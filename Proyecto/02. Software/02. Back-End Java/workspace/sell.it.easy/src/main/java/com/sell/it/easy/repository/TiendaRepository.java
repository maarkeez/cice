package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Tienda;

public interface TiendaRepository extends CrudRepository<Tienda, Long>{
	public List<Tienda> findAll();
	
	public Tienda findById(Integer id);

}
