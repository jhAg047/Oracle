-- 함수(FUNCTION) : 컬럼의 값을 읽어서 계산한 결과 리턴 
-- 단일 행 함수 (SINGLE ROW FUNCTION)
--      N개의 값을 넣어서 N개의 결과 리턴
-- 그룹 함수 (GROUP FUNCTION)
--      N개의 값을 넣어서 한 개의 결과 리턴 
-- SELECT절에 단일행 함수와 그룹 함수를 함께 사용 못 함 : 결과 행의 개수가 다르기 때문

-- 단일 행 함수 
SELECT LENGTH(EMP_NAME)
FROM EMPLOYEE;

-- 그룹 함수
SELECT COUNT(EMP_NAME)
FROM EMPLOYEE;

-- 동시 사용
--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM EMPLOYEE;
-- not a single-group group function : 반환하는 개수가 같아야하는데 달라서 오류

-- 함수를 사용할 수 있는 위치
-- SELECT절, WHERE절, GROUP BY절, HAVING절, ORDER BY절

-- 단일 행 함수 
-- 1. 문자 관련 함수

-- LENGTH / LENGTHB
-- LENGTH(컬럼명 | '문자열') : 글자 수 반환
-- LENGTHB(컬럼명 | '문자열') : 글자의 바이트 사이즈 반환

-- 오라클은 한글은 3바이트로 인식함
SELECT LENGTH('오라클'), LENGTHB('오라클')
FROM DUAL; -- 가상 테이블
-- 3 / 9

