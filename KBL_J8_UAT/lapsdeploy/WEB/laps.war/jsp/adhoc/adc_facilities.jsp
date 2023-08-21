<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>

<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<laps:handleerror />
<%
String strAppno = "";
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;

}
//out.println("hshValues-->"+hshValues);
String applicantid = "";
String appstatus = "";
String appname = "";
String Valuesin = "";
String strValuesin = "";
String hidcatory = "";
String strappstatus = "";
String strBtnenable="";
strAppno = Helper.correctNull((String) hshValues.get("appno"));
applicantid = Helper.correctNull((String) hshValues.get("applicantid"));
appstatus = Helper.correctNull((String) hshValues.get("appstatus"));
appname = Helper.correctNull((String) hshValues.get("app_name"));
Valuesin = Helper.correctNull((String) hshValues.get("valuesin"));
strBtnenable= Helper.correctNull((String) hshValues.get("btnenable"));

if (strAppno.equalsIgnoreCase(""))
{
	strAppno = Helper.correctNull((String) request.getParameter("appno"));
}
if (appstatus.equalsIgnoreCase("op") || strAppno.equalsIgnoreCase("new")) 
{
	strappstatus = "Open/Pending";
}
else if (appstatus.equalsIgnoreCase("pa"))
{
	strappstatus = "Processed/Approved";

}
else if (appstatus.equalsIgnoreCase("pr"))
{
	strappstatus = "Processed/Rejected";
}
else if (appstatus.equalsIgnoreCase("ca")) 
{
	strappstatus = "Closed/Approved";
} 
else if (appstatus.equalsIgnoreCase("cr"))
{
	strappstatus = "Closed/Rejected";
}
if (appname.equalsIgnoreCase("")) 
{
	appname = Helper.correctNull((String) request.getParameter("appname"));
}
if (applicantid.equalsIgnoreCase("")) 
{
	applicantid = Helper.correctNull((String) request.getParameter("comapp_id"));
	
}
hidcatory = Helper.correctNull((String) request.getParameter("hidcatory"));

ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
if (Valuesin.equalsIgnoreCase("")) 
{
	Valuesin = Helper.correctNull((String) request.getParameter("valuesin"));
}
if (Valuesin.equals("L")) 
{
	strValuesin = " in Lacs";
}
else
{
	strValuesin = " in Crores";
}

			%>
