package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.PedidoProductos;

public interface PedidoProductosRepository extends CrudRepository<PedidoProductos, Long>{
	public List<PedidoProductos> findAll();
	public PedidoProductos findById(Integer id);

}