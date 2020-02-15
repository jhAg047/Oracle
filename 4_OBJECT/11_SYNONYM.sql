-- ���Ǿ�(SYNONYM) : �ٸ� DB�� ���� ��ü�� ���� ���� Ȥ�� ���Ը�
-- ���Ǿ ����Ͽ� �����ϰ� ������ �� �ֵ��� ��

-- ����� ���Ǿ� : ��ü�� ���� ���� ������ �ο� ���� ����ڰ� ������ ���Ǿ�� �ش� ����ڸ� ��� ����
CREATE SYNONYM EMP FOR EMPLOYEE;
-- ORA-01031: insufficient privileges ���Ǿ ������ ������ ����

GRANT CREATE SYNONYM TO KH; -- (SYSTEM����)

SELECT * FROM EMPLOYEE;
SELECT * FROM EMP;

-- ���� ���Ǿ� : ��� ������ �ִ� �����(DBA)�� ������ ���Ǿ�
--              ��� ����ڰ� ����� �� ����

SELECT * FROM KH.EMPLOYEE;
SELECT * FROM KH.EMP;
SELECT * FROM KH.DEPARTMENT;

CREATE PUBLIC SYNONYM DEPT FOR KH.DEPARTMENT;

SELECT * FROM DEPT; -- ���� ���Ǿ�� ��밡��

-- ���Ǿ� ����
-- ����� ���Ǿ� 
DROP SYNONYM EMP;
SELECT * FROM EMP;

-- ���� ���Ǿ�
DROP PUBLIC SYNONYM DEPT; -- KH���� ����� ������ ��� ����
-- private synonym to be dropped does not exist
SELECT * FROM DEPT;

