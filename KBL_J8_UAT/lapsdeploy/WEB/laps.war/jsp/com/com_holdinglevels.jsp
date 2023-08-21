<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
ArrayList arrRow = new ArrayList();
String finvalcheck="";
arrRow = (ArrayList) hshValues.get("arrRow");
if (arrRow != null && arrRow.size() > 0)
{
  finvalcheck="true";
}%>
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
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
function htmlView()
{
  var hlpvar = appURL+"action/com/htmlView.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComment&type=1&appno="+"<%=Helper.correctNull((String)hshValues.get("appno"))%>";
  var title = "HTMLVIEW";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
function gototab2(beanid,methodname,pagename,flowtype)
{
     var finval='<%=finvalcheck %>';
	if(flowtype=="COP")
	{ 
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
		document.forms[0].submit();
	}
	else
	{ 		
		if(finval=='true')  //to check whether values have been availble in financial date fields
		{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
		}
		else
		{
			alert("Please Enter values in Financial");
		}
	}
}
function gototab(beanid,methodname,pagename,flowtype)
{
     
	if(flowtype=="COP")
	{ 
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
		document.forms[0].submit();
	}
	else
	{ 				
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=flowtype;
		document.forms[0].submit();		
	}
}   
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;	
}

function call_page(url,method,type)
{	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();	
}
function placevalues()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	if(document.forms[0].btnenable.value=="N")	 
	{
	 	
	 	enableButtons(true,true,true,false,true);
	 	document.forms[0].cmdloadholdinglevels.disabled=true;
	}
	else
	{
	enableButtons(false,true,true,false,false);
	document.forms[0].cmdloadholdinglevels.disabled=false;
	for(var i=0;i<document.forms[0].elements.length;i++)
		{			
			if(document.forms[0].elements[i].type=="textarea")
			{
				 document.forms[0].elements[i].readOnly=true;			  
			}
			if(document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].disabled=true;			  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
				 document.forms[0].elements[i].disabled=true;			  
			}			
		}
		}
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/com_holdinglevels.jsp?type=5";
	document.forms[0].submit();
	}
}

function doClose()
{

        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }

}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
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
			if(document.forms[0].elements[i].type=="text")
			{
				 document.forms[0].elements[i].disabled=false;			  
			}
			
		}
	enableButtons(true,false,false,true,true);
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_holdinglevel');
	
}
function doSave()
{	
	enableButtons(true,true,true,false,true);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_holdinglevels.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=5";
	document.forms[0].submit();
}
function doLoadHoldingLevels()
{
	document.forms[0].hidBeanId.value="combobassessment";
	document.forms[0].hidBeanGetMethod.value="updateHoldingLevels";
	document.forms[0].action=appURL+"action/com_holdinglevels.jsp?pageval=HL";
	document.forms[0].submit();
	
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateGeneralComment";
		document.forms[0].hidBeanGetMethod.value="getDataComment";
		document.forms[0].hidSourceUrl.value="/action/com_holdinglevels.jsp"
		document.forms[0].action=appURL+"controllerservlet?type=5";
		document.forms[0].submit();
	}
}
</script>
</head>

<body onload="placevalues()">
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
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="top" colSpan=5><jsp:include
			page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<span class="page_flow">Home -&gt; Corporate &amp; SME -&gt;
Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Holding Levels
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
 <jsp:include
	page="../com/com_commentstab.jsp" flush="true">
	<jsp:param name="tabid" value="5" />
</jsp:include>
<table width="98%" border="0" cellspacing="0" cellpadding="5"
	class="outertable border1" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5"
					class="outertable">
					<tr>
						<td valign="top">
						<table width="90%" border="0" cellspacing="0" cellpadding="3"
							class="outertable" align="center">
							<tr>
								<td>
								<table width="90%" border="0" cellspacing="1" cellpadding="5"
									class="outertable" align="center">
									<%arrRow = (ArrayList) hshValues.get("arrRow");									
									if (arrRow != null && arrRow.size() > 0) {%>
									<%for (int i = 0; i < arrRow.size(); i++) {
					ArrayList arrCol = new ArrayList();
					arrCol = (ArrayList) arrRow.get(i);
					
					String strBgcolor = "";
					String strAlign = "";
					if (i < 2) {
						strBgcolor = "dataheader";
						strAlign = "center";
					} else {
						strBgcolor = "datagrid";
						strAlign = "right";
					}

					String strRowType=Helper.correctNull((String) arrCol.get(2));
					if(strRowType.trim().equals("HE"))
					{
					%>
									<tr class="<%=strBgcolor%>">
										<td colspan="7"><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;
										<input type="hidden" name="txt_holdlevel" value=""></td>
									</tr>
									<%}else{ %>
									<tr class="<%=strBgcolor%>">
										<td><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(3))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(7))%>&nbsp;</td>
										<%if(i==0){ %>
										<td width="13%" align="center" nowrap><input type="text"
											name="txt_date"
											value="<%=Helper.correctNull((String) arrCol.get(8))%>"
											size="13" maxlength="12" style="" border=1
											class="cellContainer"
											onBlur="checkDate(txt_date);checkmaxdate(this,currentDate)"
											readOnly> <a alt="Select date from calender"
											href="javascript:callCalender('txt_date')"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											width="21" height="18" border="0"></a></td>
										<%}else if(i==1){ %>
										<td width="13%" align="center">Accepted</td>
										<%}else{ %>
										<td width="13%" align="center"><lapschoice:CurrencyTag
											name="txt_holdlevel" size="22" maxlength="12"
											value='<%=Helper.correctNull((String) arrCol.get(8))%>' /></td>
										<%} %>
									</tr>
									<%}}}%>
								</table>
								</td>
							</tr>
							<tr>
							<td width="60%" valign="top">
							<div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("com_holdinglevel_comments")) %></div></div>
					 		<div id="id_editor">
							<textarea name="txt_holdinglevel" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)hshValues.get("com_holdinglevel_comments"))%></textarea>
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
<lapschoice:combuttonnew
	btnnames='Edit_Save_Cancel_Delete_Load Holding Levels'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden" name="yearfrom" value="1">
<input type="hidden" name="cattype" value="<%=strCategoryType%>">
<input type="hidden" name="pagefrom"></form>
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
</form>
</body>
<!--<script language="javascript1.2">editor_generate('txt_holdinglevel');</script>-->
</html>