SELECT EMAIL,LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : 해당 문자열의 위치 / 해당하는 문자열이 없으면 0 반환
-- 오라클은 제로인덱스 기반 XXXXXXXXXXXXXXX
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B',1) FROM DUAL; -- 1번째부터 읽기 시작해서 처음으로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'B',-1) FROM DUAL; -- -1번째(끝)부터 읽기 시작해서 처음으로 나오는 B의 위치 반환 / 근데 위치는 처음부터 카운트
SELECT INSTR('AABAACAABBAA', 'C',-1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B',1,2) FROM DUAL; -- 1번째부터 읽기 시작해서 두번째로 나오는 B의 위치를 반환 
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- 끝에서부터 읽기 시작해서 두번째로 나오는 B의 위치 반환
SELECT INSTR('AABAACAABBAA', 'C',1,2) FROM DUAL; -- 1번째부터 읽기 시작해서 두번재로 나오는 C의 위치를 반환 / 없어서 0 반환

-- EMPLOYEE테이블에서 이메일의 @ 위치 반환
SELECT EMAIL, INSTR(EMAIL, '@') 
FROM EMPLOYEE;

--0205(수)

-- LPAD / RPAD : 주어진 컬럼이나 문자열에 임의의 문자열을 왼쪽/오른쪽에 덧붙여 길이 N의 문자열 반환
-- 지정한 만큼 자리를 만들고 공백이나 지정한 문자로 공백을 채움
SELECT LPAD(EMAIL, 20) -- 아무것도 지정안해서 공백으로 채움 
FROM EMPLOYEE;

SELECT LPAD(EMAIL,20, '#') -- 20자리를 만들어놓고 빈공간을 #으로 채우겠다!
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

-- LTRIM/RTRIM/TRIM : 주어진 컬럼이나 문자열의 왼쪽 또는 오른쪽 또는 앞/뒤/양쪽에서 지정한 문자 제거
SELECT LTRIM('   KH') FROM DUAL; -- 왼쪽 공백 제거 / 삭제할 문자열을 지정하지 않았을 경우 공백이 디폴트가 됨
SELECT LTRIM('   KH', ' ') FROM DUAL; -- 이건 지정한거 
SELECT LTRIM('000123456', '0') FROM DUAL; -- 123456 
SELECT LTRIM('123123KH','123') FROM DUAL; -- KH
SELECT LTRIM('123123KH123','123') FROM DUAL; -- KH123
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- KH 왜죠? ABC를 하나하나씩 쪼개서 보기때문에 
SELECT LTRIM('5781KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL; -- 오른쪽부터 삭제 / KH
SELECT RTRIM('123456000' ,'0') FROM DUAL; -- 123456
SELECT RTRIM('KHACABACC','ABC') FROM DUAL; -- KH

SELECT TRIM('   KH   ') FROM DUAL; -- KH
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
-- SELECT TRIM (제거할 문자열 FROM 문자열 ) TRIM만 사용방법이 다름
-- TRIM은 한글자밖에 삭제 못함~!
--SELECT TRIM('1' FROM '123132KH123321') FROM DUAL; 한글자만 제거 가능
-- TRIM 위치 지정하기
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- Z: 앞 (LEADING)
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- 뒤 (TRAILING)
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZZ') FROM DUAL; -- 양 쪽 (BOTH)

-- SUBSTR : 컬럼이나 문자열에서 지정한 위치부터 지정 개수의 문자열을 잘라내 반환
SELECT SUBSTR('SHOWMETHEMONEY','7') FROM DUAL; -- 시작지점은 지정하되 끝지점을 지정안하면 끝까지 반환
SELECT SUBSTR('SHOWMETHEMONEY',5,2) FROM DUAL; -- 5번째부터 2개 잘라서 반환
SELECT SUBSTR('SHOWMETHEMONEY',5,0) FROM DUAL; -- 5번째부터 0개 반환 : NULL
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL; -- 1번째부터 6개 반환
SELECT SUBSTR('SHOWMETHEMONEY',-8,3) FROM DUAL; -- 뒤에서 8번째부터 3개 반환 : THE
SELECT SUBSTR('SHOWMETHEMONEY',-10,2) FROM DUAL; 

-- EMPLOYEE테이블에서 이름, 이메일, @이후를 제외한 아이디 조회
SELECT EMP_NAME 이름,EMAIL 이메일, SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) "@제외한 이메일"
--SELECT RTRIM(EMAIL,'@kh.or.kr')
FROM EMPLOYEE;

-- 주민등록번호에서 성별을 나타내는 부분만 잘라보기
SELECT SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE;

-- EMPLOYEE 테이블에서 직원들의 주민번호를 이용하여 사원 명, 생년, 생월, 생일 조회
SELECT EMP_NAME,SUBSTR(EMP_NO,1,2) 생년,SUBSTR(EMP_NO,3,2) 생월,SUBSTR(EMP_NO,5,2) 생일
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- 모두 다 소문자
SELECT UPPER('Welcome To My World') FROM DUAL; -- 모두 다 대문자
SELECT INITCAP('welcome to my world') FROM DUAL; -- 띄어쓰기만 기준으로 앞글자만 대문자로 변경

-- CONCAT : 문자열/컬럼 합치기~~!
SELECT CONCAT('가나다라','ABCD') FROM DUAL;
SELECT '가나다라' || 'ABCD' FROM DUAL;

-- REPLACE 
SELECT REPLACE('서울시 강남구 역삼동', '역삼동','삼성동') FROM DUAL;
SELECT REPLACE('서정호 학생의 별명은 군인일까요?','군인','에코') FROM DUAL;

-- EMPLOYEE테이블에서 이메일의 도메인을 gmail.com으로 변경하기
SELECT EMAIL 변경전, REPLACE(EMAIL,'kh.or.kr','gmail.com') FROM EMPLOYEE;

-- EMPLOYEE테이블에서 사원 명, 주민번호 조회
-- 단, 주민번호는 생년월일- 성별까지만 보이게 하고 나머지 값은 '*'으로 바꾸기 EX.010114-2******
SELECT EMP_NAME,REPLACE(EMP_NO,SUBSTR(EMP_NO,9),'******')
FROM EMPLOYEE;

SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8), '******')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14, '*')
FROM EMPLOYEE;

