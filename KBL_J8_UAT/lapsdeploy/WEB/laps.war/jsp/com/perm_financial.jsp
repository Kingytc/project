    <%@include file="../share/directives.jsp"%>
    <%
	String strpermission_Freezeflag =Helper.correctNull((String)session.getAttribute("strpremission_freezeflag")).trim();
    
    %>
<html>
<head>
<title>Financial</title>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varyear1="<%=Helper.correctNull((String)hshValues.get("txt_year1"))%>";	
var varyear2="<%=Helper.correctNull((String)hshValues.get("txt_year2"))%>";	
var varyear3="<%=Helper.correctNull((String)hshValues.get("txt_year3"))%>";	
var varyear4="<%=Helper.correctNull((String)hshValues.get("txt_year4"))%>";	
var varyear5="<%=Helper.correctNull((String)hshValues.get("txt_year5"))%>";	
var varcombo1="<%=Helper.correctNull((String)hshValues.get("combo1"))%>";	
var varcombo2="<%=Helper.correctNull((String)hshValues.get("combo2"))%>";	
var varcombo3="<%=Helper.correctNull((String)hshValues.get("combo3"))%>";	
var varcombo4="<%=Helper.correctNull((String)hshValues.get("combo4"))%>";	
var varcombo5="<%=Helper.correctNull((String)hshValues.get("combo5"))%>";	
var amtType="<%=Helper.correctNull((String)hshValues.get("PERM_AMTTYPE"))%>";	
var App_exist="<%=Helper.correctNull((String)hshValues.get("Financial_Exist"))%>";

var varpermission_Freezeflag="<%=strpermission_Freezeflag%>";


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
	}
}
function onload()
{
	disablefields(true);
	
	document.forms[0].sel_amtType.value=amtType;
	if(varcombo1!="" && App_exist=="Y" )
		document.forms[0].combo1.value=varcombo1;
	else
		document.forms[0].combo1.value="S";

	if(varcombo2!="" && App_exist=="Y" )
		document.forms[0].combo2.value=varcombo2;
	else
		document.forms[0].combo2.value="S";

	if(varcombo3!="" && App_exist=="Y" )
		document.forms[0].combo3.value=varcombo3;
	else
		document.forms[0].combo3.value="S";

	if(varcombo4!="" && App_exist=="Y" )
		document.forms[0].combo4.value=varcombo4;
	else
		document.forms[0].combo4.value="S";

	if(varcombo5!="" && App_exist=="Y" )
		document.forms[0].combo5.value=varcombo5;
	else
		document.forms[0].combo5.value="S";
//===========for years
	
	if(varyear1!="" && App_exist=="Y" )
		document.forms[0].txt_year1.value=varyear1;
	else
		document.forms[0].txt_year1.value="";

	if(varyear2!="" && App_exist=="Y" )
		document.forms[0].txt_year2.value=varyear2;
	else
		document.forms[0].txt_year2.value="";

	if(varyear3!="" && App_exist=="Y" )
		document.forms[0].txt_year3.value=varyear3;
	else
		document.forms[0].txt_year3.value="";

	if(varyear4!="" && App_exist=="Y" )
		document.forms[0].txt_year4.value=varyear4;
	else
		document.forms[0].txt_year4.value="";

	if(varyear5!="" && App_exist=="Y" )
		document.forms[0].txt_year5.value=varyear5;
	else
		document.forms[0].txt_year5.value="";
	
	var AssessmentParam=document.forms[0].hidassessment.value;
	var FinancialParam=document.forms[0].hidfinancial.value;
	if(AssessmentParam=="Y")
	{
		document.all.idAssessment.style.display="table-cell";
	}
	else
	{
		document.all.idAssessment.style.display="none";
	}
	if(FinancialParam=="Y")
	{
		document.all.idFinancial.style.display="table-cell";
	}
	else
	{
		document.all.idFinancial.style.display="none";
	}

	
}

function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}else{
		alert("Enable the edit Mode");
	}
}

