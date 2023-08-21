<%@ include file="../share/directives.jsp"%>
<%
   ArrayList arrWorkid=(ArrayList)hshValues.get("prd_workid");
   ArrayList arrMaxclass=(ArrayList)hshValues.get("prd_minclass");
   ArrayList arrDuration=(ArrayList)hshValues.get("prd_duration");
   ArrayList arrWorkflowname=(ArrayList)hshValues.get("wrk_flowname");
   String strWrkflowtype=request.getParameter("wrk_flowtype");
   String strprdtype=Helper.correctNull((String)hshValues.get("strPrdCode"));
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
%>
<html>
<head> 
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" ></script>

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var strWrkflowtype ="<%=strWrkflowtype%>";
var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strprd_skip="<%=Helper.correctNull((String) hshValues.get("prd_skip"))%>";
var strprd_approval="<%=Helper.correctNull((String) hshValues.get("prd_approval"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varProductcode="<%=Helper.correctNull((String) hshValues.get("prd_code"))%>";
var varminclssapproval="<%=Helper.correctNull((String) hshValues.get("prd_minclassapproval"))%>";
var varminclassskip="<%=Helper.correctNull((String) hshValues.get("prd_minclassskip"))%>";
var workid=new Array();
var maxclass=new Array();
var duration=new Array();
var workname=new Array();
var varmaxid="<%=Helper.correctNull((String) hshValues.get("prd_minclassapprovaltxt"))%>";
var recsize=<%=arrWorkid.size()%>;
<%for(int j=0;j<arrWorkid.size();j++){%>
	 workid[<%=j%>]="<%=arrWorkid.get(j)%>";
     maxclass[<%=j%>]="<%=arrMaxclass.get(j)%>";	
	 duration[<%=j%>]="<%=arrDuration.get(j)%>";
	 workname[<%=j%>]="<%=arrWorkflowname.get(j)%>";
<%}%>

function showDescSkip(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_skip_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}

function showDescApp(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_app_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		enableButtons(false,true,true,false);
		if(val=="existing")
		{
			ShowAlert(144);
		}
	}
}

 function placeValues()
 {
     if(strprd_skip!="")
	 {
         document.forms[0].prd_skip.value=strprd_skip;
		 document.forms[0].prd_approval.value=strprd_approval;
	 }
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
 	if(varProductcode!="")
 	{
 		 document.forms[0].sel_prd.value=varProductcode;
 	}
 	else
 	{
 		 document.forms[0].sel_prd.value="0";
 	}
	 document.forms[0].prd_approval.value=varminclssapproval;
	 document.forms[0].prd_skip.value=varminclassskip;
	 document.forms[0].prd_skip_value.style.visibility="hidden";
     document.forms[0].prd_skip_descr.readOnly=true;
	 document.forms[0].prd_app_descr.readOnly=true;
	 document.forms[0].wrk_flowname.readOnly=true;
	 disabledFields(true);
	 document.forms[0].sel_prd.disabled=false;
	 enableButtons(false,true,true,false);
}

 function doEdit()
 {
	 document.forms[0].wrk_flowname.readOnly=true;
	 disabledFields(false);
	 enableButtons(true,false,false,false);

	 if(document.forms[0].sel_prd.value=="0")
	 {
		 alert('Please select product code');
		 return;
	 }
 }

 function doSave()
 {
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

	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].hidAction.value = "insert";
	 document.forms[0].hidBeanId.value="setproducts";
	 document.forms[0].hidBeanMethod.value="updateSolKpowerData";
	 document.forms[0].hidBeanGetMethod.value="getSolKpowerData";
	 document.forms[0].hidSourceUrl.value="/action/solandkpowerflowpoint.jsp";
	 document.forms[0].action=appUrl+"controllerservlet";
	 document.forms[0].submit();
	 disabledFields(true);
 }

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].prd_skip.value="";
	  	document.forms[0].prd_approval.value="";
	    placeValues();
	 }
	 document.forms[0].prd_skip.disabled=strprd_skip;
	 document.forms[0].prd_approval.disabled=strprd_approval;
    
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

 function menuOptionDivMouseDown (url)
{

	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
		document.currentMenu.style.display='none';
		document.currentMBarOpt.style.border='1px solid lightgrey';
		document.menuIsActive = false;
		document.forms[0].action=url;
		document.forms[0].submit();
}

function dohlp()     
{
  var hlpvar = appUrl+"phlp/setup_retailprod_authority.htm";
  var title = "Authority";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function gotopostprocess()
{
	 document.forms[0].action=appURL+"action/.jsp";
	 document.forms[0].submit();
}

function gotopostrejct()
{
	 document.forms[0].action=appURL+"action/.jsp";
	 document.forms[0].submit();
}

function callFlowtype(type)
{
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].wrk_flowtype.value=type;
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanGetMethod.value="getSolKpowerData";
	document.forms[0].action=appUrl+"action/solandkpowerflowpoint.jsp";
	document.forms[0].submit();
}

