SELECT Student.full_name AS Full_name, 
		Groups.group_name AS Group_name, 
		CASE
			WHEN Student.budget = TRUE THEN 'Бюджет'
			ELSE 'Внебюджет'
		END AS Budget
FROM Student
JOIN Groups ON Groups.id = Student.group_id
ORDER BY Student.full_name;
 
SELECT Student.full_name as Full name,
		Groups.group_name as Group name,
        Directions_of_study.direction_name as Direction name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
WHERE Student.full_name LIKE 'К%';

SELECT CONCAT(LEFT(full_name, POSITION(' ' IN full_name)),
       	CONCAT(LEFT(RIGHT(full_name, (CHAR_LENGTH(full_name) - POSITION(' ' IN full_name))), 1), '. '),
		CONCAT(LEFT(RIGHT(full_name, (CHAR_LENGTH(full_name) - POSITION(' ' IN substr(full_name, (POSITION(' ' IN full_name) + 1))))), 1), '.'))
as name,
EXTRACT(DAY FROM Student.date_of_birth) as day,
CASE
	WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 1
    	THEN 'Январь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 2
    	THEN 'Февраль'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 3 
    	THEN 'Март'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 4 
    	THEN 'Апрель'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 5
    	THEN 'Май'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 6
    	THEN 'Июнь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 7 
    	THEN 'Июль'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 8 
    	THEN 'Август'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 9
    	THEN 'Сентябрь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 10
    	THEN 'Октябрь'
    WHEN EXTRACT(MONTH FROM Student.date_of_birth) = 11
    	THEN 'Ноябрь'
    ELSE 'Декабрь'
 END AS Month,
Groups.group_name as Group_name,
Directions_of_study.direction_name as Direction_name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
ORDER BY EXTRACT(MONTH FROM Student.date_of_birth); 

SELECT full_name, (EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM date_of_birth)) as Age
FROM student;

SELECT full_name as Name, date_of_birth as Birthday
FROM Student
WHERE EXTRACT(MONTH FROM Student.date_of_birth) = EXTRACT(MONTH FROM CURRENT_DATE);

SELECT COUNT(Student.id) as Students_number, Directions_of_study.direction_name as Direction_name
FROM Student
JOIN Groups ON Groups.id = Student.group_id
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Directions_of_study.direction_name;

SELECT 
	Groups.group_name, 
    Directions_of_study.direction_name, 
	COUNT(CASE WHEN budget = true THEN 1 ELSE 0 END) as number_of_buget 
FROM Student
	JOIN Groups ON Groups.id = Student.group_id
    JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
GROUP BY Groups.id, directions_of_study.id

SELECT Disciplines.name, Groups.group_name,Teachers.name
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Directions_of_study ON Directions_of_study.id = DirectionDisciplineTeacher.direction_id
JOIN Groups ON Groups.direction_id = Directions_of_study.id
JOIN Teachers ON Teachers.id = DirectionDisciplineTeacher.teacher_id

SELECT Disciplines.name as disc_name, COUNT(Student.full_name) as s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC 
LIMIT 1

SELECT Teachers.name, COUNT(Student.id) as s_num
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIn Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Student.id = Marks.student_id
GROUP BY Teachers.name

SELECT Disciplines.name as disc_name, COUNT(
                                           
  CASE 
  	WHEN Marks.mark > 2 THEN 1
                                           ELSE 0 END) as s_num
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Student ON Marks.student_id = Student.id
GROUP BY Disciplines.name
ORDER BY COUNT(Student.full_name) DESC

SELECT Groups.group_name, AVG(Marks.mark) as average_mark
FROM Groups
JOIN Directions_of_study ON Directions_of_study.id = Groups.direction_id
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.direction_id = Directions_of_study.id
JOIN Marks ON Marks.sub_disc_teach_id = DirectionDisciplineTeacher.id
GROUP BY Groups.group_name
LIMIT 1

SELECT Student.full_name, AVG(Marks.mark)
FROM Student
JOIN Marks ON Marks.student_id = Student.id
GROUP BY Student.full_name
HAVING AVG(Marks.mark) = 5.0;

SELECT Student.full_name
FROM Student
JOIN Marks ON Marks.student_id = Student.id
WHERE Marks.mark = 2
GROUP BY Student.full_name
HAVING COUNT(*)>1

SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = 'Программирование дискретных структур' AND Attendance.presense = true
GROUP BY Attendance.presense;

SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = 'Программирование дискретных структур' AND Attendance.presense = false
GROUP BY Attendance.presense;

SELECT COUNT(Attendance.id) as num_presense, DirectionDisciplineTeacher.id
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Teachers.name = 'Шиловский Дмитрий Михайлович' AND Attendance.presense = true
GROUP BY Lessons_shedule.sub_disc_teach_id;
