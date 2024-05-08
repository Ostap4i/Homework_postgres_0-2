------------------------------------------------------------------- Request 0 -------------------------------------------------------------------

-- Resquest 1
-- Вивести кількість палат, місткість яких більша за 10.

-- SELECT *
-- FROM wards
-- WHERE wards.places > 10;




-- Resquest 2
-- Вивести назви корпусів та кількість палат у кожному з них.

-- SELECT ds.building AS building, COUNT(w.id)
-- FROM wards AS w
-- JOIN departments AS ds
-- ON w.department_id = ds.id
-- GROUP BY building;





-- Resquest 3
-- Вивести назви відділень та кількість палат у кожному з них.

-- SELECT ds.name AS department, SUM(w.places) AS places
-- FROM wards AS w
-- JOIN departments AS ds
-- ON w.department_id = ds.id
-- GROUP BY department;





-- Resquest 4
-- Вивести назви відділень та сумарну надбавку лікарів у кожному з них.

-- SELECT des.name AS department, SUM(dos.premium) as sum_premium
-- FROM departments AS des
-- JOIN wards as w
-- ON w.department_id = des.id
-- JOIN doctors_examinations as de
-- ON de.ward_id = w.id
-- JOIN doctors as dos
-- ON de.doctor_id = dos.id
-- GROUP BY department;




-- Resquest 5
-- Вивести назви відділень, у яких проводять обстеження 5 та більше лікарів.

-- SELECT des.name AS department_name, COUNT(dos.id) AS ds_count
-- FROM doctors_examinations AS d_e
-- JOIN doctors AS dos
-- ON d_e.doctor_id = dos.id
-- JOIN wards AS ws
-- ON d_e.ward_id = ws.id
-- JOIN departments AS des
-- ON ws.department_id = des.id
-- GROUP BY department_name;





-- Resquest 6
-- Вивести кількість лікарів та їх сумарну зарплату (сума ставки та надбавки).

-- SELECT d_e.doctor_id, dos.salary, dos.premium
-- FROM doctors_examinations AS d_e
-- JOIN doctors as dos
-- ON d_e.doctor_id = dos.id;

-- SELECT COUNT(d_e.id) as dos_count, SUM(dos.salary + dos.premium)
-- FROM doctors_examinations AS d_e
-- JOIN doctors as dos
-- ON d_e.doctor_id = dos.id
-- GROUP BY GROUPING SETS (());




-- Resquest 7
-- Вивести середню зарплату (сума ставки та надбавки) лікарів.


-- Resquest 8
-- Вивести назви палат із мінімальною місткістю.   

-- SELECT MIN(ws.places)
-- FROM wards as ws
-- GROUP BY GROUPING SETS (());
   
   
   
   
-- Resquest 9
-- Вивести в яких із корпусів 1, 6, 7 та 8, сумарна кількість
-- місць у палатах перевищує 100. При цьому враховувати
-- лише палати з кількістю місць більше 10.






------------------------------------------------------------------- Request 1 -------------------------------------------------------------------

-- Request 1
-- Вивести назви відділень, що знаходяться у тому ж корпусі, що й відділення “Cardiology”.

-- SELECT *
-- FROM departments
-- WHERE departments.building = (SELECT building FROM departments WHERE name = 'Cardiology')
-- AND name <> 'Cardiology';




-- Request 2
-- Вивести назви відділень, що знаходяться у тому ж корпусі, що й відділення “Gastroenterology” та “General Surgery”.

-- SELECT *
-- FROM departments 
-- WHERE departments.building = (SELECT building FROM departments WHERE name = 'Gastroenterology')
-- AND name <> 'Gastroenterology'
-- OR departments.building = (SELECT building FROM departments WHERE name = 'General Surgery')
-- AND name <> 'General Surgery';




-- Request 3
-- Вивести назву відділення, яке отримало найменше пожертвувань.

-- SELECT *
-- FROM departments
-- WHERE id = (SELECT department_id 
 -- FROM donations
 -- GROUP BY department_id
 -- ORDER BY COUNT(*) LIMIT 1);




-- Request 4
-- Вивести прізвища лікарів, ставка яких більша, ніж у лікаря “Thomas Gerada”.

-- SELECT *
-- FROM doctors
-- WHERE salary > (SELECT salary
 -- FROM doctors
 -- WHERE name = 'Thomas' AND surname = 'Gerada');




-- Request 5
-- Вивести назви палат, місткість яких більша, ніж середня місткість у палатах відділення “Microbiology”.

-- SELECT w.name AS ward, w.places, des.name AS department
-- FROM wards AS w
-- JOIN departments AS des
-- ON w.department_id = des.id
-- WHERE w.places > (SELECT AVG(w.places)
 -- FROM wards AS w
 -- JOIN departments AS des
 -- ON w.department_id = des.id
 -- WHERE des.name = 'Microbiology'
 -- );




-- Request 6
-- Вивести повні імена лікарів, зарплати яких (сума ставки та надбавки) перевищують більш ніж на 100 зарплату лікаря Anthony Davis.

-- SELECT *
-- FROM doctors
-- WHERE (salary + premium) > (
 -- SELECT (salary + premium)
 -- FROM doctors
 -- WHERE name = 'Anthony' AND surname = 'Davis'
 -- );




-- Request 7
-- Вивести назви відділень, у яких проводить обстеження лікар Joshua Bell.

-- SELECT CONCAT(dos.name, ' ', dos.surname) as full_name, w.id, des.name 
-- FROM doctors_examinations AS d_e
-- JOIN doctors as dos
 -- ON d_e.doctor_id = dos.id
-- JOIN wards as w
 -- ON d_e.ward_id = w.id
-- JOIN departments AS des 
 -- ON w.department_id = des.id
