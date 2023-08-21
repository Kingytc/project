package com.sai.laps.logging;

import java.net.URL;
import java.util.Enumeration;
import java.util.Properties;

import org.apache.log4j.PropertyConfigurator;
import org.apache.log4j.xml.DOMConfigurator;

import com.sai.laps.helper.Helper;

/**
 * 
 * @author Arunkumar Subramaniam
 * 
 */
public class LoggerInit {
	public void initlize(String fileName) {
		//dispEnvProperties();
		if (!isJbossServer()) {
			//System.out.println("Log File  : "+fileName);
			try {
				if (!Helper.correctNull(fileName).equals("")) {
					if (fileName.endsWith(".xml")) {
						DOMConfigurator.configure(fileName);
					} else if (fileName.endsWith(".properties")) {
						PropertyConfigurator.configure(fileName);
					} else {
						defaultConfig();

					}
				} else {
					defaultConfig();
				}
			} catch (Exception e) {
				System.err.println("Logging Initilization Error"+ e.getMessage());
				e.printStackTrace();
			}
		}
	}

	private URL defaultConfig() {
		ClassLoader loader = Thread.currentThread().getContextClassLoader();
		URL resURL = loader.getResource("com/sai/laps/xml/log4j.xml");
		if (resURL != null) {
			//System.out.println("Loading Default Logger Config - "+ resURL.getFile());
			DOMConfigurator.configure(resURL);
		} else {
			//System.out.println("Default Logger Config file is NULL ");
		}
		return resURL;
	}
	
	private boolean isJbossServer() {
		if (Helper.correctNull(System.getProperty("jboss.home.dir")).equals("")) {
			return false;
		}
		return true;
	}
	// unit test
	public static void main(String[] args) {
		LoggerInit lapsLogger = new LoggerInit();
		lapsLogger.initlize("");
		
	}
    private void dispEnvProperties(){
    	Properties properties=	System.getProperties();
    	Enumeration enumeration=  properties.keys();
        while (enumeration.hasMoreElements()) {
			String object = (String) enumeration.nextElement();
			//System.out.println(object+"------->"+properties.get(object));
			
		}
    }
	
}
