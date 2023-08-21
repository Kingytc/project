
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
 if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }

//out.println(((String)hshValues.get("zone")));
//out.println((String)session.getAttribute("link"));
String bid=Helper.correctNull((String)hshValues.get("borrowerid"));
String strAppID="";
if (bid.trim().equals(""))
{

 strAppID=request.getParameter("comapp_id");

}
else
{
 strAppID=Helper.correctNull((String)hshValues.get("borrowerid"));
}
//out.println(strAppID);
String strAppno=request.getParameter("appno");
String strNpaDate=request.getParameter("txt_date");

HashMap hshData=new HashMap();
if (hshValues!=null)
{
 hshData=(HashMap)hshValues.get("hshData");

}
HashMap hshVal=new HashMap();
if (hshValues!=null)
{
 hshVal=(HashMap)hshValues.get("hshVal");

}

%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function  doPrint(tdate,cid,x)
{	
	var url1 = appURL+"action/npastatus1prn.jsp?hidBeanId=npabob"+"&hidBeanGetMethod=getNpaData"+"&txt_date="+tdate+"&comappid="+cid+"&appno="+x;	
	var title = "QisAnalysis";
	var prop = "scrollbars=yes,width=775,height=450,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url1,title,prop);
}


function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	
}

function call_page(url)
{
	
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
	
}



function show_details()
{
	

}

function placevalues()
{
	
	disableFields(true);
	enableButtons(false,true,true,true);
	var a="<%=Helper.correctNull((String)hshValues.get("npa_sectype"))%>";
	if (a!="")
	{
		document.forms[0].sel_sec.value=a;
	}
	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled =val;		  
		}
	}
}
function oncancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="npabob"
		document.forms[0].hidBeanGetMethod.value="getNpaData";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/npa_status_1.jsp";
		document.forms[0].submit();
	}
	
}

function onclose()
{
	/*if (ConfirmMsg(100))
	{
	document.forms[0].action=appURL+"/action/corppge.jsp";
	document.forms[0].submit();
	}*/
	if(ConfirmMsg('100'))
	{
		document.forms[0].method="post";	//document.forms[0].action=appURL+"action/"+"comsearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=<%=session.getAttribute("link")%>";
		document.forms[0].action=appURL+"action/"+"comsearch.jsp?id=<%=session.getAttribute("comappid")%>&hidNpaPageType=<%=request.getParameter("hidNpaPageType")%>";
		//alert(document.forms[0].action);
		document.forms[0].submit();
		//document.forms[0].action=appUrl+"action/setupnav.jsp";
		//document.forms[0].submit();
	}
}

function onedit()
{
	disableFields(false);
	enableButtons(true,false,false,true)
	
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool5;
}
function apply()
{
	
		//document.forms[0].txt_date.value=document.forms[0].txt_npadate.value;
		document.forms[0].hidAction.value="edit";
		document.forms[0].hidBeanId.value="npabob";
		document.forms[0].hidBeanMethod.value="updatesecurities";
		document.forms[0].hidBeanGetMethod.value="getsecurities";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/npa_securities.jsp";
		document.forms[0].submit();
	
}
function callLink(page,bean,method)
{	
	
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}
</script>

