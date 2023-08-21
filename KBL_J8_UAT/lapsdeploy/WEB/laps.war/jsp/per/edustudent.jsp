<%@include file="../share/directives.jsp"%>
<%
	String strVal = Helper.correctNull((String) hshValues
			.get("edu_relation"));
	String strMatVal = Helper.correctNull((String) hshValues
			.get("edu_status"));
	String strReligion = Helper.correctNull((String) hshValues
			.get("edu_religion"));
%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var CurrentDate="<%=Helper.getCurrentDateTime()%>";
var edu_exp= "<%=Helper.correctNull((String) hshValues.get("edu_exp"))%>"
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function checkgua()
{
	if(document.forms[0].nameof.value=="Guardian")
	{
		document.all.g1.style.visibility="visible";
		document.all.g2.style.visibility="visible";
	}
	else{
		document.all.g1.style.visibility="hidden";
		document.all.g2.style.visibility="hidden";
		document.forms[0].guastaterelation.value="";
	}
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}

function callCalender(fname)
{
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
}

function callcustprofile()
{
	document.all.ifrstudpart.src = appURL+"action/iframestudpart.jsp?hidBeanId=edustudent&hidBeanGetMethod=getStudentDetails&hidapplicantid="+document.forms[0].hidapplicantid.value;
}

function getAge(obj)
{
  	var result = true;
  	var birthDate = new Date(obj.value);
  	var today = new Date();
 	var currdate=CurrentDate.substring(6,10);
  	var birthDate1=document.forms[0].dob.value;
  	var birthMM=birthDate1.substring(3,5);
  	var CurrbirthMM=CurrentDate.substring(3,5);
    birthDate1=birthDate1.substring(6,10);
    var CurrYear=parseInt(currdate)-parseInt(birthDate1);
	var CurrMon=parseInt(CurrbirthMM)-parseInt(birthMM);
	
	if(CurrMon==0)
	{
		CurrMon=0;
	}  
	if(CurrbirthMM > birthMM)
	{
		CurrMon = 0;
	  	CurrMon=parseInt(CurrbirthMM)-parseInt(birthMM);
	}
	if(CurrbirthMM < birthMM)
	{
		CurrMon = 0;
		CurrMon = parseFloat(birthMM)-parseFloat(CurrbirthMM);
		CurrYear=Math.round(CurrYear)-1;
		CurrMon=  12 - CurrMon;
	}
  	if(CurrYear<18)
  	{
   		document.forms[0].age.value=(CurrYear);
   		alert("Age should be Greater Than 18")
   		document.forms[0].dob.value="";
   		document.forms[0].age.value="0";
  	}
   	else
   	{
   		document.forms[0].age.value=NanNumber((CurrYear));
   	}
}

function disableFields(one)
{	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		}		
	}		
}

function onloading()
{
	if(edu_exp!="")
	{
		document.forms[0].previous1.value=edu_exp;
	}
	disableFields(true);
}

function showedu()
{
	if(document.forms[0].previous1.value=="0")
	{
		document.all.e1.style.visibility="hidden";		
		document.all.e2.style.visibility="hidden";
		document.all.e3.style.visibility="hidden";		
		document.all.e4.style.visibility="hidden";
		document.forms[0].previous.value="";
		document.forms[0].prevexperience.value="";
	}
	else if(document.forms[0].previous1.value=="1")
	{
		document.all.e1.style.visibility="visible";		
		document.all.e2.style.visibility="visible";
		document.all.e3.style.visibility="visible";		
		document.all.e4.style.visibility="visible";
	}
	else if(document.forms[0].previous1.value=="2")
	{
		document.all.e1.style.visibility="hidden";		
		document.all.e2.style.visibility="hidden";
		document.all.e3.style.visibility="hidden";		
		document.all.e4.style.visibility="hidden";
		document.forms[0].previous.value="";
		document.forms[0].prevexperience.value="";	
	}
}

function onSelect()
{
	var selVall = "<%=strVal%>" ;
	var strMatVal1 = "<%=strMatVal%>" ; 
	var strReligion = "<%=strReligion%>" ;
	if(selVall != "")
	{
		document.forms[0].nameof.value = selVall ;
	}
	if(strMatVal1!="")
	{
		document.forms[0].mstatus.value = strMatVal1 ;
	}
	if(strReligion!="")
	{
		document.forms[0].selreligion.value = strReligion;
	}
}

