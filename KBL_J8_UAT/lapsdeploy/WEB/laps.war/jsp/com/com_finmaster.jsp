<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strType = Helper.correctNull(request.getParameter("hidval"));%>
<html>
<head>
<title>Limit Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var button="";
var vartype = "";
var vardesc = "";
var varformula1="";
var varformula2="";
var varformulano1="";
var varformulano2="";
var varsno="";
var varstressrdo="";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doClose()
{
	if(ConfirmMsg(100)){
	document.forms[0].action=appURL+"action/setupnav.jsp";
	document.forms[0].submit();
	}
}

function changeTypeofRow()
{
	var finselect = document.forms[0].select_page.value;
	if(finselect == "CA" || finselect == "FU"  )
	{
		document.forms[0].select_type.length=3;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
		document.forms[0].select_type.options[1].value="HE";
		document.forms[0].select_type.options[1].text="Heading";
		document.forms[0].select_type.options[2].value="FO";
		document.forms[0].select_type.options[2].text="Formula";
	}
	else if(finselect == "FI"  || finselect=="DSCR")
	{
		document.forms[0].select_type.length=4;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
		document.forms[0].select_type.options[1].value="C";
		document.forms[0].select_type.options[1].text="Calculated";
		document.forms[0].select_type.options[2].value="H";
		document.forms[0].select_type.options[2].text="Heading";
		document.forms[0].select_type.options[3].value="E";
		document.forms[0].select_type.options[3].text="Enterable";
	}
   else	if(finselect == "S"  )
	{
		document.forms[0].select_type.length=1;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
	}
	else
	{
		document.forms[0].select_type.length=3;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
		document.forms[0].select_type.options[1].value="HE";
		document.forms[0].select_type.options[1].text="Heading";
		document.forms[0].select_type.options[2].value="FO";
		document.forms[0].select_type.options[2].text="Formula";
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddelete.disabled=bool6;
}

function showRating(val)
{
	var prop = "scrollbars=no,width=450,height=350";	
	var xpos = (screen.width - 450) / 2;
	var ypos = (screen.height - 350) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	if ((button == "add"  || button == "")&& (val == "rowdesc"))
	{
		return;
	}
	if(document.forms[0].cmdedit.disabled != true && val == "formula")
	{
		return;
	}
	if (val == "tabtitle")
	{
		if (document.forms[0].cmaformat.value =="")
		{
			alert("Select a CMA Format");
			return;
		}
	}
	if(document.forms[0].cmdsave.disabled == true)
	{
		if ((val == "rowdesc") && (document.forms[0].select_page.value == "FI") && (document.forms[0].select_page =="MU") && (document.forms[0].select_page =="MA") && (document.forms[0].tabtitle.value == "" ) )
		{
			alert("Select a Tabtitle");
			return;
		}
	}
	if(document.forms[0].cmdsave.disabled != true || document.forms[0].cmdedit.disabled != true)
	{
		if ((val == "rowdesc") && (document.forms[0].select_page =="FI") && (document.forms[0].select_page =="MU")&& (document.forms[0].select_page =="MA"))
		{
			if (document.forms[0].tabtitle.value == "")
			{
				alert("Select a Tabtitle format");
				return;
			}
		}
		if (val == "formula" || val == "formula2" )
		{
			if (document.forms[0].select_type.value == "HE" || document.forms[0].select_type.value == "H" ||
				document.forms[0].select_type.value == "I" || document.forms[0].select_type.value == "E" || document.forms[0].select_type.value == "S")
			{
				if (val == "formula" && document.forms[0].formula.value == "")
				{
					alert("Only Calculated Fields Needs Formula");
					return;
				}
			}
		}
		tabtitle=document.forms[0].tabtitle.value;
		cmano=document.forms[0].cmano.value;
		pagetitle = document.forms[0].select_page.value;
		if (document.forms[0].select_type.value == "IC" && val !="cma" && val != "tabtitle" && val != "rowdesc")
		{

			val="selfdescription";
			var purl = appURL+"jsp/com/finmasterselectformula.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
			prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
		}
		else
		{
			
			var purl = appURL+"jsp/com/finmasterselect.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
		}
		if (document.forms[0].select_type.value == "D" || document.forms[0].select_type.value == "CWF" && val != 'cma'&& val != 'tabtitle'  && val != "rowdesc")
		{
			
			val="description"
			var purl = appURL+"jsp/com/finmasterselectdesc.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
		}
		var title = "Help";
		window.open(purl,title,prop);
	}
}

function loadrowtype()
{
	a="<%=Helper.correctNull((String) hshValues.get("select_type"))%>"
	if(a != "")
	{
		document.forms[0].select_type.value=a;
	}
	else
	{
		document.forms[0].select_type.value="S";
	}
}

function doEdit()
{
	button="edit";
	if (document.forms[0].rowdesc.value == "")
	{
		alert("select a row description");
		return ;
	}
	else
	{
		enableButtons(true,true,false,false,true,true);
		vartype=document.forms[0].select_type.value;
		varformula1=document.forms[0].formula.value;
		varformulano1=document.forms[0].formulano.value;
		varsno=document.forms[0].txtorder.value;
		vardesc=document.forms[0].rowdesc.value;
		varstressrdo=document.forms[0].stressrdo.value;
	}
	addedit();
}

function doNew()
{
	button="add";
	enableButtons(true,true,false,false,true,true);
	document.forms[0].formula.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].rowdesc.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].txtorder.value="";
	document.forms[0].stressrdo.value="N";
	document.forms[0].formula.value="";
	document.forms[0].formulano.value="";
	addedit();
}

