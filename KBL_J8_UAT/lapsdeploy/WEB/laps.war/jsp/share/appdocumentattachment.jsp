
<%@include file="../share/directives.jsp"%>
<% 
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
ArrayList arrAppRow=new ArrayList();
ArrayList arrBankRow=new ArrayList();
ArrayList arrCol=new ArrayList();
arrAppRow=(ArrayList)hshValues.get("arrAppRow");
arrBankRow=(ArrayList)hshValues.get("arrBankRow");
String app_status=Helper.correctNull((String)request.getParameter("appstatus"));
String docAttCount=Helper.correctNull((String)hshValues.get("docAttCount"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
if(strCategory.equals(""))
{
	strCategory=strSessionModuleType;
}
String StrDigiLoanType=Helper.correctNull((String)session.getAttribute("StrDigiLoanType")).trim();


String StrIBMURL = ApplicationParams.getStrlogintoibm();
String StrIBMPass = ApplicationParams.getStrlogintoibmPass();
String StrIBMCon = StrIBMURL + "&" + StrIBMPass;
String StrGenIBMURL = ApplicationParams.getStrgenDocupdurl();
String encubmurl=StrIBMURL +Helper.correctNull((String)hshValues.get("encubmurlun"))+ "&password=" +Helper.correctNull((String)hshValues.get("encubmurl"));


String StrIBMURLDIGI = ApplicationParams.getStrlogintoibmdigi();
String StrIBMPassDIGI = ApplicationParams.getStrlogintoibmPassdigi();
String StrIBMConDIGI = StrIBMURLDIGI + "&" + StrIBMPassDIGI;
String StrGenIBMURLDIGI = ApplicationParams.getStrgenDocupdurldigi();
String encubmurlDIGI=StrIBMURLDIGI +Helper.correctNull((String)hshValues.get("encubmurlundigi"))+ "&password=" +Helper.correctNull((String)hshValues.get("encubmurldigi"));

//String StrGenIBMURLDIGI = ApplicationParams.getStrgenDocupdurldigi();




%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
<title>Insert title here</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 200;
  overflow: auto;
}
.dhtmlgoodies_question{	/* Styling question */
	/* Start layout CSS */
	font-size:11px;;
	font-family:Trebuchet MS;
	background-color:#FFFFFF;
	/*width:1000px;*/
	margin-bottom:2px;
	/*background-image: url(laps/img/line.gif);*/
	margin-top:2px;
	padding-left:2px;
	
	background-repeat:repeat;
	
	height:25px;

	/* End layout CSS */

	overflow:hidden;
	cursor:pointer;
}
.dhtmlgoodies_answer{	/* Parent box of slide down content */
	/* Start layout CSS */
	border:1px solid ;
	background-color:#FFFFFF;
	/*background-image: url(laps/img/tab_back.png);*/
	/*width:1000px;*/
	/*background-repeat:repeat;*/
	font-family:Trebuchet MS;
	/* End layout CSS */
	visibility:hidden;
	height:100px;
	overflow:hidden;
	position:relative;

}
.dhtmlgoodies_answer_content{	/* Content that is slided down */
	padding:1px;
	font-size:0.9em;
	font-family:Trebuchet MS;
	position:relative;
}
.searchOuter{background:url('../img/srchOuter_1.png') 0 0 repeat-x;height:30px;}
.searchOuter:hover{background:url('../img/srchOuter_2.png');}
.searchOuter_active{background:url('../img/srchOuter_3.png') 0 0 repeat-x;height:46px;}
.searchOuter1{background:#ece1ea;height:30px;}
</STYLE>
<script>
var docAttCount="<%= docAttCount%>";
var app_status="<%=app_status%>";
var varOrgLevel="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var strCategory="<%= strCategory%>";
var strSessionModuleType="<%= strSessionModuleType%>";
var StrDigiLoanType="<%= StrDigiLoanType%>";

function callApplicant()
{
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsappl.jsp?hidBeanGetMethod=getData";
	document.forms[0].hidAppDoc.value="A";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callInternal()
{
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocumentsinter.jsp?hidBeanGetMethod=getData";
	document.forms[0].hidAppDoc.value="I";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callpostsancDocAttachment()
{
	if(strSessionModuleType=="DIGI" || StrDigiLoanType=="PC")
	{
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].hidBeanId.value="DigitalAppInterface";
		document.forms[0].hidBeanMethod.value="getDocumentURLs";
		document.forms[0].hidBeanGetMethod.value="getDocumentDetailsdigi";
		document.forms[0].hidSourceUrl.value="/action/apppostsancDocattachment.jsp?docpagetype=post";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();					
	}
	else
	{
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/apppostsancDocattachment.jsp?hidBeanGetMethod=getDocumentDetails&docpagetype=post";
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function callRBIGuidelines()
{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_rbi_guidelines_restr.jsp?hidBeanGetMethod=getRBIGuidelines_restr&strPageType=G";
	document.forms[0].method="post";
	document.forms[0].submit();
}
var dhtmlgoodies_slideSpeed = 10;	// Higher value = faster
var dhtmlgoodies_timer = 10;	// Lower value = faster

var objectIdToSlideDown = false;
var dhtmlgoodies_activeId = false;
var dhtmlgoodies_slideInProgress = false;
var dhtmlgoodies_slideInProgress = false;
var dhtmlgoodies_expandMultiple = false; // true if you want to be able to have multiple items expanded at the same time.

function showHideContent(e,inputId)
{
	if(dhtmlgoodies_slideInProgress)return;
	dhtmlgoodies_slideInProgress = true;
	if(!inputId)inputId = this.id;
	inputId = inputId + '';
	var numericId = inputId.replace(/[^0-9]/g,'');
	var answerDiv = document.getElementById('dhtmlgoodies_a' + numericId);

	objectIdToSlideDown = false;

	if(!answerDiv.style.display || answerDiv.style.display=='none'){
		if(dhtmlgoodies_activeId &&  dhtmlgoodies_activeId!=numericId && !dhtmlgoodies_expandMultiple){
			objectIdToSlideDown = numericId;
			slideContent(dhtmlgoodies_activeId,(dhtmlgoodies_slideSpeed*-1));
		}else{

			answerDiv.style.display='block';
			answerDiv.style.visibility = 'visible';

			slideContent(numericId,dhtmlgoodies_slideSpeed);
		}
	}else{
		slideContent(numericId,(dhtmlgoodies_slideSpeed*-1));
		dhtmlgoodies_activeId = false;
	}
	if(numericId=="1")
	{
		document.forms[0].hidAppDoc.value="A";
		document.forms[0].hidDocCode.value="";
	}
	else
	{
		document.forms[0].hidAppDoc.value="I";
		document.forms[0].hidDocCode.value="";
	}
	document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp";
}

function slideContent(inputId,direction)
{

	var obj =document.getElementById('dhtmlgoodies_a' + inputId);
	var contentObj = document.getElementById('dhtmlgoodies_ac' + inputId);
	height = obj.clientHeight;
	if(height==0)height = obj.offsetHeight;
	height = height + direction;
	rerunFunction = true;
	if(height>contentObj.offsetHeight){
		height = contentObj.offsetHeight;
		rerunFunction = false;
	}
	if(height<=1){
		height = 1;
		rerunFunction = false;
	}

	obj.style.height = height + 'px';
	var topPos = height - contentObj.offsetHeight;
	if(topPos>0)topPos=0;
	contentObj.style.top = topPos + 'px';
	if(rerunFunction){
		setTimeout('slideContent(' + inputId + ',' + direction + ')',dhtmlgoodies_timer);
	}else{
		if(height<=1){
			obj.style.display='none';
			if(objectIdToSlideDown && objectIdToSlideDown!=inputId){
				document.getElementById('dhtmlgoodies_a' + objectIdToSlideDown).style.display='block';
				document.getElementById('dhtmlgoodies_a' + objectIdToSlideDown).style.visibility='visible';
				slideContent(objectIdToSlideDown,dhtmlgoodies_slideSpeed);
			}else{
				dhtmlgoodies_slideInProgress = false;
			}
		}else{
			dhtmlgoodies_activeId = inputId;
			dhtmlgoodies_slideInProgress = false;
		}
	}
}
function initShowHideDivs()
{
	 
		var divs = document.getElementsByTagName('DIV');
		var divCounter = 1;
		for(var no=0;no<divs.length;no++){
			if(divs[no].className=='dhtmlgoodies_question'){
				divs[no].onclick = showHideContent;
				divs[no].id = 'dhtmlgoodies_q'+divCounter;
				var answer = divs[no].nextSibling;
				while(answer && answer.tagName!='DIV'){
					answer = answer.nextSibling;
				}
				answer.id = 'dhtmlgoodies_a'+divCounter;
				contentDiv = answer.getElementsByTagName('DIV')[0];
				contentDiv.style.top = 0 - contentDiv.offsetHeight + 'px';
				contentDiv.className='dhtmlgoodies_answer_content';
				contentDiv.id = 'dhtmlgoodies_ac' + divCounter;
				answer.style.display='none';
				answer.style.height='1px';
				divCounter++;
			}
		}
	
}
function callOnLoad()
{
	if(document.forms[0].hidAppDoc.value=="")
	showHideContent(0,1);
}
function showSelected(obj,val){
		$(obj).siblings().removeClass('searchOuter1');
		$(obj).siblings().addClass('searchOuter');
		$(obj).addClass('searchOuter1');
		$(obj).removeClass('searchOuter');
		document.forms[0].hidDocCode.value = val;
}
function callListUpload()
{
	var title = "IBMViewer";
	var prop = "titlebar=no,toolbar=no,scrollbars=no,width=50,height=20";	
	//titlebar=no,toolbar=no,location=no,status=no,menubar=no,resizable=no
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	if(strCategory=="DIGI" || StrDigiLoanType=="PC")
	{
	var purl = "<%=encubmurlDIGI%>";
	}else{
	var purl = "<%=encubmurl%>";
	}
	// Timmer set for 1sec
	var prop = "scrollbars=no,width=350,height=250"; 
	var win = window.open(purl,title,prop);
	setTimeout(function(){win.close(purl,title,prop);},1200000);
	// Timmer ends
	
	if(strCategory=="DIGI" || StrDigiLoanType=="PC")
	{
		document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/iframeDocGatway.jsp?hidBeanGetMethod=readTableFromServer&hidBeanId=DigitalAppInterface&DocType="+document.forms[0].hidAppDoc.value+
		"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].appno.value+"&strCBSID="+document.forms[0].hidCBSID.value;
	}
	else
	{
		document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/iframeDocGatway.jsp?hidBeanGetMethod=getUploadedDocDetails&hidBeanId=commdocument&DocType="+document.forms[0].hidAppDoc.value+
		"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].appno.value+"&strCBSID="+document.forms[0].hidCBSID.value;
	}
	
}
function doClose()
{
	document.forms[0].action=appUrl+"action/persearch.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function viewDocAttach(val){
	var title = "AttachmentViewer";
	var prop = "scrollbars=no,width=850,height=620";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;		
	var purl = "<%=ApplicationParams.getAppUrl()%>action/iframeDocView.jsp?hidBeanId=commdocument&hidBeanGetMethod=viewDocumentData&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].appno.value+"&snoNo="+val+"&strCBSID="+document.forms[0].hidCBSID.value;
	window.open(purl,title,prop);
}
function callUploadFile()
{
	if(varGrpRights=='r')
	{
		alert("You cannot Attach the Document");
		return;
	}
	if(docAttCount=="0" || app_status!="Open/Pending")
	{	
		alert("You cannot Attach the Document");
		return;
	}
	
	if(document.forms[0].hidAppDoc.value == ""){
		alert('Document type Required.');
		return;
	}
	else if(document.forms[0].hidDocCode.value == ""){
		alert('Document Required.');
		return;
	}
	else{	
		var prop = 'scrollbars=no,width=550,height=200,menubar=no';	
		var url = "<%=ApplicationParams.getAppUrl()%>action/perDocumentAttach.jsp?&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].appno.value+"&UserID="+document.forms[0].strUserId.value+"&strCBSID="+document.forms[0].hidCBSID.value+"&strCategory="+strCategory;	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 600) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,'AttachFile',prop);		
	}
	
}
function DelAttach(val,alertno){	    
	var alert1 = alertno;
	if(document.forms[0].hidAppDoc.value == ""){
		alert('Document type Required.');
		return;
	}
	else if(document.forms[0].hidDocCode.value == ""){
		alert('Document Required.');
		return;
	}else{		
		    var attSno = "",attFilename="";
			var attSize = window.frames[0].document.getElementsByName("chk_attachdocs").length;										
			if(attSize == 0)
			{
				alert("No Attachment found");
				return;
			}else{				
					document.forms[0].hidAttachmentSnoList.value = "";
					document.forms[0].hidAttachmentName.value = "";
					if(attSize==1)
					{
						if(window.frames[0].document.forms[0].chk_attachdocs.checked == true){
							attSno = attSno + window.frames[0].document.forms[0].attach_hidden.value + "@";
							attFilename = attFilename + window.frames[0].document.forms[0].hidFilename.value + "@";
						}
					}else{			                   				
					for(var i=0;i<attSize;i++)
					{
						if(window.frames[0].document.forms[0].chk_attachdocs[i].checked == true){
							attSno = attSno + window.frames[0].document.forms[0].attach_hidden[i].value + "@";
							attFilename = attFilename + window.frames[0].document.forms[0].hidFilename[i].value + "@";
						}
					}}
                    if(attSno == ""){
                        alert("Select Attachment"); 
                        return;
                    }
					
					if(ConfirmMsg(alert1)){
					document.forms[0].hidAttachmentSnoList.value = attSno;
					document.forms[0].hidAttachmentName.value = attFilename;
					document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/iframeDocGatway.jsp?hidBeanGetMethod=getUploadedDocDetails&hidBeanId=commdocument&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].appno.value+"&UserID="+document.forms[0].strUserId.value+"&hitportion="+val+
					"&hidNewDocCodeList="+document.forms[0].hidAttachmentSnoList.value+"&hidFileName="+document.forms[0].hidAttachmentName.value+"&strCBSID="+document.forms[0].hidCBSID.value;
					}			    
		   }								
	}
}

function callBureauRep()
{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appcibilinterface.jsp?hidBeanGetMethod=getCIBILReport";	
		document.forms[0].method="post";
 		document.forms[0].submit();	
}

</script>
</head>
<body  onLoad="javascript:initShowHideDivs();callOnLoad();">
<form method="post" action="" class="normal">

 <% if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("LAD")) { %>

<jsp:include
	page="../share/Applurllinkper.jsp" flush="true">
	<jsp:param name="pageid" value="5" />
</jsp:include>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; <%
        if(strCategory.equals("AGR"))
         { %>Agriculture <% }
        else if(strCategory.equals("LAD"))
         {
         %> Loan Against Gold Ornaments &amp; Deposits <%} 
        else { %> Retail <% }%> -&gt; Documents -&gt; Pre Sanction Document Attachment</td>
	</tr>
</table>

  <% } else if(strSessionModuleType.equalsIgnoreCase("DIGI")) {%>
	
   <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="5" />
        </jsp:include>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr> 
      <td class="page_flow">Home -&gt; Retail -&gt; Documents -&gt; Pre Sanction Document Attachment</td>
    </tr>    
  </table>

  <% } else  { %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="77" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
	</table>

		<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		<tr> 
		 <td class="page_flow">
		 Home -&gt; Agriculture -&gt; Application  -&gt; Documents -&gt; Pre Sanction Document Attachment
		 </td>
		</tr>
		</table><%} else {%>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		    <tr>
		        
				<td class="page_flow">Home&nbsp;-&gt;Corporate &amp; SME -&gt; Application  -&gt; Documents -&gt; Pre Sanction Document Attachment</td>
		    </tr>
		</table>
		<%} %>
  <% }  %>


<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="70%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr>
	
	  <% if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("LAD") || strSessionModuleType.equals("DIGI")  )  { %> 
				
				<td width="10%" align="center" class="sub_tab_inactive"><b><a
					href="javascript:callApplicant()">By Applicant</a></b></td>
					<td width="15%" align="center" class="sub_tab_active"><b>Pre Sanction Document Attachment</b></td>
				<td width="10%" align="center" class="sub_tab_inactive"><b><a
					href="javascript:callInternal();">By Bank</a></b></td>
					<%if(app_status.equalsIgnoreCase("Processed/Approved")||app_status.equalsIgnoreCase("Closed/Approved") || strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
				 <td width="15%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callpostsancDocAttachment()">Post Sanction Document Attachment</a></b> </td>
				<%}if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("S")){ %>
				<td align="center" width="10%" class="sub_tab_inactive"><b><a
					href="javascript:callRBIGuidelines()">RBI Guidelines</a></b></td>
				<%} %>
			 <%if(Helper.correctNull(ApplicationParams.getCIBILENABLE()).equalsIgnoreCase("TRUE")) { %>
            		<td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callBureauRep()">Bureau Report</a></b> </td>
            <% } %>
		<% } else { %>	
		
		<td width="15%" align="center" class="sub_tab_inactive"><b><a
					href="javascript:callApplicant()">By Applicant</a></b></td>
					<td width="25%" align="center" class="sub_tab_active"><b>Pre Sanction Document Attachment</b></td>
				<td width="15%" align="center" class="sub_tab_inactive"><b><a
					href="javascript:callInternal();">By Bank</a></b></td>
					<%if(app_status.equalsIgnoreCase("Processed/Approved")||app_status.equalsIgnoreCase("Closed/Approved")){ %>
				 <td width="20%"  align="center" class="sub_tab_inactive"><b><a href="javascript:callpostsancDocAttachment()">Post Sanction Document Attachment</a></b> </td>
					<%}if(Helper.correctNull((String)hshValues.get("strAppType")).equalsIgnoreCase("S")){ %>
<!--				<td align="center" width="15%" class="sub_tab_inactive"><b><a href="javascript:callRBIGuidelines()">RBI Guidelines</a></b></td>-->
				<%} %>
				
		 <%} %>
			
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
	class="outertable">
	<tr>
		<td width="30%" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
			<tr>
				<td width="100%">
				<div class="dhtmlgoodies_question"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="3"   class="outertable">
					<tr class="dataheader">
					<td>
				Applicant Documents</td>
				</tr>
				</table>
				</div>
			<div class="dhtmlgoodies_answer"> 
				<div>
					<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%if(arrAppRow!=null && arrAppRow.size()>0){
						for(int i=0;i<arrAppRow.size();i++){
						arrCol=(ArrayList)arrAppRow.get(i);%>
						<tr  class="searchOuter"  style="cursor: pointer;"
								onclick="javascript:showSelected(this,'<%= Helper.correctNull((String)arrCol.get(0)) %>');callListUpload();">
						<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
						</tr>
					<%}}else{ %>
					<tr>
					<td>-- No Documents attached --</td>
					</tr>
					<%} %>
					</table>
					</div>
					</div>
			</td>
			</tr>
			<%-- <tr>
				<td>
				<div class="dhtmlgoodies_question"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="3"   class="outertable">
					<tr class="dataheader">
					<td> Pre-Sanction Bank Documents </td>
				</tr>
				</table>
				</div>
			<div class="dhtmlgoodies_answer"> 
				<div>
					<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%if(arrBankRow!=null && arrBankRow.size()>0){
						for(int i=0;i<arrBankRow.size();i++){
						arrCol=(ArrayList)arrBankRow.get(i);%>
						<tr  class="searchOuter"   style="cursor: pointer;"
								onclick="javascript:showSelected(this,'<%= Helper.correctNull((String)arrCol.get(0)) %>');callListUpload();">
						<td><%=Helper.correctNull((String)arrCol.get(1)) %></td>
						</tr>
					<%}}else{ %>
					<tr>
					<td>-- No Documents attached --</td>
					</tr>
					<%} %>
					</table>
					</div>
					</div>
			</td>
			</tr>--%>
		</table>
		</td>
		<td width="70%" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr style="background:#cba2c6 ;">
								<td style="text-align: center;" colspan="2">Attached
								Documents</td>
							</tr>
							<tr class="datagrid">
						 <%if(!strCategory.equalsIgnoreCase("DIGI") || !StrDigiLoanType.equals("PC")) { %>	
								<td align="right" width="85%"> <img
									src="<%=ApplicationParams.getAppUrl()%>img/attached.jpg"
									onClick="callUploadFile()" width="30" height="25"
									style="display: inline-block; cursor: pointer;"
									title="Attach New Document" id="attNewDoc"/>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;
									&nbsp;&nbsp;&nbsp;
									</td>
								<td align="center" width="15%">
								<img
									src="<%=ApplicationParams.getAppUrl()%>img/deleted.jpg" 
									onClick="DelAttach('D',123)" width="30" height="25"
									style="display: inline-block; cursor: pointer;"
									title="Delete Attachment" id="delDoc"/>
								</td>
						 <%} %>	
							</tr>
							<tr class="datagrid">
							 <%if(!strCategory.equalsIgnoreCase("DIGI")) { %>	
							<td align="right" width="85%">
							Attach Document 
							</td>
							<td align="center" width="15%">
							 Delete Document
							</td>
							<%} %>
							</tr>
							<tr id="iframeID">
								<td class="datagrid" align="center" colspan="2">
								<iframe id="iframeDocAttach" align="top" style="width: 800px;border: 0px;"></iframe>
								</td>
							</tr>							
						</table>
		</td>
		</tr>
		</table>
		</td>
	</tr>
	<tr>
	<td><br/><lapschoice:combuttonnew
	btnnames=''
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' /> </td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidAppDoc">
<input type="hidden" name="hidDocCode">
<input type="hidden" name="hidAttachmentSnoList">
<input type="hidden" name="hidAttachmentName">
<input type="hidden" name="strUserId" value = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>">
<input type="hidden" name="hidCBSID" value = "<%=Helper.correctNull((String)hshValues.get("strCBSID"))%>">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hidpagefrom">
<input type="hidden" name="hidDocCnt">
	</form>
</body>
</html>