<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
ArrayList arrRow=(ArrayList)hshValues.get("arrRow");
ArrayList arrCol=new ArrayList();
%>
<html>
<head>
<title>Security Classification</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var sectype="<%=Helper.correctNull((String)request.getParameter("sectype"))%>";
var pagefrom="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>";
var sectype1="<%=Helper.correctNull((String)request.getParameter("sectype1"))%>";
function loadValues()
{
	parent.frames.document.forms[0].sel_securityclassifcation.options[0].text="----select----";
	parent.frames.document.forms[0].sel_securityclassifcation.options[0].value="0";
	parent.frames.document.forms[0].sel_securityclassifcation.length ="<%=arrRow.size()+1%>";

<%

	 if (arrRow!=null && arrRow.size() > 0)
	 {			
			for(int i=0;i<arrRow.size();i++)
			{
				arrCol=new ArrayList();
				arrCol=(ArrayList)arrRow.get(i);
				String strCode=Helper.correctNull((String)arrCol.get(0));
				String strClassificationDesc=Helper.correctNull((String)arrCol.get(1));
			%>		
		    parent.frames.document.forms[0].sel_securityclassifcation.options[<%=i+1%>].text="<%=strClassificationDesc%>";
			parent.frames.document.forms[0].sel_securityclassifcation.options[<%=i+1%>].value="<%=strCode%>";
			
<%	}
			%>
			
			if(sectype1!="")
			{
			parent.frames.document.forms[0].sel_securityclassifcation.value="<%=Helper.correctNull((String)request.getParameter("sectype1"))%>";
			}
			else{
				parent.frames.document.forms[0].sel_securityclassifcation.value="<%=Helper.correctNull((String)request.getParameter("sectype"))%>";
			}
			if(pagefrom!="appl")
			{
				if(sectype!="")
				parent.frames.document.forms[0].old_sel_securityclassifcationText.value=parent.frames.document.forms[0].sel_securityclassifcation.options[parent.frames.document.forms[0].sel_securityclassifcation.selectedIndex].text;
			}
		  <%
	 }
	 else
	 {
%>
		
		parent.frames.document.forms[0].sel_securityclassifcation.length =1;
		 parent.frames.document.forms[0].sel_securityclassifcation.options[0].text="-----select-----";
			parent.frames.document.forms[0].sel_securityclassifcation.options[0].value="0";
<%	 }
%>
parent.frames.showSpecify('N');
}

</script>
</head>

<body bgcolor="#E4E2ED" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="appfrm" method="post">
</form>
</body>
</html>
