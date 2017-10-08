package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Stock;

public interface StockRepository extends CrudRepository<Stock, Long>{
	public List<Stock> findAllByTienda_id(Integer idTienda);
	public Stock findByTienda_idAndProducto_id(Integer idTienda, Integer idProducto);
}