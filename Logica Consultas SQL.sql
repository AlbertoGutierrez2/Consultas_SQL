//**Ejercicio 2.Muestra los nombres de todas las películas con una clasificación por
edades de ‘R’.**//

select f.title as "Nombre_pelicula"
from film as f
where f.rating = 'R'

//**Ejercicio 3. Encuentra los nombres de los actores que tengan un “actor_id” entre 30
y 40**//

select a."actor_id",
	   concat(a.first_name, ' ', a.last_name) as "Nombre_actor"	   
from actor as a
where a.actor_id between 30 and 40

//**Ejercicio 4. Obtén las películas cuyo idioma coincide con el idioma original.**//

select f.film_id,
	   f.title as "Titulo_pelicula" 
from film as f
where f.original_language_id = f.language_id 
order by f.film_id 

//**Ejercicio 5.Ordena las películas por duración de forma ascendente.**//

select f.title as "Titulo_pelicula",
	   f.length as "Duracion"
from film as f
order by f.length asc

//**Ejercicio 6.Encuentra el nombre y apellido de los actores que tengan ‘Allen’ en su
apellido.*//

select a.actor_id,
	   concat(a.first_name, ' ', a.last_name) as "Nombre_apellido_actor"
from actor as a
where a.last_name = 'ALLEN'

//**Ejercicio 7. Encuentra la cantidad total de películas en cada clasificación de la tabla
“film” y muestra la clasificación junto con el recuento.**//

select c.category_id,
	   c.name as "Nombre_categoria",
	   sum(fc."film_id") as "Recuento"
from film as f
	inner join film_category as fc
	on f.film_id = fc.film_id 
	inner join category as c
	on c.category_id = fc.category_id
	group by c.category_id,  "Nombre_categoria"
	order by c.category_id asc
	
//**Ejercicio 8. Encuentra el título de todas las películas que son ‘PG-13’ o tienen una
duración mayor a 3 horas en la tabla film.**//

select f.title as "Titulo_pelicula",
	   f.rating as "Rating",
	   f.length as "Duracion"
from film as f
where f.rating ='PG-13' OR f.length > 180
	

//**Ejercicio 9. Encuentra la variabilidad de lo que costaría reemplazar las películas.**//

select round(avg(f.replacement_cost),2) as "Media",
	   round(stddev(f.replacement_cost),2) as "Desviacion_estandar",
	   round(Variance(f.replacement_cost),2) as "Varianza"
from film as f

*Explicacion: La media del coste de reemplazo se situa en 19,98€ aprox., sin embargo existe una desviación estándar de 6€ 
por encima y por debajo de la media y, finalmente la varianza de 36,61€ nos muestra que existe una gran cantidad de valores 
en la columna coste de reemplazo que se alejan de la media mostrando una gran variabilidad*.

//**Ejercicio 10. Encuentra la mayor y menor duración de una película de nuestra BBDD.**//

select max(f.length) as "Mayor_duracion",
	   min(f.length) as "Menor_duracion"
from film as f

//**Ejercicio 11. Encuentra lo que costó el antepenúltimo alquiler ordenado por día.**//

select r.rental_date as "Fecha_alquiler",
	   r.rental_id as "Rental_Id",
	   p.amount as "Coste" 
from rental as r
	inner join payment as p
	on p.rental_id = r.rental_id 
	group by "Fecha_alquiler", "Rental_Id", "Coste"
	order by "Fecha_alquiler" desc, "Rental_Id" asc
	offset 2
	limit 1

*Respuesta: El antepenúltimo alquiler fue el 11.563 y costó 4,99€.*


//**Ejercicio 12. Encuentra el título de las películas en la tabla “film” que no sean ni ‘NC-
17’ ni ‘G’ en cuanto a su clasificación.**//

select f.title as "Titulo_pelicula",
	   f.rating as "Clasificacion"
from film as f
where rating <> 'NC-17' and rating <> 'G'


//**Ejercicio 13. Encuentra el promedio de duración de las películas para cada
clasificación de la tabla film y muestra la clasificación junto con el
promedio de duración.**//

