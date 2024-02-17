# Описание БД Plastic Orders 

База данных предназначена для автоматизации процессов заказа карт Банка в удаленных каналах.

![image](https://github.com/vnukov-vv/AlfaCampus-SA/assets/101928718/2f544ce3-c362-438f-ac93-bf983526f492)

## DBML (database markup language)
```
// Определение внешних ключей для наглядности уже указаны в определениях таблиц

// #region

// Описание таблицы dbo.cardTypes
Table dbo.cardTypes as cardTypes [note: 'Тип Карты']{
  idCardType smallint [primary key, increment, note: 'Первичный ключ.(2)']	
  idCardSystem bigint [null, note: 'Идентификатор в источнике данных.(8)']
  name nvarchar [null, note: 'Наименование карты.(50)']
  
  Indexes {
    (idCardType) [pk, unique] // clustered
    }
}

// Описание таблицы dbo.clients
Table dbo.clients as clients [note: 'Анкеты Клиентов']{
  idClient bigint [primary key, increment, note: 'Уникальный идентификатор.(8)']
  firstName nvarchar [null, note: 'Имя.(255)']  
  middleName nvarchar [null, note: 'Отчество.(255)']  
  surname nvarchar [null, note: 'Фамилия.(255)']  
  birthday date [null, note: 'Дата рождения.(3)']
  regAddress nvarchar [null, note: 'Адрес регистрации.(255)']
  idDirStatus smallint [null, note: 'Статус.(2)', ref: > dirStatuses.idDirStatus] // Внешний ключ на dbo.dirStatuses
  createDate date [null, note: 'Дата создания.(3)']
  PIN_EQ nchar [null, note: 	'Идентификатор Клиента Банка. Заполняется для действующих клиентов.(6)']	
  
  Indexes {
    (idClient) [pk, unique] // clustered
    }
}

// Описание таблицы dbo.departments
Table dbo.departments as departments [note: 'Отделения выдачи Карт']{
  idDepartment int [primary key,increment, note: 'Идентификатор.(4)'] // clustered
  name nchar [null, note: 'Наименование.(255)']
  idDepartmentsSystem bigint  [null, note: 'Идентификатор в системе-источнике.(8)']
  workTime nvarchar [null, note: 'Время работы отделения Банка.(255)']
  phone nvarchar [null, note: 'Телефон отделения Банка.(255)']
  adressString nvarchar [null, note: 'Адрес Банка.(255)']
  
  Indexes {
    (idDepartment) [pk, unique] // clustered
    }
}

// Описание таблицы dbo.dirChannels
Table dbo.dirChannels as dirChannels [note: 'Канал поступления Анкеты']{
  idDirChannel smallint [primary key, increment, note: '[Первичный ключ.(2)']
  name nvarchar [null, note: 'Наименование канала.(50)']

  Indexes {
   (idDirChannel) [pk, unique] // clustered
   }
}

// Описание таблицы dbo.dirStatuses
Table dbo.dirStatuses as dirStatuses [note: 'Статусы Анкет']{
  idDirStatus smallint [primary key, increment, note: 'Первичный ключ.(2)'] 
  name nvarchar [null, note: '(Наименование Статуса.(50)']

  Indexes {
   (idDirStatus) [pk, unique] // clustered
   }
}

// Описание таблицы dbo.dirStatusesOrders
Table dbo.dirStatusesOrders as dirStatusesOrders [note: 'Статусы Заявок'] {
  idDirStatusOrder smallint [primary key, increment, note: 'Первичный ключ.(2)'] 
  name nvarchar [note: '(Наименование Статуса Заявки.(50)']

  Indexes {
   (idDirStatusOrder) [pk, unique] // clustered
   }

}

// Описание таблицы dbo.orders
Table dbo.orders as orders [note: 'Таблица заказов Карт']{
  idOrder bigint [primary key, increment, note: 'Первичный ключ.(8)']
  idClient bigint [ref: > dbo.clients.idClient]               // Внешний ключ на dbo.clients
  idDirChannel smallint [ref: > dbo.dirChannels.idDirChannel] // Внешний ключ на dbo.dirChannels
  idCardType smallint [ref: > dbo.cardTypes.idCardType]       // Внешний ключ на dbo.cardTypes
  idDepartment int [ref: > dbo.departments.idDepartment]      // Внешний ключ на dbo.departments
  idDirStatusOrder smallint [ref: > dbo.dirStatusesOrders.idDirStatusOrder] // Внешний ключ на dbo.dirStatusesOrders
  createDate date [null, note: 'Дата создания Заказа.(3)']
  editUser bigint [ref: > dbo.users.idUser , note: 'Пользователь - Сотрудник Банка, кто вносил изменения.(8)'] // Внешний ключ на dbo.users
  updateDate date [null, note: 'Дата обновления заказа.(3)']

  Indexes {
   (idOrder) [pk, unique] // clustered
   }
}

// Описание таблицы dbo.users
Table dbo.users as users 
[note: 'Пользователи Системы. Сотрудники Банка, кто имеет разрешение на редактирование Запросов и Анкет Клиента']{
  idUser bigint [primary key, increment, note: 'Первичный ключ.(8)']
  login nchar [note: 'Логин Пользователя.(10)']

  Indexes {
   (idUser) [pk, unique] // clustered
   }

}

// #endregion

Ref: "dbo"."departments"."phone" < "dbo"."departments"."idDepartmentsSystem"

```
