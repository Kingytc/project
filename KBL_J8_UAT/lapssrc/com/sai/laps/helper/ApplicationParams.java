package com.sai.laps.helper;

import java.util.HashMap;

import org.apache.log4j.Logger;

public class ApplicationParams
{
	static Logger log=Logger.getLogger(ApplicationParams.class);
	private static String strxmlfilepath = "";
	private static String strxmlfactory = "";
	private static String strinitialcontext = "";
	private static String strproviderurl = "";
	private static String strJndiPath = "";
	private static String strdatasource = "";
	private static String strappurl = "";
	private static String strcurrency = "";
	private static String strIP = "";
	private static String strZipName = "";
	private static String strZipValue = "";
	private static String strFtpPath = "";

	private static String strJspMAPSFile = "";
	private static String strBeanMAPSFile = "";
	private static String strSQLQueriesFile = "";
	private static String strDatabaseType = "";

	private static String strLapsVersion = "";
	private static String strFolder = "";
	private static String strFolder1 = "";
	private static String strTertiarycma = "";
	private static String strOPSCMAWOADV = "";

	private static String strIRBURL = "";
	private static String strSQLDBS2QUERYFILE = "";// this variable holds the files for the second data base
	private static String strDataSource2 = "";
	private static String strCIBILREPORT = "";

	private static String strcibilFolder = "";
	private static String strRequestPath = "";
	private static String strFileListener = "";
	private static String strdatasource3 = "";

	private static String stronlineenabled = "";

	private static String strCCPSSQLQueriesFile = "";

	private static String strAuditTrail = "";
	private static String strOnlineExcel = "";
	private static String strFlatfileFormat = "";
	private static String strImageEnabled = "";// This variable holds whether the images to be enabled in pages or not

	private static String strCBSSQLQueriesFile = "";
	private static String strCbsIntegration = "";
	private static String strcbsfcrdatasource = "";

	private static String strKalyptoConnection = "";
	private static String strKalyptoDataSource = "";
	private static String strKalyptowebservice = "";
	private static String strRatingSoadAddress = "";
	public static String strOnlineIp = "";
	private static String strNsdlConnector ="";
	
	private static String strNSDLResponseFilePath="";
	private static String strORACLEDBURL="";
	private static String strdoclocation = "";
	
	private static String strAadharkey = "";
	private static String strAadharvector = "";
	private static String finacialloaction;
	
	private static String strSMSURL = "";
	private static String strSMSDCode = "";
	private static String strSMSUserID = "";
	private static String strSMSPassword = "";
	private static String strSMSSender = "";
	private static String strSMSTypeFlag = "";
	private static String SMSFlag = "";
	private static String MONITORINGDBENABLED = "";
	private static String strCIBILPATH = "";
	private static String strCIBILRENEW = "";
	private static String strdatasource4="";
	private static String strNSDLSchStatus = "";
	private static String strCBSIDCreation = "";
	private static String strCBSIDModification = "";
	private static String strCUSTIDVerification = "";
	private static String strCUSTIDPANModification = "";
	private static String strUploadFileToServer = "";
	private static String strReadTableFromServer = "";
	private static String strPushDocumentService = "";
	private static String strLoanAccountOpening = "";
	private static String strAuthValue="";
	private static String strLoanAccountCreation="";
	private static String strRetailTCEffectDate="";
	private static String strLMSDatasource="";
	private static String strLMSConnection="";
	private static String strFinacleURL="";
	private static String strdmsurl="";
	private static String strbreurl="";
	private static String strdmsloginurl="";
	private static String strhunterurl="";
	private static String strcalceligibilityurl=""; 
	private static String strapicredential="";
	private static String strappdedupe="";
	private static String strCIBILReportPath = "";
	private static String stramberrule="";
	private static String stramberauthvalue="";
	private static String strInprincipleUrl="";
	private static String strInprincipleAuthValue="";
	private static String strroiupdurl="";
	private static String strroipaupdurl="";
	
	private static String strPRIVATEKEYFILE="";
	private static String strPUBLICKEYFILE="";
	private static String strCLPCdate="";

	private static String strPostSancEnabDisablelivedate="";
	private static String strCLPHdate="";


	private static String strroiBQLupdurl="";
	//gen	
	private static String strlogintoibm="";
	private static String strlogintoibmPass="";
	//gen
	//digi
	private static String strlogintoibmdigi="";
	private static String strlogintoibmPassdigi="";
	//digi
	private static String StrBQLAuthValue="";
	private static String VersionStage="";
	
	private static String strKblUserSac="";
	

	private static String SCHSECURITYFLAG="";
	private static String SCHSECURITYDAYS="";
	private static String SCHSECURITYHOURS="";
	private static String SCHSECURITYMINS="";
	
	private static String SHGFILE_RESDOWNLOAD="";
	public static String getSHGFILE_RESDOWNLOAD() {
		return SHGFILE_RESDOWNLOAD;
	}

	public static void setSHGFILE_RESDOWNLOAD(String sHGFILE_RESDOWNLOAD) {
		SHGFILE_RESDOWNLOAD = sHGFILE_RESDOWNLOAD;
	}

	public static String getStrKblUserSac() {
		return strKblUserSac;
	}

	public static void setStrKblUserSac(String strKblUserSac) {
		ApplicationParams.strKblUserSac = strKblUserSac;
	}

	public static String getStrPostSancationEncryptionFile() {
		return strPostSancationEncryptionFile;
	}

	public static void setStrPostSancationEncryptionFile(String strPostSancationEncryptionFile) {
		ApplicationParams.strPostSancationEncryptionFile = strPostSancationEncryptionFile;
	}

	private static String strPostSancationEncryptionFile="";
	
	
	public static String getVersionStage() {
		return VersionStage;
	}

	public static void setVersionStage(String versionStage) {
		VersionStage = versionStage;
	}

	public static String getStrCLPHdate() {
		return strCLPHdate;
	}

	public static void setStrCLPHdate(String strCLPHdate) {
		ApplicationParams.strCLPHdate = strCLPHdate;
	}

	private static String strPostSancationEncryptionURL="";
	public static String getStrPostSancationEncryptionURL() {
		return strPostSancationEncryptionURL;
	}

	public static void setStrPostSancationEncryptionURL(String strPostSancationEncryptionURL) {
		ApplicationParams.strPostSancationEncryptionURL = strPostSancationEncryptionURL;
	}

	private static String strPostSancationDecryptionFile="";
	
	public static String getStrPostSancationDecryptionFile() {
		return strPostSancationDecryptionFile;
	}

	public static void setStrPostSancationDecryptionFile(String strPostSancationDecryptionFile) {
		ApplicationParams.strPostSancationDecryptionFile = strPostSancationDecryptionFile;
	}

	
	private static String strPostSancationTokenFile="";
	public static String getStrPostSancationTokenFile() {
		return strPostSancationTokenFile;
	}

	public static void setStrPostSancationTokenFile(String strPostSancationTokenFile) {
		ApplicationParams.strPostSancationTokenFile = strPostSancationTokenFile;
	}

	
	private static String StrPostSanctionNURL="";
	
	private static String StrPostSanctionTokenURL="";
	
	public static String getStrPostSanctionTokenURL() {
		return StrPostSanctionTokenURL;
	}

	public static void setStrPostSanctionTokenURL(String strPostSanctionTokenURL) {
		StrPostSanctionTokenURL = strPostSanctionTokenURL;
	}

