<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% 
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strAssessmentType= Helper.correctNull((String)hshValues.get("assessmenttype"));

%>
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
//out.println("hshValues==="+hshValues);
	String cattype = (String) request.getParameter("cattype");
	String ssitype = (String) request.getParameter("ssitype");
	String strSessionModule="";
	strSessionModule=Helper.correctNull((String)request.getParameter("sessionModuleType"));
	if(strSessionModule.equalsIgnoreCase("")){
		strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
	}
	
	String strDesc[] = { "Turn Over", "Expenditure",
			"Cash Flow Statement", "Method 1 of lending other than export limits", "Method 2 of lending other than export limits",
			"Working Capital gap method for export limits","Other Assessment for WCDPN/WCTL","Term loan assessment",
			"DSCR","Cash Budget Method","Other Assessment for TL","Assessment of Inland / Import LC","Other than LC/BG",
			"BG Assessment","Assessment Comments","Agriculture Assessment"};
	String strValue[]= { "TO", "Exp", "CFS", "MED1" ,"MED2","WCGMED","AOW","EXPORTCF","DSCR","CASHBUD","AOA","AOI","NFA","BGA","ACOM","FB"};


	
	    String strAssessment = Helper.correctNull((String) hshValues.get("COM_ASSESSMENTTYPE"));
		String StrSchemeType=Helper.correctNull((String)hshValues.get("strschemeType"));
		String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
		session.setAttribute("COM_ASSESSMENTTYPE",strAssessment);
		String strAppType=Helper.correctNull((String)hshValues.get("app_renew_flag"));
		String strexpenditure = Helper.correctNull((String) hshValues.get("COM_EXPENDITURE"));
		String strturnover = Helper.correctNull((String) hshValues.get("COM_TURNOVER"));
		String strrestgeclmandatorychk=Helper.correctNull((String)  session.getAttribute("restgeclmandatorychk"));
		String strLoanType=Helper.correctNull((String) hshValues.get("StrLoanType"));
		//out.println(hshValues);
%>
<html>
<head>
<title>Proposal</title>
	<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varAssesment="<%=strAssessment%>";
var varAssesmentArray = varAssesment.split('@');
var len = varAssesmentArray.length;
var appstatus="<%=Helper.correctNull((String) request
	.getParameter("appstatus"))%>";
