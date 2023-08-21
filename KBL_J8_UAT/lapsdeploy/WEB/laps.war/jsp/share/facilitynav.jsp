<%@ include file="../share/directives.jsp"%>
<html>
<head>
<TITLE>Laps Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename)
{
	document.forms[0].method="post";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	
}

function callPage(pagename)
{	
	document.forms[0].method="post";	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanId.value="formula";
	document.forms[0].hidBeanGetMethod.value="getCMA";
	document.forms[0].submit();
}
function callPage1(pname)
{
    document.forms[0].method="post";
	document.forms[0].action=appURL+"action/"+pname;
	document.forms[0].submit();
}
function doClose()
{
	callFunction('setupnav.jsp','','');
}
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
</head>

<body>
<form name="frmltrnav" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" colspan=5><jsp:include page="../share/help.jsp"
					flush="true"/>
				 </td>
			</tr>
			<tr>
				<td valign="top" colspan=5 class="page_flow">Home
				-&gt; Setup -&gt; Corporate Products</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<BR>
<BR>
<table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable"
			align="center">
			<tr>
				<td width="100%" valign="top" align="center">
				<fieldset style="width=600"><legend><b>Corporate
				Products</b></legend>
				<table width="100%" cellpadding="1" cellspacing="1" border="0" class="outertable">
					<tr>

						<td valign="top" align="center" width="51%">
						<fieldset style="width=200">
						<table width="100%" border="0" cellspacing="2" cellpadding="5" class="outertable"
							align="center">
							<tr>
								<td width="65%"><b><a
									href="javascript:callFunction('com_indus_master.jsp')"
									>Industry
								Master</a></b></td>
							</tr>
							<tr>
								<td width="65%"><b><a
									href="javascript:callPage('com_cma_master.jsp?hidMode=new')"
									>CMA Index
								</a></b></td>
							</tr>
							<tr>
								<td width="65%"><b><a
									href="javascript:callFunction('com_finmaster.jsp')"
									>CMA
								Master</a></b></td>
							</tr>
							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('com_formula.jsp?val=cma')"
									>Formula
								Definition </a></b></td>
							</tr>
							<!--
				  <TR> 
                    <TD ><B> <A HREF="javascript:callFunction('comdynamiccashflow.jsp?appno=ABCIABCI0000012')" >Cash Flow </A></B></TD>
                  </TR>
!-->
							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('com_facilitymaster.jsp')"
									>Facility
								Master</a></b></td>
							</tr>
							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('com_limitmaster.jsp')"
									>Limit
								Master</a></b></td>
							</tr>


						</table>
						</fieldset>
						</td>

						<td valign="top" width="50%">
						<fieldset style="width=200">
						<table width="100%" border="0" cellspacing="2" cellpadding="5"
							align="center" class="outertable">
							<tr>
								<td width="35%"><b> <a
									href="javascript:callWorkflow('setprdworkflowcom.jsp')"
									>Flow
								points</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callPage1('setexposure.jsp')"
									>Exposure</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('facilitiesdoc.jsp')"
									>Documents</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('setcomtermscondition.jsp')"
									>Terms and
								Conditions</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('netownedfunds.jsp')"
									>Net Owned
								Funds</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b><a
									href="javascript:callFunction('notecom_finmaster.jsp')"
									>Note to
								MCB Financials</a></b></td>
							</tr>
							<%-- <tr> 
                          <td  width="35%"><b><a href="javascript:callFunction('qis_master.jsp')" >QIS 
                            Master</a></b></td>
                        </tr>
							
				  <TR> 
                    <TD ><B> <A HREF="javascript:callFunction('comdynamiccashflow.jsp?appno=ABCIABCI0000012')" >Cash Flow </A></B></TD>
                  </TR>
--%>
							<%-- <tr> 
                          <td  width="35%"><b><a href="javascript:callFunction('qis_analysis_master.jsp')" >Analysis 
                            Master</a></b></td>
                        </tr>
                        <tr> 
                          <td  width="35%"><b><a href="javascript:callFunction('qis_analysis_point.jsp')" >Analysis 
                            Range</a></b></td>
                        </tr>--%>
							
							<%--  <tr> 
                          <td  width="35%"><b><a href="javascript:callFunction('npa_fin_master.jsp')" >NPA Financials</a></b></td>
                        </tr>
						
						 <tr> 
                          <td  width="35%"><b><a href="javascript:callFunction('defaulter.jsp')" >Defaulter Add</a></b></td>
                        </tr>
 --%>
						</table>

						</fieldset>
						</td>
						<td valign="top" width="50%">
						<fieldset style="width=200">
						<table width="100%" border="0" cellspacing="2" cellpadding="5"
							align="center" class="outertable">
							<tr>
								
                        <td width="35%"><a
									href="javascript:txtLoad('Setup');callFunction('combst_main.jsp')"
									><b>Broad Terms Proposal</b>
								</a> </td>
							</tr>
							<tr>
								<td width="35%"><a
									href="javascript:txtLoad('Setup');callFunction('setmst_mainnav.jsp')"
									><b>Modification in Sanction Terms</b>
								</a> </td>
							</tr>
							<tr>
								<td width="35%"><a
									href="javascript:txtLoad('Upload Defaulters');callFunction('rbiupload.jsp')"
									><b>RBI Defaulters List Upload</b>
								</a> </td>
							</tr>
							<tr>
								<td width="65%"><b> <a
									href="javascript:callFunction('com_extcreditrating.jsp')"
									>External Credit Rating Particulars</a></b></td>
							</tr>
							<tr>
								<td width="35%"><b></b></td>
							</tr>
							<tr>
								<td width="35%"><b></b></td>
							</tr>
							<tr>
								<td width="35%"><b></b></td>
							</tr>
							<tr>
								<td width="35%"><b></b></td>
							</tr>
							</table>

						</fieldset>
						</td>
					</tr>
				</table>
				</fieldset></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div align="center"><BR>
<lapschoice:combuttonnew 
btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" NAME="hidPage">
<INPUT TYPE="hidden" NAME="hidusr_id"> 
<input type="hidden" name="newmode" value="Y"> 
<input type="hidden" name="prdtype" value="C">
</div>
</form>
</body>
</html>
