#### DDL(Data Define Language): 데이터 정의어 

> - CREATE SCHEMA
>
> > * 스키마를 정의하는 명령문 
> > * 스키마의 식별을 위해 스키마 이름과 소유권자나 허가권자를 정의한다
>
> ``` sql
> CREATE SCHEMA 스키마명 AUTHORIZATION 사용자_id;
> 
> -- ex/ 소유권자의 사용자ID가 '홍길동'인 스키마 '대학교'를 정의하는 SQL문
> CREATE SCHEMA 대학교 AUTHORIZATION 홍길동;
> ```
>
> - CREATE DOMAIN
>
> > * 도메인을 정의하는 명령문 
> > * 도메인이란 하나의 속성이 취할 수 있는 동일한 유형의 원자값들의 집합을 의미 
> > * 임의의 속성에서 취할 수 있는 값의 범위가 SQL에서 지원하는 전체 데이터 타입의 값이 아니고 일부분일 때, 사용자는 그 값의 범위를 도메인으로 정의할 수 있다. 
> > * 정의된 도메인명은 일반적인 데이터 타입처럼 사용한다 
>
> ```sql
> CREATE DOMAIN [AS] 데이터_타입 -- SQL에서 지원하는 데이터 타입
> 	[DEFAULT 기본값] -- 데이터를 읿력하지 않았을 때 자동으로 입력되는 값 
> 	[CONSTRAINT 제약조건명 CHECK (범위값)];
> 	
> -- ex/ '성별'을 
> ```
>
> 
>
> - CREATE TABLE
> - CREATE VIEW
> - CREATE INDEX
> - ALTER TABLE
> - DROP

