<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strType = Helper.correctNull(request.getParameter("hidval"));%>
<html>
<head>
<title>Limit Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path = "<%=ApplicationParams.getAppUrl()%>";
var button="";
var vartype = "";
var vardesc = "";
var varformula1="";
var varformula2="";
var varformulano1="";
var varformulano2="";
var varsno="";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
	document.forms[0].action=path+"action/setupnav.jsp";
	document.forms[0].submit();
}

function changeTypeofRow()
{
	var finselect = document.forms[0].select_page.value;
	if(finselect == "CA" || finselect == "FU" || finselect=="FUA" )
	{
		document.forms[0].select_type.length=3;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
		document.forms[0].select_type.options[1].value="HE";
		document.forms[0].select_type.options[1].text="Heading";
		document.forms[0].select_type.options[2].value="FO";
		document.forms[0].select_type.options[2].text="Formula";
	}
	else if(finselect == "FI" || finselect == "INV" || finselect == "WCA" || finselect =="PLA" || finselect =="CLA" || finselect =="CAA" || finselect =="WAA")
	{
		document.forms[0].select_type.length=3;
		document.forms[0].select_type.options[0].value="S";
		document.forms[0].select_type.options[0].text="<-- Select -->";
		document.forms[0].select_type.options[1].value="C";
		document.forms[0].select_type.options[1].text="Calculated";
		document.forms[0].select_type.options[2].value="H";
		document.forms[0].select_type.options[2].text="Heading";
		
		
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
		
	if(document.forms[0].cmdsave.disabled != true || document.forms[0].cmdedit.disabled != true)
	{		
		if (val == "formula" || val == "formula2" )
		{
			if (document.forms[0].select_type.value == "HE" || document.forms[0].select_type.value == "H" ||
				 document.forms[0].select_type.value == "S")
			{
				if (val == "formula" && document.forms[0].formula.value == "")
				{
				alert("Only Calculated Fields Needs Formula");
				return;
				}
				else if(val == "formula2" && document.forms[0].formula2.value == "")
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
			var purl = path+"jsp/com/finmasterselectformula.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
			prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;			
		}
		else
		{			
			var purl = path+"jsp/com/notefinmasterselect.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
		}
		if (document.forms[0].select_type.value == "D" || document.forms[0].select_type.value == "CWF" && val != 'cma'&& val != 'tabtitle'  && val != "rowdesc")
		{
			val="description"
			var purl = path+"jsp/com/finmasterselectdesc.jsp?val="+val+"&tabtitle="+tabtitle+"&cmano="+cmano+"&pagetitle="+pagetitle;
		}
	var title = "Help";
	window.open(purl,title,prop);		
	}	
}

function loadrowtype()
{
	a="<%=Helper.correctNull((String) hshValues
									.get("select_type"))%>"
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
	varformula2=document.forms[0].formula2.value;
	varformulano1=document.forms[0].formulano.value;
	varformulano2=document.forms[0].formulano2.value;
	varsno=document.forms[0].txtorder.value;
	vardesc=document.forms[0].rowdesc.value;
	}
	addedit();
}

