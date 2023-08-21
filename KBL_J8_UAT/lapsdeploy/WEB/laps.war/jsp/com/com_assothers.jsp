<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="Javascript1.2"><!-- // load htmlarea
_editor_url = "<%=ApplicationParams.getAppUrl()%>";                     // URL to htmlarea files
var win_ie_ver = parseFloat(navigator.appVersion.split("MSIE")[1]);
if (navigator.userAgent.indexOf('Mac')        >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Windows CE') >= 0) { win_ie_ver = 0; }
if (navigator.userAgent.indexOf('Opera')      >= 0) { win_ie_ver = 0; }
if (win_ie_ver >= 5.5) {
  document.write('<scr' + 'ipt src="' +_editor_url+ 'editor.js"');
  document.write(' language="Javascript1.2"></scr' + 'ipt>');  
} else { document.write('<scr'+'ipt>function editor_generate() { return false; }</scr'+'ipt>'); }
// --></script>

<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request
							.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var eco_date="<%=Helper.correctNull((String)hshValues.get("com_date"))%>";
var appno="<%=request.getParameter("appno")%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;	
	document.forms[0].cmdcomments.disabled=bool5;
}
function call_page(url,method,type)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
	
}

function placevalues()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	document.forms[0].txt_commercialdate.value=eco_date;
	document.forms[0].txt_commercialdate.readOnly=true;
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
	}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getSourceOfMargin";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].action=appURL+"action/com_assothers.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	 var cattype=document.forms[0].cattype.value;
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME")||(cattype=="STL"))
    {
	    if(ConfirmMsg(100))
		{
			document.forms[0].action=appUrl+"action/corppge.jsp";
		 	document.forms[0].submit();
	 	}
	}
}

function doEdit()
{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}
			
		}
	enableButtons(true,false,false,true);
	document.forms[0].cmddelete.disabled=false;	
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_termloan');
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanMethod.value="updateOthers";
	document.forms[0].hidBeanGetMethod.value="getOthers";
	document.forms[0].hidSourceUrl.value="/action/com_assothers.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appURL+"action/ControllerServlet";	
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidBeanMethod.value="updateOthers";					
	document.forms[0].hidSourceUrl.value="action/com_assothers.jsp";	
    document.forms[0].method="post";			
	document.forms[0].submit();	
}
function gototab(beanid,methodname,pagename,type)
{
		if(type=="COP")
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
		document.forms[0].submit();
		}
		else
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=type;
		document.forms[0].submit();
		}	
}   
function callcopmof()
{
	
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/com_termloanassesment.jsp";
		document.forms[0].submit();
	
}
function callReleasePattern(beanid,methodname,pagename)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callCalender()
{
	if(document.forms[0].cmdedit.disabled==true && document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,'txt_commercialdate');
	}	
}
function callTermAssesement(beanid,methodname,pagename,type)
{			
	if(type=="COP")
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
	document.forms[0].submit();
	}
	else if(type=="SOM")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+type;
		document.forms[0].submit();
	}
	else
	{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].flowtype.value=type;
	document.forms[0].submit();
	}
}
function doComments()
{
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno;
	window.open(url,"Comments",prop);
}
</script>
</head>
<body onload="placevalues()">
<%
	String strType = Helper.correctNull((String) hshValues.get("type"));
%>
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
<form name="frmpri" method="post" class="normal">
<%
	if (strCategoryType.equalsIgnoreCase("STL")) {
%> <jsp:include
	page="../share/applurllinkscom.jsp" flush="true">
	<jsp:param name="pageid" value="11" />
	<jsp:param name="cattype" value="<%=strCategoryType%>" />
	<jsp:param name="ssitype" value="<%=strSSIType%>" />
</jsp:include>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
		Term Loan -&gt; Comments -&gt; Term loan assessment</td>
	</tr>
</table>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="30%" border="0" cellspacing="1" cellpadding="3"
	class="outertable">
	<tr>
		<td class="sub_tab_inactive" align="center"><a
			href="JavaScript:gototab('comformula','getDateFincommentsData','comdynamiccashflow.jsp','CA')"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Cash Flow';return true;"> <b>Cash
		Flow</b></a></td>
		<td class="sub_tab_active" align="center">Term loan assessment</td>
	</tr>
</table>
<%
	} else {
%>
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
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Term Loan
Assessment</span><br>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="3" />
</jsp:include> <%
 	}
 %> <%
 	if (!strCategoryType.equalsIgnoreCase("STL")) {
 %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="1" cellpadding="3"
					class="outertable">
					<tr align="center">
					    <td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getBreifDetailOfProject','com_BreifDetailOfProject.jsp','')"><b>Brief Details of the project</b></a></td>					    
						<td class="sub_tab_inactive" align="center"><a
							href="javascript:callcopmof()"><b>Term loan assessment</b></a></td>
						<td class="sub_tab_inactive" align="center"><a
					href="javascript:callTermAssesement('bankapp','getSourceOfMargin','com_contlimitcomment.jsp','SOM')"><b>Source of Margin</b></a></td>
						<td class="sub_tab_inactive" align="center"><a
							href="javascript:callReleasePattern('bankapp','getReleasePattern','com_releasepattern.jsp','')"><b>Release Pattern/ Margin</b></a></td>

						<td class="sub_tab_active" align="center"><b>Others</b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="5"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr><td><table class="outertable"><tr><td>Date of commencement of commercial operation(DCCO / COD)</td><td><input
											type="text" name="txt_commercialdate" size="11"
											value="" maxlength="10" style="text-align: right"
											onBlur="checkmindate(this,currentDate)">
                                           <a alt="Select date from calender" href="#"
											onClick="callCalender('txt_commercialdate')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border='0' alt="Select date from calender"></a></td></tr></table></td></tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="90%" align="center" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>Remarks</td>
							</tr>
							<tr>
								<td valign="top" width="60%">
								 <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_termloan_comments")) %></div></div>
					 				<div id="id_editor">
					 				<textarea name="txt_termloan"
									cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
									<%=Helper.correctNull((String) hshValues
							.get("com_termloan_comments"))%></textarea>
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
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable">
	<tr>
		<td colspan="3"><lapschoice:combuttonnew
			btnnames='Edit_Save_Cancel_Delete_Comments'
			btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="flowtype" /> <input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="pageType" value="SOM">
<input type="hidden" name="hidSno" value="1">
<input type="hidden" name="pagefrom">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<input type="hidden" name="hidCommentPage" value="assothers">
</form>
</body>
<!--<script language="javascript1.2">editor_generate('txt_termloan');</script>-->
</html>