select c.category_id,
	   c.name as "Nombre_categoria",
	   round(avg(f.length),2) as "Promedio_duracion"
from film as f
	inner join film_category as fc
	on f.film_id = fc.film_id 
	inner join category as c
	on c.category_id = fc.category_id
	group by c.category_id,  "Nombre_categoria"
	order by c.category_id asc

//** Ejercicio 14. Encuentra el título de todas las películas que tengan una duración mayor
a 180 minutos.**//

select f.title as "Titulo_pelicula",
	   f.length as "Duracion"
from film as f
where f.length > 180
	

//**Ejercicio 15. ¿Cuánto dinero ha generado en total la empresa?**//

select sum(amount) as "Total_Amount"
from payment as p

*Respuesta: La empresa ha generado en total 67.416,51€*

**//Ejercicio 16. Muestra los 10 clientes con mayor valor de id.**//

create view "Ultimo_Cliente" as
select max(customer_id)
from customer as c
	
select  c."customer_id",
		concat (c.first_name, ' ', c.last_name) as "Nombre_Cliente"	
from customer as c
order by customer_id desc
limit 10
	
//**17. Encuentra el nombre y apellido de los actores que aparecen en la
película con título ‘Egg Igby’.**//

select concat(a.first_name,' ', a.last_name) as "Nombre_Apellido"
from film as f
inner join film_actor as fa
on fa.film_id = f.film_id 
inner join actor as a
on a.actor_id = fa.actor_id
where f.title = 'EGG IGBY'


//**Ejercicio 18. Selecciona todos los nombres de las películas únicos.**//

select distinct(f.title) as "Titulo_pelicula"
from film as f
order by f.title asc

//**Ejercicio 19. Encuentra el título de las películas que son comedias y tienen una
duración mayor a 180 minutos en la tabla “film”.**//


select f.title as "Titulo_pelicula",
	   f.length as "Duracion_pelicula",
	   c."name" as "Categoria"
from film as f
inner join film_category fc 
on fc.film_id = f.film_id 
inner join category c
on c.category_id = fc.category_id 
where f.length > 180 and c."name" = 'Comedy'

//**Ejercicio 20. Encuentra las categorías de películas que tienen un promedio de
duración superior a 110 minutos y muestra el nombre de la categoría
junto con el promedio de duración.**//


select c.category_id,
	   c.name as "Nombre_categoria",
	   round(avg(f.length),2) as "Promedio_duracion"
from film as f
	inner join film_category as fc
	on f.film_id = fc.film_id 
	inner join category as c
	on c.category_id = fc.category_id
	group by c.category_id,  "Nombre_categoria"
	having round(avg(f.length),2) > 110
	order by c.category_id asc

//**Ejercicio 21. ¿Cuál es la media de duración del alquiler de las películas?**//


select round(avg(rental_duration))
from film as f

*Respuesta: La media de duración de alquiler de las peliculas es 5 días*

 

//**Ejercicio 22. Crea una columna con el nombre y apellidos de todos los actores y
actrices.**//

 

select concat(a.first_name, ' ', a.last_name) as "Nombre_apellidos"
from actor as a

 

//**Ejercicio 23. Números de alquiler por día, ordenados por cantidad de alquiler de
forma descendente.**//

select count(r.rental_id) as "Contador_alquileres",
	   concat(extract(day from r.rental_date), '-', extract(month from r.rental_date), '-', extract(year from r.rental_date)) as "Día"
from rental as r
group by concat(extract(day from r.rental_date), '-', extract(month from r.rental_date), '-', extract(year from r.rental_date)) 
order by "Contador_alquileres" desc


//**Ejercicio 24. Encuentra las películas con una duración superior al promedio.**//

 select f.film_id,
        f.title as "Titulo_pelicula",
        f.length as "Duracion_pelicula",
          (select avg(f.length)
          from film f) as "Promedio_duracion_peliculas"
