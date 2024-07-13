FROM maven:3.8.4-openjdk-8 AS build
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

FROM openjdk:8-jdk-alpine
VOLUME /tmp
EXPOSE 8080
COPY --from=build /app/target/orders-service-example-0.0.1-SNAPSHOT-spring-boot.jar app.jar

# CMD ["java", "-jar", "app.jar", "http://localhost:8081", "http://localhost:8082", "http://localhost:8083"]
CMD ["java", "-jar", "app.jar", "http://be_payments_service_container:8081", "http://be_shipping_service_container:8082", "http://be_products_service_container:8083"]

# intrucciones para generar una img y el contenedor corectamentes# docker build -t be_orders_service .
# docker build -t be_orders_service . 
# docker run -d --name be_orders_service_container -p 8080:8080 be_orders_service
# docker run -d --name be_orders_service_container --network my_network -p 8080:8080 be_orders_service
