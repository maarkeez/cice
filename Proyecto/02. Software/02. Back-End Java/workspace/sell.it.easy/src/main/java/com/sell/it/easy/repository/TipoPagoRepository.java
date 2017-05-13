package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.TipoPago;

public interface TipoPagoRepository extends CrudRepository<TipoPago, Long>{
	public List<TipoPago> findAll();
	public TipoPago findById(Integer id);
}
