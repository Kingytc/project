<%@ include file="../share/directives.jsp"%>
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
<title>Application Status</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/MSME_Reports.js">
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var param="";
var userid ="<%=(String) session.getAttribute("strUserId")%>";
var rights ="<%=(String) session.getAttribute("strGroupRights")%>";
var report = "<%=str_report%>";
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

</head>

<body>
<form class="normal"><iframe
	height="0" width="0" id="ifrm" frameborder=0 style="border: 0"></iframe>
<br>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Reports -&gt;
		OnLine Reports &gt; Annexure II</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="20">
	<tr>
		<td valign="middle">
		<table class="outertable border1" border="0" cellspacing="0" cellpadding="3"
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
							</tr>
							<tr>
								<%
									if ("C".equals((String) request.getParameter("report"))) {
								%>
								<td width="36%" align="center"><select name="sellevel"
									style="width: 120" onChange="LoadValues()">
									<option value="" selected>---Select---</option>
									<option value="State">State</option>
									<option value="City">City</option>
									<option value="S/C">City within a State</option>
								</select></td>
								<%
									} else {
								%>
								<td width="39%" align="center"><select name="sellevel"
									style="width: 100" onChange="selectValues()" tabindex="1">
									<option selected>---Select---</option>
									<laps:reptag beanid="setupreport" methodname="getLevels"
										param="" />
								</select></td>
								<%
									}
								%>
							</tr>
							<%
								if ("C".equals((String) request.getParameter("report"))) {
							%>
							<tr id="state">
								<td width="36%" align="center" height="35"><select
									name="sel_state" onchange="LoadcityValues()">
									<option value="0" selected>--Select--</option>
									<laps:stateflexmaster />
								</select></td>
							</tr>
							<%
								}
							%>
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
								<td width="4%" style="visibility: hidden"><select
									name="rpselect2" size="11" style="width: 10" tabindex="4"
									multiple id="acctclass">
									<option value="app_no">Application Number</option>
									<option value="perapp_fname,perapp_lname">Applicant
									Name</option>
									<option value="loan_recmdamt as  loan_recmdamt">Amount</option>
									<option
										value="to_char(loan_receivedate,'DD/MM/YYYY') as app_date,to_char(inward_docreceivedon,'DD/MM/YYYY') as inward_date">Applied
									Date</option>
									<!--<option value="app_status">Application Status</option>-->
									<option
										value="cat2.cat_name,cat1.cat_name as scatname,prd_desc">Product
									Name</option>
									<option
										value="to_char(app_processdate,'DD/MM/YYYY') as app_processdate">Date</option>
									<option value="org_name">Branch</option>
								</select> <!-- <option value="convert(varchar,mail_date,103) as mail_date">Flowpoint 
                            Received Date</option>
                            <option value="wrk_flowname">Current Flowpoint Action</option>  -->
								</td>
							</tr>
						</table>
						</td>
					</tr>
					
					
					 <tr align="center"> 
                        <td align="center" colspan="2"> 
                          <table class="outertable" width="60%" border="1" cellspacing="0" cellpadding="3" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td width="21%" align="center">Period 
                                      </td>
                                    <td width="79%" align="center">&nbsp;
                                      <input type="text" name="txtDate" maxlength="21" readonly size="27" onFocus="document.forms[0].rprunreport.focus();">
                                      <a href="#" onClick="showPeriod()" class="blackfont" tabindex="5"><b>?</b></a> 
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
<lapschoice:combuttonnew btnnames="Run Report_Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <input	type="hidden" name="hidOrgCode"> <input type="hidden"
	name="hidOpFields"> <input type="hidden" name="hidSelFields">
<input type="hidden" name="hidStatus"> <input type="hidden"
	name="userid"> <input type="hidden" name="repname"
	value="Personal Application Status Report"> <input
	type="hidden" name="txtprofile_name"> <input type="hidden"
	name="hidParam"> <input type="hidden" name="hidPage"
	value="perrunappstatus.jsp"> <input type="hidden"
	name="hidusr_id"> <input type="hidden" name="txtSaveDate"
	value='<%=Helper.getCurrentDateTime()%>'> <input type="hidden"
	name="hidOrgName"></form>
</body>
</html>
