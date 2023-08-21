<%@include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");
session.removeAttribute("cattype");
String strSessionModuleType="";
strSessionModuleType=Helper.correctNull((String)request.getParameter("hidCategoryType"));
if(strSessionModuleType.equalsIgnoreCase("")){
	strSessionModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
}
session.setAttribute("sessionModuleType",strSessionModuleType);
String strModuleType="",strModuleDesc="";
strModuleType=Helper.correctNull((String)request.getParameter("hidCategoryType"));
if(strModuleType.equalsIgnoreCase(""))
{
	strModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));	
}
if(strModuleType.equalsIgnoreCase("CORP"))
{
	strModuleDesc="Corporate & SME";
}
else
{
	strModuleDesc="Agriculture";
}

%>
<HTML>
<HEAD>
<TITLE>Laps Corporate Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename,pagetype)
{
	document.forms[0].workflow.value="N";	
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callFunctionTM(pagename)
{
	document.forms[0].hidBeanId.value="agrcommon"
	document.forms[0].hidBeanGetMethod.value="getAgr_targetmastedate";	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}



function doClose()
{
	document.forms[0].action = appURL+"action/mainnav.jsp";
	document.forms[0].submit();
}
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style_tab.css" type="text/css">
</HEAD>
<BODY>
<jsp:include page="../share/sessionmaintaince.jsp" flush="true"/>
<form name="navigation" class="normal">
<br>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<TABLE width="25%" BORDER="0" CELLSPACING="0" CELLPADDING="4" class="outertable">
			<tr>
		<td>&nbsp;</td>
	</tr>
			<TR>
                <%if (grpRights.charAt(11) == '1'
					&& grpRights.charAt(18) == 'w'
					&& (strOrgLevel.equals("A")||strOrgLevel.equals("C") || (strOrgLevel.equals("D") && Helper.correctNull((String)session.getAttribute("strRLPFUser")).equalsIgnoreCase("012")))) {%>
               <TD class="menubackflow"><b><A HREF="javascript:txtLoad('<%=strModuleDesc %>');callFunction('comborrowersearch.jsp','NEW')">New Proposal</A></b></TD>                
               <%} else {%><td class="disabledmenu">New Proposal<%}%></TD>
			</TR>
			<TR><%if (grpRights.charAt(11) == '1') {%>
                <TD class="menubackflow"><b><A HREF="javascript:txtLoad('<%=strModuleDesc %>');callFunction('comborrowersearch.jsp','EXI')">Existing Proposal</A></b></TD> 
                <%} else {%><td class="disabledmenu">Existing Proposal<%}%></TD>
			</TR>
			<%if(!strModuleType.equalsIgnoreCase("CORP")){ %>
			<TR><%if (grpRights.charAt(11) == '1') {%>
                <TD class="menubackflow"><b><A HREF="javascript:txtLoad('<%=strModuleDesc %>');callFunctionTM('agr_targetmaster.jsp')">Target Master</A></b></TD> 
                <%} else {%><td class="disabledmenu">Target Master<%}%></TD>
			</TR>
			<%} %>
			
			<TR> 
                <TD class="menubackflow"><b><A HREF="javascript:txtLoad('<%=strModuleDesc %>');callFunction('querySearch_dev.jsp','Query')">Query / Reply</A></b></TD> 
			</TR>
			
		<!--  	<TR>
                <%if (grpRights.charAt(12) == '1') {%>
                <TD class="menubackflow"><b><a href="javascript:txtLoad('<%=strModuleDesc %>');callFunction('comborrowersearch.jsp','PROP')">Proposal</a></b></td>
                <%} else {%><td class="disabledmenu">Proposal<%}%></TD>
			</TR>-->
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR>
				<%if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
				if (grpRights.charAt(11) == '1') {%> 
				<TD class="menubackflow"><A HREF="javascript:txtLoad('Broad Terms of Proposal');callFunction('combstpge.jsp','BST')"> Broad Terms of Proposal</A></b> 
				<%} else {%><td class="disabledmenu"> Broad Terms of Proposal <%}}%></TD>
			</TR>
			<TR>
				<%if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
				if (grpRights.charAt(11) == '1') {%> 
				<TD class="menubackflow"><A HREF="javascript:txtLoad('Modifications in Sanction Terms');callFunction('comborrowersearch.jsp','MST')"> Modification in Sanction Terms</A></b> 
				<%} else {%><td class="disabledmenu"> Modification in Sanction Terms <%}}%></TD>
			</TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
            <TR>
                  <%
                  if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
                  if(grpRights.charAt(11) == '1'){%>
                  <TD class="menubackflow"><b><A HREF="javascript:txtLoad('ADHOC LIMIT');callFunction('comborrowersearch.jsp','ADC')" >Ad hoc Limit </A></b></td>
                  <%}else{%><td class="disabledmenu">Ad hoc Limit<%}}%></TD>
          </TR>            
             <TR>
                  <%
                  if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
                  if(grpRights.charAt(11) == '1'){%>
                  <TD class="menubackflow"><b><A HREF="javascript:txtLoad('Short Review/Extension');callFunction('comborrowersearch.jsp','SRE')" >Short Review/Extension </A></b></td>     
                  <%}else{%><td class="disabledmenu">Short Review/Extension<%}}%></TD>
                </TR>
			<TR>
                    <%
                    if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
                    if(grpRights.charAt(11) == '1'){%>
                    <TD class="menubackflow"><b><A HREF="javascript:txtLoad('Short Term Loan');callFunction('comborrowersearch.jsp','STL')" >Short Term Loan </A></b></td>
                    <%}else{%> <td class="disabledmenu">Short Term Loan<%}}%></TD>
                </TR>
			<TR>
				<TD>&nbsp;</TD>
			</TR>
			<TR>
				<%
				if(!((strModuleType.equalsIgnoreCase("CORP")) || (strModuleType.equalsIgnoreCase("AGR")))){
				if ((grpRights.charAt(11) == '1' && grpRights.charAt(18) == 'w'
					&& strOrgLevel.equals("A")) || (grpRights.charAt(11) == '1' && grpRights.charAt(18) == 'w' && strOrgLevel.equals("D") && strIsSaral.equalsIgnoreCase("Y"))) {%> 
					<TD class="menubackflow"><a href="javascript:txtLoad('Corporate & SME');callFunction('comappmastersearch.jsp','UPL')">Upload </a></b></td> 
					<%} else {%> <td class="disabledmenu">Upload  <%}}%></TD>
			</TR>

		</TABLE>
		</td>
		</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td class="darkbandcolor">&nbsp;</td>
	</tr>
	<tr>
		<td class="lightbandcolor">&nbsp;</td>
	</tr>
</table><br>
<lapschoice:combuttonnew btnenable=''/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidusr_id"> 
<input type="hidden" name="hidPageType" value=""> 
<input type="hidden" name="hidMethod"> 
<input type="hidden" name="workflow"> 
<INPUT TYPE="hidden" NAME="hdnfld">
<INPUT TYPE="hidden" NAME="hid_categorytype" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<INPUT TYPE="hidden" NAME="hid_moduletype" value="">
<input type="hidden"" name="hidCategoryType" value="<%=strModuleType%>"> 
</form>
</BODY>
</HTML>