function doNew()
{
	button="add";
	enableButtons(true,true,false,false,true,true);
	document.forms[0].formula.value="";
	document.forms[0].formula2.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].rowdesc.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].txtorder.value="";	
	document.forms[0].formula.value="";
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
	document.forms[0].formula2.readOnly=true;
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
	var flag=Validate();
	
	if (flag == "true")
	{
			if(document.forms[0].sel_attach.value == "1" && document.forms[0].sel_finind.value == "S")
				{
				
					alert("Attach Financial Indicators");
					document.forms[0].sel_finind.focus();
					return;
				}
			document.forms[0].formula.disabled=false;
			document.forms[0].cmaformat.disabled=false;
			if (button == "")
			{
				button = "add";
			}			
			if (button=="add")
				{
					if (document.forms[0].rowdesc.value != "")
						{
				document.forms[0].tabtitle.disabled=false;
				document.forms[0].cmdsave.disabled = true;
				document.forms[0].action=path+"controllerservlet";
				document.forms[0].hidBeanId.value="notefinmaster";
				document.forms[0].hidval.value="insert";
				document.forms[0].hidBeanMethod.value="updateData";
	//---------------------To Fix Proxy Error Eswari--------------------					
				document.forms[0].hidBeanGetMethod.value="getDataHelp";
				document.forms[0].hidSourceUrl.value="/action/notecom_finmaster.jsp";
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
						document.forms[0].tabtitle.disabled=false;
						document.forms[0].cmdsave.disabled = true;
						document.forms[0].action=path+"controllerservlet";
						document.forms[0].hidBeanId.value="notefinmaster";
						document.forms[0].hidval.value="update";
						document.forms[0].hidBeanMethod.value="updateData";
	//---------------------To Fix Proxy Error Eswari--------------------							
        				document.forms[0].hidBeanGetMethod.value="getDataHelp";						
						document.forms[0].hidSourceUrl.value="/action/notecom_finmaster.jsp";
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
	//if(varRecordFlag=="Y")
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
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanId.value="notefinmaster";
			document.forms[0].hidval.value="delete";
			document.forms[0].hidBeanMethod.value="updateData";
			//---------------------To Fix Proxy Error Eswari--------------------		
			document.forms[0].hidBeanGetMethod.value="getDataHelp";	
			document.forms[0].hidSourceUrl.value="/action/notecom_finmaster.jsp";
			document.forms[0].submit();
		}
	}
	//else
	{
	//	ShowAlert(158);
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
		enableButtons(false,false,false,false,true,true);
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
		document.forms[0].sel_attach.disabled=true;
		document.forms[0].sel_finind.disabled=true;
	}		
		fillvalues();
		changeTypeofRow();
		pageComboChange();
		changeCashFlowTypeCombo();
		loadrowtype();		
		document.forms[0].cmaformat.readOnly=true;
		document.forms[0].formula.readOnly=true;
		document.forms[0].formula2.readOnly=true;		
		showattach();		
		var attach = "<%=Helper.correctNull((String) hshValues.get("attach"))%>";
		var indicator = "<%=Helper.correctNull((String) hshValues.get("indicator"))%>";
		if(attach != "" && attach != "0")
		{			
			document.forms[0].sel_attach.value = attach;
			document.forms[0].sel_finind.value= indicator;
			showfinindicators();
		}
		else
		{
			document.forms[0].sel_attach.value = "0";
			document.forms[0].sel_finind.value = "S";
			showfinindicators();
		}
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
			document.forms[0].formula2.value="";
			document.forms[0].txtorder.value="";
			changemode(true);
			if (vartype == "")
			{
				vartype="S";
			}
			document.forms[0].select_type.value=vartype;
			document.forms[0].formula.value=varformula1;
			document.forms[0].formula2.value=varformula2;
			document.forms[0].formulano.value=varformulano1;
			document.forms[0].formulano2.value=varformulano2;
			document.forms[0].txtorder.value=varsno;
			document.forms[0].rowdesc.value=vardesc;			
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
	document.forms[0].sel_attach.disabled=val;
	document.forms[0].sel_finind.disabled=val;
}
function pagechange()
{
	document.forms[0].formula.value="";
	document.forms[0].select_type.value="S";
	document.forms[0].rowdesc.value="";
	document.forms[0].formula.value="";
	document.forms[0].formula2.value="";
	document.forms[0].cmaformat.value="";
	document.forms[0].tabtitle.value="";
	document.forms[0].txtorder.value="";
}

