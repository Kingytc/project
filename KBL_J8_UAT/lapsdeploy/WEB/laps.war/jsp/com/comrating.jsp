<%@include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();

if(hshValues!=null)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
}
int arSize=0;
if(arrRow!=null && arrRow.size()>0)
{
	arSize=arrRow.size();
}
String strChekFlag=Helper.correctNull((String)hshValues.get("strFlag"));
String strChekSendFlag=Helper.correctNull((String)hshValues.get("strSendFlag"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strfacSNO="";
String strFinalFlag="",strBusiID="",strCurrYear="";
String strRatType="",strMisFlag="";
ArrayList arRatRow=new ArrayList();
ArrayList arRatCol=new ArrayList();
String strDataSecFlag="";
String strROIValue="";
String strNonPoolEMptyRatingFlag="",strRMDUserFlag="";
String digiPrdType=Helper.correctNull((String)hshValues.get("prdType"));

if(hshValues!=null)
{
	strfacSNO=Helper.correctNull((String)hshValues.get("strFacSno"));
	strFinalFlag=Helper.correctNull((String)hshValues.get("strFinalFlag"));
	strBusiID=Helper.correctNull((String)hshValues.get("strBusId"));
	strCurrYear=Helper.correctNull((String)hshValues.get("strCurrYear"));
	strRatType=Helper.correctNull((String)hshValues.get("strRatType"));
	strMisFlag=Helper.correctNull((String)hshValues.get("strDataFlag"));
	arRatRow=(ArrayList)hshValues.get("arRatRow");
	strDataSecFlag=Helper.correctNull((String)hshValues.get("strDataSecFlag"));
	 strROIValue=Helper.correctNull((String)hshValues.get("ROIUpdateFlag"));
	 strNonPoolEMptyRatingFlag=Helper.correctNull((String)hshValues.get("strNonPoolEMptyRatingFlag"));
	 strRMDUserFlag=Helper.correctNull((String)hshValues.get("strRMDUserFlag"));
	 
}
String strFreezePromoters=Helper.correctNull((String)hshValues.get("strPromoFreezeflag"));
String strFreezeSecurity=Helper.correctNull((String)hshValues.get("strSecFreezeflag"));
String strFIN_TALLY=Helper.correctNull((String)hshValues.get("FIN_TALLY"));

String strCashMargin=Helper.correctNull((String)session.getAttribute("strCashMargin"));
if(strCashMargin.equalsIgnoreCase("Y"))
	strRatType="0";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
var varCheckFlag="<%=strChekFlag%>";
var varSendFlag="<%=strChekSendFlag%>";
var varFacSno="<%=strfacSNO%>";
var varstrBusiID="<%=strBusiID%>";
var varCurrYear="<%=strCurrYear%>";
var varstrFinalFlag="<%=strFinalFlag%>";
var varFinTally="<%=strFIN_TALLY%>";
var varWebserviceErrorMessage="<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)hshValues.get("WebserviceErrorMessage")))%>";
var varstrROIValue="<%=strROIValue%>";
var varstrNonPoolEMptyRatingFlag="<%=strNonPoolEMptyRatingFlag%>";
var varFreezePromoters="<%=strFreezePromoters%>";
var varFreezeSecurity="<%=strFreezeSecurity%>";
var varRMDUserFlag="<%=strRMDUserFlag%>";
var varMCLRTally="<%=Helper.correctNull((String)hshValues.get("strMCLRTally"))%>";
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
var varUpdateROIFlag="<%=Helper.correctNull((String)hshValues.get("strupdateROIFlag"))%>";
var varRatingROIFlag="<%=Helper.correctInt((String)hshValues.get("strRatingROI"))%>";
</script>
<script>

function callOnLoad()
{

	disableFields(true);
	if(varCheckFlag=="Y")
	{
		if(varSendFlag=="Y")
		{
		document.forms[0].send.disabled=true;
		disableCommandButtons(true, true, true, true, false);		
		}
		else
		{
			document.forms[0].send.disabled=false;
			disableCommandButtons(false, true, true, true, false);
		}
	}
	else
	{
		document.forms[0].send.disabled=true;
	}


	  if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
		        document.forms[0].doundo.disabled=true;
		        disableCommandButtons(true, true, true, true, false);
			  }
			  else
			  {
				    document.forms[0].doundo.disabled=false;
			        disableCommandButtons(true, true, true, true, false);
               
			  }
		   
		  }
		  else
		  {
			  document.forms[0].doundo.disabled=true;
			  disableCommandButtons(false, true, true, true, false);
		  }
		  
	  }
	  else
	  {
		document.forms[0].doundo.disabled=true;
	  }

	  if(varFacSno!="")
	  {
        //document.forms[0].sel_facilitysno.value=varFacSno;
	  }
	  else
	  {
		  //document.forms[0].sel_facilitysno.value="";
	  }
	  <%if(strFinalFlag.equalsIgnoreCase("N")){%>
	 
	  if(varstrBusiID!="")
	  {
		  document.forms[0].sel_corpbusinessid.value=varstrBusiID;
			  }
	  else
	  {
		  document.forms[0].sel_corpbusinessid.value=""; 
	  }

	  if(varCurrYear!="")
	  {
		  document.forms[0].sel_curryear.value=varCurrYear;
	  }
	  else
	  {
		  document.forms[0].sel_curryear.value=""; 
	  }
	 
	  <%}%>

	  <%if(strfacSNO.equalsIgnoreCase("")){%>
	  disableCommandButtons(true, true, true, true, false);
	  //document.forms[0].sel_facilitysno.disabled=false;
	  <%}%>

		<%if(arrRow!=null && arrRow.size()>0){
			String strName2="",stValue="";
			int j=0;
			for(int i=0;i<arrRow.size();i++)
			{
				int k=i+1;
				arrCol=(ArrayList)arrRow.get(i);
				strName2="txt_riskparam"+k;
				j=Integer.parseInt(Helper.correctInt((String)arrCol.get(0)));
				stValue="rskvalue"+j;
				if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
				if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")
						|| Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01"))
				{
				%>
				<%if(strChekFlag.equalsIgnoreCase("Y")){%>
				 document.forms[0].<%=strName2%>.value="<%=Helper.correctNull((String)hshValues.get(stValue))%>";
				 <%}else if(strChekFlag.equalsIgnoreCase("N")){%>
				 document.forms[0].<%=strName2%>.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				 <%}%>
				 document.forms[0].<%=strName2%>.disabled=true;
				 
				 <%}else{%>			 

				 document.forms[0].<%=strName2%>.readOnly=true;
				
				<%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

				 document.forms[0].<%=strName2%>.readOnly=false;
			<%
				}
			}
			
		}%>


		<%if(strMisFlag.equalsIgnoreCase("N")){%>
	    alert("Please Fill the MIS/CBS Details Page");
	    document.forms[0].hidBeanId.value="mis";	
		document.forms[0].hidBeanGetMethod.value="getMISDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/misdetails.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();	

	<%}else{%>	
      
	<%}%>

	if(varWebserviceErrorMessage!="")
	  {
		  alert(varWebserviceErrorMessage);
	  }
	 if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
				  document.forms[0].roiupdate.disabled=true;
			  }
			  else
			  {
				  if(varstrROIValue=="Y")
					{
						document.forms[0].roiupdate.disabled=false;
						
						if(varUpdateROIFlag=="Y" && eval(varRatingROIFlag)>0)
						{
							alert("Please Click Update ROI button");
							document.forms[0].roiupdate.disabled=false;
						}
					}
					else
					{
						document.forms[0].roiupdate.disabled=true;
					}
			  }
		  }
		  else
			{
				document.forms[0].roiupdate.disabled=true;
				
			}
	  }
	  else
		{
			document.forms[0].roiupdate.disabled=true;
			
		}
	  if(varCheckFlag=="Y")
	  {
		  if(varSendFlag=="Y")
		  {
			  if(varstrNonPoolEMptyRatingFlag=="Y")
			  {
		
		       document.forms[0].docheck.disabled=false;
		       alert("Rating still not done");
		       return false;
			  }
			  else
			  {
				  document.forms[0].docheck.disabled=true;
			  }
		  }
		  else
		  {
			  document.forms[0].docheck.disabled=true;
		  }
	  }	
	else
	{
		document.forms[0].docheck.disabled=true;
		
	}
	<%  if(strRatType.equalsIgnoreCase("1"))		  
	  {
		  if(strDataSecFlag.equalsIgnoreCase("N"))
		  {%>	
			alert("Please Enter The Securities Details in Security Master tab and check all the details");
      		return false;
		 <% }
	  }%>


	  if(document.forms[0].btnenable.value=="N")
	  {
		  document.forms[0].send.disabled=true;
		  document.forms[0].roiupdate.disabled=true;
		  document.forms[0].docheck.disabled=true;
		  document.forms[0].doundo.disabled=true;
	      disableCommandButtons(true, true, true, true, false); 
	  }

	  if(varMCLRTally=="N")
	  {
		alert("Please Fill Reference Rate tab for all the facilities");
	    document.forms[0].hidBeanId.value="facilities";	
		document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/facility_mclr.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	  }
}

