<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@include file="../share/directives.jsp"%>
<%
int  vecModSize = 0;
ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
if (vecModule != null) {
	vecModSize = vecModule.size();
}
String tagFlag = "",strCurModule="";
ArrayList arrCol = new ArrayList();
ArrayList arrRow = (ArrayList) hshValues.get("arrRow");
String strfintype = Helper.correctNull((String)hshValues.get("fintype"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<title>Financial rating workflow</title>
<script type="text/javascript">
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var cma="<%=strfintype%>";
var finaced_id="<%= Helper.correctNull((String)hshValues.get("finace_id"))%>";
function callAction()
{
	document.forms[0].hidBeanId.value = "financial";
	document.forms[0].hidBeanGetMethod.value ="getAction";
	document.forms[0].action=appUrl+"action/com_financialratingaction.jsp";
    document.forms[0].submit();
}

function doClose()
{
 	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appUrl+"action/financialsrch.jsp";
	 	document.forms[0].submit();
	}
}

function getSection(modid)
{	
	document.forms[0].hidcmasno.value=cma;
	document.forms[0].hidfinanceid.value=finaced_id;
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}

function callonlyforrating()
{
document.forms[0].hidBeanId.value = "financial";
document.forms[0].hidBeanGetMethod.value = "updateFinRating";
document.forms[0].action=appUrl+"action/FinancialOFRating.jsp";
document.forms[0].submit();
}

function getdigirating()
{ 
    
		document.forms[0].hidcmasno.value=cma;
		document.forms[0].hidfinanceid.value=finaced_id;
		document.forms[0].hidBeanId.value="financial";	
		document.forms[0].hidBeanGetMethod.value="getDigiRating";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/digiRatingFin.jsp";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}
</script>

</head>
<body>
<form name="misdet" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		<td class="page_flow">Home -&gt;Financial / Rating-&gt;Financial/Rating Workflow-&gt;History</td>
	</tr>
</table>
<lapschoice:finapptype appid='<%=Helper.correctNull((String)hshValues.get("appidnew"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>'/> 
<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   
				  strClass="sub_tab_inactive";
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
				}%>
				</td>
								<%}%>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('financial','getDataRatio','finratio.jsp','RA1&pagetype1=OFR')">FINANCIAL RATIOS</a></b></td>
					<% if(Helper.correctNull((String)hshValues.get("digiflag")).equalsIgnoreCase("Y")){ %>
								<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getdigirating()">DIGI RATING</a></b></td>  
								<%} else {%>
								<td class="sub_tab_inactive"><a
					href="javascript:callonlyforrating()">ONLY FOR RATING</a></td>
										<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('perDeviation','getpermDocumentDetails','perm_docAttachment.jsp')">Document Attachment</a></b></td>
								<%}%>
				<td align="center" class="sub_tab_active">FINANCIAL/RATING
				WORKFLOW
			</tr>
						</table>
						</td>
					</tr>
				</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable"
			width="40%">
			<tr align="center">
				<td width="50%" class="sub_tab_active">History</td>
				<td width="50%" class="sub_tab_inactive"><a
					href="javascript:callAction()">Action</a></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="5"
	class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable border1">
					<tr>
						<td valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="2" align="center"
							class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td valign="top">
										<table width="100%" border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr class="dataheader">
												<td width="25%" align="center">Sent By</td>
												<td width="25%" align="center">Sent On</td>
												<td width="25%" align="center">Sent To</td>
												<td width="25%" align="center">Mail Type</td>
											</tr>
											
											<%
												if (arrRow != null && arrRow.size() > 0) {
													for (int i = 0; i < arrRow.size(); i++) {
														arrCol = (ArrayList) arrRow.get(i);
											%>
											<tr class="datagrid">
												<td width="25%" align="left"><%=arrCol.get(0)%></td>
												<td width="25%" align="center"><%=arrCol.get(1)%></td>
												<td width="25%" align="left"><%=arrCol.get(2)%></td>
												<td width="25%" align="center"><%=arrCol.get(3)%></td>
												
											</tr>
											<%
												}
												}
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
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames='' btnenable=''/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String)hshValues.get("fintype"))%>">
<input type="hidden" name="hid_appid" value="<%=Helper.correctInt((String)hshValues.get("appidnew"))%>">
<input type="hidden" name="pageval">
<input type="hidden" name="AssetandLiab" value="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>">
<INPUT TYPE="hidden" NAME="hidfinid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
</form>
</body>
</html>