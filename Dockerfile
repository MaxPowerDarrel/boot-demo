FROM alpine AS builder

RUN apk --no-cache add openjdk11
RUN apk --no-cache add maven

RUN /usr/lib/jvm/default-jvm/bin/jlink \
    --compress=2 \
    --module-path /usr/lib/jvm/default-jvm/jmods \
    --add-modules java.base,java.logging,java.xml,jdk.unsupported,java.sql,java.naming,java.desktop,java.management,java.security.jgss,java.instrument \
    --output /jdk-minimal

WORKDIR /build
COPY pom.xml pom.xml
RUN mvn dependency:go-offline
COPY src src
RUN mvn clean package

FROM alpine
COPY --from=builder /build/target/*.jar /app.jar
COPY --from=builder /jdk-minimal /opt/jdk/
VOLUME /tmp
EXPOSE 8080
CMD /opt/jdk/bin/java $JAVA_OPTS -Djava.security.egd=file:/dev/./urandom -jar /app.jar
