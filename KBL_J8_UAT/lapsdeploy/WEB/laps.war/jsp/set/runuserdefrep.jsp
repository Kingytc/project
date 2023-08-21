<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%

//out.println(hshValues);
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
  String align="left";
  	
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var outlabel="<%= hshValues.get("labels")%>";
var textlabel="";
var datalen ="<%= vecOrg.size()%>";
function doPrintPreview()
{
	if (datalen > 0)
   	{
	win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=600,height=450,left=60,top=40");
	win.document.write("<head>");
	win.document.write("<title>LAPS</title>");
	win.document.write("<meta http-equiv='Content-Type' content='text/html; charset=iso-8859-1'>");
	win.document.write("</head>");
	win.document.write("<body bgcolor='#FFFFFF' text='#000000'>");

	win.document.write("<center>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='4' face='MS Sans Serif'><B><center>User Definition Report</center></B></font></TD>");
	win.document.write("</TABLE>");
	win.document.write("</center>");

	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated By :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("genby")%>'+"</font></TD>");
	win.document.write("</TR>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><font size='1' face='MS Sans Serif'><B>Generated On :</B></font></TD>");
	win.document.write("<TD ><font size='1' face='MS Sans Serif'>"+'<%=(String)hshValues.get("txtDate")%>'+"</font></TD>");
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

    win.document.write("<center><TABLE border='1' cellspacing='0' cellpadding='0' >");
		var agln="";
			
		 textlabel =outlabel.split(',');
		 for(l=0;l<textlabel.length;l++)
			{
				win.document.write("<td width='11%' height='30'> ");
				win.document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ textlabel[l] + "</B></font></div>");
				win.document.write("</td>");
			}
				win.document.write("<tr>"); 
				win.document.write("</tr>"); 
			
			
			<%if (vecOrg.size() > 0)
			{
				for(int i1=0;i1<vecOrg.size();i1++)
				{
				  ArrayList vecVal = new ArrayList();
				  vecVal =(ArrayList)vecOrg.get(i1);
			 %>
				  
				  win.document.write("</tr>");
			<%	  for(int j1=0;j1<vecVal.size();j1++)
				  { 
						String stp =(String)vecVal.get(j1);
						align =(String)vecVal.get(j1+1);
						if (stp.equals(" "))
						{
							stp="&nbsp;";
						}
						
             %>
					win.document.write("<td width='20%'align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=stp%>"+'&nbsp;'+"</td> ");	
			<%   j1 = j1 +1;
				}
			%>
				  win.document.write("</tr>");
			<%	}
			}
			%>
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
		 for(l=0;l<textlabel.length;l++)
			{
				document.write("<td width='11%' height='30'> ");
				document.write("<div align='center'><B>"+ textlabel[l] + "</B></div>");
				document.write("</td>");
			}
		
	}
   else
	{
	   document.write("<tr class='datagrid'><td align='center'>No Data Found</td></tr>");
	}
         <%
		  for(int i=0;i<vecOrg.size();i++)
		  {
			  ArrayList ht = new ArrayList();
			  ht =(ArrayList)vecOrg.get(i);
		  %>
				document.write("<tr>");
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
					document.write("<div align='<%=align%>'>"+"<%=dt%>"+'&nbsp;'+ "</div>");
					document.write("</td>");
					
			<%	j =j +1;
				}%>
				document.write("</tr>");					
		  <%}
		%>
}
function doPrevious()
{
	window.close();
}
function doClose()
{
	window.close();
}
</script>
</head>
<body >
<br>
<h3><center>User Definition Report</center></h3>
<form name= "orgfrm" method="post" class="normal">

<div class="cellContainer">
  
    <table width="100%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
            <script>
         
			printData();
 		</script>
          </table>
        </td>
      </tr>
    </table>
  </div>
<br>
<lapschoice:combuttonnew btnnames="Previous_Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>
