# Use OpenJDK 21 base image (most aligned with Oracle OpenJDK setup)
 FROM openjdk:21-slim

 # Set workdir inside the container
 WORKDIR /app

 # Copy the Spring Boot JAR file
 COPY build/libs/*.jar app.jar

 # Expose default port
 EXPOSE 8080

 # Run the app
 ENTRYPOINT ["java", "-jar", "app.jar"]