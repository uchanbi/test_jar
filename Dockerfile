FROM openjdk:8
ADD Main.jar Main.jar
EXPOSE 8080
CMD ["java", "-jar", "Main.jar"]


