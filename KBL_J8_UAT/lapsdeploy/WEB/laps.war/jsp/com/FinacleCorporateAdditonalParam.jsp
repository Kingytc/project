<%@include file="../share/directives.jsp"%>
<%
	String flag = "false";
	if (hshValues.get("flag") != null) {
		flag = "true";
	}

	String strPrdtype = Helper.correctNull((String) request
			.getParameter("prdtype"));
	String strLabelType = "";
	if (strPrdtype.equalsIgnoreCase("pH")) {
		strLabelType = "62";
	} else if (strPrdtype.equalsIgnoreCase("pA")) {
		strLabelType = "63";
	} else if (strPrdtype.equalsIgnoreCase("pE")) {
		strLabelType = "64";
	} else if (strPrdtype.equalsIgnoreCase("pD")) {
		strLabelType = "65";
	} else {
		strLabelType = "66";
	}
	
%>
<html>

<head>
<title>Retail Sanction Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varborrowercat="<%=Helper.correctNull((String) hshValues.get("borrowcat"))%>";
var varadvmode="<%=Helper.correctNull((String) hshValues.get("advmode"))%>";
var varadvtype="<%=Helper.correctNull((String) hshValues.get("advtype"))%>";
var varindtype="<%=Helper.correctNull((String) hshValues.get("indtype"))%>";

function placevalues()
{
	disableFields(true);
	if(document.forms[0].appstatus.value=="Closed/Approved")
	{
		enableButtons(true,true,true,true,false,true);
	}
	else
	{
		enableButtons(false,true,true,false,false,true);	
	}		
	var a1="<%=Helper.correctNull((String) hshValues
									.get("txt_taxslab"))%>";
	if(a1!="")
	{
		document.forms[0].sel_taxslab.value=a1;			
	}
	else
	{
		document.forms[0].sel_taxslab.value="s";
		//document.forms[0].sFinacle1.disabled=false;
		document.forms[0].sFinacle2.disabled=true;
	}	
	var a="<%=Helper.correctNull((String) hshValues
							.get("sel_subsector"))%>";
	if(a!="")
	{
		document.forms[0].sel_subsector.value=a;
	}
	else
	{
		document.forms[0].sel_subsector.value="s";
		//document.forms[0].sFinacle1.disabled=false;
		document.forms[0].sFinacle2.disabled=true;
	}	
	var e="<%=Helper.correctNull((String) hshValues
							.get("sel_sanctionlevel"))%>";
	if(e!="")
	{
		document.forms[0].sel_sanctionlevel.value=e;
	}
	else
	{
		document.forms[0].sel_sanctionlevel.value="s";
		document.forms[0].sFinacle2.disabled=true;
		//document.forms[0].sFinacle1.disabled=false;
	}
	var f="<%=Helper.correctNull((String) hshValues
							.get("sel_operationmode"))%>";
	if(f!="")
	{
		document.forms[0].sel_oprationmode.value=f;
	}
	else
	{
		document.forms[0].sel_oprationmode.value="s";
		//document.forms[0].sFinacle1.disabled=false;
		document.forms[0].sFinacle2.disabled=true;
	}
	var g="<%=Helper.correctNull((String) hshValues
							.get("sel_sanctionauthority"))%>";
	if(g!="")
	{
		document.forms[0].sel_sanctionauthority.value=g;
	}
	else
	{
		document.forms[0].sel_sanctionauthority.value="s";
		document.forms[0].sFinacle2.disabled=true;
		//document.forms[0].sFinacle1.disabled=false;
	}
	var h="<%=Helper.correctNull((String) hshValues
							.get("sel_sectorcode"))%>";
	if(h!="")
	{
		document.forms[0].sel_sectorcode.value=h;
	}
	else
	{
		document.forms[0].sel_sectorcode.value="s";
		document.forms[0].sFinacle2.disabled=true;
		//document.forms[0].sFinacle1.disabled=false;
	}
	var l="<%=Helper.correctNull((String) hshValues
							.get("sel_purpose_advance"))%>";
	if(l!="")
	{
		document.forms[0].select_purposeadvance.value=l;
	}
	else
	{
		document.forms[0].select_purposeadvance.value="s";
		document.forms[0].sFinacle2.disabled=true;
		//document.forms[0].sFinacle1.disabled=false;
	}
	if(varborrowercat!="")
	{
		document.forms[0].selborrowercat.value=varborrowercat;
	}
	else
	{
		document.forms[0].selborrowercat.value="s";
		document.forms[0].sFinacle2.disabled=true;
	}
	if(varadvmode!="")
	{
		document.forms[0].seladvmode.value=varadvmode;
	}
	else
	{
		document.forms[0].seladvmode.value="s";
		document.forms[0].sFinacle2.disabled=true;
	}
	if(varadvtype!="")
	{
		document.forms[0].seladvtype.value=varadvtype;
	}
	else
	{
		document.forms[0].seladvtype.value="s";
		document.forms[0].sFinacle2.disabled=true;
	}
	if(varindtype!="")
	{
		document.forms[0].selindtype.value=varindtype;
	}
	else
	{
		document.forms[0].selindtype.value="s";
		document.forms[0].sFinacle2.disabled=true;
	}
	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
	if(checktrim(document.forms[0].sel_taxslab.value) == "NOPAN")//only for customers have not panno
	{
	  document.forms[0].sel_taxslab.disabled=true;
	}
	document.forms[0].txt_freetext7.readOnly=true;
	document.forms[0].txt_label.readOnly=true;
	document.forms[0].txt_custtype.readOnly=true;
	document.forms[0].txt_healthcode.readOnly=true;
	document.forms[0].txt_freecode7.readOnly=true;
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true,true)
	document.forms[0].sFinacle2.disabled=true;
	//document.forms[0].sFinacle1.disabled=true;
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	//document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].hidBeanMethod.value="getadditionalParameter1";
		//document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].action=appUrl+"action/FinacleCorporateAdditonalParam.jsp";
		document.forms[0].submit();
	 }	
}

