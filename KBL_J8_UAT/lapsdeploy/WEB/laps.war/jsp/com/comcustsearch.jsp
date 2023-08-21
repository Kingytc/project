<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script language="Javascript">
var path      ="<%=ApplicationParams.getAppUrl()%>";

function menuOptionDivMouseDown (url)
{
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
				
}
function search1()
{
	var typ;
	if(document.forms[0].srchtype[0].checked==false && document.forms[0].srchtype[1].checked==false )
	{
		alert("Select the Search Criteria");
		return false;
	}
	
	
	if (document.forms[0].srchtype[0].checked)
		typ="Industry";
	else if(document.forms[0].srchtype[1].checked)
		typ="Group";
	var des=document.forms[0].txtvalue.value;
	if (typ==null) typ="";
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/comgroupresult.jsp?hidBeanId=exposure&hidBeanGetMethod=getApplicantList&txtvalue="+des+"&srchtype="+typ;
}

function doReset()
{
	document.forms[0].reset();
	document.all.result.src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp";
	
}
function newgrp()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comgroupmaster.jsp?mode=new&hidBeanId=exposure&hidBeanGetMethod=getExpData";
    document.forms[0].submit();
}

function callPage(pname)
{
	//document.forms[0].action=appUrl+"action/offline.jsp?fileid=companydtls";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pname;
	document.forms[0].submit();
}

function callClose(pname)
{
	if(ConfirmMsg(100))
	{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setexposure.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	callClose('facilitynav.jsp');
}
</script>
<STYLE>
DIV.cellContainer {
	width: 100%;
	height: 100%;
	overflow: auto;
}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top" colSpan=5>Home -&gt; Commercial(Applicant
				Master) -&gt; Group Master Details
			</tr>
		</table>
		</td>
	</tr>
</table>
<div align="center"><br>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable">
	<tr>
		<td valign="top">
		<div align="left"></div>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<div align="left"><b>Group Master Details</b><br>
						</div>
						<table width="100%" border="0" cellspacing="0" cellpadding="5"
							height="100%" class="outertable">
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="0"
									class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="4"
											class="outertable linebor">
											<tr>
												<td colspan="2"><b>Search By</b></td>
												<td colspan="5">&nbsp;</td>
											</tr>
											<tr>
												<td width="3%"><input type="radio" name="srchtype"
													value="Industry" style="border-style: none"></td>
												<td width="15%">Industry Exposure</td>
												<td width="2%"><input type="radio" name="srchtype"
													value="Group" style="border-style: none"></td>
												<td width="13%">Group Exposure</td>
												<td width="24%"><input type="text" name="txtvalue"
													onKeyPress="notAllowSplChar()"></td>
												<td width="12%" align="center"><input type="button"
													name="search" value="Search" class="buttonstyle"
													onclick="search1()"></td>
												<td width="12%" align="center"><input type="button"
													name="cmdOK22" value="New Group" class="buttonstyle"
													onclick="newgrp()"></td>
											</tr>
											<tr>
												<td colspan="7">
												<table width="70%" border="0" cellspacing="0"
													cellpadding="5" align="center" class="outertable">
													<tr class="dataheader" >
														<!--  <td width="50%"> 
                                              <div align="center"><font color="#FFFFFF"><b><font face="MS Sans Serif" size="1">Industry / Group</b></div>
                                            </td> -->
														<td width="100%">
														<div align="center"><b>Description</b></div>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr align="center"  >
												<td colspan="7"><iframe id="result" width=70%
													height=240
													src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp">
												</iframe></td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
</div>
</form>
</body>
</html>
