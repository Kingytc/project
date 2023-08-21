<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
String indexval=Helper.correctNull((String)request.getParameter("indexvalue"));
String strncgtcflag=Helper.correctNull((String)hshValues.get("strncgtcflag")) ;
if(strncgtcflag=="Y")
{
	session.setAttribute("strncgtcflag",strncgtcflag);
}
%>
<html>
<head>
<title>Purpose check</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<script>

function callonLoad()
{
	parent.frames.document.forms[0].sel_facility.value="<%=Helper.correctNull((String)hshValues.get("CORP_FACILITY"))%>";
	parent.frames.document.forms[0].sel_projecttype.value="<%=Helper.correctNull((String)hshValues.get("CORP_TYPEOFPROJECT"))%>";
	parent.frames.document.forms[0].txt_greenfield.value="<%=Helper.correctNull((String)hshValues.get("CORP_GREENFIELD"))%>";
	parent.frames.document.forms[0].txt_brownfield.value="<%=Helper.correctNull((String)hshValues.get("CORP_BROWNFIELD"))%>";
	parent.frames.document.forms[0].sel_metro.value="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJECT"))%>";

	parent.frames.document.forms[0].sel_metroeligibility.value="<%=Helper.correctNull((String)hshValues.get("CORP_METROPROJELIGIBLE"))%>";
	parent.frames.document.forms[0].sel_industrysector.value="<%=Helper.correctNull((String)hshValues.get("CORP_INDUSTRYSECTOR"))%>";
	parent.frames.document.forms[0].sel_industryeligibility.value="<%=Helper.correctNull((String)hshValues.get("CORP_INDUSTRYSECTORELIGI"))%>";
	//parent.frames.document.forms[0].txt_udyogaadhaar.value="<%=Helper.correctNull((String)hshValues.get("CORP_UDYOGAADHAAR"))%>";
	parent.frames.document.forms[0].txt_projectunitpincode.value="<%=Helper.correctNull((String)hshValues.get("CORP_PROJECTUNITPIN"))%>";
	parent.frames.document.forms[0].sel_natureofproject.value="<%=Helper.correctNull((String)hshValues.get("CORP_PROJECTNATURE"))%>";

	if(parent.frames.document.forms[0].sel_projecttype.value!="0")
	{
		if(parent.frames.document.forms[0].sel_projecttype.value=="1")
		{
			parent.frames.document.all.t1.style.visibility="visible";
			parent.frames.document.all.t1.style.position="relative";
			parent.frames.document.all.t2.style.visibility="hidden";
			parent.frames.document.all.t2.style.position="absolute";
		}
		else
		{
			parent.frames.document.all.t1.style.visibility="hidden";
			parent.frames.document.all.t1.style.position="absolute";
			parent.frames.document.all.t2.style.visibility="Visible";
			parent.frames.document.all.t2.style.position="relative";
		}
	}
	if(parent.frames.document.forms[0].sel_projecttype.value=="")
	{
		parent.frames.document.forms[0].sel_projecttype.value="0";
	}
	if(parent.frames.document.forms[0].sel_metro.value=="")
	{
		parent.frames.document.forms[0].sel_metro.value="0";
	}
	if(parent.frames.document.forms[0].sel_metroeligibility.value=="")
	{
		parent.frames.document.forms[0].sel_metroeligibility.value="0";
	}
	if(parent.frames.document.forms[0].sel_industrysector.value=="")
	{
		parent.frames.document.forms[0].sel_industrysector.value="0";
	}
	if(parent.frames.document.forms[0].sel_natureofproject.value=="")
	{
		parent.frames.document.forms[0].sel_natureofproject.value="0";
	}
	if(parent.frames.document.forms[0].sel_industryeligibility.value=="")
	{
		parent.frames.document.forms[0].sel_industryeligibility.value="0";
	}
}
</script>
</head>
<body onLoad="callonLoad()">
<form name="bfrm" method="post">

</form>
</body>
</html>