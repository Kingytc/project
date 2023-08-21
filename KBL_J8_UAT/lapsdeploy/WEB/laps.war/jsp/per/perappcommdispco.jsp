<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
String strEmployment="";
String appid = Helper.correctNull((String)hshValues.get("perapp_id"));		
strEmployment=Helper.correctNull((String)hshValues.get("perapp_employment"));
String pageid = Helper.correctNull((String) request.getParameter("pageid"));
String strapptype = Helper.correctNull((String)request.getParameter("corp"));
session.setAttribute("strEmployment",strEmployment);
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>

<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script LANGUAGE="JavaScript">
var sel_residence="<%=Helper.correctNull((String)hshValues.get("sel_residence"))%>";
var chk_offaddress="<%=Helper.correctNull((String)hshValues.get("chk_offaddress"))%>";
var chk_offaddress1="<%=Helper.correctNull((String)hshValues.get("chk_offaddress1"))%>";
var chk_commaddress="<%=Helper.correctNull((String)hshValues.get("chk_commaddress"))%>";
var app_constitution="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>";
var perapp_id="<%=Helper.correctNull((String)hshValues.get("hidDemoId"))%>";

function showres()
{	
	
	if(app_constitution=="01" || app_constitution=="02" || app_constitution=="") 
	{	

		document.all.add1.style.visibility="hidden";
		document.all.add1.style.position="absolute";
		document.all.add2.style.visibility="visible";
		document.all.add2.style.position="relative";
		
		document.all.chkAddress.style.visibility="hidden";
		document.all.chkAddress.style.position="absolute";		

		document.all.add_admin1.style.visibility="hidden";
		document.all.add_admin1.style.position="absolute";	
		
		document.all.add_admin2.style.visibility="hidden"; 
		document.all.add_admin2.style.position="absolute";	
		   
		document.all.add_admin12.style.visibility="hidden";
		document.all.add_admin12.style.position="absolute";	
		
		document.all.add_admin22.style.visibility="hidden"; 
		document.all.add_admin22.style.position="absolute";	
		 
		document.all.add_admin13.style.visibility="hidden";
		document.all.add_admin13.style.position="absolute";	
				
		document.all.add_admin23.style.visibility="hidden";
		document.all.add_admin23.style.position="absolute";	
		
		document.all.add_admin14.style.visibility="hidden"; 
		document.all.add_admin14.style.position="absolute";	
		   
		document.all.add_admin24.style.visibility="hidden";
		document.all.add_admin24.style.position="absolute";	
		
		document.all.add_admin15.style.visibility="hidden";  
		document.all.chkAddress.style.position="absolute";	
		
		document.all.add_admin25.style.visibility="hidden";		
		document.all.add_admin25.style.position="absolute";	
		
		document.all.add_admin16.style.visibility="hidden";
		document.all.add_admin16.style.position="absolute";	
		
		document.all.add_admin26.style.visibility="hidden";
		document.all.add_admin26.style.position="absolute";	
		    
		document.all.add_admin17.style.visibility="hidden";
		document.all.add_admin17.style.position="absolute";	
		
		document.all.add_admin27.style.visibility="hidden"; 
		document.all.add_admin27.style.position="absolute";	
		
		document.all.add_admin18.style.visibility="hidden";
		document.all.add_admin18.style.position="absolute";	
		
		document.all.add_admin28.style.visibility="hidden";
		document.all.add_admin28.style.position="absolute";	
		
		document.all.add_admin19.style.visibility="hidden";
		document.all.add_admin19.style.position="absolute";	
		
		document.all.add_admin29.style.visibility="hidden"; 
		document.all.add_admin29.style.position="absolute";	
		
		document.all.add_admin10.style.visibility="hidden";
		document.all.add_admin10.style.position="absolute";	
		
		document.all.add_admin20.style.visibility="hidden"; 
		document.all.add_admin20.style.position="absolute";	
		
		document.all.chkregaddress.style.visibility="hidden";
		document.all.chkregaddress.style.position="absolute";	
		 
		document.all.chkregaddress.style.position="absolute"; 
		
		document.all.chkcommaddress.style.visibility="visible";	
		document.all.chkcommaddress.style.position="relative";			
	}
	else
	{
		document.all.add1.style.visibility="visible";
		document.all.add1.style.position="relative";
		document.all.add2.style.visibility="hidden";
		document.all.add2.style.position="absolute";
		document.all.chkAddress.style.visibility="visible";
		
		document.all.add_admin1.style.visibility="visible";	
		document.all.add_admin2.style.visibility="visible";
		document.all.add_admin12.style.visibility="visible";
		document.all.add_admin22.style.visibility="visible";
		document.all.add_admin13.style.visibility="visible";		
		document.all.add_admin23.style.visibility="visible";	
		document.all.add_admin14.style.visibility="visible";
		document.all.add_admin24.style.visibility="visible";
		document.all.add_admin15.style.visibility="visible";
		document.all.add_admin25.style.visibility="visible";		
		document.all.add_admin16.style.visibility="visible";	
		document.all.add_admin26.style.visibility="visible";
		document.all.add_admin17.style.visibility="visible";
		document.all.add_admin27.style.visibility="visible";
		document.all.add_admin18.style.visibility="visible";
		document.all.add_admin28.style.visibility="visible";
		document.all.add_admin19.style.visibility="visible";
		document.all.add_admin29.style.visibility="visible";
		document.all.add_admin10.style.visibility="visible";
		document.all.add_admin20.style.visibility="visible";
		document.all.chkcommaddress.style.visibility="hidden"; 	
	}
}

