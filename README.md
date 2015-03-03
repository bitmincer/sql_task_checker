### Wstępna konfiguracja
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

### Kofiguracja bazy testowej
```
./prepare_test_database
```


### Po dodania tabeli do bazy trzeba wykonać z poziomu psql

```sql
\c sql_task_checker;
GRANT USAGE ON SCHEMA public to sql_checker;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO sql_checker;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sql_checker;
```
