<%@ include file="../share/directives.jsp"%>
<%
ArrayList arrValues = new ArrayList();
if (hshValues != null)
{
	arrValues = (ArrayList) hshValues.get("arrRow");
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Activity List</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/mis/set_misactivity.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varAction="<%=Helper.correctNull((String)request.getParameter("hidActionType"))%>";
function doSearch()
{
	if(document.forms[0].rad_category[0].checked)
	{
		varCategory=1;
	}
	else if (document.forms[0].rad_category[1].checked)
	{
		varCategory=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	var txtval=document.forms[0].txt_Activity.value;
	var txtlen=txtval.length;
	if (varCategory==2)
	{
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
		     document.forms[0].txt_Activity.focus();
		     return;
	 	 }
	}
	else if(txtval=="")
	{
		 alert("Enter Value to Search");
	     document.forms[0].txt_Activity.focus();
	     return;
	}
	document.forms[0].master.value="master";
	document.forms[0].method="post";
	document.forms[0].hidCategory.value=varCategory;
	document.forms[0].hidBeanGetMethod.value="getMISActivityCodeDetails";
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].action=appURL+"action/mis_classification_activity.jsp";	
	document.forms[0].submit();
}
function doSelect()
{
	document.forms[0].txt_Activity.value="";
	document.forms[0].txt_Activity.focus();
}
function setValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val12)
{
	window.opener.document.forms[0].hidSlNo.value=val0;
	window.opener.document.forms[0].txt_ActivityCode.value=val4;
	if(varAction!="insert")
	{
		window.opener.document.forms[0].method="post";
		window.opener.document.forms[0].hidBeanGetMethod.value="getMisClassification";
		window.opener.document.forms[0].hidBeanId.value="mis";
		window.opener.document.forms[0].action=appURL+"action/mis_classification_master.jsp";	
		window.opener.document.forms[0].submit();
	}
	window.close();
}
function setSubActCode(val2)
{
	var subactcode=val2;
	window.opener.document.all.ifrm.src=appURL+"action/iframemainactcode.jsp?hidBeanGetMethod=getMainActCode&hidBeanId=mis&strMainActCode="
	+window.opener.document.forms[0].sel_MainActivity.value+"&subactcode="+subactcode;
}
function doClose()
{
	window.close();
}
</script>
<STYLE>
div.cellContainer
{	
  width: 100%; height: 200;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="misactlist" method="post" class="normal">
<br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="3" cellpadding="3" class="outertable" align="center">
						<tr>
							<td>
								<input type="radio" name="rad_category" value="1" onClick="doSelect()" style="border-style:none">
							</td>
							<td><b>Activity Code</b></td>
							<td>
								<input type="radio" name="rad_category" value="2" onClick="doSelect()" style="border-style:none">
							</td>
							<td><b>Purpose</b></td>
							<td>
								<input type="text" name="txt_Activity" size="20" maxlength="25" value="" onKeyPress="notAllowSplChar()">
							</td>
							<td>
								<input type="button" name="cmdsearch" value="Search" class="buttonStyle" onClick="doSearch()">
							</td>
						</tr>
					</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
								<tr class="dataheader">
									<td width="40%" align="center"><b>Activity Code</b></td>
									<td width="60%" align="center"><b>Purpose</b></td>
								</tr>
								<tr>
									<td colspan="2">
									<div class="cellcontainer">
										<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
										<%
										if (arrValues != null)
										{
											int arrSize = arrValues.size();
											ArrayList arrCol = new ArrayList();
											for (int i = 0; i < arrSize; i++)
											{
												arrCol = new ArrayList();
												arrCol = (ArrayList) arrValues.get(i);
										%>
										<tr class="datagrid">
											<td width="40%">&nbsp;
												<a href="javascript:setValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
														'<%=Helper.correctNull((String)arrCol.get(1))%>',
														'<%=Helper.correctNull((String)arrCol.get(2))%>',
														'<%=Helper.correctNull((String)arrCol.get(3))%>',
														'<%=Helper.correctNull((String)arrCol.get(4))%>',
														'<%=Helper.correctNull((String)arrCol.get(5))%>',
														'<%=Helper.correctNull((String)arrCol.get(6))%>',
														'<%=Helper.correctNull((String)arrCol.get(7))%>',
														'<%=Helper.correctNull((String)arrCol.get(8))%>',
														'<%=Helper.correctNull((String)arrCol.get(9))%>',
														'<%=Helper.correctNull((String)arrCol.get(12))%>')"><%=Helper.correctNull((String) arrCol.get(4))%>
												</a>
											</td>
											<td width="60%">&nbsp;
												<a href="javascript:setValues('<%=Helper.correctNull((String)arrCol.get(0))%>',
														'<%=Helper.correctNull((String)arrCol.get(1))%>',
														'<%=Helper.correctNull((String)arrCol.get(2))%>',
														'<%=Helper.correctNull((String)arrCol.get(3))%>',
														'<%=Helper.correctNull((String)arrCol.get(4))%>',
														'<%=Helper.correctNull((String)arrCol.get(5))%>',
														'<%=Helper.correctNull((String)arrCol.get(6))%>',
														'<%=Helper.correctNull((String)arrCol.get(7))%>',
														'<%=Helper.correctNull((String)arrCol.get(8))%>',
														'<%=Helper.correctNull((String)arrCol.get(9))%>',
														'<%=Helper.correctNull((String)arrCol.get(12))%>')"><%=Helper.correctNull((String) arrCol.get(13))%>
												</a>
											</td>
										</tr>
											<%}
		
											}
											%>
										</table>
									</div>
									</td>
								</tr>
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
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCategory">
<input type="hidden" name="master">
<input type="hidden" name="hidActionType" value="<%=Helper.correctNull((String)request.getParameter("hidActionType"))%>">
</form>
</body>
</html>