function addedit()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=false;
		}	
	}
	document.forms[0].cmaformat.readOnly=true;
	changemode(false);
	document.forms[0].formula.readOnly=true;
	document.forms[0].stressrdo[0].disabled=false;
	document.forms[0].stressrdo[1].disabled=false;
}

function change_combo()
{
	if (document.forms[0].select_type.value != "C")
	{
		document.forms[0].formula.readOnly = true;
	}
}

function Validate()
{
	if (document.forms[0].cmaformat.value == ""  || document.forms[0].select_page.value == "" || document.forms[0].select_type.value == "S" )
	{
		flag = "false";
	}
	else
	{
		flag ="true";
	}
	return flag;
}

function doSave()
{
	if(document.forms[0].tabtitle.value == "RA3" && trim(document.forms[0].txt_kalypto_code.value) == "")
	{
		alert("Please enter the Kalypto passing code for the ratio");
		document.forms[0].txt_kalypto_code.focus();
		return;
	}
	
	var flag=Validate();
	if (flag == "true")
	{
		document.forms[0].formula.disabled=false;
		document.forms[0].cmaformat.disabled=false;
		document.forms[0].stressrdo[0].disabled=false;
		document.forms[0].stressrdo[1].disabled=false;
		if (button == "")
		{
			button = "add";
		}
		if (button=="add")
		{
			if (document.forms[0].rowdesc.value != "")
			{
				document.forms[0].tabtitle.disabled=false;
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidBeanId.value="finmaster";
				document.forms[0].hidval.value="insert";
				document.forms[0].hidBeanMethod.value="updateData";
				document.forms[0].hidBeanGetMethod.value="getDataHelp";
				document.forms[0].hidSourceUrl.value="/action/com_finmaster.jsp";
				document.forms[0].submit();
			}
			else
			{
				alert("enter Row Description ");
			}
		}
		else if (button == "edit")
		{
			if (document.forms[0].rowdesc.value != "")
			{
				document.forms[0].cmdsave.disabled=true;
				document.forms[0].tabtitle.disabled=false;
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidBeanId.value="finmaster";
				document.forms[0].hidval.value="update";
				document.forms[0].hidBeanMethod.value="updateData";
       			document.forms[0].hidBeanGetMethod.value="getDataHelp";						
				document.forms[0].hidSourceUrl.value="/action/com_finmaster.jsp";
				document.forms[0].submit();
			}
			else
			{
				alert("Select Row Description ");
			}
		}
	}
	else
	{
		alert("Enter the values For The Fields");
	}
}
   
