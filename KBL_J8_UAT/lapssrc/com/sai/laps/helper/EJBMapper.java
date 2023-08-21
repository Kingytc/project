package com.sai.laps.helper;

import java.util.HashMap;

import org.apache.log4j.Logger;

public class EJBMapper
{
	private static HashMap mapPageBean = new HashMap();
	static Logger log = Logger.getLogger(EJBMapper.class);

	public static String getLookUp(String strPageID) throws Exception {
		String strJNDI = ""; String strVersionStage = "";
	    String[] strJNDIArr = { "", "" };
	    strVersionStage = Helper.correctNull(ApplicationParams.getVersionStage());
		try {
			if(!strPageID.equals(""))
			{if (!mapPageBean.containsKey(strPageID)) {
				log.error("No Matching JNDI Name Found For Specified PageID :");
				throw new Exception("No Matching JNDI Name Found For Specified PageID :");
			}
			//Changes for JBoss 7.1 Supports
			if (strVersionStage.equalsIgnoreCase("MAJOR"))
		    {
		        strJNDI = (String)mapPageBean.get(strPageID);
		        strJNDIArr = strJNDI.split(":");
		    }
		    else
		    {
		        strJNDI = (String)mapPageBean.get(strPageID);
		        strJNDIArr[0] = strJNDI;
		    }
			}
		} catch (NullPointerException ne) {
			log.error("Specified PageID does not Have a Mapping JNDI Name:"+ ne.getMessage());
			throw new Exception(
				"Specified PageID does not Have a Mapping JNDI Name:"
					+ ne.getMessage());
		} catch (Exception e) {
			log.error("Matching JNDI name Could Not be Found :" + e.getMessage());
			throw new Exception("Matching JNDI name Could Not be Found :" + e);
		}
		log.info("BEAN ID :: " + strPageID + " JNDI NAME  :: " + strJNDIArr[0] + " SERVICE ID :: " + strJNDIArr[1]);
		return strJNDI;
	}

	public static void initLookUp() {
		try {

			mapPageBean = GlobalXMLLoader.loadBeanMetaData();
		} catch (Exception e) {
			log.error(e.toString());

		}
	}
}
