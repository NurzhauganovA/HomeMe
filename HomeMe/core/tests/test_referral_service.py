from unittest.mock import patch

from django.test import SimpleTestCase, TestCase

from core.services import referral_service
from dashboard.models import ReferralLink, Role
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
        self.referral_role = Role.objects.create(name=referral_service.REFERRAL_ROLE_NAME, is_active=True)
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
        result = referral_service.process_referral_start(self.invitee, "ref_ref11111")
        self.assertTrue(result.consumed)
        self.assertEqual(result.source, "user")
        self.invitee.refresh_from_db()
        self.assertEqual(self.invitee.invited_by_id, self.referrer.pk)
        self.assertEqual(self.invitee.role_id, self.referral_role.pk)

    def test_attach_only_once(self):
        referral_service.process_referral_start(self.invitee, "ref_REF11111")
        other = BotUser.objects.create(platform="telegram", user_id="333", referral_code="OTHERCODE")
        result = referral_service.process_referral_start(self.invitee, "ref_OTHERCODE")
        self.assertFalse(result.consumed)
        self.invitee.refresh_from_db()
        self.assertEqual(self.invitee.invited_by_id, self.referrer.pk)

    def test_no_self_referral(self):
        result = referral_service.process_referral_start(self.referrer, "ref_REF11111")
        self.assertFalse(result.consumed)

    def test_invitee_without_telegram_username_still_works(self):
        self.assertIsNone(self.invitee.username)
        result = referral_service.process_referral_start(self.invitee, "ref_REF11111")
        self.assertTrue(result.consumed)


class CampaignReferralTests(TestCase):
    def setUp(self):
        self.vip_role = Role.objects.create(name="VIP", is_active=True)
        self.campaign = ReferralLink.objects.create(
            name="Instagram",
            code="CAMPINSTA",
            role=self.vip_role,
        )
        self.invitee = BotUser.objects.create(platform="telegram", user_id="444", name="CampaignUser")

    def test_campaign_link_assigns_role(self):
        result = referral_service.process_referral_start(self.invitee, "ref_CAMPINSTA")
        self.assertTrue(result.consumed)
        self.assertEqual(result.source, "campaign")
        self.assertTrue(result.role_assigned)
        self.invitee.refresh_from_db()
        self.assertEqual(self.invitee.role_id, self.vip_role.pk)
        self.assertEqual(self.invitee.referral_link_id, self.campaign.pk)

    def test_inactive_campaign_ignored(self):
        self.campaign.is_active = False
        self.campaign.save()
        result = referral_service.process_referral_start(self.invitee, "ref_CAMPINSTA")
        self.assertFalse(result.consumed)


class DefaultRoleTests(TestCase):
    def test_ensure_default_role(self):
        Role.objects.create(name=referral_service.DEFAULT_ROLE_NAME, is_active=True)
        user = BotUser.objects.create(platform="telegram", user_id="555")
        self.assertTrue(referral_service.ensure_default_role(user))
        user.refresh_from_db()
        self.assertEqual(user.role.name, referral_service.DEFAULT_ROLE_NAME)

    def test_ensure_default_role_skips_if_has_role(self):
        role = Role.objects.create(name="Агент", is_active=True)
        Role.objects.create(name=referral_service.DEFAULT_ROLE_NAME, is_active=True)
        user = BotUser.objects.create(platform="telegram", user_id="556", role=role)
        self.assertFalse(referral_service.ensure_default_role(user))
        user.refresh_from_db()
        self.assertEqual(user.role.name, "Агент")
