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

import com.sell.it.easy.entity.VentaFisica;
import com.sell.it.easy.repository.VentaFisicaRepository;

@RestController
@RequestMapping(value="/ventafisica")
public class VentaFisicaController {

	
//	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private VentaFisicaRepository repository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<VentaFisica> index(HttpSession session, HttpServletRequest request) {
		return repository.findAll();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody VentaFisica alta(HttpServletRequest request, @RequestBody VentaFisica ventaFisica) {

		ventaFisica  = repository.save(ventaFisica);

		return ventaFisica;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

		repository.delete(repository.findById(id));
			return true;
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody VentaFisica editar(@PathVariable Integer id, HttpServletRequest request, @RequestBody VentaFisica ventaFisica) {

		repository.save(ventaFisica);
			return ventaFisica;
	}

}
