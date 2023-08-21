<%@include file="../share/directives.jsp"%>
<%ArrayList glp = null;
			glp = (ArrayList) hshValues.get("arr");
			session.setAttribute("TotalLandHolding", "");
			session.setAttribute("strappno", "");
			session.setAttribute("perapp_dob", "");
			session.setAttribute("perapp_status", "");
			session.setAttribute("perapp_eduothers", "");
			session.setAttribute("Salaryrouted", "");
			session.setAttribute("bowname", "");
			session.setAttribute("MarginPercent", "");
			session.setAttribute("strProductType", "");
			session.setAttribute("prdcode", "");
			session.setAttribute("InterestCharged", "");%>
<html>
<head>
<title>Borrower Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
function setpageid()
{
	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
}
function doReset()
	{
		document.forms[0].reset();
		document.forms[0].bow_name.focus();
		document.all.result.src=appURL+"action/blank.jsp";
	}
// row count to be displayed in screen
function setCount()
{
   if(document.forms[0].txt_noofrows.value == "")
	{
		alert(" Enter Value");
		document.forms[0].txt_noofrows.focus();
		return;
	}
	if(parseInt(document.forms[0].txt_noofrows.value) > 100)
	{
		alert("Value should be below 100");
		document.forms[0].txt_noofrows.focus();
		return;
	}
}
function doSearch()
{
   if(document.forms[0].bow_name.value && document.forms[0].dateofbirth.value != "")
	{
		alert("Search by Borrower name or Date of birth");
		return;
	}
   if(document.forms[0].bow_name.value==""  && document.forms[0].dateofbirth.value == "")
	{
		alert("Enter data in any of the search criteria");
		return;
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
			alert("Select a branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
	}
	scode="";
	hid_rowcount=document.forms[0].hid_rowcount.value;	
	if(hid_rowcount=="")
	{
	hid_rowcount=0;	
	}
    noofrows = document.forms[0].txt_noofrows.value;
	bow_name =  document.forms[0].bow_name.value;
	var varCategoryType = document.forms[0].hidCategoryType.value;

	document.all.result.src=appURL+"action/agrborrowerresult.jsp?hidBeanGetMethod=getBorrowerDetails&area1="
	+area1+"&scode="+scode+"&bow_name="+bow_name+"&dateofbirth="+ document.forms[0].dateofbirth.value+"&area2="
	+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows
	+"&hidCategoryType="+varCategoryType;
}

function callCalender(name)
{
	showCal(appURL,name);
}	
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/agrpage.jsp?hidCategoryType="+document.forms[0].hidCategoryType.value;
		document.forms[0].submit();
	}
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
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
				
			}
		if(val == "4")
			{
				if(document.forms[0].hidarea3.value != "" )
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&glpsize="+glpsize;							
			}		
	}	
	title="help";
	window.open(purl,title,prop);
}
function rowCount(nav)
 	{
	if(document.forms[0].hid_rowcount.value == "")
 		{
 		document.forms[0].hid_rowcount.value = 0;
 		document.all.result.src=appURL+"action/blank.jsp";
 		}	
 	else
 		{
 		if(nav == 1)
	 		{
 			if(parseInt(document.forms[0].hid_rowcount.value) < parseInt(document.forms[0].txt_noofrows.value) + 1)
 				{
	 			document.forms[0].hid_rowcount.value = 0;
	 			}
	 		else
	 			{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) - parseInt(document.forms[0].txt_noofrows.value);
				}
			}
		else if(nav == 2)
			{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) + parseInt(document.forms[0].txt_noofrows.value);
			}
	    	doSearch();
	    }
 } 
 function changeStaffFlag()
 {
	if(document.forms[0].chk_staff_only.checked)
		document.forms[0].chk_staff_only.value = "Y";
	else
		document.forms[0].chk_staff_only.value = "N";		 	
 } 
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="rowCount('0')">
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Tertiary -&gt; Application search</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td valign="top" align="left"><b>Borrower Search</b><br>
						<table width="100%" border="0" cellspacing="2" cellpadding="3" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
											<tr>
												<td width="76%" valign="top">
												<table width="100%" border="0" cellspacing="1" class="outertable" cellpadding="0">
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
														<td width="8%"><%=glp.get(y)%> </td>
														<td width="25%"><input type="text" name="area<%=y%>"
															size="25"> <input type="hidden" name="hidarea<%=y%>"> 
														<b><span
															onClick="showSystem('<%=y%>','<%=glp.size()-initial%>')"
															style="cursor:hand"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0"></span></b>

														&nbsp;&nbsp;&nbsp;&nbsp; </td>
														<%}}%>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>

									<tr>
										<td valign="top"><br>
										<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="1" class="outertable" cellpadding="0">
													<tr>
														<td align="right" width="15%">Borrower
														Name</td>
														<td width="13%" align="center"><input type="text"
															name="bow_name" size="20"
															onKeyPress="notAllowSplChar1(this)"></td>
														<td align="right" width="15%">Date of Birth</td>
														<td width="15%" align="center">
														<table border="0" width="30%" cellspacing="0"
															cellpadding="3">
															<tr>
																<td><input type="text" name="dateofbirth" maxlength="10"
																	size="15" readOnly="readonly" onBlur="checkDate(this)"></td>
																<td><a alt="Select date from calender" href="#"
																	onClick="callCalender('dateofbirth')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender" tabindex="25"></a></td>
															</tr>
														</table>
														</td>
														<td width="15%">&nbsp; <input type="hidden"
															name="chk_staff_only" value="N" style="border:none"
															onChange="changeStaffFlag()">&nbsp;</td>
														<td width="15%"><input type="button" name="search"
															value="Search"
															class="buttonStyle"
															onClick="doSearch()"></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<br>
										</td>
									</tr>
									<!-- for no of rows to be displayed -->
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
											<tr>
												<td width="19%" nowrap="nowrap"><b>No. of Rows to be Displayed </b> </td>
												<td width="81%"><input type="text" name="txt_noofrows"
													size="4" maxlength="2" value="15"
													onKeyPress="allowInteger()" onBlur="setCount()"> 
												<b>(Value should be below 100)</b></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable linebor" align="center">
											<tr class="dataheader">
												<td width="38%" align="center" >Borrower
												Name </td>
												<td width="10%" align="center"  nowrap="nowrap">CBS Customer
												Id</td>
												<td width="10%" align="center" >Applicant
												Id</td>
												<td width="10%" align="center" >PAN
												No. </td>
												<td width="30%"  align="center">City</td>
											</tr>
										</table>
										<!-- next and  previous --></td>
									</tr>


									<tr align="center">
										<td colspan="8"><iframe id="result" src="" width="100%"
											height="240" border="no"></iframe></td>
									</tr>
								</table>
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td width="9%" nowrap="nowrap"><a href="javascript:rowCount('1')"
											class="blackfont"><b>&lt;&lt;Previous</b></a></td>
										<td width="84%"><lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/></td>
										<td align="right" width="7%"><a
											href="javascript:rowCount('2')" class="blackfont"><b>Next&gt;&gt;</b></a></td>
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
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidBeanMethod" value="getBorrowerDetails" /> 
<input type="hidden" name="hid_rowcount" value="" />
</form>
</body>
</html>
