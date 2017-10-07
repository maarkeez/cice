package com.sell.it.easy.controller;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

import com.sell.it.easy.entity.EstadisticasVenta;
import com.sell.it.easy.entity.PedidoProductos;
import com.sell.it.easy.entity.Usuario;
import com.sell.it.easy.entity.VentaFisica;
import com.sell.it.easy.repository.VentaFisicaRepository;

@RestController
@RequestMapping("/estadisticas/venta")
public class EstadisticasVentaController {

	@Autowired
	private VentaFisicaRepository ventaFisicaRepository;
	
	
	@RequestMapping(value = "/tienda/{idTienda}/desde/{fechaInicio}/hasta/{fechaFin}", method = RequestMethod.GET)
	public @ResponseBody EstadisticasVenta findByTiendaBetweenFechas(
			@PathVariable Integer idTienda,
			@PathVariable @DateTimeFormat(pattern = "dd-MM-yyyy HH:mm") Date fechaInicio,
			@PathVariable @DateTimeFormat(pattern = "dd-MM-yyyy HH:mm") Date fechaFin,
			HttpServletRequest request){
		
		//Variables locales
		EstadisticasVenta estadisticas = new EstadisticasVenta();
		Calendar calendario = new GregorianCalendar();
		Map<Integer,Double> dineroPorHora = new HashMap<Integer,Double>();
		Map<Integer,Object> dineroPorVendedor = new HashMap<Integer,Object>();
		Double dineroTotal = 0.0;
		
		//Datos
		List<VentaFisica> ventas = ventaFisicaRepository.findByPedido_Tienda_idAndFechaGreaterThanEqualAndFechaLessThanEqual(idTienda, fechaInicio, fechaFin);
				
		
		//Tratar los datos
		for(VentaFisica venta: ventas){
			
			// -----------------------------------
			// -- Dinero por hora
			// -----------------------------------
			//Recuperar la hora de la venta
			calendario.setTime(venta.getFecha());
			int hora = calendario.get(Calendar.HOUR_OF_DAY);
			
			
			Double dineroEnEstaHora = 0.0;
			Double dineroEnEstaVenta = getPVPVendido(venta);
			
			//Crear hora si no existe
			if (dineroPorHora.containsKey(hora) ){
				dineroEnEstaHora = dineroPorHora.get(hora);
			}
			//Actualizar hora
			dineroEnEstaHora += dineroEnEstaVenta;
			dineroPorHora.put(hora, dineroEnEstaHora);
			
			
			// -----------------------------------
			// -- Vendido por vendedor
			// -----------------------------------
			Usuario vendedor = venta.getVendedor();
			
			//Crear vendedor si no existe
			if (!dineroPorVendedor.containsKey(vendedor.getId())) {
				Map<String,Object> datosVendedor = new HashMap<String,Object>();
				
				String nombre = "";
				if(vendedor.getNombre() != null && !vendedor.getNombre().isEmpty()){
					nombre += vendedor.getNombre();
				}
				if(vendedor.getApellidos() != null && !vendedor.getApellidos().isEmpty()){
					nombre += " " + vendedor.getApellidos();
				}
				
				datosVendedor.put("nombre", nombre);
				datosVendedor.put("dinero", 0.0);
				dineroPorVendedor.put(vendedor.getId(), datosVendedor);
			}
			
			//Actualizar vendedor
			Map<String,Object> datosVendedor = (Map<String, Object>) dineroPorVendedor.get(vendedor.getId());
			Double dineroVendedor = (Double) datosVendedor.get("dinero");
			datosVendedor.put("dinero", dineroEnEstaVenta + dineroVendedor);
			dineroPorVendedor.put(vendedor.getId(), datosVendedor);
			 
			//Actualizar dinero total
			dineroTotal += dineroEnEstaVenta;

		}
		
		//Convertir los datos a la salida esperada.
		Set<Integer> horas = dineroPorHora.keySet();
		for(Integer hora: horas){
			//Recuperar datos
			Double dineroHora = dineroPorHora.get(hora);
			
			//Guardar en el objeto a devolver
			estadisticas.horas.add(hora);
			estadisticas.dineroHoras.add(dineroHora);	
		}
		
		Set<Integer> idVendedores = dineroPorVendedor.keySet();
		for(Integer idVendedor : idVendedores){
			//Recuperar datos
			Map<String,Object> datosVendedor = (Map<String, Object>) dineroPorVendedor.get(idVendedor);
			String nombre = (String) datosVendedor.get("nombre");
			Double dinero = (Double) datosVendedor.get("dinero");
			
			//Calcular porcentaje vendido sobre el total
			Double porcentajeVendido = ( dinero * 100 ) / dineroTotal;
			
			//Guardar en el objeto a devolver
			estadisticas.nombreVendedores.add(nombre);
			estadisticas.porcentajeVendedores.add(porcentajeVendido);
			
		}
		
		
		return estadisticas;
	}
	
	public Double getPVPVendido(VentaFisica venta){
		Double toReturn = 0.0;
		
		if(venta != null){
			for(PedidoProductos pedidoProducto : venta.getPedido().getProductos()){
				toReturn += pedidoProducto.getPrecioVentaPublico() * pedidoProducto.getCantidad();
			}
		}
		return toReturn;
	}
}