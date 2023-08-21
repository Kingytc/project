<%@include file="../share/directives.jsp"%>
<%java.util.ArrayList arrWorkid=(java.util.ArrayList)hshValues.get("prd_workid");
   java.util.ArrayList arrMaxclass=(java.util.ArrayList)hshValues.get("prd_maxclass");
   java.util.ArrayList arrDuration=(java.util.ArrayList)hshValues.get("prd_duration");
   java.util.ArrayList arrWorkflowname=(java.util.ArrayList)hshValues.get("wrk_flowname");
   String strWrkflowtype=Helper.correctNull(request.getParameter("wrk_flowtype"));
   int intCount=0;
   if(strWrkflowtype==null || strWrkflowtype.trim().equals(""))
   {
	   strWrkflowtype="p";
   }
   if(strWrkflowtype.equals("p"))
   {
	   intCount=1;
   }
   else if(strWrkflowtype.equals("a"))
   {
	   intCount=9;
   }
   else
   {
	   intCount=17;
   }
   
   String strPrdCode=Helper.correctNull((String)hshValues.get("strPrdCode"));%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/setprdworkflownpa.js" ></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var prdcode="<%=strPrdCode%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
<!--
function showdata()
{
	if(document.forms[0].prdCode.value != "")
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].method="post";
		document.forms[0].hidBeanId.value="setproducts";		
		document.forms[0].hidBeanGetMethod.value="getWorkflowNPA";
		document.forms[0].action=appUrl+"action/setprdworkflowcomnpa.jsp";	
		document.forms[0].submit();
	}
}
		 var val = "<%=request.getParameter("val")%>";
		 var appUrl="<%=ApplicationParams.getAppUrl()%>";
		 var workid=new Array();
		 var maxclass=new Array();
		 var duration=new Array();
		 var workname=new Array();
		 var strWrkflowtype ="<%=strWrkflowtype%>";
		 var recsize=0;
		 <%if(arrWorkid!=null){%>
		 recsize=<%=arrWorkid.size()%>;
 <%for(int j=0;j<arrWorkid.size();j++){%>
	 workid[<%=j%>]="<%=arrWorkid.get(j)%>";
     maxclass[<%=j%>]="<%=arrMaxclass.get(j)%>";
	 duration[<%=j%>]="<%=arrDuration.get(j)%>";
	 workname[<%=j%>]="<%=arrWorkflowname.get(j)%>";
<%}}%>

function loadCode()
{
    document.forms[0].method="post";
    if(prdcode!="" && prdcode!="S")
    {
		document.forms[0].prdCode.value = prdcode;
	}
	else
	{
		document.forms[0].prdCode.value = "S";
	}	
}

function callFlowtype(type)
{
	if(type!="w")
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
		document.forms[0].hidBeanGetMethod.value="getWorkflowNPA";
		document.forms[0].action=appUrl+"action/setprdworkflowcomnpa.jsp";
		document.forms[0].submit();
		}
		else
		{
			alert("select a Product To view its details");
		}
	}
	else
	{
		document.forms[0].wrk_flowtype.value=type;
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanGetMethod.value="getNPAAuthority";
		document.forms[0].action=appUrl+"action/npa_authority.jsp";
		document.forms[0].submit();
	}
}


//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp();loadCode()">
<form name="documentsfrm" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; NPA -&gt; Flowpoints</td>
    </tr>
    </table><br>
        <table width="41%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr>                                                
            <td align="center" width="51%">Select NPA Module</td>
                                                <td width="49%">
                                                  <select name="prdCode" onChange="showdata()">
                                                    <option value="S" selected="selected">-------SELECT-------</option>
													 <option value="OTSCO">COMPROMISE PROPOSAL</option>
													 <option value="PAWO">PRUDENTIAL WRITE OFF/ABSOLUTE WRITE OFF</option>
													 <option value="SUIT">FILING OF SUIT</option>
													 <option value="STAT">STATUS NOTE</option>
													 <option value="SARFI">SARFAESI ACT</option>
                                                  </select>
                                                </td>
                                              </tr>
                                            </table> <br>
												<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
													<tr>
														<td>
														<table border="0" cellspacing="1" cellpadding="3" class="outertable">
															<tr>
															<%if (strWrkflowtype.equals("p")){%><td align="center" class="main_tab_active">In Process</td>
															<%}else{%><td align="center" class="main_tab_inactive">
																<a href="#" onclick="callFlowtype('p')"> In	Process</a></td>
																<%}%>																
																	<%if(strWrkflowtype.equals("a")){%><td align="center" class="main_tab_active">Post Approval </td><%}%>
																	<%if (!strWrkflowtype.equals("a")){%><td align="center" class="main_tab_inactive">
																<a href="javascript:callFlowtype('a')">Post Approval</a></td> <%}%>
																
																	<%if(strWrkflowtype.equals("r")){%><td align="center" class="main_tab_active">Post Rejection </td><%}%>
																	<%if (!strWrkflowtype.equals("r")){%><td align="center" class="main_tab_inactive">
																<a href="javascript:callFlowtype('r')">Post Rejection</a></td> <%}%> 
																
																	<%if(strWrkflowtype.equals("w")){%> <td align="center" class="main_tab_active">Authority</td><%}%>
																	<%if (!strWrkflowtype.equals("w")){%><td align="center" class="main_tab_inactive">
																	<a href="javascript:callFlowtype('w')"> Authority</a></td><%}%>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												<br>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
													<tr>
														<td colspan="5" >Double click on the cell
														to get the list of Actions, then enter Maximum Class and
														Duration after selecting the Action.</td>
													</tr>
													<tr class="dataheader">
														<td width="9%"><div align="center">Flow point</div></td>
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
															<%for(int i=intCount,j=0;i<intCount+8;i++,j++){%>
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
																<td width="35%" align="center"><select name="prd_maxclass"
																	onFocus="checkFlowname(<%=j%>)">
																	<option value="">----Select----</option>
																	<%String apptype="7"; %>
																	<lapschoice:StaticDataNewTag apptype="<%=apptype%>" />
																</select> <input type="hidden" name="hid_prd_maxclass">
																</td>
																<td width="11%" align="center"><input type="text"
																	name="prd_duration" size="5"
																	style="width: 50; text-align: center" maxlength="4"
																	onKeyPress="allowInteger()"
																	onFocus="checkFlowname(<%=j%>)"> <input
																	type="hidden" name="prd_workid">
																</td>
															</tr>
															<%}%>
														</table>
<br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="wrk_flowtype">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
 </html>
