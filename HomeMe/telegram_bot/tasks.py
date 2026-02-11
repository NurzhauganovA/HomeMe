from celery import shared_task
from django.core.management import call_command


@shared_task
def sync_bi_group_all() -> None:
    call_command('sync_bi_residential')
    call_command('sync_bi_commercial')
