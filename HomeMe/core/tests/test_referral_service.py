from unittest.mock import patch

from django.test import SimpleTestCase, TestCase

from core.services import referral_service
from telegram_bot.models import BotUser


class ReferralParsingTests(SimpleTestCase):
    def test_parse_start_with_ref(self):
        self.assertEqual(parse := referral_service.parse_start_argument("/start ref_ABCD1234"), "ref_ABCD1234")

    def test_parse_start_without_arg(self):
        self.assertIsNone(referral_service.parse_start_argument("/start"))

    def test_build_link_without_username_returns_none(self):
        with patch.object(referral_service, "resolve_telegram_bot_username", return_value=None):
            self.assertIsNone(referral_service.build_telegram_referral_link("ABCD1234"))

    def test_build_link_with_username(self):
        with patch.object(referral_service, "resolve_telegram_bot_username", return_value="HomeMeBot"):
            self.assertEqual(
                referral_service.build_telegram_referral_link("ABCD1234"),
                "https://t.me/HomeMeBot?start=ref_ABCD1234",
            )

    def test_build_share_text_fallback(self):
        with patch.object(referral_service, "build_telegram_referral_link", return_value=None):
            self.assertEqual(referral_service.build_referral_share_text("ABCD1234"), "/start ref_ABCD1234")


class ReferralAttachTests(TestCase):
    def setUp(self):
        self.referrer = BotUser.objects.create(
            platform="telegram",
            user_id="111",
            name="Referrer",
            referral_code="REF11111",
        )
        self.invitee = BotUser.objects.create(
            platform="telegram",
            user_id="222",
            name="Invitee",
        )

    def test_attach_referrer_by_code(self):
        attached = referral_service.try_attach_referrer(self.invitee, "ref_ref11111")
        self.assertTrue(attached)
        self.invitee.refresh_from_db()
        self.assertEqual(self.invitee.invited_by_id, self.referrer.pk)

    def test_attach_only_once(self):
        referral_service.try_attach_referrer(self.invitee, "ref_REF11111")
        other = BotUser.objects.create(platform="telegram", user_id="333", referral_code="OTHERCODE")
        attached_again = referral_service.try_attach_referrer(self.invitee, "ref_OTHERCODE")
        self.assertFalse(attached_again)
        self.invitee.refresh_from_db()
        self.assertEqual(self.invitee.invited_by_id, self.referrer.pk)

    def test_no_self_referral(self):
        attached = referral_service.try_attach_referrer(self.referrer, "ref_REF11111")
        self.assertFalse(attached)

    def test_invitee_without_telegram_username_still_works(self):
        self.assertIsNone(self.invitee.username)
        attached = referral_service.try_attach_referrer(self.invitee, "ref_REF11111")
        self.assertTrue(attached)
