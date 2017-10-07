package com.sell.it.easy.repository;

import java.util.Date;
import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.sell.it.easy.entity.VentaFisica;

public interface VentaFisicaRepository extends CrudRepository<VentaFisica, Long>{
	public List<VentaFisica> findAll();
	public VentaFisica findById(Integer id);
	public List<VentaFisica> findAllByOrderByFechaDesc();
	public List<VentaFisica> findByPedido_Tienda_idAndFechaGreaterThanEqualAndFechaLessThanEqual(Integer idTienda, Date fechaInicio, Date fechaFin);
}
