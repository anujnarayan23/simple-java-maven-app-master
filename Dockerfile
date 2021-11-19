FROM maven:3.3-jdk-8
#openjdk:8-jdk-alpine

COPY . /project
WORKDIR /project
RUN  mvn clean package && cp /project/target/spring-boot-hello-world-1.0.0-SNAPSHOT.jar app.jar

ENTRYPOINT ["java","-jar","app.jar"]
