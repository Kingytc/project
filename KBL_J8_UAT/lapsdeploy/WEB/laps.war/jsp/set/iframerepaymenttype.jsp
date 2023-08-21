<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
	
	
	String strRepaymentType=Helper.correctNull((String)hshValues.get("strRepaymentType"));
	String strArr[]= strRepaymentType.split("@");
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/javascript">
var varRepay="<%=Helper.correctNull((String)hshValues.get("strRepayType"))%>";
var varProductType="<%=Helper.correctNull((String)hshValues.get("strProductType"))%>";
var varModType="<%=Helper.correctNull((String)hshValues.get("strModType"))%>";
var varFacType="<%=Helper.correctNull((String)hshValues.get("strFacType"))%>";
function loadValues()
{	
	if(varModType=="AGR" || varModType=="CORP")
	{
		if(varFacType=="facility")
		{
			parent.frames.document.forms[0].sel_repaytype.length ="<%=strArr.length+1%>";
			parent.frames.document.forms[0].sel_repaytype.options[0].text="<----select---->";
			parent.frames.document.forms[0].sel_repaytype.options[0].value="0";
		}
		else
		{
			parent.frames.document.forms[0].sel_sub_repaytype.length ="<%=strArr.length+1%>";
			parent.frames.document.forms[0].sel_sub_repaytype.options[0].text="<----select---->";
			parent.frames.document.forms[0].sel_sub_repaytype.options[0].value="0";
		}
	}
	else
	{
	parent.frames.document.forms[0].selrepaymenttype.length ="<%=strArr.length+1%>";
	parent.frames.document.forms[0].selrepaymenttype.options[0].text="<----select---->";
	parent.frames.document.forms[0].selrepaymenttype.options[0].value="0";
	}

<%
String strTemp="";
for(int i=0;i<strArr.length;i++)
{
	strTemp=strArr[i];
	%>
	if(varModType=="AGR" || varModType=="CORP")
	{
		if(varFacType=="facility")
		{
		<%if(strTemp.equalsIgnoreCase("E"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="EMI"
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("NE"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="Non-EMI";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("OD"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="On Demand";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("LC"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="As Per LC Terms";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("CO"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="As Per Contract Terms";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("BG"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="As Per BG Rules";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("DD"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="On Due Date";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("PC"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="From the proceeds of PSC \ by realization of bill";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("PS"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="By Realization of Export Bills";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("PR"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="By Realization of Respective Bills";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}
		else if(strTemp.equalsIgnoreCase("TG"))
		{%>
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].text="As per TCBG Rules";
			parent.frames.document.forms[0].sel_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
		<%}%>
		}else
		{
			<%if(strTemp.equalsIgnoreCase("E"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="EMI"
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("NE"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="Non-EMI";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("OD"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="On Demand";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("LC"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="As Per LC Terms";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("CO"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="As Per Contract Terms";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("BG"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="As Per BG Rules";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("DD"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="On Due Date";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("PC"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="From the proceeds of PSC \ by realization of bill";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("PS"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="By Realization of Export Bills";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("PR"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="By Realization of Respective Bills";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}
			else if(strTemp.equalsIgnoreCase("TG"))
			{%>
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].text="As per TCBG Rules";
				parent.frames.document.forms[0].sel_sub_repaytype.options[<%=i+1%>].value="<%=strTemp%>";
			<%}%>
		}
		
	}
	else
	{
	<%if(strTemp.equalsIgnoreCase("1"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="EMI"
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}
	else if(strTemp.equalsIgnoreCase("2"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="Non-EMI";
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}
	else if(strTemp.equalsIgnoreCase("8"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="On Due Date";
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}
	else if(strTemp.equalsIgnoreCase("12"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="On Demand";
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}
	else if(strTemp.equalsIgnoreCase("13"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="Equal Monthly Installment";
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}
	else if(strTemp.equalsIgnoreCase("14"))
	{%>
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].text="2 Yearly Equal Installment";
		parent.frames.document.forms[0].selrepaymenttype.options[<%=i+1%>].value=<%=strTemp%>;
	<%}%>
	}
<%}
%>
	if(varModType=="AGR" || varModType=="CORP")
	{
		if(varFacType=="facility")
		{
			parent.frames.document.forms[0].sel_repaytype.value=varRepay;
		}
		else
		{
			parent.frames.document.forms[0].sel_sub_repaytype.value=varRepay;
		}
	}
	else
	{
		parent.frames.document.forms[0].selrepaymenttype.value=varRepay;
		if(varProductType!="pG" && varProductType!="pR")
		{
			parent.frames.showRepayButton();
		}
		parent.frames.callSanc();
	}
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
