<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%request.setAttribute("_cache_refresh", "true");%>
<%ArrayList vecRow = new ArrayList();
			ArrayList vecCol = new ArrayList();
			vecRow = (ArrayList) hshValues.get("vecRow");
			String existing = Helper.correctNull((String) hshValues
					.get("existing"));
			String strapptype = Helper.correctNull((String)request.getParameter("corp"));
			if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			request.setAttribute("scode", "yyy");
			
			String strEmployment=(String)session.getAttribute("strEmployment");		
			String pageid = request.getParameter("pageid");
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
			%>
<html>
<head>
<title>Factory Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callDescHelp(page)
{	
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = appURL+"action/comindustrymasterhelp.jsp?page="+page;
		var title = "IndustryHelp";
		var prop = "scrollbars=no,width=650,height=400";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/comappmastersearch.jsp";
		document.forms[0].submit();
	}
}

function doClose1()
{
	window.close();
}

function selectValues(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14)
{	
	document.forms[0].comapp_div_id.value=val1;
	document.forms[0].comapp_div_name.value=val2;
	document.forms[0].comapp_div_address.value=val3;
	document.forms[0].comapp_div_city.value=val5;
	document.forms[0].comapp_div_state.value=val7;
	document.forms[0].comapp_div_pin.value=val8;
	document.forms[0].comapp_div_phone.value=val9;
	document.forms[0].comapp_div_fax.value=val10;	
	document.forms[0].comapp_divisiontype.value=val11;
	document.forms[0].comapp_companyid.value=val12;
	document.forms[0].comapp_div_dist.value=val5;
	
}

function clearfields()
{
	document.forms[0].comapp_div_id.value="";
	document.forms[0].comapp_div_name.value="";
	document.forms[0].comapp_div_address.value="";
	document.forms[0].comapp_div_city.value="";
	document.forms[0].comapp_div_state.value="";
	document.forms[0].comapp_div_pin.value="";
	document.forms[0].comapp_div_phone.value="";
	document.forms[0].comapp_div_fax.value="";	
	document.forms[0].comapp_divisiontype.value="";
}


