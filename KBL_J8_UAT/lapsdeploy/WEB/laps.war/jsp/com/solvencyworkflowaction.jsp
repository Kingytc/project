<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strStatus = "";
	HashMap hshTemp = new HashMap();
	if (objValues != null && objValues instanceof HashMap) {
		hshTemp = (HashMap) objValues;
		strStatus = Helper.correctNull((String) hshTemp.get("status"));
	}
	ArrayList arrWorkid = (ArrayList) hshValues.get("prd_workid");
	ArrayList arrflowpoint = (ArrayList) hshValues.get("arrflowpoint");
	ArrayList arrMinclass = (ArrayList) hshValues.get("prd_minclass");
	ArrayList arrWrkflwname = (ArrayList) hshValues.get("wrk_flowname");
	ArrayList arrMaxclass = (ArrayList) hshValues.get("arrMaxclass");
	String Appstatus = Helper.correctNull((String) session
			.getAttribute("strappstatus"));
	String stratatus = Helper.correctNull((String) hshValues.get("sol_status"));
%>
<html>
<head>
<title>Work Flow</title>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script>

var currdate = "<%=Helper.getCurrentDateTime()%>";
var solid="<%=Helper.correctNull((String) hshValues.get("SOL_APPID"))%>"
var usr_class="";
var usr_dept="";
var varUserId="<%=Helper.correctNull((String) hshValues.get("strUserId"))%>";
var varHolder="<%=Helper.correctNull((String) hshValues.get("strAppholder"))%>";
var varusrfunction="<%=Helper.correctNull((String) hshValues.get("usrfunction"))%>";
var varSancAuth="<%=Helper.correctNull((String) hshValues.get("strSancAuth"))%>";
var varloanamount="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbltotalrecamt")))%>";
var varsancPowerTotal="<%=Double.parseDouble(Helper.correctDouble((String)hshValues.get("PowerAmt"))) %>";
function setValues(idx,size)
{
	if(size>1)
	{
		usr_class=document.forms[0].prd_maxclass[idx].value;	
		document.forms[0].mail_tousrid.value="";
		
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint[idx].value;
	}
	else
	{
		usr_class=document.forms[0].prd_maxclass.value;	
		document.forms[0].mail_tousrid.value="";
		document.forms[0].mail_toflowpoint.value=document.forms[0].txtmail_toflowpoint.value;
	}
}

function placeValues()
{	

	if(document.forms[0].btnenable.value=="Y")
    {
		<%if (stratatus.equalsIgnoreCase("PR") || stratatus.equalsIgnoreCase("PA")) {%>
			disableButtons(false,true,true,true);
		<%} else {%>
			disableButtons(true,true,true,true);
		if(varSancAuth=="Y")
		{
			document.forms[0].cmdsanction.disabled=false;
			document.forms[0].cmdreject.disabled=false;
		}
		<%}%>
        
		<%if (stratatus.equalsIgnoreCase("CR") || stratatus.equalsIgnoreCase("CA")) {%>
		disableButtons(true,true,true,true);
		<%}%>
		document.forms[0].cmdsend.disabled=false;
	 }
	else
	{
		if(varUserId==varHolder)
		{
		<%if (stratatus.equalsIgnoreCase("PR") || stratatus.equalsIgnoreCase("PA")) {%>
		disableButtons(false,true,true,false);
		<%}else if (stratatus.equalsIgnoreCase("CR") || stratatus.equalsIgnoreCase("CA")) {%>
		disableButtons(true,true,true,true);
		<%}else{%>
		disableButtons(true,true,true,false);
		if(varSancAuth=="Y")
		{
			document.forms[0].cmdsanction.disabled=false;
			document.forms[0].cmdreject.disabled=false;
		}
		<%}%>
		}
		else
		{
		disableButtons(true,true,true,true);
		}
		
	}
	if(varusrfunction=="Delegated Authority")
	{
		document.all["idorgselect"].style.visibility="visible";
	}else{
		document.all["idorgselect"].style.visibility="hidden";
	}
	if(document.forms[0].org_name.value=="HEAD OFFICE"){

		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
	}else{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
	}

	<%if(strGroupRights.charAt(18)=='r'){%>
	disableButtons(true,true,true,true);
	<%}%>
}
function disableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdundo.disabled=bool1;
	document.forms[0].cmdsanction.disabled=bool2;
	document.forms[0].cmdreject.disabled=bool3;
	document.forms[0].cmdsend.disabled=bool4;
}
function openWindow(pagename)
{
	var url = "<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	window.open(url,"report","scrollbars=no,toolbars=no,menubar=no,width=450,height=300,left=60,top=40");
}
function doSend()
{	
    if(usr_class=="" )
	{
		ShowAlert(111,"Flowpoint");
		return;
	}
	if(document.forms[0].mail_tousrid.value=="")
	{
		ShowAlert(111,"Recipient");
		return;
	}
	document.forms[0].hidAction.value = "send";
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/mainnav.jsp";
	alert("Your application has been sent successfully");
	document.forms[0].submit();
}

