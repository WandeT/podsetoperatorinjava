#
# Build stage
#
FROM maven:3.8.4-jdk-8-slim AS build
COPY src /home/app/src
COPY pom.xml /home/app
RUN mvn -f /home/app/pom.xml clean package

#
# Package stage
#
FROM openjdk:8-jre-slim
COPY --from=build /home/app/target/podset-operator-in-java-1.0-SNAPSHOT-jar-with-dependencies.jar /usr/local/lib/tpn.jar
EXPOSE 8080
ENTRYPOINT ["java","-jar","/usr/local/lib/tpn.jar"]
