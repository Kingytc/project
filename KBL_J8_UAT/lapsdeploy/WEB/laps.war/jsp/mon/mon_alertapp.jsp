<%@include file="../share/directives.jsp"%>
<%
	request.setAttribute("_cache_refresh", "true");
	ArrayList glp = null;
	glp = (ArrayList) hshValues.get("arr");
%>

<html>
<head>
<title>Monitoring Alerts</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>

<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";

function loadalertfor()
{
	document.forms[0].selalertfor.value="S";
	if(document.forms[0].selassetclassified.options.selectedIndex==1)
	{
		document.forms[0].selalertfor.length =5;
		document.forms[0].selalertfor.options[0].text= "<---- Select ---->";
		document.forms[0].selalertfor.options[0].value= "S";
		document.forms[0].selalertfor.options[1].text= "Document expiring in next three months";
		document.forms[0].selalertfor.options[1].value= "001";
		document.forms[0].selalertfor.options[2].text= "Difference in Location of address in Stock and Insurance";
		document.forms[0].selalertfor.options[2].value= "002";
		document.forms[0].selalertfor.options[3].text= "Insurance expiring in next three months";
		document.forms[0].selalertfor.options[3].value= "003";
		//document.forms[0].selalertfor.options[4].text= "Bills payment Due";
		//document.forms[0].selalertfor.options[4].value= "004";
		document.forms[0].selalertfor.options[4].text= "Limits Due for Renewal in next three Months";
		document.forms[0].selalertfor.options[4].value= "005";
	}
	else if(document.forms[0].selassetclassified.options.selectedIndex==2 || document.forms[0].selassetclassified.options.selectedIndex==3)
	{
		document.forms[0].selalertfor.length =4;
		document.forms[0].selalertfor.options[0].text= "<---- Select ---->";
		document.forms[0].selalertfor.options[0].value= "S";
		document.forms[0].selalertfor.options[1].text= "Loan Default";
		document.forms[0].selalertfor.options[1].value= "001";
		document.forms[0].selalertfor.options[2].text= "Non Renewal";
		document.forms[0].selalertfor.options[2].value= "003";
		document.forms[0].selalertfor.options[3].text= "Non Inspection";
		document.forms[0].selalertfor.options[3].value= "004";
	}
	else if(document.forms[0].selassetclassified.options.selectedIndex==4 || document.forms[0].selassetclassified.options.selectedIndex==5)
	{
		document.forms[0].selalertfor.length =6;
		document.forms[0].selalertfor.options[0].text= "<---- Select ---->";
		document.forms[0].selalertfor.options[0].value= "S";
		document.forms[0].selalertfor.options[1].text= "Loan Default";
		document.forms[0].selalertfor.options[1].value= "001";
		document.forms[0].selalertfor.options[2].text= "Non Renewal";
		document.forms[0].selalertfor.options[2].value= "003";
		document.forms[0].selalertfor.options[3].text= "Non Inspection";
		document.forms[0].selalertfor.options[3].value= "004";
		document.forms[0].selalertfor.options[4].text= "Document deficiency";
		document.forms[0].selalertfor.options[4].value= "005";
		document.forms[0].selalertfor.options[5].text= "Other Default";
		document.forms[0].selalertfor.options[5].value= "006";
	}
	else
	{
		document.forms[0].selalertfor.length =1;
		document.forms[0].selalertfor.options[0].text= "<---- Select ---->";
		document.forms[0].selalertfor.options[0].value= "S";
	}
	changehead();
}
	


/*function callgeneral()
{
	disablefields();
	clearfields();
	for(var i=0;i<5;i++)
	{
		document.forms[0].optalertfor[i].disabled=true;
	}
	var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Zone");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a region");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a region");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=getGeneral&hidorg_code="+area4;
	
}	*/