-- 2. 숫자 관련 함수
-- ABS : 절대 값(양수)을 리턴해주는 함수
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : 나머지 값을 반환
-- 무조건! 나누어지는 수에 음수가 들어가면 음수 반환
SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- 1 
SELECT MOD(10.9,3) FROM DUAL; -- -1.9
SELECT MOD(-10.9,3) FROM DUAL; -- -1.9

SELECT MOD(-10,-3) FROM DUAL; -- -1 -10의 부호를 따라가기 때문에

-- ROUND : 반올림 / 소수는 제로인덱스 기반
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678,0) FROM DUAL; -- 124
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -2) FROM DUAL; -- 100 // 10의 자리

-- 번외
SELECT ROUND(-10.61) FROM DUAL; -- 음수는 반올림되는수가 1,2,3,4 // -11

-- FLOOR : 내림(수학적)
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC : 버림(절삭)
SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(123.678) FROM DUAL; -- 123
SELECT TRUNC(123.456, 1) FROM DUAL; -- 소수 2번째자리에서 버림
SELECT TRUNC(123.456, -1) FROM DUAL; -- 1의 자리에서 버림

-- CEIL : 올림
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124

-- 3. 날짜 관련 함수
-- SYSDATE : 오늘 날짜 반환

-- MONTHS_BETWEEN : 날자와 날짜 사이의 개월 수 차이를 숫자로 리턴하는 함수
-- EMPLOYEE테이블에서 사원의 이름, 입사일, 근무 개월 수 조회
SELECT EMP_NAME,HIRE_DATE,ABS(MONTHS_BETWEEN(HIRE_DATE,SYSDATE))
FROM EMPLOYEE;

-- ADD_MONTHS : 날짜에 숫자만큼의 개월 수를 더해 날짜 리턴
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; -- 20/07/05
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL; -- 21/05/05 12월달이 넘어가면 알아서 내년으로 바뀜

-- NEXT_DAY : 기준 날짜에서 구하려는 요일에 가장 가장 가까운 날자를 리턴하는 함수 
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목요일') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- 일 월 화 수 목 금 토
-- 1  2  3  4  5 6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '목') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, '화진씨는 지금 무슨 생각을 하고 있을까?') FROM DUAL; -- 첫번째 글자에 화가 있어서 화요일 나옴
SELECT SYSDATE, NEXT_DAY(SYSDATE, '연화시도 자기 이름이 되는지 궁금하겠지') FROM DUAL; -- 첫번째 글자가 요일이 안들어가있어서 오류
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- 설정값 바꾸기 : 영어
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- 가능
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL; -- 가능 
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- 설정값 바꾸기 : 한글

-- LAST_DAY : 해당 월에 마지막 날짜 리턴
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20/12/15') FROM DUAL;
-- EXTRACT : 날자에서 년, 월, 일 추출하여 리턴
-- EXTRACT(YEAR FROM 날짜)
-- EXTRACT(MONTH FROM 날짜)
-- EXTRACT(DAY FROM 날짜)

-- EMPLOYEE테이블에서 사원의 이름, 입사 년, 입사 월, 입사 일 조회
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) 입사년도,
                EXTRACT(MONTH FROM HIRE_DATE) 입사월,
                EXTRACT(DAY FROM HIRE_DATE) 입사일
FROM EMPLOYEE;

