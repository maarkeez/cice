package com.sell.it.easy.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;

@Entity
public class PedidoProductos {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	@ManyToOne(optional=false)
	private Producto producto;
	private Float precioCoste;
	private Float precioVentaPublico;
	@Column(nullable=false)
	private Float cantidad;
	
	@ManyToOne(optional=true)
	private Inventario inventario;
	
	@ManyToOne(optional=true)
	private Pedido pedido;
	
	
	public PedidoProductos(){
		
	}


	public Integer getId() {
		return id;
	}


	public void setId(Integer id) {
		this.id = id;
	}


	public Producto getProducto() {
		return producto;
	}


	public void setProducto(Producto producto) {
		this.producto = producto;
	}


	public Float getPrecioCoste() {
		return precioCoste;
	}


	public void setPrecioCoste(Float precioCoste) {
		this.precioCoste = precioCoste;
	}


	public Float getPrecioVentaPublico() {
		return precioVentaPublico;
	}


	public void setPrecioVentaPublico(Float precioVentaPublico) {
		this.precioVentaPublico = precioVentaPublico;
	}


	public Float getCantidad() {
		return cantidad;
	}


	public void setCantidad(Float cantidad) {
		this.cantidad = cantidad;
	}


	public Inventario getInventario() {
		return inventario;
	}


	public void setInventario(Inventario inventario) {
		this.inventario = inventario;
	}


	public Pedido getPedido() {
		return pedido;
	}


	public void setPedido(Pedido pedido) {
		this.pedido = pedido;
	}
	
	
}
