<%@include file="../share/directives.jsp"%>
<%
	int pageid = Integer.parseInt(Helper.correctInt((String) request
			.getParameter("pageid")));
	String cattype = Helper.correctNull((String) request
			.getParameter("cattype"));
	String ssitype = Helper.correctNull((String) request
			.getParameter("ssitype"));
	String strcattype = Helper.correctNull((String) request
			.getParameter("hidCategoryType"));
	String strMisFlag = Helper.correctNull((String) session
			.getAttribute("strSessionMisFlag"));
	if (cattype.equalsIgnoreCase("")) {
		cattype = strcattype;
	}
	String strSessionModuleType = Helper.correctNull(
			(String) session.getAttribute("sessionModuleType")).trim();
	String strPageIDPSApp = Helper.correctNull(
			(String) session.getAttribute("strPageID_PS")).trim();
	String strPageParam = Helper.correctNull(
			(String) session.getAttribute("strModifyterms")).trim();

	int subpageid = Integer.parseInt(Helper.correctInt((String) request
			.getParameter("subpageid")));
	int subsubpageid = Integer.parseInt(Helper
			.correctInt((String) request.getParameter("subsubpageid")));

	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	String strRepaymenttype = Helper.correctNull((String) request
			.getParameter("hidRepayType"));
	if (strRepaymenttype.equals("")) {
		strRepaymenttype = Helper.correctNull((String) hshValues
				.get("repaymenttype"));
	}
	String strSchemeCode = Helper.correctNull((String) session
			.getAttribute("schemeCode"));
	if(strSchemeCode.equalsIgnoreCase(""))
	strSchemeCode = Helper.correctNull((String) hshValues
			.get("strLoanType"));
