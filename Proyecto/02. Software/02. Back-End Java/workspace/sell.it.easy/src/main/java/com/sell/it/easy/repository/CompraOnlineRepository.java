package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.CompraOnline;

public interface CompraOnlineRepository extends CrudRepository<CompraOnline, Long>{
	public List<CompraOnline> findAll();
	public CompraOnline findById(Integer id);

}
