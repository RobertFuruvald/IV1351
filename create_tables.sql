CREATE TABLE brand (
 brand_id SERIAL NOT NULL,
 brand_name VARCHAR(50)
);

ALTER TABLE brand ADD CONSTRAINT PK_brand PRIMARY KEY (brand_id);


CREATE TABLE genre (
 genre_id SERIAL NOT NULL,
 genre VARCHAR(50) NOT NULL
);

ALTER TABLE genre ADD CONSTRAINT PK_genre PRIMARY KEY (genre_id);


CREATE TABLE instruments (
 instrument_id SERIAL NOT NULL,
 instrument_type VARCHAR(50)
);

ALTER TABLE instruments ADD CONSTRAINT PK_instruments PRIMARY KEY (instrument_id);


CREATE TABLE person (
 person_id SERIAL NOT NULL,
 person_number VARCHAR(12) UNIQUE NOT NULL,
 first_name VARCHAR(50) NOT NULL,
 last_name VARCHAR(50) NOT NULL,
 email VARCHAR(100) UNIQUE,
 street VARCHAR(50),
 zip VARCHAR(5),
 city VARCHAR(50)
);

ALTER TABLE person ADD CONSTRAINT PK_person PRIMARY KEY (person_id);


CREATE TABLE phone (
 phone_id SERIAL NOT NULL,
 phone_no VARCHAR(50) NOT NULL
);

ALTER TABLE phone ADD CONSTRAINT PK_phone PRIMARY KEY (phone_id);


CREATE TABLE rentable_instrument (
 rent_inst_id SERIAL NOT NULL,
 brand_id SERIAL NOT NULL,
 instrument_id SERIAL NOT NULL,
 price_monthly VARCHAR(50) NOT NULL
);

ALTER TABLE rentable_instrument ADD CONSTRAINT PK_rentable_instrument PRIMARY KEY (rent_inst_id,brand_id);


CREATE TABLE sibling (
 sibling_id SERIAL NOT NULL,
 sibling_student_id SERIAL NOT NULL
);

ALTER TABLE sibling ADD CONSTRAINT PK_sibling PRIMARY KEY (sibling_id);


CREATE TABLE skill_level (
 skill_level_id SERIAL NOT NULL,
 skill VARCHAR(50) NOT NULL
);

ALTER TABLE skill_level ADD CONSTRAINT PK_skill_level PRIMARY KEY (skill_level_id);


CREATE TABLE student (
 student_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL,
 enrolled VARCHAR(50)
);

ALTER TABLE student ADD CONSTRAINT PK_student PRIMARY KEY (student_id);


CREATE TABLE student_instruments (
 instrument_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL,
 skill_level_id SERIAL NOT NULL
);

ALTER TABLE student_instruments ADD CONSTRAINT PK_student_instruments PRIMARY KEY (instrument_id,student_id,skill_level_id);


CREATE TABLE student_siblings (
 sibling_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
 
);
ALTER TABLE student_siblings ADD CONSTRAINT PK_student_siblings PRIMARY KEY (sibling_id,student_id);


