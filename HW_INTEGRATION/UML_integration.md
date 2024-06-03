# ДЗ Интеграции
## Задание №1. Обновление справочника ГАР

- [Описание службы обновлений (скачать .pdf)](https://fias.nalog.ru/docs/Описание%20службы%20получения%20обновлений.pdf)
- [API-сервисы ФИАС (swagger)](https://fias-public-service.nalog.ru/api/spas/v2.0/swagger/index.html)
- [Руководство пользователя API-сервисов ФИАС (скачать .docx)](https://fias.nalog.ru/docs/SPASDesc%20v2.0.docx)

![SVG](https://www.plantuml.com/plantuml/svg/ZLDTJnD157sVNt7J5qiZ3V6nKO89I514muVXWOGCT20RjxljpYoYJu1H7oJYnxD6ZJzWHIi5PFqBT_wHPsQxQomnyMKwS_RSS-wPkPtIHYOcxOJ212PKn1_uArzmpiTypdti1jmdky-_x1vd07FxmeDdd16_uzVyKOWk58BDe2iZGxMjGEfc9CDukvcaDPAQ728sujs_UVo9-z0yve7TfxM8yr5VUpGqy29Q9JkYbwfKKUsEt7eeFTgxf0arUm21dvmLTO-rK57RsOk5s2YIcqciDRM8tn9Iv7pX-MT57V49Odxd3347XFxwE9uZxubzYduFm3egED_i7g0JBt5AZZ5ibw2JyxazT9_y1pI3HFODNs1zQP-HCoWFPTLQr6ZmU_x2dnkDrh-UWLmkrolEs7aNiCWzZFF1-iENdOBi_94WTydieNtLX8SGGgOcZjBEXag4SBTAuvF-YN0bYpDBopGximpYh3BpKflf-54Knh9zAmZLNBGL5nNNnyVBaciJ4oswlNHl0JNr1ohHGHpDjQ_EocJrxloq2erSMPmV--FaVrleRZXFI8OrA-yMAfK8MWqD2HLgl7c5qWsgzbTgfUvgARnoV_hcyapT11s5oUvqn_wllepJ7kQjZmR038bBuRTbijvsbFNTJjXy4dH7OnO3Xe0OTOn5Pf_pm8U4zgIxjQgWHyKrrdTac2ez9Z2u9RweUe2CX-0-n7GtZhGgUVYfqbCb8iGK6dV_xjy0)

```
@startuml
title Обновление справочника ГАР

participant "fias.nalog.ru" as fias
box
participant "Сервис \nобновления ГАР" as serv
queue "Kafka" as q
participant "Система" as sys
endbox

Note across : В контексте задачи реализуется загрузкой из ГАР только изменённых данных ГАР \n**НФТ**: Обновление с максимально возможной скоростью. \n


autonumber

serv -> fias : REST GET \nGetLastDownloadFileInfo
serv <-- fias : 200: JSON \n(VersionId,GarXMLDeltaURL)

serv -> serv : сравнивается \nVersionId

alt 
else "VersionId = VersionId'"
serv ->X serv : UPDATE(timestamp)
else "VersionId = VersionId'"
serv -> fias : download(GarXMLDeltaURL)
end

serv <-- fias : gar_delta_xml.zip
serv -> serv : конвертация \nXML>JSON
serv -> q : JSON(values)
sys -> q : Request
sys <-- q : Response
sys -> sys : UPDATE (values)


@enduml

```
## Задание №2. Расширяем клиентские данные




