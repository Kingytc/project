<%@ include file="../share/directives.jsp"%>
<%
ArrayList arrValues = new ArrayList();
if (hshValues != null)
{
	arrValues = (ArrayList) hshValues.get("arrRow");
}
String strPage=Helper.correctNull((String)request.getParameter("master"));
String strLoanType=Helper.correctNull((String)request.getParameter("LoanType"));
String strCorpProductCode=Helper.correctNull((String)request.getParameter("CorpProdCode"));
String appno=Helper.correctNull((String)request.getParameter("strAppNo"));
String FacilitySno=Helper.correctNull((String)request.getParameter("FacilitySno"));
if(strLoanType.equalsIgnoreCase(""))
{
	strLoanType=Helper.correctNull((String)hshValues.get("strLoanType"));
}
if(strCorpProductCode.equalsIgnoreCase(""))
{
	strCorpProductCode=Helper.correctNull((String)hshValues.get("strCorpProductCode"));
}
if(appno.equalsIgnoreCase(""))
{
	appno=Helper.correctNull((String)hshValues.get("appno"));
}
if(FacilitySno.equalsIgnoreCase(""))
{
	FacilitySno=Helper.correctNull((String)hshValues.get("FacilitySno"));
}
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>MIS Activity List</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/mis/set_misactivity.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varPage="<%=strPage%>";
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
	document.forms[0].method="post";
	document.forms[0].hidCategory.value=varCategory;
	document.forms[0].hidBeanGetMethod.value="alliedgetMISActivityCodeDetails";
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].action=appURL+"action/allied_set_misactivityhelp.jsp";	
	document.forms[0].submit();
}
function doSelect()
{
	document.forms[0].txt_Activity.value="";
	document.forms[0].txt_Activity.focus();
}
function setValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val12,val14,val17,val18,val19,val20,val21,val22,val23)
{
	
		window.opener.document.forms[0].allied_sel_MainActivity.value=val1+"-"+val12;
		window.opener.document.forms[0].txt_allied_ActivityCode.value=val4;
		window.opener.document.forms[0].allied_sel_SubActivity.value=val2+"-"+val14;
		window.opener.document.forms[0].allied_sel_Purpose.value=val3+"-"+val17;
		
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
									<td width="15%" align="center"><b>Activity Code</b></td>
									<td width="30%" align="center"><b>Main Activity</b></td>
									<td width="30%" align="center"><b>Sub Activity</b></td>
									<td width="25%" align="center"><b>Purpose</b></td>
								</tr>
								<tr>
									<td colspan="4">
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
											<td width="15%">&nbsp;
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
														'<%=Helper.correctNull((String)arrCol.get(15))%>',
														'<%=Helper.correctNull((String)arrCol.get(16))%>',
														'<%=Helper.correctNull((String)arrCol.get(13))%>',
														'<%=Helper.correctNull((String)arrCol.get(18))%>',
														'<%=Helper.correctNull((String)arrCol.get(19))%>',
														'<%=Helper.correctNull((String)arrCol.get(20))%>',
														'<%=Helper.correctNull((String)arrCol.get(21))%>',
														'<%=Helper.correctNull((String)arrCol.get(22))%>',
														'<%=Helper.correctNull((String)arrCol.get(23))%>')"><%=Helper.correctNull((String) arrCol.get(4))%>
												</a>
											</td>
											<td width="30%">&nbsp;
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
														'<%=Helper.correctNull((String)arrCol.get(15))%>',
														'<%=Helper.correctNull((String)arrCol.get(16))%>',
														'<%=Helper.correctNull((String)arrCol.get(13))%>',
														'<%=Helper.correctNull((String)arrCol.get(18))%>',
														'<%=Helper.correctNull((String)arrCol.get(19))%>',
														'<%=Helper.correctNull((String)arrCol.get(20))%>',
														'<%=Helper.correctNull((String)arrCol.get(21))%>',
														'<%=Helper.correctNull((String)arrCol.get(22))%>',
														'<%=Helper.correctNull((String)arrCol.get(23))%>')"><%=Helper.correctNull((String) arrCol.get(15))%>
												</a>
											</td>
											<td width="30%">&nbsp;
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
														'<%=Helper.correctNull((String)arrCol.get(15))%>',
														'<%=Helper.correctNull((String)arrCol.get(16))%>',
														'<%=Helper.correctNull((String)arrCol.get(13))%>',
														'<%=Helper.correctNull((String)arrCol.get(18))%>',
														'<%=Helper.correctNull((String)arrCol.get(19))%>',
														'<%=Helper.correctNull((String)arrCol.get(20))%>',
														'<%=Helper.correctNull((String)arrCol.get(21))%>',
														'<%=Helper.correctNull((String)arrCol.get(22))%>',
														'<%=Helper.correctNull((String)arrCol.get(23))%>')"><%=Helper.correctNull((String) arrCol.get(16))%>
												</a>
											</td>
											<td width="25%">&nbsp;
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
														'<%=Helper.correctNull((String)arrCol.get(15))%>',
														'<%=Helper.correctNull((String)arrCol.get(16))%>',
														'<%=Helper.correctNull((String)arrCol.get(13))%>',
														'<%=Helper.correctNull((String)arrCol.get(18))%>',
														'<%=Helper.correctNull((String)arrCol.get(19))%>',
														'<%=Helper.correctNull((String)arrCol.get(20))%>',
														'<%=Helper.correctNull((String)arrCol.get(21))%>',
														'<%=Helper.correctNull((String)arrCol.get(22))%>',
														'<%=Helper.correctNull((String)arrCol.get(23))%>')"><%=Helper.correctNull((String) arrCol.get(13))%>
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
<input type="hidden" name="master" value="<%=Helper.correctNull((String)request.getParameter("master"))%>">
<input type="hidden" name="strLoanType" value="<%=strLoanType %>">
<input type="hidden" name="strCorpProductCode" value="<%=strCorpProductCode%>">
<input type="hidden" name="strappno" value="<%=appno%>">
<input type="hidden" name="facilitySno" value="<%=FacilitySno %>">
</form>
</body>
</html>