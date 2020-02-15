-- ������(SEQUENCE) : �ڵ� ��ȣ �߻���
CREATE SEQUENCE SEQ_EMPID -- ������ �̸�����
START WITH 300 -- ���� ���� 300
INCREMENT BY 5 -- ���� ���� 5
MAXVALUE 310 -- �ִ� ���� 310
NOCYCLE -- ����Ŭ�� ���� �ʰڴ�
NOCACHE; -- �޸� �󿡼� �������� �ʰڴ�

SELECT * FROM USER_SEQUENCES;

-- SEQUENCE ���
-- ��������.CURRAVAL : ���� ������ ������ ��
-- ��������.NEXTVAL : �������� ������Ű�ų� ���ʷ� �������� ����
--                   ------------- ��������.NEXTVAL = ��������.CURRVAL + INCREMENT�� ������ ��

SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ORA-08002: sequence SEQ_EMPID.CURRVAL is not yet defined in this session
-- NEXTVAL�� �������� �������� �ʾƼ� �ߴ� ����~!

SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.CURRVAL FROM DUAL; -- 300
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 305
SELECT SEQ_EMPID.NEXTVAL FROM DUAL; -- 310

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
-- ORA-08004: sequence SEQ_EMPID.NEXTVAL exceeds MAXVALUE and cannot be instantiated
-- SEQ_EMPID.NEXTVAL�� MAXVALUE�� �ʰ��ؼ� �� �����Ҽ��� ����!
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
-- ���������� ȣ��� ������ NEXTVAL�� �� ����

-- CURRVLA / NEXTVAL ��� ���� �� �Ұ���
-- ��밡��
--      ���������� �ƴ� SELECT��
--      INSERT���� SELECT��
--      INSERT���� VALUES��
--      UPDATE���� SET��
-- ��� �Ұ���
--        VIEW�� SELECT��
--        DISTINCTŰ���尡 �ִ� SELECT��
--        GROUP BY, HAVING, ORDER BY���� SELECT��
--        SELECT , UPDATE , DELETE���� ��������
--        CREATE TABLE, ALTER TABLE�� DEFAULT ��

-- ���� ���ڰ� 300�̰� ���� ���� 1�̸� �ִ� ���ڰ� 10000�� ���ȯ �� ĳ�� ����� ���ϴ� SEQ_EID ������ ����
CREATE SEQUENCE SEQ_EID
START WITH 300
--INCREMENT BY 1 / 1�̿��� ��������
MAXVALUE 10000
NOCYCLE
NOCACHE;

COMMIT;

INSERT INTO EMPLOYEE
VALUES(SEQ_EID.NEXTVAL, 'ȫ�浿', '666666-6666666','hong_gd@kh.or.kr','01066666666','D2','J7','S1',
        5000000,0.1,200,SYSDATE,NULL,DEFAULT);

SELECT * FROM EMPLOYEE;

-- ��� �Ұ��� ����
CREATE TABLE TMP_EMPLOYEE(
    E_ID NUMBER DEFAULT SEQ_EID.NEXTVAL,
    E_NAME VARCHAR2(30)
);    
-- ORA-00984: column not allowed here / DEFAULT������ ������ �Ұ�!!!

ROLLBACK;

-- ������ ����
ALTER SEQUENCE SEQ_EMPID
INCREMENT BY 10
MAXVALUE 400
NOCYCLE
NOCACHE;

SELECT * FROM USER_SEQUENCES;
-- START WITH �� ���� �Ұ�!

SELECT SEQ_EMPID.NEXTVAL FROM DUAL;
SELECT SEQ_EMPID.CURRVAL FROM DUAL;