var varturnover="<%=strturnover%>";	
var varexpenditure="<%=strexpenditure%>";
var varGECL="<%=Helper.correctNull((String)hshValues.get("strgeclavailable"))%>";
var varMMithra="<%=Helper.correctNull((String)hshValues.get("strMMithra"))%>";
var varDPN2020="<%=Helper.correctNull((String)hshValues.get("strDPN2020"))%>";
var varCGSSD="<%=Helper.correctNull((String)hshValues.get("strCgssd"))%>";
var varrestassessment="<%=Helper.correctNull((String)hshValues.get("strrestasseselection"))%>";
var varrestassesmandatory="<%=strrestgeclmandatorychk%>";
var varappstatus="<%=strAppType%>";
var varpmSvanidhi3="<%=Helper.correctNull((String)hshValues.get("pmSvanidhi3"))%>";
var varstrenwravailable="<%=Helper.correctNull((String)hshValues.get("strenwravailable"))%>"; 
function doSave() {
	var flag = false;
	for ( var i = 0; i < document.forms[0].chk_assessment.length; i++) 
	{
		if (document.forms[0].chk_assessment[i].checked == true) 
		{
			flag = true;
			document.forms[0].txt_chkvalue[i].value="Y";
		}
		else
		{
			if(document.forms[0].txt_chkvalue[i].value=="Y")
			{
				document.forms[0].txt_chkvalue[i].value="N";
			}
		}
	}
	if (!flag) {
		alert("Select Assessment Method");
		return;
	} else {
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].hidBeanId.value = "executive";
		document.forms[0].hidBeanMethod.value = "updateAssessmentSelection";
		document.forms[0].hidBeanGetMethod.value = "getAssessmentSelection";
		document.forms[0].action = appUrl + "controllerservlet";
		document.forms[0].hidSourceUrl.value = "/action/com_assessmentselection.jsp";
		document.forms[0].method = "post";
		document.forms[0].submit();
	}
}
function doEdit() {
	
	document.forms[0].hidAction.value = "Edit";
	disabledFields(false);
	enableButtons(true,false,false,true,true);
	if(varAssesment=="")
	{
		document.forms[0].chk_assessment[14].checked = true;
		document.forms[0].txt_chkvalue[14].value="Y";
	}
	
if(varappstatus=="S"){
		if(varrestassesmandatory=="Y")
		{
				
			varcnt=document.forms[0].chk_assessment.length-3;
			document.forms[0].chk_assessment[varcnt].checked = true;
			document.forms[0].txt_chkvalue[varcnt].value="Y";
		}
	}else{
		if(varGECL=="Y")
		{
			//alert(document.forms[0].chk_assessment.length);
			//varcnt=document.forms[0].chk_assessment.length-3;
			varcnt=document.forms[0].chk_assessment.length-4;
			document.forms[0].chk_assessment[varcnt].checked = true;
			document.forms[0].txt_chkvalue[varcnt].value="Y";
		}
	}
		
		if(varGECL=="Y")
		{
			//var varcnt=document.forms[0].chk_assessment.length-6;
			var varcnt=document.forms[0].chk_assessment.length-7;
			document.forms[0].chk_assessment[varcnt].checked = true;
			document.forms[0].txt_chkvalue[varcnt].value="Y";

			
		}
	if(varMMithra=="Y")
	{
		/*var varcnt=document.forms[0].chk_assessment.length-4;
		document.forms[0].chk_assessment[varcnt].checked = true;
		document.forms[0].txt_chkvalue[varcnt].value="Y";*/
	}
		if(varDPN2020=="Y")
	{
		var varcnt=document.forms[0].chk_assessment.length-5;
		document.forms[0].chk_assessment[varcnt].checked = true;
		document.forms[0].txt_chkvalue[varcnt].value="Y";
	}
	
	if(varCGSSD=="Y")
	{
		var varcnt=document.forms[0].chk_assessment.length-2;
		document.forms[0].chk_assessment[varcnt].checked = true;
		document.forms[0].txt_chkvalue[varcnt].value="Y";
	}

	if(varrestassessment=="Y")
	{
		var varcnt=document.forms[0].chk_assessment.length-1;
		document.forms[0].chk_assessment[varcnt].checked = true;
		document.forms[0].txt_chkvalue[varcnt].value="Y";
	}
	//else{
	//	var varcnt=document.forms[0].chk_assessment.length-1;
	//	document.forms[0].chk_assessment[varcnt].checked = false;
	//}
	
}

function doCancel() {
	if (ConfirmMsg(102)) {
		document.forms[0].action = appUrl + "controllerservlet";
		document.forms[0].hidBeanGetMethod.value = "getAssessmentSelection";
		document.forms[0].hidBeanId.value = "executive";
		document.forms[0].action = appUrl
				+ "action/com_assessmentselection.jsp";
		document.forms[0].submit();
	}
}