function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='textarea'  )
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=='select-one'  )
		{
			document.forms[0].elements[i].disabled=val;
		}	 
	}
}
  
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if (ConfirmMsg("101"))
		{
			document.forms[0].hidAction.value ="Delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateDivisionDetails";
			document.forms[0].hidBeanGetMethod.value="getDivisionDetails";	
			document.forms[0].hidBeanId.value="commappmaster";
			document.forms[0].hidSourceUrl.value="action/comappdivision.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
    }
	else
	{
		ShowAlert(158);
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
<body onload="onloading()" class="bgcolor">
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
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="29" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="29"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="29"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
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
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant -&gt; Customer Profile -&gt; Sister Concerns</td>
	</tr>
  </table>
  <%} else if(strapptype.equalsIgnoreCase("R")){ %>
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
			<jsp:param name="pageid" value="29"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0 " cellspacing="0" cellpadding="5"
			class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="2"
					class="outertable">
					<tr>
						<td width="10%" nowrap="nowrap">Concern type<span
							class="mantatory">*&nbsp;</span></td>
						<td width="19%"><select name="comapp_divisiontype" size="1"
							tabindex="1">
							<option Selected="selected" value="">--Select--</option>
							<option value="Division">Division</option>
							<option value="Sister concern">Sister Concern</option>
							<option value="Group concern">Group Concern</option>
							<option value="O">Share Holders</option>
							<option value="D">Directors</option>
							<option value="SP">Sole Proprietor</option>
							<option value="PT">Partner</option>
							<option value="OT">Others</option>
							<option value="T">Trustee</option>
						</select></td>
						<td width="11%">Concern Name<span class="mantatory">*&nbsp;</span></td>
						<td align="left" width="25%"><input type="text"
							name="comapp_div_name" size="30" maxlength="75"
							onKeyPress="notAllowSplChar()"></td>
						<td width="10%">Address<span class="mantatory">*&nbsp;</span></td>
						<td align="left" width="25%"><textarea
							name="comapp_div_address" cols="25" rows="4"
							style="text-align: left;" onkeypress="notAllowSplChar();textlimit(this,999)" onKeyUp="textlimit(this,999)"
							wrap="VIRTUAL">                                
                                </textarea></td>
					</tr>
					<tr>
						<td align="left" width="10%">City<span class="mantatory">*&nbsp;</span></td>
						<td width="19%"><input align="left" type="text"
							name="comapp_div_city" size="25" style="text-align: left;"
							onKeyPress="notAllowSplChar();allowAlphabets()"></td>
						<td>District<span class="mantatory"><b>*</b></span></td>
						<td><input type="text" name="comapp_div_dist" size="25"
							maxlength="30" style="text-align: left;"
							onKeyPress="">
							<input type="hidden" name="hid_dist" size="5" value=""></td>
						<td width="11%">State<span class="mantatory">*&nbsp;</span></td>
						<td width="25%"><input align="left" type="text"
							name="comapp_div_state" size="30" maxlength="30"
							style="text-align: left;" onKeyPress="notAllowSplChar();allowAlphabets()"></td>
					</tr>
					<tr>
						<td width="10%"><%=ApplicationParams.getZipName()%><font
							color="#FF0000"><b>*</b></font></td>
						<td align="left" width="25%"><input type="text"
							name="comapp_div_pin" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>"
							style="text-align: left;" onKeyPress="allowInteger()"
							OnBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
						</td>
						<td align="left" width="10%">Phone No.</td>
						<td width="19%"><input type="text" name="comapp_div_phone"
							size="20" maxlength="20" style="text-align: left;"
							onKeyPress="allowPhone()"></td>
						<td width="11%">Fax</td>
						<td width="25%"><input type="text" name="comapp_div_fax"
							size="20" maxlength="20" style="text-align: left;"
							onKeyPress="allowPhone()"></td>
					</tr>
					<tr>
						<td width="10%">BSR Code</td>
						<td width="25%"><input type="hidden" name="comapp_indcode"
							size="20" maxlength="23" style="text-align: left;" value="">
						<input type="text" name="comapp_companyid" size="30"
							maxlength="15" style="text-align: left;"
							onKeyPress="notAllowSpace()" tabindex="7" readOnly="readonly">
						</td>
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
				<table width="98.3%" border="0" cellspacing="1" cellpadding="3" align="center"
					class="outertable">
					<tr align="center" class="dataheader">
						<td width="25%">Concern Name</td>
						<td width="15%">Concern Type</td>
					</tr>
					<%if (vecRow!=null && vecRow.size() > 0) {
				for (int i = 0; i < vecRow.size(); i++) {
					vecCol = (ArrayList) vecRow.get(i);%>
					<tr class="datagrid">
						<td width="25%"><b><a
							href="javascript:selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(1))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(3))%>'
                            	,'<%=Helper.correctNull((String)vecCol.get(4))%>','<%=Helper.correctNull((String)vecCol.get(5))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(6))%>','<%=Helper.correctNull((String)vecCol.get(7))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(8))%>','<%=Helper.correctNull((String)vecCol.get(9))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(10))%>','<%=Helper.correctNull((String)vecCol.get(11))%>',
                            	'<%=Helper.correctNull((String)vecCol.get(12))%>','<%=Helper.correctNull((String)vecCol.get(13))%>')">
						<%=Helper.correctNull((String) vecCol.get(1))%></a></b></td>
						<%
						String strTemp="";
						if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("O")) {strTemp="Share Holders";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("D")) {strTemp="Directors";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("SP")) {strTemp="Sole Proprietor";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("PT")) {strTemp="Partner";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("OT")) {strTemp="Others";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("T")) {strTemp="Trustee";}
						else if(Helper.correctNull((String) vecCol.get(10)).equalsIgnoreCase("HC")) {strTemp="Trustee";}
						else{strTemp=Helper.correctNull((String) vecCol.get(10)); } %>
						<td width="15%"><%=strTemp%></td>
					</tr>

					<%}%>
					<tr class="datagrid">
						<td width="25%">&nbsp;</td>
						<td width="15%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>

			<%} else {%>
			<tr class="datagrid">
				<td align="center" colspan="6">No Data Found</td>
			</tr>
			<%}%>
		</table>
		</td>
	</tr>
</table>

<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="comapp_sno" value=""> 
	
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)request.getParameter("hidDemoId")%>">
		 <input type="hidden" name="cmdsave" value="" disabled>
	
	<input type="hidden" name="comapp_div_id"
	value="<%=Helper.correctNull((String)hshValues.get("comapp_div_id"))%>">
<input type="hidden" name="exist"
	value="<%=Helper.correctNull((String)hshValues.get("existing"))%>">
<input type="hidden" name="scode" value="yy"> <input
	type="hidden" name="hiddivcity"> <input type="hidden"
	name="hiddivstate">
	<input type="hidden" name="hidPage" value="<%=pageid%>">
<input type="hidden" name="hidEmployment" value="<%=Helper.correctNull((String)request.getParameter("hidEmployment"))%>">
</form>
</body>
</html>
