<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues
					.get("app_status"));
			 
			%>

<html>
<head>
<title>CAPL Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 100;
  overflow: auto;
}
</STYLE>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var txt_mainoccupation= "<%=Helper.correctNull((String)hshValues.get("txt_mainoccupation"))%>"
var txt_subsidaryoccupation= "<%=Helper.correctNull((String)hshValues.get("txt_subsidaryoccupation"))%>" 
var txt_proposedactivity= "<%=Helper.correctNull((String)hshValues.get("txt_proposedactivity"))%>" 
var txt_place= "<%=Helper.correctNull((String)hshValues.get("txt_place"))%>" 
var txt_distance= "<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>" 
var txt_place1= "<%=Helper.correctNull((String)hshValues.get("txt_place1"))%>" 
var txt_distance1= "<%=Helper.correctNull((String)hshValues.get("txt_distance1"))%>" 
var sel_labour = "<%=Helper.correctNull((String)hshValues.get("sel_labour"))%>" 
var txt_labourers = "<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>"  
var txt_wage = "<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>" 


var txt_income= "<%=Helper.correctNull((String)hshValues.get("txt_income"))%>" 

</script>

<script>


function onloading()
{	  
	if (document.forms[0].app_status.value!="")
	{
		if (document.forms[0].app_status.value=="pa")
		{	
			 document.forms[0].cmdnew.disabled = true;
			 document.forms[0].cmdedit.disabled = true;
			 alert("unable to modify APPROVED APPLICATION !!!")
		}
	}
	document.forms[0].txt_mainoccupation.value=txt_mainoccupation;
	document.forms[0].txt_subsidaryoccupation.value=txt_subsidaryoccupation;
	document.forms[0].txt_proposedactivity.value=txt_proposedactivity;
	document.forms[0].txt_place.value=txt_place;
	document.forms[0].txt_distance.value=txt_distance;
	document.forms[0].txt_place1.value=txt_place1;
	document.forms[0].txt_distance1.value=txt_distance1;
	
	if(sel_labour!="")
	{
		document.forms[0].sel_labour.value=sel_labour;
	}
	
	document.forms[0].txt_labourers.value=txt_labourers;
	document.forms[0].txt_wage.value=txt_wage;
	document.forms[0].txt_income.value=txt_income;
	disableFields(true);
	enableButtons(true, true, true, true, true, false);
		
}
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}
function doSave()
{   
    enableButtons(true, true, true, true, true, false);
	document.forms[0].hidBeanId.value="agrcoffee";		
	document.forms[0].hidSourceUrl.value="/action/agr_seri_apprisal.jsp";
	document.forms[0].hidBeanMethod.value="updateseritechdata";
	document.forms[0].hidBeanGetMethod.value="getseritechdata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(true);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidAction1.value ="insert1";
	document.forms[0].hidAction2.value ="insert2";
	enableButtons(true, true, false, false, true, true);		
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_seri_apprisal.jsp";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidBeanGetMethod.value="getseritechdata";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"agr_seri_apprisal.jsp";
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
		
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
	 	if(document.forms[0].elements[i].type=='checkbox')
	 	{
			document.forms[0].elements[i].disabled=one;
	 	}
		  
	}
}


function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
	    document.forms[0].hidAction1.value ="delete1";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateseritechdata";
		document.forms[0].hidBeanGetMethod.value="getseritechdata";
		document.forms[0].hidBeanId.value="agrcoffee";
		document.forms[0].hidSourceUrl.value="action/agr_seri_apprisal.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function checklabour()
{
	if(document.forms[0].sel_labour.value == "2")
	{
		document.all.r1.style.visibility="visible";
		document.all.r2.style.visibility="visible";		
	}
	else
	{
		document.all.r1.style.visibility="hidden";
		document.all.r2.style.visibility="hidden";		
		document.forms[0].txt_labourers.value="";
		document.forms[0].txt_wage.value="";
	}
}
function chkcentgunt() 
{
	if(document.forms[0].land_measurement.value == 'g')
	{
		if(document.forms[0].txt_guntas.value > 39)
		{
		 	alert("The Data you entered is not valid");
		 	document.forms[0].txt_guntas.value = "";
		 	document.forms[0].txt_guntas.focus();
		}
	}
}

