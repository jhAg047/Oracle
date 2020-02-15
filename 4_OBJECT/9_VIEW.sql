-- VIEW(뷰)
-- SELECT쿼리 실행 결과를 화면을 저장한 객체, 논리적인 가상 테이블
-- 실제 데이터를 저장하고 있지 않지만 테이블을 사용하는 것과 동일하게 사용 가능

-- 표현식
-- CREATE [OR REPLACE] VIEW 뷰이름 AS 서브쿼리
-- OR REPLACE : 뷰 생성 시 같은 이름의 뷰가 기존에 존재한다면 해당 뷰를 새롭게 변경
-- OR REPLACE를 사용하지 않고 뷰를 생성 후 같은 이름의 뷰를 또 생성시 이미 다른 객체가 사용중인 이름이라고 에러 발생

-- 사번, 이름, 부서 명, 근무 지역을 조회하고 그 결과를 V_EMPLOYEE라는 뷰를 생성하여 저장
CREATE OR REPLACE VIEW V_EMPLOYEE
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE,NATIONAL_NAME
    FROM EMPLOYEE
    LEFT JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID)
    LEFT JOIN LOCATION ON (LOCATION_ID = LOCAL_CODE)
    LEFT JOIN NATIONAL USING(NATIONAL_CODE);
--  ORA-01031: insufficient privileges : 권한이 없다~
-- 뷰를 생성할때도 권한이 필요함

-- SYSTEM 계정에서 권한 주기
GRANT CREATE VIEW TO KH;

SELECT * FROM V_EMPLOYEE;

COMMIT;

SELECT * 
FROM V_EMPLOYEE
WHERE EMP_ID = 205;

-- EMPLOYEE테이블 에서 사번이 205번인 사원의 이름을 '정중앙'으로 변경
UPDATE EMPLOYEE
SET EMP_NAME = '정중앙'
WHERE EMP_ID = 205;

SELECT * FROM V_EMPLOYEE;
-- 베이스테이블의 정보가 변경되면 VIEW도 변경됨

ROLLBACK;

-- 생성된 뷰 컬럼에 별칭 부여하기 
-- 서브쿼리의 SELECT절에 함수가 사용된 경우는 반드시 별칭 지정(뷰 서브쿼리 안에 연산 결과도 포함 가능)
CREATE OR REPLACE VIEW  V_EMP_JOB(사번,이름,직급,성별,근무년수)
AS SELECT EMP_ID, EMP_NAME,JOB_NAME,
            DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여'),
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE)
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
-- ORA-00998: must name this expression with a column alias : 반드시 컬럼 별칭이 필요하다
-- 서브쿼리에 SELECT절에 함수가 사용된 경우 반드시 별칭을 지정해야하기 때문에

SELECT * FROM V_EMP_JOB;

CREATE OR REPLACE VIEW  V_EMP_JOB
AS SELECT EMP_ID 사번, EMP_NAME 이름,JOB_NAME 직급,
            DECODE(SUBSTR(EMP_NO,8,1),1,'남',2,'여') 성별,
            EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) 근무년수
    FROM EMPLOYEE
        JOIN JOB USING(JOB_CODE);
        
-- 생성된 뷰를 이용해서 DML문 사용 가능
CREATE OR REPLACE VIEW V_JOB
AS SELECT JOB_CODE,JOB_NAME
    FROM JOB;
    
-- 뷰에 INSERT 사용
INSERT INTO V_JOB
VALUES ('J8','인턴');

SELECT * FROM V_JOB;
SELECT * FROM JOB;
-- 뷰에서 요청한 DML 구문은 베이스 테이블도 변경함

-- 뷰에 UPDATE 사용 
UPDATE V_JOB
SET JOB_NAME = '알바'
WHERE JOB_CODE = 'J8';

SELECT * FROM V_JOB;
SELECT * FROM JOB;

-- 뷰에 DELETE 사용
DELETE FROM V_JOB
WHERE JOB_CODE = 'J8';

SELECT * FROM V_JOB;
SELECT * FROM JOB;

COMMIT;

-- 0214(금)
-- DML명령어로 VIEW 조작이 불가능한 경우
-- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
-- 2) 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- 3) 산술표현식으로 정의된 경우
-- 4) 그룹함수나 GROUP BY절을 포함한 경우
-- 5) DISTINCT를 포함한 경우
-- 6) JOIN을 이용해 여러 테이블을 연결한 경우

-- 1) 뷰 정의에 포함되지 않은 컬럼을 조작하는 경우
CREATE OR REPLACE VIEW V_JOB2
AS SELECT JOB_CODE
FROM JOB;

SELECT * FROM V_JOB2;

INSERT INTO V_JOB2 VALUES('J8','인턴');
-- ORA-00913: too many values 

UPDATE V_JOB2
SET JOB_NAME = '인턴'
WHERE JOB_CODE = 'J7';
-- ORA-00904: "JOB_NAME": invalid identifier 

