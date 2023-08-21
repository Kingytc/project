<%@ include file="../share/directives.jsp"%>
<%
	ArrayList g1 = new ArrayList();
	String strFromLink = Helper.correctNull((String) request.getParameter("strfrom"));
	String strvalue = Helper.correctNull((String) hshValues.get("svalue"));
	ArrayList v = (ArrayList) hshValues.get("vecRow");
%>
<html>
<title>LAPS: Lawyer Master</title>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<SCRIPT LANGUAGE="JavaScript">	
var from_link = "<%=strFromLink%>";	
var appUrl="<%=ApplicationParams.getAppUrl()%>";
	
function onselect1()
	{
	if (document.forms[0].selradio[0].checked==true)
		{
		document.forms[0].stype.value = document.forms[0].selradio[0].value
		}		
	document.forms[0].txt_ser.disabled = false
	document.forms[0].txt_ser.focus();		
	}
	
function searchData()
{
	if(trim(document.forms[0].txt_ser.value)=="")
	{
		ShowAlert(121,'Name');
		document.forms[0].txt_ser.focus();
		return;
	}	
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidAction.value="search";
	document.forms[0].hidBeanGetMethod.value="getLawyerMaster_legal";
	document.forms[0].stype.value ="N"; 
	document.forms[0].svalue.value = document.forms[0].txt_ser.value.toUpperCase(); 
	
	document.forms[0].action=appUrl+"action/lawyermaster_retail.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function getSelectedValue(val1, val2, val3,val4)
{
	if(val3=="Y")
	{
		alert(val1 +" is Blacked List");
		window.opener.document.forms[0].hid_sno.value = "";
		window.opener.document.forms[0].txt_nameofadviser.value= "";
		window.opener.document.forms[0].sel_elitepanel_leg.value="S";
		return;
	}
	else
	{	
		if(from_link=="legal1")
		{
			window.opener.document.forms[0].hid_legalauditorsno.value = val2;
			window.opener.document.forms[0].txt_legalauditor.value=val1;
		}	
		else
		{	
			window.opener.document.forms[0].hid_sno.value = val2;
			window.opener.document.forms[0].txt_nameofadviser.value=val1;
			if(val4==""){
			  window.opener.document.forms[0].sel_elitepanel_leg.value="S";
			 
			}
			else{
				 window.opener.document.forms[0].sel_elitepanel_leg.value=val4;
				 
			}
		}
		window.close();
	}
	if(from_link=="legal")
	{
		window.opener.govtValuerCheck();
	}	
}
function doClose()
{
	window.close();
}
</SCRIPT>
</head>
<body >
<form name="productlisthelp" method="post" class="normal">
<div>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td><br>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr>
				<td><b>Search </b>
				<table border="0" cellspacing="0" cellpadding="3" width="100%" align="center" class="outertable">
					<tr>
						<td width="30%">Lawyer Name
						<td width="30%"><input type="text" name="txt_ser" maxlength="40"
							size="40" value="<%=strvalue%>" tabindex="1"
							onKeyPress="notAllowSplChar()"></td>
						<td width="40%" align="center"><input type=button
							class="buttonStyle" value="Search" name="search" tabindex="2"
							onClick="searchData()"></td>
					</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
				class="outertable">
					<tr>
						<td>
						<table width="97%" border="0" cellspacing="1" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
								<td width="15%"><b>Sl. No.</b></td>
								<td width="85%"><b>Lawyer Name </b></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<%
				if(v.size()>6){ %><div class="cellContainer"><%} %>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%
			String inside = "N";
			int i=0;
			if (v != null) 
			{
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) 
				{
					inside = "Y";
					g1 = (ArrayList) v.get(l);%>
					<tr valign="top" class="datagrid">
						<td width="15%" align="left"><%=l + 1%>&nbsp;</td>
						<td width="85%" align="left"><a
					href="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>',
		            '<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)g1.get(1)))%>',
		            '<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>')" align="center"><b><%=Helper.correctNull((String) g1.get(0))%></b></a></td>
					</tr>
					<%
				}
			}
			%>
					<tr class="datagrid">
						<td width="15%">&nbsp;</td>
						<td width="85%">&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr >

					<%if (inside.equals("N")) {

			%>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr valign="top" class="datagrid">
						<td colspan="2" width="15%" align="center"><b>No Data Found </b>
					</tr>

					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr >
					<tr class="datagrid">
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<%}%>
				</table>
				<%if(v.size()>6){ %></div><%} %>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew 
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</div>
<input type="hidden" name="svalue" value="<%=Helper.correctNull((String)hshValues.get("svalue"))%>"> 
<input type="hidden" name="stype" value="<%=Helper.correctNull((String)hshValues.get("scode"))%>"> 
<input type="hidden" name="strfrom" value="<%=strFromLink%>"> 
<input type="hidden" name="org_name" value="<%=session.getAttribute("strOrgName")%>"> 
<input type="hidden" name="org_code" value="<%=session.getAttribute("strOrgCode")%>">
<input type="hidden" name="namevalue" value="<%=session.getAttribute("strnamevalue")%>">
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>