from film as f
group by f.film_id, "Titulo_pelicula", "Duracion_pelicula"
having  sum(f.length) > (
		select avg(f.length)
		from film as f
)
		
//**Ejercicio 25. Averigua el número de alquileres registrados por mes.**//

select count(r.rental_id) as "Contador_alquileres",
	   extract(month from r.rental_date) as "Mes"
from rental as r
group by extract(month from r.rental_date)

//**Ejercicio 26. Encuentra el promedio, la desviación estándar y varianza del total
pagado.**//

select round(avg(p.amount),2) as "Promedio",
	   round(stddev(p.amount),2) as "Desviacion_estandar",
	   round(Variance(p.amount),2) as "Varianza"
from payment as p

//**Ejercicio 27. ¿Qué películas se alquilan por encima del precio medio**//

select f.film_id,
	   f.title as "Titulo_pelicula",
	   p.amount as "Precio_pelicula",
	   (select round(avg(p."amount"),2)
	   from payment as p) as "Precio_medio"
from payment as p
inner join rental as r
on p.rental_id = r.rental_id 
inner join inventory as i
on r.inventory_id = i.inventory_id 
inner join film as f
on f.film_id = i.film_id 
group by f.film_id, "Titulo_pelicula", "Precio_pelicula", "Precio_medio"
having p.amount > (
		select avg(p.amount)
		from payment as p)
		
//**Ejercicio 28. Muestra el id de los actores que hayan participado en más de 40
películas.**//

select fa.actor_id,
	   count(fa.actor_id) as "Número_peliculas_actor"
from film_actor fa 
group by fa.actor_id
having count(fa.actor_id) > 40
		
//**Ejercicio 29. Obtener todas las películas y, si están disponibles en el inventario
mostrar la cantidad disponible.**//

select f.film_id,
	   f.title as "Titulo_pelicula",
	   count(i.inventory_id) as "Cantidad_Disponible"
from film as f
right join inventory as i
on f.film_id = i.film_id 
group by f.film_id
order by f.film_id asc

//**Ejercicio 30. Obtener los actores y el número de películas en las que ha actuado.**//

select a.actor_id,
	   concat(a.first_name, ' ', a.last_name) as "Nombre_actor",
	   count(fa.actor_id) as "Numero_peliculas_actuado"
from actor as a
right join film_actor fa 
on a.actor_id = fa.actor_id 
group by a.actor_id
order by a.actor_id asc


//**Ejercicio 31. Obtener todas las películas y mostrar los actores que han actuado
ellas, incluso si algunas películas no tienen actores asociados**//

select f.film_id,
	   f.title as "Titulo_pelicula",
	   concat(a.first_name, ' ', last_name) as "Nombre_actor"
from film as f
inner join film_actor as fa
on fa.film_id = f.film_id 
inner join actor as a
on a.actor_id = fa.actor_id 
group by f.film_id, "Titulo_pelicula", "Nombre_actor"
order by f.film_id asc

//**Ejercicio 32. Obtener todos los actores y mostrar las películas en las que han
actuado, incluso si algunos actores no han actuado en ninguna película.**//

select a.actor_id,
	   concat(a.first_name, ' ', a.last_name) as "Nombre_actor",
	   f.title as "Titulo_pelicula"
from actor as a
inner join film_actor as fa
on a.actor_id = fa.actor_id 
inner join film as f
on f.film_id = fa.film_id 
group by a.actor_id, "Nombre_actor", "Titulo_pelicula"
order by a.actor_id asc

//**Ejercicio 33. Obtener todas las películas que tenemos y todos los registros
alquiler.**//

select f.film_id,
	   f.title as "Titulo_pelicula",
	   count(r.rental_id) as "Registros_alquiler"
from film as f
inner join inventory as i
on i.film_id = f.film_id 
inner join rental as r
on r.inventory_id = i.inventory_id 
group by f.film_id, "Titulo_pelicula"
order by f.film_id asc

//**Ejercicio 34. Encuentra los 5 clientes que más dinero se hayan gastado con nosotros.**//

