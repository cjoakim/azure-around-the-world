package com.chrisjoakim.azure.atw;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.context.event.ApplicationReadyEvent;
import org.springframework.context.event.EventListener;
import org.springframework.stereotype.Component;

/**
 * This @Component class logs Spring Boot application events.
 * 
 * @author Chris Joakim
 * @date   2020/01/02
 */

@Component
public class AppEvents {

    private static final Logger logger = LoggerFactory.getLogger(AppEvents.class);

	@Autowired
	protected ApplicationConfig appConfig;
	
    @EventListener(ApplicationReadyEvent.class)
    public void startApp() {

		StringBuffer sb = new StringBuffer();
		sb.append("ApplicationReadyEvent port: " + appConfig.getPort());
		sb.append(", buildDate: " + appConfig.getBuildDateString());
		sb.append(", buildUser: " + appConfig.getBuildUserString());
		sb.append(", loc: " + appConfig.getAzureResourceLocation());
		sb.append(", name: " + appConfig.getAzureResourceName());
		sb.append(", cosmosUri: " + appConfig.getCosmosSqlUri());
		logger.warn(sb.toString());
    }
}
