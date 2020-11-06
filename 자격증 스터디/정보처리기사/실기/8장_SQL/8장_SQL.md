

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
> > 

**SQL-DML**

**DML-SELECT-1**

**DML-SELECT-2**

**프로시저(Procedure)**

**트리거(Trigger)**

**사용자 정의 함수**

**제어문**

**커서(Cursor)**