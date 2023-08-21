<%@include file="../share/directives.jsp"%>
<%String strSecId=Helper.correctNull((String) session.getAttribute("strSecId"));

String prd_type = Helper.correctNull((String) session.getAttribute("strProductType"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
String strProAvailableFor =Helper.correctNull((String) hshValues.get("prd_applicablefor"));
int linkid=5;
String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
%>
<html>
<head>
<title>Personal - Vehicle</title>
<script language="JavaScript">
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var auto_appno="<%=Helper.correctNull((String)hshValues.get("VERIFY_APPNO"))%>";
var srcofverf = "<%=Helper.correctNull((String)hshValues.get("VERIFY_SOURCE"))%>";
var refmade = "<%=Helper.correctNull((String)hshValues.get("VERIFY_REFERENCE"))%>";
var checkboxapp="<%=Helper.correctNull((String)hshValues.get("VERIFY_APPLICANTREMARK"))%>";
var chkboxdealer="<%=Helper.correctNull((String)hshValues.get("VERIFY_DOCUMENTRERK"))%>";
var verf_doneon="<%=Helper.correctNull((String)hshValues.get("verf_doneon"))%>";
var varrecordflag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";

function callUsersHelp()
{
	if(document.forms[0].cmdsave.disabled == false)
	{
		var prop="scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL +"action/selectusers.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}

function doEdit()
{  
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="insert";	
    callDisableControls(true,false,false,false,true);
    callEnableFields(false);
}
     
function doSave()
{	

	if(document.forms[0].txt_userid.value=="")
	{
		ShowAlert('111','Verification done by');
		return;
	}
	var srcofverf = document.forms[0].srcofverf.length;	
	for(i=0;i<srcofverf;i++)
	{
		 if(document.forms[0].srcofverf.options[i].selected==true)
		 {
			if(document.forms[0].srcofverf.options[i].value!="0")
			{
				document.forms[0].hidsrcofverf.value = document.forms[0].srcofverf.options[i].text;
			} 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanMethod.value="updateVerification";
	document.forms[0].hidBeanGetMethod.value="getVerification";
	document.forms[0].hidBeanId.value="percollateral";
	document.forms[0].hidRecordflag.value=varrecordflag;
	document.forms[0].hidSourceUrl.value="/action/perverificationdetails.jsp";
	document.forms[0].submit();
}
       
function callEnableFields(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=one;	
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=one;	
		}
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=one;	
		}
	}
	
	document.forms[0].txt_userid.readOnly=true;
	document.forms[0].txtverf_doneby.readOnly=true;
}
	
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getVerification";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].action=appURL+"action/perverificationdetails.jsp";	
		document.forms[0].submit();
	}
}
	
function doDelete()
{
	if(varrecordflag=="Y"){
	if(ConfirmMsg(101))
	{
     	document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="percollateral";
		document.forms[0].hidBeanMethod.value="updateVerification";
	    document.forms[0].hidBeanGetMethod.value="getVerification";
		document.forms[0].hidSourceUrl.value="/action/perverificationdetails.jsp";
		document.forms[0].submit();
	}
	}	
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}       
       
function callOnload()
	{
	
	if(srcofverf!="")
		{
		document.forms[0].srcofverf.value=srcofverf;
		}
	else
		{
		document.forms[0].srcofverf.value="0";
		}	
    if(refmade!="")
		{
		document.forms[0].refmade.value=refmade;
		}
	else
		{
		document.forms[0].refmade.value="0";
		}
	if(checkboxapp == "Y")
		{
		document.forms[0].checkboxapp[0].checked = true;
		document.forms[0].checkboxapp[1].checked = false;
		}
	else if(checkboxapp == "N")
		{
		document.forms[0].checkboxapp[0].checked = false;
		document.forms[0].checkboxapp[1].checked = true;
		}
	if(chkboxdealer == "Y")
		{
		document.forms[0].chkboxdealer[0].checked = true;
		document.forms[0].chkboxdealer[1].checked = false;
		}
	else if(chkboxdealer == "N")
		{
		document.forms[0].chkboxdealer[0].checked = false;
		document.forms[0].chkboxdealer[1].checked = true;
		}
	
	callEnableFields(true);
	}
	
function callCalender(name)
{
	
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
		
	}
}	

function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
	{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
	}
	
function dohlp()
{
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
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
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
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload()">
<form name="colForm" method="post" class="normal">

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
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
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Security </td>
	<%}else if(strSessionModuleType.equals("DIGI")){%>
		<td class="page_flow">Home -&gt; Digi Retail -&gt; Application  -&gt; Security Master -&gt; Security</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Security</td>
		<%} %>			</tr>
