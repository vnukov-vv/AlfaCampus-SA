## C1(Context) - C2 (Container)
```
@startuml
!include <c4/C4_Context.puml>
!include <c4/C4_Container.puml>
 
'ref http://plantuml.com/stdlib
!include <office/Users/user.puml>
!include <office/Users/online_user.puml>
!include <office/Users/mobile_user.puml>

'так стрелки будут лучше, но наслаиваются подписи к ним ...
'skinparam linetype ortho

'поэтому так:
skinparam linetype polyline

'ограничиваем ширину элементов (текст без переноса)
skinparam wrapWidth 250

'задаем "направление" диаграммы так:
'left to right direction

'или так:
LAYOUT_LANDSCAPE()

'добавляем легенду:
LAYOUT_WITH_LEGEND()

title C4. Система заказа Карт. Container diagram (С1-С2)

'3 параметра: ключ, заголовок и описание.
Person(customer, "Пользователь", "Физическое лицо")
Person(security, "Сотрудник СБ", "Проверяет Анкеты")
Person_Ext(user, "Сотрудник", "Внешний пользователь печатных форм")

System_Ext(site, "<$online_user> Веб-сайт", "Размещение и  отображение Заявки на выпуск Карт")

'так правильно, но "не работает" фон...
'System_Boundary(c1,"Система заказа Карт") { 

'поэтому вот так :
System_Boundary(<#abcdef,"Система заказа Карт") {
'4 параметра: ключ, заголовок, стек и описание.
    Container(api, "API Gateway", "Yandex", "Заказ карты для физического лица через сайт банка")
    Container(rec, "Сервис рекомендаций", "Какой-то стек", "Формирует актуальные наборы доступных и/или рекомендованных продуктов/услуг")
    Container(sys, "Сервис Заявок", "Какой-то стек", "Мастер-сервис заявок")
    Container(print, "Сервис печатных форм", "Какой-то стек", "Управляет печатью")
    Container(delivery, "Сервис логистики", "Какой-то стек", "")
    Container(conv, "Сервис конвейера", "Какой-то стек", "Отправляет акцептованные Заявки в работу")
    Container(int, "Сервис интеграций", "Какой-то стек", "Актуализирует в мастер-сервисе статусы Заявок во внешних системах 'Конвейер' и 'Логистика'")
    ContainerDb(db_sys, "PlasticOrder", "SQL", "")
    ContainerDb(db_rec, "DataBase", "SQL", "")
    ContainerDb(db_int, "DataBase", "SQL", "Журнал событий")
    ContainerDb(db_delivery, "DataBase", "SQL", "Журнал событий")
    ContainerDb(db_conv, "DataBase", "SQL", "Журнал событий")
    SystemQueue(queue, "Очередь", "отдельный топик \n на каждый сервис")
    SystemQueue(queue_e, "Очередь", "отдельный топик \n на каждую систему")

note left of rec
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из внешней Системы 'Карточный модуль' \n список доступных и/или рекомендованных \n продуктов/услуг по клиентам|
end note

note right of print
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из 'Мастер-сервиса' данные для \n печатных форм|
|GET| Получить готовые печатные формы \n из внешней Cистемы|
end note

note bottom of conv
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из 'Мастер-сервиса' данные Заявок \n акцептованных СБ|
|POST| Разместить задание \n во внешней системе 'Конвейер'|
end note

note bottom of delivery
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из 'Мастер-Сервиса' данные Заявок \n готовых к доставке|
|POST| Разместить заказ на доставку \n во внешней системе 'Логистика'|
end note

note bottom of int
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из 'Мастер-сервиса' \n список Заявок со статусом 'отклонена' СБ|
|POST| Разместить задание \n на отправку уведомления \n по отклонённым Заявкам|
|GET| Получить статусы Заявок \n во внешних системах|
|PATCH| Актуализировать статусы \n в 'Мастер-сервисе'|
|POST| Разместить задание \n на отправку уведомления \n при изменении статуса|
end note

}

'базы данных Системы:
Rel_D(sys,db_sys,"чтение/запись", "sync, JDBC/ODBC")
Rel_U(rec,db_rec,"чтение/запись", "sync, JDBC/ODBC")
Rel_U(int,db_int,"чтение/запись", "sync, JDBC/ODBC")
Rel_U(conv,db_conv,"чтение/запись", "sync, JDBC/ODBC")
Rel_U(delivery,db_delivery,"чтение/запись", "sync, JDBC/ODBC")

' комментарии
note left of site
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить информацию о\n доступных продуктах/услугах \n из 'Сервиса рекомендаций'|
|POST| Заполнить Анкету/ \n разместить Заявку на Карту и/или услуги в 'Мастер-сервисе'|
|GET| Получить актуальную информацию о Заявке:\n из 'Мастер-сервиса'|
|PATCH| Изменить данные Анкеты/Заявки или \n отменить Заявку (изменить статус)|
end note

note left of security
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить из 'Мастер-сервиса' информацию об \n Анкетах на проверку|
|PATCH| Изменить статус анкеты (акцептовать/отклонить|
end note

note left of user
<#C80815,#FADADD>|=<color:white>Метод |=<color:white> Описание|
|GET| Получить информацию об \n Анкетах Акцептованных СБ|
|POST| Сформировать печатные формы по шаблону|
|GET| Получить готовые печатные формы|
end note

'связи
Rel_D(api, queue, "producer/consumer", "Kafka (?)")
Rel(queue, rec, GET)
Rel(queue, sys, POST/PATCH/GET)
Rel(queue, print, GET)

Rel_L(delivery, sys, GET)
Rel_L(conv, sys, GET)
Rel_L(print, sys, GET)

Rel(int, queue_e,GET/POST)
Rel(int, sys, GET/PATCH)


System_Boundary(ext,"Внешние Системы") {

System_Ext(card_e, "Карточный модуль", "Агрегирует информацию по картам клиентов (содержит информацию по доступным типам карт и/или услугам)")
System_Ext(form_e, "Система работы с печатными формами", "Хранит шаблоны печатных форм (при запросе к системе возвращается pdf-заявления)")
System_Ext(conv_e, "Карточный конвейер", "Прием и обработка заявок связанных с картами (заказ, выдача, перевыпуск, доп. Услуги и прч)")
System_Ext(log_e, "Логистическая система Банка", "Ведет учет заявок на доставку любых физических объектов между офисами и отделениями банка.")
System_Ext(comm_e, "Коммуникационный модуль", "Принимает запросы на формирование и отправку уведомлений любого типа (E-mail, SMS и т.д.).")

ContainerDb_Ext(db_card_e, "Database", "SQL"," ")
ContainerDb_Ext(db_form_e, "Database", "SQL", " ")
ContainerDb_Ext(db_log_e, "Database", "SQL", " ")
ContainerDb_Ext(db_conv_e, "Database", "SQL", " ")
ContainerDb_Ext(db_comm_e, "Database", "SQL", " ")

}

'3 параметра: ключ одной сущности, ключ другой тип отношений.

Rel_U(customer, site ,"Использует")
Rel(site, api, "Использует")
Rel(security, api, "Использует")
Rel(user, api, "Использует")

Rel(rec,queue_e,"интеграция",sync)
Rel(print,queue_e,"интеграция",sync)
Rel(conv,queue_e,"интеграция",async)
Rel(delivery,queue_e, "интеграция",async)

Rel(queue_e,card_e,"интеграция",sync)
Rel(queue_e,form_e,"интеграция",sync)
Rel(queue_e,conv_e,"интеграция",async)
Rel(queue_e,log_e, "интеграция",async)
Rel(queue_e,comm_e,"интеграция",async)

Rel(card_e,db_card_e,"чтение/запись", "sync, JDBC/ODBC")
Rel(form_e,db_form_e,"чтение/запись", "sync, JDBC/ODBC")
Rel(conv_e,db_conv_e,"чтение/запись", "sync, JDBC/ODBC")
Rel(log_e,db_log_e,"чтение/запись", "sync, JDBC/ODBC")
Rel(comm_e,db_comm_e,"чтение/запись", "sync, JDBC/ODBC")


footer Кампусёнок Вова (с)
@enduml
```

