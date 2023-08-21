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
				String strA=	Helper.correctNull((String)vecRow.get(5));
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
				  
				  
				  strA=	Helper.correctNull((String)vecRow.get(8));
					strA=Helper.correctDoubleQuote(strA);
					 strIdV = new StringTokenizer(strA,"\n");			 
					 
					  tmpcount =strIdV.countTokens();
					  String tmp1 = "";
					  count=0;
					  while (strIdV.hasMoreTokens())			
					  {
						 String strTempV=(String)strIdV.nextToken();
						 count = count+1;
						 //System.out.println("count "+count);
						 if(count == tmpcount)
						 {
							 tmp1 = tmp1+" "+ strTempV;
						 }
						 else
						 {
						 	 tmp1 = tmp1 +" "+ strTempV.substring(0,strTempV.length()-1);
						 }
					 }
	%>       
		parent.frames.document.forms[0].idno.value = "<%=Helper.correctNull((String)vecRow.get(0))%>";	
		parent.frames.document.forms[0].bank.value = "<%=Helper.correctNull((String)vecRow.get(7))%>";
		parent.frames.document.forms[0].sel_divID.value = "<%=Helper.correctNull((String)vecRow.get(9))%>";
		parent.frames.document.forms[0].lmtfunded.value= "<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRow.get(1)))%>";
		parent.frames.document.forms[0].lmtfundedprop.value= "<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRow.get(2)))%>";
		parent.frames.document.forms[0].lmtnonfunded.value = "<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRow.get(3)))%>";
		parent.frames.document.forms[0].lmtnonfundedprop.value = "<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRow.get(4)))%>";	
		//parent.frames.document.forms[0].osfunded.value = "<%//=Helper.correctNull((String)vecRow.get(10))%>";		
		//parent.frames.document.forms[0].osnonfunded.value = "<%//=Helper.correctNull((String)vecRow.get(12))%>";		
		parent.frames.document.forms[0].selconsortium.value = "<%=Helper.correctNull((String)vecRow.get(12))%>";		
		parent.frames.document.forms[0].overdue.value = "<%=tmp%>";
		//parent.frames.document.forms[0].securityfunded.value = "<%//=Helper.correctNull((String)vecRow.get(17))%>";
		parent.frames.document.forms[0].excess.value = "<%=tmp1%>";
		parent.frames.document.forms[0].hidAction.value="";
		//if("<%//=Helper.correctNull((String)vecRow.get(16))%>" =="UBI")
		//{
			parent.frames.document.forms[0].selectbank.value ="<%=Helper.correctNull((String)vecRow.get(10))%>";
		/*} 
		else
		{
			parent.frames.document.forms[0].selectbank.value ="<%//=Helper.correctNull((String)vecRow.get(20))%>";
		}*/
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