function disablebutton(Edit,Save,Delete,Close,Cancel){
	
	document.forms[0].cmdedit.disabled=Edit;
	document.forms[0].cmdsave.disabled=Save;
	document.forms[0].cmdclose.disabled=Close;
	document.forms[0].cmddelete.disabled=Delete;
	document.forms[0].cmdcancel.disabled=Cancel;
}
function doEdit()
{
	disablebutton(true, false, false, false,false);
	disablefields(false);
}
function doClose()
{
   if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/mainnav.jsp";
		 document.forms[0].submit();
	 }
}

function doSave()
{	
	if(document.forms[0].sel_amtType.value=="selected" ||document.forms[0].sel_amtType.value=="")
	{
		alert("Please Select All Values are in ");
		return false;
	}
	/*if(document.forms[0].txt_year1.value=="" ||document.forms[0].txt_year1.value==null)
	{
		alert("Please Enter Particulars of YEAR-1 ");
		return false;
		}
	if(document.forms[0].combo1.value=="S" ||document.forms[0].combo1.value=="")
	{
		alert("Please Select DropDown of YEAR-1 ");
		return false;
		}
	if(document.forms[0].txt_year2.value=="" ||document.forms[0].txt_year2.value==null)
	{
		alert("Please Enter Particulars of YEAR-2 ");
		return false;
		}
	if(document.forms[0].combo2.value=="S" ||document.forms[0].combo2.value=="")
	{
		alert("Please Select DropDown of YEAR-2 ");
		return false;
		}
	if(document.forms[0].txt_year3.value=="" ||document.forms[0].txt_year3.value==null)
	{
		alert("Please Enter Particulars of YEAR-3 ");
		return false;
		}
	if(document.forms[0].combo3.value=="S" ||document.forms[0].combo3.value=="")
	{
		alert("Please Select DropDown of YEAR-3 ");
		return false;
		}
	if(document.forms[0].txt_year4.value=="" ||document.forms[0].txt_year4.value==null)
	{
		alert("Please Enter Particulars of YEAR-4 ");
		return false;
		}
	if(document.forms[0].combo4.value=="S" ||document.forms[0].combo4.value=="")
	{
		alert("Please Select DropDown of YEAR-4 ");
		return false;
		}
	if(document.forms[0].txt_year5.value=="" ||document.forms[0].txt_year5.value==null)
	{
		alert("Please Enter Particulars of YEAR-5 ");
		return false;
		}
	if(document.forms[0].combo5.value=="S" ||document.forms[0].combo5.value=="")
	{
		alert("Please Select DropDown of YEAR-5 ");
		return false;
		}*/
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateFinancial";					
	document.forms[0].hidBeanGetMethod.value="getdataFinancial";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="action/perm_financial.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updateFinancial";					
	document.forms[0].hidBeanGetMethod.value="getdataFinancial";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="action/perm_financial.jsp";
	document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanGetMethod.value="getdataFinancial";
	document.forms[0].action=appURL+"action/perm_financial.jsp";
	document.forms[0].submit();
	}
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		if(page=="permissiongist_addDetails.jsp" && varpermission_Freezeflag!="Y")
		{	
		 	alert("Kindly click on freeze button in Permission Tab");
			return;
		}
		else
		{
			document.forms[0].hidAction.value="";
		 	document.forms[0].hidBeanGetMethod.value=method;
		 	document.forms[0].hidBeanId.value=bean;
		 	document.forms[0].action=appURL+"action/"+page;
		 	document.forms[0].submit();
		}	
	}
	else 
	{
		ShowAlert(103);
		return;
	}
	
}	
</script>

</head>
<body onload="onload()">
<form method="post">
<jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
<tr>
<td class="page_flow">Home -&gt;Permission -&gt; General Info  -&gt; Financial 
</td>
</tr>
</table>
<lapschoice:ApplDevHeaderTag />
<table width="100%">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin" nowrap width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_gist.jsp','perDeviation','getPermissionGistData')">Permission Gist</a></b></td>
			<td class="sub_tab_inactive" id="more_det" align="center" width="250px;"><b><a href="#" onclick="javascript:callLink('permissiongist_addDetails.jsp','perDeviation','getPermissionGistMoreDet')">Permission Gist- More Information</a></b></td>	
			<td class="sub_tab_inactive" id="prin" align="center" width="200px;"><b><a	href="#" onclick="javascript:callLink('perm_appbackground_info.jsp','perDeviation','get_PermApplBackgroundData')">Background of the Applicant</a></b></td>
			<td class="sub_tab_inactive" id="idAssessment" width="200px" align="center"><b><a href="#" onclick="javascript:callLink('perdeviationassessment.jsp','perDeviation','getAssessment')">Interest concession Assessment</a></b></td>
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a href="#" onclick="javascript:callLink('permission_parameters.jsp','perDeviation','getPermissionData')">Permission Parameters</a></b></td>
			<td class="sub_tab_active" id="idFinancial" width="200px;" align="center"><b>Gist of Balance Sheet Analysis</b></td>
			</table>
  			</td>
  		</tr>
  </table>
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:1; left: 521px; top: 300px">
<img src="<%=ApplicationParams.getAppUrl()%>img/finloader.gif"></div>


