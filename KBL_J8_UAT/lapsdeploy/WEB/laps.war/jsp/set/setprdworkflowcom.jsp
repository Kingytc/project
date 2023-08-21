<%@ include file="../share/directives.jsp"%>
<%
	java.util.ArrayList arrWorkid = (java.util.ArrayList) hshValues.get("prd_workid");
	java.util.ArrayList arrMaxclass = (java.util.ArrayList) hshValues.get("prd_maxclass");
	java.util.ArrayList arrDuration = (java.util.ArrayList) hshValues.get("prd_duration");
	java.util.ArrayList arrWorkflowname = (java.util.ArrayList) hshValues.get("wrk_flowname");
	String strWrkflowtype = Helper.correctNull(request.getParameter("wrk_flowtype"));
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
	String strprdtype = Helper.correctNull((String) request.getParameter("prdtype"));%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setprdworkflowcom.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";


function showdata()
{	
	if(document.forms[0].prdCode.value != "")
	{	
		try{
			document.forms[0].cmdaudittrail.disabled = false; 
				}catch(e){
				}
		document.forms[0].prdCode.value;
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="setproducts";		
		document.forms[0].hidBeanGetMethod.value="getWorkflowData";
		document.forms[0].action=appUrl+"action/setprdworkflowcom.jsp";	
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
var recsize = 0;
var strWrkflowtype ="<%=strWrkflowtype%>";
<%if(arrWorkid!=null){%>
recsize=<%=arrWorkid.size()%>;
 <%for (int j = 0; j < arrWorkid.size(); j++) {%>
	 workid[<%=j%>]="<%=arrWorkid.get(j)%>";
     maxclass[<%=j%>]="<%=arrMaxclass.get(j)%>";
	 duration[<%=j%>]="<%=arrDuration.get(j)%>";
	 workname[<%=j%>]="<%=arrWorkflowname.get(j)%>";
<%}}%>

function loadCode()
{
    document.forms[0].method="post";
	document.forms[0].prdCode.value = "<%=Helper.correctNull(request.getParameter("prdCode"))%>";
	document.forms[0].hidkeyid.value = "<%=Helper.correctNull(request.getParameter("prdCode"))%>";
	if(document.forms[0].prdCode.value ==""){
		try{
	document.forms[0].cmdaudittrail.disabled = true; 
		}catch(e){
		}
	}
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
		document.forms[0].hidBeanGetMethod.value="getWorkflowData";
		document.forms[0].action=appUrl+"action/setprdworkflowcom.jsp";
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
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp();loadCode()">
<form name="documentsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; <%if (strprdtype.equals("C")) {%>Corporate &amp; Agriculture <%} else {%> 
		Tertiary <%}%> Products -&gt; Flowpoints</td>
	</tr>
</table><br>
		<table width="35%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td align="center" width="25%">Select Limit</td>
				<td width="75%"><select name="prdCode"
					onChange="javascript:showdata();">
					<option value="" selected>-------Select-------</option>
					<lapschoice:productcode />
				</select> <input type="hidden" name="hid_prdCode"> 
				<%if (strprdtype.equals("C")) {%><b>(Rs. in Lacs)</b>
				<%}%>
				</td>
			</tr>
		</table><br>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
														<td colspan="6">
														<table width="37%" border="0" cellspacing="1" cellpadding="3" class="outertable">
															<tr>
																<td align="center"
																	<%if (strWrkflowtype.equals("p")) {%> class="sub_tab_active"><b> 
																	<%}%><%if (!strWrkflowtype.equals("p")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('p')">
																<%}%> In Process</a></b></td>
																<td align="center"
																	<%if (strWrkflowtype.equals("a")) {%> class="sub_tab_active"><b>
																	<%}%> <%if (!strWrkflowtype.equals("a")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('a')">
																<%}%> Post Approval </a></b></td>
																<td align="center"
																	<%if (strWrkflowtype.equals("r")) {%>class="sub_tab_active"><b>
																	<%}%> <%if (!strWrkflowtype.equals("r")) {%>
																class="sub_tab_inactive"><b> <a href="javascript:callFlowtype('r')">
																<%}%> Post Rejection </a></b></td>
															</tr>
														</table>
														</td>
													</tr>
												</table><br>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
													<tr>
														<td >
												<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
													<tr>
														<td colspan="5"><span class="mantatory">Double
														click on the cell to get the list of Actions, then enter
														Maximum Class and Duration after selecting the Action.</span></td>
													</tr>
													<tr class="dataheader">
														<td width="9%">
														<div align="center">Flow point </div>
														</td>
														<td width="30%">
														<div align="center">Action</div>
														</td>
														<td width="35%">
														<div align="center">Minimum Class </div>
														</td>
														<td width="11%">
														<div align="center">Duration (in Days)</div>
														</td>
													</tr><%for (int i = intCount, j = 0; i < intCount + 8; i++, j++) {%>
															<tr class="datagrid">
																<td width="9%">
																<div align="center"><%=i%></div>
																</td>
																<td width="30%" >
																<div align="center"><input type="text"
																	name="wrk_flowname" size="5" style="width: 200"
																	maxlength="200" onDblClick="callWorkflowlist(<%=j%>)"
																	onKeyDown="doDelete(<%=j%>)"></div>
																</td>
																<td width="35%"><select
																	name="prd_maxclass" onFocus="checkFlowname(<%=j%>)">
																	<option value="">----Select----</option>
																	<%String apptype = "7";%>
																	<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
																</select> <input type="hidden" name="hid_prd_maxclass"></td>
																<td width="11%">
																<div align="center"><input type="text"
																	name="prd_duration" size="5"
																	style="width: 50; text-align: center" maxlength="2"
																	onKeyPress="allowInteger()"
																	onFocus="checkFlowname(<%=j%>)"> <input
																	type="hidden" name="prd_workid"></div>
																</td>
															</tr>
															<%}%>
														</table>
														</td>
													</tr>
												</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>  
<input type="hidden" name="wrk_flowtype"> 
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="prdtype" value="<%=strprdtype%>">
<input type ="hidden" name ="hidkeyid" value="<%=Helper.correctNull((String) hshValues.get("prdCode"))%>">
</form>
</body>
</html>
