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
		vecData = (ArrayList)hshValues.get("vecData");
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
		parent.frames.document.forms[0].village.value = "<%=Helper.correctNull((String)vecRow.get(2))%>";	
		parent.frames.document.forms[0].survey.value = "<%=Helper.correctNull((String)vecRow.get(3))%>";
		parent.frames.document.forms[0].age.value= "<%=Helper.correctNull((String)vecRow.get(4))%>";
		parent.frames.document.forms[0].irrigated.value= "<%=Helper.correctNull((String)vecRow.get(5))%>";
		parent.frames.document.forms[0].source.value = "<%=Helper.correctNull((String)vecRow.get(6))%>";
		parent.frames.document.forms[0].encumbrance.value = "<%=Helper.correctNull((String)vecRow.get(7))%>";	
		parent.frames.document.forms[0].sellease.value = "<%=Helper.correctNull((String)vecRow.get(8))%>";
		parent.frames.document.forms[0].leaseperiod.value = "<%=Helper.correctNull((String)vecRow.get(9))%>";
		parent.frames.document.forms[0].farmdistance.value = "<%=Helper.correctNull((String)vecRow.get(10))%>";
		parent.frames.document.forms[0].housedistance.value = "<%=Helper.correctNull((String)vecRow.get(11))%>";
		
		parent.frames.document.forms[0].location.value = "<%=Helper.correctNull((String)vecRow.get(12))%>";
		parent.frames.document.forms[0].taluk.value = "<%=Helper.correctNull((String)vecRow.get(13))%>";
		parent.frames.document.forms[0].selirrigation.value = "<%=Helper.correctNull((String)vecRow.get(14))%>";
		parent.frames.document.forms[0].seltax.value = "<%=Helper.correctNull((String)vecRow.get(15))%>";
		parent.frames.document.forms[0].chobank_apptype.value = "<%=Helper.correctNull((String)vecRow.get(16))%>";
		
	
		
		
<%
		}
	}	
%>

	if(parent.frames.document.forms[0].sellease.value == "2")
	{
		///// show Since
		parent.frames.document.all.r1.style.visibility="visible";
		parent.frames.document.all.r2.style.visibility="visible";


	}
	else
	{
		///// show Since
		parent.frames.document.all.r1.style.visibility="hidden";
		parent.frames.document.all.r2.style.visibility="hidden";


	}
	

}

</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
