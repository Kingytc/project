<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%ArrayList ArrRow=new ArrayList();
ArrayList ArrRow1=new ArrayList();
ArrayList ArrCol=new ArrayList();
ArrRow=(ArrayList)hshValues.get("arrRow");
ArrRow1=(ArrayList)hshValues.get("arrRow1");
int arrsize=0,arrsize1=0;
if(ArrRow !=null)
{
	arrsize=ArrRow.size();
}
if(ArrRow1 !=null)
{
	arrsize1=ArrRow1.size();
}
java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
%>

<html>
<head>
<title>Security Valuation Report</title>
<script>
function doPrintPreview()
{
win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=1200,height=600,left=60,top=40");
	
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");

	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+'<%=ApplicationParams.getAppUrl()%>'+"img/kbl_newlogo.jpg'"+"></td>");          		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><b>"+'<%=Helper.correctNull((String)hshValues.get("Org_Name"))%>'+"</b></td>");
	win.document.write("</tr>");
	
	win.document.write("<tr>");
	win.document.write("<td>");        
	win.document.write("<center>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><strong><center> Security Valuation Report</center></strong></TD>");
	win.document.write("</TABLE>");
	win.document.write("</center>");
	win.document.write("</td>");
	win.document.write("</tr>");
	
	win.document.write("<tr>");
	win.document.write("<td>");   
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='10%'><font size='1' face='MS Sans Serif'><B>Generated By :</B></font></TD>");
	win.document.write("<TD  width='40%'><font size='1' face='MS Sans Serif'>"+'<%=session.getAttribute("strUserName")%>'+"</font></TD>");
	win.document.write("<TD width='50%' align='right'><font size='1' face='MS Sans Serif'><B>Report Generated On :</B></font></TD>");
	win.document.write("<TD  width='10%'><font size='1' face='MS Sans Serif'>"+'<%=Helper.getCurrentDateTime()%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("</TABLE>");
	
	win.document.write("</td>");   
	win.document.write("</tr>");


	<%if(arrsize>0)
	  {%>
	win.document.write("<tr>");
	win.document.write("<td>");   
	win.document.write("<center><TABLE width='100%' border='1' cellspacing='0' cellpadding='3' bordercolor='#eeeeee' >");
	win.document.write("<tr>"); 
	win.document.write("<td colspan='11'> ");
	win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ "Valuation Expired Securities" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("</tr>"); 
	win.document.write("<tr>"); 
	win.document.write("<td> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Branch Code" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Branch Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Proposal No" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "CBS Customer ID" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Borrower Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security ID" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Type" + "</B></font></div>");
	win.document.write("</td>");
	//win.document.write("<td> ");
	//win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Description" + "</B></font></div>");
	//win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Value" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Valuer Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Valuation Date" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("</tr>"); 

	<%
	  for(int i=0;i<arrsize;i++){
		  ArrCol=(ArrayList)ArrRow.get(i);%>

		  	win.document.write("<tr>"); 
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=i+1 %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(9)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(8)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(10)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(0)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(1))%>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(2)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td nowrap='nowrap'> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(3)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			//win.document.write("<td> ");
			//win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%//=Helper.correctNull((String)ArrCol.get(4)) %>' + "&nbsp;</B></font></div>");
			//win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(5)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(6)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(7)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("</tr>"); 
	  <%} %>
	win.document.write("</TABLE></center>");
	win.document.write("</td>");   
	win.document.write("</tr>");

	<%}
	if(arrsize1>0)
	  {
	%>
	win.document.write("<tr><td>&nbsp;</td></tr>");
	win.document.write("<tr><td>&nbsp;</td></tr>");
	win.document.write("<tr>");
	win.document.write("<td>");   
	win.document.write("<center><TABLE border='1' cellspacing='0' cellpadding='3' bordercolor='#eeeeee' >");
	win.document.write("<tr>"); 
	win.document.write("<td colspan='11'> ");
	win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ "Securities Approaching the Valuation Expiry" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("</tr>"); 
	win.document.write("<tr>"); 
	win.document.write("<td> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Branch Code" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Branch Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Proposal No" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "CBS Customer ID" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Borrower Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security ID" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Type" + "</B></font></div>");
	win.document.write("</td>");
	//win.document.write("<td> ");
	//win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Description" + "</B></font></div>");
	//win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Security Value" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Valuer Name" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("<td nowrap='nowrap'> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Valuation Date" + "</B></font></div>");
	win.document.write("</td>");
	win.document.write("</tr>"); 

	<%
	  for(int i=0;i<arrsize1;i++){
		  ArrCol=(ArrayList)ArrRow1.get(i);%>

		  	win.document.write("<tr>"); 
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=i+1 %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(9)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(8)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(10)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(0)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(1))%>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(2)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td nowrap='nowrap'> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(3)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			//win.document.write("<td> ");
			//win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(4)) %>' + "&nbsp;</B></font></div>");
			//win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div align='right'><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(5)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(6)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("<td> ");
			win.document.write("<div><font size='1' face='MS Sans Serif'><B>"+ '<%=Helper.correctNull((String)ArrCol.get(7)) %>' + "&nbsp;</B></font></div>");
			win.document.write("</td>");
			win.document.write("</tr>"); 
	  <%} %>
	
	win.document.write("</TABLE></center>");
	win.document.write("</td>");   
	win.document.write("</tr>"); 
	<%}%>
	win.document.write("</td>");   
	win.document.write("</tr>");   
	win.document.write("</TABLE>");
	
	win.document.write("</body>");

	
	
}
function doClose()
{
	window.close();
}
</script>
</head>
<body >
<form name= "orgfrm" method="post" class="normal">
<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b>Security Valuation Report</b></td>
        </tr>
        <%if(arrsize>0)
  	  { %>
        <tr>
        <td>
          <table width="100%" border="1px" cellspacing="0" cellpadding="3"  class="outertable">
          <tr>
          <td colspan="11"><b>Valuation Expired Securities</b></td>
          </tr>
          <tr>
          <td align="center" nowrap="nowrap"><b>Sno</b></td>
           <td align="center"  nowrap="nowrap"><b>Branch Code</b></td>
           <td align="center"  nowrap="nowrap"><b>Branch Name</b></td>
           <td align="center"  nowrap="nowrap"><b>Proposal No</b></td>
          <td align="center" nowrap="nowrap"><b>CBS Customer ID</b></td>
          <td align="center" nowrap="nowrap"><b>Borrower Name</b></td>
          <td align="center" nowrap="nowrap"><b>Security ID</b></td>
          <td align="center" nowrap="nowrap"><b>Security Type</b></td>
          <!--<td align="center"><b>Security Description</b></td>
          --><td align="center" nowrap="nowrap"><b>Security Value</b></td>
          <td align="center" nowrap="nowrap"><b>Valuer Name</b></td>
          <td align="center" nowrap="nowrap"><b>Valuation Date</b></td>
          </tr>
          
          <%
        	  for(int i=0;i<arrsize;i++){
        		  ArrCol=(ArrayList)ArrRow.get(i);%>
        		  
        		  <tr>
        		  <td align="center"><%=i+1 %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(9)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(8)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(10)) %>&nbsp;</td>
        		  <td nowrap="nowrap"><%=Helper.correctNull((String)ArrCol.get(0)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(1)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(2)) %>&nbsp;</td>
        		  <td nowrap="nowrap"><%=Helper.correctNull((String)ArrCol.get(3)) %>&nbsp;</td>
        		  <!--<td><%//=Helper.correctNull((String)ArrCol.get(4)) %>&nbsp;</td>
        		  --><td align="right"><%=Helper.correctNull((String)ArrCol.get(5)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(6)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(7)) %>&nbsp;</td>
        	  
        	  <%} %>
          </table>
        </td>
      </tr>
      <%
      }%>
      <tr> 
          <td><b>&nbsp;</b></td>
        </tr>
      <%if(arrsize1>0)
	  { %>
      <tr>
        <td>
          <table width="100%" border="1px" cellspacing="0" cellpadding="3"  class="outertable">
          <tr>
          <td colspan="11"><b>Securities Approaching the Valuation Expiry</b></td>
          </tr>
          <tr>
          <td align="center" nowrap="nowrap"><b>Sno</b></td>
           <td align="center"  nowrap="nowrap"><b>Branch Code</b></td>
           <td align="center"  nowrap="nowrap"><b>Branch Name</b></td>
           <td align="center"  nowrap="nowrap"><b>Proposal No</b></td>
          <td align="center" nowrap="nowrap"><b>CBS Customer ID</b></td>
          <td align="center" nowrap="nowrap"><b>Borrower Name</b></td>
          <td align="center" nowrap="nowrap"><b>Security ID</b></td>
          <td align="center" nowrap="nowrap"><b>Security Type</b></td><!--
          <td align="center"><b>Security Description</b></td>
          --><td align="center" nowrap="nowrap"><b>Security Value</b></td>
          <td align="center" nowrap="nowrap"><b>Valuer Name</b></td>
          <td align="center" nowrap="nowrap"><b>Valuation Date</b></td>
          </tr>
          
           <%
        	  for(int i=0;i<arrsize1;i++){
        		  ArrCol=(ArrayList)ArrRow1.get(i);%>
        		  
        		  <tr>
        		  <td align="center"><%=i+1 %>&nbsp;</td>
        		   <td><%=Helper.correctNull((String)ArrCol.get(9)) %>&nbsp;</td>
        		   <td><%=Helper.correctNull((String)ArrCol.get(8)) %>&nbsp;</td>
        		   <td><%=Helper.correctNull((String)ArrCol.get(10)) %>&nbsp;</td>
        		  <td nowrap="nowrap"><%=Helper.correctNull((String)ArrCol.get(0)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(1)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(2)) %>&nbsp;</td>
        		  <td nowrap="nowrap"><%=Helper.correctNull((String)ArrCol.get(3)) %>&nbsp;</td>
        		  <!--<td><%//=Helper.correctNull((String)ArrCol.get(4)) %>&nbsp;</td>
        		  --><td align="right"><%=Helper.correctNull((String)ArrCol.get(5)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(6)) %>&nbsp;</td>
        		  <td><%=Helper.correctNull((String)ArrCol.get(7)) %>&nbsp;</td>
        	  
        	  <%} %>
          </table>
        </td>
      </tr>
      <%} %>
       <tr> 
          <td><b>&nbsp;</b></td>
        </tr>
      </table>
      
      <lapschoice:combuttonnew btnnames="Print Preview" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>