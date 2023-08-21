<%@include file="../share/directives.jsp"%>
<%
if (strSSIType.equalsIgnoreCase(""))
{
	strSSIType = Helper.correctNull((String) hshValues.get("hidSSIType"));
}%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var govtsponsor="<%=Helper.correctNull((String)hshValues.get("OPS_GOVTSPONSOR"))%>";
var scemetype="<%=Helper.correctNull((String)hshValues.get("OPS_SCHEMETYPE"))%>";
var sponsoragency="<%=Helper.correctNull((String)hshValues.get("OPS_SPONSORAGENCY"))%>";
var subsidytype="<%=Helper.correctNull((String)hshValues.get("OPS_SUBSIDYTYPE"))%>";
var varresidencein="<%=Helper.correctNull((String)hshValues.get("ops_residencein"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function selsub()
{
	if(document.forms[0].selectgovt.value == "1")
    {
	    document.all.s1.style.visibility="visible";
    	document.all.s1.style.position="relative";	
    	document.all.s2.style.visibility="visible";
    	document.all.s2.style.position="relative";	
    	document.all.s3.style.visibility="visible";
    	document.all.s3.style.position="relative";	
    	document.all.s4.style.visibility="visible";
    	document.all.s4.style.position="relative";
    }
    else
  	{
    	document.all.s1.style.visibility="hidden";
    	document.all.s1.style.position="absolute";	
    	document.all.s2.style.visibility="hidden";
    	document.all.s2.style.position="absolute";	
    	document.all.s3.style.visibility="hidden";	
    	document.all.s3.style.position="absolute";
    	document.all.s4.style.visibility="hidden";	
    	document.all.s4.style.position="absolute";
    	document.forms[0].schemetype.value="0";
    	document.forms[0].sub_amt.value="";
    	document.forms[0].sel_sponser_agency.value="0";
    	document.forms[0].sel_subsidytype.value="0";
    	document.forms[0].txt_familyincome.value="";
    	document.forms[0].txt_incomesrc.value="";
    	document.forms[0].txt_mobility.value="";
    	document.forms[0].sel_residencein.value="0";
   	}
}
	
function disableCommandButtons(val)
{	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}	  
}

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");	
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
		document.forms[0].action=appUrl +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}
function doSave()
{	
	document.forms[0].schemetype1.value = document.forms[0].schemetype.options[document.forms[0].schemetype.selectedIndex].text; 
	document.forms[0].sel_sponser_agency1.value = document.forms[0].sel_sponser_agency.options[document.forms[0].sel_sponser_agency.selectedIndex].text; 
	document.forms[0].sel_subsidytype1.value = document.forms[0].sel_subsidytype.options[document.forms[0].sel_subsidytype.selectedIndex].text; 
	document.forms[0].sel_residencein1.value=document.forms[0].sel_residencein.options[document.forms[0].sel_residencein.selectedIndex].text;
	document.forms[0].hidRecordflag.value=varRecordFlag;		
	document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].hidBeanMethod.value="updataSubsidy";
	document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].schemetype1.value = document.forms[0].schemetype.options[document.forms[0].schemetype.selectedIndex].text; 
			document.forms[0].sel_sponser_agency1.value = document.forms[0].sel_sponser_agency.options[document.forms[0].sel_sponser_agency.selectedIndex].text; 
			document.forms[0].sel_subsidytype1.value = document.forms[0].sel_subsidytype.options[document.forms[0].sel_subsidytype.selectedIndex].text; 
			document.forms[0].sel_residencein1.value=document.forms[0].sel_residencein.options[document.forms[0].sel_residencein.selectedIndex].text;
			document.forms[0].hidAction.value ="delete";
			document.forms[0].hidSourceUrl.value="/action/ops_subsidy.jsp";
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanMethod.value="updataSubsidy";
			document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();
		}
    }
	else
	{
		ShowAlert(158);
	}
}	
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
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
function onLoading()
{
	if(govtsponsor!="")
	{
		document.forms[0].selectgovt.value=govtsponsor;
	}
	else
	{
		document.forms[0].selectgovt.value="2";
	}
	
	if(scemetype!="")
	{
		document.forms[0].schemetype.value=scemetype;
	}
	else
	{
		document.forms[0].schemetype.value="0";
	}
	
	if(sponsoragency!="")
	{
		document.forms[0].sel_sponser_agency.value=sponsoragency;
	}
	else
	{
		document.forms[0].sel_sponser_agency.value="0";
	}
	if(subsidytype!="")
	{
		document.forms[0].sel_subsidytype.value=subsidytype;
	}
	else
	{
		document.forms[0].sel_subsidytype.value="0";
	}
	if(varresidencein!="")
	{
		document.forms[0].sel_residencein.value=varresidencein;
	}
	else
	{
		document.forms[0].sel_residencein.value="0";
	}
	selsub();
	disableFields("true");
}
function Close()
	{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp";
		document.forms[0].submit();		
	}
}