</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="placevalues()">
<jsp:include page="../share/help.jsp" flush="true"/>  <form name="frmpri" method = post> 
<span style="display:none"><laps:borrowertype /></span><laps:displayorgname /> 
<laps:application/> <table width="100%" border="0" cellspacing="2" cellpadding="3"> 
<tr><td colspan="2" align="center"> <font size="1" face="MS Sans Serif, Verdana" ><B>Details 
of Securities</B></font></td></tr> <tr> <td><font face="MS Sans Serif, Verdana" size="1"><b></b></font></td><td> 
<div align="right"><font size="1" face="MS Sans Serif, Verdana" color="#FF0000">Rupees 
in lacs</font></div></td></tr> </table><table width="100%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%"> 
<tr> <td valign="top"> <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"> 
<tr> <td valign="top"> <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" > 
<tr> <td valign="top" height="115"> <table width="100%" border="0" cellspacing="2" cellpadding="3"> 
<tr> <td WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Type of securityes</FONT></td><td WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><SELECT NAME="sel_sec" > 
<OPTION VALUE="0" selected><FONT FACE="MS Sans Serif" SIZE="1">Select</FONT></OPTION> 
<OPTION VALUE="Primary" ><FONT FACE="MS Sans Serif" SIZE="1">Primary</FONT></OPTION> 
<OPTION VALUE="Collateral"><FONT FACE="MS Sans Serif" SIZE="1">Collateral</FONT></OPTION> 
</SELECT> </FONT></td><td WIDTH="24%">&nbsp;</td><td WIDTH="26%">&nbsp;</td></tr> <tr> <td COLSPAN="4"><b>Land 
and Building:</b></td></tr> <tr> <td WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td WIDTH="23%"> <font face="MS Sans Serif" size="1"> </font><font face="MS Sans Serif" size="1"><INPUT TYPE="text" NAME="txt_market"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_lmarket"))%>"> 
</font></td><td WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable value</FONT></td><td WIDTH="26%"> 
<font face="MS Sans Serif" size="1"> <input type="text" name="txt_realise"  onkeypress="allowDecimals(this)" maxlength="12"
							value="<%=Helper.correctNull((String)hshValues.get("npa_lrealise"))%>"> 
</font></td></tr> <tr> <td WIDTH="27%"><font face="MS Sans Serif" size="1">&nbsp;Last 
Date of Inspection</font></td><td WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_ldateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Name of the Official 
who inspected and comments</FONT></td><td WIDTH="26%"><font face="MS Sans Serif" size="1"> 
<input type="text" name="txt_official" maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("npa_inspection"))%>"> 
</font></td></tr> <tr> <td COLSPAN="4"><b>Plant and Machinery:</b></td></tr> <tr> <td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td WIDTH="23%"> <font face="MS Sans Serif" size="1"> <input type="text" name="txt_market1" onKeyPress="allowDecimals(this)" onBlur="showtotos()" maxlength="12" value="<%=Helper.correctNull((String)hshValues.get("npa_pmarket"))%>" readonly> 
</font></td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td WIDTH="26%"> <font face="MS Sans Serif" size="1"><INPUT TYPE="text" NAME="txt_realise1"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_prealise"))%>"> 
</font></td></tr> <tr> <td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td WIDTH="23%"> <A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins1')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins1"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_pdateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td height="37" id="n1" WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Name 
of the Official who inspected and comments</FONT></td><td height="37" id="n2" WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official1"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection1"))%>"> 
</FONT></td></tr><tr><td nowrap COLSPAN="4"><b>Vechiles:</b></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_market2"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_vmarket"))%>" readonly> 
</FONT></td><td height="37" WIDTH="24%" ><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td height="37" WIDTH="26%" ><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_realise2"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_vrealise"))%>"> 
</FONT></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins2')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins2"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_vdateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td height="37" WIDTH="24%" ><FONT FACE="MS Sans Serif" SIZE="1">Name of 
the Official who inspected and comments</FONT></td><td height="37" WIDTH="26%" ><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official2"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection2"))%>"> 
</FONT></td></tr><tr><td nowrap COLSPAN="4"><b>Stocks:</b></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td nowrap WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_market3"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_smarket"))%>" readonly> 
</FONT></td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_realise3"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_srealise"))%>"> 
</FONT></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td nowrap WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins3')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins3"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_sdateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Name of the Official 
who inspected and comments</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official3"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection3"))%>"> 
</FONT></td></tr><tr><td nowrap COLSPAN="4"><b>Book Debts</b></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td nowrap WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_market4"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_bmarket"))%>" readonly> 
</FONT></td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_realise4"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_brealise"))%>"> 
</FONT></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td nowrap WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins4')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins4"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_bdateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Name of the Official 
who inspected and comments</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official4"  MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection4"))%>"> 
</FONT></td></tr><tr><td nowrap COLSPAN="4"><b>Bills of Exchange</b></td></tr><tr><td nowrap HEIGHT="40" WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td nowrap HEIGHT="40" WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_market5"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_bemarket"))%>" readonly> 
</FONT></td><td nowrap HEIGHT="40" WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td nowrap HEIGHT="40" WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_realise5"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_berealise"))%>"> 
</FONT></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td nowrap WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins5')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins5"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_bedateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Name of the Official 
who inspected and comments</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official5"  MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection5"))%>"> 
</FONT></td></tr><tr><td nowrap COLSPAN="4"><b>OtherAssets:</b></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">Market 
value</FONT></td><td nowrap WIDTH="23%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_market6"  MAXLENGTH="12" VALUE="<%=Helper.correctNull((String)hshValues.get("npa_omarket"))%>" readonly> 
</FONT></td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable 
value</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_realise6"  ONKEYPRESS="allowDecimals(this)" MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_orealise"))%>"> 
</FONT></td></tr><tr><td nowrap WIDTH="27%"><FONT FACE="MS Sans Serif" SIZE="1">&nbsp;Last 
Date of Inspection</FONT></td><td nowrap WIDTH="23%"><A ALT="Select date from calender"  HREF="javascript:callCalender('txt_ins6')"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_ins6"  ONBLUR="checkDate(this)" MAXLENGTH="10"  VALUE="<%=Helper.correctNull((String)hshValues.get("npa_odateofins"))%>" readOnly></FONT><IMG src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" BORDER="0" ></A> 
</td><td nowrap WIDTH="24%"><FONT FACE="MS Sans Serif" SIZE="1">Realisable value</FONT></td><td nowrap WIDTH="26%"><FONT FACE="MS Sans Serif" SIZE="1"><INPUT TYPE="text" NAME="txt_official6"   MAXLENGTH="12"
							VALUE="<%=Helper.correctNull((String)hshValues.get("npa_inspection6"))%>"> 
