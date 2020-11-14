------------------------------------------------------------------
--total visists  group by age-group, gender (1 person might have multiple encounter_diag)
-----------------------------------------------------------------

create table stacked_new1  as
select  t2.grp, sum(t2.cnt) cnt, t2.gender from(
select t1.gender, count(*) cnt, (strftime('%Y', 'now') - strftime('%Y', t1.birthdate))  - (strftime('%m-%d', 'now') < strftime('%m-%d', t1.birthdate) ) as age,
((strftime('%Y', 'now') - strftime('%Y', t1.birthdate)) -  (strftime('%m-%d', 'now') < strftime('%m-%d', t1.birthdate) ) -1)/5+1  as grp
   from patient t1
   
   left join encounter t4 on t1.id = t4.patient_id
   join encounter_diagnosis t3 on t3.encounter_id=t4.id
   
   group by t1.gender, (strftime('%Y', 'now') - strftime('%Y', t1.birthdate))  - (strftime('%m-%d', 'now') < strftime('%m-%d', t1.birthdate) ) ) as t2
   group by t2.grp, t2.gender order by gender,age;
   -----------------------------------------------------

        create table stacked_new2 as

  select t3.group_name, t3.male_count, ifnull(t4.female_count,0) as female_count from
   (select (((t1.grp-1)*5+1) || '-' || ((t1.grp)*5)) as group_name, t1.cnt as male_count from stacked_new1 t1 where gender='M') t3
 

    left join
  (select (((t2.grp-1)*5+1) || '-' || ((t2.grp)*5)) as group_name, t2.cnt as female_count from stacked_new1 t2 where gender='F') t4
on t3.group_name = t4.group_name;

==============================================================================
