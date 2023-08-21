<%@include file="../share/directives.jsp"%>


<%
	String empdet = Helper.correctNull((String) hshValues
			.get("peremploy"));
	String strProfilestatus = Helper.correctNull((String) hshValues
			.get("strProfilestatus"));
	String strModuleName = Helper.correctNull(request
			.getParameter("hidModuleName"));
	String strModName = "";
	if (strModuleName.equalsIgnoreCase("T")) {
		strModName = "Tertiary";
	} else if (strModuleName.equalsIgnoreCase("P")) {
		strModName = "Retail";
	} else {
		strModName = "Corporate & SME";
	}
	String strCattype = Helper.correctNull(request
			.getParameter("hidCategoryType"));
	String strappname = Helper.correctNull((String) request
			.getParameter("txtperapp_fname"));
	if (strappname.equals("")) {
		strappname = Helper.correctNull((String) request
				.getParameter("hidapp_name"));
	}
	String strSelConfEmp=Helper.correctNull((String) hshValues
			.get("peremp_confemp"));
	String strSelIncSource=Helper.correctNull((String) hshValues.get("PEREMP_INCSOURCE"));
	String strSelListComp=Helper.correctNull((String) hshValues
			.get("peremp_listcomp"));
	String strSelDeal=Helper.correctNull((String) hshValues
			.get("peremp_dealing"));
	String strEmployment=(String)session.getAttribute("strEmployment");
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));
	
	String pageid = request.getParameter("pageid");
	String strapptype = Helper.correctNull((String)request.getParameter("corp"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<script>var busowned="<%=Helper.correctNull((String) hshValues
							.get("peremp_busowned"))%>";</script>
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/peremployer.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var value1="<%=Helper.correctNull((String) hshValues.get("perinc_id"))%>";
var peremp_servleft="<%=Helper.correctNull((String) hshValues
							.get("peremp_servleft"))%>";
var varemploy = "<%=Helper.correctNull((String) hshValues.get("peremploy"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var Category = "<%=Helper.correctNull((String) hshValues
							.get("peremp_category"))%>";
var buspremises ="<%=Helper.correctNull((String) hshValues
									.get("peremp_lease"))%>";
var varOccupation="<%=Helper.correctNull((String) hshValues
							.get("peremp_occupation"))%>";
var varStaff="<%=Helper.correctNull((String) hshValues
							.get("perapp_istaff"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues
							.get("recordflag"))%>";
var varRecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var VARSALARYROUTED="<%=Helper.correctNull((String)hshValues.get("PEREMP_SALARYROUTED"))%>";

