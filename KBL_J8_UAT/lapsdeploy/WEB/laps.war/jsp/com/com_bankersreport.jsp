<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%

//out.println("hshValues"+hshValues);

  ArrayList arrRow=new ArrayList();
  ArrayList arrCol=new ArrayList();
  if(hshValues!=null){
  arrRow=(ArrayList)hshValues.get("arrRow");
  }
  int intsize=0,intsize1=0;
  String strtota1="",strtotal2="",strtotal3="",strtotal4="",strtotal5="",strtotal6="",strtotal7="";
  if(arrRow!=null && arrRow.size()>0)
  {
	  intsize=arrRow.size();
	  intsize1=intsize;
  }

%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<script>

var datalen ="<%=intsize%>";

		
function doClose()
{
	window.close();
}
function doPrintPreview()
{

	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=1000,height=500,left=60,top=40");
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");
	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+<%=ApplicationParams.getAppUrl()%>+"img/kbl_newlogo.jpg'></td>");           		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><strong>Karnataka Bank Ltd.</strong></td>");
	win.document.write("</tr>");
	win.document.write("</table>");
	
	win.document.write("<center>");
	win.document.write("<table border='0'>");
	win.document.write("<tr>");
	win.document.write("<td width='20%'><B><center>Banker'sCertificate Report Generation</center></B></TD>");
	win.document.write("<tr>")
    win.document.write("<td align='center'><b>Generated By :<%=Helper.correctNull((String)hshValues.get("genby"))%> </b></td>")
   win.document.write(" </tr>")
   win.document.write("<tr>")
    win.document.write("<td align='center'><b>Generated By Id :<%=Helper.correctNull((String)hshValues.get("strUserIdforgen"))%> </b></td>")
   win.document.write(" </tr>")
   win.document.write(" <tr>")
   
   win.document.write(" <td align='center'><b>Generated On :  <%=Helper.getCurrentDateTime()%></b></td>")
    win.document.write("</tr> ")
	win.document.write("</table>");
	win.document.write("</center>");

	
	if(datalen >=0){
    win.document.write("<center><table border='1' cellspacing='0' cellpadding='0' bordercolor='#eeeeee' >");
    win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>S.No</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Application number</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Applied for</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Customer ID</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Customer name</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Amount of BC/LOC</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Name of the Beneficiary</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Tender Notification date</B></div>");
	win.document.write("</td>");
	win.document.write("<td height='30'> ");
	win.document.write("<div align='center'><B>Work order/Contract details</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Date of issue</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Date of Sanction</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Sanction Ref.</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Applicable Charges</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Charges collected</B></div>");
	win.document.write("</td>");
	win.document.write("<td  height='30'> ");
	win.document.write("<div align='center'><B>Status</B></div>");
	win.document.write("</td>");
	win.document.write("</tr>");
				<% if (arrRow!=null && arrRow.size() > 0)
				{
					for(int i=0;i<arrRow.size();i++)
					 { 
						  arrCol = new ArrayList();
					 	  arrCol =(ArrayList)arrRow.get(i);
					 	%>
				   	win.document.write("<tr align='center'>");
				   	win.document.write("<td>");
				   	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=i+1%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");	
				   	win.document.write("<td>");
				   	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(0)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td>");
				   	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(1)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(2)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(3)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(4)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(5)%>"+'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(6)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(7)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
					win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(8)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
					win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(9)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(10)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(11)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(12)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
					win.document.write("<td align='left'>");
				   	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(13)%>" +'&nbsp;'+ "</font></div>");
				   	win.document.write("</td >");
				   	win.document.write("</tr>");
					
					
				   	
		<%}}%>
         	
}
else
{
		 win.document.write("<center><table border='1' width='100%' cellspacing='0' cellpadding='0' bordercolor='#eeeeee' >");
		 win.document.write("<tr><td align='center'>No Data Found</td></tr>");
}
	win.document.write("<tr>");	
	win.document.write("<td>");
	win.document.write("<div align='center'><B>Total</B></div>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String)hshValues.get("sumofamount"))%>" +'&nbsp;'+ "</font></div>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String)hshValues.get("actotal"))%>" +'&nbsp;'+ "</font></div>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String)hshValues.get("cctotal"))%>" +'&nbsp;'+ "</font></div>");
	win.document.write("</td>");
	win.document.write("</td>");
	win.document.write("<td>");
	win.document.write("</tr>");
win.document.write("</table>");
win.document.write("</center>"); 
win.document.write("<table>");
win.document.write("<tr>");
win.document.write("<td><B>Total Applications = "+'<%=intsize1%>');
win.document.write("</B></td>");
win.document.write("</tr>");
win.document.write("</table>");
win.document.write("</body>");
win.document.write("</html>");
}


