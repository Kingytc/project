<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
  String align="left";
  	
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<script>
var outlabel="<%= hshValues.get("labels")%>";
var textlabel="";
var per="<%= hshValues.get("txtDate")%>";
var datalen ="<%= vecOrg.size()%>";
function doClose()
{
	window.close();
}

function doPrintPreview()
{
	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=450,left=60,top=40");
	
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
	win.document.write("</table>");
  
	
	
	win.document.write("<center><TABLE border='1' cellspacing='0' cellpadding='3' bordercolor='#eeeeee' >");
	var agln="";
		
			win.document.write("<td> ");
			win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
			win.document.write("</td>")

		    win.document.write("<td align='center'><B>Proposal Number</B>");
		    win.document.write("</td>");
		    
		    win.document.write("<td align='center'><B>Applicant Name</B>");
		    win.document.write("</td>");
		    
		    win.document.write("<td align='center'><B>CBS Customer ID</B>");
		    win.document.write("</td>");
		    
		    win.document.write("<td align='center'><B>Address</B>");
		    win.document.write("</td>");
		    
		    win.document.write("<td align='center'><B>Phone No</B>");
		    
		    win.document.write("<td align='center'><B>Email Id</B>");
		    win.document.write("</td>");

			win.document.write("<td align='center'><B>Pending</B>");
		    win.document.write("</td>");
		    win.document.write("<td align='center'><B>Proposal Type </B>");
		    win.document.write("</td>");
			win.document.write("<tr>"); 
			win.document.write("</tr>"); 
			
			
			<%
			 int totcount1=vecOrg.size();
			if (vecOrg.size() > 0)
			{
				for(int i1=0;i1<vecOrg.size();i1++)
				{
				  ArrayList vecVal = new ArrayList();
				  vecVal =(ArrayList)vecOrg.get(i1);
			 %>
				  
			    win.document.write("</tr>");
			    win.document.write("<td align='center'>");
				win.document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=(i1+1)%>" +'&nbsp;'+ "</font></div>");
				win.document.write("</td>");
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(0))%>"+'&nbsp;'+"</font></td>");	
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(1))%>"+'&nbsp;'+"</font></td>");	
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(2))%>"+'&nbsp;'+"</font></td>");	
				
				
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(4))%>"+','+"</font>");
				win.document.write("<br>");
				
				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(7))%>"+','+"</font>");
				<%if(!Helper.correctNull((String) vecVal.get(8)).equalsIgnoreCase("")){ %>
				win.document.write("<br>");

				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(8))%>"+','+"</font>");
				<%} %>
				<%if(!Helper.correctNull((String) vecVal.get(9)).equalsIgnoreCase("")){ %>
				win.document.write("<br>");

				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(9))%>"+','+"</font>");
				<%} %>
				<%if(!Helper.correctNull((String) vecVal.get(10)).equalsIgnoreCase("")){ %>
						win.document.write("<br>");

				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(10))%>"+','+"</font>");;
				<%} %>
				<%if(!Helper.correctNull((String) vecVal.get(11)).equalsIgnoreCase("")){ %>
				win.document.write("<br>");

				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(11))%>"+','+"</font>");
				<%} %>
				<%if(!Helper.correctNull((String) vecVal.get(12)).equalsIgnoreCase("")){ %>
				win.document.write("<br>");

				win.document.write("<font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(12))%>"+','+"</font>");
				<%} %>
				
				win.document.write("</td>");
				
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(5))%>"+'&nbsp;'+"</font></td>");	
				win.document.write("<td><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(6))%>"+'&nbsp;'+"</font></td>");	
				win.document.write("<td align='center'><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(13))%>"+'&nbsp;'+"</font></td>");	
				win.document.write("<td align='center'><font size='1' face='MS Sans Serif'>"+"<%=Helper.correctNull((String) vecVal.get(14))%>"+'&nbsp;'+"</font></td>");	
				
		<%	
			}
		%>
			  win.document.write("</tr>");
		<%	}
		
		%>
	win.document.write("</TABLE></center>");
  win.document.write("<TABLE border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");		
	win.document.write("<td align='left'>");
	win.document.write("<b>Total Applications = &nbsp;</b>");
	win.document.write("<b>"+"<%=totcount1%>" + "</b>");
	win.document.write("</td>");
	win.document.write("</tr>");
	win.document.write("</TABLE>");
	win.document.write("</body>");
	win.document.write("</html>");
	
}

</script>
</head>

<body>
<br>
<form name= "orgfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b> Pending Digital Loan Applications</b></td>
        </tr>
   </table>
    <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr align="center">
						<td width="3%"><B>S.no</B> </td>
						<td width="10%"><B>Proposal Number</B></td>
						<td width="15%"><B>Applicant Name</B></td>
						<td width="10%"><B>CBS Customer ID</B></td>
						<td width="25%"><B>Address</B></td>
						<td width="10%"><B>Phone No</B></td>
						<td width="15%"><B>Email ID</B></td>
						<td width="15%"><B>Pending</B></td>
						<td width="15%"><B>Proposal Type</B></td>
						
			</tr>
         <%
         String StrAddress="";
		 int totcount2=vecOrg.size();

         if (vecOrg.size() > 0)
			{
				for(int i=0;i<vecOrg.size();i++)
				{
				  ArrayList vecVal = new ArrayList();
				  vecVal =(ArrayList)vecOrg.get(i);
			 %>
			 <tr >
						<td align="center"><%=i+1%></td>
						<td><%=Helper.correctNull((String) vecVal.get(0))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecVal.get(1))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecVal.get(2))%>&nbsp;</td>
						
						<td>
						
						<%=Helper.correctNull((String) vecVal.get(4))%>,
						<br>
						<%=Helper.correctNull((String) vecVal.get(7))%>,
						<%if(!Helper.correctNull((String) vecVal.get(8)).equalsIgnoreCase("")){ %>
						<br>
						<%=Helper.correctNull((String) vecVal.get(8))%>,
						<%} %>
						<%if(!Helper.correctNull((String) vecVal.get(9)).equalsIgnoreCase("")){ %>
						<br>
						<%=Helper.correctNull((String) vecVal.get(9))%>,
						<%} %>
						<%if(!Helper.correctNull((String) vecVal.get(10)).equalsIgnoreCase("")){ %>
						<br>
						<%=Helper.correctNull((String) vecVal.get(10))%>,
						<%} %>
						<%if(!Helper.correctNull((String) vecVal.get(11)).equalsIgnoreCase("")){ %>
						<br>
						<%=Helper.correctNull((String) vecVal.get(11))%>,
						<%} %>
						<%if(!Helper.correctNull((String) vecVal.get(12)).equalsIgnoreCase("")){ %>
						<br>
						<%=Helper.correctNull((String) vecVal.get(12))%>.
						<%} %>&nbsp;
						</td>
						
						<td><%=Helper.correctNull((String) vecVal.get(5))%>&nbsp;</td>
						<td><%=Helper.correctNull((String) vecVal.get(6))%>&nbsp;</td>
						<td align="center"><%=Helper.correctNull((String) vecVal.get(13))%>&nbsp;</td>
						<td align="center"><%=Helper.correctNull((String) vecVal.get(14))%>&nbsp;</td>
						
			 </tr>
			 <%}}%>
			 
          </table>
          <table width="100%" border="1" cellspacing="2" cellpadding="3"  class="outertable">
          <tr>
			<td align='left'>
			<b>Total Applications = &nbsp;</b>
			<b><%=totcount1%></b>
			</td>
			</tr>
          </table>
<br>
<lapschoice:combuttonnew btnnames="Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>