DELETE FROM V_JOB2
WHERE JOB_NAME = '사원';
-- ORA-00904: "JOB_NAME": invalid identifier

-- 2) 뷰에 포함되지 않은 컬럼 중에 베이스가 되는 테이블 컬럼이 NOT NULL 제약조건이 지정된 경우
-- : INSERT에서만 오류 발생
--  JOB_NAME만 가진 V_JOB3뷰 생성
CREATE OR REPLACE VIEW V_JOB3
AS SELECT JOB_NAME 
FROM JOB;

SELECT * FROM V_JOB3;

INSERT INTO V_JOB3 VALUES('인턴'); -- > 베이스테이블 JOB_CODE에 NULL이 들어감
-- 뷰에 INSERT를 할때 베이스테이블에도 들어가는데 테이블에 있는 JOB_CODE는 NULL이 들어갈수가 없는데 VIEW에서 JOB_NAME만 값을 지정해서
-- 베이스테이블에 있는 JOB_CODE에 NULL을 넣으려고 해서 오류

INSERT INTO JOB VALUES('J8','인턴');

SELECT * FROM V_JOB3;

UPDATE V_JOB3
SET JOB_NAME = '알바'
WHERE JOB_NAME = '인턴';

SELECT * FROM V_JOB3;
SELECT * FROM JOB;

DELETE FROM V_JOB3
WHERE JOB_NAME = '알바';

SELECT * FROM V_JOB3;
SELECT * FROM JOB;

-- 3) 산술표현식으로 정의된 경우
-- 사번, 사원 명, 급여, 보너스가 포함된 연봉으로 이루어진 EMP_SAL 뷰 생성
CREATE OR REPLACE VIEW EMP_SAL
AS SELECT EMP_ID,EMP_NAME,SALARY,
    (SALARY + (SALARY*NVL(BONUS,0)))*12 연봉
FROM EMPLOYEE;

SELECT * FROM EMP_SAL;

INSERT INTO EMP_SAL VALUES(800,'정진훈',3000000,36000000);
-- ORA-01733: virtual column not allowed here
-- 산술표현식이 포함된 연봉때문에 안됨~~!~!연봉은 SALARY와 BONUS로 계산하는건데 바로 3600만원으로 지정해버려서 오류

UPDATE EMP_SAL
SET 연봉 = 8000000
WHERE EMP_ID = 200;
-- ORA-01733: virtual column not allowed here 
-- 계산을 통해 나와야하는 값을 지정해서 넣으려고 해서 오류 발생

COMMIT;

DELETE FROM EMP_SAL
WHERE 연봉 = 124800000;
-- 계산할 필요 없이 일치되는 값으로만 찾아서 삭제가 가능하다~!

SELECT * FROM EMP_SAL;
SELECT * FROM EMPLOYEE;

ROLLBACK;

-- 4) 그룹함수나 GROUP BY절을 포함한 경우
-- 부서 코드, 부서 코드 별 급여 합계, 부서 코드 별 급여 평균을 가지고 있는 V_GROUPDEPT 뷰 생성
--                (합계)                 (평균)
CREATE OR REPLACE VIEW V_GROUPDEPT
AS SELECT DEPT_CODE,SUM(SALARY) 합계,AVG(SALARY) 급여
    FROM EMPLOYEE
    GROUP BY DEPT_CODE;

SELECT * FROM V_GROUPDEPT;

INSERT INTO V_GROUPDEPT
VALUES('D10',6000000,4000000);
-- ORA-01733: virtual column not allowed here 
-- SUM,AVG 그룹함수

UPDATE V_GROUPDEPT
SET DEPT_CODE = 'D10'
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_GROUPDEPT
WHERE DEPT_CODE = 'D1';
-- ORA-01732: data manipulation operation not legal on this view

-- 5) DISTINCT를 포함한 경우
CREATE OR REPLACE VIEW V_DT_EMP
AS SELECT DISTINCT JOB_CODE
FROM EMPLOYEE;

SELECT * FROM V_DT_EMP;

INSERT INTO V_DT_EMP VALUES('J9');
-- ORA-01732: data manipulation operation not legal on this view

UPDATE V_DT_EMP
SET JOB_CODE = 'J9'
WHERE JOB_CODE = 'J7';
-- ORA-01732: data manipulation operation not legal on this view

DELETE FROM V_DT_EMP
WHERE JOB_CODE = 'J1';
-- ORA-01732: data manipulation operation not legal on this view

-- 6) JOIN을 이용해 여러 테이블을 연결한 경우
-- 사번, 사원 명, 부서 명 정보를 가지고 있는 V_JOINEMP 뷰 생성
CREATE OR REPLACE VIEW V_JOINEMP
AS SELECT EMP_ID,EMP_NAME,DEPT_TITLE
    FROM EMPLOYEE
    JOIN DEPARTMENT ON (DEPT_CODE = DEPT_ID);

