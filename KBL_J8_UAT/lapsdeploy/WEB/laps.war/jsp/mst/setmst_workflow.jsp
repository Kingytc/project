<%@ include file="../share/directives.jsp"%>
<%
	java.util.ArrayList arrWorkid = (java.util.ArrayList) hshValues
			.get("prd_workid");
	java.util.ArrayList arrMaxclass = (java.util.ArrayList) hshValues
			.get("prd_maxclass");
	java.util.ArrayList arrDuration = (java.util.ArrayList) hshValues
			.get("prd_duration");
	java.util.ArrayList arrWorkflowname = (java.util.ArrayList) hshValues
			.get("wrk_flowname");
	String strWrkflowtype = Helper.correctNull(request
			.getParameter("wrk_flowtype"));
	int intCount = 0;
	if (strWrkflowtype == null || strWrkflowtype.trim().equals("")) {
		strWrkflowtype = "p";
	}
	if (strWrkflowtype.equals("p")) {
		intCount = 1;
	} else if (strWrkflowtype.equals("a")) {
		intCount = 9;
	} else {
		intCount = 17;
	}
	String strprdtype = Helper.correctNull((String) request
			.getParameter("prdtype"));
%>

<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
DIV.cellContainer {
	width: 100%;
	height: 75;
	overflow: auto;
}
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
<!--

function showdata()
{
	
	if(document.forms[0].prdCode.value != "")
	{
	document.forms[0].prdCode.value;
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].method="post";
	document.forms[0].hidBeanId.value="setproducts";		
	document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	document.forms[0].action=appUrl+"action/setmst_workflow.jsp";	
	document.forms[0].submit();
	}
}

 var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
 var workid=new Array();
 var maxclass=new Array();
 var duration=new Array();
 var workname=new Array();
var strWrkflowtype ="<%=strWrkflowtype%>";
 var recsize=<%=arrWorkid.size()%>;
 <%for (int j = 0; j < arrWorkid.size(); j++) {%>
	 workid[<%=j%>]="<%=arrWorkid.get(j)%>";
     maxclass[<%=j%>]="<%=arrMaxclass.get(j)%>";
	 duration[<%=j%>]="<%=arrDuration.get(j)%>";
	 workname[<%=j%>]="<%=arrWorkflowname.get(j)%>";
<%}%>

function loadCode()
{
     document.forms[0].method="post";
	document.forms[0].prdCode.value = "<%=Helper.correctNull(request.getParameter("prdCode"))%>";
}

function callFlowtype(type)
{
	if (document.forms[0].prdCode.value != "")
	{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].method="post";
	document.forms[0].wrk_flowtype.value=type;
	document.forms[0].hidBeanId.value="modsancterms";
	document.forms[0].hidBeanGetMethod.value="getMstWorkflowMasterData";
	document.forms[0].hidSourceUrl.value="/action/setmst_workflow.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
	else
	{
		alert("select a Product To view its details");
	}
}
function doAssign()
{
 for(var i=0;i<=7;i++)
 {
  document.forms[0].hid_prd_maxclass[i].value=document.forms[0].prd_maxclass[i].options[document.forms[0].prd_maxclass[i].selectedIndex].text;
  
  }
   document.forms[0].hid_prdCode.value=document.forms[0].prdCode.options[document.forms[0].prdCode.selectedIndex].text;
  
}

function placeValues()
{
	for(var i=0;i<recsize;i++)
	{
		document.forms[0].prd_workid[i].value=workid[i];
		document.forms[0].prd_maxclass[i].value=maxclass[i];
		document.forms[0].prd_duration[i].value=duration[i];
		document.forms[0].wrk_flowname[i].value=workname[i];
	}
	for(var j=recsize;j<document.forms[0].prd_workid.length;j++)
	{
		document.forms[0].prd_workid[j].value="";
		document.forms[0].prd_maxclass[j].value="";
		document.forms[0].prd_duration[j].value="";
		document.forms[0].wrk_flowname[j].value="";

	}
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	disableFields(true);
}

