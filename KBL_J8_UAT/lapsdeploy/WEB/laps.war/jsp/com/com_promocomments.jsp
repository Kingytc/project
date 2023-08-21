<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strgroup = "";
if (!strCategoryType.equalsIgnoreCase("")) {
	if (strCategoryType.equalsIgnoreCase("CORP")
			|| (strCategoryType.equalsIgnoreCase("SME"))) {
		strgroup = "Promoters";
	} else if (strCategoryType.equalsIgnoreCase("SSI")) {
		strgroup = "Banking Arrangement";
	}
}
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Comments</title>
<script type="text/javascript">
var currdate = "<%=Helper.getCurrentDateTime()%>";
function callLink(page,bean,method)
{
  
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	
}


function getValues()
{
	if(document.forms[0].cho_promoter.selectedIndex>0)
	{
		document.forms[0].hidAction.value="get"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getgroupcomments";
		document.forms[0].action=appURL+"action/com_promocomments.jsp";
		document.forms[0].submit();
	}
	else
	{
		clearFields();
		enableButtons(false,true,true,true,true,false);
		disablefields(true);
	}
}
function doSave()
{
	/*if(document.forms[0].fname.value=="")
	{
		alert("Enter Full Name");
		return false;
	}
	if(document.forms[0].selemp.value=="S" || document.forms[0].selemp.value=="")
	{
		alert('Select Gender');
		return;
	}
	if(document.forms[0].Type.options[2].selected==true)
	{
		if(document.forms[0].held.value=="")
		{
			alert('Enter Shares Held');
			return;
		}
	}	
	if(document.forms[0].txt_relationship.value=="")
	{
			alert('Enter Relationship with the Applicant');
			document.forms[0].txt_relationship.focus();
			return;
	}*/
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].cho_promoter.disabled=false;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanMethod.value="updategroupcomments";
	document.forms[0].hidBeanGetMethod.value="getgroupcomments";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_promocomments.jsp";
	document.forms[0].submit();	
}
function doDelete()
{
	if(ConfirmMsg(101))
 	{
		document.forms[0].cho_promoter.disabled=false;
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updategroupcomments";
		document.forms[0].hidBeanGetMethod.value="getgroupcomments";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_promocomments.jsp";
		document.forms[0].submit();
    }
	else
	{
		ShowAlert(158);
	}
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
function onLoading()
{
	var val="<%=Helper.correctNull((String) hshValues.get("com_compdtappid"))%>";
	if(val !="")
	{
		document.forms[0].cho_promoter.value = val;
		if(document.forms[0].btnenable.value=="Y")
		{
			enableButtons(false,true,true,true,false);
		}
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
	var val1="<%=Helper.correctNull((String) hshValues.get("COM_COMMENTSTYPE"))%>";
	if(val1!="")
	{
		document.forms[0].sel_commentstype.value=val1;
	}
	disablefields(true);
	EditorEnableDisable("id_div","block","id_editor","none");
}

function enableButtons(bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doEdit()
{
	disablefields(false);
	document.forms[0].hidAction.value="update";
	enableButtons(true,false,false,false,true);
	document.forms[0].cho_promoter.disabled=true;
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_comments');
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidAction.value="get"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].hidBeanMethod.value="getValues";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/com_promocomments.jsp";
		document.forms[0].submit();

	 }
	
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}


function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	document.forms[0].cho_promoter.disabled=false;
}
function getCollData()
{
	disablefields(false);
	document.forms[0].cho_promoter.disabled=false;
	document.forms[0].hidBeanId.value="compro";
	document.forms[0].hidBeanGetMethod.value="getgroupcomments";
	document.forms[0].action=appURL+"action/com_promocomments.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>
</head>
<body onload="onLoading()">
<form name="frmpri" method="post" class="normal">
	 <%if(strCategory.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Banking Arrangement-&gt;Comments </td>
    </tr>
  </table>
  <%}
	 else
	 { %>
	<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">
		<%
			if (strCategoryType.equalsIgnoreCase("SRE")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Review/Extension -&gt;
		Comments <%
			} else if (strCategoryType.equalsIgnoreCase("STL")) {
		%> Home -&gt;Corporate &amp; SME -&gt; Short Term Loan -&gt; Comments
		 <%
			} else if(strSessionModuleType.equalsIgnoreCase("AGR")){
		%> Home -&gt; Agriculture -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; <%=strgroup%>
		Comments<%
 	}else
 	{%>
 		Home -&gt; Corporate &amp; SME -&gt; Application-&gt;Co-Applicant / Guarantor-&gt; <%=strgroup%>-&gt;Comments
 	<%}
 %>
		</td>
	</tr>
</table>
<%} %>
<span style="display: none;"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	align="center" class="outertable">
	<tr align="center">
		<td valign="bottom">
		 <%if(strCategory.equalsIgnoreCase("RET")){ 
		 %> 
		 <table border="0" cellspacing="2" cellpadding="3"
			align="left" class="outertable">
			<tr>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('combankingfi.jsp','bankappfi','getData')">  Existing  Banking Details</a></b></b></td>
		    <td class="sub_tab_active" id="prin" nowrap><b>  Guarantor / Group concern </b></td>
			</tr>
			</table>
		 <%}else { %>
		<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
				<td class="sub_tab_inactive" id="prin"><b> <a
					href="#" onclick="javascript:callLink('compromoters.jsp','compro','getProData')">Co-Applicant / Guarantor
				</a></b></td>
				<%
					if (strCategoryType.equalsIgnoreCase("CORP")
							|| strCategoryType.equalsIgnoreCase("SME")) {
				%>
				<!-- <td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('com_companybackground.jsp','compro','getCompanyBackground')">Promoter
				Company / Group Companies Background</a></b></b></td> -->
				<% } %>
				<td class="sub_tab_inactive" nowrap><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')">Share Holding Pattern</a></b></b></td>
				<td class="sub_tab_active" nowrap="nowrap"><b><b>Comments</b></b></td>
			</tr>
		</table>
		<%} %>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td align="center">
		<table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable">
		<tr>
				<td align="center">Select Principal <span
						class="mantatory"><b>*</b></span>&nbsp;
					<select name="cho_promoter" tabindex="1" size="1" style="width: 150" onChange="javascript:getValues()">
						<%String appidval = request.getParameter("appno");
							String strcompanyname = request.getParameter("appname");
											%>
				                                  <option value="">&lt;---select---&gt;</option>
				                                  <lapschoice:divisionslistid appid="<%=appidval%>" />
				                            </select>
						</td>
			</tr>
			<tr>
			<td align="center">
			<table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable">
			<tr>
					<td>Asset Classification</td>
					<td> <%String sel_assetclass = Helper.correctNull((String)hshValues.get("COM_ASSETCLASS"));%>
							<select name="sel_assetclass" tabindex="2">
							<%if (sel_assetclass.equalsIgnoreCase("0")) {%>
							 <option selected value="0">--select--</option> 
							  <%} 
							else {%> 
							  <option value="0">--Select--</option> <%}
		
					 if (sel_assetclass.equalsIgnoreCase("S"))  {%>
		
						 <option selected value="S">Standard</option> 
						 <%}
					 else {%> 
					  <option value="S">Standard</option> <%}
		
					 if (sel_assetclass.equalsIgnoreCase("SS"))  {%>
		
						<option selected value="SS">Sub Standard</option> <%}
					 else {%> 
					  <option value="SS">Sub Standard</option> <%}
						 if (sel_assetclass.equalsIgnoreCase("D"))  {%>
		
						<option selected value="D">Doubtful</option> <%}
						 else {%> 
						  <option value="D">Doubtful</option> <%}
						 if (sel_assetclass.equalsIgnoreCase("L"))  {%>
		
							<option selected value="L">Loss</option> <%}
						else {%>
		
						<option value="L">Loss</option> <%}%> 
						</select>
					</td>
					<td>Asset Classification as on </td>
					<td><table width="100%" border="0">
					<tr>
						<td width="21%"><input type="text" name="txt_assdate"
							size="16"
							onBlur="checkDate(this);checkmaxdate(this,currdate);"
							value="<%=Helper.correctNull((String) hshValues.get("com_asscladate"))%>" tabindex="3">
						</td>
						<td width="79%"><a alt="Select date from calender"
							href="#" onClick="callCalender('txt_assdate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
							border="0" alt="Select date from calender"></a></td>
					</tr>
					</table></td>
				</tr>
				<tr>
					<td>Comments On <span class="mantatory">*</span></td>
					<td>
    					<select name="sel_commentstype" tabindex="4" onchange="getCollData()">
						<option value="s" selected>----select----</option>
						<option value="1">Performance</option>
						<option value="2">Credit Information Report</option>
						<option value="3">Confidential Opinion</option>
						<option value="4">Arrears</option>
						</select>
					</td>
					<td colspan="2">&nbsp;</td>
				</tr>
				<tr class="dataheader"><td colspan="4">Comments:</td></tr>
				<tr><td colspan="4">	
      				<div id="id_div"><div class="EditorClassNew" style="text-align: left;"><%=Helper.correctNull((String)hshValues.get("com_groupcomments")) %></div></div>
      				<div id="id_editor">
	  				<textarea name="txt_comments" cols="100"  rows="8" tabindex="2" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_groupcomments"))%></textarea>
	  				</div>
 			</td></tr>
				</table>
				</td></tr>
		</table>
		</td>
	
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
 <iframe height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe>
</form>
</body>
</html>