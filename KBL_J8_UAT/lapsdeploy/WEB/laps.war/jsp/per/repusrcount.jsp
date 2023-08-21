<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>

<%
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
  	
%>

<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css"	type="text/css">
<script>
function doClose()
{
	window.close();
}
function doPrintPreview()
{

win = window.open("","","scrollbars=yes,toolbars=Yes,menubar=Yes,width=600,height=450,left=60,top=40");
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
	win.document.write("<td align='center'><b>"+'<%=Helper.correctNull((String)hshValues.get("OrgName"))%>'+"</b></td>");
	win.document.write("</tr>");
	win.document.write("</table>");
	
	win.document.write("<center>");
	win.document.write("<TABLE border='0'>");
	win.document.write("<TR>");
	win.document.write("<TD width='20%'><B><center>Individual User Disposal of loan Application</center></B></TD>");
	win.document.write("</TABLE>");
	win.document.write("</center>");
	
   win.document.write("<table width='100%' border='1' cellspacing='0' cellpadding='0'  bordercolor='#000000'>");
          
          
                                win.document.write("<tr>");
                                  win.document.write("<td height='50' align='center'><b>User</b>&nbsp;&nbsp;</td>");
                                  win.document.write("<td height='50' align='center'>Application(s) <br> Approved&nbsp;</td>");
                                  win.document.write("<td height='50' align='center'>Amount</td>");
                                  win.document.write("<td height='50' align='center'>Application(s) <br> Rejected&nbsp;</td>");
                                  win.document.write("<td height='50' align='center'>Amount</td>");
                                  win.document.write("<td height='50' align='center'>Application(s) <br> Inprocess&nbsp;</td>");
                                  win.document.write("<td height='50' align='center'>Amount</td>");
                                  win.document.write("<td height='50' align='center'>Lodged  <br> Application(s)&nbsp;</td>");
                                  win.document.write("<td height='50' align='center'>Amount</td>");
                                win.document.write("</tr>");
          <%
          ArrayList vecReport1=new ArrayList();
			int vecRsize1=0;
			if (hshValues != null)
			 {
			   vecReport1 = (ArrayList)hshValues.get("vecValues");
			 }
			 if(vecReport1!=null)
			{
				vecRsize1 =vecReport1.size();
				
			}
			ArrayList b11=null;
			 		for (int l1=0;l1<vecRsize1;l1++)
					 {
						
						int colSize1=0;
						 if(l1<vecRsize1)
						 {
							 b11 = (ArrayList)vecReport1.get(l1);

							if(b11!=null)
							{
							   colSize1 = b11.size();
       						}
						 }
						
											
						 if(colSize1>0)	
						  {

			
			
			%>
                                win.document.write("<tr bgcolor='#FFFFFF'> ");
                                  win.document.write("<td align='center' height='25'><b><%=Helper.correctNull((String)b11.get(0))%></b>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(1))%>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(2))%>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(3))%>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(4))%>&nbsp;</td>");                                  
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(5))%>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(6))%>&nbsp;</td>");                                  
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(7))%>&nbsp;</td>");
                                  win.document.write("<td align='center' height='25'><%=Helper.correctNull((String)b11.get(8))%>&nbsp;</td>");
                                win.document.write("</tr>");
                                <%
			}
		}
			
			
			%>
          
            
          win.document.write("</table> </td></tr>");
    }  
</script>
</head>
<body>
<form  method="post" name= "orgfrm" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td align="center"><img
			src="<%=ApplicationParams.getAppUrl()%>img/kbl_newlogo.jpg"></td>
	</tr>
	<tr>
		<td align="center"><%=Helper.correctNull((String) hshValues.get("OrgName"))%></td>
	</tr>
	<tr>
		<td align="center"><b>Individual User Disposal of loan Application</b></td>
	</tr>
</table>

  
<table width="100%" border="1" cellspacing="0" cellpadding="0"  class="outertable">
  <tr> 
    <td height="3"> 
      <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
        <tr class="dataheader"> 
          <td height="50"><b>User</b> &nbsp;&nbsp;</td>
          <td height="50" align="center">Application(s) Approved&nbsp;</td>
          <td height="50" align="center">Amount</td>
          <td height="50" align="center">Application(s) Rejected&nbsp;</td>
          <td height="50" align="center">Amount</td>
          <td height="50" align="center">Application(s)Inprocess&nbsp;</td>
          <td height="50" align="center">Amount</td>
          <td height="50" align="center">Lodged <br>Application(s)&nbsp;</td>
          <td height="50" align="center">Amount</td>
        </tr>
        <%
          ArrayList vecReport11=new ArrayList();
			int vecRsize11=0;
			if (hshValues != null)
			 {
			   vecReport11 = (ArrayList)hshValues.get("vecValues");
			 }
			 if(vecReport11!=null)
			{
				vecRsize11 =vecReport11.size();
				
			}
			ArrayList b111=null;
			 		for (int l1=0;l1<vecRsize11;l1++)
					 {
						
						int colSize1=0;
						 if(l1<vecRsize11)
						 {
							 b111 = (ArrayList)vecReport11.get(l1);

							if(b111!=null)
							{
							   colSize1 = b111.size();
       						}
						 }
						
											
						 if(colSize1>0)	
						  {
			
			%>
        <tr class="datagrid"> 
          <td height="25"><b><%=Helper.correctNull((String)b111.get(0))%></b>&nbsp;&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(1))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(2))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(3))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(4))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(5))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(6))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(7))%>&nbsp;</td>
          <td align="center" height="25"><%=Helper.correctNull((String)b111.get(8))%>&nbsp;</td>
        </tr>
        <%
			}
		}
			
			
			%>
      </table>
    </td>
  </tr>
  <br>
<lapschoice:combuttonnew btnnames="Print Preview"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <br>
</table>
</form>
</body>
</html>