<html>
<head>
<title>Facilities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varAppno ="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var varappstatus ="<%=Helper.correctNull((String)hshValues.get("checkappln"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";



function selectValues(varsno, vargrp)
{
var strheadid=0,strfacid=0,strsubheadid=0,strsubfacid=0;
len = document.forms[0].facility_head.length;
	if(vargrp=="0")
	{
		//document.forms[0].facility_head.value=document.forms[0].elements["hidfachead"+varsno].value;
		strheadid=document.forms[0].elements["hidfachead"+varsno].value;
		//document.forms[0].facility.value=document.forms[0].elements["hidfacility"+varsno].value;
		strfacid=document.forms[0].elements["hidfacility"+varsno].value;
		document.forms[0].txt_amt.value=document.forms[0].elements["hidamt"+varsno].value;
		document.forms[0].txt_outstanding.value=document.forms[0].elements["hidoutstanding"+varsno].value;
		document.forms[0].txt_int.value=document.forms[0].elements["hidint"+varsno].value;
		document.forms[0].txt_outstandingason.value=document.forms[0].elements["hidoutstandingason"+varsno].value;
		document.forms[0].txt_security.value=document.forms[0].elements["hidsecurity"+varsno].value;
		document.forms[0].txt_overdue.value=document.forms[0].elements["hidoverdue"+varsno].value;
		document.forms[0].txt_margin.value=document.forms[0].elements["hidmargin"+varsno].value;
		document.forms[0].txt_period.value=document.forms[0].elements["hidperiod"+varsno].value;
		document.forms[0].txt_cbsno.value=document.forms[0].elements["hidcbsno"+varsno].value;
		
		if(document.forms[0].elements["hidcategory"+varsno].value=="R")
		{
			document.forms[0].category[0].checked=true;
		}
		else if(document.forms[0].elements["hidcategory"+varsno].value=="A")
		{
			document.forms[0].category[1].checked=true;
		}
		
		document.forms[0].subfacility_head.value="-";
		document.forms[0].subfacility.value="";
		document.forms[0].txt_subamt.value="";
		document.forms[0].txt_suboutstanding.value="";
		document.forms[0].txt_subint.value="";
		document.forms[0].txt_suboutstandingason.value="";
		document.forms[0].txt_subsecurity.value="";
		document.forms[0].txt_suboverdue.value="";
		document.forms[0].txt_submargin.value="";
		document.forms[0].txt_subperiod.value="";
		document.forms[0].txt_subcbsno.value="";
		document.forms[0].chksublimit.checked=false;
		document.forms[0].chksublimit.value="N";
		document.forms[0].hidfactype.value="limit";
		
	}
	else
	{
		strheadid=document.forms[0].elements["hidfachead"+vargrp].value;
		strfacid=document.forms[0].elements["hidfacility"+vargrp].value;
		
		document.forms[0].txt_amt.value=document.forms[0].elements["hidamt"+vargrp].value;
		document.forms[0].txt_outstanding.value=document.forms[0].elements["hidoutstanding"+vargrp].value;
		document.forms[0].txt_int.value=document.forms[0].elements["hidint"+vargrp].value;
		document.forms[0].txt_outstandingason.value=document.forms[0].elements["hidoutstandingason"+vargrp].value;
		document.forms[0].txt_security.value=document.forms[0].elements["hidsecurity"+vargrp].value;
		document.forms[0].txt_overdue.value=document.forms[0].elements["hidoverdue"+vargrp].value;
		document.forms[0].txt_margin.value=document.forms[0].elements["hidmargin"+vargrp].value;
		document.forms[0].txt_period.value=document.forms[0].elements["hidperiod"+vargrp].value;
    	document.forms[0].txt_cbsno.value=document.forms[0].elements["hidcbsno"+vargrp].value;
    	
    	if(document.forms[0].elements["hidcategory"+vargrp].value=="R")
		{
			document.forms[0].category[0].checked=true;
		}
		else if(document.forms[0].elements["hidcategory"+vargrp].value=="A")
		{
			document.forms[0].category[1].checked=true;
		}
    	
		strsubheadid=document.forms[0].elements["hidfachead"+varsno].value;
		strsubfacid=document.forms[0].elements["hidfacility"+varsno].value;
		
		document.forms[0].txt_subamt.value=document.forms[0].elements["hidamt"+varsno].value;
		document.forms[0].txt_suboutstanding.value=document.forms[0].elements["hidoutstanding"+varsno].value;
		document.forms[0].txt_subint.value=document.forms[0].elements["hidint"+varsno].value;
		document.forms[0].txt_suboutstandingason.value=document.forms[0].elements["hidoutstandingason"+varsno].value;
		
		document.forms[0].txt_subsecurity.value=document.forms[0].elements["hidsecurity"+varsno].value;
		document.forms[0].txt_suboverdue.value=document.forms[0].elements["hidoverdue"+varsno].value;
		document.forms[0].txt_submargin.value=document.forms[0].elements["hidmargin"+varsno].value;
		document.forms[0].txt_subperiod.value=document.forms[0].elements["hidperiod"+varsno].value;
		document.forms[0].txt_subcbsno.value=document.forms[0].elements["hidcbsno"+varsno].value;
		
		if(document.forms[0].elements["hidcategory"+varsno].value=="R")
		{
			document.forms[0].category[0].checked=true;
		}
		else if(document.forms[0].elements["hidcategory"+varsno].value=="A")
		{
			document.forms[0].category[1].checked=true;
		}
		
		document.forms[0].chksublimit.checked=true;
		document.forms[0].chksublimit.value="Y";
		document.forms[0].hidfactype.value="sublimit";
	}
	document.forms[0].hidsno.value=varsno;
	document.forms[0].hidfacgrp.value=vargrp;
	
	for(k=0;k<len;k++)
	{
		arr = document.forms[0].facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strheadid)
			{
				document.forms[0].elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strheadid!="")
	{
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strheadid
									 +"&value=subsel&hidMethod=getFacility&factid="+strfacid+"&strtype=facility";
	}
	for(k=0;k<len;k++)
	{
		arr = document.forms[0].subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strsubheadid)
			{
				document.forms[0].elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strsubheadid!="")
	{

		if(!isNaN(strsubheadid))
		{
			document.forms[0].chksublimit.checked=true;
		}
		else
		{
			document.forms[0].chksublimit.checked=false;
		}
		document.all.ifrm2.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strsubheadid
									 +"&value=subsel&hidMethod=getFacility&factid="+strsubfacid+"&strtype=sublimit";
	}
	else
	{
		document.forms[0].chksublimit.checked=false;
	}
	if(vargrp=="0")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			disableCommandButtons(false,false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
	else
	{
		
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			disableCommandButtons(true,false,true,true,false,true);
		}
		else
		{
			disableCommandButtons(true,true,true,true,true,false);
		}
	}
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
}

function onloading()
{	  
var varLimitAvil ="<%=Helper.correctNull((String)hshValues.get("strLimitAvil"))%>";
	if(varAppno=='NEW')
	{
		if(varappstatus=='false' || varappstatus=='')
		{	
			disableCommandButtons(true,true,false,true,true,false);
			disableFields(false);
			document.forms[0].hidfactype.value="limit";
		}
		else
		{
			alert("You can not create a new Adhoc proposal, Since Old Adhoc proposal is not closed");
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
			document.forms[0].target="mainFrame";
			document.forms[0].submit();
		}
		if(varLimitAvil!='')
		{
			alert(varLimitAvil);
		}
		
	}
	else
	{
		disableFields(true);
		//disableCommandButtons(false,true,true,true,true,false);
	}
	
}

function doSave()
{
	if(document.forms[0].hidfactype.value=="limit")
	{
		if(document.forms[0].facility_head.selectedIndex == "0")
		{
			ShowAlert(111,'Facility Head');
			document.forms[0].facility_head.focus();
			return false;
		}
		else if(document.forms[0].facility.value == "-")
		{
			ShowAlert(111,'Facility Type');
			document.forms[0].facility.focus();
			return false;
		}
		else if((document.forms[0].txt_amt.value == "") || (document.forms[0].txt_amt.value == "0.00")) 
		{
			ShowAlert(121,'Amount');
			document.forms[0].txt_amt.focus();
			return false;
		}
		
	}
	else
	{
		if(document.forms[0].subfacility_head.selectedIndex == "0")
		{
			ShowAlert(111,'Facility Head for Sublimit');
			document.forms[0].subfacility_head.focus();
			return false;
		}
		else if(document.forms[0].subfacility.value == "-")
		{
			ShowAlert(111,'Facility Type for Sublimit');
			document.forms[0].subfacility.focus();
			return false;
		}
		else if((document.forms[0].txt_subamt.value == "") || (document.forms[0].txt_subamt.value == "0.00")) 
		{
			ShowAlert(121,'Amount');
			document.forms[0].txt_subamt.focus();
			return false;
		}
	}
	
	if(document.forms[0].category[0].checked==true)
	{
		document.forms[0].faccategory.value="R";
	}
	else if(document.forms[0].category[1].checked==true)
	{
		document.forms[0].faccategory.value="A";
	}

	document.forms[0].hidBeanId.value="adhoc";		
	document.forms[0].hidSourceUrl.value="/action/adc_facilities.jsp";
	document.forms[0].hidBeanGetMethod.value="updateFacilityData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanGetMethod.value="updateFacilityData";	
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidSourceUrl.value="action/adc_facilities.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    document.forms[0].hideditflag.value="Y";
    disableCommandButtons(true,true,false,true,false,true);
    if(document.forms[0].hidfactype.value=="sublimit")
    {
   		document.forms[0].hidfacgrp.value=document.forms[0].hidsno.value;
    	document.forms[0].subfacility_head.focus();
    }
    else
    {
  		document.forms[0].facility_head.value="-";
  		document.forms[0].facility.value="0";
		document.forms[0].txt_amt.value="";
		document.forms[0].txt_outstanding.value="";
		document.forms[0].txt_int.value="";
		document.forms[0].txt_outstandingason.value="";
		document.forms[0].txt_security.value="";
		document.forms[0].txt_overdue.value="";
		document.forms[0].txt_margin.value="";
		document.forms[0].txt_period.value="";
		document.forms[0].txt_cbsno.value="";
		document.forms[0].hidfactype.value="limit";
	}
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	document.forms[0].hideditflag.value="Y";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].facility_head.focus();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="adhoc";
		document.forms[0].hidBeanGetMethod.value="getFacilityData";
		document.forms[0].action=appURL+"action/adc_facilities.jsp";
		document.forms[0].submit();
	}
}
   
 function disableCommandButtons(cmdnew,cmdedit,cmdapply,cmddel,cmdcancel,cmdclose)
 {  
	  document.forms[0].cmdnew.disabled =cmdnew;
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdapply.disabled=cmdapply;
	  document.forms[0].cmddel.disabled=cmddel;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callSublimit()
{
	if(document.forms[0].chksublimit.checked && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Can't check in edit mode or add mode");			
		return;
	}
	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hideditflag.value=="Y")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck");			
		return;
	}
	
	if(document.forms[0].chksublimit.checked==false && document.forms[0].hidfacgrp.value!="0")
	{
		document.forms[0].chksublimit.checked=true;
		alert("Can't uncheck sublimit exists");			
		return;
	}
	
	
	if(document.forms[0].hidsno.value=="")
	{
		document.forms[0].chksublimit.checked=false;
		alert("Select Main Limit");
		return;
	}
	if(document.forms[0].chksublimit.checked)
	{
		document.forms[0].hidfactype.value="sublimit";
		disableCommandButtons(false,true,true,true,true,false);
	}
	else
	{
		document.forms[0].hidfactype.value="limit";
		disableCommandButtons(false,false,true,true,true,false);
	}
}

