 <%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Insert title here</title>
</head>
<script language="javaScript" 	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
<script type="text/javascript">
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var varSubCategory="<%=Helper.correctNull((String) hshValues.get("PM_SUBCATID"))%>";
var varMaincategory="<%=Helper.correctNull((String) hshValues.get("PM_MAIN_CATEGORY"))%>";
var varFemaleOwn="<%=Helper.correctNull((String) hshValues.get("PM_FEMALE_OWNERSHIP"))%>";
var varNRIElig="<%=Helper.correctNull((String) hshValues.get("PM_NRI_BORROWER"))%>";
var varExtension="<%=Helper.correctNull((String) hshValues.get("PM_ELIGIBILITY_HOMEEXT"))%>";
var varAadharChk="<%=Helper.correctNull((String) hshValues.get("PM_AADHAR_MANDATORY"))%>";
var varSelectType="<%=Helper.correctNull((String) hshValues.get("PM_ACTIVE_TYPE"))%>";
function loadPage(){
	
	document.forms[0].select_category.value=varMaincategory;
	document.forms[0].sel_pmay.value=varSubCategory;
	document.forms[0].sel_female.value=varFemaleOwn;
	document.forms[0].sel_eligible.value=varNRIElig;
	document.forms[0].sel_xtension.value=varExtension;
	document.forms[0].sel_Aadhar.value=varAadharChk;
	document.forms[0].sel_active.value=varSelectType;
	disablefields(true);
	document.all.category.style.visibility="hidden";
	document.all.category.style.position="absolute";
	document.forms[0].sel_pmay.disabled=false;
	document.forms[0].select_category.disabled=false;
	callDisableControls(false,true,true,true,false);
	callValues('N');

	
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
	}
}
function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
   		document.forms[0].hidBeanGetMethod.value="getPayMaster";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/set_PMAYMaster.jsp";	
		document.forms[0].submit();
	}
}

function doEdit()
{   
	document.forms[0].hidAction.value="update";
	document.all.category.style.visibility="visible";
	document.all.category.style.position="relative";
	 disablefields(false);
	 callDisableControls(true,false,false,false,false);
   
}

function doSave()
{	


	if(document.forms[0].select_category.value=="")
	{
		ShowAlert(111,'Category');
		document.forms[0].select_category.focus();
		return;
	}

	if(document.forms[0].sel_pmay.value=="")
	{
		ShowAlert(111,'Sub_Category');
		document.forms[0].sel_pmay.focus();
		return;
	}
	//if(document.forms[0].sel_pmay.value=="0")
	{
		if(document.forms[0].txt_cat.value=="")
		{
			ShowAlert(121,'Sub_Category');
			document.forms[0].txt_cat.focus();
			return;
		}
	}
	if(document.forms[0].txt_income.value=="")
	{
		ShowAlert(121,'FAMILY ANNUAL INCOME (TOTAL)');
		document.forms[0].txt_income.focus();
		return;
	}

	if(document.forms[0].sel_female.value=="")
	{
		ShowAlert(111,'FEMALE OWNERSHIP');
		document.forms[0].sel_female.focus();
		return;
	}

	if(document.forms[0].txt_subsidy.value=="")
	{
		ShowAlert(121,'LOAN AMOUNT ELIGIBLE FOR SUBSIDY');
		document.forms[0].txt_subsidy.focus();
		return;
	}

	if(document.forms[0].txt_subinterest.value=="")
	{
		ShowAlert(121,'INTEREST SUBSIDY');
		document.forms[0].txt_subinterest.focus();
		return;
	}
	
	if(document.forms[0].txt_maxloan.value=="")
	{
		ShowAlert(121,'MAX. LOAN TENURE FOR INTEREST SUBSIDY');
		document.forms[0].txt_maxloan.focus();
		return;
	}

	if(document.forms[0].txt_area.value=="")
	{
		ShowAlert(121,'AREA OF THE HOUSE- CARPET AREA ');
		document.forms[0].txt_area.focus();
		return;
	}

	if(document.forms[0].sel_eligible.value=="")
	{
		ShowAlert(111,'WHETHER NRI BORROWER IS ELIGIBLE ');
		document.forms[0].sel_eligible.focus();
		return;
	}

	if(document.forms[0].sel_xtension.value=="")
	{
		ShowAlert(111,'WHETHER SCHEME IS ELIGIBLE FOR EXTENSION OF HOUSE ');
		document.forms[0].sel_xtension.focus();
		return;
	}

	if(document.forms[0].txt_fromdate.value=="")
	{
		ShowAlert(121,'SCHEME FROM PERIOD ');
		document.forms[0].txt_fromdate.focus();
		return;
	}

	if(document.forms[0].txt_todate.value=="")
	{
		ShowAlert(121,'SCHEME TO PERIOD ');
		document.forms[0].txt_todate.focus();
		return;
	}

	if(document.forms[0].txt_maxsub.value=="")
	{
		ShowAlert(121,'Maximum Subsidy');
		document.forms[0].txt_maxsub.focus();
		return;
	}

	if(document.forms[0].sel_Aadhar.value=="")
	{
		ShowAlert(111,'Aadhar mandatory');
		document.forms[0].sel_Aadhar.focus();
		return;
	}
	if(document.forms[0].sel_active.value=="")
	{
		ShowAlert('111','Active');
		document.forms[0].sel_active.focus();
		return;
	}
	
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatePayMaster";
	document.forms[0].hidBeanGetMethod.value="getPayMasterData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/set_PMAYMaster.jsp";
	document.forms[0].submit();

}