function doClose()
{
	if (ConfirmMsg(100)) {
		document.forms[0].action = appURL + "action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function doReject()
{
	if(document.forms[0].txt_sanctioncomments.value=="")
	{
		alert("Enter Sanctioning Authority Comments");
		return;
	}
	document.forms[0].hidAction.value="reject";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].hidSourceUrl.value="/action/solvencyworkflow.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doSanction()
{
	if(document.forms[0].txt_sanctioncomments.value=="")
	{
		alert("Enter Sanctioning Authority Comments");
		return;
	}
	<%if (stratatus.equalsIgnoreCase("OP")) {%>
	if(parseFloat(varloanamount)>parseFloat(varsancPowerTotal))
	{
		 
			 alert("Delegated power under Solvency exceeds the maximum limit  -> "+varsancPowerTotal+"  hence cannot be sanctioned");
			 return;
		 
	}
<%}%>
	document.forms[0].hidAction.value="approve";
	document.forms[0].hidSourceUrl.value="/action/solvencyworkflow.jsp"; 
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}


function callOtherTab(val)
{
	 if(val=="history")
	 {
	 document.forms[0].action=appURL+"action/solvencyworkflow.jsp?hidBeanGetMethod=getAction&hidBeanId=comsolvency";
	 document.forms[0].submit();  
	 }
}

function callCalender(val)
{
	showCal(appURL,val);
}

function gotoWorkflowPage()
{
	//document.forms[0].action = appURL + "action/ControllerServlet";
	document.forms[0].hidBeanId.value = "comsolvency";
	document.forms[0].hidBeanGetMethod.value = "getSolvencyData";
	document.forms[0].action = appURL+"action/com_solvency.jsp";
	document.forms[0].submit();
}

function callUsersHelp()
{
	if(document.forms[0].org_name.value=="HEAD OFFICE")
	{
		if(document.forms[0].usr_department.value=="0")
		{
			ShowAlert(111,"Department");
			document.forms[0].usr_department.focus();
			return;
		}
	}
	usr_dept=document.forms[0].usr_department.value;
	if(usr_class=="")
		{
			ShowAlert(111,"Flowpoint");	
			return;
	    }
		var prop="scrollbars=no,width=400,height=350,top=100,left=250";
		var url=appURL+"action/wrkflowuserlist.jsp?usr_class="+usr_class+"&org_code="+document.forms[0].org_code.value+"&usr_dept="+usr_dept;
		window.open(url,"hai",prop);
}


function doUndo()
{
	document.forms[0].hidAction.value="undo";
	document.forms[0].hidSourceUrl.value="/action/solvencyworkflow.jsp"; 
	document.forms[0].hidBeanId.value="comsolvency";
	document.forms[0].hidBeanMethod.value="updateAction";
	document.forms[0].hidBeanGetMethod.value="getAction";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function callOrgHelp()
{
	var appno1="<%=Helper.correctNull((String) request.getParameter("hidapplno"))%>";
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		var prop = "scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appURL+"action/orgnamelist.jsp?&appno="+appno1;
		window.open(url,"",prop);
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<body onLoad="placeValues();">
<form name="frmworkflow" method="post" class="normal">
<table>
	
<tr>
		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:gotoWorkflowPage();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		Solvency </b></a></td>

		<td width="50%" align="center" class="sub_tab_active">Solvency WorkFlow</td>
</tr>
		
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
   	<tr>
		<td class="page_flow">Home -> Solvency Workflow  -> Action</td>
	</tr>
</table>

<lapschoice:ApplSolHeaderTag/>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="70%" border="0" cellspacing="1" cellpadding="3"
			class="outertable">
			<tr align="center">
				<td class="sub_tab_inactive" width="10%"><a
					href="javascript:callOtherTab('history')">History</a></td>
				<td class="sub_tab_active" width="10%">Action</td>

			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td width="47%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									
									<tr>
									<td>
									<!--<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable">
											<tr class="dataheader">
											<td width="50%" align="center"> Select Facility
											</td>
											<td width="50%">
												<select name="sel_facility">
												<option value="s" selected="selected">--Select--</option>
                									<lapschoice:ComApprovedFacility apptype='<%=Helper.correctNull((String) request
									.getParameter("appno"))%>'/>
												</select>
											</td>
											</tr>
									</table>
									--></td>
									</tr>
						
									<tr>
										<td height="161" valign="top">
										<table width="100%" border="0" cellspacing="1" cellpadding="3"
											class="outertable">
											<tr class="dataheader">
												<td width="18%" align="center">Current Flowpoint</td>
												<td width="13%" class="datagrid" align="center">
														<b><%=Helper.correctNull((String) hshValues.get("as_toflwpt"))%>&nbsp;</b>
												</td>
												<td width="16%" align="center">Received On</td>
														<td align="center" class="datagrid"><b><%=Helper.correctNull((String) hshValues.get("as_date"))%>&nbsp;</b></td>
												<td width="12%" align="center">Due On</td>
														<td align="center" class="datagrid"><b><%=Helper.correctNull((String) hshValues.get("dueon_date"))%>&nbsp;</b></td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
											<tr>
												<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable linebor">
							<tr class="dataheader">
								<td width="7%" align="center">Select</td>
								<td width="10%" align="center">Flowpoints</td>
								<td width="10%" align="center">Min. Class</td>
								<td width="73%" align="center">Actions</td>
							</tr>
							<%
								if (arrMinclass != null && arrMinclass.size() > 0) {

									for (int i = 0; i < arrMinclass.size(); i++) {
							%>

							<tr class="datagrid">

								<td align="center"><input type="radio" name="optflowpnt" value=""
									style="border-style: none"
									onClick="setValues(<%=i%>,<%=arrMinclass.size()%>);"></td>

								<td width="10%" align="center"><%=Helper.correctNull((String) arrflowpoint.get(i))%>
								<input type="hidden" name="txtmail_toflowpoint"
									value="<%=Helper.correctNull((String) arrflowpoint.get(i))%>">
								</td>
								<td width="10%" align="center"><%=Helper.correctNull((String) arrMinclass.get(i))%>
								<input type="hidden" name="prd_maxclass"
									value="<%=Helper.correctNull((String) arrMinclass.get(i))%>">
								<input type="hidden" name="prd_maxclass1"
									value="<%=Helper.correctNull((String) arrMinclass.get(i))%>">
								</td>
								<td width="73%" align="left"><%=Helper.correctNull((String) arrWrkflwname
											.get(i))%>
								<input type="hidden" name="wrk_flowname"
									value="<%=Helper.correctNull((String) arrWrkflwname
											.get(i))%>">
								</td>
							</tr>

							<%
								}
								}
							%>
						</table>
						</td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable border1">
											<tr>
														<td colspan="2" >
											<!--<table width="60%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td valign="top">
														Initial Data Entry Vetting done</td>
														<td><select name="sel_datavetting">
															<option value="S">&lt;---select---&gt;</option>
															<option value="Y">Yes</option>
															<option value="N">No</option>
														</select></td>
														
														<td valign="top">
															 Vetting done by</td>
														<td>
															<input type="text" value="<%=Helper.correctNull((String) hshValues
									.get("app_vettedby"))%>">															
														</td>
													</tr>
												</table>
											--></td>
											</tr>
											
											<tr>
												<td align="center" colspan="3">
												<!--<table width="100%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td width="27%"><input type="checkbox"
															name="appraisal" value="checkbox" style="border:none">Appraisal
														Checked</td>
														<td width="18%"><input type="checkbox"
															name="documents" value="checkbox" style="border:none">Process Note</td>
														
														<td width="55%"><input type="checkbox"
															name="sancinti" value="checkbox" style="border:none">Pre Sanction
														Inspection Conducted Checked</td>
														
													</tr>
												</table>
												--></td>
											</tr>
											
											<tr>
												<td colspan="2">
												<!--<table width="43%" border="0" cellspacing="0"
													cellpadding="3" class="outertable">
													<tr>
														<td valign="top">Whether Legal Compliance Certificate is Applicable</td>
														<td width="18%"><select name="sel_legalcomp">
															<option value="S">&lt;---select---&gt;</option>
															<option value="N">No</option>
															<option value="Y">Yes</option>
														</select></td>
													</tr>
												</table>-->
												</td>
											</tr>
											<tr>
												
                              <td width="42%" valign="top"> 
                                <table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td valign="top">
														
                                      <table width="93%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
                                        <tr>
																<td width="30%" nowrap>Select Organisation</td>
																<td ><select  name="org_name"   >
																	<option value="">--select--</option>
																	<lapschoice:organizations />
																	</select>
																	
																	</td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
												
                              <td align="right" valign="top" width="58%"> 
                                <table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr>
														<td valign="top">
														<table width="100%" border="0" cellspacing="0"
															cellpadding="3" class="outertable">
															<tr>
											
										  <td width="16%"></td>	 					
                                          <td id="deprt1" width="16%">Department<span class="mantatory">*&nbsp;</span> 
                                          </td>
																
                                         <td id="deprt2" width="15%"> 
                                            <select name="usr_department">
																<option value="0">---Select---</option>
									 							<%String apptypecon = "20";%>
                          										<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>'/>
																</select>
										 </td>
																
                                          <td width="21%" align="center">Select 
                                            Recipient</td>
																
                                          <td width="48%" nowrap> 
                                            <input type="text"
																	name="mail_tousrid" size="37" readonly="readonly"
																	value="">
																<input type="hidden" name="hidmail_tousrid"> <a
																	href="#" onClick="javascript:callUsersHelp()"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
															</tr>
														</table>
														</td>
													</tr>
												</table>
												</td>
											</tr>
											<tr>
												<td colspan="2">
												<table width="100%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													
													<!--<tr>
														<td nowrap>Next Review Date</td>
														<td>
														<table class="outertable">
															<tr>
																<td><input type="text" name="txt_reviewdate"
																	size="12"
																	value="<%=Helper.correctNull((String) hshValues
							.get("app_reviewdate"))%>"
																	maxlength="10"
																	onBlur="checkDate(this);checkmindate(this,currentDate)"></td>
																<td><a alt="Select date from calender" href="#"
																	onClick="callCalender('txt_reviewdate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border="0" alt="Select date from calender"></a></td>
															</tr>
														</table>
														</td>
													</tr>
													--><tr>
														<td nowrap>Sanctioning Authority Comments</td>
														<td><textarea name="txt_sanctioncomments" cols="150"
															rows="3" onkeyup="textlimitcorp1(this,256);" onkeydown="textlimitcorp1(this,256);"><%=Helper.correctNull((String) hshValues
							.get("sol_comments"))%></textarea></td>
													</tr>
												</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

