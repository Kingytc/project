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
  ArrayList vecalign = new ArrayList();
  vecalign=(ArrayList)hshValues.get("vecalign");
%>
var datalen ="<%= vecrow.size()%>";
var per="<%= hshValues.get("period")%>";
function printData()
{
	var l;
	textlabel =outlabel.split(',');
	document.write("<td> ");
	document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
	document.write("</td>")
	for(l=0;l<textlabel.length;l++)
	{
		document.write("<td> ");
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
					// align =(String)ht.get(j+1);
					if (data.equals(""))
					{
						data="&nbsp;";
					}
	%>		
					document.write("<td align='<%=vecalign.get(j)%>'>");
					document.write("<div align='<%=vecalign.get(j)%>'><font size='1' face='MS Sans Serif'>"+"<%=data%>" +'&nbsp;'+ "</font></div>");
					document.write("</td>");
			<%	
				// j= j+1;
			  }
			%>
				document.write("</tr>");					
		  <%}
		%>
		        	
	            document.write("</table>");
		        document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'  bordercolor='#FFFFFF'>" );
    			document.write("<tr>");		
				document.write("<td align='left' ><font size='1' face='MS Sans Serif'>");
				document.write("<b>Total Applications = &nbsp;</font></b>");
				document.write("<b><font size='1' face='MS Sans Serif'>"+"<%=totcount%>" + "</font></b>");
				document.write("</td>");
				document.write("</tr>");		
			
} 

function printpreview()
{
	if(datalen>0)
	{
	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=450,left=60,top=40");
	win.document.write("<html>");
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("</head>");
	win.document.write("<body bgcolor='#FFFFFF' text='#000000' leftmargin='0' topmargin='0' marginwidth='0' marginheight='0'>");
	win.document.write("<form name= 'orgfrm' method='post'>");
 	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
    win.document.write("<tr>");
    win.document.write("<td align='center'><img src='<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg'></td>");       		
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'><strong>Karnataka Bank Ltd.</strong></td>");
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'><%=Helper.correctNull((String)hshValues.get("orgname"))%></td>");
    win.document.write("</tr>");
    win.document.write("<tr>"); 
    win.document.write("<td align='center'><b>NPA Application <%=Helper.correctNull((String)hshValues.get("status"))%> Status Report</b></td>");
    win.document.write("</tr>");
	win.document.write("<br>");
	win.document.write("</table>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated By :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=session.getAttribute("strUserName")%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated On :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=Helper.getCurrentDateTime()%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Period:</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+per+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD > </TD>");
	win.document.write("<TD > </TD>");
	win.document.write("</TR>");
	win.document.write("</TABLE>");
	win.document.write("<div>");
    win.document.write("<table width='100%' border='1' cellspacing='0' cellpadding='0' align='center'  bordercolor='#eeeeee'>");
    win.document.write("<tr>"); 
    win.document.write("<td height='3'>"); 
    win.document.write("<table width='100%' border='1' cellspacing='0' cellpadding='3'  bordercolor='#eeeeee'>");
	var l;
	textlabel =outlabel.split(',');
	win.document.write("<td> ");
	win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
	win.document.write("</td>")
	for(l=0;l<textlabel.length;l++)
	{
		win.document.write("<td> ");
		win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ textlabel[l] + "</B></font></div>");
		win.document.write("</td>");
	}
	 <%
         int totcount1=vecrow.size();
	 	 if(totcount1==0)
	 	 {
	 %>	
	 		 win.document.write("<tr>");
	 		 win.document.write("<td align='center' colspan='");
	 		 win.document.write(textlabel.length+1);
	 		 win.document.write("'>");
	 		 win.document.write("<div align='center'>No Data Found</div>");
	 		 win.document.write("</td>");
	 		 win.document.write("</tr>");
	 <%
	 	 }
		  for(int i=0;i<totcount;i++)
		  {
			  ArrayList veccol = new ArrayList();
			  veccol =(ArrayList)vecrow.get(i);
	 %>
		      win.document.write("<tr>");
			  win.document.write("<td align='center'>");
			  win.document.write("<div align='center'>"+"<%=(i+1)%>" +'&nbsp;'+ "</div>");
			  win.document.write("</td>");
	 <%	
	 		  for(int j=0;j<veccol.size();j++)
			  {
					String data = (String)veccol.get(j);
					// align =(String)ht.get(j+1);
					if (data.equals(""))
					{
						data="&nbsp;";
					}
	%>		
					win.document.write("<td align='<%=vecalign.get(j)%>'>");
					win.document.write("<div align='<%=vecalign.get(j)%>'><font size='1' face='MS Sans Serif'>"+"<%=data%>" +'&nbsp;'+ "</font></div>");
					win.document.write("</td>");
			<%	
				// j= j+1;
			  }
			%>
				win.document.write("</tr>");					
		  <%}
		%>
		        	
	            win.document.write("</table>");
		        win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>" );
    			win.document.write("<tr>");		
				win.document.write("<td align='left' ><font size='1' face='MS Sans Serif'>");
				win.document.write("<b>Total Applications = &nbsp;</font></b>");
				win.document.write("<b><font size='1' face='MS Sans Serif'>"+"<%=totcount%>" + "</font></b>");
				win.document.write("</td>");
				win.document.write("</tr>");	
				win.document.write("</table>");
        		win.document.write("</td>");
      			win.document.write("</tr>");
    			win.document.write("</table>");
				win.document.write("</div>");
				win.document.write("</form>");
				win.document.write("</body>");
				win.document.write("</html>");
		}
		else
		{
			//alert("No Data Found");
		}	
}	
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css"	type="text/css">
</head>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
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
          <td align="center"><b>NPA Application <%=Helper.correctNull((String)hshValues.get("status"))%> Status Report</b></td>
        </tr>
<br>
</table>
<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"   align="center">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3"  bordercolor="#FFFFFF">
            <script>         
			printData();
 		</script>
          </table>
        </td>
      </tr>
    </table>
</div>
  <table border="0" cellspacing="0" cellpadding="0"  class="outertable border1"  align="center">
    <tr> 
      <td height="17"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="45%"> 
                <input type="button" name="Button232253" value="Close" 
                style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="window.close()">
            </td>
            <td width="55%"> 
                <input type="button" name="Button2322532" value="Print Preview" 
                style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:100;font-weight:bold" 
                onclick="printpreview()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
</form>
</body>
</html>