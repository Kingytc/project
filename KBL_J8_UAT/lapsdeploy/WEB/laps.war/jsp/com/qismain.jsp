<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
String strType = Helper.correctNull(request.getParameter("hidval"));
String mode=Helper.correctNull(request.getParameter("mode"));
String id="",status="";

 %>
<html>
<head>
<title>Financials-Assets</title> <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="http://vidhya:8080/boblaps/js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/rating/rating.js"></script>
<script language="Javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function call_page(url)
{
	
	if (ConfirmMsg(100))
		{
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
		}
	
}

function changeLbl(val)
{
	if(val=="s")
	{
	
	document.all.mainLabel.innerText="Select Year";
	document.all.selectid.style.visibility="visible";
	document.all.showhelp.style.visibility="hidden";
	document.forms[0].select_quater.disabled=true;
	document.forms[0].year.readOnly=true;
	}
	else
	{
	document.forms[0].year.value="";
	document.all.mainLabel.innerText="Enter Year";
	document.all.selectid.style.visibility="hidden";
	document.all.showhelp.style.visibility="visible";
	document.forms[0].select_quater.disabled=false;
	document.forms[0].year.readOnly=false;
	
	}
}


function doSave()
{
	if (trimtxt(document.forms[0].year.value) != "" && document.forms[0].select_quater.value != "")
	{
		if (document.forms[0].mode[0].checked==true)
				mode="N";
		else
				mode="E";

		document.forms[0].cmdok.disabled = true;
		if (mode == "N")
		{

		year=document.forms[0].year.value;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="QisBean";
		document.forms[0].hidval.value="insert_qis";
		document.forms[0].hidBeanMethod.value="insData";
		document.forms[0].hidSourceUrl.value="/action/hidqis.jsp?mode="+mode;
		document.forms[0].submit();
		}
		
		else if (mode == "E")
		{
		year=document.forms[0].year.value;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="QisBean";
		document.forms[0].hidval.value="show_qis";
		document.forms[0].hidBeanMethod.value="showupdateData";
		document.forms[0].hidSourceUrl.value="/action/qis.jsp?mode="+mode;
		document.forms[0].submit();
		}
	}
	else
	{
		alert("Enter the Value for all the fields");
	}
}

function showRating(val)
{
	appno=document.forms[0].hidappno.value;
	var purl = appURL+"jsp/com/qisselect.jsp?val="+val+"&appno="+appno;
	var title = "Qis";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
	
	
}

function onCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].year.value="";
	document.forms[0].select_quater.value="";
	document.forms[0].mode[0].checked = true;
	document.forms[0].select_quater.disabled=false;
	document.forms[0].select_quater.value="";
	document.all.mainLabel.innerText="Enter Year";
	document.all.selectid.style.visibility="hidden";
	document.all.showhelp.style.visibility="visible";
	document.forms[0].year.readOnly=false;
	}
}

