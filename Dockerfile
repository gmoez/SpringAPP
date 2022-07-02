FROM openjdk:8
EXPOSE 8080
ADD helloworld-1.0-SNAPSHOT.jar helloworld-1.0-SNAPSHOT.jar
ENTRYPOINT ["java","-jar","helloworld-1.0-SNAPSHOT.jar"]