function ApplicantTab(page)
{
	if(document.forms[0].cmdapply.disabled==true)
	{
		if(page=="facilities")
		{
			document.forms[0].hidBeanMethod.value="getOPSFacilityData";
			document.forms[0].hidBeanId.value="facilities";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
		}
		if(page=="customerprofile")
		{
			document.forms[0].hidBeanMethod.value="getDemographics";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/ops_applicantdisp1.jsp";
		}
		if(page=="accountdetails")
		{
			document.forms[0].hidBeanId.value="comssiaboveten";
			document.forms[0].hidBeanGetMethod.value="getAccountDetails";
			document.forms[0].action=appURL+"action/ops_accountdetails.jsp";
		}
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onLoading()">
<form name="appform" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
    <tr> 
      <td class="page_flow">Home -&gt; Tertiary -&gt;Application-&gt; Subsidy </td>
    </tr>
  </table>
  <span style="display:none"><lapschoice:borrowertype /></span>
  <lapschoice:application />
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td class="sub_tab_inactive"><b> <a
							href="javascript:gotoTab(appURL,'facilities','getOPSFacilityData','ops_facilities.jsp')">Facilities</a>
						</b></td>
						<td class="sub_tab_active"><b>Subsidy</b></td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'comssiaboveten','getAccountDetails','ops_accountdetails.jsp')">Account
						Details</a></b></td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'compro','getCapitalStructure','com_capitalstructure.jsp')">Capital Structure</a></b>
						</td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'ssidemographics','getOpsdemograph','ops_demographics.jsp')">Details of Promoter/Guarantor</a></b>
						</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td> 
                          <table width="97%" border="1" cellspacing="0" cellpadding="4" class="outertable" align="center">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                                  <tr> 
                                    <td  nowrap="nowrap" width="27%">Govt. Sponsor Scheme</td>
                                    <td width="33%"> 
                                      <select name="selectgovt" onChange="selsub()" tabindex="16">
                                        <option value="1">Yes</option>
                                        <option value="2" selected="selected">No</option>
                                      </select>
                                    </td>
                                    <td width="20%">&nbsp;</td>
                                    <td width="20%">&nbsp;</td>
                                  </tr>
                                  <tr id="s1"> 
                                    <td>Scheme Type</td>
                                    <td> 
                                      <select name="schemetype"
													tabindex="17">
                                        <option value="0">&lt;---select---&gt;</option>
                                        <lapschoice:StaticDataTag apptype="11" tagType="" /> 
                                      </select>
                                      &nbsp;</td>
                                    <td width="20%">Subsidy Amount&nbsp;</td>
                                    <td width="20%"><lapschoice:CurrencyTag
													name="sub_amt" size="20" maxlength="10" onBlur=""
													value='<%=Helper.correctNull((String)hshValues.get("OPS_SUBSIDYAMT"))%>'
													tabindex="18" /> &nbsp;</td>
                                  </tr>
                                  <tr id="s2"> 
                                    <td  nowrap="nowrap" width="27%"> Sponsor Agency</td>
                                    <td width="33%"> 
                                      <select name="sel_sponser_agency"
													tabindex="19">
                                        <option value="0">&lt;---Select---&gt;</option>
                                        <%String apptype = "3";%>
                                        <lapschoice:StaticDataTag apptype='<%=apptype%>' /> 
                                      </select>
                                    </td>
                                    <td width="20%">Subsidy type </td>
                                    <td width="20%"> 
                                      <select name="sel_subsidytype" tabindex="20">
                                        <option value="0">&lt;---Select---&gt;</option>
                                        <%apptype = "5";%>
                                        <lapschoice:StaticDataTag apptype='<%=apptype%>' /> 
                                      </select>
                                    </td>
                                  </tr>
                                  <tr id="s4"> 
                                    <td  valign="top" width="27%">Residence In</td>
                                    <td valign="top" width="33%"> 
                                      <select name="sel_residencein">
                                        <option value="0" selected="selected">&lt;---Select---&gt;</option>
                                        <option value="R">Rural</option>
                                        <option value="U">Urban</option>
                                        <option value="S">Semi - Urban</option>
                                        <option value="M">Metro</option>
                                      </select>
                                    </td>
                                    <td  valign="top" width="20%">Mobility in 
                                      Years</td>
                                    <td width="20%" valign="top"> 
                                      <input type="text" onkeypress="allowInteger();" name="txt_mobility" size="5" maxlength="2" value="<%=Helper.correctNull((String)hshValues.get("ops_mobility"))%>">
                                    </td>
                                  </tr>
                                  <tr id="s3"> 
                                    <td valign="top" width="27%">Present Income(Including 
                                      Family Member) &nbsp;</td>
                                    <td valign="top" width="33%"><lapschoice:CurrencyTag
													name="txt_familyincome" size="20" maxlength="10" onBlur=""
													value='<%=Helper.correctNull((String)hshValues.get("ops_familyincome"))%>'
													tabindex="18" /> &nbsp;</td>
                                    <td  valign="top" width="20%">Source of Income 
                                      &nbsp;</td>
                                    <td width="20%" valign="top"> 
                                      <textarea cols="30" rows="5" name="txt_incomesrc" onKeyPress="textlimit(this,1999)" onKeyUp="textlimit(this,1999)"><%=Helper.correctNull((String)hshValues.get("ops_srcincome"))%></textarea>
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
                   <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="schemetype1" />
<input type="hidden" name="sel_sponser_agency1" />
<input type="hidden" name="sel_subsidytype1" />
<input type="hidden" name="sel_residencein1" />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidmoduletype" />
<INPUT TYPE="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidapplicantid"))%>">
</form>
</body>
</html>
