package com.sai.laps.helper;

import org.apache.log4j.Logger;

public class MISLogger {
	
	static Logger log=Logger.getLogger(MISLogger.class);
	
	public static void UpdateLogger(String strValue)
	{
		log.debug(strValue);
	}

}
