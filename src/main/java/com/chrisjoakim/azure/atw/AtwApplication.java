package com.chrisjoakim.azure.atw;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;


/**
 * This is the entry point for this Spring Boot application.
 * 
 * @author Chris Joakim
 * @date   2020/01/02
 */

@SpringBootApplication
public class AtwApplication {

	public static void main(String[] args) {

		SpringApplication app = new SpringApplication(AtwApplication.class);
		//app.setBannerMode(Banner.Mode.OFF);
		app.run(args);
	}

}
