<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ page import="java.util.*,java.text.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror/>
<%
ArrayList arrRowDefault		= new ArrayList();//need
ArrayList arrRowCIBIL	= new ArrayList();//need
ArrayList arrColCIBIL	= new ArrayList();
ArrayList arrColDefault		= new ArrayList();

	hshValues = (HashMap)hshValues.get("hshReqValues5");
	//out.println(hshValues);

if(hshValues!=null)
{
	
	arrRowDefault = (ArrayList)hshValues.get("arrRowDefault");//need
	arrRowCIBIL = (ArrayList)hshValues.get("arrRowCIBIL");//need
	
	
}

String strNil= "Nil",strValuesIn="";

%>
<html>
<head>
<title>Annexure - II</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body>
<table width="100%" border="1" cellspacing="0" cellpadding="4"
	align="center">
	
	<tr>
		<td align="center" width="5%"><b>S:NO</b></td>
		<td align="center" width="30%"><b>Particular</b></td>
		<td align="center" width="60%"><b>Input</b></td>
	</tr>

	<tr>
		<td align="center" width="5%">1</td>
		<td align="center" width="30%">Is any of the Promoter(s)/Directors/Key management personnel in the CRILC/CIBIL/RBI list of defaulters ?</td>
		
<td align="center" width="60%">
	<div id="top">
	<table width="100%" align="center" cellpadding="2" cellspacing="0" border="0" >
	 <% if(arrRowDefault!=null&&arrRowDefault.size()>0)
	{%>
	 
	
	<tr>
	<td align="center" width="50%">Name</td>
	<td align="center" width="50%">Defaulters List</td>
	</tr>
	<%
	String strPrevCusID="";
	strPrevCusID="";int j=0;
	for(int i=0;i<arrRowDefault.size();i++) {
		arrColDefault	= (ArrayList)arrRowDefault.get(i);
		
		if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColDefault.get(0))))
		{
			continue;
		}
		else
		{
			strPrevCusID = Helper.correctNull((String)arrColDefault.get(0));		
		}j=j+1;
	%>
	<tr>
	<td width="50%"><%=Helper.correctNull((String)arrColDefault.get(1))%></td>
	<td width="50%" align="center"><%=Helper.correctNull((String)arrColDefault.get(2))%></td>
	</tr>
	<%}}else{%>
	<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
	<%} %>
	</table>
	</div>
</td>
	</tr>
	
	
	
	
	
	
	
	
	<tr>
		<td align="center" width="5%">2</td>
		<td align="center" width="30%">Credit bureau score of key promoter & credit bureau name</td>
		<td align="center" width="60%">
<div id="top">
<table width="100%" align="center" cellpadding="2" cellspacing="0" border="0" >
 <% if(arrRowCIBIL!=null&&arrRowCIBIL.size()>0)
{%>

<tr>
	<td align="center" width="50%">Name</td>
	<td align="center" width="50%">CIBIL Refered</td>
</tr>
<%
String strPrevCusID="";int j=0;
for(int i=0;i<arrRowCIBIL.size();i++) {
	arrColCIBIL	= (ArrayList)arrRowCIBIL.get(i);
	if(strPrevCusID.equalsIgnoreCase(Helper.correctNull((String)arrColCIBIL.get(0))))
	{
		continue;
	}
	else
	{
		strPrevCusID = Helper.correctNull((String)arrColCIBIL.get(0));		
	}j=j+1;
%>
<tr>
	<td width="50%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(1))%></td>
	<td width="50%" align="center"><%=Helper.correctNull((String)arrColCIBIL.get(4))%></td>
</tr>
<%}}else{%>
<tr><td align="center" style="border:none;"><%=strNil%></td></tr>
<%} %>
</table>
</div>
</td>

	</tr>
		
		
		
		
		
		
		
		
	<tr>
		<td align="center" width="5%">2.1</td>
		<td align="center" width="30%">If there are multiple promoters, Credit bureau score of promoter 2 & credit bureau name</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">2.2</td>
		<td align="center" width="30%">If there are multiple promoters, Credit bureau score of promoter 3 & credit bureau name</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	
	<tr>
		<td align="center" width="5%">2.3</td>
		<td align="center" width="30%">If there are multiple promoters, Credit bureau score of promoter 4 & credit bureau name</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">2.4</td>
		<td align="center" width="30%" width="10%">If there are multiple promoters, Credit bureau score of promoter 5 & credit bureau name</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">3</td>
		<td align="center" width="30%">CIBIL MSME Rank of the firm (if available, else put NA)</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">4</td>
		<td align="center" width="30%">Experian Commercial score (if available, else put NA)</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">5</td>
		<td align="center" width="30%">Net worth of the key</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">6</td>
		<td align="center" width="30%">Promoter's contribution in the entity (in % terms)</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">7</td>
		<td align="center" width="30%">Group/associate entities of promoter(s) have been into NPA category in past 1 year</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	<tr>
		<td align="center" width="5%">8</td>
		<td align="center" width="30%">Promoter's experience in current/related business (in years)</td>
		<td align="center" width="60%">&nbsp;</td>
	</tr>
	
</table>



</body>
</html>