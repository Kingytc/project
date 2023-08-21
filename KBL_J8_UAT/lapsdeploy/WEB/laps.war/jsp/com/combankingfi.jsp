<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	if (hshValues != null)
	{		vecData = (ArrayList) hshValues.get("vecData");				
	}
	String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strCategory=Helper.correctNull((String)request.getParameter("hidCategoryType"));	
	String strBATypeWC		= Helper.correctNull((String)hshValues.get("com_wc_bnkarg"));
	String strConsTypeWC	= Helper.correctNull((String)hshValues.get("com_wc_type"));
	String strBATypeTL		= Helper.correctNull((String)hshValues.get("com_tl_bnkarg"));
	String strConsTypeTL	= Helper.correctNull((String)hshValues.get("com_tl_type"));
	session.setAttribute("com_wc_bnkarg",strBATypeWC);
	session.setAttribute("com_wc_type",strConsTypeWC);
	session.setAttribute("com_tl_bnkarg",strBATypeTL);
	session.setAttribute("com_tl_type",strConsTypeTL);
%>
<html>
<head>
<title>Commercial-Principal (s)</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/combankingfi.js"> </script>
<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varstrCategory="<%=strCategory%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style>
.selectwidth
{
	width: 150px;
}
</style>
</head>
<body onLoad="onloading()">
<form name="frmpri" method="post" class="normal">
  <iframe height="0" width="0" id="ifrm" frameborder="0"	style="border:0"></iframe>
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
          
          <td width="15%" nowrap align="center"   class="sub_tab_active"> <b> Existing Facilities</b> </td>
          <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>
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
			</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="3" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<table width="100%">
  		
  		<tr>
  			<td>
  			<table border="0" cellspacing="2" cellpadding="3" align="left" class="outertable">
			<tr>
			<td class="sub_tab_active" id="prin" nowrap><b>Existing  Banking Details sss</b></td>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">
					Guarantor / Group concern</a></b></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
  
