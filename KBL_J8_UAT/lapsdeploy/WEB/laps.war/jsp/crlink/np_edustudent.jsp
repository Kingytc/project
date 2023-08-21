<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<% String stroptions=" "; %>
<%
String strVal=Helper.correctNull((String)hshValues.get("edu_relation"));
String strMatVal=Helper.correctNull((String)hshValues.get("edu_status"));
String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
String strintSubsidy="";
if(strCanaraSyndBank.equalsIgnoreCase("C")){
strintSubsidy=Helper.correctNull((String)hshValues.get("EDU_ELIGINT_SUBSIDY"));
}
session.setAttribute("AppHolder",Helper.correctNull((String)hshValues.get("strAppHolder")));
%>
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>

<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>
<SCRIPT   LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/per/perpropertydetails.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>

var strvalue= "/jsp/perhlp/hlp_edustudent.jsp";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var varparent="<%=Helper.correctNull((String)hshValues.get("edu_parentname"))%>";
var varstabilty="<%=Helper.correctNull((String)hshValues.get("edu_stabilityparents"))%>";
var varCanaraSyndBank="<%=strCanaraSyndBank%>";
var varCaste="<%=Helper.correctNull((String)hshValues.get("edu_caste"))%>";
var varReligion="<%=Helper.correctNull((String)hshValues.get("edu_religion"))%>";
var varAppHolder="<%=Helper.correctNull((String)hshValues.get("strAppHolder"))%>";
var varuserId="<%=session.getAttribute("strUserId")%>";
var varAppNo= "<%=Helper.correctNull((String)hshValues.get("edu_appno"))%>";
function onloading()
{
	if(varparent!="")
	{
		document.forms[0].parentname.value=varparent;
	}
	else 
	{
		document.forms[0].parentname.value="";
	}
	disableCommandButtons("load");
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		alert("Cannot modify --> APPROVED APPLICATION !!!")
		callDisableControls(true,true,true,true,false)
	}  
	else
	{
		if(strappeditsameregbranch!="")
		{
			if(strappeditsameregbranch=="disablefalse")
			{
				callDisableControls(false,true,true,true,false);
			}
			else if(strappeditsameregbranch=="disabletrue")
			{
				callDisableControls(true,true,true,true,false);
			}
		}
	}	
}

function callonload()
{
	if(varstabilty!="")
	{
		document.forms[0].Parent_stability.value=varstabilty;
	}
	else 
	{
		document.forms[0].Parent_stability.value=0;
	}
	if(varCanaraSyndBank == "C")
	{
		if(varCaste!="")
		{			
			document.forms[0].caste.value=varCaste;				
		}
		else 
		{
			document.forms[0].caste.value="s";
		}
		if(varReligion!="")
		{			
			document.forms[0].religion.value=varReligion;				
		}
		else 
		{
			document.forms[0].religion.value="s";
		}
		if(document.forms[0].nameof.value=="Mother" || document.forms[0].nameof.value=="Father")
		{
			document.all.parenid.style.visibility="Visible";
			document.all.parenid.style.position="relative";
		}
		else
		{
			document.all.parenid.style.visibility="hidden";
			document.all.parenid.style.position="absolute";
		}
	}	
}

