package com.sai.laps.helper;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import org.apache.log4j.Logger;

import com.sai.laps.helper.SAILogger;

public class RefTableManager implements Serializable {

	static Logger log = Logger.getLogger(RefTableManager.class);
	public static Map referenceData = new ConcurrentHashMap();
	public static Map referenceCBSDataNew = new ConcurrentHashMap();

	public static void initializeRefTableManager() throws Exception {
		try {
			ReferenceTableDAO rtDAO = new ReferenceTableDAO();
			referenceData = rtDAO.getAllReferenceData();
			referenceCBSDataNew = rtDAO.getAllReferenceCBSDataNew();
		} catch (Exception e) {
			log.error("Warning!!!Unable to initializeReferenceTableDataCaching->" + e.getMessage());
		}
	}

	/**
	 * @param fieldname
	 * @return ArrayList
	 * @throws Exception
	 */
	public static ArrayList getCodeAndDescription(String strStaticId,String strType) throws Exception {
		ArrayList arrStaticData = new ArrayList();
		try {
			if(strType.equalsIgnoreCase("STATIC"))
			{
				if (referenceData != null) {
					arrStaticData = (ArrayList) referenceData.get(strStaticId);
				}
			}
			else if(strType.equalsIgnoreCase("CBS"))
			{
				if (referenceCBSDataNew != null) {
					arrStaticData = (ArrayList) referenceCBSDataNew.get(strStaticId);
				}
			}

		} catch (Exception ce) {
			throw ce;
		}

		return arrStaticData;
	}
}