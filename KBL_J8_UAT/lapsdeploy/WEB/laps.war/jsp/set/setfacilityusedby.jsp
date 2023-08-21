<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Used By</title>
<script language="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var val = "<%=request.getParameter("val")%>";
<%
	String fac_id=Helper.correctNull(request.getParameter("fac_id"));
	out.println(fac_id);
	HashMap hshSelNames = (HashMap)hshValues.get("OrgSelNames");
	int len = hshSelNames.size(); 
	out.println("var arrSelNames = new Array("+len+");");
	out.println("var arrSelKeys = new Array("+len+");");
	Iterator iterator =(hshSelNames.keySet()).iterator();
	int i=0;
	while(iterator.hasNext())
	{
		String strTmp = (String) iterator.next();
		out.println("arrSelNames["+i+"] = '"+hshSelNames.get(strTmp)+"';");
		out.println("arrSelKeys["+i+"] = '"+strTmp+"';");
		i++;
	}
	HashMap hshNames = (HashMap)hshValues.get("OrgNames");
	int len1 = hshNames.size();
	out.println("var arrNames = new Array();");
	out.println("var arrKeys = new Array();");
	iterator = (hshNames.keySet()).iterator();
	i=0;
	while(iterator.hasNext())
	{
		String strTmp = (String) iterator.next();
		out.println("arrNames["+i+"] = '"+hshNames.get(strTmp)+"';");
		out.println("arrKeys["+i+"] = '"+strTmp+"';");
		i++;
	}
	String strProductType = Helper.correctNull((String)session.getAttribute("strProductType"));
%>
function setData()
{
	setButtons();
	code = '<%= hshValues.get("prd_code") %>';
	level = '<%= hshValues.get("prd_org_level") %>';
	scode = '<%= hshValues.get("fac_org_scode") %>';
	setOptions(level);
	for(i=0;i<arrSelNames.length;i++)
	{
		document.prdusedfrm.seldInsti.options[i] = new Option(arrSelNames[i],arrSelKeys[i]);
	}
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setfacilityusedby.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script> 
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="setData();loadUsedApp()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
<div class="menuitems" url="">
<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div>
</div>
<form name="prdusedfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr> 
			<td>
				<jsp:include page="../share/help.jsp" flush="true"/>
				<jsp:include page="../share/menus.jsp" flush="true"/>
			</td>
		</tr>
		</table>		
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="2" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Used By</td>
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
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
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
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
								<tr class="dataheader"> 
									<td colspan="8">Select Organisation Level</td>
								</tr>
								<tr class="datagrid">
								<% if(!(((String)hshValues.get("orgname1")).trim()).equals(""))
								{
								%>
									<td width="5%" align="center">
										<input type="radio" name="radioOrg" value="C" disabled="true"
											style=" border-style: none" onClick="setOptions('C')">
									</td>
									<td width="20%">&nbsp;<%=hshValues.get("orgname1")%></td>
								<%  
								}
								if(!(((String)hshValues.get("orgname2")).trim()).equals(""))
								{
								%>
									<td width="5%" align="center">
										<input type="radio" name="radioOrg" value="R" disabled="true"
											style=" border-style: none" onClick="setOptions('R')">
									</td>
									<td width="20%" align="left">&nbsp;<%=hshValues.get("orgname2")%></td>
								<%  
								}
								if(!(((String)hshValues.get("orgname3")).trim()).equals(""))
								{
								%>
									<td width="5%" align="center">
										<input type="radio" name="radioOrg" value="D" disabled="true"
											style=" border-style: none" onClick="setOptions('D')">
									</td>
									<td width="20%">&nbsp;<%=hshValues.get("orgname3")%></td>
								<%  
								}
								if(!(((String)hshValues.get("orgname4")).trim()).equals(""))
								{
								%>
									<td width="5%" align="center">
										<input type="radio" name="radioOrg" value="A" disabled="true"
											style=" border-style: none" onClick="setOptions('A')">
									</td>
									<td width="20%" align="left">&nbsp;<%=hshValues.get("orgname4")%></td>
								<%}%>
								</tr>
								</table>
							</td>
						</tr>
						</table>
					</td>
				</tr>
				<tr>
					<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="1">
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
								<tr class="dataheader">
									<td colspan="3" valign="top">Double click to select Institution</td>
								</tr>
								<tr class="dataheader">
									<td width="37%" align="center" valign="top">Select the&nbsp;Institution&nbsp;</td>
									<td width="41%" align="center">Selected&nbsp;Institution</td>
								</tr>
								<tr class="datagrid">
									<td width="37%" align="center" valign="top">
										<select name="selInsti" size="8" style="width:75%;"
											onDblClick="javascript:selectedProduct()">
										</select>
									</td>
									<td width="41%" align="center" >
										<select name="seldInsti" size="8" style="width:75%;"
											onDblClick="checkRemove()" multiple="multiple">
										</select>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="hidPageId" value="<%=PageId%>">
<input type="hidden" name="hidBeanId" value="setusedby">
<input type="hidden" name="hidBeanMethod" value="updateFacUsedby">
<input type="hidden" name="hidSourceUrl" value="/action/setfacilityusedby.jsp" >
<input type="hidden" name="hidSeldInsti" value="" > 
<input type="hidden" name="hidActionMode" value="INSERT">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidActionMode" value="INSERT">
<input type="hidden" name="hidBeanGetMethod" value="getFacUsedby">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="sch_code" value="">
<input type="hidden" name="checkApp" value="">
<input type="hidden" name="hidProducttype" value="">
<input type="hidden" name="hidindtype" value="">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidcorp_faccode" value="<%=Helper.correctNull(request.getParameter("txt_code"))%>">
<input type="hidden" name="hidcorp_headname" value="<%=Helper.correctNull(request.getParameter("txtcat_name"))%>">
<input type="hidden" name="hidcorp_subfac" value="<%=Helper.correctNull(request.getParameter("txt_facility"))%>">
<input type="hidden" name="prd_rng_from" value="<%=Helper.correctNull(request.getParameter("prd_rng_from"))%>">
<input type="hidden" name="prd_rng_to" value="<%=Helper.correctNull(request.getParameter("prd_rng_to"))%>">
<input type="hidden" name="prd_minterm" value="<%=Helper.correctNull(request.getParameter("prd_minterm"))%>">
<input type="hidden" name="prd_maxterm" value="<%=Helper.correctNull(request.getParameter("prd_maxterm"))%>">
<input type="hidden" name="txt_holiday" value="<%=Helper.correctNull(request.getParameter("txt_holiday"))%>">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
</form>
</body>
</html>