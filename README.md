# Theater

### Пример создание прод image

```
cpp -E -P -o Dockerfile Dockerfile.in
docker build -t theater .
docker run -it --rm -p <IP>:<PORT>:9760 -e MYSQL_PARAMS='mysql2://root:123321@<DATEBASE_IP>:3313/name' --name theater theater
```

Переменная окружения MYSQL_PARAMS используется для подключения к базе

### Примеры запросов и ответов к апи

```
curl -X POST "http://<IP>:<PORT>:/v1/event" -H "accept: application/json" -H "Content-Type: application/json" -d "{ \"title\": \"qweqwe\", \"start_time\": 123, \"end_time\": 125}"

{"body":{"object":{"start_time":"1970-01-01 00:02:03 +0000","end_time":"1970-01-01 00:02:05 +0000","title":"qweqwe"}}}

curl -X GET "http://<IP>:<PORT>:/v1/event" -H "accept: application/json"

{"body":{"objects":[{"start_time":"1970-01-01 00:02:03 +0000","end_time":"1970-01-01 00:02:05 +0000","title":"qweqwe"}]}}
```

### Создание тестового image для прогонов тестов

```
cpp -E -P -DTEST -o Dockerfile Dockerfile.in
docker build -t theater-test .
docker run -it --rm theater-test
```
