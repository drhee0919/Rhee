###################### join ############################
Q. ����̸�, �μ���ȣ, �μ��̸��� ��ȸ ����� ���� 
select ename, deptno, dname
from emp,dept; --error, ���� ���ǰ� �ָ� 

select emp.ename, emp.deptno, dept.dname
from emp, dept; -- �� 56�� ��

select a.ename, a.deptno, b.dname
from emp a, dept b; --emp 14rows, dept 4rows, ��56��
--join ������ �����Ǿ� cartesian product(Cross join)�� ���� �� 

select a.ename, a.deptno, b.dname
from emp a, dept b 
where a.deptno = b.deptno; --14�� �ุ ���(inner) 

--employee���� ���� (hr���� ����) --
----------------------------------

-- natural join ����
-- natural join�� ������ �𵨸��� �߸��ؼ� �� ���̺��� ������ �Ӽ��� ���ؼ� �÷��̸��� �ٸ� ��쿡�� ������ ������� �ʽ��ϴ�. 

create table dept2(deptid, dname, loc)
as select * from dept; --���̺��� ������ row�� ���� 

desc dept2
select * from dept2;

select a.ename, deptno, b.dname
from emp a natural join dept2 b; --cartesian product (join���� ����; deptno != dname)

--�ڵ� ����
select a.ename, a.deptno, b.dname
from emp a join dept2 b on a.deptno = b.deptid; --14�� �� 


--------
--non equi join 
Q. �� ������� �޿��� ����� �޿� ����� ��ȸ ����ϴ� SQL �ۼ� 
desc emp 
desc salgrade

select a.ename, a.sal, b.grade
from emp a, salgrade b
where a.sal between b.losal and b.hisal;
--�Ǵ� 
select a.ename, a.sal, b.grade
from emp a join salgrade b on a.sal between b.losal and b.hisal;


--self join 
--�ڱ� ���� ���� ���̺��� PK�� FK�÷����� ���� ���� 
Q. �� ������� ���, �̸�, �����ڹ�ȣ, �������̸��� ��ȸ ����ϴ� SQL�ۼ� 
select a.empno, a.ename, a.mgr, b.ename
from emp a, emp b 
where a.mgr = b.empno;

select a.empno, a.ename, a.mgr, b.ename
fro emp a join emp b on a.mgr = b.empno;

--- ���� hr �������� �������� Ǯ��2-------

Q. ����̸�, �ҼӺμ� �̸�, �ҼӺμ��� ��ġ(���ø�)�� ��ȸ ����ϴ� SQL(last_name, department_name, city) 