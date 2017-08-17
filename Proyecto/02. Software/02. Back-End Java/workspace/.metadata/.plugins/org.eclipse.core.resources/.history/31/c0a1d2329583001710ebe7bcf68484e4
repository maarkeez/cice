package com.sell.it.easy.entity;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Pedido {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	@Column(nullable=false)
	private Date fechaApertura;
	private Date fechaCierre;
	@ManyToOne
	private TipoPago tipoPago;
	@ManyToOne
	private TipoCompra tipoCompra;
	
	@OneToMany(mappedBy="pedido")
	private List<PedidoProductos> productos = new ArrayList<PedidoProductos>();
	@ManyToOne
	private Tienda tienda;
	public Pedido(){
		
	}
	public Integer getId() {
		return id;
	}
	public void setId(Integer id) {
		this.id = id;
	}
	public Date getFechaApertura() {
		return fechaApertura;
	}
	public void setFechaApertura(Date fechaApertura) {
		this.fechaApertura = fechaApertura;
	}
	public Date getFechaCierre() {
		return fechaCierre;
	}
	public void setFechaCierre(Date fechaCierre) {
		this.fechaCierre = fechaCierre;
	}
	public TipoPago getTipoPago() {
		return tipoPago;
	}
	public void setTipoPago(TipoPago tipoPago) {
		this.tipoPago = tipoPago;
	}
	public TipoCompra getTipoCompra() {
		return tipoCompra;
	}
	public void setTipoCompra(TipoCompra tipoCompra) {
		this.tipoCompra = tipoCompra;
	}
	public List<PedidoProductos> getProductos() {
		return productos;
	}
	public void setProductos(List<PedidoProductos> productos) {
		this.productos = productos;
	}
	public void addProductos(PedidoProductos producto) {
		this.productos.add(producto);
	}
	public Tienda getTienda() {
		return tienda;
	}
	public void setTienda(Tienda tienda) {
		this.tienda = tienda;
	}
	
	
}