function callCalender(fname)
{
		showCal(appURL,fname);
}
function callperType() {
	if(document.forms[0].sel_pmay.value=="")
		{
		document.forms[0].sel_pmay.value="";
		document.forms[0].sel_female.value="";
		document.forms[0].sel_eligible.value="";
		document.forms[0].sel_xtension.value="";
		document.forms[0].sel_Aadhar.value="";

		document.forms[0].txt_cat.value="";
		document.forms[0].txt_income.value="";
		document.forms[0].txt_subsidy.value="";
		document.forms[0].txt_subinterest.value="";
		document.forms[0].txt_maxloan.value="";
		document.forms[0].txt_area.value="";
		document.forms[0].txt_fromdate.value="";
		document.forms[0].txt_todate.value="";
		document.forms[0].txt_maxsub.value="";
		
		document.all.category.style.visibility="hidden";
		document.all.category.style.position="absolute";
		disablefields(false);
		callDisableControls(true,true,true,false,false);
		}
	else if(document.forms[0].sel_pmay.value=="0")
		{	
			document.forms[0].sel_pmay.value="0";
			document.forms[0].sel_female.value="";
			document.forms[0].sel_eligible.value="";
			document.forms[0].sel_xtension.value="";
			document.forms[0].sel_Aadhar.value="";

			document.forms[0].txt_cat.value="";
			document.forms[0].txt_income.value="";
			document.forms[0].txt_subsidy.value="";
			document.forms[0].txt_subinterest.value="";
			document.forms[0].txt_maxloan.value="";
			document.forms[0].txt_area.value="";
			document.forms[0].txt_fromdate.value="";
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_maxsub.value="";
			
			document.all.category.style.visibility="visible";
			document.all.category.style.position="relative";
	     	document.forms[0].hidAction.value="insert";
			disablefields(false);
			callDisableControls(true,false,true,false,true);
		}
	
		else
		{		
			document.forms[0].hidBeanId.value="perDeviation";
			document.forms[0].hidBeanGetMethod.value="getPayMasterData";
			document.forms[0].action=appURL+"action/set_PMAYMaster.jsp";
			document.forms[0].submit();
		}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		disablefields(false);
     	document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updatePayMaster";
	    document.forms[0].hidBeanGetMethod.value="getPayMasterData";
		document.forms[0].hidSourceUrl.value="/action/set_PMAYMaster.jsp";
		document.forms[0].submit();
	}
}
function callValues(flag) {
	var varType = document.forms[0].select_category.value;
	if(flag=="Y")
	{
		document.forms[0].txt_cat.value="";
		document.forms[0].txt_income.value="";
		document.forms[0].txt_subsidy.value="";
		document.forms[0].txt_subinterest.value="";
		document.forms[0].txt_maxloan.value="";
		document.forms[0].txt_area.value="";
		document.forms[0].txt_fromdate.value="";
		document.forms[0].txt_todate.value="";
		document.forms[0].txt_maxsub.value="";
		document.forms[0].sel_female.value="";
		document.forms[0].sel_eligible.value="";
		document.forms[0].sel_xtension.value="";
		document.forms[0].sel_Aadhar.value="";
		document.all.category.style.visibility="hidden";
		document.all.category.style.position="absolute";
	}
	if(varType!="")
	{
		document.all.iframe_setPmay.src = appURL+"action/iframe_setPmay.jsp?hidBeanGetMethod=getPmayClassification&hidBeanId=perDeviation&strPageFrom=Master&classificationtype="+ varType+"&strSubCategory="+varSubCategory;
	}
}

