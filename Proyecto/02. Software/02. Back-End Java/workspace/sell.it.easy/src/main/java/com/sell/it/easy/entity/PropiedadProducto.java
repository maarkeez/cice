package com.sell.it.easy.entity;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;

@Entity
public class PropiedadProducto {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	private String talla;
	private String codigoDeBarras;
	private String codigoDeEmpresa;
	private Float precioCoste;
	private Float precioVentaPublico;
	private Float descuento;
	@Lob
	private String imagenString;
	private Float IVA;
	
	public PropiedadProducto(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getTalla() {
		return talla;
	}

	public void setTalla(String talla) {
		this.talla = talla;
	}

	public String getCodigoDeBarras() {
		return codigoDeBarras;
	}

	public void setCodigoDeBarras(String codigoDeBarras) {
		this.codigoDeBarras = codigoDeBarras;
	}

	public String getCodigoDeEmpresa() {
		return codigoDeEmpresa;
	}

	public void setCodigoDeEmpresa(String codigoDeEmpresa) {
		this.codigoDeEmpresa = codigoDeEmpresa;
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

	public Float getDescuento() {
		return descuento;
	}

	public void setDescuento(Float descuento) {
		this.descuento = descuento;
	}

	public String getImagenString() {
		return imagenString;
	}

	public void setImagenString(String imagenString) {
		this.imagenString = imagenString;
	}

	public Float getIVA() {
		return IVA;
	}

	public void setIVA(Float iVA) {
		IVA = iVA;
	}
	
	
}
