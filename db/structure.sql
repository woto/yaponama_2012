--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: a1s; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE a1s (
    id integer NOT NULL,
    name character varying(255),
    parent_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: a1s_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE a1s_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: a1s_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE a1s_id_seq OWNED BY a1s.id;


--
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE account_transactions (
    id integer NOT NULL,
    account_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    product_transaction_id integer,
    comment text,
    debit_before numeric,
    debit_after numeric,
    credit_before numeric,
    credit_after numeric,
    accountable_id_before integer,
    accountable_id_after integer,
    accountable_type_before character varying(255),
    accountable_type_after character varying(255),
    content_before text,
    content_after text,
    created_at timestamp without time zone
);


--
-- Name: account_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE account_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: account_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE account_transactions_id_seq OWNED BY account_transactions.id;


--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE accounts (
    id integer NOT NULL,
    debit numeric(8,2) DEFAULT 0,
    credit numeric(8,2) DEFAULT 0,
    accountable_id integer,
    accountable_type character varying(255),
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: accounts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE accounts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: accounts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE accounts_id_seq OWNED BY accounts.id;


--
-- Name: admin_blocks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_blocks (
    id integer NOT NULL,
    content text,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: admin_blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_blocks_id_seq OWNED BY admin_blocks.id;


--
-- Name: admin_site_settings; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE admin_site_settings (
    id integer NOT NULL,
    environment character varying(255),
    sms_notify_method character varying(255),
    send_request_from_search_page boolean,
    price_request_cache_with_replacements_in_seconds integer,
    price_request_cache_without_replacements_in_seconds integer,
    request_emex boolean,
    emex_income_rate double precision,
    avtorif_income_rate double precision,
    retail_rate double precision,
    robokassa_integration_mode character varying(255),
    robokassa_pass_1 character varying(255),
    robokassa_pass_2 character varying(255),
    robokassa_user character varying(255),
    google_maps_key character varying(255),
    travel_mode character varying(255),
    initial_map_lat double precision,
    initial_map_lng double precision,
    initial_map_zoom integer,
    delivery_minute_cost double precision,
    warehouse_address character varying(255),
    checkout_account character varying(255),
    checkout_bank character varying(255),
    checkout_bik character varying(255),
    checkout_correspondent character varying(255),
    checkout_inn character varying(255),
    checkout_recipient character varying(255),
    counter_yandex text,
    counter_mail text,
    counter_rambler text,
    counter_google text,
    counter_openstat text,
    counter_liveinternet text,
    default_user_prepayment double precision,
    default_user_discount double precision,
    default_user_order_rule character varying(255),
    avisosms_username character varying(255),
    avisosms_password character varying(255),
    avisosms_source_address character varying(255),
    avisosms_delivery_report character varying(255),
    avisosms_flash_message character varying(255),
    avisosms_validity_period character varying(255),
    site_address character varying(255),
    site_port character varying(255),
    redis_address character varying(255),
    redis_port character varying(255),
    socket_io_address character varying(255),
    socket_io_port character varying(255),
    juggernaut_address character varying(255),
    juggernaut_port character varying(255),
    price_address character varying(255),
    price_port character varying(255),
    get_image_data_address character varying(255),
    get_image_data_port character varying(255),
    google_oauth2_key character varying(255),
    google_oauth2_secret character varying(255),
    facebook_key character varying(255),
    facebook_secret character varying(255),
    yandex_key character varying(255),
    yandex_secret character varying(255),
    twitter_key character varying(255),
    twitter_secret character varying(255),
    vkontakte_key character varying(255),
    vkontakte_secret character varying(255),
    odnoklassniki_key character varying(255),
    odnoklassniki_secret character varying(255),
    mailru_key character varying(255),
    mailru_secret character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: admin_site_settings_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE admin_site_settings_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: admin_site_settings_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE admin_site_settings_id_seq OWNED BY admin_site_settings.id;


--
-- Name: attachments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE attachments (
    id integer NOT NULL,
    email_id integer,
    attachment character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: attachments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE attachments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attachments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE attachments_id_seq OWNED BY attachments.id;


--
-- Name: auths; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auths (
    id integer NOT NULL,
    provider character varying(255),
    uid character varying(255),
    user_id integer,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: auths_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE auths_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: auths_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE auths_id_seq OWNED BY auths.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brands (
    id integer NOT NULL,
    name character varying(255),
    brand_id integer,
    image character varying(255),
    rating integer,
    content text,
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: brands_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE brands_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brands_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE brands_id_seq OWNED BY brands.id;


--
-- Name: calls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE calls (
    id integer NOT NULL,
    phone_id integer,
    file character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: calls_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE calls_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: calls_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE calls_id_seq OWNED BY calls.id;


--
-- Name: car_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE car_transactions (
    id integer NOT NULL,
    car_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    god_before integer,
    god_after integer,
    period_before character varying(255),
    period_after character varying(255),
    brand_before character varying(255),
    brand_after character varying(255),
    model_before character varying(255),
    model_after character varying(255),
    generation_before character varying(255),
    generation_after character varying(255),
    modification_before character varying(255),
    modification_after character varying(255),
    dvigatel_before character varying(255),
    dvigatel_after character varying(255),
    tip_before character varying(255),
    tip_after character varying(255),
    moschnost_before character varying(255),
    moschnost_after character varying(255),
    privod_before character varying(255),
    privod_after character varying(255),
    tip_kuzova_before character varying(255),
    tip_kuzova_after character varying(255),
    kpp_before character varying(255),
    kpp_after character varying(255),
    kod_kuzova_before character varying(255),
    kod_kuzova_after character varying(255),
    kod_dvigatelya_before character varying(255),
    kod_dvigatelya_after character varying(255),
    rinok_before character varying(255),
    rinok_after character varying(255),
    vin_before character varying(255),
    vin_after character varying(255),
    frame_before character varying(255),
    frame_after character varying(255),
    komplektaciya_before character varying(255),
    komplektaciya_after character varying(255),
    dverey_before integer,
    dverey_after integer,
    rul_before character varying(255),
    rul_after character varying(255),
    car_number_before character varying(255),
    car_number_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: car_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE car_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: car_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE car_transactions_id_seq OWNED BY car_transactions.id;


--
-- Name: cars; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE cars (
    id integer NOT NULL,
    god integer,
    period character varying(255),
    brand character varying(255),
    model character varying(255),
    generation character varying(255),
    modification character varying(255),
    dvigatel character varying(255),
    tip character varying(255),
    moschnost character varying(255),
    privod character varying(255),
    tip_kuzova character varying(255),
    kpp character varying(255),
    kod_kuzova character varying(255),
    kod_dvigatelya character varying(255),
    rinok character varying(255),
    vin character varying(255),
    frame character varying(255),
    komplektaciya character varying(255),
    dverey integer,
    rul character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    car_number character varying(255),
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: cars_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE cars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: cars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE cars_id_seq OWNED BY cars.id;


--
-- Name: comments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE comments (
    id integer NOT NULL,
    creator_id integer,
    content text,
    commentable_id integer,
    commentable_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    ancestry character varying(255)
);


--
-- Name: comments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE comments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: comments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE comments_id_seq OWNED BY comments.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    ownership character varying(255),
    name character varying(255),
    inn character varying(255),
    kpp character varying(255),
    ogrn character varying(255),
    account character varying(255),
    bank character varying(255),
    bik character varying(255),
    correspondent character varying(255),
    okpo character varying(255),
    okved character varying(255),
    okato character varying(255),
    legal_address_id integer,
    actual_address_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: companies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE companies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: companies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE companies_id_seq OWNED BY companies.id;


--
-- Name: company_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE company_transactions (
    id integer NOT NULL,
    company_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    ownership_before character varying(255),
    ownership_after character varying(255),
    name_before character varying(255),
    name_after character varying(255),
    inn_before character varying(255),
    inn_after character varying(255),
    kpp_before character varying(255),
    kpp_after character varying(255),
    ogrn_before character varying(255),
    ogrn_after character varying(255),
    account_before character varying(255),
    account_after character varying(255),
    bank_before character varying(255),
    bank_after character varying(255),
    bik_before character varying(255),
    bik_after character varying(255),
    correspondent_before character varying(255),
    correspondent_after character varying(255),
    okpo_before character varying(255),
    okpo_after character varying(255),
    okved_before character varying(255),
    okved_after character varying(255),
    okato_before character varying(255),
    okato_after character varying(255),
    legal_address_id_before integer,
    legal_address_id_after integer,
    actual_address_id_before integer,
    actual_address_id_after integer,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: company_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE company_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: company_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE company_transactions_id_seq OWNED BY company_transactions.id;


--
-- Name: delayed_jobs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delayed_jobs (
    id integer NOT NULL,
    priority integer DEFAULT 0,
    attempts integer DEFAULT 0,
    handler text,
    last_error text,
    run_at timestamp without time zone,
    locked_at timestamp without time zone,
    failed_at timestamp without time zone,
    locked_by character varying(255),
    queue character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delayed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delayed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delayed_jobs_id_seq OWNED BY delayed_jobs.id;


--
-- Name: deliveries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deliveries (
    id integer NOT NULL,
    name character varying(255),
    content text,
    available boolean DEFAULT true,
    type character varying(255),
    sequence integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveries_id_seq OWNED BY deliveries.id;


--
-- Name: delivery_zones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE delivery_zones (
    id integer NOT NULL,
    name character varying(255),
    content text,
    vertices text,
    active_fill_color character varying(255),
    active_fill_opacity character varying(255),
    active_stroke_color character varying(255),
    active_stroke_opacity character varying(255),
    active_stroke_weight character varying(255),
    inactive_fill_color character varying(255),
    inactive_fill_opacity character varying(255),
    inactive_stroke_color character varying(255),
    inactive_stroke_opacity character varying(255),
    inactive_stroke_weight character varying(255),
    lat double precision,
    lng double precision,
    zoom integer,
    z_index integer,
    display_marker boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: delivery_zones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE delivery_zones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: delivery_zones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE delivery_zones_id_seq OWNED BY delivery_zones.id;


--
-- Name: email_address_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE email_address_transactions (
    id integer NOT NULL,
    email_address_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    email_address_before character varying(255),
    email_address_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    confirmed_by_user_before boolean,
    confirmed_by_user_after boolean,
    confirmed_by_manager_before boolean,
    confirmed_by_manager_after boolean,
    user_confirmation_datetime_before timestamp without time zone,
    user_confirmation_datetime_after timestamp without time zone,
    manager_confirmation_datetime_before timestamp without time zone,
    manager_confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying(255),
    confirmation_token_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: email_address_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_address_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_address_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_address_transactions_id_seq OWNED BY email_address_transactions.id;


--
-- Name: email_addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE email_addresses (
    id integer NOT NULL,
    email_address character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed_by_user boolean DEFAULT false,
    confirmed_by_manager boolean DEFAULT false,
    user_confirmation_datetime timestamp without time zone,
    manager_confirmation_datetime timestamp without time zone,
    confirmation_token character varying(255),
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: email_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_addresses_id_seq OWNED BY email_addresses.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE emails (
    id integer NOT NULL,
    from_addrs text,
    return_path text,
    "from" text,
    subject text,
    in_reply_to text,
    to_addrs text,
    html_part text,
    text_part text,
    user_id text,
    "to" text,
    body bytea,
    cc_addrs text,
    bcc_addrs text,
    bcc text,
    cc text,
    resent_bcc text,
    resent_cc text,
    is_multipart text,
    parts_length text,
    date text,
    message_id text,
    name text,
    content_types text,
    classes text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    email_address_id integer
);


--
-- Name: emails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE emails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: emails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE emails_id_seq OWNED BY emails.id;


--
-- Name: generations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE generations (
    id integer NOT NULL,
    name character varying(255),
    model_id integer,
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: generations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE generations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: generations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE generations_id_seq OWNED BY generations.id;


--
-- Name: ipgeobase_ips; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ipgeobase_ips (
    start_ip bigint,
    end_ip bigint,
    region_id integer
);


--
-- Name: ipgeobase_regions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ipgeobase_regions (
    id integer NOT NULL,
    name character varying(255),
    ancestry character varying(255),
    names_depth_cache text,
    region_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: ipgeobase_regions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ipgeobase_regions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ipgeobase_regions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ipgeobase_regions_id_seq OWNED BY ipgeobase_regions.id;


--
-- Name: mails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE mails (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    available boolean DEFAULT true,
    sequence integer,
    name character varying(255),
    delivery_cost numeric(8,2) DEFAULT 0,
    delivery_id integer,
    content text,
    postal_address_required boolean DEFAULT false,
    full_prepayment_required boolean DEFAULT false,
    passport_required boolean DEFAULT false
);


--
-- Name: mails_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE mails_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: mails_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE mails_id_seq OWNED BY mails.id;


--
-- Name: metro; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE metro (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: metro_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE metro_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: metro_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE metro_id_seq OWNED BY metro.id;


--
-- Name: models; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE models (
    id integer NOT NULL,
    brand_id integer,
    name character varying(255),
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: models_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE models_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: models_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE models_id_seq OWNED BY models.id;


--
-- Name: modifications; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE modifications (
    id integer NOT NULL,
    name character varying(255),
    generation_id integer,
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: modifications_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE modifications_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: modifications_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE modifications_id_seq OWNED BY modifications.id;


--
-- Name: name_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE name_transactions (
    id integer NOT NULL,
    name_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    name_before character varying(255),
    name_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: name_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE name_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: name_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE name_transactions_id_seq OWNED BY name_transactions.id;


--
-- Name: names; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE names (
    id integer NOT NULL,
    name character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: names_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE names_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: names_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE names_id_seq OWNED BY names.id;


--
-- Name: order_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_transactions (
    id integer NOT NULL,
    order_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    postal_address_id_before integer,
    postal_address_id_after integer,
    company_id_before integer,
    company_id_after integer,
    delivery_cost_before numeric,
    delivery_cost_after numeric,
    status_before character varying(255),
    status_after character varying(255),
    delivery_id_before integer,
    delivery_id_after integer,
    profile_id_before integer,
    profile_id_after integer,
    cached_profile_before character varying(255),
    cached_profile_after character varying(255),
    legal_before boolean,
    legal_after boolean,
    phantom_before boolean,
    phantom_after boolean,
    token_before character varying(255),
    token_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: order_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_transactions_id_seq OWNED BY order_transactions.id;


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE orders (
    id integer NOT NULL,
    postal_address_id integer,
    company_id integer,
    delivery_cost numeric(8,2) DEFAULT 0,
    status character varying(255) DEFAULT 'open'::character varying,
    delivery_id integer,
    profile_id integer,
    cached_profile character varying(255),
    legal boolean,
    phantom boolean DEFAULT true,
    token character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: orders_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE orders_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: orders_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE orders_id_seq OWNED BY orders.id;


--
-- Name: pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages (
    id integer NOT NULL,
    path character varying(255),
    content text,
    keywords text,
    description text,
    title character varying(255),
    robots character varying(255),
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE pages_id_seq OWNED BY pages.id;


--
-- Name: pages_uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE pages_uploads (
    page_id integer,
    upload_id integer
);


--
-- Name: passport_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE passport_transactions (
    id integer NOT NULL,
    passport_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    seriya_before character varying(255),
    seriya_after character varying(255),
    nomer_before character varying(255),
    nomer_after character varying(255),
    passport_vidan_before character varying(255),
    passport_vidan_after character varying(255),
    data_vidachi_before date,
    data_vidachi_after date,
    kod_podrazdeleniya_before character varying(255),
    kod_podrazdeleniya_after character varying(255),
    female_before boolean,
    female_after boolean,
    data_rozhdeniya_before date,
    data_rozhdeniya_after date,
    mesto_rozhdeniya_before character varying(255),
    mesto_rozhdeniya_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: passport_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE passport_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: passport_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE passport_transactions_id_seq OWNED BY passport_transactions.id;


--
-- Name: passports; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE passports (
    id integer NOT NULL,
    seriya character varying(255),
    nomer character varying(255),
    passport_vidan character varying(255),
    data_vidachi date,
    kod_podrazdeleniya character varying(255),
    female boolean,
    data_rozhdeniya date,
    mesto_rozhdeniya character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: passports_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE passports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: passports_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE passports_id_seq OWNED BY passports.id;


--
-- Name: phone_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phone_transactions (
    id integer NOT NULL,
    phone_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    phone_before character varying(255),
    phone_after character varying(255),
    phone_type_before character varying(255),
    phone_type_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    confirmed_by_user_before boolean,
    confirmed_by_user_after boolean,
    confirmed_by_manager_before boolean,
    confirmed_by_manager_after boolean,
    user_confirmation_datetime_before timestamp without time zone,
    user_confirmation_datetime_after timestamp without time zone,
    manager_confirmation_datetime_before timestamp without time zone,
    manager_confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying(255),
    confirmation_token_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: phone_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phone_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phone_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phone_transactions_id_seq OWNED BY phone_transactions.id;


--
-- Name: phones; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phones (
    id integer NOT NULL,
    phone character varying(255),
    phone_type character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed_by_user boolean DEFAULT false,
    confirmed_by_manager boolean DEFAULT false,
    user_confirmation_datetime timestamp without time zone,
    manager_confirmation_datetime timestamp without time zone,
    confirmation_token character varying(255),
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: phones_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE phones_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: phones_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE phones_id_seq OWNED BY phones.id;


--
-- Name: postal_address_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE postal_address_transactions (
    id integer NOT NULL,
    postal_address_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    postcode_before character varying(255),
    postcode_after character varying(255),
    region_before character varying(255),
    region_after character varying(255),
    city_before character varying(255),
    city_after character varying(255),
    street_before character varying(255),
    street_after character varying(255),
    house_before character varying(255),
    house_after character varying(255),
    stand_alone_house_before boolean,
    stand_alone_house_after boolean,
    room_before character varying(255),
    room_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: postal_address_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE postal_address_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postal_address_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE postal_address_transactions_id_seq OWNED BY postal_address_transactions.id;


--
-- Name: postal_addresses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE postal_addresses (
    id integer NOT NULL,
    postcode character varying(255),
    region character varying(255),
    city character varying(255),
    street character varying(255),
    house character varying(255),
    stand_alone_house boolean,
    room character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: postal_addresses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE postal_addresses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: postal_addresses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE postal_addresses_id_seq OWNED BY postal_addresses.id;


--
-- Name: product_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE product_transactions (
    id integer NOT NULL,
    product_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    catalog_number_before character varying(255),
    catalog_number_after character varying(255),
    manufacturer_before character varying(255),
    manufacturer_after character varying(255),
    short_name_before character varying(255),
    short_name_after character varying(255),
    long_name_before text,
    long_name_after text,
    quantity_ordered_before integer,
    quantity_ordered_after integer,
    quantity_available_before integer,
    quantity_available_after integer,
    min_days_before integer,
    min_days_after integer,
    max_days_before integer,
    max_days_after integer,
    buy_cost_before numeric,
    buy_cost_after numeric,
    sell_cost_before numeric,
    sell_cost_after numeric,
    hide_catalog_number_before boolean,
    hide_catalog_number_after boolean,
    status_before character varying(255),
    status_after character varying(255),
    probability_before integer,
    probability_after integer,
    product_id_before integer,
    product_id_after integer,
    order_id_before integer,
    order_id_after integer,
    supplier_id_before integer,
    supplier_id_after integer,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: product_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE product_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: product_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE product_transactions_id_seq OWNED BY product_transactions.id;


--
-- Name: products; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE products (
    id integer NOT NULL,
    catalog_number character varying(255),
    manufacturer character varying(255),
    short_name character varying(255),
    long_name text,
    quantity_ordered integer,
    quantity_available integer,
    min_days integer,
    max_days integer,
    buy_cost numeric(8,2),
    sell_cost numeric(8,2),
    hide_catalog_number boolean DEFAULT false,
    status character varying(255),
    probability integer,
    product_id integer,
    order_id integer,
    supplier_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: products_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE products_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: products_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE products_id_seq OWNED BY products.id;


--
-- Name: profile_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profile_transactions (
    id integer NOT NULL,
    profile_id integer,
    user_id integer,
    operation character varying(255),
    creator_id integer,
    cached_names_before text,
    cached_names_after text,
    cached_phones_before text,
    cached_phones_after text,
    cached_email_addresses_before text,
    cached_email_addresses_after text,
    cached_passports_before text,
    cached_passports_after text,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    created_at timestamp without time zone
);


--
-- Name: profile_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profile_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profile_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profile_transactions_id_seq OWNED BY profile_transactions.id;


--
-- Name: profiles; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE profiles (
    id integer NOT NULL,
    cached_names text,
    cached_phones text,
    cached_email_addresses text,
    cached_passports text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    user_id integer,
    creator_id integer
);


--
-- Name: profiles_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE profiles_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: profiles_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE profiles_id_seq OWNED BY profiles.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying(255) NOT NULL,
    data text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: sessions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE sessions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: sessions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE sessions_id_seq OWNED BY sessions.id;


--
-- Name: spare_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_infos (
    id integer NOT NULL,
    catalog_number character varying(255),
    manufacturer character varying(255),
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: spare_infos_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_infos_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_infos_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_infos_id_seq OWNED BY spare_infos.id;


--
-- Name: stats; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stats (
    id integer NOT NULL,
    location character varying(255),
    title character varying(255),
    referrer character varying(255),
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: stats_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stats_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stats_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stats_id_seq OWNED BY stats.id;


--
-- Name: suppliers; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE suppliers (
    id integer NOT NULL,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: suppliers_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE suppliers_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: suppliers_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE suppliers_id_seq OWNED BY suppliers.id;


--
-- Name: talks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE talks (
    id integer NOT NULL,
    talkable_id integer,
    talkable_type character varying(255),
    user_id integer,
    creator_id integer,
    read boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: talks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE talks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: talks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE talks_id_seq OWNED BY talks.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uploads (
    id integer NOT NULL,
    upload character varying(255),
    content_type character varying(255),
    file_size integer,
    user_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE uploads_id_seq OWNED BY uploads.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    discount numeric(8,2),
    prepayment numeric(8,2),
    role character varying(255),
    auth_token character varying(255),
    password_digest character varying(255),
    password_reset_email_token character varying(255),
    password_reset_sms_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    ipgeobase_name character varying(255),
    ipgeobase_names_depth_cache character varying(255),
    accept_language character varying(255),
    user_agent character varying(255),
    russian_time_zone_auto_id integer,
    russian_time_zone_manual_id integer,
    use_auto_russian_time_zone boolean DEFAULT true,
    remote_ip inet,
    creation_reason character varying(255),
    notes character varying(255),
    notes_invisible character varying(255),
    creator_id integer,
    cached_profile text,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    order_rule character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: versions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE versions (
    id integer NOT NULL,
    item_type character varying(255) NOT NULL,
    item_id integer NOT NULL,
    event character varying(255) NOT NULL,
    whodunnit character varying(255),
    object text,
    created_at timestamp without time zone
);


--
-- Name: versions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE versions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: versions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE versions_id_seq OWNED BY versions.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY a1s ALTER COLUMN id SET DEFAULT nextval('a1s_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY account_transactions ALTER COLUMN id SET DEFAULT nextval('account_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts ALTER COLUMN id SET DEFAULT nextval('accounts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_blocks ALTER COLUMN id SET DEFAULT nextval('admin_blocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY admin_site_settings ALTER COLUMN id SET DEFAULT nextval('admin_site_settings_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY attachments ALTER COLUMN id SET DEFAULT nextval('attachments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY auths ALTER COLUMN id SET DEFAULT nextval('auths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY brands ALTER COLUMN id SET DEFAULT nextval('brands_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY calls ALTER COLUMN id SET DEFAULT nextval('calls_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY car_transactions ALTER COLUMN id SET DEFAULT nextval('car_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY cars ALTER COLUMN id SET DEFAULT nextval('cars_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY comments ALTER COLUMN id SET DEFAULT nextval('comments_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY companies ALTER COLUMN id SET DEFAULT nextval('companies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY company_transactions ALTER COLUMN id SET DEFAULT nextval('company_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delayed_jobs ALTER COLUMN id SET DEFAULT nextval('delayed_jobs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries ALTER COLUMN id SET DEFAULT nextval('deliveries_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY delivery_zones ALTER COLUMN id SET DEFAULT nextval('delivery_zones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_address_transactions ALTER COLUMN id SET DEFAULT nextval('email_address_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_addresses ALTER COLUMN id SET DEFAULT nextval('email_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY emails ALTER COLUMN id SET DEFAULT nextval('emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY generations ALTER COLUMN id SET DEFAULT nextval('generations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ipgeobase_regions ALTER COLUMN id SET DEFAULT nextval('ipgeobase_regions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY mails ALTER COLUMN id SET DEFAULT nextval('mails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY metro ALTER COLUMN id SET DEFAULT nextval('metro_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY models ALTER COLUMN id SET DEFAULT nextval('models_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY modifications ALTER COLUMN id SET DEFAULT nextval('modifications_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY name_transactions ALTER COLUMN id SET DEFAULT nextval('name_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY names ALTER COLUMN id SET DEFAULT nextval('names_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY order_transactions ALTER COLUMN id SET DEFAULT nextval('order_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders ALTER COLUMN id SET DEFAULT nextval('orders_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY pages ALTER COLUMN id SET DEFAULT nextval('pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY passport_transactions ALTER COLUMN id SET DEFAULT nextval('passport_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY passports ALTER COLUMN id SET DEFAULT nextval('passports_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phone_transactions ALTER COLUMN id SET DEFAULT nextval('phone_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY phones ALTER COLUMN id SET DEFAULT nextval('phones_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY postal_address_transactions ALTER COLUMN id SET DEFAULT nextval('postal_address_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY postal_addresses ALTER COLUMN id SET DEFAULT nextval('postal_addresses_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY product_transactions ALTER COLUMN id SET DEFAULT nextval('product_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY products ALTER COLUMN id SET DEFAULT nextval('products_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profile_transactions ALTER COLUMN id SET DEFAULT nextval('profile_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY profiles ALTER COLUMN id SET DEFAULT nextval('profiles_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY sessions ALTER COLUMN id SET DEFAULT nextval('sessions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_infos ALTER COLUMN id SET DEFAULT nextval('spare_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stats ALTER COLUMN id SET DEFAULT nextval('stats_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY suppliers ALTER COLUMN id SET DEFAULT nextval('suppliers_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY talks ALTER COLUMN id SET DEFAULT nextval('talks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads ALTER COLUMN id SET DEFAULT nextval('uploads_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY versions ALTER COLUMN id SET DEFAULT nextval('versions_id_seq'::regclass);


--
-- Name: a1s_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY a1s
    ADD CONSTRAINT a1s_pkey PRIMARY KEY (id);


--
-- Name: account_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY account_transactions
    ADD CONSTRAINT account_transactions_pkey PRIMARY KEY (id);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: admin_blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_blocks
    ADD CONSTRAINT admin_blocks_pkey PRIMARY KEY (id);


--
-- Name: admin_site_settings_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY admin_site_settings
    ADD CONSTRAINT admin_site_settings_pkey PRIMARY KEY (id);


--
-- Name: attachments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY attachments
    ADD CONSTRAINT attachments_pkey PRIMARY KEY (id);


--
-- Name: auths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auths
    ADD CONSTRAINT auths_pkey PRIMARY KEY (id);


--
-- Name: brands_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY brands
    ADD CONSTRAINT brands_pkey PRIMARY KEY (id);


--
-- Name: calls_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY calls
    ADD CONSTRAINT calls_pkey PRIMARY KEY (id);


--
-- Name: car_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY car_transactions
    ADD CONSTRAINT car_transactions_pkey PRIMARY KEY (id);


--
-- Name: cars_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY cars
    ADD CONSTRAINT cars_pkey PRIMARY KEY (id);


--
-- Name: comments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY comments
    ADD CONSTRAINT comments_pkey PRIMARY KEY (id);


--
-- Name: companies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY companies
    ADD CONSTRAINT companies_pkey PRIMARY KEY (id);


--
-- Name: company_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY company_transactions
    ADD CONSTRAINT company_transactions_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delayed_jobs
    ADD CONSTRAINT delayed_jobs_pkey PRIMARY KEY (id);


--
-- Name: deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deliveries
    ADD CONSTRAINT deliveries_pkey PRIMARY KEY (id);


--
-- Name: delivery_zones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY delivery_zones
    ADD CONSTRAINT delivery_zones_pkey PRIMARY KEY (id);


--
-- Name: email_address_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY email_address_transactions
    ADD CONSTRAINT email_address_transactions_pkey PRIMARY KEY (id);


--
-- Name: email_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY email_addresses
    ADD CONSTRAINT email_addresses_pkey PRIMARY KEY (id);


--
-- Name: emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: generations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY generations
    ADD CONSTRAINT generations_pkey PRIMARY KEY (id);


--
-- Name: ipgeobase_regions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ipgeobase_regions
    ADD CONSTRAINT ipgeobase_regions_pkey PRIMARY KEY (id);


--
-- Name: mails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY mails
    ADD CONSTRAINT mails_pkey PRIMARY KEY (id);


--
-- Name: metro_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY metro
    ADD CONSTRAINT metro_pkey PRIMARY KEY (id);


--
-- Name: models_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY models
    ADD CONSTRAINT models_pkey PRIMARY KEY (id);


--
-- Name: modifications_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY modifications
    ADD CONSTRAINT modifications_pkey PRIMARY KEY (id);


--
-- Name: name_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY name_transactions
    ADD CONSTRAINT name_transactions_pkey PRIMARY KEY (id);


--
-- Name: names_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY names
    ADD CONSTRAINT names_pkey PRIMARY KEY (id);


--
-- Name: order_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_transactions
    ADD CONSTRAINT order_transactions_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY pages
    ADD CONSTRAINT pages_pkey PRIMARY KEY (id);


--
-- Name: passport_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY passport_transactions
    ADD CONSTRAINT passport_transactions_pkey PRIMARY KEY (id);


--
-- Name: passports_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY passports
    ADD CONSTRAINT passports_pkey PRIMARY KEY (id);


--
-- Name: phone_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phone_transactions
    ADD CONSTRAINT phone_transactions_pkey PRIMARY KEY (id);


--
-- Name: phones_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY phones
    ADD CONSTRAINT phones_pkey PRIMARY KEY (id);


--
-- Name: postal_address_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY postal_address_transactions
    ADD CONSTRAINT postal_address_transactions_pkey PRIMARY KEY (id);


--
-- Name: postal_addresses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY postal_addresses
    ADD CONSTRAINT postal_addresses_pkey PRIMARY KEY (id);


--
-- Name: product_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY product_transactions
    ADD CONSTRAINT product_transactions_pkey PRIMARY KEY (id);


--
-- Name: products_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: profile_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profile_transactions
    ADD CONSTRAINT profile_transactions_pkey PRIMARY KEY (id);


--
-- Name: profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY profiles
    ADD CONSTRAINT profiles_pkey PRIMARY KEY (id);


--
-- Name: sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: spare_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_infos
    ADD CONSTRAINT spare_infos_pkey PRIMARY KEY (id);


--
-- Name: stats_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stats
    ADD CONSTRAINT stats_pkey PRIMARY KEY (id);


--
-- Name: suppliers_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY suppliers
    ADD CONSTRAINT suppliers_pkey PRIMARY KEY (id);


--
-- Name: talks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY talks
    ADD CONSTRAINT talks_pkey PRIMARY KEY (id);


--
-- Name: uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: versions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY versions
    ADD CONSTRAINT versions_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


--
-- Name: index_a1s_on_parent_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_a1s_on_parent_id ON a1s USING btree (parent_id);


--
-- Name: index_account_transactions_on_account_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_account_transactions_on_account_id ON account_transactions USING btree (account_id);


--
-- Name: index_account_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_account_transactions_on_creator_id ON account_transactions USING btree (creator_id);


--
-- Name: index_account_transactions_on_product_transaction_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_account_transactions_on_product_transaction_id ON account_transactions USING btree (product_transaction_id);


--
-- Name: index_account_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_account_transactions_on_user_id ON account_transactions USING btree (user_id);


--
-- Name: index_accounts_on_accountable_id_and_accountable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_accounts_on_accountable_id_and_accountable_type ON accounts USING btree (accountable_id, accountable_type);


--
-- Name: index_attachments_on_email_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_attachments_on_email_id ON attachments USING btree (email_id);


--
-- Name: index_auths_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auths_on_user_id ON auths USING btree (user_id);


--
-- Name: index_brands_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brands_on_brand_id ON brands USING btree (brand_id);


--
-- Name: index_brands_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brands_on_creator_id ON brands USING btree (creator_id);


--
-- Name: index_calls_on_phone_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_calls_on_phone_id ON calls USING btree (phone_id);


--
-- Name: index_car_transactions_on_car_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_car_transactions_on_car_id ON car_transactions USING btree (car_id);


--
-- Name: index_car_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_car_transactions_on_creator_id ON car_transactions USING btree (creator_id);


--
-- Name: index_car_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_car_transactions_on_user_id ON car_transactions USING btree (user_id);


--
-- Name: index_cars_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_creator_id ON cars USING btree (creator_id);


--
-- Name: index_cars_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_user_id ON cars USING btree (user_id);


--
-- Name: index_comments_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_comments_on_ancestry ON comments USING btree (ancestry);


--
-- Name: index_companies_on_actual_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_actual_address_id ON companies USING btree (actual_address_id);


--
-- Name: index_companies_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_creator_id ON companies USING btree (creator_id);


--
-- Name: index_companies_on_legal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_legal_address_id ON companies USING btree (legal_address_id);


--
-- Name: index_companies_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_user_id ON companies USING btree (user_id);


--
-- Name: index_company_transactions_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_transactions_on_company_id ON company_transactions USING btree (company_id);


--
-- Name: index_company_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_transactions_on_creator_id ON company_transactions USING btree (creator_id);


--
-- Name: index_company_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_transactions_on_user_id ON company_transactions USING btree (user_id);


--
-- Name: index_email_address_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_address_transactions_on_creator_id ON email_address_transactions USING btree (creator_id);


--
-- Name: index_email_address_transactions_on_email_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_address_transactions_on_email_address_id ON email_address_transactions USING btree (email_address_id);


--
-- Name: index_email_address_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_address_transactions_on_user_id ON email_address_transactions USING btree (user_id);


--
-- Name: index_email_addresses_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_addresses_on_creator_id ON email_addresses USING btree (creator_id);


--
-- Name: index_email_addresses_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_addresses_on_profile_id ON email_addresses USING btree (profile_id);


--
-- Name: index_email_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_addresses_on_user_id ON email_addresses USING btree (user_id);


--
-- Name: index_generations_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_generations_on_creator_id ON generations USING btree (creator_id);


--
-- Name: index_generations_on_model_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_generations_on_model_id ON generations USING btree (model_id);


--
-- Name: index_ipgeobase_ips_on_region_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ipgeobase_ips_on_region_id ON ipgeobase_ips USING btree (region_id);


--
-- Name: index_ipgeobase_ips_on_start_ip; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ipgeobase_ips_on_start_ip ON ipgeobase_ips USING btree (start_ip);


--
-- Name: index_ipgeobase_regions_on_ancestry; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_ipgeobase_regions_on_ancestry ON ipgeobase_regions USING btree (ancestry);


--
-- Name: index_mails_on_delivery_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_mails_on_delivery_id ON mails USING btree (delivery_id);


--
-- Name: index_models_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_models_on_brand_id ON models USING btree (brand_id);


--
-- Name: index_models_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_models_on_creator_id ON models USING btree (creator_id);


--
-- Name: index_modifications_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_modifications_on_creator_id ON modifications USING btree (creator_id);


--
-- Name: index_modifications_on_generation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_modifications_on_generation_id ON modifications USING btree (generation_id);


--
-- Name: index_name_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_name_transactions_on_creator_id ON name_transactions USING btree (creator_id);


--
-- Name: index_name_transactions_on_name_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_name_transactions_on_name_id ON name_transactions USING btree (name_id);


--
-- Name: index_name_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_name_transactions_on_user_id ON name_transactions USING btree (user_id);


--
-- Name: index_names_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_creator_id ON names USING btree (creator_id);


--
-- Name: index_names_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_profile_id ON names USING btree (profile_id);


--
-- Name: index_names_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_user_id ON names USING btree (user_id);


--
-- Name: index_order_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_transactions_on_creator_id ON order_transactions USING btree (creator_id);


--
-- Name: index_order_transactions_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_transactions_on_order_id ON order_transactions USING btree (order_id);


--
-- Name: index_order_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_transactions_on_user_id ON order_transactions USING btree (user_id);


--
-- Name: index_orders_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_company_id ON orders USING btree (company_id);


--
-- Name: index_orders_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_creator_id ON orders USING btree (creator_id);


--
-- Name: index_orders_on_delivery_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_delivery_id ON orders USING btree (delivery_id);


--
-- Name: index_orders_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_postal_address_id ON orders USING btree (postal_address_id);


--
-- Name: index_orders_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_profile_id ON orders USING btree (profile_id);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_user_id ON orders USING btree (user_id);


--
-- Name: index_passport_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passport_transactions_on_creator_id ON passport_transactions USING btree (creator_id);


--
-- Name: index_passport_transactions_on_passport_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passport_transactions_on_passport_id ON passport_transactions USING btree (passport_id);


--
-- Name: index_passport_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passport_transactions_on_user_id ON passport_transactions USING btree (user_id);


--
-- Name: index_passports_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_creator_id ON passports USING btree (creator_id);


--
-- Name: index_passports_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_profile_id ON passports USING btree (profile_id);


--
-- Name: index_passports_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_user_id ON passports USING btree (user_id);


--
-- Name: index_phone_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_transactions_on_creator_id ON phone_transactions USING btree (creator_id);


--
-- Name: index_phone_transactions_on_phone_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_transactions_on_phone_id ON phone_transactions USING btree (phone_id);


--
-- Name: index_phone_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_transactions_on_user_id ON phone_transactions USING btree (user_id);


--
-- Name: index_phones_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_creator_id ON phones USING btree (creator_id);


--
-- Name: index_phones_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_profile_id ON phones USING btree (profile_id);


--
-- Name: index_phones_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_user_id ON phones USING btree (user_id);


--
-- Name: index_postal_address_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_address_transactions_on_creator_id ON postal_address_transactions USING btree (creator_id);


--
-- Name: index_postal_address_transactions_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_address_transactions_on_postal_address_id ON postal_address_transactions USING btree (postal_address_id);


--
-- Name: index_postal_address_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_address_transactions_on_user_id ON postal_address_transactions USING btree (user_id);


--
-- Name: index_postal_addresses_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_addresses_on_creator_id ON postal_addresses USING btree (creator_id);


--
-- Name: index_postal_addresses_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_addresses_on_user_id ON postal_addresses USING btree (user_id);


--
-- Name: index_product_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_transactions_on_creator_id ON product_transactions USING btree (creator_id);


--
-- Name: index_product_transactions_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_transactions_on_product_id ON product_transactions USING btree (product_id);


--
-- Name: index_product_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_transactions_on_user_id ON product_transactions USING btree (user_id);


--
-- Name: index_products_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_creator_id ON products USING btree (creator_id);


--
-- Name: index_products_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_order_id ON products USING btree (order_id);


--
-- Name: index_products_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_product_id ON products USING btree (product_id);


--
-- Name: index_products_on_supplier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_supplier_id ON products USING btree (supplier_id);


--
-- Name: index_products_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_user_id ON products USING btree (user_id);


--
-- Name: index_profile_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_transactions_on_creator_id ON profile_transactions USING btree (creator_id);


--
-- Name: index_profile_transactions_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_transactions_on_profile_id ON profile_transactions USING btree (profile_id);


--
-- Name: index_profile_transactions_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_transactions_on_user_id ON profile_transactions USING btree (user_id);


--
-- Name: index_profiles_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profiles_on_creator_id ON profiles USING btree (creator_id);


--
-- Name: index_profiles_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profiles_on_user_id ON profiles USING btree (user_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_stats_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stats_on_user_id ON stats USING btree (user_id);


--
-- Name: index_talks_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_creator_id ON talks USING btree (creator_id);


--
-- Name: index_talks_on_talkable_id_and_talkable_type; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_talkable_id_and_talkable_type ON talks USING btree (talkable_id, talkable_type);


--
-- Name: index_talks_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_user_id ON talks USING btree (user_id);


--
-- Name: index_uploads_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_uploads_on_user_id ON uploads USING btree (user_id);


--
-- Name: index_users_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_creator_id ON users USING btree (creator_id);


--
-- Name: index_versions_on_item_type_and_item_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_versions_on_item_type_and_item_id ON versions USING btree (item_type, item_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20121006145258');

INSERT INTO schema_migrations (version) VALUES ('20121006151609');

INSERT INTO schema_migrations (version) VALUES ('20121006162056');

INSERT INTO schema_migrations (version) VALUES ('20121007031343');

INSERT INTO schema_migrations (version) VALUES ('20121008122314');

INSERT INTO schema_migrations (version) VALUES ('20121017160108');

INSERT INTO schema_migrations (version) VALUES ('20121017202023');

INSERT INTO schema_migrations (version) VALUES ('20121019203051');

INSERT INTO schema_migrations (version) VALUES ('20121020205913');

INSERT INTO schema_migrations (version) VALUES ('20121024192648');

INSERT INTO schema_migrations (version) VALUES ('20121024192711');

INSERT INTO schema_migrations (version) VALUES ('20121027124845');

INSERT INTO schema_migrations (version) VALUES ('20121027175844');

INSERT INTO schema_migrations (version) VALUES ('20121031170331');

INSERT INTO schema_migrations (version) VALUES ('20121101131911');

INSERT INTO schema_migrations (version) VALUES ('20121106143606');

INSERT INTO schema_migrations (version) VALUES ('20121107184827');

INSERT INTO schema_migrations (version) VALUES ('20121207143942');

INSERT INTO schema_migrations (version) VALUES ('20121221143230');

INSERT INTO schema_migrations (version) VALUES ('20121222095424');

INSERT INTO schema_migrations (version) VALUES ('20121223234359');

INSERT INTO schema_migrations (version) VALUES ('20121224004534');

INSERT INTO schema_migrations (version) VALUES ('20121228131534');

INSERT INTO schema_migrations (version) VALUES ('20130101155849');

INSERT INTO schema_migrations (version) VALUES ('20130101182056');

INSERT INTO schema_migrations (version) VALUES ('20130106092934');

INSERT INTO schema_migrations (version) VALUES ('20130110155802');

INSERT INTO schema_migrations (version) VALUES ('20130116032450');

INSERT INTO schema_migrations (version) VALUES ('20130120165741');

INSERT INTO schema_migrations (version) VALUES ('20130124091011');

INSERT INTO schema_migrations (version) VALUES ('20130124111243');

INSERT INTO schema_migrations (version) VALUES ('20130215104437');

INSERT INTO schema_migrations (version) VALUES ('20130224071844');

INSERT INTO schema_migrations (version) VALUES ('20130227004055');

INSERT INTO schema_migrations (version) VALUES ('20130306003435');

INSERT INTO schema_migrations (version) VALUES ('20130307044921');

INSERT INTO schema_migrations (version) VALUES ('20130310180445');

INSERT INTO schema_migrations (version) VALUES ('20130315205632');

INSERT INTO schema_migrations (version) VALUES ('20130325223150');

INSERT INTO schema_migrations (version) VALUES ('20130331190859');

INSERT INTO schema_migrations (version) VALUES ('20130427055353');

INSERT INTO schema_migrations (version) VALUES ('20130502181249');

INSERT INTO schema_migrations (version) VALUES ('20130507060163');

INSERT INTO schema_migrations (version) VALUES ('20130519232746');

INSERT INTO schema_migrations (version) VALUES ('20140427060162');

INSERT INTO schema_migrations (version) VALUES ('20140427060163');

INSERT INTO schema_migrations (version) VALUES ('99999999999998');

INSERT INTO schema_migrations (version) VALUES ('99999999999999');
