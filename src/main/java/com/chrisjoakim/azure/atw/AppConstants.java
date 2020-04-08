package com.chrisjoakim.azure.atw;

/**
 * This interface defines constant values used in this application.
 * 
 * @author Chris Joakim
 * @date   2020/04/07
 */
public interface AppConstants {
	
	public static final String AZURE_RESOURCE_LOC      = "AZURE_RESOURCE_LOC";
	public static final String AZURE_COSMOSDB_URI      = "AZURE_COSMOSDB_URI";
	public static final String AZURE_COSMOSDB_KEY      = "AZURE_COSMOSDB_KEY";
	public static final String AZURE_COSMOSDB_DATABASE = "AZURE_COSMOSDB_DATABASE";
	public static final String CONTAINER_IMAGE         = "CONTAINER_IMAGE";

	public static final long   MS_PER_MINUTE           = 1000 * 60; 
	public static final long   MS_PER_HOUR             = 1000 * 60 * 60; 
}
