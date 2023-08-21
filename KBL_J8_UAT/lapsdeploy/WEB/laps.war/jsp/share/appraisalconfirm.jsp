<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
ArrayList arrRow = new ArrayList();
ArrayList arrCol = new ArrayList();		
if (hshValues != null) {
	arrRow = (ArrayList) hshValues.get("arrRow");}
String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));%>
<html>
<head>
<title>Appraisal Confirmation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strOption ="<%=Helper.correctNull((String)hshValues.get("strOption"))%>";
var strDet ="<%=Helper.correctNull((String)hshValues.get("strDet"))%>";
var stat_data_sno ="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>";
var str="<%=Helper.correctNull((String)hshValues.get("str"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
var vardatalength="<%=arrRow.size()%>";
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdHelp.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function callonLoad()
{
	document.forms[0].hidAction.value="select";		
	disablefields(true);	
}
function doSave()
{
	if(vardatalength=="1")
	{
		if(document.forms[0].sel_option.value=="0")
		{
			alert("Select Value for the Questions given");
			document.forms[0].sel_option.focus();
			return;
		}
	}
	else
	{
		for(var i = 0; i < vardatalength; i++)
		{
			if(document.forms[0].sel_option[i].value=="0")
			{
				alert("Select Value for the Questions given");
				document.forms[0].sel_option[i].focus();
				return;
			}
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].hidBeanMethod.value="updateDataQuestParameters";
	document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
	document.forms[0].hidSourceUrl.value="/action/appraisalconfirm.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
	 document.forms[0].action=appURL+"action/retailpge.jsp";
	  document.forms[0].submit();
	}
}
function doCancel()
{	
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action=appURL+"action/appraisalconfirm.jsp";
		document.forms[0].submit();
	}
}

function doEdit() 
{
   	document.forms[0].hidAction.value="update"
   	document.forms[0].hid_option.value="";
	enableButtons(true, false, false, true);
	disablefields(false);
}   
function enableButtons(bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="appform" method="post" class="normal"><jsp:include
	page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="10" />
</jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt;
		Check List</td>
	</tr>
</table>
<lapschoice:application /> <jsp:include page='../share/apprlinktab.jsp'
	flush="true">
	<jsp:param name="tabid" value="7" />
</jsp:include>
<table width="98%" border="0" cellpadding="3" cellspacing="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="98%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<tr>
						<td valign="top" height="76">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable linebor">
									<tr align="center" class="dataheader">
										<td nowrap="nowrap" width="65%"><b>Appraisal</b></td>
										<td nowrap="nowrap" width="5%"><b>Value</b></td>
										<td nowrap="nowrap" width="30%"><b>Remarks</b></td>
									</tr>
						                    <%
												if (arrRow != null && arrRow.size() > 0) {
													int intarrSize1 = arrRow.size();
													for (int i = 0; i < intarrSize1; i++) {
														arrCol = (ArrayList) arrRow.get(i);
											%>
									<tr class="datagrid">
										<td><br>
										<%=i + 1%>. <%=Helper.correctNull((String) arrCol.get(1))%><br>
										<input type="hidden" name="txt_staticdataid"
											value="<%=Helper.correctNull((String) arrCol.get(0))%>"></td>
										<td align="center">
										<%String str11 =Helper.correctNull((String) arrCol.get(2));%>

							 <select name="sel_option">
							<%if (str11.equals("0")) { %>
								<option value="0" selected="selected">&lt;---Select---&gt;</option>
								<%} else { %>
								<option value="0">&lt;---Select---&gt;</option>
								<%} %>
								<%if (str11.equals("1")) { %>
								<option value="1" selected="selected">Yes</option>
								<%} else { %>
								<option value="1">Yes</option>
								<%} %>
								<%if (str11.equals("2")) { %>
								<option value="2" selected="selected">No</option>
								<%} else { %>
								<option value="2">No</option>
								<%} %>
								<%if (str11.equals("3")) { %>
								<option value="3" selected="selected">Not Applicable</option>
								<%} else { %>
								<option value="3">Not Applicable</option>
								<%} %>
							</select></td>
							<td valign="top" align="center"><textarea
								name="txt_comments" 
								onKeyPress="NoallowEnterandDoubleQuote();notAllowSingleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
								rows="2" cols="25" wrap="virtual"><%=Helper.correctNull((String) arrCol.get(3))%></textarea>
							</td>
						</tr>
						<%					
					}
			}
			%>
								</table>
								</td>
							</tr>
						</table>
						<table>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
	<input type="hidden" name="hidslno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
	<input type="hidden" name="hidstate" value="2"> 
	<input type="hidden" name="hidstatenew" value=""> 
	<input type="hidden" name="hid_option" value="<%=Helper.correctNull((String)hshValues.get("strOption"))%>">
</form>
</body>
</html>
