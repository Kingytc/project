<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	String eligible="";
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Eligibility</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frmchkeilg" method="post">
<br />
<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center">
<tr>
	<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="3">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="5">
						<tr class="tblhead">
							<td width="35%" align="center"><b>Eligibility Conditions</b></td>
							<td width="20%" align="center"><b>Required</b></td>
							<td width="20%" align="center"><b>Available</b></td>
							<td width="25%" align="center"><b>Status</b></td>
		                </tr>
		                <%
		                if(arrRow!=null&&arrRow.size()>0)
		                {
		                	for(int i=0;i<arrRow.size();i++)
		                	{
		                		arrCol=new ArrayList();
			                	arrCol=(ArrayList)arrRow.get(i);
			                	if(arrCol!=null&&arrCol.size()>0)
			                	{
			            %>
			            <tr>
				            <td><%=Helper.correctNull((String)arrCol.get(0))%></td>
				            <td><%=Helper.correctNull((String)arrCol.get(1))%></td>
				            <td><%=Helper.correctNull((String)arrCol.get(2))%></td>
				            <td align="center">
				            <%
				            if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Not Eligible")){
								eligible="Not eligible";
							%>
							<font color="red"><%=Helper.correctNull((String)arrCol.get(3))%></font>
							<%}
				            else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Eligible")){%>
							<font color="green"><%=Helper.correctNull((String)arrCol.get(3))%></font>
							<%}
							else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Deviated")){%>
							<font color="Royal Blue"><%=Helper.correctNull((String)arrCol.get(3))%></font>
							<%}
							else if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Relaxed")){%>
							<font color="Royal Blue"><%=Helper.correctNull((String)arrCol.get(3))%></font>
							<%}%>
							</td>
			            </tr>
			            <%
			                	}
		                	}
		                }
						if(eligible.equalsIgnoreCase("Not Eligible")){%>
						<tr>
							<td colspan="4" align="center"><b><font color="#FF0000" size="2px">Applicant is not Eligible</font></b></td>
						</tr>
						<%} else {%>
						<tr> 
							<td colspan="4" align="center"><b><font color="green" size="2px">Applicant is Eligible</font></b></td>
						</tr>
						<%}%>
						</table>
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<br>
</form>
</body>
</html>