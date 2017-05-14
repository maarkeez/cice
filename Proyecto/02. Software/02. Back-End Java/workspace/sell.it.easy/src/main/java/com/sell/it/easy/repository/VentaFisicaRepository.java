package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.VentaFisica;

public interface VentaFisicaRepository extends CrudRepository<VentaFisica, Long>{
	public List<VentaFisica> findAll();
	public VentaFisica findById(Integer id);
}