-- 4. 형 변환 함수 
-- TO_CHAR(날짜[, 포맷]) : 날짜형 데이터를 문자형 데이터로 바꿈
-- TO_CHAR(숫자[, 포맷]) : 숫자형 데이터를 문자형 데이터로 바꿈
SELECT TO_CHAR(1234) ㅇ FROM DUAL;
SELECT TO_CHAR(1234, '99999') ㅇ  FROM DUAL; -- 5칸을 생성하고 오른쪽 정렬, 빈칸 공백
SELECT TO_CHAR(1234, '00000') ㅇ FROM DUAL; -- 5칸을 생성하고 오른쪽 정렬이고 빈칸을 0으로 표시 
SELECT TO_CHAR(1234,'FML99999') ㅇ FROM DUAL; -- 공백을 제거하고 원으로 표기
SELECT TO_CHAR(1234,'$99999') ㅇ FROM DUAL; -- 공백을 만들고 $으로 표기
SELECT TO_CHAR(1234,'FM$99999') ㅇ FROM DUAL; -- 공백을 제거하고 $으로 표기
SELECT TO_CHAR(1234, '99,999') ㅇ FROM DUAL; 
SELECT TO_CHAR(1234, 'FM99,999') ㅇ FROM DUAL;
SELECT TO_CHAR(1234, '00,000') ㅇ FROM DUAL;
SELECT TO_CHAR(1234, 'FM00,000') ㅇ FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') O FROM DUAL; -- 지수 형식으로 표현
SELECT TO_CHAR(1234, '999') ㅇ FROM DUAL; 

-- 날짜를 문자로 
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- 오후 20:04:54
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- 오후 08:05:01
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; -- 2월  수, 2020
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2020-02-05 수요일
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- 2020-2-5 수요일 FM은 뒤에까지 영향을 미침
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '분기' FROM DUAL; -- TWENTY TWENTY, 1 = 분기  // 영어표기법
SELECT TO_CHAR(SYSDATE, 'YYYY"년" MM"월" DD"일" DAY') FROM DUAL; -- 2020년 02월 05일 수요일

-- 오늘 날짜에 대해 연도 출력
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
--          2020                      20                       TWENTY TWENTY
FROM DUAL;

-- 월 출력 
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
--           02                         2월                     2월                      II  -> 로마자 표기
FROM DUAL;

-- 일 출력
SELECT TO_CHAR(SYSDATE, 'DDD'), -- 년 기준으로 일째
       TO_CHAR(SYSDATE,'DD'),  -- 달 기준으로 일째
       TO_CHAR(SYSDATE,'D') -- 주 기준으로 일째
FROM DUAL;

-- 분기, 요일 출력
SELECT TO_CHAR(SYSDATE, 'Q'), -- 분기 
       TO_CHAR(SYSDATE, 'DAY'), -- 요일 (수요일)
       TO_CHAR(SYSDATE, 'DY') -- 요일(수)
FROM DUAL;

-- TO_DATE : 문자/숫자형 데이터 -> 날짜형 데이터
-- 오라클에서 기본적으로 날짜 출력할때는 2글자가 기본
SELECT TO_DATE('20100101','YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101,'YYYYMMDD') FROM DUAL;

-- 2010 01 01 ==> 2010, 1월
SELECT TO_CHAR(TO_DATE('20100101','YYYYMMDD'),'YYYY, MON') A -- TO_DATE('20100101','YYYYMMDD') 날짜 형식
FROM DUAL;

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM') A -- 04-10월-30 02:30:00 오후
FROM DUAL;

-- RR과 YY의 차이 
-- 공통점 : 년도를 표시하는거
-- YY : 2자리 년도에 현재세기를 맞춰서 넣어줌
-- RR : 2자리 년도가 50년 이상이면 이전세기(20세기)// 50년 미만이면 현재세기가 적용
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'), 'YYYYMMDD') A , -- 20980630
       TO_CHAR(TO_DATE('140918','YYMMDD'), 'YYYYMMDD') B, -- 20140918
       TO_CHAR(TO_DATE('980630','RRMMDD'), 'YYYYMMDD') C, -- 19980630
       TO_CHAR(TO_DATE('140918','RRMMDD'), 'YYYYMMDD') D -- 20140918
FROM DUAL;

-- TO_NUMBER : 문자형 데이터를 숫자형 데이터로 바꿔주는 함수 
-- 기본적으로 오라클에서 숫자만 있는 문자는 알아서 바꿔서 계산해줌
SELECT TO_NUMBER('123456789') A FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL; -- 에러
SELECT '1,000,000' + '550,000' FROM DUAL; -- 에러 
SELECT TO_NUMBER('1,000,000','99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000','99,999,999') + TO_NUMBER('550,000','999,999') A FROM DUAL;

-- 5. NULL 처리 함수 
-- NVL(컬럼명, 컬럼 값이 NULL일 때 바꿀 값)

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'없습니다')
FROM EMPLOYEE;

