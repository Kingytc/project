<%@include file="../share/directives.jsp"%>

<%
ArrayList arrData = new ArrayList();
ArrayList arrRow = new ArrayList();
arrData = (ArrayList) hshValues.get("arrhistory");

String appno=Helper.correctNull((String)hshValues.get("appno"));	
String strAppstatus = Helper.correctNull((String)hshValues.get("appstatus"));
session.setAttribute("strappstatus",strAppstatus);
%>
<html>
<head>
<title>Work Flow - History</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var appno="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var varRecmdFlag="<%=Helper.correctNull((String)hshValues.get("strRecmdFlag"))%>";
function callPermissionLetter()
{
	if(varRecmdFlag=="Y")
	{ 
	var prop = "scrollbars=yes,width=650,height=500,top=25,left=180,menubar=yes";
	var url=appURL+"action/permissionletter.jsp?hidBeanId=perDeviation&hidBeanGetMethod=getPermissionLetterData&appno="+appno;
	window.open(url,"",prop);
	}
	else
	{
		alert("Please to fill the recommendations tab");
	}	
}

function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getAction";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/permworkflowaction.jsp";
		document.forms[0].submit();
	}
	if(val=="recommendations")
	{
		document.forms[0].hidBeanGetMethod.value="getRecommendations";
		 document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].action=appURL+"action/permworkflowrecomments.jsp";
		document.forms[0].submit();
	}
	
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}	
}


</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 250;
	overflow: auto;
}
</STYLE>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<form name="frmworkflow" method="post" class="normal">
 <jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
		</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Permission -&gt; WorkFlow -&gt;
		History</td>
	</tr>

</table>
<lapschoice:ApplDevHeaderTag />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable" width="50%">
			<tr align="center">
				<td class="sub_tab_active">History</td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('recommendations')">Permitting Department Recommendations</a></td>
				
				
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('action')">Action</a></td>
				<td class="sub_tab_inactive"><a href="javascript:callOtherTab('remarks')">Remarks</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
					<tr>
						<td valign="top">History
						<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr class="dataheader">
												<td width="15%" align="center">From Flowpoint</td>
												<td width="19%" align="center">Sent By</td>
												<td width="16%" align="center">Sent On</td>
												<td width="15%" align="center">To Flowpoint</td>
												<td width="20%" align="center">Sent To</td>
												<td width="15%" align="center">Mail Type</td>
											</tr>									
												<%
												if (arrData!=null && arrData.size()>0)
												{
													for (int i = 0; i < arrData.size(); i++) 
													{
														arrRow = (ArrayList) arrData.get(i);
														
												%>	
													<tr class="datagrid">
														<td width="15%" align="center"><%=Helper.correctNull((String) arrRow.get(2))%></td>
														<td width="19%" align="center"><%=Helper.correctNull((String) arrRow.get(0))%></td>
														<td width="16%" align="center"><%=Helper.correctNull((String) arrRow.get(4))%></td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrRow.get(3))%></td>
														<td width="20%" align="center"><%=Helper.correctNull((String) arrRow.get(1))%></td>
														<td width="15%" align="center"><%=Helper.correctNull((String) arrRow.get(5))%></td>
													</tr>
													
												<%}
													}else {%>
													
													<tr class="datagrid">
														<td width="15%" align="center"></td>
														<td width="19%" align="center"></td>
														<td width="16%" align="center"></td>
														<td width="15%" align="center"></td>
														<td width="20%" align="center"></td>
														<td width="15%" align="center"></td>
													</tr>	
													<%}
													 %>
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
						
						<%if(strAppstatus.equalsIgnoreCase("pa")||strAppstatus.equalsIgnoreCase("ca")){ %>	
						<table align="center" border="0" cellspacing="1" cellpadding="1"
				class="outertable border1" align="center">
				<tr>
						<td align="left"><input type="button" name="doc_per_ltr"
						class="buttonStyle" value="Permission Letter" onClick="callPermissionLetter()"></td>

				</tr>
				</table>
				<%} %>
											


						<table width="0%" border="0" cellspacing="0" cellpadding="0"
							class="outertable" align="center">
							<tr>
								<td>
								<table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
									<tr valign="top">
										<td height="2" align="center">
										<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
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
<lapschoice:hiddentag pageid='<%=PageId%>'/>
 <input	type="button" name="cmdsave" disabled="disabled" style="visibility: hidden"> 
 </form>
</body>
</html>
