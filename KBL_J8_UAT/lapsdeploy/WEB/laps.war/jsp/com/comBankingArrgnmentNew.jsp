<%@include file="../share/directives.jsp"%>
<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));	

String strBATypeWC		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg1"));
String strConsTypeWC	= Helper.correctNull((String)hshValues.get("com_wc_type1"));
String strBATypeTL		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg1"));
String strConsTypeTL	= Helper.correctNull((String)hshValues.get("com_tl_type1"));

String strAppno = Helper.correctNull((String) hshValues.get("appno"));
String strBAtype=Helper.correctNull((String)hshValues.get("com_ba_type"));
%>
<html>
<head>
<title>Banking Arrangement</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/com/comBankingArrgnmentNew.js"> </script>
<script>
var appno="<%=request.getParameter("appno")%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varBAtype="<%=strBAtype%>";
var varproposedtype="<%=Helper.correctNull((String)hshValues.get("bankingarrangement"))%>";
function onloading()
{
	
	if(varBAtype!="")
	{
		document.forms[0].sel_Type.value=varBAtype;
	}else{
		document.forms[0].sel_Type.value="S";
	}
	if(varproposedtype=="Y"){
		document.forms[0].sel_Type.value="O"
	}
	selValues();
	
	document.forms[0].txt_bnk_arg.value= "<%=Helper.correctNull((String)hshValues.get("com_wc_bnkarg"))%>";
	document.forms[0].txt_bnk_arg_TL.value= "<%=Helper.correctNull((String)hshValues.get("com_tl_bnkarg"))%>";
	OnBankArgChanged();
	OnBankArgChangedTL();
	document.forms[0].txt_bnk_type.value= "<%=Helper.correctNull((String)hshValues.get("com_wc_type"))%>";
	document.forms[0].txt_bnk_type_TL.value= "<%=Helper.correctNull((String)hshValues.get("com_tl_type"))%>";
	OnBnkTypeChanged();
	OnBnkTypeChangedTL();
	document.forms[0].txt_no_consortium.value= "<%=Helper.correctNull((String)hshValues.get("com_wc_no"))%>";
	document.forms[0].txt_no_consortium_TL.value= "<%=Helper.correctNull((String)hshValues.get("com_tl_no"))%>";
	disableFields(true);
	if(appstatus=="Open/Pending")
	{
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	     disableCommandButtons(false,true,true,true,false,false);
	}
	else
	{
		disableCommandButtons(true,true,true,true,false,false);
	}
	}
	else
	{
		disableCommandButtons(true,true,true,true,false,false);
	}
	
}

