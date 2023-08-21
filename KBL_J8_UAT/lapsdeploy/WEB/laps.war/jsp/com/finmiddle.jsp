<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%request.setAttribute("_cache_refresh", "true");%>
<lapschoice:handleerror />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			String pageval = Helper.correctNull((String) hshValues.get("page"));
			String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();%>
<html>
<head>
<title>Financial</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/finmain.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<Script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
function fincomments()
{
	document.forms[0].hidBeanId.value="qisanalysisresult";
	document.forms[0].hidBeanGetMethod.value ="getDataList";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].action=appUrl+"action/qis_analysis_result.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
} 
</script>
</head>
<body>
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
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"	flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
	<tr>
	<%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt;Agriculture -&gt; Proposal -&gt; Financial Analysis
		</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis
		</td>
		<%} %>
		
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colspan="2">
		<table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<lapschoice:FinAnalysisTag tabid="1" />			
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="flowtype">
<input type="hidden" name="yearfrom" value="1"> 
<input type="hidden" name="access" value="B">
<input TYPE="hidden" value="10" name="hidTotal"> 
<input type="hidden" name="hidcmano" value="<%=Helper.correctNull((String)hshValues.get("cma_index"))%>"> 
<input type="button" name="cmdsave" disabled="disabled" style="visibility:hidden" />
</form>
</body>
</html>
