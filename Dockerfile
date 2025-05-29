FROM maven:3.8.4-openjdk-11-slim AS builder
WORKDIR /app
COPY . .
RUN mvn clean package

FROM tomcat:8.0
COPY --from=builder /app/target/*.war /usr/local/tomcat/webapps/ROOT.war