function doDelete()
{
		if (document.forms[0].rowdesc.value == "")
		{
			alert("select Row Description");
			return ;
		}
		if(ConfirmMsg(101))
		{
			document.forms[0].formula.disabled=false;
			document.forms[0].cmaformat.disabled=false;
			document.forms[0].tabtitle.disabled=false;
			document.forms[0].select_type.disabled=false;
			document.forms[0].stressrdo[0].disabled=false;
			document.forms[0].stressrdo[1].disabled=false;
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="finmaster";
			document.forms[0].hidval.value="delete";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getDataHelp";	
			document.forms[0].hidSourceUrl.value="/action/com_finmaster.jsp";
			document.forms[0].submit();
		}
}

function whileLoading()
{
	strtype="<%=strType%>";
	var buttonstatus="<%=Helper.correctNull((String) hshValues.get("hidval"))%>"
	if (strtype == "delete")
	{
		var success = "<%=Helper.correctNull((String) hshValues.get("success"))%>";
		if (success == "N")
		{
			alert("The Description You Are Trying To Delete Have Some Relative Applications")
		}
	}
	if (buttonstatus == "update" )
	{
		enableButtons(false,false,true,true,false,false);
		button="edit";
	}
	else
	{
		enableButtons(false,false,true,true,true,true);
		button = "add";
	}
	if(strtype != "update")
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			 	document.forms[0].elements[i].readOnly=false;
			}	
		}
		document.forms[0].stressrdo[0].disabled=false;
		document.forms[0].stressrdo[1].disabled=false;
	}
	else
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			 	document.forms[0].elements[i].readOnly=true;
			}	
		}
		document.forms[0].select_type.disabled=true;
		document.forms[0].stressrdo[0].disabled=true;
		document.forms[0].stressrdo[1].disabled=true;
	}
	fillvalues();
	changeTypeofRow();
	pageComboChange();
	changeCashFlowTypeCombo();
	loadrowtype();
	document.forms[0].cmaformat.readOnly=true;
	document.forms[0].formula.readOnly=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		button ="cancel";
		enableButtons(false,false,true,true,false,false);
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			 	document.forms[0].elements[i].readOnly=true;
			}	
		}
		document.forms[0].select_type.value="S";
		document.forms[0].rowdesc.value="";
		document.forms[0].formula.value="";
		document.forms[0].txtorder.value="";
		document.forms[0].stressrdo[0].disabled=true;
		document.forms[0].stressrdo[1].disabled=true;
		val=document.forms[0].stressrdo.value;
		
		changemode(true);
		if (vartype == "")
		{
			vartype="S";
		}
		document.forms[0].select_type.value=vartype;
		document.forms[0].formula.value=varformula1;
		document.forms[0].formulano.value=varformulano1;
		document.forms[0].txtorder.value=varsno;
		document.forms[0].rowdesc.value=vardesc;
		document.forms[0].stressrdo.value=varstressrdo;
	}
}

function changemode(val)
{
	document.forms[0].select_type.disabled=val;
	document.forms[0].rowdesc.readOnly=val;
	document.forms[0].formula.readOnly=val;
	document.forms[0].txtorder.readOnly=val;
	document.forms[0].cmaformat.readOnly=val;
	document.forms[0].cmaformat.readOnly=val;
}

function pagechange()
{
	document.forms[0].formula.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].rowdesc.value="";
	document.forms[0].formula.value="";
	document.forms[0].cmaformat.value="";
	document.forms[0].tabtitle.value="";
	document.forms[0].txtorder.value="";
}

