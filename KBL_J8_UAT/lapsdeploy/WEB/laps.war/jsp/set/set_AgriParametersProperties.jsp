<%@ include file="../share/directives.jsp"%>
<%
	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType"));
	String strProductFor= Helper.correctNull((String) session.getAttribute("strProductFor"));
	
	if(strProductType.equalsIgnoreCase(""))
	{
		strProductType = Helper.correctNull((String)request.getParameter("hidAgrScheme"));
	}	
%>
<html>
<head>
<title>Setup(Products - Agri properties)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prdInterest.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">

var val = "<%=Helper.correctNull((String)request.getParameter("hidval"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";

function onloading()
{   
	DisableButtons(false,true,true,true,false);
	disabledFields(true);
}
function DisableButtons(val1,val2,val3,val4,val5)
{
	document.forms[0].cmdedit.disabled=val1;
	document.forms[0].cmdsave.disabled=val2;	
	document.forms[0].cmdcancel.disabled=val3;
	document.forms[0].cmddelete.disabled=val4;
	document.forms[0].cmdclose.disabled=val5;	
}

function disabledFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}	
	}
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getAgriPropertiesData";
		document.forms[0].hidSourceUrl.value="/action/set_AgriParametersProperties.jsp";
		document.forms[0].submit();	
	}
}

function doEdit()
{
	document.forms[0].hidAction.value="insert";
	disabledFields(false);
	DisableButtons(true,false,false,false,true);
}
function doSave()
{
		document.forms[0].cmdsave.disabled = true;
        document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateAgriPropertiesData";
		document.forms[0].hidBeanGetMethod.value="getAgriPropertiesData";
		document.forms[0].hidSourceUrl.value="/action/set_AgriParametersProperties.jsp";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();	
}
function doClose()
{	
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/comfacilityhome.jsp";
		document.forms[0].hidBeanId.value="setsearchproducts";
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].submit();
	}
}

function callAgrimargin(page)
{
     document.forms[0].hidBeanId.value="setinterest";
	 document.forms[0].hidBeanGetMethod.value="getAgrimarginData";
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanMethod.value="updateAgriPropertiesData";
		document.forms[0].hidBeanGetMethod.value="getAgriPropertiesData";
		document.forms[0].hidSourceUrl.value="/action/set_AgriParametersProperties.jsp";
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}
</script>
<style>
.navlist {
	padding: 3px 0;
	margin-left: 0;
	border-bottom: 1px solid #778;
	font: bold 12px Verdana, sans-serif;
}
.navlist li {
	list-style: none;
	margin: 0;
	display: inline;
}
.navlist li a,.navlist li a.normal {
	padding: 2px 0.5em 3px 0.5em;
	margin-left: 3px;
	border: 1px solid #778;
	border-bottom: none;
	background: #DDE;
	text-decoration: none;
}
.navlist li a:link {
	color: #448;
}
.navlist li a:visited {
	color: #667;
}
.navlist li a:hover {
	color: #000;
	background: #AAE;
	border-color: #227;
}
.navlist li a.current {
	background: white;
	border-bottom: 1px solid white;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body onLoad="onloading()">
<form name="prdagriprop" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"></jsp:include>
		<jsp:include page="../share/menus.jsp" flush="true"></jsp:include>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="17" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Agri Properties</td>
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
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable" align="center">
<tr>
<td>
<table width="40%" border="0" cellspacing="1" cellpadding="0" class="outertable" >
		<tr>
			<td width="20%" align="center" class="sub_tab_inactive">
						<a href="javascript:callAgrimargin('set_AgriParametersmargin.jsp')">Margin</a>
			</td>
			<td width="20%" align="center" class="sub_tab_active">Agri Properties</td>			
		</tr>
</table>
</td>
</tr>
</table>
	<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
							<tr>
								<td colspan="4">
									<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center">
									<tr>
									<td width="20%">Repairs and Maintenance</td>
									<td width="30%"><input type="text" name="txt_repairs" onkeypress="allowNumber(this)" 
									onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right"  size="8"
                          			value="<%=Helper.correctDouble((String)hshValues.get("repairs"))%>">&nbsp;<b>%</b>
                          			</td>
                          			<td width="15%">Lubricants</td>
									<td width="35%"><input type="text" name="txt_lubricants" onkeypress="allowNumber(this)" 
									onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right"  size="8"
                          			value="<%=Helper.correctDouble((String)hshValues.get("lubricants"))%>">&nbsp;<b>%</b>
                          			</td>
                          			</tr>
                          			</table>
								</td>
							</tr>
						</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="fac_id1" value="<%=Helper.correctNull((String)request.getParameter("fac_id"))%>">
</form>
</body>
</html>