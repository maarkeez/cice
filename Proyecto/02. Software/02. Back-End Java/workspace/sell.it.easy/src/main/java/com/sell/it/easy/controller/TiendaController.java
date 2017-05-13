package com.sell.it.easy.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sell.it.easy.entity.Tienda;
import com.sell.it.easy.repository.TiendaRepository;

@RestController
@RequestMapping("/tienda")
public class TiendaController {

//	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private TiendaRepository tiendaRepository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<Tienda> index(HttpSession session, HttpServletRequest request) {
		return tiendaRepository.findAll();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody Tienda alta(HttpServletRequest request, @RequestBody Tienda tienda) {

		Tienda tiendaCreada = tiendaRepository.save(tienda);

		return tiendaCreada;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

		tiendaRepository.delete(tiendaRepository.findById(id));
			return true;
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody Tienda editar(@PathVariable Integer id, HttpServletRequest request, @RequestBody Tienda tienda) {

		tiendaRepository.save(tienda);
			return tienda;
	}

}