<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strBATypeWC		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg"));
String strConsTypeWC	= Helper.correctNull((String)hshValues.get("com_wc_type"));
String strBATypeTL		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg"));
String strConsTypeTL	= Helper.correctNull((String)hshValues.get("com_tl_type"));
%>

<html>
<head>
<title>Commercial-Principal (s)</title>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";


function doSave()
{
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="bankapp";
	document.forms[0].hidSourceUrl.value="/action/com_bankingdetails.jsp";
	document.forms[0].hidBeanMethod.value="updateBankingdetailsData";
	document.forms[0].hidBeanGetMethod.value="getBankingdetailsData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=valdel;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,false,false,false,true);
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_arrearcmt');
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankapp";
		document.forms[0].hidBeanGetMethod.value="getBankingdetailsData";
		document.forms[0].action=appURL+"action/com_bankingdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
}
function doDelete()
{
	
		if(ConfirmMsg(101))
		{
			
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="bankapp"
			document.forms[0].hidBeanMethod.value="updateBankingdetailsData";	
			document.forms[0].hidBeanGetMethod.value="getBankingdetailsData";		
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="action/com_bankingdetails.jsp";
			document.forms[0].submit();
		}

}
function onloading()
{
	disableFields(true);
	EditorEnableDisable("id_div","block","id_editor","none");
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}

</script>
<style>
.selectwidth
{
	width: 150px;
}
</style>
</head>
<body onLoad="onloading();">
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
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
  %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
			<jsp:param name="subpageid" value="104" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
          <tr align="center">
          
       		<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_active"><b>Asset Classification / Comments on Arrears</b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
			<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">
					Consortium Details for TL
			</a></b></td>
			<%}}%>
			
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
			<%if(strBATypeTL.equalsIgnoreCase("M")){%> 
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">
					Multiple Banking Details for TL
			</a></b></td>
			<%}} %>
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){ %>
			<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">
					Consortium Details for WC
			</a></b></td>
			<%} }%>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){ %>
			<%if(strBATypeWC.equalsIgnoreCase("M")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">
					Multiple Banking Details for WC
			</a></b></td>
			<%} }%>
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&(strBATypeWC.equalsIgnoreCase("C")||strBATypeWC.equalsIgnoreCase("M"))){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getMultipleBanking','com_multipleBanking.jsp')">
						Existing and Proposed Exposure
			</a></b></td>
			<%} %>
					
        </table>
<%}else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top" colSpan="5"><jsp:include
					page="../share/applurllinkscom.jsp" flush="true">
					<jsp:param name="pageid" value="3" />
					<jsp:param name="cattype" value="<%=strCategoryType%>" />
					<jsp:param name="ssitype" value="<%=strSSIType%>" />
				</jsp:include></td>
			</tr>
			<%if (strCategoryType.equalsIgnoreCase("SRE")) {%>
			<tr>
				<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short
				Review/Extension -&gt; Banking Arrangement -&gt; Banking Details</td>
			</tr>

			<%} else {

			%>
			<tr>
				<td class="page_flow">Home
				-&gt; Corporate &amp; SME -&gt; Application-&gt; Banking Arrangement
				-&gt; Banking Details</td>
			</tr>
			<%}

			%>
		</table>
		</td>
	</tr>
</table>