function pageComboChange()
{
	if (document.forms[0].select_page.value != "FI" && document.forms[0].select_page.value != "RA" && document.forms[0].select_page.value != "MU" && document.forms[0].select_page.value != "MA" && document.forms[0].select_page.value != "INV" )
	{
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";
	}
	else
	{
		document.forms[0].tabtitle.disabled=false;
		document.all.showhelp.style.visibility = "visible";
	}
	pageselected = document.forms[0].select_page.value;
	//Comment is removed by Kamal - Remove 
	if(pageselected =="FI")
	{	
		document.all.financialId.style.visibility="visible";
	}
	else
	{	
		document.all.financialId.style.visibility="hidden";
	}
}

function changeCashFlowTypeCombo()
{
	pagev = document.forms[0].select_page.value 
	if(pagev == "CA" ||  pagev == "FU" ||  pagev == "AS"  )
	{
		document.forms[0].formula.readOnly=true;
	}
}

function fillvalues()
{
	if("<%=Helper.correctNull((String) hshValues.get("select_page"))%>"!="")
	{
		document.forms[0].select_page.value="<%=Helper.correctNull((String) hshValues.get("select_page"))%>"
	}
	if("<%=Helper.correctNull((String) hshValues.get("stressrdo"))%>"!="")
	{
		val= "<%=Helper.correctNull((String) hshValues.get("stressrdo"))%>";
		
		if (val == "N")
		{
			document.forms[0].stressrdo[1].checked=true;
		}
		else if(val == "Y")
		{
			document.forms[0].stressrdo[0].checked=true;
		}
	}
	else
	{
		document.forms[0].stressrdo[1].checked=true;
	}
}
function doExportExcel()
{
	var cmaindex=document.forms[0].cmano.value;
	var category = document.forms[0].select_page.value;
	var varCmaDesc = document.forms[0].cmaformat.value;
	if(category=="S")
	{
		alert("Select the Category");
		return false;
	}
	if(category!="S" && category!="FI")
	{
		alert("Select the Category as Financial");
		return false;
	}
	if(cmaindex=="")
	{
		alert("Select the CMA Format to Export!");
		return false;
	}
	if(cmaindex!="" && category=="FI")
	{
		var FileName=varCmaDesc+"_"+cmaindex+"_COMPANYNAME";
		var qryString=appURL+"action/"+FileName+".xls?&hidBeanId=excelfunction&hidBeanGetMethod=doExcelExportFinancialFormat&strCMANo="+cmaindex+"&strPage="+category+"&cmaformat="+varCmaDesc;
		var prop="scrollbars=yes,menubar=yes,width=20, height=20";
		window.open(qryString,"FinancialFormat",prop);
	}
}

