<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
String strfinindactor=Helper.correctNull((String)hshValues.get("finindactor"));
String indicatorflag=Helper.correctNull((String)hshValues.get("indicatorflag"));
ArrayList arrRow = new ArrayList();
arrRow = (ArrayList) hshValues.get("arrRow");
%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
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

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
   
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;	
}
function placevalues()
{
	var finindactor="<%=strfinindactor%>";
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	
	 //	enableButtons(true,true,true,true,false);
	 	document.forms[0].cmdload.disabled=true;
	}
	else
	{
	//	enableButtons(false,true,true,false,false);
		<% if(indicatorflag.equals("yes") ) {%>
				document.forms[0].cmdload.disabled=false;
		<%}else{%>
				document.forms[0].cmdload.disabled=true;
		<%}%>
	
	}
		if(finindactor != "")
			document.forms[0].sel_comment.value=finindactor;
		else
			document.forms[0].sel_comment.value="0";			
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getFinIndicatorComment";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].action = appUrl+"action/com_finindicatorcomment.jsp";
	document.forms[0].submit();
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";	
		document.forms[0].action=appUrl+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	if(document.forms[0].sel_comment.value != "0")
	{		
		enableButtons(true,false,false,false,true);
		document.forms[0].hidAction.value ="insert";
	}
	else
	{
		alert("Select Financial Indicator");
		document.forms[0].sel_comment.focus();
		return;		
	}	
}

function doSave()
{
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].sel_comment.disabled=false;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateFinIndicatorComment";
	document.forms[0].hidBeanGetMethod.value="getFinIndicatorComment";
	document.forms[0].hidSourceUrl.value="/action/com_finindicatorcomment.jsp"
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
} 
function doLoad()
{
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="updateLoad";
	document.forms[0].action=appURL+"action/com_finindicatorcomment.jsp";
	document.forms[0].submit();			
}
function callCalender(fname)
 {
	if(document.forms[0].cmdapply.disabled==false)
	{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 	}
 }
 function gototab(beanid,methodname,pagename,flowtype)
{	if(document.forms[0].cmdsave.disabled==true)
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].flowtype.value=flowtype;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}	
} 
function showcomment()
{
	
		document.forms[0].hidBeanId.value="executive";
		document.forms[0].hidBeanGetMethod.value="getFinIndicatorComment";
		document.forms[0].action = appUrl+"action/com_finindicatorcomment.jsp";
		document.forms[0].submit();

}
function doDelete()
{
	if(document.forms[0].sel_comment.value != "0")
	{
		var con=ConfirmMsg('152');
		if(con)
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].sel_comment.disabled=false;
			document.forms[0].hidBeanId.value="executive";
			document.forms[0].hidBeanMethod.value="updateFinIndicatorComment";
			document.forms[0].hidBeanGetMethod.value="getFinIndicatorComment";
			document.forms[0].hidSourceUrl.value="/action/com_finindicatorcomment.jsp"
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		alert("Select Financial Indicator");
		document.forms[0].sel_comment.focus();
		return;		
	}
}
function getdivval()
{		
	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanGetMethod.value="getFinIndicatorComment";
	document.forms[0].action = appUrl+"action/com_finindicatorcomment.jsp";
	document.forms[0].submit();
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
<form name="frmpri" method = post class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top" colSpan=5>
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="8" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />			
              </jsp:include>
            </td>
          </tr>
        </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>	
      <td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Financial Indicator -&gt; Financial Indicator Comments	
      <span style="display:none"><lapschoice:borrowertype /></span> 
        <lapschoice:application /> </td>
	</tr>
</table>
<lapschoice:FinAnalysisTag tabid="9" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td valign="bottom">
		<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">				
				<td id="prin" class="sub_tab_inactive" WIDTH="15%"><a href="javascript:gototab('executive','getData8','exec_page8.jsp','FI')" class="blackfont">Financial Indicators</a></td>
				<td class="sub_tab_active" WIDTH="15%">Financial Indicator Comments</td>
       		</tr>
		</table>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">             
			  <tr>
			  	<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
				<tr>
				        <td width="15%">Financial Indicator :</td>
				        <td width="85%"> 
                         <select name="sel_comment" onchange="showcomment()">
							<option value="0">&lt;-- Select --&gt;</option>
							<lapschoice:finindicatorcomments/>
						</select>
				</td>
				</tr>
				</table>				
				</td>
			  </tr>
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
				<tr>
								<td>
								<table width="90%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
									<%if (arrRow != null && arrRow.size() > 0) {%>																	
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
					}%>
								<%if(Helper.correctNull((String) arrCol.get(2)).equals("FO")){ %>
								<% if(!(Helper.correctNull((String) arrCol.get(4)).equals("")|| Helper.correctNull((String) arrCol.get(4)).equals("0.00"))|| !(Helper.correctNull((String) arrCol.get(5)).equals("")|| Helper.correctNull((String) arrCol.get(5)).equals("0.00"))|| !(Helper.correctNull((String) arrCol.get(6)).equals("")|| Helper.correctNull((String) arrCol.get(6)).equals("0.00"))){%>
									<tr class="<%=strBgcolor%>">
										<td><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>
									</tr>
									<%}} else {%>
										<tr class="<%=strBgcolor%>">
										<td><%=Helper.correctNull((String) arrCol.get(1))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(4))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(5))%>&nbsp;</td>
										<td width="13%" align="<%=strAlign%>"><%=Helper.correctNull((String) arrCol.get(6))%>&nbsp;</td>										
									</tr><%}}}%>
								</table>
								</td>
								</tr>									
					 <tr>
					  <td width="60%" valign="top">
					  Comment:
					  </td>
					  </tr>
					  <tr>
					  <td width="60%" valign="top" >
					  <textarea name="txt_finindicator"  cols="110" wrap="VIRTUAL" rows="20" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("finindicator_comments"))%></textarea>
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
	<table width="12%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Load' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
		</td>
          </tr>
        </table>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="yearfrom" value="1">
   <INPUT TYPE="hidden" name="trapEdit"  value="<%=Helper.correctNull((String)hshValues.get("trapEdit"))%>">
  <INPUT TYPE="hidden" name="hidEditMode"  value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
   <input type="hidden" name="flowtype" value="<%=Helper.correctNull((String)hshValues.get("page"))%>">
</form>
</body>
<script language="javascript1.2">
editor_generate('txt_finindicator');
</script> 
</html>