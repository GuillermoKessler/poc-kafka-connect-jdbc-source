FROM confluentinc/cp-kafka-connect:7.5.3

COPY lib /etc/kafka-connect/jars
COPY mysql-connector-j-8.2.0.jar /etc/kafka-connect/jars/mysql-connector-j-8.2.0.jar
