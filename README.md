
# NutrisoftAPI

API para el manejo de los datos.


# API Reference

## suscripciones

* Obtener todos los paquetes

```http
  GET /suscriptions/packets
```

```javascript
{
    id: Number,
    type: String,
    months: Number,  
    monthlyPayment: Number
}
```

* Obtener todas las boletas de un cliente

```http
  GET /suscriptions/tickets/${id}
```

| Parameter | Type     | 
| :-------- | :------- | 
| `id`      | `int` | 

```javascript
{
    id: Number,
    id_client: Number,
    id_paquet: Number,
    suscribedDate: Number,  
    type: String,
    months: Number,
    monthlyPayment: Number
}
```

* Obtener todas las boletas de todos los clientes

```http
  GET /suscriptions/tickets
```

```javascript
{
    id: Number,
    id_client: Number,
    id_paquet: Number,
    suscribedDate: Number,  
    type: String,
    months: Number,
    monthlyPayment: Number
}
```

* Suscribir un cliente

```http
  POST /suscriptions/suscribe
```

```javascript
{
    id_client: Number,
    id_packet: Number
}
```


## Alimentos

* Obtener info de el alimento por el id

```http
  GET /foods/${id}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |

```javascript
{
    id: Number,
    id_info_nutri: Number,
    id_type: Number,
    name: string,
    type: string,
    calories: Number,
    proteins: Number,
    carbohydrates: Number,
    fats: Number,
    ref_weight: Number
}
```

* Obtener info de todas los alimentos

```http
  GET /foods
```

```javascript
{
    id: Number,
    id_info_nutri: Number,
    id_type: Number,
    name: string,
    type: string,
    calories: Number,
    proteins: Number,
    carbohydrates: Number,
    fats: Number,
    ref_weight: Number
}
```

* Obtener los tipos de los alimentos

```http
  GET /foods/${type}
```

| Parameter   | Type     |
| :--------   | :------- |
| `type`      | `int`    |

```javascript
{
    id: Number,
    nombre: string
}
```

* Añadir un alimento

```http
  POST /foods
```

```javascript
{
    name: string,
    type_id: Number,
    calories: Number,
    proteins: Number,
    carbohydrates: Number,
    fats: Number,
    ref_weight: Number
}
```