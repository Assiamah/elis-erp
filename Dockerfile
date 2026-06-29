FROM eclipse-temurin:17-jdk-alpine
VOLUME /tmp
EXPOSE 9010
COPY target/elis-app-v5.war elis-app-v5.war
ENTRYPOINT ["java","-jar","elis-app-v5.war"]


