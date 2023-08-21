<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<title>Facility - Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/com_facilitymaster.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var mode ="load";
var path ="<%=ApplicationParams.getAppUrl()%>";
var strAction ="<%=(String) objValues.get("action")%>";
var strMsg ="<%=(String) objValues.get("Msg")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript">
<!--
function MM_reloadPage(init) {  //reloads the window if Nav4 resized
  if (init==true) with (navigator) {if ((appName=="Netscape")&&(parseInt(appVersion)==4)) {
    document.MM_pgW=innerWidth; document.MM_pgH=innerHeight; onresize=MM_reloadPage; }}
  else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}
MM_reloadPage(true);
// -->
function showCodes(chr)
{
	if(chr=="Y")
	{
		document.all.codelyr.style.visibility="visible";
	}
	else if(chr=="N")
	{
		document.all.codelyr.style.visibility="hidden";
	}	
}
function assoc()
{
	document.forms[0].hid_selProd.value=document.forms[0].selProd.options[document.forms[0].selProd.selectedIndex].text;
}
</script>
</head>
<body onLoad="loadPage();showMsg();">
<div id="codelyr" style="position: absolute; left: 72px; top: 400px; width: 410px; height: 144px; z-index: 1; visibility: hidden">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
		<td colspan="2">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr class="dataheader">
				<td width="94%">USE THE FOLLOWING CODES WHILE DEFINING FACILITIES</td>
				<td width="6%" align="right"><b><span onClick="showCodes('N')" style="cursor: hand" title="CLOSE">X</span></b></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td width="50%">
		<table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
			<tr class="datagrid">
				<td width="89%" >Secured Advances</td>
				<td width="11%" align="center">SEC</td>
			</tr>
			<tr class="datagrid">
				<td width="89%">Unsecured Advances</td>
				<td width="11%" align="center">UNSEC</td>
			</tr>
			<tr class="datagrid">
				<td width="89%">LC with 100% Margin</td>
				<td width="11%" align="center">LC100</td>
			</tr>
			<tr class="datagrid">
				<td width="89%">LG with 100% Margin</td>
				<td width="11%" align="center">LG100</td>
			</tr>
			<tr class="datagrid">
				<td width="89%">LC of prime bank</td>
				<td width="11%" align="center">LCPB</td>
			</tr>
			<tr class="datagrid">
				<td width="89%">Bank's Own Deposit</td>
				<td width="11%" align="center">BOD</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<form name="myfrm" method="post" class="normal">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Setup-&gt; Corporate  &amp; Agriculture Products -&gt;Facility Master
			</tr>
		</table>		
<br>
										<table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1 tableBg">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr class="dataheader">
														<td colspan="2"><b>Facility Master</b></td>
													</tr>
													<tr>
														<td colspan="2">
														<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
															<tr>
																<td colspan="4">
																<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
																	<tr >
																		<td width="16%">Head of the Facility</td>
																		<td width="4%"><input type="radio" name="rad"
																			value="radiobutton" onClick="showFields()"
																			style="border-style: none"></td>
																		<td width="4%" align="right">&nbsp;</td>
																		<td width="8%">Facility</td>
																		<td width="25%"><input type="radio" name="rad"
																			value="radiobutton" onClick="showFields()"
																			style="border-style: none"></td>
																		<td width="20%" id="subcateg1"
																			style="visibility: hidden">Head of the Facility</td>
																		<td width="23%" id="subcateg2"
																			style="visibility: hidden"><select
																			name="selProd"
																			onChange="getValue()">
																			<option selected value="0">--Select--</option>
																			<%	HashMap h = new HashMap();
																				h.put("value", "parent");
																				h.put("page","facility");
																				h.put("parent", "0");
																				h.put("hidMethod", "getFacility");

																				HashMap hp1 = new HashMap();
																				hp1.put("BeanId", "facilitymaster");
																				hp1.put("MethodName", "getData");
																				hp1.put("BeanParam", h);%>
																			<lapschoice:selecttag value='<%=hp1%>' />
																		</select><input type="hidden" name="hid_selProd"></td>
																	</tr>
																</table>
																</td>
															</tr>
															<tr id="categ">
																<td width="23%" id="catlab">Facility</td>
																<td width="40%"><input type="text"
																	name="txtcat_name" size="48" maxlength="50"
																	onBlur="JavaScript:this.value =trim(this.value)"
																	onKeyPress="allowAlphaSpaIntPunct()"> <b><span
																	onClick="showProduct();" style="cursor: hand"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"></span></b></td>
																<td width="14%" id="typelabel">Type</td>
																<td width="23%" id="typecombo"><select
																	name="seltype">
																	<option value='' selected>----Select----</option>
																	<option value="F">Funded</option>
																	<option value="NF">Non Funded</option>
																</select></td>
															</tr>
															<tr>
																<td width="23%" style="visibility: hidden"
																	id="idfaccode1">Code&nbsp;</td>
																<td width="40%" style="visibility: hidden"
																	id="idfaccode2" nowrap="nowrap"><select name="txt_code">
																	<option value='' selected>----Select----</option>
																	<option value="WC">Working Capital</option>
																	<option value="TL">Term Loan</option>
																	<!--<option value="SEC">Secured Advances</option>
																	<option value="UNSEC">Unsecured Advances</option>
																	<option value="BOD">Bank's Own Deposit</option>
																	<option value="LC100">LC with 100% Margin</option>
																	<option value="LG100">LG with 100% Margin</option>
																	<option value="LCPB">LC of prime bank</option>-->
																</select><span onClick="showCodes('Y')" style="cursor: hand">&nbsp;&nbsp;?</span>
																(Click the Question mark to view codes)</td>
																<td width="14%" style="visibility: hidden" id="scheme1">Scheme
																Code</td>
																<td width="23%" id="scheme2" style="visibility: hidden;">
																<input type="text" name="txt_schemecode" maxlength="5"
																	value=""></td>
															</tr>
															<tr>
																<td width="23%">Sequence Order</td>
																<td WIDTH="40%"><INPUT TYPE="text"
																	NAME="txt_seqorder" ONKEYPRESS="allowInteger()"></td>
																<td WIDTH="21%" id="fac">Nature of facility</td>
																<td WIDTH="23%" id="fac1"><SELECT NAME="facility1">
																	<OPTION VALUE="0" selected>--Select--</OPTION>
																	<OPTION VALUE="1">Working Capital</OPTION>
																	<OPTION VALUE="2">Term Loan</OPTION>
																</SELECT></td>
															<tr>
																<td id="idfacstatus1">Facility Status (Only for
																Corporate &amp; Tertiary)</td>
																<td id="idfacstatus2"><select name="selstatus">
																	<option value='S' selected>----Select----</option>
																	<option value="A">Active</option>
																	<option value="I">In Active</option>
																</select></td>
															</tr>
															<tr id="facfor">
															   <td align="left">Facility For <span class="mantatory">*</span> </td>
																<td align="left">
																	<select name="sel_facilityfor">
																		<option value="s" selected="selected">--Select--</option>
																		<option value="c">Corporate</option>
																		<option value="a">Agriculture</option>
																	</select>
																</td>
															</tr>
															 <tr id="action">
															<td width="">Active</td>
									                        <td width=""><select name="sel_active">
									                            <option value="S" selected="selected">--Select--</option>
									                            <option value="E">Enable</option>
									                            <option value="D">Disable</option>
									                            </select>
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
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidcat_id"> 
<input type="hidden" name="hidcat_parent" value="0">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
<br>
</body>
</html>
