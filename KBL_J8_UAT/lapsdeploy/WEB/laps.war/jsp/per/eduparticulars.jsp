<%@include file="../share/directives.jsp"%>
<%
	String strsplscheme = Helper.correctNull((String)hshValues.get("splscheme"));
	String strPrdType=Helper.correctNull((String)hshValues.get("strPrdType"));
	String strPageParam = Helper.correctNull((String) session.getAttribute("strModifyterms")).trim();
	String strFlag="N";
	if(strPageParam.contains("COEX"))
	{
		strFlag="Y";
	}
%>
<html>
<head>
<title>Education Particulars</title>
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
var varFlag="<%=strFlag%>";
var strEdu_course_approved="<%=Helper.correctNull((String) hshValues
							.get("edu_course_approved"))%>";
var strEdu_univ_approved="<%=Helper.correctNull((String) hshValues
							.get("edu_univ_approved"))%>";
var strEdu_partfull="<%=Helper.correctNull((String) hshValues
									.get("edu_partfull"))%>";
var strEdu_qual_proposed="<%=Helper.correctNull((String) hshValues
							.get("edu_qual_proposed"))%>";
var strEdu_mode_secure="<%=Helper.correctNull((String) hshValues
							.get("edu_mode_secure"))%>";
var strEdu_univ_situ_domicile="<%=Helper.correctNull((String) hshValues
							.get("edu_univ_situ_domicile"))%>";
var strEdu_comp_stay_hostel="<%=Helper.correctNull((String) hshValues
							.get("edu_comp_stay_hostel"))%>";
var stredu_studies_in="<%=Helper.correctNull((String) hshValues
							.get("prd_purpose"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varPrdType="<%=strPrdType%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varUnivName ="<%=Helper.correctNull((String) hshValues.get("edu_univ_name"))%>";
var currentdate ="<%=Helper.getCurrentDateTime()%>";
var varCourseType="<%=Helper.correctNull((String)hshValues.get("edu_typeofcourse"))%>";
var varSchemetype="<%=Helper.correctNull((String)hshValues.get("edu_schemetype"))%>";
var varothersubsidy="<%=Helper.correctNull((String)hshValues.get("EDU_OTHR_SUBSIDY"))%>";
var varIncCertificate="<%=Helper.correctNull((String)hshValues.get("EDU_INC_CERT"))%>";
var varIncCertAuthority="<%=Helper.correctNull((String)hshValues.get("EDU_INC_CERT_AUTHORITY"))%>";

var varProposalType = "<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";

function onloading()
{
	document.forms[0].sel_studentmeri.value="<%=Helper.correctNull((String) hshValues.get("EDU_MERITORIOUS"))%>";
	document.forms[0].cbostudies.disabled=false;
	<%if(strsplscheme.equalsIgnoreCase("Y"))
	{%>
	if(varUnivName!="")
	{
		document.forms[0].txtnameofunins.value=varUnivName;
	}
	else
	{
		document.forms[0].txtnameofunins.value="0";
	}
	<%
	}%>
	if(strEdu_course_approved!="")
	{
		document.forms[0].cboapprovedcourse.value=strEdu_course_approved;
	}
	else
	{
		document.forms[0].cboapprovedcourse.value="0";
	}
	if(strEdu_univ_approved!="")
	{
		document.forms[0].cboapprovedinsti.value=strEdu_univ_approved;
	}
	else
	{
		document.forms[0].cboapprovedinsti.value="0";
	}
	if(stredu_studies_in!="")
	{
	  document.forms[0].cbostudies.value=stredu_studies_in;
	}
	else
	 {
	  document.forms[0].cbostudies.value="0";
	 }
	if(strEdu_partfull!="")
	{
		document.forms[0].cbocoursetype.value=strEdu_partfull;
		  
	}
	else
	{
		document.forms[0].cbocoursetype.value="0";
	}
	if(strEdu_qual_proposed!="")
	{
		document.forms[0].cboqualproposed.value=strEdu_qual_proposed;
	}
	else
	{
		document.forms[0].cboqualproposed.value="0";
	}
	if(strEdu_mode_secure!="")
	{
		document.forms[0].cbomodeofsecure.value=strEdu_mode_secure;
	}
	else
	{
		document.forms[0].cbomodeofsecure.value="0";
	}
	if(strEdu_univ_situ_domicile!="")
	{
		document.forms[0].cboinstdomicile.value=strEdu_univ_situ_domicile;
	}
	else
	{
		document.forms[0].cboinstdomicile.value="0";
	}
	if(strEdu_comp_stay_hostel!="")
	{
		document.forms[0].cbocomphostel.value=strEdu_comp_stay_hostel;
	}
	else
	{
		document.forms[0].cbocomphostel.value="2";
	}
	if(varCourseType!="")
	{
		document.forms[0].seltypeofcourse.value=varCourseType;
	}
	else
	{
		document.forms[0].seltypeofcourse.value="0";
	}
	if(varSchemetype!="")
	{
		document.forms[0].selscheme.value=varSchemetype;
	}
	else
	{
		document.forms[0].selscheme.value="N";
	}
	if(varothersubsidy!="")
	{
		document.forms[0].sel_othersubsidy.value=varothersubsidy;
	}
	else
	{
		document.forms[0].sel_othersubsidy.value="s";
	}
	if(varIncCertificate!="")
	{
		document.forms[0].sel_inc_cert.value=varIncCertificate;
	}
	else
	{
		document.forms[0].sel_inc_cert.value="s";
	}
	if(varIncCertAuthority!="")
	{
		document.forms[0].sel_inc_cert_authority.value=varIncCertAuthority;
	}
	else
	{
		document.forms[0].sel_inc_cert_authority.value="s";
	}
	disableFields(true);
	if(varProposalType == "P")
	{
		document.all.postsancFields.style.display = "table-row";
		if(varFlag=="Y")
			document.forms[0].cmdedit.disabled=false;
		else
			document.forms[0].cmdedit.disabled=true;
	}
	else
	{
		document.all.postsancFields.style.display = "none";
	}
}

function doEdit()
{
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].cbostudies.disabled=true;
	if(varProposalType == "P")
	{
		if(varFlag == "Y")
		{
			disableFields(true);
			document.forms[0].txtdurofcourse_extend.readOnly = false;
			document.forms[0].txt_crse_strt_date.readOnly = false;
		}
		else
		{
			disableFields(true);
		}
	}
}

