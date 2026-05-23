from django.test import TestCase, override_settings

from core.services.ilvo_description import (
    descriptions_from_payload,
    display_description,
    public_description_for_ilvo_export,
)


class IlvoDescriptionTest(TestCase):
    def test_import_splits_fields(self):
        internal, public = descriptions_from_payload({
            "description": "внутреннее",
            "public_description": "реклама",
        })
        self.assertEqual(internal, "внутреннее")
        self.assertEqual(public, "реклама")

    def test_import_public_optional(self):
        internal, public = descriptions_from_payload({"description": "только внутреннее"})
        self.assertEqual(internal, "только внутреннее")
        self.assertEqual(public, "")

    def test_export_public_empty_by_default(self):
        self.assertEqual(
            public_description_for_ilvo_export("внутр", ""),
            "",
        )

    @override_settings(ILVO_EXPORT_PUBLIC_DESCRIPTION_FALLBACK=True)
    def test_export_fallback_when_enabled(self):
        self.assertEqual(
            public_description_for_ilvo_export("внутр", ""),
            "внутр",
        )

    def test_display_prefers_public(self):
        self.assertEqual(display_description("внутр", "реклама"), "реклама")

    def test_display_falls_back_to_internal(self):
        self.assertEqual(display_description("внутр", ""), "внутр")