	public static String getStrPostSanctionNURL() {
		return StrPostSanctionNURL;
	}

	public static void setStrPostSanctionNURL(String strPostSanctionNURL) {
		StrPostSanctionNURL = strPostSanctionNURL;
	}

	
	private static String StrPostSanctionNURL2="";
	
	
	

	public static String getStrPostSanctionNURL2() {
		return StrPostSanctionNURL2;
	}

	public static void setStrPostSanctionNURL2(String strPostSanctionNURL2) {
		StrPostSanctionNURL2 = strPostSanctionNURL2;
	}

	private static String strroiMSMEupdurl="";
	private static String strUCICdatasource = "";
	private static String strENACHURL = "";
	private static String strgenDocupdurl = "";
	//digi-dms
	private static String strgenDocupdurldigi ="";
	//digi-dms
	private static String strgenDocupdun = "";
	private static String strgenDocupdpd = "";
	private static String strIbmUN = "";

	private static String StrBULKHANDOFFLAPSTIME="";
	
	private static String StrPostSanctionURLEnc1="";
	public static String getStrPostSanctionURLEnc1() {
		return StrPostSanctionURLEnc1;
	}

	public static void setStrPostSanctionURLEnc1(String strPostSanctionURLEnc1) {
		StrPostSanctionURLEnc1 = strPostSanctionURLEnc1;
	}

	public static String getStrPostSanctionURLEnc2() {
		return StrPostSanctionURLEnc2;
	}

	public static void setStrPostSanctionURLEnc2(String strPostSanctionURLEnc2) {
		StrPostSanctionURLEnc2 = strPostSanctionURLEnc2;
	}

	private static String StrPostSanctionURLEnc2="";
	private static String strSMSDCode1="";
	public static String getStrSMSDCode1() {
		return strSMSDCode1;
	}

	public static void setStrSMSDCode1(String strSMSDCode1) {
		ApplicationParams.strSMSDCode1 = strSMSDCode1;
	}

	public static String getStrSMSDCode2() {
		return strSMSDCode2;
	}

	public static void setStrSMSDCode2(String strSMSDCode2) {
		ApplicationParams.strSMSDCode2 = strSMSDCode2;
	}

	public static String getStrSMSDCode3() {
		return strSMSDCode3;
	}

	public static void setStrSMSDCode3(String strSMSDCode3) {
		ApplicationParams.strSMSDCode3 = strSMSDCode3;
	}

	public static String getStrSMSDCode4() {
		return strSMSDCode4;
	}

	public static void setStrSMSDCode4(String strSMSDCode4) {
		ApplicationParams.strSMSDCode4 = strSMSDCode4;
	}

	public static String getStrSMSDCode5() {
		return strSMSDCode5;
	}

	public static void setStrSMSDCode5(String strSMSDCode5) {
		ApplicationParams.strSMSDCode5 = strSMSDCode5;
	}

	private static String strSMSDCode2="";
	private static String strSMSDCode3="";
	private static String strSMSDCode4="";
	private static String strSMSDCode5="";
	
	
	
	
	public static String getStrInprincipleUrl() {
		return strInprincipleUrl;
	}

	public static void setStrInprincipleUrl(String strInprincipleUrl) {
		ApplicationParams.strInprincipleUrl = strInprincipleUrl;
	}

	public static String getStrInprincipleAuthValue() {
		return strInprincipleAuthValue;
	}

	public static void setStrInprincipleAuthValue(String strInprincipleAuthValue) {
		ApplicationParams.strInprincipleAuthValue = strInprincipleAuthValue;
	}

	public static String getStramberauthvalue() {
		return stramberauthvalue;
	}

	public static void setStramberauthvalue(String stramberauthvalue) {
		ApplicationParams.stramberauthvalue = stramberauthvalue;
	}

	public static String getStramberrule() {
		return stramberrule;
	}

	public static void setStramberrule(String stramberrule) {
		ApplicationParams.stramberrule = stramberrule;
	}

	public static String getStrappdedupe() {
		return strappdedupe;
	}

	public static void setStrappdedupe(String strappdedupe) {
		ApplicationParams.strappdedupe = strappdedupe;
	}

	public static String getStrcalceligibilityurl() {
		return strcalceligibilityurl;
	}

	public static void setStrcalceligibilityurl(String strcalceligibilityurl) {
		ApplicationParams.strcalceligibilityurl = strcalceligibilityurl;
	}

	public static String getStrhunterurl() {
		return strhunterurl;
	}

	public static void setStrhunterurl(String strhunterurl) {
		ApplicationParams.strhunterurl = strhunterurl;
	}

	public static String getStrdmsloginurl() {
		return strdmsloginurl;
	}

	public static void setStrdmsloginurl(String strdmsloginurl) {
		ApplicationParams.strdmsloginurl = strdmsloginurl;
	}

	public static String getStrbreurl() {
		return strbreurl;
	}

	public static void setStrbreurl(String strbreurl) {
		ApplicationParams.strbreurl = strbreurl;
	}

	public static String getStrdmsurl() {
		return strdmsurl;
	}

	public static void setStrdmsurl(String strdmsurl) {
		ApplicationParams.strdmsurl = strdmsurl;
	}

	public static String getStrLMSConnection() {
		return strLMSConnection;
	}

	public static void setStrLMSConnection(String strLMSConnection) {
		ApplicationParams.strLMSConnection = strLMSConnection;
	}

	public static String getStrLoanAccountCreation() {
		return strLoanAccountCreation;
	}

	public static void setStrLoanAccountCreation(String strLoanAccountCreation) {
		ApplicationParams.strLoanAccountCreation = strLoanAccountCreation;
	}

	public static String getStrAuthValue() {
		return strAuthValue;
	}

	public static void setStrAuthValue(String strAuthValue) {
		ApplicationParams.strAuthValue = strAuthValue;
	}

	public static String getStrLoanAccountOpening() {
		return strLoanAccountOpening;
	}

	public static void setStrLoanAccountOpening(String strLoanAccountOpening) {
		ApplicationParams.strLoanAccountOpening = strLoanAccountOpening;
	}

	public static String getStrUploadFileToServer() {
		return strUploadFileToServer;
	}

	public static void setStrUploadFileToServer(String strUploadFileToServer) {
		ApplicationParams.strUploadFileToServer = strUploadFileToServer;
	}

	public static String getStrReadTableFromServer() {
		return strReadTableFromServer;
	}

	public static void setStrReadTableFromServer(String strReadTableFromServer) {
		ApplicationParams.strReadTableFromServer = strReadTableFromServer;
	}

	public static String getStrPushDocumentService() {
		return strPushDocumentService;
	}

	public static void setStrPushDocumentService(String strPushDocumentService) {
		ApplicationParams.strPushDocumentService = strPushDocumentService;
	}

	public static String getStrCUSTIDPANModification() {
		return strCUSTIDPANModification;
	}

	public static void setStrCUSTIDPANModification(String strCUSTIDPANModification) {
		ApplicationParams.strCUSTIDPANModification = strCUSTIDPANModification;
	}

	public static String getStrCUSTIDVerification() {
		return strCUSTIDVerification;
	}

	public static void setStrCUSTIDVerification(String strCUSTIDVerification) {
		ApplicationParams.strCUSTIDVerification = strCUSTIDVerification;
	}

	public static String getStrCBSIDModification() {
		return strCBSIDModification;
	}

	public static void setStrCBSIDModification(String strCBSIDModification) {
		ApplicationParams.strCBSIDModification = strCBSIDModification;
	}

