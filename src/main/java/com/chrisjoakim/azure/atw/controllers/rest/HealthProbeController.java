package com.chrisjoakim.azure.atw.controllers.rest;

import java.util.HashMap;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.chrisjoakim.azure.atw.AppConstants;
import com.chrisjoakim.azure.atw.ApplicationConfig;

/**
 * Spring REST Controller intended for Kubernetes health checks, as it
 * implements the /health/ready and /health/alive GET endpoints.
 * 
 * curl "http://localhost:8080/health/ready"
 * curl "http://localhost:8080/health/alive"
 *
 * @author Chris Joakim
 * @date   2020/04/07
 */

@RestController
@RequestMapping(path="/health", produces="application/json")
@CrossOrigin(origins="*")
public class HealthProbeController implements AppConstants {

	private static long startEpoch = System.currentTimeMillis();
	private static long aliveRequestCount = 0;

	private static Logger logger = LoggerFactory.getLogger(HealthProbeController.class);

	@Autowired
	protected ApplicationConfig appConfig;


	public HealthProbeController() {
		
		super();
	}

	@GetMapping("/ready")
	public ResponseEntity<Map<String,String>> getReady() {
		HashMap<String, String> responseData = new HashMap<String, String>();
		
		try {
			responseData.put("status",        "ready");
			responseData.put("azureLocation",  appConfig.getAzureResourceLocation());
			responseData.put("azureName",      appConfig.getAzureResourceName());
			responseData.put("buildDate",      appConfig.getBuildDateString());
			responseData.put("buildUser",      appConfig.getBuildUserString());
			responseData.put("containerImage", appConfig.getContainerImage());
			responseData.put("currentEpoch",  "" + System.currentTimeMillis());
			return new ResponseEntity<>(responseData, HttpStatus.OK);
		}
		catch (Exception e) {
			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
		}
	}
	
	@PostMapping("/ready")
	public ResponseEntity<Map<String,String>> postReady() {
		HashMap<String, String> responseData = new HashMap<String, String>();
		
		return this.getReady();
	}
	
	@GetMapping("/alive")
	public ResponseEntity<Map<String,String>> alive() {
		HashMap<String, String> responseData = new HashMap<String, String>();
		
		try {
			aliveRequestCount++;
			long uptimeMs = System.currentTimeMillis() - startEpoch;
			double uptimeHours = (double) uptimeMs / (double) MS_PER_HOUR;
			Runtime runtime = Runtime.getRuntime();
			
			responseData.put("status", "alive");
			responseData.put("uptimeMs", "" + uptimeMs);
			responseData.put("uptimeHours", "" + uptimeHours);
			responseData.put("aliveRequestCount", "" + aliveRequestCount);
			responseData.put("threadName", Thread.currentThread().getName());
			responseData.put("threadId", "" + Thread.currentThread().getId());
			responseData.put("maxMemory", "" + runtime.maxMemory());
			responseData.put("totalMemory", "" + runtime.totalMemory());
			responseData.put("freeMemory", "" + runtime.freeMemory());
			return new ResponseEntity<>(responseData, HttpStatus.OK);
		}
		catch (Exception e) {
			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
		}
	}
	
//	@GetMapping("/env")
//	public ResponseEntity<Map<String, String>> azureEnvVars() {
//		HashMap<String, String> responseData = new HashMap<String, String>();
//
//		try {
//			Map<String, String> env = System.getenv();
//			Iterator iterator = env.keySet().iterator();
//			while (iterator.hasNext()) {
//				String key = (String) iterator.next();
//				boolean omit = false;
//				if ((key.contains("PASS")) || (key.contains("KEY")) || (key.contains("STRING"))) {
//					omit = true;
//				}
//				if (!omit) {
//					responseData.put(key, env.get(key));
//				}
//			}
//			return new ResponseEntity<>(responseData, HttpStatus.OK);
//		}
//		catch (Exception e) {
//			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
//		}
//	}
	
}
