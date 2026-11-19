use empresa;

-- Recuperar todos los empleados y sus numeros de telefono
SELECT 
    emp.nombre,
    emp.primerApellido,
    emp.segundoApellido,
    tel.numero
FROM
    empleados emp
        INNER JOIN
    telefonos tel ON emp.id = tel.empleado_id;
-- con lef join recupera empleados tengan  o no tengan numeros de telefono.

use world;
-- Ejercicio # 2 del miercoles 18 de nov:: Recuperar los paises y el idioma hablado en cada pais,
-- siempre que sea una lengua oficial
SELECT 
    co.name, cl.Language
FROM
    country co
        INNER JOIN
    countrylanguage cl ON co.Code = cl.CountryCode
WHERE
    cl.IsOfficial = 'T';
    
-- Ejercicio # 3 del miercoles 18 de nov: Recuperar la ciudad mas poblada 
-- y el nombre del pais donde se encuentra dicha ciudad.
SELECT
    ci.name, co.name, max(ci.Population)
FROM
    city ci
        INNER JOIN
    country co ON ci.CountryCode = co.Code;

    
SELECT
    ci.name, co.name, max(ci.Population)
FROM
    city ci
        INNER JOIN
    country co ON ci.CountryCode = co.Code
GROUP BY ci.name , co.name;
    
-- Ejercicio # 4 del miercoles 18 de nov: Modificar los resultados del ejercicio #2 para
-- que solamente se muestren los resultados para España y todos los idiomas, no solo los oficiales

SELECT 
    co.name, cl.Language
FROM
    country co
        LEFT JOIN
    countrylanguage cl ON co.Code = cl.CountryCode
WHERE
    co.Name = 'Spain';
