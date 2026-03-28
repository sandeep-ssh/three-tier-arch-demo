FROM --platform=linux/arm64 mysql:8.4

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    MYSQL_DATABASE=cities \
    MYSQL_USER=shipping \
    MYSQL_PASSWORD=secret

COPY scripts/* /docker-entrypoint-initdb.d/

CMD ["mysqld", "--mysql-native-password=ON"]
