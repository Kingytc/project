<%@ include file="../share/directives.jsp"%>
<%
	String strprdtype = Helper.correctNull((String) request
			.getParameter("prdtype"));
%>
<html>
<head>
<title>Commercial(Facilities)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

var varfaclhead =" "
var varfacl =" ";
var appUrl   ="<%=ApplicationParams.getAppUrl()%>";
var selindex="";
var selindexdoc="";
var appdoccode=new Array();
var appdocdesc=new Array();
var intdoccode=new Array();
var intdocdesc=new Array();


function getGenDocuments()
{
	var constitution="";
	callMode();
	selindexdoc=document.forms[0].selfacilityhead[document.forms[0].selfacilityhead.selectedIndex].value;	
	selindex=document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].value;
	document.forms[0].hiddesc.value=selindex;
	//constitution=document.forms[0].constitution.value;
	constitution='';
	document.all.ifrm.src = '<%=ApplicationParams.getAppUrl()%>action/iframedocfacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getDocData&hidSourceUrl=iframedocfacilities.jsp&selfacilityhead='+selindexdoc+'&selfacility='+selindex+'&constitution='+constitution+'&general=gen';
}


 function callMode()
 {
 		var mode;
		if(document.forms[0].doc_mode[0].checked)
		mode="G";
		else
		mode="S";	
		if(mode=="G")
		{
			document.forms[0].selfacilityhead.disabled=true;
			document.forms[0].selfacility.disabled=true;
			document.forms[0].constitution.disabled=true;
			document.forms[0].selfacilityhead.value='';
			document.forms[0].selfacility.value='';
			document.forms[0].constitution.value='Select';
		 }
		 else
		 {
			document.forms[0].selfacilityhead.disabled=false;
			document.forms[0].selfacility.disabled=false;
			document.forms[0].constitution.disabled=false;
		 }	
 }

function getValue()
{	
	selindex=document.forms[0].selfacilityhead[document.forms[0].selfacilityhead.selectedIndex].value;		
	if(selindex=='')		
	{	
		
		document.forms[0].selfacility.selectedIndex=1;
		document.forms[0].selfacility.length =1;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.all.ifrm.src = '<%=ApplicationParams.getAppUrl()%>action/iframedocfacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getDocData&selfacilityhead='+' '+'&selfacility='+' '+'&hidSourceUrl=iframedocfacilities.jsp';
	}
	else
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].selfacilityhead[document.forms[0].selfacilityhead.selectedIndex].value ;
		document.forms[0].hiddesc.value=selindex;
		document.all.ifrm.src = '<%=ApplicationParams.getAppUrl()%>action/iframefacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getFacility&hidSourceUrl=iframefacilities.jsp&hiddesc='+selindex;
	}
}

function getFacValue()
{
	var constitution="";
	callMode();
	selindexdoc=document.forms[0].selfacilityhead[document.forms[0].selfacilityhead.selectedIndex].value;		
	if(!selindexdoc=='')
	{	
		selindex=document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].value;
		if(!selindex=='')			
		{
			document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].value ;
			document.forms[0].hiddesc.value=selindex;
			constitution=document.forms[0].constitution.value
			document.all.ifrm.src = '<%=ApplicationParams.getAppUrl()%>action/iframedocfacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getDocData&hidSourceUrl=iframedocfacilities.jsp&selfacilityhead='+selindexdoc+'&selfacility='+selindex+'&constitution='+constitution;
		}
		else
		{
			document.all.ifrm.src = '<%=ApplicationParams.getAppUrl()%>action/iframedocfacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getDocData&selfacilityhead='+' '+'&selfacility='+' '+'&constitution='+' '+'&hidSourceUrl=iframedocfacilities.jsp';
		}
	}
	else
	{
			document.all.ifrm.src =	'<%=ApplicationParams.getAppUrl()%>action/iframedocfacilities.jsp?hidBeanId=facilitiesdoc&hidBeanGetMethod=getDocData&hidSourceUrl=iframedocfacilities.jsp&selfacilityhead='+selindexdoc+'&selfacility='+selindex+'&constitution='+constitution+'&general=no';
	}

}

function onloading()
{   
	document.forms[0].cmdedit.disabled=false;	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].selfacilityhead.disabled=true;
	document.forms[0].selfacility.disabled=true;
	document.forms[0].constitution.disabled=true;

}

