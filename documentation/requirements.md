# Построить витрину для RFM-анализа

RFM (от англ. Recency, Frequency, Monetary Value).

Каждого клиента оценивают по трём факторам:

- Recency (пер. «давность») — сколько времени прошло с момента последнего заказа.
- Frequency (пер. «частота») — количество заказов.
- Monetary Value (пер. «денежная ценность») — сумма затрат клиента.

## Выяснить требования к целевой витрине

Требуется создать витрину **dm_rfm_segments** в схеме **analysis** с полями:

- user_id
- recency (число от 1 до 5)
- frequency (число от 1 до 5)
- monetary_value (число от 1 до 5)

В витрине нужны данные с начала 2022 года.  
Для анализа нужно отобрать только успешно выполненные заказы. Это заказ со статусом Closed.

## Изучитить структуру исходных данных

Для расчета витрины буду использовать следующие поля:

| Таблица                | Поле     | Описание                          |
| ---------------------- | -------- | --------------------------------- |
| analysis.users         | id       | Ид. пользователя                  |
| analysis.orders        | order_id | Ид. заказа                        |
| analysis.orders        | order_ts | Дата и время заказа               |
| analysis.orders        | payment  | Платеж клиента                    |
| analysis.orders        | status   | Статус заказа в числовом формате  |
| analysis.orderstatuses | key      | Статус заказа в текстовом формате |

## Проанализировать качество данных

Информация о качестве данных находится в файле `data_quality.md`

## Подготовить витрину данных

1. Сделать представление для таблиц из базы production. Файл `views.sql`
2. Написать DDL-запрос для создания витрин. Файл `datamart_ddl.sql`
3. Написать SQL-запрос для создания 3-х таблиц с метриками. Файлы `tmp_rfm_recency.sql`, `tmp_rfm_frequency.sql`, `tmp_rfm_monetary_value.sql`
4. Собрать витрину dm_rfm_segments. Файл `datamart_query.sql`
