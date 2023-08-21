<%@ include file="../../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%
	String str_report = Helper.correctNull((String) request.getParameter("report"));
	String str_multiple = "";
	if (str_report.equalsIgnoreCase("C")) {
		str_multiple = "multiple";
	} else {
		str_multiple = "";
	}
%>
<html>
<head>
<title>ecurity Valuation Report</title>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/mis/per/per_securityvaluationreport.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var report = "<%=str_report%>";

</script>

</head>

<body onload="callonLoad();">
<form name="perappstat" method="post" class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home  -&gt; Reports -&gt;
		Security Valuation Report</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1 tableBg" border="0" cellspacing="0" cellpadding="3"
			align="center" width="65%">
			<tr>
				<td>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="5" align="center">
					<tr>
						<td colspan="2" height="30">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="3">
							<tr>
								<td width="39%" align="center">Organisation Level</td>
								<td width="39%" align="center" id="idsec1">Security Type</td>
							</tr>
							<tr>
								
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100px;" onChange="enablesectype();selectValues();" tabindex="1">
									<option selected>---Select---</option>
									 <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="secval" /> 
								</select></td>
								<td width="39%" align="center"  id="idsec2">
									 <select name="sel_securitytype">
								<option value="0">&lt;--Select--&gt;</option>
								  <lapschoice:reptag beanid="securitymaster" methodname="" param="'10','11','12','13','14','15','16','17','19','20'" /> 
								 </select>
							 </td>
								
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="75%" valign="top" colspan="2">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="4">
							<tr align="center">
								<td align="center" width="96%">Select Organisation</td>
								<td align="center" width="4%">&nbsp;</td>
							</tr>
							<tr align="center">
								<td width="96%"><select name="rpselect1" size="11"
									style="width: 230" tabindex="3" <%=str_multiple%>>
								</select></td>
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
<lapschoice:combuttonnew btnnames="Run Report_Reset" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode"> 
 <input type="hidden"
	name="userid">  <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName">
	<input type="hidden" name="hidsectype" value="'10','11','12','13','14','15','16','17','19','20'">
	</form>
</body>
</html>