function pageComboChange()
{
	if (document.forms[0].select_page.value != "FI"  )
	{
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";			
	}
	else
	if (document.forms[0].select_page.value != "INV"  )
	{
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";			
	}
	else
	if (document.forms[0].select_page.value != "WCA"  )
	{	
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";			
	}
	else if (document.forms[0].select_page.value != "PLA")
	{
	
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";
			
	}
	else if (document.forms[0].select_page.value != "CLA")
	{
	
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";
			
	}
	else if (document.forms[0].select_page.value != "CAA")
	{
		document.forms[0].tabtitle.disabled=true;
		document.all.showhelp.style.visibility = "hidden";
			
	}
	else if (document.forms[0].select_page.value != "WAA")
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
	if (pageselected == "FI" || pageselected == "RA" || pageselected == "CA" 
		|| pageselected == "FU"  || pageselected == "S" || pageselected == "INV" 
		|| pageselected == "WCA" || pageselected == "PLA" || pageselected == "FUA" 
		|| pageselected == "CLA" || pageselected == "CAA" ||pageselected == "WAA" ||pageselected == "MST")
	{
		document.all.showformula.style.visibility="hidden";
		document.all.formulaid.innerText="Formula";
	}
	else
	{		
		document.all.showformula.style.visibility="visible";
		document.all.formulaid.innerText="Formula 1";
	}	
}
function changeCashFlowTypeCombo()
{
	pagev = document.forms[0].select_page.value 
	if(pagev == "CA" ||  pagev == "FU" ||  pagev == "AS"  || pagev=="FUA"  )
	{		
		document.forms[0].formula.readOnly=true;
	}
}
function fillvalues()
{
	
	if("<%=Helper.correctNull((String) hshValues
									.get("select_page"))%>"!="")
	{
	document.forms[0].select_page.value="<%=Helper.correctNull((String) hshValues
									.get("select_page"))%>"
	}	
}
function showfinindicators()
{
	if(document.forms[0].sel_attach.value == "0")
	{
		document.all.showfinind.style.visibility = "hidden";
		document.forms[0].sel_finind.value = "S";
	}
	else
	{
		document.all.showfinind.style.visibility = "visible";		
	}	
}
function showattach()
{
	if(document.forms[0].select_page.value == "FI")
	{
		document.all.attachid.style.visibility = "visible";
		document.all.attachid.style.position="relative";
		document.all.show_attach.style.visibility = "visible";
	}
	else
	{
		document.all.attachid.style.visibility = "hidden";
		document.all.attachid.style.position="absolute";
		document.all.show_attach.style.visibility = "hidden";
		document.forms[0].sel_attach.value = "0";
		document.forms[0].sel_finind.value = "S";
		showfinindicators();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="whileLoading()">
<form class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td valign="bottom" class="page_flow">Home -&gt; Setup -&gt;  Corporate Products-&gt; Note to Dir - Proposal Master  </td>
	</tr>
</table>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
	<tr>
		<td>
		<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" >
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="4"
					align="center">
					<tr>
						<td>
						<table class="outertable" width="90%" border="0" cellspacing="0" cellpadding="3"
							align="center">
							<tr>
								<td>
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
									<tr>
										<td width="22%">Category</td>
										<td><select name="select_page"
											onChange="pageComboChange();pagechange();changeTypeofRow();showattach()">
											<option value="S" selected>&lt;---Select---&gt;</option>
											<option value="FI">Financial - Note To Dir</option>
											<option value="CA">CashFlow - Note To Dir</option>
											<option value="FU">FundFlow -Note To Dir</option>
											<option value="RA">Ratios -Note To Dir</option>
											<option value="MPBF1">Assessment - MPBF1 -Note To Dir</option>
											<option value="MST">Modification of Sanction</option>											
										</select></td>
									</tr>
									<tr>
										<td width="22%">CMA Index</td>
										<td><input type="text" name="cmaformat" size="30"
											value="<%=Helper.correctNull((String) hshValues.get("cmaformat"))%>">
										<span onClick="showRating('cma')" style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
									</tr>
									<tr>
										<td width="22%">Title</td>
										<td><input type="text" name="tabtitle" size="50"
											maxlength="100"
											value="<%=Helper.correctNull((String) hshValues.get("tabtitle"))%>">
										<span onClick="showRating('tabtitle')"
											style="cursor: hand" id="showhelp"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
									</tr>
									<tr>
										<td width="22%">Row Description</td>
										<td><input type="text" name="rowdesc" size="80"
											value="<%=Helper.correctNull((String) hshValues.get("rowdesc"))%>">
										<span onClick="showRating('rowdesc')"
											style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
									</tr>
									<tr id="attachid">
										<td width="22%">Attach Financial Indicators</td>
										<td>
										<table class="outertable">
											<tr>
												<td id="show_attach"><select name="sel_attach"
													onChange="showfinindicators()">
													<option value="0" selected>No</option>
													<option value="1">Yes</option>
												</select></td>
												<td>&nbsp;</td>
												<td id="showfinind"><select name="sel_finind">
													<option value="S" selected>&lt;-- Select --&gt;</option>
													<lapschoice:StaticDataNewTag apptype="72" />
												</select></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td width="22%">Row For</td>
										<td><select name="select_type" id="showfintype"
											onChange="change_combo();changeCashFlowTypeCombo()">
											<option value="S" selected>&lt;-- Select --&gt;</option>
											<option value="C">Calculated</option>
											<option value="H">Heading</option>
										</select></td>
									</tr>
									<tr>
										<td width="22%">S.No</td>
										<td><input type="text" name="txtorder" size="30"
											value="<%=Helper.correctNull((String) hshValues.get("order"))%>">
										</td>
									</tr>
									<tr>
										<td width="22%"><span id="formulaid">Formula</span></td>
										<td><input type="text" name="formula" size="30"
											value="<%=Helper.correctNull((String) hshValues.get("formula"))%>">
										<span onClick="showRating('formula')"
											style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
									</tr>
									<tr id="showformula">
										<td width="22%">Formula 2</td>
										<td><input type="text" name="formula2" size="30"
											value="<%=Helper.correctNull((String) hshValues.get("formula2"))%>">
										<span onClick="showRating('formula2')"
											style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></td>
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="sno" value="<%=Helper.correctNull((String) hshValues.get("sno"))%>">
<input type="hidden" name="hidval"> 
<input type="hidden" name="formulano" value="<%=Helper.correctNull((String) hshValues.get("formulano"))%>">
<input type="hidden" name="formulano2" value="<%=Helper.correctNull((String) hshValues.get("formulano2"))%>">
<input type="hidden" name="cmano" value="<%=Helper.correctNull((String) hshValues.get("cmano"))%>">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
