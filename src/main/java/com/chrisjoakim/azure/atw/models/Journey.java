package com.chrisjoakim.azure.atw.models;

import java.time.ZonedDateTime;
import java.util.ArrayList;
import java.util.UUID;

import org.springframework.data.annotation.Id;

import com.microsoft.azure.spring.data.cosmosdb.core.mapping.Document;
import com.microsoft.azure.spring.data.cosmosdb.core.mapping.PartitionKey;

/**
 * Instances of this POJO and JPA/CosmosDB @Document class represent a
 * "journey" of HTTP data POSTed around the planet by this application.
 * 
 * @author Chris Joakim
 * @date   2020/03/16
 */

@Document(collection = "atw_journeys")
public class Journey {
	
	// Constants:
	public static final String FUNCTION_RELAY       = "relay";
	public static final String FUNCTION_PING        = "ping";
	public static final String FUNCTION_DELETE_ALL  = "delete_all";
	public static final String PERSIST_POLICY_NONE  = "none";
	public static final String PERSIST_POLICY_ALL   = "all";
	public static final String PERSIST_POLICY_FINAL = "final";
	
	// Instance variables:
	
	@Id
	public String  id;
	
	@PartitionKey
	public String  pk;

	public String  function;
	public String  originLocation;
	public String  originResourceName;
	public long    originStartEpoch;
	public long    originFinishEpoch;
	public long    elapsedMs;
	public String  currentLocation;
	public String  currentResourceName;
	public int     currentRouteIndex;
	public String  nextUrl;
	public boolean verbose;
	public String  persistPolicy;
	public ArrayList<String> route;
	public ArrayList<String> messages;
	
	public Journey() {
		
		super();
		route    = new ArrayList<String>();
		messages = new ArrayList<String>();
	}

	public void received(String resourceLoc, String resourceName, String buildUser, String buildDate) {
		
		incrementRoute();
		setCurrentLocation(resourceLoc);
		setCurrentResourceName(resourceName);
		addMessage("---");
		StringBuffer sb = new StringBuffer();
		sb.append("received @ " + currentLocation);
		sb.append(" resource: " + currentResourceName);
		sb.append(" routeIndex: " + currentRouteIndex);
		sb.append(" buildUser: " + buildUser);
		sb.append(" buildDate: " + buildDate);
		addMessage(sb.toString());
		
		if (getCurrentRouteIndex() == 0) {
			setOriginLocation(resourceLoc);
			setOriginResourceName(resourceName);
			setOriginStartEpoch(System.currentTimeMillis());
			determineNextUrl();
			addMessage("journey starting -> " + getNextUrl());
		}
		else {
			if (isCompleted()) {
				setOriginFinishEpoch(System.currentTimeMillis());
				setElapsedMs(getOriginFinishEpoch() - getOriginStartEpoch()); 
				addMessage("journey finished, elapsedMs " + getElapsedMs());
			}
			else {
				determineNextUrl();
				addMessage("journey continuing -> " + getNextUrl());
			}
		} 
	}
	
	private void incrementRoute() {
		
		currentRouteIndex++;	
	}
	
	private void determineNextUrl() {
		
		if (isRelay()) {
			try {
				setNextUrl(getRoute().get(getCurrentRouteIndex()));
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		else {
			setNextUrl("N/A");
		}
	}
	
	public boolean isRelay() {
		
		return FUNCTION_RELAY.equalsIgnoreCase(getFunction());
	}
	
	public boolean isCompleted() {
		
		if (getCurrentRouteIndex() < getRoute().size()) {
			return false;
		}
		else {
			return true;
		}	
	}
	
	public boolean shouldPersistNow() {
		
		if (PERSIST_POLICY_ALL.equalsIgnoreCase(getPersistPolicy())) {
			addMessage("shouldPersistNow -> true -> PERSIST_POLICY_ALL");
			return true;
		}
		if (isCompleted()) {
			if (PERSIST_POLICY_FINAL.equalsIgnoreCase(getPersistPolicy())) {
				addMessage("shouldPersistNow -> true -> PERSIST_POLICY_FINAL");
				return true;
			}			
		}
		addMessage("shouldPersistNow -> false");
		return false;		
	}
	
	public void addMessage(String msg) {
		
		ZonedDateTime zdt = ZonedDateTime.now();
		this.messages.add(zdt.toString() + ": " + msg);
	}

	
	// generated getters and setters below
	

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPk() {
		return pk;
	}

	public void setPk(String pk) {
		this.pk = pk;
	}

	public String getFunction() {
		return function;
	}

	public void setFunction(String function) {
		this.function = function;
	}

	public String getOriginLocation() {
		return originLocation;
	}

	public void setOriginLocation(String originLocation) {
		this.originLocation = originLocation;
	}

	public String getOriginResourceName() {
		return originResourceName;
	}

	public void setOriginResourceName(String originResourceName) {
		this.originResourceName = originResourceName;
	}

	public long getOriginStartEpoch() {
		return originStartEpoch;
	}

	public void setOriginStartEpoch(long originStartEpoch) {
		this.originStartEpoch = originStartEpoch;
	}

	public long getOriginFinishEpoch() {
		return originFinishEpoch;
	}

	public void setOriginFinishEpoch(long originFinishEpoch) {
		this.originFinishEpoch = originFinishEpoch;
	}

	public long getElapsedMs() {
		return elapsedMs;
	}

	public void setElapsedMs(long elapsedMs) {
		this.elapsedMs = elapsedMs;
	}

	public String getCurrentLocation() {
		return currentLocation;
	}

	public void setCurrentLocation(String currentLocation) {
		this.currentLocation = currentLocation;
	}

	public String getCurrentResourceName() {
		return currentResourceName;
	}

	public void setCurrentResourceName(String currentResourceName) {
		this.currentResourceName = currentResourceName;
	}

	public int getCurrentRouteIndex() {
		return currentRouteIndex;
	}

	public void setCurrentRouteIndex(int currentRouteIndex) {
		this.currentRouteIndex = currentRouteIndex;
	}

	public String getNextUrl() {
		return nextUrl;
	}

	public void setNextUrl(String nextUrl) {
		this.nextUrl = nextUrl;
	}

	public boolean isVerbose() {
		return verbose;
	}

	public void setVerbose(boolean verbose) {
		this.verbose = verbose;
	}

	public String getPersistPolicy() {
		return persistPolicy;
	}

	public void setPersistPolicy(String persistPolicy) {
		this.persistPolicy = persistPolicy;
	}

	public ArrayList<String> getRoute() {
		return route;
	}

	public void setRoute(ArrayList<String> route) {
		this.route = route;
	}

	public ArrayList<String> getMessages() {
		return messages;
	}

	public void setMessages(ArrayList<String> messages) {
		this.messages = messages;
	}

}	
	
