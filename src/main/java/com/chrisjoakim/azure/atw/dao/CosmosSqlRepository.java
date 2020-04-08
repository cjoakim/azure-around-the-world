package com.chrisjoakim.azure.atw.dao;

import org.springframework.stereotype.Repository;

import com.chrisjoakim.azure.atw.models.Journey;

import com.microsoft.azure.spring.data.cosmosdb.repository.ReactiveCosmosRepository;

import reactor.core.publisher.Flux;
import reactor.core.publisher.Mono;

/**
 * Instances of this class interact with CosmosDB/SQL via Spring Data, and not the native SDK.
 *  
 * A Flux is a stream which emits 0..n elements.
 * A Mono is a stream which emits 0..1 elements.
 * 
 * See https://www.baeldung.com/reactor-core
 * 
 * @author Chris Joakim
 * @date   2019/12/18
 */

@Repository
public interface CosmosSqlRepository extends ReactiveCosmosRepository<Journey, String> { 
	
	Flux<Journey> findByPk(String partitionKey);
	
	Mono<Journey> findByIdAndPk(String id, String partitionKey);
	
	Flux<Journey> findByOriginLocation(String originLocation);
	
	Flux<Journey> findByElapsedMsLessThan(long elapsedMs);
	
	// See https://docs.spring.io/spring-data/jpa/docs/1.5.0.RELEASE/reference/html/jpa.repositories.html#jpa.query-methods.at-query
}
