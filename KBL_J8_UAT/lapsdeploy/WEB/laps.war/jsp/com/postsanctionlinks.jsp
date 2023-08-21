<%@include file="../share/directives.jsp"%>
<%
	int pageid = Integer.parseInt(Helper.correctInt((String)request.getParameter("pageid")));
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
	String strSessionModuleType = Helper.correctNull((String) session.getAttribute("sessionModuleType")).trim();
	String strPageIDPSApp = Helper.correctNull((String) session.getAttribute("strPageID_PS")).trim();
	
	int subpageid = Integer.parseInt(Helper.correctInt((String)request.getParameter("subpageid")));
	int subsubpageid=Integer.parseInt(Helper.correctInt((String)request.getParameter("subsubpageid")));
	//out.println("pageID="+strPageIDPSApp);
	String strPagefrom = Helper.correctNull((String) request.getParameter("pslink"));	
	if(!strPagefrom.equalsIgnoreCase("Y"))
	 strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));
	String strPage=	Helper.correctNull((String) hshValues.get("hidpage"));
	String strcgssdType=Helper.correctNull((String)session.getAttribute("strcgssdType")).trim();
	String strNCGTCFg=Helper.correctNull((String)session.getAttribute("strncgtcflag")).trim();
	String strncgtcbankscheme=Helper.correctNull((String)session.getAttribute("strncgtcbankscheme")).trim();
	
%>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varPage="<%=strPage%>";
var varFlag=true;
var strncgtcflag="<%=strNCGTCFg%>";
var strncgtcbankscheme="<%=strncgtcbankscheme%>";

function callPostSancLink(url,bean,method)
{
	if(varPage=="param")
	{
		//varFlag=callFacsnoChk();
		//if(document.forms[0].hidpending.value=="Y")
		//{
			//alert("Please select Post sanction parameter for all the facilities");
			//return;
		//}
	}
	if(varFlag==false)
	{
		return;
	}
	else
	{
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
		document.forms[0].submit();
	}
}

function CallPSOldProposal()
{
	var varQryString = appURL+"action/com_postsancoldproposal.jsp?hidBeanGetMethod=getPSOldSanctionedData&hidBeanId=facilities&appno="+document.forms[0].appno.value+"&apploantype="+document.forms[0].apploantype.value;
	var title = "Post sanction old proposal details";
	var prop = "scrollbars=yes,width=1000,height=600,left=20,top=10";
	window.open(varQryString,"",prop);
}
function callalert()
{
	alert("Click Freeze to view Security Coverage");
	return;
}
 
</script>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="1"
	class="outertable">
	<tr>
		<td width="30%">&nbsp;</td>
		<td width="40%" align="center"><b>&nbsp;&nbsp;<FONT color="red" size="3">(All Values are in Rs.)</FONT></b></td>
		<td width="30%" align="right"><input type="button" style="cursor: hand" class="buttonStyle" value="Verify Old Proposal" name="btnPSverify" onClick="javascript:CallPSOldProposal()"></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellpadding="2" cellspacing="1"
			class="outertable" align='center'>
			<tr align="center">
				<%int tabcount=0;boolean boolTrunc=false;
		if (pageid == 15) {
			%>
			<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Post Sanction Parameters
			</b></td>
			<%
				} else {
			%>
			<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
			<a href="javascript:callPostSancLink('postsancparameters.jsp','bankapp','getPostSanctionParameters')">Post Sanction Parameters </a>
			</b></td>
			<%
				}tabcount=tabcount+1;
				if(strPageIDPSApp.contains("@1@")){
					if (pageid == 1) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Applicant</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('facilities.jsp','facilities','getFacilityData')" title="Applicant">
				Applicant </a></td>
				<%
					}tabcount=tabcount+1;}
				%>
				<%if(strPageIDPSApp.contains("@2@")){
					if (pageid == 2) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">
				Co-Applicant / Guarantor</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('compromoters.jsp','compro','getValues')" title="Co-Applicant / Guarantor">Co-Applicant / Guarantor</a>
				</td>
				<%
					}tabcount=tabcount+1;}
				%>
				<%if(strPageIDPSApp.contains("@3@")){
					if (pageid == 3) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Banking
				Arrangement</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('combankingfi.jsp','bankappfi','getData')"
					title="Banking Arrangement"> Banking Arrangement</a></td>
				<%
					}tabcount=tabcount+1;}
				%>

				<%if(strPageIDPSApp.contains("33@")){
					if (pageid == 33) {
				%>
				<td class="main_tab_active" WIDTH="10%" nowrap="nowrap">Security
				Master</td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="10%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('securitiesMasterPage.jsp','securitymaster','getSecurityValuesDetails')"
					title="Security Master">Security Master</a></td>
				<%
					}tabcount=tabcount+1;}
				if(!strcgssdType.equalsIgnoreCase("Y")){
				if(strPageIDPSApp.contains("@5@")){
					if (pageid == 5) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Financial
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a href="javascript:callPostSancLink('financial.jsp','financial','getData')">Financial </a>
				</b></td>
				<%
					}tabcount=tabcount+1;}
				if(strPageIDPSApp.contains("@6@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
						</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
				<%}
					if (pageid == 6) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Financial-Group Concerns / Borrower 
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a href="javascript:callPostSancLink('com_financialgrpconc.jsp','comassestsliab','getFinangrpconcern')">Financial-Group Concerns / Borrower  </a>
				</b></td>
				<%
					}tabcount=tabcount+1;}	}%>