function callDocList(doctype)
{
	selindexdoc=document.forms[0].selfacilityhead[document.forms[0].selfacilityhead.selectedIndex].value;
	selfacility=document.forms[0].selfacility[document.forms[0].selfacility.selectedIndex].value;
	constitution=document.forms[0].constitution.value;
	
	var mode;
	if(document.forms[0].doc_mode[0].checked)
		mode="G";
	else if(document.forms[0].doc_mode[1].checked)
		mode="S";	

	if(mode=="G")
	 {
	 }
	 else if(mode=="S")
	 {		
		if(selindexdoc=='')
		{
			ShowAlert('111','Facility Head');
			document.forms[0].selfacilityhead.focus();
			return;
		}
		else if(selfacility=='')
		{
			ShowAlert('111','Facility ');
			document.forms[0].selfacility.focus();
			return;
		}
		else if(constitution=='Select')
		{
			ShowAlert('111','constitution');
			document.forms[0].constitution.focus();
			return;
		}

	}
	else
	{
		alert("Choose General (or) Facility Based");
		return;
	}
	var prop = "scrollbars=no,width=700,height=400,top=100,left=80";
	var url="<%=ApplicationParams.getAppUrl()%>action/facdoclist.jsp?doc_type="+ doctype;
		window.open(url, "", prop);
	}

	function doEdit() {
		document.forms[0].appdoclist.disabled = false;
		document.forms[0].intdoclist.disabled = false;
		document.forms[0].cmdedit.disabled = true;
		document.forms[0].cmdsave.disabled = false;
		document.forms[0].cmdcancel.disabled = false;
		document.forms[0].cmdclose.disabled = true;
	}

	function doSave() {
		disableFields(false);
		assignData();
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].action = appUrl + "controllerservlet";
		document.forms[0].hidBeanId.value = "facilitiesdoc";
		document.forms[0].hidBeanMethod.value = "updateDocData";
		document.forms[0].hidBeanGetMethod.value = "getDocData";
		document.forms[0].hidSourceUrl.value = "/action/facilitiesdoc.jsp";
		document.forms[0].submit();
	}

	function disableFields(val) {
		for ( var k = 0; k < document.forms[0].idoc_desc.length; k++) {
			document.forms[0].idoc_desc[k].disabled = val;

		}
		for ( var k1 = 0; k1 < document.forms[0].adoc_desc.length; k1++) {
			document.forms[0].adoc_desc[k1].disabled = val;

		}
	}

	function doCancel() {
		if (ConfirmMsg(102)) {
			document.forms[0].action = appUrl + "action/facilitiesdoc.jsp";
			document.forms[0].submit();
		}
	}

	function doClose() {
		if (ConfirmMsg('100')) {
			
				document.forms[0].action = appUrl + "action/setupnav.jsp";
				document.forms[0].submit();
		}
	}

	function allowDelete(obj) {
		var key = window.event.keyCode;
		if (!(key == 46 || key == 8)) {
			window.event.returnValue = false;
		} else if (document.forms[0].cmdedit.disabled) {
			obj.value = "";
			window.event.returnValue = false;
		} else {
			window.event.returnValue = false;
		}

	}

	function assignData() {

		document.forms[0].hid_selfacilityhead.value = document.forms[0].selfacilityhead.options[document.forms[0].selfacilityhead.selectedIndex].text;
		document.forms[0].hid_constitution.value = document.forms[0].constitution.options[document.forms[0].constitution.selectedIndex].text;
		document.forms[0].hid_selfacility.value = document.forms[0].selfacility.options[document.forms[0].selfacility.selectedIndex].text;

}
</script>

</head>


<body onLoad="onloading()">
<form name="documentsfrm" method="post" class="normal"><iframe
	id="ifrm" height="1" width="1" name="iframe1" style="scrollbar: no"></iframe>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0" align="center">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; 
		<%if (strprdtype.equals("C")) {%>
		Corporate <%
 	} else {
 %>Tertiary <%
 	}
 %> Products -&gt; Documents</td>
	</tr>
	<tr>
		<td align="right">&nbsp;</td>
	</tr>
