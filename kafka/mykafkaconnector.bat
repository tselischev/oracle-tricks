bin/windows/kafka-storage.bat random-uuid
bin/windows/kafka-storage.bat format -t "rDVedKZnQgGBeipQnyLEw" -c config/kraft/server.properties
bin/windows/kafka-server-start.bat config/kraft/server.properties
bin/windows/zookeeper-server-start.bat config/zookeeper.properties

bin/windows/connect-standalone.bat config/connect-standalone.properties

curl -X GET "localhost:8083/connector-plugins" -H "Content-Type: application/json"

curl -X GET "localhost:8083/connectors" -H "Content-Type: application/json"

# sync connector
curl  -X POST localhost:8083/connectors -H "Content-Type: application/json" -d @ofsa-t-sync-config.json
# source connector
curl  -X POST localhost:8083/connectors -H "Content-Type: application/json" -d @ofsa-config.json

curl localhost:8083/connectors/ofsa-t-connector/status
curl localhost:8083/connectors/ofsa-connector/status
curl  -X DELETE http://localhost:8083/connectors/ofsa-t-connector
curl  -X DELETE http://localhost:8083/connectors/ofsa-connector