function callWorkflowlist(idx)
{
	if(document.forms[0].cmdedit.disabled)
	{
		var prop = "scrollbars=no,width=500,height=420,top=50,left=50";
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

function getproduct()
{
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanGetMethod.value="getSolKpowerData";
	document.forms[0].action=appUrl+"action/solandkpowerflowpoint.jsp";
	document.forms[0].submit();
}

function enableButtons(bool1, bool2, bool3, bool4) 
{
	document.forms[0].cmdedit.disabled = bool1;
	document.forms[0].cmdsave.disabled = bool2;
	document.forms[0].cmdcancel.disabled = bool3;
	document.forms[0].cmdclose.disabled = bool4;
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp()">
<form name="documentsfrm" method="post" class="normal" >  

<table width="100%" border="0" cellspacing="0" cellpadding="1" align="center" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Solvency and kpower Flow point</td>
    </tr>    
  </table>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
    <tr> 
      <td> 
       <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
       <tr>
       <td valign="top">
       <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                  <tr>
                                  <td width="47%">Product code</td>
                                  <td width="29%"> <select name="sel_prd" onchange="getproduct();">
                                        <option value="0">&lt;---Select---&gt;</option>
                                        <option value="1">Solvency</option>
                                        <option value="2">Kpower</option>
                                        <option value="3">Deviation</option>
                     
                                        <option value="6">Banker Certificate</option>
                                         <option value="7">Line of Credit</option>
                                          </select>
                                     </td>
                                   <td width="24%"></td>
                                  </tr>
                                  <tr> 
                                    <td width="47%" >Minimum Class for Approval / Rejection 
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_approval1" size="12" maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_approval" onChange=showDescApp(document.forms[0].prd_approval.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                      </td>
                                    <td width="24%">                                       
                                        <input type="text" name="prd_app_descr" size="50"  maxlength="4" style="text-align:left" value="<%=Helper.correctNull((String) hshValues.get("prd_minclassapprovaltxt"))%>">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="47%" >Minimum Class for Skip flowpoints
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_skip1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_skip" onChange=showDescSkip(document.forms[0].prd_skip.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_skip_descr" size="50"  maxlength="4" style="text-align:left" value="<%=Helper.correctNull((String) hshValues.get("prd_minclassskiptxt"))%>">
                                        
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3" >
                                      <select name="prd_skip_value" style="width:100">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclassdesc /> 
                                      </select>
                                      </td>
                                  </tr>
                                </table>
                                </td>
                              </tr>
                              </table>
		<table width="37%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			
             <tr > 
               <td align="center" <%if(strWrkflowtype.equals("p")){%>
                 class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b> 
                 <%if (!strWrkflowtype.equals("p")){%>
                 <a href="javascript:callFlowtype('p')"> 
                 <%}%>
                 In Process</a></b></td>
               <td align="center" <%if(strWrkflowtype.equals("a")){%>
                class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b> 
                 <%if (!strWrkflowtype.equals("a")){%>
                 <a href="javascript:callFlowtype('a')" > 
                 <%}%>
                 Post Approval </a></b></td>
               <td align="center" <%if(strWrkflowtype.equals("r")){%>
                class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b>  
                 <%if (!strWrkflowtype.equals("r")){%>
                 <a href="javascript:callFlowtype('r')" > 
                 <%}%>
                 Post Rejection </a></b></td>
             </tr>
           </table>



		</td>
    </tr>
  </table>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	align="center" class="outertable">
	<tr>
		<td colspan="5" height="18"><span class="mantatory">Double
		click on the cell to get the list of Actions, then enter Minimum Class
		and Duration after selecting the Action.</span></td>
	</tr>
	<tr class="dataheader">
		<td width="7%">
		<div align="center">Flow point</div>
		</td>
		<td width="38%">
		<div align="center">Action</div>
		</td>
		<td width="35%">
		<div align="center">Minimum Class</div>
		</td>
		<td width="10%">
		<div align="center">Duration (in Days)</div>
		</td>
	</tr>
	<tr class="datagrid">
		<td colspan="5">
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			align="center" class="outertable">
			<%for(int i=intCount,j=0;i<intCount+8;i++,j++){%>
			<tr>
				<td width="5%" align="center"><%=i%></td>
				<td width="40%" align="center">
				
				<input type="text"
					name="wrk_flowname" size="5" style="width: 200" maxlength="200"
					onDblClick="callWorkflowlist(<%=j%>)">
				</td>
				
				
				<td width="35%" align="center"><input type="hidden"
					name="prd_maxintclass1" size="12" maxlength="4" disabled
					onKeyPress="allowInteger()" style="text-align: right"> <select
					name="prd_maxclass">
					<option value="">----Select----</option>
					<%String apptype="7"; %>
					<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
				</select> <input type="hidden" name="hid_prd_maxclass"></td>
				
				
				
				<td width="10%">
				<div align="center"><input type="text" name="prd_duration"
					size="5" style="width: 50; text-align: center" maxlength="4"
					onKeyPress="allowInteger()" onFocus="checkFlowname(<%=j%>)">
				<input type="hidden" name="prd_workid"></div>
				</td>
			</tr>
			<%}%>
		</table>
</table>

<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String) request.getParameter("prdCode"))%>"/>
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String) request.getParameter("hidProductType"))%>">
<input type="hidden" name="wrk_flowtype" value="<%=request.getParameter("wrk_flowtype")%>">
<input type="hidden" name="prd_id">
<input type="hidden" name="hidprdcode" value="<%=Helper.correctNull((String)hshValues.get("strPrdCode"))%>">
</form>
</body>
</html>
  