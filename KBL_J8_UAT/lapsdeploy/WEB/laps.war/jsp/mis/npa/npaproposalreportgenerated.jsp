<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<laps:handleerror />
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var outlabel="<%= hshValues.get("labels")%>";
<%
  ArrayList vecrow = new ArrayList();
  vecrow=(ArrayList)hshValues.get("vecrow");
  String align="center";
  String[] count=(String[])hshValues.get("count");
 // ArrayList vecalign = new ArrayList();
 // vecalign=(ArrayList)hshValues.get("vecalign");
%>
var datalen ="<%= vecrow.size()%>";
var per="<%= hshValues.get("period")%>";
function printData()
{
	var l;
	textlabel =outlabel.split(',');
	document.write("<td bgcolor='#E2E2E2'> ");
	document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
	document.write("</td>")
	for(l=0;l<textlabel.length;l++)
	{
		document.write("<td bgcolor='#E2E2E2'> ");
		document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ textlabel[l] + "</B></font></div>");
		document.write("</td>");
	}
	 <%
         int totcount=vecrow.size();
	 	 if(totcount==0)
	 	 {
	 %>	
	 		 document.write("<tr>");
	 		 document.write("<td align='center' colspan='");
	 		 document.write(textlabel.length+1);
	 		 document.write("'>");
	 		 document.write("<div align='center'>No Data Found</div>");
	 		 document.write("</td>");
	 		 document.write("</tr>");
	 <%
	 	 }
		  for(int i=0;i<totcount;i++)
		  {
			  ArrayList veccol = new ArrayList();
			  veccol =(ArrayList)vecrow.get(i);
	 %>
		      document.write("<tr>");
			  document.write("<td align='center'>");
			  document.write("<div align='center'>"+"<%=(i+1)%>" +'&nbsp;'+ "</div>");
			  document.write("</td>");
	 <%	
	 		  for(int j=0;j<veccol.size();j++)
			  {
					String data = (String)veccol.get(j);
					if(j==0)
					{
						align="center";	
					}
					else
					{
						align="right";	
					}
					if (data.equals(""))
					{
						data="&nbsp;";
					}
	%>		
					document.write("<td align='<%=align%>'>");
					document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=data%>" +'&nbsp;'+ "</font></div>");
					document.write("</td>");
			<%	
				// j= j+1;
			  }
			%>
				document.write("</tr>");					
		  <%}
		%>
				document.write("<tr>");
			  	document.write("<td align='right' colspan='2'>");
			    document.write("<div align='right'>"+"<b>Total :</b>" +'&nbsp;'+ "</div>");
			    document.write("</td>");
	    <%
	    		for(int i=0;i<4;i++)
	    		{
	    %>
			    document.write("<td align='right'>");
				document.write("<div align='right'><font size='1' face='MS Sans Serif'>"+"" +'&nbsp;<b>'+<%=count[i]%>+"</b></font></div>");
				document.write("</td>");
		<%}
		%>
				document.write("</tr>");
		        document.write("</table>");
		        		
			
} 


</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css"	type="text/css">
</head>

<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name= "orgfrm" method="post">
 <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
        <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("orgname"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b>Disposal of NPA Application Report</b></td>
        </tr>
<br>
</table>
<div class="cellContainer">
  
    <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor='#eeeeee' align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="1" cellspacing="0" cellpadding="3"  bordercolor='#eeeeee'>
            <script>         
			printData();
 		</script>
          </table>
        </td>
      </tr>
    </table>
</div>
   
</form>
</body>
</html>