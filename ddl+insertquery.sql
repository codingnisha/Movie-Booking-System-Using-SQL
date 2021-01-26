DROP SCHEMA MOVIE_BOOKING CASCADE;
CREATE SCHEMA MOVIE_BOOKING;
SET SEARCH_PATH TO MOVIE_BOOKING;

CREATE TABLE STATE_TBL(
	STATE_ID SMALLINT PRIMARY KEY,
	STATE_NAME VARCHAR(20) NOT NULL
);

CREATE TABLE CITY_TBL(
	CITY_ID INT PRIMARY KEY,
	CITY_NAME VARCHAR(20) NOT NULL,
	SID SMALLINT NOT NULL REFERENCES STATE_TBL(STATE_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE THEATRE_TBL(
	THEATRE_ID INT PRIMARY KEY,
	THEATRE_NAME VARCHAR(50) NOT NULL,
	ADDRESS_LINE1 VARCHAR(200),
	ADDRESS_LINE2 VARCHAR(200),
 	PINCODE INT NOT NULL CHECK(PINCODE between 100000 AND 999999),
	CID INT NOT NULL REFERENCES CITY_TBL(CITY_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE SCREEN_TBL(
	SCREEN_NO INT PRIMARY KEY,
	SCREEN_NAME VARCHAR(4) NOT NULL,
	TID INT NOT NULL REFERENCES THEATRE_TBL(THEATRE_ID) ON DELETE RESTRICT ON UPDATE CASCADE
);

CREATE TABLE GENRE_TBL(
	GENRE_NAME VARCHAR(20) PRIMARY KEY
);

CREATE TABLE MOVIE_TBL(
	MOVIE_ID INT PRIMARY KEY,
	MOVIE_NAME VARCHAR(50) NOT NULL,
	RELEASE_DATE DATE NOT NULL,-- CHECK(RELEASE_DATE>=CURRENT_DATE),
	DESCRIPTION VARCHAR(500),
	MOVIE_LANGUAGE VARCHAR(30) NOT NULL,
	RATING DECIMAL(3,1) CHECK(RATING>=1 AND RATING<=10),
	UNIQUE(MOVIE_NAME,RELEASE_DATE)
);

CREATE TABLE MOVIE_GENRE_TBL(
	GNAME VARCHAR(20) REFERENCES GENRE_TBL(GENRE_NAME)ON DELETE RESTRICT ON UPDATE CASCADE,
	MID INT REFERENCES MOVIE_TBL(MOVIE_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	PRIMARY KEY(GNAME,MID)
);

CREATE TABLE SHOW_TBL(
	SHOW_ID INT PRIMARY KEY,
	SNO INT NOT NULL REFERENCES SCREEN_TBL(SCREEN_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	MID INT NOT NULL REFERENCES MOVIE_TBL(MOVIE_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	DATETIME TIMESTAMP NOT NULL,-- CHECK (DATETIME > CURRENT_TIMESTAMP),
	UNIQUE(SNO,MID,DATETIME)
);

CREATE TABLE SEAT_TBL(
	SEAT_NO INT PRIMARY KEY,
	SEAT_NAME VARCHAR(3) NOT NULL,
	SNO INT NOT NULL REFERENCES SCREEN_TBL(SCREEN_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	SEAT_CATEGORY VARCHAR(8) NOT NULL CHECK(SEAT_CATEGORY IN ('SILVER','GOLD','PLATINUM')),
	UNIQUE(SEAT_NAME,SNO)
);

CREATE TABLE CUSTOMER_TBL(
	CONTACT_NO BIGINT PRIMARY KEY CHECK(CONTACT_NO BETWEEN 1000000000 AND 9999999999),
	CUSTOMER_NAME VARCHAR(30) NOT NULL,
	EMAIL VARCHAR(50)
);

CREATE TABLE TICKET_TBL(
	TICKET_NO INT PRIMARY KEY,
	PRICE Decimal(6,2) NOT NULL,
	SNO INT NOT NULL REFERENCES SEAT_TBL(SEAT_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	SID INT NOT NULL REFERENCES SHOW_TBL(SHOW_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	UNIQUE(SNO,SID)
);

CREATE TABLE PAYMENT_TBL(
	PAYMENT_ID INT PRIMARY KEY,
	AMOUNT DECIMAL(8,2) NOT NULL,
	PAYMENT_MODE BOOLEAN 
);

CREATE TABLE BOOKED_TBL(
	BOOKING_ID INT PRIMARY KEY,
	CNO BIGINT NOT NULL REFERENCES CUSTOMER_TBL(CONTACT_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	PID INT  NOT NULL REFERENCES PAYMENT_TBL(PAYMENT_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	TNO INT  NOT NULL REFERENCES TICKET_TBL(TICKET_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	BOOKING_TIME TIMESTAMP,
	UNIQUE(CNO,PID,TNO)
);

CREATE TABLE REVIEW(
	REVIEW_ID INT PRIMARY KEY,
	CNO BIGINT NOT NULL REFERENCES CUSTOMER_TBL(CONTACT_NO) ON DELETE RESTRICT ON UPDATE CASCADE,
	MID INT NOT NULL REFERENCES MOVIE_TBL(MOVIE_ID) ON DELETE RESTRICT ON UPDATE CASCADE,
	RATING DECIMAL(2,1) NOT NULL CHECK(RATING>=1 AND RATING<=10),
	REVIEW_COMMENT VARCHAR(1000) NOT NULL,
	UNIQUE(CNO,MID)
);

INSERT INTO movie_booking.state_tbl(state_id, state_name)VALUES (1, 'Gujarat');
INSERT INTO movie_booking.state_tbl(state_id, state_name)VALUES (2, 'Maharashtra');
INSERT INTO movie_booking.state_tbl(state_id, state_name)VALUES (3, 'Kerala');
INSERT INTO movie_booking.state_tbl(state_id, state_name)VALUES (4, 'Madhya Pradesh');
INSERT INTO movie_booking.state_tbl(state_id, state_name)VALUES (5, 'Rajasthan');



	
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (1, 'Ahmedabad', 1);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (2, 'Gandhinagar', 1);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (3, 'Surat', 1);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (4, 'Rajkot', 1);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (5, 'Jamnagar', 1);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (6, 'Mumbai', 2);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (7, 'Pune', 2);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (8, 'Nagpur', 2);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (9, 'Aurangabad', 2);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (10, 'Solapur', 2);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (11, 'Kochi', 3);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (12, 'Kollam', 3);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (13, 'Thrissur', 3);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (14, 'Thiruvananthapuram', 3);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (15, 'Kannur', 3);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (16, 'Indore', 4);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (17, 'Bhopal', 4);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (18, 'Ujjain', 4);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (19, 'Gwalior', 4);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (20, 'Ratlam', 4);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (21, 'Jaipur', 5);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (22, 'Jodhpur', 5);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (23, 'Kota', 5);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (24, 'Bikaner', 5);
INSERT INTO movie_booking.city_tbl(city_id, city_name, sid)VALUES (25, 'Udaipur', 5);




INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Comedy');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Horror');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Romance');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Thriller');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Action');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Adventure');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Mystery');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Drama');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Satire');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Biography');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Sci-Fi');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Crime');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Fantasy');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Sports');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Documentary');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('History');
INSERT INTO movie_booking.genre_tbl(genre_name)VALUES ('Science&Nature');




INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (1, 'Khaali Peeli','01-Oct-2020','In a nutshell, ‘Khaali Peeli’ has slow-mos and a background score that is faster than the heartbeat of an average young adult and on top of everything, a hot pair leading the show! But it derails every once in a while and you wonder – quite empathetically – why! Then again, if you are missing your regular dose of the larger-than-life heroes on celluloid, ‘Khaali Peeli’ is the turn you take – samajla na? CAST : Ishaan Khatter,Ananya Panday','Hindi',1.9);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (2, 'Dolly Kitty Aur Woh Chamakte Sitare', '18-Sep-2020', 'The movie is directed by Alankrita Shrivastava and featured Konkona Sen Sharma, Bhumi Pednekar, Vikrant Massey and Amol Parashar as lead characters. Other popular actors who were roped in for Dolly Kitty Aur Woh Chamakte Sitare are Aamir Bashir, Neelima Azim and Kubbra Sait. CAST : Konkona Sen Sharma, Bhumi Pednekar, Vikrant Massey,Amol Parashar','Hindi', 5.5);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (3, 'Sadak 2','28-Aug-2020','In a nutshell, ‘Sadak 2’, for everyone involved with this project, should have been a ‘road not taken’. CAST :Sanjay Dutt,Alia Bhatt,Aditya Roy Kapur','Hindi',5.5);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (4, 'Khuda Haafiz', '14-Aug-2020','‘Khuda Haafiz’ does not have the most innovative script on the planet but it still could have worked had it not been for the randomness in the second half and the outrageously sham Arabic accents.','Hindi', 7.2);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (5, 'Gunjan Saxena: The Kargil Girl', '12-Aug-2020', 'More than anything else, Gunjan Saxena: The Kargil Girl is a deeply moving tale of a feminist father and his feisty daughter. It wages war against patriarchal mind-set and discrimination, and identifies it as a bigger threat to progress than the one we perhaps tackled in 1999.','Hindi', 5.2);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (6,'Pareeksha - The Final Test','06-Aug-2020', 'The screenplay has noble intent at its heart but only manages to touch upon the periphery of the subject of the Indian education system and its shortcomings – an issue that required an in-depth handling. CAST :Adil Hussain,Shourya Deep,Sanjay Suri','Hindi',8.2);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (7, 'Lootcase','31-Jul-2020','The plotline is intrigue personified; given. But, what it does lack is a stable momentum and subtexts that came off as fresh-from-the-oven ideas.','Hindi', 7.7);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (8, 'Shakuntala Devi','31-Jul-2020','Vidya Balan gets under the skin of her character and simply aces it in the titular role – she gives an unrestrained performance as Shakuntala Devi from the 1950s to 2000s which is captivating to watch, as every stage of her life unfolds.','Hindi', 6.1);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (9, 'Raat Akeli Hai', '31-Jul-2020','Raat Akeli Hai is a sincere attempt but it isn’t engaging enough for you to feel the joy of solving a murderous puzzle or detective riddles. CAST :Nawazuddin Siddiqui,Radhika Apte,Shweta Tripathi','Hindi',7.3);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (10,'Dil Bechara','24-Jul-2020','‘Dil Bechara’ will always be remembered as Sushant Singh Rajput’s swan song. Watch this movie simply to witness Sushant Singh Rajput’s last act. A brilliant one at that.CAST :Sushant Singh Rajput,Sanjana Sanghi,Sahil Vaid','Hindi',7.9);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (11, 'Angrezi Medium','13-Mar-2020','There are some fantastic moments in the film, and sharply written scenes between the characters, too, which in turn, prove to be the highlights of this drama. CAST :Irrfan Khan,Kareena Kapoor,Pankaj Tripathi','Hindi',7.3);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (12, 'Laxmmi Bomb', '09-Nov-2020', 'Laxmmi Bomb is an upcoming Hindi movie scheduled to be released on 9 Nov, 2020. The movie is directed by Raghava Lawrence and will feature Akshay Kumar, Kiara Advani, Babu Antony and Tusshar Kapoor as lead characters. Other popular actors who were roped in for Laxmmi Bomb are Sharad Kelkar and Mir Sarwar. CAST :Akshay Kumar,Kiara Advani,Sharad Kelkar,Muskaan Khubchandani','Hindi',4.5);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (13, 'The Discovery','13-Mar-2020','A science-fiction romance starring Robert Redford begins with the premise that proof of what’s next has been found. After that, things turn ugly. CAST :Robert Redford,Mary Steenburgen,Brian McCarthy','English',6.3);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (14, 'The Commuter','08-Jan-2018',' On his daily train commute, an insurance salesman gets railroaded into accepting a suspiciously lucartive offer from a mysterious follow passenger. CAST :Liam Neeson,Vera Farmigo,Patrick Wilson','English',6.3);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (15, 'Clash of the Titians','08-Jan-2020','Perseus, a demigod and son of Zeus, embarks on an adventure as he sets out to thwart Hades, who threatens to release the monstrous Kraken on Earth if his demands are not met.. CAST :Sam Worthington,Gemma Arterton,Ralph Fiennes','English',5.8);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (16, 'David Attenborough: A Life On Our Planet','16-Apr-2020','In his 93 years, Attenborough has visited every continent on the globe, exploring the wild places of the planet and documenting the living world in all its variety and wonder. But during his lifetime, Attenborough has also seen first-hand the monumental scale of humanitys impact on nature. CAST :David Attenborough','English',9.2);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (17, 'The Glorias','30-Sept-2020',' The story of feminist icon Gloria Steinems itinerant childhood influence on her life as a writer, activist and organizer for womens rights worldwide. CAST :Julianne Moore, Alicia Vikander, Janelle Monáe, Ryan Kiera Armstrong','English',4.6);
INSERT INTO movie_booking.movie_tbl(movie_id, movie_name, release_date, description, movie_language, rating)VALUES (18, 'Human Nature','12-Mar-2020',' A breakthrough called CRISPR opens the door to curing diseases, reshaping the biosphere, and designing our own children. A provocative exploration of its far-reaching implications, through the eyes of the scientists who discovered it . CAST :Jennifer Doudna, George Church, Alta Charo','English',7.7);



INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',1);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Adventure',1);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Romance',1);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Mystery',1);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Comedy',2);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Satire',2);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',2);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',3);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',3);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Thriller',3);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Romance',3);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',4);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Thriller',4);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Romance',4);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Adventure',4);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Mystery',4);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',5);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',5);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Biography',5);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',6);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',7);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Comedy',7);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Thriller',7);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',8);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Biography',8);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',9);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Thriller',9);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Mystery',9);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',10);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Romance',10);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Comedy',10);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',11);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Comedy',11);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Comedy',12);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Horror',12);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Sci-Fi',13);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Romance',13);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Crime',14);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',14);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Thriller',14);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Fantasy',15);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Action',15);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Documentary',16);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('History',17);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Drama',17);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Science&Nature',18);
INSERT INTO movie_booking.movie_genre_tbl(gname, mid)VALUES('Documentary',18);




INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (1, 'Cinepolis', 'Ahmedabad One Mall', 'Sarkari Vasahat Road, Vastrapur, Ahmedabad, Gujarat','380054', 1);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (2, 'Time Cinema Ahmedabad CG Road', 'CG Square Mall', 'CG Square Mall, Chimanlal Girdharlal Rd, Ahmedabad, Gujarat','380006', 1);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (3, 'PVR Acropolis', 'The Acropolis', 'Acropolis Mall, Cross Road, Sarkhej - Gandhinagar Highway, A/604, Drive In Rd, Thaltej, Ahmedabad, Gujarat','380059', 1);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (4, 'Carnival Cinemas', 'Himalaya mall', '3 Himalaya Mall Drive In Road Memnagar Ahmedabad Gujarat 380054 IN, Drive In Rd, Ahmedabad, Gujarat','380054', 1);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (5, 'City Gold The Multiplex- Ashram Road', 'Ashram Rd, near Dena Bank, Muslim Society','Navrangpura, Ahmedabad, Gujarat','380009', 1);

INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (6, 'Metro INOX Cinema','Mahatma Gandhi Road, Dhobi Talao',' New Marine Lines, Junction, Mumbai, Maharashtra','400020', 6);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (7, 'Regal Cinema', 'Colaba Causeway, opposite Chhatrapati Shivaji Maharaj Vastu Sangrahalaya','Apollo Bandar, Colaba, Mumbai, Maharashtra','400005', 6);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (8, 'Eros Cinema', 'Cambata Building, 42, Maharshi Karve Rd',' Churchgate, Mumbai, Maharashtra','400020', 6);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (9, 'Cinepolis', 'Centre Square Mall, Kochi','66/6284-H, 6th Floor, Centre Square Mall, Mahatma Gandhi Rd, Shenoys','682035', 11);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (10, 'Q Cinemas', 'Eliora Fashion','Gold Souk Grandé Mall, Panvel - Kochi - Kanyakumari Hwy, Vyttila, Kochi, Kerala ','682019', 11);

INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (11, 'PVR', 'Treasure Island Mall','TI Mall, 4th, 11, Mahatma Gandhi Rd, South Tukoganj, Indore, Madhya Pradesh','452001', 16);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (12, 'Carnival Cinemas', 'Circle, Mangal City, Plot No.A-1, PU-4, Garipipliya Road Scheme No.54',' Vijay Nagar, Indore, Madhya Pradesh ','452010', 16);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (13, 'Carnival Cinemas', 'Malhar Mega Mall','A.B.Road, Vijay Nagar, Indore, Madhya Pradesh','452010', 16);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (14, 'Raj Mandir Cinema', 'C-16, Bhagwan Das Rd, Panch Batti, C Scheme',' Ashok Nagar, Jaipur, Rajasthan','302001', 21);
INSERT INTO movie_booking.theatre_tbl(theatre_id, theatre_name, address_line1, address_line2, pincode, cid)VALUES (15, 'PVR','Forum Celebration Mall Udaipur','Celebration Mall, NH - 8, opp. Devendra Dham, Bhuwana, Udaipur, Rajasthan','313001', 25);




INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (1, 'A', 1);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (2, 'B', 1);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (3, 'C', 1);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (4, 'D', 1);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (5, 'A', 2);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (6, 'B', 2);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (7, 'C', 2);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (8, 'D', 2);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (9, 'A', 3);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (10, 'B', 3);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (11, 'C', 3);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (12, 'D', 3);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (13, 'A', 4);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (14, 'B', 4);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (15, 'C', 4);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (16, 'D', 4);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (17, 'A', 5);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (18, 'B', 5);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (19, 'C', 5);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (20, 'D', 5);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (21, 'A', 10);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (22, 'B', 10);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (23, 'C', 10);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (24, 'D', 10);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (25, 'A', 11);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (26, 'B', 11);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (27, 'C', 11);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (28, 'D', 11);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (29, 'A', 14);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (30, 'B', 14);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (31, 'C', 14);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (32, 'D', 14);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (33, 'A', 15);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (34, 'B', 15);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (35, 'C', 15);
INSERT INTO movie_booking.screen_tbl(screen_no, screen_name, tid)VALUES (36, 'D', 15);




INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (1, 1, 1, '2020-10-3 10:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (2, 5, 1, '2020-10-3 8:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (3, 5, 1, '2020-10-3 20:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (4, 6, 2, '2020-9-18 21:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (5, 7, 2, '2020-9-19 14:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (6, 13, 2, '2020-9-19 16:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (7, 22, 2, '2020-9-22 19:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (8, 14, 3, '2020-8-29 18:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (9, 9, 3, '2020-8-29 18:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (10, 9, 3, '2020-8-29 20:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (11, 10, 3, '2020-8-30 8:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (12, 10, 4, '2020-8-14 10:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (13, 14, 4, '2020-8-17 14:30:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (14, 19, 5, '2020-8-12 21:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (15, 14, 6, '2020-8-7 12:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (16, 21, 6, '2020-8-8 22:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (17, 8, 12, '2020-6-8 12:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (18, 5, 12, '2020-6-7 11:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (19, 10, 13, '2020-9-9 16:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (20, 34, 16, '2020-5-5 13:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (21, 8, 17, '2020-10-6 14:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (22, 20, 14, '2020-6-8 10:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (23, 27, 18, '2020-10-10 18:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (24, 30, 18, '2020-10-5 12:00:00');
INSERT INTO movie_booking.show_tbl(show_id, sno, mid, datetime)VALUES (25, 35, 15, '2020-2-10 17:00:00');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (1, 'A1', 1, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (2, 'A2', 1, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (3, 'A3', 1, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (4, 'A4', 1, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (5, 'A5', 1, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (6, 'B1', 1, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (7, 'B2', 1, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (8, 'B3', 1, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (9, 'B4', 1, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (10,'B5', 1, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (11,'C1', 1, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (12,'C2', 1, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (13,'C3', 1, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (14,'C4', 1, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (15,'C5', 1, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (16, 'A1', 2, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (17, 'A2', 2, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (18, 'A3', 2, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (19, 'A4', 2, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (20, 'A5', 2, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (21, 'B1', 2, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (22, 'B2', 2, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (23, 'B3', 2, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (24, 'B4', 2, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (25, 'B5', 2, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (26, 'C1', 2, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (27, 'C2', 2, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (28, 'C3', 2, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (29, 'C4', 2, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (30, 'C5', 2, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (31, 'A1', 5, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (32, 'A2', 4, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (33, 'A3', 3, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (34, 'A4', 3, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (35, 'A5', 4, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (36, 'B1', 5, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (37, 'B2', 6, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (38, 'B3', 6, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (39, 'B4', 7, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (40, 'B5', 7, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (41, 'C1', 7, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (42, 'C2', 8, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (43, 'C3', 9, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (44, 'C4', 10, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (45, 'C5', 10, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (46, 'A1', 35, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (47, 'A2', 35, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (48, 'A3', 35, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (49, 'A4', 20, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (50, 'A5', 34, 'PLATINUM');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (51, 'B1', 30, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (52, 'B2', 30, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (53, 'B3', 30, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (54, 'B4', 27, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (55, 'B5', 27, 'GOLD');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (56, 'C1', 27, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (57, 'C2', 9, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (58, 'C3', 5, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (59, 'C4', 9, 'SILVER');
INSERT INTO movie_booking.seat_tbl(seat_no, seat_name, sno, seat_category)VALUES (60, 'C5', 7, 'SILVER');





INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (1, 400, 1, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (2, 400, 2, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (3, 400, 3, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (4, 400, 4, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (5, 350, 5, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (6, 300, 6, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (7, 300, 7, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (8, 300, 8, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (9, 300, 9, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (10, 200, 10, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (11, 200, 11, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (12, 200, 12, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (13, 200, 13, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (14, 200, 14, 1);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (15, 150, 15, 1);

INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (16, 400, 16, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (17, 400, 17, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (18, 400, 18, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (19, 400, 19, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (20, 350, 20, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (21, 300, 21, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (22, 300, 22, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (23, 300, 23, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (24, 300, 24, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (25, 200, 25, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (26, 200, 26, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (27, 200, 27, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (28, 200, 28, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (29, 200, 29, 2);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (30, 150,30, 2);

INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (31, 400, 5, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (32, 400, 4, 4);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (33, 400, 3, 5);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (34, 400, 4, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (35, 350, 9, 4);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (36, 300, 5, 5);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (37, 300, 6, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (38, 300, 7, 4);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (39, 300, 8, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (40, 200, 11, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (41, 200, 12, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (42, 200, 9, 3);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (43, 200, 13, 4);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (44, 200, 15, 4);
INSERT INTO movie_booking.ticket_tbl(ticket_no, price, sno, sid)VALUES (45, 150, 9, 5);






INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9978353466,'Raj Verma', 'raj44verma@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9874125468,'Jay Shah', 'Jayshah232@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7741259863,'Heena Sharma', 'sharmaheena2@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7984221122,'Rohit Sharma', 'Rohit45sharma@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9909523999,'Dhoni Singh', 'captaincool07@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9825293153,'Meenakshi Menon', 'menonMeena54@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9987411458,'Ria Parekh', 'reep342@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9654123478,'Mahima Patel', 'PatelMahima4@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9877441122,'Daksh Jhala', 'JhalaBoy12@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9725339725,'Virat Kohli', 'One8Virat@outlookmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7944124489,'Shikkhar Dhawan', 'GabbruDhawan29@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7574986541,'Lavina Agarwal', 'LavinaRocks11@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7745989896,'Jheel Singh', 'SinghJheel4@hotmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9696961235,'Yash Verma', 'Yashverma33@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9641223547,'Anushka Pania', 'Pania.Anushka12@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9663321414,'Aditi Neema', 'AditiNeema12@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (9335544881,'Nivedita Kundu', 'KunduNivedita4@hotmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7796545899,'Shlok Jadeja', 'Shlok3Jadeja@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7898546214,'Bhuveneshwar Kumar', 'BhuviKumar54@gmail.com');
INSERT INTO movie_booking.customer_tbl(contact_no, customer_name, email)VALUES (7742698521,'Jasprit Bumrah', 'BoomBoomBumrah1@gmail.com');




INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (1, 600, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (2, 200, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (3, 750, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (4, 800, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (5, 1600, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (6, 1600, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (7, 600, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (8, 800, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (9, 800, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (10, 400, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (11, 200, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (12, 200, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (13, 350, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (14, 150, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (15, 250, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (16, 350, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (17, 600, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (18, 750, '1');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (19, 500, '0');
INSERT INTO movie_booking.payment_tbl(payment_id, amount, payment_mode)VALUES (20, 150, '1');



INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(1, 7574986541, 1, 27, '2020-2-3 6:30:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(2, 9978353466, 4, 16, '2020-5-13 6:30:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(3, 9663321414, 2, 29, '2020-6-3 6:30:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(4, 9978353466, 3, 32, '2020-7-17 17:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(5, 9978353466, 12, 17, '2020-7-10 15:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(6, 9335544881, 15, 10, '2020-8-18 10:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(7, 9641223547, 10, 18, '2020-9-9 15:30:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(8, 7742698521, 15, 28, '2020-9-15 19:30:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(9, 7898546214, 18, 31, '2020-9-18 20:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(10, 9641223547, 11, 8, '2020-9-30 16:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(11, 7898546214, 13, 9, '2020-10-1 19:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(12, 9825293153, 14, 18, '2020-10-1 21:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(13, 7742698521, 15, 15, '2020-10-5 22:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(14, 9641223547, 10, 25, '2020-10-7 10:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(15, 7574986541, 16, 30, '2020-10-10 11:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(16, 9825293153, 17, 24, '2020-10-12 12:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(17, 9725339725, 12, 15, '2020-10-13 16:00:00');
INSERT INTO movie_booking.booked_tbl(booking_id, cno, pid, tno, booking_time)VALUES(18, 7745989896, 19, 45, '2020-10-13 18:00:00');



INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(1, 9978353466, 1, 4, 'A Typical Bollywood Masala with New Star-cast but NOT with the new Story. Khaali Peeli is a Action-packed Drama starring Ananya Pandey, Ishaan Khatter but there is nothing new in the story line. The same old drama which includes Hero, Heroine, Police, Goons , Music and Few Emotional Scenes. The good part of the movie is the The Chemistry between the lead pair of the movie and they look good together as they are playing their age. Written by Yash Kesarwani and Sima Agarwal, Screenplay is written fantastically keeping in mind todays time. It also keeps you engaging till the climax, but the climax is predictable. There is no romantic track, all the songs are rock peppy numbers keeping the fast pace of the story. The "Tapori" accent and Ishaan Khatter Dance are another plus points of the drama.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(2, 7742698521, 2, 5, 'Dolly Kitty Aur Woh Chamakte Sitare is a self discovering journey of two backward middle class women from North India. This empowering feminist tale is about Dolly & Kitty who break the society norms and make their own choices. The slow liberating drama is rescued by its two lead characters. ');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(3, 7745989896, 3, 6, 'It was a nice watch, brought out some social issues and challenged some beliefs like trust on godmen, blind faith, parents undying love for children...thus while it may not sit well with our preconcieved notions, it challeneges us to think why we have these beliefs in the first place? And whether they are actually universal truths or just more of generational beliefs that are passed on to us.....forming sort of an archetype in out psyche. The movie has good twists which come as a surpirse, and a decent story line. I love how they"ve incorporated scenes, songs, moments and dialogues from sadak as flashbacks to give a feeling of continuity and give depth to Sanjay Dutt"s character. Also subtle things sprinkled across for movie buffs to pick up on.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(4, 7741259863, 5, 2, 'I started watching the movie and somewhere into pre-mid of the movie, seeing Ishaan Khatter I thought "is this some performance? what a joker this person is turning out to be". Then, my mind trailed off to Joker, and I recalled I wanted to see The Dark Knight again and compare Heath with Joaquin. Khaali Peeli is such a drag, my brain says. It convinced me to stop mid way and go and watch The Dark Knight again. I did so and that was awesome. I watched Dark Knight again, and reveled in such relevance, such complexity in human nature and that boat scene, that hit me different level second time.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(5, 9825293153, 7, 3 ,'Just finished watching the movie.. the movie bring our attention to a number of issues which are not given enough importance, the needs of an woman has been beautifully portrayed.  The movie conveys a number of beautiful messages. How the educated society brings about genfer roles and imposes the gender-wise preference ....the communal intolerance..love knows no boundaries and so on..However at some places the movie went wrong, cheating can never been an option ..if dolly"s husband was wrong using the app even dolly was wrong cheating on his husband..I felt somewhere Dolly"s case was justified that she was never happy with her husband so she left...but cheating is never ever an option in a relationship...moreover the end of the movie was quite unrealistic!!...overall its av good movie to watch with lots of social awareness');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(6, 9725339725, 2, 4, 'This aint no Woody Allen type movie — loaded with irony, and male gaze — for sure. If anything it is the opposite, which might be for the better.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(7, 9335544881, 6, 6, 'Got me teary eyed. Though the plot is obvious and heard many times, it is Adil Hussains performance that deserves applause. I watched Pareeksha during the time when all OTT platforms were flooded with crime thrillers. This film is bit different yet not so new. Its inspiring and shows a mirror to the society. A special mention to Priyanka Bose who did complete justice to her role as a supportive wife and strong mother.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(8, 7741259863, 8, 7, 'The movie Shakuntala Devi is based on the biography of world‑famous mathematician Shakuntala Debi but it may not be the complete true fact which has been shown in the movie. Those who love math and numbers might not love this movie');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(9, 9641223547, 11, 6, 'There are some fantastic moments in the film, and sharply written scenes between the characters, too, which in turn, prove to be the highlights of this drama. ');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(10, 7574986541, 15, 8, 'I watched this film last night with a heavy heart and feeling skeptical and ba da bim ba da boom I enjoyed this film to the fullest. Because I read critics and stuff like that and look at that how low it is 5.3/10??? To be honest, this movies is solid 7/10. Of course it kinda fast-paced but you will enjoy it like riding a roller coaster. You will sympathise with Perseus and enjoy the journey of him to find the way to defeat the Kraken. The graphic too is amazing!!');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(11, 9978353466, 10, 7, 'Dil Bechara will always be remembered as Sushant Singh Rajputs swan song. Watch this movie simply to witness Sushant Singh Rajputs last act. A brilliant one at that.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(12, 9335544881, 12, 5, 'Laxmmi Bomb is an upcoming Indian Hindi-language comedy horror film written and directed by Raghava Lawrence in his Hindi directorial debut. ');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(13, 7741259863, 15, 6, 'The graphics are amazing. The story is good, it is a fight between good and bad becoming an emperor of this world. It is a fictional movie but narrated most interestingly. Multiple small stories combined to bang the entire narration to a greater extent. One who pays close attention can clearly understand the moral of this movie. I admired the story and acting projected on the screen.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(14, 7898546214, 17, 7, 'The Glorias rejects complex character building and storytelling in favor of a fairly rote sermon featuring fairly wooden icons.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(15, 9725339725, 16, 8, 'This powerful documentary finds the much-loved and well-respected natural historian in a somber mood.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(16, 7574986541, 13, 5, 'Crazy, I watched this movie before and it left me with a lot of questions... rewatched it a couple months later and I understand if now. There are definitely alternate realties going on in the universe when we are alive or not. Are you really alive?');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(17, 7898546214, 14, 4, 'It was not a bad action movie. The story is... unique. It doesnot feel like that whole movie is in a train,  which it is but that is a good thing. They certainly throw an immense amount of little things at you at once,  which can feel overwhelming. A very huge blooper,  no spoiler,  but pay attention to Liam Neesons bag,  just casually dissapears between scenes and then he sporadically has it over his shoulder again.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(18, 9335544881, 11, 9, 'It was just fabulous & the content is very confounding. I anticipate more such documentaries in future. I myself am a research student. CRISPR is my current favourite research topic, the way they have shown the origin, engineering & applications of this technology.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(19, 7741259863, 17, 7, 'This movie was very well done, moving, and inspirational. Gloria Steinem is more than a feminist. She has been instrumental in the movement for the rights and dignity of all humans for decades. She is strong, humane, capable, successful, and very smart.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(20, 9978353466, 16, 8, 'This film is remarkable. There is no justification for any rating less than five stars. As I saw it, Sir Davids main takeaways for the film were: 1: changing our diet to be more plant based and less carnivorous 2: reducing the size of the areas we farm.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(21, 9641223547, 13, 6, 'This movie was really good. Thought provoking and sweet. I feel like the type of people that can not appreciate this movie cannot because they lack the imagination or ability to follow,so the circus music in their heads fill in the gaps.');
INSERT INTO movie_booking.review(review_id, cno, mid, rating, review_comment)VALUES(22, 9335544881, 18, 7, 'This is an excellent explanation of CRISPR, how it works and we can use it as a tool.  It also gives great bioethics points of view on both sides.  It is very engaging and contains old footage and animations to explain things very well.');



