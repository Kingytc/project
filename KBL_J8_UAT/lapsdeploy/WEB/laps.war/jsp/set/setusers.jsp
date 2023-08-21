<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup - Users</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<script language="JavaScript"> 
var appURL = "<%=ApplicationParams.getAppUrl()%>";
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script>
 var strId=trim("<%=Helper.correctNull((String) request
							.getParameter("usr_id"))%>");
 var strAction="<%=Helper.correctNull((String) request
							.getParameter("hidAction"))%>";
 var strusrgrpid="<%=Helper.correctNull((String) hshValues.get("usr_grpid"))%>";
 var strusrorgcode=trim("<%=Helper.correctNull((String) hshValues
									.get("usr_orgcode"))%>");
 var strusrfname=trim("<%=Helper.correctNull((String) hshValues.get("usr_fname"))%>");
 var strusrlname=trim("<%=Helper.correctNull((String) hshValues.get("usr_lname"))%>");
 var strusrmname=trim("<%=Helper.correctNull((String) hshValues.get("usr_mname"))%>");
 var strusrclass=trim("<%=Helper.correctNull((String) hshValues.get("usr_class"))%>");
 var strusrsupid=trim("<%=Helper.correctNull((String) hshValues.get("usr_supid"))%>");
 var strusrsupstatus=trim("<%=Helper.correctNull((String) hshValues
							.get("usr_supstatus"))%>");
 var strusravail=trim("<%=Helper.correctNull((String) hshValues.get("usr_avail"))%>");
 var strusrfunction=trim("<%=Helper.correctNull((String) hshValues
									.get("usr_function"))%>");
 var strusrsanction=trim("<%=Helper.correctNull((String) hshValues
									.get("usr_sanction"))%>");
  var user_designation=trim("<%=Helper.correctNull((String) hshValues
							.get("user_designation"))%>");
 var strAppUrl="<%=ApplicationParams.getAppUrl()%>";
  var varMailBoxStatus=trim("<%=Helper.correctNull((String) hshValues
									.get("mailboxcount"))%>");
  var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var strEmailID=trim("<%=Helper.correctNull((String) hshValues.get("usr_emailid"))%>");
var strdepartment=trim("<%=Helper.correctNull((String) hshValues.get("usr_department"))%>");
var strRmdFlag="<%=Helper.correctNull((String) hshValues.get("usr_rmdflag"))%>";
var strRLPFType="<%=Helper.correctNull((String) hshValues.get("usr_rlpftype"))%>";
var strHrmsDes="<%=Helper.correctNull((String) hshValues.get("USR_HRMS_DESIGNATION"))%>";
var strHrmsjobCode="<%=Helper.correctNull((String) hshValues.get("USR_HRMS_JOBCODE"))%>";

function showDescClass(id)
{
	for(i=0;i<document.forms[0].prd_class_value.length;i++)
		{	
			if(id == document.forms[0].prd_class_value[i].value)
			{
				document.all.d1.style.visibility="hidden";
				document.all.d1.style.position="absolute";
				document.forms[0].prd_class_value.selectedIndex=i;
				if(document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text == "Select")
					document.forms[0].txt_class_desc.value="";
				else
					document.forms[0].txt_class_desc.value=document.forms[0].prd_class_value.options[document.forms[0].prd_class_value.selectedIndex].text
			}
		}
}
function fetchValuesWindowOpener()
{
	 document.forms[0].hidBeanMethod.value="getData";
	 var strText=document.forms[0].userslist.value.split("^");
	 document.forms[0].usr_id.value=strText[0];
	 document.forms[0].usr_id.disabled=false;
	 document.forms[0].action=strAppUrl+"action/setusers.jsp";
	 document.forms[0].submit();
}
function doPasswordReset()
{
 	if(document.forms[0].usr_id.value!="")
 	{
 		document.forms[0].hidAction.value="reset";
 		document.forms[0].hidBeanId.value="setusers";
		document.forms[0].hidSourceUrl.value="/action/setusers.jsp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();		
 	}
}