select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   sum(p.amount) as "Cantidad_gastada"
from customer c 
inner join payment as p
on c.customer_id = p.customer_id 
group by c.customer_id
order by "Cantidad_gastada" desc
limit 5

//**Ejercicio 35. Selecciona todos los actores cuyo primer nombre es 'Johnny'.**//

select a.actor_id,
	   concat(a.first_name, ' ', a.last_name) as "Nombre_actor"
from actor as a
group by a.actor_id 
having a.first_name = 'JOHNNY'

**//Ejercicio 36. Renombra la columna “first_name” como Nombre y “last_name” como
Apellido.**//


select a.first_name as "Nombre",
	    a.last_name as "Apellido"
from actor a

 
**//Ejercicio 37. Encuentra el ID del actor más bajo y más alto en la tabla actor.**//


select min(a.actor_id) as "Id_mas_bajo",
       max(a.actor_id) as "Id_mas_alto"
from actor as a

**//Ejercicio 38. Cuenta cuántos actores hay en la tabla “actor”.**//

 
select count(a.actor_id) as "Número_actores"
from actor as a


**//Ejercicio 39. Selecciona todos los actores y ordénalos por apellido en orden
ascendente.**//

 
select concat(a.first_name, ' ', a.last_name) as "Nombre_actor"
from actor as a
order by a.last_name asc

 

**//Ejercicio 40. Selecciona las primeras 5 películas de la tabla “film”.**//

select f.film_id,
       f.title as "Titulo_pelicula"
from film as f
order by f.film_id asc
limit 5


**//Ejercicio 41. Agrupa los actores por su nombre y cuenta cuántos actores tienen el
mismo nombre. ¿Cuál es el nombre más repetido?.**//

select a.first_name,
       count(a.actor_id) as "Conteo"
from actor as a
group by a.first_name
order by "Conteo" desc


*Respuesta: Los nombres más repetidos son KENNETH, PENELOPE y JULIA.**//


**//Ejercicio 42. Encuentra todos los alquileres y los nombres de los clientes que los
realizaron.**//

select r.rental_id,
       concat(c.first_name,' ', c.last_name) as "Nombre_cliente"
from rental as r
left join customer as c
on c.customer_id = r.customer_id
group by r.rental_id, "Nombre_cliente"
order by r.rental_id asc

**//Ejercicio 43. Muestra todos los clientes y sus alquileres si existen, incluyendo
aquellos que no tienen alquileres.**// 

select c.customer_id,
       concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
       r.rental_id as "Id_alquiler"
from customer as c
right join rental as r
on r.customer_id = c.customer_id
group by c.customer_id, "Nombre_cliente", "Id_alquiler"
order by c.customer_id asc


//**Ejercicio 44. Realiza un CROSS JOIN entre las tablas film y category. ¿Aporta valor
esta consulta? ¿Por qué? Deja después de la consulta la contestación.**//


select f.film_id,
       f.title as "Titulo_pelicula",
       c.category_id,
       c."name" as "Category"
from film as f
inner join film_category as fc
on f.film_id = fc.film_id
cross join category as c
group by f.film_id, "Titulo_pelicula", c.category_id, "Category"
order by f.film_id asc

*Respuesta: Esta consulta no aporta valor porque muestra todas las categorías de peliculas existentes por cada película*
 

//**Ejercicio 45. Encuentra los actores que han participado en películas de la categoría
'Action'.**//

select a.actor_id,
       concat(a.first_name, ' ', a.last_name) as "Nombre_actor"
from film as f
inner join film_actor as fa
on fa.film_id = f.film_id
inner join actor as a
on a.actor_id = fa.actor_id 
inner join film_category as fc
on f.film_id = fc.film_id
where fc.category_id = 1
group by a.actor_id, "Nombre_actor"
order by a.actor_id asc


//**Ejercicio 46. Encuentra todos los actores que no han participado en películas.**//


select a.actor_id,
       concat(a.first_name, ' ', a.last_name) as "Nombre_actor",
       fa.film_id
