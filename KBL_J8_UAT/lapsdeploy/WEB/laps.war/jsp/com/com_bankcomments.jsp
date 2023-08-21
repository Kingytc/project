<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strBATypeWC		= Helper.correctNull((String)session.getAttribute("com_wc_bnkarg"));
String strConsTypeWC	= Helper.correctNull((String)session.getAttribute("com_wc_type"));
String strBATypeTL		= Helper.correctNull((String)session.getAttribute("com_tl_bnkarg"));
String strConsTypeTL	= Helper.correctNull((String)session.getAttribute("com_tl_type"));
%>
<html>
<head>
<title>Bank comments</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var selcomments="<%=Helper.correctNull((String) hshValues.get("selcoment"))%>";
var appno="<%=request.getParameter("appno")%>";

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].hidBeanId.value="compro";
    document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].hidSourceUrl.value="action/com_bankcomments.jsp";	
	document.forms[0].action=appURL+"action/controllerservlet";	
	document.forms[0].submit();
}
function doSave()
{ 	
	if(document.forms[0].sel_commentstype.value =="s")
	{
		alert("Please Select comment on");
		document.forms[0].sel_commentstype.focus();
		document.forms[0].txt_comments.value="";
		EditorEnableDisable("id_div","block","id_editor","none");
		return;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updateFinancialComments";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_bankcomments.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
		}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	if(selcomments=="")
	{
		document.forms[0].sel_commentstype.value="s";
	}
	else
	{
		document.forms[0].sel_commentstype.value=selcomments;
		
	}				
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
	  
	}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updateFinancialComments";
		document.forms[0].hidBeanGetMethod.value="getFinancialComments";
		document.forms[0].action=appURL+"action/com_bankcomments.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getCollData()
{
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getFinancialComments";
	document.forms[0].action=appURL+"action/com_bankcomments.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
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
<body onLoad="onLoading()">
<form method = post class="normal">
		 <%if(strCategory.equalsIgnoreCase("RET")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt;  Retail -&gt; Application -&gt; Banking Arrangement -&gt; Existing Banking Details </td>
    </tr>
  </table>
  <%}
	 else
	 { %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan="5">
					<jsp:include page="../share/applurllinkscom.jsp" flush="true">
		        	<jsp:param name="pageid" value="3" />
		        	<jsp:param name="cattype" value="<%=strCategoryType%>" />
		        	<jsp:param name="ssitype" value="<%=strSSIType%>" /></jsp:include>
		       </td>
	    </tr>
	</table>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	 <%if (strSessionModuleType.equalsIgnoreCase("AGR")) {
			%>
			<tr>
				<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Banking Arrangement -&gt; Comments</td>
			</tr>
			<%
			}else if(strCategoryType.equalsIgnoreCase("SRE"))
		{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Banking Arrangement -&gt; Comments</td>
	</tr>
	
	<%} else {
				%>
	<tr>
		<td class="page_flow">
	   Home	-&gt; Corporate &amp; SME -&gt; Application -&gt; Banking Arrangement -&gt; Comments<%} %>	</td>
	  </tr>
	</table>
	<%} %>
  <span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		 <%if(strCategory.equalsIgnoreCase("RET")){   %> 
		  <table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_active" id="prin" nowrap><b>Existing  Banking Details </b></td>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Guarantor / Group concern</a></b></b></td>
			</tr>
			</table>
		 <%}else { %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td><table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
          <tr align="center">
          
          <td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
          <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>
          <td  width="15%" nowrap align="center" class="sub_tab_active"><b>Other Comments</b></td>
		  <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
		  <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
		 
		  <%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
			
					<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
					<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Consortium Details for TL</a></b></td>
					<%}else if(strBATypeTL.equalsIgnoreCase("M")){ %> 
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Multiple Banking Details for TL</a></b></td>
					<%} %>
			
			<%}if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>

					<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
					<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC</a></b></td>
					<%}else if(strBATypeWC.equalsIgnoreCase("M")){ %> 
					<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC</a></b></td>
					<%} %>
			
			<%} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&(strBATypeWC.equalsIgnoreCase("C")
					||strBATypeWC.equalsIgnoreCase("M"))){%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getMultipleBanking','com_multipleBanking.jsp')">
						Existing and Proposed Exposure
			</a></b></td>
			<%} %>
       </tr>
        </table></td>
    </tr>
  </table>
  <%} %>
  </td>
  </tr>
  </table>
<br>
 <table width="98%" align="center" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
<tr>
<td>
<br>
    <table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
  <tr> 
    <td width="20%" nowrap="nowrap"><b>Comments On <span class="mantatory">*</span></b>&nbsp;
    <select name="sel_commentstype" tabindex="1" onchange="getCollData()">
		<option value="s" selected>----select----</option>
		<option value="1">Performance</option>
		<option value="2">Credit Information Report</option>
		<option value="3">Confidential Opinion</option>
		</select>
    </td>
  </tr>  
  <tr><td>&nbsp;</td> </tr>  
  <tr class="dataheader"> 
    <td width="20%"> Comments</td>
    </tr>
   <tr class="datagrid"> 
    <td width="60%"> 
      <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("comments")) %></div></div>
					 <div id="id_editor">
				
      <textarea name="txt_comments" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("comments"))%></textarea></div>
 </td>
 </tr>
 </table>
  <br>

 </td>
 </tr>
 </table>
 <br> 
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete_Audit Trail'/>
<input type="hidden" name="hidPage" value="bankcomments">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<br>
</form>
</body>
</html>