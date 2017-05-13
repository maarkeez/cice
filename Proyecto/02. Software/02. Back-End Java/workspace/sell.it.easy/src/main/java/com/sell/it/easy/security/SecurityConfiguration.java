package com.sell.it.easy.security;

import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;

@Configuration
@EnableGlobalMethodSecurity(securedEnabled = true)
public class SecurityConfiguration extends WebSecurityConfigurerAdapter {

	
	/**
	 * <b>Descripción</b>
	 * <p>
	 * Método creado para securizar las URLs de la aplicación.
	 * Configura el filtro de las URL que deben y no deben tener acceso sin iniciar sesión.
	 * Además se establecen las URL para la página de inicio de sesión, de cierre de sesión,
	 * de error por expiración de la sesión 
	 * </p>
	 * @param http
	 */
	@Override
	protected void configure(HttpSecurity http) throws Exception {
		
		//TODO: Securizar
		// Se permite acceso a la raíz para cualquier usuario sin autenticar
		http.authorizeRequests().anyRequest().permitAll();
		//Deshabilitar token de sesión
		http.csrf().disable();

		
	}
}
