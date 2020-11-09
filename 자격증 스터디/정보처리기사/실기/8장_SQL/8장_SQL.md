

### 8장. SQL

#### 단원별 요점 정리(72~81, 총 10개) 

**SQL-DDL(데이터 정의어)**

> DDL(데이터 정의어)는 DB구조, 데이터 형식, 접근 방식 등 DB를 구축하거나 수정할 목적으로 사용하는 언어이다. 
>
> - DDL은 번역한 결과가 데이터사전(Data Dictionary)이라는 특별한 파일에 여러개의 테이블로서 저장된다. 
>
> - DDL에는 CREATE SCHEMA, CREATE DOMAIN, CREATE TABLE, CREATE VIEW, CREATE INDEX, ALTER TABLE, DROP 등이 있다. (CAD) 
>
>   
>
> - CREAET SCHEMA
>
> > 스키마를 정의하는 명령문 
> >
> > * 스키마의 식별을 위해 스키마 이름과 소유권자나 허가권자를 정의한다. 
> >
> > ```sql
> > CREATE SCHEMA 스키마명 AUTHORIZAION 사용자_id; 
> > 
> > --소유권자의 사용자 ID가 홍실동 인 스키마 대학교를 정의하는 SQL문 
> > CREATE SCHEMA 대학교 AUTHORIZATION 홍길동; 
> > ```
> >
>
> - CREATE DOMAIN
>
> > 도메인을 정의하는 명령문 
> >
> > * 임의의 속성에서 취할 수 있는 값의 범위가 SQL에서 지원하는 전체 데이터타입의 값이 아니고 일부분일 때, 사용자는 그 값의 범위를 도메인으로 정의할 수 있다. 
> > * 정의된 도메인명은 일반적인 데이터 타입처럼 사용한다. 
> > * <u>데이터타입, 기본값, 제약조건</u> 이 포함된다. 
> >
> > ```sql
> > CREATE 도메인명 [AS] 데이터_타입 --SQL에서 지원하는 데이터타입
> > 	[DEFAULT 기본값] -- 데이터를 입력하지 않았을 때 자동으로 입력되는 값 
> > 	[CONSTRAINT 제약조건명 CHECK (범위값)]; 
> > 	   
> > /* '셩별'을 '남' 또는 '여'와 같이 정해진 1개 문자로 표현되는 도메인 SEX를 정의하는 SQL문 */
> > 
> > CREATE DOMAIN SEX CHAR(1) --정의된 도메인의 이름은 'SEX', 문자형에 크기는 1자
> > 	DEFAULT '남' -- 도메인 SEX를 지정한 속성의 기본값은 '남'이다.
> >     CONSTRAINT VALID-SEX CHECK(VALUE IN ('남', '여')); 
> >     --SEX를 지정한 속성에는 '남', '여' 중 하나의 값만을 지정할 수 있다. 
> > ```
> >
> > ※ SQL에서 지원하는 기본 데이터 타입 
> >
> > > * 정수 : INTEGER(4Byte 정수), SMALLINT(2Byte 정수)
> > > * 실수 : FLOAT, REAL, DOUBLE PRECISION 
> > > * 형식화된 숫자 : DEC(i, j) (i: 전체자릿수, j: 소수부 자릿수)
> > > * 고정길이 문자 : CHAR(n), CHARACTER(n) (n: 문자수)
> > > * 가변길이 문자 : VARCHAR(n), CHRACTER VARYING(n) (n: 최대 문자수)
> > > * 고정길이 비트열 : BIT(n)
> > > * 가변길이 비트열 : VARBIT(n)
> > > * 날짜 : DATE
> > > * 시간 : TIME
>
> - CREATE TABLE 
>
> > 테이블을 정의하는 명령문
> >
> > * 기본 테이블에 포함될 모든 속성에 대하여 속성명과 그 속성의 데이터 타입, 기본값, NOT NULL 여부를 지정한다. 
> >
> > ※테이블 :  DB설계 단계에서는 '릴레이션' 이라 부르고, 조작 검색 시에는 테이블로 지칭한다. 
> >
> > ```sql
> > CREATE TABLE 테이블명
> > 	(속성명 데이터_타입 [DEFAULT 기본값][NOT NULL],…
> >      [, PRIMARY KEY(기본키_속성명, …)]
> >      [, UNIQUE(대체키_속성명, …)]
> >      [, FOREIGN KEY(왜래키_속성명, …)]
> >      	REFERENCES 참조테이블(기본키_속성명, …)]
> >      	[ON DELETE 옵션]
> >      	[ON UPDATE 옵션]
> >      [, CONSTRAINT 제약조건명][CHECK(조건식)]);
> > ```
> >
> > * PRIMARY KEY : 기본키로 사용할 속성 또는 속성의 집합을 지정한다. 
> > * UNIQUE : 대체키로 사용할 속성 또는 속성의 집합을 지정. 중복된 값을 가질 수 없다. 
> > * FOREIGN KEY ~ REFERENCES ~
> >
> > > 참조할 다른 테이블과 그 테이블을 참조할 떄 사용할 외래키 속성을 지정한다. 
> > >
> > > 외래키가 지정되면 참조 무결성의 CASCADE법칙이 적용된다. 
> > >
> > > * ON DELETE 옵션<BR>: 참조 테이블의 튜플이 삭제되었을 때 기본 테이블에 취해야 할 사항을 지정한다.<BR>옵션에는NO ACTION, CASCADE, SET NULL, SET DEFAULT 가 있다. 
> > >
> > > * ON UPDATE 옵션<BR>: 참조 테이블의 참조 속성 값이 변경되었을 때 기본 테이블에 취해야 할 사항을 지정한다.   옵션에는 NO ACTION, CASCADE, SET NULL, SET DEFAULT 가 있다. 
> > >
> > >   → NO ACTION : 참조 테이블에 변화가 있어도 기본테이블에는 조치를 취하지 않는다. 
> > >
> > >   → CASCADE : 참조 테이블의 튜플이 삭제 되면 기본테이블의 관련 튜플도 모두 삭제되고, 속성이 변경되면 관련 튜플의 속성 값도 모두 변경된다. 
> > >
> > >   → SET NULL : 참조 테이블에 변화가 있으면 기본 테이블의 관련 튜플의 속성값을 NULL 로 변경한다. 
> > >
> > >   → SET DEFAULT : 참조 테이블에 변화가 있으면 기본 테이블의 관련 튜플의 속성 값을 기본값으로 변경한다. 
> >
> > * CONSTRAINT<BR>: 제약 조건의 이름을 설정한다. 이름을 지정할 필요가 없으면 CHECK절만 사용하여 속성 값에 대한 제약 조건을 명시한다. 
> > * CHECK : 속성 값에 대한 제약조건을 명시한다. 
> >
> > ```SQL
> > /* '이름','학번','전공','성별','생년월일' 로 구성된 <학생> 테이블을 정의하는 sql문을 작성하시오 
> > - '이름'은 NULL이 올 수 없고, '학번'은 기본키이다. 
> > - '전공'은 <학과> 테이블의 '학과코드'를 참조하는 외래키로 사용된다. 
> > - <학과> 테이블에서 삭제가 일어나면 관련된 튜플들의 전공 값을 NULL로 만든다. 
> > - <학과> 테이블에서 '학과코드' 가 변경되면 전공 값도 같은 같으로 변경한다. 
> > - '생년월일'은 1980-01-01 이후의 데이터만 저장할 수 있다. 
> > - 제약 조건의 이름은 '생년월일제약' 으로 한다. 
> > - 각 속성의 데이터 타입은 적당하게 지정한다. 단 '성별'은 도메인 'SEX'를 사용한다. 
> > */
> > 
> > CREATE TABLE 학생
> > 	(이름 VARCHAR(15) NOT NULL,
> >      학번 CHAR(8),
> >      전공 CHAR(5),
> >      성별 SEX, --앞서 DOMAIN 선언시 SEX라는 도메인을 선언한 이후에 가능하다. 
> >      생년월일DATE,
> >      PRIMARY KEY(학번),
> >      FOREIGN KEY(전공) REFERENCES 학과(학과코드)
> >      	ON DELETE SET NULL 
> >      	ON UPDATE CASCADE, 
> >      CONSTRAINT 생년월일제약
> >      	CHECK(생년월일>='1980-01-01'));
> > ```
> >
> > ※ 다른 테이블을 이용한 테이블 정의 (AS SELECT, FROM)
> >
> > > 기본 테이블의 정보를 이용해 새로운 테이블을 정의할 수 있다. 
> >
> > ```sql
> > CREATE TABLE 신규테이블명 AS SELECT 속성명[, 속성명, …] FROM 기존테이블명;
> > 
> > /* <학생> 테이블의 '학번','이름','학년' 속성을 이용하여<재학생> 테이블을 정의하는 SQL문 작성하기 */
> > CREATE TABLE 재학생 AS SELECT 학번, 이름, 학년 FROM 학생;
> > ```
>
> - CREATE VIEW 
>
> > 뷰(VIEW)를 정의하는 명령문
> >
> > ※ 뷰(VIEW)<BR>: 뷰는 테이블처럼 물리적으로 구현되지는 않지만(테이블처럼 실제 데이터가 저장되지 않는다), 뷰 정의시 시스템 내에 저장되었다가 SQL내에서 해당 이름 사용시 실행 시간에 뷰 정의가 대체되어 수행된다. 
> >
> > - SELECT문을 서브 쿼리로 사용하여 SELECT문의 결과로서 뷰를 생성한다. 
> >
> >   →서브쿼리(Sub Query) : 조건절에 주어진 질의로서, 상위 질의에 앞서 실행되며 검색 결과는 상위 질의의 조건절의 피연산자로 사용된다. 
> >
> > - 서브쿼리인 SELECT문에는 UNION(합집합)이나 ORDER BY(정렬) 절을 사용할 수 없다.
> >
> > - 속성명을 기술하지 않으면 SELECT문의 속성명이 자동으로 사용된다.  
>
> ```sql
> CREATE VIEW 뷰명[(속성명[, 속성명, …])]
> AS SELECT문;
> 
> /* <고객> 테이블에서 '주소'가 '안산시' 인 고객들의 '성명' 과 '전화번호' 를 '안산고객' 이라는 뷰로 정의하시오. */
> CREATE VIEW 안산고객(성명, 전화번호)
> AS SELECT 성명, 전화번호 
> FROM 고객 
> WHERE 주소 = '안산시';
> 
> ```
>
> 
>
> - CREATE INDEX
>
> > 인덱스를 정의하는 명령문 
> >
> > * UNIQUE
> >
> > > * 사용된 경우 : 중복 값이 없는 속성으로 인덱스를 생성한다. 
> > > * 생략된 경우 : 중복 값을 허용하는 속성으로 인덱스를 생성한다. 
> >
> > * 정렬 여부 지정 
> >
> > > * ASC : 오름차순 정렬 
> > > * DESC : 내림차순 정렬 
> > > * 생략된 경우 : 자동으로 오름차순(default)
> >
> > * CLUSTER : 사용하면 인덱스가 클러스터드 인덱스로 설정됨 
>
> ```sql
> CREATE [UNIQUE] INDEX 인덱스명
> ON 테이블명(속성명 [ASC|DESC][, 속성명[ASC|DESC]])
> [CLUSTER];
> 
> 
> /* <고객> 테이블에서 UNIQUE한 특성을 갖는 '고객번호' 속성에 대해 내림차순으로 정렬하여 '고객번호_idx'라는 이름으로 인덱스를 정의하시오. */
> CREATE UNIQUE INDEX 고객번호_idx
> ON 고객(고객번호 DESC);
> ```
>
> 
>
> - ALTER TABLE 
>
> > 테이블에 대한 정의를 변경하는 명령문 
> >
> > * ADD : 새로운 속성(열) 을 추가할 때 사용한다. 
> > * ALTER : 특정 속성의 Default 값을 변경할 때 사용한다. 
> > * DROP COLUMN : 특정 속성을 삭제할 때 사용한다. 
>
> ```sql
> ALTER TABLE 테이블명 ADD 속성명 데이터_타입 [DEFAULT '기본값'];
> ALTER TABLE 테이블명 ALTER 속성명 [SET DEFAULT '기본값'];
> ALTER TABLE 테이블명 DROP COLUMN 속성명 [CASCADE];
> 
> /* <학생> 테이블에 최대 3문자로 구성되는 '학년' 속성 추가하시오. */
> ALTER TABLE 학생 ADD 학년 VARCHAR(3);
> 
> /* <학생> 테이블의 '학번' 필드의 데이터 타입과 크기를 VARCHAR(10)으로 하고 NULL값이 입력되지 않도록 변경하시오. */
> ALTER TABLE 학생 ALTER 학번 VARCHAR(10) NOT NULL;
> ```
>
> 
>
> - DROP 
>
> > 스키마, 도메인, 기본 테이블, 뷰 테이블, 인덱스, 제약 조건 등을 제거하는 명령문 
> >
> > * CASCADE : 제거할 요소를 참조하는 다른 모든 개체를 함께 제거한다.<BR>즉 주 테이블의 데이터 제거 시 각 외래키와 관계를 맺고 있는 모든 데이터를 제거하는 참조 무결성 제약 조건을 설정하기 위해 사용된다. 
> > * RESTRICTED : 다른 개체가 제거할 요소를 참조중일 때는 제거를 취소한다. (제거 제한)
>
> ```sql
> DROP SCHEMA 스키마명 [CASCADE|RESTRICTED]; --스키마 제거
> DROP DOMAIN 도메인명 [CASCADE|RESTRICTED]; --도메인 제거 
> DROP TABLE 테이블명 [CASCADE|RESTRICTED];  --테이블 제거 
> DROP VIEW 뷰명 [CASCADE|RESTRICTED];		-- 뷰 제거 
> DROP INDEX 인덱스명 [CASCADE|RESTRICTED];  -- 인덱스 제거 
> DROP CONSTRAINT 제약조건명;  			 -- 제약조건 제거 
> 
> /* <학생>테이블을 제거하되, <학생> 테이블을 참조하는 모든 데이터를 함께 제거하시오. */
> DROP TABLE 학생 CASCADE;
> ```
>
> 
>
> ※예제 풀이
>
> ```plsql
> /* 문제1.
>    아래의 요구사항을 만족하는 테이블 <patient>를 정의하는 SQL문을 작성하시오. 
>    
>    - 'id(문자 5)', 'name(문자 10)', 'sex(문자 1)', 'phone(문자 20)' 속성을 가진다. 
>    - 'id' 속성은 기본키이다. 
>    - 'sex' 속성은 'f' 또는 'm' 값만 갖도록 한다. (제약조건명 : sex_ck).
>    - 'id'는 <doctor> 테이블에 있는 'doc_id'를 참조한다.(제약조건명 : id_fk).  
> */
> 
> CREATE TABLE patient 
> 	(id CHAR(5) PRIMARY KEY,
>      name CHAR(10),
>      sex CHAR(1),
>      phone CHAR(20),
>      
>      CONSTRAINT sex_ck CHECK(sex='f' or sex='m'),
>      CONSTRAINT id_fk FOREIGN KEY(id) REFERENCES doctor(doc_id)
>     
>     );
>    
>    
> --------------------------------------------------------------------------------------
> 
> /* 문제2.
>    아래의 요구사항을 만족하는 테이블 <Instructor>를 정의하는 SQL문을 작성하시오. 
>    
>    - 'id(문자 5)', 'name(문자 15)', 'dept(문자 15)' 속성을 가진다. 
>    - 'id' 속성은 기본키이다. 
>    - 'name' 속성은 Null이 올 수 없다. 
>    - 'dept' 속성은 <Department> 테이블의 'dept' 속성을 참조하는 외래키이다.
>      → <Department> 테이블에서 튜플이 삭제되면 관련된 모든 튜플의'dept' 속성을 값은
>        Null로 변경되어야 한다. 
>      → <Department> 테이블의 'dept' 속성이 변경되면 <Instructor> 테이블의 관련된 모든 
>        속성 값도 같은 값으로 변경되어야 한다. 
> */
> 
> CREATE TABLE Instructor
> 	(id CHAR(5)
>      name CHAR(15) NOT NULL,
>      dept CHAR(15),
>      PRIMARY KEY(id),
>      FOREIGN KEY(dept) REFERENCES Department(name)
>      	
>      	ON DELETE SET NULL
>      	ON UPDATE CASCADE
>     );
>     
>     
>  -------------------------------------------------------------------------------------
>  
>  /* 문제3.
>  	<patient> 테이블에 데이터 타입이 문자 20자리인 'job' 속성을 추가하는 SQL문을 
>  	작성하시오. 
>  */
> 
> ALTER TABLE patient 
> 	ADD job CHAR(20);
> ```
>
> 