	public static String getStrCBSIDCreation() {
		return strCBSIDCreation;
	}

	public static void setStrCBSIDCreation(String strCBSIDCreation) {
		ApplicationParams.strCBSIDCreation = strCBSIDCreation;
	}

	public static String getMONITORINGDBENABLED() {
		return MONITORINGDBENABLED;
	}

	public static void setMONITORINGDBENABLED(String monitoringdbenabled) {
		MONITORINGDBENABLED = monitoringdbenabled;
	}

	public static String getStrORACLEDBURL() {
		return strORACLEDBURL;
	}

	public static void setStrORACLEDBURL(String strORACLEDBURL) {
		ApplicationParams.strORACLEDBURL = strORACLEDBURL;
	}

	public static String getStrdoclocation() {
		return strdoclocation;
	}

	public static void setStrdoclocation(String strdoclocation) {
		ApplicationParams.strdoclocation = strdoclocation;
	}
	
	public static void setStrPRIVATEKEYFILE(String strPRIVATEKEYFILE) {
		ApplicationParams.strPRIVATEKEYFILE = strPRIVATEKEYFILE;
	}
	
	public static String getStrPRIVATEKEYFILE() {
		return strPRIVATEKEYFILE;
	}
	public static void setStrPUBLICKEYFILE(String strPUBLICKEYFILE) {
		ApplicationParams.strPUBLICKEYFILE = strPUBLICKEYFILE;
	}
	
	public static String getStrPUBLICKEYFILE() {
		return strPUBLICKEYFILE;
	}