%>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style..css" type="text/css">
<script language="JavaScript">
function callPostSancLink(url, bean, method)
{
	document.forms[0].hidBeanGetMethod.value = method;
	document.forms[0].hidBeanId.value = bean;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+ url;
	document.forms[0].submit();
}

 
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="1"
			class="outertable" align='center'>
			<tr align="center">
				<%
					if (strPageIDPSApp.contains("@1@")) {
						if (pageid == 1) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Loan
				Particulars</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('perloandetails.jsp','perapplicant','getLoanProducts')"
					title="Applicant"> Loan Particulars</a></td>
				<%
					}
						}
				
				if (pageid == 100) {
					%>
					<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">
					Post Sanction Parameters</td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
						href="javascript:callPostSancLink('perpostsancparameters.jsp','bankapp','getPostSanctionParameters')"
						title="Promoter">Post Sanction Parameters</a></td>
					<%
						}
				%>
				<%
						if (strPageIDPSApp.contains("@2@")) {
							if (pageid == 2) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">
				Applicant/Guarantor</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('perapplicantdispco.jsp','mastapplicant','getDemographics')"
					title="Promoter">Applicant/Guarantor</a></td>
				<%
					}
						}
				%>

				<%
						if (strPageIDPSApp.contains("@4@")) {
							if (pageid == 4) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Security
				Master</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')"
					title="Security Master">Security Master</a></td>
				<%
					}
						}
				%>
				<%
						if (strPageIDPSApp.contains("@7@")) {
							if (pageid == 7) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Appraisal</b></td>
				<%
					} else {
						
						if(!(prd_type.equalsIgnoreCase("pR")||prd_type.equalsIgnoreCase("pG")||prd_type.equalsIgnoreCase("pE"))
								&& !(strSchemeCode.equalsIgnoreCase("OD"))){%>
							<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a
					href="javascript:callPostSancLink('per_assessment_repayment_capacity.jsp','retailassessment','getRepaymentCapacity')">Appraisal

				</a></b></td>
							
						<%}else{
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a
					href="javascript:callPostSancLink('loandetails.jsp','appraisal','getloandetails')">Appraisal

				</a></b></td>
				<%
						}}
						}
				%>
				<%
						if (strPageIDPSApp.contains("@8@")) {
							if (pageid == 8) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>MIS/CBS
				Details</b></td>
				<%
					} else {%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('misdetails.jsp','mis','getMISDetails')"><b>MIS/CBS
				Details</b></a></td>

				<%
					}
						}
				%>
				
				<%
										if (strPageIDPSApp.contains("@11@")) {
											if (!prd_type.equalsIgnoreCase("pR")
													&& !((prd_type.equalsIgnoreCase("pM") || prd_type
															.equalsIgnoreCase("pI")) && strSchemeCode
															.equalsIgnoreCase("OD"))) {
												if ((!(strRepaymenttype.equalsIgnoreCase("1"))&& !strRepaymenttype.equalsIgnoreCase("") && !prd_type
														.equalsIgnoreCase("pG"))
														|| (prd_type.equalsIgnoreCase("pG") && strRepaymenttype
																.equalsIgnoreCase("14"))) {
													if (pageid == 10) {
								%>
					<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Repayment Schedule</b></td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
					<a href="javascript:callPostSancLink('per_RepaymentSchedulenonemi.jsp','comrepayschedule','getFacNonEMIRepayment')"><b>RepaymentSchedule</b></a></td>
					<%
						}

										if (pageid == 11) {
					%>
					<td class="main_tab_active" WIDTH="12%" nowrap="nowrap"><b>Terms of Repayment</b></td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="12%" nowrap="nowrap">
					<a href="javascript:callPostSancLink('com_repaycomment.jsp?pagetype=repaycomment','comproposal','getDataComments')"><b>Terms of Repayment</b></a></td>
					<%
						}
					%>
					
					
				<%
															}
																	}
										}
														%>
				
				<%
									if (strPageIDPSApp.contains("@9@")) {
										if (pageid == 9) {
								%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>WorkFlow
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a
					href="javascript:callPostSancLink('appworkflowhistory.jsp','commworkflow','getHistory')">WorkFlow</a>
				</b></td>
				<%
					}
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
	<%
		if (pageid == 1 && subpageid == 101) {
	%>
	<tr>
			<td class="page_flow">Home -&gt; Retail -&gt;
			 Application -&gt; Loan  Particulars -&gt; Loan Product</td>
	</tr>
	<%
		}
	%>
	<%
		if (pageid == 1 && subpageid == 102) {
	%>
	<tr>
			<td class="page_flow">Home -&gt; Retail -&gt;
			 Application -&gt; Loan  Particulars -&gt; Co-Applicant / Guarantor</td>
	</tr>
	<%
		} else if (subsubpageid == 21) {
	%>
	<tr>
				<td class="page_flow">Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor  -&gt; Demographics  </td>
	</tr>
	<%
		} else if (pageid == 10) {
	%>
	<tr>
			<td class="page_flow">Home -&gt; Retail -&gt;
			 Application -&gt; Repayment Schedule</td>
	</tr>
	<%
		} else if (pageid == 11) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt;
	 Application -&gt; Terms of Repayment</td>
	</tr>
	<%
		} else if (subsubpageid == 22) {
	%>
	<tr>
						<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor  -&gt; Communication Details</td>
	</tr>
	<%
		} else if (subsubpageid == 23) {
	%>
	<tr>
						<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor -&gt; KYC Norms </td>
	</tr>
	<%
		} else if (subsubpageid == 24) {
	%>
	<tr>
						<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor   -&gt; Rating / Defaulter</td>
	</tr>
	<%
		} else if (subsubpageid == 25) {
	%>
	<tr>
						<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor   -&gt; Employment Details </td>
	</tr>
	<%
		} else if (subsubpageid == 26) {
	%>
	<tr>
				<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor -&gt; Income / Expenses </td>
	</tr>
	<%
		} else if (subsubpageid == 29) {
	%>
	<tr>
				<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor -&gt; Sister Concerns </td>
	</tr>
	<%
		} else if (subsubpageid == 10) {
	%>
	<tr>
						<td class="page_flow"> Home -&gt; Retail -&gt;
			 Application  -&gt; Applicant / Guarantor   -&gt; Land Holdings</td>
	</tr>
	<%
		} else if (subpageid == 105) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	 Application  -&gt; Security Master -&gt; Security </td>
	</tr>
	<%
		} else if (subpageid == 106) {
	%>
	<tr>
				<td class="page_flow"> Home -&gt; Retail -&gt;
	 Application  -&gt; Security Master -&gt; Attached Security </td>
	</tr>
	<%
		} else if (subpageid == 107) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Security Master -&gt; Security Coverage </td>
	</tr>
	<%
		} else if (subpageid == 108) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Security Master -&gt; Comments on Security Coverage </td>
	</tr>
	<%
		} else if (subpageid == 109) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Assessment-Cost </td>
	</tr>
	<%
		} else if (subpageid == 110) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Assessment-R/C </td>
	</tr>
	<%
		} else if (subpageid == 111) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Comments on Assessment </td>
	</tr>
	<%
		} else if (subpageid == 112) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Loan Details </td>
	</tr>
	<%
		} else if (subpageid == 113) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Comments</td>
	</tr>
	<%
		} else if (subpageid == 114) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Terms and Conditions </td>
	</tr>
	<%
		} else if (subpageid == 115) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Proposal Flow </td>
	</tr>
	<%
		} else if (subpageid == 116) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; Appraisal -&gt; Key Fact Statement </td>
	</tr>
	<%
		} else if (subpageid == 117) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; MIS /CBS Details -&gt; MIS Details </td>
	</tr>
	<%
		} else if (subpageid == 118) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt;  MIS /CBS Details -&gt; CBS Details </td>
	</tr>
	<%
		} else if (subpageid == 119) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; WorkFlow -&gt; History </td>
	</tr>
	<%
		} else if (subpageid == 120) {
	%>
	<tr>
	<td class="page_flow"> Home -&gt; Retail -&gt;
	Application  -&gt; WorkFlow -&gt; Action</td>
	</tr>
	<%
		}
		 else if (subpageid == 201) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Security Details</td>
	</tr>
	<%
		}
		 else if (subpageid == 202) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Non Tradeable</td>
	</tr>
	<%
		}
		 else if (subpageid == 203) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Tradeable</td>
	</tr>
	<%
		}
		 else if (subpageid == 204) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Securities -&gt; Bank Deposits</td>
	</tr>
	<%
		}
		 else if (subpageid == 205) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Jewel Details</td>
	</tr>
	<%
		}
		 else if (subpageid == 206) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Title to Goods</td>
	</tr>
	<%
		}
		 else if (subpageid == 207) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Property Details</td>
	</tr>
	<%
		}
		 else if (subpageid == 208) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Vehicle Details</td>
	</tr>
	<%
		}
		 else if (subpageid == 209) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Plant & Machinery</td>
	</tr>
	<%
		}
		 else if (subpageid == 210) {
	%>
	<tr>
	<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Furniture & Fixtures</td>
	</tr>
	<%
		}
	if (pageid == 100) {
		%>
		<tr>
				<td class="page_flow">Home -&gt; Retail -&gt; Post sanction Parameter </td>
		</tr>
		<%
			}
	%>

	<tr>
		<td><span style="display: none;"><lapschoice:borrowertype /></span></td>
	</tr>
	<lapschoice:application />
	<%
		if (pageid == 9) {
	%>
	<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1" class="outertable"
			width="30%">
			<tr align="center">
				<%
					if (subpageid == 119) {
				%>
				<td class="main_tab_active" nowrap="nowrap"><b>History </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" nowrap="nowrap"><b> <a
					href="javascript:callPostSancLink('appworkflowhistory.jsp','commworkflow','getHistory')">History</a>
				</b></td>
				<%
					}
				%>

				<%
					if (subpageid == 120) {
				%>
				<td class="main_tab_active" nowrap="nowrap"><b>Action </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" nowrap="nowrap"><b> <a
					href="javascript:callPostSancLink('appworkflowaction.jsp','commworkflow','getAction')">Action</a>
				</b></td>
				<%
					}
				%>
				<%if (subpageid == 121) {
		%>
		<td class="sub_tab_active" id="idloanaccount"  nowrap="nowrap">Loan Account Details</td>
		<%
			} else {
		%>
		<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
		<%
			}
	%>
				<td id="idfacdetail">&nbsp;</td><td id="idrestr">&nbsp;</td><td id="idCGTMSEtxn">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
	<%
		}
	%>
<input type="hidden" name="hiPgDist" value="P">
</table>
</body>