</script>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
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
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();checklabour()">
	<form name="frmpri" method="post">
  <table width="100%"  border="0" cellpadding="3" cellspacing="0">
    <tr> 
      <td width="25%"></td>
      <td width="24%"></td>
      <td width="12%"></td>
      <td width="8%"></td>
      <td> </td>
      <td width="1%"> </td>
      <td width="1%"></td>
      <td width="2%"></td>
    </tr>
    <tr> 
      <td>Main Occupation</td>
      <td> 
        <input type="text" name="txt_mainoccupation"  value="<%=Helper.correctNull((String)hshValues.get("txt_mainoccupation"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        <br>
         </td>
      <td colspan="2">Subsidary Occupation</td>
      <td nowrap> 
        <input type="text" name="txt_subsidaryoccupation"  value="<%=Helper.correctNull((String)hshValues.get("txt_subsidaryoccupation"))%>"  size="30%"  maxlength="30">
        <br>
         </td>
    </tr>
    <tr> 
      <td>Knowledge &amp; Experience in proposed 
        Activity </td>
      <td> 
        <input type="text" name="txt_proposedactivity"  value="<%=Helper.correctNull((String)hshValues.get("txt_proposedactivity"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        </td>
      <td colspan="3">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="5" align="center"> <strong>Availibility 
        of Eggs</strong></td>
    </tr>
    <tr> 
      <td>Place</td>
      <td>&nbsp;  
        <input type="text" name="txt_place"  value="<%=Helper.correctNull((String)hshValues.get("txt_place"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        </td>
      <td colspan="2">Distance from Farm</td>
      <td ><b> 
        <input type="text" name="txt_distance"  value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="15">
        (Km) </b></td>
      <br>
    <tr> 
      <td colspan="12" align="center"><strong>Marketing 
        of cocoons</strong></td>
    <tr> 
      <td>Place</td>
      <td> 
        <input type="text" name="txt_place1"  value="<%=Helper.correctNull((String)hshValues.get("txt_place1"))%>"  size="30%" onKeyPress="notAllowSplChar()" maxlength="30">
        </td>
      <td colspan="2">Distance from Farm</td>
      <td  ><b> 
        <input type="text" name="txt_distance1"  value="<%=Helper.correctNull((String)hshValues.get("txt_distance1"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="15">
        (Km) </b></td>
    <tr> 
      <td>Labourers to be Employed</td>
      <td><select value="0"
											name="sel_labour" onChange="checklabour()">
          <option value="0" selected>--Select--</option>
          <option value="1">Family Labour</option>
          <option value="2">Labour Employed</option>
        </select></td>
      <td colspan="2" id="r1">No of labourers<b> 
        <input type="text" name="txt_labourers"  value="<%=Helper.correctNull((String)hshValues.get("txt_labourers"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="15">
        </b></td>
      <td id="r2">Wages per Employee(Rs.)<b> 
        <input type="text" name="txt_wage"  value="<%=Helper.correctNull((String)hshValues.get("txt_wage"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="15">
        per month</b></td>
    <tr> 
      <td rowspan="2">Net annual income from 
        existing arrangements(Rs.)</td>
      <td rowspan="2"><b> 
        <input type="text" name="txt_income"  value="<%=Helper.correctNull((String)hshValues.get("txt_income"))%>"  size="20%" onKeyPress="allowNumber(this)" maxlength="15">
        </b></td>
      <td rowspan="2">Net annual income from 
        Proposed Limit(Rs.)</td>
      <td><strong>I year</strong></td>
      <td><strong>II Year(Onwards)</strong></td>
    
    <tr> 
      <td>
        <input type="text" name="txt_totalincomeiyear" maxlenght="10"
											size="15" style="text-align:left" value="<%=Helper.correctNull((String)hshValues.get("txt_totalincomeiyear"))%>" onBlur="">
        </td>
      <td>
        <input type="text" name="txt_totalincomeiiyear" maxlenght="10"
											size="15" style="text-align:left" value="<%=Helper.correctNull((String)hshValues.get("txt_totalincomeiiyear"))%>" onBlur="">
        </td>
  </table>
  <br>
<br>
						<table width="12%" border="0" align="center" cellpadding="0"
							cellspacing="0" class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="2">
									<tr valign="top">
																				<td align="center"><input type="button" name="cmdedit"
											value="Edit"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doEdit()">
										</td>
										<td align="center">
										<input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doSave()">
										</td>
										<td align="center"><input type="button" name="cmdcancel"
											value="Cancel"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doCancel()" >
										</td>
										<td><input type="button" name="cmddel"
											value="Delete"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor"  onClick="doDelete()"></td>
										<td><input type="button" name="cmdhelp2"
											value="Help"
											style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											 ></td>
										<td><input type="button" name="cmdclose"
											value="Close"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="doClose()" ></td>
										 
									</tr>
								</table>
								</td>
							</tr>
						</table>
		<%String strappno = request.getParameter("appno");%>

		<td><input type="hidden" name="hidAction">
		<input type="hidden" name="hidAction1"> 
			<input type="hidden" name="hidAction2">
		<input type="hidden"
			name="hidBeanId" value=""> <input type="hidden"
			name="hidBeanMethod" value=""> <input type="hidden"
			name="hidBeanGetMethod" value=""> <input type="hidden"
			name="hidSourceUrl" value=""> <input type="hidden" name="hidApp_type"
			value="A"> <input type="hidden" name="hidflag" value=""> <input
			type="hidden" name="hideditflag"> <input type="hidden" name="selsno"
			value=""> <input type="hidden" name="hidval">  <input
			type="hidden" name="page">  
		 <input
			type="hidden" name="radLoan" value="Y">   <input
			type="hidden" name="app_status" value="<%=app_status%>">  <input type="hidden"
			name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
			<input type ="hidden" name="land_measurement" value ="<%=Helper.correctNull((String)hshValues.get("land_measurement"))%>">

</form>

</body>
</html>



