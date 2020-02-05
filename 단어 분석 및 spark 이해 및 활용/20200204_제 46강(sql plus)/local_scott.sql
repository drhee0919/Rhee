select sysdate from dual;
select 10+10 from dual;

alter session set nls_date_format = 'YYYY/MM/DD HH24:MI:SS';
alter session set nls_language=american;
select sysdate from dual;
alter session set nls_date_format='RR/MM/DD';
select sysdate from dual;

alter session set nls_date_format = 'DD Month YYYYspth';
select sysdate from dual;

alter session set nls_language=korean;
select sysdate from dual;

select 'A' || 'B' from dual; -- AB  
select ename, job from emp; -- ename�� job �÷��� ���� ���(2�� col)
select ename||job from emp; --ename||job �̶� �÷����� �� ���� �ٿ��� ���(1�� col)
select ename || ' ' || job from emp; -- ��� ������� ����������� ����(1�� col)

--���� ���� 
select 'A' from dual; --A
select '''A''' from dual; --'A'
select q'['A']' from dual; --'A'    

--��¥ ����(date+n, date-n, date+n/24, date+n/1440, date-n/24, date-n/12
alter session set nls_date_format = 'YYYY/MM/DD HH24:MI:SS';
select sysdate, sysdate+1, sysdate-1 from dual; --n�� '�Ϸ�' �� ���� Ȯ�� 
select sysdate, sysdate+ 5/24, sysdate-5/24 from dual; --n�� '�ð�(5�ð�)'�� ���� Ȯ��
select sysdate-hiredate from emp; -- hiredate: �ٹ��ߴ� ��¥, �Ⱓ ��� 

select sal, comm, (sal+comm)*12
from emp; 

-- 10�� �μ� �Ҽ� ��� �˻� 
select * 

from emp 

where deptno = 10;

-- ������ salesman �� ��� �˻� 
select * 

from emp 

where job = 'SALESMAN'; --�÷����� ��ҹ��� ������ 



-- �Ի糯¥�� 82�� 1�� 1�� ���Ŀ� �Ի��� ��� �˻� 
select * 
from emp 
where HIREDATE > '1982/01/01';

-- �޿��� 2500�̻��� ��� �˻� 
select * 
from emp 
where SAL >= 2500;
----------------------------------
-- Where �� 
-- where ���� ��밡���� ���� ������ : (����)�÷� between ���Ѱ� and ���Ѱ� 
-- Q. �޿��� 2000�̻� 3000������ ���  �˻�
from emp 
where sal between 2000 and 3000;
--�Ǵ� 
select * 
from emp 
where sal>=2000 
and sal<=3000;

-- where���� ��밡���� �������� ���� �� ������ :   (����)�÷� in (��1, ��2, ��3, ��4, ...)
-- Q. ������ clerk�̰ų� salesman�� ����� �˻�
select * 
from emp 
where job in ('CLERK', 'SALESMAN');
--�Ǵ� 
select *
from emp 
where job = 'CLERK'
or job = 'SALESMAN';

-- where ���� ��밡���� ���� �� ���� ������ : (����)Į�� like '�񱳹���% �Ǵ� _ '
-- Q. ��� �̸��߿� N���� ������ ��� �˻� 
select ename 
from emp 
where ename like '%N';
--Q. ��� �̸��߿� �ι�° ���ڰ� O�� ��� �˻� 
select ename 
from emp 
where ename like '_O%';

-- where ���� ��밡���� null�� �� ������ : is null, is not null 

select * 
from emp
where comm = null; --������ 

select * 
from emp 
where comm is null; -- COMM���� null �� row ��� 

select * 
from emp 
where comm >= 0;

--orderby ��� 
select * from emp;
select empno, ename,sal, deptno 
from emp
order by depto;

elect empno,ename,sal, deptno 
from emp
order by deptno desc ;
--Q.�����ȣ, �̸�, �μ���ȣ, ����(�޿�*12)�� ������ ������������ ���ĵ� �˻� ��� ���� 
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by sal * 12 desc; -- ǥ���� ���� ���� 
--�Ǵ�
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by "Annual Salary" desc; -- alias ���� ���� 
--�Ǵ� 
 select empno, ename, deptno, sal * 12 "Annual Salary"
 from emp 
 order by 4 desc; -- column position ���� ���� 

--Q. ��ü ����� �μ���ȣ�� �������� �����ϰ� �μ��� ����� �޿��� ������������ ������ �˻� ��� ���� 
select empno, ename, deptno, sal * 12 "Annual Salary"
from emp 
order by 3, 4 desc;

select empno, ename, deptno, sal * 12 "Annual Salary"
from emp 
order by deptno, 4 desc; --ȥ�뵵 �����ϴ� 

is not null
not between ~ and
not in
not like

-- input�� ȹ�� 
-- cmd������ �����ϴ� 
-- Q. �Է¹��� �����ȣ�� �ش� ����� ���� ���� ��ȯ 
select *
from emp
where empno = &emp_num;

--���� �����ϴ� Ȥ�� ���������� �����ϴ� sql������ ��ũ��Ʈ���Ϸ� ����
--Ȯ���� .sql

desc dept 
select rowid, deptno, dname 
from dept;



--�������� 
--����1)  EMP Table�� ��� �ڷḦ ����Ͽ���.
select * 
from emp