	public static void initializeProperties(HashMap aPropsMap, String appServerHome, String lapsHome, String lapsHomePath, String lapsConfigPath,
			char fileSeparator) throws Exception
	{
		try
		{
			if (aPropsMap == null)
			{
				throw new Exception("Application Initialization Parameters not available");
			}
			setXMLFilePath(lapsConfigPath);
			if (aPropsMap.get("APPURL") != null)
			{
				setAppUrl((String) aPropsMap.get("APPURL"));
			}
			if (aPropsMap.get("INITIALCONTEXT") != null)
			{
				setInitialContext((String) aPropsMap.get("INITIALCONTEXT"));
			}
			if (aPropsMap.get("PROVIDERURL") != null)
			{
				setProviderUrl((String) aPropsMap.get("PROVIDERURL"));
			}
			if (aPropsMap.get("JNDIPATH") != null)
			{
				setJndiPath((String) aPropsMap.get("JNDIPATH"));
			}
			if (aPropsMap.get("IP") != null)
			{
				setIP((String) aPropsMap.get("IP"));
			}
			if (aPropsMap.get("DATASOURCE") != null)
			{
				setDataSource((String) aPropsMap.get("DATASOURCE"));
			}
			if (aPropsMap.get("CURRENCY") != null)
			{
				setCurrency((String) aPropsMap.get("CURRENCY"));
			}
			if (aPropsMap.get("ZIPNAME") != null)
			{
				setZipName((String) aPropsMap.get("ZIPNAME"));
			}
			if (aPropsMap.get("ZIPVALUE") != null)
			{
				setZipValue((String) aPropsMap.get("ZIPVALUE"));
			}
			if (aPropsMap.get("JSPMAPSFILE") != null)
			{
				setJspMAPSFile((String) aPropsMap.get("JSPMAPSFILE"));
			}
			if (aPropsMap.get("BEANMAPSFILE") != null)
			{
				setBeanMAPSFile((String) aPropsMap.get("BEANMAPSFILE"));
			}
			if (aPropsMap.get("SQLQUERYFILE") != null)
			{
				setSQLQueryFile((String) aPropsMap.get("SQLQUERYFILE"));
			}
			if (aPropsMap.get("DATABASETYPE") != null)
			{
				setDatabaseType((String) aPropsMap.get("DATABASETYPE"));
			}
			if (aPropsMap.get("VERSION") != null)
			{
				setLapsVersion((String) aPropsMap.get("VERSION"));
			}
			if (aPropsMap.get("DRIVEURL") != null)
			{
				setDRIVEURL((String) aPropsMap.get("DRIVEURL"));
			}
			if (aPropsMap.get("DRIVEURL1") != null)
			{
				setDRIVEURL1((String) aPropsMap.get("DRIVEURL1"));
			}
			if (aPropsMap.get("TERTIARYCMA") != null)
			{
				setTertiaryCMA((String) aPropsMap.get("TERTIARYCMA"));
			}
			if (aPropsMap.get("TERCMAWOADV") != null)
			{
				setTerCMAWOADV((String) aPropsMap.get("TERCMAWOADV"));
			}
			if (aPropsMap.get("FTPPATH") != null)
			{
				setFtpPath(lapsHomePath + fileSeparator + ((String) aPropsMap.get("FTPPATH")));
			}
			if (aPropsMap.get("IRBURL") != null)
			{
				setIRBUrl((String) aPropsMap.get("IRBURL"));
			}
			if (aPropsMap.get("SQLDBS2QUERYFILE") != null)
			{
				setStrSQLDBS2QUERYFILE((String) aPropsMap.get("SQLDBS2QUERYFILE"));
			}
			if (aPropsMap.get("DATASOURCE2") != null)
			{
				setStrDataSource2((String) aPropsMap.get("DATASOURCE2"));
			}
			if (aPropsMap.get("CIBILENABLE") != null)
			{
				setCIBILENABLE((String) aPropsMap.get("CIBILENABLE"));
			}
			if (aPropsMap.get("RESPONSEFILEPATH") != null)
			{
				setRESPONSEFOLDER((String) aPropsMap.get("RESPONSEFILEPATH"));
			}
			if (aPropsMap.get("CIBILREQUESTPATH") != null)
			{
				setRequestPath((String) aPropsMap.get("CIBILREQUESTPATH"));
			}
			if (aPropsMap.get("FILELISTENER") != null)
			{
				setFileListener(((String) aPropsMap.get("FILELISTENER")));
			}
			if (aPropsMap.get("AUDITRAILENABLE") != null)
			{
				setAuditTrailEnable(((String) aPropsMap.get("AUDITRAILENABLE")));
			}

			if (aPropsMap.get("DATASOURCE3") != null)
			{
				setStrDataSource3((String) aPropsMap.get("DATASOURCE3"));
			}

			if (aPropsMap.get("ONLINEENABLED") != null)
			{
				setStrOnlineEnabled((String) aPropsMap.get("ONLINEENABLED"));
			}

			if (aPropsMap.get("ONLINEEXCELPATH") != null)
			{
				setStrOnlineExcel((String) aPropsMap.get("ONLINEEXCELPATH"));
			}

			if (aPropsMap.get("FLATFILEPATH") != null)
			{
				setFlatFile((String) aPropsMap.get("FLATFILEPATH"));
			}
			if (aPropsMap.get("IMAGEENABLED") != null)
			{
				setStrImageEnabled((String) aPropsMap.get("IMAGEENABLED"));
			}
			if (aPropsMap.get("CCPSSQLQUERYFILE") != null)
			{
				setCCPSSQLQueryFile((String) aPropsMap.get("CCPSSQLQUERYFILE"));
			}
			if (aPropsMap.get("CBSSQLQUERYFILE") != null)
			{
				setCBSSQLQueryFile((String) aPropsMap.get("CBSSQLQUERYFILE"));
			}
			if (aPropsMap.get("CBS-INTEGRATION") != null)
			{
				setCbsIntegration((String) aPropsMap.get("CBS-INTEGRATION"));
			}
			if (aPropsMap.get("CBSDATASOURCE") != null)
			{
				setCBSFCRDataSource((String) aPropsMap.get("CBSDATASOURCE"));
			}
			if (aPropsMap.get("KALYPTOCON") != null)
			{
				setKalyptoConnection((String) aPropsMap.get("KALYPTOCON"));
			}
			if (aPropsMap.get("KALYPTODATASOURCE") != null)
			{
				setKalyptoDataSource((String) aPropsMap.get("KALYPTODATASOURCE"));
			}
			if (aPropsMap.get("KALYPTOWEBSERVICE") != null)
			{
				setKalyptowebservice((String) aPropsMap.get("KALYPTOWEBSERVICE"));
			}
			if (aPropsMap.get("RATINGSOAPADDRESS") != null)
			{
				setRatingSoapAddress((String) aPropsMap.get("RATINGSOAPADDRESS"));
			}
			if(aPropsMap.get("ONLINELOGINIP")!= null) {
				setStrOnlineIp(((String) aPropsMap.get("ONLINELOGINIP")));
			}
			if(aPropsMap.get("NSDLResponseFilePath")!= null) {
				setStrNSDLResponseFilePath((String) aPropsMap.get("NSDLResponseFilePath"));		
			}
			if(aPropsMap.get("NSDLCONNECTOR")!= null) {
				setStrNsdlConnector((String) aPropsMap.get("NSDLCONNECTOR"));		
			}
			if(aPropsMap.get("ORACLEDBURL")!= null) {
				setStrORACLEDBURL((String) aPropsMap.get("ORACLEDBURL"));		
			}
			if(aPropsMap.get("DOCLOCATION")!= null) {
				setStrdoclocation((String) aPropsMap.get("DOCLOCATION"));		
			}
			
			if(aPropsMap.get("SMSURL")!= null) {
				setStrSMSURL((String) aPropsMap.get("SMSURL"));		
			}
			if(aPropsMap.get("SMSDCode")!= null) {
				setStrSMSDCode((String) aPropsMap.get("SMSDCode"));		
			}
			
			
			
			
			if(aPropsMap.get("SMSDCode1")!= null) {
				setStrSMSDCode1((String) aPropsMap.get("SMSDCode1"));		
			}
			if(aPropsMap.get("SMSDCode2")!= null) {
				setStrSMSDCode2((String) aPropsMap.get("SMSDCode2"));		
			}
			if(aPropsMap.get("SMSDCode3")!= null) {
				setStrSMSDCode3((String) aPropsMap.get("SMSDCode3"));		
			}
			if(aPropsMap.get("SMSDCode4")!= null) {
				setStrSMSDCode4((String) aPropsMap.get("SMSDCode4"));		
			}
			if(aPropsMap.get("SMSDCode5")!= null) {
				setStrSMSDCode5((String) aPropsMap.get("SMSDCode5"));		
			}
			
			
			
			if(aPropsMap.get("SMSUserID")!= null) {
				setStrSMSUserID((String) aPropsMap.get("SMSUserID"));		
			}
			if(aPropsMap.get("SMSPassword")!= null) {
				setStrSMSPassword((String) aPropsMap.get("SMSPassword"));		
			}
			if(aPropsMap.get("SMSSender")!= null) {
				setStrSMSSender((String) aPropsMap.get("SMSSender"));		
			}
			if(aPropsMap.get("SMSType")!= null) {
				setStrSMSTypeFlag((String) aPropsMap.get("SMSType"));		
			}
			if(aPropsMap.get("SMSActiveFlag")!= null) {
				setSMSFlag((String) aPropsMap.get("SMSActiveFlag"));		
			}
			if(aPropsMap.get("MONITORINGDBENABLED")!= null) {
				setMONITORINGDBENABLED((String) aPropsMap.get("MONITORINGDBENABLED"));		
			}
			if (aPropsMap.get("CIBILPATH") != null) {
				setStrCIBILPATH((String) aPropsMap.get("CIBILPATH"));
			}
			if (aPropsMap.get("DATASOURCE4") != null) {
				setStrDataSource4((String) aPropsMap.get("DATASOURCE4"));
			}
			if (aPropsMap.get("CIBILRENEW") != null) {
		    	setStrCIBILRENEW((String) aPropsMap.get("CIBILRENEW"));
		    }
			if(aPropsMap.get("NSDLSchedulerStatus")!= null) {
				 setStrNSDLSchStatus((String) aPropsMap.get("NSDLSchedulerStatus"));		
			}
			if(aPropsMap.get("CBSIDCREATION")!= null) {
				setStrCBSIDCreation((String) aPropsMap.get("CBSIDCREATION"));		
			 }
			if(aPropsMap.get("CBSIDMODIFICATION")!= null) {
				setStrCBSIDModification((String) aPropsMap.get("CBSIDMODIFICATION"));		
			 }
			if(aPropsMap.get("CBSIDVERIFICATION")!= null) {
				setStrCUSTIDVerification((String) aPropsMap.get("CBSIDVERIFICATION"));		
			 }
			if(aPropsMap.get("CUSTIDPANMODIFICATION")!= null) {
				setStrCUSTIDPANModification((String) aPropsMap.get("CUSTIDPANMODIFICATION"));		
			 }
			if(aPropsMap.get("UPLOADFILETOSERVER")!= null) {
				setStrUploadFileToServer((String) aPropsMap.get("UPLOADFILETOSERVER"));		
			 }
			if(aPropsMap.get("READTABLEFROMSERVER")!= null) {
				setStrReadTableFromServer((String) aPropsMap.get("READTABLEFROMSERVER"));		
			 }
			if(aPropsMap.get("PUSHDOCUMENTSERVICE")!= null) {
				setStrPushDocumentService((String) aPropsMap.get("PUSHDOCUMENTSERVICE"));		
			 }
			if(aPropsMap.get("LOANACCOUNTOPENING")!= null) {
				setStrLoanAccountOpening((String) aPropsMap.get("LOANACCOUNTOPENING"));		
			 }
			if(aPropsMap.get("RetailTCDate")!= null) {
				setStrRetailTCEffectDate((String) aPropsMap.get("RetailTCDate"));		
			}
			if(aPropsMap.get("LMSDATASOURCE")!= null) {
				setStrLMSDatasource((String) aPropsMap.get("LMSDATASOURCE"));		
			}
			if(aPropsMap.get("LMSCONNECTION")!= null) {
				setStrLMSConnection((String) aPropsMap.get("LMSCONNECTION"));		
			}
			
			
			if(aPropsMap.get("DMSAUTHVALUE")!=null)
			{
				setStrAuthValue((String) aPropsMap.get("DMSAUTHVALUE"));		
			
			}
			if(aPropsMap.get("FINACLEDBURL")!=null)
			{
				setStrFinacleURL((String) aPropsMap.get("FINACLEDBURL"));		
				
			}
		
			if(aPropsMap.get("DMSGENERATEURL")!=null)
			{
				setStrdmsurl((String) aPropsMap.get("DMSGENERATEURL"));		
				
			}
			
			if(aPropsMap.get("BRESERVICEURL")!=null)
			{
				setStrbreurl((String) aPropsMap.get("BRESERVICEURL"));		
				
			}
			
			if(aPropsMap.get("DMSLOGINURL")!=null)
			{
				setStrdmsloginurl((String) aPropsMap.get("DMSLOGINURL"));					
				
			}
		
			if(aPropsMap.get("HUNTERURL")!=null)
			{
				setStrhunterurl((String) aPropsMap.get("HUNTERURL"));		
				
			}
			if(aPropsMap.get("UPDATEELIGIBILITY")!=null)
			{
				setStrcalceligibilityurl((String) aPropsMap.get("UPDATEELIGIBILITY"));		
				
			}
			if(aPropsMap.get("APICREDENTIAL")!=null)
			{
				setStrapicredential((String) aPropsMap.get("APICREDENTIAL"));		
				
			}
			
			if(aPropsMap.get("DIGIAPPDEDUPEAUTHVALUE")!=null)
			{
				setStrappdedupe((String) aPropsMap.get("DIGIAPPDEDUPEAUTHVALUE"));		
				
			}
			
			if(aPropsMap.get("CIBILREPORTPATH")!=null)
			{
				setStrCIBILReportPath((String) aPropsMap.get("CIBILREPORTPATH"));		
				
			}
			
			if(aPropsMap.get("AMBERRULEURL")!=null)
			{
				setStramberrule((String) aPropsMap.get("AMBERRULEURL"));		
				
			}
			
			if(aPropsMap.get("AMBERAUTHVALUE")!=null)
			{
				setStramberauthvalue((String) aPropsMap.get("AMBERAUTHVALUE"));		
				
			}
			
			
			if(aPropsMap.get("INPRINCIPLEURL")!=null)
			{
				setStrInprincipleUrl((String) aPropsMap.get("INPRINCIPLEURL"));		
				
			}
			
			if(aPropsMap.get("INPRINCIPLEAUTHVALUE")!=null)
			{
				setStrInprincipleAuthValue((String) aPropsMap.get("INPRINCIPLEAUTHVALUE"));		
				
			}
			
			if(aPropsMap.get("ROIUPDATEURL")!=null)
			{
				setStrroiupdurl((String) aPropsMap.get("ROIUPDATEURL"));		
				
			}
			
			if(aPropsMap.get("ROIAUTOLOANUPDATEURL")!=null)
			{
				setStrroipaupdurl((String) aPropsMap.get("ROIAUTOLOANUPDATEURL"));		
				
			}
			if (aPropsMap.get("PRIVATE_KEY_FILE") != null) {
				setStrPRIVATEKEYFILE((String) aPropsMap.get("PRIVATE_KEY_FILE"));
			}
			if (aPropsMap.get("PUBLIC_KEY_FILE") != null) {
				setStrPUBLICKEYFILE((String) aPropsMap.get("PUBLIC_KEY_FILE"));
			}
		
			
			if(aPropsMap.get("CLPCDATE")!=null)
			{
				setStrCLPCdate((String) aPropsMap.get("CLPCDATE"));		
				
			}

			 if (aPropsMap.get("POSTSANCENABLEDISABLELIVEDATE") != null) {
				 setStrPostSancEnabDisablelivedate((String) aPropsMap.get("POSTSANCENABLEDISABLELIVEDATE"));
				}

			 if (aPropsMap.get("CLPHDATE") != null) {
				 setStrCLPHdate((String) aPropsMap.get("CLPHDATE"));
				}

			if(aPropsMap.get("ROIBQLUPDATEURL")!=null)
			{
				setStrroiBQLupdurl((String) aPropsMap.get("ROIBQLUPDATEURL"));		
				
			}
			//gen
			if(aPropsMap.get("LOGINIBM")!=null)
			{
				setStrlogintoibm((String) aPropsMap.get("LOGINIBM"));		
				
			}
			
			if(aPropsMap.get("LOGINIBMPASS")!=null)
			{
				setStrlogintoibmPass((String) aPropsMap.get("LOGINIBMPASS"));		
				
			}
			//gen
			//digi
			if(aPropsMap.get("LOGINIBMDIGI")!=null)
			{
				setStrlogintoibmdigi((String) aPropsMap.get("LOGINIBMDIGI"));		
				
			}
			if(aPropsMap.get("LOGINIBMPASSDIGI")!=null)
			{
				setStrlogintoibmPassdigi((String) aPropsMap.get("LOGINIBMPASSDIGI"));		
				
			}
			//digi
			if(aPropsMap.get("BQLAUTHVALUE")!=null)
			{
				setStrBQLAuthValue((String) aPropsMap.get("BQLAUTHVALUE"));		
				
			}
			
			if(aPropsMap.get("ROIMSMEUPDATEURL")!=null)
			{
				setStrroiMSMEupdurl((String) aPropsMap.get("ROIMSMEUPDATEURL"));		
				
			}
			
			if(aPropsMap.get("UCICCON")!=null)
			{
				setStrUCICdatasource((String) aPropsMap.get("UCICCON"));		
				
			}
			
			if(aPropsMap.get("ENACHURL")!=null)
			{
				setStrENACHURL((String) aPropsMap.get("ENACHURL"));		
				
			}
			//gen
			if(aPropsMap.get("GENDMSURL")!=null)
			{
				setStrgenDocupdurl((String) aPropsMap.get("GENDMSURL"));		
				
			}
			//gen
			//digi
			if(aPropsMap.get("READTABLEFROMSERVER")!=null)
			{
			setStrgenDocupdurldigi((String) aPropsMap.get("READTABLEFROMSERVER"));
			}
			//digi
			if(aPropsMap.get("GENDMSUN")!=null)
			{
				setStrgenDocupdun((String) aPropsMap.get("GENDMSUN"));		
				
			}
			
			if(aPropsMap.get("GENDMSPD")!=null)
			{
				setStrgenDocupdpd((String) aPropsMap.get("GENDMSPD"));		
				
			}
			
			if(aPropsMap.get("LOGINIBMUN")!=null)
			{
				setStrIbmUN((String) aPropsMap.get("LOGINIBMUN"));		
				
			}
			
			if(aPropsMap.get("VERSIONSTAGE")!=null)
			{
				setVersionStage((String) aPropsMap.get("VERSIONSTAGE"));		
				
			}
			

			if(aPropsMap.get("BULKHANDOFFLAPSTIME")!= null)
			{
				setStrBULKHANDOFFLAPSTIME((String) aPropsMap.get("BULKHANDOFFLAPSTIME"));
			}
			if(aPropsMap.get("Aadharkey")!= null) {
				setStrAadharkey((String) aPropsMap.get("Aadharkey"));
			}
			if(aPropsMap.get("Aadharvector")!= null) {
				setStrAadharvector((String) aPropsMap.get("Aadharvector"));
			}
			if(aPropsMap.get("FinancialLocation")!= null){
				 setFinacialloaction((String)aPropsMap.get("finacialloaction"));
			 }
			
			if(aPropsMap.get("KBLUSERSSAC")!=null)
			{
				setStrKblUserSac((String) aPropsMap.get("KBLUSERSSAC"));
			}
			
			if(aPropsMap.get("POSTSANCATIONKEYFILE")!=null)
			{
				setStrPostSancationEncryptionFile((String) aPropsMap.get("POSTSANCATIONKEYFILE"));
			}
			
			
			if(aPropsMap.get("POSTSANCATIONDECYRPTKEYFILE")!=null)
			{
				setStrPostSancationDecryptionFile((String) aPropsMap.get("POSTSANCATIONDECYRPTKEYFILE"));
			}
			
			
			if(aPropsMap.get("POSTSANCATIONKEYURL")!=null)
			{
				setStrPostSancationEncryptionURL((String) aPropsMap.get("POSTSANCATIONKEYURL"));
			}
			
			
			
			if(aPropsMap.get("POSTSANCATIONTOKENFILE")!=null)
			{
				setStrPostSancationTokenFile((String) aPropsMap.get("POSTSANCATIONTOKENFILE"));
			}
			
			
			
			if(aPropsMap.get("POSTSANCATIONNURL")!=null)
			{
				setStrPostSanctionNURL((String) aPropsMap.get("POSTSANCATIONNURL"));
			}
			
			
			if(aPropsMap.get("POSTSANCATIONTOKENURL")!=null)
			{
				setStrPostSanctionTokenURL((String) aPropsMap.get("POSTSANCATIONTOKENURL"));
			}
			
			
			if(aPropsMap.get("POSTSANCATIONNURL2")!=null)
			{
				setStrPostSanctionNURL2((String) aPropsMap.get("POSTSANCATIONNURL2"));
			}
			
			
			
			
			if(aPropsMap.get("POSTSANCATIONURLENC1")!=null)
			{
				setStrPostSanctionURLEnc1((String) aPropsMap.get("POSTSANCATIONURLENC1"));
			}
			if(aPropsMap.get("POSTSANCATIONURLENC2")!=null)
			{
				setStrPostSanctionURLEnc2((String) aPropsMap.get("POSTSANCATIONURLENC2"));
			}
			
			if(aPropsMap.get("SCHSECURITYFLAG")!=null)
			{
				setSCHSECURITYFLAG((String) aPropsMap.get("SCHSECURITYFLAG"));
			}
			
			if(aPropsMap.get("SCHSECURITYDAYS")!=null)
			{
				setSCHSECURITYDAYS((String) aPropsMap.get("SCHSECURITYDAYS"));
			}
			
			if(aPropsMap.get("SCHSECURITYHOURS")!=null)
			{
				setSCHSECURITYHOURS((String) aPropsMap.get("SCHSECURITYHOURS"));
			}
			
			if(aPropsMap.get("SCHSECURITYMINS")!=null)
			{
				setSCHSECURITYMINS((String) aPropsMap.get("SCHSECURITYMINS"));
			}
			
			
			
			if(aPropsMap.get("SHGFILE_RESDOWNLOAD")!=null)
			{
				setSHGFILE_RESDOWNLOAD((String) aPropsMap.get("SHGFILE_RESDOWNLOAD"));
			}
			
		}
		catch (Exception e)
		{
			SAILogger.log("Exception in ApplicationParams.initializeProperties() - " + e.getMessage());
			throw e;
		}
	}

