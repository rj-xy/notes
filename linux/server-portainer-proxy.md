```bash
nano compose.yml
# contents below
docker compose up
```

Notes:
- For exec bash to work, websockets needs to be enabled
* scheme: **http**
* hostname: **port**
* port: **9000**

```yaml
version: '3.8'
services:
  port:
    container_name: port
    image: 'portainer/portainer-ce:latest'
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    networks:
      - default
    restart: unless-stopped
    ports:
      - '9000:9000'
    volumes:
      - portainer_data:/data
      - /var/run/docker.sock:/var/run/docker.sock

  proxy:
    container_name: proxy
    image: 'jc21/nginx-proxy-manager:latest'
    stdin_open: true # docker run -i
    tty: true        # docker run -t
    networks:
      - default
    restart: unless-stopped
    ports:
      - '80:80'
      - '81:81'
      - '443:443'
    volumes:
      - proxy_data:/data
      - proxy_letsencrypt:/etc/letsencrypt

volumes:
  portainer_data:
  proxy_data:
  proxy_letsencrypt:
```


Cockpit:
Install on host machine (not docker container)

* scheme: **https**
* hostname: **port**
* port: **9090**