--����2)  EMP Table���� ��� ��ȣ, �̸�, �޿�, �������� ����Ͽ���.
select deptno, ename, sal, job
from emp

--����3) ��� ����� �޿��� $300 ������Ű�� ���� ���� �����ڸ� ����ϰ� ����� SAL+300�� ��ȸ�Ѵ�
select empno, ename, deptno, sal, sal + 300 "Added Salary"
from emp 

--����4) EMP ���̺��� �����ȣ, �̸�, �޿����ʽ��� ����Ͽ���.
select empno, ename, deptno, sal 
from emp 

--����5) EMP ���̺��� ENAME�� NAME�� SAL�� SALARY�� ����Ͽ���.
select ename "NAME", sal "SALARY"
from emp

--����6) EMP ���̺��� ENAME�� Name�� SAL*12�� Annual Salary �� ����Ͽ���.


����7) EMP ���̺��� ENAME�� '�� ��'����, SAL�� ���� ��'��  ����Ͽ���.

����8) EMP ���̺��� �̸��� ������ �����Ͽ� ����Ͽ���.

����9) EMP ���̺��� �̸��� ������ "King is a PRESIDENT" �������� ����Ͽ���.

����10) EMP ���̺��� �̸��� ������ "KING: 1 Year salary = 60000" 

����11) EMP ���̺��� JOB�� ��� ����Ͽ���.

����12) EMP ���̺��� ����ϰ� �ִ� ������ ������ ����Ͽ���.

����13) EMP ���̺��� �μ���ȣ�� �ߺ� ���� �����ؼ� ��ȸ�϶�

����14) �μ����� ����ϴ� ������ �ѹ��� ����Ͽ���.

����15) EMP ���̺��� �����ȣ, �̸�, rowid�� ��ȸ�϶�.
���̺� ���ڵ尡 �߰��Ǹ� �ڵ����� �÷����� �߰��˴ϴ�.
desc dept
select rowid, deptno, dname
from dept;
rowid�÷��� ���� �� �ּҰ� ����Ǵ� �÷����� ����Ŭ ������ �ڵ� �������ݴϴ�.

����17) EMP ���̺��� �޿��� 3000 �̻��� ����� �����ȣ, �̸�, ������, �޿��� ����϶�.

����18) EMP ���̺��� �������� Manager�� ����� ������ �������, ����, ������, �޿�, �μ���ȣ�� ����϶�.

����19) EMP ���̺��� 1982�� 1�� 1�� ���Ŀ� �Ի��� ����� �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����϶�.

����20) EMP ���̺��� �޿��� 1300���� 1700������ ����� ����, ������, �޿�, �μ� ��ȣ�� ����Ͽ���.

����21) EMP ���̺��� �����ȣ�� 7902, 7788, 7566�� ����� �����ȣ, ����, ������, �޿�, �Ի����ڸ� ����Ͽ���.

����22) EMP ���̺��� �Ի����ڰ� 82�⵵�� �Ի��� ����� ���, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.

����23) EMP ���̺� �̸��� ù ���ڰ� 'M'�� ����� �̸�, �޿� ��ȸ�϶�

����24) EMP ���̺� �̸���  �� ��° ���ڰ� ��L'�� ����� �̸�,������  ��ȸ�϶�

����25) EMP ���̺��� ���ʽ��� NULL�� ����� �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.

����26) EMP ���̺��� �޿��� 1100 �̻��̰� JOB�� Manager�� ����� �����ȣ, ����, ������, �޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.
 
����28) EMP ���̺��� JOB�� Manager, Clerk, Analyst�� �ƴ� ����� �����ȣ, ����, ������, �޿�, �μ���ȣ�� ����Ͽ���

����29) ������ PRESIDENT�̰� �޿��� 1500 �̻��̰ų� ������ SALESMAN�� ����� �����ȣ, �̸�, ����, �޿��� ����Ͽ���.

����30)  �޿��� 1500 �̻��� ����� ������  PRESIDENT �̰ų�  SALESMAN �� �����ȣ, �̸�, ����, �޿��� ����Ͽ���.

����31) EMP ���̺��� �Ի����� ������ �����Ͽ� �����ȣ, �̸�, ����, �޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.

����32) EMP ���̺��� ���� �ֱٿ� �Ի��� ������ �����ȣ, �̸�, ����, �޿�, �Ի�����, �μ���ȣ�� ����Ͽ���.

����33) EMP ���̺��� �μ���ȣ�� ������ �� �μ���ȣ�� ���� ��� �޿��� ���� ������ �����Ͽ� �����ȣ, ����, ����, �μ���ȣ, �޿��� ����Ͽ���.

����34) EMP ���̺��� ù��° ������ �μ���ȣ�� �ι�° ������ ������ ����° ������ �޿��� ���� ������ �����Ͽ� �����ȣ, ����, �Ի�����, �μ���ȣ, ����, �޿��� ����Ͽ���.

����35) �μ����� ����ϴ� ������ �ѹ��� ��ȸ�϶�.�� ���� �������� �����ؼ� �������� �Ѵ�.

����36) EMP  ����̸�, ����, �Ŵ�����ȣ�� ��ȸ�϶� ,�� �Ŵ��� ��ȣ�� ū �������� �������� �����Ѵ�.


