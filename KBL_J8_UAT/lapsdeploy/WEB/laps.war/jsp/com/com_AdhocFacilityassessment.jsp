<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<% 
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varAdhocFalg="<%=Helper.correctNull((String)hshValues.get("strAdhoFacFlag"))%>";
function htmlView()
{
  var hlpvar = appURL+"action/com/htmlView.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComment&type=1&appno="+"<%=Helper.correctNull((String)hshValues.get("appno"))%>";
  var title = "HTMLVIEW";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
}

function call_page(url,method,type)
{	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();	
}

function placevalues()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	if(document.forms[0].btnenable.value=="N")	 
	{
	 	
	 	enableButtons(true,true,true,false);
	}
	else
	{
	enableButtons(false,true,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			
			if(document.forms[0].elements[i].type=="textarea")
			{
				 document.forms[0].elements[i].readOnly=true;			  
			}			
		}
		}

	if(varAdhocFalg=="Y")
	{
		document.all.idAssessment.style.display="table-row";
		document.all.idComments.style.display="none";
	}
	else
	{
		document.all.idComments.style.display="table-row";
		document.all.idAssessment.style.display="none";
		document.forms[0].cmdedit.disabled=true;
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/com_AdhocFacilityassessment.jsp?type=37";
	document.forms[0].submit();
	}
}

function doClose()
{
	var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
}

function doEdit()
{		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;			  
			}			
		}
	enableButtons(true,false,false,true);
	document.forms[0].hidAction.value ="insert";
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_assessment');
}

function doSave()
{	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_AdhocFacilityassessment.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=37";
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename,flowtype)
{
	if(flowtype=="COP")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=flowtype;
		document.forms[0].submit();
	}	
}   
</script>
</head>

<body onload="placevalues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url=""><script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; <% if(strSessionModuleType.equalsIgnoreCase("CORP")){ %>
Corporate &amp; SME -&gt; <%}else{ %> Agriculture &amp; <%} %> Proposal
-&gt; Financial Analysis -&gt; Assessment -&gt; Adhoc Facility
Assessment </span><br>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="1"
	class="outertable" align="center">
	<tr>
		<td><jsp:include page="../com/com_commentstab.jsp" flush="true">
			<jsp:param name="tabid" value="37" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td valign="top" align="center">
		<table width="90%" align="center" border="0" cellspacing="0"
			cellpadding="3" class="outertable">
			<tr id="idAssessment"  style="display: none;">
				<td width="60%" valign="top">
				<div id="id_div">
				<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("com_assessment_comments")) %></div>
				</div>
				<div id="id_editor"><textarea name="txt_assessment" cols="110"
					wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,99)" onKeyUp="textlimit(this,99)"><%=Helper.correctNull((String)hshValues.get("com_assessment_comments"))%>
</textarea></div>
				</td>
			</tr>
			<tr id="idComments" style="display: none;">
				<td align="center">
				<table width="100%" align="center" border="0" cellspacing="0"
					cellpadding="3" class="outertable border1">
					<tr>
						<td width="60%" align="center"><span class="mantatory">Assessment not Required. Adhoc Facility not present in this proposal</span></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="yearfrom" value="1"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="pagefrom"> <INPUT TYPE="hidden" name="strAssessment"
	value="<%=request.getParameter("strAssessment")%>"> <input
	type="hidden" name="hidpageval"
	value="<%=Helper.correctNull((String)hshValues.get("strFlowType"))%>">
</form>
</body>
</html>