function kalyptocode()
{
	if(document.forms[0].tabtitle.value == "RA3")
	{
		document.all.kaly_code.style.display="table-row";
	}
	else
	{
		document.all.kaly_code.style.display="none";
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="whileLoading();kalyptocode();">
<form class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corporate Products -&gt; CMA Master </td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
					<tr>
						<td width="22%">Category</td>
						<td colspan="2"><select name="select_page"
							onChange="pageComboChange();pagechange();changeTypeofRow()">
							<option value="S" selected>&lt;-- Select --&gt;</option>
							<option value="FI">Financial</option>
							<option value="CA">CashFlow</option>
							<option value="FU">FundFlow</option>
							<option value="RA">Ratios</option>
							<option value="DSCR">DSCR</option>
							<option value="INV">Assessment - Inventory Norms</option>
							<option value="MU">Assessment - MPBF UPTO 25 CRORES</option>
							<option value="MA">Assessment - MPBF ABOVE 25 CRORES</option>
							<option value="FL">Assessment - Forex Limits</option>
							<!-- <option value="TO">Assessment - Turn Over</option>
							<option value="MPBF1">Assessment - MPBF1</option>
							<option value="PBF2">Assessment - NBFC1</option>
							<option value="HL">Assessment - Holding Levels</option>
							<option value="OCA">Financial Indicators - Other Current Assets</option>
							<option value="RS">Financial Indicators - Reserves & Surplus</option>
							<option value="TNW">Financial Indicators - TNW</option>
							<option value="LTL">Financial Indicators - Long Term Liabilities</option>
							<option value="NCA">Financial Indicators - Non Current Assets</option>
							<option value="CAS">Financial Indicators - Current Assets</option>
							<option value="CL">Financial Indicators - Current Liabilities</option>
							<option value="NS">Financial Indicators - Net Sales</option>
							<option value="OI">Financial Indicators - Other Income</option>
							<option value="PRA">Profitability Ratios</option> -->
						</select></td>
					</tr>
					<tr>
						<td width="22%">CMA Index</td>
						<td colspan="2"><input type="text" name="cmaformat" size="30"
							value="<%=Helper.correctNull((String) hshValues.get("cmaformat"))%>">
						<b><span onClick="showRating('cma1')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					</tr>
					<tr>
						<td width="22%">Title</td>
						<td colspan="2"><input type="text" name="tabtitle" size="50"
							maxlength="100"
							value="<%=Helper.correctNull((String) hshValues.get("tabtitle"))%>">
						<b><span onClick="showRating('tabtitle')" style="cursor: hand"
							id="showhelp"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					</tr>
					<tr>
						<td width="22%">Row Description</td>
						<td colspan="2"><input type="text" name="rowdesc" size="80"
							value="<%=Helper.correctNull((String) hshValues.get("rowdesc"))%>">
						<b><span onClick="showRating('rowdesc')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					</tr>
					<tr>
						<td width="22%">Row For</td>
						<td colspan="2"><select name="select_type" id="showfintype"
							onChange="change_combo();changeCashFlowTypeCombo()">
							<option value="S" selected>&lt;-- Select --&gt;</option>
							<option value="I" selected>Blank</option>
							<option value="C">Calculated</option>
							<option value="H">Heading</option>
							<option value="E">Enterable</option>
						</select></td>
					</tr>
					<tr>
						<td width="22%">S.No</td>
						<td width="12%"><input type="text" name="txtorder" size="5"
							value="<%=Helper.correctNull((String) hshValues.get("order"))%>">
						</td>
						<td width="66%" id="financialId" style="visibility: hidden">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td width="17%" nowrap>Stress Analysis</td>
								<td width="5%"><input type="radio" name="stressrdo"
									value="Y" style="border-style: none">
								</td>
								<td width="7%">Yes</td>
								<td width="6%"><input type="radio" name="stressrdo"
									value="N" style="border-style: none">
								</td>
								<td width="5%">No</td>
								<td width="19%">&nbsp;</td>
								<td width="41%">&nbsp;</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="22%"><span id="formulaid">Formula</span></td>
						<td colspan="2"><input type="text" name="formula" size="30"
							value="<%=Helper.correctNull((String) hshValues.get("formula"))%>">
						<b><span onClick="showRating('formula')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b></td>
					</tr>
					<tr id="kaly_code">
						<td width="22%">KALYPTO passing code</td>
						<td colspan="2"><input type="text" name="txt_kalypto_code" size="30"
							value="<%=Helper.correctNull((String) hshValues.get("txt_kalypto_code"))%>">
						</td>
					</tr>
					
					<tr id="experian_code">
						<td width="22%">Perfios Passing Code</td>
						<td colspan="2"><input type="text" name="txt_experian_code" size="30"
							value="<%=Helper.correctNull((String) hshValues.get("txt_experian_code"))%>">
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail_Export Excel" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String) hshValues.get("oldVal"))%>">
<input type="hidden" name="sno" value="<%=Helper.correctNull((String) hshValues.get("sno"))%>">
<input type="hidden" name="hidval"> 
<input type="hidden" name="val"> 
<input type="hidden" name="formulano" value="<%=Helper.correctNull((String) hshValues.get("formulano"))%>">
<input type="hidden" name="cmano" value="<%=Helper.correctNull((String) hshValues.get("cmano"))%>">
<input type="hidden" name="hidPageName" value="com_finmaster.jsp">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
