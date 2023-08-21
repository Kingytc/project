<%@include file="../share/directives.jsp"%>
<%ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
			ArrayList arrCol = new ArrayList();%>
<html>
<head>
<title>Legal Opinion</title>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/legal_opinion.js"></script>
<script>
var branchpanel="<%=Helper.correctNull((String)hshValues.get("branch_panel"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var application_receivedate="<%=Helper.correctNull((String)hshValues.get("application_receivedate"))%>";
</script>
</head>
<body onload="callLoading()">
<form name="fininc" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td class="page_flow">Home -&gt; Retail -&gt; Application
				-&gt; Loan Particulars -&gt; Proposed/Offered Asset - &gt; Legal Opinion</td>

			</tr>
		</table>
		<table width="100%" border="0" cellpadding="0" cellspacing="0"
			class="outertable">
			<tr>
				<td><lapschoice:application /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="5" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp"
					flush="true">
					<jsp:param name="tabid" value="5" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="1" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td colspan="5"><b>Legal Opinion</b></td>
					</tr>
					<tr>
						<td width="7%" nowrap>Date of Entry</td>
						<td colspan="2">
						<table border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><input type="text" name="TxtEntryDt" size="11"
									maxlength="10" tabindex="1"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate(application_receivedate,document.forms[0].TxtEntryDt.value)"
									value="<%=Helper.correctNull((String)hshValues.get("entry_date"))%>">
								<td colspan="2"><a href="#"
									onClick="callCalender('TxtEntryDt')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="2"></a></td>
							</tr>
						</table>
						</td>
						<td width="5%">Date Sent<span class="mantatory">*&nbsp;</span></td>
						<td width="37%">
						<table border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><input type="text" name="TxtsentDt" size="11"
									maxlength="10" tabindex="3"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate1(document.forms[0].TxtEntryDt.value,document.forms[0].TxtsentDt.value)"
									value="<%=Helper.correctNull((String)hshValues.get("Send_date"))%>">
								<td colspan="2"><a href="#"
									onClick="callCalender('TxtsentDt')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="4"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="7%" nowrap>Date received</td>
						<td colspan="2">
						<table border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><input type="text" name="TxtRecdDt" size="11"
									maxlength="10" tabindex="5"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);comparedate2(document.forms[0].TxtsentDt.value,document.forms[0].TxtRecdDt.value)"
									value="<%=Helper.correctNull((String)hshValues.get("Recd_date"))%>">
								<%out.println(Helper.correctNull((String)hshValues.get("Recd_date"))); %>
								
								<td colspan="2"><a href="#"
									onClick="callCalender('TxtRecdDt')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="6"></a></td>
							</tr>
						</table>
						</td>
						<td width="5%" nowrap>Search Report Date</td>
						<td width="37%"><input type="text" name="TxtSearchDt"
							size="11" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate)"
							value="<%=Helper.correctNull((String)hshValues.get("search_date"))%>">
						<a href="#" onClick="callCalender('TxtSearchDt')"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0" tabindex="4"></a></td>
						<!--prakash-->
					</tr>
					<tr>
						<td nowrap width="7%">Ref.No.</td>
						<td colspan="2" valign="top"><input type="text"
							name="TxtRefNo" size="38" maxlength="20" tabindex="7"
							value="<%=Helper.correctNull((String)hshValues.get("ref_no"))%>"
							onKeyPress="notAllowedDouble()">
						<td width="5%">Dated</td>
						<td valign="top" width="37%">
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td><input type="text" name="TxtRefDt" size="11"
									maxlength="10" tabindex="8"
									onBlur="checkDate(this);checkmaxdate(this,currentDate)"
									value="<%=Helper.correctNull((String)hshValues.get("ref_date"))%>">
								<td colspan="2"><a href="#"
									onClick="callCalender('TxtRefDt')"
									title="Click to view calender" border=0><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="9"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2" nowrap>Whether on the branch panel? &nbsp;<select
							name="sel_branchpanel" tabindex="13" onChange="selLawyerNme()">
							<option value="Y" selected>Yes</option>
							<option value="N">No</option>
						</select></td>
						<td nowrap width="70%"></td>
						<td colspan="2" nowrap>&nbsp;</td>
					</tr>
					<tr>
						<td width="7%" nowrap>Lawyer Name <span
							class="mantatory">*&nbsp;</span></td>
						<td valign="top"><input type="hidden" name="hid_sno"
							size="38" maxlength="50"> <input type="text"
							name="TxtLawDet" size="38" maxlength="49" tabindex="10" readonly><span
							onClick="javascript:callsupnam()" style="cursor: hand">&nbsp;&nbsp;<img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span>
						<td valign="top" id="b1">
						<td width="5%">Designation</td>
						<td valign="top" width="37%"><input type="text"
							name="TxtDesign" size="25" maxlength="49" tabindex="12" readOnly>
						</td>
					</tr>
					<tr>
						<td colspan="2" nowrap>Whether legal opinion Indicated
						clear/marketable title <select name="LegOpFl" tabindex="14">
							<option value="Y" selected>Yes</option>
							<option value="N">No</option>
						</select></td>
						<td nowrap width="31%"></td>
						<td colspan="2" nowrap>Whether Valid mortgage can be created
						in favour of our bank <select name="MortFl" tabindex="15">
							<option value="Y" selected>Yes</option>
							<option value="N">No</option>
						</select></td>
					</tr>
					<tr>
						<td nowrap width="7%">Conditions</td>
						<td colspan="2" valign="top"><textarea name="TxtCond"
							tabindex="16" cols="42" wrap="VIRTUAL" rows="4"
							onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
							value="<%=Helper.correctNull((String)hshValues.get("conditions"))%>"></textarea>
						</td>
						<td width="5%">Remarks</td>
						<td valign="top" width="37%"><textarea name="TxtRemark"
							tabindex="17" cols="42" wrap="VIRTUAL" rows="4"
							onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,299)" onKeyUp="textlimit(this,299)"
							value="<%=Helper.correctNull((String)hshValues.get("remarks"))%>"></textarea>
						</td>
					</tr>
					<tr>
						<!--prakash-->
						<!-- changed by madhura -->
						<td nowrap>Past 30 Year's <br>
						Search Report</td>
						<td nowrap colspan="2"><textarea name="TxtPast" tabindex="16"
							cols="42" wrap="VIRTUAL" rows="4"
							onKeyPress="notAllowSingleAndDoubleQuote();textlimit(this,2999)" onKeyUp="textlimit(this,2999)"
							value="<%=Helper.correctNull((String)hshValues.get("past_details"))%>"></textarea>
						</td>
						<td nowrap width="5%">&nbsp;</td>
						<td nowrap width="37%">&nbsp;</td>
						<!--prakash-->
					</tr>
				</table>
		</table>
		<br>
		<lapschoice:combuttonnew
			btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<tr>
		<td>
		<table width="98.3%" border="0" cellspacing="1" cellpadding="5"
			class="outertable">
			<tr class="dataheader">
				<td width="5%"></td>
				<td width="12%" align="center" nowrap>Opinion By </td>
				<td width="10%" align="center" nowrap>Date Sent</td>
				<td width="15%" align="center" nowrap>Date Received</td>
				<td width="13%" align="center" nowrap>Date of Entry</td>
				<td width="12%" align="center">Designation</td>
				<td width="9%" align="center">Opinion Ref. No </td>
				<td width="17%" align="center">Opinion Date</td>
			</tr>
			<%if (arryRow.size() > 0) {
                    	  
                    	  int size=arryRow.size();
				for (int i = 0; i < arryRow.size(); i++) {
					arrCol = (ArrayList) arryRow.get(i);
					
					%>
			<tr class="datagrid">
				<td width="5%"><input type="radio" name="lopra"
					value="<%=arrCol.get(0)%>" style="border-style: NONE"
					onClick="selApplicant('<%=arrCol.get(0)%>', '<%=arrCol.get(1)%>','<%=arrCol.get(2)%>','<%=arrCol.get(3)%>','<%=arrCol.get(4)%>','<%=arrCol.get(5)%>','<%=arrCol.get(6)%>','<%=arrCol.get(9)%>','<%=arrCol.get(10)%>', '<%=arrCol.get(11)%>','<%=arrCol.get(12)%>','<%=arrCol.get(13)%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString((String)arrCol.get(15)))%>','<%=arrCol.get(16)%>','<%=i%>','<%=size%>')">


				<input type="hidden" name="hidcond" value="<%=arrCol.get(7)%>">
				<input type="hidden" name="hidremarks" value="<%=arrCol.get(8)%>">
				<input type="hidden" name="hidpast" value="<%=arrCol.get(14)%>">
				</td>
				<td width="12%"> <%=arrCol.get(15)%></td>
				<td width="10%" style="text-align: center"> <%=arrCol.get(10)%></td>
				<td width="15%" style="text-align: center"> <%=arrCol.get(11)%></td>
				<td width="13%" style="text-align: center"> <%=arrCol.get(2)%></td>
				<td width="12%"> <%=arrCol.get(16)%></td>
				<td width="9%"> <%=arrCol.get(3)%></td>
				<td width="17%" style="text-align: center"> <%=arrCol.get(4)%></td>
			</tr>
			<%}
			} else {
			}
			%>
		</table>
		</td>
	</tr>
	<tr>
		<td></td>
	</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidsno"> <INPUT TYPE="hidden" name="radLoan" value="Y">
</form>
</body>
</html>
