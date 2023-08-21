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
	String prd_type = Helper.correctNull((String) request.getParameter("prd_type"));
	String comappid = Helper.correctNull((String) request.getParameter("comappid"));
	String appno = Helper.correctNull((String) request.getParameter("appno"));
	String prdcode = Helper.correctNull((String) request.getParameter("prdcode"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Check Eligibility</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
function doPrint()
{
	var prd_type="<%=prd_type%>";
	var appno = "<%=appno%>";
	var prdcode="<%=prdcode%>";
	var comappid ="<%=comappid%>";
	var	varQryString = appURL+"action/checkeligibilityprint.jsp?hidBeanGetMethod=getEligibility&hidBeanId=checkeligibility&appno="+appno+"&prd_type="+prd_type+"&prdcode="+prdcode+"&comappid="+comappid;
	var title = "Check_Eligibility_Print";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = (screen.width - 810) / 2;
	var ypos = (screen.height - 668) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
function doClose(){
	if(ConfirmMsg('100'))
	{
		window.close();
	}
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="frmchkeilg" method="post" class="normal">
<br />
&nbsp;<b><i>Check Eligibility</i></b>
<br />
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
						<tr class="dataheader">
							<td width="35%" align="center"><b>Eligibility Conditions</b></td>
							<td width="20%" align="center"><b>Scheme Guidelines</b></td>
							<td width="20%" align="center"><b>As per proposal</b></td>
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
			            <tr class="datagrid">
				            <td><%=Helper.correctNull((String)arrCol.get(0))%></td>
				            <td><%=Helper.correctNull((String)arrCol.get(1))%></td>
				            <td><%=Helper.correctNull((String)arrCol.get(2))%></td>
				            <td align="center">
				            <%
				            if(Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("Not Eligible")){
								eligible="Not eligible";
							%>
							<font color="red">Deviation</font>
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
						<tr class="datagrid">
							<td colspan="4" align="center"><b><font color="#FF0000" size="2px">Applicant is not Eligible</font></b></td>
						</tr>
						<%} else {%>
						<tr class="datagrid"> 
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
<table border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
<tr align="center">
	<td>
		<table border="0" cellspacing="0" cellpadding="1" class="outertable border1" align="center">
		<tr>
			<td>
				<table border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
				<tr>
					<td id="tdprint" align="center"><input type="button" name="cmdprint"
						value="Print" onClick="doPrint()" class="buttonOthers"></td>
					<td align="center"><input type="button" name="cmdclose"
						value="Close" onClick="doClose()" class="buttonClose"></td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
</form>
</body>
</html>