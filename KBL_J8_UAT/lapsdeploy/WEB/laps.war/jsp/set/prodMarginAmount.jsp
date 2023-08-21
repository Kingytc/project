<%@ include file="../share/directives.jsp"%>
<%	ArrayList vecMargin = new ArrayList();
	String strrangefrom = "";
	String strrangeto = "";
	String strpercentcharge = "";
	String strpercentchargeSec="",strpercent_recur="",strpercent_allied="";
	if (hshValues != null) 
	{
	vecMargin = (ArrayList) hshValues.get("vecMarginRow");
	if (vecMargin != null && vecMargin.size() > 0) 
		{
		ArrayList vec = new ArrayList();
		vec = (ArrayList) vecMargin.get(0);
		if (vec != null) 
			{
			strrangefrom =  Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(2))));
			strrangeto =  Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(3))));
			strpercentcharge = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(4))));
			strpercentchargeSec = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(5))));
			strpercent_recur = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(6))));
			strpercent_allied = Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) vec.get(7))));
			}
		}
	}
	String strExp=Helper.correctNull((String)hshValues.get("strExp"));
	String strPurpose = Helper.correctNull((String) hshValues.get("strPurpose"));
  	String prdtype = Helper.correctNull((String) hshValues.get("hidProductType"));
  	String strVehitype = Helper.correctNull((String) hshValues.get("strvehitype"));
  	if(prdtype.equals(""))
  	{
  		prdtype  = Helper.correctNull((String)request.getParameter("hidProductType"));
  	}
  	if(prdtype.equals(""))
  	{
  		prdtype  = Helper.correctNull((String)request.getParameter("hidProducttype"));
  	}
  	String prd_cat=Helper.correctNull((String) hshValues.get("prd_catid"));
  	if(prd_cat.equals("")){
  		prd_cat=Helper.correctNull((String)request.getParameter("hidCatId"));
  	}
  	String agri_margin=Helper.correctNull((String) hshValues.get("prd_whetheragri"));
	if(agri_margin.equals("")){
		agri_margin=Helper.correctNull((String) hshValues.get("hidAgri"));
	}
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
var varprdtype = "<%=prdtype%>";
var varpurpose = "<%=strPurpose%>";
var varVehitype = "<%=strVehitype%>";
function onloading()
	{   
	strExp="<%=strExp%>";
	if(strExp!="")
		{
		alert(strExp);
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
			DisableButtons(false,true,true,false,false);			
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
	<%if(prdtype.equalsIgnoreCase("pG")){ %>
	document.forms[0].txt_avgmargin.readOnly=flag;
	document.forms[0].txt_latestmargin.readOnly=flag;
	<%} else{%>
	document.forms[0].prd_procfees.readOnly=flag;
	<%}%>
	<%if((prdtype.equalsIgnoreCase("pG"))&&(agri_margin.equalsIgnoreCase("Y")) )  { %>
	document.forms[0].txt_recurexpmargin.readOnly=flag;
	document.forms[0].txt_maragridevelop.readOnly=flag;
	<%}%>
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
	<%if(prdtype.equalsIgnoreCase("pG")){ %>
	document.forms[0].txt_avgmargin.value="";
	document.forms[0].txt_latestmargin.value="";
	<%} else{%>
	document.forms[0].prd_procfees.value="";
	<%}%>
	<%if((prdtype.equalsIgnoreCase("pG"))&&(agri_margin.equalsIgnoreCase("Y")) )  { %>
	document.forms[0].txt_recurexpmargin.value="";
	document.forms[0].txt_maragridevelop.value="";
	<%}%>
	
	
}
function onNew()
{	
	varRecordFlag="N";
	isnew="true";
	if(document.forms[0].checkApp.value=="No" || document.forms[0].checkApp.value=="null" || document.forms[0].checkApp.value=="")
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
		document.forms[0].hidBeanGetMethod.value="getMarginData";
		document.forms[0].action=appURL+"action/prodMarginAmount.jsp";
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
		document.forms[0].hiddesc.value = document.forms[0].selectmarginterm[document.forms[0].selectmarginterm.selectedIndex].value;
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getMarginData";
		document.forms[0].action=appURL+"action/prodMarginAmount.jsp";
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
<%if(prdtype.equalsIgnoreCase("pG")){ %>
	if(document.forms[0].txt_avgmargin.value=="0.00" || document.forms[0].txt_avgmargin.value=="")
	{
		alert("Please enter the Margin percentage of previous 30 days closing gold rates as per IBJA");
		document.forms[0].txt_avgmargin.focus();
		return;
	}
	if(document.forms[0].txt_latestmargin.value=="0.00"||document.forms[0].txt_latestmargin.value=="")
	{
		alert("Please enter the Margin percentage of last market rate as per IBJA ");
		document.forms[0].txt_latestmargin.focus();
		return;
	}
	<%}else{%>
	if(document.forms[0].prd_procfees.value=="")
	{
		alert("Please enter the Margin Percentage");
		return;
	}
	<%}%>
	<%if((prdtype.equalsIgnoreCase("pG"))&&(agri_margin.equalsIgnoreCase("Y")) )  { %>
	if(document.forms[0].txt_recurexpmargin.value=="0.00" ||document.forms[0].txt_recurexpmargin.value=="")
	{
		alert("Please enter the Margin percentage of the recurring expenses ");
		document.forms[0].txt_recurexpmargin.focus();
		return;
	}
	if(document.forms[0].txt_maragridevelop.value=="0.00"||document.forms[0].txt_maragridevelop.value=="")
	{
		alert("Please enter the Margin percentage for Allied Activities ");
		document.forms[0].txt_maragridevelop.focus();
		return;
	}
	<%}%>
	
	if((varprdtype=='pH' && varpurpose=='H') || (varprdtype=='pA' && varpurpose=='U') || (varprdtype=='pI')||(varprdtype=='pU' && varVehitype=='2'))
	{
		
	}
	else
	{
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
	document.forms[0].hidBeanGetMethod.value="updateMarginData";
	document.forms[0].action=appURL+"action/prodMarginAmount.jsp";
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
		document.forms[0].hidBeanGetMethod.value="updateMarginData";
		document.forms[0].hidSourceUrl.value="/action/prodMarginAmount.jsp";
		document.forms[0].method="post";			
		document.forms[0].submit();	
		}
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
<form name="prdinterestfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<lapstab:setproductstab tabid="10" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Margin Amount</td>
	</tr>	
</table><br>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<fieldset>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td><lapschoice:products /></td>
	</tr>
</table>
</fieldset>
</td>
</tr>
</table><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable border1">
							<tr>
								<td colspan="4">
								<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
									<tr>
										<td width="25%"><b>Margin Amount Percentage</b></td>
										<td width="4%">&nbsp;</td>
										<td width="20%"> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"> </td>
									</tr>
									<tr>
										<% if(prdtype.equalsIgnoreCase("pH") && strPurpose.equals("H")){ %>

										<td width="25%">Select Age of the Premises</td>
										
										<% }else if(prdtype.equalsIgnoreCase("pA") && strPurpose.equals("U")){ %>
										
										<td width="25%">Select Age of the Vehicle</td>
																				
										<%}else if(prdtype.equalsIgnoreCase("pI")){%>
										
										<td width="25%">Select Maturity Period</td>							
										<%}else if(prdtype.equalsIgnoreCase("pU") && strVehitype.equals("2")){%>
										
										<td width="25%">Select Age of the Vehicle</td>							
										<%}else{ %>				
																
										<td width="25%">Select Processing Amount Range</td>
										
										<%} %>
										<td width="4%"></td>
										<td width="20%"> <select name="selectmarginterm" onChange="getMarginValue()" tabindex="10">
											<lapschoice:margintag pageid='P'/>
										</select> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"></td>
									</tr>
									
									<%if(prdtype.equalsIgnoreCase("pH") && strPurpose.equals("H")){ %>
									<tr>
										<td width="25%">Age of the Premises Range From </td>
										<td width="4%">&nbsp;</td>
										<td width="20%"><input type="text" name="prd_procrangefrom"
											size="15" maxlength="3" tabindex="11" onKeyPress="allowNumber(this)"
											value="<%=strrangefrom%>" style=text-align:"right"></td>
										<td width="19%">Age of the Premises Range To</td>
										<td width="3%"></td>
										<td width="29%"><input type="text" name="prd_procrangeto"
											size="15" maxlength="3" tabindex="12" onKeyPress="allowNumber(this)"
											value="<%=strrangeto%>"
											style=text-align:"right"></td>
									</tr>
									
									<%}else if(prdtype.equalsIgnoreCase("pA") && strPurpose.equals("U")){ %>
									<tr>
										<td width="25%">Age of the Vehicle Range From  </td>
										<td width="4%">&nbsp;</td>
										<td width="20%"><input type="text" name="prd_procrangefrom"
											size="15" maxlength="3" tabindex="11" onKeyPress="allowNumber(this)"
											onBlur="" maxlength=""
											value="<%=strrangefrom%>" style=text-align:"right"></td>
										<td width="19%">Age of the Vehicle Range To</td>
										<td width="3%"></td>
										<td width="29%"><input type="text" name="prd_procrangeto"
											size="15" maxlength="3" tabindex="12" onKeyPress="allowNumber(this)"
											onBlur="" maxlength="" value="<%=strrangeto%>"
											style=text-align:"right"></td>
									</tr>
									<%}else if(prdtype.equalsIgnoreCase("pI")){ %>
									<tr>
									<td width="25%">Maturity Period Range From</td>
									<td width="4%">&nbsp;</td>
									<td width="20%"><input type="text" name="prd_procrangefrom"
										size="15" maxlength="3" tabindex="11" onKeyPress="allowNumber(this)"
										onBlur="" maxlength=""
										value="<%=strrangefrom%>" style=text-align:"right"></td>
									<td width="19%">Maturity Period Range To</td>
									<td width="3%"></td>
									<td width="29%"><input type="text" name="prd_procrangeto"
										size="15" maxlength="3" tabindex="12" onKeyPress="allowNumber(this)"
										onBlur="" maxlength="" value="<%=strrangeto%>"
										style=text-align:"right"></td>
								</tr>
								<%}else if(prdtype.equalsIgnoreCase("pU") && strVehitype.equals("2")){ %>
								<tr>
								<td width="25%">Age of the Vehicle Range From  </td>
								<td width="4%">&nbsp;</td>
								<td width="20%"><input type="text" name="prd_procrangefrom"
									size="15" maxlength="3" tabindex="11" onKeyPress="allowNumber(this)"
									onBlur="" maxlength=""
									value="<%=strrangefrom%>" style=text-align:"right"></td>
								<td width="19%">Age of the Vehicle Range To</td>
								<td width="3%"></td>
								<td width="29%"><input type="text" name="prd_procrangeto"
									size="15" maxlength="3" tabindex="12" onKeyPress="allowNumber(this)"
									onBlur="" maxlength="" value="<%=strrangeto%>"
									style=text-align:"right"></td>
							</tr>
							<%}else{ %>	
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
									<%} %>
									<%if(prdtype.equalsIgnoreCase("pG")){ %>
									<tr>
										<td  width="25%" colspan="2" nowrap="nowrap">
											Margin percentage of last market rate as per IBJA 
										</td>
										<td  width="25%" nowrap="nowrap">
											<input type="text" name="txt_latestmargin" tabindex="11" size="10" maxlength="5" value="<%=strpercentcharge%>"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
										</td>
										<td  width="25%" colspan="2">
											Margin percentage of previous 30 days closing gold rates as per IBJA 
										</td>
										<td  width="20%" nowrap="nowrap">
											<input type="text" name="txt_avgmargin" tabindex="11" size="10" maxlength="5" value="<%=strpercentchargeSec%>"
											onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);roundtxt(this);" style="text-align: right">&nbsp;(%)
										</td>
									</tr>
									<%}else{ %>
									<tr>
										<td width="25%">Margin
										Amount Percentage (%)</td>
										<td width="4%">&nbsp;</td>
										<td width="20%"> <input
											type="text" name="prd_procfees" size="8"
											onKeyPress="allowNumber(this)" maxlength="5"
											style="text-align:right" tabindex="13"
											value="<%=strpercentcharge%>" onBlur="checkPercentage(this);roundtxt(this);"> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"> </td>
									</tr>
									<%} %>
									<%if((prdtype.equalsIgnoreCase("pG"))&&(agri_margin.equalsIgnoreCase("Y")) )  { %>
									<tr>
										<td width="25%" colspan="2">
											Margin percentage of the recurring expenses
										</td>
										<td  width="20%" nowrap="nowrap">
											<input type="text" name="txt_recurexpmargin" tabindex="10" size="10" maxlength="5" value="<%=strpercent_recur%>"
											onKeyPress="allowNumber(this)" style="text-align: right" onBlur="checkPercentage(this);roundtxt(this);">&nbsp;(%)
										</td>
										
										<td width="25%" colspan="2">
											Margin percentage for Allied Activities
										</td>
										<td  width="20%" nowrap="nowrap">
											<input type="text" name="txt_maragridevelop" tabindex="11" size="10" maxlength="5" value="<%=strpercent_allied%>"
											onKeyPress="allowNumber(this)" style="text-align: right" onBlur="checkPercentage(this);roundtxt(this);">&nbsp;(%)
										</td>
									</tr>
									<%} %>
									
									<tr></tr>
									<%if(prdtype.equalsIgnoreCase("pI")){ %>
									<tr>

										<td width="25%">Margin
										Amount Percentage for Other Securities (%)</td>
										<td width="4%">&nbsp;</td>
										<td width="20%"> <input
											type="text" name="prd_procfees_othersec" size="8"
											onKeyPress="allowNumber(this)" maxlength="5"
											style="text-align:right" tabindex="13"
											value="<%=strpercentchargeSec%>" onBlur="checkPercentage(this);roundtxt(this);"> </td>
										<td width="19%">&nbsp;</td>
										<td width="3%"></td>
										<td width="29%"> </td>
									</tr>
									<%} %>
								</table>
								</td>
							</tr>
						</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="hidSeldInsti" value=""> 
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
<input type=hidden name="selperiod" value=""> 
<input type=hidden name="hidId" value="<%=Helper.correctNull((String)hshValues.get("hidId"))%>"> 
<input type="hidden" name="checkApp" value="<%=Helper.correctNull((String)request.getParameter("checkApp"))%>">
<input type=hidden name="hiddesc" value="">
<input type ="hidden" name ="hidkeyid" value="set">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<input type=hidden name="hidCatId" value="<%=Helper.correctNull((String) hshValues.get("prd_catid"))%>">
<input type=hidden name="hidAgri" value="<%=Helper.correctNull((String) hshValues.get("prd_whetheragri")) %>">
</form>
</body>
</html>