-- WHERE dos.name = 'Joshua' AND dos.surname = 'Bell'
-- ORDER BY w.id;




-- Request 8
-- Вивести назви спонсорів, які не робили пожертвування відділенням “Neurology” та “Oncology”.

-- SELECT sp.name, ds.amount, ds.don_date
-- FROM donations AS ds
-- JOIN sponsors AS sp
-- ON ds.sponsor_id = sp.id
-- WHERE ds.department_id <> (SELECT id 
 -- FROM departments
 -- WHERE name = 'Neurology' OR name = 'Oncology'
 -- LIMIT 1)
-- ORDER BY sp.name;




-- Request 9
-- Вивести прізвища лікарів, які проводять обстеження у період з 12:00 до 15:00.
-- Вивести обстеження

-- SELECT DISTINCT 
  -- dos.surname, 
  -- d_e.start_time,
  -- d_e.end_time
-- FROM doctors_examinations AS d_e
-- JOIN doctors AS dos
  -- ON d_e.doctor_id = dos.id
-- JOIN examinations AS exs
  -- ON d_e.examination_id = exs.id
-- WHERE d_e.start_time <= '12:00' AND d_e.end_time >= '15:00'
-- ORDER BY d_e.start_time;





------------------------------------------------------------------- Request 2 -------------------------------------------------------------------


-- Request 1
-- Вивести назви та місткості палат, розташованих у 5-му корпусі, місткістю 5 і більше місць,
-- якщо в цьому корпусі є хоча б одна палата місткістю понад 15 місць.

-- SELECT w.name, w.places 
-- FROM wards AS w
-- JOIN departments AS des
-- ON w.department_id = des.id
-- WHERE des.building = 5 
  -- AND w.places >= 5
  -- AND EXISTS (SELECT 1 
    -- FROM wards AS w
	-- JOIN departments AS des
	-- ON w.department_id = des.id
	-- WHERE des.building = 5	
	-- AND w.places > 15);



-- Request 2
-- Вивести назви відділень, у яких проводилося хоча б одне обстеження за останній тиждень.

-- SELECT DISTINCT des.name 
-- FROM doctors_examinations AS d_e
-- JOIN wards AS w
-- ON d_e.ward_id = w.id
-- JOIN departments AS des
-- ON w.department_id = des.id
-- WHERE (NOW() - d_e.ex_date) < '7 days';



-- Request 3
-- Вивести назви захворювань, для яких не проводяться обстеження.

-- SELECT dis.name
-- FROM diseases AS dis
-- WHERE dis.id NOT IN (
   -- SELECT dis.id
   -- FROM doctors_examinations AS d_e
   -- JOIN diseases AS dis
    -- ON d_e.disease_id = dis.id
   -- GROUP BY dis.id);




-- Request 4
-- Вивести повні імена лікарів, які не проводять обстеження.

-- SELECT CONCAT(ds.name, ' ', ds.surname) AS full_name
-- FROM doctors AS ds
-- WHERE ds.id NOT IN (
   -- SELECT ds.id
   -- FROM doctors_examinations AS d_e
   -- JOIN doctors AS ds
    -- ON d_e.doctor_id = ds.id
   -- GROUP BY ds.id);





-- Request 5
-- Вивести назви відділень, у яких не проводяться обстеження.

-- SELECT des.name AS dep_name
-- FROM departments AS des
-- WHERE des.id NOT IN (
   -- SELECT des.id
   -- FROM doctors_examinations AS d_e
   -- JOIN wards AS ws
    -- ON d_e.ward_id = ws.id
   -- JOIN departments AS des
	-- ON ws.department_id = des.id
   -- GROUP BY des.id);



-- Request 6
-- Вивести прізвища лікарів, які є інтернами.

-- SELECT ds.name AS doctor_name
-- FROM doctors AS ds
-- WHERE ds.id IN (
   -- SELECT ins.doctor_id
   -- FROM interns AS ins
   -- JOIN doctors AS ds
    -- ON ins.doctor_id = ds.id);



-- Request 7
-- Вивести прізвища інтернів, ставки яких більші, ніж ставка хоча б одного з лікарів.

-- SELECT ds.surname AS intern_surname
-- FROM doctors as ds
-- WHERE ds.id IN (
   -- SELECT ins.doctor_id
   -- FROM interns AS ins
   -- JOIN doctors AS ds
    -- ON ins.doctor_id = ds.id)
 -- AND ds.salary > (
   -- SELECT MIN(salary)
   -- FROM doctors);
   
-- SELECT name, salary
-- FROM doctors;
   
   



-- Request 8
-- Вивести назви палат, чия місткість більша, ніж місткість
-- кожної палати, що знаходиться в 3-му корпусі.

-- SELECT ws.name, ws.places
-- FROM wards AS ws
-- WHERE ws.id NOT IN (
   -- SELECT ws.id
   -- FROM wards AS ws
   -- JOIN departments AS des
    -- ON ws.department_id = des.id
   -- WHERE des.building = 3)
 -- AND ws.places > (
   -- SELECT MAX(ws.places)
   -- FROM wards AS ws
   -- JOIN departments AS des
    -- ON ws.department_id = des.id
   -- WHERE des.building = 3
   -- );

-- SELECT ws.name, ws.places, des.name, des.building
-- FROM wards AS ws
-- JOIN departments AS des
 -- ON ws.department_id = des.id
-- ORDER BY ws.places desc;



-- Request 9
-- Вивести прізвища лікарів, які проводять обстеження у відділеннях “Ophthalmology” та “Physiotherapy”.




-- Request 10
-- Вивести назви відділень, у яких працюють інтерни та професори.




-- Request 11
-- Вивести повні імена лікарів та відділення у яких вони проводять обстеження,
-- якщо відділення має фонд фінансування понад 20000.