function getalertdetails()
{
	var area1="";
    var area2="";
    var area3="";
    var area4=""; 
    var area5="";
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Zone");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a region");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a region");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	if(document.forms[0].selalertfor.value=="S")
	{
		ShowAlert(111,'Alert for');
		document.forms[0].selalertfor.focus();
		return;
	}
	if(document.forms[0].selassetclassified.value=="S")
	{
		ShowAlert(111,'Asset Classification');
		document.forms[0].selassetclassified.focus();
		return;
	}
	document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=getAlertData&hidalertfor="+document.forms[0].selalertfor.value+"&hidAsset="+document.forms[0].selassetclassified.value+"&hidorg_code="+area4;
	
	//Loan Default	
	/*if((document.forms[0].optassetclafication[1].checked==true)||(document.forms[0].optassetclafication[2].checked==true)||(document.forms[0].optassetclafication[3].checked==true)||(document.forms[0].optassetclafication[4].checked==true))
	{
		if(document.forms[0].optalertfor[0].checked==true)
		{
			//document.forms[0].hidalertfor.value="001";
			var hidAsset=document.forms[0].hidAsset.value;
			document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=getLoanDefaultData&hidalertfor="+document.forms[0].hidalertfor.value+"&hidAsset="+hidAsset+"&hidorg_code="+area4;
			disablefields();clearfields();
		}
		//Non-Renewal of Limit
		else if(document.forms[0].optalertfor[1].checked==true)
		{
			//document.forms[0].hidalertfor.value="003";
			var hidAsset=document.forms[0].hidAsset.value;
			document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=nonRenewal&hidalertfor="+document.forms[0].hidalertfor.value+"&hidAsset="+hidAsset+"&hidorg_code="+area4;
			disablefields();clearfields();
		}
		//Non-inspection of securities
		else if(document.forms[0].optalertfor[2].checked==true)
		{
			//document.forms[0].hidalertfor.value="004";
			var hidAsset=document.forms[0].hidAsset.value;
			document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=noninspectionofsecurities&hidalertfor="+document.forms[0].hidalertfor.value+"&hidAsset="+hidAsset+"&hidorg_code="+area4;
			disablefields();clearfields();
		}
		//Deficiency in documentation
		else if(document.forms[0].optalertfor[3].checked==true)
		{
			//document.forms[0].hidalertfor.value="005";
			var hidAsset=document.forms[0].hidAsset.value;
			if(hidAsset=="002")
			{
				alert("Deficiency in Documentation have only EAS-II and SMA alert type");
				document.forms[0].optassetclafication[1].checked=false;
				document.forms[0].optalertfor[3].checked=false;
				disablefields();clearfields();
			}
			else
			{
				document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=getDocumentationdeficiency&hidalertfor="+document.forms[0].hidalertfor.value+"&hidAsset="+hidAsset+"&hidorg_code="+area4;
				disablefields();clearfields();
			}
		}
		//Other Defaults
		else if(document.forms[0].optalertfor[4].checked==true)
		{
			//document.forms[0].hidalertfor.value="006";
			var hidAsset=document.forms[0].hidAsset.value;
			if(hidAsset=="002")
			{
				alert("Other Defaults have only EAS-II and SMA alert type");
				document.forms[0].optassetclafication[1].checked=false;
				document.forms[0].optalertfor[4].checked=false;
				disablefields();clearfields();
			}
			else
			{
				document.all.result.src=appUrl+"action/mon_alertresult.jsp?&hidBeanId=monitoringalert&hidBeanGetMethod=otherdefaults&hidalertfor="+document.forms[0].hidalertfor.value+"&hidAsset="+hidAsset+"&hidorg_code="+area4;
				disablefields();clearfields();
			}
		}
	}
	else
	{
		alert("Select Alert type");
		for(var i=0;i<5;i++)
		{
			document.forms[0].optalertfor[i].checked=false;
		}
		return;
	}*/

}
function resetme()
{
	document.forms[0].reset();
	document.all.result.src=appUrl+'action/blank.jsp';
}	
function doClose()
{
	//document.forms[0].optassetclafication.value="";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].submit();
}
	
