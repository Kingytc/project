<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%//=hshValues%>

<%
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
  String align="left";
  	
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var outlabel="<%= hshValues.get("labels")%>";
var textlabel="";
var datalen ="<%= vecOrg.size()%>";
function doClose()
{
	window.close();
}
function doPrintPreview()
{
	if (datalen > 0){

	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=800,height=450,left=60,top=40");
	
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("<link rel='stylesheet'	href='<%=ApplicationParams.getAppUrl()%>css/report.css'	type='text/css'>");
	win.document.write("</head>");
	
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");
	
	win.document.write("<table width='100%' border='0' cellspacing='0' cellpadding='3'>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><img src='"+'<%=ApplicationParams.getAppUrl()%>'+"img/kbl_newlogo.jpg'></td>");          		
	win.document.write("</tr>");
	win.document.write("<tr>");
	win.document.write("<td align='center'><b>"+'<%=Helper.correctNull((String)hshValues.get("Org_Name"))%>'+"</b></td>");
	win.document.write("</tr>");
	win.document.write("</table>");
        
	win.document.write("<center>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><B><center>Application Tracking Report</center></B></TD>");
	win.document.write("</TABLE>");
	win.document.write("</center>");
	
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated By :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("genby")%>'+"</font></TD>");
	win.document.write("</TR>");
	
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated On :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=Helper.getCurrentDateTime()%>'+"</font></TD>");
	win.document.write("</TR>");
	
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Period :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("txtDate1")%>'+"</font></TD>");
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
    win.document.write("<center><TABLE border='1' cellspacing='0' cellpadding='3' bordercolor='#eeeeee'>");
	var agln="";			
		 textlabel =outlabel.split(',');
				win.document.write("<td> ");
				win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
				win.document.write("</td>")
		 for(l=0;l<textlabel.length;l++)
			{
				win.document.write("<td  height='10'> ");
				win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ textlabel[l] + "</B></font></div>");
				win.document.write("</td>");
			}
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
				   win.document.write("<td height = '2%' align='center'>");
					win.document.write("<div align='center'><font size='1' face='MS Sans Serif'>"+"<%=(i1+1)%>" +'&nbsp;'+ "</font></div>");
					win.document.write("</td>");
			<%	  for(int j1=0;j1<vecVal.size();j1++)
				  { 
					String stp = (String)vecVal.get(j1);
					align =(String)vecVal.get(j1+1);
					if (stp.equals(" "))
					{
						stp="&nbsp;";
					}
             %>
					win.document.write("<td align='<%=align%>' ><font size='1' face='MS Sans Serif'>"+"<%=stp%>"+'&nbsp;'+"</td> ");	
			<%	j1=j1+1; 
				}
			%>
				  win.document.write("</tr>");
			<%	}
%>
				
	<%			
			}
		
			%>
    			
		win.document.write("</TABLE></center>");
        win.document.write("<center><TABLE border='0' cellspacing='0' cellpadding='0' >");
		win.document.write("<tr width='30'>");		
		win.document.write("<td align='left' height = '30' >");
		win.document.write("<b><font size='2' face='MS Sans Serif'>Total Applications = &nbsp;</font></b>");
		win.document.write("<b><font size='2' face='MS Sans Serif'>"+"<%=totcount1%>" + "</font></b>");
		win.document.write("</td>");
		win.document.write("</tr>");
		win.document.write("</TABLE></center>");
		win.document.write("</body>");
		win.document.write("</html>");
	}
}

function printData()
{
	if (datalen > 0)
   	{
	textlabel =outlabel.split(',');
				document.write("<td width='2%'> ");
				document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "Sno" + "</B></font></div>");
				document.write("</td>")
		 for(l=0;l<textlabel.length;l++)
			{
				document.write("<td height='30'> ");
				document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ textlabel[l] + "</B></font></div>");
				document.write("</td>");
			}
	}
   else
	{
	   document.write("<tr><td align='center'>No Data Found</td></tr>");
	}	
         <%
         
         int totcount=vecOrg.size();
		  for(int i=0;i<vecOrg.size();i++)
		  {
			  ArrayList ht = new ArrayList();
			  ht =(ArrayList)vecOrg.get(i);
		  %>
					document.write("<tr>");
					document.write("<td height = '2%' align='center'>");
					document.write("<div align='center'>"+"<%=(i+1)%>" +'&nbsp;'+ "</div>");
					document.write("</td>");
		   <%	for(int j=0;j<ht.size();j++)
			    {
					String dt = (String)ht.get(j);
					align =(String)ht.get(j+1);
					if (dt.equals(" "))
					{
						dt="&nbsp;";
					}
					
			%>		
					document.write("<td height = '30' align='<%=align%>'>");
					document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=dt%>" +'&nbsp;'+ "</font></div>");
					document.write("</td>");
					
			<%	j= j+1;
				}%>
				document.write("</tr>");					
				
		  <%}
		%>
		        document.write("</table>");
		        document.write("<table width='100%' border='0' cellspacing='0' cellpadding='0'  bordercolor='#FFFFFF'>" );
    			document.write("<tr width='30'>");		
				document.write("<td align='left' height = '30' nowrap>");
				document.write("<b>Total Applications = &nbsp;</b>");
				document.write("<b>"+"<%=totcount%>" + "</b>");
				document.write("</td>");
				document.write("</tr>");		
			
	           }
	           


</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
</head>

<body>
<div align="center">
<h3></h3></div>


<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b>Application Tracking Report</b></td>
        </tr>
   </table>
<form name= "orgfrm" method="post" class="normal">

<div class="cellContainer">
  
    <table width="100%" border="1" cellspacing="0" cellpadding="0"  class="outertable">
      <tr> 
        <td height="3"> 
          <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable" >
            <script>         
			printData();
 		</script>
          </table>
        </td>
      </tr>
    </table>
  </div>
<br>
<lapschoice:combuttonnew btnnames="Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>
