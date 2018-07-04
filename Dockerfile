FROM openjdk:8
ADD Main.jar hellow.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "hellow.jar"]
CMD [""]


