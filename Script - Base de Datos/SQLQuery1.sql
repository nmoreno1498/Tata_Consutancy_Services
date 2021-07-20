--
--creacion de tablas Cliente, Pedidos Interior junto con Primary key
create table Cliente(
[ID] int identity not null,
[Nombre] nvarchar(15) null,
[Desc] nvarchar(20) null,
[is_active] int,
constraint pk_Cliente primary key clustered([ID] asc)) ON [PRIMARY]
go
--creacion de tablas Pedidos_Interior, Pedidos Interior junto con Primary key
create table Pedidos_Interior(
[ID] int identity not null,
[Cliente_ID] int not null,
[Desc] nvarchar(20) null,
[Estado] int,
constraint pk_Pedidos primary key clustered([ID] asc)) ON [PRIMARY]
go
--creacion de tablas Pedidos_Exterior, Pedidos Interior junto con Primary key
create table Pedidos_Exterior(
[ID] int identity not null,
[Cliente_ID] int not null,
[Desc] nvarchar(20) null,
[Estado] int,
constraint pk_Pedidos primary key clustered([ID] asc)) ON [PRIMARY]
go

-- creacion y seteo de llave extranjera

alter table Pedidos_Interior with check add constraint fk_cliente_int foreign key ([Cliente_ID]) references Cliente ([ID])
go
alter table Pedidos_Exterior with check add constraint fk_cliente_ext foreign key ([Cliente_ID]) references Cliente ([ID])
go

-- Inserir datos dentro de las tablas, para comenzar Test

insert into Pedidos_Exterior([Cliente_ID],[Desc],[Estado]) values 
(1, 'Raul',1),
(2, 'Marco',1),
(3,'Aurelio',1),
(4,'Solis',1),
(5,'Miguel',1)
--
insert into Pedidos_Interior([Cliente_ID],[Desc],[Estado]) values 
(1, 'Melo',1),
(2, 'Furtado',1),
(3,'DaSilva',1),
(4,'Flores',1),
(5,'Mellace',1)

-- Como hacer la diferencia entre 2 resultados de una consulta.
select * from Cliente
except
select C.* from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID
--Teniendo como referencias las tablas del modelo traer los clientes que no posean pedidos para exterior
--except
select * from Cliente
except
select C.* from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID

--Como hacer la unión entre 2 set de datos.
select C.* from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID
union
select C.* from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID

--Teniendo como referencias las tablas del modelo traer todos los pedidos (interior/exterior) para el cliente de id 3,4 o 5
--union
select P_Int.* from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID where C.ID in(3,4,5)
union
select P_Ext.* from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID where C.ID in(3,4,5)

--Teniendo como referencias las tablas del modelo devolver la cantidad de pedidos del interior que tiene el cliente 3,4,5

select * from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID where C.ID in(3,4,5)

--Como hacer la intersección.
select C.* from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID where C.ID in(3,4,5)
intersect
select C.* from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID where C.ID in(3,4,5)

--Teniendo como referencias las tablas del modelo devolver la cantidad total de pedidos por cliente
-- cuando se menciona cliente no entendi si era en relacion al ID o al Nombre, por las dudas hice los 2.
-- por ID - cLiente
select IdCliente, count (IdCliente) as TotalPedidosCliente
from
(select C.ID as IdCliente, C.Nombre, C.[Desc], C.is_active,P_Int.ID as IdPedido ,P_Int.Cliente_ID, P_Int.[Desc] as DescPedido, P_Int.Estado from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID
union
select C.ID as IdCliente, C.Nombre, C.[Desc], C.is_active,P_Ext.ID as IdPedido ,P_Ext.Cliente_ID, P_Ext.[Desc] as DescPedido, P_Ext.Estado from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID)
as TablasUnion
group by IdCliente 

-- Por nombre Cliente
select Nombre, count (IdCliente) as TablasPedidos
from
(select C.ID as IdCliente, C.Nombre, C.[Desc], C.is_active,P_Int.ID as IdPedido ,P_Int.Cliente_ID, P_Int.[Desc] as DescPedido, P_Int.Estado from Cliente C join Pedidos_Interior P_Int on C.ID = P_Int.Cliente_ID
union
select C.ID as IdCliente, C.Nombre, C.[Desc], C.is_active,P_Ext.ID as IdPedido ,P_Ext.Cliente_ID, P_Ext.[Desc] as DescPedido, P_Ext.Estado from Cliente C join Pedidos_Exterior P_Ext on C.ID = P_Ext.Cliente_ID)
as TablasUnion
group by Nombre 