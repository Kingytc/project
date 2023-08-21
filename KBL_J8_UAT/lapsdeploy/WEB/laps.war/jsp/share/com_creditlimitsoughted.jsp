<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%@ taglib prefix="lapstab" uri="/WEB-INF/lapstab.tld"%>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrRow= new ArrayList();
ArrayList arrCol= new ArrayList();
arrRow =(ArrayList)hshValues.get("arrRow");
String strSector=Helper.correctNull((String)request.getParameter("hidsector"));
String strSaral = Helper.correctNull((String) request.getParameter("hidsaral"));
String appstatus = (String) request.getParameter("appstatus");
String strValuesin=Helper.correctNull((String)request.getParameter("valuesin"));

if(strValuesin.equals("L"))
{
	strValuesin=" in Lacs";
}
else
{
	strValuesin="";
}
String strappholder =Helper.correctNull((String)request.getParameter("appholder"));
String strloanType =Helper.correctNull((String)request.getParameter("apploantype"));
String strappliedfor=Helper.correctNull((String)request.getParameter("appliedfor"));
%>

<html>
<head>
<title>Facility For Recommendation</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLevel="<%=strOrgLevel%>";
var appstatus="<%=appstatus%>";
function selectValues(val1,val2,val3)
{
	document.forms[0].selnaturefac.value=val2;
	document.forms[0].txt_limitapplied.value=val3;
	document.forms[0].hid_slno.value=val1;
	if (("<%=strSaral%>"=="saral"))
	{ //For Saral Application , Branch User Through Mail
			if(varOrgLevel=='A')
			{
			enableButtons(true,false,true,true,true);
			}
			else
			{
			enableButtons(true,true,true,true,true);
			}
	}
	else if((varOrgLevel=='D') && (document.forms[0].applevel.value=='S'))
	{ //For Saral Application , Saral User Link
			enableButtons(true,true,true,true,true);
	}
	else 
	{  //For all others
		if(varOrgLevel==document.forms[0].applevel.value && ((appstatus=="") || (appstatus=="Open/Pending")))
		{//For the users, in the application created organisation other than SARAL throgh link
			enableButtons(true,false,true,true,true);
		}
		else
		{//For the users, other than application created organisation other than SARAL throgh link
			enableButtons(true,true,true,true,true);
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
if (("<%=strSaral%>"=="saral"))
	{ //For Saral Application , Branch User Through Mail
			if(varOrgLevel=='A')
			{
			enableButtons(false,true,true,true,true);
			}
			else
			{
			enableButtons(true,true,true,true,true);
			}
	}
	else if((varOrgLevel=='D') && (document.forms[0].applevel.value=='S'))
	{ //For Saral Application , Saral User Link
			enableButtons(true,true,true,true,true);
	}
	else 
	{  //For all others
		if(varOrgLevel==document.forms[0].applevel.value && ((appstatus=="") || (appstatus=="Open/Pending")))
		{//For the users, in the application created organisation other than SARAL throgh link
			enableButtons(false,true,true,true,true);
		}
		else
		{//For the users, other than application created organisation other than SARAL throgh link
			enableButtons(true,true,true,true,true);
		}
	}
	disableFields(true);
}
function enableButtons(valnew,valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdnew.disabled=valnew;
	document.forms[0].cmdedit.disabled=valedit;	  	
	document.forms[0].cmdapply.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmddel.disabled=valdel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,false,true);
	document.forms[0].selnaturefac.focus();
}

function doSave()
{
	if(trim(document.forms[0].selnaturefac.value) == "")
	{
		ShowAlert(112,'Nature of Facility');
		return false;
	}
	else if(document.forms[0].txt_limitapplied.value == "")
	{
		ShowAlert(112,'Amount');
		return false;
	}
	
	document.forms[0].hidBeanId.value="lapsReport";		
	document.forms[0].hidSourceUrl.value="/action/com_creditlimitsoughted.jsp";
	document.forms[0].hidBeanMethod.value="updateComCreditLimitSought";
	document.forms[0].hidBeanGetMethod.value="getComCreditLimitSought";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanMethod.value="updateComCreditLimitSought";
		document.forms[0].hidBeanGetMethod.value="getComCreditLimitSought";
		document.forms[0].hidBeanId.value="lapsReport";		
		document.forms[0].hidSourceUrl.value="action/com_creditlimitsoughted.jsp";	
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
	}	
}

