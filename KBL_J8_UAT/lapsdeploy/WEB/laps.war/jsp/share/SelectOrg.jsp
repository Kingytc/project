<%@include file="../share/directives.jsp"%>
<%

String strglp_orgname1 = "";
String strglp_orgname2 = "";
String strglp_orgname3 = "";
String strorgcode1 = "";
String strorgcode2 = "";
String strorgcode3 = "";
String strorgcode4 = "";
String strorgcode = "";
String strLevels = "",strStatus="";
String strorgcodenew1="",strorgcodenew2="",strorgcodenew3="",strOrgCodeOld="",strOrgCodeNew="";

HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
HashMap hshLevels = (HashMap) hshValues.get("hshLevels");

if(hshRecord==null && hshLevels==null)
{
	strglp_orgname1=Helper.correctNull((String)request.getParameter("glp_orgname1"));
	strglp_orgname2=Helper.correctNull((String)request.getParameter("glp_orgname2"));
	strglp_orgname3=Helper.correctNull((String)request.getParameter("glp_orgname3"));
	strorgcode1 = Helper.correctNull((String) request.getParameter("strorgcode1")).trim();
	strorgcode2 = Helper.correctNull((String) request.getParameter("strorgcode2")).trim();
	strorgcode3 = Helper.correctNull((String) request.getParameter("strorgcode3")).trim();
	strorgcode4 = Helper.correctNull((String) request.getParameter("strorgcode4")).trim();
	strorgcodenew1 = Helper.correctNull((String) request.getParameter("strorgcode1")).trim();
	strorgcodenew2 = Helper.correctNull((String)request.getParameter("strorgcode2")).trim();
	strorgcodenew3 = Helper.correctNull((String) request.getParameter("strorgcode3")).trim();
	strOrgCodeOld= Helper.correctNull((String) request.getParameter("hidOrgCode")).trim();
	strOrgCodeNew= Helper.correctNull((String) request.getParameter("hidOrgCode")).trim();
}else{
	strglp_orgname1=Helper.correctNull((String)hshLevels.get("glp_orgname1"));
	strglp_orgname2=Helper.correctNull((String)hshLevels.get("glp_orgname2"));
	strglp_orgname3=Helper.correctNull((String)hshLevels.get("glp_orgname3"));
	strorgcode1 = Helper.correctNull((String) hshRecord.get("strorgcode1")).trim();
	strorgcode2 = Helper.correctNull((String)hshRecord.get("strorgcode2")).trim();
	strorgcode3 = Helper.correctNull((String) hshRecord.get("strorgcode3")).trim();
	strorgcodenew1 = Helper.correctNull((String) hshRecord.get("strorgcode1")).trim();
	strorgcodenew2 = Helper.correctNull((String)hshRecord.get("strorgcode2")).trim();
	strorgcodenew3 = Helper.correctNull((String) hshRecord.get("strorgcode3")).trim();
	strOrgCodeOld=Helper.correctNull((String) hshValues.get("hidOrgCode"));
	strOrgCodeNew=Helper.correctNull((String) hshRecord.get("txtorg_code"));
	strStatus=Helper.correctNull((String) hshValues.get("Status"));
}
strorgcode = "001000000000000";
if (strglp_orgname1 != "") {
	if (!strorgcode1.equals("")) {
		strorgcode1 = strorgcode1.substring(0, 3);
	}
}
if (strglp_orgname2 != "") {
	if (!strorgcode2.equals("")) {
		strorgcode2 = strorgcode2.substring(0, 6);
	}
}
if (strglp_orgname3 != "") {
	if (!strorgcode3.equals("")) {
		strorgcode3 = strorgcode3.substring(0, 9);
	}
}

%>
<html>
<head>
<title>Organisation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
</style>
<script type="text/javascript">
var varglp_orgname1= "<%=strglp_orgname1%>";
var varglp_orgname2= "<%=strglp_orgname2%>";
var varglp_orgname3= "<%=strglp_orgname3%>";
varstrorgcode1="<%=strorgcodenew1%>";
var varstrorgcode2 = "<%=strorgcodenew2%>";
var varstrorgcode3 = "<%=strorgcodenew3%>";
var varStatus="<%=strStatus%>";
var appurl = "<%=ApplicationParams.getAppUrl()%>";
function submitHelp1()
{
	var varorghelp1 = document.forms[0].setorghelp1.value;
	document.forms[0].hidsetorghelp1.value = varorghelp1;
	document.forms[0].hidsetorghelpvalue1.value = varorghelp1;
	document.forms[0].hidBeanId.value="setorg";
	document.forms[0].hidBeanGetMethod.value="getData";	
	document.forms[0].action=appURL+"action/SelectOrg.jsp";
	document.forms[0].submit();
}

function submitHelp2()
{
	if(varglp_orgname2 != "")
	{
		var varorghelp2 = document.forms[0].setorghelp2.value;
		if(varorghelp2 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelp2.value = varorghelp2;
			document.forms[0].hidsetorghelpvalue2.value = varorghelp2;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/SelectOrg.jsp";
			document.forms[0].submit();
		}
		else
		{
			if(varglp_orgname3 != "")
			{
				document.forms[0].setorghelp3.value ="";
				document.forms[0].setorghelp3.disabled = true;
			}
			if(varglp_orgname4 != "")
			{
				document.forms[0].setorghelp4.value ="";
				document.forms[0].setorghelp4.disabled = true;
			}
			if(varglp_orgname5 != "")
			{
				document.forms[0].setorghelp5.value ="";
				document.forms[0].setorghelp5.disabled = true;
			}
		}
	}
}

