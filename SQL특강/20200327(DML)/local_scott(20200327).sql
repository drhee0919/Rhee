conn scott/oracle --scott DB�� ����
select table_name from user_tables; --scott����(������)�� ���̺� ��� 
select table_name from all_tables; --���� + ������ ���� ���̺� ���
select count(table_name) from all_tables; 
select count(table_name) from dba_tables; -- ���� ����� ���� �߻� 

conn scott /oracle 
desc dept 

select constraint_type, constraint_type
from user_constraints 
where table_name = 'DEPT'; --���̺� ���ǵ� �������� Ȯ�� 

--insert into ���̺�� values (�÷��� ����Ʈ); �� 1�� ������ �߰� 
--insert into (�÷�����Ʈ) values (�÷��� ����Ʈ); 
--insert into values (���̺� ���ǵ� ������ �÷��� ����Ʈ); 
insert into dept (deptno, dname) values(50, 'IT'); --������ �÷������� �ڵ����� null ������ ����� 
insert into dept values(70, 'IT','seoul'); -- 50���� �����ϸ� ���Ἲ ���������� �浹�߻�(����)  
select * from dept; --�޸𸮿��� ���ο� �����Ͱ� �߰���(��������� DB�� ������ �����(file)�� �����Ű�� ��ɾ ������Ѿ� ����(���Ӽ�) ��) 
                    --����(DB�� �������)�� ���������� ���ᳪ DB������ ������������ ����Ǹ� �����ʹ� �ڵ����� rollback(���) �� 
rollback; --�������� rollback��ɾ�

select * from dept;
insert into dept( dname, loc ) values ('web','inchon'); -- PK�������� ����, ���� 
                                                        -- ORA-01400: NULL�� ("SCOTT"."DEPT"."DEPTNO") �ȿ� ������ �� �����ϴ�

select constraint_type, constraint_type
from user_constraints
where table_name = 'EMP'; --Ÿ�����

select * from emp;
insert into emp(empno, ename, deptno, hiredate) values(9001, 'kim', 80, sysdate); 
--���� ���Ἲ �������� ����, dept.deptno �÷��� ���� 
--ORA-02291: ���Ἲ ��������(SCOTT.FK_DEPTNO)�� ����Ǿ����ϴ�- �θ� Ű�� �����ϴ�
insert into emp(empno, ename, deptno, hiredate) values(10001, 'kim', 80, sysdate);
--�÷� ������ ����, ���ڸ��� �Ѱ�
--ORA-01438: �� ���� ���� ������ ��ü �ڸ������� ū ���� ���˴ϴ�.
insert into emp(empno, ename, deptno, hiredate) values(1234, 'kim', 50, sysdate);
insert into emp(empno, ename, deptno, hiredate) values(100, 'lee', 50, to_date('19-03-05')); --������ �Լ��κ��� ��ȯ�� �� ���� 
insert into emp(empno, ename, deptno, hiredate) values(1000, 'kim', 50, null); --��������� null ��� ���� 

create table student(
grade number(1),
class number(2),
name varchar2(15),
exam number(3) default 50); --student ���̺� �ۼ�

describe student 
desc student 
insert into student values(1, 1, 'Hong', null);  --1�� ����
insert into student values(1, 2, 'Hong'); --SQL ����: ORA-00947: ���� ���� ������� �ʽ��ϴ�
insert into student values(1, 1, 'Hong', default); -- default(=50)�� �߰��� 
insert into student (grade, class, name) values(1, 3, 'Hong'); --������ �÷���? default(=50)�� �߰��� 
select * from student;

drop table dept2 purge; -- ���� dept2�� ������ ���� 
create table dept2
as select * from dept 
where 1 = 2; --���� �� ����� false�̹Ƿ� �˻� data�� �����Ƿ� ���̺� ������ ������ 

desc dept                                           
desc dept2
select * from dept;
select * from dept2; --������ ��µ�(���� ����) 