</FONT></td></tr> </table></td></tr> </table><table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" > 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="2" cellpadding="3"> 
 </table></td></tr> </table><table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" > 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="2" cellpadding="3"> 
</table></td></tr> </table></td></tr> 
</table></td></tr> </table></td></tr> </table><br> <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="2"> <tr valign="top"> 
<td width="0"> <div align="center"> <input type="button" name="cmdedit" value="Edit" class="buttonStyle" onClick="onedit()"> 
</div></td><td width="0"> <div align="center"> <input type="button" name="cmdapply" value="Save" class="buttonStyle" onClick="apply()" > 
</div></td><td width="0"> <div align="center"> <input type="button" name="cmdcancel" value="Cancel"  class="buttonStyle" onClick="oncancel()"> 
</div></td><td width="0"> <div align="center"> <input type="button" name="cmdhelp" value="Help"  class="buttonHelp"> 
</div></td><td width="0"> <div align="center"> <input type="button" name="cmdclose" value="Close"  class="buttonClose"  onClick="onclose()"> 
</div></td><td width="0" nowrap> <div align="center"> <input type="button" name="cmdnpa" value="NPA Status Report"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:125"   onClick="callnpa()"> 
</div></td></tr> </table></td></tr> </table><table width="5%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center"> 
<!-- <tr> <td width="0" align="center"> <div align="center"> <input type="button" name="cmdprint" value="Print" onClick="doPrint(document.forms[0].txt_date.value,document.forms[0].comapp_id.value,document.forms[0].ano.value)"  class="buttonClose"> 
</div></td></tr>--> </table><table width="100%" border="0" cellspacing="0" cellpadding="3"> 
<tr> <td width="33%" HEIGHT="24"><b><font size="1" face="MS Sans Serif">&nbsp;</font></b></td><td width="33%%" align="center" HEIGHT="24"><b><font size="1" face="MS Sans Serif"> 
<jsp:include page="../com/print_link.jsp" flush="true"/> </font></b></td><td width="33%%" align="right"><b><font size="1" face="MS Sans Serif">Page: 
1/3 <a href="javascript:callLink('npa_securities.jsp','npabob','getsecurities')" class="blackfont">Next 
&gt;&gt; </a></font></b> </td></tr> </table><input type=hidden name="hidBeanId" > 
<input type=hidden name="hidBeanMethod"  > <input type=hidden name="hidBeanGetMethod" > 
<input type=hidden name="hidSourceUrl"> <input type=hidden name="comapp_id" value="<%=strAppID%>"> 
<input type=hidden name="txt_date" value="<%=strNpaDate%>"> <input type=hidden name="hidAction" > 
<input type=hidden name="ano" value="<%=strAppno%>"> <input type="hidden" name="hidNpaPageType" value="<%=Helper.correctNull(request.getParameter("hidNpaPageType"))%>">	
</form>
</body>
</html>
