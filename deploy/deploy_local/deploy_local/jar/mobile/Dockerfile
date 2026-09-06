FROM openjdk:8
RUN mkdir -p /opt/fonts
COPY ./fonts /opt/fonts
WORKDIR /app
EXPOSE 9094
COPY ./x1-mobile-api.jar app.jar
ENTRYPOINT ["java","-jar","/app/app.jar","--spring.profiles.active=docker","--host_ip=10.118.13.122","--mysql_ds1_ip=10.118.13.122","--host_ai_ip=10.118.13.122"]
