function callCalender(name)
{
	if(varProposalType == "P" && name != "txt_crse_strt_date")
	{
		return false;
	}
	if(document.forms[0].hideditflag.value=="Y")
	{
		showCal(appURL,name);
	}
}

function doSave()
{
	//document.forms[0].cbostudies.disabled=false;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(varProposalType == "P")
	{
		if(varFlag == "Y")
		{
			if(document.forms[0].txtdurofcourse_extend.value=="")
			{
				alert("Enter Duration of course extended");
				document.forms[0].txtdurofcourse_extend.focus();
				return;
			}
		}
	}
	else
	{
	  	if(document.forms[0].txtnameofcourse.value=="")
	   		{
	    	alert("Enter Name of course");
	    	document.forms[0].txtnameofcourse.focus();
	    	return;
	   		}
			
		if(document.forms[0].txtnameofunins.value=="" || document.forms[0].txtnameofunins.value=="0")
		{
	  		alert("Enter Name of University/Institutuion");
	  		document.forms[0].txtnameofunins.focus();
	  		return;
		}
		if(document.forms[0].cboqualproposed.value=="0")
	      	{
	        alert("Select Edu. Qualification Proposed ");
	        document.forms[0].cboqualproposed.focus();
	        return;        
	      	}
	    if(document.forms[0].cbocoursetype.value=="0")
	    	{
	        alert("select Type of Course");
	        document.forms[0].cbocoursetype.focus();
	        return;
	       	}
		if(document.forms[0].cbostudies.value=="0")
	    	{
	        alert("Select Studies");
	        document.forms[0].cbostudies.focus();
	        return;
	        }
		
		if(document.forms[0].txt_markseq.value=="" || document.forms[0].txt_markseq.value=="0")
	    	{
	        alert("Enter Marks Secured");
	        document.forms[0].txt_markseq.focus();
	        return;
	        }
		if(document.forms[0].sel_othersubsidy.value=="s")
	    {
	      alert("Select Availed other subsidy");
	      if(varProposalType == "P" && varFlag=="Y")
	  	  {
	    	  document.forms[0].sel_othersubsidy.disabled=false;
	  	  }
	      document.forms[0].sel_othersubsidy.focus();
	      return;
	    }
		if(document.forms[0].sel_inc_cert.value=="s")
	    {
	      alert("Select Income Certificate availability");
	      if(varProposalType == "P" && varFlag=="Y")
	  	  {
	    	  document.forms[0].sel_inc_cert.disabled=false;
	  	  }
	      document.forms[0].sel_inc_cert.focus();
	      return;
	    }
	    if(document.forms[0].sel_inc_cert.value=="Y")
	    {
	    	if(document.forms[0].txt_inc_cert_number.value=="")
	        {
	          alert("Enter Income Certificate number");
	          if(varProposalType == "P" && varFlag=="Y")
	      	  {
	        	  document.forms[0].txt_inc_cert_number.readOnly=false;
	      	  }
	          document.forms[0].txt_inc_cert_number.focus();
	          return;
	        }
	    	if(document.forms[0].txt_inc_cert_date.value=="")
	        {
	          alert("Enter Income Certificate issue date");
	          if(varProposalType == "P" && varFlag=="Y")
	      	  {
	        	  document.forms[0].txt_inc_cert_date.readOnly=false;
	      	  }
	          document.forms[0].txt_inc_cert_date.focus();
	          return;
	        }
	    	if(document.forms[0].sel_inc_cert_authority.value=="s")
	        {
	          alert("Select Income Certificate issuing authority");
	          if(varProposalType == "P" && varFlag=="Y")
	      	  {
	        	  document.forms[0].sel_inc_cert_authority.disabled=false;
	      	  }
	          document.forms[0].sel_inc_cert_authority.focus();
	          return;
	        }
	    }
	    else
	    {
	    	document.forms[0].txt_inc_cert_number.value = "";
			document.forms[0].txt_inc_cert_date.value = "";
			document.forms[0].sel_inc_cert_authority.value = "s";
	    }
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].cbostudies.disabled = false;
	disableFields(false);
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="eduparticulars"
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/eduparticulars.jsp";
	document.forms[0].submit();	
	}
 
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="eduparticulars";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/eduparticulars.jsp";
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
			document.forms[0].hidBeanId.value="eduparticulars";
			document.forms[0].hidSourceUrl.value="/action/eduparticulars.jsp";	
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
	if (document.forms[0].hideditflag.value=="N")
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

