# Pet project «Актуализация модели данных»

### Описание

В данном проекте необходимо создать витрину данных для RFM-классификации пользователей приложения.

### Структура репозитория

Папка `documentation` содержит описание задачи и структуры таблицы.  
Папка `sql` содержит скрипты для расчета метрик и создания view.  

### Ипользуемые технологии

1. `DDL` для созадния таблиц;
2. `DML` для наполнения таблиц;
3. `Window functions`
4. 'Aggregate functions'
5. `View`

### Запуск контейнера

```
docker run -d --rm -p 3030:3030 -p 3000:3000 --name=de-project-sprint-1-server-local sindb/project-sprint-1:latest
```
