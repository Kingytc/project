<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	out.println("hshValues----"+hshValues);
	ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (ArrayList)hshValues.get("vecData1");
	}
	
%>

<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
 <%
		if(vecData!=null)
		{
			vecsize = vecData.size();
		}
		String strSno="";

		for(int i=0;i<vecsize;i++)
		{	vecRow = (ArrayList)vecData.get(i);
			if(vecRow!=null)
			{			
	%>       
	 
		parent.frames.document.forms[0].txt_season.value= "<%=Helper.correctNull((String)vecRow.get(2))%>";
		parent.frames.document.forms[0].txt_crop.value= "<%=Helper.correctNull((String)vecRow.get(3))%>";
		parent.frames.document.forms[0].txt_cultarea1.value = "<%=Helper.correctNull((String)vecRow.get(4))%>";
		parent.frames.document.forms[0].txt_cultarea2.value = "<%=Helper.correctNull((String)vecRow.get(5))%>";	
		parent.frames.document.forms[0].txt_mon_sowing.value = "<%=Helper.correctNull((String)vecRow.get(6))%>";
		parent.frames.document.forms[0].txt_mon_harvest.value= "<%=Helper.correctNull((String)vecRow.get(7))%>";
		parent.frames.document.forms[0].txt_corp_value.value = "<%=Helper.correctNull((String)vecRow.get(8))%>";
		parent.frames.document.forms[0].txt_scale.value = "<%=Helper.correctNull((String)vecRow.get(9))%>";
		parent.frames.document.forms[0].txt_loan_req.value = "<%=Helper.correctNull((String)vecRow.get(10))%>";	
			
<%
		}
	}	
%>

}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
