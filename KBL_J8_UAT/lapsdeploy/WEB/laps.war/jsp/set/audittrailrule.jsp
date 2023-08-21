<!--
Coded By Rajesh on 11/01/2003
-->
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request"/>
<jsp:useBean id="strUserId" class="java.lang.String" scope="session"/>
<laps:handleerror />
 <%
   ArrayList arryRow = (ArrayList)hshValues.get("vecData");
   ArrayList arryCol = null;
   String rowsize ="";
   String type = "";
   String appform = "";
   String pre	= "";
   String post = "";
   String br = "";
   String set = "";
   rowsize = "0";
   if(arryRow.size()==1)
   {
   	rowsize = "1";
  	arryCol= (ArrayList)arryRow.get(0);
	 type = (String)Helper.correctNull((String)arryCol.get(0));
	 appform = (String)Helper.correctNull((String)arryCol.get(1));
	 pre = (String)Helper.correctNull((String)arryCol.get(2));
	 post = (String)Helper.correctNull((String)arryCol.get(3));
	 br = (String)Helper.correctNull((String)arryCol.get(4));
	 set = (String)Helper.correctNull((String)arryCol.get(5));

   }
    %>
<html>
<head>
<title>Audit Trail</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; color: #000099; font-size: 10px}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #000099; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/audittrailrule.js"></script>
<script>

var arrsize = "<%=rowsize%>"
if(arrsize=="1")
{
	var type = "<%=Helper.correctNull(type)%>";
	var appform = "<%=Helper.correctNull(appform)%>";
	var pre = "<%=Helper.correctNull(pre)%>";
	var post = "<%=Helper.correctNull(post)%>";
	var br = "<%=Helper.correctNull(br)%>";
	var set = "<%=Helper.correctNull(set)%>";
}
</script>
<script Language = "JavaScript">
   var path = "<%=ApplicationParams.getAppUrl()%>";

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onopen()" >
<form name="audittrail" method=post action="<%=ApplicationParams.getAppUrl()%>controllerservlet" > 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="0" > <tr> 
<td valign="top" colspan=5> <jsp:include page="../share/help.jsp" flush="true"/> 

</td></tr> </table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> 
      <td height="18"><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="MS Sans Serif">-&gt;</font><i> Setup </i><font face="MS Sans Serif">-&gt;</font><i> 
        Global Options</i></b></font></td>
    </tr> 
<tr> <td align="right">&nbsp; </td></tr> <tr> <td align="right"> <table width="100%" border="0" cellspacing="0" cellpadding="0"> 
<tr> <td width="75%" valign="bottom"> <table width="60%" border="0" cellspacing="3" cellpadding="3" align="left"> 
<tr> <td width="35%" align="center" bgcolor="#EEEAE3" height="2"><font face="MS Sans Serif" size="1"><b><a href="javascript:callOrg()" class="blackfont">Organisation</a></b></font></td><td width="30%" align="center" bgcolor="#71694F" height="2"><b><font  color="#FFFFFF">Audit 
Trail </font></b></td><td width="30%" align="center" height="2"><b></b></td></tr> 
</table></td><td width="25%">&nbsp;</td></tr> </table></td></tr> </table><table width="100%" border="1" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" > 
<tr> <td valign="top"> <div align="left"></div><table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" height="100%"> 
<tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%"> 
<tr> <td valign="top"> <table width="25%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"> 
<tr> <td height="32"> <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center"> 
<tr> <td width="7%"> <font size="1" face="MS Sans Serif"> <input type="radio" name="optAud" value="Y" style="border-style:none" onclick="fld('E')"> 
</font></td><td width="43%"><font size="1" face="MS Sans Serif">On</font></td><td width="9%"> 
<input type="radio" name="optAud" value="N" style="border-style:none" onclick="fld('D')"> 
</td><td width="41%"><font size="1" face="MS Sans Serif">Off</font></td></tr> 
</table></td></tr> </table></td></tr> <tr> <td valign="top"> <table width="50%" border="1" cellspacing="0" cellpadding="8" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" > 
<tr> <td> <table width="100%" border="1" cellspacing="0" cellpadding="8" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" > 
<tr> <td valign="middle"> <table width="100%" border="0" cellspacing="1" cellpadding="10" align="center"> 
<tr bgcolor="#EEEAE3"> <td width="44%"><font size="1" face="MS Sans Serif">Application 
Form </font></td><td width="56%"><font size="1" face="MS Sans Serif"> <select name="cmbapp" style="width:120;border-style:groove" > 
<option value="0" selected>----Select----</option> <option value="1">Full</option> 
<option value="2">Who,Where,When</option> <option value="3">None</option> </select> 
</font></td></tr> <tr bgcolor="#EEEAE3"> <td width="44%"><font size="1" face="MS Sans Serif">Presanction</font></td><td width="56%"><font size="1" face="MS Sans Serif"> 
<select name="cmbpre" id="cmbpre"  style="width:120;border-style:groove" > <option value="0" selected>----Select----</option> 
<option value="1">Full</option> <option value="2">Who,Where,When</option> <option value="3">None</option> 
</select> </font></td></tr> <tr bgcolor="#EEEAE3"> <td width="44%"><font size="1" face="MS Sans Serif">Post 
Disbursal Control</font></td><td width="56%"><font size="1" face="MS Sans Serif"> 
<select name="cmbpost" id="select2"  style="width:120;border-style:groove" > <option value="0" selected>----Select----</option> 
<option value="1">Full</option> <option value="2">Who,Where,When</option> <option value="3">None</option> 
</select> </font></td></tr> <tr bgcolor="#EEEAE3"> <td width="44%"><font size="1" face="MS Sans Serif">Business 
Rules </font></td><td width="56%"><font size="1" face="MS Sans Serif"> <select name="cmbbr" id="select4"  style="width:120;border-style:groove" > 
<option value="0" selected>----Select----</option> <option value="1">Full</option> 
<option value="2">Who,Where,When</option> <option value="3">None</option> </select> 
</font></td></tr> <tr bgcolor="#EEEAE3"> <td width="44%"><font size="1" face="MS Sans Serif">Setup</font></td><td width="56%"><font size="1" face="MS Sans Serif"> 
<select name="cmbset" id="select5"  style="width:120;border-style:groove" > <option value="0" selected>----Select----</option> 
<option value="1">Full</option> <option value="2">Who,Where,When</option> <option value="3">None</option> 
</select> </font></td></tr> </table></td></tr> </table></td></tr> </table></td></tr> 
</table></td></tr> </table><br> </td></tr> </table><br> <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center"> 
<tr> <td> <table width="100%" border="0" cellspacing="0" cellpadding="3"> <tr> 
<td> <div align="center"> <input type="button" name="cmdedit" value="Edit" class="buttonStyle" onclick = "onedit()"> 
</div></td><td> <div align="center"> <input type="button" name="cmdapply" value="Save" class="buttonStyle" onclick="onSave()"> 
</div></td><td> <div align="center"> <input type="button" name="cmdcancel" value="Cancel" class="buttonStyle" onclick="oncancel()"> 
</div></td><td> <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50;cursor:help" onClick="doHelp('global.htm#audittrail')"> 
</td><td> <div align="center"> <input type="button" name="cmdclose" value="Close" class="buttonClose" onclick="closewindow()"> 
</div></td></tr> </table></td></tr> </table><input type=hidden name="hidBeanId" value="audittrailrule"> 
<input type=hidden name="hidBeanMethod" > <input type="hidden" name="hidSourceUrl" value="/action/audittrailrule.jsp" > 
<input type="hidden" name="hideditflag"> </form>
</body>
</html>