<!--				</tr>-->
<!--					<tr align="center">-->
				<%
				if(strPageIDPSApp.contains("@14@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
					</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
				<%}
					if (pageid == 14) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Implementation Schedule
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a href="javascript:callPostSancLink('com_BreifDetailOfProject.jsp','bankapp','getBreifDetailOfProject')">Implementation Schedule  </a>
				</b></td>
				<%
					}tabcount=tabcount+1;}
				if(strPageIDPSApp.contains("@8@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
					</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
					<%}
					if (pageid == 8) {
						%>
						<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>Basic Information</b></td>
						<%
							} else {
						%>
						<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap"><a
						href="javascript:callPostSancLink('com_companydet.jsp','comproposal','getData')"><b>Basic Information</b></a></td>
						<%
							}tabcount=tabcount+1;
					}
				if(strPageIDPSApp.contains("@4@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
					</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
					<%}
					if (pageid == 4) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Audit Observations 
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a href="javascript:callPostSancLink('com_Rbiloanpolicyguide.jsp','compro','getcom_Rbiloanpolicyguidedata')">Audit Observations </a>
				</b></td>
				<%
					}tabcount=tabcount+1;}
				if(strPageIDPSApp.contains("@9@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
					</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
					<%}
					if (pageid == 9) {
						%>
						<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>Business Turn Over</b></td>
						<%
							} else {
						%>
						<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap"><a
						href="javascript:callPostSancLink('com_others.jsp','inwardRegister','getOthersDetails')"><b>Business Turn Over</b></a></td>
						<%
							}tabcount=tabcount+1;
					}
				%>
					<%if(strPageIDPSApp.contains("@28@")){
						if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%>
							</tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center">
					<%}
					if (pageid == 28) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Repayment
				Schedule </b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a
					href="javascript:callPostSancLink('com_fac_repayment.jsp','comproposal','getTermFinanceFac')">Repayment
				Schedule</a> </b></td>
				<%
					}tabcount=tabcount+1;}
					if(strPageIDPSApp.contains("@11@")){
						if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
						if (pageid == 11) {
					%>
					<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Financial Analysis
					</b></td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
					<a href="javascript:callPostSancLink('finratio.jsp','financial','getDataRatio')">Financial Analysis  </a>
					</b></td>
					<%
						}tabcount=tabcount+1;}
					if(strPageIDPSApp.contains("@12@")){
						if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
						if (pageid == 12) {
					%>
					<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Terms&Conditions
					</b></td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
					<a href="javascript:callPostSancLink('comtermsandcond.jsp','apptermscond','getComFacilityTermData')">Terms&Conditions  </a>
					</b></td>
					<%
						}tabcount=tabcount+1;}
					
					if(strPageIDPSApp.contains("@26@")){
							if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
					if (pageid == 26) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>MIS/CBS
				Details</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('misdetails.jsp','mis','getMISDetails')"><b>MIS/CBS Details</b></a></td>
				<%
					}tabcount=tabcount+1;}
					
					if(strPageIDPSApp.contains("@34@")){
							if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
					if (pageid == 34) {
				%>
				<td class="main_tab_active" WIDTH="8%" nowrap="nowrap"><b>Reference Rate</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="8%" nowrap="nowrap"><a
					href="javascript:callPostSancLink('facility_mclr.jsp','facilities','getFacilityMCLRDetails')"><b>Reference Rate</b></a></td>
				<%
					}tabcount=tabcount+1;}%>
					
					<%if(strPageIDPSApp.contains("@13@")){
						if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
						if (pageid == 13) {
					%>
					<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Rating
					</b></td>
					<%
						} else {
					%>
					<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
					<a href="javascript:callPostSancLink('comrating.jsp?strFromN=T','perapplicant','getRetailrating')">Rating  </a>
					</b></td>
					<%
						}tabcount=tabcount+1;}
				%>
				<%if(strPageIDPSApp.contains("@10@")){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
					if (pageid == 10) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>Prop Flow/Exec Summary</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a
					href="javascript:callPostSancLink('com_delegation.jsp','executive','getDelegationData')">Prop Flow/Exec Summary </a></b></td>
				<%
					}tabcount=tabcount+1;}
				%>
				<%if(strPageIDPSApp.contains("@7@")|| true){
					if(tabcount>=8 && boolTrunc==false){boolTrunc=true;%></tr>
					</table>
					<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align='center'>
						<tr align="center"><%}
					if (pageid == 7) {
				%>
				<td class="main_tab_active" WIDTH="16%" nowrap="nowrap"><b>WorkFlow
				</b></td>
				<%
					} else {
				%>
				<td class="main_tab_inactive" WIDTH="16%" nowrap="nowrap"><b>
				<a href="javascript:callPostSancLink('appworkflowhistory.jsp','commworkflow','getHistory')">WorkFlow</a>
				</b></td>
				<%
					}}
				%>
			</tr>
		</table>
		</td>
	</tr>
	
	<%if(pageid==1 && subpageid==101){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt;
				 Application -&gt; Applicant -&gt; Facilities</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
						 Application -&gt; Applicant -&gt; Facilities</td>
				<%
					} %>
	</tr>
	<%} else if(pageid==2 && subpageid==102){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Co-Applicant / Guarantor</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Co-Applicant / Guarantor </td>
				<%
					} %>
	</tr>
	<%} else if(pageid==2 && subpageid==103){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Group Concerns </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Group Concerns </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==3 && subpageid==104){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Banking Arrangement -&gt;
		Existing Facilities  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Banking Arrangement -&gt;
		Existing Facilities </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==33 && subpageid==105){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt;
		Security   </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt;
		Security </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==33 && subpageid==106){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt;
		Attached Securities    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt;
		Attached Securities  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==33 && subpageid==107){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt;
		Security Coverage    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt;
		Security Coverage  </td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==201){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Security Details</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Security Details</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==202){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Non Tradeable</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Non Tradeable</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==203){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Tradeable</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Financial Documents &ndash; Tradeable</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==204){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Securities -&gt; Bank Deposits</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Securities -&gt; Bank Deposits</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==205){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
			<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Jewel Details</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Jewel Details</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==206){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Title to Goods</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Title to Goods</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==207){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Property Details</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Property Details</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==208){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Vehicle Details</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Vehicle Details</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==209){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt; Agriculture -&gt; Application -&gt; Security Master -&gt; Plant & Machinery</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Plant & Machinery</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==33 && subpageid==210){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">Home -&gt;Agriculture -&gt; Application -&gt; Security Master -&gt; Furniture & Fixtures</td>
		<%
			}else{
				%>
						<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Furniture & Fixtures</td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==28 && subpageid==108){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Repayment Schedule  -&gt;
		Repayment Schedule for EMI    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Repayment Schedule  -&gt;
		Repayment Schedule for EMI  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==28 && subpageid==109){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Repayment Schedule  -&gt;
		Repayment Schedule for Non-EMI    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Repayment Schedule r -&gt;
		Repayment Schedule for Non-EMI  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==26 && subpageid==110){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; MIS/CBS Details -&gt;
		MIS Details    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; MIS/CBS Details -&gt;
		MIS Details  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==26 && subpageid==111){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; MIS/CBS Details -&gt;
		CBS Details    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; MIS/CBS Details -&gt;
		CBS Details  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==10 && subpageid==112){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Prop Flow/Exec Summary -&gt;
		Proposal Flow    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Prop Flow/Exec Summary -&gt;
		Proposal Flow  </td>
				<%
					} %>
	</tr>
	<%}
	else if(pageid==10 && subpageid==211){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Prop Flow/Exec Summary -&gt;
		Key Fact Statement   </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Prop Flow/Exec Summary -&gt;
		Key Fact Statement </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==7 && subpageid==113){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow  -&gt;
		History    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; WorkFlow  -&gt;
		History  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==7 && subpageid==114){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow  -&gt;
		Action    </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; WorkFlow  -&gt;
		Action  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==7 && subpageid==116){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; WorkFlow  -&gt;
		Proposed facility Approve / Reject </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; WorkFlow  -&gt;
		Proposed facility Approve / Reject </td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==21){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Demographics  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Demographics </td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==22){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Communication Details  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Communication Details</td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==23){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; KYC Norms </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; KYC Norms </td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==24){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Rating / Defaulter </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Rating / Defaulter</td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==25){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Employment Details </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Employment Details </td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==26){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Income / Expenses </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Income / Expenses</td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==29){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Sister Concerns </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Sister Concerns </td>
				<%
					} %>
	</tr>
	<%}else if(subsubpageid==10){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Customer profile  -&gt; Land Holdings </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Customer profile   -&gt; Land Holdings</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==117){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Brief History  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Brief History  </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==118){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Management Information  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Management Information </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==119){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Gist of Proposal(Introduction)</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Gist of Proposal(Introduction) </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==120){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Details of proposal (for Assessment) </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Details of proposal (for Assessment)  </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==121){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Applicant  -&gt;
		Other Interest Rate / Commission   </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Applicant  -&gt;
		Other Interest Rate / Commission  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==8){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Basic Information   </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Basic Information  </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==122){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==123){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application  -&gt; Business Turn Over -&gt; Term Loan  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Term Loan </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==124){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt;  OD / CC Limits</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt; OD / CC Limits</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==125){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt;  BPC & PC / Shipping Loan</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt; BPC & PC / Shipping Loan</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==126){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt;  Bills Purchased</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Conduct of Working Capital Facilities -&gt; Bills Purchased</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==127){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Non Funded Loans</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Non Funded Loans</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==128){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Overall Comments </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Overall Comments </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==129){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Business Turn Over -&gt; Comments on Transaction in the existing accounts </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Business Turn Over -&gt; Comments on Transaction in the existing accounts </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==130){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Audit Observations -&gt; Audit / Inspection Observations </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Audit Observations -&gt; Audit / Inspection Observations</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==131){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Audit Observations -&gt; Comments </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Audit Observations -&gt; Comments </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==5){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Financial</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==6){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Financial-Group Concerns / Borrower </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial-Group Concerns / Borrower  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==11){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Financial Analysis  -&gt; Ratios</td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial Analysis -&gt; Ratios</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==132){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Financial Analysis  -&gt; Deviation from Loan Policy </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial Analysis -&gt; Deviation from Loan Policy </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==133){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Financial Analysis  -&gt; Deviation from Loan Policy </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Financial Analysis -&gt; Deviation from Loan Policy </td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==134){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Rating -&gt; Corporate Rating </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Rating -&gt; Corporate Rating</td>
				<%
					} %>
	</tr>
	<%}else if(subpageid==135){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Rating  -&gt; Previous Rating  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Rating -&gt; Previous Rating  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==14){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Implementation Schedule  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Implementation Schedule  </td>
				<%
					} %>
	</tr>
	<%}else if(pageid==15){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">  Home -&gt; Agriculture -&gt; Application -&gt; Post sanction Parameter  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Post sanction Parameter</td>
				<%
					} %>
	</tr>
	<%}else if(pageid==34){ %>
	<tr>
	<%if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%>
				<td class="page_flow">  Home -&gt; Agriculture -&gt; Application -&gt; MCLR  </td>
		<%
			}else{
				%>
						<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; MCLR</td>
				<%
					} %>
	</tr>
	<%}%>