function dateDOB1Check()
{
	var mycurrdate1 = new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));	
	var retdate =  document.forms[0].txtperemp_retdate.value;
	var mycurrdate = new Date(retdate.substring(6,10),retdate.substring(3,5)-1,retdate.substring(0,2));	
	var dd=mycurrdate.getYear();
	var retmonth = mycurrdate.getMonth();
 	var DOB =  document.forms[0].txtperemp_dob.value;
  	var dobyear=mycurrdate1.getYear();
  	var curmonth = mycurrdate1.getMonth();
  	var retyear=retdate.substring(6,10);
  	if(retdate!="")
  	{
	   	if(curmonth>=retmonth)
	  	{
		  	var serv_month= curmonth-retmonth;
		  	document.forms[0].txt_servicemonths.value=serv_month;
		  	var serv_left=dd-dobyear;
		  	document.forms[0].txtserviceleft.value=serv_left;
	  	}
	  	else if (curmonth<=retmonth)
	  	{
	  		var serv_month= retmonth-curmonth;
		  	document.forms[0].txt_servicemonths.value=serv_month;
		  	var serv_left=dd-dobyear;
		  	document.forms[0].txtserviceleft.value=serv_left;
	  	}
  	}
}
function retireDobCheck()
{

  var sandate=document.forms[0].txtperemp_dob.value;
  var duedate=document.forms[0].txtperemp_retdate.value;

  var S_Date=sandate.substring(0,2);
  var S_Month=sandate.substring(3,5);
  var S_Year=sandate.substring(6,10);

  var D_Date=duedate.substring(0,2);
  var D_Month=duedate.substring(3,5);
  var D_Year=duedate.substring(6,10);


  if(duedate!= "")
  {

  if(D_Year<S_Year)
  {
	   alert("Retirement Date cannot be less than or equal to Date of Birth");
	   document.forms[0].txtperemp_retdate.value="";
	   document.forms[0].txtperemp_retdate.focus();
	   return;
  }
  else if(D_Year==S_Year)
  {
	  if(D_Month<S_Month)
	  {
		   alert("Retirement Date cannot be less than or equal to Date of Birth");
		   document.forms[0].txtperemp_retdate.value="";
		   document.forms[0].txtperemp_retdate.focus();
		   return;
	  }
	  else if(D_Month==S_Month)
	  {
		  if(D_Date<=S_Date)
		  {
			   alert("Retirement Date cannot be less than or equal to Date of Birth");
			   document.forms[0].txtperemp_retdate.value="";
			   document.forms[0].txtperemp_retdate.focus();
			   return;
		  }
	  }
  }
  }
}
function calyearsofserviceleft()
{
	var mycurrentdate=new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));
	var retdate=document.forms[0].txtperemp_retdate.value;
	var retiredate=new Date(retdate.substring(6,10),retdate.substring(3,5)-1,retdate.substring(0,2));
	var retyear=retiredate.getYear();
	var curryear=mycurrentdate.getYear();
	var retmonth=retiredate.getMonth();
	var currmonth=mycurrentdate.getMonth();
	
	if(parseInt(retyear)<parseInt(curryear))
	{
		document.forms[0].txt_servicemonths.value="0";
		document.forms[0].txtserviceleft.value="0";
	}
	else if(parseInt(retyear)>parseInt(curryear))
	{
		if(retmonth>currmonth)
		{
			var serv_month=retmonth-currmonth;
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=retyear-curryear;
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else if(retmonth < currmonth)
		{
			var serv_month=parseInt(retmonth)+12-parseInt(currmonth);
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=parseInt(retyear)-1-parseInt(curryear);
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else
		{
			if(parseInt(retdate.substring(0,2))>=parseInt(currdate.substring(0,2)))
			{
				var serv_month=retmonth-currmonth;
	  			document.forms[0].txt_servicemonths.value=serv_month;
	  			var serv_left=retyear-curryear;
	  			document.forms[0].txtserviceleft.value=serv_left;
			}
			else
			{
				var serv_month=retmonth-currmonth+11;
	  			document.forms[0].txt_servicemonths.value=serv_month;
	  			var serv_left=retyear-1-curryear;
	  			document.forms[0].txtserviceleft.value=serv_left;
			}
		}
	}
	else if(parseInt(retyear)==parseInt(curryear))
	{
		if(retmonth>=currmonth)
		{
			var serv_month=retmonth-currmonth;
	  		document.forms[0].txt_servicemonths.value=serv_month;
	  		var serv_left=retyear-curryear;
	  		document.forms[0].txtserviceleft.value=serv_left;
		}
		else
		{
			document.forms[0].txt_servicemonths.value="0";
			document.forms[0].txtserviceleft.value="0";
		}
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{	
	varemp = "EMPL";
	if(document.forms[0].cmdsave.disabled==false)	
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&employer="+varemp;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function callCalender(fieldname)
{
	if(document.forms[0].cmdsave.disabled==false)	
	{
		showCal(appURL,fieldname);
	}
}

function winopenlegalheirs()
{
	var purl = appURL+"action/per_legalheirs.jsp?hidBeanGetMethod=getDataIns&hidBeanId=insreport&appno="+document.forms[0].hidDemoId.value;
	prop = "scrollbars=yes,width=750,height=550,statusbar=yes,menubar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 650) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var title = "Print";	
	window.open(purl,title,prop);
}

function callsupnam1()
{
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=appURL+"action/occupationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getOccupationMasterList&strfrom=Employer";
	window.open(url,"",prop);
}

function callsupnam2()
{
	if(document.forms[0].cmdsave.disabled==false)	
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/companymastlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getCompanyMasterList&strfrom=CompanyMaster1";
		window.open(url,"",prop);
	}
}

function callsupnam()
{	
	if(document.forms[0].cmdsave.disabled==false)	
	{
		var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/designationlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getDesignationMasterList&strfrom=Employer";
		window.open(url,"",prop);	
	}
}

function GetYearsleft()
{
	var month=document.forms[0].txt_servicemonths.value;
	var year=document.forms[0].txtserviceleft.value;
	var monthvalue;
	var monthvalue1;
	var yearvalue;
	if(month>12)
	{
		monthvalue=month/12;		
		yearvalue=parseFloat(year)+parseFloat(monthvalue);
		document.forms[0].txtserviceleft.value=yearvalue;
		monthvalue="";
		monthvalue1=month%12;
		document.forms[0].txt_servicemonths.value=monthvalue1;
		
	}
	if(month==12)
	{
		monthvalue=month/12;		
		yearvalue=parseFloat(year)+parseFloat(monthvalue);
		document.forms[0].txtserviceleft.value=Math.round(yearvalue);
		monthvalue="";
		monthvalue=month%12;
		document.forms[0].txt_servicemonths.value=Math.round(monthvalue);
	}
}



function min_nos(obj,no)
{
	
	var min_len=obj.value.length;
	if(obj.value!=""){
		if(min_len<eval(no))
		{
			alert("Enter all "+no+" digits");
			obj.value="";
			obj.focus();
		}
	}
}
function onloading()
{
	var varConfEmp='<%=strSelConfEmp%>';
	var varListcomp='<%=strSelListComp%>';
	var varIncSrc='<%=strSelIncSource%>';
	var varDeal='<%=strSelDeal%>';
	if(varConfEmp == "")
		document.forms[0].sel_confemp.value="0";
	else
		document.forms[0].sel_confemp.value=varConfEmp;
	if(varListcomp == "")
		document.forms[0].sel_listcom.value="0";
	else
		document.forms[0].sel_listcom.value=varListcomp;

	if(varIncSrc == "")
		document.forms[0].sel_empsource.value="0";
	else
		document.forms[0].sel_empsource.value=varIncSrc;

	if(VARSALARYROUTED!="")
	{
		document.forms[0].sel_salrouted.value=VARSALARYROUTED;
	}
	else
	{
		document.forms[0].sel_salrouted.value="S";
	}
	if(varemploy=="1" || varemploy=="9")
	{
		if(varListcomp=="2")
		{
			document.all.id_empdeal.style.visibility="visible";
			document.all.id_empdeal.style.position="relative";
			document.forms[0].sel_empdeal.value=varDeal;
		}
		else
		{
			document.all.id_empdeal.style.visibility="hidden";
			document.all.id_empdeal.style.position="absolute";
		}
		document.forms[0].sel_empdeal.value=varDeal;
		if(varDeal=="1")
		{
			document.all.id_noofyrs.style.visibility="visible";
			document.all.id_noofyrs.style.position="relative";
		}
		else
		{
			document.all.id_noofyrs.style.visibility="hidden";
			document.all.id_noofyrs.style.position="absolute";
		}
	}
	else
	{
		//No Function
	}
	if(varemploy=="1")
	{
		document.all.idsal.style.display="table-row";
	}

	if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,false);
	}
	else
	{
	
		if(appstatus=="true")
		{
			disableControls(true,true,true,false);
		}
		else
		{
			disableControls(false,true,true,false);	
		}
	}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body text="#000000" vlink="#330000" alink="#330000" leftmargin="0"
	topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad();onloading();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="appform" method="post" class="normal"
	action="newapplicantDBase.jsp">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt; Employment Details</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td id="hyperlnk3">
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="5" />
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
		</jsp:include></td>
	</tr>
		</table>
		</td>
	</tr>
</table >
<% } else {  %>

<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="25" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="25"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="25"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if (!strCategoryType.equalsIgnoreCase("OPS")) { %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;
		<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		Agriculture -&gt;
		<%}else{%>
		Corporate &amp; SME -&gt;
		<%} %>
		
		 Application -&gt; Applicant-&gt; customer profile -&gt; Employment details</td>
	</tr>
  </table>
  
  
  <% } else if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
  <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkerdigi.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; 
      	Digi Retail  -&gt; Application -&gt; Applicant/Guarantor
		-&gt; Employment Details</td>
	</tr>
</table>
<%}else if(strapptype.equalsIgnoreCase("R")){ %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="<%=pageid%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; 
<%  if(strCategoryType.equals("AGR")){ %>Agriculture <% }
	else if(strCategoryType.equals("LAD"))
	{
	%> Loan Against Gold Ornaments &amp; Deposits  
	<%} 
     else { %> Retail(including schematic) <%} %> -&gt; Application -&gt; Applicant/Guarantor
		-&gt; Employment Details</td>
	</tr>
</table>
<%} %>
<lapschoice:application />
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">			
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%} if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="25"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table><%} %>
<%} else if (strCategoryType.equalsIgnoreCase("OPS")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="25" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Application -&gt; Promoter -&gt; Employment</td></tr></table>
<span style="display:none"><lapschoice:borrowertype /></span><lapschoice:application />
<lapschoice:TerPromoterTag pageid="4" />
<%}} %>

