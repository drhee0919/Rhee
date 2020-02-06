
alter session set nls_language=american;
select last_name, hire_date, 
        to_char(next_day(add_months(hire_date, 6), 'MON'),
        'Day, "the " Ddspth "of" Month, YYYY.')   review
from employees;


--------sql 1999���� : natural join, join ~using, join ~on
Q. ����̸�, �μ���ȣ, �μ��̸��� ��ȸ ����� ���� 
conn hr/oracle
--employees 108rows
--departments 27rows
select a.last_name, a.department_id, b.department_name
from employees a, departments b 
where a.department_id = b.department_id; --106rows (�μ��� null in ����� ����) 

--natural join: oracle������ ������ �� ���̺��� ������ �̸��� �÷������� equi join�� ���� 
--������ �̸��� �÷��տ� ������ ���̺���̳� alias�� ������ �� ���� 
--������ �𵨸��� �߸��ؼ� �� ���̺��� ������ �Ӽ��� ���ؼ� �÷��̸��� �ٸ� ��쿡�� ������ ������� �ʴ´�. 
select a.lst_name, a.department_id, b.department_name
from employees a natural join departments b; --error, ������ �̸��� �÷��տ� ������ ���̺���̳� alias�� ������ �� ���� 

select a.last_name, department_id, b.department_name
from employees a natural join departments b; ---32��

desc employees
desc departments --�� �����Ϳ��� department_ID�� manager_ID�÷��� ��ġ�� ���� Ȯ�� 

-- join ~using: ������ �� �� ���̺��� ������ �̸��� �ϳ��� �÷����θ� ���� ���� 
select a.last_name, a.department_id, b.department_name
from employees a join departments b using(a.department_id); --error 

--���ĽẸ��
select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id); --106rows

select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id)
where a.department_id > 50 ; --error

--���ľ���
select  a.last_name, department_id, b.department_name
from employees a   join departments b  using (department_id)
where department_id > 50 ; --51���� 


-------natural ���� �ǽ��� ���� scott ���� ���� -----
------ join���� �̾ ----------------------------
Q. ����̸�, �ҼӺμ� �̸�, �ҼӺμ��� ��ġ(���ø�)�� ��ȸ ����ϴ� SQL(last_name, department_name, city) 
conn hr/oracle
desc employees
desc departments
desc locations






select rpad(concat(last_name, ' '), length(last_name) +1 + trunc(salary/1000), '*')
EMPLOYEES_AND_THEIR_SALARIES
from employees;
(�Ǵ�)
select concat(last_name, rpad(' ', trunc(salary/1000)+1, '*'))
      EMPLOYEES_AND_THEIR_SALARIES
from employees;




select job_id , decode(job_id, 'AD_PRES', 'A',
			   'ST_MAN', 'B',
			   'IT_PROG', 'C',
			   'SA_REP', 'D',
			  'ST_CLERK', 'E', '0') grade
From employees;
--(�Ǵ�)

Select job_id, case job_id when 'AD_PRES' then 'A'
                           when 'ST_MAN' then 'B'
                           when 'IT_PROG' then 'C'
                           when 'SA_REP' then 'D'
                           when 'ST_CLERK' then 'E'
                           else '0' end grade
from employees;

select max(salary) "Maximum", min(salary) "Minimum"
        ,sum(salary)  "Sum", avg(salary) "Average"
from employees;


select job_id, max(salary) "Maximum", min(salary) "Minimum"
      ,sum(salary) "Sum", avg(salary) "Average"
from employees;
--group by job_id;


select job_id, count(*)
from employees
group by job_id;



select job_id, count(job_id) "count(*)"
from employees
group by job_id;




select count(distinct manager_id) "Number of Manager" --�ߺ� ��� �ȵǰ� ���� 
from employees;


select max(salary)-min(salary) difference
from employees;

select manager_id, min(salary) --5
from employees --1
where manager_id is not null --2 
group by manager_id --3
having min(salary) > 6000 --4
order by 2 desc; --6





select count(*) total,
      sum(decode(to_char(hire_date, 'YYYY'), '2002', 1)) "2002"
from employees; --TOTAL 2002
                --  107    7


select count(*) total, 
      count(case to_char(hire_date, 'YYYY') when '2002' then 1 end)
"2002"
from employees; --TOTAL 2002
                --  107    7


select count(*) total,
count(decode(to_char(hire_date, 'YYYY'), '2002', 1)) "2002",
count(decode(to_char(hire_date, 'YYYY'), '2003', 1)) "2003",
count(decode(to_char(hire_date, 'YYYY'), '2004', 1)) "2004",
count(decode(to_char(hire_date, 'YYYY'), '2005', 1)) "2005"
from employees; 


select job_id,
       sum(decode(department_id, 20, salary)) "Dept 20",
       sum(decode(department_id, 50, salary)) "Dept 50",
       sum(decode(department_id, 80, salary)) "Dept 80",
       sum(decode(department_id, 90, salary)) "Dept 90",
       sum(salary) "Total"
from employees
grou pby job_id;