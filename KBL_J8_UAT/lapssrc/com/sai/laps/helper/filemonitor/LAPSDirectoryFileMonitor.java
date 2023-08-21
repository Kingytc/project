package com.sai.laps.helper.filemonitor;

import java.io.File;
import java.util.HashMap;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;
import com.sai.laps.helper.ApplicationParams;
import com.sai.laps.helper.ControllerServlet;
import com.sai.laps.helper.EJBMapper;
import com.sai.laps.helper.GlobalXMLLoader;
import com.sai.laps.helper.SQLParser;
import com.sai.laps.helper.SAILogger;

/**
 * @purpose:FOR MONITORING THE LAPS ARCHITECURAL FILES.(DIRECTORY BASED)
 * @since 24/11/2008
 * @author S.SATHYA MOORTHY
 * @description: SEPERATE MONITOR THREAD FOR EACH DIRECTORY.(SIGLE THREAD MODEL)
 * @description: Includes Timer,Linked List and basic file operations.
 */
public class LAPSDirectoryFileMonitor
{
	static Logger log=Logger.getLogger(LAPSDirectoryFileMonitor.class);
	public LAPSDirectoryFileMonitor()
	{
		
	}
	/**
	 * @author  :S.SATHYA MOORTHY
	 * @purpose :To Start the Monitoring.
	 * @since   :24/11/2008.
	 * @param directoryName
	 * @param intervalSeconds
	 * @return boolean
	 */
	public boolean startMonitor(String directoryName,int intervalSeconds)
	{
		boolean bool=false;
		try
		{
		log.info("STARTING THE LAPS FILE AND DIRECTORY MONITOR...");
		  DirectoryWatcher dw = new DirectoryWatcher(directoryName, intervalSeconds);
	      dw.addListener(new FileListener());
	      dw.start();
	      bool=true;
	   log.info("** LAPS FILE AND DIRECTORY MONITOR HAS BEEN STARTED SUCCESSFULLY **");   
		}
		catch(Exception e)
		{
			bool=false;
			e.printStackTrace();
		}
		return bool;
	}
	
	/**
	 * @author S.SATHYA MOORTHY
	 * @purpose TO RELOAD THE SETTINGS.
	 * @since :25/11/2008
	 * @param strFlag
	 * @param strFilePath
	 * @param strDirectory
	 * @param strFileName
	 */
	public static void reloadLAPSSettings(String strFlag ,String strFilePath,String strDirectory,String strFileName)
	{
		
		try
		{
			if(strFlag.equals("1"))
			{
				SQLParser.buildDocument();
			}
			if(strFlag.equals("2"))
			{
				SQLParser.buildDocument();
			}
			if(strFlag.equals("3"))
			{
				ControllerServlet.mapPageBean.clear();
				ControllerServlet.mapPageBean = GlobalXMLLoader.loadPageAndServiceMappings();
				log.info("JSP MAPPINGS LOADED FROM jspmaps.xml :"+ControllerServlet.mapPageBean.size());
			}
			if(strFlag.equals("4"))
			{
				ControllerServlet.mapPDF.clear();
				ControllerServlet.mapPDF=GlobalXMLLoader.getPDFDetails(strDirectory,"\\"+ strFileName);
			}
			if(strFlag.equals("5"))
			{
				EJBMapper.initLookUp();
			}
			if(strFlag.equals("6"))
			{
				
		    	 // Logger.log("Cannot Load the LAPSProperties.xml \n To realize the changes plz restart the server !");
					//ApplicationParams.initializeProperties(GlobalXMLLoader.getApplicationProperties(strDirectory+"\\", strFileName),
					//	appHome,lapsHome, lapsHomePath, propsFilePath, File.separatorChar);
		    	  String appHome =System.getProperty("jboss.home.dir");
		    	  if(appHome==null)appHome=System.getProperty("app.home.dir");
		    	  if(appHome==null)appHome=System.getProperty("user.dir");
		    	  String lapsHomePath = appHome + File.separatorChar + "lapshome";
					String propsFilePath = lapsHomePath + File.separatorChar + "lapsconfig"+ File.separatorChar;
					HashMap appProperties = GlobalXMLLoader.getApplicationProperties(propsFilePath, "LAPSProperties.xml");
					ApplicationParams.initializeProperties(appProperties, appHome,"lapshome", lapsHomePath, propsFilePath, File.separatorChar);
					log.info("APPLICATION PROPERTIES LOADED SUCCESSFULLY FROM LAPSProperties.xml");
					log.info("LOADED PROPERTIES ARE :"+appProperties);
			}
			
			
		}
		catch(Exception e)
		{
			e.printStackTrace();
		}
		finally
		{
			strFlag=null;
			strFilePath=null;
			strDirectory=null;
			strFileName=null;
			System.runFinalization();
			System.gc();
		}
			
		
	}
	
	
}
