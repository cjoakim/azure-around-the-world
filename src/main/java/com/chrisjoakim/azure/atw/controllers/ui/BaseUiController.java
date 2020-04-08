package com.chrisjoakim.azure.atw.controllers.ui;

import java.io.IOException;
import java.io.InputStreamReader;
import java.io.Reader;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.Resource;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;

import com.chrisjoakim.azure.atw.ApplicationConfig;

/**
 * Base/Superclass Spring UI Controller.
 * 
 * @author Chris Joakim
 * @date   2019/12/15
 */

public class BaseUiController {

	Logger logger = LoggerFactory.getLogger(BaseUiController.class);

	@Autowired
	protected ApplicationConfig appConfig;
	
	public BaseUiController() {
		
		super();
	}
	
    protected void initializeModel(Model model) {
        
        model.addAttribute("appName",   appConfig.getAppName());
        model.addAttribute("htmlTitle", appConfig.getHtmlTitle());
        model.addAttribute("buildDate", appConfig.getBuildDateString());
        model.addAttribute("buildUser", appConfig.getBuildUserString());
    }
    
    public static String resourceAsString(Resource resource) {
    	
        try (Reader reader = new InputStreamReader(resource.getInputStream(), "UTF-8")) {
            return FileCopyUtils.copyToString(reader);
        }
        catch (IOException e) {
            return "";
        }
    }

}