function doClose()
{	
	this.close();	
}

function closeWindow()
{
	window.close();
}

function doSave()
{
		if(document.forms[0].sel_taxslab.value=="s")
		{
			ShowAlert('111','Tax Slab');
			document.forms[0].sel_taxslab.focus();
			return;
		}
		if(document.forms[0].sel_oprationmode.value=="s")
		{
			ShowAlert('111','Operation Mode');
			document.forms[0].sel_oprationmode.focus();
			return;
		}
		if(document.forms[0].sel_sectorcode.value=="s")
		{
			ShowAlert('111','Sector Code');
			document.forms[0].sel_sectorcode.focus();
			return;
		}
		if(document.forms[0].select_purposeadvance.value=="s")
		{
			ShowAlert('111','Purpose Of Advance');
			document.forms[0].select_purposeadvance.focus();
			return;
		}
		if(document.forms[0].sel_subsector.value=="s")
		{
			ShowAlert('111','Sub Sector Code');
			document.forms[0].sel_subsector.focus();
			return;
		}
		if(document.forms[0].sel_sanctionlevel.value=="s")
		{
			ShowAlert('111','Sanction Level');
			document.forms[0].sel_sanctionlevel.focus();
			return;
		}
		if(document.forms[0].sel_sanctionauthority.value=="s")
		{
			ShowAlert('111','Sanction Authority');
			document.forms[0].sel_sanctionauthority.focus();
			return;
		}
		
		if(trimtxt(document.forms[0].txt_freetext7.value)=="")
		{
			ShowAlert('121','Free Text 7');
			document.forms[0].txt_freetext7.focus();
			return;
		}
		if(trimtxt(document.forms[0].selborrowercat.value)=="s")
		{
			ShowAlert('121','Borrower Category');
			document.forms[0].selborrowercat.focus();
			return;
		}
		if(trimtxt(document.forms[0].seladvmode.value)=="s")
		{
			ShowAlert('121','Mode of Advance');
			document.forms[0].seladvmode.focus();
			return;
		}
		if(trimtxt(document.forms[0].seladvtype.value)=="s")
		{
			ShowAlert('121','Type of Advance');
			document.forms[0].seladvtype.focus();
			return;
		}
		if(trimtxt(document.forms[0].selindtype.value)=="s")
		{
			ShowAlert('121','Industry Type');
			document.forms[0].selindtype.focus();
			return;
		}
		if("<%=strPrdtype%>".charAt(0)=='p')
		{
			if(trimtxt(document.forms[0].txt_label.value)=="")
			{
				ShowAlert('121','Label');
				document.forms[0].txt_label.focus();
				return;
			}
		}
		if(trimtxt(document.forms[0].txt_custtype.value)=="")
		{
			ShowAlert('121','CBS Customer Type');
			document.forms[0].txt_custtype.focus();
			return;
		}
		if(trimtxt(document.forms[0].txt_healthcode.value)=="")
		{
			ShowAlert('121','CBS Health Code');
			document.forms[0].txt_healthcode.focus();
			return;
		}
		if(trimtxt(document.forms[0].txt_freecode7.value)=="")
		{
			ShowAlert('121','CBS Free Code7(District)');
			document.forms[0].txt_freecode7.focus();
			return;
		}
		if("<%=flag%>"=="false")
		{
			document.forms[0].hidAction.value="insert";
		}
		else
		{		
			document.forms[0].hidAction.value="update";		
		}
		document.forms[0].sel_taxslab.disabled=false;
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter1";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/FinacleCorporateAdditonalParam.jsp";
		document.forms[0].submit();
		if(document.forms[0].cmdapply.disabled==false)
		{
			document.forms[0].sFinacle2.disabled=false;
			//document.forms[0].sFinacle1.disabled=false;
		}
		else
		{
			document.forms[0].sFinacle2.disabled=true;
			//document.forms[0].sFinacle1.disabled=false;
			
		}
		
}

