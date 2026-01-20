--
-- PostgreSQL database dump
--

\restrict IzxF8cvZZv48iyTy100veGNHmEIiB9ZeLwEh2iIdetZivfIi32Ab9o1goue4J1c

-- Dumped from database version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.11 (Ubuntu 16.11-0ubuntu0.24.04.1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

ALTER TABLE ONLY public.telegram_bot_usersession DROP CONSTRAINT telegram_bot_userses_user_id_9c4f6916_fk_telegram_;
ALTER TABLE ONLY public.telegram_bot_userfeedback DROP CONSTRAINT telegram_bot_userfee_user_id_e1b293a2_fk_telegram_;
ALTER TABLE ONLY public.telegram_bot_searchlog DROP CONSTRAINT telegram_bot_searchl_user_id_b31b8462_fk_telegram_;
ALTER TABLE ONLY public.telegram_bot_lead DROP CONSTRAINT telegram_bot_lead_user_id_13f1774c_fk_telegram_bot_botuser_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co;
ALTER TABLE ONLY public.bi_units DROP CONSTRAINT bi_units_complex_id_d7119ef4_fk_bi_complexes_id;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm;
DROP INDEX public.whatsapp_bot_whatsappuser_phone_number_aa314366_like;
DROP INDEX public.telegram_bot_userfeedback_user_id_e1b293a2;
DROP INDEX public.telegram_bot_secondaryproperty_title_01d99009_like;
DROP INDEX public.telegram_bot_secondaryproperty_title_01d99009;
DROP INDEX public.telegram_bot_secondaryproperty_rooms_740d56eb;
DROP INDEX public.telegram_bot_secondaryproperty_is_active_6de3aaa2;
DROP INDEX public.telegram_bot_secondaryproperty_district_76931b7f_like;
DROP INDEX public.telegram_bot_secondaryproperty_district_76931b7f;
DROP INDEX public.telegram_bot_secondaryproperty_created_at_66fee04f;
DROP INDEX public.telegram_bot_secondaryproperty_city_ddc6d418_like;
DROP INDEX public.telegram_bot_secondaryproperty_city_ddc6d418;
DROP INDEX public.telegram_bot_secondaryproperty_address_1c73ff18_like;
DROP INDEX public.telegram_bot_secondaryproperty_address_1c73ff18;
DROP INDEX public.telegram_bot_searchlog_user_id_b31b8462;
DROP INDEX public.telegram_bot_searchlog_created_at_bcf8dab7;
DROP INDEX public.telegram_bot_lead_user_id_13f1774c;
DROP INDEX public.telegram_bot_lead_status_234a80ae_like;
DROP INDEX public.telegram_bot_lead_status_234a80ae;
DROP INDEX public.telegram_bot_lead_created_at_e007ada5;
DROP INDEX public.telegram_bot_botuser_user_id_096041e9_like;
DROP INDEX public.telegram_bot_botuser_platform_51119c06_like;
DROP INDEX public.telegram_bot_botuser_platform_51119c06;
DROP INDEX public.telegram_bot_botuser_created_at_3b098a9e;
DROP INDEX public.telegram_bo_status_551593_idx;
DROP INDEX public.telegram_bo_priorit_da0de4_idx;
DROP INDEX public.telegram_bo_platfor_566670_idx;
DROP INDEX public.telegram_bo_last_ac_77624c_idx;
DROP INDEX public.telegram_bo_is_acti_e756bf_idx;
DROP INDEX public.telegram_bo_distric_812c3b_idx;
DROP INDEX public.telegram_bo_detecte_d6d46b_idx;
DROP INDEX public.telegram_bo_created_ca4a75_idx;
DROP INDEX public.telegram_bo_created_512a93_idx;
DROP INDEX public.telegram_bo_city_7ea1e0_idx;
DROP INDEX public.django_session_session_key_c0390e0f_like;
DROP INDEX public.django_session_expire_date_a5c62663;
DROP INDEX public.django_admin_log_user_id_c564eba6;
DROP INDEX public.django_admin_log_content_type_id_c4bce8eb;
DROP INDEX public.bi_units_room_count_9823fee7;
DROP INDEX public.bi_units_price_d_3c0521_idx;
DROP INDEX public.bi_units_complex_id_d7119ef4;
DROP INDEX public.bi_units_bi_uuid_1b16f04a_like;
DROP INDEX public.bi_units_area_f1eed0_idx;
DROP INDEX public.bi_complexes_city_uuid_fa3c647a_like;
DROP INDEX public.bi_complexes_city_uuid_fa3c647a;
DROP INDEX public.bi_complexes_bi_uuid_a2a6896c_like;
DROP INDEX public.auth_user_username_6821ab7c_like;
DROP INDEX public.auth_user_user_permissions_user_id_a95ead1b;
DROP INDEX public.auth_user_user_permissions_permission_id_1fbb5f2c;
DROP INDEX public.auth_user_groups_user_id_6a12ed8b;
DROP INDEX public.auth_user_groups_group_id_97559544;
DROP INDEX public.auth_permission_content_type_id_2f476e4b;
DROP INDEX public.auth_group_permissions_permission_id_84c5c92e;
DROP INDEX public.auth_group_permissions_group_id_b120cbf9;
DROP INDEX public.auth_group_name_a6ea08ec_like;
ALTER TABLE ONLY public.whatsapp_bot_whatsappuser DROP CONSTRAINT whatsapp_bot_whatsappuser_pkey;
ALTER TABLE ONLY public.whatsapp_bot_whatsappuser DROP CONSTRAINT whatsapp_bot_whatsappuser_phone_number_key;
ALTER TABLE ONLY public.telegram_bot_usersession DROP CONSTRAINT telegram_bot_usersession_user_id_key;
ALTER TABLE ONLY public.telegram_bot_usersession DROP CONSTRAINT telegram_bot_usersession_pkey;
ALTER TABLE ONLY public.telegram_bot_userfeedback DROP CONSTRAINT telegram_bot_userfeedback_pkey;
ALTER TABLE ONLY public.telegram_bot_secondaryproperty DROP CONSTRAINT telegram_bot_secondaryproperty_pkey;
ALTER TABLE ONLY public.telegram_bot_searchlog DROP CONSTRAINT telegram_bot_searchlog_pkey;
ALTER TABLE ONLY public.telegram_bot_lead DROP CONSTRAINT telegram_bot_lead_pkey;
ALTER TABLE ONLY public.telegram_bot_botuser DROP CONSTRAINT telegram_bot_botuser_user_id_key;
ALTER TABLE ONLY public.telegram_bot_botuser DROP CONSTRAINT telegram_bot_botuser_pkey;
ALTER TABLE ONLY public.django_session DROP CONSTRAINT django_session_pkey;
ALTER TABLE ONLY public.django_migrations DROP CONSTRAINT django_migrations_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_pkey;
ALTER TABLE ONLY public.django_content_type DROP CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq;
ALTER TABLE ONLY public.django_admin_log DROP CONSTRAINT django_admin_log_pkey;
ALTER TABLE ONLY public.bi_units DROP CONSTRAINT bi_units_pkey;
ALTER TABLE ONLY public.bi_units DROP CONSTRAINT bi_units_bi_uuid_key;
ALTER TABLE ONLY public.bi_complexes DROP CONSTRAINT bi_complexes_pkey;
ALTER TABLE ONLY public.bi_complexes DROP CONSTRAINT bi_complexes_bi_uuid_key;
ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_username_key;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq;
ALTER TABLE ONLY public.auth_user_user_permissions DROP CONSTRAINT auth_user_user_permissions_pkey;
ALTER TABLE ONLY public.auth_user DROP CONSTRAINT auth_user_pkey;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq;
ALTER TABLE ONLY public.auth_user_groups DROP CONSTRAINT auth_user_groups_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_pkey;
ALTER TABLE ONLY public.auth_permission DROP CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_pkey;
ALTER TABLE ONLY public.auth_group_permissions DROP CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq;
ALTER TABLE ONLY public.auth_group DROP CONSTRAINT auth_group_name_key;
DROP TABLE public.whatsapp_bot_whatsappuser;
DROP TABLE public.telegram_bot_usersession;
DROP TABLE public.telegram_bot_userfeedback;
DROP TABLE public.telegram_bot_secondaryproperty;
DROP TABLE public.telegram_bot_searchlog;
DROP TABLE public.telegram_bot_lead;
DROP TABLE public.telegram_bot_botuser;
DROP TABLE public.django_session;
DROP TABLE public.django_migrations;
DROP TABLE public.django_content_type;
DROP TABLE public.django_admin_log;
DROP TABLE public.bi_units;
DROP TABLE public.bi_complexes;
DROP TABLE public.auth_user_user_permissions;
DROP TABLE public.auth_user_groups;
DROP TABLE public.auth_user;
DROP TABLE public.auth_permission;
DROP TABLE public.auth_group_permissions;
DROP TABLE public.auth_group;
DROP EXTENSION vector;
--
-- Name: vector; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS vector WITH SCHEMA public;


--
-- Name: EXTENSION vector; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION vector IS 'vector data type and ivfflat and hnsw access methods';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: auth_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group (
    id integer NOT NULL,
    name character varying(150) NOT NULL
);


--
-- Name: auth_group_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_group_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_group_permissions (
    id bigint NOT NULL,
    group_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_group_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_group_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_permission; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_permission (
    id integer NOT NULL,
    name character varying(255) NOT NULL,
    content_type_id integer NOT NULL,
    codename character varying(100) NOT NULL
);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_permission ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_permission_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user (
    id integer NOT NULL,
    password character varying(128) NOT NULL,
    last_login timestamp with time zone,
    is_superuser boolean NOT NULL,
    username character varying(150) NOT NULL,
    first_name character varying(150) NOT NULL,
    last_name character varying(150) NOT NULL,
    email character varying(254) NOT NULL,
    is_staff boolean NOT NULL,
    is_active boolean NOT NULL,
    date_joined timestamp with time zone NOT NULL
);


--
-- Name: auth_user_groups; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_groups (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    group_id integer NOT NULL
);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_groups ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: auth_user_user_permissions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.auth_user_user_permissions (
    id bigint NOT NULL,
    user_id integer NOT NULL,
    permission_id integer NOT NULL
);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.auth_user_user_permissions ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.auth_user_user_permissions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: bi_complexes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bi_complexes (
    id uuid NOT NULL,
    bi_uuid character varying(100) NOT NULL,
    name character varying(255) NOT NULL,
    address character varying(500) NOT NULL,
    city_uuid character varying(100) NOT NULL,
    latitude double precision,
    longitude double precision,
    class_name character varying(100) NOT NULL,
    deadline character varying(50) NOT NULL,
    min_price numeric(15,2),
    url character varying(200) NOT NULL,
    image_url character varying(200) NOT NULL,
    features jsonb NOT NULL,
    embedding public.vector(768),
    updated_at timestamp with time zone NOT NULL,
    description text NOT NULL
);


--
-- Name: bi_units; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.bi_units (
    id uuid NOT NULL,
    bi_uuid character varying(100) NOT NULL,
    room_count integer NOT NULL,
    floor integer NOT NULL,
    max_floor integer,
    area double precision NOT NULL,
    price numeric(15,2) NOT NULL,
    price_discount numeric(15,2),
    block_name character varying(100) NOT NULL,
    deadline character varying(50) NOT NULL,
    is_active boolean NOT NULL,
    complex_id uuid NOT NULL
);


--
-- Name: django_admin_log; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_admin_log (
    id integer NOT NULL,
    action_time timestamp with time zone NOT NULL,
    object_id text,
    object_repr character varying(200) NOT NULL,
    action_flag smallint NOT NULL,
    change_message text NOT NULL,
    content_type_id integer,
    user_id integer NOT NULL,
    CONSTRAINT django_admin_log_action_flag_check CHECK ((action_flag >= 0))
);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_admin_log ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_admin_log_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_content_type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_content_type (
    id integer NOT NULL,
    app_label character varying(100) NOT NULL,
    model character varying(100) NOT NULL
);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_content_type ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_content_type_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_migrations (
    id bigint NOT NULL,
    app character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    applied timestamp with time zone NOT NULL
);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.django_migrations ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.django_migrations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: django_session; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.django_session (
    session_key character varying(40) NOT NULL,
    session_data text NOT NULL,
    expire_date timestamp with time zone NOT NULL
);


--
-- Name: telegram_bot_botuser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_botuser (
    id uuid NOT NULL,
    platform character varying(20) NOT NULL,
    user_id character varying(50) NOT NULL,
    name character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    last_active_at timestamp with time zone NOT NULL,
    total_searches integer NOT NULL,
    total_messages integer NOT NULL,
    is_active boolean NOT NULL,
    language character varying(5) NOT NULL
);


--
-- Name: telegram_bot_lead; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_lead (
    id bigint NOT NULL,
    request_text text NOT NULL,
    search_params jsonb NOT NULL,
    status character varying(20) NOT NULL,
    assigned_to character varying(100),
    manager_notes text NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    contacted_at timestamp with time zone,
    closed_at timestamp with time zone,
    priority integer NOT NULL,
    user_id uuid NOT NULL
);


--
-- Name: telegram_bot_lead_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.telegram_bot_lead ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.telegram_bot_lead_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: telegram_bot_searchlog; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_searchlog (
    id uuid NOT NULL,
    query_text text NOT NULL,
    detected_intent character varying(50) NOT NULL,
    detected_city character varying(50),
    detected_district character varying(100),
    lifestyle_tags jsonb NOT NULL,
    ai_confidence double precision NOT NULL,
    results_count integer NOT NULL,
    bi_group_count integer NOT NULL,
    secondary_count integer NOT NULL,
    search_duration_ms integer NOT NULL,
    created_at timestamp with time zone NOT NULL,
    user_id uuid
);


--
-- Name: telegram_bot_secondaryproperty; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_secondaryproperty (
    id uuid NOT NULL,
    title character varying(200) NOT NULL,
    description text NOT NULL,
    address character varying(255) NOT NULL,
    price numeric(12,0) NOT NULL,
    rooms integer NOT NULL,
    area double precision NOT NULL,
    floor integer NOT NULL,
    total_floors integer NOT NULL,
    city character varying(50),
    district character varying(100),
    latitude double precision,
    longitude double precision,
    owner_phone character varying(20) NOT NULL,
    owner_name character varying(100) NOT NULL,
    has_parking boolean NOT NULL,
    has_balcony boolean NOT NULL,
    has_renovation boolean NOT NULL,
    image character varying(100),
    is_active boolean NOT NULL,
    is_verified boolean NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    views_count integer NOT NULL,
    embedding public.vector(768)
);


--
-- Name: telegram_bot_userfeedback; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_userfeedback (
    id bigint NOT NULL,
    feedback_type character varying(20) NOT NULL,
    rating integer,
    comment text NOT NULL,
    property_id character varying(100),
    created_at timestamp with time zone NOT NULL,
    user_id uuid NOT NULL
);


--
-- Name: telegram_bot_userfeedback_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.telegram_bot_userfeedback ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.telegram_bot_userfeedback_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: telegram_bot_usersession; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.telegram_bot_usersession (
    id bigint NOT NULL,
    current_intent character varying(50) NOT NULL,
    search_params jsonb NOT NULL,
    conversation_history jsonb NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    expires_at timestamp with time zone,
    user_id uuid NOT NULL,
    state character varying(50) NOT NULL
);


--
-- Name: telegram_bot_usersession_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.telegram_bot_usersession ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.telegram_bot_usersession_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Name: whatsapp_bot_whatsappuser; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.whatsapp_bot_whatsappuser (
    id bigint NOT NULL,
    phone_number character varying(20) NOT NULL,
    name character varying(100),
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL
);


--
-- Name: whatsapp_bot_whatsappuser_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

ALTER TABLE public.whatsapp_bot_whatsappuser ALTER COLUMN id ADD GENERATED BY DEFAULT AS IDENTITY (
    SEQUENCE NAME public.whatsapp_bot_whatsappuser_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- Data for Name: auth_group; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group (id, name) FROM stdin;
\.


--
-- Data for Name: auth_group_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_group_permissions (id, group_id, permission_id) FROM stdin;
\.


--
-- Data for Name: auth_permission; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_permission (id, name, content_type_id, codename) FROM stdin;
1	Can add log entry	1	add_logentry
2	Can change log entry	1	change_logentry
3	Can delete log entry	1	delete_logentry
4	Can view log entry	1	view_logentry
5	Can add permission	2	add_permission
6	Can change permission	2	change_permission
7	Can delete permission	2	delete_permission
8	Can view permission	2	view_permission
9	Can add group	3	add_group
10	Can change group	3	change_group
11	Can delete group	3	delete_group
12	Can view group	3	view_group
13	Can add user	4	add_user
14	Can change user	4	change_user
15	Can delete user	4	delete_user
16	Can view user	4	view_user
17	Can add content type	5	add_contenttype
18	Can change content type	5	change_contenttype
19	Can delete content type	5	delete_contenttype
20	Can view content type	5	view_contenttype
21	Can add session	6	add_session
22	Can change session	6	change_session
23	Can delete session	6	delete_session
24	Can view session	6	view_session
25	Can add Пользователь WhatsApp	7	add_whatsappuser
26	Can change Пользователь WhatsApp	7	change_whatsappuser
27	Can delete Пользователь WhatsApp	7	delete_whatsappuser
28	Can view Пользователь WhatsApp	7	view_whatsappuser
29	Can add Пользователь бота	8	add_botuser
30	Can change Пользователь бота	8	change_botuser
31	Can delete Пользователь бота	8	delete_botuser
32	Can view Пользователь бота	8	view_botuser
33	Can add Вторичная недвижимость	9	add_secondaryproperty
34	Can change Вторичная недвижимость	9	change_secondaryproperty
35	Can delete Вторичная недвижимость	9	delete_secondaryproperty
36	Can view Вторичная недвижимость	9	view_secondaryproperty
37	Can add Отзыв	10	add_userfeedback
38	Can change Отзыв	10	change_userfeedback
39	Can delete Отзыв	10	delete_userfeedback
40	Can view Отзыв	10	view_userfeedback
41	Can add Сессия пользователя	11	add_usersession
42	Can change Сессия пользователя	11	change_usersession
43	Can delete Сессия пользователя	11	delete_usersession
44	Can view Сессия пользователя	11	view_usersession
45	Can add Лид	12	add_lead
46	Can change Лид	12	change_lead
47	Can delete Лид	12	delete_lead
48	Can view Лид	12	view_lead
49	Can add Лог поиска	13	add_searchlog
50	Can change Лог поиска	13	change_searchlog
51	Can delete Лог поиска	13	delete_searchlog
52	Can view Лог поиска	13	view_searchlog
53	Can add ЖК	14	add_bicomplex
54	Can change ЖК	14	change_bicomplex
55	Can delete ЖК	14	delete_bicomplex
56	Can view ЖК	14	view_bicomplex
57	Can add Квартира в ЖК	15	add_biunit
58	Can change Квартира в ЖК	15	change_biunit
59	Can delete Квартира в ЖК	15	delete_biunit
60	Can view Квартира в ЖК	15	view_biunit
\.


--
-- Data for Name: auth_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user (id, password, last_login, is_superuser, username, first_name, last_name, email, is_staff, is_active, date_joined) FROM stdin;
1	pbkdf2_sha256$1000000$rHmNaWyySkQ1lHlxdVThS8$rQHN8yKoBtVR5yQLj09U1CkN0YaCWuzyXzedY6yK9ac=	2026-01-20 12:40:48.049762+05	t	admin			admin@gmail.com	t	t	2026-01-20 12:40:43.714381+05
\.


--
-- Data for Name: auth_user_groups; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_groups (id, user_id, group_id) FROM stdin;
\.


--
-- Data for Name: auth_user_user_permissions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.auth_user_user_permissions (id, user_id, permission_id) FROM stdin;
\.


--
-- Data for Name: bi_complexes; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bi_complexes (id, bi_uuid, name, address, city_uuid, latitude, longitude, class_name, deadline, min_price, url, image_url, features, embedding, updated_at, description) FROM stdin;
c8a207af-dffd-4e8f-b235-8ddbe42f6cc5	8139bae9-2852-4a3e-9279-4f25a04cc651	Darmen	г. Астана, пересечение ул. Кенесары и ул. Асан Кайгы	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.167	71.44568	Комфорт+		\N	https://bi.group/ru/landing/darmen	https://s3.bi.group/biclick/8139bae9-2852-4a3e-9279-4f25a04cc651/8139bae9-2852-4a3e-9279-4f25a04cc651_foto_400.jpg	{"side": "Right", "tags": ["школа рядом", "детский сад рядом", "супермаркет рядом", "магазины рядом", "аптека рядом", "банк рядом", "ТЦ рядом", "рынок рядом", "кафе рядом", "рестораны рядом", "салон красоты рядом", "фитнес-центр рядом", "остановки общественного транспорта", "парк рядом", "сквер рядом", "поликлиника рядом", "гос. учреждения рядом", "бизнес-центры рядом", "старый центр", "правый берег", "доступные цены на продукты", "удобный выезд на основные магистрали", "исторический район", "почта рядом", "кинотеатр рядом", "медицинские центры"], "atmosphere": ["деловой", "семейный", "шумный", "развитая инфраструктура", "удобная транспортная развязка", "много магазинов", "кафе", "рестораны", "близость к центру", "пробки", "старый центр", "городской", "оживленный"], "district_name": "Алматинский"}	[-0.005732856,-0.0019429259,-0.011781224,-0.006270242,-0.0070447726,-0.0007980212,0.03579703,-0.010793289,0.016916705,0.070727736,0.025354419,0.060146876,0.018041287,-0.005484296,0.031117065,0.012200516,0.03055943,0.006150165,-0.13665853,-0.019325292,0.037442878,-0.030930437,0.07191115,-0.038991462,-0.035794668,-0.061114423,-0.04416227,0.035537276,-0.0143717965,0.0062264483,0.030408744,0.056044966,0.020681456,-0.033773117,0.0151165025,0.016058274,-0.011321181,-0.037391458,0.035170168,-0.049034823,-0.064233445,0.0341028,0.025440473,0.02222075,-0.09107671,-0.05451411,-0.027457757,0.008524464,-0.032645945,-0.005292696,-0.0043005417,-0.045712277,-0.03444115,0.06184031,-0.081535414,-0.0092301015,-0.004890032,-0.045705903,0.059221044,0.02306489,0.0015662432,-0.0013989774,-0.0052637123,-0.02324548,0.00048686672,-0.009582156,-0.039456833,0.00430209,-0.04792329,0.02229442,-0.02385098,0.0677154,-0.021197585,0.047943298,0.003493984,0.005850053,0.014574763,0.0038229167,0.04586204,0.02856048,-0.0078018666,-0.016119258,-0.007177877,0.04118363,0.037997022,-0.0012766041,0.016445791,-0.022750918,-0.08262795,-0.03767827,0.05083121,0.015763298,0.019569905,0.017484508,0.06430972,0.030010613,-0.11961378,-0.10091131,0.08301904,0.040934503,0.0041539837,0.0147978375,-0.04123199,-0.0893245,0.03759545,0.065128334,-0.0460321,-0.04790054,-0.06127957,0.0059085405,-0.006928747,0.019558089,0.032421354,-0.00053261034,0.039952442,0.03236212,-0.055980414,0.04975345,-0.019029392,0.037888307,0.034327704,-0.009674796,-0.016657336,0.052958462,0.017742278,0.0050633852,0.015170652,-0.045259655,-0.03182231,-0.013097088,0.06670122,-0.03290395,-0.009257828,0.0026596691,-0.012645967,-0.0042715236,0.035550043,-0.0341109,-0.0060784942,-0.0036590705,0.010049077,-0.05305828,-0.072610535,-0.024173966,-0.014128535,0.012995547,-0.00744729,0.06113663,-0.049002964,-0.0046222196,-0.033045974,-0.03166291,0.028203018,0.020575656,0.008768574,0.010499589,0.077157006,-0.055885136,0.022418927,-0.034368876,0.05663498,-0.048206683,-0.027711818,-0.013335676,0.016392563,0.002520004,0.024141598,-0.020295575,-0.018554254,-0.022811383,-0.020803552,-0.07660925,-0.035929248,-0.08565389,0.012014022,-0.030698366,-0.025424482,0.01342511,-0.02526318,0.030651838,0.106444046,0.0010261504,-0.017364243,-0.07564779,-0.0108505245,-0.0019579781,-0.02778874,0.0555239,0.06453173,0.010292473,0.00052484765,0.015823076,0.0020614907,0.044953424,-0.0533135,-0.006311547,0.03896626,-0.054632943,0.0057221022,-0.029901203,0.051468927,-0.032883305,-0.01586948,-0.02151379,-0.015762093,0.04455822,-0.022461632,-0.060363952,-0.033887655,0.026763193,-0.033066675,-0.011640865,-0.010095205,-0.07641028,0.024531508,-0.00809414,-0.0067768497,-0.03865566,0.05689686,-0.06828233,-0.0055113905,0.00021801247,0.039764583,0.015598937,0.05868445,-0.009878292,-0.017137468,-0.006870479,-0.014016866,-0.07231267,-0.033349566,-0.030690843,-0.008772631,0.043972343,-0.032801796,0.0039909324,-0.0028244662,-0.05111488,-0.041385364,-0.027648006,-0.026770981,0.039101392,0.037997458,-0.02012918,0.008043841,-0.009588173,0.06457931,0.016675152,0.013650266,-0.007270186,-0.04034393,-0.007925709,-0.012320206,-0.03063813,-0.022134142,-0.05419743,0.019093154,0.009745176,-0.004827154,-0.016462198,-0.01334106,-0.030137101,0.013890105,-0.043664154,-0.04709988,-0.0183415,0.0029286551,-0.01686184,0.074759975,-0.04225664,0.045710593,-0.039210673,-0.045385826,-0.0028000611,-0.041215353,0.083649315,-0.0063926117,0.009119737,-0.0021481463,-0.02802586,0.06835637,-0.00045552067,-0.039763317,0.0132387355,0.018087603,-0.04377589,-0.036248215,0.049928885,-0.056779947,-0.02606464,0.038228255,0.05789661,0.030218605,-0.0001300854,0.013860794,-0.012852567,0.020646954,0.05950267,-0.021505294,-0.0394367,0.023053754,0.034078535,-0.036167134,0.034424093,-0.011585662,-0.056997336,-0.0049222345,0.0012745581,-0.025363443,-0.021306893,0.028947365,0.046888135,-0.05597636,-0.050310966,-0.05695855,-0.02197647,-0.11692552,-0.055502992,0.00034645613,0.00965872,0.00303046,0.09092546,-0.03249642,0.0024520585,0.047213644,-0.02437451,-0.018722111,-0.013764158,0.0603005,-0.037930578,0.002683138,0.003021704,-0.027643217,-0.056999825,-0.01983444,0.035906307,-0.06829473,0.015945446,0.038036104,0.032518677,0.07491273,0.040510003,0.016350597,0.034951545,-0.01786883,-0.017110674,0.02528498,0.016888404,0.016499976,0.0050861435,0.009277162,0.036308747,-0.042865388,-0.06148326,-0.0014521148,-0.030508682,0.021691049,-0.011914272,0.0017281467,-0.078761764,-0.029254926,-0.00018525153,0.0059210607,0.023388145,0.017520756,0.0012896312,0.007440727,0.041456394,-0.06482697,-0.013833959,0.013258745,0.039671265,0.005621791,0.0030834188,0.020488115,0.0012123738,-0.0714305,0.042481214,0.043342203,0.00301611,0.013540915,0.014122223,-0.026258366,-0.0016774597,-0.005588706,0.060660787,-0.03845737,-0.004800176,-0.022266483,-0.0008595305,-0.020124452,-0.011820584,0.02692312,0.0513626,0.019052079,0.021443656,0.053663097,0.067230456,0.036596738,-0.0048413756,0.034841187,-0.046136867,0.05945602,-0.048238665,-0.0077936077,-0.012687311,0.07084875,-0.0051023113,-0.035853058,0.013468986,-0.023017729,-0.05766556,-0.055063535,0.0049795136,-0.041549835,-0.029693486,-0.025120962,-0.027248107,-0.029670594,-0.06251285,-0.03239625,0.018723864,0.015428185,-0.017309582,0.0035411324,-0.083427705,0.006910449,0.009110902,-0.0030826929,0.027541218,0.07488815,0.04528111,0.009943095,0.029618477,0.0116171315,0.0740919,-0.04428072,-0.062310837,-0.026848141,0.019500125,-0.02397077,-0.0042214766,0.027421923,0.011358594,0.01303774,0.038030468,0.043539245,0.0013156588,-0.03165995,-0.049341943,-0.009609739,-0.013809904,-0.011230739,-0.0005073412,-0.06681462,-0.0014663738,0.025628433,0.011420532,-0.066425584,0.009265554,-0.06937553,-0.026927216,0.071212046,0.033842064,-0.01512457,-0.02762186,-0.01121646,0.04934797,0.0049189115,0.011977556,0.043112356,0.01640084,0.03337048,0.0009048972,-0.011232951,-0.003957547,0.024902552,-0.018323576,-0.063195154,-0.02389761,-0.014536272,0.022521771,-0.066915505,-0.0023259383,0.050819326,-0.07264415,-0.010310822,0.026909623,-0.04358022,-0.04635204,0.012016537,0.0017531614,-0.016355416,-0.014672939,0.018698735,-0.008973242,0.02280603,0.04836134,-0.0036803319,0.010790335,0.035340026,0.026055016,0.04962326,-0.039315578,0.006766562,0.049051218,-0.086563826,-0.03529229,0.036777075,0.032264993,0.026083311,-0.0064393515,-0.025982102,0.05979847,-0.0009092742,0.008140624,-0.014827281,0.006525276,0.009719973,-0.015610751,-0.0308709,-0.0051939865,0.042435873,-0.026998352,0.010762971,-0.022362389,-0.018056843,-0.024191039,0.015037337,0.014855847,-0.029986342,0.01639848,0.04066179,0.055771064,0.024921203,0.07274309,0.03067757,0.05755464,0.032349676,0.036806062,0.022431972,-0.013104612,-0.054553654,0.01372903,0.02916467,-0.04643828,-0.0156151755,0.0724166,-0.025815725,0.071827404,0.03314076,-0.051951874,-0.05204293,-0.006059632,-0.006448548,-0.012477009,0.026412627,0.003902566,-0.06686142,0.035372045,0.017176006,-0.02000309,0.031733736,-0.024588522,-0.0058084684,-0.0038884624,0.019117324,0.06936786,-0.0067939335,-0.008712671,0.03197079,0.013482695,0.024017394,-0.053894058,0.037441086,-0.029979534,-0.053368516,-0.027971067,0.009329228,-0.054906312,-0.05698784,0.013567984,0.02980976,-0.032753337,-0.0014632224,-0.004873019,0.04748854,-0.007697988,-0.01991506,0.027768062,-0.017792476,0.027606191,-0.014370898,-0.05627123,0.0017101315,0.008345797,-0.009051786,0.025448425,0.04185789,0.006137673,0.037134945,0.016964966,0.042665288,-0.019294243,-0.01793366,-0.061322633,0.039458282,-0.012583497,-0.023282511,-0.021934748,-0.0134469075,-0.013157255,0.038595192,-0.029636458,-0.023174375,0.010797303,-0.0034381573,-0.04909934,0.0080438135,0.0069542513,0.008555218,0.023874255,-0.013817352,0.022489674,-0.042463318,-0.0072932527,-0.0023324327,0.012596497,0.0068280185,0.013149492,0.027579062,-0.049777925,0.01185932,-0.02103461,-0.02444422,0.015049767,0.005057963,-0.049769353,0.040429585,-0.026088309,0.02609421,0.00882465,0.059998337,-0.010995795,-0.031699486,0.02666662,0.044792432,-0.043196373,0.014592135,0.07985102,0.018127589,0.021803629,-0.06398803,0.069703445,-0.02309796,0.04617861,-0.00574169,-0.026150336,0.058365304,0.03425104,-0.006743205,0.0010058618,-0.021992004,0.014238164,-0.07677837,0.068503715,-0.01172166,-0.006421939,0.02049002,-0.013326356,-0.005571848,0.026288275,-0.045971896,0.013438203,-0.016612783,-0.05042825,0.023800984,-0.015715519,-0.031212792,-0.0015749093,-0.021422777,-0.020082146,-0.0008515954,-0.08040377,-0.024986679,0.013473046,0.048039727,0.044492062,-0.026367411,-0.025185786,0.03716183,-0.027977528,-0.0010967883,0.02110162,-0.02959037,0.032791354,-0.00896774,-0.010073726,-0.07360445,-0.0060936664,-0.024341108,0.022880653,-0.06374942,-0.059981134,0.001516777,-0.0028718237,0.04193726,0.04209593,-0.017871767,-0.004553691,-0.009271225,0.02876123,0.026281735,0.029895853,-0.016398825,0.035310954,0.0073210043,-0.01375482,-0.007124185,0.01049489,0.026693847,-0.0024896925,0.01650569,0.04072029,0.034340583,-0.004815323,-0.067717634,-0.007840463,-0.018397527,0.057395786,0.028650539,-0.00066772016,-0.014985317,0.021690546,0.012281192,-0.028241042,-0.02952864,0.010537893,-0.036131952,0.010177408,0.044447564,-0.009353334,-0.025082609,-0.042324588,-0.014928766,-0.0011199352,0.00050871423,0.0038501038,-0.0473532,-0.052256696,-0.058025274,0.0027352015,-0.012097473,-0.022744223,0.11396253,0.02421117,0.0019985724,-0.033039108,0.005210348,0.00022010124,-0.01219775,0.049642637,0.010694442,0.043383125,-0.0032978137,-0.020903667,0.061469316,-0.0395766]	2026-01-20 16:04:22.820697+05	ЖК Darmen. Адрес: г. Астана, пересечение ул. Кенесары и ул. Асан Кайгы
fec52f0e-66db-42a7-8757-b8723db9aa12	37a17998-d8a5-11ef-a834-001dd8b726aa	Arena Vista	г. Астана, вблизи пересечения пр. Туран и ул. T-6	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10895	71.3917	Комфорт+		\N	https://bi.group/ru/landing/arena-vista	https://s3.bi.group/biclick/37a17998-d8a5-11ef-a834-001dd8b726aa/37a17998-d8a5-11ef-a834-001dd8b726aa_foto_400.jpg	{"side": "Left", "tags": ["Барыс Арена", "Астана Арена", "Ледовый дворец Алау", "Велотрек Сарыарка", "Легкоатлетический комплекс Qazaqstan", "пр. Туран", "Левый берег", "спортивный кластер", "школа рядом", "детский сад", "супермаркет", "аптека", "остановка рядом", "современный ЖК", "новостройка", "паркинг", "охраняемая территория", "детская площадка", "фитнес-центр", "рестораны", "кафе", "медицинский кластер", "Хан Шатыр", "ТРЦ Asia Park", "Small", "Magnum", "удобная транспортная развязка", "вид на город", "динамичный район", "фудкорт", "банкоматы", "салон красоты", "стоматология", "автобусные маршруты", "развитая инфраструктура", "центр притяжения", "новые дороги"], "atmosphere": ["деловой", "молодежный", "спортивный", "современный", "ветреный", "активный", "широкие дороги", "развивающийся", "шумный у дороги", "урбанистичный", "динамичный", "открытое пространство", "новые постройки"], "district_name": "Нура"}	[-0.020221215,0.0026886056,-0.01160098,0.006349579,-0.0021475363,-0.025775757,0.042566884,-0.040988386,0.03334691,0.03784357,-0.01867086,0.01706938,0.06722792,-0.028117934,-3.892543e-05,0.015080845,0.051321946,0.051298402,-0.14103125,-0.043652937,0.0036987287,-0.031542104,0.053635135,-0.010899569,-0.04591337,-0.033360623,-0.056710903,-0.011345676,-0.009704788,0.002142838,0.039428394,0.039324775,0.018572383,0.0044406583,0.0117501365,0.00471508,-0.030718798,-0.062093314,0.0061156116,-0.043766726,-0.060619283,0.034062456,0.03033496,0.009241664,-0.033802498,-0.083279796,-0.020699589,-0.0057622814,-0.049961016,-0.011034211,-0.015078101,-0.04185277,-0.047816865,0.0077379216,-0.06643332,-0.011819684,-0.045990217,-0.02736709,0.03999323,0.0049995496,0.022941938,0.017886378,0.0043889293,-0.027438348,0.017647922,-0.029015725,-0.08505331,-0.022384185,-0.06312105,0.015571195,-0.013216779,0.10723843,-0.025559304,0.027688866,-0.002498924,-0.018397192,0.01865089,-0.0022608342,0.023212349,0.062072206,-0.059578143,-0.011612916,0.022297986,0.022310717,0.013026247,-0.007084451,0.009255269,-0.035360422,-0.06807525,-0.048891418,0.07028651,0.015019284,0.043763362,0.0371636,0.0779092,0.0074957116,-0.12735492,-0.11135014,0.07504101,0.058584943,0.0125219915,0.01197316,-0.03858145,-0.07568714,0.013620087,0.038751036,-0.06082786,-0.058070235,-0.058741778,-0.01429736,-0.018665561,0.0034335905,0.025351556,0.024511231,0.0073134466,0.028721133,-0.09468782,0.05097149,0.008526097,0.053770773,0.024849925,0.015309206,-0.0020760882,0.030650353,-0.017447468,0.026842343,0.017670583,-0.058313854,-0.04317756,-0.028311163,0.018686363,-0.043145724,0.0030352885,-0.018399144,-0.022275431,-0.008100154,0.059589297,-0.017774664,0.016816417,-0.027025873,-0.0012174773,-0.046812475,-0.030185658,-0.009238269,0.0023706986,-0.03776579,0.0078001064,0.046822637,-0.058606908,0.0068659903,-0.07943215,-0.0052753557,0.018705234,0.002336348,0.001930684,-0.026472207,0.07013129,-0.04363515,0.039672837,-0.029180462,0.07683898,-0.040408295,-0.059231833,0.021767162,-0.012763881,-0.014216494,0.019379755,-0.03526152,-0.027921451,-0.010966494,-0.023080256,-0.04789079,-0.004226901,-0.062481724,-0.00492839,-0.015482484,-0.037745755,0.02049364,-0.007811114,0.008005082,0.114390984,-0.014734769,-0.0063189804,-0.09318087,0.016476944,0.0001282656,-0.012166634,0.052386276,0.016458401,0.024386063,0.011016694,0.020646552,-0.020533623,0.036326554,-0.0450015,-0.02780721,0.03877653,-0.03293467,0.022623638,-0.07563488,0.05478745,-0.026849184,-0.02422793,-0.04635125,-0.039992653,0.019884413,-0.03298466,-0.049995273,-0.030247554,0.03794235,0.0026459452,-0.00874677,-0.028487278,-0.046916675,0.011968637,0.028821105,0.004103772,-0.034957066,0.10242922,-0.09810524,0.014901226,-0.00026686853,0.08994796,0.059333645,0.050516672,-0.0054368577,-0.008682615,-0.034788158,0.0066310368,-0.03442254,-0.01712968,-0.015562476,0.002963505,0.042827167,0.013090709,0.042770624,-0.0046812897,-0.045188956,-0.028432313,-0.035280928,-0.01371838,0.019244293,0.0170866,0.00095733104,0.0028063722,0.0009457816,0.040319413,0.016714815,0.043718845,0.035323057,-0.053215362,0.0057397075,-0.015467433,0.0030530107,-0.041962806,-0.05040557,0.015981745,-0.0016700777,-0.031052563,0.0067431494,-0.010999086,-0.0039736023,0.012306761,-0.05733982,-0.07193937,-0.05004698,-0.01556128,0.013334621,0.06251678,-0.060174912,0.07105016,-0.04228027,-0.024400359,0.020939643,-0.017854488,0.052087814,-0.02570959,0.021047546,-0.020197347,-0.050471503,0.03742421,-0.012587352,-0.014788924,0.01175858,0.050357662,-0.05425332,-0.020032682,0.006971111,-0.0017981437,-0.037697688,0.031775355,0.04400548,0.009715429,0.0027586601,0.012241201,-0.02165875,0.024115726,0.046141114,0.019657606,-0.057168778,0.01922628,0.055759802,-0.03923604,0.018124063,-0.015330298,-0.02265619,-0.0112673985,0.038938936,-0.032909464,0.0031912394,0.018940007,0.04873856,-0.044094402,-0.03478148,-0.052494835,0.0069294027,-0.118858315,-0.017348047,0.0103617795,0.0006923817,0.028015507,0.066848285,-0.00021408724,0.00032700715,0.058418274,-0.0017132331,-0.02668279,-0.043821126,0.02847389,-0.033165645,-0.0028348283,-0.01634545,-0.0050803693,-0.050420485,-0.02475171,0.016953921,-0.09237954,0.013364984,0.06424021,0.010952159,0.055485196,0.056671467,-0.016104022,0.014825726,0.0037537513,-0.024980934,0.0094575975,0.010341181,0.023753427,0.044584937,0.029089544,0.038246848,-0.031679872,-0.07290017,0.012170533,-0.0105615845,0.04021429,-0.014839944,-0.013100463,-0.07226208,-0.020988021,0.025377894,0.015885644,0.030502679,0.0030599134,-0.0013003129,-0.027377978,0.046627898,-0.07266662,0.000165143,0.00552687,0.024565002,0.002001993,-0.03222227,-0.014918628,-0.0052339416,-0.012604874,0.02698478,0.04134667,-0.0099316845,0.013637351,-0.0037431915,0.010162149,0.02075253,-0.00038509825,0.064960115,-0.041480552,-0.019393269,-0.015692245,-0.00795941,-0.0036047164,0.0229633,0.007846807,0.059902236,0.0070316405,0.0150322765,0.04272519,0.05853997,0.052051682,-0.0008436588,-0.019233795,-0.019782247,0.068223126,-0.037396766,-0.03058272,-0.025540529,0.052789643,0.010201534,-0.032308966,0.010464441,-0.014037411,-0.036341604,-0.024765188,0.016074745,-0.038452916,-0.018106503,-0.01706528,-0.013756251,0.017028168,-0.0506634,-0.031118419,0.0454798,0.03634342,-0.025529262,-0.017621307,-0.10659652,-0.027221197,-0.008490662,0.0071937013,-0.016845098,0.032260593,0.04626002,-0.0012262171,0.051602025,0.03212316,0.057507806,-0.019951826,-0.05079092,-0.045331772,0.027323764,-0.036062613,-0.0016904783,0.04381469,-0.021081317,-0.0059799375,0.030712005,0.047710165,0.01453582,-0.010835751,-0.012455386,-0.010737792,0.01854016,-0.0010354333,0.012345005,-0.063832544,0.026754351,0.03462918,0.0034516007,-0.052877985,0.034012496,-0.07219972,-0.03117464,0.050574303,0.024620906,-0.0076654246,0.025561403,0.023131987,0.0712387,-0.016793545,0.009304816,0.061709158,-0.025129242,0.054010473,0.011930592,0.014915698,-0.007989756,0.020267647,-0.01050578,-0.037637934,-0.04800368,-0.0070268307,0.014934804,-0.065608226,0.017149275,0.058705848,-0.031210424,0.040672738,0.036860134,-0.014535661,-0.030778266,-0.003193534,-0.004539695,-0.049771678,-0.03737014,0.008450067,-0.015955914,0.054984063,0.04910944,-0.0047880257,0.0026729705,0.07230617,0.014932564,0.021861829,-0.0654651,0.015120915,0.07700768,-0.069637544,0.01058395,0.02966415,0.02459894,0.03029878,-0.016651679,-0.029056828,0.06617638,-0.015113092,-0.0016050431,-0.038758468,0.026147421,-0.0059915553,-0.0038852992,0.023389945,-0.018063921,0.044751246,-0.055099785,0.013345054,-0.018657284,-0.010547398,-0.016599165,0.01654635,0.018563272,-0.010182375,-0.0067456686,0.044868544,0.0386841,0.016031168,0.06439252,0.014862987,0.047315244,-0.004827245,0.038206887,0.009413862,-0.034027223,-0.056363836,0.035527058,0.038352586,-0.01450026,-0.003270864,0.049262475,-0.033742208,0.06733249,0.017416704,-0.0659495,-0.020740705,-0.041681726,-0.0064840815,-0.02505746,0.02555892,-0.002336256,-0.07258817,-0.0017291022,0.013003333,-0.025357094,0.032229804,-0.0083846385,-0.012926967,0.012550752,0.048601408,0.058066297,-0.019573305,-0.007470617,0.030487545,0.014265961,0.03989342,-0.045263924,0.03330055,-0.01673337,-0.04822599,-0.018535547,0.001893797,-0.02968866,-0.017921552,0.03765841,0.03312317,-0.014905699,0.037712913,0.00830959,0.04303294,-0.029445315,-0.01798532,0.0016043764,-0.01184963,0.045371022,0.014790503,-0.056022163,0.026980855,0.0072828378,-0.017095452,0.026909009,0.044109315,-7.846685e-05,0.027970139,-0.007898751,0.06208886,-0.011046095,-0.0264245,-0.0618441,0.04457154,-0.023351459,-0.022557624,-0.04980249,-0.024716284,-0.0052645607,0.052386384,-0.032443255,-0.04184291,-0.0076394146,-0.041503325,-0.021244308,0.008421683,0.024981713,0.01209667,0.017724305,-0.018324792,0.021993188,-0.014828072,0.019085255,0.009703277,0.01620464,-0.019849505,-0.0109044565,0.04501438,-0.03929224,0.0146105345,-0.042080425,-0.013704361,0.01623702,0.0036263082,-0.022705121,0.035510622,-0.040138837,0.036437117,-0.0061798412,0.057033993,-0.025076676,-0.020960504,0.06833036,0.039294727,0.026851274,-0.008814477,0.0453279,0.01076857,0.06284533,-0.05013646,0.064453356,-0.002691069,0.022576127,-0.0126898205,-0.027250543,0.02225375,0.032571185,-0.016838785,-0.0021650377,-0.019717418,0.02936517,-0.05156108,0.05059326,-0.070324995,-0.011135974,0.0045100395,-0.0040565026,-0.018075926,0.037139565,-0.023688324,0.03553136,-0.0016173673,-0.012858213,0.022583902,0.007933774,-0.020485872,0.0089962995,0.010256044,-0.025141908,0.008697929,-0.07087257,-0.021403825,0.017773492,0.019113371,0.01410296,-0.015409935,-0.03913816,0.00370793,-0.027370699,-0.023950579,0.018624747,-0.024605533,0.04688261,0.015603752,-0.012557632,-0.029351836,-0.018012656,-0.00506187,0.014274279,-0.062732376,-0.05093079,0.012255952,0.0033729163,0.057323366,0.016221255,-0.017683906,-0.013102792,-0.0074698683,-0.004062399,0.019164251,0.033926178,0.014392636,0.07159742,0.0404034,-0.00769184,-0.0072061974,0.017924998,0.016669314,-0.021775436,0.042860907,0.0046551423,0.056286443,-0.0135960765,-0.07094335,-0.01769653,0.0019804924,0.059914842,0.0011814038,-0.007977962,-0.010902284,0.027924988,0.008960395,-0.03157741,-0.009948562,-0.020554656,-0.017639566,0.0012656274,0.06371775,0.0032265475,-0.048996188,-0.028227368,0.0021546646,0.0007644981,0.026049528,0.015882436,-0.04197576,-0.04344784,-0.072267674,-0.0028486757,0.006693055,-0.031391766,0.07814169,0.01526409,-0.0069686817,-0.013509268,0.008302984,-0.019477028,-0.012272421,0.040096644,0.008132801,0.050705373,-0.036267024,-0.007775235,0.07494559,-0.0013655641]	2026-01-20 16:05:02.738578+05	ЖК Arena Vista. Адрес: г. Астана, вблизи пересечения пр. Туран и ул. T-6
9d0833f8-ac76-43af-8030-5ead1717ed48	f68d1c73-4b0e-11ef-a830-001dd8b72708	Arena Unity	г. Астана, вблизи пересечения пр. Туран и ул. T-6	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10679	71.3944	Комфорт+		\N	https://bi.group/ru/landing/arena-unity	https://s3.bi.group/biclick/f68d1c73-4b0e-11ef-a830-001dd8b72708/f68d1c73-4b0e-11ef-a830-001dd8b72708_foto_400.jpg	{"side": "Left", "tags": ["экспо рядом", "мега силк уэй рядом", "тц рядом", "школа рядом", "детский сад рядом", "назарбаев университет рядом", "ботанический сад рядом", "парк рядом", "супермаркет рядом", "продуктовый магазин рядом", "аптека рядом", "кафе рядом", "ресторан рядом", "фитнес-центр рядом", "спортивный комплекс рядом", "астана арена рядом", "велотрек сарыарка рядом", "ледовый дворец алау рядом", "поликлиника рядом", "больница рядом", "медицинский центр рядом", "остановки общественного транспорта", "автобусные остановки", "удобный выезд на магистрали", "ж/д вокзал нурлы жол доступность", "кинотеатр рядом", "фудкорт рядом", "салон красоты рядом", "банкинг рядом", "банкомат рядом", "детская площадка", "спортивная площадка", "современная инфраструктура", "новые здания", "развивающийся район", "учебные заведения", "медицинские учреждения", "развлекательные центры", "зона отдыха", "офисные центры", "мечеть рядом", "чистые дворы"], "atmosphere": ["семейный", "молодежный", "современный", "развивающийся", "активный", "динамичный", "ветреный", "широкие дороги", "чистый воздух", "есть пробки в час пик", "красивый вид", "чистые улицы"], "district_name": "Есильский"}	[-0.017068816,0.02133855,3.3441604e-05,-0.028185043,-0.0056715105,-0.030760141,0.030719144,-0.033008534,0.023211878,0.04453854,-0.0020643494,0.051214978,0.05450868,-0.0229644,0.019293342,0.02765291,0.052640773,0.044700645,-0.12810399,-0.03488124,0.025874903,-0.005534995,0.047805626,-0.020276567,-0.054795776,-0.060935803,-0.04818896,0.009237692,-0.0025378612,0.008865366,0.042838085,0.046424072,0.02075318,0.009364176,0.01489606,0.0012299612,-0.011866646,-0.061407622,0.02165272,-0.031688817,-0.043581307,0.04241083,0.0058437516,0.016223978,-0.0761887,-0.0621981,-0.044902537,0.020929873,-0.038016822,-0.011677588,-0.013562358,-0.073492505,-0.04790031,0.044934295,-0.06503186,-0.009322413,-0.038230546,-0.020814681,0.066766955,0.013625272,-0.007029883,0.008061642,-0.0071166595,-0.017747594,0.017832827,-0.022465428,-0.052593663,-0.004759161,-0.049759924,0.040602867,-0.028411794,0.09651048,-0.03356064,0.021462409,0.00066632027,-0.014669799,-0.003358088,0.0007040126,0.04845545,0.04219086,-0.03806071,-0.0122041125,0.03197151,0.017198183,0.0076219123,0.004503159,0.005658562,-0.01033551,-0.059974607,-0.038837664,0.07597825,0.022649135,0.047462016,0.052368857,0.056457542,0.027385384,-0.11649378,-0.09726855,0.05858131,0.037817378,0.017382966,0.021258503,-0.05157273,-0.08626979,0.02014353,0.07594535,-0.074794315,-0.05183652,-0.057546787,0.017709553,0.005387965,0.0024033743,0.03762922,0.0059425347,0.018308049,0.043124925,-0.094024695,0.055122737,0.026884628,0.025435667,0.030082643,0.023612048,-0.002997392,0.041165106,-0.0030123086,0.018779974,0.013674709,-0.04651285,-0.0355744,-0.028481506,0.030138327,-0.025630198,-0.012995073,-0.02332189,-0.016824745,-0.0083678,0.06014915,-0.028873809,0.018958824,-0.011430402,0.010304855,-0.04527591,-0.053648565,-0.024750626,-0.004139637,-0.016261032,0.016860675,0.06218244,-0.061828602,0.020579677,-0.05543207,-0.023661131,0.03126959,-0.0150045585,0.030689597,0.002549107,0.077950895,-0.02904678,0.023855144,-0.03740944,0.0555378,-0.045859184,-0.045203444,0.0049699363,-0.0034943237,-0.011254763,0.036168315,-0.014300514,-0.017344262,-0.0025819456,-0.015593916,-0.05151383,-0.03226956,-0.057216704,-0.012417316,-0.0050893663,-0.031522002,0.014563028,-0.009707108,-0.0010801171,0.107291326,-0.019792518,-0.0149035,-0.0578746,-0.008416708,-1.3901814e-05,-0.01563338,0.06330259,0.044767212,0.0077965828,0.009049945,0.019372448,-0.023204593,0.05460412,-0.060851153,-0.01613741,0.047090277,-0.06323215,0.0030956394,-0.06418182,0.045217954,-0.036159024,-0.02150028,-0.01578374,-0.04529367,0.044514496,-0.032354914,-0.046912476,-0.042917773,0.035839632,0.008751736,-0.02950476,-0.035255075,-0.066674955,0.018300878,0.015227722,-0.0068726502,-0.010032687,0.11470942,-0.09635935,0.004232011,-0.0026678762,0.07827544,0.032356597,0.06936542,-0.0064186654,-0.014955507,-0.018908115,-0.018511364,-0.039379623,-0.03193835,0.005225504,0.004492595,0.047305454,0.00073194556,0.028625155,0.005796485,-0.059092224,-0.03579728,-0.03262548,-0.040681727,0.032650903,0.03143474,-0.031183215,0.019989172,0.0067733387,0.050120126,0.046036948,0.027539669,0.03803193,-0.04005874,-0.009304895,0.0007277779,0.00010940008,-0.06644557,-0.05476771,0.029398967,-0.006902297,-0.027389698,-0.041903995,-0.0031846564,-0.01784099,0.010332436,-0.0835201,-0.06457959,-0.041435387,-0.029602319,0.0016799585,0.07243859,-0.032125417,0.08144149,-0.036701072,-0.036205236,-0.006945482,-0.035251513,0.090078525,-0.029677266,0.0331606,-0.024033926,-0.044695042,0.043966856,-0.02125534,-0.039031096,0.016933152,0.026795218,-0.06497446,-0.030719725,0.014367691,-0.03538767,-0.036433935,0.025008878,0.05479071,0.015377873,0.014424422,0.007032932,-0.05096116,0.024986314,0.022819329,0.0060091186,-0.04672194,0.02591793,0.05433514,-0.038202506,0.025671037,-0.01198073,-0.03938304,0.0003260696,0.02897982,-0.028747937,0.009077722,0.0029828083,0.029306304,-0.050250713,-0.03241484,-0.02836362,-0.027396988,-0.12737341,-0.058886983,0.020435732,-0.00087506376,0.0018468566,0.065457456,-0.0025345355,0.0057482743,0.03056377,-0.013495331,-0.016170103,-0.039591983,0.049428444,-0.037000787,-0.00059246965,0.014650495,-0.008616977,-0.039910063,-0.013973561,0.014346963,-0.0745157,0.023524264,0.05762205,0.031445064,0.041269816,0.05882234,0.0005759058,0.023482403,0.004507254,-0.018578488,0.008539138,0.026484035,0.02413489,0.027438741,0.021000827,0.008251886,-0.05559507,-0.05897484,0.032952294,-0.008231196,0.050968636,0.0056688893,-0.0018730251,-0.07402753,-0.016767235,-0.0058575477,0.0016234879,0.03614904,0.011168781,0.012490281,-0.022611,0.04941615,-0.05053223,-0.0033204355,0.035619292,0.030258313,0.010763213,-0.0038484696,-0.004373671,-0.0068369596,-0.039942436,0.017950116,0.03175274,-0.0014563013,-0.009752405,0.014904356,-0.015621139,0.02977927,0.0076712966,0.06728221,-0.04949823,-0.02325849,-0.02158458,0.0007314793,-0.01689522,0.013107653,0.03196677,0.027731894,0.02564902,0.023399767,0.050660096,0.05223084,0.035489768,0.00438359,-0.022216612,-0.043798573,0.08835215,-0.005806406,-0.0050201546,-0.019314174,0.05974328,0.0014886709,-0.014287611,0.0011840133,-0.019248627,-0.025491552,-0.022762932,0.00042411467,-0.03990496,-0.011625528,-0.0199277,-0.018551754,0.014388438,-0.024609525,-0.036158856,0.04491461,0.031879764,-0.012797508,0.0031073345,-0.097736746,-0.026662737,-0.003660572,0.009099179,0.0014022149,0.04416797,0.043021854,0.0031465637,0.048155867,0.011558378,0.08786846,0.00059302617,-0.031051407,-0.036281414,0.02929852,-0.023567097,-0.010200792,0.039591454,-0.01602779,-0.0012154513,0.032635786,0.043219052,0.017663745,-0.010463431,-0.0098348595,-0.0036627203,0.012588683,-0.005845183,0.0083892085,-0.06276012,0.027039368,0.030163398,0.00091725535,-0.048191775,0.034330398,-0.05281586,-0.033727713,0.065270975,0.013668019,0.00884157,0.017239679,0.018819056,0.05702144,-0.041509368,-0.009899175,0.04677892,0.010470905,0.040708553,0.017062465,0.03469204,-0.00019923363,0.010874364,-0.030306872,-0.056185555,-0.022339785,-0.03511381,0.020877473,-0.06160117,0.016787473,0.03161141,-0.036129415,0.005861684,0.049495008,-0.03622785,-0.04915424,0.0033068687,-0.013066219,-0.036350854,-0.038316824,0.019986635,-0.026569415,0.046125755,0.03858483,0.0024026616,0.004083022,0.056009136,0.033729605,0.034801,-0.068970375,0.02219028,0.047879934,-0.05587619,0.0048072245,0.044668168,0.03412493,0.03942395,-0.03163798,-0.022055715,0.050564464,-0.01515776,0.009551523,-0.038475823,-0.009741441,0.013289359,-0.022421747,-0.012962348,-0.030579774,0.03960025,-0.05857051,0.013837089,-0.013362952,0.0021956956,-0.039026532,0.023979772,0.015624923,-0.025960507,0.0063697947,0.042828355,0.03316593,0.0219063,0.05608397,0.015190209,0.042339858,0.0089183645,0.038768724,0.028123816,-0.011717661,-0.061766677,0.009220177,0.036093067,-0.021937078,-0.02628808,0.06729055,-0.03179363,0.060878504,0.0015770346,-0.071386725,-0.033835158,-0.06836678,-0.016217332,-0.0282843,0.019991007,0.00076792494,-0.06875921,0.018320912,0.0367124,0.009629736,0.056602057,-0.017917912,0.0057018925,0.024056967,0.045716014,0.065272555,-5.4701024e-05,-0.0037407856,0.0055611194,0.0014835222,0.03982811,-0.025535839,0.03314022,-0.017643284,-0.045944463,-0.004484825,-0.011048789,-0.017467925,-0.032008886,0.017376125,0.016753715,-0.03422199,0.013496057,0.02093113,0.042542864,-0.026958011,-0.030951431,0.032706827,-0.008599727,0.028203763,-0.0071029463,-0.054444794,0.025131864,0.0037804083,-0.025758214,0.061969258,0.028262893,0.012355019,0.020185739,0.002829348,0.06232066,-0.021450333,-0.030473927,-0.052523214,0.011554212,-0.029098704,-0.017255455,-0.020205801,-0.04115006,-0.0055685677,0.05790515,-0.031132659,-0.047751628,0.010632175,-0.03265867,-0.030715954,0.00034983925,9.3425035e-05,0.002485225,0.0069878357,-0.03795476,0.007959737,-0.00899167,0.026883064,0.019732306,0.0009664317,-0.011461741,0.02382318,0.03498622,-0.035346262,0.006058969,-0.038174715,-0.006280341,0.016496098,0.021907723,-0.023483137,0.015896773,-0.07014513,0.046626803,0.01843486,0.04650826,-0.013235842,-0.026253887,0.0657001,0.027126007,-0.0162089,-0.0067675486,0.080493875,0.0029570786,0.028757975,-0.046123832,0.07490606,-0.015162645,0.030532233,0.009637802,-0.020988997,0.034559846,0.039440203,0.0015520398,-0.007520716,-0.016373629,0.015573921,-0.07354601,0.060088973,-0.046065014,-0.024765555,0.0044341027,-0.005512651,-0.034096763,0.032674264,-0.049328715,0.0343913,-0.0013223463,-0.029437352,0.010899155,-0.028493727,-0.03739442,0.00559569,-0.0035668465,-0.00952194,0.0030458258,-0.080107756,-0.01513732,0.013113373,0.017004082,0.013162074,-0.039331492,-0.012554301,-0.008645415,-0.033700537,-0.009039986,0.02150881,-0.025852896,0.059676155,-0.0051430687,-0.015883407,-0.026763216,-0.021718387,-0.020423176,0.0064613298,-0.061077513,-0.051341653,0.008679547,0.015612125,0.04763161,0.024600284,-0.009599844,0.0014875554,0.012682847,0.0035459993,0.019584194,0.014164859,0.010487334,0.05489531,0.055791043,-0.018962564,0.014642361,0.009158978,0.03666796,-0.015405783,0.03166095,0.020022178,0.0380164,-0.0012924741,-0.06396946,-0.009817684,-0.008218801,0.06308445,0.002400846,-0.0024551388,-0.008598857,0.019666739,-0.0055921264,-0.03002655,-0.031236317,-0.030119186,-0.0414457,-0.016207114,0.0369421,-0.01359448,-0.037879754,-0.0313565,-0.012648995,0.016125279,0.043372773,0.01239571,-0.02618775,-0.032833874,-0.06369406,-0.010258357,0.00037651832,-0.024319403,0.085634984,0.0022489827,0.014584462,-0.02087721,0.014798295,0.026791764,-0.021240633,0.05318518,-0.0011941982,0.07298091,-0.018701756,0.0067412923,0.047522515,-0.01112965]	2026-01-20 16:05:02.172128+05	ЖК Arena Unity. Адрес: г. Астана, вблизи пересечения пр. Туран и ул. T-6
268f202a-ef1a-4263-81d4-cfa593722772	b014cff8-24de-4cc1-846a-8a672f863a83	Arna Urpaq	г. Астана, ул. Хусейн бен Талал, 11/1	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.08608	71.38031	Комфорт+		\N	https://bi.group/ru/landing/arna-urpaq	https://s3.bi.group/biclick/b014cff8-24de-4cc1-846a-8a672f863a83/b014cff8-24de-4cc1-846a-8a672f863a83_foto_400.jpg	{"side": "Left", "tags": ["expo", "mega_silk_way", "botanical_garden", "astana_ballet", "nazarbayev_university", "binom_school", "nis", "hospital", "supermarket", "magnum", "small", "pharmacy", "playground", "parking", "new_building", "airport_direction", "linear_park", "fitness_center", "coffee_shop", "restaurant", "bus_stop", "security", "closed_yard", "high_ceilings", "modern_facade", "near_park", "near_school", "near_kindergarten", "cycling_path", "walking_area"], "atmosphere": ["тихий", "семейный", "деловой", "современный", "перспективный", "ветреный", "просторный", "чистый воздух", "широкие дороги", "безопасный", "развивающийся", "ухоженный", "малоэтажная застройка", "спокойный"], "district_name": "Есильский"}	[-0.005245569,0.00021596209,-0.013007934,0.0049184635,-0.0131749315,-0.013631366,0.013160982,0.018144237,0.0064644734,0.07147186,-0.021033479,0.019280422,0.06141543,-0.026064867,-0.01954157,-0.008975005,0.056031737,0.05143919,-0.13587089,-0.01580403,0.032075584,0.009865719,0.055738598,-0.00074324466,-0.047127116,-0.033267397,-0.058660842,0.034259386,0.0007325676,-0.028322868,0.021673298,0.03649854,-0.0150274895,0.014496186,0.0135589065,0.027497381,-0.037144165,-0.02018113,0.029274695,-0.022968281,-0.06585219,0.040417865,0.0077865454,-0.007892638,-0.07207346,-0.049231045,-0.028099893,0.007967047,-0.043271456,0.014587935,0.022503275,-0.018982586,-0.016789798,0.030422416,-0.090471566,-0.025023082,-0.014526672,-0.020109337,0.02348832,-0.028864356,0.011049836,0.016604181,-0.017059088,0.013356644,0.027838903,-0.03765169,-0.07483446,0.00019123116,-0.052598998,0.016432898,-0.04279521,0.042934205,-0.032869574,0.010558988,-0.020905674,-0.0030258598,0.01753124,0.015550325,0.041260663,0.065286785,-0.022483204,-0.0073805233,0.045813147,-0.011822958,0.0006079771,-0.015305086,0.003689652,-0.064534806,-0.07452435,-0.023408292,0.0868253,0.022561835,0.050201192,0.052080106,0.06146586,0.010238881,-0.10501425,-0.09084011,0.077547394,0.027404515,0.039541814,0.030004544,-0.0379967,-0.07300479,-0.0008272701,0.054914955,-0.05583448,-0.029395603,-0.038113546,-0.012040992,-0.005773623,0.0043178876,0.01436339,-0.008144644,-0.00807693,-0.0011108975,-0.053111482,0.06460496,0.016822284,0.006401704,0.06656023,-0.00389533,0.008730436,0.051077273,0.037771627,-0.021278413,0.038614802,-0.015651165,-0.02451981,-0.0007392183,0.015952729,-0.07941307,-0.01329533,-0.0041731354,-0.0044111046,0.011869284,0.056812968,-0.03878524,0.002379505,0.029170042,0.021717913,-0.03726983,-0.06319995,0.030127415,-0.00830475,-0.018333586,0.03576386,0.08491341,-0.03804196,0.013785467,-0.05202074,0.002396773,0.04888218,-0.015937302,0.009158689,-0.024954528,0.1033827,-0.053545658,0.019528465,-0.06344417,0.022537895,-0.07446481,-0.027191507,0.029514747,-0.0061395066,-0.01856224,0.01811941,-0.017223362,-0.032126166,0.012724168,-0.03864599,-0.08921646,-0.0018747936,-0.061493184,-0.03585955,0.000451519,-0.040082626,-0.0043980503,0.0024597112,0.02852735,0.09996812,-0.019664964,-0.010752413,-0.09012549,-0.008217622,-0.013401453,-0.07070031,0.033879265,0.021396494,0.023374755,0.041731182,0.018276192,-0.0033175822,0.033130176,-0.037948795,-0.036647078,0.041804146,-0.047842175,0.06031252,-0.06364599,0.053944048,-0.018776378,0.024904266,-0.04679546,-0.026104415,0.029885039,-0.016486352,-0.070788,-0.0420321,0.052335117,0.0023276678,-0.0056091608,-0.005484113,-0.071204804,0.018044261,0.038904052,0.0022219904,-0.041733097,0.10873165,-0.08182755,-0.0119367195,0.0041139787,0.06295852,0.039502274,0.04378269,-0.032206092,0.01582469,-0.047451515,0.016348906,-0.04680483,-0.035726864,0.0020243598,-0.032012984,0.05962568,-0.06107643,0.03469642,0.013532051,-0.0665453,-0.03204802,0.017213026,0.013353367,0.030974861,0.015851127,-0.031790793,0.0054080193,-0.011850194,0.08620916,0.047467496,0.013168727,0.006366884,-0.023106443,-0.0014334564,-0.02986086,-6.949909e-05,-0.05206337,-0.060031798,0.027829116,0.009634741,-0.038774863,-0.0095731625,-0.0031168498,-0.032680277,0.00899357,-0.06304466,-0.049091674,-0.07595906,0.0007746907,0.023247534,0.045605633,-0.031924218,0.054947,-0.026465802,-0.030663563,0.019151054,-0.015406514,0.048261862,-0.056789067,0.020676095,-0.046146113,-0.041580237,0.07044713,-0.0056968424,0.00015854063,-0.011338744,0.019039704,-0.04633208,-0.019720381,0.021758972,-0.026447227,-0.021124316,0.005347868,0.058417395,-0.0015940553,0.011198072,0.019794572,-0.04139701,0.017306183,0.0118712345,0.018346865,-0.033707406,0.014602227,0.061818536,-0.04451619,0.016769255,-0.03281211,-0.018766306,-0.0157744,0.037716586,-0.02327803,-0.023199324,0.019966226,0.015530359,-0.060626198,-0.041155316,-0.04278194,-0.0020577842,-0.17832649,-0.02144134,0.007627797,0.0036664563,-0.019893626,0.0312116,-0.010308575,0.023398923,0.019514987,-0.028853878,-0.027865691,-0.03514521,0.046759333,-0.026663678,0.00636953,0.0043886146,-0.030050157,-0.06311099,-0.006516475,0.047149602,-0.07630889,0.033711813,0.05838211,0.03104074,0.06830087,0.017827995,-0.00235025,-0.0024552278,-0.00456303,0.0053282003,-0.0025006102,-0.009299735,-0.0021035925,0.023588102,0.0034622536,0.008681994,-0.033004533,-0.05864205,0.023862828,-0.05002994,0.024196409,0.00899118,0.021336254,-0.054753147,-0.0021041043,0.031783413,0.010662184,0.022958443,-0.016093438,-0.025778739,0.017344523,0.04486526,-0.078947514,-0.010297556,-0.020166544,0.02167182,0.027094502,-0.01001257,-0.022447798,-0.014539243,-0.0072113583,0.010392255,0.008139959,-0.00936531,0.019226514,-0.03233791,0.027752526,0.028562697,-0.034201257,0.068170205,-0.027499827,-0.019719256,-0.034319457,-0.013590458,0.0065253037,0.029615065,0.016050918,0.052562967,0.014685884,0.047559425,0.055820916,0.07176613,0.03733435,0.027760517,0.0052066087,-0.022214407,0.07777838,-0.05049043,-0.0472269,-0.038350657,0.0620359,0.021501472,-0.014332448,0.0022572854,-0.018944755,-0.0049593346,-0.05112703,0.024257626,-0.05253734,-0.004796605,0.012289198,-0.016783327,-0.015882652,-0.025537837,-0.024206318,0.034724526,0.020794803,-0.0054896087,-0.013003976,-0.07157947,-0.0026274119,-0.0050246012,-0.005414132,0.0037865774,0.02305333,0.049890168,0.0153280515,0.04739882,0.03260182,0.055896766,0.018436667,-0.0297301,-0.0265222,0.02123425,-0.0118703935,0.0029028677,0.02918363,0.028309105,0.027486213,0.021197159,0.041247662,0.0077110305,-0.017342996,0.0003294141,-0.0016525062,0.0199757,0.032533824,0.012085824,-0.05067442,0.025649078,0.018544136,0.013533357,-0.031029606,0.03749595,-0.066657096,-0.047531668,0.042528767,0.05029433,0.009710698,0.047491666,0.019055348,0.048240684,-0.023336431,-0.0025267822,0.054186173,0.0068376665,0.05837717,-0.0059397416,0.0008285061,0.006083748,0.0152718015,0.004779997,-0.060464013,-0.04290508,-0.0057604774,0.041536205,-0.061069123,0.027704388,0.042164214,-0.039065305,0.0102475025,0.019881751,-0.019009013,-0.014164202,-0.032986753,0.01381611,-0.03755706,-0.035714243,0.01588002,0.016402049,0.05131292,0.034698863,0.0013425109,0.028070306,0.058789212,0.035403654,-0.012954009,-0.05834469,0.003346559,0.075296804,-0.044872735,0.0083013885,0.08763099,0.018395973,0.026597202,-0.0063502076,0.014211267,0.035923865,0.0070703076,-0.007932006,-0.038365517,0.062014207,0.0070128734,-0.0030067812,-0.00893681,-0.013817695,0.042682372,-0.014909752,0.009538153,-0.0030981642,-0.008664983,-0.017942278,-0.002211401,0.016623829,-0.03805606,0.03469698,0.06034155,0.026930975,0.025221286,0.0045570256,0.012728144,0.064583324,0.02026659,0.033183232,0.026481181,-0.029788835,-0.04322345,0.009469745,0.009195936,-0.019729616,-0.006617392,0.050171837,-0.0275522,0.06982644,0.00041148148,-0.05344284,-0.034061685,-0.026515704,0.015113932,-0.021121057,0.025254933,-0.022876864,-0.08220997,-0.03345603,0.013671335,-0.010598881,0.016012,0.0017045306,0.0072554606,0.031755902,0.039574906,0.052459273,-0.016117133,0.013795587,0.016931985,-0.0018717911,0.030857166,-0.0363383,0.04478034,-0.03286649,-0.05763667,-0.024804138,0.00065864786,-0.044679977,-0.010073549,0.051630203,0.028896423,-0.031702522,0.027678028,-0.017070692,0.018948691,-0.019127786,0.019421726,0.019793184,-0.0173574,0.026685039,0.01191364,-0.08079878,0.036182545,0.0025579187,-0.06925348,0.046095885,0.06382881,0.017628318,0.036425065,-0.002486443,0.024464035,-0.026610853,0.008939515,-0.05251349,0.02404408,-0.02182763,-0.025132427,-0.014716935,-0.008885639,-0.0066019725,0.03790736,-0.013873456,-0.068646915,0.0022907625,-0.033637658,-0.019327022,0.013852143,0.025768898,-0.0130264675,0.009687401,-0.002038081,-0.016525479,-0.015838636,0.010016162,0.022922162,0.009587829,-0.011046363,0.025457006,0.052824315,-0.02405405,0.0052645532,-0.03619163,-0.015568988,0.007509967,0.015080008,-0.033627097,0.023219507,-0.058691915,0.01904933,-0.01754778,0.061220996,-0.034967836,-0.0249865,0.05820545,0.073271416,-0.023563243,0.015472675,0.04512928,0.0025291974,0.01141667,-0.0638844,0.07608179,0.0014250681,0.015343959,-0.0056247516,-0.023038503,0.027069291,0.05462544,-0.02006795,0.00035951188,0.010973637,0.015324947,-0.058899615,0.05065913,-0.02519572,0.0017474203,0.036158677,-0.015080883,-0.006040785,0.018225236,-0.031330366,0.014508359,0.000254786,-0.0040071886,0.03789707,0.0014680558,-0.004563107,0.031098107,-0.02755631,0.0010846237,0.005344974,-0.05904662,-0.011083001,-0.0041578347,0.011817011,-0.0103617385,-0.023889704,0.0023700322,-0.0030869571,0.0037644117,0.006428787,0.008485974,-0.016036594,0.024561403,0.0032048118,0.02023834,-0.009583932,-0.04092724,0.0007639235,-0.003925337,-0.08414258,-0.07734865,0.016279817,0.018324867,-0.00018923289,0.0025032517,-0.010235097,-0.028217794,0.0004673461,0.030948259,0.021540463,0.045592345,-0.013902534,0.0477382,0.056895733,-0.015962413,-0.020122841,-0.0047352985,0.050830107,0.004364163,0.022077337,-0.0062537966,0.07170977,-0.0017056388,-0.057737496,-0.018605568,-0.010970766,0.03416039,0.043663047,0.0089261485,0.020495249,0.056648657,-0.0014166896,-0.041103415,-0.04167505,-0.0244445,0.00058535894,-0.0072107813,0.017419435,-0.0070054675,-0.035706308,-0.019719988,-0.004249021,-0.012312215,0.026716722,-0.0030252389,-0.044601716,-0.040293116,-0.044227,-0.0072136936,0.010931319,-0.0050116717,0.068024635,0.014089754,0.050519995,-0.0025528704,-0.051825844,0.03308033,0.0021251705,0.047903355,0.015843041,0.040659312,-0.048281852,-0.022665057,0.06266825,-0.043902144]	2026-01-20 16:05:05.501521+05	ЖК Arna Urpaq. Адрес: г. Астана, ул. Хусейн бен Талал, 11/1
d0f283d8-4977-4277-a4e9-47c56f59d780	e196a8fc-d7da-11ef-a834-001dd8b726aa	GreenLine. Garden	г. Астана, бигвилль GreenLine	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13819	71.3911	Бизнес		\N	https://bi.group/ru/landing/greenline-garden	https://s3.bi.group/biclick/e196a8fc-d7da-11ef-a834-001dd8b726aa/e196a8fc-d7da-11ef-a834-001dd8b726aa_foto_400.jpg	{"side": "Left", "tags": ["парк рядом", "школа рядом", "детский сад рядом", "экспо рядом", "ТЦ рядом", "супермаркет рядом", "аптека рядом", "кафе рядом", "рестораны рядом", "фитнес-центр рядом", "салон красоты рядом", "остановки общественного транспорта", "подземный паркинг", "спортивный комплекс рядом", "кинотеатр рядом", "университет рядом", "поликлиника рядом", "медицинский центр рядом", "велодорожки", "новые дома", "современная архитектура", "охраняемая территория", "детские площадки", "спортивные площадки", "Ботанический сад", "Mega Silk Way", "Astana Arena", "Назарбаев Университет", "чистый район", "развитый район", "престижный район", "удобная транспортная развязка", "фудкорт", "банки", "почта", "детские развивающие центры", "химчистка", "автомойка", "заправка", "офисные центры", "государственные учреждения"], "atmosphere": ["тихий", "семейный", "зеленый", "ветреный", "элитный", "современный", "широкие дороги", "чистый воздух", "красивый вид", "развитая инфраструктура", "комфортный", "безопасный", "ухоженный", "престижный", "спальный"], "district_name": "Есильский"}	[-0.021317337,0.00848098,-0.025841733,-0.013237411,0.023665292,0.00014564401,0.015846377,-0.022036163,0.0150638865,0.034356542,-0.015949368,0.048818965,0.04409552,-0.034711465,-0.012027939,0.010444861,0.057042077,0.044808492,-0.1276712,-0.0017541259,0.014526549,0.00032422502,0.052795403,-0.0014793873,-0.04928306,-0.043132592,-0.062302034,0.017645422,-0.020167693,-0.021775896,0.037321474,0.06432447,0.010850719,0.012627894,0.008965742,0.02898886,-0.04312405,-0.04253168,0.032124233,-0.037034646,-0.057529423,0.039094146,0.0013409293,0.026763616,-0.08492615,-0.07637724,-0.020105511,0.013223732,-0.037233915,0.0005868,-0.005821915,-0.04576694,-0.040822774,0.05474633,-0.05978993,0.0051208944,-0.012074882,-0.016953865,0.07316511,0.005019126,0.025813848,-0.009511434,0.012112461,-0.0155016435,0.021185443,-0.0029698778,-0.07948888,-0.0347149,-0.06426557,0.0097817825,-0.0023937293,0.112538666,-0.034793604,0.016672956,-0.025493642,0.013688704,0.014775108,-0.0011908647,0.03189482,0.06663524,-0.052722298,0.00068130676,0.029332386,0.0072002653,0.010934257,-0.005423776,-0.0030687926,-0.04855973,-0.069673315,-0.01381048,0.07354275,0.030062038,0.03764952,0.042016156,0.07142543,0.02776176,-0.1009049,-0.11944986,0.048055477,0.033609156,0.014682272,0.016577126,-0.031142017,-0.08157897,0.022867328,0.066253364,-0.06324033,-0.06746021,-0.06484807,0.015637986,0.01732333,-0.013987231,0.015548311,-0.007964055,0.008128173,0.035207894,-0.079145566,0.058125794,-0.018812211,0.019067384,0.030777214,-0.00026696504,-0.020146336,0.03903832,0.028504478,0.0271473,0.0219922,-0.027081303,-0.05647113,-0.030314459,0.015074179,-0.047549117,0.009872544,0.0006800949,-0.037834205,0.03499824,0.03399801,-0.0071709338,0.011086597,-0.020799128,0.03204857,-0.0111944415,-0.051050328,-0.02065971,-0.0037094764,-0.02716807,0.016637014,0.049289763,-0.02429881,0.024033424,-0.047157943,-0.029396417,0.018801339,0.008162689,0.025378846,-0.011176777,0.05862582,-0.057000346,0.015041836,-0.048286516,0.05200428,-0.01597005,-0.027110055,0.0051114443,-0.00031553258,-0.0046079187,0.009293009,-0.033799727,-0.018401982,-0.00035762644,-0.037117228,-0.08157896,0.00039014337,-0.050097253,-0.018928563,0.008176643,-0.023453472,0.015617392,-0.026108846,0.010876119,0.106062196,-0.0008126583,-0.012330684,-0.04465579,0.004091595,0.027679289,-0.015075943,0.03953743,0.019091357,0.01768777,0.015967168,0.014977514,0.0011444433,0.06574363,-0.047165144,-0.036904052,0.05499261,-0.06330263,0.003454786,-0.056043424,0.041813858,-0.049206186,-0.0051055774,-0.030232657,-0.017028365,0.02658705,-0.029985161,-0.080982834,-0.031908937,0.06401921,0.009679714,-0.025817553,-0.05175021,-0.06688152,0.04860988,0.02820741,0.016344396,-0.014427853,0.07265997,-0.07557414,-0.006701861,0.012992963,0.05375633,0.025306394,0.042546637,-0.01596138,0.0063627716,-0.020569278,-0.015634919,-0.031890992,-0.018137723,2.516008e-06,-0.022300266,0.051438913,-0.008421105,0.045946766,-0.0059910724,-0.06486938,-0.029421676,-0.0145751415,-0.0095067145,0.037757866,0.03115476,-0.020029726,-0.011169937,0.01949173,0.051828828,0.03198882,0.002724461,0.03020004,-0.041951362,0.003970417,-0.0068824287,0.00048362513,-0.050573718,-0.044459905,0.02786158,0.027104806,-0.023107918,-0.019471996,-0.011102858,-0.028699825,0.029341133,-0.071397424,-0.060092796,-0.042611808,-0.013879956,0.01032252,0.039588757,-0.0381411,0.093350306,-0.049146462,-0.024046132,-0.014759986,-0.020910492,0.06141377,-0.055398278,0.054015383,-0.013393453,-0.05501441,0.05321071,0.0037198048,0.00088747026,-0.017787974,0.026472857,-0.05681311,0.009228429,0.013981337,-0.034284193,0.00017160503,0.015262886,0.048640236,-0.0062252725,-0.0029085046,0.010117281,-0.031291183,0.015614261,0.03410251,-0.012197571,-0.06453453,0.015596285,0.052096266,-0.03796256,0.01647413,0.0052889357,-0.038493406,-0.001367992,0.0041300454,-0.011437302,0.0078102583,0.034379724,0.04034474,-0.062387303,-0.045370206,-0.037898142,0.0061509185,-0.15784325,-0.06364535,0.00816941,-0.028897224,-0.0076995613,0.07742703,0.0049137385,-0.028640568,0.05193389,-0.0043006977,-0.028950993,-0.0713042,0.06501536,-0.034267053,0.0070895674,-0.018286647,-0.015176933,-0.04670891,0.0133464355,0.029853333,-0.07916135,0.022520887,0.034616094,0.02233749,0.029759225,0.04692814,0.021564625,-0.008018434,0.020690568,-0.0043445886,0.011260222,0.018109856,0.02925454,0.018704226,0.024825487,0.027228693,-0.0154514415,-0.04594003,0.027557723,-0.03077968,0.031045571,0.014362192,-0.009714809,-0.084296465,-0.014665729,0.01096615,0.018593224,0.006152501,0.039440043,0.010035206,-0.031145161,0.04868029,-0.049580067,0.019885017,0.02454974,0.029280169,0.017078614,-0.004708044,-0.018893778,-0.0112576885,-0.012186541,0.009608585,0.017639501,-0.01890114,-0.0022746152,-0.026958726,0.0022078878,0.04322203,-0.007444807,0.06163596,-0.04986941,-0.02980113,-0.024916647,0.007020547,-0.005895481,0.015588722,0.014179855,0.034217164,0.039137945,0.034859546,0.05304304,0.058351226,0.039544158,0.017417235,-0.016493917,-0.039655056,0.05455073,-0.005047323,-0.021489179,-0.02466882,0.04634649,-0.0026543401,-0.03558836,0.0024866927,-0.026629463,-0.026619317,-0.03437673,0.004839562,-0.032847367,-0.008651384,-0.00364352,-0.008904995,0.027386406,-0.031615358,-0.05404939,0.030086374,0.04198619,-0.0014791313,-0.0011102244,-0.09631622,-0.015562181,-0.010134978,-0.019084672,-0.022194088,0.04756285,0.04036559,0.0066084983,0.011916447,0.019565148,0.072715856,-0.0010306333,-0.029494809,0.001131644,0.0012092785,-0.01949542,-0.00923941,0.013619936,0.0019699754,0.009280057,0.03193753,0.038641334,-0.012162077,-0.016814088,0.0045888256,-0.03067526,0.011575275,-0.007288786,0.0018585853,-0.059005894,0.011852416,0.029554855,0.018987304,-0.04768693,0.028229319,-0.038643688,-0.035546687,0.044530272,0.025569761,0.00087876624,0.03978699,0.019696314,0.07116036,-0.032051824,-0.014776706,0.062306818,0.00868019,0.041936126,0.0029022824,0.0037314468,-0.018494109,-0.012438068,-0.023646694,-0.050292403,-0.03276654,-0.027133297,0.019421777,-0.07877991,-0.004921265,0.036398537,-0.040320747,0.01805884,0.055871867,-0.03024912,-0.02410833,-0.007522709,0.0019082912,-0.027674425,-0.042654246,0.03183253,-0.022528902,0.045420732,0.038614348,-0.0238732,-0.0077388133,0.06436873,0.033576347,0.035441663,-0.0654263,-0.0129437195,0.07288202,-0.07726016,-0.008479835,0.04466109,0.04135105,0.021946447,-0.046730068,-0.027545843,0.055090226,-0.0065820375,0.0022360506,-0.007037422,-0.009659099,-0.022774454,-0.022509355,-0.010069146,-0.027344467,0.043699354,-0.04712397,0.032669995,-0.0062834304,0.0201219,-0.017794712,0.029625641,0.018694997,-0.021556886,-0.0033051663,0.047153644,0.05271748,0.013725264,0.06108504,0.0008959819,0.054373406,0.035656594,0.068568155,0.019336317,-0.0067485073,-0.06835504,0.014249737,0.029011978,-0.0050210343,-0.020244211,0.053478464,-0.030704232,0.08245093,0.020397227,-0.088348724,-0.040423814,-0.060476568,-0.016794967,-0.02304551,0.0030564992,0.005888143,-0.077413425,-0.012707865,0.002249996,-0.007455932,0.04290977,-0.026803086,0.020073043,0.0066643846,0.04236854,0.06905883,-0.04163209,-0.010237269,0.028086133,-0.0053119706,0.0309347,-0.015266068,0.056845117,-0.018456971,-0.03709957,-0.012066678,-0.0145639535,-0.017822761,-0.02399061,0.018564293,0.007826468,-0.010481045,0.023617478,0.0042073014,0.029634424,-0.022533642,-0.0073576425,0.033556063,-0.020532947,0.007778142,-0.008878969,-0.06732344,0.02410224,-0.02127509,-0.02514609,0.050209425,0.02473249,-0.018589657,0.02767175,-0.010260523,0.049593527,-0.006893782,-0.028008636,-0.07390752,0.028673243,-0.027383491,-0.008772843,-0.020692991,-0.0138894105,-0.02367156,0.056351114,-0.03327643,-0.06821003,-0.021384107,-0.027798504,-0.027546376,0.009291168,0.032111797,-0.009011699,-0.0028332917,-0.02331636,-0.0057241046,0.010078901,0.00615341,0.036072772,0.010800999,-0.022777746,0.025142087,0.039402474,-0.03509812,0.0060507385,-0.034867827,-0.01505025,0.017430041,0.035139658,-0.015135896,0.023768598,-0.0463997,0.03245463,-0.010026792,0.05985114,-0.015444192,-0.022987887,0.062116247,0.030921219,-0.017578093,0.0137998145,0.056938615,-0.009342464,0.006894852,-0.07127533,0.068813734,-0.02378401,0.018169021,-0.015072761,-0.00034372325,0.025736675,0.024523757,-0.030092454,-0.01527703,0.0053532515,0.024708917,-0.06568592,0.04280665,-0.05275032,-0.009823321,0.029208185,-0.0014733681,-0.02634351,0.02753647,-0.06144411,0.015557624,0.00041159813,-0.030176038,0.02424126,-0.017079258,-0.0068130936,-0.0046285405,-0.012464346,-0.020500962,0.004855432,-0.07298892,-0.036752306,-0.031390548,0.025595784,0.011432838,-0.05071087,-0.013786632,0.0042149355,-0.01042708,-0.0022628105,0.003054083,-0.013561362,0.05797543,-0.0032661525,-0.0059601264,-0.021909688,-0.044769615,0.0036622086,0.0025866535,-0.071062945,-0.06045633,0.008049107,0.00297658,0.051717605,0.0031717813,0.0010386488,-0.0032727409,-0.0009706652,-0.014377907,0.037707467,0.036139183,-0.0036539508,0.046969187,0.047343433,-0.006148947,0.005292245,-0.0039452147,0.03562779,0.015105715,0.03617266,0.0053483318,0.04855229,-0.01422663,-0.1081077,-0.030971825,0.016811851,0.06941091,-0.004428563,-0.010546418,0.010524208,0.0146456575,-0.010028008,-0.038727462,-0.033584625,-0.023204187,-0.028679842,-0.016524063,0.054170877,-0.02626404,-0.037366472,-0.03096706,0.0054211942,0.015549089,0.03758536,0.020664902,-0.03243328,-0.05423731,-0.081404075,-0.014056604,-0.013227101,-0.030586168,0.08548325,0.019921387,0.006469854,-0.0015772514,0.007993845,0.03738707,-0.013426784,0.041188672,-0.018991286,0.049047578,-0.021103682,-0.02157377,0.04612459,-0.015367358]	2026-01-20 16:04:31.089634+05	ЖК GreenLine. Garden. Адрес: г. Астана, бигвилль GreenLine
7491ac46-0f86-48f8-98b3-eb5ab5ce6e73	3907d63c-d9e8-4999-8056-c65d182c1a53	BAIZAMAN	г. Астана, вблизи пересечения ул. Айтматова и Сыганак	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.12773	71.36111	Комфорт+		\N	https://bi.group/ru/landing/baizaman	https://s3.bi.group/biclick/3907d63c-d9e8-4999-8056-c65d182c1a53/3907d63c-d9e8-4999-8056-c65d182c1a53_foto_400.jpg	{"side": "Right", "tags": ["школа", "детский сад", "супермаркет", "аптека", "поликлиника", "автобусные остановки", "удобный выезд на магистрали", "кафе", "рестораны", "банки", "фитнес-центр", "торговый центр", "рынок", "ВУЗ", "сквер", "детские площадки", "спортивные площадки", "салоны красоты", "химчистки", "почта", "банкоматы", "парковки", "АЗС", "СТО", "общественный транспорт", "магазины у дома", "бытовые услуги", "медицинские учреждения", "спорткомплекс", "развлекательный центр", "парк", "вокзал"], "atmosphere": ["семейный", "оживленный", "развитая инфраструктура", "удобная транспортная развязка", "широкие дороги", "возможны пробки", "много магазинов", "доступные цены", "ветреный", "спальный", "зеленые дворы", "городской вид", "хорошая транспортная доступность", "чистый воздух"], "district_name": "Алматинский"}	[-0.02230544,-0.00047715305,-0.0048046215,-0.022159543,-0.020104941,-0.017829556,0.0009742894,0.004765247,-0.04706914,0.038946,0.02238471,0.073331736,0.053765215,-0.009178691,0.017171351,0.020795243,0.021915918,0.02490797,-0.108304806,-0.015637225,0.034511797,-0.016063662,0.04917452,-0.03744729,-0.054545727,-0.049703512,-0.03800827,0.04084313,-0.0008135695,0.006869279,0.03038254,0.032560986,0.009075794,-0.011818873,0.039302148,0.013462803,-0.017647006,-0.052111823,0.04499319,-0.06577875,-0.046735037,0.045090713,-0.008156094,0.0015841009,-0.068526596,-0.049326986,-0.047995742,0.0013966841,-0.028734324,0.015558406,-0.00080914184,-0.036339168,-0.018987661,0.035905134,-0.08460376,0.015364987,-0.029910559,-0.015758721,0.06688828,0.007904054,0.008128043,-0.017695107,0.008329854,-0.04635458,-0.00029584503,-0.004676472,-0.056343563,-0.001987845,-0.05879178,0.0051026824,-0.028359205,0.044151977,-0.06434826,0.03601891,-0.009058264,-0.046739854,-0.0013594741,0.0175064,0.052471537,0.032212753,-0.029834632,-0.008501532,0.0017988756,0.018870337,0.040387694,0.012597239,0.00786533,-0.039357297,-0.073670596,-0.010682098,0.07289245,0.038318813,0.025783498,-0.0091075925,0.0691843,0.02154191,-0.11274412,-0.11831803,0.049127486,-0.021899464,0.017523622,0.023118014,-0.047717147,-0.09538487,0.04846302,0.08452931,-0.07285761,-0.045341853,-0.05864026,0.01712544,-0.0025948521,0.026708405,0.064949065,0.0056974404,0.045943692,0.030413,-0.056333136,0.069926016,-0.012294127,0.031647123,0.03523618,0.014401507,0.0055682864,0.029816238,0.012077969,-0.0021979641,0.0035420207,-0.039336197,-0.0324314,-0.01022625,0.035647064,-0.034527488,0.004528623,0.004610578,-0.048849855,-0.006163284,0.063504755,-0.026721612,-0.012334186,-0.0018705657,0.018129596,-0.01536573,-0.07824825,-0.016015338,0.0076128435,-0.020213734,0.010990013,0.0916456,-0.047530968,0.0006930474,-0.062204435,-0.0011499906,0.041069746,0.0052596964,0.0025692636,0.0061054644,0.070713185,-0.07053522,0.03433787,-0.024444697,0.056401514,-0.03766895,-0.04001185,0.016885709,0.009191163,-0.0026522381,0.027366897,-0.0025347462,-0.033188947,-0.01919455,-0.04072271,-0.08881422,-0.008739534,-0.06816901,-0.003948652,-0.02080098,-0.029535448,-0.019978937,-0.009131118,0.0131062735,0.10711008,-0.009922998,-0.017536521,-0.092394166,-0.0062024007,0.0017672796,-0.029203594,0.056739308,0.07108829,0.012926602,-0.0005253772,0.00531424,-0.007840685,0.05507013,-0.056816675,-0.0118948305,0.036242582,-0.052359607,-0.002160573,-0.03340262,0.05977746,-0.061568327,0.0061494233,-0.024921468,-0.027745811,0.040588133,-0.02525562,-0.07198485,-0.04592509,0.03509768,-0.017865123,-0.027205579,-0.032653216,-0.07557209,0.04276902,0.0077867545,0.0031683377,-0.023905078,0.08534257,-0.07905201,0.006847494,-0.008747753,0.07466493,0.022102783,0.039335936,-0.021012705,0.018073004,-0.008490966,0.0025465009,-0.056783143,-0.017424503,-0.0098327845,-0.0025191414,0.04315683,-0.017871058,0.01956409,0.0015874639,-0.054312512,-0.044116225,-0.010680748,0.0015821825,0.04375456,0.051791646,-0.04143166,-0.0024001603,0.016554955,0.0785979,0.029234,0.04178153,0.0216811,-0.04180391,-0.011655141,-0.011006562,0.0036161377,-0.03875561,-0.060842704,0.0010027641,-0.0009591823,-0.042540185,-0.022923527,0.0030235255,-0.03867768,0.018203376,-0.06812708,-0.059322193,-0.02657412,-0.012891255,0.004107961,0.07369826,-0.037767652,0.07725267,-0.039685506,-0.05147642,0.0076059354,-0.025317153,0.07367388,-0.038844265,0.04531349,0.018085416,-0.034631837,0.04761933,-0.009895051,-0.03059765,0.014287182,-0.00094560685,-0.07277477,0.0003754103,0.03440974,-0.035698984,-0.010963406,0.049488887,0.05697742,0.023130987,0.007003394,0.011760931,-0.024555892,0.030032206,0.059030704,0.0068405666,-0.05053154,0.0054193563,0.044856295,-0.029929545,0.02190669,-0.017108282,-0.030506652,0.0036723346,0.013070338,-0.036266465,0.008217323,0.029439455,0.04281439,-0.07959423,-0.033464532,-0.05471386,-0.013321499,-0.137257,-0.062028628,-0.001291185,0.009464459,0.01770587,0.09221757,-0.019461352,-0.01849096,0.06729697,-0.018985815,-0.034897063,-0.0647733,0.06068087,-0.041975785,-0.0008453906,-0.012974923,-0.026682995,-0.046325628,-0.023158174,0.04411334,-0.09701724,0.0062981336,0.055346757,0.034090046,0.043237533,0.042228322,0.009118561,0.020652464,-0.004951125,-0.008324898,0.015799038,-0.0017123853,0.021041824,-0.00449732,0.011173999,0.042885825,-0.0023337712,-0.051977236,0.021585766,-0.021288244,0.038504507,-0.012966932,-0.002014334,-0.049655776,-0.03134944,0.00969656,-0.014224737,0.025653182,0.0013189983,0.0040625758,-0.011705934,0.04239445,-0.053598132,-0.007265506,0.0044567976,0.023359781,0.018543983,0.000730051,-0.007953923,-0.004940872,-0.052622236,0.026600812,0.020232446,0.0016352461,0.017250884,-0.012904706,-0.003018694,0.0342415,0.0016009358,0.057652216,-0.023984171,-0.0045675253,-0.0320752,0.016807431,-0.011603668,0.0009503376,0.023080131,0.030485786,0.041838728,0.018390793,0.035051655,0.0867446,0.011766019,0.0028288348,0.0055921455,-0.04929514,0.06940769,-0.028040765,0.0004042041,-0.005204916,0.038892414,0.0066438382,-0.020945415,-0.008664683,-0.011446182,-0.032823212,-0.042942513,0.0066491566,-0.028015725,-0.03924453,-0.010536669,-0.03504208,-0.013973741,-0.042508442,-0.0002927884,0.030832667,0.013838417,-0.0306776,0.010666533,-0.07936129,-0.00438687,0.0033097141,0.0006265216,0.025674356,0.07669833,0.043481644,0.030565932,0.055044733,0.015897948,0.060951315,-0.020335011,-0.03811544,-0.017207323,0.018305497,-0.012056332,0.0022489086,0.027542513,-0.0012014421,0.017442103,0.05698044,0.022793394,0.005979833,-0.03688597,-0.028147426,-0.002886107,-0.011372383,-0.0033466262,0.009143152,-0.061963867,0.0044356734,0.031738363,-0.010940937,-0.053610813,0.030644026,-0.053989243,-0.02599738,0.04483661,0.029898377,-0.02530112,-0.00815272,-0.011504716,0.06558859,-0.029288493,0.005249629,0.025539843,0.010915265,0.025316674,0.019041836,0.0040487256,0.009775745,0.047023475,-0.01856409,-0.04305282,-0.03498448,-0.0012268862,0.022707235,-0.0533577,-0.0049421717,0.040110875,-0.05479819,-0.027795214,0.05153123,-0.033982366,-0.017430278,0.010845298,-0.0033179529,-0.011469505,-0.019816864,0.020278817,-0.023996795,0.0343332,0.041855063,0.010556645,0.012594823,0.04976637,0.01615481,0.03325106,-0.069993526,0.015706066,0.03494391,-0.07865458,-0.01071435,0.045210067,-0.003158499,0.028513212,-0.016196974,-0.04702555,0.069797926,-0.033702035,-0.013405943,-0.03626849,0.005925611,-0.0033156406,-0.024701081,-0.045041017,-0.016592469,0.031233752,-0.036928933,0.00039327552,-0.022660365,-0.014013344,-0.038240854,0.020032845,0.016905101,-0.012072896,0.0027832019,0.04722528,0.047661763,0.04681395,0.05125937,0.008501146,0.022252487,0.02264824,0.01108122,0.04194681,0.014307346,-0.053309385,-0.0062420275,0.02554756,-0.035890345,-0.02630557,0.066678256,-0.021288313,0.04604965,0.002460828,-0.032616697,-0.038742553,-0.018336972,0.0072574345,-0.04116583,0.025690163,-0.0036115334,-0.05835452,0.016068585,0.00352098,-0.017708013,0.044810843,-0.021752683,-0.006968094,0.031780537,-0.0030222526,0.050111417,-0.004626706,0.0034725557,0.05184939,0.0032175418,0.02477325,-0.04827579,0.05641919,-0.02910634,-0.06489138,-0.034588028,0.01631626,-0.039403487,-0.060255576,0.023278162,0.006446101,0.0152559485,0.019601732,0.007723229,0.022820443,-0.0273263,-0.034701888,0.013610284,-0.024660727,0.056898773,0.007056811,-0.0601254,0.019132564,-0.0073020654,-0.021880127,0.044827823,0.030187,0.005195994,0.031763643,0.023460874,0.047734622,-0.031200556,-0.018271783,-0.07029716,0.027906649,-0.01139038,-0.028484821,-0.024655525,0.0041444143,-0.016002107,0.034314636,-0.06751871,-0.049658064,0.010953374,-0.022010751,-0.050092623,0.016761465,0.015348982,-0.030420287,0.026342645,-0.019075135,0.0049987654,-0.019089174,-0.0070151943,-0.0031808645,0.008493884,-0.013869651,-0.0048656524,0.024153195,-0.035559382,0.023723338,-0.021955488,-0.028497314,0.034099095,0.02142328,-0.04916666,0.019938085,-0.045843776,0.01469405,0.0012288677,0.06777906,-0.017950715,-0.03900106,0.039477903,0.03147788,-0.029762482,-0.008545832,0.07012741,0.0059693023,0.014976761,-0.036271032,0.09735751,-0.0068877935,0.025858393,0.0068703103,-0.036068358,0.05050541,0.017379558,-0.025246486,0.0075609447,0.006563145,0.0030307944,-0.08131598,0.055856716,-0.01249288,-0.0046270494,0.017954625,-0.014646133,-0.0144952545,0.01431567,-0.024950065,-0.002879463,-0.0048430953,-0.03286719,0.030859888,-0.0073929727,-0.04583268,0.0071972967,-0.03964087,-0.0040029967,0.006010797,-0.07767607,-0.019253252,-0.007169885,0.0033301807,0.051272094,-0.02241131,-0.026121495,-0.0046586036,-0.019955555,0.018900555,-0.0020660628,-0.0017803743,0.035223514,0.010654685,0.0068200375,-0.04629168,-0.0130080525,-0.026193883,0.013567102,-0.06571399,-0.07100157,-0.007496805,0.0029431575,0.029391054,0.033341017,-0.0075732945,-0.01806943,0.010044613,0.021874191,0.024473667,0.053131275,0.005326693,0.040434033,0.023519365,0.0042359727,0.01633766,0.0104990285,0.023983935,-0.0049476777,0.01791669,0.037671454,0.0370458,-0.014541859,-0.0750311,-0.0041564796,-0.008059447,0.074996606,0.019397607,0.011388354,-0.019286707,0.025528328,-0.012075274,-0.030777901,-0.01638591,0.0019110343,-0.027775869,0.018166326,0.05488989,0.018090317,-0.027587784,-0.029400395,-0.03262124,0.008411798,0.033467375,-2.4038598e-05,-0.031013638,-0.039276395,-0.05121976,-0.004881075,-0.016777951,-0.0067779287,0.08190821,0.011661127,0.028281413,-0.035478033,-0.01564036,0.005308255,-0.0013386167,0.041561,0.0022595034,0.04262726,-0.03759844,-0.027487613,0.046496537,-0.01942654]	2026-01-20 16:04:26.970416+05	ЖК BAIZAMAN. Адрес: г. Астана, вблизи пересечения ул. Айтматова и Сыганак
b4334f89-b8ed-47e6-acd5-d023fc10ccb6	aa618151-c212-4dd1-8b68-783ffe7c7d42	AruPark	г. Астана, вдоль ул. E-652	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.05619	71.4247	Стандарт		\N	https://bi.group/ru/landing/arupark	https://s3.bi.group/biclick/aa618151-c212-4dd1-8b68-783ffe7c7d42/aa618151-c212-4dd1-8b68-783ffe7c7d42_foto_400.jpg	{"side": "Left", "tags": ["левый берег", "хан шатыр", "трц green mall", "magnum", "small", "школа-лицей №71", "школа-лицей №78", "binom school", "детский сад рядом", "образовательные центры", "аптека", "супермаркет", "магазин у дома", "озеро талдыколь", "парк гашыктар", "фитнес клуб", "тренажерный зал", "детская площадка", "видеонаблюдение", "безопасный двор", "паркинг", "новостройка", "удобный выезд", "кофейня", "пекарня", "салон красоты", "стоматология", "медицинский центр", "развивающаяся инфраструктура", "тихий район", "чистые улицы", "хорошие дороги", "автобусная остановка", "продуктовый рынок рядом", "фудкорт в трц", "спортивные площадки", "зоны для прогулок"], "atmosphere": ["тихий", "семейный", "развивающийся", "ветреный", "современный", "просторный", "чистый воздух", "широкие дороги", "перспективный", "спальный", "спокойный", "уютный", "открытый", "малоэтажная застройка рядом"], "district_name": "Нура"}	[-0.03615499,0.00020616605,-0.019174226,-0.015024883,-0.018687515,-0.037006095,0.033449084,-0.039158266,0.028595755,0.041136336,-0.01096916,0.023180649,0.04639528,-0.010176757,0.0043753153,-0.00828734,0.04089285,0.033600505,-0.13603579,-0.025257476,0.02109229,-0.02211251,0.06708473,-0.0172817,-0.07052905,-0.034402113,-0.037510727,0.028179744,-0.016860245,-0.021085074,0.04163123,0.054001395,0.030386278,0.012126559,0.034043152,0.0080881165,-0.018687282,-0.035390697,0.009482875,-0.031983532,-0.08137723,0.044780876,0.012851831,0.00076352176,-0.041061215,-0.092662096,-0.05241269,0.01959097,-0.053363543,-0.0025580719,-0.011881358,-0.051913276,-0.013127111,0.028691217,-0.084917784,-0.018626975,-0.010135447,-0.022434717,0.055292577,-0.0038517248,0.02542455,0.008489283,0.00025366907,-0.0344208,0.0010392021,-0.029641587,-0.07802212,-0.021186357,-0.05856401,0.00031708155,-0.022140944,0.07692518,-0.034751743,0.013918986,-0.015490787,-0.01914266,0.01118018,0.0031882774,0.056887694,0.054681208,-0.045829818,-0.022923276,0.03981627,0.021418426,0.028585194,-0.0082281735,-0.001316158,-0.057153635,-0.051270388,-0.05556309,0.086376145,-0.007710165,0.020369668,0.03342551,0.05508792,0.018204914,-0.11771686,-0.068104655,0.087394625,0.031247513,0.008431676,0.022123564,-0.042175878,-0.08239422,0.0018963281,0.0553226,-0.06670707,-0.0375971,-0.064870045,0.0046235644,-0.033947825,-0.0007293284,0.040615536,0.02353374,-0.0021068468,0.022504821,-0.06350355,0.05082108,0.01253244,0.012126754,0.034851424,-0.014983144,-0.011273647,0.027242452,-0.00341033,0.0067281253,0.024645662,-0.014305874,-0.023460578,-0.021399433,0.020727916,-0.03127684,0.014288216,0.0107733775,-9.435812e-07,-0.0034720108,0.056186616,-0.03388235,0.008283181,-9.408801e-05,0.016595306,-0.06579347,-0.053988073,-0.019908855,-0.0050705336,-0.037652593,0.0141542135,0.07229854,-0.06372481,0.02685908,-0.06678739,-0.0068375682,0.032169823,0.010891181,0.013859593,-0.003671011,0.06498112,-0.048819333,0.036815178,-0.041692026,0.063348785,-0.060622633,-0.047941603,0.02418014,-0.004690195,-0.044468615,0.036022488,-0.034683492,-0.017177392,-0.0002560231,-0.047799706,-0.05683504,-0.02329686,-0.08286152,-0.01548039,0.0081748115,-0.043135926,0.028953783,-0.035551745,0.02168289,0.09964534,-0.005395217,-0.011276518,-0.09674589,0.0011917704,-0.011268055,-0.03715433,0.06203948,0.04203934,0.011849227,0.029819688,0.0144346375,0.004370142,0.05532287,-0.062136408,-0.00680792,0.04745341,-0.05567469,0.035451297,-0.055940382,0.046302393,-0.030532716,-0.009264486,-0.04741366,-0.0018218354,0.040963404,-0.020907924,-0.07040186,-0.035440937,0.010084673,0.023376008,0.0055043446,-0.038627584,-0.06022537,0.01654346,0.03642868,0.016864976,-0.040963706,0.089276396,-0.09732762,0.022268154,0.00552633,0.07133427,0.040564183,0.054936733,-0.02731469,0.006090835,-0.028078886,0.007173079,-0.041816458,-0.027938569,-0.035403416,-0.003428439,0.068653055,-0.012069158,0.03344685,0.0016830182,-0.035052214,-0.04842515,-0.0031402216,-0.047619045,0.01972013,0.01468706,-0.019304244,0.008045187,-0.0005560626,0.059040286,0.041692317,0.03345974,0.016992208,-0.060863946,-0.014111782,-0.0062783193,-1.1068924e-05,-0.03815346,-0.060820013,0.011726761,0.009060019,-0.01452085,-0.009167268,0.006164632,-0.013575114,0.014478869,-0.046252336,-0.05856616,-0.04488737,-0.0154396435,0.0031895156,0.070436805,-0.04312871,0.063563086,-0.041068558,-0.029203724,0.008978319,-0.01703921,0.07190521,-0.030565107,0.008713922,-0.010253972,-0.025652878,0.04855696,0.012049104,-0.030194234,-0.0012816825,0.013061992,-0.04165907,-0.015640307,0.022040525,-0.02585149,-0.028501779,0.035328496,0.051950045,0.012406466,0.0101391105,0.038446426,-0.030706597,0.013412165,0.026220784,0.004056164,-0.043446884,0.02213183,0.041417718,-0.024722883,0.032822963,-0.011728616,-0.023877952,0.0016024011,0.011457065,9.519929e-05,0.017075082,0.029587446,0.03718817,-0.03626314,-0.027682373,-0.050119728,-0.010901486,-0.1289184,-0.039647304,0.02046592,-0.014523896,0.02161297,0.074706815,0.017786918,-0.018601697,0.056278437,-0.022361178,-0.013331919,-0.06327367,0.042763818,-0.038549483,0.012833783,0.001050202,-0.0012833013,-0.062136717,-0.023169685,0.04214969,-0.07378721,0.040844016,0.03423422,0.034009073,0.040191423,0.044380214,-0.012350748,0.038430084,0.021787478,-0.014282402,0.005341685,-0.0018848102,0.022043755,-0.0068656197,0.031846743,0.022203302,-0.049555104,-0.088974774,0.035243597,-0.020171816,0.04076243,-0.0037241958,0.002827471,-0.08030901,-0.007724221,0.008870075,0.029344657,0.013704342,-0.0029141188,0.0028621657,0.0009802014,0.046432283,-0.05696769,-0.01966795,0.009640951,0.03159781,-0.001017289,-0.006755958,-0.02417981,-0.00070033956,-0.033909757,0.005940684,0.03527683,-0.02447142,-0.018653277,-0.013004087,0.0060111233,0.011323138,-0.01133646,0.053078547,-0.035207283,-0.051192474,-0.020825658,-0.0056125415,-0.024899896,0.035314515,0.009287158,0.045405176,0.021786224,0.03307031,0.053797685,0.07033695,0.05723571,0.04017194,-0.00053792493,-0.017906792,0.060988586,-0.03735061,-0.027650768,-0.032699358,0.040404357,-0.00045309693,-0.0291711,-0.0045631137,-0.044334006,-0.029420523,-0.04317772,0.039445676,-0.04119835,-0.028584987,0.003972712,-0.032744464,-0.0015222327,-0.028170278,-0.0277162,0.052463572,0.039692663,-0.019323997,-0.0017830902,-0.0808187,-0.015957078,-0.01421708,0.0065154545,-0.011777886,0.041870926,0.056979638,-0.0015419736,0.0073956395,0.045160826,0.06970042,-0.014410728,-0.04756522,-0.03535959,0.03277955,-0.028413119,-0.009117236,0.020241732,-0.008082522,0.006570876,0.04213352,0.04420421,0.020179268,-0.028141415,-0.010899723,-0.009165426,0.0058898344,0.018221866,0.023795944,-0.060733788,-0.005760298,0.024867749,0.015548956,-0.048375014,0.028688038,-0.06189395,-0.04093276,0.040735673,0.016414594,-5.814318e-05,0.017857308,-0.003535462,0.04869466,-0.016052205,0.019198924,0.056443088,-0.0070881527,0.036133595,-0.005647234,0.027920477,-0.014489385,0.020111008,-0.0055644787,-0.04038185,-0.05014874,-0.025522606,0.027460093,-0.046991684,0.0034051188,0.052344393,-0.015529914,0.01869878,0.029100128,-0.0060290773,-0.029645205,0.012252136,-0.024242975,-0.02931856,-0.042423155,0.029955015,-0.013908209,0.026262583,0.043345746,-0.011335621,0.004722697,0.049200352,0.012865863,0.045890216,-0.05396018,-0.013774685,0.048337296,-0.051608685,-0.0025521924,0.0539107,0.037711065,0.0072078197,-0.02828681,-0.0103590805,0.04740774,-0.007052975,-0.0045201117,-0.04332416,0.045723993,-0.011431457,-0.004656671,0.0014834877,-0.047070608,0.02816193,-0.03665017,0.00684329,-0.026564889,0.025566082,-0.027293421,0.0090972325,0.016935525,-0.02183617,0.009481236,0.04574981,0.046893723,0.02111667,0.030154772,-0.018069103,0.040440224,-0.0023927225,0.04489513,0.019906092,-0.023126984,-0.054769143,0.024515335,0.030751988,-0.02423732,0.009697328,0.06987965,-0.03162487,0.07697518,0.016497051,-0.059539754,-0.033456277,-0.05197244,-0.008614857,-0.029775357,0.019716423,0.00798967,-0.077625245,0.0067272726,0.025694015,-0.023366828,0.04218395,-0.0231136,-0.011115894,0.0111466395,0.04413267,0.064458646,-0.034809794,0.010566609,0.02349499,0.004644577,0.02135641,-0.06125251,0.0470155,-0.017274857,-0.059519164,-0.013204038,-0.023864312,-0.036261443,-0.032852367,0.022586549,0.042069066,-0.008716065,0.0011246382,0.025760034,0.041331574,-0.0070577213,0.001942833,0.022522572,-0.028296938,0.037189398,-0.0075680185,-0.057042792,0.02238623,-0.00039355908,-0.019231739,0.039435033,0.058195338,0.013106301,0.04282244,0.01018891,0.04859681,-0.008446334,-0.024115166,-0.045115605,0.025806969,-0.032883253,-0.020276906,-0.045175508,-0.031623382,0.0055580107,0.04193199,-0.04344331,-0.047280785,0.0011276597,-0.022881307,-0.045553405,0.039231077,0.024130573,-0.018198874,0.011555813,-0.0011328271,0.017205082,-0.017000739,-0.0027636138,0.012539791,0.02436513,-0.028600875,0.0017642577,0.057144795,-0.049946472,0.0141391745,-0.03973428,-0.018550156,0.035290793,-0.0027470884,-0.033172254,0.04978257,-0.053660646,0.023943767,-0.01643283,0.061002232,-0.020483175,-0.030830966,0.068395436,0.04103137,-0.00052265957,0.013720767,0.046602894,-0.0035057836,0.032475423,-0.0460119,0.089585975,0.005069624,-0.0059795426,-0.022664897,-0.039527357,0.04712628,0.02322952,-0.030891994,-0.009017522,-0.010045199,0.010345853,-0.046586473,0.055471435,-0.03712636,0.0061200215,0.019875467,-0.012346143,-0.036046803,0.021574209,-0.026606902,0.02479525,-0.011745136,-0.0057030777,0.02886889,0.01976011,-0.01877782,-0.008747399,-0.008627147,-0.0038945505,0.019378295,-0.06982426,-0.011269296,0.02926006,0.044174816,0.019901818,-0.021255584,-0.02551089,0.017139578,-0.023933928,-0.032630138,0.016587378,-0.012415021,0.027892567,-0.0062679444,-0.015993059,-0.059233814,-0.026882946,-0.014295144,-0.00060463406,-0.08089045,-0.06003678,0.010338555,0.0040886556,0.01973687,0.012702868,0.0031489616,-0.00945784,-0.00537187,0.0013911058,0.021900153,0.0324407,-0.0002974339,0.044065934,0.02052773,-0.012338703,0.0050669136,-0.014631211,0.050965548,-0.010326571,0.044966336,0.009927043,0.059515674,-0.017758284,-0.08126147,-0.024510385,-0.009095685,0.07072419,-0.0046031205,0.013585277,0.003875976,0.03684445,0.013884403,-0.04325808,-0.0087537365,-0.015029547,-0.019751545,-0.01605262,0.058031797,-0.0054881675,-0.049125638,-0.04654897,0.0035953058,-0.016856752,0.027769454,0.021856967,-0.043883134,-0.037833318,-0.06112282,-0.027803747,0.021769408,-0.031863112,0.07870897,0.019621134,0.01190924,-0.01474461,-0.040060855,0.0011262273,-0.014037759,0.04690304,0.0124536315,0.06977798,-0.046164237,0.0067712725,0.046396814,-0.027173538]	2026-01-20 16:05:28.158302+05	ЖК AruPark. Адрес: г. Астана, вдоль ул. E-652
dbdae371-974f-48c5-a2a7-f4952e1ec47f	b69fb8a9-7a3a-11ef-a830-001dd8b72708	Arena Style	г. Астана, вблизи пересечения пр. Туран и ул. Бухар жырау	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10616	71.39352	Комфорт+		\N	https://bi.group/ru/landing/arena-style	https://s3.bi.group/biclick/b69fb8a9-7a3a-11ef-a830-001dd8b72708/b69fb8a9-7a3a-11ef-a830-001dd8b72708_foto_400.jpg	{"side": "Left", "tags": ["Астана Арена", "велотрек Сарыарка", "ледовый дворец Алау", "Дворец спорта Казахстан", "ТЦ Mega Silk Way", "выставочный центр EXPO", "Назарбаев Университет", "НИШ", "школа рядом", "детский сад рядом", "супермаркет Magnum", "супермаркет Small", "аптека рядом", "Ботанический сад", "парк рядом", "фитнес-центр", "кафе", "ресторан", "банки", "остановки общественного транспорта", "современная застройка", "спортивные объекты", "развлекательные центры", "медицинские учреждения", "детские площадки", "велодорожки", "прогулочные зоны", "бизнес-центры", "государственные учреждения", "фудкорт", "кинотеатр", "салон красоты", "химчистка", "АЗС", "автомойка", "офисные здания", "детские развивающие центры", "поликлиника", "стоматология", "спортивные секции", "кофейни", "пекарни", "банкоматы"], "atmosphere": ["современный", "развитый", "активный", "деловой", "молодежный", "семейный", "ветреный", "широкие дороги", "чистый воздух", "красивый вид", "развитая инфраструктура", "многофункциональный", "динамичный", "перспективный", "комфортный"], "district_name": "Есильский"}	[-0.0153978225,0.0076218573,-0.01970044,-0.019260487,0.0012250455,-0.014228316,0.018121095,-0.032346897,-0.001119704,0.05234309,-0.0025028572,0.0400997,0.0556216,-0.031860277,0.0037447533,0.020671409,0.045514736,0.055390306,-0.1272373,-0.04022768,0.018497344,-0.026652774,0.04027258,-0.020515494,-0.050462283,-0.03743585,-0.056770317,0.018175535,-0.012486626,-0.009065925,0.020367729,0.048459724,-0.004958181,0.024132775,0.02368408,0.009094622,-0.043098465,-0.05581545,0.025974907,-0.014897544,-0.05357004,0.04702991,0.007048233,0.014104263,-0.074278094,-0.085533544,-0.03446145,0.0076001585,-0.030279277,-0.0144000845,0.00017118674,-0.05511952,-0.033205613,0.031366367,-0.05066229,-0.00092051155,-0.02806347,0.0011765092,0.069894396,-0.009595481,0.01537446,0.008259625,0.019461438,-0.020267889,0.0065702577,-0.025891816,-0.05476573,-0.0066810404,-0.05060895,0.02819485,-0.02244566,0.10491227,-0.045016997,0.0054562544,-0.0018673536,-0.021666933,0.009190664,0.021871272,0.044063177,0.05653688,-0.05389085,-0.0023671787,0.03184199,0.0059516025,0.023254022,-0.0041076895,-0.0007581577,-0.026849424,-0.05711571,-0.044685613,0.06088511,0.037459906,0.03553699,0.05024048,0.07290428,0.0094522135,-0.12742522,-0.12002844,0.05406866,0.029659735,0.025828544,0.030410739,-0.048733637,-0.052333098,0.017254487,0.06463234,-0.07131805,-0.05426292,-0.06414979,0.024109086,-0.000993314,-0.013151299,0.025485856,-0.0009107314,0.010917668,0.045144346,-0.08331121,0.055310827,0.014364325,0.023307184,0.027165018,0.019510191,-0.014959535,0.029429067,-0.017477147,0.018076818,0.012973693,-0.049492728,-0.049222436,-0.021174556,0.024481537,-0.036931973,-0.015913978,-0.027443646,-0.04005561,0.00151439,0.0702385,-0.022108866,0.008834342,-0.021095712,0.02756253,-0.0327491,-0.03643507,-0.017586235,-0.002118721,-0.027008457,0.011092025,0.06073422,-0.0398974,0.006385635,-0.06406216,-0.029120801,0.022749498,-0.00074410933,0.026008185,0.008209536,0.08180823,-0.03707228,0.051582746,-0.03335167,0.074615,-0.052931666,-0.036381893,-0.0133342715,-0.010841377,-0.0042419215,0.036860336,-0.021967405,-0.030674063,0.008637057,-0.03225705,-0.049967285,-0.014698115,-0.080405146,-0.007809036,0.0012107034,-0.04626863,0.0070105344,-0.012814382,0.027474185,0.12190829,-0.02227945,-0.018913912,-0.056903917,0.011978732,-0.0036674154,-0.021658314,0.057314225,0.043273516,0.013831445,0.0012419663,0.014754274,-0.0025670205,0.040702574,-0.041679084,-0.034665283,0.048873104,-0.052761097,0.004035698,-0.06183708,0.03589869,-0.02492194,-0.020407135,-0.018563682,-0.032942954,0.040484216,-0.020067839,-0.06924459,-0.047624663,0.033323612,0.01583042,-0.04195651,-0.036084138,-0.04160076,0.02689912,0.022024227,-0.0016461582,-0.0007680574,0.10659219,-0.093842015,-0.001747759,0.0018753692,0.06715378,0.04459357,0.07546066,-0.011240864,-0.02072995,-0.025199864,-0.011367437,-0.044324547,-0.029590447,-0.0032692796,0.009585739,0.052492272,0.0015702276,0.045652516,0.0042104963,-0.064417295,-0.027150229,-0.041598402,-0.034429103,0.032890372,0.032104325,-0.019360904,-0.004053177,0.006426217,0.060657237,0.03405093,0.041051004,0.024513341,-0.04290745,-0.010890994,0.005394914,0.01175604,-0.046634167,-0.059389517,0.032163553,0.0030113945,-0.036788628,-0.027133401,-0.015287223,-0.026052263,0.02121519,-0.064979546,-0.05490657,-0.03762136,-0.032385662,0.023745632,0.0690699,-0.03931491,0.07685974,-0.03470517,-0.03399997,0.011334338,-0.012985471,0.06925817,-0.04334173,0.03544488,-0.011767356,-0.042250708,0.034135427,-0.0033857578,-0.038999595,0.0035084344,0.035310343,-0.06837937,-0.0010343818,0.015062674,-0.028750781,-0.03862398,0.046412576,0.043660365,0.019580616,-0.0015055574,0.014185162,-0.05045467,0.021583714,0.03266693,0.014352992,-0.057112962,0.01334923,0.056445964,-0.04510863,0.023805382,-0.010219782,-0.036127567,0.007074907,0.019534763,-0.034892626,0.017080035,0.011569769,0.026682785,-0.05984314,-0.044640828,-0.051257517,0.0045308378,-0.13642405,-0.04433653,0.0067757363,-0.014799727,0.013076554,0.07106705,-0.013576554,0.0047870046,0.04173464,-0.018731661,-0.027160838,-0.025707753,0.04187255,-0.035236303,-0.002021947,-0.0078545185,-0.012512404,-0.045607828,-0.017688876,0.011373678,-0.07737899,0.002536871,0.05170808,0.018177923,0.052293688,0.038043603,0.0032193644,-0.0020601102,0.0017969749,-0.026427655,-0.0025738985,0.016279906,0.023013001,0.017055098,0.012043966,0.0140814325,-0.054955263,-0.053714562,0.031506337,-0.030498046,0.040809274,-0.00139336,-0.020166185,-0.076446645,-0.020726675,0.0042760656,0.00082476373,0.03580679,0.041113436,0.010818514,-0.018024033,0.05036486,-0.036324546,0.008670057,0.021307075,0.027922692,-0.0007387845,-0.003071969,-0.01359511,-0.008766565,-0.02397912,0.023002036,0.04000754,-0.011401632,0.008452282,0.0053236163,-0.0017908524,0.03532033,-0.012733264,0.059050523,-0.034111407,-0.011800793,-0.043466408,0.0024103639,0.013787313,0.011715179,0.013927683,0.055224374,0.018881626,0.017585507,0.05239683,0.07442773,0.03638061,0.012172505,-0.017201208,-0.01942211,0.09703219,-0.038555093,-0.00081168575,-0.027447935,0.070095524,0.023478441,-0.014704745,0.011237377,-0.018834712,-0.023684323,-0.022262063,0.010317759,-0.042800806,-0.017291795,-0.009988743,-0.025126006,0.009450769,-0.0329312,-0.03330469,0.04383891,0.033209164,-0.0014795603,0.011121205,-0.09522789,-0.015748661,0.0031940173,0.008899628,-0.006612348,0.038701363,0.029761685,0.0032084787,0.041501824,0.032704275,0.07493468,-0.008796134,-0.03304866,-0.032773133,0.018979834,-0.022862788,-0.004889348,0.02948491,-0.0131833535,-0.016736364,0.03651587,0.054307304,0.0067759044,-0.0055446336,-0.027848136,-0.0124496,0.010277424,-0.0034220174,0.017173443,-0.06913998,0.020906571,0.034348488,-0.000118744436,-0.05220358,0.015573656,-0.046815775,-0.020887138,0.050952815,0.035882715,0.006983996,0.033829745,0.0047372635,0.06842793,-0.028184196,-0.0042198035,0.054853894,0.0083904695,0.036387254,0.02201671,0.028258687,-0.0072039184,0.014414623,-0.018700691,-0.04590141,-0.030593855,-0.01757143,0.0053977715,-0.056582816,0.00070346444,0.04242238,-0.034776293,0.006659924,0.048122443,-0.03057103,-0.040082175,0.0066913352,-0.0009308374,-0.019064432,-0.03659686,0.022778206,-0.020526081,0.054611523,0.041089546,0.004516881,0.020320272,0.051594824,0.024508119,0.017279757,-0.0706854,0.015224622,0.0753032,-0.06624318,0.016681692,0.053019065,0.022689207,0.026720399,-0.029778553,-0.027840698,0.05429771,-0.011547651,-0.016690908,-0.037820525,0.0012551935,0.018644262,-0.01847077,0.00043073192,-0.017955948,0.041650373,-0.053479895,0.010868914,-0.007043026,-0.015899401,-0.021093592,0.01708401,0.014870935,-0.022999665,-0.0044615134,0.041172035,0.04743601,0.031194227,0.07823462,0.017510844,0.04309183,0.0075113596,0.04226364,0.013890468,-0.0027199541,-0.053525962,0.009994596,0.024599671,-0.036942836,-0.026146227,0.073150136,-0.033693574,0.06340086,0.014805448,-0.057591412,-0.032331936,-0.05173301,-0.003610483,-0.028133063,0.013899689,0.008934241,-0.07829292,0.00805986,0.024841717,0.005383132,0.05656033,-0.008195259,0.0024902422,0.029774541,0.046654638,0.055829626,-0.021953832,0.012401771,0.02277673,-0.0011957831,0.02253206,-0.027966902,0.03581405,-0.02460244,-0.039519835,-0.016316686,0.0012369874,-0.023035048,-0.02843542,0.010648734,0.029630011,-0.015979169,0.015831755,0.009542161,0.038385257,-0.03448047,-0.021491934,0.021327896,-0.004687666,0.029497597,-0.0011292924,-0.054791518,0.0021930614,0.006618746,-0.027016051,0.056287445,0.029231735,0.011716445,0.036226686,0.0029335148,0.047690872,-0.0064021647,-0.0230538,-0.0612301,0.033027053,-0.015719535,-0.017426694,-0.026942402,-0.032569908,-0.017163154,0.044925526,-0.043817136,-0.042681605,0.0032159982,-0.034030948,-0.027101468,0.012419787,0.016889887,0.002086384,0.005886059,-0.019780137,0.010101716,-0.0016939926,0.021264233,0.04578444,0.01068359,-0.012147102,0.007501309,0.03802425,-0.026758624,0.0069759255,-0.0408458,-0.0046207127,0.018348236,0.025240088,-0.029458167,0.026065243,-0.053898145,0.03185974,0.0070928573,0.06716743,-0.02446919,-0.015189401,0.06838239,0.038046397,0.00073560374,-0.004939529,0.06829793,0.009308836,0.03776676,-0.05693016,0.06838308,-0.017595714,0.019036738,-0.0052601844,-0.011012927,0.025711112,0.04739701,-0.006343963,0.0071281167,-0.0009221012,0.03362534,-0.06549208,0.059745524,-0.063635126,-0.022611719,0.027675502,-0.0014424841,-0.030234711,0.019273637,-0.045088295,0.05034876,-0.010359934,-0.031192929,0.014717161,-0.020164495,-0.014962778,0.01139081,-0.015462918,-0.011442131,-0.0052807047,-0.07786605,-0.014104591,0.021916026,0.018584134,0.022741357,-0.04833753,0.0012091835,0.015473211,-0.01815089,-0.013344304,0.022896191,-0.00046805272,0.0507146,0.004728472,-0.00934186,-0.024018144,-0.027316594,-0.021433374,-0.0004627987,-0.060560647,-0.06338055,0.019040983,0.02236925,0.061071742,0.023059247,-0.017573575,-0.0016579177,0.0075700204,0.005522122,0.013903763,0.024022717,0.027251923,0.06844212,0.040298976,-0.0058151227,0.0007844924,0.0070505165,0.012907818,-0.009375234,0.03446736,0.004271855,0.03977809,0.0038083591,-0.069166586,-0.011189636,-0.007907328,0.07432765,-0.0056010117,-0.009455332,-0.0016539064,0.028450804,0.0019710865,-0.018247502,-0.015795834,-0.0211006,-0.032551195,-0.02110998,0.044723384,-0.02228247,-0.038170885,-0.049749963,-0.011819964,0.0019782828,0.03782088,0.022449883,-0.033573307,-0.053706672,-0.06015038,0.00830108,-0.0056659095,-0.036497593,0.09015942,0.015702106,0.014569498,-0.008519812,-0.008419316,0.03678907,-0.013719597,0.06277045,-0.0027138614,0.06796462,-0.034898188,0.00041873546,0.057259817,-0.024334494]	2026-01-20 16:05:02.047203+05	ЖК Arena Style. Адрес: г. Астана, вблизи пересечения пр. Туран и ул. Бухар жырау
94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7	0b54c53f-5c3c-4ba4-97d8-ee5723b87227	Alem Sana	г. Астана, пересечение пр. Туран и Кабанбай батыра	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.0746	71.37829	Комфорт+		\N	https://bi.group/ru/landing/alem-sana	https://s3.bi.group/biclick/0b54c53f-5c3c-4ba4-97d8-ee5723b87227/0b54c53f-5c3c-4ba4-97d8-ee5723b87227_foto_400.jpg	{"side": "Left", "tags": ["expo_рядом", "тц_mega_silk_way", "университет_назарбаева", "национальный_музей", "президентский_парк", "ботанический_сад", "нур_алем", "астана_арена", "ледовый_дворец_алау", "велотрек_сарыарка", "линейный_парк", "школа_рядом", "детский_сад_рядом", "супермаркет_рядом", "аптека_рядом", "кафе_рестораны", "медицинский_центр", "остановки_общ_транспорта", "бизнес_центры", "банки_банкоматы", "фитнес_центры", "салоны_красоты", "заправки", "автомойки", "современная_застройка", "развитая_инфраструктура", "новые_дороги", "детские_площадки", "спортивные_площадки", "прогулочные_зоны", "велодорожки"], "atmosphere": ["современный", "развитая инфраструктура", "шумный", "деловой", "семейный", "молодежный", "зеленый", "ветреный", "широкие дороги", "чистый воздух", "пробки", "красивый вид", "улицы чистые", "дороги хорошие"], "district_name": "Есильский"}	[-0.008399071,0.0075065442,-0.008043706,0.00033135686,-0.0067721824,-0.01348089,0.029452877,-0.014950426,-0.013535064,0.056612685,-0.011583193,0.046050914,0.041782465,-0.046443023,0.006206983,0.016675219,0.03920256,0.029204076,-0.11784818,-0.01984361,0.010631929,-0.03518862,0.04358419,-0.017265161,-0.04717032,-0.038204934,-0.0481056,0.020033488,-0.0029199212,-0.003949296,0.03335779,0.058899328,0.01564559,0.011388893,0.04127476,0.030553225,-0.022131925,-0.04864817,0.030085607,-0.015014381,-0.06958266,0.031679943,-0.014214439,0.017978318,-0.078625925,-0.07044434,-0.025780918,0.022622515,-0.024733556,0.012154533,0.010409178,-0.055694055,-0.02074672,0.048612285,-0.07886342,-0.010153099,-0.015904972,-0.0027112914,0.055279672,0.0005425441,0.013186863,0.0047746035,-0.0076365503,-0.018546801,0.02967118,-0.0051835747,-0.05285763,-0.00430618,-0.08327107,0.013694014,-0.047193047,0.071480125,-0.067860276,0.02269172,0.008215056,-0.017186347,-0.0066723228,-0.0028345166,0.037141297,0.04941922,-0.06191035,0.015006134,0.02463141,0.022856057,0.029600484,0.00063770456,0.008297488,-0.022732941,-0.07254106,-0.005257828,0.078029834,0.04339371,0.04198678,0.04724359,0.07634999,0.0132578155,-0.13257149,-0.09870729,0.074214704,0.020828605,0.013854513,0.022578226,-0.036663335,-0.07090795,0.008053881,0.061973486,-0.07272942,-0.054492477,-0.06696485,-0.00021940413,0.0018434775,0.005927599,0.030696103,0.0007551803,0.021993296,0.024117239,-0.06353064,0.044582017,-0.017803704,0.024037588,0.022974228,0.0127013195,-0.00137922,0.044712026,0.0014814129,-0.008698248,0.021693919,-0.055028006,-0.03648516,-0.020554984,0.0377058,-0.021257287,0.01589783,-0.009344493,-0.06487344,0.036377057,0.07457181,-0.03369191,0.011684298,-0.025057107,0.014573281,-0.037598163,-0.08877478,-0.0075420565,-0.00039273503,-0.036381133,0.01953412,0.06587823,-0.04805008,0.02729218,-0.059204504,-0.019675134,0.01348198,0.010921558,0.010749047,0.015119671,0.071688764,-0.049725715,0.0076667718,-0.05333388,0.0545601,-0.044309318,-0.013385629,0.015954467,-0.00642632,0.0125579825,0.034342863,-0.013481265,-0.033552665,0.026234185,-0.03734733,-0.06376101,-0.017335365,-0.05693244,-0.014696327,0.022815669,-0.043998312,-0.02162851,-0.019151865,0.0020482005,0.11719442,-0.01337703,-0.008454105,-0.081165366,-0.0037668594,-0.008545393,-0.03596961,0.049391404,0.037655693,-0.02041562,0.010258804,0.017348403,-0.0133738,0.037196178,-0.053452507,-0.048907038,0.044785447,-0.06198977,0.022523822,-0.07254083,0.051346757,-0.05225574,0.004178471,-0.020292081,-0.031126644,0.04696127,-0.024735676,-0.0449378,-0.038144052,0.039301537,-0.006629121,-0.044756792,-0.040280737,-0.091730595,0.03528438,0.029837474,-0.0038823443,-0.023570193,0.097995915,-0.061511066,-0.015454169,0.014428693,0.040004686,0.05129198,0.0675593,0.015620534,0.0031775804,-0.017019557,-0.0038775469,-0.04424551,-0.05073194,-0.02092442,-0.009677124,0.041708857,-0.019352386,0.039840125,0.0065481765,-0.061896898,-0.025170377,-0.017751453,-0.013942685,0.024794957,0.04544378,-0.0026625774,-0.00020301163,-0.006474492,0.045111995,0.041728746,0.05450606,0.011120798,-0.042424005,0.016467636,-0.03144595,-0.003334107,-0.058311112,-0.037151236,0.02184727,0.0036362042,-0.031524777,-0.007789418,-0.01312276,-0.04910136,0.0100545585,-0.07445871,-0.045425616,-0.014741421,-0.021596286,-0.0061063115,0.07169054,-0.019649496,0.07958906,-0.039202843,-0.017020892,0.0037668755,-0.045198213,0.056158863,-0.047158398,0.04094956,0.003407636,-0.060609724,0.02477469,-0.010456555,-0.025796281,0.010860319,0.010016265,-0.061302617,-0.0029843706,0.024111342,-0.02554284,-0.03877412,0.03566413,0.047295667,-0.005011022,-0.021379687,0.025682617,-0.036529195,0.014755069,0.039512526,-0.012544112,-0.03354213,0.013077431,0.05202538,-0.05319948,0.031551994,0.0082127955,-0.009081687,-0.0139736915,0.02020567,-0.029133635,-0.0051011806,0.039466172,0.027801573,-0.0585349,-0.05509323,-0.013524203,-0.010299493,-0.15247707,-0.04171139,-0.004094225,-0.02031419,0.014065428,0.067087874,-0.02435477,-0.01620165,0.044708624,-0.01757237,-0.022250023,-0.04162439,0.053132918,-0.014151891,0.009674182,-0.0019611707,-0.021456733,-0.032756865,0.014559445,0.03741784,-0.069699325,0.012511102,0.06260386,0.02095115,0.056446567,0.03272336,0.008915914,0.037210573,-0.011816477,-0.03082634,0.012627148,0.0060483613,0.02902109,0.008765268,0.0131966155,0.021469628,-0.035674967,-0.04519483,0.024649957,-0.008767262,0.04080865,0.0022221988,-0.010375252,-0.06292248,-0.006200003,0.007363363,-0.0048909155,0.014794323,0.031317566,0.018056806,-0.014169,0.036750715,-0.06831215,-0.013998277,0.008595291,0.047671024,-0.011010382,-0.001988514,-0.043440077,-0.011125261,-0.06062101,0.002662714,0.030486034,-0.0053079897,0.008968541,0.024226096,0.016411424,0.035454404,-0.011177686,0.06813236,-0.040319,-0.023273766,-0.032331165,-0.0027793786,0.008876612,0.022001086,0.014414438,0.022812797,0.007119227,0.02002307,0.044820875,0.08710424,0.028657498,0.014644016,0.007361792,-0.036173355,0.09102121,-0.036057368,-0.011366017,-0.017598968,0.060353596,0.019900745,-0.00864333,0.022974629,-0.027872026,-0.03940026,-0.025111465,0.023332966,-0.0149711985,-0.019672716,0.010463156,-0.01677218,0.018295266,-0.019903457,-0.006773628,0.028240172,0.03714274,-0.009654594,0.015260806,-0.08108392,-0.018966071,-0.0007214411,0.007836437,-0.008018573,0.049621303,0.046155073,-0.0038933405,0.0703612,0.036060985,0.062279858,0.0013330623,-0.017661696,-0.029336914,0.021917734,-0.029072357,0.0055646244,0.00879136,-0.012128768,-0.0065756785,0.033337317,0.06184077,0.01972902,4.5187753e-05,-0.025038408,-0.002303722,-0.013716473,-0.009973638,-0.01235227,-0.07488867,0.034960162,0.009470196,0.00544219,-0.046998583,0.02918454,-0.05918776,-0.024314938,0.063311614,0.022286896,0.0043221726,0.03818246,0.013061584,0.07326266,-0.035919856,-0.015097283,0.060523883,0.01979127,0.039707277,-0.0019985219,-0.0020931766,0.00061279413,0.023192722,-0.015136969,-0.031780172,-0.04852268,0.00030714573,0.013914912,-0.05229257,0.012665016,0.05271451,-0.05531367,-0.012495428,0.0332907,-0.035700716,-0.021737097,-0.014954435,0.0038770076,-0.025400981,-0.035293512,0.029749649,-0.003498879,0.044881728,0.023591489,-0.0127302315,0.0037614463,0.05192277,0.020776575,0.006497078,-0.05345023,-0.005026436,0.08185905,-0.057250015,-0.0013805686,0.06843028,0.024357598,0.023201928,-0.03459387,-0.014308854,0.04008646,-0.024470204,-0.030036556,-0.035982627,-0.022999043,0.0007999947,0.010875255,-0.004210523,-0.011819797,0.06229017,-0.033718385,0.007035944,-0.0066728783,-0.011879339,-0.036411807,0.036628626,0.0052467217,-0.035413638,-0.01745755,0.057935353,0.033222504,0.03248291,0.06083876,0.021782948,0.04324242,0.0040175137,0.029600265,0.015736125,-0.018037036,-0.021530712,0.033277456,0.019282948,-0.01903906,-0.02054068,0.072299704,-0.056735363,0.07008328,0.019567564,-0.06804503,-0.06560893,-0.031536974,-0.021737568,-0.025112074,0.024539568,-0.021997463,-0.08180855,-0.03307801,0.007854796,-0.01173602,0.022976534,-0.021436239,-0.0050976644,0.016706908,0.02416272,0.07928835,-0.028594377,0.02592691,0.024737729,-0.022302167,0.02620273,-0.040446978,0.02976964,-0.04645891,-0.055512667,-0.028619118,-0.00034509017,-0.034162324,-0.021370966,0.014417347,0.01583229,-0.0050184177,0.033708926,-0.010747343,0.025755154,-0.02974074,-0.02262115,0.023513336,-0.011397745,0.049520485,0.0048418664,-0.04658743,0.037454892,0.00048486335,-0.039183915,0.045396786,0.0353571,0.0004866883,0.035354502,-0.013144841,0.05616273,-0.021697618,-0.03259522,-0.046856586,0.0061048847,-0.009462109,-0.038723033,-0.02882221,-0.01935301,0.0005079926,0.042172316,-0.04930216,-0.060416818,0.005656067,-0.02451964,-0.040090874,0.020810803,0.03814683,-0.015763337,0.02642302,-0.027821673,-0.002993407,-0.008942919,0.0012619589,0.036321115,-0.008904267,0.0048441943,0.015411713,0.039513823,-0.018818462,0.017552193,-0.01729392,-0.009273094,0.022155417,0.008467353,-0.041171968,0.020712642,-0.035420682,0.011860801,-0.0025254267,0.03288352,-0.01798205,-0.03105891,0.054291807,0.032159757,-0.0130288815,0.01871868,0.08142001,-0.00021503115,0.005131175,-0.035730973,0.071954064,-0.016023658,0.021906195,-0.00092035887,0.00013290656,0.03419269,0.024764452,-0.013654296,-0.028074713,0.0036674773,-0.01300586,-0.056065418,0.042428,-0.057215817,-0.008167362,0.037947606,0.01865406,-0.0077114,0.01703952,-0.05801056,0.033076353,-0.0063608913,-0.054155376,0.057914943,-0.020025607,-0.029855246,0.0081956135,-0.020706397,-0.01100573,-0.0021952793,-0.08125702,-0.005133812,-0.0127485655,0.01704656,0.025430808,-0.02531809,-0.004016046,0.0014523615,-0.020122431,-0.021373447,-0.022236304,-0.014671899,0.046170533,-0.017623577,-0.008105174,-0.020401541,-0.0152074415,-0.009592898,0.010179084,-0.04801501,-0.07290979,-0.010552424,-0.008682224,0.04730467,0.037609402,-0.0016059264,-0.003923831,0.013013264,0.00075852696,0.024159085,0.02589906,-0.01090186,0.06341601,0.033064958,-0.013428379,-0.0052792174,0.0122032715,0.019254992,-0.017021738,0.033553813,0.0051738718,0.05559215,-0.03129213,-0.06078894,-0.0071542277,-0.027645258,0.08362971,-0.002722351,0.0039436417,-0.0026613025,0.023671133,-0.0030612838,-0.036087595,-0.05109859,-0.002687188,-0.014669514,-0.014813565,0.048275575,-0.017097618,-0.05030709,-0.029986372,-0.03557049,0.022400677,0.028481288,0.025157265,-0.025018612,-0.0460019,-0.056379385,0.004918788,0.008170324,-0.010571104,0.06822865,0.012791311,0.04194123,-0.008497836,0.0034880294,0.011353024,-0.018465765,0.059263386,0.009204154,0.056682583,-0.020573216,-0.016239012,0.047069922,-0.029236794]	2026-01-20 16:04:53.852967+05	ЖК Alem Sana. Адрес: г. Астана, пересечение пр. Туран и Кабанбай батыра
2c634fd9-680c-4b67-82a8-8966608baa8d	9bccb06e-2545-11e9-80d9-00155d101f25	Atlant	г. Астана, ул. Д. Конаева, 5 	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13481	71.41897	Бизнес+		\N	https://bi.group/ru/landing/atlant	https://s3.bi.group/biclick/9bccb06e-2545-11e9-80d9-00155d101f25/9bccb06e-2545-11e9-80d9-00155d101f25_foto_400.jpg	{"side": "Left", "tags": ["Байтерек", "Водно-зеленый бульвар", "Нуржол", "Ак Орда", "Министерства", "Керуен", "Talan Towers", "Abu Dhabi Plaza", "парк", "школа", "детский сад", "супермаркет", "аптека", "рестораны", "кофейни", "банки", "центр города", "левый берег", "элитное жилье", "бизнес-центры", "остановки рядом", "велодорожки", "фонтаны", "прогулочная зона", "охрана", "паркинг", "фитнес-центр", "салон красоты", "медицинский центр", "Galmart", "Small", "торговый центр", "фудкорт", "панорамный вид", "высокие потолки", "консьерж", "видеонаблюдение", "умный дом", "элитное соседство", "дизайнерский холл", "быстрые лифты", "закрытый двор"], "atmosphere": ["деловой", "элитный", "престижный", "шумный", "активный", "современный", "туристический", "ветреный", "широкие дороги", "красивый вид", "освещенный", "безопасный", "статусный", "урбанистический", "динамичный", "центр притяжения"], "district_name": "Есильский"}	[-0.0054795397,0.0064962716,-0.0068874317,0.008359131,0.007866936,-0.020124204,0.048663605,-0.035726488,0.0010371149,0.065071285,-0.020855661,0.022525223,0.044974063,-0.03325273,0.013873023,0.013398209,0.04332026,0.032968607,-0.115068436,-0.012429308,0.034956813,-0.02692633,0.040569074,0.0006826629,-0.03601682,-0.009992251,-0.047257356,0.011814641,-0.010112439,-0.035308942,0.03809359,0.023673238,0.000143518,0.01553125,0.03499577,0.015957268,-0.01261947,-0.030017423,0.015102543,-0.044057965,-0.04586045,0.01989818,0.024736831,0.039511904,-0.07074033,-0.06262959,-0.03951529,0.008048409,-0.051559106,-0.0043640235,-0.012204359,-0.04125236,-0.016477775,0.05280313,-0.07430198,-0.028434325,-0.006288478,-0.008852714,0.061073672,0.010609588,0.0013482611,0.030798843,-0.00084204215,-0.00909968,0.016906792,-0.026245253,-0.03997303,0.007927765,-0.059449583,0.061037086,-0.0268728,0.058776792,-0.056433085,0.0004163152,-0.021269016,-0.018691309,0.001995813,-0.0056246645,0.03874405,0.036240917,-0.028230527,-0.0025439241,0.026900517,0.03938074,0.017757796,0.0043074507,0.01599173,-0.035520505,-0.079882644,-0.04643047,0.06824085,0.02903537,0.038762722,0.046554014,0.059414968,0.015296759,-0.15647613,-0.11221942,0.07539135,0.003351341,-0.002045486,0.016294269,-0.0803299,-0.054971054,0.024116777,0.056564044,-0.040955503,-0.065632485,-0.060772747,0.028478734,-0.026969636,-0.014577904,-0.0034993743,-0.002533507,0.007235124,0.017993627,-0.07523476,0.049553443,-0.005340405,0.017731557,0.029944003,0.022148738,-0.021885019,0.03252296,-0.0123764435,-0.0033142325,0.04031712,-0.028747518,-0.03132898,-0.030920053,0.025710557,-0.028032094,0.008859221,0.00082768715,-0.044671483,0.03030535,0.057901204,-0.025653496,-0.0027695044,0.009791732,0.013908785,-0.023240283,-0.0807786,-0.02367653,0.0012558597,-0.014513446,0.00026599417,0.04641551,-0.058045197,0.009814906,-0.06035921,-0.040767252,0.02408805,-0.01633,0.029352495,0.023376908,0.033232868,-0.061715625,0.04307538,-0.027578775,0.03560901,-0.0457608,-0.024122447,-0.0014260319,-0.020778267,0.02388847,0.015414851,-0.018798392,-0.043136954,0.03071374,-0.03978219,-0.058997486,-0.03226412,-0.073814474,-0.033647098,0.009830504,-0.05019953,-0.0019146358,-0.013104531,-0.001482185,0.12222783,1.3927249e-05,0.009009309,-0.09577158,0.015010076,0.022097452,-0.030041482,0.05578812,0.042749327,-0.006215929,0.026991896,-0.0006047853,-0.00081410975,0.05916961,-0.06256987,-0.027997883,0.022065807,-0.05427313,0.03931021,-0.06332711,0.03932927,-0.0444628,0.011984509,-0.0062748445,-0.027957901,0.030328603,-0.018837607,-0.06145991,-0.040616497,0.019586693,-0.02376233,-0.0034733512,-0.0283532,-0.056029335,0.041847453,0.01704719,0.0066049253,-0.0040997313,0.10163933,-0.07345454,-0.0051387167,0.01762556,0.057283755,0.0055786776,0.06785237,-0.00991546,-0.0064977575,-0.005238067,-0.008820755,-0.01834061,-0.04380804,-0.010333381,0.02178592,0.00215573,-0.0049781604,0.021153506,0.05383745,-0.035457492,-0.0412084,-0.024917807,-0.021333314,0.004299799,0.02800319,-0.067879185,-0.0013740346,0.0025242209,0.04444714,0.024855515,0.01605573,0.0058149025,-0.042358574,-0.005567529,0.011257951,0.03187678,-0.06687502,-0.025658183,0.021863928,-0.039759647,-0.027310755,-0.022487575,-0.004903961,-0.05021632,0.016672982,-0.075575605,-0.041551623,-0.023266697,-0.028237574,-0.00023041228,0.038396522,-0.018576149,0.0462873,-0.022242056,-0.036313467,0.014395953,-0.042570185,0.08267831,-0.029061053,0.058363914,-0.017555842,-0.028530393,0.036027256,0.014067303,-0.07075041,0.027570961,0.024011085,-0.07299381,-0.008715147,0.022884663,-0.027647618,-0.018318716,0.012704076,0.04325957,0.0039150054,-0.00037943275,0.04220492,-0.033059776,0.03508465,0.035583045,-0.0046610646,-0.043097798,0.0152068315,0.04997803,-0.043666895,0.051967237,-0.004263212,-0.049169328,-0.023507766,0.029830528,-0.0251606,-0.028341865,0.0059854244,0.046086427,-0.025065448,-0.05002224,-0.043632556,-0.023820993,-0.13900393,-0.07172073,0.010664138,-0.04494108,-0.020639341,0.055542164,-0.01024498,-0.013516026,0.018835122,0.00015825781,-0.017361358,-0.023454962,0.07056038,-0.023322675,-0.01188965,0.009373647,-0.014453992,-0.06801044,0.002756479,0.023578096,-0.08076399,0.016644733,0.04445434,0.021307291,0.0355618,0.020255623,0.009838078,0.030305132,0.0063205636,-0.026532741,0.009656512,0.0016873851,0.035956085,0.007834134,0.025279839,0.033718217,-0.033968605,-0.0609791,0.015357819,-0.0074502965,0.03995072,-0.0098491665,-0.015837021,-0.087736465,-0.038054354,7.895448e-05,-0.0037713053,0.035230093,0.021613648,0.039815787,-0.03152895,0.0500845,-0.04259697,-0.021567766,0.005011759,-0.008261674,0.017895507,-0.007531067,-0.013948052,0.01044248,-0.06389474,0.0004032351,0.034770582,0.002100846,-0.013834286,0.010695113,-0.024376903,0.04934934,0.011718968,0.06583152,-0.05384164,-0.013744739,-0.00699955,0.01118916,0.0019017741,0.0055492483,0.024429783,0.048570443,0.010594143,0.021289393,0.039861985,0.059854113,0.048251066,0.01718958,-0.00754969,-0.03297166,0.0795535,-0.055012703,-0.014497773,-0.025629383,0.09967941,-0.012227862,-0.009232795,0.01931848,-0.045848876,-0.02475798,-0.02374322,0.013786288,-0.03152351,-0.02713427,-0.0032952044,-0.017176243,0.008299114,-0.032176252,-0.0044119,0.03886933,0.045186743,-0.018561177,0.005591912,-0.07940114,-0.00072886125,0.011660036,-0.005882161,0.0042472174,0.022627588,0.052915465,-0.005260778,0.033568725,0.004523433,0.06000966,0.0015212795,-0.029863602,-0.034760565,0.02182761,-0.04768492,0.010597984,0.06286994,-0.022454666,-0.012721584,0.050657865,0.06241904,0.024853515,-0.022779334,0.0032479002,-0.007214085,-0.022599805,-0.009762911,-0.007892034,-0.08757412,0.008814517,0.03017726,0.017646288,-0.054824598,0.040922746,-0.039239172,-0.025412027,0.041169025,0.037585106,-0.015412977,0.025421683,-0.007414588,0.07707655,-0.034229293,-0.029491907,0.06591691,0.049092986,0.022514828,0.006205769,0.008954188,-0.0030979642,-0.003294652,-0.041728813,-0.07074911,-0.032846346,-0.029406317,0.023377312,-0.072384596,0.020991508,0.03557458,-0.05423143,-0.033577833,0.041181065,-0.022422163,-0.017763464,-0.010235924,0.015621112,-0.01391875,-0.021633679,0.024682082,-0.013495059,0.034803856,0.008623258,0.01141696,0.021719746,0.044498987,0.039105467,0.032494333,-0.06287933,-0.0005012145,0.046297178,-0.052259814,-0.013668494,0.013660767,0.011558899,0.045059174,-0.03346536,-0.034644634,0.06185004,-0.013465253,-0.0076848743,-0.008098031,-0.0070810053,-0.016381938,0.0036041725,0.0109728165,0.011125355,0.04652313,-0.04819581,-0.00436782,-0.02464168,-0.023107145,-0.018184492,0.023410369,0.0076134196,-0.05016156,0.02152579,0.018029783,0.05093902,0.04238546,0.05555054,-0.0101140505,0.05296309,0.0021234264,0.034171153,0.01584534,-0.041719217,-0.036215317,0.024500467,0.03320766,-0.030076433,0.0009678035,0.07256525,-0.042343583,0.07504635,0.01529168,-0.049262673,-0.036288477,-0.045556933,-0.015893161,-0.031905096,0.02179533,-0.027865754,-0.071168214,-0.002639356,0.011212825,0.0026055118,0.03811916,-0.033872124,0.00044043714,0.018126478,0.043189038,0.07769404,-0.052629966,0.005631108,0.025301045,-0.01803568,0.030295836,-0.026730945,0.043597005,-0.017414737,-0.042249963,0.0010474926,0.0102084745,-0.034429245,-0.014213028,0.006185861,0.010447,-0.009495061,0.04320728,-0.014033924,0.031998944,-0.008324661,-0.026186077,0.02913456,-0.01368323,0.015473987,-0.016921248,-0.03513816,0.029925514,0.018180896,-0.028891312,0.013478124,0.035979606,0.021883393,0.031150019,-0.014726936,0.061662838,-0.015320694,-0.023162877,-0.046730313,0.028687749,-0.029195158,0.009104079,-0.019972607,-0.025076717,0.0013256827,0.04632939,-0.036418863,-0.036799435,0.016326988,-0.019099854,-0.029499045,0.00023803483,0.037168317,-0.024853814,-0.0021082852,-0.023740597,0.00817849,0.004169651,-0.010444862,0.026727999,0.026286945,-0.0024727131,0.016919313,0.031007951,-0.051690355,0.0024743853,-0.037138343,0.0017129661,0.018836072,0.015688675,-0.0350169,0.014117769,-0.08210973,0.018456576,0.017150996,0.062373675,-0.00025741127,-0.035692066,0.04059758,0.036657993,-0.0227318,-0.0030265898,0.044639356,-0.016415525,-0.006885235,-0.0487611,0.08861071,-0.037123393,0.011335737,-0.015698317,-0.05590835,0.014070713,0.021826781,-0.009461132,-0.03127811,-0.013239964,-0.007397712,-0.054938294,0.040899318,-0.05137027,-0.008130813,0.024717879,-0.012240605,0.009854071,0.025178025,-0.044314187,0.030137597,-0.0030359419,-0.06791411,0.018734282,-0.027629644,-0.023139156,0.01280716,-0.025755286,-0.015791267,-0.0012331583,-0.065110356,-0.028488329,-0.009829374,-0.01836304,0.01956993,-0.021676162,-0.009392165,0.0024715173,-0.03267672,0.009565649,-0.020854754,-0.022820922,0.05960479,-0.011910791,-0.020318054,-0.022789996,-0.03313022,-0.0032666798,-0.02101579,-0.0752924,-0.06766478,0.0032389197,-0.008476497,0.04308509,0.026200099,-0.007389433,0.031414323,-0.015464399,0.0062156087,-0.002066945,0.06083129,0.007636609,0.07054362,0.032365575,-0.017952064,0.00022342517,-0.0012358775,0.040161047,-0.00565162,0.03163164,0.002572242,0.039008424,-0.023729783,-0.08093264,-0.02122504,-0.009809119,0.05968617,-0.0012767025,0.0016654432,-0.011440633,0.03103218,0.0036809405,-0.033871196,-0.03271043,-0.012681574,-0.027001433,0.010886312,0.03030857,-0.026378771,-0.033728033,-0.02983052,-0.009694654,0.008240373,0.055425752,-0.012791957,-0.041104157,-0.03947122,-0.08716722,0.008372811,-0.014743259,-0.026286937,0.080268376,0.0017691568,0.0022666603,-0.038695686,-0.0055138837,0.027264453,-0.03156778,0.04424897,-0.002915895,0.07393681,-0.04625546,0.013510912,0.038143244,-0.027258078]	2026-01-20 16:05:28.337684+05	ЖК Atlant. Адрес: г. Астана, ул. Д. Конаева, 5 
f1cbcfb6-5728-48b0-b8c3-958f0a9bf455	e0a8a372-45e5-49d2-992f-ab15f695f5d3	Auez Park	г. Астана, пересечение улиц Ш.Калдаякова, С.Нурмагамбетова, Райымбек батыра	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.11354	71.48204	Бизнес		\N	https://bi.group/ru/landing/auez-park	https://s3.bi.group/biclick/e0a8a372-45e5-49d2-992f-ab15f695f5d3/e0a8a372-45e5-49d2-992f-ab15f695f5d3_foto_400.jpg	{"side": "Right", "tags": ["парк рядом", "Президентский парк", "мечеть Хазрет Султан", "Национальный музей", "Пирамида", "Дворец мира и согласия", "школа рядом", "BINOM", "детский сад", "супермаркет", "Magnum", "Small", "аптека", "автобусная остановка", "университет Шабыт", "Аллея Тысячелетия", "новые дороги", "велодорожки", "детская площадка", "охраняемая территория", "подземный паркинг", "магазин у дома", "кофейня", "ресторан", "фитнес центр", "салон красоты", "медицинский центр", "близость к левому берегу", "мост Улы Дала", "вокзал Нурлы Жол", "фудкорт", "продукты дешево", "мини-маркет", "стоматология", "развитая инфраструктура"], "atmosphere": ["тихий", "семейный", "развивающийся", "перспективный", "просторный", "ветреный", "культурный", "современный", "чистый воздух", "широкие дороги", "красивый вид на мечеть", "спокойный", "спальный", "уютный", "чистые улицы", "хорошая транспортная развязка"], "district_name": "Алматинский"}	[-0.036231533,0.014387643,-0.009779094,-0.018816106,-0.021754924,-0.021943675,0.009465202,-0.005168698,0.0082105035,0.028260397,-0.0037555085,0.03853147,0.027867174,-0.016317194,0.02704905,0.010728518,0.026591923,0.027873684,-0.14538562,-0.008560259,0.041367956,-0.015102807,0.072143085,-0.025311628,-0.056365404,-0.046252362,-0.014935962,0.025703816,0.01942569,-0.007512381,0.039562065,0.0323802,0.004387531,-0.0134719005,0.039947525,0.032807164,0.011546825,-0.04886854,0.017765064,-0.033340584,-0.07015411,0.054173168,0.021589749,0.008259763,-0.058176268,-0.0576065,-0.06373002,0.01902008,-0.06075171,0.0126721645,-0.0045382106,-0.0361142,-0.02298899,0.055641476,-0.084998116,-0.014254946,-0.024687197,-0.008317475,0.07408532,0.003929801,0.016834177,-0.01635738,-0.0060336306,-0.04145459,-0.012794778,-0.01949052,-0.061611276,-0.0060497634,-0.06148999,-0.004914023,-0.038020328,0.06421031,-0.010488261,0.022033535,-0.0019641675,-0.028039929,0.009318598,0.0008394107,0.051941223,0.0431505,-0.042241666,-0.024399685,0.026961772,0.025290525,0.03205418,0.004141173,0.0003224423,-0.023714943,-0.076123364,-0.020946734,0.049710378,0.042453982,0.05251253,0.029893974,0.05674775,0.046286255,-0.116388485,-0.103942454,0.08287071,0.008575864,0.014815998,0.015493245,-0.05507093,-0.0846973,0.00611294,0.05234878,-0.049304742,-0.059026808,-0.078510396,0.008849037,0.0047324807,0.014930081,0.06432051,0.018379197,0.034059476,0.044617128,-0.07327159,0.049323678,0.016289627,0.02646176,0.024903625,-0.008317367,-0.019832645,0.05716819,0.0078442525,-0.016038693,0.027499214,-0.022694247,-0.01720734,-0.007950178,0.026503285,-0.030057246,0.023340328,0.010345627,-0.03485108,-0.011022783,0.062920645,-0.058266636,-0.0024923952,0.007032545,0.005532207,-0.049027383,-0.06694467,-0.027772611,-0.0025664219,-0.019611256,0.00224804,0.060960118,-0.042355094,0.0036774585,-0.05694187,-0.023419065,0.053656727,0.017087825,-0.0040661823,-0.008812662,0.07296253,-0.06387546,0.012242701,-0.035313483,0.045898218,-0.06828884,-0.054676477,0.022770375,0.0014601247,0.0011834361,0.037041422,-0.024921715,-0.015723716,-0.00850542,-0.059084974,-0.09170059,-0.0046383715,-0.069728725,-0.014223473,-0.009963704,-0.017435588,0.026272198,-0.0068234187,0.011587598,0.112330526,-0.023114648,-0.015033357,-0.090778574,-0.024740154,0.017159179,-0.009389752,0.06527538,0.047096394,-0.01097093,0.018939342,0.0103845345,0.0010916662,0.05705845,-0.03763751,-0.023620933,0.039993763,-0.0756206,-0.01246042,-0.046676897,0.06461847,-0.039018717,-0.014210382,-0.030016812,-0.011478923,0.034202993,-0.030614205,-0.06569742,-0.04910436,0.008435938,-0.0081735505,-0.01577698,-0.016763533,-0.073699005,0.013750307,0.0070387414,0.0074080867,-0.036094576,0.06949704,-0.081857055,0.02820741,0.0071470975,0.06684315,0.014949972,0.05033948,0.0076153404,0.019815205,0.00029080664,0.000983872,-0.054442424,-0.039478812,-0.011051432,-0.010714221,0.060979005,-0.039227117,0.024759497,-0.013648688,-0.036880862,-0.007092518,-0.013219207,-0.011458569,0.017925572,0.03398751,-0.025923336,0.012567369,-0.017274946,0.054409273,0.063935146,0.05191361,0.01381688,-0.047814906,-0.021509571,-0.013366161,0.0010961695,-0.054229338,-0.0570604,0.020747783,-0.0068936893,-0.010061805,-0.018013377,-0.0019333943,-0.037392806,0.012409789,-0.041407496,-0.06719694,-0.009838625,-0.02477546,-0.0066423193,0.055839486,-0.044153303,0.06758866,-0.052023325,-0.04555562,0.0034598028,-0.019271081,0.06546157,-0.007734254,0.036719117,-0.027313083,-0.039747078,0.03058738,0.013799614,-0.05723599,0.015238036,-0.0047671325,-0.06267826,-0.018728979,0.023803553,-0.027693221,-0.02470974,0.041761056,0.06590618,0.0061908504,0.013076019,0.0051108403,-0.038273323,0.034014642,0.049505487,-0.0035554883,-0.043577373,0.014710907,0.04042156,-0.043839797,0.030353965,-0.015401614,-0.022414118,-1.8347313e-05,-0.008761889,-0.035609722,0.0047879186,0.029668516,0.048384022,-0.04416017,-0.042271424,-0.075189725,-0.013265954,-0.13845892,-0.05704485,-0.006148355,0.0112950895,0.0131103555,0.08755275,-0.011460037,-0.02544765,0.057961836,-0.016041595,-0.0104239145,-0.07718205,0.061468095,-0.042708755,-0.0063471734,-0.015632637,-0.015781244,-0.072785504,-0.032195613,0.027444527,-0.0718295,0.026407836,0.0525209,0.020823041,0.030349854,0.043402385,0.0042418907,0.034008525,0.00069152465,-0.020858876,-0.0076092994,0.009783723,0.015858654,-0.002649973,0.011435646,0.01087727,-0.015539174,-0.07395976,0.03212017,-0.019986961,0.04162958,-0.012485166,-0.013287803,-0.06469855,-0.04562039,0.0060098814,0.016903093,0.030839423,0.011096288,0.013737399,-0.009544925,0.04587304,-0.06746834,-0.008073303,0.02374991,0.03329538,0.005945716,-0.0021898109,-0.004444402,0.006169058,-0.053929675,0.01604317,0.03170426,-0.022724329,-0.016101602,-0.014480968,0.0015884084,0.02130627,0.0010083063,0.07597168,-0.027895682,-0.013992404,-0.03278402,-0.0052254596,-0.031676237,0.006168966,0.016372655,0.029772183,0.019198153,0.031238183,0.040730137,0.051249847,0.043379594,0.027840964,-0.0074721696,-0.04501173,0.06380786,-0.013241472,-0.012394771,-0.005942377,0.048276015,-0.0019057209,-0.038864065,-0.006645644,-0.023024345,-0.046939876,-0.05180978,0.033469807,-0.042253405,-0.040705707,-0.016407043,-0.041662253,-0.015584092,-0.03907941,-0.0026967186,0.031328924,0.032349072,-0.010489445,-0.0072071254,-0.06531494,0.007889108,-0.01434994,0.005522371,0.022398394,0.047708128,0.049718414,-0.0011936413,0.019448083,0.047797978,0.073650934,-0.012845834,-0.050970107,-0.0033058426,0.038661227,-0.011143958,0.019405777,0.02273398,-0.0017066336,0.0091435695,0.04934857,0.027430965,0.022135288,-0.030983645,0.0015086571,-0.01491382,-0.005910793,-0.0026176313,0.015512038,-0.054252867,-0.002865279,0.030132411,0.006723375,-0.04149559,0.0147296395,-0.06494447,-0.020987267,0.0365348,0.021159384,-0.025971843,0.01836688,0.0054931506,0.035303336,-0.0017853694,-0.0033821617,0.055293046,-0.013490909,0.027126271,0.0029286493,0.0062062317,0.0023957442,0.031957995,-0.0034399547,-0.03246816,-0.04146916,-0.0007845912,0.03553199,-0.061251894,0.01157424,0.03475852,-0.03839377,-0.014568436,0.038417794,-0.036177795,-0.02959889,0.013471349,-0.008043193,-0.026181582,-0.03217584,0.019076023,-0.021233015,0.034045372,0.04888314,-0.0012861198,0.002240671,0.04306094,0.043220244,0.04023735,-0.049345322,0.012567989,0.04838834,-0.0565703,-0.027820295,0.008022444,0.02173931,0.015590313,0.0010229432,-0.03423835,0.078725055,-0.0032902162,0.007758423,-0.044424027,0.016000027,0.00207886,-0.014540915,0.0064798514,-0.013185023,0.023370998,-0.02823987,0.01281076,-0.031282127,-0.0064861523,-0.026895981,0.027966818,0.023754377,-0.020668544,0.011528137,0.03690694,0.052173097,0.024215734,0.052792292,-0.011444345,0.03689203,0.019967165,0.043043915,0.0025020335,-0.00018460026,-0.041313343,0.014663109,0.0445162,-0.026760079,-0.0032798809,0.07124232,-0.034976844,0.055134833,0.021065632,-0.04588763,-0.03679043,-0.030007703,-0.008403908,-0.02282766,0.02443677,0.010759696,-0.0675968,0.014190056,0.016384281,-0.020409277,0.041302927,-0.028763724,0.015385069,0.022043202,0.0296782,0.061269633,-0.030790914,0.008617847,0.02896254,-0.0017718679,0.02983894,-0.06298651,0.041628204,-0.027824039,-0.06945581,-0.0074807135,-0.0076512196,-0.026571348,-0.031254385,0.014161153,0.03175049,-0.003996842,-0.007564368,0.021231448,0.05553233,-0.021343319,-0.019651905,0.029427834,-0.016611302,0.034099475,-0.0074681398,-0.073990196,0.01197745,0.0042251605,-0.018809307,0.033971775,0.04518703,-0.0062599145,0.021381542,-0.006441368,0.038432658,-0.015943212,-0.03082757,-0.0669849,0.032210983,-0.03246064,-0.04180038,-0.04132822,-0.021349257,-0.0024403967,0.033463016,-0.044196725,-0.07118182,-0.006596599,-0.010821938,-0.028611166,0.01316652,0.03197024,-0.041704692,0.020266177,-0.00794123,0.012603782,-0.031201003,-0.025980491,0.0121134855,0.011986286,-0.027096497,0.005482584,0.031074569,-0.051018186,-0.0056774905,-0.038998,-0.011294231,0.05811831,0.0059379865,-0.03802202,0.039036013,-0.058679868,0.023322422,-0.01786564,0.05083654,-0.027188746,-0.027637491,0.05072363,0.026385171,-0.010086923,0.008159367,0.059121676,0.016701454,0.009144806,-0.0425174,0.07673441,0.0013064286,0.015893012,-0.021417227,-0.019048195,0.045033794,0.015175509,-0.025806226,-0.0013835195,-0.00032405314,0.007212187,-0.05476619,0.026381029,-0.032675978,0.0030727412,0.040568873,-0.028720913,-0.022072824,0.023603925,-0.05125356,0.024361076,0.009858097,-0.012653654,0.03033219,-0.0060012485,-0.03210488,0.02125044,-0.024614822,-0.026728246,0.024645511,-0.0745088,-0.00010652775,0.015022211,0.029341457,0.050521553,-0.036715116,-0.012710036,0.009238398,-0.039643638,-0.003410455,0.023833811,-1.4094114e-05,0.038507074,-0.005716164,-0.005448097,-0.043456234,-0.018637098,-0.016990844,0.0020839542,-0.082526885,-0.07957439,0.0070864577,-0.019645492,0.03302883,0.019290334,0.016997386,0.00011275572,-0.01025771,-0.0023377696,0.027265295,0.036952715,0.0076296446,0.03386963,0.017314916,-0.03510422,0.0006291383,-0.018394075,0.013436245,0.0022518043,0.010888749,0.03114942,0.062400326,-0.01635482,-0.09159164,-0.0099666035,-0.014086508,0.06265483,0.0014401347,0.0026395977,-0.017330071,0.044821303,0.01788643,-0.021405727,-0.02020803,-0.019299217,-0.039095797,0.009213285,0.05093649,0.0100927,-0.019915959,-0.018399969,0.009684334,0.014364587,0.0048457836,-0.0056458665,-0.033497725,-0.043487854,-0.0604998,-0.01026759,-0.008206506,-0.04613679,0.11673428,0.018503726,0.011106182,-0.035872113,-0.0051336964,0.019147374,-0.004533919,0.040519122,0.0069312328,0.07748899,-0.040793467,-0.0050662146,0.033601206,-0.0073439823]	2026-01-20 16:05:35.205213+05	ЖК Auez Park. Адрес: г. Астана, пересечение улиц Ш.Калдаякова, С.Нурмагамбетова, Райымбек батыра
1e729afc-964b-4ef5-aa54-7ad9b41b1565	e2998ec2-4b23-4560-8aae-345db3a4668b	Capital Park Joy	г. Астана, ул. Бухар жырау, 31/1	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.09906	71.44315	Комфорт+		\N	https://bi.group/ru/landing/capitalpark-joy	https://s3.bi.group/biclick/e2998ec2-4b23-4560-8aae-345db3a4668b/e2998ec2-4b23-4560-8aae-345db3a4668b_foto_400.jpg	{"side": "Left", "tags": ["парк рядом", "ботанический сад", "президентский парк", "экспо рядом", "expo", "mega silk way", "школа рядом", "детский сад рядом", "супермаркет", "аптека", "кофейня", "ресторан", "фитнес-центр", "велодорожки", "остановка рядом", "астана арена", "барыс арена", "линейный парк", "bi group", "capital park", "новостройка", "комфорт класс", "чистый подъезд", "охрана", "видеонаблюдение", "паркинг", "детская площадка", "спортивная площадка", "магазин у дома", "салон красоты", "стоматология", "развитая инфраструктура", "магнум", "small", "школа бином", "seed school", "лицей 88", "назарбаев университет", "мечеть абу насыр аль-фараби"], "atmosphere": ["семейный", "современный", "развивающийся", "просторный", "ветреный", "перспективный", "молодежный", "деловой", "широкие дороги", "близость к паркам", "активная застройка", "чистый воздух", "современные детские площадки", "безопасный", "динамичный", "ухоженные тротуары", "хорошее освещение"], "district_name": "Есильский"}	[-0.015786313,0.0097163515,-0.035938043,-0.016774045,-0.015643971,-0.022174776,0.011445122,-0.02047633,0.024214173,0.020296091,-0.0027177164,0.034528807,0.033549823,-0.018105026,-0.008861883,0.014666238,0.05300683,0.03465336,-0.12479453,-0.035813943,0.031836618,-0.0022178683,0.06523959,-0.009576934,-0.062783696,-0.03450783,-0.077104665,0.014003714,0.00748572,-0.03837691,0.009191067,0.043424174,0.004325397,0.009410368,0.01253423,0.01391467,-0.03159155,-0.033000253,0.01739235,-0.013718463,-0.05946858,0.03088764,0.015335805,-0.00039758795,-0.08177962,-0.07411527,-0.02711661,0.033677436,-0.055530813,0.0049393475,0.028634567,-0.055973575,-0.028783944,0.07014208,-0.09139221,-0.008440038,-0.0019322125,-0.024235265,0.06929912,0.0117016,0.02364192,-0.015419603,0.019663583,-0.011675839,0.02643289,-0.025917033,-0.07136463,-0.003182025,-0.09584114,0.0045008017,-0.01656198,0.092699625,-0.04491524,-0.0022576058,-0.009377224,-0.031581074,0.017750615,-0.0021344342,0.057481978,0.065463826,-0.06436172,-0.0106816655,0.042432103,0.02484707,0.0070157014,0.000345536,0.010228426,-0.054207426,-0.060645547,-0.03530422,0.05226393,0.05339467,0.016541364,0.017327668,0.07235571,0.024030134,-0.1094219,-0.075249486,0.06745272,0.008397279,0.037055485,0.015465257,-0.030901577,-0.062112357,-0.009116791,0.064969905,-0.060722284,-0.058296446,-0.064143315,0.033976205,0.003646395,-0.024697445,0.028163187,-0.0029963644,0.012813982,0.052318066,-0.095142424,0.0617453,0.0052309893,0.041307487,-0.0043511894,-0.019588705,-0.032713436,0.054818492,-0.004201576,0.023563256,-0.0044487924,-0.030589614,-0.04634978,-0.058558006,0.018900184,-0.046927955,0.0049910876,-0.010702971,-0.03420808,-0.00977979,0.06880191,-0.008256317,-6.70689e-05,-0.0014680085,0.016492123,-0.04305168,-0.039575703,-0.009536603,-0.019244663,-0.03522177,0.016944718,0.06101743,-0.045505147,0.023403756,-0.07000284,-0.033818208,0.020289015,-0.01826265,0.0083415685,0.0130826635,0.05522187,-0.07578063,0.013697015,-0.044014253,0.047434334,-0.046289165,-0.05145348,0.009719782,-0.015016919,-0.0020239123,0.0036186655,-0.008597883,-0.037747115,0.019166782,-0.033696663,-0.076980464,-0.01566272,-0.07040571,-0.009740186,0.029114377,-0.0481357,-0.0002956213,-0.018787704,0.011752869,0.088988364,-0.025208088,-0.010662331,-0.07969953,-0.0069178566,0.025937887,-0.019888895,0.051895127,0.03406657,0.00048020406,0.030199347,0.010586364,0.0045239353,0.054869983,-0.04719869,-0.02171629,0.042490464,-0.06294317,-0.003144807,-0.06148881,0.043149766,-0.033643436,-0.012890598,-0.04902005,-0.04548654,0.044966534,-0.04298409,-0.08388637,-0.061931647,0.03219166,0.02427188,0.0013244557,-0.042183947,-0.06481305,0.028075324,0.018447291,0.008027791,-0.017129706,0.08089758,-0.093428865,0.021012265,0.005182527,0.07542374,0.030149093,0.053797577,-0.0016765866,-0.0067654694,-0.025040964,0.0068123406,-0.033246994,-0.043552812,-0.008959233,-0.007718797,0.05406698,0.0038694623,0.048307244,0.006080368,-0.026915273,-0.034193475,-0.026704742,-0.0066677295,0.03164086,0.018384587,-0.03046118,0.0046811,0.0038803765,0.027159246,0.05847573,0.0454373,0.002259597,-0.050528962,0.0024229595,0.00016259597,-0.008386847,-0.042520273,-0.030034732,0.011328642,0.011414356,-0.04241829,-0.02990611,0.008342189,-0.038445115,0.0042373994,-0.08284872,-0.04249659,-0.03763968,-0.020253835,-0.0003475483,0.05418639,-0.04189119,0.07730592,-0.0404652,-0.018209672,-0.0018601345,-0.013108672,0.05849094,-0.02890112,0.02321173,-0.029173747,-0.047566593,0.026830558,0.022254782,-0.053710576,0.02617082,0.0055117705,-0.060894467,0.0065152883,-0.002189912,-0.019818261,-0.021467749,0.015220966,0.08321973,-0.0017555093,-0.016768496,0.017475808,-0.04492471,0.0003216843,0.031976406,0.012023442,-0.042651992,-0.0034584126,0.04659346,-0.046456557,0.017500073,0.026808824,-0.032379836,-0.0019632964,-0.0033466446,-0.018893383,0.031833913,0.016653556,0.05037714,-0.041434165,-0.029523218,-0.044107024,-0.02147263,-0.15595865,-0.053297237,0.024731252,-0.003698347,0.05220191,0.054790743,-0.003321125,-0.01089586,0.030535763,-0.011448624,-0.011422914,-0.040615328,0.044970725,-0.050569214,-0.0048062615,-0.014920369,0.000987063,-0.04108111,-0.008634533,0.05060914,-0.07146183,0.01794542,0.0363873,0.022448795,0.031881757,0.024088148,-0.004249257,0.015405393,0.02062245,-0.04484591,-0.008886736,0.011616824,0.031790566,-0.007942418,0.024477022,0.013173718,-0.051844165,-0.04590645,0.06459266,0.0073886565,0.050144773,0.0015130368,0.0068010297,-0.056723643,-0.0042416025,-0.010837047,0.013659373,0.03411706,-0.004500676,0.002983908,-0.015889939,0.05233223,-0.05558357,0.011445785,0.02827825,0.04450751,0.0056407675,0.00430663,-0.0073628086,-0.0024896914,-0.030744286,0.015566675,0.018564943,-0.010626238,-0.002089723,0.025658267,0.0047337417,0.032759856,-0.015027406,0.044516366,-0.056574658,-0.0040583834,-0.005043962,-0.004819333,-0.011374126,0.029561492,0.016208744,0.03918661,0.01568335,0.040082783,0.04623714,0.07751594,0.022434983,0.018290266,-0.01855345,-0.035955094,0.10470023,-0.009805323,0.0025163777,-0.040953208,0.056726627,0.0030785329,-0.016428053,0.0011510028,-0.022843562,-0.024712356,-0.026925875,0.01839503,-0.0316477,-0.020474568,-0.008341763,-0.0429435,-0.004955441,-0.01951525,-0.011014638,0.04979945,0.037939247,0.005276257,0.011072493,-0.0697488,0.0036092573,-0.006139359,0.022153314,-0.011379201,0.02305962,0.047940657,0.0017240503,0.030164057,0.032029442,0.086213134,0.0041336818,-0.028555898,-0.016479857,0.030113561,-0.015791142,-0.002149782,0.015012957,-0.017438924,-0.023506474,0.046062138,0.040239092,0.015375972,-0.00013252028,-0.0062705996,-0.025983391,-0.0050920234,0.030197155,0.030756785,-0.045963883,0.025920188,0.026823679,0.0046875593,-0.072889656,0.021743737,-0.030228551,-0.034757208,0.040127985,0.03493742,-0.011184536,0.019217122,0.01188256,0.064324155,-0.032392323,-0.0034865767,0.065292716,0.010122014,0.02731082,-0.0015786448,0.017637549,-0.01656689,0.033937313,-0.002369929,-0.031475786,-0.008948252,-0.032289583,0.009747614,-0.06256139,0.013690048,0.037994612,-0.022715671,0.010954568,0.043264557,-0.022517782,-0.009783422,-0.001684189,-0.0010479966,-0.012002608,-0.030190146,0.017917125,-0.019834844,0.06251618,0.029940546,0.00026078854,0.010658785,0.08861067,0.01650205,0.017361147,-0.0695673,-0.009241063,0.03659133,-0.0650511,-0.012440285,0.05558387,0.0021361134,0.024217524,-0.014602282,-0.01789921,0.05573402,-0.020215958,-0.02531504,-0.04521423,0.004087663,-0.0016932369,-0.025063043,-0.018410714,-0.027679859,0.03608595,-0.047415562,0.014221175,-0.0040220255,-0.008841006,-0.024723446,0.037924323,0.013438797,-0.008011549,0.023298336,0.04869361,0.035998743,0.018403761,0.046783168,-0.0052791787,0.031136483,-0.022822188,0.04008402,0.01862972,-0.007882044,-0.034116615,0.032955207,0.032341417,-0.041329764,-0.020980703,0.05380714,-0.033254486,0.04722832,0.011017886,-0.055287745,-0.008814696,-0.04911858,-0.017639227,-0.022264035,0.009367503,0.007026878,-0.074665986,0.015286768,0.01411085,0.005742978,0.06000886,-0.004179307,0.003664965,0.026290119,0.03865623,0.07003722,-0.03250424,0.0015127443,0.028518638,-0.0041795964,0.011327947,-0.041423447,0.054269485,-0.03763688,-0.053063937,-0.019716928,-0.0019990567,-0.05157169,-0.010693417,0.0120247295,0.036452644,-0.000687374,0.025906589,0.016428467,0.024104685,-0.03677493,-0.028132986,0.02468334,0.004675819,0.025560603,-0.003876356,-0.0703472,0.023271445,-0.0069192816,-0.026212834,0.03355391,0.036621843,0.0011297354,0.00919329,0.000835183,0.043938044,-0.033941507,-0.028241089,-0.076488666,0.056650165,-0.017439565,-0.01602496,-0.016134547,-0.012143667,-0.025194565,0.038433768,-0.016820986,-0.052176014,-0.015954245,-0.028508073,-0.03560378,0.023502244,0.03654311,-0.0026666082,-0.0067343395,0.0010485752,-0.008320606,-0.033369534,-0.004040531,0.033614077,0.013193941,0.008990924,0.017977262,0.030477822,-0.036159392,0.023955196,-0.02349649,-0.01363967,0.029929716,0.021817513,-0.027106868,0.027850268,-0.06331581,0.024092106,-0.0071811955,0.051523536,-0.026476197,-0.03406191,0.08005922,0.026316075,0.02060039,0.0043089455,0.06986231,0.02865576,0.040981002,-0.052401517,0.08919341,0.002099446,0.024275094,-0.022662729,-0.037867896,0.03268159,0.043273687,-0.004490233,0.024318399,0.0053600525,0.016316218,-0.034255482,0.04835468,-0.06328567,0.00023421545,0.03344856,-0.016827239,-0.036188614,0.026418198,-0.046747383,0.025796669,-0.0010742805,-0.038644217,0.039448947,0.0143745225,-0.009004139,0.012125059,-0.023059193,-0.009343867,0.019298354,-0.07263609,-0.020804806,0.006901283,0.026292296,0.037457358,-0.04253056,-0.010826073,-0.0017045713,-0.0071570133,-0.008240577,0.009652351,-0.00268535,0.04849178,-0.041523986,0.023786897,0.018840294,-0.02505994,-0.022917282,-6.3262996e-05,-0.06571363,-0.07659082,0.00967079,-0.0014054393,0.049596857,0.014965098,0.002461152,-0.010886724,-0.0009514395,-0.0105893975,0.02735711,0.012770759,0.012074738,0.041235358,0.036620483,-0.01424968,0.00788625,-0.0028674668,0.040088534,-0.003201058,0.029503535,0.00395487,0.061427027,-0.02078103,-0.07965667,-0.013534529,-0.008450137,0.066730686,-0.008139337,-0.00043764318,0.03162994,0.037426453,-0.0034733755,-0.030585743,-0.031158067,-0.042667873,-0.028754013,-0.023438375,0.048217203,0.00038461655,-0.022247542,-0.031156898,-0.010594292,0.014061184,0.042547334,0.013909011,-0.018345585,-0.04086986,-0.054879703,-0.023651412,-0.0071173063,-0.03448902,0.09325137,0.014903732,0.0006266784,-0.010896885,0.00075030106,0.039285116,-0.015619572,0.06473663,0.009176565,0.054643,-0.039741557,-0.025195552,0.052700978,-0.03229858]	2026-01-20 16:05:41.924444+05	ЖК Capital Park Joy. Адрес: г. Астана, ул. Бухар жырау, 31/1
fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392	4d7b4fe0-649b-4d90-808f-39e97e3aac12	Family Nest	г. Астана, ул. Е354	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.0522	71.43136	Комфорт lite		\N	https://bi.group/ru/landing/family-nest	https://s3.bi.group/biclick/4d7b4fe0-649b-4d90-808f-39e97e3aac12/4d7b4fe0-649b-4d90-808f-39e97e3aac12_foto_400.jpg	{"side": "Right", "tags": ["школа рядом", "детский сад рядом", "супермаркет рядом", "аптека рядом", "поликлиника рядом", "остановки общественного транспорта", "парк рядом", "мечеть рядом", "спортивные площадки", "кафе рядом", "салоны красоты", "банкоматы", "детские площадки", "фитнес-центр", "магазины у дома", "автобусные маршруты", "почта рядом", "пекарня рядом", "химчистка рядом", "стоматология рядом", "автомойка рядом", "АЗС рядом"], "atmosphere": ["семейный", "тихий", "спальный", "зеленый двор", "чистый воздух", "широкие дороги", "развивающийся", "уютный", "спокойный"], "district_name": "Алматинский"}	[-0.020244488,0.012722074,-0.008285762,0.005736475,-0.015025716,-0.0034941009,0.021194901,-0.019574186,0.0061916886,0.021929929,-0.0102287205,0.057258584,0.03948661,-0.013629201,0.0118983025,0.022720497,0.036741003,0.025410628,-0.1402779,-0.0025700196,0.03490752,0.001063996,0.044441722,-0.022620637,-0.048051123,-0.05929832,-0.029877814,0.0076038996,0.0059727333,-0.022404118,0.05085151,0.04110542,0.009078307,-0.019295506,0.035201143,0.013525446,-0.029195098,-0.0670036,0.049915124,-0.030898124,-0.06291214,0.0036119109,0.025026305,-0.0010680351,-0.06420205,-0.072376035,-0.056192577,0.024975756,-0.05592654,0.00582476,-0.004525893,-0.027178548,-0.028593479,0.05066909,-0.07949363,-0.00076025265,-0.022795271,-0.028907634,0.0528852,0.008882751,0.006718745,-0.014126454,0.0006087905,-0.019460415,0.0029878533,0.0012704378,-0.011517197,0.0019333794,-0.0641827,-0.0037181415,-0.0011127663,0.06587535,-0.016890602,0.03987924,-0.013712706,-0.01455333,0.008618694,0.028557664,0.067148514,0.044387605,-0.038362842,-0.01534288,0.029306088,0.029345386,0.00996237,0.022545539,-0.0059146383,-0.030820973,-0.068209894,-0.029296441,0.06522553,0.033567682,0.04187695,0.017744504,0.06379244,0.041927535,-0.10263882,-0.09781711,0.046671785,0.023653533,0.04216388,-0.0061244187,-0.049324773,-0.101714455,0.025382202,0.053867582,-0.056787197,-0.07160144,-0.07492838,0.011333999,0.0032421863,0.0018172108,0.044056494,0.015958397,0.0036751823,0.03191578,-0.06778319,0.056273606,0.01658386,0.020183932,0.02085275,0.025150057,-0.015714737,0.052017726,0.02383163,0.019220266,0.01281018,-0.032758497,0.003096597,-0.009487677,0.02640212,-0.043237016,-0.0030063528,0.0063911513,-0.027771177,-0.00057197316,0.0645787,-0.040360454,0.022681633,0.040519416,0.014588181,-0.042178735,-0.047296047,-0.007602686,-0.009417076,-0.0153404875,0.022321044,0.06773493,-0.032684352,0.021046102,-0.047195114,-0.03339432,0.037425004,0.014260156,0.019674534,-0.01260666,0.096012324,-0.07280206,0.013583649,-0.020712385,0.073185265,-0.074287154,-0.028164197,0.017589388,-0.006307403,-0.0015545292,0.021006798,0.0010080725,-0.013302062,-0.013587806,-0.052278753,-0.08734689,-0.043140177,-0.081377044,-0.016049244,0.00010186768,-0.026834983,-0.013248218,-0.007990125,0.030223833,0.10172107,-0.002803842,-0.013559902,-0.08204208,-0.019190712,-7.293426e-05,-0.017302684,0.030843027,0.07168883,0.019094272,0.030334879,0.01942515,-0.0007215495,0.063291244,-0.026523044,-0.011345169,0.04374898,-0.071511775,-0.011394839,-0.047552917,0.018624218,-0.040966347,-0.010712869,-0.020320412,-0.02982824,0.03995582,-0.02374156,-0.073667854,-0.031143311,0.019619066,0.003909663,-0.009063492,-0.020816654,-0.07487578,0.021844298,0.019242771,-0.00665918,-0.021216832,0.07302114,-0.0884073,0.011929776,-0.0033313723,0.060318597,0.012594141,0.060762625,-0.012955009,-0.02082967,-0.021850808,-0.014374735,-0.03494055,-0.044996608,0.012620396,0.0019781163,0.03645719,-0.027102308,0.024745097,0.037044186,-0.051455893,-0.04444802,0.0040177205,-0.015325881,0.04002349,0.024732238,-0.041583177,0.022729782,-0.019089518,0.10425959,0.06455074,0.02705928,0.02269361,-0.011315362,-0.04155878,-0.001949742,-0.020452406,-0.037101343,-0.036675263,0.023826545,0.032846913,-0.029717986,-0.0066614645,0.025928339,-0.02757308,-0.0025841028,-0.059713423,-0.056130044,-0.01444317,-0.008580449,0.0114119155,0.05335378,-0.032457475,0.06743333,-0.057097808,-0.037340563,-0.0065265796,-0.021643158,0.0736563,-0.0036037632,0.027594402,-0.020070486,-0.031850073,0.07516317,-0.00032038533,-0.038457952,0.020401519,0.01630319,-0.074592695,0.0075040124,0.020323848,-0.040909834,-0.029421741,0.03860901,0.05650287,0.006043625,0.018264765,0.006080631,-0.03159637,0.0111361025,0.027353164,-0.0055018077,-0.036147382,0.024453452,0.047093775,-0.016993897,0.043879736,-0.016562743,-0.046155624,-0.020753553,-0.009393619,-0.021441946,0.016300268,-0.0067074057,0.045301605,-0.06906498,-0.030648248,-0.039862957,-0.020792555,-0.13528512,-0.03610635,0.009867914,0.01745254,0.02745551,0.08026298,0.029520947,-0.015227526,0.047398936,-0.031624466,-0.0008485178,-0.029734487,0.0649051,-0.022771802,0.007822562,-0.03444719,-0.012765381,-0.05216439,-0.02995801,0.04075781,-0.07553245,0.025689656,0.059171658,0.04419392,0.06915917,0.04656175,0.004358653,0.0347397,0.012283451,-0.02432875,-0.014819115,0.030798448,0.033362355,0.010531157,0.045342468,0.013182566,-0.012284721,-0.06661852,0.01861841,-0.008065346,0.039190788,-0.0010817809,-0.008194892,-0.05111332,-0.024197208,0.0021438242,0.015910668,0.026559023,0.0059227045,0.033036973,0.010971711,0.055735696,-0.05453494,-0.0036713937,0.013235942,0.0150953205,0.028024605,0.006778187,0.01740506,-0.0065412414,-0.05869028,0.03057015,0.036093593,-0.004165182,0.013669574,0.002935599,-0.012062737,0.025456008,0.009941938,0.06577139,-0.03905946,0.017575605,-0.026198475,-0.0053484067,-0.027564911,0.00705548,0.04122657,0.049919344,0.044792414,0.041836858,0.025872236,0.056323197,0.02251269,0.018799718,0.0059356843,-0.045915194,0.08395355,-0.023105588,-0.028320197,-0.027298173,0.06642248,-0.02589742,-0.023585567,-0.0030001253,-0.022692984,-0.021389982,-0.049971998,0.0370104,-0.060568023,-0.00833765,-0.02081496,-0.020589834,-0.017433345,-0.032639794,0.009309217,0.03544469,0.017084118,-0.017106203,-0.009086454,-0.08660979,-0.00036337346,-0.011563589,0.012580037,0.012994935,0.040903483,0.051340934,0.0034471091,0.045829978,0.029893529,0.07435407,-0.01643285,-0.0520579,-0.026241073,0.023775265,0.0017610869,0.0020625843,0.025979424,0.005892432,-0.009084521,0.06849341,0.030944688,0.02484159,-0.04508608,0.0061960183,-0.027425066,0.003914128,-0.0038098653,0.023669748,-0.07305811,0.002762212,0.022902757,-0.003964739,-0.033992775,0.040486585,-0.055057842,-0.04316725,0.043783706,0.03306357,-0.00470772,0.01250973,0.0020689291,0.032598134,-0.022971261,0.009920761,0.030350167,0.016305232,0.029690458,0.011286131,0.031788502,0.0065606507,0.0161433,-0.00088304403,-0.053067297,-0.011431538,-0.005590423,0.034533553,-0.07849657,0.009396696,0.049442872,-0.054172702,-0.012644231,0.049024872,-0.01666112,-0.02871614,0.0013267613,-0.0069488967,-0.023452217,-0.025616754,0.026767254,-0.014936298,0.02947354,0.027798656,-0.016013762,0.02372624,0.03143162,0.014988939,0.042213514,-0.06224512,0.0087074265,0.055260327,-0.0623401,-0.002131153,0.04108257,0.0061597032,0.03648513,-0.010844355,-0.017744713,0.04942433,-0.008980776,0.0042296113,-0.04788127,0.018674383,-0.013344869,-0.016341148,-0.04088604,-0.030993022,0.018477395,-0.04272943,0.012592552,-0.017635586,-0.0022788113,-0.03922631,0.03964296,0.00952757,-0.0327467,0.01908669,0.052181635,0.05978029,0.019980432,0.05439461,0.0060046855,0.033150923,0.021135058,0.022322034,0.050330605,0.011076984,-0.05868174,0.012574139,0.05078508,-0.0444979,-0.004911952,0.068324976,-0.022396894,0.045712527,0.023731526,-0.078381844,-0.046561893,-0.05823458,0.0115576545,-0.0141051505,0.03053405,0.007848174,-0.07156365,0.00895751,0.009284275,-0.020819118,0.032477826,-0.02685193,0.004203315,0.032319654,0.027066255,0.0731892,-0.014388713,-0.00799968,0.025456619,-0.00020583566,0.020763207,-0.037555292,0.06859785,-0.019875297,-0.07333549,-0.01810496,-0.015649166,-0.024968166,-0.044953384,0.019749131,0.014029313,-0.02400031,-0.0021255105,-0.006047316,0.030336497,-0.014542134,-0.02030592,0.023896918,-0.011346171,0.03396998,-0.02383156,-0.05971127,0.01343762,0.009985166,-0.023854813,0.023753304,0.050191164,0.009179906,0.010670768,0.012012537,0.040759835,-0.028875383,-0.016675431,-0.09009102,0.03327079,-0.026867367,-0.01582483,-0.017551774,-0.016418412,-0.0033159843,-0.011343635,-0.049972445,-0.03579112,0.0064088195,0.004280893,-0.039716978,0.0138451485,-0.004743372,-0.032962963,0.019542135,-0.015654135,0.002392765,-0.029351601,-0.0066324743,0.00961719,0.03381185,-0.010460473,0.0005190905,0.015886985,-0.04858842,0.02469162,-0.031196197,-0.039138086,0.0176467,0.009228422,-0.04128565,0.051921796,-0.04890749,0.0010809469,-0.008012749,0.0691969,-0.004760585,-0.056366995,0.05778156,0.037779596,-0.04551372,0.015476812,0.06919462,0.01574098,0.022216143,-0.049798332,0.06890339,-0.014571197,0.010912881,-0.008934343,-0.05045638,0.041037153,0.030054383,-0.031070331,0.019731386,-0.015476746,0.0008481069,-0.06493885,0.04894548,-0.023222037,-0.0097560175,0.016035102,-0.023975976,-0.025271315,0.011125937,-0.033236634,0.0069200387,-0.011642168,-0.012008934,0.011275295,-0.03141365,-0.040270187,0.019536978,-0.018547697,-0.0035800438,0.014516197,-0.05956132,-0.020477857,-0.002150372,0.044971116,0.055493418,-0.041501142,-0.020491777,-0.0012976573,-0.02350846,0.00035856562,0.02688174,-0.013054244,0.044064645,-0.010376977,0.01719396,-0.03512185,-0.013142009,-0.0038752332,0.005657044,-0.053834885,-0.07590763,0.008876264,0.005864811,0.033131517,0.017751008,-0.0071918285,-0.017792268,-0.0043188566,-0.006128258,0.0136865545,0.04792764,-0.016833888,0.025569653,0.019764336,-0.020619571,0.009715142,-0.01015871,0.030553197,-0.009458375,0.027000993,0.012495635,0.052698072,0.013902324,-0.06899973,-0.02958349,-0.046077564,0.045610715,0.013874891,-1.0797112e-05,0.020097783,0.024517573,-0.0035429422,-0.029508632,-0.026874289,-0.010246397,-0.031467684,0.009818349,0.03383377,-0.0150449155,-0.030573651,-0.023562508,-0.016209979,0.014521073,0.025238987,-0.031705987,-0.046489388,-0.039858233,-0.049253214,-0.0074366108,-0.014780505,-0.020854298,0.12363158,-0.006135085,0.02109236,-0.034043647,-0.00074413454,0.04140599,0.010225331,0.05544338,0.0142366225,0.026134618,-0.034663264,0.0074511487,0.025522493,-0.017121958]	2026-01-20 16:07:03.563921+05	ЖК Family Nest. Адрес: г. Астана, ул. Е354
23428d03-18a0-4461-a225-3e75f604cc4d	e20ac2ca-f4ed-11ef-a832-001dd8b72708	Capital Park. Melody	г. Астана, Есильский район, пересечение ул. Бухар Жырау и Жошы Хана	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10054	71.43999	Комфорт+		\N	https://bi.group/ru/landing/capitalpark-melody	https://s3.bi.group/biclick/e20ac2ca-f4ed-11ef-a832-001dd8b72708/e20ac2ca-f4ed-11ef-a832-001dd8b72708_foto_400.jpg	{"side": "Left", "tags": ["парк рядом", "школа рядом", "детский сад рядом", "супермаркет рядом", "ТРЦ рядом", "университет рядом", "EXPO рядом", "остановки общественного транспорта", "аптека рядом", "кафе рядом", "ресторан рядом", "фитнес-центр рядом", "медицинский центр рядом", "салон красоты рядом", "банки рядом", "детская площадка", "спортивная площадка", "охраняемая территория", "подземный паркинг", "новые дома", "современная архитектура", "благоустроенный двор", "велодорожки", "прогулочные зоны", "хорошая транспортная доступность", "престижный район", "чистый район", "Ботанический сад", "Назарбаев Университет", "Mega Silk Way"], "atmosphere": ["семейный", "молодежный", "зеленый", "ветреный", "элитный", "современный", "развитая инфраструктура", "широкие дороги", "чистый воздух", "красивый вид", "перспективный", "умеренно шумный", "благоустроенный"], "district_name": "Есильский"}	[-0.018270798,0.050705817,-0.026199227,-0.032291893,-0.018581418,-0.005544898,0.00042119506,-0.0011071532,0.010624364,0.038867194,0.0023423843,0.056059953,0.03567462,-0.029941343,0.0323485,-0.0051795053,0.037632536,0.05169262,-0.12678328,-0.030043384,0.02331947,-0.010998217,0.051144693,-0.016847044,-0.05463356,-0.04840283,-0.0730654,0.02542371,0.0013274181,-0.02022643,0.023224495,0.04883726,-0.00016325554,0.006941664,0.011786832,0.020525424,-0.02316915,-0.046937693,0.026479263,-0.01442529,-0.054860435,0.03505198,0.024806252,0.021074403,-0.09270858,-0.07520072,-0.03582196,0.03307804,-0.05335627,0.0076150056,0.021914963,-0.047655623,-0.0304657,0.054027755,-0.05178519,-0.02770498,-0.023157338,-0.01925686,0.08186529,0.017415142,0.003149219,0.0018389769,0.011524934,-0.016018646,0.022030072,-0.0181406,-0.07729878,-0.014043498,-0.08389699,0.02323656,-0.024368072,0.096749336,-0.036241762,0.013834507,-0.019106135,-0.015047024,0.015103796,-0.007853953,0.032244746,0.06019236,-0.07031715,0.0025752708,0.03860284,0.022297505,0.00031116066,0.010962117,0.014858158,-0.024663594,-0.075742275,-0.030745927,0.065789975,0.037191287,0.037809152,0.029646594,0.07367447,0.029256653,-0.114783466,-0.08835692,0.050317045,0.02087267,0.01751522,0.023950996,-0.029365959,-0.07162358,0.0009811354,0.07369981,-0.061015915,-0.07663058,-0.06366036,0.01965699,0.017756179,-0.031525113,0.0333341,0.0033683951,0.025115259,0.049339492,-0.10044912,0.06327992,0.023304425,0.03380027,0.010547559,-0.0066517815,-0.023054488,0.062363524,-0.018395612,0.013330522,0.011186515,-0.040727597,-0.019666206,-0.035143938,0.027450211,-0.019109372,-0.006923778,-0.01092088,-0.030592324,0.024234418,0.0581747,-0.01769372,0.004075344,-0.014394031,0.0059311828,-0.0359034,-0.048522137,-0.024286116,-0.013153639,-0.025274387,0.0072316434,0.06788645,-0.042780757,0.031744592,-0.05313621,-0.025954776,0.0198847,-0.01937401,0.020506777,0.017054629,0.0749248,-0.042115442,-0.022614509,-0.052388266,0.046704758,-0.042754095,-0.035080902,0.0033324277,-0.017964026,0.0015082902,0.0031353738,-0.029289745,-0.037173223,0.006793368,-0.036408454,-0.085211866,-0.02945203,-0.07626958,-0.018619478,0.014181767,-0.028843723,-0.0034483373,-0.031193532,0.01156361,0.0927415,-0.03622065,-0.0066679437,-0.06993362,-0.0024882343,0.01024874,-0.010264119,0.05987158,0.03695501,-0.0021543324,0.011939129,0.003884563,0.022776913,0.06525887,-0.040795714,-0.036574338,0.048389275,-0.08329893,0.008586014,-0.060921777,0.042139072,-0.032841794,-0.023466334,-0.037196383,-0.037573654,0.031034488,-0.020793073,-0.07390434,-0.04239041,0.030828256,0.010965023,-0.013617173,-0.038101953,-0.08812713,0.015629714,0.0073515093,0.0074039656,-0.030731749,0.089919,-0.07440161,0.0075308112,0.010385096,0.05014288,0.011861559,0.04656719,-0.012550184,-0.0064561563,-0.015081519,-0.0042581563,-0.044887334,-0.044725493,-0.0118280025,0.00047238386,0.03660897,0.0069537777,0.046794698,-0.0019915432,-0.03191518,-0.03876227,-0.019695867,-0.007279888,0.029080976,0.0066190483,-0.015470178,0.0066283387,0.0089519955,0.04343888,0.05535222,0.032542866,0.017243518,-0.05686126,0.005000522,0.009230759,-0.011948071,-0.05774672,-0.05423947,0.023319812,0.012593886,-0.040497355,-0.032865554,-0.0036768208,-0.031125054,0.0057452037,-0.0808897,-0.057942454,-0.0406767,-0.020782864,-0.009071384,0.05319073,-0.036875516,0.060674295,-0.040303044,-0.029806625,0.0016397199,-0.011122928,0.07646909,-0.031077094,0.03737222,-0.032508064,-0.039154597,0.03267757,0.006759084,-0.031313904,0.0066967485,0.011594271,-0.068153664,-0.0073978133,0.0053203413,-0.008407959,-0.023382995,0.011424111,0.07493933,0.018192563,-0.007335204,0.01837763,-0.06181984,0.017103078,0.039706916,0.008426928,-0.042249497,0.0044022864,0.04833411,-0.047473263,0.025676247,0.008702272,-0.036192514,-0.0013074011,-0.001338647,-0.021265348,0.0216701,0.009423416,0.04012434,-0.040109806,-0.027529052,-0.039611652,-0.0020371033,-0.15403011,-0.05198432,0.016872669,-0.0115839215,0.042575665,0.06960104,-0.017874446,-0.00078424596,0.017464792,-0.01143339,-0.02452855,-0.039779905,0.061334014,-0.040245004,-0.023781244,-0.0069208983,0.00404151,-0.03766915,0.00086740823,0.03635297,-0.067657605,0.02515835,0.041783746,0.019388748,0.034623448,0.037857812,-0.012818856,0.011021712,0.011534048,-0.016702259,0.0047708284,0.021859325,0.01957262,0.009952579,0.02886085,0.018505225,-0.037541807,-0.06264882,0.040573787,-0.023341509,0.0462789,-0.00081978366,0.01519819,-0.077235654,-0.008962522,0.010885724,0.019927831,0.027089618,0.0012943918,0.002442996,-0.0032900248,0.045921862,-0.06698819,-0.0031582424,0.013114341,0.042035405,0.0073062875,0.012643513,-0.030668726,-0.004543495,-0.023689477,-0.0005191339,0.023858652,-0.0034765576,-0.02457882,0.01719034,-0.001609488,0.04246325,-0.010055973,0.061952747,-0.040181246,-0.006199223,-0.020256259,0.0034390648,-0.019926488,0.023720574,0.0074710054,0.030631019,0.024335736,0.029192843,0.046731424,0.06972862,0.031090202,0.0022058613,0.0068731834,-0.020396357,0.08886929,-0.018300202,-0.004349064,-0.029961525,0.059320636,0.0011536463,-0.0184227,0.0013068968,-0.014606671,-0.027362315,-0.03663924,0.013119011,-0.024583492,-0.0138063505,-0.009221149,-0.03539479,-0.0010406652,-0.004722195,-0.017467948,0.046566453,0.03510044,0.0060452153,0.015728949,-0.088368066,0.015744781,-0.006830391,0.016013237,-0.006312492,0.030529978,0.039741278,-0.009126592,0.03110517,0.01605407,0.07701172,0.022656895,-0.015995426,-0.021496631,0.035767257,-0.017962469,0.00092715747,0.0015783211,-0.0138701005,-0.017045753,0.026599186,0.038982328,0.018915398,0.0019761769,0.020621615,-0.023996972,-0.0013452109,0.010285593,0.010968076,-0.05485106,0.022016961,0.02459858,0.01280464,-0.042953257,0.018960109,-0.04244585,-0.025149357,0.046356305,0.045878388,-0.008237764,0.026602564,0.011692055,0.06602211,-0.039250653,-0.0036699637,0.051213898,0.011199121,0.043882072,0.00020107708,0.0068242066,-0.029863745,0.0168755,-0.013898019,-0.025589341,-0.015946882,-0.009979239,0.018357221,-0.05960765,0.013832619,0.023473924,-0.03336079,-0.005722121,0.06145966,-0.032612078,-0.028475348,-0.00536206,-0.0017233074,-0.020128619,-0.033971213,0.01023862,-0.02205444,0.048027445,0.02783267,-0.0017964012,0.0096194865,0.04718802,0.029094309,0.030079754,-0.07456247,0.012464402,0.05527547,-0.073909804,-0.019903539,0.05905153,0.02436831,0.028903276,-0.019409662,-0.024593782,0.05179973,-0.023919404,-0.017351374,-0.036523007,-0.0049974406,0.010462216,-0.018834446,-0.014785593,-0.02072731,0.052128606,-0.051705137,0.013930024,-0.007894835,0.0066039315,-0.03710264,0.042199526,0.0096911425,-0.03752302,0.007386641,0.040479206,0.028145991,0.026624614,0.06442101,-0.007377933,0.034996442,-0.014244397,0.057891216,0.026332231,-0.007357907,-0.039968807,0.03356458,0.030637654,-0.019041572,-0.022467148,0.044461463,-0.03623301,0.08563501,0.014434265,-0.059195966,-0.022744514,-0.05684853,-0.018427184,-0.00595062,0.005482962,-0.008971894,-0.076461114,-0.0032583622,0.010095979,0.021221032,0.06822193,-0.009745342,-0.0053226133,0.03502457,0.051260743,0.06580052,-0.028761012,0.016252609,0.011246686,0.0015767901,0.019460725,-0.03763291,0.04995009,-0.038093947,-0.054433823,-0.017835375,-0.016222985,-0.026486369,-0.012902383,0.013130127,0.03541545,-0.008421281,0.021416342,0.014699414,0.012661799,-0.026499487,-0.03329853,0.026337339,-0.009062504,0.030680163,-0.0095342435,-0.06358057,0.008019061,-0.008749108,-0.04626353,0.034413036,0.027075045,-0.0078025223,0.027210306,-0.01330031,0.038891558,-0.015480649,-0.026579468,-0.061735366,0.028251186,-0.038541626,-0.03331307,-0.025521938,-0.014697102,-0.035013903,0.04657387,-0.02921637,-0.036859702,-0.0024390365,-0.02192983,-0.024395822,0.01758941,0.033454187,-0.009482758,-0.008389489,-0.0053354315,-0.019890422,-0.033280484,0.010395356,0.028601805,0.008762515,0.008158718,0.0248741,0.0196632,-0.04384908,0.012714645,-0.028382597,-0.0081838835,0.028183173,0.01098828,-0.028074898,0.020468364,-0.060371447,0.028244216,0.010670408,0.048452076,-0.013356601,-0.03189456,0.07015862,0.02042018,-0.0002495461,0.030439831,0.06878859,-0.0019533879,0.027576618,-0.055412788,0.09739881,-0.021447359,0.037640758,-0.011094885,-0.03155514,0.036266733,0.055909656,-0.0015503255,-0.0037473447,0.011634366,0.021411425,-0.05129617,0.05717706,-0.053463675,-0.019957963,0.024540694,-0.016866524,-0.03097877,0.031434402,-0.05073973,0.038882747,0.0029953397,-0.042455744,0.037479244,-0.002623016,-0.014657766,0.016760388,-0.023326833,-0.0056475266,0.014315101,-0.06541411,-0.009274538,0.004552545,0.026557827,0.033762507,-0.03770003,0.0057520564,-0.006123353,-0.01560905,0.0019080482,0.017848482,-0.002867892,0.0513623,-0.015510378,0.0017796454,-0.01400473,-0.03913963,-0.019264488,0.0034704562,-0.06288422,-0.07958039,0.032159496,-0.009526419,0.04620014,0.015198085,-0.0034638587,0.013488336,-0.0007410599,0.0018500063,0.030474728,0.019427955,-0.016309494,0.036528498,0.05778964,-0.022783695,0.0025093711,-0.008539384,0.02323512,0.015128733,0.04572284,0.019021377,0.06866409,-0.009086726,-0.06582386,-0.015983172,-0.010865307,0.07594353,-0.0098859705,-0.0010022536,0.014417588,0.00852327,-0.0032986857,-0.04177681,-0.031610664,-0.04992402,-0.013891603,-0.011988161,0.04526301,-0.019693248,-0.043674115,-0.028559962,-0.017598322,0.036006704,0.034701157,0.027990893,-0.029287059,-0.0399871,-0.06326318,-0.00753288,-0.01599218,-0.037329704,0.10498391,0.03407444,-0.0012836249,-0.01785774,0.009041207,0.036547128,-0.0076186126,0.05023877,0.0015013496,0.06411836,-0.046059467,-0.02062759,0.054051436,-0.035211653]	2026-01-20 16:05:57.985816+05	ЖК Capital Park. Melody. Адрес: г. Астана, Есильский район, пересечение ул. Бухар Жырау и Жошы Хана
d5800c89-ebee-4cf0-9e59-466bf0b1b56f	6b28ba79-f6fb-11ee-a82d-001dd8b72708	Capital Park. Sky	г. Астана, пр. Аль-Фараби, 3	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10319	71.45317	Бизнес		\N	https://bi.group/ru/landing/capitalpark-sky	https://s3.bi.group/biclick/6b28ba79-f6fb-11ee-a82d-001dd8b72708/6b28ba79-f6fb-11ee-a82d-001dd8b72708_foto_400.jpg	{}	\N	2026-01-20 16:05:59.425949+05	ЖК Capital Park. Sky. Адрес: г. Астана, пр. Аль-Фараби, 3
242f52e6-ff31-40e9-ba4f-9773a184393a	99c61421-2523-4174-8589-e1b24455868c	Capital Park. Art	г. Астана, пр. Аль-Фараби, 3/2	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10188	71.44999	Бизнес		\N	https://bi.group/ru/landing/capitalpark-art	https://s3.bi.group/biclick/99c61421-2523-4174-8589-e1b24455868c/99c61421-2523-4174-8589-e1b24455868c_foto_400.jpg	{"side": "Left", "tags": ["парк рядом", "школа рядом", "детский сад рядом", "EXPO рядом", "Ботанический сад", "Линейный парк", "NIS", "Binom School", "Назарбаев Университет", "Mega Silk Way", "ТРЦ", "супермаркет", "Magnum", "Small", "аптека", "кафе", "ресторан", "кофейня", "фудкорт", "магазины", "Астана Арена", "Барыс Арена", "Ледовый дворец Алау", "спорткомплекс", "фитнес-центр", "бассейн", "Республиканский диагностический центр", "Национальный научный кардиохирургический центр", "клиника", "больница", "Музей энергии будущего Нур Алем", "Конгресс-центр", "автобусная остановка", "удобный выезд на магистрали", "остановка общественного транспорта", "банкомат", "салон красоты", "химчистка", "почта", "банк"], "atmosphere": ["элитный", "семейный", "зеленый", "тихий", "красивый вид", "чистый воздух", "широкие дороги", "современный", "развивающийся", "престижный", "комфортный", "спокойный", "ухоженный", "безопасный", "инфраструктурно развитый"], "district_name": "Есильский"}	[-0.017023224,0.029178724,-0.020514276,-0.021092955,-0.030824605,-0.01416141,0.0072581233,-0.013451893,-0.0031473117,0.04777815,-0.012625901,0.040452678,0.040516812,-0.014640091,0.0070076687,0.007314338,0.053620744,0.03502543,-0.13393699,-0.039858602,0.021177473,-0.006845741,0.044638652,-0.010296314,-0.05285929,-0.047892597,-0.07621483,0.02874615,-0.002228725,-0.03770419,0.015536404,0.03857073,0.008449668,0.0086922115,0.0266293,0.010458083,-0.0180611,-0.04290921,0.038385488,-0.014919705,-0.0759288,0.033866126,0.021032438,0.018647993,-0.07821827,-0.06718708,-0.037773095,0.028994521,-0.053087488,0.012083273,0.023622459,-0.04775956,-0.031605646,0.05591447,-0.069635555,-0.013624426,-0.014965377,-0.030788304,0.061921995,0.003544238,0.021461422,-0.0028509567,0.007829169,-0.002242109,0.019949242,-0.031778052,-0.05848429,-0.022651631,-0.06598727,0.023862014,-0.031212462,0.102268904,-0.045602616,0.0073729265,-0.011833059,-0.033172667,0.016570827,0.003444963,0.05220077,0.05711671,-0.060959365,-0.01828564,0.031204276,0.028863173,0.0059613166,0.027228087,0.023109967,-0.02677009,-0.06667277,-0.020699719,0.06395443,0.028313724,0.03249367,0.026829958,0.06878817,0.025579827,-0.10883988,-0.09560128,0.07561199,0.011542555,0.009980886,0.02704738,-0.04658448,-0.06771618,0.0074211643,0.07464254,-0.06395386,-0.08570007,-0.057443842,0.018202212,0.013221912,-0.0074926107,0.029120674,-0.008579583,0.018172814,0.040633164,-0.084391825,0.057647225,0.011270008,0.04173389,0.017894099,0.0039913952,-0.016737362,0.041112885,-0.013504353,0.011248269,0.0029874744,-0.036973175,-0.046777997,-0.041149467,0.014932017,-0.02949232,-0.0022405048,0.0030104048,-0.035183433,0.024238687,0.061986458,-0.002589025,-5.2238265e-05,-0.00042485105,0.015747046,-0.056219857,-0.051521488,-0.016566144,0.020527935,-0.019116456,0.02611636,0.045519777,-0.024932016,0.005008654,-0.053471945,-0.01658105,0.023891263,-0.01774162,0.017771507,-0.0034106348,0.062422615,-0.05528609,0.0007005651,-0.039800536,0.047734275,-0.03131901,-0.034911748,0.0046845037,-0.015146203,0.002842515,0.0066551613,-0.024909483,-0.041205294,0.018198887,-0.023194382,-0.079517044,-0.016251259,-0.07328278,-0.009471864,0.009680777,-0.02659804,0.019701878,-0.0181505,0.024104644,0.09399418,-0.034529712,-0.014495784,-0.08398567,-0.008369337,0.030378954,-0.015134108,0.060387794,0.045513753,-0.0041380953,0.010472764,0.015179793,0.0063942717,0.06428954,-0.052703038,-0.033311468,0.03068082,-0.060851417,-0.009405326,-0.04555603,0.046094604,-0.036763772,-0.014932748,-0.05594993,-0.032751378,0.043148637,-0.031563587,-0.06707452,-0.050634854,0.04995557,0.005738134,-0.02111371,-0.032411344,-0.078548625,0.0281592,0.002699898,-0.005270657,-0.018577756,0.094887435,-0.09395301,0.003182085,0.021625241,0.07718046,0.025427258,0.057303786,-0.018136216,-0.0002031064,-0.027700018,0.015705416,-0.057211444,-0.0426864,-0.0041096937,0.0067718457,0.033480547,-0.005242127,0.04173122,0.0092857275,-0.044310957,-0.032652814,-0.019338604,-0.0181872,0.032707054,0.011309475,-0.034097545,0.01586091,-0.00037342872,0.045796566,0.04723436,0.038482882,0.013190354,-0.050749302,-0.012456325,-0.009069543,0.005334099,-0.06407654,-0.0636887,0.015286672,0.015321045,-0.035057362,-0.03997747,-0.0033227126,-0.019692348,0.023209456,-0.07193954,-0.0609666,-0.024634274,-0.02018195,0.0005365344,0.05127378,-0.028542362,0.073102474,-0.039182063,-0.030559054,0.006191899,-0.02505647,0.07737284,-0.025893144,0.035799835,-0.020358736,-0.052730307,0.041924115,0.016052576,-0.04102346,0.00930099,0.013692857,-0.052735727,-0.013060569,0.013755919,-0.035372816,-0.020739036,0.020324051,0.07019328,0.010627215,-0.009299589,0.012789836,-0.049661387,0.017516373,0.02785173,0.0008669418,-0.052932627,0.008786325,0.04445788,-0.04924567,0.030685818,0.0038352993,-0.043117747,0.0046406565,0.012092646,-0.021990137,0.026597837,0.012998304,0.031622577,-0.044871908,-0.039182555,-0.026737211,-0.010787966,-0.14896439,-0.061235234,0.030090373,-0.0029577983,0.026073907,0.073209904,-0.011643122,-0.0106327785,0.03551415,-0.002588921,-0.0220555,-0.04882329,0.056569695,-0.04360576,-0.0012376887,-0.00508675,0.0021338756,-0.043209244,-0.010703751,0.032342933,-0.07036402,0.016125364,0.037373018,0.005107573,0.034404133,0.031661335,-0.01157967,0.0056288983,0.0057877274,-0.035002176,-0.0008356216,0.012134864,0.025881324,0.00191785,0.014640074,0.011482058,-0.03181343,-0.044354964,0.04788892,-0.014350305,0.049891993,-0.0017563327,0.0053251204,-0.07768365,-0.019995477,0.0013922948,0.005319698,0.024543231,0.012895839,0.0035443024,-0.010640703,0.051595256,-0.05818558,0.011093862,0.033832785,0.034323186,0.014132216,0.019277379,-0.01895992,0.010774162,-0.031775676,0.0082776705,0.022447908,-0.0034548596,-0.0072231637,0.022055045,-0.010155504,0.026457928,-0.00037719164,0.061603703,-0.040816758,-0.013617013,-0.018649543,-0.017237054,-0.01655152,0.009963598,0.0028856792,0.044043604,0.012351941,0.04995417,0.040457524,0.072673805,0.044508982,0.0074540586,-0.004726305,-0.036053833,0.082655236,-0.0120299375,-0.0026179065,-0.0339499,0.03654226,0.015345438,-0.025444943,0.012523958,-0.018160978,-0.016157474,-0.029369965,0.020051664,-0.027010685,-0.025593055,-0.0124673415,-0.03312598,-0.0036142848,-0.026194813,-0.017972166,0.045673538,0.03291906,0.008317629,0.0051005404,-0.082101494,0.01301087,-0.0030650499,0.008884968,-0.00053808675,0.028506208,0.049035676,-0.016420402,0.0402484,0.022319116,0.08266457,-0.0053241444,-0.030997483,-0.029320616,0.029656345,-0.013534284,-0.0004804868,0.024731224,-0.009623358,-0.021273362,0.0369526,0.023297656,0.013872062,0.0071485844,-0.017137334,-0.029969173,0.0007648533,0.020408852,0.007817685,-0.05252654,0.031858373,0.02726803,0.010466875,-0.057426427,0.018116692,-0.033070438,-0.024939202,0.05194507,0.034621302,0.003516714,0.017333858,0.017699433,0.056409873,-0.01906409,-0.008219708,0.05327117,0.00906303,0.031184467,-0.0005324211,0.014407556,-0.014194653,0.019211097,-0.003301969,-0.041121516,-0.0168677,-0.010715761,0.030796561,-0.071693264,0.0066856993,0.03826011,-0.041789096,-0.0026349926,0.04391837,-0.023961522,-0.01811797,-0.009242358,0.016481023,-0.0111012785,-0.048913565,0.018437793,-0.012814094,0.051086262,0.038484238,3.5274457e-05,0.025297286,0.07189212,0.026145553,0.019029932,-0.075748704,0.011571818,0.05290467,-0.06683072,-0.024439687,0.063720636,0.0052674236,0.030112322,-0.016434709,-0.026508592,0.058561917,-0.022903394,-0.0237252,-0.02399648,0.0117827505,0.007874471,-0.030029928,-0.015314209,-0.027195962,0.037265986,-0.036962654,0.016447004,-0.007070327,0.0029010463,-0.03267861,0.034608793,0.015094523,-0.029038766,0.021126293,0.043758113,0.040289287,0.037903573,0.048581626,-0.008932504,0.055185415,-0.01919062,0.038526163,0.023375666,-0.020185987,-0.04061112,0.035835423,0.02248337,-0.020951638,-0.008755305,0.057276897,-0.041101232,0.05478125,0.012162889,-0.0525382,-0.047818184,-0.043117963,-0.02172189,-0.030441424,0.026968738,0.0023115785,-0.07529352,0.0069645112,0.012964065,0.0058549196,0.054475054,-0.016501456,0.014141617,0.023120679,0.043340825,0.06567779,-0.03561762,0.010432326,0.020914841,-0.010808716,0.020672308,-0.032179296,0.05422168,-0.042103343,-0.05425851,-0.012484158,-0.005097365,-0.032485932,-0.03272439,0.024633998,0.043695353,-0.0050857607,0.015255293,0.00874967,0.023910342,-0.03494487,-0.021974573,0.027372662,-0.0022846377,0.034858327,0.0034028662,-0.071544185,0.014267007,-0.007883299,-0.0488804,0.03555506,0.030758543,0.0029667334,0.023941293,-0.0021389704,0.03667129,-0.03684995,-0.029117119,-0.06548916,0.036247253,-0.027980141,-0.028150802,0.0015489453,-0.02762065,-0.022849217,0.031560935,-0.041859373,-0.052506756,-0.015312481,-0.027716644,-0.028936975,0.0064264643,0.016305832,-0.018062798,-0.0043337876,0.007442849,-0.013393114,-0.025919247,0.010587925,0.03024233,0.003207002,-0.018569527,0.01353277,0.037418444,-0.04568055,0.03496672,-0.028830862,-0.012616142,0.03415553,0.022859717,-0.022540428,0.031995635,-0.05202611,0.030622534,-0.0016638967,0.05089339,-0.0095411,-0.008317522,0.063540496,0.043366186,-0.011458918,0.0064068907,0.069458514,0.012117882,0.031564966,-0.053106077,0.090705045,-0.007390478,0.0322978,-0.01278622,-0.030520845,0.032310493,0.038831536,0.0010154631,0.004408315,-0.017891506,0.01211063,-0.0498586,0.06710876,-0.059945486,-0.008255296,0.016837562,-0.017517619,-0.042852994,0.015564019,-0.05472551,0.024193283,-0.009698331,-0.040564112,0.03795825,0.004380725,0.0032989506,0.0007690171,-0.019357663,0.007490586,0.009989743,-0.09281949,-0.029045962,0.010910336,0.035884283,0.036135357,-0.050190113,-0.0128505025,0.0011386593,-0.013997661,0.0055267825,0.023029454,-0.0056048427,0.04630577,-0.010811337,0.009336306,-0.004055917,-0.025315315,-0.020680632,0.0002465078,-0.06453921,-0.07547309,0.016672343,0.003554285,0.03694496,0.023959339,-0.0056724707,0.0015008327,0.013201591,0.010087373,0.011697618,0.03317574,0.0062168,0.06158357,0.054632783,-0.021276334,-0.0015540349,0.005539922,0.03258419,0.00079898426,0.035532083,0.01762116,0.06430508,-0.024752531,-0.06789817,-0.027810093,-0.011099106,0.07782311,-0.013002802,-0.011212068,0.016284311,0.021715641,0.0074065956,-0.044519626,-0.030795285,-0.04205529,-0.009051138,-0.01624312,0.038651362,-0.01381911,-0.040275406,-0.03885674,-0.009429614,0.020304397,0.048060495,0.026811915,-0.017545903,-0.057887122,-0.06357068,-0.008341818,-0.007023005,-0.03492889,0.0834495,0.03687877,0.017104423,-0.022162657,-0.011289078,0.030490115,-0.012115103,0.062196657,-0.0030698956,0.066733174,-0.052978024,-0.022396846,0.044340514,-0.04387214]	2026-01-20 16:05:51.185878+05	ЖК Capital Park. Art. Адрес: г. Астана, пр. Аль-Фараби, 3/2
37877142-0d66-4025-b07e-db8ce1d1cb9b	32453f14-664f-11ed-a82b-001dd8b726aa	Aisar	г. Астана, ул. Е-321, 6/2	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.06334	71.42546	Комфорт+		\N	https://bi.group/ru/landing/aisar	https://s3.bi.group/biclick/32453f14-664f-11ed-a82b-001dd8b726aa/32453f14-664f-11ed-a82b-001dd8b726aa_foto_400.jpg	{"side": "Right", "tags": ["школа рядом", "детский сад рядом", "супермаркет рядом", "аптека рядом", "парк Жеруйык рядом", "поликлиника рядом", "остановки общественного транспорта рядом", "кафе рядом", "рестораны рядом", "фитнес-центр рядом", "ТРЦ Astana Mall рядом", "ТРЦ Ailand рядом", "рынок Шапагат рядом", "спортивные площадки", "детские площадки", "удобный выезд на главные улицы", "банки рядом", "почта рядом", "салон красоты рядом", "стоматология рядом", "АЗС рядом"], "atmosphere": ["семейный", "спальный", "развитая инфраструктура", "широкие дороги", "уютный", "чистые улицы", "хорошие дороги", "ветреный", "пробки (в часы пик)", "много зелени во дворах", "доступные цены"], "district_name": "Алматинский"}	[-0.017114049,-0.013846461,-0.0210492,-0.0035220436,-0.030829616,-0.026551167,0.011218216,-0.03087644,-0.009933594,0.063502006,-0.016088793,0.03678677,0.048393838,-0.031154037,-0.016515484,0.0069963178,0.023351988,0.034500733,-0.11764898,-0.011107368,0.029695883,-0.029220656,0.05624415,-0.013419946,-0.04499318,-0.04966394,-0.042531405,0.032126475,-0.0059318314,-0.009756945,0.0293548,0.052022718,-0.002352295,-0.022048948,0.026455997,0.0466775,-0.03287689,-0.053336985,0.024846388,-0.032353185,-0.049982168,0.049597267,-0.0022006915,-0.022361403,-0.0786001,-0.057141792,-0.031696,0.019813893,-0.05387876,0.008380824,-0.02625353,-0.04948922,-0.03302622,0.035888318,-0.10685215,-0.025016839,-0.009525004,-0.029309591,0.07078882,-0.005554501,0.01610843,0.0043111877,0.0038656686,-0.00023792776,0.019866852,-0.016420297,-0.06675883,0.01171108,-0.03345222,0.02003661,-0.02504401,0.03266617,-0.023786563,0.016868856,0.008447969,-0.014461605,-0.00083732675,0.021271117,0.044100985,0.043764323,-0.07042826,-0.024753856,0.024131583,0.0070721265,0.025219696,-0.017690882,0.000509019,-0.048939943,-0.045225546,-0.039757278,0.061656255,0.035248775,0.020443508,0.021807598,0.067109756,0.0111917285,-0.13916914,-0.12113163,0.08098252,0.012573006,0.03014144,0.010212764,-0.03703329,-0.06381477,0.022127243,0.067949004,-0.043965958,-0.046477124,-0.0721788,-0.018005202,-0.011108039,-0.001155275,0.026273882,0.0076332,0.004141057,0.038887396,-0.067838326,0.066901706,0.0009023429,0.037811812,0.0353658,0.008123811,-0.02030973,0.038790163,0.042167712,0.0242816,0.0383974,-0.019955864,-0.022397297,-0.018972358,0.03605887,-0.050623406,0.012892644,0.011147852,-0.026250333,-0.022217222,0.045391746,-0.061150387,-0.007359301,-0.017011443,0.0018334339,-0.029110676,-0.070356645,-0.016441738,-0.0008163364,-0.022486402,0.029522715,0.07572431,-0.04700843,0.026658634,-0.07577051,-0.02052591,0.04398132,0.009984963,0.018854246,-0.022375535,0.079513244,-0.073507056,0.008781641,-0.059454523,0.049670774,-0.056614134,-0.018652095,0.026837835,-0.006249618,-0.009658211,0.027590564,-0.019970488,-0.04613526,0.008973568,-0.04592403,-0.07269531,0.0061086924,-0.049828522,-0.019468505,-0.0031136465,-0.046756584,0.017149063,-0.0037089828,0.027770001,0.12659484,-0.02014808,-0.004136984,-0.084313124,0.0068789404,0.005622683,-0.016687855,0.041645456,0.044258177,0.010317024,0.025592046,0.0072830627,0.01882937,0.07007349,-0.05240957,-0.02209674,0.034549177,-0.060440417,0.03363469,-0.05057719,0.050917316,-0.053415876,-0.011012767,-0.016439743,-0.02650025,0.026731804,-0.022199463,-0.05954389,-0.038155995,0.040395986,0.0045115855,0.018147489,-0.04322537,-0.05848546,-0.0020766873,0.004180316,-0.005227551,-0.014912267,0.06865925,-0.0735384,0.0016316419,-0.0021857165,0.054030925,0.006910675,0.04923008,0.005513657,0.017244244,-0.018216405,0.009821368,-0.020066554,-0.03859427,-0.017218394,-0.015395379,0.0571212,-0.017401334,0.03594315,0.017978072,-0.038036343,-0.04180457,-0.005579412,-0.008717307,0.029258052,0.032543115,-0.038397815,-0.00078715186,-0.0072340085,0.058178104,0.026260637,0.021328114,0.010706602,-0.048077535,-0.018811222,-0.017430693,0.015529676,-0.04817303,-0.043858755,0.024059942,0.018488023,-0.03133861,-0.023381444,0.0002514637,-0.026041983,0.026685543,-0.083734356,-0.076274596,-0.020505328,-0.026990823,0.035556927,0.06997318,-0.029020831,0.04765532,-0.0325126,-0.03325685,0.015962634,-0.018235335,0.06828445,-0.012191273,0.02764137,-0.023364186,-0.0258322,0.06426176,-0.023778828,-0.023507724,-0.013842331,0.021879794,-0.06794961,0.0051192204,0.012133661,-0.042103663,-0.019177286,0.011588704,0.045214612,0.002497303,0.0009798937,0.023751277,-0.030008944,0.011487049,0.023890084,0.01288605,-0.03881224,0.00047231908,0.050601203,-0.05334819,0.031481978,-0.016295739,-0.06898765,-0.009668072,0.01150083,-0.022642633,-0.009646259,0.024631986,0.042709544,-0.056747682,-0.054181576,-0.053465072,-0.0028394964,-0.14046144,-0.033710107,0.008570595,-0.0019584463,-0.016298674,0.06445313,0.010415534,0.0035768943,0.04268021,0.0054398878,-0.022779074,-0.028086886,0.05669719,-0.0411993,0.020382259,-0.009883584,-0.033869546,-0.07943996,-0.027143043,0.014550267,-0.079817645,0.027200093,0.052747656,0.042401537,0.06377555,0.045139827,0.0051130955,0.019599803,0.02722837,-0.009188768,0.00686585,0.00756622,0.018220508,0.018991146,0.033671536,0.03843573,-0.011716154,-0.07176508,0.020860892,-0.001914709,0.02235702,0.0033097682,-0.005568133,-0.052709244,-0.03637782,0.014279983,0.003981534,0.014736607,-0.002885167,0.023737866,-0.026760237,0.043269366,-0.04900036,-0.023746435,-0.00061748177,0.0289465,0.0134038115,-0.0052673426,-0.002196702,0.0007548815,-0.016684396,0.010492752,0.027563067,-0.023515165,0.0020190396,-0.012694394,0.020576077,0.039666384,-0.0013154037,0.084505245,-0.043304153,-0.011048672,-0.03854549,0.0006975195,0.00020331515,0.016516322,0.009175096,0.056571607,0.022857405,0.026140993,0.020043258,0.0808594,0.031212984,0.031650115,0.012788859,-0.022513483,0.07854732,-0.049085613,-0.02839808,-0.034728516,0.046049435,-0.011008751,-0.026281558,0.011381728,-0.03714446,-0.040520057,-0.017106632,0.008049497,-0.059445843,-0.024976617,0.0045550265,-0.018702364,0.006198667,-0.022946618,-0.006723225,0.03454217,0.021558529,-0.018017769,0.029646855,-0.0708184,-0.006198237,-0.024755264,-0.0009869334,0.0046487814,0.051241357,0.054694265,-0.005456296,0.03207783,0.025481146,0.06502261,0.0013072432,-0.048404664,-0.018297615,0.006477736,-0.015379506,0.0029751097,0.017593224,0.020071032,0.0004262494,0.056947697,0.029000847,0.003952846,-0.047914762,-0.014415418,-0.032919317,0.009559562,0.001224167,0.016305203,-0.057424586,0.010306982,0.014693796,-0.009114246,-0.051010113,0.03519205,-0.05391656,-0.025946029,0.031330757,0.02858792,-0.024038399,0.025732983,0.005609451,0.067835815,-0.018571228,-0.018187465,0.04132791,0.01275019,0.02164563,0.008333944,0.01912379,0.017420033,0.015552032,-0.004269544,-0.064754315,-0.051024474,-0.005077353,0.04473172,-0.04647113,0.0054107076,0.046872124,-0.050332252,0.0018592922,0.042118806,-0.037040215,-0.0394217,-0.023169845,-0.019287994,-0.013523841,-0.027340373,0.03291684,-0.020551419,0.05598587,0.03181655,-0.032399856,0.020524412,0.055667173,0.02660512,0.018217685,-0.044393074,0.009979401,0.06103115,-0.0466805,0.010986166,0.048694964,0.018564671,0.021719329,-0.01104908,-0.02069266,0.06123375,-0.022989204,0.00042157285,-0.033426918,0.0294418,-0.008418686,-0.04378633,-0.01243426,-0.029996004,0.022482144,-0.014645327,0.017569052,-0.007043885,-0.015291382,-0.023994334,0.012126171,0.01042569,-0.033173434,-0.006007017,0.04447333,0.06676833,0.015455597,0.044375982,-0.0011434528,0.03682867,0.028734524,0.039773688,0.032326356,-0.024147803,-0.0365042,0.030489556,0.03423234,-0.022547945,-0.016717501,0.051809564,-0.037837327,0.06639556,0.02282743,-0.071846396,-0.039404117,-0.050885666,-0.00029133796,-0.030948805,0.023303665,0.008295402,-0.06511462,0.0014965881,-0.02269842,-0.036885,0.02485768,-0.026158152,0.0005266927,0.003993188,0.027352203,0.07089138,-0.044775177,0.008128999,0.028620064,-0.015677024,0.015933536,-0.047579452,0.03478219,-0.02134632,-0.053322766,-0.032074843,0.0034746872,-0.032287166,-0.053474452,0.028878806,0.020565296,-0.01231365,0.025875961,-0.032554958,0.026230644,-0.0028461542,-0.03809975,0.010732468,-0.0056692767,0.035859846,-0.009431068,-0.08678104,0.007192409,-0.0057181534,-0.016460927,0.022139218,0.044706505,0.0023564075,0.030616077,0.0074522374,0.041138496,-0.046577338,-0.021827154,-0.066795185,0.05583424,-0.012920271,-0.018423513,-0.03732262,-0.030224832,-0.012079671,0.032472845,-0.044222176,-0.041631922,-0.014498352,-0.009841195,-0.035822418,-0.0019055891,0.03387102,-0.041526157,-0.0024362411,-0.012301486,0.012804682,0.0016558062,-0.042177584,0.01906556,0.0233654,-0.026280269,-0.007676077,0.041505765,-0.042367924,0.014591435,-0.024021355,-0.011953957,0.040569518,-0.0010263111,-0.053252485,0.05642741,-0.053757917,0.0055340454,0.0028228986,0.08472254,-0.011590811,-0.040083107,0.057273757,0.052700434,-0.0219928,0.014643686,0.06059103,0.022572381,0.008539151,-0.04935178,0.09563827,-0.012474467,0.023672197,-0.013069198,-0.04623231,0.033278752,0.027880264,-0.035945855,-0.0032592139,0.002978483,0.017328171,-0.063001946,0.033327695,-0.042138696,0.0033009797,0.04023832,-0.0039910288,-0.032681562,0.022739504,-0.042874135,0.0058319476,-0.019389896,-0.03759632,0.019443154,-0.01243399,-0.021368386,-0.0031497313,-0.015259912,-0.0056933947,0.006441712,-0.06612993,-0.016090296,-0.018234616,0.02398968,0.035384744,-0.047553726,-0.036206547,0.0011454776,-0.022002067,0.0013147605,0.0007769294,-0.009104649,0.03715447,-0.0074176216,-0.007500834,-0.024252607,-0.027280308,-0.016098956,0.0076659946,-0.086022034,-0.055158075,-0.014015571,0.0014864,0.049904205,0.014757709,-0.010900232,0.0044079735,0.022057911,0.0155890435,0.010226262,0.03233412,-0.012369039,0.03607603,0.04267041,-0.021559918,0.0038120863,0.0073244134,0.05104661,0.011752723,0.028285205,0.0219605,0.051105723,-0.02130572,-0.08872565,-0.029105062,-0.0014473042,0.058661662,0.014131305,0.0102326125,0.019194575,0.030194899,0.029262872,-0.044391308,-0.026721127,0.0010660974,-0.017692342,-0.0067030415,0.03917487,-0.0075057093,-0.031587053,-0.020354448,-0.0039615217,-0.008217885,0.03542243,-0.0002239243,-0.026659101,-0.031108672,-0.05526737,-0.013430944,-0.006481218,-0.019199522,0.09630577,0.013979766,0.0057603987,-0.039918005,-0.02785876,-0.0055957567,-0.015532943,0.045458496,0.020186579,0.06415423,-0.03463544,-0.0029578258,0.060228795,-0.014980398]	2026-01-20 16:04:47.657323+05	ЖК Aisar. Адрес: г. Астана, ул. Е-321, 6/2
ab56f36d-cc97-46bc-ac64-9a7ecee9da0a	233a4419-150b-4439-af19-299428fe4f70	Bosağa	г. Астана, вдоль пр. Улы Дала	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.08649	71.48512	Комфорт+		\N	https://bi.group/ru/landing/bosaga	https://s3.bi.group/biclick/233a4419-150b-4439-af19-299428fe4f70/233a4419-150b-4439-af19-299428fe4f70_foto_400.jpg	{"side": "Left", "tags": ["expo", "экспо", "ботанический сад", "botanical garden", "mega silk way", "мега", "nazarbayev university", "назарбаев университет", "binom school", "бином", "школа рядом", "детский сад", "супермаркет magnum", "супермаркет small", "аптека", "кофейня", "ресторан", "фитнес центр", "тренажерный зал", "линейный парк", "linear park", "остановки рядом", "автобусные маршруты", "дорога в аэропорт", "медицинский кластер", "кардиохирургический центр", "центр материнства и детства", "фудкорт", "детская площадка", "охраняемая территория", "видеонаблюдение", "подземный паркинг", "гостевая парковка", "велодорожки", "прогулочная зона", "банки", "банкоматы", "салон красоты", "химчистка", "цветочный магазин"], "atmosphere": ["деловой", "современный", "семейный", "молодежный", "ветреный", "широкие дороги", "активный трафик", "перспективный район", "развитая инфраструктура", "чистые улицы", "ночные огни", "урбанистичный", "динамичный", "престижный", "открытое пространство"], "district_name": "Есильский"}	[-0.015653932,0.030782554,-0.023749825,0.006497859,-0.0076662526,-0.013596428,-0.008752944,-0.013977531,-0.01585689,0.034797914,-0.0038909838,0.041906737,0.059395052,-0.0153363105,-0.008967964,-0.0035603158,0.0400386,0.046323173,-0.106720276,-0.038726993,0.01938933,-0.018593557,0.06846243,-0.028300403,-0.07110053,-0.063097894,-0.07248455,0.012399597,0.005058911,-0.0016351885,0.048517074,0.027650654,0.009429256,0.021554708,0.028181924,0.038710028,-0.025192838,-0.028333545,0.05039031,-0.016040247,-0.05595604,0.044586193,0.011060143,-0.0017316655,-0.07020343,-0.07248154,-0.009107553,0.015876316,-0.02658224,0.013009361,0.0006696301,-0.027769394,-0.024043655,0.054013237,-0.07873995,-0.003929473,-0.027004596,-0.010165357,0.051992103,0.017079445,0.019282436,0.015201013,-0.0024031498,-0.0033833226,0.013212456,-0.03172249,-0.0700469,0.00058812747,-0.06902548,0.014978799,-0.041815005,0.08736832,-0.07783245,-0.0042974027,-0.007402418,-0.030183401,-0.0027788382,0.026245806,0.04876592,0.049762953,-0.06182298,-0.005034342,-0.0006601015,0.009499986,0.006913246,0.005333903,-0.003997805,-0.047398366,-0.064673185,0.0056704045,0.07637834,0.04087003,0.03158145,0.01910044,0.08152778,0.039507445,-0.101610094,-0.109629974,0.056619465,0.020307511,0.031186974,0.031935323,-0.026268039,-0.07266502,0.018312767,0.073857196,-0.056519866,-0.060520217,-0.05548502,0.030613823,-0.0049516936,-0.0006547118,0.049725752,0.00081239536,0.021662401,0.040885378,-0.059555855,0.057936534,-0.023922276,0.042615864,0.024336858,0.0132585075,-0.008947425,0.030017229,0.007997556,0.020405062,0.015555961,-0.04063005,-0.06962455,-0.029814532,0.0053889384,-0.035187945,0.013167392,-0.00295483,-0.057101592,-0.0011581477,0.06434871,-0.017124053,-0.0015048371,-0.012537235,0.012172648,-0.028899277,-0.032698423,-0.008945975,0.009097373,-0.029445365,0.03200511,0.07663109,-0.027088521,-0.0025872786,-0.07287636,0.0053349454,0.020582912,-0.017471775,0.00010859322,-0.015104474,0.086341605,-0.033818282,0.007504404,-0.03467608,0.07801836,-0.030851923,-0.02502659,0.014880202,-0.007464238,0.002771882,0.019791685,0.003163641,-0.05032245,0.023472369,-0.039240792,-0.0707773,0.011032379,-0.05163402,-0.018376749,0.010663768,-0.054428436,-0.018462209,-0.011579112,0.029642364,0.109489515,-0.012479694,-0.01308935,-0.08205113,0.0034513306,0.0264211,-0.00057461474,0.04765675,0.062234014,0.008337677,-0.0037622566,0.02065819,-0.014840109,0.052755445,-0.07399893,-0.031266138,0.03604867,-0.071695775,0.023195382,-0.063419856,0.04814763,-0.04363089,0.01773803,-0.0429529,-0.032936078,0.043955944,-0.017108975,-0.054423172,-0.030855684,0.048529454,-0.0066283243,-0.019181658,-0.042033304,-0.067689605,0.020448087,0.013363987,0.014165031,-0.02060825,0.08549877,-0.08192176,-0.017746253,0.0022466048,0.084048174,0.052931607,0.0599671,-0.029175576,-0.0016591699,-0.028793178,0.00081823196,-0.049604196,-0.03805922,-0.018053245,-0.010113467,0.048855532,0.020424807,0.04279787,0.022074344,-0.07483686,-0.031676814,-0.007508129,0.0070881625,0.018227493,0.028005235,-0.008375802,0.01143862,0.015684271,0.044406254,0.038429417,0.037257195,-0.0038531055,-0.057162426,-0.0045032497,-0.025440592,-0.0043213964,-0.032524932,-0.05111593,-0.0052387216,-0.00528232,-0.034104828,-0.014643551,-0.025211975,-0.03459293,0.015108345,-0.06579439,-0.066534646,-0.038378537,-0.023643844,-0.00457485,0.049035367,-0.023513312,0.09013176,-0.031140039,-0.036523182,0.0026300973,-0.015270801,0.04873884,-0.056198183,0.047574904,-0.018633295,-0.03330186,0.045176793,-0.0056685274,-0.020001385,0.006463659,0.023620162,-0.06671771,0.022664357,0.014041274,-0.014118429,-0.0011591741,0.018778605,0.07346529,-0.008017437,-0.013659611,0.020399427,-0.027379297,-0.0021533153,0.034285963,0.00903537,-0.05416719,0.004393893,0.06235902,-0.04869991,0.025262114,-0.0010012372,-0.021447439,0.00039956957,0.0079430705,-0.014310763,0.0028928411,-0.015976174,0.03205357,-0.056378186,-0.025549047,-0.030776864,-0.007021778,-0.15729591,-0.03175907,0.020764066,-0.001324645,0.0019315757,0.086216904,-0.021642115,-0.004452578,0.06714885,-0.030465212,-0.048157256,-0.063839704,0.04575168,-0.05183725,0.010785825,-0.002491543,-0.020666236,-0.050563727,0.010485214,0.045543272,-0.09824168,0.018578168,0.06237067,0.012341804,0.07150055,0.050440617,0.004403358,-0.004269327,0.0057344446,-0.023244988,0.0014667084,0.007178254,0.02685759,0.012790581,0.007980436,0.0082629975,-0.030615952,-0.04824951,0.042718552,0.011962276,0.04955229,0.017636571,-0.016598955,-0.047366455,-0.017903036,-0.00081029866,0.009545672,0.030158557,-0.009701357,-0.0029377143,-0.021630524,0.05892942,-0.070582606,-0.01800631,0.020022688,0.039834462,0.0072115837,-0.00044079043,-0.006874314,0.008512708,-0.026463185,0.007833036,0.01833367,0.0016588414,0.024102552,-0.0050274995,0.014022169,0.050610617,-0.015152507,0.055353995,-0.04392968,-0.02956248,-0.020238882,-0.00013604897,-0.0025426496,0.035830393,0.0034594643,0.037321728,0.02383318,0.00946942,0.043112364,0.08469657,0.030525856,0.021420939,0.01576475,-0.01680059,0.082086295,-0.014765314,-0.017039888,-0.029314334,0.038925536,0.036850657,-0.011881728,0.0090686055,-0.020051183,-0.0074966233,-0.025543772,0.008712158,-0.042020135,-0.011909099,0.026344795,-0.04069078,6.807682e-05,-0.026330851,-0.027942564,0.036683254,0.037202977,0.008617473,0.00020224026,-0.078417994,0.0009317868,-0.0043859133,-0.011635968,-0.012621605,0.04019667,0.040367372,0.011005748,0.052453645,0.029568914,0.07782382,0.018884743,-0.013648428,-0.038196266,0.015213701,-0.025423938,0.015281633,0.036679894,-0.008556447,-0.0036385567,0.02144074,0.034013268,-0.0011457388,-0.0029729854,-0.014471682,-0.03781209,0.0012534935,0.008541265,0.015284586,-0.05373801,0.039019432,0.024947045,-0.005152047,-0.035207674,0.026182123,-0.042285156,-0.027766662,0.0500899,0.017806774,-0.014595743,0.0116895735,0.018269304,0.05753779,-0.025789488,0.002675634,0.061567698,-0.008855889,0.031946845,0.003464126,0.016366074,-0.005086841,0.02011231,-0.005153944,-0.020006964,-0.03426084,-0.016769687,0.030440954,-0.06453763,-0.02455001,0.06454072,-0.055273805,0.0067803175,0.0487945,-0.016049532,0.011593502,-0.0068256753,0.00838076,-0.03377188,-0.049836043,0.02087594,-0.026627872,0.040092275,0.036361244,-0.00190435,0.045831725,0.08515595,0.043301735,-0.0020967696,-0.07495434,0.0018535408,0.07756337,-0.04948326,-0.0063567003,0.07836927,0.021726346,0.033383742,-0.0118784765,-0.019303022,0.051143527,-0.014638782,-0.0043930053,-0.036338665,0.011579977,-0.0042614504,-0.025962071,-0.0074010123,-0.015700005,0.052128945,-0.050610688,0.005604956,-0.011422401,-0.0025159738,-0.026913643,0.023045786,0.0071956203,-0.020103466,0.009284616,0.05298418,0.048696987,0.02517121,0.04245207,0.006916916,0.061551444,0.0054686056,0.050839115,0.006664818,-0.014534425,-0.028381586,0.0045182575,0.011983681,-0.021404225,-0.019099804,0.07533254,-0.022850828,0.04293655,0.026434634,-0.047007237,-0.03911243,-0.049675312,-0.013223683,-0.05001845,0.01722202,0.0086817015,-0.08905515,-0.013878487,0.031704497,-0.02158551,0.037789945,-0.0066101192,0.0033072385,0.010550331,0.034259696,0.04720356,-0.023327133,0.020156693,0.03582948,-0.017614298,0.011633159,-0.023372915,0.045800608,-0.052984625,-0.038431138,-0.015146036,0.0055061607,-0.05142744,-0.04067535,0.006685407,0.02373749,0.0052280794,0.026841039,-0.005880611,0.026759291,-0.040401984,-0.018124767,0.031137224,-0.01813166,0.07335897,0.0019285696,-0.0547662,0.008631252,-0.0047868686,-0.039457966,0.035097778,0.017867701,0.008208207,0.033522572,0.0066040256,0.031425506,-0.042762112,-0.021325307,-0.050450247,0.032666054,-0.02095615,-0.01699619,0.010898952,-0.009017152,-0.0110402545,0.037007462,-0.03765039,-0.029737862,-0.013466721,-0.031395666,-0.02659873,0.0081087435,0.014469694,0.007795397,0.0029576672,-0.030285403,0.0001242742,-0.01163388,0.015524373,0.0297049,-0.006380327,-0.019324701,-0.0049388926,0.03399405,-0.047379717,0.0029402368,-0.0302525,-0.018641528,0.016909609,0.022178626,-0.01844299,0.034582317,-0.03180916,0.014209742,0.008716656,0.051548667,0.0077647213,-0.018445397,0.07181673,0.01695578,0.00768286,0.007780226,0.07310309,0.01414371,6.7572386e-05,-0.050267335,0.094232924,-0.017003106,0.028957225,-0.015373343,-0.0139310835,0.026518019,0.024261514,-0.022157155,-0.014023618,0.010524681,0.0064100707,-0.045362175,0.042752463,-0.04366607,0.013788755,0.02452569,-0.0083414335,-0.030240644,0.022040086,-0.0525098,0.027057607,8.314408e-05,-0.027178366,0.021282433,-0.018936615,-1.624372e-05,0.002376541,-0.03550922,0.005947005,0.012403719,-0.07901374,0.00010967664,0.0020679382,0.00563051,0.013024452,-0.03225024,-0.028528702,-0.0014479918,0.0028167702,0.0020350714,-0.011430751,-0.0024182182,0.02505333,0.0023094097,-0.00064304477,-0.017707143,-0.027476208,-0.032935206,0.024114328,-0.050275866,-0.047257103,0.02618094,-0.013428407,0.044817854,0.014314742,-0.015105034,-0.017983295,0.010636811,-0.00237551,0.016283566,0.042853456,0.0017797832,0.05671469,0.035665363,0.005930051,0.00039160257,0.024539901,0.027394252,0.0061402256,0.022224836,0.028912302,0.055333573,-0.030835798,-0.09925343,-0.017444707,-0.013767228,0.06724114,0.013374522,0.0033650114,0.0056711654,0.021730168,-0.012651568,-0.05397665,-0.0349887,-0.024089113,-0.021032473,-0.007520287,0.027927743,0.009278009,-0.021831624,-0.035751197,-0.007896914,0.025929965,0.04749796,0.009936857,-0.0073327143,-0.07275644,-0.06362302,0.006589292,-0.002370507,-0.010488934,0.06618966,0.005736133,0.033011504,-0.021005012,-0.025193812,0.0427154,-0.012241275,0.06121088,0.007774341,0.068075195,-0.04414668,-0.01934483,0.060123388,-0.015377204]	2026-01-20 16:05:38.817245+05	ЖК Bosağa. Адрес: г. Астана, вдоль пр. Улы Дала
c1788e5b-ec5e-4712-b573-1d782de3e7cb	48df0528-245d-411c-b26e-2c3ac08863d9	Family Gardens	г. Астана, ул. Е-314, район коттеджного городка Family Village	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.06892	71.42416	Бизнес+		\N	https://bi.group/ru/landing/family-gardens	https://s3.bi.group/biclick/48df0528-245d-411c-b26e-2c3ac08863d9/48df0528-245d-411c-b26e-2c3ac08863d9_foto_400.jpg	{"side": "Left", "tags": ["школа рядом", "детский сад рядом", "Назарбаев Университет", "Haileybury Astana", "QSI International School", "НИШ (Назарбаев Интеллектуальная Школа)", "супермаркет рядом", "магазины у дома", "кафе", "рестораны", "Mega Silk Way", "ТЦ", "продуктовый магазин", "парк рядом", "Ботанический сад", "велодорожки", "детские площадки", "спортивные площадки", "зоны для прогулок", "фитнес-центр", "остановки общественного транспорта", "удобный выезд на основные магистрали", "аэропорт рядом", "Международный аэропорт Нурсултан Назарбаев", "аптека рядом", "клиника", "EXPO рядом", "охраняемая территория", "закрытый жилой комплекс", "чистый воздух", "тихий район", "семейный район", "элитный район", "новый район", "малоэтажная застройка", "широкие дороги", "современная архитектура", "безопасный район", "комфортное проживание", "развитая инфраструктура", "уютный двор", "паркинг", "частный сектор", "коттеджный городок"], "atmosphere": ["тихий", "семейный", "зеленый", "элитный", "чистый воздух", "широкие дороги", "спокойный", "современный", "уютный", "безопасный", "развитая инфраструктура", "комфортный", "малоэтажная застройка", "ветреный", "красивый вид"], "district_name": "Есильский"}	[-0.016839981,0.009268205,-0.025085116,-0.014148177,-0.005470009,-0.010586882,0.0016071508,-0.025571354,0.010807055,0.017508592,-0.025550205,0.026799021,0.06110792,-0.057247013,-0.010742183,0.02220806,0.060971525,0.058953162,-0.10805063,-0.012715512,0.042926777,-0.0032809745,0.061104067,-0.026201837,-0.053394753,-0.054408398,-0.055617847,0.015301637,0.0037800644,-0.023752669,0.035917703,0.05009874,0.011117213,-0.011971941,0.009468776,0.015120544,-0.036182493,-0.041058168,0.050902836,-0.0068567884,-0.048045747,0.030104972,0.025807178,0.0040969746,-0.078385,-0.07323879,-0.028912218,0.021404613,-0.04472177,0.020808041,-0.0022182898,-0.036022596,-0.0032600334,0.042133454,-0.07344574,0.004755059,-0.042864006,-0.017955601,0.07644083,0.00091725227,0.01011246,-0.0049736975,0.016217003,-0.02160798,0.011102478,-0.024406275,-0.061883077,0.0030180283,-0.06038062,0.00066006294,-0.00038679643,0.13170052,-0.025224635,0.018180896,0.010647954,-0.0013079755,0.0066557685,0.0013293051,0.043501355,0.0695686,-0.06697474,0.015406564,0.026878614,0.0043717846,-0.007777588,0.0046575963,-0.0056191063,-0.030401738,-0.06623773,-0.023873072,0.073569015,0.045558095,0.04011991,0.029652061,0.06105009,0.025899451,-0.11041675,-0.10890217,0.049577758,0.041110784,0.06381898,0.02594973,-0.03723157,-0.08298631,0.010787932,0.06188532,-0.07168949,-0.056373812,-0.06584122,0.003920273,-0.00042612964,-0.028560055,0.010392695,-0.0077976706,0.0070275213,0.025418364,-0.08602644,0.05255297,-0.011011032,0.025067827,-0.00018367059,0.01702582,0.014785787,0.031853635,0.019695945,0.025427813,0.023422431,-0.03283497,-0.04877562,-0.015307887,0.008469065,-0.051406648,-0.013415218,-0.0029815515,-0.03130183,0.00065985066,0.06324623,-0.020006932,0.021518633,-0.008038971,0.024261069,-0.033959735,-0.03828361,-0.017729674,0.008304258,-0.031462748,0.042045552,0.05344681,-0.021263681,0.034094915,-0.07147056,-0.03446155,0.028483827,-0.014545868,0.02770721,-0.0065526413,0.07576765,-0.0569088,0.02437456,-0.02587241,0.04899885,-0.03155778,-0.04295198,-0.00024375026,-0.013874225,-0.020275317,0.00050264306,-0.011836774,-0.024301518,-0.013613779,-0.042838093,-0.074751414,-0.033862516,-0.051496375,-0.023522021,0.0073849494,-0.028021298,0.00405796,0.0016871981,0.0034788428,0.10510496,-0.016706241,-0.0070445756,-0.07197598,0.0006595721,-0.00027955067,-0.0044014975,0.04197136,0.03464564,0.003393972,0.017633658,0.013858383,-0.0034334399,0.06598111,-0.05184787,-0.04571869,0.04268507,-0.10271214,0.016581343,-0.048304547,0.030306473,-0.036376894,0.0033429055,-0.036065433,-0.003745605,0.041314352,-0.022447238,-0.068987936,-0.047307853,0.046285305,0.025742382,0.021126727,-0.05513564,-0.093363985,0.013349303,0.027371299,0.013374743,-0.023048075,0.079446785,-0.09762648,-0.0136959385,0.0085249115,0.06378838,0.025903728,0.05071614,-0.0431417,-0.0006563017,-0.024249295,-0.013223677,-0.028202975,-0.02485482,-0.00061796966,0.01433886,0.035365146,-0.026587458,0.045604903,0.033711135,-0.065976255,-0.047520265,0.002548726,-0.020587707,0.02082998,0.023992157,-0.035431977,0.007776086,-0.0067503285,0.060419045,0.053731054,0.03643043,0.014269271,-0.045372624,-0.019055331,-0.0011254611,0.0008503046,-0.045533273,-0.018445991,0.01690639,0.0050865375,-0.033922035,-0.02724232,0.011747984,-0.029757122,0.012379022,-0.078129925,-0.058229383,-0.020264065,-0.021432819,0.0064559192,0.05691309,-0.02715876,0.059131656,-0.041452836,-0.02015452,-0.01162844,-0.011859456,0.06501221,-0.035137136,0.03821971,-0.025593748,-0.045759644,0.040725548,0.0030677505,-0.023887122,0.0033679542,0.03428585,-0.07656073,0.0044244356,0.011472607,-0.020859387,-0.022870451,0.02058381,0.06290882,0.0065487414,0.02318992,0.012079722,-0.031883754,-0.0005514747,0.018038627,-0.006628928,-0.034586042,0.0075416947,0.046799965,-0.017770758,0.023103876,-0.0024104586,-0.021021921,-0.0016300011,0.022710413,-0.03991747,-0.00049514655,-0.0059231347,0.028705742,-0.07059595,-0.034790717,-0.032715086,0.004306394,-0.16656871,-0.03999982,0.01186961,-0.0026802332,0.016607257,0.06809862,-0.00015696966,-0.011914672,0.025354987,-0.0037886743,-0.012114098,-0.029861167,0.06234382,-0.025257306,0.0089941295,-0.027203567,-0.017909853,-0.05587765,-0.0024718712,0.025027234,-0.08609683,0.029085305,0.057049453,0.024998007,0.04174912,0.053660516,-0.008900514,0.020135466,0.010382541,-0.025987163,0.009749851,0.039004948,0.0067355097,0.016432453,0.041424744,0.013532322,-0.032752052,-0.066355,0.04249588,0.00067217764,0.046261214,0.009189174,-0.007083198,-0.05909283,-0.0168885,0.0029686892,0.0341527,0.022355339,-0.010593113,0.012864328,-0.017807651,0.068449676,-0.058150865,0.011342764,0.02984995,0.014666275,0.0037090497,-0.021229323,-0.007164386,-0.0027949873,-0.034620136,-0.0063020606,0.026278086,-0.0040726135,0.013416343,-0.0147696845,0.020594543,0.050171293,-0.010478646,0.05963687,-0.054878585,-0.01139388,-0.001519108,0.0055291518,-0.009199585,0.0094455695,0.025163127,0.031087259,0.050724704,0.038228326,0.041118048,0.06236912,0.012181458,0.030846829,-0.03188508,-0.01146278,0.08157744,-0.0044685714,-0.016651198,-0.047032066,0.05017047,-0.004846683,-0.038571093,-0.0027430514,-0.024075791,-0.017175412,-0.016348954,0.024147443,-0.046316788,-0.014831106,0.02260008,0.0062715677,0.000870747,-0.028386094,-0.0036787642,0.020147966,0.032053012,-0.011038959,0.008637252,-0.082966484,0.013013887,-0.0113358935,0.002155124,0.00834464,0.021502566,0.05378087,0.0013267956,0.01644166,0.031310044,0.08077859,0.013619249,-0.022186093,-0.020962786,0.024952421,-0.01978283,-0.0074358657,0.017673269,0.003963956,-9.6801436e-05,0.06235833,0.029350732,0.025425823,-0.030746033,0.018142112,-0.03046304,0.005251222,0.0068927435,0.022979729,-0.05352777,0.018689046,0.021475779,0.012842959,-0.053966846,0.05189269,-0.041739505,-0.041783243,0.04639919,0.039492734,-0.0055416813,0.03534246,0.0020805714,0.068100296,-0.00043303447,-0.004863033,0.054144856,0.018662024,0.01331942,-0.0048347367,0.030722914,-0.01062337,-0.0003898012,-0.028388696,-0.042757228,-0.027840825,-0.013906069,0.009114159,-0.05798768,-0.0045608412,0.035289563,-0.06439984,0.011655626,0.059513457,-0.029026654,-0.015011309,0.0030758309,-0.0047496324,-0.022552071,-0.009403374,0.03140738,-0.025102252,0.048497915,0.033261146,-0.0192726,0.01625431,0.04687049,0.023409983,0.031220127,-0.065933615,-0.012328152,0.08555102,-0.074583046,0.026432645,0.0734272,0.023812765,0.04397212,-0.032493778,-0.033269454,0.049034473,0.0033125274,-0.021103203,-0.048481688,0.0036424696,-0.012144988,-0.0195872,-0.025444247,-0.016015332,0.046723217,-0.046090785,0.0002677854,-0.009019996,-0.0071784942,-0.031899087,0.04919732,0.02431542,-0.027871285,0.0016310437,0.029777953,0.03766098,5.2842188e-05,0.055177987,0.019143159,0.04657711,0.006771531,0.05098133,0.059105042,-0.010921305,-0.04225185,0.03494359,0.03470811,-0.032553013,-0.021158569,0.054181334,-0.030191494,0.050431874,0.02035007,-0.08065581,-0.03838919,-0.075598784,-0.0077545107,-0.04377022,0.015096273,-0.00479177,-0.07980094,-0.021081723,0.0083706165,-0.007998144,0.061281875,-0.011970626,0.009522492,0.026447339,0.052283872,0.06872302,-0.040930886,0.0037337753,0.026110886,0.012461719,0.023984397,-0.030368611,0.049917374,-0.01656934,-0.042914283,0.00213707,-0.0026644098,-0.014508454,-0.014384364,0.031269908,0.0094390465,-0.016851371,0.02683853,0.005659171,0.027596848,-0.026325244,-0.00896117,0.028742295,-0.007516728,0.030629536,0.0041875667,-0.060707513,-0.010015375,0.018754909,-0.03730134,0.031109525,0.043684244,-0.0039693983,0.0061774305,-0.015130828,0.03370769,-0.04485646,-0.02517154,-0.0640923,0.028034324,-0.021686992,-0.032552537,-0.03308151,-0.029679222,-0.02131897,0.043571338,-0.022210808,-0.049784865,-0.004862135,-0.012820236,-0.007869283,0.02030142,0.03394972,-0.009314655,0.026297057,-0.008266754,-0.021737635,-0.007925292,0.004238183,0.027051581,0.012698661,-0.021721886,0.035762627,0.028630262,-0.0323458,0.010774064,-0.02142312,-0.03925791,0.021149272,0.012780161,-0.02955935,0.0341162,-0.05139659,0.017406011,-0.013752316,0.044510774,-0.0044092415,-0.031872764,0.062188663,0.024718672,0.003706978,0.0056058466,0.055645857,0.012713683,0.018040236,-0.067276366,0.083494,-0.0066810474,0.035859223,-0.023003092,-0.032629624,0.018189332,0.05255956,-0.034269802,0.00014120982,0.004864289,0.012241226,-0.05135957,0.053059977,-0.059634306,-0.0073854276,0.03853948,-0.00010064977,-0.052000534,0.029358285,-0.042810086,0.008849959,0.004359643,-0.03843923,0.015960544,-0.031112019,-0.023519978,0.014484454,-0.034146037,0.021898955,0.0068996246,-0.077775225,-0.034562204,-0.029917046,0.0061133546,0.018494079,-0.05377031,-0.019056557,-0.006240431,-0.0068455217,-0.022636706,0.006979472,-0.015223166,0.050898805,0.0038417806,0.007709866,-0.001134629,-0.037678786,-0.020234616,0.0051976442,-0.046524897,-0.069027565,-0.0020761956,0.015888186,0.030521726,0.009325915,0.004398315,-0.008954708,-0.011353182,-0.018577354,0.017664982,0.038404264,-0.022269884,0.023072612,0.0516497,-0.00082617905,0.018372556,-0.008880779,0.032559264,0.00088292983,0.033420946,-0.008347112,0.06164243,0.0032816262,-0.07418227,-0.025873123,-0.008432735,0.056363687,0.0041919127,-0.017862158,0.0184488,0.011318055,0.003436972,-0.05798132,-0.024220375,-0.014937254,-0.0105109755,-0.009786847,0.040042154,-0.018400336,-0.05294401,-0.025569614,0.00576373,0.013460737,0.054933507,-0.0017906458,-0.05198016,-0.031638857,-0.056480158,0.0057599116,-0.007296134,-0.014123461,0.081535794,0.0014045433,-0.0012186359,-0.022480803,-0.00809788,0.01849745,-0.016484132,0.04907045,-0.011333409,0.03528724,-0.01646993,-0.020600628,0.050208766,-0.010081582]	2026-01-20 16:07:00.908194+05	ЖК Family Gardens. Адрес: г. Астана, ул. Е-314, район коттеджного городка Family Village
f0c58e39-e18a-40d3-8a52-a7cec336f928	92085076-bbcd-11ec-a820-001dd8b72708	Garden View	г. Астана, пересечение пр. Кабанбай батыра и ул. Бухар Жырау	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.10206	71.40981	Бизнес+		\N	https://bi.group/ru/landing/garden-view	https://s3.bi.group/biclick/92085076-bbcd-11ec-a820-001dd8b72708/92085076-bbcd-11ec-a820-001dd8b72708_foto_400.jpg	{"side": "Right", "tags": ["школа рядом", "детский сад рядом", "супермаркет рядом", "аптека рядом", "ТЦ Аружан рядом", "Рынок Артем рядом", "остановка общественного транспорта рядом", "кафе рядом", "рестораны рядом", "банки рядом", "фитнес-центр рядом", "поликлиника рядом", "сквер рядом", "набережная реки Есиль рядом", "ЕНУ рядом", "бизнес-центр рядом", "АЗС рядом", "автомойка рядом", "салон красоты рядом", "почта рядом", "банкомат рядом", "детская площадка", "спортивная площадка", "магазины у дома", "удобный выезд на главные улицы", "развлекательный центр рядом", "медицинский центр рядом", "парковка", "общественный транспорт", "детские кружки", "спортивные секции", "ЖД вокзал Астана-1 рядом", "автобусные маршруты", "стоматология рядом", "нотариус рядом", "химчистка рядом", "пекарня рядом", "кондитерская рядом", "офисы рядом", "государственные учреждения рядом", "культурные объекты рядом", "парк Астана рядом", "Дворец школьников рядом", "продуктовый магазин", "бытовые услуги", "ремонт одежды", "парикмахерская", "барбершоп", "кофейня", "фастфуд", "доставка еды", "детские развивающие центры"], "atmosphere": ["шумный", "семейный", "деловой", "ветреный", "широкие дороги", "пробки", "улицы чистые", "дороги хорошие", "спальный", "старый центр", "развитая инфраструктура", "удобная транспортная развязка", "много магазинов", "много кафе", "хорошая транспортная доступность", "активный трафик", "городской"], "district_name": "Алматинский"}	[-0.018438889,0.003359054,-0.010282361,-0.014364069,-0.0053510517,-0.0054126703,0.029875085,-0.02401387,0.008245475,0.052331105,-0.0028542986,0.05265985,0.030624114,-0.02701073,0.008601798,0.03349998,0.026489276,0.024624486,-0.13042684,-0.01225724,0.045105346,-0.020630015,0.052133106,-0.029186213,-0.05055914,-0.06499355,-0.048874684,0.0223674,0.0010152566,-0.027888747,0.051322598,0.049097292,0.0025887035,-0.00949661,0.01763708,0.030312274,-0.007245508,-0.04840477,0.016194716,-0.039012942,-0.04924637,0.029240943,0.023317771,0.018733485,-0.079019435,-0.06902065,-0.031997006,0.022920754,-0.03555652,0.004271233,-0.01171462,-0.052293397,-0.024639053,0.07006762,-0.068344854,0.016037563,-0.031606812,-0.03469021,0.071282506,0.006745835,0.012798215,-0.015121771,0.0066934237,-0.03659548,-0.007587937,-0.0062196394,-0.041333873,-0.009150274,-0.06896818,-0.00097395474,-0.016669117,0.10087914,-0.04183529,0.04067048,-0.02620349,0.015487923,0.012088468,0.020222336,0.077040985,0.029198108,-0.062170886,-0.0031660937,0.010509126,0.036512755,0.03357143,0.009326022,0.008852967,-0.0140352575,-0.08287693,-0.013630858,0.08663667,0.027055414,0.050409943,0.0011469306,0.080712385,0.018293845,-0.109613575,-0.10997358,0.042410173,0.014930634,0.027483905,0.008840865,-0.041078392,-0.09244038,0.03904773,0.05740892,-0.078860685,-0.061982334,-0.083582856,0.010102991,0.0025078098,0.009336474,0.05246697,0.023050236,0.008788501,0.040984582,-0.07596295,0.04526807,0.0063431347,0.02845123,0.029060319,0.014558437,-0.014074991,0.029488416,0.004179385,0.014799402,0.0007698229,-0.03436083,-0.024163576,-0.0050997566,0.038012505,-0.02000852,-0.005888661,-0.014785993,-0.039602738,-0.004596349,0.046236668,-0.032009277,-0.0023133913,0.030687163,0.02197324,-0.04118435,-0.05556661,-0.0074149086,0.0058724177,-0.0025683008,0.013664086,0.085465714,-0.04550538,0.01561979,-0.04928559,-0.028439676,0.03979653,0.016140006,0.01970352,0.0065051536,0.07031011,-0.054298706,0.016916532,-0.010117669,0.06427023,-0.037664175,-0.04176376,-0.0031771732,0.009722302,0.0072451215,0.011184693,-0.0072115585,-0.006310207,-0.0013012943,-0.035793025,-0.06555994,-0.027074749,-0.08277814,0.0053758114,-0.008617281,-0.021300375,0.007359281,-0.017314456,0.021617131,0.12536752,0.011866184,-0.010260556,-0.06907161,-0.011070623,0.0154564725,-0.011322275,0.061258536,0.041667286,-0.004639048,0.012431509,0.010465588,0.012358841,0.05853332,-0.063440144,-0.009063503,0.0288208,-0.060285687,0.0017456119,-0.051026955,0.059246022,-0.02797788,-0.005065543,-0.041139428,-0.024498915,0.031031154,-0.028156972,-0.060608994,-0.040361874,0.017733783,0.0008150306,-0.022887949,-0.029634975,-0.06611885,0.030481711,0.02273932,0.00051368354,-0.025113713,0.06037403,-0.09560708,-0.016660398,0.015170405,0.06438288,0.022112202,0.0574902,-0.01587761,-0.015454652,-0.011457317,-0.0010315223,-0.05687409,-0.017782401,-0.01646286,0.01035369,0.05208301,-0.00702912,0.027552528,0.018141717,-0.072938085,-0.029665424,-0.019421667,-0.019295981,0.035856467,0.04455525,-0.01403062,0.01865177,-0.02119517,0.077830404,0.044662427,0.026754461,0.016187841,-0.040643755,-0.017200112,-0.0047069304,-0.000104193205,-0.037820525,-0.040928487,0.024256557,0.02409495,-0.02619824,-0.02788067,0.0015290638,-0.035042826,0.029624587,-0.04885674,-0.05525432,-0.026425684,-0.011466561,0.0029661178,0.03773801,-0.04496428,0.06913745,-0.05267774,-0.041739035,-0.007161203,-0.02341116,0.07548564,-0.008472345,0.03242358,-0.010670947,-0.037949026,0.050882343,0.012838394,-0.040914036,0.032842595,0.013901232,-0.08112255,0.0068928716,0.01558403,-0.044621315,-0.033132005,0.038623285,0.069000624,0.0074173543,0.005917231,0.0016956863,-0.022359358,0.021986494,0.031398833,-0.011715766,-0.04927848,0.018421937,0.051612537,-0.016228322,0.031197684,-0.0021642759,-0.040559877,-0.0008604778,-0.009925686,-0.0001677196,0.0084810825,0.022226248,0.041763168,-0.066325784,-0.046944104,-0.048074365,-0.010747796,-0.13429701,-0.058279034,0.009614677,-0.006708659,0.013320143,0.0829162,-0.015312258,-0.03792311,0.052565824,-0.018836906,-0.008021353,-0.061692104,0.04563301,-0.04270355,0.017191935,-0.022726266,-0.021633243,-0.044912584,-0.007044971,0.019162167,-0.07652722,0.01531986,0.045868907,0.028374335,0.0473272,0.059657127,0.0009313652,0.04026174,-0.007070793,-0.022991432,-0.0011331522,0.008146932,0.025928957,0.011409871,0.02979458,0.020817043,-0.026546184,-0.059586145,0.009286823,-0.023616064,0.026689528,0.013267862,-0.014306194,-0.063667394,-0.03411923,0.006571052,0.017451234,0.0070825173,0.01627955,0.01643229,-0.0059917113,0.046921983,-0.059634708,0.006871243,0.019312605,0.028414365,0.010531286,-0.0026483196,-0.0074938238,0.00059519237,-0.045341197,0.022536691,0.032407522,-0.013011995,-0.003557894,-0.0061023585,-0.00936012,0.025730768,0.005368001,0.08005586,-0.035285648,-0.0061436226,-0.026124941,-0.021470767,-0.035607252,0.0030094094,0.023209983,0.03359759,0.028166052,0.026776833,0.044792365,0.04458162,0.029241584,0.018603785,0.006763916,-0.060893405,0.061659854,-0.03029249,-0.0144678755,-0.020721676,0.076713346,0.0013999454,-0.028970603,-0.00055053394,-0.025425073,-0.017881712,-0.035197753,0.003955584,-0.029176448,-0.037283603,-0.024241412,-0.027656727,-0.0047426033,-0.051055882,-0.023773277,0.023888288,0.028751729,-0.010058845,0.010524106,-0.08344246,-0.00903395,-0.01049842,0.00042585115,0.00043082976,0.06337864,0.047565095,-3.81341e-05,0.03600212,0.024764273,0.06687137,-0.018626777,-0.07583993,-0.022995573,0.03317083,-0.023285564,-0.0001504742,0.049265366,-0.0037754185,-0.013141295,0.05888747,0.03988988,0.01853735,-0.027411101,-0.025090283,-0.024981173,-0.0081954,0.0013369616,0.010220802,-0.077312104,-0.011141064,0.03075804,0.0055889986,-0.061936192,0.019442277,-0.05987906,-0.024456393,0.06632577,0.02285844,-0.0055615115,0.018359862,0.009593968,0.03944451,-0.018032707,-0.000588829,0.056756683,0.00853208,0.044656586,0.009956726,0.02320211,-0.00659774,0.012571653,-0.015980644,-0.060174197,-0.03580233,-0.017492779,0.008924204,-0.080631144,0.013607504,0.0436472,-0.043060362,0.007406872,0.051034596,-0.032096393,-0.041524764,0.010844053,-0.0077667274,-0.023112876,-0.032555804,0.014158963,-0.019575264,0.04661279,0.045346323,0.002110995,0.0031372106,0.030332217,0.03676066,0.046247218,-0.05604769,0.0009070052,0.053687345,-0.071998596,-0.019262645,0.020708527,0.0085021565,0.011163981,-0.029032107,-0.030386833,0.06304608,-0.010512837,0.008566483,-0.014587767,-0.007186982,0.002016605,-0.026129559,-0.0127594285,-0.014907748,0.0288758,-0.04610363,0.015838122,-0.01249592,-0.0023160395,-0.044448785,0.043528385,0.012851154,-0.020346552,0.010908919,0.038285017,0.05747294,0.013579358,0.07094235,0.027549896,0.033249855,0.05060374,0.04581672,0.026079323,0.00781314,-0.045674775,0.00875624,0.03946822,-0.039664473,-0.021336779,0.05291115,-0.028127562,0.05884458,0.0236872,-0.053108737,-0.053147804,-0.043334242,-6.9468355e-05,-0.007203459,0.02436816,-0.012629199,-0.06120985,0.016575947,0.0071247984,-0.0055968114,0.034226503,-0.021979673,0.0024148324,0.023802983,0.016568342,0.06900354,-0.014385152,-0.008171789,0.037308387,-0.008664692,0.03880035,-0.04072627,0.05405662,-0.025189077,-0.066178866,-0.030270679,-0.009058803,-0.025836369,-0.021503465,0.005184592,0.01886474,0.01072118,0.005038845,0.013635169,0.031455725,-0.0164665,-0.02946516,0.019682862,-0.019693438,0.026334524,-0.011156645,-0.05636924,0.028611721,0.0023724202,0.0010241471,0.017902829,0.047916822,-0.0006685687,0.03532516,-0.004381919,0.042179763,-0.025086703,-0.02546082,-0.063478924,0.030743627,-0.008539333,-0.02844559,-0.03507317,-0.027473992,0.0017368845,0.026858099,-0.05482626,-0.05154695,-0.0073734256,-0.01568481,-0.041689787,-0.00034224556,0.035219748,-0.019986987,0.027677992,-0.017843133,0.01395348,-0.02029043,0.0075806924,0.014596222,0.020998633,-0.00027410255,-0.0032359983,0.0053989217,-0.04423328,0.0068940874,-0.030204076,-0.03722325,0.028694421,0.019719211,-0.025775027,0.040163524,-0.04255751,0.027696414,-0.000766021,0.06737172,-0.018271236,-0.038207646,0.055516344,0.033323158,-0.009594807,0.02007747,0.07590957,0.028547397,0.0118926205,-0.05860633,0.07627477,-0.017490914,0.029153403,-0.0035460573,-0.015083859,0.057747345,0.030566,-0.03179009,1.3345754e-05,-0.00667538,-0.021783993,-0.06383181,0.045404,-0.025275722,-6.716992e-05,0.0054756016,-0.0060794456,-0.023050403,0.003183161,-0.05384275,0.03200687,0.0142255,-0.033035487,0.017469825,-0.0012158168,-0.019571584,0.009054559,-0.008776622,-0.0027209383,0.0056314734,-0.07329801,-0.018663835,0.01123779,0.042497523,0.054288596,-0.04929356,-0.027272517,0.016915327,-0.016500885,0.00047571558,0.0123850405,-0.020441655,0.037781198,0.009304754,0.0022820993,-0.037225068,-0.015354227,-0.008486739,0.013930705,-0.07264082,-0.06748796,0.007670079,0.0031435844,0.02868599,0.02614831,-0.010626567,-0.008621309,-0.0038542233,-0.0023388069,0.02576087,0.021960571,-0.011679547,0.030828102,0.029858418,-0.0104564,0.0057062632,-0.010713867,0.02371933,-0.0064103026,0.015635418,0.011454964,0.037442587,0.0015799651,-0.087460145,-0.03289178,-0.008517644,0.05720453,0.013314695,-0.01831493,-0.00063323975,0.018071916,0.014342477,-0.015621094,-0.022686314,-0.010607779,-0.048179224,0.018866172,0.05293002,-0.0045573986,-0.046135806,-0.022231642,0.01195286,-0.0016260179,0.023420526,-0.0036244574,-0.037673123,-0.0466915,-0.07545392,-0.018973123,-0.0075033405,-0.030521085,0.109622374,0.024975386,0.026088089,-0.031315856,0.024014914,0.015938954,-0.0031281544,0.059666526,-0.0025877403,0.056753505,-0.01298064,-0.009841524,0.036063068,-0.0063155084]	2026-01-20 16:07:18.031097+05	ЖК Garden View. Адрес: г. Астана, пересечение пр. Кабанбай батыра и ул. Бухар Жырау
eaba4330-74fa-4f6a-8173-61daad13ddc9	8654dbf5-53ee-11eb-a83d-00155d106579	GreenLine. Prima	г. Астана, ул. Е899, уч. 4	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13406	71.39031	Бизнес+		\N	https://bi.group/ru/landing/greenline-prima	https://s3.bi.group/biclick/8654dbf5-53ee-11eb-a83d-00155d106579/8654dbf5-53ee-11eb-a83d-00155d106579_foto_400.jpg	{"side": "Left", "tags": ["экспо рядом", "ботанический сад", "парк", "школа", "детский сад", "супермаркет", "торговый центр", "ТРЦ Mega Silk Way", "кафе", "ресторан", "аптека", "фитнес-центр", "остановки общественного транспорта", "детские площадки", "спортивные площадки", "велодорожки", "медицинский центр", "банки", "салоны красоты", "развитая инфраструктура", "новые дома", "современный район", "удобная транспортная развязка", "зона отдыха", "университет Назарбаева", "бизнес-центры", "концертный зал", "Астана Арена", "Барыс Арена", "Congress Center", "безопасный район", "рядом поликлиника", "рядом больница", "рядом Magnum", "рядом Small"], "atmosphere": ["тихий", "семейный", "деловой", "зеленый", "ветреный", "элитный", "современный", "развитая инфраструктура", "широкие дороги", "чистый воздух", "красивый вид", "ухоженный", "спокойный", "перспективный", "комфортный", "чистые улицы", "хорошие дороги"], "district_name": "Есильский"}	[-0.008896263,0.003912504,-0.034062613,-0.025924403,-0.0008432871,-0.01801992,0.009837884,-0.026292145,0.004213836,0.037552834,-0.011266309,0.060746327,0.031641718,-0.031435467,0.00087468966,0.010163905,0.054848347,0.029095698,-0.12787496,-0.0037696976,0.014370354,0.006834561,0.04977327,-0.00305593,-0.053780388,-0.039537646,-0.060142875,0.012501988,-0.017716229,-0.04607353,0.046855327,0.07193623,0.003956738,0.0097863935,0.0068277856,0.018651426,-0.029023722,-0.043210544,0.0313377,-0.03746186,-0.038940594,0.044237874,0.0064256196,0.032478366,-0.076566994,-0.093335815,-0.038063534,0.02706325,-0.063091435,0.014896472,0.0031253446,-0.03357743,-0.041527756,0.05466891,-0.061337724,-0.0025219847,-0.005908016,-0.011780019,0.05942621,0.005407881,0.032987237,-0.019349726,0.006330918,-0.01524014,0.016873607,-0.006881105,-0.052130748,-0.02154162,-0.07678326,0.016451258,-0.00391428,0.098485954,-0.028055234,0.025152678,-0.03741083,0.0051678466,0.01896389,0.0015133774,0.032737773,0.071870476,-0.039034415,0.005062894,0.028138464,0.011734241,0.02427545,0.0031603433,0.018844398,-0.06018861,-0.05540063,-0.02053325,0.048211183,0.02826084,0.03568402,0.045642287,0.06569811,0.03201807,-0.12673949,-0.08968085,0.06344087,0.02503176,0.00065029087,0.018874079,-0.03819313,-0.0905798,0.025255837,0.07456773,-0.06436237,-0.07941365,-0.054949522,0.027921513,0.004254674,0.00080657285,0.00849072,0.00071561796,0.021820532,0.032633446,-0.090226695,0.051380116,-0.0023451133,0.028988713,0.052176215,0.0032222432,-0.047530554,0.035300232,0.008681278,0.02797311,0.0056497687,-0.014481561,-0.049971297,-0.020569801,0.03352245,-0.021871056,-0.023203105,0.009435295,-0.042977847,0.0441724,0.05582745,-0.012944951,-0.00027002013,-0.0064327107,0.028981928,-0.016942812,-0.050908405,-0.021805812,-0.0028269985,-0.018527893,0.004928372,0.044692896,-0.031105964,0.020079685,-0.042861372,-0.030583989,0.03412051,-0.0020118817,0.03571198,0.010293561,0.047858227,-0.05968399,0.0063389023,-0.037471496,0.048275765,-0.022215433,-0.02918974,0.0018743736,0.008258599,0.0019883798,0.0003898346,-0.044216838,-0.020709557,-0.0022664124,-0.028232489,-0.08085292,-0.019659543,-0.074935235,-0.0029415926,0.0014666294,-0.000705419,0.0005728799,-0.025306206,0.019827452,0.100915305,0.001240589,-0.023613723,-0.04735914,0.016104398,0.015168829,-0.01922313,0.04625333,0.0140972575,0.010970279,0.010289099,0.01544411,-0.0098419,0.043438304,-0.05176316,-0.023013555,0.047128025,-0.053025633,0.012076496,-0.051163975,0.038435522,-0.03988506,0.0003328748,-0.03208854,-0.04613903,0.024592357,-0.043426596,-0.07754273,-0.04760562,0.04712432,0.00095692446,-0.047011163,-0.045224015,-0.086983435,0.05381373,0.01811168,0.031377207,-0.024782754,0.073557846,-0.09008491,-0.0027107024,0.004598563,0.07290306,0.026920224,0.07413576,-0.001959655,-0.009913432,-0.00013719234,-0.013358187,-0.04415042,-0.0384671,0.0022564905,-0.01605312,0.04029326,-0.011808448,0.05886234,0.010608415,-0.048863772,-0.037777048,-0.011410758,-0.02974097,0.036537297,0.030715264,-0.017517421,-0.013474691,0.023226026,0.06606967,0.054221664,0.017191064,0.026404167,-0.057626974,-0.0014847268,0.0048444434,-0.003453885,-0.044097953,-0.03682987,0.02454014,0.040285088,-0.02261735,-0.026913196,-0.0065289033,-0.03225867,0.015005814,-0.0686102,-0.04370179,-0.037930034,0.000767567,0.0025528441,0.040018056,-0.038613375,0.08475499,-0.042683747,-0.017719107,-0.0098047415,-0.02428047,0.07475264,-0.06265456,0.039900362,-0.018015081,-0.06693456,0.02800519,0.006449705,-0.0018173505,0.006138292,0.02453616,-0.043932986,0.010302221,0.031764798,-0.03877309,-0.00047774523,0.01342594,0.048038423,-0.0030436988,-0.0024791623,0.011242299,-0.030554904,0.02478839,0.035212982,0.0049781404,-0.0555684,0.018836487,0.043751314,-0.027535131,0.02443951,0.010571744,-0.0139735155,-0.012437087,0.010492856,-0.03479034,0.023386944,0.031905673,0.04156704,-0.04654432,-0.033540323,-0.030998597,-0.006475476,-0.14786133,-0.055236164,0.010891931,-0.01771845,0.008492267,0.068043105,-0.0030386662,-0.013975502,0.05410135,0.0040533356,-0.025957517,-0.06041731,0.057525754,-0.029498644,0.011688592,-0.0074186544,-0.0121441325,-0.050029926,-0.001593982,0.047965385,-0.077468716,0.017499669,0.0376255,0.01935679,0.036717728,0.043662217,0.009216486,-0.010297273,0.008884464,0.00018401233,-0.0076551912,0.013292911,0.03552599,0.005816517,0.006809896,0.01774679,-0.051806442,-0.052435428,0.021263093,-0.024173463,0.038851406,-0.003219283,0.016050216,-0.10284682,-0.017369358,0.020545814,0.006930825,0.013550616,0.03295459,0.0077354317,-0.014999254,0.042153385,-0.043722115,0.009468616,0.018115968,0.017318215,0.023333965,0.008836953,-0.026633695,-0.008572451,-0.03594575,0.005510858,0.029282603,-0.012666581,-0.013186529,-0.024894178,-0.009725689,0.032622937,-0.007430544,0.061664086,-0.039152917,-0.019854296,-0.02895973,0.0039549503,-0.012986768,0.02612458,0.010390951,0.029093405,0.02857085,0.046739276,0.04829332,0.062474355,0.023057878,0.0063245846,-0.008458261,-0.033497818,0.069227174,0.0034801273,-0.02057161,-0.029175717,0.06328847,-0.002744625,-0.02563487,0.004513041,-0.033456195,-0.017803816,-0.052149106,0.004193083,-0.032068297,-0.01178695,-0.009363259,-0.02096369,0.007763619,-0.036987722,-0.024611888,0.049291886,0.03704313,-0.010722265,0.0028018313,-0.09006648,-0.0035194834,-0.005523817,-0.012235434,-0.003624007,0.053608432,0.0399668,0.009769905,0.019073097,0.015499586,0.07198582,0.0076640644,-0.021373447,-0.011932678,0.021392837,-0.031568073,-0.014220693,0.022673978,-0.015917512,-0.012635,0.03087732,0.032931928,0.007901848,-0.0016287672,0.014042996,-0.01408682,0.00203095,-0.009388785,0.0030622757,-0.062768735,0.0014905985,0.03839511,0.00945763,-0.039633118,0.029905401,-0.03168331,-0.03041265,0.04678525,0.027662499,-0.0075907013,0.026775261,0.0064774784,0.06650903,-0.046995588,-0.0016486956,0.048533622,0.0063606184,0.046701536,0.0025332363,0.01841913,-0.032115623,0.013870382,-0.012748222,-0.050196238,-0.024490535,-0.028721541,0.018058887,-0.06353267,-0.012796541,0.045610283,-0.030157879,0.0066483584,0.044193015,-0.013334992,-0.027232949,0.010664694,0.0048359516,-0.017220406,-0.051235773,0.03698902,-0.025608055,0.053529784,0.029696811,-0.0125762895,0.01617115,0.060419284,0.036606323,0.023197306,-0.07127072,0.0006556789,0.06091993,-0.073235504,-0.01863636,0.059160486,0.024308342,0.022361625,-0.036507625,-0.030110922,0.046810213,-0.0143707935,-0.004355498,-0.018429494,-0.0051450348,0.0058716224,-0.019900871,-0.015864482,-0.025419598,0.042970717,-0.044871762,0.024521708,-0.017080164,-0.00032500358,-0.020493155,0.02680546,0.024649374,-0.012012119,0.011251163,0.04578211,0.057309117,0.021616684,0.054034024,-0.009906697,0.05423489,0.01698788,0.05531107,0.024301331,-0.00710007,-0.068764426,0.02711392,0.017021779,-0.0142551195,-0.026770128,0.05236537,-0.06705376,0.087028794,0.022061424,-0.06252155,-0.036834985,-0.05211559,-0.018862138,-0.027826102,0.016164389,0.0062620225,-0.07861766,-8.075849e-06,0.028384639,-0.01761508,0.057997365,-0.030425308,0.0113463905,0.009405256,0.05526963,0.07902261,-0.035997026,-0.011226778,0.027522974,-0.015347148,0.031543292,-0.011289081,0.051904347,-0.01926369,-0.047864877,-0.018981328,-0.006280786,-0.010938755,-0.039315768,-0.0007161786,0.022589197,-0.0029894859,0.01393504,0.005778828,0.037740186,-0.038723316,-0.0052768425,0.025751827,-0.036695972,0.01968649,-0.0185665,-0.061702356,0.03805256,-0.022234447,-0.022888806,0.051631525,0.025212703,-0.006898518,0.023169136,0.0031132102,0.050267454,0.011044464,-0.02947457,-0.056527868,0.028646922,-0.04128514,-0.015983086,-0.0058709914,0.00015815804,-0.014916978,0.05009087,-0.04302955,-0.06656301,-0.0023514375,-0.019264732,-0.03315176,0.0233671,0.021532891,-0.0012964747,-0.014766778,-0.022976305,-0.003550207,0.0116592795,0.012341784,0.038003393,0.006414597,-0.020150807,0.017315308,0.036607053,-0.0450702,0.006051143,-0.039114073,-0.015736997,0.02453111,0.028037151,-0.014705468,0.017216157,-0.049477197,0.038469467,0.008931006,0.056858845,-0.01580523,-0.034178622,0.04762006,0.041334532,-0.015285619,-0.00011293908,0.05968304,-0.014435107,0.011728749,-0.07387961,0.08290188,-0.0172712,-0.0003574264,-0.002188541,-0.00017269586,0.03288894,0.023699459,-0.007896944,-0.016748779,0.009858185,0.023170061,-0.049681164,0.054603614,-0.05818347,-0.0059509506,0.013396331,-0.0018396112,-0.02775595,0.03016521,-0.06343631,0.009679513,-0.010868884,-0.020641493,0.0337432,-0.010436293,-0.008860407,0.011647071,-0.016409192,-0.018200047,0.00018165259,-0.08081118,-0.034025107,-0.0044233585,0.021663105,0.030551245,-0.048763264,-0.014340313,-0.0037239413,-0.010002333,-0.014171493,0.023853892,-0.015217041,0.050993368,-0.0072993734,-0.01216812,-0.014438966,-0.04015485,-0.017574197,-0.0061140605,-0.060726162,-0.072494306,0.011830798,0.008022234,0.06268029,0.015625076,0.0035267104,-0.008551303,0.010380247,-0.015033507,0.03742883,0.030265145,0.0023945295,0.037661623,0.04117157,-0.012814846,-0.00023544894,-0.005986363,0.037543815,0.0053897547,0.019610554,0.020173639,0.052482042,-0.0044705,-0.08159452,-0.03478247,-0.0095958235,0.07134345,-0.001395824,-0.01751917,0.018194333,0.0125661725,-0.0106995795,-0.035399795,-0.043996036,-0.04552325,-0.023475263,-0.031586748,0.03679601,-0.037670985,-0.02321235,-0.051185016,-0.015690383,0.023550315,0.041205455,0.025595307,-0.028295167,-0.062443294,-0.07762519,-0.017534964,-0.0022280514,-0.032365263,0.07598393,0.02343312,0.015986022,-0.01424129,-0.0016582418,0.041419365,-0.019599618,0.044462852,-0.0035687266,0.06681137,-0.0415472,-0.005347494,0.02961153,-0.024734374]	2026-01-20 16:07:18.400667+05	ЖК GreenLine. Prima. Адрес: г. Астана, ул. Е899, уч. 4
acb24dbf-75de-46bd-92d9-60ba8e280339	c9720994-8cac-4025-88eb-ffd94e56d548	GreenLine. Astra	г.Астана, ул. Е-796, 1	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13782	71.39347	Комфорт		\N	https://bi.group/ru/landing/greenline-astra	https://s3.bi.group/biclick/c9720994-8cac-4025-88eb-ffd94e56d548/c9720994-8cac-4025-88eb-ffd94e56d548_foto_400.jpg	{"side": "Left", "tags": ["парк рядом", "школа рядом", "детский сад рядом", "супермаркет рядом", "ТЦ рядом", "кафе рядом", "ресторан рядом", "аптека рядом", "фитнес-центр рядом", "салон красоты рядом", "остановка рядом", "EXPO рядом", "Ботанический сад рядом", "университет рядом", "стадион рядом", "кинотеатр рядом", "фудкорт рядом", "банкинг рядом", "детская площадка", "спортивная площадка", "велодорожки", "прогулочные зоны", "новые дома", "современная застройка", "удобный выезд", "охраняемая территория", "подземный паркинг", "поликлиника рядом", "медицинский центр", "бутики", "развлекательный центр", "автобусные маршруты", "чистые улицы"], "atmosphere": ["семейный", "современный", "зеленый", "ветреный", "чистый воздух", "широкие дороги", "развитая инфраструктура", "спокойный", "комфортный", "деловой", "молодежный", "элитный"], "district_name": "Есильский"}	[-0.0051220395,0.0031100872,-0.032432202,-0.022592846,0.0019321961,-0.008412733,0.026026899,-0.013228427,0.0030019912,0.028292961,-0.0057339943,0.066909246,0.041775588,-0.02071698,0.0050882157,0.01597121,0.044515856,0.024898285,-0.13225174,-0.019040436,0.01905932,-0.00046586146,0.057711028,0.011402175,-0.0514841,-0.053041648,-0.05508096,0.023462068,-0.022799356,-0.022165194,0.04964229,0.0626748,0.014111424,0.02650532,0.0030042827,0.022333773,-0.029340876,-0.039871663,0.024026373,-0.043258447,-0.04468747,0.037175994,0.0111302,0.03350051,-0.07703176,-0.08729235,-0.030832676,0.021364009,-0.043935716,-0.004417738,-0.005018293,-0.031722385,-0.028100798,0.062448137,-0.0618462,-0.0030149687,0.008213985,-0.018008923,0.07871662,0.0058061574,0.027796818,0.0010910133,0.0032778096,-0.011822371,0.0055246027,0.0009008748,-0.055721033,-0.010951641,-0.06057358,0.02556467,-0.0009763317,0.09158903,-0.029897764,0.01608831,-0.027467925,0.0218247,0.0076546185,0.0062983837,0.042286165,0.062439583,-0.031937227,-0.015466375,0.027935062,0.013614524,0.008097486,-0.009022907,-0.0031200561,-0.05795295,-0.07118969,-0.026525434,0.06368319,0.022637764,0.036149573,0.052008964,0.05110314,0.050531555,-0.11802783,-0.114039324,0.054709457,0.024584742,-0.005553536,0.03024933,-0.03956526,-0.08345919,0.029198075,0.08806305,-0.039152898,-0.05668857,-0.067066714,0.017652966,0.012943063,0.0061393655,0.018796727,0.0011478056,0.006404307,0.03641806,-0.08563183,0.068175614,-0.013889739,0.018959891,0.049907498,0.0066845063,-0.026464643,0.041577473,0.020895744,0.017524192,0.012093477,-0.024401871,-0.050526246,-0.021332314,0.016405016,-0.034990296,-0.0076192836,0.0076352092,-0.029527253,0.018500354,0.043376278,-0.017522488,0.015743822,-0.01929137,0.024018314,-0.029036794,-0.06112075,-0.021842524,-0.013354222,-0.03030645,0.016703878,0.052129854,-0.019467648,0.01325677,-0.043861795,-0.02990439,0.03178926,0.0023249334,0.028388295,-0.0015126292,0.061667435,-0.060819898,0.015315182,-0.05662751,0.0719214,-0.032151606,-0.021721592,-0.0050188676,-0.005900721,-0.008230783,0.027986366,-0.04100828,-0.025946215,-0.009153102,-0.026688749,-0.06842829,-0.0047114086,-0.05186751,-0.017854922,-0.000933633,-0.025524445,0.002059955,-0.017587453,0.014217055,0.09129665,-0.00036959938,-0.019423982,-0.051171675,0.0004047576,0.02354066,-0.008920782,0.051977813,0.027394405,0.0071324664,0.012540549,0.014248824,0.0053118207,0.049927667,-0.058031894,2.2424305e-05,0.042553294,-0.073877335,0.00894415,-0.067939565,0.027182555,-0.038489673,0.005303847,-0.028130954,-0.03864764,0.0015248625,-0.024654131,-0.070353515,-0.04636074,0.056882363,0.008886084,-0.021070391,-0.050164036,-0.07440288,0.027871996,0.015768638,0.009006096,-0.006473387,0.081972055,-0.09093448,0.0025999113,0.014254028,0.07042332,0.023841863,0.06464809,-0.011935363,-0.025938578,-0.017233303,-0.019263512,-0.029816475,-0.033434767,0.008025651,-0.011507929,0.041182492,-0.013589518,0.037879568,0.01767612,-0.061651815,-0.02020883,-0.010921864,-0.032902107,0.022523982,0.033019777,-0.027769614,0.0025415786,0.013919228,0.07237717,0.051224243,0.013003554,0.023888415,-0.041632183,0.003929907,-0.0033428231,0.0041887397,-0.04955948,-0.035240747,0.02508213,0.016916797,-0.0102861645,-0.02996267,0.0066198143,-0.030300332,0.014103921,-0.058660015,-0.061303068,-0.036549173,-0.020352365,0.0017996264,0.049855735,-0.025309315,0.07292423,-0.0408604,-0.026797852,-0.009049519,-0.039003946,0.07821247,-0.054218378,0.05341764,-0.009058933,-0.05377814,0.051621642,-0.0016002463,0.0052419044,0.004326024,0.0014886529,-0.05305174,0.009070393,0.034979157,-0.042388566,-0.0039159027,0.013083659,0.03579942,0.0006857867,0.004151677,0.016462136,-0.039031614,0.026806418,0.04377229,-0.010024198,-0.052447304,0.027048161,0.03812024,-0.05639575,0.031523578,0.0025909008,-0.023908472,-0.01434388,0.013796467,-0.016602129,0.019144827,0.02562963,0.039941546,-0.04421051,-0.045005176,-0.017208157,-0.007693154,-0.14637353,-0.059281487,0.014622877,-0.01114454,0.008394667,0.073206075,0.020147765,-0.021201458,0.05861174,0.0022457272,-0.02237501,-0.060320627,0.061880253,-0.026442492,-0.0025790385,-0.0015249653,-0.025187347,-0.05434606,0.0060425126,0.044976115,-0.06950074,0.03078905,0.030452972,0.03252263,0.04488186,0.06433221,0.009607149,-0.002305472,0.0035647952,-0.0013566212,0.004867436,0.025098043,0.03505244,0.0094898,0.018162023,0.012102423,-0.024958048,-0.05827356,0.02217204,-0.04143036,0.026865833,0.005301777,0.005397423,-0.096116774,-0.022112884,0.011123214,0.010111323,0.019998187,0.035707235,0.010612417,-0.01801494,0.04110506,-0.048514646,0.011863512,0.030472506,0.027073452,0.027941225,-0.0026358357,-0.0037945656,0.0021030018,-0.04461426,0.0074830735,0.023323731,-0.012807685,-0.01046874,-0.016442169,-0.0077873967,0.030170962,0.0197283,0.05876135,-0.040599983,-0.03897249,-0.03245295,0.00059869955,-0.0008955594,0.0220997,0.014212208,0.043725803,0.044529825,0.042551678,0.055068284,0.048746113,0.030355329,0.0073171323,-0.010183771,-0.03265766,0.054367088,-0.0149370935,-0.021269592,-0.013082165,0.06748596,-0.00804685,-0.03107493,0.018724017,-0.036260687,-0.013153551,-0.0377711,0.013070421,-0.031027254,-0.011938546,-0.0073471204,-0.017798962,0.017448846,-0.020471828,-0.049408983,0.05582685,0.033632703,-0.0070441295,0.004483744,-0.09598277,-0.02202871,0.0022135447,-0.019211208,-0.0044307024,0.052653756,0.035173718,0.0038154311,0.030678606,0.00092400424,0.059116937,0.0014517976,-0.02818711,-0.016348436,0.016416082,-0.02811931,0.00058745284,0.020248676,0.0020737716,0.0105350055,0.041227516,0.052555148,-0.010530129,-0.014308083,-0.0025446995,-0.019339472,0.020916605,-0.011275482,0.008574612,-0.060011007,-0.00022942694,0.046652686,0.010054101,-0.022643019,0.02868654,-0.036783505,-0.038788766,0.044348337,0.020518208,0.012308061,0.0330052,-0.012594733,0.05635182,-0.027833302,0.0040155263,0.055600595,0.017448785,0.037944812,0.012082403,0.031974237,-0.008187928,-0.0056117876,-0.014452405,-0.053528767,-0.027147975,-0.023243211,0.028320214,-0.07259362,0.012288568,0.033624087,-0.032233723,0.011904964,0.036978435,-0.015323231,-0.049637057,0.01625203,-0.0036296302,-0.01910383,-0.052365396,0.046212804,-0.03186293,0.03417873,0.035661187,-0.006648248,-0.0039295126,0.053630505,0.033468857,0.027823843,-0.07207295,0.0008915549,0.0617336,-0.06350495,-0.014228206,0.0626345,0.03389066,0.02447102,-0.026300816,-0.029338446,0.055302743,-0.01928063,0.0047324793,-0.024155555,-0.016059643,0.013575235,-0.03424002,-0.013314546,-0.034976587,0.036978103,-0.04174046,0.02936956,-0.013773035,0.00084528857,-0.03539388,0.0150374705,0.016616236,-0.026197229,0.0020827432,0.03301606,0.06734336,0.016995165,0.062293608,-0.007762236,0.055912185,0.029759357,0.051328413,0.021532413,-0.004736988,-0.06686596,0.007453264,0.020199133,-0.0024641377,-0.020606767,0.067061424,-0.057806283,0.06693431,0.025932249,-0.06855227,-0.04631593,-0.065168984,-0.02087658,-0.019203527,0.004487779,0.019409524,-0.067983516,0.010763766,0.03211809,0.0011865592,0.047542974,-0.039219525,-0.0057995454,0.010274029,0.059537362,0.07726744,-0.03764351,-0.006157977,0.00954534,-0.017070116,0.033042237,-0.015450103,0.04568437,-0.020610776,-0.05234576,-0.01722242,-0.030336944,-0.00958281,-0.038551707,0.0017034322,0.0059662703,-0.011451659,0.014273872,0.013771738,0.03326161,-0.007728625,-0.025569608,0.044420205,-0.030209474,0.015647454,-0.026247315,-0.05586667,0.020857338,-0.008529752,-0.015111332,0.055643804,0.020963233,0.004467434,0.029287217,0.005803944,0.055911385,0.00088627666,-0.023538591,-0.07236798,0.025019107,-0.03119857,-0.0077232174,-0.009599536,-0.011412394,0.00025955113,0.04220015,-0.03454687,-0.07508282,-0.004333795,-0.013614603,-0.033604454,0.007344052,0.007994901,-0.0082661845,-0.010752173,-0.032721866,-0.01515029,0.008535642,0.015097609,0.029151091,0.008619009,-0.02613849,0.007386147,0.053034674,-0.053884488,0.013383361,-0.040132042,-0.0214183,0.035183746,0.0074552116,-0.011804972,0.015323,-0.045265254,0.019313904,0.004396735,0.057934724,-0.019280976,-0.034107685,0.07015826,0.04230445,-0.022636699,0.00905948,0.06606414,-0.0002577423,0.0026136108,-0.06561281,0.07614078,-0.025327247,0.0070933145,-0.0029641096,-0.011690599,0.032850694,0.016633924,-0.019413171,-0.0065150405,0.0047297315,0.030258399,-0.05398013,0.04300408,-0.063146494,-0.013996391,0.015363714,0.0006642499,-0.02127621,0.026794994,-0.04664085,0.009115598,-0.0058810553,-0.016205883,0.02857008,-0.007832116,-0.027130263,0.00479157,-0.011422795,-0.004012285,0.007851314,-0.07431239,-0.03206763,-0.028831448,0.024006171,0.029885117,-0.041431237,-0.017603165,0.011360837,-0.023834411,-0.011079361,0.007896231,-0.0073841647,0.057579055,0.0014496391,-0.014007025,-0.030551383,-0.046033952,-0.004232196,0.007244262,-0.07595803,-0.06101651,0.0071627586,-0.0048000733,0.060283877,0.00986249,-0.00930118,0.0071410583,-0.0006366896,-0.0007311663,0.03751958,0.042865057,0.0018646722,0.053162225,0.044248078,0.0074133566,0.017635638,0.008268168,0.054847587,0.008464737,0.03753432,0.011359842,0.048508666,0.0012710014,-0.09869917,-0.026590457,-0.005967156,0.06833386,0.009023073,-0.01419024,0.015433524,0.02395889,-0.019096768,-0.03774198,-0.046939142,-0.035092074,-0.03532772,-0.023565097,0.042454574,-0.017783668,-0.02853565,-0.03126745,-0.003293299,0.025753537,0.035816174,0.0029419346,-0.023835585,-0.044359285,-0.07549573,-0.021868775,-0.00466441,-0.030700447,0.094595425,0.018924896,0.01792911,-0.021071935,0.01520589,0.039831385,-0.02141192,0.037667587,-0.0019135571,0.067288496,-0.026587721,-0.0044397726,0.037339654,-0.032421757]	2026-01-20 16:07:18.198042+05	ЖК GreenLine. Astra. Адрес: г.Астана, ул. Е-796, 1
25cfb270-1dfa-40aa-bbfb-af7264f84764	75f6fd8c-b9a0-11ed-a826-001dd8b72708	GreenLine.Headliner Exclusive	г.Астана, ул. Толе би, 52	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13362	71.39858	Бизнес+		\N	https://bi.group/ru/landing/headliner-exclusive	https://s3.bi.group/biclick/75f6fd8c-b9a0-11ed-a826-001dd8b72708/75f6fd8c-b9a0-11ed-a826-001dd8b72708_foto_400.jpg	{}	\N	2026-01-20 15:56:39.508246+05	ЖК GreenLine.Headliner Exclusive. Адрес: г.Астана, ул. Толе би, 52
db559bf9-4004-4cd2-981b-917cbb7e06de	3a7456d7-8ef3-11f0-a834-001dd8b726aa	Greenline. Velora	г. Астана, ул. Е-899, 5/1а	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13592	71.38775	Бизнес		\N	https://bi.group/ru/landing/greenline-velora	https://s3.bi.group/biclick/3a7456d7-8ef3-11f0-a834-001dd8b726aa/3a7456d7-8ef3-11f0-a834-001dd8b726aa_foto_400.jpg	{}	\N	2026-01-20 15:57:41.708736+05	ЖК Greenline. Velora. Адрес: г. Астана, ул. Е-899, 5/1а
ec2e9bbe-381a-4093-9c12-15af262caaae	485e3599-c424-48ca-bf3c-bc62cf1098de	Greenline.Aurora	г. Астана, пересечение улиц Е-27 и Е899	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13385	71.3865	Бизнес		\N	https://bi.group/ru/landing/greenline-aurora	https://s3.bi.group/biclick/485e3599-c424-48ca-bf3c-bc62cf1098de/485e3599-c424-48ca-bf3c-bc62cf1098de_foto_400.jpg	{}	\N	2026-01-20 15:58:47.092814+05	ЖК Greenline.Aurora. Адрес: г. Астана, пересечение улиц Е-27 и Е899
53b406fa-fda1-4e13-87f5-67ec4c70a3f0	c40534e8-00c2-409e-8d23-514940a4aa1a	GreenLine. Verda	г. Астана, бигвилль GreenLine	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13714	71.38776	Бизнес		\N	https://bi.group/ru/landing/greenline-verda	https://s3.bi.group/biclick/c40534e8-00c2-409e-8d23-514940a4aa1a/c40534e8-00c2-409e-8d23-514940a4aa1a_foto_400.jpg	{}	\N	2026-01-20 16:07:22.647753+05	ЖК GreenLine. Verda. Адрес: г. Астана, бигвилль GreenLine
3392e766-0500-4503-958a-4e8781bba820	db0e58a6-220f-4ca3-8ee9-fdf21ea719e0	Capital Park Vector	г. Астана, пересечение ул. Бухар Жырау и К. Кайсенова	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.09932	71.44617	Бизнес		\N	https://bi.group/ru/landing/capitalpark-vector	https://s3.bi.group/biclick/db0e58a6-220f-4ca3-8ee9-fdf21ea719e0/db0e58a6-220f-4ca3-8ee9-fdf21ea719e0_foto_400.jpg	{"side": "Left", "tags": ["Ботанический сад", "EXPO", "Mega Silk Way", "Astana Ballet", "Nazarbayev University", "Binom School", "школа рядом", "детский сад рядом", "супермаркет", "аптека", "фитнес-центр", "кофейня", "ресторан", "парк рядом", "прогулочная зона", "велодорожки", "детская площадка", "закрытый двор", "видеонаблюдение", "паркинг", "автобусная остановка", "спортивная площадка", "Small", "Magnum", "медицинский центр", "стоматология", "салон красоты", "цветочный магазин", "химчистка", "банк", "банкомат", "фудкорт", "торговый центр", "интеллектуальная школа", "лицей", "центр развития", "мини-маркет", "пекарня", "зоомагазин"], "atmosphere": ["семейный", "современный", "развивающийся", "ветреный", "просторный", "молодежный", "деловой", "широкие дороги", "новые дома", "близость к парку", "активное строительство", "развитая инфраструктура", "панорамные виды", "чистые улицы", "хорошие дороги", "безопасный", "перспективный"], "district_name": "Есильский"}	[-0.032106057,0.005491274,-0.019838395,-0.0049698986,-0.0021111914,0.012845138,0.018691927,-0.0037770208,0.001416324,0.029475488,-0.0017299997,0.03146731,0.036786254,-0.016532676,-0.00857743,0.0064805886,0.03551993,0.05172056,-0.13905053,-0.019398395,0.015986258,-0.020608505,0.057706412,-0.003073576,-0.05030977,-0.031541307,-0.07962915,0.013607238,-0.004114402,-0.027885435,0.02573856,0.047053132,0.013194216,-0.014336916,0.0035686912,0.023104362,-0.043383908,-0.014644647,0.02882188,-0.01888679,-0.0703114,0.036452267,0.009932015,0.014451816,-0.0766298,-0.05547744,-0.0071541676,0.015743531,-0.04024203,0.0070276684,0.012871371,-0.04138096,-0.040912542,0.04693123,-0.07417795,-0.018973446,-0.02185985,-0.04250599,0.077240564,-0.0015333982,0.017883025,0.005473687,0.01311278,-0.004539665,0.03954026,-0.017057125,-0.06884448,-0.012086706,-0.0585808,0.011085841,-0.035806112,0.10405132,-0.030616174,0.0016405139,-0.011388473,-0.036508422,0.020181583,0.0055336137,0.026421672,0.07362876,-0.058670692,-0.019720845,0.02573308,0.034193076,0.016094204,0.0069699017,0.01788869,-0.04672821,-0.07221991,-0.0154151,0.06865171,0.037954047,0.04734485,0.033322807,0.084172726,0.0060638175,-0.10617529,-0.12517399,0.058043696,0.029999707,0.02546918,0.028540617,-0.02923336,-0.034354646,0.0006079918,0.08008869,-0.05420881,-0.07074928,-0.06591189,0.020406079,-0.004450164,-0.01811136,-0.006515161,-0.016854284,0.00745387,0.026451625,-0.103405416,0.06861262,0.008371786,0.04149324,-0.010182361,-0.0017106304,0.0015101787,0.040754378,0.011359169,0.014217507,0.019276256,-0.032707203,-0.04243331,-0.03554577,0.013852891,-0.038898494,-0.0047693113,0.00024260217,-0.02080204,0.016144598,0.05111856,-0.0069180415,-0.012147325,-0.010769932,0.0099968,-0.02563142,-0.03361142,-0.0041441387,0.018909417,-0.028299041,0.027221527,0.05005479,-0.04219147,0.014621546,-0.06698758,-0.017243791,0.0057590697,0.0025297024,0.0013128623,-0.020386325,0.07514736,-0.054028526,0.0040194364,-0.054360304,0.050122216,-0.04834605,-0.02319992,0.029997729,-0.0047989283,-0.009021269,-0.003700231,-0.023931403,-0.02565109,0.024623366,-0.053544775,-0.06899571,-0.014743616,-0.051555376,-0.02678032,0.015513462,-0.03924314,0.008444813,-0.022135898,0.030464828,0.10457896,-0.03098976,-0.006715379,-0.08584522,-0.002351037,0.04431365,-0.0344309,0.03837611,0.032333568,0.015233488,0.009949913,0.011931649,-0.007114422,0.056055933,-0.03931009,-0.042874042,0.0595613,-0.06718637,-0.008115678,-0.040632065,0.042861525,-0.057712533,-0.00050218677,-0.055546865,-0.053389024,0.034440115,-0.03042648,-0.08399356,-0.05665439,0.062092412,-0.002153012,0.0064656064,-0.016050044,-0.065792136,0.015368105,0.014525956,-0.002234096,-0.02275923,0.077603176,-0.08036819,-0.01286549,0.016567977,0.08195248,0.014118824,0.050534207,-0.030834043,0.038619447,-0.032822717,0.024183132,-0.04992296,-0.042258304,-0.021886243,-0.014445128,0.029058093,0.00041137173,0.040412504,-0.01307444,-0.059681814,-0.032110658,-0.009561047,0.00798737,0.031340227,0.014078817,-0.00922348,0.004982977,-0.012909033,0.027658658,0.021050015,0.03329082,-0.000241146,-0.026485967,-0.0115498,-0.020344188,-0.006933531,-0.047770217,-0.0560484,0.014240922,-0.0103830015,-0.034525312,-0.008724198,-0.016894536,-0.011132592,0.0273682,-0.07438407,-0.061140772,-0.036065202,-0.03819044,-0.011394994,0.052024465,-0.04161753,0.07169396,-0.046097245,-0.026573628,0.022309268,-0.013166305,0.058392826,-0.022470312,0.03608515,-0.0400033,-0.039500754,0.049339835,0.0013298298,-0.042273752,0.0064099818,0.012887547,-0.050484814,-0.013060039,0.0024970935,-0.016545452,-0.018706689,0.016531339,0.08148923,-0.002327941,-0.00961455,0.016521286,-0.024928225,0.025939213,0.009984425,0.004342405,-0.060339242,-0.0004589209,0.05914149,-0.051881507,0.03289065,0.0023761136,-0.027902,0.014103541,-0.015744988,-0.0154635105,0.0027960474,0.030533655,0.03208238,-0.04063663,-0.04513322,-0.014998198,-0.00012510037,-0.1383815,-0.062756464,0.010648161,-0.011408417,0.029782213,0.083638035,-0.0080122845,-0.020203367,0.03269436,-0.005036841,-0.021952115,-0.055257328,0.04883682,-0.017430604,-0.0029285946,-0.014750581,0.006364876,-0.047761846,-0.0016865635,0.043866336,-0.09086907,0.014453657,0.05269824,0.02574494,0.03871306,0.014652791,-0.009999784,-0.01209596,0.01722166,-0.02778336,-0.0012015096,0.030370377,0.026355486,0.0091852555,0.029696316,0.020607444,-0.0095951855,-0.026226671,0.050741825,-0.013784496,0.04466788,-0.0053250454,-0.0014768449,-0.066389315,-0.0035713986,-0.0107741365,-0.0016191101,0.030727247,0.008899338,-0.016879695,-0.028127488,0.0503634,-0.0659881,-0.022060003,0.0075259428,0.030192677,0.02167403,0.0005649722,-0.018921388,0.00084583537,-0.027652174,0.015348973,0.015848337,-0.012154067,0.0051705423,0.013036376,0.008197658,0.032446194,-0.008714882,0.041175805,-0.052581195,-0.007202988,-0.009492894,0.016177058,-0.00448993,0.012963881,-0.0027875928,0.054184716,0.020835003,0.018063568,0.041065942,0.0830075,0.036603976,0.00991,-0.0053703026,-0.03520968,0.085713744,-0.025702806,-0.017768374,-0.044642687,0.037703574,0.026933108,-0.029804872,-0.0052738227,-0.009919978,-0.030994259,-0.027033616,0.029167289,-0.049558256,-0.011571524,-0.011276794,-0.010206143,0.0021952142,-0.028817754,-0.03609692,0.021114117,0.036443785,-0.0007208452,0.006305965,-0.074290134,0.010833002,-0.021209206,-0.003213729,-0.0102322465,0.01406682,0.033934776,-0.016181327,0.044926386,0.034220498,0.08945016,-0.0015172603,-0.035082918,0.0018296657,0.023887003,-0.024378477,-0.005737705,0.015316214,0.0016141715,0.0042421846,0.04189751,0.022019021,0.010728796,-0.01284785,-0.01357994,-0.034257617,-0.0126213785,0.006129793,-0.0006344361,-0.053454734,0.034137886,0.014450214,0.009359316,-0.05459751,0.026620325,-0.04004874,-0.024836555,0.042301558,0.031184614,0.01665742,0.025508089,0.023662329,0.074371435,-0.024347328,-0.014739344,0.07826919,-0.00088734267,0.02803831,0.0074356077,0.0135979755,-0.019717801,0.009626511,0.0013612568,-0.026146937,-0.02331695,0.014624782,0.02621766,-0.06559244,0.0013180189,0.035551783,-0.035513517,0.0067601237,0.049581934,-0.034680743,-0.00661137,-0.01300855,0.0016155181,-0.022524139,-0.05782144,0.02581999,-0.009954195,0.06385216,0.038518254,-0.017704936,0.02439698,0.08404471,0.028849293,0.010878946,-0.081103764,0.0014596833,0.053373035,-0.06385333,-0.008974314,0.0638381,0.0154386815,0.032199487,-0.009875618,-0.03437473,0.047998536,-0.01968694,-0.017228434,-0.028987998,0.009874738,-0.0020052583,-0.028096221,-0.008099322,-0.01290781,0.036163848,-0.047859125,0.0056650103,-0.014278269,0.0006778105,-0.015557455,0.017935993,0.026160378,-0.038962275,0.020805651,0.039484702,0.041448094,0.031395685,0.06370804,-0.008422648,0.054548327,-0.0036186085,0.045588974,-0.00027945606,-0.024198065,-0.028725507,0.035525575,0.0168958,-0.03583866,-0.012028164,0.055670463,-0.02331796,0.06407156,0.011438276,-0.056430195,-0.051842358,-0.04395267,-0.027015878,-0.027431853,0.022967033,-0.02031753,-0.092545226,-0.0015233228,-0.008669079,0.004830897,0.04202571,-0.012928039,0.0051346454,0.03369384,0.032741997,0.049184445,-0.055478677,0.006565944,-0.00079834415,-0.008586002,0.024884513,-0.036211096,0.07015619,-0.030544974,-0.062070474,-0.004576127,0.011307084,-0.036134727,-0.012838359,0.035733957,0.044449255,-0.0061656586,0.025744656,-0.008273199,0.017375158,-0.032681473,-0.0175386,0.041253906,0.009372369,0.039861023,0.00044421945,-0.08033872,0.02361572,-0.018074093,-0.039711796,0.043981697,0.0451414,-0.004363132,0.033186615,-0.0047351285,0.026009312,-0.020611288,-0.011361145,-0.08101978,0.03334056,-0.020080626,-0.030701585,-0.024365565,-0.021318154,-0.040689573,0.023376578,-0.020068847,-0.051235445,0.003605729,-0.0144523475,-0.04047518,0.014016941,0.023822093,-0.0035308376,0.004428445,0.0026138634,-0.0056838742,0.0015442972,0.0034422316,0.032249477,0.008689116,-0.0029216874,0.0068014883,0.029624235,-0.042310227,0.03631606,-0.035454832,-0.00412594,0.049013007,0.02623991,-0.016754916,0.03361406,-0.052269,0.020806193,-0.014281349,0.06140524,-0.016741144,-0.014267184,0.07858575,0.025535356,-0.022216273,0.015159756,0.07664693,0.008518591,-0.0007512145,-0.04938909,0.078294925,-0.003822214,0.048861057,-0.019377604,-0.014102319,0.014878702,0.052250244,-0.017910877,0.008663228,0.0047994573,0.021364149,-0.060121644,0.07594408,-0.049218893,-0.0089275185,0.017684646,-0.029522425,-0.03247323,0.025333948,-0.06284186,0.036205817,0.011647151,-0.029370409,0.03824364,-0.009356106,0.0194549,-0.005455381,-0.0062550637,0.005336717,0.02047294,-0.09165926,-0.036734767,-0.0024463518,-0.0020528415,0.0265539,-0.05362722,-0.027893454,0.0021374447,-0.012086196,0.009691559,0.010498167,-0.0018089687,0.03722944,-0.019936796,0.010325449,-0.00028945223,-0.018701062,-0.0014630299,0.0032916188,-0.0748387,-0.07083901,0.013804121,0.00078502484,0.036933478,0.012868046,0.004602461,-0.011381726,0.011111925,0.00020905393,0.033129063,0.057353586,0.016583903,0.055651624,0.04967595,-0.0020859884,0.016943024,-0.006320373,0.030113764,0.003101673,0.019739183,0.009600238,0.06696951,-0.03125075,-0.06937704,-0.012216489,-0.012169156,0.071370125,0.023438565,-0.01197904,0.006936908,0.031811487,0.007489242,-0.043040432,-0.022661958,-0.02584801,0.002639265,0.005701964,0.043853648,-0.0011062836,-0.024122175,-0.01595553,0.0004983781,0.010066289,0.03389119,0.0063694003,-0.033266205,-0.033998586,-0.04703687,-0.009327288,-0.0075718774,-0.02716323,0.08112163,0.03598617,0.023254262,-0.012860813,-0.0045142435,0.013340749,-0.007605258,0.062733084,-0.002300384,0.05465494,-0.031237653,-0.030687964,0.066747226,-0.015805477]	2026-01-20 16:05:46.113748+05	ЖК Capital Park Vector. Адрес: г. Астана, пересечение ул. Бухар Жырау и К. Кайсенова
a7ac43bf-e821-4c56-a499-e50df137a2e3	11c8fd42-6f74-11ef-a830-001dd8b72708	GreenLine.4YOU	г. Астана, вдоль ул. Кайым Мухамедханова	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13843	71.39421	Бизнес+		\N	https://bi.group/ru/landing/greenline-4you	https://s3.bi.group/biclick/11c8fd42-6f74-11ef-a830-001dd8b72708/11c8fd42-6f74-11ef-a830-001dd8b72708_foto_400.jpg	{}	\N	2026-01-20 16:08:26.978876+05	ЖК GreenLine.4YOU. Адрес: г. Астана, вдоль ул. Кайым Мухамедханова
302bf159-af0e-4961-ae16-9f2759439b59	557bf122-0035-4843-a373-c4f565cbb080	IZBASAR	г. Астана, пр. М. Жумабаева	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.11293	71.49845	Комфорт+		\N	https://bi.group/ru/landing/izbasar	https://s3.bi.group/biclick/557bf122-0035-4843-a373-c4f565cbb080/557bf122-0035-4843-a373-c4f565cbb080_foto_400.jpg	{}	\N	2026-01-20 15:59:49.441661+05	ЖК IZBASAR. Адрес: г. Астана, пр. М. Жумабаева
97d12c96-1111-4481-8bd5-6eb5d51a915e	b42a5e8b-4e96-46ed-9056-560139708590	Abyroi	г. Астана, ул. Т. Рыскулова, 18/5	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.07983	71.4388	Комфорт+		\N	https://bi.group/ru/landing/abyroi	https://s3.bi.group/biclick/b42a5e8b-4e96-46ed-9056-560139708590/b42a5e8b-4e96-46ed-9056-560139708590_foto_400.jpg	{"side": "Right", "tags": ["школа рядом", "детский сад рядом", "супермаркет рядом", "аптека рядом", "поликлиника рядом", "остановки общественного транспорта", "парк рядом", "сквер рядом", "продуктовые магазины", "кафе", "салоны красоты", "фитнес-центр", "детская площадка", "спортивная площадка", "рынок", "ТЦ", "вокзал Астана-1", "почта", "банки"], "atmosphere": ["тихий", "семейный", "зеленый", "спальный", "уютный", "развитая инфраструктура", "чистые улицы", "хорошие дороги", "умеренный трафик", "старый центр"], "district_name": "Алматинский"}	[-0.0141604645,0.017221408,-0.025939558,-0.006840149,0.010697017,-0.01142962,0.031023586,-0.007871387,-0.026202533,0.060031034,-0.017832125,0.038428623,0.01802386,-0.011543444,0.020878961,0.016396381,0.03338012,0.024495397,-0.12617569,0.014452922,0.032464113,-0.008749679,0.06278277,-0.029578581,-0.030851187,-0.05725196,-0.015684277,0.023018813,0.012921159,-0.013915017,0.011386169,0.028736155,0.005799843,0.006813936,0.035584893,0.03549577,-0.01221851,-0.016856391,0.03429617,-0.044368032,-0.07847504,0.040009353,0.01819808,0.0238508,-0.0713952,-0.0633089,-0.058085673,0.010958168,-0.052168883,0.019486794,-0.0020810668,-0.010677827,-0.031183632,0.047930893,-0.101435766,0.00866897,-0.017470375,-0.0344369,0.09621337,-0.0065922104,0.0005980853,0.008289581,-0.008239265,-0.011695881,0.022903843,-0.014849339,-0.023136348,0.015768379,-0.05760827,0.04132798,-0.031400986,0.04872617,-0.040192254,0.033542626,-0.0070731146,-0.0019807522,-0.0033594025,0.022158869,0.026846545,0.030816358,-0.039670054,-0.029092064,0.0564153,0.025068395,0.003414633,-0.016102957,0.019062452,-0.040842965,-0.073580995,-0.04354458,0.06632818,0.014351934,0.03479119,0.01764053,0.066356406,0.0402698,-0.10427366,-0.09544823,0.07799563,-0.016391579,0.011453206,0.019390346,-0.05593458,-0.09322156,0.048025463,0.08572249,-0.04839948,-0.054889105,-0.058168054,-0.006050793,-0.017369067,-0.00029174675,0.039277606,0.014422302,0.0293938,0.034484833,-0.08312549,0.050467853,-0.013829546,0.016493356,0.021070821,0.01120927,-0.033952665,0.052933067,0.011917653,-0.012064737,0.035153054,-0.020435205,-0.032215454,-0.009112123,0.029843798,-0.04215534,0.0066264886,0.010276252,-0.019387169,-0.0021984833,0.038809773,-0.040801298,-0.010867176,0.029379467,0.015840085,-0.041779283,-0.09315155,-0.020471025,-0.005336927,0.016564531,-0.015850566,0.090662114,-0.030715985,0.013321486,-0.04320095,-0.02659079,0.026227092,0.00059176504,-0.0058621676,0.010289685,0.04796685,-0.058307547,0.01586296,-0.026760658,0.03629747,-0.049528472,-0.01935655,-0.005286073,0.011828035,-0.02592694,0.012680014,0.0072594834,-0.03756501,-0.0009271356,-0.059873562,-0.08621262,-0.0069483793,-0.071713984,-0.018801952,-0.01869613,-0.02040262,0.037472352,-0.011687742,0.0184248,0.10354171,0.011180607,-0.027638966,-0.09219252,-0.0099607445,0.018165573,-0.004946182,0.06484291,0.062360793,0.0052520838,0.034187324,0.03025459,-0.0010313584,0.057668645,-0.038794186,0.010791473,0.0370565,-0.04759442,0.014303513,-0.04874995,0.033036876,-0.05291403,0.008306407,-0.012317438,-0.015077256,0.034365162,-0.021306327,-0.06313653,-0.01309734,0.041483946,-0.00932404,-0.003734304,-0.040139835,-0.053322893,0.030725596,-0.008394508,0.02076631,-0.04232107,0.071996436,-0.07104012,-0.0026535408,0.021605443,0.053891297,0.019500274,0.02794399,-0.007723041,-0.023582,0.010688175,-0.026126804,-0.03007856,-0.031322613,0.00011869707,0.0035736603,0.03557931,-0.034176808,0.042006068,0.05111938,-0.043469746,-0.06326033,-0.018321384,-0.034494836,0.037150938,0.014909568,-0.03725616,0.013406195,-0.010460049,0.06509336,0.05843517,0.026422396,0.0059064347,-0.033640407,-0.032401286,-0.00566408,-0.014118657,-0.07343449,-0.066544496,0.019460402,0.009653599,-0.02198156,-0.02306257,0.014126156,-0.01842608,0.021996183,-0.051855877,-0.045113403,-0.02853947,-0.006625465,-0.017549122,0.020177862,-0.04035049,0.063528806,-0.04356119,-0.05460451,-0.0074484283,-0.055538528,0.087129995,-0.010714192,0.044508714,0.01981982,-0.010000541,0.03896772,0.011140881,-0.045770474,0.0100996625,0.018458348,-0.074415475,-0.0054094642,0.0415981,-0.032779835,-0.02214234,0.039931048,0.06757059,0.0008156113,0.00030181545,0.016078511,-0.038250554,0.034740664,0.012636532,0.0021427292,-0.05496368,-0.0010069616,0.054587632,-0.03008501,0.021481039,-0.013886983,-0.032316975,-0.02318399,0.0037655262,-0.027658002,0.0054601217,0.013882187,0.041331913,-0.052502643,-0.02529307,-0.057060506,-0.027424235,-0.13535526,-0.058666784,-0.01146705,-0.005263756,0.04158984,0.07762155,-0.004866249,-0.016465455,0.05560911,-0.027128976,6.28293e-05,-0.010617306,0.074861236,-0.03482378,-0.006114786,-0.0016210896,-0.035781104,-0.06349672,0.0007757146,0.035415363,-0.07534852,0.012445167,0.043789595,0.057968948,0.0391576,0.04067868,0.0047406936,0.031687155,0.0002858113,-0.02781374,0.015061224,0.003825174,0.03308564,-0.0011458064,-0.00022738447,0.045438007,-0.043139044,-0.07719098,0.024291681,-0.02587363,0.03295584,-0.016458819,-0.0070680045,-0.0637105,-0.050552666,0.0013299359,0.013789159,0.042596817,-0.0012948656,0.025570009,-0.014224129,0.05618136,-0.06196605,0.0040238835,0.0043508657,0.0015104704,0.02383114,0.011872115,0.012539006,0.005839368,-0.06009549,0.005824302,0.038593322,-0.017480375,0.00017720964,-0.0004915116,-0.008249274,0.029852878,0.002514168,0.060666088,-0.030827792,-0.02389458,0.00026096345,-0.0007652484,-0.040105674,-0.010270945,0.03983136,0.06121862,0.026362924,0.04908433,0.04348162,0.054711957,0.032053858,0.0022115442,0.019396927,-0.029670667,0.071713276,-0.017278152,-0.012824225,-0.0134288855,0.077299595,-0.003912976,-0.028221963,0.0006109996,0.0025599308,-0.03052908,-0.028567486,-0.0070830844,-0.05772814,-0.023620991,-0.0018720399,-0.029246405,0.005412511,-0.012942232,0.019535895,0.020944905,0.006913316,-0.029588424,0.038149282,-0.07296942,-0.01664526,-0.02197773,0.015374368,0.013031203,0.045500547,0.03330916,-0.0008129194,0.05747908,0.052454144,0.0661269,-0.008508285,-0.043667093,-0.03260083,0.036188852,0.007787026,0.017293481,0.030259807,0.00016453277,0.0009452846,0.053055264,0.040123917,0.022901267,-0.039491896,-0.029511562,-0.016399011,-0.007642826,0.0074801957,0.014275535,-0.0931251,0.010302915,0.041382488,0.011168038,-0.03859117,0.03569741,-0.07661969,-0.047976602,0.04424403,-0.0039695697,-0.010464337,0.012832923,0.003054551,0.048495032,-0.022972565,0.003841817,0.03941487,0.019926198,0.031735346,0.01329024,0.013489596,0.010287417,0.0041288896,-0.025396837,-0.055499673,-0.041895557,-0.014913228,0.023575962,-0.065542966,0.015295121,0.04613702,-0.054005854,-0.01514364,0.06565629,-0.03193411,-0.044205163,0.0045050182,0.0056113633,-0.0015027992,-0.01138584,0.023117911,-0.02489949,0.029343436,0.03429162,-0.0007749715,0.008095256,0.035181113,0.038238127,0.03278298,-0.06978616,-0.0019418409,0.048771214,-0.06203934,0.0024044767,0.0012622216,0.014333922,0.037243363,-0.03102366,-0.00588584,0.063707076,-0.0016571467,0.0051862225,-0.01042526,0.030244958,-0.010903426,-0.010504958,-0.044183876,-0.00840608,0.021972513,-0.012249997,0.019976165,-0.010012518,-0.0035879933,-0.025863178,0.01681472,0.020429224,-0.03984713,0.017346233,0.029095681,0.057795286,0.036593426,0.046536386,-0.014158188,0.035824496,-0.012475849,0.011326764,0.018856715,-0.031225523,-0.03360853,0.027325695,0.030731633,-0.028537773,0.0063575753,0.08095233,-0.034803614,0.065865695,0.012915894,-0.0528924,-0.0396268,-0.044190347,0.010938292,-0.02276796,0.022910295,-0.029046401,-0.073577024,0.0019649842,-0.0045727077,-0.012723702,0.04834534,-0.033196166,-0.009696476,0.017323403,0.0022687397,0.07129868,-0.013721622,0.024422549,0.03843792,-0.0017394361,0.008735299,-0.03831535,0.05546711,-0.025929699,-0.07077685,-0.0032726638,0.001839658,-0.03929477,-0.03869004,-0.008828566,0.036757432,-0.016195953,0.033601604,0.012367541,0.027873762,-0.00876539,-0.04067963,0.018998345,-0.017038215,0.020658694,0.022510236,-0.06278592,-0.0013428418,-0.0026409482,-0.009523979,0.027062654,0.017714398,0.009434971,0.049841397,0.029089734,0.040816806,-0.012636075,-0.02889776,-0.044421025,0.023376174,-0.02435682,0.00079494104,-0.007217268,-0.019463664,-0.013124676,0.026005954,-0.04477714,-0.04222797,0.008208468,-0.013845896,-0.028573507,-0.0029831587,0.029590517,-0.014636075,0.018187284,-0.0111593,0.0030089943,-0.05869736,-0.040800788,0.019694466,0.004390716,0.019074943,0.0026758658,0.013908572,-0.059283163,0.014887067,-0.03864408,0.0073807705,0.02898519,0.021119086,-0.04282168,0.025501586,-0.04650139,0.024280889,0.0026954392,0.046334393,-0.021331066,-0.061136995,0.05103126,0.03174223,-0.05825052,0.027099386,0.0680226,0.0313506,0.039548725,-0.046849854,0.08611412,-0.032597873,0.0031016236,-0.010118077,-0.02877642,0.059046034,0.0003689887,-0.035456657,-0.025978453,-0.014813245,-0.0033031164,-0.033126004,0.040552124,-0.021064918,-0.0091196485,0.030786311,-0.009686124,-0.02199301,0.010311134,-0.041173942,0.0034086471,-0.0049884776,-0.046048228,0.037393443,-0.01856392,-0.0406022,0.01454865,-0.016808195,-0.016317701,-0.00016403705,-0.06489734,-0.023502495,-0.02776668,0.03929811,0.02884512,-0.03148978,-0.027852084,-0.0032564425,-0.02957443,-0.0092537375,0.019158652,-0.019478343,0.05099241,-0.010333241,-0.019786283,-0.034715496,-0.02414511,0.005056771,0.028626978,-0.088946626,-0.061313245,0.009005692,0.00011575733,0.022586042,0.018952874,-0.005255978,0.010323178,-0.009832582,0.007467597,0.0033971106,0.0539413,-0.003384536,0.06901879,0.009032682,-0.015690183,0.0052152057,-0.0102560595,0.028255824,-0.009351325,-0.005718178,0.016493268,0.05557966,-0.0049345675,-0.064916186,-0.012257158,-0.018489322,0.043864794,-0.0065829577,0.010231391,0.0024152235,0.03655701,-0.014386362,-0.024500828,-0.028337795,-0.0012091022,-0.028639391,0.0027367803,0.04828808,-0.0016723112,-0.03600505,-0.025512973,-0.022551944,-0.015003727,0.01361258,0.0013259823,-0.030361302,-0.045307223,-0.053639688,-0.020504676,0.00014695745,-0.030700015,0.10209764,-0.014550959,0.003164835,-0.044399034,0.0013814892,0.04287297,-0.02395776,0.057382092,0.03762517,0.040830385,-0.060870405,-0.01991583,0.06472653,-0.045681093]	2026-01-20 16:04:46.697046+05	ЖК Abyroi. Адрес: г. Астана, ул. Т. Рыскулова, 18/5
efb1d717-725c-4541-92ab-62173f6aebf9	a9b5179d-b8d6-11ee-a82d-001dd8b72708	Atlant Unique	г. Астана, ул. Д. Конаева, 3	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.13332	71.41784	Бизнес+		\N	https://bi.group/ru/landing/atlant-unique	https://s3.bi.group/biclick/a9b5179d-b8d6-11ee-a82d-001dd8b72708/a9b5179d-b8d6-11ee-a82d-001dd8b72708_foto_400.jpg	{"side": "Left", "tags": ["Байтерек", "Акорда", "бульвар Нуржол", "Водно-зеленый бульвар", "ТРЦ Керуен", "ТРЦ Азия Парк", "Казмедиа центр", "Министерства", "парк Жетысу", "Ботанический сад", "школа рядом", "детский сад", "супермаркет Galmart", "Magnum", "аптека", "рестораны", "кофейни", "фитнес-центр", "банки", "паркинг", "охрана", "видеонаблюдение", "автобусная остановка", "удобная транспортная развязка", "бизнес-центры", "фудкорты", "элитное жилье", "центр города", "левый берег", "прогулочные зоны", "велодорожки", "фонтаны", "Национальная библиотека", "Национальный архив", "Керуен Сити", "Хан Шатыр рядом", "мечеть Абу Наср аль-Фараби", "Казмунайгаз", "КТЖ", "отель Ritz-Carlton", "Talan Towers", "медицинские центры", "салоны красоты", "химчистка", "цветочные магазины", "детские площадки", "спортивные площадки"], "atmosphere": ["элитный", "деловой", "современный", "престижный", "шумный", "ветреный", "красивый вид", "широкие дороги", "правительственный квартал", "активный", "статусный", "безопасный", "освещенный", "урбанистический", "туристический", "динамичный", "чистые улицы", "хорошие дороги", "панорамный вид"], "district_name": "Есильский"}	[-0.012917337,0.0117393695,-0.005968615,-0.002240552,-0.0061001675,-0.028274687,0.03745419,-0.042810537,-0.0004944338,0.06851824,-0.006862157,0.032538604,0.05775742,-0.040949907,0.019382862,0.020128906,0.04687625,0.045507126,-0.1248349,-0.029455196,0.05471415,-0.012499466,0.045561206,-0.011442726,-0.043243703,-0.036643457,-0.05758731,0.023344422,-0.010227549,-0.04996614,0.03910831,0.041874215,-0.013149426,0.028393302,0.018637989,0.0043184934,-0.0059491205,-0.051825833,0.017028036,-0.046321403,-0.036520958,0.035626356,0.017074673,0.02260231,-0.06563415,-0.06611717,-0.045747913,0.025773754,-0.045676187,-0.004236151,-0.017641552,-0.050104763,-0.0263562,0.045324795,-0.07182043,-0.012736031,-0.021880593,-0.014249119,0.055907957,0.0031227528,0.008249801,0.030051926,0.0116166845,-0.014177369,0.0051034647,-0.01704834,-0.04149354,0.0028935347,-0.06688983,0.025680501,-0.024577694,0.07872715,-0.036126647,0.017631525,-0.022132842,-0.0041181925,-0.0076328414,0.0026338017,0.04483473,0.041232854,-0.057971083,0.007887055,0.02568072,0.03588762,0.028074836,0.0055719167,0.0023949188,-0.027064791,-0.062482305,-0.020283233,0.07484089,0.02224143,0.05273357,0.034258433,0.0659383,0.015008371,-0.14064848,-0.11654217,0.04037478,0.004249468,0.009745341,0.014466173,-0.066375755,-0.06448406,0.013267254,0.057268444,-0.054806013,-0.06967227,-0.072007254,0.026752321,-0.01230555,-0.0005398605,0.012629867,0.0048753517,0.009806202,0.01828234,-0.07070443,0.04256446,0.00768598,0.018352902,0.023584345,0.016638288,-0.033579145,0.04767432,-0.02576247,-0.0015488124,0.013495931,-0.030254591,-0.029173788,-0.010728358,0.027902968,-0.01797529,-0.015091547,0.001811975,-0.03627017,0.0117807975,0.05972849,-0.032059263,-0.0071632415,0.0023139426,0.016554976,-0.018601336,-0.07404181,-0.024718806,-0.00093650917,-0.012937956,0.01750316,0.06502112,-0.06763576,0.007123874,-0.05856502,-0.04649115,0.023731207,-0.00016321853,0.04124882,0.01935395,0.03069247,-0.05468395,0.022729702,-0.027494064,0.044257805,-0.05367887,-0.022724574,0.009060733,-0.016176013,0.011801948,0.022507489,-0.013375924,-0.026601473,0.020112243,-0.028911904,-0.0799966,-0.027487718,-0.05554895,-0.01085336,0.012558615,-0.022098549,5.9068548e-06,0.01064176,0.0021793835,0.12967126,-0.017632907,0.00046954074,-0.078447394,0.009543784,0.019757139,-0.022042548,0.054825936,0.029136391,-0.00511508,0.008560375,-0.0025708592,-0.007747285,0.0641744,-0.07787433,-0.02934518,0.032822184,-0.062496718,0.015839234,-0.06820308,0.04498015,-0.02324583,-0.0013874723,-0.03002478,-0.019481283,0.02204052,-0.030501164,-0.056311097,-0.05016295,0.022204759,-0.013168913,-0.012538404,-0.036358315,-0.0679626,0.027740547,-0.0070192013,0.0029046822,-0.030549135,0.11037973,-0.08151062,-0.008092265,0.021771211,0.060263235,0.017194284,0.07284043,-0.0033585872,-0.001718274,-0.0018442626,-0.0066301795,-0.034060482,-0.038943578,-0.0005657984,0.01796482,0.022962445,0.0059092324,0.0016147031,0.033561148,-0.04411471,-0.034429938,-0.03355597,-0.02362319,0.0034144924,0.020831691,-0.04410162,0.012049443,0.0020327196,0.039876193,0.038798325,0.029942458,0.014937935,-0.050585017,-0.004627002,0.01723887,0.025690846,-0.061189745,-0.04388599,0.018093484,-0.01728522,-0.014766174,-0.034346376,-0.008802759,-0.027914837,0.0024553894,-0.072179444,-0.04462548,-0.02080651,-0.040203467,-0.0015235809,0.025158802,-0.030425552,0.06554573,-0.036183905,-0.035732165,0.0027037882,-0.028391205,0.07210277,-0.033421364,0.047500677,-0.031371143,-0.043111946,0.033928916,-0.0027121077,-0.049208194,0.024267266,0.021493705,-0.06198927,-0.009456032,0.030742548,-0.023094332,-0.03297241,0.005538679,0.054134917,0.0050978367,0.0037653954,0.025080161,-0.03956325,0.02324635,0.047848184,-0.0037134574,-0.051745374,0.020750633,0.045918163,-0.03960937,0.04774954,-0.0019271268,-0.03951117,0.002921791,0.019016292,-0.014748631,-0.011191297,0.013621618,0.035752505,-0.03993507,-0.03927593,-0.037842743,-0.020262577,-0.15224124,-0.05374663,0.022978716,-0.0186944,-0.0141298855,0.065144084,-0.0087546045,-0.010031295,0.021164168,-0.0062646638,-0.023574883,-0.03552321,0.06254668,-0.043975756,-0.007882269,0.0057678674,0.00097352243,-0.05212448,0.00018175291,0.011223052,-0.06966077,0.026831057,0.045881853,0.020337364,0.036414057,0.024157632,0.003327097,0.02294975,0.0058331224,-0.01745998,-0.00047961395,0.009266268,0.014685972,0.02585865,0.039201487,0.0036788261,-0.052115392,-0.057133842,0.023713209,-0.0030359407,0.056019954,-0.0009426449,-0.009998853,-0.087145075,-0.044729527,0.008196735,0.001197925,0.029582622,-0.00010068273,0.027147895,-0.02712308,0.064559035,-0.03921389,-0.020250943,0.025413591,0.0053814906,0.014836124,-0.008628617,-0.015926339,0.009270408,-0.060887422,0.004244767,0.025774779,-0.0050053876,-0.014421771,0.010935263,-0.020651637,0.045741502,0.006741442,0.07480623,-0.044169173,-0.016969949,-0.029591009,0.010505545,-0.014367735,0.012598465,0.026164213,0.037243098,0.021884197,0.04058415,0.038572792,0.051884875,0.04509165,0.024040777,-0.012271316,-0.03985199,0.088726096,-0.02936336,-0.014593568,-0.013103861,0.08301911,-0.021794358,-0.009367461,0.02376464,-0.0410506,-0.030029517,-0.034333162,0.0132570565,-0.025215464,-0.031672362,-6.553082e-05,-0.018813733,0.02059139,-0.031038145,-0.012404536,0.03221268,0.04923785,-0.017146472,-0.0012724048,-0.0822475,0.0020178112,0.013160196,-0.0024384297,0.005930568,0.040994786,0.045759615,0.0078085284,0.025234587,0.0067583774,0.08239552,-0.003134345,-0.024073785,-0.02368484,0.022148443,-0.049726542,0.0027938613,0.05580927,-0.013130722,-0.0068608676,0.04629883,0.060704127,0.024371225,-0.011061959,-0.015099712,-0.010816502,-0.017795812,-0.010796587,0.0031062667,-0.07832617,0.012527209,0.024024665,0.01708304,-0.047801558,0.02254464,-0.054466598,-0.017585142,0.06052593,0.038828522,-0.021076523,0.020145593,0.00088780676,0.073397234,-0.030535577,-0.034056857,0.0501294,0.02753804,0.023567218,-0.0020208408,0.0011185159,-0.0014331894,0.006199379,-0.04925243,-0.057127085,-0.006951693,-0.02559039,0.029942034,-0.06724623,0.016451826,0.022778321,-0.040322807,-0.011752472,0.05548748,-0.02609687,-0.010098616,0.01473522,-0.003021503,-0.010971962,-0.03251159,0.018329604,-0.019910073,0.050906844,0.02915407,0.012919378,0.03742168,0.04074357,0.035108313,0.03788422,-0.058527786,-0.003587678,0.036322728,-0.03915221,-0.0025120343,0.025494006,0.016178897,0.030877309,-0.034407906,-0.027822256,0.070199795,-0.020987317,-0.008941216,-0.017542819,-0.017786937,-0.00034194137,-0.017287336,0.011281965,0.01680935,0.036102608,-0.05966669,0.0028927424,-0.009155907,-0.016905636,-0.033593617,0.020618694,0.014875272,-0.036831234,0.013965608,0.023598019,0.046869926,0.035625808,0.044113986,-0.0019107788,0.046594765,0.02493022,0.043901276,0.011278052,-0.031540506,-0.055668462,0.02438042,0.03353983,-0.03931821,-0.004192374,0.055976506,-0.05303431,0.07420749,0.013302272,-0.06159429,-0.031951383,-0.06451855,-0.030526761,-0.035998903,0.02180318,-0.014354009,-0.069855064,-0.0103535345,0.021491062,0.015313168,0.048771504,-0.02825133,-0.006987495,0.008078949,0.045055926,0.08410377,-0.04332498,0.00785132,0.036637962,-0.01735225,0.025952416,-0.030176291,0.042153813,-0.012554282,-0.038307384,0.00024950318,0.0017332189,-0.02338414,-0.009583614,0.007210044,0.012819548,0.007928341,0.024323473,-0.003952893,0.03896294,-0.021061517,-0.030015929,0.02802372,-0.02301355,0.0029614663,-0.022157421,-0.033651475,0.015213446,0.0073844125,-0.033287834,0.023725025,0.024194954,0.008281973,0.023280062,-0.011640798,0.06384297,-0.024507292,-0.026978657,-0.037398815,0.021379074,-0.023671255,0.0006041242,-0.02624875,-0.04365437,0.0038614613,0.057421986,-0.04584135,-0.04227069,0.019509733,-0.032693457,-0.04231335,-0.0040156306,0.013039325,-0.03064003,-0.005211374,-0.016340578,-0.0013153533,-0.010474403,-0.004084031,0.03373249,0.004571804,-0.02669523,0.024611048,0.04595523,-0.056623563,-0.03358348,-0.039315704,-0.0071486495,0.047108714,0.013707143,-0.03934948,0.01448799,-0.084863074,0.025271246,0.017434072,0.068521276,-0.008244465,-0.0187822,0.038888115,0.055895768,-0.0125620365,-0.00048683808,0.048764326,-0.016220715,-0.0044075004,-0.056384597,0.09458321,-0.016896902,0.0152408285,-0.023425348,-0.056383107,0.032739133,0.026152952,-0.006562463,-0.012842724,-0.024961129,-0.004070749,-0.038327962,0.06220599,-0.044970393,-0.013412135,0.020033354,-0.0069005964,-0.013337609,0.029153787,-0.047646753,0.019812047,-0.0001390654,-0.047684923,0.023781387,-0.017004658,-0.027630182,0.015855059,-0.034186233,-0.026470577,0.005211804,-0.08072403,-0.013456633,0.018067885,-0.0071087447,0.026144382,-0.03290772,-0.013712663,-0.006903945,-0.029303752,0.009563183,-0.008407628,-0.018710941,0.055027366,-0.0013829202,-0.031764705,-0.024135945,-0.031683847,-0.016203579,-0.014539737,-0.05796658,-0.050516985,-0.0059208646,-0.0029123249,0.03932553,0.038286693,-0.0021846467,0.022405168,0.0031777385,0.007977428,0.014614285,0.04452212,-0.008319137,0.05548951,0.039516605,-0.03690525,0.0011748404,0.012697741,0.034319934,-0.0025424603,0.024473505,0.0026858635,0.05422958,-0.010611573,-0.0823168,-0.0261555,-0.003925869,0.07605983,-0.00947983,-0.012296478,-0.0013502461,0.027165877,-0.00031045105,-0.029882813,-0.03714691,-0.029393766,-0.03335361,0.005881896,0.031850442,-0.024452154,-0.021440297,-0.042273566,-0.015379093,0.028968511,0.06931655,0.0029500069,-0.03631054,-0.048053343,-0.06103799,-0.0135568045,-0.0064816205,-0.01743659,0.09154056,0.02776453,0.0060090227,-0.032990433,-0.020694306,0.028655179,-0.0064752465,0.05885838,-0.012465664,0.0752873,-0.03356958,0.006642927,0.031057032,-0.027368339]	2026-01-20 16:05:28.999178+05	ЖК Atlant Unique. Адрес: г. Астана, ул. Д. Конаева, 3
a07586c8-dce2-4e28-bc34-4ad15c3d3414	f4f8eed8-6269-4a41-972c-137d028411ee	Capital Park. Emotions	г. Астана, ул. Бухар Жырау, 33	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.09781	71.44575	Комфорт+		\N	https://bi.group/ru/landing/capitalpark-emotions	https://s3.bi.group/biclick/f4f8eed8-6269-4a41-972c-137d028411ee/f4f8eed8-6269-4a41-972c-137d028411ee_foto_400.jpg	{"side": "Right", "tags": ["парк рядом", "школа рядом", "детский сад рядом", "университет рядом", "колледж рядом", "супермаркет рядом", "ТЦ рядом", "рынок рядом", "аптека рядом", "поликлиника рядом", "больница рядом", "остановки общественного транспорта", "рестораны и кафе", "спортивные объекты", "фитнес-центры", "мечеть рядом", "культурные объекты", "зеленая зона", "развитая инфраструктура", "удобная транспортная развязка", "доступные цены на продукты", "детские площадки", "спортивные площадки", "пешеходные зоны", "банки рядом", "почта рядом", "салоны красоты", "бизнес-центры", "спокойный район", "безопасный район", "хорошая экология", "близость к набережной", "детские развивающие центры"], "atmosphere": ["семейный", "зеленый", "спокойный", "уютный", "развитый", "умеренно шумный", "хорошие дороги", "чистые улицы", "много зелени", "близость к старому центру", "удобный для жизни", "ветреный"], "district_name": "Алматинский"}	[-0.031247076,0.011266604,-0.00883389,-0.030682566,-0.0257898,-0.012734657,0.02357403,-0.006060248,0.027474724,0.021131061,0.0004559996,0.044127762,0.012919541,-0.019370267,0.034337137,-0.008001425,0.031978197,0.027735997,-0.14167042,-0.017690493,0.045820076,-0.0049449084,0.06421331,-0.037493635,-0.045501478,-0.05424469,-0.05169402,0.024249956,0.0062087732,-0.018899716,0.04125815,0.028423259,0.021642324,-0.0139329415,0.01749265,0.016409814,-0.0070819193,-0.048977613,0.026191952,-0.044145275,-0.07955889,0.038032696,0.032476313,0.006236004,-0.08846268,-0.06561391,-0.045760803,0.036758833,-0.0698416,0.02114833,0.0050530653,-0.044353813,-0.03331721,0.05832849,-0.067012675,-0.0054614935,-0.02106881,-0.022678457,0.06264545,0.022482282,0.0048573045,-0.021495499,0.0059845597,-0.022893036,0.020820811,-0.014795123,-0.04643084,-0.017070938,-0.06577522,0.012556055,-0.03501135,0.09828423,-0.024591235,0.012902098,-0.010607317,-0.018875796,0.0053972392,-0.006661829,0.06290516,0.04356643,-0.042986244,-0.028088436,0.035656977,0.04172482,0.0045569222,0.008456803,0.004098944,-0.041566215,-0.07835112,-0.027859464,0.046737973,0.03639338,0.029154409,0.01347435,0.071907565,0.02713913,-0.09568572,-0.06794824,0.07491193,0.021176472,0.018966964,0.012998589,-0.030141674,-0.07195615,-0.0009552228,0.07898845,-0.051017262,-0.0928895,-0.06801524,0.04052573,0.016285473,-0.023237074,0.043922197,0.016365748,0.034087084,0.05190517,-0.086149976,0.06868724,0.03544444,0.012693991,0.004523837,-0.0015825061,-0.030510359,0.063253745,0.02092672,0.0061489865,0.010793485,-0.033244535,-0.012290191,-0.029420074,0.026242547,-0.026595486,0.0073910095,-0.009157702,-0.020797543,-0.0037073956,0.054300133,-0.012132768,0.014435497,-0.009427577,0.017162163,-0.053855836,-0.035324953,-0.029174821,-0.022527965,0.0012182437,0.019117687,0.061068974,-0.048693668,0.020923786,-0.030026002,-0.03344642,0.029425224,-0.0051619792,0.019745253,0.016595159,0.07459934,-0.053725295,-0.0040484085,-0.039118804,0.038622323,-0.049506605,-0.04158226,0.031414066,-0.015843926,-0.01723516,0.010538578,-0.009195661,-0.03269247,-0.020554457,-0.044078965,-0.06775054,-0.03844139,-0.08448551,-0.0068307295,0.0034319954,-0.015160058,0.022597212,-0.03586828,0.02407653,0.0780333,-0.028680203,-0.012192348,-0.08276281,-0.02229616,0.03305217,-0.015795019,0.044604562,0.049913965,-0.0035600197,0.01155956,0.01649976,0.023873141,0.054132555,-0.034417197,0.0018513617,0.051010195,-0.081640914,-0.011856759,-0.042429138,0.029993696,-0.027109476,-0.025625665,-0.031383928,-0.030779414,0.028568963,-0.028588876,-0.08893661,-0.063962735,0.0064819455,-0.018745197,-0.004010552,-0.023968538,-0.10166175,0.020681385,0.00295573,0.0016427686,-0.056103505,0.0683695,-0.089996494,0.0073681045,0.019407963,0.07204699,-0.0005503526,0.04165099,-0.013905191,-0.01509579,-0.020370655,-0.013464591,-0.041218914,-0.046425678,-0.00400812,0.0028972826,0.051849935,-0.0067560063,0.03938841,-0.002064644,-0.0042412505,-0.02629075,-0.02068939,-0.00961489,0.03484391,0.012751733,-0.020323405,0.008906931,-0.0142199,0.046825446,0.045416508,0.03796625,-0.006574299,-0.04061079,-0.0086175,-0.015626462,-0.031412743,-0.046087302,-0.058270346,0.036001474,0.0118685495,-0.02289494,-0.020605896,-0.004305736,-0.026611349,0.004234912,-0.049115755,-0.054405175,-0.016638838,-0.00011050784,-0.004297805,0.055630762,-0.028038504,0.061141275,-0.049628276,-0.037088092,-0.008114499,-0.009040178,0.06970301,0.0017181383,0.03710252,-0.032642834,-0.030001258,0.059447892,0.015478863,-0.05950866,0.026913395,0.0123155005,-0.06410252,-0.015966566,0.011763837,-0.03765211,-0.014482791,0.024853546,0.06825316,0.009096139,-0.0020979138,0.00511581,-0.046009794,0.02709957,0.03862819,0.0017885411,-0.048308976,-0.0060682916,0.030684642,-0.04453134,0.041215982,0.014735867,-0.036350545,0.014496486,-0.0015928053,-0.017867079,0.04207773,0.02657701,0.056554105,-0.042808387,-0.051319007,-0.049602788,-0.017125946,-0.13829608,-0.05991993,0.01985446,0.003323609,0.04345856,0.09018292,-0.0074952724,-0.00039619752,0.052824564,0.006297689,-0.0050962297,-0.04151864,0.06029083,-0.05876536,-0.00664319,-0.024755038,-0.0065215686,-0.04051804,-0.009833211,0.039416708,-0.05750591,0.018251663,0.036033828,0.025495017,0.03395056,0.02186454,-0.0140780965,0.021945396,0.0060477867,-0.022326598,-0.023545047,0.027770683,0.03175822,-0.006067916,0.03601694,0.010650862,-0.02458095,-0.058880046,0.033960935,-0.012015828,0.020515144,-0.009779384,-0.0026389724,-0.06844861,-0.015237123,-0.01466693,0.014851268,0.030883139,0.0007397097,0.026690165,-0.010670949,0.042587694,-0.06661302,0.00080893387,0.01917249,0.029645178,0.0020396751,0.0062694345,-0.007978613,-0.00029351714,-0.054507628,0.037467327,0.03483299,-0.014094662,-0.020305475,0.017007705,-0.013551738,0.020467822,-0.00084368984,0.047908425,-0.04750001,0.0049171513,-0.010359517,-0.0007580229,-0.03819152,0.026762063,0.029603984,0.045411818,0.0030489452,0.039150786,0.020222997,0.06085692,0.021014757,-6.313046e-05,0.011812169,-0.04589167,0.07691204,-0.010729962,0.0037091803,-0.018284885,0.059873134,-0.012681376,-0.015251255,-0.0058049466,-0.0082272915,-0.037645992,-0.042216327,0.018404126,-0.04512818,-0.020563139,-0.032856487,-0.02996346,0.001122978,-0.021309108,-0.008057129,0.026350718,0.03322479,-0.005974416,-0.011748002,-0.06314271,0.030542834,-0.0053758146,0.008359372,0.0060273646,0.01865256,0.05581633,-0.008157786,0.032886665,0.029610407,0.08651183,-0.010597978,-0.050040275,-0.0027039873,0.037369475,-0.020512931,-0.010198326,0.00054716604,-0.003559037,0.0038419478,0.059275568,0.024550958,0.023221917,-0.010914132,-0.012872591,-0.033913486,-0.0009404206,0.0029653793,0.016388984,-0.04370871,0.0056164153,0.01527567,-0.0023630864,-0.052266937,0.026995398,-0.045390204,-0.022718558,0.05018759,0.039023172,-0.013284907,0.006119814,0.0084371,0.05053004,-0.040048007,-0.0061795046,0.038032565,-0.010333638,0.038220935,0.0004964643,0.0024815106,-0.029367918,0.021110397,-0.004343709,-0.066233106,-0.029681306,-0.0041849213,0.02678128,-0.06826882,-0.0060474034,0.036472254,-0.046143163,-0.0021429807,0.05185795,-0.017540216,-0.047674574,0.008475434,0.011787447,0.0019040223,-0.037729003,-0.002425199,-0.022908336,0.02605079,0.034215547,0.009361698,0.013070244,0.04299611,0.03910843,0.051777024,-0.06944904,0.01848482,0.024086263,-0.07195375,-0.029442636,0.024736824,0.01969702,0.022535589,0.001099619,-0.033334784,0.05351186,-0.020563737,0.0032199079,-0.005658074,0.015272917,-0.014566842,-0.021647256,-0.019672722,-0.019364795,0.028261011,-0.048138894,0.013219398,-0.0034456977,-0.014341045,-0.04538086,0.05029819,0.0066068936,-0.03136481,0.027310766,0.04441647,0.044450752,0.013054354,0.046746142,0.0009937383,0.029589543,-0.00039825047,0.036802743,0.02681628,0.0032788692,-0.036855474,0.027498856,0.044737402,-0.024077442,-0.001731815,0.06487034,-0.016288115,0.06875222,0.012798952,-0.06797003,-0.030103842,-0.045944512,-0.009973795,-0.012649243,0.018928364,0.010853459,-0.067010224,0.004431574,-0.0031887211,-0.0130635705,0.06866882,-0.015568362,0.008653861,0.03328117,0.0296118,0.048290152,-0.021525448,1.884034e-05,0.007955305,0.012304727,0.0321344,-0.049058616,0.05479243,-0.02855386,-0.06812201,-0.021656167,-0.018990554,-0.02318585,-0.020802569,0.032902364,0.041649476,-0.009223924,0.016658798,0.016680798,0.024362832,-0.02290447,-0.022584308,0.02861358,-0.011911938,0.034041088,-0.014122674,-0.0742327,0.03699387,-0.020247601,-0.014072507,0.02692239,0.04175247,0.0032654733,0.021781849,-0.002499988,0.040801905,-0.023423823,-0.036538377,-0.07558819,0.05131734,-0.036775257,-0.029706422,-0.021581443,-0.015552831,-0.012499597,0.036198925,-0.030918356,-0.049355324,-0.01114582,-0.023210112,-0.03407121,0.0029957106,0.026761837,-0.035898376,0.0012606402,-0.0055639395,-0.015710788,-0.052311324,-0.0020419117,0.009150047,0.029521415,-0.010052141,0.015043246,0.0200361,-0.05090085,0.019289466,-0.024113804,-0.0070371553,0.045580566,0.014340859,-0.036307193,0.028483484,-0.055177916,0.005543152,-0.0049715987,0.05134041,-0.026240274,-0.03629524,0.08287535,0.026496094,-0.025864648,0.023071239,0.06364206,0.012748743,0.030954257,-0.054711554,0.0752838,-0.017503785,0.036942597,-0.02549487,-0.038687885,0.05253337,0.045670863,-0.007658728,0.0013513532,0.0037750034,0.011727674,-0.056741428,0.067842714,-0.038492594,-0.00042925766,0.024219267,-0.03165531,-0.03629835,0.017543916,-0.06970888,0.023696946,0.013748208,-0.019926045,0.024974845,0.0035430996,-0.027379684,-0.007991564,-0.022404138,-0.005735108,0.025114954,-0.08027211,-0.014409896,0.005106078,0.04599096,0.059403483,-0.032586712,-0.019917963,-0.0046685846,-0.023277964,0.0059801587,0.052852105,-0.007889143,0.052858803,-0.02114829,0.0059696278,-0.017732855,-0.027230447,0.0055802604,0.005331947,-0.07311537,-0.080914624,0.020150395,-0.013044808,0.036221042,0.01738719,-0.016074609,-0.0016160063,-0.013589316,-0.017262923,0.023808412,0.024000004,-0.02557223,0.0477985,0.04272024,-0.031419303,0.01912617,-0.023172893,0.014591832,-0.017201897,0.031429987,0.01343581,0.06657607,0.0014769498,-0.09507969,-0.01794194,-0.009980281,0.05419586,-0.0067293476,-0.0042978874,-0.00058988447,0.035316598,-0.0042970944,-0.03484786,-0.034893017,-0.040075924,-0.029598368,0.017614814,0.05377364,0.01429454,-0.03740685,-0.024921877,0.005317984,-0.002948616,0.022496173,0.008990248,-0.01820336,-0.04467647,-0.05220362,-0.014069242,0.0026705055,-0.04915383,0.123433724,0.02031295,0.00063787034,-0.040519327,0.018860977,0.020949002,-0.013482019,0.031462412,0.0037930417,0.050460998,-0.01998775,-0.014548936,0.043284386,-0.01810548]	2026-01-20 16:05:57.764002+05	ЖК Capital Park. Emotions. Адрес: г. Астана, ул. Бухар Жырау, 33
a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef	5fb755c4-c9b9-48ec-b5ec-e263a552fb7d	Auez	г. Астана, пересечение улиц Ш.Калдаякова, С.Нурмагамбетова, Райымбек батыра	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.11354	71.48204	Комфорт+		\N	https://bi.group/ru/landing/auez	https://s3.bi.group/biclick/5fb755c4-c9b9-48ec-b5ec-e263a552fb7d/5fb755c4-c9b9-48ec-b5ec-e263a552fb7d_foto_400.jpg	{"side": "Right", "tags": ["мечеть Хазрет Султан", "Национальный музей", "Дворец Мира и Согласия", "Пирамида", "Дворец Независимости", "Университет искусств Шабыт", "Аллея Мыңжылдық", "школа-лицей №72", "школа-лицей №73", "вокзал Нурлы Жол", "парк", "сквер", "супермаркеты", "аптеки", "кафе", "рестораны", "детские сады", "медицинские центры", "остановки общественного транспорта", "новый центр", "правый берег", "культурный центр", "развитый район", "продуктовые магазины", "салоны красоты", "фитнес центры", "кофейни", "банкоматы", "детские площадки", "спортивные площадки", "удобная транспортная развязка"], "atmosphere": ["деловой", "перспективный", "современный", "просторный", "ветреный", "культурный", "широкие дороги", "красивый вид", "новые постройки", "развивающаяся инфраструктура", "близость к достопримечательностям", "урбанистический", "динамичный", "чистые улицы", "хорошее освещение"], "district_name": "Алматинский"}	[-0.027279057,0.0113808485,-0.00025186583,-0.015782673,-0.014723848,-0.0285583,0.0045501343,-0.0073894714,0.0006255761,0.04660934,0.014518424,0.043829337,0.022011418,-0.017869197,0.036343943,0.005334862,0.016441062,0.029058076,-0.14142622,-0.0052973405,0.043787125,-0.015670178,0.0673461,-0.0377994,-0.046466105,-0.045456097,-0.027264876,0.031225735,0.013633777,-0.008958227,0.040047966,0.04946542,0.0016026465,-0.0152199855,0.03238196,0.015136166,0.0076514995,-0.042047035,0.008782543,-0.036608703,-0.067441456,0.054401807,0.027167056,0.0056015975,-0.07303471,-0.06721606,-0.06251014,0.018401641,-0.04620971,0.017419565,-0.0107711395,-0.035701986,-0.03080355,0.06082001,-0.08148405,0.008160761,-0.012610661,-0.0033279003,0.083653286,0.011458399,0.007148041,-0.004538813,-0.0055966326,-0.035928566,-0.0018296852,-0.013115744,-0.05758391,-0.0057256273,-0.0528617,0.008457219,-0.037015915,0.04964982,-0.019211398,0.024160212,-0.0026204882,-0.023225367,0.015224915,0.0019450743,0.045145657,0.031554334,-0.03562079,-0.016374549,0.016938027,0.03364559,0.031664133,-0.0039409255,0.003656253,-0.02823956,-0.08210519,-0.029349249,0.04792102,0.025700757,0.056060918,0.034883156,0.07047148,0.040141575,-0.11308241,-0.11402483,0.052022982,0.018485725,0.012102909,0.025728554,-0.055889916,-0.10261136,0.028932322,0.05804431,-0.04824676,-0.06600783,-0.078049704,0.023571508,-0.0040478995,0.018233422,0.053699907,0.011537918,0.028030653,0.03426201,-0.059242696,0.041083746,0.018419573,0.044131648,0.049589954,-0.0065398607,-0.018294033,0.052619793,0.00094593235,-0.014384476,0.027140647,-0.04226248,-0.02326282,-0.005285777,0.051491633,-0.028877262,-0.0026025022,0.0045945565,-0.013021103,-0.014501547,0.047945585,-0.06434931,0.004034124,0.0047756005,0.012111891,-0.03150229,-0.06944614,-0.026309675,-0.02331997,-0.01182392,-0.0021292698,0.07342716,-0.042747524,0.0051629366,-0.04036905,-0.030394068,0.0506119,0.0230264,0.0027988595,0.0059210304,0.07866323,-0.062101312,0.014825342,-0.02905272,0.053673543,-0.05286871,-0.044820566,0.023250507,0.0015472019,-0.0024940562,0.0294486,-0.031934,-0.022127926,-0.0124217,-0.038171645,-0.07787371,-0.013314946,-0.06584846,-0.021719472,-0.0036512595,-0.0067997673,0.014751714,-0.0049663363,0.0012727064,0.12305553,-0.0143163605,-0.017793786,-0.08881958,-0.02246112,-0.0062957346,-0.023994967,0.055739447,0.04448066,-0.0030490675,0.0130295865,0.0052897823,0.0050419997,0.036047712,-0.051753152,-0.02300462,0.047790524,-0.06648417,-0.0038412136,-0.06890356,0.04805036,-0.050217412,-0.023510631,-0.01722073,-0.010595543,0.036995195,-0.044075612,-0.060430773,-0.032183282,0.0067999335,-0.034350477,-0.027541757,-0.00884434,-0.07122441,0.02031951,0.004962787,0.010387836,-0.034509823,0.07797577,-0.08438758,0.0047811647,0.006425986,0.05023566,0.004982347,0.058261544,0.020231403,0.01566464,0.009053682,-0.010028788,-0.05627964,-0.021958925,0.0013605619,0.0024484384,0.056494776,-0.034181062,0.020285772,-0.0059453323,-0.030047229,-0.016119469,-0.005347806,-0.024114663,0.019542782,0.038508747,-0.030890558,0.012957725,-0.017031,0.06012882,0.04019374,0.03482036,0.016370883,-0.045220654,-0.02215238,-0.006789925,0.003777797,-0.052670456,-0.055581633,0.019592095,0.013124862,-0.00566259,-0.017474683,-0.0075787785,-0.021184767,0.008151935,-0.05572462,-0.060596976,-0.014065352,-0.007754808,0.0013060207,0.05374659,-0.04213171,0.068843246,-0.05496087,-0.051277258,-0.0013127768,-0.020101702,0.055262446,-0.012269675,0.033711515,-0.01471539,-0.019478329,0.03356226,-0.0014774048,-0.05126739,0.011034965,5.133759e-06,-0.05671364,-0.007700752,0.02245305,-0.04280542,-0.039061096,0.03482899,0.054238863,0.030271707,0.009005279,0.0061295433,-0.045069046,0.031867076,0.050856285,-0.012956404,-0.056913625,0.011334159,0.0329645,-0.038971767,0.04097109,-0.019202791,-0.03667654,-0.0055043027,0.013260218,-0.028102623,-0.00070073147,0.035688683,0.05082235,-0.058129378,-0.029996755,-0.05499924,-0.022142224,-0.14391933,-0.06199501,0.0038049112,0.0085948,0.0039684465,0.08349668,-0.022378713,-0.01232631,0.058256585,-0.017710255,-0.015762486,-0.062178656,0.06843423,-0.053599328,-0.0043474124,-0.008404255,-0.029159779,-0.07057027,-0.020014748,0.015959542,-0.084931515,0.023540879,0.065007836,0.03796333,0.05373235,0.046926305,0.008106893,0.024212983,-0.0152098145,0.00016319424,0.0024608395,0.015549878,0.013028212,0.005614401,0.014253345,0.0083955005,-0.020168446,-0.058386665,0.016608698,-0.023217695,0.028497515,-0.007535481,-0.003735239,-0.07106704,-0.036110554,0.010136946,-0.0042571323,0.03291271,0.014418429,0.029642379,-0.019628784,0.040179297,-0.05238788,-0.019366821,0.01602683,0.022296516,0.007956101,-0.009610192,-0.015656555,-0.013219333,-0.06150146,0.025745975,0.031489678,-0.009638918,-0.025470559,-0.00536924,-0.019704102,0.03335759,0.0062730457,0.06378938,-0.021957181,-0.013336468,-0.028446574,-0.0039255605,-0.034341313,0.0031748933,0.016210519,0.024597926,0.013455258,0.017359542,0.03251083,0.0651473,0.032712374,0.014969922,0.019039746,-0.043939687,0.07101158,-0.029736195,-0.019947054,-0.0007368034,0.064056516,-0.0054708947,-0.025543345,0.0009989769,-0.036978986,-0.042531226,-0.04613786,0.012613534,-0.02639418,-0.03421676,-0.024446951,-0.020860752,-0.022243569,-0.038264275,-0.012502994,0.029765425,0.018511608,-0.009144527,-0.002573107,-0.07578896,0.013128333,-0.002040577,0.005763938,0.0205906,0.048894078,0.04354056,0.008690707,0.023885734,0.037739027,0.070824735,-0.0141757,-0.050243597,-0.025017286,0.03040914,-0.008248634,0.01816196,0.023770977,0.0036953515,0.010904848,0.061536305,0.0410328,0.013749846,-0.03138838,-0.0093650315,-0.017739339,-0.019628963,-0.020476652,0.020354083,-0.06837614,-0.00077717414,0.035517845,-0.0009433936,-0.046062022,0.02054249,-0.06783884,-0.0343651,0.045780696,0.020980649,-0.027180636,0.0069197365,0.0050163195,0.0422225,-0.013488671,-0.011018315,0.036675807,-0.0034108504,0.037480276,0.011242696,0.0043652877,0.015032523,0.03274916,-0.015166257,-0.04764816,-0.0405515,-0.0031237698,0.025027217,-0.05305991,0.010396682,0.034681026,-0.059310365,-0.020165013,0.049050152,-0.034412727,-0.02514329,0.031831555,0.013206022,-0.013114796,-0.038959492,0.010083478,-0.03254073,0.03869922,0.051431052,0.0013473452,0.012620075,0.020912929,0.039775588,0.04171888,-0.05596344,0.016965419,0.057364088,-0.07191538,-0.023182536,0.012042083,0.03484591,0.006479363,-0.008414018,-0.030697992,0.06588019,-0.009741908,0.011629441,-0.037480123,0.011719412,0.0016454419,-0.027696516,-0.021801613,-0.009362497,0.024567556,-0.03812148,-0.0030809315,-0.03378239,-0.008134435,-0.02629124,0.029804174,0.019115059,-0.013183018,0.016730586,0.046873305,0.05769069,0.026535802,0.052564237,5.8754402e-05,0.04032714,0.03140949,0.029462112,0.0052902787,0.0006828504,-0.04950926,0.029707095,0.02972002,-0.032278273,0.006773177,0.07142521,-0.02786543,0.058442596,0.023249574,-0.05183734,-0.031217074,-0.04248077,-0.008434586,-0.022282742,0.033094414,-0.00036596693,-0.06981244,0.005404634,0.004611608,-0.024544826,0.035450727,-0.03571254,-0.010289151,0.026543446,0.01614169,0.07178597,-0.018421892,-0.0036781752,0.024080614,0.003466981,0.03499267,-0.054843105,0.028661879,-0.023335533,-0.06663751,-0.019303625,-0.00049210625,-0.005279849,-0.04073487,0.004800384,0.008981093,0.0037065556,0.011213385,5.2370116e-05,0.041656286,-0.02239952,-0.024939926,0.017747587,-0.032668434,0.0490252,-0.0024028977,-0.06354536,0.021991968,0.008072502,-0.008104625,0.03834325,0.029630339,0.0026650876,0.026916247,-0.003344591,0.04973973,-0.009327108,-0.025218789,-0.05618936,0.03366031,-0.034511454,-0.03866341,-0.036401264,-0.033231508,-0.018128144,0.03360756,-0.053083908,-0.08181053,0.00034306856,-0.0154198725,-0.028815746,-0.011253105,0.02237308,-0.023209954,0.012535973,-0.015161195,0.023226608,-0.026948672,-0.017235097,0.020213652,0.018516796,-0.024468476,0.0020604136,0.0149962045,-0.046909697,-0.003641139,-0.036628865,-0.015185293,0.043275453,0.012278966,-0.053447705,0.038415592,-0.059004813,0.024616022,-0.005713308,0.057223924,-0.02637196,-0.04655444,0.047228426,0.033087965,-0.026060501,0.0071023884,0.06415068,0.010272241,0.018485457,-0.032996666,0.07814418,0.0024113543,0.008104273,-0.01924657,-0.0227161,0.055908665,0.017409379,-0.025360031,-0.0031446856,0.009154413,0.022603171,-0.074812725,0.02998142,-0.021380762,-0.013110514,0.037361957,-0.009978972,-0.02633113,0.018596094,-0.04329999,0.026408354,-0.0027085857,-0.02430607,0.027508352,-0.019361604,-0.04145321,0.028024558,-0.022501756,-0.015536707,0.02287961,-0.063137434,-0.0026488705,0.005306568,0.024246773,0.045840513,-0.03060669,-0.018224824,0.005110124,-0.048810467,-0.00632778,0.010886202,-0.0017425519,0.044785425,0.010747022,-0.0082325665,-0.064261444,-0.019320313,-0.023379652,0.0062218336,-0.083538,-0.07423088,0.004286877,-0.0114923855,0.040803075,0.02880101,0.013587521,-0.0015013677,0.004819649,0.0054531815,0.035626262,0.050523065,0.0013194553,0.03442565,0.025545817,-0.015791895,0.0076224464,-0.012526281,0.009911218,0.0023663451,0.02291201,0.04425877,0.048847985,0.006333581,-0.08321156,-0.013054162,0.0043716426,0.06098161,0.009298385,0.003247813,-0.014239686,0.033158522,0.0098445285,-0.029056735,-0.017669236,0.004909189,-0.04704183,0.02057834,0.05456238,0.005625208,-0.029487373,-0.004062261,-0.0027317817,0.004820891,0.011695269,0.012000888,-0.0423819,-0.047203645,-0.062563896,-0.024376346,-0.0077318586,-0.029365515,0.12349114,0.016808337,0.00380228,-0.046214797,-0.004480611,0.012887876,0.00321553,0.025470704,0.0031070802,0.068569705,-0.039878916,-0.015179024,0.032502174,-0.017198218]	2026-01-20 16:05:30.426228+05	ЖК Auez. Адрес: г. Астана, пересечение улиц Ш.Калдаякова, С.Нурмагамбетова, Райымбек батыра
8be56884-79ce-4504-8ba2-5c2f1189b939	1a8988ee-b3b6-11ef-a830-001dd8b72708	Jetisu Kerbez Comfort	г. Астана, вдоль проспекта Улы Дала	4c0fe725-4b6f-11e8-80cf-bb580b2abfef	51.0864	71.46416	Комфорт+		\N	https://bi.group/ru/landing/kerbez-comfort	https://s3.bi.group/biclick/1a8988ee-b3b6-11ef-a830-001dd8b72708/1a8988ee-b3b6-11ef-a830-001dd8b72708_foto_400.jpg	{"side": "Left", "tags": ["экспо рядом", "ботанический сад рядом", "парк рядом", "школа рядом", "детский сад рядом", "супермаркет рядом", "аптека рядом", "ТЦ Mega Silk Way рядом", "Назарбаев Университет рядом", "BINOM школа рядом", "Haileybury Astana рядом", "QSI International School рядом", "конгресс-центр рядом", "библиотека первого президента рядом", "кафе рядом", "рестораны рядом", "фитнес-центр рядом", "салон красоты рядом", "банки рядом", "остановки общественного транспорта", "велодорожки", "спортивные площадки", "детские площадки", "новые дома", "современный ЖК", "комфорт-класс", "левый берег", "новые дороги", "благоустроенный двор", "удобный выезд на магистрали", "чистый район", "развитая транспортная сеть", "поликлиника рядом", "автобусные маршруты", "зона отдыха", "пешеходные зоны"], "atmosphere": ["семейный", "зеленый", "тихий", "современный", "развивающийся", "ветреный", "широкие дороги", "чистый воздух", "красивый вид", "развитая инфраструктура", "новые застройки", "чистые улицы", "хорошие дороги", "много зелени", "удобная транспортная развязка"], "district_name": "Есильский"}	[-0.015366204,0.017200422,-0.010752304,-0.0223002,0.004349055,-0.010377983,-0.005130125,0.0006210977,-0.013276761,0.038157295,-0.0111553995,0.037654534,0.061059166,-0.037722252,-0.006005671,-0.0005522783,0.05117332,0.016600862,-0.112341516,-0.03731655,-0.006119138,-0.011826957,0.05228742,-0.011001502,-0.065663084,-0.032115325,-0.045205265,0.031232223,-0.0055450653,-0.03218519,0.0319696,0.049623184,-0.03639429,0.007906386,0.017015707,0.03646175,-0.036717575,-0.037669778,0.05869325,-0.030105937,-0.0649614,0.017000197,0.007967258,0.022294115,-0.06394016,-0.079560384,-0.038904455,0.030679245,-0.03789613,0.0034650273,-0.009498141,-0.05917731,-0.043213382,0.048717033,-0.094093695,0.008194973,-0.0229192,-0.01630668,0.06379876,0.0029423577,0.010461177,0.008863734,0.0073546553,-0.022443859,0.034712665,-0.000430384,-0.072050504,0.018890282,-0.068020485,0.010847999,0.0054030204,0.09946479,-0.014815467,0.040472463,0.0068721375,-0.005120935,-0.00891064,0.0030420048,0.03183753,0.043664627,-0.055566546,0.0030053852,0.034597404,0.038083203,0.0061658337,-0.010925449,0.0029881417,-0.020727102,-0.07986544,0.0024042903,0.056904364,0.04123414,0.03431956,0.027360966,0.08179457,0.024048282,-0.11214718,-0.10484505,0.052999213,0.034144714,0.051129457,0.034723017,-0.031570796,-0.09452964,0.021208102,0.080912866,-0.070746385,-0.038175393,-0.05305966,0.023168895,0.008658218,0.012256656,0.048406478,-0.0055920957,0.009821351,0.027475089,-0.069976605,0.042505108,-0.0022196122,0.038977396,0.0051686447,0.022696557,-0.006023847,0.050099794,-0.006889471,0.005629036,0.019536942,-0.039142393,-0.027300382,-0.026727809,0.043954875,-0.030648852,-0.0011112578,0.0067986357,-0.025360007,0.0012717826,0.06100761,-0.011159714,0.00023142889,-0.021701192,0.0470037,-0.007624633,-0.06121067,-0.04026549,-0.014167646,-0.02711625,0.034341846,0.043291274,-0.047357924,0.017949509,-0.07430661,-0.049050678,-0.009883724,0.008672763,0.032073732,-0.0186568,0.061468527,-0.051008847,-0.008625643,-0.033430208,0.06781766,-0.03263562,-0.051872313,0.029442053,0.0017738871,-0.027461752,-0.0024263726,-0.009104065,-0.038638394,0.010291585,-0.036616996,-0.07193438,-0.01291965,-0.05545311,-0.016564485,0.010016613,-0.053219005,-0.0049836207,-0.010712184,0.013707576,0.10233886,-0.0030286333,-0.016635716,-0.06646747,0.0055434857,-0.0013556628,-0.024236225,0.03801117,0.03249012,0.0039746296,-0.005249817,0.013576777,0.011215823,0.04908617,-0.053980343,-0.04013782,0.026654199,-0.06998834,0.02936181,-0.042570677,0.044580463,-0.020805135,0.0035726186,-0.04764378,-0.03007711,0.031752154,-0.04722211,-0.0719342,-0.027346559,0.030384975,0.00037099762,-0.007024611,-0.03871414,-0.07526797,0.037776474,0.014247563,0.013956198,-0.034767613,0.08249303,-0.07598601,0.0019956662,-0.011111899,0.06457954,0.055624865,0.034030877,-0.02383608,0.009687393,-0.021662997,-0.020860346,-0.03821042,-0.017963126,-0.0144549925,-0.027044885,0.049602292,-0.018618427,0.03168546,0.017809024,-0.05730936,-0.033765264,-0.0045482493,-0.013767948,0.028550884,0.05930425,-0.04094458,-0.0030300089,0.025408661,0.061348416,0.047158275,0.033920653,0.04066936,-0.065952495,0.0009853983,-0.002114433,-0.013604823,-0.048582792,-0.03281795,0.03547786,0.020126963,-0.004993619,-0.021178963,-0.00019046802,-0.011428265,0.008238403,-0.056756925,-0.06774135,-0.04118578,-0.029002145,0.024296978,0.037883274,-0.054396234,0.06734611,-0.044895176,-0.028053254,-0.016425835,-0.017945036,0.07287204,-0.051513642,0.049627326,-0.007535839,-0.042219765,0.034527306,-0.00088584435,0.00528966,-0.018827377,0.0189372,-0.065699264,-0.015579922,0.0040939907,-0.0148074115,0.010144719,-0.0054630213,0.060524035,0.026103064,0.015914183,0.018496068,-0.0560988,0.013723125,0.04410589,-0.01984472,-0.0488588,0.010136145,0.05061153,-0.035779346,0.044820808,0.012042323,-0.02010745,-0.042650912,0.0256855,-0.043513536,0.0021163013,0.020021798,0.06200126,-0.081997305,-0.027176784,-0.023277758,0.015352733,-0.17588834,-0.04038081,0.010531537,-0.008056349,-0.009797085,0.067499936,-0.0062915864,-0.005757517,0.02159133,-0.035166506,-0.018918755,-0.050924774,0.06382509,-0.042959154,-0.025491958,-0.027663365,-0.032462258,-0.0399421,-0.0046336562,0.04646797,-0.09672615,0.021126974,0.047676973,0.011161357,0.043301098,0.017562935,0.017230375,0.011108754,0.01838606,-0.016670633,0.01486036,0.03088577,0.0019841718,0.03684059,0.028265782,0.009107202,-0.02149385,-0.051174194,0.01924043,0.0035297682,0.035380006,0.0006790102,0.0021285233,-0.046786036,-0.034046695,0.0019908925,0.01146804,0.035664693,-0.00073421415,0.012434873,0.010992194,0.04233092,-0.049895618,-0.020555213,-0.005883447,0.050203573,0.025871627,-0.012417948,-0.00854364,-0.0004913648,-0.01523759,-0.009492014,0.028692467,-0.018648123,0.023331588,0.00032925166,0.013600175,0.04329811,-0.0029349208,0.077101454,-0.03944915,-0.033184383,-0.01293976,0.010970456,0.017545886,0.025556289,0.0054428647,0.05488279,0.011426671,0.026630726,0.027528258,0.06990607,0.016988877,0.010012602,-0.014499652,-0.036255024,0.08207709,-0.020168178,-0.016326373,-0.014838692,0.051785436,0.015096749,-0.019308908,0.008884302,-0.02456382,-0.003937427,-0.0102028,-0.0005549394,-0.013369972,-0.0124108745,-0.008838485,-0.014441451,0.011617558,-0.038313307,-0.027645122,0.014090271,0.006910349,-0.014989056,-0.013160136,-0.08468615,-0.01969821,-0.006875492,-0.014092795,0.006755872,0.040509038,0.045485597,0.008489804,0.032408167,0.02309529,0.06618107,-0.0013485948,-0.016490348,-0.027640318,0.021855302,-0.023304867,0.011914377,0.025627578,0.010611411,-0.01007212,0.045726642,0.038584717,0.006460293,-0.02518707,-0.024510847,-0.009022229,0.009150475,0.00059570407,0.011157995,-0.048615236,0.026449004,0.02043678,0.0046446403,-0.055438552,0.032406647,-0.05978739,-0.042666566,0.030945115,0.047119252,-0.011915428,0.024109986,0.005178513,0.07382601,0.0071213543,-0.015908075,0.054168735,8.1685495e-05,0.002862784,-0.00029453606,0.001577375,-0.018473836,0.0007595603,-0.03178154,-0.054243714,-0.05474837,-0.010675361,0.01392406,-0.05790898,-0.01966347,0.04057414,-0.01941258,-0.006321045,0.064320736,-0.039426427,-0.012764348,0.01650248,0.008876622,0.0056283697,-0.024361353,0.01756423,-0.026820809,0.05534604,0.029908031,0.0043451814,0.022987919,0.07447854,0.03283527,0.03493433,-0.055082235,0.016358547,0.0569915,-0.051724177,-7.583092e-05,0.06661027,0.02628254,0.040687285,-0.035729103,-0.008392114,0.0606053,-0.004538485,-0.011464034,-0.035595797,-0.015404206,-0.006337787,-0.022722837,-0.030615246,-0.022555457,0.061915245,-0.046780583,0.0023502344,-0.020666018,-0.010488825,-0.01423071,0.017890511,0.01978701,-0.025834193,0.0059638363,0.06852464,0.035438865,0.033697553,0.030594863,0.010194633,0.0638239,0.016966242,0.051504284,0.016151503,-0.008437176,-0.050956346,0.030423261,0.03363375,-0.023092197,-0.015598657,0.05035365,-0.027117854,0.065611206,0.008839153,-0.07772943,-0.026008923,-0.06709993,-0.027106302,-0.038415622,0.025362525,0.0302467,-0.072610356,-0.006756418,0.019376563,-0.02972168,0.032635693,-0.019365206,-0.0035855714,0.008933234,0.056078102,0.087097175,-0.0199668,0.0037611038,0.02027089,-0.011712184,0.021486245,-0.04504622,0.041216094,-0.031248087,-0.060674038,-0.0026562815,0.012239112,0.004366257,-0.03745037,0.0072702244,0.008180984,-0.027056927,0.033328924,0.0072324127,0.01754859,-0.0076573994,-0.0059494013,0.00437693,-0.015217766,0.012055388,0.005736149,-0.06900305,0.012807535,-0.008430668,-0.032623056,0.039312128,0.041833393,-0.0011246314,0.015447903,0.0038351547,0.046219453,-0.017782388,-0.01875473,-0.011829602,0.02787983,-0.033543736,-0.027958157,-0.028412016,-0.011703615,-0.0044671535,0.050878927,-0.030780591,-0.014254348,-0.0025673232,-0.040714595,-0.03753988,0.013995404,0.013254222,0.0005654701,0.0018153308,-0.0027938776,-0.0036514963,-0.0015361,0.0021262472,0.035832863,0.017712392,-0.01954819,0.027248947,0.017600456,-0.04332544,-0.005360342,-0.027050082,-0.024369128,0.008874521,0.011169348,-0.035401165,0.03237208,-0.047759335,0.021089403,-0.0024392083,0.049643632,-0.01403192,-0.04401966,0.07408988,0.052815065,-0.019823372,-0.016582109,0.068298355,0.009403003,0.011472661,-0.051894113,0.07785395,-0.017745974,0.030216532,0.0095032025,-0.05228702,0.03669054,0.046538297,-0.035856478,-0.00798285,0.02550134,0.0120375585,-0.036545992,0.05768018,-0.0332989,0.008440598,0.036227733,-0.018495368,-0.023487797,0.024017133,-0.028095294,0.016060805,-0.022981402,-0.051136453,0.021833977,-0.008308847,-0.0038730812,0.027254049,-0.037234105,0.0051924745,-0.0049521755,-0.04876894,-0.014704469,-0.010752303,0.020338448,0.030519368,-0.05320008,-8.794995e-06,-0.0034269597,-0.025046542,0.0092467405,-0.009017625,-0.01923033,0.05692689,0.009949783,0.0118456865,-0.034348257,-0.029178955,-0.036153007,0.009495941,-0.074232936,-0.07660948,0.0139549095,0.013664715,0.040850334,0.041633315,-0.019750474,-0.009314756,-0.0017029534,-0.010015073,0.014391474,0.03471733,-0.013358001,0.04248349,0.04337439,-0.027544668,-0.0014783788,-0.004938865,0.035751034,0.004384835,0.03407389,-0.0072824545,0.05389706,-0.029718753,-0.0985949,-0.009206814,0.0023685968,0.06555995,0.00012141777,0.012374431,0.018160025,0.006274791,0.006772674,-0.04760526,-0.041337248,-0.0008052794,-0.021213317,0.0025979248,0.013040962,-0.00013491379,-0.041603677,-0.06273523,0.0005938977,0.018919578,0.045836233,0.012890183,-0.051256023,-0.023776107,-0.06536954,-0.0034185555,-0.0020499497,0.024331536,0.06882714,0.03644006,0.019972155,-0.039540727,-0.0149454065,0.012381154,-0.013132773,0.06772331,0.014243282,0.055996243,-0.01504226,-0.039437637,0.041439656,-0.030070229]	2026-01-20 16:04:19.392867+05	ЖК Jetisu Kerbez Comfort. Адрес: г. Астана, вдоль проспекта Улы Дала
\.


--
-- Data for Name: bi_units; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.bi_units (id, bi_uuid, room_count, floor, max_floor, area, price, price_discount, block_name, deadline, is_active, complex_id) FROM stdin;
fb7c4756-17e4-4296-8546-cb41b103e79f	88911f22-3e45-49c6-a6e9-e5942bbc602f	2	14	14	53.26	32222300.00	32222300.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
657d19e5-f81f-4568-9a0c-fd5dbd234c16	6b50d82d-dd8f-4863-a6e3-ca3e25d3ec8f	2	14	14	50.22	37213020.00	37213020.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
b09212cf-ac65-4920-b620-b3a8426ffe11	fdcb21ba-79f2-4002-813e-07f21f7a4000	4	5	9	110.13	65307090.00	65307090.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
d68ea010-2e43-4bcc-8ea3-dfee3a839ad3	99a5f80c-dc8d-499a-b601-f86c00b2b069	3	8	14	80.43	53164230.00	53164230.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
cefd0999-eeff-474c-a1b6-3d16e26be0ad	50ad2080-db76-4292-8a9b-33eedd3ccd12	3	8	14	67.87	41061350.00	41061350.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
cf28d117-9c8f-4b96-a5f1-2f048871ae7d	bad9fb54-b059-4a6a-9608-be035915212a	3	8	14	77.96	45684560.00	45684560.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
4bb159b9-d93b-4c90-93a2-46938e42ba3b	33228bb3-fcea-4a78-9512-a8464192b7e3	1	9	14	37.46	26634060.00	26634060.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
10547b44-da8b-4116-8975-b4c886e316fc	e9a7e846-3307-4c51-b902-7b4d44abd7d1	3	13	14	80.43	46408110.00	46408110.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
5f90da0a-9458-40d9-802e-d359e7445e22	3d425eca-b41d-4bad-be1d-19c5783e4b9b	3	14	14	80.43	45603810.00	45603810.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
5aec2194-1280-498e-96df-ef2ce8859fa7	07637ca4-b037-457f-b04b-aa5759d17988	1	14	14	37.46	26896280.00	26896280.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
9d61d064-8ff9-499b-8b4b-4cc4055921f1	f41d6178-ae41-40ad-b33f-740b6f36a960	3	14	14	67.83	37699168.00	37699168.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
d0f00499-1573-4c3a-ac88-aeb5b6d82b77	f1f7847d-3e82-47b3-a378-bd7fd927e1f6	3	14	14	77.96	43735560.00	43735560.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
84a9c2f5-c31a-45a5-a1e3-f87fd8d9ebbd	2ed1f50f-382d-41d2-89c7-a391817d68e2	1	5	9	37.39	29014640.00	29014640.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
1bea5e6b-3435-4909-aae7-2907e71723de	47c91c11-9344-4f5c-a09d-a96b0a9d216c	3	7	9	92.04	55868280.00	55868280.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
c91bf7f6-5b39-4137-bd56-e854c295fc59	3a08abb1-5629-470e-80f2-b921d5311809	3	4	14	78.31	46437830.00	46437830.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
9299e921-c8d0-488e-95f8-c037c020b89f	42d1c681-8d5b-45ad-b2ea-758412810c41	3	5	14	68.13	42785640.00	42785640.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
15e2c325-c9e7-4c98-af53-31a71eaaed73	a7ce88a6-d1c2-452e-a220-9decf0ce3f72	3	6	14	80.49	52640460.00	52640460.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
79a527fb-a5bc-4728-b152-7fff5f14a430	437d52d4-4f8d-4ffe-b255-1f29dcff78c1	3	7	14	77.74	46099820.00	46099820.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
b17581f9-e32f-4b26-9406-b040e716281d	d2897c51-2608-45b0-b5e4-2b6da0fc1525	3	8	14	67.88	42628640.00	42628640.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
1444f0fd-47bb-4ba3-8090-f934838f2206	a0b58e70-2211-4918-82b4-adc70300af0c	3	9	14	80.49	52640460.00	52640460.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
45e1eee5-34f0-4ce0-b085-9a49bf3bbc50	2f16ebf0-e2ac-4146-b7fc-9868299cdb1e	1	9	14	36.64	27406720.00	27406720.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
4017e5bd-9cf6-4d3d-b014-8750e41002c0	38fcbe09-0bbf-4901-8f5d-ad88b60bfe03	1	11	14	35.24	26253800.00	26253800.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
58a9a153-b74c-4e33-90c4-2d5bc366a05c	b773ac8c-05bf-4f31-9a07-feb842ed0e7c	3	12	14	80.49	46040280.00	46040280.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
7e60282d-8053-40ca-8c7e-58e3ffc7ed71	5c4d5f9d-f469-4ade-844e-41cc7715a004	3	12	14	77.88	46182840.00	46182840.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
45700d73-1b00-489f-ac10-45bf114e6fdd	601160da-2bd8-4984-9249-723021e2ae0b	3	13	14	80.49	46040280.00	46040280.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
6da39e28-89f8-46f7-81cc-4e7cfc5b9adf	a793611e-90a0-4fed-9f04-e3569d2b4c69	1	13	14	37.26	25709400.00	25709400.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
9438dfdd-790f-410c-89e3-c132625d4410	4029ee3d-798a-46c6-b8b6-7270fd1a1582	3	9	9	75.04	46824960.00	46824960.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
94252f6a-b43d-4278-89e9-ca0480fab9d9	fd200c67-e7f7-4800-b207-88972202c370	3	14	14	80.49	45637830.00	45637830.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
186537b3-4d7e-41bf-a83d-5ae2593fbf7c	d651179f-ba21-4c33-9429-ae02b04c55d9	3	14	14	67.84	41382400.00	41382400.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
d9c7c599-c9c7-42b4-9c05-271827747463	186ad204-c652-4f39-928c-b61007c115f3	3	14	14	77.88	43690680.00	43690680.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
23b50484-b2a8-4d3a-b84e-1ed2a3d5b9d3	b883676a-ff04-4786-ac71-850a7bf92ece	2	2	14	61.27	36149300.00	36149300.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
9cba4fae-6577-4591-94fc-737f5656a7d0	b470242a-ea53-4ee8-bbc6-372c8c8568d4	2	9	9	59.43	37440900.00	37440900.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
62f53d04-33e6-4066-94b6-fde6e54ebd23	6da5295a-7ec5-4d8a-b91e-4b9acaffc4c4	2	2	14	54.18	32508000.00	32508000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
082c0dc9-5335-4b65-bd75-ce52ca3adecd	83db2cdb-7faf-4826-aae6-d6f1eb176aef	2	2	14	51.23	30738000.00	30738000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
8e2e2a51-8bfa-4776-b692-4fd43bfc6bb1	e4fc5ac1-c04e-4ea5-a000-75c48be79a1e	3	14	14	89.71	50147890.00	50147890.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
f7e006de-abd4-47ea-b237-e370931a633c	441f928c-8e03-46b3-b4bf-b024c7a31c4a	2	14	14	59.96	35976000.00	35976000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
47cff6e7-3717-4e2a-ad16-d253a23c3593	c0ecd4a8-81d2-4afe-9430-fcff5d048a03	2	14	14	45.99	29433600.00	29433600.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
c4152ade-dc51-4bc6-afe2-21d3c834e3b7	9970194b-09a9-4cd3-822a-6aba25a6c375	2	14	14	59.93	35958000.00	35958000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
1d8ea90c-34ec-4d0a-9d0c-2781faf59aab	91be697a-c27b-496c-aba3-f575fa0afb22	2	2	14	52.02	31212000.00	31212000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
73ce842f-5e19-43ef-943b-dec6b2a390ec	13bf39da-4106-4e2c-a9e2-e32496472cba	3	3	14	72.33	44193630.00	44193630.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
43f7fba0-f148-430d-9bd2-363fc33013a3	2b2ad92b-48ee-4ec9-a081-6f2acfe03306	2	2	14	53.29	31441100.00	31441100.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
0f61365a-59f8-413e-84a3-3d33979359df	2b01fa80-c374-40c9-bb56-a03d9207b6d9	3	5	14	80.26	48477040.00	48477040.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
b90f25cb-5569-4a74-a725-617596ad0515	10f7e38d-8cf4-4a7b-9714-f2fd52913089	3	6	14	72.06	44028660.00	44028660.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
4ac2daf1-ffe1-43e2-99a7-1ecfa06d0dd3	9c7e21d9-b227-4223-8267-2023ee7f6d2f	4	2	9	111.29	64770780.00	64770780.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
1bb5c3d6-0d92-4c00-92ea-ec27ed19eda3	dba4524d-855e-4149-889c-ab753c01bd91	2	13	14	53.26	40158040.00	40158040.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
5bec29fd-3770-417d-9bd3-726cbadda612	0a17f8b6-a938-4fbd-88b8-352f2c091646	2	13	14	51.11	31432650.00	31432650.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
5df20e6c-3939-477b-ab57-c763f711dff8	e4451151-d2b9-41a8-a01d-b93cdd40b8fb	2	14	14	59.18	44089100.00	44089100.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
46216af2-b40c-463d-a00c-156a78841321	9c024df2-be35-406a-b7b1-51f51e68ccc4	3	5	14	80.8	53651200.00	53651200.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
1f0357e3-28c8-40d4-86d9-09bb6bd7d710	1ad089a6-82c5-40eb-93d8-f5b792a1f9e3	3	5	9	75.3	47740200.00	47740200.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
4b283a09-0999-4491-9bd4-67b71d040d89	deca9e6a-faaf-4c1c-92bb-945c6621fd7a	3	5	14	78.33	45901380.00	45901380.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
7e009c64-1880-4679-b782-e74750d1519f	316fc7f9-896e-463e-b150-2567aaeda898	3	12	14	79.75	46015750.00	46015750.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
aeca13bb-5b1c-4f8b-9625-fa921b788c0f	30fd9582-ed23-47dd-8c9c-1af40732d431	3	13	14	79.75	46015750.00	46015750.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
9b0c250d-0696-46e3-9ea0-0a11f822ea96	a5606806-6947-438e-8e57-414389d16b9a	1	9	9	37.77	27118860.00	27118860.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
da745e70-5533-4a98-8ad7-4971a01b6a13	a6163366-d0c8-459c-9c10-7acb70434e23	2	4	14	53.61	41762190.00	41762190.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
384827fe-070a-4323-baa5-f66468265523	67e8018e-b948-4ce7-aee7-879586839b18	3	3	9	75.3	47740200.00	47740200.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
d11809d1-fdba-4a14-b620-0959c879af0d	ae865936-8efe-4e1a-b1df-a7000894f98f	2	5	14	53.61	35918700.00	35918700.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
331488a7-b624-4e74-b3ed-b65fdbab6a39	f6c6852c-e347-4a49-9a08-5ff824feb969	2	10	14	50.22	38116980.00	38116980.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
43f61dea-ab35-418b-887e-18b76cd95cc5	5150d83f-75de-49c0-a56e-a5d3b34af7ea	2	12	14	50.22	30885300.00	30885300.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
7a1fac14-2c71-443a-b932-7ab51ba25d6d	4c56b8da-531c-423e-a8d3-a288d8f33ee6	4	13	17	112.95	67431150.00	67431150.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
17e5dc7c-4aa9-468c-9ad6-751a6093de56	8d75be83-9780-4d66-9aab-3a27909acd3d	2	16	17	61.77	38235630.00	38235630.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
46204aba-3635-481e-b569-c93a959925bc	d12f8d14-c777-44ca-89c8-45e19262db11	2	16	17	45.88	32483040.00	32483040.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
8fc984ab-6f5e-4c2f-b758-560cc23dc39b	a3410c94-9bcd-49ac-b829-19d864ba6983	4	16	17	112.95	67431150.00	67431150.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
90ef3501-1dde-436e-9ddb-d3b94fbeed3d	04b2e832-8a59-4fd6-9690-3c1d3fa20961	2	17	17	62.47	39356100.00	39356100.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
63ee1464-bdd9-4ce7-b28f-dc34715e10f8	2409d8b5-3d5e-4ac7-bb9a-65c6f60e6eae	2	17	17	45.88	32483040.00	32483040.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
79bc66af-a36b-4525-972a-6abad3d2faaf	e36b8b7f-58e0-4f9a-b9e8-d869c5e3b743	3	17	17	71.22	45652020.00	45652020.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5e65e806-8a89-4e92-a4e6-3e201a6d5f67	21fb0fe5-7026-4586-8291-3f5021e64c86	3	8	17	89.73	64515870.00	64515870.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
a299df37-a351-4aa5-9992-03662156d6e3	f58f7491-d445-4294-8407-5568217e6081	3	9	17	84.5	51460500.00	51460500.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
d9bf1b79-be91-48d8-b488-f5dca88220c8	441f3d6b-9453-4445-9b26-c37ff048cb59	1	11	17	38.3	26235500.00	26235500.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
bf207261-2c13-447f-8e4c-f8d52100f547	8c343c71-f2d1-4b0c-8eb1-a189477ef643	3	12	17	84.82	51655380.00	51655380.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
a18fce34-f3e9-4be2-b9a5-58a98a2cf790	9c405661-6ebc-49d5-9135-5454f1ea9190	3	2	17	72.49	44581350.00	44581350.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
038ff604-c3d1-4e0f-8f97-bc3e2149325e	e009193e-61a0-4476-bf0d-d57b08b13512	2	2	17	69.21	43809930.00	43809930.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5a05d616-440d-4127-9282-f3a3a83e8b40	516c8c37-a6de-426d-89b7-5622bdad381b	2	4	9	56.24	39030560.00	39030560.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
91ee48e2-e496-411e-aeb6-520fe33ba90b	ffc54f8f-3828-43ef-8667-fb91dcf26b98	2	8	9	45.32	31859960.00	31859960.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
7cbed721-5d26-4da5-81cd-192a4525e60c	8af88f05-5934-46d6-90b2-bebbce458189	1	14	14	36.47	26185460.00	26185460.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
c890df51-272a-4934-b8f6-f762d2e01abd	4dbafbb0-21c5-4982-bb2c-01fa4730cd11	3	9	9	67.57	39933870.00	39933870.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5ec04d05-896b-49f7-bbd6-6cd942ee3a20	b50fe2d6-ac72-44dd-9600-cf7009fc0c42	2	2	9	56.36	37270786.00	37270786.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
9d810340-0a5d-4e9f-a937-aca55f681c89	750b67bc-6677-4217-8632-ef381d6dc24d	2	3	9	45.3	37160460.00	37160460.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
45a452e0-7a89-4175-b2be-bf6d7eb63047	6bab77e3-74f7-4fd2-ac22-49eb1cf67368	3	3	9	67.81	46898970.00	46898970.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
768090ce-bce0-45f2-9991-7e42998d7721	e6fbcb91-ca78-4ce2-8774-64d697c59cfe	3	3	9	68.7	47540279.00	47540279.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
23955de8-78e7-4693-b87f-ca51cb1890fb	7536863f-2942-4d72-a853-75e3f3e76419	3	4	9	67.78	47152480.00	47152480.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
b39db162-4df0-4a49-9dd5-047fcf654d51	5addfb44-908b-433e-8097-9efb8cfaeeb0	2	4	9	56.06	44647880.00	44647880.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
4bc8f6a5-3fc9-4042-b0b4-038455aefe6c	74e1e876-5743-4299-bd06-f0e774f82dd7	3	4	9	68.22	47597699.00	47597699.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
578ed25c-71af-498d-9684-9d9ab65802b3	136d8122-8fe6-4096-8769-f226e14c3878	3	5	9	67.78	54540500.00	54540500.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
00712c96-6994-47e1-ac60-4e8dc1323546	86032515-6894-4e7a-ba2b-667e708e2169	3	4	9	89.03	49589710.00	49589710.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
df8f373f-d5d0-4d28-9eb2-ea90be9a4063	ce1bf5ff-017b-45b7-a326-96283f1a748f	3	5	9	68.22	47597699.00	47597699.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
4bfd02ab-c921-4f5b-a29c-e71fb995f5a9	5bfadf55-7648-4d73-aced-7d7147488c2f	2	6	9	45.3	37341660.00	37341660.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
543983ef-ddc7-46c0-86a0-016eacb72483	98c5b796-4572-403e-842e-02a160cfc59a	3	6	9	68.2	55019579.00	55019579.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
124f0516-c4cd-4805-8477-beba37510ac8	f6378648-da64-49dd-8e87-43f46318eab6	3	7	9	67.68	47093380.00	47093380.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
7e00504b-d540-4146-9aaf-2bfd368853b1	cd4006a2-d9c2-460a-9f7b-f29298eb4396	2	7	9	56.01	44613180.00	44613180.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
dd724969-48db-4e21-bae1-c01bfcefa68c	8d65dda2-a1a7-4cbf-ac05-a1a399b76809	3	7	9	68.2	47585779.00	47585779.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
e5dd75d4-c914-40cb-a405-b64081f2b671	982c195f-2b86-4fc8-979f-6a02e4468090	3	5	9	88.64	58945600.00	58945600.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
26131deb-d8b0-4ac5-b91c-766ff90ad3d2	89a54edc-a171-4486-8d2a-efa5354fa210	3	8	9	68.18	47301139.00	47301139.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
75a30067-74e8-42f0-900d-a16ff5f636e9	062da13d-064d-47ff-ae7a-46d3fcb2642e	2	9	9	55.95	37018290.00	37018290.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
61519d55-3c6e-44c9-a5b7-61c44b127cef	014bccd0-152f-48bf-8b31-c42aac761d4f	3	9	9	68.18	45937539.00	45937539.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
38e47b08-b837-4a89-a463-d4739400d689	92c89666-7ee6-4cd7-a41f-5eb036a1078a	1	11	17	39.04	26742400.00	26742400.00		2026-09-29	f	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
495487e4-89e5-4a92-a323-a41feb11f40d	105852d6-9422-4b21-82ba-46f416700a9f	3	10	14	70.57	42342000.00	42342000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
38e55562-acc2-41aa-83c3-fa95eea335ad	c6e2f6da-0d2f-4cf1-adee-fecaca7cd41f	3	11	14	72.06	44605140.00	44605140.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
73d2b8f4-1c33-4eb7-84bc-254d33f2d1da	d7129907-5a24-4f27-8cb4-3e571bdb2468	3	14	14	79.75	45218250.00	45218250.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
b57c6612-5388-4a4b-922a-a5cc4b7ee174	326d245c-31d9-4d39-b9b5-b44137f5b829	2	3	14	51.5	40221500.00	40221500.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
2969abdb-8141-4302-a998-f1a921d8129b	b3ed1255-fce6-441a-a48b-4afe025e200e	3	5	9	89.59	52678920.00	52678920.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
7fbf4b57-b8eb-4a1c-8393-4166cea31c9b	8d750dd3-5a0b-42a0-85bd-0d36b112869d	4	5	9	113.6	76112000.00	76112000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
d8dfbb68-ca3f-42f4-b927-2c81fb1435ab	d0566d19-745e-40e5-8b1e-9b0b4804cafe	3	6	9	76.02	59075487.00	59075487.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
ee9c94f1-c433-4bab-b741-9eac7c1fbe97	7e4c9164-af61-4748-aec8-798e5246de46	4	7	9	113.6	76112000.00	76112000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
c89e63cd-c2a6-4429-927a-c42d2f41692e	d8d46695-76c4-40a8-84d1-34e3fb132781	3	7	9	76.02	50941347.00	50941347.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
7eccd167-d007-4d24-a05c-978e2e224dc8	3f7fa103-c345-46df-8855-29319eaf7977	4	8	9	113.6	64297600.00	64297600.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
0b3aa789-0680-4122-afdc-20e40041a306	75a05893-b3ac-4bf1-99e0-b2facec36542	2	8	9	56.79	45033406.00	45033406.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
a94dbf5b-7315-438f-b49b-f102b928fc4a	6fbbb040-4eb6-4ba7-81fc-2f299c6eda93	3	8	9	76.02	50637267.00	50637267.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
ec17125f-82c4-40c6-9dcb-39ae896b1605	51466577-7624-4bed-a0f1-b0fb806d35ea	4	9	9	113.6	62025600.00	62025600.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
61e8792c-a66e-4377-b4fa-b2711c727ec0	77af2363-7094-4317-b016-15e7ff661a83	3	9	9	76.02	49116867.00	49116867.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
baa61167-f862-4c70-aa9c-8c72c2abe1c8	934c13f7-aa44-4062-8d58-6a40ff06152d	2	6	9	56.32	39086080.00	39086080.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
548cafd4-8172-40dc-be29-cca023e573d8	d5bbc8b1-b204-438d-b5db-e1f466ac6023	3	2	9	93.63	61444510.00	61444510.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
548f971b-30ab-4d74-97b2-fcef83a1f669	c2b16f8a-8337-4731-9a41-31a2f32da295	4	3	9	113.61	75664260.00	75664260.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
f5e2ab18-7598-416b-bbe1-82d29c37ff12	ad61ba20-be46-4234-beb9-5aa26ea1855f	3	3	9	88.88	58305280.00	58305280.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
e2a64514-b4b4-42eb-8ec4-c505054b5122	08f8ad28-31cf-4433-84b6-2c6714940337	2	4	9	56.15	38968100.00	38968100.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
a7175802-de47-4592-927b-a1494b623cf7	f9ff240f-ecaf-4aa1-a31b-28475e75962e	3	4	9	88.89	49956180.00	49956180.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
61b4a95e-64b1-4df4-8b6d-279408bc4610	58665758-12eb-4ffb-862c-36f823daab1e	4	5	9	113.6	64752000.00	64752000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
57c2126f-c465-4031-9fff-776214d3e7d8	53f62777-1d24-4e07-95b5-bd2cb03c1a8f	3	5	9	88.89	49956180.00	49956180.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
87cca6a1-c480-4ea2-a888-156422f6bca3	0e6de311-c46d-4a3a-a876-43af199afefe	4	6	9	113.61	76118700.00	76118700.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
9ce69e84-c450-4e11-baaf-1de1c60463a7	d010aa92-dbdd-4584-a4b8-e7d20c4e5e8d	3	6	9	88.88	49950560.00	49950560.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
8be91a5f-628e-4b08-904a-a666ac4b8e1a	220ef100-f8e9-447b-b2a7-307d06869ea0	4	7	9	113.61	64757700.00	64757700.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
d082146e-c961-4182-a4e8-f2c199945919	fd4a566f-3d4f-4e6c-aa15-c88876671155	3	6	9	89.1	49628700.00	49628700.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
e7a0653f-1ade-43e8-85b5-0ff58c6b6744	6f622334-840c-45ee-871d-1c6ac580e2ac	3	7	9	88.88	58660800.00	58660800.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
096e5822-6076-49a4-ae66-a4bc02814b33	8dcae0e7-ee04-4287-b20b-ec2f3b989114	4	9	9	113.57	62009220.00	62009220.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
8a5afd15-fb95-4aea-9166-0957fcdb7e79	50192a95-733c-4225-a3fe-53c3d51a3c8f	1	9	9	35.5	24850000.00	24850000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
dbbbaba3-213a-4aa6-8633-b5da28bb96dc	e743d17c-687e-4930-9ec6-22eb3692e3b2	2	9	9	56.15	32454700.00	32454700.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
af822a7c-3081-4614-b4fe-b6007d563745	550e6e16-51ea-4ddc-a201-dc7a727be464	3	9	9	88.89	47822820.00	47822820.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
68d45493-8c02-400a-9e8a-3bc137900947	9be15940-18f7-4e5e-9f31-961633e4ce31	3	7	9	88.73	50309910.00	50309910.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
381927ff-a7e0-4b14-95df-5be312eb0ce2	ba204e45-76db-471e-b314-f62251841cb3	2	7	9	55.42	38516900.00	38516900.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
633c6553-687f-4c6b-a909-3c8de183804f	bfe8da0e-923f-48e1-9344-a954aea3c883	2	8	9	55.42	36023000.00	36023000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
1ce61224-ca60-4425-afe7-5bc179a2d082	52e07f5b-c05f-42ea-919b-5f5bc4746d44	3	8	9	89.1	49272300.00	49272300.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
70c46cad-ffc8-43b3-ade5-f43e8b55bc10	f7252d9d-2c68-4598-8111-81d3cc0ead9c	3	9	9	89.1	47490300.00	47490300.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5e9159ef-d23b-4265-a1bd-a3804e5b3cfa	84a53bd8-cde9-414f-9558-72995caba8ee	3	2	9	77.26	53328562.00	53328562.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
4d9a2719-4088-49a3-96d9-4a92a96395e5	d3fa04c8-b246-4d8a-a1d8-ad5a7fa6a356	1	2	9	54.27	38479797.00	38479797.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
16390581-4105-4fa0-ad21-816875cb2c50	1e3916dc-a442-43e7-ac88-6b3427fba317	3	3	9	76.5	43681500.00	43681500.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
06a9b326-b726-4c74-b151-5dac5d12a9ab	33795eb1-1da1-4ecd-a8aa-2345c3b329c2	1	2	9	40.48	29325196.00	29325196.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
4e46542c-3410-4051-b274-01d0f3a47316	360608d0-f14c-4306-aee7-c4625e05c30d	3	4	9	76.57	53369290.00	53369290.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
3e5fb381-32d3-47bb-bef9-d52a70005df3	190914e8-9bf9-4b03-a947-4a7b17911847	2	4	9	62.08	36937600.00	36937600.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
0729c8ba-6a15-4a0a-9c79-f028663b1b0c	7afe69dd-bdd4-4ce6-a1d6-1ce6316dc6f2	3	5	9	76.41	43935750.00	43935750.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5de56f45-a0fa-454a-a41f-ddb9fdc5f28a	a3095b47-13f6-4b08-8faf-49d004aa0d29	2	5	9	62.24	42758880.00	42758880.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
82e9ef36-2fa4-4be1-8127-f322fe7ca8ee	6d8a9809-e384-496c-9e50-a339ff741d14	3	6	9	76.45	51603750.00	51603750.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
89d5972b-e882-4b38-8d82-426fab16718b	7ecf0268-19ff-4396-8215-ebb9c7f6f9ca	3	6	9	76.48	45811520.00	45811520.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
cf1d62fe-e851-43b7-8301-f37379e8a0b6	f5724f79-c566-43ca-b24d-9f5f22b0384e	3	7	9	76.45	43958750.00	43958750.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
8fda1724-b954-4d8b-ad99-e5b6ee463d91	d5090094-65d8-49ed-b4c3-0c438194e603	3	7	9	76.48	53306560.00	53306560.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
32e7e9cf-51f2-464d-95e0-86a841ce470e	d54dd87e-9bda-409d-8c4d-fa0a08067ced	4	8	12	114.1	61956300.00	61956300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d6b4916d-bc67-433c-a77c-e3877e343fe6	3a04415e-84cd-47eb-920d-88cd4daaa0b3	3	3	9	76.02	50637267.00	50637267.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
69f6a2ce-501d-48bc-a9a8-25986965f858	05c0b14c-8c2b-4c83-a460-57deba7f7b9b	2	5	9	56.79	45260566.00	45260566.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
cb3b689d-4f96-4e7f-bcdc-7cc6c4637855	4d10264b-1f1a-4784-a44a-7a686ad8ae8b	3	5	9	76.03	50947027.00	50947027.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
18cd9e37-af42-4dbe-a815-6b45f94d06bd	d4633723-19f9-4939-95fd-cd9606b9b155	3	5	9	89.03	49589710.00	49589710.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
76eeced5-8b92-4c31-b85b-2efe5cffd39b	ae3732b3-2855-4e5b-a0ea-b0efbcc511ae	2	6	9	56.79	39695146.00	39695146.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
6a0b9dd8-d931-4a0c-a4f2-8693cf7e317a	4e37bd96-3413-465f-b158-f28bf0af1a08	3	4	9	76.03	50947027.00	50947027.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
968305a1-b2ab-4488-b2d6-7b64f0a8abb8	18185525-5354-4480-8d25-f191e7deae30	4	10	12	114.1	61956300.00	61956300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
bd46f4bf-0516-41f2-975c-907089d9b0f1	0ccbb771-91e4-4f94-913a-f8c78e7af527	2	11	12	60.94	37051520.00	37051520.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
f9bbd3d9-8dac-4675-96d5-a6881ccfcb6a	1f2d5c03-5fb6-4d48-9c9f-80d22bbada41	3	5	9	68.25	48116250.00	48116250.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
b1ab5f41-288c-4ed7-85e7-43318d6fc713	8022607c-696a-4794-8d36-7f99967c520b	2	5	9	56.08	38358720.00	38358720.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
62f6653c-4946-43fc-b84e-353aebcc8244	f264c3f0-e13e-4703-b84a-247ff9de3b1f	2	5	9	45.32	32041240.00	32041240.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
f36b82ed-3599-4e82-8e7a-af0b9cd514d3	61ee5d64-9637-40ba-878b-17d96b2fa344	2	6	9	56.03	38884820.00	38884820.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
51ec1ba4-c328-41db-9dfb-7b28dbe26ede	1d3ae2f9-5acf-49bb-a957-759b8e0350d9	3	7	9	67.67	48316380.00	48316380.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
97b2211c-9314-43a4-bc59-d65c3039275a	2d93c7f2-2210-41b8-8e8c-5cb77653ae04	2	8	9	55.96	37717040.00	37717040.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
3dd5a2ea-75fb-4dbf-b5a4-a5875c2ad851	900f4e91-f5e4-48f4-b58e-2eabe4c49e1f	3	8	12	85.95	48991500.00	48991500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4f255845-447b-474c-b9c5-2c4ee1aeb8ca	eee36169-7160-484e-a8e4-7398f9fa5383	2	10	12	60.94	37660920.00	37660920.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
897d89c8-bb7d-4bb4-91a8-3e994b5c6076	5b2dfbe9-6043-4202-bb6b-0fa050d1cff2	3	10	12	85.95	48991500.00	48991500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
1bb4a2ab-b874-47ac-9dcf-b16e30865df3	a02f050a-178e-4a01-bb04-f84cef2954d4	3	11	12	85.95	53976600.00	53976600.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9890e1b0-b5a6-4c08-9816-b42316a9132f	30a583a8-8374-425f-9296-af7d36ad2d23	4	11	12	114.1	60815300.00	60815300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
615de941-90ab-45a7-893c-f1ec6675caee	f393ea6e-ce8c-4187-a99b-1e63135aeede	2	12	12	60.94	36442120.00	36442120.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2757cab1-b271-4e10-9556-e4b12a497110	053826f4-3212-4b15-bbd0-869b3a9ff6a8	4	12	12	114.1	59674300.00	59674300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
caf10331-3559-4620-9d81-803540c1491f	596e45a0-3772-4f53-a42c-9e77bf14bc39	2	2	8	62.85	39029850.00	39029850.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
f483e4d7-0220-4fe7-8d5a-258438ecdb4e	6e1c4f36-018d-4824-9719-710f93dfaa70	3	4	8	89.91	62397540.00	62397540.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
188bbf92-0837-4df2-89c9-476746bbf17f	f1e43532-73c5-44d4-81a6-d3a7b594e025	2	6	8	62.85	40852500.00	40852500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
935b24ef-31a5-4b5b-a19f-48a9507f2677	330b7a49-5a9b-43ae-a436-1927268bf7a9	3	4	8	91.29	61164300.00	61164300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
62c8223a-c38e-4798-bcd3-581582e7d72b	63053ab4-8aef-4e3f-b37c-435f7613c4f5	3	5	8	90.67	60748900.00	60748900.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
110ea928-b7c4-47e9-a20a-09fda0481e6d	63502a7c-caef-4833-9a09-8f199bcf05df	4	2	9	111.39	63158130.00	63158130.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
45190b8c-5a8e-4463-b3e0-aa4dc410b05f	f56f1c62-49d9-4f05-8acf-0f5708fade52	3	2	9	88.37	54612660.00	54612660.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
15b50f20-b194-4a9a-8a3b-1e132c513cf5	8383bcc0-aed9-46dd-b7d1-95e60ba04a15	2	2	9	48.43	34772740.00	34772740.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
094ea9b5-e582-420c-bb95-8db638b2110d	88cabc6c-aa41-48f5-a739-1d5351ae30ea	3	2	9	84.4	47854800.00	47854800.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4c737c63-64dd-4fe8-bd81-ffc9f5f60dda	0ce30e19-52a2-4ccf-b66b-331744c19428	4	2	9	100.43	58751550.00	58751550.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9274f58c-01a5-4e31-b1db-21cf62f74f95	732305dd-bce5-4bed-a70f-61ec844f20d4	2	3	9	48.43	34772740.00	34772740.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
46da82b0-fa85-4e5a-8197-56c7bac1743f	4534d94f-bae4-45e5-b329-2fdeb0fbe607	4	4	9	111.39	66277050.00	66277050.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3a01b6f8-2da8-4b97-a42a-ecd3bbbbad33	11475546-4b3c-4c88-bf6b-6d4fa793a195	3	4	9	88.37	55673100.00	55673100.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
98119720-a06a-4117-ba5c-086cf47888d5	790318c5-69fb-4679-b4ba-e220ea683444	3	4	9	84.4	52243600.00	52243600.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2010a40f-134b-4365-ba0b-32bce4df6772	f1864ba9-1dd5-4e2e-9361-43ff657d1cfd	4	7	9	111.39	68727630.00	68727630.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
dd75a769-5275-4d78-b628-8ff0b38e140d	aca81a70-7b77-40ec-ac59-43f38b94793a	3	7	9	88.37	53728960.00	53728960.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c82cefea-be2a-48fe-a113-96ba6e11f992	bba2e31b-4604-47df-ba6f-54d6b262310e	2	7	9	48.43	32351240.00	32351240.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
bdf89895-fc5a-4d95-ba50-38323c6eb4e8	c2c4373f-eba8-43e7-a44f-0b892aab395b	4	8	9	111.39	62044230.00	62044230.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
ed263c0e-78f0-4476-a935-9e01f0f1602a	3d6a8924-50ad-4748-a41b-4b8c0111e808	3	8	9	88.37	50194160.00	50194160.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
31123fdc-c3e4-4aec-961e-470520f5133e	e1e5f045-625e-4476-99ff-19fcc99be413	4	9	9	111.39	60930330.00	60930330.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
303075a0-a0a2-4051-9ddf-f3a467650d15	1724eda8-2311-4c79-896d-4a1093cc4c56	3	9	9	88.37	49310460.00	49310460.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3a97da0e-bcb9-4d3c-909e-a1b3d3912805	dc6ee9f3-13a1-4ac3-96b6-af58b80c80d9	2	3	12	51.39	32838210.00	32838210.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
74205931-d493-4e7c-9966-846b0fb0d60a	aa1a45bb-8a55-4987-b7eb-5911f374778d	2	3	12	60.89	38238920.00	38238920.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
0d58bce4-a31c-40a8-8305-145e6302473b	c66756b1-39a9-4ab7-a6db-cbe8281d5de5	2	3	12	54.16	36395520.00	36395520.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
286f4f29-24fe-475c-9496-00fd3ef1f553	a3c7145d-a1df-4a7c-9d99-a4af14db6f12	3	3	12	85.73	49723400.00	49723400.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
60598f3f-51e5-45af-b060-f551fa5ba4ea	68bf51f4-8673-4a5a-8014-1a309806527c	2	7	9	62.02	42607740.00	42607740.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
bb1a64c4-eee1-465b-8f7a-fa5c0d0caaaf	b37e17f9-5377-48f1-b56a-a025ab10051f	3	9	9	76.46	43964500.00	43964500.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
fa86fdfc-6b02-4f1f-93b1-f0931854d433	ea6c1fb7-cf5a-413b-bb45-64affb87f16e	2	3	9	55.35	38246850.00	38246850.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
68a142f9-8ea4-4cfb-bad3-e0f6b2ad2ca8	3270b84d-9948-41d4-a418-44274c5ddab8	3	2	9	68.5	47016833.00	47016833.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
da6b2a31-2d06-44c5-9a8c-eaa8b631d099	0255d313-6b1a-476d-931d-0167462a8b47	3	3	9	68.73	48111000.00	48111000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
192b5350-78fd-4865-b994-0cca8c9ba0db	5c8531f4-d879-4582-baa4-d94e93c19904	3	3	9	67.79	41351900.00	41351900.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
4b8f7992-7fb8-4d61-aa97-8e36ed759eec	1b9b1181-2862-43b1-bd37-6fe6260594d9	3	3	9	89.02	49584140.00	49584140.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
22de7bdb-6726-49f0-b808-5ec650c6c5bf	cc2c8566-1ecf-463b-be14-5837894decef	3	4	9	67.76	48380640.00	48380640.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
dda71d99-69b6-4c31-a20a-07125199b7f0	dd2a46b4-59da-4c7e-ac7b-ccfd2318e29f	2	5	12	51.39	32838210.00	32838210.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
db91dd76-4630-481f-9ba9-bb4bb94b271b	afeb1018-9a24-491e-a5fd-a390d8212a1f	2	5	12	60.89	38238920.00	38238920.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d4db3d40-152e-481b-be04-f321ff7515fe	f051aca6-42e7-46e8-a8f1-c505aea704c3	3	6	12	85.73	49723400.00	49723400.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
b4e865d4-b559-423d-8597-033e279908d8	5a9c381f-9c34-43b2-af0b-37a151be05ab	4	6	12	113.31	62887050.00	62887050.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2e44a8c9-0a83-4489-9f00-0a44130c2294	5af57623-30b7-4ac3-98e7-733b23f9c33a	2	7	12	60.89	37934470.00	37934470.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9a9daafc-26f4-41dd-8f55-063c8f638aae	8f652a67-e562-4d76-8b4c-a7f7f9c65267	4	7	12	113.31	61753950.00	61753950.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d738f757-af90-444f-8102-690131f27b5d	13f74b7e-c9ae-4eff-a42a-2a5a62e58e21	2	8	12	60.89	37630020.00	37630020.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
26c89ba2-9ce1-45b6-bbf8-b62b7589c00e	3ef01549-957e-483c-982f-8d4a92824a2c	3	8	12	85.73	48866100.00	48866100.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c0207790-80d6-403a-9b65-0f234be6528b	0c7edcb4-ed46-48ab-8baa-b9e8f3b786b1	3	8	8	89.93	49461500.00	49461500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d631386b-ad5b-4f39-9e47-8a2f91aca177	b72c81d3-a05c-4e88-9fe3-7bded8d6083b	2	10	12	60.89	37630020.00	37630020.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
76a1444e-c3b0-41c0-8d48-665e9d0a7543	b701bc5d-3b4d-45d8-a5d9-956280aca01c	3	10	12	85.73	48866100.00	48866100.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
f9dd2b99-e44f-4715-a061-974eeebbd8e9	4060b324-8ad5-474b-a53e-e9f59fa90845	4	10	12	113.31	61753950.00	61753950.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
74637862-42dc-42e9-87e9-ee7f42fa2c8a	dd66eb46-908a-45c5-965f-7ed9d4316333	2	11	12	60.89	37021120.00	37021120.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
dd3550f3-32c2-4a63-a369-aadbff08ffce	862f1228-985e-417d-8cf0-e098e34d6e7e	3	11	12	85.73	48866100.00	48866100.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
5b5bf803-9fab-4135-9dcf-230d1f398c8f	c3e5bf14-d2d5-4099-8174-fd1d6c7aef4e	2	12	12	60.89	36412220.00	36412220.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
bea7dfb1-1c69-4991-a816-7c457083db63	ee09326b-1fa7-493c-9478-2e97127d32c8	3	12	12	85.73	47151500.00	47151500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
8478e385-90ec-4680-a830-f16739f5d6a9	6a7e256e-c6ec-43e1-8362-c95f8b98b963	4	12	12	113.31	63793530.00	63793530.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
0a68c28c-a312-48dd-a55e-49a739e245b8	68e5d32f-2f77-4fc9-8c4b-9556d1d4fb8b	2	2	8	62.92	39702520.00	39702520.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
097bd776-b58e-4b3c-820b-426a1e06aea5	91fd8930-b116-4f31-bbc3-0362a7cd658b	2	2	8	62.92	39702520.00	39702520.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2dc39782-d9b1-40e4-9b01-13014199b302	7acc9872-8671-4b43-9333-4d8f0594c7be	3	2	8	89.84	50310400.00	50310400.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
dda6b64e-1ea9-4eeb-b542-7720b109d45c	bb01679a-9f15-499f-a6e4-d2fed7aa27c3	3	3	8	89.84	50759600.00	50759600.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
56628d58-78d5-4c61-a133-5e76e0be749b	f7cff0bd-eb87-4e09-814c-97bb6e26a37c	3	4	8	89.84	55431280.00	55431280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9ec990d8-990d-42fe-b429-b0463095c176	b33c71ec-180b-4908-95b4-e932ce3c37ff	2	5	8	62.92	41527200.00	41527200.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
62907abd-e514-4a20-96ef-62fa963e1e02	4968f229-b419-4833-a76c-374410dcfebb	2	8	8	62.92	38758720.00	38758720.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
39dfdabf-a972-4b8b-bec2-45e04a0881a2	0594633a-90db-4b69-ba44-d50eabdac297	2	2	12	60.39	37079460.00	37079460.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9b40d817-0ffb-4445-be29-27eb95a6d7ae	4a537be4-2b18-465a-8e15-389a563dab72	4	3	12	126.58	70378480.00	70378480.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c5f3be4f-f65a-4c19-a3f5-9d1a823f0ecd	49d77d5e-45dc-4504-a815-7a09e135bce9	2	3	12	51.41	32491120.00	32491120.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
1f50eb61-2a0d-43d0-9c5c-448d6fb605d3	929d29e6-ff38-481d-8da9-e7311c79c44a	2	4	12	51.39	32324310.00	32324310.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
03095084-18c4-401e-8643-002d9eb244e9	4990019f-0749-455f-b879-00ebd4445a4c	3	2	8	89.85	50316000.00	50316000.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
b940e704-c35f-40d5-9805-14f1e9ac8066	5fd39247-d45a-48c1-9ed3-9e954bb46036	2	4	12	60.39	37381410.00	37381410.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
7b4cf599-8949-457f-89eb-58d370d28ebb	aa9bdcea-b6a6-486d-9e03-fe5bf45fd149	4	4	12	126.58	70378480.00	70378480.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d6b5ab07-563e-4890-8844-9fecdcf6df10	9861722d-308b-4e16-8aca-53ad55ba0ebd	2	4	12	51.41	32336890.00	32336890.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
51d5f394-a929-4746-a0ad-62aa243da15f	3df05a68-0438-4db5-9cb0-1acc124e117b	2	5	12	60.39	38830770.00	38830770.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
45642e5c-210b-4606-9a98-3ff98b3c0215	00fe49bb-a4fd-415c-8547-94b8adc5fd58	2	5	12	53.96	36153200.00	36153200.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
34508d57-aed8-4e93-8c03-3466914ce13c	feda5671-3757-4fae-84c4-6422c0cc7a27	2	6	12	51.39	32324310.00	32324310.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
0d025529-b8f9-48af-8554-976f701d1b27	1c4bd643-b4f8-4acd-8ff3-a3176a92e8c1	2	6	12	51.41	32336890.00	32336890.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d563cd89-881a-4870-8108-3f450f7618e6	6b237641-4845-46ab-ac31-e8a7755c7d40	3	3	8	89.85	53640450.00	53640450.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c968d435-90e5-47a2-bca3-9f398c3e4fe8	3351aa63-70a7-4bee-bc00-a101fbfbcc2e	2	9	12	53.96	35613600.00	35613600.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
489b3223-4d51-46f5-811e-9ffa5de5de6c	f9cf6363-783c-41ad-ab70-a8aea6bc6dc4	3	4	8	68.9	44922800.00	44922800.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
33354a8d-5af5-4552-ab32-386355643133	bca3cfff-fd2c-4cdb-8938-c0fef0224828	1	12	12	35.83	25976750.00	25976750.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3bc30441-7c75-4ae5-ae2a-66ec58c55c23	5652f803-3f7b-48a1-a3bb-c49efb6db32c	4	2	8	111.63	62624430.00	62624430.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
e9110ad7-bb47-4d5f-8e32-1749a94b0606	d80c71ae-dc9e-4134-a283-0baacd519864	4	2	8	111.83	62736630.00	62736630.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
d66bf313-2ef1-46cd-8afc-17921caa9af7	657ac676-124d-4b8a-ad65-97a01bfa20f6	4	3	8	111.63	63182580.00	63182580.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4d1d4431-7c5e-48c3-b781-bf89e7001e6e	93ea1c6c-67d3-493f-8e87-7044635ec6f0	3	3	8	88.54	50999040.00	50999040.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3a9c4ce0-eb80-4e49-9f8a-835c64dccc9c	be331acd-7365-49f4-8b3b-dd70ba0b7cf8	2	4	12	60.89	38238920.00	38238920.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
e1e92314-0b69-4c4b-b623-82f995acc471	fb89f077-37de-4765-96f9-af21d7837281	3	4	12	85.73	54181360.00	54181360.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
de6f650e-a396-4121-95f4-706852ac59ec	4956f3db-cef1-4122-bd60-5b8bd1bbb860	4	4	12	113.31	62887050.00	62887050.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2891b161-6811-4f27-a088-87c583859314	32da35ff-4ab1-4fc0-bf33-2b66d8e59db6	3	5	12	85.73	49723400.00	49723400.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
8b627ebb-927d-4148-83a9-82dfec96fde8	04fda344-bf87-4975-be68-bb30af7bf200	4	5	12	113.31	69685650.00	69685650.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
0b9772e4-847d-4f1c-bde6-fb2be2007ac8	191be6aa-65d2-4583-859c-e0079a8f2c7b	2	6	12	60.89	38238920.00	38238920.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
e83eaba5-171a-4352-a7c5-18428902f6a5	646f9cbc-7571-4768-abb9-ba263e833017	4	4	8	111.83	63295780.00	63295780.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
255c632b-ed78-4737-b39c-5019eda94800	454e14cd-a94c-4cb0-94c9-92b62f92f126	4	5	8	111.63	69880380.00	69880380.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
fb6655e6-9f4e-4f07-a2c6-03362131cc9c	a848944c-f0d6-4f2b-a16c-130fbaa578f7	4	6	8	111.83	63295780.00	63295780.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
5281ee71-b248-46f9-845f-88b72ae6b404	f2e24a7a-3c0c-4a57-bf8c-00a95577d28a	3	7	8	88.78	51137280.00	51137280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9e2020b7-6a37-4b9a-b521-ac11aa141d2a	249fb0b6-5edc-459f-8000-eff68f2bcf12	4	7	8	111.83	63295780.00	63295780.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
5523a097-f0b2-46d6-8e91-3138621cb0ba	8503349e-d42d-46b2-99cc-03641f927380	4	2	12	126.32	67454880.00	67454880.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
069597f4-bced-4054-9083-1bb3ed70f142	59055ad1-f36a-4d42-9251-a8251a1db814	2	2	12	60.39	37381410.00	37381410.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
a967f628-ad89-48ad-b78e-265b97ca3623	78db5aeb-3f77-4e1c-89ca-aea131ab10eb	2	3	12	60.39	37683360.00	37683360.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c4454b4b-88fd-45e1-b2ac-5b0f191e05dd	d7352bb8-4831-4472-9546-26a303ddca80	2	4	12	60.39	37683360.00	37683360.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
9b7f918f-70ae-4e85-aba8-7c9d9a809fce	23506212-14f6-4a7f-9022-e76d38712842	3	6	8	68.9	44922800.00	44922800.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
e5cbc2a2-9f2a-4450-84de-a25a31f4219a	4bb55eef-383c-4f28-ad9b-5214eef4b776	2	5	12	60.39	39132720.00	39132720.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
beb7e823-8325-4e8a-8433-945ffd98d60e	c85e8ecf-279d-4d8c-b984-94392724290e	2	6	12	51.53	32360840.00	32360840.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
61a7eea8-8ef9-4c0c-baab-1387b5c646bd	71099118-4379-4e36-a11f-80ded2da184f	2	6	12	51.4	32279200.00	32279200.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2e2dba82-50a5-4060-a5f1-87154a44af9c	9ed1aa4e-f69c-4d00-ad0d-d9d80530e67d	2	8	12	51.4	31765200.00	31765200.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
ef36ce10-b961-44b8-a5cd-c858dd5eb1a3	6858f51f-c850-4172-9b60-6e5972c2e9f1	2	10	12	51.4	31765200.00	31765200.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
1ca631c5-dff5-41f4-a2a0-6e5f8be62e4c	4e30892c-af8a-4162-b99f-6ba5295dcd78	4	10	12	130.65	99816600.00	99816600.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
47342d82-ba34-435d-854b-5b19a1f0b23e	f45cbeb8-9f1a-4577-9df7-c4d7085fa4bf	1	12	12	35.82	25969500.00	25969500.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2279ec45-28a4-46da-803b-f09a7e67b1f9	39568a9e-06b9-4898-96bf-9b0a731ea087	1	12	12	35.83	25976750.00	25976750.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
e61fccd8-0c7c-4f6b-903e-246c87f6a310	bc571f52-413f-4b0e-8688-f13f5f8760d6	2	12	12	60.39	36475560.00	36475560.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4435f87b-7509-47cc-bc78-bd02e9aa91ad	cc82be4c-94a5-4c71-93db-d12b2515384b	3	2	12	85.95	49421250.00	49421250.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3cde6c1b-ee13-4e28-a833-eee4f79e8b42	c17725e6-57c4-495a-8070-54227b2fa2a2	4	2	12	114.1	62526800.00	62526800.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
419c8498-90c7-4b8f-ade5-59f818e7c31e	2f776a6f-7e5b-4291-9ef9-0d8b99c2fb43	2	3	12	60.94	38270320.00	38270320.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
502edd8e-f65f-4de1-b49b-f8ed848ad3d6	dca90294-0959-4d50-8d9a-e17d18579178	4	3	12	114.1	63097300.00	63097300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
cbd57d8d-86a8-42b4-81cd-2ac3c2460ffe	d8e67b01-d50c-477f-ad4e-0af3e21a03f1	2	4	12	51.4	34386600.00	34386600.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
587860fc-c8c5-4ad5-9eb6-60cf00d971e7	dfa98deb-faee-4e36-a16e-bf4f7c5bb605	2	4	12	60.94	38270320.00	38270320.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
438e9e7f-18a7-428e-baf2-858e8d6fb854	d7320fda-fab8-43eb-be29-2225bbfae640	3	4	12	85.95	54320400.00	54320400.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4470717e-2e67-4146-9705-436bf067247d	c03be402-9a84-472d-8bd3-a9c997119833	4	4	12	114.1	63097300.00	63097300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
8b9e1bb7-6106-43ac-acbf-aff9519f326c	0ef6983e-3d9c-4803-8f41-e6fe367a1095	2	5	12	60.94	39732880.00	39732880.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4d5019ff-db83-413f-86e9-6baa674605bb	d022cdd9-cdbc-46d7-a3ce-9a943d50ba5d	3	5	12	85.95	49851000.00	49851000.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2c2c5117-ce0a-425b-bb39-0e45b9ed2873	cf5b6bb5-51e4-4689-afc9-be3325a6a698	4	5	12	114.1	69943300.00	69943300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
2902d621-af86-4343-91fb-a384b6a66311	2a3c8806-cca9-4447-b81a-fa58ac1747ae	2	6	12	60.94	38270320.00	38270320.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
4649f985-6f40-4b04-9b29-fac48f7131d4	da364564-3202-4b4c-9149-c7a9072087a9	2	6	12	54.21	36862800.00	36862800.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
74624bac-c0ac-40f5-8da1-e14aa48c13b5	823dcf4f-ef6d-4ccd-a4f7-68f21aa60fd9	3	6	12	85.95	49851000.00	49851000.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c776a6c0-d59c-4755-867a-3c4b8dfc9835	18bb71f9-6228-4d5a-a052-34b4197fe862	4	6	12	114.1	63097300.00	63097300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3e0ef5c0-b8dc-4177-8916-9ad7c8143cb5	25d5d24c-38a8-4bf8-977a-c1968d85fc55	2	8	12	51.53	31845540.00	31845540.00		2026-08-28	f	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
3695dbf9-ce79-47ad-973b-368dde258a29	6352a642-ee10-4d8a-9d39-5880ed51bed0	3	2	16	98.66	75573560.00	75573560.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ef7439e9-174d-4f13-922d-fa5b3d228afa	6e8d3020-7c96-46f7-99ce-c587e1d049da	4	12	12	130.65	99032700.00	99032700.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
79f24269-c66b-44ea-b781-2c9d05d9203e	329f9326-384f-4b2b-be08-d7f906902a98	3	2	9	100.99	79075170.00	79075170.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6b042e26-88c8-4be6-97b1-c600d6b401d4	5c03673e-557d-4dc4-8c84-b3437d28a262	4	2	9	133.89	98409150.00	98409150.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b70ca8aa-17e7-4486-bb1e-05633e5c2673	c74b0f02-b4ea-478f-bfbf-68bf30306375	4	3	9	133.59	101261220.00	101261220.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
55399580-8b6d-4a35-a13a-24e0785c0190	23ab832f-2d8e-4a14-8a8d-3e1c36ce9123	3	2	12	99.77	76224280.00	76224280.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ef64a216-2965-4d18-94b3-c7a3d2293e49	87d57414-c523-4d75-99f1-7c00772a3cd0	2	3	12	62.68	55033040.00	55033040.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b54051f3-2901-4eac-bd72-98806f0894da	883e4239-1bef-409c-bd44-7587f674d6b7	2	12	12	62.49	54866220.00	54866220.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c9506f03-73a6-4a70-b8ad-0e5c0372e363	b23ebdf3-7ea4-434a-9d9f-a0b0d191df27	4	8	16	130.92	105259680.00	105259680.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
62f93c8e-8fcd-476c-9309-3208fc13c4f3	816cf280-66cc-4898-be1c-29d6664f31a0	4	3	8	111.83	63295780.00	63295780.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
75837089-85d3-477f-bdb7-1caace0b2eb9	5170869a-6b78-43e2-baa4-1f4c3edb9425	3	4	8	88.54	50999040.00	50999040.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
23b6bca8-d1a8-4487-ae20-1b6e23d6c1f9	945d42a9-3378-4bcf-bdf8-0ea9e9596f16	3	4	8	88.78	51137280.00	51137280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
f401b42c-12ca-4c0a-80a4-dbf004782272	38e00713-db67-49e3-a073-4a7d01190c6f	3	5	8	88.78	51137280.00	51137280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
c79d8194-2220-4fba-8000-c76e6f1f41e5	4c0f5ec5-9afb-46ea-a24b-dd13ebdc2b73	4	5	8	111.83	70005580.00	70005580.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
20c11424-c3a8-4eb3-986a-221095bcedf5	a409f9de-a0fd-4a36-b654-f69d4f3055b9	3	6	8	88.78	51137280.00	51137280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
41c5681e-27ad-4032-99a5-131c07cfcdc6	71a5fe5c-e309-4355-884a-0b887eea8dd0	3	2	12	103.38	78672180.00	78672180.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f996a682-dfa3-4fd3-9874-84cc7033c3c9	91050022-4504-4595-9671-4bfda31582d8	3	4	9	100.43	90587860.00	90587860.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b8da7047-987c-450b-9613-1fbaa7ad34fb	2ec4d49d-af2e-4dec-900c-abb8840de86b	4	9	12	130.98	102426360.00	102426360.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c2024dca-6c93-4e73-9e80-d15738535c2e	8ef205c3-4f64-4812-906b-0450d0c2013f	3	9	12	105.44	82981280.00	82981280.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
403a7fd0-8ddc-41c3-94db-c4b394d96cf2	f90765cf-8f49-45e6-8c78-202f09175aab	4	10	12	130.65	100731150.00	100731150.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5974a1dc-c71f-4854-9bd4-2843381b75de	e95d3659-0343-4738-b835-7b7e6ec04cca	3	11	12	105.18	82250760.00	82250760.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cce19893-a6aa-45a6-86e3-6446c10ad9f0	f1dd7846-1859-403e-95d8-eee38ce44418	2	12	12	64.27	56814680.00	56814680.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0596ec8a-5af6-4355-880e-3748d572be0f	d773dfcf-3d53-463b-baaf-878beebabefa	3	12	12	105.18	82250760.00	82250760.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
053df418-7312-43dd-af3a-c5ab82bf9ed0	93207937-9e0f-4d79-b7e5-74bdbc1dd95f	3	2	9	108.48	83855040.00	83855040.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a6a71ba9-1e04-4577-85e4-b77b4f1fd057	49e30d2f-6a99-4bbb-8a13-c29c143d061f	1	2	9	41.93	37653140.00	37653140.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7d91847e-7983-4557-82e3-996d146453c7	41732274-7f63-49d2-a9b9-a361bde44a95	1	2	9	41.99	37707020.00	37707020.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f5b9a561-fcb2-4f15-9447-744f707734a7	6882a799-7f3e-42bb-a2e0-7e0f0f946bc9	3	2	9	107.3	83157500.00	83157500.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3308663d-6e94-4431-8c54-5e66a0d35c71	a490de97-81de-486d-9ccc-b24708f702f8	4	3	9	137.02	107423680.00	107423680.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2b051c54-4d65-443f-a462-593ca81a49b7	7518cb70-7e32-4b26-a13e-c2d7bdb90b35	1	3	9	41.45	38258350.00	38258350.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7c05513a-190a-4e54-8d3d-14453a388869	0dcbb53e-7d18-454c-8939-a14f83cb8b43	3	3	9	107.35	85880000.00	85880000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f72b0959-889e-4fb5-a311-0a2b1ce22e16	48cffcf0-dc4d-493e-8c2e-6370b1f2c55f	4	4	9	137.02	108245800.00	108245800.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
18682ffa-7f9d-421c-926d-d974e331b176	8bc00ecc-e8a0-4407-887f-f7cd379e1e8e	1	4	9	41.51	37691080.00	37691080.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9db5a1b4-8e0f-47a3-81d8-1f04a697ea9f	f4618b2f-989f-4fc0-a770-96a6c89fee27	2	4	9	66.89	64348180.00	64348180.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
76a765a7-b770-485f-9fac-af92c5a3bb8a	a95fab68-2cee-44c2-84c8-4078a324ad16	3	4	9	107.35	88027000.00	88027000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
944f7f9c-0b0d-4f15-bb90-2ac3937600a2	136d4445-6a9a-45f1-93f1-6070671434b4	4	5	9	137.02	108245800.00	108245800.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
21650949-c4a6-41c1-8c45-b07721abae50	7b2f7cf5-b907-4997-903a-d1ded4bcb798	1	5	9	41.45	37636600.00	37636600.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6d025b48-dbcd-4c48-ac2d-0ec76b9c234d	3f434f3f-1c2d-4aa3-81e6-4bf7d0eaad8c	1	5	9	41.51	38313730.00	38313730.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b52a6a87-1ac9-4445-a6a4-d439456d4650	efac6c78-ca19-407d-8e50-a6ae48f3038e	3	5	9	105.6	85641600.00	85641600.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ad53c0d4-353d-4cae-8e5b-4176ecdcb8a6	f07e4dd7-b3eb-4c40-b7c5-167345bb6ebf	3	5	9	107.35	85880000.00	85880000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7de6ddf5-277e-4f4d-82d6-dc856e9f0b02	08b532f4-2e49-479a-a595-83a9da18296d	4	6	9	136.87	107442950.00	107442950.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
17d86dc8-e1d3-4fe1-bc8d-f53a9e402797	59b0d178-9d3b-4689-a3fe-68c79e7b1d9d	1	6	9	41.41	37434640.00	37434640.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c02847e3-6d1d-4f44-8c5a-e2212f595a58	1931f335-aebb-481f-9fff-c5c657343319	2	4	9	66.14	63692820.00	63692820.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0e9da80f-6c9b-415c-8d26-7fdc978d238c	f1546445-ea06-48ed-991b-78a23a23e0b5	3	6	9	107.2	85224000.00	85224000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7247744c-d5ea-4d07-ae2e-ee361182b693	eefd5409-e4c8-4778-b3b1-493502d6aef8	4	7	9	136.87	107442950.00	107442950.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1cd1a722-b05c-4267-b580-fdd77e37cb7a	09780c14-d5ad-4830-8326-1a1a9384b1fd	1	7	9	41.35	37380400.00	37380400.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f97388d8-6fd1-4546-b5da-a4ace5432001	f30b99be-5107-4bc7-9e5b-a321a55546cd	1	7	9	41.41	38055790.00	38055790.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b4c357ef-1d1a-4864-a29c-0c30429aa51a	24274f46-725a-4ae2-bfbf-e9d98a12f8b9	3	7	9	107.2	87368000.00	87368000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b0e72f64-2059-4e2d-b0f4-632156e4280f	2ac7d534-80e2-4cbf-9ba7-75eb34ec572a	4	8	9	136.59	105857250.00	105857250.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ccb67b94-bbd5-4026-8592-bae4440500cd	479d4f1c-00a5-404c-a8bc-555f15e766fa	1	8	9	41.3	37748200.00	37748200.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
24b466c9-4a0d-48df-9a58-eb15b4b4037e	6c866a86-c306-4010-a3b9-93ff75463e3a	3	5	9	100.43	90587860.00	90587860.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7c42cedc-c763-4bc3-a0f2-3d71048d3878	c453bf4c-a9b0-4d0d-82d6-489c93294807	3	8	9	106.98	84514200.00	84514200.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9f04e8c0-a4df-48ab-bc36-34cfe69e5856	ed74b0e6-cb27-4496-be41-9ec3f3d2c43f	1	9	9	41.24	37693360.00	37693360.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
388b29b7-fffd-4c95-8292-ebc05270a37c	410db641-9be7-4612-a768-48ebca66a777	1	9	9	41.3	37748200.00	37748200.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
11b82a39-3996-4d5f-939b-65feb568f2d6	b4abeab1-c3da-4219-9889-827df4b62049	3	9	9	106.98	84407220.00	84407220.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
311496eb-eef7-4bf9-8adf-ae50deedf5db	6f2c9838-925e-4162-b963-68842a9aea1b	2	2	9	79.72	67841720.00	67841720.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7b76a8a2-1b79-4666-b8a8-6fed707e58bd	efc028b0-991e-4f63-a9b2-f8d1b04a7027	3	2	9	102.44	80825160.00	80825160.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cc74f7bc-d510-4114-86de-f790b054a45b	f2a429af-0f1d-4620-b362-8c2a3a30ef95	3	4	9	101.68	82869200.00	82869200.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3a297046-6311-4e8a-9511-f3d37c4ffff3	d533d7b3-00df-4e1c-8ddb-4a9c581bc013	3	4	9	100.86	82402620.00	82402620.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cfaacb4d-9202-4fae-a70e-09924f9abe81	8d1e3854-6f80-4417-91de-5db2eab52e89	2	8	9	38.17	22520300.00	22520300.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a4e3396b-6f86-48da-b821-72ee8eb36c70	ff69a551-73c1-417f-a9fe-83ca03cea644	2	16	16	46.21	41773840.00	41773840.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7f103979-8ed3-41ed-b249-3d3ed6ec3416	4ea44884-b08a-4fdb-8d07-02ea5cf96b75	2	3	16	65.97	57657780.00	57657780.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
93181e8b-45eb-4d16-9b84-bfb10a1d1849	30b4d99e-b7e6-4d5f-87d1-854c6e86b512	4	5	12	130.97	101370780.00	101370780.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d3049103-8637-4a84-8e2a-a6cf119994e3	02e3cc68-0b5b-463f-a399-1f1204c6613d	3	2	9	91.37	82689850.00	82689850.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
59ef45a6-41ff-4a3d-ac30-cbabeb42c699	4efea39b-62a5-4eb5-8f91-8e64795a2c1e	3	2	12	106.08	80939040.00	80939040.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
67deaf75-3428-4720-8cea-4ca040e9788d	957fc184-24bc-460a-9760-07428c906a19	3	16	16	95.06	75667760.00	75667760.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
21ea7374-8006-4a6b-bb95-7084b198b2ab	66182c95-e2b6-4531-b467-8309e4b6724d	3	8	9	99.23	80277070.00	80277070.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e4f3e771-f9fa-4ebe-9226-56c43a7a970f	7cf0f79f-1eff-477d-9053-fdff50d9c9e1	2	6	9	66.75	63879750.00	63879750.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3fae8c10-a38c-4f14-80bf-2c21caa38e59	e523cf84-9845-48c0-a8a4-d221be1082ef	3	9	9	99.23	78292470.00	78292470.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ca01afbd-330a-4fc1-aa67-84e46fbedc25	a8209765-93f6-43af-a61f-cf285d6ac193	2	6	9	66.07	63295060.00	63295060.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8ee368c3-a06e-4793-8078-eb01c15efa32	220d57f4-75a3-4dec-883c-ffa7cf660098	2	7	9	66.75	63879750.00	63879750.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
36b79fa8-1ab7-40ab-9c6e-93ebbcce6918	001fcbd4-fc73-43e7-aefb-5171e7572779	2	7	9	66.07	63295060.00	63295060.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1d828715-0577-40ea-983e-9f0fce7c2f7a	e9c19a79-02ca-424f-aea7-998cbf79e9b2	3	2	9	101.05	88519800.00	88519800.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7f26a50a-c1fe-4c15-b3c8-c53e3a50e85d	8183af05-0b16-417b-bc30-cc3c409ecd78	3	9	9	100.29	89458680.00	89458680.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
89843c08-731b-4b14-90a1-0f36b794af50	95480eb2-b9eb-4bcb-8ef9-29465bbd4681	2	9	9	66.58	63384160.00	63384160.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
51ff6df9-681e-4691-b1dc-e5df4730fb2d	6acb48a5-2fd0-4aaa-8d93-248abb788d80	2	9	9	65.9	62802700.00	62802700.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
823bff10-3d11-4d54-92d9-5ef54aa31b17	14367369-70c6-4e33-b120-605752fef489	4	2	9	133.97	102888960.00	102888960.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
52ae4159-6766-431f-b9d3-b1a392cffa27	9a50f858-59dc-4656-80eb-484b4b8c9c5d	3	2	9	101	78073000.00	78073000.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1e84d7a6-e764-4f93-a6aa-9c34cbab52b8	a08f490a-4799-4714-97bf-e25b7445721a	3	2	9	96.45	76195500.00	76195500.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5af7ab26-4a43-4f21-8fb5-c86781b00c38	676ed52d-536d-4a66-b1f9-cc3c65240635	4	4	9	133.71	105363480.00	105363480.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d7cff666-dcdf-45cb-a083-41a62c078506	efbb98e0-aedb-4b8f-87ec-2a55b788454f	3	3	9	100.43	90587860.00	90587860.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
70d8d4c1-52fe-4e99-8c6f-a679b4502bcc	2c4bdf5d-b0e2-4580-9278-4f1d3dbe5dc1	4	4	9	123.93	100383300.00	100383300.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f1eb567f-2930-4823-9c21-4b014dcd073a	326ddb6d-a10a-42e9-b356-4155d77523dd	4	6	9	133.59	105402510.00	105402510.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
daf8af77-05eb-4d17-8670-2ca428557c96	92707509-ee13-4cd9-8c47-4e648dee4bea	3	6	9	100.23	81587220.00	81587220.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
57d2ce74-b43e-4547-8659-60e0721c155c	e8b97b6f-1695-48ca-a14d-b2ec4ddecd9e	3	9	9	71.27	58013780.00	58013780.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1dc9d770-2051-43ef-8288-95b1fd2e29d8	9bfd7f4b-27fc-49ac-b5da-df4640120170	3	2	12	103.44	80579760.00	80579760.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
83b08675-ebb9-4b7c-87d6-fb32e991d137	febce603-0140-4794-a478-001140ba8c52	2	2	12	65.02	56502380.00	56502380.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f5a2bd12-499d-462e-950a-c393743f582e	d6f98a85-8e6c-4d28-93b8-43e6da52ce9e	3	2	12	106.08	83166720.00	83166720.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
68ea2bfd-4836-4f7b-8ed8-39349897d950	a1bbb0eb-356b-469a-913c-49cde59217ce	2	3	12	64.55	57707700.00	57707700.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
dfc777ba-14c6-40d3-b498-2cec98e9e04d	e7ccea8e-61a4-4441-bde0-3bcab6462a0a	3	3	12	105.3	83397600.00	83397600.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
de90542c-b632-4b6d-a6e2-28372107b14e	d58ada0a-75bb-485e-934c-c9b37a9c0cea	4	4	12	130.97	102287570.00	102287570.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
abc86733-e6a1-4519-a843-c75a4b1f8f66	404768c3-e103-43cd-8a5a-12ef365fc9bd	2	4	12	64.55	55577550.00	55577550.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
624ec598-c281-4a39-9e99-a747c6a00492	57996437-2cd4-4aa4-bee2-31c6728039c5	4	6	12	131.26	101857760.00	101857760.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
14ff0663-fc21-40b8-ba8e-91eae015d89a	6ac54c29-6a7f-41a7-87a2-465758e93098	2	3	9	66.14	63692820.00	63692820.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f31ce6eb-ac8e-458b-8847-bdfdf52da915	25d73016-8181-4ea4-92f8-417cc62a7c70	3	7	12	105.5	85138500.00	85138500.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
19eda775-43a2-41a3-83f7-89c007760565	72a660e7-ee6f-4a36-b52f-87a41cf9d5e6	2	8	12	64.4	55126400.00	55126400.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
327e008c-58b6-4091-ae6e-f7862b70e02a	55e4939c-f36f-4534-aa3f-a9488ec64a36	3	2	12	103.04	77383040.00	77383040.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9d3bd5bd-d0cb-4b2c-b4b1-a725b0c98c2b	bd173b5c-f18e-47ca-ac48-98927fc3f70d	3	5	9	95.77	85522610.00	85522610.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8c391d55-ecc8-4219-ad39-95faa51529c9	eaf9f151-98af-405f-af67-6eb0fe354279	3	6	9	68.52	65368080.00	65368080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5fbff962-6c31-4142-9bbc-d512d279b2d0	e1f8ba9e-15e3-49e0-9dfa-a97ea4873b9c	2	6	9	46.17	44923410.00	44923410.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cb8857b8-5940-4e16-839b-f8f68779de6d	1e33a5ae-675b-403d-97f9-4156f326f8eb	3	7	9	95.77	85522610.00	85522610.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0f7a8f98-ea60-462c-92e8-c8568eea0a2c	64e39c75-4106-4328-8ab5-5cbe6515b3e7	1	4	12	37.99	37116230.00	37116230.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
15470b18-2490-421b-9ba7-5901b4899f4f	b13b5a25-736d-4c08-ac95-7a8d38d9bf60	3	8	9	95.77	77094850.00	77094850.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
68c9866c-3efa-4bcc-8c76-c38782f98718	442f252e-7e3f-48cb-9ef3-a63451bb6aa3	3	9	9	68.52	61736520.00	61736520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ef1f1dea-0155-4887-8a44-19303ae3a257	00a198ca-de24-4f04-a59d-6778d8c4de25	2	9	9	60.66	52592220.00	52592220.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b9a9867c-ffc3-43e5-80f1-d1ba6e80cc82	a41dd6c5-5583-4c0b-9dfa-1a80c0665a00	2	9	9	46.17	43815330.00	43815330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2edadf7b-fb72-4533-97c3-0ee9a56f2c81	45e568b0-4b94-48e7-8a6c-ae3fad801976	3	9	9	95.77	77094850.00	77094850.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2d2fd06b-d127-4f9d-ad20-4d4d16aed97d	14ee215c-206f-44d2-8db4-b7e72f9ce25e	2	2	9	46.41	41026440.00	41026440.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a65d808e-8cda-463e-a893-20b85c8d8b62	dfb5ce1c-d7a4-4091-95d9-c82d5e231b1c	3	2	9	96.53	74231570.00	74231570.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5184c108-84be-457b-ba4f-0c5026fcb629	80edfd75-6be9-4e08-b6da-be821c576eec	3	2	9	69.29	58550050.00	58550050.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a5bb7b06-fe76-4218-8dd7-99cd5071d3f2	8ceebb36-9289-402e-b24d-4b8082ddbbe3	4	15	16	130.24	101587200.00	101587200.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8b4b1cbf-caf4-49e8-a878-e9f8f193b24a	32eb57d4-a2db-4a8a-aa2a-ce7aea546763	3	2	9	102.14	80588460.00	80588460.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3f1f6905-64f9-4b19-a673-2f7521c1a614	bab74b68-64d2-45b6-9c18-d877dcab0234	4	2	9	126.42	98228340.00	98228340.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
360faf4e-f3ca-48a7-8712-22dfb95f30ca	187ca537-1ce5-464c-8daf-f70fd631146a	4	4	12	128.74	99516020.00	99516020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2df20af1-a13f-41de-bc7d-f48501b30c67	02a4661f-c8a2-451a-a619-d89670b2600b	3	6	9	99.41	80919740.00	80919740.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4eb0121a-38d9-4c0a-b817-425b05fbec0a	5c1360ea-d1fe-40aa-a848-3fe38aa78fad	3	5	9	68.52	62079120.00	62079120.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
53fe71bf-a24c-461d-9582-a967d696e4a3	37bcc147-2605-4841-bb46-14fe20d3689d	3	5	9	95.77	85522610.00	85522610.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2bb90621-4203-4059-a97a-7e7c13d0beb5	705fbcea-48dc-4ef1-9e60-04dcc2dc6242	3	6	9	68.52	65368080.00	65368080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9dcac05d-6297-4f62-8f25-42f5211fbfe1	a34cb35b-0c43-455b-976c-2910cb0b221a	2	6	9	46.17	44923410.00	44923410.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d3fc6c5a-0154-4701-a546-052fa894e425	d4f8acf8-6829-492d-9d12-d7e26d04eb42	3	7	9	68.52	62079120.00	62079120.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5f6a581c-fb3e-4b37-b459-877818166340	fce4bed0-d767-437b-8954-6bc1cfb28542	2	7	9	60.66	55807200.00	55807200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0e24d808-6283-4114-b32a-1959ca90fe87	e9c6b8af-207c-42a7-a5c4-0249b34d47b1	2	5	12	63.28	57394960.00	57394960.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5aeebe8d-9c5c-46b3-995b-3ca0d2f5e972	c3a8bd86-f712-4c34-8ee0-9d58d9318d72	3	8	9	95.77	77094850.00	77094850.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d448527c-1098-448a-b8a5-f41ec14c53e0	ae68a4b6-3721-4c22-a739-15214c921a10	3	9	9	68.52	61736520.00	61736520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e90e0018-b07b-4bdf-867d-11c0d83b4890	6188505f-bc7d-48f5-ad16-a46717985acc	2	9	9	46.17	43815330.00	43815330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0cc1a62a-0241-4833-ad89-2e17fbc1edb5	1b694a43-3ef6-4294-bea2-9fa887123d0b	3	9	9	95.77	77094850.00	77094850.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3d251d3f-763a-499c-a6dd-46a07b2f277f	c14da395-1db8-4841-b484-4ff23a64c4b0	3	2	12	107.16	79405560.00	79405560.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
daf55209-04ff-4392-b6b1-0ded16c9a42b	d3e91ee8-e64f-41bf-8db4-e9208016c003	3	2	12	75.24	63201600.00	63201600.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d7e6d573-574d-453b-892e-aa81c6bd541d	d2da75f4-7c6d-4007-bb6b-c691506254df	2	2	12	47.85	41725200.00	41725200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
64222f52-57ba-49d7-ba3d-2db59360f566	11dc26a0-06bb-481f-a719-2b465008e5a1	2	2	12	48.24	42065280.00	42065280.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
79d281a2-667b-408f-a258-cc55044235fe	1a11af39-d290-4f0c-b8e1-5a4cca5b2840	1	2	12	43.19	39734800.00	39734800.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
36ea1418-17ec-4c7c-958c-a528d635c494	259893e7-e4a5-4ce1-9dcb-e5a93d94e98a	3	3	12	106.25	83087500.00	83087500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3594633f-0c62-4243-ab3f-3f6a333c6c03	3d6bc82d-5a23-457f-883a-440623a9aa3e	2	3	12	47.06	43906980.00	43906980.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4822e319-f43a-4d7c-ada3-bd7ab05b9ba4	693655fb-2452-4e1b-824e-b1c60aecc7ec	2	3	12	47.47	44289510.00	44289510.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5da7d38e-f211-4ab5-a99d-77ffa1b50178	e0e2c0d1-ad77-435a-9d31-41058b863a31	3	4	12	106.25	83087500.00	83087500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
75568d12-f79e-468a-9c90-0d28ec05441d	56beaf5d-356a-4a54-88eb-90d4116c404a	4	5	12	128.74	110330180.00	110330180.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
647abaee-90e1-4ee7-b864-5202097250a6	5240f19f-73f6-4381-b113-986dd9fa2820	3	4	12	74.18	68913220.00	68913220.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2c4b63db-3246-4f0e-9f7b-088217222734	44a610e8-69f6-4dfe-ac58-be84da159312	2	4	12	47.47	45666140.00	45666140.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
efd9319d-e3fc-4238-bb60-0e415e2972b7	46eb341f-4244-4011-88d7-aec7e0d459e7	3	5	12	106.25	91906250.00	91906250.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
81998183-d462-4de9-ae9a-0a378e354ecb	2b994bae-b4a9-4fc5-9ecd-72ace97534d8	2	5	12	47.06	45271720.00	45271720.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d508a0f8-0338-4d58-a52d-188f868a770e	1f2062b7-f899-49a8-abfa-4c712afda597	2	5	12	47.47	44289510.00	44289510.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
dea40932-8dd7-4d50-a30c-3da6d8167d15	6429ddb0-9f40-40a2-9510-bd0e2383a3d3	2	5	12	65.42	59532200.00	59532200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
219adf03-8c4d-4e0e-9836-f1feaea5a364	14265a7d-9b10-40c8-b665-cdb3960e4cab	3	6	12	106.25	83087500.00	83087500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
955a2657-ec49-4f4e-9dbd-1ffdab33fbec	46030156-b26a-47b9-963f-8f23e884fb80	3	6	12	102.41	89608750.00	89608750.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
568aa0a7-6e41-4872-a954-d3869e4193ff	c3825ca0-bd68-4b9a-9516-d87ddbdebf8b	3	6	12	74.18	68913220.00	68913220.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1cfb7fb1-3446-4075-bf1e-e64069ac7c06	d1ad8e7b-d6d9-4676-baa4-b489d0bed49a	2	6	12	47.06	44848180.00	44848180.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b0781b81-2b7c-494e-82ec-500e42056ce7	c4e8bf8d-41c8-4c64-86aa-de47e7ae5f95	2	6	12	47.47	45666140.00	45666140.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6e4ce6a6-f81a-429e-b6b7-ee9a8a5c4fd9	4dec3254-5537-4844-90a7-af438809ed0e	3	7	12	106.25	83087500.00	83087500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3af2bc17-4538-4e72-b847-a8b87c3d5228	76728803-b768-449a-bb4c-85be3f486cdb	3	7	12	74.18	65352580.00	65352580.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
48dbb713-1fb9-4de7-95b3-b74fa50392bc	4f64c7cf-c0b3-4cb1-9fe2-26df8bf343a0	2	7	12	47.06	45271720.00	45271720.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7a91f38b-2f13-4955-aade-5be1d767c140	5c1fe81e-47b0-4bf8-a6ac-a4f39a8aec9a	2	7	12	47.47	45238910.00	45238910.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
47d9fd43-4079-4ff8-bbb0-fa56da78cfd0	3bc33578-a704-4bff-a2ec-1f743fb6f08d	2	7	12	65.42	60186400.00	60186400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
bf90e2e0-98df-413a-9b62-c5eed70a5aaf	9fccb6ed-65fa-47bd-a7f2-82946dac77f6	3	8	12	106.25	80962500.00	80962500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a877cde9-0cb2-48a7-8ab1-47e159d233c7	d94ea667-f258-4865-9501-5b8b001b59fc	2	6	12	63.28	54357520.00	54357520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
81fd0395-7300-41e8-aded-e456bc4a0df4	3d582b18-e791-4862-b68f-edc6944b907b	2	8	12	47.47	44716740.00	44716740.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d9346637-3605-44d9-ab32-d2913981467c	ce283a71-c77e-4212-8479-c2971b287f5a	3	9	12	106.25	80962500.00	80962500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f098d939-77b5-4f65-a26f-4762695b008d	5d0b723f-d924-4421-bddc-f6c83ed88d71	2	9	12	47.06	44330520.00	44330520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
546d38b6-43dd-4445-97c7-8916a2e8ff32	c856b200-4d88-491f-883a-787f3fb4877b	2	9	12	65.42	57046240.00	57046240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f5e454bb-52c1-4564-bd81-18e6c713d1f6	fced2f17-01ec-4c3c-92ab-860cda3797ef	3	10	12	106.25	80962500.00	80962500.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4e088ac7-0691-4c1c-8ba0-720b020b4382	cbbc0776-cb2a-48fc-9780-95d08952a5b8	2	10	12	47.47	44289510.00	44289510.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8f0f9dd8-43c5-436c-9597-654fdb95348b	928fcadb-1d75-43a8-a811-2c07495555fa	3	9	9	100.62	85225140.00	85225140.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6489c8ce-5c5d-4af0-9e07-6d757134c9d3	39fbb745-49cc-4184-8cce-4e7ad232ca44	3	3	9	95.77	85522610.00	85522610.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c4685eae-e647-4697-8ce1-66e3e7527049	c7f9110d-8382-446b-a3fb-c4736208c19f	3	4	9	68.52	65368080.00	65368080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
50969599-f7ea-4416-bb91-c55b103c768f	c35ed53e-7c8e-422c-8cf1-a58bba712b9e	2	4	9	45.74	44550760.00	44550760.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c300c970-32d4-49bd-a037-7feb6ad41a88	3cc16672-c9bd-47a1-84da-cabccf2f3353	4	6	12	128.74	99516020.00	99516020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8cc1ace0-c515-4f4e-995f-2ac2691ce1a9	3fee215f-05ba-4098-bb17-e66c49698577	3	12	12	74.18	63498080.00	63498080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
77321ed3-4874-4d7a-9b2b-141c2fa5c9da	1986ab6e-fbba-408a-95e4-abc23a114152	2	12	12	47.06	43671680.00	43671680.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0fc5d7e7-49c5-47c9-ae64-7d43254ed745	aa7cea8e-2bfc-42c3-a12c-b1844d337f9e	2	12	12	47.47	44052160.00	44052160.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cbad65c9-108e-4135-bfd7-7637cec47e3c	1e7ad8dc-4086-4c10-a1b4-5679355d357c	2	12	12	65.42	57046240.00	57046240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1ab0c28c-6f90-466e-9143-121285dabb27	55243df7-3f9a-4c40-be0e-59c463a50f4d	3	2	9	101.08	77427280.00	77427280.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
db524306-38ab-4680-8781-8f0d9b8abd69	a65c7710-204b-42d4-aea4-23290a491eb4	4	2	9	130.21	95834560.00	95834560.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
57172b03-b57f-49c2-bc54-7286d766888c	a71e6e9f-0c6b-4c5f-8952-7804307336c5	4	3	9	129.45	100582650.00	100582650.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8705f954-52e6-43da-bd47-6ff72be59e99	64aa9281-33ff-4a72-9ede-f7f46804a47b	1	3	9	37.99	36736330.00	36736330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ab7de0f5-cf34-462c-8529-f23caa1775a4	f0fee512-9df3-40c1-8218-d3901a9dde6c	4	4	9	129.45	111456450.00	111456450.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
41b95103-7653-43e4-aee0-19c5ff128e4a	74793346-a622-4cc2-886b-259b2980bd1e	1	4	9	37.99	36736330.00	36736330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b9dfd07c-5806-4245-adcd-13e8f8961f9c	fc7a7c4e-01b4-49b8-a775-da2e4b3040a0	4	4	9	129.81	100862370.00	100862370.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
fb2826bc-7970-4327-810b-8e3e45cf7783	6d78f1ad-1d1c-4ea3-a7fc-0f5b9ced1613	4	5	9	129.45	100582650.00	100582650.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f801a4b3-57ef-4e6f-8d71-941e6fe3e909	1ec75f82-1636-4e22-8d5b-1511c4a2c025	1	5	9	37.99	36736330.00	36736330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b3c2af7c-7bcc-4066-8207-ddc586d20a17	e0b5407e-dfde-42ee-8447-115a76d259a3	4	5	9	129.81	111766410.00	111766410.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
70c6fec8-d41c-412a-b439-6754911b71f9	5ab5b594-a97d-4658-97f1-b51465c7d083	2	7	12	63.28	54357520.00	54357520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
71191075-25f4-4166-841a-89f1f4b2510d	ef109498-84dd-40be-bfbd-46b620eeba18	4	6	9	129.45	100582650.00	100582650.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1d6685a5-a3e8-4c27-a0f0-ce368cb704b6	8bd6f363-1461-4b15-a01b-2f1f6317c5ed	1	6	9	37.99	36736330.00	36736330.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e9c6d28d-f8f3-4ab8-b3f4-d0d7c5bbf59e	48ef95ef-9713-4426-8db9-781c5c89e7d7	4	6	9	129.81	100862370.00	100862370.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
139dbbc1-c9f9-4cd5-a976-3c779f82df54	25afaf6c-c52e-4c58-bfb3-89afaac6dd1d	4	7	9	129.45	100582650.00	100582650.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
52e19024-838b-4a2a-9549-33d29826035a	40594b9c-8c1b-456c-934c-9d673dcbda5b	4	7	9	129.81	100862370.00	100862370.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e30deace-ced0-462f-8dfa-cf2f3a12ba37	d7352f5c-9d6a-4022-b1d1-afa6fa21052b	4	8	9	129.45	99935400.00	99935400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
defe6b30-e21f-4d31-ba67-670699d373f6	97db5747-9c64-46d0-a524-34a01698808c	4	8	9	129.81	100213320.00	100213320.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5baab489-d624-4fc9-b281-4cee57332a82	5ee2eea8-1455-4ae6-959d-2219914feb61	4	9	9	129.45	99935400.00	99935400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7bca2722-d2e0-4aa1-995c-96a71469ca7f	555df86d-5634-459c-9499-3ecd19fd10f8	1	9	9	37.99	36432410.00	36432410.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e246cd7f-51c8-461e-9c0e-e26dcf85e2b9	3e4de18b-ff01-4a61-9e25-8a816d8d92cd	4	9	9	129.81	100213320.00	100213320.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
32713122-2897-47ba-9f5c-194e16fa5941	3c4e9709-5f44-4054-9637-a9d8decc1e51	3	2	16	95.42	71565000.00	71565000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
048cfaee-c149-4f33-9606-280216271b52	27991f61-156a-4777-9d15-3718a3251a86	2	2	16	64.55	53770150.00	53770150.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c8ddb84c-89c7-44de-aa23-3d03f5837e86	7624eb33-fccc-462e-9708-61fcf024c5a5	2	2	16	46.2	40425000.00	40425000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4d399e23-af6f-4af6-9042-5ace315a1940	a8ce5bdc-6c64-464f-8c9d-275d1fc60a9c	2	2	16	46.2	40425000.00	40425000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a3b0fce7-fe20-4106-a1a4-dc6bd268b272	9138c6d3-54fb-4d1c-a8b0-f603d3440a00	4	7	12	128.74	99516020.00	99516020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
785b0bb0-06de-4fd7-bcc7-6384f633165a	e637ccf3-0874-40ba-b1d1-eb0ad6341266	4	2	16	129.15	98154000.00	98154000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b9a87306-9340-46c8-9594-f10a375f9060	46672b40-8785-44e0-bad7-c3beef83ad2d	3	3	16	94.7	73013700.00	73013700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
67bd7d68-79a1-438f-ad04-847e3bb52626	972053d3-e61d-420c-a38a-061fd5e5932d	2	3	16	64.13	54767020.00	54767020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4837dbf3-8be3-4fdc-bc1c-894977d8b84f	21107bd5-c371-485d-9cef-67cc58d3d71b	4	3	16	127.79	105554540.00	105554540.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0354f4a7-28e1-4b34-b737-90f836323879	db851fb7-9ad3-41c4-9208-ff95e8ef290e	3	4	16	94.7	80873800.00	80873800.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8e6e73ff-e6c2-42ce-b997-6701e6f3664b	a8cee5d8-5cf5-43fb-a83c-ae2e47fc549c	2	4	16	64.13	54767020.00	54767020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5c963d48-2f98-4cae-a842-a4f0d30b4f5a	5383f6f0-867c-45d9-80fc-b6e1a74a5cab	2	4	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
69ea16bc-4eaa-4d21-9b4b-d52802a93c85	8c5d0eac-1e56-4b38-90c0-11e5ec117f13	3	8	12	102.41	87560550.00	87560550.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ba7a9ec7-c7f4-4923-874a-a7a5a5b3ba60	c30e0b05-a850-45a6-ad01-5ef0c12bc13a	4	4	16	127.79	109388240.00	109388240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f87410de-9af7-41f9-9a56-86a34a495505	bc7be4f6-6082-482e-9673-e1b3d305bdec	3	5	16	94.7	73960700.00	73960700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f7fbe55a-ac1b-4d0b-87e4-a74412730fd6	9994fa27-abab-4c30-8aa8-06492a993445	2	5	16	64.13	58486560.00	58486560.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7edb77d4-c7bf-4b2c-a8d9-333030c2835c	ccde293a-9ad5-48c5-be3c-d76a932618ca	2	5	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8b71915e-5d7b-4eb1-88e8-82cf7aabbe9e	194b7e0b-3cdf-44fc-bec5-4239ecf1c9eb	3	6	16	94.7	73960700.00	73960700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9def2ccf-82a2-49d0-bd10-72e7b429339c	3ef78489-3e13-4ea7-a79b-7fa3b4981f8c	2	6	16	64.13	55408320.00	55408320.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
76661202-c9e7-48aa-bc79-03cec1ffd610	f9eddd99-06e3-4cef-979d-ee87a2b50d3d	3	3	9	68.52	62079120.00	62079120.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f00d4806-e923-46cf-9c9c-204c6397facb	7d8292a2-e75b-4a53-9c3e-714a1a51380e	2	11	12	47.47	44052160.00	44052160.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
34ffe5b0-814a-406e-b8fe-843a1baafd29	e7c951a4-1bf3-4c66-a4da-763a890559f9	2	11	12	65.42	57046240.00	57046240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
2a110d19-b544-4aa1-916c-a6f5465f9e57	4c1f1f35-3efe-43b9-a7e1-362e84110eef	2	2	12	63.97	52327460.00	52327460.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
aa7bbd33-45ad-4c99-a7b5-03dc1a5d1b56	b4c5963a-649c-4837-912a-40523a614049	2	8	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f379be89-ec44-4e89-b1d6-516cdcca43f2	6654e497-8df7-4a1e-8345-2f89eac1f6b4	3	9	16	94.7	73960700.00	73960700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
cfbd430c-7b2b-4dc1-9134-c821f2374a84	980b7d50-330a-4478-8515-a9ea19fb7d60	2	9	16	64.13	55408320.00	55408320.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f6fbcb8f-cbed-49cd-80e7-eb95c7b70325	38002375-dc10-4973-a9e4-681156fbb52e	2	9	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d720a915-8815-4219-9b72-042389123367	be52b65b-a7ca-4128-8b1f-87bf5536a37c	4	9	16	127.79	108110340.00	108110340.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f238004f-5683-41a8-a8b7-db6b417a4fff	5f1ebe29-36dd-460d-af0c-39c3e31b843e	4	8	12	128.74	95010120.00	95010120.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
fe3eaccc-2862-48b9-937d-774d6c9abcdd	eaec2185-9e74-48c8-b2f6-110456c4eade	4	10	16	127.79	95331340.00	95331340.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
489a805f-deb1-4301-8955-6a75e0fcb328	93dab144-21fc-4150-a328-94e926a602cc	3	11	16	94.7	73013700.00	73013700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
051ec34f-b3e3-453a-a510-7287e7ce25f2	79d33a18-d8d4-4095-8f6e-90dbee484e4a	2	11	16	64.13	54767020.00	54767020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
489bd590-0fd0-4cf1-b001-7d81677c2155	c09fe11f-dedd-48f2-a1e6-bf33cb86e55d	4	12	16	127.79	110666140.00	110666140.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
efef8e1f-a30c-4693-8f96-d8a920fa152b	b3abb17b-aa86-4426-b88e-1c53f0109efa	3	13	16	94.7	73013700.00	73013700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0b98ba5b-b8f7-4f86-890d-48ac75831993	365a9697-c3fa-4d59-84b5-169b9e444115	2	13	16	64.13	54767020.00	54767020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7fac461f-da3c-4daa-a402-e7bc8846daef	55fcbf52-8c1e-433d-a220-f72959b6c2a6	3	16	16	94.7	72540200.00	72540200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
05571304-b48b-43a2-a186-c6f5f2e57fcb	8ec6ebe2-6824-43a3-86d1-ed6537f9407e	2	16	16	64.13	54446370.00	54446370.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a792d266-4f98-4f48-a1b3-5889ff5848fe	a1d8327c-767d-41f7-a368-e8022b3bb628	2	16	16	45.28	41702880.00	41702880.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
753ae4a7-063c-437c-b2c2-6b9349db313e	abb6c976-8674-46ba-bad5-3ca695d813e8	4	16	16	127.79	101209680.00	101209680.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d6db753d-8183-42b3-80af-b83889f13aee	7a0e25e3-08ab-45f6-9f40-53a4ebd93246	2	2	9	46.72	42827561.00	42827561.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
594dce49-2101-4d58-b32d-d6dcaf029a6a	53f9def9-cec2-4024-8fbb-02889245c269	2	2	9	66.42	58436936.00	58436936.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
eaae3beb-d023-447f-a174-2d55b54c1dd2	49ba4dfd-9096-4fce-89e0-17b04a3be581	1	2	9	38.89	39483165.00	39483165.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
76c9a271-fe0c-4738-a277-6cd26b35d356	b18227e9-e7d4-4228-9efd-3c2e6337996c	2	2	9	49.59	46100931.00	46100931.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
159c509d-025d-45c4-af41-4f361cbf96b9	4caf9d50-50f2-423a-a465-7ed67157881f	3	2	9	101.31	85867967.00	85867967.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
15abcb7b-a403-46d2-8cca-b519d4bb302a	30445ba5-3cfc-4f3e-9b58-cd3c77047d9e	2	3	9	66.2	59953413.00	59953413.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0638b7c9-697f-488a-806e-f88f8e373d47	6ed6c6f6-1c59-4cd3-a65f-00f76af9e5b1	2	3	9	66.02	60805159.00	60805159.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c0a3b2ad-0a58-4b68-adfe-b6c27924c352	1ff22b2d-ab35-445d-ae65-b2f1370e1b4a	1	3	9	38.28	40951855.00	40951855.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4d7a96f1-3d69-4b0b-8408-37e78a20c683	0b88168d-29e5-403b-887f-0aaa10e6c038	2	3	9	48.97	47546874.00	47546874.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
96f01dc9-0203-4e5a-b922-523a989f328e	d63e6837-eb9a-4194-ae9a-1bcf3502702c	4	9	12	128.74	107755380.00	107755380.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
28d8216d-3aba-431f-8c25-7c77d17f5bcc	72ca072b-b087-48aa-912f-80b8f91ceb31	3	3	9	100.85	89625737.00	89625737.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
64b9eac9-dce9-4973-9a7d-17d9e15edde3	97a359de-0006-44a0-959b-e836850bcca1	2	4	9	66.2	67301613.00	67301613.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
798e1733-da82-49ea-8eeb-50f2b702f6ab	2df1d61e-a75f-419c-bb73-94bbb9b8da75	2	4	9	66.02	60805159.00	60805159.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
44030496-923d-4558-b8e1-e79ced165860	1fe82cd7-8d34-4d3e-b5a6-dd9d3d85c12f	1	4	9	38.28	40454215.00	40454215.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
48aac75e-95c4-4e7b-908f-ddfc237676a8	8bc2e26d-f011-44d1-81d6-16172fde7a7c	2	4	9	48.97	51807264.00	51807264.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
aaf9cfa8-5b26-4284-8b66-6eae4d76f2a3	2d6ec32f-0cf9-44a4-8b5e-5072adc5da3f	3	4	9	100.85	89625737.00	89625737.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
371d8a53-e86d-4964-9d07-a15839ec10fb	51d1a380-cf08-4633-8773-ac4c0be63124	2	5	9	66.02	68133379.00	68133379.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9b9f1c4b-9624-499c-b669-5b6764dc0c81	e237c7ae-807d-4419-90ea-63cbaae3fdc5	2	5	9	48.97	47546874.00	47546874.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
12294664-787e-4f4f-b115-1b6a5285ca9c	82a9d82e-2484-4753-b954-ead598c9a392	3	10	12	102.41	79060520.00	79060520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ecb438f2-4a57-40b0-89d3-13072dfe0b3a	664d34d8-e7f3-4e4a-90f5-4c916cf2b4b9	3	5	9	100.85	100517537.00	100517537.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1932d9e8-6bd9-497a-bdad-7adf68e0b672	19d5e240-b325-4c6f-bf6c-60dc9be1d294	2	6	9	66.2	67301613.00	67301613.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5ee262ec-2bf3-4e55-8429-e744d66405a6	eac46b01-0e17-4b35-88d8-225dc2b6532d	2	6	9	66.02	60805159.00	60805159.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e91b0fdf-249a-49e5-95c2-6801fd8b9913	19499233-b85a-488f-9be7-969e8a99b00a	2	6	9	48.97	47546874.00	47546874.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d92c53ef-ed98-4100-af41-b314e1ee31c2	ce9a7c87-f11b-437a-8d31-27bb6955fe48	3	6	9	100.85	89625737.00	89625737.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4e62d4ce-4836-4341-a9d7-f72c28a5ad56	6836c322-f5ee-4f7d-8dab-26c397e271ce	2	7	9	66.2	59953413.00	59953413.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
34342e13-cc3e-4766-a56a-c6eee5b15156	ebda064a-7d42-4929-ac56-d689b3ad20c9	2	7	9	66.02	68133379.00	68133379.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6a8be825-93f8-4fa5-8cc0-c724fbfbae32	c235276c-4865-420e-9913-d02f9dec7b1f	2	7	9	48.97	51807264.00	51807264.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
eff79ec5-201a-4548-86f1-0246935db1d3	73b95da6-11d6-471b-9788-c6062dc1dd37	3	7	9	100.85	89625737.00	89625737.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
96e17eea-eca7-4375-9402-1143eb5c8829	ea6a7c7f-d799-4ff9-a471-c9f9005265d8	2	8	9	66.2	59622413.00	59622413.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
68d35167-8983-462d-8b46-aef26b1a1e77	7ec5df63-e3d3-47a7-a86e-d28a3980e5a2	3	11	12	106.25	80431250.00	80431250.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
7e91617c-3e7b-4158-95c5-33fc9cdbd298	064bd160-0daf-486d-96f9-47e38935d7b2	2	7	16	64.13	58486560.00	58486560.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
37cb2ccb-f424-4ff2-8706-471695e10f9c	883626e0-6a2d-4cfc-bdc3-7d19d828810f	2	7	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0abbca57-4abe-4123-9f37-1800891b8390	6e718d60-88af-40a1-8654-ab004ae07840	4	7	16	127.79	104276640.00	104276640.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1f1fdad7-fc26-4f4a-a7db-b3e734545f36	480097a7-e3d7-4fb5-8bb7-abbd013213be	3	9	9	100.85	89121487.00	89121487.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
39464e35-231b-429b-91ff-466e96c440bd	fef6885e-f387-4136-bdbd-d929051af1d8	3	2	9	107.77	82228510.00	82228510.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
250d8048-567a-4823-bbc5-aa1f05a0d8ac	4e303a87-6ff7-43a4-b792-849b99f0190f	3	2	9	107.15	79398150.00	79398150.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
ca86999f-86d9-40fc-833b-ba9bc6d6b547	d61e2731-6d30-4010-88ee-a29dee21a02c	1	2	9	42.66	38351340.00	38351340.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3a7fec46-447a-4b5e-a95a-59de4938fc05	08162dc0-794e-4f92-833a-6e451e285ee3	1	2	9	42.58	38279420.00	38279420.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
dadbc7b3-e56c-440b-a73f-c3becba6874a	1969a4ed-1261-4011-9e4a-e1c28f9ae41e	3	2	9	108.6	82210200.00	82210200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c624c772-d95b-4341-a3fd-9a12505a0b8f	b5224c44-7603-4660-982a-4342f923f09e	3	3	9	107.1	86108400.00	86108400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f2dccfb4-89e3-471d-a0c8-e210272a001e	65a75ceb-7ac9-4b82-894c-465a6bd3851c	3	3	9	106.22	83064040.00	83064040.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
845f53fb-2c48-4a5c-96ae-eeba5cef61d1	4f740f68-fc3c-4a67-bd34-5d01476037b6	1	3	9	41.89	40340070.00	40340070.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
246caa9f-bdd2-4e2e-9d4d-1554e4375b92	ec2840c8-773c-4885-90ea-3b6cb07a7ff4	4	10	12	128.74	96941220.00	96941220.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c23ac293-3e4c-4e20-b23c-e03b9500ef39	812ac717-84c2-438d-a7dc-6b8e919a0f0e	1	4	9	42.02	40423240.00	40423240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
bd534698-5e9e-4a1e-86b1-7ef9ff71f702	1adc45cf-83bc-43fa-ad62-3fa0641f99af	4	4	9	135.79	115964660.00	115964660.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
07618a60-b99c-4aa6-ad0c-0ba50fbcfcc7	fb56324f-a492-4111-91af-864e6ed976ba	3	5	9	106.22	91880300.00	91880300.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
efd3081f-e3f4-4de2-9e87-443a93485075	1b5134e0-6b91-40c5-bf9c-7f2f8065b622	1	5	9	42.02	40717380.00	40717380.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1e9bdebc-7f12-4235-9871-f179158585d6	d3dcc7d1-2d16-460e-8b2e-7fc88eb48feb	1	5	9	41.89	40340070.00	40340070.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
08bf288d-e29d-4ceb-9ed1-2c2bbd9abde9	d5232197-820e-414d-b323-0b15b528d952	3	11	12	102.41	78548470.00	78548470.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
74b9c9bc-9012-4b6c-a60d-b17aaf51a096	bc402134-f84c-4be4-a150-38677cb71a90	4	5	9	135.79	104558300.00	104558300.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6ac36d9d-09c7-415d-9520-698a15d7d9e4	1bb92de3-7086-49fd-a96b-c82221597c9e	3	6	9	107.1	86108400.00	86108400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
db96d2b9-6b49-4e3a-ba67-f81500338bff	ab8a60a5-6680-4f5e-92e7-0950302ac307	1	6	9	42.02	40423240.00	40423240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
04b730a7-a5cf-46ab-afa0-42bf553004b7	13e3b37f-d45b-491f-ae1f-aa909c016d08	4	6	9	135.79	104558300.00	104558300.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8fdcce84-82e1-4554-a20e-ba76225df880	c743c8e3-9b58-4d06-81ef-4dfa7cba5b8f	3	7	9	107.1	86108400.00	86108400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
da0d77ee-7f46-4150-a8a9-1d52cd6ade6d	1dd57580-a153-4b76-8b5b-23585dc08dc5	1	7	9	41.89	40340070.00	40340070.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
92b857e5-4cd1-43f2-8fbe-5d95c8712d77	f37dcf14-bbe5-4bc8-8f7c-364ecfca2340	2	11	12	63.28	52775520.00	52775520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8ab58219-f4f4-4b0d-b951-3f02ac4b2ec9	6e11c88c-e096-4b14-8102-2262fb42eff8	4	7	9	135.79	104558300.00	104558300.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
295e2bf4-c376-4535-92bd-26f6b763e126	83ce84cd-b8c6-4151-bb74-199e1f70fda3	3	8	9	107.1	85572900.00	85572900.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9653543f-6a85-4e1f-b948-50a1c44d5d0b	6152d942-0b48-42e8-9788-d7fca403b4dd	1	8	9	41.89	40214400.00	40214400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f24a18de-610e-4768-be4b-80618d0d6083	76a73675-9a80-4a0c-a065-ca0c3e4340ff	4	8	9	135.79	103879350.00	103879350.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d5a960ee-4ef4-4137-8074-a1d35fe4830d	273aea4a-3ade-4ece-956e-c222b82669f6	3	9	9	107.1	85572900.00	85572900.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
306a63d6-d853-407e-8543-b89a6d32c9e2	05596ff9-7a8e-4e08-bed9-f744528635e8	1	9	9	42.02	40087080.00	40087080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
67a33d91-ec49-4e70-b81a-c3cc827339c3	fb1c7e71-38b7-4c62-9d01-47cfab880f76	4	9	9	135.79	103879350.00	103879350.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
282b9b6b-b7fc-47ec-9e0c-f7a20040c9a8	0e0796f8-5d3a-4698-adcb-f2b20ed5c9d0	3	2	12	102.65	77192800.00	77192800.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
95dc893a-5471-4699-b21b-21054f3dd969	5e02f979-15a0-4759-9e51-94cec74d62b0	4	11	12	128.74	96297520.00	96297520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5506a0e3-1070-4317-93b5-5ae86ae0da07	e17f55ed-5253-48c8-bd07-bb991a227d17	3	12	12	102.41	78548470.00	78548470.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
db783a27-c159-42e0-b281-6b9e46c260df	7bd32049-ebed-4f7f-8e6e-f7529088e699	1	12	12	37.99	36432410.00	36432410.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4c7698a8-8b3d-4f64-bb4a-9b38519cc291	d044484d-2086-434c-b908-07649eafa54a	4	12	12	128.74	96297520.00	96297520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e484d16e-e260-4723-aec8-16f8d92f059f	20d857e7-f06c-45a6-98f7-db5bc4369445	1	2	9	47.82	47699882.00	47699882.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1c3496a4-870c-4746-8533-495aa1b9a7ad	af08ee32-64df-4c88-b657-11e8897061b1	2	2	9	66.77	59038534.00	59038534.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5be1a23a-1c63-4914-8487-9d1d7fc5a573	6ea49acf-dfa0-487f-ace4-8b79c478017c	3	2	9	74.89	66989554.00	66989554.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
bac38efe-f14e-471d-a1a0-32cb80b1a07d	5fe0dcd6-aed2-4eed-be0c-183abdb5399b	3	2	9	80.25	70362371.00	70362371.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c646a12d-85a8-4284-9ec3-0e4026b0d7d8	3a4dfbfc-0c22-4ff0-b8ba-bcdd859c0206	3	3	12	102.41	81108720.00	81108720.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
553cc051-1b8b-4cdc-be6f-3cb9fa5b53f7	852a34bf-bc39-45c8-93f6-3724b71687f1	2	3	9	62.73	58415079.00	58415079.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e951d7c1-0a62-4f73-a46e-8b1b3eb7336d	bc98978d-0014-48d1-bf95-07f763edb007	2	3	9	65.74	68148658.00	68148658.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c0ea4d60-7ed5-4fbb-b3ed-e125a81acc67	a32277aa-9fe0-4560-ad88-a296d45d9d0d	3	3	9	73.92	69172798.00	69172798.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6334d49e-c1b2-4710-b486-e7fbb1c00c29	aaccaeb9-a064-40fb-a8c9-0073cc2c301a	4	6	16	127.79	109388240.00	109388240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f95ca790-d00d-456d-803a-c8990f25b50e	a43a230b-df79-4556-990e-f350ea484202	2	9	9	66.02	60475059.00	60475059.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e97b439d-feec-4dd1-b714-5f561eeca21b	17cdc423-a439-4d9d-82ca-31b2fa61991d	1	9	9	38.28	40262815.00	40262815.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5a09ec05-46cb-4b2b-a16b-e2654e0567f5	c3d89f4b-8ed5-4f98-b573-7fbc0eb4c4f8	2	2	9	63.94	56610612.00	56610612.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
21c22b5a-7b5e-479e-ab13-991ae832da6a	07c19e89-e09f-4592-89ce-582487a70b6f	2	9	9	48.97	47302024.00	47302024.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4abf84d7-e847-4815-9d81-e5d8073c023d	ac018263-f68c-4b7c-baf7-fdddd8b7af07	1	9	9	41.89	40004950.00	40004950.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b454a376-7e32-4e5a-bf98-6bf7eec9cd55	ed90d165-cfbe-489b-91cf-6c79ac34d44a	3	4	9	79.16	82177776.00	82177776.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f3a46fec-be0b-4e43-9681-11436e27b6d8	66b5d4da-8908-4fa4-8667-81c5f272c299	2	3	12	63.28	57394960.00	57394960.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
758e5220-955b-4241-8daa-96f7d95ae482	82fde716-a5c4-4be7-b84f-4beef57916b6	2	5	9	62.73	58415079.00	58415079.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
aabc3604-ccf3-4d20-adf1-0e69afea4a44	0f61f4ad-a615-4581-849f-9039b0d3654f	3	5	9	73.92	69172798.00	69172798.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
bf4d789e-e72e-44c8-b85e-517a98bf6b89	ea60d60d-5d70-4478-b51e-d5961964413f	2	5	9	62.94	65389038.00	65389038.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
80b8018f-24b2-4b68-8389-6a0235def121	63fe9447-635e-4753-a9a6-e75b17dbc3ea	3	5	9	79.16	72678576.00	72678576.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
810c9c28-dfbe-4b70-84b6-eea204b1d913	be2bfd9a-162f-4bf5-9300-f41a6303a801	2	6	9	62.43	65076844.00	65076844.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c01548ef-ba65-4a48-8f86-fa8153735b69	b6e49272-e4ff-45dc-8935-b9b2f962f5ac	2	6	9	65.74	60851518.00	60851518.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
33d31c23-f3ea-4b62-a5a5-e683b4415f79	29de6d6a-71a1-4132-aec0-dffb379c5d84	3	6	9	73.92	78043198.00	78043198.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
abda663a-9e79-4030-a9c1-6910b1b43cce	4e4ec2ac-43b7-4b1f-9b81-a82464172ae1	3	6	9	79.16	82177776.00	82177776.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6895e8e0-bef6-42d5-8d0b-2d3af98f1f20	dfc1e5a9-a373-4eca-8f6c-903fc4d51dec	2	7	9	62.43	58147114.00	58147114.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
24a08946-c421-4e63-9827-550e8a05f60f	57182ff8-b8ad-4c73-b524-38099f9b373e	2	7	9	65.74	60851518.00	60851518.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
72cea62c-3941-48c3-997f-cbbe2360b323	e091e8e4-03ca-4d66-8cc5-51b8264f9f73	3	7	9	73.92	69172798.00	69172798.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
acc0f08b-f346-4e9b-9678-3471f275edd8	4d19d8cd-8337-4dbf-95c4-fc90a891ffc6	2	7	9	62.94	58402698.00	58402698.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
caa23117-2c70-4cc2-91a8-61d492663ceb	3845201e-608b-461c-a977-18c049741771	3	7	9	79.16	72678576.00	72678576.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
36c9ed5b-8701-495d-bf59-2e7edc77791e	413059fb-834e-4c49-aca9-4509422237ae	2	8	9	65.74	60522818.00	60522818.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4128467e-94ac-476f-8041-7272041bc852	2235bf74-9bef-4dd6-883c-fe8283d83157	3	8	9	73.92	68803198.00	68803198.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
912f676b-ae6c-411f-9390-5f2b4a719f9e	13a8c382-50a6-422d-bb81-7e3185bc387b	2	8	9	62.94	58087998.00	58087998.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
925ff7eb-3663-42a1-ae52-3e4b10f43b20	f81f9346-a596-4f57-bfab-7218f9b5861d	3	8	9	79.16	72282776.00	72282776.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3ec5c2ca-f624-446f-b448-caa3416902ff	6ae8a76d-e0a9-45ec-9230-a218b29ae8c1	4	3	12	128.74	99516020.00	99516020.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
fa7c794f-f1ac-4c0a-8241-d44344703df8	852eba50-ee4e-46de-bf93-f8db93f73697	2	9	9	62.43	57834964.00	57834964.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c2807d64-ecec-4f20-8fd8-01f280774101	cbe62f85-bb7a-48a8-884d-87b9217fad0e	2	9	9	65.74	60522818.00	60522818.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b326ab22-9b02-4bb3-953c-01413f407c92	4d7c2d73-5b29-4942-a990-c75fd71ba527	3	9	9	73.92	68803198.00	68803198.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6fe567ef-06cb-471b-bac7-abe8b0239786	148df982-954a-419e-8b8e-9337ed32ec4c	2	9	9	62.94	58087998.00	58087998.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
1c9badee-d96f-4564-b5f7-9de421c860da	e924d2b1-dba0-4230-ad3b-d4e91a05efa5	3	9	9	79.16	72282776.00	72282776.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
50411959-9fea-45fb-bd23-3e053348cbf9	23d9583d-15be-4993-ac0c-063af3e5876c	2	2	9	46.41	41026440.00	41026440.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a66327b0-c591-47d3-acd4-b63a4cde51c1	3d4d112d-ae76-4d0d-9b59-cc2654bb761e	3	2	9	96.53	74231570.00	74231570.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0367bcfc-d4b2-4009-8669-e6cb8658a544	d354e027-7833-49fa-850f-4f10736801f3	3	2	9	69.29	58550050.00	58550050.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c1700a08-6126-48bf-a974-5baf31cd8e64	8f0c7a61-320a-4c2b-9bc2-402cb0355fca	1	2	9	41.43	37287000.00	37287000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
9be157e3-90dc-451e-a613-f05fdbdd86fa	a7b0a1cc-d59e-4130-b9ed-0dc361b2d927	3	4	12	102.41	81108720.00	81108720.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6489e852-3fcc-47d0-b41a-a551d8e19f3f	7d85f774-d6c3-4fa5-867f-d75d832e83f3	2	3	9	60.66	55807200.00	55807200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
58f591ea-a2f2-47ad-b3e8-5323a37ea309	26c9eecb-4cf6-413e-bcdd-28d127549c39	2	3	9	45.74	42995600.00	42995600.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4a83467e-fd2b-44eb-a866-0e6740db528a	ad704c81-08a9-4959-82ba-374da976086b	3	4	9	68.52	65368080.00	65368080.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
25f33e04-abb6-4ce0-9321-fdbf68c95a8c	1e5205d8-2702-4255-b29a-bdd8c04b6ee5	2	5	9	60.66	55807200.00	55807200.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
b95b73d0-097a-4b65-8505-d863273d6457	fbe07984-5967-457e-933c-f793731ba9a4	4	11	12	128.29	94934600.00	94934600.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
1f0d7418-c1aa-42ea-9fb1-260ffcbdf190	c2de3a9e-1eaa-4393-b37e-558fbff3b0f3	4	3	12	118.57	82643290.00	82643290.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
87732b94-69f7-4f83-99a5-d6629b0c8e41	bac2e5ff-9c7c-4273-aade-749d4b859ff2	4	5	12	118.57	82524720.00	82524720.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
48c8878a-1582-476f-bde4-9ff956f93bbe	de216850-a71b-48da-b79c-936226f88b5e	2	5	9	65.74	68148658.00	68148658.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
306c1fe8-db7b-4f26-9089-b85a02b642a9	d334c5e9-11ea-4d2a-a8a6-7d01f5af0f3a	4	7	12	118.57	82643290.00	82643290.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
c5086517-8d92-49b9-8fd0-e9f5cb458e91	11488592-3f7d-4195-97ee-2d7dd7ed85cf	4	9	12	118.57	81457590.00	81457590.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
0708feac-093f-41f5-be86-ff56dff67bac	8e29c1a6-b8d4-48b2-b890-3f0402cb50cb	4	9	12	105.82	75767120.00	75767120.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
bcd420df-cc43-44d7-b752-92a84fd6ca51	2df13f99-cbed-4fe4-9e04-7a785c7a365c	2	9	12	64.83	51086040.00	51086040.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
282b6d60-7499-454a-ba7f-0428fb7fb354	7fc318b4-c5de-4d0b-b03a-0d2de4e88c16	4	10	12	121.34	82753880.00	82753880.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
df28d9ee-f965-434b-b2ce-d49d82b6c27f	ce5f9766-e544-4ef3-b07c-e8d2560938ac	4	10	12	107.72	75188560.00	75188560.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
79fa40ad-a980-4dcf-b2e9-680bfb9729ea	37398449-ee66-42bc-8cd4-b7672150bbfe	2	9	9	66.2	59622413.00	59622413.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
618a05a8-f6bf-43d9-8597-73139b4eba1e	1356343e-82e6-47cd-8fe2-62c7fb4885eb	2	4	9	62.73	65378109.00	65378109.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6a53a792-5c39-406c-8894-1122a1918a5a	731791b2-644e-46b2-840b-3e27b5892a43	2	4	9	65.74	60851518.00	60851518.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e20fc1e7-bafd-488c-bc44-42bea5ec6998	14471870-5b15-4029-a6d2-abc8ad5dfe31	4	4	12	118.57	82643290.00	82643290.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
b75fdbc3-9a66-4efa-8733-0d5196080410	966dfc14-448e-4094-ba3e-a9a0a97f7f82	3	4	9	73.92	78043198.00	78043198.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
d4ac256c-e71b-43fe-b6b1-1b66d4aa5e2a	301a66e0-aafd-4b05-a5f3-1144c96ded52	4	12	12	107.72	74434520.00	74434520.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
ca9fe356-f5b6-4f3b-bda7-2fb5b5e389ce	6623ef1f-8816-4749-a991-8424ead8e645	2	12	12	66.13	50060410.00	50060410.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
0a3dc02e-9bd9-4741-854a-44bc651dc4f3	7346ec58-3d4f-4b0f-a959-071f5ab999ba	2	2	9	70.4	53292800.00	53292800.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
76db3f47-abde-4fc0-8a7b-429d2fb87349	b23f1491-de81-42b0-bac5-8c8a30793b13	2	9	9	64.47	47514390.00	47514390.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
43292e78-9e80-4c6e-950b-2479ce367ea4	dbc84f02-e2f0-4c2f-b527-400ae375a79a	2	2	9	62.42	54383764.00	54383764.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
fa444f81-4652-494c-8f08-e0de737cbb92	f2bf0b81-4375-4380-a0bf-2ed42b82117a	2	8	9	64.47	57317150.00	57317150.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
65806637-792d-4464-bae5-9ea673d38017	297ecc98-8d2e-4832-9784-52ccff20e914	3	8	9	77.5	64921333.00	64921333.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
b031a469-38c0-48b4-bed4-6cb09afe6214	bddaa52d-fa53-44a2-ba7f-8c877cddad8c	3	9	9	95.14	64790340.00	64790340.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
60dfb265-32df-464a-afa0-499fc56ccb87	d35842c1-714f-4dfe-a625-be74e36a2662	2	9	9	64.47	57317150.00	57317150.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
0a1c0acc-3977-410d-b799-9993271936df	a93f434f-a355-4808-8c6c-921f116490c3	3	9	9	77.5	64921333.00	64921333.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
56e40968-f69d-4fb9-9e55-034d713ddb86	8197bdf8-18d1-4d13-888a-7665f28ad186	4	3	9	127.13	90516560.00	90516560.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
b2127bd1-7546-4105-8b74-adc694d523bc	484b398e-7ea4-43e0-8b76-f1ed5902889a	4	8	9	131.47	93606640.00	93606640.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
98de70ce-4728-418d-aa9e-778c98c799bf	e37f837e-eeda-404b-9ac1-55150d5f49d4	3	9	9	94.95	64566000.00	64566000.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
4ca242ea-2a35-432f-8dab-e11493607c58	9327b017-3a4c-4e38-a63f-56e71f8fad33	4	5	12	121.7	87137200.00	87137200.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
4e6d416d-ca36-49a9-a5fc-6cf7c2af676c	585c3a01-3912-497c-8eba-df338d30e64f	4	7	12	121.88	87266080.00	87266080.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
dd91d842-6eaf-485f-953f-d7af00e2e68e	5b699938-cfc0-47c3-bd83-73d3aca189c8	4	11	12	128.12	91990160.00	91990160.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
253dd024-e334-4d33-acf5-2e476d6413da	adf6f033-4730-442f-b3fd-e3f880ef9be7	4	2	8	115.06	83188380.00	83188380.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
2b6a10d9-6d21-4852-9303-9318f6e11308	111237c0-1ee5-40bb-9f34-956cb75e80fe	4	8	8	117.59	82430590.00	82430590.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
4986fc67-4440-4ac8-8e20-4ac51b0c8df2	50e8703b-d558-4c2a-832f-10f9e6d51e77	2	8	8	63.9	49650300.00	49650300.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
30e2a870-ce6a-484b-bd9e-f22c9bcf93fb	1862f7ed-f579-11ee-a82d-001dd8b72708	1	2	9	39.43	27601000.00	27601000.00		2025-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
f3aba371-d259-4c12-a38d-7fd2a51020bc	0b0c1621-562b-42ba-a093-d407281d6091	3	4	9	74.31	41316360.00	41316360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c7b71b02-1ce8-499e-b5d3-ea9306b76ee3	1af60ebe-6666-4792-9134-026712dd2597	3	6	9	69.83	45040350.00	45040350.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b6e10dc0-5247-49ee-b9b2-0934b749c127	6faad9bb-6fb5-4d45-a9cc-d21a671cb053	4	7	9	121.68	73251360.00	73251360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
55277001-1610-4cea-bd95-3ea39cca6f13	9dfe919d-0d04-495a-8735-133c8a1cb166	2	7	9	65.26	42419000.00	42419000.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
7cc266d3-7d1e-412a-b4a2-c8e611c29fdd	8d466039-fd91-4d90-9f7e-3f8a9c96b2ec	3	7	9	74.47	40884030.00	40884030.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
4d7f689a-0b17-4b1c-8fb9-33e36e108109	19a1f173-655a-4d22-896c-26bd8cd71666	4	8	9	121.68	60353280.00	60353280.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d3327c4b-1acf-476a-8ec4-8a32a5f28bec	8368ffa3-bdef-4ffb-8b4f-8b9daea3289c	2	8	9	65.26	37132940.00	37132940.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3376d22f-bd01-45dc-9412-0ca9ace208be	8f46e3fa-b448-4f46-8e2d-29bb336f0c90	3	8	9	69.83	38755650.00	38755650.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a1a9952b-80d7-405a-82a0-0673420aa819	8cbb4a7f-a1c1-4920-91ed-3cdfce4e1c24	4	9	9	121.68	59136480.00	59136480.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
532a5717-e26a-450e-8ff6-f718fdcbf371	26893b53-34ac-4a45-83bb-c25afe3b954b	2	9	9	65.26	36415080.00	36415080.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
958e5ff2-3177-4eb4-b720-a1235dc5471a	b9b79b6c-0f8e-485c-b049-ce547d30b114	3	9	9	74.47	39394630.00	39394630.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fa9eecf1-f135-4757-b4c4-ffac4624ce80	f14a4686-ad78-4954-b712-cfca07b29a1b	3	9	9	69.83	38057350.00	38057350.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a265a7a1-4b86-42dd-9270-554dcba7ffa8	6c490a73-8fdb-471d-ac9e-a03159f5279a	2	1	9	54.95	33849200.00	33849200.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
f7e353eb-4c1a-4adf-bbef-81ecaa49ef15	b1501e46-b64f-48b9-a0f7-8b9d8cbaa193	2	2	9	63.58	36240600.00	36240600.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2439a1a6-24e0-4a8b-a62d-fe8dae1f0364	9c5d30bb-a6a5-4d04-824d-c23724959d8d	2	2	9	64	36480000.00	36480000.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
dbd04526-1169-4aa0-9ec8-0ec4553b4662	d3456e82-78b5-40f0-a577-50082d4c8a4b	2	4	9	64.5	37990500.00	37990500.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fdbc94d2-7cb4-44c2-9661-8fb642cab16c	f70e84de-d914-4bd8-b581-01d88be7b60a	4	4	9	113.02	70976560.00	70976560.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
957c186b-e227-4b84-ad6a-083eb38360f8	755af5ba-8ac0-4c8d-b9a7-67692bff2879	3	5	9	69.76	39414400.00	39414400.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
446ceffa-d215-4fb1-9e9e-15cd6d3d36c6	818d1c6e-37c7-45be-8748-06fb2747ade3	2	5	9	64.52	43292920.00	43292920.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
5b8a22e3-1ad1-451e-be8f-4f8ce4daa076	60b67326-5aa1-41d0-a920-99c9af6b61e1	3	6	9	81.06	51148860.00	51148860.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c1dca765-1fd5-46aa-b1cd-b92b3f6960df	6529ffd3-1bb4-4c0f-b176-8b4f5986f0f4	4	6	9	113.02	68716160.00	68716160.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
49996e5e-1097-402b-b6ef-8ddb288b3c4c	ee0efd38-68dc-11ee-a82a-001dd8b72708	3	5	8	125.34	143263620.00	143263620.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
1e6dc204-9117-4469-813a-da9140c669bf	738ce2ca-68dc-11ee-a82a-001dd8b72708	3	6	8	126.41	149163800.00	149163800.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
d50fb23f-9c06-496d-8485-0f02dd58a6ce	aaea8ca9-68dc-11ee-a82a-001dd8b72708	2	6	8	57.13	81867290.00	81867290.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
4349847e-cb99-4ab8-abed-0db26ad0f2b9	8fd91a0c-425f-4654-b053-0d3fdc7e5587	4	12	12	121.34	82147180.00	82147180.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
a095af7d-6952-482e-b4a3-ac994ee80db8	d5df62b9-68dc-11ee-a82a-001dd8b72708	2	6	8	55.5	69985500.00	69985500.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
68bc9185-fc0b-41da-9a31-66fdb778cdfd	00046fde-68dd-11ee-a82a-001dd8b72708	3	6	8	125.34	144517020.00	144517020.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
e18bcd53-7b6a-445c-8387-b808cb20dd74	8b93732d-68dc-11ee-a82a-001dd8b72708	3	7	8	126.41	149416620.00	149416620.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
3f9ecadf-5d23-43c8-acf5-13337a17428a	e17e87a6-dc10-4eb4-a0e8-4d374c68c622	2	11	12	63.78	49493280.00	49493280.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
1ba43ec8-3487-48f5-93fa-f0db93c2f677	5a950eff-3959-4446-b966-338b04023339	4	11	12	107.72	74434520.00	74434520.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
be504b73-c8e7-45d8-baf1-c1e87b96a535	a917d9a7-1408-4e9e-8e87-cb209b4ae8aa	4	2	9	122.07	61401210.00	61401210.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
39d4e391-d41d-4a16-86bc-e74c946045fc	96738231-9efd-4881-910d-7e170a6a50a4	4	3	9	121.39	63608360.00	63608360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3cbfeeb0-67a3-4953-96dd-f6d5fbb66d4e	bdfe7817-b18c-4682-b5be-e41a247bc7e7	4	5	9	121.39	63608360.00	63608360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0bb83f08-3a70-4181-9702-35d68d1ea974	7e65ed88-2804-4960-9311-81ac2b40044a	3	6	9	69.76	44995200.00	44995200.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
011c09a3-dab7-4afd-a775-ee552a567154	af311ae6-d9be-440c-82cb-41b4811d229b	4	5	9	121.56	63697440.00	63697440.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ba846153-ba3e-40d4-978b-04b6ecdacf6d	7fbfb9c7-10d9-4956-a37a-fc5138c0a6a0	4	6	9	121.38	74041800.00	74041800.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
29a5969a-ce4c-4605-992d-6b64f11de971	b0727419-ebf3-4520-9311-294d9d84cc85	4	6	9	121.56	74151600.00	74151600.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
dba70675-475a-4034-911e-9a7a5da41a3e	6bc2e3f6-c011-4dc8-aa25-fdeca2bf53b9	4	7	9	121.38	63117600.00	63117600.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
e44fead7-2767-4cd1-8f07-32f04c65f8fd	87c52590-6018-405e-a242-c71e260e23e2	4	8	9	121.38	61175520.00	61175520.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3cd004b6-e6c1-45ac-abce-41f05361134e	c8106508-a6f8-408d-9cac-4f910c756df9	4	9	9	121.38	59961720.00	59961720.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fb88c636-fa5a-4d67-bdd3-e7bb4129ec4c	ea6b65c5-f7f3-4e05-96bd-385a5aa46117	4	9	9	121.56	60050640.00	60050640.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
4a646a92-fda8-46c6-aad0-daae4c50ea7c	df432cc1-8ea0-47da-872b-c0acfe421d0b	2	1	9	67.54	40929240.00	40929240.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
60a48f4d-0777-424f-a9c8-7586348a27a8	df74750a-2223-4f69-9aee-fde26b66abfa	2	6	9	65.07	42295500.00	42295500.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d14745fe-c58b-49c2-96a9-ebb0c33f6685	f3a143f6-469f-441c-aebf-12c2a1f26bd3	2	1	9	59.87	36580570.00	36580570.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
587aff9c-d4bf-4a4e-b968-92f1d79b59a1	a14c1f9c-3af3-4536-8814-2335dda89bed	4	2	9	118.61	67598794.00	67598794.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3848ad01-26a2-48d8-b436-0114c754c63e	3fa607b5-bf59-4032-b883-e70865f39b1c	3	2	9	100.94	60306451.00	60306451.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
146e5c54-5088-411a-aabe-c2d3f894c994	8d7d8ce9-cddb-48bc-9c5c-bdeec8392afc	3	3	9	80.73	52204079.00	52204079.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
8185f8ba-0ac6-4f35-90eb-8cf1b51448e3	beb2ef57-8db2-4f7b-841a-4df40cf4a5ec	2	3	9	63.46	49047923.00	49047923.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
eab34c3f-c874-41ad-a2c6-646a9820170d	b0cfebc2-0166-4962-bf79-313b9e7033a9	2	3	9	52.33	41278545.00	41278545.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
8db535ae-832f-4a50-9c93-d27acba6bf9b	7772c04b-a2d3-45b2-a0b3-2356048d77ab	3	3	9	104.27	65261271.00	65261271.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b20f9857-b125-4d33-9612-dadcfa672ddd	0ef1305e-0db1-4293-a9f3-711c7c5a9768	3	4	9	80.76	52220429.00	52220429.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2859cd4b-33eb-4280-b403-b12d83cfb5d7	a211ab1a-a38e-416d-9207-0ebd3a01178d	2	4	9	63.44	42373283.00	42373283.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
bd44fcf2-acf6-4f7f-98dc-957686993006	86adc0f2-d808-4325-b29c-43eabaf99d51	3	4	9	100.63	74244439.00	74244439.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c0934ce4-07b1-4e00-81b7-54d5c6d57e50	252df62f-a2b0-449f-aacb-f0d64e0d9394	3	5	9	80.76	60861749.00	60861749.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
daf52d00-6515-4094-99d5-968dab48fd26	2587eb55-ee33-47ab-ae0a-1670900e1eb2	2	5	9	63.42	42361943.00	42361943.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d1974888-5eb4-4d32-b94c-a948baa77cba	c340eb9c-25d7-42e5-a9e7-9c45d45e09bd	2	5	9	52.36	41299125.00	41299125.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
08cda86e-8f85-4902-b246-b258891f18e0	9c4c55b8-271b-4558-af73-9c403803882c	3	5	9	104.28	65331534.00	65331534.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0acbce80-d67f-4ed0-acd8-352cd2a8231c	92798dcd-d9d3-4926-818b-e30b1faef7e1	2	6	9	63.46	47778723.00	47778723.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
79a76a6e-72b0-4149-a4f0-e625d300d118	6484067e-1a33-4c83-95d8-8973c52644f0	3	6	9	77.02	56507027.00	56507027.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
57589550-ee2e-4d9c-8800-e6c0aaf38de3	aebe4e1a-4220-487c-a8e6-ad825e90a726	3	6	9	100.63	62370099.00	62370099.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
6a8bf99d-0812-4488-aa2a-425ba64ea966	896690b1-75c1-4a12-a817-df13bf5dfec3	3	7	9	80.76	58842749.00	58842749.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
e5b50e32-a762-40d8-bdee-ee719e6f47e2	517b984d-9a7e-44b5-bd6f-2dfb2b926a17	2	7	9	63.46	48857543.00	48857543.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
743d7f02-59be-4162-bf66-3e17e1e907d8	602bdc34-c592-4f15-a5f0-72c3942b2ce9	3	7	9	100.63	72231839.00	72231839.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b4be8a31-eaf1-4017-a229-7c9fc9dd8c77	a24f0f14-4937-4fcd-ba39-ed68f024c2fc	3	8	9	80.76	50605229.00	50605229.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
e6ee565a-da3e-4575-aa9b-e839d2709194	53f1f835-fa5f-4ac2-98f9-41cfee3a226c	2	8	9	63.46	41115423.00	41115423.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3532dd50-2c56-4b39-8d37-8f738abc358c	52d44b91-96f7-4e26-bf46-df80aa663ec9	2	8	9	52.31	40218625.00	40218625.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d8f11479-7b59-4217-9929-1e6d4ffa5b46	9f8d2f68-95f3-405a-8f4a-ce84a9160ec1	3	8	9	100.63	61464429.00	61464429.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2ce92e9c-4ec4-426a-980a-ed92a4a00169	01fbe977-3ba7-46cc-94f0-5f0000b040eb	3	9	9	80.76	49797629.00	49797629.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
bb2246af-2403-4063-9bf5-81d26a6fbcf5	9f8c4ab3-c4f0-47b1-9f55-288f878d1242	2	9	9	63.46	40480823.00	40480823.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
31f39364-7c73-4d5c-aed6-fe7d361ee7c2	40747737-bf58-4fcf-8b1a-57f7ec0bea75	2	9	9	52.31	38417518.00	38417518.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
39da1009-9472-489b-98e7-8b6e42c7ec90	f56f8e3f-f70c-4938-955f-7787f1742bfb	3	9	9	73.26	46257946.00	46257946.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
35ad8054-2a01-46bf-8bc2-f4231c3464cb	3859a27c-a9e9-4f4f-9854-dfbb86a9ca39	3	9	9	100.63	60458129.00	60458129.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
89d65ecf-77f5-45f5-82c1-fafda5f6fcf1	3be6dae8-7eb5-489c-a13e-0a2ebe22c294	4	7	9	121.58	73191160.00	73191160.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d59fd305-793f-4624-8d16-b79df6d71d93	731e9506-360f-4d68-92d8-79c3875b0b84	3	8	9	69.76	38716800.00	38716800.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
f51005bb-d1a2-4a84-9ef6-806e9234cad5	1023452c-15a8-4cfa-b5ae-f08f78a5635d	3	9	9	81.06	43610280.00	43610280.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
618564d1-ed4f-4517-9739-511305561a32	3d6e0c74-e07c-4ada-860d-416d169bea55	4	2	9	121.49	61230960.00	61230960.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
bc240e31-0e73-41ce-8133-757f90d3b56b	0133e4ee-7f4c-48f5-bc1c-14c1ec72cfa2	4	5	9	121.58	62735280.00	62735280.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
9e4d2fe5-cf1f-4c89-b803-087d3fcf5e52	3e29ef80-02bc-4649-90af-e87e4dbfdf5d	4	3	9	121.56	63697440.00	63697440.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
755e9e2f-520b-4181-8795-af06cf31c191	d0d06369-77ec-4b49-8fff-f3f2c6073c04	4	4	9	121.39	63608360.00	63608360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
47a87f78-b8a6-4c90-81a4-626d6336b10f	8fa103c3-de45-4046-82d5-8a568568abcc	4	4	9	121.56	76582800.00	76582800.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2ccd131b-13c0-4e73-b5a3-9e79dc100269	48810069-561d-4186-9d5c-1e11de435539	4	9	9	121.58	59087880.00	59087880.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
000f208b-c5c9-4ac8-9e61-217c03501f9a	687f17e0-3526-4127-8f07-6f58dcc5fb25	1	2	9	45.67	32404883.00	32404883.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2ed5b245-8e8d-4e88-a4fd-c356a6299cda	afc5e791-2aa0-4a62-b705-da0332a07ba8	3	2	9	79.29	49478873.00	49478873.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ea1667e7-4da8-4090-b3bf-336dbfb3fe02	1ed15ff9-2be9-4fb9-8fc8-4e06fb56e38f	3	3	9	82.42	54292462.00	54292462.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
990db5df-f606-44b3-829c-303eceb7cc1c	7362fefc-b6bb-4309-b507-9910d116f253	3	4	9	74.16	55774154.00	55774154.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3f789b40-e20b-489a-91d0-19457273e28e	12091f87-93c3-44d0-9ea6-978b81c96c0c	1	4	9	38.87	29110569.00	29110569.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ac45cb60-0017-486c-abc0-d0a2838b702e	cdf429ee-24ce-42a2-ab00-87046d53d8ed	1	4	9	39.4	31886708.00	31886708.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d90aeecf-a6be-44b2-8a0c-fcadb367c2b1	941404e9-418f-4db0-8dc9-33c704b1111b	3	3	9	69.76	39205120.00	39205120.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
efbfbadc-ff90-4c1e-9da0-13a6271f0548	23b3ed4e-f44d-4228-a1b5-f64f7d6576ae	2	5	9	62.96	49064969.00	49064969.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
6181c359-17bd-4c79-9daf-22a18a88a760	e7c3466a-c561-4aa8-8b09-901bb9c50ed1	3	5	9	74.16	48506474.00	48506474.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b34010a8-8856-49e5-9554-e838c9e81b74	8034f062-354c-48bd-be78-25c824688965	1	5	9	38.87	31424723.00	31424723.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
37417c84-5701-417d-aaaa-dda1b891f106	4a574357-f054-4397-8fdc-417d66d0f395	3	5	9	82.42	54292462.00	54292462.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
acd8d064-ef86-484d-a42f-b2c833daf4ec	d019a33d-9902-4880-b560-dc409fe2f1a1	2	6	9	62.95	48869339.00	48869339.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
99da5715-1436-4344-9afe-f6dbd42d3681	a028615f-c976-4ee0-8744-3e23da005a42	3	6	9	74.16	47023274.00	47023274.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d3f9edb1-a538-4adf-a65a-e1761073178d	b7b4db52-eb9e-45c9-bacd-612de5600523	3	3	9	74.31	41539290.00	41539290.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0a39b60c-ed5c-419f-aacd-9455c9b5e1fc	8f2a3c2c-c695-4eae-862a-2be19f9995d0	3	6	9	82.43	61469442.00	61469442.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0aece093-c3d5-4d0d-a996-2a7db9363948	56981c3b-eaa6-479d-a806-a359511d5eb4	3	7	9	74.16	47023274.00	47023274.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a65f9f65-2899-4385-aa30-493fd58f4c0d	314cb628-79d2-4921-b86c-83cae0856c72	1	7	9	39.4	31019908.00	31019908.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b3390fe4-1abf-49f2-8921-f830d0fd780c	420c0c0e-9807-42b6-b290-ebfeed79d89b	3	7	9	82.43	52649432.00	52649432.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
96ceb19f-9cca-4213-b1df-a4b51d28f540	65bfe406-17d5-4f57-89b5-5516eee5c69c	2	3	9	65.07	43596900.00	43596900.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
6a17e558-3d89-4132-a733-06f9dc952057	35de700e-1352-404b-b7a3-a33b252b5572	3	8	9	74.16	47023274.00	47023274.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d26c93d6-6c03-4e78-bb86-a251fb1a991c	f5ba9092-a05e-4ab2-8fd0-e48ca08742f5	2	9	9	62.95	40559939.00	40559939.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
afb84c47-2e50-43f7-a1d4-7fc219a74519	4d86d51a-393d-468b-b483-a7bec79c4bb5	3	9	9	74.16	46281674.00	46281674.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
53b563d2-7e29-4075-89ed-2f12e01caebc	a45ca2b0-f697-4788-a9bf-32109e32dfca	4	3	9	121.58	62735280.00	62735280.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
35d9b8b6-72e5-4013-8476-5500db32982c	64fcee19-45dd-4554-87fe-b221875136df	3	9	9	82.43	51825132.00	51825132.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
8e6c227c-237a-416a-a905-73149f335100	cde5d489-5e46-48a0-947b-58811fab3e89	4	3	9	121.68	62786880.00	62786880.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2823e14d-f1c7-4e55-9460-5cf437a6485d	e38b5433-7a99-49d4-8def-ecb520205d1a	2	3	9	65.26	43724200.00	43724200.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b14d6cdd-9f43-4774-98cb-599aae553a16	fd07c662-8448-4b41-97f4-fa7d968da9c4	3	3	9	69.83	46436950.00	46436950.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
07305b7c-301f-4a0a-8c7e-6004d7171e71	c833a1a1-2730-4e4f-96b8-f5c73a9ddea1	4	4	9	121.68	62786880.00	62786880.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
1f21f463-de56-4336-bdef-6a1047e250dd	66af2f45-0fdf-479b-8e17-1f039bbc7d3c	3	4	9	69.76	39414400.00	39414400.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
aa273988-6ef0-462e-a9d2-2bc1d524eb51	3a933f10-09f3-4000-8524-6e2f103e5514	3	4	9	74.47	49075730.00	49075730.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c2046363-cd1a-4c3d-b6a0-7fb8c936a6d6	71412077-40b8-49ed-a749-d9dbf861fe44	3	4	9	69.83	39453950.00	39453950.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b0d4151e-6d64-4b6d-b510-bbff2da6b9c3	b24f54bd-e124-4360-a5e0-6c30da74f122	4	5	9	121.68	75684960.00	75684960.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3b7fc0bb-7c02-45ae-b05b-282ac9f2eb44	ceb542ee-7d51-41a4-a8e4-0cddf9bda03f	3	5	9	74.47	41628730.00	41628730.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
78bdcf11-d62a-40bd-8fbe-416e126e0f2b	f2dd25cb-0907-4f38-91df-ae2fda0825fc	3	5	9	69.83	39453950.00	39453950.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fb8fd165-ad80-4542-982f-95915b483537	36b15878-d686-4c33-8858-90461daaaf6a	4	6	9	121.68	60353280.00	60353280.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2d0b8f6a-8c0a-4115-9d15-66cf6fcef549	e02e4d2c-3591-48fd-9290-e416e0381023	3	7	9	72.49	45596210.00	45596210.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
8163dc1c-406e-4af5-abc3-82a668ee1806	ec1cd5f9-5245-471d-8fc8-ec57e2c2dbf3	2	2	9	52.85	38157700.00	38157700.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a2593c5d-bf65-4360-96a2-ef872911f349	eb8f49c9-21b1-4e0c-8840-762cc65e6ce3	3	2	9	68.79	44713500.00	44713500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ebc35c0e-9739-48e2-b933-339a4bdb1ca1	57103b45-2a3f-4305-8570-9a4f8a9f68f8	3	3	9	69.16	45991400.00	45991400.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
9b7c125d-7dfd-48ab-ab73-a9ef26a6c1ca	472759ed-3007-467c-938a-bff53e8d1b04	3	3	9	73.76	48681600.00	48681600.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0b72747a-8e35-435d-a95b-cd13951a58df	3a54d946-8c80-4048-a608-58efe610342f	1	3	9	40.77	32575230.00	32575230.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a490213f-cbd7-41b7-9ba0-76aa2592c2be	a37ce316-a3b4-4a15-a9bb-5028a1255c68	2	3	9	51.17	37456440.00	37456440.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
20be42ab-2652-43f2-8895-40ca678a3850	46e708e7-18be-48ee-ad54-497ab2276936	3	3	9	84.34	54567980.00	54567980.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
02a9de4b-b419-4252-b325-4a610dd4cdab	3c4cbcb0-ebd3-44c0-bd33-bbc6ea82044c	3	9	9	69.76	38437760.00	38437760.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3a732f99-127e-4b0f-b1c6-e6521c05f40f	d5192c5b-aec8-4335-b290-fd45b69ee10f	3	9	9	74.31	40944810.00	40944810.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
9769eda0-09b1-4546-b444-3c0d24d6e6a2	477c9dde-16f3-42ce-9d0b-afa3344337dc	2	9	9	65.07	36699480.00	36699480.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
007acbf0-f4f0-457e-a02f-be9a3f4155ee	7289cc08-4c9b-4340-8346-adf5d9b9d7e7	1	2	9	39.92	29020183.00	29020183.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
38946336-3f40-4d92-8e07-f0e3f774a3a2	bd7dc8b3-d6d8-484d-9155-c4077a2720bc	1	2	9	39.33	28310098.00	28310098.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
831fb1c8-06dc-4cff-8fac-3ddabc695950	8b1647ed-96ce-4819-851c-ec02ceb8bd91	1	2	9	39.86	28308340.00	28308340.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
62a6fb63-7a75-4d39-b98b-5d9c36f34c04	a3c15da5-6ca3-488f-ab19-6b3d9f56c574	3	5	9	84.34	53724580.00	53724580.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3fb497be-546e-421f-b0b6-e423ac700ff6	9fe8c365-b457-4a35-96ea-2f323ce258d0	3	6	9	73.76	47944000.00	47944000.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2874114c-734f-4a45-87e1-53fa3668d90e	f11751c6-9070-4e12-a926-6449517f7667	3	9	9	69.16	50348480.00	50348480.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b67217e8-8f3b-4f31-9e44-e68c502885e4	ce014882-629d-42b8-856e-e4543d78cc11	3	9	9	73.76	46468800.00	46468800.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
dd773118-d551-4ed1-a9ae-9abe7377edb6	42bc3d40-96c3-489c-82c2-6b2dbf5b11cf	1	9	9	40.77	29925180.00	29925180.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
008ccbc3-58b8-4f91-90ce-4a2d5be17a70	29213a24-17fa-465d-8db7-8aeeb1272bdb	3	3	9	82.47	47090370.00	47090370.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fe46e58c-784c-4055-947b-9f2cafa08a6a	af7761ff-f860-483f-8d94-71e614c47850	3	4	9	74.25	42916500.00	42916500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
1b8bf91f-7eaf-4934-9fe8-82710096e78b	ff1c407b-b0f2-4e91-a816-2f86480d585f	3	5	9	82.47	46265670.00	46265670.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
68836489-8f32-4c62-a62c-0df54b5283eb	5cc33d6e-d32b-4404-bc36-f5ee2574816f	3	6	9	82.47	46265670.00	46265670.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
576a55f5-6010-403b-bbb9-518a3cf3138f	2ce1c340-efe3-498d-9b64-34b0c5ad4bbe	3	6	9	74.25	42174000.00	42174000.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
eced1478-eaf1-4d9f-9db0-5d0daeb04512	a48b9bf9-9a7e-472d-b6be-b8f07c4b6be0	3	7	9	82.47	45440970.00	45440970.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
73d84acc-8ea2-4519-bcef-453bd07fd846	f1bbd530-a323-46f0-a21e-ef04fe44275f	2	7	9	62.49	30245160.00	30245160.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
1200e6c6-06b0-4a61-adfc-298b7fd25242	45ccc2f9-729e-4eb8-afad-30265a88a3cd	3	8	9	74.25	41431500.00	41431500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
107a3844-8f4d-4814-9bef-c362cb44903d	ea51dc7b-856a-4a99-bbeb-24e71a66b9d6	3	9	9	74.25	40392000.00	40392000.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
b24abc62-03b2-4516-a7b2-f6332645db7d	eb73fc11-d8f9-4380-85b5-6a1cf8dd95d8	3	3	9	71.05	41422150.00	41422150.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
406abe28-9dac-4928-95f0-f82bcb8e0bb5	562a2c2e-6fb7-499f-8b65-71afb7bbb5fe	3	3	9	87.45	49146900.00	49146900.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
3ed3d1cd-1cb7-44a4-b1bb-0d1ac3438af4	cceb0854-6394-4727-b4f4-3ae5b54a4a20	3	4	9	87.85	49371700.00	49371700.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
860a59ab-4513-4619-bc83-9b4bf9713b28	508fac10-ae84-4e00-8bbd-0c343e34411d	3	4	9	70.47	41084010.00	41084010.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ee218454-cc4e-4750-b8bb-4b4f29cdb985	a9c67eea-989e-49a9-b100-c1b3e6983bf9	3	6	9	70.43	40778970.00	40778970.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
217ce73f-8d6b-493a-b0ad-3b56d3abe562	835b49c9-32e2-4e0d-8d06-8f32040626f2	3	7	9	71.01	40901760.00	40901760.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
67cb96f3-8eec-45bc-8ce7-e49ddc9469ef	92c2655c-896e-46df-9d7f-7428e0d2f034	3	8	9	70.43	39863380.00	39863380.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
019c2e72-002d-4a67-b8fb-f8117e16b50f	f8b4e2bc-bb92-44b8-b2ef-5e9de0081a43	3	9	9	87.85	48229650.00	48229650.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
73e6e456-90ae-40d9-ae59-88ec30bc4028	d08d063b-8d71-4780-9dac-0ecbe17fdc3b	3	9	9	71.01	38487420.00	38487420.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
16e733d2-5e9b-4151-b938-34aca86afc87	f5cdd836-29f2-4ea4-b0bd-b682ce4950b1	3	9	9	70.43	38736500.00	38736500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c79be93d-5b10-4a7e-81cf-a012f0c0725f	f3738b50-bc57-4939-9918-7e408010136a	3	9	9	87.43	47824210.00	47824210.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fe8ad535-8eb2-48af-aac7-eb061e4fb6f7	36d4d84d-3052-4ff8-b519-e7cc13fed8a4	3	6	9	78.53	45076220.00	45076220.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
cb7e247e-30fa-4adb-923f-4c1d89052769	79f98982-b637-4690-9e41-db4f6fd2a8f1	3	3	9	82.47	47090370.00	47090370.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
69fb4783-067c-4fa3-bb7a-00b5b8105d7f	580a37ed-bbaf-4f1c-a070-31ddf566afb2	3	4	9	74.25	42174000.00	42174000.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
f9a828b3-0d93-4c72-8abb-25e6d5636ce6	72b096e3-4cc9-4049-83fb-3d268a456829	3	5	9	82.47	46265670.00	46265670.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
e86c575c-9f54-4adf-873b-1fadbc98fcae	34b9d0a7-34fb-42ef-8be1-4cf24e96360e	3	6	9	74.25	41431500.00	41431500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
1f113a0c-a71a-4918-b29f-822ab2d2ae98	7ee04786-12ff-4daf-8d16-01143dd1320e	3	8	9	74.25	41134500.00	41134500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
211fddc7-fb56-49b7-801c-736afa58a8ce	08dd5c84-0b4a-46e3-90c4-dc18a70073ba	4	6	9	112.57	65290600.00	65290600.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
89d516fd-496f-485e-9137-7737f840714b	591672d0-d7e5-4fce-88f8-e5970ecd64ab	3	9	9	82.47	44038980.00	44038980.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
7f4902b8-9a94-4ae8-a0db-b47d7be0174e	58a7162c-e005-4901-895a-76467d6bf9dd	2	7	9	64.11	41286840.00	41286840.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
4894fe97-1989-40aa-bcae-aeb9f440d327	75474beb-e964-44e1-a4fb-7ac29f9158a5	3	6	9	70.43	39652090.00	39652090.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
16a15b5a-88fe-4bff-a716-47e3a7e0b453	d0713c30-1f6d-4082-b637-0f57e463b4be	3	7	9	71.06	40219960.00	40219960.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0ea3f3c4-4279-4a90-a3f4-48004bf6c948	f9a4c2ae-6308-40af-bb9d-81ef1eaef33f	3	7	9	87.69	48317190.00	48317190.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d297f274-31da-48b3-bf61-1e3b6d0c5600	8123d71e-ea1a-44b8-98e8-7530f185ebad	3	8	9	70.43	39440800.00	39440800.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
cd813baa-be57-4d98-a28f-a46572f92dac	a9264a41-48bb-4580-9e4f-5811a0ed72c7	3	8	9	78.53	44290920.00	44290920.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
04eb2319-0bb2-41bd-adab-9e55d866507c	7328f7c7-9f31-4284-adab-fde9ab3a48b0	4	2	9	121.36	64320800.00	64320800.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
8e7a84d0-c165-4029-a894-9555296cd6c9	6006f9c6-6379-457e-9210-d2920cd4986e	4	3	9	120.88	66484000.00	66484000.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
9d100f63-edc5-44da-88ac-440eee8fdbd7	f0fd927f-58bb-48f4-9c74-7f98329ba376	4	4	9	120.88	65396080.00	65396080.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
6f17d5a7-8b2b-48ea-bfdc-4a009a5b5424	89be9fc4-f653-4827-a7aa-a061fee876b6	4	5	9	121.03	64751050.00	64751050.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
09bea1ce-20b3-4efd-8bbb-1f0835fcf45b	25196a87-1346-4439-857f-3670e48ed9c7	4	2	9	112.67	60841800.00	60841800.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
33e60a65-3a28-4398-bb24-258a881ed322	45718266-6ccd-4179-88cf-d0e20afa90f0	3	4	9	73.76	48681600.00	48681600.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
bce73572-545c-4c18-9fe8-3beea0b0af9d	5e91d1e7-21c1-4ac3-81f0-f9373090e10c	3	4	9	84.34	61230840.00	61230840.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
0ba81dfb-ccfe-413e-b4be-47233a6b8ce8	1eee70df-6161-48d0-b996-9c26ddeb1405	2	5	9	51.17	42880460.00	42880460.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
e026b860-3de6-4e90-bcc3-d834ce05a0ef	4d345782-fc6b-4bba-b450-7b81b49f9a57	2	6	9	51.17	42880460.00	42880460.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
a5be06e1-2313-4101-be03-355b422535c3	e45034a7-0ff8-464d-adf2-7c333f472fdd	3	8	9	73.76	47206400.00	47206400.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
81e2ac95-42bb-4c84-b492-1758c140fee8	42745388-04a5-4d2e-98b3-d013869de2d5	3	8	9	84.34	62580280.00	62580280.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
ad0d31f9-1f95-41a8-8678-fbaa0c0a3ee4	e9dc0b29-c027-4d1c-ba06-d6dce2958416	4	4	9	114.41	62811090.00	62811090.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
598f2082-8b12-40a1-9abb-0e08a37dbae6	8ef09dcc-2128-4c3e-bab6-c88c69efccb5	2	4	9	53.62	32600960.00	32600960.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
de8e8009-4e2c-4146-ba37-90a42ebc65eb	31e42d53-d760-4bea-b55e-4fa5bdd036a3	3	3	9	90.95	54364966.00	54364966.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1d99fa25-41f2-4cfa-8b10-db710ce3e041	6c6f2394-ce23-4e32-9e77-0d155a94091d	4	5	12	116.47	59050290.00	59050290.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3e1f1d65-1d84-4595-91b7-6c0614b961ae	ceea2aa3-b4e2-4176-8235-58480dcbd748	3	6	12	79.4	42161400.00	42161400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
26b6abf9-b73f-4ba7-8b48-92f0e7c2ed01	0fb1f2f8-ad87-49c9-85a2-47feaa3ee115	4	6	12	103.04	51313920.00	51313920.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
49c0cacf-effa-4168-845b-2e20ab0eb644	4bbc3f5c-b87d-4817-8f89-b8292b70a832	3	6	12	86.92	52760440.00	52760440.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
be3dd250-d358-4b7c-8579-f381ec71e757	4802b892-3285-49c1-9dd4-94a6b3b9b6d1	3	7	12	79.4	42161400.00	42161400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
21af7724-637b-4566-bf08-5b9226f87352	b83ff941-b95b-47fe-a93f-489c4be112e6	4	7	12	105.51	63306000.00	63306000.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b4769e4e-e7f3-4401-bc92-a5c271752aea	823c5dd0-550c-4330-a04e-434d6b8e50b7	2	4	9	64.26	41688873.00	41688873.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a8543bfe-0ff9-43bd-97af-801f31d72f41	4275fbbd-71fe-492b-8d28-2ccc80678338	3	8	12	79.4	48513400.00	48513400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b304a49c-7691-4950-bece-1ae26aa2937b	af4cba70-7997-4588-9b0d-9e387e56794d	4	8	12	103.08	51849240.00	51849240.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
80f00f37-02fb-4c75-b4c7-1deec0d805b5	ef04e504-aaf1-4c87-a965-a7a259a30f3d	3	8	12	86.93	51897210.00	51897210.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
58b72ef7-848a-4bb6-85ca-21fa417361b5	76e0d909-f978-427e-889c-e98988ab65c4	4	9	12	103.04	51520000.00	51520000.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a3a9f871-7861-4e11-aca0-ba5d45c32cde	df228f78-c96a-4850-98db-5800121866dd	3	9	12	86.88	51867360.00	51867360.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8c10ca2c-44c4-48d5-9c8a-6f6a8f58a36c	56145736-5118-4089-b26a-7edfdf35d283	3	11	12	79.65	41497650.00	41497650.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6c40c864-b279-4dc4-9af0-ac104a967950	65636f4b-1dd4-42ab-93cc-03c8f2086f8e	4	11	12	105.78	62304420.00	62304420.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5587d9d7-94c8-4e79-9969-193cc7b86de1	5c341078-0ff1-47b6-b6f2-e8336d2d92df	3	11	12	86.88	51867360.00	51867360.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d2da9c72-e783-4559-a260-1a0e80037ec7	01bf6655-cea4-4fd0-97c2-a3dcf7260a0a	4	11	12	116.4	57850800.00	57850800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5e5df67b-2b63-4da7-94ab-81dc4c39af40	7e527932-a2b4-4706-99c5-997193f861f3	3	12	12	79.62	40685820.00	40685820.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
88a68f14-2bd3-4ec6-963e-25aa1fe75283	4b994ecd-32cd-4a81-98c6-011023e7a0d0	4	12	12	103.28	50503920.00	50503920.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6275278f-b558-4f6b-a061-4f935bb4e4fb	0020c5fa-9605-433a-87f6-8aab699bcb8b	4	12	12	116.4	56686800.00	56686800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1574e82a-3d2a-41d6-8c43-a1f50ad70b49	6851f5ae-2ee4-44cd-8ede-41e7ebcb15a5	2	2	9	58.87	42063406.00	42063406.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b67340ff-75a6-4bc8-8bad-d63662fabe51	32499824-c2ff-428f-9f76-ecbd83bd71b7	2	2	9	64.96	45734549.00	45734549.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
40b14d98-f7cf-46c4-9094-0c7c4b333a59	0e8896a4-8b5d-4ef2-a766-704965fe44f4	2	2	9	65.01	45763459.00	45763459.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7b843c2a-82db-4887-a4a5-fc715a348a6e	7614d217-824a-43a6-978c-1ad34792440e	1	4	9	37.06	28715351.00	28715351.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
08f84b2c-4689-4036-80b9-fbaf872a9e14	a6cc6569-b3f3-4939-a945-914e8cab00e3	2	3	9	64.33	37954700.00	37954700.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
68ea37d0-104a-4537-80a2-7c3a6a17cd8f	b969227c-d850-4a27-9bd9-cb30bbf7ab41	2	3	9	64.39	37990100.00	37990100.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8c643ccc-c119-48c4-877c-41e2eea64376	8d4b3c7b-7073-46c7-8f9d-ae203ba00525	1	3	9	36.97	25620210.00	25620210.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d8c534b7-4963-4894-9de4-27e8dd33e8bc	030923db-d81e-4eb4-94b8-ebb8af77e40a	2	4	9	64.23	40593360.00	40593360.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6d747011-aaf1-4e48-944b-d6052b95be09	4b7f2a2a-d9a0-420d-8fb4-9732b7effb03	2	4	9	64.39	38634000.00	38634000.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d5715c6f-f613-4a5b-8814-232ddd3ca35f	afbde3ee-447d-49b1-a26c-2c969c221b75	3	4	9	91.27	51385010.00	51385010.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8fca8e7e-52ff-4be7-a797-c51488af5065	13df459f-de6e-4d01-bf8c-a4bfd642e626	2	5	9	64.39	40694480.00	40694480.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0ce9eabf-d6b9-4f59-b7a2-40b751910c5a	e263ca3b-10c3-4a99-a8ac-d30bede12817	2	6	9	64.29	40631280.00	40631280.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e3c5bc2b-5238-4df2-8c77-79ddcd72e6cd	aa4d2fdf-e4af-4524-a8ee-1d4a3b8405c8	2	6	9	64.39	38634000.00	38634000.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f39215f0-9724-4e79-8f2b-cd2701c7ba12	9dc064a2-65cb-4c5d-966a-f0cfdb9b8c5c	3	6	9	91.31	56703510.00	56703510.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2d263f82-66e9-408a-9bd6-06377ed88043	b1e056b2-de35-455a-8d44-ab84b2d757c9	2	5	9	64.26	45930033.00	45930033.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b12c5136-aeb7-4b8f-a7d8-7ab389d7ddd6	ca31f84c-3a9f-451a-947b-dfa0dd0e094d	1	7	9	37.03	24699010.00	24699010.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b383567c-5054-4605-a0fc-37f4475da963	a42a4128-0059-421b-9f4b-c11be84a23ca	3	8	9	91.31	55790410.00	55790410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0f16f13f-7afd-4929-ae43-0c61bd933ac5	fb79a9b8-10fa-4cca-851a-e213b26f52db	2	5	9	64.28	41701453.00	41701453.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a8afdae0-aed9-451d-9299-de620d72ff98	552af568-b023-4201-8eba-bd4bcd9f5769	2	9	9	64.27	37276600.00	37276600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
961c0d09-68a1-408b-bb0d-c6521f6122c5	4fb115f6-66d1-4f2f-b442-84c0d8b043e7	2	9	9	63.77	36986600.00	36986600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b59b1d4f-1c36-4728-acc7-d025334fdd03	49322043-32f5-4ca5-9c3e-78221ef13c45	1	9	9	36.96	25243680.00	25243680.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ee8810c9-597d-4280-9757-7499f33179a1	01ba3669-5fea-483d-88ed-9af0d93a285c	1	9	9	36.99	25264170.00	25264170.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ef92b196-8d5a-4c37-997a-72bb9da78b1a	b7348b46-68dc-11ee-a82a-001dd8b72708	2	7	8	57.13	71641020.00	71641020.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
403163b3-eb5d-44ff-aa32-425641de7d43	4a7ab52d-625f-4d70-8975-54c7ac1aef11	4	3	9	114.41	65099290.00	65099290.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
1d01139a-4a9d-439b-b42a-a6ddc632551e	c51e4fae-5376-488b-aeea-09d4026e9029	4	5	9	114.41	63955190.00	63955190.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
497d4db6-82cf-4704-a620-a972994e1ed8	c9ae655f-0966-4794-a462-16a6cf8c6bfd	3	6	9	75.89	46748240.00	46748240.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
5ada458f-0e02-45b4-8a82-6409ac2985cc	4cff2902-4854-49ce-9de0-5a959d5b61ab	2	2	9	64.94	40539422.00	40539422.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9327968d-5c92-4e71-b6fc-21d5e8d6721f	6b01fd14-8b24-4294-8651-2de7b306871d	3	3	9	100.57	55715780.00	55715780.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c2d92458-41dc-42bf-a897-cfc74965fbb3	539fc2f0-944b-441e-bb8e-eb307be029d6	1	4	9	37.02	28061159.00	28061159.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2604ccdb-d39a-4773-ab19-532ae3d518bc	fc6afdb5-69f2-47c0-8507-ab665705d001	2	5	9	47.37	37035023.00	37035023.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
067bffd2-5c2e-4e2e-9f58-4b7de93f1e5d	48bb4263-de5b-4616-ad72-b22730325e9e	2	7	9	58.39	42495269.00	42495269.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
51a1d6f2-f0d5-4c9e-a8da-442f72b26669	646de204-809c-455f-955e-835feeecbf2e	1	7	9	36.94	28008999.00	28008999.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
602e247b-f01e-44b2-8fba-2e784008a0e3	0c34e35e-276e-419a-948f-4d0e533e534c	2	6	9	64.23	41672433.00	41672433.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b0ff83fa-4faf-4f24-a884-722a8de5ee52	5eeb26da-be35-4b7f-a54c-1fcc6e745f90	2	9	9	47.86	33725002.00	33725002.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
446f6e91-34a5-4907-ab14-c38cac3a6edb	176ba8d6-5111-4d19-8402-b7fb136368a9	2	9	9	57.8	41313927.00	41313927.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
12f27bea-5c23-447b-bc52-b74cd6564f98	59071911-7d8f-451d-88b6-cdd9bb2030db	2	6	9	64.26	45932464.00	45932464.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2c5240e5-11b1-4ac1-aa40-6d617ac8395e	3a772179-ac52-44bf-8bfc-c591eb415178	3	2	9	71.25	44649202.00	44649202.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
47986bfc-46e9-431f-ba45-3040f3d070ba	b23e670e-8147-4195-89c2-4ea3a2676045	2	3	9	48.19	36283530.00	36283530.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a29a5342-e96d-48a9-8514-12e59664c69b	3dced82e-0abb-44ce-80b3-df6e0338bca3	1	4	9	36.99	28300912.00	28300912.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2d90c2cf-4a7f-436b-ba83-8585cd6c67b1	d7314870-18ac-43aa-b322-62dfc6c0fa96	2	4	9	47.38	35080210.00	35080210.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9d640f10-0dc0-4ce8-bc5a-ef705c1cc840	7fdebcbf-15b6-45da-b083-7cc6fa149ab5	2	5	9	57.9	42678357.00	42678357.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c8add84b-eb27-48fd-a417-c5b30e2330ea	8e14a682-c2e1-4dca-abe6-643ccdd8bdfb	2	5	9	47.38	35080210.00	35080210.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
31b217e4-dbad-42c9-a296-995ad7a73c56	6e06c048-98c8-46d6-970b-cb8cef518a0b	2	6	9	48.13	36721025.00	36721025.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c1cade91-1827-43f2-b3a6-f95810b93861	02357984-7c2b-4a94-936c-915317dc3385	2	6	9	47.39	36982981.00	36982981.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
681cfeca-1fc3-4159-b7f6-0596813efd6d	2e786be9-9a6b-4b4c-8fc8-465a2f348d9e	3	6	9	90.95	64278516.00	64278516.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3195dbfc-a0b2-4e18-9032-9ee8dfd1c939	a70c2d70-9840-405f-bc9d-da207d3e1d39	2	7	9	58.41	42934290.00	42934290.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6036fbae-29db-40a6-a3c1-7d6a47ca04d3	2ef752f7-7e82-4e90-ac8b-328f01efb8af	2	7	9	48.13	34795825.00	34795825.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2402b8ed-59ba-4f6f-9d2c-0a55951b3dc3	d59316e8-2dc0-4a30-922f-353dddef2189	1	7	9	36.93	28254490.00	28254490.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
57530922-80b9-42f1-8c38-4acfeb4c68a9	de40c90b-9723-4a57-bd6e-2d35e29d7a57	1	7	9	36.94	28008999.00	28008999.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
30ba8f71-d657-4cd6-b3ef-082dc20d8e2d	d5dac9f4-6309-4677-8a2c-396345bf3de7	2	8	9	48.13	34314525.00	34314525.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6ca3c4b4-e57d-4214-81f6-f66332af37cc	474ecf7f-0ece-4118-a619-36a71f20e712	2	7	9	64.23	45911613.00	45911613.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9eb515dd-faaa-4e25-8f5a-8f52674dfdf5	65597af8-39cb-4205-82bd-19ceec3160f4	2	8	9	47.39	34613481.00	34613481.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fc471e65-8773-412e-8031-378b43f40a8f	41bd0ce2-5199-45f4-9a9d-ebe842ac0fba	1	8	9	36.94	28636979.00	28636979.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4be795ca-f2ca-465f-b17b-2d7602fdd8f9	4a0d7efc-9da9-4d53-b66f-62e4dd7e66d7	2	9	9	47.43	33458726.00	33458726.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4f5956a4-427e-4947-9044-5e94258c4f2d	9221d1df-f6c3-4db0-a412-2cc6b4c9cacb	2	9	9	47.38	34133421.00	34133421.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ffd1f021-a6c9-493f-a2bb-fa55f91bfa42	fcdfc271-544d-4bbc-887e-82be590faa12	3	2	14	80.99	51750633.00	51750633.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
075c671d-f0dd-426a-a047-821e6505adc3	cc7240cf-df21-4fc9-a2d9-b5c355de2736	2	7	9	64.26	41691304.00	41691304.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
880ef22c-c3e9-4f33-891d-aad474f15050	003522fd-385b-4462-824e-281d843f7ad2	4	2	14	104.71	51726740.00	51726740.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d562c0aa-0661-41c3-aa93-dc8db0261818	3ad6381d-4011-4277-a758-a8ae97d550e5	1	2	14	37.53	31184629.00	31184629.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
23c777cb-27fb-4a71-b7a6-b3c5a40d5f4c	b532a7c8-ddd8-4539-8145-eec0bf7922c5	3	2	14	85.64	52839398.00	52839398.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
df73b4b4-b1a3-4347-bf31-f0eaf173b9a4	56b32759-f221-4197-b57e-583c79ed9a97	3	2	14	85.79	51224542.00	51224542.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4f8e90e5-8826-43fb-a8e4-b384ad3b4093	d69192bf-df01-4848-9887-65d199dc23b5	3	3	14	80.06	42431800.00	42431800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5e058a61-39ae-43fb-9b12-fce094e94312	f9be68c1-ed74-483e-9adf-e80cf1f213b3	4	3	14	103.65	51721350.00	51721350.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7df36f7f-04d0-4c16-8b6b-013fc5eef054	dc91ea69-210f-45eb-847d-2dbb8f8c6653	1	3	14	36.95	25680250.00	25680250.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
950f0e22-db2d-4ce5-bc5c-87e8e008df0d	47e3bb6a-1bbf-4991-ac9a-06ffb65a2254	3	3	14	84.77	46708270.00	46708270.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6079a32d-6ab3-47cb-8d37-16dd10b9c619	7bfb5847-2e49-49eb-8c44-f9431d75e34f	4	3	14	116.93	59517370.00	59517370.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d693bf66-6b7f-479b-90ca-eca32cb0d344	7e64583c-1ac1-4b76-9be3-351fc6c62aee	3	4	14	80.06	43232400.00	43232400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
54b6ea49-ba67-4d5a-87f1-d04483adb4e5	9f782334-3454-4ce3-93fd-bca59f091da6	4	4	14	103.65	52757850.00	52757850.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0a7750ee-3b23-4399-8fe2-733351848be1	3ac5dd32-3420-46ae-b0f4-4049d75e280d	1	4	14	36.95	24719550.00	24719550.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
76dd5481-98e8-4aaa-a947-0b51be587c88	f179d865-d5f3-4090-9e8b-f83d7535f912	3	4	14	84.77	47555970.00	47555970.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3036e7d5-da55-43c9-bb01-1659cb469878	1615a692-1036-4753-94d3-47823fcedb98	3	5	14	80.06	43232400.00	43232400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8992c33f-6fe6-4fdd-99d4-3432c98cced0	cda68ee6-8b4d-47e6-972f-3116d58cb043	4	5	14	103.65	52757850.00	52757850.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9ca4cd30-be79-4e14-8643-e385ebb7e30d	b866cb29-0b65-400b-8342-deb75cbab18e	1	5	9	37.05	28085964.00	28085964.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f52c0359-7f4c-47c0-b476-56ec9a1c947e	90307fe6-9b93-4951-b935-529f6846f648	2	4	9	48.31	36893152.00	36893152.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a80872d3-ca07-4f63-824c-6bca448ebb96	2ed95db8-e1c6-4834-8ec0-6f53a36336f3	2	4	9	47.37	35045483.00	35045483.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ba74e37b-4ff2-4411-a16d-453c69521f1c	b65fe562-5e75-4600-b527-308d275b1c7f	2	6	9	48.42	36965642.00	36965642.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3470c22e-865a-4893-8d6c-0a7c57e8c5e9	e783bc51-656c-4d10-9f8e-98cfe5b9be7d	3	5	9	90.95	55274466.00	55274466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3600780a-1cc1-435c-b72e-50ac813a8a5a	de5cd221-7a32-48cc-aa8d-62103b56d169	2	6	9	57.8	42123127.00	42123127.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
46bef5bd-2e9d-48e2-bb05-9f336e6ea033	74b3f052-884f-4983-b0af-e29cfe9c52a6	3	6	14	87.5	53900000.00	53900000.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7e11a01c-409e-45dc-8a8a-341c27093b1f	0e6da590-0887-4af1-8fbd-bee2ffa87d4e	4	6	14	116.72	60577680.00	60577680.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4180ef26-cc4e-4db4-82e4-1c7f1669e589	1a2f90c3-cd42-4bb4-80a0-1c2cd74ccfd5	3	7	9	90.95	55274466.00	55274466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2d180172-17c7-411b-af5b-7be226182871	aee2abf3-159d-4862-a37b-a87efad77996	4	8	14	103.39	51591610.00	51591610.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0d0c160c-f7f3-4934-a537-1fe1a33503ad	fcaa40a5-1704-4c7f-a3e9-6e36990d914e	3	9	14	87.5	53462500.00	53462500.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9f6f5348-52ff-490d-96e5-0c27e5c59e4a	92a7b1e3-b1a7-4390-91f6-b5e03a826c4d	4	9	14	116.72	59410480.00	59410480.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1e7fb705-1d6a-4ce1-b93b-42dd122c18c3	8ab9a9f3-8f70-4458-b291-17cbbf99a136	3	10	14	79.76	42272800.00	42272800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0f3a4f3e-d02f-4150-aee3-6491023a7835	890a4262-2f4c-4075-a93b-1ad03334fb25	4	10	14	106.31	62616590.00	62616590.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b7ac8759-aa7b-4160-8dc0-9f69a194ab8a	138fe62d-103d-49f2-a2cf-0cc8292abdc8	3	10	14	87.44	53425840.00	53425840.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
22492369-58b5-42a7-b777-cce6d8c1bf2b	da3a9904-fade-42dc-ae43-d17cbfa4a8e0	4	10	14	116.63	59364670.00	59364670.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d669a176-8a7f-4475-83b2-e25ce0a9ab72	39bab8b3-f4fe-40a8-b06f-f596dcc1e4d8	4	11	14	103.59	51691410.00	51691410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c5e22ffd-cce0-4b61-9765-026edc5d6ce6	8755a2a8-b9c8-415f-97cd-5a0a95b3de07	3	11	14	84.43	46520930.00	46520930.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
79bac678-89df-4dd8-93b7-457935182b39	19950bb3-44ca-4133-93cd-45eb0b71fe09	4	11	14	116.63	58664890.00	58664890.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4fd6b0f2-e21e-461c-b41c-6b0ac661bb70	233a2e97-cef2-4fd3-9625-fd8a3af5416f	3	12	14	80.06	42431800.00	42431800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3186caf8-d99d-43c1-95d6-7a89f033824e	d053e2d9-b7a7-41d3-b704-516111ee8785	2	8	9	64.26	41048704.00	41048704.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
bac4c580-50b4-40c4-bb84-0b0a83c55b8f	707715e2-fd56-4a0b-9730-79e40a68e180	4	12	14	103.59	51691410.00	51691410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e98ba394-58aa-424e-ba67-addcabbc0bcc	2232c613-8244-4f0f-86d5-6ee9f2bc7175	4	12	14	119.55	67665300.00	67665300.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5b058664-4eab-47b2-a010-c054ec7ae5f7	20909192-2f48-495f-8e94-34e49219e45d	3	13	14	80.06	42431800.00	42431800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
dd27096f-f53f-49d0-95c3-779b49fe4016	c8c66df7-16fc-408f-868e-28bb5334f21e	4	13	14	103.59	51691410.00	51691410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f9928772-b62e-4a56-9a2b-9f028764dcf7	da5eff70-bf08-4874-bdf0-b2c8548552f4	4	13	14	116.63	59364670.00	59364670.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9cd12d54-3b90-40ca-9e9f-2b23d25754e1	16e7a8dd-cb7e-4833-a1ae-49613e84ec1c	3	14	14	80.06	41631200.00	41631200.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
98afb105-2bb0-4ff9-8ac4-c8357c018147	cf81bcbd-2d07-44ab-bbff-a15f24fa988f	4	14	14	103.59	50655510.00	50655510.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
17211620-d91f-4f73-82ec-74f78f4908f4	efc2ecdb-1137-41c4-afe7-e4a440e9112b	3	14	14	84.43	45676630.00	45676630.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9179a16e-c87d-49f5-bc1b-d4268f58a20f	49fbc0ed-e402-4797-89c3-77578e043a98	4	14	14	116.63	58198370.00	58198370.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4e1de1a9-d96a-4044-b522-e1b0b4eddadb	96b6fe4b-d030-445c-a01a-6d999e01d334	3	8	9	90.95	54364966.00	54364966.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1b7d4d35-36d4-4b62-8d0d-07947947922f	36beea26-efcf-4184-982b-3754488c7adf	2	9	9	63.43	39959760.00	39959760.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6719f2c6-a9d5-4ab7-ac7b-33648754d543	0e1bd21a-0f4a-43df-9063-22cdce7a4fee	2	9	9	63.46	39978032.00	39978032.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
db768e06-1780-411e-a451-5fc69dc152bf	fea425ba-d17c-4f9e-b4db-01863b56da28	3	2	9	71.39	43510146.00	43510146.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b38f8ea5-d465-4985-a39b-c891ba7c8331	54f3cbad-12a4-4986-8b50-3cd163d3e04c	2	2	9	64.82	40498024.00	40498024.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1941e858-3e06-44d7-8f1f-e40ae18e5e03	e2081e93-855c-4ed1-b39f-e5f06ca2a2d7	3	3	9	90.95	54364966.00	54364966.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b95a6492-91eb-4a8f-900a-c0d1bf763fe3	f2f4768a-89af-46d6-8b76-21c301901d42	2	3	9	64.11	40980879.00	40980879.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ac59e10b-d185-4e9b-bc01-163118978060	973f692a-ebd1-4c53-b297-bf3e3b085132	3	4	9	90.95	55274466.00	55274466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8bc0cf08-e27f-443b-ac60-cbd7ae5ae7c8	23b491eb-238e-4a30-b8c5-3a1e74782d41	1	4	9	37.08	28137053.00	28137053.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3400b566-04d7-4484-adbb-6a63771a5384	cfd91097-cb25-4c6a-bc5d-0c3a08507dcd	1	4	9	37.08	28753878.00	28753878.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b22be7b7-e25a-4e16-9103-66f6460f866c	095825f8-1f7a-41fe-a5c1-7bef7335a6b5	2	4	9	64.11	45853239.00	45853239.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
95871aed-fdc9-4886-adfe-efae5a447e0b	1be25955-4103-4fb5-ace7-89ccbe1ba281	3	5	9	90.95	64278516.00	64278516.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4a1d5275-f78f-49a8-8cba-c3c59c803626	c8c163d2-8472-4dbc-bda6-5b4e52b69766	1	5	9	37.08	28160598.00	28160598.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
78e9d93a-3362-400f-993b-d5fd5a2e3e33	df33d082-6c20-4590-ae58-8ddc378e524b	2	5	9	64.07	45878612.00	45878612.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
12c3c94e-0d1c-4ca0-974d-e315e32d4bd1	f3ae3217-d263-4847-b574-60d8f0c2c7a4	2	3	9	64.26	41046273.00	41046273.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0b7bdbd7-ded8-4db4-bb69-eac91594b973	8b00967e-b901-486c-978b-23fe3f350fb6	2	5	9	64.11	41621979.00	41621979.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
42dff0f4-1c87-4078-a407-927508049ae5	b45e5718-a683-466c-8993-79d890c48aae	3	6	9	90.95	55274466.00	55274466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
655134a2-fbe3-4305-9dc4-e76ca6db975e	27ee641f-c657-4018-806b-c0c6a0953767	1	6	9	37	28078410.00	28078410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
27fc1cad-3600-4154-9447-871192653768	be4b1846-d06e-425b-a235-a194deb1acf0	2	6	9	64.04	41628079.00	41628079.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
85db19df-cf37-4abb-bd76-ca1186926f35	deab4a1f-a506-4fd2-9878-c02e8e27427c	2	6	9	64.08	45830964.00	45830964.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fad4568c-a0fb-46f4-a0c2-d279225dbaa0	e21540f6-68dc-11ee-a82a-001dd8b72708	2	7	8	55.5	79920000.00	79920000.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
731baa5d-4af1-42f9-992d-982059a6178a	550e6529-51bf-40bf-8de5-6969ee6d9df9	1	7	9	37	28078410.00	28078410.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
22f24d90-bccd-41d2-89f1-394e93a1473d	8b8b3738-c73f-44d5-a838-193c8954b76f	3	7	14	79.76	43070400.00	43070400.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c9f65802-e305-482e-a9aa-0e867bb549f0	3fba10d0-a749-4e35-b310-1b4f758f7085	4	7	14	106.4	63733600.00	63733600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
98e0b171-9129-475d-b8db-be4ee6ae86cc	0b725a57-02b6-47af-9100-6943e424efa7	3	8	14	79.76	49451200.00	49451200.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
1a4fee61-31ab-4041-98f1-3a7af69b4601	700b9ec6-b4f6-4549-901e-0902266bd5a3	4	6	14	103.39	51591610.00	51591610.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
af5f82a5-20ff-4b0a-8366-1862a1560a05	3c300d91-1b98-4562-83f9-c17ff65f6de7	2	7	9	64.08	41601684.00	41601684.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8f00fdfc-73cd-4e03-a857-1b7bb902ce7b	0b10a270-1542-4b87-92ce-55a3afaa16c4	2	8	9	64.04	40987679.00	40987679.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
57afe155-0201-4504-9645-d35638b925cb	e37fadf3-8d24-4921-b207-ad2b42063423	2	9	9	64.05	40304244.00	40304244.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
739e67d5-7451-4bd9-9c7c-3fa6a63a89e9	07b65b44-b480-49be-9156-f2992ddab601	3	2	12	80.62	50706233.00	50706233.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
baf0d2e6-fc7b-4a16-9f69-2487b50d1854	15fb2e56-6036-4380-99e5-d4dbd4658f29	1	2	12	37.53	30921919.00	30921919.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9335bd50-0b42-4aff-908a-531376983aab	8fbeb77f-f838-4789-92f8-24ae05b7880b	3	2	12	85.11	45363630.00	45363630.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
15d58edc-4699-467e-8c89-bbe2b1660186	08d6ee4d-4c5f-43c1-999a-bc009fde24ac	4	3	12	103.29	51541710.00	51541710.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6bd6b73d-455e-4743-b288-3c2ebab015da	18a940be-3104-4a7a-9e86-71d87b0d6c7f	1	3	12	36.87	26103960.00	26103960.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e92bf7be-3ee8-471a-b93c-d84097b065fb	06abc14a-1ecf-4258-9184-acf7c1fbe262	3	4	12	79.6	42267600.00	42267600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
77b7e50e-c0e7-4fd5-a189-91d803f51f8a	e9590abb-24c6-40c8-8a44-8f3d138597df	1	4	12	36.87	26103960.00	26103960.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8c574ecb-e03a-47f9-816f-056c2b19a8c6	a2435516-e79e-47da-93c1-50402129eaf1	4	4	12	116.47	59050290.00	59050290.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e34835df-1076-4d5e-865e-4cd804d8ebe7	a8b33d03-83c8-45ef-ae50-fef7d4f1b3e3	3	5	12	79.6	49431600.00	49431600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e9729ef6-3601-449d-8401-ea010697ceb6	aed02c46-96ac-4bf5-bf40-1bc19775542a	4	5	12	105.75	63344250.00	63344250.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6008ee81-bd29-4934-ad48-a5200389d1e1	0a25e018-5a2e-48bf-9dfc-0a00a8fde0a5	1	5	12	36.87	26103960.00	26103960.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fdb5e303-d6a2-4d20-8733-ae97a0e2a65b	c68cc2b7-4eff-4edf-81f6-279e7a337432	3	5	12	86.97	52790790.00	52790790.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6a402c83-8809-4ffe-98ec-bce8afc3dcb8	7e5b94e1-078c-45bc-9a36-aecf71dce1ba	3	7	9	66.93	44173800.00	44173800.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a38b2e00-18e7-4c36-9299-7065a19bccbb	9f2a4da9-fed1-45f5-b490-c0aef393de03	3	8	9	70.97	42156180.00	42156180.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
69a3d55e-5126-4303-bfde-2e6c4915c0a1	6a64bc16-ba3f-4c48-8b5f-c47ff397fdd1	3	8	9	66.93	39087120.00	39087120.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4dc92b63-52cb-45fe-9a53-b8d59e8df82b	b5912c3c-b2da-4f8d-8584-33eee3fed94d	3	9	9	70.97	41801330.00	41801330.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
00faa8b6-f679-4b08-88e8-5de7df9082fb	cd196b68-5b0a-4229-85c4-328fd49c52ee	1	9	9	33.25	21446250.00	21446250.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5402da02-bddb-4d82-91ad-7a221d828218	e34c73d5-e501-44da-8f69-e06b6c01bcb1	1	9	9	33.94	21857360.00	21857360.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
66469e3e-f88f-4593-b990-b0f666f0f95e	bf2b0d8d-30c4-45af-b511-2dc43258e86c	3	9	9	66.93	38752470.00	38752470.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
30c54dc4-11fd-40fc-ab1c-0c51581b2004	dc48169e-3ca2-4591-8066-efdb7a77cd97	3	2	9	66.15	37705500.00	37705500.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7cb07465-7520-4ed8-bf19-357df200d027	988eb893-5ff9-4877-b4f5-c2524ffceed1	3	2	9	79.47	43390620.00	43390620.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2ca321fc-f1e0-4214-8a75-90a1f0b9f59d	317910f6-8af8-4406-8c03-9178d847547b	1	3	9	33.26	22716580.00	22716580.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
acd43cb3-8d93-4957-a454-bfa68d1a0bd4	76df88b4-53ca-4912-a568-80463d170161	3	3	9	69.56	40692600.00	40692600.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d3ecc113-92be-4681-8291-b7aa81e1dcbe	c053381e-dfe8-47f6-8229-39c442b0194a	3	4	9	65.57	43341770.00	43341770.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
64fc59d8-5ae6-4e20-91fa-8ff41ef9edb1	8096f2d2-2101-45f8-9a89-5eb64f204ebd	1	4	9	32.58	22284720.00	22284720.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
40ddae3e-96e7-40db-bc86-419967efea55	020f3f79-cd9a-40dd-85d5-cb3bee7476bb	3	4	9	69.56	40692600.00	40692600.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ac115541-788a-41ca-a54a-bdbe455fb652	e2d929e4-a2eb-4677-a171-2a6e99142a96	1	5	9	33.26	22716580.00	22716580.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ac0d6faf-536c-44c7-b477-dd0a68b8c5b8	f08c1813-fdb6-463b-b66e-eabc981bda84	3	5	9	69.56	45631360.00	45631360.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fb5435ca-2c9a-433b-bb36-09782905cb87	feb499e6-3550-4908-9a89-2a00af21aad7	3	6	9	66.65	43989000.00	43989000.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
bcdbef81-036f-4661-bf96-e2dc1b3b2758	3067aa47-87ca-4377-8b7f-814f33c05905	1	6	9	33.16	22681440.00	22681440.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
4029e937-d442-4c0a-b6d2-fb4ef0f78fa1	d557aa00-55bb-4c7c-bc5c-8ca439abff81	3	6	9	70.74	41312160.00	41312160.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
993b31b9-dbea-4227-8d1e-39693899fffa	05dbe909-37df-4b29-913c-bb780f60c9df	3	7	9	66.65	39256850.00	39256850.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e76c1379-b443-4a84-952b-d9556c824c40	13b10678-2f89-4cf9-9928-2e8a55c70cd0	3	7	9	70.74	41312160.00	41312160.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
586e11ba-ddea-4d9f-8361-b240b0930a45	7e0b16be-584c-4fb9-8c1c-bceb2d774d88	1	8	9	33.85	22307150.00	22307150.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f252b237-edeb-4707-a746-353fe58925c7	d934bc04-2c73-4422-9d13-91623205f5db	3	8	9	70.74	40958460.00	40958460.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9d1f7398-f55e-4fd1-8ede-0f61628e9931	1ad2f5f6-b691-4acf-bf15-0093b7809fd5	3	9	9	66.65	38590350.00	38590350.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f6cf71e0-83f4-4545-be53-6e8fe4a59485	4e33a041-0b1c-425e-bc2e-e43a9b1f69cd	1	9	9	33.85	21799400.00	21799400.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ccb5b043-532d-4f12-91f0-075d6f7a6246	4bd989e8-c85c-4c06-9340-4368f19272b6	1	9	9	33.16	21388200.00	21388200.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3ccccfaa-301b-4eb7-a517-adc445f2bd0f	bdd863be-6077-466d-958a-57cd996db99b	3	9	9	70.74	40604760.00	40604760.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a758da81-2b13-452f-94f3-c4df260debb7	284ba990-bde8-4392-9ec3-b23cb5070010	3	2	9	78.97	42485860.00	42485860.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2274ba84-3a10-445e-99ea-ec7c4db06d23	4cb19366-6246-40b0-86b7-6863a47247d7	1	3	9	38.8	26267600.00	26267600.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9efb8ccf-3d08-46f1-a54d-341531396b71	e3affe1e-506d-41e5-bc99-13fd0e013ca9	1	7	9	37	28101954.00	28101954.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b7efdf5c-1982-430e-b519-37f6207d39ca	1073b5b0-7651-4493-995f-5cb64c8f9efb	2	7	9	64.04	41628079.00	41628079.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
797dd8ae-1e46-42d7-82f7-4f9de5e9656c	e2f818b9-211b-4e47-bb4d-bb62ea31f156	2	3	9	64.28	41058653.00	41058653.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
12979dec-e0fa-4340-9a45-073e9c9aa3fd	ad17130d-4183-4e3e-be96-f7bcff2dc628	2	8	9	64.08	40960884.00	40960884.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f5537d06-5409-4c23-8b3b-547dcc8ca5da	1b98be0a-59fe-4702-8c57-2b61e54b8109	3	9	9	90.95	53455466.00	53455466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
12189c43-acc5-44c2-8454-20e5ca35563d	528792c8-7ad5-49ff-bc13-f3074591e51a	2	9	9	63.27	39992641.00	39992641.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0151d84c-bef0-4528-a5e3-373684d63249	69085f20-b59f-49ef-88d4-f5a91a1478cc	2	4	9	51.55	35105550.00	35105550.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
70678737-8fe8-48f7-9344-2d79ae7e989b	5ea9f5dc-a19c-439b-b8e6-4b4a6eeb5aa2	3	4	9	96.11	51322740.00	51322740.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3797e60f-44bc-494c-b493-d28f8a6f7bff	a867254a-a1dd-4869-be08-a65474e6690a	3	5	9	96.11	58434880.00	58434880.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d90b25f5-34ef-4450-91ee-77d8ab596f0f	434cd60f-eec0-4efe-84d5-7a1305b1af4e	4	5	9	100.41	61049280.00	61049280.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f1e0bbec-896f-4ffb-995e-417562c6c625	fe10ea20-2ea5-4573-9117-849ff5c5e7ee	2	6	9	50.42	33327620.00	33327620.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
dddb38f2-9f71-4f45-87cf-96697a309ea1	bab791bd-a972-45c9-94df-0e3f6d28a5fe	3	6	9	98.64	52377840.00	52377840.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
0acf35b9-12d4-4119-8f26-27c90ec97b0d	05934cea-69c2-4d40-a803-450e860f324f	4	6	9	103.77	53130240.00	53130240.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
5afaf0fc-5106-48f5-af1d-c58cd283ccd6	33c92304-414e-4036-8893-392c0ac8f8b3	3	7	9	98.64	52377840.00	52377840.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
54158b58-cc5e-40d6-9172-c5f896b84b2e	2b7267f7-77ab-4349-9b18-d8d801a6204f	1	6	9	33.84	23112720.00	23112720.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
8899a12d-cdb0-452c-bc2f-e5cd9f7a2101	5b313df6-821b-47db-8e03-8d4e6a7f6b22	2	8	9	52.55	34315150.00	34315150.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7729a4cb-a92c-4ae1-974e-57435a444e6f	a5f4b76e-f4b6-4cba-bac0-820299925701	3	8	9	98.64	51884640.00	51884640.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ebd08518-4c0d-4564-952d-6d13208d85e3	d93e9c61-68a0-45dd-b78e-3ba3e95e550b	4	8	9	103.77	53130240.00	53130240.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e8b304b1-5b53-46a6-a376-98b04d144b80	8d748307-c39e-4ff7-9505-0a8bfb628f80	1	9	9	39.44	25162720.00	25162720.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
28e131a0-5286-40a9-ab3e-58d1268c8c5d	a30d1c5a-8272-4933-805c-f94a19df26bb	2	9	9	50.42	31260400.00	31260400.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2ad24f10-0a96-43ca-96a4-811c9b6f97c3	4e32f7ae-6051-4ecc-8e10-4cca9f9d352d	1	9	9	39.74	25314380.00	25314380.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7dd82cfa-97ac-48f7-8013-f70dc7cf4c09	a310a8d9-48a1-4365-82ce-800e8f35ccd4	2	9	9	52.55	34052400.00	34052400.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3adac956-047c-4bbf-aba6-ef3cc80373e3	b40386b7-d2af-4a09-aaa2-6288e55b08d5	3	9	9	98.64	51391440.00	51391440.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
022ebca4-c419-41a1-8de4-9a8fec630e27	13496db6-6fb8-40ea-8e68-88360c123ddc	4	9	9	103.77	52611390.00	52611390.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
de33af40-13be-4070-b9cf-3130a7ed9ece	32dfb11c-b8a3-4c4e-9a37-e08b8764d6ba	3	7	9	66.69	44015400.00	44015400.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b244c4f5-1f8c-4539-a430-e607f6f8b79f	61213b9f-16cc-45f9-a2b5-7d1a301713c0	3	8	9	71.08	41155320.00	41155320.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
d832a1f3-6bc7-40c9-bc42-05f1a963c369	a7e450b7-34b2-4cd4-b859-b7582cfabddf	3	9	9	71.08	40799920.00	40799920.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6999ce75-de42-4abe-8280-e4dd3ae2f81b	6d558865-0e39-4176-a50f-236725506581	3	2	9	66.17	37716900.00	37716900.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9390e831-d998-401c-a0b7-9735f22e91a8	0b2f5dd5-6186-4b7a-9d80-a4ffca150afe	3	9	9	66.69	38613510.00	38613510.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7fb964dc-1322-45a5-911c-376a9e98b413	9916ed1c-46c4-4315-b98e-8315ac2f4c0e	3	2	9	85.05	45756900.00	45756900.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6bae4ff0-d7f1-4723-8abd-2c00a4f4d6f7	ab953e43-545a-4333-afbd-5fe11282237d	3	2	9	68.14	39930040.00	39930040.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
64e58e72-238b-4d7b-b8c1-365207dd909c	3bc976c7-f192-48ce-b8b5-9681cf56de2a	3	2	9	79.65	43966800.00	43966800.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ca308778-86f3-49bd-8ee4-d377aee2e2ef	dbfc1111-cc1c-4d14-93a7-892e62aec5d8	2	3	9	47.67	32320260.00	32320260.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b4db3b32-d5f4-4fbd-b85e-7e5cac33da7b	b000fbd7-8dbe-4eb1-8e3e-547207c41dc5	3	3	9	68.31	40097970.00	40097970.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
88733eab-cda0-4bb0-8a99-9a0412c80fa3	a2d1c651-fe1d-4391-9a03-509ba1bab2e0	3	3	9	68.16	46144320.00	46144320.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
50c73ae8-9e22-42a5-a035-98058f3aff50	949438ea-e20f-4f89-85aa-26cfd343cadc	2	3	9	44.44	29552600.00	29552600.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
eab2492d-571a-43a8-b37d-fb82242bd1a7	7c55880c-433f-4b9e-9295-ec6e99bfa0a2	4	3	9	100.17	62005230.00	62005230.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
38b3112a-0811-422a-a92e-b0e6ecaeea28	3136217c-d16e-42da-b31b-6da6e6452106	3	4	9	85.09	53776880.00	53776880.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
229bde0b-e3ec-4ffb-9002-b0c3eb183849	32105578-3060-4c86-bf51-14d85c07f5dc	1	4	9	34.24	23385920.00	23385920.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7d872e0b-1a35-4182-8de3-dd708e47d3d2	ec875cfa-6d41-40b1-9e34-d755415435dd	2	4	9	44.44	30930240.00	30930240.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
bce177fc-d196-4788-b708-2ecb3fc7c62d	f3586cbc-cc4a-430c-9698-d6529c1823ca	4	4	9	100.17	53190270.00	53190270.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
e1d65779-a648-4b31-aef3-53424ea9d9bf	c5a1f05c-def7-45f2-9cc8-f7859af77404	1	3	9	32.59	22291560.00	22291560.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
eeb07f3e-ed5e-42ff-b09b-0ae3b3af3a5b	7d6bee5c-b2a7-4903-bda8-3ab65d7ede3b	2	5	9	47.67	32320260.00	32320260.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6d739508-fe38-4264-8386-dddf0988310c	4206a3ed-9157-41e3-a7c5-f6c648778adc	3	5	9	68.16	46144320.00	46144320.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9185e71d-fa91-447f-bca4-e812c4f22c18	dbee53de-83bf-489a-adff-cfb784976290	4	5	9	100.17	62005230.00	62005230.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
84b5e953-9f71-4f9b-9c60-f10267b080a8	6e0fb64e-06eb-40a6-890b-e571640ebb78	1	6	9	34.83	23754060.00	23754060.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6a65a4db-117d-4eb8-b9f4-51b025855883	0b8ac007-3ff1-43d5-a812-02fa66bb77d0	3	6	9	70.22	42412880.00	42412880.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a50675be-f071-4030-a9c0-91b3ffc60084	81e98f40-3ef2-4348-8f56-84bd29784d38	2	6	9	45.02	31333920.00	31333920.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
a3b6d864-0021-41c2-ad4a-a90971a886b4	fc34fb82-fe07-48d2-b6ae-50abda1a7800	3	7	9	86.72	48216320.00	48216320.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c10ebfe5-b530-48bc-ac8b-86f2ed860402	111ccb88-522a-47fd-b7c1-9bba65871ce8	2	7	9	48.39	31259940.00	31259940.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fcba2718-b33f-4d86-ad53-903ae974162f	b1e4cfdc-0883-47e6-ac86-ba92ae28f9fd	3	3	9	96.11	51322740.00	51322740.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
ec61eccf-96d5-434c-bf7b-24a7f7b5dd17	6f823948-a649-4885-8e10-0e565c5dbeb4	4	3	9	100.41	61049280.00	61049280.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b85e25be-9a86-4849-9cc5-1d73c8d0ac8d	50630fb2-8d17-4127-87f4-fd09523aecae	2	4	9	49.71	32908020.00	32908020.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
7ac0cbd3-8df3-4533-9d82-50d311f9f039	f7840607-0ac9-4345-9a21-6a65958b0fa4	4	4	9	100.41	52213200.00	52213200.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
feaa8d04-1c41-4e4d-82c9-64665eec692d	8c3a0800-96ac-4b95-bc42-0bd0953f6e7d	3	6	9	71.08	46557400.00	46557400.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9f0c9f4e-e759-4c99-9cc5-cc0457904660	03032cfc-1dfa-4a36-92e1-5e2dd8a2e020	1	5	9	38.8	26267600.00	26267600.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
07c9beee-81de-4da1-9fe5-7935b0e092ef	86964077-0036-4108-a32c-d961736c78f3	3	3	8	88.78	51137280.00	51137280.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
a388474a-db21-4aee-beca-0a77bdcc143f	1de8727f-e3c0-4a2a-a90e-fbe2f9944bd8	2	4	12	51.53	32360840.00	32360840.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
6fdf7d44-bed9-45fc-b632-491afcc180b6	dc7be057-c6e1-485d-9108-bb5de5966ac1	4	9	9	103.53	53525010.00	53525010.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
bb5e311f-4091-45bb-9ab8-b17ede4ecc5c	373d969c-c3e1-46f2-9e47-461d0697a0ad	3	4	9	68.31	44947980.00	44947980.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
69f3a6db-2f59-41d7-bf10-98d22bdc9255	b0023dc7-3f3a-49e2-9f75-87c1ca57a887	3	2	9	79.52	44610720.00	44610720.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
618229e5-7c90-47ad-be0b-2a122cdb8493	f1e3ee2e-0ab2-48da-a130-55dc7fd9480b	3	2	9	66.14	37699800.00	37699800.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
225e7efb-8bcf-49b3-ba7d-f03f0c8be2cd	6f6801d5-6966-4bbd-8747-0bbcd50b8440	3	3	9	69.56	41736000.00	41736000.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
540dc478-b4e0-4e75-8bbf-879cd509992c	e7fb0c31-f4f4-4f7f-8cb4-a15db64020a8	3	4	9	69.56	46674760.00	46674760.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
57a648c8-f707-440b-9257-2f3319135842	935e7caa-d48b-44b4-8b13-bf14bde16bfc	1	4	9	33.34	22771220.00	22771220.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
fdf68411-a557-456a-8f87-5d069928019d	494609e5-1a93-4b63-93e9-d890acf8db74	3	5	9	69.56	41736000.00	41736000.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
41566190-a291-4bc3-94da-ab581802366f	84948efc-9e5a-4b39-86d4-0d95d8bb014c	3	6	9	70.97	47549900.00	47549900.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
faa19c9d-c167-49e2-8491-c95261c90f96	f66f0ee6-9a28-47da-9fd7-0e22aa6e90c3	1	6	9	33.94	23181020.00	23181020.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
707e6b30-b173-4ff8-b946-4f682e09f15b	c55d38e6-4aaf-4643-9d3d-93bc8b8705d1	3	6	9	66.93	39421770.00	39421770.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
57603332-f179-46b6-95e2-145ae67f1326	88c65b9c-f343-4e78-9cc1-93776945330d	3	7	9	70.97	42511030.00	42511030.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b332637b-e66c-48d1-914f-9603cebcfbb1	df19f3e6-a893-4548-a494-766ae8c2eb86	3	2	9	77.84	50206800.00	50206800.00		2026-03-20	t	dbdae371-974f-48c5-a2a7-f4952e1ec47f
dbeeace8-b611-4e27-a6f4-6e9c326e68d0	664943a4-06f4-41c1-9071-9a394b7043be	3	8	9	88	43676160.00	43676160.00		2026-03-20	t	dbdae371-974f-48c5-a2a7-f4952e1ec47f
de6f397b-6be8-4882-a159-eb20c622edbb	5730e713-4f20-4570-8ef3-bf350da32adf	3	2	9	89.6	81536000.00	81536000.00		2025-10-31	t	9d0833f8-ac76-43af-8030-5ead1717ed48
6482b850-961e-4f79-acce-a00fbb7079ec	f95f2f56-7c51-411c-97fb-e6278c95af20	3	2	9	71.36	50451520.00	50451520.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
4afdd1e1-204e-415f-82f3-732dd5c09d79	af1f34e5-e9d1-47bc-8204-54324a78b444	3	2	9	79.05	51856800.00	51856800.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
c03a782a-93b9-4199-8187-3823018adae0	b932770b-a8c4-4541-8dcb-2725298b2b45	3	3	9	75.42	57017520.00	57017520.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
19111f0e-712e-4d1d-b760-8bb4502dab21	ecb93298-d295-4eb6-9831-c30111c9f456	3	9	9	75.42	56263320.00	56263320.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
02c8adce-bbbc-4d78-aa97-9c5cd02f72a2	019a4b48-d295-4145-9b18-6663a91f891d	3	3	9	73.99	55936440.00	55936440.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
24be6746-3968-43d4-a7b4-e768b4d33c2c	6d39087a-6721-406d-9a2f-723e11b27b98	3	4	9	73.75	55755000.00	55755000.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
3bdd4d56-4237-4f61-b945-920b995f0974	e84c4ab1-a908-459b-82ea-d6e46d4e2585	3	8	9	73.75	55755000.00	55755000.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
93f4cfe3-2555-4a4f-80ea-610f13afc1eb	243cf00d-f999-4118-8bc8-751564f6cea8	3	2	9	77.86	51932620.00	51932620.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
0c71a2b7-933d-4b19-8ed8-665469bc2d83	af86ab24-2a72-4ff0-8d65-76ddc1f8e16c	3	2	9	73.87	51265780.00	51265780.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
40f9c514-20eb-46e5-8915-17902c9fa0f3	c376d24b-4f8f-41d3-bd60-e9b5912ffe67	3	7	9	89.62	68380060.00	68380060.00		2026-06-26	t	9d0833f8-ac76-43af-8030-5ead1717ed48
c1235a6c-75bb-4c84-b39f-4ca0be247521	0c02cc1a-68dd-11ee-a82a-001dd8b72708	3	7	8	125.34	144517020.00	144517020.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
4ddaa557-3222-47d8-a704-036396318281	518e6ee0-1d44-486f-8eba-901e8188c98f	4	6	9	109.97	68181400.00	68181400.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
4d90c712-8d93-4897-ba32-6d8f7d611831	b6bb14a4-c2b3-47ac-b10b-f5106e927b16	3	10	17	71.04	44826240.00	44826240.00		2026-09-29	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
5d523144-2b70-49a0-a1c6-025ad0fe1bcb	236e50d1-f4b1-404c-8646-29402846dcc6	2	2	9	57.51	38743306.00	38743306.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
67216308-94e8-412e-9b75-0e8616b11272	8caf08b1-808b-4c35-bfb3-d9a005e8643d	3	2	9	90.22	49169900.00	49169900.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
29aea76b-3ff5-443b-8637-8b4d0e2a825b	9064516d-707f-4555-9dbb-ab295091dd16	2	7	9	62	36890000.00	36890000.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
9d3ab3cd-fe3d-463c-aeff-a7cc399d4de0	4a7ee43d-64cc-44b4-924d-987887c57308	2	7	12	54.21	36917010.00	36917010.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
cd9ddf96-c2ef-4e07-ae91-1e38443d94de	97e589d5-ed31-4cda-9e51-68a380783cb1	4	3	12	113.31	62887050.00	62887050.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
a6154e68-36bb-4253-9387-be320f2def3b	92c6cec2-0dfb-4aa8-88ca-21840d747b20	4	8	12	113.31	61753950.00	61753950.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
ca569e37-5154-4f6a-ad72-5bdeef934ac6	28282392-58e6-4f9b-a179-e4b95538d257	2	9	16	65.79	57171510.00	57171510.00		2026-10-23	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e951a2ad-aa16-4cf6-8b9b-22610e4c07fd	651b87ec-2c10-4f74-bfc4-6a48b7829930	3	2	9	106.3	81425800.00	81425800.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
c22987ff-c368-4481-ba92-edfec62b5aea	70ae8e5b-54bb-4d92-ad92-c3412f60c203	3	8	9	101.47	81886290.00	81886290.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
227ad2d4-0e1d-480c-8361-9a8c7ea1b481	14b3bf2d-b198-4096-9cd8-0f25c1e2bfcd	2	2	9	52.38	49446720.00	49446720.00		2026-08-28	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8f60f825-ec9e-4f19-b42e-d8402a2d1b03	54359445-f183-4922-b699-0470d14025f1	1	2	9	41.43	37287000.00	37287000.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
579ab021-5ab3-48ea-a1e0-5d5d786bc36c	43a11a73-77a3-45a6-ace1-dcf7fe6b1fa1	4	7	9	103.53	63670950.00	63670950.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
11718d43-e50d-427d-a01c-ac45fcf54505	555e2e44-622d-4a45-9b17-e6e17564215a	3	8	9	70.22	42061780.00	42061780.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
6780075f-5001-419f-97cc-75ffaa3aad1e	b3025323-742b-4aaa-9a14-1e0f99cce702	2	8	9	45.02	29713200.00	29713200.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
27257c6d-94b8-413f-9efc-808ed2ab3a3f	f676daa8-db67-4f9b-b384-27b7c996eff9	4	8	9	103.53	54042660.00	54042660.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
01cf44cf-9143-4680-8f5e-46ca2859936f	eecd21c2-267f-42fd-af5a-fdac9741dd37	3	9	9	86.72	47349120.00	47349120.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
968d121e-959c-460a-9c7d-adb5348e6a5b	0e0edbd2-dc58-4291-9edb-9205c4d76972	2	9	9	48.39	30776040.00	30776040.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2827a6de-1b3a-4191-8f8b-972d1ddec4ca	1cf3011e-c2ad-440a-b86c-772ab3363a92	3	9	9	70.22	41710680.00	41710680.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
c6d96fd6-7d3c-45a3-885f-f9a9c7118f6c	fcc61882-b726-4d28-b7ab-53b625d5436f	2	9	9	45.02	29488100.00	29488100.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
3b0a5777-40bf-47c4-ab0e-c5fff6f35586	09104a89-0e84-481c-a760-6b7bc2e6148b	3	9	14	79.75	48169000.00	48169000.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
cc2b45a4-e4ea-4eca-bd5a-29ac3a3361d8	6a39a200-2e12-4027-a53a-fea1a183f609	3	9	12	102.41	79060520.00	79060520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
f8c2dc90-66fb-42db-aced-5e22dd37f40d	dd0ecb8d-f141-4d80-8034-efedb9767743	4	3	9	135.79	104558300.00	104558300.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a6257c43-97c8-4f3e-ab5a-90482910d842	7d561dd8-76e2-4af8-8d79-62c6f3efd2ae	2	3	9	62.94	65389038.00	65389038.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
e242276e-5e0a-4599-88e0-5ee00c84be49	47f399b8-e79c-49f6-94cd-ce7bae69b10d	2	6	9	62.94	58402698.00	58402698.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
a6c02dfe-0080-43a3-ba27-0f15b8ef5809	c04b6983-7b1e-4a71-b24d-2016b50d3ee4	4	9	9	123.67	86692670.00	86692670.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
ef432043-fe19-43b8-af92-ab0b0bc7cfc0	788ab281-3372-48a3-a564-a6ffee94b996	3	5	9	74.31	48970290.00	48970290.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fde6de12-f2c4-4baa-a374-1ec144084f33	042ef61e-1a63-4764-a89e-8798940b2055	4	7	9	121.56	61266240.00	61266240.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
07f3b5b1-5fa3-4b89-981d-13571884f148	7215c55b-4e40-48d3-9d20-a643b2c45e83	4	8	9	121.58	60303680.00	60303680.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
f2ba9e79-02f1-4dce-b54f-5e9ff532fdb7	89d5e4f5-a05f-4607-840c-5d5a9e4aab19	3	4	9	82.42	54292462.00	54292462.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
79c655d6-fdd5-49b0-95d8-6f572a4b7d86	b6c61ee9-bafc-4307-8d9d-d7f8644d5e59	4	4	9	112.56	66410400.00	66410400.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
07c96cc1-c487-49d9-9ac5-59e3897f607c	edfb4fb5-54cf-4557-80e5-55a676778ff3	4	2	9	115.1	61118100.00	61118100.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
67139732-b857-4daf-9cda-33d837a66975	ea77a51c-6194-4bf9-82a8-df6831376225	4	7	12	118.84	67025760.00	67025760.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
634b5672-d243-4bb2-9af8-3027a88314cf	9329a993-23c2-40c1-8d34-e4e5bcbcd46a	3	2	9	71.27	44083296.00	44083296.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
2746d327-30f6-458e-9759-13e06ac4bab1	0f8c5edb-df6f-4a46-a39a-9d81197bc826	2	9	9	47.38	34199003.00	34199003.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
44c58e46-0811-4400-8bf3-6812a6d05ea0	4ec6e55c-a2b7-4f89-90bb-82f4e1634bc2	4	5	14	116.93	60686670.00	60686670.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
262b812a-0294-481e-a10d-b077f299ff19	0405c8ba-e53a-4eef-9afd-96d2b3190f82	3	11	14	80.06	49637200.00	49637200.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
bd32b874-351b-4be7-9265-2dc2decf7a08	01eb88e2-5c09-420a-a6df-7d55c362d536	3	7	9	90.95	55274466.00	55274466.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
70b2fa0b-d3e3-4d2d-94e8-6b4d98f836f3	e3c05b3c-0a87-4174-a21d-2139cad85dcc	4	3	12	118.9	65870600.00	65870600.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
9a16eca2-050e-40b2-9c1d-801c4c9a70ee	88e5bb04-3cba-4c66-94d7-4bf80514a327	3	5	9	65.64	43388040.00	43388040.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
92eb9c2f-1def-4d9a-bf5d-b992c304557f	0dd76f20-13c6-4f00-8bd4-b50fe2825425	4	7	9	103.77	62780850.00	62780850.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
aef63bea-493b-4ff3-a1e1-ab952423f1ff	b47be2e4-f19e-4de8-8d85-ac81599be8d2	3	7	9	70.22	42412880.00	42412880.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
f03054d8-0edf-4687-82d3-f4f35bc44d40	9d403c4e-6ae7-4244-a4e2-a50b770d72f5	3	5	9	65.65	43394650.00	43394650.00		2026-11-27	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
694b5ce4-f09b-45db-aeac-9b0ab6982618	d2765945-ef06-4873-a551-4ce6333c24c2	4	10	16	114.91	84343940.00	84343940.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
07cbad9d-07b8-4320-af1d-a18d319eaff2	d05b5a1f-8334-43ea-a6d5-9da02873aea1	4	12	16	114.91	89514890.00	89514890.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
b551bc6f-1e62-4ccb-8bce-e0722d396e0f	779f19b4-355d-40db-bdaf-1f7675960371	2	5	9	62.86	56825440.00	56825440.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
188a224b-e4b5-4d7a-80fc-f877ea75eed8	4e0426f6-8986-43dd-8820-f1587751b5e1	3	14	16	83.1	60829200.00	60829200.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
cfc909b6-bf84-4c3d-8e72-4ae68b620736	5841e326-b1ec-46d7-b167-7ca649d4beb4	1	15	16	35.78	32488240.00	32488240.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
559beffa-2c31-4237-9786-66b3fd4c0eca	d7135350-491f-4519-966e-e0ab41b1b903	4	16	16	113.77	80776700.00	80776700.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
e0459436-21c6-4091-9f2a-51ef9ac22e58	f51f66f0-cbaa-4bb6-bc3c-97adddb1af62	3	3	9	69.21	52530390.00	52530390.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
a833cb54-a583-427c-a659-85f9234ee341	972866e5-b50c-4da1-a124-b85135a23b9f	3	9	9	89.81	62777190.00	62777190.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
aa6ade88-fe94-4e33-94ab-70f47de62c3c	a98b6c24-f6ba-4aa3-abf0-c55b82ea552f	1	9	9	35.86	29978960.00	29978960.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
11e2dbb6-7a7b-4313-bc4a-b55452a865d9	d40d8cfb-c0e8-4990-9889-185cd170808a	3	9	9	79.14	54369180.00	54369180.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
79250639-0eb3-4a44-82eb-fb4283ba04ef	3ccda1df-c45e-4e38-a647-88acf98c138a	2	9	9	57.06	44449740.00	44449740.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
f4d92933-33e6-4c4b-8c83-f1700c28e635	fabb7f23-8a5a-48e0-a587-0c9aa0b6c3f5	2	9	9	56.83	44270570.00	44270570.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
cde6e564-26dc-4e90-b3b2-7527472e664b	c106cfec-c24a-4968-9a1e-eebeb71a402f	3	2	8	69.45	58268550.00	58268550.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
7c4d932b-31e8-4833-b3eb-6d589cf3655f	52ecba41-0954-4f81-9aad-cc90f0a811f2	3	4	16	83.17	62793350.00	62793350.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
d3bb6e6c-dce5-4387-b107-a14b3632cc27	3f503086-2348-4f01-b07f-6d37797b2036	4	5	16	114.95	84373300.00	84373300.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
fa02790f-5962-4ce8-ba14-0a59d1816824	e9199758-cceb-4d83-a419-7a880d44c330	4	6	16	114.95	85522800.00	85522800.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
d378e49a-9594-485e-924e-8204ab3ef6cf	6dc3ee07-fe27-4653-9b1e-6a10b6d05c0e	4	7	16	102.55	77015050.00	77015050.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
4617ce9a-907c-481c-869a-2825272ca3d5	96b9f6e4-36ec-4712-a86b-603f7547a443	4	10	16	114.95	82304200.00	82304200.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
f79a3921-9f3a-44d5-b22b-5778719d812e	461d384d-d6c6-458e-a192-ed27f9e7b8c1	4	12	16	114.95	87476950.00	87476950.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
cd5cd8b3-bb9f-4e05-9077-0c2d2e43ed87	c4f10e45-a75a-4dbd-8249-9f065f1b6b4b	4	13	16	114.95	82304200.00	82304200.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
114bb40c-5c25-407a-a6c7-fb14c279dc43	8c7d626b-d52f-418f-8d71-8cade7a51194	4	14	16	114.95	87476950.00	87476950.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
f3b14240-8a96-4d48-9f40-2f49178061a8	4cff7388-64d9-403c-ac9d-4674858a6161	4	15	16	114.95	82304200.00	82304200.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
8633dcd0-d171-4e64-9366-13e8b3a3c7f7	6ca30a38-6f5d-4665-8e66-66529e4beb64	2	2	6	56.77	49162820.00	49162820.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
c4169c96-f07b-45bc-8857-308b92519a25	80b4618e-68dd-11ee-a82a-001dd8b72708	3	8	8	126.37	151896740.00	151896740.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
0d4909c3-44de-4a8f-8881-b23e29b3c124	92ae1f6d-68dd-11ee-a82a-001dd8b72708	2	8	8	57.11	71615940.00	71615940.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
9ff8eae1-b15a-47cc-8599-8b586a48fae0	7e6a138a-3e01-49a9-b431-e0f5bdfd6fdf	4	11	12	121.34	82147180.00	82147180.00		2026-07-24	t	97d12c96-1111-4481-8bd5-6eb5d51a915e
fe3d6141-1c79-4935-a802-3d5d2c44d2da	596d0ea1-7a84-4a5b-af16-65ec4775b038	4	3	9	129.81	100862370.00	100862370.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
6ba02498-04a7-4802-93bc-fda004e10d60	13d78eb3-dba7-4d08-8a84-aa4046a2819d	2	6	16	45.28	43242400.00	43242400.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
3deb49ab-eca3-4056-b2c1-d7f6d0bfec63	cbe8424a-255a-478d-8faa-4adfa782a71b	2	8	9	53.57	30642040.00	30642040.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a4a9b205-3b7a-4fee-9d5e-ba353c76cdea	ed385aef-94ac-497d-84a8-c76e4bce98a2	3	2	9	91.07	48813520.00	48813520.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
c41c5c5a-c6e8-4a52-bcfb-521c6dd16fb8	d2a9c691-e9c6-461a-ba57-4d8e256d89f6	4	4	9	121.58	75622760.00	75622760.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
00643add-8e03-4af3-bd5f-e591ab94fde7	b4d6dab3-4034-4ddc-9dc9-e5424a9038f0	3	3	9	81.02	46019360.00	46019360.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
fb8a3908-8e43-4dd7-9c01-16850083ea4b	4a98ca43-4235-46ad-a4c7-f69db016715d	2	3	9	64.5	43279500.00	43279500.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
2aee983e-e33c-4740-8f6e-88993695a1f7	fb30a80e-6aea-465b-9b16-5b153d0d05dd	3	3	9	91.07	58193730.00	58193730.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
d2866a21-2d4a-45b2-a336-431541b3eb46	eaf8d83a-fcf6-4240-8e16-9e188b92b420	3	4	9	81.07	52776570.00	52776570.00		2026-10-30	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
aba69f7c-c69d-4587-851c-2572e0e665c4	eff5e268-a4b7-40c8-a279-bead28df12c5	3	4	9	69.16	45991400.00	45991400.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
584eb9cf-2478-4495-af85-42663b34ebc1	627ffb05-f43c-4c66-80b6-e091e9ef022f	2	3	6	54.52	49286080.00	49286080.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
6410ea33-705d-4bb3-9ab5-0ead4e0aa6c9	d6130a1d-2086-47c2-829e-dab6401e0fa1	2	3	6	54.52	49286080.00	49286080.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
ba47f876-5378-4399-ac2c-a41c4e0e3afe	17b2431f-557c-4a13-93d2-5bb6de2b11e7	3	5	6	86.9	67086800.00	67086800.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
08590ef2-06b7-41a8-b2fa-3735acb8a758	9f70605b-fc2f-493b-b0ce-cf68add0522e	2	5	6	54.52	48468280.00	48468280.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
369ed985-2b98-4d87-9faa-2c4f97880224	2f5c816c-d282-4fb9-899e-317c5eb699f8	3	2	16	84.33	61982550.00	61982550.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
9ec47f19-e2a5-4375-a2c8-4ca537f89092	55d6c14e-c4a5-4737-a6a5-7a0b40aee45b	4	3	16	114.88	79956480.00	79956480.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
a664a31b-bb8f-4c87-8f7d-db1968fc59ef	88c2e942-0a40-4d42-bfb0-b77db1fa2f52	3	4	16	80.19	54288630.00	54288630.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
4cf88dae-28a6-49f8-ad31-978e31e39009	33f1819a-5378-4f35-8764-8882bb9cc232	4	6	16	114.88	82024320.00	82024320.00		2026-08-21	t	fec52f0e-66db-42a7-8757-b8723db9aa12
7f356c2f-c66d-4ba8-89b5-65d324e8f64b	2355bc30-f99e-4637-a9aa-38a0b717720c	3	3	12	71.5	46618000.00	46618000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
034b9509-a2ef-44d1-ae71-0a46a8ce7edb	ff135eed-b583-4d4d-9048-32009df8768e	3	10	12	72.66	40035660.00	40035660.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3ac32cec-6615-4876-a109-09b4a092226f	964c9948-c1fc-4f2f-aa37-2ce6de242aa9	3	11	12	74.68	39132320.00	39132320.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
55e2b84b-fffe-4f2b-b5b6-1d005c243c38	81dbce5f-3d81-4d61-af2e-16d8558455c9	3	12	12	74.68	38758920.00	38758920.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a95402bd-76e8-43fd-a41d-1fca8b7e717f	8db93377-dbe7-4789-b892-82e3b74dc026	2	12	12	61.62	35924460.00	35924460.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7dcc2578-6612-4d47-828a-b0f223b177e5	bde30bf7-4ce2-4435-86d1-14e56f20d195	3	4	12	73.42	40748100.00	40748100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f22cf249-69fc-4d78-aef9-db4c5f20d554	7fdea165-b209-48c1-874d-9872c4f4aff7	3	12	12	72.66	38945760.00	38945760.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
523b5d7a-6504-4f01-a822-db251f58daea	a4d61cf6-68dd-11ee-a82a-001dd8b72708	2	8	8	55.48	69960280.00	69960280.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
bb2675e8-1be1-4e3b-a0f2-06497bc69e22	5efa7602-68e6-11ee-a82a-001dd8b72708	2	4	8	58.33	75304030.00	75304030.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
892262ab-72d1-43b0-8fa8-b43ae544a4cb	488522c4-4500-4d85-a0ea-ed6d01c3440e	1	4	12	35.97	27588990.00	27588990.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
b8f3b691-bab6-416d-9785-eae544a7c9b7	80d79052-f0b7-40ec-8b53-5ab63e47fe6c	3	9	9	81.97	37460290.00	37460290.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3af89bd6-46f8-4c4d-bd29-fa01c7721ffc	b9c791e8-bf21-4dd5-92e2-c9b914ccab60	2	9	9	53.57	30106340.00	30106340.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0981596f-6ed2-4a08-8f84-2dcb59a211bb	6382e633-10cf-4a59-bf37-7fa4cda6bdba	2	2	9	39.21	23094690.00	23094690.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
714106d4-f2d2-49c5-9282-4a192fd3c289	ed6eb34e-3474-4d51-a517-e1b48b7e90f7	4	3	9	86.22	47507220.00	47507220.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
26b8f378-daac-4ac1-ace8-560b9ee3acb2	b684feba-b241-4e79-832d-58c700fd10f0	2	4	9	46.15	27459250.00	27459250.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
58551138-146e-4f88-924b-05857720d58c	e5b7b5de-1bd1-46c4-b8e0-8e8769e81b4e	4	5	9	86.22	47507220.00	47507220.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b3ad1efa-8007-4294-8a63-706ec2f89c95	ee6b0213-f5aa-4772-9916-38ed356740b3	2	6	9	46.15	27459250.00	27459250.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2146d8df-f4ef-4f58-a0d5-bcce4754f8e7	22411e00-9162-4e2f-a258-d368c5fa4b70	2	7	9	46.15	27459250.00	27459250.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b407e7bd-60b6-41cf-a6ee-26b4308ecfbb	4200a05d-7edd-4955-9b97-a21d537cda59	4	7	9	86.22	47507220.00	47507220.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
af03e53d-a68e-4956-b56e-6d7be79618ef	29bc95a8-0158-4ed7-bf67-84a52efffb91	4	8	9	86.22	43627320.00	43627320.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0ebb73ba-9c20-4bd8-9881-2c323b759e09	bd9f5aa1-7b1a-4292-86bd-75cfb377b797	3	7	9	84.7	39216100.00	39216100.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
73a9ac97-7b68-4379-a2aa-10bc025e21af	4ac8aefc-7f68-4dce-b1a3-650fb0a4dc71	2	2	9	38.81	23635290.00	23635290.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b6279352-f236-4e29-87fd-78c30ee01259	3b39d9fd-9d84-444c-890c-915d99d9d63d	2	3	9	46.15	27459250.00	27459250.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
50176f01-3259-4114-b884-df0225a808a5	348e479d-847a-41fe-bb69-34b0757bb959	4	4	9	86.22	47507220.00	47507220.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b575ef69-5c66-4e38-8c33-f8c00e8af373	43015694-e546-415b-81a6-e2bc2bb4dfd4	4	6	9	86.22	47507220.00	47507220.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d53444f2-f2af-4ee3-b4f4-d3d75c96a4ce	49344ee3-9356-4325-9fee-4857b980471d	2	6	9	46.15	27459250.00	27459250.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ffc60b67-14f0-494a-a101-e69f9c4a4b27	aabdffc6-484a-4d04-9635-e706723d3e07	4	8	9	86.22	41040720.00	41040720.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6cb8827c-0db5-49b7-866a-9aa8d5b6deba	15d9f868-a73d-4334-ae73-0f51036d9bf9	3	4	9	85	40885000.00	40885000.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
117747fc-ef7d-4c4a-86d8-d4696381a35e	f6837bfc-ebc1-4a0a-82d2-8cd3330759d3	3	6	9	85	40885000.00	40885000.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
66b1eae2-ec8f-4a53-b43b-540466ece7eb	e83afad6-ac33-48ac-9d88-1affc0132cbc	3	9	9	85	38335000.00	38335000.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
21191e92-ba0e-4f3c-8155-25869cc18045	0ff0c177-dccc-48ec-94c3-8c913bb45e1c	2	2	9	39.55	23255400.00	23255400.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2cbb4a04-7946-4cb8-bea3-e804950eb01b	76bb0399-7240-41c0-9234-2f45ff05d43e	2	2	9	39.56	23261280.00	23261280.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
9e652c01-c736-411e-b503-357234c86b64	d9a5ee26-eb76-45a5-ab62-f2e56576e645	4	3	9	87.84	51997708.00	51997708.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6e56453d-63bd-4e07-a9f6-a47c8dba1314	dd9a7998-4f56-4b27-9781-39dab24e3ee4	2	9	9	60.66	52592220.00	52592220.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
018a7acd-62cd-45ba-a193-c9be33d7501f	7697a74f-147c-4ab9-8fda-47bdc3f05e1e	2	4	9	61.31	40403290.00	40403290.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
41cd55ec-dc6e-4ecb-af7e-949a8a993836	3410c255-fbd4-4124-9e98-00fd1b0fa5c8	2	5	9	59.87	39574070.00	39574070.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
40decaf3-65b6-489c-a7ed-27d5781b208a	2c2e717f-d6a4-40e6-b3db-67fd8b3f11ac	4	5	9	115.5	68491500.00	68491500.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4a70c7f5-9b10-4fe7-850e-18bd553e8184	654e0535-1de0-48e1-b75b-1c85cd33c503	3	6	9	68.59	44995040.00	44995040.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2e11c412-c0cb-4848-b6cb-15e3ad3aa0d9	57f4ec83-899d-458b-808d-a0ebcdd6e781	1	6	9	40.53	28168350.00	28168350.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1498628b-5b96-403d-9733-3b57b3edc0d6	f012192a-3f24-4ad1-8152-dd3672bc83b6	2	6	9	62.25	40960500.00	40960500.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
df9e6e4d-0548-43db-986b-79f8ee08e2a3	35acb414-c898-4e11-806c-2f7919fc7a7b	1	4	12	33.72	24042360.00	24042360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
69c15eaa-f6d2-4216-8630-218781f29157	07935224-6962-4412-a228-ca70e0c717d2	4	6	9	117.44	65061760.00	65061760.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b07caa82-d605-4c19-b66f-7e5e37c0f9ed	abb357d0-5cd3-48e4-a5f9-b8d225c8e65c	3	7	9	68.59	38821940.00	38821940.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0baaece6-aa28-442f-98d2-8e05e4d00686	1449ed20-a19a-45da-b9fd-e0449e1dbfff	4	7	9	117.44	65061760.00	65061760.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
faba375e-e2ae-4f4c-adf3-dc1a3fdf6eb2	36325176-2833-448a-b7f8-ee18d4d96b8f	3	9	9	68.59	37793090.00	37793090.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5a7158ad-e929-4691-b24a-a79ca7f250f3	2f9de42c-8a34-40bb-8ffe-f73b5fb301e5	4	9	9	117.44	62243200.00	62243200.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
cb4d33d9-9e32-4620-bf98-282f5debd319	2b2ccba8-9435-44cc-90d1-d194fc8cebaa	3	5	12	73.42	47355900.00	47355900.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8e24e0b0-6ba0-4cf8-96c4-1755e4e705e9	849026ec-ff3d-48e6-a558-eed011eafb34	3	3	9	83.49	53600580.00	53600580.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c31caac1-3305-4ff6-a07c-f9dafc697b42	6b0656a1-9e95-4803-874e-c2d518412b55	1	3	9	36.9	25424100.00	25424100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
bec04712-d4da-49f4-a220-31602317f10b	fa5434a4-76de-4e4f-bef1-2c82d1421b6e	3	3	9	83.76	53773920.00	53773920.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
390c203f-f00f-49e9-9a5a-131bc53de7e4	eec3d7c9-1e2b-4064-9e05-2a882f7f2621	2	5	12	60.52	38067080.00	38067080.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ec270d01-cf30-49b1-a49b-9e6f436c0e73	1c7f1063-6b66-47a2-b17c-8ef65b88bdba	1	4	9	41.36	28703840.00	28703840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5e0b0e86-2ce3-4e29-aa9f-2abe2ef02042	64504a83-4cf6-4d93-b8f0-0074e6d2ee38	3	5	9	83.49	53600580.00	53600580.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0a255280-2676-4fdd-a988-46ff0401d91d	715b46ab-3c29-461b-8d9a-7578f19f5f0d	1	5	9	36.9	25424100.00	25424100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
02695659-a2c6-4f97-a5ba-ea46384378ea	ca4a46b4-75d3-4d93-916c-5cf6f0b7adde	3	5	9	83.76	53773920.00	53773920.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6f9cfd7a-b4b5-4898-9588-1c5e7012a45d	f40cb052-30d3-4301-9790-d90c5214c638	1	5	12	33.54	23914020.00	23914020.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0d8032bd-3704-4a73-af75-5b3c16413478	97d2a0fb-5cf8-4a36-9126-42028fc3bf97	3	8	9	87	52026000.00	52026000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
575c3371-a433-4e3e-b4fd-812486c4a788	f27fb533-4405-4f5d-8b79-9e181e7cde1f	1	9	9	37.09	25555010.00	25555010.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
58209f4b-d5e2-41f0-868b-e91aed6d660d	1e523462-1c21-45c0-983b-a492646c0ff0	1	9	9	37.53	25895700.00	25895700.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d9d52397-4619-45cb-9e2b-78ebb329cc78	6ec82ed1-eb3a-4378-8dd1-8e2f26b35d37	3	9	9	87	47241000.00	47241000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5679deaf-11d6-4dd7-a5a7-16a06d3071b7	afbfa9f6-0330-4c25-80eb-b1f2e04b1799	2	2	12	59.94	35364600.00	35364600.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
72b045b7-91d4-4e03-a743-6d1513825d21	3c64deab-104a-463b-ac11-79b2fa4a33d7	3	5	12	71.5	46618000.00	46618000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ae1193f2-7141-474e-a4d2-c38a97351c12	472092e7-67b6-432e-947f-eb9cfbc32b17	2	3	12	59.94	36563400.00	36563400.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
267b9dea-5ee6-4ae5-b0ac-b3ccd894bbe6	c494d924-bdaa-4f03-a6cc-ee4b555a09f8	1	3	12	33.94	24708320.00	24708320.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
48f7803d-1afd-4f81-8363-33baf4536a8b	875e2ec6-50d3-47b3-aa7c-f9fe1f64b0c6	1	3	12	35.19	25547940.00	25547940.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e823955a-eb96-480a-997d-8874164351e3	6e313e16-f747-4cc5-8795-6f5796ad1ea2	3	3	12	78.82	51075360.00	51075360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
89a4eb17-38ba-4a84-b847-55c7951838b5	fa92755e-73d8-4bac-8d3b-7ab7d1f3bfa1	3	6	12	73.42	40748100.00	40748100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f7fe7e47-cd69-41aa-be91-976848378d25	f62e57ff-0af4-4603-96f4-89dfd59d77f6	2	4	12	58.86	38965320.00	38965320.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
78ee2b3c-0726-4085-a296-a68ec4a551b3	e12263d0-9676-4ff4-88e0-e1b7baed8d9f	1	4	12	33.94	24708320.00	24708320.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
788d8c1a-dc00-49cc-ae19-c35ee177c734	aa24df39-0f44-4a2d-98e3-a4399bfe55fe	1	4	12	35.19	25020090.00	25020090.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6c668826-7a67-4b22-87eb-3e2fb0b735b9	bacca02e-86d0-4e3b-8a4e-666f6b0541b8	2	5	12	59.94	38421540.00	38421540.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8e6ba5e1-437b-4011-a684-28425291ff66	e94c080c-54d4-48b7-8334-030478d8653d	1	5	12	33.94	24199220.00	24199220.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
238d9eb6-ea85-4776-876e-12886c42eaa3	9a850f8c-9c9f-4f63-8603-ab482be857d5	3	5	12	78.82	51075360.00	51075360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b11bb629-b936-4ca1-a661-5d37d8ea6d23	3d3e6222-79e7-49f6-b9f5-52b4998a6408	2	6	12	60.52	39943200.00	39943200.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8860700d-d12e-4991-83a2-7cfe1e180a6e	49169660-67fd-4557-bea4-500097077d35	2	6	12	58.86	38965320.00	38965320.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8fe21d9a-a91a-41d2-b55a-47599f6db49f	9d820a08-17d2-4028-b46f-dd0a4fdc3174	1	6	12	35.19	25020090.00	25020090.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
20360ca3-7784-4335-8f7c-d01800ddc7c3	76b7a55a-34a3-45a4-a8a2-9edb36da6e6d	2	7	12	59.94	38421540.00	38421540.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7237ef7b-7418-4a86-9dbf-592580b489f3	e5eaf21e-3029-49a5-829b-62fa69f517bb	1	7	12	33.94	24199220.00	24199220.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6287bf25-b909-4d28-af56-edf7973ef701	c8e806a9-3cf6-48d6-b748-804c6abf6bf8	1	6	12	33.72	24042360.00	24042360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b46af119-f468-48eb-a833-0c8e588c88ac	1e59d145-2662-4078-a9df-29bab459e3c7	3	10	12	80.15	46246550.00	46246550.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
786d791a-56ee-4e12-a408-730180904108	eb469910-0822-42c6-a8b5-310650096548	2	12	12	61.83	36046890.00	36046890.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f2405fe8-1abe-4a70-95ec-724052943e86	baf0cf09-0cdd-4715-9e56-16558042f33a	2	3	9	59.87	39574070.00	39574070.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8fbc0b39-400d-4d79-9307-6eb976eec232	de728a9f-cd2c-4fcc-8ce5-e1571a5daa53	4	3	9	115.5	68491500.00	68491500.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ce7edad9-d90d-465e-b0e1-8b1c48a64936	24349e52-354e-4c94-a748-cd2acfe025d7	3	4	9	67.55	44380350.00	44380350.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1a29d935-002a-4a55-bb5e-8f22a18bfd77	7aa28b02-f009-4b9c-93c8-33ddb03f4f74	2	2	12	60.9	41478489.00	41478489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
14084e7b-df7e-4d48-af31-7c0c3e047d93	101b7df2-8741-4030-9cb3-a1f6d96a430c	2	2	12	57.18	38212148.00	38212148.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a5006505-9be7-4dc9-9bdc-80501825723f	84ce3165-c579-4f69-9265-1ce1d292aebd	4	2	12	101.4	64680682.00	64680682.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7a5a53e7-584b-49cb-a1b6-bbd1dc38a780	574f6934-e275-4089-89d3-a8008b6e5545	2	3	12	60.9	49395489.00	49395489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
9c4400ab-967b-4132-ac2e-d11c5e48e703	b8aad948-8c71-48b9-9df4-1737941c91f0	3	7	12	73.42	47355900.00	47355900.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1acc5fc6-845a-4d73-a6bb-40c1f9b0e2b1	7cdfa812-d61e-43ee-aa01-f24036be0ac4	2	3	12	53.21	37434757.00	37434757.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
853e47be-bce1-4389-9f52-32e6d6e4bf78	d32a2034-fb09-4e36-a72d-5521ea979f36	4	3	12	101.4	66708682.00	66708682.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
973e1011-8eba-4f94-aad5-91ade53d1c84	107afc1b-2f54-46df-ba5a-44b01b0eccb3	2	4	12	60.9	42696489.00	42696489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
652f8385-15a7-47db-b477-cbfaf01df122	e7118dfb-a4c0-4cf2-8d92-6a6f606a0e71	2	4	12	57.18	45531188.00	45531188.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ead9babc-c40a-4320-916a-c1080ca676ef	2d73ef71-ed3c-44b6-ae46-6afb935cfd42	2	4	12	53.21	37434757.00	37434757.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
df28662e-e995-41ce-b47c-7aa3c37a11c8	2267479e-4e29-470b-ad8c-ec80a24b8fae	4	4	12	101.4	77558482.00	77558482.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8827f56e-38ad-4efb-b39c-6acf0d80bc3e	ac800400-ede9-408c-958a-6c1b7c3921f6	2	5	12	57.18	39355748.00	39355748.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
480ba836-d19f-4fe8-95bc-7db546959f4e	710462f7-e275-4c4e-b938-2177f2aeefe5	2	5	12	53.21	43181437.00	43181437.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
852f16cf-9349-4aa7-bb43-1f4bf61e5828	25ba5b78-b8c1-429c-8df0-060da54594cc	4	5	12	101.4	66708682.00	66708682.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4535c91c-3c0d-4a5d-bf43-b4212cbd6efc	b58943e3-d08e-4d16-a2cd-9d6fc583651c	2	7	12	60.52	38067080.00	38067080.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
9c7910a4-9b2f-42b1-abbf-659b7c3c65ce	ae3288a3-1d6c-4386-bcb9-988ec98843d6	2	6	12	60.9	42696489.00	42696489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3466e3ff-22df-4464-809e-24e4195f3d7b	4ab9c11d-ca7f-4b7d-85e3-61bc2fff0bd2	2	6	12	57.18	45531188.00	45531188.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1aa43eb3-69cc-4503-b7a7-a2e24322bdf7	891432e9-8a4e-47dd-b167-6fe5cf8f1fd3	2	6	12	53.21	37434757.00	37434757.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
cd5cea6f-2901-47c0-b501-6493afc78fc0	bd8d54be-91e9-458f-8f46-29315e2e3636	4	6	12	101.4	77558482.00	77558482.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8384fab7-6714-4aee-9989-2e2ecab7a4ec	d3224cff-4a5c-4313-a5a3-36fb61a80737	2	7	12	60.9	42696489.00	42696489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2ec856a4-cfdc-443e-9456-f4f70b0ebeba	2e8ff2ce-326b-4efc-b3ed-c5bd8ce06145	2	7	12	57.18	39355748.00	39355748.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
57eb8652-94cd-4340-b178-96ac3abe23f9	73a40159-8c48-427a-b58d-2a5dd3a9b4c7	2	7	12	53.21	43181437.00	43181437.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a5c70769-a35b-47a0-8595-ab2c47fb11c8	6a4157a1-f405-4c16-b635-8133cd426097	4	7	12	101.4	66708682.00	66708682.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6cb358fa-7647-425d-800b-d4df2c010ffa	e0b4ee92-f3db-409d-a429-058f14922179	2	8	12	60.9	42087489.00	42087489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0e52ca23-f582-42ca-83bc-9d1e4b91c1cc	440a3e01-a255-4ff1-bc1b-0486ee873558	1	7	12	33.54	23914020.00	23914020.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e5aa32fc-c900-456e-881f-077146a702ef	69e8ce5b-8ed8-45e0-9720-7eb77df9a6af	2	8	12	53.21	36902657.00	36902657.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2b7da8be-1be2-47bf-9606-5ef86e5c920f	931e3faf-b491-4bc9-8616-b0350c19d36a	4	8	12	101.4	65694682.00	65694682.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2ef5d570-9cb8-43ac-b000-6056c6222a13	edd28cb5-b920-4226-85a7-f10100fcbf3b	2	9	12	61.92	42621733.00	42621733.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2bee3df1-30ce-4a16-b931-cadd9015584e	65cefb10-3564-492c-9327-fd7542e0d72f	2	9	12	58.19	39380657.00	39380657.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7eb7c500-38c7-4db5-b4e6-79334b91003a	206c527a-a6d3-4157-9e68-eefbc9067aa1	2	9	12	54.29	37568917.00	37568917.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0c5d0fba-a6dd-4d02-9d07-bcc03db652e1	4068811f-6941-40b6-82e1-f001b926421e	4	9	12	103.14	66610513.00	66610513.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
44b1e4ef-c4d3-4d43-903c-a226de7a56ab	f49fd241-ab53-423b-b53b-435e0f19f1c2	2	10	12	61.92	42621733.00	42621733.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e40a9ffc-1c82-467f-8680-8a1bab697962	ab216e42-d2bd-4106-a909-acec878d8d3e	2	10	12	58.19	39380657.00	39380657.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
bd46ef64-a88e-4624-b5fb-4e25d884bfd0	2b15934c-2468-424c-8d80-684bba1c70f1	2	10	12	54.29	37568917.00	37568917.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7ed635fc-268a-4fb3-8196-c13461127dbc	9565db5e-95b2-4556-9d50-59c2d2ad7b1e	4	10	12	103.14	66610513.00	66610513.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0c1894f3-165d-4ba6-aac0-08632ead6b9e	65f7beff-acd1-4cb2-a7c4-2a011ecab59a	1	7	12	33.72	24548160.00	24548160.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5ca94474-14dc-43ca-8ca1-b22969e4a034	8afacddd-3afb-4f62-af28-8f690fd7b4d0	2	11	12	61.92	42002533.00	42002533.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c6ef5a1e-52d9-40cd-8511-935f51f4d213	873326b6-a108-45c1-8951-d2635ea25216	2	11	12	58.19	38798757.00	38798757.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7b96008d-e847-4673-8336-ef821e66db25	aa6ccc98-be3b-46a1-b287-34db4bd09118	4	11	12	103.14	65579113.00	65579113.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e0b0da65-db7f-4533-be7f-79c18094949c	8f3053cb-1e8d-466b-af8c-2b66bedd9180	2	12	12	61.92	41692933.00	41692933.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ce967d72-5d22-4601-b280-ba2a6cc9e004	0be88531-1e79-4f44-b05b-b52b5b14a68a	2	12	12	58.19	38507807.00	38507807.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6e190af3-07e1-4a0f-994e-396388f18739	2565f134-9553-4fd5-8ddf-a4c771ee8009	2	12	12	54.29	36754567.00	36754567.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5937b42f-8517-4731-bbcc-1e3f4971cb9d	742fef57-412d-495e-ad56-f386b62a604c	4	12	12	103.14	65063413.00	65063413.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7f52efc0-066c-4267-a488-db66e51abd5d	09b8f80b-a7d9-4468-81ab-5fb908552664	2	2	12	51.51	35226553.00	35226553.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2b9fde9f-7207-47c5-b760-226cb47d3a1f	1d1cafbf-bc99-4736-be80-d4884337541d	3	7	12	71.5	40183000.00	40183000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0800e90d-2a46-47a7-b875-701fa762ddc3	6d918a4b-675c-4eee-b483-f1b8b042658a	1	2	12	36.28	28814445.00	28814445.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8298bdda-3ca8-44fb-901e-1a03de64d192	6fbdefc2-7f1c-4042-b3ab-9e8035375d8d	2	2	12	57.5	37870946.00	37870946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6e641356-5ad6-4a02-bcbf-3e19b41c7882	b6fdbc5d-1984-4763-a34a-511777c46555	2	12	12	60.75	35478000.00	35478000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
25114aef-7b7b-4eeb-acb6-d5a8286adebf	882eff66-b6af-41c3-80fc-a956c2767401	1	12	12	34.54	23867140.00	23867140.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b7c59578-b0df-4041-b27a-8a03e5cc3eea	08ffd616-cf29-469b-a336-2e3b4e3211dc	3	12	12	80.15	43441300.00	43441300.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
920bb842-dde0-4c12-8c5b-262763b062f9	582c5e1c-f98e-4be4-a577-e8781c1472e0	2	3	12	57.5	39020946.00	39020946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ce6dc98d-5e81-434c-b56a-bdb4d2948e84	a5299bb2-558b-4d2e-85ec-5333bd07e130	3	3	12	66.3	43475013.00	43475013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ca62b18c-6f1c-47ea-b687-6be38ed5180f	2a3f0a7e-17d9-4c69-b78a-fc8269290c60	2	4	12	51.51	41922853.00	41922853.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d9654fc3-9937-4a40-8737-39b3a9165cd3	b25a1fe4-301c-4308-bee6-a2de652d018e	2	4	12	57.63	39079221.00	39079221.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ff170785-dbd2-44a9-a4fc-b46d20918787	2d80d507-5ccd-4402-8368-defe5575d697	1	4	12	36.28	33857365.00	33857365.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4e7ec305-2d7e-46e9-b4ab-76c33b8cefcf	26dc9776-cc58-42e8-9718-72533e32cdba	2	4	12	57.5	39020946.00	39020946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
906e9c3c-0fb1-41db-90d1-fd6042c4e459	418fbdb8-fe93-4d4a-87ad-9e8027f7e57c	3	4	12	66.3	50768013.00	50768013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
59f96ba5-10d6-4d95-a8a7-d0c839d29a9b	5dabd3d8-fc1a-4720-b9a2-8cd9230acb0c	2	5	12	51.51	36256753.00	36256753.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0e2d88b2-10e0-42e3-8a2b-dcd90003b5a7	b4120aec-ef19-401a-aee8-ffb2569036b9	2	5	12	57.63	45303261.00	45303261.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
966e440f-7e9c-4363-9ac2-80c1c56e1473	e0e87d23-b50d-4554-ab73-e0d4335a9370	1	5	12	36.28	29902845.00	29902845.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f2149ae9-1c51-4ee9-8dd2-98116696a785	5bd47642-e9c2-4cb5-a4b0-1b5aba023d58	2	5	12	57.5	45230946.00	45230946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
824a972d-9cf6-43ba-9aef-8ff834419fca	979c1ef5-b1d2-4f55-bcde-4dd71f1be331	2	6	12	51.51	41922853.00	41922853.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7f2785f1-a6fb-4b36-8a06-3bf93bfc8c6a	1316ec18-b50d-424a-aae0-19cad6ec8c7a	2	6	12	57.63	39079221.00	39079221.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
72a0e862-2f45-4c0c-a458-710225ec7809	955464ef-c358-40bf-bd62-bf86599d0d86	1	6	12	36.28	33857365.00	33857365.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a28f85f6-af28-4c21-9185-2de92675b70d	b57da15a-8561-4b9d-a064-b99b4f1600d8	2	6	12	57.5	39020946.00	39020946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7943ba05-53a2-4eb9-9903-b90d3f4e5d07	e023c4ef-ba65-49c4-95c5-9bccbf738838	3	6	12	66.3	50768013.00	50768013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4f1170c8-f907-4ff9-9a27-228daec5e201	1f1cb293-f73e-41c3-ba64-cedebb8d4f9f	2	7	12	51.51	36256753.00	36256753.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a75ce57e-c282-4dd5-a641-c0db87ae0965	9124c051-f1b8-47cf-b259-b0843198fd76	2	7	12	57.63	45303261.00	45303261.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6af510bd-7b98-4255-ae4f-3ae75200b4ff	d38f7ea5-54a6-442d-8042-fcaae81b9f59	1	7	12	36.28	29902845.00	29902845.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
15354899-aa73-4371-ac99-feb9052c755f	62d38f8b-fa79-459a-a760-9818c7abc11a	2	7	12	57.5	45230946.00	45230946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4b3d5960-e11b-4964-964c-50f5ce4d7635	c4ab4172-38c0-4049-9296-0afae9b87b44	3	7	12	66.3	43475013.00	43475013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a677f54c-e126-4939-9aa7-1200ab2d735b	0c801f9b-4f4a-4292-aaf4-ab327963669f	2	8	12	51.51	35741653.00	35741653.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
74711ad0-b373-42ec-b426-69b72f6dad72	fccc44b4-1f52-4aa1-90e0-053bc806ba15	2	8	12	57.63	38502921.00	38502921.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e4faa25c-ac23-4188-9dc4-f6f8dca11c60	d89fc7fc-afb0-486e-8c30-076d4d7bbb0b	1	8	12	36.28	29503765.00	29503765.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
17e460b7-51b3-4a4e-a0aa-c37be34d64d2	02e994d4-979d-4086-8669-e6bba7974740	2	8	12	57.5	38445946.00	38445946.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6206009a-c314-48f1-b12b-cd2f9177172d	9b987e71-672c-4012-8836-2a9a456d4918	3	8	12	66.3	42812013.00	42812013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
197bc6d9-20d6-40e9-891b-1aef9529d4f8	a7bc5fa9-b063-4b54-afb8-8e5a54890c77	2	9	12	52.34	36274478.00	36274478.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3d4d0344-2edd-4bc6-a26a-0afb4d86237f	fd4cf35d-b86b-479c-ab3c-8cf9c5ba17a1	2	9	12	58.65	39133235.00	39133235.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
260ea099-9dee-48ad-be73-cdd07fce7074	6d76e70f-9e97-45af-b25d-640602405c6a	1	9	12	36.94	30044853.00	30044853.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
bbbd408b-27a5-47a6-b63f-34e5feaab434	42af3f05-6af5-47fc-877f-5cb9e1ca4dde	2	9	12	59.38	39574333.00	39574333.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e2b46296-a2f3-4e69-aaeb-f06a9a7a2016	cf8c8342-e590-4dc6-8e1b-cf94386d9904	3	9	12	68.24	43906637.00	43906637.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
6158ea9b-543f-47bd-ab9e-a43a1e219e30	f533e29f-869e-49e3-a804-cf9b367c3cb6	2	10	12	52.34	36274478.00	36274478.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3588845a-d8cc-40fa-9ff5-86d71b7b19e3	8d16d158-689c-44af-a5ea-53a593382ec7	2	10	12	58.65	39133235.00	39133235.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4e02c83a-ba75-4025-95a8-a1021f8127fd	1ee9a3a2-d077-4333-a383-9163cc725306	1	8	12	33.72	24210960.00	24210960.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
90fb910f-ebac-454c-a72e-40271765f78e	ef4326a7-e77c-46af-8ed9-fb91e5fac73c	1	10	12	36.94	30044853.00	30044853.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
bc49072b-9dc8-4a2d-b453-1b8629c69018	5b58166f-777a-433c-a227-7046658e2123	2	10	12	59.38	39574333.00	39574333.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
65836ca5-c05e-4469-aceb-a0ca8dcfbb89	bb13f5c3-140c-4988-b45d-c2fc08dd1353	3	10	12	68.24	43906637.00	43906637.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
40d14f50-8efc-425f-b381-fd2d8a407a8a	524c835f-b020-430f-8553-7563af06018d	2	11	12	52.34	35751078.00	35751078.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0e2d68ee-699c-42bf-b499-b63b7dbe76e0	f0150f46-d290-4a4c-aaba-b0e2a1a9dabe	2	11	12	58.65	38546735.00	38546735.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
635f6ac5-3629-4939-ae0c-c4471457d5b6	78076f8a-0c27-4f41-861f-f061904a7cb7	1	11	12	36.94	29675453.00	29675453.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7d03a834-fcef-4004-bf49-a045d5674aee	01d4a624-ed2b-43c3-8668-66f046653b33	2	11	12	59.38	38980533.00	38980533.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3f13b213-0196-44e2-bdc8-91c7c78773bc	e5c08fb0-9f4f-4c85-9fc1-ee9f8c69bad3	3	11	12	68.24	43224237.00	43224237.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
fd900b5d-0bc4-48bf-8e8e-b381f72b2732	b35a95c3-bc38-49b5-b58b-a1b4ede007c8	2	12	12	52.34	35489378.00	35489378.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d7bd0645-9130-453a-9fdc-21b60047f379	f547aec5-fc79-447b-b20f-838d741776aa	2	12	12	58.65	38253485.00	38253485.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f7e84417-ccf5-4877-8479-738628056cac	41de3f88-8633-4242-9a44-1dea075eefab	3	8	12	71.5	39468000.00	39468000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
3d2e3a3a-5758-454c-ac28-8cd2564e4d67	c3653d26-a686-4b82-8f3e-9b19c0ea34e2	1	12	12	36.94	29306053.00	29306053.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ad893218-dfec-4cf5-9098-6a04dcd08453	ec32b8de-debb-434b-bfb3-cad5e629cb9f	2	12	12	59.38	38683633.00	38683633.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
da091997-c481-42e8-a031-2d8eb0ff48be	9416b4cb-0d76-4fdf-9080-88fa3c228c36	2	3	12	51.51	36256753.00	36256753.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
19d0ed73-95a5-4a6f-9fbf-b9e13dc69810	a59cb206-3223-4f59-a8c5-ed175b89903e	1	3	12	36.28	29902845.00	29902845.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
13c96d82-2ff2-4ae3-8611-b33127573d04	0bdfc0d0-f667-4c2e-b289-0578d7fd24a0	3	9	12	75.48	40985640.00	40985640.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a5aa49f5-25b2-494a-b229-5730c33b7e0d	2c33ac4c-1c8e-4936-adfa-0b612f0bdc58	1	3	9	41.36	28703840.00	28703840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c0e60aa7-7b39-47f6-b0d5-abd2cddfb127	932631eb-2086-4449-af19-393e70bdf15c	3	3	9	83.76	47073120.00	47073120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0e541828-3c45-4d2b-ba86-f831ba3007bc	f46d2fe3-1841-4004-afbb-1beb5f51215e	3	4	9	84.26	52409720.00	52409720.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
deeb92d2-076b-4041-b7e7-9ad4dc5e2a9f	23dc853b-1a24-4515-8626-9a00b23e11f4	1	4	9	36.9	25977600.00	25977600.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
50f70658-1c66-47dd-8db0-66ddcc6bf6b1	4c947b85-a9ed-4490-bd9e-750dfa3aaf6e	1	4	9	41.36	28000720.00	28000720.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ad043e6b-4ba9-4029-92ac-c9489f8cbae0	d9fe5865-6083-4e0f-8524-65a15a6bf395	3	4	9	83.76	52098720.00	52098720.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
36dc5808-ccf2-4211-aebe-4525b67d0927	6090626c-4bcc-4cc3-8e26-68c516c3ad77	3	5	9	84.26	47354120.00	47354120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7c85577b-1268-4ed4-893f-121cb653b118	a34d81a0-0fec-44e2-92da-308e57e71b1f	1	5	9	36.46	25667840.00	25667840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0a44ae49-751a-4ab1-b4ff-3eac08bee4a7	9e226b60-8e8f-4cf3-b095-ac288d17c7d1	1	5	9	36.9	26531100.00	26531100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
35548100-2ce9-42be-8428-2c46513dead8	3065c2ce-c5e2-4f5c-80b6-4158940ad3fc	2	9	12	62.45	38531650.00	38531650.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
41ad2148-7f56-4708-970d-0e5e4e0c0de9	5923d950-4358-43f3-89bf-21924e334f36	3	5	9	83.76	47073120.00	47073120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e0169590-4ae1-4e52-817c-6ef886ca592d	1d806803-b0ee-484d-9d6d-cf036d56b467	1	6	9	37.09	26667710.00	26667710.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
2f4b3f1e-ad59-4661-9220-ee8bf93cea1d	8af35551-604d-4e6a-a1fd-5367be228e82	1	6	9	37.53	26383590.00	26383590.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d065e5e9-46b4-407b-9571-ccbaceb3ee59	a9e4046f-72a0-4a1e-aacf-ca231210e5be	1	6	9	42.05	28467850.00	28467850.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a56b1cdd-6b4c-4e50-a62a-d038147a348b	f57b4672-b600-4a6a-81a6-35f003f31872	3	6	9	87	48546000.00	48546000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4f04f06c-bac1-4b41-a102-a0e6de013271	175a0492-5831-482d-9586-236a6a64853a	3	7	9	87.49	48819420.00	48819420.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0a884d47-2636-4336-a5af-192883728f17	efaf338e-2a63-4439-a25a-0ae692bded71	1	7	9	37.09	26667710.00	26667710.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5b77cf51-41d2-482f-8981-4394a32a1e4e	b03158d6-2760-4cce-966d-aa58e472fdc4	3	7	9	87	48546000.00	48546000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e8038fed-0609-420d-80f3-720a9a8b09f2	c213bd3e-2c43-4e52-b755-c9ac715b96d8	3	8	9	87.49	47944520.00	47944520.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d3419b6a-2b5b-4923-b373-573cd8181298	0b44813d-c883-4237-92bd-ff76d2c8f8ed	1	8	9	37.53	26571240.00	26571240.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
65000bf8-be74-495c-8f0c-088d0ee54174	29c6bfea-93c9-4a86-a1d2-4c8511c166ae	3	8	9	87	47676000.00	47676000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e5927471-86d9-4b2f-a73d-25ddfd2f3f22	9ef0657b-5611-47fd-ac39-60951fde5258	3	9	9	87.49	47507070.00	47507070.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
97f7f149-cdac-4f5a-b87f-46740dc3f954	e8291a30-c89a-4493-a61e-23e59b0aad01	1	9	9	37.53	25445340.00	25445340.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
fcbf02c6-0837-44cd-8f00-73b9ab1241ff	4c0d2520-942f-461c-b2ef-616be6959daf	1	9	12	34.33	24614610.00	24614610.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b55236a0-8f52-4bba-ba0d-1e7a14f2880c	ddc542ad-3aa5-483b-ad01-ccfbb6e5b9a8	1	9	9	42.05	26996100.00	26996100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7c5f3aad-b362-4e1f-838f-28ed03776ede	5c981171-0e79-4844-9cfd-aa02473ef5cb	3	9	9	87	47241000.00	47241000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
cf2ca543-fe66-422b-9c37-83122a256ee6	e40e1c15-3b13-4ee4-b599-07dae5f0e12f	1	2	12	33.72	23165640.00	23165640.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0ecdb98a-d3b8-4021-88f1-a7dd4cc0928b	71533d41-2a70-424f-9a4d-82995519d5ba	3	9	12	72.66	40035660.00	40035660.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4c9336a8-0bc6-4a03-b22d-548fb03f09be	1a351599-b843-42e9-ae11-23725ca531a1	3	10	12	75.48	40985640.00	40985640.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e78b33de-26ab-4c2c-9e68-a62e7fbe3ccf	cd8ac422-28af-427a-9b39-01e7086df89e	2	10	12	62.45	38531650.00	38531650.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1b13a58f-f0e5-41e5-894c-f6623888f0f5	c9cf77f2-a2e1-4a71-bc15-1f5cc822ba43	1	10	12	34.15	24519700.00	24519700.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d5598566-8ced-4fd7-9eb4-9084cd1a1d5a	6f370f7f-95fc-4dbe-aeb1-56d6d0c788fe	1	10	12	34.33	24614610.00	24614610.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a043e8f4-925a-4b87-a892-86f48278971a	96906195-f181-4805-a4e3-5720af82f601	3	10	12	72.66	40035660.00	40035660.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a708621e-eb0b-4ecf-9c91-5e164a24e69b	4519168a-efa9-4a36-b7ce-b3243ae063a9	3	11	12	75.48	40230840.00	40230840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c9ef229f-0303-4a80-bb1f-50a31270f813	cceb0fdf-d06d-42ba-8749-08005a9d5149	3	11	12	72.66	39309060.00	39309060.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
5e609b67-4890-4ba5-bbbf-1b9e020972ba	d1358e13-a2ec-401d-9dac-f52bcda1b575	3	12	12	75.48	39853440.00	39853440.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
44dbf67c-54dc-4d87-92e1-2e08e618421b	8e2107d3-e4e0-4000-83cc-a40d32af9f3e	2	12	12	62.45	36345900.00	36345900.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
1c857e4e-7865-4863-b82e-e2a0499d381c	a22553e4-93d2-48e7-b728-64d3a4cf2280	3	12	12	72.66	38945760.00	38945760.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
271eb4d3-5eaf-41ca-a698-430a1bd0181d	653ce4d7-5449-4b23-9744-3c400e3f619f	3	3	12	73.42	40748100.00	40748100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a3d4574f-7c8b-4413-b13e-e99c5c25358c	80e05395-1307-411f-b575-9221fe1d2c75	3	3	12	73.42	46621700.00	46621700.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
01c87590-9e6a-4368-a623-cf916cdc60f0	dddb0c0f-6607-4389-9195-066b3f8e1a2f	2	3	12	60.62	38129980.00	38129980.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7d8a1730-7d72-439a-af07-acfb3405d75e	109f19ca-1e64-4e2a-bd30-4b944aca216b	1	3	12	33.54	24417120.00	24417120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f4a985d5-3af0-4f8f-b87b-0d68e6c4379b	e5f64157-62eb-4ff2-833b-ec512969747b	1	3	12	33.72	24548160.00	24548160.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
811b72fe-ddb6-476f-bbac-c23f851ef7b0	5b0e768f-f71b-4d60-8560-ea1c7de8fa5b	3	3	12	71.5	46618000.00	46618000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
d7523970-fd25-4cd8-be02-fe441cc3614b	d3886b8e-5c04-49f0-8067-8942da7715b3	3	4	12	73.42	40013900.00	40013900.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
7ad45327-b8fc-4b52-9718-48aaeea78f5e	02a3ed7b-8056-4e93-a745-8b57ee159ce7	2	4	12	60.62	40009200.00	40009200.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c39a4ba3-de97-4527-92dc-3d19faaea919	f463f468-2fc2-4d24-9c42-115584009b2f	3	3	9	84.26	47354120.00	47354120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
e406e39e-8fab-4a35-ab1d-fddd6923a0ed	1f004458-fba3-49d3-9ded-7b62b216ff10	1	3	9	36.46	25667840.00	25667840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
9eb7b364-2a96-4fee-abba-42de4099549b	383bc879-1f6e-4b9d-a072-c7886c2bacfb	1	3	9	36.9	26531100.00	26531100.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
009c23a6-0425-4e90-ab2f-e0f4141e0e97	21ec0ad0-e942-4880-8183-a6944d20d843	3	6	12	73.42	40013900.00	40013900.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
9717aff2-6c73-446e-85eb-e18a2a2ebe00	eede10a0-b4d7-4632-9693-76d56ad28d1c	2	6	12	60.62	40009200.00	40009200.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c84123d8-face-4562-bd1e-e7f4b870227b	009cf8d0-3168-4a57-a661-d7f665c74716	1	6	12	33.54	24417120.00	24417120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
8bb7ae48-d9df-402e-ada5-b2edb86adc35	0907e467-85b1-449e-acf1-ebeee5dd6bf0	1	6	12	33.72	24042360.00	24042360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
351ebb8e-d1ec-428a-8c33-104fc312085c	4a937c57-9a7f-41a1-8859-6a7204383c6f	3	6	12	71.5	40183000.00	40183000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
45c1790c-e260-428b-a29b-9eed98a4a1ff	ecec7e6f-d149-4f92-bc43-3ede63603e19	1	7	12	33.54	23914020.00	23914020.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f639232c-3ee8-4778-ae15-c8589f98ad07	067bb58c-3dd8-425f-bf7c-976c66583c8f	1	7	12	33.72	24548160.00	24548160.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b3213f1d-6ddb-48fa-8846-4b84f6f1e74f	f50bce79-17e1-46c6-8f57-00c7b9ea09e8	3	7	12	71.5	40183000.00	40183000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
01628880-30d4-4d37-ae38-928990b752c0	36663578-02b7-4ca1-b3aa-454f7e1663e8	1	3	12	33.72	24548160.00	24548160.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
13ff1234-af90-472b-acd7-910e629a6669	8678939d-2032-4940-ade5-cbf6b719fd8d	3	9	12	74.68	39879120.00	39879120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
ebde9420-43ec-40f6-88da-1e2bc245c7aa	f7c133af-00c9-47bc-8cbf-c69f07f5c6f5	3	9	12	72.66	40035660.00	40035660.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
f733bb8e-6bc1-486c-bf72-aac83cb3f5f7	422ade44-eaef-41a5-ae46-cbd1f5a7935a	2	10	12	61.62	38081160.00	38081160.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
68451798-8066-4b0a-9fe8-979dcd27470b	04408381-3aa3-4c2f-a7ad-64945e40452a	1	10	12	34.15	24519700.00	24519700.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
b2937893-7fb2-430c-8906-79bc476fe8b2	916fb414-e0cd-421a-84b5-6fd87448ae30	1	3	12	35.49	26384757.00	26384757.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c7b3b5c8-c398-4283-95af-7ecf75bb49a7	2a7fe96a-050a-4180-b143-81a0ecdace5d	3	3	9	67.83	40562340.00	40562340.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
677c4e0b-71b3-4042-acd4-e6885e120b6d	cd9c0224-64ff-4f99-9ade-018198fcf631	2	3	9	44.97	30804450.00	30804450.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
cfc68a84-3d4d-4c1c-9520-333adf831f17	6c1abf95-7ab9-4518-aaba-dc75c0c2a687	3	3	9	71.96	45262840.00	45262840.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
122aee21-af96-4488-b9e1-c35521c2e9ce	e6225120-73d7-4a46-98c3-8431e99726b3	3	4	9	67.83	44428650.00	44428650.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a3f1d442-9412-45fe-bec5-3b00d5908b9a	71ff4a54-6258-4a03-bb81-63ae1b9c9400	2	4	9	55.32	36179280.00	36179280.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e8294118-85da-4a6b-a3e8-6f46b428d5a6	f89bf507-d045-407e-a721-6a33041face5	4	3	12	128.92	79559084.00	79559084.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0e9aa043-96fa-46f8-8953-11a998055236	2cd0c5ac-3f40-4c90-b3eb-9074e3ef9c04	3	5	9	71.96	45262840.00	45262840.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5522a00f-d46b-4f7a-b8b3-cbba209d0eb9	2e59d9af-ac6c-49fa-af32-468e34616d9b	3	6	9	67.83	44428650.00	44428650.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
90e58272-75a5-4396-a07b-e7a184b7f016	bda3aff3-d504-4c52-8a61-894bd0c9b4cc	2	6	9	55.32	36179280.00	36179280.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7145bb13-2b2d-4249-ace5-9e00f4aa1e04	30489e1e-8cc9-41f3-bce1-dd90d9c00dd2	3	7	9	67.83	40562340.00	40562340.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d88da8bb-db42-447c-bc07-480cc49b05c5	8ef4dd79-ab5c-4524-bd95-bea2215ae209	2	3	12	53.15	39279101.00	39279101.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3f9f7b8a-3b5d-42cc-8c91-1c1f36b41845	179dfaee-4ee6-4ace-aaa3-98d4d6967df8	2	9	9	55.32	33081360.00	33081360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d4643f10-2605-44b2-9b62-954afc6e284b	f02cb1ba-4575-4fae-881a-49643fe134a0	3	9	9	71.97	40015320.00	40015320.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e7e28405-f1b9-4eb3-bd83-b440d83bd2b6	be695c92-0448-4d93-b864-8cde7ecf0294	2	2	12	57.2	37122800.00	37122800.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e42fb59e-7093-4197-99f2-8ff712e77dea	9b3cb8b2-f08b-4cfa-9fb6-7b0fcd97c69d	2	2	12	56.91	37560600.00	37560600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
78080b53-692f-4eab-a998-3dc005344413	f15f267a-654d-409e-a249-6e7771a93b93	2	3	12	53.15	34228600.00	34228600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b47ef3c0-9068-47b8-8c48-ecc25ca86212	52f2dc6e-4136-4a5d-a5a0-d589be3a314f	4	3	12	128.92	66522720.00	66522720.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fd284ed1-df4f-42e5-9c05-b4a4ae0fbda8	eb2b5a59-42df-4273-84dc-7c3b45c7e3f7	2	3	12	53.05	35702650.00	35702650.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e45f39c7-4edd-4ca4-8e95-41edc87a9da4	45f61245-abed-47d5-b3fd-3a9c891f415d	2	3	12	63.73	38492920.00	38492920.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
af70ea07-5151-4151-840c-70d336ee4302	609a72b6-1965-475f-90dd-0002f96530ff	2	3	12	52.66	36756680.00	36756680.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
487bc80a-ecf8-4390-8150-61b03f038013	c7c23e74-1466-4685-bca6-0ce9e6d657e6	2	4	12	53.15	36567200.00	36567200.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
510790be-b59c-46f0-ad78-250d6d47ad5e	1c864a7f-2c6a-4b45-b3c1-ef3988aaaa32	2	4	12	55.77	39329051.00	39329051.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6fe189b0-c11d-435c-b8b8-1e45e84b024d	08c95f3d-37d9-415e-bf7b-02a7cc0dd9b8	2	4	12	63.73	41105850.00	41105850.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
29dddba1-0396-4723-9b39-92274c2820b6	ed556830-2f03-4c7f-843e-e0c1fdf6bb12	2	4	12	52.66	34439640.00	34439640.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ec502515-36c1-4574-9cc4-efe724a8d383	254ec479-2b8a-44c6-a39c-2b1ed85215ee	2	5	12	53.15	34228600.00	34228600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4754ec07-d85c-4697-9fb9-848dcc93c45c	b7103a5c-32fa-41a3-be43-fdbb3c93d9ad	4	5	12	128.92	75289280.00	75289280.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c8718807-4014-45cc-99f4-cc6cc613d914	266629ff-7f02-4f7c-8c79-6a6dccaa9aac	1	4	12	35.49	29294937.00	29294937.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
dc61a176-6206-466f-a581-c0b178535c0f	b7ea3ef0-2e2b-43bb-8306-37fd60098af8	2	5	12	53.05	35702650.00	35702650.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
df25d1eb-8ffb-47d6-8d00-1f4305e1a240	d1d6f2a4-6b03-419c-a045-9d6479922c1d	2	5	12	52.66	36756680.00	36756680.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3f184826-4b9f-4332-a90b-945912d83ddf	f681bc8d-d71c-47b1-a43b-1b422937923d	2	6	12	63.73	41105850.00	41105850.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
38b1c252-3ffd-409e-a6e5-a2bfcd7b58a1	f82b787d-a151-4e31-a1f4-b3fac3872d7a	4	4	12	128.92	79559084.00	79559084.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
17d38223-8da0-4b21-852d-1a82ea14049c	4a4312ff-0d2a-40e2-8951-b6cd29f814e1	2	6	12	52.66	34439640.00	34439640.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c9764762-2622-4778-8979-fb2ac0c1aa18	6817a990-11e6-45aa-a73c-097398f69f1a	2	7	12	53.15	34228600.00	34228600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4514cc16-09b7-4df8-86f6-cc7387c8d653	ec19126a-49ae-42d2-873a-7a81926c6514	3	5	12	73.42	46621700.00	46621700.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
dff8b701-2d22-456f-803d-c1c463336fc4	8950de8f-ed9e-4200-b04a-1e30ec52eb37	1	5	12	33.54	23914020.00	23914020.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
79b481c2-1b38-480a-97c7-4fa9b8b099e7	f3de52ec-9a55-4b97-a785-335599a31d18	3	5	12	71.5	46618000.00	46618000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0dc8fb8b-c3b1-4930-8d43-cb69df476c65	5308b715-bac1-4f19-bfce-bd717bc61706	2	4	12	53.15	42042901.00	42042901.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1f0a4e61-75fe-4492-ac09-5bfe1c8a84c2	42cb9700-59ce-48e6-b2d6-c0bd0ca0f711	2	8	12	63.73	37855620.00	37855620.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
142004c8-04a6-4289-9e12-ea8ff71a3da3	08720d29-e59f-4080-95b0-50d71e98a10a	2	8	12	52.66	33913040.00	33913040.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
606d47b0-cd48-476c-a4d9-b401e04994d0	a8d88b9a-6ccc-411c-8530-ae10c9edd16e	2	9	12	52.7	31251100.00	31251100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ebfb93f4-c245-4a2a-95a0-5e24f9796460	b956f5bc-e9fe-4dd1-bcf2-0184aa09ba21	2	9	12	52.29	31060260.00	31060260.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
51536c2d-a516-4a3f-a542-508ee4424796	bbe0956a-6337-4df5-ab7a-079754b8cf1f	2	10	12	60.23	35415240.00	35415240.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
667048b3-cfaa-4215-bd04-54284a41134b	ddefdc19-a341-4394-80e6-98382a21919f	2	11	12	49.21	29427580.00	29427580.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d2857386-e4b9-4a5e-bbef-886b9ee0ccf2	409d5ac9-34f6-40b3-9ac1-e416dd22cb11	2	11	12	60.23	35415240.00	35415240.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d4d6cd0a-cd90-46f2-bc95-ec2af81e631c	ed70fcce-05c4-459f-8f6d-eccf33cb6254	2	5	12	55.77	41727161.00	41727161.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a7fa292a-136f-4abc-a943-fbfc3875484a	f787f6cf-8d05-4982-aa29-a1d390d90dbd	2	12	12	49.21	29427580.00	29427580.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d5e0d648-4728-4d14-900f-bbf722a33116	d1bd2ad5-0bfc-4dd5-8e84-526220f05cda	4	12	12	121.07	58718950.00	58718950.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9d8ace83-cffd-46a3-85c5-8ce7d91506f7	b825e797-607e-4853-abac-918f13df22a5	2	12	12	47.8	29397000.00	29397000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7a6a5796-f9ab-4ebc-b8e9-ec56ed7493cd	24b57c4f-6c43-4493-ad7d-4f37f7b11559	2	12	12	60.23	35415240.00	35415240.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7e2f08b9-e284-42bd-a5d8-0896f9a18756	b7fba8c9-f693-4720-894d-df0e9e0ae0e5	2	12	12	48.86	29755740.00	29755740.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
45375d7e-8f21-44b9-956c-3b5191223f71	7b35085c-3b6a-4df1-b6d8-f3288029d955	3	2	9	72.32	48555638.00	48555638.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a6b1d617-774c-4caf-9674-3bd3afa8fccc	dffa1d0e-1d90-4486-8edd-0baf8fda9279	1	3	9	39.46	29984928.00	29984928.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f5a86631-97d7-4d77-a3e1-9aca1c5bac50	febfe26a-f9e6-4536-ac57-b2effde436bf	3	3	9	68.62	50609977.00	50609977.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a083b772-7ec7-475a-b136-02ca83ca0861	cb4c7b3a-60ab-4720-8188-db20fa37be4e	4	5	12	128.92	90775124.00	90775124.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e1e3a5db-fd49-4882-9bc0-5cc26c1fd19f	e1e133f0-28ff-49c9-8447-99c2551ed5f0	1	4	9	39.48	29960150.00	29960150.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2925dbe2-248a-4102-af21-aeba968bc347	21186431-1023-48ea-8a24-e86e8257a3c2	3	4	9	68.62	46094861.00	46094861.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
067ef413-11b1-4ec6-859f-afa2733acec3	849e1784-30bd-4e1c-b281-875036e87a73	1	5	9	39.46	29984928.00	29984928.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
99b65d89-9a53-451d-9311-c6c1a8498636	0b1635f9-34d0-411c-bc46-b2a79d39913b	1	5	9	39.48	28894190.00	28894190.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
120139a7-7aa6-4b4b-953e-1542da5eeaf8	d2564135-7445-4baf-956b-6fec13bda27b	3	5	9	68.62	50692401.00	50692401.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3df815d1-3202-4a3d-86dd-443f99389874	756d8fbf-0858-46d3-81b4-7db55705a05f	2	5	12	53.15	39279101.00	39279101.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
070a07f2-e23d-43be-86d7-0de876937e9f	9bb5b5e5-109e-48ca-a1a8-51cd46f5cd0e	1	6	9	39.46	28919508.00	28919508.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4c33a027-e72c-41c8-821e-f22e39b8cb81	c8b0fab2-c750-4fac-8da5-7866a28c30cb	1	6	9	39.48	29960150.00	29960150.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5dc62f44-fde5-4347-920c-d51bfee187ef	b556d479-174b-4f4e-a8de-d358e133f48d	3	6	9	68.62	46094861.00	46094861.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c2509867-60b9-4a2b-af28-d8bb30dc3cdf	b69725f6-09cb-4d03-87f0-28ea6d1b8666	1	7	9	39.46	28919508.00	28919508.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
016fc659-845b-4b95-a048-00b269879840	741b6b99-d746-4196-a75d-2f9ea50e5725	3	8	9	68.62	46094861.00	46094861.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
968a4fc2-93bf-4419-a697-0178e2f094b1	151caabb-c211-4546-ae9b-2dec893bd5d3	1	9	9	38.78	27629880.00	27629880.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6c44841c-85fb-4ac1-b2bb-01f8592557f5	32925dee-14c2-4056-aa3e-21dddc8f72fb	3	9	9	68.61	44975997.00	44975997.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
411afbd9-75da-41a8-a8c5-2921da7e0215	b476de9d-9e6a-4629-922d-8eb8d6b5cd18	3	2	9	92.98	63525751.00	63525751.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2449408e-7ccc-41ac-ab2b-86c7eece66e3	1735bc76-1357-4c72-abf9-060f51b857b1	1	2	9	39.6	28194748.00	28194748.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fe87c12e-e136-472f-99a1-d0dfc6c9625f	ba06aa82-c6e5-4519-869f-212a368d54e9	3	3	9	89.49	60458912.00	60458912.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7f0cf497-1e5d-4082-933d-3f3b605f5a7f	7bc02fb2-4ab2-416a-9e39-10b64406e759	1	3	9	39.5	29971985.00	29971985.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b6131d24-83d8-465c-ba96-b90133b3a254	39fb8c64-bcde-413e-8a4e-ac954b61f386	2	3	9	62.25	46516746.00	46516746.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ff51a44c-5428-4b03-99f2-470cb523e13a	fc9587b5-f651-43cb-ac93-eb6b7d6a82b9	2	3	9	62.88	44197505.00	44197505.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
112d346e-c190-4e5b-99d8-d03d5ff9ee20	e18d6cbc-8fc5-4c56-83ab-038b17b043c9	3	4	9	89.49	70302812.00	70302812.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
56e5eebc-1584-49db-9b34-3d83d1b59537	dd133c52-51fd-4145-a79f-00ef6653f9d5	2	6	12	55.77	39329051.00	39329051.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
bfa8f9ad-8c00-4559-8cc8-4a93a3fd2c8c	56e65e64-b613-4606-95aa-601c2ddbe2f2	1	4	9	39.6	30055948.00	30055948.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d5496ca6-6f9a-4669-8b5c-054e639d1604	1878ba48-f06a-4589-aeb3-b1abeaeca3d9	2	4	9	62.88	46901345.00	46901345.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
261a41f7-d30b-43ba-924d-569294a37f2f	eae17c02-b12f-4a95-b0bf-bab9270661be	3	5	9	89.49	60458912.00	60458912.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f65964e8-917d-4528-888f-75c2071e09f2	ba5f8f15-0d19-4a85-8ed2-7bcea9211736	1	5	9	39.5	29971985.00	29971985.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e9a6db5b-93ad-40b5-88e3-6ebf8bd8c9c2	c5b07d68-bc02-499d-9841-52f498bb7b04	1	5	9	39.6	28986748.00	28986748.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c06ed37c-e2fc-4a7a-a909-be94155f5c4d	31940bf3-ad6d-4f36-814a-f1545708f2e8	2	5	9	62.25	46519988.00	46519988.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d912f358-b16e-4dca-9099-31fff6714e86	e6f32b26-a854-41bc-97b9-a33903912e9d	2	5	9	62.88	44197505.00	44197505.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8bbb2d8e-4437-4b10-9f45-2a387eb05ac0	8a15660d-09b4-4cf0-8919-4d8f81fdb59e	3	6	9	89.49	70302812.00	70302812.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ee3c00ea-4083-43c8-9224-b7539f0a940a	0060df37-0d40-452d-895f-d3783d7cad3e	2	7	12	63.73	38492920.00	38492920.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
73742852-ee67-47d3-a090-a077d344a3bb	ab45344a-4bcb-4094-97ea-d6e2aa34c58d	2	7	12	52.66	34439640.00	34439640.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e6971727-484a-473d-899e-551192b5e3e0	a0269e3a-ea51-4600-a1a3-da7d91ed34c2	2	8	12	53.15	33697100.00	33697100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e8ae7876-a253-43f1-8990-7dc0b590ae30	1a46e0aa-9835-4c25-9a49-fcc3b2c5d836	2	6	9	62.88	46901345.00	46901345.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
692c46a3-297d-4901-a5ea-23b9ae179eef	24c1a555-6fc1-41ee-b2e5-bb67f92eedf2	3	7	9	89.49	60458912.00	60458912.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
99b57320-41cc-4e72-851c-7d4592c3616e	b1c8e8ab-77e1-44cf-b4d0-3a2b5d62b2c9	1	7	9	39.5	28905485.00	28905485.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a31c27f5-b927-4dde-ba8d-f1be96995ccf	fdb32cf7-ee5d-4cb5-836d-6fc59837b1ce	1	7	9	39.6	28986748.00	28986748.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
19c2873c-15c6-47e9-a3e7-fac0332b3667	b195ab9a-6e77-400e-b466-9f82fdf36292	2	7	9	62.25	43843238.00	43843238.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fe162ec4-b8a3-4114-b227-cd0ef1b1f06a	ebe5d050-68fa-468e-89dc-731f5d9d8290	3	8	9	89.49	59564012.00	59564012.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e3f3d1c8-f6f5-4449-b1f5-5e11ba3400d7	4ca71ebc-2c69-4aac-a1be-2fa86d219911	4	6	12	128.92	79559084.00	79559084.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e04ce7a8-4e53-4293-b6ad-eb0306ebf0d2	4c6bbf24-856e-4957-92d7-a296abcf51c9	1	8	9	39.5	28510485.00	28510485.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9335c004-d08c-4477-842b-9d2faa1cb9ef	69ef9044-dbe7-4321-91c5-08d4d87f75bd	1	8	9	39.6	28590748.00	28590748.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5b615746-59b6-4e9e-b1b8-3bcff159d46b	a00e4335-4454-4451-82f0-01c9956fff82	2	8	9	62.25	43220738.00	43220738.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a248058e-029a-4119-a3d0-5ab36d727b5f	5906753c-6560-49a2-ab80-76e3ed88108e	2	8	9	62.88	43568705.00	43568705.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
54d0f789-3cca-4ff0-babf-147f646f391c	ae5f8324-d6c3-41cd-9723-1ea6a9dd0e94	1	9	9	38.9	27712308.00	27712308.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
06924891-9011-4078-a756-ad75e3a57288	4fd91838-f184-4a44-b213-b7df0af58348	1	9	9	38.99	27774594.00	27774594.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
66c5b78d-8a4e-4f8e-b26c-39080404af2d	28dc2b58-3d40-45dd-9889-eeac80821aed	2	9	9	61.73	41771808.00	41771808.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5e9e9ee7-4645-4a9f-8463-fd588890f1f6	336bc972-937d-4a0f-a2c8-82c3e009e6d1	2	9	9	62.36	42298871.00	42298871.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fe03a246-e893-436b-ba5b-2e9e8a39ff38	34e96a32-c75b-4617-8bb1-d3f18e5b080e	2	6	12	53.15	42042901.00	42042901.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fe3d0305-3752-4618-a581-0ebbb861c0cf	10f2a92d-c561-46db-8a8d-4686a6ae9230	2	7	12	55.77	41727161.00	41727161.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
133cc2b3-6dc2-4655-8f49-fac9399bf818	12b53cfd-0e68-4703-8e4b-c2cb8c3cf96c	1	7	12	35.49	26384757.00	26384757.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
34881c90-9d07-42d3-b3cc-4486b38d5671	3d0a88e7-fd48-4dfe-bfe7-97ac24e7bf01	4	7	12	128.92	90775124.00	90775124.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c9c87cde-7b88-4e57-bb2f-7365c7a30624	fdb83c7c-19a3-4e22-bb3d-e3aba46b1fa0	2	7	12	53.15	39279101.00	39279101.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
562e3d40-3c18-4cbd-ac1f-e52015d1388e	d3c1053b-c091-4ef1-8daf-a5898fe052e0	4	8	12	128.92	78269884.00	78269884.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e0af2ad8-2c0d-4d6c-8d30-dc9fc69188cf	f75c3aa9-bcfb-452a-8f6d-c4f8599dd2d3	2	8	12	53.15	38747601.00	38747601.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2aa26ab9-d591-4f6e-b2ae-ed6014da02bc	7daba46f-7913-4988-8551-6c32fd6bdb74	1	9	12	35.49	26029857.00	26029857.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f9da81f4-62bc-4913-8ca5-0ea8d07e851c	a3c8a746-7b86-41e4-b66f-293d5de7f545	4	9	12	124.95	72786336.00	72786336.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d0c5db90-7f0d-4a28-8d08-4f077ca4468a	defb1aa5-a29d-48e4-a1e8-cca5b84adae3	2	9	12	52.71	36101291.00	36101291.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
910cb5bd-83b1-46c4-abd1-bd331b37b379	4c633d9a-49b4-46ca-a150-b904ace8ee59	4	2	12	133.08	84430096.00	84430096.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
204c2648-40c0-4ed1-bf5c-5be6dbcb3522	4a213052-8e47-46be-af9f-0bf61f879f86	2	10	12	55.77	38771351.00	38771351.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1da6105e-ec98-4091-b28d-663e3a7a7423	39cbda47-bd00-4a0f-9586-b690fb93027c	4	10	12	121.07	71053146.00	71053146.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0f835e10-f429-4c8f-833c-679d933c8555	1d8a9f60-924b-4552-bff8-f93c67591b36	2	10	12	49.21	34156167.00	34156167.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0e0c05f3-2fca-4e06-928c-2624536c1423	5c7a3e99-9855-444a-926a-89900d1480d6	2	11	12	55.77	38771351.00	38771351.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f2880e9b-7a21-4db0-a9ce-692f2a05fac1	71628340-e7d1-4e79-8c34-8d4b6ab7d508	1	11	12	35.49	26029857.00	26029857.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1aaf4607-9d00-4ea5-a20c-e6bc7e2b512a	e4d3e657-f55a-488e-ad0b-6ca25b7cef9c	4	11	12	121.07	71053146.00	71053146.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4304f151-ebae-49a5-a718-10061fb068f6	6d045033-26a5-468f-b03b-e7ab0198d13c	2	2	12	57.22	42243706.00	42243706.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e8cc2f9f-1af0-4b25-b1ee-3006188275a8	f36a3076-3502-42c8-a1c2-f64a2c4052d9	2	11	12	49.21	34156167.00	34156167.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
46f89ca0-7c29-474b-a0b5-b91bd336b148	df1b0922-d026-4bd9-b85a-64b4ceab1687	2	12	12	55.77	38771351.00	38771351.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
82ab2ab3-8d64-4112-a27f-4773713e7f4c	f383953f-60af-411a-84e2-53d6709c129e	1	12	12	35.49	26029857.00	26029857.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a09459ca-99c3-4214-ada8-399f6abe5df8	e5763c75-e890-4704-94a4-a747d9e84175	4	12	12	121.07	71053146.00	71053146.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a7ab9fbc-6d3d-4280-be07-9e70734bf374	8962d636-a8a6-4ca2-8b7c-0ed979d2598e	2	12	12	49.21	34156167.00	34156167.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5ed07010-5341-40ed-ab47-6b9d948338e9	e8947838-1681-4883-a963-47ad6470798f	3	3	9	71.85	45265500.00	45265500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
bbff4d9f-c52d-4eaf-a639-0e46c3a352d1	dbe0b01c-2c4d-495d-9fbc-8a2bf2e06b0a	3	4	9	90.05	56011100.00	56011100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
306adbd0-2c16-473c-8bc9-3f4fe1316d22	d49dbb47-820b-45df-84af-c68648dcc6e2	3	5	9	71.85	45265500.00	45265500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fa747969-2778-4270-9486-161f4f66c64c	87901199-2251-401e-be3e-bcf33e7432fb	3	6	9	90.05	56011100.00	56011100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4c6333b2-e343-4a04-9efd-089de1975867	dfde6023-5b8f-40ae-9164-9b9dae143016	2	3	12	55.77	39329051.00	39329051.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9b16eacb-eb0f-43a0-871f-26144275ba40	888f41ce-4743-442a-9e5d-76abe0cd350e	3	8	9	90.05	59433000.00	59433000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2cf27f81-a9f5-4733-a4f3-1c46eaeb3c0d	839ecdeb-6a7b-4ecc-ac9e-1538d9edc514	2	2	12	57.2	33347600.00	33347600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
677b69fb-3788-4ab8-a9d1-8fd3eebfe31d	07c16f74-6d5c-4902-978e-132f84d7fe2a	4	2	12	131.81	72627310.00	72627310.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
76ac254e-ee94-4229-a8ae-cdc1d4f70cfe	8053fb8b-0d28-4425-825a-ab94b4b19093	1	2	12	35.49	20690670.00	20690670.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7f91e103-bb0d-41cb-a9b9-0b337f971721	61f593af-fae8-4d11-bb52-6ea6db47e41a	1	6	9	39.5	28905485.00	28905485.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1cb91e2d-f2d2-41e7-aee1-3819783f1d00	91314b18-e746-477f-a74f-59273b7202ff	1	6	9	39.6	30055948.00	30055948.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
67f88cf8-88db-43b6-accd-605533554aa3	3a85975f-65f1-4e40-86e9-69c56010254d	2	6	9	62.25	43843238.00	43843238.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
798b2ff1-ba11-4469-afde-d4a4897f8acd	1cb36080-8696-4e93-b818-b42a486b1b08	2	3	12	53.15	36514050.00	36514050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ed2d8012-46b1-4162-9e3e-c78a821c851a	8a9712f9-ee66-472d-aa88-a73c607b62c1	4	3	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5e5b13b3-19e3-475e-b4f1-c185eeddefe8	470c75bd-e116-486d-b92c-f1b55c01896c	1	3	12	35.49	24736530.00	24736530.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
cc4fabc3-39f3-49e3-8347-96a2f82a8fa9	ec553e80-5b62-4db3-8335-ea1de5eff89f	1	3	12	35.47	21388410.00	21388410.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2ea8bef7-5f21-427b-8feb-05a29877a5bd	f2d7b4c0-f525-40b3-a3bd-6507d7efdec4	1	3	12	35.47	24722590.00	24722590.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
88495d69-6ab6-4ea1-aaee-2e74f27be134	d1416def-e288-4a2f-8572-084881627cae	2	3	12	53.05	30875100.00	30875100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5a8439fb-3aef-4d7a-bdba-7b56fb8fa953	e9d72585-1b1c-4170-9470-2e9f70ee971b	2	3	12	63.73	42954020.00	42954020.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
29229e45-122b-4484-806b-1223f68d5d92	656944c3-17c6-4083-b3ef-742f9271ebde	2	3	12	52.66	30384820.00	30384820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c901e048-90db-44e3-8d85-ea87aa7887d0	c914a18b-0be9-442a-9cad-39061e2f0a8a	2	4	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
41835620-93be-4d76-ba10-8f91d90a4753	f1372d13-d393-43fb-a91f-3b4f58948462	4	4	12	128.92	80317160.00	80317160.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
60a4c8a5-5f2b-4314-baa7-d2ace2b66c1f	bbc7d6cf-f049-4c1c-8d71-f057116d9fce	1	4	12	35.49	21400470.00	21400470.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
67210edf-9753-4e8e-aed7-28760c91924d	2d117f03-dc22-480b-8106-84e56b4db233	1	4	12	35.47	23161910.00	23161910.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
88b03e83-5fba-4564-b289-dd41e351cba6	b1079fe6-b94b-4f4f-b3e0-95de580b388d	2	4	12	53.05	36710600.00	36710600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
cd1ac234-f4cd-45be-b0c0-8612401ef781	97226806-4529-437c-944b-bcfd126ca4bb	2	4	12	63.73	37282050.00	37282050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9eedcd02-45d1-435a-affc-cba44059c1ab	6a02ae1d-afdd-45e6-9827-ebf435f332a8	2	4	12	52.66	36177420.00	36177420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
425b96c2-1566-4790-aaba-387d7c0e5df4	d0dce133-45c2-46f3-8e8f-b08454c0e8bb	2	5	12	53.15	36514050.00	36514050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d81cadc9-5118-4f6c-bdf6-5098d64df5ed	f551ccd5-3d98-49f7-9a40-4c4f969f9782	4	5	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fd48a2da-e299-4536-8282-a45af6ba6eb2	ade92bf8-c2b2-4c9f-a966-a1c9108649bb	1	5	12	35.49	24736530.00	24736530.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3086818f-04a3-40a1-a1a1-783d3a0dbc60	c86c2937-01c0-43c5-93bc-b4e28aa22fee	1	5	12	35.47	24722590.00	24722590.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
86a8df36-2449-4719-bb54-0b910ccfc627	cadf6943-1018-4137-a5bd-0662510075c9	2	5	12	53.05	30875100.00	30875100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
66b2c589-519c-4750-95b9-a30030692afe	9f1a8581-140c-4247-98ad-14a7b9ae83f5	2	5	12	63.73	42954020.00	42954020.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
75ef6ae0-30ef-44aa-8f2f-59f0ad44c66b	e69bdc67-178f-4f88-b389-3c7ca7160661	2	5	12	52.66	30384820.00	30384820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
928d7198-60be-4e14-af15-9afde7b5a320	6e0f540e-0096-49b4-8e86-8eac1ee53e36	2	6	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ef7e77ae-f89a-4869-bd8e-909006cfaae9	ba66911d-b94a-44f1-9cff-654166ad5c8a	4	6	12	128.92	80317160.00	80317160.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
227ec147-9a6b-47cc-aa86-d5bb8ff4029f	7518a9a1-88f0-4305-a0f2-e073e81c7e3a	1	6	12	35.49	21400470.00	21400470.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ea02576a-023b-47a7-a07f-755807d8aba1	1fe7abe9-dbff-49ae-b972-bb4d9913acb5	1	6	12	35.47	24722590.00	24722590.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e9cd7887-f74b-436e-b6db-751774f3f971	83122265-b975-4bd0-9f5f-7daf11edad23	1	6	12	35.47	21388410.00	21388410.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9f58d266-756c-4384-acf5-ec9bb600b86c	1ddffa53-c5c7-4afa-9e14-af0ae055cb7c	2	6	12	53.05	36710600.00	36710600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d762d9ed-cad1-41f6-bdcd-c2c8b4bcb678	282b9c97-36d8-44bf-ae1d-4ce201e09b1b	2	6	12	63.73	37282050.00	37282050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
37f46f98-397c-4cdc-8cf4-d8bd1e020be5	7ffb5982-2a50-45e0-84d0-9db12fbfa7b4	2	6	12	52.66	36177420.00	36177420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0f034180-5dec-4082-8ada-416ebbc90f0a	f82dd401-54df-4dc0-ac35-cf30b22e4c50	2	7	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e011c755-a396-43b5-96be-2af4b3011f96	98648025-b9c8-41a2-ae8a-0480d1d065d0	4	7	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8eff9921-cebb-4f88-85a3-1d22c8c75c96	243afa67-2d8d-4c03-94a4-518c088a5ad1	1	7	12	35.49	21400470.00	21400470.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3a34ce07-5c36-4406-97a7-f57fbce82750	623e1925-c582-4cda-87ac-3646771baa3c	2	7	12	63.73	37282050.00	37282050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b3e97f8d-8d31-4afd-b04f-f9d785cec0c1	1e0afc16-bc07-44d1-80be-c890932f43ba	2	7	12	52.66	30384820.00	30384820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b767ba26-3131-4bab-b1a1-14dbb4b09b14	5bd9b10b-8c6a-444a-890b-6e1ddcc85466	2	8	12	53.15	30136050.00	30136050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2eaa4cf0-20f5-4923-923c-f52cff8024df	943dc062-0ba5-43d5-ab11-3d73c2a54c89	4	8	12	128.92	64846760.00	64846760.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3881a52f-df31-4609-8365-fb4909860aaa	7a03a898-138c-4719-85e9-aeda52427e37	1	8	12	35.49	21045570.00	21045570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
360198db-af04-4ee5-8109-20880afec410	ef962c85-ab24-4ec5-99c1-d5164575646a	1	8	12	35.47	21033710.00	21033710.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a488c6ce-fd3b-4546-bba7-79da1b78b655	1e8b9518-d4a4-4b8c-807f-0fca938a44b6	2	8	12	53.05	30344600.00	30344600.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0347f757-a0c9-4818-8303-010153465f5a	73207938-97aa-4b12-911e-535cb5cbeae5	2	8	12	63.73	36644750.00	36644750.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7aa07833-3fa1-4e6b-ab3e-64f43b6b81a9	222b0b44-5131-47f4-9782-d33960818478	2	8	12	52.66	29858220.00	29858220.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a8bea829-9a6f-4847-8c73-43d685debbf2	bb1a0c72-ef2d-4de7-b333-0cd5d4d1d58b	2	9	12	52.7	28299900.00	28299900.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
be47b924-c2d8-4708-ae0c-6082314abc75	4fd8bafb-9717-45ef-bcff-9881fee9e58f	4	9	12	124.99	59745220.00	59745220.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3fc1c431-b850-4cfa-a586-459584465da6	356d9f9f-5ba1-4d44-b361-3a3c96997666	1	9	12	35.49	21045570.00	21045570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8309578b-6a26-45bf-8f09-6fa7edcdf81f	8cbc3604-5470-4dbe-baf7-f423a45eefc5	1	9	12	35.47	21033710.00	21033710.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4635f49f-5ec4-487b-91c6-8e661b244c6f	1a2f6057-bb47-4728-b694-2de81fdcc0e0	1	9	12	35.47	21033710.00	21033710.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2de2a6dc-cd5b-4a7d-8cc2-10029f27a141	a9339e08-a845-43f7-a30f-d8fd6d74173e	1	2	12	35.47	20679010.00	20679010.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
49131c6c-a96c-4623-b6d6-03228bab080d	f80697e4-218e-47a3-87a7-30cec6d1aa8d	2	2	12	53.05	29814100.00	29814100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
94857f02-ecde-4403-8cbe-5e2621081c52	7998b18a-76de-4bc8-b966-a9eb19651dd7	2	2	12	56.91	33178530.00	33178530.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
31944a51-9e34-4caa-ab60-1b6d1eed3859	58f8ae6f-ed3f-4eb7-99c0-c04b2fb34682	4	10	12	121.07	58476810.00	58476810.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
657ea065-7890-4b90-8a87-f8b1a4780efc	7e3dbb8c-2ee2-42b7-9aeb-060301a26bd2	1	10	12	35.49	21045570.00	21045570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
857d9df6-afe9-497b-b32d-1912fe569dd7	65d36fe3-9ee0-457d-83e9-390f34d0e578	1	10	12	35.47	21033710.00	21033710.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
863f84ce-819b-4899-83a4-a3f83274012d	5245b36c-ecde-451e-bba9-5853b27b52c4	1	10	12	35.47	21033710.00	21033710.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4c50507a-9c2f-4e83-bce0-790ed057207d	3b0a5857-582c-416a-95cf-fb4638184ad7	2	10	12	49.31	27712220.00	27712220.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
03be1ab3-d813-43bf-b924-74f5eb86402f	e342f74e-274c-46ef-985b-df2e6916401d	2	10	12	48.78	26438760.00	26438760.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a2411d1a-10e3-4672-ad0b-fd0be2bdbd17	68ed2a2b-0484-4f59-8152-afb7146d3bd2	2	11	12	49.21	26425770.00	26425770.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b98e6ddb-b01e-4ff9-a7f6-efd324dada01	5c2c12b1-a73d-42c3-ac0f-e33abfad009b	4	11	12	121.07	57871460.00	57871460.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e2584d9d-390f-4a30-b6bc-a9f65d6250e3	0dc777f2-de0c-4ec6-8bbd-06304afd24d6	1	11	12	35.49	20868120.00	20868120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
00dc6a9c-8b57-4c5d-9bd7-ee549a0c7a0c	a849d965-4622-4fa2-8a6f-016300fd6677	1	11	12	35.47	20856360.00	20856360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
105bfe6d-bd8e-474d-b1d4-f18d1ea57420	f6658f65-14d5-49ef-ad11-2944bf4a2d1b	1	11	12	35.47	20856360.00	20856360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
46075b57-003f-4bd6-94da-46e2d86f4f0b	5778ef94-2519-4532-9360-f6606858dba3	2	11	12	60.23	32765120.00	32765120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
098e4b6e-cf46-4704-870c-565113a3f649	fa5e3117-5dd9-4c91-8968-7f948325eb0f	2	11	12	48.78	26194860.00	26194860.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c4c0fbcc-a9b5-4286-a572-1db6d20746f2	b1e4e84f-0c5e-4515-9317-7d7af68fdb6b	2	12	12	49.21	26425770.00	26425770.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b7a2c188-de4c-4008-a52e-a2e65942aa4f	4fc50fc6-6564-49e7-a661-e0c4227c086c	4	12	12	121.07	57871460.00	57871460.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
65ce0404-bcd3-4029-8faf-0d0e2d3e95d6	46a31d8d-9f51-400d-9585-da09cef06e23	1	12	12	35.49	20868120.00	20868120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
24088fe0-2d05-4ce1-9242-31342eca347a	84424078-334a-487c-b163-d6009b26dcbe	1	12	12	35.47	20856360.00	20856360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c2f39c4b-9540-4030-acb4-dd7c6e9ab73e	fb4914fd-bded-4df2-9a09-78be78885806	1	12	12	35.47	20856360.00	20856360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fd4fba96-e6c9-48fa-8f45-0fb1099353e1	cda0a884-9957-4ec6-8c29-be8fa4ef0872	2	12	12	49.24	27426680.00	27426680.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e3d74b9b-7e96-4764-b50b-caaa73dadd35	03456296-c0c1-4b34-ba4b-299c58462f6c	2	12	12	60.19	32743360.00	32743360.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ecb1ca1a-a37b-499e-92f5-ff966c46eab7	778454a1-7e92-4895-af2c-3876362b8fc7	2	12	12	48.86	26237820.00	26237820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b43e5373-1b5d-4f5c-92a2-4be706df1781	6b2da69d-6151-47a4-b9f1-4f4a1ef5c435	3	2	9	80.73	49924878.00	49924878.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f882c3ed-a225-4c92-a9e9-4a0a09223830	c28ab33f-eea5-4577-b4ec-c3b129281fa0	2	2	9	55.42	37497757.00	37497757.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c6b195d5-3bee-424a-891d-2711c58e9f22	6bf4cc33-1699-484d-83b9-a8ac4a120c4c	1	2	9	39.46	27431932.00	27431932.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a054fd7e-434d-426c-84ab-ebbdafd23d71	60a98201-b19a-408a-8a7a-8c54150889e6	3	2	9	72.32	48373008.00	48373008.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8dd159d3-da58-4dba-a2ae-11bd97245b5d	18376eaa-96ef-4fec-873f-0071d4791264	3	3	9	78.23	58515563.00	58515563.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5079531c-937e-4ca7-92f4-9cbc21e428a5	715e959c-53ce-45bb-9e6f-2217f7676308	2	3	9	51.03	36175262.00	36175262.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fce0e62e-ad25-474c-b093-70b1d7e9708c	c5282514-38eb-45fa-9644-89af7d9b320b	1	3	9	39.46	31456852.00	31456852.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
674067c4-e2b6-4487-8388-bb85b629caf1	7f342a97-8000-47c6-bd95-b9913e0650e7	1	3	9	39.48	28233332.00	28233332.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
141a6155-e9a0-428c-ab21-cc4107a29d1d	1b24ee2b-6f78-4840-89b6-493b430a730d	3	3	9	68.62	51276470.00	51276470.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3784bdc2-b232-4203-81d9-217d19ff93eb	e1330838-7062-4ba9-929a-a55f949f13c9	3	4	9	78.23	50457873.00	50457873.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7b07a053-5ae6-4e07-8655-31402421d169	bd312f06-656c-4f94-97be-6125d7ebb7b0	2	4	9	51.03	40716932.00	40716932.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3dbff5c5-a938-4755-a264-2bf9e703371d	8c1ba4ae-7aee-43c9-9baf-7ed0b42a22ff	1	4	9	39.46	28221132.00	28221132.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3bd55bcd-b884-4cdd-b012-dd002ef3cf2b	42daee33-7f72-4c4b-854b-8e76364960f4	1	4	9	39.48	31470692.00	31470692.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2c7ba50b-c2e1-4509-9a8b-11b8b11eabbf	b355b117-ffdb-4c1b-984b-3e837825e6b5	3	4	9	68.62	43728270.00	43728270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
027dd2fb-a6cd-4eaf-8b32-fe9f9018f3c3	82cbfe17-6281-4076-9ff7-28b2e20caaa3	3	5	9	78.23	58515563.00	58515563.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
17396abc-17d3-42d1-9fdc-ecb7c1cace0f	07695831-95f9-4f44-bb6d-b32b5d87cba4	2	5	9	51.03	36175262.00	36175262.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
361a9fbe-9314-4e44-9ab2-058b5f379d06	df031fd7-af79-4d76-90ec-8ac643c0f6dc	1	5	9	39.46	31456852.00	31456852.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f35a4a2c-48b2-4946-971a-da7a7838d8b7	62e333a9-0a42-4c84-9ae2-dcb5d0b5fd59	1	5	9	39.48	28233332.00	28233332.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b24f457d-0d4a-4964-bf1a-e855db447393	2f99f863-3b2d-4461-8fa4-ab3f70323222	3	5	9	68.62	51276470.00	51276470.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f00da54b-ea93-41e4-b210-70d8c5929c90	69211fd2-4f79-464a-9a19-e6d1ae06feba	3	6	9	78.23	50457873.00	50457873.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5f7b673a-0259-4acb-8c4e-d07b6fddb332	1a4cd754-ea59-4db4-842b-2d3f4f69fcb7	2	6	9	51.03	40716932.00	40716932.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9dd0a1ea-87c7-4b96-887d-4530136bea3c	011de7e7-ea52-45a3-aa88-c7f787daee0e	1	6	9	39.46	28221132.00	28221132.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1f75b907-818a-4647-ab80-251e49833d02	bf50d54b-aadd-4204-9025-7af6f88863d2	1	6	9	39.48	31470692.00	31470692.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b01446a6-29e4-4777-90e9-857321286a58	7bd63f7c-2eec-4e89-81c6-29a73261b3c8	3	6	9	68.62	43728270.00	43728270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9f2b715c-755b-44f2-b2c2-49fc326d4ce3	ae9fd9f7-bc55-4aad-9a22-cedf70ec3213	3	7	9	78.23	50457873.00	50457873.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
bd606c3b-1581-4f77-a30f-cd5be15fdeb4	971e9245-f0f5-449e-9a67-28abdc2579b0	2	7	9	51.03	36175262.00	36175262.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d25caa58-389f-4110-b1c3-515691d4cc56	0e1367f1-e38a-4dc4-8aa0-535b43f79b35	2	9	12	63.2	34380800.00	34380800.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
216abcc3-31ee-4209-ae96-2c2842cbcca5	be622b37-ea7a-4eeb-bd98-187370aa9d92	2	9	12	52.29	28079730.00	28079730.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
419fe1b4-3997-4068-8386-bdbf140ec468	a406b3ad-6f7e-4ba1-b518-26b19d0ff08c	2	10	12	49.21	26671820.00	26671820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
529e8a7b-af85-4a7c-bd65-70a8b69afa12	dd5f03a6-5684-4312-b6bf-1e7b568e8134	2	8	9	51.03	35920112.00	35920112.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1fb28f1c-97ef-490c-9584-1cd10fa02ca0	39f01899-8d7e-40cf-ad16-0b88eafa69a8	1	8	9	39.46	28023832.00	28023832.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
60bb7d0a-060e-4935-a475-a9133d4e1171	76590f24-65bc-4b34-823a-c3e664eaf276	1	8	9	39.48	28035932.00	28035932.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a512e715-0321-4da8-940c-c20ef64c50f9	d0287fb4-6ef0-4730-8722-47df6491c2f9	3	8	9	68.62	43385170.00	43385170.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
878979e7-75bc-43ba-a488-9a5d761454bb	2f24cd07-b7aa-4eea-b446-9016a7c37bc0	3	9	9	78.23	50066723.00	50066723.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
780a1f83-6946-4ea0-b594-b61a14cb4975	144e325a-668b-46b5-b426-ba1d45cc82c9	2	9	9	51.03	35924165.00	35924165.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ed6a1189-3a15-4345-9366-c0942dd1cb59	cfd64f20-1117-449f-883f-bcf4e45ebc9d	1	9	9	38.78	27552852.00	27552852.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2dc6ce1e-2f4d-4ce7-8275-2087237de00b	7756f526-6be4-40f0-b1da-f25c24bf3a19	3	9	9	68.61	43373407.00	43373407.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f437cf9e-abee-47ba-b9c2-08d03242b4cc	9e59cec2-9c20-41ba-a8d7-ee57efc4048d	3	2	9	93.98	60518475.00	60518475.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3841b833-5ac4-49cc-b9d2-3a8d288d1a4c	60fa5aaf-4fe6-4f5a-9bb5-55a051685823	2	2	9	49.58	35147827.00	35147827.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a4ef4bfc-b05b-4e24-94e2-95feb57917d1	9d380269-3c4c-4ae3-b126-4cc8998faef4	3	3	9	89.26	63856916.00	63856916.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
eeca2285-3388-436e-b76d-8823a687bea3	f39c6eaf-04dc-4dda-83a5-ee7921f7793b	1	3	9	39.31	31415454.00	31415454.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
69f1fa35-f36f-4ea8-9c50-30d8479891ba	d31959f5-51dc-4af8-9fdf-12e0ccf7af62	3	3	9	68.15	45004956.00	45004956.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
360c239a-1e7f-42a7-9a68-d131b3544eca	09c47e72-6c88-49f0-8f26-52a700bafd23	2	3	9	45.19	36150036.00	36150036.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
80535dcc-9f7b-4e35-a191-4cb7ea425023	2654c075-dfa6-4306-81a2-3a6be65d9fa5	3	4	9	89.26	54663136.00	54663136.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ecff6045-d93e-405c-a1d9-327aa24d8cd2	e123be59-222c-4916-8253-14c678d59f18	1	4	9	39.33	31433168.00	31433168.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
eada3d4d-c6d7-495d-8760-7505efe1aa5d	34bcd734-c2ce-4dc2-ae33-46dd1a67c6bd	3	4	9	68.15	52501456.00	52501456.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
48cf886f-00f2-4832-9931-978b2fa2d7cb	2609c5f8-09f2-4907-9267-426a21442202	2	4	9	45.19	32128126.00	32128126.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
77545fc4-5283-4ff7-99e7-0f61fec3d64a	0d903a7c-f3b6-42e7-949e-fe064762ec14	3	5	9	89.26	63856916.00	63856916.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0458b711-1563-407a-895b-2457683bc5c9	496958ad-bd7e-4e35-b4bd-99e15ef45f6c	1	5	9	39.31	31415454.00	31415454.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2f36572c-d4f8-495d-9d61-2225c5bd74fc	b4281061-2f6c-40b2-8c44-2cea60566b0a	3	5	9	68.15	45004956.00	45004956.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f2bd604c-0d81-4117-b8ea-441f8cec0334	2d1a724a-448c-4d5f-b958-4e0da87e8933	2	5	9	45.19	36150036.00	36150036.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
506da792-7408-4ff5-8114-64729a1802f3	2ea5fcc2-3bce-4dca-8a66-42434213e44c	3	6	9	89.26	54663136.00	54663136.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c4d1edca-800a-4c47-b479-e948f8f6f002	59047533-ca1b-4daa-8a63-25a7e7b1e9d2	1	6	9	39.33	31433168.00	31433168.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0266ad22-aa28-43fb-bc46-8803c12a40a8	3a2c0d4d-33f3-47c6-a64d-c17a063addef	1	6	9	39.31	28192034.00	28192034.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
91a186cf-d896-4c50-8979-6df4c672f9ef	0f5d250b-ab20-40d4-97e9-95f445d075cc	3	6	9	68.15	52501456.00	52501456.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
71d820e4-d7ca-42f6-8e94-caea5ae9f058	b835aebc-2f81-4802-8ca4-e5cd0cac619e	2	6	9	45.19	32128126.00	32128126.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
60114a5f-7598-48fd-9b98-1607e0346ee2	763e6589-e7fe-4e31-9bf9-d22480d4a790	1	7	9	39.33	28208108.00	28208108.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
47285613-14da-4d52-ac7a-cc3c22b87dfc	a6c7fd7c-2642-4378-aa33-d5264ced16d5	1	7	9	39.31	28192034.00	28192034.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ec31ed69-69a4-437c-8648-4240fc688344	d1b4536c-57c6-4b91-b70d-7191459ad430	3	7	9	68.15	45004956.00	45004956.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
716ba5a0-79fe-4d9e-8aa6-a142675c9723	d8f4f6e3-356b-4e04-a33f-b7ba2bdd5fb5	3	8	9	68.15	44664206.00	44664206.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3a7603ff-0c94-4500-b39d-d7768e013f1e	c2a36898-83a4-478c-a996-087995210f38	2	8	9	45.19	31902176.00	31902176.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3fe529be-8241-4448-a260-c44179c55fcf	ae066896-97b0-438b-867e-6bcd19c2594f	1	7	9	39.48	28233332.00	28233332.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
31babaae-a71d-4458-b11e-5aaec70f96eb	49c39a7e-77cc-45b8-8c4e-2befeb446375	3	9	9	89.26	54216836.00	54216836.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7863b4fb-d75a-43db-ac46-a48159b18e32	d13b31dd-a20c-488c-a873-4d75f80d86a5	1	9	9	38.61	27479580.00	27479580.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
792b9413-bd0f-4099-9799-985cc7637824	cc47060e-c64a-4825-9312-18bf880b03a8	1	9	9	38.58	27454333.00	27454333.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
abd5a676-da90-4534-a633-5b1217afb567	57ca5377-bc19-40c7-a400-d5509ec2e149	3	9	9	68.15	44664206.00	44664206.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
27aea168-068b-4782-bec7-9c9175976276	6f93888b-cf6b-4888-bcbd-6eb980e960c6	2	9	9	45.19	31902176.00	31902176.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5b36d7ee-f558-4f4e-a7fb-fe6824726fdc	15148461-317f-46da-b593-ffb30f767cd6	4	2	12	118.92	57914040.00	57914040.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3ebaf3d4-edd8-4665-937f-172fba185174	fa025c51-8802-435d-8cba-358c0e972635	2	2	12	55.63	29706420.00	29706420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
66af623b-0c04-4032-8383-ed855d3a9380	7ce7286a-d0d6-4b56-95ab-a2f532deb991	1	2	12	35.49	20690670.00	20690670.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
cd91fec7-3833-4446-8edf-dca345194a1e	e4014dde-efed-4262-aa06-58bcce2a4603	4	2	12	133.08	65076120.00	65076120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
81a52678-b7d8-4077-ab8b-c2ed01c837bd	dd6e2aec-226d-4075-839a-96401112dca1	2	2	12	57.22	31642660.00	31642660.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
65224b00-0533-443c-b9cb-71ec0b7713a8	8bf067f4-1114-47b3-a619-a0078ca01187	4	3	12	115.85	75302500.00	75302500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
340a61c1-c74d-4af8-aefd-941aaa8e3e66	7f8f89e5-61cf-4dde-a13b-631662ca06e9	3	3	12	85.19	47280450.00	47280450.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
281e7f72-4433-4dde-a089-53ed13dda32f	01314046-d436-40e9-8f95-2fdab1c8f518	1	3	12	35.49	24736530.00	24736530.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
717c5e8b-9eee-47ba-b2d6-b07a31d2cba4	a03fad9d-1581-4b61-87fb-e91316634089	4	3	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f456d668-1d48-4896-b1f4-e4eeb82814e4	587c8136-59c7-48bd-a852-d04b6a89cfa4	1	8	9	39.31	27995484.00	27995484.00		2027-04-23	f	268f202a-ef1a-4263-81d4-cfa593722772
9e2243a0-dab9-443c-ba9b-286558e8dbb9	3be49fe4-9857-4509-92b4-ccf35514b362	3	7	9	68.62	43728270.00	43728270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7afea720-2c1b-4067-bd6a-eaaf97bf14dd	cd0a633a-9851-47fa-84f5-a77f11a1452f	3	8	9	78.23	50066723.00	50066723.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
caa9e676-a3a1-4c73-bff2-f047cea62c9d	15de701e-d55a-49f0-b1f7-1cc60679974e	4	4	12	128.92	80317160.00	80317160.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d3848161-22b4-4ca7-931e-16d3ed17b766	9290aa52-4170-433d-bc7c-589b35d6ccbc	2	4	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f0c398d9-4c38-4a7d-987f-30073db42f55	e74165ca-6c5b-4539-969f-fcd9d2a620c7	4	5	12	115.85	62559000.00	62559000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4d90992c-3921-4a7e-9694-a90f512fd75b	6d5b8a9d-4bc0-40b0-92f2-0e84bb6d9296	3	5	12	85.19	54351220.00	54351220.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a9efcd9a-2528-4734-87fb-6791dacbde7c	bc665c27-d460-4fea-be58-4f21db9e6fd9	2	5	12	55.63	30819020.00	30819020.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9560c422-fa96-4d64-ad68-94a6df7b2cfe	5ec928f6-1d8d-4f43-a0f3-ee15601592ff	1	5	12	35.49	24736530.00	24736530.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0f374ded-c449-4fdd-8dc2-9163d535550b	3aec9fd0-df8a-4938-8fa7-7d38a2ebbff6	4	5	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4befc857-c6e4-42f8-b5d8-933ccd5d1536	d67f18d8-6423-4593-b498-f43fde422c12	2	5	12	53.15	36514050.00	36514050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e1111eed-0498-4ea5-8100-73f44765c5fd	af1c5e36-25ec-4ff4-a83b-a8b03a140cf6	4	6	12	115.85	75302500.00	75302500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f88b91bc-05d7-43f0-893e-b71fc5e481c0	c1986cb1-94fd-431b-88a7-3f31388f7d8b	3	6	12	85.19	47280450.00	47280450.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d1689a0e-7090-4911-9608-6da8db6fd3ec	3138eb7b-b2a2-4e34-b574-3a804bc026df	2	6	12	55.63	35770090.00	35770090.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
25efcf45-3529-4cf1-b0f4-a99d868b7163	dde93a47-01b2-4560-a274-e20a3423fbe7	4	6	12	128.92	80317160.00	80317160.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ef0ca4f8-93da-4d7f-aaa2-59d849e3edae	0adc5769-5a2c-49f5-8449-e26ff184a33b	2	6	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
aa658b8b-6ee6-4452-8f63-eed31e6eb04c	17d8841f-05cd-497b-8e52-0001cbcc1181	3	7	12	85.19	54351220.00	54351220.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
293e5460-5936-450a-83d4-17416fdae2b4	61ceedd4-e05e-4214-9dee-46c4de7bf42a	2	7	12	55.63	30151460.00	30151460.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
53cde035-724d-42e3-8253-ad46100b5e0c	7dd97097-bc21-4f86-b960-e260bc9ce5bc	4	7	12	128.92	66135960.00	66135960.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a599d3ce-a7ea-4938-94a3-19bdcf712b33	502e2561-ab33-4b2a-9873-561b7cfc3cb2	2	7	12	53.15	36514050.00	36514050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
9b0ebe00-026d-484f-a80e-9867399f74ba	110d238e-70f6-4922-a192-c439fd4940f7	4	8	12	115.85	61400500.00	61400500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2b5e2e9f-3927-4935-8bc5-4856a620aa30	dcb9aa31-0481-4635-be6a-ffcd6fef41d4	3	8	12	85.19	46428550.00	46428550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
089e7bb1-a259-41c2-aa33-8bff396b6808	e8451095-3d74-4e21-a84e-1547c36a4512	1	8	12	35.49	20477730.00	20477730.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
059d2086-54ad-41d6-bd8f-7f4c1e5536a5	27df6921-80de-4caa-bf21-9cbd64099164	4	8	12	128.92	64846760.00	64846760.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b33bf839-9e81-4cf7-98a7-bea7403d55e5	eefcf829-9131-45db-bd42-731d73106101	2	8	12	53.15	30136050.00	30136050.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f5daef43-0e25-449e-a2fb-f603d20c3427	9429e9f4-ed62-4e2e-96e3-eadab7dfc5c6	4	9	12	112.33	53356750.00	53356750.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
707b2f2f-3e1e-4fc9-ac4e-06cf1bb33d89	e8cc7169-9a7a-47f3-b23a-86c303ff0c32	2	9	12	55.63	30262720.00	30262720.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3b490f5c-9e86-499a-b1dc-69910f9855d5	58e0b480-a170-485b-b77c-7da5e4740c11	1	9	12	35.49	21045570.00	21045570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
38c58428-f7cb-4b42-b171-b5b564e76c8e	0ca153dd-2b35-4c65-b01a-fcb8c8b7118d	4	9	12	124.95	59726100.00	59726100.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
527f0b49-0bc7-4865-a972-b8cfecaad843	75b268b0-8ecf-4856-b01e-3659c48c32e3	2	9	12	52.71	28305270.00	28305270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
db56de66-80dd-4b94-9c3f-3ce2bc7f3066	f83c5e00-fa87-4a29-9d30-819565b61477	4	10	12	108.26	51964800.00	51964800.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
900fb301-4941-4c2a-bf82-710ea48aadc3	bd821675-c633-4a77-8418-94aef70d0816	3	10	12	83.7	43021800.00	43021800.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
f66693c0-a946-4175-ab3e-24ed08964226	2609e7d7-6223-4b25-8e9f-3147a9829d23	1	10	12	35.49	21045570.00	21045570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1388b34c-8ef5-4631-8afb-102f178c77f0	e8ea47de-67a1-42d7-aa08-a56c4b648b5f	4	10	12	121.07	58476810.00	58476810.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8830ec86-50a2-4144-99e4-9a73921c1116	409876b6-5da5-497a-a5b9-7b8dd490e74b	2	10	12	49.21	26671820.00	26671820.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e1c65fdf-9d75-43a5-a8e1-cb1d7fd660ee	d26c8741-7160-4fe6-a3ce-cc4830cf8a15	4	11	12	108.26	51423500.00	51423500.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d091a565-2c2a-4436-bfcb-5f429e3c33a4	bbafc8ba-e0e2-4d63-98c1-f1b8d8fcec18	3	11	12	83.7	41850000.00	41850000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3def6b64-571f-4c5e-8c6c-46155a6ca592	8dce6723-03ee-4e9e-9bf8-e13bf7ffb0db	1	11	12	35.49	20868120.00	20868120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
08012d24-77bd-4729-87d0-c709a7d3fec1	92b83bca-287e-47b2-a2d5-6f00cb58c53c	4	11	12	121.07	57871460.00	57871460.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
47f57a4f-764c-4e9f-83c0-211896f9d0af	6c04b777-1e8f-4c0d-8ba4-ffad28b180f1	2	11	12	49.21	26425770.00	26425770.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a95645c8-c620-4f48-bdd1-4a81f85d9ebc	ca648cc3-cc17-422a-8fb0-c75d624a40f2	3	12	12	83.7	42603300.00	42603300.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
012cbd05-6858-4121-830e-a4d0f72e129f	fb91239b-6582-416f-bb5f-16bd89f143cb	2	12	12	55.63	29984570.00	29984570.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
3b76219d-212e-4a20-a2ff-117709c0349b	762924ff-3086-43bb-9acf-69250374c0e9	1	12	12	35.49	20868120.00	20868120.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fcff821b-7a36-49ba-8bab-488bb7f4d94f	e0ef03b5-248e-461d-9e31-cf8e5f8e574b	4	12	12	121.07	57871460.00	57871460.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a0abb108-dc40-4145-be95-aa01101a0ba5	40ed4933-c47a-47ea-a49d-cc1403aaf544	2	12	12	49.21	26425770.00	26425770.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fac86eae-e6de-47a4-8501-b282d6b3856e	0d35cd72-0d82-4a68-94c8-1b20f2ca9ac1	1	2	9	39.54	28270371.00	28270371.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
21e806ef-24a3-43b1-89e1-dc78124f4537	08d1b841-24f2-44d0-a274-200002b7cd07	3	2	9	93.56	57225616.00	57225616.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
58c2a23e-7fba-4b30-874f-1ef1d57505fe	6d5e3387-a145-4d9b-8184-b45e0c7fd6ad	3	2	9	76.23	48208675.00	48208675.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
b4f7b568-95a1-4522-a0f4-3887b3d6ba61	b9b1150c-66b1-4034-8a70-a7cc22040e82	1	2	9	42.31	30196661.00	30196661.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
16ad130c-344b-4498-9231-f2987a549b2e	73faff30-163a-4224-9640-58021e648949	3	3	9	71.85	47119227.00	47119227.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a8a903d8-8a63-46ea-8cad-99cada15c3a1	c1e611be-a0ea-46cd-9834-1234ab4a0f60	3	4	9	94.08	55036800.00	55036800.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
d4cbbea8-a7cc-4eb1-b841-d0da7b65ffea	2b98eb48-b691-4f44-8ec7-a649afb4250a	3	4	12	85.19	47280450.00	47280450.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2199309a-ebbd-464c-b352-d25253950f5f	e6096a9e-fb9c-418d-8a66-646494c2271b	2	4	12	55.63	35770090.00	35770090.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
17ef0283-eb47-4f23-b5ea-1de5dff638a5	d3ac787c-bd10-4cb7-9eff-63b1ba8047c3	1	4	9	35.46	28328015.00	28328015.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
364cbbfc-dfec-488d-aded-d709032e70ad	a57465a3-e8ea-410b-9c48-6f8a254242ce	3	4	9	90.05	57510270.00	57510270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
63a6ecea-3c97-4c56-a12c-99fc2a5386c2	13f02155-5bd4-42a3-afdf-b75e28b22baf	3	5	9	71.85	47119227.00	47119227.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
aa999e6d-c110-471f-8e42-c0ad9153b651	c5747f64-693c-4497-882a-84e93419cb1c	2	5	9	55.4	41237784.00	41237784.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
cfe88997-f3c8-48e2-820d-efec0c9075fc	6a3d25c0-2172-4b09-a699-2c89c22e5a0d	3	5	9	90.05	66785420.00	66785420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
06a7f1e6-33e2-4036-9e77-718f1ec4af2c	8e1d53b4-59ac-43c1-a49b-1cb02cd543b3	3	6	9	71.85	55022727.00	55022727.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
92d4744d-2888-4aed-bb1a-b3b64dc8452a	5dbb4799-141b-4478-9ab4-6b4a4e4600fe	1	6	9	35.46	28328015.00	28328015.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8f3ed52e-82af-41b5-93a7-5b64b5392280	3c48e340-a3b7-47c2-bee6-3058012e021d	3	6	9	90.05	57510270.00	57510270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6cb7a279-e386-4d6e-89da-fb53f4e724e5	0c229c5d-c15f-4531-b4f5-ce4b622f7579	3	7	9	71.85	47119227.00	47119227.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6a4c6f8d-9ee4-4b54-8197-86ed4190d184	a92ad603-3299-4546-a3c5-f77a8907dad7	1	7	9	35.46	25420295.00	25420295.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
813d20b4-0f20-4645-a053-ff348072d558	a8d9ace0-04d5-433d-a0fe-0558dc6d99b6	3	7	9	90.05	57510270.00	57510270.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
91394128-e447-4768-b571-489d754f4aeb	d9aa0d8e-446d-41c2-b87a-eab7f249a2a7	2	8	9	55.4	37138184.00	37138184.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e855db24-e58b-497c-a9fd-0e61b6813362	87c07b5c-5749-4386-8683-37a9f8d33cd3	3	8	9	90.05	57060020.00	57060020.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0db2562c-e648-4b79-b4d7-b501626d9417	d29e50f7-e7e0-4056-857b-2dca4890a3f6	3	9	9	71.82	44329872.00	44329872.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
82ffc313-16f3-47a4-bd62-1aef35280443	048b5c67-e29c-42d3-9515-f8bc49f8b5bd	3	9	9	86.21	52233576.00	52233576.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6f1829e8-85f4-4715-bb88-26632e57eff3	ac3c5df5-8b39-4fcd-8865-6c5f8b2ef3e6	1	2	9	43.09	30714635.00	30714635.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e2beeea0-7cf2-4251-9500-75f4eb8353cb	7f2766a3-ae94-4da5-b142-6a8e6eb3b402	3	2	9	76.6	48456706.00	48456706.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
708eb9de-f38e-404f-98db-8e3974a1f3cd	6ac50d36-b79d-4552-827b-8e3d910f3022	3	2	9	94.7	57722040.00	57722040.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d135781c-157c-4073-9e20-b8b086cb4b17	acf6dcea-def4-49f9-a520-3acd8152d615	1	2	9	39.08	28177134.00	28177134.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5a01c6dc-b61f-4046-9f02-0d4c4d438ad5	03488823-03cf-4018-84e6-4259951d80db	3	3	9	90.43	66913157.00	66913157.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6e6f77d9-720d-4be4-8444-53698584b48f	18a8e863-7f91-4b36-a9b9-2ccf65ba586f	1	3	9	35.45	25543317.00	25543317.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
dc37b079-3b7b-4345-abcd-23d453fcfa83	ad8f1b47-03bc-420f-bb7c-1fb2015e4d32	2	3	9	55.66	41416112.00	41416112.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
ca1f13fa-a70c-4062-8963-333d268fce9a	a83208a3-cbe0-4dc2-bdfa-894ec0a30ebc	3	3	9	72.13	47233420.00	47233420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
348f5a17-beed-439a-96f0-ff4599359fb0	2ccf9d62-154a-4494-b68c-ca1f1a0fdaa6	3	4	9	90.43	57598867.00	57598867.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
03f9447d-fadb-451c-9934-f8364d2b2c75	74060d59-7853-449a-b02c-9400fcf4313a	1	4	9	35.45	28450217.00	28450217.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5f45a466-05f6-4bb1-b3a6-6098ea2492dd	1ae444d7-f741-460d-9720-16b1874283d8	2	4	9	55.66	37575572.00	37575572.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6482ce16-6bec-4933-8c10-6cce7a6e326d	b4fe2550-321d-4fb3-8aff-214e814ba208	3	4	9	72.13	55167720.00	55167720.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4ceb411b-c2df-468e-94de-35955d56659e	cd99b15a-8cbf-436d-ba71-6fc5e3b13dd7	3	5	9	90.43	66913157.00	66913157.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e7cd0501-0b64-4be7-ba9d-b63430a636fd	f94ed285-08a2-4f82-94bb-9237f31d7d4d	2	5	9	55.66	41416112.00	41416112.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
7f4cb231-af02-43e3-a541-96e413baf6e1	7ae96248-2de8-499c-87e0-35a31a55b046	3	5	9	72.13	47233420.00	47233420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6e5e4c83-861e-4f9d-b45b-ebb555dc4a17	96bea91c-60b2-4130-9f22-847fe5394540	3	6	9	90.43	57598867.00	57598867.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
335add31-23e0-4ed3-a9c5-b1f507866c27	552def37-659d-4c71-9c50-a289c4fa8314	1	6	9	35.45	28450217.00	28450217.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a9168642-2a69-4adc-b267-3591ebbc0c25	9a4bc554-cbcb-4324-9827-0a95cd7aa43c	2	6	9	55.66	37575572.00	37575572.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
e0f8f9e2-4ce0-4e63-abc2-2e82245e7a51	6f1c3c85-f701-43ff-9384-80b186904cb1	3	6	9	72.13	55167720.00	55167720.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
70eda14c-1b82-4866-a702-9871696d9e6c	a0f446b7-e4aa-4f39-b6be-8f377e6dab2a	3	7	9	90.43	57598867.00	57598867.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8eef494c-cd70-4884-ad99-3867289f80fa	35816c54-f2eb-4156-bdf4-5f343e9518e9	1	7	9	35.45	25543317.00	25543317.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
c98312d8-7e59-41f3-9cba-4300bca5e869	cc7555ea-7bd2-4b8d-ba80-62cea3723fc2	2	7	9	55.66	37575572.00	37575572.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
fa9accc9-920f-4275-b347-28281bfe4ca4	27fdacfc-08b6-464f-a113-bcec93530a88	3	7	9	72.13	47233420.00	47233420.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
719069b1-35c5-4354-9e2f-2a9216adef79	89529f0b-a200-47fa-8280-845dcb4d065a	3	8	9	90.43	57146717.00	57146717.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5357e9eb-9dea-4daa-831c-11a53df1d77e	69c1c888-f0c8-4e1f-8c1b-1a8041dfd14d	3	8	9	72.13	46872770.00	46872770.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
de2ac89c-e97f-473f-a82c-0590a3625a4b	62ec2f6f-700f-4413-9bbd-b4aac70972ff	3	9	9	86.77	52450525.00	52450525.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
2b265fff-817c-4979-b976-0b9eebc790b6	a72d0a86-191c-4adc-88da-80b964c0ef34	1	9	9	35.45	25365256.00	25365256.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
42bfdd1f-8704-4c0b-a7a4-af3cc8bbd01b	ef96dab3-4334-40a3-8ea3-d8b9bd68a2d8	2	9	9	55.67	37302152.00	37302152.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1dc81b8b-2b08-46a7-946e-e9e072bd11e3	19213ccc-aed9-44af-93c5-344f4d967c9b	3	9	9	72.15	44486666.00	44486666.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
5f7eb5b3-e4ac-4518-9e50-f1c467affb04	b5765259-9476-4b41-b68b-ccc80e2dd6ee	3	1	9	83.59	41795000.00	41795000.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
f14d3730-0337-46f6-9b42-5568521f874a	1a9938c7-1db4-4c9b-a079-ac8212cbf5af	3	1	9	83.59	42463720.00	42463720.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
9ea0f25e-eaa7-42ec-a034-704798f105dd	34714eac-022d-409f-ab0d-0a1403f90987	2	8	9	62.68	36667800.00	36667800.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
60d04baa-f38e-41d4-8d9b-3afc54864d5f	31386ee9-8474-4237-8745-96ca1b63fbb9	1	3	9	35.46	25420295.00	25420295.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
98e0c944-7b79-4727-8771-fb6ed03bfe22	cc907d8f-4155-4e83-b1e8-beae9ab481b1	3	3	9	90.05	66781367.00	66781367.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0534cce9-bc49-4c77-b15e-7eab73edb148	56cce17b-f3cf-4325-9ef1-963b53082f51	3	4	9	71.85	55022727.00	55022727.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
01e99c30-10a3-41c3-b85d-610dce7b2009	52277653-70f8-4e8b-a6ae-f2132bcd5639	3	8	16	94.7	73960700.00	73960700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
0c036e33-3ced-4289-a0ab-6110238d50af	c0aa67ca-b22d-46a8-80b2-a6c1f92a74b3	2	8	9	66.02	60475059.00	60475059.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
4ae5118f-9c9d-4858-a725-25b96789f70a	d44e79c4-b992-11ec-a820-001dd8b72708	3	5	8	119.08	153851360.00	153851360.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
91598cf1-2867-40be-b99d-c048f4bf7026	d44e79c6-b992-11ec-a820-001dd8b72708	5	6	8	190.96	230297760.00	230297760.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
c2940f69-0e95-4f6f-9af8-86e980606bd8	d44e79c8-b992-11ec-a820-001dd8b72708	2	6	8	58.76	69160520.00	69160520.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
b4165fde-cdaf-41f6-872e-220e214b25c6	d44e79ca-b992-11ec-a820-001dd8b72708	3	6	8	119.08	135155800.00	135155800.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
5619ac95-a272-4995-ba32-03fbece3f2ff	d44e79cc-b992-11ec-a820-001dd8b72708	5	7	8	190.96	197643600.00	197643600.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
9beb320e-94d9-41fc-8c8a-796c81ef823e	d44e79ce-b992-11ec-a820-001dd8b72708	2	7	8	58.76	80148640.00	80148640.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
c7a7ddee-b27c-4cc5-8474-05b09737de8a	d44e79d0-b992-11ec-a820-001dd8b72708	3	7	8	119.08	139561760.00	139561760.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
040a86dd-c7fa-4dc1-824f-44b0e9291a1c	d44e79d2-b992-11ec-a820-001dd8b72708	5	8	8	190.96	197643600.00	197643600.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
f3f7e814-4e4d-4e2c-941c-2d95df3fa142	d44e79d4-b992-11ec-a820-001dd8b72708	2	8	8	58.76	75036520.00	75036520.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
e6482d78-78e0-47fb-b9fa-94c2982f4a05	d44e79b2-b992-11ec-a820-001dd8b72708	5	2	8	191.04	207278400.00	207278400.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
cf6fe46c-1f9b-40ce-868a-1df64553c946	d44e79b4-b992-11ec-a820-001dd8b72708	5	3	8	190.96	180457200.00	180457200.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
845b0155-5464-4227-a404-68eb65dc2d1a	d44e79b6-b992-11ec-a820-001dd8b72708	2	3	8	59.76	70277760.00	70277760.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
7ac2b7be-cde3-4a6d-bf71-d8cb0586c3b3	d44e79b8-b992-11ec-a820-001dd8b72708	3	3	8	119.08	126582040.00	126582040.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
47a97fc8-9203-4021-8dae-af1c9dd2ef4f	d44e79ba-b992-11ec-a820-001dd8b72708	5	4	8	190.96	184276400.00	184276400.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
53dca022-843c-4efa-9505-6e8eb04c3f17	d44e79bc-b992-11ec-a820-001dd8b72708	2	4	8	58.76	71569680.00	71569680.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
f76987fe-5260-4090-a8b5-fa9204f8f5e9	d44e79be-b992-11ec-a820-001dd8b72708	3	4	8	119.08	131345240.00	131345240.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
189b1028-d169-4048-bec2-886e5c8f34f4	d44e79c0-b992-11ec-a820-001dd8b72708	5	5	8	190.96	188286560.00	188286560.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
b1858c21-9226-4244-a12a-018fce3e589c	b956ba18-6c08-11ee-a82b-001dd8b72708	2	18	21	108.88	101040640.00	101040640.00		2026-06-19	t	efb1d717-725c-4541-92ab-62173f6aebf9
fff2ff1e-b6e5-4c2b-b468-8db7a8454b60	09590f18-6c0a-11ee-a82b-001dd8b72708	2	19	21	107	98012000.00	98012000.00		2026-06-19	t	efb1d717-725c-4541-92ab-62173f6aebf9
cc0bf290-b468-4db8-87b3-0648d9bc142e	0c8f8458-6c0e-11ee-a82b-001dd8b72708	2	20	21	106.98	98635560.00	98635560.00		2026-06-19	t	efb1d717-725c-4541-92ab-62173f6aebf9
24de480d-4ca0-4563-9215-7caf49218a98	5b000ee6-68b5-11ee-a82a-001dd8b72708	3	2	16	129.62	121842800.00	121842800.00		2026-06-19	t	efb1d717-725c-4541-92ab-62173f6aebf9
195d3d68-c562-4bb5-bae2-e906ee20ff88	a5a1432e-68b5-11ee-a82a-001dd8b72708	3	2	16	121.32	114768720.00	114768720.00		2026-06-19	t	efb1d717-725c-4541-92ab-62173f6aebf9
8b9a0598-5004-4e89-af64-b3e8bf60fe26	62ed7b66-68e1-11ee-a82a-001dd8b72708	5	3	8	190.17	185986260.00	185986260.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
78c727f9-007b-4575-8529-5cba05b0c249	abf6c4bd-68e9-11ee-a82a-001dd8b72708	5	6	8	189.42	193587240.00	193587240.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
4e8cfa91-ad6a-4a9d-b7d4-64a67d21f54c	c9fb3bee-68e9-11ee-a82a-001dd8b72708	2	6	8	58.22	80401820.00	80401820.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
24251124-95bd-4a80-9819-58fd208d550d	ee341bbc-68e9-11ee-a82a-001dd8b72708	3	6	8	119.11	167706880.00	167706880.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
ef81210d-7e55-47b9-8cfe-5eaa7d8aee2e	2b0ed974-68ea-11ee-a82a-001dd8b72708	5	7	8	189.42	197565060.00	197565060.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
aaa99e2d-8a5b-4b19-b05a-a8fd90022b3a	372897d4-68ea-11ee-a82a-001dd8b72708	2	7	8	58.22	80401820.00	80401820.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
7fdf0ae7-34f1-4502-8ed6-1060de843037	4363c426-68ea-11ee-a82a-001dd8b72708	3	7	8	119.11	144123100.00	144123100.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
7eff7b18-f98d-4e4f-8d59-e618b2dfdf15	798c4452-68ea-11ee-a82a-001dd8b72708	5	8	8	189.34	197292280.00	197292280.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
4f1b41d3-5452-4464-bc98-cc310006d98a	9e5e8358-68ea-11ee-a82a-001dd8b72708	2	8	8	58.17	78005970.00	78005970.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
34e7ba86-8cf5-4b9a-a14b-18c66b956024	c2cdc250-68ea-11ee-a82a-001dd8b72708	3	8	8	119.05	146431500.00	146431500.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
d1cfeaa2-7a5d-4221-8646-b76a58f88411	7effb7e1-68db-11ee-a82a-001dd8b72708	3	3	8	127.47	139197240.00	139197240.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
76ca8702-80b7-4bd9-b80b-a6e132fa3aed	cd9e621e-68e5-11ee-a82a-001dd8b72708	2	3	8	58.8	72970800.00	72970800.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
0b46fc3e-8a2b-49e9-834c-bb616a77b0e8	9dfd0464-68db-11ee-a82a-001dd8b72708	2	3	8	57.76	70640480.00	70640480.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
cc5d0013-c7bd-44f5-a113-56ea2f2df288	e7daad07-68db-11ee-a82a-001dd8b72708	2	3	8	56.14	69052200.00	69052200.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
c1c40878-9979-43ba-babc-42dd31d514ec	0061527f-68dc-11ee-a82a-001dd8b72708	3	3	8	126.46	135565120.00	135565120.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
812ef1da-cc55-46aa-a5c5-d7afab67260d	185ac7e5-68dc-11ee-a82a-001dd8b72708	3	4	8	126.5	141680000.00	141680000.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
6abb94c8-4e4b-4dd7-b91d-6b088bf7eb4a	24766d41-68dc-11ee-a82a-001dd8b72708	2	4	8	57.24	71321040.00	71321040.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
34be744b-20d6-4f3d-b848-05a4a2910992	1167e4a5-b17e-4441-82e0-c4dadd791608	5	3	12	167.17	133568830.00	133568830.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
196eb6c2-fef3-4bea-b74c-08f735a61dc3	7883e069-d05f-4a8b-bd11-8d18c30d44f0	3	5	12	102.41	81108720.00	81108720.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
46eca260-4898-4812-8df4-db2e62e6b387	5025de48-11ba-49e0-9482-6bc942a0e73f	3	4	9	107.1	94997700.00	94997700.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
24a5d6a8-a4eb-4a78-919f-ce0ced28715c	ee7141a8-f85e-4840-ab8d-2aea307d1213	2	4	9	45.74	44550760.00	44550760.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
5e02d9fa-65ee-4ce9-8352-62a57628f0b0	312be723-e951-485a-b9bc-fd3521da5a60	3	1	9	67.66	36198100.00	36198100.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
85880199-9c58-467f-9df1-fb2963afab0c	8db33385-b6eb-47d7-bda3-f25ac3296730	3	9	9	68.75	36437500.00	36437500.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
12ffa1d9-eaf5-40e0-b160-603840cb4b87	d44e79b0-b992-11ec-a820-001dd8b72708	3	2	8	139.45	129967400.00	129967400.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
7ceaca8e-2cff-46a7-96b0-c4d29377341c	d44e79c2-b992-11ec-a820-001dd8b72708	2	5	8	58.76	80148640.00	80148640.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
11506160-f47b-4a73-853b-addaab3b8adf	4b36d5a9-0f36-4b63-bf1e-1817b79f67d0	3	12	12	106.25	80431250.00	80431250.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
77b3557b-da52-493b-bf6b-d89196013f74	f1d89aac-68e5-11ee-a82a-001dd8b72708	3	3	8	119.71	134314620.00	134314620.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
caf2d651-05d0-44ba-a291-052d3497a628	8311eaa8-68e6-11ee-a82a-001dd8b72708	3	4	8	119.25	140595750.00	140595750.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
f733af71-5d37-4ff9-be2c-488205e34759	dde409d5-68e6-11ee-a82a-001dd8b72708	5	5	8	189.42	193587240.00	193587240.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
29f6e334-a416-45f9-8a31-e5660c7a2bed	0819d8da-68e7-11ee-a82a-001dd8b72708	2	5	8	58.22	80401820.00	80401820.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
d6073d7f-99ec-4e2e-b5cd-b16f698464ff	32432f35-68e7-11ee-a82a-001dd8b72708	3	5	8	119.11	142932000.00	142932000.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
713c5b91-187a-4dd6-a20d-70b79108c1c5	35df1375-80ce-4bbd-bc89-f01f870557c9	2	2	8	64.98	43926480.00	43926480.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ebf7c14f-2412-4abc-8975-d7943b7390db	0a584a47-6a1d-4360-a756-0e127971749b	2	4	8	67.45	45866000.00	45866000.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f21c20a1-5492-4639-ac10-2ca0c1aaa1e2	e3cdae07-ef61-4b56-9613-c8bc2ea760e1	2	4	8	64.98	45421020.00	45421020.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
da4b8d7a-ed76-4984-92fd-a747b35e877e	91856965-1141-40b6-a0b3-c77a98b46a46	3	4	8	76.52	49891040.00	49891040.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
3ea052dd-fbd9-486a-b90c-3e4e574b3d61	f3575de7-864c-4506-beac-2b78e54f2f80	2	5	8	64.98	44381340.00	44381340.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
33dda6d2-d6b9-4953-acd1-5415936d91a2	956a6fda-e5c6-44fb-8cf7-eaf93c87f5d5	3	5	8	76.52	49891040.00	49891040.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
304879e8-a3ed-4efe-a291-726cc10cad44	509325ee-b858-4fef-8542-1dd94ad0712a	2	7	8	64.98	44836200.00	44836200.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
36fc3240-9996-400a-bdac-e220b2e8d5c0	c0d8184b-855b-4c48-98a1-93532f1f553f	1	8	8	38	29032000.00	29032000.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
74e5cd21-cfc8-4934-acb1-e183fa39061e	aa989ed8-6b20-4a0d-8005-9f9c45f79fe0	1	8	8	36.47	27936020.00	27936020.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
dea70b5c-f72d-43fb-a3d8-d3f08029afff	07556841-112e-4dc7-844a-4f082025f7d9	2	8	8	64.98	45096120.00	45096120.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
1496103d-70f4-41de-a165-1d3df6b68fff	0a91c38b-b4e7-49fc-831c-9080e98c29e7	3	2	8	92.07	58648590.00	58648590.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
bd23c9e4-364c-4d93-83d3-ff86620c062e	69bc04a4-85e6-4e55-87b7-21392ceff1ff	2	2	8	62.64	42532560.00	42532560.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
be119c82-5008-41c1-a882-ae5dece82555	4e489f1a-a2a4-4251-b2ca-82e5d03395d5	3	2	8	92.19	58725030.00	58725030.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
4f38dfc4-20ee-4cda-b82e-d1200792b78e	d880d2af-f74a-4fd9-a4e4-9e9be50cbcbe	2	3	8	62.67	43994340.00	43994340.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
687d75bf-39de-44fe-a91a-6ff97dd2ecda	2f9bfedc-e736-4042-9145-3fd6be8dffb0	2	3	8	62.64	43973280.00	43973280.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d5671ebf-b2f2-413e-b7ee-c345a57b059a	54f1e493-089c-48c3-8209-ea494a79cd58	2	4	8	62.67	42991620.00	42991620.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
23377c5f-5e92-476f-8bba-53e1d717963d	b1ac33ec-8255-4d64-91eb-ab3142df2b5c	2	5	8	62.67	42991620.00	42991620.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
bf2eafc9-aa31-4536-aa76-3338434deab0	0c741382-ecde-43bd-9450-d903d360d218	2	6	8	62.67	43994340.00	43994340.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
7e38dc87-2a77-4912-b49d-7f807a0d7ce4	311a1157-972b-4bd1-95fa-62babf860911	2	6	8	62.64	42657840.00	42657840.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
21d032fb-8dfe-4f5a-9e8f-1f31d2728031	b4b31bb9-820c-439a-b69f-1087a6ff1bd5	2	7	8	62.67	43680990.00	43680990.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6fefaacb-801c-4f3d-bb35-99d9fcc9b98a	5a1f85df-b8e6-4343-b231-f894ced66dbe	2	7	8	62.64	43033680.00	43033680.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a90f2974-d164-4404-b20a-c33cc0d303aa	a9b366bf-f984-419b-94a2-c91386c90313	2	8	8	62.67	43680990.00	43680990.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5f5a73de-f563-4042-8a53-a43e8837bf18	f843b7fc-e489-4d33-a8f6-168f20a82ec7	3	3	8	72.66	47446980.00	47446980.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
210077fd-75b9-45db-be47-b531f49a0b16	a3b6b9cc-66b4-4d16-8199-b9dfa4b5f21c	2	4	8	61.2	42166800.00	42166800.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c2a2c962-0a6f-4f02-9784-90c24ba10a19	be5b9a5a-0861-467d-a3a1-859428070d58	3	2	14	106.3	64949300.00	64949300.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
aceecd04-f510-4ea6-830c-71d9953dcf3b	168aba89-7789-438c-ace6-f6c856eedf0d	1	2	15	40.77	33676020.00	33676020.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
2695d857-6b25-48cf-98f2-15c9040b15e6	57f3c508-bab1-49ed-810e-fea8a78b418e	1	2	15	38.24	31700960.00	31700960.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
63550cb4-e6c2-4697-b184-0f75e9baa64f	ff4c32a8-698e-4c42-9132-cad88c309f28	3	3	15	70.34	52403300.00	52403300.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0fc92857-ea4a-4f03-a601-456115ed662e	4fd32713-16ed-458b-8edd-3525e6557d51	1	3	15	40.77	34613730.00	34613730.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
085b4a0e-24bc-4f25-b771-1eaa58d894f0	472ff9c3-abec-4cbc-95c4-e58fe9456864	5	7	12	167.99	134056020.00	134056020.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b3949bbf-d9db-4b52-9940-3ca318469a09	1ebbaa16-f796-49ec-8381-6106fdc6895d	3	7	12	93.47	93991798.00	93991798.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
86f10785-40bf-4378-9c85-2a4e441150a3	9e1e2224-8dcc-4213-86cb-675d097a7130	2	11	12	60.58	61693496.00	61693496.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6b2a9962-16c4-4589-a5bf-9353febcfa3b	8231b158-3dc5-40cf-acf8-ccddd1820376	3	6	14	110.24	113988160.00	113988160.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1c520def-b1e2-40f0-8615-35c16860beb9	a3f30464-ab96-42a1-8f75-9b190ddbe156	3	4	16	118.03	93597790.00	93597790.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
20fd1d5e-523d-4828-bbb4-2c30225a77a2	db15789b-d32b-44b5-8200-41f2a09bfef6	4	10	16	137.76	127979040.00	127979040.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
93a31418-734c-4548-890c-fad0a482e480	407b8a40-f199-4bea-8f6d-2a664cfa17fb	3	12	14	116.32	102245280.00	102245280.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a64a061b-b489-4a46-9979-f0d8a887a20f	ac92e7ff-5075-4088-bdf8-4e8cca3228ac	3	3	14	111.61	91631810.00	91631810.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
273ee002-0588-4734-adaf-13272832f6bb	366a7beb-60cb-4b41-bc5d-6b612cb764a6	3	12	14	115.8	92292600.00	92292600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7cfc265b-008e-4982-b6e9-b2b7b6aea766	a9b362fb-770e-4b1d-a9c7-10292ae697aa	3	6	14	114.93	91714140.00	91714140.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b9bd4db9-11d1-40ce-94af-22dd0b84eac4	f6a1f43f-d8b6-414f-a4de-8fe029b454cf	2	5	16	75.31	67854310.00	67854310.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2442f64c-183b-496f-b0fa-88cee450c1a7	8ca40f22-06a0-40b0-8715-e04444513a5f	2	10	16	86.6	72397600.00	72397600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d59d7214-19e0-44ca-95f3-5ab2bb758cb0	952bd627-538c-4be5-a1b7-b7029807df73	3	2	9	86.42	48504521.00	48504521.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8add8660-f135-4d7c-a73f-198d10daec2a	673c9c2a-68dc-11ee-a82a-001dd8b72708	3	5	8	126.41	157886090.00	157886090.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
2de9d4e1-4f42-4305-bf78-b10f4ecee6e0	978dd151-68dc-11ee-a82a-001dd8b72708	2	5	8	57.13	71641020.00	71641020.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
86d276ca-e553-497f-a09d-523ece2152b8	fdde6df0-7245-483e-a511-a903d81bf3a8	3	5	15	73.76	54656160.00	54656160.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6ff35848-9612-4597-ad7e-2f264c614252	0c983611-e7ac-4dd9-b01c-a38eb08ef91d	3	6	15	70.34	52051600.00	52051600.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c2c87c11-5e22-463b-a27e-335a2d4f985d	e39f0e37-0627-48cd-85b8-88d973980795	1	6	15	38.24	32580480.00	32580480.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
da873ac7-1d12-4726-94f9-2e1003b296a9	a763f1a1-cd69-440e-9127-3a017c12c9d6	3	6	15	73.76	54287360.00	54287360.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
46044c17-b2f0-4130-87ac-2121677de067	1399262a-6f76-4c76-8953-934d71c67ebd	3	7	15	73.76	54287360.00	54287360.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
30d1bb37-f0c8-4bc1-87fd-4a12fb6d99a0	e14fbb6a-ef28-4541-b9d3-d835dde0db33	3	8	15	70.34	52051600.00	52051600.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6f544747-ea99-46ed-9871-b1a0b611c10e	15397571-5561-4306-b19d-52a71432244b	1	8	15	40.77	34409880.00	34409880.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6bada354-2db1-4642-a692-21be07f2de1a	f312a337-69ae-4f27-adbf-8b1c665d05e9	1	9	15	40.77	34206030.00	34206030.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
11cd61ff-fc04-44cf-bff4-6b873d889479	b88011ac-2ce6-42e0-9468-82c8b34831f8	3	11	15	70.34	51699900.00	51699900.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
e1f07cdd-49d8-45dc-9c8e-beea619df427	60866458-89f4-4fc3-92ae-53ce1629ab24	3	13	15	70.34	50996500.00	50996500.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
812fba32-6cf6-4f0c-9012-723636277bf2	bb4a62f8-fda6-4b95-8d9b-5375191d5116	3	14	15	70.34	50996500.00	50996500.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8ba43f39-067b-4e0a-8180-e1afe42a21bc	f8c12e24-8cb3-4ac2-b846-72af9e8a8ed5	3	14	15	95.91	59464200.00	59464200.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b113a7cb-defd-4dc3-b1de-15660fe4f915	7427d4df-aae5-48f4-aba3-913ea0bdb721	1	15	15	38.97	29889990.00	29889990.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
404413f3-85fa-4fcd-bc9e-f97de486f83b	874032b1-7355-443c-aec4-4a5ba44072e8	1	15	15	40.23	30816180.00	30816180.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
dbee5b8a-0590-40de-a79d-0ef01d9cc2f5	6a32ba76-131e-44e4-93f5-8655f05584c6	3	15	15	95.92	58511200.00	58511200.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
2e9b472e-ce7e-4793-8eb1-67647bd9feca	2a10db28-d8a9-4486-b550-e31ca2639c29	2	2	17	63.89	43189640.00	43189640.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b0c71545-7690-44f6-b592-ed5d2a571fef	f40f4cba-daae-4305-b561-9f4b1e63d0dd	2	2	17	66.29	44613170.00	44613170.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
07c6e7b0-d04f-48bb-9994-e4c439fb99d0	a58dd7a1-0f62-4cb1-b563-292edc7d94fc	2	2	17	49.83	36575220.00	36575220.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
59031d77-ad1e-4504-9509-ec48ea9554ee	892bb47a-f5b3-4bc0-b79c-6c7295883ee2	2	3	17	66.29	46137840.00	46137840.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0eceb977-c517-4082-a80e-d354e137b7c5	a01efc7b-130b-4ac5-ad9e-5c7cb4550206	2	11	17	63.89	44275770.00	44275770.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
572489d3-8526-4ba9-9c30-8b918efc4ff9	6848f415-274c-492b-bf9b-ca949b022b26	1	11	14	40.35	31715100.00	31715100.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
43cd5a48-2e8f-49c4-a085-200bcec6c665	99a04508-78aa-4739-bdee-4b3d40a04e57	2	14	17	63.89	44659110.00	44659110.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
daeea37e-e153-4214-a5d8-9eed5064d9f2	923654aa-14f4-40ea-b88e-3a6ed927e160	4	3	14	116.95	73444600.00	73444600.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
95f69a43-e464-4c34-8af4-076dadf94c67	cbdedd74-2f80-4c3d-9614-e20035b19891	4	3	14	118.43	74255610.00	74255610.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
10b0f13a-275f-423d-95df-f3bcdd26b88e	e0fc289c-08da-453d-8a2c-aa06b529212f	4	4	14	118.43	74255610.00	74255610.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ad0b707e-1d08-4fac-8472-39d7f3c8e0e3	663f926d-8387-48e3-a66f-4bf693225e3c	4	5	14	116.95	73444600.00	73444600.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
46786623-bad1-43fc-8085-78d915e5bcc4	40b5089b-32c5-4a73-833c-36a07360b1ea	1	12	14	35.98	28784000.00	28784000.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
9bcfa7fe-47e4-4d11-84c9-c622c7cdc021	5fffc1be-5f49-4ee0-b395-76b8a8125d97	2	2	9	65.86	50038919.00	50038919.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
fa014ce1-10c4-4295-9693-55ef70b5d67e	980efdfd-ff49-4b07-9402-92c738cca161	4	7	9	117.29	73540830.00	73540830.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0d5f4309-9cf9-4e06-834c-e9f42a828e31	7e0cca8c-c68b-45f6-b17a-d63e1be3fe68	4	7	9	109.51	74138270.00	74138270.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
30dc23ee-f9c2-4564-94fc-de4ca29fdbff	f1cf1819-1f08-452d-9d7a-995258becba6	4	8	9	108.7	73698600.00	73698600.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
4bd35329-e6e6-48ba-ac6a-8405f4b732dd	88d36d85-5858-4a99-913b-fb4a3b1c004a	2	4	9	62.44	48041094.00	48041094.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a88c131e-14af-4754-a451-e110ad267fa3	4134442c-4084-459a-a7d7-4922353da554	4	9	9	117.29	71898770.00	71898770.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ad31161e-f3d9-47f8-b586-375de50a0297	4b10c297-995d-4c00-9968-5da60e9c6231	4	9	9	109.51	67129630.00	67129630.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
fe3f08f1-56d5-47da-9c1a-a67334573916	f12ff9a7-a49b-4d82-aa25-fd05ee029356	3	2	9	69.83	51380130.00	51380130.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b7cc56c7-d1dc-41be-8a02-b135441e6b71	6d602684-b4ed-44a6-8860-9b0082be1050	1	3	9	35.79	31901454.00	31901454.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
150c698e-237b-4815-8656-139a533f46c2	ea5f0884-d36f-424d-9f1f-789c41dca9eb	3	3	9	69.83	52148260.00	52148260.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f8f7b2ca-956c-4704-9c2f-c81ce1c9d304	379bd973-eb82-4eb6-a552-83024900cc8c	2	4	9	51.12	42208501.00	42208501.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c996256a-dc96-425a-b351-693a2dc72c3f	253040a6-a133-478f-947f-a044cc1bf591	1	5	9	35.79	31829874.00	31829874.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
222e6d84-41f9-4909-96d1-3506a6c04530	8fa01a9d-ce1a-4ae3-b760-a8674dc03b6e	1	4	9	35.88	31515383.00	31515383.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b993d687-6f23-41c9-b792-40a1d40de9e9	b4cabf12-7434-47fd-9a81-8146dd2e1715	2	5	9	51.12	42208501.00	42208501.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5d8d9863-22c2-4c3a-8309-cc1565022d9b	b707b837-a685-4af9-841c-4b0aae9de5e6	3	6	9	69.83	56547550.00	56547550.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
e4ab82af-4b53-4fc1-9054-33631cac3eb8	032ed41a-cc08-4ede-916a-c63b274ed317	2	7	9	51.12	41697301.00	41697301.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
570f436e-8b1d-4d26-a4b8-fb99743dde7d	055504ab-3a96-47a9-a2c0-7485094a5ecd	3	7	9	69.83	52637070.00	52637070.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
3ee1f7fc-6ba9-4b75-b7d9-325565502882	7090f126-593d-4284-a57a-303afbc1e29b	3	9	9	89.33	63386651.00	63386651.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
e2c50b0f-882f-40e4-9abb-17caee69d8cb	885d084b-da6f-41ad-922a-3248cab6bdb3	3	4	9	89.15	64983848.00	64983848.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a082844a-99d2-4355-8ad4-8582ff37023e	0f3e8a63-5844-4ebc-b32c-449d298bc2df	3	2	9	89.04	56273280.00	56273280.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
da289e5e-88ae-47d7-9b2d-3cdff8981d88	e67b416f-70e7-462d-871e-807745ab4526	3	4	15	70.34	52403300.00	52403300.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
454207b9-ce05-4d59-8eaa-77f38b62bcd8	57f21220-989d-4469-ae14-51a84f981ff8	3	4	15	73.76	54656160.00	54656160.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ec55500c-8952-4122-ba78-71361eda4852	6e9ca424-ea77-4682-af70-7ce252f59b78	3	5	15	70.34	52403300.00	52403300.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
67e15ee1-2b89-44f5-9a80-820561954842	178e3276-3c11-4b79-9265-551daa0c0eb3	3	8	9	89.37	59073570.00	59073570.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f0ecde8c-aa3e-43bf-a098-842791c1bfcf	899d43c5-f207-405a-be58-c041c962d917	2	9	9	55.77	43200072.00	43200072.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
1a4cfd68-4ed1-4510-9b66-b6efae63a0b1	cb059ee9-7971-497d-a0c4-bbcfd1ebd8ba	3	9	9	89.37	57733020.00	57733020.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
50e15d8b-13a6-43b2-828f-0178f6aba980	e09673c0-f1db-422f-8809-14eeda61dff1	3	3	9	89.38	59258940.00	59258940.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
856c496d-c8d1-45d3-9d6f-9ec818ea6c03	afe559b8-382b-440a-aa20-12adc32b27c6	3	4	9	89.37	60860970.00	60860970.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a5507d97-28ee-4096-ad54-dc4c4eae3e5b	e607e842-c65c-4fef-a6ec-d7d692cc9c87	2	4	9	55.77	40767870.00	40767870.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6f0dc66d-75a9-4946-97f1-44a63f3bab07	a2f6c574-e491-4cff-a0f7-dd05db5ae2f2	3	4	9	89.38	59527080.00	59527080.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ac19f234-e5c4-45ff-846e-ff12b570362b	79a42a31-6e0b-4242-a320-dbb215e3e8b8	2	5	9	55.61	40650910.00	40650910.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
212aa422-ca50-4f85-b505-ccc2c368c183	0a0330f9-6eec-47a2-be65-f6db0b49b9d2	3	5	9	89.38	60867780.00	60867780.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b2d87b8a-3bf9-47ae-95ee-8222864c52be	2cfdd27f-fddf-491f-85b7-12d07e0ff682	2	7	9	55.61	40094810.00	40094810.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0ecbae94-a865-4995-9414-427282b9d2d9	71f71d86-66cf-44cf-82e1-4ac4e2daa196	3	9	9	89.37	59073570.00	59073570.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5313ffc4-0ec7-4786-9176-66c4de89f959	663273d6-e5c0-4ef3-b67b-efff0ce8c374	3	2	9	76.78	53885497.00	53885497.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
e63c8f5c-da15-4154-a471-98eeac5fdccd	d609b4d1-76cc-4c82-bf22-264ba7ee4f08	4	2	9	97.8	60831600.00	60831600.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8dbad8db-232c-4227-bbff-a99c83c4464f	62e632ec-f22e-450b-8153-0391994f75b4	2	6	9	62.49	49301627.00	49301627.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5da266ee-2d18-4344-9316-ab51752ac5e9	1c6a6233-a954-48e8-8e14-922151113b0d	4	3	9	97.71	62045850.00	62045850.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
22c99b56-b6f1-4c9a-bd18-47e73aa6400d	193ed1b2-bad4-4183-8c59-d35afe640c9b	2	3	9	46.67	35515870.00	35515870.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
106f159e-8dde-414e-841e-4f89f0229c3e	06b631e9-7c0b-4093-9b3b-d4a15d41a346	3	4	9	77.18	52173680.00	52173680.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
53c047e4-94c0-43d6-b152-0593d9b345e6	709e47c5-3233-4dd7-ac03-d6273e3ee15c	4	4	9	97.71	62241270.00	62241270.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f83edfbb-24a8-4bd0-8e2c-735a205acb98	b369d81a-98f3-4c18-8740-b1860c218401	4	5	9	97.71	68690130.00	68690130.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
58514dc4-4144-467a-8252-b8240670d949	ca11bfee-247c-4617-aa91-997c28e302bf	2	5	9	47.52	36495360.00	36495360.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f2d8d6b4-ba11-49e2-8e51-e00f41ec560f	c6fc3d5d-b3ee-4fec-8c92-3f17e130a1fe	3	6	9	77.18	52945480.00	52945480.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
aeca6480-9fce-44e1-aea1-d37ef0a6afea	275998ca-166e-4ed2-a3ec-f02445403625	4	6	9	97.71	62729820.00	62729820.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8b47abb3-d98f-42e3-b981-771009fb8eed	b467bedc-1552-4de5-a29f-e2fb2dac4996	2	6	9	46.64	35679600.00	35679600.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0baa8151-289c-4f8b-b0c3-ed1093b9ecbb	f82b1ef0-8eaa-4d23-85cd-7942c1c572e8	2	6	9	46.67	35842560.00	35842560.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
4f0924f9-2c18-4b26-a024-a2e02adca157	30de478d-69b5-445e-8ad6-6e0e24a19a3d	2	7	9	47.52	36590400.00	36590400.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
baa1bd58-13c7-4b2e-a192-0ccd244cbe3b	24db9d0e-e718-436a-885d-865072302ab8	2	8	9	47.52	35877600.00	35877600.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c88fdff3-db53-4165-bdd3-01415421b4a2	98cda019-dbeb-4004-af47-53e464de6c2c	3	9	9	77.18	47234160.00	47234160.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
51189d77-fd12-4337-a76b-92be186642b5	bc2e4aa7-b2dd-458e-81bc-a0dbfdd19858	4	9	9	97.71	61752720.00	61752720.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c343faa8-7cb4-47a2-b22a-9230ce698710	db4c319d-7348-4af8-88cd-699961462b97	2	9	9	46.64	32601360.00	32601360.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
72be77de-3b1e-4e7d-9a9f-469e6c4818f7	7af85d33-7ddb-4051-a055-e4345fa26134	2	7	9	62.44	47416694.00	47416694.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
556b0299-5487-4109-81a4-b9f1e0393b6f	60d0216a-6c4a-449e-8642-cab6a7fb13c5	3	7	9	89.15	67925798.00	67925798.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8a88c6d3-9667-4e6d-9809-ba42aa458382	64760804-de1f-494a-9529-b5874d70fc63	2	8	9	62.44	47416694.00	47416694.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6ee97ea9-57f9-4974-be19-48fdc0964a37	f1578008-1400-4ad7-9323-36189bde4fbf	2	9	9	62.44	47104494.00	47104494.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
4ab99499-4e6d-478b-b307-52d2d1167247	a649e60f-5e9c-4b8c-b60e-e80edf75ed84	1	9	9	35.88	29219063.00	29219063.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
1d95034a-1b96-4417-8585-1853722a4595	8a3978aa-06e2-4cf7-acd3-824893189845	3	2	9	92.67	65571545.00	65571545.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
9dfd8d5f-599f-453b-b19b-1aad5ff9f900	7f81910d-2e7f-46b0-b90a-e30d0bf6140a	2	2	9	65.43	49689391.00	49689391.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
6f9d4469-e659-4692-8666-9ee175fcda03	450fccd2-3183-4e0c-b763-c30c0a4a0f2a	2	3	9	62.44	47577294.00	47577294.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a46110f7-150b-4782-a022-971de52a2b29	908688e6-6fc2-4b4b-b126-76768c62b384	1	4	9	35.88	31514575.00	31514575.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d2616bcb-ca6d-4fcf-b935-64bfb729925f	c6f42b97-9d56-468f-943c-89b4122a964b	2	4	9	62.44	48014374.00	48014374.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d52d2101-8968-4f3a-b6a2-545b09a7210a	a6981919-906a-4b54-a5c1-5c71d4eee6de	2	5	9	62.49	49952438.00	49952438.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
041133eb-e327-4db2-a0ca-308d07bafe01	3a072a98-95b8-484c-9b9a-2d0191b166e0	2	5	9	62.44	48014374.00	48014374.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
e84f4c4e-9c53-4e7a-a4ab-907d60dcf4b6	6ee23090-8fb1-42e8-8d32-b5611dc06950	3	6	9	89.15	67873231.00	67873231.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
916e9c1e-1bb3-4cc7-ab98-bf0edd5d4031	3b54c507-f59b-473e-8e8e-8d737a393590	1	6	9	35.88	31155775.00	31155775.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
69ce3ec5-8447-4996-9ea7-a24b0e56cb4e	149e3914-933f-43b6-9346-e8b58f88daf3	2	6	9	62.44	49263174.00	49263174.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
bfdabc92-3990-435c-bc30-b02612b93cba	ab9f0b45-4abc-46dc-98bd-cff1b2e93982	1	7	9	35.88	33165055.00	33165055.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
89b61956-4fbf-4bfe-abfb-b5262684a3b3	ad8eed82-03f2-469f-9cc7-be1c78ece1f2	2	7	9	62.49	49327538.00	49327538.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
86e8d32c-60fe-4aae-867b-aa93cc3270b8	736eaab3-a60e-4f1d-bc4f-c164c17109cd	2	7	9	62.44	47389974.00	47389974.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d49cd7f6-db43-4cef-848e-303d3ed34c6e	12e779c0-7169-426d-94e7-bac0e9793919	3	4	9	89.37	59520420.00	59520420.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
54f3c737-9593-410d-8607-98e79de2d358	698c3d1e-cd82-44b3-8c16-cc2fce08a025	2	5	9	55.61	45525755.00	45525755.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5fb043d5-4574-4f37-9fca-23ebde615ab3	18058566-8cb7-4788-bcc9-bc6cfc9af8f6	2	6	9	55.77	46267422.00	46267422.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
0178d6b4-8a18-49e3-9b45-08475123b67d	d7c38ebc-0ca8-41bc-b002-6d8dd9906cfa	2	9	9	62.44	47077774.00	47077774.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a8c30b38-654a-49dc-89c4-28b87389d780	7b9013e1-c7c0-43c1-8b59-4ef605bac99e	4	2	9	97.45	60808800.00	60808800.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8a9ad217-c0ba-4626-a566-6475493b47fe	917e76a1-75a9-4d55-a78a-72a0f472c1a0	4	2	9	114.33	71684910.00	71684910.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
3e0c7382-db82-4750-bb86-040c9e95ee6d	febf0666-8e18-46a3-a79e-f6fdc291ebcb	4	4	9	108.7	74785600.00	74785600.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
ae518533-9a21-45c2-b772-2cafe2e2681e	e91f95ee-85c4-4523-b0cd-7612756c43bf	1	3	9	35.89	30913814.00	30913814.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
53d50f7d-4931-4a5a-8448-2eacc432890f	fc0be793-6789-4874-ade2-6ded8e1686db	4	4	9	117.29	72367930.00	72367930.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
38cbb28c-ced0-44e1-ab07-6e524be8f406	10ea66f1-9e83-4f07-a37b-c8dbf07461b9	4	5	9	109.51	75233370.00	75233370.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
52286d6c-9a48-4e4e-868f-0c2a47517476	335b4ae0-0d7f-4c27-b2a4-39544cb4f13a	4	6	9	108.7	78155300.00	78155300.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
a28f99db-3916-40c7-86c1-dfa6941e4ed6	d710f84d-d62e-4af2-9419-c1f3dc871954	4	6	9	117.29	80695520.00	80695520.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
8d3ca0cb-292d-4896-b127-c06016ddf2e6	66cec85f-e13e-4fb1-8614-f368c5f93520	4	6	9	117.29	79522620.00	79522620.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f10e30ab-e897-4def-8930-b3e2a0196563	852be528-7cc7-11ef-a834-001dd8b726aa	3	14	14	71.82	45821160.00	45821160.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
b156984c-1fcb-4786-ab53-7ce24b58c761	ed73c06d-7c9f-11ef-a834-001dd8b726aa	3	12	16	73.76	52738400.00	52738400.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
87a5c30d-491c-404c-8020-775c0cbae209	7f73cf9d-3b51-417c-a986-7a0d6f448cc3	3	2	14	71.93	49128190.00	49128190.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
669174d0-aa38-48a1-b140-3c17fbda813a	7eedc76b-44e9-4545-b0db-a94c861ed7b7	2	4	9	61.11	48704670.00	48704670.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5a81531f-375c-4e8b-8dbb-ab69162e0164	dffb656a-2888-461f-8018-89ec487a1f5b	2	9	9	61.29	48235230.00	48235230.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d9b4a439-5aa5-42e1-b568-27acad433702	d26fc320-6df7-4ccb-b58a-943f664ed573	3	5	9	74.66	54128500.00	54128500.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
7de48f29-e25b-4102-8a0e-b1498978c1b7	97daecdf-c0a9-4104-b884-f1eef89aa7b7	4	9	9	118.58	81227300.00	81227300.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
3930b3b7-f803-4d30-8248-596d8315fa93	14b7dae2-795a-48e1-95ef-d4e17481bc4c	2	2	9	68.91	52785060.00	52785060.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
1a32e0b4-5bd1-4351-a621-259f2004f5d9	c38905c8-3ec9-49e5-9e5d-e7fcef89ae02	4	5	9	131.44	96082640.00	96082640.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
52ca912b-70a9-4ad3-ae7a-8e039e5e10e0	b0d692ec-5cf8-45fd-8f3b-1edb31447ace	2	9	9	66.31	49003090.00	49003090.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
95d1e05f-7703-4057-82ae-e778cdbbb25a	100105bd-83e0-4260-9bc1-6abb0939078b	1	9	9	42.41	36048500.00	36048500.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
2dba8aba-076c-4945-a782-fe4e40ffaa62	6cef6053-e039-4688-b9d8-0e6af0bffc88	3	3	9	77.51	62085510.00	62085510.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
98b4c728-f177-47bf-883f-0af4aa9a4e26	85cc995f-c21c-448c-b2ee-81444ee456b7	2	5	9	69.84	54265680.00	54265680.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
9515345d-4d66-4213-b7a0-6420a41d608a	17f99ee4-47c1-4234-95dd-e14688c29d4d	4	3	9	139.27	102502720.00	102502720.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
4887bf53-81a7-4366-9d60-561e91fd7d6e	66383f4e-91f9-486a-a356-594f394d3993	3	5	9	77.38	58499280.00	58499280.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
7ab1a43e-87c8-49c8-9727-9c796dae6935	32ab4429-536d-419c-afea-c3f2881b4ded	3	6	9	77.31	63471510.00	63471510.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
41acc67d-e9f2-4c56-a248-9bc4d6cf3f13	2659acd7-33a2-45b9-aa2c-cd5578803e8e	4	6	9	131.44	96214080.00	96214080.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
f607a5a5-8d04-4674-841f-320a8b708aa6	a2e6b729-763a-490e-afac-7bec1c924d39	2	2	9	77.87	54041780.00	54041780.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
84e370b6-df5d-439d-b585-464f5493295e	6a83a884-88fa-463f-9254-ee707ce38bf0	2	4	9	72.8	54672800.00	54672800.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
e33f1b6b-07bc-49da-bd6d-afc84eae81dc	c6c809ed-c9df-4566-8050-3d9cf77e1952	4	7	9	131.28	96228240.00	96228240.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
451514d4-ad43-4c75-bdf2-60b0e28e2d2a	54232862-9867-4900-9c58-3c8b35276a84	2	7	9	69.78	54219060.00	54219060.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
bc0e5584-43c6-4e09-8105-bd3be04bc8ab	2682ad14-adcf-4244-be79-7c15357d5a64	2	2	9	70.34	50293100.00	50293100.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
e0f2a0b0-a429-41aa-a6e1-9789d21a6f78	b64e7c4c-d049-4001-8a43-a35845a4d5a4	2	3	9	72.03	51645510.00	51645510.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
afee79f9-454e-401e-94b3-1d4e9d65b0fa	b72d611b-1b1a-4386-865b-ae7014319e1e	4	7	9	136.06	100412280.00	100412280.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
cc776203-d11d-4553-97ea-73d612279b9e	13302b55-0213-4fed-b8b6-63e5cfa281bb	3	5	9	105.35	86913750.00	86913750.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
d2a4bab0-e18a-46d9-9e2e-999a5f20b277	4e9d2557-a2f4-4b51-a64f-f473a6c1ddb1	1	5	9	42.73	34269460.00	34269460.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
d30e17aa-dcb1-4f49-b276-c8e2026d49c5	93550b9a-2691-47e3-9772-2f01c329bab0	4	8	9	131.28	95965680.00	95965680.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
adaaa029-4304-47c0-8e6d-63ee0c40c14b	456d07ed-2016-457a-9729-9627fe6617ee	2	6	9	50.52	39051960.00	39051960.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
8e106120-a283-4a42-9798-e6bd2401dab6	f0ba508b-e41c-45b1-8514-aa93207ad9ab	2	7	9	71.81	52923970.00	52923970.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b53f1b12-1387-4f3f-8956-809596329f55	c655fa19-c48c-4b37-8d8a-67e69cb82d61	4	2	9	134.91	99293760.00	99293760.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
8716c61e-4331-4726-acb0-aa53429b33f3	c77bea93-a377-4fd9-9e18-11c57aaf44cc	2	8	9	69.78	54986640.00	54986640.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
bafe2de1-4d9a-40aa-870c-21d0dc42a548	cc0fb676-27d5-4a84-ab42-b7b745258e3d	4	8	9	136.06	102045000.00	102045000.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
6c78d62d-bf8f-4bec-8bd3-fc9e26183ea2	ba93c78a-52af-42c3-a6d1-3fbc3c65669a	4	9	9	131.19	95243940.00	95243940.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
32731faf-ba23-4ad7-bed3-c8694312111d	01cd5952-1237-477d-addf-bcd8c19f2df0	2	9	9	69.77	54629910.00	54629910.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
81f496a8-57fb-4edd-894e-6e1d621033ed	cab25627-a723-435a-a719-87b7088fce30	4	9	9	136.06	99459860.00	99459860.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
4a5d2aa4-9364-4f01-89da-4d7c1c9d04f2	edd529f6-8526-4a63-84bc-f40cf2fcd03c	3	2	9	97.21	80198250.00	80198250.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
1cca22c1-ce42-4e52-a7b5-08119723cbd8	685d9297-3895-486a-a91e-7c575a8ea1bd	3	3	9	76.29	61108290.00	61108290.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ac6169b7-b11e-4b66-914d-05a6a71b9c5f	18642910-068b-46d0-9287-93c0925da68b	1	9	9	35.89	29222321.00	29222321.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
18c4c764-bacd-4be0-862b-ab20440c2d5e	5bddf04a-2900-416e-873e-a40c55dece32	1	9	9	35.88	29218255.00	29218255.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
855ec5e7-b6e9-414c-82e9-a98b48f75ff8	cb70d752-995e-4a28-8c31-fd22af4a33a7	2	9	9	62.49	47140388.00	47140388.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c3ac2fc9-9e59-440b-89e2-94842072e0ac	30a42379-501e-45d1-b0a6-e0de2391fcf0	2	5	12	60.9	49395489.00	49395489.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0f6364b7-383b-47c9-90ae-5e4a4156f9c6	106c82f7-9923-488b-8fec-580ab1f39b50	3	2	12	66.31	42154343.00	42154343.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
a95ef102-00cc-41f7-a157-99f118278ff7	25038ab2-3ac5-4630-a4af-bebe3e4afc62	3	5	12	66.3	43475013.00	43475013.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
0540fd30-4958-4b24-ba97-9db49df8421b	f973acab-86ca-4353-8ef4-c99d246271c0	3	12	12	68.24	42883037.00	42883037.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
06a03ca9-f3b4-40fd-9bfb-1a9488b215e3	ffd4be94-7ee4-4ce0-a843-bf7edf999f15	1	5	9	41.36	28703840.00	28703840.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
4a95796f-9c0c-4c96-8343-84f6a33d05e0	65d5735d-377a-4951-80a8-a4c82a1ce899	1	4	12	33.72	24042360.00	24042360.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
35b93911-8854-4de9-80be-10e613f573f9	d8278216-371c-4cbe-a444-883299e623fa	3	10	12	74.68	39879120.00	39879120.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
421ed889-65be-4774-a6d0-68162937b5a2	28b9b263-9004-40fc-b429-a0400da78a0b	4	7	12	128.92	75289280.00	75289280.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
1e3606ca-a782-471d-b67f-2c63bb371763	daf91d5c-fef7-41fe-b5bd-013aedbf879d	1	12	12	35.47	24474300.00	24474300.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
77144041-cee1-499f-857b-9d237e8534ea	d2a6d5cd-4fa9-404f-967c-a235184be581	1	6	12	35.49	29294937.00	29294937.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
63b05bdd-a012-41f3-93de-a1f0b0e73951	998c7033-33ce-42b9-a548-11253b15a79a	3	9	9	89.49	59116562.00	59116562.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
8d14e864-1599-4a33-bd81-4f03d967e349	25b387d5-1656-4926-a05a-4a0a834049d8	1	2	12	35.47	20679010.00	20679010.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
0e3b7df5-6ab1-45b4-a9eb-916c61ce9be7	54f854a7-5db2-4d94-919c-79e8fa14bd2e	1	4	12	35.47	24722590.00	24722590.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
6d0dd7e0-8f03-4720-b23a-986ca8625d4b	a9055451-e149-4ce8-b447-06a4cfe285fd	2	9	12	52.53	29259210.00	29259210.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
31250ff0-3cd7-4cd3-ab08-d2719456bf28	6fad23e3-6bd6-40f5-a1f3-cb8efe39292f	2	11	12	49.31	27465670.00	27465670.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
a11f80c0-1665-41c0-a9f0-c5ec643fcdcb	7d3dc27a-878d-4f40-9238-f0963e5950bb	1	7	9	39.46	28221132.00	28221132.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
d46c5604-c3a9-4666-adaa-e3d9b63505fe	dc778ca0-b16d-4de5-9cbc-b0e092bbdbe6	1	3	9	39.33	28208108.00	28208108.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
02e4ca31-e16a-421c-93eb-7a7997a4f533	a68f4805-8752-42cb-9f55-d318c0853dfb	2	3	12	53.15	30667550.00	30667550.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
10dc534b-4eee-4c78-a52f-a9a816c7d0e6	a9e1ff20-5934-4902-ba88-d8f8a69411b9	4	7	12	115.85	62559000.00	62559000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
4ab5e45a-9351-4b23-98dd-d755cbf51fef	c6be568c-1f5e-47d2-93d0-e07b578adbb8	2	3	9	55.4	41237784.00	41237784.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
798e18ae-27be-4f7e-8882-1450aaeea99c	925dda33-4b61-478e-acb0-5d33c43d8299	3	8	9	71.85	46759977.00	46759977.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
55061d60-7cb4-4551-928e-126092c80b56	83d22a01-4833-41fe-9ce6-2f94c7000797	2	9	9	52.6	31823000.00	31823000.00		2025-12-24	t	b4334f89-b8ed-47e6-acd5-d023fc10ccb6
1eea7b45-c51b-470d-b2c7-3ce0157f1d90	d44e79d6-b992-11ec-a820-001dd8b72708	3	8	8	119.08	144324960.00	144324960.00		2026-12-25	t	2c634fd9-680c-4b67-82a8-8966608baa8d
cf3f9452-9e12-4b2c-85ce-cac64901c7d6	367b729a-68dc-11ee-a82a-001dd8b72708	2	4	8	55.61	69568110.00	69568110.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
ce107f6c-7cdb-42b8-9aec-f171e4f9acfe	b6fe46c2-68dd-11ee-a82a-001dd8b72708	3	8	8	125.31	145735530.00	145735530.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
13800a79-5ff6-44e3-9843-6137accebbe1	d72fea74-3aa2-4b24-b4dd-603d32d172df	3	3	15	73.76	54656160.00	54656160.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
d95f16bb-c562-4a73-866f-10e6fdbfb2b3	1e93f033-55d0-49c7-a5c5-b8a17d432e9e	3	2	15	95.92	57743840.00	57743840.00		2026-10-16	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
5afe53c7-c5cd-48a8-a078-1c86259001c7	d0c9226b-82a6-4eee-b1f8-31e3fa70cfd7	2	5	9	62.44	49914294.00	49914294.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
c07c22df-70c0-4198-b82c-8eb24b9c3799	10b17c2e-88e3-4e6d-a0a7-29cf79a85dc7	3	9	9	89.38	59080180.00	59080180.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
f3a64049-4554-495b-ab56-cef6499e75f0	3bff854c-f7be-457d-aadc-c307bad83757	2	8	9	62.44	47389974.00	47389974.00		2026-11-14	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
37d70aff-bd59-4f46-a74c-6ffe76b5edda	852be736-7cc7-11ef-a834-001dd8b726aa	2	14	14	63.31	44950100.00	44950100.00		2026-05-29	t	a5edcb13-82ab-49f9-b3d7-ab9ca36b9bef
77e87aec-0cde-4858-8cb4-40e2b0c538de	ba231418-c27c-4343-bce9-d0cf96864373	3	3	9	78.01	57961430.00	57961430.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ed97a1e2-3bfd-4d40-bae2-1bc857bf5163	6f5e9833-2277-491a-aaf4-cab284b9607f	2	5	9	70.83	52343370.00	52343370.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
137b384f-c5ca-45cf-aaee-825cdb558717	bc2fccd6-60b4-4c2a-b3d2-a74f2fd5eb69	4	3	9	132.99	92561040.00	92561040.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
82a6a9f1-11f2-4c58-b525-784d1cf89281	64cdfe05-b5c0-4618-b29f-aa836e5eb497	2	9	9	69.53	55276350.00	55276350.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
beefeb08-6d17-48cc-9f31-dbf622fab7ee	a1c735d4-0479-4143-9b1b-1c1f204548ed	4	11	17	107.71	88106780.00	88106780.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
bf72dcc5-6250-4987-9126-27ddce36dfd3	53365a62-e727-46ed-aa48-7e7c9652038f	3	9	9	75.23	60033540.00	60033540.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
69594bbb-b918-434c-8cc2-fcc4fb380247	24a82325-d1b7-4bc2-8e47-b0a6948f8b4f	3	2	9	81.97	39509540.00	39509540.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3ef10a51-6c80-412d-8287-a15f499c8087	dd48f78a-d921-4760-9b44-b207c34066e4	3	6	12	71.5	40183000.00	40183000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
c4dfa1ce-2a66-481a-933f-45140ed0b706	7772212d-da56-4c7b-adc9-c5ef45e455ce	2	4	12	60.52	39943200.00	39943200.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
649fa587-d7dc-445a-a60b-03fe93464e8d	e5a0ecc2-b663-4a5b-a3aa-25479c32324e	2	2	9	39.54	23644920.00	23644920.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f9e0519a-6b46-47a1-9885-d767906bd777	307e03b5-1d7e-452d-9e23-37ba17bfde65	2	2	9	39.55	23650900.00	23650900.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4162c13f-7957-4a0d-bdd3-16e7f0b5b8a4	885f1bf2-8380-41ae-a51f-283fea3b5347	3	2	9	61.62	33459660.00	33459660.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f3c851ad-a6f8-46c0-80d6-934e0fcc95a2	f9bac313-0510-445b-81c7-7d714e44d325	2	2	9	53.57	30642040.00	30642040.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
92aff4cb-0290-4a9c-b68e-33f712836d11	0159c760-01aa-4ab4-8a33-7ccf4fbcb5d8	3	3	9	81.97	40575150.00	40575150.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ef33fb0c-8862-4bee-87f9-dc9553f1cef6	e15cdc7f-1095-4f2e-a3ce-8d60c91839a6	2	3	9	38.17	22672980.00	22672980.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
02a03317-8b04-4125-8e02-06d84aaf81a0	40f24d42-7a05-4aac-b2b3-fe191cf08240	3	3	9	61.62	33459660.00	33459660.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4bc8e41d-4445-4347-a2a9-ac8debfba7e6	c4620852-8fd9-481d-95a5-3cf5630908fb	2	3	9	53.57	31606300.00	31606300.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c0a1f4da-48ea-4cca-8b04-84fa8995beae	8b6767b3-e2d8-44f1-8e03-224e3b31bebf	3	4	9	81.97	39099690.00	39099690.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bb4fefcd-1c46-4d75-8761-f570843883a8	c4f20b52-b652-4f5d-b45f-d71bffeb7dec	2	9	9	62.25	36852000.00	36852000.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
425d25b3-7ea0-4c9e-a114-719cda04279c	34aa1299-bb8a-4611-973b-e73377c80138	3	7	9	77.77	57938650.00	57938650.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b391052a-ad29-4962-8ec5-aaed648bee84	2af8da6d-db6a-4aac-9b67-1415b329a2aa	2	9	9	72.72	50904000.00	50904000.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
9307ad9e-3924-403d-83f1-e69c18b7d702	602bcfba-bb6e-4923-ae27-e3fcbd2c8e34	2	9	9	53.73	39437820.00	39437820.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
5fa495c3-fea6-4bcd-a7ec-60533686ec66	0a6ec0b5-df46-46fe-8073-72007b7387af	4	2	9	131.1	78791100.00	78791100.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
4c444248-118a-486e-9db8-c0fafe3f487e	7033484a-2e08-40a1-aaba-e32cd5a7250f	1	2	9	42.91	34714190.00	34714190.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
a17de371-346e-4d0e-8c80-83b02e3f9569	9c33cfc3-26d3-47f4-a786-0a0a00d24830	3	3	9	90.85	74678700.00	74678700.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
a183682d-5c68-45ea-8085-220b3adf90e6	574de29f-b8cc-4ec3-b05d-010fe03fb31a	2	3	9	59.64	49381920.00	49381920.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b45dda06-3718-4c70-a982-d9fbc6c4c6de	f6d97be8-bcaa-490f-9281-bb3ce7c2c4bb	1	3	9	42.62	36397480.00	36397480.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
522b00ed-f6be-4d22-9d95-8ae9d3438485	84ab697a-dd21-492c-a475-bb5375af7587	2	4	9	69.05	50130300.00	50130300.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
0822396e-5258-466c-afbe-addf08d59b83	643490a2-a4ec-4154-bb0d-95d697978ea3	2	4	9	69.84	54894240.00	54894240.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
906fe0e1-4276-48a0-962d-d3ed39cf2c9e	54813d37-fd02-4838-971d-1dbf110fb7cc	3	5	9	77.13	55996380.00	55996380.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ee3fa729-8632-4694-bb2a-94b831b170e6	40891174-3651-446e-b2fd-8b9034ed7025	4	4	9	136.32	100876800.00	100876800.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
dac453ff-1758-48cd-9f20-546d00f20d3a	449f2e9a-3c85-4f2b-9a4c-aa64f00aaf2d	3	7	9	77.07	60962370.00	60962370.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
2c70a307-9daf-469e-a3c6-fe5be86e5f85	3724cce1-182e-4312-ae21-a9d80e2a0133	2	7	9	66.36	49703640.00	49703640.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
95db55fb-ac52-4307-afc9-035c2057fbe8	663cb20d-b155-4b9a-8b84-637ed23516b4	2	8	9	68.91	51406860.00	51406860.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
7f800102-8009-4122-a823-0b3914c51c43	a30b6424-5824-4ca7-8f8f-56eeb24bee6e	2	8	9	66.36	49040040.00	49040040.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
49f6c822-bad1-4f22-8d14-e4aa8fa41915	67a4a929-e1d6-43be-bc22-91c668380ee1	2	8	9	70.64	52556160.00	52556160.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
05a9955c-3c18-4d00-9e94-69324e0180f6	33e1bc4b-6a46-4298-be6e-392a9ed52e8d	2	9	9	68.67	53699940.00	53699940.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b677e84a-e7a8-4396-ad95-aac52321c46b	6241c401-1166-4937-b150-b72f8d406786	4	2	9	127.45	84371900.00	84371900.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
7d8043f4-1cef-420d-9957-f589f61a734f	55b4aa8f-221f-4699-b898-fa2de43513d4	2	4	9	73.34	54418280.00	54418280.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
474f1eb2-981a-498b-9029-34753e1be1a6	5b74c2bd-032b-4871-acef-f6cd007b8438	3	4	9	104.83	77679030.00	77679030.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
d1b945e1-8250-47ee-992d-ee2338608985	9e3487b6-0308-4b1f-be0e-9ea9b68d6954	4	4	9	138.08	95275200.00	95275200.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
62b9d1c7-9984-46b9-802e-95c23d322286	27b34e8a-2506-4750-be40-d73a37e7602e	2	6	9	73.34	53684880.00	53684880.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
d8393ffe-a98c-4a9f-8695-774ed06b6317	ea3c9cab-661e-4466-bfb9-951f6bb4ab32	3	6	9	106.02	78454800.00	78454800.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ac6d530d-cfdf-4be7-a143-2d08670d0ce7	3b37ed35-569e-4f6a-b243-ac37ec080b93	3	7	9	104.84	76638040.00	76638040.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
3d017df1-9b00-49ed-81fd-8579d2f7dd59	605e5a86-6209-4120-8963-9d0558c71058	2	8	9	47.65	36785800.00	36785800.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
cb5b9361-412b-4098-a54e-c81311941a65	b17866b9-e65f-4119-b5fc-73170e408d45	3	8	9	105.98	77047460.00	77047460.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
f80b0800-952b-41e6-9571-9df564afd4ff	3d560fcf-b9a7-482a-b924-ebb5ff3c5f56	3	9	9	104.88	70164720.00	70164720.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
2a7faaef-7639-40f5-b247-7972a034b9ce	bf45d3a1-bb5e-4462-a9a6-6c7605a9edae	3	2	9	105.73	67244280.00	67244280.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
d7ad950b-73b6-4b92-adea-f4aaa4bdc0da	0fd40d3f-a861-4063-9473-bc02b913bef3	4	2	9	123.77	80574270.00	80574270.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
95217216-8833-4324-af13-b490ed6341c0	fa7fcb9a-fce9-4926-9472-f9db36cc0165	3	2	9	72.85	48809500.00	48809500.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
cc35f7ff-d399-4232-8352-606ffcfd411f	1a54d121-67db-46c3-9b68-1ab7233fb4bf	2	4	9	71.57	53248080.00	53248080.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
3babb3ae-b7bd-4cfd-a599-63010f81e523	85cf523a-a17a-462c-ade5-d8d7e3f83299	4	4	9	132.53	97144490.00	97144490.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
6e82f8bd-e865-4ad5-a86c-9bfad355f3ee	9ac73607-358a-4ce9-94cb-d6ec77be9c50	1	5	9	41.33	33849270.00	33849270.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
3c96ada2-0803-410d-ae16-53011a67e7a6	cc894f9d-963a-4b83-8026-90b9693514ea	4	5	9	132.53	87602330.00	87602330.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
0b6b00ed-1b3d-4fa0-8f30-52b30737350c	779f0531-8b22-4bce-94db-5c0e2cb7920b	2	6	9	71.57	52532380.00	52532380.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
c3fc316a-2334-4038-b42a-00f00fff4947	329e0d94-5058-4660-ac97-d943ef2c373b	3	7	9	107.28	78099840.00	78099840.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
bd85f229-dade-4024-933b-06da87936984	d52ab514-2859-484d-9bdf-a2f71b2b6ac0	4	7	9	132.51	95804730.00	95804730.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
bcb55bfe-a0c5-49a2-86c6-72600d6f43a8	dc60e367-72bb-4531-af64-ec25d245da08	4	8	9	132.51	86264010.00	86264010.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
64866e94-f2c7-40eb-bf4d-722117399b32	dd5e6696-1291-4a9f-baa9-7f12994b7839	2	6	9	72.5	54955000.00	54955000.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b34046e4-521a-4120-841e-dec8feaf77ff	39648f00-bd62-4c87-8fc2-84867104abd8	3	7	9	103.18	78932700.00	78932700.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
5155137b-ab79-4d80-b967-162007819868	f542acca-ad57-4a92-8a55-e96580403c71	2	8	9	72.5	54955000.00	54955000.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ce9d3878-2d85-480f-8505-7dfd7a493930	04ccd925-df5c-492d-b216-087982e8e85c	4	8	9	133.48	100510440.00	100510440.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
63d64e16-a971-467a-bb92-02ff0a86098b	ff63eae7-3d44-421b-92f8-ccde7bb55fb8	4	2	9	137.89	92386300.00	92386300.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
e68ee71a-a50a-4de1-af0b-f67ae322e08a	6901b6e1-9561-4447-be55-aebf5af403f9	4	9	9	132.19	90682340.00	90682340.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
e792fd33-04cc-4302-a98e-ebb0ac388df1	5c3a6d44-0aac-4699-9781-ab49889c48f8	3	2	9	115.14	75646980.00	75646980.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
59ba9c1f-b725-4d73-a472-b9346360c9ba	ffad0be4-4884-4b20-a33e-d1c7232a1e18	4	2	9	128.38	81649680.00	81649680.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ab7062e7-b297-49f0-b733-1fe5fd21f635	c63dd5da-beca-477b-a3ae-d590a6fb1e89	4	3	9	131.74	95906720.00	95906720.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
8000ed0d-f1bd-47af-8351-74191d4f56a4	589798f4-6b1f-4ac3-94d1-788cc42d2a7b	3	5	9	77.95	57916850.00	57916850.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
fd345f4e-f1e5-42bc-b09f-5633329a7306	5ec457bc-22b7-4d3e-adf5-4a64233fcd62	2	3	9	70.09	55090740.00	55090740.00		2026-06-19	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
7c99a1f2-b76f-43cf-a81f-dfb97e1dd117	91a1b02a-acb4-4364-8e42-f723b8df3554	1	3	9	40.77	38119950.00	38119950.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
736e2011-dbde-4c47-b85f-40799c7ec540	ecd9080c-ee18-44dd-8b10-9466d313883a	3	3	9	76.3	67525500.00	67525500.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
46272bc1-66c2-44c4-9102-c9d10cf4dde2	c0a091ab-1148-4b7a-9868-a6a49a569b4a	4	3	9	137.07	94578300.00	94578300.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
41e09a14-7af3-4910-81f4-5ca0f0cd1f5b	b5066226-16b2-4f65-b139-8ce378a7b06e	2	5	9	66.86	59171100.00	59171100.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
c9d26b9f-5e17-42ff-9c5d-e0271f5dbe5d	5653b8b8-b819-41aa-83f3-1ca5346c57f1	3	5	9	77.37	63752880.00	63752880.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
170eddfe-2dd2-499c-8d22-819e71f65ee0	8e4821c2-f0e8-4615-b684-dd6259f5f74a	2	5	9	69.57	59899770.00	59899770.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
7f3aa1f5-e99f-4f36-83ad-24754f1dd508	7233a864-f529-43f3-bea5-ec1fbb983f51	1	6	9	40.77	37712250.00	37712250.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
5977d5d1-34c5-4c69-9a1b-0ebee058fc9c	50ff73c0-86fd-48b7-9b3d-5fc251f8212c	3	4	9	107.17	74054470.00	74054470.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
0aa450e5-1a3e-469e-b7ae-c11103239fb7	8784da26-73b9-4924-8d7a-9cbcf782da66	2	7	9	70.23	59695500.00	59695500.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
0b7c1b6e-9964-47c1-a094-de06b349e4fe	d5103a09-0de9-4c12-bd10-1074418ba4ff	2	8	9	65.41	57299160.00	57299160.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
6eb80531-f7ad-42b2-8ea4-5585cf6fe67a	a00e7c99-3ead-4ddc-9186-2a5d030aaace	2	4	9	72.5	55680000.00	55680000.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
1a9c17cd-ac0a-4a94-9379-973f47fa7df2	ebbf5a6c-95c9-4c8a-aa18-8c3e52d7540c	2	8	9	69.53	55276350.00	55276350.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
a4c44a9e-7262-4d4f-9327-788888438d76	5dcd931c-91de-42ff-9237-8daf43753ade	2	9	9	61.56	50787000.00	50787000.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
aaf83623-f1ac-4bc0-bee3-79fa06e14c8f	e09bb551-787b-4438-87a7-e388c0a9d21d	3	2	9	106.48	68040720.00	68040720.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
50ada954-f18b-4aff-86e6-1d1bc1a88b6a	2df1d5b6-f64e-450e-aaa4-641d63144da4	3	3	9	90.97	52944540.00	52944540.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
f21adf2b-7bf1-4aeb-bffc-53220612c80e	dc05e189-b0ca-4fb3-8551-9dd3e5a39563	3	6	9	89.23	52556470.00	52556470.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
8e996c85-ddaf-4fbb-b06c-5950cb0e0a29	d51250fd-7921-4912-a192-eb17160e4863	3	7	9	90.67	51137880.00	51137880.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
074df37e-c4b1-42d4-9db8-b391232039a9	d5df4837-3b9c-44f2-952a-b5cb18e0010a	3	4	9	70.72	42785600.00	42785600.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
136908f1-8369-4e92-871d-21405690bf73	a250595a-5341-49c4-a727-de0d653b9b93	1	9	9	35.89	21821120.00	21821120.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
578e7774-774d-4cba-9bf7-003f943bc186	68f1538f-07a7-404c-bf5b-ffdd02ed307f	3	3	9	94.08	50709120.00	50709120.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
63b6615e-df52-401d-9e79-11db3d9b3f50	35cad8d6-96a2-4c5e-bc77-a26497befe24	2	3	9	56.27	35787720.00	35787720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
631cc8c3-5169-4470-86ae-a698c78ecc34	06696d7d-fcfb-48ab-9074-a5d205649129	4	4	9	123.98	69924720.00	69924720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
a01164f3-f35b-4c16-9a99-3df0ba2de5a1	61095388-088b-4ad8-a5b3-9581f655e91c	2	5	9	56.27	35787720.00	35787720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
81b02878-0ba3-433b-9b1f-94cc0249868e	ff41d6fc-b554-475e-b85d-9b651d2c8f75	3	6	9	93.89	55019540.00	55019540.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
f7605d9c-ea14-408d-83c7-7cbebbe17e23	0bcdf482-deff-4b1c-81e4-bb3a88925b24	3	7	9	93.89	50231150.00	50231150.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
4d3004f2-20dc-45e4-8e8f-3f293a77ea6b	6b0345fc-5071-4bb8-9ceb-446e3510c0ac	2	8	9	56.05	35367550.00	35367550.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
26d23a18-49b1-4747-b5a0-6a4adc413d80	29543c0e-935d-442f-9f0a-139a9f0ff937	3	9	9	93.89	49761700.00	49761700.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
c67254d1-2c81-460d-9b51-4c7b2b5c555d	3f0296a5-b9f8-4a5d-8c85-d1d60e83bbcf	4	9	9	123.63	65771160.00	65771160.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
e8e67581-06a0-4571-8dfa-f3defedf6583	a580d4ee-20a5-415b-909c-eb977444900a	4	3	9	123.98	69924720.00	69924720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
07400006-ff3d-43c3-a19f-f1dd5f747bc5	daa02c66-39a9-452c-beab-305c12e94266	3	3	9	94.1	55048500.00	55048500.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
753b3fb0-cd85-409f-bd9a-3225310d030d	2324d5b5-d31c-47a4-adc3-50accd180a3c	2	4	9	56.27	35787720.00	35787720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
bde62957-ae0d-4001-bd60-31019b0d2ccd	290f89a9-2736-4417-9b1b-301aa4ca5f14	3	4	9	94.1	52131400.00	52131400.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
80dfe8c7-e14c-4eba-8f3f-328d2942823c	476e1ddc-6b92-423f-9d10-850e3608ae95	4	5	9	123.98	69924720.00	69924720.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
0d6d43d0-567e-4b2e-aab3-6f557504ef54	346ec6dc-523e-416f-a580-058ddd56c480	2	5	9	60.66	39004380.00	39004380.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
6557c32d-dbd3-4988-9358-4ce896e9f8c3	645114b4-07a1-4674-8d2e-6ac106ee9fe4	2	5	9	56.27	35506370.00	35506370.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
b35fb6b9-5bac-4556-91d5-e6ef28d4f4bd	d074516a-2c36-4b93-9171-6d336d03f173	2	6	9	56.05	35647800.00	35647800.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
c892313f-ec22-4785-9b86-571d2ebf919f	ac8075f8-690f-40aa-816b-da69554d50ef	3	6	9	93.91	52026140.00	52026140.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
10ee98f0-fe57-4dfa-9e89-83f2465ef9ff	eacf2061-0897-4d9a-83a9-686e9f0c24ce	4	7	9	123.63	69727320.00	69727320.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
4ec807f2-59ea-4d72-b0c6-75547aeab34d	f0181598-e8be-4600-a653-ef6c2fb39cfb	3	7	9	93.91	54467800.00	54467800.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
ac1fff64-5301-4dfd-866c-efc8f9408865	5581c152-2c94-4eb5-8156-7172bd1f1bf9	4	8	9	123.63	68738280.00	68738280.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
2fd13431-440b-4f5b-817e-6c96af216b7d	0afd2cbd-7466-4124-a69f-22d2725f2d22	2	8	9	56.05	35367550.00	35367550.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
b777f42b-7f95-45f0-890d-4bd8425566d1	9e94d3c0-6323-49ea-a19c-5932ac414e0a	4	9	9	123.63	65647530.00	65647530.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
6de49bf2-ae32-4e38-94a8-f60aeda688a9	4c45c63b-f796-4a6a-9495-8a6508817b89	3	9	9	93.91	51087040.00	51087040.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
4164485f-a0be-42e2-85bb-04bb8a292d75	d1eb8ce6-f0fd-46f2-9684-60ceda90c808	2	2	9	61.35	46073850.00	46073850.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
e3582f7b-28b0-45f3-bacd-a2633a81b395	eec437e0-387d-4120-8e40-b10e5fbbe252	3	2	9	73.46	51275080.00	51275080.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
2dd17a21-60a0-43e3-92c0-c5992fe69026	8a253bed-29d2-4b7c-8685-95d99113c7d4	3	3	9	68.87	48277870.00	48277870.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
353f4cb5-227d-453d-83cc-19f5ff2c6702	532f248b-1183-4b5b-824f-326aa3a305cc	3	5	9	84.7	40740700.00	40740700.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a32acd16-75a4-45de-bfc8-79ab737b32e6	5df837dd-7ab2-4540-a913-88cc21cc2cf9	4	9	9	138.47	92497960.00	92497960.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
b0935f92-a2fe-486e-921e-bcf8c42ec60c	b3f80b1a-831a-40bc-a684-641f3d94bea0	2	4	9	39.55	23492700.00	23492700.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
96fc78d0-4d30-4bf1-b0c1-41320e6f6b6a	86fc3de0-0c50-4532-b881-16bc33cd1e91	2	2	9	72.72	56867040.00	56867040.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
cd45bc2a-c5ca-4b53-8107-155844ba8c6f	9ee79331-cef4-4d9a-b238-1d92ffab9e3d	3	2	9	77.4	44272800.00	44272800.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
efa26c08-22fb-48d8-b894-663f891a644a	52823b94-c9c5-4f58-bc4d-fc5ebc49ff1e	4	3	9	120.69	67707090.00	67707090.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
6ba3194a-73d6-4719-a7f7-003fcec634c5	55436b2d-e262-48fb-b511-ab0f40e7b653	3	3	9	76.59	44651970.00	44651970.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
0096e1b7-d346-4503-a35e-e24e676f7e7e	dea8ba9f-b3f4-461a-91c3-6082b384042d	3	3	9	89.32	52609480.00	52609480.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
1c4b4b4d-6d53-40d9-88aa-1a6b13f38553	415d8385-cc50-44b4-a2ad-03ad67c41992	3	4	9	76.59	44651970.00	44651970.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
e9ddd0f1-c764-40cf-aa0c-3fc3aaf85cee	4121d187-6034-4173-9576-8f5ef81f699e	1	4	9	35.87	23781810.00	23781810.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
704dfe9f-eec1-4589-8301-1ac5ea1e9d1e	e38d8ddc-ea8c-48b2-a00e-1b5d20472b0e	3	5	9	76.59	44651970.00	44651970.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
6fc0c570-312b-4047-838b-1698081fb482	9ad793e2-a7b2-4903-8b7a-bee6cb32bc60	3	5	9	89.32	52609480.00	52609480.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
4f649385-0bbe-440d-964a-37a41310c07b	33bf489b-f637-43df-9e42-e3dac1b2a51e	3	6	9	76.19	44494960.00	44494960.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
8f1ce546-47c7-4aba-95c1-35b37372f641	b193f21c-5331-4c5a-be9d-5f078996d0ef	4	7	9	120.37	67046090.00	67046090.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
5f04cb2e-3d79-4b3d-a794-3afeb64f9ca4	ea305628-396d-41d4-ab12-4964c59d3a43	3	3	9	89.21	53882840.00	53882840.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
78b8a9b4-b197-400b-bc01-32e97f570cbb	85c16195-24ec-4f53-abbd-5e7427d46d73	2	3	9	60.51	38907930.00	38907930.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
59b0f840-618f-45ac-a775-ba5981cbf9d9	b0390441-348a-4923-a783-180c900c9922	3	4	9	71.87	43050130.00	43050130.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
ced6a4b8-5902-4a6c-90c1-bfb4eb540d0b	b25ccde8-d486-43a7-b5fe-2537ed4baa2a	2	5	9	60.51	38907930.00	38907930.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
3ebbb594-f246-4e98-b42f-9c0ce425e59c	eca90fce-5ce7-4b5f-aa63-6dcf794242da	3	7	9	88.9	53340000.00	53340000.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
cd376a67-2cd5-433d-9983-70a1c9501343	8c314571-2de0-4af7-b7e4-25ec0498980b	2	7	9	60.22	38420360.00	38420360.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
028815ac-3094-451b-bd19-298c26a21208	dd3b7eac-cd3d-4f71-9faa-594ef3e61538	3	9	9	71.58	45166980.00	45166980.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
13c41543-124a-4601-9888-7de56b9e312a	5dd8bb55-b530-4ae9-a659-15ac805fa9b4	3	9	9	70.21	41915370.00	41915370.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
1d55cba8-ba20-4d23-b93b-c5a2d47df037	cf192410-ad6e-4fa2-8342-d76dde96a1d0	2	3	9	59.81	38517640.00	38517640.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
51ce340e-80ba-4769-8cc3-08425bc10da9	fd9c4239-0105-4a35-a2df-9226700eec32	3	3	9	76.64	44297920.00	44297920.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
8483b576-1c31-4368-9b13-30ea87060155	1e85f6d6-0e51-4844-b32e-30075d2f7f05	4	3	9	120.9	67824900.00	67824900.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
c09b178e-3eca-4ed5-8df3-77b223bfa4d8	6c86971a-8f5d-47cb-b7fe-31c6c463fd78	3	4	9	76.64	44297920.00	44297920.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
1a3ab7d0-7594-40ec-9d1c-2c0f87668aed	9227bcf8-b91d-4283-967f-6d4b71c7cd5d	4	4	9	120.9	66978600.00	66978600.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
06c7949a-9472-45a3-bd3d-d60b6eb28be1	379f1a0c-2189-4c7b-9478-0c34d0ff8739	2	5	9	59.81	38517640.00	38517640.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
3165a4dc-5142-44b7-a3d1-3cdfc866d6e1	800ba434-35ce-4faf-be13-fabd2a84a6f0	2	3	9	60.66	39004380.00	39004380.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
05858268-1e51-4065-8f8c-f6b9b68f8ca3	49e266f6-ea12-44e0-acc1-53bcfc533178	3	5	9	76.64	44297920.00	44297920.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
568a752f-e763-48b4-b0f8-1d1dd0362111	e9685a9d-30bc-49ec-9f33-f7787480b28a	3	6	9	76.44	44182320.00	44182320.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
3ce3431d-d14f-4e88-a148-ff95c5999e36	8d13bc7c-cb22-4d76-8da5-04b2e487c1ce	3	3	9	70.72	43917120.00	43917120.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
3f9621b8-122d-4883-afbc-acf72db10006	83a6f009-3b40-4f21-87ca-010c272aa4bb	2	7	9	59.67	38129130.00	38129130.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
20183ab4-0663-429b-8895-7a2a442b247d	7031449a-35d6-42e7-a4b9-c7deaef61bb2	3	9	9	68.25	40404000.00	40404000.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
35977d44-4a3f-47a7-b1fa-ee11a0c37ed6	3dac2382-f23c-4185-86cc-63a352e2eef0	3	9	9	76.44	43417920.00	43417920.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
f8443b70-354e-4c2b-a1d9-f651c55dbe4f	23cb73e7-cc9b-46de-8db9-979fe696732f	3	4	9	90.95	51750550.00	51750550.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
9d2bb2c5-efed-4797-b451-5c91311d6c8a	fd4b9d9e-4345-42de-96fb-ed28bf9fd027	2	2	14	57.9	45972600.00	45972600.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f64bdb90-bd65-4dfd-b12f-14295931f46c	c6c6b21b-eedd-43c6-8219-ac6cb7087211	3	3	14	78.81	61944660.00	61944660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a5e3310a-d096-4643-b7d4-813662276faf	b283c294-4129-456c-8280-705d6fe4c335	1	8	8	35.44	34407135.00	34407135.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0d69742f-5a33-42ba-8489-a508e909c227	4407cbf6-2c93-437d-a9af-8e1436f11459	1	8	8	39.83	38465857.00	38465857.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
fece308f-4252-4041-94c3-e89a5307497f	93df545a-b962-4f75-b531-c99261a20856	2	4	14	53.48	43372280.00	43372280.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
e5070de6-fc42-4402-b6a5-7ab23387ea1d	d227faee-26d3-4528-b623-cbbecc37d6af	3	8	8	69.29	59594836.00	59594836.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
5cb523a6-9265-4726-bc80-72f1073a694f	69f067c2-c286-4d2f-bd52-9e1c69f4eca7	3	2	8	96	75840000.00	75840000.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
ac4669a9-58a3-44d0-8283-b4eca731dc69	a4339e20-09d1-4062-919c-bfc27eafe4e8	2	3	8	56.49	48976830.00	48976830.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
fcb53ea8-a9f3-45d2-ab1b-322a2638d50f	92d852d0-c0cd-4a75-8616-67ba35bf2fa4	2	4	9	38.17	22902000.00	22902000.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c9f0170e-1965-4f71-a202-7f58bd5ef02e	29ac4d74-3088-45b3-a7ef-2ca02a5f5698	3	4	9	68.87	48277870.00	48277870.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
d3c3d7e0-421e-4bfe-8b20-05cf54a3cd15	5c365ac5-5310-444d-a138-c56f11d688f3	3	4	9	61.62	35123400.00	35123400.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1445b5d4-b0c8-4c3b-b97b-e1795bc23237	486556b7-2747-4c23-a208-4fdbf05eec79	3	5	9	90.95	52932900.00	52932900.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
c17c2340-014c-4283-9bba-25786e1a9509	61fbdf24-40eb-4381-8664-4685be710fd0	2	9	9	44.52	36506400.00	36506400.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
365bb34b-4417-42b5-a464-02691deca023	20ffe7f8-3e65-45c1-8e51-5dcb66dfed40	3	5	9	81.97	40575150.00	40575150.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7d2c5e2f-0b39-4f0e-9348-9c84ab1ed414	b0b909d4-234f-482f-9d90-19c5279f5394	2	5	9	39.54	23486760.00	23486760.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f3c0d444-0156-4cf1-9304-b50805fdc62b	9d8aaa20-cbf9-47bc-ab61-239a365ebf5d	2	5	9	39.55	23650900.00	23650900.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cb1de35e-6562-4c53-9f5b-75eebe760869	39b7df54-9836-4cd8-8330-e94ccd9227e2	2	5	9	38.17	22672980.00	22672980.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7fd835d5-4067-4838-9399-04eb1f40b1b5	999f6a8d-0046-4ada-b7c7-782c6dbbddf8	3	5	9	68.87	48277870.00	48277870.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
59d31bfa-bb43-42a6-8988-7161e39d1f96	f5e7f09d-2229-40e5-a20a-dfde568805e8	3	5	8	78.19	65757790.00	65757790.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
04acc4f3-51d0-4cc7-bcf7-65e5c21e9474	56e94791-3860-4563-81a2-84beffad6b08	3	6	8	82.13	68742810.00	68742810.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f9ef9205-6d84-4baf-87d7-1c28e7f5e3b4	96e995ba-1e68-417a-9bcd-02f96597374d	4	4	14	100.7	79250900.00	79250900.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
ab37b46b-415c-4eb1-8d0c-85e9dedf7fc6	ce39208d-5209-4bc6-8b0f-012cc63ad04f	3	7	8	82.13	63732880.00	63732880.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
724d32c9-fdf9-40de-8664-a323ed27e0fe	de2ba697-7a04-4d38-a50d-70799542b153	3	7	8	78.19	64975890.00	64975890.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
020313a2-87fa-49c9-bf0a-f50956dbe8c3	91e87e30-51f3-4422-a36c-46f3d8857799	3	8	8	81.64	67516280.00	67516280.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
268ff8f8-c4fd-4404-a31e-5e61e496269d	ebf499d2-944a-48b4-b0cc-277471d7d44b	3	8	8	78.22	61480920.00	61480920.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
bb900a2a-2d7f-40e3-89f4-4eb0d994f5c6	607b2c1e-267b-4194-b8c5-f5c53879cd92	3	2	7	69.19	58949880.00	58949880.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
80cdf28a-00ce-4df7-b9b2-23f7da4859ff	b28a783a-1545-42d0-a719-c5605f011d33	3	2	7	94.37	75212890.00	75212890.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
1ecff438-e36e-41fa-a1af-f5669cf9b4a6	908f413d-caa7-4f1d-8148-0fecb43e57c8	3	4	14	78.81	64703010.00	64703010.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
66ce8d6f-3d94-47b4-9df3-aac8ef8ffc8f	5afe0009-6f5f-4369-93db-eda4f3a4e3f6	3	3	7	94.76	80166960.00	80166960.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
095046ae-cce7-4b08-863c-1bf4b9962261	302f4e8e-8d3c-4114-90fe-d0373e3b8cc4	3	3	7	94.41	79021170.00	79021170.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
98c9e027-241d-4ac3-b1cd-708f2c59eb68	194eda4f-d446-437b-b5d0-fa36e44319e6	3	4	7	94.76	79219360.00	79219360.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
3b03eefd-e251-4811-afbb-b3aec7fdfd8a	76383b46-a828-41b4-8b45-6f9011dfb324	2	6	7	57.2	48963200.00	48963200.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0bf681e8-92b9-4e2e-829c-6c1c0e431e15	f61ea95a-4795-412b-9ae2-47b109e3ae1d	4	5	14	124.53	97880580.00	97880580.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
8346edc1-609b-4dd5-99d9-fe923da0046f	360c3488-c241-4fc3-aef3-48a2332f5bbb	3	7	7	93.92	78611040.00	78611040.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
dd38c291-8936-4196-97e3-151fc81efcb3	b94de5fd-10f2-4c18-b67f-fda406bc2a95	2	2	13	57.79	45885260.00	45885260.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
608a8b34-a47f-4d68-9789-db5bfb7e7a8d	40cad7be-7650-4c28-aceb-309fe5c4ab7f	4	2	13	127.23	94404660.00	94404660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
7773f85a-3be1-4a91-8fcb-e4a555da66f4	ef4d50cb-7bed-4a14-a4c3-0471e826eba3	2	2	13	61.12	51157440.00	51157440.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
092b6cc8-4289-4806-8a1b-5bc2c71f475a	1d076922-1af2-4426-b404-c26e7012c141	4	2	13	128.71	90097000.00	90097000.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
6dc4e74b-b225-4bc7-b539-7be1f3268e63	2788696a-a30f-49d3-b1da-80aeafe6bdde	2	3	13	53.28	43636320.00	43636320.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a744ee0e-b646-4c92-b22c-76ec8f52213e	4e4f9079-0aa2-4c8e-9c49-2e2dfc3d439a	4	3	13	123.71	94761860.00	94761860.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
2c3bb87d-db6a-4b9e-ae27-4208503c0ac3	24342b45-5e71-46c3-8263-80067a7683b4	2	3	13	56.9	49047800.00	49047800.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f277e7e3-91e1-4f68-b94c-0069ec501a12	592b2f97-6fd5-4e04-88bb-a57c01005d3f	2	5	14	56.28	48569640.00	48569640.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
c6234169-5aa8-4dd7-9f1f-07fc5aeab91f	0db11a76-3012-4eb1-a2ca-a1db726e25dd	4	3	13	123.71	91297980.00	91297980.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
dbf1fd61-07d4-4d7a-9331-7eff024b6280	082e614c-7099-4bbe-a676-69f4c0722728	2	3	13	52.17	42414210.00	42414210.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
06cd3cd4-5342-47ca-9326-3e1afe022680	93d6ec05-ce03-4dee-99df-1b4ef87bbae9	2	4	13	56.9	49901300.00	49901300.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0ddb1a65-65d7-4fd0-b72a-50505c03baed	7e5b902f-7cb3-4f33-8315-9633ce1dfc73	4	4	13	123.71	92411370.00	92411370.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
cc784682-9267-44d4-bd65-de7ebb6b29d0	2c0dae5e-4298-4aab-a828-0dca6e2526ad	4	5	14	100.69	81961660.00	81961660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
e56274a3-064b-44dc-a8bc-272b2e8330c6	d756f189-234a-4acd-8a35-a9139aa8296b	4	5	13	123.71	97359770.00	97359770.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
dd918285-9b62-40b5-9f98-edd397793248	25591ad0-d567-4e31-ba2a-e17b33162c2a	2	6	13	53.28	43210080.00	43210080.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
290713ca-c242-4008-9475-0a2577691808	a6719726-157d-4dba-976d-27337e475605	2	6	13	56.9	49901300.00	49901300.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
daf481a9-c784-45cc-8621-0099865f0fc3	f78006c6-f160-4ca1-b53e-58da27f4cf13	4	6	13	123.71	92411370.00	92411370.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a6cdb96b-3c3a-4e7f-915d-faf136e010a9	5d7cd833-4dcc-4df9-9b27-d45449afcba0	4	2	14	129.66	95818740.00	95818740.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
5389751c-7e8a-4ad1-8b72-22d701f54e84	7928af8b-938f-4413-8142-c2cfee9644a6	3	5	14	78.81	61944660.00	61944660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
e4d5db41-1d34-4511-882b-6a5d60f60f0c	d62fb4aa-c137-48ea-a949-7589e1d7cb30	2	7	13	53.28	43636320.00	43636320.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
149d869e-e52a-4601-a642-d866bc236309	11d437ff-4b54-4f13-8842-33ad7358c55b	4	7	13	123.71	97359770.00	97359770.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a8ecc1ed-61e2-44b1-b327-234a5fcc5793	fa2889f8-49aa-43f8-9311-e73c1bfcd05c	2	7	13	56.9	49047800.00	49047800.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0e8386d1-cbc3-451c-b2cd-8083b12d5ce0	fe369a50-7241-4891-b13d-758f98e5a0e2	4	7	13	123.71	89813460.00	89813460.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
21a5c2ca-c950-471d-9f5b-80ddc6eda3b6	45456148-06b8-455c-a73f-cfc0f360a5e6	2	10	13	56.9	48478800.00	48478800.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
6417d2c9-09d5-4db0-bf57-169475a0ab67	e7ec939c-6a04-4333-a08c-0a3673103b10	2	11	13	56.9	48478800.00	48478800.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f83fb9a2-f63c-43c3-8d34-fd0a629216b3	921b9e98-24be-41c4-afa0-9a0324fceeff	2	6	14	56.28	49413840.00	49413840.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
7c9cbf93-9c82-4db7-8874-11fb879e8907	d7141b50-322c-498f-8194-e379c8e0a548	2	13	13	53.28	42037920.00	42037920.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
92f0dc22-db04-4042-bf06-deb3f3229449	9ab660d5-f18d-47b9-a50b-aa444e3851b5	4	13	13	115.08	97357680.00	97357680.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a4a723d1-96e0-4bb2-b15e-f8b28a7402c6	b52436f2-6ebb-49fc-b5e2-135e85772764	2	13	13	56.8	45099200.00	45099200.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
ca0c033f-1dc1-4048-8d97-c08c52866ab7	28f3d8ca-ac04-4bef-9073-ddb9b5cc9d6d	2	13	13	52.17	41266470.00	41266470.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
c932d13d-9ab4-401c-ac50-3743708dda4f	6777cdf0-61c7-441a-bfbc-5c721421cc5a	3	2	7	94.48	76245360.00	76245360.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
61a13d13-a703-49cd-8d5d-65b455b0f2c9	b8714692-4712-4665-b84e-b67f1230b833	3	4	8	82.13	68742810.00	68742810.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
aa7a75bf-c8f5-4e03-aa1b-805733a87d9e	d34d71c5-d029-4b05-9532-ef3542a2e502	3	4	8	78.19	63021140.00	63021140.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
35a06d4f-4d3d-4eeb-9acf-6157a718c2a3	568c8562-0736-4b22-9c40-e4b968049dca	2	4	14	56.28	49413840.00	49413840.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0d80243c-a32c-4c7c-a257-124e23137232	8f08c000-6d51-43a7-b5ba-e6d667f37501	3	3	7	94.65	81115050.00	81115050.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
b6268f9e-3421-4fd4-a408-2e4c02cbbe35	272ca6b4-a5bc-47b2-be57-8cf6629194aa	3	4	7	94.33	79897510.00	79897510.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
0e97a7a9-f172-4b59-b275-edb5dd8490a3	d225bd73-3345-4a0a-bd9b-a7b8d3e25b80	2	4	7	57.22	49552520.00	49552520.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
397f9d21-2b36-4263-ab2a-e6f9c461a340	7b333d13-6a49-4cd1-a41c-d0a01e3fa4db	3	5	7	94.65	80168550.00	80168550.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f76bdbab-1bbf-491e-99d2-9db3dc453148	be320b34-f6c6-4a45-b3b4-3df86e3541dd	3	6	7	94.33	80840810.00	80840810.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
b118b677-a0e7-426d-89b9-161c34ff33de	43964aef-b33b-49fb-a625-e9dcafd413e6	3	7	7	93.84	79482480.00	79482480.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
43e1e67e-1d6b-45b3-888d-a22b99380cef	20c9b592-1b99-460c-94da-48e780306130	2	7	7	57.21	49829910.00	49829910.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
78dd5c89-ed3f-48ab-aecb-4e388c101007	36992e77-3494-4b08-a7ca-8869a82d6a7e	2	7	7	57.22	49838620.00	49838620.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
67443102-f4ed-457f-b84f-d7bd83404d1f	9283b395-5dc4-4a8a-9388-3ad33f519d1c	3	7	7	94.17	79761990.00	79761990.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
393e7ea1-ac61-459b-97e3-32ab16e92ab1	2039a006-dc30-483b-b024-bb9c695f2423	4	7	14	124.53	97880580.00	97880580.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
d2ec7447-e025-46e1-bcb0-4528ad393b5a	38a259a1-9b34-4ed2-b5c6-054163acd7b9	3	3	8	77.46	67651778.00	67651778.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
336d6b2a-446b-485c-81e3-3ddac1de5392	ffcc1704-e9b1-4297-8296-acd4f21a10e8	4	3	8	108.24	89732414.00	89732414.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
763468d4-adf5-4d2d-93cd-484c3c002768	d8a544da-4ef1-495c-9406-e28a2c951ac8	3	4	8	77.46	66877178.00	66877178.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
9b129d5e-6826-46b8-971e-21bdd27d7b88	111d32e4-0944-4529-8573-e6651ce322bd	3	4	8	82.3	71504456.00	71504456.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
5b0101e2-6d8c-4233-9b86-32aaa5f7d37b	5a84498b-4ab0-437e-8081-c29f7dcbe1e6	4	4	8	108.24	92330174.00	92330174.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
b989313a-7bd2-4b88-8da6-bf8d43b32f8e	42be2694-b483-4f45-bf74-e5c9340d180e	3	5	8	77.46	66877178.00	66877178.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4dee977f-7f55-4dc5-aaf6-6b6b5269903a	c6f6161e-3370-4276-ad20-f117dac54a5c	3	5	8	82.3	70516856.00	70516856.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
cd165051-6e55-4f7b-9474-376b937f0ea1	6e496c73-6de9-4f24-b950-3b1e9625871c	3	6	8	77.46	66877178.00	66877178.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
67348b9c-5a7e-40c2-8211-c2d564e51dc8	5f3c1410-59b1-483b-8d89-e5085831974c	4	7	14	100.69	81961660.00	81961660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4d5bbfe2-b43b-4868-9800-b307947b5ef0	6254322a-856e-44e7-af60-50b65e5b878c	4	6	8	108.24	89732414.00	89732414.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
d5b05048-34e8-44bb-99e3-68d25739f73e	59b9388b-34ac-48a7-8d80-503a381138ae	3	7	8	77.46	66102578.00	66102578.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
2ba645b7-43da-4b21-a161-5a5ca52c4234	cadcd03c-971f-40c3-a43c-494ac2ddcf3c	3	7	8	82.3	70516856.00	70516856.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
d79527bc-f409-4b33-9e16-ea1426a85697	e4efdf7d-a009-4c8d-8ab5-c1e75705fd13	4	7	8	108.24	87242894.00	87242894.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
025d7b78-fcbf-4f21-b837-27cdcd99fda5	2c10bf76-16ee-4ceb-a3c4-309319e86f52	3	8	8	77.46	65327978.00	65327978.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
95efc063-6e4b-4369-96ca-4f67a2680c74	fafbb250-33e5-4362-8cdd-447884f930f5	3	8	8	81.81	68511196.00	68511196.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
27798a28-2310-4da7-8840-1e1018aa9eca	67bb96f0-c380-428c-b765-0507f1c442b7	3	7	14	78.81	61944660.00	61944660.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
27f629ac-6df0-4142-99b3-95fcd0572e81	ff95f69f-be05-4191-899b-104adc98d0f0	4	8	14	100.69	78236130.00	78236130.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
733e67e6-8c95-4999-80bf-946796cb2987	ff54f23e-c0a4-4c31-a0ce-e64261b256ad	3	8	14	78.81	61156560.00	61156560.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
1b93b2e4-15b7-400f-ab58-b18aafc971ff	e6109db1-f6e0-441e-93b5-ab0159aee5e2	3	9	14	78.81	61156560.00	61156560.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4d6f0170-2e06-4c5a-80c5-fa5dc24a7c45	aa03b493-0d21-4188-ab5d-0f5ea92dfb28	2	10	14	53.48	43265320.00	43265320.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
1c871b8f-e50c-466a-ba24-c370cc8604fd	eb83d711-d571-42c7-9851-6dd2d3a2ae2b	3	10	14	85.23	70911360.00	70911360.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
584551c6-0798-4cb9-9921-76214c48d442	3fc03982-fc0f-4802-90cd-19011b7902bd	2	11	14	53.4	43200600.00	43200600.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
49582b76-2d24-44ad-8c3a-1bfc86c52a04	79823077-fe93-4349-8e3c-edaef7156c99	4	11	14	120.51	91587600.00	91587600.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
5762144b-c52d-4143-954c-55d10a2a8dec	e8b8222a-3ebc-4b4b-bbb0-959b005de69a	3	2	14	83.14	63269540.00	63269540.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
d47efa75-90c7-478d-8dd0-3b688a823bbc	6d841f5a-c66b-44cd-bf49-2ed4c469a77c	3	11	14	84.64	70420480.00	70420480.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
7aa5317f-c5aa-44e3-9124-e8816d1be284	d470c856-0178-43fb-bffe-e301d3d3f6f9	2	12	14	53.48	43265320.00	43265320.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
2b2971d7-319d-403b-9452-fcf1c1f1c95a	96acfa75-bc43-4542-8ac1-094e1d4141b6	2	12	14	56.38	48035760.00	48035760.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
46ba2320-1f10-40e8-9aba-a2a7862d5dd7	f0b92fc5-0a25-4f9d-aeea-13bc80fb1c66	2	13	14	53.48	42730520.00	42730520.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
68ac7bd9-44ea-4c37-87d9-d8ff42ee021c	9aad4e3d-096e-4021-b652-a02febdd7dca	2	3	14	53.48	43800120.00	43800120.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
abb92ba9-027a-4c0c-9226-e6218de2fdce	11917c21-2afa-47c6-8464-1e552836dd4c	4	13	14	116.01	87587550.00	87587550.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
2b9b405b-31ec-4c0e-afa4-fc8c4c1072b4	1b0c6b0a-64cd-410a-a6f4-9f539da7213a	2	14	14	53.48	42195720.00	42195720.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
3943dff9-4aa2-467c-9a4b-7441a5c19681	43ba4d73-08b8-495c-8985-046f21f7a471	4	14	14	116.01	86427450.00	86427450.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
6d85f98e-c8fc-49b3-b2c9-b1ebaa2f8efa	c2c8676f-61aa-4c92-8e70-103b32041176	2	14	14	56.38	46908160.00	46908160.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
9368edcb-7d27-48e4-95a1-d10b26302fbf	57b15c47-98de-4b63-9900-b300f22879d3	4	3	14	124.53	95265450.00	95265450.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
e27ddf0f-e134-4caf-8221-d535c87c4221	a278cca5-3858-4f08-abc8-de31b62ddb6f	3	14	14	80.89	63741320.00	63741320.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
99bcb369-6c58-412b-97c0-1f4fe1fb95ad	a6d3ffdc-9e50-4147-9539-45e3eadbbef9	1	2	8	40.16	38401131.00	38401131.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
09108469-13c7-4fcb-b53f-ac0affdfbe19	9e2038ef-3550-480e-8e7b-3c67610fba27	3	2	8	75.04	63559913.00	63559913.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
b8f5ef36-27fe-43ed-8b64-89eee42d835a	80b1ddaa-f1bc-4209-be05-7785b9ea4d01	3	3	7	94.33	80840810.00	80840810.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
e1f18946-d35e-4f3f-9bbe-2a107fa168be	815cbc81-bc16-4179-8b75-953aa848e22f	2	3	7	57.21	49543860.00	49543860.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
30bfa1d8-9a09-478f-b2cf-31f54f9176fb	5dbcc6e0-4d11-483b-9cbb-e24bea2047ea	3	6	14	78.81	64703010.00	64703010.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4952fd45-e59e-4bf1-ba31-8ed05d33e843	a4749edc-3ec0-4e49-9a5c-b669b4de3ff0	1	4	8	40.33	38087757.00	38087757.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
dc9dd7c1-2c52-4cfb-843f-76a4492daf31	0a4744f7-a175-4e25-99d0-7bd10687d266	4	3	14	100.7	79250900.00	79250900.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
cec15ed2-72e5-4daf-83b3-6b13b6318908	31fa89be-e77a-45d0-90ce-ff3c2ceb3553	2	2	12	74.79	66338730.00	66338730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
f5eb65ab-65f8-4e7f-ab35-97f9b6e0263b	c46723de-7648-4fa3-9f38-611d053cb4ad	2	4	12	72.23	76924950.00	76924950.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
38927888-fb2e-4890-a70a-c999c4aca9b0	0b7ef2a7-5a68-41f0-ad78-c4ea49b66b70	3	6	12	110.27	108726220.00	108726220.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
158514d8-4480-4e9d-a4a8-87e8ce80b541	2ea474f5-ebbf-409e-be1d-c5db300f6533	2	6	12	70.59	70543841.00	70543841.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7624aa36-64f9-44aa-927a-1a902cf90cf8	f675a80a-763c-4b17-976f-9f6a9594291d	1	6	12	46.31	56585349.00	56585349.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
693615d5-22db-4851-96ef-8503e7b1fbde	7bfe8fe0-4901-4255-9a1b-b0e18e83e8ee	4	6	12	142.69	120430360.00	120430360.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
cb629ba5-386e-40ea-b0a7-c71a6eeb525f	2964b87c-582e-46be-9116-46f742b51e39	3	3	8	82.3	70516856.00	70516856.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
ae1a85a9-9ac8-4b60-8298-46c6ee7107e9	b579e2e9-298b-4be5-bf8e-989cba47ab85	3	2	8	74.11	62936523.00	62936523.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
bd40ab9e-d2f5-40d7-abf0-d8ff8313d21d	4d694d82-6fde-462a-a1a9-a48cd320fffc	3	3	8	70.29	61687346.00	61687346.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4c69b9ff-e12f-45f4-9a7a-398c9871b3e9	3b28b218-13a8-47b4-b2e7-93dbae9c869a	2	3	14	56.28	48569640.00	48569640.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
f0e0d008-dd5d-489e-ad72-37e9c2cd7f3b	5dc33845-da8c-449e-bdf6-b79736550989	3	3	8	69.29	61673536.00	61673536.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
4d04abf6-6f64-4bde-bc78-f5b030160dd8	8ba28c43-3e44-479f-b3c6-16cd15a163a5	3	4	8	70.29	62390246.00	62390246.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
c7e68f71-0f10-4ef3-89c9-8f4f20690dba	61a40be2-6e39-4edd-ae5a-08c6430b8868	3	5	8	69.29	61673536.00	61673536.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a9b402fe-5a91-4b0d-a319-fbd034afd80a	0c31eac3-5f1a-48ee-9ffa-6ec98bd2fdde	3	7	12	110.27	91634370.00	91634370.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
da9a8c64-3bf9-4fd2-9a84-85578eb9dd5e	dbc1998f-8600-4599-a0e0-be9a8c6d660a	2	7	12	70.59	81838241.00	81838241.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
841f511f-fe05-4daa-92ab-9b0a48add777	7b2cf70e-e938-40e7-8980-ea8140cc7d79	1	7	12	46.31	50981839.00	50981839.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e1d00010-2ec5-4815-8db0-5907a43c731b	9fbe4fc5-6c24-412b-9572-c5ae880bb7d3	4	7	12	142.69	120430360.00	120430360.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
805b1ee8-560c-4331-953a-4358658ff200	8eb773df-e7d9-4016-aa28-efb4ad4c94d3	2	8	12	70.59	69803263.00	69803263.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
ca396dc7-29e1-48e7-8405-6af9897044d1	dcf58611-097a-433e-a3c3-74b3bf7cb80f	3	9	12	110.24	90507040.00	90507040.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1cbc6eb3-1c89-473c-bb4e-a7b26e1d4a97	26da06b6-43ac-4313-a0bc-515cffc1a023	2	9	12	70.51	71854980.00	71854980.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
3a5c17d1-f480-4928-8c9d-fb4a2b77a325	7de07375-9442-43d6-99f0-29e906a1d2ba	4	9	12	142.45	118803300.00	118803300.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
3bafc244-ea9b-4917-a005-439695cdb414	97fd40c0-fadd-440e-abdf-9033065dd9e4	3	10	12	110.24	90507040.00	90507040.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
11d18109-c5c2-4ac1-b3ca-e20def91b424	8d2ab174-f529-4000-a564-a2bd57dc45e1	2	10	12	70.51	71854980.00	71854980.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2b52459e-5350-4298-95ef-e5538977c318	4b570924-e5ba-4268-9996-cc91a735b0b3	1	10	12	45.98	47287696.00	47287696.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
816ea5c2-d4f5-4eb1-b777-8762d70529e5	c96b8d6e-b8f0-4dde-891b-008462aa14b5	3	4	12	108.61	107306680.00	107306680.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b8a110a1-75ba-4759-91b3-a09ad0ca7f7e	54f44554-6e26-4a50-bbd1-08e3d6540636	3	11	12	110.24	89955840.00	89955840.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e1054efc-9652-4dfb-b280-5eaf81971947	58b45ba6-2a8e-4b5c-9514-848d2632ccf5	2	11	12	70.51	71502430.00	71502430.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
87d5cac0-3cf4-4f01-8ab1-451662c96825	0ebde55f-8c71-4b4f-a9fb-6d68ba0e0269	3	12	12	110.21	92135560.00	92135560.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5923b19f-ba22-411c-970c-981aadfc4a53	8978343b-1f86-492a-8796-70ac1be1df67	2	12	12	70.46	63484460.00	63484460.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
73bb0289-8cbd-48c1-8c1b-c96302b0a936	5c28f886-28d7-4087-bcae-4ea1dbbeed8b	3	5	12	104.95	104110400.00	104110400.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
f7abf0d7-aeb9-46af-9ca7-351386a7a4fd	c037c0c8-0157-4301-9cb1-caa147a9b810	2	5	12	72.23	66740520.00	66740520.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7b28b61c-598c-4649-9ec5-2d40cbbbbb08	1d2d3716-6e3b-4fb9-ac55-f388bfdcf8ac	2	5	12	72.62	75089080.00	75089080.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d239447e-a439-41ed-b6ed-c65db29bd833	1cd9ddb0-e8e9-4ac0-905a-5da3345c6abb	3	6	12	104.95	87843150.00	87843150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
05c1cdf1-dafd-4060-bc53-e543cb21d0ea	d0c706ec-f52b-4446-9a3f-d26f3bac0995	2	6	12	72.23	76924950.00	76924950.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
cb1c9446-5e47-4619-aae4-11b759023835	d2054917-1ac8-40ef-8bdb-87ee5c043864	2	6	12	72.62	64849660.00	64849660.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
69af675c-7935-4f53-a003-4ecfe601bccf	40845c63-9841-4ad4-8a81-4dde09ebe24c	5	2	12	170.92	136052320.00	136052320.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b24fdabe-cb2a-4ace-bc37-53ab9e3e0fbb	2b3f6b84-c6ef-455a-8fe4-fe1a64b2bcd6	2	2	12	74.8	65150800.00	65150800.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1a35adc0-bc22-42a4-a378-ac6594def711	cc67d422-bd52-4c89-9398-375c4d485b63	3	6	12	108.66	107356080.00	107356080.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
4cfed2b5-31e3-40a1-b279-ba6d48775b29	690763d2-5752-4c76-b04b-6d7cbd6cf37e	4	2	12	131.42	111312740.00	111312740.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d98758db-24ec-4e45-9444-a283997024d2	b32da28a-ee83-4f2c-aecb-d116db309e47	2	5	9	53.57	31606300.00	31606300.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fb6ad5d2-976e-4b1e-86d7-e1ffc6bfef17	66cafdff-b449-4b89-ba77-6670c77ea040	4	4	14	124.53	95265450.00	95265450.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
2b0a278c-c74a-4d97-b71a-8891861a4692	b18e55d0-213b-45d9-8750-b386aae02b37	3	6	9	81.97	39099690.00	39099690.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
49681972-5281-4943-b7c6-7cfbe6996170	016206de-9d03-4bdd-a0d9-59bdf30503dc	3	2	7	69.18	60048240.00	60048240.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
283f6253-2850-4394-9011-9df848b0bdc3	92253254-d94f-42e7-ad3e-9c9f691153d9	2	6	9	39.56	23656880.00	23656880.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b6c84df2-b73c-4599-befe-525b02f04b51	22b8c1fd-1043-48b6-9534-a966627c6b75	2	6	9	39.54	23644920.00	23644920.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d651b543-a25b-4ec3-9a3d-61ab587a9f72	f5ad66c3-c9d8-4972-b78c-8605f11b17ba	2	6	9	39.55	23650900.00	23650900.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1a6451b5-4806-45fc-becf-acac9619f737	34396fa4-6894-408c-912b-85d9be93c4d1	2	3	7	57.2	48963200.00	48963200.00		2027-02-26	t	1e729afc-964b-4ef5-aa54-7ad9b41b1565
a7d486f4-47f0-4506-9b49-830b9f5482e8	2e815ad7-2154-4a7f-a41e-4656c9f9afbd	2	4	12	60.94	58746160.00	58746160.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e6564096-ed7d-4a55-8e7a-82913d65a966	9a7ba8b0-10cf-4df1-94f0-35c0e9fefd8e	5	4	12	167.99	157910600.00	157910600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
795ee552-50d4-45ba-9e6d-38cbcf9c2013	7c94fa5a-8103-43fc-97e4-5d3f642a250b	5	5	12	167.17	133568830.00	133568830.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
04ae7e66-9026-4544-a9ec-70ccf0de4f1f	f3506d88-93be-4a3b-b4eb-39d5dc22a783	2	5	12	60.94	65571440.00	65571440.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
324bf238-9934-4b81-926e-78657b04fc5e	926dd72d-5cad-4450-8514-bb6eecd463e1	5	5	12	167.99	134056020.00	134056020.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6fcdfc35-6a4f-4f53-aebf-e8452aceef53	61756e30-535d-4612-8e0f-c460e58cf3ba	3	7	12	104.95	87843150.00	87843150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b2a7ac4f-8e22-41d4-b075-e414e3561b37	25b05444-f902-40a1-bbc2-c8ac9fff06b5	5	6	12	167.17	157306970.00	157306970.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2d5b9a0c-e77f-41a8-8f8e-8a7d8fd0181b	b31e72a9-e07d-4020-a093-adc4f616ffe4	2	6	12	60.94	58746160.00	58746160.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
fa4f379e-127c-4603-835d-550c5ea559eb	3ac3cd52-e80f-4e68-b267-d0177e30fe23	5	6	12	167.99	157910600.00	157910600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e97e4dbd-dad4-4f78-ae95-3f29cc3b3472	b922a801-84e2-46fa-8975-5829dc06973b	5	7	12	167.17	133568830.00	133568830.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
df9ee3b5-b687-47bd-b1b7-bef09ec7103c	cb493cb3-06a3-42c0-9e52-079ee88b069e	2	7	12	60.94	65571440.00	65571440.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
52e15cf4-3c0e-4f0c-b951-624464ca4600	0940892c-c0da-4dd1-8780-3f67656adc17	5	8	12	167.17	128553730.00	128553730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d688fb25-3e22-4544-b680-47f31ec81d98	71e08e1e-28a5-4315-81eb-76d586737886	5	8	12	167.99	127336420.00	127336420.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7c68f6ec-b743-49dd-8592-486b96a58216	c0a83d81-6141-42ea-9fcf-c4ead2a6716a	5	9	12	167.17	128553730.00	128553730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
86849eb6-aea3-43b5-ab90-352227d17285	fbd8ea28-8874-4075-b810-1e7297bbbdad	2	7	12	72.23	66740520.00	66740520.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e6999c80-d372-4af0-ac35-1ed59b407973	4cbcf327-a31a-4f46-b784-bca5aad09058	5	10	12	167.17	128553730.00	128553730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
819e76b7-e910-4268-9e42-771a68300664	4aecb3be-9ff7-4183-8c78-0b3f57c0c14e	5	11	12	167.17	128553730.00	128553730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b9d9e5db-77fa-40ca-b015-850aaf10c15d	0b0cb857-1afe-41c5-83a2-3eaca1213f1c	2	11	12	60.94	57832060.00	57832060.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
107136e6-0abd-452c-b420-ecd2757714f0	2472b445-14db-48ec-b346-986a59d153af	5	12	12	167.21	129420540.00	129420540.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
54301ffd-ca44-4c0c-899b-27885471d628	70fd613f-1218-4645-b6e2-ed13710e4a99	2	12	12	60.89	59002410.00	59002410.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6d51341e-9250-4707-9f35-8b98452f23fd	7e9953e9-d726-44be-a733-000dda4cf569	2	7	12	72.62	75089080.00	75089080.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c4abe31f-c438-47be-98b0-e93718c492b0	2b6dbd86-53b6-441f-8d17-671e41ac61a2	4	12	12	154.64	150155440.00	150155440.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2ea417ca-84fe-4880-b6c3-065c2e1d0254	1d912f60-1a88-4569-9802-4cf03e3fde67	2	2	12	61.34	62270132.00	62270132.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
0890e2d9-2ff1-41b8-b9e5-405c79b6c6b8	a662b0a5-66f9-457f-9a1c-faeee45cb749	3	2	12	96.48	96399028.00	96399028.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
ca5351c7-5140-4cc5-b955-ea778412fcf3	91dce13d-3669-484e-81d5-3543dbd2394a	3	2	12	111.97	90583730.00	90583730.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b2984727-0048-4091-be86-007067f228e1	afd1a113-5fd1-4c55-981b-6a3e7e2966a4	1	2	12	52.45	54251982.00	54251982.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7104d5f9-4521-47bf-9900-ffb456f13ff7	b214b120-30be-4593-b0ec-c5f978d70381	3	3	12	115.01	116160100.00	116160100.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
505c2fe2-e518-4cc8-bbae-599c1f745fc6	063d0803-74b6-490f-bf40-29d6f6ec0171	2	3	12	67.94	68248580.00	68248580.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c0904d2b-8111-49d6-98c3-3c0b31f1c3ee	ac127707-2a1e-4203-8fc2-3cc99c496304	2	3	12	60.58	72294996.00	72294996.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bf1d0266-1eb6-47a6-93e6-2402c0e7ba6d	8a72b7e5-8f6b-43f5-8630-2912418b9d67	3	3	12	93.49	94008687.00	94008687.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
96789a64-bdab-4e5f-83eb-1047bbfc59ac	1ad58652-879f-430e-8768-d7fe88e03460	3	4	12	115.01	98333550.00	98333550.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d7d18012-9b5f-48da-bbaa-e8509e072f83	c2e86466-fc5e-4026-b9af-c1b415518865	3	7	12	108.66	90513780.00	90513780.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2d342a6d-7589-46f3-80f8-ea52e93a7243	1eb3316c-248a-42ad-a467-86fbe2783cba	2	4	12	67.94	79118980.00	79118980.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
ab3e7f5d-964f-4a0b-b7a3-a03fb63c4a2d	285bec67-d24d-425c-8285-99c85142154b	2	4	12	60.58	62602196.00	62602196.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6fc7ef19-8970-4ece-aa78-5efacd933848	10ce3484-4d41-4384-903f-ab3775bdf3f0	3	4	12	93.49	108967087.00	108967087.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
da442a45-3777-4223-a078-6e98a8375bbd	e0105649-bac7-488f-81ae-417cd9f79f2d	3	5	12	115.01	116160100.00	116160100.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
a109c642-4b7c-4df9-8349-00a237416ba8	611a668d-3240-41b4-89b2-c8c3305cf19f	2	5	12	67.94	68262930.00	68262930.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
da15b09f-9983-49b5-827d-c5fcf8ac356f	3ef676e1-991b-4d3a-8b1d-845bfd3b63d4	2	5	12	60.58	72294996.00	72294996.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
8c8d8bc9-cca0-40d9-8c4d-fc7bf0e6abe2	a5e0bd12-9bed-458a-8432-b1a770c9de48	3	5	12	93.49	94009498.00	94009498.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
f10f7daf-af24-4d76-8125-2d6b3073ad2f	53d99085-a628-488e-9209-8d263ba6e289	3	6	12	115.01	98333550.00	98333550.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e4da4250-8d23-402c-a827-5c37cae88d12	d3387928-dacd-4fdc-a68d-38d227c0a338	2	6	12	67.94	79133330.00	79133330.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
091727ea-8632-4a90-a0b1-dbc2345a3ed6	505b2df5-fcea-4594-9c27-01c1c9fbfb4e	2	6	12	60.58	62602196.00	62602196.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c7961fe9-a1df-4ed9-9ab2-152fa90dca01	466cf03e-afd3-4672-a2f2-0f8e854f6b19	3	8	12	104.8	86669600.00	86669600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
089f3cb4-0f31-4bb9-baee-9e73916be108	7776977d-28c1-495d-a581-54a166caf5f4	3	6	12	93.49	108967898.00	108967898.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b4f40df6-ce4b-4622-8cac-729a20cad96d	1addd18b-6c36-402d-9fd9-f4c65306947e	3	7	12	115.01	98333550.00	98333550.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c26e7b99-685b-4aab-a47c-338b013f97c6	d477c03a-7aa5-4a8f-a0a3-06e5a9220eab	2	7	12	67.94	68267792.00	68267792.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
9e9bf9b0-c1c7-4128-8083-da399a13fbff	ebbf7561-569b-47cb-b4f1-1e310287615a	2	7	12	60.58	72294996.00	72294996.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
23982d49-ef4b-40de-bea7-c74df3d0eab8	eab94229-f2bc-4fb8-9cdc-3ee0f337fc5e	2	3	12	60.94	65571440.00	65571440.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
94c5c40b-4560-422b-913e-20b264928cf3	b8da632f-cb13-439a-bdcb-df0af1ec89c3	5	3	12	167.99	134056020.00	134056020.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
df5f9894-2a03-413a-bcda-a53d451b6c2d	0032bc2b-3a6c-45e4-b010-740aafe44469	5	4	12	167.17	157306970.00	157306970.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b3b50cb8-b318-4274-8f15-546119d1e48f	5ea79365-7c4d-450f-a48c-888a71d9602f	3	8	12	93.47	93057098.00	93057098.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5a8e061f-800d-43e0-8329-1bcfdaa2d982	166cabc4-b5f4-438c-a315-208665f8ce80	3	9	12	115.01	93733150.00	93733150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bb2673f9-7863-42f0-bc73-e93d68001f8c	d59cc200-3e1a-4f3b-846d-f9f6f330e58b	2	9	12	67.94	67583530.00	67583530.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
cff4d876-4125-4cfe-bdc9-cd0ef0cacfcc	e062a466-d99d-4b11-aca1-c5155ca19f2d	2	9	12	60.58	61996396.00	61996396.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
cfa212fe-5aec-46e5-af99-e163e76efdf2	3554a3d9-2492-47f1-b2d9-cd392c52a429	3	9	12	93.47	93057098.00	93057098.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bd612ebf-7b5b-4348-8bfe-a73efb9f456d	36189b99-7647-4b2d-b653-f1c4972af727	3	10	12	115.01	93733150.00	93733150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
90a29ee3-82b3-4cb8-884a-70ae4c1cd97a	73a3eb71-6eda-4f91-835e-bf48372b361f	2	10	12	67.94	67583530.00	67583530.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
567d8e83-8024-4ba5-94e3-856b81cc8e49	e4455a3b-c42d-4636-b566-4cfe576c0167	2	10	12	60.58	61996396.00	61996396.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2fd3d48b-abf0-4a52-9b77-3a30fcc54d76	7b15763e-e706-43d0-95ce-bbcfad143be3	3	10	12	93.47	93057098.00	93057098.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
82217601-f13b-4ba8-b71b-f8b241274a0f	bc45716e-8b29-42e3-834c-8502ba4234d9	3	11	12	115.01	93158100.00	93158100.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
17475c04-670f-41cf-bcfa-237fbf3e50bf	89c5b8c6-ce7a-4013-ab3b-726ef991924f	2	11	12	67.94	67243830.00	67243830.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
9063c7ff-c670-4ac7-9031-e8349dab70b0	2fdd0ad6-d58b-48cc-95e8-3a98432e377b	2	8	12	72.43	63955690.00	63955690.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
17821fc8-6f85-462c-9f71-ac0a1af241ba	afbcaedf-977d-43e7-b0d3-ccd769c1b299	3	11	12	93.47	92589748.00	92589748.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7041f2df-79d1-49c7-abbb-613031b8fd7e	3fdaa3f4-3ef9-41c3-825e-98fc1214b2a9	3	12	12	115.01	95458300.00	95458300.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
015c18c2-116b-4230-bbe5-716b0ec295b8	492b334a-3d19-4e64-9ded-d5bec707b384	2	12	12	67.94	68602630.00	68602630.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bf23a4e1-09d8-4713-bdc1-b7c21546ac3d	85692cb0-2b0f-41a3-8d82-6932209ad8c0	2	12	12	60.58	62905096.00	62905096.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
fe369509-a85c-4737-94f9-e62a6265a102	4d0fda16-3785-4425-b3ee-33c7d5dfcdbe	3	12	12	93.44	91624385.00	91624385.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
f4412da6-ec7a-41ee-b32f-0e0137be6d38	b40fe2b0-fa8b-4317-a668-8547494a0f3b	3	8	12	108.44	89246120.00	89246120.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d1019db1-7398-4d9a-9f28-7b3ab921d895	8a13d3d6-608d-47d2-8ce8-6519fb7ada86	3	9	12	104.8	86669600.00	86669600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
fb8a1a13-a95b-41a8-bd4b-a3b974320e85	87d17498-0af0-4082-be89-d96f6b451d7a	2	2	12	73.62	64196640.00	64196640.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
74b139f0-efad-4590-9fdc-0867b64e77bf	262bea2c-636d-4394-99bd-162fdb32d5b1	2	9	12	72.29	66073060.00	66073060.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
da5de5b6-0259-4244-9420-e0588d3dcc76	c395cd59-1048-4099-9e4d-34f2e43a6b4f	3	9	12	108.36	89180280.00	89180280.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2e857bd4-14e3-46ad-881c-b4693bf151b4	f1c326f6-8827-4f2d-9f75-f23a9f0e3e56	3	10	12	104.8	86669600.00	86669600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
98ee869e-765a-4426-b5d6-e10b56b8047b	88c3f64e-d8e4-4bd1-9e3d-ec0e08c235a4	2	10	12	72.29	66073060.00	66073060.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
61fecd8d-acb2-4bf3-b1ab-84244b4d49d6	e45a94ef-e47a-49dd-9544-4b63d8034084	3	10	12	108.36	89180280.00	89180280.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b1cf3c39-3cc9-48b0-b954-d585b61d2c78	98bb33df-7334-4d93-817a-b123736c5906	3	11	12	104.8	86145600.00	86145600.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
913de453-c97a-4620-993b-744c17712e27	6e35bc55-5c63-4188-a3c9-59ea379b06f6	2	11	12	72.29	65711610.00	65711610.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e089d6e7-a95d-46e7-a03c-eda548f74cb7	3c22949e-c088-4cf1-948e-f5ea868e9ca0	3	2	12	109.14	88621680.00	88621680.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2874d7d1-9412-4bde-9158-617b3c9d79ef	1edd7a57-932c-43e8-8379-7f91c9f5b0d5	3	11	12	108.36	88638480.00	88638480.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
21fd19f1-9614-4fd8-9243-8e0b92cf729f	f75bec48-c7af-45b5-ac65-fba28c0aae10	2	12	12	71.83	64575170.00	64575170.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
e671021e-91c0-40fe-8c53-ded85568003d	424d2834-5442-4f84-a84d-a5edd5c6db48	2	12	12	72.22	64925780.00	64925780.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1e26ddfd-e962-4d08-b044-340c84f9e94e	ff99747d-ae6e-4b78-b4e1-fc780f7e9207	3	12	12	108.23	90696740.00	90696740.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c56fa9bf-b8a6-49b1-9ff7-62997da293fd	e6697da9-6929-49cc-90b8-75f8be2d77d1	2	2	14	80.23	70121020.00	70121020.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1aca28a3-1319-4601-91f1-9d39d71522b3	11866afb-1f50-4bc3-86e7-d23addb134e7	3	2	14	108.96	101005920.00	101005920.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
a14dc684-9529-45ac-94a1-8e11cb206c18	ba09c87a-e318-4f56-bdc9-bc486aa629f8	3	2	14	110.78	91725840.00	91725840.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
8082a367-5291-438c-8d2b-6d3a1719a653	88945031-1666-4b1b-b05d-8d388a44685d	3	3	14	116.57	100599910.00	100599910.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5471dfab-c752-483a-92e3-ef56b575336f	cc3d2496-68ef-428b-b91e-744606ca8e0e	3	3	14	108.47	122788040.00	122788040.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bf32ecf4-75d6-4ba4-b70e-1fd0499663f7	84b1a000-35ac-4dfd-ab84-93d234709070	3	3	12	104.95	104110400.00	104110400.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6795fef7-0ed3-4749-9374-7c87b5c0febe	bea4485b-03cc-4414-a527-d1192ca50093	3	3	14	110.26	96918540.00	96918540.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
ab475271-ad0f-47f3-bcc7-37531976d774	9e80a9d4-92a0-44ac-a896-1fbd45b427b6	3	4	14	116.57	118668260.00	118668260.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
4d9896ee-db6f-4324-b22a-85b0f035bd79	ab2c4685-ce3d-4e9f-b38c-b3dd29fc1bef	3	4	14	108.47	105975190.00	105975190.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
416e5c22-ed96-4edf-9f21-15ee377852ea	dd126fe5-0748-42e3-a14e-794dd25e0b4f	3	4	14	110.26	114008840.00	114008840.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
992c7cbd-cec5-4e74-bf04-6252afcd840b	6d39a7f2-3286-46ab-9ccc-b408cbbee332	3	5	14	116.57	100599910.00	100599910.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
372451b5-577f-492f-8670-abeafc9de516	b72c3c14-1e1c-4bf4-a532-79cd2231579b	3	5	14	108.47	122788040.00	122788040.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
adbaa068-b7fd-4723-8b39-f4a66b9ba307	f2cdbf39-c88a-462b-83d5-0edcf7be412b	3	5	14	110.25	96909750.00	96909750.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
35e1ff45-ac17-4bed-87a7-aedc50b06b2a	b13b722c-81a6-4fa2-87aa-2befc2507592	3	6	14	116.57	118668260.00	118668260.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
83d69545-ccc0-4e03-b34c-27967b3a45f9	5a789874-d51f-4fc2-a864-63c46ae1be6a	3	6	14	108.43	105936110.00	105936110.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
3c8249c3-13f7-4cb6-b205-e799d13ee924	5b6e84bb-d2bf-4930-9591-0752276d032b	3	8	12	115.01	93733150.00	93733150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c2b53aa3-2a33-43d7-82c1-43a92fbb4b62	f31f8105-1db0-4abc-a8bb-4294c8e31c1a	2	8	12	67.94	67583530.00	67583530.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d8a7e6e4-2ec8-48e9-8aab-c4096bbe8007	ef62a2e3-c2ce-4528-ba1a-dc9e4cfe8390	2	8	12	60.58	61996396.00	61996396.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7ff9079f-20fb-44a6-a808-39f4955d08d7	ca9cf0ea-aec1-4ebe-af69-3313a125fe0f	3	7	14	110.12	96795480.00	96795480.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
bb2aee46-bf9c-4789-ada1-88c68eb00634	1b9b5f52-425b-474f-9d07-e827ba7e3e19	3	8	14	116.26	95681980.00	95681980.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
fb6e620d-067d-48a3-8b1a-5a8d19339727	be883a0b-49f1-4f67-b318-e698d7a9d731	3	8	14	108.29	104824720.00	104824720.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5f01e0af-2620-454e-b3ca-0c7f95dc557e	82a30e35-0f09-4cc0-8cc2-efd41e9b5a5c	3	8	14	109.96	95555240.00	95555240.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
13a37808-d9d8-4eaf-a9cc-c299bcf33e30	b13f19d5-678e-4dc5-975e-d2cef918a84f	3	9	14	116.26	95681980.00	95681980.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d8cbac49-7770-4e2a-a95c-612041309c74	47a84396-45af-4648-b3f5-2c6d2d728d6e	3	9	14	108.29	104824720.00	104824720.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
922e517c-9826-4792-91fb-6370566ba197	2fc1ecd3-1cab-4b9a-b094-6a2d809d219f	3	9	14	109.96	95555240.00	95555240.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
93b66836-3b5a-4dc5-9600-eef4dbc10252	6325b6f5-1af5-4552-b9c8-ea0e99c0c60c	3	10	14	116.16	95599680.00	95599680.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
8adb784e-8466-47b0-bf62-a0c7ff0443e1	df1145c1-bc56-4afe-a860-0b8876874fa2	2	3	12	72.62	64849660.00	64849660.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
68aa3ce7-ac74-455c-a657-f7a8e0889786	b7f6499f-f762-417c-bd7c-14ec7bb97133	3	10	14	108.21	104747280.00	104747280.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5cc83b27-aa71-4ad4-a869-4ba7e01610a5	b2cdd14c-dc63-4c27-9d97-edba3d4825bd	3	10	14	109.88	95485720.00	95485720.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
43d8ab47-7714-4492-b05a-64805d87a4c3	2199caa8-bc17-491d-9f48-6a0b6e76b48b	3	11	14	108.21	104206230.00	104206230.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
9869bb6a-c172-4783-ac24-6d2cedbbecb1	1cf621ec-eed0-45ba-ac2b-a4b187c63150	3	11	14	109.88	94936320.00	94936320.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
3166c15f-6dff-4bbb-bce4-0816e7fe3b9a	875d3ee3-8cd7-4458-b0c9-1864e7afaf98	3	12	14	115.97	94979430.00	94979430.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
9ebe18c7-4523-47b7-9362-0230928665dc	e8c52081-582c-44d0-a52a-ab1434f55034	3	12	14	108.19	104186970.00	104186970.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
99135305-7dfb-407e-8b2e-6314fba5d316	0df38f2d-cae7-4fac-9072-dbe496921127	3	13	14	116.43	95239740.00	95239740.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
787fb1a7-691c-4b3d-bba7-00cd70f6eace	1328872c-98ab-4644-9577-4f363df3aca3	3	13	14	108.19	104186970.00	104186970.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
feaa2aa0-1f77-45a5-94ec-2fbe7799f846	37af8830-672e-450c-be8c-b3b8786242d1	3	3	12	108.61	90472130.00	90472130.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
1a154c00-3b12-45f1-bc7c-4c29f54c4d82	c7d678ff-222d-4674-875d-4e61768e8f77	3	13	14	110.25	91948500.00	91948500.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
c429f26f-d096-4538-a4f2-facd27956b3d	4a0a780f-f3c2-4f98-aaa7-941f00caa495	3	14	14	116.59	97702420.00	97702420.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
8f43041f-9677-4c8f-b852-85a8038a1810	769beb68-1edc-4dff-bdff-a3651147da7d	3	14	14	108.11	95461130.00	95461130.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
2096bcf3-0ade-449f-bc20-191db77270dc	86bf3fe6-d0a1-4a39-af3d-28d606a3ab96	3	14	14	110.65	94384450.00	94384450.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
24114a08-8de6-42aa-abd5-7226a59541f2	02f65a31-78bf-4f6f-bf53-0a9b95a7e6dc	2	2	12	74.96	74399351.00	74399351.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
482d0b11-2134-45de-ad10-43b2af372d59	9d13a399-b15a-4e9d-97f9-88663e3434c4	2	2	12	71.55	69972080.00	69972080.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d4bee3bf-e165-4aa1-ad97-725a4e518a8d	8a6ae350-a776-424f-894c-c78ddc022b8a	1	2	12	46.75	49065005.00	49065005.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
05db0d91-66cf-4d9f-9882-d53dc3e6f8e8	8e9e2069-c28f-4879-b8c6-6830ff70dfb8	4	2	12	143.13	117795990.00	117795990.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
b7760e6a-5135-45a1-87d0-306191f5b845	8989eada-425d-46e4-88ca-4017b1d86dbf	3	3	12	110.27	91634370.00	91634370.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
85fe0cc5-9112-47d3-9d20-2108d82b5c94	e1f5adf9-5e09-4e04-9394-cb09285c7b21	2	3	12	70.59	81838241.00	81838241.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5f7af873-7703-49d5-a8c2-f8ffb79955b5	4adfd886-2639-4cc5-bfbf-6761df7a1303	3	4	12	104.95	87843150.00	87843150.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
68ee5789-8e10-4ebc-97cc-e2d1ff4f4351	1b7f5631-b287-4e2d-a9b2-9a44838f94de	1	3	12	46.39	51067701.00	51067701.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
94f2ca63-b960-47dd-bb9e-70bb39bf9014	e400425a-cf70-4b97-a978-9d919f577287	4	3	12	142.69	120430360.00	120430360.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
485f0dd6-b897-489a-aa38-fa717466686e	fb394acf-50d5-43a4-8aa1-88e0faaeae24	3	4	12	110.27	108726220.00	108726220.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d888549c-cb8e-453b-9764-18f9b84a06a5	4bfa3a41-c6fa-43b5-b31e-54bca39316ff	2	4	12	70.59	70542221.00	70542221.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
d073229b-f9f3-4e09-95fd-8c3cf795bffe	d9b8c99f-6b5a-4ab3-b033-e3249023d357	1	4	12	46.31	56585349.00	56585349.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
8489b239-e6b7-4d09-8009-fab91d9081e6	842f32b0-9571-40e6-bb20-f57ab3a42f3d	4	4	12	142.69	120430360.00	120430360.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
0d4602b3-4255-4719-9b6e-b08997db51e8	bd2fadb8-be44-4ebe-b1c7-d3df12eceeaf	3	5	12	110.27	91634370.00	91634370.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
6203c386-7b1b-4a54-9fec-bb10c0dd322b	7f6c38b2-43c2-4b18-be68-b6fd0ca9b309	2	5	12	70.59	81838241.00	81838241.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
5d00f253-15d7-4c19-9ee1-ab8a0604887d	674998a5-cb13-49c0-882b-d3d775cbba26	1	5	12	46.31	50981839.00	50981839.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
4010fa5b-385b-4f49-8a58-bd29b653a8fa	58e2666e-9b77-44fc-8572-32eafe3470ce	4	5	12	142.69	137267780.00	137267780.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
36465d95-80ac-4ca7-8383-25f844ff9b1e	147ca7a5-6cb4-470d-8d30-c3fafb43c6a9	3	9	14	111.61	90515710.00	90515710.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
758a81fe-73b8-4236-a7b7-c4b20feeb511	c2957d38-b08a-4668-825a-74931174a371	3	4	14	111.17	91381740.00	91381740.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f6a4d9ee-f30f-470b-a15f-80332b73e758	bf2477d9-39c8-49e0-b60b-835d5fa3c8a4	1	14	14	44.67	38416200.00	38416200.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
9bdd4bd7-9d07-4cb7-b309-8a865f6892cb	ef0c978f-0b21-4808-8a59-925e01092267	2	2	16	103.81	82321330.00	82321330.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5e744cc6-b63c-4949-9849-4ddc95a196a5	67fb8449-4b5e-49fd-92f7-ad92a6315612	4	2	16	135	114750000.00	114750000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
15ccf515-56c4-410d-bd55-c395e8a9acd5	263413c6-1e16-4d46-adf6-7a6f8515c2ea	2	2	16	95.86	79851380.00	79851380.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c28e8aef-a09d-4c33-aa6d-c0f1650adbc9	c06f7662-ec86-4729-a7d0-d522b424e603	3	3	16	118.03	93597790.00	93597790.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e1729c6e-e076-4dcd-9cc9-1e78cea6343e	84b2e1f1-88eb-4b13-916c-9e9d1e083061	3	3	16	112.82	100748260.00	100748260.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cb463476-d44b-449e-be32-002e53e245b4	cdcbb331-d5f3-4318-840d-6d4b9d81c37d	2	3	12	72.23	66740520.00	66740520.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7c2ba784-14d7-46df-8795-b5c1d61929fe	3a1a4d19-4ff9-4dc0-96f6-99a397cbe047	3	7	14	116.51	100548130.00	100548130.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
7385b028-3aa9-431b-be1e-fb89c52d6cc0	1c64d7c3-7708-4852-8b79-3642747d4321	3	7	14	108.41	105916570.00	105916570.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
a4f8a098-5bc1-4b95-95bd-3e4f5611cc14	d8cbd1e8-e15a-4d03-a53e-1f199a0f9f5c	3	6	16	118.03	93597790.00	93597790.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a8d88e67-3b40-4bbf-a1af-be43b4e13734	19642d9c-0230-4cb2-b400-3f8e9d66e2e0	4	6	16	137.76	128667840.00	128667840.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f0e7cbfe-3eae-4d17-9ece-86d32411a094	1ac4c384-57ef-40e1-8fc1-161b7dcdf545	3	6	16	112.82	94655980.00	94655980.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f2e79612-10dc-4b4d-b386-d670df44b329	01c4ed48-ad65-4e1b-a280-69c1e133dfda	3	7	16	118.03	93597790.00	93597790.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
816ed614-469b-4611-9240-b32fc2adc589	e6500685-846c-46b8-a1eb-98cf7447d8f7	3	7	16	112.82	100748260.00	100748260.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a447d0d0-54d6-497c-84e0-8dded94974fb	85b004d2-c333-4fdf-a68b-1bfd20dc76ab	3	8	16	118.03	92417490.00	92417490.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3b039ee8-add0-4144-9d73-f3ee3dc59d76	4d15c219-66e2-4613-82c8-ab070a55cc5a	4	8	16	137.76	127979040.00	127979040.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3d052c55-e2d8-47c1-b4ab-d18428779eec	8b53f10e-82dc-4973-89fc-64627d255af4	3	8	16	112.82	94317520.00	94317520.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3d8939ca-5fba-4364-ad9d-69498b544a06	6f4668eb-e7dc-46d8-b45c-4247cc4eedcd	3	9	16	118.03	92417490.00	92417490.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
39100772-5bdc-4ac7-b2f3-725b39ba022f	8835c298-cc72-4333-9eb6-da71a5e6ef71	3	9	16	112.82	93527780.00	93527780.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cb4d2adc-30f4-4baf-889b-e6ede0f66d79	2f861289-711d-4cb3-8993-480bb2d85e33	3	10	16	118.03	92417490.00	92417490.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
bcc5ab64-5457-43d2-b961-74a3de7eddcb	b8a5d6b6-5ff1-4025-82d0-fc332eea9d0c	3	10	16	112.82	93527780.00	93527780.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
814b00a2-86b8-41aa-b68e-89488ecfd6c0	82daa01f-e9ad-409c-8eaf-26c05574b32c	3	11	16	118.03	92417490.00	92417490.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
91413a27-307c-40dd-b949-56f9ada436aa	e2b2b160-bb45-467d-a2aa-eb4a6ce8fa8e	3	5	14	111.17	97384920.00	97384920.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2c148da2-01be-4299-9212-a296aac47948	83fc7c87-2910-4b2e-905c-fef7f4bc769a	3	11	16	112.82	93527780.00	93527780.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d36c2c27-0acb-45b3-85d8-c3f50d63d2dc	82168aa9-5003-41d8-90e4-0a551f342db0	3	12	16	112.82	92399580.00	92399580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
4cba0a73-ce88-497b-bd7f-948719cc6d49	6ea4cae9-1acc-48c3-b73c-17f33e5b02b0	3	13	16	118.03	90647040.00	90647040.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
00ddbd3d-2199-4777-bceb-77adaf11e826	2f09f942-046a-444a-9a7f-41a203958bd9	3	13	16	112.82	92399580.00	92399580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
61a3053a-a81f-4add-8a10-4fa53370d2cd	af4cc17f-b61a-4af1-8888-079e56bb6242	3	14	16	118.03	90647040.00	90647040.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2f759b27-1973-4f8c-9b5a-dfc258e5cd29	00aa5f9c-b2b1-4f6e-b5a9-f388486fb629	3	14	16	112.82	92399580.00	92399580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
77c22a3d-a9be-4d3f-bafe-6f0111f70560	ae66111b-3027-48c1-8c7f-5244e17d3b7a	4	15	16	137.76	127290240.00	127290240.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
97626060-9239-4315-a4f0-89872aa648b1	f1f32391-25cf-4999-858c-f2bd0a9ea08e	3	15	16	112.82	92399580.00	92399580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2620895b-9df6-4f9b-aaf4-9a21c7f46439	4445c2ee-715d-40bd-a51e-d1be3e8bb519	3	16	16	118.03	90056890.00	90056890.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
8b9c2812-7f0d-47ec-8db6-cb3971d3b0d4	ba01edf6-00c3-4248-9b6e-e795a9c3183f	3	16	16	112.82	92399580.00	92399580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
6cc674f8-7ff1-4961-96d0-47a04a0c72e8	8faaa9d3-d34f-4e12-a0a1-aa76731cef9e	2	2	14	89.04	73992240.00	73992240.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
133bb8f4-1878-4825-8a1a-6d7ca2e6424b	58e14ddb-1c43-413e-9ced-ca07ad8b26bf	3	2	14	117.07	89441480.00	89441480.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f05124f8-f81b-4e1f-9d8d-22bc5336a4d4	148bea04-1d87-46a5-a56d-5cb8d245bb09	2	5	14	57.78	51597540.00	51597540.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7c330be8-6871-4787-bade-463ccb2f2cc8	09ccd9ac-3de5-4962-b52e-dca39cfb4b6b	3	3	14	116.37	94841550.00	94841550.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b7ed3886-ab2c-463e-8355-98823b09257c	7967479b-550b-443c-8ce8-e98ea3033a13	3	3	14	116.32	101082080.00	101082080.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
4b2c18e3-dad1-4ad4-9b1e-b49591ef0d5f	273f1e77-8821-488d-8626-73c1ad090fad	3	4	14	116.37	101125530.00	101125530.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
50d9f422-7a5c-4ca8-a89f-170e6888f67f	d88bf050-6439-4d72-b2f8-f6b93bc5ac7a	3	4	14	116.32	94800800.00	94800800.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
72a02206-2c1e-487c-963a-c263a788ccc4	ba4d4c7c-62cd-4a74-9e25-06f7af22a3af	3	5	14	116.37	94841550.00	94841550.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cdfac244-153a-4b2a-a524-57b690d4d608	4f7ffd25-bd41-4584-b438-046ed8797aaf	3	5	14	116.32	101082080.00	101082080.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e69d9e0a-14c1-45bf-a45d-81ba6099723c	062b071e-3000-4abb-936b-f804013155fa	3	6	14	116.37	101125530.00	101125530.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
65ef31b4-2671-4a4e-9641-2cd067267856	4ed2a5ad-a6f4-4440-97a1-a4e8b9be5c6d	3	6	14	116.32	94800800.00	94800800.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1cfa5867-2fa3-4fd5-8621-2b2d83b064b7	6b1008b3-b60c-4b49-8730-faee76af9fba	3	7	14	116.37	94841550.00	94841550.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c05d0d10-5040-418d-865b-945989792cb8	b2cddc91-9d44-4d04-9f2a-c6e1ac1be6af	3	7	14	116.32	94800800.00	94800800.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ebaea345-bbdb-4007-bfeb-62e0330f7db6	5dbe80eb-d43c-4483-bc3b-d8152dd337f6	3	5	14	111.57	97623750.00	97623750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3a954728-f169-436e-9167-6f6981c6cff9	c76c3ed4-dc7e-4b9b-b5d6-2de0f0c5fa22	3	8	14	116.37	99961830.00	99961830.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e6a13abc-70c1-4e68-8056-a14beb4249e4	798eb44a-c481-45ee-8881-00fec2e9de2f	3	8	14	116.32	93637600.00	93637600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b1c43dbd-4f00-4918-812d-486af14218f1	b4ae9b45-8d15-4518-bb2d-f7dad040e7b4	3	9	14	116.37	93677850.00	93677850.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
bb1ebe58-942e-4474-ab25-a973f18b3bd5	88b484f1-57bf-4880-8457-c68457a4532d	3	9	14	116.32	93637600.00	93637600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1fbb061a-09fb-4c18-93ab-a59b2e16bdcf	170edeee-944c-4466-b997-dde9c2754ff4	3	10	14	116.37	93677850.00	93677850.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
8760f926-b153-412e-a5b7-f33bc743cbd7	484f46b0-d894-4cf0-a6be-25841976887b	3	6	14	111.17	91381740.00	91381740.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
854803ac-e0a8-4852-8be1-2e78b785874e	f27fa4d9-b7be-4469-9bee-e39d431b3d69	3	10	14	116.32	93637600.00	93637600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
fc08c71c-935c-4430-b0f1-5482a34eb9e8	71f56bfa-381c-49df-8cd7-b3d8ebf25e90	3	11	14	116.37	93677850.00	93677850.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
6ddd07a0-725b-4e6e-be19-af4ca277e0a7	5d10beeb-7f17-4800-820e-f010af078cb2	3	12	14	116.37	92514150.00	92514150.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
506e6da6-b512-49ea-8b2e-fc041327a7c8	b9750090-3430-4b0f-8d6c-c9f3bef895a9	4	4	16	137.76	128667840.00	128667840.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
95844f9e-dc3b-4221-88e9-682f4a7b97ab	868eee07-3106-4742-bcd3-d0c16a701bbf	3	5	16	118.03	93597790.00	93597790.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
dc63f259-2e97-4617-a60f-742ad21139af	fbf97fee-abfe-41c2-8228-7683418ca94a	3	5	16	112.82	100748260.00	100748260.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e7b180ee-bcda-4a60-b098-bc6df0c93639	7e2adf28-4a30-4341-85df-f44a8d2bbee6	1	6	14	44.64	40979520.00	40979520.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a71b55fa-19fe-456e-b05d-d6bcd2a4c4a2	433d74f2-293b-40b3-9c25-874919d8fb46	3	6	14	111.57	91598970.00	91598970.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
660c9e8b-2bab-42ea-a041-37bb7a887485	4a7c3370-83c2-45e0-8945-1b473f2fd529	3	7	14	111.17	97384920.00	97384920.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
51c7fe86-9064-47a1-9672-7b236f56ed51	d775db0b-598d-424e-aaf4-ffec6933bff0	2	7	14	57.78	51597540.00	51597540.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
342c90bf-c244-4411-a9e5-fdaa62bf0b7c	5ed2dae9-57d5-4feb-be85-3b7950668329	3	7	14	111.57	97623750.00	97623750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
318dca9b-5807-4404-83bb-fcd92396a1a4	53432324-6ef3-4319-9e22-860875ae5a04	3	8	14	111.17	90270040.00	90270040.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3666d11f-2695-4d57-8f4a-d16b4a7ae5c6	a59d6daa-c1dd-459f-8aac-f2616885dcb5	3	3	14	111.17	91381740.00	91381740.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d572b4ba-638c-4e56-860e-c91efc1f67ef	05433a6c-cd81-4ad3-873c-1eac130faeee	1	14	14	44.68	39407760.00	39407760.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
25f16b61-5d4f-445b-b365-f4112439addc	0af478fe-f74c-4c91-9b36-b17d146e7ac5	1	14	14	44.64	39372480.00	39372480.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d093eca1-415b-4c8d-8b5f-7fa9b528a0c8	c6e9a1ce-6983-4bc3-97fe-fc9d1dab034f	3	2	14	112.33	86494100.00	86494100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5c73a966-1a6b-4da4-9a74-489c7944b4e3	d118f4b0-2772-41a0-8fab-d475138fa462	1	3	14	44.67	41007060.00	41007060.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
39bb3ef6-8f56-41c8-b307-b5fd16f88d9e	407a64ae-82bd-486f-9ae3-3d3180474fba	3	4	14	111.16	97376160.00	97376160.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
305622ea-cf68-4a95-bf6e-66f1e3f21252	96561405-40b6-43a7-ba5a-fce28a3c5c9f	2	4	14	57.76	51579680.00	51579680.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
6a357911-b837-422e-add6-01d5bc59f050	a4030e74-58f6-4c74-9afa-e95451cc7859	2	3	14	57.78	51597540.00	51597540.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
887e5d8c-5c58-4f89-a948-73bc549002a0	6113a789-097b-4f51-ab9d-b47f7daba194	3	4	14	111.61	97658750.00	97658750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7924b94d-8b8e-40cf-84b2-afb6af8a75a2	e74b3683-477f-4851-861e-2ce23c63ec74	1	5	14	44.63	40970340.00	40970340.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
9d6f70cb-c675-471c-9ab8-819e6458fa21	a285e1d2-b957-430b-854c-de592426d5aa	3	6	14	111.16	97376160.00	97376160.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d352cdcc-fa20-4654-8107-3eaf13874f1f	f00e4363-61dd-404a-9e9d-0b48e63913e0	2	6	14	57.76	51579680.00	51579680.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
14015342-cf83-4a7a-ae61-9b04c016cf99	03ca25a2-6173-4514-9127-6741bd973b6c	3	6	14	111.61	97658750.00	97658750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
328c9dc3-84cf-4c66-9d52-f8c6c4fb7a10	0bb1f5d9-3612-497b-863e-934c83f98577	3	7	14	111.61	91631810.00	91631810.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a1945083-edfd-43a9-afc9-3769958d55dc	77dc1e97-55ff-4998-b699-4d77bb6f0f7e	4	2	9	147.76	127221360.00	127221360.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
07f3356d-21eb-41c4-9ba2-c1a7a521ae23	e1f7cd52-ef64-4a01-8165-0b12b451f537	2	2	9	52.4	55072400.00	55072400.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1e75661c-75f2-47d5-9c0b-986499b0f627	d9272df4-b234-42cc-9863-3ad0ad23a05e	2	2	9	84.39	80339280.00	80339280.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b70c543d-05c8-47ae-bdd5-307c1173af2e	72ba2c44-f574-443c-9391-1a2f77545aae	4	5	9	146.67	136403100.00	136403100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
341b43eb-76fe-403e-802a-9a79cd858a51	f384e30a-195d-4546-9a12-3bcacccfac9f	4	2	9	143.94	134008140.00	134008140.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a41b4c99-325e-4dd0-95a0-6bbae36b6dcc	7d9d4fac-8397-416b-b97a-1ffbdf3c2490	2	2	9	52.9	55545000.00	55545000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7cbe7366-491f-48b1-ae58-17a22d38dbbb	c445f05b-8e8e-4b6a-865d-240a6c006f8a	4	2	9	149.11	138523190.00	138523190.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f9a1967a-b7b7-42a5-b2cc-61e1d8d3a460	9e6db784-44c5-4f75-8bc3-21f8213e66cf	4	3	9	148.37	141099870.00	141099870.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
baa9c000-a308-415e-a16a-df67840169fa	e707bbcf-64bf-4cc1-8b88-f9788c35f5bd	4	2	9	144.25	134873750.00	134873750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cc346752-2a37-4f09-9524-af407e367b71	b1f8c315-abe4-4ac9-a8d4-95399326e2de	4	2	9	156.54	143234100.00	143234100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c505919e-83ef-4730-a59c-fbd874112ebe	3b094d59-7a7a-4d76-b2f4-286cb7ac04b7	4	3	9	148.39	141118890.00	141118890.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2af80cd3-fb88-4785-b582-be52599d5067	f013c2f9-b35e-421a-8603-1ab6327d6c0f	4	3	9	155.86	149002160.00	149002160.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
15941761-a5cf-468c-9e48-6cfd159805a5	85c3ff94-10c1-4eb2-95d5-b900b4cda14e	4	4	9	155.86	146820120.00	146820120.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3e39b608-77a0-4445-8093-f91b335a07c5	3207df1c-3ccd-4d1a-8276-68f96a5ff17a	2	2	9	93.05	85792100.00	85792100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
197c938e-b14a-4126-b891-5922b7be93a4	5d971d08-43a5-4270-9c8f-94d33a766792	3	2	9	81.5	72453500.00	72453500.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
43a4470a-f814-4f32-88a3-a16662860da4	599b723e-03a2-4219-836a-0f3ea1b5e302	4	5	9	149.83	133348700.00	133348700.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
534dda1c-e583-4696-963a-b103caba19f1	149ffed4-a923-461f-9c8c-96daa12c63a4	3	2	14	115.68	91734240.00	91734240.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7955ecde-fb48-4cbe-b86f-6421f29776da	c3707aae-cde2-4314-b6b3-2c94cc5b5d2a	3	2	14	111.76	89072720.00	89072720.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e2ced348-878b-47c4-a428-b6dc2948c8f6	593eb275-0e8a-4d1a-a4cc-ba0686c31ea3	3	3	14	115.8	94608600.00	94608600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5232295a-334c-414e-8cfb-f213068fbe18	f344bddc-b620-4017-ad67-c7bf14f65af6	2	3	14	75.45	66320550.00	66320550.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
df21f8d4-2d4e-40c5-9c41-18eb5f40e272	ec8f9bdd-afb5-4373-bd90-c196bdb1df8b	3	3	14	114.24	93562560.00	93562560.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
fa2122a1-e7bc-466a-ae2a-c29eddd29625	c9e47268-82c8-42f0-a117-dcb037c42a2f	3	4	14	115.8	96114000.00	96114000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d3ff4a3e-3aa8-4083-8dc6-7d2856c49f79	cacba207-2a28-44d0-b8fb-8f93c5d0f33b	2	5	14	75.45	66320550.00	66320550.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
573975be-ad38-4c60-9185-c4abdfff3a33	5c1cee33-61d3-4203-a901-74ee24862dd3	3	6	14	114.24	95047680.00	95047680.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7b0e9a68-27dd-4bbd-a776-021e221d5f4a	840ebf3c-d3ab-41e1-b85a-bc7c1af50549	3	7	14	115.8	96114000.00	96114000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5e410566-3eb6-4f0a-b602-78a9a55bb15d	3ff84ff2-59c9-448d-9144-dfa2ffbe3a28	3	9	14	114.24	93905280.00	93905280.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c546c742-6642-4368-be15-e182b42ec607	92af3040-fca9-44d3-8dea-7c57ffb134cb	3	11	14	115.8	92292600.00	92292600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d28c345f-8a3f-4d80-a29e-95ed52dd2bb6	59021a52-f451-42b7-aa5f-df4574412168	3	13	14	116.37	91932300.00	91932300.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ac7fa004-3717-4e60-aeed-ecafe6064299	7a3a52ea-c158-432e-90a1-c93a199a6637	3	14	14	116.37	91932300.00	91932300.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
6c4c811f-bd88-4f12-9a88-15a98227f629	7d41d273-a350-4ea2-9790-9681c433a1a7	3	14	14	116.32	95382400.00	95382400.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cebe9171-3a28-49ec-9adf-e51427ae7cc1	84904eef-7799-48c4-92ec-2961ea8ddb1e	2	2	14	52.91	48465560.00	48465560.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
09e6ca48-c371-4db6-a2e8-e4645cdcf14c	fd860d64-c913-4b93-8060-37da42807d45	3	2	14	115.11	88980030.00	88980030.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
36f271d7-94ec-43a1-9353-2edf22d37851	da291003-727c-4a5d-a654-434db1c8f245	3	3	14	114.93	91714140.00	91714140.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
bf34b0d4-681e-4bd3-993c-c9cc9210dd6f	366ce37f-eb20-4c92-bed0-b4c8ffec4918	2	3	14	51.5	47483000.00	47483000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
dcd3b389-9151-4bf5-98ae-b412f6470910	27bcc0a4-9e34-4fcc-b987-1b025eec3241	2	3	14	52.53	49693380.00	49693380.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7e6bdd5c-6e9f-40af-8356-de0c34dd15dd	60cee2a4-d4e6-4576-a08f-511e63d250d5	2	3	14	52.23	49409580.00	49409580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5228442a-3103-4984-8e23-827fef8521b0	1f39ae9c-57d7-4ed4-bd4b-9fa55f663e20	3	3	14	113.94	91152000.00	91152000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3ce6695a-10c7-4987-b574-f54dab4ed2f8	966bd71f-f60c-4bc8-83b7-b0a2ede49ae2	3	4	14	114.93	91714140.00	91714140.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cca8924f-b4b6-4244-a29c-77838012b328	c0e414e9-a5d4-4a21-b829-7f30810f6dbe	2	4	14	52.53	48064950.00	48064950.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
30191e69-3574-4499-9908-6258fd76706d	b6dc8cbc-381b-4240-9875-bb1b6da05fb7	2	4	14	52.23	49409580.00	49409580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
690f0dc5-2818-48c4-94ad-a166909b18d6	d9e80f3a-897f-4049-8ec9-b9c82b0759d5	3	5	14	114.93	93208230.00	93208230.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
223c68b3-dd06-48e0-b09e-fd88e61160cd	1d483e0d-109d-4884-9b4f-7c2714bb7d60	2	5	14	52.53	49693380.00	49693380.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
afa7b578-e9fa-43cf-a810-c5e19fb5324b	2e197e53-fc9f-473e-8ff1-8cecd2aec1a5	2	5	14	52.23	48573900.00	48573900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a2695a81-7165-4780-9fc7-237a95be2710	e041e289-411f-4003-b62b-4ae456b21459	2	6	14	51.5	47380000.00	47380000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
cf61b0d2-7a4f-4065-958b-743ad0814d9a	a974f041-f7d8-4a88-ae1f-69cc9c73802a	2	6	14	52.53	49693380.00	49693380.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
57a988cc-f760-4406-8e33-10fbf237c958	337b7498-c295-4724-ad1c-f337e9161741	2	6	14	52.23	49409580.00	49409580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7f9cd4e9-33aa-4a86-a0e9-f5ce630c8bc2	05c0065e-370a-4a9c-8876-ff88a3416e22	3	6	14	113.94	92633220.00	92633220.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
80b6f14c-db05-4e38-841d-0b6eff621698	b08b3116-c37a-44d3-988f-52587daa2ea6	3	7	14	114.93	91714140.00	91714140.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b3c04ea7-2f58-4436-88c1-743974cf8886	24a11d1e-0017-45a6-8e13-4c35e1cb9069	2	7	14	52.53	47959890.00	47959890.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ac1407d6-fc8d-4993-a822-842a60264e67	15816022-4c7c-4447-aef9-c752bc0f2d77	2	7	14	52.23	49409580.00	49409580.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
23a4fdab-1ab9-46ef-8e3d-95939fde0e43	8e1b4191-3a1f-4c65-ad06-cdd261875fd5	3	7	14	113.94	91152000.00	91152000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
7aef7b96-2c53-48e3-928c-1d50358fa130	b0acae5a-4111-4d55-9258-1315323bcda5	3	8	14	114.93	92058930.00	92058930.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
edfa612b-894a-4371-bbea-fa7f31d52937	acad6a83-c995-4867-a442-3b5819e29ed7	2	8	14	52.23	48312750.00	48312750.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ad731463-82f1-4875-bd85-7f2e5a9cc5f3	d193558b-a144-4131-b2c7-67e634ea196b	2	9	14	52.53	49168080.00	49168080.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2e75902e-e74c-42f8-b3e0-2916895d41be	c85e1f8b-dc3b-49b5-bd8c-fa5eb5c36b59	3	9	14	113.94	91493820.00	91493820.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
849ad19c-fb6e-45f1-b33c-78ea52e6761d	048e966c-8053-4f62-ae0f-29c0037617e1	2	10	14	52.23	48887280.00	48887280.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
13886864-9415-4817-82de-5d32c82b419d	4ac4be06-fdcb-439a-8d08-05a80aaaf54e	2	13	14	52.53	48642780.00	48642780.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e4b15a51-3e3f-4d5d-aff4-ab69b8b546f6	893360f4-b729-4d81-b175-f546eb8a65a3	2	13	14	52.23	48364980.00	48364980.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
32925e44-4f7b-438f-866a-5aadf8dabf56	c50d492b-5c03-42fa-bcaa-b57b3429a4d8	3	14	14	114.93	89415540.00	89415540.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
60c5d370-0a61-4575-988b-fb27e3302521	04c59023-1df5-4d49-9a47-21c54bb0679f	2	14	14	51.5	47740500.00	47740500.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2043fe52-1c8c-4630-b3cf-bc80d5bf40de	96b5518c-598b-408c-8a56-af191d7e0009	2	14	14	52.53	48642780.00	48642780.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
fe4b5d51-4198-4087-9bfe-24057dad10b8	64e0fb88-b2c7-4e8b-b226-e4544d365f95	2	14	14	52.23	48364980.00	48364980.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
273039df-1b01-4476-92e8-1d4f18906a8d	416618a8-a8ce-4c93-b405-8503766117a9	3	14	14	113.94	88873200.00	88873200.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ad0585a8-5dba-4faf-bcd8-44348759b2ac	b32560d8-668e-4fe9-aa53-49aa89b08fd2	2	2	16	85.12	67755520.00	67755520.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c3fd957c-03ab-41a8-9e64-9f5fab8d4ed0	adafe88c-3a25-41a5-9741-4711fff2bee7	2	2	16	87.49	69467060.00	69467060.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d3949167-8f1c-45dc-a776-f9dd1100fc73	7b35cdf7-247c-45df-a1b9-a1d2c0c2799b	2	3	16	86.6	73263600.00	73263600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
354390dc-0fbc-4fb9-ba8c-4cf5316e67bd	bc190e85-dc41-4acd-aef9-d687dd03a1c0	2	3	16	74.9	67484900.00	67484900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
bca7ae50-d6a0-4eb7-8cd5-8ff320abe863	197d7864-ef80-4661-9f73-e049c776f54f	2	3	16	75.31	67854310.00	67854310.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f30db3a5-3435-47a4-b731-03b8dd5dc4ff	c6f2fdca-628e-4339-9642-9dfe7b36fc1c	3	3	16	70.64	71911520.00	71911520.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e2cf5acd-e4f6-40ad-b438-ce8bd02b801d	0f629ca1-f6d1-4bae-bc49-cb53fb050d92	2	3	16	94.21	76781150.00	76781150.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a791ca8b-07f2-4f46-985f-781985883304	08a9b7b5-d2e7-459f-9812-4923ae9e875a	2	4	16	86.6	71445000.00	71445000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1ac6a114-69b2-41f9-832e-8ca97e31470f	d487d27b-ea36-4fad-9f2a-544d7419c525	2	4	16	74.9	67484900.00	67484900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
c6153cdd-e3ab-4e09-a42c-f1269cbe8b57	0710c811-bdd4-4dc6-9667-026f5b70e3bb	2	4	16	75.31	67854310.00	67854310.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
4de8490b-e632-4288-99dc-db31ee51523f	3884560b-50d1-4853-89ac-6868edcf5d23	3	4	16	70.64	71911520.00	71911520.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ee84e5de-9c87-4303-9775-5bb0ffa4e064	7737e92c-f2db-491b-aa93-292075877bdb	2	4	16	94.21	76781150.00	76781150.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
5fd141c4-1764-483f-b6a2-31113766e977	bbabb04e-ab7f-4298-a16e-d6256fc1ba55	2	5	16	86.6	71445000.00	71445000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
dee543fe-bffd-48ce-b795-12cb0176b0ab	89ee7308-103a-4226-b72f-5244abcc60b2	2	5	16	74.9	67484900.00	67484900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1fbf4603-2b7b-4d49-932a-01936cb3777a	3936a070-42c5-4682-bcc4-cd8c92d4f198	3	14	14	115.8	92292600.00	92292600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
a5bce1d6-3a15-4205-a1cb-2bb6dfa10ec5	b004a751-5197-488c-8b64-7f5485b5cff7	2	14	14	75.45	63227100.00	63227100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
703fbf42-80b6-4130-928f-da1262e8bed7	1c5aecdc-f81b-467f-988a-96473640db4e	2	14	14	74.79	62748810.00	62748810.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
8635edad-9564-408c-a40b-40097e6b0b7f	65fcf956-98ce-447d-8e6b-216f24b1d6a7	2	7	16	86.6	71445000.00	71445000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
95534af4-4367-4166-9378-7cf2a9a1fc1d	42514ecd-76c5-41b9-98e2-5d05faf567e9	2	7	16	74.9	67484900.00	67484900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
d972bf6c-5aa0-4b61-afc1-bda3335203de	943ec427-dd99-430f-9534-1c7c9447fd72	2	7	16	75.31	67854310.00	67854310.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
3daed6ab-3e49-425a-a688-0530221fb7e2	6417a4c4-d654-4a03-8dfb-e6ab8b07a6c2	2	8	16	86.6	72397600.00	72397600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
50237f6f-a047-4554-9803-06e66c412ba7	a76103bb-2952-4479-9b08-262612009c5a	2	8	16	74.9	66735900.00	66735900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
f1a140bc-7d33-4e84-b072-eb00014c66ef	39e8cca9-b642-44e2-be13-4f75bd00c77d	2	8	16	75.31	67101210.00	67101210.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1feb0988-a19d-46b7-af11-2079e3b70655	8c2e1669-f41a-4afa-8910-0a26bc6a1ed6	2	8	16	94.21	77817460.00	77817460.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b1e1f9ca-b391-4847-a4bc-625ccb60c8e8	8c207e11-a333-4bf5-80e6-e29b16198a08	2	9	16	86.6	70579000.00	70579000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
bcaed4ad-a0f9-43df-a665-2e0a492a3cf3	029450ce-6489-446a-a037-c4a5dc92220a	2	9	16	74.9	66735900.00	66735900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
8639421d-4dc0-4c21-adcf-6d325f24d80e	ccaf7cf1-aab2-45a0-b764-cff1f6a86f82	2	9	16	75.31	67101210.00	67101210.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
38e844ec-8321-45e6-9035-3e81d9ecc85e	c986e6e0-c203-45de-9ca4-b9846829c623	2	9	16	94.21	75839050.00	75839050.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
67a5ecbd-6327-48f3-86c0-c99914f1bec5	130947c5-0b96-40b7-861c-03fca153372d	2	10	16	75.31	67101210.00	67101210.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
306d8539-5ff3-4b19-9e6b-1995e122ad21	ab10319b-aa9d-40d6-bd05-dd2269a1902e	2	10	16	94.21	77817460.00	77817460.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e90df557-7d38-4eaf-9012-2882eb7169d5	ee0ce939-acfe-4f73-b454-275e13b038d1	2	11	16	74.9	65986900.00	65986900.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b39d8261-36c6-4bff-8fc4-b9c4f13a9941	60cc4a61-ca45-49b4-84cc-158697487592	2	12	16	86.6	69713000.00	69713000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
51e26166-9261-4d77-b883-b95e359dea29	b367a666-8717-4109-b5be-d8e445fec25f	2	13	16	86.6	69713000.00	69713000.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
1bc21907-c1ce-4cd7-971f-529fe7fb02c5	a36560ef-93ab-419a-92ff-30796d9b1bab	2	14	16	74.9	61343100.00	61343100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
ffd72c06-3f8d-47a8-b22e-d58e6e6ad958	5baa2b83-437c-4601-b52a-203933542910	2	15	16	75.31	63185090.00	63185090.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
73249b60-d02b-4251-9195-262e14b409f9	0a1265f4-883b-4b58-8b37-af3c257b22cb	2	16	16	74.9	60594100.00	60594100.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e76c6070-90e1-4b7e-8e11-7881cf2d52a9	a449d466-5cfc-4d45-999c-634a473e2d5f	2	16	16	75.34	63210260.00	63210260.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
e9b48951-3bff-4276-bb60-fcccd783ad69	afd21dc8-8ac8-4c85-ba2d-fde95f9c79c0	2	5	14	49.42	47393780.00	47393780.00		2026-06-26	t	a07586c8-dce2-4e28-bc34-4ad15c3d3414
9a3aa383-c0de-4045-9d38-8b144e99b46d	ff9323a6-2fe8-497c-aab4-d7ef83dfd1f5	1	11	14	39.31	37698290.00	37698290.00		2026-06-26	t	a07586c8-dce2-4e28-bc34-4ad15c3d3414
d2aafa44-95da-4bd0-ad55-f1c760e4a4a3	b50cb6ea-f38e-45a5-ada5-f793a251c482	4	10	14	121.76	90102400.00	90102400.00		2026-06-26	t	a07586c8-dce2-4e28-bc34-4ad15c3d3414
c2d04439-6e42-4f1b-8ac2-e3e70b614b4d	8d3f4756-33ba-4dcf-939b-66009711173e	2	2	8	67.14	54114840.00	54114840.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
e52e95c1-cd9b-437f-b137-d8a5b6c1cf94	4c4d8ca5-fdb5-454d-b5bb-649c4949f036	3	3	16	74.41	60048870.00	60048870.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
cf8a66ab-71e3-4aa2-8c2a-a0a6068d847c	562f2462-f02e-420a-973b-9d3fd4accce8	3	6	16	74.38	59429620.00	59429620.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
4516670f-a4f8-4957-a121-53171d7754d2	c48e7353-f575-4cb9-9293-b9c35bb51d82	3	8	16	74.38	59429620.00	59429620.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
16861da3-826d-4df1-9247-d4ff7c2ae190	7bfba6f4-89c6-463e-ae4c-fc552858ac58	3	10	16	74.67	56002500.00	56002500.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
50884b37-d129-470f-bf08-02e4c6e2891f	aae106f3-e149-4226-addb-90566da8870a	3	10	16	74.67	59661330.00	59661330.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
0ca19855-0cb9-4d55-8e68-40de0f662241	7f882b8f-a196-40ac-b926-ffa51436d307	3	11	16	74.7	57743100.00	57743100.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
1e508f6c-2f02-40d5-aba1-fb224ca4d2b2	06678ce2-b578-4568-b76a-de2b8b02541a	3	12	16	74.81	56107500.00	56107500.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
34a7eec5-bb16-46ce-ae48-62e8636f2a4c	357ebbb6-dc63-43f8-97d3-37d1465013e6	3	12	16	74.81	59773190.00	59773190.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
a318e21c-2cec-451e-9c3d-21b1905bf91b	d96bd9cb-7418-4c52-a442-d82fff85b7cc	3	13	16	74.7	60208200.00	60208200.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
b854e340-90da-4d60-a669-53c53755e140	72c0a97f-1ec0-4d52-8f49-27584114565b	2	16	16	55.68	45323520.00	45323520.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
42461eaa-c92d-44f6-8855-d6e2390cb3ea	a5a40a17-35ac-400a-803c-f186fdcc7414	2	16	16	55.69	45331660.00	45331660.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
23c9faa0-f1c4-4c62-b710-9371a4eb4fd8	3a482377-4663-4b68-8ab5-bb5e899a3700	3	16	16	74.81	59922810.00	59922810.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
44fc78dd-e3bb-496f-ab28-0a40aa2ea2dd	a89ad22c-5f94-4a99-ac42-9d302a3c43a3	3	2	9	70.78	57898040.00	57898040.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
6c202cfd-4e5d-4421-9835-32c1004b8d4d	53d2ea2c-7fa2-439c-905b-efc60686b5c9	2	2	9	64.17	53389440.00	53389440.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
7ee30c34-335e-42e1-a069-2ea065b5f929	b3665b6c-9460-42fe-93b0-eca269cc0b92	2	7	9	58.54	46129520.00	46129520.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
60fe9da9-5ca5-4b2f-b735-901cffd3989c	c03c5bab-be65-4351-bc96-6b0bd19f1a86	2	9	9	58.54	47534480.00	47534480.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
cd6ac8bb-64cc-4958-9fdf-ac19f386472f	8a801c88-5f26-402e-9bfe-1374e73db251	3	4	9	85.8	80137200.00	80137200.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
88268afc-438f-415d-8e1a-98bc76c94238	514a9f0d-9a1d-4be8-9470-1ce9918ac7c1	3	8	8	91.53	82377000.00	82377000.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
4be66caa-7ba0-4d63-99e7-40e6283e14e2	c8f1a891-728b-4dbe-91ba-35dc0e5fc236	4	8	8	118.11	100865940.00	100865940.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
11b63fb5-5907-41d2-a111-ba4ed9a465b4	4a6b6da9-ef69-4cf3-ac6e-023759019fb7	4	3	17	107.12	87838400.00	87838400.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
dfcb1352-7710-4966-868b-360f31fa282f	fd4c03a8-70c1-4b7c-9786-ee94df58800f	4	3	17	104.44	85431920.00	85431920.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
57630788-4095-4d08-b53d-79465bfc4b37	3e451ab0-ff6e-47ee-a43e-dfafdf4c7864	4	4	17	107.24	88473000.00	88473000.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
c2a9c295-ccd1-4fe9-b283-e63532c54188	afa58ff8-6a81-44fd-8d56-33f5ec5616a6	4	4	17	104.58	86592240.00	86592240.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
25d1e5f1-fb26-4625-8633-65d2cd0ea3bc	adc7ce85-c3e5-43f5-902b-229b78467753	2	6	16	86.6	73263600.00	73263600.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
2f8c04f8-9cbf-4586-b22d-87c9ae24f151	8f015cf7-1950-4110-a8a2-20d825dcb045	2	6	16	75.31	67854310.00	67854310.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
45450572-19f1-405d-bcef-2b059e23e089	e3c76cf4-7087-4c8a-93d5-a272712acbd7	2	6	16	94.21	78759560.00	78759560.00		2026-10-02	t	242f52e6-ff31-40e9-ba4f-9773a184393a
b149602f-d2d8-4170-be43-38c0afd4d4ea	873cfb2d-bce2-4ebc-9642-3483cf74eb73	4	13	17	104.98	85978620.00	85978620.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
a2b1d150-3942-41af-bb50-a09a4a7cfb6b	30aefcf2-0f4c-4853-8e87-be8db5f46c20	4	14	17	107.84	87889600.00	87889600.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
11875f3a-dc7b-46da-89ce-a2d5a5ff0a2c	1165f351-a34a-4fb6-966c-2ab10aa0f48c	4	14	17	105.11	85349320.00	85349320.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
25cab64c-1e44-49af-9c61-b30faa68c230	df5f4457-85db-4dd0-b86a-f89832ce9a18	4	15	17	104.98	85768660.00	85768660.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
53f16276-5c4b-4753-b365-20d1328e2b3c	e5ea58b5-9f1b-4f5c-b357-8a7e579bc2a6	4	16	17	107.89	88254020.00	88254020.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
cb12fced-1cd4-4cb6-94ed-bc93109669cf	5d27eb35-77c4-49b0-ab64-4c26e943d19e	4	17	17	107.77	87617010.00	87617010.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
2dcad75a-e7a6-4d9b-8d12-4d1e6e53cae4	a8d9bb6c-0087-4f28-8b3b-88fd16fe7671	1	17	17	40.63	34129200.00	34129200.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
6fb9eea8-509c-4a4b-a465-88218063fac5	f43ad612-b02e-485b-8ecd-86842ad0054b	4	17	17	104.98	85243760.00	85243760.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
1f6c2afe-6e54-4e5c-a0eb-690487221b4e	908b0b3b-4334-49a8-9be6-d7d2b57bdd14	4	7	7	119.16	102358440.00	102358440.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
4024f8a9-ffa8-481c-b833-5ca71471740a	50226346-1533-44f5-8d04-1211a02c72b3	4	7	7	119.11	102196380.00	102196380.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
07fbf36a-9510-42da-ac21-5e233f770f25	d5ea537b-40cc-4082-a3f9-25dbb4b575b6	3	4	9	77.93	49875200.00	49875200.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
93b2619a-0073-46c2-8557-098a866f7cff	daf9c422-f640-11ee-a82d-001dd8b72708	3	21	22	112.2	123420000.00	123420000.00		2025-11-05	t	d5800c89-ebee-4cf0-9e59-466bf0b1b56f
0ef0161f-99f4-4a27-9310-58764ba50f66	f658105c-0013-4b21-bcb6-b1eb7ceb424a	4	11	17	104.98	86188580.00	86188580.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
6c90a433-e6f6-4efb-a6a3-8f0b6d91e3f6	75826dd5-da6b-4b41-8dbd-4ce8c5474777	2	1	4	98.82	102871620.00	102871620.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
d363d350-0574-4344-b57e-eca26b6adf32	046f64ba-2de1-4195-9a31-2d1e31787411	5	2	5	209.18	226751120.00	226751120.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
cab2e987-b503-4886-9e95-f7f6e47215e9	83deca43-5c45-43b1-965b-d259984ca8e3	3	2	5	119.61	128341530.00	128341530.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2fae0a03-e976-4293-8184-edbebd6b0c3c	414dd3ac-91b3-4de9-a4d8-1ac03c7d5d10	4	3	5	147.75	162377250.00	162377250.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
e1b0a1e8-eede-4967-b6ba-af513293aaa3	4c1fddd3-08b9-4bfd-b887-a2aceda30dac	4	4	5	147.65	166844500.00	166844500.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
f4adf3a3-67b3-48f9-976e-58f75d36e602	cf988965-6761-4d15-9794-0997895ebb67	4	5	5	147.86	155253000.00	155253000.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
c805d900-f24b-49f6-b953-b31d11a74c54	99112eae-2b18-4387-89f8-43abf37629f4	3	1	5	102.78	107919000.00	107919000.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
1ac31037-b0d1-4596-82ba-d104c5c74f78	61cb2944-1423-460e-b588-0f49dcb16a32	4	4	5	153.55	161995250.00	161995250.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
08be60e5-d331-4374-a30e-06e814a65c90	8cbdf9cf-e93e-49b4-9bdf-37c2cafed530	4	5	5	153.62	160225660.00	160225660.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
32333616-359f-4244-b224-3e70ef1f7088	3673974f-8773-4ec0-859e-2a4a72c004ee	2	1	4	88.07	92473500.00	92473500.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
01b1e519-360b-4fb3-85ac-27d7d1b18b78	d5eb51dd-4760-4064-8726-31a726db1998	2	1	5	88.85	93825600.00	93825600.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
058ae13f-8b75-4b81-b3a1-0c717718dd56	fd5625d5-8041-48c9-bef6-70726b7167c2	2	3	4	86.78	96152240.00	96152240.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
b8cba0d2-9664-4c64-9f88-a4538bbf8f6b	285591d1-0073-45d0-8c57-7e7c13a9b0bc	2	1	4	101.21	105258400.00	105258400.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
af4722df-a119-4760-8767-25a1f07e0100	9bb31827-4953-4bd7-9669-434d1ff2c11b	3	2	5	119.76	135328800.00	135328800.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
e99c0f5c-6a31-4721-80a5-c218d1bb476b	b195189f-fc28-4b04-ac38-74600f3210f3	2	1	4	98.23	101275130.00	101275130.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
8b1f4f13-bcfb-48d8-b950-c641b28319a7	7ef2603b-ecef-436f-9e3b-129bd47042e7	2	3	5	87.2	102024000.00	102024000.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
683f22cf-6d75-4734-9619-499b0f0db492	a7b99b0a-9664-4263-b7fe-c9f4ded9aff5	4	2	4	149.95	160896350.00	160896350.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
f0937ab1-3b17-4eb2-ae1b-4e443948cfd2	a038c932-5898-4468-a59e-481f84e5677d	4	4	5	146.25	165701250.00	165701250.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
192c7949-52c7-45ba-9c8a-75f3ad544d2c	7e8103b7-fef2-4e45-af49-2d9307dc0dff	4	5	5	146.37	160567890.00	160567890.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
1e196f18-15a6-4e6b-8204-2ffdb0844572	f374b908-f6bb-489d-9eaa-0bf592e61705	2	5	5	87.34	103497900.00	103497900.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
d960f38e-4b99-41b5-9215-65d89cb79228	fb1d2d56-faad-4fb0-bf79-91bc5611f290	4	5	5	149.25	163876500.00	163876500.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2d5b9450-7bc6-4d88-bc2b-34e916c5dc05	b52a69be-1eae-470d-898a-a09129a4a946	2	1	4	88.53	93487680.00	93487680.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
abc817ac-9a27-468f-ad2d-036e23ebe232	594734d9-bc35-4b31-9500-ad20b46265fb	4	2	4	148.95	161312850.00	161312850.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
6cbe5b6e-066a-43a2-b7d4-fbf11bfb49ae	e7961f06-120c-4286-802f-64da3cc7762d	2	2	4	87.41	96850280.00	96850280.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
0f1666c1-c12c-4948-96ad-b3d669252c8e	115a2106-4095-4c4b-ad58-8ecd2ae69d2d	2	2	4	87.22	105999949.00	105999949.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
59ff1d47-19f7-4f3f-b413-81d54fdd75d4	aea162c7-a4ac-45ac-b851-df750bf78e95	4	4	4	148.91	168268300.00	168268300.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2e377a2f-47f4-4a97-8730-59d743b27cd6	baf3084c-aaf3-4511-b3ee-0504c81f5e33	2	4	4	87.2	97576800.00	97576800.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2e73d56d-6ee9-404b-8b82-ba1cbb15194e	252530b8-b073-441a-8d8d-89ea1981b32f	4	4	4	146.12	160293640.00	160293640.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
7bc6feaf-d9fd-4867-918e-fd5842f3f7f1	1c6206c6-56c5-4bc7-a676-b73cb626256c	2	1	5	72.9	76763700.00	76763700.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
9f519e41-cf03-4e74-af5c-320d04da8d9b	5cdd2266-8e22-48a0-ae0b-4b1a0992ed5c	3	2	4	119.19	134327130.00	134327130.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2b950d22-c895-4ce2-8532-58014cff47dc	e8696674-e1ba-4bc2-a621-8b72a1646b93	2	1	5	66.32	72023520.00	72023520.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
835c3965-9b3b-48fe-ad35-5bcc02c5752f	0d679f33-7214-49e3-a0e6-47353c993908	3	2	5	119.38	135018780.00	135018780.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
817afe65-f535-406a-8bab-ebff91e6ba6e	53a37b78-7342-4e6f-982d-43af815e554b	3	2	5	126.3	141708600.00	141708600.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
1539c744-a841-43ba-a9f3-49aaacee0343	48c5ac5c-3eeb-45ba-9f93-032e0d9f8eea	4	3	5	146.43	159022980.00	159022980.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
59a1b119-6b49-4b18-9b6b-736c3734efab	dca03cb3-3865-4a99-8b57-df527fbfbbde	2	3	5	87.95	102725600.00	102725600.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
764e6ebe-aec5-46ae-80ed-b00a6dc90da2	d1bdfc62-6959-4c23-8651-36bcef3b471f	4	12	17	107.89	88361910.00	88361910.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
70a668e4-64d6-438b-9dfb-4addf53aa227	bc227805-024c-453b-a937-5518f3f1a0ff	4	13	17	107.71	88106780.00	88106780.00		2026-09-25	t	23428d03-18a0-4461-a225-3e75f604cc4d
6974182d-d03f-45a0-8408-3c40a8808dbc	e92e8e4c-a307-4933-b1fb-0287dfcac997	3	7	9	81.97	39099690.00	39099690.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cd8f59b5-7ccc-4ebd-932b-849978530473	d6b365ed-fd79-4c17-971c-e9b0687c45bd	2	7	9	39.54	23644920.00	23644920.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
72b7bc14-5ec9-46b8-aa68-7c113ae9a1c2	a9376eca-717d-4099-9ab0-13b6fbb9f95c	3	8	9	81.97	38279990.00	38279990.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
46e293c8-1695-4883-8ac6-562d7587964b	76ace577-9ed3-4394-b4be-808b67b4ea99	2	8	9	39.56	23261280.00	23261280.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a11faa68-32aa-437d-a602-76d1f1c9642e	63e1fe45-3dc9-4455-8bf0-b090f70bd596	3	3	5	126.08	141461760.00	141461760.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
2da0e342-51d4-4bcf-a7fd-9352d911cf5b	2dcd885d-28e9-4f5a-a5b9-82cb79323ce7	4	4	5	146.41	160465360.00	160465360.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
1f59fb1a-ed73-4ce0-b84e-80a2828c8181	b26cbfee-d729-45c2-9f0a-20f1f1b3b68c	2	4	5	87.92	98294560.00	98294560.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
6add67bd-00d2-4e69-a0ad-d68162a6253b	cb8c5687-032d-4dc9-9470-179990178551	3	4	5	126.06	145977480.00	145977480.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
d0da9cf7-c76f-4c18-a613-f2f134b479ba	04a91778-3998-4dcd-b327-6939ae36b744	4	5	5	146.48	161274480.00	161274480.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
54fea10b-cb95-4edb-a1f0-41ed98a8982e	3e37d433-64ed-4dfe-b964-66654556db73	2	5	5	87.93	106155163.00	106155163.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
6e4f970b-e20c-476b-b4f7-bd2fb4a9ea6e	7c62ba43-edfc-46ad-8026-158a85199c65	3	5	5	126.02	143284740.00	143284740.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
b4391b3b-3821-453f-a8f1-63c79a7230c8	02161899-ba6d-49e2-b97a-e0e333fee875	5	2	5	209.63	227238920.00	227238920.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
1f1f0599-15a8-4b24-b56f-4915045a490c	165bb03b-88ed-4a9b-b289-2919564f85a9	3	2	5	119.69	136566290.00	136566290.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
34696c49-aea6-4d05-ae00-b76617d45790	5047134d-7b63-4d07-b121-cbdcd5e75a1e	4	4	5	147.3	169542300.00	169542300.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
d4567567-78c5-46db-8909-e96dc93ee61f	ea1843c9-0241-448d-8b64-7a0fe3a038ec	2	3	4	87.05	101848500.00	101848500.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
7836c765-06fb-4251-b802-2a5d421338fa	47b3f2b8-c6e4-419b-9b66-b78ce70a8b30	3	1	5	121.61	139851500.00	139851500.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
72151bd9-545a-4fc1-9cbe-3d316af80d10	49f101b3-5669-439a-8eb7-0259e8a040af	4	3	4	145.85	166269000.00	166269000.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
77094b95-ea3f-46a8-886c-c21f751afce3	66a18c3a-ab90-4aa9-bb82-92766bf88538	3	1	4	116.7	124052100.00	124052100.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
32b814e3-ef06-420c-92ff-17f1bbdc346c	e626215f-8853-4dc2-a565-89cda7d3bc27	3	2	4	122.32	138099280.00	138099280.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
87bd97d1-c87b-4efa-a286-4865035f7c53	70168eb0-c156-40eb-8850-9182b913ec76	3	2	4	113.9	125176100.00	125176100.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
a3674f24-3dd8-4ec9-b45a-c2419f7a5ce8	7f6fc802-5dae-49b4-8012-eae14543ba0e	4	4	4	149.14	175985200.00	175985200.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
01823787-0319-4f35-9e01-d986d5a4e394	8ca7ceb5-7ec1-4903-aaa9-0953a50a9782	3	4	4	114.09	127096260.00	127096260.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
4209314e-e6cf-4533-9f93-b6a5bcac8b9c	07fbc218-3104-41c1-a73a-d0035a74052e	3	2	5	122.41	134895820.00	134895820.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
b31fec48-f539-45a8-9650-ef1d6a26f2dd	dca6bda1-9b5b-4d31-99d8-548a7fa26e9b	3	2	5	113.95	122838100.00	122838100.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
616905e2-d8ef-4a93-a515-c693400b5bb0	9534929c-a260-4146-996d-13d3a17f46ec	2	4	4	87.03	97473600.00	97473600.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
8b62b00e-1db1-49f8-8f10-88d7d99b4a09	185507b0-ee22-407b-aa48-626dca68dfad	3	5	5	114.24	127834560.00	127834560.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
88b911c7-9962-4d18-991d-ff61ee7e1b4a	a95e4c65-972f-4e74-8c94-73efcd989ea9	2	1	5	93.43	97260630.00	97260630.00		2026-10-23	t	c1788e5b-ec5e-4712-b573-1d782de3e7cb
0b26bb12-5510-4083-9ba6-cd706401944f	44fab8e4-8fa2-49b3-a088-6c97a86fa20a	2	6	9	38.17	22902000.00	22902000.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
eeec125d-5956-4537-bd6f-eaf1628334d4	b97728e4-207e-4f1d-8198-b586280a3ee4	3	6	9	61.62	33459660.00	33459660.00		2026-07-24	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5be77405-384c-467e-85ce-e5dc80937bdd	3059c331-ebd8-4477-9ab5-78dff006fc40	2	3	9	36.73	27049534.00	27049534.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fdaa6871-1fb3-457e-af2a-3f9e0a37000a	dd8ac010-1fef-42a9-9dea-29ec6d18e184	2	3	9	36.82	27069414.00	27069414.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0c0fdcf7-310c-4e3e-b6be-c4c8d482d720	9a35c8a6-d670-46c5-8c36-d6a37b76a9a5	3	3	9	86.13	48313455.00	48313455.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bbf44291-64e8-4bc3-856c-3fb5ddc3fe29	d0cd9e0a-cccb-4cff-b1c0-e4e9b06c7847	3	3	9	61.87	42774491.00	42774491.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e8fa98ae-e180-44bf-85de-87c1a9c8344d	f2833113-5fd4-4a17-8f7f-a3ae8f5db77b	3	4	9	85.96	55954189.00	55954189.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
21cd992d-2c04-4a12-b2df-1c3210fbacc3	3e00e8a1-31cc-42cd-8ae7-a27e8231ac18	2	4	9	37.3	27409911.00	27409911.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b4911f51-6446-4094-ad5c-6a1259f24b8c	57676c54-9796-47ec-ac84-cbc5cf959a86	3	4	9	86.13	56065155.00	56065155.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0a8b68c5-2124-4c9e-bcba-731862a00c5e	d6591d46-0150-4fe5-9007-ca21a2e04cdf	3	5	9	85.96	48217789.00	48217789.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0834a09c-3e51-4b02-b59d-0b6f07675a5a	8d54b2a9-a496-481f-bb9d-643c77f9541e	2	5	9	36.73	27049534.00	27049534.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4f7a106c-3f98-44e5-a451-38c0cb4fcb5d	3e946d88-226c-41bc-a4ba-fadafa7be6c3	2	5	9	36.82	27069414.00	27069414.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
323a9402-bbf3-4844-8e72-2b59f37b30c4	a5352fc6-fd0f-4b6f-bf99-70be60afb23d	3	5	9	86.13	50036055.00	50036055.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a1a83c6d-2170-4898-a0ee-01648a5f3373	fc7c5507-c426-40a6-ac23-74fdc2727299	2	3	9	39.94	28592126.00	28592126.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bf2d0d16-b615-4215-8728-14d214d3884b	ff181aaf-0bad-4bd4-878b-440f2100917f	3	6	9	85.76	48162264.00	48162264.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4bac8506-41e7-4db5-bd7f-9c2c1887dd52	b1c67458-dfe1-471a-8e5d-dd68d33517c8	3	6	9	86.44	50203184.00	50203184.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e812eb52-8d9b-45e0-af8e-7041bb024931	81156144-b3e0-40bc-9e2f-dcc6bd9312f4	3	7	9	85.76	48162264.00	48162264.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4bf06a27-5abc-421e-a192-fe5f23f2b004	d316aea7-aa91-4927-bf31-3b35c42bded3	3	7	9	86.44	50203184.00	50203184.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3f6478ea-4b53-4a4d-baee-d82f2ab4510d	f6113a7f-a024-43c7-92a9-e5fa4f98332e	2	3	9	39.53	28900334.00	28900334.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
02dc51dd-141a-4abf-9781-341a87e34d9f	455a576e-9a5b-4aaa-ae66-bc76aef02324	3	8	9	85.76	47304664.00	47304664.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c6434f34-6160-41b6-bfcb-2b7c636395d3	1f9299cf-b9c2-4c48-a76d-d23b78594858	3	8	9	86.44	49338784.00	49338784.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
38caf79a-3d7a-44b7-bda1-fc1db2a81ea4	27f9a6b2-78f5-40cc-b898-844f4c3fc543	3	9	9	85.74	46866984.00	46866984.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
64293047-68ea-4c9a-80af-7c8e7a121c35	e0177a82-99a1-4c81-9e1d-f3bdd0c4ec1a	3	9	9	85.65	48540024.00	48540024.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5d3c6222-e8fd-4bca-a8d6-4e9500ce5b02	825c7382-7840-460e-9ff7-225c347e68f7	2	3	9	45.99	32237380.00	32237380.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7ec3391f-5c4e-4ca2-aeee-813c22ea9cb1	03b35db1-17dc-47fe-ae53-17e0435c4f32	2	1	9	35.86	22986260.00	22986260.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7b6848b9-f52f-4617-b290-0d002ef2c455	2f285210-368d-4055-9ed7-4e31cd89111b	2	2	9	35.82	22602420.00	22602420.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f2947857-6d24-4ad7-aef4-3ecc2f6eaaaf	efada158-ef2e-45f2-889c-d2a309336768	2	2	9	46.8	27705600.00	27705600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0e6ac5e3-d54d-4c49-89b1-a1b7f0f95141	5c9343d4-9b15-4734-b02d-a444facb541b	2	2	9	39.69	24845940.00	24845940.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
eeddd23f-bd37-4a9d-90c8-4764d5f8bbf5	d127b779-3ab4-4943-943f-5f062f480806	2	2	9	39.89	24173340.00	24173340.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b1db1467-480c-4de7-8dfe-aef8c88deffc	54e356f8-1ff0-44f0-9179-b0f399cad4ce	2	3	9	35.85	26445264.00	26445264.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
485d08c4-5e93-48e1-a66c-f15897894b38	1aa15623-5aef-498a-8fd4-4e26e92fde3d	4	2	9	87.98	43110200.00	43110200.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
25dd1a0a-f92b-4dd8-b883-c6e78e215f90	e363a7a1-bde5-4ca8-b1d7-b2198e0d37f7	2	2	9	54.43	29718780.00	29718780.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a7de799d-1f01-4742-8cd7-47218cd77466	af1a6392-16f7-4d5e-bc83-e66590508857	2	3	9	46.5	28458000.00	28458000.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d16d16a9-26ef-4532-8f69-a4ae379b302f	f864e3de-8533-4405-90c1-905f2040a3fa	2	3	9	39.43	23894580.00	23894580.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
05218fbe-9051-4df6-aa2f-f32b44c3bc1e	faba8656-3283-4873-ae04-c1dddf03f003	2	3	9	39.86	24952360.00	24952360.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
88a965ca-251e-46f9-ba45-1bceb91bbd2b	ee6c6ce5-decd-4572-89bc-a53c787318c3	4	3	9	87.68	50854400.00	50854400.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1951db70-a3d7-4690-be6b-01af1b45aa1d	aa2397f6-6860-44e4-845b-20499d5083c9	2	3	9	53.85	30640650.00	30640650.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7cddd8d3-7a6b-4981-9cea-d057947f80f9	8ca87eeb-ba55-4f3c-b33d-57b8d491ae6c	2	4	9	35.82	22602420.00	22602420.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3400d7cd-13f4-45b9-b2c0-a2e97ff97387	19945ad8-23ca-4044-ae16-7f32a7453213	2	4	9	39.43	24683180.00	24683180.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
78fd548a-d602-4150-8885-7960e82180cf	f6890f31-cf07-4cac-aa46-a9e2b97bdc76	3	4	9	61.74	36426600.00	36426600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4f9acf6f-c3ed-4e05-ab0b-b332304a2bce	fc46f86b-2a96-4349-9d1c-db749b68fafe	4	4	9	87.68	42963200.00	42963200.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
56c8843d-2de1-456d-8f8c-e6cb49cb1b23	53d279b7-980a-4ab6-9ce5-524db0ce9ce4	2	4	9	53.85	32848500.00	32848500.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
617ac8cf-02f0-44a3-af6f-209f7e276a15	17587e03-9b60-46cc-a3a9-458bfbb23d0c	4	4	9	87.84	59903308.00	59903308.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
817dcd6c-64c4-4ae1-9c09-634416b0831e	18992dad-f011-454d-b07b-c975435b4f74	2	5	9	39.86	24952360.00	24952360.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2a5cdb3d-5e84-4347-a183-f2d9f60f70a8	5d1f4e8c-5e67-4334-9383-1c2f5b458ae4	4	5	9	87.68	50854400.00	50854400.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
9edd7ea0-6dc7-4168-a300-458aa67d04f6	f846849b-da93-4913-83b9-fd0b97d7bc94	2	6	9	46.32	27467760.00	27467760.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
30ab8ff1-b0f4-4c8c-a84f-4d7685a3f1e0	a1513bf6-b284-45fe-980c-281d59f995ed	3	6	9	61.64	36367600.00	36367600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e757b2dd-b8e6-403f-bd97-0dbe812b4e19	8c9274c9-2344-401a-abee-672d4650872b	4	6	9	87.42	42835800.00	42835800.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
07d0dceb-c57c-4e49-a47f-af2ea4c6a7a9	8a7a17de-4269-4d98-8ee6-424b23a8e694	3	4	9	61.87	37206191.00	37206191.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
273c1868-4023-474b-9037-d1f0b4114fdf	920fb8e9-5259-4305-87fd-beb5e08b2c71	2	6	9	53.67	32738700.00	32738700.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1bc4e79a-770d-43b9-b075-1f671c7341bd	72b6e4b8-35bf-40ca-bc95-75e7e40141ed	2	7	9	46.32	27467760.00	27467760.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2fc04cb4-8c5b-42a9-b723-1a7933ad89b0	36733bf6-416b-4e7d-a69e-ba117234eb6e	3	3	9	85.96	48217789.00	48217789.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
da99e475-fcae-4978-ac5e-51bbf404dd08	a92177cf-002c-44ba-a3b7-8e3e7837dc8c	4	8	9	87.42	41961600.00	41961600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f2443a55-30a0-46e9-8915-37c68823fb37	be2d4749-605b-4171-9e6e-72e573e175a9	2	9	9	46.32	26772960.00	26772960.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e8134e6e-8540-4543-8f7b-434fddb811f6	afb6afc3-09e9-4f5c-a595-4ca26f3e4965	2	9	9	39.76	23498160.00	23498160.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a189b0ba-4712-4f88-a22d-0e402390762c	e913a350-29f1-4724-a321-f349cd2cd153	3	9	9	61.64	30573440.00	30573440.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fc0a6494-865a-4e8d-ae64-1aed2f2bcba7	f0d5b675-b5a1-4f4c-8463-269cf65d30ca	2	2	9	54.43	33779724.00	33779724.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
88606851-6db2-4f93-9f9c-6a21397bb1a6	33fdd4d3-739c-4033-9aeb-1c8b27d8e432	4	9	9	87.42	41524500.00	41524500.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0ec1f6e9-5e59-411e-9bb6-6eac9140a7cb	8d76de43-dbd4-4fe4-80c8-51cd1c3d3bbf	2	1	9	59.47	32054330.00	32054330.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5b07b972-adc0-4f5b-bc01-a68edc3fa303	d630b260-bcab-40a6-8993-b2bffd8ca8f0	3	2	9	63.9	32652900.00	32652900.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c74aeb53-4b19-46fe-9b9a-21f1b745d3ba	95c53269-1148-4850-9a3d-76df9fb96239	2	2	9	57.68	29993600.00	29993600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
76aa61ea-bb57-4c6c-8200-3efd96559390	3dd7c902-cc6a-4b94-a851-f9725fa6f2d1	3	2	9	62.18	31773980.00	31773980.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d78d5aae-2497-4c8a-b907-b2ef101afa69	1d8fdb90-c0b6-4576-9ea7-ba1fe8b1d8d0	2	4	9	45.99	32927230.00	32927230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d6933264-a5d0-4525-a151-12f8e6fa6b83	e98ca345-3eb3-430b-af3f-981ea062c46e	2	2	9	58.7	30465300.00	30465300.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e8210107-14ad-4f90-8f42-f98ccc1e12fc	09a7021a-4269-41f3-a643-e0d33f2e12fe	3	3	9	63.62	37535800.00	37535800.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7f1832c2-a894-4e22-9b6f-4107efc3ae89	9d8c57f4-78a8-4223-a352-e9460e455b57	2	3	9	37.29	23455410.00	23455410.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e7e8d796-8af1-4341-bb64-282918666325	f40317af-1aa1-4a57-b566-44fa848c3e10	3	3	9	62.15	31758650.00	31758650.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cfb4f84e-165d-4a9f-b27c-3ae6c9adcf56	e421582f-a673-4543-8b7b-03480a6c7896	2	3	9	58.7	34222100.00	34222100.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
db7829ff-cc65-4e8d-be72-80d7606ddf89	c656cf35-2f36-48de-87d2-fb90235f6931	2	4	9	57.68	33685120.00	33685120.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
652c6fda-47fc-4f25-9b38-57717f50a4aa	ebf18b5b-e924-4f09-b02c-d1f1261e11e7	3	4	9	62.15	36668500.00	36668500.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5467dfc3-43d3-4c4b-bae3-ef8fd205be1a	a38dfda8-bce8-4b8a-90ce-f4cbf5b8816b	3	5	9	63.62	32509820.00	32509820.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
57be8c8c-fb48-4252-b2f1-83d106947e9a	0dbe3c08-03a0-4875-9ec9-9be05a589ea6	2	5	9	37.29	23455410.00	23455410.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
9b590a6d-f725-4904-b7e5-2a9b11fcd7ca	b34dcbf6-9cbb-4450-8e68-2065b3adf886	2	5	9	58.7	34222100.00	34222100.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
20babad0-b8a5-4f7c-b27e-f02260c02be4	2823c5ff-5901-4c4b-8961-87ed74f5356a	3	6	9	63.35	32371850.00	32371850.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fc722f2b-e4ae-475f-96ad-7cf923770ae1	3a7ffde3-cc10-4988-b0c1-8c884ab9df25	3	6	9	62.06	31712660.00	31712660.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ea44e939-613c-4b8d-9874-2329b127d22e	4667343b-198b-4dfa-b508-e05b6c03beca	2	5	9	53.9	38359486.00	38359486.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8e116d73-7198-4f95-828e-4d7c4e561b36	72199ebe-fdbc-4352-a12e-d11f779721ec	2	6	9	58.52	30371880.00	30371880.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
47eed5ae-0d76-4c4f-b513-37f0eab8e6be	7c8d197b-f0b0-4d9c-88a3-4d146281a597	3	7	9	63.35	32371850.00	32371850.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6e12edc0-6dbd-4ee0-8d73-79181d3f2412	d92e8750-6fa5-4943-9158-6195bc6260e0	3	7	9	62.06	31712660.00	31712660.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6ae3fbf7-63a4-4f1f-aec5-d8116f8236be	9e2814e2-4f14-4b74-83b6-f12da6d6dea2	2	7	9	58.52	30371880.00	30371880.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c0b3ff8f-779c-4cf7-9eae-96e626a6e68f	e6eb5e93-7a53-4e7b-aa6f-22f3ff9e3c08	3	8	9	63.35	31738350.00	31738350.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
541a0d41-6d08-427f-a77a-e3cf45018416	89672f27-457c-4bc6-9871-4b10c33711b2	4	5	9	87.84	51997708.00	51997708.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
31dd037a-9ca4-46b0-8ee6-b4e766bb2dcf	ab07c1fa-4586-469b-b16d-db365e314bda	3	9	9	63.35	31421600.00	31421600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
66f6661b-722f-478a-944d-b2fd9e75f71c	60e1929e-0015-4ad8-bf14-fb00f3344c3a	3	9	9	62.06	30781760.00	30781760.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c28894da-4628-45af-b106-081f71d5109c	293b28b7-b0b4-4ebf-b3f1-2f86dbcd9c1f	2	9	9	58.52	29494080.00	29494080.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
55868987-f336-4a27-95a6-a60324482cea	f5c2c997-4a83-457e-ab04-361f02d0232e	3	1	9	61.77	30329070.00	30329070.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7e565dd6-7164-4942-8356-5d932d1e3c08	00bf1937-5e08-44fc-96ef-5ddcac6a1a4f	3	5	9	61.87	42774491.00	42774491.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
531272a5-8b3d-47c2-b808-106e40a520ac	fa0ca770-1d4c-4d31-810d-849f008bdb39	3	2	9	78.49	37047280.00	37047280.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
31922118-f0fc-4b84-b0b0-08961c8ace32	3a0a419d-e344-4c47-991d-ec03b9b58691	3	2	9	62.12	31743320.00	31743320.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
be06afc0-a36c-46b4-b175-fd8f739aef02	afb62b01-91c9-4891-889d-6d6f3c68236d	2	2	9	57.55	29983550.00	29983550.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
334857fb-d823-4ace-a51a-a42b013afc64	ba587c71-0833-459c-baaa-5eb1b374eaf4	4	2	9	101.73	52390950.00	52390950.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e6c130f4-8083-4ca7-8638-29b19cef9dea	064c098e-5f33-4263-8b3d-3f0a43d02b8b	3	3	9	78.44	43220440.00	43220440.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3d102f73-f61f-42cb-93c8-6d944a52e922	781346b9-b7d6-48c2-956d-6b32d6e7d1dc	3	3	9	62.05	31707550.00	31707550.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d4aefe10-830e-4649-a886-69b4b9c56ccf	0d45be12-cdb7-4877-9aac-765435b89796	2	3	9	37.32	23474280.00	23474280.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
abe13a71-7620-4683-a551-b78a7696937e	adfb08e1-7495-45a8-af74-287da188989d	2	3	9	57.55	29983550.00	29983550.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
77fff844-4a30-4568-ad44-904a3615eb59	0d2c4d50-57cc-43e4-a11c-b4aebd13a320	4	3	9	101.22	60732000.00	60732000.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8e5330cd-3255-4ee4-b14b-5909158d5eb7	e431c941-8f53-4d32-a86b-c09466744cb6	3	4	9	78.44	37023680.00	37023680.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
707ad27f-71cd-4953-b63d-981cdb99c505	4eb7481a-5207-4121-bd55-004904f57a8d	3	4	9	62.05	36609500.00	36609500.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c8c61deb-cc5d-4205-b06e-22b46a8e6ed9	83a95c73-a09e-4a5a-9dfc-4dca30ccf484	2	4	9	57.55	33666750.00	33666750.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0e04d44f-1174-4d1b-bbb0-54db4a1895c7	0745bee0-9f8f-4868-9a49-cf450b98bfdd	4	4	9	101.22	52128300.00	52128300.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
27e658ed-3d57-4644-ae55-47234ae02fdc	f7718609-0da7-440a-84ba-3f87d2940439	3	5	9	78.44	37023680.00	37023680.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d644b442-daca-4b50-9e91-e4e94efb9fc2	b5d50949-4179-4306-b846-dfa1e5cf7390	2	4	9	39.94	29191226.00	29191226.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7253195d-f241-477c-a179-9dc3014c2765	ca781781-b8aa-4b10-8b11-6bc97136dc8a	2	5	9	39.53	28900334.00	28900334.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cd9960e9-b068-4093-8aeb-b9d094e05cbd	c718d474-9bfb-481b-8fea-91e9d5f1fe29	3	6	9	77.99	36811280.00	36811280.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
908becef-be61-425e-b120-c629c871157c	315be243-fb94-4c8f-be44-3c4d82fd5dcb	3	6	9	61.82	36473800.00	36473800.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
34439e30-aae8-457f-99cf-7342a0c4349e	533dcd1d-1d27-47b1-a1f5-dbc01f730d24	4	6	9	100.95	60570000.00	60570000.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ffd60b48-4fa7-41b1-9ab2-5e4de92ea3b1	e5a88a08-b677-4756-897d-f2f57879bdf7	3	7	9	77.99	36811280.00	36811280.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ef154820-3f8b-45f2-abdb-0f7f12de5ada	818f4ea2-c7e7-47d0-ad2b-00ca87cdedac	3	7	9	61.82	31590020.00	31590020.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8d8a7e20-4b0c-4182-a45a-711ce8426a6f	94dcae17-fbe9-4099-8140-93da4243dae6	2	7	9	57.55	29983550.00	29983550.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fd4fc047-5d68-43cd-bd02-a964f19fe048	7a421c41-99a0-469f-955b-bc62ae00cfb9	2	5	9	45.99	32237380.00	32237380.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
85242650-c357-4e8b-bfc3-5a2d44e0062e	19de7d12-4a1c-4135-966c-b61d94186153	4	7	9	100.95	51989250.00	51989250.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
42f86660-abf3-4b48-98cd-a2632de0e812	90149990-0f9b-47f0-96e1-8170d19c6feb	3	8	9	61.82	30971820.00	30971820.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
358264a3-4332-40ec-99d5-1ba7ac0e16e7	cc4b6bee-c630-404f-ae84-6c21fe7902a5	4	8	9	100.95	59560500.00	59560500.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c90d76ef-39a6-4f09-9d61-c799bac93d0b	be363d30-bf58-4160-827d-8f49d1643f97	3	9	9	77.99	35641430.00	35641430.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5786eac1-4917-469f-a30b-95c0e4ac72b1	5aa1de94-5358-4117-9231-b1e3165fc4e8	3	9	9	61.82	30662720.00	30662720.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7f2cb70e-7941-475a-8351-b0df543d6666	aba5182b-7fd7-4748-8830-2c4f59a58840	4	9	9	100.95	50475000.00	50475000.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1ee43194-ba89-4595-873a-aeb679b68def	7e167557-4576-49bf-8298-03b95d047ef7	4	2	9	88.15	52178999.00	52178999.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6c772228-8f0c-4aa4-8c6c-26ca22612419	8318e2dd-76a3-41a0-8c86-092e495fb400	4	6	9	87.53	59697774.00	59697774.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f1eaa9d5-2399-4a51-b681-3c378cd34825	18634286-1854-456d-9c00-e459cc84a2b5	3	6	9	61.77	37146661.00	37146661.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
07798885-b9a2-4a77-8f70-00faac7d931f	8290cee8-2a42-4268-87ec-67020849996a	2	6	9	39.86	29129997.00	29129997.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7fb0766a-9cf2-4e1e-aabe-c4e88d70407f	ee0dca54-a0b4-4d81-abd8-f58ef5229db1	2	6	9	45.81	32799458.00	32799458.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d025b3e0-b822-4866-87ba-57cef7a052c5	cd05c73d-8917-4c68-926c-a34957670ed8	2	7	9	53.72	33342313.00	33342313.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
94a1eb0b-f6da-4944-b73f-79f196ef9313	6201b555-6381-4013-a15a-54b2beb9e4f7	4	7	9	87.53	51820074.00	51820074.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
03f39d8f-67c0-4ee0-8771-f0a85622e07e	7af33255-8033-40df-a393-45ae515917e1	3	7	9	61.77	37146661.00	37146661.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4a84df49-d405-4501-b3c1-e6dd766a7799	d9228c8d-7523-4ffa-a72a-395f13f380f7	3	2	9	61.9	37223621.00	37223621.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a184d1e1-122a-4401-98f3-ccf012646bfb	63046d34-7707-4cc4-aa9e-0ea8236b14da	2	7	9	39.86	28532097.00	28532097.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2fed3e07-d489-475d-a39b-cf6fbbdc9676	f45c31dd-0ab5-488c-98fe-4b859b5e4efe	2	8	9	53.72	32805113.00	32805113.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e3bbd518-87d4-4808-a353-1b062c5af4f9	65553650-2427-44ac-a6c4-9ae1c0ff60ac	4	8	9	87.53	58822474.00	58822474.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
90dc0117-ff16-4679-9246-55db78c7730e	45a13ce8-4abf-47e4-bdc3-24ffe696f4f3	3	8	9	61.77	36528961.00	36528961.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
863fe61e-4959-4509-8020-ddd3e9decd4b	fb06aca6-0b13-4052-b628-9f866d84ce0e	2	8	9	39.3	27751161.00	27751161.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bd530750-d32a-460c-afae-7f86afb72e62	6b71a586-2850-4cec-ab37-236d2552fd80	2	2	9	39.98	28616566.00	28616566.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
53f92359-74ed-4caf-8232-8e7024e035ea	14c14922-ac32-477b-926f-120aee30cc06	2	9	9	53.72	32536513.00	32536513.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
134b4ec5-d947-45c4-8a92-043130f91d68	2743057c-cb47-4c96-b16c-7051e16d300a	4	9	9	87.53	50507124.00	50507124.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4db61eed-46c4-493f-9c22-5ce83f4ff07f	2421d00e-a73c-462e-be2a-c49bf634e934	3	9	9	61.77	36220111.00	36220111.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
deaa5b88-2b74-45cd-8937-f7dd1ec73362	d98e82d9-6e39-4dcb-af54-07440c6760dc	2	9	9	39.86	27934197.00	27934197.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4a3875ee-2924-43fa-9647-472e16583dac	4396d513-78d3-4e9d-b8aa-91dd75e87861	2	9	9	39.3	27554661.00	27554661.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a7630d39-2f6e-4e0a-be29-8fd524265a7e	1153c6e1-d5e4-4562-99ea-53881a8bd266	2	1	9	59.77	36880722.00	36880722.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1a38b4dd-c70c-4d29-819d-991b71f6f425	13606041-73cf-47bd-b666-2e2163938c48	2	2	9	58.79	34824311.00	34824311.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1c6c7a71-40d0-4cc4-9770-51bf1d129245	39a669df-3195-469f-9701-0ccaa8cbc452	2	2	9	39.62	28367038.00	28367038.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
aa854473-244d-4c2e-ade4-4aa6ccb4394f	ce4b2b4e-8f43-40d9-b6da-c58ac61785bc	3	2	9	62.23	37321230.00	37321230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
94777ad0-4a47-49db-8c0b-48c33f32a4d8	8501c2dd-61f0-45b4-890c-bb181caa2851	2	2	9	57.68	33641893.00	33641893.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2c26b224-0cca-4fc3-bc83-a4f7f037bc79	5e6b80e9-d767-4ac2-a2f4-f0dfdae97083	3	2	9	63.97	38369405.00	38369405.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
80caafd9-575c-4739-93f9-48e9f27012b2	8bd1637c-5777-4d1e-9f75-af8b3b697d2a	2	3	9	58.86	40215011.00	40215011.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
abe1531e-4edf-4a13-b011-42cd050bfed8	cac01a6d-5f02-4ba5-adb5-21936498e123	3	3	9	62.03	37221230.00	37221230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2060677c-65c4-436e-a4f9-ee7ff1605c26	daf9d484-9831-44b4-ae0e-f847df370880	2	3	9	37.39	27429430.00	27429430.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
51e653ef-532a-40bd-9cf1-d7a452108567	a661826f-0cc4-49f3-bee3-ad58e17ebc7d	2	3	9	57.72	33661213.00	33661213.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
eb80bc27-fa38-4648-9f63-bec935d0225f	9987b72c-126c-41c6-9f40-141bae068a70	3	3	9	63.42	38057856.00	38057856.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b0912b73-ca90-41ad-96cf-5bee3c56b971	5199bb15-c850-4b70-8a17-a050bf7f703d	2	4	9	58.86	34858751.00	34858751.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7b2a85a1-f009-4a97-b86f-d36348f22e1d	dc6143c1-3b76-42ad-899a-73cc8747199d	3	4	9	62.03	42803930.00	42803930.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
249b06bd-325e-4963-ab84-9a583aa94a4c	cab02e0d-ae7a-44a1-ab19-be5b819cdcc3	2	4	9	57.72	38913733.00	38913733.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4b686c2a-d406-419e-8801-c99409aeab13	bc5ef69b-da88-4bbc-8b1c-93da0784516e	3	4	9	63.42	38057856.00	38057856.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5d633134-f3f5-4684-9d2e-72f851dbe16c	3a450427-5b12-4055-9fdf-4103c02eb4a9	2	5	9	37.32	23474280.00	23474280.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
43e75cd7-3656-4592-a54f-29e595156c7f	f31c8b7d-0c7b-4cee-a0fb-de7b7d972eed	2	5	9	37.39	27429430.00	27429430.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b3581c4e-2ff1-4172-a4a5-5bd2e64ea306	34b456f9-6e01-48a6-b448-be0e387e061f	3	5	9	63.42	38057856.00	38057856.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f7b6541d-a9ea-4288-a6f9-d336cce6e487	11c5d2a4-eb93-4284-99af-00725571652d	2	6	9	58.61	34735751.00	34735751.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
209e19bd-4c8d-4efc-ba86-902ca57d2df8	cf937a6e-111b-46df-9bb5-675dda32078e	3	6	9	62.1	37256230.00	37256230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
01693c5c-9a86-46ac-b135-55b9f85a258e	3a890710-506e-435b-a4bb-f4935de8f6b2	2	6	9	57.73	38919473.00	38919473.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
97e63b52-7412-4b41-9945-619b9cc3bd07	23f3c4fd-d37d-4b9e-bc31-09d9c5abd703	3	6	9	63.27	37982856.00	37982856.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0b942ff6-08ce-46f9-b9de-ba2c89a7ba25	704a8984-2f13-4102-b5a9-a72385486120	2	7	9	58.61	34735751.00	34735751.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c08f9c2c-1b30-4868-8843-4fde89120004	16dcb4ad-cc86-428e-bee6-a774355575e2	3	7	9	62.1	37256230.00	37256230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
beb39a5f-410e-44e5-80e5-72fdf12a26ff	c0b390f4-a495-4b47-a542-5c631c2599e3	2	7	9	57.73	33666043.00	33666043.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
397d155b-49dd-42bd-84ad-60aeb1f0ad08	ab202e38-00ce-4ee5-9b5f-c2746cbf5dea	3	7	9	63.27	37982856.00	37982856.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2c7584db-a271-460c-8e43-49151ef73196	ec5feb87-69f0-4638-9cfd-d9337337dbc9	2	8	9	58.61	34149651.00	34149651.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a6e67d1d-6897-4767-9cd8-9351141bb6de	dbbfa4c5-f05a-487b-a4c6-180413edda69	2	3	9	53.9	38359486.00	38359486.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
47f3b65a-601a-477b-b7d9-e3dcec149ff5	0124a28c-fe97-4db8-a886-831b849fd75c	3	8	9	62.1	36635230.00	36635230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d8048290-8067-42f4-94a6-13a63824e458	241120e0-d4f6-4c5d-affc-376013653bdc	3	8	9	63.27	37350156.00	37350156.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
768d9938-e25c-44d7-8d37-59e1e32b58c8	15a2e933-a193-4fa7-bc34-fbda138b5702	2	9	9	58.61	33856601.00	33856601.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
162a2280-c2b1-4169-a1d0-e751fa8b552e	05fa1ce3-4e6b-47dc-a98f-d52431022d35	3	9	9	62.1	36324730.00	36324730.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a8b02b23-33cb-48ba-b75d-a39036c8472d	aea5b696-2bfb-4498-83b0-e373960bcf39	3	9	9	63.27	37033806.00	37033806.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dd9554eb-21c6-4c6e-8dcf-fe2491efc6a3	1ddcbd91-82a0-43c0-bbed-5d0b7e77f7f7	2	1	9	59.51	36584956.00	36584956.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bdf1bc11-8a29-4509-b093-8d6c316eb4ba	0188c0f5-5454-4cc3-97cd-a124b8d8abfc	2	3	9	47.48	35045097.00	35045097.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6495d77b-4ec2-45e9-9137-7c09809e62b0	7abd4810-6303-4f2c-9925-5be9946e9902	4	7	9	115.98	54394620.00	54394620.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e601a6a3-da61-4ee0-b04f-115fd5ff6cb4	c8719948-8c36-476d-923f-18cd8155ebe6	4	8	9	116.91	60208650.00	60208650.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
41575b5a-4eb7-42d8-929f-446cb19453d4	e684eeae-5b8f-4c13-90d8-1f41a0135b0a	4	9	9	115.98	52654920.00	52654920.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0dcfdcbb-cb76-4157-b375-2822330d670b	eaa10fb5-5fa4-47b7-b445-7ba55edf2771	1	3	9	36.85	27833484.00	27833484.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
81689653-2ddb-49cc-b464-4013eca1e1ea	36f0e2d7-dc04-4eaa-b470-c7374ce04eab	2	3	9	58.04	44157501.00	44157501.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3adf7a12-4eb0-4621-a3da-f860697bd1f7	0a095bbe-593d-4325-b3fc-35f928b60f6d	3	3	9	90.9	54026303.00	54026303.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8ed7e959-c659-4b5a-af14-a5cb829369a4	aa3dda70-11f6-4526-be46-4d7f2b71a40a	2	4	9	58.14	37554427.00	37554427.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a87ae409-9e7f-49ed-8673-9c36e5a2e50d	a28b6343-fefa-4152-a1e5-d6c537d695f9	2	4	9	48.35	32113251.00	32113251.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
02220e25-7ff7-46bd-9e0c-3a250adbb965	ed818e02-b9f2-4644-a7b6-f6a5c3488789	2	4	9	58.27	37554752.00	37554752.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
717ddc75-6817-48ee-8b4c-338933727831	5c70b672-10bb-4b17-9a65-1b2e82078f8f	1	4	9	36.85	27833484.00	27833484.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fafafd2b-68c5-4a00-a069-59d56c8b3092	dc76bd37-45d6-480a-b88f-e2dbb1ca0c97	2	4	9	57.85	37440306.00	37440306.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f1d7285f-05d1-4697-a787-d9ce9d73336a	8e28a68f-dc0b-4aab-af3c-f09a2d33fde2	2	5	9	58.14	37554427.00	37554427.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cf7d9cd2-d538-400b-9c9f-eb1a838182fb	2283f94a-b998-4e5c-882f-5636cbd3a4be	2	5	9	48.35	35739501.00	35739501.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3fe6af7c-572a-4f1b-a778-27795a481e5e	0ec48350-c478-45d8-aaa4-3bcfc8888f26	2	5	9	57.85	37440306.00	37440306.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
88e26e7e-5a57-4399-8c19-4919e45bfeea	b84ef25b-d25c-4fb0-8485-d4e4ff146a07	3	5	9	90.9	54026303.00	54026303.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
41eb9a9a-9d0e-45f1-947b-2942a8c9abc3	dfe832af-fdec-4001-a795-47ccd94e5e73	2	6	9	58.14	37554427.00	37554427.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
78ec2f45-6ebc-4a6f-92be-6dca0a5e0d35	38e2bf78-6206-416c-bcef-818e720920f4	2	4	9	48.67	35885049.00	35885049.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d5713296-2113-443e-bbf3-487a06ce83a0	88e31fe2-a7a0-47e5-b581-c813032a3769	1	6	9	36.85	27833484.00	27833484.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fc51c1cb-5f9c-4316-81b7-d204c3ef94c7	b632d38e-295c-4813-8e45-f5ad5a495fbb	2	6	9	57.85	37440306.00	37440306.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1f8c667a-f3e4-4d51-b096-d26d1f0073c4	aca051a0-fdcc-4c17-8cc6-7e31b025b24e	3	6	9	90.9	54026303.00	54026303.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d52bcb2d-f456-4d47-8642-96571767d412	8d8d35a4-d5c4-4dac-8475-f310bd222e3e	2	7	9	58.14	36973027.00	36973027.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dcfc783f-fc3f-4dd0-9b5a-6a5f0470b374	aad701b5-1fcf-4a3e-bad8-2dec60923afc	2	7	9	48.35	35256001.00	35256001.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c02ae5ff-7a42-4358-b478-655a9b6ee477	a55ba53e-c06a-40c5-b331-fc79931294d5	2	7	9	57.85	36861806.00	36861806.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e752102b-e5d1-47a3-96dc-29e001b250ac	45756f54-ec84-48a6-92fc-f9a3bcef2880	3	7	9	90.9	53117303.00	53117303.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
76e404f4-c00a-4210-b1ba-c704f7ca55d4	561169c5-5aff-41c9-9d95-7fc99060b082	2	8	9	58.14	36973027.00	36973027.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3cc32dab-b776-4e38-9c63-debadaf27043	21044cb4-67a8-47d1-a699-7afbbd9ce724	2	8	9	57.85	36780176.00	36780176.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ec9d7280-c617-4a16-992a-ba2459bcc33c	1070a1b3-9101-4e13-859f-4ab212476982	3	8	9	90.9	52971507.00	52971507.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cb04b325-54a0-42c5-b631-44ed56d03b8e	c9158bcf-ac8b-4dc6-853d-ebaf70c86f8a	2	9	9	58.14	36100927.00	36100927.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4c55b7f0-2190-4d78-ab71-a6485cb6392e	57fc3d78-8163-4c84-9cf4-d64683166cf4	2	9	9	48.35	30936001.00	30936001.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5dd456cc-ae1a-4227-8b70-af3e7ce9d45b	9fe14092-e659-476e-b5b6-5175439842b1	2	9	9	57.85	35912426.00	35912426.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dfc57c52-1bcd-4bdd-9310-69461e03984e	a24eda26-40d6-47c7-945f-a3de8497e22a	3	5	9	62.03	37221230.00	37221230.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1bcf5530-37a7-4eb3-ac3d-1396ae99d568	249fe71f-250f-41ae-9bd6-3c35d9517c47	4	3	9	115.87	64771330.00	64771330.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
51823d4e-dbc8-4425-9f33-867002b456f4	f3499b78-e133-4185-9bcc-7f2da3d98ec9	3	4	9	91.02	56250360.00	56250360.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dd3821b4-324a-4950-afc8-3366fbdf670e	6ccd92f3-9197-4428-a629-5fb7c1e0946f	4	4	9	119.24	62601000.00	62601000.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a7a5fb25-5c85-4ac5-b61c-345c70cd4c75	014bb9d7-aa44-433a-8dbe-85a780d859a4	2	5	9	61.03	41195250.00	41195250.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dde213cb-4666-4b48-912a-acd4d82f65c2	df989793-7e20-480b-ada9-078e5f93ecf2	4	5	9	115.77	64715430.00	64715430.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
324b12be-297c-459c-b29b-18d5809b2c92	55cc7d20-5681-4168-959d-b82b996f920b	3	6	9	90.97	56219460.00	56219460.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
67eb6042-3069-453d-88cd-5710bfb19cd1	9d804154-ff8e-4dd4-9ea5-d2c831569d33	1	4	9	36.94	27922996.00	27922996.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b091e7c9-04e3-4e81-b01c-8fd772cc7213	2fcfaa05-2fe8-4522-a3c9-41b5cf7a84b3	3	8	9	90.97	49123800.00	49123800.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ca70f9f5-f8b0-45a9-ae5a-09ddf5f6fea6	d46d99e8-6c40-4a84-bd66-d75ca6fae03c	2	5	9	58.27	37554752.00	37554752.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7aad3918-8281-4f30-818e-bd4581797fa8	45a48147-503d-444c-9fbe-f7a91ff168d7	2	3	9	57.7	36293300.00	36293300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
97be3913-a4ab-4190-8b6a-11f678dc26f4	391ae1fb-e7c0-41c7-927d-34bbb9a2530e	4	3	9	120.62	60068760.00	60068760.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0ec2aac5-b872-41c9-b1f7-ace64e212eb6	b407e532-a63d-4c1b-bc22-aab223944ffe	2	4	9	61.05	39194100.00	39194100.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
87d72b62-8f36-4fc4-a20d-543416fb3407	ed0c421a-e253-47e8-a53a-9388da6498e8	2	5	9	48.67	32234799.00	32234799.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
75cad8e1-f01c-4992-9e4e-292e9712fa5b	eba543a0-2bf2-47cf-b37c-bf49b13ac545	3	6	9	93.88	53699360.00	53699360.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b1adbd74-be94-40cf-b031-020369d73cb0	99cf78f5-ef5e-4c86-a6c6-387841208cf7	2	6	9	57.55	36198950.00	36198950.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a2b10bda-ad97-4bf3-8f7d-a21b440319c3	fe9aee4c-f4a6-4373-9d3f-733c59333328	4	6	9	120.57	60043860.00	60043860.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c9d0c8c4-9ef4-4f00-82cb-740608847cee	57e0ed1f-311a-4851-9b66-88ae0e1a1bc1	2	8	9	60.91	37276920.00	37276920.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4a431d0d-3246-4121-9890-e1dd4b13ef68	40f75586-0389-4923-944e-d7fc993cfe56	4	8	9	120.52	58813760.00	58813760.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
06235f92-eb33-45cf-84cf-1a89639b42f0	1ed4b757-36ad-4211-bd94-81be9546b80d	4	2	9	120.58	57034340.00	57034340.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7b62f0bd-953b-4a9f-a3a4-04203f41abe1	c1c8a861-3125-4e1b-90b5-727d997b3353	3	3	9	90.55	47629300.00	47629300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5c9e7f99-b60c-44b0-8837-218c114c1da4	8688c7d1-8c8a-4e4d-9306-a5ec94e8f589	2	3	9	57.71	36299590.00	36299590.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d2bfc8f9-fa95-4863-a64d-6218788b779c	67abd829-c7f8-4a7a-afab-88ae272cd466	4	3	9	115.86	55496940.00	55496940.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0399f89b-f881-4542-b900-739d5230299b	88aea696-dc3e-41d1-aff6-1eb9a45f37b9	2	5	9	47.48	35045097.00	35045097.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2dc4b8a8-b874-485f-bf33-3633dc398054	61406038-73c7-4ba6-90dd-87baa39cb722	3	4	9	90.55	47629300.00	47629300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0b44b983-c247-4ab3-9390-564e5d1ea6f7	5e8fc168-1391-4e0d-ac42-108a54a70c56	1	4	9	36.76	24041040.00	24041040.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4426b29c-38aa-4ddf-bcc8-e144e9978847	ea302aa3-5e1f-48f7-980e-0e6256554904	4	4	9	115.86	55496940.00	55496940.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bfd2f7f3-ca58-4128-9b5b-71d82ae8944c	93c47c1a-f91b-4478-8bfd-c3e581e9c5d9	2	5	9	57.71	36299590.00	36299590.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bd15db54-76b6-454f-9466-77d0922f2f40	9b1577ec-2d26-4d4b-999b-4fefea661c56	4	5	9	115.86	64765740.00	64765740.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
56b77e7a-806f-41b2-a508-8740a95130e5	5f8ce67a-3b86-4bc5-8cb3-376da152cbb6	3	6	9	90.55	47629300.00	47629300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fa8a4d9d-d617-4cf8-a758-74059a4144da	b26fd0e0-ac5f-4cec-994a-7403e51b5e54	1	5	9	36.94	27125350.00	27125350.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
ae0baa17-5827-4933-a781-d7daf2e53523	09b1c352-edfa-4e6f-91e7-c1d9201449f3	1	6	9	36.76	24041040.00	24041040.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3a4ffcd1-93c8-4f35-af3d-d5e1bd1e4be5	13b34fdb-d1d2-4eba-aabf-adddf98b68c4	4	6	9	115.86	55496940.00	55496940.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e5a5eb8d-f2f9-478a-a8b9-b60237a113a6	e20c57de-da9d-440e-ad6e-5792e9f6ac00	3	7	9	90.55	47629300.00	47629300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c784792f-ae21-4719-839c-fc2eb6b458a5	3238a7d6-edef-4177-b3e5-0b6b2b6f5100	3	8	9	90.55	46723800.00	46723800.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
264ab5d3-4aba-4689-953f-45ec81fc0f24	d456dd46-7faa-43e6-8e65-2ca11e4950c2	4	8	9	115.86	54338340.00	54338340.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
da6589bd-b529-4b23-9f3d-b961b242c37b	f7cd8a62-ddb6-4a8c-89b2-7a19bb7883cf	3	9	9	90.55	45365550.00	45365550.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
409f1883-9cbc-4f8f-9879-68bccf91e17b	99f7102f-921d-4349-b6c1-6b9189d9cbe1	4	9	9	115.86	52600440.00	52600440.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fd896404-fada-4e1d-a94e-29ad896a9edf	f9e4d8c2-81ca-44ba-93c9-9fe499e52f1d	3	2	9	70.2	40858359.00	40858359.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f316c64b-cc01-416e-bd50-cdb080b519cb	296b9f30-b026-4c40-905e-5e46643f6173	2	6	9	48.67	35885049.00	35885049.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
308a86f9-6cb8-47de-a955-a07d008e20b8	d180f949-8431-48eb-9100-84ba4ea5639e	2	3	9	57.81	37336916.00	37336916.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
3398254d-ad27-4f51-acbe-6ff280901bdb	e9e164c4-1605-4692-bd81-a5178b763561	1	3	9	36.86	27840784.00	27840784.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f3f8b255-41ae-4107-bf69-dc8f2dee052e	393105e4-774d-45fd-b158-dc97ed80ca18	2	3	9	48.34	32926959.00	32926959.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b0075718-fa4f-4370-b2c3-17e86af19f55	11d70184-ef7c-4205-9131-45000d64acc3	2	3	9	58.03	38625461.00	38625461.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
92af52a1-de98-43ca-a5f1-d74dfe84a063	ba7c071b-6521-452b-932a-a10925d3c386	3	4	9	90.75	53788083.00	53788083.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
2c736433-0a40-4af6-917b-69c0650c6e79	041f4ea1-4c3f-4f5d-8f58-1768e2663634	2	4	9	57.81	37336916.00	37336916.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c80ad0dc-8db9-42f9-b5a5-2afb6dcfce67	09ed85cb-5f48-4de1-9789-16a8e1251332	2	4	9	48.34	36552459.00	36552459.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5bcab280-42cd-467b-bc15-953cd872390d	aba7d328-81e9-430a-9185-bb94ffddff63	2	4	9	58.03	38625461.00	38625461.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
af54eabd-0815-439c-a336-71f9016c023b	99188407-796e-464f-9b48-ba493aae5789	3	5	9	90.75	53788083.00	53788083.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c8d59146-d88d-4a1f-9180-3235dd964e2c	4b22f800-1d60-4d36-bdc9-3f350f61b40a	2	5	9	57.81	37336916.00	37336916.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
341a58f8-45f2-47f5-9f5f-439aa4747c85	7bb32857-e735-4f9d-8547-e41cf6472ea8	2	3	9	61.13	41262750.00	41262750.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
7368dd36-f644-41a9-9000-d3417a206baf	e9fb8eaf-f6e8-44a1-adc9-4ee8cc7abec0	2	5	9	58.03	38625461.00	38625461.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
688fabb1-2ed8-4051-a0f2-f0baadcf2648	c8b9d025-c79a-47bf-9fb5-20a850ba95b0	3	6	9	90.75	53788083.00	53788083.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f567a629-2b9e-4830-9a41-6457dff672ef	a81fddea-971e-48ed-ad20-4cdc477b1e3a	2	6	9	57.81	37336916.00	37336916.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a6cdead7-9325-4332-bf33-f3b0bf00bcfc	90bcf79c-60b9-437a-9bd6-af4958125ab8	2	6	9	48.34	36552459.00	36552459.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
14e08efe-3b25-4c97-9128-10f6b0e4ba46	c3699685-3a76-4e7c-9576-0f354fba756f	2	6	9	58.03	38625461.00	38625461.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e5ad5d5c-7d42-4c10-8f78-bd51cbb78a99	6aecc1f1-1371-424f-b645-50cd419d63ae	3	7	9	90.75	52880583.00	52880583.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
88bb5435-372f-4c92-84de-920320e4ee08	7c264c68-dec4-4b9f-b7e7-aa760f145b74	2	6	9	57.84	37354858.00	37354858.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
12bf9542-a23c-4ab5-83d8-1974823895d7	db0ab905-0fc3-4fc3-8b33-338c20b4996c	1	7	9	36.86	27472184.00	27472184.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
11f74df2-0fb7-4b93-8ad6-31649fe6b715	21f3e77f-b42c-43c7-8893-a4d921c93b22	2	7	9	48.34	32443559.00	32443559.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e6b34590-dd5b-4fec-90e2-4da7639ceb78	76fc7552-f94e-43cb-85cb-c08cdd5b5d3e	2	7	9	58.03	38045161.00	38045161.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
d5b31e67-464d-412f-aef5-d2143b9ce0f2	773d67c8-0049-4a70-b46d-82f8db2d2211	3	8	9	90.75	52880583.00	52880583.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cb8a23c8-f9d2-475d-9e73-06e39a477e83	20873544-3b0c-44ce-a530-8018ad4c44a6	2	8	9	57.81	36758816.00	36758816.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
f58e6fb4-6785-4aac-9fc7-e582a120cf90	8a256ab1-a8e9-4432-9ace-8a50f37b9c71	2	8	9	48.34	32443559.00	32443559.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fc1facc8-0182-4556-8001-5f1e7136baa6	1debf60e-49ee-4400-a72b-850182652d1c	1	6	9	36.94	27922996.00	27922996.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
6c140383-06d0-451e-951f-53950d23b686	f8c47282-19f8-4ba3-a2ee-389f12e8ec06	2	7	9	47.48	34570297.00	34570297.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
120d4cf2-976c-4bfd-a468-eea2916a7358	d307db17-1fcc-4439-85cc-e20565aac20c	2	8	9	48.67	31748099.00	31748099.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
14f44ebe-5023-498c-96fc-16f2bf6f9dec	574ad821-9bd3-4bae-b68c-0b95e92c6ce1	2	9	9	48.67	31018049.00	31018049.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e187a610-4a7b-4195-8dff-bd023be3d7d7	39f0bfd0-9691-4b5d-843f-122080a43da4	1	9	9	36.94	26149876.00	26149876.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
29264cbd-1c56-4014-b418-70a3342e9d9f	9eacca2a-5438-40e6-bf9f-d55fd17108bf	3	2	9	70.69	41196410.00	41196410.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8a17a724-eaf4-4a0e-a394-d9fa050525bc	909491c8-2f5a-4054-a928-e25371e946a3	4	3	9	111.32	63341080.00	63341080.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
261b2346-fa71-4244-94d3-3b33398ad04c	adca9bf9-a5d3-4119-86ba-afeb3ff0edbb	2	3	9	51.39	30474270.00	30474270.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
5edf6633-24c2-4993-ae0e-a31b29f731e2	f0160993-411e-4157-a407-ea502e31aaf7	3	3	9	79.43	47816860.00	47816860.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
dedfeb11-3c16-4d15-9059-ec5f7ae16fca	52a4f300-f1f2-4d98-bca9-2b7057697fad	3	3	9	73.89	40122270.00	40122270.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
93e66747-79c8-4ba9-bf49-8f44bcf643dc	5083e8c8-37a7-4ae9-8709-c5dbe9400ab4	4	4	9	111.3	54425700.00	54425700.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1f44c6e8-940c-4055-8027-e9bf53706f96	0ed6c440-e6fd-4781-b0d8-0aba619ab87c	3	4	9	75.03	49144650.00	49144650.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bc592bb4-0e85-4d6c-9f02-d27cf3048980	17a41fe1-2c9c-4c30-baee-479d63f595bb	2	3	9	58.27	37554752.00	37554752.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
44c733b2-5ca6-4006-8489-18120d4416d3	798985dd-90be-4024-a69a-5738e34f67d3	4	5	9	111.32	63341080.00	63341080.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
03e73a52-e32c-4df3-9104-56fe55e83672	388715d6-9717-441e-afcb-05e8d27e12e3	3	5	9	79.43	47816860.00	47816860.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
35fc20bf-c4be-4a16-9d43-97c4a58ee1b3	fb19a591-43ae-4401-bb18-34a40b684056	3	6	9	79.43	42574480.00	42574480.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1e3a3acf-f6d1-4854-af0e-5a4210ba3ea2	97db3511-9a90-4876-8e8b-769eef836125	3	6	9	73.89	44999010.00	44999010.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
4ba99e77-cbbc-4c0c-a2b3-29aff9705115	db01abfb-981a-4454-ab1f-72fe2529905c	2	7	9	51.4	30634400.00	30634400.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
809fb782-8909-4f68-afbb-869f33aaff92	75bece27-ea2e-4521-a5a2-a59f4c3f1994	2	3	9	48.67	32234799.00	32234799.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
8491e195-249a-4d80-b86d-0005635d0c35	688af39a-24c2-4318-aa60-ca96c0698483	3	7	9	79.42	47016640.00	47016640.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
213dee67-395e-4d40-b0bc-0437df313fe9	e534c88e-7f20-443b-b62a-93896a63c88d	3	7	9	74.93	43384470.00	43384470.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b6c59413-4dee-4550-ba51-28847c8e300c	a297aad0-67bd-4e44-8e5b-23631df271a3	4	8	9	111.32	62227880.00	62227880.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
aaab9ede-3d45-4521-99ec-a6c31e5e5df3	ba3da086-116b-4337-b34a-ca9f7c70a494	3	8	9	79.43	41780180.00	41780180.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
1db4046e-cffc-4a58-b481-119118ddc6e4	a7334783-2878-47bc-a89d-cb252c5b24e7	3	9	9	79.43	40588730.00	40588730.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
198a2384-3a9d-4705-af05-0a704a18abf6	63ea7e16-7e02-4be0-9bff-71fe5396fb94	3	9	9	73.89	38275020.00	38275020.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
080b7cfa-acb6-442e-acb4-7acb62438baf	725f5539-99aa-4c46-a3c6-fde6e48ea9f2	4	2	9	116.98	53576840.00	53576840.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
911688bc-abe4-4acd-b2e5-75842049ec12	87c0918f-99d1-44ab-a0d5-87dc5e468939	3	3	9	90.81	53941140.00	53941140.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e7d8d547-a3f5-453a-98d9-c7a73a91d798	a0294358-f4f1-4c5e-a1a8-873467a7630f	2	3	9	58	33408000.00	33408000.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
73e0be7e-51e6-46ec-a0b1-fcb515a733ab	06f0c0e2-36e4-4107-9dd9-ca18e1a08bef	1	3	9	36.91	24139140.00	24139140.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e482c9bd-2100-41b6-ae5c-e4a1ac52f082	85551f31-cb87-4f9d-9a76-421641429733	4	3	9	115.98	55554420.00	55554420.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b1dc6fd2-44d4-46a0-9ac3-0586fcb4df2e	0f11f22e-ea62-4bfe-9ac6-a7cd63f26ebc	3	4	9	90.85	47787100.00	47787100.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
deafd508-4002-4ab6-8a99-874b6e13f26e	31e4eb99-0bd2-48c9-b070-5001724e513c	2	4	9	57.83	36375070.00	36375070.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
215219c6-3e16-4bce-915b-924b783e78c5	a7764060-50a3-43fb-93c1-d0bf0fa68fca	4	4	9	117.16	70881800.00	70881800.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
0e001377-5188-4f27-82fd-6a1263c8eb93	6beae917-fb87-465c-873d-ef2f58ae9c2a	3	5	9	90.81	53941140.00	53941140.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
345e94e7-237d-45ae-ba3a-e4b6ce835cf7	4dd4f0d9-c556-408f-8a03-321d8ae8a926	3	6	9	90.71	47713460.00	47713460.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
abbec1df-a47e-43cc-948a-7281e1003b7d	5adba977-300f-43c1-ac61-5346a97c55c2	2	6	9	57.69	36287010.00	36287010.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a4e9cab8-2df5-447c-bb9e-36e5c81b414b	81239fb9-88ff-408a-9b48-7a0d9040d256	2	5	9	48.34	32926959.00	32926959.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
cfc8da2d-2e1b-4beb-8de6-cb3b2d5225d5	98c3566a-1127-11ef-a82d-001dd8b72708	3	2	20	112.56	123816000.00	123816000.00		2026-01-22	t	f0c58e39-e18a-40d3-8a52-a7cec336f928
db5fce21-0e65-4c1e-b9d5-44a2db3deb0d	56e707eb-0248-11ef-a82d-001dd8b72708	4	4	12	126.51	98677800.00	98677800.00		2025-10-03	t	acb24dbf-75de-46bd-92d9-60ba8e280339
2f0b4b13-f2dd-45f1-8f08-a60591406a79	77fe39e2-72a4-445f-b084-3cae8be15562	4	4	18	159.18	156951480.00	156951480.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
b96bc7ff-1804-4ef9-90b7-a13613b72098	1741cd58-0c2a-49af-9cf8-1eecd832bb28	3	2	9	76.89	49595145.00	49595145.00		2026-11-14	t	c8a207af-dffd-4e8f-b235-8ddbe42f6cc5
9f437b96-075b-4fbb-a3d3-0ddc96e185ec	3d0e7636-d187-4296-a379-80258e6de569	4	9	12	114.1	61956300.00	61956300.00		2026-08-28	t	7491ac46-0f86-48f8-98b3-eb5ab5ce6e73
0461cc27-de59-4b3f-b642-ad2131969cfe	d5204377-8b7a-404f-adb2-71a65aa6b6b4	3	8	9	68.52	61736520.00	61736520.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
49a68b71-d372-41fb-b23a-81c628456bfd	84e7dfd7-eff3-451d-8b91-026f3e916e7f	2	10	12	65.42	57046240.00	57046240.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
074c5a04-d0f0-4d3a-a6c5-fd2c566756d7	0deee921-1e39-4552-8681-ce289ea1c7bf	3	3	9	79.16	72678576.00	72678576.00		2027-05-21	t	d0f283d8-4977-4277-a4e9-47c56f59d780
8791e437-fffd-487c-b715-7e766771f112	f273237a-3f52-4e2c-8c9b-ff8d08f50525	4	2	9	107.58	56479500.00	56479500.00		2026-07-24	t	37877142-0d66-4025-b07e-db8ce1d1cb9b
caf9f1de-54a9-48b1-862e-358971e96a83	95212820-7740-4808-b170-11e8f1f2db28	3	6	14	79.76	50248800.00	50248800.00		2026-12-19	t	94c6cbb6-a76a-4d35-a29a-f74b3d3df4f7
b33cc337-ee9a-42a7-afa4-f7527c74971a	3a900175-4556-43e0-83b9-d9ed95b178ba	4	4	12	115.85	62559000.00	62559000.00		2027-04-23	t	268f202a-ef1a-4263-81d4-cfa593722772
37ec87fa-7bf1-4462-b485-f4bd510f7dc8	4f04764f-68dc-11ee-a82a-001dd8b72708	3	4	8	125.49	140925270.00	140925270.00		2026-12-25	t	efb1d717-725c-4541-92ab-62173f6aebf9
d7aee4b1-2dc5-46f3-9410-07a4f7b09a21	a3212be6-73ee-4099-8ff2-152d9af727ec	4	7	9	126.96	98520960.00	98520960.00		2026-10-30	t	f1cbcfb6-5728-48b0-b8c3-958f0a9bf455
ba617e4b-7eb1-4ecf-862c-43aa52783604	6df94caf-2ddc-4313-9877-7deba15116e2	1	4	9	35.63	29359120.00	29359120.00		2026-08-14	t	ab56f36d-cc97-46bc-ac64-9a7ecee9da0a
966f9488-3d52-4651-bd22-e722c20a19dc	2aafeb2e-e986-4626-88fd-27c527cf4ba3	3	11	14	116.16	95018880.00	95018880.00		2027-06-25	t	3392e766-0500-4503-958a-4e8781bba820
89e357a7-7df9-46e1-891e-b2920452a765	7b1620a1-0f09-44cc-bd7e-11afe5d9bc50	3	2	9	86.98	48773309.00	48773309.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
b3c17642-36fc-48f4-bd05-1b38c3e7bd67	4b95cd95-2190-4ff9-a84c-73c306d4d1bf	4	4	9	110.13	68280600.00	68280600.00		2026-07-24	t	8be56884-79ce-4504-8ba2-5c2f1189b939
c5708b22-12a3-42a0-b4e9-7053254f67ba	def670c4-fd95-4f75-b4c4-1219ba99e95b	2	6	9	37.31	27417013.00	27417013.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
76032bf8-b8ce-45a8-b3b1-10c6cea152fc	8de977b6-0984-45a1-9220-7668b8e125a1	4	7	9	87.42	50703600.00	50703600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
c2a84f07-549c-4e6e-a34e-bb82ec0a04f6	2e9ecdaa-16bd-4e2c-8493-f438c0436c0d	2	3	9	57.68	29993600.00	29993600.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
e0869e1c-a658-4e40-beea-0cc4372fe636	c5ec8d46-2931-496f-b96b-fa43cd230708	3	5	9	62.05	31707550.00	31707550.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
733f391a-94eb-4d15-b264-67cc24100a5b	b71e5071-b0bc-4ad8-9682-a447a8956166	2	6	9	53.72	33342313.00	33342313.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
57d5f1c8-fcb9-4b67-82b1-b4d059ec017a	f6d02ad9-7caf-48f3-9b3d-8f2c9b800024	2	5	9	58.86	40215011.00	40215011.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
fca01799-166d-42d4-b9da-61a2e113c445	28aa2592-e87c-4fc0-a98a-230b0acce2ee	2	8	9	57.73	33088743.00	33088743.00		2026-12-04	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
38cd649b-30bd-4811-a077-0da56433728e	a9bd2a10-3a9b-4aed-8a5f-3fc058a718a9	3	3	9	90.56	47634560.00	47634560.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
666bf5f8-8bcd-4630-8428-f5dfce4791ea	c8b64736-1ad0-42ba-889d-b4acb787ad05	4	5	9	120.62	69718360.00	69718360.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
73cad292-21ce-4a73-b58a-a57a6bf8dc02	8be40336-c8b5-4840-bb3d-d178760efc7a	1	5	9	36.86	27840784.00	27840784.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
bb7ad43f-9da9-4105-a1a1-2b443642d231	26057efe-dfdd-4fa2-bb44-e9bfe6802573	3	9	9	90.59	51431642.00	51431642.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
16dc56bb-7e39-480f-9f5f-0c080bfb3aef	e706c424-11aa-489b-b0ca-61ffae9c4142	4	6	9	116.86	70700300.00	70700300.00		2027-02-05	t	fbf997d1-e5a3-4e4d-ad80-3b6f6e9a6392
a54764df-367e-4dcb-a2b8-3cbb5c259454	7555e6fb-4002-4c7c-b014-ec4050c2f5bb	3	10	20	78.64	96176720.00	96176720.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
3c170764-566a-4d88-8bac-61df84d25ba0	ee9921ea-f973-49a7-9cf7-0c2f7d5fac09	5	11	20	160.63	162557560.00	162557560.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a1ffaeb2-44a8-4935-930b-f2dc04fcaab6	a694d183-540a-4fa7-8e2c-4e6d54424e29	4	11	20	134.64	148104000.00	148104000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0b1f3365-9c7e-43b8-9874-d53bd6b5451e	a1aee320-2316-4c8c-ab48-5a5fdc464d55	3	12	20	78.64	96176720.00	96176720.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
109ad46a-59ad-4915-8beb-b33c2ec480aa	ec2b372b-9bbf-411e-b36d-7121341a62da	5	14	20	160.63	174283550.00	174283550.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
7ab38ab7-db57-4fb3-972b-a41ce0477a99	77a45619-4910-4703-a334-b635796fe59c	3	14	20	78.64	93345680.00	93345680.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
67354012-5d1f-47f2-bb7c-7b6583b4f3ed	3ee1e967-6bde-415f-8e5f-02ee26cf84ef	3	15	20	78.64	93109760.00	93109760.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
00ea3e05-139b-43b0-95d0-f95af1a2403e	dc8e423e-61ea-469a-ace6-79f4b37d5470	3	16	20	105.17	124941960.00	124941960.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
36583adf-e73a-4e9a-89bc-1c8055a5e2a0	80e427e3-8e0c-4978-8b7c-6d8db725c2d5	3	16	20	78.64	93109760.00	93109760.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
8f8b7e29-eb2a-4f65-987f-c87dba5e33b4	e634adf9-e8ae-4e06-ba3d-07e783d102b5	5	18	20	160.63	164645750.00	164645750.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
c26b0442-6962-40d3-83ff-3fab88f029f6	26f53e67-a9a4-4a33-9703-24d1bba944d9	4	18	20	134.64	142314480.00	142314480.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
31fefbce-adbe-44de-9e86-2d3e77864e8d	42d91d02-1162-4f56-b985-8f40765f4ffb	5	19	20	160.42	164430500.00	164430500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
04030adf-9a14-4477-9815-008f6a592e54	d80741b5-57f6-48c7-8574-9d7577b72249	4	19	20	131.9	139814000.00	139814000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
43fcbedd-35d6-469c-82ad-07e66883cae0	a10a3fdc-be98-422c-980a-9217863e3f35	4	5	18	159.18	157429020.00	157429020.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d38bcf9d-c030-49b5-9964-2170b521f3fb	785231b1-d8c2-4854-ba08-1d5b586861ce	2	5	18	77.46	86522820.00	86522820.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
9276b1d1-fd63-4321-9683-9cba1e5eea6e	dc369707-4c3f-4d28-b99f-a599fab7c0b4	4	6	18	134.25	152105250.00	152105250.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
2b4c84ca-9bb2-4449-b571-07b490a5e2ac	cd57b669-2a14-4a03-8d3d-4149d5d2a664	4	6	18	159.18	157429020.00	157429020.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
9d2210de-d9f1-43a2-a9da-1bd2fdd32f08	9f869d29-bdf2-4b89-a7a2-28c4706e2c35	2	6	18	77.46	86832660.00	86832660.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
647b254f-5377-40e6-9cbe-b480a9f25e3b	fb4f6546-2ee4-4854-927f-9964eedbce90	4	7	18	159.18	157429020.00	157429020.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
44a68b44-58d1-4446-9d3c-ee3b89b165d2	2e4608bb-ca21-46ff-8eb8-479a862390ad	2	7	18	77.46	86367900.00	86367900.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a4ee6f24-30db-49ef-ad2c-e3e26982393b	b4f49e2a-e3bf-46f9-b236-6e4fd6243d45	4	8	18	159.18	167139000.00	167139000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
151b53fe-802d-4f95-a14e-69a88fa5f0bc	39a43ac1-b111-45b1-af1e-b50f992eecc3	2	8	18	77.46	86677740.00	86677740.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
70621847-9943-4c1d-ac5e-77c539def3e4	5686742b-3e8d-4b2e-8213-e072a6ef6333	4	9	18	159.18	158065740.00	158065740.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
67892b58-bc5a-4f44-afa7-e8e6c22f34df	4916677b-0e4d-4f94-8a95-bbfef6537912	3	9	18	107.25	115186500.00	115186500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0b96896f-5794-482a-8660-1750ca30c3a1	8350ada3-9595-43da-9b11-77aaaca8acae	4	10	18	159.18	158065740.00	158065740.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
ee3bca88-c22d-41af-8f7d-f1e728c37289	4e80965f-327c-435b-8343-d5cc23a9fb8c	2	10	18	77.46	87142500.00	87142500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
7b30141d-827e-4b25-b9e3-6c8d75ba8324	f0e2ef27-d68c-40f8-82ac-047e9a07ab84	4	11	18	159.18	167139000.00	167139000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
e4cce8d0-6f93-4c49-8391-31f59b054953	7afc3777-85b3-4277-875c-78c2ddf2f900	4	12	18	159.18	158065740.00	158065740.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
e6743a5b-edb0-499a-b23d-11d96c71ab3f	4dc06970-da81-4538-9f5e-0465ab827466	2	12	18	77.46	87142500.00	87142500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
2e62dc93-d265-43fa-8240-999504898074	f84ff110-8024-462a-ac0a-b83cc0916cc8	3	13	18	107.25	114543000.00	114543000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
7c117af5-b76c-42c5-a881-3e2835431866	6c8c2a97-834f-4703-8bdc-2b3ecbf16858	3	16	18	107.25	120763500.00	120763500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
bc76d152-d8c4-4ff8-90d0-1379c3c08a7f	a3e59601-efb8-427e-9774-32666b5e9051	4	17	18	134.25	144721500.00	144721500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d22806df-33f9-44e1-892d-5ce209233e7f	8c43d1d2-03ba-4cf0-bcf6-876e24f9a466	3	4	20	105.17	128833250.00	128833250.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
8fd5e1cc-580e-48d4-bca7-be7fbcd3a699	40a20cef-6694-4dba-a073-722b3ce0de05	5	4	20	160.63	161433150.00	161433150.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
e0ce4245-6c6f-4506-a843-14f0771a967f	4a168255-0141-48d3-a680-8753bfd81175	5	6	20	160.63	173641030.00	173641030.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
910b909b-bb2a-40e8-b91e-4325befb8f8d	f7ca8186-0826-4475-8ba2-3ded5db1c3ed	3	6	20	78.64	96491280.00	96491280.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d5eb8081-16ef-42b1-8982-17993aca7819	86c36907-f6b1-4f74-96af-4c17789512f7	3	7	20	105.17	125783320.00	125783320.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
71dc295c-b08d-4898-a2b3-c4d4caaafdef	5671103e-aac1-4761-85a2-9cb4483990a6	4	7	20	134.64	148104000.00	148104000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
bb530036-e813-425e-9f01-282879ca60f1	2df7cc2d-fab0-4d91-a19b-ee0e00270b78	3	8	20	78.64	96491280.00	96491280.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
007ae549-525f-4fbe-ad3e-15836e3545fd	3b936ba2-b5e2-4b6e-a42f-8087571978b5	5	9	20	160.63	174283550.00	174283550.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
110305e0-8694-4f19-95bd-6328e7f0aa42	acd73a8b-4a12-4100-809d-ed9ea8f4c16c	5	2	7	201.21	227970930.00	227970930.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
7181b29e-abb7-45b4-aca4-24756e209431	3b005c8e-5472-4426-a8d9-88fb27b081c7	4	2	7	186.55	215651800.00	215651800.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
cf99abe2-8d8d-46ac-a398-503fedbcfa0a	3a7a616d-1a97-4968-bbec-d279a98b92fd	4	3	7	187.59	218542350.00	218542350.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
c2eab105-b7f3-4bb8-9f87-52ee5283e74f	98765b63-d028-4ab9-b7ad-ef2983c9373f	4	4	7	187.59	256623120.00	256623120.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d5beb8a1-e3e6-4f97-ab0a-e0939a4d9641	485b2a46-9d2c-4fd3-b45a-c9a0524002f1	4	6	7	187.58	220406500.00	220406500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
cef2bcd5-5a5b-4344-8ace-40cef5169bdc	64b3f511-8db5-4f99-986a-8c44537cdef3	5	7	7	212.61	272778630.00	272778630.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
89513e7d-cf35-4349-8b15-a78955b545ca	91bb964a-d632-4ee8-bf23-0c2afa6016be	4	2	9	125.69	143286600.00	143286600.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
fb5ea578-bbd2-420b-b0ea-173996fbfbe1	a977e1d5-70ab-40da-ab8e-dea3148013b6	3	2	9	85.45	106641600.00	106641600.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
36488bf8-2da7-4a03-98b0-9292800d5349	836475e1-89e4-4ce2-8ff8-b8e24d58478e	4	3	9	156.09	210409320.00	210409320.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
ab0d04c7-98f8-49b6-a81b-9a066f31f033	1e4d205c-cea3-4111-95d0-033713b4f5cf	3	3	9	84.32	106411840.00	106411840.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
4ad4c5d3-adce-4be9-95c1-9f4560855b90	f2954878-df57-4bef-aa1e-3ec3c13acb48	3	4	9	84.37	122589610.00	122589610.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0a41cb6d-3d63-45b1-bdad-fbafe8dfe033	4a5e3562-0277-499f-85ce-0d31f5466da7	4	4	9	156.22	181996300.00	181996300.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a1b04200-fef0-4c8d-801e-e7a545cc90d2	7b85642f-18e2-4ec9-844c-da70680eb5c4	4	5	9	155.71	182647830.00	182647830.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
2dd3c2e0-baeb-4baf-887c-0db5bc9f264d	fda5fd4d-15c3-4d93-a173-f6e5c554cf25	3	5	9	84.37	107318640.00	107318640.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
8b96cd9f-8fea-4bbb-9bae-0fa43329dbbd	0f387f02-80e4-4c62-8d65-87f364d75bcb	4	5	9	154.75	211388500.00	211388500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
1a1206e6-4d28-4de0-a1e2-5206f457025c	eea9dcc3-d01a-4a65-9b3b-e2133cf0aacf	4	6	9	155.71	182647830.00	182647830.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
35edcae1-b490-490e-af40-dbcb35a5121f	27ec2295-0255-4625-a64c-c0627d07e382	3	6	9	84.37	123433310.00	123433310.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0f44d675-e11d-479b-8716-4610d6e1a91d	ce8187bc-d131-427b-a7f2-80e8112be9a9	4	6	9	155.02	181373400.00	181373400.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
6b72bbca-f2af-4b9a-a7c9-6e91c8334dcc	86dc093e-d6b9-4a26-84d3-69e105804b6f	4	7	9	155.71	213789830.00	213789830.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
f0d0f9ec-466a-48b5-9215-cf46a2d239ef	8ce6b38d-d1a7-4dff-ac7b-582dafe607e6	3	7	9	84.37	107318640.00	107318640.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a697d7e3-e883-49ae-b0bb-b2552f655117	9d611063-3ef6-4e29-94c0-47e687de32ad	4	7	9	155.02	181373400.00	181373400.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
9597687c-2081-4c36-8290-f89545c6c42d	082ba8af-51dd-4706-92bc-4df5dae206c5	3	8	9	84.37	123180200.00	123180200.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
94838e73-50d3-4632-9755-48d7a52d6c2a	bff4e273-09f4-4ca3-8363-19133825fcd6	4	8	9	154.74	181819500.00	181819500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
3e6a06cf-b3e3-4184-8799-8b1f55d10943	63e31d56-455a-418b-9bd3-b8d062eed84b	4	9	9	154.91	181244700.00	181244700.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
85f9f431-1653-43e3-aafc-9c41a55e6c43	6944df12-6aa9-4fe8-8d17-f2ac63831512	3	9	9	84.37	107065530.00	107065530.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
f7da3205-e800-4c2c-aaa1-e43caa266d86	706a768a-c20a-4c1d-8c94-926c18825d73	4	9	9	155.92	186324400.00	186324400.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a58a8251-a66a-403a-bc4f-ea9ab784aba2	1075f10b-7131-4832-b612-e195ff980300	3	2	7	121.01	146664120.00	146664120.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
81aa1d65-a5aa-40b4-99c8-e18b27a08e0f	0ba16370-7a83-479c-bcc0-34f58c87ad37	5	2	7	241.34	283574500.00	283574500.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d5ac35eb-d668-4129-881d-1d199a436b29	cafb20f7-56fe-40e1-b6c6-dde8eb4312d0	5	3	7	239	283932000.00	283932000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
215ca16b-516c-4aa9-906a-cb7bfb8ce13c	c6c76490-cf50-4cf1-8154-04489ff8eccf	4	4	7	175.94	241213740.00	241213740.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
fa1effa0-9066-402c-9e3d-e6a66ff6a468	3794c711-148a-4ab4-af80-067edea4571a	4	5	7	175.94	207257320.00	207257320.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
3cf71391-dcbf-44af-9c5b-c75e656d6dc0	2ae9b060-d1cc-4118-9d3a-abee96046191	5	5	7	239	323367000.00	323367000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
199c74b1-ab64-4b77-a81c-28dd46d9dc82	32633151-5363-43e2-b488-7d08d0a44907	4	6	7	175.94	207257320.00	207257320.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0fef1702-a9ab-486f-a0e5-da2201f85552	ff12f84d-e218-4655-b289-667d2401caae	4	7	7	175.94	207257320.00	207257320.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
2915c31a-8f60-4ccb-9264-0c94777625f0	a8ba64d2-46f2-43ff-8282-af3fd347c180	3	2	9	132.94	158065660.00	158065660.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
c697ae9d-39de-45aa-b1b4-70b7a0473f0a	45f58161-3e1c-4bd6-a3df-e71cbe76cf35	3	2	9	109.15	128251250.00	128251250.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0576d1cf-e9f9-43a2-bfe7-aa0d945f3bd1	1159e20f-66a1-4247-8549-84fb3010584c	3	3	9	132.29	159144870.00	159144870.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
7166c6d7-3678-4586-93a9-6e9d7cd9e85f	f975c33d-320c-41c5-9b8c-2b3547c29c8a	4	3	9	146.03	171731280.00	171731280.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
ea7dfd2a-c02f-4ff3-9ef9-69f4d4fe6461	89eadc5f-ac93-4580-9e7b-f954520866a6	3	4	9	132.29	186925770.00	186925770.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
a7940ee0-66cf-4822-b483-6421ee89081b	c739e49c-0819-40b3-9203-4f1c09ee105f	4	4	9	146.03	173921730.00	173921730.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
543cd523-251c-4d20-b755-c0796f72bd82	38b16325-11aa-4a1b-9c17-8e214e928226	3	5	9	132.29	160467770.00	160467770.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
252401e3-230d-43e6-a9d1-959a8ef65627	5b4b4c72-c3a7-4551-827c-ba46c1a82b54	4	5	9	146.03	204149940.00	204149940.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
2696b426-bdc6-4b4d-b408-6af4fbdbfd10	af29d73d-fd9c-4f2d-9547-0f40809c35a6	3	6	9	132.29	188248670.00	188248670.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
d94427ae-4f4a-48b3-a5f0-713ee07ed20f	2360976c-833d-4613-a88b-2ea4603a7c89	4	6	9	146.03	174943940.00	174943940.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
694fe890-de9a-4701-acd0-fc293ec6b68b	36c4094b-feca-469c-8046-3e64d96d82cf	4	7	9	146.03	174943940.00	174943940.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
c1ee47e7-ad84-4ad8-a041-6cb8a0fe8a47	3b26cf79-cb2f-403a-beaa-590f4833be02	3	8	9	132.29	160070900.00	160070900.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
8a8d2f34-406b-46a4-adb8-71b4f11b2f53	5a6a81a9-1cd1-42c0-a9b1-53806d55fa3f	4	8	9	146.03	174505850.00	174505850.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
0eb4c381-2a86-4c8e-8dec-98ad2e54c6e9	4cd224d4-16af-4724-9878-5cb406ca641b	3	9	9	133.14	161099400.00	161099400.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
df1fe2ae-9fc2-4662-b2e6-ccb6865d4cc5	1eabf65f-d267-4a98-a51a-89d6b0f9559f	4	9	9	146.07	174553650.00	174553650.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
e7a665db-01bd-469a-b21f-5ceed9fce57f	e58f0ef5-e056-4446-b594-0d15d9a70a8c	4	10	12	124.71	106627050.00	106627050.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
9a5c02a5-8e32-47f5-9654-77c5374146c1	3bb194e9-ac78-4d86-9ea8-4b00d7e319ce	4	12	12	124.71	106128210.00	106128210.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
c185c592-f4c4-4025-91d4-f5bd11b8bcf1	88abda04-64ce-42ac-83c6-641f8d6dd0cf	3	2	12	98.2	75024800.00	75024800.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
5a640df7-f2c8-4443-a69f-642cf4b047e2	ddbfa660-f3c3-4bc3-ab5d-eee9044d4710	2	2	12	74.68	59893360.00	59893360.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
a0987b22-f1e4-4596-9fd4-07f5b8e874ac	dcabab96-f137-4e29-b3a5-bae570269f97	3	3	12	98.16	77939040.00	77939040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
f179d3d4-c0fb-41d4-8211-e5ae9a51e707	79d6977d-b09e-4daf-85fb-dbf8b4e5ea9c	3	4	12	98.16	79509600.00	79509600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
eadd07fe-26c8-4e5c-99aa-1b911c926570	342b4696-6211-41f2-b112-98b5b86af260	3	5	12	98.16	78920640.00	78920640.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
c9e5759f-f3a0-46e5-938b-4a92ad103d3f	3641ad59-7fcf-44f9-9464-3d7e131baf9b	2	5	12	65.08	60524400.00	60524400.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
63fc7b9f-7f9d-4b77-9e83-d8c2db0b2194	ef2a7e15-5af1-469a-86cb-e747ad79fc0b	4	5	12	140.56	120881600.00	120881600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
3e37a517-317e-485e-8916-7e8ce98ec2dd	2ce526b6-d5a8-4dc6-bd1c-b8e8b9e559f2	3	8	12	98.16	77939040.00	77939040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
e4e687c6-6fb2-4e1b-bbd9-a4cfbb4ab1b0	153d0094-31e1-4590-a748-93022f4d4672	3	9	12	98.16	77939040.00	77939040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
a59aff29-6999-4030-a3f7-fb3f394fb062	9f622576-3558-4bfb-a0b6-27ac2bc51aed	3	11	12	98.16	76957440.00	76957440.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
dfad48ac-6fa2-4ed4-91b1-2ad58e524225	9d0555ad-3961-41ff-9615-286ee8195de4	2	2	9	80.66	65253940.00	65253940.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
6b5d151a-4d9b-4c9a-8a40-0cb0ce2438af	d2820c4e-531e-4ea3-9195-0e8f344b45ae	4	2	9	140.81	112929620.00	112929620.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
92df25fd-811d-4976-a713-6d98e4ed5720	1b2478c1-274d-4dd0-a30a-29b5175311c8	3	5	12	109.35	96446700.00	96446700.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
1f2e83b1-91c6-4ec6-b6ab-c86c9cf6b7ca	367e6986-84fe-4f95-8635-d76e7429db8f	4	6	12	140.56	124536160.00	124536160.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
b36c2ae5-0e2e-4b80-8370-75cd23dc301c	5e21b1b5-5b64-4e6d-addd-e56ed35bdd80	1	2	12	47.96	39375160.00	39375160.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
e652b928-b3ab-4b6f-89e1-2697c58e4d5a	261123bf-a382-4585-8dda-ba5a785c76a8	2	2	12	73.14	59535960.00	59535960.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
fbbfa397-fae2-445f-9fa1-427f77f67227	bd5de676-9fd5-47a7-9c9d-4a2644cec638	3	2	12	77.23	67499020.00	67499020.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
3022ccd7-2dc3-4040-a805-3b67fed77b49	cad6dbf5-638a-40e4-9bc1-41bcea20ee3f	2	3	12	72.27	63958950.00	63958950.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
7e55c874-2929-4187-bfeb-fc3f311bda9e	07a03f99-dbe8-449c-b49d-9b9f4d1d6fed	2	3	12	67.3	63262000.00	63262000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
d9089482-c521-4054-8b22-b8915dc4ac00	c4db4433-538b-42a3-a7de-65074e32be54	2	6	12	69.44	65065280.00	65065280.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
c6ba7aa4-0a8c-4fd3-a512-5670a2208aa7	5bcdb3ee-46b3-4394-b39e-3ac184190b18	2	5	12	72.27	62874900.00	62874900.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
4bd40842-0975-4ac7-9f23-7f8bf8906ee0	706d534e-1943-42a4-bcaa-22346e113c20	1	2	12	43.3	40875200.00	40875200.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
b1717d6b-31a4-4b77-a48f-06515c2a6eda	a3fd90ff-724c-4c0c-b1a8-8941d758da30	3	6	12	109.35	95243850.00	95243850.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
d54f47c3-3f6d-4dd2-bb60-0044371e3a76	4996ef71-a72f-45d9-911a-11aa38fb648d	1	7	12	43.32	41760480.00	41760480.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
ef0dede5-8715-45e6-acdf-ccc990f9b02c	2f04c031-ddf0-40fc-9ea9-76ec3fcd38d6	3	12	12	75.75	65826750.00	65826750.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
643c03ed-7eb9-4099-8148-58e6f709b9f9	a9a2de80-7689-495b-86c7-41ec4a6c80e3	3	2	9	109.27	80422720.00	80422720.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
70ecb182-86b8-4216-824a-f9ff618620bf	08c0f9f4-780b-41dc-a5c0-cdf96b4f084b	4	2	9	144.86	111831920.00	111831920.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
697ee0f3-7df7-4b17-9927-ded7591457c8	12c0b332-b8cb-4f18-b6c4-72523149b318	3	7	12	109.35	95243850.00	95243850.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
51a6e751-d8ec-4e9c-87f7-1e50e8a34af9	284fb822-6e63-4d67-a59f-44547f7c61f3	2	3	9	73.51	62336480.00	62336480.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
e663fe96-e0a2-4477-821d-c1f93182cac3	02c97d79-9a0e-457c-8fa2-50ccb6d068e1	2	2	16	59.99	55250790.00	55250790.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
08c4db29-85a2-4ab8-810b-6a86949d0433	82972760-4b1a-48c7-a562-5a91ba9a650a	3	2	16	118.87	96760180.00	96760180.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
3f729f6e-f180-45fe-a8fb-524a2ba03e65	a1102cdd-ff6c-4ad4-9c44-b03ef6d351f3	4	3	16	146.32	138272400.00	138272400.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
31c407ef-9f76-4d6c-aeaf-c08c71885ae2	a01ae050-f4d2-4d2b-8dd2-25b5144e2971	2	3	16	66.7	62231100.00	62231100.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
b3632b84-ee26-41e1-9f7d-6f2538565204	234f9d83-7e3f-4660-a1fe-6e3c60132642	2	3	16	59.03	57200070.00	57200070.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
2b4febd9-8891-4f24-a15c-48e64ebe1902	09bdca59-87db-4778-a3bb-c99cc99b6dad	3	3	16	116.69	104204170.00	104204170.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
57c77c66-eea5-4627-9026-bbc923e3cce3	6b070487-be28-44fa-b8d9-aa38ef43a5cd	3	4	16	116.69	104204170.00	104204170.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
701eb6d9-4199-4c6b-95ba-fb313af169c2	db6bbde7-2bab-4fc7-ae9d-81e3e508b550	2	6	16	66.7	61364000.00	61364000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
549af748-c592-490b-9823-71a0bae5979b	8ab74bc6-475b-4f02-9713-396f60d93c24	4	7	16	149.67	140240790.00	140240790.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
ce57b8e5-b223-46a0-ba2d-3a7497bae5fe	2b268301-d4e1-4e44-aba8-10ed53617c45	2	10	16	59.25	56820750.00	56820750.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
8218eafa-ea0c-4ab1-87d8-1d3f09b143a1	c37c9302-67f5-42e1-933a-d1cda34b89db	2	13	16	66.85	61702550.00	61702550.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
4d47e198-e9bf-4666-89ca-f87c8f043065	513149b9-788a-4bda-aeaa-1dcaaa927a56	2	13	16	59.25	56820750.00	56820750.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f9ec1140-3808-4755-be0a-422f3e9d1e3c	e7a5ce40-31ec-4b89-a50d-60854759f812	2	14	16	66.85	61702550.00	61702550.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
9895dbe2-f705-47f6-a658-1e87ed561c53	c35fed84-e021-4484-af20-4ef2679cdb8d	2	15	16	59.25	56228250.00	56228250.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
dccf74e5-2f82-407d-9d30-32dda34e5371	a13a5f6e-24c9-49b1-ab62-d3658a0e1a72	3	15	16	117.34	105371320.00	105371320.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
b9efc385-d056-43cc-bec7-ad25c5efafce	1cdd3934-e8b2-498d-b0da-f0226a273a97	4	8	9	144.9	128961000.00	128961000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
960deeae-bae3-4dd0-8369-c228064a9732	6f42cf8f-727a-48e7-bbc8-c4fe39c96505	1	8	12	43.32	41847120.00	41847120.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
6d6a522d-0ff5-427a-a0ba-93bfa62aabb6	4dee10a8-c498-4c81-a413-e080dbc8d56f	2	8	9	73.51	62336480.00	62336480.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
36354076-e179-44f3-8515-92ebf2ae3220	9d47a8a3-e9e9-43f6-9006-c0c8e8071c7a	2	9	9	52.4	44749600.00	44749600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
a64ca8e1-e7eb-471d-9f17-deaa64dde9bd	a12caffd-e1e1-46a5-85c8-61fe42696547	2	9	9	73.51	61086810.00	61086810.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
22bde3ce-e411-4537-8be1-aae9b540b5f4	d95fa2cc-c395-4b93-a8ac-b226a3143310	4	9	12	140.56	125941760.00	125941760.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
9c2b7903-fdbd-4772-b3b6-aec60b19ac90	e2db0296-5541-4f54-aa4f-020270078184	3	9	12	109.35	95790600.00	95790600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
aa641388-a686-4664-86ad-a69a0182efaa	d12e53cc-7678-440a-b7ae-923632e99ae9	4	10	12	140.56	122990000.00	122990000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
b3ed110f-796b-49d8-8422-eda12dfcea2b	ee718ca2-9dfe-40d3-a989-b77075868739	1	10	12	43.32	41977080.00	41977080.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
b6011308-d4b5-4c4a-9a16-279368715d5b	c3f9613f-cdda-4232-8e7b-2ae6195fb8e3	2	10	12	69.44	65273600.00	65273600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
28252fd3-443e-45bb-98ef-30c687d5bc25	c330d8d5-086b-4d11-bb3b-52095d3363dc	3	10	12	109.35	95790600.00	95790600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
105b872b-6948-488b-8d25-5849bc434948	33a5b39c-a180-4034-a264-521af6ab9dbd	4	11	12	140.56	122990000.00	122990000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
d4828bd5-adc9-47a6-8277-ea67ecc733d1	01565a57-896d-4731-b49e-e3aed4e18130	1	11	12	43.32	42063720.00	42063720.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
c1abedf6-8b45-4f28-82a2-0590005b9060	161f06ba-11ee-43f0-a317-e330cbd92f53	2	11	12	69.44	64787520.00	64787520.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
d75b9c38-d150-473a-94be-992deec4a68f	fad0fb55-d27a-4cfe-8cae-d0ccb10562df	3	11	12	109.35	95790600.00	95790600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
e8c0f56a-94fa-482c-8929-d510ed1739a5	bfbe23f2-9f8c-483e-82bf-1a5063e7153f	5	2	9	168.14	141237600.00	141237600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
c336220a-3fce-4c36-9c01-69fee42ca8ab	23083984-6f18-489b-8819-5a2463f3bbdd	2	2	9	52.44	50342400.00	50342400.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
36191722-883e-4b70-a9d4-772b98fa2101	a6f959cc-88e8-429f-94d2-8229a4466e44	3	2	9	111.75	92417250.00	92417250.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
b636f220-02e3-497a-8610-9819773afb47	f8f6e722-6c96-418d-805b-2662000c5f46	4	3	12	140.56	120881600.00	120881600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
3bf6a1e3-806d-4059-933d-c80df58492b6	d1ef344d-7477-410c-9b0c-87c3202508e2	2	4	9	52.98	55523040.00	55523040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
39421e1f-2370-4dd2-a49a-e1900a6f39ca	e0d809b7-a405-47c4-8115-6af678c0961e	4	4	9	133.78	122007360.00	122007360.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
d3075fee-c81d-48ed-bab9-6037ee6b3b63	c3bdce96-45f1-4810-9b7f-8cce36770570	5	5	9	167.92	153814720.00	153814720.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
1d50d64d-4cfa-4198-b679-2d5f43117f5f	3efff4c8-ea9e-4da6-a6d9-378ab6c60490	1	3	12	43.32	41543880.00	41543880.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
7ab91b1f-4a31-4881-a937-bdb3ef0a98a9	a3f3d058-dedb-4af1-a14b-ecce4eddbd51	5	7	9	167.92	154654320.00	154654320.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
0b931c56-70db-43e8-920e-7dcf70324241	ea214345-9c64-4d0d-a23a-aa5351fee2ba	2	8	9	52.98	55523040.00	55523040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
fc5a0a8d-2123-4cb1-a216-899224f2081f	78482d95-98ff-47b0-9656-a9895d99e183	2	9	9	52.98	54834300.00	54834300.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
45f0b6c5-ac17-4bf7-b717-426108e23629	50773a52-5397-4b32-8f19-ac2cc6cc1005	3	2	12	100.12	81798040.00	81798040.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
fa50bad3-c38b-4206-b24e-dd224e79b77d	e714d1b6-0125-4dc7-b89b-8619cddf5cee	2	3	12	69.44	64232000.00	64232000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
8f4b6662-3fb9-4c9c-8684-1bdf8cc0b9b1	38ed827b-0956-46fa-9c93-7257414399d7	3	2	12	86.23	75623710.00	75623710.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
0700afd6-ec26-42b5-899e-36bf02542da8	7b6e66c9-6122-4388-bdc3-242f8d6b95b5	3	3	12	109.35	94697100.00	94697100.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
abc65aa0-3807-44b9-ae2a-99629876fbf8	4f0b221a-0de7-45d2-946d-12a8e531f4d9	4	6	12	124.71	107250600.00	107250600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
80cb302e-65d8-439f-8d87-e366d5efb71f	f13fda99-4b27-4efd-85e3-711758f535f2	4	4	12	140.56	120881600.00	120881600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
f94b887e-61a8-43ac-a089-2327bca031c5	b936d7a3-9e05-4de7-9c3c-72e7dc16efb9	4	8	12	124.71	107250600.00	107250600.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
7df20081-41d0-48d2-a85e-43719b2d7efd	5f533576-265b-4f16-bab8-3f3944eb62ee	3	8	12	86.22	79667280.00	79667280.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
dc5eb6e1-96dc-4cc5-a355-ed50ce4a8511	1ad64333-bd62-48fa-9f08-e65ba7cfcb5f	4	9	12	124.71	107998860.00	107998860.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
4b7b62d3-15e4-4a46-a274-73a601cf57b6	4c7f0730-5b92-4068-bc5f-ff1ee446868b	4	2	14	148.33	132310360.00	132310360.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
c1d7df27-ce7f-4dc1-85ae-7539dd18504c	c462a612-970b-4407-b74e-1d650005ef71	2	2	14	67.75	59620000.00	59620000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
16828433-3403-463b-b0a4-a9676c009f36	486d1f3c-7513-4f75-b1b2-d2fbb0609247	2	2	14	60.25	55490250.00	55490250.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f429c7bd-06b7-4597-a5a1-4533bacf3f79	54dab9ed-fd13-4699-a620-c2f82eb85500	4	3	14	146.04	135087000.00	135087000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
37346eb6-c63c-4530-818d-302cc1f59838	ff5a0026-e626-4c63-8073-2d18d9060fc9	2	3	14	66.37	61923210.00	61923210.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6eb6b034-a1a4-4140-81b9-133873d41c55	3dec5d23-0a0a-436c-ae60-ee2e7b4f71b7	2	3	14	58.97	56552230.00	56552230.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f9632ec2-3bd2-43ca-8f12-b2cba2c2a69c	3ce54356-af8e-40a6-8bc3-b4429c36346a	3	3	14	116.42	103380960.00	103380960.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
789b3d92-4729-4f96-93f2-ba0bc50afb58	995448dc-fd97-49e1-b07b-34e983ad4934	2	4	14	66.4	63080000.00	63080000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6d7a4268-24ef-4507-a161-2202e59f8b77	7fa46001-a772-496f-88d5-ba454ec78659	2	4	14	62.15	59974750.00	59974750.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
ee23b2b7-22a0-466d-963a-c9bddab87562	63d19cfb-0d26-4bd8-95f7-ff6b8f5afbd1	3	4	14	116.42	103380960.00	103380960.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
e95d9710-a81d-4793-81b9-976c004b267a	35b9708d-0c8f-4c29-b53f-f2a520692c5c	2	5	14	62.15	57240150.00	57240150.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
7c230f52-5e3e-4ea6-9016-870c8a016de2	bd896552-3ce4-473e-a08e-1600849662bc	4	6	14	149.24	139240920.00	139240920.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
d3eea520-6e2c-46ff-8c70-e109ac072ef6	e94ae293-df98-4af0-baaa-00c41e846e01	2	6	14	66.37	63051500.00	63051500.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f7a9a502-707e-4634-bde8-67246c908b1b	4395c76b-b796-40aa-a298-f4e1aa92f9e1	2	6	14	58.95	57122550.00	57122550.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
428281bf-fc4b-47cf-8ca7-f8fdb8f7b618	0a93de64-a4ab-47b8-8686-085bdc2db3bf	3	6	14	116.43	104787000.00	104787000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
9cf6a77f-e20d-4081-81d8-718fc69855f8	342f147c-12e2-45a9-9a3e-d58398064125	2	7	14	59.17	54732250.00	54732250.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
8c611b9a-325e-4b1d-9dda-f677e9b74baf	3ca6f2d0-b64e-41f8-844b-9e03f7e0af6b	3	7	14	117.08	107245280.00	107245280.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
349ea40f-2394-4367-9ac2-add469600d9b	330f6450-b513-4d62-8164-07ddef335939	2	10	14	66.57	62442660.00	62442660.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
fd96a6e4-f5c8-4a10-b65e-ee6f992944aa	5f249eaf-1d44-4b0f-ad88-daf6b76804fc	2	11	14	66.57	63308070.00	63308070.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f44023d5-4a3c-4655-a6ef-55fcc0178dc5	e087d09a-df90-4699-b249-7b84fc78e09c	3	11	14	117.07	104894720.00	104894720.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
13ea67e8-974c-493e-bc36-1a222ecc867a	532cfc49-da2d-4290-b7f2-9e8ef944ab0f	2	12	14	66.57	63308070.00	63308070.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
186e982e-9af3-415b-8331-b9b8db964760	3ed3ddc1-2a60-4ca2-829e-6be919b7b7f6	2	12	14	59.19	56763210.00	56763210.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
ba695565-aabd-4dfe-8d0a-31e920fbb4fc	eab2f8f1-6ffa-4044-a05b-2d70625e412e	3	12	14	117.07	106065420.00	106065420.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
731d7f80-0583-4544-b692-975221979d4c	d254bba1-07ea-4592-8ffb-587a1ad8bb72	3	13	14	117.07	104894720.00	104894720.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
213f26fa-caed-47df-9410-7d2388491347	f812d726-be13-4994-aa0e-8dcf44a149c4	3	2	20	130.42	105770620.00	105770620.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
1dfe3c6a-ac19-4d23-853b-c1396f70cf44	0d3393f5-e16e-4a82-a341-4f511e861844	2	2	20	67.4	60053400.00	60053400.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
14dbc5ca-1782-45e0-afbc-f76baae66127	fb7d4735-d3a8-4e4a-abce-8bfbdf60d3f4	3	3	20	128.81	108458020.00	108458020.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
4106056b-c57b-44a1-b7f0-9a3b2abdce7c	150f3c83-088c-4eb6-b0f9-5cf57c616d41	4	3	20	155.36	139357920.00	139357920.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
cbe37a5c-180d-482c-ae1a-419423c9eb47	76e5aa9f-9315-46ae-9bc6-22d6d8e4432b	2	3	20	54.67	52319190.00	52319190.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
67c67e45-3e0a-49ca-9aa3-3a7c7a6a9909	1c54b719-978d-46bc-8f9c-6709ca8afcbc	3	4	20	128.77	108424340.00	108424340.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6c7849cf-fef4-4243-9f63-4e7ada600eac	ee0c4a5f-4c80-4531-a196-3852769821aa	3	5	20	128.77	108424340.00	108424340.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
78591b64-989c-4211-af2a-9929a8cda096	3220d553-b8a4-4cb5-a400-73c160363682	2	5	20	54.67	50624420.00	50624420.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f226de02-2c55-4916-bbc1-7b09a46df619	beb964f6-d72d-4f87-bced-95bd16fb627e	3	6	20	128.77	108424340.00	108424340.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
d913af59-fad4-4a3f-9a68-15529a1dffe7	0a98a13c-615c-4df2-ac05-a466353d79e2	3	7	20	128.76	108415920.00	108415920.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
8f834e32-d67a-4a79-9b46-a8540f9246d4	ebfc3ff7-df01-47d4-923b-9556697785f3	4	7	20	161.62	144973140.00	144973140.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
e3ae78f8-17b3-4e4f-ae1d-4921b1ec2ad7	3c7a72ef-1d38-4a90-889c-2dca297bdcb8	4	8	20	158.41	142569000.00	142569000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
98d9b42f-5822-4fac-b12c-54909dc50f24	82a9411e-71f9-4c1e-b110-f4b41e2ee792	2	9	20	69.36	64227360.00	64227360.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f89d1b37-deb3-476a-a569-db3d96344c29	714e2ec6-36dd-4873-965a-77d1c027e86d	4	9	20	158.46	142614000.00	142614000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
37de7f02-72fc-41aa-8eaa-22a9c6351c67	0e254775-e21b-4cd7-8ed5-6ead53733fb1	4	10	20	158.43	142587000.00	142587000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6cc58cdf-3135-4005-bcad-2abc9d2400d7	f4afe04b-dd71-41e6-9ecc-0e257d1fa129	4	11	20	158.43	142587000.00	142587000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
a5ed7bdc-4a46-4893-9321-34d9471c8e1d	6bb9e3e1-ad1b-4332-9d5d-a2ae4e1a5788	4	12	20	158.48	142632000.00	142632000.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
13ff02a4-46ca-46e5-bd68-7def182f2c19	5aec9ec0-4da6-4dc3-9251-e384d6c423f3	2	13	20	55.41	50035230.00	50035230.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6be99f0a-bb22-410d-971c-6fd9faa5e39c	0c391f5f-1560-4827-ae48-5ffce65dafcf	3	14	20	132.55	113595350.00	113595350.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
f42bd31f-86ee-4230-8cb9-3980d7d64eea	37291f1e-257d-4c9c-b46f-99d7405a578f	2	14	20	55.41	52473270.00	52473270.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
4b824c43-d9de-41b0-b80c-918e665ca306	da47b016-d90c-4bd9-8912-7d2b9bccfc3f	2	15	20	55.39	52454330.00	52454330.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
79aef6c7-1c94-43e3-9954-75d1fd38fba3	2cb88c13-1478-4473-8ae5-4dbf894655cf	2	16	20	55.39	52454330.00	52454330.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
ead9eb3a-a7ab-4080-a63f-fc27b53e635d	fd4257bd-42c7-4173-adc8-027d52130469	2	18	20	55.39	52454330.00	52454330.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
1a11c1b7-be75-4302-9391-803ff7cd8a70	f2bcc94b-1169-4dd5-8352-f9c90d9ad709	2	19	20	55.4	51909800.00	51909800.00		2026-09-18	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
37afe0c1-b809-4403-9881-b290e354bb24	92350001-c721-497f-834f-e8703de5ce1b	3	2	20	130.32	116897040.00	116897040.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
1448c10f-e4f6-4f2f-9734-011071c0ab3b	645d9f02-a7c2-4410-b986-ad37017f6bc8	2	4	20	52.89	49769490.00	49769490.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
87b1ee5e-cb71-475e-b829-54465aa6628c	792ac75f-1c93-4553-bdfd-8574504006fb	2	12	20	64.57	61018650.00	61018650.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
47142848-b6d5-4ed4-840b-925e57f9b04b	8aa902e7-8c8b-438f-ae24-d5253a784f04	5	15	20	165.22	165550440.00	165550440.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
a5569566-0af6-46d8-b53b-2e1854e068ae	d0466dc5-7f6e-4b4b-8333-5512f3f5b063	5	16	20	165.68	162238827.00	162238827.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
6af41769-92be-4227-9c1d-6f59e00ad509	f94b92c1-c68d-4212-bf21-c746e3c9154f	5	18	20	162.47	153046740.00	153046740.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
92658f6d-0c0b-46b0-98a8-3bb3bc748f14	e69aaf9d-0394-4353-a74c-1fa413f6a2e1	2	19	20	64.65	60253800.00	60253800.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
801622db-e016-44d8-a208-47dd5cf6a2fb	8331d2d0-c747-40e0-b09b-4328a2b658a3	2	20	20	64.57	60179240.00	60179240.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
e410e7ec-8bf2-43dd-a233-7a28939e6e36	98e63cb1-e53f-4800-b0bf-fad4a66723a5	2	2	20	67.34	61481420.00	61481420.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
fa6ab3ed-8853-455c-a9e6-51aae2507a9d	dce1e131-a511-4ce8-b226-b4c6edc21da0	4	7	20	158.43	141002700.00	141002700.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
637018ef-5621-48a2-a8a7-72b8d379d189	f7987a5c-1b00-4161-899e-dfd4d8b6375c	5	2	20	187.23	148098930.00	148098930.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
44fb8aa2-b1ae-4518-8a15-d5f99dc31a11	c817b3d9-bc9c-4256-9bfd-0b79a50c1f2e	2	11	20	66.2	65869000.00	65869000.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
46ea166e-61f8-4835-9c9e-031c8e7799fe	fcd7cf14-dd86-4aa5-b3c5-e89b81adb134	2	13	20	56.75	55855052.00	55855052.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
559d514a-cfe4-4d2f-9a92-9ca2945aa0b3	6a9bcda9-da6f-4ec9-aba6-0e81c226f544	4	14	20	158.28	147042120.00	147042120.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
fb7a3fa0-f51b-45e2-943b-d8410b7d1586	5c13a8d8-85ba-4916-8e8c-35557139b9dc	2	14	20	56.75	55104250.00	55104250.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
75da331a-c61f-472e-8fd0-d708c99e6729	499e4713-c5b0-40b7-8319-a794bab4372c	4	15	20	158.28	145459320.00	145459320.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
aeba05eb-a1c9-493a-a493-e4247e34dfa1	090c463f-2682-4ad0-a28c-e48fd5e575a9	4	16	20	158.28	145459320.00	145459320.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
b8df83cc-3da3-43fb-b654-86878a54c600	82152ee3-fa37-4a75-ba8a-b29daf957df1	2	17	20	66.05	65719750.00	65719750.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
3cd68f98-4906-479a-9161-c18494175c4c	ac19f4e3-279d-49a0-8bf8-3f47a87bf7c1	3	19	20	129.1	112058800.00	112058800.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
ddf681a3-2438-4d66-8c17-f9236c63029b	ce904d92-176c-4341-a849-d2b5dd0e7f2f	2	3	20	52.89	49769490.00	49769490.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
b5daf22c-5c13-4117-830c-318efcf2c7a6	a1cc8486-1f78-4213-8c65-aebf5f53627d	2	19	20	53.56	49328760.00	49328760.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
57b9b85a-5bc4-4501-9417-71ea944d6345	3ade6d01-89e1-4bf5-9142-64a838dcef0c	2	20	20	66.05	60435750.00	60435750.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
a71bdccc-9449-4b2c-ae3d-dbc3f661cd91	aa0aa899-7767-4f76-8f12-6a1273b4136f	2	20	20	53.56	49328760.00	49328760.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
0971bb0f-f67f-4002-b0fe-ac6bc5b3e58e	b14c95a7-3c43-4718-bbc4-9e089dadbdf3	2	2	20	65.02	59623340.00	59623340.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
284e5b44-02ca-4c61-87a9-dd1795ac9e85	e7d328b3-cb96-46ca-85c4-e64a47e196bc	4	2	20	140.17	120546200.00	120546200.00		2026-06-19	t	a7ac43bf-e821-4c56-a499-e50df137a2e3
218293e9-ab63-4008-960a-3dd2f4cbd192	e6ab2db9-7fa1-4de8-9035-2c455b6a373b	4	2	17	133.35	132283200.00	132283200.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
a2b3bdd0-1b9f-425b-a728-65979c292237	d01f13eb-cd18-425a-ac84-bae19783e0ed	3	4	17	105.8	108550800.00	108550800.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
02b01ce0-f57d-4621-9193-27dce46e8543	205b3f59-61d7-4872-9fed-c4825188b288	4	17	17	119.64	118084680.00	118084680.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
5e33bd97-e1f7-41de-a9cc-20f7761eeddf	a1e7c6c9-844e-4cfb-b46e-09e11b926641	3	2	17	100.55	96125800.00	96125800.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
999ec7ef-e98e-495b-bef1-52320f85664e	5462aa19-01f4-4224-a538-3acb53b5f76f	3	2	17	104.74	98141380.00	98141380.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
acf60348-e8b2-4097-aa27-fd54b3a9a75b	9175ad0c-ca9c-4fcf-8bfb-56506d91476d	3	5	17	100.07	99369510.00	99369510.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
1a88989e-56bc-41af-9e1f-892da2f6ee5b	068fdf26-3ec2-4df3-a029-0f7af1d7de12	3	9	17	99.58	99181680.00	99181680.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
f4bc9566-9858-4dee-832f-9e5dd5429787	abba4193-0828-4a12-954d-914ddbfa2e27	3	10	17	99.58	99181680.00	99181680.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
8cf69c44-fd42-47d6-98ee-2a437eed0371	4976dac1-24b6-40f7-b8d7-99eefae32ee0	3	11	17	99.29	98892840.00	98892840.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
92840315-b3d6-4128-8ee8-aee644f064ce	a2cb3873-6856-456c-82fc-60371574206b	3	12	17	99.29	98892840.00	98892840.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
28bffaa2-c010-474d-bab1-489649f4107d	37ce8713-c1e5-431b-a02f-61849d7ad73a	3	13	17	99.29	98892840.00	98892840.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
a6f7626b-134b-44ba-9225-fd98bcb941bd	c6447316-33d9-4855-a166-0f7fe34d1359	3	14	17	99.28	98882880.00	98882880.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
d4bcf942-2640-4535-b092-82a7acca4a9c	d96fb933-9afc-41b5-a87d-ebb91358527d	3	16	17	99.28	98882880.00	98882880.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
a8a6493e-665e-45fe-b43d-148f503c9194	7ad0cbae-4694-4f0b-bf0b-afe4d40d79fc	3	2	17	106.99	107524950.00	107524950.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
ef565cba-ef2d-4ca6-9e09-1e6b31ef5b10	b0c72d3f-e63d-4cbb-8611-8dfdb27f79f1	3	2	17	102.17	93485550.00	93485550.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
31787f00-7332-4902-be42-6ba55a496409	748738f3-b2d8-45c1-9882-34e22201bff1	3	3	17	105.95	109234450.00	109234450.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
dc2c7cba-f946-4601-be02-8bb95deb2b6b	97a5c89c-0e57-4ca8-b29d-97978461d9aa	4	2	17	121.33	117326110.00	117326110.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
28dd1c1a-d1f8-491e-95f4-f7befa255d7c	95b57c86-431f-49ff-a88e-267f4ecb5066	3	2	17	97.01	97592060.00	97592060.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
4e6fdf72-0eb5-409d-83fb-f745f73988ec	589ec563-30ae-45b9-b2c7-4f82dd96ab16	3	2	17	102.95	93169750.00	93169750.00		2026-05-29	t	25cfb270-1dfa-40aa-bbfb-af7264f84764
bea8b4a3-8cc5-4866-90e5-694a48d45dc6	b0316f83-0e03-4f03-a8e7-a9d1ec290dee	2	2	9	80.15	67486300.00	67486300.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e279654d-7679-4ffd-85e9-e0bc35ed9da5	70146231-65c2-4444-8d8f-b628b241f4f7	5	5	9	177.95	161934500.00	161934500.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
c08561c3-ccad-4268-a4b2-565a9869546d	5d31f5d4-5c47-4bd2-88fe-6e6c98ac5e20	2	5	12	67.38	63674100.00	63674100.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
99c328a5-985a-49ca-9851-15637fb7d93c	9e1fc728-8f7d-4309-9301-7fe09c34982b	3	5	12	113.08	86393120.00	86393120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
2c12ac94-b28a-4521-80ed-c09fdc47d363	4e041b84-9de1-443a-aa20-4082efd1fd59	4	6	12	135.23	124141140.00	124141140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
acabc389-9c6f-4259-92d5-a97b97e5214f	9a4d3314-d8ad-4d01-b661-48e5a30c26b9	1	6	12	41.88	41670600.00	41670600.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
93244cc9-b026-4eb0-9df2-aa232ff2c5aa	02858b1d-7a30-4ba8-9702-264b41db7818	3	6	12	113.08	100641200.00	100641200.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
d777e9c1-cc8e-4d72-b66d-39f1dd0d6136	73bd3ea8-893b-4d6e-89f1-123302a1a0d6	4	7	12	135.23	124952520.00	124952520.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
a0e597b2-30a9-4b4c-a68e-b044178ed988	725ca350-c735-4228-9c4d-6c167dc25416	3	7	12	113.08	86393120.00	86393120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
94294895-63ab-4135-99c6-15a79d8820e7	05ae6340-4fb0-4b2b-b3d5-452eedc195b7	2	8	12	67.38	58014180.00	58014180.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e1f96865-5699-449a-a4e0-b0f50c88f194	fb42cffe-fb26-4613-8af4-aa11bb26e475	3	8	12	113.08	86393120.00	86393120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
571e759a-8bf1-4161-8985-8f9ed013af65	4c2c163d-623c-4d95-825e-81e7668e0470	4	9	12	135.23	124141140.00	124141140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
5cd32f5d-d1f2-4b6b-9adc-a86add362a72	f39a5b6a-b4b1-484f-9c57-5a4bd1da133f	1	9	12	41.88	41670600.00	41670600.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
a791124a-9834-4755-8ecc-2cbc67cf2889	b2e85593-b71e-4371-9943-6411ff513c47	2	9	12	67.38	63674100.00	63674100.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
d02ebf16-e752-4560-a8ba-12690abc99a6	48cc1309-9b63-436e-9900-96b696f2baca	3	9	12	113.08	86393120.00	86393120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
3570904a-27e9-42cd-a806-77b14da6f0c8	f6f4acba-90de-4f53-815c-09df19b29cd6	4	10	12	135.23	124952520.00	124952520.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
57ef0ebd-2b80-4e85-bfae-6cec338b1d30	4db48924-5d84-46b8-a6a4-2d701b502076	2	10	12	67.38	58351080.00	58351080.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
5c78987f-9059-4319-910a-dc80ca319288	19dc2a3a-0c4e-44da-ba89-dbfb0ad97da9	3	10	12	113.08	100641200.00	100641200.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
b9db60f5-9314-4a0c-bd64-b7c2f2d6d7cb	33aa4332-5847-4115-8e4c-4617c4dac2f9	2	11	12	67.38	58351080.00	58351080.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
3bf12677-5c76-4402-9eec-c6877744dd6c	9aec12f8-6236-484d-9680-2850b41a753f	5	6	9	176.33	157462690.00	157462690.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
775e1021-5b0a-49a7-83ec-e82c90cb2fc2	8a1fdca7-315c-4606-9aa1-3e8d2ca6d1eb	2	12	12	67.38	58351080.00	58351080.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
c89b4d55-9333-4d3a-af88-a1559e0b0795	8d77f1bf-1fdf-4d78-9258-8cd218e33843	3	2	12	87.41	72550300.00	72550300.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
8cc48b3d-5339-4228-acf8-adb9a1dde774	d7b71bbb-9511-4130-9589-bcfb07fafb27	1	2	12	42.68	39137560.00	39137560.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
130e714c-ae19-4796-939d-a608449b14cc	ff149981-426a-408e-9c3b-b7c3d20b84fd	1	2	12	44.48	40699200.00	40699200.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
fc1c3fe9-e0bb-425d-ae77-f6f27b83594c	b7c91b45-e4b2-41a2-b913-35c9ebc85267	2	2	12	64.85	56030400.00	56030400.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
9375bbdd-0932-45aa-ac3a-ede3c8b3ca7e	95c97aa0-392e-412a-9aa7-20533c9eefd9	3	2	12	79.63	69118840.00	69118840.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e6714b04-fe83-4b20-bc87-2d7b8570253e	7c74b8f3-43c0-4791-9b41-0cb08d0bc716	3	3	12	113.91	85318590.00	85318590.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e8a6cf83-5b0a-4f22-ae55-fe4759bfed63	f26114e5-6644-43d0-aa94-077b731f6b68	2	3	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
df8d83c2-fe87-4fe0-add4-66f160d17f52	29e94d6e-ec92-41b1-9d45-a38e4c894140	3	3	12	79.63	70711440.00	70711440.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
2226bf74-7374-42cd-a52f-73a9bc04c331	f3e9feff-dde9-4f1d-b214-27620f2e7cb9	3	4	12	113.91	85318590.00	85318590.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
33f3eaca-ace9-42ee-a7a4-4486818e7a2f	654405cb-5010-4298-90fc-cffbf3416ad7	2	4	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
c9ed179c-d277-46f5-b873-1b3695a95f40	b7fba40c-95f8-482a-823a-0885df5ee71d	3	5	12	113.91	85318590.00	85318590.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
62891562-5a57-4750-8342-5fb2a9f2968c	1d1a529f-355f-43f9-9f0d-6095d4481a5a	1	5	12	43.68	42937440.00	42937440.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
7406f2cd-d950-49b2-80cf-302015b3c480	3282439a-25d6-40e5-956c-50964458aa4d	2	5	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
36caf34d-14f4-4bf1-865a-c4211c3b09b3	87513120-6d95-4d5c-b1a4-250c18bd042a	3	5	12	79.63	78037400.00	78037400.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
d8cb7d96-f307-423e-8d10-bc402afcc653	39516860-8c51-4ac1-8bb7-7ba984982664	1	6	12	42.28	41603520.00	41603520.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
785e7c64-4f29-4f4a-b9f9-933a6c74d0a1	907e8286-a798-48da-a0f9-4f17cb671e98	2	6	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
1eb679b9-afaf-403d-9aa7-f316071bb42f	38f24f47-0a0a-4ecd-a974-dcff0c919897	3	7	12	113.91	100240800.00	100240800.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
5d4e0bef-cd93-409b-8846-258faa3ec807	aa68a0c4-8a74-4f28-ad97-d41538dfade1	2	7	12	64.22	62229180.00	62229180.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
dd1ebae3-d8d6-44bc-807c-55f91a02f8ca	81bfca66-4e8c-4065-9bd9-8663a32af02a	3	8	12	113.91	85888140.00	85888140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
83b25b6b-8317-44fd-8bdf-93399bd61e13	ab71cf98-8b01-4a8f-8d45-d1076c03b464	1	8	12	43.68	42937440.00	42937440.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
d0960aaa-ff46-423a-bb62-4cd8e466a394	b34a1b28-605f-4a80-b4ac-c09a6d5d0a39	2	8	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
0dabcf64-0018-4425-a8b8-d632f102ad04	c94bcce2-e4d5-4814-a01f-81e28891afe2	3	9	12	113.91	85888140.00	85888140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
533d0263-c672-4d87-8447-5c9f6a4d9d9c	88ea1e8d-ee81-43f2-b947-3311d826fc87	1	9	12	42.28	41603520.00	41603520.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
0e72b05d-f88e-419d-bc4b-4a4288c56cb8	8499553e-f490-44d3-ac1c-6790a051aa19	2	7	9	53.57	55552090.00	55552090.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
1b7c565d-eb94-4ca7-bc31-ceb2ed0bea63	1e376a30-ec70-4017-8640-5bbaff5cbbbc	2	9	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
b210748c-59c2-472b-b41a-a5225301c67c	08c58fb2-648c-4ea8-8867-f0df6ad806d9	3	9	12	79.63	78037400.00	78037400.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
3be1df13-ae96-40f7-9f77-70d5edbc19ef	3234cc85-5ec5-4356-82cd-0cf83816caae	3	10	12	113.91	100240800.00	100240800.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
c0435b96-4ef2-4e3d-8ca4-51c8c20e4d97	60127b15-5c1b-4ac2-9dac-eaa9b1b6db4d	1	10	12	43.68	42937440.00	42937440.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
5071fbd5-64f4-4bd0-8eb2-cb291f6ca57a	242c9992-8846-47a0-9325-dabf9030711a	2	10	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
ed70e793-6c50-4e0b-89fb-939e94c9a0ba	ad751ac1-dec0-4f0c-8ede-5a954025a91c	3	11	12	113.91	85888140.00	85888140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
60e8e89f-09f5-48ae-abbe-bd877ad5d1c1	bc31a7d9-aa03-4eff-9dee-c47afb3c751c	2	11	12	64.22	62229180.00	62229180.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
0e250ed0-2758-4e03-87fa-937b70d0ebff	6c0b686c-3000-4aaa-9a1b-58804d58d7b4	3	12	12	113.91	85888140.00	85888140.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e5a656b0-06b4-4f2a-ae9f-cca1a3cf2f7b	3310f211-4063-4cbd-9c01-cd02afa93816	1	12	12	42.28	39616360.00	39616360.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
82d4cda1-aac2-4cbc-96c0-26e1db11f351	e0bee695-0206-4f20-97c7-b7038c8b3dd3	1	12	12	43.68	40884480.00	40884480.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
ed466694-ac63-4a4b-9a20-a0a8846672a2	3cf81048-62eb-43cf-9784-da6d14448071	2	12	12	64.22	56834700.00	56834700.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
9f5f92d0-936e-498c-b760-73661b491cb8	3301690d-756c-45ee-b9ca-0a4590dc10bd	3	12	12	79.63	70711440.00	70711440.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
4d050646-5343-4930-91d9-017a2c75dff2	d012b5bd-4a54-4a56-9d82-4d75e6842749	5	8	9	177.95	163358100.00	163358100.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e9eb5f15-7bb1-4761-8d1e-1fa98d7c2255	c6ef48fb-9461-400d-bb76-e2d709a6d29d	2	2	9	54.2	50731200.00	50731200.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
7197e1a7-1184-4926-813c-8dcc6f171e45	716e3cb8-400f-49bd-ab9e-1efa2e988cba	5	9	9	177.95	157129850.00	157129850.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e7d37381-fc18-4357-999d-c601a49c7602	ee68f1d4-3ca3-48fb-b4dc-074359218386	4	2	17	151.68	124074240.00	124074240.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
599550ba-ea32-4c59-89d2-479473112fbc	1551757b-9c24-4b37-91c6-b09cf4239741	2	2	17	67.23	59095170.00	59095170.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
a06a80e0-2350-4d05-b335-d79c9ed572f2	1e9942f7-44da-418c-8e97-b99ca081fd1c	2	2	17	69.16	61483240.00	61483240.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
63edd767-d096-4186-8e9f-f42941e0b37d	038fcd98-a818-4c7d-8044-2bb37bf614e8	2	2	17	74.66	62639740.00	62639740.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
1451d58c-fc4b-404c-b270-1105f0c9eb48	cd9795d0-47fb-4863-8fac-d5c368794b6d	3	2	9	107.17	84342790.00	84342790.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
69241641-7831-46c6-9bae-735af67a0667	b8a537ab-a1d8-4f07-af77-71adc154faef	2	3	17	68.47	62239230.00	62239230.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
ba36ed16-2a54-41ef-b948-7feffb28d34e	11e8cdff-401f-4688-aab2-0c86dba38775	3	3	17	104.22	79728300.00	79728300.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
bf0bad35-6a67-4ec1-8eb3-46aac3ac1898	72ec0027-7471-4b03-9197-9c989b3f3bbb	4	4	17	152.99	132795320.00	132795320.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
d65f6e95-8933-4e62-97f8-da7990f50f77	7fc110ca-99d7-4597-90b1-f56330d7e8e2	4	5	17	153	132804000.00	132804000.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
b50f3a37-ff28-4f2a-a292-0b0d24e6f8d3	79e3edc3-6084-4ebc-ac42-02085f06058a	2	6	17	68.52	68040360.00	68040360.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
49dbddc6-9b6f-47db-963b-6b01e5661ea7	ee57e272-6c21-48f1-af0f-9ea65aec6ee8	4	7	17	152.33	146846120.00	146846120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
2e302024-5a06-4ead-a6d9-41745ea8306a	71fc519b-ab65-4844-84e6-9dfba42da915	2	3	9	53.57	50409370.00	50409370.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
bfa327a1-bb9a-4c38-a1c0-866fe8898f30	ea33354e-5bf4-44ae-bd2b-c01d4cc2f966	2	8	17	66.49	65359670.00	65359670.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
23728a12-9955-4665-b8d9-a34459671942	1f15edb6-c2b5-40c9-a439-f5e4de9ee441	3	8	17	104.31	92940210.00	92940210.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
7246b159-a4b2-4318-98cc-43752d4744c5	d6ea9df5-770d-4a51-9a31-4261050ea14a	4	9	17	152.33	133898070.00	133898070.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
a1ecb5b7-cae4-433c-a30f-3b92d228470c	6f7561ec-38d0-485f-b0b8-94e3a43942d3	2	9	17	68.52	68725560.00	68725560.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
ca91b967-024d-40aa-8a87-d961e9e7b9bf	e153f1c5-6034-49c0-a660-7b16b2b9b027	4	10	17	153.14	147473820.00	147473820.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
52c237e4-bf6e-4ecc-9555-982df4834640	19056f14-a8ab-42aa-bd6e-575257167df4	4	11	17	153.14	134456920.00	134456920.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
4d5856bc-d57c-457d-8117-4570e0cd781c	be231201-c940-47ae-b2b9-59487fbd5b79	3	11	17	104.31	79797150.00	79797150.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
6151711d-ea41-4343-aa47-0df3acd96714	fe8ff327-ba38-4b6a-a888-2c07254be672	2	12	17	66.49	65692120.00	65692120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
b15cf2d6-a48f-4921-874c-347b1d58c854	d7cc403a-90ed-4a49-ac0a-7186feb0eb0c	2	12	17	68.52	68725560.00	68725560.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
cfb24228-d2c7-48bc-98af-31e18c983e36	8f368cb7-88de-4a1f-937c-11e96a8eb9aa	3	12	17	104.31	79797150.00	79797150.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
33594561-8d6e-4749-88be-e29f611bffa6	786610d4-7e17-4f25-93c5-368f783f1291	2	13	17	68.52	62969880.00	62969880.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
0d31d97a-204f-445a-82f1-165b9905fac0	ae961980-58e7-4bb3-9052-b3debb28cb50	3	13	17	104.31	79797150.00	79797150.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
63e918be-337d-4f65-827f-77b80c985f5d	b1018b91-3018-4e14-bc79-f1312023c155	4	14	17	152.33	148217090.00	148217090.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
f03a0771-0851-4b49-b492-2bfbee4a05ff	cb8a759a-e399-48a7-9307-75f62ea33238	3	14	17	104.31	94504860.00	94504860.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
afe66c47-3262-4676-a309-d2593aad30e6	94e3b65d-7b54-4f0e-b0a3-06eabba6301a	2	15	17	66.49	60106960.00	60106960.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
7d35f632-ccea-4515-8cc1-ab7bc42f5917	c8684782-809e-4439-b241-afcb207b6945	2	15	17	68.52	68725560.00	68725560.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
7e918bb9-59c7-4d28-9304-41aa4f705096	8e2d26db-b61b-481d-a641-f3f9246a08b4	2	4	9	53.57	55552090.00	55552090.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
9f2c8cd0-23bc-46b5-a058-d1c374152e6b	e6dd118f-15a2-4b9b-a49b-12c97ce07f86	4	16	17	152.33	135269040.00	135269040.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
792f18bc-bd67-4d86-9302-53989ca3d92d	93451fe3-f80b-4c88-9c50-806ce62e8f6d	2	16	17	66.49	60106960.00	60106960.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
e21d0014-0d30-4df3-824d-15d7eb36f864	e82d3266-ef0e-45f9-85c3-6bd80c9a13db	2	16	17	68.52	62969880.00	62969880.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
296771ea-b0cd-4b1b-81fe-935fabceed4b	abf1fe6a-1874-4542-b628-fc28235fb9fd	3	16	17	104.31	81361800.00	81361800.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
137a1b31-fc48-4126-b89c-503964f4b243	fbc6bd95-d96f-4888-8ad2-fe587aeec57f	2	17	17	66.49	60106960.00	60106960.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
6e6b8a07-4a6c-4360-a1c7-4712b3df688c	fd2ddc51-eabf-454d-8dab-205ef3747b9e	2	17	17	68.52	62969880.00	62969880.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
061f4648-ad24-4dee-90ad-15fbb48405fe	2f1eb2ec-51b2-49d0-903a-d85af9eff3f1	3	17	17	104.31	81361800.00	81361800.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
68475d50-b3c0-41b8-a47d-6466dcc45fcc	a8403a9d-f6c9-46dc-8d7d-ba2209823023	4	2	12	136.37	110186960.00	110186960.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
67e891cb-d6f3-41a6-91b4-6a0ca13d9228	1a7da554-982b-4ffe-89f6-4beea55778dc	1	2	12	42.69	39573630.00	39573630.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
5a475581-0803-4f2e-9a32-5c34dac8b618	e71843d6-c63e-434b-843a-43edc28ecd07	2	2	12	68.19	57347790.00	57347790.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
0aef1af1-0613-4fe7-bf77-ee4dda04c31d	137a212a-d22c-4e28-b4f2-e3704d4d44fd	3	2	12	89.1	70478100.00	70478100.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
bbc016f2-0195-4e37-b9e6-c2e5998395b2	5ffe6d79-d45e-41d1-bdae-c65c6f9cd431	2	3	12	67.38	58014180.00	58014180.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
94351913-6f02-450a-8108-1acaefe91c56	6a6ce772-a72f-408f-bb4c-f0b31e70154d	3	3	12	113.08	86393120.00	86393120.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
436fdef7-acdd-4257-9741-08700484d99a	744b9a4f-bf09-4c79-9c32-bfde2f049d6c	1	4	12	41.88	44057760.00	44057760.00		2027-03-05	t	db559bf9-4004-4cd2-981b-917cbb7e06de
160bd0a4-4bfd-4856-b894-1876a54311a5	14079484-c5fa-4936-82b1-736f3b9d8375	2	2	9	70.9	67000500.00	67000500.00		2025-12-17	t	ec2e9bbe-381a-4093-9c12-15af262caaae
4508926c-a7eb-45fb-815a-8ed5903c1e1b	6132e6e5-47b5-4c11-8fad-d951a26c4bc1	4	2	9	131.9	119369500.00	119369500.00		2025-12-17	t	ec2e9bbe-381a-4093-9c12-15af262caaae
92d10103-e685-4731-926a-bc1c9411b9d0	420769b2-0709-4e86-bd6b-f1f64b3f1bfa	3	3	9	109.5	116398500.00	116398500.00		2025-12-17	t	ec2e9bbe-381a-4093-9c12-15af262caaae
98835549-093f-47d3-8ae2-e9520499bb9f	37a8acc5-137c-4597-becf-af019151244e	3	4	9	108.7	116526400.00	116526400.00		2025-12-17	t	ec2e9bbe-381a-4093-9c12-15af262caaae
effb9f75-17be-42c5-9b59-834c7c8672f7	1ddc63ec-b67f-4235-a3f9-7975c185dae3	4	5	9	141.76	134672000.00	134672000.00		2025-12-17	t	ec2e9bbe-381a-4093-9c12-15af262caaae
93e5de33-f0e2-464a-9c1e-8465cfbef32a	c1739596-ca9b-4e90-8514-72e830bc3af2	3	2	9	84.79	68171160.00	68171160.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
ee344ac7-10ab-406d-9044-e2c727ca1330	4e9e5df9-00bc-41dd-8afe-8ab4bc3d6f5a	4	4	9	131.27	113154740.00	113154740.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
e7a0794b-5147-4009-9212-909077928e2e	7d323e38-20fc-4e06-af74-69b8aaa7fc49	4	7	9	131.27	113154740.00	113154740.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
397b04e2-c422-43bc-a1db-c87c8d59d398	cc5f8fc3-b18b-4aaa-95e6-e3600d6adf0a	3	2	9	113.44	88936960.00	88936960.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
efeace84-5c19-435c-bf59-7092b50100e8	2ec06eba-eb57-419b-a718-10f02824995f	3	6	9	113.38	94785680.00	94785680.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
b457d817-a7ba-45b6-a691-f39b137310ee	01e9e574-45e8-4dd7-80e2-68f14c736a08	3	8	9	113.38	92518080.00	92518080.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
a33d7bb2-3afb-48e5-92bb-ac88a2403fc3	48536457-f786-4f94-9852-0619a385b11a	2	9	9	52.31	46555900.00	46555900.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
8605cbc0-a535-405b-9dc5-242673971e9b	988b0615-695c-4f6a-a920-f08fcfcda785	4	2	9	136.56	109111440.00	109111440.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
f1e99b1c-95c8-4c2d-bf66-0dd844dda17f	5bab0f77-7a0e-4e16-9a11-3d51723cad1d	3	2	9	101.28	81530400.00	81530400.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
bfd0b900-889e-49b2-87d6-3ccfaa6815f6	5452bca2-4173-4315-bb8f-57b7f45eba2c	1	4	9	45.99	42770700.00	42770700.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
d0825cfa-d686-4c0c-8105-6eb4a3078986	3225ec8f-95f7-4369-b2f8-4794ae073f39	2	6	9	51.31	47307820.00	47307820.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
ef34912a-5c0f-4d61-b6c8-75e38f858835	ddf84ad5-80fb-40c0-9a5d-4da6db0d0fda	2	2	9	71.24	60269040.00	60269040.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
98fffba1-8453-40b5-b4fe-4c2cad81fe91	65377561-0e90-4d66-9dfc-9984c35e2581	4	8	9	136.79	116818660.00	116818660.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
d127d5f7-be85-4b31-a425-a414c241125b	aa7bb255-474d-4207-a446-de82ee4c2444	2	9	9	70.64	60750400.00	60750400.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
101ad717-f097-4862-a739-1d7a763d7e51	3bc91fed-28ba-4b54-af1f-8b24d8b9d067	3	2	9	82.01	63803780.00	63803780.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
ed2e52bd-c05e-44af-9f7b-8a42c4c4d3b9	81f75650-531f-43e8-baea-fe72925d5fec	3	2	9	88.94	71507760.00	71507760.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
0fd0e91a-f455-41ef-ae32-d18dcf4c29df	c475285c-3f9d-4d06-9929-cd30492faddd	3	2	9	81.75	63601500.00	63601500.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
56b861f2-fd45-4cdf-bd94-996710aec324	375f3132-8d46-47d5-b9f3-44a9f07f51d4	3	3	9	101.15	86483250.00	86483250.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
482a96b4-b5cc-4fc0-bac5-3f757f41e708	65588cd5-1e31-4911-a0ab-0b31e2a9f5e4	2	5	9	69.85	62655450.00	62655450.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
91690c7e-e4fb-4271-abdf-6182c1064016	caf9653a-863f-4b66-9758-7dc82945f88a	2	3	9	70.82	62038320.00	62038320.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
6a3fa365-3e92-4df9-b4c7-7ffc3fe10c6f	f2faaa3b-a1a0-404b-ab3b-fec8e37ee3ff	2	2	9	52.94	47698940.00	47698940.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
d80d2489-7eae-431b-b11c-cd4044afa2a4	d77e5564-f3be-425c-a9c7-bdbd0cdab3ca	4	2	9	138.14	107334780.00	107334780.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
a6ff0dff-8c82-409c-8a7c-2541dff4b1a9	2044fbca-e18d-48e5-a287-105c6bc4901e	5	3	9	180.15	147002400.00	147002400.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
b110a119-2f5b-4f6f-bf06-970a1a6c6c1b	36663ea5-a6d7-4ead-9123-d8c5908bca24	2	3	9	52.77	48337320.00	48337320.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
c067283f-4a56-4f12-b573-cab70aff0c1d	815fcf80-bb99-42c3-8630-4f467c8925db	2	4	9	52.77	47651310.00	47651310.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
30863592-7ed4-4ac0-931a-c8c44c02f9cd	2d86a254-3197-4736-b8e1-a5724cca63ba	5	5	9	180.15	147723000.00	147723000.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
8552c3e3-dc1a-455d-9e67-50cd1fa67180	d46a006a-29ce-408d-a88b-abd3794a3a01	5	7	9	179.95	148458750.00	148458750.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
4117c0ee-e2ed-4c22-9db4-f64681a5110f	7ec03aec-532f-47db-8acf-519cb401cbf2	4	7	9	136.7	116195000.00	116195000.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
759ee9ca-a1bb-4e85-b104-9fbca8546a13	b5d96257-19c1-4df3-8b7c-864d14e5c259	5	8	9	176.38	150099380.00	150099380.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
1e556f3a-2315-4a5f-b470-d08b69fc1c77	572afbba-a48c-48c1-a971-7f144990567f	2	8	9	52.54	48126640.00	48126640.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
71a8c537-ad10-4505-bdd0-65048f6ec037	db35c006-525a-46be-b900-aad473ca0c03	4	8	9	136.71	114836400.00	114836400.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
2e27a4ab-214e-40a1-98bd-42adc314e71f	4a796d8b-4320-49e7-8968-c1960ab0e528	2	9	9	52.54	47601240.00	47601240.00		2026-05-22	t	ec2e9bbe-381a-4093-9c12-15af262caaae
12a04012-f3f8-43f9-a753-f4f6b63adb90	1991c06b-1cc8-4906-b45e-a870e48b9023	2	3	12	57.63	39079221.00	39079221.00		2027-02-05	t	268f202a-ef1a-4263-81d4-cfa593722772
37a74f5c-94d3-42c8-b150-363373950b7f	fec3c10c-0840-4451-8867-aaffc6dc31e3	3	7	18	107.25	115401000.00	115401000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
810505cf-53ca-4131-98e5-d9feb48fd9e5	af24ba17-1d57-4fe1-86e0-651d742f164c	5	5	20	160.63	161915040.00	161915040.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
6f4d6d6d-75c6-4d12-be6a-16bd1de15d82	3c8b6d9f-a329-4d54-953b-0b91cdea723c	5	4	7	239	283932000.00	283932000.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
21d216eb-03b3-4757-8a41-029d081894bc	67125464-14c7-4abe-8e6a-8330bd370105	3	7	9	132.29	160467770.00	160467770.00		2027-03-26	t	eaba4330-74fa-4f6a-8173-61daad13ddc9
62986eed-bb04-4667-9e99-74ced08abd3e	b51325e4-e7b8-4fac-8350-ba1b89151835	4	7	9	144.9	126063000.00	126063000.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
e8e8affd-ebfb-4d3e-92d3-e6a04b4d10d0	3184e44d-2873-4a0a-a85d-1840d50365e3	3	2	12	109.35	88682850.00	88682850.00		2026-08-28	t	53b406fa-fda1-4e13-87f5-67ec4c70a3f0
\.


--
-- Data for Name: django_admin_log; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_admin_log (id, action_time, object_id, object_repr, action_flag, change_message, content_type_id, user_id) FROM stdin;
\.


--
-- Data for Name: django_content_type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_content_type (id, app_label, model) FROM stdin;
1	admin	logentry
2	auth	permission
3	auth	group
4	auth	user
5	contenttypes	contenttype
6	sessions	session
7	whatsapp_bot	whatsappuser
8	telegram_bot	botuser
9	telegram_bot	secondaryproperty
10	telegram_bot	userfeedback
11	telegram_bot	usersession
12	telegram_bot	lead
13	telegram_bot	searchlog
14	telegram_bot	bicomplex
15	telegram_bot	biunit
\.


--
-- Data for Name: django_migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_migrations (id, app, name, applied) FROM stdin;
1	contenttypes	0001_initial	2026-01-15 14:08:22.729724+05
2	auth	0001_initial	2026-01-15 14:08:22.797959+05
3	admin	0001_initial	2026-01-15 14:08:22.817794+05
4	admin	0002_logentry_remove_auto_add	2026-01-15 14:08:22.827306+05
5	admin	0003_logentry_add_action_flag_choices	2026-01-15 14:08:22.835657+05
6	contenttypes	0002_remove_content_type_name	2026-01-15 14:08:22.853997+05
7	auth	0002_alter_permission_name_max_length	2026-01-15 14:08:22.864183+05
8	auth	0003_alter_user_email_max_length	2026-01-15 14:08:22.87001+05
9	auth	0004_alter_user_username_opts	2026-01-15 14:08:22.877947+05
10	auth	0005_alter_user_last_login_null	2026-01-15 14:08:22.888595+05
11	auth	0006_require_contenttypes_0002	2026-01-15 14:08:22.890772+05
12	auth	0007_alter_validators_add_error_messages	2026-01-15 14:08:22.900997+05
13	auth	0008_alter_user_username_max_length	2026-01-15 14:08:22.915188+05
14	auth	0009_alter_user_last_name_max_length	2026-01-15 14:08:22.923462+05
15	auth	0010_alter_group_name_max_length	2026-01-15 14:08:22.928517+05
16	auth	0011_update_proxy_permissions	2026-01-15 14:08:22.93293+05
17	auth	0012_alter_user_first_name_max_length	2026-01-15 14:08:22.938852+05
18	sessions	0001_initial	2026-01-15 14:08:22.944011+05
19	telegram_bot	0001_initial	2026-01-15 14:08:23.041201+05
20	whatsapp_bot	0001_initial	2026-01-15 14:08:23.047911+05
21	telegram_bot	0002_bicomplex_biunit	2026-01-15 16:19:30.665433+05
22	telegram_bot	0003_enable_pgvector	2026-01-20 02:32:52.758925+05
23	telegram_bot	0004_merge_0002_bicomplex_biunit_0003_enable_pgvector	2026-01-20 02:32:52.761587+05
24	telegram_bot	0005_rename_website_bicomplex_url_bicomplex_description_and_more	2026-01-20 02:35:44.511943+05
\.


--
-- Data for Name: django_session; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.django_session (session_key, session_data, expire_date) FROM stdin;
j9qqshofeyzc6tl9ehgubaacm15smvlj	.eJxVjMsOwiAQRf-FtSE8WgGX7v0GMsMMUjWQlHZl_HfbpAvdnnPufYsI61Li2nmOE4mL0OL0yxDSk-su6AH13mRqdZknlHsiD9vlrRG_rkf7d1Cgl23tLbIPBoakMVsDmch4hjMjWOfBE9hx9CZoF5JVQbkAOalhw5qQgxWfL_zKOGM:1vi6M4:pT8SNeuIeYBthfcTrNsand5ERcPVZxM1eZG7Ao5aNhc	2026-02-03 12:40:48.050901+05
\.


--
-- Data for Name: telegram_bot_botuser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_botuser (id, platform, user_id, name, created_at, updated_at, last_active_at, total_searches, total_messages, is_active, language) FROM stdin;
7e9020fc-d6d8-4b85-8883-c136374b082b	telegram	872799354	Anu	2026-01-15 14:24:44.730678+05	2026-01-15 14:24:44.73069+05	2026-01-15 14:24:44.730693+05	0	0	t	ru
6e84fd8f-fa6b-4294-b1c1-60451f7987a2	telegram	468453981	Аmina	2026-01-20 15:33:25.403199+05	2026-01-20 15:33:25.403217+05	2026-01-20 15:33:25.403223+05	0	0	t	ru
\.


--
-- Data for Name: telegram_bot_lead; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_lead (id, request_text, search_params, status, assigned_to, manager_notes, created_at, updated_at, contacted_at, closed_at, priority, user_id) FROM stdin;
1	Запрос на эксперта. Контекст: {'city': 'Astana', 'rooms': 1, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 30000000, 'min_price': None, 'confidence': 0.95, 'district_text': 'Байтерек', 'property_type': 'any', 'embedding_text': 'Байтерек', 'floor_preferences': [], 'extracted_entities': {'price': '30 млн'}}	{}	new	\N		2026-01-20 02:58:21.725895+05	2026-01-20 02:58:21.725924+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
2	Запрос на эксперта. Контекст: {'city': 'Astana', 'rooms': 2, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 50000000, 'min_price': 30000000, 'confidence': 0.95, 'district_text': 'Правый берег', 'property_type': 'any', 'embedding_text': 'Правый берег', 'floor_preferences': [], 'extracted_entities': {'price': '30-50 млн'}}	{}	new	\N		2026-01-20 09:11:12.955234+05	2026-01-20 09:11:12.955256+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
3	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'rooms': 2, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 50000000, 'min_price': 30000000, 'confidence': 0.95, 'district_text': 'Левый берег', 'property_type': 'any', 'embedding_text': 'Левый берег', 'floor_preferences': [], 'extracted_entities': {'price': '30-50 млн'}}	{}	new	\N		2026-01-20 12:09:37.589739+05	2026-01-20 12:09:37.589768+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
4	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'rooms': 3, 'offset': 5, 'source': 'bi', 'max_area': 60.0, 'min_area': 40.0, 'max_price': 80000000, 'min_price': 50000000, 'confidence': 0.9, 'property_type': 'any', 'embedding_text': 'Найди мне рядом Хан Шатыр', 'floor_preferences': ['not_first'], 'extracted_entities': {'price': '50-80 млн'}}	{}	new	\N		2026-01-20 13:26:02.741435+05	2026-01-20 13:26:02.741456+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
5	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'rooms': None, 'offset': 10, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 80000000, 'min_price': 50000000, 'confidence': 0.95, 'property_type': 'any', 'embedding_text': 'рядом Хан Шатыр', 'floor_preferences': [], 'extracted_entities': {'price': '50-80 млн'}}	{}	new	\N		2026-01-20 13:37:58.634854+05	2026-01-20 13:37:58.634889+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
6	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'offset': 5, 'source': 'bi', 'max_price': 80000000, 'min_price': 50000000, 'confidence': 0.95, 'property_type': 'any', 'embedding_text': 'рядом Хан Шатыр', 'floor_preferences': [], 'extracted_entities': {'price': '50-80 млн'}}	{}	new	\N		2026-01-20 14:00:02.684608+05	2026-01-20 14:00:02.684642+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
7	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'rooms': None, 'offset': 0, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 80000000, 'min_price': 50000000, 'radius_km': 0.5, 'confidence': 0.95, 'coordinates': {'lat': 51.091, 'lon': 71.417}, 'property_type': 'any', 'embedding_text': 'Найди мне ЖК в 500 метров рядом Назарбаевский университет', 'floor_preferences': [], 'extracted_entities': {'price': '50-80 млн'}}	{}	new	\N		2026-01-20 15:30:23.227347+05	2026-01-20 15:30:23.227383+05	\N	\N	0	7e9020fc-d6d8-4b85-8883-c136374b082b
8	Заявка на эксперта. Контекст поиска: {'city': 'Astana', 'rooms': 3, 'offset': 5, 'source': 'bi', 'max_area': None, 'min_area': None, 'max_price': 50000000, 'min_price': 30000000, 'radius_km': 5.0, 'confidence': 0.95, 'coordinates': {'lat': 51.091, 'lon': 71.417}, 'property_type': 'any', 'embedding_text': 'EXPO', 'floor_preferences': [], 'extracted_entities': {'price': '30-50 млн'}}	{}	in_progress	Анварбек		2026-01-20 15:35:20.792576+05	2026-01-20 15:41:07.268914+05	\N	\N	5	6e84fd8f-fa6b-4294-b1c1-60451f7987a2
\.


--
-- Data for Name: telegram_bot_searchlog; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_searchlog (id, query_text, detected_intent, detected_city, detected_district, lifestyle_tags, ai_confidence, results_count, bi_group_count, secondary_count, search_duration_ms, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: telegram_bot_secondaryproperty; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_secondaryproperty (id, title, description, address, price, rooms, area, floor, total_floors, city, district, latitude, longitude, owner_phone, owner_name, has_parking, has_balcony, has_renovation, image, is_active, is_verified, created_at, updated_at, views_count, embedding) FROM stdin;
\.


--
-- Data for Name: telegram_bot_userfeedback; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_userfeedback (id, feedback_type, rating, comment, property_id, created_at, user_id) FROM stdin;
\.


--
-- Data for Name: telegram_bot_usersession; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.telegram_bot_usersession (id, current_intent, search_params, conversation_history, created_at, updated_at, expires_at, user_id, state) FROM stdin;
2	START	{}	[]	2026-01-20 15:33:25.409409+05	2026-01-20 15:35:20.796582+05	\N	6e84fd8f-fa6b-4294-b1c1-60451f7987a2	START
1	BROWSING	{"city": "Astana", "rooms": null, "offset": 1, "source": "bi", "max_area": null, "min_area": null, "max_price": 50000000, "min_price": 10000000, "radius_km": 5.0, "confidence": 0.95, "coordinates": {"lat": 51.027, "lon": 71.461}, "property_type": "any", "embedding_text": "рядом аэропорт", "floor_preferences": [], "extracted_entities": {"price": "10-50 млн"}}	[]	2026-01-15 14:24:44.73523+05	2026-01-20 15:32:00.924243+05	\N	7e9020fc-d6d8-4b85-8883-c136374b082b	START
\.


--
-- Data for Name: whatsapp_bot_whatsappuser; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.whatsapp_bot_whatsappuser (id, phone_number, name, created_at, updated_at) FROM stdin;
\.


--
-- Name: auth_group_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_id_seq', 1, false);


--
-- Name: auth_group_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_group_permissions_id_seq', 1, false);


--
-- Name: auth_permission_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_permission_id_seq', 60, true);


--
-- Name: auth_user_groups_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_groups_id_seq', 1, false);


--
-- Name: auth_user_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_id_seq', 1, true);


--
-- Name: auth_user_user_permissions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.auth_user_user_permissions_id_seq', 1, false);


--
-- Name: django_admin_log_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_admin_log_id_seq', 1, false);


--
-- Name: django_content_type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_content_type_id_seq', 15, true);


--
-- Name: django_migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.django_migrations_id_seq', 24, true);


--
-- Name: telegram_bot_lead_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.telegram_bot_lead_id_seq', 8, true);


--
-- Name: telegram_bot_userfeedback_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.telegram_bot_userfeedback_id_seq', 1, false);


--
-- Name: telegram_bot_usersession_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.telegram_bot_usersession_id_seq', 2, true);


--
-- Name: whatsapp_bot_whatsappuser_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.whatsapp_bot_whatsappuser_id_seq', 1, false);


--
-- Name: auth_group auth_group_name_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_name_key UNIQUE (name);


--
-- Name: auth_group_permissions auth_group_permissions_group_id_permission_id_0cd325b0_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_permission_id_0cd325b0_uniq UNIQUE (group_id, permission_id);


--
-- Name: auth_group_permissions auth_group_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_group auth_group_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group
    ADD CONSTRAINT auth_group_pkey PRIMARY KEY (id);


--
-- Name: auth_permission auth_permission_content_type_id_codename_01ab375a_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_codename_01ab375a_uniq UNIQUE (content_type_id, codename);


--
-- Name: auth_permission auth_permission_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_pkey PRIMARY KEY (id);


--
-- Name: auth_user_groups auth_user_groups_user_id_group_id_94350c0c_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_group_id_94350c0c_uniq UNIQUE (user_id, group_id);


--
-- Name: auth_user auth_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_pkey PRIMARY KEY (id);


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_permission_id_14a6b632_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_permission_id_14a6b632_uniq UNIQUE (user_id, permission_id);


--
-- Name: auth_user auth_user_username_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user
    ADD CONSTRAINT auth_user_username_key UNIQUE (username);


--
-- Name: bi_complexes bi_complexes_bi_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bi_complexes
    ADD CONSTRAINT bi_complexes_bi_uuid_key UNIQUE (bi_uuid);


--
-- Name: bi_complexes bi_complexes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bi_complexes
    ADD CONSTRAINT bi_complexes_pkey PRIMARY KEY (id);


--
-- Name: bi_units bi_units_bi_uuid_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bi_units
    ADD CONSTRAINT bi_units_bi_uuid_key UNIQUE (bi_uuid);


--
-- Name: bi_units bi_units_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bi_units
    ADD CONSTRAINT bi_units_pkey PRIMARY KEY (id);


--
-- Name: django_admin_log django_admin_log_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_pkey PRIMARY KEY (id);


--
-- Name: django_content_type django_content_type_app_label_model_76bd3d3b_uniq; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_app_label_model_76bd3d3b_uniq UNIQUE (app_label, model);


--
-- Name: django_content_type django_content_type_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_content_type
    ADD CONSTRAINT django_content_type_pkey PRIMARY KEY (id);


--
-- Name: django_migrations django_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_migrations
    ADD CONSTRAINT django_migrations_pkey PRIMARY KEY (id);


--
-- Name: django_session django_session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_session
    ADD CONSTRAINT django_session_pkey PRIMARY KEY (session_key);


--
-- Name: telegram_bot_botuser telegram_bot_botuser_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_botuser
    ADD CONSTRAINT telegram_bot_botuser_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_botuser telegram_bot_botuser_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_botuser
    ADD CONSTRAINT telegram_bot_botuser_user_id_key UNIQUE (user_id);


--
-- Name: telegram_bot_lead telegram_bot_lead_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_lead
    ADD CONSTRAINT telegram_bot_lead_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_searchlog telegram_bot_searchlog_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_searchlog
    ADD CONSTRAINT telegram_bot_searchlog_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_secondaryproperty telegram_bot_secondaryproperty_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_secondaryproperty
    ADD CONSTRAINT telegram_bot_secondaryproperty_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_userfeedback telegram_bot_userfeedback_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_userfeedback
    ADD CONSTRAINT telegram_bot_userfeedback_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_usersession telegram_bot_usersession_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_usersession
    ADD CONSTRAINT telegram_bot_usersession_pkey PRIMARY KEY (id);


--
-- Name: telegram_bot_usersession telegram_bot_usersession_user_id_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_usersession
    ADD CONSTRAINT telegram_bot_usersession_user_id_key UNIQUE (user_id);


--
-- Name: whatsapp_bot_whatsappuser whatsapp_bot_whatsappuser_phone_number_key; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_bot_whatsappuser
    ADD CONSTRAINT whatsapp_bot_whatsappuser_phone_number_key UNIQUE (phone_number);


--
-- Name: whatsapp_bot_whatsappuser whatsapp_bot_whatsappuser_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.whatsapp_bot_whatsappuser
    ADD CONSTRAINT whatsapp_bot_whatsappuser_pkey PRIMARY KEY (id);


--
-- Name: auth_group_name_a6ea08ec_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_name_a6ea08ec_like ON public.auth_group USING btree (name varchar_pattern_ops);


--
-- Name: auth_group_permissions_group_id_b120cbf9; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_group_id_b120cbf9 ON public.auth_group_permissions USING btree (group_id);


--
-- Name: auth_group_permissions_permission_id_84c5c92e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_group_permissions_permission_id_84c5c92e ON public.auth_group_permissions USING btree (permission_id);


--
-- Name: auth_permission_content_type_id_2f476e4b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_permission_content_type_id_2f476e4b ON public.auth_permission USING btree (content_type_id);


--
-- Name: auth_user_groups_group_id_97559544; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_group_id_97559544 ON public.auth_user_groups USING btree (group_id);


--
-- Name: auth_user_groups_user_id_6a12ed8b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_groups_user_id_6a12ed8b ON public.auth_user_groups USING btree (user_id);


--
-- Name: auth_user_user_permissions_permission_id_1fbb5f2c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_permission_id_1fbb5f2c ON public.auth_user_user_permissions USING btree (permission_id);


--
-- Name: auth_user_user_permissions_user_id_a95ead1b; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_user_permissions_user_id_a95ead1b ON public.auth_user_user_permissions USING btree (user_id);


--
-- Name: auth_user_username_6821ab7c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX auth_user_username_6821ab7c_like ON public.auth_user USING btree (username varchar_pattern_ops);


--
-- Name: bi_complexes_bi_uuid_a2a6896c_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_complexes_bi_uuid_a2a6896c_like ON public.bi_complexes USING btree (bi_uuid varchar_pattern_ops);


--
-- Name: bi_complexes_city_uuid_fa3c647a; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_complexes_city_uuid_fa3c647a ON public.bi_complexes USING btree (city_uuid);


--
-- Name: bi_complexes_city_uuid_fa3c647a_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_complexes_city_uuid_fa3c647a_like ON public.bi_complexes USING btree (city_uuid varchar_pattern_ops);


--
-- Name: bi_units_area_f1eed0_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_units_area_f1eed0_idx ON public.bi_units USING btree (area);


--
-- Name: bi_units_bi_uuid_1b16f04a_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_units_bi_uuid_1b16f04a_like ON public.bi_units USING btree (bi_uuid varchar_pattern_ops);


--
-- Name: bi_units_complex_id_d7119ef4; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_units_complex_id_d7119ef4 ON public.bi_units USING btree (complex_id);


--
-- Name: bi_units_price_d_3c0521_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_units_price_d_3c0521_idx ON public.bi_units USING btree (price_discount, room_count);


--
-- Name: bi_units_room_count_9823fee7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX bi_units_room_count_9823fee7 ON public.bi_units USING btree (room_count);


--
-- Name: django_admin_log_content_type_id_c4bce8eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_content_type_id_c4bce8eb ON public.django_admin_log USING btree (content_type_id);


--
-- Name: django_admin_log_user_id_c564eba6; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_admin_log_user_id_c564eba6 ON public.django_admin_log USING btree (user_id);


--
-- Name: django_session_expire_date_a5c62663; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_expire_date_a5c62663 ON public.django_session USING btree (expire_date);


--
-- Name: django_session_session_key_c0390e0f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX django_session_session_key_c0390e0f_like ON public.django_session USING btree (session_key varchar_pattern_ops);


--
-- Name: telegram_bo_city_7ea1e0_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_city_7ea1e0_idx ON public.telegram_bot_secondaryproperty USING btree (city, rooms, price);


--
-- Name: telegram_bo_created_512a93_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_created_512a93_idx ON public.telegram_bot_searchlog USING btree (created_at DESC);


--
-- Name: telegram_bo_created_ca4a75_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_created_ca4a75_idx ON public.telegram_bot_botuser USING btree (created_at);


--
-- Name: telegram_bo_detecte_d6d46b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_detecte_d6d46b_idx ON public.telegram_bot_searchlog USING btree (detected_city, created_at DESC);


--
-- Name: telegram_bo_distric_812c3b_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_distric_812c3b_idx ON public.telegram_bot_secondaryproperty USING btree (district, created_at DESC);


--
-- Name: telegram_bo_is_acti_e756bf_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_is_acti_e756bf_idx ON public.telegram_bot_secondaryproperty USING btree (is_active, created_at DESC);


--
-- Name: telegram_bo_last_ac_77624c_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_last_ac_77624c_idx ON public.telegram_bot_botuser USING btree (last_active_at);


--
-- Name: telegram_bo_platfor_566670_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_platfor_566670_idx ON public.telegram_bot_botuser USING btree (platform, user_id);


--
-- Name: telegram_bo_priorit_da0de4_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_priorit_da0de4_idx ON public.telegram_bot_lead USING btree (priority DESC, created_at DESC);


--
-- Name: telegram_bo_status_551593_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bo_status_551593_idx ON public.telegram_bot_lead USING btree (status, created_at DESC);


--
-- Name: telegram_bot_botuser_created_at_3b098a9e; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_botuser_created_at_3b098a9e ON public.telegram_bot_botuser USING btree (created_at);


--
-- Name: telegram_bot_botuser_platform_51119c06; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_botuser_platform_51119c06 ON public.telegram_bot_botuser USING btree (platform);


--
-- Name: telegram_bot_botuser_platform_51119c06_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_botuser_platform_51119c06_like ON public.telegram_bot_botuser USING btree (platform varchar_pattern_ops);


--
-- Name: telegram_bot_botuser_user_id_096041e9_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_botuser_user_id_096041e9_like ON public.telegram_bot_botuser USING btree (user_id varchar_pattern_ops);


--
-- Name: telegram_bot_lead_created_at_e007ada5; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_lead_created_at_e007ada5 ON public.telegram_bot_lead USING btree (created_at);


--
-- Name: telegram_bot_lead_status_234a80ae; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_lead_status_234a80ae ON public.telegram_bot_lead USING btree (status);


--
-- Name: telegram_bot_lead_status_234a80ae_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_lead_status_234a80ae_like ON public.telegram_bot_lead USING btree (status varchar_pattern_ops);


--
-- Name: telegram_bot_lead_user_id_13f1774c; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_lead_user_id_13f1774c ON public.telegram_bot_lead USING btree (user_id);


--
-- Name: telegram_bot_searchlog_created_at_bcf8dab7; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_searchlog_created_at_bcf8dab7 ON public.telegram_bot_searchlog USING btree (created_at);


--
-- Name: telegram_bot_searchlog_user_id_b31b8462; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_searchlog_user_id_b31b8462 ON public.telegram_bot_searchlog USING btree (user_id);


--
-- Name: telegram_bot_secondaryproperty_address_1c73ff18; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_address_1c73ff18 ON public.telegram_bot_secondaryproperty USING btree (address);


--
-- Name: telegram_bot_secondaryproperty_address_1c73ff18_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_address_1c73ff18_like ON public.telegram_bot_secondaryproperty USING btree (address varchar_pattern_ops);


--
-- Name: telegram_bot_secondaryproperty_city_ddc6d418; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_city_ddc6d418 ON public.telegram_bot_secondaryproperty USING btree (city);


--
-- Name: telegram_bot_secondaryproperty_city_ddc6d418_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_city_ddc6d418_like ON public.telegram_bot_secondaryproperty USING btree (city varchar_pattern_ops);


--
-- Name: telegram_bot_secondaryproperty_created_at_66fee04f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_created_at_66fee04f ON public.telegram_bot_secondaryproperty USING btree (created_at);


--
-- Name: telegram_bot_secondaryproperty_district_76931b7f; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_district_76931b7f ON public.telegram_bot_secondaryproperty USING btree (district);


--
-- Name: telegram_bot_secondaryproperty_district_76931b7f_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_district_76931b7f_like ON public.telegram_bot_secondaryproperty USING btree (district varchar_pattern_ops);


--
-- Name: telegram_bot_secondaryproperty_is_active_6de3aaa2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_is_active_6de3aaa2 ON public.telegram_bot_secondaryproperty USING btree (is_active);


--
-- Name: telegram_bot_secondaryproperty_rooms_740d56eb; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_rooms_740d56eb ON public.telegram_bot_secondaryproperty USING btree (rooms);


--
-- Name: telegram_bot_secondaryproperty_title_01d99009; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_title_01d99009 ON public.telegram_bot_secondaryproperty USING btree (title);


--
-- Name: telegram_bot_secondaryproperty_title_01d99009_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_secondaryproperty_title_01d99009_like ON public.telegram_bot_secondaryproperty USING btree (title varchar_pattern_ops);


--
-- Name: telegram_bot_userfeedback_user_id_e1b293a2; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX telegram_bot_userfeedback_user_id_e1b293a2 ON public.telegram_bot_userfeedback USING btree (user_id);


--
-- Name: whatsapp_bot_whatsappuser_phone_number_aa314366_like; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX whatsapp_bot_whatsappuser_phone_number_aa314366_like ON public.whatsapp_bot_whatsappuser USING btree (phone_number varchar_pattern_ops);


--
-- Name: auth_group_permissions auth_group_permissio_permission_id_84c5c92e_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissio_permission_id_84c5c92e_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_group_permissions auth_group_permissions_group_id_b120cbf9_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_group_permissions
    ADD CONSTRAINT auth_group_permissions_group_id_b120cbf9_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_permission auth_permission_content_type_id_2f476e4b_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_permission
    ADD CONSTRAINT auth_permission_content_type_id_2f476e4b_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_group_id_97559544_fk_auth_group_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_group_id_97559544_fk_auth_group_id FOREIGN KEY (group_id) REFERENCES public.auth_group(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_groups auth_user_groups_user_id_6a12ed8b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_groups
    ADD CONSTRAINT auth_user_groups_user_id_6a12ed8b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm FOREIGN KEY (permission_id) REFERENCES public.auth_permission(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: auth_user_user_permissions auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.auth_user_user_permissions
    ADD CONSTRAINT auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: bi_units bi_units_complex_id_d7119ef4_fk_bi_complexes_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.bi_units
    ADD CONSTRAINT bi_units_complex_id_d7119ef4_fk_bi_complexes_id FOREIGN KEY (complex_id) REFERENCES public.bi_complexes(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_content_type_id_c4bce8eb_fk_django_co; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_content_type_id_c4bce8eb_fk_django_co FOREIGN KEY (content_type_id) REFERENCES public.django_content_type(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: django_admin_log django_admin_log_user_id_c564eba6_fk_auth_user_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.django_admin_log
    ADD CONSTRAINT django_admin_log_user_id_c564eba6_fk_auth_user_id FOREIGN KEY (user_id) REFERENCES public.auth_user(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telegram_bot_lead telegram_bot_lead_user_id_13f1774c_fk_telegram_bot_botuser_id; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_lead
    ADD CONSTRAINT telegram_bot_lead_user_id_13f1774c_fk_telegram_bot_botuser_id FOREIGN KEY (user_id) REFERENCES public.telegram_bot_botuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telegram_bot_searchlog telegram_bot_searchl_user_id_b31b8462_fk_telegram_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_searchlog
    ADD CONSTRAINT telegram_bot_searchl_user_id_b31b8462_fk_telegram_ FOREIGN KEY (user_id) REFERENCES public.telegram_bot_botuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telegram_bot_userfeedback telegram_bot_userfee_user_id_e1b293a2_fk_telegram_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_userfeedback
    ADD CONSTRAINT telegram_bot_userfee_user_id_e1b293a2_fk_telegram_ FOREIGN KEY (user_id) REFERENCES public.telegram_bot_botuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- Name: telegram_bot_usersession telegram_bot_userses_user_id_9c4f6916_fk_telegram_; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.telegram_bot_usersession
    ADD CONSTRAINT telegram_bot_userses_user_id_9c4f6916_fk_telegram_ FOREIGN KEY (user_id) REFERENCES public.telegram_bot_botuser(id) DEFERRABLE INITIALLY DEFERRED;


--
-- PostgreSQL database dump complete
--

\unrestrict IzxF8cvZZv48iyTy100veGNHmEIiB9ZeLwEh2iIdetZivfIi32Ab9o1goue4J1c

