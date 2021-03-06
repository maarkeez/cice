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

import com.sell.it.easy.entity.Organizacion;
import com.sell.it.easy.repository.OrganizacionRepository;

@RestController
@RequestMapping("/organizacion")
public class OrganizacionController {

	@Autowired
	private OrganizacionRepository organizacionRepository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<Organizacion> index(HttpSession session, HttpServletRequest request) {
		return organizacionRepository.findAllByOrderByNombreAsc();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody Organizacion alta(HttpServletRequest request, @RequestBody Organizacion organizacion) {

		Organizacion organizacionCreada = organizacionRepository.save(organizacion);

		return organizacionCreada;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

		organizacionRepository.delete(organizacionRepository.findById(id));
		return true;
	}

	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody Organizacion editar(@PathVariable Integer id, HttpServletRequest request,
			@RequestBody Organizacion organizacion) {

		organizacionRepository.save(organizacion);
		return organizacion;
	}
}
