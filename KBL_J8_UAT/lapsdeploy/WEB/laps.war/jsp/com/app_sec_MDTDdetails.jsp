<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%String strSessionModule="";
 strSessionModule=Helper.correctNull((String)session.getAttribute("sessionModuleType")); %>
<%
String strpagetype = Helper.correctNull((String) hshValues.get("page"));
String strFreezeflag =Helper.correctNull((String)session.getAttribute("strFrzfalgnew")).trim();

String strAppno=Helper.correctNull((String)request.getParameter("appno"));
String app_secid=Helper.correctNull((String) hshValues.get("app_secid"));

String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid = Integer.parseInt(Helper.correctInt(request.getParameter("linkid")));


%>
<html>
<head>
<title>Comments</title>
<script>
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var btnenable="<%=Helper.correctNull((String) request.getParameter("btnenable"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var secid="<%=app_secid%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		window.close();
	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{
			document.forms[0].cmdedit.disabled=true;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	}
	else if(val=="loadvalue")
	{
			document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=false;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	}
	else if(val=="edit")
	{
	  	document.forms[0].cmdedit.disabled=true;
	  	document.forms[0].cmddelete.disabled=true;
	  	document.forms[0].cmdsave.disabled=false;
	  	document.forms[0].cmdcancel.disabled=false;
	  	document.forms[0].cmdclose.disabled=false;
	    disableFields(false);
	}
}

function onLoading()
{
	 disableFields(true);
	 EditorEnableDisable("id_div","block","id_editor","none");

	 if(document.forms[0].btnenable.value=="Y")
	 {
		 if(secid!="")
		 {
			 document.forms[0].app_secid.value=secid;
			 disableCommandButtons("loadvalue");
		 }
		 else
		 {
			 disableCommandButtons("load");
		 }
	 }
	 if(secid!="")
	 {
		 document.forms[0].app_secid.value=secid;
	 }
}

function doEdit()
{
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txtarea_comments');
	document.forms[0].app_secid.disabled=true;
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

function doSave()
{
		document.forms[0].app_secid.disabled=false;
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateMDTDAttachedsec";
		document.forms[0].hidBeanGetMethod.value="getMDTDattachedSec";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/app_sec_MDTDdetails.jsp";
		document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].app_secid.disabled=false;
		document.forms[0].hidBeanGetMethod.value="getMDTDattachedSec";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg('101'))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateMDTDAttachedsec";
		document.forms[0].hidBeanGetMethod.value="getMDTDattachedSec";
		document.forms[0].hidSourceUrl.value="/action/app_sec_MDTDdetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function callLink1(page,bean,method)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
 	 document.forms[0].hidAction.value="";
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
		return;
	}
}

function getSecdetails()
{
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanGetMethod.value="getMDTDattachedSec";
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
</script>
</head>
<body onLoad="onLoading()">
<form name="comments" method="post" class="normal">

 <%if(strSessionModule.equals("RET") || strSessionModule.equals("DIGI")) { %>
 
<% if(strSessionModule.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application  -&gt; Security Master -&gt; MDTD</td>
	</tr>
</table>
<% } else { %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; MDTD</td>
	</tr>
</table>
<% } %>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
           <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
       
            <%if(strSessionModule.equals("RET") || strSessionModule.equals("DIGI") ){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
        
        
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_active"><b>MDTD</b></td>
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitynewtab.jsp','bankappfi','getlegalopinionverification')">Legal opinion verification</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
 
 <%}else{ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModule.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt;  Security Master -&gt; MDTD </td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application  -&gt; Security Master -&gt; MDTD</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="102"/>
			<jsp:param name="Freezeflag" value="<%=strFreezeflag%>" />
		</jsp:include>
		</td>
	</tr>
</table>
 <%} %>

<table width="98%" border="0" cellpadding="3" cellspacing="3" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable border1" align="center">
		<tr align="center"> 
		
			<td valign="top">Security ID : <select
													name="app_secid" style="width: 150"
													onchange="getSecdetails()">
													<option value="">--Select--</option>
													<lapschoice:SecurityAttachedtoProposal appno="<%=strAppno %>"/>
													</select>
			</td>	
		</tr>
		<tr>
		 	<td>
		 		<table width="100%" border="0" cellpadding="2" cellspacing="1" class="outertable" align="center">
		 			<tr class="dataheader">
		 				<td> Security Owner name </td>
		 				<td> Security value </td>
		 				<td> Security Type </td>
		 			</tr>
		 			<tr class="datagrid">
		 				<td> <%= Helper.correctNull((String) hshValues.get("ownername")) %> </td>
		 				<td> <%= Helper.correctNull((String) hshValues.get("APP_SEC_SECURITYVALUE")) %> </td>
		 				<td> <%= Helper.correctNull((String) hshValues.get("SEC_NAME")) %> </td>
		 			</tr>
		 		</table>
		 	</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
					<tr class="dataheader">
						<td>Comments</td>
					</tr>
					
					<tr>
					<td>
					  <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("MDTD_COMMENTS")) %></div></div>
	                 <div id="id_editor"> <textarea name="txtarea_comments" cols="150" rows="12" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
	         		     <%=Helper.correctNull((String)hshValues.get("MDTD_COMMENTS")) %>
	                 </textarea></div>
					</td></tr>
					<tr><td>&nbsp;</td></tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
</table>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidCommentPage" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<input type="hidden" name="hidAppNo" value="<%=strAppno%>">
<input type="hidden" name="hidPageType" value="<%=Helper.correctNull((String)request.getParameter("hidCommentPage"))%>">
<INPUT TYPE="hidden" name="hidDemoId"	value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
<input type="hidden" name="hidPage">
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="hpage">
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)request.getParameter("hidValuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)request.getParameter("hidHouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)request.getParameter("hidVehicleEdit_Flag"))%>">
</form>
</body>
</html>