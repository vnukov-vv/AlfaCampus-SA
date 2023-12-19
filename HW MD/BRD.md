<table width="1000" border="1">
<thead>
  <tr>
    <td rowspan="3"><img width="300px" src="https://github.com/vnukov-vv/AlfaCampus-SA/assets/101928718/6c8664d3-2b42-4c23-9b08-686f390ca366"></td>
    <td colspan="2" width="700"><p align="center"><b>Бизнес функциональные требования<br>Доставка карты клиенту курьером</b></p></td>
  </tr>
  <tr>
    <td>Дата</td>
    <td>19.12.2023</td>
  </tr>
  <tr>
    <td>Версия</td>
    <td>1.1</td>
  </tr>
</thead>
</table>

# Бизнес функциональные требования <br> “Доставка карты клиенту курьером ”.

## История изменений

|Дата |Описание изменения |Версия |Автор |Бизнес-заказчик |Согласование<br>бизнес-заказчика|
|:---:|:---:|:---:|:---:|:---:|:---:|
|19/12/2023|Согласованная версия документа|1.1|Внуков В. |Еремчук Е.|---|


## Оглавление
[1. Общая информация](#title1) <br> 
&nbsp; [1.1 Термины и определения](#title1_1) <br>
&nbsp; [1.2 Ссылки на существующую документацию](#title1_2) <br>
&nbsp; [1.3. Контактные лица](#title1_3) <br>
[2. Бизнес цели и бизнес требования](#title2)</br>
[3. Функциональные требования](#title3)</br>
[4. Нефункциональные требования](#title4)</br>
[5. Возможность поэтапного внедрения](#title5)</br>
[6. Критерии приёмки функционала](#title6)</br>
[7. Приложения](#title7)</br>

## <a id="title1"> 1. Общая информация </a>
### <a id="title1_1"> 1.1. Термины и определения </a>
|Термин	|Определение|
|---|---|
|**Встреча**	|Часть процесса **Доставки**, относящаяся к непосредственному взаимодействию **Курьера** и **Клиента**|
|**Доставка**	|Комплекс мероприятий, осуществляемых для передачи **Карты** **Клиенту**|
|**Карта**	|Банковская карта (расчетная, кредитная) на физическом носителе выпущенная на имя конкретного **Клиента**, либо неперсонифицированная.|
|**Клиент**	|физическое лицо на имя которого в **Банке** открыт счёт и выпущена **Карта**|
|**Курьер**	|Физическое лицо осуществляющее доставку **Карты**|
|**Система**	|Комплекс программного и технического обеспечения предназначенный для поддержки бизнес-процессов **Банка**|

### <a id="title1_2"> 1.2 Ссылки на существующую документацию </a>
|Описание|Ссылка|
|---|---|
|Use Case "Встреча"|[ссылка](https://github.com/vnukov-vv/AlfaCampus-SA/blob/main/HW%20BPMN/about.md)|
|UML диаграммы (UC, Sequence)|[ссылка](https://github.com/vnukov-vv/AlfaCampus-SA/blob/main/HW%20UML/UML.md)|

### <a id="title1_3"> 1.3 Контактные лица </a>
|Подразделение	|Роль в процессе| Фамилия И.О.|
|---|---|---|
|Альфа-Кампус|СА-Кампусенок|Внуков В.В.|

## <a id="title2"> 2. Бизнес цели и бизнес требования </a>
Обеспечить **Клиентам** **Банка** возможность получить **Карту** [и начать ей пользоваться] в нужное время и в нужном месте.

## <a id="title3"> 3. Функциональные требования </a>

### User Story
- Я, как **Клиент**, хочу получить **Карту** [на **Встрече**], чтобы начать ей пользоваться (**MVP**)
- Я, как **Клиент**, хочу изменять способ **Доставки** и атрибуты **Встречи**, чтобы мне было удобно [получить **Карту**]
- Я, как **Курьер**, хочу получить **Карту**, чтобы передать её **Клиенту**
- Я, как **Курьер**, хочу получить атрибуты **Встречи** (время, место), чтобы выдать ему **Карту** (**MVP**)
- Я, как **Курьер**, хочу получить оптимальный маршрут для **Встречи**, чтобы тратить меньше времени на дорогу.
- Я, как **Курьер**, хочу передать в **Систему** информацию что **Карта** получена **Клиентом**, чтобы **Клиент** мог начать пользоваться Картой (**MVP**)

### Предусловие:
- **Клиент** сделал заказ **Карты** (любой удалённый канал: телефон, веб, приложение)
- **Клиент** идентифицирован в **Системе**, досье (персональные данные) **Клиента** заведено в **Систему** и заполнено корректными данными.
- **Клиент** (предварительно) выбрал доставку карты **Курьером**.
- **Карта** выпущена (в **Системе** есть реквизиты) и находится в статусе *«Не выдана»*
- **Карта** (физическая) находится на хранении у ответственного сотрудника **Банка**

### Пост-условие:
- В целях безопасности, активация **Карты** производится **Клиентом** в **Приложении** **Банка** или иным способом (например в устройстве самообслуживания или по телефону)
 
#### Требования:
- Формирование/отображение списка заданий на доставку (**Карта**, **Клиент**, атрибуты **Встречи**) // **Система**, **Курьер**, **Клиент**
- Изменение способа **Доставки** (**Курьером**, **Самовывоз**) // **Клиент**
- Изменение атрибутов **Встречи** // **Клиент**, **Курьер**
- Создание оптимального маршрута **Курьера** для нескольких **Встреч** // **Система**
- Изменение статуса **Доставки** // **Курьер**
- Изменение статуса **Карты** в **Системе** // **Курьер**
- Открытие счета **Карты** (при необходимости) // **Система**
- Формирование/проводка в **Системе** [бухгалтерских] документов по учету бланка **Карты** // **Система**

#### Алгоритм:
- **Клиент** сделал в **Системе** заказ **Карты** через удаленные каналы и выбрал **Доставку** **Карты** **Курьером**.
- **Курьер** получил бланк **Карты** и атрибуты **Встречи** из **Системы**.
- На **Встрече** **Курьер** идентифицировал **Клиента** и передал ему **Карту**.
- **Курьер** зафиксировал факт передачи **Карты** **Клиенту**.
- **Курьер** передал, а **Система** получила, данные (подтверждение) о факте передачи **Карты** **Клиенту**.

## <a id="title4"> 4. Нефункциональные требования </a>
- При взаимодействии участников с **Системой** должно обеспечиваться соблюдение правил информационной безопасности
- Реквизиты **Карты** отображаются в маскированном виде.
- Время взаимодействия с **Системой** в рамках одного цикла запрос-ответ не должно превышать 60000 мс
- Отображение атрибутов **Встречи** доступно только её участникам и уполномоченным пользователям **Системы**.


## <a id="title5"> 5. Возможность поэтапного внедрения </a>
### Минимальный функционал (MVP):
- Формирование/отображение списка заданий на доставку (**Карта**, **Клиент**, атрибуты **Встречи**)
- Изменение статуса **Карты** в **Системе**
### Промежуточные этапы:
- Изменение способа **Доставки** (**Курьером**, **Самовывоз**) // **Клиент**
- Изменение атрибутов **Встречи** // **Клиент**, **Курьер**
- Изменение статуса **Доставки** // **Курьер**
### Финальный этап:
- Открытие счета **Карты** (при необходимости) // **Система**
- Формирование/проводка в **Системе** [бухгалтерских] документов по учету бланка **Карты** // **Система**
- Создание оптимального маршрута **Курьера** для нескольких **Встреч** // **Система**

## <a id="title6"> 6. Критерии приёмки функционала </a>
|Номер критерия приёмки	|Описание сценария приёмки	|Ожидаемый результат|
|----|-----|----|
|1.	|Просмотр списка карт:<br>- **Клиента**, <br>- Выданных **Курьеру** [или любое другое представление] |статус **Карты** в **Системе**:<br> *«Получена клиентом»*|

## <a id="title7"> 7. Приложения </a>
### Приложение 1
 [BPMN-Диаграмма](https://viewer.diagrams.net/?tags=%7B%7D&highlight=0000ff&edit=_blank&layers=1&nav=1&title=bpmn#R7R1bc5u4%2Btf4sR7Encc4cfacM%2B1M57R79vKyQ2xis8XGBdLE%2B%2BuPAEkWkgiCIMApndYFWQjMd79qYdweXn5J%2FNP%2BU7wNooWubV8Wxt1C14GjafC%2FfORcjpiGXQ7sknCLJl0GvoT%2FBGgQXbd7CrdBWpmYxXGUhafq4CY%2BHoNNVhnzkyR%2Brk57jKPqXU%2F%2BLuAGvmz8iB%2F9Ldxm%2B3LUtbTL%2BL%2BCcLfHdwb4Bx98PBkNpHt%2FGz9TQ8Z6YdwmcZyVR4eX2yDKXx5%2BL%2BV19zXfkgdLgmMmuCB%2B%2BDt%2FH7oW%2BQ8QJsWE8hK8wvnrH5vgr1%2Fj5MfNP3%2Bef%2Fn4b%2B9%2B%2FQGQJyN3TLMzfhvpc3iI%2FCM8W%2B2zQ74qgIdp5icZAh18CGP1GB%2BzL%2Biq%2FHwTR5F%2FSsMHMrKPk%2FAfOMuP0ABe%2BWOYr14ui4buwyi6jaM4KZ7BeCz%2BFLdN4m8EKvCpV8%2F7MAu%2BnPxNvsQzREg4xr8m9OZ%2BBEkWvFBD6Ff%2FEsSHIEvOcMqZALW85PmCAcDCcN1T4Ncx9H2Edjuy2AUy8AC9W3yKYCUGtBBMCJQ%2F%2FOgJgWYBX6N3k3%2BuVsWnW3xaxefdAr5RF11EwRO%2BgIy8SfyOj3EBYD8Kd0d4uoEvLkhyqFJwQHMoJMhfZwjp5gZddgi32%2Fw2QqAk8dNxG2wR7JM487Mwzq%2F64GlCmNXjqhQg0bcfMMwQYC0errYAqkZ7oMpBEd%2BfBiMLolMcHrPixtYK%2FtWWurXQb7XinwUn3BaDojGHHwT5GV6hOigacyzRkkBwb3ZMFwwKlxTcW2MeEv6FKLr3T%2FkbObzsckGzfDgdjsvMT7%2FVYRgkKMyCCLat0pJJAa2Ku5ucE0HGk6Dz4OXkHzF28swrv%2B0nP%2FlWzPcfIPX4OfUqQ1vTtipoq%2BtLi2dIQIC5rqUKcwGPuTkDui%2FYzbr4NBHTyY91zIzgiFYc23gO%2FNSob%2FNVi6X04hTgRciF5TSn%2BDQmytEkMYHQvzQq6M6yigsGz8Isa0AW5hm1iEBDjIB6XYUqAb6OJRccvxegw%2BVy%2BHmDgJ8f34rEnEZNqLvvWoSY5d3hZznfoySph5%2BEiNcSDcv78reAn7czN5%2B5OUvCDqOE6AJeLtItXVUkDHSngxoCzAKk%2BP8G7HUt8WwRtl5mo%2F8bsBM%2FCTe7unY94gU%2FChCLeP%2FH3Hj6HKch0k8f4iyLD3BCYVWt%2FM23XYGPIvuElR9ZfBIJoVOQhBCQBfpBaEHDNvh8GVrFT1kEkfmW2Lc5zvrpqTx5DF8KUkCz8rvsodEbHnf5jz0fHuL8Fx2CNC3sXGVIbRlVpDZ4qSRAaUsdSrscBgdbaNij0zjJ9vEuPvrR%2BjLKyPDLnI9xDrkCL%2F4OsuyMTF3%2FKYurWANfanL%2BHV1fnPyRn0AcRKd3L%2FSXd2f6jAJ6Gx0CgSqNn5JNIKFrQFt9F7y2IJbo%2Bft6FfRJEEGz7UfVUaIAlJ5Yw7jD2gMRw7R4Xi90O8qJ%2BiGBR7uCoUtplYVoF%2BHOx9KPQsObo%2BValTEJoLDyL0Knyk7vWoAbYzZHm8QHhm6zoN1MQmtYW2qO5VXoFqOTNGzR6p%2Fz30NNiR8fU4hlLPDJQ7wBH0wgBI9i0u6ZGoEB%2BqYyBhIYNTSrypltxiQs%2BQG6SgG4jHpLkRBfqTlbVduR6NjEBHCpr6oK%2F2WySc28oTiETc1Zz2r5rJaz3ND1pqaWG7wW%2FpPrMFg1adRhFLDXN8JS4CaZTawrNbGC45a2ruAih%2FDoZ4GukD1BOV51%2FAGT9%2FyZAv5kquNPbgecLiUOKx1fk60ykpTM5YRprdxskpL1uLyDoH72z%2Fok0DnZx4eHp7QRnS%2FYixzdBH3R%2Be7567n4rcHLJnpKC5aoEpur0laAzMM6DAxvXGF7ka9%2FVMTreMKW0LeEtJ2Yy8CsCY%2FfVQML0zXyMTb2YuTrFUq7AgsfU%2Fl1W%2Fim2TdR1Fj4BhjXwsc%2F9LVY8AoH5BhnHRPzpS12jfLR8XHe2WKftsV%2B8I9PeXKXOhUCMArx%2BAa7aY2rQ0zPYG%2BhQ%2FTPLmWB%2Bd3dfv%2Bfs07uf7P%2B83us%2F%2FX1cf2R4CPD03C%2ByoR1B4yFP6fuYM6x7PfjaEkzKG%2F8pOJt2QVQICmVLIY5MdvUnIPZdWTeKFcwVKZimnoCwTLzpyvlT6M4gllzz%2BT13kH9wJ7ADXwx%2FzScbwGP76lgr1bjhBEizdbPfIwHFIJwWlUtBjXqYSW%2BYDvIeotnoEUmIBNyBIJkXqMfUHasBjKo55%2BrgRBEBFASVwOZentAdaoGqnHA3FBOFw0lJNPZziztTSN3vms1kCENyJpqIOItGKscqIaRkgR5OnWd5M6UqS64HIL2qV0S3e6Rf22FHW03gEqHoZPirUpO%2Fex0uy6nG5UmE6a5ov%2Fl6aGdDGtNRMBhnM%2Fm0nV5%2FqgJ6MjTl9hn1zspiZJGZzX7StVskRsgg6slCvGa8QG49lIDHFoP6gbAT%2FT2MMuKDq3QUgRQl5ffrnBkplve9CwwZoHBetf0SQoMGb8x7XQLoof4mfa3FVYOghCTGhQctzd5K4qc2Ubx5tvXfXgsh3NjBk2qKsG9Ot%2BClzD7nWBHmFFLwbPLSvnJmTrp6MTDwdomJ55saAgzvkYXHo0%2FWHF%2FY3CdRAvZVhB4ifJXcsF1biG2QEpnF1IcpbcFNuIITuWeUcj0JHEIl7lMxA3sjJNthvjAhfZJrtmYfMDsHTY1JMhKnmEp0Oxiksz60lT1JWWGB2tQC7yNQuXIXVq2InZl6c2mx9ztowkVCAOQ7%2FZRzXAyoP5rWqbpeZbjmY5rc5ghMkgNsNRc0zMtw8j1Fw8n2vSPJS1VDMUqdDsCHUO5NFkHNNCWjH0jq16yXAMA5mkUCzd3lBSFnhWR%2FpVEMbDYDiBA85a6413%2BOMPCrqbAfvq5bm6%2FtfC4snzC6W2aQBK%2FH8JrzhLVZH0BA6XzaDXtr66m0oQgVB8kBFy72k5i8gRldTfK5hrGd1XD2NpQs5k8LNdc6rwje9hMUc1qRufrEw84TUpCPKipuYKmh3%2BmJiCOUKvguazXGOXo1WnvDfPhQfkEvbI%2B%2FFZZ0dVXlxWcdNLYlFisZc6usGm7wiDDhlem6X%2BfIpVclrWVHIE7TFjl5SyBoYrN6gLSuX42S5TrZj4LphVOIU8%2Bp%2FuMrcv1n1Wfwru1qffpoMgxhaSCdv%2FDdlYBvKf75w0PqlLqOC3MYwqKB44PAiBQ3q%2FKlwDqSK%2BTL0FzGLJcTNyXAICtXKMW9TRd0QhicPU25bhLzZyyS7dnJHLwdkPVvsQTRiLMhMbh%2FRNLERuM9wPNEJvgg3F%2Fq4Z5TD8KQ1C2nzDM5H3GBClnp%2FHsNG5pa3gsmwHe0vP40O94jfMlGpVeo2tDug8NZjWTcW106bI5uzZm10bJbqo2FCDbR43n26ipcr2jzKM1VY0k7ApPalRrtnkghg6qjaVHqHKlS7Lh7avrkK2iiIG1Xuh0WW7bvEW6XJ5B%2Bscoft7s%2FSRb%2BscjKoX%2BS6dwMwoeswXfDCEpgafOS2YzksvjvWQiUeWow6S5xvPdcsYurVRaozRXk6MJ2aMlYI%2BqytCI%2BjEj9YzUnZDatVmk5jDaEGC0oQ6j67uTvJoW8LqvE4lffhcZeqlVzSLqNpJRKNipvigqu6J4TC6KtwS6FAZZNink7R%2BJcG3B%2B2%2BBJ23S4qKcZpMWF4qo70TNJrYP7kTVxbyGjoTwe9IWhO1hHb65FbVkWtPct%2FoK05ra9q1u3zAHMK1FSNLmeI2rbXsM7to7Q3QGYnPsVjwKa%2FmFval5F%2B2vcCFNAx9wNv8040QYzfrpTG15ZpWOFlOPG1ldelPPcaOpx40g4vtRFCgVGlx4WmDWDRsowpUzs0bO0XezRo711KkEmexRgnxTBiZuINgIS3dikHxFOQBCIE9FOcCm25uVg2Jb68krA3iXJtZUXVOeKNq7RcJNpM0fbdRis1UQsCotVK%2BYwHR7rdq15bcN5u9KVmOZLdqJWLRp6YVWp5owdZCi9Hlhxxp19mxNQ4NWbS9FjuOOXTCvMNprMF5gXdD0XKRvsjnz%2FcHUGbtBY9HXHk%2Fbhv4hPm7RxOIrNLVUULboTjb%2B9gtF2Eyrx%2FxB4TGWsYv%2BsnGnrGARASjhvx6xRw8AjE%2BbQ3HZFj1AZ%2Fa8NQZuAQkwTVf4ooxK8Hok7pUQm0Ol6liVq8pj%2FtoJa6iEA%2FVSmUAKWvopb3kRXqBQf3UFiQrdkUkSXd4rv7%2F%2Bbr%2Fj8GZW9cRWe2vezO75xq2knDePU%2FZTs%2F846IJ4fSsIWOw3KwjeUFVCJpsxxvpXlaNJTb8pOf5Jh6ol3QHleLNTgE6s5ePsDl5hzRUmMjsSaNXdbea%2BINfmbnhKle7LAXSW5wvykIlcGMbd4EqUaFxhPH2wtCGWqw6eNuQKai8l%2Bc4cmP25A7Os4jh%2BYFbU16sRmecM8jmDvJ4f4z7koxWNeRIM%2BgolLLZbxkjhfSNA5hL48fnLdZbA874WQQJsTyKz47bHFvUD5m2Py28d0UYkwm2PQQdLa9Fl22NxxxSpvW15v8I0thLpuvmxJQ3Oms2PXZ4GB937WBeEd%2B%2FkNz%2Bu65elUf4meovMW%2BpCkizD%2BKEsav69rHSb%2FVAT8UOlQfIj3LQQZK1JiNv6eOy8F0MUkiurn4R1T2uRB5hOMnvFdaxVd3O6o0qfVqhvQ85hhME%2BTI66ViVfYT0nTs6Z6W%2BmPyZHCTTT36COYG9i9DcT30x8qojPMZqJb%2BAixquKwuBwf3Oa3FCxbZ31%2BmkMqFRHYURbFCN7riGjyD%2Fk1HV8SEtbVyJYrdvfn2KS1svbB0Y1nK1RrXPlN7VYI4PzcrOZj858tCF9fnQthpg1cwBpbAevwgCSSpRmJQmuxhorJGq2jB61TCWlEkHlE0Pz862f7gtVA6CTz34GAXQsRnTNXFQyVeNTcKTzTwXjTKLpZT8Hj97RASw1AyeHdqklWNpmJVkwb9psOIteMgZxiWLjnvEIVxojZ9gnMkZ%2BquF4uJ8cogQL8NsSyeao8qs5lsatpnqvWAnZ8B5JqSZPVuuC9eJ9VtpTZHfqsWSpB29ZPsru2My2PFy5jCzhWE7DQqppRm3l2kwzg9CMbANxXbYLkYqCCNYp07VWjSTV1i2kmGQ8fSaZHknGNSii0fINBwYkHOndW70RVTWHQXjT60g5LlPkabH9r1VTjkRi1nuknJ7kQ68U%2BAaakS19wmg6Bs3YDM0YLKp3pRluIdWeZ%2BNda2goQUmGYLTWBNMdx1vsyTKmEe8xWR75Pu9WNzwHrH4mWEs1qjs%2FqXxQW%2BgqjfM4xtWM87g9xih2hMY0kXe6GhIek2ZoswmEqvH9p7ckKlpMHqHrraWA3kdPAQWUM267GIbFu2wUXb5dDEM6jiTpQNzwz9Q0FKp75ZHZPEak111IsVyyK2EKexi%2Fa7JUqnFRosxwqsJsqRnuwAJNfhcCUzaRRQVZsiFJw3aWmt2RMg3W8BEs1lmuwdMkjjN6eh6a%2FhRv8wKW9f8B
) 
<br>
<br>
![](https://github.com/vnukov-vv/AlfaCampus-SA/blob/main/HW%20MD/bpmn.drawio.png)


