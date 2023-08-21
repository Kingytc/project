<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
//out.println(hshValues);
String strModuleType="";
	strModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
	
	String strEmployment="";
	strEmployment=(String)session.getAttribute("strEmployment");

	String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
	String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
	String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));


ArrayList vecData = new ArrayList();
ArrayList vecRow = new ArrayList();
int vecsize = 0;
int vecsize2 = 0;
if (hshValues != null) 
{
	vecData = (ArrayList) hshValues.get("vecData");
}
double acreval = 0.00;
double centguntval = 0.00;
double totalacreval = 0.00;
double totalcentgunt =0.00; 
double guntasrealq = 0.00; 
double guntasrealr = 0.00;
String strapptype = "";
String apptype = "";

String chobankapptype = Helper.correctNull((String)hshValues.get("chobank_apptype"));

	String strAcres="";
	strAcres= Helper.correctNull((String) hshValues.get("strAcress"));
	
	if(strAcres.trim().equals(""))
	{
		strAcres="0";
	}
	
	
	String schemetype = Helper.correctNull((String)request.getParameter("schemetype"));
	if(schemetype. trim().equalsIgnoreCase(""))
	{
		schemetype="0";
	}

	String strFarmcategory=Helper.correctNull((String)hshValues.get("strFarmcategory"));
	
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String pageid = request.getParameter("pageid");
	strapptype = Helper.correctNull((String)request.getParameter("corp"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Land Holdings</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varaction="<%=Helper.correctNull((String)hshValues.get("hidAction"))%>";
var id ="";
var apptype="";
var varApptype=new Array();
var area4="";
var appstatus ="<%=Helper.correctNull((String) hshValues.get("appstatus"))%>";

function mortgage()
{
   if(document.forms[0].security.value == "0")
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";
				
	}
   if(document.forms[0].security.value == "1")
	{
		document.all.m1.style.visibility="visible";
		document.all.m2.style.visibility="visible";
		document.all.m3.style.visibility="visible";
		document.all.m4.style.visibility="visible";
		document.all.m1.style.position="relative";
		document.all.m2.style.position="relative";
		document.all.m3.style.position="relative";
		document.all.m4.style.position="relative";	
	}
	 if(document.forms[0].security.value == "2")
	
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";	
		document.forms[0].Mortgage.value="0";
		//document.forms[0].txt_dateofmortgage.value="";
	}
	if(document.forms[0].security.value == "3")
	
	{
		document.all.m1.style.visibility="hidden";
		document.all.m2.style.visibility="hidden";
		document.all.m3.style.visibility="hidden";
		document.all.m4.style.visibility="hidden";
		document.all.m1.style.position="absolute";
		document.all.m2.style.position="absolute";
		document.all.m3.style.position="absolute";
		document.all.m4.style.position="absolute";		
		document.forms[0].Mortgage.value="0";
		//document.forms[0].txt_dateofmortgage.value="";
	}
}
function chkcentgunt() 
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_acreage1.value > 39)
		{
		 	alert("Guntas value cannot be greater than 39");
		 	document.forms[0].txt_acreage1.value = "";
		 	document.forms[0].txt_acreage1.focus();
		}
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}	
	//document.forms[0].txt_dateofmortgage.readOnly=true;
	document.forms[0].txt_nonCultivable.readOnly=true;
	document.forms[0].txt_nonIrrigated.readOnly=true;
	//document.forms[0].chobank_apptype.disabled=false;
}

