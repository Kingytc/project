<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />  
<lapschoice:handleerror />
<%

%>

<html>
<head>
<title>National Portal  - Report List</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
<script>	
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

function doClose()
{
	window.close();
}	


function onload()
{
	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/NationalPortal.css" type="text/css">
<link href="../../css/NationalPortal.css" rel="stylesheet" type="text/css">
</head>
<body onload="onload();">	
<form name="national_portal" method="post" class="normal">
	
 <table  width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
        <td >
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td colspan="2" align="center"><b>NP Report List</b></td>
             </tr>
          </table>
          <br/>
          <table width="100%" border="1" cellspacing="0" cellpadding="2" class="outertable border1">
             <tr class="dataheader">
             	  <td align="center">Sr.No</td>
             	  <td align="center">Branch</td>
             	  <td align="center">Branch Sol ID</td>
             	  <td align="center">Name of the RO</td>
             	  <td align="center">RO Sold Id</td>
             	  <td align="center">Name of the FGMO</td>
             	  <td align="center">FGMO Sol ID</td>
             	  <td align="center">Application Reference ID</td>
             	  <td align="center">Applicant Name</td>
	        
             	  <td align="center">Application Date</td>
             	  <td align="center">Scheme name (National Portal)</td>
             	  <td align="center">Status</td>
             	  <td align="center">TAT in case Status is Open / Pending</td>
             	  <td align="center">Sanction date</td>
             	  <td align="center">Disbursement Date </td>
             	  <td align="center">In case of Hold / Rejection Reason</td>
             	  <td align="center">Account Number </td>
             </tr>
	        <%ArrayList g1 = new ArrayList();
	       ArrayList arr = (ArrayList) hshValues.get("arrdata");
			if (arr != null) {
				int vecsize = arr.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) arr.get(l);

					String strappstatus = Helper.correctNull((String) g1.get(1));
										%>
					<tr>	
					<td align="center"><%=l+1%></td>				
					<td align="center"><%= Helper.correctNull((String) g1.get(0)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(1)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(2)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(3)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(4)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(5)) %> </td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(6)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(7)) %> </td>
             	  
             	  <td align="center"><%= Helper.correctNull((String) g1.get(8)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(9)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(10)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(11)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(12)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(13)) %> </td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(14)) %></td>
             	  <td align="center"><%= Helper.correctNull((String) g1.get(15)) %> </td>
             						
						</tr>				
										
										<%}} %>
           </table>  
       </td>
   </tr>
</table>	
<br/>
<table border="0" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="1">
			<tr valign="middle">
				<td><input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>		
	
</form>
</body>
</html>