insert into dept2
select * from dept 
where deptno <= 30; -- values �� ��� subquery�� ���(subquery�� ���� ����ȴ�.) 
select * from dept2; -- 3�� ���� ���Ե� ���� Ȯ�� 


--# �÷��� ������ row �����ϱ� 
--# update ���̺�� set�÷��� = new_valuep[, �÷��� = new_value, ...];
--# update ���̺�� set�÷��� = new_valuep[, �÷��� = new_value, ...]
--  where ����; -- ������ �����ϴ� row�� ����� 
select sal from emp;
update emp set sal =0; --��� ���ڵ��� sal�÷����� ���ϰ����� ���� 
select sal from emp;

rollback;
update emp set sal = sal*1.1;
select sal from emp;

rollback;
update emp set sal = sal*1.1 where deptno = 20;

--# ������ �÷��� ��������, �Լ�, null, default���� ����� 
-- Q. smith ����� �޿��� scott����� �޿��� �����ϵ��� �����Ͻÿ� 
select sal, ename from emp;

update emp set sal= (select sal from emp where ename = 'SCOTT')
where ename = 'SMITH';
--update�� set��, where ���� subquery������� ���� ���� 
select sal, ename 
from emp 
where ename in ('SMITH','SCOTT');
rollback;



--#���ڵ� ������ ���� 
--# delete from ���̺��; --���̺��� ��� �� ����
--# delete from ���̺�� where ����; -- ������ �����ϴ� �ุ ���� 
select count(*) from emp;
delete from emp; --��ü row�� �� ������ 
select count(*) from emp;--0
rollback;
select count(*) from emp;

delete from emp where deptno = 20;
select count(*) from emp; --10
select deptno from emp;
rollback;


--Q. smith ����� ������ ������ ����ϴ� ����� ���� 
--Hint/ delete from ���̺�� where ���� = (subquery);
select * from emp;
select count(*) from emp; --15
delete from emp where job = (select job from emp where ename = 'SMITH'); --4�� �� ���� 
select * from emp; 
select count(*) from emp; --11
rollback;



--#merge�� - ETL�۾��� ���� 
--#join ���ǿ� ���� insert, update ����, update ��� �������� delete�� �Բ� ���� 
/* merge into Ÿ�����̺� ��Ī 
   using �ҽ����̺� ��Ī 
   on(Ÿ�����̺� .pk �÷� = �ҽ����̺� .pk �÷�)
   when matched then 
     update set t.�÷� = s.�÷�, ....
     [delete where ����]
   when not matched then 
     insert (t.�÷�, t.�÷�, t.�÷�,..)
     values (s.�÷�, s.�÷�, s.�÷�,..) 
*/
create table tiny_emp
as select empno, ename, deptno, sal, job 
   from emp 
   where deptno=10; --auto commit (create�� �ѹ��� �ȵȴ�)
   
select * from tiny_emp;


--Q. emp�� �����͸� tiny_emp�� �̰��Ͻÿ� 
/* tiny_emp���̺� �̹� ���ڵ尡 �����ϸ� �޿��� 10%�λ��ϰ� 
   �λ�� �޿��� 5000���� ũ�� �����ϰ� 
   tiny_emp ���̺� emp���̺��� �����Ͱ� �������� ������ emp�� �����͸� 
   insert �Ͻÿ� (merge���� �ۼ�) 
*/
merge into tiny_emp t 
using emp s 
on(t.empno = s.empno)
when matched then 
  update set t.ename = s.ename, t.deptno=s.deptno, t.sal=s.sal*1.1, t.job=s.job
  delete where t.sal>5000
when not matched then 
  insert (t.empno, t.ename, t.deptno, t.sal, t.job)
  values (s.empno, s.ename, s.deptno, s.sal, s.job); --15�� �� ��(��) ���յǾ����ϴ�.

select * from tiny_emp;
rollback;
