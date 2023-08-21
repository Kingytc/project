<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			int noofrows = Integer.parseInt(request.getParameter("noofrows"));

			%>

<html>
<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strLinkFrom=Helper.correctNull((String)request.getParameter("pageType"));
%>
<SCRIPT LANGUAGE="JavaScript">
var vardataexists="<%=Helper.correctNull((String)hshValues.get("exbool"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";
function callLink(demoid, cbsdata, cbsid,name,addr,citycode,dist,statcode,pin,ph,fax,cityname,statename,distname,status,age,minority,indminority)
{
if(status == "N")
{
	alert("Customer Profile Not Completed");
	return;
}

if(parent.frames.window.opener.document.all.comapp_divisiontype.value=="K" && parent.frames.window.opener.document.all.comapp_divisionSubtype.value=="002" && parseInt(age)>18)
{
	alert("Member should be below 18 Years");
	return;
}
if(minority == "Y")
{
	alert("Please fill Whether majority of members/owners belong to minority community in-> Demographics tab");
	return;
}
if(indminority=="Y"){
	alert("Please fill Minority in-> Demographics tab");
	return;
}
parent.frames.window.opener.document.all.comapp_customer_id.value=demoid;
parent.frames.window.opener.document.all.comapp_div_name.value=name;
parent.frames.window.opener.document.all.comapp_div_address.value=addr;

parent.frames.window.opener.document.all.hid_city.value=citycode;
parent.frames.window.opener.document.all.hid_state.value=statcode;
parent.frames.window.opener.document.all.comapp_div_pin.value=pin;
parent.frames.window.opener.document.all.comapp_div_phone.value=ph;
parent.frames.window.opener.document.all.comapp_div_fax.value=fax;

parent.frames.window.opener.document.all.comapp_div_city.value=cityname;
parent.frames.window.opener.document.all.comapp_div_state.value=statename;

parent.frames.window.opener.document.all.comapp_div_dist.value=distname;
parent.frames.window.opener.document.all.hid_dist.value=dist;
parent.frames.window.opener.document.all.comapp_cbsid.value=cbsid;

parent.frames.window.opener.document.forms[0].comapp_customer_id.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_cbsid.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_div_name.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_div_address.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_div_pin.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_div_phone.readOnly = true;
parent.frames.window.opener.document.forms[0].comapp_div_fax.readOnly = true;

top.close();	
}

function callOnload()
{
	
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
<form name="isearch" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
	<%String uniqid = "";

			if (arryRow != null) {
				int vecsize = arryRow.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {
						arryCol = (ArrayList) arryRow.get(l);

						if (arryCol != null) {
							uniqid = Helper
									.correctNull((String) arryCol.get(0));
							if (uniqid.equalsIgnoreCase("")) {
								uniqid = Helper.correctNull((String) arryCol
										.get(4));
							}

							%>
	<tr class="datagrid">

		<td width="35%" align="left">&nbsp; <a
			href="JavaScript:callLink('<%=uniqid%>', '<%=arryCol.get(6)%>','<%=arryCol.get(5)%>','<%=arryCol.get(1)%>','<%=arryCol.get(7) %>','<%=arryCol.get(8) %>','<%=arryCol.get(9) %>','<%=arryCol.get(10) %>','<%=arryCol.get(11) %>','<%=arryCol.get(12) %>','<%=arryCol.get(13) %>','<%=arryCol.get(14) %>','<%=arryCol.get(15) %>','<%=arryCol.get(16) %>','<%=arryCol.get(17) %>','<%=arryCol.get(18) %>','<%=arryCol.get(19) %>','<%=arryCol.get(20) %>')" class="blackfont">
		<b><%=Helper.replaceForJavaScriptString((String)arryCol.get(1))%></b></a></td>
		<td width="35%" align="center"">&nbsp;<%=Helper.correctNull((String)arryCol.get(5))%>&nbsp;&nbsp;</td>
		<td width="30%" align="center"">&nbsp;<%=uniqid%>&nbsp;&nbsp;</td>

	</tr>
	<%}
					}
				}

				else {

				%>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5" align="center">&nbsp;No  Data Found</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<%}
			}
		%>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hidModuleName" value="P">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
