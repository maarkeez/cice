package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Organizacion;

public interface OrganizacionRepository extends CrudRepository<Organizacion, Long>{
	public List<Organizacion> findAll();
	public List<Organizacion> findAllByOrderByNombreAsc();
	public Organizacion findById(Integer id);

}
