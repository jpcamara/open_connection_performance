### Echo Server

```
cd echo_server
docker-compose up --build -d # first time
docker-compose up            # after building
```

### Java

```
docker build -t java-virtual-thread .
docker run -it --rm --name run-those-threads java-virtual-thread
```