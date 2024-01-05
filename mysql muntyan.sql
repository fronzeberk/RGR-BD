SELECT `Student`.`full_name` as `Full name`, 
		`Student_groups`.`group_name` as `Group name`, 
		if (`Student`.`budget` = 1, "Бюджет", "Внебюджет") as `Budget`
FROM `Student`
JOIN `Student_groups` ON `Student_groups`.`id` = `Student`.`group_id`
ORDER BY `Student`.`full_name`;

SELECT `Student`.`full_name` as `Full name`,
		`Student_groups`.`group_name` as `Group name`,
        `Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Student_groups` ON `Student_groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Student_groups`.`direction_id`
WHERE `Student`.`full_name` LIKE "К%";

SELECT 
CONCAT(LEFT(`full_name`, LOCATE(' ', `full_name`)),
       CONCAT(LEFT(RIGHT(`full_name`, CHAR_LENGTH(`full_name`) - LOCATE(' ', `full_name`)), 1), '. '),
      CONCAT(LEFT(RIGHT(`full_name`, CHAR_LENGTH(`full_name`) - LOCATE(' ', `full_name`, (LOCATE(' ', `full_name`) + 1))), 1), '.')) 
as `Name`,
DAYOFMONTH(`Student`.`date_of_birth`) as `Day`,
CASE
	WHEN MONTHNAME(`Student`.`date_of_birth`) = "January" 
    	THEN "Январь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "February" 
    	THEN "Февраль"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "March" 
    	THEN "Март"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "April" 
    	THEN "Апрель"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "May" 
    	THEN "Май"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "June" 
    	THEN "Июнь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "July" 
    	THEN "Июль"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "August" 
    	THEN "Август"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "September" 
    	THEN "Сентябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "October" 
    	THEN "Октябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "November" 
    	THEN "Ноябрь"
    WHEN MONTHNAME(`Student`.`date_of_birth`) = "December" 
    	THEN "Декабрь"
 END AS 'Month',
`Student_groups`.`group_name` as `Group name`,
`Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Student_groups` ON `Student_groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Student_groups`.`direction_id`
ORDER BY MONTH(`Student`.`date_of_birth`); 
SELECT full_name, (YEAR(CURRENT_DATE()) - YEAR(date_of_birth)) as Age
FROM Student;
SELECT `full_name` as `Name`, `date_of_birth` as `Birthday`
FROM `Student`
WHERE MONTH(`Student`.`date_of_birth`) = MONTH(CURRENT_DATE());

SELECT COUNT(`Student`.`id`) as `Students number`, `Directions_of_study`.`direction_name` as `Direction name`
FROM `Student`
JOIN `Student_groups` ON `Student_groups`.`id` = `Student`.`group_id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Student_groups`.`direction_id`
GROUP BY `Directions_of_study`.`direction_name`;

SELECT 
	Student_groups.group_name, 
    Directions_of_study.direction_name, 
	COUNT(CASE WHEN budget = true THEN 1 ELSE 0 END) as number_of_buget 
FROM Student
	JOIN Student_groups ON Student_groups.id = Student.group_id
    JOIN Directions_of_study ON Directions_of_study.id = Student_groups.direction_id
GROUP BY Student_groups.id

SELECT `Disciplines`.`name`, `Student_groups`.`group_name`,`Teachers`.`name`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `DirectionDisciplineTeacher`.`direction_id`
JOIN `Student_groups` ON `Student_groups`.`direction_id` = `Directions_of_study`.`id`
JOIN `Teachers` ON `Teachers`.`id` = `DirectionDisciplineTeacher`.`teacher_id`

SELECT `Disciplines`.`name` as `disc_name`, COUNT(`Student`.`full_name`) as `s_num`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC 
LIMIT 1

SELECT `Teachers`.`name`, COUNT(`Student`.`id`) as `s_num`
FROM `Teachers`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`teacher_id` = `Teachers`.`id`
JOIn `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Student`.`id` = `Marks`.`student_id`
GROUP BY `Teachers`.`name`

SELECT `Disciplines`.`name` as `disc_name`, COUNT(IF(`Marks`.`mark` > 2, 1, NULL)) as `s_num`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC

SELECT `Disciplines`.`name` as `disc_name`, AVG(IF(`Marks`.`mark` > 2, `Marks`.`mark`, NULL)) as `s_avg`
FROM `Disciplines`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`discipline_id` = `Disciplines`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
JOIN `Student` ON `Marks`.`student_id` = `Student`.`id`
GROUP BY `Disciplines`.`name`
ORDER BY COUNT(`Student`.`full_name`) DESC

SELECT `Student_groups`.`group_name`, AVG(`Marks`.`mark`) as `average_mark`
FROM `Student_groups`
JOIN `Directions_of_study` ON `Directions_of_study`.`id` = `Student_groups`.`direction_id`
JOIN `DirectionDisciplineTeacher` ON `DirectionDisciplineTeacher`.`direction_id` = `Directions_of_study`.`id`
JOIN `Marks` ON `Marks`.`sub_disc_teach_id` = `DirectionDisciplineTeacher`.`id`
GROUP BY `Student_groups`.`group_name`
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
WHERE Disciplines.name = "Программирование дискретных структур" AND Attendance.presense = true
GROUP BY Attendance.presense;

