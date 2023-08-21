<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
  <%
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strSno = Helper.correctNull((String)request.getParameter("varSno"));
	if(strSno.equalsIgnoreCase(""))
	{
		strSno = Helper.correctNull((String)hshValues.get("varSno"));
	}

	String pagename=Helper.correctNull((String)request.getParameter("pagename"));
	
	if(pagename.equalsIgnoreCase(""))
		pagename=Helper.correctNull((String)request.getParameter("hidPagename"));

	String strAppVar=request.getParameter("strAppVar");
	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>	

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varSno = "<%=strSno%>";

var pagename1="<%=pagename%>";
var strAppVar1 = "<%=Helper.correctNull((String)hshValues.get("strAppVar"))%>";

function selectValues(val0,val1,val22,val10,val2)
{
	window.opener.document.forms[0].txt_extcustid.value=val0;
	window.opener.document.forms[0].hidoldId.value=val22;
	window.opener.document.forms[0].txt_name.value=val1;
	window.opener.getapplication();
	window.close();
	return;
}


function doClose()
{
 	window.close();
}

function callcbsid()
{
	if(document.forms[0].txt_cbsid.value=="")
	{
		alert("Enter minimum 3 characters");
		return;
	}
}

function callSearch()
{
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getCBSIDHelp";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].action=appURL+"action/CBSapplHelp.jsp";	
	document.forms[0].submit();	
}

function onRadioClick()
{
	if((document.forms[0].RD_CBS[0].checked==false)&& (document.forms[0].RD_CBS[1].checked==false))
	{
		document.forms[0].RD_CBS[0].checked=true;
	}
 	var varhidvalue=document.forms[0].hidvalue.value;
	document.forms[0].txt_cbsid.value="";
	document.forms[0].txt_cbsid.focus();
}

function resetme()
{
	document.forms[0].reset();
}

</script>
</head>
<body onload="onRadioClick()">
<form  method="post" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<tr><td><b>Select CBS ID</b></td></tr>
</table>

<br>
<table width="90%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td><b>CBS ID</b></td>
		<td><input type="radio" name="RD_CBS" STYLE="border-style: none" value="NO" ONCLICK="onRadioClick();"></td>
		<td><b>Name</b></td>
		<td><input type="radio" name="RD_CBS" STYLE="border-style: none" value="NAME" ONCLICK="onRadioClick();"></td>
		<td><input type="text" name="txt_cbsid" size="20" maxlength="25" value="" onKeyPress="notAllowSplChar();"></td>
		<td><input type="button" name="cmdsearch" value="Search" class="buttonStyle" onClick="callSearch();callcbsid();"></td>
		<td><input type="reset"name="search2" value="Reset" class="buttonStyle" onClick="resetme()"></td>
	</tr>
</table>
<br>
<table align="center" width="90%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
<tr class="dataheader">
<td align="center" width="15%"><b>CBS ID</b></td>
<td align="center" width="45%"><b>Name</b></td>
</tr>
<%
	arrCol=new ArrayList();
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	if(arrRow!=null)
	{
			if(arrRow.size()>0)
			{
					for(int i=0;i<arrRow.size();i++)
					{
						 arrCol=(ArrayList)arrRow.get(i); 
%>
     	<tr class="datagrid">
		<td>	
		 <a href="javascript:selectValues(
		'<%=Helper.correctNull((String)arrCol.get(0))%>',
		'<%=Helper.correctNull((String)arrCol.get(1))%>',
	    '<%=Helper.correctNull((String)arrCol.get(22))%>',
	    '<%=Helper.correctNull((String)arrCol.get(10))%>',
	    '<%=Helper.correctNull((String)arrCol.get(2))%>'
		)"><%=Helper.correctNull((String)arrCol.get(0))%></a>
		</td>
		<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}%>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<% }
		else
		{%>
		<tr class="datagrid"><td COLSPAN="2" align="center">&nbsp;No Data Found</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<%} 
		}%>
		</table>
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>			
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden"  name="hidvalue" value="<%=Helper.correctNull((String)hshValues.get("hidStrCbs"))%>">
<input type="hidden"  name="varSno" value="<%=strSno%>">

<input type="hidden"  name="hidPagename" value="<%=pagename%>">
<input type="hidden"  name="hidstrAppVar" value="<%=strAppVar%>">

</form>
</body>
</html>