function selectValues(val1, val2, val3,val5, val6, val7, val8, val9, val10, val11, val12, val13, val14, val15, val16, val20,val21,val23,val24,val25,val28,val30,val31,val32,val33,val34,val29,totacr,val35)
{
	document.forms[0].selsno.value = val3;
	//document.forms[0].chobank_apptype.value = val2;  
	document.forms[0].txt_acreage.value = val5;
	document.forms[0].txt_acreage_copy.value = val5;
	document.forms[0].village.value = val6;
	document.forms[0].txt_taluk.value = val7;
	document.forms[0].txt_district.value = val8;
	document.forms[0].survey.value = val9;
	document.forms[0].txt_landrevenue.value = val10;
	document.forms[0].txt_value.value = val11;
	document.forms[0].sellease.value =val12;
	checkLease();
	document.forms[0].leaseperiod.value =val13;
	document.forms[0].txt_amtrent.value = val14;
	
	//document.forms[0].selirrigation.value = val15;
	//document.forms[0].irrigated.value =val16;
	//document.forms[0].source.value =val17;
	//document.forms[0].encumbrance.value = val18;
	//document.forms[0].txr_encroached.value = val19;	
	document.forms[0].farmdistance.value = val20;
	document.forms[0].housedistance.value = val21;
	//document.forms[0].txr_address.value = val22;
	document.forms[0].txt_acreage1.value = val23;
	//document.forms[0].Mortgage.value = val24;
//	document.forms[0].security.value = val25;
	//document.forms[0].txt_fruit.value = val26;
	//document.forms[0].txt_nonfruit.value = val27;
	//document.forms[0].txt_dateofmortgage.value = val28;
	/*document.forms[0].txt_year1.value=vala;
	document.forms[0].txt_year2.value=valb;
	document.forms[0].txt_year3.value=valc;
	document.forms[0].txt_grossinc1.value=vald;
	document.forms[0].txt_grossinc2.value=vale;
	document.forms[0].txt_grossinc3.value=valf;*/
	document.forms[0].txt_Irrigated.value=val30;
	document.forms[0].txt_nonIrrigated.value=val31;
	document.forms[0].txt_nonCultivable.value=val32;
	document.forms[0].txt_Cultivable.value=val33;
	if(totacr=="Y")
	{	
	 document.forms[0].sel_FarmerCategory.value=val34;
	}else
	{
		setFarmerCategory();
	}
	
	document.forms[0].source.value = document.getElementById("hidsource"+val29).value;
	document.forms[0].encumbrance.value = document.getElementById("hidencumbrance"+val29).value;
	document.forms[0].txr_encroached.value = document.getElementById("hidencroached"+val29).value;
	document.forms[0].txt_fruit.value = document.getElementById("hidtreesfruit"+val29).value;
	document.forms[0].txt_nonfruit.value = document.getElementById("hidtreesnonfruit"+val29).value;
	document.forms[0].txr_address.value = document.getElementById("hidaddress"+val29).value;
	
	//roundtxt(document.forms[0].txt_grossinc1);
	//roundtxt(document.forms[0].txt_grossinc2);
	//roundtxt(document.forms[0].txt_grossinc3);
	roundtxt(document.forms[0].txt_landrevenue);
	roundtxt(document.forms[0].txt_value);
	
//	mortgage();
       if(document.forms[0].readFlag.value=="r")
	    {
		   disableControls(true,true,true,true,false);
		
	    }
	  else
	   {
				if(appstatus=="true")
			  	{
					enableButtons(true,true,true,true,true,false);
			  	}
			  	else
			  	{		
					disableCommandButtons("radioselect");
			  	}
	    }		  	   
	removemandatory();
	if(document.forms[0].sel_FarmerCategory.value != "021")
	{
		document.all.llt1.style.display = "none";
		document.forms[0].sel_landless_options.value = "";
	}
	else
	{
		document.all.llt1.style.display = "table-row";
		document.forms[0].sel_landless_options.value = val35;
	}
}
function getgrossdata()
{
	if(document.forms[0].hideditflag.value=="N")
	{
    	document.forms[0].hidAction.value="get";
    	document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp";
		document.forms[0].hidBeanMethod.value="updateLandbuild";
		document.forms[0].hidBeanGetMethod.value="getLandbuild";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('');
		return;
	}
}

function doSave()
{  
   /* if(document.forms[0].chobank_apptype.value=="s")
	{
		alert('Select Applicant Type');
		document.forms[0].chobank_apptype.focus();
		return;
	}*/ 

	if(parseInt(NanNumber(eval(document.forms[0].txt_acreage.value))) > 0) {
	if(trim(document.forms[0].survey.value)=="")
	{
		alert('Enter Survey No.');
		document.forms[0].survey.focus();
		return;
	}
	}
	if(document.forms[0].txt_acreage.value == "")
    {
	    alert('Enter the acreage value in acres');
	    document.forms[0].txt_acreage.focus();
	    return;
    }
   /* if(document.forms[0].txt_acreage1.value == "")
    {
	    document.forms[0].txt_acreage1.value = "0";
		return;
    }*/
    if(document.forms[0].sellease.value == "0")
    {
	    alert('Enter Whether the land is owned/leased');
	    document.forms[0].sellease.focus();
	    return;
    }
	/*if(document.forms[0].security.value == "1")
	{
	    if(document.forms[0].Mortgage.value == "0")
	    {
		    alert('Select Mortgage Type');
		    document.forms[0].Mortgage.focus();
		    return;
	    }
    }*/
   /* if(document.forms[0].security.value == "0")
    {
     	alert('Select security Type');
     	document.forms[0].security.focus();
   		return;
    }  */
     /*if(document.forms[0].selirrigation.value == "0")
    {
     	alert('Select Particulars of land');
     	document.forms[0].selirrigation.focus();
   		return;
    }*/
    //document.forms[0].hidchobank_apptype.value = document.forms[0].chobank_apptype.options[document.forms[0].chobank_apptype.selectedIndex].text;
    lablechange();
    if(document.forms[0].sel_FarmerCategory.value == "021")
	{
		if(document.forms[0].sel_landless_options.value == "")
		{
			alert("Please select the landless labour type");
			document.forms[0].sel_landless_options.focus();
			return;
		}
	}
	
    document.forms[0].cmdsave.disabled = true;
    document.forms[0].sel_FarmerCategory.disabled=false;
    document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp";
	document.forms[0].hidBeanMethod.value="updateLandbuild";
	document.forms[0].hidBeanGetMethod.value="getLandbuild";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}
	if(val=="approved")
	{  
		disableFields(true);
		disableFarmCat();
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
	}	 
	if(val=="edit")
	{		  
		disableFields(false);
		disableFarmCat();
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;	
		document.forms[0].cmdclose.disabled=true;	 
	}
	if(val=="radioselect")
	{	
		disableFields(true);  
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;	 
	}	  
}  

