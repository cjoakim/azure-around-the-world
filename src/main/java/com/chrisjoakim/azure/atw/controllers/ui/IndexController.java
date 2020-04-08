package com.chrisjoakim.azure.atw.controllers.ui;

import java.util.Arrays;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.core.io.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.chrisjoakim.azure.atw.ApplicationConfig;

/**
 * Spring Controller for UI with Thymeleaf templates.
 * 
 * @author Chris Joakim
 * @date   2019/12/15
 */
@Controller
public class IndexController extends BaseUiController {
	
	Logger logger = LoggerFactory.getLogger(IndexController.class);

	@Autowired
	protected ApplicationConfig appConfig;
	
	private List<String> links = null;
	
	@Value("classpath:marathons.csv")
	private Resource marathonsCsvResource;
	
	public IndexController() {
		
    	links = Arrays.asList(
    		"/actuator",
    		"/health/ready",
    		"/health/alive"); 
	}

    @GetMapping("/")
    public String index(
            @RequestParam(name="name", required=false, defaultValue="guest") 
			String name, Model model) {
    	
    	initializeModel(model);
        model.addAttribute("name", name);
        return "index";
    }
    
    // @GetMapping("/code")
    // public String code(Model model) {
    	
    // 	initializeModel(model);
    //     return "code";
    // }

}
