## 프로그래밍 언어 활용(C, JAVA, Python)

### 예상 문제 은행 풀이



- 문제 1

  > 프로그램이 언어의 종류 중 하나로, 일련의 처리 절차를 정해진 문법에 따라 순서대로 기술해 나가는 언어이며, 주로 객체지향 프로그래밍 언어와 비교된다. 데이터를 중심으로 프로시져를 구현하며, 프로그램 전체가 유기적으로 연결되어 있는 특징이 있다. 이 설명에 해당하는 프로그래밍 언어의 종류를 쓰시오
  >
  > 답: 절차적 프로그래밍 언어

  

- 문제 2 

> 객체지향 프로그래밍 언어의 구성 요소에는 객체, 클래스, 메시지가 있다. 각 구성요소가 무엇을 의미하는지 간략하게 서술하시오. 
>
> 답: 
>
> 1. 객체 : 속성과 이를 처리하기 위한 메소드를 결합한 소프트웨어 모듈 
> 2. 클래스 : 공통된 특성과 행위를 갖는 객체의 집합. 객체의 유형 또는 타입 의미 
> 3. 메시지 : 객체들 간 상호작용의 수단 



- 문제3

> 객체지향 프로그래밍 언어의 특징 중 하나로, 데이터와 함수를 하나로 묶는 것을 의미한다. 객체의 세부 내용을 외부로부터 은폐함으로써 변경이 발생할 때 오류의 파급 효과를 최소화시키는 기능을 하며, 객체들의 재사용성을 향상시킨다. 이 설명에 해당하는 용어를 쓰시오. 
>
> 답: 캡슐화(Encapsulation)



- 문제4 

> 수치 계산이나 논리 연산에 특화되어 있어 과학 기술 계산용으로 주로 사용되며, PASCAL과 C언어의 모체가 된 절차적 프로그래밍 언어는 무엇인지 쓰시오. 
>
> 답: ALGOL



- 문제5

> 다음 설명에 가장 적합한 프로그래밍 언어의 종류를 쓰시오 
>
> * HTML 문서 안에 직접 프로그래밍 언어를 삽입하여 사용하는 것으로, 기계어로 컴파일 되지 않고 별도의 변역기가 소스를 분석하여 동작하게 하는 언어이다. 
> * 게시판 입력, 상품 검색, 회원 가입 등과 같은 데이터베이스 처리 작업을 수행하기 위해 주로 사용한다. 
> * 클라이언트의 웹 브라우저에서 해석되어 실행되는 클라이언트용 언어와 서버에서 해석되어 실행된 후 결과만 클라이언트로 보내는 서버용 언어가 있다. 
>
> 답: 스크립트 언어 



- 문제6

> 서버용 스크립트 언어의 하나로, Linux, Unix, Windows 운영체제에서 사용된다. C, Java 언어의 문법과 유사하여 배우기 쉽고, 웹페이지 제작에 많이 사용된다. 이 설명에 해당하는 프로그래밍 언어를 쓰시오. 
>
> 답: PHP



- 문제7

> 프로그래밍 언어에 관한 다음 설명을 보고 괄호에 공통적으로 들어갈 가장 적합한 용어를 쓰시오. 
>
> ()는 순차적인 명령 수행을 기본으로 하는 언어로, 문제를 처리하기 위한 방법에 초점을 주고 코드를 작성한다. ()는 폰 노이만 구조에 개념적인 기초를 두고 있으며, 알고리즘을 명시하고 목표는 명시하지 않는다. 절차적 언어와 객체지향 언어가 있으며, 우리가 주로 사용하는 C, Java등이 여기에 속한다. 
>
> 답: 명령형 언어



- 문제8

> 선언형 프로그래밍 언어는 프로그램이 수행해야 할 문제를 기술하는 언어로, 목표를 명시하고 알고리즘은 명시하지 않는 특징이 있다. 선언형 프로그래밍 언어의 종류 중 3가지만 쓰시오. 
>
> 답: (다음 중 3가지) HTML, LISP, PROLOG, XML, Haskell



- 문제9 

> 다음 JAVA로 구현된 프로그램을 분석하여 그 실행 결과를 쓰시오. 
>
> ```java
> public class problem {
>     public static void main(String[] args) {
>         int i, j = 0;
>         for(i=0; i<8; i++) {
>             j += i;
>         }
>         System.out.printf("%d, %d\n", i, j)
>     }
> } 
> ```
>
> 답: 8, 28
>
> 해설:<br>서식 문자열 '%d'에 대응하는 정수 변수 i의 값 8을 출력하고 콤마(,)를 출력한 다음 한 칸 띄고 서식 문자열 '%d'에 대응하는 정수변수 j의 값 28을 출력한다. '\n' 으로 인해 커서는 다음 줄로 이동한다. 



- 문제10

> 다음 C언어로 구현된 프로그램을 분석하여 그 실행 결과를 쓰시오. 
>
> ```c
> #include <stdio.h>
> main() {
>     int a=12, b=8, c=2, d=3;
>     a /= b++ - c * d;
>     printf("%d", a);
> }
> ```
>
> 답: 6
>
> 해설:<br>연산식이 복잡해 질 때는 우선순위에 맞게 괄호로 묶은 다음 계산하면 쉽다. 연산자의 우선순위가 같은 때에는 좌에서 우로, 대입 연산자는 우선순위가 가장 낮다. 
>
> a = a / (b++ - (c*d))<br>   = 12 / (8 - (2 * 3))<br>   = 6 <br>※ b++는 후치 연산이므로 연산에 참여한 후 1을 증가시킨다. 



- 문제11

> 다음 Java로 구현된 프로그램을 분석하여 그 실행 결과를 쓰시오
>
> ```java
> public class Problem{
>     public static void main(string[] args){
>         byte a=15, b=19;
>         System.out.printf("%d\n", ~a);
>         System.out.printf("%d\n", a^b);
>         System.out.printf("%d\n", a&b);
>         System.out.printf("%d\n", a|b);
>     }
> }
> ```
>
> 답:
>
> ```java
> -16
> 28
> 3
> 31 
> // \n이므로 줄바꿈 해주는 것 까지 정확히 해야한다. 
> ```
>
> 해설:
>
> ```java
> System.out.printf("%d\n", ~a)
> /* ~는 각 비트의 부정을 만드는 연산자다(not). Java에서 byte변수는 정수형 1바이트이므로 각 변수의 값을 1바이트 2진수로 변환한 다음 각 비트에 대해 부정연산을 취해준다. 
> 즉, 15 = 0000 1111 → ~15 = 1111 0000 
> Java는 C와 마찬가지로 2의 보수를 사용하므로 맨 왼쪽 비트는 부호 비트이다. 0이면 양수, 1이면 음수이다. 원래의 값을 알기 위해서는 1111 0000 에 대한 2의 보수를 구한다. 0001 0000 은 10진수로 16이고 원래 음수였으므로 -를 붙이면 -16이다. */
>     
> 
> ```
>
> 



- 문제12 

> 다음은 python



