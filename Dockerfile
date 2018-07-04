FROM openjdk:8
ADD Main.jar hellow.jar
EXPOSE 8080
CMD java -jar hellow.jar


