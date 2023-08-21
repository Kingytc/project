<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>

<lapschoice:handleerror />

<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<% String stroptions=" "; %>
<%

String strVal=Helper.correctNull((String)hshValues.get("edu_partfull"));

String strnature=Helper.correctNull((String)hshValues.get("EDU_STUDINGIN"));

String loan_recmdamt=Helper.correctNull((String)hshValues.get("loan_recmdamt"));

String loan_marginpercent=Helper.correctNull((String)hshValues.get("loan_marginpercent"));

String strscheme = (String)session.getAttribute("selectpurposeedu");

String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
String strLoanPurpose="",strQuota="",strCourseType="",strInstitution="",strCourseStream="";
if(strCanaraSyndBank.equalsIgnoreCase("C")){
strLoanPurpose=Helper.correctNull((String)hshValues.get("EDU_LOANPURPOSE"));
strQuota=Helper.correctNull((String)hshValues.get("EDU_QUOTA"));
strCourseType=Helper.correctNull((String)hshValues.get("EDU_COURSETYPE"));
strInstitution=Helper.correctNull((String)hshValues.get("EDU_INSTITUTION"));
strCourseStream=Helper.correctNull((String)hshValues.get("EDU_COURSESTREAM"));
}

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

<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script LANGUAGE="JavaScript"	src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>

<script>

var strvalue= "/jsp/perhlp/hlp_eduparticulars.jsp";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var strappeditsameregbranch="<%=session.getAttribute("HRBranchUserEdit")%>";
var varcourseval="<%=Helper.correctNull((String)hshValues.get("edu_courseval"))%>";
var varNameofInstitute="<%=Helper.correctNull((String)hshValues.get("edu_university"))%>";
var prdcode="<%=session.getAttribute("productcode")%>";
var scheme="<%=strscheme%>";
var varLoanPurpose = "<%=strLoanPurpose%>";
var varQuota = "<%=strQuota%>";
var varCourseType = "<%=strCourseType%>";
var varInstitution = "<%=strInstitution%>";
var varCourseStream = "<%=strCourseStream%>";
var varCanaraSyndBank="<%=strCanaraSyndBank%>";
var varAppholder="<%=session.getAttribute("AppHolder")%>";
var varUserId= "<%=session.getAttribute("strUserId")%>";
var varAppno= "<%=request.getParameter("appno")%>";

