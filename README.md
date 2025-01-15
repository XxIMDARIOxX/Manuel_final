# Manuel_final

Este proyecto es un sistema web desarrollado con Node.js, Express y una base de datos MySQL (MariaDB). Incluye una interfaz de backend y un conjunto de servicios desplegados mediante Docker Compose. También cuenta con herramientas de monitoreo y gestión como Prometheus, Grafana, Elastic Stack y más.

## 🚀 Características

- **Backend**: Construido con Node.js y Express, conectado a una base de datos MySQL.
- **Frontend**: Servido por Nginx.
- **Base de datos**: MariaDB con datos iniciales cargados automáticamente.
- **Monitoreo**: Prometheus y Grafana para métricas, cAdvisor para estadísticas de contenedores.
- **Logs**: Elastic Stack (Elasticsearch, Logstash, Kibana) para administración centralizada de logs.

## 📋 Requisitos Previos

Asegúrate de tener instalados los siguientes componentes:

- Docker y Docker Compose
- Node.js (si no usas contenedores para desarrollo)
- Git (para clonar el repositorio)

## 🛠️ Instalación

1. **Clona el repositorio**:
   ```bash
   git clone https://github.com/XxIMDARIOxX/Manuel_final.git
   cd Manuel_final
2. **Configura el entorno**:
    Asegúrate de que los archivos de configuración como docker-compose.yml y nginx/nginx.conf estén correctamente configurados para tu entorno.
3. **Ejecuta docker compose**:
    ```bash
    docker-compose up -d --build
4. **Accede a la aplicación**:
    Nginx: http://localhost
    Kibana: http://localhost:5601
    Prometheus: http://localhost:9090
    Grafana: http://localhost:3000
    cAdvisor: http://localhost:8080
5. **Estructura del proyecto**:
    ```bash
        Manuel_final/
    ├── backend/                  # Código del backend (Node.js)
    ├── database/                 # Archivos SQL de inicialización
    ├── nginx/                    # Configuración de Nginx
    ├── prometheus.yml            # Configuración de Prometheus
    ├── logstash.conf             # Configuración de Logstash
    ├── docker-compose.yml        # Configuración principal de Docker Compose
    └── README.md                 # Documentación del proyecto

**Contacto**
Para cualquier consulta, puedes comunicarte conmigo:

GitHub: XxIMDARIOxX
Email: dnicolas.burneo@alumno.ucjc.edu
