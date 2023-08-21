<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%ArrayList ArrRow=new ArrayList();
    ArrRow=(ArrayList)hshValues.get("arrRow");


String align="left";
int arrsize=0; 
if(ArrRow !=null)
{
 arrsize=ArrRow.size();
}
java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
String str_report = Helper.correctNull((String) request.getParameter("report"));
int intFcnt = Helper.parseInt((String)hshValues.get("intFundcnt"));
int intNFcnt = Helper.parseInt((String)hshValues.get("intNonfundcnt"));
int intPromocnt = Helper.parseInt((String)hshValues.get("intPromocnt"));

%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var report = "<%=str_report%>";
var outlabel="<%= hshValues.get("labels")%>";
var textlabel="";
var datalen ="<%= ArrRow.size()%>";

function doClose()
		{
			window.close();
		}

function printData()
		{
			if (datalen > 0)
		   	{
			textlabel =outlabel.split(',');
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
			int totcount=ArrRow.size();
			  for(int i=0;i<ArrRow.size();i++)
			  {
				  ArrayList ht = new ArrayList();
				  ht =(ArrayList)ArrRow.get(i);
			  %>
				document.write("<tr>");
			   <%	for(int j=0;j<ht.size();j++)
				    {
						String dt =ht.get(j).toString();
						if (dt.equals(" "))
						{
							dt="&nbsp;";
						}	
						if((j==11||j==14) && str_report.equals("enchancement")){
							
							int intTemp=0;
							 if(j==11)
								 intTemp=intFcnt;
							 else
								 intTemp=intNFcnt;
						String[] strArr=((String)ht.get(j)).split("@");
						for(int a=0;a<strArr.length;a++){
						String[] strArr1=strArr[a].split("~");
						if(strArr1!=null && strArr1.length>1){%>
						
						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=strArr1[0]%>" +'&nbsp;'+ "</font></div>");
						document.write("</td>");

						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=strArr1[1]%>" +'&nbsp;'+ "</font></div>");
						document.write("</td>");
						
						<%}else{%>

						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
						document.write("</td>");

						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
						document.write("</td>");
							<%}
						}
						for(int a=strArr.length;a<intTemp;a++)
						{%>

						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
						document.write("</td>");

						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
						document.write("</td>");
							
						<%}
						%>
	
							
						<%}
						
						
		if((j==40) && str_report.equals("ca")){
							int intTemp=0;
							ArrayList arr1=(ArrayList)ht.get(40);
							ArrayList arr2=(ArrayList)ht.get(41);
							ArrayList arr3=(ArrayList)ht.get(42);
							if(arr1!=null && arr1.size()>0)
							{
								
								for(int a=0;a<arr1.size();a++)
								{%>

								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'<%=arr1.get(a)%>'+ "</font></div>");
								document.write("</td>");

								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'<%=arr2.get(a)%>'+ "</font></div>");
								document.write("</td>");


								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'<%=arr3.get(a)%>'+ "</font></div>");
								document.write("</td>");
									
								<%}
								
								if(intPromocnt>arr1.size())
								{
									for(int a=arr1.size();a<intPromocnt;a++)
									{%>

									document.write("<td height = '30' align='<%=align%>'>");
									document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
									document.write("</td>");

									document.write("<td height = '30' align='<%=align%>'>");
									document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
									document.write("</td>");


									document.write("<td height = '30' align='<%=align%>'>");
									document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
									document.write("</td>");
										
									<%}
								}
								
								j=j+2;
							}
							else
							{
								for(int a=0;a<intPromocnt;a++)
								{%>

								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
								document.write("</td>");

								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
								document.write("</td>");


								document.write("<td height = '30' align='<%=align%>'>");
								document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+'&nbsp;'+ "</font></div>");
								document.write("</td>");
									
								<%}
								j=j+2;
							}
						
						%>

						<%}
						
						
						else{
				%>	
						document.write("<td height = '30' align='<%=align%>'>");
						document.write("<div align='<%=align%>'><font size='1' face='MS Sans Serif'>"+"<%=dt%>" +'&nbsp;'+ "</font></div>");
						document.write("</td>");				
				<%	
						}}%>
					document.write("</tr>");		
			  <%}
			%>
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
   <td align="center"><b><%=Helper.correctNull((String)hshValues.get("strHeader"))%>&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("strFromDate"))%> - <%=Helper.correctNull((String)hshValues.get("strToDate"))%></b>
   </td>
</tr>
</table>
   
<form name="custdet" method="post" class="normal">
          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" >
            <script>         
			printData();
 		</script>
          </table>
</form>
</body>
</html>