	/*
	 * ************************************************************************
	 * Start of setter methods *************************************************************************
	 */
	private static void setXMLFilePath(String aXMLFilePath)
	{
		strxmlfilepath = aXMLFilePath;
	}

	public static void setXMLFactory(String aXMLFactory)
	{
		strxmlfactory = aXMLFactory;
	}

	private static void setInitialContext(String aInitialContext)
	{
		strinitialcontext = aInitialContext;
	}

	private static void setProviderUrl(String aProviderUrl)
	{
		strproviderurl = aProviderUrl;
	}

	private static void setJndiPath(String aJndiPath)
	{
		strJndiPath = aJndiPath;
	}

	private static void setDataSource(String aDataSource)
	{
		strdatasource = aDataSource;
	}

	private static void setAppUrl(String aAppUrl)
	{
		strappurl = aAppUrl;
	}

	private static void setCurrency(String aCurrency)
	{
		strcurrency = aCurrency;
	}

	private static void setIP(String aIP)
	{
		strIP = aIP;
	}

	private static void setZipName(String aZipName)
	{
		strZipName = aZipName;
	}

	private static void setZipValue(String aZipValue)
	{
		strZipValue = aZipValue;
	}

	private static void setJspMAPSFile(String aJspMapsFile)
	{
		strJspMAPSFile = aJspMapsFile;
	}

