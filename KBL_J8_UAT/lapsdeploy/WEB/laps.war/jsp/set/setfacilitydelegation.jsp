<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap)
{
	hshValues = (java.util.HashMap) objValues;
}
ArrayList vecData=new ArrayList();
ArrayList vecDatag=new ArrayList();
int size=0;
if(hshValues!=null)
{
	vecData = (ArrayList) hshValues.get("vecData");
	if(vecData!=null)  
	{
		size=vecData.size();
	}
	vecDatag = (ArrayList) hshValues.get("vecDatagroup");
}
String strProductType = Helper.correctNull((String) hshValues.get("prd_type"));
session.setAttribute("strProductType", strProductType);
session.setAttribute("schemeCode", Helper.correctNull((String) hshValues.get("scheme_code")));
String fac_id=Helper.correctNull((String) hshValues.get("fac_id"));
String strType=	Helper.correctNull((String)hshValues.get("txt_industry"));
String facility1 = Helper.correctNull((String)session.getAttribute("facility_nature"));
%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Delegated Powers</title>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript">
var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var path ="<%=ApplicationParams.getAppUrl()%>";
var fac_id ="<%=Helper.correctNull(request.getParameter("fac_id"))%>";
function callOnLoad()
{
	disableCommandButtons("load");
	disableFields(true);
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="edit")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=true;
	}
}
function doEdit()
{
	disableCommandButtons("edit");
	disableFields(false);
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].name=="txtsanc_limit" )
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].name=="txtinformalsanc_limit")
		{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].name=="txtsanc_security")
		{
			document.forms[0].elements[i].readOnly=val;
		}
	}
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="corporatefacility";
	document.forms[0].hidBeanGetMethod.value="getComFacilityDelegatedPowers";
	document.forms[0].hidBeanMethod.value="updateComFacilityDelegatedPowers";
	document.forms[0].hidSourceUrl.value="/action/setfacilitydelegation.jsp";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].submit();
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].hidBeanGetMethod.value = "";
		document.forms[0].action=appUrl+"action/comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="corporatefacility";
		document.forms[0].hidBeanMethod.value="getComFacilityDelegatedPowers";
		document.forms[0].hidSourceUrl.value="/action/setfacilitydelegation.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{	
	if(ConfirmMsg(100))
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
</script>
<style>
.CellContainer 
{
	width: 100%;
	height: 150px;
	overflow: auto;
}
</style>
</head>
<body onLoad="callOnLoad();">
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border:0"></iframe> 
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
<div class="menuitems" url="">
<script language="JavaScript">
if(document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
</div>
<form name="prdinterestfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" >
<tr> 
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="0" >
		<tr> 
			<td valign="top" colSpan="5"> 
				<jsp:include page="../share/help.jsp" flush="true"/>
				<jsp:include page="../share/menus.jsp" flush="true"/>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="3" />
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr> 
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Delegated Powers</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td>
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2">
						<tr>
							<td colspan="6">
								<table width="100%" border="0"  align="center" cellspacing="0" cellpadding="0">
								<tr>
									<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
										<tr>
											<td>
												<table width="98.3%" border="0" cellspacing="1" cellpadding="3">
												<tr class="dataheader"> 
													<td width="4%" align="center" nowrap="nowrap">S.No</td>
													<td width="36%" align="center">User Group</td>
													<td width="30%" align="center">Limit Sanction Powers</td>
													<td width="30%" align="center">Security Sanction Powers</td>
												</tr>
												</table>
											</td>
										</tr>
										<tr>
											<td>
											<div class="CellContainer"> 
												<table width="100%" border="0" cellpadding="3" cellspacing="1">
												<%
												String strPrdCode="";
												if(size>0)
												{
													if(vecData!=null)
													{
														for(int i=0;i<size;i++)
														{
														ArrayList vecVal = (ArrayList)vecData.get(i);
														String strSancClass=Helper.correctNull((String)vecVal.get(0));
														String strSancLimit=Helper.correctNull((String)vecVal.get(1));
														String strSancDesig=Helper.correctNull((String)vecVal.get(2));
														String strSancSecurity=Helper.correctNull((String)vecVal.get(3));
												%>
												<tr class="datagrid"> 
													<td width="4%" align="center" nowrap="nowrap"><%=i+1%></td>
													<td width="36%" align="center">
														<input type="hidden" name="txtsanc_class"
															size="15" readonly="readonly" value="<%=strSancClass%>">
														<input type="text" name="txtsanc_desig"
															size="50"  value="<%=strSancDesig%>" readOnly="readonly">
													</td>
													<td width="30%" align="center"> 
														<lapschoice:CurrencyTag name="txtsanc_limit" maxlength="13"
															size="15" onBlur="roundtxt(this)" value='<%=strSancLimit%>' /> 
													</td>
													<td width="30%" align="center"> 
														<lapschoice:CurrencyTag name="txtsanc_security" maxlength="13"
															size="15" onBlur="roundtxt(this)" value='<%=strSancSecurity%>' /> 
													</td>
												</tr>
												<%		}
													}
												}
												else
												{
													if(vecDatag!=null)
													{
														for(int i=0;i<vecDatag.size();i++)
														{
														ArrayList vecVal = (ArrayList)vecDatag.get(i);
														String strSancClass=Helper.correctNull((String)vecVal.get(0));
														String strSancDesig=Helper.correctNull((String)vecVal.get(1));
												%>
												<tr class="datagrid">
													<td width="4%" align="center" nowrap="nowrap"><%=i+1%></td>
													<td width="36%" align="center">
														<input type="hidden" name="txtsanc_class"
															size="15" readonly="readonly" value="<%=strSancClass%>">
														<input type="text" name="txtsanc_desig"
															size="50" value="<%=strSancDesig%>" readOnly="readonly">
													</td>
													<td width="30%" align="center"> 
														<lapschoice:CurrencyTag name="txtsanc_limit" maxlength="13"
															onBlur="roundtxt(this)" size="15"/>
													</td>
													<td width="30%" align="center"> 
														<lapschoice:CurrencyTag name="txtsanc_security" maxlength="13"
															onBlur="roundtxt(this)" size="15"/>
													</td>
												</tr>
												<%		}
													}
												}
												%>
												</table>
											</div>
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
	</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>