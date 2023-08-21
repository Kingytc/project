<%@ include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<%
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
  String align="left";
  	
%>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Spread Updation Report</title>
</head>
<script type="text/javascript">
var outlabel="<%= hshValues.get("labels")%>";
var datalen ="<%= vecOrg.size()%>";
function printData()
{
	if (datalen > 0)
   	{
	textlabel =outlabel.split(',');
				document.write("<td width='2%'> ");
				document.write("<div align='center'><font size='1' face='MS Sans Serif'><B>"+ "S.No." + "</B></font></div>");
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
			   ht = (ArrayList)vecOrg.get(i);
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
				document.write("<b>Total Proposals = &nbsp;</b>");
				document.write("<b>"+"<%=totcount%>" + "</b>");
				document.write("</td>");
				document.write("</tr>");		
			
	           }
function doClose()
{
	window.close();
}
</script>
<body>
<div align="center">
<h3></h3></div>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><b>Interest Report</b></td>
        </tr>
   </table>
<form name="custdet" method="post" class="normal">

  
    <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable border1">
      <tr> 
        <td height="3"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" >
            <script>         
			printData();
 		</script>
          </table>
        </td>
      </tr>
    </table>
<br>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</form>
</body>
</html>