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
		parent.frames.document.forms[0].idno.value = "<%=Helper.correctNull((String)vecRow.get(1))%>";
			
		parent.frames.document.forms[0].assettyp.value = "<%=Helper.correctNull((String)vecRow.get(2))%>";
		parent.frames.document.forms[0].breedmake.value= "<%=Helper.correctNull((String)vecRow.get(3))%>";
		parent.frames.document.forms[0].totalsqft.value= "<%=Helper.correctNull((String)vecRow.get(4))%>";
		parent.frames.document.forms[0].ageofasset.value = "<%=Helper.correctNull((String)vecRow.get(5))%>";
		parent.frames.document.forms[0].selyear.value = "<%=Helper.correctNull((String)vecRow.get(6))%>";
		parent.frames.document.forms[0].cost.value = "<%=Helper.correctNull((String)vecRow.get(7))%>";	
		parent.frames.document.forms[0].subsidy.value = "<%=Helper.correctNull((String)vecRow.get(8))%>";
		parent.frames.document.forms[0].margin.value = "<%=Helper.correctNull((String)vecRow.get(9))%>";
		parent.frames.document.forms[0].loanamountrequird.value = "<%=Helper.correctNull((String)vecRow.get(10))%>";
		//parent.frames.document.forms[0].dblTotalExp.value = "<%//=Helper.correctNull((String)vecRow.get(10))%>";
		parent.frames.document.forms[0].selsubsidy.value = "<%=Helper.correctNull((String)vecRow.get(12))%>";
	
		
		
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
