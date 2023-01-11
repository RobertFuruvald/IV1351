
--number of lessons a certain month
CREATE VIEW lesson_count_type AS
SELECT
	COUNT(*) as total,
	COUNT(*) FILTER(WHERE price_id=1 or price_id=2 or price_id=3) as individual,
	COUNT(*) FILTER(WHERE price_id=4 or price_id=5 or price_id=6) as group,
	COUNT(*) FILTER(WHERE price_id=7) as ensamble
	FROM public.lesson
	WHERE EXTRACT(YEAR FROM lesson_date)=EXTRACT(YEAR FROM CURRENT_DATE)
	GROUP BY EXTRACT(MONTH FROM lesson_date);


-- number of lessons per instructor
CREATE VIEW lesson_count_instructor as
SELECT 
	public.person.first_name, public.person.last_name, public.instructor.instructor_id, 
	COUNT(*) FILTER (WHERE EXTRACT(MONTH FROM lesson_date) = EXTRACT(MONTH FROM CURRENT_DATE)) as numoflessons 
	FROM lesson
	INNER JOIN public.instructor ON  public.lesson.instructor_id = public.instructor.instructor_id 
	INNER JOIN public.person ON public.instructor.person_id = public.person.person_id
	GROUP BY person.first_name, person.last_name, instructor.instructor_id
	HAVING COUNT(*) FILTER (WHERE EXTRACT(MONTH FROM lesson_date) = EXTRACT(MONTH FROM CURRENT_DATE)) > 1
	ORDER BY numoflessons ASC;

--number of siblings
CREATE VIEW number_of_siblings AS
SELECT COUNT(student_id) as student_count, 
       CASE 
         WHEN siblings = 0 THEN 'No siblings'
         WHEN siblings = 1 THEN 'One sibling'
         WHEN siblings = 2 THEN 'Two siblings'
         ELSE 'More than two siblings'
       END as sibling_group
FROM (SELECT student_id, 
             (SELECT COUNT(*) FROM student_siblings WHERE student_id = s.student_id) as siblings 
      FROM student s) as students_with_siblings
GROUP BY siblings
ORDER BY siblings;

--ensambles for next week wiht available room left
CREATE MATERIALIZED VIEW lessons_next_week AS
SELECT lesson.lesson_date,genre.genre,group_lesson.max_students, COUNT(lesson_attendees.lesson_id) as enrolled,
  CASE 
    WHEN COUNT(student_id) = CAST(group_lesson.max_students as INT) THEN 'Full'
    WHEN COUNT(student_id) >= CAST(group_lesson.max_students AS INT) - 2 THEN '1-2 seats left'
    ELSE 'More seats left'
  END AS availability
	FROM public.lesson_attendees
	inner join lesson ON lesson_attendees.lesson_id = lesson.lesson_id
	inner JOIN group_lesson ON lesson_attendees.lesson_id = group_lesson.lesson_id
	inner join ensamble ON ensamble.lesson_id = lesson_attendees.lesson_id
	inner join genre ON genre.genre_id=ensamble.genre_id
	WHERE EXTRACT(WEEK FROM lesson.lesson_date)=EXTRACT(WEEK FROM CURRENT_DATE+7)
	GROUP BY genre.genre, group_lesson.max_students, lesson_attendees.lesson_id, lesson.lesson_date
	ORDER BY genre.genre ASC, lesson.lesson_date ASC;



