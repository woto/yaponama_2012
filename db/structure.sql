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


--
-- Name: citext; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS citext WITH SCHEMA public;


--
-- Name: EXTENSION citext; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION citext IS 'data type for case-insensitive character strings';


--
-- Name: hstore; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS hstore WITH SCHEMA public;


--
-- Name: EXTENSION hstore; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION hstore IS 'data type for storing sets of (key, value) pairs';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: account_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE account_transactions (
    id integer NOT NULL,
    account_id integer,
    operation character varying,
    creator_id integer,
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
-- Name: bots; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bots (
    id integer NOT NULL,
    title character varying,
    user_agent character varying,
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
    operation character varying,
    creator_id integer,
    name_before character varying,
    name_after character varying,
    path_before character varying,
    path_after character varying,
    brand_id_before integer,
    brand_id_after integer,
    image_before character varying,
    image_after character varying,
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
    created_at timestamp without time zone
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
    name citext,
    brand_id integer,
    image character varying,
    rating integer,
    content text,
    creator_id integer,
    phantom boolean,
    is_brand boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    preview text,
    default_display boolean,
    opts character varying[] DEFAULT '{}'::character varying[],
    sign integer
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
-- Name: brands_spare_catalogs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE brands_spare_catalogs (
    spare_catalog_id integer NOT NULL,
    brand_id integer NOT NULL
);


--
-- Name: calls; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE calls (
    id integer NOT NULL,
    phone_id integer,
    somebody_id integer,
    file character varying,
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
    operation character varying,
    creator_id integer,
    god_before integer,
    god_after integer,
    period_before character varying,
    period_after character varying,
    brand_id_before integer,
    brand_id_after integer,
    model_id_before integer,
    model_id_after integer,
    generation_id_before integer,
    generation_id_after integer,
    modification_id_before integer,
    modification_id_after integer,
    dvigatel_before character varying,
    dvigatel_after character varying,
    tip_before character varying,
    tip_after character varying,
    moschnost_before character varying,
    moschnost_after character varying,
    privod_before character varying,
    privod_after character varying,
    tip_kuzova_before character varying,
    tip_kuzova_after character varying,
    kpp_before character varying,
    kpp_after character varying,
    kod_kuzova_before character varying,
    kod_kuzova_after character varying,
    kod_dvigatelya_before character varying,
    kod_dvigatelya_after character varying,
    rinok_before character varying,
    rinok_after character varying,
    vin_before character varying,
    vin_after character varying,
    frame_before character varying,
    frame_after character varying,
    vin_or_frame_before character varying,
    vin_or_frame_after character varying,
    komplektaciya_before character varying,
    komplektaciya_after character varying,
    dverey_before integer,
    dverey_after integer,
    rul_before character varying,
    rul_after character varying,
    car_number_before character varying,
    car_number_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    period character varying,
    brand_id integer,
    model_id integer,
    generation_id integer,
    modification_id integer,
    dvigatel character varying,
    tip character varying,
    moschnost character varying,
    privod character varying,
    tip_kuzova character varying,
    kpp character varying,
    kod_kuzova character varying,
    kod_dvigatelya character varying,
    rinok character varying,
    vin character varying,
    frame character varying,
    vin_or_frame character varying,
    komplektaciya character varying,
    dverey integer,
    rul character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    car_number character varying,
    creation_reason character varying,
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer,
    user_id integer
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
-- Name: ckpages_pages; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ckpages_pages (
    id integer NOT NULL,
    path text,
    content text,
    keywords text,
    description text,
    title text,
    robots text,
    redirect_url text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    title1 text,
    url1 text,
    title2 text,
    url2 text,
    title3 text,
    url3 text,
    title4 text,
    url4 text,
    title5 text,
    url5 text
);


--
-- Name: ckpages_pages_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ckpages_pages_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ckpages_pages_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ckpages_pages_id_seq OWNED BY ckpages_pages.id;


--
-- Name: ckpages_parts; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ckpages_parts (
    id integer NOT NULL,
    title character varying,
    text text,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: ckpages_parts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ckpages_parts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ckpages_parts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ckpages_parts_id_seq OWNED BY ckpages_parts.id;


--
-- Name: ckpages_uploads; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE ckpages_uploads (
    id integer NOT NULL,
    file character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    content_type character varying,
    file_size integer
);


--
-- Name: ckpages_uploads_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE ckpages_uploads_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: ckpages_uploads_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE ckpages_uploads_id_seq OWNED BY ckpages_uploads.id;


--
-- Name: companies; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE companies (
    id integer NOT NULL,
    ownership character varying,
    name character varying,
    inn character varying,
    kpp character varying,
    ogrn character varying,
    account character varying,
    bank character varying,
    bik character varying,
    correspondent character varying,
    okpo character varying,
    okved character varying,
    okato character varying,
    legal_address_id integer,
    cached_legal_address character varying,
    actual_address_id integer,
    cached_actual_address character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
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
    operation character varying,
    creator_id integer,
    ownership_before character varying,
    ownership_after character varying,
    name_before character varying,
    name_after character varying,
    inn_before character varying,
    inn_after character varying,
    kpp_before character varying,
    kpp_after character varying,
    ogrn_before character varying,
    ogrn_after character varying,
    account_before character varying,
    account_after character varying,
    bank_before character varying,
    bank_after character varying,
    bik_before character varying,
    bik_after character varying,
    correspondent_before character varying,
    correspondent_after character varying,
    okpo_before character varying,
    okpo_after character varying,
    okved_before character varying,
    okved_after character varying,
    okato_before character varying,
    okato_after character varying,
    legal_address_id_before integer,
    legal_address_id_after integer,
    cached_legal_address_before character varying,
    cached_legal_address_after character varying,
    actual_address_id_before integer,
    actual_address_id_after integer,
    cached_actual_address_before character varying,
    cached_actual_address_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    locked_by character varying,
    queue character varying,
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
-- Name: deliveries_places; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE deliveries_places (
    id integer NOT NULL,
    name character varying,
    vertices text,
    realize boolean DEFAULT true,
    active boolean DEFAULT true,
    z_index integer,
    display_marker boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    price_url character varying,
    metro character varying,
    partner boolean DEFAULT false NOT NULL,
    ycountry character varying,
    ycountry_code character varying,
    ycity character varying,
    ystreet character varying,
    yhouse character varying,
    ycity_code character varying,
    yphone character varying,
    ycompany_name character varying,
    ycontact_email character varying,
    ywork_time character varying,
    yogrn character varying,
    faq_id integer
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
    name character varying,
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
    operation character varying,
    creator_id integer,
    value_before character varying,
    value_after character varying,
    profile_id_before integer,
    profile_id_after integer,
    confirmed_before boolean,
    confirmed_after boolean,
    confirmation_datetime_before timestamp without time zone,
    confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying,
    confirmation_token_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    value character varying,
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed boolean,
    confirmation_datetime timestamp without time zone,
    confirmation_token character varying,
    creation_reason character varying,
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
-- Name: galleries; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE galleries (
    id integer NOT NULL,
    title character varying,
    content text,
    image character varying,
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
    name citext,
    content text,
    model_id integer,
    cached_model character varying,
    creator_id integer,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "from" date,
    "to" date,
    preview text
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
    name character varying,
    ancestry character varying,
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
    name citext,
    content text,
    creator_id integer,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    "from" date,
    "to" date,
    slang character varying,
    preview text
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
    name citext,
    content text,
    generation_id integer,
    cached_generation character varying,
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
    operation character varying,
    creator_id integer,
    surname_before character varying,
    surname_after character varying,
    name_before character varying,
    name_after character varying,
    patronymic_before character varying,
    patronymic_after character varying,
    profile_id_before integer,
    profile_id_after integer,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    surname character varying,
    name character varying,
    patronymic character varying,
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
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
-- Name: opts_accumulators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE opts_accumulators (
    id integer NOT NULL,
    voltage integer,
    battery_capacity integer,
    cold_cranking_amps integer,
    length integer,
    width integer,
    height integer,
    base_hold_down integer,
    layout integer,
    terminal_types integer,
    spare_info_id integer,
    creator_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: opts_accumulators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE opts_accumulators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: opts_accumulators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE opts_accumulators_id_seq OWNED BY opts_accumulators.id;


--
-- Name: opts_truck_tires; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE opts_truck_tires (
    id integer NOT NULL,
    height integer,
    width integer,
    diameter integer,
    spare_info_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    load integer,
    speed integer,
    line integer,
    axle integer
);


--
-- Name: opts_truck_tires_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE opts_truck_tires_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: opts_truck_tires_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE opts_truck_tires_id_seq OWNED BY opts_truck_tires.id;


--
-- Name: order_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE order_transactions (
    id integer NOT NULL,
    order_id integer,
    operation character varying,
    creator_id integer,
    postal_address_id_before integer,
    postal_address_id_after integer,
    company_id_before integer,
    company_id_after integer,
    delivery_cost_before numeric,
    delivery_cost_after numeric,
    status_before character varying,
    status_after character varying,
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
    token_before character varying,
    token_after character varying,
    track_number_before character varying,
    track_number_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    status character varying DEFAULT 'open'::character varying,
    delivery_place_id integer,
    delivery_variant_id integer,
    delivery_option_id integer,
    profile_id integer,
    cached_profile text,
    full_prepayment_required boolean,
    legal boolean,
    phantom boolean DEFAULT true,
    token character varying,
    track_number character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer,
    user_id integer
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
    operation character varying,
    creator_id integer,
    path_before character varying,
    path_after character varying,
    content_before text,
    content_after text,
    keywords_before text,
    keywords_after text,
    description_before text,
    description_after text,
    title_before character varying,
    title_after character varying,
    robots_before character varying,
    robots_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    path character varying,
    content text,
    keywords text,
    description text,
    title character varying,
    robots character varying,
    creator_id integer,
    creation_reason character varying,
    phantom boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    redirect_url character varying
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
-- Name: passport_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE passport_transactions (
    id integer NOT NULL,
    passport_id integer,
    operation character varying,
    creator_id integer,
    seriya_before character varying,
    seriya_after character varying,
    nomer_before character varying,
    nomer_after character varying,
    passport_vidan_before character varying,
    passport_vidan_after character varying,
    data_vidachi_before date,
    data_vidachi_after date,
    kod_podrazdeleniya_before character varying,
    kod_podrazdeleniya_after character varying,
    gender_before character varying,
    gender_after character varying,
    data_rozhdeniya_before date,
    data_rozhdeniya_after date,
    mesto_rozhdeniya_before character varying,
    mesto_rozhdeniya_after character varying,
    profile_id_before integer,
    profile_id_after integer,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    seriya character varying,
    nomer character varying,
    passport_vidan character varying,
    data_vidachi date,
    kod_podrazdeleniya character varying,
    gender character varying,
    data_rozhdeniya date,
    mesto_rozhdeniya character varying,
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
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
-- Name: phone_transactions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE phone_transactions (
    id integer NOT NULL,
    phone_id integer,
    operation character varying,
    creator_id integer,
    value_before character varying,
    value_after character varying,
    mobile_before boolean,
    mobile_after boolean,
    profile_id_before integer,
    profile_id_after integer,
    confirmed_before boolean,
    confirmed_after boolean,
    confirmation_datetime_before timestamp without time zone,
    confirmation_datetime_after timestamp without time zone,
    confirmation_token_before character varying,
    confirmation_token_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    value character varying,
    mobile boolean,
    profile_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    confirmed boolean,
    confirmation_datetime timestamp without time zone,
    confirmation_token character varying,
    creation_reason character varying,
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
    operation character varying,
    creator_id integer,
    postcode_before character varying,
    postcode_after character varying,
    region_before character varying,
    region_after character varying,
    city_before character varying,
    city_after character varying,
    street_before character varying,
    street_after character varying,
    house_before character varying,
    house_after character varying,
    stand_alone_house_before boolean,
    stand_alone_house_after boolean,
    room_before character varying,
    room_after character varying,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    postcode character varying,
    region character varying,
    city character varying,
    street character varying,
    house character varying,
    stand_alone_house boolean,
    room character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer,
    user_id integer
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
    operation character varying,
    creator_id integer,
    catalog_number_before character varying,
    catalog_number_after character varying,
    brand_id_before integer,
    brand_id_after integer,
    short_name_before character varying,
    short_name_after character varying,
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
    status_before character varying,
    status_after character varying,
    probability_before integer,
    probability_after integer,
    order_id_before integer,
    order_id_after integer,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    catalog_number character varying,
    brand_id integer,
    title character varying,
    titles text[] DEFAULT '{}'::text[],
    quantity_ordered integer,
    quantity_available integer,
    min_days integer,
    max_days integer,
    buy_cost numeric(8,2),
    sell_cost numeric(8,2),
    hide_catalog_number boolean DEFAULT false,
    status integer,
    probability integer,
    order_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    creation_reason character varying,
    notes text DEFAULT ''::text,
    notes_invisible text DEFAULT ''::text,
    somebody_id integer,
    creator_id integer,
    user_id integer,
    deliveries_place_id integer
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
    operation character varying,
    creator_id integer,
    cached_names_before text,
    cached_names_after text,
    cached_phones_before text,
    cached_phones_after text,
    cached_emails_before text,
    cached_emails_after text,
    cached_passports_before text,
    cached_passports_after text,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    creation_reason character varying,
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
    version character varying NOT NULL
);


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE sessions (
    id integer NOT NULL,
    session_id character varying NOT NULL,
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
    role character varying,
    auth_token character varying,
    password_digest character varying,
    password_reset_token character varying,
    password_reset_sent_at timestamp without time zone,
    ipgeobase_name character varying,
    ipgeobase_names_depth_cache character varying,
    accept_language character varying,
    user_agent character varying,
    remote_ip inet,
    creation_reason character varying,
    notes text,
    notes_invisible text,
    creator_id integer,
    phantom boolean DEFAULT false,
    logout_from_other_places boolean DEFAULT true,
    profile_id integer,
    cached_profile text,
    cached_debit numeric(8,2) DEFAULT 0,
    cached_credit numeric(8,2) DEFAULT 0,
    type character varying,
    order_rule character varying,
    location text,
    referrer text,
    first_referrer text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone
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
    operation character varying,
    creator_id integer,
    discount_before numeric,
    discount_after numeric,
    prepayment_before numeric,
    prepayment_after numeric,
    role_before character varying,
    role_after character varying,
    auth_token_before character varying,
    auth_token_after character varying,
    password_digest_before character varying,
    password_digest_after character varying,
    password_reset_token_before character varying,
    password_reset_token_after character varying,
    password_reset_sent_at_before timestamp without time zone,
    password_reset_sent_at_after timestamp without time zone,
    ipgeobase_name_before character varying,
    ipgeobase_name_after character varying,
    ipgeobase_names_depth_cache_before character varying,
    ipgeobase_names_depth_cache_after character varying,
    accept_language_before character varying,
    accept_language_after character varying,
    user_agent_before character varying,
    user_agent_after character varying,
    cached_russian_time_zone_auto_id_before integer,
    cached_russian_time_zone_auto_id_after integer,
    remote_ip_before inet,
    remote_ip_after inet,
    creation_reason_before character varying,
    creation_reason_after character varying,
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
    sound_before boolean,
    sound_after boolean,
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
    type_before character varying,
    type_after character varying,
    order_rule_before character varying,
    order_rule_after character varying,
    stats_count_before integer,
    stats_count_after integer,
    touch_confirm_before timestamp without time zone,
    touch_confirm_after timestamp without time zone,
    cached_location_before text,
    cached_location_after text,
    cached_title_before character varying,
    cached_title_after character varying,
    cached_referrer_before text,
    cached_referrer_after text,
    first_referrer_before text,
    first_referrer_after text,
    cached_screen_width_before character varying,
    cached_screen_width_after character varying,
    cached_screen_height_before character varying,
    cached_screen_height_after character varying,
    cached_client_width_before character varying,
    cached_client_width_after character varying,
    cached_client_height_before character varying,
    cached_client_height_after character varying,
    cached_talk_before character varying,
    cached_talk_after character varying,
    transport_before character varying,
    transport_after character varying,
    unread_talks_before integer,
    unread_talks_after integer,
    total_talks_before integer,
    total_talks_after integer,
    default_addressee_id_before integer,
    default_addressee_id_after integer,
    created_at timestamp without time zone
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
-- Name: spare_applicabilities; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_applicabilities (
    id integer NOT NULL,
    spare_info_id integer,
    brand_id integer,
    model_id integer,
    generation_id integer,
    modification_id integer,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    notes text,
    notes_invisible text
);


--
-- Name: spare_applicabilities_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_applicabilities_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_applicabilities_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_applicabilities_id_seq OWNED BY spare_applicabilities.id;


--
-- Name: spare_catalog_groups; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_catalog_groups (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    ancestry character varying
);


--
-- Name: spare_catalog_groups_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_catalog_groups_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_catalog_groups_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_catalog_groups_id_seq OWNED BY spare_catalog_groups.id;


--
-- Name: spare_catalog_tokens; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_catalog_tokens (
    id integer NOT NULL,
    spare_catalog_id integer,
    name character varying,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    weight integer DEFAULT 1
);


--
-- Name: spare_catalog_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_catalog_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_catalog_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_catalog_tokens_id_seq OWNED BY spare_catalog_tokens.id;


--
-- Name: spare_catalogs; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_catalogs (
    id integer NOT NULL,
    name character varying,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    intro text,
    page text,
    opt character varying,
    shows integer,
    spare_catalog_group_id integer
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
-- Name: spare_info_phrases; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_info_phrases (
    id integer NOT NULL,
    spare_info_id integer,
    catalog_number character varying,
    yandex_campaign_id integer,
    yandex_banner_id integer,
    yandex_banner_updated_at timestamp without time zone,
    yandex_wordstat_updated_at timestamp without time zone,
    yandex_shows integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    phrase character varying,
    publish boolean,
    yclicks integer,
    yshows integer,
    "primary" boolean
);


--
-- Name: spare_info_phrases_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_info_phrases_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_info_phrases_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_info_phrases_id_seq OWNED BY spare_info_phrases.id;


--
-- Name: spare_infos; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_infos (
    id integer NOT NULL,
    catalog_number character varying,
    brand_id integer,
    content text,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    spare_catalog_id integer,
    notes text,
    notes_invisible text,
    image1 character varying,
    image2 character varying,
    image3 character varying,
    image4 character varying,
    image5 character varying,
    image6 character varying,
    image7 character varying,
    image8 character varying,
    file1 character varying,
    file2 character varying,
    file3 character varying,
    file4 character varying,
    file5 character varying,
    file6 character varying,
    file7 character varying,
    file8 character varying,
    hstore hstore,
    titles text[] DEFAULT '{}'::text[],
    min_days integer,
    min_cost integer,
    offers integer,
    aggregated_content_updated_at timestamp without time zone,
    aggregated_content_checked_at timestamp without time zone,
    fix_spare_catalog boolean DEFAULT false NOT NULL
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
-- Name: spare_replacements; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE spare_replacements (
    id integer NOT NULL,
    from_spare_info_id integer,
    to_spare_info_id integer,
    wrong boolean,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    notes text,
    notes_invisible text,
    status integer
);


--
-- Name: spare_replacements_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE spare_replacements_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: spare_replacements_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE spare_replacements_id_seq OWNED BY spare_replacements.id;


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
    string character varying,
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
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    email character varying DEFAULT ''::character varying NOT NULL,
    encrypted_password character varying DEFAULT ''::character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL,
    user_agent text,
    accept_language text,
    location text,
    referrer text,
    first_referrer text,
    credit integer DEFAULT 0,
    debit integer DEFAULT 0,
    role integer,
    name character varying,
    phone character varying,
    creator_id integer,
    ipgeobase_name character varying,
    ipgeobase_names_depth_cache character varying,
    time_zone character varying,
    notes text,
    notes_invisible text
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
-- Name: warehouses; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE warehouses (
    id integer NOT NULL,
    spare_info_id integer,
    count integer,
    price integer,
    place_id integer,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: warehouses_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE warehouses_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: warehouses_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE warehouses_id_seq OWNED BY warehouses.id;


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

ALTER TABLE ONLY ckpages_pages ALTER COLUMN id SET DEFAULT nextval('ckpages_pages_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ckpages_parts ALTER COLUMN id SET DEFAULT nextval('ckpages_parts_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY ckpages_uploads ALTER COLUMN id SET DEFAULT nextval('ckpages_uploads_id_seq'::regclass);


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

ALTER TABLE ONLY opts_accumulators ALTER COLUMN id SET DEFAULT nextval('opts_accumulators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY opts_truck_tires ALTER COLUMN id SET DEFAULT nextval('opts_truck_tires_id_seq'::regclass);


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

ALTER TABLE ONLY spare_applicabilities ALTER COLUMN id SET DEFAULT nextval('spare_applicabilities_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_catalog_groups ALTER COLUMN id SET DEFAULT nextval('spare_catalog_groups_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_catalog_tokens ALTER COLUMN id SET DEFAULT nextval('spare_catalog_tokens_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_catalogs ALTER COLUMN id SET DEFAULT nextval('spare_catalogs_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_info_phrases ALTER COLUMN id SET DEFAULT nextval('spare_info_phrases_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_infos ALTER COLUMN id SET DEFAULT nextval('spare_infos_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_replacements ALTER COLUMN id SET DEFAULT nextval('spare_replacements_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY tests ALTER COLUMN id SET DEFAULT nextval('tests_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY warehouses ALTER COLUMN id SET DEFAULT nextval('warehouses_id_seq'::regclass);


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
-- Name: ckpages_pages_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ckpages_pages
    ADD CONSTRAINT ckpages_pages_pkey PRIMARY KEY (id);


--
-- Name: ckpages_parts_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ckpages_parts
    ADD CONSTRAINT ckpages_parts_pkey PRIMARY KEY (id);


--
-- Name: ckpages_uploads_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY ckpages_uploads
    ADD CONSTRAINT ckpages_uploads_pkey PRIMARY KEY (id);


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
-- Name: opts_accumulators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY opts_accumulators
    ADD CONSTRAINT opts_accumulators_pkey PRIMARY KEY (id);


--
-- Name: opts_truck_tires_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY opts_truck_tires
    ADD CONSTRAINT opts_truck_tires_pkey PRIMARY KEY (id);


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
-- Name: spare_applicabilities_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_applicabilities
    ADD CONSTRAINT spare_applicabilities_pkey PRIMARY KEY (id);


--
-- Name: spare_catalog_groups_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_catalog_groups
    ADD CONSTRAINT spare_catalog_groups_pkey PRIMARY KEY (id);


--
-- Name: spare_catalog_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_catalog_tokens
    ADD CONSTRAINT spare_catalog_tokens_pkey PRIMARY KEY (id);


--
-- Name: spare_catalogs_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_catalogs
    ADD CONSTRAINT spare_catalogs_pkey PRIMARY KEY (id);


--
-- Name: spare_info_phrases_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_info_phrases
    ADD CONSTRAINT spare_info_phrases_pkey PRIMARY KEY (id);


--
-- Name: spare_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_infos
    ADD CONSTRAINT spare_infos_pkey PRIMARY KEY (id);


--
-- Name: spare_replacements_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY spare_replacements
    ADD CONSTRAINT spare_replacements_pkey PRIMARY KEY (id);


--
-- Name: tests_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY tests
    ADD CONSTRAINT tests_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: warehouses_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY warehouses
    ADD CONSTRAINT warehouses_pkey PRIMARY KEY (id);


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
-- Name: index_accounts_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_accounts_on_somebody_id ON accounts USING btree (somebody_id);


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
-- Name: index_cars_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_cars_on_user_id ON cars USING btree (user_id);


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
-- Name: index_opts_accumulators_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_opts_accumulators_on_creator_id ON opts_accumulators USING btree (creator_id);


--
-- Name: index_opts_accumulators_on_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_opts_accumulators_on_spare_info_id ON opts_accumulators USING btree (spare_info_id);


--
-- Name: index_opts_truck_tires_on_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_opts_truck_tires_on_spare_info_id ON opts_truck_tires USING btree (spare_info_id);


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
-- Name: index_orders_on_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_token ON orders USING btree (token);


--
-- Name: index_orders_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_orders_on_user_id ON orders USING btree (user_id);


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
-- Name: index_products_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_creator_id ON products USING btree (creator_id);


--
-- Name: index_products_on_deliveries_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_deliveries_place_id ON products USING btree (deliveries_place_id);


--
-- Name: index_products_on_order_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_order_id ON products USING btree (order_id);


--
-- Name: index_products_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_products_on_somebody_id ON products USING btree (somebody_id);


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
-- Name: index_somebodies_on_remote_ip; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebodies_on_remote_ip ON somebodies USING btree (remote_ip);


--
-- Name: index_somebodies_on_type_and_auth_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_somebodies_on_type_and_auth_token ON somebodies USING btree (type, auth_token);


--
-- Name: index_somebodies_on_user_agent; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebodies_on_user_agent ON somebodies USING btree (user_agent);


--
-- Name: index_somebody_transactions_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebody_transactions_on_creator_id ON somebody_transactions USING btree (creator_id);


--
-- Name: index_somebody_transactions_on_somebody_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_somebody_transactions_on_somebody_id ON somebody_transactions USING btree (somebody_id);


--
-- Name: index_spare_applicabilities_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_applicabilities_on_brand_id ON spare_applicabilities USING btree (brand_id);


--
-- Name: index_spare_applicabilities_on_generation_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_applicabilities_on_generation_id ON spare_applicabilities USING btree (generation_id);


--
-- Name: index_spare_applicabilities_on_model_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_applicabilities_on_model_id ON spare_applicabilities USING btree (model_id);


--
-- Name: index_spare_applicabilities_on_modification_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_applicabilities_on_modification_id ON spare_applicabilities USING btree (modification_id);


--
-- Name: index_spare_applicabilities_on_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_applicabilities_on_spare_info_id ON spare_applicabilities USING btree (spare_info_id);


--
-- Name: index_spare_catalog_tokens_on_spare_catalog_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_catalog_tokens_on_spare_catalog_id ON spare_catalog_tokens USING btree (spare_catalog_id);


--
-- Name: index_spare_catalogs_on_spare_catalog_group_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_catalogs_on_spare_catalog_group_id ON spare_catalogs USING btree (spare_catalog_group_id);


--
-- Name: index_spare_info_phrases_on_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_info_phrases_on_spare_info_id ON spare_info_phrases USING btree (spare_info_id);


--
-- Name: index_spare_infos_on_brand_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_infos_on_brand_id ON spare_infos USING btree (brand_id);


--
-- Name: index_spare_infos_on_spare_catalog_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_infos_on_spare_catalog_id ON spare_infos USING btree (spare_catalog_id);


--
-- Name: index_spare_replacements_on_from_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_replacements_on_from_spare_info_id ON spare_replacements USING btree (from_spare_info_id);


--
-- Name: index_spare_replacements_on_to_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_spare_replacements_on_to_spare_info_id ON spare_replacements USING btree (to_spare_info_id);


--
-- Name: index_users_on_creator_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_creator_id ON users USING btree (creator_id);


--
-- Name: index_users_on_email; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_users_on_email ON users USING btree (email);


--
-- Name: index_users_on_reset_password_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_users_on_reset_password_token ON users USING btree (reset_password_token);


--
-- Name: index_warehouses_on_place_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_warehouses_on_place_id ON warehouses USING btree (place_id);


--
-- Name: index_warehouses_on_spare_info_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_warehouses_on_spare_info_id ON warehouses USING btree (spare_info_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- Name: fk_rails_266f4f9407; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_info_phrases
    ADD CONSTRAINT fk_rails_266f4f9407 FOREIGN KEY (spare_info_id) REFERENCES spare_infos(id);


--
-- Name: fk_rails_7c301f2df7; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY products
    ADD CONSTRAINT fk_rails_7c301f2df7 FOREIGN KEY (deliveries_place_id) REFERENCES deliveries_places(id);


--
-- Name: fk_rails_c02d25e658; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY spare_catalogs
    ADD CONSTRAINT fk_rails_c02d25e658 FOREIGN KEY (spare_catalog_group_id) REFERENCES spare_catalog_groups(id);


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

INSERT INTO schema_migrations (version) VALUES ('20121027175844');

INSERT INTO schema_migrations (version) VALUES ('20121106143606');

INSERT INTO schema_migrations (version) VALUES ('20121107184827');

INSERT INTO schema_migrations (version) VALUES ('20121207143942');

INSERT INTO schema_migrations (version) VALUES ('20121221143230');

INSERT INTO schema_migrations (version) VALUES ('20121224004534');

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

INSERT INTO schema_migrations (version) VALUES ('20130922203206');

INSERT INTO schema_migrations (version) VALUES ('20140210162300');

INSERT INTO schema_migrations (version) VALUES ('20140210162400');

INSERT INTO schema_migrations (version) VALUES ('20140210162610');

INSERT INTO schema_migrations (version) VALUES ('20140213012421');

INSERT INTO schema_migrations (version) VALUES ('20140304135621');

INSERT INTO schema_migrations (version) VALUES ('20140304201547');

INSERT INTO schema_migrations (version) VALUES ('20140308162758');

INSERT INTO schema_migrations (version) VALUES ('20140409194938');

INSERT INTO schema_migrations (version) VALUES ('20140409195035');

INSERT INTO schema_migrations (version) VALUES ('20140409195051');

INSERT INTO schema_migrations (version) VALUES ('20140414150436');

INSERT INTO schema_migrations (version) VALUES ('20140419155001');

INSERT INTO schema_migrations (version) VALUES ('20140420212924');

INSERT INTO schema_migrations (version) VALUES ('20140501151705');

INSERT INTO schema_migrations (version) VALUES ('20140613155843');

INSERT INTO schema_migrations (version) VALUES ('20140613160003');

INSERT INTO schema_migrations (version) VALUES ('20140615054649');

INSERT INTO schema_migrations (version) VALUES ('20140615054718');

INSERT INTO schema_migrations (version) VALUES ('20140615065414');

INSERT INTO schema_migrations (version) VALUES ('20140617025202');

INSERT INTO schema_migrations (version) VALUES ('20140706053926');

INSERT INTO schema_migrations (version) VALUES ('20140712231753');

INSERT INTO schema_migrations (version) VALUES ('20140714212333');

INSERT INTO schema_migrations (version) VALUES ('20140725230738');

INSERT INTO schema_migrations (version) VALUES ('20140731082734');

INSERT INTO schema_migrations (version) VALUES ('20140803012109');

INSERT INTO schema_migrations (version) VALUES ('20140803012115');

INSERT INTO schema_migrations (version) VALUES ('20140804054308');

INSERT INTO schema_migrations (version) VALUES ('20140806150318');

INSERT INTO schema_migrations (version) VALUES ('20140906072213');

INSERT INTO schema_migrations (version) VALUES ('20140906201729');

INSERT INTO schema_migrations (version) VALUES ('20140913152339');

INSERT INTO schema_migrations (version) VALUES ('20140915071435');

INSERT INTO schema_migrations (version) VALUES ('20141006025353');

INSERT INTO schema_migrations (version) VALUES ('20141011053349');

INSERT INTO schema_migrations (version) VALUES ('20141011053357');

INSERT INTO schema_migrations (version) VALUES ('20141011053405');

INSERT INTO schema_migrations (version) VALUES ('20141107160440');

INSERT INTO schema_migrations (version) VALUES ('20141107161606');

INSERT INTO schema_migrations (version) VALUES ('20141110045739');

INSERT INTO schema_migrations (version) VALUES ('20141111210657');

INSERT INTO schema_migrations (version) VALUES ('20141111210706');

INSERT INTO schema_migrations (version) VALUES ('20141111210712');

INSERT INTO schema_migrations (version) VALUES ('20141111210807');

INSERT INTO schema_migrations (version) VALUES ('20141115052731');

INSERT INTO schema_migrations (version) VALUES ('20141123095157');

INSERT INTO schema_migrations (version) VALUES ('20141123132440');

INSERT INTO schema_migrations (version) VALUES ('20141129220602');

INSERT INTO schema_migrations (version) VALUES ('20141203210937');

INSERT INTO schema_migrations (version) VALUES ('20141204183826');

INSERT INTO schema_migrations (version) VALUES ('20141205155812');

INSERT INTO schema_migrations (version) VALUES ('20141205160245');

INSERT INTO schema_migrations (version) VALUES ('20141216044524');

INSERT INTO schema_migrations (version) VALUES ('20150112112945');

INSERT INTO schema_migrations (version) VALUES ('20150114174108');

INSERT INTO schema_migrations (version) VALUES ('20150117202141');

INSERT INTO schema_migrations (version) VALUES ('20150121135654');

INSERT INTO schema_migrations (version) VALUES ('20150121141753');

INSERT INTO schema_migrations (version) VALUES ('20150214233552');

INSERT INTO schema_migrations (version) VALUES ('20150214234355');

INSERT INTO schema_migrations (version) VALUES ('20150214235607');

INSERT INTO schema_migrations (version) VALUES ('20150219204555');

INSERT INTO schema_migrations (version) VALUES ('20150220093637');

INSERT INTO schema_migrations (version) VALUES ('20150220100938');

INSERT INTO schema_migrations (version) VALUES ('20150225035028');

INSERT INTO schema_migrations (version) VALUES ('20150225042143');

INSERT INTO schema_migrations (version) VALUES ('20150228074529');

INSERT INTO schema_migrations (version) VALUES ('20150304113125');

INSERT INTO schema_migrations (version) VALUES ('20150304113458');

INSERT INTO schema_migrations (version) VALUES ('20150306183309');

INSERT INTO schema_migrations (version) VALUES ('20150306194354');

INSERT INTO schema_migrations (version) VALUES ('20150313035357');

INSERT INTO schema_migrations (version) VALUES ('20150326194116');

INSERT INTO schema_migrations (version) VALUES ('20150416123919');

INSERT INTO schema_migrations (version) VALUES ('20150416154252');

INSERT INTO schema_migrations (version) VALUES ('20150416161036');

INSERT INTO schema_migrations (version) VALUES ('20150416161556');

INSERT INTO schema_migrations (version) VALUES ('20150416161643');

INSERT INTO schema_migrations (version) VALUES ('20150418110510');

INSERT INTO schema_migrations (version) VALUES ('20150425032739');

INSERT INTO schema_migrations (version) VALUES ('20150425123410');

INSERT INTO schema_migrations (version) VALUES ('20150425152814');

INSERT INTO schema_migrations (version) VALUES ('20150505030808');

INSERT INTO schema_migrations (version) VALUES ('20150512221516');

INSERT INTO schema_migrations (version) VALUES ('20150513150519');

INSERT INTO schema_migrations (version) VALUES ('20150522092733');

INSERT INTO schema_migrations (version) VALUES ('20150523043528');

INSERT INTO schema_migrations (version) VALUES ('20150524033803');

INSERT INTO schema_migrations (version) VALUES ('20150524221102');

INSERT INTO schema_migrations (version) VALUES ('20150525052444');

INSERT INTO schema_migrations (version) VALUES ('20150526090432');

INSERT INTO schema_migrations (version) VALUES ('20150527023128');

INSERT INTO schema_migrations (version) VALUES ('20150528104139');

INSERT INTO schema_migrations (version) VALUES ('20150605124316');

INSERT INTO schema_migrations (version) VALUES ('20150822031229');

INSERT INTO schema_migrations (version) VALUES ('20150822151002');

INSERT INTO schema_migrations (version) VALUES ('20150822151448');

INSERT INTO schema_migrations (version) VALUES ('20150822162006');

INSERT INTO schema_migrations (version) VALUES ('20150823132425');

INSERT INTO schema_migrations (version) VALUES ('20150830182557');

INSERT INTO schema_migrations (version) VALUES ('20150830183518');

INSERT INTO schema_migrations (version) VALUES ('20150830204409');

INSERT INTO schema_migrations (version) VALUES ('20150830212934');

INSERT INTO schema_migrations (version) VALUES ('20150830214155');

INSERT INTO schema_migrations (version) VALUES ('20150830223925');

INSERT INTO schema_migrations (version) VALUES ('20150830224449');

INSERT INTO schema_migrations (version) VALUES ('20150830224753');

INSERT INTO schema_migrations (version) VALUES ('20150831054546');

INSERT INTO schema_migrations (version) VALUES ('20150831074318');

INSERT INTO schema_migrations (version) VALUES ('20150831235524');

INSERT INTO schema_migrations (version) VALUES ('20150901031407');

INSERT INTO schema_migrations (version) VALUES ('20150903085312');

INSERT INTO schema_migrations (version) VALUES ('20150903103919');

INSERT INTO schema_migrations (version) VALUES ('20150903105540');

INSERT INTO schema_migrations (version) VALUES ('20150903131505');

INSERT INTO schema_migrations (version) VALUES ('20150903164913');

INSERT INTO schema_migrations (version) VALUES ('20150904095232');

INSERT INTO schema_migrations (version) VALUES ('20150907052955');

INSERT INTO schema_migrations (version) VALUES ('20150907053042');

INSERT INTO schema_migrations (version) VALUES ('20150910103005');

INSERT INTO schema_migrations (version) VALUES ('20150910104117');

INSERT INTO schema_migrations (version) VALUES ('20150910150422');

INSERT INTO schema_migrations (version) VALUES ('20150919133514');

INSERT INTO schema_migrations (version) VALUES ('20150925055346');

INSERT INTO schema_migrations (version) VALUES ('20151006134626');

INSERT INTO schema_migrations (version) VALUES ('20151007051155');

INSERT INTO schema_migrations (version) VALUES ('20151008232547');