	private static void setBeanMAPSFile(String aBeanMapsFile)
	{
		strBeanMAPSFile = aBeanMapsFile;
	}

	private static void setSQLQueryFile(String aSQLQueryFile)
	{
		strSQLQueriesFile = aSQLQueryFile;
	}

	private static void setDatabaseType(String aDatabaseType)
	{
		strDatabaseType = aDatabaseType;
	}

	private static void setLapsVersion(String aLapsVersion)
	{
		strLapsVersion = aLapsVersion;
	}

	private static void setDRIVEURL(String aDRIVEURL)
	{
		strFolder = aDRIVEURL;
	}

	private static void setCCPSSQLQueryFile(String aCCPSSQLQueryFile)
	{
		strCCPSSQLQueriesFile = aCCPSSQLQueryFile;
	}

	private static void setDRIVEURL1(String aDRIVEURL1)
	{
		strFolder1 = aDRIVEURL1;
	}

	private static void setTertiaryCMA(String aTertiaryCMA)
	{
		strTertiarycma = aTertiaryCMA;
	}

	private static void setTerCMAWOADV(String aOPSCMAWOADV)
	{
		strOPSCMAWOADV = aOPSCMAWOADV;
	}

	private static void setFtpPath(String aFTPPath)
	{
		strFtpPath = aFTPPath;
	}

	private static void setIRBUrl(String aIRBUrl)
	{
		strIRBURL = aIRBUrl;
	}

	public static void setStrSQLDBS2QUERYFILE(String strSQLDBS2QUERYFILE)
	{
		ApplicationParams.strSQLDBS2QUERYFILE = strSQLDBS2QUERYFILE;
	}

	public static void setStrDataSource2(String strDataSource2)
	{
		ApplicationParams.strDataSource2 = strDataSource2;
	}

	public static void setCIBILENABLE(String strCIBILREPORT)
	{
		ApplicationParams.strCIBILREPORT = strCIBILREPORT;
	}

	private static void setRESPONSEFOLDER(String aresurl)
	{
		strcibilFolder = aresurl;
	}

	private static void setRequestPath(String aDRIVEURL)
	{
		strRequestPath = aDRIVEURL;
	}

	private static void setFileListener(String strFileListener)
	{
		ApplicationParams.strFileListener = strFileListener;
	}

	public static void setStrDataSource3(String strDataSource3)
	{
		ApplicationParams.strdatasource3 = strDataSource3;
	}

	private static void setAuditTrailEnable(String strAuditTrailEnable)
	{
		ApplicationParams.strAuditTrail = strAuditTrailEnable;
	}

	public static void setStrOnlineEnabled(String strOnlineEnabled)
	{
		ApplicationParams.stronlineenabled = strOnlineEnabled;
	}

	public static void setStrOnlineExcel(String strOnlineExcel)
	{
		ApplicationParams.strOnlineExcel = strOnlineExcel;
	}

	public static void setStrOnlineIp(String strOnlineIp) {
		ApplicationParams.strOnlineIp = strOnlineIp;
	}
	public static String getStrOnlineIp() {
		return strOnlineIp;
	}
	public static void setFlatFile(String strFlatFile)
	{
		strFlatfileFormat = strFlatFile;
	}

	public static void setStrImageEnabled(String strImageEnable)
	{
		strImageEnabled = strImageEnable;
	}

	private static void setCBSSQLQueryFile(String aCBSSQLQueryFile)
	{
		strCBSSQLQueriesFile = aCBSSQLQueryFile;
	}