function doEdit()
{
 	disableFields(false);
 	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].village.focus();
}

function doNew()
{
	//if(document.forms[0].chobank_apptype.value!="s")
	//{
		disableFields(false);
		disableCommandButtons("edit");
		document.forms[0].hideditflag.value="Y";
		document.forms[0].source.readonly =false;
		//document.forms[0].selirrigation.value="0";
		//document.forms[0].Mortgage.value="0";
		//document.forms[0].security.value="0";
		document.forms[0].hidAction.value ="insert";
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].type=='radio')
			{
				document.forms[0].elements[i].checked=false;
			}	  
		}
		document.forms[0].village.focus();
	//}
	//else
	//{
	//	alert("Select Applicant Type");
	//	document.forms[0].chobank_apptype.focus();
	//	return;
	//}
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getLandbuild";
		document.forms[0].action=appURL+"action/agr_landholdingscust.jsp";
		document.forms[0].submit(); 		
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";		
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanMethod.value="updateLandbuild";
		document.forms[0].hidBeanGetMethod.value="getLandbuild";
		document.forms[0].hidSourceUrl.value="/action/agr_landholdingscust.jsp";
		document.forms[0].method="post";			
		document.forms[0].submit();		
	}
}
	
function onloading()
{	
	//if(varaction=="get")
	//{
	//	document.forms[0].chobank_apptype.value="<%=chobankapptype%>";	  
	//}
	//else
	//{
	//	..document.forms[0].chobank_apptype.value="s";
	//}
	disableFields(true);
	checkLease();
	setFarmerCategory();

	//lablechange();
	if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,false);
		
	}
	else
    {
	      if(appstatus=="true")
  	      {
		  enableButtons(true,true,true,true,true,false);
  	      }
	     else
  	     {
     	enableButtons(false,true,true,true,true,false);
  	      }
     }
	//document.all.sel_scheme.disabled=false;
	//document.all.sel_scheme.value="<%=schemetype%>";
}

function checkLease()
{
	if(document.forms[0].sellease.value == "2")
	{
		document.all.r1.style.visibility="visible";		
		document.all.r1.style.position="relative";	
	}
	else
	{
		document.all.r1.style.visibility="hidden";	
		document.all.r1.style.position="absolute";
		document.forms[0].leaseperiod.value="";
	}
}
		


function callCalender(name)
{
if(document.forms[0].cmdedit.disabled==true)
	{
	showCal(appURL,name);
	}
}

function setFarmerCategory1() {
	document.forms[0].txt_TotLandHold.value=eval(document.forms[0].txt_TotLandHold_copy.value)+eval(document.forms[0].txt_acreage.value)-eval(document.forms[0].txt_acreage_copy.value);
	document.all.ifrm1.src = appURL+ "action/iframefarmcat.jsp?hidBeanGetMethod=getAppFarmersCategory&hidBeanId=mis&strTotLandVal="+document.forms[0].txt_TotLandHold.value;
	disableFarmCat();
	//lablechange();
}

function setFarmerCategory() {
	document.all.ifrm1.src = appURL+ "action/iframefarmcat.jsp?hidBeanGetMethod=getAppFarmersCategory&hidBeanId=mis&strTotLandVal="+document.forms[0].txt_TotLandHold.value;
	//disableFarmCat();
}

function disableFarmCat()
{
	
	if(document.forms[0].txt_TotLandHold.value=="0.00"||document.forms[0].txt_TotLandHold.value=="0" || document.forms[0].txt_TotLandHold.value=="0.0")
	{
		document.forms[0].sel_FarmerCategory.disabled=false;
	}
	else
	{
		document.forms[0].sel_FarmerCategory.disabled=true;
	}
}

function calculatenonIrrigate()
{
	var totArceage=document.forms[0].txt_acreage.value;
	var irrigated =document.forms[0].txt_Irrigated.value;
	var nonIrrigated="";
	if(totArceage!="" && irrigated!="")
	{
		nonIrrigated=eval(totArceage)-eval(irrigated);
		document.forms[0].txt_nonIrrigated.value=nonIrrigated;
	}
	if(eval(totArceage)<eval(irrigated))
	{
		alert("Irrigated Acre cannot be greater than Land Holding");
		document.forms[0].txt_Irrigated.value="";
		document.forms[0].txt_Irrigated.focus();
		return;
	}
	else
	{
		if(totArceage!="" && irrigated!="")
		{
			nonIrrigated=eval(totArceage)-eval(irrigated);
			document.forms[0].txt_nonIrrigated.value=nonIrrigated;
		}
	}
}

