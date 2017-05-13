package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Rol;

public interface RolRepository extends CrudRepository<Rol, Long>{
	public List<Rol> findAll();
	public Rol findById(Integer id);

}