function disableFields(bool) {
	for ( var i = 0; i < document.forms[0].elements.length; i++) {
		if (document.forms[0].elements[i].type == "select-one") {
			document.forms[0].elements[i].disabled = bool;
		}
		if (document.forms[0].elements[i].type == "text") {
			document.forms[0].elements[i].readOnly = bool;
		}
	}
}

function doEdit() {
	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
				if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")
						|| Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01")){%>
						
				 document.forms[0].<%=strName2%>.disabled=false;
				 <%}else{%>			 
	
				 document.forms[0].<%=strName2%>.readOnly=true;
			
			<%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

			 document.forms[0].<%=strName2%>.readOnly=false;
			
			<%}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){%>

			 document.forms[0].<%=strName2%>.disabled=false;
			
			<%}if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0")){%>
			
			 document.forms[0].<%=strName2%>.disabled=false;
			<%}
		}
		
	}%>
	
	disableCommandButtons(true, false, false, false, true);
	//document.forms[0].sel_facilitysno.disabled=false;
    <%if(strFinalFlag.equalsIgnoreCase("N")){%>
    document.forms[0].sel_corpbusinessid.disabled=false;
    document.forms[0].sel_curryear.disabled=false;
	<%}%>

}

function disableCommandButtons(cmdedit, cmdsave, cmdcancel, cmddelete, cmdclose) {
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}
function doSave() {

	/*if(document.forms[0].sel_facilitysno.value=="")
	{
      alert("Select Facility");
      document.forms[0].sel_facilitysno.focus();
      return false;
	}*/	
	<%if(strFinalFlag.equalsIgnoreCase("N")){ %>
	
	if(document.forms[0].sel_corpbusinessid.value=="")
	{
      alert("Select Business Rule");
      document.forms[0].sel_corpbusinessid.focus();
      return false;
	}	
	if(document.forms[0].sel_curryear.value=="")
	{
      alert("Select Current year");
      document.forms[0].sel_curryear.focus();
      return false;
	}	
	<%}%>
	disableFields(false);

	<%if(strFinalFlag.equalsIgnoreCase("Y")){ 
		
	  if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		String strName3="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			strName3="ratingdesc"+k;%>
			 if(document.forms[0].<%=strName2%>.value=="")
			 {
               alert("Please enter "+document.all.<%=strName3%>.innerHTML);
               document.forms[0].<%=strName2%>.focus();
               return false;
			 }			
			
		<%
			}		
	}}else if(strFinalFlag.equalsIgnoreCase("N")){
	  if(strRatType.equalsIgnoreCase("1"))		  
	  {
		  if(strDataSecFlag.equalsIgnoreCase("N"))
		  {
	%>
	  	
	  alert("Please Enter The Securities Details in Security Master tab and check all the details")
      return false;

	<%}}}%>
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comrating.jsp";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function doCancel() {
	if (ConfirmMsg('102')) {
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidBeanGetMethod.value = "getRetailrating";
		document.forms[0].action = appURL + "action/comrating.jsp";
		document.forms[0].submit();
	}
}
function doDelete() {
	if (ConfirmMsg('101')) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidBeanId.value = "perapplicant";
		document.forms[0].hidSourceUrl.value = "/action/comrating.jsp";
		document.forms[0].hidBeanGetMethod.value = "getRetailrating";
		document.forms[0].hidBeanMethod.value = "updateRetailRating";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
}
function doClose() {
	if (ConfirmMsg('100')) {
		window.close();
	}
}

