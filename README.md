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
