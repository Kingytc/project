<%@include file="../share/directives.jsp"%>
<html>
<%
	String strappname = Helper.correctNull((String) request
			.getParameter("app_name"));
	if (strappname.equals("")) {
		strappname = Helper.correctNull((String) hshValues
				.get("app_name"));
	}
	String strPurposeOfLoan=Helper.correctNull((String) hshValues.get("phpa_loan_purpose"));
%>
<head>
<title>General Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var app_status="<%=Helper.correctNull((String) request
							.getParameter("app_status"))%>";
var loanReimbersment = "<%=Helper.correctNull((String) hshValues.get("escalation_status"))%>";
var varPurposeOfLoan = "<%=Helper.correctNull((String) hshValues.get("phpa_loan_purpose"))%>";
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
function doEdit()
{
	calldisable(false);
	document.forms[0].cmdedit.disabled = true;
	document.forms[0].cmddelete.disabled = false;
	document.forms[0].cmdcancel.disabled = false;
	document.forms[0].cmdsave.disabled = false;
}
function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getGeneralInfo";
		document.forms[0].action=appURL+"action/propgeninfo.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateGeneralInfo";
			document.forms[0].hidBeanGetMethod.value="getGeneralInfo";
			document.forms[0].hidSourceUrl.value="/action/propgeninfo.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{
		
		ShowAlert(158);
	}	
		
}

function callOnload()
{ 
  	calldisable(true);
  	if(varPurposeOfLoan=="H" || varPurposeOfLoan=="G"){
		document.all.reimbursement.style.visibility="visible";
		document.all.reimbursement1.style.visibility="visible";
		document.all.reimbursement2.style.visibility="visible";
	}else{
		document.all.reimbursement.style.visibility="hidden";
		document.all.reimbursement1.style.visibility="hidden";
		document.all.reimbursement2.style.visibility="hidden";
	}
  	registrationDateVisiblity();
}

function placevalues()
{
	document.forms[0].sel1.value = "<%=Helper.correctNull((String) hshValues
							.get("selfocc_status"))%>";
	document.forms[0].sel2.value = "<%=Helper.correctNull((String) hshValues
							.get("spouse_status"))%>";
	document.forms[0].sel3.value = "<%=Helper.correctNull((String) hshValues
									.get("legal_status"))%>";
	document.forms[0].sel4.value = "<%=Helper.correctNull((String) hshValues
							.get("collateral_status"))%>";
	document.forms[0].sel5.value = "<%=Helper.correctNull((String) hshValues
							.get("emploan_status"))%>";
	document.forms[0].sel6.value = "<%=Helper.correctNull((String) hshValues
							.get("escalation_status"))%>";
	//document.forms[0].sel7.value = "<%=Helper.correctNull((String) hshValues
							.get("guarantor_status"))%>";
	
	if(document.forms[0].sel1.value=="")
	{
	  document.forms[0].sel1.value=0;
	}
	if(document.forms[0].sel2.value=="")
	{
		document.forms[0].sel2.value=0; 
	}
	if(document.forms[0].sel3.value=="")
	{
	  document.forms[0].sel3.value=0;
	}
	if(document.forms[0].sel4.value=="")
	{
	  document.forms[0].sel4.value=0;
	}
	if(document.forms[0].sel5.value=="")
	{
	   document.forms[0].sel5.value=0;
	}
	if(document.forms[0].sel6.value=="")
	{
	   document.forms[0].sel6.value=0;
	}
	registrationDateVisiblity();
	
}

function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
	/*if(app_status=="pa")
	{
		document.forms[0].cmdedit.disabled = true;
	}
	else
	{
		document.forms[0].cmdedit.disabled = false;
	}*/
}

function doSave()
{
	if(document.forms[0].sel4.value=="0")
	{
		ShowAlert('111',"Bonafide Owner of the Residential");
		document.forms[0].sel4.focus();
		return false;
	}
	if((document.forms[0].sel6.value=="1")&&(document.forms[0].txt_registration.value==""))
	{
		ShowAlert('121',"Date of Registration");
		document.forms[0].txt_registration.focus();
		return false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateGeneralInfo";
	document.forms[0].hidBeanGetMethod.value="getGeneralInfo";
	document.forms[0].hidSourceUrl.value="/action/propgeninfo.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function callCalender(name)
{

if(document.forms[0].cmdsave.disabled==false)
	{
	
	showCal(appURL,name);
	}
}
function registrationDateVisiblity(){

		if(document.forms[0].sel6.value=="1"){
			document.all.registration.style.visibility="visible";
			document.all.registration1.style.visibility="visible";
			document.all.registration2.style.visibility="visible";
		}else{
			document.all.registration.style.visibility="hidden";
			document.all.registration1.style.visibility="hidden";
			document.all.registration2.style.visibility="hidden";
		}
}
</script>

<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callOnload(); placevalues()">
<form class="normal" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  <tr>
      <td >
        <div align="center">
          <p class="dataheader" >General Information</p>
          <table width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr>
              <td width="56%">1) Whether the house/flat be self occupied 
                after construction ? </td>
              <td width="5%"> 
                <select name="sel1">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea1" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
									.get("selfocc_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td width="56%"> 
                <p>2) Does the applicant/his or her spouse/children own any house/flat?</p>
                </td>
              <td width="5%"> 
                <select name="sel2">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea2" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
									.get("spouse_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td width="56%">3) Is the legal title clear ?</td>
              <td width="5%"> 
                <select name="sel3">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea3" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues.get("legal_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td width="56%"> 
                <p>4) Whether the applicant is bonafide owner of the residential / commercial ?&nbsp;<span class="mantatory">*</span></p>
                </td>
              <td width="5%"> 
                <select name="sel4">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea4" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
							.get("collateral_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td width="56%">5) Whether applicant's employer has any housing loan schemes?</td>
              <td width="5%"> 
                <select name="sel5">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea5" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
									.get("emploan_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td id="reimbursement" width="56%">6) Whether the loan is taken for reimbursement ?</td>
              <td id="reimbursement1" width="5%"> 
                <select name="sel6" onChange="registrationDateVisiblity();">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td id="reimbursement2" width="39%"> &nbsp;
                <textarea name="txtArea6" cols="30"  onKeyup="textlimit(this,499)"  onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
							.get("escalation_desc"))%></textarea>
              </td>
            </tr>
            <tr>
              <td id="registration" width="56%">7)Date of registration&nbsp;<span class="mantatory">*</span></td>
				<td>
				<table border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td id="registration1"><input type="text" name="txt_registration" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("registration_date"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate)" maxlength="12"></td>
						<td id="registration2"><a alt="Select date from calender" href="#"
							onClick="callCalender('txt_registration')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					</tr>
				</table>
				</td>
				<!--<td width="5%"> 
                <select name="sel7">
                  <option value="0" selected="selected">Select</option>
                  <option value="1">Yes</option>
                  <option value="2">No</option>
                </select>
              </td>
              <td width="39%"> &nbsp;
                <textarea name="txtArea7" cols="30" onKeyup="textlimit(this,499)" onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues
							.get("guarantor_desc"))%></textarea>
              </td>-->
            </tr>
          </table>
        </div>
      </td>
  </tr>
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>'/>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' />
<input type="hidden" name="appno" value="<%=request.getParameter("appno")%>">
<input type="hidden" name="readFlag" value="<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>">
<input type="hidden" name="appname" value="<%=strappname%>">
</form>
</body>

</html>