function onloading()
{

	disableCommandButtons("load");

var eduaicte ="<%=Helper.correctNull((String)hshValues.get("edu_aicte"))%>";
if(eduaicte == "1")
	document.forms[0].selRec.value= "1";
else if(eduaicte == "2")
		document.forms[0].selRec.value= "2";
		
	else if(eduaicte == "3")
		document.forms[0].selRec.value= "3";
		
		
else
		document.forms[0].selRec.value= "";
		
	if (document.forms[0].appstatus.value != "Open/Pending")
	{
		alert("Cannot modify --> APPROVED APPLICATION !!!")
		callDisableControls(true,true,true,true,false)
	}else{
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
	}}	
	/*if(varNameofInstitute!="")
	{
		document.forms[0].selInstitute.value=varNameofInstitute;
	}	
	else
	{
		document.forms[0].selInstitute.value="";
	}*/
	if(varcourseval!="")
			{
				document.forms[0].selvalofjob.value=varcourseval;
				
				
			}
			else 
			{
				document.forms[0].selvalofjob.value=0;
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
function doAfterEdit()
{
	
}
function doEdit()
{
		
		document.forms[0].hidflag.value ="edit";
		document.forms[0].hidAction.value ="update";
		disableCommandButtons("edit");
}

function onSelect()
{
	var selVall = "<%=strVal%>" ;
	
	if(selVall != "")
	{
		document.forms[0].select.value = selVall ;
	}
	
}

function onNature()
{
var selnature1 = "<%=strnature%>" ;
	
	if(selnature1!= "")
	{
		document.forms[0].natureofstudy.value = selnature1;
	}
}

function callregion()
{

    if(varCanaraSyndBank=="C"){
    	var india="D";
    	var abroad="A";		
    	var select="select";
    	var shanshidProductID=document.forms[0].natureofstudy.value;
    }
    else{
    var india="india";
	var abroad="abroad";		
	var select="select";
	
	var shanshidProductID=document.forms[0].natureofstudy.value;
    }
		if((prdcode=="965"|| prdcode=="977"  || prdcode=="949"|| prdcode=="947" || prdcode=="651"|| prdcode=="654"|| prdcode=="655" )&& (eval(shanshidProductID)!= eval(india)))
		
			{
					alert("This product is for students studying in India.Choose Studying in accordingly");
					document.forms[0].natureofstudy.value="select";
					return false
			}

		if((prdcode=="966"|| prdcode=="978" || prdcode=="950"|| prdcode=="948") && (eval(shanshidProductID)!= eval(abroad)))
			
			{
					alert("This product is for students studying in Abroad.Choose Studying in accordingly");
					document.forms[0].natureofstudy.value="select";
					return false
			}

}
function doApply()
{

	 if(varAppholder!=varUserId&&varAppno!="")
		{	
			alert("Your Not The Holder of the Application to Modify The Application");
			return;
		}	
	 else{
	if(document.forms[0].natureofstudy.value=="select" || document.forms[0].natureofstudy.value=="0" )
	{
		alert("Enter Studing in India or Abroad");
		document.forms[0].natureofstudy.focus();
		return false;
	} 
	if(document.forms[0].selInstitute.value=="" )
	{
		alert("Enter Name of University/Institution");
		document.forms[0].selInstitute.focus();
		return false;
	}
	if(document.forms[0].durofcourse.value=="")
	{
		alert("Enter Duration of Course");
		document.forms[0].durofcourse.focus();
		return false;
	}
	if(varCanaraSyndBank=="C"){
		if(document.forms[0].sel_purpLoan.value=="" || document.forms[0].sel_purpLoan.value=="s")
		{
			alert("Select Purpose of Loan");
			document.forms[0].sel_purpLoan.focus();
			return false;
		}
		if(document.forms[0].sel_quota.value=="" || document.forms[0].sel_quota.value=="s")
		{
			alert("Select Quota");
			document.forms[0].sel_quota.focus();
			return false;
		}
		if(document.forms[0].sel_CourseType.value=="" || document.forms[0].sel_CourseType.value=="s")
		{
			alert("Select Course Type");
			document.forms[0].sel_CourseType.focus();
			return false;
		}
		if(document.forms[0].sel_instCat.value=="" || document.forms[0].sel_instCat.value=="s")
		{
			alert("Select Institution Category");
			document.forms[0].sel_instCat.focus();
			return false;
		}
		if(document.forms[0].sel_courStream.value=="" || document.forms[0].sel_courStream.value=="s")
		{
			alert("Select Course Stream");
			document.forms[0].sel_courStream.focus();
			return false;
		}
		if(document.forms[0].txt_courCompDate.value=="")
		{
			alert("Enter Course Completion Date");
			document.forms[0].txt_courCompDate.focus();
			return false;
		}
	    }

	if(document.forms[0].nameofcourse.value=="")
	{
		alert("Please enter the Name of course");
		document.forms[0].nameofcourse.focus();
		return false;
	}

	if(document.forms[0].selInstitute.value=="")
	{
		alert("Please enter name of University/Institution");
		document.forms[0].selInstitute.focus();
		return false;
	}
	var varUniv = document.forms[0].selInstitute.value;
	var varCourse = document.forms[0].nameofcourse.value;
	
	if(varUniv.length > 40){
		alert("Name of University/Institution should be less than 40 character");
		document.forms[0].selInstitute.focus();
		return false;
	}
	if(varCourse.length > 40){
		alert("Name of Course should be less than 40 character");
		document.forms[0].nameofcourse.focus();
		return false;
	}

	var regex = /^[A-Za-z0-9 ]+$/;
    var isValid = regex.test(varUniv);
	var isValid1 = regex.test(varCourse);
    if (!isValid){
    	alert("Please remove special characters in Name of University/Institution");
		document.forms[0].selInstitute.focus();
		return false;
    }
    if (!isValid1){
    	alert("Please remove special characters in Name of Course");
		document.forms[0].nameofcourse.focus();
		return false;
    }
	/**(scheme=="16")
	{
		if(trim(document.forms[0].nameofcoursesoff.value)=="")
		{
			alert("Enter Synd Super Vidya Courses Offered/Institute");
			document.forms[0].nameofcoursesoff.focus();
			return false;
		}	
	}**/	
		
     if(document.forms[0].selvalofjob.value=="0" ||document.forms[0].selvalofjob.value=="" )
	{
		alert("Select Value of course/Job Prospects");
		document.forms[0].selvalofjob.focus();
		return false;
	}
	document.forms[0].natureofstudy.disabled = false; 
	document.forms[0].durofcourse.disabled = false; 
	document.forms[0].sel_CourseType.disabled = false; 
	document.forms[0].txt_courCompDate.disabled = false; 
                        
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="NationalPortal"
		document.forms[0].hidBeanMethod.value="updateCourseDetailsData";
		document.forms[0].hidBeanGetMethod.value="getCourseDetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/np_eduparticulars.jsp";
		document.forms[0].submit();
	 }	
}
function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="NationalPortal";
		document.forms[0].hidBeanGetMethod.value="getCourseDetailsData";
		document.forms[0].action=appUrl+"action/np_eduparticulars.jsp";
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
			document.forms[0].hidBeanMethod.value="updateCourseDetailsData";
			document.forms[0].hidBeanId.value="NationalPortal";
			document.forms[0].hidSourceUrl.value="action/np_eduparticulars.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		 }
  }

