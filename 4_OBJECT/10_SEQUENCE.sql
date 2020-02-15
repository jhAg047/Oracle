-- 시퀀스(SEQUENCE) : 자동 번호 발생기
CREATE SEQUENCE SEQ_EMPID -- 시퀀스 이름지정
START WITH 300 -- 시작 숫자 300
INCREMENT BY 5 -- 증가 숫자 5
MAXVALUE 310 -- 최대 숫자 310
NOCYCLE -- 사이클을 돌지 않겠다
NOCACHE; -- 메모리 상에서 관리하지 않겠다

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE 사용
-- 시퀀스명.CURRAVAL : 현재 생성된 시퀀스 값
-- 시퀀스명.NEXTVAL : 시퀀스를 증가시키거나 최초로 시퀀스를 실행
--                   ------------- 시퀀스명.NEXTVAL = 시퀀스명.CURRVAL + INCREMENT로 지정한 값

SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- NEXTVAL로 시퀀스를 실행하지 않아서 뜨는 오류~!

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- SEQ_EMPID.NEXTVAL이 MAXVALUE를 초과해서 또 생성할수가 없다!
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- 성공적으로 호출된 마지막 NEXTVAL의 값 저장

-- CURRVLA / NEXTVAL 사용 가능 및 불가능
-- 사용가능
--      서브쿼리가 아닌 SELECT문
--      INSERT문의 SELECT절
--      INSERT문의 VALUES절
--      UPDATE문의 SET절
-- 사용 불가능
--        VIEW의 SELECT절
--        DISTINCT키워드가 있는 SELECT문
--        GROUP BY, HAVING, ORDER BY절의 SELECT문
--        SELECT , UPDATE , DELETE문의 서브쿼리
--        CREATE TABLE, ALTER TABLE의 DEFAULT 값

-- 시작 숫자가 300이고 증가 값은 1이며 최대 숫자가 10000인 비순환 및 캐시 사용을 안하는 SEQ_EID 시퀀스 생성
CREATE SEQUENCE SEQ_EID
START WITH 300
--INCREMENT BY 1 / 1이여서 생략가능
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, '홍길동', '666666-6666666','hong_gd@kh.or.kr','01066666666','D2','J7','S1',
        5000000,0.1,200,SYSDATE,NULL,DEFAULT);

SELECT * FROM EMPLOYEE;

-- 사용 불가능 예시
CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHAR2(30)
);    
-- ORA-00984: column not allowed here / DEFAULT값으로 시퀀스 불가!!!

ROLLBACK;

-- 시퀀스 변경
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- START WITH 값 변경 불가!

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