[Картинкой](//www.plantuml.com/plantuml/png/pLbRRnl75NxdhvZI1KW1D1cd3X08hXjPKfsqRknKDe801OGLkRA9a5nskOmjr04aigtiAl4b3qtG5cc5jE-KHCRKXT9VcFb7FT_PuMYMomj5E8aVH96xS-xVkSpCUxN0yODwkPJuMR6IBzKBhhYMlvfRlBgww5K2zr6GhTBBwqFVEiMAw-lt8f7otNNn80YgyxbSjUHKm3IRzygvMb0e5TSi3jxwUZ7lvkxLNB-MgzSCZn4hl4g91ArENbZsregboC94IZLaInu9jQKQQbDsvB4yabqXzrHJjbLJDOGyfd_RwediP8JioLDyjDGMBMp9hjodxyzKWyYV2tacJsMRFhjg2poEiBGhJqGscqsaQfyMArN7Tye2sWORLLTuVl308nr0gBvK3I8_KKqHgZIV649HzKeR-06YKtb06hSWGss7giWEIIDLk_IYAtlWzQKynbFwwx60VP6c_nrv18l9Jlhw2fftO3ti8zrRSvRiXxvJ_RXO21w8jzzv2t9VaPosbfM4C-GPwx4FIMnn9obeHLUsj8OdPDQECIjLSjS34NZ2Bzv_48X2qNVpGT6hW7UNU7JDobiBdzo-TtVrriA7IokB2tUMqtDOqoOhza9vwZbhmO8F81mnCtGVVt3t_TLRopUNFrm2PL0CIgvOl9eLSbTsOJuxfYNOeYFwUuKV_w28Rgf6LXW4auhEVRWYBNUlN9QxRqEDNy1fBMrUXy7JcXV4vfZmi9q9cHwGgiTmElqT2M3YLCEZ5JegcxX3mFGgwNoz5dXbry-GI_yDAlK5SG1b2thYTnBl_ajKhpZW7U9oH2iw0ZvJVvMdoRa-jvgRh_l5O0CKk_8KsW7FBFC8vhzCiY2r2H68FJm9FBoWDKTipuvXjxhyA4WZQOQoOqvVoHuHFU4dX_3CK0j2d6tpWvxQKNyHwi_4RbEUaAp4oaOjSCiih5OCN69xxUTMQbyN9AKZzowpzmvLWmN_XyE623pjWmz-5j0IEE40VN_-wclP8bFtmoJl8TxxQeS0t8GtJV197LCP3BgxC04Pekj04ZOBVha7SKW98cMRP8zpNfjqmwjN2ew_aSvVoIGdWm_onPz4l338VSWHMh7vn23xQvUSjNp1NPzUI29rzS8upWZDUGIYXH3dkPDsgaMAqyAT3yHD9t0VEXi8soTEfU0-uW1-tTSCCbalAXMoZTo69mVG3atwU6y9Vhx95Ko30XKDce0N1J6g2jKPHZ0JxKDf0MhcomKIPOqO4uIX6lp4xmul8mB6Qfs7Z5lPvLH0wc2nQj2F5d02V0DlFOsEJROArPNNd6dyosvErxoO9l0sBD4BWS9Jb3T8mSiSC8lc90zYbjOsQWEM6kGZWXEj-vTiuJV8aMuMbrSMbq6fLRzO2M9oHwNyH2M-E-yhONMoUAalrBEO_89RAdxc-Xin5G3T0vqGNQJ-9DanrdclybcCBOXxA9_oa1-t9fhqhMh4ZC9o0bs7NZJieCUgrRvLQrGpfk8mtsC6W7IquMcH_U8SniW-6-7xGfwCG8RiX5nQeALlEn70SUN2X-aI0CAMNQFeGOhqYdWqXGAJalyS25yhDMZyqbgwiBOQelvEoQa5nVnjl-3wC6ZberluDvmaB0bBJk3SS6hknENmyT3bykzazIPd-p4CG-VPONKFXtCoM7qzx83FMLc5NUIZkbjtqt_49oFLrDQsdZpGuTgoOuhReM2ydl58yOUAxgP7t6xR_Dx6noXPgwz5MbCzYy29qoDHyG9NyB3fhGkATEBQfSLttthtoZkPIxzUM5fOMhh--9VNybx9y-SVFg29uphLlGwBQOk1Dq9-6srpZnEFRoxVVIpqiDR418wo990p5j81PNlUn22SwdTWid9RMoTFmkeEWrCmK6rfWPm-itSEy1hRF7XQuuOFkr0mC0eyJhYLWe07jHzvM8SZkSh_UAvCZMn6L0VW65CkzTG0WqSsdP6oC5Y4hW4hcm7pDWpK3lWF2_AY7UEO-zQyWEPx-0-f-cQwpoxOC79uOu8xiOCWkNTkhq2mcS4XHmitkqJM4Up0UC1dqHRG6T80nlYnNq5_Ab_AtUbzQSCB_hDI6hC0TbmJtMd6P5I-ABLgJktWU2yTu-8tAD5Z5T5sC9v5nWyKGv62or7NW2bKDl2P2RdiyLDhTeF7LPDnseQi_ic7gJwdmXQkNcfWdDWZNMjqEHexIq725ECKh5ouk_W-SHyoqeK9FKmMinyNZKxg1tSWbdKP5hgfyKlPZGQvPKFtSsoNzw0ExxIYnSggpFE9txkbrINU8kcPCQcs-IthcsFr6MZXA5BRgD2C-9kb6ukvs_IHd6C6ztWtgIV8sHXWcDGpvMmCUEZJmz-CBCmOQesa5sQLI0azV-XZHamt25Tq0iEXpezLJdhzVXrkUzGpWX-05P-ZehCH4iUQZV3JzFjKjEAFF3imwS5f6vw5GMFePX-mDNDSrJRZAMHL2PpwzCoX3QYioSzIj3inQKUvAtPmWMbwb0_j-jMPXsScbcwh3drZyfabHrkcVVIOY-nyjRMGXXgYESGTbROAHhoCpiKQdG6cFYrzGthTAD_BFNQ1SHF0gS5nTdwG2q-CSRdj4KJUk5oau_CUA7AHBifCHZeInxG_POOFzz2BASVONSCnqX_7xWMurQidE9RHhRxv6hOOjeDJQei8dgDhwyx59whzZNhLzmhrlEldg0dKwkNmoEEtplgdZaZ_QYwiysczc0yxIBV8GpuqWGTo39dSu7lUxcaoLk2MQHfCR3ZY3JfH_2cpi1ypVtxMFmEWnpae4OgsbskzY2Xst4sNZvderKDdeDdZY3joiP1t_08VEKpOWkkJi0EkyGVM6TXmvEaTD7F4N6UsqzQbsnQuSuP-BxlZECMw5F7ZQVqCh8sSeNq0An1ro-Hrpo-poT4x0VimSKV43cgH1GQHuAeFJVzdhXmRKTplZDvqYxGUw7YKu5g5aaUM3EvFCDVIedq8KKzneQAlLgk5zSlcxDdCYb5B6NqZWXixh3NtNrs8rXSPU-S-WPSZfzt2vA6f7_2Q7NLYaZxVg6NuQWaj3ax9c3jM-y8fmx6MPraXlxDRUPTBkjeUCB3atMVx8hiuSpi2NICEXGKlpMq8NzDXtcOSeoxXIzJ6uNjBN0N9FLWSlv71peCzzpSCGnhiY6LuBaVlGC8b_IIqp1pjcJ3YZNLlansCQhcienhEcAe9Cgn4qY2ienAOuykBJq8iHH08oCBUUDatzuZJRLeWcbqKta-PP1NfvSjbfrZAY9NVhO2RQcHbEpi70nFM0IwRYJbU5oS-nbspZt6JWaY6K22tXrE8KIJ0qCKea5ON9YcFrIln-SGRT85OufwLJp48ha_n8qHynbhLvj9yW7NQyHmqNloa7vziGkztp3KxxqO4jOzl29lckZeiyhfhXfVGt6t7BjFJunHBCHzDMCRhqAZxdJ4PlyHHpvCPxCAOgUwkKoz7D2UjTinoq-iDYHXFmqJzjGpeoJgPzO3pHTR3bibMM0GQ_DCJQ21FOREsrQJnB1loVg_McJqZ4-qLdRapCWazfUl5R2oqxtGvc8598h7kqGpiy-PNdeHDay_Ik5Tz5HPhZ5PpYVTeOgwNI_y7)
