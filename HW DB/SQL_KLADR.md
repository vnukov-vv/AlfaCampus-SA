<table width="1000" border="1">
<thead>
  <tr>
    <td rowspan="3"><img width="300px" src="https://github.com/vnukov-vv/AlfaCampus-SA/assets/101928718/6c8664d3-2b42-4c23-9b08-686f390ca366"></td>
    <td colspan="2" width="700"><p align="center"><b>Проект по обработке адресных объектов<br>в Системе «Заказ банковских карт в удаленных каналах»</b></p></td>
  </tr>
  <tr>
    <td>Дата</td>
    <td>13.02.2024</td>
  </tr>
  <tr>
    <td>Версия</td>
    <td>2.0</td>
  </tr>
</thead>
</table>

## История изменений

|Дата |Описание изменения |Версия |Автор |Бизнес-заказчик |Согласование<br>бизнес-заказчика|
|:---:|:---:|:---:|:---:|:---:|:---:|
|29/01/2024|Согласованная версия документа|1.1|Внуков В.В. |Кислицын Е.В.|---|

## Контактные лица
|Подразделение	|Роль в процессе| Фамилия И.О.|
|---|---|---|
|Альфа-Кампус|СА-Кампусенок|Внуков В.В.|

# Поддержка формата Государственного адресного реестра (ГАР) в Системе "Заказ банковских карт в удаленных каналах"
В рамках централизованного банковского проекта по обработке адресных объектов.
<br>**Допущение**: в рамках задания используется файловая [выгрузка](https://fias-file.nalog.ru/downloads/2024.01.23/base.7z "см. https://fias.nalog.ru/Frontend") в формате  [КЛАДР 4.0](https://kladr-rf.ru/ "Классификатор адресов Российской Федерации
Введен в действие с 01.12.2005 приказом ФНС России от 17.11.2005 № САЭ-3-13/594@.")

## Оглавление
[1. Цели проекта](#title1) <br> 
[2. Задачи проекта](#title2)</br>
[3. Модель данных](#title3)</br>
&nbsp; [3.1 Таблицы БД](#title3_1) <br>
&nbsp; [3.2 Описание таблиц БД PlasticOrder](#title3_2) <br>
&nbsp; [3.3 Описание таблиц БД KLADR](#title3_2) <br>
&nbsp; [3.4 SQL-скрипты](#title3_2) <br>

## <a id="title1"> 1. Цели проекта </a>
- Исключить регуляторный риск (комплаенс).
- Обязательное использование ГАР всеми информационными системами Банка;
- Привести разрозненные сведения об адресах к единому, унифицированному написанию, исключить дубли, ошибки и противоречия в адресах при информационном взаимодействии;
- Обеспечить корректное заполнение адресных данных Банка, Клиентов, Контрагентов в исходящих документах и отчетности Банка;

## <a id="title2"> 2. Задачи проекта </a>
- Настроить хранение справочника ГАР в информационной Системе Банка;
- Настроить регулярное обновление справочника ГАР в информационной системе Банка;
- Произвести конвертацию имеющихся адресных записей в формат ГАР;
- Изменить формы ввода адресных данных;
- Настроить контроль заполнения атрибутов адресов [при добавлении или изменении записей] значениями из ГАР.

## <a id="title3"> 3. Модель данных </a>

База данных **PlasticOrder** предназначена для автоматизации процессов заказа **Карт** **Банка** в удаленных каналах
База данных **KLADR** импортируемый справочник адресов в установленном формате.

### <a id="title3_1"> Таблицы БД </a>
Таблицы изменяемые в рамках реализации проекта
<br>**Допущение**: в рамках задания используется только одна сущность

|№ |Имя|Описание| 
|---|---|---|
|1|*dbo.departments*|Отделения выдачи **Карт**|

### <a id="title3_2"> Описание таблиц БД **PlasticOrder** </a>

#### dbo.departments (AS IS)
Отделения выдачи карт

##### Колонки (6)
|№ |Имя|Тип<br>данных|Размер|Обязательное<br>(Да/Нет)|Описание|
|---|---|---|---|---|---|
|1|*idDepartment*|int|4|Да|Первичный ключ|
|2|*name*|nchar|255|Нет|Наименование отделения|
|3|*idDepartmentsSystem*|bigint|8|Нет|Идентификатор в системе-источнике|
|4|*workTime*|nvarchar|255|Нет|Времф работы отделения Банка|
|5|*phone*|nvarchar|255|Нет|Телефон отделения Банка|
|6|*adressString*|nvarchar|255|Нет|Адрес Банка|
##### Ключи (1)
|Тип|Имя ключа|Поле|Описание| 
|---|---|---|---|
|PRIMARY KEY<BR>(clustered)|*PK_department*|*idDepartment*|---|
##### Индексы (1)
|Имя|Детали|Ключи|Описание| 
|---|---|---|---|
|*PK_department*|clustered, unique, primary key located on PRIMARY|*idDepartment*|---|

Таблица ссылается на внешние ключи: *PlasticOrder.dbo.orders: FK_orders_department*

#### dbo.departments (TO BE)
##### Колонки (6)
|№ |Имя|Тип<br>данных|Размер|Обязательное<br>(Да/Нет)|Описание|
|---|---|---|---|---|---|
|1|*idDepartment*|int|4|Да|Первичный ключ|
|2|*name*|nchar|255|Нет|Наименование отделения|
|3|*idDepartmentsSystem*|bigint|8|Нет|Идентификатор в системе-источнике|
|4|*workTime*|nvarchar|255|Нет|Времф работы отделения Банка|
|5|*phone*|nvarchar|255|Нет|Телефон отделения Банка|
|6|*addressString*|nvarchar|255|Нет|Адрес Банка|
|7|*city*|nvarchar|255|Нет|Город, Городской округ|
|8|*village*|nvarchar|255|Нет|Населенный пункт|
|9|*street*|nvarchar|255|Нет|Улица|
|10|*build*|nvarchar|255|Нет|Дом|
|11|*SCNAME*|varchar|10|Нет|Тип адресного объекта 5-го уровня классификации|
|12|*KLADR*|varchar|13|Нет|Город (КЛАДР)|
|13|*KLADR_STREET*|nvarchar|17|Нет|Улица (КЛАДР)|

### <a id="title3_3"> Описание таблиц БД **KLADR** </a>
Классификатор адресов РФ

|№ |Имя|Описание| 
|---|---|---|
|1|*dbo.ALTNAMES*|содержит **сведения о соответствии кодов записей** со старыми и новыми наименованиями адресных объектов, а также сведения о соответствии кодов адресных объектов до и после их переподчинения.|
|2|*dbo.DOMA*|содержит объекты 6-го уровня классификации (**номера домов**, улиц, городов и населённых пунктов);|
|3|*dbo.FLAT*|содержит объекты 7-го уровня классификации (**номера квартир** домов);|
|4|*bo.KLADR*|содержит объекты c 1-го по 4-й уровень классификации (регионы; районы (улусы); города, посёлки городского типа, сельсоветы; сельские населённые пункты);|
|5|*dbo.NAMEMAP*|содержит объекты 5-го уровня классификации|
|6|*dbo.SOCRBASE*|содержит объекты с краткими наименованиями **типов адресных объектов**;|
|7|*dbo.STREET*|содержит объекты 5-го уровня классификации (**улицы** городов и населённых пунктов);|

<br>**Допущение**: В рамках задания поддержка КЛАДР будут использоваться таблицы **dbo.KLADR**, **dbo.STREET**. Таблица **dbo.SOCRBASE** использовалась как справочник формата сокращений.

#### dbo.KLADR
объекты c 1-го по 4-й уровень классификации
##### Колонки (8)
|№ |Имя|Тип<br>данных|Размер|Обязательное<br>(Да/Нет)|Описание|
|---|---|---|---|---|---|
|1	|NAME	|varchar	|40	|Нет|Наименование адресного объекта|
|2	|SOCR	|varchar	|10	|Нет|Сокращенное наименование типа|
|3	|CODE	|varchar	|13	|Нет|Код адресного объекта|
|4	|INDEX	|varchar	|6	|Нет||
|5	|GNINMB	|varchar	|4	|Нет||
|6	|UNO	|varchar	|4	|Нет||
|7	|OCATD	|varchar	|11	|Нет||
|8	|STATUS	|varchar	|1	|Нет||

#### dbo.STREET
объекты 5-го уровня классификации
##### Колонки (6)
|№ |Имя|Тип<br>данных|Размер|Обязательное<br>(Да/Нет)|Описание|
|---|---|---|---|---|---|
|1	|NAME	|varchar	|40	|Нет|Наименование адресного объекта|
|2	|SOCR	|varchar	|10	|Нет|Сокращенное наименование типа|
|3	|CODE	|varchar	|17	|Нет|Код адресного объекта|
|4	|INDEX	|varchar	|6	|Нет||
|5	|GNINMB	|varchar	|4	|Нет||
|6	|UNO	|varchar	|4	|Нет||
|7	|OCATD	|varchar	|11	|Нет||


### <a id="title3_4"> SQL-скрипты </a>

#### 1. Добавляем атрибуты в PlasticOrder.dbo.departments
```
/* добавляем новые атрибуты в PlasticOrder.dbo.departments */

ALTER TABLE dbo.departments
ADD City nvarchar(255),
    Village nvarchar(255),
    Street nvarchar(255),
    Build nvarchar(255),
    SCNAME varchar(10),
    KLADR varchar(13),
    KLADR_STREET varchar(17)
```
#### 2.1 Разбираем dbo.departments.addressString
```
/* разбираем адресную строку dbo.departments.addressString и заполняем адресные атрибуты КЛАДР в dbo.departments */

WITH SPLIT_ADDRESS AS
(
SELECT
	IdDepartment
	,STRING_AGG(City, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS City 
	,STRING_AGG(Village, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Village
	,STRING_AGG(StreetType, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS SCNAME
	,STRING_AGG(Street, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Street
	,STRING_AGG(Build, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Build
FROM 
(SELECT 
	IdDepartment , addressString,
    CASE 
        WHEN CHARINDEX('г. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('г. ', value) + 3, LEN(value))))
        WHEN CHARINDEX('г ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('г ', value) + 2, LEN(value))))
        ELSE NULL
    END AS City,
    CASE 
        WHEN CHARINDEX('с. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('с. ', value) + 3, LEN(value))))
        ELSE NULL
    END AS Village,
    CASE 
        WHEN CHARINDEX('пр. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр. ', value) + 4, LEN(value))))
        WHEN CHARINDEX('пер. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пер. ', value) + 5, LEN(value))))
        WHEN CHARINDEX('пр-д ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-д ', value) + 5, LEN(value))))
        WHEN CHARINDEX('ул. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('ул. ', value) + 4, LEN(value))))
        WHEN CHARINDEX('пр-кт ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-кт ', value) + 6, LEN(value))))
        WHEN CHARINDEX('б-р ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('б-р ', value) + 4, LEN(value))))
        WHEN CHARINDEX('ш. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('ш. ', value) + 3, LEN(value))))
        WHEN CHARINDEX('пл. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пл. ', value) + 4, LEN(value))))
        WHEN CHARINDEX('пр-т ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-т ', value) + 5, LEN(value))))
        WHEN CHARINDEX('аллея ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('аллея ', value) + 6, LEN(value))))
        WHEN CHARINDEX('линия ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('линия ', value) + 6, LEN(value))))
        ELSE NULL
    END AS Street,
    CASE 
        WHEN CHARINDEX('д.', value) > 0 THEN REPLACE(LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('д. ', value) + 3, LEN(value)))),'. ','') -- появляется '.' только для IdDepartment=118 o_O из-за непечатного символа
	    WHEN CHARINDEX('дом ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('д. ', value) + 5, LEN(value)))) -- появляется '.' только для IdDepartment=118 o_O из-за непечатного символа
        ELSE NULL
    END AS Build,
    CASE 
        WHEN CHARINDEX('пр.', value) > 0 THEN 'пр-кт'
        WHEN CHARINDEX('пер.', value) > 0 THEN 'пер'
        WHEN CHARINDEX('пр-д', value) > 0 THEN 'проезд'
        WHEN CHARINDEX('ул.', value) > 0 THEN 'ул'
        WHEN CHARINDEX('пр-кт', value) > 0 THEN 'пр-кт'
        WHEN CHARINDEX('б-р', value) > 0 THEN 'б-р'
        WHEN CHARINDEX('ш.', value) > 0 THEN 'ш'
        WHEN CHARINDEX('пл.', value) > 0 THEN 'пл'
        WHEN CHARINDEX('пр-т', value) > 0 THEN 'пр-кт'
        WHEN CHARINDEX('линия', value) > 0 THEN 'линия'
        WHEN CHARINDEX('аллея ', value) > 0 THEN 'аллея'
        ELSE NULL
    END AS StreetType,
    CASE 
        WHEN CHARINDEX('д. ', value) > 0 THEN 'д.'
        WHEN CHARINDEX('д ', value) > 0 THEN 'д.'
        ELSE NULL
    END AS BuildType,
    CASE 
        WHEN CHARINDEX('с.', value) > 0 THEN 'с.'
        ELSE NULL
    END AS VillageType
FROM 
    dbo.departments
CROSS APPLY 
    STRING_SPLIT(addressString, ',')
WHERE CHARINDEX(',', addressString) != 0
) AS TMP_TBL
where 1=1
group BY IdDepartment
)
SELECT
	IdDepartment 
	,City
	,Village 
	,Street
	,Build
	,SCNAME
	,k.CODE "KLADR"
	,s.CODE "KLADR_STREET" 
FROM SPLIT_ADDRESS sa
	LEFT JOIN KLADR.dbo.KLADR k ON sa.City = k.name
	LEFT JOIN KLADR.dbo.STREET s ON  sa.Street = s.name
where 1=1
	and LEFT(s.CODE,10) = LEFT(k.CODE,10)
	and s.socr = sa.SCNAME
;
```
в выборке задваиваются строки для id = 3, 5 из-за
```
select * from KLADR.dbo.STREET s, KLADR.dbo.KLADR k
 where 1=1
 and LEFT(s.CODE,10) = LEFT(k.CODE,10)
 and s.code in(
 '66000001000203799'
 ,'66000001000060500'
 ,'66000001006005600'
 ,'66000001000117100')
 and k.name = 'Екатеринбург'
 and k.socr = 'г'
 ; 
````
установка дополнительных условий на `INDEX` и/или `GNINMB` влияет на остальную выборку

 NAME | SOCR | CODE||
---|---|---|---|
Ленина   |пр-кт|66000001000060500||
Уральская|ул   |66000001000117100||
Ленина   |пр-кт|66000001000203799|Этот адресный объект не существует или упразднен|
Уральская|ул   |66000001006005600|Относится к с. Горный Щит|

Добавил `CASE` для `SELECT...s.CODE "KLADR_STREET"` и `DISTINCT IdDepartmentв` в окончательный вариант

#### 2.2 Заполняем PlasticOrder.dbo.departments данными КЛАДР
```
/* Заполнение атрибутов PlasticOrder.dbo.departments данными КЛАДР */

-- Объявление переменных для хранения значений
DECLARE @IdDepartment INT;
DECLARE @City NVARCHAR(255);
DECLARE @Village NVARCHAR(255);
DECLARE @Street NVARCHAR(255);
DECLARE @Build NVARCHAR(255);
DECLARE @SCNAME NVARCHAR(10);
DECLARE @KLADR NVARCHAR(13);
DECLARE @KLADR_STREET NVARCHAR(17);

DECLARE addressCursor CURSOR FOR

WITH SPLIT_ADDRESS AS
			(SELECT
				IdDepartment
				,STRING_AGG(City, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS City 
				,STRING_AGG(Village, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Village
				,STRING_AGG(StreetType, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS SCNAME
				,STRING_AGG(Street, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Street
				,STRING_AGG(Build, '') WITHIN GROUP (ORDER BY IdDepartment ASC) AS Build
			FROM 
			(SELECT 
				IdDepartment , addressString,
			    CASE 
			        WHEN CHARINDEX('г. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('г. ', value) + 3, LEN(value))))
			        WHEN CHARINDEX('г ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('г ', value) + 2, LEN(value))))
			        ELSE NULL
			    END AS City,
			    CASE 
			        WHEN CHARINDEX('с. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('с. ', value) + 3, LEN(value))))
			        ELSE NULL
			    END AS Village,
			    CASE 
			        WHEN CHARINDEX('пр. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр. ', value) + 4, LEN(value))))
			        WHEN CHARINDEX('пер. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пер. ', value) + 5, LEN(value))))
			        WHEN CHARINDEX('пр-д ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-д ', value) + 5, LEN(value))))
			        WHEN CHARINDEX('ул. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('ул. ', value) + 4, LEN(value))))
			        WHEN CHARINDEX('пр-кт ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-кт ', value) + 6, LEN(value))))
			        WHEN CHARINDEX('б-р ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('б-р ', value) + 4, LEN(value))))
			        WHEN CHARINDEX('ш. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('ш. ', value) + 3, LEN(value))))
			        WHEN CHARINDEX('пл. ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пл. ', value) + 4, LEN(value))))
			        WHEN CHARINDEX('пр-т ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('пр-т ', value) + 5, LEN(value))))
			        WHEN CHARINDEX('аллея ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('аллея ', value) + 6, LEN(value))))
			        WHEN CHARINDEX('линия ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('линия ', value) + 6, LEN(value))))
			        ELSE NULL
			    END AS Street,
			    CASE 
			        WHEN CHARINDEX('д.', value) > 0 THEN REPLACE(LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('д. ', value) + 3, LEN(value)))),'. ','') -- появляется '.' только для IdDepartment=118 o_O из-за непечатного символа
				    WHEN CHARINDEX('дом ', value) > 0 THEN LTRIM(RTRIM(SUBSTRING(value, CHARINDEX('д. ', value) + 5, LEN(value)))) -- появляется '.' только для IdDepartment=118 o_O из-за непечатного символа
			        ELSE NULL
			    END AS Build,
			    CASE 
			        WHEN CHARINDEX('пр.', value) > 0 THEN 'пр-кт'
			        WHEN CHARINDEX('пер.', value) > 0 THEN 'пер'
			        WHEN CHARINDEX('пр-д', value) > 0 THEN 'проезд'
			        WHEN CHARINDEX('ул.', value) > 0 THEN 'ул'
			        WHEN CHARINDEX('пр-кт', value) > 0 THEN 'пр-кт'
			        WHEN CHARINDEX('б-р', value) > 0 THEN 'б-р'
			        WHEN CHARINDEX('ш.', value) > 0 THEN 'ш'
			        WHEN CHARINDEX('пл.', value) > 0 THEN 'пл'
			        WHEN CHARINDEX('пр-т', value) > 0 THEN 'пр-кт'
			        WHEN CHARINDEX('линия', value) > 0 THEN 'линия'
			        WHEN CHARINDEX('аллея ', value) > 0 THEN 'аллея'
			        ELSE NULL
			    END AS StreetType,
			    CASE 
			        WHEN CHARINDEX('д. ', value) > 0 THEN 'д.'
			        WHEN CHARINDEX('д ', value) > 0 THEN 'д.'
			        ELSE NULL
			    END AS BuildType,
			    CASE 
			        WHEN CHARINDEX('с.', value) > 0 THEN 'с.'
			        ELSE NULL
			    END AS VillageType
			FROM 
			    dbo.departments
			CROSS APPLY 
			    STRING_SPLIT(addressString, ',')
			WHERE CHARINDEX(',', addressString) != 0
			) AS TMP_TBL
			where 1=1
			group BY IdDepartment
			)
	SELECT
		DISTINCT IdDepartment
		,City
		,Village 
		,Street
		,Build
		,SCNAME
		,k.CODE "KLADR"
		,CASE
			WHEN s.CODE = '66000001000203799' THEN '66000001000060500'
			WHEN s.CODE = '66000001006005600' THEN '66000001000117100'
			ELSE s.CODE
		END AS "KLADR_STREET"
	FROM SPLIT_ADDRESS sa
		LEFT JOIN KLADR.dbo.KLADR k ON sa.City = k.name
		LEFT JOIN KLADR.dbo.STREET s ON  sa.Street = s.name
	where 1=1
		and sa.SCNAME = s.socr
		and LEFT(s.CODE,10) = LEFT(k.CODE,10)
		order by 1

-- Открытие курсора
OPEN addressCursor;

-- Получение первой строки из курсора
FETCH NEXT FROM addressCursor INTO @IdDepartment, @City, @Village, @Street, @Build, @SCNAME, @KLADR, @KLADR_STREET;
-- Начало цикла
WHILE @@FETCH_STATUS = 0
BEGIN
    -- Обновление данных в таблице PlasticOrder.dbo.departments
    UPDATE PlasticOrder.dbo.departments
    SET 
        City = @City,
        Village = @Village,
        Street = @Street,
        Build = @Build,
        SCNAME = @SCNAME,
        KLADR = @KLADR,
        KLADR_STREET = @KLADR_STREET
    WHERE IdDepartment = @IdDepartment;

    -- Получение следующей строки из курсора
    FETCH NEXT FROM addressCursor INTO @IdDepartment, @City, @Village, @Street, @Build, @SCNAME, @KLADR, @KLADR_STREET;
END;

-- Закрытие курсора
CLOSE addressCursor;
DEALLOCATE addressCursor;

select * FROM  dbo.departments

```
#### 3. Удаляем новые атрибуты в dbo.departments
```
/* удаляем новые атрибуты в dbo.departments (отмена внесенных изменений) */

ALTER TABLE
    dbo.departments
DROP COLUMN
    City,
    Village,
    Street,
    Build,
    SCNAME,
    KLADR,
    KLADR_STREET
```


