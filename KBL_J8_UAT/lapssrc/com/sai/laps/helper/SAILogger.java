package com.sai.laps.helper;

import org.apache.log4j.Logger;

import com.sai.fw.management.log.LogWriter;



/**
 *@author : S.SATHYA MOORTHY
 *@date   :Mar 13, 2009 :2:51:41 PM
 *@purpose:LOG DISPATCHING
 *@description :Logger
 *@todo :dispatch the log as per the requirement.
 */
public class SAILogger extends LogWriter{
	static Logger log=Logger.getLogger(SAILogger.class);	

	public SAILogger() {
	super();
	// TODO Auto-generated constructor stub
	}
	
	
	public static void log(Throwable e) {
		log.info(e.getMessage());
		
	}
	public static void log(String e) {
		log.info(e);
	}
	public static void shutdown() {
		
	}
	
	
	
}