function clearfields()
{
	document.forms[0].txt_loandefcount.value="";
 	document.forms[0].txt_renewalcount.value="";
 	document.forms[0].txt_noninspcount.value="";
 	document.forms[0].txt_defindoccount.value="";
 	document.forms[0].txt_otherdefcount.value="";
}
function disablefields()
{
	document.forms[0].txt_loandefcount.readOnly=true;
 	document.forms[0].txt_renewalcount.readOnly=true;
 	document.forms[0].txt_noninspcount.readOnly=true;
 	document.forms[0].txt_defindoccount.readOnly=true;
 	document.forms[0].txt_otherdefcount.readOnly=true;
}	
function changehead()
{

	if(document.forms[0].selassetclassified.value=="005" && document.forms[0].selalertfor.value=="005")
	{
		document.all.headdataid.innerHTML='<table width="100%" cellspacing="0" cellpadding="2" border="1"><tr class="dataHeader"><th width="35%">Customer Name</th><th width="25%">Renewal On</th><th  width="15%">Remarks</th></table>';
	}
	else if((document.forms[0].selassetclassified.value == "005") || (document.forms[0].selassetclassified.value != "005" && document.forms[0].selalertfor.value=="003") || (document.forms[0].selassetclassified.value != "005" && document.forms[0].selalertfor.value=="006"))
	{
	    document.all.headdataid.innerHTML='<table width="100%" cellspacing="0" cellpadding="2" border="1"><tr class="dataHeader"><th width="20%">Account Number</th><th width="35%">Customer Name</th><th width="20%">Alert Due To</th><th width="15%">Remarks</th></table>';
	}
    else if(document.forms[0].selassetclassified.value != "005" && document.forms[0].selalertfor.value=="001")
	{
		document.all.headdataid.innerHTML='<table width="100%" cellspacing="0" cellpadding="2" border="1"><tr class="dataHeader"><th width="15%">Account Number</th><th width="22%">Customer Name</th><th idth="13%">Alert Due To</th><th  width="10%">Remarks</th><th width="10%">Overdue Amount</th><th  width="10%">Sanctioned Amount</th></table>';
	}
	else
	{
		document.all.headdataid.innerHTML='<table width="100%" cellspacing="0" cellpadding="2" border="1"><tr class="dataHeader"><th width="20%">Account Number</th><th width="30%">Customer Name</th><th width="20%">Alert Due To</th><th width="15%">Remarks</th><th width="15%">Sanctioned Amount</th></table>';
	}
										
}
/*function changelbl()
{
	if(document.forms[0].optassetclafication[1].checked==true)
	{
		document.forms[0].hidAsset.value="001";
		document.forms[0].optalertfor[0].disabled=false;
		document.forms[0].optalertfor[1].disabled=false;
		document.forms[0].optalertfor[2].disabled=true;
		document.forms[0].optalertfor[3].disabled=true;
		document.forms[0].optalertfor[4].disabled=true;
		disablefields();clearfields();
		
		for(var i=0;i<5;i++)
		{
			document.forms[0].optalertfor[i].checked=false;
		}
	}
	else if(document.forms[0].optassetclafication[2].checked==true)
	{
		document.forms[0].hidAsset.value="002";
		document.forms[0].optalertfor[0].disabled=false;
		document.forms[0].optalertfor[1].disabled=false;
		document.forms[0].optalertfor[2].disabled=false;
		document.forms[0].optalertfor[3].disabled=true;
		document.forms[0].optalertfor[4].disabled=true;
		disablefields();clearfields();
		for(var i=0;i<5;i++)
		{
			document.forms[0].optalertfor[i].checked=false;
		}
	}
	else if(document.forms[0].optassetclafication[3].checked==true)
	{
		document.forms[0].hidAsset.value="003";
		document.forms[0].optalertfor[0].disabled=false;
		document.forms[0].optalertfor[1].disabled=false;
		document.forms[0].optalertfor[2].disabled=false;
		document.forms[0].optalertfor[3].disabled=false;
		document.forms[0].optalertfor[4].disabled=false;
		disablefields();clearfields();
		for(var i=0;i<5;i++)
		{
			document.forms[0].optalertfor[i].checked=false;
		}
	}
	else if(document.forms[0].optassetclafication[4].checked==true)
	{
		document.forms[0].hidAsset.value="004";
		document.forms[0].optalertfor[0].disabled=false;
		document.forms[0].optalertfor[1].disabled=false;
		document.forms[0].optalertfor[2].disabled=false;
		document.forms[0].optalertfor[3].disabled=false;
		document.forms[0].optalertfor[4].disabled=false;
		disablefields();clearfields();
		for(var i=0;i<5;i++)
		{
			document.forms[0].optalertfor[i].checked=false;
		}
	}
	
}*/
function loading()
{
	disablefields();
	clearfields();
}

