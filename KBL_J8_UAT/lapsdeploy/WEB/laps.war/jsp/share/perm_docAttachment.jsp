<%@include file="../share/directives.jsp"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
    <% 
			ArrayList arrOtherRow=new ArrayList();
			ArrayList arrCol=new ArrayList();
			arrOtherRow=(ArrayList)hshValues.get("arrOtherRow");
			String app_status=Helper.correctNull((String)request.getParameter("appstatus"));
			String docAttCount=Helper.correctNull((String)hshValues.get("docAttCount"));
			String strModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType"));
			int  vecModSize = 0;
			ArrayList vecModule = (ArrayList) hshValues.get("tabdetails");
			if (vecModule != null) {
				vecModSize = vecModule.size();
			}
			String tagFlag = "";
			String strCurModule="";
			if(app_status.equalsIgnoreCase(""))
				app_status=Helper.correctNull((String)hshValues.get("appstatus"));
			
			String strModule="";
			String strPageFrom=Helper.correctNull((String)request.getParameter("hidpagefrom"));
			if(strModuleType.equalsIgnoreCase("PERM"))
				strModule="dev";
			else if(strPageFrom.equalsIgnoreCase("MSME"))
				strModule="MSME";
			else
				strModule="rating";
			
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>
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
	border: 1px solid #dcbad8;
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
var varappstatus="<%=app_status%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varModuleType="<%=strModule%>";
var varMigrationFlag="<%=Helper.correctNull((String)hshValues.get("strMigrationflag"))%>";
var varFinno="<%=Helper.correctNull((String)hshValues.get("strAppno")) %>";
var varAssLiabFlag="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var varpageName="<%=Helper.correctNull((String)hshValues.get("strpageName")) %>";
	
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
		document.forms[0].hidAppDoc.value="O";
		document.forms[0].hidDocCode.value="";
		document.forms[0].hidDocID.value="";
		document.forms[0].hidDocCnt.value="";
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
function showSelected(obj,val,val1,val2,val3){
		$(obj).siblings().removeClass('searchOuter1');
		$(obj).siblings().addClass('searchOuter');
		$(obj).addClass('searchOuter1');
		$(obj).removeClass('searchOuter');
		document.forms[0].hidDocCode.value = val;
		document.forms[0].hidDocID.value = val1;
		document.forms[0].hidDocCnt.value = val2;	
}

function addDoc(varType,varSubType)
{
if(varappstatus!=""){
	if(varappstatus!="op")
	{	
		alert("You cannot Attach the Document");
		return;
	}
	}
	if(confirm("Do you want to add new documents?"))
	{
		var prop = "scrollbars=no,width=700,height=350,top=100,left=80";
		var url=appUrl+"action/appdoclist.jsp?doc_type="+varType+"&ModuleType="+varModuleType+"&strSubType="+varSubType+"&varpageName="+varpageName;
		window.open(url,"",prop);
	}
}


function doSave()
{
	document.forms[0].hidAction.value="New";
	//document.forms[0].app_no.value = document.forms[0].appno.value;
	document.forms[0].hidSourceUrl.value="perm_docAttachment.jsp";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatePermDocument";
	document.forms[0].hidBeanGetMethod.value="getpermDocumentDetails";
	document.forms[0].action=appUrl+"action/controllerservlet";
	//document.forms[0].hidAppDoc.value="O";
	document.forms[0].hidAppDocType.value=document.forms[0].hidAppDoc.value;
	document.forms[0].cmdsave.disabled=true;
 	document.forms[0].submit();
}
function callListUpload()
{
	document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/iframeDocGatway.jsp?hidBeanGetMethod=getUploadedDocDetails&hidBeanId=commdocument&DocType="+document.forms[0].hidAppDoc.value+
	"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].app_no.value+"&strappstatus="+varappstatus;
}

