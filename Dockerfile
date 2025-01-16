# Stage 1: Build the application
FROM maven:latest AS build

# Set the working directory
WORKDIR /app

# Clone the Git repository
RUN git clone https://github.com/PrasanthNandyalaa/Springboot-rest-aws-eks-cluster-deploy.git .

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Run the application
FROM openjdk:18-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the built jar file from the build stage
#COPY --from=build /app/target/spring-boot-docker-app.jar /app/spring-boot-docker-app.jar
COPY --from=build /app/target/sb-rest-aws-eks.jar /app/sb-rest-aws-eks.jar

# Expose the port the app runs on
EXPOSE 8080

# Command to run the application
ENTRYPOINT ["java", "-jar", "/app/sb-rest-aws-eks.jar"]