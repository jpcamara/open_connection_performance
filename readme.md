### Echo Server

```
cd echo_server
docker-compose up --build -d # first time
docker-compose up            # after building
```

### JRuby

```
docker build -t jruby-threads .
docker run --ulimit nofile=102400:102400 -it --rm --name run-those-jruby-threads jruby-threads
```

### Java

```
docker build -t java-virtual-thread .
docker run -it --rm --name run-those-threads java-virtual-thread
```