<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			int noofrows = Integer.parseInt(request.getParameter("noofrows"));
			int vecsize =0;
			if (arryRow != null) 
				vecsize = arryRow.size();
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
var pageType='<%=strLinkFrom%>';
var varucicFlag="<%=Helper.correctNull((String)hshValues.get("ucicFlag"))%>";

function callLink(demoid, cbsdata, cbsid,democuststatus,hidval,appoldid,cust_dupe,varoccup, CBSfetch_flag,existCust)
{
	/*if(existCust=="block")
	{
    alert("Customer profile is pending...");
	return;
	}*/
	
	if(cust_dupe>0)
	{
		alert("Duplicate customer id with same PAN/AADHAR/PASSPORT. Do De-duplication in FINACLE and then continue. Check through UCIC- BVT.");
		return;
	}

	if(varucicFlag=="Y")
	{
		alert("Given CBS-ID having Pending Digi Proposal as new to bank customer.please complete and proceed further");
		return;
	}
	
	if(varoccup=="MIGR")
	{
		alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile through Customer ID");
		return;
	}
	if(pageType=="Fin")
	{
		if(democuststatus!="Y")
		{
			alert("Customer Profile is not filled completely");
			return;
		}
	}
	document.forms[0].hidAppType.value="";
	document.forms[0].hidDemoId.value=demoid;


	if(CBSfetch_flag!="")
	{
		cbsdata="FALSE";
		document.forms[0].hidDemoId.value=CBSfetch_flag;
	}
	
	<%if(vecsize<2)
	{%>
		document.all.idstab.style.display="table-cell";
		document.all.idmtab.style.display="none";
	<%}else{%>
		document.all.idmtab[hidval].style.display="none";
		document.all.idstab[hidval].style.display="table-cell";
	<%}%>
	
	if(pageType=="sec")
	{
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanGetMethod.value="getSecurities";
		document.forms[0].hidBeanMethod.value="getSecurities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/customer_securities.jsp?applnt=T&scode=yyy&cbsdata="+cbsdata+"&cbsid="+cbsid+"&demoid="+demoid;
		
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else if(pageType=="Fin")
	{
		//alert();
		//document.forms[0].hidBeanId.value="facilities";
		//document.forms[0].hidBeanGetMethod.value="getFinancialtype";
		//document.forms[0].hidBeanMethod.value="getData";
		//document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_FinancialTemp.jsp?hidappid="+demoid;
		//document.forms[0].submit();
		parent.frames.document.all.non_finacial.style.visibility="hidden";
		parent.frames.document.all.non_finacial.style.position="absolute";
		parent.frames.document.all.finacial.style.visibility="visible";
		parent.frames.document.all.finacial.style.position="relative";
		//parent.frames.document.all.isearch.width="50%";
				
		parent.frames.document.all.isearch.src=appURL+"action/iframefinsearch.jsp?hidBeanGetMethod=getFinancialtype&hidBeanId=facilities&hidappid="+demoid;
		
					
	}
	else if(pageType=="COF")
	{
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getClosureFacilities";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setclosureoffacility.jsp?hidcbsid="+cbsid+"&appoldid="+appoldid;
		
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	else
	{
		
		parent.frames.document.getElementById('imgloading').style.display = 'block';
		document.body.scroll="no";		
		document.forms[0].hidAction.value=cbsid;
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/perapplicant.jsp?applnt=T&scode=yyy&cbsdata="+cbsdata+"&cbsid="+cbsid;
		
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
	}
	
}
function callOnload()
{
	if(vardataexists=="true")
	{
		var varapplicantid="<%=Helper.correctNull((String)hshValues.get("exapplicantid"))%>";
		var varapplicantbranch="<%=Helper.correctNull((String)hshValues.get("exbranchname"))%>";
		alert("Person with same CBS ID exists in Applicant Id : " +varapplicantid +" and in Branch : "+varapplicantbranch);	
	}
	if(pageType=="Fin")
	{
		parent.frames.document.all.non_finacial.style.visibility="visible";
		parent.frames.document.all.non_finacial.style.position="relative";
	}
	else
	{
		parent.frames.document.getElementById('imgloading').style.display = 'none';
		
	}
}

</SCRIPT>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="callOnload()">
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
<form name="isearch" method="post" class="normal" style="width: 102%">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">


	<%String uniqid = "",strPAN="";

			if (arryRow != null) {
				vecsize = arryRow.size();

				if (vecsize != 0) {
					if (noofrows > vecsize) {
						noofrows = vecsize;
					}
					for (int l = 0; l < noofrows; l++) {
						arryCol = (ArrayList) arryRow.get(l);

						if (arryCol != null) {
							uniqid = Helper
									.correctNull((String) arryCol.get(4));
							strPAN = Helper.correctNull((String)arryCol.get(2));						
							%>
	<tr class="datagrid">
		
		<td width="35%" align="center" id="idmtab">&nbsp;
		<%if(strLinkFrom.equalsIgnoreCase("Fin")){%> 
		<a href="JavaScript:callLink('<%=arryCol.get(0)%>', '<%=arryCol.get(6)%>','<%=arryCol.get(5)%>','<%=arryCol.get(7)%>','<%=l %>','<%=Helper.correctNull((String)arryCol.get(4))%>','0','<%=Helper.correctNull((String)arryCol.get(9))%>','')" class="blackfont">
		<b><%=Helper.replaceForJavaScriptString((String)arryCol.get(1))%></b></a>
		<%}else{ %>
		<a href="JavaScript:callLink('<%=arryCol.get(0)%>', '<%=arryCol.get(6)%>','<%=arryCol.get(5)%>','<%=arryCol.get(7)%>','<%=l %>','<%=Helper.correctNull((String)arryCol.get(4))%>','<%=Helper.correctNull((String)arryCol.get(8))%>','<%=Helper.correctNull((String)arryCol.get(9))%>','<%=Helper.correctNull((String)arryCol.get(10))%>','<%=Helper.correctNull((String)arryCol.get(11))%>')" class="blackfont">
		<b><%=Helper.replaceForJavaScriptString((String)arryCol.get(1))%></b></a>
		<%} %>
		</td>
		<td width="35%" align="center" id="idstab" style="visibility: hidden;position: absolute;">&nbsp; <b><%=Helper.replaceForJavaScriptString((String)arryCol.get(1))%></b></td>
		<td width="10%" align="center">&nbsp;<%=Helper.correctNull((String)arryCol.get(5))%>&nbsp;&nbsp;</td>
		<td width="10%" align="center">&nbsp;<%=uniqid%>&nbsp;&nbsp;</td>
		<%if(strPAN.equalsIgnoreCase("")){%>
		<td width="10%" align="center">NOPAN</td>
		<%}else{%>
		<td width="10%" align="center"><%=strPAN%></td><%}%>
		<td width="35%" align="center"><b>&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)arryCol.get(3))%></b>
		</td>
	</tr>
	<%}
					}
				}

				else {

				%>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5">&nbsp;</td></tr>
	<tr><td colspan="5" align="center">&nbsp;No Data Found</td></tr>
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
