# ДЗ №7 (DB Design)
- *FSD.md* - Домашнее задание: Структура БД для сервиса  "Доставка заказа Карт"

    - [x] Требования к Системе (на своё усмотрение)
    - [x] Нормализованная структура БД (3-НФ)
    - [x] Описание БД
    - [x] Пояснительная

- *ParcelDelivery.drawio.png* - диаграмма картинкой
- *ParcelDelivery.drawio.xml* - диаграмма в `xml`

# ДЗ №8 (DB SQL)
- *SQL_KLADR.md* - Практическое задание по теме «БД и SQL» (КЛАДР)
    - [x] Описание целей и задач указанного проекта;
    - [x] SQL скрипты:
        - [x] добавляющие новые атрибуты в PlasticOrder.dbo.departments;
        - [x] разбирающие адресную строку dbo.departments.addressString и заполняющие адресные атрибуты КЛАДР в dbo.departments;
        - [x] удаляющие новые атрибуты в dbo.departments.

# ДЗ №9 (DB PostgreSQL )
**Легенда задания**: в рамках проекта по импортозамещению нам предстоит перевести БД с MS SQL Server на PostgreSQL.

[How to configure a Linked Server using the ODBC driver](https://www.sqlshack.com/how-to-configure-a-linked-server-using-the-odbc-driver/)

- Задание:
    - [x] Установить PostgreSQL;
    - [x] Сформировать скрипты на создание структуры БД PlasticOrder для PostgreSQL. Создать БД и таблицы.
    - [x] Создать связный сервер MS SQL Server с PostgreSQL.
    - [x] Перенести данные из таблиц MS SQL Server в таблицы PostgreSQL.

- Результат выполнения - [2 файла](https://github.com/vnukov-vv/AlfaCampus-SA/tree/main/HW%20DB/POSTGRE_SQL):
    - [x] Скрипты создания структуры БД в postgreSQL с комментариями, поясняющими различие типов данных.
    - [x] Скрипты на перенос данных с комментариями, поясняющие преобразование данных.
