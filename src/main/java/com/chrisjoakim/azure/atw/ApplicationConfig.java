package com.chrisjoakim.azure.atw;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Component;

/**
 * Configuration class used throughout the application; gets its' values injected
 * from environment variables, application.properties, etc.
 * 
 * @author Chris Joakim
 * @date   2020/04/07
 */
@Component
public class ApplicationConfig implements AppConstants {

	private static Logger logger = LoggerFactory.getLogger(ApplicationConfig.class);

	// Instance variables; environment variable values are injected by Spring
	// Default values are specified after the optional colon in the @Value clause.
	
	@Value("${airports.csv.file}")
    private String airportsCsvFile;
	
	@Value("${app.name}")
    private String appName;
	
	@Value("${html.title}")
    private String htmlTitle;

	@Value("${AZURE_RESOURCE_LOC:}")
	private String azureResourceLocation;

	@Value("${AZURE_RESOURCE_NAME:}")
	private String azureResourceName;

	@Value("${AZURE_COSMOSDB_URI:}")
    private String cosmosSqlUri;
	
	@Value("${AZURE_COSMOSDB_KEY:}")
    private String cosmosSqlKey;
	
	@Value("${AZURE_COSMOSDB_DATABASE:}")
    private String cosmosSqlDbname;
	
	@Value("${CONTAINER_IMAGE:}")
    private String containerImage;

	@Value("${PORT:80}")
    private String port;
	
	@Value("${USER:}")
    private String user;
	
	@Value("classpath:build_date.txt")
	private Resource buildDate;
	
	@Value("classpath:build_user.txt")
	private Resource buildUser;
	
	// Getter methods
	
	public String getAirportsCsvFile() {
		return airportsCsvFile;
	}

	public void setAirportsCsvFile(String airportsCsvFile) {
		this.airportsCsvFile = airportsCsvFile;
	}
	
	public String getAppName() {
		return appName;
	}

	public void setAppName(String appName) {
		this.appName = appName;
	}

	public String getHtmlTitle() {
		return htmlTitle;
	}

	public void setHtmlTitle(String htmlTitle) {
		this.htmlTitle = htmlTitle;
	}

	public String getAzureResourceLocation() {
		return azureResourceLocation;
	}

	public void setAzureResourceLocation(String azureResourceLocation) {
		this.azureResourceLocation = azureResourceLocation;
	}

	public String getAzureResourceName() {
		return azureResourceName;
	}

	public void setAzureResourceName(String azureResourceName) {
		this.azureResourceName = azureResourceName;
	}

	public String getCosmosSqlUri() {
		return cosmosSqlUri;
	}

	public void setCosmosSqlUri(String cosmosSqlUri) {
		this.cosmosSqlUri = cosmosSqlUri;
	}

	public String getCosmosSqlKey() {
		return cosmosSqlKey;
	}

	public void setCosmosSqlKey(String cosmosSqlKey) {
		this.cosmosSqlKey = cosmosSqlKey;
	}

	public String getCosmosSqlDbname() {
		return cosmosSqlDbname;
	}

	public void setCosmosSqlDbname(String cosmosSqlDbname) {
		this.cosmosSqlDbname = cosmosSqlDbname;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}

	public String getUser() {
		return user;
	}

	public void setUser(String user) {
		this.user = user;
	}

	public Resource getBuildDate() {
		return buildDate;
	}
	
	public void setBuildDate(Resource buildDate) {
		this.buildDate = buildDate;
	}
	
	public String getBuildDateString() {
		return getResourceText(getBuildDate());
	}

	public Resource getBuildUser() {
		return buildUser;
	}

	public void setBuildUser(Resource buildUser) {
		this.buildUser = buildUser;
	}

	public String getBuildUserString() {
		return getResourceText(getBuildUser());
	}

	public String getContainerImage() {
		return containerImage;
	}

	public void setContainerImage(String containerImage) {
		this.containerImage = containerImage;
	}

	private String getResourceText(Resource r) {
		
		try {
			InputStream is = r.getInputStream();
			InputStreamReader sr = new InputStreamReader(is, StandardCharsets.UTF_8);
			BufferedReader reader = new BufferedReader(sr);
			String line = "";
			StringBuffer sb = new StringBuffer();
			while (line != null) {
				line = reader.readLine();
				if (line != null) {
					sb.append(line);
				}
			}
			return sb.toString().trim();
		}
		catch (Exception e) {
			e.printStackTrace();
			return "";
		}
	}
}
