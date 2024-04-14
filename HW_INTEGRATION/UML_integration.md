# ДЗ Интеграции
## Задание №1. Обновление справочника ГАР

- [Описание службы обновлений (скачать .pdf)](https://fias.nalog.ru/docs/Описание%20службы%20получения%20обновлений.pdf)
- [API-сервисы ФИАС (swagger)](https://fias-public-service.nalog.ru/api/spas/v2.0/swagger/index.html)
- [Руководство пользователя API-сервисов ФИАС (скачать .docx)](https://fias.nalog.ru/docs/SPASDesc%20v2.0.docx)

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