function callfunction()
{
	disableFields(true);
	if(sel_residence=='0')
	{
		
		document.forms[0].sel_residence.options[0].selected=true;
		
	}
	else if(sel_residence=='1')
	{
			document.forms[0].sel_residence.options[1].selected=true;
	}
	else if(sel_residence=='2')
	{
			document.forms[0].sel_residence.options[2].selected=true;
	}
	else if(sel_residence=='3')
	{
			document.forms[0].sel_residence.options[3].selected=true;
	}
	else if(sel_residence=='4')
	{
			document.forms[0].sel_residence.options[4].selected=true;
	}
	else if(sel_residence=='5')
	{
			document.forms[0].sel_residence.options[5].selected=true;
	}
	if(chk_offaddress=='1')
	{
		
		document.forms[0].chk_offaddress.checked=true;
	}
	else if(chkcommaddress=='1')
		{
			document.forms[0].chkcommaddress.checked=true;
		}

	 if(chk_offaddress1=='2')
	{
		document.forms[0].chk_offaddress1.checked=true;
	}


		if(document.forms[0].chk_offaddress.checked)
		{
			disableFields(true);
		}
	 showres();
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
		else if(document.forms[0].elements[i].type=="checkbox")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		if(document.forms[0].hidModuleName.value=='T')
		{
			document.forms[0].action=appURL+"action/agrappmastersearch.jsp";	
			document.forms[0].submit();
		}
		else if(document.forms[0].hidModuleName.value=='P')
		{
			document.forms[0].action=appURL+"action/mastersearchper.jsp";
			document.forms[0].submit();
		}
		else 
		{
			document.forms[0].method="post";
			document.forms[0].action=appURL+"action/comappmastersearch.jsp";
			document.forms[0].submit();
		}
	}
}

</script>
</head>
<body onload="callfunction();">
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
<form name="appform" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="22" />
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
			<jsp:param name="subsubpageid" value="22"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="22"/>
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
		<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Applicant -&gt; customer profile -&gt; Communication details</td>
	</tr>
   
    <%}else
     {
     %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Communication details</td>
	</tr>
  </table>
   <%}}else if(strapptype.equalsIgnoreCase("R")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
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
		<tr>
		<%} if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="22"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
		<%} }%>

<table width="98%" border="1" cellspacing="0" cellpadding="3"  class="outertable" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable" align="center" >