function submitHelp3()
{
	if(varglp_orgname3 != "")
	{
		var varorghelp3 = document.forms[0].setorghelp3.value;
		if(varorghelp3 != "")
		{
			document.forms[0].hidsetorghelp1.value = document.forms[0].setorghelp1.value;
			document.forms[0].hidsetorghelp2.value = document.forms[0].setorghelp2.value;
			document.forms[0].hidsetorghelpvalue1.value = "";
			document.forms[0].hidsetorghelpvalue2.value = "";
			document.forms[0].hidsetorghelp3.value = varorghelp3;
			document.forms[0].hidsetorghelpvalue3.value = varorghelp3;
			document.forms[0].hidBeanId.value="setorg";
			document.forms[0].hidBeanGetMethod.value="getData";	
			document.forms[0].action=appURL+"action/SelectOrg.jsp";
			document.forms[0].submit();
		}
	}
}

function doClose()
{
	window.close();
}
function placevalues()
{
	if(varStatus=="Success")
	{
		alert("The Organisation Moved Successfully");
		window.close();
		window.opener.document.forms[0].action=appURL+"action/setorg.jsp";
		window.opener.document.forms[0].submit();
	}	
	document.forms[0].setorghelp1.value = varstrorgcode1;
	document.forms[0].setorghelp2.value = varstrorgcode2;
	if(varglp_orgname3 != "")
	{
		if(varstrorgcode3 == "")
		{
			document.forms[0].setorghelp3.value = "";
		}
		else
		{
			document.forms[0].setorghelp3.value = varstrorgcode3;
		}
	}
}
function doMove()
{
	if(document.forms[0].setorghelp1.value=="")
	{
		ShowAlert(111,"Head Office");
		document.forms[0].setorghelp1.focus();
		return;
	}
	else if(document.forms[0].setorghelp2.value=="")
	{
		ShowAlert(111,"Regional Office");
		document.forms[0].setorghelp2.focus();
		return;
	}
	else if(document.forms[0].setorghelp3.value=="")
	{
		ShowAlert(111,"CLPU");
		document.forms[0].setorghelp3.focus();
		return;
	}
	document.forms[0].hidAction.value="Move";
	document.forms[0].hidBeanId.value="setorg";
	document.forms[0].hidBeanGetMethod.value="getData";	
	document.forms[0].hidBeanMethod.value="updateMoveOrganisation";	
	document.forms[0].hidSourceUrl.value="/action/SelectOrg.jsp";
	document.forms[0].action=appurl+"controllerservlet";
	document.forms[0].submit();
}
</script>
</head>
<body onload="placevalues()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
<tr class="dataheader"><td align="center">Select Organisattion</td></tr>
<tr>
<td align="center">
<table width="100%" border="1px" cellspacing="0" cellpadding="0"
							class="outertable" align="center">
							<tr>
								<td valign="top">
								<table width="80%" border="0" cellspacing="0" cellpadding="2"
									align="center" class="outertable">
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname1%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp1" onClick="submitHelp1()"
											style="width: 180">
											<%
												String s = strorgcode + "^C";
											%>
											<lapschoice:choiceOrg value='<%=s%>' />
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td align="center"></td>
									</tr>
									<tr>
										<td><b><%=strglp_orgname2%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp2" onChange="submitHelp2()"
											style="width: 180">
											<option value="" selected>----Select----</option>
											<%
												String s1 = strorgcode1 + "^R";
											%>
											<lapschoice:choiceOrg value='<%=s1%>' />
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<tr>
										<td align="center"></td>
									</tr>
									<%
										if (!strglp_orgname3.equals("")) {
									%>
									<tr>
										<td><b><%=strglp_orgname3%></b></td>
									</tr>
									<tr>
										<td><select name="setorghelp3" onChange="submitHelp3()"
											style="width: 180">
											<option value="">----Select----</option>
											<%
												String s2 = strorgcode2 + "^D";
											%>
											<lapschoice:choiceOrg value='<%=s2%>'/>
										</select></td>
									</tr>
									<tr>
										<td align="center">&nbsp;</td>
									</tr>
									<%
										}
									%>
								</table>
								</td>
							</tr>
						</table>
		</td>
		</tr>
		<tr>
			<td>
			<lapschoice:combuttonnew  btnnames='Move' btnenable="Y" />
			</td>
		</tr>
	</table>
<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidAction" value="">  
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidsetorghelp1" value=""> 
<input type="hidden" name="hidsetorghelpvalue1" value=""> 
<input type="hidden" name="hidsetorghelp2" value=""> 
<input type="hidden" name="hidsetorghelpvalue2" value=""> 
<input type="hidden" name="hidsetorghelp3" value=""> 
<input type="hidden" name="hidsetorghelpvalue3" value=""> 
<input type="hidden" name="hidOrgCode" value="<%=strOrgCodeOld %>">
<input type="hidden" name="hidOrgCodeNew" value="<%=strOrgCodeNew %>">
<input type="hidden" name="hidOrgLevel" value="D">
<input type="hidden" name="hidSourceUrl" value=""> 
</form>
</body>
</html>