function getFacility(strtype)
{	
	if(strtype=="facility")
	{
		document.forms[0].hidGrpList.value="";
		arr1=document.forms[0].facility_head.value.split("~");		
		var facilityhead = document.forms[0].elements["facility_head"].value;
		
		arr = facilityhead.split("-");
		var parentparam =arr[0];
		if(parentparam)
		{
			document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="
			+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility";
		}
	}
	else if(strtype=="sublimit")
	{		
		var subfacilityhead = document.forms[0].elements["subfacility_head"].value;
		arr = subfacilityhead.split("-");
		var parentparam =arr[0];			
		if(parentparam)
		{
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="
		+parentparam+"&value=subsel&hidMethod=getFacility&strtype=sublimit";
		}
		else
		{			
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=1;
		}
	} 
 }
 
function selectSublimit()
{
	if(document.forms[0].chksublimit.checked==false)
	{
		alert("Check sublimit option");
		document.forms[0].subfacility_head.selectedIndex=0;
 		return;
	}

}

function opendisfixed(field)
{
	if (document.forms[0].cmdapply.disabled == false)
	{
	var num="-";
	
	  var purl = appURL+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
	
	
}
function callCalender(val)
{
	if(document.forms[0].cmdapply.disabled==false)
	{
		 showCal(appURL,val);
	}
}
</script>
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}