**SQL-DCL(데이터 제어어)**

> DCL(데이터 제어어)는 데이터의 보안, 무결성, 회복, 병행 제어 등을 정의하는데 사용하는 언어이다. 
>
> * DCL은 데이터베이스 관리자(DBA)가 데이터 관리를 목적으로 사용한다. 
>
> * DCL에는 GRANT, REVOKE, COMMIT, ROLLBACK, SAVEPOINT 등이 있다. 
>
>   ※ COMMIT, ROLLBACK, SAVEPOINT 들은 TCL(Transaction Control Language)로 분류하기도 한다. 
>
> * GRANT / REVOKE
>
> > 데이터베이스 관리자가 데이터베이스 사용자에게 권한을 부여하거나 취소하기 위한 명령어 
> >
> > ※ 사용자 등급 
> >
> > > * DBA : 데이터베이스 관리자 
> > > * RESOURCE : 데이터베이스 및 테이블 생성 가능자 
> > > * CONNECT : 단순 사용자 
> >
> > * GRANT : 권한 부여를 위한 명령어 
> > * REVOKE : 권한 취소를 위한 명령어 
> > * 사용자 등급 지정 및 해제 구문 
>
> ```plsql
> GRANT 사용자등급 TO 사용자_ID_리스트 [IDENTIFIED BY 암호];
> REVOKE 사용자등급 FROM 사용자_ID_리스트;
> 
> /* 사용자 ID가 "NABI"인 사람에게 데이터베이스 및 테이블을 생성할 수 있는 권한을 부여하는 SQL문을 작성하시오. */
> GRANT RESOURCE TO NABI;
> 
> /* 사용자 ID가 "STAR"인 사람에게 단순히 데이터베이스에 있는 정보를 검색할 수 있는 권한을 부여하는 SQL문을 작성하시오. */
> GRANT CONNECT TO STAR;
> ```
>
> > * 테이블 및 속성에 대한 권한 부여 및 취소 구문 
> >
> > > * 권한종류 : ALL, SELECT, INSERT, DELETE, UPDATE, ALTER 등 
> > > * WITH GRANT OPTION :부여받은 권한을 다른 사용자에게 다시 부여할 수 있는 권한 부여 
> > > * GRANT OPTION FOR : 다른 사용자에게 권한을 부여할 수 있는 권한을 취소함. 
> > > * CASCADE : 권한 취소 시 권한을 부여받았던 사용자가 다른 사용자에게 부여한 권한을 연쇄적으로 취소함 
>
> ```plsql
> GRANT 권한_리스트 ON 개체 TO 사용자 [WITH GRANT OPTION];
> REVOKE [GRANT OPTION FOR] 권한_리스트 ON 개체 FROM 사용자[CASCADE];
> 
> /* 사용자 ID가 "NABI" 인 사람에게 <고객> 테이블에 대한 모든 권한과 다른 사람에게 권한을 부여할 수 있는 권한까지 부여하는 SQL문을 작성하시오. */
> GRANT ALL ON 고객 TO NABI WITH GRANT OPTION;
> 
> /* 사용자 ID가 "STAR"인 사람에게 부여한 <고객> 테이블에 대한 권한 중 UPDATE 권한을 다른 사람에게 부여할 수 있는 권한만 취소하는 SQL문을 작성하시오. */
> REVOKE GRANT OPTION FOR UPDATE ON 고객 FROM STAR;
> ```
>
> 
>
> - COMMIT
>
> > 트랜잭션이 성공적으로 끝나면 데이터베이스가 새로운 일관성(Consistency)상태를 가지기 위해 변경된 모든 내용을 데이터 베이스에 반영하는데, 이때 반영시키기 위한 명령이 COMMIT이다. 
> >
> > * COMMIT 명령을 완료하지 않아도 <u>DML문이 성공적으로 완료되면 자동으로 COMMIT</u>되고, DML이 실패하면 자동으로  ROLLBACK이 되도록 Auto Commit 기능을 설정할 수 있다. 
>
> ```plsql
> /* <사원 테이블에서 '사원번호'가 40인 사원의 정보를 삭제한 후 COMMIT을 수행하시오 */
> DELETE * FROM 사원 WHERE 사원번호 = 40;
> COMMIT;
> ```
>
> 
>
> - ROLLBACK
>
> > 아직 COMMIT되지 않은 변경된 모든 내용들을 취소하고 데이터베이스를 이전 상태로 되돌리는 명령어이다. 
> >
> > * 트랜잭션 전체가 성공적으로 끝나지 못하면 일부 변경된 내용만 데이터베이스에 반영되는 비일관성(Inconsistency)인 상태를 가질 수 있기 떄문에 일부분만 완료된 트랜잭션은 롤백(Rollback)되어야 한다. 
>
> - SAVEPOINT
>
> > 트랜잭션 내에 ROLLBACK할 위치인 저장점을 지정하는 명령어 
> >
> > * 저장점을 지정할 때는 이름을 부여하며, ROLLBACK 시 지정된 저장점까지의 트랜잭션 처리 내용이 취소된다. 
>
> ```plsql
> /* SAVEPOINT 'S2'까지 ROLLBACK을 수행하시오. */
> ROLLBACK TO S2;
> ```
>
> 

**SQL-DML**

**DML-SELECT-1**

**DML-SELECT-2**

**프로시저(Procedure)**

**트리거(Trigger)**

**사용자 정의 함수**

**제어문**

**커서(Cursor)**