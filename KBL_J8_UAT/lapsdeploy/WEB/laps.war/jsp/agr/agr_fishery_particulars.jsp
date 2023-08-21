<%@include file="../share/directives.jsp"%>
<%
String PageType =Helper.correctNull((String) hshValues.get("PageType"));
ArrayList vecrow = new ArrayList();
ArrayList veccol = new ArrayList();
int vecsize = 0;
String tractortype = "";
String tractorreason = "";
String machinerytype = "";
String machineryreason = "";
if (hshValues != null) {
	vecrow = (ArrayList) hshValues.get("vecData");
	if(vecrow!=null)
	{
		vecsize = vecrow.size();
	}
	else
	{
		vecsize=0;
	}
	}
String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<html>
<head>
<title>Live Stock Details</title>

<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>


<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var seltract = "<%=Helper.correctNull((String)hshValues.get("seltractor"))%>";
var selmachin = "<%=Helper.correctNull((String)hshValues.get("selmachinery"))%>";
var schemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callhelp()
{
	
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function doClose()
{
	if( ConfirmMsg(100))
	{
		parent.menuFrame.doWindowClose();
	}
}

function doSave()
{
	<%for(int n = 0;n<vecsize;n++){%>
	if(document.forms[0].txtarea_presentposition[<%=n%>].value=="")
	{
	ShowAlert('121','Present Position Regarding Pisciculture');
	return;
	}
	<%}%>
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_fishery_particulars.jsp";
	document.forms[0].hidBeanMethod.value="updateFisheryParticularsData";
	document.forms[0].hidBeanGetMethod.value="getFisheryParticularsData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
 	disableFields(false);
	document.forms[0].hidAction.value ="update"; 
	enableButtons(true, false, false, false, true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getFisheryParticularsData";
		document.forms[0].action=appUrl+"action/agr_fishery_particulars.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateFisheryParticularsData";
		document.forms[0].hidBeanGetMethod.value="getFisheryParticularsData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_fishery_particulars.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	} 
}
	
function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			if(!document.forms[0].elements[i].name=="txt_particulars")
			{
				document.forms[0].elements[i].readOnly=one;
			}
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
		
	} 
		
}	

function onloading()
{
	disableFields(true);
	var strUserMode="";
	strUserMode=document.forms[0].hidUsrMode.value;
	//disableEditButtons(false, true, true, false, false, false);
	document.forms[0].cmddelete.disabled=true; 
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			enableButtons(false, true, true, true, false);
		}
		else
		{
			enableButtons(true, true, true, true, false);
		}
		
	}
	else
	{
		enableButtons(true, true, true, true, false);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	 text="#000000" onload="onloading()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5();"><script
	language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
	 
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Proposed Development </td>
     
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="201" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr class="dataheader">
								<td colspan="6" ><b>Particulars of
								Pisciculture</b></td>
							</tr>
							<tr class="dataheader">
								<td width="26%" align="center" >Particulars</td>
								<td width="24%" align="center" >Present Position Regarding Pisciculture
									<span class="mantatory">*</span>
									</td>
								<td width="24%" align="center" >Proposed Development For Pisciculture</td>
							</tr>
							<%if(vecsize>0){
							for (int i = 0; i < vecsize; i++) {
								veccol = (ArrayList) vecrow.get(i);
							%>
							<tr class="datagrid" >
								<td align="center"><input type="text" name="txt_particulars"
									value="<%=Helper.correctNull((String)veccol.get(0))%>" size="53" maxlength="99" style="text-align:left;background-color:#FFF2F1;border-style: none;color:#000000" readonly="readonly"></td>
								<td align="center">
									<textarea name="txtarea_presentposition" rows="5" cols="40" maxlength="4000" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)veccol.get(1))%></textarea>
								</td>
								<td align="center">
									<textarea name="txtarea_proposeddevelopment" rows="5" cols="40" maxlength="4000" onKeyUp="textlimit(this,3999)" onkeyPress="notAllowSingleQuote();textlimit(this,3999)"><%=Helper.correctNull((String)veccol.get(2))%></textarea>
								</td>
							</tr>
							<%}}%>
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
<%String strappno =Helper.correctNull((String) request
					.getParameter("appno"));

			if (strappno.equalsIgnoreCase("new")) {
				strappno = "";
			}

			%> 
			
			<lapschoice:combuttonnew
	btnnames="Edit_Save_Cancel_Delete_Audit Trail"
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid="<%=PageId%>" />
<input type="hidden" name="hidUsrMode" value="<%=session.getAttribute("strUserMode")%>">
</form>
</body>
</html>