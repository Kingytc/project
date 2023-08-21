<%@include file="../share/directives.jsp"%>
<%
	session.setAttribute("appno", "");
	String applicantoldid = Helper.correctNull((String) request
			.getParameter("applicantoldid"));
	String searchType = Helper.correctNull((String) request
			.getParameter("searchtype"));
%>

<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRLPFUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
var orglevel = "<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
function doClose()
{
	if(ConfirmMsg(100))
	{
		if(document.forms[0].hidPageType.value == "audit_trial")
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/audit_trial_search.jsp?hidPageType=<%=request.getParameter("hidPageType")%>";
		}
		else
		{
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perborrowersearch.jsp?hidPageType=<%=request.getParameter("hidPageType")%>&hidCategoryType=<%=Helper.correctNull((String) request
							.getParameter("hidCategoryType"))%>";
			
		}
		document.forms[0].submit();
	}
}

function doNew()
{
	/*if(document.forms[0].hidApprovedApplDemoID.value=='Y')
	{
		alert("You can't create the proposal, Kindly Renew the Customer Profile");
		return;
	}*/

	if(document.forms[0].hidOccuCode.value=='MIGR')
	{
		alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile");
		return;
	}
	
	var Flag=false;
	if(document.forms[0].hidRatingProposalPendingFlag.value=='Y')
	{
		//alert("You can't create the proposal, Rating request is still Pending for this Applicant in Only for Rating;Please contact ["+document.forms[0].hidRatingProposalUser.value+"] for further processing.");
		//return;
	}
	if(document.forms[0].hidRatingProposalFlag.value=='Y')
	{
		//if(confirm("This Applicant has Only for Rating proposal in pending.If you are proceeding, Existing Only for Rating proposal will be closed.Do you want to continue?"))
		{
			Flag=true;
		}
	}
	else
	{
		Flag=true;
	}
	if(Flag)
	{
		var varCategoryType="<%=Helper.correctNull((String) request
			.getParameter("hidCategoryType"))%>";
		var varappname="<%=Helper.correctNull((String) request
			.getParameter("appname"))%>";
		var varappid="<%=applicantoldid%>";
		var varCBSId=document.forms[0].hidCBSId.value;
		var varapproveddAppDemoId= document.forms[0].hidApprovedApplDemoID.value;
		document.forms[0].action = appURL + "action/perloan_preapplicationhistroy.jsp?page1=nr&appno=new&compname="+varappname+"&hidCategoryType="+varCategoryType+"&hidapplicantoldid="+varappid+"&hidCBSID="+varCBSId+"&varapproveddAppDemoId="+varapproveddAppDemoId;
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
}
function onLoad()
{
	if((orglevel=="D" && varRLPFUser!="012")||orglevel=="R")
	{
		document.all.idnewbuton.style.display="none";
		document.forms[0].cmdnew.disabled=true;
	}
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoad();">
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
<form name="exist" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<%
					if (Helper.correctNull(
							(String) session.getAttribute("hidCategoryType"))
							.equalsIgnoreCase("RET")) {
				%>
				<td valign="top" class="page_flow">Home -&gt; Retail</td>
				<%
					} else if (Helper.correctNull(
							(String) session.getAttribute("hidCategoryType"))
							.equalsIgnoreCase("AGR")) {
				%>
				<td valign="top" class="page_flow">Home -&gt; Agriculture</td>
				<%
					} else if (Helper.correctNull(
							(String) session.getAttribute("hidCategoryType"))
							.equalsIgnoreCase("LAD")) {
				%>
				<td valign="top" class="page_flow">Home -&gt; Loan Against Gold
				Ornaments &amp; Deposits</td>
				<%
					}
				%>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="1" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td valign="top"><br>
						<%
							if (!searchType.equalsIgnoreCase("APPLICATIONNO")) {
						%>
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							align="center" class="outertable">
							<tr>
								<td valign="top" align="center">
								<table width="60%" border="1" cellspacing="0" cellpadding="0"
									align="center" class="outertable">
									<tr>
										<td align="center">
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center" class="outertable">
											<tr class="datagrid" align="center">
												<td><B>Borrower Name: <%=Helper.decodeAmpersand((String) request
								.getParameter("appname"))%></B>
												</td>
												<td id="idnewbuton">
												<%
													if (((strCategoryType.equalsIgnoreCase("AGR")
															&& strGroupRights.length() > 19
															&& strGroupRights.charAt(20) == '1')
														|| (strCategoryType.equalsIgnoreCase("RET")
																&& strGroupRights.charAt(5) == '1')
														|| (strCategoryType.equalsIgnoreCase("LAD")
																&& strGroupRights.length() > 23
																&& strGroupRights.charAt(24) == '1'))
																&& strGroupRights.charAt(18) == 'w') {
												%>
												<input type="button" name="cmdnew" value="New Proposal"
													onClick="doNew()" class="buttonStyle" /> <%
 	}
 %>
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table><%
							}
						%>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							align="center" class="outertable">
							<tr valign="top">
								<td id="searchheading">
								<table width="100%" border="0" cellspacing="1" cellpadding="1"
									class="outertable">
									<tr class="dataheader" align="center">
										<td width="10%">Proposal No.</td>
										<td width="18%">Product Category</td>
										<td width="18%">Product Sub-Category</td>
										<td width="27%">Product Description</td>
										<td width="20%">Process Status</td>
										<td width="7%">Holder</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="top"><iframe id="result"
									src="<%=ApplicationParams.getAppUrl()%>action/perresult.jsp?hidBeanGetMethod=getDataFinal&applicantoldid=<%=Helper.correctNull((String) request
							.getParameter("applicantoldid"))%>&hidPageType=<%=request.getParameter("hidPageType")%>&appid=<%=Helper.correctNull((String) request
							.getParameter("applicantoldid"))%>&hidCategoryType=<%=Helper.correctNull((String) request
							.getParameter("hidCategoryType"))%>&select_cat=Retail&searchtype=<%=Helper.correctNull((String) request
							.getParameter("searchtype"))%>&searchval=<%=Helper.correctNull((String) request
							.getParameter("searchval"))%>"
									width="100%" height="310"> </iframe></td>
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
<table border="1" cellspacing="0" cellpadding="0" align="center">
	<tr>
		<td>
		<table width="0%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="middle">
				<td align="center"><input type="button" name="cmdclose"
					value="Close" class="buttonClose" onClick="doClose()"></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidPageType"
	value="<%=request.getParameter("hidPageType")%>"> <input
	type="hidden" name="hidapplicantid"> 
	<input type="hidden" name="hidRatingProposalFlag">
	<input type="hidden" name="hidRatingProposalPendingFlag">
	<input type="hidden" name="hidRatingProposalUser">
	<input type="hidden" name="hidCBSId" value="<%=Helper.correctNull((String)request.getParameter("hidCBSID")) %>">
	<input type="hidden" name="hidApprovedApplDemoID"> 
	<input type="hidden" name="hidOccuCode"> 
	<lapschoice:hiddentag
	pageid='<%=PageId%>' /></form>
</body>
</html>
