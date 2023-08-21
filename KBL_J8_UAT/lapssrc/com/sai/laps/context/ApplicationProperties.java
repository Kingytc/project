/*
 * Created on Dec 10, 2004
 *
 *
 */
package com.sai.laps.context;

import java.util.HashMap;

import com.sai.fw.context.ApplicationContext;
import com.sai.fw.management.utils.FwHelper;

/**
 * @author Ram This class defines the application specific context parameters
 *         that needs to be initialized
 *  
 */
public class ApplicationProperties extends ApplicationContext {

    /**
	 * 
	 */
	private static final long serialVersionUID = 1L;

    //private static String strZipName = "";

    private static String strOffLineDataSource = "";

    private static String strOffLineDatabaseType = "";

    private static String strOffLineSqlfile[] = null;

    private static String strOffLineURL = "";

    private static String strCreditBureau[] = null;

    private static String strDocumentInterface[] = null;

    private static String strLAPSImplementation = "";

    public static void initialize(HashMap appContextMap) 
    {
       
        /*if (appContextMap.get("ZIPNAME") != null) {
            setZipName((String) appContextMap.get("ZIPNAME"));
        }*/
       
        if (appContextMap.get("OFFLINECOMMONDBTYPE") != null) {
            setOfflineDatabaseType((String) appContextMap.get("OFFLINECOMMONDBTYPE"));
        }
       
        if (appContextMap.get("OFFLINESQLFILE") != null) {
            setOfflineSQLQueriesFile(FwHelper.getStringArrayFromTokeinzedString(FwHelper.correctNull(
                    (String) appContextMap.get("OFFLINESQLFILE")).trim(), ","));
        }
        
        if (appContextMap.get("OFFLINEDATASOURCE") != null) {
            setOfflineDataSource((String) appContextMap.get("OFFLINEDATASOURCE"));
        }
        if (appContextMap.get("OFFLINEURL") != null) {
            setOfflineURL((String) appContextMap.get("OFFLINEURL"));
        }

        if (appContextMap.get("CREDITBUREAU") != null) {
            setInstalledCreditBureauInterface(FwHelper.getStringArrayFromTokeinzedString(FwHelper.correctNull(
                    (String) appContextMap.get("CREDITBUREAU")).trim(), ","));
        }

        if (appContextMap.get("DOCUMENTATIONINTERFACE") != null) {
            setInstalledDocumentationInterface(FwHelper.getStringArrayFromTokeinzedString(FwHelper.correctNull(
                    (String) appContextMap.get("DOCUMENTATIONINTERFACE")).trim(), ","));
        }

    }

    /*private static void setZipName(String aZipName) {
        strZipName = aZipName;
    }*/

    private static void setOfflineDatabaseType(String aOffLineCommonDBType) {
        strOffLineDatabaseType = aOffLineCommonDBType;
    }

    private static void setOfflineSQLQueriesFile(String[] aOffLineSQLFile) {
        strOffLineSqlfile = aOffLineSQLFile;
    }

    private static void setOfflineDataSource(String aOffLineDS) {
        strOffLineDataSource = aOffLineDS;
    }

    private static void setOfflineURL(String aOffLineURL) {
        strOffLineURL = aOffLineURL;
    }

	

    public static String getOffLineDataSource() {
        return strOffLineDataSource;
    }

    public static String getOfflineDatabaseType() {
        return strOffLineDatabaseType;
    }

    public static String[] getOfflineSQLQueriesFile() {
        return strOffLineSqlfile;
    }

    public static String getOfflineURL() {
        return strOffLineURL;
    }

    public static String[] getInstalledCreditBureauInterface() {
        return strCreditBureau;
    }

    private static void setInstalledCreditBureauInterface(String aInstalledCreditBureau[]) {
        strCreditBureau = aInstalledCreditBureau;
    }

    public static String[] getInstalledDocumentationInterface() {
        return strDocumentInterface;
    }

    private static void setInstalledDocumentationInterface(String[] aInstalledDocumentationInterface) {
        strDocumentInterface = aInstalledDocumentationInterface;
    }
    public static String getLAPSImplementation() {
        return strLAPSImplementation;
    }
    
}