	private static void setCbsIntegration(String aCbsIntegration)
	{
		strCbsIntegration = aCbsIntegration;
	}

	private static void setCBSFCRDataSource(String aCBSDataSource)
	{
		strcbsfcrdatasource = aCBSDataSource;
	}

	private static void setKalyptoConnection(String aKalyptoCon)
	{
		strKalyptoConnection = aKalyptoCon;
	}

	private static void setKalyptoDataSource(String aKalyptoDataSource)
	{
		strKalyptoDataSource = aKalyptoDataSource;
	}

	private static void setKalyptowebservice(String aKalyptoWebserivce)
	{
		strKalyptowebservice = aKalyptoWebserivce;
	}

	private static void setRatingSoapAddress(String RatingSoapAddress)
	{
		strRatingSoadAddress = RatingSoapAddress;
	}
	private static void setStrNSDLResponseFilePath(String NSDLResponseFilePath)
	{
		strNSDLResponseFilePath = NSDLResponseFilePath;
	}

	public static String getCCPSSQLQueryFile()
	{
		return strCCPSSQLQueriesFile;
	}

	public static String getCBSSQLQueryFile()
	{
		return strCBSSQLQueriesFile;
	}

	public static String getCbsIntegration()
	{
		return strCbsIntegration;
	}

	public static String getCBSFCRDataSource()
	{
		return strcbsfcrdatasource;
	}

	public static String getKalyptoConnection()
	{
		return strKalyptoConnection;
	}

	public static String getKalyptoDataSource()
	{
		return strKalyptoDataSource;
	}

	public static String getKalyptowebservice()
	{
		return strKalyptowebservice;
	}

	public static String getRatingSoapAddress()
	{
		return strRatingSoadAddress;
	}

	/*
	 * **********************************************************
	 * End of Setter Methods **********************************************************
	 */
	/*
	 * ************************************************************
	 * Start of getter Methods ************************************************************
	 */

	public static String getXMLFilePath()
	{
		return strxmlfilepath;
	}

	public static String getXMLFactory()
	{
		return strxmlfactory;
	}

	public static String getInitialContext()
	{
		return strinitialcontext;
	}

	public static String getProviderUrl()
	{
		return strproviderurl;
	}

	public static String getJndiPath()
	{
		return strJndiPath;
	}

	public static String getDataSource()
	{
		return strdatasource;
	}

	public static String getAppUrl()
	{
		return strappurl;
	}

	public static String getCurrency()
	{
		return strcurrency;
	}

	public static String getIP()
	{
		return strIP;
	}

	public static String getZipName()
	{
		return strZipName;
	}

	public static String getZipValue()
	{
		return strZipValue;
	}

	public static String getJspMAPSFile()
	{
		return strJspMAPSFile;
	}

	public static String getBeanMAPSFile()
	{
		return strBeanMAPSFile;
	}

	public static String getSQLQueryFile()
	{
		return strSQLQueriesFile;
	}

	public static String getDatabaseType()
	{
		return strDatabaseType;
	}

	public static String getLapsVersion()
	{
		return strLapsVersion;
	}

	public static String getDRIVEURL()
	{
		return strFolder;
	}

	public static String getDRIVEURL1()
	{
		return strFolder1;
	}

	public static String getTertiaryCMA()
	{
		return strTertiarycma;
	}

	public static String getTerCMAWOADV()
	{
		return strOPSCMAWOADV;
	}

	public static String getFtpPath()
	{
		return strFtpPath;
	}

	public static String getIRBUrl()
	{
		return strIRBURL;
	}

	public static String getStrSQLDBS2QUERYFILE()
	{
		return strSQLDBS2QUERYFILE;
	}

	public static String getStrDataSource2()
	{
		return strDataSource2;
	}

	public static String getCIBILENABLE()
	{
		return strCIBILREPORT;
	}

	public static String getRESPONSEFOLDER()
	{
		return strcibilFolder;
	}

	public static String getRequestPath()
	{
		return strRequestPath;
	}

	public static String getFileListener()
	{
		return strFileListener;
	}

	public static String getAuditTrailEnable()
	{
		return strAuditTrail;
	}

	public static String getDataSource3()
	{
		return strdatasource3;
	}

	public static String getstrOnlineEnabled()
	{
		return stronlineenabled;
	}

	public static String getstrOnlineExcel()
	{
		return strOnlineExcel;
	}

	public static String getFlatFile()
	{
		return strFlatfileFormat;
	}

	public static String getImageEnabled()
	{
		return strImageEnabled;
	}
	public static String getstrNSDLResponseFilePath() 
	{
		return strNSDLResponseFilePath;
	}
	public static String getStrNsdlConnector() { return strNsdlConnector; }
	public static void setStrNsdlConnector(String strNsdlConnector)
	{
		ApplicationParams.strNsdlConnector = strNsdlConnector;
	}
	/*
	 * *******************************************************************************
	 * End of Getter Methods********************************************************************************
	 */

	public static String getStrSMSURL() {
		return strSMSURL;
	}

	public static void setStrSMSURL(String strSMSURL) {
		ApplicationParams.strSMSURL = strSMSURL;
	}

	public static String getStrSMSDCode() {
		return strSMSDCode;
	}

	public static void setStrSMSDCode(String strSMSDCode) {
		ApplicationParams.strSMSDCode = strSMSDCode;
	}

	public static String getStrSMSUserID() {
		return strSMSUserID;
	}

	public static void setStrSMSUserID(String strSMSUserID) {
		ApplicationParams.strSMSUserID = strSMSUserID;
	}

	public static String getStrSMSPassword() {
		return strSMSPassword;
	}

	public static void setStrSMSPassword(String strSMSPassword) {
		ApplicationParams.strSMSPassword = strSMSPassword;
	}

	public static String getStrSMSSender() {
		return strSMSSender;
	}

	public static void setStrSMSSender(String strSMSSender) {
		ApplicationParams.strSMSSender = strSMSSender;
	}

	public static String getStrSMSTypeFlag() {
		return strSMSTypeFlag;
	}

	public static void setStrSMSTypeFlag(String strSMSTypeFlag) {
		ApplicationParams.strSMSTypeFlag = strSMSTypeFlag;
	}

	public static String getSMSFlag() {
		return SMSFlag;
	}

	public static void setSMSFlag(String flag) {
		SMSFlag = flag;
	}
	
	public static void setStrCIBILPATH(String strCIBILPATH) 
	{
		ApplicationParams.strCIBILPATH = strCIBILPATH;
	}

	public static String getStrCIBILPATH() 
	{
		return strCIBILPATH;
	}
	
	public static void setStrCIBILRENEW(String strCIBILRENEW) 
	{
		ApplicationParams.strCIBILRENEW = strCIBILRENEW;
	}
	
	public static String getStrCIBILRENEW() 
	{
		return strCIBILRENEW;
	}
	
	public static void setStrDataSource4(String strDataSource4) 
	{
		ApplicationParams.strdatasource4 = strDataSource4;
	}
	public static String getDataSource4() 
	{
		return strdatasource4;
	}
	public static String getStrNSDLSchStatus() {
		return strNSDLSchStatus;
	}

	public static void setStrNSDLSchStatus(String strNSDLSchStatus) {
		ApplicationParams.strNSDLSchStatus = strNSDLSchStatus;
	}

	public static String getStrRetailTCEffectDate() {
		return strRetailTCEffectDate;
	}