function doEdit()
{		
	if(document.forms[0].namefostudent.value=="")
	{
		callcustprofile();
	}
	else
	{
		disableCommandButtons("edit");
		document.forms[0].age.readOnly = true;
		document.forms[0].dob.readOnly = true;
		document.forms[0].city.readOnly = true;
		document.forms[0].state.readOnly = true;
	}
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
}

function doSave()
{
	if(document.forms[0].namefostudent.value == "")
	{
		alert("Enter Name of Student");
		document.forms[0].namefostudent.focus();
		return;
	}
	if(document.forms[0].dob.value == "")
	{
		alert("Enter Date of Birth");
		document.forms[0].dob.focus();
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="edustudent"
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/edustudent.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="edustudent";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/edustudent.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doDelete()
{
  	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanId.value="edustudent";				
			document.forms[0].hidSourceUrl.value="/action/edustudent.jsp";
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
	}
	else
	{
		ShowAlert(158);
	}
}
	
function disableCommandButtons(val)
{
  	if(val=="edit")
  	{
	 	document.forms[0].cmdedit.disabled=true;
	 	document.forms[0].cmdsave.disabled=false;
	 	document.forms[0].cmdcancel.disabled=false;
	 	document.forms[0].cmddelete.disabled=false;
	 	document.forms[0].cmdclose.disabled=true;
	 	disableFields(true);
		document.forms[0].previous1.disabled=false;
		document.forms[0].previous.readOnly=false;
		document.forms[0].prevexperience.readOnly=false;
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
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

var strvalue="loan_appretail_eduloan_partistud.htm";
function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_eduloan_partistud.htm";
	var title = "ParticularsOfStudent";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();onSelect();showedu();checkgua()">
<form method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail -&gt; Application -&gt; Loan Particulars -&gt; Details for Education Loan -&gt; Particulars of Student</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><lapschoice:application /></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="93%" border="0" cellspacing="0" cellpadding="0"
			align="left" class="outertable">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="7" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr align="center">
				<td width="20%" class="sub_tab_active" id="prm"><b>Particulars
				of Student</b></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('edueducational.jsp','edudetails','getData')"><b>Educational
				Details</b></a></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('eduscholarship.jsp','eduscholar','getData')"><b>Scholarship
				</b></a></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('eduparticulars.jsp','eduparticulars','getData')"><b>Course
				Details </b></a></td>
				<td width="20%" class="sub_tab_inactive" id="com2"><a
					href="javascript:callLink('educourse.jsp','eduscholar','getDataExp')"><b>Course
				Expenses </b></a></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		<td>
		<table border="1" cellspacing="0" cellpadding="3" width="100%"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					class="outertable">
					<tr>
						<td width="13%">Name of Student&nbsp;<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="35%"><input type="text" name="namefostudent"
							size="50" maxlength="50" tabindex="1"
							value="<%=Helper.correctNull((String) hshValues.get("edu_name"))%>">
						</td>
						<td width="15%">Any previous work experience</td>
						<td width="10%"><select name="previous1" onChange="showedu()"
							tabindex="2">
							<option value="0">select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
						<td width="10%" id="e1">No of Years</td>
						<td width="7%" id="e2"><input type="text" name="previous"
							size="5" maxlength="2" tabindex="3"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_no_of_years"))%> "
							onKeyPress="allowInteger()"></td>
						<td width="8%" id="e3">Work Experience</td>
						<td width="15%" id="e4"><textarea name="prevexperience" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)"><%=Helper.correctNull((String) hshValues
							.get("edu_prevexperience"))%></textarea></td>
					</tr>
					<tr>
						<td width="13%">Name of</td>
						<td width="35%"><input type="text" name="nameof"> <input
							type="text" name="nameofval" size="20" maxlength="50"
							tabindex="5"
							value="<%=Helper.correctNull((String) hshValues
									.get("edu_relname"))%>">
						</td>
						<td width="15%" id="g1">If Guardian state relationship</td>
						<td colspan="5" id="g2"><input type="text"
							name="guastaterelation" tabindex="6" size="20" maxlength="50"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_relgauratian"))%>">
						</td>
					</tr>
					<tr>
						<td width="13%">Date of Birth <b>&nbsp;<span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="35%">
						<table width="35%" border="0" cellspacing="0" cellpadding="0">
							<tr>
								<td width="83%"><input type="text" name="dob" size="12"
									maxlength="12"
									value="<%if (!(Helper.correctNull((String) hshValues.get("edu_dob")).trim()
					.equals("01/01/1900"))) {
				out.println(Helper.correctNull(
						(String) hshValues.get("edu_dob")).trim());
			}%>"
									onBlur="dateDOBCheck(document.forms[0].dob); getAge(document.forms[0].dob)"
									readonly></td>
								<td align="left" valign="bottom" width="17%">&nbsp;</td>
							</tr>
						</table>
						</td>
						<td width="15%">Age</td>
						<td colspan="5"><input type="text" name="age" size="5"
							maxlength="3"
							value="<%if (!Helper.correctNull((String) hshValues.get("edu_age")).trim()
					.equals("")) {
				out.println(Helper.correctNull(
						(String) hshValues.get("edu_age")).trim());%>">
						<%
							} else {

								out.println("");
						%> "> <%
							}
						%>
						</td>
					</tr>
					<tr>
						<td width="13%">Caste</td>
						<td width="35%"><input type="text" name="caste" size="15"
							tabindex="8" maxlength="50"
							value="<%=Helper.correctNull((String) hshValues.get("edu_caste"))%>">
						</td>
						<td width="15%">Religion</td>
						<td colspan="5"><input type="text" name="selreligion"></td>
					</tr>
					<tr>
						<td width="13%">Marital Status</td>
						<td width="35%"><input type="text" name="mstatus"></td>
						<td width="15%">No of Children if any</td>
						<td colspan="5"><input type="text" name="noofchildren"
							size="4" tabindex="11" maxlength="2"
							value="<%=Helper.correctNull((String) hshValues.get("edu_child"))%>"
							onKeyPress="allowInteger()"></td>
					</tr>
					<tr>
						<td width="13%">Address1</td>
						<td width="35%"><input type="text" name="addr1" size="50"
							maxlength="50" tabindex="12"
							value="<%=Helper.correctNull((String) hshValues.get("edu_addr1"))%>">
						</td>
						<td width="16%">Address2</td>
						<td colspan="5"><input type="text" name="addr2" size="50"
							maxlength="50" tabindex="13"
							value="<%=Helper.correctNull((String) hshValues.get("edu_addr2"))%>">
						</td>
					</tr>
					<tr>
						<td width="13%">Address3</td>
						<td width="35%"><input type="text" name="addr3" size="50"
							maxlength="45" tabindex="14"
							value="<%=Helper.correctNull((String) hshValues.get("edu_addr3"))%>"></td>
						<td width="15%">City</td>
						<td colspan="5"><input type="text" name="city" size="20"
							tabindex="15"
							value="<%=Helper.correctNull((String) hshValues.get("edu_city"))%>"
							maxlength="10"> <b><span
							onClick="showCitySearch('city','state','hidcity','hidstate')"
							style="cursor: hand"></span></b></td>
					</tr>
					<tr>
						<td width="13%">State</td>
						<td width="35%"><input type="text" name="state" size="20"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("edu_state"))%>"
							maxlength="25"></td>
						<td width="15%"><%=ApplicationParams.getZipName()%></td>
						<td colspan="5"><input type="text" name="pincode" size="12"
							maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="17"
							value="<%=Helper.correctNull((String) hshValues
									.get("edu_pincode"))%>"
							onKeyPress="allowInteger()"
							onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
						</td>
					</tr>
					<tr>
						<td width="13%">Mobile Number</td>
						<td width="35%"><input type="text" name="mobile"
							maxlength="15" tabindex="18"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_mobile_no"))%>"
							onKeyPress="allowInteger()"></td>
						<td width="15%">&nbsp;</td>
						<td colspan="5">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <INPUT TYPE="hidden"
	name="radLoan" value="Y"> <input type="hidden" name=hidcity
	value="<%=Helper.correctNull((String) hshValues.get("hidcity"))%>">
<input type="hidden" name=hidstate
	value="<%=Helper.correctNull((String) hshValues.get("hidstate"))%>">
<iframe height="0" width="0" id="ifrstudpart" style="visibility: hidden"></iframe>
</form>
</body>
</html>