</table>
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
        
           <%if(strSessionModuleType.equals("RET")){ %>
           
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
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table> 
  
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp" flush="true">
					<jsp:param name="tabid" value="4" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="1" cellspacing="0" cellpadding="4" class="outertable">
					<tr>
						<td valign="top">
						<table width='100%' border="0" cellspacing="0" cellpadding="5" align="left" class="outertable">
							<tr>
								<td>
								<table width='100%' border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
									
									<tr>
										<td><b><u>Verification	Details</u> </b></td>
									</tr>
									<tr>
									<td>
											
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td width="33%">Verification done by <span class="mantatory">*</span></td>
												<td colspan="4">
												<table width="98%" border="0" cellspacing="0" cellpadding="2" class="outertable">
													<tr>
														<td colspan="2" nowrap="nowrap"><input type="text" name="txt_userid"
															size="10" maxlength="30" readonly="readonly"
															value="<%=Helper.correctNull((String)hshValues.get("VERIFY_DONEBY"))%>">
														<input type="text" name="txtverf_doneby" size="35"
															maxlength="60" onKeyPress="notAllowSplChar()"
															value="<%=Helper.correctNull((String)hshValues.get("VERIFY_DONEBYNAME"))%>">
														<a href="#" onClick="javascript:callUsersHelp()"><b
															class="blackfont"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
															border="0"></b></a></td>
													</tr>
												</table>
												</td>
												<td nowrap="nowrap" WIDTH="6%">Verified On: </td>
												<td width="29%">
												<table width="20%" border="0" cellspacing="1" cellpadding="1" class="outertable">
													<tr>
														<td width="92%"><input type="text" name="txtverf_doneon"
															size="12" maxlength="10" onBlur="checkDate(document.forms[0].txtverf_doneon);checkmaxdate(this,currentDate);"
															value="<%=Helper.correctNull((String)hshValues.get("VERIFY_DONEON"))%>">
														</td>
														<td width="8%"><a
															href="#" onClick="callCalender('txtverf_doneon')"
															title="Click to view calender" border="0"><img
															src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
															width="0" border="0" tabindex="7"></a></td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td nowrap="nowrap" width="33%">Source
												of verification/identification of the applicant</td>
												<td nowrap="nowrap" colspan="6"><select name="srcofverf" size="1">
													<option selected="selected" value="0">-----------Select-----------</option>
													<lapschoice:StaticDataNewTag apptype="45"/>
													</select></td>
											</tr>
											<tr>
												<td nowrap="nowrap" width="33%">Reference
												made </td>
												<td nowrap="nowrap" colspan="6"><select name="refmade" size="1">
													<option selected="selected" value="0">-----------Select-----------</option>
													<option value="1">The Manufactures / Their Reg.Office</option>
													<option value="2">Visit made</option>
													<option value="3">Local Dealer of same or similar product</option>
												</select></td>
											</tr>
											<tr>
												<td width="33%" colspan="6">
												<p><b><u>Remarks of the
												Official</u></b> </p>
												</td>
											</tr>
											
											<tr>
												<td width="33%">
												<p>(a) Applicant : Genuine&gt;</p>
												</td>
												<td width="1%">Yes
												</td>
												<td width="6%"><input type="radio" name="checkboxapp"
													style="border-style:none" value="Y" onClick=""></td>
												<td width="3%">No
												</td>
												<td width="22%"><input type="radio" name="checkboxapp"
													style="border-style:none" value="N" onClick=""></td>
												<td width="6%">&nbsp;</td>
												<td width="29%">&nbsp;</td>
											</tr>
											<tr>
												<td width="33%">
												(b) Documents submitted by 
												Applicant:Geniune&gt;</td>
												<td width="1%">Yes
												</td>
												<td width="6%"><input type="radio" name="chkboxdealer"
													style="border-style:none" value="Y" onClick=""></td>
												<td width="3%">No</td>
												<td width="22%"><input type="radio" name="chkboxdealer"
													style="border-style:none" value="N" onClick=""></td>
												<td width="6%">&nbsp;</td>
												<td width="29%">&nbsp;</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr> </table></td>
				</tr> </table></td></tr> 
</table><br> 
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="appraisedby" value=""> 
<INPUT TYPE="hidden" name="radLoan1" value="Y">
<input type="hidden" name="hidsrcofverf" value="">
<input type="hidden" name="hidSecurityId" value="<%=strSecId%>">	
<input type="hidden" name="hpage">
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)request.getParameter("hidValuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)request.getParameter("hidHouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)request.getParameter("hidVehicleEdit_Flag"))%>">
</form>
</body>
</html>