function doPrintPreview2()
{
if(datalen >=0){

	document.write("<tr>");
	document.write("<td  height='30'> ");
	document.write("<div align='center'><B> Sl.No </B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Application number</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Applied for</B></div>");
	document.write("</td>");
	document.write("<td  height='30'> ");
	document.write("<div align='center' nowrap><B>Customer ID</B></div>");
	document.write("</td>");
	document.write("<td  height='30'> ");
	document.write("<div align='center' nowrap><B>Customer name</B></div>");
	document.write("</td>");
	document.write("<td  height='30'> ");
	document.write("<div align='center' nowrap><B>Amount of BC/LOC Requested</B></div>");
	document.write("</td>");
	document.write("<td  height='30' > ");
	document.write("<div align='center' nowrap><B>Name of the Beneficiary</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Tender Notification date</B></div>");
	document.write("</td>");
	document.write("<td  height='30'> ");
	document.write("<div align='center' nowrap><B>Work order/Contract details</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Date of issue</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Date of Sanction</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Sanction Ref.</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Applicable Charges</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Charges collected</B></div>");
	document.write("</td>");
	document.write("<td   height='30'> ");
	document.write("<div align='center' nowrap><B>Status</B></div>");
	document.write("</td>");
	document.write("</tr>");

	<% if (arrRow!=null && arrRow.size() > 0)
	{
		for(int i=0;i<arrRow.size();i++)
		 { 
			  arrCol = new ArrayList();
		 	  arrCol =(ArrayList)arrRow.get(i);
		 	%>
	   document.write("<tr align='center'>");	
	   document.write("<td>");
	   	 document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=i+1%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td>");
	   	 document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(0)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td>");
	   	 document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(1)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(2)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(3)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(4)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(5)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td align='left' nowrap>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(6)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(7)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(8)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(9)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(10)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(11)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(12)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	 	document.write("<td align='left'>");
	   	 document.write("<div><font size='1' face='MS Sans Serif'>"+"<%=arrCol.get(13)%>" +'&nbsp;'+ "</font></div>");
	   	 document.write("</td >");
	   	 document.write("</tr>");	
	   	<%	} } %>
         		
}
else
{
	 document.write("<tr><td align='center'>No Data Found</td></tr>");
}

document.write("<table>");
document.write("<tr>");
document.write("<td><B>Total Applications = "+'<%=intsize%>');
document.write("</B></td>");
document.write("</tr>");
document.write("</table>");
}



</script>
</head>
<body>

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
		<tr>
			<td>
				<table width="95%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
					<tr class="dataheader">
						<td width="14%" align="center"  valign="center">SI no</td>
						<td align="center" >Applied For</td>
						<td align="center" >CBSID</td>
						<td align="center" >Applicant Name</td>
						<td align="center" >Amount of BC/LOC requested</td>
						<td width="9%" align="center" >Name of the Beneficiary</td>
						<td align="center" >Tender Notification Date</td>
						<td width="9%" align="center" >Work Order/contract Details</td>
						<td align="center" >Date of Issue</td>
						<td width="14%" align="center"  >Sanction Ref No</td>
						<td width="14%" align="center"  >Date of Sanction</td>
						<td width="14%" align="center"  >Charges</td>
						<td align="center" >Status</td>
					</tr>
					<tr class="dataheader">
					<%
					if(arrRow!=null&&arrRow.size()>0)
					{
						for(int i=0;i<arrRow.size();i++)
						{
							arrCol=(ArrayList)arrRow.get(i);
					%>
					<td><%=i+1%></td>
					<td><%=Helper.correctNull((String)arrCol.get(0))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(2))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(3))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(4))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(5))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(6))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(7))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(8))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(9))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(10))%></td>
					<td><%=Helper.correctNull((String)arrCol.get(11))%></td>
					
					</tr>
					 <% 
	  }
	  }
					
	  %>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
=======
<br>
<form name= "orgfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
       <tr> 
          <td align="center"><b>Banker Certificate Report Generation </b></td>
        </tr>
       <tr>
        <td align="center"><b>Generated By :<%=Helper.correctNull((String)hshValues.get("genby"))%> </b></td>
        </tr>
        <tr>
        <td align="center"><b>Generated On :  <%=Helper.getCurrentDateTime()%></b></td>
        </tr> 
                 
    </table>
    
    
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
      <tr> 
        <td > 
          <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable border1">
            <script>
        
            doPrintPreview2();
			
 		</script>
          </table>
        </td>
      </tr>
    </table>
<br>
>>>>>>> .r25411

 	<lapschoice:combuttonnew btnnames="Print Preview" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />  
 
<input type="hidden" name ="hiduserOrgCode" value ="">
</form>
</body>
</html>