function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="FinacleBean";
		document.forms[0].hidBeanMethod.value="updateadditionalParameter1";
		document.forms[0].hidBeanGetMethod.value="getadditionalParameter1";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/FinacleCorporateAdditonalParam.jsp";
		document.forms[0].submit();
	 }
}

function sendSanctionDetailsToFinacle()
{	
	/*if(document.forms[0].appstatus.value=="Processed/Approved")
	{
		alert('Freeze the Application then send the Datas to CBS for Account Creation');
		return;
	}
	else*/
 	if(window.confirm("Do you want to send Sanction Details to CBS ?"))
	{	    
		 var appno = document.forms[0].appno.value;
		 var strappno = document.forms[0].appno.value;
		 var FileName='SanctionDetails_'+appno;
		 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
		 var url=appUrl+"action/"+FileName+".txt?appno="+appno+"&strappno="+strappno+"&hidBeanGetMethod=SanctionDetails&hidBeanId=FinacleBean";
		 window.open(url,"Sanctiondetails",prop);			
	}
}
function sendCustomerDetailsToFinacle()
{
		if(window.confirm("Do you want to send Customer Details to CBS ?"))
		{	    
			 var appno = document.forms[0].appno.value;
			 var strappno = document.forms[0].appno.value;
			 var FileName='CustomerDetails_'+appno;
			 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
			 var url=appUrl+"action/"+FileName+".txt?appno="+appno+"&strappno="+strappno+"&hidBeanGetMethod=CustomerProfile&hidBeanId=FinacleBean";
			 window.open(url,"remarks",prop);			
		}

}

function callDescHelp(id)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appUrl+"action/ops_sanctionhelp.jsp?id="+id+"&hidBeanId=additionalParameter&hidBeanGetMethod=getSearch";;
		var title = "CBS_DATAS_HELP";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}

</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body onLoad="placevalues()">
<form name="frmfinacleinterface" method="post" class="normal">
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom" align="center" height="49"><b>Sanction 	Particulars<br>
		<br></b>
		</td>
	</tr>