from actor as a
right join film_actor as fa
on a.actor_id = fa.actor_id
where fa.film_id is NULL
group by a.actor_id, "Nombre_actor", fa.film_id
order by a.actor_id asc

-- Otra forma--

select a.actor_id 
from actor as a
where exists (
		select 1
		from film_actor as fa
		where fa.actor_id = a.actor_id)

*Con where exists aparecen los 200 actores*

--Otra forma--

select a.actor_id 
from actor as a
where not exists (
		select *
		from film_actor as fa
		where fa.actor_id = a.actor_id)
		
*Con where not exists no aparece ningún resultado*
		
*Respuesta: no hay ningún actor que no haya participado al menos en una pelicula*.

//**Ejercicio 47. Selecciona el nombre de los actores y la cantidad de películas en 
que han participado.**//


with Cantidad_peliculas as (
		select a.actor_id as "actor_id",
			   concat(a."first_name", ' ', a."last_name") as "Nombre_actor",
			   count(fa."film_id") as "Numero_peliculas"
		from actor as a
		inner join film_actor as fa
		on a."actor_id" = fa."actor_id"
		group by a.actor_id)
select "actor_id", "Nombre_actor", "Numero_peliculas"
from Cantidad_peliculas
order by  "actor_id" asc

-----Otra forma--

select a.actor_id,
	   concat(a."first_name", ' ', a."last_name") as "Nombre_actor",
	   count(fa.film_id) as "Numero_peliculas"
from actor as a
inner join film_actor fa 
on a.actor_id = fa.actor_id 
group by a.actor_id 
order by a.actor_id asc

//**Ejercicio 48. Crea una vista llamada “actor_num_peliculas” que muestre los nombres
de los actores y el número de películas en las que han participado.**//

create view actor_num_peliculas as
with Cantidad_peliculas as (
		select a.actor_id as "actor_id",
			   concat(a."first_name", ' ', a."last_name") as "Nombre_actor",
			   count(fa."film_id") as "Numero_peliculas"
		from actor as a
		inner join film_actor as fa
		on a."actor_id" = fa."actor_id"
		group by a.actor_id)
select "actor_id", "Nombre_actor", "Numero_peliculas"
from Cantidad_peliculas
order by  "actor_id" asc

//**Ejercicio 49. Calcula el número total de alquileres realizados por cada cliente.**//

select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   count (distinct r.rental_id) as "Numero_alquileres"
from rental as r
inner join customer as c
on r.customer_id = c.customer_id 
group by c.customer_id
order by c.customer_id asc

//**Ejercicio 50. Calcula la duración total de las películas en la categoría 'Action'.**//

select fc.category_id,
	   c."name" as "Nombre_categoria",
	   sum(f.length) as "Duracion_total"
from film as f
inner join film_category fc 
on f.film_id = fc.film_id 
inner join category as c
on fc.category_id = c.category_id 
group by fc.category_id, "Nombre_categoria"
having c."name" = 'Action'


//**Ejercicio 51. Crea una tabla temporal llamada “cliente_rentas_temporal” para
almacenar el total de alquileres por cliente.**//

create temp table "cliente_rentas_temporal" as
select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   count(distinct r.rental_id) as "Total_alquileres"
from rental as r
inner join customer as c
on r.customer_id = c.customer_id 
group by c.customer_id, "Nombre_cliente"
order by c.customer_id asc

//**Ejercicio 52. Crea una tabla temporal llamada “peliculas_alquiladas” que almacene las
películas que han sido alquiladas al menos 10 veces.**//

create temp table "peliculas_alquiladas" as
select f.film_id,
	   f.title as "Titulo_pelicula",
	   count(distinct r.rental_id) as "Numero_alquileres"
from inventory as i
left join film as f
on i.film_id = f.film_id 
inner join rental as r
on r.inventory_id = i.inventory_id 
group by f.film_id, "Titulo_pelicula"
having count(distinct r.rental_id) >= 10
order by f.film_id asc


