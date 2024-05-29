# First stage: Build the application
FROM openjdk:17-alpine AS builder
WORKDIR /app
COPY . .
RUN ./gradlew bootJar

# Second stage: Create the final image
FROM openjdk:17-alpine
WORKDIR /app
COPY --from=builder /app/build/libs/*.jar app.jar
EXPOSE 8080
ENTRYPOINT ["java", "-jar", "app.jar"]