function onReport()
{
	appno=document.forms[0].hidappno.value;
	document.forms[0].action=appURL+"jsp/com/report.jsp?appno="+appno+"&val=qis_report";
	document.forms[0].submit();
}
</script> <style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style> <link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"> 
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="changeLbl('n')">
<form method="post" > 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td>
<font size="4"><b><i>
Quarterly Information Statement</i></b></font>
</td></tr> 
</table><br> 
<table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"> 
<tr> <td valign="top"> 
<table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%"> 
<tr> <td valign="top">
<TABLE WIDTH="100%" BORDER="0" CELLSPACING="0" CELLPADDING="0">
<TR><TD>
<TABLE WIDTH="30%" BORDER="0" CELLSPACING="0" CELLPADDING="3" ALIGN="CENTER">
<TR><TD WIDTH="15%">
<INPUT TYPE="radio" NAME="mode" VALUE="N" onClick="changeLbl('n')" CHECKED style="border-style:none">
</TD>
<TD WIDTH="35%">
<FONT SIZE="1" FACE="MS Sans Serif">New</FONT>
</TD>
<TD WIDTH="15%">
<INPUT TYPE="radio" NAME="mode" VALUE="E" onClick="changeLbl('s')" style="border-style:none">
</TD>
<TD WIDTH="35%">
<FONT SIZE="1" FACE="MS Sans Serif">Existing</FONT>
</TD></TR>
</TABLE>
</TD>
</TR>
<TR>
<TD>&nbsp;</TD>
</TR>
<TR><TD>&nbsp;</TD>
</TR><TR>
<TD>
<TABLE WIDTH="35%" BORDER="0" CELLSPACING="0" CELLPADDING="5" ALIGN="CENTER">
<TR>
<TD WIDTH="37%" ALIGN="CENTER">
<FONT SIZE="1" FACE="MS Sans Serif"><span id="mainLabel">
Enter Year </span>
</FONT>
</TD>
<TD WIDTH="43%">
<INPUT TYPE="text" NAME="year" SIZE="13" maxlength="10" onBlur="checkDate(year)"><a id="showhelp" alt="Select date from calender"  href="#" onClick="javascript:callCalender('year')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"  width="0" height="24" border="0"></a>  
</TD>
<TD WIDTH="20%">
<FONT SIZE="1" FACE="MS Sans Serif">
<B>
<span id="selectid" style="visibility:hidden"><a href="JavaScript:showRating('qis')" class="blackfont"><b class="fontstyle">? 
                      </b></a></SPAN>
</B>
</FONT>
</TD></TR>

<tr> 
 <td width="32%" align="center"> <font size="2" face="MS Sans Serif"><font size="1">
                                      Quarter Ending </font></font></td>
                                    <td colspan="3"> 
                                      <select name="select_quater">
									  <option value="" selected>Select</option>
										<option value="1" >1</option>
										<option value="2">2</option>
										<option value="3">3</option>
										<option value="4">4</option>
									 </select>
                                    </td>
                                  </tr>
</TABLE>
</TD>
</TR>
<TR>
<TD>&nbsp;</TD>
</TR><TR>
<TD>&nbsp;</TD>
</TR><TR><TD>&nbsp;</TD>
</TR><TR><TD>&nbsp;</TD>
</TR>
<TR><TD>
<TABLE WIDTH="12%" BORDER="1" CELLSPACING="0" CELLPADDING="0" BORDERCOLORLIGHT="#8F8369" BORDERCOLORDARK="#FFFFFB"  ALIGN="center"> 
<TR>
<TD>
<TABLE BORDER="0" CELLSPACING="0" CELLPADDING="5" ALIGN="CENTER"> 
<TR VALIGN="top"> 
<TD WIDTH="0">
<DIV ALIGN="center">
<INPUT TYPE="button" NAME="cmdok" VALUE="OK" onClick="doSave()" STYLE="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" > 
</DIV>
</TD>
<TD WIDTH="0">
<DIV ALIGN="center">
<INPUT TYPE="button" NAME="cmdcancel" VALUE="Cancel" onClick="onCancel()" STYLE="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"> 
</DIV>
</TD>
<TD WIDTH="0">
<DIV ALIGN="center">
<INPUT TYPE="button" NAME="cmdcancel" VALUE="Report" onClick="onReport()" STYLE="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"> 
</DIV>
</TD>
</TR>
</TABLE>
</TD>
</TR>
 </TABLE>
 </TD>
 </TR>
 </TABLE>
 </td>
 </tr>
 </table>
 </td>
 </tr> 
</table>
<br>
<table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center"> 
<tr> <td> 
<table width="100%" border="0" cellspacing="0" cellpadding="2">
<tr valign="top"> 
<td width="0">
<div align="center"> 
<input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"> 
</div>
</td>
<td width="0"> 
<div align="center"> <input type="button" name="cmdclose" value="Close" onClick="call_page('navigation.jsp')"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"> 
</div>
</td></tr> 
</table>
</td></tr> 
</table>
			<input type=hidden name="hidBeanId" >
			<input type=hidden name="hidBeanMethod"  >
			<input type=hidden name="hidBeanGetMethod" >
			<input type=hidden name="hidSourceUrl">
			<input type=hidden name="hidappno" value="ABCI0000010">
			<input type=hidden name="hidval">
			<input type=hidden name="id">
</form>
</body>
</html>