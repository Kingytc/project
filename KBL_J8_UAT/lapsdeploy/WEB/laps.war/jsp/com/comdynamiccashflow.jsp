<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%ArrayList vecData = null;
			String[] strCurrYear = new String[4];
			String[] strPrevYear = new String[4];
			String[] strCurrFinancialType = new String[4];
			String[] strPrevFinancialType = new String[4];
			int totnoofyears = 0;
			int totalsize = 0;			
			if(!strCategoryType.equalsIgnoreCase("STL"))
			{
			if (hshValues.size() > 0 && hshValues != null) {
				totalsize = Integer.parseInt((String) hshValues.get("totvalue"));
				totnoofyears = Integer.parseInt((String) hshValues.get("totalnoofyears"));
			}
			if (hshValues.size() > 0 && hshValues != null) {
				for (int j = 0; j < 4; j++) {
					strCurrYear[j] = Helper.correctNull((String) hshValues.get("fincurryear" + Integer.toString(j + 1)));
					strPrevYear[j] = Helper.correctNull((String) hshValues.get("finprevyear" + Integer.toString(j + 1)));
					if (Helper.correctNull((String) hshValues.get("fincurrtype"+ Integer.toString(j + 1))).equals("A")) {
						strCurrFinancialType[j] = "Audited";
					} else if (Helper.correctNull((String) hshValues.get("fincurrtype"+ Integer.toString(j + 1))).equals("U")) {
						strCurrFinancialType[j] = "Unaudited";
					} else if (Helper.correctNull(
							(String) hshValues.get("fincurrtype"+ Integer.toString(j + 1))).equals("E")) {
						strCurrFinancialType[j] = "Estimated";
					} else if (Helper.correctNull((String) hshValues.get("fincurrtype"+ Integer.toString(j + 1))).equals("P")) {
						strCurrFinancialType[j] = "Projection";
					} else {
						strCurrFinancialType[j] = "";
					}
					strPrevFinancialType[j] = Helper.correctNull((String) hshValues.get("finprevtype"+ Integer.toString(j + 1)));
				}
			} else {
				for (int j = 0; j < 4; j++) {
					strCurrYear[j] = "";
					strPrevYear[j] = "";
					strCurrFinancialType[j] = "";
					strPrevFinancialType[j] = "";
				}
			}
		}
			String strcmaindex = Helper.correctNull((String) request.getParameter("hidcmano"));
			if (strcmaindex.equalsIgnoreCase("")) {
				strcmaindex = Helper.correctNull((String) hshValues.get("cma_index"));
			}%>
<html>
<head>
<title>Cash Flow</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
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
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varyearfrom = "<%=totnoofyears%>";
function onloading()
{ 
	EditorEnableDisable("id_div","block","id_editor","none");
	function placevalues()
	{
		var sel_divID="<%=Helper.correctNull((String)hshValues.get("sel_divID"))%>";			
		document.forms[0].sel_divID.value=sel_divID;
		disableFields(true);
	}
}
function onPrev()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)-3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)-3;
		document.forms[0].action = appUrl+"action/comdynamiccashflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}
function onNext()
{
	var var1 = document.forms[0].yearfrom.value;
	if((eval(var1)+3) <varyearfrom)
	{	
		document.forms[0].yearfrom.value = eval(var1)+3;
		document.forms[0].action = appUrl+"action/comdynamiccashflow.jsp";
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";	
		document.forms[0].submit();	 
	}
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}

function doPrint()
{
	appno = document.forms[0].appno.value;
	yearfrom=document.forms[0].yearfrom.value;

	if(document.forms[0].identity.value == "")
	{
		var purl = appUrl+"action/comcashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=CA&appno="+appno+"&yearfrom="+yearfrom;
			prop = "scrollbars=yes,width=700,height=450,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";		
	}
	else
	{		
		var purl = appUrl+"action/comcashflowprint.jsp?hidBeanGetMethod=GetCashFlowData&hidBeanId=comformula&flowtype=CA&appno="+appno;
		prop = "scrollbars=yes,width=700,height=550,statusbar=yes";	
			xpos = (screen.width - 700) / 2;
			ypos = (screen.height - 550) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "Print";
	}
	window.open(purl,title,prop);
}

