sudo -u postgres psql postgres

CREATE DATABASE sql_task_checker;

CREATE USER sql_checker WITH ENCRYPTED PASSWORD 'sql_checker';
GRANT CONNECT ON DATABASE sql_task_checker to sql_checker;
\c sql_task_checker;
GRANT USAGE ON SCHEMA public to sql_checker;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO sql_checker;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO sql_checker;
