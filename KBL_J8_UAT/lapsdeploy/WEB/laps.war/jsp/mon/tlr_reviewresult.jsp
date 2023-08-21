<%@include file="../share/directives.jsp"%>
<html>
<head>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varcustclassification="<%=Helper.correctNull((String)request.getParameter("custclassification"))%>";
var varorglevel="<%=strOrgLevel%>";
var varnewButtonDisable="<%=Helper.correctNull((String)hshValues.get("newButtonDisable"))%>"

function callPage(accno,cbsid,appstatus,year)
{
	document.forms[0].reviewYear.value=year;
	document.forms[0].appstatus.value=appstatus;
    document.forms[0].hidtlrno.value=accno;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/reviewnotetypeofreview.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].hidBeanId.value="reviewtermloantwo";
	document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
	document.forms[0].submit();
	
}
function callOnLoad()
{
	if(varnewButtonDisable=="Y" || varcustclassification!="001" || varorglevel!="A")
	{
		parent.frames.document.all.yearchk.style.visibility="hidden";
		parent.frames.document.all.yearchk.style.position="absolute";
	}
	else 
	{
	 	parent.frames.document.all.yearchk.style.visibility="visible";
	 	parent.frames.document.all.yearchk.style.position="relative";
	}
	parent.frames.document.forms[0].hidMaxYear.value='<%=Helper.correctNull((String)hshValues.get("tlr_maxyear"))%>';
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body  onLoad="callOnLoad()">
<form name="srchform" class="normal">
<table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
	<% 
   ArrayList vec = (ArrayList)hshValues.get("vecval");
    ArrayList vec1=null;
  	if(vec!=null)
	{
	int vecsize =vec.size();
	for(int i=0;i<vecsize;i++)
	{ 
		vec1=(ArrayList)vec.get(i);
		
		%>

	<tr valign="top" class="datagrid">
		<td width="9%" align="center"><a
			href="javascript:callPage('<%=Helper.correctNull((String)vec1.get(0))%>', '<%=Helper.correctNull((String)vec1.get(1))%>', '<%=Helper.correctNull((String)vec1.get(2))%>','<%=Helper.correctNull((String)vec1.get(3))%>')">
			<input type="hidden" name="hidYear" value="<%=Helper.correctNull((String)vec1.get(3))%>"><%=Helper.correctNull((String)vec1.get(0))%></a></td>
			<td width="18%" align="center"><%=Helper.correctNull((String) request.getParameter("cbsname"))%>&nbsp;</td>
		<td width="20%" align="left"><%=Helper.correctNull((String)vec1.get(4))%>&nbsp;</td>


	</tr>
	<%}
	}%>
</table>
<lapschoice:hiddentag/>
<input type="hidden" name="appname"> 
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>"> 
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("id"))%>"> 
<input type="hidden" name="cbsname" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">
<input type="hidden" name="custorgscode" value="<%=Helper.correctNull((String)request.getParameter("custorgscode"))%>">
<input type="hidden" name="appstatus" value=""> 
<input type="hidden" name="reviewYear" value=""> 
<input type="hidden" name="hidtlrno" value="">
</form>
</body>
</html>
