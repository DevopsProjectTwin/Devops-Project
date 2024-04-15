FROM openjdk:8-jdk-alpine
EXPOSE 8089
ADD target/achat-2.5.3.jar achat:1.0.jar
ENTRYPOINT ["java","-jar","/achat:1.0.jar"]