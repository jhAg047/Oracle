-- �Լ�(FUNCTION) : �÷��� ���� �о ����� ��� ���� 
-- ���� �� �Լ� (SINGLE ROW FUNCTION)
--      N���� ���� �־ N���� ��� ����
-- �׷� �Լ� (GROUP FUNCTION)
--      N���� ���� �־ �� ���� ��� ���� 
-- SELECT���� ������ �Լ��� �׷� �Լ��� �Բ� ��� �� �� : ��� ���� ������ �ٸ��� ����

-- ���� �� �Լ� 
SELECT LENGTH(EMP_NAME)
FROM EMPLOYEE;

-- �׷� �Լ�
SELECT COUNT(EMP_NAME)
FROM EMPLOYEE;

-- ���� ���
--SELECT LENGTH(EMP_NAME), COUNT(EMP_NAME)
--FROM EMPLOYEE;
-- not a single-group group function : ��ȯ�ϴ� ������ ���ƾ��ϴµ� �޶� ����

-- �Լ��� ����� �� �ִ� ��ġ
-- SELECT��, WHERE��, GROUP BY��, HAVING��, ORDER BY��

-- ���� �� �Լ� 
-- 1. ���� ���� �Լ�

-- LENGTH / LENGTHB
-- LENGTH(�÷��� | '���ڿ�') : ���� �� ��ȯ
-- LENGTHB(�÷��� | '���ڿ�') : ������ ����Ʈ ������ ��ȯ

-- ����Ŭ�� �ѱ��� 3����Ʈ�� �ν���
SELECT LENGTH('����Ŭ'), LENGTHB('����Ŭ')
FROM DUAL; -- ���� ���̺�
-- 3 / 9

SELECT EMAIL,LENGTH(EMAIL), LENGTHB(EMAIL)
FROM EMPLOYEE;

-- INSTR : �ش� ���ڿ��� ��ġ / �ش��ϴ� ���ڿ��� ������ 0 ��ȯ
-- ����Ŭ�� �����ε��� ��� XXXXXXXXXXXXXXX
SELECT INSTR('AABAACAABBAA', 'B') FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'Z') FROM DUAL;

SELECT INSTR('AABAACAABBAA', 'B',1) FROM DUAL; -- 1��°���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'B',-1) FROM DUAL; -- -1��°(��)���� �б� �����ؼ� ó������ ������ B�� ��ġ ��ȯ / �ٵ� ��ġ�� ó������ ī��Ʈ
SELECT INSTR('AABAACAABBAA', 'C',-1) FROM DUAL;
SELECT INSTR('AABAACAABBAA', 'B',1,2) FROM DUAL; -- 1��°���� �б� �����ؼ� �ι�°�� ������ B�� ��ġ�� ��ȯ 
SELECT INSTR('AABAACAABBAA','B',-1,2) FROM DUAL; -- ���������� �б� �����ؼ� �ι�°�� ������ B�� ��ġ ��ȯ
SELECT INSTR('AABAACAABBAA', 'C',1,2) FROM DUAL; -- 1��°���� �б� �����ؼ� �ι���� ������ C�� ��ġ�� ��ȯ / ��� 0 ��ȯ

-- EMPLOYEE���̺��� �̸����� @ ��ġ ��ȯ
SELECT EMAIL, INSTR(EMAIL, '@') 
FROM EMPLOYEE;

--0205(��)

-- LPAD / RPAD : �־��� �÷��̳� ���ڿ��� ������ ���ڿ��� ����/�����ʿ� ���ٿ� ���� N�� ���ڿ� ��ȯ
-- ������ ��ŭ �ڸ��� ����� �����̳� ������ ���ڷ� ������ ä��
SELECT LPAD(EMAIL, 20) -- �ƹ��͵� �������ؼ� �������� ä�� 
FROM EMPLOYEE;

SELECT LPAD(EMAIL,20, '#') -- 20�ڸ��� �������� ������� #���� ä��ڴ�!
FROM EMPLOYEE;

SELECT RPAD(EMAIL, 20)
FROM EMPLOYEE;

SELECT RPAD(EMAIL,20,'#')
FROM EMPLOYEE;

