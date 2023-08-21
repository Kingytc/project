<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="PageId" class="java.lang.String" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserId" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgCode" class="java.lang.String" scope="session" />
<jsp:useBean id="strOrgName" class="java.lang.String" scope="session" />
<jsp:useBean id="strUserClass" class="java.lang.String" scope="session" />
<lapschoice:handleerror />
<%
/*response.addHeader("P3P","CP=\"IDC DSP COR ADM DEVi TAIi PSA PSD IVAi IVDi CONi HIS OUR IND CNT\"");
response.addHeader("X-UA-Compatible","IE=EmulateIE8");
	//request.setAttribute("_cache_refresh", "true"); 
	SimpleDateFormat sDF = new SimpleDateFormat("dd MMM yyyy hh:mm a",Locale.US);
	String strDate = sDF.format(new Date(System.currentTimeMillis() - (long)82800000));
	//response.setHeader("Expires",strDate);
	//response.setHeader("Cache-Control", "no-cache");
	
	//request.setAttribute("_cache_refresh", "true"); 
   /* response.setHeader("Cache-Control", "no-cache, no-store"); // HTTP 1.1.
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
    response.setHeader("Expires", "0"); // Proxies.*/
    
  /*  response.setHeader("Set-Cookie","JSESSIONID="+session.getId()+";HttpOnly;SameSite=Strict;");//Secure;");
    response.addHeader("X-Frame-Options", "SAMEORIGIN");
    response.addHeader("Content-Security-Policy", "frame-ancestors 'self';");
    response.setHeader("Strict-Transport-Security","max-age=31536000;includeSubdomains"); 
    response.setHeader("X-XSS-Protection", "1; mode=block");
    response.addHeader("X-Content-Type-Option", "nosniff");*/
    
	
    SimpleDateFormat sDF = new SimpleDateFormat("dd MMM yyyy hh:mm a",Locale.US);
	String strDate = sDF.format(new Date(System.currentTimeMillis() - (long)82800000));
	//request.setAttribute("_cache_refresh", "true"); 
	//response.setHeader("Expires",strDate);
	//response.setHeader("Cache-Control", "no-cache");
	
   request.setAttribute("_cache_refresh", "true"); 
   response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate, pre-check=0, post-check=0, max-age=0, s-maxage=0"); // HTTP 1.1.
   response.setHeader("Pragma", "no-cache"); // HTTP 1.0.
   response.setDateHeader("Expires", 0); // Proxies.	
	
   response.addHeader("X-Frame-Options", "SAMEORIGIN");
   response.addHeader("Content-Security-Policy", "frame-ancestors 'self';");
   response.setHeader("Strict-Transport-Security","max-age=31536000;includeSubdomains"); 
   response.setHeader("X-XSS-Protection", "1; mode=block");
   response.addHeader("X-Content-Type-Option", "nosniff");
   
	String strCategoryType = Helper.correctNull((String) request.getParameter("hidCategoryType"));
	//String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
		strCategoryType = "CORP";
	}
	if (strCategoryType.equals("")) 
	{
		strCategoryType = Helper.correctNull((String) hshValues.get("categorytype"));
	}
	if (strCategoryType.equalsIgnoreCase("")) 
	{
		strCategoryType = Helper.correctNull((String) request.getParameter("hidcategory"));
	}
	if (strCategoryType.equalsIgnoreCase("")) 
	{
		if(hshValues.get("hidCategoryType") instanceof String[])
		{
			 String[] strArray = (String[]) hshValues.get("hidCategoryType");
		     System.out.println(Arrays.toString(strArray));
		}
		else
		{
			strCategoryType = Helper.correctNull((String) hshValues.get("hidCategoryType"));
		}
		if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
			strCategoryType = "CORP";
		}
		 
	}
	if (strCategoryType.equalsIgnoreCase("")) 
	{
		strCategoryType = Helper.correctNull((String) session.getAttribute("cattype"));
		
		if (strCategoryType.equalsIgnoreCase("")) 
		{
			strCategoryType = Helper.correctNull((String) session.getAttribute("sessionModuleType"));
		}
		if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
			strCategoryType = "CORP";
		}
		 
		
	}

	String strSSIType = Helper.correctNull((String) request.getParameter("hidSSIType"));
	if (strSSIType.equalsIgnoreCase("")) {
		strSSIType = Helper.correctNull((String) hshValues.get("hidSSIType"));
	}

	String strBorrowerId = Helper.correctNull((String) hshValues.get("borrowid"));
	if (strBorrowerId.trim().equals("")) {
		strBorrowerId = Helper.correctNull((String) request.getParameter("comapp_id"));
	}
	 %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<!--<script LANGUAGE="JavaScript" src="<%//=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>-->
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
<script>var appURL = "<%=ApplicationParams.getAppUrl()%>";</script>
<script>var currentDate = "<%=Helper.getCurrentDateTime()%>";</script>
</head>
</html>