SELECT * FROM V_JOINEMP;

INSERT INTO V_JOINEMP VALUES(888,'조세오','인사관리부');
-- ORA-01776: cannot modify more than one base table through a join view
-- 조인을 이용해서 만든 뷰는 DML문 불가!

UPDATE V_JOINEMP
SET DEPT_TITLE = '인사관리부'
WHERE EMP_ID = 219;
-- ORA-01779: cannot modify a column which maps to a non key-preserved table

COMMIT;

DELETE FROM V_JOINEMP
WHERE EMP_ID = 219;
-- DELETE는 가능 

SELECT * FROM V_JOINEMP;
SELECT * FROM EMPLOYEE;
SELECT * FROM DEPARTMENT; -- EMP_ID를 통해서 삭제한거여서 DEPARTMENT에는 지장없음

ROLLBACK;

SELECT * FROM USER_VIEWS;
-- 실제로 테이블에서 가지고 온게 아니라 TEXT에서 가지고 온거

-- VIEW 옵션
-- VIEW 생성 표현식
-- CREATE [OR REPLACE] [FORCE | NOFORCE] VIEW 뷰이름 [(alias[, alias])]
-- AS SUBQUERY
-- [WITH CHECK OPTION]
-- [WITH READ ONLY];

-- 1) OR REPLACE 옵션 : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
-- 2) FORCE / NOFORCE 옵션
--          FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
--            NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본 값)
-- 3) WITH CHECK OPTION 옵션 : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
-- 4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능

-- 1) OR REPLACE 옵션 : 기존에 동일한 뷰 이름이 존재하는 경우 덮어쓰고, 존재하지 않으면 새로 생성
-- 주민번호와 사원 명 정보를 가지고 있는 V_EMP1 뷰 생성
CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO,EMP_NAME
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE OR REPLACE VIEW V_EMP1
AS SELECT EMP_NO,EMP_NAME,SALARY
FROM EMPLOYEE;

SELECT * FROM V_EMP1;

CREATE VIEW V_EMP1
AS SELECT EMP_NO,EMP_NAME
FROM EMPLOYEE;
-- ORA-00955: name is already used by an existing object 이미 사용중이다~! OR REPLACE 없어서 덮어쓰기 불가!!!!

-- 2) FORCE / NOFORCE 옵션 : 지정안하면 NOFORCE가 기본 옵션
--          FORCE : 서브쿼리에 사용된 테이블이 존재하지 않아도 뷰 생성
CREATE OR REPLACE VIEW V_EMP2
AS SELECT TCODE, TNAME,TCONTENT
    FROM TT;
-- ORA-00942: table or view does not exist 존재하지 않는 테이블이나 뷰
CREATE OR REPLACE FORCE VIEW V_EMP2
AS SELECT TCODE, TNAME,TCONTENT
    FROM TT;
-- 경고: 컴파일 오류와 함께 뷰가 생성되었습니다.

SELECT * FROM V_EMP2; -- 에러있음 진짜 딱 생성만 된거여서 아무것도 할수가 읎다!
SELECT * FROM USER_VIEWS;
--            NOFORCE : 서브쿼리에 사용된 테이블이 존재해야만 뷰 생성(기본 값)
CREATE OR REPLACE /*NOFORCE*/ VIEW V_EMP2
AS SELECT TCODE, TNAME,TCONTENT
    FROM TT;
-- ORA-00942: table or view does not exist  

-- 3) WITH CHECK OPTION 옵션 : 옵션을 설정한 컬럼의 값을 수정 불가능하게 함
CREATE OR REPLACE VIEW V_EMP3
AS SELECT * 
    FROM EMPLOYEE
    WHERE DEPT_CODE = 'D9' WITH CHECK OPTION; -- DEPT_CODE에만 WITH CHECK옵션 들어감
SELECT * FROM V_EMP3;

UPDATE V_EMP3
SET DEPT_CODE = 'D1'
WHERE EMP_ID = 200;
-- ORA-01402: view WITH CHECK OPTION where-clause violation / CHECK옵션 위배

COMMIT;

UPDATE V_EMP3
SET EMP_NAME = '선동이'
WHERE EMP_ID = 200;
-- EMP_NAME은 CHECK 옵션이 안들어가 있어서 사용가능 

SELECT * FROM V_EMP3;

ROLLBACK;

-- 4) WITH READ ONLY 옵션 : 뷰에 대해 조회만 가능
CREATE OR REPLACE VIEW V_DEPT
AS SELECT * FROM DEPARTMENT
WITH READ ONLY;

SELECT * FROM V_DEPT;

DELETE FROM V_DEPT;
-- ORA-42399: cannot perform a DML operation on a read-only view : READ ONLY뷰는 DML문 불가