SELECT COUNT(Attendance.id) as num_presense 
FROM Disciplines
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.discipline_id = Disciplines.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Disciplines.name = "Программирование дискретных структур" AND Attendance.presense = false
GROUP BY Attendance.presense;

SELECT COUNT(Attendance.id) as num_presense, DirectionDisciplineTeacher.id
FROM Teachers
JOIN DirectionDisciplineTeacher ON DirectionDisciplineTeacher.teacher_id = Teachers.id
JOIN Lessons_shedule ON Lessons_shedule.sub_disc_teach_id = DirectionDisciplineTeacher.id
JOIN Attendance ON Attendance.schedule_id = Lessons_shedule.id
WHERE Teachers.name = "Шиловский Дмитрий Михайлович" AND Attendance.presense = true
GROUP BY Lessons_shedule.sub_disc_teach_id;

DROP TRIGGER IF EXISTS student_insert;
DELIMITER //
CREATE TRIGGER student_insert BEFORE INSERT ON Student
FOR EACH ROW BEGIN 

IF (NOT (NEW.email REGEXP "[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+")) THEN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Некорректный email.';
END IF;
IF (NOT (NEW.full_name REGEXP "([A-Я]{1}[а-я]+[[:space:]]){2}[А-Я]{1}[а-я]+")) THEN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Некорректное имя.';
END IF;
IF (NOT (SELECT COUNT(Student_groups.id) FROM Student_groups WHERE Student_groups.id = NEW.group_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой группы не существует.';
END IF;
IF(DATE(NEW.date_of_birth) > DATE(CURDATE())) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Неправильная дата рождения.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS student_update;

DELIMITER //
CREATE TRIGGER student_update BEFORE UPDATE ON Student
FOR EACH ROW BEGIN 

IF (NOT(NEW.email REGEXP "[a-zA-Z0-9._-]+@[a-zA-Z0-9._-]+\.[a-zA-Z0-9_-]+")) THEN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Некорректный email.';
END IF;
IF (NOT(NEW.full_name REGEXP "([A-Я]{1}[а-я]+[[:space:]]){1}[А-Я]{1}[а-я]+")) THEN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Некорректное имя.';
END IF;
IF (NOT(SELECT COUNT(Student_groups.id) FROM Student_groups WHERE Student_groups.id = NEW.group_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой группы не существует. Сначала создайте такую группу';
END IF;
IF(DATE(NEW.date_of_birth) > DATE(CURDATE())) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Неправильная дата рождения.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS student_delete;

DELIMITER //
CREATE TRIGGER student_delete BEFORE DELETE ON Student
FOR EACH ROW BEGIN

DELETE FROM Phone_numbers WHERE Phone_numbers.student_id = OLD.id;
DELETE FROM Attendance WHERE Attendance.student_id = OLD.id;
DELETE FROM Marks WHERE student_id = OLD.id;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS Phone_numbers_insert;

DELIMITER //
CREATE TRIGGER Phone_numbers_insert BEFORE INSERT ON Phone_numbers
FOR EACH ROW BEGIN

IF (NOT(NEW.phone_number REGEXP "^[+]7(9[0-9]{9})$")) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Некорректный номер телефона.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS Phone_numbers_update;

DELIMITER //
CREATE TRIGGER Phone_numbers_update BEFORE UPDATE ON Phone_numbers
FOR EACH ROW BEGIN

IF (NOT(NEW.phone_number REGEXP "^[+]7(9[0-9]{9})$")) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Некорректный номер телефона.';
END IF;

END //
DELIMITER ;

DROP TRIGGER  IF EXISTS Student_groups_insert;
DELIMITER //
CREATE TRIGGER  Student_groups_insert BEFORE INSERT ON Student_groups
FOR EACH ROW BEGIN

IF (NOT(SELECT COUNT(Directions_of_study.id) FROM Directions_of_study WHERE Directions_of_study.id = NEW.direction_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого направления обучения не существует. Сначала создайте его.';
END IF;

END //
DELIMITER ;

DROP TRIGGER  IF EXISTS Student_groups_update;
DELIMITER //
CREATE TRIGGER Student_groups_update BEFORE UPDATE ON Student_groups
FOR EACH ROW BEGIN

IF (NOT(SELECT COUNT(Directions_of_study.id) FROM Directions_of_study WHERE Directions_of_study.id = NEW.direction_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого направления обучения не существует. Сначала создайте его.';
END IF;

END //
DELIMITER ;

DROP TRIGGER  IF EXISTS Student_groups_delete;
DELIMITER //
CREATE TRIGGER Student_groups_delete BEFORE DELETE ON Student_groups
FOR EACH ROW BEGIN

IF ((SELECT COUNT(Student.id) FROM Student WHERE Student.group_id = OLD.id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Вы пытаетесь удалить группу к которой привязан/ны студенты. Сначала перезакрепите их к другим группам.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS marks_insert;
DELIMITER //
CREATE TRIGGER marks_insert BEFORE INSERT ON Marks
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(Student.id) FROM Student WHERE Student.id = NEW.student_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Вы пытаетесь внести оценки для несуществующего студента.';
END IF;
IF(NOT(SELECT COUNT(DirectionDisciplineTeacher.id) FROM DirectionDisciplineTeacher WHERE DirectionDisciplineTeacher.id = NEW.sub_disc_teach_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Вы пытаетесь внести оценку по набору: направление, дисициплина, преподователь; которого не существует.';
END IF;
IF((NEW.mark < 0) OR (NEW.mark > 5)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Поставтье оценку в диапозне от 0 до 5.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS marks_update;
DELIMITER //
CREATE TRIGGER marks_update BEFORE UPDATE ON Marks
FOR EACH ROW BEGIN

IF((NEW.mark < 0) OR (NEW.mark > 5)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Поставтье оценку в диапозне от 0 до 5.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS DirectionDisciplineTeacher_insert;
DELIMITER //
CREATE TRIGGER DirectionDisciplineTeacher_insert BEFORE INSERT ON DirectionDisciplineTeacher
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(Directions_of_study.id) FROM Directions_of_study WHERE Directions_of_study.id = NEW.direction_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого направления обучения не существует.';
END IF;
IF(NOT(SELECT COUNT(Disciplines.id) FROM Disciplines WHERE Disciplines.id = NEW.discipline_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой дисциплины не существует.';
END IF;
IF(NOT(SELECT COUNT(Teachers.id) FROM Teachers WHERE Teachers.id = NEW.teacher_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого преподавателя не существует.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS DirectionDisciplineTeacher_update;
DELIMITER //
CREATE TRIGGER DirectionDisciplineTeacher_update BEFORE UPDATE ON DirectionDisciplineTeacher
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(Directions_of_study.id) FROM Directions_of_study WHERE Directions_of_study.id = NEW.direction_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого направления обучения не существует.';
END IF;
IF(NOT(SELECT COUNT(Disciplines.id) FROM Disciplines WHERE Disciplines.id = NEW.discipline_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой дисциплины не существует.';
END IF;
IF(NOT(SELECT COUNT(Teachers.id) FROM Teachers WHERE Teachers.id = NEW.teacher_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого преподавателя не существует.';
END IF;
END //
DELIMITER ;

DROP TRIGGER IF EXISTS Lessons_shedule_insert;
DELIMITER //
CREATE TRIGGER Lessons_shedule_insert BEFORE INSERT ON Lessons_shedule
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(DirectionDisciplineTeacher.id) FROM DirectionDisciplineTeacher WHERE DirectionDisciplineTeacher.id = NEW.sub_disc_teach_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого набора направления дисциплины и преподавателя не существует.';
END IF;
IF(NOT(SELECT COUNT(Pair_time.id) FROM Pair_time WHERE Pair_time.id = NEW.time_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой пары в расписании нет.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS Lessons_shedule_update;
DELIMITER //
CREATE TRIGGER Lessons_shedule_update BEFORE UPDATE ON Lessons_shedule
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(DirectionDisciplineTeacher.id) FROM DirectionDisciplineTeacher WHERE DirectionDisciplineTeacher.id = NEW.sub_disc_teach_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого набора направления дисциплины и преподавателя не существует.';
END IF;
IF(NOT(SELECT COUNT(Pair_time.id) FROM Pair_time WHERE Pair_time.id = NEW.time_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такой пары в расписании нет.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS Attendance_insert;
DELIMITER //
CREATE TRIGGER Attendance_insert BEFORE INSERT ON Attendance
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(Lessons_shedule.id) FROM Lessons_shedule WHERE Lessons_shedule.id = NEW.schedule_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Вы пытаетесь проставить посещаемость по паре, которой нет в расписании.';
END IF;
IF(NOT(SELECT COUNT(Student.id) FROM Student WHERE Student.id = NEW.student_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого студента нет.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS Attendance_update;
DELIMITER //
CREATE TRIGGER Attendance_update BEFORE UPDATE ON Attendance
FOR EACH ROW BEGIN

IF(NOT(SELECT COUNT(Lessons_shedule.id) FROM Lessons_shedule WHERE Lessons_shedule.id = NEW.schedule_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Вы пытаетесь проставить посещаемость по паре, которой нет в расписании.';
END IF;
IF(NOT(SELECT COUNT(Student.id) FROM Student WHERE Student.id = NEW.student_id)) THEN
    SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Такого студента нет.';
END IF;

END //
DELIMITER ;

DROP TRIGGER IF EXISTS teachers_insert;
DELIMITER //
CREATE TRIGGER teachers_insert BEFORE INSERT ON Teachers
FOR EACH ROW BEGIN

IF (NOT(NEW.name REGEXP "([A-Я]{1}[а-я]+[[:space:]]){2}[А-Я]{1}[а-я]+")) THEN
    SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Некорректное имя.';
END IF;

END //
DELIMITER ;