-- NVL2(컬럼 명, 바꿀 값1, 바꿀 값2) / 컬럼값이 NULL이 아니면 바꿀 값1로 바꾸고 NULL이면 바꿀 값2로 바꾼다
-- EMPLOYEE테이블에서 보너스가 NULL인 직원은 0.5로 NULL이 아닌 직원은 0.7로 변경하여 조회
SELECT EMP_NAME,BONUS,NVL2(BONUS,0.7,0.5)
FROM EMPLOYEE;

-- NULLIF(비교대상1, 비교대상2) : 두 개의 값이 동일하면 NULL, 동일하지 않으면 비교대상1 리턴
SELECT NULLIF(123,123) FROM DUAL; -- (null)
SELECT NULLIF(123,124) FROM DUAL; -- 123

-- 6. 선택함수 : 여러 가지 경우 선택할 수 있는 기능 제공
-- DECODE(계산식|컬럼명, 조건값1, 선택값1, 조건값2, 선택값2...,Default)
-- 비교하고자하는 값 또는 컬럼이 조건식과 같으면 결과 값 반환
SELECT EMP_ID, EMP_NAME,EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1,'남',2,'여') 성별 
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1,'남','여') 성별 -- 1이 아니면 여자 
FROM EMPLOYEE;
-- 마지막 인자로 조건 값 없이 선택 값을 작성하면 
-- 아무 것도 해당되지 않을 때 마지막에 작성한 선택값을 무조건 선택함

-- CASE WHEN 조건식 THEN 결과 값
--        WHEN 조건식 THEN 결과 값
--        ELSE 결과 값
-- END
-- 비교하고자 하는 값 또는 컬림이 조건식과 같으면 결과 값 반환(조건은 범위 가능)
SELECT EMP_ID,EMP_NAME,EMP_NO,
        CASE WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '남'
            ELSE '여'
        END 성별
FROM EMPLOYEE;

-- 급여가 500만원을 초과하면 1등급, 350만원을 초과하면 2등급, 200만 초과 3등급, 나머지 4등급
SELECT EMP_ID,EMP_NAME,SALARY,
    CASE WHEN SALARY > 5000000 THEN '1등급'
        WHEN SALARY > 3500000 THEN '2등급'
        WHEN SALARY > 2000000 THEN '3등급'
        ELSE '4등급'
        END 등급
FROM EMPLOYEE;

-- 그룹함수 : 여러 행을 넣으면 한개의 결과 반환
-- SUM(숫자가 기록된 컬럼) : 합계 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 총합 조회
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- 남자 사원의 총합 급여
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- AVG(숫자가 기록된 컬럼) : 평균 리턴
-- EMPLOYEE테이블에서 전 사원의 급여 평균 조회
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT SUM(BONUS)
FROM EMPLOYEE;

SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
-- NULL값을 가진 행은 평균 계산에서 제외 되어 계산

-- MIN / MAX : 최대 / 최대
-- 문자 숫자 날짜 다 들어갈수 있음
-- EMPLOYEE테이블에서 가장 적은 급여, 알파벳 순서가 가장 빠른 이메일, 가장 빠른 입사일
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE테이블에서 가장 많은 급여, 알파벳 순서가 가장 마지막인 이메일, 가장 느린 입사일
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | 컬럼명) : 행의 개수 리턴 
-- COUNT(DISTINCT 컬럼명) : 중복을 제거한 행 개수 리턴
-- COUNT(*) : NULL을 포함한 전체 행 개수 리턴
-- COUNT(컬럼명) : NULL을 제외한 전체 행 개수 리턴
SELECT COUNT(*),COUNT(DEPT_CODE),COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;