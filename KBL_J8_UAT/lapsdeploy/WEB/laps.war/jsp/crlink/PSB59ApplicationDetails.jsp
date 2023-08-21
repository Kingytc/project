<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />        
<lapschoice:handleerror />
<%
String strCurrTabe= (String) session.getAttribute("CURRENT_TAB");
String strSegType= (String) session.getAttribute("SegType");
if(strSegType.equalsIgnoreCase("")){
	strSegType= (String) session.getAttribute("strSegType");	
}

String strPopSchemeId=Helper.correctNull((String)hshValues.get("POP_SCHEME_ID"));

if(strPopSchemeId.equalsIgnoreCase("")){
strPopSchemeId=(String) session.getAttribute("sessPopId");
}

//String strsessPopId= (String) session.getAttribute("sessPopId");

if(strPopSchemeId != "")
{
session.setAttribute("sessPopId",strPopSchemeId);
}
String strRefno=Helper.correctNull((String)hshValues.get("Refno"));

session.setAttribute("Refno",strRefno);
strRefno=(String) session.getAttribute("Refno");



%>

<html>
<head>
<title>National Portal - Application Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var segType="<%=strSegType%>";
var varPopSchemeId = "<%=strPopSchemeId%>";
var strRefno="<%=strRefno%>";
function onLoadPage()
{
	if(segType=="EDU" || segType=="HL")
	{
	gotoPage('PSB59ApplicantDetails.jsp');
	}

	if(segType=="LHD" || segType=="AGRI" || segType=="BS")
	{
	gotoPage('PSB59PersonalDetails.jsp');
	}
}

function gotoPage(pagename)
{
	
		if(pagename=="PSB59ApplicantDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
			document.forms[0].action = appURL+"action/psb59ApplicantDetails.jsp";
			document.forms[0].submit();
			
		}
		else if(pagename=="PSB59PersonalDetails.jsp")
		{

			if(segType == "LHD" && varPopSchemeId == "NULM")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getNULMPersonalDetails";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails.jsp";
			document.forms[0].submit();
			}
			else if(segType == "LHD" && varPopSchemeId == "NRLM")
			{
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_NRLM.jsp";
			document.forms[0].submit();
			}
			else if(segType == "BS" && varPopSchemeId == "SRMS")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_SRMS.jsp";
			document.forms[0].submit();
			}
			else if(segType == "AGRI")
			{	
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getAGRIPersonalDetails";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_Agri.jsp";
			document.forms[0].submit();
			}
			else if(segType == "BS" && varPopSchemeId == "PMMY")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusmudrapersdetails";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_Mudra.jsp";
			document.forms[0].submit();
			}
			else if(segType == "BS" && varPopSchemeId == "SWMS")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusSWMSpersonaldetails";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_SWMS.jsp";
			document.forms[0].submit();
			}
			else if(segType == "BS" && varPopSchemeId == "STD")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusstandindiapersonaldet";
			document.forms[0].action = appURL+"action/PSB59PersonalDetails_STANDUP.jsp";
			document.forms[0].submit();
			}
			
		}
		else if(pagename=="PSB59ProjectLoanDetails.jsp")
		{
			
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getAgriProjLoanDetails";
			document.forms[0].action = appURL+"action/PSB59ProjectLoanDetails.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59EduDetails.jsp")
		{			
			var hidValue = strRefno;			
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPSB59CourseDtls";
			document.forms[0].action = appURL+"action/psb59EduDetails.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59EmpDetails.jsp")
		{
			
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPSB59ApplicantListDtls";
			document.forms[0].action = appURL+"action/psb59EmpDetails.jsp";
			document.forms[0].submit();

		}
		else if(pagename=="PSB59FinDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getITRDETAILS";
			document.forms[0].action = appURL+"action/psb59FinDetails.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59DocDetails.jsp")
		{
			
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getDOCDETAILS";
			document.forms[0].action = appURL+"action/psb59DocDetails.jsp";
			document.forms[0].submit();

		}
		else if(pagename=="PSB59BREDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBREMATCHDETAILS";
			document.forms[0].action = appURL+"action/psb59BREDetails.jsp";
			document.forms[0].submit();
			
		}
		else if(pagename=="PSB59InPrinciDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="PSB59getPrincipleDetailsList";
			document.forms[0].action = appURL+"action/psb59InPrinciDetails.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59PropertyDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getPropertyDetails";
			document.forms[0].action = appURL+"action/PSB59PropertyDetails.jsp";
			document.forms[0].submit();
		}
	    else if(pagename=="PSB59BankDetails.jsp")
		{
	    	var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBankDetails";
			document.forms[0].action = appURL+"action/PSB59BankDetails.jsp";
			document.forms[0].submit();
		}
	    else if(pagename=="PSB59LoanDetails.jsp")
		{			
			if(segType == "LHD" && varPopSchemeId == "NULM")
			{
	    	var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getNULMLoanDetails";
			document.forms[0].action = appURL+"action/PSB59LoanDetails_NULM.jsp";
			document.forms[0].submit();
			}
	    	else if(segType == "LHD" && varPopSchemeId == "NRLM")
   			{
   			document.forms[0].action = appURL+"action/PSB59LoanDetails_NRLM.jsp";
   			document.forms[0].submit();
   			}
	    	else if(segType == "BS" && varPopSchemeId == "SRMS")
   			{
	    	var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
	    	document.forms[0].hidBeanId.value="NationalPortal";
		 	document.forms[0].hidBeanGetMethod.value="getBusSWMSloandetails";
   			document.forms[0].action = appURL+"action/PSB59LoanDetails_SRMS.jsp";
   			document.forms[0].submit();
   			}
	    	else if(segType == "BS" && varPopSchemeId == "SWMS")
			{
    		var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusSWMSloandetails";
			document.forms[0].action = appURL+"action/PSB59LoanDetails_SWMS.jsp";
			document.forms[0].submit();
			}
	    	else if(segType == "BS" && varPopSchemeId == "PMMY")
			{
    		var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusMudraloandetails";
			document.forms[0].action = appURL+"action/PSB59LoanDetails_Mudra.jsp";
			document.forms[0].submit();
			}
	    	else if(segType == "BS" && varPopSchemeId == "STD")
			{
    		var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusstandindialoandet";
			document.forms[0].action = appURL+"action/PSB59LoanDetails.jsp";
			document.forms[0].submit();
			}
		}
		else if(pagename=="PSB59ScoreDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getScoringDetails";
			document.forms[0].action = appURL+"action/PSB59ScoreDetails.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59EligibiltyDetails.jsp")
		{
			if(segType == "HL" || segType == "AGRI" || segType == "EDU")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBasicEligibilityDetails";
			document.forms[0].action = appURL+"action/PSB59EligibiltyDetails.jsp";
			document.forms[0].submit();
			}
			else if(segType == "BS")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBasicEligibilityDetails";
			document.forms[0].action = appURL+"action/PSB59EligibilityPrdDetails_SWMS.jsp";
			document.forms[0].submit();
			}
			else if(segType == "LHD")
			{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBasicEligibilityDetails";
			document.forms[0].action = appURL+"action/PSB59EligibilityPrdDetails.jsp";
			document.forms[0].submit();
			}
		}
		else if(pagename=="PSB59AssoConcern.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getAssoConcernDetails";
			document.forms[0].action = appURL+"action/PSB59AssoConcern.jsp";
			document.forms[0].submit();
		}
		else if(pagename=="PSB59GSTDetails.jsp")
		{
			var hidValue = strRefno;
			document.forms[0].hidApplicantId.value = hidValue;
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidBeanGetMethod.value="getBusmudragstdetails";
			document.forms[0].action = appURL+"action/PSB59GSTDetails.jsp";
			document.forms[0].submit();
		}
		else
		{
          return false;
		}
}
</script>
<style type="text/css">