function doSendApp()
{
	//document.forms[0].sel_facilitysno.disabled=false;
    <%if(strFinalFlag.equalsIgnoreCase("N")){%>
    if(document.forms[0].sel_curryear.value=="")
	{
      alert("Select Current year");
      doEdit();
      document.forms[0].sel_curryear.focus();
      return false;
	}
    document.forms[0].sel_corpbusinessid.disabled=false;
    document.forms[0].sel_curryear.disabled=false;
	<%}%>
	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
			if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")
					|| Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01"))
			{
			%>
			 document.forms[0].<%=strName2%>.disabled=false;
			 <%}else{%>			 

			 document.forms[0].<%=strName2%>.readOnly=true;
			
			<%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

			 document.forms[0].<%=strName2%>.readOnly=false;
		<%
			}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){%>

			 document.forms[0].<%=strName2%>.disabled=false;
			
			<%}
		}
		
	}%>
	if(varstrNonPoolEMptyRatingFlag=="Y")
	  {
	 document.forms[0].docheck.disabled=true;
     alert("Rating still not done");
     return false;
	  }
	if(varFreezePromoters=="N")
	  {
  		 alert("Coapplicant/Guarantor freeze not yet done. Please click on Freeze button in Coapplicant/Guarantor tab.");
  		 return false;
	  }
	if(varFreezeSecurity=="N")
	  {
  		 alert("Security freeze not yet done. Please click on Freeze button in Security Master -> Attached Securities tab");
  		 return false;
	  }
	if((varFinTally=="N"||varFinTally=="")&& document.forms[0].hidFinalFlag.value=="N")
	  {
  		 alert("Assets and Liabilities does not Tally. Cannot forward for Rating");
  		 return false;
	  }
	document.forms[0].send.disabled = true;
	document.forms[0].hidAction.value = "send";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comrating.jsp?sendButtonFlag=Y";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
	
}

