# playground-postgres

```shell
curl -sSf https://atlasgo.sh | sh
```

## logical replication

https://www.postgresql.org/docs/16/logical-replication-row-filter.html

### create publication

```shell
make prmsql f=sql/publication.sql
```

### create subscription

```shell
make secsql f=sql/subscription.sql
```

### insert data

```shell
make prmsql f=sql/insert.sql
```