CREATE TABLE application_student (
 application_id SERIAL NOT NULL,
 person_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE application_student ADD CONSTRAINT PK_application_student PRIMARY KEY (application_id);


CREATE TABLE contact_person (
 contact_person_id SERIAL NOT NULL,
 relation_type_student VARCHAR(50),
 person_id SERIAL NOT NULL
);

ALTER TABLE contact_person ADD CONSTRAINT PK_contact_person PRIMARY KEY (contact_person_id);


CREATE TABLE instructor (
 instructor_id SERIAL NOT NULL,
 emplyment_id VARCHAR(50) UNIQUE NOT NULL,
 person_id SERIAL NOT NULL
);

ALTER TABLE instructor ADD CONSTRAINT PK_instructor PRIMARY KEY (instructor_id);


CREATE TABLE instructor_genre (
 genre_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
);

ALTER TABLE instructor_genre ADD CONSTRAINT PK_instructor_genre PRIMARY KEY (genre_id,instructor_id);


CREATE TABLE instructor_instruments (
 instrument_id SERIAL NOT NULL,
 instructor_id SERIAL NOT NULL
);

ALTER TABLE instructor_instruments ADD CONSTRAINT PK_instructor_instruments PRIMARY KEY (instrument_id,instructor_id);


CREATE TABLE instrument_rented (
 instrument_rented_id SERIAL NOT NULL,
 rent_start DATE NOT NULL,
 rent_end DATE NOT NULL,
 student_id SERIAL NOT NULL,
 rent_inst_id SERIAL NOT NULL,
 brand_id SERIAL NOT NULL,
 instrument_returned DATE
);

ALTER TABLE instrument_rented ADD CONSTRAINT PK_instrument_rented PRIMARY KEY (instrument_rented_id);



CREATE TABLE person_phone (
 person_id SERIAL NOT NULL,
 phone_id SERIAL NOT NULL
);

ALTER TABLE person_phone ADD CONSTRAINT PK_person_phone PRIMARY KEY (person_id,phone_id);


CREATE TABLE price (
 price_id SERIAL NOT NULL,
 lesson_type VARCHAR(50) NOT NULL,
 sibling_discount VARCHAR(50),
 skill_level_id SERIAL,
 price VARCHAR(50)
);

ALTER TABLE price ADD CONSTRAINT PK_price PRIMARY KEY (price_id);


CREATE TABLE student_contact_person (
 contact_person_id SERIAL NOT NULL,
 student_id SERIAL NOT NULL
);

ALTER TABLE student_contact_person ADD CONSTRAINT PK_student_contact_person PRIMARY KEY (contact_person_id,student_id);


CREATE TABLE lesson (
 lesson_id SERIAL NOT NULL,
 time_slot TIME(6),
 lesson_date DATE,
 room VARCHAR(50),
 instructor_id SERIAL,
 price_id SERIAL NOT NULL,
 instrument_id SERIAL
);

ALTER TABLE lesson ADD CONSTRAINT PK_lesson PRIMARY KEY (lesson_id);


CREATE TABLE lesson_attendees (
 student_id SERIAL NOT NULL,
 lesson_id SERIAL NOT NULL
);

ALTER TABLE lesson_attendees ADD CONSTRAINT PK_lesson_attendees PRIMARY KEY (student_id,lesson_id);



CREATE TABLE group_lesson (
 lesson_id SERIAL NOT NULL,
 min_students VARCHAR(50) NOT NULL,
 max_students VARCHAR(50) NOT NULL
);

ALTER TABLE group_lesson ADD CONSTRAINT PK_group_lesson PRIMARY KEY (lesson_id);


CREATE TABLE ensamble (
 lesson_id SERIAL NOT NULL,
 genre_id SERIAL NOT NULL
);

ALTER TABLE ensamble ADD CONSTRAINT PK_ensamble PRIMARY KEY (lesson_id,genre_id);

ALTER TABLE rentable_instrument ADD CONSTRAINT FK_rentable_instrument_0 FOREIGN KEY (brand_id) REFERENCES brand (brand_id) ON DELETE CASCADE;
ALTER TABLE rentable_instrument ADD CONSTRAINT FK_rentable_instrument_1 FOREIGN KEY (instrument_id) REFERENCES instruments (instrument_id) ON DELETE CASCADE;


ALTER TABLE student ADD CONSTRAINT FK_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE;


ALTER TABLE student_instruments ADD CONSTRAINT FK_student_instruments_0 FOREIGN KEY (instrument_id) REFERENCES instruments (instrument_id) ON DELETE CASCADE;
ALTER TABLE student_instruments ADD CONSTRAINT FK_student_instruments_1 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE student_instruments ADD CONSTRAINT FK_student_instruments_2 FOREIGN KEY (skill_level_id) REFERENCES skill_level (skill_level_id) ON DELETE CASCADE;

ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE student_siblings ADD CONSTRAINT FK_student_siblings_1 FOREIGN KEY (sibling_id) REFERENCES sibling (sibling_id) ON DELETE CASCADE;

ALTER TABLE application_student ADD CONSTRAINT FK_application_student_0 FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE;
ALTER TABLE application_student ADD CONSTRAINT FK_application_student_1 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE contact_person ADD CONSTRAINT FK_contact_person_0 FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE;


ALTER TABLE instructor ADD CONSTRAINT FK_instructor_0 FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE;


ALTER TABLE instructor_genre ADD CONSTRAINT FK_instructor_genre_0 FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE CASCADE;
ALTER TABLE instructor_genre ADD CONSTRAINT FK_instructor_genre_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;


ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_0 FOREIGN KEY (instrument_id) REFERENCES instruments (instrument_id) ON DELETE CASCADE;
ALTER TABLE instructor_instruments ADD CONSTRAINT FK_instructor_instruments_1 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE CASCADE;


ALTER TABLE instrument_rented ADD CONSTRAINT FK_instrument_rented_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;
ALTER TABLE instrument_rented ADD CONSTRAINT FK_instrument_rented_1 FOREIGN KEY (rent_inst_id,brand_id) REFERENCES rentable_instrument (rent_inst_id,brand_id) ON DELETE CASCADE;


ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_0 FOREIGN KEY (person_id) REFERENCES person (person_id) ON DELETE CASCADE;
ALTER TABLE person_phone ADD CONSTRAINT FK_person_phone_1 FOREIGN KEY (phone_id) REFERENCES phone (phone_id) ON DELETE CASCADE;



ALTER TABLE price ADD CONSTRAINT FK_price_0 FOREIGN KEY (skill_level_id) REFERENCES skill_level (skill_level_id) ON DELETE CASCADE;
ALTER TABLE IF EXISTS price
    ALTER COLUMN skill_level_id DROP NOT NULL;

ALTER TABLE student_contact_person ADD CONSTRAINT FK_student_contact_person_0 FOREIGN KEY (contact_person_id) REFERENCES contact_person (contact_person_id) ON DELETE CASCADE;
ALTER TABLE student_contact_person ADD CONSTRAINT FK_student_contact_person_1 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE CASCADE;


ALTER TABLE lesson ADD CONSTRAINT FK_lesson_0 FOREIGN KEY (instructor_id) REFERENCES instructor (instructor_id) ON DELETE NO ACTION;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_1 FOREIGN KEY (price_id) REFERENCES price (price_id) ON DELETE NO ACTION;
ALTER TABLE lesson ADD CONSTRAINT FK_lesson_2 FOREIGN KEY (instrument_id) REFERENCES instruments (instrument_id) ON DELETE NO ACTION;
ALTER TABLE IF EXISTS lesson
ALTER COLUMN instrument_id DROP NOT NULL;
ALTER TABLE IF EXISTS lesson
ALTER COLUMN instructor_id DROP NOT NULL;

ALTER TABLE lesson_attendees ADD CONSTRAINT FK_lesson_attendees_0 FOREIGN KEY (student_id) REFERENCES student (student_id) ON DELETE NO ACTION;
ALTER TABLE lesson_attendees ADD CONSTRAINT FK_lesson_attendees_1 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE NO ACTION;


ALTER TABLE group_lesson ADD CONSTRAINT FK_group_lesson_0 FOREIGN KEY (lesson_id) REFERENCES lesson (lesson_id) ON DELETE CASCADE;


ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_0 FOREIGN KEY (lesson_id) REFERENCES group_lesson (lesson_id) ON DELETE CASCADE;
ALTER TABLE ensamble ADD CONSTRAINT FK_ensamble_1 FOREIGN KEY (genre_id) REFERENCES genre (genre_id) ON DELETE CASCADE;


