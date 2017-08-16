package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.Producto;

public interface ProductoRepository extends CrudRepository<Producto, Long>{
	public List<Producto> findAll();
	public List<Producto> findByPropiedades_codigoDeBarras(String codigoDeBarras);
	public Producto findById(Integer id);

}