<%}}else{ %>
		 <%if(strSessionModuleType.equalsIgnoreCase("RET")){ %> 
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt;  Retail(including schematic) -&gt; Application -&gt; Banking Arrangement -&gt; Existing Banking Details </td>
    </tr>
  </table>
  <%} else if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
	  
	  	<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
	        <jsp:param name="pageid" value="12" />
	        </jsp:include>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
	    <tr> 
	     <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Banking Arrangement -&gt; Existing Banking Details </td>
	    </tr>
	  </table> 	
	<%  }
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
		 <%if(strSessionModuleType.equalsIgnoreCase("RET") || strSessionModuleType.equalsIgnoreCase("DIGI")){   %> 
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
          
          <td width="15%" nowrap align="center"   class="sub_tab_active"> <b> Existing Facilities</b> </td>
          <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'bankapp','getBankingdetailsData','com_bankingdetails.jsp')">Asset Classification / Comments on Arrears</a></b></td>
          <td  width="15%" nowrap align="center" class="sub_tab_inactive"><b>
          <a href="#" onclick="javascript:gotoTab(appURL,'compro','getFinancialComments','com_bankcomments.jsp')">Other Comments</a></b></td>
		
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
  <%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center">Company Name</td>
										<td align="center">Bank <span class="mantatory">*</span></td>
										<td align="center" id="id_Module">Module <span class="mantatory">*</span></td>
										<td align="center">Facility <span class="mantatory">*</span></td>
										<td align="center">Type</td>
										<td align="center" id="id_MainLimit1">Facility of</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center">
											<select name="sel_CompName" class="selectwidth">
												<%
													String name_company = "";
													if(strCategoryType.equalsIgnoreCase("RET") || strCategoryType.equalsIgnoreCase("DIGI") )
													{
														name_company=Helper.correctNull((String)request.getParameter("appname"));
													}
													else
													{
														name_company=request.getParameter("comapp_compname");
													}
												%>
												<option value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>"><%=name_company%></option>
											</select>
										</td>
										<td align="center">
											<select name="sel_Bank" class="selectwidth" onChange="javascript:calBankFun()" tabindex="1">
												<option value="Our">Karnataka Bank</option>
											</select>
										</td>
										<td align="center" id="id_FacTypeTxt" style="visibility:hidden;position: absolute;">
											<select name="sel_FacilityType" class="selectwidth" onChange="javascript:calBankFun()" tabindex="3">
												<option value="" selected>--select--</option>
												<option value="1">Working Capital</option>
												<option value="2">Term Loan</option>
											</select>
										</td> 
										<td align="center" id="id_ModuleVal">
											<select name="sel_Module" class="selectwidth" tabindex="1">
												<option value="">--select--</option>
												<option value="r">Retail</option>
												<option value="c">Corporate</option>
												<option value="a">Agriculture</option>
											</select>
										</td>
										<td align="center" id="id_FacilitySel">
											<input type="text" name="sel_FacilityNew" readonly="readonly" size="40"/>
											<input type="hidden" name="sel_Facility"/>
											<span onClick="callDescHelp()" style="cursor: hand;display: none;">
											<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="2"></span>	
										</td>
										<td>
										<select name="sel_factype">
										<option value="0">-- Select --</option>
										<option value="M">Main Limit</option>
										<option value="S">Sub Limit</option>
										</select>
										</td>
										<td id="id_MainLimit2">
										<input type="hidden" name="txt_facof" >
										<input type="text" name="txt_facof_desc" >
										</td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Limit <span class="mantatory">*</span></td>
									<td align="center">Outstanding <span class="mantatory">*</span></td>
									<td align="center">As on Date <span class="mantatory">*</span></td>
									 <td align="center" id="id_monthlyins">Monthly Installment</td>
									<td align="center">Banking Type <span class="mantatory">*</span></td> 
									<td align="center">Interest Type <span class="mantatory">*</span></td>
									<td align="center">Spread Value <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<lapschoice:CurrencyTag name="txt_Limit"
											maxlength="15" size="12" tabindex="6"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_OS"
											maxlength="15" size="12" tabindex="7"
											onKeyPress="allowDecimals(this)" style="text-align:right"
											onBlur="roundtxt(this)" other="readOnly" />
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_OSAsOnDate" tabindex="9"
													onBlur="checkDate(this);checkmaxdate(this,currentDate)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="8"
												href="javascript:callCalender('txt_OSAsOnDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									  <td align="center" id="id_monthlyinsval">
										<input type="text" name="txt_monthlyins" value="" size="12" tabindex="13" maxlength="15" onKeyPress="allowDecimal(this,2)"  onblur="roundtxt(this)">
									</td>
									<td align="center">
										<select name="sel_BnkType" tabindex="9">
											<option value="">--Select--</option>
											<option value="S">Sole</option>
											<option value="C">Consortium</option>
											<option value="M">Multiple</option>
										</select>
									</td>
									<td align="center">
										<select name="sel_IntType" tabindex="10">
											<option value="">--Select--</option>
											<option value="BR">Base Rate</option>
											<option value="MCLR">MCLR</option>
											<option value="BRLEC">BR linked Export Credit</option>
											<option value="MCLEC">MCLR linked Export Credit</option>
											<option value="BPLR">BPLR</option>	
											<option value="LIBOR">LIBOR</option>
											<option value="EURIBOR">EURIBOR</option>
											<option value="EUROLIBOR">EUROLIBOR</option> 
											<option value="COMMI">Commission</option>
											<option value="NOTAP">Not Applicable</option>			
											<option value="ST">6 Months Treasury Bill</option>			
											<option value="GS">10 Year Government Security</option>	
											<option value="FTBR">FBIL-TERM MIBOR</option>		
										</select>
									</td>
									<td align="center">
										<lapschoice:CurrencyTag name="txt_SpreadVal" maxlength="6" size="12" tabindex="11" style="text-align:right" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this);checkPercentage(this);" />
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center" width="20%">Interest Rate&nbsp;% <span class="mantatory">*</span></td>
										<td align="center" width="20%">Repayment Type <span class="mantatory">*</span></td>
										<td align="center" width="20%">Drawing Power</td>
										<td align="center" width="40%">Present Status</td>		
										<td align="center" width="40%">Exposure</td>								 
									</tr>
									<tr align="center" class="datagrid">
										<td width="20%"><input type="text" name="txt_bank_intrate" maxlength="5" size="15" style=" text-align: right"  onkeypress="allowDecimals(this)" onblur="roundtxt(this)"></td>
										<td width="20%">
											<select name="com_banksel_repaytype"  style="width:150px">
												<option value="0" selected>----Select----</option>
											</select>
										</td>
										<td width="20%"><input type="text" name="txt_bank_drwpower" maxlength="15" size="25" style=" text-align: right" onkeypress="allowNumber(this)" onblur="roundtxt(this)"></td>
	                              		<td align="center"><input type="text" name="txt_prestatus" maxlength="100" size="35" style=" text-align: left" ></td>
	                              		<td align="center" width="40%"><input type="text" name="txt_Exposure" maxlength="20" size="35" style=" text-align: left" ></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
								<tr align="center" class="dataheader">
									<td align="center">Type of Credit</td>
									<td align="center">Sanction Reference Number</td>
									<td align="center">Sanctioned Date</td>
									<td align="center">Due Date <span class="mantatory">*</span></td>
									<td align="center">CBS Account No <span class="mantatory">*</span></td>
								</tr>
								<tr align="center" class="datagrid">
									<td align="center">
										<select name="sel_CreditType"  disabled="disabled" tabindex="12">
											<option value="" selected>--select--</option>
											<option value="E">Existing</option>
											<option value="P">Proposed</option>
										</select>
									</td>
									<td align="center">
										<input type="text" name="txt_SancRefNo" value="" size="30" tabindex="13"
												maxlength="30" onKeyPress="notAllowSingleAndDoubleQuote()">
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_SancDate" tabindex="15"
													onBlur="checkDate(this);checkmaxdate(this,document.forms[0].txt_DueDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="14"
												href="javascript:callCalender('txt_SancDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center">
										<table>
										<tr>
											<td>
												<input type="text" name="txt_DueDate" tabindex="16"
													onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_SancDate.value)">
											</td>
											<td width="34%"><a alt="Select date from calender" tabindex="15"
												href="javascript:callCalender('txt_DueDate')"><img
												src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
												border="0"></a>
											</td>
										</tr>
										</table>
									</td>
									<td align="center">
										<input type="text" name="txt_cbsappno" value="" size="30" tabindex="13" maxlength="40" readOnly="readonly" allowAlphaNumeric();">
									</td>
								</tr>
								</table>
							</td>
						</tr>
						<tr>
							<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
									<tr align="center" class="dataheader">
										<td align="center">Arrears if any</td>
										<td align="center">Remarks</td>
										<td align="center">Purpose</td>
										<td align="center">Repayment Comments</td>
									</tr>
									<tr align="center" class="datagrid">
										<td align="center"><textarea name="txtArea_Arrears" cols="50" style="text-align:left" tabindex="16" rows="3" onKeyPress="textlimitcorp1(this,50)" wrap="VIRTUAL" onkeyup="textlimitcorp1(this,50);" onkeydown="textlimitcorp1(this,50);"></textarea></td>
										<td align="center"><textarea name="txtarea_Remarks" cols="50" style="text-align:left" tabindex="17" rows="3" onKeyPress="textlimit(this,499)" wrap="VIRTUAL" onkeyup="textlimit(this,499)"></textarea></td>
										<td><textarea name="txtArea_purpose" cols="50" style="text-align:left" tabindex="16" rows="3" onKeyPress="textlimit(this,1999)" wrap="VIRTUAL" onkeyup="textlimit(this,1999)"></textarea></td>
										<td><textarea name="txtArea_repayment" cols="50" style="text-align:left" tabindex="16" rows="3" onKeyPress="textlimit(this,499)" wrap="VIRTUAL" onkeyup="textlimit(this,499)"></textarea></td>
									</tr>
								</table>
								</td>
							</tr>
							<lapschoice:combuttonnew btnnames="Edit_Save_Delete_Cancel_Audit Trail_Update Liabilities" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							<tr style="display: none;">
								<td>
									<table width="25%" align="center" border="0" cellpadding="2" cellspacing="0">
									<tr>
										<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Existing Credit Facility" onClick="callexisec()"></td>
										<td><input type="button" name="coll_exifac" class="buttonstyle" value="Comments on Repayment" onClick="callRepayMentComments()"></td>
									</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
								<tr class="dataheader">
									<td width="3%">&nbsp;</td>
									<td width="19%" align="center">Name of the Bank</td>
									<td width="21%" align="center">Facility</td>
									<td width="10%" align="center">Limit</td>
									<td width="10%" align="center">Banking Type</td>
									<td width="10%" align="center">Type of Credit</td>
									<td width="10%" align="center">Limit Type</td>
									<td width="10%" align="center">Nature of Limit</td>
								</tr>
									<%
									if (vecData != null)
									{
										vecsize = vecData.size();
									}
									String strSno = "";
									double strLFE = 0.00;
									double strLNFE = 0.00;
									double strLFP = 0.00;
									double strLNFP = 0.00;
									double strOSF = 0.00;
									double strOSNF = 0.00;
									for (int i = 0; i < vecsize; i++)
									{
										vecRow = (ArrayList) vecData.get(i);
										if (vecRow != null && vecRow.size() > 0)
										{
											strSno = Helper.correctDouble((String) vecRow.get(0));
											String strBank="";
											if(Helper.correctNull((String) vecRow.get(11)).equalsIgnoreCase("Our"))
											{
												strBank=Helper.correctNull((String)vecRow.get(18));
											}
											else
											{
												strBank=Helper.correctNull((String)vecRow.get(1));
											}
											String strBnkType=Helper.correctNull((String) vecRow.get(3));
											if(strBnkType.equalsIgnoreCase("S"))
											{
												strBnkType="Sole";
											}
											else if(strBnkType.equalsIgnoreCase("C"))
											{
												strBnkType="Consortium";
											}
											else if(strBnkType.equalsIgnoreCase("M"))
											{
												strBnkType="Multiple";
											}
											String strCreditType=Helper.correctNull((String) vecRow.get(5));
											if(strCreditType.equalsIgnoreCase("E"))
											{
												strCreditType="Existing";
											}
											else if(strCreditType.equalsIgnoreCase("P"))
											{
												strCreditType="Proposed";
											}
									%>
									<tr class="datagrid">
										<td align="center">
											<input type="radio" name="sno" style="border-style:none"
												onClick="selectValues('<%=Helper.correctInt((String)vecRow.get(0))%>',
														'<%=Helper.correctNull((String)vecRow.get(1))%>',
														'<%=Helper.correctNull((String)vecRow.get(2))%>',
														'<%=Helper.correctNull((String)vecRow.get(3))%>',
														'<%=Helper.correctNull((String)vecRow.get(4))%>',
														'<%=Helper.correctNull((String)vecRow.get(5))%>',
														'<%=Helper.correctNull((String)vecRow.get(6))%>',
														'<%=Helper.correctNull((String)vecRow.get(7))%>',
														'<%=Helper.correctNull((String)vecRow.get(8))%>',
														'<%=Helper.correctNull((String)vecRow.get(9))%>',
														'<%=Helper.correctNull((String)vecRow.get(10))%>',
														'<%=Helper.correctNull((String)vecRow.get(11))%>',
														'<%=Helper.correctNull((String)vecRow.get(12))%>',
														'<%=Helper.correctNull((String)vecRow.get(13))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(14))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(15))))%>',
														'<%=nf.format(Double.parseDouble(Helper.correctDouble((String)vecRow.get(16))))%>',
														'<%=Helper.correctNull((String)vecRow.get(17))%>',
														'<%=Helper.correctNull((String)vecRow.get(18))%>',
														'<%=Helper.correctNull((String)vecRow.get(19))%>','<%=Helper.correctNull((String)vecRow.get(20))%>','<%=Helper.correctNull((String)vecRow.get(21))%>',
														'<%=Helper.correctNull((String)vecRow.get(22))%>',
														'<%=Helper.correctNull((String)vecRow.get(23))%>','<%=Helper.correctNull((String)vecRow.get(24))%>',
														'<%=Helper.correctNull((String)vecRow.get(25))%>','<%=Helper.correctNull((String)vecRow.get(26))%>',
														'<%=Helper.correctNull((String)vecRow.get(27))%>','<%=Helper.correctNull((String)vecRow.get(28))%>',
														'<%=Helper.correctNull((String)vecRow.get(29))%>','<%=Helper.correctNull((String)vecRow.get(30))%>',
														'<%=Helper.correctNull((String)vecRow.get(31))%>','<%=Helper.correctNull((String)vecRow.get(32))%>'
														,'<%=Helper.correctNull((String)vecRow.get(33))%>','<%=Helper.correctNull((String)vecRow.get(34))%>')">
											<input type="hidden" name="hid" value="<%=strSno%>">
										</td>
										<td align="left">&nbsp;<%=Helper.correctNull((String)vecRow.get(12))%></td>
										<td align="left">&nbsp;<%=strBank%></td>
										<td align="right"><%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecRow.get(14))))%>&nbsp;</td>
										<td align="left">&nbsp;<%=strBnkType%></td>
										<td align="left">&nbsp;<%=strCreditType%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(35))%></td>
										<td align="left">&nbsp;<%=Helper.correctNull((String) vecRow.get(36))%></td>
									</tr>
									<%	}
									}
									if(vecsize<=0)
									{
									%>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td align="center">--No Records Found--</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<tr class="datagrid">
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
									<%
									}
									%>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table><br>
		</td>
	</tr>
</table>
	<lapschoice:hiddentag pageid='<%=PageId%>'/> 
	<input type="hidden" name="hidflag" value="">
	<input type="hidden" name="selsno1" value="">
	<input type="hidden" name="hidval">
	<input type="hidden" name="hiddesc">
	<input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>">
	<input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>">
	<INPUT TYPE="hidden" NAME="hidPageSource" VALUE="">
	<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
	<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
	<input type="hidden" name="id" value="<%=strBorrowerType%>">
	<input type="hidden" name="hidAppId" value="<%=Helper.correctNull((String)hshValues.get("hidAppId"))%>">
	<input type="hidden" name="idno" value="">
	<input type="hidden" name="type" value="T">
	<input type="hidden" name="hidFacSNo" value="">
	<input type="hidden" name="hidappno" value="<%=Helper.correctNull((String)request.getParameter("appno")) %>">
	<input type="hidden" name="hidFacID">
	<iframe height="0" width="0" id="ifrFacilityDesc" frameborder="0" style="border:0" ></iframe>
</form>
</body>
</html>