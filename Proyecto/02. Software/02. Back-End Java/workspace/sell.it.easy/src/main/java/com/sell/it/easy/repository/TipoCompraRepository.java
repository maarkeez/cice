package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.TipoCompra;

public interface TipoCompraRepository extends CrudRepository<TipoCompra, Long>{
	public List<TipoCompra> findAll();
	public TipoCompra findById(Integer id);
}
