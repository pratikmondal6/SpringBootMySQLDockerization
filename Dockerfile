# Section 1: Uses Maven to build the application in one stage.

# Use a base Maven image
FROM maven:3.9.2 AS build

# Install OpenJDK 17
RUN apt-get update && \
    apt-get install -y openjdk-17-jdk

# Set the working directory in the container
WORKDIR /app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Section 2: Uses a lightweight JRE base image in another stage.It is optional to create another stage for running the application.
# it is lightweight and recommended to use a separate image for running the application

# Use a lightweight base image with JRE
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

#Section 3: Copy the JAR file from the build stage

# Copy the JAR file from the build stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port your application runs on
EXPOSE 8080

# Command to run the application
CMD ["java", "-jar", "app.jar"]


