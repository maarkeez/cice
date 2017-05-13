package com.utils;

import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class StringUtils {

	public StringUtils() {
	}

	public static String getStringFromObject(Object objeto) {

		String stringDeObjeto = objeto.getClass().getSimpleName();
		stringDeObjeto += "=[";
		// Recorrer los atributos declarados para el objeto filtro.
		// PRE: El nombre de los campos del request se corresponde con el nombre
		// de los atributos.
		// Si falla alguno, no se añade.

		for (Field f : objeto.getClass().getDeclaredFields()) {
			try {
				String fieldName = f.getName();
				stringDeObjeto += fieldName + ":";
				f.setAccessible(true);

				if (objeto != null) {
					if (f.getType() == java.util.Date.class) {
						SimpleDateFormat fechaFormato = new SimpleDateFormat("dd/MM/yyyy");
						Date fecha = (Date) f.get(objeto);
						String fechaString = fechaFormato.format(fecha);

						stringDeObjeto += fechaString;

					} else {

						stringDeObjeto += f.get(objeto);

					}
				} else {
					stringDeObjeto += "ElObjetoEs Null";
				}
			} catch (IllegalArgumentException e) {
				stringDeObjeto += "IllegalArgumentException";
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				stringDeObjeto += "IllegalAccessException";
				e.printStackTrace();
			}

			stringDeObjeto += ",";

		}

		stringDeObjeto += "]";
		return stringDeObjeto;
	}

}
