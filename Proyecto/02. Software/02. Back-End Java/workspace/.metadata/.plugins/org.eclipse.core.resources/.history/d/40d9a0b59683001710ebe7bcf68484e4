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
public class Inventario {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	
	@Column(nullable=false)
	private Date fechaInicio;
	private Date fechaFin;
	
	@Column(nullable=false)
	private Boolean completo;
	
	@OneToMany(mappedBy="inventario")
	private List<PedidoProductos> productosInventariados = new ArrayList<PedidoProductos>();
	
	@ManyToOne
	private Tienda tiendaInventariada;
	
	public Inventario(){
		
	}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public Date getFechaInicio() {
		return fechaInicio;
	}

	public void setFechaInicio(Date fechaInicio) {
		this.fechaInicio = fechaInicio;
	}

	public Date getFechaFin() {
		return fechaFin;
	}

	public void setFechaFin(Date fechaFin) {
		this.fechaFin = fechaFin;
	}

	public Boolean getCompleto() {
		return completo;
	}

	public void setCompleto(Boolean completo) {
		this.completo = completo;
	}

	public List<PedidoProductos> getProductosInventariados() {
		return productosInventariados;
	}

	public void setProductosInventariados(List<PedidoProductos> productosInventariados) {
		this.productosInventariados = productosInventariados;
	}
	
	public void addProductosInventariados(PedidoProductos producto) {
		this.productosInventariados.add(producto);
	}

	public Tienda getTiendaInventariada() {
		return tiendaInventariada;
	}

	public void setTiendaInventariada(Tienda tiendaInventariada) {
		this.tiendaInventariada = tiendaInventariada;
	}
}
