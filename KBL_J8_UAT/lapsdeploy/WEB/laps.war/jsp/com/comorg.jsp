<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Organisation and Employees</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comorg.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" name="fltintrate" class="normal"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td valign="top" colSpan="5"><jsp:include
			page="../share/applurllinkscom.jsp" flush="true"> <jsp:param name="pageid" value="5" /> 
<jsp:param name="cattype" value="<%=strCategoryType%>" /> <jsp:param name="ssitype" value="<%=strSSIType%>" /> 
</jsp:include></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable"> <tr> <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; 
Application -&gt; Org. &amp; Emp. -&gt; Organisation</td></tr> </table><span style="display: none"><lapschoice:borrowertype /></span><lapschoice:application /> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"> <tr> <td> <table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="60%"> <tr align="center"> <td width="15%" class="sub_tab_active"><b>Organisation</b></td><td width="15%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('comemp.jsp','combanking','getEmpData')"> 
Mgmt. &amp; Employees</a></b></td><td width="15%" class="sub_tab_inactive"><b><a href="#"
					onclick="javascript:callLink('commis.jsp','combanking','getMisData')"> 
Other Management Details</a></b></td><td width="15%" class="sub_tab_inactive"><b> 
<a href="#"
					onclick="javascript:callLink('comotherinfo.jsp','combanking','getInfoData')">Other 
Info</a></b></td></tr> </table></td></tr> </table><table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable"> <tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable border1"> <tr> <td valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0"
					class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="1" cellpadding="3"> 
<tr align="center" class="dataheader"> <td><b>Management Personal Name</b></td><td><b>Functions, 
responsibilities </b></td><td><b>Working Since</b></td><td><b>Experience in Years</b></td><td><b>Reporting 
to</b></td></tr> <tr align="center"> <td><input type="text" name="technical" size="35" value=""
									maxlength="49" onKeyPress="notAllowSplChar()"></td><td><input type="text" name="functions" size="35" value=""
									maxlength="199" onKeyPress="notAllowSplChar()"></td><td><input type="text" name="working" size="5" value=""
									onKeyPress="allowNumber(this)" maxlength="4"
									onBlur="checkcurrentyear(this)"></td><td><input type="text" name="experience" size="5"
									onKeyPress="allowNumber(this)" maxlength="2"></td><td><input type="text" name="reporting" size="20"
									maxlength="30" onKeyPress="notAllowSplChar()"></td></tr> 
</table></td></tr> </table></td></tr> </table></table><br> <lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' /><br> 
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1"> <tr> <td valign="top"> <table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable"> <tr> <td> <table width="100%" border="0" cellspacing="1" cellpadding="3"
					align="center" class="outertable"> <tr class="dataheader"> 
<td WIDTH="5%"><b>&nbsp;</b></td><td ALIGN="CENTER" WIDTH="20%"><b>Management 
Personal Name</b></td><td ALIGN="CENTER" WIDTH="20%"><b>Functions, responsibilities 
</b></td><td ALIGN="CENTER" WIDTH="15%"><b>Working Since</b></td><td ALIGN="CENTER" WIDTH="15%"><b>Experience 
in Years</b></td><td ALIGN="CENTER" WIDTH="15%"><b>Reporting to</b></td></tr> 
</table></td></tr> <tr> <td> <%
					ArrayList arrRow = new ArrayList();
					if (arrRow.size() > 6) {
				%> <div class="cellContainer"> <%
					}
				%> <table width="100%" border="0" cellspacing="1" cellpadding="3"> 
<%
						arrRow = (ArrayList) hshValues.get("arrRow");
						if (arrRow != null && arrRow.size() > 0) {
							for (int i = 0; i < arrRow.size(); i++) {
								ArrayList arrCol = new ArrayList((ArrayList) arrRow.get(i));
					%> <tr class="datagrid"> <td WIDTH="5%"><input type="radio" name="selradio" style="border: none"
							onclick="SelectValues('<%=arrCol.get(0)%>','<%=arrCol.get(1)%>',
							'<%=arrCol.get(2)%>','<%=arrCol.get(3)%>', '<%=arrCol.get(4)%>', '<%=arrCol.get(5)%>')"> 
</td><td WIDTH="20%"><%=arrCol.get(1)%>&nbsp;</td><td WIDTH="20%"><%=arrCol.get(2)%>&nbsp;</td><td WIDTH="15%"><%=arrCol.get(3)%>&nbsp;</td><td WIDTH="15%"><%=arrCol.get(4)%>&nbsp;</td><td WIDTH="15%"><%=arrCol.get(5)%>&nbsp;</td></tr> 
<%
						}
						}
					%> </table><%
					if (arrRow.size() > 6) {
				%> </div><%
					}
				%> </td></tr> </table></td></tr> </table><lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden"
	value="" name="hidsno" /> </form>
</body>
</html>
