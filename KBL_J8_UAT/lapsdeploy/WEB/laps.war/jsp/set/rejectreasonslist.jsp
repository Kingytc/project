<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%ArrayList g1 = new ArrayList();
String strFromLink = Helper.correctNull((String) request.getParameter("strfrom"));
String strvalue = Helper.correctNull((String) hshValues.get("svalue"));
String appno = Helper.correctNull((String) request.getParameter("appno"));



%>

<html>
<title>LAPS: Reject Reasons List</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";

function callapply()
{   
	buildString(document.forms[0].hidvecsize.value);
	window.opener.document.forms[0].txt_usrid.value=document.forms[0].txt_usrid.value;
    document.forms[0].hidAction.value="apply";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateReject";
	document.forms[0].hidBeanGetMethod.value="getRejectReasonMasterList";	
	document.forms[0].hidSourceUrl.value="/action/rejectreasonslist.jsp";	
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	
	window.close();
}

function buildString(val1)
{
	document.forms[0].txt_usrid.value = "";	
	for(var i = 0; i <= val1 - 1; i++)
	{
		if(val1==1)
		{
			if(document.forms[0].chkbox.checked == true)
			{
				document.forms[0].txt_usrid.value = document.forms[0].chkbox.value;
			}
		}
		else
		{
			if(document.forms[0].chkbox[i].checked == true)
			{
				 	if(document.forms[0].txt_usrid.value!="")
					{
						document.forms[0].txt_usrid.value = document.forms[0].txt_usrid.value + "," + document.forms[0].chkbox[i].value;
					}
					else
					{
						document.forms[0].txt_usrid.value =document.forms[0].chkbox[i].value;
					}
			}
		}
	}
		
}
function getSelectedValue(val1, val2)
{	
	if(from_link == "RejectMaster")
	{
		window.opener.document.forms[0].hidsno.value = val1;
		window.opener.document.forms[0].txttrmcontent.value=val2;	
		window.close();
	}
}
	
	
</SCRIPT>
</head>
<body class="bgcolor">
<form name="productlisthelp" method="post" class="normal"><br>
<table width="95%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="97%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr class="dataheader">
						<td width="15%"><b></b></td>
						<td width="85%"><b>Rejection List</b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<div class="cellcontainer">
		<table width="100%" border="0" cellspacing="1" cellpadding="3">
			<%ArrayList v = (ArrayList) hshValues.get("vecRow");
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				//System.out.println("+++++++++++++++++++" + vecsize);
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
			<tr valign="top" class="datagrid">
				<td width="15%" align="left"><!-- <%=l + 1%> -->
				   <input type="hidden" name="txt_val" size="10" value="<%=Helper.correctNull((String)g1.get(1))%>">
				<input type="checkbox" name="chkbox"  value="<%=Helper.correctNull((String)g1.get(0))%>"   style="border:none">
							&nbsp;</td>
				 <td width="85%" align="left"><a
					href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>')"
					class="blackfont" align="center"><b><%=Helper.correctNull((String) g1
											.get(1))%></b></a></td>
			</tr>
			<%}
			}

			%>
			<tr>
				<td width="15%">&nbsp;</td>
				<td width="85%">&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
		</table>
		</div>
		</td>
	</tr>
</table>
<br>

<table width="10%" border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr valign="top">
	<td width="20%"><input type="button" name="cmdapply" value="Save"
					class="buttonStyle"
					onClick="callapply()"></td>
		<td width="20%"><input type=button
			class="buttonClose"
			value="Close" name="closebtn" tabindex="25" onClick=window.close()></td>
	</tr>
</table>
<br>
<br>
<br>
<br>
<br>
<input type="hidden" name="svalue"
	value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>"> <input
	type="hidden" name="stype"
	value="<%=Helper.correctNull((String)hshValues.get("scode"))%>"> <input
	type="hidden" name="strfrom" value="<%=strFromLink%>"> <input
	type="hidden" name="hidBeanId">
	 <input type="hidden" name="hidSourceUrl" >
	<input
	type="hidden" name="hidBeanMethod"> <input type="hidden"
	name="hidBeanGetMethod"> <input type="hidden" name="org_name"
	value="<%=session.getAttribute("strOrgName")%>"> <input type="hidden"
	name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
	<input type="hidden" name="txt_usrid" >
	<input type="hidden" name="hidAction" >
	<input type="hidden" name="appno"
	value="<%=appno%>">
	<input type="hidden" name="hidvecsize" value="<%=v.size() %>">
	</form>
</body>
</html>

