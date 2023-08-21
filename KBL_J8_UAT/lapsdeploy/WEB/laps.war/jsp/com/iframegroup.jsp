<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%	
	//out.println("hshValues----"+hshValues);
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
		String strLStr="";

		for(int i=0;i<vecsize;i++)
		{	vecRow = (ArrayList)vecData.get(i);
			if(vecRow!=null)
			{		
				String strA=Helper.correctNull((String)vecRow.get(7));
				strA=Helper.correctDoubleQuote(strA);
				 StringTokenizer strIdV = new StringTokenizer(strA,"\n");	
				String tmp = "";
				// tmp=Helper.correctNull(strA);
				 int tmpcount =strIdV.countTokens();
				
				 int count=0;
				 while (strIdV.hasMoreTokens())			
				  {
					 String strTempV=(String)strIdV.nextToken();
					 count = count+1;
					 //System.out.println("count "+count);
					 if(count == tmpcount)
					 {
						 //System.out.println("tmp in if");
						 tmp = tmp+" "+ strTempV;
					 }
					 else
					 {
						  //System.out.println("tmp in else");
					 	tmp = tmp +" "+ strTempV.substring(0,strTempV.length()-1);
					 	
					 }
										
				}
			
				  //System.out.println("tmp valis"+tmp);
				  
				
				
	%>     
		

		parent.frames.document.forms[0].idno.value = "<%=Helper.correctNull((String)vecRow.get(0))%>";	
		parent.frames.document.forms[0].name.value = "<%=Helper.correctNull((String)vecRow.get(1))%>";
		parent.frames.document.forms[0].nature.value= "<%=Helper.correctNull((String)vecRow.get(2))%>" ;		
		parent.frames.document.forms[0].fundbob.value= "<%=Helper.correctNull((String)vecRow.get(3))%>";	
		parent.frames.document.forms[0].nonfundbob.value= "<%=Helper.correctNull((String)vecRow.get(4))%>";	
		parent.frames.document.forms[0].fund.value= "<%=Helper.correctNull((String)vecRow.get(5))%>";	
		parent.frames.document.forms[0].nonfund.value= "<%=Helper.correctNull((String)vecRow.get(6))%>";	
		parent.frames.document.forms[0].remarks.value= "<%=tmp%>";		
		// parent.frames.document.forms[0].selbankdet.value= "<%=Helper.correctNull((String)vecRow.get(8))%>";	
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