<% }  %>

<table  width="95%" border="0" cellpadding="2" cellspacing="5"
	class="outertable border1">
	<tr>
	<td valign="top" >
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable">
		<tr>
			<td> <%
 	if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
 %> Current Employment Details <%
 	} else {
 %> Self Employment Details <%
 	}
 %> </td>
			</tr>
			<tr>
			</tr>
		</table>
		</td>
	</tr>
	<br></br>
	<tr>
	<td>
		<table  width="100%" border="0" cellpadding="2" cellspacing="5" class="outertable">
			<tr>
				<td width="40%">
					<table  width="100%" border="0" cellpadding="2" cellspacing="5" class="outertable">
				<tr>
					<td width="4%" nowrap> <%
 					if (empdet.equalsIgnoreCase("1") && !empdet.equalsIgnoreCase("9")) {
 				%> Employer Name  <%
 				} else {
 			%> Company Name <%
 				}
 					%> <span class="mantatory" id="empname">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_name"
									maxlength="100" size="40"
									value="<%=Helper.correctNull((String) hshValues
									.get("peremp_name"))%>"
									onKeyPress="notAllowSingleQuote()" tabindex="1"> <input
									type="hidden" name="txtperemp_name1" size="15" maxlength="20"
									value="<%=Helper.correctNull((String) hshValues
									.get("company_name"))%>"
									onKeyPress="allowAlphabets()">
									<span onClick="callsupnam2()"
									style="cursor: hand"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="2"></span>
					</td>
									
				</tr>
				<tr>
					<td width="4%">Address <span class="mantatory" id="add">*&nbsp;</span></td>
					<td width="30%"><input type="text" name="txtperemp_address1"
							size="30" maxlength="50" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_address1"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
				<td width="4%">&nbsp;</td>
				<td width="30%"><input type="text" name="txtperemp_address2"
							size="30" maxlength="25" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_address2"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
					<td width="4%">Village / Taluk</td>
					<td width="30%"><input type="text" name="txtperemp_address3"
							size="30" maxlength="50" tabindex="5"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_address3"))%>"
							onKeyPress="notAllowedDouble()"></td>
				</tr>
				<tr>
					<td width="4%">City<span class="mantatory" id="city">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_city" size="30"
									maxlength="20"
									value="<%=Helper.correctNull((String) hshValues
									.get("peremp_city"))%>"
									onKeyPress="notAllowSplChar()"> <a href="#"
									onClick="showCitySearch('txtperemp_city','txtperemp_state','hidcity','hidstate','txtperemp_zip','hidzip')"
									style="cursor: hand"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="6"></a></td>
				</tr>
				<tr>
					<td width="4%">State<span class="mantatory" id="state">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_state"
							size="30" maxlength="50"
							value="<%=Helper.correctNull((String) hshValues
									.get("peremp_state"))%>"
							onKeyPress="notAllowSplChar()" onBlur="changecase(this)"
							tabindex="7"></td>
					
				</tr>
				<tr>
					<td width="4%"><%=ApplicationParams.getZipName()%><span class="mantatory" id="pin">*&nbsp;</span></td>
					<td ><input type="text" name="txtperemp_zip"
							size="8" maxlength="6" tabindex="9"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_zip"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')"></td>
				</tr>
				<tr>
					<td width="4%">Phone No.<span class="mantatory" id="phone">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_phone"
							size="18" maxlength="12" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
									.get("peremp_phone"))%>"
							onKeyPress="allowInteger()"></td>
				</tr>
				<tr>
					<td width="4%">FAX No.</td>
					<td><input type="text" name="txtperemp_fax"
							size="12" maxlength="15" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues.get("peremp_fax"))%>"
							onKeyPress="allowInteger()"></td>
					
				</tr>
				<tr>
					<td width="4%">Company E-mail</td>
					<td><input type="text" name="txtperemp_email"
							maxlength="50" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues
									.get("peremp_email"))%>"
							onBlur="isEmailAddr(document.forms[0].txtperemp_email.value,document.forms[0].txtperemp_email)"
							size="30"></td>
				</tr>
				
				
				
					</table>
				</td>
				<td width="60%">
					<table  width="100%" border="0" cellpadding="2" cellspacing="5" class="outertable">
				<tr>
					<td width="6%" nowrap="nowrap">Employee Id<span class="mantatory" id="empid">*&nbsp;</span></td>
					<td width="35%" id="emp1"><input type="text"
							name="txtperemp_empno" size="12" maxlength="9" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues
									.get("peremp_empno"))%>"
							onKeyPress="notAllowSplChar()"></td>
					<td width="20%" ><span id="exp_col">Experience in years</span><span class="mantatory">*&nbsp;</span></td>
					<td width="39%"><input type="text" name="txt_expinyrs" size="4"
							maxlength="4" 
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_expinyrs"))%>"></td>
				</tr>
				<tr>
					<td width="6%" nowrap="nowrap">Designation</td>
					<td><input type="text" name="txtperemp_Designation"
									size="20" maxlength="60"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_design"))%>"
									onKeyPress="notAllowSplChar()"><input type="hidden"
									name="txtperemp_Desigcode" size="15" maxlength="20"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_design"))%>"
									onKeyPress="allowAlphabets()"></td>
				<td width="6%">
						<%
							if (empdet.equalsIgnoreCase("9")) {
						%> Pension <%
							} else {
						%> Salary <%
							}
						%> Receipt Date <span class="mantatory" id="rec">*&nbsp;</span></td>
					<td nowrap="nowrap"><input type="text" name="txtperemp_receipt"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_receipt"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);">&nbsp;<a style="vertical-align: middle" href="#" onClick="callCalender('txtperemp_receipt')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="19"></a></td>
				</tr>
				<tr>	
					<td width="6%">Department Name</td>
					<td><input type="text"
							name="txtperemp_department" size="35" maxlength="50"
							tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_department"))%>"
							onKeyPress="notAllowSplChar()"></td>
					<td >Date of <%if(Helper.correctNull((String) hshValues.get("peremploy")).equalsIgnoreCase("1")){ %>Joining in the Current Employment<%}else{ %>Commencement<%} %><span id="est" class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_establish" size="11"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_establish"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currdate)">&nbsp;<a style="vertical-align: middle" href="#"
									onClick="callCalender('txtperemp_establish')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="22"></a></td>
				</tr>
				<tr>
					<td width="6%" >Retirement Date<span id="ret" class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txtperemp_retdate" size="11"
									maxlength="10"
									value="<%=Helper.correctNull((String) hshValues
							.get("peremp_retdate"))%>"
									onBlur="checkDate(this);calyearsofserviceleft();retireDobCheck()">&nbsp;<a style="vertical-align: middle" href="#" onClick="callCalender('txtperemp_retdate')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									border="0" tabindex="21"></a></td>
					<td width="6%">Years of service</td>
					<td><input type="text" name="txtserviceleft"
							size="3" maxlength="2" onKeyPress="allowInteger()" readOnly
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_servleft"))%>">&nbsp;Years&nbsp;<input type="text" name="txt_servicemonths" size="3"
							maxlength="2" onBlur="GetYearsleft()" onKeyPress="allowInteger()"
							readOnly
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_servleftmon"))%>">&nbsp;Months</td>
					
				</tr>
				<tr>
				<td width="6%" id="t1"> Contact Person</td>
				<td id="t2"><input type="text"
							name="peremp_contperson" size="25" maxlength="50" tabindex="25"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_contperson"))%>"
							onKeyPress="notAllowedDouble();allowAlphabets()"></td>

				<td>&nbsp;</td><td>&nbsp;</td>
				</tr>
				<tr id="id_conemp">
					<td width="6%" colspan="2">Whether a confirmed employee<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_confemp">
					<option value="0" selected="selected">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				<tr id="id_list">
					<td width="6%" colspan="2">Whether an employee of listed company, school/college/university and of any other entity permitted by credit department<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_listcom" onchange="callemp();">
					<option value="0" selected="selected">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				<tr id="id_empdeal">
					<td width="6%" colspan="2">Whether an employer is dealing with our bank<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_empdeal" onchange="callnoofyrs();">
					<option value="0">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
					
				</tr>
				<tr id="id_noofyrs">
					<td>No of Years<span class="mantatory">*&nbsp;</span></td>
					<td><input type="text" name="txt_noofyears" size="4"
							maxlength="4" onBlur="GetYearsleft()" onKeyPress="allowInteger()"
							value="<%=Helper.correctNull((String) hshValues
							.get("peremp_noofyrs"))%>"></td>
							<td colspan="2">&nbsp;</td>
				</tr>
				<tr>
					<td>Past Experience</td>
					<td colspan="3"><textarea name="txtperemp_experience"
							cols="30"
							%="%" onKeyPress="textlimit(this,1999);notAllowSplChar()" onKeyUp="textlimit(this,1999)"
							tabindex="28"><%=Helper.correctNull((String) hshValues
							.get("peremp_experience"))%></textarea></td>
				</tr>
				
				<tr id="idsal" style="display: none;">
					<td>Salary routed through</td>
					<td>
					 	<select name="sel_salrouted">
					 		<option value="S">--Select--</option>
					 		<option value="K">Own Bank </option>
					 		<option value="O">Other Bank</option>
					 	</select>
					</td>
					
				</tr>
				<tr id="id_source">
					<td width="6%" colspan="2">Whether an Regular Source from a gainful employment<span class="mantatory">*&nbsp;</span></td>
					<td colspan="2"><select name="sel_empsource">
					<option value="0" selected="selected">--Select--</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select></td>
				</tr>
				
					</table>
				</td>
			</tr>
	</table>
	</td>
		
	</tr>
	
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
	  
	  		<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
				<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		<% }  else { %>
			 <span style="display: none; "> <div>
			 </div>	</span>	
				<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
			<% } %>
			</tr>
		</table>
		</td>
	</tr>
