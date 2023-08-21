<%@include file="../share/directives.jsp"%>
<%String strProfilestatus=Helper.correctNull((String)hshValues.get("strProfilestatus"));
String tempProfile="";
if(strProfilestatus.equalsIgnoreCase("Y"))
{
	tempProfile="Completed";
}
else
{
	tempProfile=" Not Completed";
}
String strModuleName=Helper.correctNull(request.getParameter("hidModuleName"));
if (strCategoryType.equals("")) {
	strCategoryType = Helper.correctNull((String) hshValues.get("categorytype"));
}
String strhidfacilities=Helper.correctNull((String)request.getParameter("hidfacilities"));%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/perapplicantdispco.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var strapplnt="<%=request.getParameter("applnt")%>";
var strapplntvalue = "Applicant/ Guarantor";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var id="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>";
var varSex="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varMstatus="<%=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>";
var varEmployed="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var varedu = "<%=Helper.correctNull((String)hshValues.get("perapp_education"))%>";
var varbank = "<%=Helper.correctNull((String)hshValues.get("perapp_bank"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varcat = "<%=Helper.correctNull((String)hshValues.get("perapp_category"))%>";
var yearsinadd = "<%=Helper.correctNull((String)hshValues.get("perapp_yrsinpresadd"))%>";
var bobstaff = "<%=Helper.correctNull((String)hshValues.get("perapp_buss"))%>";
var typeofprof = "<%=Helper.correctNull((String)hshValues.get("perapp_typeofprof"))%>";
var varrelg="<%=Helper.correctNull((String)hshValues.get("perapp_religion"))%>";
var varreligion= "<%=Helper.correctNull((String)hshValues.get("perapp_minority"))%>";
var varOccuCat="<%=Helper.correctNull((String)hshValues.get("perapp_eduothers"))%>";
var perapp_banksince="<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%>";
var varstatus= "<%=Helper.correctNull((String)hshValues.get("perapp_status"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function callLoad()
{
	callonLoad();
	document.forms[0].txtperapp_apptitle.disabled=true;
	document.forms[0].hidDemoId.disabled=false;
	if(id!="")
	{
		document.forms[0].hidDemoId.value=id;
	}
}

function showDemographics()
{
	if(document.forms[0].hidDemoId.value!="")
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].action=appURL+"action/ops_applicantdisp.jsp";
		document.forms[0].hidBeanGetMethod.value="getDemographics";			
		document.forms[0].method="post";
		document.forms[0].hidAppType.value="";
		document.forms[0].submit();
	}
}

function callIncomeExpenses()
{
	if(document.forms[0].hidDemoId.value=="")
	{
		alert("Select "+strapplntvalue);
		return;
	}
	var applnt = document.forms[0].applntype.value;
	if(isNaN(document.forms[0].txtperapp_appid.value))
	{
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpensesdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}

function callEmployer()
{
	if(document.forms[0].hidDemoId.value=="")
	{
		alert("Select "+strapplntvalue);
		return;
	}
	var applnt = document.forms[0].applntype.value;
	if(isNaN(document.forms[0].txtperapp_appid.value))
	{

	}
	else
	{
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployerdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}

function callKYCNorms()
{
	if(document.forms[0].hidDemoId.value=="")
	{
		alert("Select "+strapplntvalue);
		return;
	}
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
		document.forms[0].action=appURL+"action/perkycnormsdisp.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="callLoad();enableSince();getlocationvalues();showres();showcoun();shownri();showStaffBox();">
<form name="appform" method="post" class="normal">
  <%if(strhidfacilities.equalsIgnoreCase("fac")){ %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
        <td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
      </tr>
      <tr>
      	<td class="page_flow">Home -&gt; Tertiary-&gt; Application-&gt; Facilities-&gt;  Customer Profile</td>
      </tr>
     </table>    
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
        <td> 
          <table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
            <tr align="center"> 
            		<td class="sub_tab_inactive"><b><a href="javascript:callApplicantTab('facilities')">Facilities</a></b></td>
					<td class="sub_tab_inactive"><a href="javascript:callApplicantTab('subsidy')" ><b>Subsidy </b></a></td>					
					<td class="sub_tab_active"><b>Customer Profile</b></td>	
					<td class="sub_tab_inactive"><a href="javascript:callApplicantTab('ops_incomeexpenses')" ><b>Income & Expenses </b></a></td>
					<td class="sub_tab_inactive"><a href="javascript:callApplicantTab('ops_employment')" ><b>Subsidy </b></a></td>	             
            </tr>
          </table>
        </td>
      </tr>
    </table>
   <%}else { %> 
   <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
        <td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
      </tr>
      <tr><td class="page_flow">
      Home -&gt; Tertiary-&gt;Application-&gt; Promoters-&gt;  Demographics</td>
      </tr></table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
 						<lapschoice:TerPromoterTag pageid="2"/>					
   <%} %>  
  <table width="99%" border="1" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="14%">Select  Applicant/ Guarantor</td>
            <td colspan="2"> 
              <select name="hidDemoId" onChange="showDemographics()">
                <option selected value="">&lt;--Select--&gt;</option>
				  <lapschoice:tertiarypromoter/> 
              </select>
            </td>
            <td width="23%">&nbsp;</td>
            <td width="21%">&nbsp;</td>
          </tr>
        </table>
      </td>
   </tr>
    </table>
        <table width="99%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                <tr> 
                  <td valign="top" colspan="4"> 
                    
                      <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                        <tr> 
                          <td valign="top"> 
                          <script>
                          var coflag=1;
                          </script>
                          <%@include file="../per/per_commoncustdemographics.jsp"%>
                          </td>
                          </tr>
  			 </table>
  			 </td>
  			 </tr>
  			 </table>
  			 </td>
  			 </tr>
  			 </table>  			 
 <lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <INPUT TYPE="hidden" name="hidApp_type" value='A'>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
   <INPUT TYPE="hidden" name="page" value="ep">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <INPUT TYPE="hidden" name="hidAppType">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">
  <INPUT TYPE="hidden" name="applntype" value="<%=(String)request.getParameter("applnt")%>" >
   <input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
  <input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>"> 
  <input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
  <input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
  <input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>">
  <input type="button" name="cmdsave" value="Save" style="visibility:hidden" disabled>
  <input type="hidden" name="cmdmodify">
  <input type="hidden" name="cmdNridetails">
  <input type="hidden" name="cmdedit">
  <input type="hidden" name="cmddelete">
  <input type="hidden" name="cmdcancel">
   </form>
</body>
</html>
 