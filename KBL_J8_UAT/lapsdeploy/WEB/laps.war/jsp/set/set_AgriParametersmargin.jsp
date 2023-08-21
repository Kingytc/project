<%@ include file="../share/directives.jsp"%>
<%	ArrayList vecMargin = new ArrayList();
	String strrangefrom = "";
	String strrangeto = "";
	String strpercentcharge = "";
	
	if (hshValues != null) 
	{
	vecMargin = (ArrayList) hshValues.get("vecMarginRow");
	if (vecMargin != null && vecMargin.size() > 0) 
		{
		ArrayList vec = new ArrayList();
		vec = (ArrayList) vecMargin.get(0);
		if (vec != null) 
			{
			strrangefrom = Helper.correctNull((String) vec.get(2));
			strrangeto = Helper.correctNull((String) vec.get(3));
			strpercentcharge = Helper.correctNull((String) vec.get(4));
			}
		}
	}
	String strExp=Helper.correctNull((String)hshValues.get("strExp"));
	

	%>
<html>
<head>
<title>Setup(Products - Margin Amount)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var selperiod="<%=Helper.correctNull((String)hshValues.get("prd_inspection"))%>";
var val = "<%=request.getParameter("val")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function onloading()
	{  
	strExp="<%=strExp%>";
	
	if(strExp!="")
		{
		
		DisableButtons(true,true,true,true,true);
		}
	for(i=0;i<document.forms[0].selectmarginterm.length;i++)
		{
		if(document.forms[0].hidId.value == document.forms[0].selectmarginterm[i].value)
			{
			if(document.forms[0].hidId.value==0)
				{
				document.forms[0].selectmarginterm.selectedIndex=0;
				}
			else
				{
			document.forms[0].selectmarginterm.selectedIndex=i;
				}
			}	
		}	
	selindex=document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
	if(selindex=='')
		{
		DisableButtons(true,true,true,true,false);
		}
	else
		{
		if(document.forms[0].checkApp.value=="No")
			{
			DisableButtons(false,true,true,true,false);			
			}
		else
			{
			DisableButtons(true,true,true,true,false);
			}	
		}
	DisableField(true);
	}

function DisableField(flag)
{
	document.forms[0].prd_procrangefrom.readOnly=flag;
	document.forms[0].prd_procrangeto.readOnly=flag;
	document.forms[0].prd_procfees.readOnly=flag;
}

function DisableButtons(cmdedit,cmdsave,cmdcancel,cmddelete,cmdclose)
{
	document.forms[0].cmdedit.disabled = cmdedit;
	document.forms[0].cmdsave.disabled = cmdsave;
	document.forms[0].cmdcancel.disabled = cmdcancel;
	document.forms[0].cmddelete.disabled = cmddelete;
	document.forms[0].cmdclose.disabled = cmdclose;
}
	
function marginpageClearValues()
{
	document.forms[0].prd_procrangefrom.value="";
	document.forms[0].prd_procrangeto.value="";
	document.forms[0].prd_procfees.value="";
}
function onNew()
{	
	varRecordFlag="N";
	isnew="true";
	if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp1.value=="null" || document.forms[0].checkApp.value=="")
	{
		DisableField(false);
		DisableButtons(true,false,false,true,true);
	}
	else
	{
		DisableField(true);
		document.forms[0].selectmarginterm.selectedIndex=0;
		ShowAlert(144);
	}
}

function getMarginValue()
{
	selindex=document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
	if(selindex=='')		
	{	
		marginpageClearValues();
		DisableField(true);
		DisableButtons(true,true,true,true,false);
	}
	else if(selindex==0)
	{
		marginpageClearValues();
		DisableField(false);
		onNew();
	}
	else
	{
		if(document.forms[0].checkApp.value=="No")
		{	
			DisableField(false);
		}	
		document.forms[0].hidId.value = 
		document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value ;
		document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getAgrimarginData";
		document.forms[0].action=appURL+"action/set_AgriParametersmargin.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		if(document.forms[0].checkApp.value=="No")
		{	
			DisableField(false);
		}	
		document.forms[0].hidId.value = 
		document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value ;
		document.forms[0].hiddesc.value="";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="getAgrimarginData";
		document.forms[0].hidSourceUrl.value="/action/set_AgriParametersmargin.jsp";
		document.forms[0].submit();	
	}
}

function doSave()
{
	
	if(document.forms[0].prd_procrangefrom.value=="")
	{
		alert("Please enter the Range From");
		return;
	}
	if(document.forms[0].prd_procrangeto.value=="")
	{
		alert("Please enter the Range To");
		return;
	}
	if(document.forms[0].prd_procfees.value=="")
	{
		alert("Please enter the Margin Percentage");
		return;
	}

	if(parseFloat(document.forms[0].prd_procrangefrom.value) > parseFloat(document.forms[0].prdRangeTo.value) || parseFloat(document.forms[0].prd_procrangefrom.value) < parseFloat(document.forms[0].prdRangeFrom.value) )
	{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
	}
	if(parseFloat(document.forms[0].prd_procrangeto.value) > parseFloat(document.forms[0].prdRangeTo.value) )
	{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
	}
	if(parseFloat(document.forms[0].prd_procrangeto.value) <  parseFloat(document.forms[0].prd_procrangefrom.value))
	{
		alert("The Amount From Range Should Be Less Than Amount To Range");
		return;
	}
	
	if(isnew=="true")
	{
		document.forms[0].hidAction.value="insert";
	}
	else
	{
		document.forms[0].hidAction.value="update";
	}
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidId.value =
	document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
	document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setinterest";
	document.forms[0].hidBeanGetMethod.value="updateAgrimarginData";
	document.forms[0].action=appURL+"action/set_AgriParametersmargin.jsp";
	document.forms[0].submit();	
}

