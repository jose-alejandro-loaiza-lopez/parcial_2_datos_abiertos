# Colombia Open Data — Flutter

Aplicación Flutter que consume la [API Colombia](https://api-colombia.com/) para mostrar datos abiertos de Colombia, incluyendo **Departamentos**, **Presidentes**, **Atracciones Turísticas** y **Regiones**.

---

## 📋 Descripción

La aplicación se conecta a **4 endpoints** de la API Colombia:

| # | Endpoint | Descripción |
|---|----------|-------------|
| 1 | `/Department` | Los 32 departamentos con capital, población y superficie |
| 2 | `/President` | Historia presidencial de Colombia con biografías |
| 3 | `/TouristicAttraction` | Lugares turísticos con imágenes y coordenadas |
| 4 | `/Region` | Las 6 regiones naturales del país |

**Base URL:** `https://api-colombia.com/api/v1`

---

## 🏗️ Arquitectura del proyecto

```
lib/
  config/          → Configuración general (lectura de .env)
  models/          → Modelos con fromJson y toJson
  routes/          → Configuración de go_router (rutas con nombre)
  services/        → Llamadas HTTP (paquete http)
  themes/          → Tema global de la aplicación
  views/           → Pantallas: Dashboard, Listados, Detalles
  widgets/         → Componentes reutilizables (loading, error, cards)
  main.dart        → Punto de entrada
```

### Capas

- **models/** — Cada modelo tiene `fromJson()` y `toJson()`. Manejo de nulabilidad para campos opcionales.
- **services/** — `ApiService` es un helper genérico que maneja status codes (`200` → éxito, cualquier otro → excepción). Los servicios específicos (`DepartmentService`, etc.) parsean a modelos tipados.
- **views/** — Cada vista maneja 3 estados: *cargando* (`CircularProgressIndicator`), *error* (con botón de reintentar) y *éxito* (renderizado de datos).
- **routes/** — `go_router` con rutas con nombre (`name`) y paso de parámetros por path (`/departments/:id`).

---

## Capturas del Dashboard, Listado, Detalle y manejo de estados.

Dashboard:



---

## 🗺️ Rutas implementadas

| Ruta | Nombre | Pantalla |
|------|--------|----------|
| `/` | `dashboard` | Dashboard con cards |
| `/departments` | `departments` | Listado de departamentos |
| `/departments/:id` | `department-detail` | Detalle del departamento |
| `/presidents` | `presidents` | Listado de presidentes |
| `/presidents/:id` | `president-detail` | Detalle del presidente |
| `/attractions` | `attractions` | Listado de atracciones |
| `/attractions/:id` | `attraction-detail` | Detalle de la atracción |
| `/regions` | `regions` | Listado de regiones |
| `/regions/:id` | `region-detail` | Detalle de la región |

---

## 📦 Paquetes utilizados

| Paquete | Uso |
|---------|-----|
| `http` | Consumo de la API REST |
| `go_router` | Navegación entre pantallas con rutas con nombre |
| `flutter_dotenv` | Variables de entorno (URL base de la API) |

---

## 🚀 Instalación y ejecución

```bash
# Clonar el repositorio
git clone https://github.com/jose-alejandro-loaiza-lopez/parcial_2_datos_abiertos.git
cd parcial_2_datos_abiertos

# Instalar dependencias
flutter pub get

# Ejecutar
flutter run
```

> **Nota:** El archivo `.env` ya está incluido con la URL base de la API. Si necesitas cambiarla, edita el archivo `.env` en la raíz del proyecto.

---

## 📄 Ejemplo de respuesta JSON

### `GET /api/v1/Region`

```json
[
  {
    "id": 1,
    "name": "Caribe",
    "description": "La región caribe es una de las regiones más importantes...",
    "departments": null
  },
  {
    "id": 5,
    "name": "Andina",
    "description": "La región Andina es la región con mayor desarrollo...",
    "departments": null
  }
]
```

### `GET /api/v1/Department/5`

```json
{
  "id": 5,
  "name": "Bogotá",
  "description": "Bogotá, oficialmente Bogotá, Distrito Capital...",
  "cityCapitalId": 167,
  "municipalities": 1,
  "surface": 1139,
  "population": 8906342,
  "phonePrefix": "1",
  "cityCapital": {
    "id": 167,
    "name": "Bogotá D.C.",
    "description": "...",
    "surface": 1636,
    "population": 7901653,
    "postalCode": "110110"
  }
}
```

---

## 👤 Información del estudiante

- **Nombre:** Jose Alejandro Loaiza López
- **Materia:** Datos Abiertos
- **Repositorio:** https://github.com/jose-alejandro-loaiza-lopez/parcial_2_datos_abiertos

---

## 📌 Endpoint base

🔗 [https://api-colombia.com/api/v1](https://api-colombia.com/api/v1)

📖 [Documentación Swagger](https://api-colombia.com/swagger/index.html)
