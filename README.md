# Docker Build for LiteCart

## Sample compose.yml file

```yaml
services:
  litecart-db:
    image: docker.io/mysql:8.4
    container_name: litecart-db
    ports:
      - "3306:3306"
    command: --character-set-server=utf8mb4 --collation-server=utf8mb4_general_ci
    environment:
      MYSQL_DATABASE: litecart_db
      MYSQL_ROOT_PASSWORD: root-litecart
      MYSQL_USER: litecart_db_usr
      MYSQL_PASSWORD: litecart
    volumes:
      - ./db_data:/var/lib/mysql
    healthcheck:
      test: ["CMD", "mysqladmin", "ping", "-h", "localhost"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  litecart:
    image: ghcr.io/edemirkan/litecart-docker:2.6.3-dev
    container_name: litecart
    ports:
      - "9080:80"
    environment:
      DB_SERVER: litecart-db
      DB_USERNAME: litecart_db_usr
      DB_PASSWORD: litecart
      DB_DATABASE: litecart_db
      DB_COLLATION: utf8mb4_general_ci
      ADMIN_USERNAME: admin
      ADMIN_PASSWORD: admin
      TZ: UTC
    depends_on:
      litecart-db:
        condition: service_healthy
    volumes:
      - ./litecart_data:/var/www/html/public_html
    restart: unless-stopped
```