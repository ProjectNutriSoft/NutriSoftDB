
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

## clientes

* Obtener las citas del cliente

```http
  GET /meetings/clients
```

```javascript
{
    id_meeting: Number,
    id_experience: Number,
    id_client: Number,
    date: String,
    state: String,
    nutriComment: String,
    clientComment: String, 
    puntuation: String
}
```

* Obtener las citas del cliente

```http
  GET /meetings/nutris
```

```javascript
{
    id_meeting: Number,
    id_experience: Number,
    id_nutri: Number,
    date: String,
    state: String,
    nutriComment: String,
    clientComment: String, 
    puntuation: String
}
```

* Obtener todas las citas

```http
  GET /meetings
```

```javascript
{
    id_meeting: Number,
    id_experience: Number,
    id_nutri: Number,
    date: String,
    state: String,
    nutriComment: String,
    clientComment: String, 
    puntuation: String
}
```

## dailySummary

* Obtener todas las citas

```http
  GET /dailySummary/${id}&${date}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |
| `date`      | `string` |

```javascript
{
    id_foodMomentDay: Number,
    id_summaryMomentDay: Number,
    id_SummaryDaily: Number,
    id_macro: Number,
    id_food: Number,
    id_foodType: Number,
    date: String,
    maxCalories: Number,
    maxProteins: Number,
    maxCarbohydrates: Number,
    maxFats: Number,
    momentDayName: String,
    recomended: boolean
}
```

## clients

* Obtener cliente por id

```http
  GET /clients/${id}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |

```javascript
{
    id: Number,
    dni: Number,
    age: Number, 
    name: String,
    mail: String,
    phone: String,
    bornDate: String,
    registerDate: String,
    vegan: boolean,
    abusive: boolean,
    suscribed: boolean
}
```

* Obtener todos los clientes

```http
  GET /clients
```

```javascript
{
    id: Number,
    dni: Number,
    age: Number, 
    name: String,
    mail: String,
    phone: String,
    bornDate: String,
    registerDate: String,
    vegan: boolean,
    abusive: boolean,
    suscribed: boolean
}
```

* Añadir Cliente

```http
  POST /clients
```

```javascript
{
    dni: Number,
    age: Number,
    name: String,
    mail: String,
    phone: String,
    bornDate: String,
    vegan: boolean
}
```

* Obtener todas las tarjetas de los clientes

```http
  GET /clients/cards
```

```javascript
{
    id: Number,
    id_user: Number,
    number: String,
    owner: String,
    expirationYear: Number,
    expirationMonth: Number,
    cvc: Number
}
```

* Obtener tarjeta de un cliente

```http
  GET /clients/cards/${id}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |

```javascript
{
    id: Number,
    id_user: Number,
    number: String,
    owner: String,
    expirationYear: Number,
    expirationMonth: Number,
    cvc: Number
}
```

* Añadir/actualizar tarjeta del cliente

```http
  POST /clients/cards
```

```javascript
{
    id_user: Number,
    number: String,
    owner: String,
    expirationYear: Number,
    expirationMonth: Number,
    cvc: Number
}
```

* Obtener todos los datos de los clientes

```http
  GET /clients/data
```

```javascript
{
    id_client: Number,
    weight: Number,
    size: Number
}
```

* Obtener datos del cliente

```http
  GET /clients/data/${id}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |

```javascript
{
    id_client: Number,
    weight: Number,
    size: Number
}
```

* Obtener datos del cliente

```http
  GET /clients/data
```

```javascript
{
    id_client: Number,
    weight: Number,
    size: Number
}
```

* Obtener alimentos base del cliente

```http
  GET /clients/foodbase/${id}
```

| Parameter   | Type     |
| :--------   | :------- |
| `id`        | `int`    |

```javascript
{
    id: Number,
    id_client: Number,
    id_food: Number
}
```

* Obtener alimentos base de todos los clientes

```http
  GET /clients/foodbase
```

```javascript
{
    id: Number,
    id_client: Number,
    id_food: Number
}
```

* Añadir alimento base a un cliente

```http
  POST /clients/foodbase
```

```javascript
{
    id_client: Number,
    id_food: Number
}
```