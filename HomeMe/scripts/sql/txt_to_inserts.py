#!/usr/bin/env python3
"""Конвертация pgAdmin export (secondaryproperty.txt) → INSERT SQL."""
import csv
import json
import re
import sys
from io import StringIO
from pathlib import Path


COLUMNS = [
    "id", "title", "description", "address", "price", "rooms", "area", "floor", "total_floors",
    "city", "district", "latitude", "longitude", "owner_phone", "owner_name",
    "has_parking", "has_balcony", "has_renovation", "image",
    "is_active", "is_verified", "created_at", "updated_at", "views_count", "embedding",
    "external_uuid", "external_id", "property_type", "deal_type", "condition", "repair",
    "construction_year", "material", "address_note", "source_url", "photos", "raw_data",
    "subtype", "rent_type", "currency", "ceiling_height", "rooms_total", "area_living",
    "area_kitchen", "prices", "prices_m2", "city_micro_district", "coordinates_source",
]

# pgAdmin export с колонкой public_description в конце (49 полей)
COLUMNS_WITH_PUBLIC = COLUMNS + ["public_description"]

INSERT_COLS = COLUMNS + ["public_description"]


def parse_rows(path: Path) -> list[list[str]]:
    text = path.read_text(encoding="utf-8")
    reader = csv.reader(StringIO(text), delimiter="\t", quotechar='"', doublequote=True)
    rows = []
    for row in reader:
        if not row or not row[0].strip():
            continue
        n = len(row)
        if n == len(COLUMNS):
            row = row + [""]  # public_description заполним из raw_data
        elif n != len(COLUMNS_WITH_PUBLIC):
            raise ValueError(
                f"Ожидалось {len(COLUMNS)} или {len(COLUMNS_WITH_PUBLIC)} колонок, "
                f"получено {n}: id={row[0][:36]}"
            )
        rows.append(row)
    return rows


def sql_literal(val: str, col: str) -> str:
    if val is None or val == "":
        if col in ("embedding", "image", "external_uuid", "external_id", "city", "district",
                   "latitude", "longitude", "property_type", "deal_type", "condition", "repair",
                   "construction_year", "address_note", "subtype", "rent_type", "currency",
                   "ceiling_height", "rooms_total", "area_living", "area_kitchen",
                   "city_micro_district", "coordinates_source", "rent_type"):
            return "NULL"
        if col in ("material", "photos", "raw_data", "prices", "prices_m2"):
            return "'{}'::jsonb" if col in ("prices", "prices_m2") else "'[]'::jsonb"
        if col in ("has_parking", "has_balcony", "has_renovation", "is_active", "is_verified"):
            return "false"
        if col == "source_url":
            return "''"
        if col == "views_count":
            return "0"
        return "NULL"
    if col in ("has_parking", "has_balcony", "has_renovation", "is_active", "is_verified"):
        return "true" if val.lower() == "true" else "false"
    if col in ("price", "rooms", "area", "floor", "total_floors", "latitude", "longitude",
               "views_count", "external_id", "construction_year", "rooms_total",
               "area_living", "area_kitchen", "ceiling_height"):
        return val
    if col in ("material", "photos", "raw_data", "prices", "prices_m2"):
        # pg export: doubled quotes inside JSON
        inner = val.replace('""', '"')
        try:
            json.loads(inner)
        except json.JSONDecodeError:
            inner = val
        escaped = inner.replace("'", "''")
        return f"'{escaped}'::jsonb"
    if col == "id":
        return f"'{val}'::uuid"
    if col == "embedding":
        return "NULL"
    escaped = val.replace("'", "''")
    return f"'{escaped}'"


def public_desc_from_raw(raw_val: str) -> str:
    if not raw_val:
        return ""
    inner = raw_val.replace('""', '"')
    try:
        data = json.loads(inner)
        return (data.get("public_description") or data.get("description") or "") or ""
    except json.JSONDecodeError:
        return ""


def main():
    src = Path(sys.argv[1] if len(sys.argv) > 1 else "secondaryproperty.txt")
    out = Path(sys.argv[2] if len(sys.argv) > 2 else "scripts/sql/secondaryproperty_inserts.sql")
    rows = parse_rows(src)

    lines = [
        "-- Вставка в telegram_bot_secondaryproperty",
        "-- Сгенерировано из pgAdmin export. Вставьте в Query Tool pgAdmin.",
        "",
        "ALTER TABLE public.telegram_bot_secondaryproperty",
        "    ADD COLUMN IF NOT EXISTS public_description text NOT NULL DEFAULT '';",
        "",
        "-- TRUNCATE TABLE public.telegram_bot_secondaryproperty;  -- раскомментируйте при повторе",
        "",
    ]

    col_list = ", ".join(INSERT_COLS)
    for row in rows:
        base = row[: len(COLUMNS)]
        vals = [sql_literal(v, c) for v, c in zip(base, COLUMNS)]
        pd = row[len(COLUMNS)] if len(row) > len(COLUMNS) else ""
        if not pd.strip():
            pd = public_desc_from_raw(base[COLUMNS.index("raw_data")])
        vals.append(sql_literal(pd, "public_description") if pd else "''")
        lines.append(
            f"INSERT INTO public.telegram_bot_secondaryproperty ({col_list}) VALUES\n"
            f"({', '.join(vals)})\n"
            f"ON CONFLICT (external_uuid) DO NOTHING;"
        )
        lines.append("")

    lines.append(f"-- Записей: {len(rows)}")
    lines.append("SELECT COUNT(*) FROM telegram_bot_secondaryproperty;")

    out.write_text("\n".join(lines), encoding="utf-8")
    print(f"OK: {len(rows)} rows -> {out}")


if __name__ == "__main__":
    main()