-- LTRIM/RTRIM/TRIM : �־��� �÷��̳� ���ڿ��� ���� �Ǵ� ������ �Ǵ� ��/��/���ʿ��� ������ ���� ����
SELECT LTRIM('   KH') FROM DUAL; -- ���� ���� ���� / ������ ���ڿ��� �������� �ʾ��� ��� ������ ����Ʈ�� ��
SELECT LTRIM('   KH', ' ') FROM DUAL; -- �̰� �����Ѱ� 
SELECT LTRIM('000123456', '0') FROM DUAL; -- 123456 
SELECT LTRIM('123123KH','123') FROM DUAL; -- KH
SELECT LTRIM('123123KH123','123') FROM DUAL; -- KH123
SELECT LTRIM('ACABACCKH','ABC') FROM DUAL; -- KH ����? ABC�� �ϳ��ϳ��� �ɰ��� ���⶧���� 
SELECT LTRIM('5781KH', '0123456789') FROM DUAL;

SELECT RTRIM('KH   ') FROM DUAL; -- �����ʺ��� ���� / KH
SELECT RTRIM('123456000' ,'0') FROM DUAL; -- 123456
SELECT RTRIM('KHACABACC','ABC') FROM DUAL; -- KH

SELECT TRIM('   KH   ') FROM DUAL; -- KH
SELECT TRIM('Z' FROM 'ZZZKHZZZ') FROM DUAL;
-- SELECT TRIM (������ ���ڿ� FROM ���ڿ� ) TRIM�� ������� �ٸ�
-- TRIM�� �ѱ��ڹۿ� ���� ����~!
--SELECT TRIM('1' FROM '123132KH123321') FROM DUAL; �ѱ��ڸ� ���� ����
-- TRIM ��ġ �����ϱ�
SELECT TRIM(LEADING 'Z' FROM 'ZZZ123456') FROM DUAL; -- Z: �� (LEADING)
SELECT TRIM(TRAILING 'Z' FROM '123456ZZZ') FROM DUAL; -- �� (TRAILING)
SELECT TRIM(BOTH 'Z' FROM 'ZZZ123456ZZZZZZ') FROM DUAL; -- �� �� (BOTH)

-- SUBSTR : �÷��̳� ���ڿ����� ������ ��ġ���� ���� ������ ���ڿ��� �߶� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY','7') FROM DUAL; -- ���������� �����ϵ� �������� �������ϸ� ������ ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY',5,2) FROM DUAL; -- 5��°���� 2�� �߶� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY',5,0) FROM DUAL; -- 5��°���� 0�� ��ȯ : NULL
SELECT SUBSTR('SHOWMETHEMONEY',1,6) FROM DUAL; -- 1��°���� 6�� ��ȯ
SELECT SUBSTR('SHOWMETHEMONEY',-8,3) FROM DUAL; -- �ڿ��� 8��°���� 3�� ��ȯ : THE
SELECT SUBSTR('SHOWMETHEMONEY',-10,2) FROM DUAL; 

-- EMPLOYEE���̺��� �̸�, �̸���, @���ĸ� ������ ���̵� ��ȸ
SELECT EMP_NAME �̸�,EMAIL �̸���, SUBSTR(EMAIL, 1,INSTR(EMAIL,'@')-1) "@������ �̸���"
--SELECT RTRIM(EMAIL,'@kh.or.kr')
FROM EMPLOYEE;

-- �ֹε�Ϲ�ȣ���� ������ ��Ÿ���� �κи� �߶󺸱�
SELECT SUBSTR(EMP_NO,8,1)
FROM EMPLOYEE;

-- EMPLOYEE ���̺��� �������� �ֹι�ȣ�� �̿��Ͽ� ��� ��, ����, ����, ���� ��ȸ
SELECT EMP_NAME,SUBSTR(EMP_NO,1,2) ����,SUBSTR(EMP_NO,3,2) ����,SUBSTR(EMP_NO,5,2) ����
FROM EMPLOYEE;

-- LOWER / UPPER / INITCAP
SELECT LOWER('Welcome To My World') FROM DUAL; -- ��� �� �ҹ���
SELECT UPPER('Welcome To My World') FROM DUAL; -- ��� �� �빮��
SELECT INITCAP('welcome to my world') FROM DUAL; -- ���⸸ �������� �ձ��ڸ� �빮�ڷ� ����

-- CONCAT : ���ڿ�/�÷� ��ġ��~~!
SELECT CONCAT('�����ٶ�','ABCD') FROM DUAL;
SELECT '�����ٶ�' || 'ABCD' FROM DUAL;

-- REPLACE 
SELECT REPLACE('����� ������ ���ﵿ', '���ﵿ','�Ｚ��') FROM DUAL;
SELECT REPLACE('����ȣ �л��� ������ �����ϱ��?','����','����') FROM DUAL;

