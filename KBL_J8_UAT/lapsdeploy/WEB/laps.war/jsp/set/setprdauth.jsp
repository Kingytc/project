<%@ include file="../share/directives.jsp"%>
<html>
<head> 
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/setprdauth.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>

 var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
 var strprd_skip="<%=hshValues.get("prd_skip")%>";
 var strprd_approval="<%=hshValues.get("prd_approval")%>";
 var strprd_maxintclass="<%=hshValues.get("prd_maxintclass")%>"; 
 var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
 var strOtherDev="<%=Helper.correctNull((String) hshValues.get("prd_otherdevclass"))%>";
 var strprd_ho="<%=Helper.correctNull((String)hshValues.get("PRD_HO"))%>";
 var strprd_ro="<%=Helper.correctNull((String)hshValues.get("PRD_RO"))%>";
 var strprd_clpu="<%=Helper.correctNull((String)hshValues.get("PRD_CLPU"))%>";
 var strprd_branch="<%=Helper.correctNull((String)hshValues.get("PRD_BRANCH"))%>";
 var strprd_sanc="<%=Helper.correctNull((String)hshValues.get("PRD_SANC_VALID"))%>";
 var strprd_reValid="<%=Helper.correctNull((String)hshValues.get("PRD_REVALID_DAYS"))%>";
 var strprd_notAvailed="<%=Helper.correctNull((String)hshValues.get("PRD_NOTAVAILED_DAYS"))%>";
//-->
function showDescSkip(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_skip_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}
function showDescInt(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_int_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}
function showDescApp(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_app_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}
function showOtherDev(id)
{
	for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_od_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
}
function showDescRev(id,val){
	var varType=val;
	if(varType=="HO"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_ho_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="RO"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_ro_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="CLPU"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_CLPU_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
	if(varType=="branch"){
		for(i=0;i<document.forms[0].prd_skip_value.length;i++)
		{	
			if(id == document.forms[0].prd_skip_value[i].value)
			{
				document.forms[0].prd_skip_value.selectedIndex=i;
				document.forms[0].prd_branch_descr.value=document.forms[0].prd_skip_value.options[document.forms[0].prd_skip_value.selectedIndex].text
			}
		}
	}
}
function checkmaxdays(){
	 if(document.forms[0].prd_sanc_days.value==""||document.forms[0].prd_sanc_days.value==null){
		 alert("Enter Sanction Validity ");
		 document.forms[0].prd_sanc_days.focus();
		 return;
	 }
	 if(document.forms[0].prd_revalid_days.value==""||document.forms[0].prd_revalid_days.value==null){
		 alert("Enter Revalidation Validity ");
		 document.forms[0].prd_revalid_days.focus();
		 return;
	 }

	if(parseInt(document.forms[0].prd_notavailed_days.value,10)<parseInt(document.forms[0].prd_sanc_days.value,10))
	 {
		 alert("Facility is not Availed/Revalidated Days should be greater than Sanction Validity Days");
		 document.forms[0].prd_notavailed_days.value="";
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
	
	if(parseInt(document.forms[0].prd_notavailed_days.value,10)<parseInt(document.forms[0].prd_revalid_days.value,10))
	 {
		 alert("Facility is not Availed/Revalidated Days should be greater than Revalidation Validity Days");
		 document.forms[0].prd_notavailed_days.value="";
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp()">
<form name="documentsfrm" method="post" class="normal" >  
<lapstab:setproductstab tabid="3" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Authority</td>
    </tr>    
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" height="400" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable border1">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable"> 
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10" valign="top"> <fieldset>
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" >
                            <tr> 
                              <td height="24" valign="top"><lapschoice:products /> </td>
                            </tr>
                          </table>
                          </fieldset> </td>
                      </tr>
                      <tr> 
                        <td colspan="10" valign="top"> <br>
                          <table width="75%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="10" class="outertable">
                                  <tr> 
                                    <td width="47%" >Minimum Class Other Deviations
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_otherdev1" size="12" maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_otherdev" onChange=showOtherDev(document.forms[0].prd_otherdev.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                      </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_od_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="47%">Minimum Class for Modifying Interest Rate
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_maxintclass1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_maxintclass" onChange=showDescInt(document.forms[0].prd_maxintclass.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                      </td>
                                    <td width="24%" > 
                                      <input type="text" name="prd_int_descr" size="50"  maxlength="4" style="text-align:left">
                                      </td>
                                  </tr>
                                  <tr> 
                                    <td width="47%" >Minimum Class for Approval / Rejection 
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_approval1" size="12" maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_approval" onChange=showDescApp(document.forms[0].prd_approval.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                      </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_app_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="47%" >Minimum Class for Skip flowpoints
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_skip1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_skip" onChange=showDescSkip(document.forms[0].prd_skip.value)>
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_skip_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                   <tr> 
                                    <td width="47%" >Minimum Class Power for HO
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_HO1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_HO" onChange="showDescRev(document.forms[0].prd_HO.value,'HO')">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_ho_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                   <tr> 
                                    <td width="47%" >Minimum Class Power for RO
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_RO1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_RO" onChange="showDescRev(document.forms[0].prd_RO.value,'RO')">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_ro_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                   <tr> 
                                    <td width="47%" >Minimum Class Power for CLPU
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_CLPU1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_CLPU" onChange="showDescRev(document.forms[0].prd_CLPU.value,'CLPU')">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_CLPU_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                   <tr> 
                                    <td width="47%" >Minimum Class Power for Branch
                                    </td>
                                    <td width="29%" > 
                                      <input type="hidden" name="prd_branch1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_branch" onChange="showDescRev(document.forms[0].prd_branch.value,'branch')">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclass /> 
                                      </select>
                                     </td>
                                    <td width="24%" >                                       
                                        <input type="text" name="prd_branch_descr" size="50"  maxlength="4" style="text-align:left">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3" >
                                      <select name="prd_skip_value" style="width:100">
                                        <option value="">&lt;---Select---&gt;</option>
                                        <lapschoice:usersclassdesc /> 
                                      </select>
                                      </td>
                                  </tr>
                                  <tr>
                                   <td width="47%" nowrap="nowrap">Sanction Validity
                                    </td>
                                    <td width="29%" > 
                                      <input type="text" name="prd_sanc_days" size="15" maxlength="3" disabled onKeyPress="allowInteger()" style="text-align:right">days
                                     </td>
                                   <td width="24%" nowrap="nowrap">&nbsp; </td>     
                                  
                                  </tr>
                                  <tr>
                                    <td width="47%" nowrap="nowrap">Revalidation Validity
                                    </td>
                                    <td width="29%" >                                       
                                        <input type="text" name="prd_revalid_days" size="15"  maxlength="3" disabled onKeyPress="allowInteger()" style="text-align:right">days
                                    </td>
                                  <td width="24%" nowrap="nowrap">&nbsp; </td>  
                                  </tr>
                                   <tr>
                                    <td width="47%" nowrap="nowrap">Facility is not availed/revalidated
                                    </td>
                                    <td width="29%" > 
                                      <input type="text" name="prd_notavailed_days" size="15"  maxlength="3" disabled onKeyPress="allowInteger()" onblur="checkmaxdays();" style="text-align:right">days
                                     </td>
                                    <td width="24%" nowrap="nowrap">&nbsp; </td>   
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                          <br>
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
   <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
  