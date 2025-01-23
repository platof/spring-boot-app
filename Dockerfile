# OpenJDK base image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the JAR file into the container
COPY target/crewmeisterchallenge-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

