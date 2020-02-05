--ascii(127�� ����)
--ebcdic(256�� ����)
select chr(48), chr(65), chr(97), chr(13)
from dual;

select upper('hello'), lower('HELLO'), initcap('HELLO SQL')
from dual; -- HELLO hello Hello Sql

select concat('hello' ,  ' SQL')
from dual;  -- hello SQL

select substr('hello world', 6), substr('hello world', 3,2), substr('hello world', -5,3)
from dual; -- world 11 wor

select replace('Jack and Jue', 'J', 'Bl')
from dual; --Black and Blue 

select instr('hello world', 'o'), instr('hello world', 'o', 6), instr('hello world', 'o', 1,2), instr('hello world', 'o', -7)
from dual; --5 8 8 5


select length('korea'), length('���ѹα�'),
       lengthb('korea'), lengthb('���ѹα�')
from dual;  

select translate('Jack and Jue', 'acJ', '137')
from dual; --713k 1nd 7ue

select sal, lpad(sal, 10, '$'), rpad(sal, 10, '$')
from emp;


-- Q. emp���̺�κ��� 82�⵵�� �Ի��� ��� ��ȸ 
select * 
from emp 
where HIREDATE like '87%';

--�Ǵ� 
select *
from emp 
where '87' = substr(hiredate, 1, 2);

-- Q. emp���̺�κ��� ����� Ȧ���� ��� ��ȸ 
select ename 
from emp 
where 1 = mod(empno, 2);

-------------�̻� �����Լ� ���� -----------
-------------���� ��¥�Լ� �Ế�ô� --------
select ename, hiredate, months_between(sysdate, hiredate)
from emp;

select ename, hiredate, trunc(months_between(sysdate, hiredate))
from emp;

select  trunc(to_date('2021/7/16'), 'Month') 
        , trunc(to_date('2021/7/14'), 'Month') 
        , trunc(to_date('2021/7/16'), 'Year') 
        , trunc(to_date('2021/6/16'), 'Month') 
from dual;   --round�Լ��� ��¥ Ÿ�Կ� ���� ���� �Լ�(������) 


select sysdate, add_months(sysdate, 3)
from dual; --20/02/05 20/05/05

alter session set nls_date_format = 'RR/MM/DD HH24:MI:SS'; -- ������ȯ(session ����)
select sysdate, current_date, current_timestamp, sessiontimezone
from dual;
--sysdate�Լ��� �ý���(�ü��)�� ���� �ð��� dateŸ�԰����� ��ȯ
--current_date �Լ��� DB���� client ������ timezone�������  dateŸ�԰����� ��ȯ
alter session set time_zone='-9:00'; -- ǥ��timestamp ���� 9�ð� ���� ������ �ð� ǥ��  

select sysdate, current_date, current_timestamp, sessiontimezone
from dual;

select dbtimezone from dual; --����
alter session set nls_date_format = 'RR/MM/DD'; --���� 

select last_day(sysdate), last_day(to_date('1900/02/03'))
      ,last_day(to_date('2000/02/03')),last_day(to_date('1996/02/03'))
from dual; --2���� last dayȰ��, ����Ȯ�� 

select  next_day(sysdate, '��'), next_day(sysdate, '��')
from dual; --20/02/07 20/02/10

select hiredate, extract( month from hiredate)
from emp; --������ HIREDATE���� �������� �� ���� 

select hiredate, extract( day from hiredate)
from emp; --������ HIREDATE���� �������� �� ���� 

--��¥ �ð� ���� �÷� Ÿ��
--timestamp with timezone
--interval year to month
--interval day to second


select hiredate, hiredate + TO_DSINTERVAL('100 00:00:00') -- day to second 
        , hiredate + to_yminterval('01-02') --year to month 
from emp;

---------------------�̻� ��¥�Լ�----------------------------------
---------------------���� ����ȯ �Լ��� ����غ��� -------------------

select sysdate, to_char(sysdate, 'YYYY"��" MM"��" DD"��" Day')
from dual; --to_char�� 1��° argument �� ���İ� ��ȯ�� �ι�° argument�� ������ �޶� ��ȯ��
           --20/02/05 2020�� 02�� 05�� ������ 

select 1234.56, to_char(1234.56 , '$999,999.990')
from dual; --1234.56 $1,234.560

select '$1,234.56' , to_number('$1234.56' , '999,999.990')
from dual; ---error, ��ġ������
select '$1,234.56' , to_number('$1,234.56' , '$999,999.990')
from dual;   -- $1,234.56   1234.56

select '2020�� 2�� 5�� ��'
        , to_date('2020�� 2�� 5�� ��', ' RR/MM/DD Day')
from dual; --error, ���ͷ��� ���� ���ڿ��� ��ġ���� ����


select '2020�� 2�� 5�� ��'
        , to_date('2020�� 2�� 5�� ��', 'YYYY"��" MM"��" DD"��" Day')
from dual; --error, ������ ������ �������մϴ�. 

select '2020�� 2�� 5�� ��'
        , to_date('2020�� 2�� 5�� ������', 'YYYY"��" MM"��" DD"��" Day')
from dual; --2020�� 02�� 5�� ��     20/02/05


-----------------�̻� ��¥�Լ� ---------------
-----------------null ���� �Լ� ���ž�--------
select nvl(comm, 'No Commission')
from emp; ---error, ��ġ������

