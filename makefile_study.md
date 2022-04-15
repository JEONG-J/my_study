# make & Makefile

## 1) make와 Makefile 이란?
`Makefile`이 있는 디렉터리에서 make만 치면 컴파일이 된다.

이유 : `make`는 파일 관리 유틸리이기 때문이다

`make`란?
> 파일 간의 종속관계를 파악하여 Makefile에 적힌 대로 컴파일러에 명령하여  SHELL 명령이 순차적으로 실행될 수 있게 된다.

<br>

## 2) make를 쓰는 이유
`장점`
> ∙ 각 파일에 대한 반복적 명령의 자동화로 인한 시간 절약 <br>
> ∙ 프로그램의 종속 구조를 빠르게 파악할 수 있으며 관리가 용이 <br>
> ∙ 단순 반복 작업 및 재작성 최소화 <br>
> ∙ 입력파일 변경 시 결과파일 자동 변경을 원할 때 지능적인 배치작업

<br>

## 3) 연습

<img width="786" alt="스크린샷 2022-04-15 오후 6 01 05" src="https://user-images.githubusercontent.com/80624315/163552031-7eb8d31d-fc6a-4c8f-bfb9-13324d2c5c34.png">

<br>

> 위의 그림대로 파일을 생성하여 make로 실행 파일을 생성할 것이다.

<br>

### **1. test.h 헤더파일 만들기**

> vi test.h
> 
```c
    //test.h
    #include <stdio.h>
    void memo();
```

<br>

### **2. C 파일들 만들기**

> vi memo.c <br>
> vi main.c
```c
    //memo.c
    #include "test.h"
    void memo(){
        printf("hi, this file name is memo.c \n");
    }
```

```c
    //main.c
    #include "test.h"
    int main(void){
        memo();
        printf("end\n");
    }
```

<br>

### **3. 생성된 파일 확인하기**

> ls

<img width="276" alt="스크린샷 2022-04-15 오후 6 36 34" src="https://user-images.githubusercontent.com/80624315/163554960-c78a3e4b-d588-4812-9c38-2a71a880b199.png">

<br>

### **4. object 파일 생성하기**

> gcc memo.c -c -o memo.o <br>
> gcc main.c -c -o main.c <br>

-c : 오브젝트 파일 생성 옵션 <br>
-o : 생성될 파일 이름 지정 옵션 <br>

### **5. 생성된 파일 확인하기**

> ls

<br>

<img width="316" alt="스크린샷 2022-04-15 오후 6 41 13" src="https://user-images.githubusercontent.com/80624315/163555560-a4be627f-bffe-43fb-85ef-c18815a0c50f.png">

<br>

### **6. object 파일들 컴파일하여 test_file 실행 파일 생성하기**

> gcc memo.o main.o -o test_file

그럼 test_file이 생성되었을 것이다!!

<br>

### **7. test_file 실행하기**

> ./test_file

<br>

<img width="316" alt="스크린샷 2022-04-15 오후 6 46 54" src="https://user-images.githubusercontent.com/80624315/163556164-7065a26d-4012-4554-a225-6fe6fed84ddd.png">

<br>

> 수많은 파일을 이렇게 하나하나 컴파일 하게 된다면 많은 시간을 소모하게 될 것이다. 그래서 이러한 상황을 해결하는 것이 `make`와 `Makefile`이다.


## 4) Makefile 구성

> 목적파일(TARGET) : 명령어가 수행되어 나온 결과 저장할 파일 <Br>
> 의존성(DEPENDENCY) : 목적파일 만들기 위해  필요한 파일 <br>
> 명령어(COMMAND) : 실행되어야 할 명령어 <br>
> 매크로(MACRO) : 코드를 단순화 시키기 위한 방법

<br>

## 5) Makefile 기본구조
```Makefile
CC = gcc # 매크로 정의

target1 : dependency1 dependency2 # 타켓절 : 의존성
        command1 # 명령어
        command2
```
<br>

## 6) Makefile 작성하기

> vi Makefile

```Makefile
test_file : memo.o main.o
        gcc memo.o main.o -o test_file

memo.o : memo.c
        gcc memo.c -c -o memo.o

main.o : main.c
        gcc main.c -c -o main.o

clean :
        rm *.o test_file #더미타켓
```

더미타겟 실행법
> make clean

<br>

`make`로 `Makefile` 실행하기
> make

일일이 컴파일 한 것과 같은 결과를 얻을 수 있다

<br>

## 7) Makefile 매크로 사용

작성 규칙
> 매크로 참조할 때 소괄호나 중괄호 앞에 `$` 붙인다. <br>
> 탭으로 시작해서는 안된다. <br>
> 치환될 위치보다 먼저 정의

<br>

```Makefile
CC = gcc
TARGET = test_file

$(TARGET) : memo.o main.o
        gcc memo.o main.o -o $(TARGET)

memo.o : memo.c
        gcc memo.c -c -o memo.o

main.o : main.c
        gcc main.c -c -o main.o

clean :
        rm *.o test_file #더미타켓
```

## 8) Makefile 내부 매크로 사용

```Makefile
CC = gcc
TARGET = test_file
OBJECTS = memo.o main.o

all : $(TARGET)

$(TARGET) : $(OBJECTS)
        $(CC) $^ -o $@

clean :
        rm *.o test_file #더미타켓
```
<br>

내부 매크로
> `$@` : 현재 타켓의 이름 <br>
> `$^` : 현재 타켓의 종속 항목 리스트

<br>

# End