//**Ejercicio 53. Encuentra el título de las películas que han sido alquiladas por el cliente
con el nombre ‘Tammy Sanders’ y que aún no se han devuelto. Ordena
los resultados alfabéticamente por título de película.**//

select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   f.title as "Titulo_pelicula",
	   r.return_date as "Fecha_devolucion"
from rental as r
inner join customer as c
on c.customer_id = r.customer_id 
inner join inventory as i
on i.inventory_id = r.inventory_id 
inner join film as f
on f.film_id = i.film_id 
group by c.customer_id, "Nombre_cliente", "Titulo_pelicula", "Fecha_devolucion"
having r.return_date is null and concat(c.first_name, ' ', c.last_name) = 'TAMMY SANDERS'
order by "Titulo_pelicula" asc

//**Ejercicio 54. Encuentra los nombres de los actores que han actuado en al menos una
película que pertenece a la categoría ‘Sci-Fi’. Ordena los resultados
alfabéticamente por apellido.**//

select a.actor_id,
	   concat(a.first_name, ' ', a.last_name) as "Nombre_actor",
	   fc.category_id as "Categoria_id"
from actor as a
inner join film_actor as fa
on fa.actor_id = a.actor_id 
inner join film as f
on f.film_id = fa.film_id 
inner join film_category as fc
on fc.film_id = f.film_id 
group by a.actor_id, "Nombre_actor", "Categoria_id"
having fc.category_id = 14
order by a.last_name asc

**Ejercicio 55. Encuentra el nombre y apellido de los actores que han actuado en
películas que se alquilaron después de que la película ‘Spartacus
Cheaper’ se alquilara por primera vez. Ordena los resultados
alfabéticamente por apellido.**//

with fecha_primer_alquiler as (
		select distinct(f."film_id") as "Id_film", 
		a."actor_id", r.rental_date
		from inventory as i
		inner join film as f
		on f."film_id" = i."film_id"
		inner join rental as r
		on r."inventory_id" = i."inventory_id"
		inner join film_actor as fa
		on fa.film_id = f.film_id 
		inner join actor as a
		on a.actor_id = fa.actor_id 
		group by f."film_id", a.actor_id, r.rental_date
		having r.rental_date > (select min(r.rental_date) as "Fecha_minima"
								from inventory as i
								inner join film as f
								on f."film_id" = i."film_id"
								inner join rental as r
								on r."inventory_id" = i."inventory_id"
								where f."title" = 'SPARTACUS CHEAPER'))
select distinct(actor_id),
	   a."first_name" as "Nombre_actor",
	   a."last_name" as "Apellido_actor" 
from actor as a
		where exists(
		select *
		from fecha_primer_alquiler
		where a.actor_id = fecha_primer_alquiler.actor_id)
order by "Apellido_actor" asc


//**Ejercicio 56. Encuentra el nombre y apellido de los actores que no han actuado en
ninguna película de la categoría ‘Music’**//

with actor_categoria as (
					select  a."actor_id",
					concat(a."first_name", ' ', a."last_name") as "Nombre_actor",
					f.film_id,
					fc.category_id as "Categoria"
					from film as f
					left join film_category as fc
					on fc.film_id = f.film_id 
					inner join film_actor as fa
					on f.film_id = fa.film_id 
					inner join actor as a
					on a.actor_id = fa.actor_id
					where fc.category_id = 12
					group by  a."actor_id", "Nombre_actor", f.film_id, "Categoria"
					order by "Nombre_actor" asc)
select distinct(actor_id),
	   concat(a."first_name", ' ', a."last_name") as "Nombre_apellido_actor"
from actor as a
		where not exists(
		select *
		from actor_categoria
		where a.actor_id = actor_categoria.actor_id)
order by a.actor_id asc
		
		
//**Ejercicio 57. Encuentra el título de todas las películas que fueron alquiladas por más
de 8 días.**//


select distinct(f."film_id") as "Id_film",
		f."title" as "Titulo_pelicula",
		extract(day from r.return_date) - extract(day from r.rental_date)  as "Duracion_alquiler",
		r.rental_id
