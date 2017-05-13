package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Imagen;

public interface ImagenRepository extends CrudRepository<Imagen, Long>{
	public List<Imagen> findAll();

}
