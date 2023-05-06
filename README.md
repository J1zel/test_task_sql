# Задание 2.
## Условие задания 2.
1. Создайте схему  geo_test в БД бд PostgreSQL
2. В схеме geo_test создайте таблицу test_point с
полями:
id целое,
task целое,
x с двойной точностью,
y с двойной точностью,
z с двойной точностью
3. Создайте первичный ключ на id.
4. В схеме geo_test создайте таблицу task c полями id - целое, первичный ключ и name - строка.
5. В схеме geo_test создайте для таблицы test_point внешний ключ с поля task таблицы test_point на поле id таблицы task.
6. Создайте индекс для таблицы test_point по полям task,id
7. Вставьте в таблицу test_point записи (1,1,1,0,0), (2,1,0,1,0), (3,1,0,0,1)
8. Выберете вторую запись из таблицы test_point

# Задание 3.
## Условие задания 3.
1. Установите в PostgreSQL расширение PostGIS
2. Добавьте в таблицу test_point поле geom типа geometry(Point)
3. Запишите координаты из полей x,y,z в поле таблицы geom, используя справку к PostGIS.
4. Выведите поле geom для всех записей таблицы в формате GeoJSON, используя справку к PostGIS.

## Источники используемые для решения задач.
### Задание 1 и 2.
1. https://postgis.net/docs/
2. https://postgrespro.ru/docs/postgresql/15/index
### Задание 3.
3. https://oracleplsql.ru/random-postgresql.html
4. https://postgrespro.ru/docs/postgresql/9.5/functions-srf
5. https://antonz.ru/random-table/
6. https://postgrespro.ru/docs/postgresql/9.5/tutorial-agg
7. https://postgrespro.ru/docs/postgresql/9.4/queries-limit

