# poc-kafka-connect-jdbc-source

## Start Kafka Connect
```bash
→ docker run --name=kafka-connect --net=host \
  -e CONNECT_BOOTSTRAP_SERVERS=localhost:9092 \
  -e CONNECT_REST_PORT=28082 \
  -e CONNECT_GROUP_ID="quickstart" \
  -e CONNECT_TOPIC_CREATION_COMPACTED_CLEANUP_POLICY="compact" \
  -e CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR=1 \
  -e CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR=1 \
  -e CONNECT_STATUS_STORAGE_REPLICATION_FACTOR=1 \
  -e CONNECT_CONFIG_STORAGE_TOPIC="quickstart-config" \
  -e CONNECT_OFFSET_STORAGE_TOPIC="quickstart-offsets" \
  -e CONNECT_STATUS_STORAGE_TOPIC="quickstart-status" \
  -e CONNECT_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_INTERNAL_KEY_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_INTERNAL_VALUE_CONVERTER="org.apache.kafka.connect.json.JsonConverter" \
  -e CONNECT_REST_ADVERTISED_HOST_NAME="localhost" \
  -e CONNECT_PLUGIN_PATH="/usr/share/java,/etc/kafka-connect/jars" \
  foo/mysql-connect:1.0
```

## Agregar config de conector JDBC
```bash
→ curl -X POST http://localhost:8083/connectors -H "Content-Type: application/json" -d '{
        "name": "jdbc_source_transactions",
        "config": {
                "connector.class": "io.confluent.connect.jdbc.JdbcSourceConnector",
                "connection.url": "jdbc:mysql://172.19.0.2:3306/example",
                "connection.user": "root",
                "connection.password": "password",
                "topic.prefix": "concentrador-users",
                "mode":"timestamp+incrementing",
                "poll.interval.ms" : 30000,
                "catalog.pattern" : "example",
                "query": "SELECT id, name, created_at, updated_at  FROM example.`user`",
                "incrementing.column.name": "id",
                "timestamp.column.name":"updated_at",
                "transforms":"createKey,extractInt",
                "transforms.createKey.type":"org.apache.kafka.connect.transforms.ValueToKey",
                "transforms.createKey.fields":"id",
                "transforms.extractInt.type":"org.apache.kafka.connect.transforms.ExtractField$Key",
                "transforms.extractInt.field":"id",
                "validate.non.null": false
                }
        }'
```

- Tener en cuenta que se deben crear los topicos internos a mano y no automaticamente, tiene que tener la property cleanupp.policy=compact
- Internal topic: config, offset, status
