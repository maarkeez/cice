package com.sell.it.easy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sell.it.easy.entity.Usuario;
import com.sell.it.easy.repository.UsuarioRepository;

@RestController
@RequestMapping("/usuario")
public class UsuarioController {

//	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private UsuarioRepository usuarioRepository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<Usuario> index(HttpSession session, HttpServletRequest request) {
		return usuarioRepository.findAll();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody Usuario alta(HttpServletRequest request, @RequestBody Usuario usuario) {

		Usuario usuarioCreado = usuarioRepository.save(usuario);

		return usuarioCreado;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

			usuarioRepository.delete(usuarioRepository.findById(id));
			return true;
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody Usuario editar(@PathVariable Integer id, HttpServletRequest request, @RequestBody Usuario usuario) {

			usuarioRepository.save(usuario);
			return usuario;
	}
	
	@RequestMapping(value = "/login", method = RequestMethod.POST)
	public @ResponseBody Usuario login(HttpServletRequest request, @RequestBody Usuario usuario) {
		Usuario usuarioBD = usuarioRepository.findByCorreo(usuario.getCorreo());
		if(usuarioBD.getPassword().equals(usuario.getPassword())){
			return usuarioBD;
		}
		return null;
	}

}
