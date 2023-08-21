<%@include file="../share/directives.jsp"%>
<%ArrayList glp = null;
glp = (ArrayList) hshValues.get("arr");%>
<html>
<head>
<title>Borrower Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";

function callNew()
{
	document.forms[0].action=appURL+"action/comappmaster.jsp";
	document.forms[0].submit();
}

function callOffline()
{
	document.forms[0].action=appURL+"action/offline.jsp?fileid=companydtls";
	document.forms[0].submit();
}


function doReset()
	{
		document.forms[0].bow_name.focus();
		document.all.result.src=appURL+"action/blank.jsp";
	}
function setpageid()
{
	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
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
var area1="";
var area2="";
var area3="";
var area4="";
var area5="";
	
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		area3=document.forms[0].hidarea3.value;
		area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "A")
	{
		area4=level;
	}
	scode="";
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	
	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
	var txtval=document.forms[0].bow_name.value;
	var txtlen=txtval.length;

	if (cat==4)
	{
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
		     document.forms[0].bow_name.focus();
		     return;
	 	 }
	}
	else if(txtval=="")
	{
			 alert("Enter Value to Search");
		     document.forms[0].bow_name.focus();
		     return;
	}
    noofrows = document.forms[0].txt_noofrows.value;
    bow_name =  document.forms[0].bow_name.value;    
   	select_cat="";	
   	if(document.forms[0].hidCategoryType.value=="NPA")
   	{ 
		document.all.result.src=appURL+"action/npaborrowersearchresult.jsp?hidBeanGetMethod=getNPAAccountSearchData&area1="+area1+"&scode="+scode+"&cat="+cat+"&select_cat="+select_cat+"&bow_name="+bow_name+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidmoduletype="+document.forms[0].hidmoduletype.value;
   	}
   	else
   	{
   		document.all.result.src=appURL+"action/npaborrowerresult2.jsp?hidBeanGetMethod=getMonitoringBorrower&area1="+area1+"&scode="+scode+"&cat="+cat+"&select_cat="+select_cat+"&bow_name="+bow_name+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidmoduletype="+document.forms[0].hidmoduletype.value;
   	}	
}

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		 document.forms[0].submit();
	 }
}

function showSystem(val)
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
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
				
			}
		if(val == "4")
		{
				if(document.forms[0].hidarea3.value != "" )
				{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;							
			}		
	}	
	title="help";	
	window.open(purl,title,prop);	
}

function doSelect()
{
	document.forms[0].bow_name.value="";
	document.forms[0].bow_name.focus();
}

function rowCount(nav)
 {

 	if(document.forms[0].hid_rowcount.value == "")
 	{
 		document.forms[0].hid_rowcount.value = 0;
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
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="rowCount('0')">
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" class="page_flow">Home -&gt; NPA(Borrower Search)</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
					<tr>
						<td valign="top"><b>Borrower Search</b><br>
						<table width="100%" border="0" cellspacing="2" cellpadding="5" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
										<td valign="top">
										<table width="60%" border="0" align="center" cellspacing="0" cellpadding="1" class="outertable">
											<tr>
												<td width="76%" valign="top">
												<table width="100%" align="center" border="0" cellspacing="1" cellpadding="0" class="outertable">
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
														<td width="3%" nowrap="nowrap"><%=glp.get(y)%></td>
														<td width="25%" nowrap="nowrap"><input type="text" name="area<%=y%>"
															> <input type="hidden" name="hidarea<%=y%>"> <b><span
															onClick="showSystem('<%=y%>')" style="cursor:hand"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0"></span></b> &nbsp;&nbsp;&nbsp;&nbsp;</td>
														<%}}%>
													<tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
											<tr>
												<td valign="top">
												<table width="100%" border="0" cellspacing="1" class="outertable" cellpadding="0">
													<tr>
														<td width="2%"><input type="radio" name="cat" value="2"
															onClick="doSelect()" style="border-style:none"></td>
														<td width="8%" nowrap><b>Customer ID</b></td>
														<td width="2%"><input type="radio" name="cat" value="4"
															onClick="doSelect()" style="border-style:none"></td>
														<td  width="10%" nowrap><b>Borrower Name</b></td>
														<td width="23%" align="left"><input type="text"
															name="bow_name" size="20"
															onKeyPress="notAllowSplChar();"></td>

														<td width="55%" align="left"><input type="button"
															name="search" value="Search" class="buttonStyle"
															onClick="doSearch()"> </td>
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
												<td width="19%" nowrap><b>No. of rows to be displayed </b></td>
												<td width="81%"><input type="text" name="txt_noofrows"
													size="4" maxlength="2" value="15" onBlur="setCount()"
													onKeyPress="allowInteger()"> <b>(Value should be below 100)</b>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr><td>&nbsp;</td></tr>
									<tr>
										<td colspan="8">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
											<tr class="dataheader">
												<td width="33%" align="center"><b>NPA BORROWER	NAME</b></td>
												<td width="26%" align="center"><b>CBSID</b></td>
												<td width="41%" align="center"><b>Organisation</b></td>
											</tr>
										</table>
										</td>
									</tr>
									<tr align="center">
										<td colspan="8"><iframe id="result" src="" width="100%"
											height="240" border=no> </iframe></td>
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
<!-- next and prev -->
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr>
		<td width="9%" nowrap><a href="javascript:rowCount('1')"
			><b>&lt;&lt;Previous</b></a></td>
		<td width="84%">&nbsp;</td>
		<td align="right" width="7%"><a href="javascript:rowCount('2')"
			><b>Next&gt;&gt;</b></a></td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidNpaPageType"
	value="<%=Helper.correctNull((String)request.getParameter("hidNpaPageType"))%>">
<input type="hidden" name="hidCategoryType"
	value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hid_rowcount" value=""> <input type="hidden"
	name="hidmoduletype"
	value="<%=(String)request.getParameter("hidmoduletype")%>"></form>
</body>
</html>
