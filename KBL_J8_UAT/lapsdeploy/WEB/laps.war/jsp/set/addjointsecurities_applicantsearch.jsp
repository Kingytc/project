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

var varapp_id="<%=Helper.correctNull((String) hshValues.get("PERAPP_OLDID"))%>";

function callLink(demoid, cbsdata, cbsid,name)
{
	var pageType='<%=strLinkFrom%>';	
	
	parent.frames.window.opener.document.all.id_jointsec.style.visibility="visible";
	parent.frames.window.opener.document.all.id_jointsec.style.position="relative";
	document.forms[0].hidAppType.value="";
	document.forms[0].hidDemoId.value=demoid;
	var table=parent.frames.window.opener.document.all.id_jointsec;
	var rowCount=table.rows.length;
	var row=table.insertRow(rowCount);
	var tempOwnerList=parent.frames.window.opener.document.forms[0].hid_SecOwnerList.value;

	if(pageType=="Deviation")
	{
		tempOwnerList=tempOwnerList+cbsid+"@";
		parent.frames.window.opener.document.forms[0].hid_SecOwnerList.value=tempOwnerList;	
		
		var tempdemoid =parent.frames.window.opener.document.forms[0].hid_demoList.value;
		
		var temp1=parent.frames.window.opener.document.forms[0].hid_demoList.value.split("@");
		for(var i=0;i<=temp1.length;i++)
		{
			if(demoid==varapp_id)
			{
				alert("Selected Applicant Details should not Allowed");
				top.close();
				return;
			}
			
			if(temp1[i]==demoid)
			{
				alert("Selected Applicant is already attached for this Application");
				top.close();
				return;
			}	
		}
			tempdemoid=tempdemoid+demoid+"@";
		parent.frames.window.opener.document.forms[0].hid_demoList.value=tempdemoid;
	}
	else{
	tempOwnerList=tempOwnerList+name+"("+cbsid+"), ";
	parent.frames.window.opener.document.forms[0].hid_SecOwnerList.value=tempOwnerList;	
	}

	var cell0=row.insertCell(0);
	cell0.className="datagrid";
	cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+demoid+');">';
	
	var cell1=row.insertCell(1);
	cell1.className="datagrid";
	cell1.innerHTML=name;

	var cell2=row.insertCell(2);
	cell2.className="datagrid";
	cell2.innerHTML=demoid;

	var cell3=row.insertCell(3);
	cell3.className="datagrid";
	cell3.innerHTML=cbsid;

	var cell4=row.insertCell(4);
	cell4.className="datagrid";
	cell4.innerHTML="";


	var cell5=row.insertCell(5);
	cell5.className="datagrid";
	var element5=parent.frames.window.opener.document.createElement("input");
	element5.type="hidden";
	element5.name="hid_jointID["+rowCount+"]";
	element5.value=demoid;
	cell5.appendChild(element5);

	top.close();	
}

function callOnload()
{
	if(vardataexists=="true")
	{
		var varapplicantid="<%=Helper.correctNull((String)hshValues.get("exapplicantid"))%>";
		var varapplicantbranch="<%=Helper.correctNull((String)hshValues.get("exbranchname"))%>";
		alert("Person with same CBS ID exists in Applicant Id : " +varapplicantid +" and in Branch : "+varapplicantbranch);	
	}
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
									.correctNull((String) arryCol.get(4));
							if (uniqid.equalsIgnoreCase("")) {
								uniqid = Helper.correctNull((String) arryCol
										.get(0));
							}

							%>
	<tr class="datagrid">

		<td width="35%" align="left">&nbsp; <a
			href="JavaScript:callLink('<%=uniqid%>', '<%=arryCol.get(6)%>','<%=arryCol.get(5)%>','<%=arryCol.get(1)%>')" class="blackfont">
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
