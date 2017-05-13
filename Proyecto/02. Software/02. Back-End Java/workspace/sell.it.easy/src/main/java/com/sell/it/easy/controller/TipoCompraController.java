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

import com.sell.it.easy.entity.TipoCompra;
import com.sell.it.easy.repository.TipoCompraRepository;

@RestController
@RequestMapping(value="/tipocompra")
public class TipoCompraController {

	
//	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private TipoCompraRepository repository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<TipoCompra> index(HttpSession session, HttpServletRequest request) {
		return repository.findAll();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody TipoCompra alta(HttpServletRequest request, @RequestBody TipoCompra tipoCompra) {

		tipoCompra  = repository.save(tipoCompra);

		return tipoCompra;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

		repository.delete(repository.findById(id));
			return true;
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody TipoCompra editar(@PathVariable Integer id, HttpServletRequest request, @RequestBody TipoCompra tipoCompra) {

		repository.save(tipoCompra);
			return tipoCompra;
	}


}
