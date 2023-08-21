function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
		if(val=="existing")
		{
			ShowAlert(144);
		}
	}
}

 function placeValues()
 {
 
	 if(strprd_skip!="null")
	 {
		 document.forms[0].prd_skip.value=strprd_skip;
		 document.forms[0].prd_approval.value=strprd_approval;
		 document.forms[0].prd_maxintclass.value=strprd_maxintclass;
		 if(strOtherDev!="")
		 {
		 document.forms[0].prd_otherdev.value=strOtherDev;
		 }
		 document.forms[0].prd_HO.value=strprd_ho;
		 document.forms[0].prd_RO.value=strprd_ro;
		 document.forms[0].prd_CLPU.value=strprd_clpu;
		 document.forms[0].prd_branch.value=strprd_branch;
		 if(strprd_sanc!=""||strprd_sanc!="null")
			 document.forms[0].prd_sanc_days.value=strprd_sanc;
		 else
			 document.forms[0].prd_sanc_days.value="";
		 if(strprd_reValid!=""||strprd_reValid!="null")
			 document.forms[0].prd_revalid_days.value=strprd_reValid;
		 else
			 document.forms[0].prd_revalid_days.value="";
		 if(strprd_notAvailed!=""||strprd_notAvailed!=null)
			 document.forms[0].prd_notavailed_days.value=strprd_notAvailed;
		 else
			 document.forms[0].prd_notavailed_days.value="";
	 }
	 //document.forms[0].prd_code.value=document.forms[0].prdCode.value;
	 document.forms[0].prd_skip.disabled=true;
	 document.forms[0].prd_approval.disabled=true;
	 document.forms[0].prd_maxintclass.disabled=true;
	 document.forms[0].prd_otherdev.disabled=true;
	 document.forms[0].prd_HO.disabled=true;
	 document.forms[0].prd_RO.disabled=true;
	 document.forms[0].prd_branch.disabled=true;
	 document.forms[0].prd_CLPU.disabled=true;
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].cmdedit.disabled=false;
	 document.forms[0].cmdclose.disabled=false;
	 
	 document.forms[0].prd_skip_descr.readOnly=true;
	 document.forms[0].prd_int_descr.readOnly=true;
	 document.forms[0].prd_app_descr.readOnly=true;
	 document.forms[0].prd_od_descr.readOnly=true;
	 document.forms[0].prd_ho_descr.readOnly=true;
	 document.forms[0].prd_ro_descr.readOnly=true;
	 document.forms[0].prd_CLPU_descr.readOnly=true;
	 document.forms[0].prd_branch_descr.readOnly=true;
	 document.forms[0].prd_skip_value.style.visibility="hidden";
	 document.forms[0].prd_skip_value.style.position="absolute";
	 showDescInt(strprd_maxintclass);
	 showDescApp(strprd_approval);
	 showDescSkip(strprd_skip);
	 showDescRev(strprd_ho,'HO');
	 showDescRev(strprd_ro,'RO');
	 showDescRev(strprd_clpu,'CLPU');
	 showDescRev(strprd_branch,'branch');
	 if(strOtherDev!="")
	 {
	 showOtherDev(strOtherDev);
	 }
	 //
	//	{	
	//		if(strprd_skip == document.forms[0].prd_skip_desc[i].value)
	//		{
	//			document.forms[0].prd_skip_desc.selectedIndex=i;
	//		}
	//	}
	
 }

 function doEdit()
 {
	 if(document.forms[0].checkApp.value=="Yes"){
		 document.forms[0].prd_skip.disabled=true;
		 document.forms[0].prd_approval.disabled=true;
		 document.forms[0].prd_maxintclass.disabled=true;
		 document.forms[0].prd_otherdev.disabled=true;
	 }else{
	 document.forms[0].prd_skip.disabled=false;
	 document.forms[0].prd_approval.disabled=false;
	 document.forms[0].prd_maxintclass.disabled=false;
	 document.forms[0].prd_otherdev.disabled=false;
	 }
	 document.forms[0].prd_HO.disabled=false;
	 document.forms[0].prd_RO.disabled=false;
	 document.forms[0].prd_branch.disabled=false;
	 document.forms[0].prd_CLPU.disabled=false;
	 document.forms[0].prd_sanc_days.disabled=false;
	 document.forms[0].prd_revalid_days.disabled=false;
	 document.forms[0].prd_notavailed_days.disabled=false;
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdclose.disabled=true;
	 document.forms[0].cmdsave.disabled=false;
	 document.forms[0].cmdcancel.disabled=false;
	 document.forms[0].prd_otherdev.focus();
	 document.forms[0].hidAction.value="update";
 }

 function doSave()
 {
	 //alert(document.forms[0].prd_otherdev.value);
	 if(document.forms[0].prd_otherdev.value=="" || eval(document.forms[0].prd_otherdev.value)<=0)
	 {
		 ShowAlert(106,'Minimum Class for Other Deviation');
		 document.forms[0].prd_otherdev.focus();
		 return;
	 }
	 if(document.forms[0].prd_maxintclass.value=="" || eval(document.forms[0].prd_maxintclass.value)<=0)
	 {
		 ShowAlert(106,'maximum class');
		 document.forms[0].prd_maxintclass.focus();
		 return;
	 }
	 if(document.forms[0].prd_approval.value=="" || eval(document.forms[0].prd_approval.value)<=0)
	 {
	 	 ShowAlert(106,'approval/rejection');
		 document.forms[0].prd_approval.focus();
		 return;
	 }
	/* if(document.forms[0].prd_skip.value=="" || eval(document.forms[0].prd_skip.value)<=0)
	 {
		 ShowAlert(107);
		 document.forms[0].prd_skip.value="";
		 document.forms[0].prd_skip.focus();
		 return;
	 }*/
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
	 if(document.forms[0].prd_notavailed_days.value==""||document.forms[0].prd_notavailed_days.value==null){
		 alert("Enter Facility is not Availed/Revalidated");
		 document.forms[0].prd_notavailed_days.focus();
		 return;
	 }
	 
	 document.forms[0].prd_int_descr.disabled=false;
	 document.forms[0].prd_app_descr.disabled=false;
	 document.forms[0].prd_skip_descr.disabled=false;
	 document.forms[0].prd_od_descr.disabled=false;
	 document.forms[0].prd_skip.disabled=false;
	 document.forms[0].prd_approval.disabled=false;
	 document.forms[0].prd_maxintclass.disabled=false;
	 document.forms[0].prd_otherdev.disabled=false;
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].hidBeanId.value="setproducts";
	 document.forms[0].hidRecordflag.value=varRecordFlag;
	 document.forms[0].hidBeanMethod.value="updateAuthorityData";
	 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
	 document.forms[0].hidSourceUrl.value="/action/setprdauth.jsp";
	 document.forms[0].action=appUrl+"controllerservlet";
	 document.forms[0].submit();
 }

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].prd_skip.value="";
	  	document.forms[0].prd_approval.value="";
	 	document.forms[0].prd_maxintclass.value="";
	 	document.forms[0].prd_otherdev.value="";
	 	 document.forms[0].prd_HO.value="";
		 document.forms[0].prd_RO.value="";
		 document.forms[0].prd_CLPU.value="";
		 document.forms[0].prd_branch.value="";
		 document.forms[0].prd_sanc_days.value="";
		 document.forms[0].prd_revalid_days.value="";
		 document.forms[0].prd_notavailed_days.value="";
		placeValues();
	 }
	 document.forms[0].prd_skip.disabled=strprd_skip;
	 document.forms[0].prd_approval.disabled=strprd_approval;
	 document.forms[0].prd_maxintclass.disabled=strprd_maxintclass;
	 document.forms[0].prd_otherdev.disabled=strOtherDev;
	 document.forms[0].prd_HO.disabled=strprd_ho;
	 document.forms[0].prd_RO.disabled=strprd_ro;
	 document.forms[0].prd_CLPU.disabled=strprd_clpu;
	 document.forms[0].prd_branch.disabled=strprd_branch;
	 document.forms[0].prd_sanc_days.disabled=strprd_sanc;
	 document.forms[0].prd_revalid_days.disabled=strprd_reValid;
	 document.forms[0].prd_notavailed_days.disabled=strprd_notAvailed;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].submit();
	}
}


/* function callOtherTab(url)
 {
	 if(!document.forms[0].cmdsave.disabled)
	 {
		 ShowAlert(103);
		 return;
	 }
	 if(url=="setproducts.jsp" || url=="produsedby.jsp" || url=="prodinterest.jsp" || url=="prodsanclimit.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getData";
	 }
	 if(url=="setprddoc.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getDocData";
	 }
	 if(url=="setprdworkflow.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	 }
	 if(url=="setprdintterms.jsp")
	 {
		 document.forms[0].hidBeanGetMethod.value="getIntTermsData";
	 }
	 document.forms[0].prd_code.value=document.forms[0].prdCode.value;
	 document.forms[0].action=appUrl+"action/"+url;
	 document.forms[0].submit();
 }
 function menuOptionDivMouseDown (url)
		{
		
			if(!document.forms[0].cmdsave.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}
*/
//Help function added by vino
function dohlp()     
{
  var hlpvar = appUrl+"phlp/setup_retailprod_authority.htm";
  var title = "Authority";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}