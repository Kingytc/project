<%@include file="../share/directives.jsp"%>
<%
	request.setAttribute("_cache_refresh", "true");
%>
<%
	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	arrRow = (ArrayList) hshValues.get("arrRow");
	String existing = Helper.correctNull((String) hshValues.get("existing"));
	request.setAttribute("scode", "yyy");
	String pageid = Helper.correctNull((String) request.getParameter("pageid"));
	String strEmployment=(String)session.getAttribute("strEmployment");
	String strapptype = Helper.correctNull((String) request.getParameter("corp"));
%>
<html>
<head>
<title>Factory Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/comappmastersearch.jsp";
		document.forms[0].submit();
	}
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16)
{
	document.forms[0].seltype.value=val2;
	document.forms[0].comapp_name.value=val3;
	document.forms[0].comapp_address.value=val4;
	document.forms[0].comapp_pin.value=val9;
	document.forms[0].comapp_ph.value=val10;
	document.forms[0].comapp_fax.value=val11;	
	document.forms[0].comapp_sno.value=val1;
	document.forms[0].comapp_city.value=val6;
	document.forms[0].comapp_state.value=val8;
	document.forms[0].comapp_factpremises.value=val12;
	document.forms[0].comapp_dist.value = val14;
}
function clearfields()
{
	document.forms[0].comapp_name.value="";
	document.forms[0].comapp_address.value="";
	document.forms[0].comapp_city.value="";
	document.forms[0].comapp_state.value="";
	document.forms[0].comapp_pin.value="";
	document.forms[0].comapp_ph.value="";
	document.forms[0].comapp_fax.value="";
	document.forms[0].seltype.value="0";
}




function disableFields(val)
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
		else if(document.forms[0].elements[i].type=="checkbox")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
} 