function disableCommandButtons(val)
{
  if(val=="load")
  {
	  
	  document.forms[0].cmdedit.disabled=false;
	  document.forms[0].cmdapply.disabled=true;
	  document.forms[0].cmdcancel.disabled=true;
	  document.forms[0].cmddel.disabled=true;
	  document.forms[0].cmdclose.disabled=false;
	  disableFields(true);
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
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
	  }
	    document.forms[0].natureofstudy.disabled = true; 
		document.forms[0].durofcourse.disabled = true; 
		document.forms[0].sel_CourseType.disabled = true; 
		document.forms[0].txt_courCompDate.disabled = true; 
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

function calCourseDetails(){
	if(varCanaraSyndBank=="C"){
	if(varLoanPurpose!= "")
	{
		document.forms[0].sel_purpLoan.value = varLoanPurpose;
	}
	if(varQuota!= "")
	{
		document.forms[0].sel_quota.value = varQuota;
	}
	if(varCourseType!= "")
	{
		document.forms[0].sel_CourseType.value = varCourseType;
	}
	if(varInstitution!= "")
	{
		document.forms[0].sel_instCat.value = varInstitution;
	}
	if(varCourseStream!= "")
	{
		document.forms[0].sel_courStream.value = varCourseStream;
	}
	}
}
function DisableCopyPaste(e) 
{
 // Message to display
 var message = "Cntrl key/ Right Click Option disabled";
 // check mouse right click or Ctrl key press
var kCode = e.keyCode; 
//FF and Safari use e.charCode, while IE use e.keyCode
 if (kCode == 17 || kCode == 0)
 {
 alert(message);
 return false;
 }
 else{
	 allowNumeric(kCode)
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

<body class="bgcolor" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="onloading();onSelect();onNature();calCourseDetails();showappholder();">
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
      <td><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
        </i></b></font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt; 
        Retail</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="2" face="Times New Roman, Times, serif"><b><i><font size="3"> 
        </font></i></b></font> <font size="3"><i><b><font face="Times New Roman, Times, serif">-&gt;</font><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Existing</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></b></i></font><font size="4"><b><i> 
        </i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
        <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"> 
        <b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font size="3" face="Times New Roman, Times, serif"><b><i>Educational 
        Loans</i></b></font></td>
    </tr>
  </table>
  <table width="100%" border="0" cellpadding="0" cellspacing="0">
    <tr> 
      <td> 
               <lapschoice:application /> </td>
    </tr>
  </table>
 
 
  <table width="100%" height="380" border="1" cellpadding="5" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" class="outertablecolor">
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
                           <td width="20%" align="center" class="tabinactive" id="prm"> <b><font size="1" face="MS Sans Serif" color="#FFFFFF"><a href="javascript:callLink('np_edustudent.jsp','NationalPortal','getStudentParticularsData')" class="blackfont">Particulars of Student</a></font></b> </td>
				            <td width="20%" align="center" class="tabinactive" id="com2"><a href="javascript:callLink('np_edueducational.jsp','NationalPortal','getEducationalDetailsData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Educational Details</font></b></a></td>
				            <td width="20%" align="center" class="tabinactive" id="com2"><a href="javascript:callLink('np_eduscholarship.jsp','NationalPortal','getScholarshipData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Scholarship</font></b></td>
				            <td width="20%" align="center" class="tabactive" id="com2"><b><font size="1" face="MS Sans Serif">Course Details </font></b></td>
				            <td width="20%" align="center" class="tabinactive" id="com2"> <a href="javascript:callLink('np_educourse.jsp','NationalPortal','getCourseExpensesData')" class="blackfont"><b><font size="1" face="MS Sans Serif">Course Expenses </font></b></a></td>
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
                              <td width="25%"><font size="1" face="MS Sans Serif"></font></td>
                              <td> </td>
                              <td><font size="1" face="MS Sans Serif"></font>Studying 
                                in <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                                 <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                                 <td width="25%"> 
                                <select value="0" name="natureofstudy" onChange="callregion()" style="width: 30%">
                                	<option value="select" selected><--- Select ---></option>
                                    <lapschoice:StaticDataTag apptype="151"/> 
                                </select>
                              </td>
                                 <%}else{ %>
                              <td width="25%"> 
                                <select value="0" name="natureofstudy" onChange="callregion()" style="width: 30%">
                                	<option value="select" selected><--- Select ---></option>
                                  <option value="india" selected>India</option>
                                  <option value="abroad">Abroad</option>
                                </select>
                              </td>
                              <%} %>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Name 
                                of course </font><font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td> 
                                <input type="text" name="nameofcourse" size="30" maxlength="40" onKeyPress="return allowAlphaNumericOne(event);" onKeyDown="return DisableCopyPaste(event)" onMouseDown="return DisableCopyPaste(event)"  value="<%=Helper.correctNull((String)hshValues.get("edu_coursename"))%>" >
                              </td>
                              <td><font size="1" face="MS Sans Serif">Name of 
                                University/Institution</font><font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%">
                              <!--<select name="selInstitute">
                              <option value="s" selected><--- Select </option>
                               <lapschoice:StaticDataTag apptype="36"/>
                              </select> -->
                                                              
                                <input type="text" name="selInstitute" size="50" maxlength="40" onKeyPress="return allowAlphaNumericOne(event);" onKeyDown="return DisableCopyPaste(event)" onMouseDown="return DisableCopyPaste(event)" value="<%=Helper.correctNull((String)hshValues.get("edu_university"))%>">  
                             
                              </td>
                            </tr>
                            <tr> 
                            <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                            <td width="25%"><font size="1" face="MS Sans Serif">Duration of course (in Months)</font>
                            <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                            <td width="25%"> 
                                <input type="text" name="durofcourse" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("COURSE_REMAINING_DURATION"))%>">
                              </td>
                            <%}else{ %>
                            <td width="25%"><font size="1" face="MS Sans Serif">Duration of course</font></td>
                              <td width="25%"> 
                                <input type="text" name="durofcourse" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("edu_duration"))%>">
                              </td>
                              <%} %>
                              <td width="25%"><font size="1" face="MS Sans Serif">Part 
                                - Time/ Full -Time</font></td>
                              <td width="25%"> 
                                <select value="0" name="select"  style="width: 30%">
                                  <lapschoice:NationalPortalStaticDataTag apptype="4"/> 
                                </select>
                              </td>
                            </tr>
                            <%if(strCanaraSyndBank.equalsIgnoreCase("C")){ %>
                            <tr>
                            <td width="25%"><font size="1" face="MS Sans Serif">Purpose of Loan</font>
                            <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <select name="sel_purpLoan"  onchange="" style="width: 30%">
                                  <option value="s" selected>---Select--- </option>
                                  <lapschoice:StaticDataTag apptype="152"/> 
							    </select></td>
							<td width="25%"><font size="1" face="MS Sans Serif">Course Type</font>
							<font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <select name="sel_CourseType"  onchange="" style="width: 30%">
                                  <option value="s" selected>---Select--- </option>
                                  <lapschoice:StaticDataTag apptype="153"/> 
							    </select></td>    
                            </tr>
                            <tr>
                            <td width="25%"><font size="1" face="MS Sans Serif">Quota</font>
                            <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <select name="sel_quota"  onchange="" style="width: 30%">
                                  <option value="s" selected>---Select--- </option>
                                  <lapschoice:NationalPortalStaticDataTag apptype="2"/> 
							    </select></td>
							<td width="25%"><font size="1" face="MS Sans Serif">Institution Category</font>
							<font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <select name="sel_instCat"  onchange="" style="width: 30%">
                                  <option value="s" selected>---Select--- </option>
                                  <lapschoice:StaticDataTag apptype="154"/> 
							    </select></td>    
                            </tr>
                            <tr>
                            <td width="25%"><font size="1" face="MS Sans Serif">Course Stream</font>
                            <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <select name="sel_courStream"  onchange="" style="width: 30%">
                                  <option value="s" selected>---Select--- </option>
                                  <lapschoice:StaticDataTag apptype="155"/> 
							    </select></td>
							<td width="25%"><font size="1" face="MS Sans Serif">Course completion date</font>
							<font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <input type="text" name="txt_courCompDate" size="24" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("EDU_COURCOMPLETION_DATE"))%>" 
                                readonly="readonly" onblur="checkDate(this);">&nbsp;&nbsp;<a href="#" onClick="callCalender('txt_courCompDate')" onMouseOver="window.status='Date Picker';return true;" 
					            onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/gold/calen.gif" alt="Select date from calender" width="20" height="18"
					            border="0" class="mandatory-textfld" ></a>
                              </td>    
							</tr><!--
							<tr>
							<td width="25%"><font size="1" face="MS Sans Serif">Certificate obtained upto</font>
							<font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td width="25%"> 
                                <input type="text" name="txt_certObtUpto" size="20" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("EDU_CERTIFICATE_UPTO"))%>" 
                                readonly="readonly" onblur="checkDate(this);">&nbsp;&nbsp;<a href="#" onClick="callCalender('txt_certObtUpto')" onMouseOver="window.status='Date Picker';return true;" 
					            onMouseOut="window.status='';return true;"><img src="<%=ApplicationParams.getAppUrl()%>img/gold/calen.gif" alt="Select date from calender" width="20" height="18"
					            border="0" class="mandatory-textfld" ></a>
                              </td>    
							</tr>
                            --><%} %>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">AICTE 
                                Recognition</font></td>
                              <td width="25%"> 
                                <select name="selRec"  style="width: 30%">
                                  <option value="" selected>Select</option>
                                  <option value="1">Recognised</option>
                                  <option value="2">UnRecognised</option>
                                  <option value="3">Not Applicable</option>
                                </select>
                                <b><font size="1" face="MS Sans Serif"> </font></b></td>
                                <td width="25%"><font size="1" face="MS Sans Serif">Appraisal  Remarks on  Recognition of University/College/Institution</font></td>
                                <td colspan="3"> 
                                <textarea name="txt_AppraisalRemarks" cols="75" rows="3" ><%=Helper.correctNull((String)hshValues.get("edu_apraisalremarks"))%></textarea>
                              </td>
                                
                                <!--
                                <%if(strscheme.equals("16")) {%>
                                <td width="25%"><font size="1" face="MS Sans Serif">Synd Super Vidya Courses Offered/Institute</font> <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                                <td width="25%"><input type="text" name="nameofcoursesoff" size="30" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("edu_coursesoff"))%>"></td>
                            	<%} %>
                            	
                            --></tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Other 
                                information in case of studies abroad</font></td>
                              <td colspan="3"> 
                                <textarea name="information" cols="75" rows="3" ><%=Helper.correctNull((String)hshValues.get("edu_other"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Any 
                                Other Information </font></td>
                              <td colspan="3"> 
                                <textarea name="AnyInfor" cols="75" rows="3" ><%=Helper.correctNull((String)hshValues.get("edu_any"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%"><font size="1" face="MS Sans Serif">Insurance 
                                Details</font></td>
                              <td colspan="3"> 
                                <textarea name="InforDet" cols="75" rows="3"><%=Helper.correctNull((String)hshValues.get("edu_insurance"))%></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="25%" nowrap><font size="1" face="MS Sans Serif">Value 
                                of course/Job Prospects </font> <font size="1" face="MS Sans Serif" color="#FF0000"><b>*</b></font></td>
                              <td colspan="3"><b><font size="1" face="MS Sans Serif"> 
                                <select name="selvalofjob"
													tabindex="12">
                                  <option value="0" selected><----Select----> </option>
                                  <lapschoice:StaticDataTag apptype="5"/> 
                                </select>
                                </font></b></td>
                            </tr>
                          </table>
                          <br><br>
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
<INPUT TYPE="hidden" name="hidAppType">
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl">
<INPUT TYPE="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidflag" value="">
<input type="hidden" name="hidAppType" >
   <INPUT TYPE="hidden" name="trapEdit" >
    <INPUT TYPE="hidden" name="page">
	<INPUT TYPE="hidden" name="hidCoDemoId" value="<%=request.getParameter("hidCoDemoId")%>" >
  <INPUT TYPE="hidden" name="hidDemoId" value="<%=request.getParameter("hidDemoId")%>">
  <INPUT TYPE="hidden" name="hidAppType" value="<%=Helper.correctNull((String)hshValues.get("hidAppType"))%>">
  <INPUT TYPE="hidden" name="hidGuaDemoId" value="<%=request.getParameter("hidGuaDemoId")%>">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
  <INPUT TYPE="hidden" name="hiPgDist" value="P">

</form>
</body>
</html>

