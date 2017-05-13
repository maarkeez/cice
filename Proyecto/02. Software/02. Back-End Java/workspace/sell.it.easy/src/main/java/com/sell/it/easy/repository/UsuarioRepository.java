package com.sell.it.easy.repository;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.sell.it.easy.entity.Usuario;


public interface UsuarioRepository extends CrudRepository<Usuario, Long>{

	public List<Usuario> findAll();
	public Usuario findById(Integer id);
}
