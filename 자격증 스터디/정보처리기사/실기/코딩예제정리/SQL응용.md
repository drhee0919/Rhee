## SQL응용

### 예상 문제 은행 풀이



#### Section 별 예제 풀기

#### **1. SQL-DDL(p.104~105) **

- 문제1

> 요구사항을 만족하는 테이블 <patient>를 정의하는 SQL문 작성

```sql
CREATE TABLE patient
( id CHAR(5) PRIMARY KEY,
  name CHAR(10),
  sex CHAR(1),
  phone CHAR(20),
  CONSTRAINT sex_ck CHECK (sex='f' or sex='m'),
  CONSTRAINT id_fk FOREIGN KEY(id) REFERENCES doctor(doc_id) );
```



- 문제2

> 요구사항을 만족하는 테이블 <Instructor>를 정의하는 SQL문 작성

```sql
CREATE TABLE Instructor
( id CHAR(5),
  name CHAR(15) NOT NULL,
  dept CHAR(15),
  PRIMARY KEY(id),
  FOREIGN KEY(dept) REFERENCES Department(name)
  
   ON DELETE SET NULL
   ON UPDATE CASCADE
 );
```



- 문제3 

> <patient> 테이블에 데이터 타입이 문자 20자리인 'job' 속성을 추가하는 SQL문 작성하기

```sql
ALTER TABLE patient
  ADD job CHAR(20);
```



- 문제4

> 아래의 요구사항을 만족하는 뷰 <CC>를 정의하는 SQL문을 작성하기 

```sql
CREATE VIEW CC(ccid, ccname, instname) AS

  SELECT Course.id, Course.name, Instructor.name
  
  FROM Course, Instructor
  
  WHERE Course.instructor = Instructor.id;
```



- 문제5

> <Student> 테이블의 ssn속성에 대해, 중복을 허용하지 않도록 'Stud_idx'라는 이름으로 오름차순 인덱스를 정의하는 SQL문을 작성하시오

```sql
CREATE UNIQUE INDEX Stud_idx

 On Student(ssn ASC);
 -- ASC는 생략해도 된다.(default)
```



- 문제6

> * '근무지번호' 는 <근무지> 테이블의 '근무지번호' 를 참조하는 외래키이다. 
> * <근무지> 테이블에서 '근무지번호'가 삭제되면 <사원> 테이블의 '근무지번호'도 삭제된다. 

```SQL
CREATE TABLE 사원
  ( 사원번호 NUMBER(4) PRIMARY KEY,
    사원명 VARCHAR2(10),
    근무지번호 NUMBER(2) FOREIGN KEY REFERENCES 근무지
    ON DELETE CASCADE
  );
```



- 문제7

> 다음은 기본키인 '직위' 속성의 값으로 "사원", "대리", "과장", "부장", "이사", "사장"만을 허용하고, 기본 값으로 "사원"을 취하는 도메인 무결성 제약 조건을 설정하기 위한 SQL문이다. 괄호를 채워 SQL문을 완성하시오

```sql
CREATE DOMAIN 직위 VARCHAR2(10)
DEFAULT "사원"
CONSTRAINT VALID-직위 CHECK(

    VALUE IN("사원", "대리", "과장", "부장", "이사", "사장"));
```



- 문제8

> <직원> 테이블에 대해 '이름' 속성으로 '직원_name' 이라는 인덱스를 정의하는 SQL문을 작성하시오 

```sql
CREATE INDEX 직원_NAME ON 직원(이름)
```



- 문제9

> 다음 <처리조건>에 부합하는 SQL문을 완성시키시오.
>
> * <학생>테이블을 제거한다.
> * <학생>테이블을 참조하는 모든 데이터도 함께 제거한다.

```sql
DROP TABLE 학생();
```



- 문제10

> * 데이터베이스 구조를 정의 및 변경하는 DDL : CREATE, ALTER, DROP 
> * 데이터를 조작하는 DML : SELECT , INSERT, DELETE UPDATE
> * 보안 및 무결성, 병행제어등을 위한 DCL : GRANT/REVOKE, COMMIT, ROLLBACK, SAVEPOINT



- 문제11

> <사원> 테이블 구조를 참고하여 SQL문 완성하기 

```sql
CREATE TABLE 사원
	(직원코드 NUMBER NOT NULL,
     성명 CHAR(10) UNIQUE,
     직책 CHAR(10) CHECK(직책 IN('사원','대리','과장','팀장')),
     연봉 NUMBER);
```

----

#### 2. SQL-DCL(P.112,113)

- 문제1~4 

> DCL을 이용하여 다음 요구 사항에 맞는 SQL문을 작성하시오.
>
> > <학사관리 시스템 스키마>
> >
> > 학생(<u>학번</u>, 주민등록번호, 이름, 학년, 전화번호, 주소)
> >
> > 강좌(<u>강좌번호</u>, 강좌명, 학점, 수강인원, 강의실, 학기, 연도, 교수번호)
> >
> > 수강(<u>학번</u>, <u>강좌번호</u>, 성적)
> >
> > 교수(<u>교수번호</u>, 주민등록번호, 이름, 직위, 임용년도)
>
> 
>
> 1. 김하늘에게 <학생> 테이블에 대한 접근 및 조작에 관한 모든 권한을 부여하는 SQL문을 작성하시오. 
>
> ```sql
> GRANT ALL ON 학생 TO 김하늘;
> ```
>
> 2. 김하늘에게 <강좌> 테이블에 대해 삭제하는 권한을 부여하고, <강좌> 테이블에 대해 삭제하는 권한을 다른 사람에게 부여할 수 있는 권한을 부여하는 SQL문을 작성하시오. 
>
> ```SQL
> GRANT DELETE ON 강좌 TO 김하늘 WITH GRANT OPTION;
> ```
>
> 3. 임꺽정에게 부여된 <교수> 테이블에 대한 SELECT, INSERT, DELETE 권한을 취소하는 SQL문을 작성하시오 
>
> ```SQL
> REVOKE SELECT, INSERT, DELETE ON 교수 FROM 임꺽정;
> ```
>
> 4. <수강> 테이블에 대해 임꺽정에게 부여된 UPDATE 권한과 임꺽정이 다른 사람에게 UPDATE 권한을 부여할 수 있는 권한, 그리고 임꺽정이 다른 사람에게 부여한 UPDATE권한도 모두 취소하는 SQL문을 작성하시오. 
>
> ```SQL
> REVOKE UPDATE ON 수강 FROM 임꺽정 CASCADE;
> -- 'GRANT OPTION FOR'의 생략된 이유는 임꺽정의 UPDATE에 대한 권한을 취소하면 다른 사람에게 UPDATE권한을 부여할 수 있는 권한도 자동으로 사라지기 떄문. 
> ```



- 문제 5

> COMMIT 연산은 트랜잭션 처리가 정상적으로 종료되어 트랜잭션이 수행한 변경 내용을 데이터베이스에 반영하는 연산이다. 
>
> ※ ROLLBACK은 아직 COMMIT되지 않은 변경된 모든 내용들을 취소하고 데이터베이스를 이전 상태로 되돌리는 명령어이다. 
>
> ※SAVEPOINT는 트랜잭션 내에 ROLLBACK 할 위치인 저장점을 지정하는 명령어이다. 

