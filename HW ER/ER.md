>Заказ карты для физического лица через мобильное приложение с выдачей в отделении

![SVG](https://www.plantuml.com/plantuml/svg/1C714K8n20N0ErMycstO2XeqZ0GoW6Ri_k_Ugpdxkupe1lw53koCXyag7Eq9zhV9m3FZ55uYJVLHtvoyOEhI_os8x1b4udtrNZszRHL1_BwVOfLJQc5pHqAeeQg4aA1IaBXmiVA7Lj2uSfn3bLYAxP8MkTHG8hMoQ1C34bV7pGil_cD_XTblnCnltjhxyfwLz40FJVVDpiwVt_nsPlsWzjYkq6_KfmaDLsnvrwwLTtxODmNBmjVKDSMYAHJe3Il4DAQ8rQOqW7fCKQ4Wcwzv-uqkVwLpTqYHQ_0dzLoJ-gxfMgvXQM3fX7gcRinEfRPbgm--lr-pbMsuiyP7O6d82_vlocRU9Mx-PIj75BlEHyQzS8Sb6b7CWYd7lsd5Mf39M_PvJX6hH1gYLTDYrwxII-hHoItDirhUsRWlcNvnv_eiqwdvB7xSsjOaOCiQjZ_XT9kiA3Oc54a0FH6u5Ws1nI6CHuRXcC9adnDCXxpgdY3js3qLXpIK0xTAXdxdnGYXYOrBXaaq6Lxt2-SzjVA7BjY29fe7KBxND530vyxMezeDqN5FN4jEIfKejgLIALDdc3CSr3G1unodfT9qvZgeSLF2SS_5l4sPdFAgFzyI4x9WO68srd0TCoSEguvTomf3w4nqP_dfkXTs5NOWSoq1zvXYr8tB9FIp58iPfYsaN0qeJrmpf5JHN8NUDNXpBE71JYTCYxUN5o2erhnSUO2boxHUszlUjc6XbdjG8X-3H1SA8Hj_3d7svh0uKqLuOvfRc1zB5EudAzNZio24L6D64OVS2ElcsfAxwkY7xATJ4rOPkJHMUSQNlIcssOXSXCHwzfpzrBfdsckWsx4KyLwC0qVKpxy6euHn5_vCJsuIH6Fq2cvNsYdkhGDVwWgklC6SakXdm630qJpLE9X6rrwLUX33Iw6KcErpDatNLcVLokRUHYtmUArD9ga4Wq1OyjrEtfroRUpCMAQbYm1YEzFBaW0CUC_kjN4P6gHhBl3a0VidXp2xcjGtF7Hkdb6MTp1WnBzh21LyeOs_eqFUGytzJaveFgRaudnUhcuYfdktlzA0hYK5BegMhL2mdzWqH7x6YKuF6qEB6tK92mDXhx-14UzVBCh32NYyeA4egezJJRhqCNKNIPRWHA48m1OodCWyDlNiT1UCCKnYkcGcf6BNYHXo3ztaG_3ErtZXNbhnYC7dqDJyp_xogp-DPcpH1ngOjm0OJNG-1owByodW6gp_JdD0dz0vjIf5NbZabe-hdJmIyXZqLqW-pYh53fsQQnyKFNzhsQzqPJzx61ptZ68b8JvvP-pQ_7UqRD1eQaZYziP6aWKmcYewINEJliNNnCyATxJ2oVoVcOQlEnqjle88zkj7MrLxysTSLwRoPxh-9rZtB6RCM3v3brsm2CJHjh6tMwiydBkqYS-_-TQzzRVxDBZ4qWAcCXiMz4lmyhWkqy0S7-doL5uWt08cSW1h3HElvtgbM3pObp6btmS7nM9b7mtEi33p2MtVvaMi5WvoPUYyQbOFwbit5EdRJkMslX3Pb98-7I1FIVHSMXQciPONbHUcmrWpVFtqGpXil5OWudyX7d27cFT192D_yAtwuRUU217tN31-eJ7hoRHCJmUyUeKsnKyq9N5rCqEfW7cO17U_14-bH-5jTOPtbneHoYGQFCu2zMFSiVuLLTa9VvsbT_DzdSjIpj10PeZw2rs8ihob5s-r9G_B75lgicuog04OBRrMGIMUDQ5M06ugjrUBt1JhzLgvjhSReftRD0PvZxOGawpfkzNAm_Up6pPn73VqXzYcEFpDe3DgfBymzBZHLp3RKv7-0i4XxlZuGIX-ZU20qsUk1OrnqFxpipfELmUPVLj-_3w9_GS0)

```PlantUML
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