function doUndoApp()
{
	//document.forms[0].sel_facilitysno.disabled=false;
    <%if(strFinalFlag.equalsIgnoreCase("N")){%>
    document.forms[0].sel_corpbusinessid.disabled=false;
    document.forms[0].sel_curryear.disabled=false;
	<%}%>
	<%if(arrRow!=null && arrRow.size()>0){
		String strName2="";
		for(int i=0;i<arrRow.size();i++)
		{
			int k=i+1;
			arrCol=(ArrayList)arrRow.get(i);
			strName2="txt_riskparam"+k;
			if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
			if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")
					|| Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0") || Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01"))
			{
			%>
			 document.forms[0].<%=strName2%>.disabled=false;
			 <%}else{%>			 

			 document.forms[0].<%=strName2%>.readOnly=true;
			
			<%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>

			 document.forms[0].<%=strName2%>.readOnly=false;
		<%
			}
		}
		
	}%>
	document.forms[0].hidAction.value = "undo";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comrating.jsp?sendButtonFlag=N";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
	
}
function callAmnt(val)
{


 alert(val);
	
}

function callKalyptoRating()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].action=appURL+"action/com_kalyptorating.jsp?hidBeanGetMethod=getcom_externalratingdata&appStatus="+document.forms[0].appstatus.value;
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callExternalRating()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].action=appURL+"action/com_externalrating.jsp?hidBeanGetMethod=getcom_externalratingdata";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function callRatingfac()
{
    //var fsno=document.forms[0].sel_facilitysno.value;    
    document.forms[0].hfacsno.value=fsno;
	document.forms[0].hidBeanId.value="perapplicant";	
	document.forms[0].hidBeanGetMethod.value="getRetailrating";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comrating.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
	
}