function gototab(beanid,methodname,pagename,flowtype)
{
	document.forms[0].hidBeanId.value=beanid;
	document.forms[0].hidBeanGetMethod.value=methodname;
	document.forms[0].flowtype.value=flowtype;
	document.forms[0].action=appURL+"action/"+pagename;
	document.forms[0].submit();
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=val;		  
		}
	}
}

function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false)
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('exec_notes');
}

function doSave()
{
   <%if(!strCategoryType.equalsIgnoreCase("STL")){%>
	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	<%}%>
	document.forms[0].hidEditMode.value="U";
	document.forms[0].hidBeanMethod.value="updateFincommentsData";
	<%if(strCategoryType.equalsIgnoreCase("STL")){%>
		document.forms[0].hidBeanGetMethod.value="getDateFincommentsData";		
	<%} else {%>
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
	<%}%>
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].hidSourceUrl.value="/action/comdynamiccashflow.jsp";
	document.forms[0].action=appURL+"controllerservlet";		
	document.forms[0].submit();
}
function doDelete()
{
	var con=ConfirmMsg('152');
	if(con)
	{
	<%if(!strCategoryType.equalsIgnoreCase("STL")){%>
	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	<%}%>
	document.forms[0].hidEditMode.value="D";
	document.forms[0].hidBeanMethod.value="updateFincommentsData";
	<%if(strCategoryType.equalsIgnoreCase("STL")){%>
		document.forms[0].hidBeanGetMethod.value="getDateFincommentsData";		
	<%} else {%>
		document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
	<%}%>
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].hidSourceUrl.value="/action/comdynamiccashflow.jsp";
	document.forms[0].action=appURL+"controllerservlet";		
	document.forms[0].submit();
	}
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
	 <%if(!strCategoryType.equalsIgnoreCase("STL")){%>
	 	document.forms[0].hidsel_divID.value=document.forms[0].sel_divID.value;
	 <%}%>
		document.forms[0].hidEditMode.value="";
		<%if(strCategoryType.equalsIgnoreCase("STL")){%>
			document.forms[0].hidBeanGetMethod.value="getDateFincommentsData";		
		<%} else {%>
			document.forms[0].hidBeanGetMethod.value="GetCashFlowData";
		<%}%>
		document.forms[0].hidBeanId.value="comformula";
		document.forms[0].action=appURL+"action/comdynamiccashflow.jsp";	
		document.forms[0].submit();
	 }
}
</script>
</head>
<body onload="onloading()">
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
<form name="frm" method="post" class="normal">
<%if(strCategoryType.equalsIgnoreCase("STL")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan="5">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="11" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class=page_flow>Home -&gt; Corporate &amp; SME -&gt; Short Term Loan  -&gt; Comments -&gt; Cash Flow </td>
	</tr>
</table>
<%}else{ %>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" /></jsp:include>		
<span class="page_flow">Home -&gt;
Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Cash Flow</span><br><%} %>
<span style="display:none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<%if(strCategoryType.equalsIgnoreCase("STL")){ %>
<table width="30%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr>
			<td align="center" class="sub_tab_active">Cash Flow</td>
			 <td align="center" class="sub_tab_inactive">
			    <a href="JavaScript:gototab('comproposal','getSourceOfMargin','com_contlimitcomment.jsp',3)"
				onMouseOut="window.status='';return true;" onMouseOver="window.status='TERM LOAN ASSESSMENT';return true;"> 
            	<b>Term loan assessment</b></a>
             </td>
    </tr>
