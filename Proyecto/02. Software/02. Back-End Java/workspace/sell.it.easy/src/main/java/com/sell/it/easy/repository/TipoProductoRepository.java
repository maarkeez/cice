package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.TipoProducto;

public interface TipoProductoRepository extends CrudRepository<TipoProducto, Long>{
	public List<TipoProducto> findAll();
	public TipoProducto findById(Integer id);
}
