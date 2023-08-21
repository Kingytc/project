<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>

<script>
var mode ="load";
var path ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";

function showAgency()
{
	if(document.forms[0].cmdnew.disabled == true || document.forms[0].cmdedit.disabled == true)
	{
		ClearFields();
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchagencylist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&hidvalue=agency&pagefrom=setuprating";
		var title = "Agencylist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function showSymbol()
{	
	if(mode=="edit")
	{
		if(document.forms[0].txt_agency.value=="")
		{
		ShowAlert("121","Agency Name");
		mode="edit";
 		document.forms[0].txt_agency.focus();
 		return;
		}
		if(document.forms[0].seltype.value=="")
		{
			ShowAlert("111","Type");
			mode="edit";
	 		document.forms[0].seltype.focus();
	 		return
		}
		var agency = document.forms[0].txt_agency.value;
		var type = document.forms[0].seltype.value;
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchsymbollist.jsp?hidBeanGetMethod=getAgencyandSymbolList&hidBeanId=limitmaster&agency="+agency+"&type="+type+"&hidvalue=symbol&pageID=setupsymbol";
		var title = "Symbollist";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
function doNew()
{
	mode = "new";
	document.forms[0].cmdnew.disabled =true;
	document.forms[0].cmdedit.disabled =true;
	//document.forms[0].buthelp.disabled =false;
	document.forms[0].cmdclose.disabled =false;
	document.forms[0].cmdsave.disabled =false;
	document.forms[0].cmdcancel.disabled =false;
	document.forms[0].cmddelete.disabled =true;
	document.forms[0].txt_agency.readOnly=false;
	document.forms[0].sel_active.disabled = false;
	ClearFields();
	disabled(false);
	
}
function loadPage()
{
	
	document.forms[0].cmdnew.disabled = false;
	document.forms[0].cmdedit.disabled = false;
	//document.forms[0].buthelp.disabled = false;
	document.forms[0].cmdclose.disabled = false;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].cmdcancel.disabled = true;
	document.forms[0].cmddelete.disabled =true;
	document.forms[0].txt_agency.readOnly=false;
	mode = "new";
	disabled(true);
	
}
function doSave()
{
	if (mode == "new")
	{
		document.forms[0].hidAction.value="INSERT";
		
	}
	else if (mode == "edit")
	{
		document.forms[0].hidAction.value="UPDATE";
	}
	
	if(document.forms[0].txt_agency.value=="")
	{
		ShowAlert("121","Agency Name");
 		document.forms[0].txt_agency.focus();
 		return false;
	}
	/* if(document.forms[0].seltype.value=="")
	{
		ShowAlert("111","Type");
 		document.forms[0].seltype.focus();
 		if(mode == "edit")
 		{
 			doEdit();
 		}
 		else
 		{
 			loadPage();
 		}
 		return
	} */
	if(document.forms[0].txt_symbol.value=="")
	{
		ShowAlert("121","Rating Symbol");
 		document.forms[0].txt_symbol.focus();
 		return false;
	
	}

	if(document.forms[0].sel_active.value == "S" ||document.forms[0].sel_active.value == "")
	{
		ShowAlert("111"," Active");
		return false;
		}
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdcancel.disabled = true;
	document.forms[0].cmddelete.disabled = true;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="limitmaster";
	document.forms[0].hidBeanGetMethod.value="updateExternalCreditRating";
	document.forms[0].action=path+"action/com_extcreditrating.jsp";
	document.forms[0].submit();
}

function doEdit()
{
	mode ="edit";
	
	document.forms[0].cmdnew.disabled = true;
	document.forms[0].cmdsave.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmdclose.disabled = true;
	disabled(false);	
	document.forms[0].txt_agency.readOnly=true;
	document.forms[0].txt_symbol.readOnly=true;
	document.forms[0].sel_active.disabled = false;
}

function doDelete()
{

		if(document.forms[0].txt_agency.value=="")
			{
			ShowAlert("121","Agency Name");
	 		document.forms[0].txt_agency.focus();
	 		doEdit();
	 		return;
		}
		if(document.forms[0].seltype.value=="")
		{
			ShowAlert("111","Type");
	 		document.forms[0].seltype.focus();
	 		doEdit();
	 		return
		}
		if(document.forms[0].txt_symbol.value=="")
		{
			ShowAlert("121","Rating Symbol");
	 		document.forms[0].txt_symbol.focus();
	 		doEdit();
	 		return;
		
		}
		
		if (ConfirmMsg("101"))
		{
			for (i=0;i<document.forms[0].elements.length;i++)
			{
				document.forms[0].elements[i].disabled =false;
			}
		
	
			document.forms[0].hidAction.value="DELETE";
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].hidBeanGetMethod.value="updateExternalCreditRating";
			document.forms[0].action=path+"action/com_extcreditrating.jsp";
			document.forms[0].submit();
			
		}
	

}

function doCancel()
{
   if (ConfirmMsg("102"))
   {
   	mode="cancel";
    document.forms[0].cmdnew.disabled =false;
	document.forms[0].cmdsave.disabled =true;
	document.forms[0].cmdcancel.disabled =true;
	document.forms[0].cmddelete.disabled =true;
	document.forms[0].cmdedit.disabled =false;
	document.forms[0].cmdclose.disabled =false;
	disabled(true);
	document.forms[0].hidBeanId.value="limitmaster";
	document.forms[0].hidBeanGetMethod.value="updateExternalCreditRating";
	document.forms[0].action=path+"action/com_extcreditrating.jsp";
	document.forms[0].submit();
   }
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
	
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disabled(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		}
	}
}
</script>
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 130;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->



</script>
</head>
<body onLoad="loadPage();">

<form name="myfrm" method="post" class="normal">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0" >
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="0">
			
			<tr >
				<td valign="top" colSpan=5 class="page_flow">Home -&gt;
				Setup -&gt; Corporate Products -&gt;External Credit Rating
				Particulars</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table class="outertable" width="90%" border="0" cellspacing="0"
	cellpadding="10" align="center">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="5" align="center">
			<tr>
				<td valign="top">
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="0" height="8" align="center">
					<tr>
						<td valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="0">
							<tr>
								<td colspan="4" height="2">
								<table class="outertable border1 tableBg" width="100%" border="0"
									cellspacing="0" cellpadding="0">
									<tr>
										<td colspan="10">
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="0">
											<tr>
												<td>
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="3">
													<tr class="dataheader">
														<td colspan="2">External Credit Rating Particulars</td>
													</tr>
													<tr>
														<td colspan="2">
														<table class="outertable" width="100%" border="0"
															cellspacing="0" cellpadding="8">
															<tr>
																<td width="23%">Agency Name</td>
																<td width="40%"><input type="text"
																	name="txt_agency" size="48" maxlength="50"
																	onBlur="JavaScript:this.value =trim(this.value);changecase(this)"
																	onKeyPress="allowAlphaSpaIntPunct()"> <b><span
																	onClick="showAgency();" style="cursor: hand"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"></span></b></td>
																  <td width="14%">Type</td>
																<td width="23%"><select name="seltype">
																	<option value='' selected>----Select----</option>
																	 <lapschoice:StaticDataTag apptype="222" />
																</select></td> 
															</tr>
															<tr>
																<td width="23%">Rating Symbol&nbsp;</td>
																<td width="40%" colspan="3"><input type="text"
																	name="txt_symbol"
																	onBlur="JavaScript:this.value =trim(this.value)"
																	maxlength="10"> <b><span
																	onClick="showSymbol();" style="cursor: hand"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"></span></b></td>
															</tr>
															<tr>
																<td width="23%">Rating Meaning</td>
																<td WIDTH="40%" colspan="3"><INPUT TYPE="text"
																	NAME="txt_meaning" maxlength="50"></td>
															</tr>
															 <tr id="action">
															<td width="23%">Active</td>
									                        <td width="40%"><select name="sel_active">
									                            <option value="S" selected="selected">--Select--</option>
									                            <option value="E">Enable</option>
									                            <option value="D">Disable</option>
									                            </select>
									                        </td>
															</tr>
															
															<tr>
															<td width="23%">Definition</td>
															<td valign="top">
					<textarea rows="3" cols="50" name="txtArea_definition" onKeyPress="textlimit(this,999)" wrap="VIRTUAL" onkeyup="textlimit(this,999)" ><%=Helper.correctNull((String) hshValues.get("EXTERNAL_DEFINITION"))%></textarea>
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
<input type="hidden" name="hidsno">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>

