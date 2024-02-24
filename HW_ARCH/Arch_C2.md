## C1(Context) - C2 (Container)
```
@startuml

!include <c4/C4_Context.puml>
!include <c4/C4_Container.puml>
 
'ref http://plantuml.com/stdlib
!include <office/Users/user.puml>
!include <office/Users/online_user.puml>
!include <office/Users/mobile_user.puml>

'skinparam linetype ortho

left to right direction

'3 параметра: ключ, заголовок и описание.
Person(customer, "Пользователь", "Физическое лицо")
Person(security, "Сотрудник СБ", "Проверяет Анкеты")

'System_Boundary(c1,"Система заказа Карт") { // так не работает
System_Boundary(<#abcdef,"Система заказа Карт") {
'4 параметра: ключ, заголовок, стек и описание.
    Container(sys, "Web Application", "Какой-то стек", "Заказ карты для физического лица через сайт банка")
    ContainerDb(db_sys, "PlasticOrder", "SQL", "")
}

Rel_L(sys,db_sys,"чтение/запись", "sync, JDBC/ODBC")

System_Ext(site, "<$online_user> Веб-сайт", "Размещение и  отображение Заявки на выпуск Карт")

System_Ext(card, "Карточный модуль", "Система, которая агрегирует в себе всю информацию по картам клиентов, а так же, содержит информацию по доступным типам карт и доступным доп.услугам")
System_Ext(form, "Система работы с печатными формами", "Система, которая хранит шаблоны печатных форм, при запросе к системе, возвращается pdf-заявления")
System_Ext(conv, "Карточный конвейер", "Система, предназначенная для приема и обработки заявок связанными с картами (заказ, выдача, перевыпуск, доп. Услуги и прч)")
System_Ext(log, "Логистическая система Банка", "Система, которая ведет учет заявок на доставку любых физических объектов между офисами и отделениями банка.")
System_Ext(comm, "Коммуникационный модуль", "Система, которая принимает запросы на формирование и отправку уведомлений любого типа (E-mail, SMS и т.д.).")

'3 параметра: ключ одной сущности, ключ другой тип отношений.

Rel_L(customer,site ,"Использует")
Rel(site, sys, "1.Запрос доступных Продуктов/Услуг")
site <.. sys : "1.Список Продуктов/Услуг"
site --> sys : "2.Размещение Заявки"
site <.. sys : "2.Статус Заявки"

Rel_U(sys, security, "id и статус Заявки")
security ..> sys : "Изменяет Статус Заявки"

Rel(sys,card,"интеграция",sync)
Rel(sys,form,"интеграция",sync)
Rel(sys,conv,"интеграция",async)
Rel(sys,log, "интеграция",async)
Rel(sys,comm,"интеграция",async)

ContainerDb(db_card, "Database", "SQL","текст")
ContainerDb(db_form, "Database", "SQL", "")
ContainerDb(db_log, "Database", "SQL", "")
ContainerDb(db_conv, "Database", "SQL", "")
ContainerDb(db_comm, "Database", "SQL", "")

Rel(card,db_card,"чтение/запись", "sync, JDBC/ODBC")
Rel(form,db_form,"чтение/запись", "sync, JDBC/ODBC")
Rel(conv,db_conv,"чтение/запись", "sync, JDBC/ODBC")
Rel(log,db_log,"чтение/запись", "sync, JDBC/ODBC")
Rel(comm,db_comm,"чтение/запись", "sync, JDBC/ODBC")

sys <.. card : "Список Продуктов"
sys <.. form : "Печатная\n форма"
sys <.. conv : "Статус заявки"
sys <.. log : "Статус доставки"
sys <.. comm : "Статус отправки"
customer <.. comm  : "Уведомление"

@enduml
```