</script>
<body onload="loadPage()">
<form class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Other Setup -&gt;
		PMAY Master</td>
	</tr>
</table>
<br>
<br>
				<table width="70%" border="0" align="center" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr class="header">
							<td colspan="2" class="dataheader" align="center" ><b>PMAY
								Master</b></td>
							</tr>
							<tr class="datagrid">
								<td width="50%">Category </td>
								<td width="50%"><select name="select_category" tabindex="1" onchange="callValues('Y');">
									<option value="">----Select----</option>
									<option value="078">PMAY(EWS/LIG)</option>
									<option value="079">PMAY(MIG)</option>
									</select></td></tr>
							<tr class="datagrid">
								<td width="50%"><span
									id="select">Select Sub Category</span></td>
								<td width="50%"><select name="sel_pmay" tabindex="1" onchange="callperType();" >
															<option value="">--Select--</option>	
															<option value="0">--new--</option>	
								</select></td>
							</tr>
											
						<tr id="category" class="datagrid">
								<td width="50%">Enter Sub_Category</td>
								<td width="50%"><input type="text" name="txt_cat" 	onKeyPress="notAllowSplChar1(this);"
								value="<%=Helper.correctNull((String) hshValues.get("PM_SUBCATEGORY"))%>"/> </td>
								
							</tr>
							<tr id="grid"   class="datagrid" >
								<td width="50%">FAMILY ANNUAL INCOME (TOTAL)</td>
								<td width="50%"><input type="text" name="txt_income" onKeyPress="allowNumber(this)" style="text-align: right" onblur="roundtxt(this);"
								value="<%=Helper.correctNull((String) hshValues.get("PM_SUBCATEGORYFAMILY_INCOME"))%>"/> </td></tr>
								
								<tr    class="datagrid">
								<td width="50%">FEMALE OWNERSHIP </td>
								<td width="50%"><select name="sel_female" tabindex="1" style="width:100px">
									<option value="">----Select----</option>
									<option value="Y">Mandatory</option>
									<option value="N">Optional</option>
									</select> </td></tr>
									
								<tr    class="datagrid">
								<td width="50%">LOAN AMOUNT ELIGIBLE FOR SUBSIDY</td>
								<td width="50%"><input type="text" name="txt_subsidy" onKeyPress="allowNumber(this)" style="text-align: right" onblur="roundtxt(this);"
								value="<%=Helper.correctNull((String) hshValues.get("PM_LOAN_SUBSIDY"))%>"/> </td></tr>
								
								<tr   class="datagrid">
								<td width="50%">INTEREST SUBSIDY</td>
								<td width="50%"><input type="text" name="txt_subinterest" onKeyPress="allowNumber(this)" style="text-align: right" onblur="roundtxt(this);checkPercentage(this)"
								value="<%=Helper.correctNull((String) hshValues.get("PM_INTEREST_SUBSIDY"))%>"/> </td></tr>
								
								<tr    class="datagrid">
								<td width="50%">MAX. LOAN TENURE FOR INTEREST SUBSIDY</td>
								<td width="50%"><input type="text" name="txt_maxloan" style="text-align: right" 
								value="<%=Helper.correctNull((String) hshValues.get("PM_MAXLOAN_TENOR"))%>" onkeypress="allowInteger()"/>&nbsp;&nbsp;(Months) </td></tr>
								
								<tr    class="datagrid">
								<td width="50%">AREA OF THE HOUSE- CARPET AREA </td>
								<td width="50%"><input type="text" name="txt_area" style="text-align: right" onkeypress="allowNumber(this)"
								value="<%=Helper.correctNull((String) hshValues.get("PM_AREA"))%>"/>&nbsp;&nbsp;(Sq.Mt) </td></tr>
								
								<tr    class="datagrid">
								<td width="50%">WHETHER NRI BORROWER IS ELIGIBLE </td>
								<td width="50%"><select name="sel_eligible" tabindex="1">
									<option value="">----Select----</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select> 
								</td></tr>
								
								<tr    class="datagrid">
								<td width="50%">WHETHER SCHEME IS ELIGIBLE FOR  EXTENSION OF HOUSE  </td>
								<td width="50%"><select name="sel_xtension" tabindex="1">
									<option value="">----Select----</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									<option value="NA">Not Applicable</option>
									</select>
								</td></tr>
								
								<tr    class="datagrid">
								<td width="50%">SCHEME PERIOD </td>
								<td width="50%">
					<table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" id="idMember">
								<tr align="center" class="dataheader">
								<td  width="50%">FROM</td>
								<td  width="50%">TO</td></tr>
							<tr   align="center" class="datagrid">
							<td><input type="text" name="txt_fromdate" size="11"
							onBlur="checkDate(this);" maxlength="10" tabindex="15" 
							value="<%=Helper.correctNull((String) hshValues.get("PM_FROM_DATE"))%>">
		    				<a alt="Select date from calender" 	onClick="callCalender('txt_fromdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>	</td>						
							
							<td><input type="text" name="txt_todate" size="11"
							onBlur="checkDate(this);" maxlength="10" tabindex="15" 
							value="<%=Helper.correctNull((String) hshValues.get("PM_FINISH_DATE"))%>">
		    				<a alt="Select date from calender" 	onClick="callCalender('txt_todate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>
								</td></tr></table>
								
								
								<tr    class="datagrid">
								<td width="50%"> Maximum Subsidy</td>
								<td width="50%"><input type="text" name="txt_maxsub" onKeyPress="allowNumber(this)" style="text-align: right" onblur="roundtxt(this);"
								value="<%=Helper.correctNull((String) hshValues.get("PM_MAX_SUBSIDY"))%>"/> </td></tr>
								
								<tr    class="datagrid">
								<td width="50%">Aadhar mandatory </td>
								<td width="50%"><select name="sel_Aadhar" tabindex="1">
									<option value="">----Select----</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select> 
								</td>
							</tr>
							<tr class="datagrid">
                                   <td>Active</td>
				                   <td><select name="sel_active" style="width: 100px">
				                   <option value="">--Select--</option>
				                   <option value="E">Enable</option>
				                   <option value="D">Disable</option>
				                 </select>
				                  </td> 
                                  </tr>
				</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid="<%=PageId%>" />
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String) hshValues.get("PM_SUBCATID"))%>">
<input type="hidden" name="hidnmbr" value="">
<iframe height="0" width="0" id="iframe_setPmay" frameborder=0 style="border: 0"></iframe>
</form>
</body>
</html>