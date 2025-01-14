# Variables
DOCKER_COMPOSE = docker compose
PROJECT_NAME = my_project

# Tareas
.PHONY: help build start stop restart logs clean test deploy

help:
	@echo "Comandos disponibles:"
	@echo "  make build       - Construye los servicios de Docker"
	@echo "  make start       - Inicia los servicios en segundo plano"
	@echo "  make stop        - Detiene los servicios"
	@echo "  make restart     - Reinicia los servicios"
	@echo "  make logs        - Muestra los logs de todos los servicios"
	@echo "  make clean       - Elimina contenedores, volúmenes y redes"
	@echo "  make test        - Ejecuta las pruebas del backend"
	@echo "  make deploy      - Despliega la aplicación en producción"

build:
	$(DOCKER_COMPOSE) build

start:
	$(DOCKER_COMPOSE) up -d

stop:
	$(DOCKER_COMPOSE) down

restart:
	make stop
	make start

logs:
	$(DOCKER_COMPOSE) logs -f

clean:
	$(DOCKER_COMPOSE) down -v --rmi all --remove-orphans

test:
	$(DOCKER_COMPOSE) up -d database
	sleep 10 # Esperar a que la base de datos esté lista
	docker exec backend npm test
	make stop

deploy:
	@echo "Desplegando la aplicación..."
	# Aquí puedes agregar scripts para el despliegue en producción
	ssh user@yourserver "cd /path/to/project && git pull && $(DOCKER_COMPOSE) up -d"
