package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Inventario;

public interface InventarioRepository extends CrudRepository<Inventario, Long>{
	public List<Inventario> findAll();
	public Inventario findById(Integer id);
}
