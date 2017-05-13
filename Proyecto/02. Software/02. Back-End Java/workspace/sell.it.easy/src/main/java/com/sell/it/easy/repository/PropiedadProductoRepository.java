package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.PropiedadProducto;

public interface PropiedadProductoRepository extends CrudRepository<PropiedadProducto, Long>{
	public List<PropiedadProducto> findAll();
	public PropiedadProducto findById(Integer id);

}