-- https://www.postgresql.jp/document/16/html/sql-createsubscription.html
CREATE SUBSCRIPTION subscription CONNECTION 'host=postgres-primary port=5432 user=postgres password=postgres' PUBLICATION publish;