<tr><td><span style="display: none;"><lapschoice:borrowertype /></span></td></tr>	
<lapschoice:application />
	
	<%if(pageid==1)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="30%">
	<tr align="center">
	<%
		if (subpageid == 101) {
	%>
	<td class="main_tab_active"  nowrap="nowrap" ><b>Facilities
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('facilities.jsp','facilities','getFacilityData')">Facilities</a>
	</b></td>
	<%
		}
	if (subpageid == 115) {
		%>
		<td class="main_tab_active"  nowrap="nowrap" ><b>Customer Profile
		</b></td>
		<%
			} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:gotocusprofile('<%=ApplicationParams.getAppUrl() %>','perapplicantdispco.jsp')">Customer Profile</a>
		</b></td>
		<%
			}
	if (subpageid == 117) {
		%>
		<td class="main_tab_active"  nowrap="nowrap" ><b>Other Post Sanction Parameters
		</b></td>
		<%
			} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:callPostSancLink('com_otherpostsanctionparams.jsp?hidPageVal=otherparams','facilities','getComments')">Other Post Sanction Parameters</a>
		</b></td>
		<%
			}
	//if (subpageid == 118) {
		%>
		<!-- <td class="main_tab_active"  nowrap="nowrap" ><b>Management Information
		</b></td>
		<%
			//} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:gotocusprofile('<%//=ApplicationParams.getAppUrl() %>','com_managementinfo.jsp')">Management Information</a>
		</b></td>
		<%
		//	}