<table width="0%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
	<!--
		<td>
		 <input type="button" name="cmdAdditionalparameter" class="buttonStyle"
			value="Send To CBS" onClick="showSanctionDetails()">
				&nbsp;<input type="button" name="cmdUpdateCBS" class="buttonStyle"
			value="Update CBS App No " onClick="UpdateCBS()">					
		</td>
	--></tr>

</table>

<lapschoice:combuttonnew btnnames='Sanction_Reject_Undo_Send' btnenable='<%=Helper.correctNull((String) session.getAttribute("strBtnenable"))%>'/>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="mail_touserclass"> 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
 <input type="hidden" name="org_code" value="<%=strOrgCode%>">
 <input type="hidden" name="mail_toflowpoint"> 
<input type="hidden" name="txt_from_flwpt" value="<%=Helper.correctNull((String) hshValues.get("as_toflwpt"))%>">
<input type="hidden" name="hidcurrflowpoint" value="<%=Helper.correctNull((String) hshValues.get("as_toflwpt"))%>">

<input type="hidden" name="txt_usrid" value="<%=session.getAttribute("strUserId")%>"> 
<input TYPE="hidden" name="hidAppNo" value="<%=Helper.correctNull((String) request.getParameter("appno"))%>">
<input type="hidden" name="hidapplname" value="<%=Helper.correctNull((String) request.getParameter("hidapplname"))%>">
<input type="hidden" name="hidapplholder" value="<%=Helper.correctNull((String) request.getParameter("hidapplholder"))%>">
<input type="hidden" name="hidOrgname" value="<%=Helper.correctNull((String) request.getParameter("hidOrgname"))%>">
<input type="hidden" name="hidapplno" value="<%=Helper.correctNull((String) request.getParameter("hidapplno"))%>">
<input type="hidden" name="btnenable" value="<%=Helper.correctNull((String) session.getAttribute("strBtnenable"))%>">
<iframe name="ifrm" width="0" height="0"></iframe>
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
</form>
</body>
</html>