<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		
		<table width="99%" border="0" align="center" cellspacing="1" cellpadding="3" class="outertable">
		<tr><td colspan="5">&nbsp;</td><td>All Values are in.<span class="mantatory">*</span></td><td><select name="sel_amtType">
			<option value="selected">--Select--</option>
			<option value="Rs.">Rs.</option>
			<option value="Lakhs">Lakhs</option>
			<option value="Crore">Crore</option>
			</select>
			</td>
			</tr>
					<tr class="dataheader">
						<td colspan="2" align="center">&nbsp;<b>Particulars</b></td>
						<td width="10%" align="center"><input type="text" name="txt_year1"
							size="13" maxlength="12"  border="1" value=""
							onBlur="checkDate(txt_year1);checkmindate(this,document.forms[0].txt_year1.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');"> 
							<a alt="Select date from calender" href="#"
									onClick="callCalender('txt_year1')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
						<td width="10%" align="center"><input type="text" name="txt_year2"
							size="13" maxlength="12"  border="1"
							 value=""
							onBlur="checkDate(txt_year2);checkmindate(this,document.forms[0].txt_year2.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;">
							 <a alt="Select date from calender" href="#"
									onClick="callCalender('txt_year2')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
						<td width="10%" align="center"><input type="text" name="txt_year3"
							size="13" maxlength="12"  border="1"
							 value=""
							onBlur="checkDate(txt_year3);checkmindate(this,document.forms[0].txt_year3.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;"> 
							<a alt="Select date from calender" href="#"
									onClick="callCalender('txt_year3')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
						<td width="10%" align="center"><input type="text" name="txt_year4"
							size="13" maxlength="12"  border="1"
							 value=""
							onBlur="checkDate(txt_year4);checkmindate(this,document.forms[0].txt_year4.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');;">
							<a alt="Select date from calender" href="#"
									onClick="callCalender('txt_year4')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
						<td width="10%" align="center"><input type="text" name="txt_year5"
							size="13" maxlength="12" style=" border-style=groove" border="1"
							 value=""
							onBlur="checkDate(txt_year5);checkmindate(this,document.forms[0].txt_year5.value);" readOnly="readonly" onkeydown="funfinancialYrCheck(this,'Y');">
							<a alt="Select date from calender" href="#"
									onClick="callCalender('txt_year5')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>					
					</tr>
					
					<tr class="dataheader">
						<td colspan="2">&nbsp;</td>
						<td width="14%" align="center"><select name="combo1" onChange="">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="u">Unaudited</option>
							<option value="e">Estimated</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="13%" align="center"><select name="combo2" onChange="">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="u">Unaudited</option>
							<option value="e">Estimated</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo3" onChange="">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="u">Unaudited</option>
							<option value="e">Estimated</option>
							<option value="p">Projection</option>
						</select></td>
						<td width="14%" align="center"><select name="combo4" onChange="">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="u">Unaudited</option>
							<option value="e">Estimated</option>
							<option value="p">Projection</option>
						</select></td>

						<td width="13%" align="center"><select name="combo5" onChange="">
							<option value="S" selected="selected">--Select--</option>
							<option value="a">Audited</option>
							<option value="e">Estimated</option>
							<option value="u">Unaudited</option>
							<option value="p">Projection</option>
						</select></td>
						
					</tr>
	                <tr class="datagrid">
	                <td colspan="2" id="Capital"><b>Capital</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row1c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row1c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
					 <td  width="10%" align="center">
	                <input type="text" name="row1c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row1c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row1c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row1c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row1c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row1c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row1c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row1c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
	                
					</tr>	
					
					<tr class="datagrid">
	                <td colspan="2" id="Networth"><b>Networth</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row2c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row2c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row2c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row2c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row2c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row2c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row2c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row2c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row2c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row2c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
							</tr>
							
				<tr class="datagrid">
	                <td colspan="2" id="Sales/Turnover"><b>Sales/Turnover</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row3c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row3c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row3c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row3c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row3c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row3c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row3c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row3c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row3c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row3c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>
							
				<tr class="datagrid">
	                <td colspan="2" id="Sundry_Creditors"><b>Sundry Creditors</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row4c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row4c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row4c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row4c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row4c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row4c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row4c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row4c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row4c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row4c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>
							
							<tr class="datagrid">
	                <td colspan="2" id="Sundry_Debtors"><b>Sundry Debtors</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row5c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row5c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row5c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row5c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row5c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row5c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row5c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row5c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row5c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row5c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>
							
							
				<tr class="datagrid">
	                <td colspan="2" id="Tangible_Networth"><b>Tangible Networth</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row6c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row6c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row6c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row6c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row6c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row6c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row6c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row6c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row6c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row6c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>			

 					<tr class="datagrid">
	                <td id="TOL:TNW" colspan="2"><b>TOL:TNW</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row7c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row7c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row7c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row7c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row7c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row7c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row7c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row7c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row7c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row7c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
							</tr>		
							
					<tr class="datagrid">
	                <td id="Debt:Equity" colspan="2"><b>Debt:Equity</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row8c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row8c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row8c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row8c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row8c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row8c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row8c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row8c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row8c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row8c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>	
							
					<tr class="datagrid">
	                <td colspan="2" id="Current_Assets"><b>Current Assets</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row9c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row9c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row9c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row9c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row9c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row9c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row9c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row9c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row9c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row9c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
							</tr>				
					
					<tr class="datagrid">
	                <td colspan="2" id="Current_Liabilities"><b>Current Liabilities</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row10c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row10c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row10c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row10c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row10c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row10c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row10c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row10c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row10c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row10c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
							</tr>				
					
					
					<tr class="datagrid">
	                <td colspan="2" id="Net_Working_Capital"><b>Net Working Capital</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row11c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row11c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row11c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row11c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row11c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row11c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row11c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row11c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row11c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row11c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>	
							
							
				<tr class="datagrid">
	                <td colspan="2" id="Current_Ratio"><b>Current Ratio</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row12c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row12c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row12c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row12c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row12c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row12c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row12c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row12c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row12c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row12c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>				
					
					
					<tr class="datagrid">
	                <td colspan="2" id="Net_Profit_after_tax/_(Net loss)"><b>Net Profit after tax/ (Net loss)</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row13c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row13c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row13c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row13c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row13c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row13c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row13c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row13c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row13c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row13c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
							</tr>	


					<tr class="datagrid">
	                <td colspan="2" id="Depreciation"><b>Depreciation</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row14c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row14c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row14c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row14c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row14c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row14c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row14c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row14c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row14c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row14c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>	
							
					<tr class="datagrid">
	                <td colspan="2" id="Cash_Loss_if_any_(Net_Loss+Depr)"><b>Cash Loss if any (Net Loss+Depr)</b></td>
	                <td  width="10%" align="center">
	                <input type="text" name="row15c1" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row15c1"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							
					 <td  width="10%" align="center">
	                <input type="text" name="row15c2" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row15c2"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row15c3" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row15c3"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row15c4" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row15c4"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 <td  width="10%" align="center">
	                <input type="text" name="row15c5" size="13" 
							style="text-align:right;border-style=groove;color:blue"
							maxlength="12" value="<%=Helper.correctNull((String) hshValues.get("hsh_row15c5"))%>" onblur="roundtxt(this);" onkeypress="allowNegtiveNumber(this)"> 
							</td>
							 
							</tr>
											</table>
											<br/>
		<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
		
	 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
	 <input type="hidden" name="id" value=""> 
	<input type="hidden" name="type" value="">
<br/>
</form>		
</body>
</html>