-- EMPLOYEE���̺��� �̸����� �������� gmail.com���� �����ϱ�
SELECT EMAIL ������, REPLACE(EMAIL,'kh.or.kr','gmail.com') FROM EMPLOYEE;

-- EMPLOYEE���̺��� ��� ��, �ֹι�ȣ ��ȸ
-- ��, �ֹι�ȣ�� �������- ���������� ���̰� �ϰ� ������ ���� '*'���� �ٲٱ� EX.010114-2******
SELECT EMP_NAME,REPLACE(EMP_NO,SUBSTR(EMP_NO,9),'******')
FROM EMPLOYEE;

SELECT EMP_NAME, CONCAT(SUBSTR(EMP_NO,1,8), '******')
FROM EMPLOYEE;

SELECT EMP_NAME, RPAD(SUBSTR(EMP_NO,1,8),14, '*')
FROM EMPLOYEE;

-- 2. ���� ���� �Լ�
-- ABS : ���� ��(���)�� �������ִ� �Լ�
SELECT ABS(10.9) FROM DUAL;
SELECT ABS(-10.9) FROM DUAL;
SELECT ABS(10) FROM DUAL;
SELECT ABS(-10) FROM DUAL;

-- MOD : ������ ���� ��ȯ
-- ������! ���������� ���� ������ ���� ���� ��ȯ
SELECT MOD(10,3) FROM DUAL; -- 1
SELECT MOD(-10,3) FROM DUAL; -- -1
SELECT MOD(10,-3) FROM DUAL; -- 1 
SELECT MOD(10.9,3) FROM DUAL; -- -1.9
SELECT MOD(-10.9,3) FROM DUAL; -- -1.9

SELECT MOD(-10,-3) FROM DUAL; -- -1 -10�� ��ȣ�� ���󰡱� ������

-- ROUND : �ݿø� / �Ҽ��� �����ε��� ���
SELECT ROUND(123.456) FROM DUAL; -- 123
SELECT ROUND(123.678,0) FROM DUAL; -- 124
SELECT ROUND(123.456, 1) FROM DUAL; -- 123.5
SELECT ROUND(123.456, 2) FROM DUAL; -- 123.46
SELECT ROUND(123.456, -2) FROM DUAL; -- 100 // 10�� �ڸ�

-- ����
SELECT ROUND(-10.61) FROM DUAL; -- ������ �ݿø��Ǵ¼��� 1,2,3,4 // -11

-- FLOOR : ����(������)
SELECT FLOOR(123.456) FROM DUAL; -- 123
SELECT FLOOR(123.678) FROM DUAL; -- 123

-- TRUNC : ����(����)
SELECT TRUNC(123.456) FROM DUAL; -- 123
SELECT TRUNC(123.678) FROM DUAL; -- 123
SELECT TRUNC(123.456, 1) FROM DUAL; -- �Ҽ� 2��°�ڸ����� ����
SELECT TRUNC(123.456, -1) FROM DUAL; -- 1�� �ڸ����� ����

-- CEIL : �ø�
SELECT CEIL(123.456) FROM DUAL; -- 124
SELECT CEIL(123.678) FROM DUAL; -- 124

-- 3. ��¥ ���� �Լ�
-- SYSDATE : ���� ��¥ ��ȯ

-- MONTHS_BETWEEN : ���ڿ� ��¥ ������ ���� �� ���̸� ���ڷ� �����ϴ� �Լ�
-- EMPLOYEE���̺��� ����� �̸�, �Ի���, �ٹ� ���� �� ��ȸ
SELECT EMP_NAME,HIRE_DATE,ABS(MONTHS_BETWEEN(HIRE_DATE,SYSDATE))
FROM EMPLOYEE;

-- ADD_MONTHS : ��¥�� ���ڸ�ŭ�� ���� ���� ���� ��¥ ����
SELECT ADD_MONTHS(SYSDATE, 5) FROM DUAL; -- 20/07/05
SELECT ADD_MONTHS(SYSDATE, 15) FROM DUAL; -- 21/05/05 12������ �Ѿ�� �˾Ƽ� �������� �ٲ�

