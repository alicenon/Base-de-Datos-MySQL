use world;
/*
Recuperar el pais y la poblacion del pais que tiene mas habitantes, consulta que ya habiamos implementado pero de una forma nada eficiente utilizando order by y limit.
*/
SELECT 
    Name `Pais`, 
    Population `Población`
FROM
    country
WHERE
    Population = (SELECT MAX(Population) FROM country);
    
-- Ejercicio # 1 del jueves 19 de noviembre: Recuperar la ciudad  que tiene mas habitantes y el pais donde se encuentra dicha ciudad, utilizando subconsultas
SELECT 
    ci.Name `Ciudad`, 
    ci.Population `Población`,
	(SELECT co.name FROM country co WHERE co.Code = ci.CountryCode ) `PAIS`
FROM
    city ci
WHERE
    Population = (SELECT MAX(ci.Population) FROM country) order by ci.Population desc limit 1;
    
-- Solucion real:
SELECT
    ci.name `Ciudad`, co.name `Pais`, ci.Population `Poblacion`
FROM
    city ci
        INNER JOIN
    country co ON ci.CountryCode = co.Code
WHERE ci.Population = (SELECT MAX(Population) FROM city);


USE jardineria;
/*
*** BASE DE DATOS JARDINERIA
TIPOS DE SUBCONSULTAS
1. Subconsultas de fila: Devuelven multiples columnas (campos) y una sola fila.
2. Subconsultas de tabla: Pueden devolver una o varias columnas y entre cero y varias filas.
3. Subconsultas escalares: Devuelven una columna y una fila (una celda) es decir un valor.
*/

/* Subconsultas en la clausula WHERE */

-- Por Ejemplo: Suponga queremos conocer el nombre del producto que tiene mayor precio
-- La solucion, una de las posibles, seria: Realizar una primera consulta, que es la subconsulta, para recuperar el precio maximo y, 
-- a continuacion , en la consulta principal buscar el nombre del producto cuyo precio coincide con el valor del precio maximo. 
SELECT 
    nombre
FROM
    producto
WHERE
    precio_venta = (SELECT MAX(precio_venta) FROM producto);
            
select * from producto order by precio_venta desc limit 1;


/*BADE DE DATOS TIENDA*/
USE tienda;

/*Subconsulta en la clausula HAVING
Recuperar un listado con todos los nombre de los fabricantes que tiene el mismo numero de productos que el fabricante Asus.
*/

-- Solución Del ejercicio de clase: Eliminacion del listado al fabricante Asus
select fa.nombre, count(*) as `Total Productos`
from fabricante fa inner join producto pro on fa.id = pro.id_fabricante and fa.nombre != 'Asus'
-- where fa.nombre != 'Asus'
group by fa.nombre
having `Total Productos` = (select count(pro1.id_fabricante) from fabricante fa1 inner join producto pro1 on fa1.id = pro1.id_fabricante and fa1.nombre = 'Asus')
order by fa.nombre ;

/* SubConsultas en la Clausula FROM 
	Recuperara el listado de todos los productos que tienen un precio mayor o igual al precio promedio, o medio, de todos los productos de su mismo fabricante
*/
SELECT 
    producto.*
FROM
    producto
INNER JOIN (
	SELECT id_fabricante, AVG(precio) `Precio Promedio`
    FROM producto
    group by id_fabricante) t on producto.id_fabricante = t.id_fabricante
    AND producto.precio >= `Precio Promedio`
ORDER BY precio desc;



    