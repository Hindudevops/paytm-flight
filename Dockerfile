FROM maven:3.6.0-jdk-11 as build
COPY pom.xml pom.xml
COPY src src
RUN mvn install -q

FROM azul/zulu-openjdk-alpine:11.0.1
COPY --from=build /target/flight.jar /flight.jar
ENTRYPOINT java -server -XX:+UseNUMA -jar /flight.jar

#NOTE: you should replace 'latest' with the specific version you want
#docker build -t flight:latest .
#docker history
#docker run -d --name flight-instance -p 8098:8098 flight:latest