</style>
 
</head>
<body onload=onLoadPage();>
<form name="" method="post"> 
 <table width="88%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tbody>
		<tr class="" >
		    <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("HL")){%>
		    <%if(strCurrTabe.equalsIgnoreCase("APPLICANT_DETAILS")){%>
		    <td width="4%" class="main_tab_active" align="center" nowrap>  
		     <b><a href="javascript:gotoPage('PSB59ApplicantDetails.jsp')" class="bluefont">Applicants Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59ApplicantDetails.jsp')" class="bluefont">Applicants Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI") || strSegType.equalsIgnoreCase("BS")){%>
            <%if(strCurrTabe.equalsIgnoreCase("PERSONAL_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		     <b><a href="javascript:gotoPage('PSB59PersonalDetails.jsp')" class="bluefont">Personal Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59PersonalDetails.jsp')" class="bluefont">Personal Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("AGRI")){%>
            <%if(strCurrTabe.equalsIgnoreCase("PROJLOAN_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		     <b><a href="javascript:gotoPage('PSB59ProjectLoanDetails.jsp')" class="bluefont">Project and Loan Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59ProjectLoanDetails.jsp')" class="bluefont">Project and Loan Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU")){%>
            <%if(strCurrTabe.equalsIgnoreCase("EMP_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59EmpDetails.jsp')" class="bluefont">Employment Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59EmpDetails.jsp')" class="bluefont">Employment Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("HL") || (strSegType.equalsIgnoreCase("LHD") && strPopSchemeId.equalsIgnoreCase("SRMS"))){%>
            <%if(strCurrTabe.equalsIgnoreCase("FINANCIAL_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59FinDetails.jsp')" class="bluefont">Financial & ITR Details</a></b></font>
            </font> </td>
            <%}else{ %>
             <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59FinDetails.jsp')" class="bluefont">Financial & ITR Details</a></b></font>
            </td>
            <%}}%>          
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("BS") || strSegType.equalsIgnoreCase("HL") || strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI")){%>
            <%if(strCurrTabe.equalsIgnoreCase("DOC_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59DocDetails.jsp')" class="bluefont">Documents</a></b></font>
            </font> </td>
            <%}else{ %>
             <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59DocDetails.jsp')" class="bluefont">Documents</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU")){%>
            <%if(strCurrTabe.equalsIgnoreCase("EDU_DETAILS")){%>
            <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> 
		     <b><a href="javascript:gotoPage('PSB59EduDetails.jsp')" class="bluefont">Education / Course Details</a></b></font>
            </td>
            <tr></tr>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
            <b><a href="javascript:gotoPage('PSB59EduDetails.jsp')" class="bluefont">Education / Course Details</a></b></font>
            </td>
            <tr></tr>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("BS") || strSegType.equalsIgnoreCase("HL") || strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI")){%>
            <%if(strCurrTabe.equalsIgnoreCase("BRE_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59BREDetails.jsp')" class="bluefont">BRE Match Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59BREDetails.jsp')" class="bluefont">BRE Match Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("BS") || strSegType.equalsIgnoreCase("HL") || strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI")){%>
            <%if(strCurrTabe.equalsIgnoreCase("INPRINCIPLE_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59InPrinciDetails.jsp')" class="bluefont">In-Principle Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59InPrinciDetails.jsp')" class="bluefont">In-Principle Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("HL")){%>
            <%if(strCurrTabe.equalsIgnoreCase("PROPERTY_DETAILS")){%>
            <td width="4%" class="tabactive" align="center" nowrap> <font color="#FFFFFF"> 
		    <b><a href="javascript:gotoPage('PSB59PropertyDetails.jsp')" class="bluefont">Property Details</a></b></font>
            </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="unnamed1"> 
            <b><a href="javascript:gotoPage('PSB59PropertyDetails.jsp')" class="bluefont">Property Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU")|| strSegType.equalsIgnoreCase("HL") || (strSegType.equalsIgnoreCase("LHD") && strPopSchemeId.equalsIgnoreCase("NULM")) || strSegType.equalsIgnoreCase("AGRI") || strSegType.equalsIgnoreCase("BS")){%>
            <%if(strCurrTabe.equalsIgnoreCase("BANK_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59BankDetails.jsp')" class="bluefont">Bank Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59BankDetails.jsp')" class="bluefont">Bank Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("BS")){%>
            <%if(strCurrTabe.equalsIgnoreCase("LOAN_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59LoanDetails.jsp')" class="bluefont">Loan Details</a></b></font>
            </font> </td>
            <%}else{ %>
            
          	<td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59LoanDetails.jsp')" class="bluefont">Loan Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("HL") || strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI") || strSegType.equalsIgnoreCase("BS")){%>
            <%if(strCurrTabe.equalsIgnoreCase("SCASCO_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59ScoreDetails.jsp')" class="bluefont">Scoring & Scaling Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59ScoreDetails.jsp')" class="bluefont">Scoring & Scaling Details</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("EDU") || strSegType.equalsIgnoreCase("HL") || strSegType.equalsIgnoreCase("LHD") || strSegType.equalsIgnoreCase("AGRI") || strSegType.equalsIgnoreCase("BS")){%>
            <%if(strCurrTabe.equalsIgnoreCase("ELIGIBILITY_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		    <b><a href="javascript:gotoPage('PSB59EligibiltyDetails.jsp')" class="bluefont">Eligibility Details</a></b></font>
            </font> </td>		
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59EligibiltyDetails.jsp')" class="bluefont">Eligibility Details</a></b></font>
            </td>	
            <%}}%>	
            
            <%if((strSegType.equalsIgnoreCase("BS") && strPopSchemeId.equalsIgnoreCase("PMMY")) || (strSegType.equalsIgnoreCase("BS") && strPopSchemeId.equalsIgnoreCase("STD"))){%>
            <%if(strCurrTabe.equalsIgnoreCase("ASSOCON_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		     <b><a href="javascript:gotoPage('PSB59AssoConcern.jsp')" class="bluefont">Associate Concern</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59AssoConcern.jsp')" class="bluefont">Associate Concern</a></b></font>
            </td>
            <%}}%>
            
            <%if(strSegType.equalsIgnoreCase("BS") && strPopSchemeId.equalsIgnoreCase("PMMY")){%>
            <%if(strCurrTabe.equalsIgnoreCase("GST_DETAILS")){%>
            <td width="4%" class="main_tab_active" align="center" nowrap>  
		     <b><a href="javascript:gotoPage('PSB59GSTDetails.jsp')" class="bluefont">GST Details</a></b></font>
            </font> </td>
            <%}else{ %>
            <td width="4%" align="center" nowrap> <font color="#000000" class="main_tab_inactive"> 
            <b><a href="javascript:gotoPage('PSB59GSTDetails.jsp')" class="bluefont">GST Details</a></b></font>
            </td>
            <%}}%>
			</tr>						
	</tbody>
</table>
  <input type="hidden" name="hidBeanId" value="">
    <input type="hidden" name="hidBeanGetMethod" value="">
    <input type="hidden" name="hidBeanMethod" value="">
    <input type="hidden" name="hidApplicantId" value="">
</form>								
</body>
</html>