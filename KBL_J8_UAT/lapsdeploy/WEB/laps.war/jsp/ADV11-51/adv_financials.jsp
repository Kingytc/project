<%@include file="../share/directives.jsp"%>
<%String appno = Helper.correctNull((String) request.getParameter("appno"));
			if (appno.equalsIgnoreCase("")) {
				appno = Helper.correctNull((String) hshValues.get("appno"));
			}
			ArrayList arrRow = new ArrayList();
			String strDesc = Helper.correctNull((String) request.getParameter("pageval"));%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callAssess(page,flowtype)
{		
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDataFinancials";	
	document.forms[0].submit();	 
}

function callLink(page,bean,method)
{
	if (document.forms[0].cmdapply.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function placevalues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
	
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false)
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="ADV1151"
		document.forms[0].hidBeanGetMethod.value="getDataFinancials";
		document.forms[0].hidSourceUrl.value="/action/adv_financials.jsp";
		document.forms[0].submit();
	 }	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
	document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
	document.forms[0].submit();
	}
}
function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_divID.value="0";
	document.forms[0].hidEditMode.value="U";
	document.forms[0].hidBeanGetMethod.value="insertData";
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].action=appURL+"action/adv_financials.jsp";	
	document.forms[0].submit();
}
function doDelete()
{
	var con=ConfirmMsg('152');
	if(con)
	{
			document.forms[0].hidEditMode.value="D";
			document.forms[0].hidBeanGetMethod.value="insertData";
			document.forms[0].hidBeanId.value="ADV1151";
			document.forms[0].action=appURL+"action/adv_financials.jsp";	
			document.forms[0].submit();
	}
}
function getdivval()
{		
	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;	
	document.forms[0].hidBeanId.value="ADV1151";
	document.forms[0].hidBeanGetMethod.value="getDataFinancials";
	document.forms[0].action = appUrl+"action/adv_financials.jsp";
	document.forms[0].submit();
}
var strvalue="";
function callRating(page,flowtype)
{
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].pageval.value=flowtype;
	document.forms[0].hidBeanId.value="LapsToRam";
	document.forms[0].hidBeanGetMethod.value="getRAMParameters";	
	document.forms[0].submit();	 
}
</script>
</head>
<body onload="placevalues()">
<form method="post" name="frmpri" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include
			page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="13" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> 
		</td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary -&gt; Proposal-&gt; Financials</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="2">
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive"><b>
				<a href="javascript:gotoTabpage(appURL,'ops_generatefinanalysis.jsp')"
					>Generate Financial Analysis</a></b></td>
				<%if (strDesc.trim().equals("FI")) {%>
				<td class="sub_tab_active"><b>Financial Indicators</b></td>
				<%} else {%>
				<td class="sub_tab_inactive"><b><a href="javascript:callAssess('adv_financials.jsp','FI')">Financial Indicators</a></b>
				</td>
				<%}%>
				<%if (strDesc.trim().equals("RA")) {%>
				<td class="sub_tab_active"><b>Ratios</b></td>
				<%} else {%>
				<td class="sub_tab_inactive"><b><a href="javascript:callAssess('adv_financials.jsp','RA')">Ratios</a></b>
				</td>
				<%}if (strDesc.trim().equals("MPBF1")) {%>
				<td class="sub_tab_active"><b>Working Capital</b></td>
				<%} else {%>
				<td class="sub_tab_inactive"><b><a href="javascript:callAssess('adv_financials.jsp','MPBF1')">Working Capital</a></b>
				</td>
				<%}if (strDesc.trim().equals("FU")) {%>
				<td class="sub_tab_active"><b>Fund Flow</b></td>
				<%} else {%>
				<td class="sub_tab_inactive"><b><a href="javascript:callAssess('adv_fundflow.jsp','FU')">Fund Flow</a></b>
				</td>
				<%}%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
									<%arrRow = (ArrayList) hshValues.get("arrRow");
			if (arrRow != null && arrRow.size() > 0) {%>
									<%for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					String strBgcolor = "";
					String strAlign = "";
					if (i < 2) {
						strBgcolor = "dataheader";
						strAlign = "center";
					} else {
						strBgcolor = "datagrid";
						strAlign = "right";
					}%>
									<tr class="<%=strBgcolor%>">
										<td><%=Helper.correctNull((String) arrCol.get(0))%>&nbsp;</td>
										<%if (!Helper.correctNull((String) arrCol.get(1)).equals("")) {%>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
										<%}if (!Helper.correctNull((String) arrCol.get(2)).equals("")) {%>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(2))%>&nbsp;</td>
										<%}if (!Helper.correctNull((String) arrCol.get(3)).equals("")) {%>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
										<%}if (!Helper.correctNull((String) arrCol.get(4)).equals("")) {%>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
										<%}if (!Helper.correctNull((String) arrCol.get(5)).equals("")) {%>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
										<%}%>
									</tr>
									<%}}%>
								</table>
								</td>
							</tr>
							<tr>
								<td><b>Comments</b></td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="50%" valign="top"><textarea name="branch_comments"
											cols="120" rows="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("advnotes"))%></textarea></td>
										<%if (strDesc.equals("MPBF1")) {%>
										<%}%>
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
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> <input type="hidden" name="totvalue"
	value="<%//=totcount%>"> <input type="hidden" name="uptovalue"
	value="<%//=upto%>"> <input type="hidden" name="flowtype" value="TERCA">
<input type="hidden" name="yearfrom" value="1">  <INPUT
	TYPE="hidden" name="hidEditMode"
	value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
<input type="hidden" name="hidappno"
	value="<%=request.getParameter("hidappno")%>"> <input type="hidden"
	name="sel_divID"> <input type="hidden" name="pageval"
	value="<%=Helper.correctNull((String)hshValues.get("page"))%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
</form>
</body>
</html>
