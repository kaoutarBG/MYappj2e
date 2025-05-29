FROM registry.access.redhat.com/ubi8/openjdk-17 AS builder
WORKDIR /app
COPY . .
RUN microdnf install -y maven git && \
    mvn clean install package

FROM registry.access.redhat.com/jboss-webserver-5/webserver53-tomcat9-openshift
COPY --from=builder /app/target/*.war /opt/webserver/webapps/
