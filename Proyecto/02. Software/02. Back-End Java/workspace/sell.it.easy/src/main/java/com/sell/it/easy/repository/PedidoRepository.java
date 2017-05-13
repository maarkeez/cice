package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Pedido;

public interface PedidoRepository extends CrudRepository<Pedido, Long>{
	public List<Pedido> findAll();
	public Pedido findById(Integer id);

}