function callDisableControls(cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdapply.disabled=cmdApply;
	document.forms[0].cmddel.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function onSelect()
{
	var selVall = "<%=strVal%>" ;
	var strMatVal1 = "<%=strMatVal%>" ; 
	if(varCanaraSyndBank=="C"){
		var varintSubsidy="<%=strintSubsidy%>";
		if(varintSubsidy!="")
		{
			document.forms[0].sel_intSubsidy.value = varintSubsidy ;
		}
	}
	if(selVall != "")
	{
		document.forms[0].nameof.value = selVall ;
		var val = selVall;
		if(val == 'Father' || val == 'Mother')
		{
			document.all.parenid.style.visibility="visible";
			document.all.parenid.style.position="relative";
			document.forms[0].parentname.value=varparent;
		}
		else
		{
			document.all.parenid.style.visibility="hidden";
			document.all.parenid.style.position="absolute";
		}
	} 
	if(strMatVal1!="")
	{
		document.forms[0].mstatus.value = strMatVal1 ;
	}

	if(strMatVal1=="Single"){
		document.all.abc1.style.visibility="hidden";
		document.all.abc1.style.visibility="absolute";
		document.all.abc2.style.visibility="hidden";
		document.all.abc2.style.visibility="absolute";
	}
	else
	{
		document.all.abc1.style.visibility="visible";
		document.all.abc1.style.visibility="relative";
		document.all.abc2.style.visibility="visible";
		document.all.abc2.style.visibility="relative";
	}
}

function onChange() 
{
	var val = document.forms[0].nameof.value;
	if(val == 'Father' || val == 'Mother')
	{
		document.all.parenid.style.visibility="visible";
		document.all.parenid.style.position="relative";
		document.forms[0].parentname.value='';
	}
	else
	{
		document.all.parenid.style.visibility="hidden";
		document.all.parenid.style.position="absolute";
		document.forms[0].parentname.value='';
	}
}

function doAfterEdit()
{
	
}

function doEdit()
{
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].age.readOnly = true;
}

function doApply()
{
	if(varAppHolder!=varuserId && varAppNo!="")
	{	
		alert("Your Not The Holder of the Application to Modify The Application");
		return;
	}
	else
	{
		if(document.forms[0].dob.value=="")
		{
			alert("Enter Date of Birth");
			return false;
		}
		var val = document.forms[0].nameof.value;
		if((val == 'Father' || val == 'Mother') && varCanaraSyndBank=="S")
		{
			if(document.forms[0].parentname.value=="")
			{
				alert("Select Parent Name");
				document.forms[0].parentname.focus();
				return false;
			}
		}
		if(document.forms[0].Parent_stability.value=="0" || document.forms[0].Parent_stability.value=="")
		{
			alert("Select Stability of Income of parents");
			document.forms[0].Parent_stability.focus();
			return false;
		}
		alert(varCanaraSyndBank);
		if(varCanaraSyndBank=="C")
		{
			if(document.forms[0].namefostudent.value=="")
			{
				alert("Enter Name of Student");
				document.forms[0].namefostudent.focus();
				return false;
			}
			if(document.forms[0].sel_intSubsidy.value=="s" || document.forms[0].sel_intSubsidy.value=="")
			{
				alert("Select Eligible for Interest Subsidy");
				document.forms[0].sel_intSubsidy.focus();
				return false;
			}
			if(document.forms[0].txt_incYear.value=="")
			{
				alert("Enter Year of parents Income");
				document.forms[0].txt_incYear.focus();
				return false;
			}
			if(document.forms[0].txt_incAmt.value=="")
			{
				alert("Enter Amount of parents Income");
				document.forms[0].txt_incAmt.focus();
				return false;
			}
			if(document.forms[0].txt_incCert_issuedBy.value=="")
			{
				alert("Enter Income Certificate Issued By");
				document.forms[0].txt_incCert_issuedBy.focus();
				return false;
			}
			if(document.forms[0].txt_incCert.value=="")
			{
				alert("Enter Income Certificate Number");
				document.forms[0].txt_incCert.focus();
				return false;
			}
			if(document.forms[0].txt_incAmt.value<=0 )
			{
				alert("  Parents Income should not be Zero");
				document.forms[0].txt_incAmt.focus();
				return false;
			}
		}
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanMethod.value="updateStudentParticularsData";
		document.forms[0].hidBeanGetMethod.value="getStudentParticularsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/np_edustudent.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getStudentParticularsData";
		document.forms[0].action=appUrl+"action/np_edustudent.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(ConfirmMsg(101))
 	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateStudentParticularsData";
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidSourceUrl.value="action/np_edustudent.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
 	}
}

function disableCommandButtons(val)
{
	if(val=="load")
	{
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
	}
	if(val=="edit")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdapply.disabled=false;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmddel.disabled=false;
		document.forms[0].cmdclose.disabled=true;
		disableFields(false);
	}
}

function Calleduparticulars()
{
	document.forms[0].hidBeanId.value="eduparticulars"
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="http://172.16.2.193:8080/boblaps/action/eduparticulars.jsp"; 
	document.forms[0].hidSourceUrl.value="/action/eduparticulars.jsp";
	document.forms[0].submit()
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
	 	}	 
	 	if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
	 	}
	}
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
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