function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankArgmnt_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
function selValues()
{
	if(document.forms[0].sel_Type.value=="S")
	{
		document.forms[0].txt_bnk_arg.length=1;
		document.forms[0].txt_bnk_arg_TL.length=1;
		document.forms[0].txt_bnk_arg.options[0]=new Option('Sole',"S");
		document.forms[0].txt_bnk_arg_TL.options[0]=new Option('Sole',"S");
		document.forms[0].txt_bnk_arg.value="S";
		document.forms[0].txt_bnk_arg_TL.value="S";
	}
	else if(document.forms[0].sel_Type.value=="O")
	{
		document.forms[0].txt_bnk_arg.length=3;
		document.forms[0].txt_bnk_arg_TL.length=3;
		document.forms[0].txt_bnk_arg.options[0]=new Option('<---Select--->',"0");
		document.forms[0].txt_bnk_arg.options[1]=new Option('Sole',"S");
		document.forms[0].txt_bnk_arg.options[2]=new Option('Consortium',"C");
		document.forms[0].txt_bnk_arg.options[3]=new Option('Multiple',"M");
		document.forms[0].txt_bnk_arg_TL.options[0]=new Option('<---Select--->',"0");
		document.forms[0].txt_bnk_arg_TL.options[1]=new Option('Sole',"S");
		document.forms[0].txt_bnk_arg_TL.options[2]=new Option('Consortium',"C");
		document.forms[0].txt_bnk_arg_TL.options[3]=new Option('Multiple',"M");;
	}
	OnBankArgChanged();
	OnBankArgChangedTL();
}
</script>
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post" class="normal">
 <%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
  if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
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
			<td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>		
			<td  width="15%" nowrap align="center" class="sub_tab_active"><b>Banking Arrangement</b></td>
			
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
<%}}else{%>
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
				<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Banking Arrangement -&gt; Existing Facilities</td>
			</tr>
			<%
			}else if(strCategoryType.equalsIgnoreCase("SRE"))
		{%>
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension  -&gt; Banking Arrangement -&gt; Existing Facilities</td>
	</tr>
	
	<%} else {
				%>
	<tr>
		<td class="page_flow">
	   Home	-&gt; Corporate &amp; SME -&gt; Application -&gt; Banking Arrangement -&gt; Existing Facilities<%} %>	</td>
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
			<td class="sub_tab_inactive" id="prin" nowrap><b>Existing  Banking Details </b></td>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Guarantor / Group concern</a></b></b></td>
			</tr>
			</table>
		 <%}else { %>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td><table border="0" cellspacing="2" cellpadding="3" class="outertable" width="60%">
          <tr align="center">
          
       		<td  width="15%" nowrap="nowrap" align="center" class="sub_tab_inactive"><b><a
					href="#" onclick="javascript:gotoTab(appURL,'bankappfi','getData','combankingfi.jsp')">Existing Facilities</a></b></td>
						
            <td  width="15%" nowrap align="center" class="sub_tab_inactive">
            <b><a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>
            <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'compro','getFinancialComments','com_bankcomments.jsp')">Other Comments</a></b></td>
			<td  width="15%" nowrap align="center" class="sub_tab_active"><b>Banking Arrangement</b></td>
			
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
					
        </table></td>
    </tr>
  </table>
  <%} %>
  </td>
  </tr>
  </table>
  <%} %>
 <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
 	<tr >
			<td align="right" width="50%" style="border: none">Type : </td>
			<td style="border: none">
				<select name="sel_Type" onchange="selValues()">
				<option value="S">Sole</option> 
				<option value="O">Others</option>
				</select>
			</td>
	</tr>
	<tr>
		<td colspan="2">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr align="center" class="dataheader" style="text-align: left" >
				<td colspan="5">
				Working Capital
				</td>
			</tr>
			<tr>
				<td width="15%">
					Banking Arrangement
				</td>
				<td width="15%">
					<select name="txt_bnk_arg" onchange="OnBankArgChanged()">
						<option value="0">--- Select ---</option> 
					</select>
				</td>
				<td width="30%">
					<table  class="outertable" id="tbl_consortium_type">
						<tr>
							<td width="50%">
					Consortium Type
				</td>
				<td width="50%" align="right">
					<select name="txt_bnk_type" onchange="OnBnkTypeChanged()">
						<option value="0">--- Select ---</option>
						<option value="S">Single</option>
						<option value="M">Multiple</option>
					</select>
				</td>
						</tr>
					</table>
				</td>
				<td width="40%">
					<table  class="outertable" id="tbl_no_consortium">
						<tr>
							<td width="60%" nowrap="nowrap">
								Enter number of consortium
							</td>
							<td width="40%" align="right">
								<input type="text" name="txt_no_consortium" maxlength="3" size="10" style="text-align: right"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
			<tr align="center" class="dataheader" style="text-align: left">
				<td colspan="5">
				Term Loan
				</td>
			</tr>
			<tr>
				<td width="15%">
					Banking Arrangement
				</td>
				<td width="15%">
					<select name="txt_bnk_arg_TL" onchange="OnBankArgChangedTL()">
						<option value="0">--- Select ---</option> 
					</select>
				</td>
				<td width="30%">
					<table  class="outertable" id="tbl_tl_consortium_type">
						<tr>
							<td width="50%">
					Consortium Type
				</td>
				<td width="50%" align="right">
					<select name="txt_bnk_type_TL" onchange="OnBnkTypeChangedTL()">
						<option value="0">--- Select ---</option>
						<option value="S">Single</option>
						<option value="M">Multiple</option>
					</select>
				</td>
						</tr>
					</table>
				</td>
				
				<td width="40%">
					<table  class="outertable" id="tbl_tl_no_consortium">
						<tr>
							<td width="60%" nowrap="nowrap">
								Enter number of consortium
							</td>
							<td width="40%" align="right">
								<input type="text" name="txt_no_consortium_TL" maxlength="3" size="10" style="text-align: right"/>
							</td>
						</tr>
					</table>
				</td>
			</tr>
		</table>
	</td>
	</tr>
</table>
	<br/>
	<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Comments" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
	
	<input type="hidden" name="hidCommentPage" value="bankargmnt">
</form>
</body>
</html>