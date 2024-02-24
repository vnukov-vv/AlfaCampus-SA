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
[В plantuml](https://www.plantuml.com/plantuml/umla/dLRTRXDN5xsVfpYVlqfnfCbOj5oX255-RYfQQ2FKcqhHU3o6KMsFDJEkYAfA9O46IaLARwZQ2uhe0oIE3Ov39gzmveswrXuVZoScmGG9Z7tsNdljjN_EkH8dRfJqsYtB-b_GyLgzXgzMlOkrQnVNhuMTnB-VE5sSNdxlgHjq_6Xohgobo6-gUqdIlLIhTLjkXwYE5xPhST9e1VKPXB3P33o_TYVsexZMYmt6QHPXfuL0wnysR8Vre5Koj9RYxuDErutSjY98ij7rLHWbzqBBQldDH2MXYeAxznBL22BVIuAm0v_Fb3xMkzdFUbU_qyDia_-xfFHO7sRFicrRwRSusTUfFiJVFlwEbHufdS9hb3t0sP4UwQ5ZtGQfi5FrUd4Ijlt8LXNzabxPRq209s9iwY6_LtZsBxpU0c5R3u4oXiLG8SGe-qMdbMM35ljUBmgI3NgyqYdPPLjw83772ZyzhqWWa6Q88Ovtc8JIlyDcBFay1PorjBOH9tvx_MhOwpJSQAFgNR09YHH82wdlIgRmsUMdqdzHb6opign-LBMQWXKE5L27IiJQ8nry8eHr4dpr_sxTQ_ZDnKDOInS_kWwsof5FguZ2dsddLkED659zwzVLvzrkA_1Srf_gaOOKu605QEaKLCvU6BvWGdRKK-a1IEsexE5S3S7FL75NyNTaCOIpq3fWNVR8ZrYLvJB1w_LgexwUixpTSkCay6v53JyYZRMlR_83BZzPrZT-Q_scf3EnhsJRmbZIhebEeaJUQV56nxFL5zUlNglTmZ_0CEMwSJ-fna7YmsZravcvkwpq7u3RMp6iHOb_g8AKvec9HTcLj46gzwHoRueZA8TUxEinQtF4SlUpf_eusw9KHUtBT3mtQZ2Od18N6Xx1xK0XSge7sPOPe79ZsIoF424Dr8Qz8jhlmump8qFHHo6O6VdruVqC6G3_8Tq8WxAD-EEnJgVrPZzA6p8j63FPleq0PYIOD5kH_AJWRm2oUGOop59I1wjZoUuTeKRu8g4ahW2ypv8_wMD7P3p4x_jqWeep8ZR3g3sdK36qw62m9PKXrELM4cI4A-Zowm8gPuy4zKWIpXup0CUJW2VmiqTJT1j7-1p9HCj_KrO5sA1LXAEed7DOzINSatpPu7n7THlD5RfBXntcJPVjb6NmmiuFf_JIc1ovB_K1ApQVwOJZaAkMVSz_uSuuHungLa2UIUupMK9xXT3I-rEQQPvW7r-O-54X-uDIi-6NQh4dxNnk1X9VUELBPNQQRDCLIhysRS788-6NRI-NXMc5TvdmtxAl9EbYXv5hgGpCwxdPMOiCNbzKuxY1754ton9Gm6bZ0nWR8jjItF9wZtqolrP7-564_PLhEHz0nGR1f0tecz85fY8UqoOZaYXQGqwAvUkSR9LsEs-L58Rle9zSiFdOibVEkOIaEuZ5OqfHwldigOXHZDqelyRD3MOo4NiZ58ABmcHgqYCpqMzo0vbjegetLjfkqBBLsfThGCE1emVEChF_qCC7aQNvKu23wbRsX5_oPh5dh0QoNVTfDuahdCNuiQ7dvBVMLpvUN_KmAXv9l7wKNT5_edh7vhMKRsjmXC_aWiglnGkEVb78DxSTsIRo4cA9JAFKYf40eiHRTHm2gak2-2g_BAKtptRFlLTMBXllJvtvM_74rLUP2mcdLsnyycOI9MEHwKx-Lfbv-mKD9NlY53yaPeoLunXwK9NKICiy2iyEB67b1gwmQwMjUObo2hXTRJubbgUMl6OMi-GcFitIBPlARbhCL8RsR5FhnEjgyhouxYPktOtzwTEg8WXZ2WmjJpWnptadVipRalw2fXHbSTlswHH44CdCPFYn3q82I9Ocs_C0I3uch_C0KBjSmdEvYqP6guy5i3Wo75Bg9xDpzbgeJ1sebpYyB9ux7AplEZFFgSASwj2yF8flYr4iJ274d6NftYnPC-rvyzBjGNEpUGiVSNhzdajbYArmnUyqUktMVm00)

[Картинкой](//www.plantuml.com/plantuml/png/dLRTRXDN5xsVfpZVV9NYI9EnQBb24QByt5Iqq4QeDvMYyNWCeywFDJEkYAfA9O46IaLARwZQ2uhe0oIE3Ow3nwzmveswrpu-7e-DWmaI6FlilVRQQ_-SSoNDd2JhX87nFpzoWqxJ4vlknVgrYzlNuYZpxcTscmull_VKyIClcPmBOotnMk9UbhKlrUljm8a0QhjnM4-pPk0tPX3YLijtlVgTr4lIUYVL6CiiuYYWGDiVDWpZXXzK38srz7i_QZk94mg0P3jjJyH9TYysZC1hPIABHUBVlPU9ffzuRkR74Vby9kHO7XO_oqFvJlQBNVplaf13ULeyA_Oj8T_IoR7CvIdzxTBVeP038NFo6XGFw6ma1x9l6xU9L1pLt4wQnQ6NMCAKB-5L_4O8v4anTcKVtqsS_KjURmbXN_O9PKWMVK4X1iKlCZVNDLhgkPt4ptRWyKhcO5VioHx770hwwRd9WOWqGlJf-0192FaxsGmvdwS4PwnjxQIP5svVZJjHqqbsQku5Yo2H0cXHweUSAVaSubF8lo1AiMkkYnz5lIx8YWu5eVO5YtKaS_o64COy-ER_dORRz5ghXp3MBdvq7IoXa9TLHD2VQUVMqfsKfFhMQuZFs-t0TntK7-g11XVWP8FGyYaedxtGV8a9s45F8Nj4wa0K3nTgIFnq5Gy5VgSi-kJCj4vGboFm0vQvNYLulL5hDhOLozk1asQ-UojfUWbeR7rz4n_ayfDXVEC5spSvdOczMUmpOqwxpZgn4ghJqft8jSGNrwzUgz-YVmX3b-l6_QoM-fb7HfkVpCpTPI7_8BYZ3SsQbVW7Ad1fdkXOa5rm6-JoY2ltfZmYvQWNktA8senGxcxnL8wBFKXLrhvAntMI9eBnAN19mn6vdGYAdCjUiQS7gDfO5ih3H423QeDUOUsFoGmpmqFHfK8WC_3halSpoe3m7y8DC5Is0NuSotnQR_GZjo7I8cCasxKeW1u998rM13yk-1i2sJq3cSnoK2TMOyxk7Q06z0MXT5o8ksZ9FycnpJAUqk_7S28LPqHinKcue50vjDJ1n1PK-gGkjX8ZKxYIBhwke7BnY557d73n604mdW2SmoyUJT4jEgBF0Kyq_pT7LGYRQ9NX82hcdAow7Ew9MZPqVY3QpTO6tBd3JbNJ5GTL6Tmu-c59Bmt14VjIdg1YxyqKnFfOjUXx_4lkY3D2LBq2L2RAPxA4ZagXLUzhchbAi4jVaFYebFr1fTdebrgv9oqrDpsEpxpKKfcT9ajtXP2lTLiWye3v5VlhLM62-2uI_flt5ITTxZ1mhPG1UJtNEskLmUkoQXWt8WVKtQe4450tDkMB3L7i2MnvUOG-MLoh0_gHXVqLQraDe423qAJru9l3XKnPFAGDHY1HjWQVbClNdc-LC5IjafFXEzAFBrWrjkYLSouXxWvWuHXIL7g-UCfYb6CtKDUuli5q9colXQBWh32OwlJ0ZFMRt41wcuZQZOtGyGDBR7svHMXqOCkUlOxiF_JmWU9e_fp0YUfUyGHVLBDOCrOztgx7oexZCcSsVgpfsUhM-igZrrSZJif74guVOPdoJwhUMB-MrBOcZkGpkQ3KjNZ1bYzA-HQs8ze4Bo4kaMwKUZaIXCZnDcqRWE8I8xvIboNtvjdkodjZuxBs_jHUl1NdhZvp8IGvlKBZWpUIg1YpJ7VKMsNcxUSt1U-99NwKc3OMjgtfaQgW1bhwKNXsO0xBDx29haLRyoMAAS1sjV2KM9zQuffPpHARU9cbKpNbtRIQAG_jsQR6tEjgyhouxcHEmqczwTFAP8GX12OjvvoGvw8JFXPjGNz5KuYokcsud08Bmfdf33_sGGW0pb9dUnu0paVdTHu0QASaF9SxQwIr-bW00oE38OL-F3jdhmLpwW2zsE5b-Tp1O7qNpJodIdEe0_FgABujHx4q9I4MB2ltPiKQQI-QLsuFcElDM_gmq-ltN2fzqxZYHSrE6Fm7)
