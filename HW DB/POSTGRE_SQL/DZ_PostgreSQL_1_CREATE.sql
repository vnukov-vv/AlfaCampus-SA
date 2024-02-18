```
CREATE database "PlasticOrder"
	WITH owner = postgres
    ENCODING   = 'UTF-8'
    ;
  
-- �������������� ������������� �� ��������� ��
CREATE SCHEMA IF NOT EXISTS "dbo";

SHOW search_path; -- ������� �� ����

SET search_path TO dbo, public ; -- ��������� ����� �����

/*	�������� ����� ������:
 * 
 *  � PostgreSQL ��� `nvarchar` �� ����������
 * `varchar(n)` - ������ ������������ ���������� �����
 * `char(n)`	- ������ ������������� �����, ����������� ���������
 * ���� `char` � `varchar` �� ������������� ������������ �� ������� �.�. ��� ���������� �������� � ������� ���� ����, ��� ������ �� ������ ��� �������� ��������
 *  
 * `varchar(n)` ����� ����� ������������ ������ ���� ����� ��������� ����, ������� ������ ������ ��� ������� ������� ������� ������ - ����� n �������� (�� ������) - ������.
 * 
 * PostgreSQL ���������� ��� `text`, � ������� ����� ������� ������ ������������ �����.
 * �.�. ��� ��� ���������� ���� �������� ���������� ���������� �����, ��� ��������� ������� � ������������������, ������������� `text` ����������������
 *
 * �.�. `text` �� ������ � ��������� SQL � ���� ������������ ��� `varchar` ��� �������� �����, ��� ����������� ������������� PostgreSQL
 * 
 * ������ � �����: ������� ������ � ���������� ���������. ��������� TEXT, �� ����������� ��������� ������� �������� �������.
 * � ��������� varchar, �� ����������� ��������� ������� ��������� ������. ������ ������� ����� �������� � ��������� �����������.
 */

--- ������� ������� �� �������. ����� :)

CREATE TABLE IF NOT EXISTS "dbo"."cardTypes"(
	"idCardType" SMALLINT NOT NULL,
	"idCardSystem" bigint NULL,
	"name" varchar NULL,
	CONSTRAINT "PK_cardType" PRIMARY KEY ("idCardType")
)
;

CREATE TABLE IF NOT EXISTS "dbo"."clients" (
  "idClient" BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "firstName" varchar,
  "middleName" varchar,
  "surname" varchar,
  "birthday" date,
  "regAddress" varchar,
  "idDirStatus" SMALLINT, -- ��� ��� ������� c PK ��� ���, FK ������� ��������
  "createDate" date,
  "PIN_EQ" varchar
)
;

CREATE TABLE IF NOT EXISTS "dbo"."departments" (
  "idDepartment" INT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar,
  "idDepartmentsSystem" bigint,
  "workTime" varchar,
  "phone" varchar,
  "adressString" varchar,
  "City" varchar,
  "Village" varchar,
  "Street" varchar,
  "Build" varchar,
  "SCNAME" varchar,
  "KLADR" bigint,
  "KLADR_STREET" bigint,
  CHECK ("KLADR">1000000000000 AND "KLADR"<9999999999999),
  CHECK ("KLADR_STREET">10000000000000000 AND "KLADR_STREET"<99999999999999999)
)
--- � ����� � ��������� �.�. �� ��������� �������� �������� �� LIKE '%'

	ALTER TABLE "dbo"."departments" DROP CONSTRAINT "departments_KLADR_STREET_check"
	ALTER TABLE "dbo"."departments" DROP CONSTRAINT "departments_KLADR_check"
	ALTER TABLE "dbo"."departments" ALTER COLUMN "KLADR" TYPE varchar(13)
	ALTER TABLE "dbo"."departments" ALTER COLUMN "KLADR_STREET" TYPE varchar(17)
;

CREATE TABLE IF NOT EXISTS "dbo"."dirChannels" (
  "idDirChannel" SMALLINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
)
;

CREATE TABLE IF NOT EXISTS "dbo"."dirStatuses" (
  "idDirStatus" SMALLINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
)
;

ALTER TABLE "dbo"."clients" ADD FOREIGN KEY ("idDirStatus") REFERENCES "dbo"."dirStatuses" ("idDirStatus")
-- ���� ������� �������� ���������, �� ������� ���� ��������� ������� ��������
;

CREATE TABLE IF NOT EXISTS "dbo"."dirStatusesOrders" (
  "idDirStatusOrder" SMALLINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "name" varchar
)
;

CREATE TABLE IF NOT EXISTS "dbo"."orders" (
  "idOrder" BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "idClient" bigint REFERENCES "dbo"."clients", -- ������������ ��������� ���������, ������� ������ ���� �� ���������
  "idDirChannel" SMALLINT REFERENCES "dbo"."dirChannels",
  "idCardType" SMALLINT REFERENCES "dbo"."cardTypes",
  "idDepartment" int REFERENCES "dbo"."departments",
  "idDirStatusOrder" SMALLINT REFERENCES "dbo"."dirStatusesOrders",
  "createDate" date,
  "editUser" bigint, -- ��� ��� ������� c PK ��� ���, FK ������� �������� 
  "updateDate" date
)
;

CREATE TABLE IF NOT EXISTS "dbo"."users" (
  "idUser" BIGINT GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY,
  "login" varchar
)
;
ALTER TABLE "dbo"."orders" ADD FOREIGN KEY ("editUser") REFERENCES "dbo"."users" ("idUser")
;

/* �������� ����� */

COMMENT ON TABLE "dbo"."cardTypes" IS '��� �����';
COMMENT ON COLUMN "dbo"."cardTypes"."idCardType" IS '��� �����.';
COMMENT ON COLUMN "dbo"."cardTypes"."idCardSystem" IS '������������� � ��������� ������';
COMMENT ON COLUMN "dbo"."cardTypes"."name" IS '������������ �����';
	
COMMENT ON TABLE "dbo"."clients" IS '������ ��������';
COMMENT ON COLUMN "dbo"."clients"."idClient" IS '���������� �������������.(8)';
COMMENT ON COLUMN "dbo"."clients"."firstName" IS '���';
COMMENT ON COLUMN "dbo"."clients"."middleName" IS '��������';
COMMENT ON COLUMN "dbo"."clients"."surname" IS '�������';
COMMENT ON COLUMN "dbo"."clients"."birthday" IS '���� ��������';
COMMENT ON COLUMN "dbo"."clients"."regAddress" IS '����� �����������';
COMMENT ON COLUMN "dbo"."clients"."idDirStatus" IS '������.(2)';
COMMENT ON COLUMN "dbo"."clients"."createDate" IS '���� ��������';
COMMENT ON COLUMN "dbo"."clients"."PIN_EQ" IS '������������� ������� �����. ����������� ��� ����������� ��������.(6)';

COMMENT ON TABLE "dbo"."departments" IS '��������� ������ ����';
COMMENT ON COLUMN "dbo"."departments"."idDepartment" IS '�������������.(4)';
COMMENT ON COLUMN "dbo"."departments"."name" IS '������������';
COMMENT ON COLUMN "dbo"."departments"."idDepartmentsSystem" IS '������������� � �������-���������.(8)';
COMMENT ON COLUMN "dbo"."departments"."workTime" IS '����� ������ ��������� �����';
COMMENT ON COLUMN "dbo"."departments"."phone" IS '������� ��������� �����';
COMMENT ON COLUMN "dbo"."departments"."adressString" IS '����� �����';

COMMENT ON TABLE "dbo"."dirChannels" IS '����� ����������� ������';
COMMENT ON COLUMN "dbo"."dirChannels"."idDirChannel" IS '[��������� ����.(2)';
COMMENT ON COLUMN "dbo"."dirChannels"."name" IS '������������ ������';

COMMENT ON TABLE "dbo"."dirStatuses" IS '������� �����';
COMMENT ON COLUMN "dbo"."dirStatuses"."idDirStatus" IS '��������� ����.(2)';
COMMENT ON COLUMN "dbo"."dirStatuses"."name" IS '(������������ �������';

COMMENT ON TABLE "dbo"."dirStatusesOrders" IS '������� ������';
COMMENT ON COLUMN "dbo"."dirStatusesOrders"."idDirStatusOrder" IS '��������� ����.(2)';
COMMENT ON COLUMN "dbo"."dirStatusesOrders"."name" IS '(������������ ������� ������';

COMMENT ON TABLE "dbo"."orders" IS '������� ������� ����';
COMMENT ON COLUMN "dbo"."orders"."idOrder" IS '��������� ����.(8)';
COMMENT ON COLUMN "dbo"."orders"."createDate" IS '���� �������� ������';
COMMENT ON COLUMN "dbo"."orders"."editUser" IS '������������ - ��������� �����, ��� ������ ���������.(8)';
COMMENT ON COLUMN "dbo"."orders"."updateDate" IS '���� ���������� ������';

COMMENT ON TABLE "dbo"."users" IS '������������ �������. ���������� �����, ��� ����� ���������� �� �������������� �������� � ����� �������';
COMMENT ON COLUMN "dbo"."users"."idUser" IS '��������� ����.(8)';
COMMENT ON COLUMN "dbo"."users"."login" IS '����� ������������.(10)';

/* ������� ��������� ����� */

DROP SCHEMA IF EXISTS "dbo" CASCADE;

/* ������� ���� ������ */

--- 1) ������� �����������
SELECT * FROM pg_stat_activity; 
--- 2) ������������ � ������ ��
--- 3) ��������� ������ ����� ��������� terminate ��� ��������� � DBeaver
--- ����� "SQL Error [55006]: ������: ������� ���� ������, �������� � ������ ������, ������"

DROP database "PlasticOrder";

```
