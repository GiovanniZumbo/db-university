--* Group by -- 

-- 1. Contare quanti iscritti ci sono stati ogni anno

SELECT COUNT(`id`), YEAR(`enrolment_date`) as `anno_di_immatricolazione`
FROM `students`
GROUP BY `anno_di_immatricolazione`;

-- 2. Contare gli insegnanti che hanno l'ufficio nello stesso edificio

SELECT COUNT(`id`), `office_address`
FROM `teachers`
GROUP BY `office_address`;

-- 3. Calcolare la media dei voti di ogni appello d'esame

SELECT AVG(`vote`) as `media_voti`, `exam_id` as `appello_esame`
FROM `exam_student`
GROUP BY `appello_esame`;

-- 4. Contare quanti corsi di laurea ci sono per ogni dipartimento

SELECT COUNT(`id`) as `id_corso_laurea`, `department_id` as `id_dipartimento`
FROM `degrees`
GROUP BY `id_dipartimento`;


--# Join --

-- 1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia

SELECT * 
FROM `students`
INNER JOIN `degrees`
ON `degrees`.`id` = `students`.`degree_id`
WHERE `degrees`.`name` = "Corso di Laurea in Economia";

-- 2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze

SELECT * 
FROM `degrees`
INNER JOIN `departments`
ON `departments`.`id` = `degrees`.`department_id`
WHERE `departments`.`name` = "Dipartimento di Neuroscienze" AND `degrees`.`level` = "magistrale";

-- 3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)

SELECT * 
FROM `course_teacher`
WHERE `teacher_id`= 44; 

-- oppure 

SELECT `courses`.`name` as `nome_corso`, `teachers`.`name` as `nome_insegnante`, `teachers`.`surname` as `cognome_insegnante` 
FROM `courses`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `teacher_id`= 44;

-- 4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
-- sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e nome

SELECT `students`.`name` as `nome`, `students`.`surname` as `cognome`, `degrees`.`name` `corso_di_laurea`,
`departments`.`name` as `dipartimento`
FROM `students`
INNER JOIN `degrees` ON `degrees`.`id` = `students`.`degree_id`
INNER JOIN `departments` ON `departments`.`id` = `degrees`.`department_id`
ORDER BY `cognome`;


-- 5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti

SELECT 
`degrees`.`name` as `nome_corso_laurea`,
`courses`.`name` as `nome_corso`,
`teachers`.`name` as `nome_insegnante`,
`teachers`.`surname` as `cognome_insegnante`

FROM `degrees`
JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
ORDER BY `degrees`.`name`;

-- 6. Selezionare tutti i docenti che insegnano nel Dipartimento di Matematica (54)

SELECT DISTINCT
`departments`.`name` as `dipartimento`,
`teachers`.`name` as `nome_insegnante`,
`teachers`.`surname` as `cognome_insegnante`

FROM `departments`
JOIN `degrees` ON `departments`.`id` = `degrees`.`department_id`
JOIN `courses` ON `degrees`.`id` = `courses`.`degree_id`
JOIN `course_teacher` ON `courses`.`id` = `course_teacher`.`course_id`
JOIN `teachers` ON `teachers`.`id` = `course_teacher`.`teacher_id`
WHERE `departments`.`name` = "Dipartimento di Matematica"
-- ORDER BY `cognome_insegnante`;

-- 7. BONUS: Selezionare per ogni studente il numero di tentativi sostenuti per ogni esame, 
-- stampando anche il voto massimo. Successivamente, filtrare i tentativi con voto minimo 18.

