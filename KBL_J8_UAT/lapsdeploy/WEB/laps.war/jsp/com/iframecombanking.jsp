<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%		
	ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	int vecsize=0;
	if(hshValues!=null)
	{
		vecData = (ArrayList)hshValues.get("vecData");
	}
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
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
			String strA=Helper.correctNull((String)vecRow.get(5));
			strA=Helper.correctDoubleQuote(strA);
			 StringTokenizer strIdV = new StringTokenizer(strA,"\n");			 
			 
			 int tmpcount =strIdV.countTokens();
			 String tmp = "";
			 int count=0;
			  while (strIdV.hasMoreTokens())			
			  {
				 String strTempV=(String)strIdV.nextToken();
				 count = count+1;
				 //System.out.println("count "+count);
				 if(count == tmpcount)
				 {
					 tmp = tmp+" "+ strTempV;
				 }
				 else
				 {
				 	 tmp = tmp +" "+ strTempV.substring(0,strTempV.length()-1);
				 }
			}
			 
	%>     
	
		parent.frames.document.forms[0].sel_Bank.value="<%=Helper.correctNull((String)vecRow.get(11))%>";
		if(parent.frames.document.forms[0].sel_Bank.value=="Our")
		{
			parent.frames.document.forms[0].sel_Facility.value="<%=Helper.correctNull((String)vecRow.get(1))%>";
			parent.frames.doHide("none");
		}
		else
		{
			parent.frames.document.forms[0].txt_Facility.value="<%=Helper.correctNull((String)vecRow.get(1))%>";
			parent.frames.doHide("block");			
		}
		parent.frames.document.forms[0].idno.value="<%=Helper.correctInt((String)vecRow.get(0))%>";
		parent.frames.document.forms[0].txt_OSAsOnDate.value="<%=Helper.correctNull((String)vecRow.get(2))%>";
		parent.frames.document.forms[0].sel_BnkType.value="<%=Helper.correctNull((String)vecRow.get(3))%>";
		parent.frames.document.forms[0].sel_IntType.value="<%=Helper.correctNull((String)vecRow.get(4))%>";
		parent.frames.document.forms[0].sel_CreditType.value="<%=Helper.correctNull((String)vecRow.get(5))%>";
		parent.frames.document.forms[0].txt_SancRefNo.value="<%=Helper.correctNull((String)vecRow.get(6))%>";
		parent.frames.document.forms[0].txt_SancDate.value="<%=Helper.correctNull((String)vecRow.get(7))%>";
		parent.frames.document.forms[0].txt_DueDate.value="<%=Helper.correctNull((String)vecRow.get(8))%>";
		parent.frames.document.forms[0].txtArea_Arrears.value="<%=Helper.correctNull((String)vecRow.get(9))%>";
		parent.frames.document.forms[0].sel_CompName.value="<%=Helper.correctNull((String)vecRow.get(10))%>";
		parent.frames.document.forms[0].txt_Bank.value="<%=Helper.correctNull((String)vecRow.get(12))%>";
		parent.frames.document.forms[0].sel_Type.value="<%=Helper.correctNull((String)vecRow.get(13))%>";
		parent.frames.document.forms[0].txt_Limit.value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(14))))%>";
		parent.frames.document.forms[0].txt_OS.value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(15))))%>";
		parent.frames.document.forms[0].txt_SpreadVal.value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(16))))%>";
		parent.frames.document.forms[0].txtarea_Remarks.value="<%=Helper.correctNull((String)vecRow.get(17))%>";
		parent.frames.document.forms[0].hidFacSNo.value="<%=Helper.correctNull((String)vecRow.get(19))%>";
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