function doDelete() {
	if (ConfirmMsg(101)) {
		document.forms[0].hidAction.value = "delete";
		document.forms[0].action = appUrl + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "executive";
		document.forms[0].hidSourceUrl.value = "action/com_assessmentselection.jsp";
		document.forms[0].hidBeanMethod.value = "updateAssessmentSelection";
		document.forms[0].hidBeanGetMethod.value = "getAssessmentSelection";
		document.forms[0].submit();
	}

}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	//document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function disabledFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;		  
		}
		
	}
}
function placeValues() 
{

	if (len > 0) {

		
		
		for ( var j = 0; j < len; j++) {
			
			for ( var i = 0; i < document.forms[0].chk_assessment.length; i++) {
				document.forms[0].txt_chkvalue[0].checked=true;
				document.forms[0].txt_chkvalue[1].checked=true;	

				
				if (document.forms[0].chk_assessment[i].value == varAssesmentArray[j]) {
					
					document.forms[0].chk_assessment[i].checked = true;
					document.forms[0].txt_chkvalue[i].value="Y";
					
					}
			}
		}
	}
	disabledFields(true);


	
	/*if (document.forms[0].appstatus.value == "Open/Pending") {
		if(document.forms[0].btnenable.value=="Y")
		{	
			enableButtons(false,true,true,true,false);
		}

			
				
		else
		{
			enableButtons(true,true,true,true,false);
		}
	} else {
		enableButtons(true,true,true,false,false);
	}*/

	<%if(strSessionModuleType.equals("CORP"))
	{%>
		document.all.idcgssd.style.display="table-row";
	<%}
	else
	{%>
		document.all.idcgssd.style.display="none";
	<%}%>
}
function callcomments()
{
	
		var appno="<%=(String) request.getParameter("appno")%>";
		var pagetype = "wccomm";
		var purl ="<%=ApplicationParams.getAppUrl()%>action/com_commentpage.jsp?hidBeanGetMethod=getDataComments&hidBeanId=comassestsliab&pagetype="+pagetype+"&appno="+appno+"&appstatus="+appstatus;				
		var prop = 'scrollbars=yes,menubar=no,width=650,height=355';	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 450) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);	
}
function chkGECL(obj)
{
	if(varGECL=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for KBL GECL Scheme Required");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required for KBL GECL Scheme");
			obj.checked=false;
			return;
		}
	}
}
function chkKrishikBhandar(obj)
{
	//alert(varstrenwravailable)
	if(varstrenwravailable=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for KBL e- Krishik Bhandar Scheme Required");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required only for KBL e- Krishik Bhandar Scheme");
			obj.checked=false;
			return;
		}
	}
}
function chkFIDPN(obj)
{
	if(varDPN2020=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for Interest Deferment DPN 2020 Required");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required only for Interest Deferment DPN 2020");
			obj.checked=false;
			return;
		}
	}
}
function chkMMithra(obj)
{
	//alert("aaa...."+obj);
	if(varMMithra=="Y")
	{
		/*if(obj.checked==false)
		{
			alert("Assessment for Micro Mithra Required");
			obj.checked=true;
			return;
		}*/
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required only for KBL Micro Mithra");
			obj.checked=false;
			return;
		}
	}
}

function chkCgssd(obj)
{
	if(varCGSSD=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for KBL CGSSD Required");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required only for KBL CGSSD");
			obj.checked=false;
			return;
		}
	}
}

function selchecbox(obj){
	if(obj.checked==false)
	{
		if(window.confirm("If Assessment untick is done related comments and assessment will get deleted. Do you want to proceed?"))
		{
			obj.checked=false;
			return;
		}else{
			obj.checked=true;
			return;
		}
	}
	if(varCGSSD=="Y")
	{
		if(obj.value!="ACOM"){
		if(obj.checked==true)
		{
			alert("For CGSSD facilities only CGSSD Assessment should be taken");
			obj.checked=false;
			return;
		}
	}
	}
}


function chkrestscheme(obj)
{
	if(varrestassessment=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for Eligibility under resolution framework Required");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required only restructure scheme under 27,28,29");
			obj.checked=false;
			return;
		}
	}
}

function chkSvanidhiScheme3(obj)
{
	if(varpmSvanidhi3=="Y")
	{
		if(obj.checked==false)
		{
			alert("Assessment for PM Svanidhi 3 is Required,You cannot untick the assessment");
			obj.checked=true;
			return;
		}
	}
	else
	{
		if(obj.checked==true)
		{
			alert("Assessment Required  only for PM Svanidhi 3");
			obj.checked=false;
			return;
		}
	}
}

</script>
</head>
<body onload="placeValues()">
  <div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="frmpri" method="post" class="">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt;Agriculture -&gt;Proposal -&gt; Assessment -&gt; Assessment Type		
		</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt;Proposal -&gt; Assessment -&gt; Assessment Type		
		</td>
		<%} %>
</tr>		
</table>
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="8" />
</jsp:include>

