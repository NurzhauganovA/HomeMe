from asgiref.sync import sync_to_async
from django.db.models import Count
from django.utils import timezone

from dashboard.models import (
    FeedbackSurvey,
    FeedbackSurveyQuestion,
    FeedbackSurveySubmission,
    FeedbackSurveyAnswer,
)
from telegram_bot.models import DailyUsageLog


class SurveyService:
    @staticmethod
    async def should_start_survey(user) -> bool:
        active_survey = await sync_to_async(
            lambda: FeedbackSurvey.objects.filter(is_active=True).order_by('-updated_at').first()
        )()
        if not active_survey:
            return False

        already_completed = await sync_to_async(
            lambda: FeedbackSurveySubmission.objects.filter(
                survey=active_survey, user=user, status='completed'
            ).exists()
        )()
        if already_completed:
            return False

        if active_survey.trigger_type == 'manual':
            return False

        if active_survey.trigger_type == 'search_count':
            return user.total_searches >= active_survey.trigger_search_count > 0

        if active_survey.trigger_type == 'objects_count':
            today = timezone.now().date()
            usage = await sync_to_async(
                lambda: DailyUsageLog.objects.filter(user=user, date=today).first()
            )()
            shown = usage.objects_shown if usage else 0
            return shown >= active_survey.trigger_objects_count > 0

        return False

    @staticmethod
    async def start_survey(user):
        survey = await sync_to_async(
            lambda: FeedbackSurvey.objects.filter(is_active=True).order_by('-updated_at').first()
        )()
        if not survey:
            return None
        submission, _ = await sync_to_async(FeedbackSurveySubmission.objects.get_or_create)(
            survey=survey, user=user, status='started'
        )
        return submission

    @staticmethod
    async def get_next_question(submission):
        answered_question_ids = await sync_to_async(
            lambda: list(
                FeedbackSurveyAnswer.objects.filter(submission=submission).values_list('question_id', flat=True)
            )
        )()
        question = await sync_to_async(
            lambda: FeedbackSurveyQuestion.objects.filter(
                survey=submission.survey,
                is_active=True
            ).exclude(id__in=answered_question_ids).order_by('order', 'id').first()
        )()
        return question

    @staticmethod
    def question_prompt(question):
        base = question.text
        if question.question_type in ('single_choice', 'multi_choice') and question.options:
            options = "\n".join([f"{idx + 1}. {opt}" for idx, opt in enumerate(question.options)])
            suffix = "\n\nВыберите вариант(ы) и отправьте номер."
            if question.question_type == 'multi_choice':
                suffix = "\n\nМожно несколько вариантов, например: 1,3"
            return f"{base}\n\n{options}{suffix}"
        if question.question_type == 'rating':
            return f"{base}\n\nПоставьте оценку от 1 до 5."
        return base

    @staticmethod
    def question_buttons(question):
        if question.question_type in ('single_choice', 'multi_choice') and question.options:
            return [str(i + 1) for i in range(len(question.options))]
        if question.question_type == 'rating':
            return ['1', '2', '3', '4', '5']
        return []

    @staticmethod
    async def save_answer(submission, question, user_input: str):
        answer_text = ""
        answer_rating = None
        answer_options = []

        if question.question_type == 'rating':
            try:
                answer_rating = int(user_input.strip())
            except Exception:
                return False, "Введите число от 1 до 5."
            if answer_rating < 1 or answer_rating > 5:
                return False, "Введите число от 1 до 5."
            answer_text = str(answer_rating)
        elif question.question_type in ('single_choice', 'multi_choice'):
            try:
                raw_parts = [p.strip() for p in user_input.split(',')]
                idxs = [int(p) for p in raw_parts if p]
            except Exception:
                return False, "Нужно отправить номер варианта."
            if not idxs:
                return False, "Нужно отправить номер варианта."
            max_index = len(question.options)
            for idx in idxs:
                if idx < 1 or idx > max_index:
                    return False, f"Выберите номер от 1 до {max_index}."
            if question.question_type == 'single_choice':
                idxs = [idxs[0]]
            answer_options = [question.options[idx - 1] for idx in idxs]
            answer_text = ", ".join(answer_options)
        else:
            answer_text = (user_input or "").strip()
            if question.is_required and not answer_text:
                return False, "Ответ не может быть пустым."

        await sync_to_async(FeedbackSurveyAnswer.objects.update_or_create)(
            submission=submission,
            question=question,
            defaults={
                'answer_text': answer_text,
                'answer_rating': answer_rating,
                'answer_options': answer_options,
            }
        )
        return True, ""

    @staticmethod
    async def complete_survey(submission):
        submission.status = 'completed'
        submission.completed_at = timezone.now()
        await sync_to_async(submission.save)(update_fields=['status', 'completed_at'])

        survey = submission.survey
        if survey.bonus_extra_limit > 0 and not submission.bonus_applied:
            today = timezone.now().date()
            daily_log, _ = await sync_to_async(DailyUsageLog.objects.get_or_create)(
                user=submission.user, date=today
            )
            daily_log.bonus_limit_daily += survey.bonus_extra_limit
            await sync_to_async(daily_log.save)(update_fields=['bonus_limit_daily', 'updated_at'])
            submission.bonus_applied = True
            await sync_to_async(submission.save)(update_fields=['bonus_applied'])

    @staticmethod
    def analytics_snapshot(survey_id: int | None = None):
        surveys_qs = FeedbackSurvey.objects.all()
        if survey_id:
            surveys_qs = surveys_qs.filter(id=survey_id)
        survey = surveys_qs.order_by('-updated_at').first()
        if not survey:
            return None

        submissions_qs = FeedbackSurveySubmission.objects.filter(survey=survey)
        completed_count = submissions_qs.filter(status='completed').count()
        started_count = submissions_qs.count()

        distribution = list(
            FeedbackSurveyAnswer.objects.filter(question__survey=survey)
            .values('question__id', 'question__text', 'answer_text')
            .annotate(count=Count('id'))
            .order_by('question__id', '-count')
        )
        return {
            'survey': survey,
            'started_count': started_count,
            'completed_count': completed_count,
            'distribution': distribution,
        }
