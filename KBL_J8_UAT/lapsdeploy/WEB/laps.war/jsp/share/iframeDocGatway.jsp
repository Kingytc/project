<%@include file="../share/directives.jsp"%>
<%
ArrayList arrAttachHolder = new ArrayList();
ArrayList arrCol = new ArrayList();
if(hshValues!=null){
	arrAttachHolder = (ArrayList)hshValues.get("arrRow");	
}

int intsize=0;

if(arrAttachHolder!=null)
	intsize=arrAttachHolder.size();
	
String app_status=Helper.correctNull((String)session.getAttribute("strappstatus"));
String sessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
if(Helper.correctNull((String)request.getParameter("strpagetype")).equals("postsanc"))
{
	sessionModuleType="RET";
}

String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType")).trim();
%>
<html>
<head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script type="text/javascript">
var varUserID="<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>";
var varAppHolder="<%=Helper.correctNull((String)hshValues.get("strAppHolder"))%>";
var app_status="<%=app_status%>";
var varsessionModuleType="<%=sessionModuleType%>";
var varOrgScode="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>";
var StrDigiLoanType="<%= StrDigiLoanType%>";
var varappstatus="<%=Helper.correctNull((String)hshValues.get("strappstatus"))%>";
function setSnoVal(val){	
	parent.frames.viewDocAttach(val);
}
function setDIGISnoVal(val)
{
	var title = "AttachmentViewer";
	var prop = "scrollbars=yes,width=850,height=620";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;		
	window.open(val,title,prop);
}
function chkDeleteFlag(obj)
{
	
	if(parent.frames.document.forms[0].hidpagefrom.value=="PSDA")
	{
		if(((varUserID!=varAppHolder)&& parent.frames.varMigrationFlag!="Y")||(parent.frames.varMigrationFlag=="Y" && varAppHolder==varOrgScode && app_status!="pa"))
		{
			alert("You cannot Delete this Attachment");
			obj.checked=false;
			return;
		}
	}
	else if(parent.frames.document.forms[0].hidpagefrom.value!="MSME")
	{
		if((varUserID!=varAppHolder) || (parent.frames.varappstatus!="op" && varappstatus!="op"))
		{
			alert("You cannot Delete this Attachment");
			obj.checked=false;
			return;
		}
	}
	else
	{
		if((parent.frames.varappstatus!="op" && varappstatus!="op"))
		{
			alert("You cannot Delete this Attachment");
			obj.checked=false;
			return;
		}
	}
}
function callLoad()
{
	parent.frames.document.forms[0].hidDocCnt.value="<%=intsize%>";
	document.forms[0].fromDms.disabled    = true;
	<%
	if(arrAttachHolder!= null && arrAttachHolder.size()>0){
	for(int i=0;i<arrAttachHolder.size();i++)
	{
		arrCol = (ArrayList)arrAttachHolder.get(i);
		String strDocUrl = Helper.correctNull((String)arrCol.get(3));
	%>
	document.forms[0].fromDms[<%=i%>].disabled    = true;

	
	<%}}%>
	
}
</script>
</head>
<body onload="callLoad();">
<form method="post">
<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
<tr class="datagrid">
<td></td>
<td>Documents</td>
<td>From DMS</td>
</tr>
<%
if(arrAttachHolder!= null && arrAttachHolder.size()>0){
for(int i=0;i<arrAttachHolder.size();i++)
{
	arrCol = (ArrayList)arrAttachHolder.get(i);
	String strFileName  = Helper.correctNull((String)arrCol.get(1));
	String strDocCode  = Helper.correctNull((String)arrCol.get(3));
%>
<tr class="datagrid">
	<%if(strDocCode.equalsIgnoreCase("")) { %>
	<td width="5%" align="center"><input type="radio" name="chk_attachdocs" style="border: none" onclick="chkDeleteFlag(this);"></td>
	<% }else{ %>
	<td width="5%" align="center"><input type="hidden"  name="chk_attachdocs" style="border: none" onclick="chkDeleteFlag(this);"></td>
	<% } %>
	<%if(!sessionModuleType.equalsIgnoreCase("RET") && StrDigiLoanType.equalsIgnoreCase("PC")) { %>
		<td width="95%" onClick ="setDIGISnoVal('<%=ApplicationParams.getStrdmsurl()%><%=Helper.correctNull((String)arrCol.get(3))%>')" style="display: inline-block; cursor: pointer;">
	<% } else if(sessionModuleType.equalsIgnoreCase("RET") && StrDigiLoanType.equalsIgnoreCase("PC")) { %>
	<td width="95%" onClick ="setSnoVal('<%=Helper.correctNull((String)arrCol.get(0))%>')" style="display: inline-block; cursor: pointer;">
	<% } else if(sessionModuleType.equalsIgnoreCase("DIGI")) { %>
		<td width="95%" onClick ="setDIGISnoVal('<%=ApplicationParams.getStrdmsurl()%><%=Helper.correctNull((String)arrCol.get(3))%>')" style="display: inline-block; cursor: pointer;">
<% } else {
	if(strDocCode.equalsIgnoreCase("")) {%>
				<td width="95%" onClick ="setSnoVal('<%=Helper.correctNull((String)arrCol.get(0))%>')" style="display: inline-block; cursor: pointer;">
	<% }else{ %>
			<td width="95%" onClick ="setDIGISnoVal('<%=ApplicationParams.getStrdmsurl()%><%=Helper.correctNull((String)arrCol.get(3))%>')" style="display: inline-block; cursor: pointer;">
		<% } }%>
	
	<input type="hidden" name="attach_hidden" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
	<input type="hidden" name="hidFilename" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
	<font color="blue"><u><%=strFileName%></u></font></td>
	
 <td> 
	<select	name="fromDms"	tabindex="12">
		<%if(strDocCode.equalsIgnoreCase("")) {%>
		<option value="n">------No------</option>
		<%}else{ %>
		<option value="y">------Yes------</option>
		<%} %>
	</select>                                           
</td></tr>
<%}}else{%>
<tr class="datagrid">
	<td align="center">No Attachment Found</td>				
</tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<tr><td>&nbsp;</td></tr>
<%}%>	
</TABLE>
</form>
</body>
</html>