from inventory as i
inner join film as f
on f."film_id" = i."film_id"
inner join rental as r
on r."inventory_id" = i."inventory_id"
group by f."film_id", r.rental_date, r.return_date, r.rental_id
having extract(day from r.return_date) - extract(day from r.rental_date) > 8 
and extract(day from r.return_date) - extract(day from r.rental_date) is not null
order by "Duracion_alquiler" desc


//**Ejercicio 58. Encuentra el título de todas las películas que son de la misma categoria que
que ‘Animation’**//


select f.title as "Titulo_pelicula",
	   c."name" as "Categoria"
from film as f
inner join film_category as fc
on f.film_id = fc.film_id 
inner join category as c
on fc.category_id = c.category_id 
where c."name" = 'Animation'
group by "Titulo_pelicula", "Categoria"
order by "Titulo_pelicula" asc

//**Ejercicio 59. Encuentra los nombres de las películas que tienen la misma duración
que la película con el título ‘Dancing Fever’. Ordena los resultados
alfabéticamente por título de película.**//

select f.title as "Titulo_pelicula",
	   f.length as "Duracion"
from film as f
group by "Titulo_pelicula", "Duracion"
having f.length = (select f.length
				   from film as f
				   where f."title" = 'DANCING FEVER') and f.title <> 'DANCING FEVER'
order by "Titulo_pelicula" asc


//**Ejercicio 60. Encuentra los nombres de los clientes que han alquilado al menos 7
películas distintas. Ordena los resultados alfabéticamente por apellido.**//

select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   count(distinct f.film_id) as "Peliculas_alquiladas"
from customer as c
inner join rental as r
on c.customer_id = r.customer_id 
inner join inventory as i
on i.inventory_id = r.inventory_id 
inner join film as f
on f.film_id = i.film_id
group by c.customer_id
having  count(distinct f.film_id) >= 7
order by c.last_name asc


61. Encuentra la cantidad total de películas alquiladas por categoría
muestra el nombre de la categoría junto con el recuento de alquileres.


select c."name" as "Categoria",
	   count(distinct r.rental_id) as "Recuento_alquileres"
from  rental as r
inner join inventory as i
on i.inventory_id = r.inventory_id 
inner join film as f
on f.film_id = i.film_id
inner join film_category as fc
on fc.film_id = f.film_id 
inner join category as c
on c.category_id = fc.category_id 
group by "Categoria"
order by "Categoria" asc


//**Ejercicio 62. Encuentra el número de películas por categoría estrenadas en 2006.**//

select c."name" as "Categoria",
	   count(distinct r.rental_id) as "Recuento_alquileres"
from  rental as r
inner join inventory as i
on i.inventory_id = r.inventory_id 
inner join film as f
on f.film_id = i.film_id
inner join film_category as fc
on fc.film_id = f.film_id 
inner join category as c
on c.category_id = fc.category_id 
where f.release_year = 2006
group by "Categoria"
order by "Categoria" asc

//**Ejercicio 63. Obtén todas las combinaciones posibles de trabajadores con las tiendas
que tenemos.**//

select s2.staff_id,
	   concat(s2."first_name",' ', s2."last_name") as "Nombre_empleado",
	   s.store_id as "Tienda"
from store as s
cross join staff as s2 


//**Ejercicio 64. Encuentra la cantidad total de películas alquiladas por cada cliente y
muestra el ID del cliente, su nombre y apellido junto con la cantidad de
películas alquiladas.**//


select c.customer_id,
	   concat(c.first_name, ' ', c.last_name) as "Nombre_cliente",
	   count(distinct f.film_id) as "Peliculas_alquiladas"
from customer as c
inner join rental as r
on c.customer_id = r.customer_id 
inner join inventory as i
on i.inventory_id = r.inventory_id 
inner join film as f
on f.film_id = i.film_id
group by c.customer_id
order by c.customer_id asc






























	
	
	

























	
	





