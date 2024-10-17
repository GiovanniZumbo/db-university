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