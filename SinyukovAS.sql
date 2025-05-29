--
-- PostgreSQL database dump
--

-- Dumped from database version 17.0
-- Dumped by pg_dump version 17.0

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'LATIN1';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: update_additional_price(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_additional_price() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    cake_count INT;
BEGIN
    SELECT COUNT(*)
    INTO cake_count
    FROM sale
    WHERE conditioner_name = NEW.conditioner_name;

    UPDATE conditioner
    SET conditioner_cost = conditioner_cost* (1 + (cake_count * 0.05))
    WHERE conditioner_name = NEW.conditioner_name;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_additional_price() OWNER TO postgres;

--
-- Name: update_client_discount(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.update_client_discount() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
    current_discount INT;
BEGIN
    SELECT client_sale INTO current_discount
    FROM client
    WHERE client_id = NEW.client_id;
    IF current_discount IS NULL OR current_discount <= 30 THEN

        UPDATE client
        SET client_sale = COALESCE(current_discount, 0) + 5
        WHERE client_id = NEW.client_id;
    END IF;

    RETURN NEW;
END;
$$;


ALTER FUNCTION public.update_client_discount() OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: administrator; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.administrator (
    administrator_money numeric NOT NULL,
    administrator_name character varying(64) NOT NULL,
    administrator_pasport integer NOT NULL
);


ALTER TABLE public.administrator OWNER TO postgres;

--
-- Name: administrator_administrator_pasport_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.administrator_administrator_pasport_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.administrator_administrator_pasport_seq OWNER TO postgres;

--
-- Name: administrator_administrator_pasport_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.administrator_administrator_pasport_seq OWNED BY public.administrator.administrator_pasport;


--
-- Name: cake; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cake (
    cake_figures character varying(20),
    cake_form character varying(20) NOT NULL,
    cake_date date NOT NULL,
    cake_name character varying(30) NOT NULL,
    sale_number integer,
    cake_letters character varying(50),
    cake_cost money NOT NULL
);


ALTER TABLE public.cake OWNER TO postgres;

--
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    client_name character varying(64) NOT NULL,
    client_adress character varying(100) NOT NULL,
    client_sale numeric NOT NULL,
    client_pasport character(10) NOT NULL,
    client_id integer NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- Name: client_client_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.client_client_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.client_client_id_seq OWNER TO postgres;

--
-- Name: client_client_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.client_client_id_seq OWNED BY public.client.client_id;


--
-- Name: conditioner; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.conditioner (
    conditioner_rang character varying(10) NOT NULL,
    conditioner_cost numeric NOT NULL,
    conditioner_name character varying(70) NOT NULL
);


ALTER TABLE public.conditioner OWNER TO postgres;

--
-- Name: doing; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.doing (
    cake_name character varying(30) NOT NULL,
    conditioner_name character varying(70) NOT NULL
);


ALTER TABLE public.doing OWNER TO postgres;

--
-- Name: includes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.includes (
    cake_name character varying(30) NOT NULL,
    ingredients_name character varying(30) NOT NULL,
    includes_num integer NOT NULL
);


ALTER TABLE public.includes OWNER TO postgres;

--
-- Name: ingredients; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.ingredients (
    ingredients_name character varying(30) NOT NULL,
    provider_name character varying(30) NOT NULL,
    ingredients_cost money NOT NULL,
    ingredients_thing character varying(10) NOT NULL,
    ingredients_num integer NOT NULL,
    ingredients_datenormal date NOT NULL
);


ALTER TABLE public.ingredients OWNER TO postgres;

--
-- Name: provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.provider (
    provider_name character varying(30) NOT NULL
);


ALTER TABLE public.provider OWNER TO postgres;

--
-- Name: sale; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sale (
    sale_date date NOT NULL,
    sale_cost money NOT NULL,
    sale_weight numeric NOT NULL,
    sale_number integer NOT NULL,
    conditioner_name character varying(70) NOT NULL,
    client_id integer NOT NULL,
    administrator_pasport integer NOT NULL
);


ALTER TABLE public.sale OWNER TO postgres;

--
-- Name: administrator administrator_pasport; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator ALTER COLUMN administrator_pasport SET DEFAULT nextval('public.administrator_administrator_pasport_seq'::regclass);


--
-- Name: client client_id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client ALTER COLUMN client_id SET DEFAULT nextval('public.client_client_id_seq'::regclass);


--
-- Data for Name: administrator; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.administrator (administrator_money, administrator_name, administrator_pasport) FROM stdin;
80000	Леонель Месси	420566664
30000	Иван Грозный	421788899
23000	Роб Бобинс	421566677
30000	Боб Робинс	421566666
20000	Данила Синюков	421455555
1000	Джон Сина	421388888
10000	Иван Свиридов	429909784
\.


--
-- Data for Name: cake; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.cake (cake_figures, cake_form, cake_date, cake_name, sale_number, cake_letters, cake_cost) FROM stdin;
Есть	Прямоугольный	2024-12-21	Шоколадный	9	С Днем рождения	800,00 ?
Нет	Круглый	2024-12-01	Мальчик и персики	8	Самый вкусный	900,00 ?
Нет	Квадратный	2024-12-12	Вишнёвый	7	С Днем рождения	1 900,00 ?
Есть	Квадратный	2024-11-22	Тирамиссу	6	Самый вкусный	2 100,00 ?
Нет	Круглый	2024-12-30	Медовик	5	Самый вкусный	2 000,00 ?
Есть	Круглый	2024-12-25	Красный бархат	4	С Днем рождения	2 400,00 ?
Нет	Прямоугольный	2024-11-23	Наполеон	3	Самый вкусный	1 000,00 ?
Есть	Квадратный	2024-12-22	Шу	2	С Днем рождения	2 000,00 ?
Есть	Круглый	2024-12-23	Шарлотка	1	С Днем рождения	2 000,00 ?
Есть	Круглый	2024-12-01	Солдатский	\N	Наконец-то	2 000,00 ?
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (client_name, client_adress, client_sale, client_pasport, client_id) FROM stdin;
Денис Шохин	ул. Доватора 34	10	4204555777	5
Елена Летучая	ул. Свердлова 10	10	4203666555	4
Виктор Малышев	ул. Фрунзе 12	5	4210999999	3
Синюков Юрий	ул. Мичурина 42	20	4224888888	2
Василий Слуцкий	ул. Доватора 2	5	4220999000	6
Алексей Пантелеев	ул. Миучрина 24	20	4220333445	7
Ляпин Борис	ул. Интернациональная 51	35	4218777777	1
\.


--
-- Data for Name: conditioner; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.conditioner (conditioner_rang, conditioner_cost, conditioner_name) FROM stdin;
Шеф	500	Данила Богров
Младший	300	Ангелина Максимова
Старший	250	Артем Овчинников
Младший	200	Людмила Хвостова
Старший	130.00	Юлия Синюкова
Младший	300.0000	Кирилл Гладких
Младший	110.2500	Иван Абрамов
\.


--
-- Data for Name: doing; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.doing (cake_name, conditioner_name) FROM stdin;
Медовик	Артем Овчинников
Наполеон	Артем Овчинников
Тирамиссу	Юлия Синюкова
Красный бархат	Кирилл Гладких
Шу	Артем Овчинников
\.


--
-- Data for Name: includes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.includes (cake_name, ingredients_name, includes_num) FROM stdin;
\.


--
-- Data for Name: ingredients; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.ingredients (ingredients_name, provider_name, ingredients_cost, ingredients_thing, ingredients_num, ingredients_datenormal) FROM stdin;
Мастика	TastyG	140,00 ?	кг	40	2028-10-10
Шоколад	Shield	400,00 ?	кг	100	2028-10-19
Мёд	MilkShilk	300,00 ?	л	200	2025-06-10
Мука	NastyTea	210,00 ?	кг	110	2025-06-07
Сахар	GoodFood	100,00 ?	кг	20	2025-12-24
Молоко	Tasty	100,00 ?	л	10	2024-10-12
\.


--
-- Data for Name: provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.provider (provider_name) FROM stdin;
Tasty
Shield
MilkShilk
NastyTea
TastyG
GoodFood
\.


--
-- Data for Name: sale; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.sale (sale_date, sale_cost, sale_weight, sale_number, conditioner_name, client_id, administrator_pasport) FROM stdin;
2024-12-20	1 000,00 ?	1	9	Артем Овчинников	1	421788899
2024-12-31	1 800,00 ?	2	8	Юлия Синюкова	5	421455555
2024-12-24	1 900,00 ?	3	7	Кирилл Гладких	5	421388888
2024-12-11	2 300,00 ?	1	6	Юлия Синюкова	4	421455555
2024-12-27	2 100,00 ?	2	5	Кирилл Гладких	3	421388888
2024-12-22	2 400,00 ?	2	4	Юлия Синюкова	3	421455555
2024-12-10	1 900,00 ?	1	3	Артем Овчинников	2	421388888
2024-12-23	2 050,00 ?	3	2	Артем Овчинников	1	421788899
2024-12-23	2 000,00 ?	2	1	Юлия Синюкова	1	421388888
2024-12-26	2 000,00 ?	1	10	Юлия Синюкова	1	421388888
2024-12-26	1 000,00 ?	2	11	Артем Овчинников	6	421788899
2024-12-30	1 000,00 ?	2	12	Кирилл Гладких	1	421788899
2024-12-31	1 000,00 ?	2	14	Кирилл Гладких	1	421788899
2024-12-30	2 000,00 ?	2	15	Юлия Синюкова	1	421788899
2024-11-30	1 000,00 ?	2	16	Кирилл Гладких	1	421788899
2024-12-31	5 000,00 ?	2.5	17	Иван Абрамов	1	429909784
\.


--
-- Name: administrator_administrator_pasport_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.administrator_administrator_pasport_seq', 1, false);


--
-- Name: client_client_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.client_client_id_seq', 1, false);


--
-- Name: administrator pk_administrator; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.administrator
    ADD CONSTRAINT pk_administrator PRIMARY KEY (administrator_pasport);


--
-- Name: cake pk_cake; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cake
    ADD CONSTRAINT pk_cake PRIMARY KEY (cake_name);


--
-- Name: client pk_client; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT pk_client PRIMARY KEY (client_id);


--
-- Name: conditioner pk_conditioner; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.conditioner
    ADD CONSTRAINT pk_conditioner PRIMARY KEY (conditioner_name);


--
-- Name: doing pk_doing; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doing
    ADD CONSTRAINT pk_doing PRIMARY KEY (cake_name, conditioner_name);


--
-- Name: ingredients pk_ingredients; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT pk_ingredients PRIMARY KEY (ingredients_name);


--
-- Name: provider pk_provider; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.provider
    ADD CONSTRAINT pk_provider PRIMARY KEY (provider_name);


--
-- Name: sale pk_sale; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT pk_sale PRIMARY KEY (sale_number);


--
-- Name: administrator_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX administrator_pk ON public.administrator USING btree (administrator_pasport);


--
-- Name: buy_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX buy_fk ON public.sale USING btree (client_id);


--
-- Name: cake_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX cake_pk ON public.cake USING btree (cake_name);


--
-- Name: client_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX client_pk ON public.client USING btree (client_id);


--
-- Name: conditioner_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX conditioner_pk ON public.conditioner USING btree (conditioner_name);


--
-- Name: contains_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX contains_fk ON public.ingredients USING btree (provider_name);


--
-- Name: doing2_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX doing2_fk ON public.doing USING btree (conditioner_name);


--
-- Name: doing_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX doing_fk ON public.doing USING btree (cake_name);


--
-- Name: doing_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX doing_pk ON public.doing USING btree (cake_name, conditioner_name);


--
-- Name: gives_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX gives_fk ON public.sale USING btree (conditioner_name);


--
-- Name: includes1_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX includes1_fk ON public.includes USING btree (cake_name);


--
-- Name: includes_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX includes_fk ON public.includes USING btree (ingredients_name);


--
-- Name: ingredients_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ingredients_pk ON public.ingredients USING btree (ingredients_name);


--
-- Name: knows_fk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX knows_fk ON public.sale USING btree (administrator_pasport);


--
-- Name: provider_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX provider_pk ON public.provider USING btree (provider_name);


--
-- Name: sale_pk; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX sale_pk ON public.sale USING btree (sale_number);


--
-- Name: sale after_sale_insert; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_sale_insert AFTER INSERT ON public.sale FOR EACH ROW EXECUTE FUNCTION public.update_additional_price();


--
-- Name: sale update_client_discount_after_sale; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER update_client_discount_after_sale AFTER INSERT ON public.sale FOR EACH ROW EXECUTE FUNCTION public.update_client_discount();


--
-- Name: cake fk_cake_what_sale; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cake
    ADD CONSTRAINT fk_cake_what_sale FOREIGN KEY (sale_number) REFERENCES public.sale(sale_number) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: doing fk_doing_doing2_conditio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doing
    ADD CONSTRAINT fk_doing_doing2_conditio FOREIGN KEY (conditioner_name) REFERENCES public.conditioner(conditioner_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: doing fk_doing_doing_cake; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.doing
    ADD CONSTRAINT fk_doing_doing_cake FOREIGN KEY (cake_name) REFERENCES public.cake(cake_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: includes fk_includes_includes1_cake; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.includes
    ADD CONSTRAINT fk_includes_includes1_cake FOREIGN KEY (cake_name) REFERENCES public.cake(cake_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: includes fk_includes_includes_ingredie; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.includes
    ADD CONSTRAINT fk_includes_includes_ingredie FOREIGN KEY (ingredients_name) REFERENCES public.ingredients(ingredients_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: ingredients fk_ingredie_contains_provider; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.ingredients
    ADD CONSTRAINT fk_ingredie_contains_provider FOREIGN KEY (provider_name) REFERENCES public.provider(provider_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sale fk_sale_buy_client; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT fk_sale_buy_client FOREIGN KEY (client_id) REFERENCES public.client(client_id) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sale fk_sale_gives_conditio; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT fk_sale_gives_conditio FOREIGN KEY (conditioner_name) REFERENCES public.conditioner(conditioner_name) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: sale fk_sale_knows_administ; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sale
    ADD CONSTRAINT fk_sale_knows_administ FOREIGN KEY (administrator_pasport) REFERENCES public.administrator(administrator_pasport) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--