-- NEXT_DAY : ���� ��¥���� ���Ϸ��� ���Ͽ� ���� ���� ����� ���ڸ� �����ϴ� �Լ� 
SELECT SYSDATE, NEXT_DAY(SYSDATE, '�����') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 1) FROM DUAL;
-- �� �� ȭ �� �� �� ��
-- 1  2  3  4  5 6  7
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��') FROM DUAL;
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'ȭ������ ���� ���� ������ �ϰ� ������?') FROM DUAL; -- ù��° ���ڿ� ȭ�� �־ ȭ���� ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, '��ȭ�õ� �ڱ� �̸��� �Ǵ��� �ñ��ϰ���') FROM DUAL; -- ù��° ���ڰ� ������ �ȵ��־ ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = AMERICAN; -- ������ �ٲٱ� : ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THURSDAY') FROM DUAL; -- ����
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUR') FROM DUAL; -- ���� 
SELECT SYSDATE, NEXT_DAY(SYSDATE, 'THUROSEMARY') FROM DUAL;

ALTER SESSION SET NLS_LANGUAGE = KOREAN; -- ������ �ٲٱ� : �ѱ�

-- LAST_DAY : �ش� ���� ������ ��¥ ����
SELECT SYSDATE, LAST_DAY(SYSDATE) FROM DUAL;
SELECT LAST_DAY('20/12/15') FROM DUAL;
-- EXTRACT : ���ڿ��� ��, ��, �� �����Ͽ� ����
-- EXTRACT(YEAR FROM ��¥)
-- EXTRACT(MONTH FROM ��¥)
-- EXTRACT(DAY FROM ��¥)

-- EMPLOYEE���̺��� ����� �̸�, �Ի� ��, �Ի� ��, �Ի� �� ��ȸ
SELECT EMP_NAME, EXTRACT(YEAR FROM HIRE_DATE) �Ի�⵵,
                EXTRACT(MONTH FROM HIRE_DATE) �Ի��,
                EXTRACT(DAY FROM HIRE_DATE) �Ի���
FROM EMPLOYEE;

-- 4. �� ��ȯ �Լ� 
-- TO_CHAR(��¥[, ����]) : ��¥�� �����͸� ������ �����ͷ� �ٲ�
-- TO_CHAR(����[, ����]) : ������ �����͸� ������ �����ͷ� �ٲ�
SELECT TO_CHAR(1234) �� FROM DUAL;
SELECT TO_CHAR(1234, '99999') ��  FROM DUAL; -- 5ĭ�� �����ϰ� ������ ����, ��ĭ ����
SELECT TO_CHAR(1234, '00000') �� FROM DUAL; -- 5ĭ�� �����ϰ� ������ �����̰� ��ĭ�� 0���� ǥ�� 
SELECT TO_CHAR(1234,'FML99999') �� FROM DUAL; -- ������ �����ϰ� ������ ǥ��
SELECT TO_CHAR(1234,'$99999') �� FROM DUAL; -- ������ ����� $���� ǥ��
SELECT TO_CHAR(1234,'FM$99999') �� FROM DUAL; -- ������ �����ϰ� $���� ǥ��
SELECT TO_CHAR(1234, '99,999') �� FROM DUAL; 
SELECT TO_CHAR(1234, 'FM99,999') �� FROM DUAL;
SELECT TO_CHAR(1234, '00,000') �� FROM DUAL;
SELECT TO_CHAR(1234, 'FM00,000') �� FROM DUAL;
SELECT TO_CHAR(1234, '9.9EEEE') O FROM DUAL; -- ���� �������� ǥ��
SELECT TO_CHAR(1234, '999') �� FROM DUAL; 

-- ��¥�� ���ڷ� 
SELECT TO_CHAR(SYSDATE, 'PM HH24:MI:SS') FROM DUAL; -- ���� 20:04:54
SELECT TO_CHAR(SYSDATE, 'AM HH:MI:SS') FROM DUAL; -- ���� 08:05:01
SELECT TO_CHAR(SYSDATE, 'MON DY, YYYY') FROM DUAL; -- 2��  ��, 2020
SELECT TO_CHAR(SYSDATE, 'YYYY-MM-DD DAY') FROM DUAL; -- 2020-02-05 ������
SELECT TO_CHAR(SYSDATE, 'YYYY-FMMM-DD DAY') FROM DUAL; -- 2020-2-5 ������ FM�� �ڿ����� ������ ��ħ
SELECT TO_CHAR(SYSDATE, 'YEAR, Q') || '�б�' FROM DUAL; -- TWENTY TWENTY, 1 = �б�  // ����ǥ���
SELECT TO_CHAR(SYSDATE, 'YYYY"��" MM"��" DD"��" DAY') FROM DUAL; -- 2020�� 02�� 05�� ������

-- ���� ��¥�� ���� ���� ���
SELECT TO_CHAR(SYSDATE, 'YYYY'), TO_CHAR(SYSDATE, 'YY'), TO_CHAR(SYSDATE, 'YEAR')
--          2020                      20                       TWENTY TWENTY
FROM DUAL;

-- �� ��� 
SELECT TO_CHAR(SYSDATE, 'MM'), TO_CHAR(SYSDATE, 'MONTH'), TO_CHAR(SYSDATE, 'MON'), TO_CHAR(SYSDATE, 'RM')
--           02                         2��                     2��                      II  -> �θ��� ǥ��
FROM DUAL;

-- �� ���
SELECT TO_CHAR(SYSDATE, 'DDD'), -- �� �������� ��°
       TO_CHAR(SYSDATE,'DD'),  -- �� �������� ��°
       TO_CHAR(SYSDATE,'D') -- �� �������� ��°
FROM DUAL;

-- �б�, ���� ���
SELECT TO_CHAR(SYSDATE, 'Q'), -- �б� 
       TO_CHAR(SYSDATE, 'DAY'), -- ���� (������)
       TO_CHAR(SYSDATE, 'DY') -- ����(��)
FROM DUAL;

-- TO_DATE : ����/������ ������ -> ��¥�� ������
-- ����Ŭ���� �⺻������ ��¥ ����Ҷ��� 2���ڰ� �⺻
SELECT TO_DATE('20100101','YYYYMMDD') FROM DUAL;
SELECT TO_DATE(20100101,'YYYYMMDD') FROM DUAL;

-- 2010 01 01 ==> 2010, 1��
SELECT TO_CHAR(TO_DATE('20100101','YYYYMMDD'),'YYYY, MON') A -- TO_DATE('20100101','YYYYMMDD') ��¥ ����
FROM DUAL;

SELECT TO_CHAR(TO_DATE('041030 143000', 'YYMMDD HH24MISS'), 'YY-MON-DD HH:MI:SS PM') A -- 04-10��-30 02:30:00 ����
FROM DUAL;

-- RR�� YY�� ���� 
-- ������ : �⵵�� ǥ���ϴ°�
-- YY : 2�ڸ� �⵵�� ���缼�⸦ ���缭 �־���
-- RR : 2�ڸ� �⵵�� 50�� �̻��̸� ��������(20����)// 50�� �̸��̸� ���缼�Ⱑ ����
SELECT TO_CHAR(TO_DATE('980630','YYMMDD'), 'YYYYMMDD') A , -- 20980630
       TO_CHAR(TO_DATE('140918','YYMMDD'), 'YYYYMMDD') B, -- 20140918
       TO_CHAR(TO_DATE('980630','RRMMDD'), 'YYYYMMDD') C, -- 19980630
       TO_CHAR(TO_DATE('140918','RRMMDD'), 'YYYYMMDD') D -- 20140918
FROM DUAL;

-- TO_NUMBER : ������ �����͸� ������ �����ͷ� �ٲ��ִ� �Լ� 
-- �⺻������ ����Ŭ���� ���ڸ� �ִ� ���ڴ� �˾Ƽ� �ٲ㼭 �������
SELECT TO_NUMBER('123456789') A FROM DUAL;
SELECT '123' + '456' FROM DUAL;
SELECT '123' + '456A' FROM DUAL; -- ����
SELECT '1,000,000' + '550,000' FROM DUAL; -- ���� 
SELECT TO_NUMBER('1,000,000','99,999,999') FROM DUAL;
SELECT TO_NUMBER('1,000,000','99,999,999') + TO_NUMBER('550,000','999,999') A FROM DUAL;

-- 5. NULL ó�� �Լ� 
-- NVL(�÷���, �÷� ���� NULL�� �� �ٲ� ��)

SELECT EMP_NAME, NVL(BONUS, 0)
FROM EMPLOYEE;

SELECT EMP_NAME, NVL(DEPT_CODE,'�����ϴ�')
FROM EMPLOYEE;

-- NVL2(�÷� ��, �ٲ� ��1, �ٲ� ��2) / �÷����� NULL�� �ƴϸ� �ٲ� ��1�� �ٲٰ� NULL�̸� �ٲ� ��2�� �ٲ۴�
-- EMPLOYEE���̺��� ���ʽ��� NULL�� ������ 0.5�� NULL�� �ƴ� ������ 0.7�� �����Ͽ� ��ȸ
SELECT EMP_NAME,BONUS,NVL2(BONUS,0.7,0.5)
FROM EMPLOYEE;