function goBusineeData()
{
         //var fsno=document.forms[0].sel_facilitysno.value;
         var fid=document.forms[0].sel_corpbusinessid.value; 
        //document.forms[0].hfacsno.value=fsno;
        document.forms[0].hbusid.value=fid;    
		document.forms[0].hidBeanId.value="perapplicant";	
		document.forms[0].hidBeanGetMethod.value="getRetailrating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comrating.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	
}
function doCheckResponse()
{
	disableFields(false);
	document.forms[0].hidAction.value = "check";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comrating.jsp?sendButtonFlag=N";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function doROIUpdate()
{
	document.forms[0].hidAction.value = "updateRoi";
	document.forms[0].hidBeanId.value = "perapplicant";
	document.forms[0].hidSourceUrl.value = "/action/comrating.jsp?strFromN=T";
	document.forms[0].hidBeanGetMethod.value = "getRetailrating";
	document.forms[0].hidBeanMethod.value = "updateRetailRating";
	document.forms[0].action = appURL + "controllerservlet";
	document.forms[0].submit();
}
function otherDetails()
{
	 document.forms[0].action=appURL+"action/comratingotherdetails.jsp";
	 document.forms[0].hidBeanId.value = "perapplicant";
	 document.forms[0].hidBeanGetMethod.value = "getotherratingParameters";
	 document.forms[0].submit();
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}

}
function scorecardDetails()
{
	 document.forms[0].action=appURL+"action/msmeScoreCard.jsp";
	 document.forms[0].hidBeanId.value = "MsmeDigitalAppInterface";
	 document.forms[0].hidBeanGetMethod.value = "getScorecardDetails";
	
	 document.forms[0].submit();
}
</script>
</div></div>
<form name="misdet" method="post" class="normal">
<%
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
class="outertable">
<tr>
	<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
		<jsp:param name="pageid" value="13" />
		<jsp:param name="subpageid" value="134" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
		<jsp:param name="ssitype" value="<%=strSSIType%>" />
	</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
	</td>
</tr>
</table>
<%}else{%>
<%if(strCategoryType.equalsIgnoreCase("CORP") || strCategoryType.equalsIgnoreCase("SME")|| strCategoryType.equalsIgnoreCase("AGR") ){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable"> 
			<tr> 
				<td valign="top" colSpan="5"> 
					<jsp:include page="../com/proposallinks.jsp" flush="true"> 
						<jsp:param name="pageid" value="21" /> 
						<jsp:param name="cattype" value="<%=strCategoryType%>" /> 
						<jsp:param name="ssitype" value="<%=strSSIType%>" /> 
					</jsp:include> 
				</td>
			</tr> 
		</table>
		<%}
 else if (strCategoryType.equalsIgnoreCase("SRE") || strCategoryType.equalsIgnoreCase("OPS") || strCategoryType.equals("STL")){ %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	    <tr> 
	      <td valign="top"> 
	        <jsp:include page="../share/applurllinkscom.jsp" flush="true">         
	        <jsp:param name="pageid" value="14" />
	        <jsp:param name="cattype" value="<%=strCategoryType%>" />
	        <jsp:param name="ssitype" value="<%=strSSIType%>" />
	        </jsp:include>
	      </td>
	    </tr>
  </table>
  <% }%>

<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Proposal -&gt; Rating </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Rating </td> 
		<%} %>		
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<br>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
    <tr> 
      <td >
         <table border="0" cellspacing="1" cellpadding="3" align="left" class="outertable" width="30%">
                <tr align="center">                
           <%if(!digiPrdType.equalsIgnoreCase("PC")){ %>
                   <td width="15%" class="sub_tab_active">Corporate Rating</td>
                 <%}%>
                
                   <td width="20%" align="center" class="sub_tab_inactive"><a
					href="javascript:otherDetails();"
					 
					onMouseOut="window.status='';return true;"
					onMouseOver="window.status='Applicant';return true;">
				
					Previous Rating </b></a></td>
				
					<%if(digiPrdType.equalsIgnoreCase("PC")){ %>
					 <b>
				<td width="15%" class="sub_tab_inactive"><a
                  href="javascript:scorecardDetails();"<b>
                  Digi Rating</b></a></td>
                  <%}%>
                  </tr>
              </table>
        </td>
    </tr>
  </table>
