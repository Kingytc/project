<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup-Groups</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%String grpRights = (String) session.getAttribute("strGroupRights");%>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function onLoad()
{
	disabledfields(true);
	enablebuttons(false, false, true, true, true, false);
}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setgroups.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onLoad()">
<form name="groupsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Groups</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
	<tr>
		<td valign="top">
		<table width="96%" align="center" border="0" cellspacing="0" cellpadding="1" class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
					<tr>
						<td width="70%" valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
							<tr>
								<td valign="middle">
								<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
									<tr>
								<td>&nbsp;</td>
							</tr>
									<tr>
										<td width="18%">&nbsp;<b>Access Rights</b></td>
										<td width="22%">&nbsp;</td>
										<td width="16%"><b>Group Name<span class="mantatory">*&nbsp;</span></b></td>
										<td width="44%"><input type="text" name="grp_name"
											maxlength="25" size="35" class="txtstyle" onKeyPress="notAllowSplChar()"></td>
									</tr>
								</table>
								</td>
							</tr>
							
							<tr>
								<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
									<tr>
										<td>										
                                <table width="100%" border="0" cellspacing="4" cellpadding="4" align="center" class="outertable">
                                   <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>Navigational Security</b></td>
                                  </tr>
                                  <tr> 
                                    <td> 
                                      <input type="checkbox" name="chk_setupvital" style="border-style:none" value="0">                                    </td>
                                    <td>Setup - Vital</td>
                                    <td> 
                                      <input type="checkbox" name="chk_setupnonvital" value="0" style="border-style:none">                                    </td>
                                    <td>Setup - Non Vital</td>
                                    <td> 
                                      <input type="checkbox" name="chk_masters" value="0" style="border-style:none">                                    </td>
                                    <td>Masters</td>
                                    <td> 
                                      <input type="checkbox" name="chk_defaulterslist" style="border-style:none" value="0">                                    </td>
                                    <td>Defaulters List</td>
                                  </tr>
								  <tr>
                                    <td> 
                                      <input type="checkbox" name="chk_allcustomerprofile" value="0" style="border-style:none">                                    </td>
                                    <td>Customer Profile </td>
                                    <td> 
                                      <input type="checkbox" name="chk_securities" style="border-style:none" value="0">                                    </td>
                                    <td>Securities</td>
                                    <td> 
                                      <input type="checkbox" name="chk_branchinbox" style="border-style:none" value="0">                                    </td>
                                    <td>Branch Inbox</td>
                                  </tr>
                                  <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>Gold & Deposit</b></td>
                                  </tr>
                                  <tr> 
                                    
                                    <td> 
                                      <input type="checkbox" name="chk_golddepapplication" value="0" style="border-style:none">                                    </td>
                                    <td>Proposal</td>
                                    <td> 
                                      <input type="checkbox" name="chk_golddepappraisal" value="0" style="border-style:none">                                    </td>
                                    <td>Appraisal</td>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>Retail</b></td>
                                  </tr>
                                  <tr> 
                                    
                                    <td> 
                                      <input type="checkbox" name="chk_branchapplication" value="0" style="border-style:none">                                    </td>
                                    <td>Proposal</td>
                                    <td> 
                                      <input type="checkbox" name="chk_appraisal" value="0" style="border-style:none">                                    </td>
                                    <td>Appraisal</td>
                                   <td> 
                                      <input type="checkbox" name="chk_nsdlappmailbox" value="0" style="border-style:none">   </td>                                 </td>
                                    <td>NSDL Application Mail box</td>
                                    
                                    <td> 
                                      <input type="checkbox" name="chk_print" value="1" style="border-style:none">   </td>                                 </td>
                                    <td>Print</td>
                                    
                                  </tr>
                                    <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>Agriculture </b>                                      </td>
                                  </tr>
                                  <tr> 
                                    
                                    <td> 
                                      <input type="checkbox" name="chk_agrapplication"
													value="0" style="border-style:none">                                    </td>
                                    <td>Proposal</td>
                                    <td> 
                                      <input type="checkbox" name="chk_agrappraisal" value="0"
													style="border-style:none">                                    </td>
                                    <td>Appraisal</td>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  
                                  <tr> 
                                    <td colspan='8' class="setuphead"><b>&nbsp;Corporate &amp; SME </b></td>
                                  </tr>
                                  <tr> 
                                    
                                    <td> 
                                      <input type="checkbox" name="chk_application"
													value="0" style="border-style:none">                                    </td>
                                    <td>Application</td>
                                    <td> 
                                      <input type="checkbox" name="chk_Proposal" value="0"
													style="border-style:none">                                    </td>
                                    <td colspan="3">Proposal</td>
                                  </tr>
                                  <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>Post 
                                      Disbursal </b></td>
                                  </tr>
                                  <tr> 
                                    <td><input type="checkbox" name="chk_monitoringregister" value="0" style="border-style:none">                                    </td>
                                    <td>Monitoring 
                                      Register </td>
                                    <td> 
                                      <input type="checkbox" name="chk_monitoringreport"
													value="0" style="border-style:none">                                    </td>
                                    <td>Monitoring 
                                      Report </td>
                                    
                                     
                                    <td> 
                                      <input type="checkbox" name="chk_TLR" value="0"
													style="border-style:none">                                    </td>
                                    <td>Term Loan Review</td>
                                    <td> 
                                      <input type="checkbox" name="chk_PIR" value="0"
													style="border-style:none">                                    </td>
                                    <td>Post/ Follow up Inspection</td>
                                  </tr>
                                  <tr>
                                    <td> 
                                      <input type="checkbox" name="chk_NPA" value="0"
													style="border-style:none">                                    </td>
                                    <td>NPA</td>
                                  </tr>
                                  <tr> 
                                    <td colspan='8' class="setuphead">&nbsp;<b>MIS</b></td>
                                  </tr>
                                  <tr> 
                                    <td> 
                                      <input type="checkbox" name="chk_Reports" value="0"
													style="border-style:none">
                                    </td>
                                    <td>Reports</td>
                                    <td colspan="2" style="display:none">Access For <span class="mantatory">*</span>
                                    &nbsp;<select name="sel_accessfor" 
													class="stylereadonly" >
                                      <option value="OL">Online &amp; LAPS</option>
                                      </select> </td>
                                    
                                    <td colspan="2" align="right">Lending power</td>
                                    <td colspan="2"> 
                                      <select name="grouplimitslist" 
													class="stylereadonly" >
                                        <option value="0">---Select---</option>
                                        <lapschoice:grouplimits /> 
                                      </select>
                                    </td>
                                  </tr>
                                  <tr>
                                  <td> 
                                      <input type="checkbox" name="chk_LODGE" value="0" style="border-style:none">                               
									</td>
									<td colspan="6">Proposal Lodging</td>
                                  </tr>
                                  <tr> 
                           <td colspan='8' class="setuphead">&nbsp;<b> Online MSME</b></td>
                         </tr>
                         <tr> 
                           <td><input type="checkbox" name="chk_onlinemailbox" value="0" style="border-style:none">                                    </td>
                           <td colspan="6"> Mail box</td>
                         </tr>
                                </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td valign="middle">
								<table width="100%" border="0" cellspacing="0" cellpadding="4"
									class="outertable">
									<tr>
										<td class="setuphead">&nbsp;&nbsp;<b>Data Security</b>
										<table width="100%" cellspacing="4" cellpadding="4" class="outertable">
											
											<tr>
												<td width="5%"><input type="radio" name="dscurrent"
													value="r" disabled="disabled" style="border-style:none"></td>
												<td width="33%">Read</td>
												<td width="5%" align="right"><input type="radio"
													name="dscurrent" value="w" disabled="disabled"
													style="border-style:none"></td>
												<td width="33%">Write</td>
												<td width="5%">&nbsp;</td>
												<td width="33%">&nbsp;</td>
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
						</td>
						<td width="30%" valign="top">
						<center><br>
						<span class="mantatory">Double click
						to view Group Rights</span><br>
						<select name="grouplist" style="width:250;height:400" size="45"
							onDblClick="populateValues()" class="txtstyle">
							<lapschoice:groups />
						</select></center>
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
<lapschoice:combuttonnew btnnames='Create_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="grp_id"> 
<input type=hidden name="grp_discreteid" value=""> 
<input type=hidden name="dscurrent2" value="">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