function calculatenonCulitivatd()
{
	var totArceage=document.forms[0].txt_acreage.value;
	var Cultivatiable=document.forms[0].txt_Cultivable.value;
	var nonIrrigated="";
	if(totArceage!="" && Cultivatiable!="")
	{
		nonIrrigated=eval(totArceage)-eval(Cultivatiable);
		document.forms[0].txt_nonCultivable.value=nonIrrigated;
	}
	if(eval(totArceage)<eval(Cultivatiable))
	{
		alert("Cultivatiable Acre cannot be greater than Land Holding");
		document.forms[0].txt_Cultivable.value="";
		document.forms[0].txt_Cultivable.focus();
		return;
	}
	else
	{
		if(totArceage!="" && Cultivatiable!="")
		{
			nonIrrigated=eval(totArceage)-eval(Cultivatiable);
			document.forms[0].txt_nonCultivable.value=nonIrrigated;
		}
	}
}

function removemandatory()
{
	if(parseInt(NanNumber(eval(document.forms[0].txt_acreage.value))) > 0) {
		document.all.id_survey.style.visibility="visible";
		document.all.id_survey.style.position="relative";
		document.all.id_whetherowned.style.visibility="visible";
		document.all.id_whetherowned.style.position="relative";
	}
	else
	{
		document.all.id_survey.style.visibility="hidden";
		document.all.id_survey.style.position="absolute";
		document.all.id_whetherowned.style.visibility="hidden";
		document.all.id_whetherowned.style.position="absolute";
	}
}
function lablechange(){
	if(document.forms[0].sel_FarmerCategory.value != "021")
	{
		document.all.llt1.style.display = "none";
		document.forms[0].sel_landless_options.value = "";
	}
	else
	{
		document.all.llt1.style.display = "table-row";
	}
}
</script>
</head>
<body onLoad="onloading();">
<form class="normal" method="post">

<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Land Holdings</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="10"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<% } else {  %>

<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="10" />
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
			<jsp:param name="subsubpageid" value="10"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="10"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
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
  <%
if(strSessionModuleType.equalsIgnoreCase("AGR")){
%>
	<tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Applicant -&gt; customer profile -&gt; Land Holdings</td>
	</tr>
	
     <%}else
     {
     %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Land Holdings</td>
	</tr>
  </table>
     <%}}else if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %> 
        <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Land Holdings</td>
    </tr>
  </table>
  <%} else if(strapptype.equalsIgnoreCase("R")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Land Holdings</td>
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
			<tr>
		<td>
		<%if(strapptype.equalsIgnoreCase("C")){ %>
		<lapstab:ComfacilityTab tabid="2" />
		<%}if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){%>
		<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="10"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
		</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%}} %>

<% } %>

