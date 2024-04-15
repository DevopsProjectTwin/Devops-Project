#FROM openjdk:11
#EXPOSE 8082alpine
#ADD target/achat-1.0.jar achat-docker.jar
#ENTRYPOINT ["java" , "-jar" , "achat-docker.jar"]

FROM openjdk:11-jdk-alpine
EXPOSE 8082
ADD target/achat-1.0.1.jar achat-docker.jar
ENTRYPOINT ["java","-jar","achat-docker.jar"]