var strvalue="loan_appretail_eduloan_courdet.htm";
function doHelp()     
{
	var hlpvar = appURL+"phlp/loan_appretail_eduloan_courdet.htm";
	var title = "CourseDetails";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}

function funStudentmer()
{
	var varstudent=document.forms[0].sel_studentmeri.value;
if((varstudent=="2")||(varstudent==""))
{
	document.all.id1.style.visibility="hidden";
	document.all.id1.style.position="absolute";
	document.all.id2.style.visibility="hidden";
	document.all.id2.style.position="absolute";
	document.forms[0].txt_markseq.value="";
}
else
{
	document.all.id1.style.visibility="visible";
	document.all.id1.style.position="relative";
	document.all.id2.style.visibility="visible";
	document.all.id2.style.position="relative";

}
}

function clearDetails()
{
	if(document.forms[0].sel_inc_cert.value != "Y")
	{
		document.forms[0].txt_inc_cert_number.value = "";
		document.forms[0].txt_inc_cert_date.value = "";
		document.forms[0].sel_inc_cert_authority.value = "s";
	}
}

function funStudies()
{
	var varstudies=document.forms[0].cbostudies.value;
	
	if(varstudies=="A")
	{
		document.all.id3.style.visible="visible";
		document.all.id3.style.position="relative"
		document.all.id4.style.visible="visible";
		document.all.id4.style.position="relative"
	}
	else
	{
		document.all.id3.style.visibility="hidden";
		document.all.id3.style.position="absolute";
		document.all.id4.style.visibility="hidden";
		document.all.id4.style.position="absolute";
	}

}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();funStudies()">
<form method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="102" />
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
			<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><b><a
					href="#" onclick="javascript:callLink('perloandetails.jsp','perapplicant','getLoanProducts')">
					Loan Product</a></b></b></td>
			<%if ((strPrdType.equalsIgnoreCase("pI")) && (strPageParam.contains("@SEC@")||strPageParam.contains("@MODSEC@"))) { %>
			<td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('per_instacash.jsp','perapplicant','getinstacash')">
					Insta Cash</a></b></b></td>
					<%} %>
					<td class="sub_tab_active" id="prin" nowrap width="150px;" align="center"><b>Course Details</b></td>
					<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><b><a
					href="#" onclick="javascript:callLink('percoappguarantor.jsp','perapplicant','getCoAppGuarantor')">
					Co-Applicant / Guarantor</a></b></b></td>
					<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><b><a
					href="#" onclick="javascript:callLink('com_otherpostsanctionparams.jsp?hidPageVal=otherparams','facilities','getComments')">
					Other Post Sanction Parameters</a></b></b></td>
			</tr>
			</table>
  			</td>
  		</tr>
  </table>
	<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td valign="bottom">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="left">
			<tr align="center">
				<td><jsp:include page="../share/Applurllinkper.jsp"
					flush="true">
					<jsp:param name="pageid" value="1" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="99%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application -&gt;
		Loan Particulars -&gt; Details for Education Loan -&gt; Course Details</td>
	</tr>
