package com.sell.it.easy.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.ManyToOne;

@Entity
public class Tienda {

	@Id
	@GeneratedValue(strategy=GenerationType.AUTO)
	private Integer id;
	@Column(nullable=false)
	private String nombre;
	
	@Lob
	private String imagenString;

	private String telefono;
	
	private String direccion;
	//@ManyToOne(optional=false)
	//private Organizacion organizacion;
	
	public Tienda(){}

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getNombre() {
		return nombre;
	}

	public void setNombre(String nombre) {
		this.nombre = nombre;
	}

	public String getImagenString() {
		return imagenString;
	}

	public void setImagenString(String imagenString) {
		this.imagenString = imagenString;
	}

	public String getTelefono() {
		return telefono;
	}

	public void setTelefono(String telefono) {
		this.telefono = telefono;
	}

	public String getDireccion() {
		return direccion;
	}

	public void setDireccion(String direccion) {
		this.direccion = direccion;
	}

//	public Organizacion getOrganizacion() {
//		return organizacion;
//	}
//
//	public void setOrganizacion(Organizacion organizacion) {
//		this.organizacion = organizacion;
//	}
	
	
}