</table>            
<%} else { %>            
<lapschoice:FinAnalysisTag tabid="2" />
<%} %>
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		<%if(!strCategoryType.equalsIgnoreCase("STL")){ %>		
			 <tr> 
            <td>Financial of :
			     <select name="sel_divID" onchange="getdivval()" >
			         <%String appidval=request.getParameter("appno"); 
			           String name_company=request.getParameter("appname");
			           %>  
			         <option value="0"><%=name_company%></option>
			         <lapschoice:divisionslistid  appid='<%=appidval%>'/>
			     </select>
			     </td>
                 </tr>
			<tr>
				<td>
				<table border="0" cellspacing="0" cellpadding="3" width="100%" class="outertable linebor">
					<tr class="dataheader">
						<%if (totalsize > 0) {%>
						<td width="40%" align="center"><b>Particulars</b></td>
						<%} else {%>
						<%}%>
						<td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[0]%> </b></td>
						<td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[1]%> </b></td>
						<td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[2]%> </b></td>
						<td width="15%" align="center" valign="bottom"><b>&nbsp;<%=strCurrYear[3]%></b></td>
					</tr>
					<tr class="dataheader">
						<td width="40%" align="center">&nbsp;</td>
						<td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[0]%></td>
						<td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[1]%> </td>
						<td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[2]%> </td>
						<td align="center" valign="bottom" width="15%">&nbsp;<%=strCurrFinancialType[3]%> </td>
					</tr>
					<%if (hshValues.size() > 0 && hshValues != null && totalsize > 0) {
				for (int i = 0; i < totalsize; i++) {
					if (hshValues.get("RowType" + Integer.toString(i + 1))
							.equals("HE")) {%>
					<tr class="dataheader">
						<td width="40%"><b><%=hshValues.get("Label"	+ Integer.toString(i + 1))%></b>
						</td>
						<td  valign="bottom" align="center"	width="15%">&nbsp;</td>
						<td  valign="bottom" align="center"	width="15%">&nbsp;</td>
						<td  valign="bottom" align="center"	width="15%">&nbsp;</td>
						<td  valign="bottom" align="center"	width="15%">&nbsp;</td>
					</tr>
					<%} else if (hshValues.get("RowType" + Integer.toString(i + 1)).equals("LTS")) {
					} else {
						vecData = (ArrayList) hshValues.get("vecData" + Integer.toString(i + 1));%>
					<tr class="datagrid">
						<td width="40%"><%=hshValues.get("Label" + Integer.toString(i + 1))%></td>
						<td width="15%" align="right"><%=vecData.get(0)%></td>
						<td width="15%" align="right"><%=vecData.get(1)%></td>
						<td width="15%" align="right"><%=vecData.get(2)%></td>
						<td width="15%" align="right"><%=vecData.get(3)%></td>
					</tr>
					<%}}} else {%>
					<tr class="datagrid">
						<td align="center" colspan="5">NO DATA FOUND&nbsp;&nbsp;&nbsp;&nbsp;</td>
					</tr>
					<%}%>
				</table>
				</td>
			</tr>
<%}%>
			<tr><td>
			<table width="90%" border="0" align="center"></td><tr><td>
			<div id="id_div">
			<div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("exec_notes")) %></div>
			</div>
			<div id="id_editor">
				<textarea name="exec_notes" cols="120" rows="15" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("exec_notes"))%></textarea>
			</div>
			</td></tr></table>
			</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
				<td><%String strYear = Helper.correctNull((String) hshValues.get("yearfrom"));
			if (strYear.equals("")) {
				strYear = "0";
			}
			if (Integer.parseInt(strYear) > 1) {%>
			&lt;&lt; <a	href="javascript:onPrev()"><b>Previous</b></a> <%}%>
			</td>
				<td>&nbsp; <%if ((Integer.parseInt(strYear) + 3) < totnoofyears) {%> 
				<a href="javascript:onNext()"><b>Next</b></a>&gt;&gt; <%}%></td>				
			</tr>
			<%if(strCategoryType.equalsIgnoreCase("STL")){%>
			<tr>
				<td>
					<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</td>
			</tr>
			<%}else{ %>
			<tr>
				<td>
					<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print'  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
				</td>
			</tr>
			<%} %>
		</table>
		</td>
	</tr>
</table>
</div>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="yearfrom" value="<%=hshValues.get("yearfrom")%>"> 
<input type="hidden" name="flowtype" value="CA">
<input type="hidden" name="totvalue" value=""> 
<input type="hidden" name="uptovalue" value=""> 
<input type="hidden" name="fromvalue" value=""> 
<input TYPE="hidden" value="10" name="hidTotal"> 
<input TYPE="hidden" value="" name="identity"> 
<input type="hidden" name="access" value="B"> 
<input type="hidden" name="hidcmano1" value="<%=strcmaindex%>">
  <input type="hidden" name="hidsel_divID"> 
  <INPUT TYPE="hidden" name="hidEditMode"  value="<%=Helper.correctNull((String)hshValues.get("hidEditMode"))%>">
</form>
</body>
<!--<script language="javascript1.2">editor_generate('exec_notes');</script>-->
</html>
