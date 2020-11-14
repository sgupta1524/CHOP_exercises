insert into result_visualisation
select t1.id, t2.encounter_datetime, t1.gender, (strftime('%Y', 'now') - strftime('%Y', t1.birthdate))  - (strftime('%m-%d', 'now') < strftime('%m-%d', t1.birthdate) )  as Age,
t4.name
from  patient t1  
left join encounter t2 on t1.id = t2.patient_id 
 join encounter_diagnosis t3 on t3.encounter_id=t2.id 
left join diagnosis t4 on t4.id = t3.diagnosis_id 
order by t1.id;