function allowIntegerOne(evt)
{ 
	evt=(evt) ? evt : window.event;
	var charCode =(evt.which) ? evt.which : evt.keyCode;
	if(charCode >31 && (charCode < 48 || charCode> 57))
	{
		return false;
	}
	return true;
}

function singlStatus()
{
	if(document.forms[0].mstatus.value=="Single"){
		document.all.abc1.style.visibility="hidden";
		document.all.abc1.style.visibility="absolute";
		document.all.abc2.style.visibility="hidden";
		document.all.abc2.style.visibility="absolute";
	}
	else
	{
		document.all.abc1.style.visibility="visible";
		document.all.abc1.style.visibility="relative";
		document.all.abc2.style.visibility="visible";
		document.all.abc2.style.visibility="relative";
	}
}

function showappholder()
{
	if((document.forms[0].hid_appholder.value=="N") || (document.forms[0].appstatus.value=="Processed/Rejected") || (document.forms[0].appstatus.value=="Processed/Approved"))
	{
		callDisableControls(true,true,true,true,false);
	}	
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading();onSelect();callonload();showappholder();">
<jsp:include page="../share/help.jsp" flush="true"> 
</jsp:include>
<form method="post" >
  <table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td> 
        <jsp:include page="../nationalportal/ApplurllinkNP.jsp" flush="true"> 
        <jsp:param name="pageid" value="12" />
        </jsp:include>
         </td>
    </tr>
  </table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td><font face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt;  National Portal Educational Loans</i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> 
       <lapschoice:application /> </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertablecolor" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="380">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table width="100%" border="0" cellspacing="3" cellpadding="3" align="left">
                      <tr> 
                        <td width="20%" align="center" class="tabactive" id="prm"> 
                          <b><font size="1" face="MS Sans Serif" color="#FFFFFF">Particulars 
                          of Student</font></b> </td>
                        <td width="20%" align="center" class="tabinactive" id="com2"><a href="javascript:callLink('np_edueducational.jsp','NationalPortal','getEducationalDetailsData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Educational 
                          Details</font></b></a></td>
                        <td width="20%" align="center" class="tabinactive" id="com2"> 
                          <a href="javascript:callLink('np_eduscholarship.jsp','NationalPortal', 'getScholarshipData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Scholarship 
                          </font></b></a></td>
						  
                           <td width="20%" align="center" class="tabinactive" id="com2"> 
                          <a href="javascript:callLink('np_eduparticulars.jsp','NationalPortal','getCourseDetailsData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Course 
                          Details </font></b></a></td>
						    
                        <td width="20%" align="center" class="tabinactive" id="com2"> 
                          <a href="javascript:callLink('np_educourse.jsp','NationalPortal','getCourseExpensesData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Course 
                          Expenses </font></b></a></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td>
                    <table border="1" cellspacing="0" cellpadding="3" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr> 
                              <td width="25%" ><font size="1" face="MS Sans Serif">Name 
                                of Student</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td colspan="2" > 
                                <input type="text" name="namefostudent" size="50" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("edu_name"))%>"  >
                              </td>
                              <td width="25%">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td width="25%" height="37"><font size="1" face="MS Sans Serif">Name 
                                of </font></td>
                              <td width="25%" height="37"> 
                                <select name="nameof" onChange="onChange()" style="width:28%">
                                  <option value="Father" selected>Father</option>
                                  <option value="Mother">Mother</option>
                                  <option value="Guardian">Guardian</option>
                                  <option value="Husband">Husband</option>
                                </select>
                                <input type="text" name="nameofval" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("edu_relname"))%>">
                              </td>
                              <td width="25%" height="37"><font size="1" face="MS Sans Serif">If 
                                Guardian state relationship</font></td>
                              <td width="25%" height="37"> 
                                <input type="text" name="guastaterelation" size="20" maxlength="50"  value="<%=Helper.correctNull((String)hshValues.get("edu_relgauratian"))%>">
                              </td>
                            </tr>
                            <tr id="parenid">
                              <td width="25%"> <font size="1" face="MS Sans Serif">Select Parent/Guardian Name(Required for Risk Analysis)</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%" >
							  <div align="left"> 
                                              <select name="parentname"  style="width:28%">
                                                <option value="" >--Select--</option>
                                                <lapschoice:fincoappguarantor/>
                                              </select>
                                            </div>
							  </td>
							  <td  style="visibility:hidden;postion:absolute"><font size="1" face="MS Sans Serif">Prior Work Exp Yrs<b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></font></td>
							  <td  style="visibility:hidden;postion:absolute">
                                <input type="text" size="20" name="priorexp" value="<%=Helper.correctNull((String)hshValues.get("edu_priorexp"))%>" onKeyPress="allowDecimals(this)">
                              </td>
                               </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Date 
                                of Birth of Student</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"> <table border="0" cellspacing="1" cellpadding="1" width="100%">
                                    <tr>
                                      <td width="20%"><input type="text" name="dob" readOnly  onBlur="checkDate(this)" size="11" value="<%=Helper.correctNull((String)hshValues.get("edu_dob"))%>" readonly size="13"></td>
									<td><a alt="Select date from calender" href="#"
									onClick="callCalender('dob')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
									border="0" alt="Select date from calender"></a></td>
                                    </tr>
                                </table>
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Age</font></td>
                              <td width="25%"> 
                                <input type="text" name="age" size="10" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("edu_age"))%>"  readOnly >
                                <%//=Helper.correctNull((String)hshValues.get("month"))%>
                                <%// out.println("Month");%>
                                <%//=Helper.correctNull((String)hshValues.get("day"))%>
                                <%// out.println("Day");%>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Caste</font></td>
                              <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                                  <td width="25%">
                              <select name="caste" tabindex="10">
											<option value="s">---Select---</option>
											<lapschoice:StaticDataTag apptype="123" />
										</select>
							  </td>
							  <%}else{ %>
								<td width="25%">
                                <input type="text" name="caste" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("edu_caste"))%>" >
                           		</td>
							  <%} %>
                              <td width="25%"><font size="1" face="MS Sans Serif">Religion</font></td>
                              <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                                 <td width="25%" ><select name="religion"   style="width:100px;font-weight: bold">
                                    <option value="s"  selected="selected">----Select----</option>
                                    <option value="1">Buddhist</option>
                                    <option value="2">Christian</option>
                                    <option value="3">Hindu</option>
                                    <option value="4">Jain</option>
                                    <option value="5">Muslim</option>
                                    <option value="6">Parsi</option>
                                    <option value="7">Sikh</option>
                                    <option value="8">Zorastrian</option>
                                    <option value="9">Others</option>
                                </select></td>
                                <%}else{ %>
                              <td width="25%"> 
                                <input type="text" name="religion" size="20" maxlength="50"  value="<%=Helper.correctNull((String)hshValues.get("edu_religion"))%>">
                              </td>
                              <%} %>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Marital 
                                Status </font></td>
                              <td width="25%"> 
                                <select value="0"name="mstatus"  style="width:28%" onchange="singlStatus()">
                                  <option value="0" selected>Select </option>
                                  <option value="Married">Married</option>
                                  <option value="Single">Single</option>
                                  <option value="Divirced">Divirced</option>
                                  <option value="Widowed">Widowed</option>
                                </select>
                              </td>
                              <td id="abc1" width="25%"><font size="1" face="MS Sans Serif">No 
                                of Children if any</font></td>
                              <td id="abc2" width="25%"> 
                                <input type="text" name="noofchildren" size="20" maxlength="2" value="<%=Helper.correctNull((String)hshValues.get("edu_child"))%>"  onKeyPress="allowInteger()" >
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Address1</font></td>
                              <td width="25%"> 
                                <input type="text" name="addr1" size="50"  maxlength="20"  value="<%=Helper.correctNull((String)hshValues.get("edu_addr1"))%>">
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Address2</font></td>
                              <td width="25%"> 
                                <input type="text" name="addr2" size="50" maxlength="20" value="<%=Helper.correctNull((String)hshValues.get("edu_addr2"))%>" >
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">City</font></td>
                              <td width="25%"> 
                                <input type="text" name="city" size="20" value="<%=Helper.correctNull((String)hshValues.get("edu_city"))%>" maxlength="10" >
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">State</font></td>
                              <td width="25%"> 
                                <input type="text" name="state" size="20" value="<%=Helper.correctNull((String)hshValues.get("edu_state"))%>" maxlength="10" >
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Pincode</font></td>
                              <td width="25%"> 
                                <input type="text" name="pincode" size="20"  maxlength="6"  value="<%=Helper.correctNull((String)hshValues.get("edu_pincode"))%>"  onKeyPress="allowInteger()">
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Stability of Income of parents </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"><select value="0"name="Parent_stability"  >
                                  <option value="0" selected>Select </option>
                                  <lapschoice:StaticDataTag apptype="11"/> 
								  </select></td>
                            </tr>
                            <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                            <tr>
                            <td width="25%" nowrap="nowrap"><font size="1" face="MS Sans Serif">Eligible for Interest Subsidy</font>
                            <b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                            <td width="25%" nowrap="nowrap"> <select name="sel_intSubsidy" style="width:28%" onchange="">
                                 <option value="s" >----Select----</option>
                                 <option value="0">No</option>
                                 <option value="1">Yes</option>
                                 </select>
                            </td>
                            <td width="25%"><font size="1" face="MS Sans Serif">Year of parents Income</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"> 
                               <input type="text" name="txt_incYear" size="20"  maxlength="4"  value="<%=Helper.correctNull((String)hshValues.get("EDU_PARENTS_INCYEAR"))%>"  onkeypress="return allowIntegerOne(event);">
                                
                              </td>
                            </tr>
                            <tr>
                            <td width="25%"><font size="1" face="MS Sans Serif">Amount of parents Income</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"> 
                            		 <input type="text" name="txt_incAmt" size="20"  maxlength="15"  value="<%=Helper.correctNull((String)hshValues.get("EDU_PARENTS_INCAMT"))%>"  onkeypress="return allowIntegerOne(event);""> 
                              
                              </td>
                              <td width="25%"><font size="1" face="MS Sans Serif">Income Certificate Issued By</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"> 
                                <input type="text" name="txt_incCert_issuedBy" size="20"  maxlength="40"  value="<%=Helper.correctNull((String)hshValues.get("EDU_INCERTIFICATE_ISSUEDBY"))%>"  onKeyPress="return allowAlphaNumericOne(event);">
                              </td>
                            </tr>
                            <tr>
                            <td width="25%"><font size="1" face="MS Sans Serif">Income Certificate Number</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                              <td width="25%"> 
                                <input type="text" name="txt_incCert" size="20"  maxlength="40"  value="<%=Helper.correctNull((String)hshValues.get("EDU_INCERTIFICATE_NUMBER"))%>"  onKeyPress="return allowAlphaNumericOne(event);">
                              </td>
                              </tr>
                            <%} %>
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
    </tr>
  </table>
  <br>

  <%String strappno = request.getParameter("appno");
  %>
    <lapschoice:combuttons  apporgcode="<%=strappno%>" strSource=""/>

	<input type="hidden" name="hidAction" value="">
	<input type="hidden" name="hidBeanId" value="">
	<input type="hidden" name="hidBeanMethod" value="">
	<input type="hidden" name="hidSourceUrl" value="">
	<INPUT TYPE="hidden" name="hidBeanGetMethod" value="">
	<input type="hidden" name="hidflag" value="">
	<input type="hidden" name="hidAppType" value="" >
	<INPUT TYPE="hidden" name="trapEdit" value="" >
	<INPUT TYPE="hidden" name="page" value="">

	<INPUT TYPE="hidden" name="hidCoDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidCoDemoId"))%>" >
	<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>">
	<INPUT TYPE="hidden" name="hidAppType" value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>">
	<INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidGuaDemoId"))%>">
	<INPUT TYPE="hidden" name="radLoan" value="Y">
	<INPUT TYPE="hidden" name="hiPgDist" value="P">
	<input type="hidden" name="month" value="<%=Helper.correctNull((String)hshValues.get("month"))%>">
	<input type="hidden" name="day" value="<%=Helper.correctNull((String)hshValues.get("day"))%>">
</form>
</body>
</html>