function doNew()
{
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
    disableCommandButtons(true,true,false,true,false,true);
  	document.forms[0].selnaturefac.value="";
	document.forms[0].txt_limitapplied.value="";
	document.forms[0].selnaturefac.focus();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="lapsReport";
		document.forms[0].hidBeanGetMethod.value="getComCreditLimitSought";
		document.forms[0].action=appURL+"action/com_creditlimitsoughted.jsp";
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
		if(document.forms[0].hidsaral && document.forms[0].hidsaral.value=="saral")
			{
				document.forms[0].method="post";
				document.forms[0].action=appURL+"action/mainnav.jsp";
				document.forms[0].submit();
			}
			else
			{
				if("<%=strloanType%>"=="C")
				{
				document.forms[0].method="post";	
				document.forms[0].action=appURL+"action/"+"corppge.jsp";
				document.forms[0].submit();
				}
				else if("<%=strloanType%>"=="P")
				{
				document.forms[0].action=appURL+"action/retailpge.jsp";
				document.forms[0].submit();
				}
			}
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onload="onloading()">
<form method="post" name="frmbrrecmd">
<%if (strSaral.equalsIgnoreCase("saral")) 
{%>
<laps:saralreportTag tabid="4" sector='<%=strSector%>' applied='<%=strappliedfor%>' /> <laps:inward />
<%
}
else
{
	if(strloanType.equalsIgnoreCase("P"))
	{
%> 
<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="outertable border1">
			<tr>
				<td id="mainlnk1"><jsp:include page="../share/Applurllinkper.jsp"
					flush="true">
					<jsp:param name="pageid" value="10" />
				</jsp:include></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				
		      <td> <b><i>Home -&gt; Retail -&gt; 
		        <%=(String) session.getAttribute("pgeLabel")%> -&gt; Appraisal -&gt; Due Diligence
		        Report </i></b> </td>
			</tr>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0">
			<tr>
				<td id="mainlnk1"><laps:application /></td>
			</tr>
		</table>
		
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="outertable border1">
			<tr>
				<td><jsp:include page="../share/apprlinktab.jsp"
					flush="true">
					<jsp:param name="tabid" value="10" />
				</jsp:include></td>
			</tr>
		</table>
		<%}
	else 
	{
	%>
		
<lapstab:ComReportTab tabid="5" applevel='<%=Helper.correctNull((String)request.getParameter("applevel"))%>'  applied='<%=strappliedfor%>'/>
	<laps:application /> 
<%}}%>

<table width="50%" border="0" cellspacing="3" cellpadding="5"	bgcolor="#DEDACF">
	<tr>
	
	<%
	String strother="";
	if((strSector.equalsIgnoreCase("Retail")) || (strloanType.equalsIgnoreCase("P")))
	{
		strother=" - Others";
		%>
		<td class="tabinactivenew" align="center">
			<b>
				<a href="JavaScript:gotoTab('<%//=ApplicationParams.getAppUrl()%>','lapsReport','getDueDiligenceRetail','Duediligence1.jsp')" onMouseOut="window.status='';return true;" class="blackfont">Due Diligence Report - Salaried</a>
			</b>
		</td>
	<%} %>
		<td class="tabinactivenew" align="center">
			<b>
				<a href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceCertificate','com_duediligencecertificate.jsp')" onMouseOut="window.status='';return true;" class="blackfont">Due Diligence Report <%=strother%></a>
			</b>
		</td>
		<td class="tabactivenew" align="center">
			<b>
				Annexure
			</b>
		</td>
	</tr>
</table>
  <table width="40%" border="0" cellspacing="3" cellpadding="5"	bgcolor="#DEDACF">
    <tr>
    <td class="tabactivenew" align="center">
			<b>
				Credit Limit sought
			</b>
		</td>
		<td class="tabinactivenew" align="center">
			<b>
				<a href="JavaScript:gotoTab('<%=ApplicationParams.getAppUrl()%>','lapsReport','getComDueDiligenceReport','com_duediligencereport.jsp')" onMouseOut="window.status='';return true;" class="blackfont">Details of Property(ies) Offered as Security</a>
			</b>
		</td>
		
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"	bgcolor="#DEDACF">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
<tr>
<td valign="top">
<table width="100%" border="0" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
<tr>
	<td valign="top">
		<table width="80%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
					<table width="100%" border="0" cellspacing="0" cellpadding="3">
						<tr>
							<td nowrap width="25%">&nbsp;</td>
						</tr>
						<tr>
    						<td width="25%" nowrap>Nature of Facility <b>*</b> </td>
               				<td width="36%">
							<input type="text" name="selnaturefac" size="25"
									maxlength="50" tabindex="2">
							</td>
							<td width="25%" nowrap>Amount&nbsp;(<%=ApplicationParams.getCurrency()%><%=strValuesin%>) <b>*</b> </td>
							<td width="36%"> 
                            	<input type="text" name="txt_limitapplied" size="15"
								maxlength="20" tabindex="3" style="text-align:right" onBlur="roundtxt(this)"
								onKeyPress="allowNumber(this)">
							</td>
						</tr>
						<tr>
							
							
						</tr>
						
					</table>
				</td>
			</tr>
		</table>
<laps:combutton btntype="NO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<tr>
		<td>
		<table width="60%" border="0" class="outertable border1" cellspacing="0" cellpadding="0" align="center">
			<tr>
				<td>
				          <table width="100%" border="0" cellspacing="1" cellpadding="3"
					bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                            <tr> 
                              <td width="10%" class="tabactivenew">&nbsp;</td>
                              <td align="center" width="61%" class="tabactivenew"><b>Nature 
                                of Facility</b> </td>
                              <td align="center" width="29%" class="tabactivenew"><b>Amount&nbsp;(<%=ApplicationParams.getCurrency()%><%=strValuesin%>)</b></td>
                            </tr>
                          </table>          <table width="100%" border="0" cellspacing="1" cellpadding="0">
                            <%	String sel_val;
			if(arrRow!=null && arrRow.size() > 0){
			if (arrRow.size() > 0) {
			for (int i = 0; i < arrRow.size(); i++) {
			arrCol = (ArrayList) arrRow.get(i);
			sel_val="";
	
			%>
                            <tr bgcolor="#EEEAE3"> 
                              <td width="10%" align="center" > 
                                <input type="radio"
							style="border:none" name="rdoUser"
							onClick="javascript:selectValues('<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>')">
                              </td>
                              <td width="61%" align="left" >&nbsp; <%=Helper.correctNull((String)arrCol.get(3))%></td>
                              <td width="29%" align="right" >&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrCol.get(4))))%></td>
                            </tr>
                            <%}
			}}else{

			    %>
                            <tr>
                              <td align="center" colspan="6">No Data Found</td>
                            </tr>
                            <%} %>
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
		</td>
			</tr>
		</table>
		
		<br>
		<input type="hidden" name="hidAction"> 
		<input type="hidden" name="hidBeanId" value=""> 
		<input type="hidden" name="hidBeanMethod" value=""> 
		<input type="hidden" name="hidBeanGetMethod" value=""> 
		<input type="hidden" name="hidSourceUrl" value=""> 
		<input type="hidden" name="hid_slno" value="">
		</form>

</body>
</html>