<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								
                        <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
                    
                      <tr> 
                        <td nowrap width="18%">Village</td>
                        <td nowrap width="16%"> 
                          <input type="text" name="village" size="20" onKeyPress="notAllowSplChar()" maxlength="50" tabindex="1">
                        </td>
                        <td nowrap width="15%">Taluk</td>
                        <td nowrap width="17%"> 
                          <input type="text"
											name="txt_taluk" size="20"
											onKeyPress="notAllowSplChar()" maxlength="50" tabindex="2">
                        </td>
                        <td nowrap width="16%">District</td>
                        <td nowrap width="18%"> 
                          <input type="text" onKeyPress="notAllowSplChar()"
											name="txt_district" value="" maxlength="50" size="20" tabindex="3">
                        </td>
                      </tr>
                      <% 	/*String measurementtype = Helper.correctNull((String)hshValues.get("land_measurement"));
                              	String measurementval="";
                            	if(measurementtype.equalsIgnoreCase("c"))
                      	  		{
                      	 
                      	  			 measurementval = "Cents";
                      	 		 }
                      	 		 else
                      	  			{
                      					measurementval = "Guntas";
                      	 			}*/
                                %>
                      <tr> 
                         <td width="18%">Land Holding<b class="mantatory">*</b></td>
                        <td width="16%"> 
                          <input type="text" name="txt_acreage" value="" size="15" maxlength="6"
											onKeyPress="allowAlphaNumeric()"
											style="text-align:right" onBlur="setFarmerCategory1();removemandatory();calculatenonIrrigate();calculatenonCulitivatd();" tabindex="4">
                          Acre&nbsp;&nbsp; 
                          
                          <input type="hidden" name="txt_acreage_copy" value="0">
                          <input type="hidden"
											name="txt_acreage1" value="" size="5" maxlength="2"
											onKeyPress="allowInteger()"
											style="text-align:right" onBlur="chkcentgunt()">
                        </td>
                        
                        <td nowrap width="15%">Land 
                          revenue (Rs)</td>
                        <td width="17%"><lapschoice:CurrencyTag name="txt_landrevenue" size="20"	style="text-align:right" maxlength="10"/></td>
                        <td nowrap width="16%">Value 
                          (Rs in Lakh)</td>
                        <td width="18%"><lapschoice:CurrencyTag name="txt_value" size="20" maxlength="10"/></td>
                      </tr>
                      <tr>
                      <td width="18%">Irrigated</td>
                      <td width="16%"><input type="text" name="txt_Irrigated" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')" style="text-align:right" onBlur="calculatenonIrrigate();roundtxt(this);" value="" tabindex="7"></td>
						<td width="15%">Non-Irrigated</td>
                      <td width="17%"><input type="text" name="txt_nonIrrigated" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')" style="text-align:right"  value="" onBlur="roundtxt(this);" tabindex="8"></td>
					<td nowrap width="16%">Farm distance from our branch</td>
                    <td width="18%"><input type="text" name="farmdistance" size="20" maxlength="5" onKeyPress="allowNumber(this)" tabindex="9">Kms</td>																
					</tr>
                      <tr>
                      <td width="18%">Cultivatable</td>
                      <td width="16%"><input type="text" name="txt_Cultivable" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')"
						style="text-align:right"  value="" onBlur="calculatenonCulitivatd();roundtxt(this);" tabindex="10"></td>
					 <td width="15%">Non-Cultivatable</td>
                      <td width="17%"><input type="text" name="txt_nonCultivable" size="20" maxlength="7" onKeyPress="allowDecimal(this,'4')"
						style="text-align:right"  value="" onBlur="roundtxt(this);" tabindex="11"></td>
						 <td width="16%">House distance from our branch</td>
                        <td width="18%"><input type="text" name="housedistance" maxlength="5" size="20" onKeyPress="allowNumber(this)" tabindex="12">Kms</td>
                      </tr>
                      <tr>
                      <td nowrap width="18%">Survey No<span id="id_survey" class="mantatory">*</span></td>
                        <td nowrap width="16%"> 
                          <input type="text" name="survey" value=""
											maxlength="20" size="20" tabindex="13">
                        </td> 
                        <td width="15%">Whether Owned/Leased<span id="id_whetherowned" class="mantatory">*</span> 
                          </td>
                        <td width="17%"> 
                          <select name="sellease" onChange="checkLease()" style="width: 120px;" tabindex="14">
                            <option value="1">Owned</option>
                            <option value="2">Leased</option>
                            <option value="3">Share cropper</option>
                            <option value="4">others</option>
                             <option value="5">Tenant farmer</option>
                              <option value="6">Oral Lessees field</option>
                          </select>
                        </td>
                        <td width="16%">&nbsp;</td>
                        <td width="18%">&nbsp; </td>
                      </tr>
                      <tr id="r1"> 
                        <td nowrap width="18%">Unexpired Lease/<br>Rent period (in months)</td>
                        <td width="16%"> 
                          <input type="text"
											name="leaseperiod" value="" size="20" maxlength="100"
											style="text-align:left" tabindex="15">
                        </td>
                        <td width="15%">Annual rent payable (Rs)
                          </td>
                        <td width="17%"> 
                          <input type="text"
											name="txt_amtrent" size="20"
											onKeyPress="allowNumber(document.forms[0].txt_amtrent)"
											maxlength="10" style="text-align:right" tabindex="16">
                        </td>
                        <td width="16%">Name and Address of landLord with lease deed details</td>
                        <td width="18%"> 
                          <textarea name="txr_address" cols="20" style="text-align:left"
											wrap="VIRTUAL" rows="2"
											onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" tabindex="17"></textarea>
                        </td>
                      </tr>
                      <!-- <tr> 
                        <td width="22%">Security
                          <b class="mantatory">*</b></td>
                        <td width="19%"> 
                          <select name="security" onChange="mortgage()">
                            <option value="0" selected>--Select--</option>
                            <option value="1">Already Taken as Security</option>
                            <option value="2">Not Offered as Security </option>
                            <option value="3">Offered as Security </option>
                          </select>
                        </td>
                        <td id="m1" width="15%">Mortgage<b class="mantatory">*</b></td>
                        <td id="m2" width="14%"> 
                          <select name="Mortgage">
                            <option value="0" selected>--Select--</option>
                            <option value="1">Equitable</option>
                            <option value="2">registered</option>
                            <option value="3">Creation of Charge</option>
                            <option value="4">Third party property</option>
                          </select>
                        </td>
                        <td width="16%" id="m3">Date 
                          of charge/mortgage</td>
                        <td width="14%" id="m4"> 
                          <input type="text" name="txt_dateofmortgage" size="12" maxlength="10"	onKeyPress="" onBlur="checkmaxdate(this,currentDate)" tabindex="7">
                          <a href="#" onClick="callCalender('txt_dateofmortgage')" title="Click to view calender" border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
						  width="0" border="0"></a>
                        </td>
                      </tr> -->
                      <!--  <tr> 
                        <td width="22%">Particulars 
                          of land <b class="mantatory">*</b></td>
                        <td width="14%"> 
                          <select value="0" name="selirrigation" onChange="" style="width: 120px;">
                            <option value="0" selected>--Select--</option>
                            <option value="1">Irrigated</option>
                            <option value="2">Dry Land</option>
                            <option value="3">Non-Cultivable</option>
                          </select>
                        </td>
                       
                       
                      </tr>-->
                    </table>
								
                          
                    <table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
                      <tr> 
                        <td width="18%">Source of Irrigation</td>
                        <td> 
                          <textarea name="source" onBlur="" cols="50" style="text-align:left"
						wrap="VIRTUAL" rows="4" onKeyPress="textlimit(source,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)" tabindex="18"></textarea>
                        </td>
						<td align="left">Encroached Land particulars 
							if any</td>
						  <td  > 
							<textarea
											  name="txr_encroached" onBlur="" cols="50"
											  style="text-align:left" wrap="VIRTUAL" rows="4"
											  onKeyPress="textlimit(txr_encroached,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)" tabindex="20"></textarea>
						  </td>
                      </tr>
                      <tr> 
                        <td>Encumbrance</td>
                        <td > 
                          <textarea
											name="encumbrance" cols="50" style="text-align:left"
											wrap="VIRTUAL" rows="4"
											onKeyPress="textlimit(encumbrance,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)" tabindex="19"></textarea>
                        </td>
                        
                      </tr>
                      <tr> 
                        <td>Details of Trees-Fruit</td>
                        <td > 
                          <textarea name="txt_fruit" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4"
							onKeyPress="textlimit(txt_fruit,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)" tabindex="21"></textarea>
                        </td>
                        <td align="left">Details of Trees- Non Fruit</td>
                        <td> 
                          <textarea name="txt_nonfruit" onBlur="" cols="50" style="text-align:left" wrap="VIRTUAL" rows="4"
						  onKeyPress="textlimit(txt_nonfruit,3999);notAllowSingleAndDoubleQuote()" onKeyUp="textlimit(this,3999)" tabindex="22"></textarea>
						  </td>
                      </tr>
                      <!-- <tr> 
                        <td colspan="4">
                          <<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr align="center"> 
                              <td colspan="4"><b><h5>Last three years production data(Gross)</h5></b></td>
                            </tr>
                            <tr>
                              <td width="26%">Year</td>
                              <td width="22%">
                                <input type="text"
											name="txt_year1" value="<%=Helper.correctNull((String)hshValues.get("year1"))%>" size="25" maxlength="4" onBlur="checkcurrentyear(this)"
											onKeyPress="allowInteger()" >
                              </td>
                              <td width="25%">
                                <input type="text"
											name="txt_year2"  size="25" maxlength="4" onBlur="checkcurrentyear(this)"
											onKeyPress="allowInteger()" value="<%=Helper.correctNull((String)hshValues.get("year2"))%>">
                              </td>
                              <td width="27%">
                                <input type="text"
											name="txt_year3" value="<%=Helper.correctNull((String)hshValues.get("year3"))%>" size="25" maxlength="4" onBlur="checkcurrentyear(this)"
											onKeyPress="allowInteger()">
                              </td>
                            </tr>
                            <tr>
                              <td width="26%">Gross 
                                Income (Rs.)</td>
                              <td width="22%">
                                <lapschoice:CurrencyTag 
											name="txt_grossinc1" value='<%=Helper.correctNull((String)hshValues.get("grossinc1"))%>' size="25" maxlength="9"
										/>
                              </td>
                              <td width="25%">
                                <lapschoice:CurrencyTag 
											name="txt_grossinc2" value='<%=Helper.correctNull((String)hshValues.get("grossinc2"))%>' size="25" maxlength="9"
											/>
                              </td>
                              <td width="27%">
                                <lapschoice:CurrencyTag 
											name="txt_grossinc3" value='<%=Helper.correctNull((String)hshValues.get("grossinc3"))%>' size="25" maxlength="9"
											/>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>-->
                      <tr> 
                        <td> Total Acreage</td>
                        <td > 
                          <%
                          String strVal="N"; 
                          if(vecData!=null && vecData.size()>0){
                              vecsize2 = vecData.size();
                  			for (int j = 0; j < vecsize2; j++) {
                  				vecRow = (ArrayList) vecData.get(j);
                  				if (vecRow != null) {
								
                      acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(3)));
					centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(21)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;	
					}
                  			}}
                  			 %>
                          <%
                    /*            if(measurementtype.equalsIgnoreCase("g"))
                      	  		{
                      	 
                      	  		                    	 		        
					guntasrealq  = totalcentgunt % 40;
					guntasrealr   = totalcentgunt / 40 ;
					if(guntasrealr >= 1)
					{
						totalacreval = 	totalacreval + guntasrealr;
					}
					totalacreval = Math.floor(totalacreval);
					
         	  		}
                   else 
                   {*/
                   	guntasrealq  = totalcentgunt % 100;
   					guntasrealr   = totalcentgunt / 100 ;
   					if(guntasrealr >= 1)
   					{
   						totalacreval = 	totalacreval + guntasrealr;
   					}
   					if((totalacreval==0.00) || (totalacreval==0))
   					{
   						strVal="Y";
   					}
   					//totalacreval = Math.floor(totalacreval);
                  /* }*/					
					%>
                          <%=totalacreval%>&nbsp;&nbsp;Acres&nbsp;</td>
                        <td  nowrap>Farmer's Category<b><span class="mantatory" id="id_Farm">&nbsp;*</span></b>
                          <input type="hidden" name="txt_TotLandHold" size="15" maxlength="100" value="<%=totalacreval%>">
                          <input type="hidden" name="txt_TotLandHold_copy" size="15" maxlength="100" value="<%=totalacreval%>">
                        </td>
                        <td>
						<select name="sel_FarmerCategory" style="width: 80%" tabindex="23">
							<option value="" selected="selected">--Select--</option>
							<lapschoice:BanksSchemeStaticDataNewTag apptype="13" />
						</select></td>
                        
                      </tr>
                      <tr id="llt1">
                      <td>&nbsp;</td>
                      <td>&nbsp;</td>
                      <td>Land less labor type<b><span class="mantatory">*&nbsp;</span></b></td>
						<td>
							<select name="sel_landless_options" tabindex="1" style="width: 90%">
			     				<option value="" selected="selected">--Select--</option>
								<lapschoice:StaticDataNewTag apptype="186" />
			    			</select>
			    		</td>
                      </tr>
                    </table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
			
				<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
					<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
				<% }  else { %>
				<span style="display: none; "> 	<div >
					<!-- <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /> -->
				</div>	 </span>	
				<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
			<% } %>
	
					
					<tr>
						<td width="10%" align="center" >Particulars of land Holdings</td>
					</tr>
					<tr align="center">
						<td >
						<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable border1" align="center">
                <%if (vecData != null) {%>
                <tr class="dataheader"> 
                  <td width="6%" align="center">&nbsp;</td>
                  <td width="10%" align="center">Village</td>
                  <td width="6%" align="center">Survey No.</td>
                  <td width="8%" align="center"> Acreage</td>
                  <!--<td width="8%" align="center">Of Which Irrigated</td>-->
                  <td width="9%" align="center">Source of Irrigation</td>
                  <td width="9%" align="center">Encumbrance</td>
                  <td width="9%" align="center">Whether Owned/Leased</td>
                  <td width="9%" align="center">Lease Period</td>
                  <td width="9%" align="center">Farm Distance - In 
                    Kms </td>
<!--                  <td width="15%" align="center">Particulars -->
<!--                          of land-->
<!--                     </td>-->
                </tr>
                <%vecsize = vecData.size();				
			}
			String strSno = "";
			
			String leased = "";			
			String strapptype1="",strapptype2="";
			String strparicularland = "";

			for (int i = 0; i < vecsize; i++) 
			{
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) 
				{
					strSno = Helper.correctNull((String) vecRow.get(2));			
					acreval = Double.parseDouble(Helper.correctDouble((String) vecRow.get(3)));
					centguntval = Double.parseDouble(Helper.correctDouble((String)vecRow.get(21)));
					totalacreval = totalacreval + acreval;
					totalcentgunt = totalcentgunt + centguntval;					
					leased = Helper.correctNull((String) vecRow.get(10));
					strparicularland = Helper.correctNull((String) vecRow.get(13));	
					
					if (leased.equals("1")) 
					{
						leased = "Owned";
					} 
					if(leased.equals("2"))
					{
						leased = "Leased";
					}
					if(leased.equals("3"))
					{
						leased = "Share cropper";
					}
					if(leased.equals("4"))
					{
						leased = "Others";
					}
					/*strapptype = Helper.correctNull((String) vecRow
							.get(1));
						strapptype2 = Helper.correctNull((String) vecRow
							.get(24));
							
					int len=strapptype.length();
					strapptype1 = strapptype.substring(0, 1);
					strapptype = strapptype.substring(1, len);
					
					if (strapptype1.equalsIgnoreCase("a"))
						apptype = "Applicant";
					else if (strapptype1.equalsIgnoreCase("c"))
						apptype = "Co-Applicant";
					else if (strapptype1.equalsIgnoreCase("g"))
						apptype = "Guarantor";
					else if (strapptype1.equalsIgnoreCase("J"))
						apptype = "Joint-Applicant";*/
					
					
					if (strparicularland.equals("1")) 
					{
						strparicularland = "Irrigated";
					} 
					if(strparicularland.equals("2"))
					{
						strparicularland = "Dry Land";
					}
					if(strparicularland.equals("3"))
					{
						strparicularland = "Non-Cultivable";
					}
					%>
					 
                <tr class="datagrid"> 
                  <td><input type="radio" name="sno"
									style="border-style:none"
									onClick="selectValues(
									'<%=Helper.correctNull((String) vecRow.get(0))%>','<%=Helper.correctNull((String) vecRow.get(1))%>',
									'<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.correctNull((String) vecRow.get(3))%>',
									'<%=Helper.correctNull((String) vecRow.get(4))%>','<%=Helper.correctNull((String) vecRow.get(5))%>',
									'<%=Helper.correctNull((String) vecRow.get(6))%>','<%=Helper.correctNull((String) vecRow.get(7))%>',
									'<%=Helper.correctNull((String) vecRow.get(8)) %>','<%=Helper.correctNull((String) vecRow.get(9))%>',
									'<%=Helper.correctNull((String) vecRow.get(10))%>','<%=Helper.correctNull((String) vecRow.get(11))%>',
									'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(12))))%>','<%=Helper.correctNull((String) vecRow.get(13))%>',
									'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vecRow.get(14))))%>',
									'<%=Helper.correctNull((String) vecRow.get(18))%>','<%=Helper.correctNull((String) vecRow.get(19))%>',
									'<%=Helper.correctNull((String) vecRow.get(21))%>',
									'<%=Helper.correctNull((String) vecRow.get(22))%>','<%=Helper.correctNull((String) vecRow.get(23))%>',
									'<%=Helper.correctNull((String) vecRow.get(27))%>','<%=Helper.correctNull((String) vecRow.get(28))%>',
									'<%=Helper.correctNull((String) vecRow.get(29))%>','<%=Helper.correctNull((String) vecRow.get(30))%>',
									'<%=Helper.correctNull((String) vecRow.get(31))%>','<%=strFarmcategory%>','<%=i%>','<%=strVal%>',
									'<%=Helper.correctNull((String) vecRow.get(33))%>')"> 
                    <input type="hidden" name="hid" value="<%=strSno%>">
                    
                    <input type="hidden" id="hidsource<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(15))%>">
                    <input type="hidden" id="hidencumbrance<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(16))%>">
                    <input type="hidden" id="hidencroached<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(17))%>">
                    <input type="hidden" id="hidtreesfruit<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(25))%>">
                    <input type="hidden" id="hidtreesnonfruit<%=i%>" value="<%=Helper.correctDoubleQuotesHtml((String) vecRow.get(26))%>">
                    <input type="hidden" id="hidaddress<%=i%>" value="<%=Helper.correctNull((String) vecRow.get(20))%>">
                     
                    </td>
                  <td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(4))%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
                  <td align="left">&nbsp; <%=Helper.correctNull((String) vecRow.get(7))%></td>
                  <td align="right"> &nbsp; <%=Helper.correctNull((String) vecRow.get(3))%></td>
                  <td><%=Helper.correctNull((String) vecRow.get(15))%></td>
                  <!--<td><%//=Helper.correctNull((String) vecRow.get(15))%></td>-->
                  <td align="left"><%=Helper.correctNull((String) vecRow.get(16))%></td>
                  <td><%=leased%></td>
                  <td align="left"><%=Helper.correctNull((String) vecRow.get(11))%></td>
                  <td><%=Helper.correctNull((String) vecRow.get(18))%></td>
<!--                  <td><%=strparicularland%></td>-->
                </tr>
                
                <%}
			                    }%>
				<tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <!--<td>&nbsp;</td>-->
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <!--<td>&nbsp;</td>
                  --><td>&nbsp;</td>

                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center"> 
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <!--<td>&nbsp;</td>
                  --><td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr align="center">
                  <td>&nbsp;</td>
                  <td align="center">&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                  <!--<td>&nbsp;</td>
                  --><td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td align="right">&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
              </table>
						</td>
					</tr>
				</table>
      </td>
			</tr>
		</table>
		
<table>
	<tr>
<td>
<input type="hidden" name="selsno"/>
<input type="hidden" name="hidcroptype" value="PR">
<input type="hidden" name="hidchobank_apptype">
<input type ="hidden" name="land_measurement" value ="">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</tr>
</table>		
<input type="hidden" name="app_constitution" value="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">
<input type="hidden" name="hid_FarmCat" value="">
<input type="hidden" name="hidfacname" value="<%=hidfacname%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>