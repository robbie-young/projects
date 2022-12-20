--
-- PostgreSQL database dump
--

-- Dumped from database version 14.0
-- Dumped by pg_dump version 14.0

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

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: countries; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.countries (
    id integer NOT NULL,
    countries text
);


--
-- Name: countries_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.countries_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: countries_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.countries_id_seq OWNED BY public.countries.id;


--
-- Name: date_added; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.date_added (
    id integer NOT NULL,
    date_added text
);


--
-- Name: date_added_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.date_added_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: date_added_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.date_added_id_seq OWNED BY public.date_added.id;


--
-- Name: genres; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.genres (
    id integer NOT NULL,
    genres text
);


--
-- Name: genres_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.genres_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: genres_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.genres_id_seq OWNED BY public.genres.id;


--
-- Name: rating; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.rating (
    id integer NOT NULL,
    rating text
);


--
-- Name: rating_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.rating_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rating_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.rating_id_seq OWNED BY public.rating.id;


--
-- Name: super_table; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.super_table (
    id integer NOT NULL,
    type_id integer,
    title text,
    director text,
    actors text,
    countries_id integer,
    date_added_id integer,
    release_year integer,
    rating_id integer,
    duration text,
    genres_id integer,
    description text
);


--
-- Name: super_table_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.super_table_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: super_table_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.super_table_id_seq OWNED BY public.super_table.id;


--
-- Name: type; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.type (
    id integer NOT NULL,
    type text
);


--
-- Name: type_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.type_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: type_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.type_id_seq OWNED BY public.type.id;


--
-- Name: countries id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.countries ALTER COLUMN id SET DEFAULT nextval('public.countries_id_seq'::regclass);


--
-- Name: date_added id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.date_added ALTER COLUMN id SET DEFAULT nextval('public.date_added_id_seq'::regclass);


--
-- Name: genres id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.genres ALTER COLUMN id SET DEFAULT nextval('public.genres_id_seq'::regclass);


--
-- Name: rating id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rating ALTER COLUMN id SET DEFAULT nextval('public.rating_id_seq'::regclass);


--
-- Name: super_table id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.super_table ALTER COLUMN id SET DEFAULT nextval('public.super_table_id_seq'::regclass);


--
-- Name: type id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.type ALTER COLUMN id SET DEFAULT nextval('public.type_id_seq'::regclass);


--
-- Data for Name: countries; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.countries (id, countries) FROM stdin;
1	
2	United States, Canada
3	United States
4	France, South Korea, Japan, United States
5	United States, United Kingdom
6	United States, Spain, France, Canada, United Kingdom
7	France
8	United States, United Kingdom, Hungary
9	United States, Germany
10	United States, United Kingdom, Australia
11	France, United Kingdom
12	Canada
13	United States, India
14	United States, Canada, United Kingdom, Singapore, Australia, Thailand
15	Canada, United States
16	United States, South Korea
17	South Korea, United States, China, Japan
18	Australia, United Kingdom
19	United Kingdom
20	United States, United Kingdom, South Korea
21	United States, United Kingdom, Canada
22	United States, Germany, United Kingdom
23	United States, Canada, Ireland
24	United States, Brazil
25	United Kingdom, United States
26	United Kingdom, United States, Canada, Ireland
27	United States, United Kingdom, Belgium, Canada
28	Austria, South Africa
29	United States, Japan
30	United States, Spain
31	United Kingdom, Germany, United States
32	United Kingdom, United States, France
33	United States, Canada, Hong Kong
34	Argentina
35	United Arab Emirates
36	United States, Mexico
37	United Kingdom, Australia
38	France, Switzerland, Spain, United States, United Arab Emirates
39	United Kingdom, France
40	Argentina, Mexico
41	India
42	France, Japan
43	United Kingdom, Canada, United States
44	Ireland, United States
45	United States, Ireland
46	France, United Kingdom, United States
47	United Kingdom, United States, Canada
48	United States, Germany, Ireland, United Kingdom
49	United States, United Kingdom, South Africa
50	United Kingdom, United States, Ireland
51	France, United States
52	United States, Australia
53	Ireland, United Kingdom, United States, South Korea, Canada
54	United States, South Korea, France
55	United States, Australia, France, Canada
56	United States, Hungary, United Kingdom
57	United States, Hong Kong, South Korea, France, Canada, China, United Kingdom, Australia, Japan, Taiwan, Philippines
58	United States, Taiwan, South Korea, China, Japan, United Kingdom
59	Germany, United States
60	United Kingdom, Germany
61	United States, Philippines, South Korea
62	United Kingdom, China, United States
63	Tanzania, United States
64	United States, Panama, Mexico
65	United States, United Kingdom, Australia, Canada
66	United States, France
67	United States, Angola, Botswana, Namibia, South Africa
68	Canada, United States, United Kingdom, France, Luxembourg
69	Australia, United States
70	United States, Denmark
71	Denmark, China
72	United States, Guatemala
73	United States, South Korea, Singapore, Russia, Malaysia, Kazakhstan, Taiwan, Hong Kong, Japan, China, India, Syria, Iran, Egypt, Pakistan
74	United States, Canada, Australia
75	United States, South Korea, China, Taiwan
76	United States, Taiwan, China
77	United States, New Zealand
78	Canada, Malaysia, United States
79	United States, India, United Kingdom
80	Norway, Sweden, United States
81	France, Canada, United States
82	United States, Poland, Slovenia, Czech Republic, United Kingdom
83	United States, Canada, Australia, Taiwan
84	China, Hong Kong, United States
85	Austria, United Kingdom, United States
86	China
87	Germany
88	New Zealand, United States
\.


--
-- Data for Name: date_added; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.date_added (id, date_added) FROM stdin;
1	September 24, 2021
2	September 22, 2021
3	September 17, 2021
4	September 15, 2021
5	September 10, 2021
6	September 8, 2021
7	September 3, 2021
8	September 1, 2021
9	August 27, 2021
10	August 25, 2021
11	August 20, 2021
12	August 18, 2021
13	August 13, 2021
14	August 11, 2021
15	August 6, 2021
16	August 4, 2021
17	July 30, 2021
18	July 28, 2021
19	July 23, 2021
20	July 21, 2021
21	July 16, 2021
22	July 14, 2021
23	July 9, 2021
24	July 7, 2021
25	July 2, 2021
26	June 25, 2021
27	June 18, 2021
28	June 11, 2021
29	June 9, 2021
30	June 4, 2021
31	May 28, 2021
32	May 21, 2021
33	May 17, 2021
34	May 14, 2021
35	May 10, 2021
36	May 7, 2021
37	May 4, 2021
38	May 3, 2021
39	April 30, 2021
40	April 23, 2021
41	April 22, 2021
42	April 16, 2021
43	April 9, 2021
44	April 2, 2021
45	March 26, 2021
46	March 19, 2021
47	March 12, 2021
48	March 5, 2021
49	February 26, 2021
50	February 19, 2021
51	February 12, 2021
52	February 5, 2021
53	January 29, 2021
54	January 22, 2021
55	January 15, 2021
56	January 8, 2021
57	January 1, 2021
58	December 25, 2020
59	December 18, 2020
60	December 11, 2020
61	December 4, 2020
62	November 27, 2020
63	November 25, 2020
64	November 20, 2020
65	November 18, 2020
66	November 17, 2020
67	November 13, 2020
68	November 6, 2020
69	October 30, 2020
70	October 23, 2020
71	October 16, 2020
72	October 9, 2020
73	October 2, 2020
74	September 25, 2020
75	September 18, 2020
76	September 11, 2020
77	September 4, 2020
78	August 28, 2020
79	August 21, 2020
80	August 14, 2020
81	August 7, 2020
82	July 31, 2020
83	July 24, 2020
84	July 17, 2020
85	July 10, 2020
86	July 5, 2020
87	July 3, 2020
88	June 26, 2020
89	June 19, 2020
90	June 12, 2020
91	June 5, 2020
92	May 29, 2020
93	May 22, 2020
94	May 15, 2020
95	May 4, 2020
96	May 2, 2020
97	May 1, 2020
98	April 30, 2020
99	April 28, 2020
100	April 24, 2020
101	April 23, 2020
102	April 22, 2020
103	April 17, 2020
104	April 14, 2020
105	April 10, 2020
106	April 3, 2020
107	April 1, 2020
108	March 27, 2020
109	March 25, 2020
110	March 20, 2020
111	March 15, 2020
112	March 14, 2020
113	March 13, 2020
114	March 6, 2020
115	March 5, 2020
116	March 4, 2020
117	February 28, 2020
118	February 25, 2020
119	February 21, 2020
120	February 16, 2020
121	February 14, 2020
122	February 8, 2020
123	February 7, 2020
124	February 5, 2020
125	February 2, 2020
126	February 1, 2020
127	January 31, 2020
128	January 28, 2020
129	January 17, 2020
130	January 15, 2020
131	January 10, 2020
132	January 8, 2020
133	January 3, 2020
134	January 1, 2020
135	December 27, 2019
136	December 26, 2019
137	December 20, 2019
138	December 13, 2019
139	December 6, 2019
140	December 5, 2019
141	December 3, 2019
142	December 1, 2019
143	November 29, 2019
144	November 27, 2019
145	November 22, 2019
146	November 20, 2019
147	November 18, 2019
148	November 15, 2019
149	November 12, 2019
150	October 1, 2019
151	
\.


--
-- Data for Name: genres; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.genres (id, genres) FROM stdin;
1	Documentary
2	Comedy, Fantasy, Kids
3	Coming of Age, Drama, Romance
4	Animals & Nature, Docuseries, Family
5	Action-Adventure, Animation, Kids
6	Action-Adventure, Animation, Anime
7	Comedy, Romance, Romantic Comedy
8	Animation, Fantasy, Musical
9	Concert Film
10	Animals & Nature, Documentary
11	Animation, Comedy, Family
12	Action-Adventure, Animals & Nature, Docuseries
13	Action-Adventure, Animation, Fantasy
14	Kids, Music
15	Animals & Nature, Docuseries
16	Comedy
17	Action-Adventure, Fantasy
18	Animation, Family
19	Comedy, Coming of Age, Family
20	Animation, Fantasy, Kids
21	Animation, Comedy, Coming of Age
22	Concert Film, Music
23	Action-Adventure, Science Fiction
24	Action-Adventure, Family, Science Fiction
25	Crime, Drama
26	Comedy, Drama, Romance
27	Family, Music, Variety
28	Comedy, Drama, Thriller
29	Action-Adventure, Family, Parody
30	Action-Adventure, Family, Fantasy
31	Comedy, Coming of Age, Fantasy
32	Reality
33	Animation, Kids, Police/Cop
34	Comedy, Family, Science Fiction
35	Action-Adventure, Animation, Anthology
36	Action-Adventure, Comedy, Family
37	Comedy, Drama
38	Animation, Kids
39	Animation, Anthology, Family
40	Comedy, Family
41	Animation, Buddy, Comedy
42	Animation, Buddy, Kids
43	Talk Show
44	Animals & Nature, Biographical, Documentary
45	Docuseries, Family
46	Action-Adventure, Buddy, Comedy
47	Animals & Nature, Drama, Family
48	Comedy, Coming of Age
49	Animals & Nature, Coming of Age, Drama
50	Animation, Fantasy
51	Action-Adventure, Docuseries, Reality
52	Animation, Kids, Sports
53	Animation, Comedy, Parody
54	Comedy, Family, Fantasy
55	Comedy, Sports
56	Action-Adventure, Comedy, Coming of Age
57	Action-Adventure, Reality, Survival
58	Action-Adventure, Family
59	Biographical, Documentary
60	Animation, Kids, Western
61	Animation, Buddy, Coming of Age
62	Action-Adventure, Animation, Family
63	Biographical, Coming of Age, Family
64	Action-Adventure, Comedy, Spy/Espionage
65	Action-Adventure, Fantasy, Science Fiction
66	Action-Adventure, Docuseries, Lifestyle
67	Action-Adventure, Drama, Historical
68	Animation, Dance, Family
69	Drama
70	Coming of Age, Drama
71	Coming of Age, Fantasy
72	Fantasy
73	Action-Adventure, Animation, Comedy
74	Animation
75	Docuseries, Reality, Survival
76	Animals & Nature, Animation, Kids
77	Action-Adventure, Family, Game Show / Competition
78	Biographical, Drama
79	Science Fiction
80	Anthology, Science Fiction
81	Action-Adventure, Animation, Science Fiction
82	Fantasy, Musical
83	Biographical, Documentary, Music
84	Musical, Romance, Western
85	Action-Adventure, Comedy, Crime
86	Comedy, Coming of Age, Kids
87	Comedy, Drama, Sports
88	Animals & Nature, Anthology
89	Action-Adventure, Coming of Age, Family
90	Action-Adventure, Comedy, Kids
91	Action-Adventure, Animals & Nature, Drama
92	Family, Kids
93	Action-Adventure, Animation
94	Comedy, Coming of Age, Crime
95	Biographical, Coming of Age, Drama
96	Action-Adventure, Biographical, Drama
97	Animation, Kids, Musical
98	Action-Adventure, Fantasy, Survival
99	Series
100	Animals & Nature, Comedy
101	Comedy, Reality
102	Action-Adventure, Buddy, Science Fiction
103	Animation, Kids, Medical
104	Anthology, Docuseries
105	Comedy, Family, Kids
106	Buddy, Comedy, Docuseries
107	Game Show / Competition, Sports, Variety
108	Comedy, Docuseries, Family
109	Comedy, Fantasy
110	Animation, Comedy, Kids
111	Animation, Family, Fantasy
112	Family, Fantasy, Mystery
113	Variety
114	Comedy, Coming of Age, Drama
115	Comedy, Family, Variety
116	Anthology, Documentary
117	Family, Fantasy, Musical
118	Drama, Fantasy, Mystery
119	Family, Game Show / Competition, Reality
120	Action-Adventure, Docuseries, Fantasy
121	Action-Adventure, Docuseries, Family
122	Documentary, Historical
123	Biographical, Comedy, Drama
124	Action-Adventure, Fantasy, Musical
125	Animals & Nature, Docuseries, Reality
126	Fantasy, Variety
127	Movies
128	Drama, Music, Romance
129	Biographical, Drama, Sports
130	Action-Adventure, Coming of Age, Drama
131	Action-Adventure, Fantasy, Soap Opera / Melodrama
132	Animals & Nature, Kids, Music
133	Documentary, Music
134	Coming of Age, Drama, Music
135	Action-Adventure, Animation, Buddy
136	Comedy, Variety
137	Docuseries, Reality
138	Biographical, Drama, Music
139	Docuseries, Historical
140	Animals & Nature, Documentary, Survival
141	Drama, Historical
142	Animals & Nature, Documentary, Family
143	Drama, Music
144	Animation, Comedy
145	Biographical, Drama, Family
146	Anthology, Docuseries, Family
147	Buddy, Comedy, Coming of Age
148	Drama, Romance
149	Docuseries, Historical, Reality
150	Documentary, Sports
151	Drama, Family, Fantasy
152	Comedy, Drama, Family
153	Comedy, Parody, Science Fiction
154	Animals & Nature, Kids, Variety
155	Animation, Kids, Music
156	Coming of Age, Fantasy, Musical
157	Action-Adventure, Comedy, Science Fiction
158	Animals & Nature, Docuseries, Kids
159	Docuseries, Kids
160	Documentary, Family
161	Animals & Nature, Family, Reality
162	Dance, Music, Musical
163	Comedy, Family, Lifestyle
164	Buddy, Docuseries
165	Documentary, Family, Historical
166	Coming of Age, Drama, Family
167	Historical, Musical
168	Action-Adventure, Crime, Science Fiction
169	Biographical, Historical, Musical
170	Comedy, Family, Sports
171	Comedy, Coming of Age, Music
172	Animation, Documentary, Family
173	Action-Adventure, Animation, Coming of Age
174	Comedy, Kids
175	Action-Adventure, Crime, Fantasy
176	Comedy, Coming of Age, Medical
177	Drama, Family, Historical
178	Animals & Nature, Comedy, Family
179	Coming of Age, Fantasy, Mystery
180	Crime, Drama, Mystery
181	Animation, Comedy, Crime
182	Comedy, Musical, Romance
183	Family, Game Show / Competition
184	Docuseries
185	Action-Adventure, Docuseries, Historical
186	Action-Adventure, Animals & Nature, Family
187	Animation, Family, Sports
188	Action-Adventure, Mystery, Thriller
189	Docuseries, Family, Game Show / Competition
190	Concert Film, Music, Musical
191	Animals & Nature, Family
192	Animation, Family, Parody
193	Comedy, Coming of Age, Romance
194	Animation, Family, Historical
195	Action-Adventure, Animals & Nature, Animation
196	Animation, Drama, Parody
197	Coming of Age, Drama, Musical
198	Action-Adventure, Disaster, Drama
199	Action-Adventure, Science Fiction, Superhero
200	Action-Adventure, Animation, Musical
201	Docuseries, Family, Lifestyle
202	Comedy, Fantasy, Romance
203	Buddy, Comedy, Drama
204	Animation, Family, Romance
205	Coming of Age, Drama, Science Fiction
206	Animation, Comedy, Fantasy
207	Biographical, Comedy, Family
208	Animals & Nature, Family, Sports
209	Action-Adventure, Animation, Superhero
210	Docuseries, Science Fiction
211	Coming of Age, Documentary, Drama
212	Action-Adventure, Comedy, Fantasy
213	Action-Adventure, Documentary, Historical
214	Buddy, Docuseries, Lifestyle
215	Concert Film, Family, Fantasy
216	Animation, Comedy, Dance
217	Action-Adventure, Animals & Nature, Documentary
218	Coming of Age, Drama, Sports
219	Drama, Family
220	Drama, Family, Musical
221	Animation, Drama, Family
222	Animation, Drama, Kids
223	Animation, Anthology, Fantasy
224	Animation, Family, Kids
225	Animation, Coming of Age, Family
226	Buddy, Coming of Age, Drama
227	Coming of Age, Docuseries, Family
228	Coming of Age, Music, Musical
229	Comedy, Coming of Age, Science Fiction
230	Drama, Family, Mystery
231	Animation, Comedy, Disaster
232	Sports
233	Comedy, Family, Game Show / Competition
234	Comedy, Mystery
235	Family, Fantasy, Romance
236	Action-Adventure, Family, Historical
237	Documentary, Family, Reality
238	Buddy, Comedy, Family
239	Animation, Coming of Age, Fantasy
240	Anthology, Family, Lifestyle
241	Animation, Anthology, Comedy
242	Animation, Kids, Parody
243	Fantasy, Musical, Thriller
244	Family, Lifestyle, Reality
245	Documentary, Family, Variety
246	Biographical, Sports
247	Docuseries, Family, Medical
248	Comedy, Coming of Age, Sports
249	Action-Adventure, Crime, Family
250	Music, Reality
251	Drama, Parody, Science Fiction
252	Action-Adventure, Documentary, Sports
253	Anthology, Comedy, Coming of Age
254	Drama, Mystery
255	Coming of Age, Sports
256	Coming of Age, Dance, Drama
257	Animation, Family, Music
258	Animals & Nature, Docuseries, Survival
259	Concert Film, Documentary, Music
260	Comedy, Family, Romantic Comedy
261	Coming of Age, Musical, Romance
262	Coming of Age, Musical
263	Coming of Age, Family, Musical
264	Animals & Nature, Comedy, Coming of Age
265	Biographical, Family, Sports
266	Comedy, Science Fiction
267	Animals & Nature, Documentary, Medical
268	Coming of Age, Dance, Sports
269	Action-Adventure, Coming of Age
270	Animation, Family, Musical
271	Action-Adventure, Documentary, Superhero
272	Action-Adventure, Fantasy, Superhero
273	Action-Adventure, Science Fiction, Spy/Espionage
274	Buddy, Comedy
275	Family, Variety
276	Drama, Historical, Sports
277	Action-Adventure, Documentary
278	Drama, Sports
279	Anthology, Comedy, Kids
280	Drama, Fantasy
281	Action-Adventure, Animals & Nature, Comedy
282	Kids
283	Animals & Nature, Animation, Family
284	Anthology, Comedy, Family
285	Animals & Nature, Coming of Age, Family
286	Family, Fantasy
287	Buddy, Family, Sports
288	Biographical, Drama, Historical
289	Animals & Nature, Biographical, Drama
290	Comedy, Crime, Family
291	Comedy, Family, Music
292	Animation, Buddy, Family
293	Fantasy, Kids, Mystery
294	Action-Adventure, Family, Survival
295	Action-Adventure, Western
296	Buddy, Coming of Age, Family
297	Comedy, Family, Western
298	Action-Adventure, Science Fiction, Thriller
299	Animation, Anthology, Kids
300	Action-Adventure, Family, Western
301	Crime, Drama, Family
302	Comedy, Crime, Science Fiction
303	Comedy, Music
304	Action-Adventure, Comedy
305	Animation, Drama, Fantasy
306	Comedy, Family, Romance
307	Action-Adventure, Drama, Family
308	Biographical, Family, Historical
309	Buddy, Comedy, Romance
310	Animation, Comedy, Drama
311	Action-Adventure, Family, Mystery
312	Coming of Age, Drama, Fantasy
313	Comedy, Crime, Fantasy
314	Action-Adventure, Coming of Age, Fantasy
315	Animals & Nature, Docuseries, Travel
316	Coming of Age, Musical, Science Fiction
317	Animation, Family, Mystery
\.


--
-- Data for Name: rating; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.rating (id, rating) FROM stdin;
1	TV-PG
2	G
3	PG-13
4	TV-Y
5	PG
6	TV-G
7	TV-14
8	TV-Y7
9	TV-Y7-FV
10	
\.


--
-- Data for Name: super_table; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.super_table (id, type_id, title, director, actors, countries_id, date_added_id, release_year, rating_id, duration, genres_id, description) FROM stdin;
1	1	A Spark Story	Jason Sterman, Leanne Dare	Apthon Corbin, Louis Gonzales	1	1	2021	1	88 min	1	Two Pixar filmmakers strive to bring their uniquely personal SparkShorts visions to the screen.
2	1	Spooky Buddies	Robert Vince	Tucker Albrizzi, Diedrich Bader, Ameko Eks Mass Carroll, Max Charles, Tim Conway, Jennifer Elise Cox	2	1	2011	2	93 min	2	The puppies go on a spooky adventure through a mysterious haunted mansion in this fur-raising flick.
3	1	The Fault in Our Stars	Josh Boone	Shailene Woodley, Ansel Elgort, Laura Dern, Sam Trammell, Nat Wolff, Willem Dafoe	3	1	2014	3	127 min	3	Hazel and Gus share a love that sweeps them on an unforgettable journey.
4	2	Dog: Impossible		Matt Beisner	3	2	2019	1	2 Seasons	4	Matt Beisner uses unique approaches to modifying canine behavior and focuses on each animal’s needs.
5	2	Spidey And His Amazing Friends		Benjamin Valic, Lily Sanfelippo, Jakari Fraser, Dee Bradley Baker, Melanie Minichino	3	2	2021	4	1 Season	5	Spidey teams up with pals to become The Spidey Team!
6	2	Star Wars: Visions			1	2	2021	1	1 Season	6	An animated anthology celebrating Star Wars through the lens of the world’s best anime creators.
7	1	Confessions of a Shopaholic	P.J. Hogan	Isla Fisher, Hugh Dancy, Joan Cusack, John Goodman, John Lithgow, Kristin Scott Thomas	3	3	2009	5	106 min	7	Becky writes a personal finance column en route to a high-fashion mag job.
8	1	Descendants: Royal Wedding	Salvador Simó	Dove Cameron, Sofia Carson, Booboo Stewart, Mitchell Hope, Sarah Jeffery, Melanie Paxson	1	3	2021	6	22 min	8	Mal and Ben’s wedding is finally here!
9	1	Disney's Broadway Hits at London's Royal Albert Hall	Jay Hatcher	John Barrowman, Ashley Brown, Merle Dandridge, Trevor Dion Nicholas, Jade Ewen, Alton Fitzgerald White	1	3	2016	6	116 min	9	Experience the magic of Disney on Broadway in an unforgettable night of music.
10	1	Flooded Tombs of the Nile	Katie Bauer Murdock	Devin E. Haqq	1	3	2021	1	44 min	1	Archaeologists dive into a pyramid flooded by the Nile to search for a king’s burial.
11	1	Jade Eyed Leopard		Jeremy Irons	1	3	2020	1	44 min	10	Jade Eyed Leopard follows a leopard, Toto, throughout the first three years of her life.
12	1	Nona	Louis Gonzales		1	3	2021	2	9 min	11	A grandmother's plan for a day alone is upended by an unexpected visit from her granddaughter.
13	1	Smoky Mountain Park Rangers		Peter Jessop	1	3	2021	1	42 min	1	Park Rangers protect the wildlife in Great Smoky Mountain National Park.
14	2	Life Below Zero		Chip Hailstone, Agnes Hailstone, Sue Aikens, Andy Bassich	3	4	2012	7	16 Seasons	12	Experience life deep in Alaska where the primal way lives on – brave the wild, fight the freeze.
15	2	Miraculous: Tales Of Ladybug & Cat Noir		Cristina Vee, Bryce Papenbrook, Keith Silverstein, Mela Lee, Max Mittelman, Carrie Keranen	4	4	2015	8	1 Season	13	Superheroes Ladybug and Cat Noir protect the city.
16	2	Ready for Preschool			1	4	2019	4	1 Season	14	The love of learning begins with Disney Junior!
17	2	Unknown Waters with Jeremy Wade		Jeremy Wade	1	4	2021	7	1 Season	15	Angler and adventurer, Jeremy Wade, explores the greatest river system in the world.
18	1	Far Away From Raven’s Home		Raven-Symoné, Issac Ryan Brown, Navia Robinson, Jason Maybaum, Sky Katz, Anneliese van der Pol	1	5	2021	6	11 min	16	Our gang is off for an exotic vacation of a lifetime!
19	1	Pirates of the Caribbean: On Stranger Tides	Rob Marshall	Johnny Depp, Penélope Cruz, Ian McShane, Geoffrey Rush, Kevin R. McNally, Sam Claflin	5	5	2011	3	140 min	17	A woman from his past uses Jack to help find the fabled Fountain of Youth.
20	1	Twenty Something	Aphton Corbin	Kaylin Price, Ariana Brown, Aliyah Taylor, Janelle LaSalle, Napoleon Highbrou	3	5	2021	5	11 min	18	Adulting is hard. One day you're nailing it, the next you're a stack of kids hiding in a trenchcoat.
21	2	Doogie Kamealoha, M.D.		Peyton Elizabeth Lee, Emma Meisel, Matthew Sato, Wes Tian, Jeffrey Bowyer-Chapman, Mapuana Makia	3	6	2021	1	1 Season	19	A 16-year-old prodigy juggles her budding medical career with the daily challenges of teenage life.
22	2	Mira, Royal Detective		Leela Ladnier, Utkarsh Ambudkar, Roshni Edwards, Kal Penn, Kamran Lucas	3	6	2020	4	2 Seasons	20	Mira is the new royal detective in the land of Jalpur!
23	2	Pepper Ann		Kathleen Wilhoite, Clea Lewis, Danny Cooksey, Pamela Segall, April Winchell, Don Adams	3	6	1997	4	3 Seasons	21	Pepper Ann Pearson is a teenage girl on an eternal quest for coolness.
24	2	The Incredible Dr. Pol		Rick Robles, Dr. Pol	3	6	2011	7	19 Seasons	4	Dr. Pol and his team handle challenging veterinary cases and animal emergencies in central Michigan.
25	1	Happier Than Ever: A Love Letter to Los Angeles	Robert Rodriguez, Patrick Osborne	Billie Eilish, FINNEAS	3	7	2021	7	66 min	22	Billie Eilish makes her Disney+ debut with "Happier Than Ever: A Love Letter to Los Angeles."
26	1	Tomorrowland	Brad Bird	George Clooney, Hugh Laurie, Britt Robertson, Raffey Cassidy, Tim McGraw, Kathryn Hahn	6	7	2015	5	131 min	23	A jaded genius and an optimistic teen unearth the secrets of Tomorrowland.
27	1	X-Men: Dark Phoenix	Simon Kinberg	James McAvoy, Michael Fassbender, Jennifer Lawrence, Nicholas Hoult, Sophie Turner, Tye Sheridan	2	7	2019	3	115 min	24	When Jean Grey transforms into the Dark Phoenix, the X-Men unite to face their greatest enemy yet.
28	2	Alaska Animal Rescue		Victoria Vosburg	3	8	2019	1	2 Seasons	4	Conservation heroes rescue and rehabilitate the wild animals of America’s last frontier.
29	2	Dug Days		Bob Peterson, Ed Asner, Jordan Nagai	3	8	2021	1	1 Season	11	“Dug Days” is a collection of shorts that follows the adventures of Dug, the dog from Pixar’s “Up.”
30	1	Cruella	Craig Gillespie	Emma Stone, Emma Thompson, Joel Fry, Paul Walter Hauser, Emily Beecham, Kirby Howell-Baptiste	5	9	2021	3	137 min	25	Witness the origin of Disney’s most notorious and notoriously fashionable villain, Cruella de Vil.
31	1	Dan in Real Life	Peter Hedges	Steve Carell, Juliette Binoche, Dane Cook, John Mahoney, Emily Blunt, Alison Pill	3	9	2007	3	99 min	26	A relationship expert falls in love with his brother's new girlfriend.
32	1	Disney Princess Remixed - An Ultimate Princess Celebration	Napoleon Dumo	Txunamy Oriz, Natalie Peyser, Dara Reneé, Frankie Rodriguez, Julia Lester, Ruth Righi	1	9	2021	6	22 min	27	Celebrate the timeless music of Disney Princess!
33	1	Marvel One-Shot: All Hail the King	Drew Pearce	Ben Kingsley, Scoot McNairy, Lester Speight, Sam Rockwell, Matt Gerald, Allen Maldonado	3	9	2014	7	14 min	28	Locked up in prison, infamous icon Trevor Slattery agrees to meet with a documentary filmmaker.
34	1	Underdog	Frederik Du Chau	Jason Lee, Amy Adams, Jim Belushi, Peter Dinklage, Patrick Warburton, Alex Neuberger	3	9	2007	5	85 min	29	A super-powered beagle tries to save Capital City from a mad scientist.
35	2	Dr. K's Exotic Animal ER		Dr. Susan Kelleher, Art Edmonds	1	10	2014	7	9 Seasons	4	Dedicated veterinarians treat a colorful array of exotic pets in south Florida.
36	2	Gigantosaurus		Dylan Schombing, Áine Sunderland, Nahanni Mitchell, Nicholas Holmes	7	10	2018	4	2 Seasons	5	Four dinos explore the mystery of the Gigantosaurus!
37	2	Life Below Zero: Next Generation		Mocean Melvin	3	10	2020	7	2 Seasons	12	The next generation of Alaskans struggle to survive without modern-day comforts.
38	1	Eragon	Stefen Fangmeier	Ed Speleers, Jeremy Irons, Sienna Guillory, Robert Carlyle, John Malkovich, Garrett Hedlund	8	11	2006	5	104 min	30	In a mythical time, a teenage boy becomes a dragon rider and embarks on a journey of adventure.
39	2	Dr. Oakley, Yukon Vet		Dr. Michelle Oakley, Zachary Fine	3	12	2013	1	9 Seasons	12	Meet Dr. Michelle Oakley, vet to pretty much everything that moves in the rugged Yukon.
40	2	Growing Up Animal		Tracee Ellis Ross	1	12	2021	1	1 Season	4	Magical stories of baby animals on the journey from womb to the wild.
41	1	Aquamarine	Elizabeth Allen Rosenbaum	Jake McDorman, Arielle Kebbel, Claudia Karvan, Bruce Spence, Tammin Sursok, Roy Billing	3	13	2006	5	104 min	31	Two 13-year-old best friends embark on an adventure when they discover a mermaid in a swimming pool.
42	1	Fantastic Four	Tim Story	Ioan Gruffudd, Jessica Alba, Chris Evans, Michael Chiklis, Julian McMahon, Kerry Washington	9	13	2005	3	106 min	24	Four astronauts develop superpowers and must join forces to protect mankind from doom.
43	1	X-Men	Bryan Singer	Patrick Stewart, Hugh Jackman, Ian McKellen, Halle Berry, Famke Janssen, James Marsden	3	13	2000	3	105 min	24	The X-Men, a small band of outcast mutants, fight to save a world that hates and fears them.
44	2	America's Funniest Home Videos: Animal Edition		Alfonso Ribeiro	1	14	2021	1	1 Season	32	NatGeo meets AMERICA’S FUNNIEST HOME VIDEOS in a hilarious new animal show
45	2	Chicken Squad		Ramone Hamilton, Gabriella Graves, Maxwell Simkins, Yvette Nicole Brown	3	14	2021	4	1 Season	33	BAGAWK! Say hello to the Chicken Squad.
46	2	Disney Presents Goofy in How to Stay at Home		Bill Farmer, Corey Burton	1	14	2021	6	1 Season	11	Goofy’s back in a trio of all-new, hand-drawn animated shorts from Walt Disney Animation Studios.
47	2	Gabby Duran And The Unsittables		Kylie Cantrall, Maxwell Donovan, Callan Farris, Coco Christo, Valery Ortiz, Nathan Lovejoy	3	14	2018	6	2 Seasons	34	Meet Gabby Duran, your average alien-babysitting girl.
48	2	What If...?			1	14	2021	7	1 Season	35	“What If…?” flips the script on the MCU by reimagining events from the films in unexpected ways.
49	1	Beverly Hills Chihuahua 2	Alex Zamm	George Lopez, Odette Yustman, Miguel Ferrer, Ernie Hudson, Loretta Devine, Jon Huertas	3	15	2011	2	88 min	36	Papi and Chloe, those talking Chihuahuas, are back... with a few surprises.
50	1	Beverly Hills Chihuahua 3: Viva La Fiesta!	Lev L. Spiro	George Lopez, Odette Annable, Ernie Hudson, Miguel Ferrer, Kay Panabaker, Tom Kenny	3	15	2012	2	92 min	19	Papi plans a "Quince" for the littlest member of his pack.
51	1	Killer Shark vs Killer Whale		Edward Marcoux	1	15	2021	7	44 min	10	Orcas attack white sharks for their livers leaving scientists baffled.
52	1	Mrs. Doubtfire	Chris Columbus	Robin Williams, Sally Field, Pierce Brosnan, Harvey Fierstein, Polly Holliday, Lisa Jakub	3	15	1993	3	126 min	37	An eccentric dad dresses as a British nanny so he can care for his kids at the home of their mother.
53	2	Cesar Millan: Better Human Better Dog		Dustin Rubin	1	16	2021	7	1 Season	4	Renowned Dog Behaviorist Cesar Millan transforms dogs and pet parents.
54	2	Disney Fancy Nancy		Mia Jenness, Alyson Hannigan, Rob Riggle, Spencer Moss, Dana Heath	2	16	2018	1	2 Seasons	38	Nancy makes every day extraordinary!
55	2	Walt Disney Animation Studios: Short Circuit Experimental Films			1	16	2020	5	2 Seasons	39	Welcome to Short Circuit - an experimental short film program at Disney Animation.
56	1	Built for Mars: The Perseverance Rover	Mark J Davis	Steven French	1	17	2021	1	88 min	1	BUILT FOR MARS: THE PERSEVERANCE ROVER follows the birth of the Perseverance rover.
57	1	Garfield	Peter Hewitt	Breckin Meyer, Jennifer Love Hewitt, Stephen Tobolowsky, Bill Murray, Evan Arnold, Mark Lawrence	3	17	2004	5	82 min	40	Garfield lures Odie out of the house but once he's lost, Garfield springs into action to save him.
58	2	Chip 'n' Dale: Park Life		Matthew Géczy, Kaycie Chase, Bill Farmer, Sylvain Caruso	1	18	2021	8	1 Season	41	Two tiny chipmunks have huge adventures while trying to live the good life in a big city park.
59	2	Critter Fixers: Country Vets		Sullivan Jones	3	18	2020	7	2 Seasons	4	Dr. Hodges and Dr. Ferguson own and operate a bustling veterinary clinic.
60	2	Disney Junior T.O.T.S.		Vanessa Williams, Megan Hilty, Jet Jurgensmeyer, Christian Simon	3	18	2018	4	2 Seasons	42	Pip and Freddy are new Junior Fliers at T.O.T.S.!
61	2	Mickey Mouse Funhouse		Bret Iwan, Kaitlyn Robrock, Bill Farmer, Tony Anselmo, Tress MacNeille, Harvey Guillén	1	18	2021	4	1 Season	38	Mickey Mouse Funhouse is filled with silly adventure!
62	2	Minnie's Bow-Toons: Party Palace Pals		Tress MacNeille, Nika Futterman, Kaitlyn Robrock	1	18	2021	8	1 Season	38	Minnie and Daisy open a party planning business!
63	2	Turning the Tables with Robin Roberts		Robin Roberts	1	18	2021	1	1 Season	43	Robin Roberts sits down with iconic Hollywood women for intimate & inspirational conversations.
64	1	Ice Age: The Meltdown	Carlos Saldanha	Ray Romano, John Leguizamo, Denis Leary, Seann William Scott, Josh Peck, Queen Latifah	10	19	2006	5	94 min	11	Manny, Sid, Diego and Scrat join forces with new friends to save the valley from an epic flood.
65	1	Playing with Sharks		Valerie Taylor, Dr. Sylvia Earle, Jeremiah Sullivan, Wendy Benchley, Jean Michel Cousteau, Michele Hall	1	19	2021	7	91 min	44	"Playing with Sharks" captures the life of conservationist Valerie Taylor.
66	1	Shark vs. Surfer	Phil Stebbing	Billy Lloyd	1	19	2020	7	44 min	10	Shark vs. Surfer visits shark-infested surf spots to relive the harrowing encounters.
67	1	Shark vs. Whale		Ted Stewart	1	19	2020	1	44 min	10	Marine biologist Ryan Johnson discovers rare behavior of a whale attacking a great white.
68	1	Stuntman	Kurt Mattila	Eddie Braun	1	19	2021	7	87 min	1	Stuntman Eddie Braun attempts to complete Evel Knievel's legendary Snake River Canyon rocket jump.
69	1	Walking with Dinosaurs: The Movie	Barry Cook, Neil Nightingale	John Leguizamo, Justin Long, Tiya Sircar, Skyler Stone, Angourie Rice, Charlie Rowe	1	19	2013	5	88 min	30	A young dinosaur named Patchi must find his courage to lead the herd.
70	1	What the Shark?		Robert Davi	1	19	2020	1	44 min	10	What the Shark? dives deep into the environments where adaptation is critical to survival.
71	2	Behind the Attraction		Paget Brewster	1	20	2021	1	1 Season	45	Behind the Attraction takes you on a wild ride behind Disney Parks' most iconic attractions!
72	2	Disney The Owl House		Sarah-Nicole Robles, Wendie Malick, Alex Hirsch, Tati Gabrielle, Issac Brown, Mae Whitman	3	20	2020	8	2 Seasons	6	Luz stumbles upon a portal to a magical new world.
73	2	Meet Spidey and His Amazing Friends (Shorts)		Ben Valic, Melanie Minichino	1	20	2021	4	1 Season	5	Meet the friends that help Spidey save the day!
74	2	Mission Force One		Justin Felbinger, Fiona Bishop, Ivy Bishop, Issac Ryan Brown, Sam Lavagnino, Dee Bradley Baker	3	20	2017	4	1 Season	5	Five kids form an elite team to protect the universe!
75	2	Turner & Hooch		Josh Peck, Carra Patterson, Lyndsy Fonseca, Vanessa Lengies, Brandon Jay Mclaren, Anthony Ruivivar	1	20	2021	1	1 Season	46	A Deputy Marshal inherits an unruly dog who helps him solve crimes and investigate a family mystery.
76	1	Most Wanted Sharks			1	21	2020	1	44 min	10	In Most Wanted Sharks, Jeremiah Sullivan dives into the stories of shark all-stars.
77	1	Secrets of the Bull Shark		Keston John	1	21	2020	7	44 min	10	Secrets of the Bull Shark unravels the mystery of some of the most dangerous predators.
78	2	Shark Attack Files			1	21	2021	7	1 Season	32	Learn the truth behind the most dramatic shark attacks of our time.
79	1	Shark Attack Investigation: The Paige Winter Story			1	21	2021	7	44 min	10	A teen survives facing one of the ocean’s deadliest predators.
80	1	Sharkcano	Andy Seestedt	Dan Nachtrab	1	21	2020	1	44 min	10	Dr. Michael Heithaus sets out to reveal the connection between sharks and volcanoes.
81	1	We Bought a Zoo	Cameron Crowe	Matt Damon, Scarlett Johansson, Thomas Haden Church, Patrick Fugit, Colin Ford, Elle Fanning	3	21	2011	5	125 min	47	A single dad tries to give his family a fresh start by moving to a home in the middle of a zoo.
82	1	World's Biggest Bullshark		Jason Hildebrandt	1	21	2021	1	44 min	10	How one of the largest Bull Sharks ever caught, grew to become a giant.
83	1	World's Most Dangerous Shark?	Kevin Bachar	Brain Cade	1	21	2021	7	44 min	10	Are Oceanic White Tips the most dangerous of all the sharks?
84	2	So Random!		Tiffany Thornton, Sterling Knight, Brandon Mychal Smith, Doug Brochu, Allisyn Ashley Arm	3	22	2011	6	1 Season	48	A musical sketch comedy show.
85	1	Flicka	Michael Mayer	Alison Lohman, Tim McGraw, Maria Bello, Ryan Kwanten, Danny Pino, Dallas Roberts	5	23	2006	5	95 min	49	A 14-year-old girl befriends a wild filly and tries to rescue the horse from a rodeo entrepreneur.
86	1	Miraculous World: Shanghai, The Legend of Ladydragon	Thomas Astruc	Cristina 'Vee" Valenzuela, Bryce Papenbrook, Keith Silverstein, Carrie Keranen, Todd Haberkorn, Max Mittelman	1	23	2021	9	54 min	50	Marinette heads to Shanghai to meet Adrien.
87	1	Orca vs. Great White	Sigmund Spath Jr.	Kina Scollay, Ingrid Visser, Ray Robertson	1	23	2021	7	44 min	10	Researchers investigate if orcas are hunting great whites in New Zealand.
88	1	Rogue Shark?	Mark Woodward	Mocean Melvin	1	23	2021	7	44 min	10	A vacation hot spot is rocked by a series of shark attacks, chaos reigns.
89	1	Shark Beach with Chris Hemsworth	Sally Aitken	Chris Hemsworth	3	23	2021	1	44 min	10	Chris Hemsworth investigates how we can live harmoniously with sharks.
90	1	Shark Gangs	Jacob Cobi Benattia, Pete Berg, James Buchanan		1	23	2021	7	44 min	10	Scientists investigate why some sharks roam the oceans in gangs.
91	1	The Croc That Ate Jaws	Mark Woodward	Dan Nachtrab	1	23	2021	7	44 min	10	What happens when two of the deadliest predators go head to head?
92	2	When Sharks Attack		Eric Meyers	3	23	2013	7	7 Seasons	32	National Geographic investigates shark attacks.
93	2	Breaking Bobby Bones		Bobby Bones	3	24	2021	7	1 Season	51	Bobby Bones travels to meet local heroes who challenge him to conquer their trades.
94	2	Mickey Mouse Mixed-Up Adventures		Bret Iwan, Russi Taylor, Bill Farmer, Daniel Ross, Tress MacNeile	3	24	2019	4	1 Season	52	Hot Dog! Get mixed-up with Mickey and all of his pals!
95	2	Monsters at Work		Billy Crystal, John Goodman, Ben Feldman, Mindy Kaling, Henry Winkler, Lucas Neff	3	24	2021	6	1 Season	11	"Monsters at Work" tells the story of Tylor Tuskmon and his dream to become a Jokester.
96	1	The Good, The Bart, and The Loki	David Silverman	Dan Castellaneta, Nancy Cartwright, Yeardley Smith	1	24	2021	1	6 min	53	Banished from Asgard once again, Loki takes on the Simpsons and Springfield’s mightiest heroes.
97	2	Disney Raven's Home		Raven-Symoné , Issac Brown, Navia Robinson, Jason Maybaum, Sky Katz, Anneliese van der Pol	3	25	2016	6	4 Seasons	54	Raven and Chelsea raise their three children together.
98	1	The Sandlot	David Mickey Evans	Art La Fleur, Tom Guiry, Mike Vitar, Patrick Renna, Chauncey Leopardi, Marty York	3	25	1993	5	101 min	19	A shy boy moves to a new neighborhood and becomes involved with a ragtag baseball team.
99	1	The Sandlot 2	David Mickey Evans	Max Lloyd-Jones, James Willson, Samantha Burton, Brett Kelly, James Earl Jones, Cole Evan Weiss	3	25	2005	5	98 min	55	10 years after the events at The Sandlot, a team of boys and girls overcome an all-new challenge.
100	1	Adventures in Babysitting	Chris Columbus	Elisabeth Shue, Maia Brewton, Keith Coogan, Anthony Rapp, Calvin Levels, Vincent Phillip D'Onofrio	3	26	1987	1	102 min	56	A seemingly quiet night turns into a wild expedition for a teen babysitter.
101	2	PJ Masks		Kyle Breitkopf, Jacob Ursomarzo, Addison Holley	11	26	2015	8	4 Seasons	5	Look out Night Time Baddies the PJ Masks are coming!
102	2	Running Wild with Bear Grylls		Bear Grylls	3	26	2019	1	2 Seasons	57	Survivalist Bear Grylls takes celebrities on wild adventures they won’t forget.
103	2	The Mysterious Benedict Society		Tony Hale, Kristen Schaal, Mystic Inscho, Seth Carr, Marta Kessler, Emmy DeOliveira	3	26	2021	1	1 Season	58	Four gifted orphans are recruited by the eccentric Mr. Benedict to save the world.
104	1	Wolfgang	David Gelb	Wolfgang Puck	1	26	2021	1	80 min	59	Wolfgang Puck persevered after a troubled childhood to become the world’s most famous chef.
105	2	Dino Ranch		Tyler Nathan, Jacob Mazeral, Ava Ro, Scott Gorman, Athena Karkanis	12	27	2021	4	1 Season	60	Join the Cassidy family on their "prewestoric" farm!
106	2	Disney Just Roll With It		Ramon Reed, Kaylin Hayman, Suzi Barrett, Tobie Windham	3	27	2018	8	2 Seasons	40	This family's fate rests in the hands of the audience!
107	2	Heartland Docs, DVM		Dr. Erin Schroeder, Dr. Ben Schroeder	3	27	2019	7	3 Seasons	4	Heartland vets Ben and Erin Schroeder live and work among farmers in the Midwest.
108	1	Luca	Enrico Casarosa	Jacob Tremblay, Jack Dylan Grazer, Emma Berman, Maya Rudolph, Marco Barricelli, Jim Gaffigan	3	27	2021	5	101 min	61	Join Luca, a young sea monster, as he experiences an unforgettable summer on the Italian Riviera.
109	2	Star Wars Vintage: Droids		Anthony Daniels, R2-D2, Lesleh Donaldson, Andrew Sabiston, Don Francks, Dan Hennessey	1	27	1985	9	2 Seasons	13	Share the early adventures of R2-D2 and C-3PO in this action-packed animated series!
110	2	Puppy Dog Pals		Harland Williams, Isaac Brown, Jessica DiCicco, Sam Lavagnino, Leslie Baker, Tara Strong	13	28	2016	6	4 Seasons	38	Two puppies are on a mission for fun and adventure!
111	1	Strange Magic	Gary Rydstrom	Alan Cumming, Evan Rachel Wood, Elijah Kelley, Meredith Anne Bull, Sam Palladio, Kristin Chenoweth	14	28	2015	5	101 min	62	A tough fairy princess crosses paths with the sinister Bog King.
112	1	The Happiest Millionaire	Norman Tokar	Fred MacMurray, Tommy Steele, Greer Garson, Geraldine Page, Gladys Cooper, Hermione Baddeley	3	28	1967	2	170 min	63	An immigrant finds a butler position in the home of a millionaire.
113	1	The Pacifier	Adam Shankman	Vin Diesel, Lauren Graham, Faith Ford, Brittany Snow, Max Thieriot, Chris Potter	15	28	2005	5	97 min	64	A Navy SEAL gets his toughest mission yet: Babysitting.
114	2	Zenimation			3	28	2020	6	2 Seasons	39	Unplug, relax and refresh your senses with the soundscapes of Disney Animation’s Zenimation.
115	2	Loki		Tom Hiddleston	1	29	2021	7	1 Season	65	The mercurial villain Loki (Tom Hiddleston) resumes his role as the God of Mischief.
116	2	Disney Amphibia		Justin Felbinger, Amanda Leighton, Bill Farmer, Brenda Song	16	30	2018	8	2 Seasons	11	Anne Boonchuy is transported to the world of Amphibia.
117	2	Gordon Ramsay: Uncharted		Gordon Ramsay	3	30	2018	7	3 Seasons	66	Gordon Ramsay travels the globe on an epic adventure in search of culinary inspiration.
118	1	Ice Age: Dawn Of The Dinosaurs	Carlos Saldanha	Ray Romano, John Leguizamo, Denis Leary, Simon Pegg, Seann William Scott, Josh Peck	10	30	2009	5	97 min	11	Our prehistoric pals visit a world inhabited by dinosaurs and a one-eyed weasel named Buck.
119	2	MUPPET BABIES		Matt Danner, Melanie Harrison, Ben Diskin, Eric Bauza, Dee Baker, Jessica DiCicco	17	30	2017	4	3 Seasons	38	The Muppet Babies are here to make dreams come true!
120	1	Raya and the Last Dragon	Don Hall, Carlos López Estrada	Kelly Marie Tran, Awkwafina , Izaac Wang, Gemma Chan, Daniel Dae Kim, Benedict Wong	3	30	2021	5	112 min	62	When evil threatens Kumandra, Raya must find the last dragon to save it.
121	1	Red Tails	Anthony Hemingway	Terrence Howard, Cuba Gooding Jr., Nate Parker, David Oyelowo, Tristan Wilds, Ne-Yo	3	30	2012	3	126 min	67	Black fighter pilots get the chance to prove themselves during WWII.
122	1	Us Again	Zach A. Parrish		1	30	2021	2	7 min	68	An elderly man and his young-at-heart wife rekindle their passion for life on one magical night.
123	1	X-Men Origins: Wolverine	Gavin Hood	Hugh Jackman, Liev Schreiber, Danny Huston, will.i.am , Lynn Collins, Kevin Durand	5	30	2009	3	108 min	24	Wolverine unites with legendary X-Men to fight against forces determined to eliminate mutants.
124	1	American Eid	Aqsa Altaf	Shanessa Khawaja, Jenna Qureshi, Cash Herrera, Fazeelat Aslam, Maya Bednarek, Iris Starlett Perry	1	31	2021	2	21 min	69	Ameena, a homesick Muslim Pakistani immigrant, wakes up on Eid to find out she has to go to school.
125	2	Bluey		Dave Mccormack, Melanie Zanetti, Brad Elliot, Hsiao-Ling Tang	18	31	2019	4	2 Seasons	38	Bluey is a six year-old Blue Heeler dog, who turns everyday family life into adventures.
126	1	Dinner Is Served	Hao Zheng	Qi Sun, Briana Liu, Ben Wang, Harry Jarvis, Ray Wise, DeJean Brown	1	31	2021	1	21 min	70	A Chinese student uncovers his true identity when trying out for a leadership role at a U.S. school.
127	2	Disney Sydney To The Max		Ruth Righi, Ava Kolker, Jackson Dollinger, Christian Simon, Ian Kesler, Caroline Rhea	3	31	2018	6	3 Seasons	19	Sydney navigates middle school with help from her Dad.
128	1	Growing Fangs	Ann Marie Pace	Keyla Monterroso Mejia, Cristela Alonzo, Grace Song, Olivia Sullivent, Gilberto Ortiz, Sean Burgos	1	31	2021	1	20 min	71	Val Garcia, a Mexican-American half human/half vampire teenager, struggles to fit in either world.
129	2	Kingdom of the Polar Bears		Dennis Compayre	1	31	2021	1	1 Season	15	Follow a mother polar bear as she raises two cubs on the Hudson Bay’s receding ice.
130	1	Let's Be Tigers	Stephanie Abel Horowitz	Otmara Marrero, Dash McCloud, Greg Worswick, Mike Millan	1	31	2021	5	15 min	69	Grieving for her mother, Avalon finds comfort when she's put in charge of a 4-year-old for a night.
131	1	The Last of the Chupacabras	Jessica Mendez Siqeiros	Melba Martinez ph.D, Cici Lau, Seven True-Divine Purnell, William Knight, Amanda Maddock, Ronald Binion	1	31	2021	1	14 min	72	A lonely Mexican-American woman unknowingly summons a dark and ancient creature.
132	1	The Little Prince(ss)	Moxie Peng	Kalo Moss, Ching Yin Ryan Hu, Evan Lai, Brian Yang, Lynn Chen, Danni Wang	1	31	2021	5	19 min	69	When Chinese kids Gabriel and Rob become friends, Rob's dad questions Gabriel's feminine behavior.
133	2	Wicked Tuna		Mike Rowe	3	31	2016	7	10 Seasons	12	Massachusetts fishermen make their living one catch at a time in pursuit of the bluefin tuna.
134	2	Big City Greens		Chris Houghton, Marieve Herington, Bob Joles, Artemis Pebdani	16	32	2017	8	2 Seasons	73	The Green family moves from the country to Big City.
135	2	Fury Files		Chi McBride	1	32	2013	8	1 Season	74	Get top-secret access to S.H.I.E.L.D. video dossiers on key Marvel heroes and villains.
136	2	Ice Road Rescue		David Wartnaby, Bjørn Lægreid, Thord Paulsen	19	32	2015	7	5 Seasons	75	Ice Road Rescue follows Norwegian towing teams who rescue trucks and trailers on icy mountain roads.
137	1	Tinker Bell and the Legend of the NeverBeast	Steve Loter	Ginnifer Goodwin, Mae Whitman, Rosario Dawson, Lucy Liu, Raven-Symoné , Megan Hilty	3	32	2014	2	79 min	13	Tink and her friends risk everything to rescue the mysterious NeverBeast.
138	2	Schoolhouse Rock!		Bob Dorough, Jack Sheldon, Lynn Ahrens, Grady Tate, Blossom Dearie, Essra Mohawk	3	33	1973	6	6 Seasons	76	Musical shorts teach kids history, grammar, and math.
139	2	Disney Special Agent Oso: Three Healthy Steps (Shorts)		Sean Astin, Meghan Strange, Phill Lewis, Amber Hood, Brad Garrett	1	34	2011	4	1 Season	5	Oso and his friends watch a kid as they demonstrate the steps to performing a healthy activity.
140	2	Race to the Center of the Earth		Chris Payne Gilbert	3	34	2021	7	1 Season	77	Race to the Center of the Earth. Four epic courses. One finish line.
141	2	Special Agent Oso		Sean Astin, Meghan Strange, Gary Anthony Williams, Amber Hood, Cam Clarke, Phill Lewis	20	34	2009	4	2 Seasons	5	Special Agent Oso is an adorable stuffed bear and an agent-in-training!
142	1	X-Men: The Last Stand	Brett Ratner	Hugh Jackman, Halle Berry, Ian McKellen, Famke Janssen, Anna Paquin, Kelsey Grammer	21	34	2006	3	105 min	24	When Professor X clashes with Magneto, the battle lines are drawn for the war to end all wars.
143	2	The Incredible Hulk		Neal McDonough, John Vernon, Luke Perry, Lou Ferrigno, Genie Francis	3	35	1996	8	2 Seasons	5	Scientist Bruce Banner develops a dangerous alter ego – a monster known as the Incredible Hulk.
144	1	Fantastic Four: Rise of the Silver Surfer	Tim Story	Ioan Gruffudd, Jessica Alba, Chris Evans, Michael Chiklis, Julian McMahon, Kerry Washington	22	36	2007	5	93 min	24	The Fantastic Four meet The Silver Surfer, who comes to Earth to prepare it for destruction.
145	2	Wander Over Yonder		Jack McBrayer, April Winchell, Keith Ferguson, Tom Kenny	23	36	2013	8	2 Seasons	16	Best friends travel through the cosmos.
146	1	Wild Hearts Can't Be Broken	Steve Miner	Gabrielle Anwar, Michael Schoeffling, Kathleen York, Dylan Kussman, Cliff Robertson, Frank Renzulli	3	36	1991	2	89 min	78	A runaway is determined to become a death-defying horse "diving girl."
147	1	Maggie Simpson in "The Force Awakens from its Nap"	David Silverman		1	37	2021	1	4 min	53	In a daycare far, far away… but still in Springfield, Maggie goes on a quest for her lost pacifier.
148	1	Star Wars Biomes			1	37	2021	6	18 min	79	Fly over the surface of some of the most iconic Star Wars biomes, planets, and moons.
149	2	Star Wars Vehicle Flythroughs			1	37	2021	6	1 Season	80	Fly through some of the most iconic Star Wars ships and vehicles.
150	2	The Bad Batch		Dee Bradley Baker	1	37	2021	1	1 Season	81	The Bad Batch must find their way in a rapidly changing galaxy.
151	2	Spider-Man		Christopher Daniel Barnes, Edward Asner, Linda Gray, Rodney Saulsberry, Liz Georges, Saratoga Ballantine	3	38	1994	8	5 Seasons	5	A young man with spider-like abilities fights crime while trying to have a normal personal life.
152	1	22 vs. Earth	Kevin Nolting	Tina Fey, Richard Ayoade, Alice Braga	1	39	2021	1	9 min	11	22 refuses to go to Earth, enlisting a gang of 5 other new souls in her attempt at rebellion.
153	2	Adventures in Wonderland		Patrick Richwood, Reece Holland, John Robert Hoffman, Wesley Mann, Harry Waters Jr., John Lovelady	1	39	1996	6	1 Season	82	This Emmy award-winning series mixes music and fantasy with language and social skills.
154	1	Disney My Music Story SUKIMASWITCH	Kentaro Takayanagi	Takuya Ohashi, Shintaro Tokita	1	39	2020	1	81 min	83	This episode features SUKIMASWITCH. They share their thoughts on music.
155	2	DuckTales		David Tennant, Danny Pudi, Ben Schwartz, Bobby Moynihan, Kate Micucci, Tony Anselmo	3	39	2017	8	3 Seasons	73	Join Scrooge and family on globe-trotting adventures!
156	1	Oklahoma!	Fred Zinnemann	Gordon MacRae, Gloria Grahame, Gene Nelson	3	39	1956	1	148 min	84	Two young cowboys vie with a ranch hand and peddler for the hearts of the women they love.
157	1	Baby's Day Out	Patrick Read Johnson	Joe Mantegna, Lara Flynn Boyle, Joe Pantoliano, Brian Haley, Cynthia Nixon, Fred Dalton Thompson	3	40	1994	5	99 min	85	Three bumbling kidnappers attempt to nab the baby of a rich couple.
158	1	Being the Queen	Tom Jennings		3	40	2020	7	44 min	59	Being the Queen tells the story of Queen Elizabeth II from those who know her best.
159	2	Liv and Maddie		Dove Cameron, Joey Bragg, Tenzing Norgay Trainor, Kali Rocha, Benjamin King	3	40	2013	6	4 Seasons	86	The series follows 15-year-old twins Liv and Maddie.
160	2	Secrets of the Whales		Sigourney Weaver, James Cameron, Brian Skerry	1	41	2021	1	1 Season	15	Secrets of the Whales reveals the mysterious and beautiful world of whales.
161	2	Big Shot		John Stamos, Jessalyn Gilsig, Yvette Nicole Brown, Richard Robichaux, Sophia Mitri Schloss, Nell Verlaque	1	42	2021	1	1 Season	87	After being ousted from NCAA, a men’s basketball coach takes a job at an elite private high school.
162	2	Earth Moods			1	42	2021	6	1 Season	88	Relax and reset as you journey around the world with Earth Moods.
163	2	Primal Survivor		Hazen Audel	3	42	2014	1	5 Seasons	75	Hazen Audel relives his most thrilling moments and reveals what it takes to become Primal Survivor.
164	1	Rio	Carlos Saldanha	Anne Hathaway, Jesse Eisenberg, will.i.am , Jamie Foxx, George Lopez, Tracy Morgan	24	42	2011	2	99 min	73	Blu, a rare macaw leaves his home in small town Minnesota and heads to Rio to help save his species.
165	1	The Kid Who Would Be King	Joe Cornish	Louis Ashbourne Serkis, Tom Taylor, Rebecca Ferguson, Patrick Stewart, Denise Gough, Dean Chaumoo	25	42	2019	5	121 min	89	When a kid discovers the legendary sword, Excalibur, he and his friends join Merlin to fight evil!
166	1	Treasure Buddies	Robert Vince	Richard Riehle, Mason Cook, Adam Alexi-Malle, Lochlyn Munro, Mo Gallini, Christopher Maleki	2	42	2012	2	96 min	90	Travel across the globe on a treasure hunt with the adorable thrill-seeking Buddies.
167	1	White Fang 2: Myth of the White Wolf	Ken Olin	Scott Bairstow, Charmaine Craig, Alfred Molina, Geoffrey Lewis, Al Harrington, Anthony Michael Ruivivar	3	42	1994	5	106 min	91	A dog-wolf stops miners from destroying a sacred land.
168	1	Cesar Millan: The Real Story	Doug Shultz	Cesar Millan	3	43	2012	1	45 min	59	Follow Cesar Millan's incredible rise from impoverished illegal immigrant to celebrity dog trainer.
169	2	Future-Worm!		Andy Milonakis, James Adomian, Corey Burton, Melanie Lynskey, Ryan Quincy, Neil deGrasse Tyson	3	43	2016	8	1 Season	92	One boy, one worm... these are their adventures!
170	2	Kick Buttowski: Suburban Daredevil		Charlie Schlatter, Matt Jones, Danny Cooksey	3	43	2010	8	2 Seasons	93	Kick Buttowski is an extraordinary kid determined to become the worlds greatest daredevil.
171	1	Man of the House	James Orr	Chevy Chase, Farrah Fawcett, Jonathan Taylor Thomas, George Wendt	3	43	1995	5	97 min	94	A man joins the YMCA to impress the son of the woman of his dreams.
172	1	Mark Twain and Me	Daniel Petrie	Jason Robards, Talia Shire, R.H. Thomson, Fiona Reid, Chris Wiggins, Amy Stewart	15	43	1991	1	93 min	95	A shy 11 -year- old is thrilled to meet Mark Twain, the man she most admires in all the world.
173	1	Squanto: A Warrior's Tale	Xavier Koller	Adam Beach, Eric Schweig, Michael Gambon, Nathaniel Parker, Alex Norton, Sheldon Peters Wolfchild	2	43	1994	5	102 min	96	A vivid true story of one man's unquenchable thirst for independence.
174	1	Caravan of Courage: An Ewok Adventure	John Korty	Eric Walker, Warwick Davis, Fionnula Flanagan, Guy Boyd, Aubree Miller, Daniel Frishman	1	44	1984	1	97 min	65	After Cindel and Mace are separated from their parents, courageous Ewoks aid in reuniting them.
175	1	Ewoks: The Battle for Endor	Jim Wheat, Ken Wheat	Wilford Brimley, Warwick Davis, Aubree Miller, Siân Phillips, Carel Struycken, Niki Botelho	3	44	1985	1	97 min	65	The adventures of the Ewoks continue as Wicket and friends confront the evil Marauders.
176	2	Higglytown Heroes		Frankie Ryan Manriquez, Taylor Masamitsu, Liliana Mumy, Rory Thost, Edie McClurg	16	44	2004	4	2 Seasons	97	You're invited to meet the heroes all around you, since everyone's a hero in their own way!
177	1	Island at the Top of the World	Robert Stevenson	David Hartman, Donald Sinden, Jacques Marin, Mako , David Gwillim, Agneta Eckemyr	3	44	1974	2	94 min	98	A man commissions an airship and crew to search for his missing son.
178	2	Made in a Day		Craig Whitney	3	44	2020	1	1 Season	32	This is the story of how today’s biggest brands are made today.
179	1	Night at the Museum	Shawn Levy	Ben Stiller, Carla Gugino, Dick Van Dyke, Mickey Rooney, Bill Cobbs, Jake Cherry	5	44	2006	5	109 min	36	A new guard at the Natural History Museum finds that when visitors leave the exhibits come to life.
180	1	Night at the Museum: Battle of the Smithsonian	Shawn Levy	Ben Stiller, Amy Adams, Owen Wilson, Hank Azaria, Christopher Guest, Alain Chabat	2	44	2009	5	106 min	36	Larry Daley returns to rescue some old friends while the Smithsonian Institution comes alive.
181	2	Secrets Of The Zoo		Mocean Melvin	1	44	2017	1	4 Seasons	4	Go behind the scenes at The Columbus Zoo and Aquarium.
182	1	Sharks Of The Bermuda Triangle		Mike New	1	44	2020	1	45 min	10	The Bermuda Triangle’s greatest wonder may be the secret breeding grounds of tiger sharks.
183	2	Star Wars Vintage: Clone Wars 2D Micro-Series		Mat Lucas, James Arnold Taylor, Tom Kane, Grey DeLisle, Corey Burton, André Sogliuzzo	1	44	2021	9	1 Season	99	Enjoy this thrilling, Emmy® Award-winning animated series that continues the Star Wars story.
184	1	Star Wars Vintage: Story of the Faithful Wookiee			1	44	2021	9	9 min	74	With his friends ailing from a sleeping virus, Chewbacca gets “help” from Boba Fett.
185	2	Star Wars: Ewoks		Jim Henshaw, Cree Summer Francks, Jackie Burroughs, George Buza, Doug Chamberlain, Paul Chato	1	44	1985	9	2 Seasons	13	Join your favorite, furry Star Wars heroes, the Ewoks, in an action-packed, animated series!
186	1	The Big Year	David Frankel	Steve Martin, Jack Black, Owen Wilson, Brian Dennehy, Anjelica Huston, Rashida Jones	2	44	2011	5	101 min	100	Three men pursue the Birder of the Year title across the continent.
187	1	The Last Ice	Scott Ressler		3	44	2020	7	82 min	10	As climate change melts the Arctic ice, the indigenous people fight to protect the land.
188	1	Third Man on the Mountain	Ken Annakin	Michael Rennie, James MacArthur, Janet Munro, James Donald, Herbert Lom, Laurence Naismith	5	44	1959	2	107 min	89	A boy attempts the impossible - climbing the "Citadel."
189	2	Walk the Prank		Cody Veith, Bryce Gheisar, Brandon Severs, Jillian Shea Spaeder, Tobie Windham	3	44	2016	8	3 Seasons	101	Chance and his crew prank unsuspecting targets.
190	1	Gnomeo & Juliet	Kelly Asbury	James McAvoy, Emily Blunt, Matt Lucas, Ashley Jensen, Michael Caine, Jim Cummings	26	45	2011	2	86 min	62	Two garden gnomes remain star-crossed lovers during a feud among neighbors.
191	2	Pickle and Peanut		Johnny Pemberton, Jon Heder, Dana Snyder, Joel Trussell	3	45	2015	8	2 Seasons	16	The freewheeling adventures of Pickle and Peanut.
192	2	The Mighty Ducks: Game Changers			1	45	2021	1	1 Season	87	A new group of misfits rediscovers the joys of playing hockey for the love of the game.
193	2	Disney Big Hero 6 The Series		Scott Adsit, Ryan Potter, Brooks Wheelan, Jamie Chung, Khary Payton, Genesis Rodriguez	3	46	2017	6	3 Seasons	5	Hiro, Baymax and team protect the city from villains.
194	1	Disney My Music Story: Perfume	Kentaro Takayanagi	a-chan , KASHIYUKA , NOCCHi	1	46	2019	10	53 min	83	J-Pop band Perfume shares their passion for music and Disney memories.
195	2	Mexico Untamed		Juan Monsalvez	1	46	2018	1	1 Season	15	Predator and prey fight age-old battles for survival in Mexico Untamed
196	2	The Falcon and The Winter Soldier		Anthony Mackie, Sebastian Stan, Daniel Brühl, Emily VanCamp, Wyatt Russell	1	46	2021	7	1 Season	102	Sam Wilson aka The Falcon and Bucky Barnes aka The Winter Soldier team up on a global adventure.
197	1	Doc McStuffins: The Doc Is In	Chris Hamilton	Laya DeLeon Hayes, Loretta Devine, Lara Jill Miller, Robbie Rist, Anthony Anderson, Dr Myiesha Taylor,  MD	1	47	2020	4	24 min	103	Doc McStuffins helps kids learn about healthy habits.
198	2	Marvel Studios ASSEMBLED			1	47	2021	10	1 Season	104	ASSEMBLED is an immersive series of docu-specials examining the next phase of the MCU.
199	1	Miss Peregrine's Home for Peculiar Children	Tim Burton	Eva Green, Asa Butterfield, Samuel L. Jackson, Judi Dench, Rupert Everett, Allison Janney	27	47	2016	3	127 min	71	A wildly imaginative fantasy-adventure about a secret world for children with unusual powers.
200	1	Own the Room	Cristina Costantini, Darren Foster	Alondra Toledo, Daniela Blanco, Henry Onyango, Jason Hadzikostas, Santosh Pandey	1	47	2021	7	91 min	1	Five young entrepreneurs from across the world vie for $100,000.
201	1	Garfield: A Tail of Two Kitties	Tim Hill	Breckin Meyer, Jennifer Love Hewitt, Billy Connolly, Bill Murray	25	48	2006	5	79 min	105	Garfield is adopted by a greedy Lord with nefarious plans to open up his estate as a hunting ground.
202	2	American Dragon: Jake Long		Dante Basco, Jeff Bennett, Amy Bruckner, John DiMaggio, Charlie Finn, Kittie	3	49	2004	8	2 Seasons	73	Jake strives to find balance in his life as a New York teen learning to master his mystical powers.
203	2	Car SOS			19	49	2012	1	8 Seasons	106	Decaying classic cars are revived by two experts for unsuspecting, grateful owners.
204	2	Disney Channel Games 2008			1	49	2008	6	1 Season	107	Disney Channel stars from around the globe compete in the third annual Disney Channel Games.
205	2	Disney Roll It Back (Shorts)		Ramon Reed, Kaylin Hayman, Suzi Barrett, Tobie Windham, JC Currais	1	49	2019	8	1 Season	108	Join the cast of Just Roll With It as they recap all the crazy that happened in the latest episode!
206	2	Dog With a Blog		G Hannelius, Blake Michael, Francesca Capaldi, Stephen Full, Regan Burns, Beth Littleford	3	49	2012	6	3 Seasons	109	Tyler and Avery hide the fact that their new dog can talk.
207	2	Mickey Go Local		Azran Bin Ahmad, Rozita Binti Mohamed Hussain, Shamsir Bin Mohd Shahar, Suzana Binti Ahmad	1	49	2019	6	1 Season	110	Mickey and his friends explore Singapore and Malaysia’s finest, from food to clothing.
208	1	Myth: A Frozen Tale	Jeff Gipson	Evan Rachel Wood	3	49	2021	6	12 min	111	A family sits down for a bedtime story and is transported to a forest filled with elemental spirits.
209	1	Okavango: River of Dreams	Dereck Joubert, Beverly Joubert	Dereck Joubert	28	49	2020	1	95 min	10	The story of the Okavango River through the wildlife who dwell amongst its waters.
210	2	Pair of Kings		Mitchel Musso, Doc Shaw, Kelsey Chow, Ryan Ochoa, Geno Segers	3	49	2010	8	3 Seasons	56	Fraternal teenage twins, Brady and Boomer, are suddenly informed of their royal lineage.
211	2	Secrets of Sulphur Springs		Preston Oliver, Kyliegh Curran, Elle Graham, Madeleine McGraw, Landon Gordon, Kelly Frye	3	49	2021	1	1 Season	112	Griffin and his family move to a mysterious town.
212	1	Shanghai Disney Resort Grand Opening Gala			1	49	2016	6	24 min	113	A grand extravaganza which celebrates the opening of Shanghai Disney Resort.
213	1	Cheaper By the Dozen	Shawn Levy	Steve Martin, Bonnie Hunt, Hilary Duff, Tom Welling, Piper Perabo	3	50	2003	5	99 min	40	Tom and Kate Baker discover that managing twelve children and big careers are a difficult mix.
214	1	Cheaper by the Dozen 2	Adam Shankman	Steve Martin, Eugene Levy, Bonnie Hunt, Tom Welling, Piper Perabo, Carmen Electra	2	50	2005	5	95 min	40	The Bakers go toe-to-toe against the Murtaughs in the ultimate inter-family battle.
215	1	Flora & Ulysses	Lena Khan	Matilda Lawler, Alyson Hannigan, Ben Schwartz, Anna Deavere Smith, Danny Pudi, Benjamin Evan Ainsworth	3	50	2021	5	95 min	114	Comic book fan Flora saves a squirrel whose superhero powers bring hope and wonder to her family.
216	1	The Book of Life	Jorge R. Gutiérrez	Diego Luna, Zoe Saldana, Channing Tatum, Ron Perlman, Christina Applegate, Ice Cube	1	50	2014	5	101 min	73	A young man embarks on a journey that spans three fantastical worlds.
217	2	The Muppet Show		Jim Henson, Frank Oz, Dave Goelz, Richard Hunt, Eren Ozker, John Lovelady	5	50	1976	1	5 Seasons	115	It's time to raise the curtain on The Muppet Show!
218	2	Marvel Battleworld: Mystery of the Thanostones		Giles Panton, Rebecca Shoichet, Jesse Inocalla, Brad Swaile, Deven Mack, Ian Hanlin	3	51	2020	9	1 Season	13	Iron Man and Captain Marvel team up to stop Thanos!
219	1	Marvel's Behind the Mask			1	51	2021	7	65 min	116	A documentary special exploring the power of identity behind superheroes we know and love today.
220	1	Rodgers & Hammerstein's Cinderella	Robert Iscove	Brandy Norwood, Whitney Houston, Bernadette Peters, Paolo Montalbán, Whoopi Goldberg, Victor Garber	1	51	1997	2	86 min	54	History’s most enduring fairy tale returns with a thoroughly modern twist.
221	1	You Again	Andy Fickman	Kristen Bell, Sigourney Weaver, Jamie Lee Curtis, Odette Yustman, Kristin Chenoweth, Victor Garber	3	51	2010	5	106 min	16	An unlikely reunion causes high school drama to resurface between a nice girl and her arch nemesis.
222	1	Disney My Music Story: Yoshiki	Kentaro Takayanagi	YOSHIKI	29	52	2019	1	48 min	83	Yoshiki from “X Japan” performs two Disney songs and talks about his music.
223	1	Expedition Everest	Katie Bauer Murdock	Tate Donovan	3	52	2020	1	45 min	10	Scientists and Sherpas team up on Mount Everest to install the highest weather station in the world.
224	1	Upside-Down Magic	Joe Nussbaum	Izabela Rose, Siena Agudong, Kyle Howard, Elie Samouhi, Alison Fernandez, Max Torina	2	52	2020	1	97 min	71	Nory enters the Sage Academy for Magical Studies!
225	2	Wicked Tuna: Outer Banks		Bill Ratner	1	52	2013	7	7 Seasons	4	Fishermen venture to North Carolina’s Outer Banks to battle for the ocean’s most lucrative prize.
226	2	Dinosaurs			3	53	1991	1	4 Seasons	40	Dinosaurs raise a family during the Stone Age.
227	1	Texas Storm Squad	Natalie Hewit	Sam Douglas	1	53	2020	7	44 min	1	An elite search and rescue team battles to save lives during record-breaking Storm Imelda.
228	2	Pixar Popcorn		Ellen DeGeneres, Craig T. Nelson, Holly Hunter, Keegan-Michael Key, Jordan Peele	3	54	2021	1	1 Season	39	Grab a quick snack of Pixar with this collection of mini shorts starring your favorite characters.
229	1	Wild Uganda	Harald Pokieser	Russell Boulter	1	54	2018	1	45 min	10	Uganda boasts one of the most diverse landscapes on Earth and wildlife is thriving.
230	2	Elena of Avalor		Aimee Carrero, Jenna Ortega, Keith Ferguson, Jillian Reed, Carlos Alazraqui, Mikey Kelley	3	55	2015	8	3 Seasons	13	Elena of Avalor must learn to rule!
231	1	Isle of Dogs	Wes Anderson	Bryan Cranston, Koyu Rankin, Edward Norton, Bob Balaban, Jeff Goldblum, Bill Murray	22	55	2018	3	102 min	73	Set in Japan, ISLE OF DOGS follows a boy's odyssey in search of his dog.
232	1	Mary Poppins Returns	Rob Marshall	Emily Blunt, Lin-Manuel Miranda, Ben Whishaw, Emily Mortimer, Julie Walters, Pixie Davies	5	55	2018	5	140 min	117	Mary Poppins is back to help the Banks family in this reimagined classic.
233	2	WandaVision		Elizabeth Olsen, Paul Bettany, Teyonah Parris, Kathryn Hahn, Randall Park, Kat Dennings	3	55	2021	7	1 Season	118	Two super-powered beings living idealized suburban lives suspect that everything is not as it seems.
234	2	Disney Fam Jam		Phil Wright, Ariel Martin, Trevor Tordjman	3	56	2020	6	1 Season	119	Families across America compete in epic dance battles!
235	1	Ferdinand	Carlos Saldanha	Jack Gore, Jet Jurgensmeyer, Nile Diaz, Colin H. Murphy, Carlos Saldanha, Jeremy Sisto	30	56	2017	5	111 min	73	Ferdinand, a peace-loving bull, rallies a misfit team of friends on the ultimate adventure home.
236	2	Marvel Studios LEGENDS			3	56	2021	7	1 Season	120	Marvel Studios LEGENDS celebrates the heroes and villains of the highly anticipated Disney+ shows.
237	1	Toy Story: That Time Forgot	Steve Purcell	Tom Hanks, Tim Allen, Kristen Schaal, Kevin McKidd, Emily Hahn, Wallace Shawn	3	56	2014	6	22 min	73	The Toy Story crew meet a delusional set of action figures.
238	1	700 Sharks	Luc Marescot	Paul Bandey	7	57	2018	1	45 min	10	Follow an international team of scientists in Polynesia as they study a school of 700 sharks.
239	1	Big Sharks Rule		Lance Lewman	1	57	2018	7	45 min	10	In the waters of South Africa, sharks reign supreme.
274	2	Party Animals			1	62	2016	6	1 Season	132	This music video series captures the funny moments animals have in their day-to-day lives.
240	1	Dr. Seuss' Horton Hears a Who!	Jimmy Hayward, Steve Martino	Jim Carrey, Steve Carell, Will Arnett, Seth Rogen, Isla Fisher, Amy Poehler	3	57	2008	2	88 min	11	Horton must save a civilization living on a speck of dust from those who don't believe they exist.
241	1	Great Shark Chow Down	Mark Woodward	Dan Nachtrab	1	57	2019	1	45 min	10	Great Shark Chow Down – prepare for a feast of extraordinary shark-feeding events.
242	1	Mega Hammerhead	Brandon Hill, Marc Ostrick	Neil Hammerschlag	3	57	2016	1	43 min	10	Dr. Neil Hammerschlag and his team are setting off on a quest to learn more the Great Hammerhead.
243	1	Burrow	Madeline Sharafian		3	58	2020	2	6 min	18	A rabbit attempts to dig a burrow and learns there’s no shame in asking for help.
244	2	Cosmos: Possible Worlds		Neil deGrasse Tyson	3	58	2020	7	1 Season	121	COSMOS: POSSIBLE WORLDS continues Carl Sagan’s legacy that began more than 40 years ago.
245	2	Disney Gallery / Star Wars: The Mandalorian		Jon Favreau, Dave Filoni, Pedro Pascal, Bryce Howard, Taika Waititi, Carl Weathers	3	58	2020	1	2 Seasons	121	DISNEY GALLERY / STAR WARS: THE MANDALORIAN is a docuseries about the making of The Mandalorian.
246	1	Max Keeble's Big Move	Tim Hill	Alex D. Linz, Larry Miller, Jamie Kennedy, Zena Grey, Josh Peck, Nora Dunn	3	58	2001	5	88 min	40	After a week of creating mayhem, Max has to face the consequences.
247	1	Soul	Pete Docter	Jamie Foxx, Tina Fey, Angela Bassett, Ahmir-Khalib "Questlove" Thompson, Phylicia Rashad, Daveed Diggs	3	58	2020	5	107 min	11	Jamie Foxx stars in Pixar’s "Soul," a comedy about what makes you... YOU.
248	1	Arendelle Castle Yule Log			3	59	2020	6	180 min	18	Set the wintry mood for your holiday celebration with Anna and Elsa’s Arendelle Castle yule log.
249	1	Buried Truth of the Maya		Josh Bernstein	3	59	2020	1	48 min	122	A high-tech archaeological team explores the hidden secrets of Chichen Itza.
250	2	Disney Parks Sunrise Series			1	59	2021	6	1 Season	4	An inspiring view of Disney Parks few have experienced before, at sunrise. Previously Recorded.
251	1	Dory's Reef Cam	Michal Makarewicz		3	59	2020	6	182 min	18	Dive into the waters below and watch the aquatic wildlife from the world of Nemo and Dory.
252	1	Eddie the Eagle	Dexter Fletcher	Tom Costello, Jo Hartley, Keith Allen, Dickon Tolson, Jack Costello, Taron Egerton	31	59	2016	3	107 min	123	True story of Eddie Edwards, a British ski-jumper whose Olympic performance wins the hearts of fans.
253	1	Into the Woods	Rob Marshall	Meryl Streep, Emily Blunt, James Corden, Anna Kendrick, Chris Pine, Tracey Ullman	3	59	2014	5	126 min	124	A baker and his wife's desperation to have a child sends them on a quest to reverse a witch’s curse.
254	1	Miraculous World: New York, United Heroez	Thomas Astruc	Cristina Vee, Bryce Papenbrook, Keith Silverstein, Carrie Keranen, Selah Victor, Sabrina Weisz	32	59	2020	9	60 min	13	Marinette’s class is headed to New York!
255	2	On Pointe			3	59	2020	1	1 Season	45	On Pointe follows students during a season in the School of American Ballet (SAB) in New York City.
256	2	Wild Nordic		Dan Nachtrab	1	59	2019	1	1 Season	125	As seen by the Viking gods, the fabled wildernesses of Norway, Finland and Sweden are revealed.
257	1	Disney Channel's Epic Holiday Showdown			3	60	2020	6	50 min	126	DC stars try to save the holidays from Scrooge.
258	1	Disney Holiday Magic Quest			3	60	2020	6	46 min	127	ZOMBIES stars race to save the holiday magic!
259	1	Gender Revolution: A Journey With Katie Couric		Katie Couric	3	60	2017	7	93 min	1	Katie Couric explores questions about gender identity with experts and everyday people.
260	1	High School Musical: The Musical: The Holiday Special		Olivia Rodrigo, Joshua Bassett, Sofia Wylie, Matt Cornett, Larry Saperstein, Julia Lester	3	60	2020	6	46 min	128	The cast of High School Musical: The Musical: The Series celebrates the holidays with music & more!
261	1	Ralph Breaks the Internet	Rich Moore, Phil Johnston	John C. Reilly, Sarah Silverman, Gal Gadot, Jane Lynch, Jack McBrayer, Alan Tudyk	3	60	2018	5	116 min	73	Ralph and Vanellope are swept into the internet.
262	1	Safety	Reginald Hudlin	Jay Reeves, Thaddeus J. Mixson, Corinne Foxx, Matthew Glave, James Badge Dale, Hunter Sansone	3	60	2020	5	123 min	129	A drama inspired by the empowering story of former Clemson University safety Ray McElrathbey.
263	1	Anastasia	Don Bluth, Gary Goldman	Meg Ryan, John Cusack, Kelsey Grammer, Christopher Lloyd, Hank Azaria, Bernadette Peters	3	61	1997	2	95 min	111	A girl heads to Paris to learn if she is the long lost princess, Anastasia.
264	1	Godmothered	Sharon Maguire	June Squibb, Jillian Bell, Jane Curtin, Carlease Burke, Sonia Manzano, Erica Parks	3	61	2020	5	113 min	54	An inexperienced fairy godmother-in-training tries to prove that people still need fairy godmothers.
265	1	Man vs. Shark		Jeremiah Sullivan, Dave Hoffman	3	61	2019	1	45 min	10	Marine biologist attempts to get bitten by a deadly tiger shark and survive
266	1	Mulan	Niki Caro	Yifei Liu, Donnie Yen, Gong Li, Jet Li, Jason Lee, Yoson An	33	61	2020	3	117 min	130	A young woman risks it all to be a great Chinese warrior in Disney’s MULAN.
267	1	Sky High	Mike Mitchell	Kelly Preston, Lynda Carter, Michael Angarano, Danielle Panabaker, Mary Elizabeth Winstead, Bruce Campbell	3	61	2005	5	101 min	36	It takes inner and outer strength to make a name for yourself when you're the son of heroes.
268	1	The Disney Holiday Singalong		Ryan Seacrest, Andrea Bocelli, BTS , Michael Bublé, Ciara , Chloe x Halle	3	61	2020	6	45 min	27	A festive musical event with more Disney melodies and classic holiday songs.
269	1	The Nutcracker and the Four Realms	Lasse Hallström, Joe Johnston	Keira Knightley, Mackenzie Foy, Eugenio Derbez, Jayden Fowora-Knight, Matthew Macfadyen, Richard Grant	3	61	2018	5	101 min	30	From Disney comes the reimagined tale of The Nutcracker.
270	1	Alexander and the Terrible, Horrible, No Good, Very Bad Day	Miguel Arteta	Steve Carell, Jennifer Garner, Ed Oxenbould, Dylan Minnette, Kerris Dorsey, Jennifer Coolidge	3	62	2014	5	83 min	19	It's one calamity after another during the worst day of Alexander's life.
271	1	Black Beauty	Ashley Avis	Mackenzie Foy, Kate Winslet, Iain Glen, Calam Lynch, Claire Forlani, Fern Deacon	3	62	2020	1	111 min	49	A wild horse and a teenage girl forge an unbreakable bond which keeps them connected for a lifetime.
272	1	From Our Family to Yours	Angela Affinita		19	62	2020	6	3 min	18	A granddaughter brings joy on Christmas by mending a beloved Mickey, evoking memories of the past.
273	2	Once Upon a Time in Wonderland		Sophie Lowe, Michael Socha, Peter Gadiot, Emma Rigby, Naveen Andrews, John Lithgow	15	62	2013	1	1 Season	131	Alice tells a tale of a strange new land.
275	2	Port Protection Alaska		Gary Muehlberger, Mary Miller, Curly Leach, Sam Carlson, Stuart Andrews, David Squibb	3	62	2015	7	1 Season	75	Residents of Port Protection must combat volatile conditions to survive and thrive in Alaska.
276	1	Folklore: the long pond studio sessions		Taylor Swift, Aaron Dessner, Jack Antonoff, Justin Vernon	3	63	2020	7	107 min	133	An intimate musical concert featuring Taylor Swift performing every song from “folklore.”
277	2	Bia		Isabela Souza, Giulia Guerrini, Julio Peña, Guido Messina, Andrea de Alba, Agustina Palma	34	64	2019	6	1 Season	134	Bia is filled with passion, after the loss of her sister she will rediscover music and find love.
278	2	Marvel's 616			3	64	2020	7	1 Season	104	An anthology documentary series exploring the impact of the Marvel Comics Universe.
279	1	Planes	Klay Hall	Dane Cook, Stacy Keach, Brad Garrett, Teri Hatcher, Julia Louis-Dreyfus, Priyanka Chopra	3	64	2013	5	94 min	73	A crop duster takes on the world’s fastest in the greatest air race ever.
280	1	Planes: Fire & Rescue	Bobs Gannaway	Dane Cook, Ed Harris, Julie Bowen, Curtis Armstrong, John Higgins, Hal Holbrook	3	64	2014	5	85 min	73	Air racer Dusty teams up with a dynamic crew of flying firefighters.
281	1	The Real Right Stuff			3	64	2020	1	90 min	122	The Real Right Stuff tells the story of the nation’s first astronauts.
282	2	The Wonderful World of Mickey Mouse		Chris Diamantopoulos, Kaitlyn Robrock, Bill Farmer, Tony Anselmo, Tress MacNeille	3	65	2020	6	1 Season	35	It's nothing but fun for Mickey and friends as they embark on their greatest adventures yet.
283	1	LEGO Star Wars Holiday Special	Ken Cunningham	Helen Sadler, Omar Miller, Jake Green, Kelly Marie Tran, Trevor Devall, Matt Sloan	3	66	2020	9	48 min	73	On the festive Life Day, Rey and BB-8 embark on an epic adventure across Star Wars history.
284	1	Home Alone	Chris Columbus	Macaulay Culkin, Joe Pesci, Daniel Stern, John Heard, Roberts Blossom, Catherine O'Hara	3	67	1990	5	103 min	40	When Kevin is home while his family goes on a Christmas trip, he must defend his home from burglars.
285	1	Home Alone 2: Lost in New York	Chris Columbus	Macaulay Culkin, Joe Pesci, Daniel Stern, John Heard, Devin Ratray, Catherine O'Hara	3	67	1992	5	121 min	40	Kevin is home alone in NYC but won't be for long since the Wet Bandits are also in the Big Apple.
286	1	Home Alone 3	Raja Gosnell	Alex D. Linz, Haviland Morris, Olek Krupa	3	67	1997	5	103 min	40	A gang of criminals come up against 8 year-old Alex Pruitt, who is home alone with the chicken pox.
287	2	Inside Pixar			3	67	2020	1	1 Season	45	An inside look at the people, artistry, and culture of Pixar Animation Studios.
288	1	Petra: Secrets of the Ancient Builders	Thierry Fessard, Yohann Thiriet	Bert Morris	35	67	2019	6	45 min	122	Discover the technical prowess behind Petra, a wonder in the middle of the desert.
289	1	Ultimate Viking Sword	Peter Yost	Jay Sanders	1	67	2019	1	45 min	122	National Geographic reconstructs the Ulfberht, a Viking warrior’s ultimate weapon.
290	1	Disney's A Christmas Carol	Robert Zemeckis	Jim Carrey, Gary Oldman, Colin Firth, Bob Hoskins, Robin Penn, Cary Elwes	3	68	2009	5	97 min	50	Three ghosts take Ebenezer Scrooge on an eye-opening journey.
291	2	Fancy Nancy (Shorts)		Mia Sinclair Jenness, Dana Heath, Spencer Moss, Alyson Hannigan	1	68	2019	4	1 Season	38	Follow Nancy as she shows you how to be more Fancy!
292	2	Goldie & Bear		Georgie Kidder, Justine Huxley, Natalie Lander, Jim Cummings, David Kaufman, David Lodge	3	68	2015	4	2 Seasons	135	Goldie and Bear go on adventures in Fairytale Forest.
293	1	Mr. Magoo	Stanley Tong	Leslie Nielsen, Kelly Lynch, Ernie Hudson, Stephen Tobolowsky, Nick Chinlund, Matt Keeslar	3	68	1997	5	88 min	85	Clueless Mr. Magoo sets out to get back a stolen precious gem.
294	1	Prep & Landing	Kevin Deters, Stevie Wermers-Skelton	Dave Foley, Sarah Chalke, Mason Cotton, Lino DiSalvo, Derek Richardson, William Sheppard	3	68	2009	6	23 min	111	An elite elf unit ensures homes around the world are prepared for Santa.
295	1	Prep & Landing: Naughty vs. Nice	Kevin Deters, Stevie Wermers-Skelton	Dave Foley, Derek Richardson, Sarah Chalke, Rob Riggle, Chris Parnell, W. Sheppard	3	68	2011	6	23 min	111	Wayne and Lanny race to save Christmas!
296	1	Disney Channel Halloween House Party	Trevor Moore	Tobie Windham, Raphael Alejandro, Suzi Barrett, Isaac Ryan Brown, Kylie Cantrall, Scarlett Estevez	3	69	2020	6	23 min	136	Disney Channel Stars celebrate Halloween in a sketch comedy special with tricks, treats, and more!
297	2	The Mandalorian		Pedro Pascal, Carl Weathers, Gina Carano, Omid Abtahi, Nick Nolte	3	69	2019	7	2 Seasons	24	After the fall of the Empire, a lone gunfighter makes his way through the lawless galaxy.
298	1	The Sorcerer's Apprentice	Jon Turteltaub	Nicolas Cage, Jay Baruchel, Alfred Molina, Teresa Palmer, Monica Bellucci, Omar Miller	3	69	2010	5	111 min	17	A modern-day sorcerer must make his seemingly average recruit into the ultimate apprentice.
299	2	X-Ray Earth			3	69	2020	1	1 Season	125	What if we could x-ray the Earth to reveal the origins of natural disasters? Now we can.
300	2	Gathering Storm		Tucker McDougall	3	70	2020	1	1 Season	15	Witness first hand stories combined with scientific insight, analysis and satellite mapping.
301	2	India From Above		Dev Patel	1	70	2019	1	1 Season	137	India From Above, a two-part aerial documentary of a nation and its people.
302	2	Marvel Super Hero Adventures			3	70	2017	4	4 Seasons	5	Spider-Man sets off on adventures with Marvel heroes!
303	1	Once Upon a Snowman	Dan Abraham, Trent Correy	Josh Gad, Idina Menzel, Kristen Bell, Jonathan Groff, Chris Williams	3	70	2020	1	12 min	21	This new short film follows Olaf’s first steps as he comes to life and searches for his identity.
304	1	Pompeii: Secrets Of The Dead	Ben Finney	Maite Jauregui	3	70	2019	1	45 min	122	Forensic experts scan Pompeii’s victims to investigate why they didn’t escape the eruption.
305	1	Toy Story of Terror!	Angus MacLane	Tom Hanks, Tim Allen, Joan Cusack, Carl Weathers, Stephen Tobolowsky, Timothy Dalton	3	70	2013	6	22 min	11	Join the Toy Story gang in a frighteningly fun animated adventure.
306	1	Beverly Hills Chihuahua	Raja Gosnell	Piper Perabo, Manolo Cardona, Jamie Curtis, Jose Yazpik, Maury Sterling, Jesus Ochoa	36	71	2008	5	95 min	36	Papi has to rescue his true love, Chloe, when she gets lost in Mexico.
307	1	Clouds	Justin Baldoni	Fin Argus, Sabrina Carpenter, Madison Iseman, Neve Campbell, Tom Scott, Lil Rel Howery	3	71	2020	3	122 min	138	A young musician with months to live turns to music to make the most of the time he has left.
308	2	Drain the Oceans		Russell Boulter	37	71	2017	1	3 Seasons	139	Pull the plug on the ocean to reveal hidden secrets using groundbreaking technology.
309	1	Lost on Everest	Renan Ozturk	Tate Donovan	3	71	2020	7	60 min	140	The quest to reveal what happened to the explorers who first set out to summit Mt. Everest.
310	1	Marvel's Iron Man & Captain America: Heroes United	Leo Riley	Adrian Pasdar, Roger Smith, Fred Tatasciore, David Kaye, Liam O'Brien, Clancy Brown	3	71	2014	5	72 min	81	Iron Man and Captain America battle the Red Skull and Taskmaster.
311	2	Meet The Chimps		Jane Lynch	3	71	2020	1	1 Season	4	Meet the Chimps takes viewers inside the secret life of Chimp Haven, a unique wildlife sanctuary.
312	2	The Rocketeer		Kitana Turnbull, Billy Campbell, Kathy Najimy, Callan Farris, Frank Welker	3	71	2019	4	1 Season	5	Kit becomes a rocket-pack wearing superhero!
313	1	Oil Spill of The Century		Loïck Peyron	1	72	2019	1	45 min	122	Loïck Peyron investigates the 1978 Amoco Cadiz oil spill and its impact.
314	1	The Chronicles Of Narnia: The Voyage of the Dawn Treader	Michael Apted	Georgie Henley, Skandar Keynes, Ben Barnes, Will Poulter, Tilda Swinton	5	72	2010	5	113 min	30	Three heroes sail with King Caspian to help Narnian lords banished by an evil usurper of the throne.
315	2	The Right Stuff		Jake McDorman, Patrick Adams, Colin O’Donoghue, Eloise Mumford, James Lafferty, Nora Zehetner	3	72	2020	7	1 Season	141	The incredible story of the Mercury Seven astronauts and their extraordinary achievements.
316	1	Wild Portugal	Christian Baumeister	Bart Thomasson	1	72	2020	7	45 min	142	Explore a rugged world where diverse species fight for survival.
317	1	X2	Bryan Singer	Patrick Stewart, Hugh Jackman, Ian McKellen, Halle Berry, Famke Janssen, James Marsden	15	72	2003	3	134 min	24	X-Men newcomer, Night Crawler, joins Magneto to rescue their brethren and forestall a holocaust.
318	1	Mr. Holland's Opus	Stephen Herek	Richard Dreyfuss, Glenne Headly, Jay Thomas, W.H. Macy, Alicia Witt, Jean Kelly	3	73	1996	5	143 min	143	A musician finds his passion when he takes a “day job” as a music teacher.
319	2	Secrets Of The Zoo: Down Under		Naomi Watts	1	73	2020	7	1 Season	4	This series is a behind-the-scenes look at one of the world’s most famous zoos.
320	2	The Simpsons		Dan Castellaneta, Julie Kavner, Nancy Cartwright, Yeardley Smith, Hank Azaria, Pamela Hayden	3	73	1989	1	31 Seasons	144	The world’s favorite nuclear family, in the award-winning, history-making series.
321	1	Disneynature Oceans	Jacques Perrin, Jacques Cluzaud	Pierce Brosnan, Lancelot Perrin	38	74	2010	2	84 min	142	Journey into the depths of a wonderland filled with beauty and power.
322	1	Hidden Figures	Theodore Melfi	Taraji Henson, Octavia Spencer, Janelle Monáe, Kevin Costner, Kirsten Dunst, Jim Parsons	3	74	2016	5	128 min	145	A story about three women at NASA who helped launch John Glenn into orbit.
323	2	Magic of Disney's Animal Kingdom		Josh Gad	19	74	2020	1	1 Season	4	Magic of Disney’s Animal Kingdom goes backstage at Walt Disney World Resort. Narrated by Josh Gad.
324	1	Secret Society of Second-Born Royals		Peyton Lee, Niles Fitch, Isabella Blake-Thomas, Olivia Deeble, Skylar Astin, Elodie Yung	3	74	2020	1	99 min	89	Sam, a rebellious royal, learns she is part of the Secret Society of Second-Born Royals.
325	1	The Giant Robber Crab	Moritz Katz	Colin Solman	3	74	2019	1	44 min	10	As we follow the robber’s life cycle, we learn that crabs are much more than creepy crawlies.
326	2	Wild Central America		Nigel Marven	1	74	2020	1	1 Season	12	Presenter Nigel Marven discovers the colourful and varied wildlife and culture of Central America.
327	2	Ancient China from Above		Dr. Allan Maca	3	75	2020	7	1 Season	139	Archaeologist Allan Maca reveals the amazing wonders of Ancient China like never before.
328	2	Becoming			3	75	2020	1	1 Season	146	Becoming chronicles the origin stories of world-class entertainers, musicians and athletes.
329	1	Bend It Like Beckham	Gurinder Chadha	Parminder Nagra, Keira Knightley, Jonathan Rhys-Meyers, Anupam Kher, Archie Panjabi, Shaznay Lewis	31	75	2003	3	112 min	147	Despite the wishes of their traditional families, two girls aim for careers in professional soccer.
330	2	Coop & Cami Ask The World		Ruby Turner, Dakota Lotus, Olivia Sanabia, Albert Tsai, Paxton Booth, Rebecca Metz	3	75	2018	6	2 Seasons	105	Cooper and Cami Wrather co-host "Would You Wrather."
331	2	Europe from Above		Julian Barratt	19	75	2019	6	1 Season	137	Europe from Above takes to the air over Europe’s finest cultural and geographical landmarks.
332	1	Ever After: A Cinderella Story	Andy Tennant	Drew Barrymore, Anjelica Huston, Dougray Scott, Patrick Godfrey, Megan Dodds, Melanie Lynskey	3	75	1998	3	122 min	148	A young woman falls in love with a prince while pretending to be a princess.
333	2	Kingdom of the Mummies		Kerry Shale	3	75	2020	7	1 Season	149	A team of archaeologists uncover the first Egyptian funeral parlor ever found.
334	1	Morning Light	Mark Monroe	Patrick Warburton	3	75	2008	5	99 min	150	Fifteen rookie sailors race to be part of the "Morning Light" crew.
335	1	Notre Dame: Race Against The Inferno	Fabrice Gardel, Simon Kessler, Josselin Mahot	Paul Bandey	39	75	2019	1	45 min	1	On April 15, 2019, Paris’ firefighters gave everything to save the Notre Dame cathedral.
336	2	Once Upon a Time		Ginnifer Goodwin, Jennifer Morrison, Robert Carlyle, Lana Parrilla, Jared Gilmore, Josh Dallas	3	75	2011	1	7 Seasons	131	Fairy tale characters inhabit a land of good and evil.
337	2	Soy Luna		Karol Sevilla, Ruggero Pasquarelli, Valentina Zenere, Lucila Gandolfo, Michael Ronda, Carolina Kopelioff	40	75	2015	6	3 Seasons	114	Luna will learn that love transcends distance.
338	2	Violetta		Diego Ramos, Martina Stoessel, Pablo Espinosa, Jorge Blanco, Mercedes Lambre, Nicolás Garnier	34	75	2011	6	3 Seasons	134	Violetta is a talented teen following her dream.
339	1	Christopher Robin	Marc Forster	Ewan McGregor, Hayley Atwell, Bronte Carmichael, Mark Gatiss, Oliver Davies, Ronke Adekoluejo	25	76	2018	5	109 min	151	Pooh leaves the Hundred Acre Wood to help grown-up Christopher Robin.
340	1	D2: The Mighty Ducks	Sam Weisman	Emilio Estevez, Michael Tucker, Jan Rubeš, Kathryn Erbe, Joshua Jackson, Elden Ratliff	3	77	1994	5	107 min	152	The Mighty Ducks face the meanest team on ice at the Junior Goodwill Games.
341	1	D3: The Mighty Ducks	Robert Lieberman	Emilio Estevez, Jeffrey Nordling, David Selby, Heidi Kling, Joshua Jackson, Elden Ratliff	3	77	1996	5	104 min	114	The Mighty Ducks inherit a new coach and a new set of problems.
342	2	Earth to Ned			3	77	2020	1	1 Season	153	From the Jim Henson Company, alien commander Ned hosts a late-night talk show with celebrity guests.
343	1	Trick or Treat	Jack Hannah		3	77	1952	6	9 min	111	Donald plays a trick on his nephews, but a witch helps them out. See details for advisory.
344	1	Alice Through the Looking Glass	James Bobin	Johnny Depp, Anne Hathaway, Mia Wasikowska, Matt Lucas, Rhys Ifans, Helena Carter	5	78	2016	5	115 min	17	Alice returns to Underland to save the Mad Hatter in a race against time.
345	1	Phineas and Ferb The Movie: Candace Against the Universe		Ashley Tisdale, Vincent Martella, Ali Wong, Dan Povenmire, Alyson Stoner, Maulik Pancholy	3	78	2020	6	86 min	73	Phineas and Ferb set out across the galaxy to rescue Candace, who has been abducted by aliens.
346	1	Back to the Titanic			19	79	2020	1	44 min	122	Back to the Titanic documents the first manned dives to Titanic in nearly 15 years.
347	1	Beauty and the Beast	Bill Condon	Emma Watson, Dan Stevens, Luke Evans, Kevin Kline, Josh Gad, Ewan McGregor	3	79	2017	5	138 min	117	Belle must look beyond the Beast’s exterior to find the true Prince within.
348	1	Mars: One Day on the Red Planet	Martin Johnson	Nigel Barber	3	79	2020	1	88 min	1	An epic journey around the real Mars – built from data, as you’ve never seen it before.
349	1	The One and Only Ivan	Thea Sharrock	Sam Rockwell, Angelina Jolie, Danny DeVito, Helen Mirren, Brooklynn Prince, Ramón Rodríguez	3	79	2020	5	95 min	151	An adaptation of the award-winning book about a very special gorilla.
350	2	Weirdest, Bestest, Truest		Charlie Engelman, Kirby Engelman	1	79	2018	6	1 Season	154	Siblings Kirby and Charlie share strange discoveries and fun facts from the world of Weird But True!
351	2	Disney Junior T.O.T.S.: Calling All T.O.T.S. (Shorts)		Jet Jurgensmeyer, Christian Simon, Megan Hilty	1	80	2020	4	1 Season	155	What happens after the baby animals are delivered?
352	1	Disney Zombies 2	Paul Hoen	Milo Manheim, Meg Donnelly, Trevor Tordjman, Kylee Russell, Carla Jeffery, Chandler Kinney	3	80	2020	6	84 min	156	Zed and Addison encounter a group of werewolves!
353	1	India's Wild Leopards		Sandesh Kadur, Priya Singh	41	80	2020	7	45 min	10	Cameraman Sandesh Kadur’s mission is to uncover the secretive lives of India’s leopards.
354	2	Jungle Animal Rescue		Dan Nachtrab	3	80	2019	1	1 Season	4	A team of conservationists and veterinarians helps India’s people and wildlife coexist.
355	1	Magic Camp	Mark Waters	Adam DeVine, Gillian Jacobs, Nathaniel McIntyre, Jeffrey Tambor, Cole Sand, Isabella Crovetti	3	80	2020	5	101 min	40	A group of misfit campers help a down-on-his-luck magician rediscover his love of magic.
356	1	Marvel Studios' Ant-Man and the Wasp	Peyton Reed	Paul Rudd, Evangeline Lilly, Michael Peña, Walton Goggins, Hannah John-Kamen, David Dastmalchian	3	80	2018	3	120 min	157	Ant-Man and the Wasp must join forces to uncover secrets from the past.
357	2	Nature Boom Time		Charlie Engelman, Kirby Engelman, Patrick Rahill	3	80	2016	6	1 Season	158	Charlie, Kirby, and Patrick travel around the U.S. to learn about what makes nature awesome.
358	2	Sam's Zookeeper Challenge		Sam Peltz	3	80	2018	6	1 Season	4	Sam is put to the test to care for animals in “Zookeeper’s Challenge.”
359	2	Scuba Sam's World		Sam Peltz	3	80	2018	6	1 Season	158	Take a deep dive and learn all about the beloved sea animals in our oceans!
360	2	Spaced Out		Ben DeTour	1	80	2018	6	1 Season	159	Learn about our universe through imagery taken from the Hubble Space Telescope.
361	1	The Greatest Showman	Michael Gracey	Hugh Jackman, Zac Efron, Michelle Williams, Rebecca Ferguson, Zendaya , Keala Settle	3	80	2017	5	106 min	145	A bold and original musical celebrating the birth of show business and dreams coming to life.
362	2	Weird But True!		Charlie Engelman, Kirby Engelman	3	80	2017	6	3 Seasons	154	Come along as we reveal fun, strange & surprising facts about our world in Weird But True!
363	2	Wild Cats of India		James Murray	3	80	2020	1	1 Season	4	Journey across the country’s landscapes to paint an intimate portrait of India's Wild Cats.
364	1	Howard	Don Hahn	Howard Ashman	3	81	2020	1	95 min	83	“Howard” is the untold story of Howard Ashman, the brilliant lyricist behind Disney classics.
365	1	Prince of Persia: The Sands of Time	Mike Newell	Jake Gyllenhaal, Ben Kingsley, Gemma Arterton, Alfred Molina, Richard Coyle, Toby Kebbell	3	81	2010	3	117 min	17	A rogue prince and rival princess safeguard a magical dagger with the power to reverse time.
366	1	Star Wars: Galaxy's Edge-Adventure Awaits		Neil Harris, Kaley Cuoco, Oscar Isaac, Sarah Hyland, Keegan-Michael Key, Jay Leno	3	81	2019	1	81 min	160	Celebrating Disney’s new land that brings Star Wars to life!
367	1	The Hidden Kingdoms of China	Ben Wallis, Emma Fraser, Jess Tombs	Michelle Yeoh	1	81	2020	1	88 min	142	THE HIDDEN KINGDOMS OF CHINA takes audiences into the secret wilds of China.
368	1	The Peanuts Movie	Steve Martino	Noah Schnapp, Alex Garfin, Hadley Miller, Mariel Sheets, Venus Schultheis, Noah Johnston	3	81	2015	2	89 min	11	Snoopy takes to the skies against The Red Baron, while his pal, Charlie Brown, begins an epic quest.
369	2	UFO Europe: The Untold Stories		Robert Ashby	1	81	2012	1	1 Season	137	A selection of stories featuring encounters and sightings of the unexplained.
370	2	Animal Showdown		Brian Peck	1	82	2018	6	1 Season	4	Animals face-off in this surprising competition of the toughest and biggest in the animal kingdom.
371	2	Best Job Ever			1	82	2018	6	1 Season	4	Check out the cool jobs Nat Geo explorers do every day!
372	1	Big Cat Games	Jeremy Turner	Boone Smith	1	82	2015	1	44 min	161	Boone Smith hosts a feline showdown as lion, tiger and cheetah battle for top cat title.
373	1	Black Is King	Beyoncé Knowles-Carter	Beyoncé Knowles-Carter	3	82	2020	7	86 min	162	This visual album from Beyoncé reimagines lessons of "The Lion King" for young kings and queens.
374	1	Cradle of the Gods	Tim Conrad	Tim Conrad	19	82	2012	1	45 min	122	Located on a hilltop sanctuary, G – bekli Tepe in Turkey is the world's first known temple.
375	2	Destination World		Rick Robles	1	82	2018	6	1 Season	158	Check out the continents and find out what makes them unique from each other!
376	2	Fearless Adventures with Jack Randall		Jack Randall	1	82	2018	1	1 Season	4	Check out Jack Randall go head-to-head with all kinds of critters.
377	1	Hunt for the Abominable Snowman	Dan Oliver	Stephen Rashbrook	1	82	2011	1	45 min	1	Across the Himalayas are stories of the yeti, or abominable snowman.
378	1	Incredibles 2	Brad Bird	Craig Nelson, Holly Hunter, Sarah Vowell, Huckleberry Milner, Catherine Keener, Eli Fucile	3	82	2018	5	118 min	62	The Incredibles spring into action when a dangerous new villain emerges.
379	2	King Fishers		Stephen Mangan	19	82	2013	1	1 Season	12	With so many fishermen and so many fishing disciplines, who is best?
380	1	Lost Temple of the Inca	Jim Aikman	Dan Nachtrab	3	82	2020	1	44 min	1	A scientist discovers artifacts in Peru that could lead him to one of the country’s missing temples.
381	2	Marvel Funko Shorts			1	82	2016	8	2 Seasons	35	Marvel and Funko present Pop! style Marvel heroes.
382	2	Muppets Now		Dave Goelz, Matt Vogel, David Rudman, Peter Linz, Bill Barretta, Eric Jacobson	3	82	2020	1	1 Season	163	The Muppets have a brand-new series ready to stream… but only if they can upload it in time.
383	1	Surviving the Mount St. Helens Disaster	Sophie Harris	Bill Ratner	19	82	2020	1	44 min	10	Eyewitness accounts and rare images chart the violent 1980 eruption of Mount St. Helens.
384	2	What Sam Sees		Sam Peltz	1	82	2018	6	1 Season	4	Join Sam on an underwater journey and learn about sharks, eels, and more!
385	1	Pirates of the Caribbean: Dead Men Tell No Tales	Joachim Rønning, Espen Sandberg	Johnny Depp, Javier Bardem, Brenton Thwaites, Kaya Scodelario, Kevin McNally, Golshifteh Farahani	3	83	2017	3	129 min	17	Captain Jack Sparrow searches for the Trident of Poseidon.
386	2	PJ Masks (Shorts)			1	83	2017	4	1 Season	5	The PJ Masks are protecting the city from villains!
387	2	Rogue Trip		Bob Woodruff, Mack Woodruff	1	83	2020	1	1 Season	164	Bob Woodruff and his son travel the world searching for beauty and adventure in unexpected places.
388	2	Wild Congo		Corey Johnson	1	83	2014	1	1 Season	4	The Congo: the most mysterious river in the dark heart of Africa.
389	2	Wild Sri Lanka		Paul McGann	19	83	2016	1	1 Season	15	This three-part series reveals the spectacular nature and amazing wildlife of Sri Lanka.
390	1	A Pre-Opening Report from Disneyland	Wilfred Jackson	Walt Disney, Winston Hibler	3	84	1955	1	55 min	165	Walt provides a look at the details needed to get the Park ready to open. See details for advisory.
391	1	Diary of a Wimpy Kid: The Long Haul	David Bowers	Jason Drucker, Alicia Silverstone, Tom Scott, Charlie Wright, Owen Asztalos, Dylan Walters	3	84	2017	5	92 min	40	A trip to Meemaw’s 90th birthday takes a detour due to Greg’s scheme to attend a gaming convention!
392	2	Disney Junior Music Lullabies			1	84	2018	4	1 Season	155	Disney Junior songs reimagined as calming lullabies.
393	1	Lost City of Machu Picchu		Craig Sechler	3	84	2019	7	44 min	160	Who were the mysterious people who built Machu Picchu and why?
394	2	Super Robot Monkey Team Hyperforce Go!		Greg Cipes, Kevin Michael\tRichardson, Tom Kenny, Kari Wahlgren, Clancy Brown, Corey Feldman	29	84	2004	8	2 Seasons	6	Chiro and a team of five Robot Monkeys defend Shuggazoom City against Skeleton King and his minions.
395	1	The Mouseketeers at Walt Disney World	John Tracy	Jo Worley, Ronnie Schell, Dennis Underwood, Leslie Norris, Billy Attmore, Scott Craig	3	84	1977	1	56 min	166	The Mouseketeers arrive to perform at Walt Disney World. See details for advisory.
396	2	Wild Chile		Peter Venn	19	84	2017	1	1 Season	4	This beautiful and intriguing blue-chip series explores the incredibly varied wildlife of Chile.
397	1	X-Men: Apocalypse	Bryan Singer	James McAvoy, Michael Fassbender, Jennifer Lawrence, Oscar Isaac, Nicholas Hoult, Rose Byrne	3	84	2016	3	144 min	24	Apocalypse, the most powerful mutant in the universe, tries to destroy all of mankind.
398	2	Cosmos: A Spacetime Odyssey		Neil Tyson, Stoney Emshwiller	3	85	2013	1	1 Season	121	A 13-part adventure across the universe of space and time.
399	1	Hamilton: History Has Its Eyes on You		Lin-Manuel Miranda, Thomas Kail, Christopher Jackson, Leslie Odom Jr., Phillipa Soo, Renee Goldsberry	3	85	2020	1	47 min	167	Robin Roberts hosts a discussion with Lin-Manuel Miranda, Thomas Kail, and original cast members.
400	1	Solo: A Star Wars Story	Ron Howard	Alden Ehrenreich, Woody Harrelson, Emilia Clarke, Donald Glover, Thandie Newton, Phoebe Waller-Bridge	3	85	2018	3	135 min	168	Witness the beginning of the Star Wars saga's most unlikely hero.
401	1	X-Men: Days of Future Past	Bryan Singer	Hugh Jackman, James McAvoy, Michael Fassbender, Jennifer Lawrence, Halle Berry, Nicholas Hoult	21	85	2014	3	132 min	24	Characters from the X-Men trilogy join their younger selves to change the past and save our future.
402	1	The Undefeated Presents: Hamilton In-Depth		Lin-Manuel Miranda, Thomas Kail, Renee Goldsberry, Leslie Odom Jr., Daveed Diggs, Phillipa Soo	3	86	2020	1	33 min	167	The Undefeated Presents: Hamilton In-Depth is a roundtable discussion with 9 stars and the director.
403	2	Animal ER		Dr. Brian Beale	3	87	2016	1	2 Seasons	4	Animal ER brings you up close to the bleeding edge of animal care.
404	1	Diary of a Wimpy Kid: Rodrick Rules	David Bowers	Zachary Gordon, Devon Bostick, Rachael Harris, Robert Capron, Steve Zahn	3	87	2011	5	100 min	40	In 7th grade, Greg must bond with his brother, Rodrick while also impressing the new girl in town.
405	1	Hamilton	Thomas Kail	Daveed Diggs, Renée Goldsberry, Jonathan Groff, Christopher Jackson, Jasmine Jones, Lin-Manuel Miranda	3	87	2020	3	160 min	169	The filmed version of Broadway original “Hamilton” that soars in music and tale.
406	1	Ice Age: Collision Course	Mike Thurmeier	Ray Romano, John Leguizamo, Denis Leary, Adam Devine, Jesse Ferguson, Max Greenfield	10	87	2016	5	97 min	73	When their world is threatened, Manny and friends go on a quest to survive the Scrat-tastrophe!
407	1	Race to Witch Mountain	Andy Fickman	Dwayne Johnson, AnnaSophia Robb, Carla Gugino, Ciarán Hinds, Alexander Ludwig, Tom Scott	3	87	2009	5	100 min	24	A Las Vegas cab driver helps two aliens disguised as teens get home to save their planet... and ours.
408	1	The Big Green	Holly Sloan	Steve Guttenberg, Olivia d'Abo, Jay Sanders, John Terry, Chauncey Leopardi, Patrick Renna	3	87	1995	5	100 min	170	A group of bored misfits become local soccer heroes in a sleepy Texas town.
409	1	The Mighty Ducks	Stephen Herek	Emilio Estevez, Joss Ackland, Lane Smith, Heidi Kling, Josef Sommer, Joshua Jackson	3	87	1992	5	104 min	87	A hotshot lawyer reluctantly coaches a hapless pee wee hockey team.
410	1	While You Were Sleeping	Jon Turteltaub	Sandra Bullock, Bill Pullman, Peter Gallagher, Peter Boyle, Glynis Johns, Micole Mercurio	3	87	1995	5	104 min	26	A lonely subway worker is mistaken for a comatose man's finacée.
411	2	Disney A.N.T. Farm		China McClain, Sierra McCormick, Jake Short, Stefanie Scott, Carlon Jeffery	3	88	2011	6	3 Seasons	171	Chyna Sparks and her friends are the newest members of the A.N.T. program.
412	2	Into the Unknown: Making Frozen 2		Kristen Bell, Idina Menzel, Josh Gad, Jonathan Groff, Jennifer Lee, Chris Buck	3	88	2020	1	1 Season	45	For the first time, go behind-the-scenes into the making of the #1 animated film, Frozen 2.
413	1	Man in Space	Ward Kimball	Walt Disney, Dick Tufeld, Ward Kimball, Willy Ley, Dr. Heinz Haber, Dr. Wernher von Braun	3	88	1955	1	49 min	160	From the TV series Disneyland, a look at the history of space travel. See details for advisory.
414	1	Mars and Beyond	Ward Kimball	Walt Disney, Paul Frees, Dr. Ernst Stuhlinger, Dr. Wernher von Braun, Dr. E.C. Slipher	3	88	1957	6	53 min	172	An animated look at humankind's early views of the universe and life on Mars.
415	1	Marvel Studios' Avengers: Infinity War	Anthony Russo, Joe Russo	Robert Downey Jr., Chris Hemsworth, Mark Ruffalo, Chris Evans, Scarlett Johansson, Don Cheadle	3	88	2018	3	152 min	65	The Avengers must be willing to sacrifice all to defeat Thanos.
416	1	Tarzan	Kevin Lima, Chris Buck	Tony Goldwyn, Minnie Driver, Glenn Close, Alex Linz, Rosie O'Donnell, Brian Blessed	3	88	1999	2	93 min	173	Adopted by gorillas, Tarzan’s life changes forever when he meets other humans.
417	1	Tarzan II	Brian Smith	Harrison Chad, George Carlin, Brad Garrett, Ron Perlman, Estelle Harris, Glenn Close	3	88	2005	2	75 min	173	Young Tarzan decides his ape family would be better off without him.
418	2	101 Dalmatians (Series)		Jeff Bennett, Christine Cavanaugh, Tara Charendoff, Jim Cummings, Tress MacNeille, Charlotte Rae	1	89	1997	8	1 Season	5	The Dearly Family move to a new farm home in the country.
419	1	Big Sur: Wild California		Hector Elizondo	3	89	2010	1	47 min	142	Why is California's Big Sur coastline experiencing an explosion in wildlife?
420	2	Disney Junior Muppet Babies Play Date			1	89	2018	4	1 Season	174	Time for a playdate with the Muppet Babies!
421	1	Egypt's Treasure Guardians	Ben Allen, Tom Jenner	Dominic Frisby	19	89	2016	1	44 min	122	This programme follows a select cast of individuals, determined to bring Egypt back from the brink.
422	1	The Jungle Book	Jon Favreau	Bill Murray, Ben Kingsley, Idris Elba, Lupita Nyong'o, Scarlett Johansson, Giancarlo Esposito	25	89	2016	5	108 min	89	A man-cub who’s been raised by a family of wolves eludes a dangerous tiger.
423	1	The Pirate Fairy	Peggy Holmes	Mae Whitman, Christina Hendricks, Tom Hiddleston, Lucy Liu, Raven-Symoné , Megan Hilty	3	89	2014	2	78 min	62	Tinker Bell and friends face the pirates of Skull Rock to save a friend.
424	1	Trail Mix-Up	Barry Cook	Charles Fleischer, Kathleen Turner, April Winchell, Lou Hirsch, Corey Burton, Frank Welker	3	89	1993	6	9 min	73	Roger Rabbit is left to care for Baby Herman in Yellowstone National Park.
425	1	Tummy Trouble	Frank Marshall, Rob Minkoff	Charles Fleischer, April Winchell, Lou Hirsch, Corey Burton, Richard Williams, Kathleen Turner	3	89	1989	6	8 min	73	Roger Rabbit is left to babysit with the mischievous Baby Herman
426	1	Artemis Fowl	Kenneth Branagh		3	90	2020	5	96 min	175	A descendant of a long line of criminal masterminds seeks to find his father who has disappeared.
427	2	Mighty Med		Bradley Perry, Jake Short, Paris Berelc, Devan Leos	3	90	2013	8	2 Seasons	176	Check in to Mighty Med, the secret superhero hospital.
428	1	The Liberty Story	Hamilton Luske, Robert Stevenson	Walt Disney	3	90	1957	1	48 min	177	Walt Disney presents segments of America's fight for freedom. See details for advisory.
429	1	The Story of the Animated Drawing	Wilfred Jackson, William Beaudine		3	90	1955	1	49 min	160	Walt Disney discusses the history of animation. See details for advisory.
430	1	Walt & El Grupo	Theodore Thomas		3	90	2009	5	108 min	122	The U.S. Government sends Walt Disney to South America on a goodwill tour.
431	2	Alaska's Grizzly Gauntlet		Les Stroud	3	91	2018	1	1 Season	4	Survival expert Les Stroud explores the world of Alaska’s most formidable wildlife.
432	1	America's Greatest Animals		Bray Poor, Casey Anderson, Brady Barr, Andy Casagrande, Mireya Mayor	3	91	2012	1	90 min	142	Nat Geo WILD goes on a search for America's 'big five.' Can America compete with Africa's beasts?
433	1	Chasing the Equinox	Kenny Scott	Stefan Frank	1	91	2019	1	45 min	1	Ancient civilizations shared an incredible knowledge of the sun.
434	2	Howie Mandel's Animals Doing Things		Howie Mandel	3	91	2017	1	2 Seasons	178	This show combines Howie Mandel’s lovable comedic genius with clips of animals doing crazy things.
435	2	Japan: Between Earth and Sky		Bray Poor	42	91	2017	1	1 Season	15	Japan: Between Earth and Sky reveals the mystery of some the most beautiful sites in the country.
436	1	Percy Jackson & The Olympians: The Lightning Thief	Chris Columbus	Logan Lerman, Brandon T. Jackson, Alexandra Daddario, Sean Bean, Pierce Brosnan, Steve Coogan	43	91	2010	5	119 min	30	A boy discovers he's the descendant of Poseidon and must settle an on-going battle between the gods.
437	2	Secrets of Wild India		David Attenborough	19	91	2012	1	1 Season	4	'Secrets of Wild India' celebrates the diversity and drama of India's extraordinary landscapes.
438	2	The Greeks		Toby Moore	3	91	2016	1	1 Season	139	Quite simply, the Greeks created our world.
439	2	Wild Hawaii		JK Simmons	3	91	2014	1	1 Season	4	National Geographic takes us on an untamed journey to Hawaii's remarkable lands.
440	1	Women Of Impact: Changing The World		Julianna Margulies	3	91	2019	1	44 min	122	How will you make the world a better place? Hear stories of the amazing women changing our world.
441	1	Maggie Simpson in "The Longest Daycare"			3	92	2012	5	5 min	144	In this Oscar-nominated short from The Simpsons, Maggie navigates an eventful first day at daycare.
442	1	Mickey and the Seal	Charles Nichols		3	92	1948	6	7 min	18	Mickey and Pluto get into trouble with a mischievous seal.
443	2	The Evermoor Chronicles		Naomi Sequeira, Finney Cassidy, Georgia Lock, Jordan Loughran, George Sear, Georgie Farmer	25	92	2015	1	2 Seasons	179	Tara is trying to settle into a strange village.
444	1	The Moon-Spinners	James Neilson	Hayley Mills, Joan Greenwood, Michael Davis, Irene Papas, Paul Stassino, Eli Wallach	3	92	1964	5	119 min	180	A teen finds romance and searches for stolen gems during her vacation.
445	2	Disney Vampirina		Isabella Crovetti, Lauren Graham, James Van Der Beek, Jordan Davis, Wanda Sykes, Mitchell Whitfield	44	93	2017	8	2 Seasons	20	Vampirina is the new girl in town!
446	2	Doc McStuffins		Kiara Muhammad, Jaden Betts, Jess Harnell, Kimberly Brooks, Lara Miller, Loretta Devine	45	93	2011	8	5 Seasons	103	Doc McStuffins has a clinic for toys in her playhouse.
447	1	Fantastic Mr. Fox	Wes Anderson	George Clooney, Meryl Streep, Jason Schwartzman, Bill Murray, Wally Wolodarsky, Eric Anderson	5	93	2009	5	88 min	181	Mr. Fox lives a happy life until he plots the greatest chicken heist the world has ever seen.
448	1	Hello, Dolly!	Gene Kelly	Barbara Streisand, Walter Matthau, Michael Crawford, Marianne McAndrew, Danny Lockin, E.J. Peaker	3	93	1969	2	147 min	182	Matchmaker Dolly Levi orchestrates the love lives of her friends while trying to figure out her own.
449	2	Marvel's Future Avengers		英司 花輪, 一博 中谷, 康之 加瀬, 健一郎 松田, かおり 水橋, 史絵 水沢	1	93	2017	8	2 Seasons	6	Teenagers train to become superheroes.
450	1	Out	Steven Hunter	Bernadette Sullivan, Kyle McDaniel, Caleb Cabrera, Matthew Martin	3	93	2020	5	12 min	111	On an average day, Greg's life seems ordinary. But today is different - there’s magic in the air.
451	2	The Big Fib			3	93	2019	1	1 Season	183	The Big Fib is a comedy game show where a truth-seeking kid chooses between a liar and an expert.
452	1	The Boys: The Sherman Brothers' Story	Jeffrey Sherman, Gregory Sherman		3	93	2009	5	102 min	83	A journey through the lives of the prolific, award-winning songwriting duo.
453	2	It's a Dog's Life with Bill Farmer		Bill Farmer	3	94	2020	1	1 Season	4	As the voice of Goofy and Pluto, Bill Farmer crosses the country meeting dogs doing incredible work!
454	1	Maleficent: Mistress of Evil	Joachim Rønning	Angelina Jolie, Elle Fanning, Chiwetel Ejiofor, Sam Riley, Harris Dickinson, Ed Skrein	21	94	2019	5	121 min	30	The story of Disney's most iconic villain continues.
455	1	Star Wars: The Rise of Skywalker (Episode IX)	J.J. Abrams	Carrie Fisher, Mark Hamill, Adam Driver, Daisy Ridley, John Boyega, Oscar Isaac	3	95	2019	3	142 min	24	The landmark Skywalker saga comes to a conclusion.
456	1	John Carter	Andrew Stanton	Taylor Kitsch, Lynn Collins, Samantha Morton, Mark Strong, Ciarán Hinds, Dominic West	3	96	2012	3	134 min	30	A former military captain is inexplicably transported to Barsoom (Mars).
457	2	Awesome Animals			1	97	2017	1	1 Season	4	National Geographic Kids presents a natural history series just for kids.
458	2	Birth of Europe		Mark Halliley	19	97	2014	6	1 Season	184	Birth of Europe reveals the extraordinary story of how Europe has been created by Nature’s forces.
459	1	Bride of Boogedy	Oz Scott	Richard Masur, Mimi Kennedy, Tammy Lauren, David Faustino, Joshua Rudoy, Leonard Frey	3	97	1987	1	93 min	30	Mr. Boogedy returns, and will not stop until he get his revenge.
460	2	Buried Secrets Of The Bible With Albert Lin		Albert Lin	1	97	2019	1	1 Season	185	Albert Lin investigates two great stories of the Bible.
461	2	Disney Prop Culture		Daniel Lanigan	3	97	2020	1	1 Season	184	Collector Dan Lanigan reunites iconic Disney movie props with filmmakers, actors, and crew.
462	1	George of the Jungle	Sam Weisman	Brendan Fraser, Leslie Mann, Thomas Church, Richard Roundtree, Greg Cruttwell, Abraham Benrubi	3	97	1997	5	93 min	36	A baby raised by gorillas grows up to be a lovable, vine-swinging klutz.
463	1	Homeward Bound II: Lost in San Francisco	David Ellis	Robert Hays, Kim Greist, Veronica Lauren, Kevin Chevalia, Benj Thall, Max Perlich	3	97	1996	2	90 min	186	Three lost pets must navigate through San Francisco to find their way home.
464	1	Homeward Bound: The Incredible Journey	Duwayne Dunham	Robert Hays, Kim Greist, Jean Smart, Veronica Lauren, Kevin Chevalia, Benj Thall	3	97	1993	2	85 min	186	Two dogs and a cat embark on a great American journey to find their owners.
465	1	How to Play Baseball	Jack Kinney		3	97	1942	6	8 min	187	Goofy teaches you all about this all-American pastime.
466	1	In Beaver Valley	James Algar	Winston Hibler	3	97	1950	1	32 min	142	A young male beaver races to build his new family a home before winter. See details for advisory.
467	2	Lost Treasures Of Egypt		Rick Robles	19	97	2018	1	1 Season	139	An immersive, discovery-led series following teams of archaeologists in Egypt.
468	2	Love & Vets		Mallory Kasdan	3	97	2017	1	1 Season	4	We watch as doctors Will and Fran divide and conquer to treat the steady flow of claw-clad patients.
469	1	Nature's Half Acre	James Algar	Winston Hibler	3	97	1951	1	33 min	142	The strange and wonderful world that lies beneath our feet. See details for advisory.
470	2	Prairie Dog Manor		Kevin Conway	3	97	2019	1	1 Season	125	Each episode takes the audience on a first-person journey following a few of the prairie dogs.
471	1	Prowlers of the Everglades	James Algar		3	97	1953	8	32 min	10	A primeval reptile stalks its prey in "the swamp that time forgot." See details for advisory.
472	2	Secrets of the Zoo: Tampa		Dr. Ray Ball, Dr. Lauren Smith, Chris Massaro, Tiffany Burns, Mike Burns, Melinda Mendolusky	3	97	2019	1	1 Season	4	A day in the life at ZooTampa is anything but ordinary. It's extraordinary!
473	1	The Princess Bride	Rob Reiner	Cary Elwes, Mandy Patinkin, Chris Sarandon, Christopher Guest, Wallace Shawn, Andre the Giant	25	97	1987	5	99 min	36	A man regales his ailing grandson with a tale of romance and adventure in a lighthearted fairy tale.
474	2	United States Of Animals		Quincy Dunn-Baker	3	97	2015	1	1 Season	4	United States of Animals takes you on a fascinating journey across the United States.
475	2	Unlikely Animal Friends		Mark Keller	3	97	2012	6	3 Seasons	4	This series reveals the stories of unlikely duos that have struck up unusual relationships.
476	1	Water Birds	Ben Sharpsteen	Winston Hibler	3	97	1952	6	31 min	142	Experience the beauty and variety of majestic water birds. See details for advisory.
477	1	National Treasure	Jon Turteltaub	Nicolas Cage, Jon Voight, Harvey Keitel, Diane Kruger, Sean Bean, Justin Bartha	3	98	2004	5	132 min	188	A treasure hunter must steal America's most sacred and guarded document.
478	1	Born Wild: The Next Generation	Liliana Olszewski	Robin Roberts	3	99	2020	1	44 min	10	BORN WILD: THE NEXT GENERATION gives viewers a look at our planet’s next generation of baby animals.
479	2	America's Funniest Home Videos		Tom Bergeron	3	100	1989	1	9 Seasons	54	Home videos compete for cash prizes. Program is presented as originally created.
480	1	The Olympic Elk	James Algar	Winston Hibler	3	100	1952	6	27 min	142	Olympic elk trek toward the fertile grazing grounds of Mount Olympus. See details for advisory.
481	2	Tangled: The Series		Zachary Levi, Mandy Moore, Eden Espinosa, Clancy Brown	3	101	2016	8	3 Seasons	73	Rapunzel must discover the secret of her hair.
482	1	Jane Goodall: The Hope	Elizabeth Leiter, Kimberly Woodard	Jane Goodall	3	102	2020	7	89 min	59	Jane Goodall continues her lifetime of activism by continuously spreading a message of hope.
483	2	Brain Games		Neil Harris	3	103	2011	6	8 Seasons	189	Brain Games features games & experiments revealing the science of how your brain works.
484	2	Disney Mickey and the Roadster Racers - Chip 'N' Dale's Nutty Tales (Shorts)		Tress MacNeille, Corey Burton, Bret Iwan, Russi Taylor, Bill Farmer, Daniel Ross	1	103	2017	4	2 Seasons	135	Chip and Dale set off on nutty adventures!
485	1	Let's Stick Together	Jack Hannah		3	103	1952	6	7 min	18	Spike, an old honey bee, recounts working with Donald in the good ol' days.
486	1	Pluto's Purchase	Charles Nichols	Pinto Colvig, James MacDonald	3	103	1948	6	7 min	18	Pluto is in for a surprise when Mickey sends him to buy a salami. See details for advisory.
487	2	Tron Uprising		Elijah Wood, Bruce Boxleitner, Emmanuelle Chriqui, Mandy Moore, Nate Corddry, Lance Henriksen	3	104	2011	8	1 Season	5	Inside the computer world of the grid, Beck becomes the unlikely leader of a revolution.
488	1	A Celebration of the Music from Coco	Ron de Moraes	Benjamin Bratt, Eva Longoria, Carlos Rivera, Natalia Jiménez, Alanna Ubach, Jaime Camil	3	105	2020	1	48 min	190	“Coco” is brought to life on stage with musical performances at the historic Hollywood Bowl.
489	2	Disney Playtime with Puppy Dog Pals (Shorts)			1	105	2017	4	2 Seasons	38	Come play with the Puppy Dog Pals!
490	1	Maggie Simpson in "Playdate with Destiny"	David Silverman		3	105	2020	2	5 min	144	A heroic baby saves Maggie Simpson from playground peril – and steals her heart.
491	2	Paradise Islands		Michael Izqueirdo	1	105	2017	1	1 Season	4	The islands that lie between Asia and Australia can claim to be the biologically richest on earth.
492	2	Tut's Treasures: Hidden Secrets		Mark Bazeley	19	105	2018	1	1 Season	139	The pharaoh’s priceless grave goods are being reunited for the first time since their discovery.
493	1	A Tale of Two Critters	Jack Speirs	Mayf Nutter	3	106	1977	2	48 min	191	A bear cub and a raccoon become fast friends. See details for advisory.
494	1	All in a Nutshell	Jack Hannah		3	106	1949	6	7 min	18	Donald steals Chip and Dale's nuts and ends up in a lake. See details for advisory.
495	1	Disneynature Penguins	Alastair Fothergill, Jeff Wilson	Ed Helms	3	106	2019	2	77 min	142	Steve the penguin embarks on an epic quest to find love and start a family.
496	1	Diving with Dolphins	Keith Scholey	Celine Cousteau	3	106	2020	2	79 min	142	Disneynature explores the making of Dolphin Reef. Céline Cousteau narrates English-language version.
497	1	Dolphin Reef	Keith Scholey	Natalie Portman	3	106	2018	2	78 min	142	A playful young dolphin named Echo must master his vital role in the coral reef community.
498	1	Don's Fountain of Youth	Jack Hannah		3	106	1953	6	6 min	18	Donald's trick at the fountain of youth is cut short by an alligator. See details for advisory.
499	1	Donald's Dog Laundry	Jack King		3	106	1940	6	9 min	18	Donald entices Pluto to try his mechanical dog washer. See details for advisory.
500	1	Double Dribble	Jack Hannah		3	106	1946	6	8 min	187	Goofy explores the wonderful world of basketball. See details for advisory.
501	1	Dragon Around	Jack Hannah		3	106	1954	6	7 min	18	Chip and Dale defend their home against Donald's dragon-like steam shovel. See details for advisory.
502	1	Elephant	Mark Linfield	Meghan,  The Duchess of Sussex	3	106	2020	2	89 min	142	African elephant Shani and her spirited son Jomo make the epic journey of their ancestors.
503	1	Elmer Elephant	Wilfred Jaxon	Jeanie Roberts, Pinto Colvig, Hal Rees, Leone Ledoux, Carlisle Tupper, Gay Seabrook	3	106	1936	6	8 min	18	An elephant is ashamed of his trunk until he saves his friend with it. See details for advisory.
504	2	Fish Hooks		Chelsea Kane, Kyle Massey, Justin Roiland	3	106	2010	6	3 Seasons	21	Milo, Bea and Oscar are three BFFs, best fish friends.
505	1	How To Play Football	Jack Kinney	Pinto Colvig	3	106	1944	6	9 min	192	Goofy demonstrates the game of football. See details for advisory.
506	1	In the Footsteps of Elephant	Vanessa Berlowitz	Jeremy Sisto	3	106	2020	2	88 min	142	Filmmakers capture an epic journey through the Kalahari Desert for Disneynature’s “Elephant.”
507	1	Lambert, The Sheepish Lion	Jack Hannah	Sterling Holloway	3	106	1952	6	8 min	18	A mix-up finds a little lion cub in the care of a gentle flock of sheep.
508	1	On Ice	Ben Sharpsteen	Pinto Colvig, Walt Disney, Marcellite Garner	3	106	1935	6	9 min	11	Mickey and friends enjoy skating on a frozen river. See details for advisory.
509	1	Onward	Dan Scanlon	Tom Holland, Chris Pratt, Julia Louis-Dreyfus, Octavia Spencer, Mel Rodriguez, Kyle Bornheimer	3	106	2020	5	103 min	73	Two elf brothers embark on an extraordinary quest in Disney and Pixar’s ONWARD!
510	1	Out of Scale	Jack Hannah		3	106	1951	6	8 min	18	Donald declares Chip n Dale's tree "out of scale" for his train set. See details for advisory.
511	1	Penguins: Life on the Edge	Alastair Fothergill, Jeff Wilson	Blair Underwood	3	106	2020	2	78 min	142	A witty and tenacious team of filmmakers brave the Antarctic to film Disneynature’s “Penguins.”
512	1	Pluto's Party	Milt Schaffer	Jimmy MacDonald, Pinto Colvig	3	106	1952	6	8 min	18	It's Pluto's birthday party!
513	1	Sea Scouts	Dick Lundy		3	106	1939	1	8 min	18	Donald and his nephews encounter a shark. See details for advisory.
514	2	Sonny With A Chance		Demi Lovato, Tiffany Thornton, Sterling Knight, Brandon Smith, Doug Brochu, Allisyn Arm	3	106	2008	6	2 Seasons	193	A teen girl is selected from a nationwide search to join the cast of a sketch-comedy series.
515	1	The Boy Who Talked to Badgers	Gary Nelson	Carl Betz, Salome Jens, Christian Juttner, Robert Donner, Denver Pyle, Stuart Lee	3	106	1975	1	90 min	91	A young farm boy relies on the help of a badger to survive the wilderness. See details for advisory.
516	1	The New Neighbor	Jack Hannah		3	106	1953	6	7 min	18	Sparks fly when Donald moves next door to Pete and his reckless dog. See details for advisory.
517	1	The Small One	Don Bluth	Sean Marshall, William Woodson, Olan Soulé, Joe Higgins, Gordon Jump, Hal Smith	3	106	1978	1	25 min	194	A young boy discovers the true spirit of the Christmas season. See details for advisory.
518	1	The Straight Story	David Lynch	Richard Farnsworth, Sissy Spacek, Harry Stanton, Everett McGill, John Farley, Kevin Farley	46	106	1999	2	112 min	78	Story of a man who takes a six week trip on his riding lawn mower.
519	1	Captain Sparky vs. The Flying Saucers	Mark Waring	Charlie Tahan	3	107	2012	6	2 min	195	View one of Sparky's favorite home movies.
520	1	Frankenweenie	Tim Burton	Catherine O'Hara, Martin Short, Martin Landau, Charlie Tahan, Atticus Shaffer, Winona Ryder	3	107	2012	5	88 min	196	Disney presents a comic twist on a classic tale from Tim Burton.
521	1	Mars Needs Moms	Simon Wells	Seth Green, Dan Fogler, Elizabeth Harnois, Mindy Sterling, Kevin Cahoon, Joan Cusack	3	107	2011	5	91 min	62	Nine-year-old Milo sets out to save his mom when she is abducted by Martians.
522	1	Prom	Joe Nussbaum	Aimee Teegarden, Thomas McDonell, De'Vaughn Nixon, Danielle Campbell, Yin Chang, Jared Kusnitz	3	107	2011	5	105 min	114	At Prom, every couple has a story, and no two are exactly alike.
523	1	The Last Song	Julie Robinson	Miley Cyrus, Liam Hemsworth, Bobby Coleman, Nick Searcy, Kelly Preston, Greg Kinnear	3	107	2010	5	109 min	134	A rebellious daughter and her estranged father try to restore the loving relationship they once had.
524	1	The Odd Life of Timothy Green	Peter Hedges	Jennifer Garner, Joel Edgerton, Dianne Wiest, CJ Adams, Rosemarie DeWitt, Ron Livingston	3	107	2012	5	106 min	151	An unexpected surprise arrives on the doorstep of a couple who can't have children of their own.
525	2	Be Our Chef		Angela Kinsey	1	108	2020	6	1 Season	183	Angela Kinsey hosts five families in a Disney-inspired cooking competition.
526	1	A Wrinkle in Time	Ava DuVernay	Oprah Winfrey, Reese Witherspoon, Mindy Kaling, Storm Reid, Levi Miller, Deric McCabe	3	109	2018	5	112 min	89	Meg travels through time and space to find her father.
527	2	Disney I Didn't Do It		Olivia Holt, Austin North, Piper Curda, Peyton Clark, Sarah Gilman	3	110	2013	6	2 Seasons	40	Fraternal twins try to explain exactly what just happened.
528	2	Disney Insider			3	110	2020	1	1 Season	104	“Disney Insider” tells the stories behind Disney’s films, parks, destinations, toys & more.
529	2	Disney Vampirina Ghoul Girls Rock! (Shorts)		Isabella Crovetti, Jordan Davis, ViviAnn Yee, Mitchell Whitfield, Wanda Sykes, Ian Corlett	1	110	2017	8	2 Seasons	20	Rock out to music videos from The Ghoul Girls!
530	1	G-Force	Hoyt Yeatman IV	Bill Nighy, Will Arnett, Zach Galifianakis, Kelli Garner, Tyler Jones, Jack Conley	3	111	2009	5	92 min	36	Four highly trained FBI guinea pigs set out to save the world.
531	1	Frozen 2	Chris Buck, Jennifer Lee	Kristen Bell, Idina Menzel, Josh Gad, Jonathan Groff, Sterling Brown, Evan Wood	3	112	2019	5	107 min	62	Elsa journeys into the unknown to uncover truths about the past.
532	1	Stargirl	Julia Hart	Grace VanderWaal, Graham Verchere, Giancarlo Esposito, Karan Brar, Darby Stanchfield, Maximiliano Hernandez	3	113	2020	5	107 min	197	A coming-of-age story about a high schooler who finds himself drawn to the free-spirited new girl.
533	1	The Finest Hours	Craig Gillespie	Chris Pine, Casey Affleck, Ben Foster, Holliday Grainger, John Ortiz, Kyle Gallner	3	114	2016	3	119 min	198	Based on a true story of the Coast Guard’s most daring rescue.
534	1	The Sandlot: Heading Home	William Dear	Danny Nucci, Luke Perry, Keanu Pires, Sarah Deakins, Chauncey Leopardi, Brandon Olds	2	114	2007	5	97 min	170	An egotistical baseball star wakes up as a 12-year-old on his childhood playing field, the sandlot.
535	1	Bedtime Stories	Adam Shankman	Adam Sandler, Keri Russell, Guy Pearce, Russell Brand, Richard Griffiths, Jonathan Pryce	3	115	2008	5	101 min	54	A hotel handyman's bedtime stories go from fantasy to reality.
536	1	Marvel Studios' Black Panther	Ryan Coogler	Chadwick Boseman, Michael Jordan, Lupita Nyong'o, Danai Gurira, Martin Freeman, Daniel Kaluuya	3	116	2018	3	137 min	199	T’Challa battles a powerful foe when his homeland of Wakanda is threatened.
537	2	101 Dalmatian Street		Josh Brener, Michaela Dietz, Ella Kenion, Rhashan Stone	47	117	2018	8	1 Season	73	Pups Dolly and Dylan adventure to find their spots.
538	1	Disney Phineas and Ferb: Phineas and Ferb Star Wars		Vincent Martella, Ashley Tisdale, Thomas Brodie-Sangster, Caroline Rhea, Richard O'Brien, Dan Povenmire	3	117	2014	6	53 min	200	Phineas, Ferb and the gang meet some iconic Star Wars characters.
539	2	Shop Class			1	117	2020	6	1 Season	183	Teams are challenged with designing and building their very unique creations.
540	1	Viking Warrior Women	Stuart Strickson	Ella Al-Shamahi	19	117	2019	1	44 min	122	New discoveries challenge everything we thought we knew about Viking warriors.
541	2	Star Wars Resistance		Christopher Sean, Josh Brener, Scott Lawrence, Suzie McGrath, As Himself	3	118	2018	8	2 Seasons	5	Kaz begins his spy mission, but is in over his head.
542	2	Lost Cities With Albert Lin		Dr. Albert Len	3	119	2019	1	1 Season	185	This series delivers stories with hi-tech imagery to bring the mysteries of the past to life.
543	1	Marvel Rising: Operation Shuri	Chris Rutkowski	Dee Baker, Dove Cameron, Jessica DiCicco, Skai Jackson, Kathreen Khavari, Daisy Lightfoot	3	119	2019	8	23 min	173	The Secret Warriors show Shuri how to be a teenager.
544	1	Marvel Rising: Playing With Fire	Sol Choi	Dee Baker, Dove Cameron, Gary Cole, Kathreen Khavari, Meera Kumbhani, Tony Mirrcandani	3	119	2019	8	45 min	173	The Secret Warriors help Inferno recover his powers.
545	2	Star Wars: The Clone Wars		Tom Kane, Matt Lanter, Ashley Eckstein, James Arnold Taylor, Dee Baker, Corey Burton	3	119	2008	1	7 Seasons	81	The saga continues, set in a faraway galaxy!
546	1	Marvel's Iron Man & Hulk: Heroes United	Leo Riley	Adrian Pasdar, Fred Tatasciore, David Kaye, Dee Baker, Robin Downes	3	120	2013	5	74 min	81	Avengers Iron Man and Hulk team up to fight an energy-devouring monster.
547	1	Because of Winn-Dixie	Wayne Wang	Jeff Daniels, Cicely Tyson, Dave Matthews, Eva Saint, AnnaSophia Robb	3	121	2005	5	107 min	152	A heartwarming tale of a girl whose life is changed by a scruffy, fun-loving pooch named Winn-Dixie.
548	2	Fairy Tale Weddings		Stephen Boss, Allison Holker	3	121	2017	1	2 Seasons	201	A behind-the-scenes look at Disney's magical weddings.
549	1	My Dog, the Thief	Robert Stevenson	Dwayne Hickman, Mary Mobley, Elsa Lanchester, Joe Flynn, Roger Carmel, Mickey Shaughnessy	3	121	1969	1	89 min	36	A St. Bernard lifts a million-dollar necklace from a team of jewel thieves.
550	1	Splash	Ron Howard	Tom Hanks, Daryl Hannah, Eugene Levy, John Candy, Dody Goodman, Shecky Greene	3	121	1984	1	110 min	202	Allen Bauer (Tom Hanks) is rescued at sea by the mermaid of his dreams.
551	2	That's So Raven		Raven , Orlando Brown, Kyle Massey, Anneliese van der Pol, T’Keyah Keymáh, Rondell Sheridan	3	122	2002	6	4 Seasons	31	Raven Baxter is a typical teenager who just happens to be psychic.
552	1	Timmy Failure: Mistakes Were Made	Tom McCarthy	Winslow Fegley, Ophelia Lovibond, Craig Robinson, Wallace Shawn, Kyle Bornheimer, Chloe Coleman	3	123	2020	5	103 min	203	“Timmy Failure” follows the hilarious exploits of a boy who operates a Portland detective agency.
553	1	Toy Story 4	Josh Cooley	Tom Hanks, Tim Allen, Annie Potts, Tony Hale, Keegan-Michael Key, Madeleine McGraw	3	124	2019	2	101 min	73	Pixar Animation Studios proudly presents the adventure of a lifetime!
554	1	Descendants 3	Kenny Ortega	Dove Cameron, Cameron Boyce, Sofia Carson, Booboo Stewart, Mitchell Hope, Sarah Jefferey	3	125	2019	6	109 min	156	A barrier breach jeopardizes the safety of Auradon.
555	1	Around the World in 80 Days	Frank Coraci	Jackie Chan, Steve Coogan, Cécile de France, Jim Broadbent, Ewan Bremner, Ian McNeice	48	126	2004	5	121 min	36	Phileas Fogg tries to beat the clock in a race around the world.
556	1	Big Business	Jim Abrahams	Bette Midler, Lily Tomlin, Fred Ward, Edward Herrmann, Michele Placido, Daniel Gerroll	3	126	1988	5	98 min	16	Two sets of identical twins, mismatched at birth, cross paths years later.
557	1	Lamp Life	Valerie LaPointe	Annie Potts, Jim Hanks, Ally Maki, Emily Davis	3	127	2020	6	11 min	11	Lamp Life answers the question of what happened to Bo Peep since we last we saw her in Toy Story 2.
558	1	The Lion King	Jon Favreau	Donald Glover, Seth Rogen, Chiwetel Ejiofor, Alfre Woodard, Billy Eichner, John Kani	49	128	2019	5	125 min	130	Disney’s The Lion King comes to life in a whole new way.
559	2	Diary of a Future President		Tess Romero, Selenis Leyva, Charlie Bushnell, Michael Weaver	3	129	2020	1	2 Seasons	19	Elena Cañero-Reed will one day become the U.S. President, but for now, she’s in middle school.
560	2	High School Musical: The Musical: The Series: The Sing-Along		Olivia Rodrigo, Joshua Bassett, Matt Cornett, Sofia Wylie, Larry Saperstein	1	129	2019	1	1 Season	114	Sing along as the East High Wildcats put on a production of High School Musical: The Musical!
561	2	America's National Parks		C.T. Taylor	3	130	2015	7	1 Season	15	Experience the breathtaking landscapes and majestic animals of eight U.S. National Parks.
562	2	Continent 7: Antarctica		Chris Browning	3	130	2016	1	1 Season	12	Experience how science is conducted as scientists and survival experts join forces in Antarctica.
563	2	Disney Randy Cunningham: 9th Grade Ninja		Ben Schwartz, Andrew Caldwell, Tim Curry, John DiMaggio, Kevin Richardson, Dave Wittenberg	50	130	2011	8	2 Seasons	73	Randy is an average freshman until he is chosen as The Ninja.
564	2	Muppet Babies Show and Tell (Shorts)		Matt Danner, Melanie Harrison, Ben Diskin, Eric Bauza, Dee Baker, Jessica DiCicco	1	130	2017	8	1 Season	38	It's Show and Tell time in the playroom!
565	2	The Lodge		Sophie Simnett, Luke Newton, Thomas Doherty, Bethan Wright, Jayden Revri, Jade Alleyne	19	130	2016	6	2 Seasons	197	A city girl starts a new life in the country.
566	2	Wild Russia		Liam Teeling	1	130	2018	1	1 Season	15	From mountains to desert, volcanoes to ice, explore Russia’s scenic beauty and iconic wildlife.
567	1	Destino	Monfery Dominique	Dora Luz	51	131	2003	5	6 min	204	A collaboration begun in 1945 by Salvador Dalí and Walt Disney.
568	1	Forky Asks a Question: What is Reading?	Bob Peterson	Tony Hale, Addison Andrews, Mila Crespo, Imani Prior, Jeff Pidgeon, Bob Peterson	3	131	2020	6	7 min	11	The energetic Peas-n-a-Pod siblings teach Forky about reading, with a little help from Mr. Spell.
569	1	Loop	Erica Milsom	Madison Bandy, Christiano Delgado, Louis Gonzales, Asher Brodkey, Erica Milsom	3	131	2020	5	12 min	18	Adrift on a lake, two kids with different ways of communicating attempt to connect.
570	2	Marvel's Runaways		Rhenzy Feliz, Lyrica Okano, Virginia Gardner, Ariela Barer, Gregg Sulkin, Allegra Acosta	3	131	2017	7	3 Seasons	205	Six kids learn their parents hide a terrible secret.
571	1	Aladdin (2019)	Guy Ritchie	Will Smith, Mena Massoud, Naomi Scott, Marwan Kenzari, Navid Negahban, Nasim Pedrad	3	132	2019	5	135 min	30	From Disney comes the thrilling live-action adaptation of Aladdin.
572	1	Forky Asks a Question: What is Cheese?	Bob Peterson	Tony Hale, Jeff Garlin, Bob Peterson	3	133	2020	6	6 min	11	Buttercup, annoyed with all of Forky’s questions, speed teaches everything there is.
573	2	Austin & Ally		Ross Lynch, Laura Marano, Raini Rodriguez, Calum Worthy	3	134	2011	6	4 Seasons	86	Austin, a musician, and Ally, a songwriter, form a team.
574	2	Billy Dilley's Super-Duper Subterranean Summer		Aaron Springer, Catherine Wayne, Tom Kenny	3	134	2016	8	1 Season	206	Billy and his friends get stuck inside Earth's core.
575	1	Cars Toon: El Materdor	John Lasseter	Larry the Cable Guy , Keith Ferguson	3	134	2008	6	4 min	11	Mater is a famous bulldozer fighter in Spain.
576	1	Cars Toon: Moon Mater	Rob Gibbs	Larry the Cable Guy , Keith Ferguson, Josh Cooley	3	134	2010	6	4 min	11	Mater’s mission on the moon: rescue the Impala XIII.
577	1	Cars Toon: Rescue Squad Mater	John Lasseter	Larry the Cable Guy , Keith Ferguson, Bret Parker, Peter Sohn, Bob Peterson, Bob Scott	3	134	2010	8	3 min	11	Mater is a fire truck that rescues McQueen from a fire
578	1	Cars Toon: Spinning	Jeremy Lasky	Keith Ferguson, Paul Dooley, Tony Shalhoub, Lloyd Sherr, Michael Wallis, Guido Quaroni	3	134	2013	6	2 min	18	Guido discovers his talent as a sign spinner.
579	1	Cars Toon: Time Travel Mater	Rob Gibbs	Larry the Cable Guy , Keith Ferguson, John Higgins, Katherine Helmond	3	134	2012	6	7 min	11	Mater travels back in time to 1909.
580	1	Cars Toon: Tokyo Mater	John Lasseter	Larry the Cable Guy , Keith Ferguson, Michael Wallis, Mach Kobayashi, Robert Ito	3	134	2008	2	8 min	11	Mater is in Tokyo, where he is challenged to a race.
581	1	Cars Toon: Unidentified Flying Mater	John Lasseter	Larry the Cable Guy , Keith Ferguson	3	134	2010	8	4 min	11	Mater and Lightning McQueen rescue a UFO named Mator.
582	1	Cars Toons: Bugged	Jeremy Lasky	Jerome Ranft, Josh Cooley	3	134	2013	6	2 min	18	Red's peaceful morning routine is interrupted by a pesky visitor.
583	1	Cool Runnings	Jon Turteltaub	Leon , Doug Doug, Rawle Lewis, Malik Yoba, Raymond Barry, Larry Gilman	3	134	1993	5	99 min	207	Based on the true story of Jamaican bobsledders at the Winter Olympics.
584	1	Drain Alcatraz	Wayne Abbott	Craig Sechler, Russell Boulter	3	134	2017	1	47 min	1	Draining the waters around Alcatraz reveals the infamous prison’s deepest secrets.
585	1	Drain The Bermuda Triangle	Jobim Sampson	Russell Boulter	3	134	2014	1	45 min	1	Explore the Bermuda Triangle by draining the water to see what lies beneath the surface.
586	1	Drain The Great Lakes	Crispin Sadler, Wayne Abbott	Cham Giobbi	43	134	2011	1	45 min	1	This groundbreaking television program pulls a virtual plug on the huge lakes.
587	1	Drain The Ocean: WWII	Mike Slee	Russell Boulter	3	134	2016	1	44 min	122	New undersea surveys and 3-D imaging reveal secrets of World War II shipwrecks.
588	1	Drain The Sunken Pirate City	Sophie Harris	Russell Boulter	19	134	2017	7	48 min	122	Hidden beneath Jamaica’s Kingston Harbour lie the ruins of the biggest pirate city of all time.
589	1	Drain The Titanic	Jobim Sampson	Russell Boulter	43	134	2015	1	45 min	122	We reveal the most famous ship wreck site by virtually draining the Titanic.
590	2	First Class Chefs: Family Style		Gia Ré, Matt Tebbutt	1	134	2015	8	1 Season	183	First Class Chefs: Family Style is a cooking competition for the whole family!
591	1	Hacksaw	Larry Lansburgh	Tab Hunter, Victor Millan, Ray Teal, Russ McCubbin, George Barrows, Christine Austin	3	134	1971	1	89 min	208	A wilderness guide sets out to catch a legendary wild horse. See details for advisory.
592	1	Holes	Andrew Davis	Sigourney Weaver, Jon Voight, Patricia Arquette, Tim Nelson, Dulé Hill, Shia LaBeouf	3	134	2003	5	119 min	166	The Yelnats family curse lands young Stanley at Camp Green Lake.
593	1	Marvel 75 Years: From Pulp to Pop!	Zak Knutson	Laura Shields, Stan Lee, Alan Fine, Nicole Perlman, Jimmy Kimmel, Gerry Conway	3	134	2014	1	42 min	160	See how Marvel became the top super hero storyteller in special interviews.
594	1	Marvel Rising: Battle of The Bands		Dee Baker, Dove Cameron, Skai Jackson, Kathreen Khavari, Kamil McFadden, Tyler Posey	3	134	2019	8	23 min	209	Gwen (Ghost-Spider) has to defeat Screaming Mimi both on the streets and on the stage.
595	2	One Strange Rock		Will Smith	3	134	2017	1	1 Season	4	Hosted by Will Smith, One Strange Rock reveals the twists of fate that allow life to thrive on Earth
596	2	Out There with Jack Randall		Jack Randall	1	134	2019	7	1 Season	12	Zoologist Jack Randall searches for dangerous animals in the most unforgiving environments on earth.
597	1	Super Rhino	Nathan Greno	Miley Cyrus, Mark Walton, Susie Essman, Malcolm McDowell, Randy Savage	3	134	2009	2	4 min	73	Rhino gets an upgrade just in time to save Bolt and Penny from Dr. Calico.
598	2	The Proud Family		Tommy Davidson, Paula Parker, Jo Payton, Kyla Pratt, Tara Strong, Karen White	3	134	2001	6	2 Seasons	21	Follow the adventures of Penny, a typical African American girl navigating through teen-dom.
599	2	The Super Hero Squad		Grey DeLisle, Steve Blum, Mikey Kelly, Charlie Adler, Mark Hamill, Tom Kenny	3	134	2009	8	2 Seasons	73	The greatest heroes on the planet unite to face the greatest villains in the Super Hero Squad.
600	2	Year Million		Laurence Fishburne	3	134	2016	1	1 Season	210	Explore what human life might be like, one million years into the future.
601	1	Forky Asks a Question: What is a Pet?	Bob Peterson	Tony Hale, Aloma Wright, Bob Peterson	3	135	2019	6	7 min	11	Forky meets Rib Tickles, and is schooled on the dangers of law enforcement.
602	1	Star Wars: The Last Jedi (Episode VIII)	Rian Johnson	Mark Hamill, Carrie Fisher, Adam Driver, Daisy Ridley, John Boyega, Oscar Isaac	3	136	2017	3	152 min	23	New heroes and galactic legends join to unlock mysteries of the Force.
603	1	Forky Asks a Question: What is a Leader?	Bob Peterson	Tony Hale, Bonnie Hunt, Bob Peterson	3	137	2019	6	6 min	11	Dolly teaches Forky about the qualities of a good leader, and he puts those qualities to the test!
604	1	George of the Jungle 2	David Grossman	Thomas Church, Julie Benz, Christina Pickles, Angus Jones, Kelly Miller, John Kassir	52	137	2003	5	89 min	36	George must rescue his family, then save the jungle from becoming mulch.
605	1	High School Musical: The Musical: The Series: The Special	Clayton Cogswell	Joshua Bassett, Olivia Rodrigo, Sofia Wylie, Matt Cornett, Dara Renee	3	137	2019	6	23 min	211	An exclusive look into the making of High School Musical: The Musical: The Series.
606	2	Pick of the Litter			3	137	2019	1	1 Season	4	Watch an adorable group of six dogs on their quest to become guides for Guide Dogs for the Blind.
607	1	Togo	Ericson Core	Willem Dafoe, Julianne Nicholson, Christopher Heyerdahl, Richard Dormer, Michael Greyeyes, Michael McElhatton	3	137	2019	5	117 min	186	An exhilarating and uplifting adventure set in the winter of 1925 of one man and his lead sled dog.
608	1	Forky Asks a Question: What is a Computer?	Bob Peterson	Tony Hale, Kristen Schaal, James Brinkley, Bob Peterson	3	138	2019	6	6 min	11	Trixie explains to Forky what a computer does as they experience the common stresses of technology.
609	1	Wind	Edwin Chang	Emilio Fuentes, Sonoko Konishi	3	138	2019	2	9 min	111	Trapped deep down an endless chasm, a grandmother and boy seek to escape to a better life.
610	1	Forky Asks a Question: What is Love?	Bob Peterson	Tony Hale, Carl Reiner, Mel Brooks, Carol Burnett, Betty White, Kristen Schaal	3	139	2019	6	7 min	11	Forky tries to understand the idea of love from some elder toys who think they’ve experienced it.
611	2	One Day at Disney (Shorts)			1	139	2019	1	1 Season	146	Meet the diverse group of people behind some of Disney’s most magical stories.
612	1	Marvel Studios' Thor: Ragnarok	Taika Waititi	Chris Hemsworth, Tom Hiddleston, Cate Blanchett, Idris Elba, Jeff Goldblum, Tessa Thompson	3	140	2017	3	132 min	212	Thor races against time to ensure that Asgard does not fall into the Hela's ruthless hands.
613	2	Disney The Lion Guard		Max Charles, Diamond White, Dusan Brown, Atticus Shaffer, Joshua Rush	3	141	2015	4	3 Seasons	73	The Lion Guard has assembled and now they will DEFEND!
614	1	One Day at Disney	Fritz Mitchell		3	141	2019	1	62 min	160	Discover the inspiring personal stories of the people behind the enduring magic of Disney.
615	2	Disney Star vs. the Forces of Evil		Eden Sher, Adam McArthur	3	142	2014	8	4 Seasons	73	Star battles villains throughout the multiverse.
616	1	Expedition Amelia	Chad Cohen	Allison Janney, Bob Ballard, Fredrik Hiebert	3	142	2019	1	94 min	213	Dr. Robert Ballard plans an expedition to solve the mystery of Amelia Earhart’s disappearance.
617	1	Glory Road	James Gartner	Josh Lucas, Derek Luke, Jon Voight, Austin Nichols, Evan Jones, Schin Kerr	3	142	2006	5	119 min	129	The story of the first all African-American college basketball team.
618	2	Henry Hugglemonster		Lara Miller, Tom Kenny, Chiara Zanni, Lori Alan, Hynden Walch, Kari Wahlgren	53	142	2012	4	2 Seasons	20	Hugglemonsters always find a way!
619	1	Incredible! The Story of Dr. Pol		Ari Rubin, Dr. Pol	1	142	2015	7	44 min	44	Dr. Pol shares his life story – from his wartime childhood to a love story fit for the movies.
620	1	Marvel Rising: Chasing Ghosts		Dee Baker, Chloe Bennet, Dove Cameron, Skai Jackson, Kathreen Khavari, Kamil McFadden	3	142	2019	9	24 min	209	Ghost-Spider teams up with the Secret Warriors.
621	1	Marvel Rising: Heart of Iron		Dee Baker, Chloe Bennet, Dove Cameron, Robbie Daymond, Kathreen Khavari, Daisy Lightfoot	3	142	2019	8	46 min	173	Ironheart joins the Secret Warriors to defend Earth.
622	2	Miles From Tomorrowland		Olivia Munn, Cullen McCarthy, Fiona Bishop, Dee Baker, Tom Kenny	1	142	2014	4	2 Seasons	5	Blastastic! Join Miles and his family in outer space!
623	2	Sheriff Callie's Wild West		Mandy Moore, Lucas Grabeel	54	142	2011	4	2 Seasons	60	Come and see how the West was fun with Sheriff Callie!
624	2	Supercar Megabuild		Dom Joly	3	142	2016	1	2 Seasons	214	A team of top car mechanics create awesome supercar megabuilds.
625	1	The Incredible Dr. Pol: Blue Ribbon Kids		Ari Rubin, Dr. Pol	1	142	2016	1	42 min	142	It’s a best-of-the-kids compilation episode with the world’s most famous veterinarian.
626	1	Coco	Lee Unkrich	Anthony Gonzalez, Gael Bernal, Benjamin Bratt, Alanna Ubach, Renée Victor, Jaime Camil	3	143	2017	5	105 min	111	Miguel journeys to the magical land of his ancestors.
627	1	Coco (in Spanish)	Lee Unkrich	Anthony Gonzalez, Gael García Bernal, Benjamin Bratt, Alanna Ubach, Renée Victor, Jaime Camil	1	143	2017	5	105 min	111	Miguel journeys to the magical land of his ancestors.
628	1	Forky Asks a Question: What is Time?	Bob Peterson	Tony Hale, Wallace Shawn, Alan Oppenheimer, Bob Peterson	3	143	2019	6	6 min	11	Rex uses the age of dinosaurs as an example to give Forky an understanding of the concept of time.
629	1	The Wonderful World of Disney Presents The Little Mermaid Live!	Hamish Hamilton	Auli'i Cravalho, Queen Latifah, Shaggy , John Stamos, Graham Phillips, Amber Riley	3	144	2019	1	84 min	215	Live musical performances by a star-studded cast are interwoven into the original feature film.
630	1	Forky Asks a Question: What is Art?	Bob Peterson	Tony Hale, Robin Downes, Bob Peterson	3	145	2019	6	7 min	11	Mr. Pricklepants tells Forky about the complexities of being an actor and the art of performance.
631	2	Mickey Mouse Roadster Racers		Bret Iwan, Russi Taylor, Bill Farmer, Daniel Ross, Tress MacNeille	1	146	2017	4	2 Seasons	52	The Sensational Six race roadsters around the world!
632	1	Happy Birthday, Mickey!			1	147	2019	6	2 min	216	Celebrating Mickey, the world’s most beloved character.
633	1	Forky Asks a Question: What is a Friend?	Bob Peterson	Tony Hale, John Ratzenberger, Bob Peterson	3	148	2019	6	6 min	11	Forky shares his thoughts on what makes a good friend based on his limited exposure to the world.
634	1	10 Things I Hate About You	Gil Junger	Heath Ledger, Julia Stiles, Joseph Gordon-Levitt, Larisa Oleynik, David Krumholtz, Andrew Keegan	3	149	1999	3	98 min	193	Cameron falls for the girl of his dreams, but she is forbidden to date.
635	1	101 Dalmatians	Wolfgang Reitherman, Hamilton Luske, Clyde Geronimi	Rod Taylor, J. Pat O'Malley, Betty Gerson, Cate Bauer, Ben Wright, Fred Worlock	3	149	1961	2	81 min	62	Cruella De Vil dognaps all of the Dalmatian puppies in London.
636	1	101 Dalmatians II: Patch's London Adventure	Jim Kammerud, Brian Smith	Barry Bostwick, Jason Alexander, Martin Short, Bobby Lockwood, Susanne Blakeslee, Samuel West	3	149	2003	2	77 min	93	Pongo and Perdita's pup Patch gets the chance to meet his TV hero.
637	1	102 Dalmatians	Kevin Lima	Glenn Close, Ioan Gruffudd, Alice Evans, Tim McInnerny, Ian Richardson, Gérard Depardieu	5	149	2000	2	104 min	186	Oddball, the spotless Dalmatian puppy, heads out in search of his spots.
638	1	12 Dates of Christmas	James Hayman	Amy Smart, Mark-Paul Gosselaar, Peter MacNeil, Mary Long, Jayne Eastwood, Laura Miyata	3	149	2011	1	88 min	54	Setup on a Christmas Eve date, a woman must relive the date over and over.
639	1	20,000 Leagues Under the Sea	Richard Fleischer	Kirk Douglas, James Mason, Paul Lukas, Peter Lorre, Robert Wilke, Ted de Corsia	3	149	1954	2	127 min	24	Climb aboard the Nautilus and into an undersea world of adventure! See details for advisory.
640	1	A Bug's Life	John Lasseter	Dave Foley, Kevin Spacey, Julia Louis-Dreyfus, Hayden Panettiere, Phyllis Diller, Richard Kind	3	149	1998	2	98 min	11	Flik goes in search of warriors to help battle the villainous grasshoppers.
641	1	A Goofy Movie	Kevin Lima	Bill Farmer, Jason Marsden, Jim Cummings, Kellie Martin, Rob Paulsen, Wallace Shawn	55	149	1995	2	81 min	73	Goofy and Max hit the road and get up to their floppy ears in misadventure.
642	1	A Kid in King Arthur's Court	Michael Gottlieb	Thomas Nicholas, Joss Ackland, Art Malik, Paloma Baeza, Kate Winslet, Daniel Craig	56	149	1995	5	90 min	56	A mysterious earthquake sends a teenage boy back into medieval times.
643	1	A Knight for a Day	Jack Hannah		3	149	1946	6	7 min	11	Goofy jousts for the hand of Penelope, as well as the championship. See details for advisory.
644	1	A Ring of Endless Light	Greg Beeman	Mischa Barton, Ryan Merriman, Jared Padalecki, Scarlett Pomers, Soren Fulton, Chris Kirby	3	149	2002	6	88 min	3	Teenager Vicky Austin discovers that she can communicate with dolphins.
645	1	Aladdin (1992)	Ron Clements, John Musker	Scott Weinger, Robin Williams, Linda Larkin, Jonathan Freeman, Frank Welker, Gilbert Gottfried	3	149	1992	2	94 min	62	Aladdin, Princess Jasmine and Genie join forces to stop evil Jafar.
646	1	Aladdin and the King of Thieves	Tad Stones	Val Bettin, Jim Cummings, Gilbert Gottfried, Linda Larkin, Jerry Orbach, John Rhys-Davies	3	149	1996	2	86 min	62	Aladdin and Jasmine plan their wedding…but will the Forty Thieves ruin it?
647	1	Aladdin: The Return of Jafar	Toby Shelton, Tad Stones, Alan Zaslove	Jason Alexander, Jeff Bennett, Val Bettin, Liz Callaway, Dan Castellaneta, Jim Cummings	3	149	1994	2	71 min	62	Aladdin and his friends defend Agrabah from Jafar's malice.
648	1	Alice in Wonderland	Clyde Geronimi, Hamilton Luske, Wilfred Jackson	Ed Wynn, Richard Haydn, Sterling Holloway, Jerry Colonna, Verna Felton, Pat O'Malley	3	149	1951	2	79 min	62	Join Alice as she chases the White Rabbit into a topsy-turvy world.
649	1	Aliens of the Deep	James Cameron, Steven Quale	Dr. Anatoly Sagalevitch, Genya Chernaiev, Victor Nischeta, Dr. Pamela Conrad, Dr. Arthur Lane, Dr. Jim Childress	3	149	2005	2	100 min	217	James Cameron teams up with NASA scientists to explore undersea life.
650	1	Alley Cats Strike!	Rod Daniel	Kyle Schmid, Robert Ri'chard, Kaley Cuoco, Mimi Paley, Joey Wilcots, Philip Williams	2	149	2000	6	87 min	218	Four outcast teens with a love of bowling are thrust into the spotlight.
651	1	Almost Angels	Steve Previn	Vincent Winter, Sean Scully, Peter Weck, Hans Holt, Bruni Löbel, Fritz Eckhardt	3	149	1962	1	90 min	166	A working-class youth tries to fit in when with the famed Vienna Boys' Choir.
652	1	America's Heart & Soul	Louie Schwartzberg	George Woodard, Charles Jimmie Sr., The Brothers, Frank Pino, Dave Pino, John Yacobellis	3	149	2004	5	88 min	160	Journey across the U.S. to meet ordinary people living extraordinary lives.
653	1	Amy	Vincent McEveety	Jenny Agutter, Barry Newman, Kathleen Nolan, Chris Robinson, Lou Fant, Margaret O'Brien	3	149	1981	2	100 min	219	A young woman takes a job as a teacher in a backwoods school for the deaf.
758	2	Disney K.C. Undercover		Zendaya , Veronica Dunne, Kamil McFadden, Tammy Townsend, Kadeem Hardison	3	149	2014	8	3 Seasons	90	K.C. joins her spy family as its newest secret agent.
654	1	An Extremely Goofy Movie	Douglas McCarthy	Bill Farmer, Jason Marsden, Jeff Bennett, Jim Cummings, Brad Garrett, Vicki Lewis	52	149	2000	2	81 min	11	Goofy shows up to finish college alongside his son Max.
655	2	Andi Mack		Peyton Lee, Joshua Rush, Sofia Wylie, Asher Angel, Lilan Bowden, Lauren Tom	3	149	2016	6	3 Seasons	114	Andi's life is shaken by her sister, Bex's, surprise.
656	1	Annie	Rob Marshall	Kathy Bates, Alan Cumming, Audra McDonald, Kristin Chenoweth, Victor Garber, Vic Polizos	3	149	1999	1	91 min	220	Annie escapes a “hard-knock life” and finds a bighearted billionaire.
657	1	Apollo: Missions To The Moon	Tom Jennings	Neil Armstrong, Buzz Aldrin	3	149	2019	1	95 min	165	With rare archival footage, this film sheds new light on an incredible time in human history.
658	1	Atlantis Rising	Simcha Jacobovici	Georgeos Diaz-Montexano, Peter Vincenti, Richard Freund, Simcha Jacobovici, Charles Pellegrino, Félix Rodrigues	12	149	2017	1	94 min	122	Filmmakers go in search of Atlantis using Plato's writings as a guide to lead the way.
659	1	Atlantis: Milo's Return	Tad Stones, Toby Shelton, Victor Cook	James Taylor, Cree Summer, John Mahoney, Jacqueline Obradors, Don Novello, Corey Burton	3	149	2003	2	83 min	62	Explorers emerge from below the sea to solve threatening mysteries above.
660	1	Atlantis: The Lost Empire	Gary Trousdale, Kirk Wise	Michael Fox, James Garner, Cree Summer, Don Novello, Phil Morris, Claudia Christian	3	149	2001	5	98 min	62	Brave explorers venture under the sea seeking legendary Atlantis.
661	1	Auntie Edna	Ted Mathot	Brad Bird, Eli Fucile, Maeve Andrews, Nick Bird, Noelle Zuber, Craig Nelson	3	149	2018	6	7 min	11	Has famous fashionista Edna Mode met her match in Jack-Jack?
662	1	Avatar	James Cameron	Sam Worthington, Zoë Saldana, Sigourney Weaver, Stephen Lang, Michelle Rodriguez, Giovanni Ribisi	3	149	2009	3	162 min	23	A man embarks on an adventure to an exotic world that he learns to call home & fights to protect.
663	1	Babes in the Woods	Burt Gillett		3	149	1932	8	8 min	111	Two children wander the forest and get lured into a witch's house. See details for advisory.
664	1	Babes in Toyland	Jack Donohue	Ray Bolger, Tommy Sands, Annette Funicello, Ed Wynn, Tommy Kirk, Kevin Corcoran	3	149	1961	1	106 min	117	Villainous Barnaby tries to spoil Tom Piper and Mary Contrary's wedding.
665	1	Bambi	David Hand		3	149	1942	2	72 min	221	Bambi sets off with his best friends to explore the wonders of the woods.
666	1	Bambi II	Brian Pimental	Patrick Stewart, Alexander Gould, Keith Ferguson, Brendon Baerg, Nicky Jones, Andrea Bowen	3	149	2006	2	75 min	222	Bambi reunites with his father, The Great Prince.
667	1	Bao	Domee Shi		2	149	2018	2	8 min	111	A Chinese mom’s life changes when her dumpling comes alive.
668	1	Beach Picnic	Clyde Geronimi		3	149	1939	6	9 min	11	Donald Duck and Pluto are at the beach. See details for advisory.
669	1	Bearly Asleep	Jack Hannah		3	149	1955	1	7 min	11	Donald Duck is a ranger and puts the bears to sleep for the winter. See details for advisory.
670	1	Beauty and the Beast: Belle's Magical World	Bob Kline	Robby Benson, Paige O'Hara, David Stiers, Jerry Orbach, Jeff Bennett, Jim Cummings	3	149	1998	2	71 min	223	In three short stories, see Belle make a gloomy castle fit for a princess.
671	1	Beauty and the Beast: The Enchanted Christmas	Andy Knight	Paige O'Hara, Robby Benson, Jerry Orbach, David Stiers, Bernadette Peters, Tim Curry	15	149	1997	2	73 min	111	Former composer Forte threatens to keep Belle and Beast apart forever.
672	1	Beezy Bear	Jack Hannah		3	149	1955	6	7 min	11	Donald tries to catch the bear that is stealing his honey. See details for advisory.
673	1	Before the Flood	Fisher Stevens	Leonardo DiCaprio, John Kerry, Barack Obama, Bill Clinton	3	149	2016	7	96 min	1	Leonardo DiCaprio searches for answers on the issue of climate change.
674	1	Benji the Hunted	Joe Camp	Red Steagall, Frank Inn, Nancy Francis, Mike Francis, Joe Camp, Steve Zanolini	3	149	1987	2	89 min	186	Benji must navigate the wilderness while caring for orphaned cougar cubs.
675	2	Best Friends Whenever		Lauren Taylor, Shelby Bender, Gus Kamp, Ricky Garcia, Benjamin Royer, Matthew Royer	3	149	2015	6	2 Seasons	147	Best friends gain the ability to travel through time!
676	2	Big City Greens (Shorts)			1	149	2017	8	1 Season	73	Head to the big city with the Green family!
677	1	Big Hero 6	Don Hall, Chris Williams	Scott Adsit, Ryan Potter, Daniel Henney, T. J. Miller, Jamie Chung, Damon Wayans Jr.	3	149	2014	5	105 min	62	A boy genius and his robot team up to save their city.
678	2	Big Hero 6 The Series (Shorts)			1	149	2017	8	2 Seasons	73	The team introduces Baymax to everyday activities.
679	1	Bizarre Dinosaurs	Jenny Kubo	Peter Cullen	3	149	2009	1	46 min	142	Which dinosaurs were the strangest of the strange, and how did they get that way?
680	1	Blank Check	Rupert Wainwright	Brian Bonsall, Karen Duffy, Miguel Ferrer, James Rebhorn, Tone Lōc, Jayne Atkinson	3	149	1994	5	94 min	40	An 11-year-old cashes a blank check for a million bucks, with wild results.
681	1	Boat Builders	Ben Sharpsteen		3	149	1938	6	8 min	11	Mickey and friends build a boat but it falls apart when christened. See details for advisory.
682	1	Bolt	Chris Williams, Byron Howard	John Travolta, Miley Cyrus, Susie Essman, Mark Walton, Malcolm McDowell, James Lipton	3	149	2008	5	98 min	73	Hollywood's smallest star embarks on a paws-itively awesome adventure!
683	1	Bone Bandit	Charles Nichols		3	149	1948	6	7 min	11	Pluto's efforts to dig up a bone are frustrated by his allergy. See details for advisory.
684	2	Bonkers		Charlie Adler, Corey Burton, Jesse Corti, Jim Cummings, Frank Welker, Gregg Berger	57	149	1993	6	1 Season	110	A washed-up cartoon star begins a new life as the first toon cop in Hollywood.
685	1	Boundin'	Bud Luckey	Bud Luckey	3	149	2004	2	6 min	224	The musical story of a dancing sheep.
686	2	Boy Meets World		Ben Savage, William Daniels, Betsy Randle, Will Friedle, Rider Strong, Lee Norris	3	149	1993	1	7 Seasons	19	Adolescent Cory Matthews grows up, and faces problems with friends, family, and school.
687	1	Brave	Mark Andrews, Brenda Chapman	Kelly Macdonald, Billy Connolly, Emma Thompson, Julie Walters, Robbie Coltrane, Kevin McKidd	5	149	2012	5	94 min	225	Princess Merida must undo a beastly curse before it’s too late.
688	1	Brave Little Toaster to the Rescue	Robert Ramirez	Deanna Oliver, Tim Stack, Jon Lovitz, Thurl Ravenscroft, Phil Hartman, Jay Mohr	3	149	1999	6	75 min	93	The gang tries to save their animal pals from being sent to a testing lab.
1028	2	My Friends Tigger & Pooh		Jim Cummings	3	149	2006	4	2 Seasons	38	Pooh, Tigger, and friends from the Hundred Acre Wood welcome new neighbors
689	1	Breaking2	Martin Roe	Lelisa Desisa, Eliud Kipchoge, Zersenay Tadese	3	149	2017	1	55 min	150	Three of the world’s most elite distance runners set out to break the 2-hour marathon barrier.
690	1	Brink!	Greg Beeman	Erik von Detten, Sam Horrigan, Christina Vidal, Robin Riker, Geoffrey Blake, Patrick Levis	3	149	1998	6	90 min	218	An in-line skater quits his crew to join a corporate-sponsored team.
691	1	Brother Bear	Aaron Blaise, Robert Walker	Joaquin Phoenix, Jeremy Suarez, Jason Raize, Rick Moranis, Dave Thomas, D.B. Sweeney	3	149	2003	2	90 min	62	A boy transformed into a bear makes an epic journey to become human again.
692	1	Brother Bear 2	Benjamin Gluck	Patrick Dempsey, Mandy Moore, Jeremy Suarez, Rick Moranis, Dave Thomas, Andrea Martin	3	149	2006	2	78 min	62	Bear Kenai is haunted by dreams of his previous life as a human child.
693	1	Buffalo Dreams	David Jackson	Reiley McClendon, Simon Baker, Graham Greene, Tessa Vonn, Max van Ville, Chris Hunter	3	149	2005	6	90 min	226	Two teenagers are sent on a vision quest by a Navajo elder.
694	2	Bug Juice: My Adventures at Camp			3	149	2017	6	1 Season	227	Camp Waziyatah opens its doors for a fun summer.
695	1	BURN-E	Angus MacLane	Angus MacLane, Tessa Swigart	3	149	2008	6	8 min	11	BURN-E the welding bot is locked out of the star liner.
696	1	Cadet Kelly	Larry Shaw	Hilary Duff, Christy Romano, Shawn Ashmore, Aimee Garcia, Linda Kash, Nigel Hamer	2	149	2002	6	100 min	48	An artsy teen goes from fab to drab after enrolling in a military academy.
697	1	Camp Nowhere	Jonathan Prince	Christopher Lloyd, Jonathan Jackson, Wendy Makkena, Tom Wilson, Andrew Keegan, Marne Patterson	3	149	1994	5	96 min	19	An actor and some teenagers create the summer camp of their dreams.
698	1	Camp Rock	Matthew Diamond	Demi Lovato, Joe Jonas, Meaghan Martin, Maria Canals-Barrera, Alyson Stoner, Julie Brown	3	149	2008	6	96 min	228	Mitchie gets the chance to spend a summer at a prestigious music camp.
699	1	Camp Rock 2: The Final Jam	Paul Hoen	Demi Lovato, Joe Jonas, Nick Jonas, Kevin Jonas, Daniel Fathers, Daniel Kash	3	149	2010	6	101 min	228	To save Camp Rock, Mitchie challenges Camp Star to a final jam.
700	1	Can of Worms	Paul Schneider	Michael Shulman, Erika Christensen, Adam Wylie, Andrew Ducote, Lee Garlington, Brighton Hertford	2	149	1999	1	84 min	229	Aliens invade when a teen asks for intergalactic help to escape Earth.
701	1	Candleshoe	Norman Tokar	David Niven, Helen Hayes, Jodie Foster, Leo McKern, Vivian Pickles, Veronica Quilligan	25	149	1978	2	101 min	94	A tomboy cons a nobleman to find a treasure trove of Spanish doubloons.
702	1	Canine Caddy	Clyde Geronimi		3	149	1941	6	8 min	11	Pluto caddies for Mickey on the golf course. See details for advisory.
703	1	Cars	John Lasseter	Owen Wilson, Paul Newman, Bonnie Hunt, Larry the Cable Guy , Cheech Marin, Tony Shalhoub	3	149	2006	2	117 min	11	Race car Lightning McQueen gets stranded in a small town on Route 66.
704	1	Cars 2	John Lasseter	Owen Wilson, Larry the Cable Guy , Michael Caine, Emily Mortimer, John Turturro, Eddie Izzard	3	149	2011	2	107 min	11	Lightning McQueen and Mater go overseas to compete in the World Grand Prix.
705	1	Cars 3	Brian Fee	Owen Wilson, Cristela Alonzo, Chris Cooper, Nathan Fillion, Larry the Cable Guy , Armie Hammer	3	149	2017	2	103 min	11	Lightning McQueen must face a new generation of racers.
706	1	Cars Toon: Air Mater	Rob Gibbs	Larry the Cable Guy , Keith Ferguson, Stacey Keach, Jonathan Adams, Jan Rabson, Lori Alan	3	149	2011	6	5 min	11	Mater’s decision to fly lands him at a big airshow.
707	1	Cars Toon: Heavy Metal Mater	John Lasseter	Larry the Cable Guy , Keith Ferguson	3	149	2010	6	5 min	11	Mater is a rock star in a heavy metal band.
708	1	Cars Toon: Hiccups	Jeremy Lasky	Keith Ferguson, Larry the Cable Guy , Michael Wallis, Tony Shalhoub, Lloyd Sherr, Bonnie Hunt	3	149	2013	6	3 min	11	Lighting McQueen gets the hiccups.
709	1	Cars Toon: Mater Private Eye	Rob Gibbs	Larry the Cable Guy , Keith Ferguson	3	149	2010	8	6 min	11	Mater searches for clues on a major crime scene.
710	1	Cars Toon: Mater the Greater	John Lasseter	Larry the Cable Guy , Keith Ferguson	3	149	2008	8	5 min	11	Mater the Greater is a famous daredevil.
711	1	Cars Toon: Monster Truck Mater	John Lasseter	Larry the Cable Guy , Keith Ferguson	3	149	2010	8	6 min	11	Mater is a monster truck wrestler.
712	1	Cars Toon: The Radiator Springs 500 1/2	Rob Gibbs, Scott Morse	Owen Wilson, Larry the Cable Guy , Steve Purcell, Jess Harnell, John Cygan,  Danny  Mann	3	149	2014	8	6 min	11	Baja racers descend on Radiator Springs.
713	1	Casebusters	Wes Craven	Pat Hingle, Noah Hathaway, Virginya Keehne, Gary Riley, Ebbe Smith, Sharon Barr	3	149	1986	1	46 min	230	Sibling sleuths investigate a crime that threatens their family business.
714	1	Cheetah	Jeff Blyth	Keith Coogan, Lucy Deakins, Timothy Landfield, Breon Gorman, Collin Mothupi, Ka Vundla	3	149	1989	2	84 min	186	American teens traverse the African desert to rescue their adopted cheetah.
715	1	Chef Donald	Jack King		3	149	1941	6	8 min	11	Donald is inspired by a radio program to make waffles. See details for advisory.
716	1	Chicken Little	Mark Dindal	Zach Braff, Garry Marshall, Don Knotts, Patrick Stewart, Amy Sedaris, Steve Zahn	3	149	2005	2	84 min	231	When disaster strikes, Chicken Little hatches a plan to save the day.
717	2	Chip 'n Dale's Rescue Rangers		Corey Burton, Peter Cullen, Jim Cummings, Tress MacNeille	58	149	1989	6	1 Season	73	Chip and Dale head a small group of animal characters who monitor the human and animal communities.
718	1	Chip an' Dale	Jack Hannah		3	149	1947	6	7 min	11	Chip and Dale have to save their home from Donald Duck. See details for advisory.
719	1	Cinderella	Wilfred Jackson, Hamilton Luske, Clyde Geronimi	Ilene Woods, Eleanor Audley, Verna Felton, Rhoda Williams, James MacDonald, Luis Van Rooten	3	149	1950	2	77 min	111	Cinderella's enchanted evening must end when a spell is broken at midnight.
720	1	Cinderella II: Dreams Come True	John Kafka	Jennifer Hale, Rob Paulsen, Corey Burton, Andre Stojka, Russi Taylor, Susanne Blakeslee	3	149	2002	2	77 min	20	Three royal tales, featuring Cinderella and her life in the palace.
721	1	Cinderella III: A Twist in Time	Frank Nissen	Jennifer Hale, C.D. Barnes, Susanne Blakeslee, Tress MacNeille, Russi Taylor, Andre Stojka	3	149	2007	2	79 min	20	Cinderella's stepmother steals a magic wand and turns back time.
722	1	Clock Cleaners	Ben Sharpsteen		3	149	1937	6	9 min	11	Mickey, Donald and Goofy are trying to clean the clock of a tower. See details for advisory.
723	1	Cloud 9	Paul Hoen	Luke Benward, Dove Cameron, Mike Manning, Kiersey Clemons, Amy Farrington, Patrick Fabian	3	149	2014	6	89 min	232	Two unlikely friends must overcome self-doubt to achieve their dreams.
724	1	College Road Trip	Roger Kumble	Martin Lawrence, Raven-Symoné , Donny Osmond, Brenda Song, Will Sasso, Eshaya Draper	3	149	2008	2	84 min	19	An overprotective dad joins his daughter in search of the perfect college.
725	1	Confessions of a Teenage Drama Queen	Sara Sugarman	Lindsay Lohan, Adam Garcia, Glenne Headly, Alison Pill, Eli Marienthal, Megan Fox	59	149	2004	5	91 min	48	A dramatic teen moves…and finds her new school already has a drama queen.
726	2	Coop & Cami Ask The World (Shorts)			1	149	2018	6	1 Season	233	Cooper and Cami Wrather co-host "Would You Wrather."
727	1	Corn Chips	Jack Hannah		3	149	1951	6	7 min	11	Donald tricks Chip 'n Dale into shoveling snow, but the tables turn. See details for advisory.
728	1	Cow Belles	Francine McDougall	Amanda Michalka, Alyson Michalka, Sheila McCarthy, Michael Trevino, Christian Serratos, Ron Gabriel	3	149	2006	6	91 min	48	Two ultra-spoiled sisters are put to work in their father's dairy.
729	2	Crash & Bernstein		Cole Jensen, Tim Lagasse, Landry Bender, Oana Gregory, Aaron Landon	3	149	2012	8	2 Seasons	2	The only boy in a family, Wyatt creates a puppet brother.
730	1	Dadnapped	Paul Hoen	Emily Osment, David Henrie, Jason Earles, Jonathan Keltz, Moises Arias, Denzel Whitaker	3	149	2009	6	85 min	234	Melissa Morris is due for adventure when her novelist father goes missing.
731	1	Darby O'Gill and the Little People	Robert Stevenson	Albert Sharpe, Janet Munro, Sean Connery, Jimmy O'Dea, Kieron Moore, Estelle Winwood	3	149	1959	2	91 min	235	Seeking a pot of gold, Darby O'Gill must match wits with a leprechaun. See details for advisory.
732	2	Darkwing Duck		Jim Cummings, Christine Cavanaugh, Terry McGovern, Frank Welker	3	149	1991	8	2 Seasons	5	Darkwing Duck tells the adventures of the superhero, aided by his sidekick Launchpad McQuack.
733	1	Davy Crockett and the River Pirates	Norman Foster	Fess Parker, Buddy Ebsen, Jeff York, Kenneth Tobey, Clem Bevans, Irvin Ashkenazy	3	149	1956	2	81 min	236	Davy Crockett encounters pirates en route to New Orleans. See details for advisory.
734	1	Davy Crockett, King of the Wild Frontier	Norman Foster	Fess Parker, Buddy Ebsen, Basil Ruysdael, Hans Conried, Pat Hogan, Ken Tobey	3	149	1955	5	93 min	236	Share Davy Crockett's legend, from the frontier to Congress to the Alamo. See details for advisory.
735	1	Day & Night	Teddy Newton		3	149	2010	2	8 min	11	When Day and Night meet each other, sparks fly!
736	1	Decorating Disney: Holiday Magic		Whoopi Goldberg, Sofia Carson, Jordan Fisher	3	149	2017	1	42 min	237	Disney Parks become the Merriest Places on Earth.
737	1	Deep Blue	Alastair Fothergill, Andy Byatt	Pierce Brosnan	60	149	2005	2	91 min	142	Join an epic underwater exploration into the secret lives of sea creatures.
738	1	Descendants 2	Kenny Ortega	Dove Cameron, Cameron Boyce, Sofia Carson, Booboo Stewart, Mitchell Hope, Brenna D'Amico	3	149	2017	6	114 min	156	Mal returns to the Isle of the Lost and confronts Uma, Ursula's daughter.
739	1	Diary Of A Wimpy Kid	Thor Freudenthal	Zachary Gordon, Robert Capron, Rachel Harris, Steve Zahn, Connor Fielding, Owen Fielding	5	149	2010	5	93 min	40	Greg faces the scariest, most humiliating experience of any kid’s life: middle school.
740	1	Dinosaur	Ralph Zondag, Eric Leighton	D.B. Sweeney, Alfre Woodard, Ossie Davis, Max Casella, Hayden Panettiere, Samuel Wright	3	149	2000	5	84 min	62	An orphaned dinosaur joins others after a meteor destroys his home.
741	1	Disney Adventures in Babysitting	John Schultz	Sabrina Carpenter, Sofia Carson, Nikki Hahn, Mallory Mahoney, Max Gecowets, Jet Jurgensmeyer	3	149	2016	6	95 min	56	Rival babysitters join forces to search the city for a kid who’s snuck out.
742	1	Disney Avalon High	Stuart Gillard	Britt Robertson, Gregg Sulkin, Joey Pollari, Devon Graye, Molly Quinn, Don Lake	3	149	2010	6	91 min	71	Allie is convinced that her new high school is a contemporary Camelot.
743	1	Disney Bad Hair Day	Érik Canuel	Laura Marano, Leigh-Allyn Baker, Christian Campbell, Alain Goulem, Christian Paul, Kiana Madeira	12	149	2015	6	93 min	147	Monica's prom day starts with bad hair…but ends with a great adventure.
744	2	Disney Bizaardvark		Madison Hu, Olivia Rodrigo, Jake Paul, DeVore Ledridge, Ethan Wacker	3	149	2015	1	3 Seasons	238	Paige and Frankie produce an online comedy channel.
745	1	Disney Den Brother	Mark Taylor	Hutch Dano, G. Hannelius, Maurice Godin, David Lambert, Kelsy Chow, Debra Mooney	3	149	2010	6	90 min	48	A hockey star hangs up his skates and becomes a substitute scoutmaster.
746	1	Disney Descendants	Kenny Ortega	Dove Cameron, Cameron Boyce, Booboo Stewart, Sofia Carson, Mitchell Hope, Melanie Paxson	3	149	2015	6	114 min	156	The kids of Disney villains are given a shot at redemption at Auradon Prep.
747	2	Disney Descendants Wicked World (Shorts)			3	149	2015	6	2 Seasons	239	Descendants continues with new animated shorts!
748	2	Disney DuckTales (Shorts)			1	149	2016	8	1 Season	73	The McDuck family welcomes you to Duckburg!
749	2	Disney Evermoor		Naomi Sequeira, Jordan Loughran, Belinda Stewart-Wilson, Dan Fredenburgh, George Sear, Georgie Farmer	1	149	2017	1	1 Season	99	Tara Crossley moves to Evermoor and realizes the English countryside is not as sleepy as it seems.
750	2	Disney Family Sundays			3	149	2019	6	1 Season	240	Amber Kemp-Gerstel shares her love of crafting in a series of Disney-themed DIY projects.
751	2	Disney Fast Layne		Sophie Pollono, Sofia Rosinsky, Brandon Rossel, Winslow Fegley	3	149	2018	6	1 Season	73	Twelve-year-old Layne Reed discovers a talking car.
752	1	Disney Girl vs. Monster	Stuart Gillard	Olivia Holt, Kerris Dorsey, Brendan Meyer, Katherine McNamara, Adam Chambers, Tracy Dawson	2	149	2012	1	90 min	212	The daughter of two monster-hunters must take on a monster of her own.
753	2	Disney Gravity Falls		Kristen Schaal, Jason Morgan, Alex Hirsch	3	149	2011	8	2 Seasons	73	Dipper and Mabel spend the summer with Grunkle Stan.
754	2	Disney Gravity Falls (Shorts)			1	149	2012	6	1 Season	241	Twins Dipper and Mabel enter the mysterious town of Gravity Falls for the summer.
755	2	Disney Jake and the Never Land Pirates		Madison Pettis, Colin Ford, Jonathan Heit, David Arquette, Corey Burton	3	149	2010	4	4 Seasons	13	Jake sails for a treasure hunt against Captain Hook.
756	2	Disney JONAS		Kevin Jonas, Joe Jonas, Nick Jonas, Chelsea Staub, Nicole Anderson, John Ducey	3	149	2008	6	2 Seasons	105	JONAS is the hottest rock band on the planet! Band members Nick, Kevin, and Joe are superstar idols.
757	2	Disney Junior Music Nursery Rhymes			1	149	2017	4	2 Seasons	97	Nursery Rhymes re-imagined with Disney Junior!
1061	2	Pixar In Real Life			3	149	2019	6	1 Season	284	Characters and moments from Pixar films are brought to life to the surprise of real people.
759	2	Disney Lab Rats: Elite Force		William Brent, Bradley Perry, Jake Short, Paris Berelc, Kelli Berglund	3	149	2015	8	1 Season	56	The Lab Rats join forces with the Mighty Med team.
760	2	Disney Legend of the Three Caballeros		Tony Anselmo, Jaime Camil, Eric Bauza, Grey Griffin, Wayne Knight, Kevin Richardson	3	149	2017	6	1 Season	73	Donald, Jose and Panchito inherit a magical atlas and travel the world battling mythical monsters.
761	2	Disney Mickey Mouse Clubhouse		Wayne Allwine, Jim Cummings, Russi Taylor, Tony Anselmo, Bill Farmer, Tress MacNeille	3	149	2005	4	5 Seasons	38	Mickey leads kids on an interactive adventure of learning.
762	2	Disney Milo Murphy's Law		Al Yankovic, Sabrina Carpenter, Mekai Curtis	3	149	2016	8	2 Seasons	73	Around Milo, anything that can go wrong, will.
763	2	Disney Minnie's Bow-Toons (Shorts)			3	149	2011	4	3 Seasons	38	Minnie Mouse teams up with Daisy to open up Minnie’s Bow-tique.
764	2	Disney Stuck In The Middle		Jenna Ortega, Ronni Hawk, Isaak Presley, Ariana Greenblatt, Kayla Maisonet, Nicolas Bechtel	3	149	2015	1	3 Seasons	19	Harley is stuck in the middle of a family with 7 kids!
765	2	Disney Take Two With Phineas And Ferb (Shorts)			3	149	2010	6	1 Season	242	Real-life celebrities are interviewed by Phineas and Ferb.
766	2	Disney Tangled: The Series - Short Cuts			1	149	2016	8	1 Season	73	Get to know the colorful residents of Corona.
767	1	Disney Under The Sea: A Descendants Short Story	Hasraf Dulull		1	149	2018	6	10 min	243	Mal emerges from the forest where she meets Dizzy.
768	2	Disney's Adventures Of The Gummi Bears		Bill Scott, Christian Jacobs, Brett Johnson, David Faustino, Paul Winchell, Jason Marsden	3	149	1985	8	6 Seasons	13	The magical Gummi Bears discover their rich history.
769	2	Disney's Doug		Connie Shulman, Doug Preis, Alice Playten, Chris Phillips, Fred Newman, Thomas McHugh	3	149	1996	8	3 Seasons	21	Doug uses his imagination to navigate through tests of friendship, love, school, and growing up.
770	1	Disney's Fairy Tale Weddings	Chris Wilson	Ben Higgins, Lauren Bushnell	1	149	2017	1	64 min	244	A look at the magical weddings at Disney Destinations.
771	1	Disney's Fairy Tale Weddings: Holiday Magic	Chris Wilson	Stephen Boss, Allison Holker	1	149	2017	1	42 min	244	Holiday Disney weddings and proposals.
772	2	Disney's Hercules: The Animated Series		Tate Donovan, Sandra Bernhard, Robert Costanzo, Matt Frewer, Bobcat Goldthwait, French Stewart	3	149	1998	8	1 Season	73	Follow Herc's many labors during the years he spent training on how to be a hero.
773	2	Disney's Kim Possible		Christy Romano, Will Friedle, Nancy Cartwright, Tahj Mowry	61	149	2001	6	4 Seasons	73	Kim Possible is a high school girl who, in her spare time, saves the world from evil villains.
774	2	Disney's Little Einsteins		Erica Huang, Aiden Pompey, Jesse Schwartz, Natalia Wojcik	3	149	2005	4	2 Seasons	5	This innovative new series provides preschoolers with new ways to hear and see music and art.
775	2	Disney's Mighty Ducks		James Belushi, Brad Garrett, Jeff Bennett, Jennifer Hale, Clancy Brown, Tony Jay	3	149	1996	8	1 Season	73	Hockey-loving alien ducks are stranded on Earth and must protect it from the evil Dragaunus.
776	2	Disney's Recess		Rickey Collins, Jason Davis, Ashley Johnson, Ross Malinger, Courtland Mead, Pamela Segall	3	149	1997	8	3 Seasons	110	A portrayal of life at Third Street Elementary School.
777	2	Disney's The Emperor's New School		Shane Baumel, Jessica DiCicco, Wendie Malick, Fred Tatasciore, Jeff Bennett, Jessie Flower	3	149	2005	6	2 Seasons	21	Disney's The Emperor's New School is a unique comedy about Kuzco, a self-centered and spoiled teen.
778	1	Disney's The Kid	Jon Turteltaub	Bruce Willis, Spencer Breslin, Emily Mortimer, Lily Tomlin, Chi McBride, Jean Smart	3	149	2000	5	105 min	152	A man's life is upended when he meets an 8-year-old version of himself.
779	2	Disney's The Little Mermaid (Series)		Jodi Benson, Samuel Wright, Ken Mars, Edan Gross	3	149	1992	8	3 Seasons	13	Follow Ariel's adventures as a mermaid living under the sea with her father, King Triton.
780	1	Disneyland Around the Seasons (Walt Disney's Wonderful World of Color: 1961-69)	Hamilton Luske	Walt Disney	3	149	1966	1	51 min	245	Walt Disney talks about Disneyland in 1966. See details for advisory.
781	1	Disneynature African Cats	Keith Scholey	Samuel Jackson	3	149	2011	2	90 min	142	Come face-to-face with the wildly majestic African lions of the savanna.
782	1	Disneynature Bears	Alastair Fothergill, Keith Scholey	John Reilly	3	149	2014	2	78 min	142	A mother bear teaches her two impressionable cubs important life lessons.
783	1	Disneynature Born in China	Lu Chuan	John Krasinski	62	149	2017	2	81 min	142	Embrace the beauty of China's vast terrain – and the life that inhabits it.
784	1	Disneynature Chimpanzee	Alastair Fothergill, Mark Linfield	Tim Allen	63	149	2012	2	79 min	142	Meet a remarkable young chimpanzee who sees his world as his playground.
785	1	Disneynature Crimson Wing	Matthew Aeberhard, Leander Ward	Mariella Frostrup	5	149	2008	2	78 min	142	A million flamingos struggle to survive in the remote Tanzanian wilderness.
786	1	Disneynature Monkey Kingdom	Mark Linfield	Tina Fey	3	149	2015	2	82 min	142	Forced from their home among ancient ruins, a mother monkey must lead her son to safety.
787	1	Disneynature Wings of Life	Louie Schwartzberg	Meryl Streep	64	149	2011	2	81 min	142	An intimate look at butterflies, hummingbirds, bees, bats and flowers.
788	2	Dog Whisperer with Cesar Millan		Cesar Millan	3	149	2004	6	6 Seasons	4	World-renowned dog expert Cesar Millan helps dogs and their owners overcome behavior issues.
789	1	Don't Look Under the Bed	Kenneth Johnson	Erin Chambers, Eric Hodges II, Eric Hodges, Robin Riker, Steve Valentine, Jake Sakson	3	149	1999	1	93 min	71	Teen Frances McCausland is framed for the Boogeyman's mischievous pranks.
790	1	Donald's Golf Game	Jack King		3	149	1938	6	8 min	11	Donald tries to impress his nephews at golfing. See details for advisory.
791	1	Donald's Tire Trouble	Dick Lundy		3	149	1943	6	8 min	11	Donald is frustrated in his attempts to fix a flat tire. See details for advisory.
792	1	Double Teamed	Duwayne Dunham	Poppi Monroe, Annie McElwain, Teal Redmann, Nick Searcy, Tanya Goott, Joey Miyashima	3	149	2002	6	93 min	246	The WNBA's Burge twins inspire this film about sisterhood and teamwork.
793	1	Doug's 1st Movie	Maurice Joyce	Thomas McHugh, Fred Newman, Chris Phillips, Constance Shulman, Frank Welker, Doug Preis	3	149	1999	2	80 min	11	Doug and his friends discover the "monster" of Lucky Duck Lake.
1288	1	Three Days	Michael Switzer		3	149	2001	6	93 min	280	An angel lets a man relive the days before his wife's death.
794	2	Dr. T, Lone Star Vet		Dr. Lauren Thielen	3	149	2019	1	1 Season	247	Dr. T, Lone Star Vet follows Dr. T as she faces the most compelling cases of her career.
795	1	DuckTales The Movie: Treasure of the Lost Lamp	Bob Hathcock	Alan Young, Terence McGovern, Russi Taylor, Richard Libertini, Christopher Lloyd, June Foray	51	149	1990	2	75 min	73	Scrooge and his nephews search for the long-lost loot of Collie Baba.
796	1	Dug's Special Mission	Ronnie Del Carmen	Bob Peterson, Delroy Lindo, Jerome Ranft	3	149	2009	1	6 min	11	Dug finds where he belongs is not where he's been looking.
797	1	Dumbo	Tim Burton	Colin Farrell, Michael Keaton, Danny DeVito, Eva Green, Alan Arkin, Nico Parker	65	149	2019	5	117 min	30	A flying elephant helps show that differences and family can be cherished.
798	1	Early to Bed	Jack Kinney		3	149	1941	6	9 min	11	A ticking alarm clock keeps Donald awake. See details for advisory.
799	1	Earth Live	Glenn Weiss	Jane Lynch, Phil Keoghan, Chris Packham	3	149	2017	1	94 min	142	Earth Live gives viewers a unique, live view of wildlife around the world.
800	1	Easter Island Unsolved	Geoff Luck	Peter Demeo	3	149	2018	7	45 min	122	Easter Island is a riddle, and its mysterious past may hold clues to its future.
801	1	Eddie's Million Dollar Cook-off	Paul Hoen	Taylor Ball, Orlando Brown, Reiley McClendon, Mark Taylor, Rose McIver, Kylie Leydon	3	149	2003	6	86 min	248	A baseball prodigy swings for the culinary fences in a cooking competition.
802	1	Eight Below	Frank Marshall	Paul Walker, Bruce Greenwood, Moon Bloodgood, Wendy Crewson, Gerard Plunkett, August Schellenberg	3	149	2006	5	122 min	91	An Antarctic storm threatens eight sled dogs alone in the wilderness.
803	2	Elena of Avalor (Shorts)		Aimee Carrero, Jenna Ortega, Maximus Riegel, Gia Lopez, Desmond Gerber, Mick Wingert	1	149	2017	4	2 Seasons	13	Elena travels to Vallestrella and trains with Zuzo!
804	1	Emil and the Detectives	Peter Tewksbury	Walter Slezak, Roger Mobley, Heinz Schubert, Peter Ehrlich, Cindy Cassell, Elsa Wagner	3	149	1964	1	98 min	249	When a young boy's money is stolen, the search is on for the thief.
805	1	Empire of Dreams: The Story of the Star Wars Trilogy	Edith Becker, Kevin Burns	Robert Clotworthy, Walter Cronkite, Anthony Daniels, Warwick Davis, Carrie Fisher, Harrison Ford	3	149	2004	7	151 min	1	Explore the creation of Star Wars, a saga few thought could ever be made.
806	2	Encore!		Kristen Bell, Roger Love, Susan Egan, Ali Stroker, Stephen Schwartz	3	149	2019	7	1 Season	250	Kristen Bell reunites former high school classmates to re-stage musicals they performed in the past.
807	1	Escape to Witch Mountain	John Hough	Eddie Albert, Ray Milland, Donald Pleasence, Kim Richards, Ike Eisenmann, Walter Barnes	3	149	1975	2	98 min	30	Two orphans with supernatural powers discover their mysterious past.
808	2	Even Stevens		Shia LaBeouf, Christy Romano, Nick Spano, Tom Virtue, Donna Pescow	3	149	2000	1	3 Seasons	86	Louis, a seventh-grade misfit, struggles to fit in at school and in his seemingly perfect family.
809	1	Expedition Mars: Spirit & Opportunity	Mark Davis	Bray Poor	3	149	2019	1	88 min	1	Expedition Mars explores the epic adventures of the Mars rovers, Spirit and Opportunity.
810	1	Fantasia	Samuel Armstrong, James Algar, Bill Roberts	Deems Taylor, Walt Disney, Leopold Stokowski	3	149	1940	2	126 min	111	Walt Disney's timeless masterpiece is an extravaganza of sight and sound. See details for advisory.
811	1	Fantasia 2000	Pixote Hunt, Hendel Butoy, Eric Goldberg	Steve Martin, Itzhak Perlman, Quincy Jones, Bette Midler, James Jones, Penn Teller	3	149	2000	2	76 min	111	A modern update of the Disney classic with new music and animation.
812	2	Fantastic Four (Series)		Beau Weaver, Lori Alan, Chuck McCann, Brian Green, Stan Lee, Pauline Lomas	3	149	1994	8	1 Season	5	Reed Richards, Sue and Johnny Storm and pilot Ben Grimm are transformed into the Fantastic Four.
813	2	Fantastic Four: World's Greatest Heroes		Christopher Jacot, Hiro Kanagawa, Lara Gilchrist, Brian Dobson	3	149	2007	8	1 Season	5	Watch Mr. Fantastic, Invisible Woman, Human Torch, and Thing as they battle their greatest foes.
814	1	Ferdinand the Bull	Dick Rickard		3	149	1938	6	8 min	11	Ferdinand only wants to stop and smell the flowers. See details for advisory.
815	1	Finding Dory	Andrew Stanton, Angus MacLane	Ellen DeGeneres, Albert Brooks, Ed O'Neill, Kaitlin Olson, Hayden Rolence, Ty Burrell	3	149	2016	5	98 min	73	Dory sets off on a life-changing adventure to find her family.
816	1	Finding Nemo	Andrew Stanton	Albert Brooks, Ellen DeGeneres, Alexander Gould, Willem Dafoe, Brad Garrett, Allison Janney	52	149	2003	2	103 min	73	Marlin makes an epic journey to bring Nemo home when he's taken by divers.
817	1	First Kid	David Evans	Sinbad , Robert Guillaume, Timothy Busfield, Brock Pierce, James Naughton, Art Fleur	3	149	1996	5	102 min	147	A wisecracking Secret Service agent is assigned to the President's son.
818	1	Flight of the Navigator	Randal Kleiser	Joey Cramer, Veronica Cartwright, Cliff De Young, Sarah Parker, Matt Adler, Howard Hesseman	3	149	1986	5	90 min	23	A boy mysteriously gains knowledge of the farthest reaches of the universe.
819	1	Float	Bobby Rubio	Eli Fucile, Bobby Rubio, Luna Watson, Mika Kubo	3	149	2019	5	10 min	111	A father hides his unusual son, and then must face the consequences.
820	1	Flowers and Trees	Burt Gillett		3	149	1932	8	8 min	224	It's spring, and the flowers, mushrooms, and trees come to life. See details for advisory.
821	1	Flubber	Les Mayfield	Robin Williams, Marcia Harden, Christopher McDonald, Raymond Barry, Clancy Brown, Ted Levine	3	149	1997	5	96 min	34	Phillip hopes his super-bouncy goo will save his college and his wedding.
822	1	Food for Feudin'	Charles Nichols		3	149	1950	6	7 min	11	The chipmunks and Pluto battle over a supply of nuts. See details for advisory.
823	1	For the Birds	Ralph Eggleston		3	149	2001	2	4 min	11	Small birds mock a big bird who tries to sit with them
824	1	Forky Asks a Question: What is Money?	Bob Peterson	Tony Hale, John Ratzenberger, Bob Peterson	3	149	2019	6	6 min	11	Hamm attempts to give Forky a lesson on how the US monetary system works.
825	1	Frank and Ollie	Theodore Thomas	Frank Thomas, Ollie Johnston, Sylvia Roemer, John Canemaker, John Culhane, Marie Johnston	3	149	1995	5	89 min	59	Share the story of famed Disney animators Frank Thomas and Ollie Johnston.
826	1	Frankenweenie (Short)	Tim Burton	Shelley Duvall, Daniel Stern, Barret Oliver	3	149	1984	5	27 min	251	Victor harnesses the power of science to bring his dog Sparky back to life.
827	1	Freaky Friday	Mark Waters	Jamie Curtis, Lindsay Lohan, Harold Gould, Chad Murray, Stephen Tobolowsky, Christina Vidal	3	149	2003	5	98 min	54	A mother and daughter see things a bit differently when they switch bodies.
828	1	Free Solo	Elizabeth Vasarhelyi, Jimmy Chin	Alex Honnold, Tommy Caldwell	3	149	2018	1	101 min	252	Free solo climber Alex Honnold prepares to scale El Capitan in Yosemite without a rope.
829	1	Frenemies	Daisy Mayer	Zendaya , Bella Thorne, Mary Mouser, Nick Robinson, Stefanie Scott, Connor Price	3	149	2012	6	88 min	253	Three very different sets of friends experience growing pains.
830	1	Frozen	Chris Buck, Jennifer Lee	Kristen Bell, Idina Menzel, Jonathan Groff, Josh Gad, Santino Fontana, Alan Tudyk	3	149	2013	5	105 min	111	Anna and Kristoff brave the elements, racing to save Elsa and the kingdom.
831	1	Full-Court Miracle	Stuart Gillard	Alex Linz, R.H. Thomson, Sean Marquette, Jase Blankfort, Erik Knudsen, David Sazant	3	149	2003	6	95 min	218	A former college star is convinced to coach a winless basketball team.
832	1	Fun and Fancy Free	Jack Kinney, W. Roberts, Hamilton Luske	Edgar Bergen, Dinah Shore, Luana Patten, Clarence Nash, Mickey Mouse, Cliff Edwards	3	149	1947	2	74 min	73	Two classic featurettes starring Mickey, Donald, Goofy and Jiminy Cricket.
833	1	Fuzzbucket	Mick Garris	Chris Hebert, Phil Fondacaro, Joe Regalbuto, Wendy Phillips, Robyn Lively, John Vernon	3	149	1986	6	46 min	147	An invisible creature helps Mikey cope with junior high and family drama.
834	2	Gargoyles		Thom Hernandez, Edward Asner, Jeff Bennett, Keith David, Bill Fagerbakke, Jonathan Frakes	3	149	1994	8	3 Seasons	13	In Scotland, 994 A.D. Goliath and his clan of gargoyles defend a medieval castle.
835	1	Geek Charming	Jeffrey Hornaday	Sarah Hyland, Matt Prokop, Sasha Pieterse, Jordan Nichols, Vanessa Morgan, Lili Simmons	3	149	2011	6	99 min	114	Popular Dylan wants film geek Josh to help her be crowned Blossom Queen.
836	1	Genius	Rod Daniel	Trevor Morgan, Emmy Rossum, Yannick Bisson, Peter Keleghan, Philip Granger, Charles Fleischer	3	149	1999	6	86 min	48	A teen genius juggles the roles of college student and junior high bad boy.
837	1	George & A.J.	Josh Cooley	Jason Topolski, A.J. Riebli  III, Steve Purcell, Peter Sohn, Bob Peterson, Kim Donovan	3	149	2009	6	4 min	11	Two nurses try to escort seniors to the nursing home.
838	1	Geri's Game	Jan Pinkava	Bob Peterson	3	149	1997	2	5 min	224	Geri plays a daylong game of chess against himself.
839	1	Get a Clue	Maggie Greenwald	Lindsay Lohan, Bug Hall, Ian Gomez, Brenda Song, Ali Mukadam, Dan Lett	3	149	2002	6	84 min	254	A teenage gossip columnist takes on the case of her missing teacher.
840	1	Giants of the Deep Blue	Ken Corben	Bill Graves	1	149	2018	1	45 min	142	Go beneath the surface of the sea for an extraordinary look at whales and dolphins.
841	2	Girl Meets World		Rowan Blanchard, Ben Savage, Sabrina Carpenter, Peyton Meyer, August Maturo, Danielle Fishel	3	149	2013	6	3 Seasons	19	Riley and Maya traverse the twists of teenage years.
842	1	Go Figure	Francine McDougall	Jordan Hinson, Whitney Sloan, Cristine Rose	3	149	2005	6	89 min	255	A girl must embrace hockey if she wants to become a champion ice skater.
843	1	Going to the Mat	Stuart Gillard	Andrew Lawrence, Khleo Thomas, Alessandra Toreson, Billy Brown, Brenda Strong, Brian Wimmer	3	149	2004	6	92 min	255	At a new school, Jace overcomes his blindness through a love of wrestling.
844	2	Good Luck Charlie		Bridgit Mendler, Leigh-Allyn Baker, Bradley Perry, Mia Talerico, Eric Kramer, Jason Dolley	3	149	2009	6	4 Seasons	19	The Duncans are a typical family whose lives are turned topsy-turvy with the arrival of Charlie
845	1	Good Luck Charlie, It's Christmas!	Arlene Sanford	Bridgit Mendler, Leigh-Allyn Baker, Bradley Perry, Mia Talerico, Debra Monk, Michael Kagan	3	149	2011	6	82 min	19	The Duncans need a miracle of their own to reunite in time for Christmas.
846	2	Goof Troop		Nancy Cartwright, Jim Cummings, Dana Hill, Rob Paulson, Corey Burton, Bill Farmer	3	149	1992	8	1 Season	110	Goofy is a single father raising his son, Max in Spoonerville.
847	1	Gotta Kick it Up	Ramon Menendez	Camille Guaty, America Ferrera, Jhoanna Flores, Suilma Rodriguez, Sabrina Wiener, Miguel Sandoval	3	149	2002	6	85 min	256	A new coach and her middle school dance team surprise all their doubters.
848	1	Grand Canyonscope	C. Nichols		3	149	1954	6	7 min	11	A park ranger has to keep Donald in check at the Grand Canyon. See details for advisory.
849	1	Grasshopper and the Ants	Wilfred Jackson		3	149	1934	6	8 min	257	A grasshopper learns a lesson about hard work. See details for advisory.
850	2	Great Migrations		Alec Baldwin	3	149	2010	1	1 Season	258	An intimate and unprecedented view of animal migrations across the globe.
851	1	Greyfriars Bobby	Don Chaffey	Donald Crisp, Laurence Naismith, Alex Mackenzie, Duncan Macrae, Andrew Cruickshank, Gordon Jackson	3	149	1961	6	91 min	47	The story of friendship forged between a shepherd and his devoted dog.
852	1	Gus	Vincent McEveety	Edward Asner, Don Knotts, Gary Grimes, Tim Conway, Liberty Williams, Dick Van Patten	3	149	1976	2	97 min	178	A football team welcomes their newest member... a placekicking mule.
853	1	Halloweentown	Duwayne Dunham	Debbie Reynolds, Judith Hoag, Kimberly Brown, Joey Zimmerman, Phillip Van Dyke, Emily Roeske	3	149	1998	1	84 min	56	Marnie and her siblings discover their spooky heritage in Halloweentown.
854	1	Halloweentown High	Mark Dippé	Kimberly Brown, Judith Hoag, Joey Zimmerman, Emily Roeske, Clifton Davis, Finn Wittrock	3	149	2004	6	83 min	212	Marnie's magic is on the line as Halloweentown kids transfer to her school.
855	1	Halloweentown II: Kalabar's Revenge	Mary Lambert	Kimberly Brown, Judith Hoag, Daniel Kountz, Joseph Zimmerman, Emily Roeske, Phillip Van Dyke	3	149	2001	1	81 min	17	A warlock with a devious plan has stripped Halloweentown of its magic.
856	2	Handy Manny		Wilmer Valderrama, Carlos Alazraqui, Dee Baker, Nika Futterman, Tom Kenny, Kath Soucie	2	149	2006	4	3 Seasons	38	Handy Manny and his box of friendly, silly tools are the go-to guys in their neighborhood.
857	2	Hannah Montana		Miley Cyrus, Emily Osment, Mitchel Musso, Jason Earles, Billy Cyrus	3	149	2005	6	4 Seasons	86	Hannah Montana is a live-action comedy series that follows typical tween Miley Stewart.
858	1	Hannah Montana and Miley Cyrus: Best of Both Worlds Concert	Bruce Hendricks	Miley Cyrus, Joe Jonas, Kevin Jonas, Nick Jonas, Kenny Ortega, Billy Cyrus	3	149	2008	2	83 min	259	A look at Miley Cyrus's sold-out concerts and her life on tour.
859	1	Hannah Montana The Movie	Peter Chelsom	Miley Cyrus, Emily Osment, Margo Martindale, Jason Earles, Peter Gunn, Melora Hardin	3	149	2009	2	105 min	114	Miley adapts to life back in Tennessee after getting too caught up in the celebrity lifestyle.
860	1	Hatching Pete	Stuart Gillard	Jason Dolley, Mitchel Musso, Tiffany Thornton, Josie Loren, Sean O'Bryan, Amy Farrington	3	149	2009	6	90 min	48	The identity of Brewster High's mascot, The Chicken, is a big mystery.
861	1	Hawaiian Holiday	Ben Sharpsteen	Walt Disney, Marcellite Garner, Clarence Nash, Pinto Colvig	3	149	1937	6	9 min	11	Mickey and gang experience Hawaii through hula dancing and the beach. See details for advisory.
862	1	Heavyweights	Steven Brill	Tom McGowan, Aaron Schwartz, Shaun Weiss, Tom Hodges, Leah Lail, Paul Feig	3	149	1995	5	98 min	40	Portly misfits join up to take back their summer camp from a fitness guru.
863	1	Herbie Goes Bananas	Vincent McEveety	Cloris Leachman, Charles Smith, John Vernon, Stephen Burns, Elyssa Davalos, Joaquin Garay  III	3	149	1980	2	93 min	36	A stowaway derails Herbie's trip from Puerto Vallarta to Brazil for an auto race.
864	1	Herbie Goes to Monte Carlo	Vincent McEveety	Dean Jones, Don Knotts, Julie Sommars, Jacques Marin, Roy Kinnear, Bernard Fox	3	149	1977	2	105 min	36	Herbie tries to lose jewel thieves and find love during a road race from Paris to Monte Carlo.
865	1	Herbie Rides Again	Robert Stevenson	Helen Hayes, Ken Berry, Stefanie Powers, John McIntire, Keenan Wynn, Huntz Hall	3	149	1974	2	89 min	260	Herbie comes to the rescue when a greedy real estate tycoon is after an elderly widow's home.
866	1	Hercules	John Musker, Ron Clements	Tate Donovan, Joshua Keaton, Roger Bart, Danny DeVito, James Woods, Susan Egan	66	149	1997	2	98 min	73	Hercules must go from zero to hero to save the universe from Hades' wrath.
867	1	High School Musical	Kenny Ortega	Zac Efron, Vanessa Hudgens, Ashley Tisdale, Lucas Grabeel, Alyson Reed, Corbin Bleu	3	149	2006	6	100 min	261	A basketball star and a brainy girl find a place in the spotlight…and love.
868	1	High School Musical 2	Kenny Ortega	Zac Efron, Vanessa Hudgens, Ashley Tisdale, Lucas Grabeel, Corbin Bleu, Monique Coleman	3	149	2007	6	114 min	262	The East High Wildcats take on summer and let their talents shine.
869	1	High School Musical 3: Senior Year	Kenny Ortega	Zac Efron, Vanessa Hudgens, Ashley Tisdale, Lucas Grabeel, Corbin Bleu, Monique Coleman	3	149	2008	2	121 min	263	Troy, Gabriella and the rest of the East High kids take on senior year.
870	2	High School Musical: The Musical: The Series		Olivia Rodrigo, Joshua Bassett, Matt Cornett, Sofia Wylie, Larry Saperstein	3	149	2019	1	2 Seasons	114	For the first time ever, East High Wildcats put on a production of High School Musical: The Musical!
871	1	Hocus Pocus	Kenny Ortega	Bette Midler, Sarah Parker, Kathy Najimy, Omri Katz, Thora Birch, Vinessa Shaw	3	149	1993	5	96 min	54	Three 17th-century Salem witches are conjured up by unsuspecting children.
872	1	Home on the Range	Will Finn, John Sanford	Roseanne Barr, Judi Dench, Jennifer Tilly, Steve Buscemi, G.W. Bailey, Cuba Gooding Jr.	3	149	2004	5	82 min	11	A corral of critters join forces to save their farm from a band of outlaws.
873	1	Honey, I Blew Up the Kid	Randal Kleiser	Rick Moranis, Marcia Strassman, Lloyd Bridges, Robert Oliveri, John Shea, Keri Russell	3	149	1992	5	90 min	34	A wacky inventor accidentally turns his baby boy into a towering toddler.
874	1	Honey, I Shrunk the Kids	Joe Johnston	Rick Moranis, Matt Frewer, Marcia Strassman, Kristine Sutherland, Thomas Brown, Jared Rushton	36	149	1989	5	94 min	36	Inventor Wayne Szalinski accidentally shrinks his kids to 1/4-inch tall.
875	1	Honey, We Shrunk Ourselves	Dean Cundey	Rick Moranis, Eve Gordon, Robin Bartlett, Allison Mack, Jake Richardson, Stuart Pankin	3	149	1997	5	76 min	212	This time, Wayne Szalinski's shrink machine is pointed at the parents!
876	1	Horse Sense	Greg Beeman	Joey Lawrence, Andy Lawrence, Susan Walters, M.C. Gainey, Leann Hunley, Robin Thomas	3	149	1999	6	92 min	70	Spoiled Michael spends a summer at his cousin Tommy's Montana ranch.
877	2	Hostile Planet		Bear Grylls	3	149	2019	1	1 Season	258	Hostile Planet reveals the animal kingdom’s epic stories of survival in extreme environments.
878	1	Hounded	Neal Israel	Tahj Mowry, Shia LaBeouf, Craig Kirkwood, Steven Bendik, Sara Paxton, Rachelle Carson	3	149	2001	6	92 min	264	Trying to right a wrong, Jay accidentally steals the principal's show dog.
879	1	How Dogs Got Their Shapes		Jake Robards	3	149	2016	1	44 min	142	Canines are one of the most diverse species on Earth – how did they get that way?
880	1	How to Build a Better Boy	Paul Hoen	Ashley Argota, Roger Bart, Kelli Berglund, Noah Centineo, China McClain, Matt Shively	3	149	2014	6	94 min	157	Tech-savvy best friends use their smarts to engineer the perfect boyfriend.
881	1	How to Fish	Jack Kinney	John McLeish	3	149	1942	6	7 min	11	Goofy shows us how to fish… or how not to! See details for advisory.
882	1	How to Swim	Jack Kinney		3	149	1942	6	8 min	192	Goofy demonstrates how to swim. See details for advisory.
883	2	Hulk and the Agents of S.M.A.S.H.		Fred Tatasciore, Clancy Brown, Seth Green, Eliza Dushku, Ben Diskin	3	149	2012	8	2 Seasons	73	Hulk and friends battle against evil.
884	1	I'll Be Home for Christmas	Arlene Sanford	Jonathan Thomas, Jessica Biel, Adam LaVorgna, Gary Cole, Eve Gordon, Lauren Maltby	2	149	1998	5	87 min	56	A jokester zooms home for Christmas with a prize in mind – his dad's car!
885	1	Ice Age: The Great Egg-Scapade	Ricardo Curtis	Raymond Albert Romano, John Leguizamo, Denis Leary, Queen Latifah	3	149	2016	6	26 min	11	Our favorite Ice Age herd embarks on a rescue mission that turns into the world’s first egg hunt.
886	1	Ice Princess	Tim Fywell	Joan Cusack, Kim Cattrall, Michelle Trachtenberg, Hayden Panettiere, Trevor Blumas, Connie Ray	2	149	2005	2	99 min	3	A brainy ugly duckling realizes her dream of becoming a champion figure skater.
887	1	Inner Workings	Leo Matsuda	Este Haim, Tucker Gilmore, Raymond Persi, Terri Douglas	3	149	2016	2	6 min	11	The tug-of-war between Paul’s head and his heart.
888	1	Inside Out	Pete Docter	Amy Poehler, Phyllis Smith, Richard Kind, Bill Hader, Lewis Black, Mindy Kaling	3	149	2015	5	95 min	225	Five Emotions must work overtime when a young girl moves to a new city.
889	1	Inspector Gadget	David Kellogg	Matthew Broderick, Rupert Everett, Joely Fisher, Michelle Trachtenberg, Michael Hagerty, Andy Dick	3	149	1999	5	80 min	36	A security guard's dreams come true when he is transformed into the ultimate crime-fighting tool.
890	1	Inspector Gadget 2	Alex Zamm	French Stewart, Elaine Hendrix, Caitlin Wachs, Tony Martin, John Batchelor, Mark Mitchell	3	149	2003	2	90 min	36	While Inspector Gadget is on probation, Claw breaks out of jail, and the Mayor unveils a new gadget.
891	1	Into the Grand Canyon	Pete McBride		3	149	2019	1	82 min	217	Two friends set out to traverse the Grand Canyon by foot, revealing its beauty and challenges.
892	1	Into the Okavango	Neil Gelinas	Steve Boyes, Dr. Steve Boyes, Chris Boyes, Tumeletso Setlabosha, Gobonamang Kgetho, Adjany Costa	67	149	2018	1	94 min	217	Follow a team of explorers on an epic expedition to save the Okavango Delta.
893	1	Invincible	Ericson Core	Mark Wahlberg, Greg Kinnear, Elizabeth Banks, Michael Rispoli, Kevin Conway, Kirk Acevedo	3	149	2006	5	105 min	265	The story of a 30-year-old bartender who earned a chance to play for the Philadelphia Eagles.
894	1	Invisible Sister	Paul Hoen	Rowan Blanchard, Paris Berelc, Karan Brar, Rachel Crow, Alex Désert, Will Meyers	3	149	2015	6	79 min	266	A Halloween science experiment leaves Cleo's popular sister invisible.
895	2	Iron Man (Series)		Robert Hays, James Avery, Ed Gilbert, Jim Cummings, Tony Steedman, James Warwick	3	149	1994	8	1 Season	5	Industrialist Tony Stark leads a private team of superheroes as Iron Man against the forces of evil.
896	2	Iron Man Armored Adventures		Adrian Petriw, Daniel Bacon, Anna Cummer, Mackenzie Gray, Vincent Tong	68	149	2008	6	2 Seasons	173	After a tragic accident robs Tony of his father, he uses his new invincible armor to protect others.
897	1	Iron Will	Charles Haid	Mackenzie Astin, Kevin Spacey, David Ogden Stiers, August Schellenberg, Brian Cox, George Gerdes	3	149	1994	5	109 min	89	Will courageously joins a dogsled race that may save his family from ruin.
898	1	Jack	Francis Coppola	Robin Williams, Diane Lane, Brian Kerwin, Jennifer Lopez, Bill Cosby, Fran Drescher	3	149	1996	3	113 min	114	A mischievous 10-year-old boy lives life in a grown-up's body.
899	1	Jack-Jack Attack	Brad Bird	Bret Parker, Bud Luckey, Eli Fucile, Jason Lee	3	149	2005	2	6 min	11	Kari thinks she's in for a routine night babysitting.
900	1	James and the Giant Peach	Henry Selick	Miriam Margolyes, Joanna Lumley, Pete Postlethwaite, Paul Terry, Simon Callow, Richard Dreyfuss	25	149	1996	5	81 min	62	A young boy escapes his cruel home life when he discovers a giant peach.
901	1	Jane	Brett Morgen	Jane Goodall	3	149	2017	5	90 min	44	An intimate portrait of Jane Goodall’s groundbreaking chimpanzee research.
902	2	Jessie		Debby Ryan, Peyton List, Cameron Boyce, Karan Brar, Skai Jackson, Kevin Chamberlin	3	149	2011	1	4 Seasons	19	A small-town girl becomes a nanny for a quirky, rich family.
903	1	Jingle Pols		Dr. Pol	1	149	2013	7	45 min	267	Nat Geo WILD re-joins the Pols in central Michigan as they get into the Christmas spirit.
904	1	Johnny Kapahala: Back on Board	Eric Bross	Brandon Baker, Robyn Lively, Mary Keller, Yuji Okumoto, Jonathan McDaniel, Andrew Allen	3	149	2007	6	93 min	218	Johnny returns to Hawaii and has to babysit his 12-year-old "Uncle Chris."
905	1	Johnny Tsunami	Steve Boyum	Cary-Hiroyuki Tagawa, Brandon Baker, Yuji Okumoto, Mary Keller, Lee Young, Kirsten Storms	3	149	1999	6	92 min	218	A teen surfing sensation moves from Hawaii to a tiny Vermont ski town.
906	1	Jonas Brothers: The Concert Experience	Bruce Hendricks	Kevin Jonas, Joe Jonas, Nick Jonas, Demi Lovato, Taylor Swift, "Big Feggans	3	149	2009	2	89 min	259	An exclusive backstage pass into the world of the Jonas Brothers.
907	1	Journey to Shark Eden		Salvatore Vecchio	3	149	2010	6	47 min	217	A team of scientists explores pristine coral reefs around five remote islands near Tahiti.
908	1	Journey to the Center of the Earth	Henry Levin	Pat Boone, James Mason, Arlene Dahl, Diane Baker, Thayer David, Peter Ronson	3	149	1959	2	130 min	24	A professor and his colleague engage in a race to see who will reach the center of the Earth first.
909	1	Jump In!	Paul Hoen	Corbin Bleu, David Reivers, Shanica Knowles, Laivan Greene, Kylee Russell, Patrick Johnson Jr.	3	149	2007	6	86 min	268	A tough Brooklyn boxer agrees to join a Double Dutch jump rope team.
910	1	Jumping Ship	Michael Lange	Joey Lawrence, Matthew Lawrence, Andrew Lawrence, Susan Walters, Stephen Burleigh, Anthony Wong	69	149	2001	6	93 min	269	Modern-day pirates leave two cousins stranded on an island.
911	1	Jungle 2 Jungle	John Pasquin	Tim Allen, Martin Short, Lolita Davidovich, David Stiers, JoBeth Williams, Sam Huntington	66	149	1997	5	105 min	40	A Wall Street mogul learns he has a son who's been raised in the jungle.
912	1	Jungle Cat	James Algar	Winston Hibler	3	149	1960	1	70 min	142	An intimate glimpse into the life-and-death struggles of a jaguar family.
913	1	Kazaam	Paul Glaser	Shaquille O'Neal, Francis Capra, Ally Walker, James Acheson, John Costelloe, Marshall Manesh	3	149	1996	5	94 min	36	12-year-old Max Connor accidentally frees a 3,000-year-old genie.
914	2	Kickin' It		Leo Howard, Dylan Snyder, Mateo Arias, Olivia Holt, Alex Jones, Jason Earles	3	149	2010	1	4 Seasons	56	The series will follow the crew of lovable misfits.
915	1	Kim Possible	Adam Stein, Zach Lipovsky	Sadie Stanley, Sean Giambrone, Ciara Wilson, Taylor Ortega, Connie Ray, Issac Brown	3	149	2019	6	88 min	56	Kim Possible and Ron Stoppable take on high school.
916	1	Kim Possible Movie: So the Drama	Steve Loter	Christy Romano, Will Friedle, Nancy Cartwright, Tahj Mowry, Raven , Gary Cole	3	149	2005	6	70 min	173	Kim's new campus crush distracts her from Dr. Drakken's latest evil plot.
917	1	Kingdom of the Apes: Battle Lines		Dan Nachtrab	1	149	2017	1	44 min	10	Gorillas and chimpanzees stuggle for power and dominance within their clans.
918	1	Kingdom of the Blue Whale		Tom Selleck	3	149	2009	1	94 min	142	Marine scientists embark on a mission to uncover the mysteries of the blue whale.
919	2	Kingdom of the White Wolf		Jenny Jules	3	149	2019	1	1 Season	12	In the remote, majestic landcape of the high Arctic, a photographer seeks the legendary white wolf.
920	1	Kitbull	Rosana Sullivan		3	149	2019	5	9 min	41	An unlikely connection between a kitten and a pit bull sparks a unique friendship.
921	1	Knick Knack Theatrical Short	John Lasseter		1	149	2003	2	4 min	224	A snowman longs to break out of his snow globe.
922	1	Kronk's New Groove	Elliot Bour, Saul Blinkoff	Patrick Warburton, Tracey Ullman, Eartha Kitt, David Spade, John Goodman, Wendie Malick	3	149	2005	2	78 min	21	Kronk cooks up a get-rich-quick scheme to impress his Dad.
923	1	La Luna	Enrico Casarosa	Tony Fucile, Krista Sheffler, Phil Sheridan	3	149	2012	2	7 min	225	A peculiar story about a young boy coming of age.
924	2	Lab Rats		Billy Unger, Spencer Boldman, Kelli Berglund, Tyrel Williams, Hal Sparks	3	149	2011	8	4 Seasons	56	Leo discovers a secret underground lab with three experiments.
925	1	Lady and the Tramp	Charlie Bean	Tessa Thompson, Justin Theroux, Sam Elliott, Ashley Jensen, Janelle Monáe, Kiersey Clemons	3	149	2019	5	111 min	36	A house dog and a stray embark on an adventure and come to understand the value of home.
926	1	Lava	James Murphy	Kuana Kahele, Napua Greig	3	149	2015	2	9 min	270	A love story that takes place over millions of years.
927	2	LEGO Disney Frozen: Northern Lights (Shorts)			3	149	2016	8	1 Season	73	Anna and Elsa search for the missing Northern Lights.
928	2	LEGO Star Wars: All Stars		Jasmin Brown, Josh Peck, Zeno Robinson, Max Mittelman, Matthew Wood	3	149	2018	8	1 Season	73	Han, Chewie, Leia and more team up for new adventures!
929	2	LEGO Star Wars: All Stars (Shorts)		Matthew Wood, Yvette Brown, Nicolas Cantu, Carolyn Hennesy, Montse Hernandez, Vanessa Lengies	1	149	2018	8	1 Season	73	Roger, the lovable battle droid, tells his story.
930	2	LEGO Star Wars: Droid Tales		Tom Kane, Anthony Daniels, Trevor Devall, Kirby Morrow, Sam Vincent, Michael Donovan	3	149	2014	8	1 Season	73	C-3PO recounts the great adventures of the Rebels.
931	2	LEGO Star Wars: Resistance Rises (Shorts)			70	149	2015	9	1 Season	73	Follow five untold stories before the Force awakened.
932	2	LEGO Star Wars: The Freemaker Adventures		Matt Sloan, Trevor Devall, Greg Baldwin, Michael Daingerfield, Vanessa Lengies, Grey Griffin	3	149	2015	8	2 Seasons	73	12-year old Rowan Freemaker discovers the Kyber Saber.
933	2	LEGO Star Wars: The Freemaker Adventures (Shorts)			1	149	2016	8	1 Season	73	The Freemakers lend a helping hand to the rebel fleet.
934	1	LEGO Star Wars: The New Yoda Chronicles - Clash of the Skywalkers	Michael Hegner	Tom Kane, Anthony Daniels, Matt Sloan, Trevor Devall, Kirby Morrow, Sam Vincent	3	149	2014	8	24 min	73	The enraged Emperor sends Darth Vader to destroy Luke.
935	1	LEGO Star Wars: The New Yoda Chronicles - Raid on Coruscant	Michael Hegner	Tom Kane, Anthony Daniels, Matt Sloan, Trevor Devall, Kirby Morrow, Sam Vincent	71	149	2014	8	24 min	73	Luke Skywalker attempts a daring raid on Coruscant.
936	1	LEGO Star Wars: The New Yoda Chronicles – Duel of the Skywalkers	Michael Hegner	Tom Kane, Anthony Daniels, Matt Sloan, Trevor Devall, Kirby Morrow, Sam Vincent	3	149	2014	8	24 min	73	Luke Skywalker accidently opens a remaining holocron.
937	1	LEGO Star Wars: The New Yoda Chronicles – Escape from the Jedi Temple	Michael Hegner	Tom Kane, Anthony Daniels, Matt Sloan, Trevor Devall, Sam Vincent, Kelly Metzger	3	149	2014	8	24 min	73	Yoda and Obi-Wan recall freeing the Holocrons from the Temple.
938	1	LEGO Star Wars: The New Yoda Chronicles – Race for the Holocrons	Michael Hegner	Tom Kane, Anthony Daniels, Matt Sloan, Trevor Devall, Brian Drummond, Michael Donovan	3	149	2014	8	24 min	73	Obi-Wan urges Luke to travel to Tatooine.
939	1	Lemonade Mouth	Patricia Riggen	Bridgit Mendler, Adam Hicks, Hayley Kiyoko, Naomi Scott, Blake Michael, Nick Roux	3	149	2011	6	110 min	134	A ragtag group of freshmen come together in the name of rock 'n' roll.
940	1	Lend a Paw	Clyde Geronimi		3	149	1941	8	8 min	224	Pluto's jealousy of a kitten leaves him conflicted about rescuing it. See details for advisory.
941	1	Leroy & Stitch	Roberts Gannaway, Tony Craig	Daveigh Chase, Chris Sanders, David Stiers, Kevin McDonald, Tia Carrere, Kevin Michael Richardson	3	149	2006	2	76 min	73	Dr. Hamsterviel forces Jumba to create Leroy, the evil twin of Stitch.
942	1	Let it Shine	Paul Hoen	Tyler Williams, Coco Jones, Trevor Jackson, Brandon Smith, Dawnn Lewis, Alex Désert	3	149	2012	6	103 min	134	A true poet overcomes self-doubt and shows everyone his artistic genius.
943	1	Life is Ruff	Charles Haid	Kyle Massey, Kay Panabaker, Mitchel Musso, Carter Jenkins, Mark Lawrence, Judith Moreland	3	149	2005	6	85 min	264	A teenager enters an adopted mutt into a dog show to try to win $5000.
944	1	Life With Mikey	James Lapine	Michael Fox, Nathan Lane, Cyndi Lauper, David Krumholtz, David Huddleston, Christina Vidal	3	149	1993	5	92 min	147	An ex-child star struggling as an agent discovers a sassy new client.
945	1	Life-Size 2	Steven Tsuchida	Tyra Banks, Francia Raisa, Gavin Stenhouse, Hank Chen, Alison Fernandez, Shanica Knowles	3	149	2018	7	82 min	31	Eve magically awakes to help get Grace back on track.
946	1	Lifted	Gary Rydstrom		3	149	2006	2	5 min	11	A young alien bungles his first lesson in abduction.
947	1	Lilo & Stitch	Christopher Sanders, Dean DeBlois	Daveigh Chase, Christopher Sanders, Tia Carrere, David Ogden Stiers, Kevin McDonald, Ving Rhames	3	149	2002	1	86 min	62	A little girl adopts a wanted alien wreaking havoc on the Hawaiian Islands.
948	1	Lilo & Stitch 2: Stitch Has a Glitch	Tony Leondis, Michael LaBash	Christopher Sanders, Dakota Fanning, Tia Carrere, David Stiers, Kevin McDonald, Kunewa Mook	3	149	2005	5	70 min	216	A glitch sends Stich out of control just before Lilo's big hula contest.
949	2	Lizzie McGuire		Hilary Duff, Lalaine , Adam Lamberg, Jake Thomas, Hallie Todd, Robert Carradine	3	149	2000	6	2 Seasons	86	Lizzie McGuire has great friends, a great family and even great foes. Get inside her head.
950	1	Lonesome Ghosts	Burt Gillett		3	149	1937	8	9 min	224	Mickey Mouse, Donald Duck and Goofy run a ghost exterminating agency. See details for advisory.
951	2	Lost Treasures of the Maya		Albert Lin	72	149	2018	1	1 Season	139	A high-tech treasure map rewrites the history of the ancient Maya in the Guatemalan jungle.
952	1	Lou	Dave Mullins		3	149	2017	2	7 min	73	A toy-stealing bully meets his match in a Lost & Found box.
953	1	Luck of the Irish	Paul Hoen	Paul Kiernan, Timothy Omundson, Ryan Merriman, Glenndon Chatman, Henry Gibson, Marita Geraghty	3	149	2001	6	86 min	31	When his lucky charm is stolen, Kyle learns that he is part leprechaun.
954	1	Luxo Jr.			3	149	1986	2	2 min	11	A baby lamp finds a ball to play with.
955	1	Magician Mickey	David Hand	Pinto Colvig, Walt Disney, Clarence Nash	3	149	1937	1	8 min	11	Donald continually heckles Mickey's magic act. See details for advisory.
956	1	Mail Dog	Charles Nichols		3	149	1947	6	7 min	11	Pluto must deliver mail to a remote outpost. See details for advisory.
957	1	Man Among Cheetahs		Bob Poole	3	149	2017	1	44 min	142	A wildlife filmmaker tries to keep up with a cheetah mom determined to keep her cubs alive.
958	1	Mars: Inside SpaceX	Julia Reagan		3	149	2018	1	47 min	1	Go behind the scenes as Elon Musk and his engineers prepare for the Falcon Heavy rocket launch.
959	2	Marvel Comics X-Men		Cedric Smith, Catherine Disher, Alyson Court, Chris Potter, George Buza, Iona Morris	2	149	1992	8	5 Seasons	13	In the Marvel Comics universe mutants are persecuted by a hateful and fearful populous.
960	2	Marvel Rising: Initiation (Shorts)			3	149	2017	8	1 Season	5	Ghost-Spider is falsely accused of her friend's death.
961	1	Marvel Rising: Secret Warriors	Alfred Gimeno	Dee Baker, Chloe Bennet, Kathreen Khavari, Andrew Kishino, Meera Kumbhani, Kamil McFadden	3	149	2018	9	80 min	173	Marvel’s young powered heroes join forces to protect the Universe.
962	1	Marvel Studios: Assembling A Universe		Jeff McNeil, Meghan Leon, Jason Hillhouse, Robert Downey Jr., Clark Gregg, Jon Favreau	3	149	2014	1	43 min	271	An exclusive look inside the world of Marvel Studios.
963	1	Marvel Studios: Expanding the Universe			1	149	2019	1	13 min	160	An exciting look into the future of Marvel Studios’ films and upcoming Disney+ series.
964	1	Marvel Studios' Ant-Man	Peyton Reed	Paul Rudd, Evangeline Lilly, Corey Stoll, Bobby Cannavale, Michael Peña, Tip Harris	3	149	2015	3	119 min	157	Scott Lang and Dr. Hank Pym plan a heist that could save the world.
965	1	Marvel Studios' Avengers: Age of Ultron	Joss Whedon	Robert Downey Jr., Chris Hemsworth, Mark Ruffalo, Chris Evans, Scarlett Johansson, Jeremy Renner	3	149	2015	3	143 min	199	Tony Stark unwittingly creates an A.I. monster bent on destroying mankind.
966	1	Marvel Studios' Avengers: Endgame	Anthony Russo, Joe Russo	Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, Jeremy Renner	3	149	2019	3	183 min	65	The epic finale to the Infinity Saga, this dramatic showdown pits the Avengers against Thanos.
967	1	Marvel Studios' Captain America: Civil War	Anthony Russo, Joe Russo	Chris Evans, Robert Downey Jr., Scarlett Johansson, Sebastian Stan, Anthony Mackie, Don Cheadle	3	149	2016	3	150 min	199	Captain America and Iron Man clash, causing the Avengers to choose sides.
968	1	Marvel Studios' Captain America: The First Avenger	Joe Johnston	Chris Evans, Tommy Jones, Hugo Weaving, Hayley Atwell, Sebastian Stan, Dominic Cooper	3	149	2011	3	126 min	199	A top-secret research project turns Steve Rogers into Captain America.
969	1	Marvel Studios' Captain America: The Winter Soldier	Anthony Russo, Joe Russo	Chris Evans, Scarlett Johansson, Sebastian Stan, Anthony Mackie, Cobie Smulders, Frank Grillo	3	149	2014	3	138 min	199	Captain America and Black Widow join forces against the Winter Soldier.
970	1	Marvel Studios' Captain Marvel	Anna Boden, Ryan Fleck	Brie Larson, Samuel Jackson, Ben Mendelsohn, Djimon Hounsou, Lee Pace, Lashana Lynch	52	149	2019	3	126 min	199	Marvel Studios’ Captain Marvel launches the MCU’s most powerful hero.
971	1	Marvel Studios' Doctor Strange	Scott Derrickson	Benedict Cumberbatch, Chiwetel Ejiofor, Rachel McAdams, Benedict Wong, Michael Stuhlbarg, Benjamin Bratt	3	149	2016	3	116 min	272	A famous surgeon battles unseen forces bent on destroying our reality.
972	1	Marvel Studios' Guardians of the Galaxy	James Gunn	Chris Pratt, Zoë Saldana, Dave Bautista, Vin Diesel, Bradley Cooper, Lee Pace	3	149	2014	3	122 min	157	A group of misfit heroes become the object of an unrelenting bounty hunt.
973	1	Marvel Studios' Guardians of the Galaxy Vol. 2	James Gunn	Chris Pratt, Bradley Cooper, Vin Diesel, Pom Klementieff, Zoë Saldana, Dave Bautista	3	149	2017	3	137 min	157	The Guardians fight to keep their newfound family together as they discover Quill's parentage.
974	1	Marvel Studios' Iron Man	Jon Favreau	Robert Downey Jr., Terrence Howard, Jeff Bridges, Gwyneth Paltrow, Leslie Bibb, Shaun Toub	2	149	2008	3	127 min	199	Jet-setting industrialist Tony Stark vows to protect the world as Iron Man.
975	1	Marvel Studios' Iron Man 2	Jon Favreau	Robert Downey Jr., Gwyneth Paltrow, Don Cheadle, Scarlett Johansson, Sam Rockwell, Clark Gregg	3	149	2010	3	125 min	199	Inventor Tony Stark forges new alliances to confront powerful enemies.
976	1	Marvel Studios' Iron Man 3	Shane Black	Robert Downey Jr., Gwyneth Paltrow, Don Cheadle, Guy Pearce, Rebecca Hall, Stephanie Szostak	3	149	2013	3	132 min	199	His personal world destroyed, Tony Stark embarks on a harrowing quest to find those responsible.
977	1	Marvel Studios' The Avengers	Joss Whedon	Robert Downey Jr., Chris Evans, Mark Ruffalo, Chris Hemsworth, Scarlett Johansson, Jeremy Renner	3	149	2012	3	145 min	65	Nick Fury recruits a team of heroes to battle an unexpected enemy.
978	1	Marvel Studios' Thor	Kenneth Branagh	Chris Hemsworth, Natalie Portman, Tom Hiddleston, Anthony Hopkins, Stellan Skarsgård, Kat Dennings	3	149	2011	3	116 min	272	Thor, Asgard's greatest hero, reignites an ancient war that he must take part in from Earth.
979	1	Marvel Studios' Thor: The Dark World	Alan Taylor	Chris Hemsworth, Natalie Portman, Tom Hiddleston, Anthony Hopkins, Rene Russo, Stellan Skarsgård	3	149	2013	3	114 min	65	Thor must set out on his most dangerous and personal journey yet.
980	2	Marvel Ultimate Spider-Man		Drake Bell, Chi McBride, Steven Weber, J.K. Simmons, Tom Kenny, Clark Gregg	3	149	2011	8	4 Seasons	13	Spider-Man trains alongside four fellow teenage superheroes.
981	2	Marvel's Agent Carter		Hayley Atwell, James D'Arcy, Chad Murray, Enver Gjokaj, Shea Whigham	3	149	2014	7	2 Seasons	273	Working for SSR, Peggy would rather be in the field.
982	2	Marvel's Ant-Man (Shorts)			3	149	2016	8	1 Season	73	Ant-Man protects the world one inch at a time!
983	2	Marvel's Avengers Assemble		Adrian Pasdar, Fred Tatasciore, Roger Smith, Travis Willingham, Troy Baker, Bumper Robinson	3	149	2012	8	5 Seasons	5	Marvel’s mightiest heroes combine their power.
984	2	Marvel's Avengers: Secret Wars (Shorts)			1	149	2016	8	1 Season	5	A new team of heroes joins the Avengers.
985	2	Marvel's Guardians of the Galaxy (Series)		Will Friedle, Trevor Devall, Kevin Richardson, Vanessa Marshall, David Sobolov	3	149	2015	8	3 Seasons	5	The Guardians find a map leading to a powerful weapon.
986	2	Marvel's Guardians of the Galaxy (Shorts)			1	149	2014	8	2 Seasons	5	The stories of five outlaws who became the Guardians.
987	2	Marvel's Hero Project			3	149	2019	1	1 Season	45	Celebrate the inspiring efforts of young, real life heroes as they join Marvel’s Hero Project.
988	2	Marvel's Inhumans		Anson Mount, Serinda Swan, Ken Leung, Eme Ikwuakor, Isabelle Cornish, Ellen Woglom	3	149	2017	7	1 Season	199	The never-before-told adventure of the Royal Family.
989	2	Marvel's Rocket & Groot (Shorts)			1	149	2016	8	1 Season	135	Rocket and Groot shop for a new ship.
990	2	Marvel's Ultimate Comics		Cole Howard, Brian Drummond	1	149	2016	8	1 Season	73	Spidey and Iron Man team-up. Black Panther vs. Ghost.
991	1	Mary Poppins	Robert Stevenson	Julie Andrews, Dick Van Dyke, David Tomlinson, Glynis Johns, Hermione Baddeley, Karen Dotrice	3	149	1964	2	142 min	117	A magical nanny reconnects a father and mother with their two children.
992	1	Mater and the Ghostlight	John Lasseter	Larry the Cable Guy , Owen Wilson, Michael Wallis, Bonnie Hunt, Paul Newman, Cheech Marin	3	149	2006	8	8 min	11	Mater ponders if the legend of the Ghostlight is true.
993	1	Meet the Deedles	Steve Boyum	Paul Walker, Steve Wormer, John Ashton, A.J. Langer, Robert Englund, Megan Cavanagh	3	149	1998	5	94 min	274	Two surfer dudes try to stop an ex-park ranger from stealing Old Faithful.
994	1	Meet the Robinsons	Stephen Anderson	Angela Bassett, Daniel Hansen, Jordan Fry, Matthew Josten, John Ford, Dara McGarry	3	149	2007	2	97 min	62	A young inventor uses time travel to find the family he never knew.
995	1	Melody Time	Clyde Geronimi, Jack Kinney, Hamilton Luske	Roy Rogers, Trigger , Dennis Day, The Andrews Sisters , Fred Waring and His Pennsylvanians , Freddy Martin	3	149	1948	1	76 min	39	Classic stories blend high-spirited music and unforgettable characters. See details for advisory.
996	1	Mickey Down Under	Charles Nichols		3	149	1948	6	7 min	11	Mickey and Pluto vacation in Australia. See details for advisory.
997	2	Mickey Mouse (Shorts)			3	149	2012	6	5 Seasons	38	All-new series of cartoon shorts, Mickey Mouse finds himself in silly situations around the world!
998	2	Mickey Mouse Club (1955-59)			3	149	1955	1	1 Season	275	The Mickey Mouse Club is a variety show featuring the Mouseketeers. See details for advisory.
999	1	Mickey, Donald, Goofy: The Three Musketeers	Donovan Cook	Wayne Allwine, Tony Anselmo, Bill Farmer, Russi Taylor, Tress MacNeille, Jim Cummings	3	149	2004	2	71 min	62	An animated version of the classic tale starring three Disney favorites.
1000	1	Mickey's Birthday Party	Riley Thomson	Walt Disney, Thelma Boardman, Pinto Colvig, Clarence Nash, Florence Gill	3	149	1942	6	9 min	11	The gang gives Mickey a surprise birthday party. See details for advisory.
1001	1	Mickey's Christmas Carol	Burny Mattinson	Alan Young, Wayne Allwine, Hal Smith, Will Ryan, Eddy Carroll, Patricia Parris	3	149	1983	2	26 min	11	All your Disney pals star in this retelling of a Dickens Christmas classic.
1002	1	Mickey's Delayed Date	Charles Nichols		3	149	1947	6	7 min	11	Pluto helps Mickey get ready when he forgets about his big date. See details for advisory.
1003	1	Mickey's Once Upon a Christmas	Bradley Raymond, Jun Falkenstein, Bill Speers	Kelsey Grammer, Wayne Allwine, Russi Taylor, Tony Anselmo, Diane Michelle, Tress MacNeille	3	149	1999	6	67 min	241	Join Mickey and his pals for tales of their most memorable Christmases.
1004	1	Mickey's Rival	Wilfred Jackson, Walt Disney	Walt Disney, Marcelite Garner, Sonny Dawson	3	149	1936	6	9 min	11	Mickey's rival, Mortimer, strives for Minnie's affections. See details for advisory.
1005	1	Mickey's Trailer	Ben Sharpsteen	Clarence Nash, Pinto Colvig, Walt Disney	3	149	1938	1	8 min	11	Mickey, Donald and Goofy are on an adventurous car trip. See details for advisory.
1006	1	Mickey's Twice Upon a Christmas	Matthew O'Callaghan	Wayne Allwine, Tony Anselmo, Jeff Bennett, Jim Cummings, Bill Farmer, Tress MacNeille	3	149	2004	2	70 min	241	Mickey and his pals learn the true meaning of Christmas…with Santa's help.
1007	1	Mighty Joe Young	Ron Underwood	Bill Paxton, Charlize Theron, Rade Šerbedžija, Regina King, Peter Firth, Naveen Andrews	3	149	1998	5	116 min	186	Taken to Hollywood to hide, a mighty gorilla is chased by a hunter.
1008	1	Mike's New Car	Pete Docter, Roger Gould	Billy Crystal, John Goodman	3	149	2002	6	5 min	41	Mike and Sulley try to take Mike's new car for a ride.
1009	1	Minutemen	Lev Spiro	Jason Dolley, Luke Benward, Nicholas Braun, Chelsea Staub, Steven McQueen, Kara Crane	3	149	2008	6	91 min	157	Three teen outcasts invent a time machine to save their social lives.
1010	1	Miracle	Gavin O'Connor	Kurt Russell, Patricia Clarkson, Noah Emmerich, Sean McCann, Kenneth Welsh, Eddie Cahill	15	149	2004	5	137 min	276	The story of the 1980 U.S. Olympic hockey team's win over a seemingly invincible Soviet squad.
1011	1	Miracle at Midnight	Ken Cameron	Sam Waterston, Mia Farrow, Justin Whalin, Patrick Malahide, Benedick Blythe	3	149	1998	7	89 min	141	A family risks their lives to help their neighbors escape the Nazis.
1012	1	Miracle in Lane 2	Greg Beeman	Frankie Muniz, Rick Rossovich, Molly Hagan, Patrick Levis, Roger Brown, Tuc Watkins	3	149	2000	6	90 min	129	A physically challenged boy strives to compete in a national soapbox derby.
1013	1	Miracle Landing on the Hudson		Todd Boyce, Miriam Lucia, James McGregor, Nathan Nolan, Phillip Wright	3	149	2014	6	44 min	277	The true story of the terrifying, ultimately triumphant landing of Flight 1549 in the Hudson River.
1014	1	Mission to the Sun	Daniel Smith	Henry Goodman, Jack Baker	3	149	2018	1	44 min	1	A NASA mission to study the sun gathers data on potentially devastating solar storms.
1015	1	Moana	John Musker, Ron Clements	Auli'i Cravalho, Dwayne Johnson, Rachel House, Temuera Morrison, Nicole Scherzinger, Jemaine Clement	3	149	2016	5	108 min	62	Moana and Maui set sail on a journey across the ocean to save the world.
1016	1	Mom's Got a Date With a Vampire	Stephen Boyum	Matthew O'Leary, Laura Vandervoort, Myles Jeffrey, Caroline Rhea, Charles Shaughnessy, Robert Carradine	15	149	2000	1	83 min	109	Two kids set up their mom on a date with a vampire.
1017	1	Monsters University	Dan Scanlon	Billy Crystal, John Goodman, Steve Buscemi, Helen Mirren, Peter Sohn, Joel Murray	3	149	2013	2	104 min	41	Discover how Mike and Sulley first met at Monsters University.
1018	1	Monsters, Inc.	Pete Docter	John Goodman, Billy Crystal, Mary Gibbs, Steve Buscemi, James Coburn, Jennifer Tilly	3	149	2001	2	93 min	41	A little girl named Boo wanders into the world of monsters.
1019	1	Motocrossed	Steve Boyum	Alana Austin, Riley Smith, Mary-Margaret Humes, Trever O'Brien, Timothy Carhart, Scott Terra	3	149	2001	6	92 min	278	Andi takes her brother's spot in a motocross race after he injures his leg.
1020	1	Mr. Boogedy	Oz Scott	Richard Masur, Mimi Kennedy, Benjamin Gregory, David Faustino, Kristy Swanson, Howard Witt	3	149	1986	1	46 min	109	A New England family finds their new home is haunted by a local legend.
1021	1	Mr. Duck Steps Out	Jack King		3	149	1940	6	9 min	11	Donald attempts to court Daisy. See details for advisory.
1022	1	Mr. Mouse Takes a Trip	Clyde Geronimi		3	149	1940	6	8 min	11	Mickey Mouse and Pluto hit the road - and run into trouble. See details for advisory.
1023	1	Mulan II	Darrell Rooney, Lynne Southerland	Ming-Na Wen, B.D. Wong, Mark Moseley, Lucy Liu, Harvey Fierstein, Sandra Oh	73	149	2005	2	82 min	62	Mulan must complete a dangerous mission before marrying General Shang.
1024	2	Muppet Moments (Shorts)			3	149	2014	8	1 Season	279	Join the Muppets as they share unforgettable moments.
1025	1	Muppet Treasure Island	Brian Henson	Tim Curry, Kevin Bishop, Billy Connolly, Jennifer Saunders, Dave Goelz, Steve Whitmire	3	149	1996	2	101 min	36	The classic pirate tale gets a fun and zany Muppet twist.
1026	1	Muppets Most Wanted	James Bobin	Ricky Gervais, Ty Burrell, Tina Fey, Steve Whitmire, Eric Jacobson, Dave Goelz	3	149	2014	5	111 min	36	The Muppets find themselves entangled in an international crime caper.
1027	1	My Favorite Martian	Donald Petrie	Jeff Daniels, Christopher Lloyd, Elizabeth Hurley, Daryl Hannah, Wallace Shawn, Christine Ebersole	3	149	1999	5	94 min	266	A TV reporter happens on the story of the millennium when a Martian lands on Earth.
1029	1	National Treasure: Book of Secrets	Jon Turteltaub	Nicolas Cage, Jon Voight, Harvey Keitel, Ed Harris, Diane Kruger, Justin Bartha	3	149	2007	5	125 min	188	Ben Gates must kidnap the president to prove his ancestor's innocence.
1030	1	Newsies	Kenny Ortega	Christian Bale, David Moscow, Bill Pullman, Gabriel Damon, Luke Edwards, Max Casella	3	149	1992	5	122 min	166	New York City paperboys battle a greedy newspaper tycoon in 1899.
1031	1	Newsies: The Broadway Musical	Jeff Calhoun, Brett Sullivan	Jeremy Jordan, Kara Lindsay, Ben Fankhauser, Andrew Keenan-Bolger, Steve Blanchard, Aisha de Haas	3	149	2017	5	134 min	166	Gutsy newsboys take on newspaper titans in 1899. Filmed live in Hollywood.
1032	1	Noelle	Marc Lawrence	Anna Kendrick, Bill Hader, Kingsley Ben-Adir, Billy Eichner, Julie Hagerty, Shirley MacLaine	3	149	2019	2	105 min	54	Kris Kringle's daughter must find her brother and bring him back in time to save Christmas.
1033	1	Now You See It	Duwayne Dunham	Alyson Michalka, Johnny Pacar, Frank Langella, Brendan Hill, Chris Olivero, Gabriel Sunday	3	149	2005	6	89 min	71	An aspiring TV producer searches for the world's greatest kid magician.
1034	1	Olaf's Frozen Adventure	Stevie Wermers-Skelton, Kevin Deters	Josh Gad, Idina Menzel, Kristen Bell, Jonathan Groff, Chris Williams, John de Lancie	3	149	2017	2	25 min	11	Olaf and Sven set out to save Christmas for Anna and Elsa.
1035	1	Old Yeller	Robert Stevenson	Dorothy McGuire, Fess Parker, Jeff York, Chuck Connors, Beverly Washburn, Tommy Kirk	3	149	1957	2	84 min	47	The quintessential film about a boy's love for his dog.
1036	1	Oliver & Company	George Scribner	Joey Lawrence, Billy Joel, Cheech Marin, Richard Mulligan, Roscoe Browne, Sheryl Ralph	3	149	1988	2	76 min	200	A feisty young cat explores New York in this animated spin on Oliver Twist.
1037	1	Once Upon a Mattress	Kathleen Marshall	Carol Burnett, Tracey Ullman, Denis O'Hare, Zooey Deschanel, Michael Boatman, Edward Hibbert	3	149	2005	1	88 min	54	A fractured retelling of the classic "The Princess and The Pea."
1038	1	One Magic Christmas	Phillip Borsos	Mary Steenburgen, Gary Basaraba, Elizabeth Harnois, Arthur Hill, Wayne Robson, Jan Rubes	15	149	1985	2	89 min	280	A young mother rediscovers the joy of Christmas thanks to the unshakable faith of her daughter.
1039	1	One Man Band	Mark Andrews, Andrew Jimenez		3	149	2006	2	5 min	11	A girl gets caught in the middle of a musical duel.
1040	1	Operation Dumbo Drop	Simon Wincer	Danny Glover, Ray Liotta, Denis Leary, Doug Doug, Corin Nemec, Tcheky Karyo	3	149	1995	5	109 min	281	Soldiers secretly transport an elephant across 200 miles of rugged terrain.
1041	2	Origins: The Journey of Humankind		Mark Monroe, Jason Silva	3	149	2016	7	1 Season	139	Hosted by Jason Silva, this eight-part series illuminates key developments in human culture.
1042	2	Out of the Box		Vivian Bayubay, Tony James, Jill Schackner, Aleisha Allen, Cece Cortes, Nicholas Eng	3	149	1998	6	3 Seasons	282	A group of children come and play in a clubhouse made entirely out of painted cardboard boxes.
1043	1	Paris To Pittsburgh	Sidney Beaumont, Michael Bonfiglio	Rachel Brosnahan	3	149	2018	1	77 min	1	Americans are demanding action on climate change and taking matters into their own hands.
1044	1	Partly Cloudy	Peter Sohn	Tony Fucile, Lori Richardson	3	149	2009	2	6 min	11	Cloud people bring babies to life to storks to deliver
1045	1	Party Central	Kelsey Mann	John Goodman, Billy Crystal, Dave Foley, Sean Hayes, Joel Murray, Charlie Day	3	149	2014	5	7 min	11	Mike and Sulley return to Monsters University.
1046	1	Perri	N. Paul Kenworthy, Ralph Wright	Winston Hibler	3	149	1957	2	75 min	142	The story of a little Pine Squirrel named Perri and her life in the forest.
1047	1	Pete's Dragon	David Lowery	Bryce Howard, Oakes Fegley, Wes Bentley, Karl Urban, Oona Laurence, Isiah Whitlock Jr.	3	149	2016	5	106 min	30	A mysterious boy claims to live in the woods with a giant green dragon.
1048	1	Peter Pan	Hamilton Luske, Clyde Geronimi, Wilfred Jackson	Bobby Driscoll, Kathryn Beaumont, Hans Conried, Bill Thompson, Heather Angel, Paul Collins	3	149	1953	2	79 min	62	Adventures await when Peter Pan and his friends fly to Never Land. See details for advisory.
1049	1	Peter Pan: Return to Never Land	Robin Budd	Harriet Owen, Blayne Weaver, Corey Burton, Jeff Bennett, Kath Soucie, Andrew McDonough	74	149	2002	2	77 min	62	Wendy's daughter Jane is whisked away to Never Land by Captain Hook.
1050	1	Phantom of the Megaplex	Blair Treu	Taylor Handley, Corinne Bohrer, Caitlin Wachs, Jacob Smith, Rich Hutchman, John Novak	2	149	2000	6	89 min	48	A phantom haunting a local megaplex threatens to ruin a premiere gala.
1051	2	Phil of the Future		Ricky Ullman, Amy Bruckner, Craig Anton, Lise Simms, Alyson Michalka	3	149	2003	6	2 Seasons	86	Phil is just your average teenager – whose family crash-landed here from the year 2121.
1052	2	Phineas and Ferb		Vincent Martella, Ashley Tisdale, Thomas Sangster, Caroline Rhea, Alyson Stoner, Mitchel Musso	75	149	2007	6	4 Seasons	73	Phineas and Ferb have big summertime adventures with friends.
1053	1	Phineas and Ferb the Movie: Across the 2nd Dimension	Dan Povenmire, Robert Hughes	Vincent Martella, Ashley Tisdale, Thomas Brodie-Sangster, Caroline Rhea, Richard O'Brien, Dan Povenmire	76	149	2011	6	79 min	73	Phineas and Ferb jump dimensions and learn Perry is a real secret agent.
1054	1	Phineas and Ferb: Mission Marvel	Robert Hughes, Sue Perrotto	Vincent Martella, Ashley Tisdale, Thomas Brodie-Sangster, Caroline Rhea, Richard O'Brien, Dan Povenmire	1	149	2013	6	46 min	73	Two Universes Collide In One Epic Adventure!
1055	1	Piglet's Big Movie	Francis Glebas	John Fiedler, Jim Cummings, Andre Stojka, Kath Soucie, Nikita Hopkins, Peter Cullen	3	149	2003	2	78 min	5	When Piglet disappears, his friends band together to find him.
1056	1	Pinocchio	Ben Sharpsteen, Hamilton Luske	Dickie Jones, Christian Rub, Cliff Edwards, Evelyn Venable, Walter Catlett, Charles Judels	3	149	1940	2	90 min	111	A little wooden puppet yearns to become a real boy.
1057	1	Piper	Alan Barillaro		3	149	2016	2	6 min	283	A sandpiper exploring by the shore encounters scary waves.
1058	1	Pirates of the Caribbean: At World's End	Gore Verbinski	Johnny Depp, Orlando Bloom, Keira Knightley, Stellan Skarsgård, Bill Nighy, Chow Yun-Fat	3	149	2007	3	169 min	17	An alliance forms to rescue Captain Jack Sparrow from Davy Jones' locker.
1059	1	Pirates of the Caribbean: Dead Man's Chest	Gore Verbinski	Johnny Depp, Orlando Bloom, Keira Knightley, Stellan Skarsgård, Bill Nighy, Jack Davenport	3	149	2006	3	152 min	17	Captain Jack Sparrow must seize the "Dead Man's Chest" to cheat death.
1060	1	Pirates of the Caribbean: The Curse of the Black Pearl	Gore Verbinski	Johnny Depp, Geoffrey Rush, Orlando Bloom, Keira Knightley, Jack Davenport, Kevin McNally	3	149	2003	3	144 min	17	Jack Sparrow and Will Turner partner to save the governor's daughter.
1062	1	Pixel Perfect	Mark Dippé	Ricky Ullman, Leah Pipes, Spencer Redford, Chris Williams, Tania Gunadi, Porscha Coleman	3	149	2004	6	90 min	171	A techno whiz must protect his hologram from falling into the wrong hands.
1063	1	Planet of the Birds		Rodd Houston	1	149	2018	1	45 min	142	Tough and versatile, birds live in almost every habitat across the world.
1064	1	Pluto and the Gopher	Charles Nichols		3	149	1950	1	7 min	11	Pluto tries to catch a gopher in Minnie's garden. See details for advisory.
1065	1	Pluto's Christmas Tree	Jack Hannah	Jimmy MacDonald, Pinto Colvig, Clarence Nash, Ruth Clifford, Dessie Miller	3	149	1952	8	7 min	224	Pluto and Mickey bring home a special Christmas Tree. See details for advisory.
1066	1	Pluto's Surprise Package	Charles Nichols		3	149	1949	6	7 min	11	Pluto tries to bring in the mail, but one parcel refuses to cooperate. See details for advisory.
1067	1	Pluto's Sweater	Charles Nichols		3	149	1949	6	7 min	11	Pluto hates the sweater that Minnie knits for him. See details for advisory.
1068	1	Pocahontas	Mike Gabriel, Eric Goldberg	Irene Bedard, Judy Kuhn, Mel Gibson, David Ogden Stiers, John Kassir, Russell Means	3	149	1995	2	85 min	62	Free-spirited Pocahontas must find her own path.
1069	1	Pocahontas II: Journey to a New World	Bradley Raymond, Tom Ellery	Irene Bedard, Jim Cummings, Donal Gibson, Finola Hughes, Linda Hunt, Judy Kuhn	3	149	1998	2	77 min	62	Pocahontas sets sail for England and the allure of life in a new land.
1070	1	Pollyanna	David Swift	Jane Wyman, Richard Egan, Karl Malden, Nancy Olson, Adolphe Menjou, Donald Crisp	3	149	1960	2	135 min	166	An orphan brings sunshine into the lives of everyone she meets, despite her stifling aunt.
1071	1	Pooh's Grand Adventure: The Search for Christopher Robin	Karl Geurs	Jim Cummings, John Fiedler, Ken Sansom, Andre Stojka, Peter Cullen, Brady Bluhm	3	149	1997	6	78 min	5	Pooh and his pals set off on an adventure to find their best friend.
1072	1	Pooh's Heffalump Movie	Frank Nissen	Jim Cummings, John Fiedler, Nikita Hopkins, Kath Soucie, Ken Sansom, Peter Cullen	3	149	2005	2	73 min	5	Pooh and his friends are shocked when Roo befriends a playful Heffalump.
1073	1	Presto	Doug Sweetland		3	149	2008	2	5 min	224	Presto forgets to feed his rabbit one too many times.
1074	1	Princess Protection Program	Allison Liddi-Brown	Demi Lovato, Selena Gomez, Nicholas Braun, Molly Hagan, Johnny Rodriguez, Jamie Chung	3	149	2009	6	90 min	147	Royalty and roughing it collide when a princess moves in with a tomboy.
1075	1	Purl	Kristen Lester	Bret Parker, Emily Davis, Kelsey Mann, Austin Madison, Erik Langley, Michael Daley	3	149	2019	5	12 min	11	Purl gets a job at a start-up and must decide how far is she willing to go to be accepted.
1076	2	Quack Pack		Tony Anselmo, James Avery, Brian Cummings, E.G. Daily, Jeannie Elias, Pamela Segall	3	149	1996	4	1 Season	73	This cartoon follows on from the 1980's cartoon "DuckTales".
1077	1	Queen of Katwe	Mira Nair	David Oyelowo, Lupita Nyong'o, Madina Nalwanga, Martin Kabanza, Taryn Kyaze, Esther Tebandeke	3	149	2016	5	125 min	129	A Ugandan girl’s life changes forever when she discovers she has an amazing talent for chess.
1078	1	Quints	Bill Corcoran	Kimberly Brown, Daniel Roebuck, Elizabeth Morehead, Shadia Simmons, Jake Epstein, Vince Corazza	15	149	2000	6	83 min	48	Jamie is the center of attention until her mom gives birth to quintuplets.
1079	1	Ratatouille	Brad Bird	Patton Oswalt, Ian Holm, Lou Romano, Brian Dennehy, Peter Sohn, Peter O'Toole	3	149	2007	2	111 min	11	A determined young rat dreams of becoming a French chef.
1080	1	Read It and Weep	Paul Hoen	Kay Panabaker, Jason Dolley, Robin Riker, Tom Virtue, Alexandra Krosney, Danielle Panabaker	3	149	2006	6	85 min	114	Jamie's journal accidentally becomes a best-selling book.
1081	1	Ready to Run	Duwayne Dunham	Krissy Perez, Jason Dohring, Lillian Hurst, Jon Brazier, Nestor Serrano, Theresa Saldana	77	149	2000	6	89 min	285	Corrie dreams of becoming a jockey despite her father's race-related death.
1082	1	Recess: All Growed Down	Howy Parkins, Chuck Sheetz	Rickey Collins, Jason Davis, Ashley Johnson, Myles Jeffrey, Andrew Lawrence, Ross Malinger	3	149	2003	2	61 min	11	T.J. and the gang are captured by the kindergartners.
1083	1	Recess: School's Out	Chuck Sheetz	Rickey Collins, Jason Davis, Ashely Johnson, Andy Lawrence, Courtland Mead, Pam Segall	29	149	2001	2	87 min	11	Third Street Elementary students band together to save summer break.
1084	1	Recess: Taking the 5th Grade	Howy Parkins	Rickey Collins, Jason Davis, Myles Jeffrey, Ashley Johnson, Courtland Mead, Pamela Adlon	3	149	2003	2	63 min	11	The gang graduates to the fifth grade but discovers some unwelcome changes.
1085	1	Red's Dream	John Lasseter		3	149	1987	6	4 min	221	Red, a unicycle, dreams that he steals the show.
1086	1	Remember the Titans	Boaz Yakin	Denzel Washington, Will Patton, Donald Faison, Wood Harris, Ryan Hurst, Ethan Suplee	3	149	2000	5	114 min	276	An African-American coach leads a newly integrated high school football team in 1970s Virginia.
1087	1	Rescue Dog	Charles Nichols		3	149	1947	6	7 min	11	Rescue dog Pluto must deal with a playful seal pup. See details for advisory.
1088	1	Return from Witch Mountain	John Hough	Bette Davis, Christopher Lee, Kim Richards, Ike Eisenmann, Jack Soo, Anthony James	3	149	1978	2	94 min	24	Sinister masterminds manipulate a boy's supernatural powers for their own devious gain.
1089	1	Return to Halloweentown	David Jackson	Sara Paxton, Judith Hoag, Lucas Grabeel, J. Zimmerman, Kristy Wu, Keone Young	3	149	2006	1	89 min	286	Marnie Piper holds the key to Witch University's ultimate secret.
1090	1	Return to Oz	Walter Murch	Nicol Williamson, Jean Marsh, Piper Laurie, Matt Clark, Fairuza Balk, Michael Sundin	25	149	1985	5	110 min	30	Dorothy battles the wicked Princess Mombi and the evil Nome King to restore the Emerald City.
1091	1	Richie Rich's Christmas Wish	John Murlowski	David Gallagher, Eugene Levy, Keene Curtis, Jake Richardson, Martin Mull, Lesley Warren	3	149	1998	2	85 min	36	A wishing machine transports Richie Rich to an alternate universe.
1092	1	Right on Track	Duwayne Dunham	Beverley Mitchell, Brie Larson, Marcus Toji, Jodi Russell, Jon Lindstrom, Ruby O'Neil	3	149	2003	6	88 min	287	Two sisters fight for their place in male-dominated junior drag racing.
1093	1	Riley’s First Date?	Josh Cooley	Lori Alan, Carlos Alazraqui, Lewis Black, Josh Cooley, Ben Cox, Kaitlyn Dias	3	149	2015	2	8 min	21	A boy shows up at Riley's door.
1094	1	Rip Girls	Joyce Chopra	Camilla Belle, Dwier Brown, Stacie Hess, Brian Stark, Jeanne Mori, Lauren Sinclair	69	149	2000	6	87 min	70	Sydney questions a decision to sell her inherited Hawaiian land.
1095	1	Robin Hood	Wolfgang Reitherman	Roger Miller, Peter Ustinov, Terry-Thomas , Brian Bedford, Monica Evans, Phil Harris	3	149	1973	2	85 min	62	Disney's animated classic tale of England's legendary hero.
1096	2	Rocky Mountain Animal Rescue		Chopper Bernet	3	149	2018	1	1 Season	4	Officers and vets in the Pike's Peak area of Colorado handle thousands of animal emergencies a year.
1097	1	Rogue One: A Star Wars Story	Gareth Edwards	Felicity Jones, Diego Luna, Ben Mendelsohn, Donnie Yen, Mads Mikkelsen, Alan Tudyk	3	149	2016	3	134 min	23	Unlikely heroes band together to steal the plans to the Death Star.
1098	1	Roving Mars	George Butler	Paul Newman, Steve Squyres, Rob Manning, Dr. Elachi, Wayne Lee	3	149	2006	2	41 min	160	Explore the surface of the red planet through the eyes of two NASA rovers.
1099	1	Ruby Bridges	Euzhan Palcy	Penelope Miller, Kevin Pollak, Michael Beach, Jean Kelly, Peter James, Patrika Darbo	3	149	1998	1	90 min	288	A little girl becomes the first African-American to integrate her school.
1100	1	Sacred Planet	Jon Long	Robert Redford, Arapata McKay, Tsaan Ciqae, Mae Tui, Cy Peck Jr., Mutang Urud	78	149	2004	2	47 min	142	Visit some of the most exotic and beautiful places still in existence.
1101	1	Saludos Amigos	Bill Roberts, Jack Kinney, Ham Luske	Fred Shields	3	149	1943	1	42 min	11	Four animated shorts with Donald Duck and Goofy are set to a samba beat. See details for advisory.
1102	1	Sammy, The Way-Out Seal	Norman Tokar	Jack Carson, Robert Culp, Patricia Barry, Elisabeth Fraser, Michael McGreevey, Billy Mummy	3	149	1962	6	43 min	178	Two young brothers adopt an injured seal…without telling their parents. See details for advisory.
1103	1	Sanjay's Super Team	Sanjay Patel	Brenton Schraff, Sunny Attar, Arun Rao, Jaquelynn Herrera	3	149	2015	5	7 min	62	Young Sanjay daydreams of Hindu gods as superheroes.
1104	1	Santa Paws 2: The Santa Pups	Robert Vince	Cheryl Ladd, George Newbern, Pat Finn, Danny Woodburn, Obba Babatunde, Paul Rae	3	149	2012	2	92 min	82	When holiday spirit mysteriously begins to disappear, the Santa Pups race to save Christmas.
1105	1	Santa's Workshop	Wilfred Jackson		3	149	1932	6	7 min	111	Santa and his elves make toys to deliver on Christmas Eve See details for advisory.
1106	1	Saving Mr. Banks	John Hancock	Emma Thompson, Tom Hanks, Colin Farrell, Paul Giamatti, Jason Schwartzman, Bradley Whitford	10	149	2013	3	129 min	288	Discover the untold story behind Walt Disney's 20-year effort to bring "Mary Poppins" to life.
1107	1	Science Fair	Cristina Costantini, Darren Foster	Anjali Chadha, Ryan Folz, Harsha Paladugu, Abraham Riedel-Mishaan, Kashfia Rahman, Ivo Zell	3	149	2018	5	91 min	160	Nine high school students compete at the International Science and Engineering Fair.
1108	1	Sea of Hope: America's Underwater Treasures	Robert Nixon	Max Kennedy	3	149	2017	1	47 min	217	Oceanographer Sylvia Earle sets out to inspire the creation of 'blue parks' to protect the ocean.
1109	1	Secret of The Wings	Peggy Holmes	Mae Whitman, Lucy Hale, Timothy Dalton, Jeff Bennett, Lucy Liu, Raven-Symoné	79	149	2012	2	79 min	20	Tink crosses into the forbidden Winter Woods and finds she has a sister.
1110	1	Secretariat	Randall Wallace	Diane Lane, John Malkovich, Dylan Walsh, James Cromwell, Kevin Connolly, Nelsan Ellis	3	149	2010	5	124 min	289	A housewife becomes the unlikely owner of a racehorse, then risks it all to make him a champion.
1111	1	Secrets of Christ's Tomb: Explorer Special	Bob Strange		3	149	2017	1	47 min	122	A team of experts races to repair the structure housing Christ’s tomb.
1112	1	Secrets of Life	James Algar	Winston Hibler	3	149	1956	1	70 min	142	Discover Mother Nature’s secrets with a look at our ever-evolving planet.
1113	1	Secrets of the King Cobra		Andre Braugher	41	149	2012	1	47 min	10	A new scientific expedition follows the king cobra into the wild for the first time.
1114	2	Shake It Up		Bella Thorne, Zendaya , Davis Cleveland, Roshon Fegan, Adam Irigoyen, Kenton Duty	3	149	2010	6	3 Seasons	147	Best friends attend high school and dance professionally.
1115	1	Sharks of Lost Island		Chris McLinden	3	149	2013	1	45 min	217	A team of explorers sets out to explore the sea and land of the remote Pitcairn Islands.
1116	1	Sharpay's Fabulous Adventure	Michael Lembeck	Ashley Tisdale, Austin Butler, Cameron Goodman, Bradley Perry, Alec Mapa, Jack Plotnick	3	149	2011	6	92 min	171	Aspiring diva Sharpay leaves suburbia and hits Broadway…and hits it hard.
1117	1	Shipwrecked	Nils Gaup	Stian Smestad, Trond Peter Munch, Louisa Haigh, Gabriel Byrne, Bjørn Sundquist, Eva von Hanno	80	149	1991	5	93 min	89	A cabin boy must outwit a ruthless gang of pirates while shipwrecked on a jungle island.
1118	2	Silver Surfer		Paul Essiembre, James Blendick, Robert Bockstael, Jennifer Daley, Colin Fox	2	149	1997	8	1 Season	5	The adventures of the cosmic wanderer as he seeks his lost home after rebelling from his master.
1119	1	Simpsons Movie	David Silverman	Dan Castellaneta, Julie Kavner, Nancy Cartwright, Yeardley Smith, Harry Shearer, Hank Azaria	3	149	2007	3	88 min	73	Homer must save the world from a catastrophe he himself created.
1120	1	Sister Act	Emile Ardolino	Whoopi Goldberg, Maggie Smith, Harvey Keitel, Bill Nunn, Mary Wickes, Kathy Najimy	3	149	1992	5	101 min	290	A low-rent lounge singer is forced to hide out from the mob in a convent.
1121	1	Sister Act 2: Back in the Habit	Bill Duke	Whoopi Goldberg, Kathy Najimy, Barnard Hughes, Mary Wickes, James Coburn, Michael Jeter	3	149	1993	5	108 min	291	Deloris goes back undercover to try to save a troubled inner-city school.
1122	1	Skyrunners	Ralph Hemecker	Kelly Blatz, Joey Pollari, Conrad Coates, Jacqueline Wood, Nathan Stephenson, Kerry Laifatt	3	149	2009	1	93 min	23	Teen brothers discover a UFO near their town…and learn of an alien plot.
1123	1	Sleeping Beauty	Clyde Geronimi	Mary Costa, Eleanor Audley, Barbara Luddy, Taylor Holmes, Bill Shirley, Verna Felton	3	149	1959	2	77 min	111	A fairy-tale classic about a princess saved by true love's kiss.
1124	1	Smart House	LeVar Burton	Ryan Merriman, Kevin Kilner, Jessica Steen, Katie Volding, Katey Sagal, Emilio Borelli	3	149	1999	6	82 min	114	A computerized Smart House becomes an overly possessive virtual mother.
1125	1	Smash and Grab	Brian Larsen		3	149	2019	5	8 min	292	Two antiquated robots risk everything for freedom and for each other.
1126	1	Snow White and The Seven Dwarfs	David Hand	Adriana Caselotti, Harry Stockwell, Lucille LaVerne, Moroni Olsen, Billy Gilbert, Pinto Colvig	3	149	1937	2	84 min	111	Discover the movie called “The Greatest Animated Film Of All Time”!
1127	1	Snowball Express	Norman Tokar	Dean Jones, Nancy Olson, Harry Morgan, Keenan Wynn, Johnny Whitaker, Michael McGreevy	3	149	1972	2	94 min	170	A New York accountant moves west when he inherits a dilapidated ski resort.
1128	1	Snowglobe	Ron Lagomarsino	Christina Milian, Erin Karpluk, Hilda Doherty, Jason Schombing, James Kot, Andrew Krivanek	3	149	2007	1	90 min	54	Angela finds a snow globe that transports her into a Christmas wonderland.
1129	2	So Weird		Cara DeLizia, Patrick Levis, Erik von Detten, Belinda Metz, Dave Ward, Mackenzie Phillips	12	149	1999	8	3 Seasons	293	A teenage girl travels the country on a rock tour while investigating the supernatural.
1130	1	Society Dog Show	Bill Roberts	Pinto Colvig, Walt Disney	3	149	1939	6	9 min	11	Pluto is out of place at a dog show, but he proves to be a hero. See details for advisory.
1131	2	Spider-Man (Shorts)			1	149	2016	8	1 Season	5	Peter uses science to investigate his spider bite.
1132	2	Spider-Man and His Amazing Friends		Hans Conried, Jerry Dexter, George DiCenzo, Alan Dinehart, Walker Edminston, Michael Evans	3	149	1982	8	1 Season	5	Spider-Man battles crime in New York City with the help of Iceman and Firestar.
1133	2	Spider-Man Unlimited		Rino Romano, Kathleen Barr, Jim Byrnes, Garry Chalk, Paul Dobson	2	149	1999	8	1 Season	5	Strap in to your seats and experience Spider-Man Unlimited!
1134	2	Spider-Woman		Joan Ark, Bruce Miller, Bryan Scott, Lou Krugman, Dick Tufeld	3	149	1979	8	1 Season	5	Jessica Drew has superhuman powers. She uses them as Spider-Woman.
1135	2	Star Wars Forces of Destiny (Shorts)		Ashley Eckstein, Matt Lanter, C1-10P a.k.a. "Chopper" , John Boyega, Vanessa Marshall, Felicity Jones	3	149	2016	8	2 Seasons	35	Untold stories from the heroines of Star Wars.
1136	2	Star Wars Rebels		Taylor Gray, Vanessa Marshall, Freddie Prinze Jr., Tiya Sircar, Steve Blum, C1-10P a.k.a. "Chopper"	3	149	2014	8	4 Seasons	5	The Ghost crew provides a spark to ignite a rebellion.
1137	2	Star Wars Rebels (Shorts)			1	149	2014	8	1 Season	5	It is a dark time in the galaxy as the Empire continues to tighten its grip.
1138	1	Star Wars: A New Hope (Episode IV)	George Lucas	Mark Hamill, Harrison Ford, Carrie Fisher, Peter Cushing, Alec Guinness, Anthony Daniels	3	149	1977	5	125 min	23	A young farm boy intercepts a distress call from the captive Princess Leia.
1139	1	Star Wars: Attack of the Clones (Episode II)	George Lucas	Ewan McGregor, Natalie Portman, Hayden Christensen, Frank Oz, Ian McDiarmid, Pernilla August	3	149	2002	5	143 min	23	Young Anakin and Padmé fall in love as galactic war looms.
1140	2	Star Wars: Blips			3	149	2019	9	1 Season	99	What does a curious little droid do when he's not on a daring mission to save the galaxy?
1141	1	Star Wars: Return of the Jedi (Episode VI)	Richard Marquand	Mark Hamill, Harrison Ford, Carrie Fisher, Billy Williams, Anthony Daniels, Peter Mayhew	3	149	1983	5	135 min	23	Luke Skywalker faces Darth Vader in a final duel.
1142	1	Star Wars: Revenge of the Sith (Episode III)	George Lucas	Ewan McGregor, Natalie Portman, Hayden Christensen, Ian McDiarmid, Frank Oz, Jimmy Smits	3	149	2005	3	140 min	23	As the Republic falls, Anakin Skywalker becomes the evil Darth Vader.
1143	1	Star Wars: The Empire Strikes Back (Episode V)	Irvin Kershner	Mark Hamill, Harrison Ford, Carrie Fisher, Billy Williams, Anthony Daniels, David Prowse	3	149	1980	5	127 min	23	Luke Skywalker trains as a Jedi and confronts Darth Vader.
1144	1	Star Wars: The Force Awakens (Episode VII)	J.J. Abrams	Harrison Ford, Mark Hamill, Carrie Fisher, Adam Driver, Daisy Ridley, John Boyega	3	149	2015	3	139 min	23	Rey, Finn, Han and Chewbacca search for the one hope of restoring peace.
1145	1	Star Wars: The Phantom Menace (Episode I)	George Lucas	Liam Neeson, Ewan McGregor, Natalie Portman, Jake Lloyd, Pernilla August, Frank Oz	3	149	1999	5	136 min	23	Jedi discover Anakin Skywalker, a boy unusually strong in the Force.
1146	1	Starstruck	Michael Grossman	Sterling Knight, Danielle Campbell, Maggie Castle, Brandon Smith, Chelsea Staub, Beth Littleford	3	149	2010	6	81 min	171	Pop star Christopher Wilde must choose to follow his heart or embrace fame.
1147	1	Steamboat Willie	Walt Disney, Ub Iwerks	Walt Disney	3	149	1928	8	8 min	224	Watch Mickey Mouse's classic cartoon debut. See details for advisory.
1148	1	Stepsister from Planet Weird	Steve Boyum	Courtnee Draper, Tamara Hope, Lance Guest, Khrystyne Haje, Vanessa Chester, Myles Jeffrey	3	149	2000	6	86 min	34	A human and an alien team up to stop their parents from getting married.
1149	1	Stitch! The Movie	Tony Craig, Bobs Gannaway	Daveigh Chase, Chris Sanders, Tia Carrere, David Stiers, Kevin McDonald, Ving Rhames	3	149	2003	2	62 min	11	Stitch tries to save his intergalactic "cousins" from evil Captain Gantu.
1150	1	Stonehenge Decoded: Secrets Revealed	Christopher Spencer	Craig Sechler	19	149	2008	1	44 min	1	The discovery of a prehistoric site in Ireland sheds new light on the mysteries of Stonehenge
1151	1	Stuck in the Suburbs	Savage Holland	Danielle Panabaker, Brenda Song, Amanda Shaw, CiCi Hedgepeth, Jennie Garland, Ryan Belleville	3	149	2004	6	79 min	171	A bored suburban teen accidentally switches phones with a pop star.
1152	1	Sultan and the Rock Star	Ed Abroms	Timothy Hutton, Ken Swofford, Bruce Glover, Ned Romero, Richard Paul, Pat Delany	3	149	1980	1	47 min	186	A rock star befriends a gentle tiger being hunted for sport. See details for advisory.
1153	1	Super Buddies	Robert Vince	Jeremy Shinder, Tenzing Trainor, Ty Panitz, G. Hannelius, Cooper Roth, Colin Hanks	3	149	2013	2	83 min	36	A new breed of hero is born when Disney's favorite extraordinary pups become Super Buddies!
1154	1	Swiss Family Robinson	Edward Ludwig	Thomas Mitchell, Edna Best, Freddie Bartholomew, Terry Kilburn, Tim Holt, Baby Quillan	3	149	1940	5	94 min	294	A violent storm shipwrecks the Robinson family on a deserted island. See details for advisory.
1155	2	TaleSpin		Charlie Adler, Jim Cummings, Ed Gilbert, Chuck McCann, Alan Roberts, Sally Struthers	3	149	1990	6	1 Season	5	Follow Baloo, his 12-year old navigator Kit, the boss Rebecca Cunningham, and the rest of the crew.
1156	1	Tall Tale	Jeremiah Chechik	Scott Glenn, Oliver Platt, Nick Stahl, Stephen Lang, Roger Brown, Jared Harris	3	149	1995	5	97 min	295	It's all up to Pecos Bill to save a boy's family farm in this rousing Western adventure.
1157	1	Tangled	Nathan Greno, Byron Howard	Mandy Moore, Zachary Levi, Donna Murphy, Ron Perlman, M.C. Gainey, Jeffrey Tambor	3	149	2010	5	101 min	62	Rapunzel and Flynn set off on a hilarious, hair-raising escapade.
1158	1	Tangled Before Ever After	Tom Caulfield, Stephen Sandoval	Zachary Levi, Mandy Moore, Eden Espinosa, Clancy Brown, Julie Bowen, Laura Benanti	3	149	2017	8	58 min	239	Rapunzel escapes for a night of freedom before her coronation.
1159	1	Tarzan & Jane	Steve Loter	Michael Weiss, Olivia d'Abo, Rene Auberjonois, Jeff Bennett, Jim Cummings, Grey DeLisle	3	149	2002	1	78 min	93	Tarzan and Jane celebrate their first year in the jungle.
1160	1	Teacher's Pet	Timothy Björklund	Nathan Lane, Kelsey Grammer, Shaun Fleming, Debra Rupp, David Stiers, Jerry Stiller	3	149	2004	5	75 min	11	A dog discovers that his dream of becoming a real boy isn't so far-fetched.
1161	1	Teen Beach 2	Jeffrey Hornaday	Ross Lynch, Maia Mitchell, Grace Phipps, Garrett Clayton, John DeLuca, Chrissie Fit	3	149	2015	6	106 min	82	Mack and Brady get a real-world visit from their retro movie compadres.
1162	1	Teen Beach Movie	Jeffrey Hornaday	Ross Lynch, Maia Mitchell, Grace Phipps, Garrett Clayton, John DeLuca, Chrissie Fit	3	149	2013	6	97 min	156	McKenzie and her boyfriend Brady catch a wave into a retro coastal musical.
1163	1	Teen Spirit	Gil Junger	Cassie Scerbo, Lindsey Shaw, Chris Zylka, Tim Gunn, Carissa Capobianco, Gabriela Lopez	3	149	2011	7	82 min	147	To save her soul, Amber must pull off a high-school miracle.
1164	1	That Darn Cat	Bob Spiers	Christina Ricci, Doug Doug, George Dzundza, Peter Boyle, Michael McKean, Bess Armstrong	3	149	1997	5	90 min	178	A teen, a cat and a rookie FBI agent team up to solve a kidnapping.
1165	1	That Darn Cat!	Robert Stevenson	Hayley Mills, Dean Jones, Dorothy Provine, Roddy McDowall, Neville Brand, Elsa Lanchester	3	149	1965	2	116 min	178	A cat holds the clue to bank robbers holding a teller hostage.
1166	1	The Absent-Minded Professor	Robert Stevenson	Fred MacMurray, Nancy Olson, Keenan Wynn, Tommy Kirk, Leon Ames, Elliott Reid	3	149	1961	2	96 min	34	A bumbling professor invents gravity-defying Flubber.
1167	1	The Adventures of André & Wally B.	Alvy Smith		3	149	1984	6	2 min	38	Andre awakens from a nap and is greeted by a pesky bee.
1168	1	The Adventures of Bullwhip Griffin	James Neilson	Roddy McDowall, Suzanne Pleshette, Karl Malden, Harry Guardino, Richard Haydn, Hermione Baddeley	3	149	1967	1	111 min	36	A boy joins the California gold rush with his trusty butler on his tail. See details for advisory.
1169	1	The Adventures of Huck Finn	Stephen Sommers	Elijah Wood, Courtney Vance, Robbie Coltrane, Jason Robards, Ron Perlman, Dana Ivey	3	149	1993	5	108 min	130	Huck and a runaway slave brave the Mississippi River in search of freedom.
1170	1	The Adventures of Ichabod and Mr. Toad	Jack Kinney, Clyde Geronimi, James Algar	Bing Crosby, Basil Rathbone, Eric Blore, Pat O'Malley, John Ployardt, Colin Campbell	3	149	1949	2	69 min	35	Enjoy two classic stories with Toad's Wild Ride and the Headless Horseman.
1171	2	The Adventures of Spin and Marty		David Stollery, Tim Considine	3	149	1955	6	1 Season	296	Spin and Marty have adventures during the summer at Triple R Ranch. See details for advisory.
1172	1	The African Lion	James Algar	Winston Hibler	3	149	1955	2	72 min	142	Two wildlife experts spend years studying the majestic African lion.
1173	1	The Apple Dumpling Gang	Norman Tokar	Bill Bixby, Susan Clark, Don Knotts, Tim Conway, David Wayne, Slim Pickens	3	149	1975	2	100 min	297	Bumbling outlaws help three young orphans protect their huge gold nugget. See details for advisory.
1174	1	The Apple Dumpling Gang Rides Again	Vincent McEveety	Tim Conway, Don Knotts, Tim Matheson, Kenneth Mars, Elyssa Davalos, Jack Elam	3	149	1979	2	89 min	297	Two bumbling outlaw wannabes just can't succeed in going straight. See details for advisory.
1175	1	The Aristocats	Wolfgang Reitherman	Phil Harris, Eva Gabor, Sterling Holloway, Scatman Crothers, Paul Winchell, Lord Tim Hudson	3	149	1970	2	81 min	73	A pedigreed cat and her kittens are catnapped by a greedy butler. See details for advisory.
1176	1	The Art of Skiing	Jack Kinney	John McLeish	3	149	1941	6	8 min	11	Goofy demonstrates the art of skiing. See details for advisory.
1177	2	The Avengers: Earth's Mightiest Heroes		Eric Loomis, Bumper Robinson, Dawn Olivera, Phil LaMarr, Alex Desert, Kari Wuhrer	3	149	2010	8	2 Seasons	5	Chaos sweeps over the planet as the Super Villain prison system breaks down.
1178	2	The Avengers: United They Stand		Martin Roach, Rod Wilson, Lenore Zann, Ron Rubin, Hamish McEwan, Lynda Ballantyne	81	149	1999	8	1 Season	5	Set in a vibrant, high-tech future, the series focuses on the mightiest superheroes in the universe.
1179	1	The Band Concert	Wilfred Jackson, Walt Disney	Clarence Nash	3	149	1935	8	10 min	224	Mickey's concert in the park is disrupted by Donald and a cyclone. See details for advisory.
1180	1	The Bears and I	Bernard McEveety	Patrick Wayne, Chief George, Andrew Duggan, Michael Ansara, Robert Pine, Val DeVargas	3	149	1974	1	83 min	47	A man seeking peace and quiet becomes a father to three mischievous bears. See details for advisory.
1181	1	The Big Bad Wolf	Burt Gillett		3	149	1934	8	9 min	270	Red Riding Hood travels to visit her sick grandmother. See details for advisory.
1182	1	The Biscuit Eater	Vincent McEveety	Earl Holliman, Patricia Crowley, Lew Ayres, Godfrey Cambridge, Beah Richards, Clifton James	3	149	1972	2	93 min	47	Two young boys try to transform a misfit hound into a champion bird dog. See details for advisory.
1183	1	The Black Cauldron	Ted Berman, Richard Rich	Grant Bardsley, Susan Sheridan, Freddie Jones, Nigel Hawthorne, Arthur Malet, John Byner	5	149	1985	5	82 min	173	A young pig keeper becomes an unlikely hero when he confronts an evil king.
1184	1	The Black Hole	Gary Nelson	Maximilian Schell, Anthony Perkins, Robert Forster, Joseph Bottoms, Yvette Mimieux, Ernest Borgnine	3	149	1979	5	98 min	298	Take a spectacular descent into nature's ultimate mystery: The Black Hole.
1185	1	The Blue Umbrella	Saschka Unseld	Sarah Jaffe	3	149	2013	2	7 min	224	Two unlikely umbrellas fall eternally in love.
1186	2	The Book of Once Upon a Time		Kate Mulvany	1	149	2014	4	4 Seasons	299	Classic Disney tales are brought to life in a magical storytelling experience.
1187	2	The Book of Pooh		Jim Cummings, Paul Tiesler, Jeff Bennett, Peter Cullen, Stephanie d’Abruzzo, John Fiedler	3	149	2000	4	2 Seasons	174	Pooh and Friends discover Christopher Robin’s storybook filled with endearing tales about them!
1188	1	The Brave Little Toaster Goes to Mars	Robert Ramirez	Deanna Oliver, Tim Stack, Roger Kabler, Thurl Ravenscroft, Eric Lloyd, Farrah Fawcett	3	149	1998	6	73 min	5	Toaster and his friends head for Mars to bring the master's baby home.
1189	1	The Castaway Cowboy	Vincent McEveety	James Garner, Vera Miles, Robert Culp, Eric Shea, Elizabeth Smith, Manu Tupou	3	149	1974	2	91 min	300	A Texan castaway helps defend a Hawaiian family's land.
1190	1	The Cheetah Girls	Oz Scott	Raven , Adrienne Bailon, Kiely Williams, Sabrina Bryan, Juan Chioran, Lori Alter	15	149	2003	6	94 min	134	The Cheetah Girls sing and dance their way toward that elusive record deal.
1191	1	The Cheetah Girls 2	Kenny Ortega	Raven-Symoné , Adrienne Bailon, Sabrina Bryan, Kiely Williams, Belinda Peregrin, Lori Alter	3	149	2006	6	98 min	134	The Cheetahs go to Barcelona to perform in a music festival.
1192	1	The Cheetah Girls: One World	Paul Hoen	Adrienne Bailon, Sabrina Bryan, Kiely Williams, Roshan Seth, Michael Steger, Kunal Sharma	3	149	2008	6	85 min	171	The Cheetah Girls are off to India to land a spot in a Bollywood musical.
1193	1	The Christmas Star	Alan Shapiro	Edward Asner, René Auberjonois, Jim Metzler, Susan Tyrrell, Karen Landry, Alan North	15	149	1986	6	94 min	301	A counterfeiter finds the true meaning of Christmas.
1194	1	The Chronicles of Narnia: Prince Caspian	Andrew Adamson	Georgie Henley, Skandar Keynes, William Moseley, Anna Popplewell, Ben Barnes, Peter Dinklage	82	149	2008	5	154 min	30	The Pevensie siblings return to lead the Narnians on a remarkable journey.
1195	1	The Chronicles of Narnia: The Lion, the Witch and the Wardrobe	Andrew Adamson	Georgie Henley, Skandar Keynes, William Moseley, Anna Popplewell, Tilda Swinton, James McAvoy	25	149	2005	5	147 min	30	Four siblings enter a magical land and help its inhabitants defeat a witch.
1196	1	The Color of Friendship	Kevin Hooks	Carl Lumbly, Penny Johnson, Shadia Simmons, Anthony Burnett, Travis Davis, Lindsey Haun	15	149	2000	6	83 min	78	Two girls from different backgrounds learn the true color of friendship.
1197	1	The Computer Wore Tennis Shoes	Robert Butler	Kurt Russell, Cesar Romero, Joe Flynn, William Schallert, Alan Hewitt, Richard Bakalyan	3	149	1969	2	90 min	302	A student turns genius when he absorbs the knowledge stored in a computer.
1198	1	The Country Bears	Peter Hastings	Christopher Walken, Stephen Tobolowsky, Daryl Mitchell, M.C. Gainey, Diedrich Bader, Alex Rocco	3	149	2002	2	91 min	303	The Country Bears aim to save the venue that made them famous.
1199	1	The Emperor's New Groove	Mark Dindal	David Spade, John Goodman, Eartha Kitt, Patrick Warburton, Wendie Malick, Eli Linnetz	3	149	2000	2	82 min	62	A selfish emperor learns a lesson in humility when he is turned into a llama.
1200	1	The Even Stevens Movie	Sean McNamara	Shia LaBeouf, Christy Romano, Tom Virtue, Nick Spano, Steven Lawrence, A.J. Trauth	3	149	2003	6	94 min	304	An all-expenses-paid vacation ends up costing the Stevens their sanity.
1201	1	The Flood	Brad Bestelink	Angela Bassett	3	149	2018	1	93 min	10	The Okavango Delta in Botswana transforms from desert to water wonderland.
1202	1	The Fox and the Hound	Art Stevens, Ted Berman, Richard Rich	Mickey Rooney, Kurt Russell, Pearl Bailey, Jack Albertson, Sandy Duncan, Jeanette Nolan	3	149	1981	2	85 min	135	A little fox and a hound pup become unlikely friends.
1203	1	The Fox and the Hound 2	Jim Kammerud	Reba McEntire, Patrick Swayze, Jonah Bobo, Harrison Fahn, Jeff Foxworthy, Vicki Lawrence	3	149	2006	2	73 min	135	Tod and Copper's friendship is put to the test.
1204	1	The Game Plan	Andy Fickman	Dwayne Johnson, Kyra Sedgwick, Morris Chestnut, Roselyn Sanchez, Madison Pettis, Gordon Clapp	3	149	2007	5	112 min	170	A superstar quarterback meets the daughter he never knew existed.
1205	1	The Ghosts of Buxley Hall	Bruce Bilson	Dick O'Neill, Victor French, Louise Latham, Rad Daly, Monte Markham, Ruta Lee	3	149	1980	1	93 min	54	Ghosts inhabiting a cash-strapped academy enlist the help of a shy cadet.
1206	1	The Goddess of Spring	Wilfred Jackson		3	149	1934	8	10 min	111	The goddess of spring is kidnapped, bringing about the winter season. See details for advisory.
1207	1	The Golden Touch	Walt Disney		3	149	1935	8	11 min	111	A fable of a king whose touch turns everything to gold. See details for advisory.
1208	1	The Good Dinosaur	Peter Sohn	Jeffrey Wright, Frances McDormand, Maleah Padilla, Ryan Teeple, Jack McGraw, Marcus Scribner	3	149	2015	5	94 min	135	A dinosaur named Arlo makes an unlikely friend during his journey home.
1209	1	The Great Muppet Caper	Jim Henson	Jim Henson, Frank Oz, Dave Goelz, Jerry Nelson, Richard Hunt, Charles Grodin	25	149	1981	2	98 min	290	Kermit and the gang investigate when Miss Piggy is framed for burglary.
1210	1	The Greatest Game Ever Played	Bill Paxton	Shia LaBeouf, Stephen Dillane, Peter Firth, Elias Koteas, Stephen Marcus, Josh Flitter	2	149	2005	5	122 min	246	The story of Francis Ouimet, the first amateur to win the U.S. Open.
1211	1	The Haunted Mansion	Rob Minkoff	Eddie Murphy, Terence Stamp, Nathaniel Parker, Marsha Thomason, Jennifer Tilly, Wallace Shawn	3	149	2003	5	89 min	54	A family comes face-to-face with 999 grim, grinning ghosts in creepy old Gracey Manor.
1212	1	The Hockey Champ	Jack King		3	149	1939	6	9 min	11	Donald and his nephews play Hockey. See details for advisory.
1213	1	The Hunchback of Notre Dame	Gary Trousdale, Kirk Wise	Tom Hulce, Demi Moore, Tony Jay, Kevin Kline, Paul Kandel, Jason Alexander	66	149	1996	2	96 min	62	Quasi leaves his tower in Notre Dame to help a kind and beautiful gypsy.
1214	1	The Hunchback of Notre Dame II	Bradley Raymond	Jason Alexander, Jennifer Hewitt, Tom Hulce, Paul Kandel, Charles Kimbrough, Kevin Kline	3	149	2002	2	69 min	62	It's Quasimodo's turn to look past appearances when seeking true love.
1215	2	The Imagineering Story			3	149	2019	1	1 Season	139	Creating happiness takes a strong blend of imagination and engineering - known as Imagineering.
1216	1	The Incredible Journey	Fletcher Markle	Émile Genest, John Drainie, Tommy Tweed, Sandra Scott, Syme Jago, Marion Finlayson	15	149	1963	2	80 min	186	Two dogs and a cat traverse the Canadian frontier to find their way home.
1217	1	The Incredibles	Brad Bird	Craig Nelson, Holly Hunter, Samuel Jackson, Jason Lee, Dominique Louis, Teddy Newton	3	149	2004	5	116 min	62	A family of Supers, forced to adopt civilian lives, returns to action.
1218	1	The Journey of Natty Gann	Jeremy Kagan	Meredith Salenger, John Cusack, Ray Wise, Lainie Kazan, Scatman Crothers, Barry Miller	3	149	1985	5	101 min	130	A brave young girl embarks on a cross-country search for her father.
1219	1	The Jungle Book 2	Steve Trenbirth	John Goodman, Haley Osment, Mae Whitman, Connor Funk, Bob Joles, Tony Jay	52	149	2003	2	77 min	5	Mowgli must decide whether to live in the village or return to the jungle.
1220	1	The Jungle Book: Mowgli's Story	Nick Marck	Brandon Baker, Sherman Howard, Clancy Brown, Peri Gilpin, Wallace Shawn, Stephen Tobolowsky	3	149	1998	2	77 min	89	Mowgli reflects on his childhood jungle adventures.
1221	1	The Legend of Mor'du	Brian Larsen	Julie Walters, Steve Purcell, Callum O'Neill	3	149	2012	6	8 min	111	A prince seeks control of a kingdom from his brothers through magic.
1222	1	The Lion King 1 1/2	Bradley Raymond	Nathan Lane, Ernie Sabella, Julie Kavner, Jerry Stiller, Matthew Broderick, Robert Guillaume	69	149	2004	2	80 min	73	Timon and Pumbaa reveal how they helped Simba save the Serengeti.
1223	1	The Lion King 2: Simba's Pride	Darrell Rooney	Matthew Broderick, Neve Campbell, Andy Dick, Robert Guillaume, James Jones, Moira Kelly	52	149	1998	2	84 min	62	Simba's strong-willed daughter befriends the heir to Scar's pride.
1224	1	The Little Mermaid	Ron Clements, John Musker	René Auberjonois, Christopher Barnes, Jodi Benson, Pat Carroll, Paddi Edwards, Buddy Hackett	3	149	1989	2	86 min	111	Dive into Disney fun with Ariel in The Little Mermaid.
1225	1	The Little Mermaid II:  Return to the Sea	Jim Kammerud	Jodi Benson, Samuel Wright, Tara Charendoff, Pat Carroll, Buddy Hackett, Kenneth Mars	83	149	2000	2	77 min	305	Return To The Sea with The Little Mermaid’s daughter.
1226	1	The Little Mermaid:  Ariel's Beginning	Peggy Holmes	Jodi Benson, Samuel Wright, Jim Cummings, Sally Field, Tara Strong, Jennifer Hale	3	149	2008	2	79 min	221	Long before Prince Eric, Ariel faces a choice between family and music.
1227	1	The Little Whirlwind	Riley Thomas	Walt Disney, Thelma Boardman	3	149	1941	8	9 min	224	Mickey tries to clean Minnie's yard despite a playful whirlwind. See details for advisory.
1228	1	The Living Desert	James Algar	Winston Hibler	3	149	1953	2	69 min	142	The desert teems with vitality in this true-life adventure.
1229	1	The Lizzie McGuire Movie	Jim Fall	Hilary Duff, Adam Lamberg, Robert Carradine, Hallie Todd, Jake Thomas, Yani Gellman	3	149	2003	5	95 min	19	Lizzie McGuire and her pals go on a class trip to Italy.
1230	1	The Lost Tomb of Alexander the Great	Duncan Singh	Matt McFetridge	19	149	2019	1	44 min	122	An archaeologist on the hunt for Alexander the Great’s lost tomb makes an extraordinary discovery.
1231	1	The Love Bug (1969)	Robert Stevenson	Dean Jones, Michele Lee, David Tomlinson, Buddy Hackett, Joe Flynn, Benson Fong	3	149	1969	2	108 min	36	A down-on-his-luck race car driver teams up with a little VW Bug that has a mind of its own.
1232	1	The Many Adventures of Winnie the Pooh	Wolfgang Reitherman, John Lounsbery	Sebastian Cabot, Junius Matthews, Barbara Luddy, Howard Morris, John Fiedler, Ralph Wright	3	149	1977	4	75 min	97	Experience the magical tales of Pooh and his Hundred Acre Wood friends.
1233	1	The Million Dollar Duck	Vincent McEveety	Dean Jones, Sandy Duncan, Joe Flynn, Tony Roberts, James Gregory, Lee Montgomery	3	149	1971	2	93 min	40	A research scientist discovers his lab duck now lays golden eggs.
1234	1	The Mistle-Tones	Paul Hoen	Tia Mowry, Jonathan Moore, Andy Gala, Megan Duffy, Jason Rogel, Tammy Townsend	3	149	2012	1	87 min	143	Holly forms a Christmas singing group to compete with a harsh rival.
1235	1	The Muppet Christmas Carol	Brian Henson	Michael Caine, Steve Whitmire, Frank Oz, Dave Goelz, Jerry Nelson, David Rudman	5	149	1992	2	87 min	152	The Muppets present their own touching rendition of Charles Dickens' classic tale.
1236	1	The Muppet Movie	James Frawley	Jim Henson, Frank Oz, Jerry Nelson, Richard Hunt, Dave Goelz, Charles Durning	25	149	1979	2	95 min	36	On his way to Hollywood, Kermit dodges a villain eager to serve him up as fried frog-legs.
1237	1	The Muppets	James Bobin	Jason Segel, Amy Adams, Chris Cooper, Rashida Jones, Steve Whitmire, Eric Jacobson	3	149	2011	5	108 min	105	The Muppets' biggest fan reunites the gang to save their beloved theater.
1238	2	The Muppets (Series)		Bill Barretta, Dave Goelz, Eric Jacobson, Peter Linz, David Rudman, Matt Vogel	3	149	2015	1	1 Season	16	"The Muppets" return with a documentary-style show.
1239	2	The New Adventures of Winnie the Pooh		Jim Cummings, Paul Winchell, John Fiedler, Ken Sansome, Tim Hoskins, Patty Paris	3	149	1988	4	4 Seasons	38	The stories of Winnie the Pooh and friends.
1240	1	The Old Mill	Wilfred Jackson		3	149	1937	8	9 min	62	Animals try to stay safe and dry in an old mill. See details for advisory.
1241	1	The Olympic Champ	Jack Kinney		3	149	1942	6	7 min	11	Goofy demonstrates Olympic events to the narration of their history. See details for advisory.
1242	1	The Parent Trap	Nancy Meyers	Dennis Quaid, Natasha Richardson, Lisa Walter, Elaine Hendrix, Simon Kunz, Ronnie Stevens	5	149	1998	5	129 min	306	Identical twins scheme to switch places and reunite their divorced parents.
1243	1	The Parent Trap (1961)	David Swift	Hayley Mills, Maureen O'Hara, Brian Keith, Charlie Ruggles, Una Merkel, Leo Carroll	3	149	1961	2	129 min	306	Twins separated at birth reunite, then switch places to try and get their parents back together.
1244	1	The Pied Piper	Wilfred Jackson		3	149	1933	6	8 min	270	The Pied Piper lures the children out of town. See details for advisory.
1245	1	The Plausible Impossible (Disneyland: 1954-58)	Wilfred Jackson, William Beaudine	Walt Disney	3	149	1956	1	52 min	160	Walt Disney explains some of the techniques of animation. See details for advisory.
1246	1	The Poof Point	Neal Israel	Tahj Mowry, Dawnn Lewis, Raquel Lee, Mark Curry, Bruce Newbold, Jan Felt	3	149	2001	6	80 min	229	Eddie and Marie’s parents invent a machine that makes them younger.
1247	1	The Prince and the Pauper	Don Chaffey	Guy Williams, Laurence Naismith, Donald Houston, Sean Scully, Niall MacGinnis, Geoffrey Keen	19	149	1962	2	94 min	89	After meeting his lookalike, a prince trades places with a pauper. See details for advisory.
1248	1	The Princess and the Frog	John Musker, Ron Clements	Anika Rose, Bruno Campos, Keith David, Michael-Leon Wooley, Jennifer Cody, Jim Cummings	3	149	2009	2	99 min	11	A fateful kiss with a frog sends Tiana on a mystical bayou adventure.
1249	1	The Princess Diaries	Garry Marshall	Anne Hathaway, Heather Matarazzo, Hector Elizondo, Mandy Moore, Caroline Goodall, Robert Schwartzman	5	149	2001	2	116 min	19	A teenager discovers that she is the princess of a small European country.
1250	1	The Princess Diaries 2: Royal Engagement	Garry Marshall	Anne Hathaway, Heather Matarazzo, John Rhys-Davies, Chris Pine, Callum Blue, Kathleen Marshall	3	149	2004	2	114 min	306	Princess Mia has 30 days to find a husband... or she can't become queen.
1251	1	The Proud Family Movie	Bruce Smith	Tommy Davidson, Kyla Pratt, Paula Parker, Jo Payton, Orlando Brown, Soleil Frye	3	149	2005	6	95 min	11	Penny's boring family vacation becomes a mysterious island adventure.
1252	1	The Reluctant Dragon	Alfred Werker	Robert Benchley, Gerald Mohr, Alan Ladd, Florence Gill, Frances Gifford, Buddy Pepper	3	149	1941	2	74 min	11	Robert Benchley gives a behind-the-scenes look at how animation is created.
1253	2	The Replacements		Nancy Cartwright, Grey DeLisle, Kath Soucie, Daran Norris, David McCallum, Jeff Bennett	3	149	2006	6	1 Season	11	Riley and Todd, can replace any adult in their life by making a simple call to the Fleemco company.
1254	1	The Rescuers	Wolfgang Reitherman, John Lounsbery, Art Stevens	Bob Newhart, Eva Gabor, Geraldine Page, Joe Flynn, Jeanette Nolan, Pat Buttram	3	149	1977	2	78 min	73	Two mice rush to help an orphan girl in the clutches of an evil woman.
1255	1	The Rescuers Down Under	Hendel Butoy, Mike Gabriel	Bob Newhart, Eva Gabor, John Candy, Tristan Rogers, Adam Ryen, Wayne Robson	3	149	1990	2	78 min	62	Bernard and Bianca race to Australia to save a boy from a vile poacher.
1256	1	The Rookie	John Hancock	Dennis Quaid, Rachel Griffiths, Jay Hernandez, Beth Grant, Angus Jones, Brian Cox	3	149	2002	2	129 min	265	A high school baseball coach gets a second chance as a big-league pitcher.
1257	1	The Santa Clause	John Pasquin	Tim Allen, Judge Reinhold, Wendy Crewson, Eric Lloyd, David Krumholtz, Larry Brandenburg	2	149	1994	5	98 min	54	A bizarre twist of fate transforms a divorced dad into the new Santa.
1258	1	The Santa Clause 2	Michael Lembeck	Tim Allen, Judge Reinhold, Wendy Crewson, Elizabeth Mitchell, David Krumholtz, Eric Lloyd	2	149	2002	2	106 min	54	Scott Calvin must get married by Christmas Eve or lose his title as Santa.
1259	1	The Santa Clause 3: The Escape Clause	Michael Lembeck	Tim Allen, Elizabeth Mitchell, Judge Reinhold, Wendy Crewson, Ann-Margret , Eric Lloyd	2	149	2006	2	94 min	54	The holidays take a chaotic turn when Jack Frost puts a freeze on Christmas.
1260	1	The Scream Team	Stuart Gillard	Mark Rendall, Kat Dennings, Robert Bockstael, Eric Idle, Tommy Davidson, Gary Reineke	3	149	2002	1	88 min	109	Ian and Claire Carlyle discover that ghosts really do exist!
1261	1	The Secret of the Magic Gourd	朱家欣 , 钟智行	劳奕嘉 , 朱祺隆 , 郭凯敏 , 郑嘉昊 , 孟谦 , 陈佩斯	84	149	2009	2	84 min	72	A boy's world is turned upside down when he hooks a wish-granting gourd.
1262	1	The Shaggy D.A.	Robert Stevenson	Dean Jones, Tim Conway, Suzanne Pleshette, Keenan Wynn, Jo Worley, Dick Van Patten	3	149	1976	2	92 min	54	A District Attorney candidate finds himself transformed into a sheepdog.
1263	1	The Shaggy Dog	Charles Barton	Fred MacMurray, Jean Hagen, Tommy Kirk, Annette Funicello, Tim Considine, Kevin Corcoran	3	149	1959	2	102 min	54	A magical ring transforms a teenager into a lumbering sheepdog.
1264	1	The Sign of Zorro	Lewis Foster, Norman Foster	Guy Williams, George Lewis, Gene Sheldon, Henry Calvin, Tony Russo, John Dehner	3	149	1960	2	90 min	307	Don Diego dons the mask of Zorro to free his town from a dictator. See details for advisory.
1265	1	The Simple Things	Charles Nichols		3	149	1953	6	8 min	11	Mickey and Pluto go fishing at the beach. See details for advisory.
1266	1	The Sound of Music	Robert Wise	Julie Andrews, Christopher Plummer, Richard Haydn, Peggy Wood, Evadne Baker, Portia Nelson	3	149	1965	2	175 min	308	A governess wins the hearts of many and leads the Von Trapp family to their 1938 flight to freedom.
1267	1	The Story of Robin Hood And His Merrie Men	Ken Annakin	Richard Todd, Joan Rice, Peter Finch, James Hayter, Martita Hunt, James Justice	19	149	1952	5	84 min	58	Prince John conspires to gain power when King Richard leaves England.
1268	1	The Strongest Man in the World	Vincent McEveety	Kurt Russell, Joe Flynn, Eve Arden, Cesar Romero, Phil Silvers, Dick Van Patten	3	149	1975	2	92 min	34	A college science wiz gains super strength in a lab accident. See details for advisory.
1269	1	The Suite Life Movie	Sean McNamara	Cole Sprouse, Dylan Sprouse, Brenda Song, Debby Ryan, Matthew Timmons, John Ducey	3	149	2011	6	81 min	48	Zack and Cody become truly connected after joining a twin research study.
1270	2	The Suite Life of Zack & Cody		Cole Sprouse, Dylan Sprouse, Brenda Song, Ashley Tisdale, Phill Lewis, Kim Rhodes	3	149	2004	6	3 Seasons	56	Twin brothers Zack and Cody get to live with their single mom in Boston's swankiest hotel.
1271	2	The Suite Life On Deck		Cole Sprouse, Dylan Sprouse, Brenda Song, Debby Ryan, Phill Lewis	3	149	2008	6	3 Seasons	56	Zack and Cody Martin are aboard the SS Tipton, a luxury passenger cruise liner.
1272	1	The Swap	Jay Karas	Peyton List, Jacob Bertrand, Darrin Rose, Claire Rankin, Callan Potter, Jesse Bostick	3	149	2016	6	91 min	31	Classmates Ellie and Jack unexplainably trigger a real-life body swap.
1273	1	The Thirteenth Year	Duwayne Dunham	Chez Starbuck, Dave Coulier, Lisa Sullivan, Justin Ross, Courtnee Draper, Tim Redwine	3	149	1999	6	89 min	71	Cody learns he can communicate with fish as he nears his 13th birthday.
1274	1	The Three Caballeros	Norman Ferguson, Clyde Geronimi, Jack Kinney	Aurora Miranda, Carmen Molina, Sterling Holloway, Clarence Nash, Joaquin Garay, Jose Oliveira	3	149	1945	2	72 min	270	Magical gifts from his friends send Donald on a musical journey. See details for advisory.
1275	1	The Three Musketeers	Stephen Herek	Charlie Sheen, Kiefer Sutherland, Chris O'Donnell, Oliver Platt, Tim Curry, Rebecca De Mornay	85	149	1993	5	106 min	36	Three loyal swordsmen and an eager recruit unite to protect the King.
1276	1	The Tigger Movie	Jun Falkenstein	Jim Cummings, Nikita Hopkins, Ken Sansom, John Fiedler, Peter Cullen, Andre Stojka	29	149	2000	2	81 min	5	Tigger goes looking through the Hundred Acre Wood to find his family.
1277	1	The Tortoise and the Hare	Wilfred Jackson		3	149	1935	6	9 min	187	Hare stops to show off, and the slower Tortoise wins the race. See details for advisory.
1278	1	The Ugly Dachshund	Norman Tokar	Dean Jones, Suzanne Pleshette, Charlie Ruggles, Kelly Thordsen, Parley Baer, Robert Kino	3	149	1966	6	93 min	178	The Garrisons live with a Great Dane who thinks he's a dainty dachshund. See details for advisory.
1279	1	The Ugly Duckling	Jack Cutting		3	149	1939	8	9 min	18	A baby duckling is shunned by his family because he is different. See details for advisory.
1280	1	The Ultimate Christmas Present	Greg Beeman	Hallee Hirsh, Spencer Breslin, Hallie Todd, Brenda Song, John Salley, Susan Ruttan	15	149	2000	6	81 min	31	Allie and Sam lose control of Santa's weather machine.
1281	1	The Vanishing Prairie	James Algar	Winston Hibler	3	149	1954	2	71 min	142	The story of the American prairie amidst the march of civilization.
1282	1	The Wild	Steve Williams	Kiefer Sutherland, Jim Belushi, Eddie Izzard, Janeane Garofalo, William Shatner, Richard Kind	15	149	2006	2	86 min	73	A band of animals escape from the zoo, into the wilds of New York City.
1283	1	The Wise Little Hen	Wilfred Jackson	Clarence Nash, Florence Gill	3	149	1934	6	8 min	224	Donald Duck learns that you must work for a harvest. See details for advisory.
1284	1	The Wizards Return: Alex vs. Alex	Victor Gonzalez	Selena Gomez, Jake T. Austin, Jennifer Stone, Gregg Sulkin, Beau Mirchoff, Maria Canals-Barrera	3	149	2013	6	59 min	31	Alex creates a good and evil version of herself.
1285	2	The World According to Jeff Goldblum		Jeff Goldblum	3	149	2019	1	1 Season	184	Jeff Goldblum explores the fascinating science and history of deceptively familiar objects.
1286	1	The Young Black Stallion	Simon Wincer	Richard Romanus, Biana Tamimi, Patrick Elyas, Gerard Rudolf, Ali Ameri, Andries Rossouw	3	149	2003	2	51 min	91	A girl risks her treasured black stallion to save her family home.
1287	1	Three Blind Mouseketeers	Dave Hand	Pinto Colvig, Billy Bletcher	3	149	1936	8	9 min	192	Captain Katt sets traps for the Three Mouseketeers. See details for advisory.
1289	1	Three Little Pigs	Burt Gillett	Billy Bletcher, Pinto Colvig, Dorothy Compton, Mary Moder	3	149	1933	8	9 min	224	A Disney telling of the Three Little Pigs. See details for advisory.
1290	1	Three Little Wolves	Dave Hand		3	149	1936	8	9 min	18	Two frivolous pigs blow the wolf horn one too many times. See details for advisory.
1291	1	Three Men and a Baby	Leonard Nimoy	Tom Selleck, Steve Guttenberg, Ted Danson, Margaret Colin, Celeste Holm, Nancy Travis	66	149	1987	5	103 min	274	Handsome men trade wine, women and song for crib, pacifier and diaper.
1292	1	Three Men and a Little Lady	Emile Ardolino	Tom Selleck, Steve Guttenberg, Ted Danson, Nancy Travis, Christopher Cazenove, Fiona Shaw	3	149	1990	5	104 min	309	Just as three doting fathers are getting the hang of parenthood, their daughter is taken from them.
1293	1	Thru the Mirror	Dave Hand	Walt Disney, Marcelite Garner, Sonny Dawson	3	149	1936	6	10 min	11	Mickey dreams he goes through his mirror to the other side. See details for advisory.
1294	1	Tiger Cruise	Duwayne Dunham	Hayden Panettiere, Troy Evans, Bianca Collins, Nathaniel Lee Jr., Nathaniel Lee, Mercedes Colon	3	149	2004	1	88 min	219	Maddie Dolan is tired of being labeled a “Navy brat."
1295	1	Tim Burton’s The Nightmare Before Christmas	Henry Selick	Danny Elfman, Chris Sarandon, Catherine O'Hara, William Hickey, Glenn Shadix, Paul Reubens	3	149	1993	5	78 min	111	Pumpkin King Jack Skellington tries to take over Christmas.
1296	2	Timon & Pumbaa		Quinton Flynn, Ernie Sabella, Jim Cummings, Nathan Lane	3	149	1995	4	3 Seasons	41	Timon, a meerkat, and Pumbaa, a warthog, join together for misadventures in the jungle.
1297	1	Tin Toy	John Lasseter	Tinny , Billy	3	149	1988	6	5 min	224	A scared, Tin Toy realizes he really wants to play.
1298	1	Tinker Bell	Bradley Raymond	Mae Whitman, Kristin Chenoweth, Raven-Symoné , Lucy Liu, America Ferrera, Jane Horrocks	3	149	2008	2	81 min	13	The story of Disney's most famous fairy is finally revealed.
1299	1	Tinker Bell and the Great Fairy Rescue	Bradley Raymond	Mae Whitman, Lauren Mote, Michael Sheen, Pamela Adlon, Lucy Liu, Raven-Symoné	3	149	2010	2	80 min	13	Tink risks her own safety when she befriends a curious human girl.
1300	1	Tinker Bell and the Lost Treasure	Klay Hall	Mae Whitman, Jesse McCartney, Jane Horrocks, Lucy Liu, Raven-Symoné , Kristin Chenoweth	3	149	2009	2	84 min	13	Tink has to set things right when her temper puts Pixie Hollow in danger.
1301	1	Titanic: 20 Years Later With James Cameron	Thomas Grane	James Cameron, Bob Ballard	3	149	2017	1	47 min	122	James Cameron revisits his blockbuster film in light of new Titanic research.
1302	1	Toby Tortoise Returns	Wilfred Jackson		3	149	1936	8	8 min	187	Max Hare and Toby Tortoise are opponents in a boxing match. See details for advisory.
1303	1	Tom and Huck	Peter Hewitt	Jonathan Thomas, Brad Renfro, Eric Schweig, Charles Rocket, Amy Wright, Michael McShane	3	149	1995	5	92 min	56	America's legendary teenage heroes Tom and Huck team-up to save a man from being wrongly accused.
1304	1	Toy Story	John Lasseter	Tom Hanks, Tim Allen, Don Rickles, Jim Varney, Wallace Shawn, John Ratzenberger	3	149	1995	2	83 min	135	Meet Woody, Buzz and the gang in an adventure full of humor and heart.
1305	1	Toy Story 2	John Lasseter	Tom Hanks, Tim Allen, Joan Cusack, Kelsey Grammer, Don Rickles, Jim Varney	3	149	1999	2	93 min	73	Join Woody, Buzz, Jessie and the gang to boldly rescue one of their own.
1306	1	Toy Story 3	Lee Unkrich	Tom Hanks, Tim Allen, Joan Cusack, Don Rickles, Wallace Shawn, John Ratzenberger	3	149	2010	2	103 min	310	Woody, Buzz and the gang return for more adventures with new friends.
1307	1	Toy Story Toons: Hawaiian Vacation	Gary Rydstrom	Tom Hanks, Tim Allen, Joan Cusack, Kristen Schaal, Wallace Shawn, Axel Geddes	3	149	2011	2	6 min	11	Ken and Barbie get the vacation of their dreams.
1308	1	Toy Story Toons: Partysaurus Rex	Mark Walsh	Tom Hanks, Tim Allen, Wallace Shawn, Corey Burton, Tony Cox, Don Fullilove	3	149	2012	2	9 min	11	Rex throws an over-the-top bath time bash!
1309	1	Toy Story Toons: Small Fry	Angus MacLane	Tom Hanks, Tim Allen, John Ratzenberger, Wallace Shawn, Joan Cusack, Estelle Harris	3	149	2011	2	10 min	224	Buzz is replaced by a miniature version of himself.
1310	1	Trail of the Panda	Zhong Yu	Zhong Yu, Zhang Qi, Daichi Harashima, Li Feng, Chang Liu, Ke Qi	86	149	2009	2	89 min	186	A mute orphan boy rescues a lost panda cub in the mountains of China.
1311	1	Trailer Horn	Jack Hannah		3	149	1950	6	7 min	11	Donald heads out for a nice relaxing camping trip. See details for advisory.
1312	1	Treasure Island	Byron Haskin	Bobby Driscoll, Robert Newton, Basil Sydney, Walter Fitzgerald, Denis O'Dea, Finlay Currie	25	149	1950	5	96 min	58	The classic tale of a young boy's search for buried treasure.
1313	1	Treasure of Matecumbe	Vincent McEveety	Robert Foxworth, Joan Hackett, Peter Ustinov, Vic Morrow, Johnny Doran, Billy Attmore	3	149	1976	2	116 min	311	Using a secret map, friends face a dangerous search for pirate gold. See details for advisory.
1314	1	Treasure Planet	John Musker, Ron Clements	Joseph Gordon-Levitt, Brian Murray, Emma Thompson, David Pierce, Martin Short, Dane Davis	3	149	2002	5	98 min	62	Jim Hawkins follow an intergalactic map in search of Captain Flint's trove.
1315	1	Tree Climbing Lions		Alexander Braczkowski	1	149	2018	1	45 min	142	Lions in Uganda exhibit a rare, mysterious behavior – they spend much of their lives up in trees.
1316	1	Tron	Steven Lisberger	Jeff Bridges, Bruce Boxleitner, David Warner, Cindy Morgan, Barnard Hughes, Dan Shor	3	149	1982	5	96 min	24	After practicing his hacking chops, a brilliant video game maker becomes part of his own creation.
1317	1	Tru Confessions	Paul Hoen	Shia LaBeouf, Clara Bryant, William McGuire, Nicole Dicker, Kevin Duhaney, Yani Gellman	2	149	2002	6	83 min	70	A chance to star in a TV show reveals the value of family for Trudy Walker.
1318	1	Tuck Everlasting	Jay Russell	Alexis Bledel, Ben Kingsley, Sissy Spacek, Amy Irving, Victor Garber, Jonathan Jackson	3	149	2002	5	91 min	312	A woman falls in love with a man who is immortal.
1319	1	Tugboat Mickey	Clyde Geronimi	Walt Disney, Clarence Nash, Pinto Colvig	3	149	1940	6	8 min	11	Mickey captains a tugboat with Donald and Goofy as the crew. See details for advisory.
1320	1	Twas the Night	Nick Castle	Bryan Cranston, Josh Zuckerman, Jefferson Mappin, Brenda Grate, Rhys Williams, Barclay Hope	3	149	2001	6	87 min	313	Danny and his con-artist uncle take over when Santa Claus is knocked out.
1321	1	Twitches	Stuart Gillard	Tia Mowry, Tamera Mowry, Kristen Wilson, Patrick Fabian, Pat Kelly, Jennifer Robertson	3	149	2005	1	87 min	109	Reunited twin girls discover they have magical powers.
1322	1	Twitches Too	Stuart Gillard	Tia Mowry, Tamera Mowry, Kristen Wilson, Patrick Fabian, Pat Kelly, Leslie Seiler	3	149	2007	1	84 min	109	When a new evil threat arrives, it's up to the twitches to save Coventry.
1323	1	Unidentified Flying Oddball	Russ Mayberry	Dennis Dugan, Jim Dale, Ron Moody, Kenneth More, John Le Mesurier, Rodney Bewes	3	149	1979	2	93 min	36	An astronaut and his robot accidentally travel in time to medieval England.
1324	1	Up	Pete Docter	Ed Asner, Christopher Plummer, Jordan Nagai, Bob Peterson, Delroy Lindo, Jerome Ranft	3	149	2009	5	96 min	135	An unlikely pair set to the sky for the adventure of their lives.
1325	1	Up, Up and Away	Robert Townsend	Robert Townsend, Michael Pagan, Alex Datcher, Sherman Hemsley, Kevin Connolly, Olivia Burnette	15	149	2000	6	78 min	31	The teenage son in a superhero family anxiously awaits his super powers.
1326	1	Valiant	Gary Chapman	Ewan McGregor, Ricky Gervais, Tim Curry, Jim Broadbent, Hugh Laurie, John Cleese	25	149	2005	2	76 min	73	When the world needs a hero, a little pigeon steps up.
1327	1	Waking Sleeping Beauty	Don Hahn	Don Hahn, Ron Clements, Roy Disney, Glen Keane, Jeffrey Katzenberg, Roger Allers	3	149	2010	5	87 min	1	A revealing look at the events that ushered in the second chapter of Disney's animation legacy.
1328	1	WALL-E	Andrew Stanton	Ben Burtt, Elissa Knight, Jeff Garlin, Fred Willard, Macintalk , John Ratzenberger	3	149	2008	2	99 min	62	Join robots WALL-E and EVE on a fantastic journey across the universe.
1329	1	Wendy Wu: Homecoming Warrior	John Laing	Brenda Song, Shin Koyamada, Susan Chuang, Justin Chon, Michael Cheng, Andy Fischer-Price	3	149	2006	1	91 min	314	Wendy's world is flipped upside down when a mysterious young monk arrives.
1330	1	Whispers: An Elephant's Tale	Dereck Joubert	Angela Bassett, Joanna Lumley, Anne Archer, Debi Derryberry, Kevin Richardson, Alice Ghostley	3	149	2000	2	73 min	186	An adorable baby elephant bravely embarks on a journey through the harsh wilds to find his mother.
1331	1	White Fang	Randal Kleiser	Klaus Brandauer, Ethan Hawke, Seymour Cassel, James Remar, Susan Hogan, Suzanne Kent	3	149	1991	5	109 min	91	A tale of a young man's journey through the treacherous Yukon Valley with the wolf-dog he rescues.
1332	1	Who Framed Roger Rabbit	Robert Zemeckis	Bob Hoskins, Christopher Lloyd, Stubby Kaye, Joanna Cassidy, Alan Tilvern, Richard LeParmentier	3	149	1988	5	104 min	73	A juicy mystery filled with loony fun pairs a Toon-hating detective with a cartoon rabbit.
1333	2	Wild Yellowstone		Bart Thomasson	87	149	2015	1	1 Season	315	Wild Yellowstone captures the beauty and essence of the land and animals.
1334	1	Willow	Ron Howard	Val Kilmer, Joanne Whalley, Warwick Davis, Patricia Hayes, Gavan O'Herlihy, Phil Fondacaro	3	149	1987	5	127 min	30	Willow finds an abandoned baby girl destined to end an evil queen's reign.
1335	1	Winged Seduction: Birds of Paradise	Molly Hermann	Josh Goodman	3	149	2012	1	45 min	217	Shape shifting, dancing, dazzling transformers – birds of paradise are astonishing.
1336	1	Winnie the Pooh	Stephen Anderson, Don Hall	John Cleese, Jim Cummings, Bud Luckey, Craig Ferguson, Jack Boulter, Travis Oates	3	149	2011	2	68 min	11	Reunite with the beloved bear and his silly but steadfast friends.
1337	1	Winnie the Pooh: A Very Merry Pooh Year	Ed Wexler, Gary Katona, Jamie Mitchell	Jim Cummings, Peter Cullen, John Fiedler, Michael Gough, William Green, Nikita Hopkins	3	149	2002	2	67 min	38	Rabbit threatens to move away if the others won't change.
1338	1	Winnie the Pooh: Springtime with Roo	Elliot Bour, Saul Blinkoff	Jim Cummings, Ken Sansom, Jimmy Bennett, David Stiers, Kath Soucie, John Fiedler	3	149	2004	2	70 min	97	Rabbit forces the others to hold off on fun until spring cleaning is done.
1339	1	Winter Storage	Jack Hannah		3	149	1949	6	7 min	11	Donald and Chip and Dale face off over acorns. See details for advisory.
1340	2	Wizards of Waverly Place		Selena Gomez, David Henrie, Jake Austin, Jennifer Stone, Maria Canals-Barrera, David DeLuise	3	149	2007	6	4 Seasons	31	Alex, Justin, and Max Russo are not your ordinary teenagers – they’re secretly wizards in training!
1341	1	Wizards of Waverly Place: The Movie	Lev L. Spiro	Selena Gomez, David Henrie, Jake T. Austin, Jennifer Stone, Maria Canals-Barrera, David DeLuise	3	149	2009	6	94 min	56	A vacation turns into a spell-soaked adventure for the family of wizards.
1342	2	Wolverine and The X-Men		Steve Blum, Chris Edgerly, Jennifer Hale, Michael Ironside, Danielle Judovits, AJ Buckley	3	149	2008	8	1 Season	5	Wolverine and the X-Men must join together to prevent a catastrophic future.
1343	1	World's Greatest Dogs		Mike Secher	3	149	2015	1	44 min	142	From acrobatics to crazy stunts, this special celebrates amazing dogs and their owners.
1344	1	Wreck-It Ralph	Rich Moore	John Reilly, Sarah Silverman, Jack McBrayer, Jane Lynch, Alan Tudyk, Mindy Kaling	3	149	2012	5	103 min	73	Ralph sets out to prove that he is a true hero in his arcade.
1345	2	X-Men: Evolution		Noel Fisher, Vincent Gale, Christopher Judge, David Kaye, Scott McNeil, Meghan Black	3	149	2000	8	4 Seasons	5	X-Men: Evolution features the team as teenagers as they fight for a world that fears and hates them.
1346	1	Ye Olden Days	Bert Gillett		3	149	1933	8	9 min	11	Minnie is locked away for not marrying a prince, but Mickey saves her. See details for advisory.
1347	1	Yellowstone Cubs	Charles Draper	Rex Allen	3	149	1963	1	48 min	178	Two bear cubs take a mischievous tour of Yellowstone National Park. See details for advisory.
1348	1	You Lucky Dog	Paul Schneider	Kirk Cameron, Chelsea Noble, John de Lancie, Christine Healy, Granville Van Dusen, Christine Cavanaugh	3	149	1998	6	88 min	109	Jack Morgan discovers a psychic connection between himself and a dog.
1349	1	You Wish!	Paul Hoen	A.J. Trauth, Spencer Breslin, Lalaine , Sally Stockwell, Peter Feeney, Tim Reid	88	149	2003	6	88 min	312	Alex uses a magical coin to wish he didn't have a younger brother.
1350	1	Your Friend the Rat	Jim Capobianco	Patton Oswalt, Peter Sohn, Lou Romano, Tony Russell, Sigmund Vik, Jim Capobianco	3	149	2007	6	13 min	11	Remy explains why humans and rats should get along.
1351	1	Z-O-M-B-I-E-S	Paul Hoen	Milo Manheim, Meg Donnelly, Trevor Tordjman, Kylee Russell, Carla Jeffery, Kingston Foster	3	149	2018	6	97 min	316	A traditional high school must accept students from Zombietown.
1352	1	Zapped	Peter DeLuise	Zendaya , Chanelle Peloso, Spencer Boldman, Emilia McCarthy, Adam DiMarco, William Ainscough	15	149	2014	6	95 min	229	Zoey discovers a magical app that can control the boys in her life.
1353	1	Zenon: Girl of the 21st Century	Kenneth Johnson	Kirsten Storms, Raven-Symoné , Stuart Pankin, Holly Fulger, Frederick Coffin, Bob Bancroft	3	149	1999	6	97 min	229	Zenon must thwart a villain's plot after she's grounded and sent to Earth.
1354	1	Zenon: The Zequel	Manny Coto	Kirsten Storms, Lauren Maltby, Phillip Rhys, Holly Fulger, Stuart Pankin, Robert Curtis Brown	77	149	2001	6	89 min	266	Zenon sneaks down to Earth to try to save her space station.
1355	1	Zenon: Z3	Steve Rash	Kirsten Storms, Lauren Maltby, Alyson Morgan, Stuart Pankin, Holly Fulger, Ben Easter	3	149	2004	6	81 min	229	It's up to Zenon and her friends when moon goddess Selena threatens Earth.
1356	1	Zootopia	Byron Howard, Rich Moore	Ginnifer Goodwin, Jason Bateman, Idris Elba, Jenny Slate, Nate Torrence, Bonnie Hunt	3	149	2016	5	109 min	11	A rookie-cop rabbit and wily fox team up to crack a case.
1357	1	Bedknobs and Broomsticks	Robert Stevenson	Angela Lansbury, David Tomlinson, Roddy McDowall, Sam Jaffe, John Ericson, Bruce Forsyth	3	150	1971	2	118 min	54	Three children and an amateur witch team up to save England from invasion.
1358	1	Blackbeard's Ghost	Robert Stevenson	Peter Ustinov, Dean Jones, Suzanne Pleshette, Elsa Lanchester, Joby Baker, Elliott Reid	3	150	1968	2	107 min	54	A track coach inherits the mischievous ghost of famed pirate Blackbeard.
1359	1	Justin Morgan had a Horse	Hollingsworth Morse	Don Murray, Lana Wood, R.G. Armstrong, Gary Crosby, John Smith, E.W. Firestone	3	150	1972	6	88 min	289	The story of the foundation sire of the Morgan Horse Breed.
1360	1	Lady and the Tramp II: Scamp's Adventure	Darrell Rooney	Scott Wolf, Alyssa Milano, Chazz Palminteri, Jeff Bennett, Jodi Benson, Bill Fagerbakke	52	150	2001	2	73 min	173	Itching for freedom, Lady's pup Scamp joins up with the Junkyard Dogs.
1361	2	Smart Guy		Tahj Mowry, John Jones, Jason Weaver, Essence Atkins	3	150	1996	6	3 Seasons	86	A genius tries to fit in as a high school sophomore.
1362	1	The Cat from Outer Space	Norman Tokar	Ken Berry, Sandy Duncan, Harry Morgan, Roddy McDowall, McLean Stevenson, Jesse White	3	150	1978	2	104 min	34	A physicist tries to help an alien cat after it crash-lands on Earth.
1363	1	The Great Mouse Detective	John Musker, Ron Clements, Dave Michener	Vincent Price, Barrie Ingham, Val Bettin, Susanne Pollatschek, Candy Candido, Diana Chesney	3	150	1986	2	75 min	317	A super-sleuth mouse must solve a toy maker's disappearance.
1364	1	The Sword in the Stone	Wolfgang Reitherman	Sebastian Cabot, Karl Swenson, Rickie Sorensen, Junius Matthews, Ginny Tyler, Martha Wentworth	3	150	1963	2	80 min	73	Merlin trains a young orphan who's destined to be the King of England.
1365	1	Those Calloways	Norman Tokar	Brian Keith, Vera Miles, Brandon de Wilde, Walter Brennan, Ed Wynn, Linda Evans	3	150	1965	5	132 min	47	A strong-willed family struggles to establish a wild geese sanctuary. See details for advisory.
1366	2	Disney Kirby Buckets		Jacob Bertrand, Mekai Curtis, Cade Sutton, Olivia Stuck, Tiffany Espensen	3	151	2014	8	3 Seasons	56	Welcome to Kirby's world! It's rude and sketchy.
1367	2	Disney Mech-X4		Nathaniel Potvin, Raymond Cham, Kamran Lucas, Pearce Joza	12	151	2016	8	2 Seasons	157	Ryan discovers his ability to control a giant robot.
1368	2	Imagination Movers		Rich Collins, Dave Poche, Scott Durbin, Scott Smith, Wendy Calio, Kevin Carlson	3	151	2008	4	3 Seasons	14	Rock out with the Imagination Movers, Disney Junior’s favorite alternative band for preschoolers!
\.


--
-- Data for Name: type; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.type (id, type) FROM stdin;
1	Movie
2	TV Show
\.


--
-- Name: countries_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.countries_id_seq', 1, false);


--
-- Name: date_added_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.date_added_id_seq', 1, false);


--
-- Name: genres_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.genres_id_seq', 1, false);


--
-- Name: rating_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.rating_id_seq', 1, false);


--
-- Name: super_table_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.super_table_id_seq', 1, false);


--
-- Name: type_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.type_id_seq', 1, false);


--
-- PostgreSQL database dump complete
--

