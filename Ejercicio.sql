--punto1
select localidad.codpostal, localidad.localidad, provincia.provincia, count(*)
from localidad, provincia, infraccion
where localidad.idprovincia = provincia.idprovincia
and localidad.codpostal in 
	(select infraccion.codpostal
	where infraccion.fecha >= '1988-01-01'
	and infraccion.fecha < '2000-01-01')
group by localidad.codpostal, provincia.provincia
order by localidad.codpostal asc, provincia.provincia


--punto2 
select sum(tipoinfraccion.importe)
from infraccion, tipoinfraccion
where infraccion.codpostal in
	(select codpostal
	from localidad, provincia
	where provincia = 'Entre Ríos'
	and localidad.idprovincia = provincia.idprovincia)
and tipoinfraccion.tipoinfraccion = infraccion.tipoinfraccion


--punto3
select tipoinfraccion.tipoinfraccion, tipoinfraccion.descripcion, sexo, count(*)
from infraccion, tipoinfraccion, persona
where infraccion.fecha >= '1990-01-01'
and infraccion.fecha < '1991-01-01'
and infraccion.dni = persona.dni
and infraccion.tipoinfraccion = tipoinfraccion.tipoinfraccion
group by tipoinfraccion.tipoinfraccion, sexo


--punto4
select vehiculo.patente, marca, modelo, anio, count(*)
from vehiculo, marca, modelo, infraccion
where vehiculo.patente in
	(select infraccion.patente)
and vehiculo.idmodelo = modelo.idmodelo
and modelo.idmarca = marca.idmarca
group by vehiculo.patente, marca, modelo
having count(*) >= 4
order by count


--punto5
create view punto5 (localidad, cant) as
	(select localidad.localidad, count(*) cant
	from localidad, infraccion, tipoinfraccion
	where tipoinfraccion.descripcion = 'Estacionamiento indebido'
	and infraccion.fecha between '1998-01-01' and '2000-01-01'
	and infraccion.tipoinfraccion = tipoinfraccion.tipoinfraccion
	and localidad.codpostal = infraccion.codpostal
	group by localidad.localidad)


select localidad, cant
from punto5
where cant =
	(select max(cant)
	from punto5)



--punto6
select localidad.codpostal, i1.tipoinfraccion, (select count(*)
						from infraccion i2
						where localidad.codpostal = i2.codpostal
						and i1.tipoinfraccion = i2.tipoinfraccion
						and i2.fecha between '1980-01-01' and '1990-01-01') ochentas, ( select count(*)
														from infraccion i2
														where localidad.codpostal = i2.codpostal
														and i1.tipoinfraccion = i2.tipoinfraccion
														and i2.fecha between '1990-01-01' and '2000-01-01') noventas
from localidad, infraccion i1
group by localidad.codpostal, i1.tipoinfraccion
order by codpostal, tipoinfraccion

/* "usado para probar"
select count(*)
from infraccion i
where i.fecha between '1980-01-01' and '1990-01-01'
and i.codpostal = 3371
and i.tipoinfraccion = 4*/


--punto7
select infraccion.patente, infraccion.dni, sum
