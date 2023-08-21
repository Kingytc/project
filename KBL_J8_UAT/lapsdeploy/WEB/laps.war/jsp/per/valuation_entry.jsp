<%@include file="../share/directives.jsp"%>
<%String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strSecId = Helper.correctNull((String) session.getAttribute("strSecId"));

String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid =5;
String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
session.setAttribute("valuationFlag", Helper.correctNull((String)hshValues.get("valuationFlag")));

%>
<html>
<head>
<title>Valuation Entry</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/per/pervaluationentry.js"></script>
<script>
var strsno="<%=Helper.correctNull((String)hshValues.get("strsno"))%>";
var varprdtype="<%=prd_type%>";
var varProAvailableFor="<%=strProAvailableFor%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function callLink(page,bean,method)
{ 
		if (document.forms[0].cmdsave.disabled)
		{
			document.forms[0].hidAction.value="";
		 	document.forms[0].hidBeanGetMethod.value=method;
		 	document.forms[0].hidBeanId.value=bean;
		 	document.forms[0].action=appURL+"action/"+page;
		 	document.forms[0].submit();
		}
		else 
		{
			ShowAlert(103);
		}
}	
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal">
 <% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Security </td>
	 <%}else if(strSessionModuleType.equals("DIGI")){%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt;Application -&gt; Security Master -&gt; Security </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Security</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET")){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
          
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td width="100%">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp"
					flush="true">
					<jsp:param name="tabid" value="6" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="3"
			class="outertable">
			<tr>
				<td>

				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable">
					<tr>
						<td colspan="8"><b>Valuation Entry</b></td>
					</tr>
					<tr>
						<td colspan="2">Date Sent<b><span class="mantatory">*&nbsp;</span></b>
						</td>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="30%"
							class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofsent" size="11"
									maxlength="10" tabindex="1"
									value="<%=Helper.correctNull((String)hshValues.get("send_date"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);">
								</td>
								<td><a href="#" onClick="callCalender1('txt_dateofsent')" title="Click to view calender">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0" tabindex="2"></a></td>
							</tr>
						</table>
						</td>
						<td>Date Received</td>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="30%"
							class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofvaluation" size="11"
									maxlength="10" tabindex="3"
									value="<%=Helper.correctNull((String)hshValues.get("valuation_dt"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);compareDate();">
								</td>
								<td><a href="#"
									onClick="callCalender1('txt_dateofvaluation')"
									title="Click to view calender"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="4"></a></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="2">Date of Entry</td>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="30%"
							class="outertable">
							<tr>
								<td><input type="text" name="txt_dateofentry" size="11"
									maxlength="10" tabindex="5"
									value="<%=Helper.correctNull((String)hshValues.get("entry_date"))%>"
									onBlur="checkDate(this);checkmaxdate(this,currentDate);">
								</td>
								<td><a href="#" onClick="callCalender1('txt_dateofentry')"
									title="Click to view calender"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="6"></a></td>
							</tr>
						</table>
						</td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>Reference Rate</td>
						<td>&nbsp;<b><%=ApplicationParams.getCurrency()%></b></td>
						<td><lapschoice:CurrencyTag name="txt_refrate" size="15"
							maxlength="10" tabindex="7" 
							value='<%=Helper.correctNull((String)hshValues.get("reference_rt"))%>' />
						</td>
						<td>Guidance Rate (in Rs.)</td>
						<td><lapschoice:CurrencyTag name="txt_guirate" size="15"
							maxlength="10" tabindex="8"
							value='<%=Helper.correctNull((String)hshValues.get("guidance_rt"))%>' />
						</td>
					</tr>
					<tr>
						<td colspan="2" nowrap="nowrap">Whether on the branch panel?</td>
						<td nowrap="nowrap" width="31%"><select
							name="sel_branchpanel" tabindex="13" onChange="selLawyerNme()">
							<option value="Y" selected="selected">Yes</option>
							<option value="N">No</option>
						</select></td>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
					</tr>
					<tr>
						<td>Valuer Name <b></b>
						</td>
						<td></td>
						<td>

						<table width="75%" border="0">
							<tr>
								<td><input type="text" name="txt_name" size="38"
									maxlength="50" tabindex="9"
									value="<%=Helper.correctNull((String)hshValues.get("valuers_name"))%>"
									onKeyPress="notAllowedDouble()"> <input type="hidden"
									name="hidsno" size="38" maxlength="50" tabindex="13"
									value="<%=Helper.correctNull((String)hshValues.get("valuers_code"))%>">
								</td>
								<td id="b1"><span onClick="javascript:callvaluerName()"
									style="cursor: hand"><b><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="10"></b></span></td>
							</tr>
						</table>

						</td>
						<td>Letter /Certification Number</td>
						<td>
						<table border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td><input type="text" name="txt_Certificationno" size="15"
									maxlength="10" tabindex="11"
									value="<%=Helper.correctNull((String)hshValues.get("let_cer_no"))%>"
									onKeyPress="notAllowSplChar()"></td>
								<td>
								<table border="0" cellspacing="0" cellpadding="3" width="30%">
									<tr>
										<td><input type="text" name="txt_CertDate" size="11"
											maxlength="10" tabindex="12"
											value="<%=Helper.correctNull((String)hshValues.get("let_cer_date"))%>"
											onBlur="checkDate(this);checkmaxdate(this,currentDate);">
										</td>
										<td><a href="#" onClick="callCalender1('txt_CertDate')"
											title="Click to view calender" border="0"> <img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="13"></a></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<%if (prd_type.equalsIgnoreCase("pH")) {%>
						<td>Market Value for the Land.</td>
						<%}
									
									else if (prd_type.equalsIgnoreCase("pP")) {%>
						<td>Market Value for the Asset.</td>
						<%}
									
									else if (prd_type.equalsIgnoreCase("pA")) {%>
						<td>Market Value for the Vehicle.</td>
						<%} else {%>
						<td>Market Value for the Land</td>
						<%}%>
						<td>&nbsp;<b><%=ApplicationParams.getCurrency()%></b></td>
						<td><lapschoice:CurrencyTag name="txt_landvalue" size="25"
							maxlength="10" tabindex="17"
							value='<%=Helper.correctNull((String)hshValues.get("mark_val_land"))%>' />
						</td>
						<%if (prd_type.equalsIgnoreCase("pH")) {%>
						<td>
						<table width="100%" border="0" class="outertable">
							<tr>
								<td>Market Value for the Building</td>
								<td><b><%=ApplicationParams.getCurrency()%></b></td>
							</tr>
						</table>
						</td>
						<td width="3%"><lapschoice:CurrencyTag
							name="txt_buildervalue" size="25" maxlength="10" tabindex="18"
							value='<%=Helper.correctNull((String)hshValues.get("mark_val_build"))%>' />
						</td>
						<%}
                    else{%>
						<td>&nbsp;</td>
						<td>&nbsp;</td>
						<%}%>
					</tr>
					<tr>
						
						<td>Estimated value on Forced Sale</td>
						<td>&nbsp;<b><%=ApplicationParams.getCurrency()%></b></td>
						<td><lapschoice:CurrencyTag name="txt_estimatedvalue"
							size="25" maxlength="10" tabindex="19"
							value='<%=Helper.correctNull((String)hshValues.get("esti_val_force"))%>' />
						</td>
						<td>Remarks</td>
						<td><textarea name="txt_comments" cols="45" tabindex="28" onKeyPress="textlimit(this,299)" onKeyUp="textlimit(this,299)"
							rows="3" wrap="VIRTUAL"><%=Helper.correctNull((String) hshValues.get("remark_note"))%></textarea></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<br>
		<lapschoice:combuttonnew
			btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
			btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="outertable">
					<tr class="dataheader">
						<td width="5%">&nbsp;</td>

						<td width="20%" align="center" nowrap="nowrap"><b>Date
						Sent</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Valuer's
						Name</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Certification
						No.</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Certification
						Date</b></td>
						<td width="15%" align="center" nowrap="nowrap"><b>Security ID</b></td>
					</tr>
				</table>
				</td>
			</tr>

			<tr>
				<td>

				<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="outertable">
					<%ArrayList g1 = new ArrayList();
			ArrayList v = (ArrayList) hshValues.get("vecRow");
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					<tr valign="top" class="datagrid">
						<td width="5%"><input type="radio"
							onclick="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
																		 '<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>',
																		 '<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(6))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(7))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(8))))%>','<%=Helper.replaceForJavaScriptString((String)g1.get(9))%>',
																		 '<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(11))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(12))))%>','<%=Helper.correctNull((String)g1.get(13))%>',
																		 '<%=Helper.correctNull((String)g1.get(14))%>','<%=Helper.correctDoubleQuotesHtml(Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(15))))%>',
																		 '<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>','<%=Helper.correctNull((String)g1.get(18))%>')"
							name="radiobutton"
							value="<%=Helper.correctNull((String) g1.get(1))%>"
							style="border: none"> &nbsp;</td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1
											.get(13))%></td>
						<td width="20%"><%=Helper.correctNull((String) g1.get(15))%></td>
						<td width="20%"><%=Helper.correctNull((String) g1
											.get(4))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1
											.get(5))%>&nbsp;</td>
						<td width="15%"><%=Helper.correctNull((String) g1.get(17))%></td>
					</tr>
					<%
														}
													}
												%>


					<tr class="datagrid">
						<td align="center" width="5%" colspan="6">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="radLoan" value="Y"> <input type="hidden" name="hidslno"
	value="<%=Helper.correctNull((String)hshValues.get("strsno"))%> ">
<input type="hidden" name="hidsmno" value="">
<input type="hidden" name="hidmastid" value = ""/>
<input type="hidden" name="hpage">
<input type="hidden" name="hidSecurityId" value="<%=strSecId%>">
<input type="hidden" name="hidsecID" value="">	
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
</form>
</body>
</html>