function callUploadFile()
{
	if(varGrpRights=='r')
	{
		alert("You cannot Attach the Document");
		return;
	}
	if(varappstatus!=""){
	if(docAttCount=="0" ||varappstatus!="op")
	{	
		alert("You cannot Attach the Document");
		return;
	}
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
		var url = "<%=ApplicationParams.getAppUrl()%>action/perDocumentAttach.jsp?&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].app_no.value+"&UserID="+document.forms[0].strUserId.value+"&strCBSID="+document.forms[0].hidCBSID.value+"&strfacslno="+document.forms[0].hidfacslno.value+"&strCategory="+varModuleType;	
		var xpos = (screen.width - 600) / 2;
		var ypos = (screen.height - 600) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,'AttachFile',prop);		
	}
	
}

function viewDocAttach(val){
	var title = "AttachmentViewer";
	var prop = "scrollbars=no,width=850,height=620";	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;		
	var purl = "<%=ApplicationParams.getAppUrl()%>action/iframeDocView.jsp?hidBeanId=commdocument&hidBeanGetMethod=viewDocumentData&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].app_no.value+"&snoNo="+val+"&strCBSID="+document.forms[0].hidCBSID.value;
	window.open(purl,title,prop);
}

function doClose()
{
   if(ConfirmMsg(100))
	 {
		 if(document.forms[0].hidpagefrom.value=="MSME")
		 {
			window.close(); 
		 }
		 else
		 {
		 	document.forms[0].action=appUrl+"action/mainnav.jsp";
		 	document.forms[0].submit();
		 }
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
						}
					}
                    if(attSno == ""){
                        alert("No Attachment found"); 
                        return;
                    }
					
					if(ConfirmMsg(alert1)){
					document.forms[0].hidAttachmentSnoList.value = attSno;
					document.forms[0].hidAttachmentName.value = attFilename;
					document.all.iframeDocAttach.src="<%=ApplicationParams.getAppUrl()%>action/iframeDocGatway.jsp?hidBeanGetMethod=getUploadedDocDetails&hidBeanId=commdocument&DocType="+document.forms[0].hidAppDoc.value+"&DocCode="+document.forms[0].hidDocCode.value+"&appno="+document.forms[0].app_no.value+"&UserID="+document.forms[0].strUserId.value+"&hitportion="+val+
					"&hidNewDocCodeList="+document.forms[0].hidAttachmentSnoList.value+"&hidFileName="+document.forms[0].hidAttachmentName.value+"&strCBSID="+document.forms[0].hidCBSID.value+"&strfacslno="+document.forms[0].hidfacslno.value;
					}			    
		   }								
	}
}

function deleteDoc()
{
	//if(((document.forms[0].appholder.value!=document.forms[0].strUserId.value) && varMigrationFlag!="Y") || (varMigrationFlag=="Y" && document.forms[0].appholder.value==varOrgScode && app_status!="Processed/Approved"))
	{	
	//	alert("You cannot Attach the Document");
	//	return;
	}
	//if(varGrpRights=='r')
	//	return;
	if(document.forms[0].hidAppDoc.value=="")
	{
		alert("Select Other Document Type");
		showHideContent(0,1);
		return;
	}
	else if(document.forms[0].hidDocID.value=="")
	{
		alert("Select the Document");
		showHideContent(0,1);
		return;
	}
	else if(document.forms[0].hidDocCnt.value!="0")
	{
		alert("Delete All the attachments before deleting the documents");
		showHideContent(0,1);
		return;
	}
	if(confirm("Do you want to delete this Document?"))
    {	
		document.forms[0].hidAction.value = "delete";
		//document.forms[0].app_no.value=document.forms[0].appno.value;
		document.forms[0].hidSourceUrl.value="/action/perm_docAttachment.jsp";
		document.forms[0].hidBeanId.value="perDeviation";
		document.forms[0].hidBeanMethod.value="updatePermDocument";
		document.forms[0].hidBeanGetMethod.value="getpermDocumentDetails";
		//document.forms[0].hidAppDoc.value=varType;
		document.forms[0].action=appUrl+"action/controllerservlet";
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].submit();	
	}
}
function callFinancialWorkflow()
{
	if(varFinno=="new")
	{
		alert("Please Enter Only for rating tab details to proceed further ");
	return;
	}
	document.forms[0].hidBeanId.value = "financial";
	document.forms[0].hidBeanGetMethod.value="getHistroy";
	document.forms[0].action=appUrl+"action/com_financialratingworkflow.jsp";
	document.forms[0].submit();
}
function getonlyforrating()
{ 
	document.forms[0].hidBeanId.value="financial";	
	document.forms[0].hidBeanGetMethod.value="getFinRating";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/FinancialOFRating.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}