-- NULLIF(�񱳴��1, �񱳴��2) : �� ���� ���� �����ϸ� NULL, �������� ������ �񱳴��1 ����
SELECT NULLIF(123,123) FROM DUAL; -- (null)
SELECT NULLIF(123,124) FROM DUAL; -- 123

-- 6. �����Լ� : ���� ���� ��� ������ �� �ִ� ��� ����
-- DECODE(����|�÷���, ���ǰ�1, ���ð�1, ���ǰ�2, ���ð�2...,Default)
-- ���ϰ����ϴ� �� �Ǵ� �÷��� ���ǽİ� ������ ��� �� ��ȯ
SELECT EMP_ID, EMP_NAME,EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1,'��',2,'��') ���� 
FROM EMPLOYEE;

SELECT EMP_ID, EMP_NAME,EMP_NO,
        DECODE(SUBSTR(EMP_NO,8,1), 1,'��','��') ���� -- 1�� �ƴϸ� ���� 
FROM EMPLOYEE;
-- ������ ���ڷ� ���� �� ���� ���� ���� �ۼ��ϸ� 
-- �ƹ� �͵� �ش���� ���� �� �������� �ۼ��� ���ð��� ������ ������

-- CASE WHEN ���ǽ� THEN ��� ��
--        WHEN ���ǽ� THEN ��� ��
--        ELSE ��� ��
-- END
-- ���ϰ��� �ϴ� �� �Ǵ� �ø��� ���ǽİ� ������ ��� �� ��ȯ(������ ���� ����)
SELECT EMP_ID,EMP_NAME,EMP_NO,
        CASE WHEN SUBSTR(EMP_NO,8,1) = 1 THEN '��'
            ELSE '��'
        END ����
FROM EMPLOYEE;

-- �޿��� 500������ �ʰ��ϸ� 1���, 350������ �ʰ��ϸ� 2���, 200�� �ʰ� 3���, ������ 4���
SELECT EMP_ID,EMP_NAME,SALARY,
    CASE WHEN SALARY > 5000000 THEN '1���'
        WHEN SALARY > 3500000 THEN '2���'
        WHEN SALARY > 2000000 THEN '3���'
        ELSE '4���'
        END ���
FROM EMPLOYEE;

-- �׷��Լ� : ���� ���� ������ �Ѱ��� ��� ��ȯ
-- SUM(���ڰ� ��ϵ� �÷�) : �հ� ����
-- EMPLOYEE���̺��� �� ����� �޿� ���� ��ȸ
SELECT SUM(SALARY)
FROM EMPLOYEE;

-- ���� ����� ���� �޿�
SELECT SUM(SALARY)
FROM EMPLOYEE
WHERE SUBSTR(EMP_NO,8,1) = 1;

-- AVG(���ڰ� ��ϵ� �÷�) : ��� ����
-- EMPLOYEE���̺��� �� ����� �޿� ��� ��ȸ
SELECT AVG(SALARY)
FROM EMPLOYEE;

SELECT SUM(BONUS)
FROM EMPLOYEE;

SELECT AVG(BONUS), AVG(NVL(BONUS,0))
FROM EMPLOYEE;
-- NULL���� ���� ���� ��� ��꿡�� ���� �Ǿ� ���

-- MIN / MAX : �ִ� / �ִ�
-- ���� ���� ��¥ �� ���� ����
-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� ���� �̸���, ���� ���� �Ի���
SELECT MIN(SALARY), MIN(EMAIL), MIN(HIRE_DATE)
FROM EMPLOYEE;

-- EMPLOYEE���̺��� ���� ���� �޿�, ���ĺ� ������ ���� �������� �̸���, ���� ���� �Ի���
SELECT MAX(SALARY), MAX(EMAIL), MAX(HIRE_DATE)
FROM EMPLOYEE;

-- COUNT(* | �÷���) : ���� ���� ���� 
-- COUNT(DISTINCT �÷���) : �ߺ��� ������ �� ���� ����
-- COUNT(*) : NULL�� ������ ��ü �� ���� ����
-- COUNT(�÷���) : NULL�� ������ ��ü �� ���� ����
SELECT COUNT(*),COUNT(DEPT_CODE),COUNT(DISTINCT DEPT_CODE)
FROM EMPLOYEE;