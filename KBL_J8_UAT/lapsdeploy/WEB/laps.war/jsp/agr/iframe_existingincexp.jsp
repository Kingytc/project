<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
ArrayList arrIncExplist =(ArrayList)hshValues.get("arrRow");
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>


function loadValues()
{
<%
	 if (arrIncExplist!=null && arrIncExplist.size() > 0)
	 {
%>
		parent.frames.document.forms[0].txt_income.length = "<%=arrIncExplist.size()%>";
<%		
	for(int i=0;i<arrIncExplist.size();i++)
	{
		ArrayList arrCol=new ArrayList();
		arrCol=(ArrayList)arrIncExplist.get(i);
%>
			parent.frames.document.forms[0].hidgridno.value="<%=Helper.correctNull((String)arrCol.get(0))%>";
			parent.frames.document.forms[0].hiddatano.value="<%=Helper.correctNull((String)arrCol.get(1))%>";
			parent.frames.document.forms[0].txt_income.value="<%=Helper.correctNull((String)arrCol.get(2))%>";
			parent.frames.document.forms[0].txt_expense.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
			<%if(arrIncExplist.size()<=1)
			{%>
			parent.frames.document.forms[0].txt_inc.value="<%=Helper.checkDecimal((String)arrCol.get(4))%>";
			parent.frames.document.forms[0].txt_exp.value="<%=Helper.checkDecimal((String)arrCol.get(5))%>";
			parent.frames.document.forms[0].txt_tot.value="<%=Helper.checkDecimal((String)arrCol.get(6))%>";
			    
				<%}else{%>
			
			parent.frames.document.forms[0].txt_inc[<%=i%>].value="<%=Helper.checkDecimal((String)arrCol.get(4))%>";
			parent.frames.document.forms[0].txt_exp[<%=i%>].value="<%=Helper.checkDecimal((String)arrCol.get(5))%>";
			parent.frames.document.forms[0].txt_tot[<%=i%>].value="<%=Helper.checkDecimal((String)arrCol.get(6))%>";

			<%}%>
			
<%
		}
	 }
	 else
	{
%>
		parent.frames.document.forms[0].txt_income.length =0;
<%	}%>
	
}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="bfrm" method="post">
</form>
</body>
</html>
