<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<lapschoice:handleerror />
<%
	
				ArrayList arrRow	=	new ArrayList();
				ArrayList arrCol	=	new ArrayList();
				arrRow	=	(ArrayList)hshValues.get("arrRow");
				int iarrLength	=0;
				if(arrRow!=null && arrRow.size()>0)
				{
					iarrLength= arrRow.size();
				}
				String strgridrowno = Helper.correctNull((String)hshValues.get("strgridrowno"));
				String strPerappEmployment=Helper.correctNull(Helper.correctInt((String)hshValues.get("strPerappEmployment")));
				String parentCbsId=Helper.correctNull((String)hshValues.get("PERAPP_CBSID"));
				String strSearchtxt=Helper.correctNull((String)hshValues.get("strSearchText"));
				//out.print("strSearchtxt::::::::::::"+strSearchtxt);
				//out.print("parentCbsId::::::::::::"+parentCbsId);
%>
<html>
<script> 
var varPerappEmployment="<%=strPerappEmployment%>";
var varparentCbsId="<%=parentCbsId%>";
var varSearchtxt="<%=strSearchtxt%>";
function loadvalues()
{
	<%if(iarrLength>0)
	{
			for(int i=0;i<iarrLength;i++)
			{
				arrCol	=	(ArrayList) arrRow.get(i);	
				%>
				parent.frames.document.forms[0].hidmapflag.value = "1"; //if CBS id is there in CBS
				parent.frames.document.forms[0].btnmap[<%=strgridrowno%>].disabled=false;		

				parent.frames.document.forms[0].hidcbsID.value = <%=Helper.correctNull((String)arrCol.get(0))%>;
				parent.frames.document.forms[0].hidAppid.value = <%=Helper.correctNull((String)arrCol.get(1))%>;
		<%	}
	} else 
	{ %>
			parent.frames.document.forms[0].hidmapflag.value = "2";  //if CBS id is not in CBS
	<% } %>
	parent.frames.document.forms[0].hidPerappEmployment.value = varPerappEmployment;
	parent.frames.document.forms[0].hidPercustid.value = varSearchtxt;
	//parent.frames.document.forms[0].hidSearchtxt.value = varSearchtxt;
}
function callcust(){

	parent.frames.document.all.cmdcust.style.visibility="visible";
	parent.frames.document.all.cmdcust.style.position="relative";
}
</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<head>
<title></title>



</head>
<body onload="loadvalues()"> 
	<table width="100%" border="0" cellpadding="1" cellspacing="2" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
	<tr  class="dataheader">
					<td align="center" width="15%">&nbsp; CBS ID</td>
					<td align="center" width="15%">&nbsp; LAPS ID</td>
					<td align="center" width="15%">&nbsp; Name</td>
					<td align="center" width="15%">&nbsp; PAN NUM</td> 
					<td align="center" width="15%">&nbsp; Address</td> 
					<td align="center" width="15%">&nbsp; Phone Num</td> 
					<td align="center" width="15%">&nbsp; Profile Status</td> 
					
	</tr>
	<%if(iarrLength>0)
	{
			for(int i=0;i<iarrLength;i++)
			{
				arrCol	=	(ArrayList) arrRow.get(i);
	
		%>
			<tr  class="datagrid">
					<td align="center" width="15%">	<%=Helper.correctNull((String)arrCol.get(0))%></td>
					<td align="center" width="15%">	<%=Helper.correctNull((String)arrCol.get(1))%></td>
					<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(2))%></td>
					<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(3))%></td>
					<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(4))%></td>	
					<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(5))%></td>
					<td align="center" width="15%"> <%=Helper.correctNull((String)arrCol.get(6))%></td>	
			</tr>
			 
		<%	}
	}
	else
	{
		%>
		<tr  class="dataGridColor" >
			<td  colspan="6" align="center" >&nbsp;Please complete the customer profile before mapping the CBS ID->Click on Customer profile button </td>
		</tr>
	<%} %>
		<tr>
			<td>
		
			</td>
		</tr>
	</table>
</body>
</html>