</table>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="3" height="400"  align="center">
	<tr>
		<td valign="top">
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="0" height="100%" align="center">
			<tr>
				<td height="7">
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="3" height="100%" >
					<tr>
						<td colspan="4" height="239" valign="top">
						<table class="outertable border1" width="100%" border="0" cellspacing="0"
							cellpadding="3" height="100%">
							<tr>
								<td colspan="10" valign="top">
								<table class="outertable" width="100%" border="0"
									cellspacing="0" cellpadding="0">
									<tr valign="top">
										<td colspan="4">
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="5">
											<tr>
												<td width="20%">&nbsp;</td>
												<td width="24%"><input type="radio" name="doc_mode" value="G" style="border:none" onClick="getGenDocuments()"> General
												Documents</td>
												<td width="25%"><input type="radio" name="doc_mode" value="S" style="border:none" onClick="getFacValue()"> Facility Based
												Documents</td>
												<td width="41%">&nbsp;</td>
											</tr>
											<tr>
												<td width="20%">Facility Head</td>
												<td width="24%"><select name="selfacilityhead"
													onChange="getValue()">
													<lapschoice:facilitiesdoc />
												</select> <input type="hidden" name="hid_selfacilityhead"></td>
												<td width="15%">Constitution</td>
												<td width="41%"><select name="constitution"
													onChange="getFacValue()">
													<option Selected value="Select">---Select---</option>
													<option value="OO">Others</option>
													<option value="OLP">Private Limited Company</option>
													<option value="OLC">Joint Borrowers</option>
													<option value="OS">Sole Proprietor</option>
													<option value="OCC">Public Limited Company</option>
													<option value="OP">Partnership</option>
													<option value="IN">Individual</option>
												</select> <input type="hidden" name="hid_constitution"></td>
											</tr>
											<tr>
												<td width="20%">Facility</td>
												<td width="24%"><select name="selfacility"
													onChange="getFacValue()">
													<option value='' selected>-Select-</option>
												</select> <input type="hidden" name="hid_selfacility"></td>
												<td width="15%">&nbsp;</td>
												<td width="41%">&nbsp;</td>
											</tr>
										</table>
										</td>
									<tr valign="top">
										<td colspan="4">&nbsp;</td>
									<tr>
										<td width="35%" height="20"><span class="mantatory">Click on 'Existing' button to
										select documents</span></td>
										<td colspan="3" height="20">&nbsp;</td>
									</tr>
									<tr>
										<td width="35%" height="29">
										<div align="right">&nbsp;Document Category - Applicant</div>
										</td>
										<td width="15%" height="29">
										<div align="center"><input type=button  name=appdoclist
											onClick="callDocList('a')" value="Existing"
											class="buttonstyle"
											disabled></div>
										</td>
										<td width="32%" height="29">
										<div align="right">Document Category - &nbsp;Internal</div>
										</td>
										<td width="18%" height="29">
										<div align="center"><input type=button name="intdoclist"
										onClick="callDocList('i')" value="Existing" class="buttonstyle"
											disabled></div>
										</td>
									</tr>
									<tr>
										<td colspan="4" height="20">
										<table class="outertable" width="100%" border="0"
											cellspacing="0" cellpadding="0" align="center" >
											<tr>
												<td colspan="2" height="2" valign="top">
												<div class="cellContainer">
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="0">
													<tr>
														<td height="10" valign="top">
														<table class="outertable" width="100%" border="0"
															cellspacing="0" cellpadding="0" align="center">
															<%
																for (int i = 1; i <= 20; i++) {
															%>
															<tr class="datagrid">
																<td width="12%" height="0">
																<div align="center"><%=i%></div>
																</td>
																<td width="88%" valign="top" height="0">
																<div align="left"><input type="text" name="adoc_desc" tabindex="0"
																	onKeyDown="allowDelete(this)" readOnly size="60">
																<input type="HIDDEN" name="adoc_code"></div>
																</td>
															</tr>
															<%
																}
															%>
														</table>
														</td>
													</tr>
												</table>
												</div>
												</td>
												<td colspan="2" height="2" valign="top" width="51%">
												<div class="cellContainer">
												<table class="outertable" width="100%" border="0"
													cellspacing="0" cellpadding="0">
													<tr>
														<td height="87" valign="top">
														<table class="outertable" width="100%" border="0"
															cellspacing="0" cellpadding="0" align="center">
											 <% for(int j=1;j<=20;j++) {%>
                                                <tr class="datagrid"> 
                                                  <td width="12%" height="0"> 
                                                    <div align="center"><font face="MS Sans Serif" size="1"><%=j%></font></div>
                                                  </td>
                                                  <td width="88%" valign="top" height="0"> 
                                                    <div align="left"><input type="text"
																	name="idoc_desc" onKeyDown="allowDelete(this)" readOnly
																	size="60"> <input type="HIDDEN"
																	name="idoc_code"></div>
																</td>
															</tr>
															<%
																}
															%>
														</table>
														</td>
													</tr>
												</table>
												</div>
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
		</td>
	</tr>
</table>
<br>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hiddesc"> 
<input type="hidden" name="hidId" value="<%=request.getParameter("hidId")%>"> 
<input type="hidden" name="general" value="gen"> 
<input type="hidden" name="prdtype" value="<%=strprdtype%>">
</form>
</body>
</html>