<br>
<table align="center" border="0" cellpadding="3" cellspacing="3" class="outertable" width="80%">
<tr>
	<td>
		<table align="center" border="0" cellpadding="2" cellspacing="0" class="outertable" width="90%">
				
				<tr><td colspan="3">&nbsp;</td></tr>			
				<%if(strFinalFlag.equalsIgnoreCase("N")){ %>				
				<tr>
				 <td align="center" nowrap="nowrap"  colspan="3">Select Business Rule&nbsp;<b><span class="mantatory">*</span></b>
				&nbsp;&nbsp;	<select name="sel_corpbusinessid" onchange="goBusineeData()">
				 	<option value="" selected>--Select--</option>
					<lapschoice:BusinessRuleTag apptype="1" page='app'/>		
				 </select>
				 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				 Select Current year&nbsp;<b><span class="mantatory">*</span></b>
				 &nbsp;&nbsp;<select name="sel_curryear">
				 <option value="" selected>--Select--</option>
					<laps:AgrFinancialYear appno='<%=Helper.correctNull((String)request.getParameter("appno"))%>' page="RP" />		
				 </select></td>
				</tr>
				<%} %>
				<tr><td colspan="3">&nbsp;</td></tr>
		</table>
		<table align="center" border="0" cellpadding="2" cellspacing="0" class="outertable border1" width="90%">
		<tr class="dataheader"> 		
		  <td align="center" width="5%"><b>S.No</b></td>		
		  <td align="center" width="35%"><b>Description</b></td>
		  <td align="center" width="50%"><b>Value</b></td>		
		</tr>
		   <%if(arrRow!=null && arrRow.size()>0){
			   String strName="";
			   String strName2="";
			   String strName3="";
			   String strcode = "";
			   int j=0;
			   String stValue="",strCIBIL="",strExisting="";;
			   for(int i=0;i<arrRow.size();i++)
			   {
				   arrCol=(ArrayList)arrRow.get(i);
				   int k=i+1;
				   strName="hid_riskparam"+k;
				   strName2="txt_riskparam"+k;
				   strName3="ratingdesc"+k;
				   j=Integer.parseInt(Helper.correctInt((String)arrCol.get(0)));
				   stValue="rskvalue"+j;
				   
					strcode = Helper.correctNull((String)arrCol.get(4));				   
				   
				   String apptype="";
				   if(strcode.equalsIgnoreCase("RE80_Counterparty_with_Credit History"))
				   {
					   if(strChekFlag.equalsIgnoreCase("N"))
					   		strCIBIL = Helper.correctNull((String)arrCol.get(3));
					   else if(strChekFlag.equalsIgnoreCase("Y"))
						   strCIBIL = Helper.correctNull((String)hshValues.get(stValue));
				   }
				   if(strcode.equalsIgnoreCase("RE82_Existing _Loan_ Account_ with_ Bank"))
					   strExisting = Helper.correctNull((String)arrCol.get(3));
				  
				   if(strcode.equalsIgnoreCase("RE25_Occupation_Grps_Individual"))
					   apptype = "155";
				   if(strcode.equalsIgnoreCase("RE85_CREDIT_HISTORY_OF _BORROWER"))
					   apptype = "156";
				   if(strcode.equalsIgnoreCase("RE40_Edu_qualification"))
					   apptype = "157";
				   if(strcode.equalsIgnoreCase("RE65_Stability_of_Income") || strcode.equalsIgnoreCase("RE31_Stability_of_income_indiv"))
					   apptype = "158";
				   if(strcode.equalsIgnoreCase("RE04_Literacy_Level"))
					   apptype = "159";
				   if(strcode.equalsIgnoreCase("RE06_Conduct_on_previous/existing_loan_Acc") && strExisting.equalsIgnoreCase("1"))
					   apptype = "160";
				   if(strcode.equalsIgnoreCase("RE06_Conduct_on_previous/existing_loan_Acc") && strExisting.equalsIgnoreCase("0"))
					   apptype = "161";
				   if(strcode.equalsIgnoreCase("RE11_Subsidy/othr_concessions_frm_Govt_avail"))
					   apptype = "162";
				   if(strcode.equalsIgnoreCase("RE14_Support_Price_Availibility"))
					   apptype = "163";
				   if(strcode.equalsIgnoreCase("RE15_App_of_Advan_Tech"))
					   apptype = "164";
				   if(strcode.equalsIgnoreCase("RE16_Avail_of_Insurn"))
					   apptype = "165";
				   if(strcode.equalsIgnoreCase("RE17_Type_of_Crop"))
					   apptype = "166";
				   if(strcode.equalsIgnoreCase("RE18_Cropping_Pattern"))
					   apptype = "167";
				   if(strcode.equalsIgnoreCase("RE19_Avail_of_Irrigation_Water"))
					   apptype = "168";
				   if(strcode.equalsIgnoreCase("RE20_Location_of_Farm"))
					   apptype = "169";
				   if(strcode.equalsIgnoreCase("RE32_Revenue_Growth_Non-individual"))
					   apptype = "170";
				   if(strcode.equalsIgnoreCase("RE35_Track_Record_non-indiv"))
					   apptype = "171";
				   if(strcode.equalsIgnoreCase("RE38_Age_of_the_Vehicle_only_for_4_wheelers"))
					   apptype = "172";
				   if(strcode.equalsIgnoreCase("RE46_Course_applied_for"))
					   apptype = "173";
				   if(strcode.equalsIgnoreCase("RE51_College_Ranking_(India)"))
					   apptype = "174";
				   if(strcode.equalsIgnoreCase("RE52_College_Ranking_(Abroad)"))
					   apptype = "175";
				   if(strcode.equalsIgnoreCase("RE59_Locality_whr_Property_is_located"))
					   apptype = "176";
				   if(strcode.equalsIgnoreCase("RE62_Stage_of_Construction"))
					   apptype = "177";
				   if(strcode.equalsIgnoreCase("RE68_Infrastructure_Facilities"))
					   apptype = "178";
				   if(strcode.equalsIgnoreCase("RE69_Vintage"))
					   apptype = "179";
				   if(strcode.equalsIgnoreCase("RE_Collateral_guarantor_required"))
					   apptype = "182";
			   %>
		   
			<tr class="datagrid"> 		
		  <td align="center" width="10%"><%=i+1%></td>		
		  <td align="left" width="30%"><span id="<%=strName3%>"><%=Helper.correctNull((String)arrCol.get(1))%></span>
		  <input type="hidden" name="<%=strName%>" value="<%=Helper.correctNull((String)arrCol.get(0))%>"/>
		  </td>
          <%if(strChekFlag.equalsIgnoreCase("N")){
        	  if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
        		  if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01"))
        		  {
        	  %>
        	    <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="1">Yes</option>
        	    <option value="0">No</option>
        	    </select></td>	
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="Forex">Forex</option>
        	    <option value="Other than Forex">Other than Forex</option>
        	    </select></td>
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0")){%>
        	    <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <%String apptypecon="29"; %>
        	     <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>        	    
        	     <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="30"; %>
        	    <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	     <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="181"; %>
        	    <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	     <%}else{%>        	  	 
		   <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50" class="finaclefieldsbgcolor"/></td>	
		  <%}}else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){
			  if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("SBACCOUN-01")||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("TERMDEPO-02")||Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("LOANOUTS-01")){%> 
    	      <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50" onkeypress="allowNumber(this);"/></td>
    	     <%}else{%> 
   	      <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)arrCol.get(3))%>" size="50"/></td>
 	     <%}} else if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){ %>
				  <td align="left"><select name="<%=strName2%>"><option value="0">--Select--</option><lapschoice:StaticDataNewTag apptype='<%=apptype%>' /></select></td>
				  <script language="JavaScript">
				  	document.forms[0].<%=strName2%>.value = "<%=Helper.correctNull((String)arrCol.get(3))%>";
				  </script>			  
				   <%}}else if(strChekFlag.equalsIgnoreCase("Y")){ 
					   if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("C")){
		         if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("EXISTING-01"))
        		  {
        	  %>
        	    <td align="center"><select name="<%=strName2%>" style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="1">Yes</option>
        	    <option value="0">No</option>
        	    </select></td>	
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Nature of Current Ratio_LCM")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	    <option value="">--Select--</option>
        	    <option value="Forex">Forex</option>
        	    <option value="Other than Forex">Other than Forex</option>
        	    </select></td>
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Loan_LCM_V2.0")){%>
        	    <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	        <%String apptypecon="29"; %>
        	     <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>        	    
        	     <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("INDUSTRY-01")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="30"; %>
        	     <option value="">---Select-----</option>                
                   <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	    <%}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Type of Business")){%>
        	     <td align="center"><select name="<%=strName2%>"  style=" width:40%">
        	     <%String apptypecon="181"; %>
        	    <option value="">---Select-----</option>                
                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
        	    </select></td>
        	     <%}else{%>	
		  
		  <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)hshValues.get(stValue))%>" size="50" class="finaclefieldsbgcolor"/></td>
		  <%}} else if (Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("E")){%>
		  <td align="left"><input type="text" name="<%=strName2%>" value="<%=Helper.correctNull((String)hshValues.get(stValue))%>" size="50"/></td>
		  <%} else if (Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("S")){%>
			  <td align="left"><select name="<%=strName2%>"><option value="0">--Select--</option><lapschoice:StaticDataNewTag apptype='<%=apptype%>' /></select></td>
			  <script language="JavaScript">
			  	document.forms[0].<%=strName2%>.value = "<%=Helper.correctNull((String)hshValues.get(stValue))%>";
			  </script>
		  
		<%} }%>
		</tr>
		<%}} %>
				
		<% if(arRatRow!=null)
		  {
			if(arRatRow.size()>0)
			{%>
			
			<tr class="dataheader">
			<td colspan="3"><b>List of the Ratings done by the Users</b></td>
			</tr>
				
				<%int count=0;
				for(int b=0;b<arRatRow.size();b++)
				{
				 arRatCol=(ArrayList)arRatRow.get(b);
		  		%>
		  		<tr class="datagrid">
		<td align="center"><%=++count%></td>
		<td align="left"><b>User ID:</b></td>
		<td align="left"><b><%=Helper.correctNull((String)arRatCol.get(2))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Score</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(0))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Weight</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(1))%></b></td>
		</tr>
		<tr class="datagrid">
		<td>&nbsp;</td>
		<td align="left">&nbsp;<b>Rating Done on</b></td>
		<td align="left">&nbsp;<b><%=Helper.correctNull((String)arRatCol.get(4))%></b></td>
		</tr>
		<%if(Helper.correctNull((String)arRatCol.get(3)).equalsIgnoreCase("N")){%>
			<tr class="datagrid">
			<td>&nbsp;</td>
			<td align="left">&nbsp;<b><span  class="mantatory">Status</span></b></td>
			<td align="left">&nbsp;<b><span  class="mantatory">Rejected</span></b></td>
			</tr>
			<tr class="datagrid">
			<td>&nbsp;</td>
			<td align="left">&nbsp;<b><span  class="mantatory">Reason for Rejection</span></b></td>
			<td align="left">&nbsp;<b><span  class="mantatory"><%=Helper.correctNull((String)arRatCol.get(5))%></span></b></td>
			</tr>
		<%} %>
		<%}}else{ %>
		<tr class="dataheader">
		<td colspan="3">&nbsp;</td>
		</tr>
		<tr class="datagrid">
		<td colspan="3" align="center"><font color="red"><b>None of the Users rated this Proposal</b></font></td>
		</tr>
		<%}}%>		
		</table>
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
  <table border="0" align="center">
  
   <tr>
   
    <td><input type="button" name="send" value="Send To Kalypto" class="buttonStyle" onclick="doSendApp()"></td>
    <td><input type="button" name="doundo" value="Undo" class="buttonStyle" onclick="doUndoApp()" ></td>
     <td><input type="button" name="docheck" value="Check for Response" class="buttonStyle" onclick="doCheckResponse()"></td>
      <td><input type="button" name="roiupdate" value="Update ROI" class="buttonStyle" onclick="doROIUpdate()"></td>
      </tr>
  
  </table>
  
  <table width="100%">
  
   <tr>
   
   <td align="center"><span class="mantatory">In case ROI is based on internal rating then click on "Update ROI" button in Rating Tab after receiving response from Kalypto,by each user</span></td>
      </tr>
  
  </table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidrowsize" value="<%=arSize%>">
<input type="hidden" name="hidModelCode" value="<%=Helper.correctNull((String)hshValues.get("strModelCode"))%>">
<input type="hidden" name="hfacsno">
<input type="hidden" name="hbusid">
<input type="hidden" name="hidBusiId" value="<%=Helper.correctNull((String)hshValues.get("RSK_RULE_ID"))%>">
<input type="hidden" name="hdCheckFlag" value="<%=strChekFlag%>">
<input type="hidden" name="hidFinalFlag" value="<%=strFinalFlag%>">
<input type="hidden" name="hidstrRatType" value="<%=strRatType%>">
</form>
</body>
</html>