<span style="display:none;"> <lapschoice:borrowertype /> </span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable"  width="60%">
			<tr align="center">
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
				<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_active"><b>Asset Classification / Comments on Arrears</b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'compro','getFinancialComments','com_bankcomments.jsp')">Other Comments</a></b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
		  <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingArrangement','comBankingArrgnmentNew.jsp')">Banking Arrangement</a></b></td>
		 
		  <%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
		  	<%if(strBATypeTL.equalsIgnoreCase("C")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Consortium Details for TL
			</a></b></td>
			<%}} %>
			<%if((!strBATypeTL.equalsIgnoreCase("")||!strConsTypeTL.equalsIgnoreCase(""))&&!strBATypeTL.equalsIgnoreCase("S")){ %>
			<%if(strBATypeTL.equalsIgnoreCase("M")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsDataTL','com_BAConsortium_TL.jsp')">Multiple Banking Details for TL
			</a></b></td>
			<%}} %>
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>
			<%if(strBATypeWC.equalsIgnoreCase("C")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Consortium Details for WC
			</a></b></td>
			<%}} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&!strBATypeWC.equalsIgnoreCase("S")){%>
			<%if(strBATypeWC.equalsIgnoreCase("M")){ %>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getBAConsData','com_BAConsortium.jsp')">Multiple Banking Details for WC
			</a></b></td>
			<%}} %>
			
			<%if((!strBATypeWC.equalsIgnoreCase("")||!strConsTypeWC.equalsIgnoreCase(""))&&(strBATypeWC.equalsIgnoreCase("C")
					||strBATypeWC.equalsIgnoreCase("M"))){%>
			<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankapp','getMultipleBanking','com_multipleBanking.jsp')">
						Existing and Proposed Exposure
			</a></b></td>
			<%} %>
				</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="90%" border="0" cellspacing="0" cellpadding="0" class="outertable border1" align="center">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr>
							<td>Asset Classification</td>
										<td> <%String sel_assetclass = Helper.correctNull((String)hshValues.get("COM_ASSETCLASS"));%>
											<select name="sel_assetclass">
											<%if (sel_assetclass.equalsIgnoreCase("0")) {%>
											 <option selected value="0">--select--</option> 
											  <%} 
											else {%> 
											  <option value="0">--select--</option> <%}

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

										<option value="L">Loss</option> <%}
											%> 
												
											</select>
										</td>
										<td>Asset Classification as on</td>
										<td><table width="100%" border="0">
											<tr>
												<td width="21%"><input type="text" name="txt_assdate"
													size="16"
													onBlur="checkDate(this);checkmaxdate(this,currdate);"
													value="<%=Helper.correctNull((String) hshValues.get("com_asscladate"))%>">
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
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table></td></tr>
				</table>
						
				</td></tr></table>
					<table width="90%" border="0" cellspacing="1" cellpadding="5" class="outertable" align="center">
									<tr><td>&nbsp;</td></tr>
									
									<tr class="dataheader"> 
									<td nowrap="nowrap"> Comment on Arrears</td>
									 </tr>
									 
   <tr class="datagrid"> 
  
									<td>
            <div id="id_div"><div class="EditorClassNew"> <%=Helper.correctNull((String)hshValues.get("COM_ARREARCMT")) %></div></div>
             <div id="id_editor"> <textarea name="txt_arrearcmt" cols="200 rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)">
         		     <%=Helper.correctNull((String)hshValues.get("COM_ARREARCMT")) %>
              </textarea></div>
            </td>
								</tr>
		
		</table>
		<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel"
								btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' /><br>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidflag" value=""> 
<input type="hidden" name="selsno" value=""> 
<input type="hidden" name="hidval"> 
<input type="hidden" name="hiddesc"> 
<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>"> 
<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>"> 
<input type="hidden" name="otherGenTable" value=""> 
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="tot_netlmtfundexist" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtfundexist"))%>">
<INPUT TYPE="hidden" NAME="tot_netlmtfundprop" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtfundprop"))%>">
<INPUT TYPE="hidden" NAME="tot_netnonlmtfundexist" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtnonfundexist"))%>">
<INPUT TYPE="hidden" NAME="tot_netnonlmtfundprop" VALUE="<%=Helper.correctDouble((String)hshValues.get("netlmtnonfundprop"))%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>">
<input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
<input type="hidden" name="idno" value="">
<input type="hidden" name="type" value="W">
<input type="hidden" name="hidFacSNo" value="">
 <iframe height="0" width="0" id="ifrFacilityDesc" frameborder="0" style="border:0" ></iframe>
<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
<iframe height="0" width="0" id="ifrm"
	frameborder="0" style="border:0"></iframe>
</form>
</body>
</html>