//	if (subpageid == 119) {
		%>
		<td class="main_tab_active"  nowrap="nowrap" ><b>Gist of Proposal(Introduction)
		</b></td>
		<%
			//} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:callPostSancLink('com_gistproposal.jsp','facilities','getComments')">Gist of Proposal(Introduction)</a>
		</b></td>
		<%
			//}
	//if (subpageid == 120) {
		%>
		<td class="main_tab_active"  nowrap="nowrap" ><b>Details of proposal (for Assessment)
		</b></td>
		<%
			//} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:callPostSancLink('com_presentproposal.jsp','facilities','getComments')">Details of proposal (for Assessment)</a>
		</b></td> -->
		<%
		//	}
	if (subpageid == 121) {
		%>
		<td class="main_tab_active"  nowrap="nowrap" ><b>Other Interest Rate / Commission
		</b></td>
		<%
			} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:callPostSancLink('com_commentsonintrestrate.jsp','facilities','getCommentsonInterestRate')">Other Interest Rate / Commission</a>
		</b></td>
		<%
			}
	%>
	</tr>
	</table>
	</td>
	</tr>
	<%} %>
	<%if(pageid==2)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="35%">
	<tr align="center">
	<%
		if (subpageid == 102) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Co-Applicant / Guarantor
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('compromoters.jsp','compro','getValues')">Co-Applicant / Guarantor</a>
	</b></td>
	<%
		}
		if (subpageid == 103) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Group Concerns
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('comgroupcompanies.jsp','executive','getData7')">Group Concerns</a>
	</b></td>
	<%
		}
	%>
	</tr>
	</table>
	</td>
	</tr>
	<%}  
	if(!strPagefrom.equalsIgnoreCase("appl")){%>
	<%if(pageid==33)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="50%">
	<tr align="center">
	<%
		if (subpageid == 105) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Security
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('securitiesMasterPage.jsp','securitymaster','getSecurityValuesDetails')">Security</a>
	</b></td>
	<%
		}
		if (subpageid == 106) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Attached Securities
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('attachedsecurities.jsp','securitymaster','getAttachedSecurityDetails')">Attached Securities</a>
	</b></td>
	<%
		}
		if (subpageid == 107) {
			%>
			<td class="main_tab_active"  nowrap="nowrap"><b>Security Coverage
			</b></td>
			<%
				} else {
			String Freezeflag=Helper.correctNull((String)request.getParameter("Freezeflag"));
		 	if(Freezeflag.equalsIgnoreCase(""))
		 	{
		 		Freezeflag=Helper.correctNull((String)hshValues.get("Freezeflag"));
		 	}
		 	if(Freezeflag.equalsIgnoreCase(""))
		 	{
		 		Freezeflag=Helper.correctNull((String)hshValues.get("strFreezeflag"));
		 	}
		 	if(Freezeflag.equalsIgnoreCase("Y")){%>
		 	<td class="main_tab_inactive"  nowrap="nowrap"><b>
			<a href="javascript:callPostSancLink('com_attchsecuritydisplay.jsp','securitymaster','getCollateralSecurityDisplaynew')">Security Coverage</a>
			</b></td>
			<% }else{%>
			<td nowrap="nowrap" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
			<%
				}
		if (subpageid == 138) {
			%>
			<td class="main_tab_active"  nowrap="nowrap"><b>Sec coverage Comments
			</b></td>
			<%
				} else {
			%>
			<td class="main_tab_inactive"  nowrap="nowrap"><b>
			<a href="javascript:callPostSancLink('securitycoveragecommentsnew.jsp?hidPage=secoveragecmts','facilities','getComments')">Sec coverage Comments</a>
			</b></td>
			<%
				}
	%>
	</tr>
	</table>
	</td>
	</tr>
	<%} }%>
	<%if(pageid==28)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="40%">
	<tr align="center">
	<%
		if (subpageid == 108) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Repayment Schedule for EMI
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('com_fac_repayment.jsp','comproposal','getTermFinanceFac')">Repayment Schedule for EMI</a>
	</b></td>
	<%
		}
		if (subpageid == 109) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Repayment Schedule for Non-EMI
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('com_fac_repaymentnonemi.jsp','comrepayschedule','getFacNonEMIRepayment')">Repayment Schedule for Non-EMI</a>
	</b></td>
	<%
		}
	%>
	</tr>
	</table>
	</td>
	</tr>
	<%} %>
	<%if(pageid==26)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="25%">
	<tr align="center">
	<%
		if (subpageid == 110) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>MIS Details
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('misdetails.jsp','mis','getMISDetails')">MIS Details</a>
	</b></td>
	<%
		}
		if (subpageid == 111) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>CBS Details
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('CBSData.jsp','FinacleBean','getCBSDetails')">CBS Details</a>
	</b></td>
	<%
		}
	%>
	</tr>
	</table>
	</td>
	</tr>
	<%} %>
	<%if(pageid==10)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="30%">
	<tr align="center">
	<%
		if (subpageid == 112) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Proposal Flow
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('com_delegation.jsp','executive','getDelegationData')">Proposal Flow</a>
	</b></td>
	<%
		}
	
	%>
	<%if(false){ %>
	
	<%if (subpageid == 211) {
		%>
		<td class="main_tab_active"  nowrap="nowrap"><b>Key Fact Statement
		</b></td>
		<%
			}else{ %>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:showKFS('com_keyfactstatement.jsp','getKeyFactStatementData')"
			onMouseOut="window.status='Key Fact Statement';return true;"
			onMouseOver="window.status='Key Fact Statement';return true;"><b>Key
		Fact Statement</b></a></td>
		<%}} %>
		</tr>
	</table>
	</td>
	</tr>
	<%} %>
	<%if(pageid==7)
		{%>
		<tr>
		<td>
		<table border="0" cellpadding="2" cellspacing="1"
			class="outertable" width="30%">
	<tr align="center">
	<%
		if (subpageid == 113) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>History
	</b></td>
	<%
		} else {
	%>
	<td class="main_tab_inactive"  nowrap="nowrap"><b>
	<a href="javascript:callPostSancLink('appworkflowhistory.jsp','commworkflow','getHistory')">History</a>
	</b></td>
	<%}%>
	<%if(!strSessionModuleType.equalsIgnoreCase("RET") && strPageIDPSApp.contains("@7@")){
		if (subpageid == 116) {
	%>
	<td class="main_tab_active"  nowrap="nowrap"><b>Proposed facility Approve/Reject</b></td>
	<%
		} else {
	%>
	<td class="sub_tab_inactive" nowrap><a href="javascript:callPostSancLink('com_termsofsanction.jsp','commworkflow','getTermsofSanctionFacilityData')" > Proposed facility Approve/Reject</a></td>
	<%}}%>
	
	<%if (subpageid == 114) {
		%>
		<td class="main_tab_active"  nowrap="nowrap"><b>Action
		</b></td>
		<%
			} else {
		%>
		<td class="main_tab_inactive"  nowrap="nowrap"><b>
		<a href="javascript:callPostSancLink('appworkflowaction.jsp','commworkflow','getAction')">Action</a>
		</b></td>
		<%
			}
	%>
	
	<%if (subpageid == 136) {
		%>
		<td class="sub_tab_active" id="idloanaccount"  nowrap="nowrap">Loan Account Details</td>
		<%
			} else {
		%>
		<td class="sub_tab_inactive" id="idloanaccount"  nowrap="nowrap"><a href="#" onClick="javascript:callLoanAccount()">Loan Account Details</a></td>
		<%
			}
	%>
	<%if(strPageIDPSApp.contains("@35@")){
	if (subpageid == 137) {
		%>
		<td class="sub_tab_active"  nowrap="nowrap">Draw Down Schedule</td>
		<%
			} else {
		%>
		<td class="sub_tab_inactive" nowrap="nowrap"><a href="#" onClick="javascript:callPostSancLink('drawdownschedule.jsp','commworkflow','getDrawDownSchedule')">Draw Down Schedule</a></td>
		<%
			}}
	%>
	<td id="idfacdetail">&nbsp;</td><td id="idrestr">&nbsp;</td><td id="idCGTMSEtxn">&nbsp;</td>
	</tr>
	</table>
	</td>
	</tr>
	<%} %>
</table>
</body>
