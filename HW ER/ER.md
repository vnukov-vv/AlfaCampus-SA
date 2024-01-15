```
@startuml

' avoid problems with angled crows feet
skinparam linetype ortho

entity "Банк" as Bank{
* БИК
--
**Наименование**
**ИНН**
**Адрес**
Статус в ПС
}

note right of Bank 
Банк как организация,
юр.лицо
end note

entity "Отделение Банка (ВСП)" as Branch{
* ID
--
**Наименование**
**Адрес**
}

note left of Branch 
Внутреннее Структурное
Подразделение (физическое).
Головной офис это тоже ВСП
end note

entity "Подразделение Банка" as Dept{
* ID
--
**Наименование**
функции ...
}

note right of Dept
Сотрудник обязательно функционально относится
к какому либо подразделению (отделу).
Директор или Президент Банка -
это тоже самостоятельное Подразделение
end note


entity "Сотрудник Банка" as Stuff {
* ID
--
**Подразделение**
**Должность**
**Отделение**
}

note right of Stuff
В рамках задания
персональные данные сотрудников
не имеют значения
сотрудник = штатная единица
end note

entity "Платежная Система (ПС)" as PS {
* Код (по справочнику)
--
**Наименование**
}

entity "Вид Карты" as Product {
* Код
--
**Наименование**
и прочие\nобязательные\nпараметры
}

note left of Product
Продукт
в рамках ПС
end note

entity "Тип Карты" as Type {
* Код
--
**Наименование**
}

note right of Type
расчетная
или кредитная
end note

entity "Карта" as Card {
* PAN
--
**Платежная Система**
**Вид** : Продукт в ПС
**Срок действия**
**Держатель карты**
**Тип** : Расч./Кредит.
**Счет Карты**
ПИН
}

entity "Банковский\nПродукт" as BProduct {
* ID
--
**Наименование**
и прочие\nобязательные\nпараметры
}

note right of BProduct 
Для упрощения примем отсутствие
какой-либо сегментации (например по ВСП)
end note

entity "Учетная\nСистема" as DB {
* ID
--
**Наименование**
и прочие\nобязательные\nпараметры
}

note left of DB
В самом широком смысле
end note


entity "Счет" as Acc {
* ID (номер)
--
**"Владелец"**
**Наименование**
и прочие\nобязательные\nпараметры
}

entity "Операции" as Oper {
* ID
--
**Наименование**
**Кто?**
**Что?**
**С чем?**
}

entity "Клиент" as Customer {
* ID 
--
**ФИО**
**ДР**
**Тип документа**
**Номер документа**
**Пол**
**Рез./нерез.**
}

Bank }o--|{ PS 
Bank ||--o{ Card
PS ||--o{ Card
PS ||--|{ Product
Card }o--|| Product
Card }o--|| Type
Bank ||--|{ Branch
Bank ||--|{ Dept
Branch }|--|{ Dept 
Bank ||--|{ Stuff
Dept ||--|{ Stuff
Branch ||--|{ Stuff
Bank ||--o{ BProduct
Card }o--|| BProduct
Bank ||--|{ DB
DB ||--|{ Acc
BProduct||--|{ Acc
Acc||--o{ Card
Stuff }|--{ Oper
Oper }|--|{ Acc
Oper }|--|{ Card
Bank }o--|{ Customer
Customer ||--o{ Acc
Customer ||--o{ Card

entity "Заказ" as Order {
* ID 
--
**Клиент** : FK
**Способ заказа**: FK
**PAN** : FK
**Дата заказа**
**Статус заказа** : FK
**Способ доставки**: FK
**Дата получения**
**Отделение доставки** : FK
}

Customer ||--o{ Order
Card }|--|{ Order
Branch ||--o{ Order

entity "Статус Заказа" as OStatus {
* ID 
--
**Наименовавние**
}

entity "Способ Заказа" as From {
* ID 
--
**Наименовавние**
}

note left of From
Мобильное приложение
отражено только этим
атрибутом
end note

entity "Способ Доставки" as Way {
* ID 
--
**Наименовавние**
}
```

Order }o--|| OStatus 
Order }o--|| Way 
Order }o--|| From 


@enduml