</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="facility"><lapstab:applurllinksadc pageid="1" />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	bgcolor="#DEDACF" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>

		<td class="page_flow"><b><i>Home
		-&gt; Corporate &amp;SME -&gt; Ad hoc Limits-&gt;</i></b><b><i>Facilities</i></b></td>
	</tr>

</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	bgcolor="#DEDACF" height="10" class="outertable border1">
	<tr>
		<td width="14%" align="center"><b> Application No : </b></td>

		<td width="20%"><b> <input type="text" name="appno" size="20"
			value="<%=strAppno%>" readonly="readonly"
			style="border:0;background-color:#DEDACF"> </b></td>

		<td width="14%" align="center"><b> Applicant Name: </b></td>

		<td width="27%"><b> <input type="text" name="appname"
			style="border:0;background-color:#DEDACF" size="80" readonly="readonly"
			value="<%=appname%>"> </b></td>

		<td width="11%" align="center"><b> Status: </b></td>

		<td width="19%">
		<b> <font color='#003399'><%=strappstatus%></font>
			<input type="hidden" name="appstatus"	value="<%=appstatus%>"> </b> 
			<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
			<input type="hidden" name="com_id" value="<%=applicantid%>"> 
			<input type="hidden" name="valuesin" value="<%=Valuesin%>">
			<input type="hidden" name="hidcatory" value="<%=hidcatory%>">
			<input type="hidden" name="btnenable" value="<%=strBtnenable%>">
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	bgcolor="#DEDACF" class="outertable border1"
	height="400">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable border1" height="100%">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top">

						<table width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td width="3%"><input type="radio" name="category"
									style="border-style:none" checked="checked" >
								</td>

								<td width="7%">Main Limit</td>
								<td>&nbsp;</td>
								<td width="7%">&nbsp;</td>
								<td width="3%"><input type="radio" name="category"
									style="border-style:none" ></td>
								<td>Adhoc</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>


								<table width="100%" border="0" cellspacing="1" cellpadding="2">
									<tr> 
                              <td width="23%" align="left" height="25">Facility 
                                Head</td>
                              <td align="left" width="30%" height="25"> 
                                <%HashMap hp1 = new HashMap();%>
                                <select name="facility_head"
											onChange="javascript:getFacility('facility')">
                                  <option selected value="-">----Select----</option>
                                  <%HashMap h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");

			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);

			%>
                                  <laps:selecttag value="<%= hp1%>" /> 
                                </select>
                                <input type="hidden" name="hid_facility_head">
                              </td>
                              <td height="25" align="left" width="27%">Facility</td>
                              <td height="25" align="left" width="20%"> 
                                <select
											name="facility">
                                  <option selected="selected">----Select----</option>
                                </select>
                                <input type="hidden" name="hid_facility">
                              </td>
                            </tr>
									<tr>
										<td align="left" width="27%">Amount</td>
										<td align="left" width="25%"><laps:CurrencyTag name="txt_amt"
											size="13" maxlength="10" /></td>
										<td align="left" nowrap="nowrap" width="22%">Outstanding</td>
										<td align="left" width="26%"><laps:CurrencyTag
											name="txt_outstanding" size="13" maxlength="10" /></td>
									</tr>
									<tr>
										<td align="left" width="27%">Interest/ Discount/ Commission
										(%)</td>
										<td align="left" width="25%"><input type="text"
											name="txt_int" size="20" maxlength="18"
											onKeyPress="notAllowSplChar"></td>
										<td align="left" nowrap="nowrap" width="22%">Outstanding as on</td>
										<td width="26%"><input type="text" name="txt_outstandingason"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
											alt="Select date from calender" href="#"
											onClick="callCalender('txt_outstandingason')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;">&nbsp;<img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>

									</tr>
									<tr>
										<td align="left" nowrap="nowrap" width="27%">Value of Securities</td>
										<td align="left" width="25%"><laps:CurrencyTag
											name="txt_security" size="13" maxlength="10" /></td>
										<td align="left" width="22%">Overdues, if any</td>
										<td align="left" width="26%"><textarea name="txt_overdue"
											wrap="VIRTUAL" cols="40" onKeyPress="notAllowSplChar(this);textlimit(this,3999)"
													onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
									<tr>
										<td align="left" nowrap="nowrap" width="27%">Margin (%)</td>
										<td align="left" width="25%"><laps:CurrencyTag
											name="txt_margin" size="13" maxlength="3" onBlur="checkPercentage(this)"/></td>
										<td align="left" width="22%">Period (in Months)</td>
										<td width="26%"><input type="text" name="txt_period"
											size="16" onKeyPress="allowNumber(this)" maxlength="3"></td>
									</tr>
									<tr>
										<td align="left" width="27%">CBS Account Number</td>
										<td width="25%"><input type="text" name="txt_cbsno" size="18"
											maxlength="15"></td>
										<td align="left" width="22%">&nbsp;</td>
										<td width="26%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable border1">
							<tr>
								<td>


								<table width="100%" border="0" cellspacing="1" cellpadding="1">
									<tr valign="middle">
										<td colspan="4">Sub -
										Limits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <input type="checkbox"
											name="chksublimit" value="N" style="border:none"
											onClick="callSublimit()"></td>
									</tr>
									<tr> 
                              <td width="23%" align="left" nowrap="nowrap">Sub-Limit Head</td>
                              <td align="left" width="30%"> 
                                <select name="subfacility_head"
											onChange="javascript:getFacility('sublimit');selectSublimit()">
                                  <option selected value="-">----Select----</option>
                                  <%h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");
			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);

			%>
                                  <laps:selecttag value='<%= hp1%>' /> 
                                </select>
                                <input type="hidden" name="hid_subfacility_head">
                              </td>
                              <td width="27%" align="left">Sub-Limit</td>
                              <td width="20%" align="left"> 
                                <select name="subfacility">
                                  <option selected="selected">----Select----</option>
                                </select>
                                <input type="hidden" name="hid_subfacility">
                              </td>
                            </tr>
									<tr>
										<td align="left" width="27%">Amount</td>
										<td align="left" width="25%"><laps:CurrencyTag
											name="txt_subamt" size="13" maxlength="10" /></td>
										<td align="left" width="22%">Outstanding</td>
										<td width="26%" align="left"><laps:CurrencyTag
											name="txt_suboutstanding" size="13" maxlength="10" /></td>
									</tr>
									<tr>
										<td align="left" width="27%">Interest/ Discount/ Commission
										(%)</td>
										<td align="left" width="25%"><input type="text"
											name="txt_subint" size="20" maxlength="18"
											onKeyPress="notAllowSplChar"></td>
										<td align="left" nowrap="nowrap" width="22%">Outstanding as on</td>
										<td width="26%"><input type="text"
											name="txt_suboutstandingason"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"> <a
											alt="Select date from calender" href="#"
											onClick="callCalender('txt_suboutstandingason')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;">&nbsp;<img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border=0 alt="Select date from calender"></a></td>
									</tr>
									<tr>
										<td align="left" nowrap="nowrap" width="27%">Value of Securities</td>
										<td align="left" width="25%"><laps:CurrencyTag
											name="txt_subsecurity" size="13" maxlength="10" /></td>
										<td align="left" width="22%">Overdues, if any</td>
										<td width="26%" align="left"><textarea name="txt_suboverdue"
											wrap="VIRTUAL" cols="40" onKeyPress="notAllowSplChar(this);textlimit(this,3999)"
													onKeyUp="textlimit(this,3999)"></textarea>
										</td>
									</tr>
									<tr>
										<td align="left" nowrap="nowrap" width="27%">Margin (%)</td>
										<td align="left" width="25%"><laps:CurrencyTag
											name="txt_submargin" size="13" maxlength="10" onBlur="checkPercentage(this)"/></td>
										<td align="left" width="22%">Period (in Months)</td>
										<td width="26%"><input type="text" name="txt_subperiod"
											size="16" onKeyPress="allowNumber(this)" maxlength="3"></td>
									</tr>
									<tr>
										<td align="left" width="27%">CBS Account Number</td>
										<td width="25%"><input type="text" name="txt_subcbsno"
											size="18" maxlength="15"></td>
										<td align="left" width="22%">&nbsp;</td>
										<td width="26%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>

						<laps:combutton btntype="NO" btnenable='<%=strBtnenable%>' />
						<br>
						</td>
					</tr>

					<tr>
						<td>


						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr>
								<td bgcolor="#CEC4B0" height="32">&nbsp;</td>
								<td align="center" bgcolor="#CEC4B0" height="32">Facility Head</td>
								<td align="center" bgcolor="#CEC4B0" height="32">Facility</td>
								
                        <td align="center" bgcolor="#CEC4B0" height="32">Amount</td>
								
                        <td width="7%" align="center" bgcolor="#CEC4B0" height="32">OutStanding 
                          as on<br>
								</td>

								
                        <td align="center" bgcolor="#CEC4B0" height="32">Value 
                          of Securities</td>
								
                        <td align="center" bgcolor="#CEC4B0" height="32">Overdues, 
                          if any</td>
							</tr>
						
							<%String strSno = "";
							String strcol = "";
			double dblamt = 0.0;
			double dblamtoutstanding = 0.0;
			if (arrRow != null && arrRow.size() > 0)
			{
				if (arrRow.size() > 0) 
				{
					int count = 0;
					for (int i = 0; i < arrRow.size(); i++) 
					{
						arrCol = (ArrayList) arrRow.get(i);
						strSno = Helper.correctNull((String) arrCol.get(13));
						if (Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("0")) 
						{
							dblamt = dblamt + Double.parseDouble(Helper.correctDouble((String) arrCol.get(3)));
							dblamtoutstanding = dblamtoutstanding + Double.parseDouble(Helper.correctDouble((String) arrCol.get(6)));
							count = 0;
							strcol = Helper.correctNull((String) arrCol.get(16));
							if(strcol.equalsIgnoreCase("R"))
							{
								strcol="#000000";
							}
							else if(strcol.equalsIgnoreCase("A"))
							{
								strcol="#CC3300";
							}
								
							
							%>
							<tr bgcolor="#F5F3EF">
								<td width="5%" align="center">
									<input type="radio"
									style="border:none" name="rdoUser"
									onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(12))%>')">
									<input type="hidden" name="hidfachead<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> 
									<input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(2))%>" />
									<input type="hidden" name="hidamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
									<input type="hidden" name="hidoutstanding<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>" />
									<input type="hidden" name="hidint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(4))%>" />
									<input	type="hidden" name="hidoutstandingason<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>" />
									<input type="hidden" name="hidsecurity<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(9))%>" />
									<input type="hidden" name="hidoverdue<%=strSno%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(10))%>" />
									<input type="hidden" name="hidmargin<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>" />
									<input type="hidden" name="hidperiod<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(8))%>" />
									<input type="hidden" name="hidcbsno<%=strSno%>"	value="<%=Helper.correctNull((String)arrCol.get(11))%>" />
									<input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(13))%>" />
									<input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(12))%>" />
									<input type="hidden" name="hidcategory<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(16))%>" />
								</td>
								<td width="20%" align="left"> <font color="<%=strcol%>"> &nbsp; <%=Helper.correctNull((String) arrCol.get(14))%> </font></td>
								<td width="18%" align="left"><font color="<%=strcol%>">&nbsp;<%=Helper.correctNull((String) arrCol.get(15))%> </font></td>
								<td width="14%" align="right"><font color="<%=strcol%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%> </font></td>
								<td width="20%" align="right"><font color="<%=strcol%>">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%> </font></td>
								<td align="right" width="12%"><font color="<%=strcol%>">&nbsp;<%=Helper.correctNull((String) arrCol.get(9))%> </font></td>
								<td width="11%"><font color="<%=strcol%>">&nbsp;<%=Helper.correctNull((String) arrCol.get(10))%> </font></td>
							</tr>
									<%
									}
						else if (!Helper.correctNull((String) arrCol.get(12)).equalsIgnoreCase("0"))
									{
							
							strcol = Helper.correctNull((String) arrCol.get(16));
							
							if(strcol.equalsIgnoreCase("R"))
							{
								strcol="#000000";
							}
							else if(strcol.equalsIgnoreCase("A"))
							{
								strcol="#CC3300";
							}
									%>
									<tr>
										<%
										if (count == 0)
										{
										%>
										<td width="5%">&nbsp;</td>
										<td colspan="6" bgcolor="#EAE4DB"><b>&gt;&gt;Sub Limit </b></td>
									</tr>
									<tr>
										<%
										}
										
							%>
							<td width="5%" align="center">
								<input type="radio"
								style="border:none" name="rdoUser"
								onClick="javascript:selectValues('<%=strSno%>','<%=Helper.correctNull((String)arrCol.get(12))%>')">
								<input type="hidden" name="hidfachead<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(1))%>" /> 
								<input type="hidden" name="hidfacility<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(2))%>" />
								<input type="hidden" name="hidamt<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>" />
								<input type="hidden" name="hidoutstanding<%=strSno%>" value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>" />
								<input type="hidden" name="hidint<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(4))%>" />
								<input	type="hidden" name="hidoutstandingason<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(7))%>" />
								<input type="hidden" name="hidsecurity<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(9))%>" />
								<input type="hidden" name="hidoverdue<%=strSno%>" value="<%=Helper.correctDoubleQuotesHtml((String)arrCol.get(10))%>" />
								<input type="hidden" name="hidmargin<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(5))%>" />
								<input type="hidden" name="hidperiod<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(8))%>" />
								<input type="hidden" name="hidcbsno<%=strSno%>"	value="<%=Helper.correctNull((String)arrCol.get(11))%>" />
								<input type="hidden" name="hidfacsno<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(13))%>" />
								<input type="hidden" name="hidfacgroup<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(12))%>" />
								<input type="hidden" name="hidcategory<%=strSno%>" value="<%=Helper.correctNull((String)arrCol.get(16))%>" />
							</td>
							<td width="20%" align="left" bgcolor="#EAE4DB"><font color="<%=strcol%>">&nbsp;<%=Helper.correctNull((String) arrCol.get(14))%></font></td>
							<td width="18%" align="left" bgcolor="#EAE4DB"><font color="<%=strcol%>">&nbsp;<%=Helper.correctNull((String) arrCol.get(15))%></font></td>
							<td width="14%" align="right" bgcolor="#EAE4DB"><font color="<%=strcol%>">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(3))))%>)</font>&nbsp;</td>
							<td width="20%" align="right" bgcolor="#EAE4DB"><font color="<%=strcol%>">(<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) arrCol.get(6))))%>)</font>&nbsp;</td>
							<td align="right" width="12%" bgcolor="#EAE4DB"><font color="<%=strcol%>"><%=Helper.correctNull((String) arrCol.get(9))%></font>&nbsp;</td>
							<td width="11%" bgcolor="#EAE4DB"><font color="<%=strcol%>"><%=Helper.correctNull((String) arrCol.get(10))%></font>&nbsp;</td>
						</tr>
									<%count++;
						}
					}
				}

				%>
									<tr bgcolor="#FFFFFF">
										<td colspan="2">&nbsp;</td>
										<td align="right"><b>Total</b></td>
										<td align="right">&nbsp;<%=Helper.formatDoubleValue(dblamt)%></td>
										<td align="right" width="20%">&nbsp;<%=Helper.formatDoubleValue(dblamtoutstanding)%></td>
										<td width="12%">&nbsp;</td>
										<td align="right" width="11%">&nbsp;</td>
									</tr>
									<%} else {

			%>
									<tr>
										<td align="center" colspan="7">No Data Found</td>
									</tr>
									<%}

		%>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<laps:hiddentag />
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidfacgrp" value="">
<input type="hidden" name="hidfactype">
<input type="hidden" name="hidGrpList">
<input type="hidden" name="hidvaluesin" value="<%=Helper.correctNull((String) hshValues.get("valuesin"))%>">
<input	type="hidden" name="faccategory" value="">
<iframe	height="0" width="0" id="ifrm1" frameborder=0 style="border:0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder=0 style="border:0"></iframe>

<script>
     var msg ="<%=Helper.correctNull((String)hshValues.get("msg"))%>";
     if(msg!="")
     {
   	  alert(msg);
     }
</script>
</form>
</body>
</html>

