Wstępna konfiguracja
```
sudo -u postgres psql postgres
```
```sql
CREATE DATABASE sql_task_checker;

CREATE USER sql_checker WITH ENCRYPTED PASSWORD 'sql_checker';
GRANT CONNECT ON DATABASE sql_task_checker to sql_checker;
\c sql_task_checker;
GRANT USAGE ON SCHEMA public to sql_checker;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO sql_checker;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sql_checker;
```

Stworzenie bazy testowej

```sql
CREATE TABLE articles (
  id bigserial primary key,
  name varchar(20) NOT NULL
);
INSERT INTO articles (name) VALUES ('name_1');
INSERT INTO articles (name) VALUES ('name_2');
```

Po dodania tabeli do bazy trzeba wykonać z poziomu psql

```sql
\c sql_task_checker;
GRANT USAGE ON SCHEMA public to sql_checker;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO sql_checker;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sql_checker;
```
