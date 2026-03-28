#
# Build
#
FROM --platform=linux/arm64 maven:3.9-eclipse-temurin-11 AS build

WORKDIR /opt/shipping

COPY pom.xml /opt/shipping/
RUN mvn dependency:resolve

COPY src /opt/shipping/src/
RUN touch src/main/java/com/instana/robotshop/shipping/JpaConfig.java && mvn clean package -Dmaven.compiler.useIncrementalCompilation=false

#
# Run
#
FROM --platform=linux/arm64 eclipse-temurin:11-jdk

EXPOSE 8080

WORKDIR /opt/shipping

ENV CART_ENDPOINT=cart:8080
ENV DB_HOST=mysql

COPY --from=build /opt/shipping/target/shipping-1.0.jar shipping.jar

CMD [ "java", "-Xmn256m", "-Xmx768m", "-jar", "shipping.jar" ]
