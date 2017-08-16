-- Tipos de productos
insert into tipo_producto values (0,'Textil');
update tipo_producto set id = 0;
insert into tipo_producto values (1,'Alimentación');
insert into tipo_producto values (2,'Transporte');

-- Tipos de compra
insert into tipo_compra values (0,'Física');
update tipo_compra set id = 0;
insert into tipo_compra values (1,'Online');

-- Tipos de pago
insert into tipo_pago values (0,'Efectivo');
update tipo_pago set id = 0;
insert into tipo_pago values (1,'Tarjeta');