function doEdit()
{
	
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	disableFields(false);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		placeValues();
	}
}

function callWorkflowlist(idx)
{
	if(document.forms[0].cmdedit.disabled)
	{
		var prop = "scrollbars=no,width=500,height=400,top=50,left=50";
		var url=appUrl+"action/workflowlist.jsp?wrk_flowtype="+strWrkflowtype+"&idx="+idx;
		window.open(url,"Workflow",prop);
	}
}

function doDelete(idx)
{
	var key=window.event.keyCode;
	if( !(key==46 || key==8))
	{
		window.event.returnValue = false;
	}
	else if(document.forms[0].cmdedit.disabled)
	{
		document.forms[0].prd_workid[idx].value="";
		document.forms[0].prd_maxclass[idx].value="";
		document.forms[0].prd_duration[idx].value="";
		document.forms[0].wrk_flowname[idx].value="";
		window.event.returnValue = false;
	}
	else
	{
		window.event.returnValue = false;
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setmst_mainnav.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
	doAssign();
	if(document.forms[0].prdCode.value=="")
	{
		alert("select a Limit To view its details");
		return;
	}
	var j=0;
	for(var i=0;i<document.forms[0].wrk_flowname.length;i++)
	{
		if(trim(document.forms[0].wrk_flowname[i].value)!="")
		{
			j++;
		}
	}
	if(j==0)
	{
		alert("Select any one of the action points");
		return;
	}
	for(var i=0;i<document.forms[0].wrk_flowname.length;i++)
	{
		if(document.forms[0].wrk_flowname[i].value!="")
		{
			if(document.forms[0].prd_maxclass[i].value=="" || eval(document.forms[0].prd_maxclass[i].value)<=0)
			{
				ShowAlert(106,"minimum class");
				document.forms[0].prd_maxclass[i].value="";
				document.forms[0].prd_maxclass[i].focus();
				return;
			}
			
			if(document.forms[0].prd_duration[i].value=="" || eval(document.forms[0].prd_duration[i].value)<=0)
			{
				ShowAlert(106,"duration");
				document.forms[0].prd_duration[i].value="";
				document.forms[0].prd_duration[i].focus();
				return;
			}

		}
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].wrk_flowtype.value=strWrkflowtype;
	document.forms[0].hidBeanId.value="modsancterms";
	document.forms[0].hidBeanMethod.value="updateMstWorkflowMasterData";
	document.forms[0].hidBeanGetMethod.value="getMstWorkflowMasterData";	
	document.forms[0].hidSourceUrl.value="/action/setmst_workflow.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}


function checkFlowname(idx)
{
	if(document.forms[0].wrk_flowname[idx].value=="")
	{
		ShowAlert(109);
		document.forms[0].wrk_flowname[idx].focus();
	}
}

function disableFields(flag)
{
	for(var i=0;i<document.forms[0].prd_workid.length;i++)
	{
		document.forms[0].prd_workid[i].disabled=flag;
		document.forms[0].prd_maxclass[i].disabled=flag;
		document.forms[0].prd_duration[i].disabled=flag;
		document.forms[0].wrk_flowname[i].disabled=flag;
	}
}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
		if(val=="existing")
		{
		ShowAlert(144);
		}
	}
}
//-->
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp();loadCode()">
<form name="documentsfrm" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corporate Products -> Modification in Sanction
		Terms -&gt; Flowpoints</td>
	</tr>
	<tr>
		<td align="right">
		<table class="outertable" width="35%" border="0" cellspacing="0"
			cellpadding="2">
			<tr>
				<td align="center" width="25%">Select Limit</td>
				<td width="75%"><select name="prdCode"
					onChange="javascript:showdata()">
					<option value="" selected="selected">-------Select-------</option>
					<lapschoice:productcode />
				</select> <input type="hidden" name="hid_prdCode"> <b>(Rs. in
				Lacs)</b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="3" >
	<tr>
		<td valign="top" height="133">
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="3" align="center" >
			<tr>
				<td height="7" valign="top">
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="0">
					<tr>
						<td colspan="4" height="2" valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td colspan="10" valign="top">
								<table class="outertable" width="100%" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<td valign="top">
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="0" align="center">
											<tr>
												<td>
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="3" height="0">
													<tr>
														<td colspan="6"></td>
													</tr>
													<tr>
														<td colspan="6">
														<table class="outertable" class="outertable" width="37%"
															border="0" cellspacing="1" cellpadding="3">
															<tr>
																<td width="27%" align="center"
																	<%if (strWrkflowtype.equals("p")) {%>
																	class="sub_tab_active">
																<%
																	}
																%> <%
 	if (!strWrkflowtype.equals("p")) {
 %> class="sub_tab_inactive"> <a href="javascript:callFlowtype('p')">
																<%
																	}
																%> In Process</a></td>
																<td width="35%" align="center"
																	<%if (strWrkflowtype.equals("a")) {%>
																	class="sub_tab_active">
																<%
																	}
																%> <%
 	if (!strWrkflowtype.equals("a")) {
 %> class="sub_tab_inactive"><a href="javascript:callFlowtype('a')">
																<%
																	}
																%> Post Approval </a></td>
																<td width="38%" align="center"
																	<%if (strWrkflowtype.equals("r")) {%>
																	class="sub_tab_active">
																<%
																	}
																%> <%
 	if (!strWrkflowtype.equals("r")) {
 %> class="sub_tab_inactive"><a href="javascript:callFlowtype('r')">
																<%
																	}
																%> Post Rejection </a></td>
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
									<tr>
										<td valign="top">
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="3" align="center">
											<tr>
												<td colspan="5" height="18"><span class="mantatory">Double click on the cell to
												get the list of Actions, then enter Maximum Class and
												Duration after selecting the Action.</span></td>
											</tr>
											<tr class="dataheader">
												<td width="9%">
												<div align="center">Flow point</div>
												</td>
												<td width="30%">
												<div align="center">Action</div>
												</td>
												<td width="35%">
												<div align="center">Minimum Class</div>
												</td>
												<%--  <td width="15%" align="center"><font  color="#FFFFFF">Function</td>--%>
												<td width="11%">
												<div align="center">Duration (in Days)</div>
												</td>
											</tr>
											<tr class="datagrid">
												<td colspan="5">
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="2" align="center">
													<%
														for (int i = intCount, j = 0; i < intCount + 8; i++, j++) {
													%>
													<tr>
														<td width="9%" height="2">
														<div align="center"><%=i%></div>
														</td>
														<td width="30%" height="2">
														<div align="center"><input type="text"
															name="wrk_flowname" size="5" style="width: 200"
															maxlength="200" onDblClick="callWorkflowlist(<%=j%>)"
															onKeyDown="doDelete(<%=j%>)"></div>
														</td>
														<td width="35%" height="2"><select
															name="prd_maxclass" onFocus="checkFlowname(<%=j%>)">
															<option value="">----Select----</option>
															<%
																String apptype = "7";
															%>
															<lapschoice:StaticDataNewTag apptype="<%=apptype%>" />
														</select> <input type="hidden" name="hid_prd_maxclass"></td>
														<td width="11%" height="2">
														<div align="center"><input type="text"
															name="prd_duration" size="5"
															style="width: 50; text-align: center" maxlength="4"
															onKeyPress="allowInteger()"
															onFocus="checkFlowname(<%=j%>)"> <input
															type="hidden" name="prd_workid"></div>
														</td>
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
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="wrk_flowtype"> 
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>"> 
<input type="hidden" name="prdtype" value="<%=strprdtype%>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
