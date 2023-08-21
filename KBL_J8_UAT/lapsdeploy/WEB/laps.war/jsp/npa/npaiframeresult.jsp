<%@include file="../share/directives.jsp"%>
<%

ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;	
arrRow=(ArrayList)hshValues.get("arrRow");
String strtype=Helper.correctNull((String)request.getParameter("hidtype"));
%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function loaddata()
{

<%
if(strtype.equalsIgnoreCase("NEW"))
{
	if(Helper.correctNull((String)(hshValues.get("exist"))).equalsIgnoreCase("Y"))
	{
	%>
		alert("<%=Helper.correctNull((String)hshValues.get("message"))%>");
	<%}
	else if(Helper.correctNull((String)(hshValues.get("prepared"))).equalsIgnoreCase("Y"))
	{%>
		alert("<%=Helper.correctNull((String)hshValues.get("message"))%>");
	<%}
	else if(Helper.correctNull((String)(hshValues.get("exist"))).equalsIgnoreCase("N"))
	{%>
		document.forms[0].appno.value="NEW";
		document.forms[0].npa_appno.value="NEW";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL+"action/StatusNote_page1.jsp?hidapplicantid="+document.forms[0].hidappid.value+"&apptype="+document.forms[0].hidapptype.value+"&borrowername="+document.forms[0].hidborrowername.value;
		//document.forms[0].hidSourceUrl.value="/
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
		<%
	} 
}
	%>
}	
function callStatusNote(appno)
{
		document.forms[0].appno.value=appno;
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getGeneralinfoData";
		document.forms[0].action=appURL+"action/StatusNote_page1.jsp?hidapplicantid="+document.forms[0].hidappid.value+"&apptype="+document.forms[0].hidapptype.value+"&borrowername="+document.forms[0].hidborrowername.value;
		//document.forms[0].hidSourceUrl.value="/
		document.forms[0].target="mainFrame"
		document.forms[0].submit();
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body onload="loaddata()">
<form name="framresult" method="post" class="normal">
  <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
    <tr class="datagrid"> 
   <%
	   if(strtype.equalsIgnoreCase("EXI"))
	   {
		  	String strappno="";
		    arrRow=(ArrayList)hshValues.get("arrRow");
			if(arrRow!=null && arrRow.size()>0 )
			{
				for(int i=0;i<arrRow.size();i++)
				{
				arrCol = (ArrayList)arrRow.get(i);
				if(arrCol!=null && arrCol.size()>0)
					{
						strappno=Helper.correctNull((String)arrCol.get(0));
						
				%>
		      <td class="datagrid">
		      <a href="javascript:callStatusNote('<%=Helper.correctNull((String)arrCol.get(0))%>')">
		      <b><%=Helper.correctNull((String)arrCol.get(0))%></b></a>
		      </td>
		       <td align="left">
		      <%
		      if(strappno.substring(10,11).equalsIgnoreCase("1"))
		      {
		    	out.println("<B>");		    	  
		    	out.println("First");
		    	out.println("</B>");		    	  
		      }
		      else if(strappno.substring(10,11).equalsIgnoreCase("2"))
		      {
		    	out.println("<B>");		  
		    	out.println("Second");
		    	out.println("</B>");	
		      }
		      else if(strappno.substring(10,11).equalsIgnoreCase("3"))
		      {
		    	out.println("<B>");		  
		    	out.println("Third");
		    	out.println("</B>");	
		      }
		      else if(strappno.substring(10,11).equalsIgnoreCase("4"))
		      {
		    	out.println("<B>");		  
		    	out.println("Fourth");
		    	out.println("</B>");	
		      }
		      %>
		      </td>
		      </tr> 
		     
		         <%} 
				}
	      	}
		}%>
		</table>
		
 


<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidSourceUrl"> 

<input type="hidden" name="hidmoduletype" value="<%=request.getParameter("moduletype")%>">
<input type="hidden" name="hidborrowername" value="<%=request.getParameter("borrowername")%>">
<input type="hidden" name="hidapptype" value="<%=request.getParameter("apptype")%>">
<input type="hidden" name="hidappid" value="<%=request.getParameter("hidapplicantid")%>">
<input type="hidden" name="year" value="<%=request.getParameter("year")%>">
<input type="hidden" name="quarter" value="<%=request.getParameter("quarter")%>">
<input type="hidden" name="appno">
<input type="hidden" name="npa_appno">
</form>
</body>
</html>
