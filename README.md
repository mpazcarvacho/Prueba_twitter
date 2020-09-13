# README

Correr rails db:seed para crear admin, usuarios y tweets.

ADMIN USER: admin@twitty.com
ADMIN PASS: adminpass

Para ingresar a dashboard, autenticarse con usuario admin, y dirigirse a http://localhost:3000/admin/users.



API:

1) Para consultar tweets entre rango de fechas usar formato dd-mm-yyyy en la siguiente dirección:

api/fecha_desde/fecha_hasta

ej: api/10-09-2020/12-09-2020 devolverá los tweets desde el 10 de sepiembre al 12 de septiembre de 2020.

2) Para crear un nuevo tweet se deben pasar los siguientes parámetros:

email
password
content

