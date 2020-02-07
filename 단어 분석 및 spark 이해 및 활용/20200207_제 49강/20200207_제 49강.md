- join 이란?

> 하나 이상의 테이블로부터 동일한 속성의 컬럼값이 일치할 때 (두 테이블의) 레코드를 결합해서 검색하는 연산
>
> (http://70.12.116.160:8080/bigdata/sql_day8.txt)
>
> (http://www.gurubee.net/lecture/1879)
>
> → 동일한 속성이 테이블 상호간에 있는지부터 확인하여야 한다. 
>
> *  문법 
>
>   > where 절에 조인 조건 선언
>   >
>   > sql 1999표준 조인 문법(from 절 조인 선언)
>
> * 종류 
>
> > equi join(inner join) 
> >
> > >  조인할 두 테이블에서 동일한 속성의 컬럼값이 일치할 때(=연산자 사용)
> > >
> > >  - \- 일반 조인시 ,(콤마)를 생략하고 INNER JOIN을 추가하고, WHERE절 대신 ON절을 사용하면 된다.
> > >  - \- INNER는 생략 가능 하다.
> > >  - \- 아래 두 조인의 결과 값은 같다.
> > >
> > >  ```sql
> > >   --  INNER JOIN을 사용한 문장
> > >  SELECT e.empno, e.ename 
> > >  FROM dept d INNER JOIN emp e 
> > >  ON d.deptno=e.deptno;
> > >   
> > >  -- 일반적인 SQL 문장
> > >  SELECT e.empno, e.ename 
> > >  FROM dept d , emp e 
> > >  WHERE d.deptno=e.deptno;
> > >  ```
> > >
> > >  
> >
> > non-equi join 
> >
> > > 조인할 두 테이블에서 동일한 속성의 컬럼이 존재하지 않은 경우
> > >
> > > (=가 아닌 다른 연산자를 사용해서 조인 조건을 선언 )
> > >
> > > ```sql
> > > select a.ename, a.sal, b.grade
> > > from emp a, salgrade b 
> > > where a.sal between b.losal and b.hisal;
> > > 
> > > 
> > > select a.ename, a.sal, b.grade 
> > > from emp a join salgrade b on a.sal between b.losal and b.hisal; 
> > > ```
> > >
> > > 
> >
> > self-join 
> >
> > >  조인할 두 테이블이 동일한 테이블(하나의 테이블에서 PK를 참조하는 FK가 존재하는 경우로서 자기참조 가능한 테이블)로부터 레코드를 결합해서 검색 
> > >
> > > * 가령 emp 테이블은 자기참조관계에 있다. (empno(PK) ← (참조)mgr(FK), self join 가능)
> > >
> > > ```sql
> > > select e.empno, e.ename, e.mgr, 
> > > from emp e, emp m 
> > > where e.mgr = m.empno;
> > > 
> > > select e.empno, e.ename, e.mgr, m.ename
> > > from emp e join emp m on e.mgr = m.empno;
> > > ```
> > >
> > > 
> >
> > outer join  
> >
> > > equi join에서 조인할 두 테이블에서 동일한 속성의 컬럼값이 일치할 때 레코드를 결합해서 검색 결과를 생성하므로, 조인할 컬럼 중 하나가 null 인 경우는 조인 결과집합에서 레코드가 누락되지 않고 결과집합에 가져오기 위해 수행하는 join 
> > >
> > > ```sql
> > > insert into emp (empno, ename)
> > > values(8000, 'Hong'); --emp에 임의의 레코드들을 넣어보자
> > > commit; --저장 
> > > select * from emp; --확인(8000번 사원 Hong씨 확인(empno와 ename외 전부 null))
> > > 
> > > select a.empno, a.ename, deptno, b.dname --동일한 이름의 컬럼앞에 alias 미사용 
> > > from emp a join dept b using (deptno); --equi join(8000번 사원 누락 )
> > > 
> > > --equi join 에서 누락된 row를 결과집합으로 가져오려면 outer join을 수행해야 하며, 조인할 레코드가 없는 테이블의 조인조건에 outer 연산자(+)를 추가합니다. 
> > > select a.empno, a.ename, a.deptno, b.dname
> > > from emp a, dept b 
> > > where a.deptno = b.deptno(+); --Hong씨 확인 
> > > 
> > > select a.empno, a.ename, a.deptno, b.dname
> > > from emp a left outer join dept b on a.deptno = b.deptno; --Hong씨 확인 
> > > ```
> > >
> > > ```sql
> > > Q. 사원이 없는 부서 정보를 포함해서 부서별 부서번호, 부서이름, 사원번호, 사원이름을 검색 
> > > select a.empno, a.ename, deptno, b.dname
> > > from emp a join dept b using(dpetno); -- equi join(40번 부서정보 없음)
> > > 
> > > select b.deptno, b.dname, a.empno, a.ename
> > > from emp a , dept b 
> > > where a.deptno(+) = b.deptno
> > > order by 1;
> > > 
> > > --1999문법 사용 
> > > select b.deptno, b.dname, a.empno, a.ename
> > > from emp a right outer join dept b on a.deptno = b.deptno 
> > > order by 1;
> > > 
> > > Q. 사원이 없는 부서 정보를 포함하고, 부서를 배정받지 못한 사원정보(8000번 hong씨)
> > > 를 포함해서 부서별 부서번호, 부서이름, 사원번호, 사원이름을 검색 
> > > select b.deptno, b.dname, a.empno, a.ename
> > > from emp a , dept b 
> > > where a.deptno(+) = b.deptno(+)
> > > order by 1; --error, outer-join된 테이블은 1개만 지정할 수 있습니다
> > > 
> > > select b.deptno, b.dname, a.empno, a.ename
> > > from emp a full outer join dept b on a.deptno = b.deptno
> > > order by 1;
> > > ```
> > >
> > > 
> >
> > cartesian product(cross join)
> >
> > > ```sql
> > > conn hr /oracle -- hr게정 접속 
> > > Q. 사원번호, 사원이름, 소속부서번호, 소속부서 이름을 검색 
> > > select employees_id, last_name, department_id, department_name
> > > from employees, departments; --오류, 조인조건누락 
> > > 
> > > select a.employee_id, a.last_name, a.department_id, b.department_name
> > > from employees a, departments b; --cartesian product(2889 = 107 * 27)
> > > 
> > > select  a.employee_id, a.last_name, a.department_id, b.department_name
> > > from employees a  , departments b
> > > where a.department_id = b.department_id; --equi join(106 rows, 하나누락)
> > > --a.employee_id 는 primary key 가 아니여서 null 허용인 record가 있음 
> > > --null을 가져오고 싶다면 outer join 필요 
> > > ```
> > >
> > > ```sql
> > > Q. 부서번호, 사원이름,  동료사원이름 검색 (동료사원이름은 같은 부서에 속한 다른 사원이름만 검색 결과로 생성)
> > > select e.empno, e.ename, e.deptno, d.dname
> > > from emp e cross join dept d; --14 x 4 rows 
> > > ```
> > >
> > > 조인조건이 누락되면 조인할 테이블의 레코드가 전체 레코드에 대해서 한번씩 조인됨
> > >
> > >  
> >
> > natural join
> >
> > > 조인할 두 테이블에서 동일한 이름의 컬럼값이 일치할 때 조인 결과를 생성 
> > >
> > > (동일한 이름의 컬럼앞에 소유자(테이블명, alias)를 선언하지 않습니다. )
> > >
> > > - \- Equi Join과 동일 하다고 보면 된다.
> > > - \- 두 테이블의 동일한 이름을 가지는 칼럼은 모두 조인이 된다.
> > > - \- 동일한 컬럼을 내부적으로 찾게 되므로 테이블 Alias를 주면 오류가 발생 한다.
> > > - \- 동일한 컬럼이 두개 이상일 경우 JOIN~USING 문장으로 조인되는 컬럼을 제어 할 수 있다.
> > > - \- 아래 두 조인의 결과 값은 같다.
> > >
> > > ``` sql
> > > select a.employee_id, a.last_name, a.department_id, b.department_name
> > > from employees a natural join departments b; --error
> > > 
> > > select a.employee_id, a.last_name, department_id, b.department_name 
> > > from employees a natural join departments b; --32행 
> > > -- a.department_id = b.department_id and a.manager_id = b.manager_id
> > > ```
> >
> > join ~using(column name)
> >
> > > 동일한 이름의 속성이 여러개인 테이블을 조인할 때, 하나의 컬럼으로만 equi방식 조인을 수행
> > >
> > > - \- NATURAL JOIN의 단점은 동일한 이름을 가지는 칼럼은 모두 조인이 되는데, USING 문을 사용하면 컬럼을 선택해서 조인을 할 수가 있다.
> > > - \- USING절 안에 포함되는 컬럼에 Alias를 지정하면 오류가 발생 한다.
> > >
> > > ```sql
> > > select a.employee_id, a.last_name, department_id, b.department_name
> > > from employees a join departments b using(department_id); --106행 
> > > ```
> >
> > join ~on 
> >
> > > 두 테이블의 조인 컬럼이름이 다른 경우 join~on 조건을 쓴다. 
> > >
> > > - 조인 조건을 지정 할 수 있다.
> > > - \- 모든 논리 연산 및 서브쿼리를 지정할 수 있다.
> > >
> > > ```sql
> > > Q. 사원번호, 사원이름, 소속부서번호, 소속부서이름을 검색
> > > select a.empno, a.ename, a.deptno, b.dname
> > > from emp a  join dept2 b on a.deptno = b.deptid;
> > > ```
> > >
> > > ```sql
> > > Q. 부서번호, 사원이름,  동료사원이름 검색 (동료사원이름은 같은 부서에 속한 다른 사원이름만 검색 결과로 생성)
> > > select e.deptno, e.ename, c.ename
> > > from emp e join emp c on e.deptno = c.deptno and e.ename <> c.ename;
> > > -- <>는 '같지 않다' 라는 뜻 
> > > 
> > > select e.deptno, e.ename, c.ename
> > > from emp e join emp c on e.deptno = c.deptno
> > > where e.ename <> c.ename; 
> > > ```
> > >
> > > 

---

- 2개 이상의(n개의) 테이블을 조인 

> n개의 테이블을 조인할 경우 최소 조인조건은 n-1개 선언해야 한다. 

```sql
conn hr/oracle --hr계정 사용 

Q. 사원이름, 부서이름, 부서의 도서명을 검색 
select a.last_name, b.department_name, c.city --테이블이 3개 
from employees a, departments b, locations c
where a.department_id = b.department_id
and b.location_id = c.location_id;--테이블이 3개이므로 join조건은 최소 2개

--join on 구문 활용 
select a.last_name, b.department_name, c.city --테이블이 3개 
from employees a join departments b 
on a.department_id = b.department_id 
join locations c on b.location_id = c.location_id;
```

> ※ sql 예제문제 docx파일 참고할 것 

* subQuery

> select문 안에 들어가는 또 다른 select문
>
> - 바깥 select문을 outer Query, 또는 main Query라고 부르고
>
> - 내부 select문을 inner Query, 또는 nested Query라고 부른다. 
>
> - subQuery가 메인 Query보다 항상 먼저 수행된다. 
>
> - subQuery는 항상 ()괄호와 함께 수행된다. 
> - select절 뿐만 아니라 from절, where절, having절, order by 절에 선언 가능하다. (group by 빼고 다)
> - where절 subQuery는 연산자 오른쪽에 ()안에 선언합니다. (가장자주 사용)
> - single row subQuery : >,=,<>,>=,<= single row operator와 함께 선언되는 subQuery
> - multiple row sudbQuery: in, any, all 등의 연산자(multiple row operator) 함께 선언되는 subQuery
>
> → 1번 이상 select를 수행해야 나올 수 있는 결과를 호출할 때 하나의 select문으로 작성시 사용 
>
> ex/ 
>
> ```sql
> conn scott/oracle --scott계정 조회 
> Q. ADAMS 사원보다 급여가 높은 사원이름과 급여 조회 
> select ename, sal
> from emp 
> where sal > (ADAMS 사원의 급여를 나타내는 select 문)
> 
> select ename, sal
> from emp 
> where sal > (select sal
>              from emp 
>              where ename = 'ADAMS' );
> ```
>
> ```sql
> Q. 7369 사원과 동일한 직무를 담당하는 사원의 이름, 부서번호, 직무, 급여를 조회 
> (7369사원은 결과에서 제외)
> select ename, deptno, job, sal
> from emp 
> where job = (select job 
>              from emp 
>              where empno =7369)
> and empno <> 7369;
> ```
>
> ```sql
> Q. ALLEN 사원과 동일한 부서에 근무하면서 급여를 더 많이 받는 사원 검색
> (사원이름, 부서번호, 직무, 급여)
> select ename, deptno, job, sal 
> from emp 
> where deptno = (select deptno
>                 from emp 
>                 where ename = 'ALLEN')
> and sal > (select sal
>            from emp
>            where ename = 'ALLEN'); 
> --and ename <> 'ALLEN';
> 
> 
> ```
>
> ```sql
> Q. emp 테이블에서 급여를 제일 적게 받는 사원의 이름, 부서, 직무, 급여를 검색 
> select ename, deptno, job, sal
> from emp 
> where sal = (select min(sal)
>              from emp);
> ```
>
> ```sql
> Q. 부서별 최대 급여를 받는 사원들의 이름, 부서, 직무, 급여를 검색
> select ename, deptno, job, sal
> from emp 
> where (deptno, sal) in (select deptno, max(sal)
>                         from emp
>                         group by deptno); -- multiple row + multiple column subquery
>                         				 -- 부서 중복 제외(부서에서 제일 높은사람만)
> ```
>
> ```sql
> Q. 직무가 salesman인 모든 사원보다 급여를 많이 받는 사원검색 
> (이름, 직무, 급여 - 단 salesman 직무 직무 제외)
> select ename, job, sal
> from emp 
> where sal > all (select sal
>                  from emp
>                  where job = 'SALESMAN')
> and job <> 'SALESMAN';                 
>                  
> 
> select ename, job, sal
> from emp 
> where sal > (select max(sal)
>              from emp
>              where job ='SALESMAN')
> and job <> 'SALESMAN'
>        
> ```
>
> ```sql
> Q. 직무가 salesman인 최소 한명의 사원보다 급여를 많이 받는 사원검색 
> (이름, 부서번호, 직무, 급여 - 단 salesman 직무 제외)
> select ename, deptno, job, sal
> from emp 
> where sal > (select min(sal)
>              from emp 
>              where job = 'SALESMAN')
> and job <> 'SALESMAN';
> ```
>
> ```sql
> Q. 전체사원의 평균 급여보다 급여를 많이 받는 사원 검색 
> select ename, deptno, job, sal
> from emp 
> where sal > (select avg(sal)
>              from emp);
> 
> select ename, deptno, job, sal
> from emp 
> where sal > (select sum(sal)/count(empno)
>              from emp);
>              
> Q. 각 부서별 부서의 평균 급여보다 급여를 많이 받는 사원 검색 
> select ename, deptno, job, sal
> from emp 
> where (deptno, sal) in (select deptno, avg(sal)
>                         from emp
>                         group by deptno)
> and sal > avg(sal);
> ```
>
> ```sql
> Q. 각 부서별 부서의 평균 급여보다 급여를 많이 받는 사원 검색 
> (join 또는 co-related subQuery라는 특수한 형태 필요)
> 
> >co-related subQuery구조
> select blah blah
> from table a 
> where col > (select blah
>              from table b
>              where a.col = b.col)
>              
> --1) co-related subQuery 방식
> select ename, deptno, sal
> from emp a 
> where sal > (select avg(sal)
>              from emp b
>              where a.deptno = b.deptno); 
>              --부서번호를 하나씩 할당하기 때문에 group by 불필요
> --2) join으로 구현
> select a.ename, a.deptno, a.sal
> from emp a, (select deptno, avg(sal) avgsal
>              from emp 
>              group by deptno) b
> where a.deptno = b.deptno and a.sal > b.avgsal;   
> ```
>
> ```sql
> conn hr/oracle -- hr계정 접속 
> Q. 전체 평균 급여보다 높은 부서별 평균 급여를 검색
> select last_name, department_id, salary 
> from employees a
> where salary > (select avg(salary)
> 			   from employees b 
> 			   where a.department_id = b.department_id)
> order by 2;
> ```
>
> 

