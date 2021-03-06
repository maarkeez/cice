package com.sell.it.easy.controller;

import java.util.ArrayList;
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

import com.sell.it.easy.entity.PedidoProductos;
import com.sell.it.easy.repository.PedidoProductosRepository;

@RestController
@RequestMapping(value="/pedidoproductos")
public class PedidoProductosController {


//	private final Logger log = LoggerFactory.getLogger(this.getClass());

	@Autowired
	private PedidoProductosRepository repository;

	@RequestMapping(value = "/todos", method = RequestMethod.GET)
	public @ResponseBody List<PedidoProductos> index(HttpSession session, HttpServletRequest request) {
		return repository.findAll();
	}

	@RequestMapping(value = "/alta", method = RequestMethod.POST)
	public @ResponseBody PedidoProductos alta(HttpServletRequest request, @RequestBody PedidoProductos pedidoProducto) {

		pedidoProducto = repository.save(pedidoProducto);

		return pedidoProducto;
	}
	
	@RequestMapping(value = "/altas", method = RequestMethod.POST)
	public @ResponseBody List<PedidoProductos> altas(HttpServletRequest request, @RequestBody List<PedidoProductos> listado) {
		List<PedidoProductos> toReturn = new ArrayList<PedidoProductos>();
		for (PedidoProductos pedidoProducto: listado){
			pedidoProducto = repository.save(pedidoProducto);
			if(pedidoProducto != null){
				toReturn.add(pedidoProducto);
			}
		}
		return toReturn;
	}

	@RequestMapping(value = "/{id}/borrar", method = RequestMethod.DELETE)
	public @ResponseBody boolean borrar(@PathVariable Integer id, HttpServletRequest request) {

		repository.delete(repository.findById(id));
			return true;
	}
	
	@RequestMapping(value = "/{id}/editar", method = RequestMethod.POST)
	public @ResponseBody PedidoProductos editar(@PathVariable Integer id, HttpServletRequest request,
			@RequestBody PedidoProductos pedidoProducto) {

		repository.save(pedidoProducto);
			return pedidoProducto;
	}
	
	@RequestMapping(value = "/pedido/{id}", method = RequestMethod.GET)
	public @ResponseBody List<PedidoProductos> findByPedido_id(@PathVariable Integer id, HttpServletRequest request) {

		List<PedidoProductos> listado = repository.findByPedido_id(id);
		for(int i = 0; i < listado.size(); i++){
			listado.get(i).setPedido(null);
		}
		return listado;
	}


}