</table>

<BR>
<BR>

<INPUT type="hidden" name="hidApp_type" value="A"> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("peremp_id"))%>"> 
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">  
<input type="hidden" name="scode" value="yyy"> 
<input type="hidden" name="txtperemp_retage" size="3" maxlength="20" value="58"
	onKeyPress="allowInteger()"> <input type="hidden" name="txtperemp_dob"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>"> <input
	type="hidden" name="hidempCity"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_empcity_code"))%>">

<input type="hidden" name="hidempstate"> <input type="hidden"
	name="hidcity"
	value="<%=Helper.correctNull((String) hshValues
									.get("peremp_city"))%>">
<input type="hidden" name="hidstate"
	value="<%=Helper.correctNull((String) hshValues
									.get("peremp_state"))%>">
<input type="hidden" name="hidsecCity"
	value="<%=Helper.correctNull((String) hshValues
							.get("peremp_prevempcity"))%>">
<input type="hidden" name="hidsecstate"> <input type="hidden"
	name="hidModuleName" value="<%=strModuleName%>"> <input
	type="hidden" name="readFlag"
	value="<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>">
<input type="hidden" name="hidCategoryType"
	value="<%=Helper.correctNull((String) request
							.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidapp_name" value="<%=strappname%>">
<input type="hidden" name="hidempdet" value="<%=empdet%>">
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">


</form>
</body>
</html>