function callAgriProp(page)
{
     document.forms[0].hidBeanId.value="setinterest";
	 document.forms[0].hidBeanGetMethod.value="getAgriPropertiesData";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		if(varRecordFlag=="Y")
		{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidId.value =
		document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="updateAgrimarginData";
		document.forms[0].hidSourceUrl.value="/action/set_AgriParametersmargin.jsp";
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
	}
}
function doEdit()
{
	document.forms[0].hidAction.value="INSERT";
	DisableField(false);
	DisableButtons(true,false,false,false,true);
}
</script>
<style>
.navlist {
	padding: 3px 0;
	margin-left: 0;
	border-bottom: 1px solid #778;
	font: bold 12px Verdana, sans-serif;
}
.navlist li {
	list-style: none;
	margin: 0;
	display: inline;
}
.navlist li a,.navlist li a.normal {
	padding: 2px 0.5em 3px 0.5em;
	margin-left: 3px;
	border: 1px solid #778;
	border-bottom: none;
	background: #DDE;
	text-decoration: none;
}
.navlist li a:link {
	color: #448;
}
.navlist li a:visited {
	color: #667;
}
.navlist li a:hover {
	color: #000;
	background: #AAE;
	border-color: #227;
}
.navlist li a.current {
	background: white;
	border-bottom: 1px solid white;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body onLoad="onloading()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"></jsp:include>
		<jsp:include page="../share/menus.jsp" flush="true"></jsp:include>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="17" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Interest and Terms</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
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
<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
<tr>
<td>
<table width="40%" border="0" cellspacing="1" cellpadding="0" class="outertable" >
		<tr>
			<td width="20%" align="center" class="sub_tab_active">Margin</td>
			<td width="20%" align="center" class="sub_tab_inactive">
						<a href="javascript:callAgriProp('set_AgriParametersProperties.jsp')">Agri Properties</a>
			</td>			
		</tr>
		</table>
</td>
</tr>
</table>
	<table width="98%" border="1" cellspacing="0" cellpadding="2" class="outertable" align="center">
							<tr>
								<td colspan="4">
								<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
									<tr>
										<td width="25%"><b>Margin Amount Percentage</b></td>
										<td width="4%">&nbsp;</td>
										<td width="20%"> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"> </td>
									</tr>
									<tr>
										<td width="25%">Select Processing Amount Range</td>
										<td width="4%"></td>
										<td width="20%"> <select name="selectmarginterm" onChange="getMarginValue()" tabindex="10">
											<lapschoice:margintag pageid='C'/>
										</select> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"></td>
									</tr>
									<tr>
										<td width="25%">Amount Range From </td>
										<td width="4%">&nbsp;</td>
										<td width="20%"><input type="text" name="prd_procrangefrom"
											size="15" maxlength="15" tabindex="11" onKeyPress="allowNumber(this)"
											onBlur="roundtxt(this)" maxlength=""
											value="<%=strrangefrom%>" style=text-align:"right"></td>
										<td width="19%">Amount Range To</td>
										<td width="3%"></td>
										<td width="29%"><input type="text" name="prd_procrangeto"
											size="15" maxlength="15" tabindex="12" onKeyPress="allowNumber(this)"
											onBlur="roundtxt(this)" maxlength="" value="<%=strrangeto%>"
											style=text-align:"right"></td>
									</tr>
									<tr>

										<td width="25%">Margin
										Amount Percentage (%)</td>
										<td width="4%">&nbsp;</td>
										<td width="20%"> <input
											type="text" name="prd_procfees" size="8"
											onKeyPress="allowNumber(this)" maxlength="5"
											style="text-align:right" tabindex="13"
											value="<%=strpercentcharge%>" onBlur="checkPercentage(this)"> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"> </td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="hidSeldInsti" value=""> 
<% %>
<input type="hidden" name="prd_code1" value="<%=Helper.correctNull((String)request.getParameter("hidcorp_faccode"))%>">
<input type="hidden" name="prdcode" value="<%=Helper.correctNull((String)request.getParameter("fac_id")) %>"/>
<input type=hidden name="selperiod" value=""> 
<input type=hidden name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>"> 
<input type="hidden" name="checkApp" value="No">
<input type="hidden" name="checkApp1" value="null">
<input type=hidden name="hiddesc" value="">
<input type ="hidden" name ="hidkeyid" value="set">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">

<input type="hidden" name="prdRangeFrom" value="<%=Helper.correctNull((String)request.getParameter("prd_rng_from"))%>">
<input type="hidden" name="prdRangeTo" value="<%=Helper.correctNull((String)request.getParameter("prd_rng_to"))%>">
</form>
</body>
</html>
	