</table>
<table width="99%" border="0" cellpadding="0" cellspacing="0"
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
			class="outertable" align="left">
			<tr align="center">
				<td><jsp:include page="../per/applicanttab.jsp" flush="true">
					<jsp:param name="linkid" value="7" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%} %>
<table width="99%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3"
			class="outertable" align="left">
			<tr align="center">
			<!-- 	<td width="20%" id="prm" class="sub_tab_inactive"><b><a
					href="javascript:callLink('edustudent.jsp','edustudent','getData')">Particulars
				of Student</a></b></td> -->
				<td width="20%" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('edueducational.jsp','edudetails','getData')"><b>Educational
				Details</b></a></td>
				<td width="20%" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('eduscholarship.jsp','eduscholar','getData')"><b>Scholarship
				</b></a></td>
				<td width="20%" id="com2" class="sub_tab_active"><b>Course
				Details </b></td>
				<td width="20%" id="com2" class="sub_tab_inactive"><a
					href="javascript:callLink('educourse.jsp','eduscholar','getDataExp')"><b>Course
				Expenses </b></a></td>
			</tr>
		</table>
		</td>
	</tr>
<%} %>
	<tr>
		<td>
		<table border="1" cellspacing="0" cellpadding="3" width="100%"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4"
					class="outertable">
					<tr>
						<td width="26%">Course Specialization</td>
						<td width="24%"><select name="seltypeofcourse">
							<option value="0" selected="selected"><--Select--></option>
							<lapschoice:StaticDataTag apptype="190"/>
						</select> 
						</td>
						<td width="25%">Whether covered under Rajiv Gandhi Loan Scholarship Scheme-Interest
						 Subsidy Scheme of the Government of Karnataka </td>
						<td width="25%"><select name="selscheme" tabindex="14">
							<option value="N">No</option>
							<option value="Y">Yes</option>
						</select></td>
					</tr>
					<tr>
						<td width="26%">Name of course<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="24%"><input type="text" name="txtnameofcourse"
							size="50" maxlength="100"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_coursename"))%>"
							tabindex="1"></td>
						<td width="25%">Is it an approved course &amp; Recognized by</td>
						<td width="25%"><select name="cboapprovedcourse" tabindex="4">
							<option value="0" selected="selected">Select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select> <input type="text" name="txtcourseapprby" size="33"
							maxlength="200"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_course_approvedby"))%>"
							tabindex="5"></td>
					</tr>
					<tr>
						<td width="26%">Name of University/Institution<b><span
							class="mantatory">*&nbsp;</span></b></td>
							<%
							if(strsplscheme.equalsIgnoreCase("Y")){
							%>
							
							<td width="24%">
								<select name="txtnameofunins">
									<option value ="0" selected>-----------select------------</option>
									<%String apptypecon = "83";	%>
									<lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
								</select>
							</td>
							<%}else{ %>
								<td width="24%"><input type="text" name="txtnameofunins"
								size="50" maxlength="50"
								value="<%=Helper.correctNull((String) hshValues
								.get("edu_univ_name"))%>"
								tabindex="2"></td>
							<%} %>
						<td width="25%">Is it a Recognized University/Institution
						&amp;Recognized by</td>
						<td width="25%"><select name="cboapprovedinsti" tabindex="6">
							<option value="0" selected="selected">Select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select> <input type="text" name="txtinstitutionapprby" size="33"
							maxlength="200"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_univ_approvedby"))%>"
							tabindex="7"></td>
					</tr>
					<tr>
						<td width="26%">Address of the University/Institution</td>
						<td width="24%"><textarea name="textunivaddr" cols="30"
							rows="3" tabindex="3" onKeyPress="textlimit(textunivaddr,599)" onKeyUp="textlimit(this,599)"><%=Helper.correctNull((String) hshValues
							.get("edu_univ_addr"))%></textarea></td>
						<td width="25%">Type of Course <b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="25%"><select name="cbocoursetype" tabindex="8">
							<option value="0">--Select--</option>
							<option value="1">Part Time</option>
							<option value="2">Full Time</option>
							<option value="3">Evening Course</option>
							<option value="4">Correspondense</option>
							<option value="5">Vocational</option>
						</select></td>
					</tr>
					<tr>
						<td nowrap="nowrap" width="26%">Edu. Qualification Proposed <b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="24%"><select name="cboqualproposed" tabindex="9">
							<option value="0">--Select--</option>
							<lapschoice:StaticDataTag apptype="189"/>
						</select></td>
						<td width="25%">Duration of course</td>
						<td width="25%"><input type="text" name="txtdurofcourseyr"
							size="5" maxlength="2" onKeyPress="allowInteger()" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_durationyrs"))%>">
						(Years) <input type="text" name="txtdurofcoursemon" size="7"
							maxlength="3" onKeyPress="allowInteger()" tabindex="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("edu_durationmon"))%>">
						(Months)</td>
					</tr>

					<tr id="postsancFields">
						<td nowrap="nowrap" width="26%">Duration of course extended (months)<b><span
							class="mantatory">*&nbsp;</span></b></td>
						<td width="24%"><input type="text" name="txtdurofcourse_extend"
							size="5" maxlength="2" onKeyPress="allowInteger()" tabindex="10"
							value="<%=Helper.correctNull((String) hshValues
							.get("EDU_COURSE_EXTEND"))%>"></td>
						<td width="25%">Course start date</td>
						<td width="25%">
						<input type="text" name="txt_crse_strt_date" maxlength="10" size="12" onKeyPress="allowAlphaNumeric()" 
						value="<%=Helper.correctNull((String) hshValues.get("EDU_COURSE_STRTDATE"))%>" onBlur="checkDate(this)">&nbsp;&nbsp;
						<a href="#"	onClick="callCalender('txt_crse_strt_date')"	title="Click to view calender" border="0">
							<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0" tabindex="13"></a>
						</td>
					</tr>
					
					<tr>
					<td style="display:none">Is the Student Meritorious </td>
					<td style="display:none"><select name="sel_studentmeri" tabindex="" onchange="">
					<option value="">---Select---</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
					</select>
					</td>
					
					<td>Marks Secured in the Qualifying Examination<b><span
							class="mantatory">*&nbsp;</span></b></td>
					<td valign="middle"><input type="text" name="txt_markseq" maxlength="3" size="4" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this)" value="<%=Helper.correctNull((String) hshValues.get("EDU_QUALIFYINGEXA"))%>"> %</td>

					<td>Availed Other Subsidy<b><span class="mantatory">*&nbsp;</span></b></td>
					<td valign="middle"><select name="sel_othersubsidy" tabindex="" onchange="">
					<option value="s">---Select---</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					</select></td>
					</tr>
					
					
					
					
					
					<tr>
						<td width="26%">Date of commencement of the course</td>
						<td width="24%">
						<table width="40%" border="0" cellspacing="0" cellpadding="2">
							<tr>
								<td><input type="text" name="txtcommencement_date"
									size="12" maxlength="10" tabindex="12"
									value="<%=Helper.correctNull((String) hshValues
							.get("edu_commencedate"))%>"
									onBlur="checkDate(this)"></td>
								<td><a href="#"
									onClick="callCalender('txtcommencement_date')"
									title="Click to view calender" border="0"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
									width="0" border="0" tabindex="13"></a></td>
							</tr>
						</table>
						</td>
						<td width="25%">Mode of securing admission</td>
						<td width="25%"><select name="cbomodeofsecure" tabindex="14">
							<option value="0">&lt;---Select---&gt;</option>
							<option value="1">Entrance Test</option>
							<option value="2">Selection Process</option>
							<option value="3">Direct on merit</option>
							<option value="4">Management Quota</option>
						</select></td>
					</tr>
					<tr>
						<td width="25%">Studies<b><span class="mantatory">*&nbsp;</span></b></td>
						<td width="25%"><select name="cbostudies" tabindex="15" onchange="funStudies()">
							<option value="0">--Select--</option>
							<option value="I">In India</option>
							<option value="A">Abroad</option>
						</select></td>
						<td width="26%">Is the institution situated at the place of
						domicile?</td>
						<td width="24%"><select name="cboinstdomicile" tabindex="16">
							<option value="0">Select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
					</tr>
					<tr>
						<td width="26%">Expected Income per month after completion of
						course</td>
						<td width="24%"><%=ApplicationParams.getCurrency()%> <lapschoice:CurrencyTag
							name="expected_income" size="15" maxlength="9"
							value='<%=Helper.correctNull((String) hshValues
							.get("expected_income"))%>'
							tabindex="17" onBlur="roundtxt(this)" /></td>
						<td width="25%">Is it compulsory to stay in hostel?</td>
						<td width="25%"><select name="cbocomphostel" tabindex="18">
							<option value="0">Select</option>
							<option value="1">Yes</option>
							<option value="2">No</option>
						</select></td>
					</tr>
					<tr>
						<td width="26%">Particular of admission letter</td>
						<td width="24%"><textarea name="textcomments1" cols="50"
							tabindex="19" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("edu_comments1"))%></textarea></td>
						<td width="25%" id="id3">Other information in case of studies abroad</td>
						<td width="25%" id="id4"><textarea name="textcomments2" cols="50"
							tabindex="20" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("edu_comments2"))%></textarea></td>
					</tr>
					<tr>
						<td width="26%">Insurance Details</td>
						<td width="24%"><textarea name="textcomments3" cols="50"
							tabindex="21" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("edu_comments3"))%></textarea></td>
						<td width="25%">Other Details</td>
						<td width="25%"><textarea name="textcomments4" cols="50"
							tabindex="22" rows="2" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
							.get("edu_comments4"))%></textarea></td>
					</tr>
					<tr>
						<td width="26%">Income Certificate<span class="mantatory">*&nbsp;</span></td>
						<td width="24%">
							<select name="sel_inc_cert" tabindex="16" onChange="clearDetails()">
							<option value="s">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
							<option value="NA">Not Applicable</option>
							</select>
						</td>
						<td width="25%">Income Certificate Number</td>
						<td width="25%"><input type="text" name="txt_inc_cert_number" maxlength="20" size="20" onKeyPress="allowAlphaNumeric()" 
						value="<%=Helper.correctNull((String) hshValues.get("EDU_INC_CERT_NUMBER"))%>"> </td>
					</tr>
					<tr>
						<td width="26%">Income Certificate Date</td>
						<td width="24%" valign="middle">
						<input type="text" name="txt_inc_cert_date" maxlength="10" size="12" onKeyPress="allowAlphaNumeric()" 
						value="<%=Helper.correctNull((String) hshValues.get("EDU_INC_CERT_DATE"))%>" onBlur="checkDate(this)">&nbsp;&nbsp;
						<a href="#"	onClick="callCalender('txt_inc_cert_date')"	title="Click to view calender" border="0">
							<img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" border="0" tabindex="13"></a>
						</td>
						<td width="25%">Income Certificate issuing authority</td>
						<td width="25%">
							<select name="sel_inc_cert_authority" tabindex="16">
							<option value="s">--Select--</option>
							<lapschoice:StaticDataTag apptype="188"/>
							</select>
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="radLoan" value="Y"></form>
</body>
</html>