<tr class="dataheader" id="add1">
    <td > Registered Office Address</td>
   
   	<td> Corporate Address</td>

	<td nowrap="nowrap" align="center">Administrative Office Address</td>
  </tr>
  <tr class="dataheader" id="add2">
   <td >Communication Address</td>
   <td > Permanent Address</td>
  </tr>
 </table> 
  <table cellpadding="3" cellspacing="1" width="90%" border="0" class="outertable" >
  <tr id="chk1">
                  <td colspan="2" id="busicommaddr" height="30">&nbsp;</td>
                  <td colspan="4" height="41"> 
                    <table width="90%" border="0" cellspacing="0"	cellpadding="0" class="outertable">
					<tr>
					     <td width="6%" nowrap >
					<input type="checkbox" name="chk_offaddress" onClick="getpmadd()" style="border-style:none" value="1"></td>
														
                        <td id="chkregaddress">Copy Registered Office Address</td>
														
                        <td  id="chkcommaddress">Copy Communication 
                          Address</td>
													</tr>
												</table>
												</td>
												
                  <td colspan="4" height="41"> 
                    <table width="90%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr id="chkAddress">
														<td width="38%" nowrap><input type="checkbox" name="chk_offaddress1" style="border-style:none" onClick="getpmadd1()" value="2">Copy Registered Office Address</td>
													
													</tr>
												</table>
												</td>
							</tr>
					<tr>
					<td>Address<b><span class="mantatory">*&nbsp;</span></b></td>
					<td> 
                      <input type="text" name="txtperapp_address1"
													size="35" maxlength="50" tabindex="18"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address1"))%>"
													onKeyPress=""></td>
												
                    <td  valign="top" >Address</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd1" size="35" maxlength="50"
													tabindex="28" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd1"))%>">
												</td>
												
                    <td valign="top"  id="add_admin1">Address</td>
												<td valign="top" style=" " colspan="2" id="add_admin2"><input type="text"
													name="txtperapp_adminadd1" size="35" maxlength="50"
													tabindex="28" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd1"))%>">
												</td>
											</tr>
											<tr>
												
                    <td align="center" width="12%">&nbsp;</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_address2"
													size="35" maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address2"))%>"
													onKeyPress=""></td>
												
                    <td valign="top" width="11%">&nbsp;</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd2" size="35" maxlength="50"
													tabindex="29" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd2"))%>">
												</td>
												
                    <td valign="top" width="12%" id="add_admin12">&nbsp;</td>
												<td valign="top" colspan="2" id="add_admin22"><input type="text"
													name="txtperapp_adminadd2" size="35" maxlength="50"
													tabindex="29" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd2"))%>">
												</td>
											</tr>
											<tr>
												
                    <td align="center" width="12%">Village/Taluk/Town</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_address3"
													size="35" maxlength="50" tabindex="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address3"))%>"
													onKeyPress=""></td>
												
                    <td valign="top" width="11%">Village/Taluk/Town</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd3" size="35" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd3"))%>">
												</td>
												
                    <td valign="top" width="12%" id="add_admin13">Village/Taluk/Town</td>
												<td valign="top" colspan="2" id="add_admin23"><input type="text"
													name="txtperapp_adminadd3" size="35" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd3"))%>">
												</td>
											</tr>
											<tr>
												
                    <td width="12%"> 
                      <div align="left">City <b><span class="mantatory">*&nbsp;</span></b></div>
												</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_city"
													size="25" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_city"))%>"
													onKeyPress="" ></td>
												
                    <td width="11%">City</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permcity"
													size="25" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcity"))%>"
													onKeyPress="" ></a>
												</td>
												
                    <td valign="top" width="12%" id="add_admin14">City</td>
												<td valign="top" colspan="2" id="add_admin24"><input type="text"
													name="txtperapp_admincity" size="25" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admincity"))%>" >
												</td>
												
											</tr>
											<tr>
												
                    <td width="12%"> 
                      <div align="left">District</div>
												</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_district"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_district"))%>"
													onKeyPress=""> </td>
												
                    <td width="11%">District</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permdistrict"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permdistrict"))%>"
													onKeyPress=""> 
												</td>
												
                    <td valign="top" width="12%" id="add_admin15">District</td>
												<td valign="top" colspan="2" id="add_admin25"><input type="text"
													name="txtperapp_admindistrict" size="35" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admindistrict"))%>">
												</td>
												
											</tr>
											<tr>
												
                    <td width="12%">State </td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_state"
													size="21" maxlength="25" tabindex="22"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_state"))%>"
													onKeyPress=""
													onBlur=""></td>
												
                    <td width="11%">State</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permstate" size="21" maxlength="20"
													tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permstate"))%>"
													onKeyPress=""
													onBlur="">
												</td>
												
                    <td width="12%" id="add_admin16">State</td>
												
                    <td colspan="2" id="add_admin26"> 
                      <input type="text"	name="txtperapp_adminstate" size="21" maxlength="20"
													tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminstate"))%>"
													onKeyPress=""
													onBlur="">
												</td>
											<tr>
												
                    <td width="12%"> 
                      <div align="left">Pin Code<span class="mantatory">*&nbsp;</span></div>
												</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_zip"
													size="12" maxlength="6"
													tabindex="23" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_zip"))%>"
													onKeyPress="allowInteger()"
													onBlur="">
												</td>
												
                    <td width="11%" >Pin Code</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permzip"	size="12" maxlength="6" tabindex="33" style="text-align:left"	  value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permzip"))%>"
													onKeyPress="allowInteger()" onBlur="">
												</td>
												
                    <td width="12%" id="add_admin17">Pin Code</td>
												
                    <td colspan="2" id="add_admin27"> 
                      <input type="text" name="txtperapp_adminzip"
													size="12" maxlength="6"
													tabindex="33" style="text-align:left"
													 value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminzip"))%>"
													onKeyPress="allowInteger()"
													onBlur="">
												</td>
											</tr>
											<tr>
												
                    <td nowrap width="12%" >Country<span class="mantatory">*&nbsp;</span></td>
												
                    <td width="18%" > 
                      <input type="text" name="txtperapp_country"
													size="25" maxlength="15" tabindex="24"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_country"))%>"
													onKeyPress=""><input type="hidden"
													name="hidperapp_country"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_country"))%>">
												</td>
												
                    <td width="11%">Country</td>
												
                    <td colspan="2"> 
                      <input type="text"	name="txtperapp_permcountry" size="25" maxlength="15"
													tabindex="34" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcountry"))%>"
													onKeyPress="">  
												</td>
													
                    <td width="12%" id="add_admin18">Country</td>
												
                    <td colspan="2" id="add_admin28"> 
                      <input type="text"	name="txtperapp_admincountry" size="25" maxlength="15"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admincountry"))%>"
													onKeyPress="">  
												</td>
											</tr>
											<tr>
												
                    <td nowrap width="12%">Phone No.(Res)</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_phone"
													size="20" maxlength="15" tabindex=""
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_phone"))%>"
													onKeyPress=""></td>
												
                    <td width="11%">Phone No.</td>
												
                    <td colspan="2"> 
                      <input type="text"	name="txtperapp_permphone" size="20" maxlength="15"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permphone"))%>"
													onKeyPress=""></td>
													
                    <td width="12%" id="add_admin19">Phone No.</td>
												
                    <td colspan="2" id="add_admin29"> 
                      <input type="text"	name="txtperapp_adminphone" size="20" maxlength="15"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminphone"))%>"
													onKeyPress=""></td>
												<!-- <td></td>-->
											</tr>
					<tr>
					<td nowrap width="12%">Phone No.(Off)</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_phoneoff"
													size="20" maxlength="15" tabindex=""
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_phoneoff"))%>"
													onKeyPress=""></td>
					<td colspan="6">&nbsp;</td>
					</tr>
											<tr>
												
                    <td nowrap width="12%">Fax No.</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_fax"
													size="20" maxlength="15" tabindex="25"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_fax"))%>"
													onKeyPress=""></td>
												
                    <td width="11%">Fax No.</td>
												
                    <td colspan="2"> 
                      <input type="text"
													name="txtperapp_permfax" size="20" maxlength="15"
													tabindex="35" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permfax"))%>"
													onKeyPress=""></td>
													
                    <td width="12%" id="add_admin10">Fax No.</td>
												
                    <td colspan="2" id="add_admin20"> 
                      <input type="text"
													name="txtperapp_adminfax" size="20" maxlength="15"
													tabindex="35" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminfax"))%>"
													onKeyPress=""></td>
												<!-- <td></td>-->
											</tr>
											<tr>
												
                    <td nowrap width="12%">Mobile No.</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_mobile"
													size="20" maxlength="10" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_mobile"))%>"
													onKeyPress=""
													onChange="min_nos(document.forms[0].txtperapp_mobile,10)">
												</td>
					<td nowrap width="12%">Website</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_website"
													size="35" maxlength="100" tabindex="26"
													style="text-align:left" readonly="readonly"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_website"))%>"
													onKeyPress=""
													onChange="" >
												</td>
                   
											</tr>
											<tr>
												
                    <td nowrap width="16%">E-mail.</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_email"
													size="30" maxlength="50" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_email"))%>"
													onKeyPress=""
													onChange=""
													onBlur="">
												</td>
					<td nowrap width="16%">E-mail</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_peremail"
													size="30" maxlength="50" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_peremail"))%>"
													onKeyPress=""
													onChange=""
													onBlur="">
												</td>
											</tr>
											<tr>
												
                    <td nowrap width="12%">Resident type<span class="mantatory">*&nbsp;</span></td>
												
                    <td width="18%"><select name="sel_residence" tabindex=""
					onChange="showres()">
					<option value="0" selected>--Select--</option>
					<option value="1">Rented</option>
					<option value="2">Owned</option>
					<option value="3">Leased</option>
					<option value="4">Family</option>
					<option value="5">Employer</option>
				</select></td>
												<td nowrap width="12%">No.of years staying in<br> the present address</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_noyears"
													size="5" maxlength="4" tabindex=""
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_noyears"))%>"
													onKeyPress=""
													onChange="" readOnly>
												</td>
											
											</tr>
											
										</table>
										
						</table>
						</td>
						</tr>
					</table>

<br>
<br>
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>


<input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
<input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>"> 
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidzipcontrol"	value="">
<input type="hidden" name="hidzipvaildatorcontrol"	value="">
 <input type="hidden" name="hidcitycontrol"	value="">
<input type="hidden" name="hidstatecontrol"	value="">
<input type="hidden" name="hidcitycodecontrol"	value="">
<input type="hidden" name="hidstatecodecontrol"	value="">
 <input type="hidden"name="hidzip">
<input type="hidden" name="hidCategory" />
<input type="hidden" name="hid_inwardno"/>
<input type="hidden" name="hidzip1" value="">
<input type="hidden" name="hidzip2" value="">
<input type="hidden" name="hidres1" value="">
<input type="hidden" name="hidres2" value="">
<input type="hidden" name="hidPage" value="<%=PageId%>">
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
<input type="hidden" name="app_constitution" value="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>">
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
 <input type="hidden" name="cmdsave" value="" disabled>
<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>