	public static void setStrRetailTCEffectDate(String strRetailTCEffectDate) {
		ApplicationParams.strRetailTCEffectDate = strRetailTCEffectDate;
	}

	public static String getStrLMSDatasource() {
		return strLMSDatasource;
	}

	public static void setStrLMSDatasource(String strLMSDatasource) {
		ApplicationParams.strLMSDatasource = strLMSDatasource;
	}

	public static String getStrFinacleURL() {
		return strFinacleURL;
	}

	public static void setStrFinacleURL(String strFinacleURL) {
		ApplicationParams.strFinacleURL = strFinacleURL;
	}

	public static String getStrapicredential() {
		return strapicredential;
	}

	public static void setStrapicredential(String strapicredential) {
		ApplicationParams.strapicredential = strapicredential;
	}

	public static String getStrCIBILReportPath()
	{
		return strCIBILReportPath;
	}

	public static void setStrCIBILReportPath(String strCIBILReportPath)
	{
		ApplicationParams.strCIBILReportPath=strCIBILReportPath;
	}

	public static void setStrroiupdurl(String strroiupdurl) {
		ApplicationParams.strroiupdurl = strroiupdurl;
	}

	public static String getStrroiupdurl() {
		return strroiupdurl;
	}

	public static void setStrroipaupdurl(String strroipaupdurl) {
		ApplicationParams.strroipaupdurl = strroipaupdurl;
	}

	public static String getStrroipaupdurl() {
		return strroipaupdurl;
	}

	public static void setStrCLPCdate(String strCLPCdate) {
		ApplicationParams.strCLPCdate = strCLPCdate;
	}

	public static String getStrCLPCdate() {
		return strCLPCdate;
	}


	public static String getStrPostSancEnabDisablelivedate() {
		return strPostSancEnabDisablelivedate;
	}

	public static void setStrPostSancEnabDisablelivedate(
			String strPostSancEnabDisablelivedate) {
		ApplicationParams.strPostSancEnabDisablelivedate = strPostSancEnabDisablelivedate;
	}



	public static void setStrroiBQLupdurl(String strroiBQLupdurl) {
		ApplicationParams.strroiBQLupdurl = strroiBQLupdurl;
	}

	public static String getStrroiBQLupdurl() {
		return strroiBQLupdurl;
	}
	//gen
	public static void setStrlogintoibm(String strlogintoibm) {
		ApplicationParams.strlogintoibm = strlogintoibm;
	}

	public static String getStrlogintoibm() {
		return strlogintoibm;
	}

	public static void setStrlogintoibmPass(String strlogintoibmPass) {
		ApplicationParams.strlogintoibmPass = strlogintoibmPass;
	}

	public static String getStrlogintoibmPass() {
		return strlogintoibmPass;
	}
	//gen
	//digi
	public static void setStrlogintoibmdigi(String strlogintoibmdigi) {
		ApplicationParams.strlogintoibmdigi = strlogintoibmdigi;
	}
	
	public static String getStrlogintoibmdigi() {
		return strlogintoibmdigi;
	}
	
	public static void setStrlogintoibmPassdigi(String strlogintoibmPassdigi) {
		ApplicationParams.strlogintoibmPassdigi = strlogintoibmPassdigi;
	}
	
	public static String getStrlogintoibmPassdigi() {
		return strlogintoibmPassdigi;
	}
	//digi
	public static void setStrBQLAuthValue(String strBQLAuthValue) {
		StrBQLAuthValue = strBQLAuthValue;
	}

	public static String getStrBQLAuthValue() {
		return StrBQLAuthValue;
	}

	public static void setStrroiMSMEupdurl(String strroiMSMEupdurl) {
		ApplicationParams.strroiMSMEupdurl = strroiMSMEupdurl;
	}

	public static String getStrroiMSMEupdurl() {
		return strroiMSMEupdurl;
	}

	public static void setStrUCICdatasource(String strUCICdatasource) {
		ApplicationParams.strUCICdatasource = strUCICdatasource;
	}

	public static String getStrUCICdatasource() {
		return strUCICdatasource;
	}

	public static void setStrENACHURL(String strENACHURL) {
		ApplicationParams.strENACHURL = strENACHURL;
	}

	public static String getStrENACHURL() {
		return strENACHURL;
	}
	//gen
	public static void setStrgenDocupdurl(String strgenDocupdurl) {
		ApplicationParams.strgenDocupdurl = strgenDocupdurl;
	}

	public static String getStrgenDocupdurl() {
		return strgenDocupdurl;
	}
	//gen
	//digi
	public static void setStrgenDocupdurldigi(String strgenDocupdurldigi) {
		ApplicationParams.strgenDocupdurldigi = strgenDocupdurldigi;
	}
	public static String getStrgenDocupdurldigi() {
		return strgenDocupdurldigi;
	}
	//digi
	public static void setStrgenDocupdun(String strgenDocupdun) {
		ApplicationParams.strgenDocupdun = strgenDocupdun;
	}

	public static String getStrgenDocupdun() {
		return strgenDocupdun;
	}

	public static void setStrgenDocupdpd(String strgenDocupdpd) {
		ApplicationParams.strgenDocupdpd = strgenDocupdpd;
	}

	public static String getStrgenDocupdpd() {
		return strgenDocupdpd;
	}

	public static void setStrIbmUN(String strIbmUN) {
		ApplicationParams.strIbmUN = strIbmUN;
	}

	public static String getStrIbmUN() {
		return strIbmUN;
	}

	public static String getStrBULKHANDOFFLAPSTIME() {
		return StrBULKHANDOFFLAPSTIME;
	}


	public static void setStrBULKHANDOFFLAPSTIME(String strBULKHANDOFFLAPSTIME) {
		StrBULKHANDOFFLAPSTIME = strBULKHANDOFFLAPSTIME;
	}

	public static String getStrAadharkey() {
		return strAadharkey;
	}

	public static void setStrAadharkey(String strAadharkey) {
		ApplicationParams.strAadharkey = strAadharkey;
	}

	public static String getStrAadharvector() {
		return strAadharvector;
	}

	public static void setStrAadharvector(String strAadharvector) {
		ApplicationParams.strAadharvector = strAadharvector;
	}
	public static String getFinacialloaction() {
		return finacialloaction;
	}

	public static void setFinacialloaction(String finacialloaction) {
		ApplicationParams.finacialloaction = finacialloaction;
	}

	public static String getSCHSECURITYFLAG() {
		return SCHSECURITYFLAG;
	}

	public static void setSCHSECURITYFLAG(String sCHSECURITYFLAG) {
		ApplicationParams.SCHSECURITYFLAG = sCHSECURITYFLAG;
	}

	public static String getSCHSECURITYDAYS() {
		return SCHSECURITYDAYS;
	}

	public static void setSCHSECURITYDAYS(String sCHSECURITYDAYS) {
		ApplicationParams.SCHSECURITYDAYS = sCHSECURITYDAYS;
	}

	public static String getSCHSECURITYHOURS() {
		return SCHSECURITYHOURS;
	}

	public static void setSCHSECURITYHOURS(String sCHSECURITYHOURS) {
		ApplicationParams.SCHSECURITYHOURS = sCHSECURITYHOURS;
	}

	public static String getSCHSECURITYMINS() {
		return SCHSECURITYMINS;
	}

	public static void setSCHSECURITYMINS(String sCHSECURITYMINS) {
		ApplicationParams.SCHSECURITYMINS = sCHSECURITYMINS;
	}

  
	
	
	
}