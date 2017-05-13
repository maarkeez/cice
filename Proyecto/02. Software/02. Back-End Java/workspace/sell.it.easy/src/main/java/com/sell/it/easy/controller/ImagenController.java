package com.sell.it.easy.controller;

import java.io.IOException;
import java.io.InputStream;

import javax.servlet.http.HttpServletRequest;

import org.apache.tomcat.util.http.fileupload.IOUtils;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping(value = "/imagen")
public class ImagenController {

//	@ResponseBody
//	@RequestMapping(value = "/{id}", method = RequestMethod.GET, produces = { MediaType.IMAGE_JPEG_VALUE,
//			MediaType.IMAGE_PNG_VALUE, MediaType.IMAGE_GIF_VALUE })
//	public  byte[] ( HttpServletRequest request) throws IOException {
//		InputStream in = this.getClass().getResourceAsStream("/static/images/");
//		return IOUtils;
//	}
//	
//	@ResponseBody
//	@RequestMapping(value = "/photo2", method = RequestMethod.GET, produces = MediaType.IMAGE_JPEG_VALUE)
//	public byte[] testphoto() throws IOException {
//	    InputStream in = this.getClass().getResourceAsStream("/images/no_image.jpg");
//	    return IOUtils.toByteArray(in);
//	}
}