</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
	<tr>
		<td width="13%">Tax Slab<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="sel_taxslab">
			<%
				String apptype = "25";
			%>
			<option value="s" selected="selected">Select</option>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Operation Mode<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="sel_oprationmode">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "16";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Sector Code<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="sel_sectorcode">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "18";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Purpose Of Advance<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="select_purposeadvance">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "22";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="11%">Sub Sector Code<b><span class="mantatory">*</span></b></td>
		<td width="46%"><select name="sel_subsector">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "19";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="11%">Sanction Level<b><span class="mantatory">*</span></b></td>
		<td width="46%"><select name="sel_sanctionlevel">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "20";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="11%">Sanction Authority<b><span class="mantatory">*</span></b></td>
		<td width="46%"><select name="sel_sanctionauthority">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "21";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="11%">Free Text 7<b><span class="mantatory">*</span></b></td>
		<td width="46%"><input type="hidden" name="hidfreetext7"
			value="<%=Helper.correctNull((String) hshValues.get("FreeText7"))%>">
		<input type="text" name="txt_freetext7" size="50" maxlength="5"
			value="<%=Helper.correctNull((String) hshValues
									.get("freetextdesc"))%>">
		<b><span onClick="callDescHelp('6')" style="cursor: hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td width="13%">Borrower Category<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="selborrowercat">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "24";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Mode of Advance<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="seladvmode">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "48";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Type of Advance<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="seladvtype">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "49";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Industry Type<b><span class="mantatory">*</span></b></td>
		<td width="30%"><select name="selindtype">
			<option value="s" selected="selected">Select</option>
			<%
				apptype = "50";
			%>
			<lapschoice:StaticDataNewTag apptype='<%=apptype%>' />
		</select></td>
	</tr>
	<tr>
		<td width="13%">Label</td>
		<td width="30%"><input type="hidden" name="hidlabel"
			value="<%=Helper.correctNull((String) hshValues.get("labelcode"))%>">
		<input type="text" name="txt_label" size="50" maxlength="5"
			value="<%=Helper.correctNull((String) hshValues.get("labeldesc"))%>">
		<b><span onClick="callDescHelp('<%=strLabelType%>')"
			style="cursor: hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0" tabindex="7"></span></b></td>
	</tr>
	<tr>
		<td width="13%">CBS Customer Type<b><span class="mantatory">*</span></b></td>
		<td width="30%"><input type="hidden" name="hidcusttype"
			value="<%=Helper.correctNull((String) hshValues
									.get("customertype"))%>">
		<input type="text" name="txt_custtype" size="50" maxlength="5"
			value="<%=Helper.correctNull((String) hshValues
							.get("customertypedesc"))%>">
		<b><span onClick="callDescHelp('67')" style="cursor: hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
	<tr>
		<td width="13%">CBS Health Code<b><span class="mantatory">*</span></b></td>
		<td width="30%"><input type="hidden" name="hidhealthcode"
			value="<%=Helper.correctNull((String) hshValues.get("healthcode"))%>">
		<input type="text" name="txt_healthcode" size="50" maxlength="5"
			value="<%=Helper.correctNull((String) hshValues
							.get("healthcodedesc"))%>">
		<b><span onClick="callDescHelp('68')" style="cursor: hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
	<tr>
		<td width="13%">CBS Free Code5(District)<b><span
			class="mantatory">*</span></b></td>
		<td width="30%"><input type="hidden" name="hidfreecode7"
			value="<%=Helper.correctNull((String) hshValues.get("freecode7"))%>">
		<input type="text" name="txt_freecode7" size="50" maxlength="5"
			value="<%=Helper.correctNull((String) hshValues
							.get("freecode7desc"))%>">
		<b><span onClick="callDescHelp('69')" style="cursor: hand"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
			border="0"></span></b></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" 	align="center" class="outertable">
	<tr>
		<td align="center">
		<input type="button" name="cmdedit" value="Edit "
			onClick="doEdit()" class="buttonStyle"> 
		<input type="button"
			name="cmdapply" value="Save" onClick="doSave()" class="buttonStyle">
		<input type="button" name="cmdcancel" value="Cancel"
			onClick="doCancel()" class="buttonStyle"> 
		<input
			type="button" name="cmdclose" value="Close" class="buttonClose"
			onClick="JavaScript:closeWindow()">
		</td>
	</tr>
	<tr>
		<td align="center">
		<input type="button" name="sFinacle2"
			value="SEND SANCTION DETAILS TO CBS"
			onClick="sendSanctionDetailsToFinacle()"
			class="buttonInterface1">
		</td>
	</tr>
</table>
<lapschoice:hiddentag/>
<input type="hidden" name="hidAppType" value="<%=(String) request.getParameter("hidAppType")%>"> 
<input type="hidden" name="prdtype" value="<%=Helper.correctNull((String) request.getParameter("prdtype"))%>">

</form>
</body>
</html>