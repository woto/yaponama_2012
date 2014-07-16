--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
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
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE account_transactions (
    id integer NOT NULL,
    account_id integer,
    creator_id integer,
    product_transaction_id integer,
    comment text,
    debit_before numeric,
    debit_after numeric,
    credit_before numeric,
    credit_after numeric,
    somebody_id_before integer,
    somebody_id_after integer,
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
    somebody_id integer,
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
-- Name: auths; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE auths (
    id integer NOT NULL,
    provider character varying(255),
    uid character varying(255),
    somebody_id integer,
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
-- Name: block_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE block_transactions (
    id integer NOT NULL,
    block_id integer,
    operation character varying(255),
    creator_id integer,
    name_before character varying(255),
    name_after character varying(255),
    content_before text,
    content_after text,
    created_at timestamp without time zone
);


--
-- Name: block_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE block_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: block_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE block_transactions_id_seq OWNED BY block_transactions.id;


--
-- Name: blocks; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE blocks (
    id integer NOT NULL,
    name character varying(255),
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: blocks_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE blocks_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: blocks_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE blocks_id_seq OWNED BY blocks.id;


--
-- Name: bots; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bots (
    id integer NOT NULL,
    title character varying(255),
    comment character varying(255),
    user_agent character varying(255),
    inet inet,
    phantom boolean,
    creator_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    block boolean DEFAULT false
);


--
-- Name: bots_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bots_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bots_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bots_id_seq OWNED BY bots.id;


--
-- Name: brand_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brand_transactions (
    id integer NOT NULL,
    brand_id integer,
    operation character varying(255),
    creator_id integer,
    name_before character varying(255),
    name_after character varying(255),
    path_before character varying(255),
    path_after character varying(255),
    brand_id_before integer,
    brand_id_after integer,
    cached_brand_before character varying(255),
    cached_brand_after character varying(255),
    image_before character varying(255),
    image_after character varying(255),
    rating_before integer,
    rating_after integer,
    content_before text,
    content_after text,
    phantom_before boolean,
    phantom_after boolean,
    catalog_before boolean,
    catalog_after boolean,
    is_brand_before boolean,
    is_brand_after boolean,
    created_at timestamp without time zone,
    manufacturer_before boolean,
    manufacturer_after boolean,
    preview_before text,
    preview_after text
);


--
-- Name: brand_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE brand_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: brand_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE brand_transactions_id_seq OWNED BY brand_transactions.id;


--
-- Name: brands; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brands (
    id integer NOT NULL,
    name character varying(255),
    path character varying(255),
    brand_id integer,
    cached_brand character varying(255),
    image character varying(255),
    rating integer,
    content text,
    creator_id integer,
    phantom boolean,
    catalog boolean,
    is_brand boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    manufacturer boolean,
    preview text
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
    somebody_id integer,
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
    operation character varying(255),
    creator_id integer,
    god_before integer,
    god_after integer,
    period_before character varying(255),
    period_after character varying(255),
    brand_id_before integer,
    brand_id_after integer,
    cached_brand_before character varying(255),
    cached_brand_after character varying(255),
    model_id_before integer,
    model_id_after integer,
    cached_model_before character varying(255),
    cached_model_after character varying(255),
    generation_id_before integer,
    generation_id_after integer,
    cached_generation_before character varying(255),
    cached_generation_after character varying(255),
    modification_id_before integer,
    modification_id_after integer,
    cached_modification_before character varying(255),
    cached_modification_after character varying(255),
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
    vin_or_frame_before character varying(255),
    vin_or_frame_after character varying(255),
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
    somebody_id_before integer,
    somebody_id_after integer,
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
    brand_id integer,
    cached_brand character varying(255),
    model_id integer,
    cached_model character varying(255),
    generation_id integer,
    cached_generation character varying(255),
    modification_id integer,
    cached_modification character varying(255),
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
    vin_or_frame character varying(255),
    komplektaciya character varying(255),
    dverey integer,
    rul character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    car_number character varying(255),
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
    cached_legal_address character varying(255),
    actual_address_id integer,
    cached_actual_address character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
    cached_legal_address_before character varying(255),
    cached_legal_address_after character varying(255),
    actual_address_id_before integer,
    actual_address_id_after integer,
    cached_actual_address_before character varying(255),
    cached_actual_address_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
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
-- Name: deliveries_options; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deliveries_options (
    id integer NOT NULL,
    name character varying(255),
    full_prepayment_required boolean,
    postal_address_required boolean,
    passport_required boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: deliveries_options_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveries_options_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_options_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveries_options_id_seq OWNED BY deliveries_options.id;


--
-- Name: deliveries_places; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deliveries_places (
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
    realize boolean DEFAULT true,
    active boolean DEFAULT true,
    lat double precision,
    lng double precision,
    zoom integer,
    z_index integer,
    display_marker boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    phone1 character varying(255),
    phone2 character varying(255),
    phone3 character varying(255),
    phone4 character varying(255),
    phone5 character varying(255),
    postal_address character varying(255),
    image1 character varying(255),
    image2 character varying(255),
    image3 character varying(255),
    address_locality character varying(255),
    postal_code character varying(255),
    street_address character varying(255),
    email1 character varying(255),
    email2 character varying(255),
    email3 character varying(255)
);


--
-- Name: deliveries_places_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveries_places_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_places_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveries_places_id_seq OWNED BY deliveries_places.id;


--
-- Name: deliveries_variants; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deliveries_variants (
    id integer NOT NULL,
    place_id integer,
    option_id integer,
    active boolean,
    sequence integer,
    name character varying(255),
    delivery_cost double precision,
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: deliveries_variants_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE deliveries_variants_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: deliveries_variants_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE deliveries_variants_id_seq OWNED BY deliveries_variants.id;


--
-- Name: email_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE email_transactions (
    id integer NOT NULL,
    email_id integer,
    operation character varying(255),
    creator_id integer,
    value_before character varying(255),
    value_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    confirmed_before boolean,
    confirmed_after boolean,
    confirmation_datetime_before timestamp without time zone,
    confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying(255),
    confirmation_token_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
    created_at timestamp without time zone
);


--
-- Name: email_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE email_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: email_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE email_transactions_id_seq OWNED BY email_transactions.id;


--
-- Name: emails; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE emails (
    id integer NOT NULL,
    value character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed boolean,
    confirmation_datetime timestamp without time zone,
    confirmation_token character varying(255),
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer
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
-- Name: faq_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE faq_transactions (
    id integer NOT NULL,
    faq_id integer,
    operation character varying(255),
    creator_id integer,
    question_before text,
    question_after text,
    answer_before text,
    answer_after text,
    phantom_before boolean,
    phantom_after boolean,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
    created_at timestamp without time zone
);


--
-- Name: faq_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE faq_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faq_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE faq_transactions_id_seq OWNED BY faq_transactions.id;


--
-- Name: faqs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE faqs (
    id integer NOT NULL,
    question text,
    answer text,
    phantom boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer
);


--
-- Name: faqs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE faqs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: faqs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE faqs_id_seq OWNED BY faqs.id;


--
-- Name: galleries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE galleries (
    id integer NOT NULL,
    title character varying(255),
    content text,
    image character varying(255),
    creator_id integer,
    phantom boolean DEFAULT false,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: galleries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE galleries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: galleries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE galleries_id_seq OWNED BY galleries.id;


--
-- Name: generations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE generations (
    id integer NOT NULL,
    name character varying(255),
    content text,
    model_id integer,
    cached_model character varying(255),
    creator_id integer,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "from" date,
    "to" date
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
    cached_brand character varying(255),
    name character varying(255),
    content text,
    creator_id integer,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "from" date,
    "to" date
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
    content text,
    generation_id integer,
    cached_generation character varying(255),
    creator_id integer,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "from" date,
    "to" date
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
    operation character varying(255),
    creator_id integer,
    surname_before character varying(255),
    surname_after character varying(255),
    name_before character varying(255),
    name_after character varying(255),
    patronymic_before character varying(255),
    patronymic_after character varying(255),
    profile_id_before integer,
    profile_id_after integer,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
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
    surname character varying(255),
    name character varying(255),
    patronymic character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
-- Name: order_deliveries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_deliveries (
    id integer NOT NULL,
    creator_id integer,
    somebody_id integer,
    postal_address_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: order_deliveries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE order_deliveries_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: order_deliveries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE order_deliveries_id_seq OWNED BY order_deliveries.id;


--
-- Name: order_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_transactions (
    id integer NOT NULL,
    order_id integer,
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
    delivery_place_id_before integer,
    delivery_place_id_after integer,
    delivery_variant_id_before integer,
    delivery_variant_id_after integer,
    delivery_option_id_before integer,
    delivery_option_id_after integer,
    profile_id_before integer,
    profile_id_after integer,
    cached_profile_before text,
    cached_profile_after text,
    full_prepayment_required_before boolean,
    full_prepayment_required_after boolean,
    legal_before boolean,
    legal_after boolean,
    phantom_before boolean,
    phantom_after boolean,
    token_before character varying(255),
    token_after character varying(255),
    track_number_before character varying(255),
    track_number_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
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
    delivery_place_id integer,
    delivery_variant_id integer,
    delivery_option_id integer,
    profile_id integer,
    cached_profile text,
    full_prepayment_required boolean,
    legal boolean,
    phantom boolean DEFAULT true,
    token character varying(255),
    track_number character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
-- Name: page_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE page_transactions (
    id integer NOT NULL,
    page_id integer,
    operation character varying(255),
    creator_id integer,
    path_before character varying(255),
    path_after character varying(255),
    content_before text,
    content_after text,
    keywords_before text,
    keywords_after text,
    description_before text,
    description_after text,
    title_before character varying(255),
    title_after character varying(255),
    robots_before character varying(255),
    robots_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    phantom_before boolean,
    phantom_after boolean,
    created_at timestamp without time zone
);


--
-- Name: page_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE page_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: page_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE page_transactions_id_seq OWNED BY page_transactions.id;


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
    creation_reason character varying(255),
    phantom boolean,
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
    gender_before character varying(255),
    gender_after character varying(255),
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
    somebody_id_before integer,
    somebody_id_after integer,
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
    gender character varying(255),
    data_rozhdeniya date,
    mesto_rozhdeniya character varying(255),
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
-- Name: payments; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE payments (
    id integer NOT NULL,
    amount integer,
    creator_id integer,
    somebody_id integer,
    profile_id integer,
    postal_address_id integer,
    payment_type character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: payments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE payments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: payments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE payments_id_seq OWNED BY payments.id;


--
-- Name: phone_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phone_transactions (
    id integer NOT NULL,
    phone_id integer,
    operation character varying(255),
    creator_id integer,
    value_before character varying(255),
    value_after character varying(255),
    mobile_before boolean,
    mobile_after boolean,
    profile_id_before integer,
    profile_id_after integer,
    confirmed_before boolean,
    confirmed_after boolean,
    confirmation_datetime_before timestamp without time zone,
    confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying(255),
    confirmation_token_after character varying(255),
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
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
    value character varying(255),
    mobile boolean,
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed boolean,
    confirmation_datetime timestamp without time zone,
    confirmation_token character varying(255),
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
    somebody_id_before integer,
    somebody_id_after integer,
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
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
    operation character varying(255),
    creator_id integer,
    catalog_number_before character varying(255),
    catalog_number_after character varying(255),
    brand_id_before integer,
    brand_id_after integer,
    cached_brand_before character varying(255),
    cached_brand_after character varying(255),
    cached_order_before character varying(255),
    cached_order_after character varying(255),
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
    somebody_id_before integer,
    somebody_id_after integer,
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
    brand_id integer,
    cached_brand character varying(255),
    cached_order character varying(255),
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
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
    operation character varying(255),
    creator_id integer,
    cached_names_before text,
    cached_names_after text,
    cached_phones_before text,
    cached_phones_after text,
    cached_emails_before text,
    cached_emails_after text,
    cached_passports_before text,
    cached_passports_after text,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    somebody_id_before integer,
    somebody_id_after integer,
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
    cached_emails text,
    cached_passports text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
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
-- Name: somebodies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE somebodies (
    id integer NOT NULL,
    discount numeric(8,2),
    prepayment numeric(8,2),
    role character varying(255),
    auth_token character varying(255),
    password_digest character varying(255),
    password_reset_token character varying(255),
    password_reset_sent_at timestamp without time zone,
    ipgeobase_name character varying(255),
    ipgeobase_names_depth_cache character varying(255),
    accept_language character varying(255),
    user_agent character varying(255),
    cached_russian_time_zone_auto_id integer,
    remote_ip inet,
    creation_reason character varying(255),
    notes text,
    notes_invisible text,
    creator_id integer,
    phantom boolean DEFAULT false,
    logout_from_other_places boolean DEFAULT true,
    online boolean DEFAULT false,
    chat text,
    profile_id integer,
    cached_profile text,
    cached_debit numeric(8,2) DEFAULT 0,
    cached_credit numeric(8,2) DEFAULT 0,
    type character varying(255),
    order_rule character varying(255),
    stats_count integer,
    touch_confirm timestamp without time zone,
    cached_location text,
    cached_title character varying(255),
    cached_referrer text,
    first_referrer text,
    cached_screen_width character varying(255),
    cached_screen_height character varying(255),
    cached_client_width character varying(255),
    cached_client_height character varying(255),
    cached_talk character varying(255),
    unread_talks integer DEFAULT 0,
    total_talks integer DEFAULT 0,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    bot boolean DEFAULT false
);


--
-- Name: somebodies_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE somebodies_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: somebodies_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE somebodies_id_seq OWNED BY somebodies.id;


--
-- Name: somebody_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE somebody_transactions (
    id integer NOT NULL,
    somebody_id integer,
    operation character varying(255),
    creator_id integer,
    discount_before numeric,
    discount_after numeric,
    prepayment_before numeric,
    prepayment_after numeric,
    role_before character varying(255),
    role_after character varying(255),
    auth_token_before character varying(255),
    auth_token_after character varying(255),
    password_digest_before character varying(255),
    password_digest_after character varying(255),
    password_reset_token_before character varying(255),
    password_reset_token_after character varying(255),
    password_reset_sent_at_before timestamp without time zone,
    password_reset_sent_at_after timestamp without time zone,
    ipgeobase_name_before character varying(255),
    ipgeobase_name_after character varying(255),
    ipgeobase_names_depth_cache_before character varying(255),
    ipgeobase_names_depth_cache_after character varying(255),
    accept_language_before character varying(255),
    accept_language_after character varying(255),
    user_agent_before character varying(255),
    user_agent_after character varying(255),
    cached_russian_time_zone_auto_id_before integer,
    cached_russian_time_zone_auto_id_after integer,
    remote_ip_before inet,
    remote_ip_after inet,
    creation_reason_before character varying(255),
    creation_reason_after character varying(255),
    notes_before text,
    notes_after text,
    notes_invisible_before text,
    notes_invisible_after text,
    phantom_before boolean,
    phantom_after boolean,
    logout_from_other_places_before boolean,
    logout_from_other_places_after boolean,
    online_before boolean,
    online_after boolean,
    chat_before text,
    chat_after text,
    profile_id_before integer,
    profile_id_after integer,
    cached_profile_before text,
    cached_profile_after text,
    cached_debit_before numeric,
    cached_debit_after numeric,
    cached_credit_before numeric,
    cached_credit_after numeric,
    type_before character varying(255),
    type_after character varying(255),
    order_rule_before character varying(255),
    order_rule_after character varying(255),
    stats_count_before integer,
    stats_count_after integer,
    touch_confirm_before timestamp without time zone,
    touch_confirm_after timestamp without time zone,
    cached_location_before text,
    cached_location_after text,
    cached_title_before character varying(255),
    cached_title_after character varying(255),
    cached_referrer_before text,
    cached_referrer_after text,
    first_referrer_before text,
    first_referrer_after text,
    cached_screen_width_before character varying(255),
    cached_screen_width_after character varying(255),
    cached_screen_height_before character varying(255),
    cached_screen_height_after character varying(255),
    cached_client_width_before character varying(255),
    cached_client_width_after character varying(255),
    cached_client_height_before character varying(255),
    cached_client_height_after character varying(255),
    cached_talk_before character varying(255),
    cached_talk_after character varying(255),
    unread_talks_before integer,
    unread_talks_after integer,
    total_talks_before integer,
    total_talks_after integer,
    created_at timestamp without time zone,
    bot_before boolean,
    bot_after boolean
);


--
-- Name: somebody_transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE somebody_transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: somebody_transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE somebody_transactions_id_seq OWNED BY somebody_transactions.id;


--
-- Name: spare_catalogs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_catalogs (
    id integer NOT NULL,
    name character varying(255),
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    intro text,
    page text
);


--
-- Name: spare_catalogs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_catalogs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_catalogs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_catalogs_id_seq OWNED BY spare_catalogs.id;


--
-- Name: spare_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_infos (
    id integer NOT NULL,
    catalog_number character varying(255),
    brand_id integer,
    cached_brand character varying(255),
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
    location text,
    title character varying(255),
    referrer text,
    russian_time_zone_auto_id integer,
    screen_width integer,
    screen_height integer,
    client_width integer,
    client_height integer,
    somebody_id integer,
    is_search boolean,
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
    creator_id integer,
    debit numeric(8,2) DEFAULT 0,
    credit numeric(8,2) DEFAULT 0,
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
    read boolean DEFAULT false,
    received boolean DEFAULT false,
    cached_talk text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying(255),
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer,
    text text,
    file character varying(255),
    file_name character varying(255),
    notified boolean DEFAULT false
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
-- Name: tests; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE tests (
    id integer NOT NULL,
    "binary" bytea,
    "boolean" boolean,
    date date,
    datetime timestamp without time zone,
    "decimal" numeric,
    "float" double precision,
    "integer" integer,
    string character varying(255),
    text text,
    "time" time without time zone,
    "timestamp" timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
);


--
-- Name: tests_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE tests_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: tests_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE tests_id_seq OWNED BY tests.id;


--
-- Name: uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE uploads (
    id integer NOT NULL,
    upload character varying(255),
    content_type character varying(255),
    file_size integer,
    somebody_id integer,
    creation_reason character varying(255),
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

ALTER TABLE ONLY auths ALTER COLUMN id SET DEFAULT nextval('auths_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY block_transactions ALTER COLUMN id SET DEFAULT nextval('block_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY blocks ALTER COLUMN id SET DEFAULT nextval('blocks_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bots ALTER COLUMN id SET DEFAULT nextval('bots_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY brand_transactions ALTER COLUMN id SET DEFAULT nextval('brand_transactions_id_seq'::regclass);


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

ALTER TABLE ONLY deliveries_options ALTER COLUMN id SET DEFAULT nextval('deliveries_options_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries_places ALTER COLUMN id SET DEFAULT nextval('deliveries_places_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY deliveries_variants ALTER COLUMN id SET DEFAULT nextval('deliveries_variants_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY email_transactions ALTER COLUMN id SET DEFAULT nextval('email_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY emails ALTER COLUMN id SET DEFAULT nextval('emails_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY faq_transactions ALTER COLUMN id SET DEFAULT nextval('faq_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY faqs ALTER COLUMN id SET DEFAULT nextval('faqs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY galleries ALTER COLUMN id SET DEFAULT nextval('galleries_id_seq'::regclass);


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

ALTER TABLE ONLY order_deliveries ALTER COLUMN id SET DEFAULT nextval('order_deliveries_id_seq'::regclass);


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

ALTER TABLE ONLY page_transactions ALTER COLUMN id SET DEFAULT nextval('page_transactions_id_seq'::regclass);


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

ALTER TABLE ONLY payments ALTER COLUMN id SET DEFAULT nextval('payments_id_seq'::regclass);


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

ALTER TABLE ONLY somebodies ALTER COLUMN id SET DEFAULT nextval('somebodies_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY somebody_transactions ALTER COLUMN id SET DEFAULT nextval('somebody_transactions_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_catalogs ALTER COLUMN id SET DEFAULT nextval('spare_catalogs_id_seq'::regclass);


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

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY uploads ALTER COLUMN id SET DEFAULT nextval('uploads_id_seq'::regclass);


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
-- Name: auths_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY auths
    ADD CONSTRAINT auths_pkey PRIMARY KEY (id);


--
-- Name: block_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY block_transactions
    ADD CONSTRAINT block_transactions_pkey PRIMARY KEY (id);


--
-- Name: blocks_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY blocks
    ADD CONSTRAINT blocks_pkey PRIMARY KEY (id);


--
-- Name: bots_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bots
    ADD CONSTRAINT bots_pkey PRIMARY KEY (id);


--
-- Name: brand_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY brand_transactions
    ADD CONSTRAINT brand_transactions_pkey PRIMARY KEY (id);


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
-- Name: deliveries_options_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deliveries_options
    ADD CONSTRAINT deliveries_options_pkey PRIMARY KEY (id);


--
-- Name: deliveries_places_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deliveries_places
    ADD CONSTRAINT deliveries_places_pkey PRIMARY KEY (id);


--
-- Name: deliveries_variants_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY deliveries_variants
    ADD CONSTRAINT deliveries_variants_pkey PRIMARY KEY (id);


--
-- Name: email_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY email_transactions
    ADD CONSTRAINT email_transactions_pkey PRIMARY KEY (id);


--
-- Name: emails_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY emails
    ADD CONSTRAINT emails_pkey PRIMARY KEY (id);


--
-- Name: faq_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY faq_transactions
    ADD CONSTRAINT faq_transactions_pkey PRIMARY KEY (id);


--
-- Name: faqs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY faqs
    ADD CONSTRAINT faqs_pkey PRIMARY KEY (id);


--
-- Name: galleries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY galleries
    ADD CONSTRAINT galleries_pkey PRIMARY KEY (id);


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
-- Name: order_deliveries_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY order_deliveries
    ADD CONSTRAINT order_deliveries_pkey PRIMARY KEY (id);


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
-- Name: page_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY page_transactions
    ADD CONSTRAINT page_transactions_pkey PRIMARY KEY (id);


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
-- Name: payments_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY payments
    ADD CONSTRAINT payments_pkey PRIMARY KEY (id);


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
-- Name: somebodies_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY somebodies
    ADD CONSTRAINT somebodies_pkey PRIMARY KEY (id);


--
-- Name: somebody_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY somebody_transactions
    ADD CONSTRAINT somebody_transactions_pkey PRIMARY KEY (id);


--
-- Name: spare_catalogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_catalogs
    ADD CONSTRAINT spare_catalogs_pkey PRIMARY KEY (id);


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
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY uploads
    ADD CONSTRAINT uploads_pkey PRIMARY KEY (id);


--
-- Name: delayed_jobs_priority; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX delayed_jobs_priority ON delayed_jobs USING btree (priority, run_at);


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
-- Name: index_accounts_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_accounts_on_somebody_id ON accounts USING btree (somebody_id);


--
-- Name: index_auths_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_auths_on_somebody_id ON auths USING btree (somebody_id);


--
-- Name: index_block_transactions_on_block_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_block_transactions_on_block_id ON block_transactions USING btree (block_id);


--
-- Name: index_block_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_block_transactions_on_creator_id ON block_transactions USING btree (creator_id);


--
-- Name: index_brand_transactions_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brand_transactions_on_brand_id ON brand_transactions USING btree (brand_id);


--
-- Name: index_brand_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_brand_transactions_on_creator_id ON brand_transactions USING btree (creator_id);


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
-- Name: index_calls_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_calls_on_somebody_id ON calls USING btree (somebody_id);


--
-- Name: index_car_transactions_on_car_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_car_transactions_on_car_id ON car_transactions USING btree (car_id);


--
-- Name: index_car_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_car_transactions_on_creator_id ON car_transactions USING btree (creator_id);


--
-- Name: index_cars_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_brand_id ON cars USING btree (brand_id);


--
-- Name: index_cars_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_creator_id ON cars USING btree (creator_id);


--
-- Name: index_cars_on_generation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_generation_id ON cars USING btree (generation_id);


--
-- Name: index_cars_on_model_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_model_id ON cars USING btree (model_id);


--
-- Name: index_cars_on_modification_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_modification_id ON cars USING btree (modification_id);


--
-- Name: index_cars_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_somebody_id ON cars USING btree (somebody_id);


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
-- Name: index_companies_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_companies_on_somebody_id ON companies USING btree (somebody_id);


--
-- Name: index_company_transactions_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_transactions_on_company_id ON company_transactions USING btree (company_id);


--
-- Name: index_company_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_company_transactions_on_creator_id ON company_transactions USING btree (creator_id);


--
-- Name: index_email_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_transactions_on_creator_id ON email_transactions USING btree (creator_id);


--
-- Name: index_email_transactions_on_email_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_email_transactions_on_email_id ON email_transactions USING btree (email_id);


--
-- Name: index_emails_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_emails_on_creator_id ON emails USING btree (creator_id);


--
-- Name: index_emails_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_emails_on_profile_id ON emails USING btree (profile_id);


--
-- Name: index_emails_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_emails_on_somebody_id ON emails USING btree (somebody_id);


--
-- Name: index_faq_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_faq_transactions_on_creator_id ON faq_transactions USING btree (creator_id);


--
-- Name: index_faq_transactions_on_faq_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_faq_transactions_on_faq_id ON faq_transactions USING btree (faq_id);


--
-- Name: index_faqs_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_faqs_on_creator_id ON faqs USING btree (creator_id);


--
-- Name: index_faqs_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_faqs_on_somebody_id ON faqs USING btree (somebody_id);


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
-- Name: index_names_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_creator_id ON names USING btree (creator_id);


--
-- Name: index_names_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_profile_id ON names USING btree (profile_id);


--
-- Name: index_names_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_names_on_somebody_id ON names USING btree (somebody_id);


--
-- Name: index_order_deliveries_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_deliveries_on_creator_id ON order_deliveries USING btree (creator_id);


--
-- Name: index_order_deliveries_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_deliveries_on_postal_address_id ON order_deliveries USING btree (postal_address_id);


--
-- Name: index_order_deliveries_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_deliveries_on_somebody_id ON order_deliveries USING btree (somebody_id);


--
-- Name: index_order_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_transactions_on_creator_id ON order_transactions USING btree (creator_id);


--
-- Name: index_order_transactions_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_order_transactions_on_order_id ON order_transactions USING btree (order_id);


--
-- Name: index_orders_on_company_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_company_id ON orders USING btree (company_id);


--
-- Name: index_orders_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_creator_id ON orders USING btree (creator_id);


--
-- Name: index_orders_on_delivery_option_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_delivery_option_id ON orders USING btree (delivery_option_id);


--
-- Name: index_orders_on_delivery_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_delivery_place_id ON orders USING btree (delivery_place_id);


--
-- Name: index_orders_on_delivery_variant_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_delivery_variant_id ON orders USING btree (delivery_variant_id);


--
-- Name: index_orders_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_postal_address_id ON orders USING btree (postal_address_id);


--
-- Name: index_orders_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_profile_id ON orders USING btree (profile_id);


--
-- Name: index_orders_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_somebody_id ON orders USING btree (somebody_id);


--
-- Name: index_page_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_page_transactions_on_creator_id ON page_transactions USING btree (creator_id);


--
-- Name: index_page_transactions_on_page_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_page_transactions_on_page_id ON page_transactions USING btree (page_id);


--
-- Name: index_passport_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passport_transactions_on_creator_id ON passport_transactions USING btree (creator_id);


--
-- Name: index_passport_transactions_on_passport_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passport_transactions_on_passport_id ON passport_transactions USING btree (passport_id);


--
-- Name: index_passports_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_creator_id ON passports USING btree (creator_id);


--
-- Name: index_passports_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_profile_id ON passports USING btree (profile_id);


--
-- Name: index_passports_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_passports_on_somebody_id ON passports USING btree (somebody_id);


--
-- Name: index_payments_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_on_creator_id ON payments USING btree (creator_id);


--
-- Name: index_payments_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_on_postal_address_id ON payments USING btree (postal_address_id);


--
-- Name: index_payments_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_on_profile_id ON payments USING btree (profile_id);


--
-- Name: index_payments_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_payments_on_somebody_id ON payments USING btree (somebody_id);


--
-- Name: index_phone_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_transactions_on_creator_id ON phone_transactions USING btree (creator_id);


--
-- Name: index_phone_transactions_on_phone_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phone_transactions_on_phone_id ON phone_transactions USING btree (phone_id);


--
-- Name: index_phones_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_creator_id ON phones USING btree (creator_id);


--
-- Name: index_phones_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_profile_id ON phones USING btree (profile_id);


--
-- Name: index_phones_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_phones_on_somebody_id ON phones USING btree (somebody_id);


--
-- Name: index_postal_address_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_address_transactions_on_creator_id ON postal_address_transactions USING btree (creator_id);


--
-- Name: index_postal_address_transactions_on_postal_address_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_address_transactions_on_postal_address_id ON postal_address_transactions USING btree (postal_address_id);


--
-- Name: index_postal_addresses_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_addresses_on_creator_id ON postal_addresses USING btree (creator_id);


--
-- Name: index_postal_addresses_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_postal_addresses_on_somebody_id ON postal_addresses USING btree (somebody_id);


--
-- Name: index_product_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_transactions_on_creator_id ON product_transactions USING btree (creator_id);


--
-- Name: index_product_transactions_on_product_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_product_transactions_on_product_id ON product_transactions USING btree (product_id);


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
-- Name: index_products_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_somebody_id ON products USING btree (somebody_id);


--
-- Name: index_products_on_supplier_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_supplier_id ON products USING btree (supplier_id);


--
-- Name: index_profile_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_transactions_on_creator_id ON profile_transactions USING btree (creator_id);


--
-- Name: index_profile_transactions_on_profile_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profile_transactions_on_profile_id ON profile_transactions USING btree (profile_id);


--
-- Name: index_profiles_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profiles_on_creator_id ON profiles USING btree (creator_id);


--
-- Name: index_profiles_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_profiles_on_somebody_id ON profiles USING btree (somebody_id);


--
-- Name: index_sessions_on_session_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_session_id ON sessions USING btree (session_id);


--
-- Name: index_sessions_on_updated_at; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_sessions_on_updated_at ON sessions USING btree (updated_at);


--
-- Name: index_somebodies_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebodies_on_creator_id ON somebodies USING btree (creator_id);


--
-- Name: index_somebody_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebody_transactions_on_creator_id ON somebody_transactions USING btree (creator_id);


--
-- Name: index_somebody_transactions_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebody_transactions_on_somebody_id ON somebody_transactions USING btree (somebody_id);


--
-- Name: index_spare_infos_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_infos_on_brand_id ON spare_infos USING btree (brand_id);


--
-- Name: index_stats_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_stats_on_somebody_id ON stats USING btree (somebody_id);


--
-- Name: index_suppliers_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_suppliers_on_creator_id ON suppliers USING btree (creator_id);


--
-- Name: index_talks_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_creator_id ON talks USING btree (creator_id);


--
-- Name: index_talks_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_talks_on_somebody_id ON talks USING btree (somebody_id);


--
-- Name: index_uploads_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_uploads_on_somebody_id ON uploads USING btree (somebody_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20120920070844');

INSERT INTO schema_migrations (version) VALUES ('20121006151609');

INSERT INTO schema_migrations (version) VALUES ('20121006162056');

INSERT INTO schema_migrations (version) VALUES ('20121007031343');

INSERT INTO schema_migrations (version) VALUES ('20121008122314');

INSERT INTO schema_migrations (version) VALUES ('20121020205913');

INSERT INTO schema_migrations (version) VALUES ('20121024192648');

INSERT INTO schema_migrations (version) VALUES ('20121024192711');

INSERT INTO schema_migrations (version) VALUES ('20121027124845');

INSERT INTO schema_migrations (version) VALUES ('20121027175844');

INSERT INTO schema_migrations (version) VALUES ('20121106143606');

INSERT INTO schema_migrations (version) VALUES ('20121107184827');

INSERT INTO schema_migrations (version) VALUES ('20121207143942');

INSERT INTO schema_migrations (version) VALUES ('20121221143230');

INSERT INTO schema_migrations (version) VALUES ('20121222095424');

INSERT INTO schema_migrations (version) VALUES ('20121224004534');

INSERT INTO schema_migrations (version) VALUES ('20121228131534');

INSERT INTO schema_migrations (version) VALUES ('20130106092934');

INSERT INTO schema_migrations (version) VALUES ('20130110155802');

INSERT INTO schema_migrations (version) VALUES ('20130120165741');

INSERT INTO schema_migrations (version) VALUES ('20130124091011');

INSERT INTO schema_migrations (version) VALUES ('20130124111243');

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

INSERT INTO schema_migrations (version) VALUES ('20130527063301');

INSERT INTO schema_migrations (version) VALUES ('20130527065612');

INSERT INTO schema_migrations (version) VALUES ('20130607164715');

INSERT INTO schema_migrations (version) VALUES ('20130627000127');

INSERT INTO schema_migrations (version) VALUES ('20130922203206');

INSERT INTO schema_migrations (version) VALUES ('20131016040326');

INSERT INTO schema_migrations (version) VALUES ('20131028130959');

INSERT INTO schema_migrations (version) VALUES ('20131201202601');

INSERT INTO schema_migrations (version) VALUES ('20131201202627');

INSERT INTO schema_migrations (version) VALUES ('20131201212428');

INSERT INTO schema_migrations (version) VALUES ('20131202004245');

INSERT INTO schema_migrations (version) VALUES ('20131202023213');

INSERT INTO schema_migrations (version) VALUES ('20140110081258');

INSERT INTO schema_migrations (version) VALUES ('20140125140823');

INSERT INTO schema_migrations (version) VALUES ('20140201225959');

INSERT INTO schema_migrations (version) VALUES ('20140210162300');

INSERT INTO schema_migrations (version) VALUES ('20140210162400');

INSERT INTO schema_migrations (version) VALUES ('20140210162610');

INSERT INTO schema_migrations (version) VALUES ('20140213012421');

INSERT INTO schema_migrations (version) VALUES ('20140304135621');

INSERT INTO schema_migrations (version) VALUES ('20140304201547');

INSERT INTO schema_migrations (version) VALUES ('20140304201759');

INSERT INTO schema_migrations (version) VALUES ('20140308162758');

INSERT INTO schema_migrations (version) VALUES ('20140308173959');

INSERT INTO schema_migrations (version) VALUES ('20140401053343');

INSERT INTO schema_migrations (version) VALUES ('20140401055103');

INSERT INTO schema_migrations (version) VALUES ('20140401063956');

INSERT INTO schema_migrations (version) VALUES ('20140401234808');

INSERT INTO schema_migrations (version) VALUES ('20140409194938');

INSERT INTO schema_migrations (version) VALUES ('20140409195035');

INSERT INTO schema_migrations (version) VALUES ('20140409195051');

INSERT INTO schema_migrations (version) VALUES ('20140414150436');

INSERT INTO schema_migrations (version) VALUES ('20140414155247');

INSERT INTO schema_migrations (version) VALUES ('20140419155001');

INSERT INTO schema_migrations (version) VALUES ('20140420212924');

INSERT INTO schema_migrations (version) VALUES ('20140501151705');

INSERT INTO schema_migrations (version) VALUES ('20140613155843');

INSERT INTO schema_migrations (version) VALUES ('20140613160003');

INSERT INTO schema_migrations (version) VALUES ('20140613160422');

INSERT INTO schema_migrations (version) VALUES ('20140613160554');

INSERT INTO schema_migrations (version) VALUES ('20140613160659');

INSERT INTO schema_migrations (version) VALUES ('20140613160710');

INSERT INTO schema_migrations (version) VALUES ('20140613160720');

INSERT INTO schema_migrations (version) VALUES ('20140613160730');

INSERT INTO schema_migrations (version) VALUES ('20140613161050');

INSERT INTO schema_migrations (version) VALUES ('20140613170705');

INSERT INTO schema_migrations (version) VALUES ('20140615054649');

INSERT INTO schema_migrations (version) VALUES ('20140615054718');

INSERT INTO schema_migrations (version) VALUES ('20140615054917');

INSERT INTO schema_migrations (version) VALUES ('20140615065414');

INSERT INTO schema_migrations (version) VALUES ('20140615070010');

INSERT INTO schema_migrations (version) VALUES ('20140617025202');

INSERT INTO schema_migrations (version) VALUES ('20140706053926');

INSERT INTO schema_migrations (version) VALUES ('20140712231753');

INSERT INTO schema_migrations (version) VALUES ('20140712231832');