function getSection(modid)
{	
    if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert('103');
		return;
	}	
	document.forms[0].pageval.value = modid;
	document.forms[0].hidBeanId.value="financial";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action = appUrl+"action/com_FinancialTemp.jsp";
	document.forms[0].submit();
}

function getmsmedocupload(){
	
	window.opener.document.forms[0].hiddocchk.value="Y";
}
</script>

</head>
<body  onLoad="javascript:initShowHideDivs();callOnLoad();">
<form method="post" class="normal">
<%if(strModuleType.equalsIgnoreCase("PERM")){ %>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td class="page_flow">  
		Home -&gt; Permission -&gt;Document Attachment
		</td>
	</tr>
</table>
	<lapschoice:ApplDevHeaderTag />
<%}else if(!strPageFrom.equalsIgnoreCase("MSME")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"class="outertable">
		<tr>
		<td class="page_flow">Home -&gt;Financial / Rating</td>
	</tr>
</table>
<lapschoice:finapptype  appid='<%=Helper.correctNull((String)hshValues.get("appidnew"))%>' financeid='<%=Helper.correctInt((String)hshValues.get("finace_id"))%>'/>
<table width="100%" cellspacing="0" cellpadding="0" class="outertable">				
					<tr>
						<td><%boolean pflag = false;
			boolean base_year = false;
			int strWidth;
			int tabWidth;
			strWidth = vecModSize;%>
						<table border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<%for (int i = 0; i < vecModSize; i++) {
				ArrayList vecVal = (ArrayList) vecModule.get(i);
					if(i==0)
					{
						tagFlag = Helper.correctNull((String)vecVal.get(0));
					}
				   String str1=Helper.correctNull((String)vecVal.get(0));					
				   String strClass;				  
     	 		 if(strWidth == 1)
					{
					tabWidth = 5;
					}
				else if(strWidth == 2)
				{
				tabWidth = 20;
				}
				else
				{
				   tabWidth=80/strWidth;
				}
				if(i==0 && strCurModule.trim().equals(""))
				{
					str1="";
				}
				   
				  strClass="sub_tab_inactive";
				   if (!Helper.correctNull((String) vecVal.get(0))
							.equals("Project Financial Input")) {
				  %> <td  align="center" class="<%=strClass%>">
				<a href="#" onclick="getSection('<%=Helper.correctNull((String)vecVal.get(0))%>')">
				<b><%=Helper.correctNull((String) vecVal.get(0))%></b></a>
								<%
					if (Helper.correctNull((String) hshValues.get("tabname"))
							.equalsIgnoreCase("Project Financial Input")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("INFRA STRUCTURE MODEL")
							|| Helper.correctNull(
									(String) hshValues.get("tabname"))
									.equalsIgnoreCase("OPERATIONS PHASE")) {
					}
				}%>
				</td>
								<%}%>
							  	<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="gototab('financial','getDataRatio','finratio.jsp','RA1&pagetype1=OFR')">FINANCIAL RATIOS</a></b></td>
							  	<td align="center" class="sub_tab_inactive" nowrap><b><a href="#" onclick="getonlyforrating()">ONLY FOR RATING</a></b></td>  
								<td align="center" class="sub_tab_active" nowrap><b>Document Attachment</b></td>

								<td align="center" class="sub_tab_inactive"><a
									href="javascript:callFinancialWorkflow();"
									onMouseOut="window.status='';return true;"
									onMouseOver="window.status='Applicant';return true;"> <b>
							         FINANCIAL/RATING WORKFLOW </b></a></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
<INPUT TYPE="hidden" NAME="hidfinanceid" value="<%=Helper.correctInt((String)hshValues.get("finace_id"))%>">
<INPUT TYPE="hidden" NAME="hidcmasno" value="<%=Helper.correctInt((String)hshValues.get("fintype"))%>">
<input type="hidden" name="AssetandLiab" value="<%=Helper.correctNull((String)hshValues.get("AssetandLiab"))%>">
<input type="hidden" name="pageval">
<input type="hidden" name="appno" value="<%=Helper.correctNull((String)hshValues.get("strAppno"))%>">
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
	class="outertable">
	<tr>
		<td width="30%" valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"	class="outertable">
	
			<tr>
				<td>
				<div class="dhtmlgoodies_question"> 
				<table width="100%" border="0" cellspacing="0" cellpadding="3"   class="outertable">
					<tr class="dataheader">
					<td>Documents &nbsp; </td> 
					<td width="2%"><img alt="Click to Add new Document" 
			src="<%=ApplicationParams.getAppUrl()%>img/add.png" 
			onclick="addDoc('O','');" style="cursor:hand"/>&nbsp;</td>
					<td width="2%"><img alt="Click to Delete the Document" 
			src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" 
			onclick="deleteDoc();" style="cursor:hand"/>&nbsp;</td>
				</tr>
				</table>
				</div>
			<div class="dhtmlgoodies_answer"> 
				<div>
					<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<%if(arrOtherRow!=null && arrOtherRow.size()>0){
						for(int i=0;i<arrOtherRow.size();i++){
							arrCol=(ArrayList)arrOtherRow.get(i);%>
							<tr  class="searchOuter"   style="cursor: pointer;"
									onclick="javascript:showSelected(this,'<%= Helper.correctNull((String)arrCol.get(0)) %>','<%=Helper.correctNull((String)arrCol.get(2)) %>','<%=Helper.correctNull((String)arrCol.get(4)) %>','');callListUpload();">
							<td><%=Helper.correctNull((String)arrCol.get(1)) %>
							<input type="hidden" name="apdoc_del" value="<%=Helper.correctNull((String)arrCol.get(2)) %>"></td>
							</tr>
						<%}	
					}else{ %>
					<tr>
					<td>-- No Documents attached --</td>
					</tr>
					<%} %>
					</table>
					</div>
					</div>
			</td>
			</tr>
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
							</tr>
							<tr class="datagrid">
							<td align="right" width="85%">
							Attach Document 
							</td>
							<td align="center" width="15%">
							 Delete Document
							</td>
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
		<td><br/><lapschoice:combuttonnew	btnnames=''	btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' /> </td>
	</tr>
</table>

	



<input type="hidden" name="hidDocCode">
<input type="hidden" name="hidAppDoc">
<input type="hidden" name="hidDocID">
<input type="hidden" name="hidDocCnt">
<input type="hidden" name="hidNewDocCode">
<input type="hidden" name="app_no" value="<%=Helper.correctNull((String)hshValues.get("strAppno"))%>">
 <input type="hidden" name="hidAppDocType" value="">
<input type="hidden" name="cmdsave" disabled="disabled">
<input type="hidden" name="hidCBSID" value = "<%=Helper.correctNull((String)hshValues.get("strCBSID"))%>">
<input type="hidden" name="hidAttachmentSnoList">
<input type="hidden" name="hidAttachmentName">
<input type="hidden" name="strUserId" value = "<%=Helper.correctNull((String)session.getAttribute("strUserId"))%>">
<input type="hidden" name="hidfacslno">


<input type="hidden" name="hidpagefrom" value="<%=strPageFrom %>">
<input type="hidden" name="hidpageName" value = "<%=Helper.correctNull((String)hshValues.get("strpageName"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>' />

</form>
</body>
</html>