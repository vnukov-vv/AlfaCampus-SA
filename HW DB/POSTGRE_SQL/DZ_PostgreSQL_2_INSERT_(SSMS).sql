```

INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[cardTypes]
SELECT
	idCardType,
	idCardSystem,
	IIF (name NOT LIKE '[�-�]%',right (name,len(name)-2),name)
FROM
	[PlasticOrder].[dbo].[cardTypes]
;


--- ����� 1 -- ���������� TOP
INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[clients]
SELECT top 10000 
	idClient,
	firstName,
	middleName,
	surname,
	birthday,
	regAddress,
	idDirStatus,
	createDate,
	PIN_EQ
FROM
	[PlasticOrder].[dbo].[clients]
;
--- ����� 2 -- ���������� OFFSET...FETCH
INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[clients]
SELECT
	idClient,
	firstName,
	middleName,
	surname,
	birthday,
	regAddress,
	idDirStatus,
	createDate,
	PIN_EQ
FROM
	[PlasticOrder].[dbo].[clients]
ORDER BY idClient
    OFFSET 10000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 3
INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[clients] 
SELECT
	idClient,
	firstName,
	middleName,
	surname,
	birthday,
	regAddress,
	idDirStatus,
	createDate,
	PIN_EQ
FROM
	[PlasticOrder].[dbo].[clients]
ORDER BY idClient 
    OFFSET 20000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 4
INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[clients]
SELECT
	idClient,
	firstName,
	middleName,
	surname,
	birthday,
	regAddress,
	idDirStatus,
	createDate,
	PIN_EQ
FROM
	[PlasticOrder].[dbo].[clients]	
ORDER BY idClient 
    OFFSET 30000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 5
INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[clients]
SELECT
	idClient,
	firstName,
	middleName,
	surname,
	birthday,
	regAddress,
	idDirStatus,
	createDate,
	PIN_EQ
FROM
	[PlasticOrder].[dbo].[clients]	
ORDER BY idClient 
    OFFSET 40000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;

INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[departments]
SELECT
	idDepartment,
	name,
	idDepartmentsSystem,
	workTime,
	phone,
	addressString,
	City,
	Village,
	Street,
	Build,
	SCNAME,
	KLADR,
	KLADR_STREET
--	� ������� �������� KLADR � KLADR_STREET �������� ��� ������������� ��������
FROM
	[PlasticOrder].[dbo].[departments]
;

INSERT INTO
	[POSTGRESQL].[PlasticOrder].[dbo].[dirChannels]
SELECT
	idDirChannel,
	name
FROM
	[PlasticOrder].[dbo].[dirChannels]
;

INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[dirStatuses]
SELECT
	idDirStatus,
	name
FROM
	[PlasticOrder].[dbo].[dirStatuses]
;

INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[dirStatusesOrders]
SELECT
	idDirStatusOrder,
	name
FROM
	[PlasticOrder].[dbo].[dirStatusesOrders]
;

/* ����� ���� �����, ������� ���� ��������� ������� */
--- ����� 1 ---
INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[orders] 
SELECT top 10000
	idOrder,
	idClient,
	idDirChannel,
	idCardType,
	idDepartment,
	idDirStatusOrder,
	createDate,
	editUser,
	updateDate
FROM
	[PlasticOrder].[dbo].[orders]
;
--- ����� 2 ---
INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[orders] 
SELECT
	idOrder,
	idClient,
	idDirChannel,
	idCardType,
	idDepartment,
	idDirStatusOrder,
	createDate,
	editUser,
	updateDate
FROM
	[PlasticOrder].[dbo].[orders]
ORDER BY idOrder
    OFFSET 10000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 3 ---
INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[orders] 
SELECT
	idOrder,
	idClient,
	idDirChannel,
	idCardType,
	idDepartment,
	idDirStatusOrder,
	createDate,
	editUser,
	updateDate
FROM
	[PlasticOrder].[dbo].[orders]
ORDER BY idOrder
    OFFSET 20000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 4 ---
INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[orders] 
SELECT
	idOrder,
	idClient,
	idDirChannel,
	idCardType,
	idDepartment,
	idDirStatusOrder,
	createDate,
	editUser,
	updateDate
FROM
	[PlasticOrder].[dbo].[orders]
ORDER BY idOrder
    OFFSET 30000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;
--- ����� 5 ---
INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[orders] 
SELECT
	idOrder,
	idClient,
	idDirChannel,
	idCardType,
	idDepartment,
	idDirStatusOrder,
	createDate,
	editUser,
	updateDate
FROM
	[PlasticOrder].[dbo].[orders]
ORDER BY idOrder
    OFFSET 40000 ROWS
    FETCH NEXT 10000 ROWS ONLY
;

INSERT INTO [POSTGRESQL].[PlasticOrder].[dbo].[users]
SELECT
	idUser,
	login
FROM
	[PlasticOrder].[dbo].[users]
;

```