<table width="50%" border="0" cellspacing="0" cellpadding="0"
	align="center">

	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable border1"></table><tr>
			<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" class="outertable border1">
			<tr class="dataheader">
				<td colspan="2">Assessment Method</td>
			</tr>
			<%
			int intlength=0;
			if(strSessionModule.equalsIgnoreCase("corp"))
			{
				intlength=(strDesc.length)-1;
			}
			else
			{
				intlength=strDesc.length;
			}
				for (int i = 0; i < intlength; i++) {
			%>
			<tr class="datagrid">
				<td><%=strDesc[i]%></td>
				<td><input type="checkbox" name="chk_assessment"
					value="<%=strValue[i]%>" style="border-style: none" onclick="selchecbox(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>		
			</tr>
			<%}
				if(strSessionModule.equalsIgnoreCase("corp"))
				{%>
				<tr style="visibility: hidden;position: absolute;">
				<td colspan="2">
					<input type="checkbox" name="chk_assessment"
					value="FB" onclick="selchecbox(this);">
				<input type="hidden" name="txt_chkvalue" value="" >
				</td>
				</tr>
				<%}
			if(strAppType.equalsIgnoreCase("S")){%>
			<tr class="datagrid">
				<td>Assessment for Restructuring</td>
				<td><input type="checkbox" name="chk_assessment"
					value="AOR" style="border-style: none" onclick="selchecbox(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%}else{%>
			<tr  style="visibility: hidden;position: absolute;">
				<td colspan="2">
			<input type="checkbox" name="chk_assessment"
					value="AOR"  onclick="selchecbox(this);">
				<input type="hidden" name="txt_chkvalue" value="" >
				</td>
				</tr>
			<%}%>
			<tr class="datagrid">
				<td>Assessment for Adhoc Facilities</td>
				<td><input type="checkbox" name="chk_assessment"
					value="AAF" style="border-style: none" onclick="selchecbox(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<% if(strAppType.equalsIgnoreCase("S")){%>
			<tr class="datagrid">
				<td>Eligiblity for KBL GECL Scheme</td>
				<td><input type="checkbox" name="chk_assessment"
					value="KSAE-Restructure" style="border-style: none" onclick="chkGECL(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%}else{ %>
			<tr class="datagrid">
				<td>Eligiblity for KBL GECL Scheme</td>
				<td><input type="checkbox" name="chk_assessment"
					value="KSAE" style="border-style: none" onclick="chkGECL(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%} %>
			<tr class="datagrid">
				<td>Assessment of fund based FIDPN limits</td>
				<td><input type="checkbox" name="chk_assessment"
					value="FIDPN" style="border-style: none" onclick="chkFIDPN(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<tr class="datagrid">
				<td>Assessment for KBL MICRO MITRA Assessment upto Rs.2 Lakhs</td>
				<td><input type="checkbox" name="chk_assessment"
					value="MMithra" style="border-style: none" onclick="chkMMithra(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
				<% if(strAppType.equalsIgnoreCase("S")){%>
			<tr class="datagrid">
				<td>Assessment for KBL GECL Scheme</td>
				<td><input type="checkbox" name="chk_assessment"
					value="GECL-Restructure" style="border-style: none" onclick="chkGECL(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%}else{ %>
			<tr class="datagrid">
				<td>Assessment for KBL GECL Scheme</td>
				<td><input type="checkbox" name="chk_assessment"
					value="AMithra" style="border-style: none" onclick="chkGECL(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%} %>
			<tr class="datagrid" id="idcgssd">
				<td>Assesment for KBL CGSSD</td>
				<td><input type="checkbox" name="chk_assessment"
					value="CGSSD" style="border-style: none" onclick="chkCgssd(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<tr class="datagrid" id="idrestruc">
				<td>Eligibility under resolution framework</td>
				<td><input type="checkbox" name="chk_assessment"
					value="Restructure" style="border-style: none" onclick="chkrestscheme(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			
			<tr class="datagrid">
				<td>Assessment for PM Svanidhi 3.0</td>
				<td><input type="checkbox" name="chk_assessment"
					value="PMS3" style="border-style: none" onclick="chkSvanidhiScheme3(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<% if(strSessionModuleType.equals("AGR")){%>
			<tr class="datagrid">
				<td>Assessment for e- Krishik Bhandar</td>
				<td><input type="checkbox" name="chk_assessment"
					value="ENWR" style="border-style: none" onclick="chkKrishikBhandar(this);">
				<input type="hidden" name="txt_chkvalue" value=""></td>
			</tr>
			<%}%>
		</table>
		
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail"
	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidBeanMethod"
	value=""> <input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl"> <input type="hidden"
	name="hidassesttype"> <input type="hidden" name="strappno"
	value="<%=Helper.correctNull(request.getParameter("appno"))%>">
<input type="hidden" name="hidvarid">
<input TYPE="hidden" name="pageval" value = "">
<input type="hidden" name="pagefrom"> 
<INPUT TYPE="hidden" name="strAssessment" value = "<%=strAssessment%>">
<INPUT TYPE="hidden" name="strschemeType" value = "<%=StrSchemeType%>">


</form>
</body>
</html>	