select nvl(to_char(comm), 'No Commission')
from emp; --null���� No commission ����

--����
Q. emp���̺��� commission�� �޴� ����� sal_+ comm �����ϰ�, ���� �ʴ� ����� sal������ ��� ��� 
select ename, sal, comm, nvl2(comm, sal+comm, sal)
from emp;

select coalesce(1,2,3,4,5), coalesce(null, null, 3,4,5), coalesce(null, null, null, null, 5)
from dual; -- 1 3 5 

-- ����ó�� : decode(),  ǥ��sql ���� case when then ...else end
Q> 10�� �μ� ����� �޿��� 5%�λ�, 
      20�� �μ� ����� �޿��� 7%�λ�, 
     30�� ����� �޿��� 3%�λ�� �޿��� ����޿��� �Բ� ���
select ename, deptno, sal
        , decode(deptno, 10, sal*1.05, 20, sal*1.07, 30, sal*1.03, sal) "Increase"
from emp; --�׹�° col�� Increase ����, �μ��� ������ �׼��� �� ��ȯ 

--�Ǵ�(ǥ�� sql�������� ó��) 
select ename, deptno, sal
        , case deptno when 10 then sal*1.05
                      when 20 then sal*1.07
                      when 30 then sal*1.03
                      else sal end "Increase"
from emp; 

Q> �޿��� ���� ������ �޿��� �Բ� ����Ͻÿ�
�޿��� 1000�̸��̸� ���� 0��
�޿��� 1000�̻� 2000�̸��̸� ���� �޿��� 5%
�޿��� 2000�̻� 3000�̸��̸� ���� �޿��� 10%
�޿��� 3000�̻� 4000�̸��̸� ���� �޿��� 15%
�޿��� 4000�̻� �̸� ���� �޿��� 20% 
�÷� ��Ī�� Tax

select ename, deptno, sal
        , decode(trunc(sal/1000), 0, 0,
                                 1, sal*0.05,
                                 2, sal*0.1,
                                 3, sal*0.15,
                                 sal*0.2) "Tax"
from emp;

--�Ǵ� 
select ename, deptno, sal
        , case when sal<1000 then 0
               when sal<2000 then sal*0.05
               when sal<3000 then sal*0.1
               when sal<4000 then sal*0.15
               else sal*0.2 end "Tax"
from emp; 

-------------------�̻� null ���� �Լ� ------------------
-------------------���� group �Լ�(�������Լ�) ---------------------
--���̺� ��ü ���ڵ带 �ϳ��� �׷����� �Լ��� ����
--���̺��� ���ڵ带 Ư�� �÷����� �׷����ϰ� �׷��ε� ���ڵ�鿡 �Լ� ����
--count(), min(), max(), sum(), avg(), stddev(), variance()
select count(sal), min(sal), max(sal), sum(sal), avg(sal), stddev(sal), variance(sal)
from emp;  
--count(), min(), max()�� ��� �÷�Ÿ�� ���� ����
select   count(hiredate), min(hiredate), max(hiredate)
from emp; 

select   count(ename), min(ename), max(ename)
from emp; 

--count�� null�� �ƴ� �÷����� ������ ����
--count�� �μ��� *�� ����� �� ����=> ���̺��� ����� ���� (not null���������� ����� �÷����� ���� ��� ����)
select count(*), count(comm), count(deptno), count(distinct deptno)
from emp;

--avg
--�� �׷��Լ��� null�� �Լ� ��꿡 �������� �ʽ��ϴ�. (����)
select avg(comm),sum(comm)/count(empno)
from emp; --comm�÷��� null ���� 
          --��� ����� �ٸ���. 
          
-- ��ü ����� commision ����� ���ϰ��� �����Ѵٸ�?
select avg(nvl(comm,0)), sum(comm)/count(empno) --null���� ���� ����
from emp; --�� col�� �����ϰ� ��� 

Q. � �÷��� ��� null�� ��� count �Լ��� �����? 
alter table emp add (address varchar2(50));
desc emp; 
select empno, ename, address from emp; --address �÷� ���� null
select count(address) from emp; -- 0�� ��ȯ�ȴ�. 

Q. � �÷��� ��� null�� ��� sum �Լ��� �����? 
alter table emp drop(address);
alter table emp add(price number(6));
desc emp
select empno, ename, price from emp; --price �÷� ���� null
select sum(price) from emp; -- null �� ��ȯ�ȴ�. 

--�׷��� ����
select deptno, avg(comm), sum(comm)
from emp; ---error, ���� �׷��� �׷� �Լ��� �ƴմϴ�. 

select deptno, avg(comm), sum(comm)
from emp
group by deptno;

--1�� �׷�� ���ڵ忡 2�� �׷��� ���� ���� 
select deptno, job, avg(comm), sum(comm)
from emp 
group by deptno, job;

--����
Q. �� �μ��� ��� �޿��� 2500 �̻��� �μ��� �ش� �μ��� �޿� ����� �˻� ����Ͻÿ� 
select deptno, job, avg(sal), sum(sal)
from emp
where avg(sal) >= 2500
group by deptno; --error, where���� gruop by ���� ����Ǹ�, �׷��Լ� ���Ұ� 

--�׷��Լ��� ���� ����, group by �Ŀ� ����
select deptno, avg(sal), sum(sal)
from emp
group by deptno
having avg(sal) >= 2500;
