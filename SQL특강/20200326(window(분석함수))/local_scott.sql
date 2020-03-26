-- Q. �μ��� �޿��� ������������ ������ ��� 
select ename, deptno, sal, 
       rank() over (partition by deptno order by sal desc) sal_rank
from emp;
-- �޿��� ������ �� ������ �����ϰ� ���� ������ ������ ������ rows��ŭ count�� ���� ���� 

select ename, deptno, sal, 
       dense_rank() over (partition by deptno order by sal desc) sal_rank
from emp;
-- �޿��� �����Ҷ� ������ �����ϰ� ���� ������ ������ ������ row��ŭ 1���� ������ ó�� �ǰ� ���� ������ ���������� ������ 


-- Q. ��� row�� �ڵ����� 1,2,3 ������ �������ִ� ���� �÷� 
select rownum, ename, sal 
from emp;

select rownum, ename, sal
from emp
order by sal desc; --rownum�� ���� ����ǰ�, order by ���� ó���� 


-- Q. �޿��� ���� �޴� 5�� ����� ��� 
select rownum, ename, sal
from (select ename, sal
      from emp 
      order by sal desc) -- subquery, inline view 
where rownum < 6 ;



-- Q. �μ��� ������ �޿��� �޴� ����� ������ �ٸ���(�����ְ�) ��� --rowid���� 
-- row_number() : order by ���� �߰� ���������� ������ rowid���� ���� ������ ������ȯ
select ename, deptno, sal, 
       row_number() over(partition by deptno order by sal desc) sal_rank
from emp;
      
 

-- Q. �μ��� ����� �޿� ���� ������ �޿� �հ踦 �Բ� ��� 
select ename, deptno, sal, 
       sum(sal) over(partition by deptno order by sal desc range unbounded preceding) cum_sal
from emp;


-- Q. �μ��� ����� �޿� ���� �μ��� �ִ� �޿� �Բ� ��� 
select ename, deptno, sal, 
       max(sal) over(partition by deptno order by sal desc range unbounded preceding) max_dep_sal
from emp;       

-- Q. �μ��� ����� �޿� ���� �μ��� �ִ� �޿��� �޴� �ο��� �̸� �Բ� ��� 
select ename, deptno, sal,
       first_value(ename) over (partition by deptno order by sal desc range unbounded preceding) max_sal_emp
from emp;


-- Q. �μ��� ����� �޿� ���� �μ��� �ּ� �޿� �Բ� ��� 
select ename, deptno, sal, 
       min(sal) over(partition by deptno order by sal desc range unbounded preceding) min_dep_sal
from emp;   


-- Q. �μ��� ����� �޿� ���� �μ��� �ּ� �޿��� �޴� �ο��� �̸� �Բ� ��� 
select ename, deptno, sal,
       last_value(ename) over (partition by deptno order by sal desc range unbounded preceding) min_sal_emp
from emp;      

-- Q. �μ��� ����� �޿� ���� ������� �޿��� �� ���� �޴� 1���� ����� �޿��� �� ���� �޴� 1���� �޿��� ��� �Բ� ��� 
select ename, deptno, sal, 
       avg(sal) over (partition by deptno order by sal desc rows between 1 preceding and 1 following) "3rows_avg_sal"
from emp;

select ename, deptno, sal, 
       round(avg(sal) over (partition by deptno order by sal desc rows between 1 preceding and 1 following)) "3rows_avg_sal"
from emp;

-- Q. �μ��� ����� �޿� ���� -200~ +200�޿��� �޴� ������� �Բ� ��� 
select ename, deptno, sal, 
       count(sal) over (partition by deptno order by sal desc range between 200 preceding and 200 following) "+200~-200"
from emp;


 -- lag(column, n, null|n)
 -- lead(column, n, null|n))
 -- Q. ��� ����� �޿��� ������������ ����ϰ�, ���� �ڽź��� �޿��� ���� �޴� ����� �޿��� �ڽź��� �޿��� ���� �޴� 
 --    ����� �޿��� �Բ� ��� 
 select ename, deptno, sal, 
        lag(sal, 1, -1) over (order by sal desc) before, 
        lead(sal) over (order by sal desc) after 
from emp;

-- nth_value(column, ����) : ������ �ش��ϴ� �÷��� ��ȯ 
select ename, deptno, sal, 
       nth_value(sal, 2) over (order by sal desc) before, 
       nth_value(sal, 2) over (order by sal) after 
from emp;


-- ���� ���� �Լ� 
-- ratio_to_report(�÷�) : ��Ƽ�� ���� �÷��� sum���� ���� ���� �÷����� ������� ��ȯ (0< ~ <=1 ����) 
select ename, deptno, sal, 
       round(ratio_to_report(sal) over (partition by deptno), 2) as ratio 
from emp;


-- percent_rank() : ��Ƽ�� ���� ���� ������ �����, ���� ���� ��µǴ� ���� ���� ������� 0, ��Ƽ�ǳ��� ������ ��µǴ� ���� ������� 1 
select ename, deptno, sal 
       percent_rank( ) over(partition by deptno order by sal desc) as percent 
from emp;


-- ntile():��ü ���� n����� ��� ��ȯ, ��Ƽ�Ǻ� ����� n����� ��� ��ȯ 
select ename, sal, ntile(4) over (order by sal desc) "4tile"
from emp;