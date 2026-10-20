# Wheelhouse API (v1)

API JSON de solo lectura (más un endpoint de creación) bajo `/api/v1`. Todas las respuestas son JSON (`Content-Type: application/json`), incluidos los errores.

## Rutas

| Verbo | Path                   | Token requerido | Status posibles       |
|-------|------------------------|:----------------:|------------------------|
| GET   | `/api/v1/services`      | No               | 200                     |
| GET   | `/api/v1/services/:id`  | No               | 200, 404                |
| POST  | `/api/v1/services`      | Sí               | 201, 400, 401, 422      |
| GET   | `/api/v1/repairs`       | Sí               | 200, 400, 401           |
| GET   | `/api/v1/repairs/:id`   | Sí               | 200, 401, 404           |

`GET /api/v1/repairs` acepta un parámetro opcional `?state=<status>`. Los valores válidos son los de `Repair::STATUSES`. Un valor inválido devuelve 400 con la lista de estados válidos en el mensaje de error.

El token va en el header `Authorization: Bearer <token>` (nunca en query string ni body).

## Shape de los documentos

### Service

```json
{
  "id": 7,
  "name": "Bottom bracket service",
  "price": "40.0",
  "repairs_charged_count": 0
}
```

- `repairs_charged_count` es un valor calculado: cuántos repairs distintos cobraron ese service (no cuántas líneas — un mismo repair que cobrara el mismo service dos veces cuenta una vez).

### Repair

```json
{
  "id": 26,
  "status": "dropped_off",
  "decision": null,
  "dropped_off_at": "2026-10-06T12:00:00.000Z",
  "promised_on": "2026-10-10",
  "collected_at": null,
  "overdue": true,
  "total": "15.0",
  "bike": {
    "model": "Giant Talon",
    "serial_number": "TAL-1011"
  },
  "customer": {
    "name": "Javier Espinoza"
  },
  "line_items": [
    {
      "service_name": "Safety inspection",
      "price_charged": "15.0"
    }
  ]
}
```

- `overdue` y `total` son calculados (no columnas): `total` es la suma de `price_charged` de las líneas, `overdue` sale de `Repair#overdue?`.
- El documento deja fuera `bike_id` y `mechanic_id` (son foreign keys internas, no información de negocio) y el teléfono del customer (dato de contacto privado).
- `bike` solo expone `model` y `serial_number`. El spec original del lab menciona también `brand`, pero el schema de este dominio (desde Lab 3) no tiene esa columna — no se inventó un campo que no existe en los datos reales.

### Colección de repairs (`GET /api/v1/repairs`)

Un array de documentos `Repair` como el de arriba, ordenado por `newest_first` (mismo scope que usan las vistas web). Sin paginación.

### Error

```json
{
  "errors": ["Resource not found"]
}
```

Mismo shape para 400, 401, 404 y 422 — solo cambia el contenido del array (puede tener uno o varios mensajes, por ejemplo en validaciones fallidas de `create`).

## Decisiones

- **Precio como string**: `current_price` es una columna `decimal`, y se serializa tal cual la devuelve Active Record (`BigDecimal` → string en JSON) en vez de forzarlo a `number`. Se eligió así para no introducir imprecisión de punto flotante en un valor monetario; el consumidor (la página de Lab 01) lo muestra como texto formateado, no hace aritmética con él.
- **Filtro de estado sin strings literales**: `Repair::STATUSES` es la única fuente de verdad para los estados válidos, tanto para filtrar como para el mensaje de error cuando el valor no es válido.
- **`services#create` nunca crea sin token**, y ningún `GET` de la API escribe — los únicos efectos secundarios posibles son vía `POST /api/v1/services`.