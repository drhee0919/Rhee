select phone_number
from employees;

SELECT
  REGEXP_REPLACE(phone_number,
                 '([[:digit:]]{3})\.([[:digit:]]{3})\.([[:digit:]]{4})',
                 '(\1) \2-\3') "REGEXP_REPLACE"
  FROM employees
  ORDER BY "REGEXP_REPLACE"; -- ������ ������ employees�� ��ȭ��ȣ ��� 
  
SELECT country_name,
  REGEXP_REPLACE(country_name, '(.)', '\1 ') "REGEXP_REPLACE"
  FROM countries;  -- 
  
SELECT
  REGEXP_SUBSTR('500 Oracle Parkway, Redwood Shores, CA',
                ',[^,]+,') "REGEXPR_SUBSTR"
  FROM DUAL; --Redwood Shores

SELECT REGEXP_COUNT('123123123123123', '(12)3', 1, 'i') REGEXP_COUNT
   FROM DUAL; -- 5
SELECT REGEXP_COUNT('123123153123123', '(12)3', 1, 'i') REGEXP_COUNT
   FROM DUAL; -- 4


SELECT
  REGEXP_INSTR('500 Oracle Parkway, Redwood Shores, CA',
               '[^ ]+', 1, 6) "REGEXP_INSTR"
  FROM DUAL;



-------�̻� �����Լ� ���� �� ----
-------���� �����Լ� -----------

select round(1234.567, 2), round(1234.567, 0), round(1234.567, -2)
from dual; --1234.57 1235 1200

select trunc(1234.567, 2), trunc(1234.567), trunc(1234.567, -2)
from dual; -- 1234.56 1234 1200

select mod(100, 35), remainder(100, 35)
from dual; -- 30 -5

select ceil(34.56), floor(34.56), power(2, 10)
from dual; --35 34 1024


------�̻� �����Լ� --------------------
------�����Լ� ������ scott���� ���� -----



---�׷��Լ� ���� ---
Q. employees���̺��� department_id, salary�÷�..
�μ��� �޿��� ����� ����� ������������ ����ϵ��� SQL �ۼ� 
select department_id, avg(salary)
from employees
group by department_id
order by 2 desc;

Q. employees ���̺��� department_id, salary, manager_id �÷�...
�����ڰ� �ִ� ������� �����ڷ� �׷����ؼ� ������ �����ڷκ��� ������ �޴� 
�ǰ����� �� �ּ� �޿��� 6000�̸��� ����� �����ڿ� �ּұ޿��� ��� �ϴ� SQL �ۼ� 
select  manager_id, min(salary)           ---5
from employees                              ----1
where manager_id is not null             -----2
group by manager_id                       ----3
having min(salary) < 6000                 ----4
order by 2 desc;                            ---6





#################set operator(���� ������)#####################
������
������
������
conn hr/oracle
desc employees
select count(*) from employees;  --���� �ٹ��ϴ� ������� ����(107)

desc job_history
select count(*) from employees;--������� ���ſ� �ٹ� �̷� ����(10)

Q> ������� ���� �ٹ������� ���� �ٹ� ������ ��� ����ϴ� SQL �ۼ�
select employee_id, department_id, job_id
from employees
union all
select employee_id, department_id, job_id
from job_history; ---(117)

Q> ������� ���� �ٹ������� ���� �ٹ� ������ ��� ����ϵ�
������ ������ �μ������� �ٹ��� ��� �ѹ��� ����ϴ�  SQL �ۼ�
select employee_id, department_id, job_id
from employees
union 
select employee_id, department_id, job_id
from job_history; ---()

Q> ������� ���� ������ ���ſ� ������ ������ �����ߴ� �����ȣ, ������ ����ϴ� SQL �ۼ�
select employee_id, job_id 
from employees 
intersect 
select employee_id, job_id
from job_history;

Q> ������߿��� �Ի��� ���� �ѹ��� �μ��� ������ ���������� ���� 
�����ȣ��  ����ϴ� SQL �ۼ�
select employee_id
from employees
minus 
select employee_id 
from job_history


--set�����ڸ� ����ϴ� select�������� set�����ڿ� �Բ� ���Ǵ� select���� ������ select�������� ���� �����մϴ�.
select employee_id,   job_id
from employees
order by job_id desc
intersect
select employee_id,   job_id
from job_history;  --error

select employee_id, job_id
from employees
intersect 
select employee_id, job_id
from job_history
order by job_id desc;

Q> ��ü ����� �޿� ��հ�
     �μ��� ������� �޿� ��հ�
      �μ��� ������ ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�
      
select to_number(null), to_char(null),avg(salary) --select�� �ȸ´� �κ��� ������ null�� ä���ֱ� 
from employees
union all --�ߺ��� ���� �����Ƿ� ���� �ּ�ȭ 
select department_id, to_char(null), avg(salary)
from employees
group by department_id
union all
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

--�Ǵ� (rollup���� �����ϰ� �ٲپ��)
select department_id, job_id, avg(salary)
from employees
group by rollup(department_id, job_id); --department_id job_id avg(salary)
--(��Ģ)--
select ~
from ~
group by rollup (A,B)
�� group by A,B
�� group by A
�� group by ()

select ~
from ~
group by rollup (A,B,C)
�� group by A,B,C
�� group by A,B
�� group by A
�� group by ()


-- ����� 4�� �϶� 
Q> ��ü ����� �޿� ��հ�
     �μ��� ������� �޿� ��հ�
     ������ ������� �޿� ��հ�
      �μ��� ������ ������� �޿� ����� ���� ��� �������� �����ϴ� SQL�� �ۼ��Ͻÿ�

select to_number(null), to_char(null),avg(salary)
from employees
union all
select department_id, to_char(null), avg(salary)
from employees
group by department_id
union all
select to_number(null), job_id, avg(salary)
from employees
group by  job_id
union all
select department_id, job_id, avg(salary)
from employees
group by department_id, job_id;

-- cube �� ��ü 
select department_id, job_id, avg(salary)
from employees
group by cube(department_id, job_id);


Q. ��ü ����� �޿� ��հ� 
    �μ��� ������� �޿� ��հ� 
    �����ڿ� ������ ������� �޿� ��հ� 
    �μ��� �����ں� ������� �޿� ����� ���� ��� �������� �����ϴ� SQL �ۼ� 
select department_id, job_id, avg(salary)
from employees
group by grouping sets((department_id, manager_id, job_id), 
                       (department_id),
                       (department_id, manager_id), 
                       (department_id, job_id));