function onloading()
{	  
	disableFields(true);
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div> 
<form name="frmpri" method="post" class="normal">
<%if(strapptype.equalsIgnoreCase("C")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> 
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Factory details</td>
	</tr>
  </table>
<%} else if(strapptype.equalsIgnoreCase("R")) { %>
 <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Demographics</td>
    </tr>
  </table>
  <%} %>
<lapschoice:application />

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<%}%>
		<%if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
			<tr>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="28"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							class="outertable border1">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2"
									class="outertable">
									<tr>
										<td width="10%">Select Branch/<br>Factory type<span class="mantatory"><b>*</b></span></td>
										<td align="left" width="20%"><select name="seltype">
											<option value="0">---Select--</option>
											<option value="1">Factory</option>
											<option value="2">Branches</option>
											<option value="3">Godown</option>
											<option value="4">Sales depots/ Outlets</option>
										</select></td>
										<td width="15%" nowrap="nowrap">Name of the Factory/ <br>
										Branches/ Godown<span class="mantatory"><b>*</b></span></td>
										<td width="20%"><input type="text" name="comapp_name"
											size="35" maxlength="75" style="text-align: left;"
											onKeyPress="notAllowSplChar()"></td>
										<td width="6%">Address<span class="mantatory"><b>*</b></span></td>
										<td align="left" width="15%"><textarea
											name="comapp_address" cols="25" rows="4"
											style="text-align: left;" onkeypress="notAllowSplChar();textlimit(this,999)" onKeyUp="textlimit(this,999)"
											wrap="VIRTUAL"> 
									</textarea></td>
									</tr>
									<tr>
										<td align="left">City<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_city" size="30"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()"></td>
										<td>District<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_dist" size="25"
											maxlength="30" style="text-align: left;"
											onKeyPress="">
											<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get(""))%>"></td>
										<td><%=ApplicationParams.getZipName()%><span
											class="mantatory"><b>*</b></span></td>
										<td align="left"><input type="text" name="comapp_pin"
											size="12" maxlength="<%=ApplicationParams.getZipValue()%>"
											style="text-align: left;" onKeyPress=""
											OnBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
										</td>
									</tr>
									<tr>
										<td>State<span class="mantatory"><b>*</b></span></td>
										<td><input type="text" name="comapp_state" size="25"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()"></td>
										<td align="left">Phone No.</td>
										<td><input type="text" name="comapp_ph" size="25"
											maxlength="20" style="text-align: left;"
											onKeyPress="allowPhone()"></td>
										<td>Fax</td>
										<td><input type="text" name="comapp_fax" size="20"
											maxlength="20" style="text-align: left;"
											onKeyPress="allowPhone()"></td>
									</tr>
									<tr>
										<td>Premises</td>
										<td align="left"><select name="comapp_factpremises"
											size="1">
											<option Selected="selected" value="0">--Select--</option>
											<option value="1">Owned</option>
											<option value="2">Leased</option>
											<option value="3">Rented</option>
										</select></td>
										<td colspan="4">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
				<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable linebor">
									<tr class="dataheader" align="center">
										<td width="10%">Select</td>
										<td width="20%">Name of the Factory/ Branches/ Godown
										Details</td>
										<td width="25%">Address</td>
										<td width="10%">City</td>
										<td width="10%">State</td>
										<td width="10%">Phone No</td>
										<td width="15%">Premises</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<%if(arrRow.size()>6){ %>
								<div class="cellContainer">
								<%} %>
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
									<%
										if (arrRow != null && arrRow.size() > 0) {
											String temp = "";
											String strpremises = "";
											for (int i = 0; i < arrRow.size(); i++) {
												arrCol = (ArrayList) arrRow.get(i);
									%>
									<tr class="datagrid">
										<td width="10%" align="center">
										<%
											if (!(temp.equals(Helper
															.correctNull((String) arrCol.get(2))))) {
														temp = Helper.correctNull((String) arrCol.get(2));
														if (temp.equals("1")) {
															out.println("Factory");
														} else if (temp.equals("2")) {
															out.println("Branches");
														} else if (temp.equals("3")) {
															out.println("Godown");
														} else if (temp.equals("4")) {
															out.println("Sales depots/ Outlets");
														}
													}
										%> &nbsp;
										<td width="20%"><B><A
											HREF="javascript:selectValues('<%=Helper.correctNull((String) arrCol.get(1))%>','<%=Helper.correctNull((String) arrCol.get(2))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(3))%>','<%=Helper.correctNull((String) arrCol.get(4))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(5))%>','<%=Helper.correctNull((String) arrCol.get(6))%>'
                            	,'<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>',
                            	'<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.correctNull((String) arrCol.get(10))%>','<%=Helper.correctNull((String) arrCol.get(11))%>','<%=Helper.correctNull((String) arrCol.get(12))%>','<%=Helper.correctNull((String) arrCol.get(13))%>','<%=Helper.correctNull((String) arrCol.get(14))%>','<%=Helper.correctNull((String) arrCol.get(14))%>')"><%=Helper.correctNull((String) arrCol.get(3))%></A></B>
										<td width="25%"><%=Helper.correctNull((String) arrCol.get(4))%>
										</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(8))%>&nbsp;</td>
										<td width="10%"><%=Helper.correctNull((String) arrCol.get(10))%>&nbsp;</td>
										<td width="15%">
										<%
											strpremises = Helper.correctNull((String) arrCol.get(12));
													{
														if (strpremises.equals("1")) {
															out.println("Owned");
														} else if (strpremises.equals("2")) {
															out.println("Leased");
														} else if (strpremises.equals("3")) {
															out.println("Rented");
														}
													}
										%>&nbsp;</td>
									</tr>
									
									<%
										}
										%>
										
										<%}else {
									%>
									<tr class="datagrid">
										<td align="center" colspan="8">No Data Found</td>
									</tr>
									<%
										}
									%>
								</table>
								<%if(arrRow.size()>6){ %></div><%} %>
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
<lapschoice:hiddentag pageid='<%=pageid%>' /> 
<%String strappno = request.getParameter("appno");%> 

<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 	
<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
<input type="hidden" name="comapp_sno" value="">
<input type="hidden" name="hidPage" value="<%=pageid%>">
<input type="hidden" name="comapp_id" value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)request.getParameter("hidappstatus"))%>">
<input type="hidden" name="hidappexist" value="<%=Helper.correctNull((String)request.getParameter("hidappexist"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="exist" value="<%=Helper.correctNull((String) hshValues.get("existing"))%>">
<input type="hidden" name="scode" value="yy"> 
<input type="hidden" name="hidappexist"	value="<%=Helper.correctNull((String) request
.getParameter("hidappexist"))%>">
	 <input type="hidden" name="cmdsave" value="" disabled>
<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>
