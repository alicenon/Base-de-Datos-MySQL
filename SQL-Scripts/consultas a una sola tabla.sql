/* La sentencia u orden siguiente pone en uso la base de datos o esquema
world, para realizar consultas a sus tablas */
use world;

-- Comentario a nivel de linea.
-- La sintaxis de la sentencia de SQL mas pequeña que se puede ejecutar
-- por ejemplo, para recuperar todos los registros de la tabla country.
select * from country;

table country;

-- Recuperar el campo Region de la tabla
SELECT 
    Region
FROM
    country;
-- Actualmente ya no es necesario utilizar la palabra reservada "As" para establecer un alias a un campo.
select Region LaRegion from country;

-- Para espacios en el alias usar los backticks. Tipo de comillas situado a lado de la letra P. 
select Region `La Region` from country;
select Region "La Region" from country; -- "" no es recomendado porque se suele usar para comparar y etc.

-- Recuperar varios campos separados por coma.
SELECT 
    Region, SurfaceArea, IndepYear, Population
FROM
    country;
    
-- Uso de la clausula distinct, por ejemplo para ver cuantas regiones diferentes existen
-- en la tabla country (OBTIENE REGISTROS SIN DUPLICADOS) lo miramos con un order by antes 239 filas, pero con distinc se quedan en 25.
SELECT distinct
    Region
FROM
    country
ORDER BY Region asc; -- ordenar por region de A-Z (PROBAR SIN DISTINC Y LUEGO USAR DISTINC)

-- Para limitar la cantidad de registros por la consulta se utiliza la clausula LIMIT.
SELECT distinct
    Region
FROM
    country
ORDER BY Region asc limit 3; -- limitamos a 3 registros

-- Si quisieramos pasar por alto los tres primeros registros y recuperar los 5 restantes.
SELECT distinct
    Region
FROM
    country
ORDER BY Region asc limit 3, 5; -- limit <OMINIR LOS TRES PRIMEROS>, <DAME LOS OTROS 5>

-- EJERCICIO: Recuperar el pais (name) que tiene la mayor poblacion (Population)
-- Solución 1 básica y no recomendada. 
SELECT
    Name,
    Population
FROM
    country
ORDER BY Population desc limit 1; 

-- Solucion 2 correcta y optima, si?
SELECT
    Name,
    Population
FROM
    country
where Population = (select max(Population) from country);

-- LA CLAUSULA WHERE
-- Por ejemplo: Recuperar los paises que tienen una poblacion superior a los 10 milllones de habitantes.
select * from country where Population > 10000000 order by Population asc;

-- A la consulta anterior agregar la condicionde que el pais haya obtenido su independencia.
select * from country where Population > 10000000 and IndepYear is not null order by Population asc;

-- A la consulta anterior agregar la condicionde que el pais haya NO obtenido su independencia.
select * from country where Population > 10000000 and IndepYear is null order by Population asc;


-- En la consulta anterior agregar la condicion de que la region sea del CARIBE
SELECT 
    *
FROM
    country
WHERE
    Population > 10000
        AND IndepYear IS NULL
        OR Region = 'Caribbean'

ORDER BY Population ASC;

/* Uso del operador LIKE. Para busquedas exactas se usa el operador de asignacion (=)
pero para busquedas mas relajadas se usa el Operador LIKE

Ejmplo: Recuperar todos los paises donde el campo continente contenga la palabra America*/
SELECT 
    name Pais,
    Continent Continente
FROM
    country
where Continent like '%America%';

-- Recuperar todos los paises donde la primera letra del Continente sea la letra A. 
SELECT 
    name Pais, Continent Continente
FROM
    country
where Continent like 'A%';