function showSystem(val,glpsize)
{
	prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	if(orglevel == "C")
	{
		if(val == "2")
		{			
			valsys=level.substring(0,3)+"%%%000000000";
			var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
			else
			{
				alert("select a Zone");
				return;
			}
		}
	    if(val == "4")
		{
			if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "")
			{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
			else
			{
				alert("select a Region");
				return;
			}
		}
		if(val == "5")
		{
			if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "" &&  document.forms[0].hidarea4.value != "")
			{
				level = document.forms[0].hidarea4.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
			else
			{
				alert("Select a Branch");
				return;
			}
		}
	}
	else if(orglevel == "R")
	{
		if(val == "3")
		{
			valsys=level.substring(0,9)+"%%%000"	;
			var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
		if(val == "4")
		{
			if(document.forms[0].hidarea3.value != "" )
			{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
			}
			else
			{
				alert("Select a Branch");
				return;
			}
		}
	}
	else if(orglevel == "D")
	{
		if(val == "4")
		{
			valsys=level.substring(0,9)+"%%%000";
			var purl = appUrl+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
	}
	title="help";
	//alert(purl);
	window.open(purl,title,prop);
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">

</head>

<body >
<form name="frmundelapp" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" class="Page_flow" colSpan=5>Home
				-&gt;Alerts</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable border1">
	<tr>
		<td valign="top" height="450">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable"> 
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="2"
							class="outertable border1">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="5"
								class="outertable">

									<tr>
										<td valign="top">
										<table width="95%" border="0" cellspacing="0" cellpadding="0"
											class="outertable border1">

											<tr>
												<td valign="top" align="left"><b>Borrower Search</b><br>
												
                                      <table width="100%" border="0" cellspacing="2"
													cellpadding="5" height="100%" class="outertable"> 
                                        <tr> 
                                          <td colspan="7" valign="top"> 
                                            <table width="100%" border="0" cellspacing="0"
															cellpadding="0" class="outertable">
                                              <tr> 
                                                <td valign="top"> 
                                                  <table width="100%" border="0" cellspacing="0"
																	cellpadding="1" class="outertable border1">
                                                    <tr> 
                                                      <td width="76%" valign="top"> 
                                                        <table width="100%" border="0" cellspacing="1"
																			cellpadding="0" class="outertable">
                                                          <tr> 
                                                            <%int initial = 0;
			String level = (String) session.getAttribute("strOrgLevel");
			if (level.equalsIgnoreCase("C")) {
				initial = 2;
			} else if (level.equalsIgnoreCase("R")) {
				initial = 3;
			} else if (level.equalsIgnoreCase("D")) {
				initial = 4;
			} else if (level.equalsIgnoreCase("A")) {
				initial = 5;
			} else if (level.equalsIgnoreCase("B")) {
				initial = 6;
			}
			for (int y = initial; y <= glp.size() - 1; y++) {
				if (!glp.get(y).equals("")) {

					%>
                                                            <td width="8%"><%=glp.get(y)%></td>
                                                            <td width="25%"> 
                                                              <input type="text" name="area<%=y%>" size=25>
                                                              <input
																					type="hidden" name="hidarea<%=y%>">
                                                              <b><span
																					onClick="showSystem('<%=y%>','<%=glp.size()-initial%>')"
																					style="cursor:hand"><img
																					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																					border="0"></span></b> 
                                                              &nbsp;</td>
                                                            <%}
			}

			%>
                                                          <tr> 
                                                        </table>
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>
                                              <%-- <tr>
																<td>

																<table width="100%" border="0" cellspacing="0"
																	cellpadding="5">
																	<tr>
																		<td valign="top">
																		<table width="100%" border="1" cellspacing="0"
																			cellpadding="1" bordercolorlight="#8F8369"
																			bordercolordark="#FFFFFB">
																			<tr>
																				<td width="76%" valign="top">
																				<table width="100%" border="0" cellspacing="1"
																					cellpadding="0">
																					<tr>
																						<td colspan="4"><b>Alert Type</b></td>
																						<td colspan="2">&nbsp;</td>
																					</tr>
																					<tr>
																						<td width="4%"><input type="radio"
																							name="optassetclafication"
																							style="border-style:none" value="005"
																							onClick="callgeneral();"></td>
																						<td width="12%">General</td>
																						<td width="4%">
																						<input type="radio" name="optassetclafication"
																							style="border-style:none" value="001"
																							onClick="changelbl();"> </td>
																						<td width="12%">Standard</td>
																						<td width="5%">
																						<input type="radio" name="optassetclafication"
																							style="border-style:none" value="002"
																							onClick="changelbl();"></td>
																						<td width="15%">EAS- I </td>
																						<td width="6%">
																						<input type="radio" name="optassetclafication"
																							style="border-style:none" value="003"
																							onClick="changelbl();"></td>
																						<td width="13%">EAS- II</td>
																						<td width="4%">
																						<input type="radio" name="optassetclafication"
																							style="border-style:none" value="004"
																							onClick="changelbl();"> </td>
																						<td width="25%">SMA</td>
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

													<tr>
														<td width="84%">
														<table width="100%" border="1" cellspacing="0"
															cellpadding="0" bordercolorlight="#8F8369"
															bordercolordark="#FFFFFB">
															<tr>
																<td id="d1"><!--style="visibility:hidden"
												-->
																<table width="100%" border="0" cellspacing="0"
																	cellpadding="5">
																	<tr>
																		<td><b>Search
																		by </b></td>
																	</tr>
																	<tr>
																		<td id="dataid">
																			<table width="100%" border=0 cellspacing="0" cellpadding="5">
																			<tr>
																		<td width="3%"> 
																		<input
																			type="radio" name="optalertfor" value="001"
																			style="border-style:none" onClick="getalertdetails()">
																		</td>
																		<td width="8%" nowrap>Loan Default</td>
																		<td width="6%"><font color="#C0C0C0"> <input
																			type="text" name="txt_loandefcount" size="5"
																			style="border:0;background-color:#DEDACF;color:black; font-weight:bold;">
																		</font></td>
																		<td width="3%"> <input
																			type="radio" name="optalertfor" value="002"
																			style="border-style:none" onClick="getalertdetails()">
																		</td>
																		<td width="8%" nowrap>Non Renewal of Limits</td>
																		<td width="6%" nowrap><input type="text"
																			name="txt_renewalcount" size="5"
																			style="border:0;background-color:#DEDACF;color:black; font-weight:bold;"></td>
																		<td width="3%" nowrap><input type="radio"
																			name="optalertfor" value="003"
																			style="border-style:none" onClick="getalertdetails()">
																		</td>
																		<td width="8%" nowrap>Non - Inspection of securities</td>
																		<td width="6%" nowrap><input type="text"
																			name="txt_noninspcount" size="5"
																			style="border:0;background-color:#DEDACF;color:black;font-weight:bold;"></td>
																		<td width="3%" nowrap><input type="radio"
																			name="optalertfor" value="004"
																			style="border-style:none" onClick="getalertdetails()">
																		</td>
																		<td width="7%" nowrap>Deficiency in Documentation</td>
																		<td width="6%" nowrap><input type="text"
																			name="txt_defindoccount" size="5"
																			style="border:0;background-color:#DEDACF;color:black;font-weight:bold;"></td>
																		<td width="3%" nowrap><input type="radio"
																			name="optalertfor" value="005"
																			style="border-style:none" onClick="getalertdetails()">
																		</td>
																		<td width="8%" nowrap>Other Defaults</td>
																		<td width="10%"><input type="text"
																			name="txt_otherdefcount" size="5"
																			style="border:0;background-color:#DEDACF;color:black;font-weight:bold;"></td>
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
													<tr>
														<td width="84%">hai</td>
													<tr>--%>
                                            </table>
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td>Asset Classification</td>
                                          <td> 
                                            <select name="selassetclassified" onchange="loadalertfor()">
                                              <option value="S" selected>&lt;---Select---&gt;</option>
                                              <option value="005">General</option>
                                              <option value="001">Standard</option>
                                              <option value="002">EAS I</option>
                                              <option value="003">EAS II</option>
                                              <option value="004">SMA</option>
                                            </select>
                                          </td>
                                          <td>Alert For</td>
                                          <td> 
                                            <select name="selalertfor" onchange="changehead()">
                                              <option value="S" selected>&lt;---Select--&gt;</option>
                                             <!--<option value="001">Loan Default 
                                              - Fund Based</option>
                                              <option value="002">Loan Default 
                                              - NFB</option>
                                              <option value="003">Non Renewal</option>
                                              <option value="004">Non Inspection</option>
                                              <option value="005">Document Deficiency</option>
                                              <option value="006">Other Default</option>-->
                                            </select>
                                          </td>
                                          <td>
                                          	No. Of Defaults
                                          </td>
                                          <td>
                                          	<input type="text" name="txt_loandefcount" size="5">
                                          </td>
                                          <td>
                                            <input type="button" name="cmdSearch" class="buttonStyle" value="Get Data" onclick="getalertdetails()">
                                          </td>
                                        </tr>
                                      <%--   <tr> 
                                          <td colspan="6">
                                            <input type="button" name="cmdSearch" value="Get Data" onclick="getalertdetails()">
                                          </td>
                                        </tr>--%>
                                      </table>
										</td>
									</tr>
									<tr>
										<td valign="top"  id="headdataid">
										<table width="100%" cellspacing="0" cellpadding="2" border="0" class="outertable border1"> 
											<tr class="dataHeader">

												<th width="25%">Account Number</th>

												<th width="35%">Customer Name</th>

												<th  width="25%">Alert Due To</th>
												<th  width="15%">Remarks</th>
										</table>

										<table width="100%" cellspacing="0" cellpadding="2" border="0"
											class="outertable border1">
											<%ArrayList arrCol = new ArrayList();
			ArrayList arrRow = new ArrayList();
			String color="";
			arrRow = (ArrayList) hshValues.get("arrAlerts");
			if (arrRow != null && arrRow.size() > 0) {
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);
				//	if(Helper.correctNull((String)arrCol.get(5)).equalsIgnoreCase("RESTR"))
				//	{
				//		color="#FFFFFF";
				//	}
				//	else
				//	{
				//		color="#DEDACF";
				//	}

					%>
											<tr class="dataGrid">

												<td width="25%"><%=Helper.correctNull((String) arrCol.get(0))%></td>
												<td width="35%"><%=Helper.correctNull((String) arrCol.get(1))%></td>
												<td width="25%"><%=Helper.correctNull((String) arrCol.get(2))%></td>
												<td width="15%"><%//=Helper.correctNull((String) arrCol.get(5))%></td>
											</tr>
											<%}
			}

		%>
										</table>
										</td>
									</tr>

									<tr align="center">
										<td><iframe id="result" src="" width="100%" height="240"
											border=no> </iframe></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<br>
<!--				<table border="1" cellspacing="0" cellpadding="0"-->
<!--					bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center"-->
<!--					bgcolor="#DEDACF">-->
<!--					<tr>-->
<!--						<td>-->
<!--						<table width="100%" border="0" cellspacing="0" cellpadding="3">-->
<!--							<tr valign="middle">-->
<!--								<td valign="top" width="12%" align="center"><input type="reset"-->
<!--									name="cmdReset"-->
<!--									style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:80;font-weight:bold"-->
<!--									onClick="resetme()"></td>-->
<!--								<%-- <td valign="top" width="25%" align="center"><input type="button"-->
<!--									name="cmdhelp" value="Help"-->
<!--									style="background-color:#009966;cursor:help;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:60;font-weight:bold"-->
<!--									onClick="doHelp('undeleted.htm')"></td>--%>-->
<!---->
<!--								<td valign="top" width="12%" align="center"><input type="button"-->
<!--									name="cmdclose" value="Close" class="buttonClose"-->
<!--									onClick="doClose()"></td>-->
<!--								<%--  <td valign="top" width="13%">-->
<!--              <input type="button" name="cmdPrint" value="Print" class = "buttonPrint" onClick="doHelp('undeleted.htm')">-->
<!--            </td>--%>-->
<!--							</tr>-->
<!--						</table>-->
<!--						</td>-->
<!--					</tr>-->
<!--				</table>-->
				<lapschoice:combuttonnew btnnames="Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</td>
			</tr>
		</table>
	</td>
</tr>
</table>
				</td>
				</tr>
				</table>

<input type="hidden" name="hidAsset"> 
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="hidSourceUrl">
<%-- <input type="hidden" name="hidalertfor">--%>

</form>
</body>
</html>
