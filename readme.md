# API de Liga de Fútbol - Spring Boot

API REST para gestionar una liga de fútbol de la provincia de Santiago. Permite consultar equipos, partidos y actualizar marcadores.

## Requisitos Previos

- Java 21
- Maven 3.8+
- Spring Boot 3.x

## Instalación y Ejecución

```bash
mvn clean install
mvn spring-boot:run
```

La aplicación se ejecutará en: `http://localhost:8080`

## Base de Datos

- **Motor:** H2 (en memoria)
- **Inicialización:** Automática al iniciar la aplicación
- **Consola H2:** `http://localhost:8080/h2-console`

## Endpoints REST

### 1. Listar todos los equipos

**Método:** `GET`

**URL:** `/api/equipos`

**Respuesta (200 OK):**
```json
[
  {
    "id": 1,
    "nombre": "Atlético Nueva Providencia",
    "anioFundacion": 1962,
    "comunaLocal": "Providencia",
    "historia": "Fundado por comerciantes y estudiantes..."
  },
  {
    "id": 2,
    "nombre": "Unión San Miguel",
    "anioFundacion": 1974,
    "comunaLocal": "San Miguel",
    "historia": "Nació tras la fusión de dos equipos..."
  }
]
```

---

### 2. Buscar equipos por nombre

**Método:** `GET`

**URL:** `/api/equipos/buscar?nombre={texto}`

**Parámetros:**
- `nombre` (string, requerido): Fragmento del nombre a buscar

**Ejemplo:** `/api/equipos/buscar?nombre=ferroviarios`

**Respuesta (200 OK):**
```json
[
  {
    "id": 20,
    "nombre": "Ferroviarios de Quinta Normal",
    "anioFundacion": 1956,
    "comunaLocal": "Quinta Normal",
    "historia": "Formado por trabajadores vinculados al mundo ferroviario..."
  }
]
```

**Respuesta (404 Not Found):**
```json
{
  "mensaje": "No se encontraron equipos con el nombre: xyz"
}
```

---

### 3. Consultar partidos por fecha

**Método:** `GET`

**URL:** `/api/partidos?fecha=YYYY-MM-DD`

**Parámetros:**
- `fecha` (date, requerido): Fecha en formato YYYY-MM-DD

**Ejemplo:** `/api/partidos?fecha=2026-03-07`

**Respuesta (200 OK):**
```json
[
  {
    "id": 1,
    "jornada": 1,
    "fecha": "2026-03-07",
    "horaInicio": "12:00",
    "equipoLocal": "Atlético Nueva Providencia",
    "equipoVisita": "Unión San Miguel",
    "golesLocal": null,
    "golesVisita": null,
    "estado": "PROGRAMADO"
  },
  {
    "id": 2,
    "jornada": 1,
    "fecha": "2026-03-07",
    "horaInicio": "15:00",
    "equipoLocal": "Deportivo Lo Prado Unido",
    "equipoVisita": "Municipal Cerro Navia Sur",
    "golesLocal": null,
    "golesVisita": null,
    "estado": "PROGRAMADO"
  }
]
```

**Respuesta (400 Bad Request):**
```json
{
  "mensaje": "Formato de fecha inválido. Usar: YYYY-MM-DD"
}
```

**Respuesta (204 No Content):**
Sin partidos disponibles para esa fecha.

---

### 4. Actualizar marcador de un partido

**Método:** `PUT`

**URL:** `/api/partidos/{id}/marcador`

**Parámetros URL:**
- `id` (number, requerido): ID del partido

**Body JSON:**
```json
{
  "golesLocal": 2,
  "golesVisita": 1
}
```

**Respuesta (200 OK):**
```json
{
  "id": 1,
  "jornada": 1,
  "fecha": "2026-03-07",
  "horaInicio": "12:00",
  "equipoLocal": "Atlético Nueva Providencia",
  "equipoVisita": "Unión San Miguel",
  "golesLocal": 2,
  "golesVisita": 1,
  "estado": "JUGADO"
}
```

**Respuesta (404 Not Found):**
```json
{
  "mensaje": "Partido no encontrado con ID: 999"
}
```

**Respuesta (400 Bad Request):**
```json
{
  "mensaje": "Los valores de goles no pueden ser negativos"
}
```

---

## Códigos de Estado HTTP

| Código | Descripción |
|--------|-------------|
| 200 | OK - Solicitud exitosa |
| 204 | No Content - Éxito pero sin contenido |
| 400 | Bad Request - Solicitud inválida |
| 404 | Not Found - Recurso no encontrado |
| 500 | Internal Server Error - Error del servidor |

## Estructura del Proyecto

```
src/main/java/com/example/demo/
├── controller/
│   ├── EquipoController.java
│   └── PartidoController.java
├── service/
│   ├── EquipoService.java
│   └── PartidoService.java
├── repository/
│   ├── EquipoRepository.java
│   ├── PartidoRepository.java
│   ├── LigaRepository.java
│   └── EquipoLigaRepository.java
├── model/
│   ├── Equipo.java
│   ├── Partido.java
│   ├── Liga.java
│   └── EquipoLiga.java
├── dto/
│   ├── EquipoDTO.java
│   ├── PartidoDTO.java
│   └── MarcadorDTO.java
└── DemoApplication.java

src/main/resources/
├── application.properties
└── schema.sql
```

## Notas

- La base de datos se reinicializa al iniciar la aplicación con los datos de ejemplo.
- Los partidos solo pueden ser jugados en fin de semana (sábado o domingo).
- Un equipo no puede jugar contra sí mismo en un partido.
- El estado del partido cambia automáticamente a "JUGADO" cuando se actualiza el marcador.