</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/setusers.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues()">
<form name="usersfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Users</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="6"
	align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td width="50%">
				<div align="center">
				<table border="0" cellspacing="0" cellpadding="0" class="outertable border1 tableBg"
					width="100%">
					<tr>
						<td valign="top">
						<table border="0" cellspacing="0" cellpadding="10" width="100%"
							class="outertable">
							<tr>
								<td nowrap="nowrap">Login Name / Employee Code<b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td colspan="3"><input type="text" name="usr_id" size="20"
									maxlength="15" disabled="disabled"
									onKeyPress="notAllowSplChar()" onBlur="getValue1()"> <span
									onClick="callSearch()" style="cursor: hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></td>
								<td nowrap="nowrap">First Name <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td><input type="text" name="usr_fname" size="25"
									maxlength="25" disabled="disabled"
									onKeyPress="notAllowSplChar()"></td>
							</tr>
							<tr>
								<td>Last Name</td>
								<td colspan="3"><input type="text" name="usr_lname"
									size="20" maxlength="20" disabled="disabled"
									onKeyPress="allowAlphabets()"></td>
								<td nowrap="nowrap">Designation <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td>
									<select name="user_designation" disabled="disabled">
									<option value="">--Select--</option>
									<lapschoice:CBSStaticDataNewTag apptype="27"/>
									</select>
								</td>
							</tr>
							<tr>
								<td>Location <b><span class="mantatory">*&nbsp;</span></b>
								</td>
								<td colspan="3"><select name="usr_orgcode"
									disabled="disabled" onChange="enableDepartment()">
									<option value="">---Select---</option>
									<lapschoice:organizations />
								</select></td>
								<td nowrap="nowrap">Group <b><span class="mantatory">*&nbsp;</span></b>
								</td>
								<td><select name="grouplist" disabled="disabled">
									<option value="">---Select---</option>
									<lapschoice:groups />
								</select></td>
							</tr>
							<tr>
								<td>Class <b> <span class="mantatory">*&nbsp;</span></b></td>
								<td colspan="3">
								<table border="0" cellspacing="0" cellpadding="0" width="100%"
									class="outertable">
									<tr>
										<td><input type="hidden" name="usr_class1"
											style="width: 40" maxlength="4" disabled="disabled"
											onBlur="populateSupervisor()"
											onKeyPress="allowInteger(window.event)"> <select
											name="usr_class"
											onChange=showDescClass(document.forms[0].usr_class.value)>
											<option value="">Select</option>
											<lapschoice:usersclass />
										</select></td>
										<td id="d1"><select name="prd_class_value"
											style="width: 20">
											<option value="">Select</option>
											<lapschoice:usersclassdesc />
										</select></td>
									</tr>
								</table>
								</td>
								<td nowrap>Class Description</td>
								<td><input type="text" name="txt_class_desc" size="35"
									maxlength="55"></td>
							</tr>
							<tr>
								<td>Availability</td>
								<td><select name="usr_avail" disabled="disabled">
									<OPTION value="a">Available</OPTION>
									<OPTION value="u">Unavailable</OPTION>
								</select></td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td nowrap="nowrap">Function<b> <span class="mantatory">*&nbsp;</span></b></td>
								<td><select name="usr_function" disabled="disabled">
									<option selected value="S">&lt;--- Select --- &gt;</option>
									<option value="Monitoring">Monitoring</option>
									<option value="Processing">Processing</option>
									<option value="Delegated Authority">Delegated
									Authority</option>
								</select></td>
							</tr>
							<tr>
								<td nowrap="nowrap">E-mail ID</td>
								<td>
									<input type="text" name="usr_emailid" size="30" maxlength="50" style="text-align:left" disabled="disabled"
										onBlur="isEmailAddr(document.forms[0].usr_emailid.value,document.forms[0].usr_emailid)">
								</td>
								<td colspan="2">&nbsp;</td>
								<td id="deprt1">Department </td>
								<td id="deprt2"><select name="usr_department" disabled="disabled">
									<option value="">---Select---</option>
									 <%String apptypecon = "20";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
								</select></td>
							</tr>
							<tr>
							<td id="clpu1">User belongs to CLPU/CLPH? <b><span class="mantatory">*&nbsp;</span></b></td>
								<td id="clpu2"><select name="sel_rlpftype" disabled="disabled">
									<option value="">---Select---</option>
									 <%apptypecon = "130";%>
                          <lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
								</select></td>
							</tr>
							<tr style="visibility: hidden" id="passwd">


								<td width="25%">Password <b><span class="mantatory">*&nbsp;</span></b>
								</td>
								<td width="27%"><input type="password" name="usr_password"
									size="15" maxlength=10 onKeyPress="notAllowSingleQuote()"
									onBlur="getValue1()"></td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td width="20%" nowrap>Confirm Password <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td width="28%"><input type="password" name="usr_password1"
									size="15" maxlength=10 onKeyPress="notAllowSingleQuote()"
									onBlur="getValue1()"></td>
							</tr>
							
							<tr>
							  <td>Whether RMD&nbsp;<span class="mantatory">*</span></td>
							  <td><select name="sle_rmd">							  
							  	  <option value="">--Select--</option>
							  <option value="1">Yes</option>
							   <option value="0">No</option>							  
							  </select>							  
							  </td>							
							</tr>
							
							<tr>
								
								
								<td nowrap="nowrap">HRMS Jobcode</td>
								<td>
									<input type="text" name="hrms_jobCode" size="30" maxlength="50" style="text-align:Right disabled="disabled">
								</td>
								<td>&nbsp;</td>
								<td>&nbsp;</td>
								<td nowrap="nowrap">HRMS Designation</td>
								<td>
									<input type="text" name="hrms_des" size="30" maxlength="200" style="text-align:left">
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</div>
				</td>
				<td width="50%" valign="top" align="center">Double Click to
				View the User Rights<br>
				<SELECT name="userslist" style="height: 285" size=18
					onDblclick="fetchValues()">
					<lapschoice:users />
				</select></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div style="padding-bottom:10px;">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" >
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			id="rights" style="Visibility: Hidden" class="outertable">
			<tr>
				<td class="setuphead"><b>&nbsp;Group Rights</b></td>
			</tr>
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					align="center" class="outertable linebor">
					<tr class="dataheader">
						<td align="center" width="9%">Setup - Vital</td>
						<td align="center" width="9%">Setup - Nonvital</td>
						<td align="center" width="9%">Master</td>
						<td align="center" nowrap" width="9%">Defaulters list</td>
						<td align="center" width="9%">Retail Cust profile</td>
						<td align="center" width="9%">Retail Appln</td>
						<td align="center" width="9%">Retail Appraisal</td>
						<td align="center" width="9%">Agri Cust Profile</td>
						<td align="center" width="9%">Agri Appln</td>
						<td align="center" width="9%">Agri Appraisal</td>
						<!-- <td align="center" width="9%">Tertiary Cust Profile</td> -->
					</tr>
					<tr class="datagrid">
						<td align="center"><input type="text" size="4" name="apptext"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="groupstext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="userstext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="otherstext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="prodtext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="servicestext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4" name="coltext"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="agricustext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="agriapptext" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="agriappsltext" readonly="readonly"></td>
						<!-- <td align="center"><input type="text" size="4" name="coctext"
							readonly="readonly"></td> -->
					</tr>
				</table>
				</td>
			</tr>
		</table>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" id="rights1" style="visibility: hidden">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0"
					 align="center"
					class="outertable linebor">
					<tr class="dataheader">

						<!-- <td align="center" nowrap width="9%">Tertiary Appln</td>
						<td align="center" nowrap width="9%"
							style="Visibility: Hidden; position: absolute;">Tertiary
						Proposal</td> -->
						<td align="center" nowrap width="9%">Corp Cust Profile</td>
						<td align="center" nowrap width="9%">Corp Appln</td>
						<td align="center" nowrap width="9%">Corp Proposal</td>
						<td align="center" nowrap width="9%"
							style="Visibility: Hidden; position: absolute;">Executive
						Summary</td>
						<td align="center" nowrap width="9%">Monitoring Register</td>
						<td align="center" nowrap width="9%">Monitoring Reports</td>
						<td align="center" nowrap width="9%">NPA</td>
						<td align="center" nowrap width="9%">MIS Reports</td>
						<td align="center" width="9%">&nbsp;</td>
					</tr>
					<tr class="datagrid">

						<!-- <td align="center"><input type="text" size="4" name="terapp"
							readonly="readonly"></td>
						<td align="center" style="Visibility: Hidden; position: absolute;"><input
							type="text" size="4" name="audOpt" readonly="readonly"></td> -->
						<td align="center"><input type="text" size="4" name="ootext"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4" name="pgotext"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4" name="audText"
							readonly="readonly"></td>
						<td align="center" style="Visibility: Hidden; position: absolute;"><input
							type="text" size="4" name="others" readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="monitoring" readonly="readonly"></td>
						<td align="center"><input type="text" size="4" name="reports"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4" name="npa"
							readonly="readonly"></td>
						<td align="center"><input type="text" size="4"
							name="workflowinbox" readonly="readonly"></td>
						<td align="center" width="9%">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
</div>
<lapschoice:combuttonnew
	btnnames='Create_Edit_Save_Cancel_Password Reset_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="user_id" value="<%=request.getParameter("usr_id")%>"> <input
	type=hidden name="usr_grpid"> <input type="hidden"
	name="txt_flag"
	value="<%=Helper.correctNull((String) hshValues.get("txt_flag"))%>">
<input type=hidden name="hid_location" value=""> <input
	type=hidden name="hid_grouplist" value=""> <input type="hidden"
	name="hidkeyid" value="set"></form>
</body>
</html>
