<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%

out.println("iframerepayment ="+hshValues);
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
ArrayList arryCol = null;

DecimalFormat dc = new DecimalFormat();
dc.setGroupingUsed(false);
dc.setMaximumFractionDigits(2);
dc.setMinimumFractionDigits(2);

int intstartterm = Integer.parseInt((String)hshValues.get("hidstartterms"));
int intendtterm = Integer.parseInt((String)hshValues.get("hidendterms"));

String checkflag =request.getParameter("checkflag");
int monthsfrom =Integer.parseInt((String)request.getParameter("monthsfrom"));
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>

var startterm = "<%=intstartterm%>";
var endterm = "<%=intendtterm%>";

var checkflag = "<%=checkflag%>";
var monthsfrom = "<%=monthsfrom%>";



function loadValues()
{
if(checkflag=="1")
{

<%
		int k =0;
	for (int i = monthsfrom; i < intstartterm; i++)
	{
		if(arryRow!=null && arryRow.size()>0)
		{
			arryCol=(ArrayList)arryRow.get(k);
			
			if(arryCol!=null)
			{
	%>
	
parent.frames.document.forms[0].elements["txt_terms"+<%=i%>].value="<%=i%>";
parent.frames.document.forms[0].elements["txt_originalOSamt"+<%=i%>].value="<%=arryCol.get(1)%>";
parent.frames.document.forms[0].elements["txt_actualinterestamt"+<%=i%>].value="<%=arryCol.get(2)%>";
parent.frames.document.forms[0].elements["hidoriginalinterestamt"+<%=i%>].value="<%=arryCol.get(3)%>";
parent.frames.document.forms[0].elements["hiddiffinterestamt"+<%=i%>].value="";
parent.frames.document.forms[0].elements["txt_actualprincipalamt"+<%=i%>].value="<%=arryCol.get(4)%>";
parent.frames.document.forms[0].elements["hidoriginalprincipalamt"+<%=i%>].value="<%=arryCol.get(5)%>";
parent.frames.document.forms[0].elements["hiddiffprincipalamt"+<%=i%>].value="";
parent.frames.document.forms[0].elements["txt_totamt"+<%=i%>].value="<%=arryCol.get(6)%>";
parent.frames.document.forms[0].elements["txt_actualOSamt"+<%=i%>].value="<%=arryCol.get(7)%>";

	<%
			}
		}
	}
	%>
 
}

	<%
		int j =0;
	for (int i =intstartterm; i <= intendtterm; i++)
	{
		if(arryRow!=null && arryRow.size()>0)
		{
			arryCol=(ArrayList)arryRow.get(j);
			j = j+1;
			if(arryCol!=null)
			{
	%>
	
parent.frames.document.forms[0].elements["txt_terms"+<%=i%>].value="<%=i%>";
parent.frames.document.forms[0].elements["txt_originalOSamt"+<%=i%>].value="<%=arryCol.get(1)%>";
parent.frames.document.forms[0].elements["txt_actualinterestamt"+<%=i%>].value="<%=arryCol.get(2)%>";
parent.frames.document.forms[0].elements["hidoriginalinterestamt"+<%=i%>].value="<%=arryCol.get(3)%>";
parent.frames.document.forms[0].elements["hiddiffinterestamt"+<%=i%>].value="";
parent.frames.document.forms[0].elements["txt_actualprincipalamt"+<%=i%>].value="<%=arryCol.get(4)%>";
parent.frames.document.forms[0].elements["hidoriginalprincipalamt"+<%=i%>].value="<%=arryCol.get(5)%>";
parent.frames.document.forms[0].elements["hiddiffprincipalamt"+<%=i%>].value="";
parent.frames.document.forms[0].elements["txt_totamt"+<%=i%>].value="<%=arryCol.get(6)%>";
parent.frames.document.forms[0].elements["txt_actualOSamt"+<%=i%>].value="<%=arryCol.get(7)%>";

	<%
			}
		}
	}
	%>
}

</script>
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="iframerepayment" method="post">
</form>
</body>
</html>
