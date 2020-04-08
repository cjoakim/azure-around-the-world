package com.chrisjoakim.azure.atw.controllers.rest;

import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.chrisjoakim.azure.atw.AppConstants;
import com.chrisjoakim.azure.atw.ApplicationConfig;
import com.chrisjoakim.azure.atw.dao.CosmosSqlRepository;
import com.chrisjoakim.azure.atw.models.Journey;
import com.fasterxml.jackson.databind.ObjectMapper;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 *
 * @author Chris Joakim
 * @date   2020/04/07
 */

@RestController
@RequestMapping(path="/journey", produces="application/json")
@CrossOrigin(origins="*")
public class JourneyController implements AppConstants {
	
	private static long startEpoch = System.currentTimeMillis();
	private static long aliveRequestCount = 0;

	private static Logger logger = LoggerFactory.getLogger(JourneyController.class);

	@Autowired
	protected ApplicationConfig appConfig;
	
	@Autowired
	private CosmosSqlRepository cosmosSqlRepository;
	
	protected String resourceLocation = null;
	protected String resourceName = null;


	public JourneyController() {
		
		super();
	}

	@GetMapping("/getbyid/{id}/pk/{pk}")
	public ResponseEntity<Map<String,String>> getByIdAndPk(
			@PathVariable String id,
			@PathVariable String pk) {
		
		try {
			logger.warn("findByIdAndPk: " + pk);
			final Mono<Journey> resultsMono = cosmosSqlRepository.findByIdAndPk(id, pk);
			Journey journey = resultsMono.block();
			if (journey != null) {
				return new ResponseEntity(journey, HttpStatus.OK);
			}
			else {
				return new ResponseEntity(HttpStatus.NOT_FOUND);
			}

		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
		}
	}
	
	@GetMapping("/getbypk/{pk}")
	public ResponseEntity<Map<String,String>> getByPk(@PathVariable String pk) {
		
		try {
			logger.warn("getByPk: " + pk);
			final Flux<Journey> resultsFlux = cosmosSqlRepository.findByPk(pk);
			Mono<List<Journey>> resultsMono = resultsFlux.collectList();
			List<Journey> resultsList = resultsMono.block();
			logger.warn("getByPk results count: " + resultsList.size());
			return new ResponseEntity(resultsList, HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
		}
	}
	
	@GetMapping("/getbyelapsed/{ms}")
	public ResponseEntity<Map<String,String>> getByElapsedMs(@PathVariable long ms) {
		
		try {
			logger.warn("getByElapsedMs: " + ms);
			final Flux<Journey> resultsFlux = cosmosSqlRepository.findByElapsedMsLessThan(ms);
			Mono<List<Journey>> resultsMono = resultsFlux.collectList();
			List<Journey> resultsList = resultsMono.block();
			logger.warn("getByElapsedMs results count: " + resultsList.size());
			return new ResponseEntity(resultsList, HttpStatus.OK);
		}
		catch (Exception e) {
			e.printStackTrace();
			return new ResponseEntity<>(null, HttpStatus.SERVICE_UNAVAILABLE);
		}
	}
	
	@PostMapping(path = "/relay", consumes=MediaType.APPLICATION_JSON_VALUE, produces="application/json")
	public Journey postJourney(@RequestBody Journey journey) {
		
		journey.received(
			appConfig.getAzureResourceLocation(),
			appConfig.getAzureResourceName(),
			appConfig.getBuildUserString(),
			appConfig.getBuildDateString());
		
		if (journey.isRelay()) {
			persistPerPolicy(journey);
			if (journey.isCompleted()) {
				// we're done
			}
			else {
				relayJourney(journey);
			}
		}
		else {
			journey.addMessage("ping response");
			journey.setOriginFinishEpoch(System.currentTimeMillis());
			persistPerPolicy(journey);
		}
		
		if (journey.isVerbose()) {
			try {
				ObjectMapper mapper = new ObjectMapper();
				//String json = mapper.writeValueAsString(journey);
				String json = mapper.writerWithDefaultPrettyPrinter().writeValueAsString(journey);
				logger.error("journey json:\n" + json);
			}
			catch (Exception e) {
				e.printStackTrace();
			}
		}
		return journey;  // the journey POJO is serialized by String as JSON
	}
	
	@PostMapping(path = "/delete_all", consumes="application/json", produces="application/json")
	public Journey deleteAll(@RequestBody Journey journey) {
		
		journey.received(
				appConfig.getAzureResourceLocation(),
				appConfig.getAzureResourceName(),
				appConfig.getBuildUserString(),
				appConfig.getBuildDateString());
		try {
			if (Journey.FUNCTION_DELETE_ALL.equalsIgnoreCase(journey.getFunction())) {
				cosmosSqlRepository.deleteAll().block();
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return journey;
	}
	
	
	private void relayJourney(Journey journey) {
		
		logger.warn("relayJourney to " + journey.getNextUrl());
		HttpHeaders headers = new HttpHeaders();
		headers.setContentType(MediaType.APPLICATION_JSON);
		HttpEntity<Journey> entity = new HttpEntity<>(journey, headers);

		RestTemplate rest = new RestTemplate();
		//Journey respJourney = rest.postForObject(journey.getNextUrl(), journey, Journey.class);
		Journey respJourney = rest.postForObject(journey.getNextUrl(), entity, Journey.class);
		logger.warn("respJourney: " + respJourney.toString());
	}
	
	private void persistPerPolicy(Journey journey) {
		
		if (journey.shouldPersistNow()) {
			journey.setId(UUID.randomUUID().toString());
//			if (journey.getId() == null) {
//				journey.setId(UUID.randomUUID().toString());
//			}
			if (cosmosSqlRepository != null) {
				logger.warn("saving the Journey Document...");
				cosmosSqlRepository.save(journey);
				final Mono<Journey> saveMono = cosmosSqlRepository.save(journey);
				final Journey savedJourney = saveMono.block();
				logger.warn("savedJourney: " + savedJourney.toString());
			}
		}	
	}
	
//	public RestTemplate restTemplate() {
//		
//		return new RestTemplate();
//	}
	
}
