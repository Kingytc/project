<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%String strFormat=Helper.correctNull((String)request.getParameter("strFormat")); 
ArrayList arrFinCommRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrFinCommRow = (ArrayList)hshValues.get("arrfinComments");%>
<html>
<head>
<title>Annexure IV</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body, table td
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;
}
#top{background-color: #ffffff;}
#top table{ border-collapse: collapse;}
#top td {border: 0.5pt solid #000000; FONT-SIZE: 16px; COLOR: #000000; LINE-HEIGHT: 16px; FONT-FAMILY: "Book Antiqua"}

.title
{
FONT-SIZE: 16px !important; COLOR: #000000 !important; FONT-FAMILY: "Book Antiqua" !important;font-weight: bold !important;
}
</style>
</head>
<%

String strValuesIn = Helper.correctNull((String)hshValues.get("strFinvaluesIn"));
if(strValuesIn.equalsIgnoreCase("Rs"))
{
	strValuesIn	= "(Amount in  "+strValuesIn+".)";
}
else
{
	strValuesIn	= "(Rs. in  "+strValuesIn+")";
}
%>
<body>
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
	
	<%if(strFormat.equalsIgnoreCase("EAN4")){ %>
		<tr>
			<td align="center" class="title"><br>ANNEXURE IV</td>
		</tr>
		<tr>
			<td align="center" class="title"><br>FINANCIAL STATEMENTS/ RATIO ANALYSIS</td>
		</tr>
		<%}else{ %>
		<tr>
			<td align="center" class="title"><br>ANNEXURE</td>
		</tr>
		<tr>
			<td align="center" class="title"><br>FINANCIAL STATEMENTS</td>
		</tr>
		<%} %>
	</table>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
		<tr>
			<td valign="top"><br><b>BALANCE SHEET :</b><br></td>
		</tr>
	</table>
	
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
	<tr>
		<td align="left"><br><b> LIABILITIES :</b></td>                     
	</tr>
	<tr>
 		<td align="right"><%=strValuesIn %></td>                     
 	</tr>
 	<tr>
		<td align="right">As on</td>                     
	</tr>
	</table>
	
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0" class="">
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues" />
				</jsp:include>
			</td>
		</tr>
	</table>
	
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0">
	<tr>
		<td align="left"><br><b>ASSETS : </b></td>                     
	</tr>
	<tr>
 		<td align="right"><%=strValuesIn %></td>                     
 	</tr>
 	<tr>
		<td align="right">As on</td>                     
	</tr>
	</table>
	
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0" class="">	
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues1" />
				</jsp:include>
			</td>
		</tr>
	</table>
<br>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0" class="">
		<tr>
			<td align="left"><b> PROFIT AND LOSS ACCOUNT:</b></td>                     
  		</tr>
  		<tr>
  			<td align="right"><%=strValuesIn %></td>                     
	 	</tr>
	 </table>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0" class="">
 		<tr>
 			<td align="right">For the year ended</td>                     
	 	</tr>
	 </table>
 
	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="0" class="">
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues2" />
				</jsp:include>
			</td>
		</tr>
	</table>
<br>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3">
		<tr>
			<td valign="top"><b>RATIO ANALYSIS:</b></td>
		</tr>
	</table>

	<table width="95%" border="0" cellspacing="0" align="center" cellpadding="3" class="">
		<tr>
			<td align="left"><br><b>CAPITALISATION/COVERAGE/LIQUIDITY RATIOS :</b></td>                     
		</tr>
		<tr>
  			<td align="right"><%=strValuesIn %></td>                     
	 	</tr>
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues3" />
				</jsp:include>
			</td>
		</tr>
		<tr>
			<td align="left"><br><b>PROFITABILITY/TURN OVER/ OPERATING : </b></td>                     
	  	</tr>
	  	<tr>
 			<td align="right"><%=strValuesIn %></td>                     
 	</tr>
		<tr valign="top">
			<td>
				<jsp:include page="../print/com_financialprint.jsp" flush="true">
				<jsp:param name="pagevalue" value="hshReqValues4" />
				</jsp:include>
			</td>
		</tr>
	</table>
	
	<%if(strFormat.equalsIgnoreCase("EAN4")){ %>
	
	<table width="95%" align="center" cellpadding="3" cellspacing="0" border="0">
<tr>
<td class="title"><br>Financial Comments:</td></tr>
				
<% if(Helper.correctNull((String)hshValues.get("fincommcheck")).equalsIgnoreCase("Y")) { %>
	<%if(arrFinCommRow!=null&&arrFinCommRow.size()>0){ 
	
	for(int j=0;j<arrFinCommRow.size();j++)
	{ 
		arrCol	= (ArrayList)arrFinCommRow.get(j);%>
		<tr><td class="title"><%=Helper.correctNull((String)arrCol.get(0))%></td></tr>
		<tr><td><%=Helper.correctNull((String)arrCol.get(1))%></td></tr>
		
<%}}}
else
{%>
	<tr><td style="border: none;">- Nil -</td></tr>
<% }
%>
</table>
	
	<%} %>

</body>
</html>