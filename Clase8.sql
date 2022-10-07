use libreria_113868

create function f_palabra
(@descrip varchar (100) = 'pa')
returns table 
as
return (select descripcion, pre_unitario
        from articulos
		where descripcion like @descrip + '%')

select * from dbo.f_palabra (default)

-----------------------------------------------------------------------------
----------- funcion que devuelve una COLUMNA ----------------------------------
create function devolver_articulos

(@desc varchar (50))
returns @tablaart table (descrip varchar (50))
as
begin 
insert @tablaart
select descripcion
from articulos
where descripcion like '%' + @desc  + '%'
return 
end

select * from dbo.devolver_articulos('fibra')


-------------------------------------------------------------------
---------- SENTENCIAS DE CONTROL DE FLUJO--------------------------


 -- AUNMENTAR LOS PRECIOS DE LOS ARTICULOS MENOS A $30

if exists (select * from articulos where pre_unitario<30)
begin
 update articulos
 set pre_unitario=pre_unitario*1.1
 where pre_unitario<30
 select 'Precios actualizados'
end
else
select 'no hay artículos con esos precios'
---- se crea un procedimiento que muestre todos los articulos de
----una descripción determinada que se ingresa como parámetro


--create procedure pa_articulos_descripm
--@descripcion varchar(100)= null
--returns 
--as
--if @descripcion is null
--begin

-- select 'Debe indicar una descripción'
-- return
--end;


--select descripcion, pre_unitario, observaciones
-- from articulos
-- where descripcion like @descripcion '%'

-- select *
-- from dbo.pa_articulos_descripm ('fibra')


------------------------------------------------------------------------------------------
------------------------------ TRY .... CATCH -------------------------------------------------

BEGIN TRY 
SELECT 15/0 AS ERROR;
END TRY 
BEGIN CATCH 
SELECT 'SE PRODUJO EL SIGUIENTE ERROR',
ERROR_NUMBER () AS NUMERO,
ERROR_STATE () AS ESTADO,
ERROR_SEVERITY () AS GRAVEDAD,
ERROR_PROCEDURE() AS PROCEDIMIENTO,
ERROR_LINE () AS LINEA,
ERROR_MESSAGE () AS MENSAJE;
END CATCH;


-------------------@@ ERROR -------------------
-- MOSTRAR EL NUMERO DE ERROR EN EL CASO DE UNA DIVISION POR CERO

DECLARE @ERR INT
SELECT 1/0 AS ERROR;
SELECT @ERR = @@ERROR
IF @ERR <> 0
PRINT  'NRO. DE ERROR ES> / ' + LTRIM (STR (@ERR))

