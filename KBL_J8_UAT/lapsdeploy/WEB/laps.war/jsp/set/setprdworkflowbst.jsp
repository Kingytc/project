<%@ include file="../share/directives.jsp"%>
<%	java.util.ArrayList arrWorkid = (java.util.ArrayList) hshValues.get("prd_workid");
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
	}%>
<html>
<head>
<title>Setup(Broad Terms of Sanction)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
<!--
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
}
function callFlowtype(type)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].wrk_flowtype.value=type;
	document.forms[0].hidBeanId.value="setproducts"
	document.forms[0].hidBeanGetMethod.value="getWorkflowBST";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setprdworkflowbst.jsp";
	document.forms[0].submit();
}

function doAssign()
{
	  for(var i=0;i<=7;i++)
	  {
	  document.forms[0].hid_prd_maxclass[i].value=document.forms[0].prd_maxclass[i].options[document.forms[0].prd_maxclass[i].selectedIndex].text;
	  }
}

function doSave()
{
	 doAssign();
	for(var i=0;i<document.forms[0].wrk_flowname.length;i++)
	{
		if(document.forms[0].wrk_flowname[i].value!="")
		{
			if(document.forms[0].prd_maxclass[i].value=="" || eval(document.forms[0].prd_maxclass[i].value)<=0)
			{
				ShowAlert(106,"maximum class");
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
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].wrk_flowtype.value=strWrkflowtype;
	document.forms[0].hidBeanId.value="setproducts"
	document.forms[0].hidBeanMethod.value="updateWorkflowBST";
	document.forms[0].hidBeanGetMethod.value="getWorkflowBST";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setprdworkflowbst.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
        document.forms[0].wrk_flowtype.value=strWrkflowtype;
		document.forms[0].hidBeanId.value="setproducts"
		document.forms[0].hidBeanGetMethod.value="getWorkflowBST";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/setprdworkflowbst.jsp";
		document.forms[0].submit();
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
	enableButtons(false,true,true,false);
	disableFields(true);
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type!="hidden" && document.forms[0].elements[i].type!="button")
		{
			 document.forms[0].elements[i].disabled=val;
		}
	}
}
function doEdit()
{
	enableButtons(true,false,false,false);
	disableFields(false);
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
function checkFlowname(idx)
{
	if(document.forms[0].wrk_flowname[idx].value=="")
	{
		ShowAlert(109);
		document.forms[0].wrk_flowname[idx].focus();
	}
}
function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
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
		 document.forms[0].action=appUrl+"action/combst_main.jsp";
		 document.forms[0].submit();
	 }
 }
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp();loadCode()">
<form name="documentsfrm" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corporate Products -> Broad Terms Proposal -&gt; Flowpoints</td>
	</tr>
</table>
<br>
												<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
													<tr>
														<td colspan="6">
														<table class="outertable" width="37%" border="0" cellspacing="1" cellpadding="3">
															<tr>
																<td align="center"
																	<%if (strWrkflowtype.equals("p")) {%>
																	class="sub_tab_active"><%}if (!strWrkflowtype.equals("p")) {%>
																class="sub_tab_inactive"> <a
																	href="javascript:callFlowtype('p')">
																	 <%}%> In Process</a></td>
																<td align="center"
																	<%if (strWrkflowtype.equals("a")) {%>
																	class="sub_tab_active">
																<%}if (!strWrkflowtype.equals("a")) {%>
																class="sub_tab_inactive">
																<a href="javascript:callFlowtype('a')"> <%}%>
																 Post Approval </a></td>
																<td align="center" <%if (strWrkflowtype.equals("r")) {%>
																	class="sub_tab_active"><%}if (!strWrkflowtype.equals("r")) {%>
																class="sub_tab_inactive"><a
																	href="javascript:callFlowtype('r')"> <%}%> Post
																Rejection </a></td>
															</tr>
														</table>
														</td>
													</tr>
												</table><br>
												<table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
													<tr>
														<td colspan="5"><span class="mantatory">Double
														click on the cell to get the list of Actions, then enter
														Maximum Class and Duration after selecting the Action.</span></td>
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
														<td width="11%">
														<div align="center">Duration (in Days)</div>
														</td>
													</tr>
													<%for (int i = intCount, j = 0; i < intCount + 8; i++, j++) {%>
															<tr class="datagrid">
																<td width="9%">
																<div align="center"><%=i%></div>
																</td>
																<td width="30%">
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
																	style="width: 50; text-align: center" maxlength="4"
																	onKeyPress="allowInteger()"
																	onFocus="checkFlowname(<%=j%>)"> <input
																	type="hidden" name="prd_workid"></div>
																</td>
															</tr>
															<%}%>
														</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<!--<input type="hidden" name="prd_code"> -->
<input type="hidden" name="wrk_flowtype"> 
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
