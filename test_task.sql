-- Задание 1
/*
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
*/
-- 1. Создание схемы geo_test
CREATE SCHEMA geo_test
    AUTHORIZATION postgres;
	
-- 2. 3. Создание таблицы test_point с атрибутами и первичным ключом id
DROP TABLE IF EXISTS geo_test.test_point;
CREATE TABLE geo_test.test_point
(
    id integer NOT NULL,
    task integer NOT NULL,
    x double precision NOT NULL,
    y double precision NOT NULL,
    z double precision,
    PRIMARY KEY (id)
);
  
-- 4. Создание таблицы task с атрибутами
DROP TABLE IF EXISTS geo_test.test_point;
CREATE TABLE geo_test.task
(
    id integer NOT NULL,
    name text NOT NULL,
    PRIMARY KEY (id)
);

	
-- 5. Создание условия fk_task с внешним ключом task для id из таблицы test.task, при обновлении и удалении ничего не делать
ALTER TABLE IF EXISTS geo_test.test_point
    ADD CONSTRAINT fk_task FOREIGN KEY (task)
    REFERENCES geo_test.task (id) MATCH SIMPLE
	ON UPDATE NO ACTION
    ON DELETE NO ACTION;
	
-- 5. Запрос для просмотра таблиц	
select * from pg_catalog.pg_tables where schemaname = 'geo_test';

-- 5. Запросы для атрибутов таблиц и их заполнености
select * from geo_test.task;
select * from geo_test.test_point;

-- 6. Создать индекс idx_task_id для колонки task
CREATE INDEX idx_task_id
    ON geo_test.test_point USING btree
    (task ASC NULLS LAST, id ASC NULLS LAST);


-- 7. Вставка значений сначала в таблицу task, т.к. значение task в таблице test_point зависит от id в таблице task
insert into geo_test.task (id, name) values
('1','name1');
-- 7. Вставка значений в таблицу test_point
insert into geo_test.test_point (id, task, x, y, z) values
('1','1','1','0','0'), 
('2','1','0','1','0'), 
('3','1','0','0','1');

-- 7. Проверка как заполнмились значения в таблице test_point
select * from geo_test.test_point;


-- Задание 2
/*
1. Установите в PostgreSQL расширение PostGIS
2. Добавьте в таблицу test_point поле geom типа geometry(Point)
3. Запишите координаты из полей x,y,z в поле таблицы geom, используя справку к PostGIS.
4. Выведите поле geom для всех записей таблицы в формате GeoJSON, используя справку к PostGIS.
*/
-- 1. Выполнить установку через Application Stack Builder

-- 2. Добавить колонку geom с помощью метода AddGeometryColumn(varchar table_name, varchar column_name, integer srid, varchar type, integer dimension)
SELECT AddGeometryColumn('geo_test', 'test_point', 'geom',4326, 'POINT', 3);

-- 3. Добавить заполнение координат x,y,z, в строки с id 1,2,3
UPDATE geo_test.test_point SET geom = ST_GeomFromText('POINT(1 0 0)') where id = 1;
UPDATE geo_test.test_point SET geom = ST_GeomFromText('POINT(0 1 0)') where id = 2;
UPDATE geo_test.test_point SET geom = ST_GeomFromText('POINT(0 0 1)') where id = 3;
-- 3. Проверка заполнились ли значения x,y,z, в строки с id = 1,2,3
select * from geo_test.test_point;

-- 4. Вывод поле geom для всех записей таблицы в формате GeoJSON с помощью метода ST_AsGeoJSON(geometry geom, integer maxdecimaldigits=9, integer options=8);
select id, task, x,y,z, ST_AsGeoJSON(geom) from geo_test.test_point;
