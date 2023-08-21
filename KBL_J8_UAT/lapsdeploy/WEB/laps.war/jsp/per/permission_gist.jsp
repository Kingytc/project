<%@include file="../share/directives.jsp"%>
<%
	String applstatus = Helper.correctNull((String) hshValues
			.get("DEV_APPSTATUS"));
	String appstatus = "";
	if (applstatus.equalsIgnoreCase("OP")) {
		appstatus = "Open/Pending";
	} else if (applstatus.equalsIgnoreCase("PA")) {
		appstatus = "Processed/Approved";
	} else if (applstatus.equalsIgnoreCase("PR")) {
		appstatus = "Processed/Rejected";
	} else if (applstatus.equalsIgnoreCase("CA")) {
		appstatus = "Closed/Approved";
	} else if (applstatus.equalsIgnoreCase("CR")) {
		appstatus = "Closed/Rejected";
	}

	String appno = Helper.correctNull((String) hshValues.get("appno"));
	if (appno.equals("")) {
		appno = Helper.correctNull((String) hshValues.get("hidAppno"));
	}
	session.setAttribute("strappno", appno);
	session.setAttribute("appno", appno);
	session.setAttribute("appno", appno);
   String DEV_CBSID=Helper.correctNull((String) hshValues.get("DEV_CBSID"));
   session.setAttribute("DEV_CBSID", DEV_CBSID);

	
	String strDEV_SUBTYPE = Helper.correctNull((String) hshValues
			.get("DEV_SUBTYPE"));
	session.setAttribute("DEV_SUB_TYPE", strDEV_SUBTYPE);
	String strDEV_SUBTYP = Helper.correctNull((String) hshValues
			.get("DEV_DEVPARAM"));
	String strDEV_FF = Helper.correctNull((String) hshValues
			.get("ParamA"));
	String strDEV_FFB = Helper.correctNull((String) hshValues
			.get("ParamB"));
	String str_org_level = Helper.correctNull((String) hshValues
			.get("strOrgLevel"));
	ArrayList arrRow = (ArrayList) hshValues.get("arrData");
	ArrayList arrCol = new ArrayList();
	String strManagementDet = Helper.correctNull((String) hshValues
			.get("PG_MANAGEMENTDET"));

	String str_devtype = Helper.correctNull((String) hshValues
			.get("strdev_type"));

	String strManagementArr[] = null;
	if (!strManagementDet.equalsIgnoreCase(""))
		strManagementArr = strManagementDet.split("@");
	if (strManagementArr == null)
		strManagementArr = new String[1];

	int intManagerLen = strManagementArr.length;

	java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strappl_exist=Helper.correctNull((String) hshValues.get("PG_APPL_EXIST"));
	String strfreeze_flag=Helper.correctNull((String) hshValues.get("DEV_FREEZE_FLAG"));
	session.setAttribute("strappstatus", applstatus);
	
	session.setAttribute("strpremission_freezeflag", strfreeze_flag);
	session.setAttribute("sessionModuleType","PERM");
	String strpermissionfalg=Helper.correctNull((String) hshValues.get("flag"));
	ArrayList arrRow1 = (ArrayList) hshValues.get("arrRow");
	
	String hunterScore=Helper.correctNull((String) hshValues.get("intHuntScore1"));
	
%>


<html>
<head>
<script language="javaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/jquery.js"></script>

<SCRIPT LANGUAGE="JavaScript">
var curdate = "<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varpageid="<%=Helper.correctNull((String) hshValues
									.get("PageId"))%>";
var strOrgcode="<%=Helper.correctNull((String) session
							.getAttribute("strOrgCode"))%>";
var strOrgLevel="<%=str_org_level%>";
var permsubtype="<%=strDEV_SUBTYPE%>";
var varconstitution="<%=Helper.correctNull((String) hshValues
							.get("PG_CONSTITUTION"))%>";
var varexisting_facility="<%=Helper.correctNull((String) hshValues
							.get("PG_EXISTING_FACILITY"))%>";

var varmanagement_det="<%=Helper.correctNull((String) hshValues
							.get("PG_MANAGEMENTDET"))%>";

var varapplt_title="<%=Helper.correctNull((String) hshValues
							.get("PG_APPL_TITLE"))%>";

var var_applexisting="<%=Helper.correctNull((String) hshValues
							.get("PG_APPL_EXIST"))%>";

var var_secextval="<%=Helper.correctNull((String) hshValues
							.get("PG_EXSTFAC_PRIMESEC"))%>";
var varParameter="<%=Helper.correctNull((String) hshValues
									.get("DEV_DEVPARAM"))%>";
var AssessmentParam="<%=Helper.correctNull((String) hshValues
									.get("ParamA"))%>";
var FinancialParam="<%=Helper.correctNull((String) hshValues
									.get("ParamB"))%>";

var var_member_det="<%=Helper.correctNull((String) hshValues.get("arrRow_Mem"))%>";

var var_freeze_flag="<%=Helper.correctNull((String) hshValues.get("DEV_FREEZE_FLAG"))%>";

var varBOR_RATING="<%=Helper.correctNull((String) hshValues.get("PG_BOR_RATING"))%>";
var varRLPFUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
var CBS_id_Check="<%=strappl_exist%>";
var Dev_ParamId="<%=strDEV_SUBTYP%>";
var param_check=0;
var total_finance=0;
var total_cost=0;
var perapp_bank="<%=Helper.correctNull((String) hshValues.get("perapp_bank"))%>";	
var varQueryStatus="<%=Helper.correctNull((String)hshValues.get("Query_Status"))%>";
var hunterScore="<%=Helper.correctNull((String)hshValues.get("hunterScore"))%>";

function onload()
{
	<%if(strappl_exist.equalsIgnoreCase("No")){%>
	document.all.add_mul.style.display="table-cell";
	<%} else{%>
	document.all.add_mul.style.display="none";
	<%}%>
	var param_id=Dev_ParamId.split("@");
	for(var i=0;i<param_id.length-1;i++){
			var param_id_value=param_id[i];
			if(param_id_value=="14" ||param_id_value=="15"||param_id_value=="29"||param_id_value=="30")
			{param_check++;}
		}
	if((CBS_id_Check=="Yes")||(param_check>0)){
		document.all.hidcibil.style.display="none";
		document.all.hidcibil1.style.display="none";
		document.all.crif_score.style.display="none";
		document.all.crif_Details.style.display="none";
	}
	else
	{
		document.all.hidcibil.style.display="table-row";
		document.all.hidcibil1.style.display="table-row";
		document.all.crif_score.style.display="table-row";
		document.all.crif_Details.style.display="table-row";
		}
	if(varapplt_title=="" ||varapplt_title==null )
	{	
	document.forms[0].txt_applt_title.value="";
	}
	else
		document.forms[0].txt_applt_title.value=varapplt_title;
	
	
	var nodelist = document.getElementsByTagName("div").length;
	for(var i=0;i<nodelist;i+=2)
	{
		var x=document.getElementsByTagName("div")[i].id;
		var tmp=x.replace("_div","");
		$('.'+tmp).hide();
	}
	
	
	var permsubtypedesc="";
	if(permsubtype=="5")
	{
		permsubtypedesc="cre";
	}
	else if(permsubtype=="6")
	{
		permsubtypedesc="gen";
	}
	else if(permsubtype=="7")
	{
		permsubtypedesc="sal";
	}
	else if(permsubtype=="8")
	{
		permsubtypedesc="trust";
	}
	else if(permsubtype=="3")
	{
		permsubtypedesc="dev";
	}
	else if(permsubtype=="4")
	{
		permsubtypedesc="dev";
	}
	
	
	var nodelist = document.getElementsByTagName("div").length;
	for(var i=0;i<nodelist;i+=2)
	{
		var x=document.getElementsByTagName("div")[i].id;
		if(x.indexOf(permsubtypedesc)>-1)
		{	
			var tmp=x.replace("_div","");
			$('.'+tmp).show();
		}
	}
	if(permsubtype=="3" || permsubtype=="4" || permsubtype=="5" || permsubtype=="6")
	{
		if(varconstitution!="")
		{
			document.forms[0].txt_constitution.value=varconstitution;
			cons_val();
		}
		else
		{
			document.forms[0].txt_constitution.value="0";
			document.all.i1.style.display="none";
		}
	}	
	var param_id=Dev_ParamId.split("@");
	for(var i=0;i<param_id.length-1;i++){
			var param_id_value=param_id[i];
			//alert(param_id_value);
			if(param_id_value=="14" ||param_id_value=="15"||param_id_value=="29"||param_id_value=="30")
			{param_check++;}
		}
	if((CBS_id_Check=="No")&&(param_check>0)){
		document.all.hidcibil.style.display="table-row";
		document.all.hidcibil1.style.display="table-row";
		document.all.crif_score.style.display="table-row";
		document.all.crif_Details.style.display="table-row";
	}
	else
	{
		document.all.hidcibil.style.display="none";
		document.all.hidcibil1.style.display="none";
		document.all.crif_score.style.display="none";
		document.all.crif_Details.style.display="none";
		}
	if(varBOR_RATING=="0" ||varBOR_RATING==null )
	{	
		document.forms[0].sel_bor_Rating.value="0";
	}
	else
	{
		document.forms[0].sel_bor_Rating.value=varBOR_RATING;
	}
	
//	FacilityDetDisp(varexisting_facility);
	
//	DepositAccDet(var_depaccdet);
//	SecurityExtVal(var_secextval);

	document.forms[0].cmdedit.disabled=true;
	ManageDetDisp1(varmanagement_det);
	document.forms[0].cmdedit.disabled=false;
	
	disablefields(true);

	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdedit.disabled=true;
	}
		 
		if(AssessmentParam=="Y")
		{		
			document.all.idAssessment.style.display="table-cell";
		}
		else
		{
			document.all.idAssessment.style.display="none";
		}
		if(FinancialParam=="Y")
		{
			document.all.idFinancial.style.display="table-cell";
		}
		else
		{		
			document.all.idFinancial.style.display="none";		
		}	
		 


	<%if (arrRow != null && arrRow.size() > 0) 
	{
		if (arrRow.size() == 1) 
		{
			arrCol = (ArrayList) arrRow.get(0);%>

			document.forms[0].txt_present_nature.value="<%=Helper.correctNull((String) arrCol.get(0))%>";
			document.forms[0].sel_bankscheme.value="<%=Helper.correctNull((String) arrCol.get(5))%>";
		<%}
		else 
		{
			for (int i = 0; i < arrRow.size(); i++) 
			{
				arrCol = (ArrayList) arrRow.get(i);%>
				document.forms[0].txt_present_nature[<%=i%>].value="<%=Helper.correctNull((String) arrCol.get(0))%>";
				document.forms[0].sel_bankscheme[<%=i%>].value="<%=Helper.correctNull((String) arrCol.get(5))%>";
			<%}
		}
	}%>

	jointownerdisp(var_member_det);

	if(var_applexisting=="Yes")
	{
		document.forms[0].txt_cbs_id.className="finaclefieldsbgcolor";
		document.forms[0].txt_applt_title.className="finaclefieldsbgcolor";
		document.forms[0].txt_applName.className="finaclefieldsbgcolor";
		document.forms[0].txt_applAddress1.className="finaclefieldsbgcolor";
		document.forms[0].txt_applAddress2.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_pincode.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_phno.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_mail.className="finaclefieldsbgcolor";
		document.forms[0].txt_constitution.className="finaclefieldsbgcolor";
		document.forms[0].txt_natureofactivity.className="finaclefieldsbgcolor";
		document.forms[0].txt_acc_introdby.className="finaclefieldsbgcolor";		
		document.forms[0].txt_employerName.className="finaclefieldsbgcolor";
		document.forms[0].txt_presentTrustee.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_city.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_state.className="finaclefieldsbgcolor";
		document.forms[0].txt_appl_district.className="finaclefieldsbgcolor";	
		document.forms[0].txt_dealingSince.className="finaclefieldsbgcolor";
		
	}
}

function ManageDetDisp1(valuerValue)
{	
	if(valuerValue!="")
		{
		 var temp=valuerValue.split("@");
		 var valuerlen=temp.length;
			 for(var i=0;i<(valuerlen);i++)
		     {    
				 addexstFac1();
				  var valtemp=temp[i].split("~");
				  if(valuerlen==1)
			      {
				      	 document.forms[0].txt_managname[0].value=valtemp[0] ;
			        	 document.forms[0].sel_designation[0].value = valtemp[1];
			        	 concernChange(document.forms[0].sel_designation[0],valtemp[2],'Y','');
			      }
			      else
			      {
					 document.forms[0].txt_managname[i].value=valtemp[0] ;
		        	 document.forms[0].sel_designation[i].value = valtemp[1];
		        	 concernChange(document.forms[0].sel_designation[i],valtemp[2],'Y',(i+1));
		    	 }
		    }	
			 if(i==valuerlen)
			 {
			  deleteRow6("tab_managdet");
			 }
		}
}


function doEdit()
{
	
	callDisableControls(true,false,false,false,false);
	disablefields(false);
	if(permsubtype!="7")
	{
		if(var_applexisting!="Yes")
		{
			document.all.iddeal.style.display="table-cell";
			document.forms[0].txt_dealingSince.readOnly=false;
		}
		else
		{
			document.all.iddeal.style.display="none";
			document.forms[0].txt_dealingSince.readOnly=true;
		}
	}		
	
	document.forms[0].txt_appl_city.readOnly=true;
	document.forms[0].txt_appl_state.readOnly=true;
	document.forms[0].txt_appl_district.readOnly=true;

	document.forms[0].txt_recommend_branch.readOnly=true;
	if(strOrgLevel=="A" || (strOrgLevel=="D" && varRLPFUser=="012"))
	{
		document.forms[0].txt_recommend_branch.readOnly=false;
	}
	if(var_applexisting=="Yes")
	{
		document.forms[0].txt_applt_title.disabled=true;
		document.forms[0].txt_applName.readOnly=true;
		document.forms[0].txt_applAddress1.readOnly=true;
		document.forms[0].txt_applAddress2.readOnly=true;
		document.forms[0].txt_appl_pincode.readOnly=true;
		document.forms[0].txt_appl_phno.readOnly=true;
		document.forms[0].txt_appl_mail.readOnly=true;
		document.forms[0].txt_constitution.disabled=true;
		document.forms[0].txt_natureofactivity.readOnly=true;
		document.forms[0].txt_acc_introdby.readOnly=true;		
		document.forms[0].txt_employerName.readOnly=true;
		document.forms[0].txt_presentTrustee.readOnly=true;
		
	}
	else
	{
		document.forms[0].txt_applt_title.disabled=false;
		document.forms[0].txt_applName.readOnly=false;
		document.forms[0].txt_applAddress1.readOnly=false;
		document.forms[0].txt_applAddress2.readOnly=false;
		document.forms[0].txt_appl_pincode.readOnly=false;
		document.forms[0].txt_appl_phno.readOnly=false;
		document.forms[0].txt_appl_mail.readOnly=false;
		document.forms[0].txt_constitution.disabled=false;
		document.forms[0].txt_natureofactivity.readOnly=false;	
		document.forms[0].txt_acc_introdby.readOnly=false;	
		document.forms[0].txt_employerName.readOnly=false;
		document.forms[0].txt_presentTrustee.readOnly=false;	
			
	}


if(permsubtype!="7")
{
	if(varmanagement_det!="")
	{
	 var temp=varmanagement_det.split("@");
	 var valuerlen=temp.length;
		 for(var i=0;i<(valuerlen);i++)
	     {    
			  var valtemp=temp[i].split("~");
			  if(valuerlen==1)
			   {	
				   if(valtemp[3]=="Y")
			      {
					  document.forms[0].chk6.disabled=true;
				      document.forms[0].txt_managname.readOnly=true;
			          document.forms[0].sel_designation.disabled = true;
			          document.forms[0].comapp_divisionSubtype.disabled=true;
			          document.forms[0].txt_mang_val.value="Y";
			          
			      }else
			      {
			    	  document.forms[0].chk6.disabled=false;
				      document.forms[0].txt_managname.readOnly=false;
			          document.forms[0].sel_designation.disabled = false;
			          document.forms[0].comapp_divisionSubtype.disabled=false;
			          document.forms[0].txt_mang_val.value="N";
			      }	 
		      }else
			  {
		    	  if(valtemp[3]=="Y")
			      {
					  document.forms[0].chk6[i].disabled=true;
				      document.forms[0].txt_managname[i].readOnly=true;
			          document.forms[0].sel_designation[i].disabled = true;
			          document.forms[0].comapp_divisionSubtype[i].disabled=true;
			          document.forms[0].txt_mang_val[i].value="Y";
			      }else
			      {
			    	  document.forms[0].chk6[i].disabled=false;
				      document.forms[0].txt_managname[i].readOnly=false;
			          document.forms[0].sel_designation[i].disabled = false;
			          document.forms[0].comapp_divisionSubtype[i].disabled=false;
			          document.forms[0].txt_mang_val[i].value="N";
			      }
		      }
	     }
	}           
}	

}

function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function doSave()
{
if(permsubtype!="7")
{
	if(var_applexisting!="Yes")
	{
		if(document.forms[0].txt_applt_title.value=="")
		{
			ShowAlert(111,'Title'); 
			document.forms[0].txt_applt_title.focus();
			return;
		}
		if(document.forms[0].txt_applName.value=="")
		{
			ShowAlert(121,'Name of the applicant');
			document.forms[0].txt_applName.focus();
			return;
		}
		
		if(document.forms[0].txt_applAddress1.value=="")
		{
			ShowAlert(121,'Address of the applicant');
			document.forms[0].txt_applAddress1.focus();
			return;
		}
		if(document.forms[0].txt_applAddress2.value=="")
		{
			ShowAlert(121,'Address of the applicant');
			document.forms[0].txt_applAddress2.focus();
			return;
		}
		
		if(document.forms[0].hidcity.value=="")
		{
			ShowAlert(111,'City');
			document.forms[0].txt_appl_city.focus();
			return;
		}
		
		if(document.forms[0].hid_dist.value=="")
		{
			ShowAlert(111,'District');
			document.forms[0].txt_appl_district.focus();
			return;
		}	
	
		if(document.forms[0].hidstate.value=="")
		{
			ShowAlert(111,'State');
			document.forms[0].txt_appl_state.focus();
			return;
		}
		if(document.forms[0].txt_appl_pincode.value=="")
		{
			ShowAlert(121,'Pincode');
			document.forms[0].txt_appl_pincode.focus();
			return;
		}
		if(document.forms[0].txt_appl_phno.value=="")
		{
			ShowAlert(121,'Phone Number');
			document.forms[0].txt_appl_phno.focus();
			return;
		}
		//mail
		/*if(document.forms[0].txt_appl_mail.value=="")
		{
			ShowAlert(121,'E-mail ID');
			document.forms[0].txt_appl_mail.focus();
			return;
		}*/
		if(document.forms[0].txt_constitution.value=="")
		{
			ShowAlert(111,'Constitution');
			document.forms[0].txt_constitution.focus();
			return;
		}
		
		if(permsubtype!="8")
		{
			if(document.forms[0].txt_natureofactivity.value=="")
			{
				ShowAlert(121,'Nature of the Activity');
				document.forms[0].txt_natureofactivity.focus();
				return;
			}
		}		
		if(document.forms[0].txt_dealingSince.value=="")
		{
			ShowAlert(121,'Dealings with us since');
			document.forms[0].txt_dealingSince.focus();
			return;
		}
		
	}
	else
	{
		if(document.forms[0].txt_applt_title.value=="")
		{
			ShowAlert(111,'Title in Customer Profile'); 
			return;
		}
		if(document.forms[0].txt_applName.value=="")
		{
			ShowAlert(121,'Name of the applicant in Customer Profile');
			return;
		}
		
		if(document.forms[0].txt_applAddress1.value=="")
		{
			ShowAlert(121,'Address of the applicant in Customer Profile');
			return;
		}
		if(document.forms[0].txt_applAddress2.value=="")
		{
			ShowAlert(121,'Address of the applicant');
			return;
		}
		
		if(document.forms[0].hidcity.value=="")
		{
			ShowAlert(111,'City in Customer Profile');
			return;
		}
		
		if(document.forms[0].hid_dist.value=="")
		{
			ShowAlert(111,'District in Customer Profile');
			return;
		}	
	
		if(document.forms[0].hidstate.value=="")
		{
			ShowAlert(111,'State in Customer Profile');
			return;
		}
		if(document.forms[0].txt_appl_pincode.value=="")
		{
			ShowAlert(121,'Pincode in Customer Profile');
			return;
		}
		if(document.forms[0].txt_appl_phno.value=="")
		{
			ShowAlert(121,'Phone Number in Customer Profile');
			return;
		}
		//mail
		/*if(document.forms[0].txt_appl_mail.value=="")
		{
			ShowAlert(121,'E-mail ID in Customer Profile');
			return;
		}*/
		if(document.forms[0].txt_constitution.value=="")
		{
			ShowAlert(111,'Constitution in Customer Profile');
			return;
		}
		
		if(permsubtype!="8")
		{
			if(document.forms[0].txt_natureofactivity.value=="")
			{
				ShowAlert(121,'Nature of the Activity in Customer Profile');
				return;
			}
		}	
		if(perapp_bank!="2")
		{	
			if(document.forms[0].txt_dealingSince.value=="")
			{
				ShowAlert(121,'Dealings with us since in Customer Profile');
				return;
			}	
		}
	}	
	
	
	
	if(document.forms[0].txt_managname.length==undefined)
	{
		if(document.forms[0].sel_designation.value=="" && document.forms[0].txt_managname.value!="")
		{
			ShowAlert(121,'Concern Type');
			document.forms[0].sel_designation.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_managname.length;i++)
		{
			if(document.forms[0].sel_designation[i].value=="" && document.forms[0].txt_managname[i].value!="")
			{
				ShowAlert(121,'Concern Type');
				document.forms[0].sel_designation[i].focus();
				return;
			}
	
		}
	}
}


if(permsubtype!="7")
{
	if(document.forms[0].txt_present_loanamt.length==undefined)
	{
		if(document.forms[0].txt_present_nature.value=="")
		{
			ShowAlert(121,'Present Nature of loan/facility');
			document.forms[0].txt_present_nature.focus();
			return;
		}
		if(document.forms[0].sel_bankscheme.value=="")
		{
			ShowAlert(121,'Bank Scheme');
			document.forms[0].sel_bankscheme.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_present_loanamt.length;i++)
		{
			if(document.forms[0].txt_present_nature[i].value=="" && document.forms[0].txt_present_loanamt[i].value!="")
			{
				ShowAlert(121,'Present Nature of loan/facility');
				document.forms[0].txt_present_nature[i].focus();
				return;
			}
			if(document.forms[0].sel_bankscheme[i].value=="")
			{
				ShowAlert(121,'Bank Scheme');
				document.forms[0].sel_bankscheme[i].focus();
				return;
			}
	
		}
	}

	if(document.forms[0].txt_present_loanamt.length==undefined)
	{
		if(document.forms[0].txt_present_loanamt.value=="0.00" || document.forms[0].txt_present_loanamt.value=="")
		{
			ShowAlert(121,'Present Request Loan Amount');
			document.forms[0].txt_present_loanamt.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_present_loanamt.length;i++)
		{
			if((document.forms[0].txt_present_loanamt[i].value=="0.00" || document.forms[0].txt_present_loanamt[i].value=="") && document.forms[0].txt_present_nature[i].value!="")
			{
				ShowAlert(121,'Present Request Loan Amount');
				document.forms[0].txt_present_loanamt[i].focus();
				return;
			}
	
		}
	}
	
	if(document.forms[0].txt_present_loanamt.length==undefined)
	{
		if(document.forms[0].txt_present_interest.value=="" || document.forms[0].txt_present_interest.value=="0.00")
		{
			ShowAlert(121,'Present Request ROI/ Commission');
			document.forms[0].txt_present_interest.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_present_loanamt.length;i++)
		{
			if((document.forms[0].txt_present_interest[i].value=="" || document.forms[0].txt_present_interest[i].value=="0.00") && document.forms[0].txt_present_loanamt[i].value!="")
			{
				ShowAlert(121,'Present Request ROI/ Commission');
				document.forms[0].txt_present_interest[i].focus();
				return;
			}
	
		}
	}

	if(document.forms[0].txt_present_loanamt.length==undefined)
	{
		if(document.forms[0].txt_present_period.value=="")
		{
			ShowAlert(121,'Present Request Period');
			document.forms[0].txt_present_period.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_present_loanamt.length;i++)
		{
			if(document.forms[0].txt_present_period[i].value=="" && document.forms[0].txt_present_loanamt[i].value!="")
			{
				ShowAlert(121,'Present Request Period');
				document.forms[0].txt_present_period[i].focus();
				return;
			}
	
		}
	}

	if(document.forms[0].txt_present_loanamt.length==undefined)
	{
		if(document.forms[0].txt_present_purpose.value=="")
		{
			ShowAlert(121,'Present Request Purpose of the loan');
			document.forms[0].txt_present_purpose.focus();
			return;
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].txt_present_loanamt.length;i++)
		{
			if(document.forms[0].txt_present_purpose[i].value=="" && document.forms[0].txt_present_loanamt[i].value!="")
			{
				ShowAlert(121,'Present Request Purpose of the loan');
				document.forms[0].txt_present_purpose[i].focus();
				return;
			}
	
		}
	}
  }
	// added by raja
	if((CBS_id_Check=="No")&& (param_check>0)){
		if(document.forms[0].txt_cibilscore.value=="")
		{
			ShowAlert(121,'CIBIL Score');
			document.forms[0].txt_cibilscore.focus();
			return;
		}
		if(document.forms[0].txt_datecibil.value=="")
		{
			ShowAlert(111,'CIBIL Reported Date');
			document.forms[0].txt_datecibil.focus();
			return;
		}
		if(document.forms[0].txt_cibilComment.value=="")
		{
			ShowAlert(121,'CIBIL Details');
			document.forms[0].txt_cibilComment.focus();
			return;
		}
		if(document.forms[0].txt_crifscore.value=="")
		{
			ShowAlert(121,'CRIF Score');
			document.forms[0].txt_crifscore.focus();
			return;
		}
		if(document.forms[0].txt_crif_date.value=="")
		{
			ShowAlert(111,'CRIF Reported date');
			document.forms[0].txt_crif_date.focus();
			return;
		}
		if(document.forms[0].txt_crifdetails.value=="")
		{
			ShowAlert(121,'CRIF Details');
			document.forms[0].txt_crifdetails.focus();
			return;
		}
	
	}

	if(permsubtype=="5")
	{
		if(document.forms[0].txt_totprojectcost.value!="" && document.forms[0].txt_totmeansoffinance.value!="")
		{
			if(document.forms[0].txt_totprojectcost.value != document.forms[0].txt_totmeansoffinance.value)
			{
				alert("Total Cost of Project and Total Means of Finance should Tally");
				return;
			}
		}
		else
		{
			alert("Enter Cost of Project/Total Means of Finance Details");
			return;
		}
	}
	else if(permsubtype=="7")
	{
		if(var_applexisting!="Yes")
		{
			if(document.forms[0].txt_employerName.value=="")
			{
				alert("Enter Employer name");
				document.forms[0].txt_employerName.focus();
				return;
			}
		}
		document.forms[0].txt_applName.value=document.forms[0].txt_employerName.value;
	}
	if(strOrgLevel!="C")
	{
		if(document.forms[0].txt_recommend_branch.value=="")
		{
			ShowAlert(121,"Recommendation by the Branch/CLPH");
			return false;
		}
	}else
	{
		if(document.forms[0].sel_bor_Rating.value=="0"||document.forms[0].sel_bor_Rating.value=="")
		{
			ShowAlert(111,"Borrower Rating");
			document.forms[0].sel_bor_Rating.focus();
			return false;
		}
	}
	document.forms[0].txt_applt_title.disabled=false;
	document.forms[0].txt_constitution.disabled=false;
	disablefields(false)
		
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatepermissionGistData";
	document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	document.forms[0].hidSourceUrl.value="/action/permission_gist.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doDelete()
{		
	if(varQueryStatus=="No")
	{
		alert("Some queries are in pending state,\n Please close all the queries before proceeding proposal deletion");
		return;
	}
	//var varconfirm=ConfirmMsg('101');
	if(confirm("Do you want to delete the proposal?"))
	{
	document.forms[0].hidAction.value="delete"; 
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatepermissionGistData";
	document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	document.forms[0].hidSourceUrl.value="/action/com_permission.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
	}
}


function doClose()
{
	var varconfirm=ConfirmMsg('100');
	if(varconfirm)
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function callLink(url,bean,method)
{
	if(document.forms[0].cmdsave.disabled)
	{
		if(permsubtype!="7" && document.forms[0].cmdfreeze.disabled==false)
		{
			alert("Kindly click on freeze button");
			return;
		}else{
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url;
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(103);
		return;
	}	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].action=appUrl+"action/permission_gist.jsp";
	document.forms[0].submit();
	}
}

function addexstFac1()
{

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tab_managdet");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		new_Row.className="datagrid";
		new_Row.align="center";
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="25%";
					new_RowCell.childNodes[j].disabled=false;
					new_RowCell.childNodes[j].readOnly=false;
					
				}
				if(new_RowCell.childNodes[j].type=="select-one")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="35%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].checked=false;	
					new_RowCell.width="5%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].name=="txt_mang_val")
				{
					new_RowCell.childNodes[j].value="N";
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
	}
}

function addexstFac2()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tab_present_req");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		new_Row.className="datagrid";
		new_Row.align="center";
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="15%";
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="25%";
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="select-one")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="20%";
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].checked=false;	
					new_RowCell.width="5%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
	//ClearFields();
	}
}


function addexstFac4()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
		var tab  = document.getElementById("tab_extFac");
		var rowsLength = tab.rows.length;
		if(rowsLength<=200)
		{
			var new_Row    = tab.insertRow(rowsLength);
			var rwlength=rowsLength;
			new_Row.id=""+rowsLength;
			new_Row.className="datagrid";
			new_Row.align="center";
			var previous_RowCells=tab.rows[rowsLength-1].cells; 
			for(i=0;i<previous_RowCells.length;i++)
			{
				var new_RowCell=new_Row.insertCell(i);
				new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
				new_RowCell.align="center";
				var new_CellElement=new_RowCell.childNodes[0];
					if(i==0)
			        {
			        	new_RowCell.align="center";
			        }
					for(var j=0;j<new_RowCell.childNodes.length;j++)
					{
						if(new_RowCell.childNodes[j].type=="text")
						{
							new_RowCell.childNodes[j].value="";
							new_RowCell.width="13%"
							new_RowCell.childNodes[j].disabled=false;
							new_RowCell.childNodes[j].readOnly=false;
							
						}
						if(new_RowCell.childNodes[j].type=="textarea")
						{
							new_RowCell.childNodes[j].value="";		
							new_RowCell.width="19%"
							new_RowCell.childNodes[j].disabled=false;
							new_RowCell.childNodes[j].readOnly=false;
						}
						if(new_RowCell.childNodes[j].type=="checkbox")
						{
							new_RowCell.childNodes[j].checked=false;	
							new_RowCell.width="3%";	  
							new_RowCell.childNodes[j].disabled=false;
						}
						if(new_RowCell.childNodes[j].type=="select-one")
						{
							new_RowCell.childNodes[j].value="0";	
							new_RowCell.width="10%";	  
							new_RowCell.childNodes[j].disabled=false;
						}
					}
			}
		}
		else
		{
			alert("Cannot add more rows");
		}
    }

	if(document.forms[0].cmdedit.disabled==true)
	{	
		var tab  = document.getElementById("tab_extFac1");
		var rowsLength = tab.rows.length;
		if(rowsLength<=200)
		{
			var new_Row    = tab.insertRow(rowsLength);
			var rwlength=rowsLength;
			new_Row.id=""+rowsLength;
			new_Row.className="datagrid";
			new_Row.align="center";
			var previous_RowCells=tab.rows[rowsLength-1].cells; 
			for(i=0;i<previous_RowCells.length;i++)
			{
				var new_RowCell=new_Row.insertCell(i);
				new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
				new_RowCell.align="center";
				var new_CellElement=new_RowCell.childNodes[0];
					if(i==0)
			        {
			        	new_RowCell.align="center";
			        }
					for(var j=0;j<new_RowCell.childNodes.length;j++)
					{
						if(new_RowCell.childNodes[j].type=="text")
						{
							new_RowCell.childNodes[j].value="";
							new_RowCell.width="13%";	 
							new_RowCell.childNodes[j].disabled=false;
						}
						if(new_RowCell.childNodes[j].type=="textarea")
						{
							new_RowCell.childNodes[j].value="";	
							new_RowCell.width="16%";	 	  
							new_RowCell.childNodes[j].disabled=false;
						}
						if(new_RowCell.childNodes[j].name=="txt_ext_val")
						{
							new_RowCell.childNodes[j].value="N";
						}
						if(new_RowCell.childNodes[j].name=="txt_extfac_sancref")
						{
							new_RowCell.width="19%";
						}
					}
			}
		}
		else
		{
			alert("Cannot add more rows");
		}
  	}
}



function addexstFac6()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tab_securdet");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=1+rowsLength;
		new_Row.className="datagrid";
		new_Row.align="center";
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			var new_CellElement=new_RowCell.childNodes[0];
			if(i==0)
	        {
	        	new_RowCell.align="center";
	        }
			for(var j=0;j<new_RowCell.childNodes.length;j++)
			{
				if(new_RowCell.childNodes[j].type=="text")
				{
					new_RowCell.childNodes[j].value="";
					new_RowCell.width="10%";
					new_RowCell.childNodes[j].disabled=false;
					new_RowCell.childNodes[j].readOnly=false;
					
				}
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="17%";	 	  
					new_RowCell.childNodes[j].disabled=false;
					new_RowCell.childNodes[j].readOnly=false;
				}
				if(new_RowCell.childNodes[j].type=="select-one")
				{
					new_RowCell.childNodes[j].value="";	
					new_RowCell.width="10%";
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="checkbox")
				{
					new_RowCell.childNodes[j].checked=false;	
					new_RowCell.width="3%";	  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].name=="txt_sec_val")
				{
					new_RowCell.childNodes[j].value="N";
				}
				
			}
			 
		}
	}
	else
	{
		alert("Cannot add more rows");
	}
  }
}



function deleteRow6(tableid)
{
	var table=document.getElementById(tableid);
	var rowCount=table.rows.length; 
		
	if(rowCount==1)
	{
	      alert("Atleast one data is needed");
	      return;
	}
	else
	{	
		 table.deleteRow(rowCount-1);
	}
}


function callCalender(fname)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		showCal(appURL,fname);
	}else{
		alert("Enable the edit Mode");
	}
}


function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=bool;		  
		}		
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].disabled=bool;
		}
	}
}



function showDistSearch(val)
{  
	if(var_applexisting=="No")
	{
		var varstate = document.forms[0].hidstate.value;
		if(document.forms[0].cmdsave.disabled==false)
		{
			if(document.forms[0].hidstate.value=="")
			{
				alert("Please Reselect the City");
				document.forms[0].txt_appl_city.focus();
				return;
			}
			if(document.forms[0].txt_appl_city.value=="")
			{
				ShowAlert(112,"City");
				document.forms[0].txt_appl_city.focus();
				return;
			}	
			else		
			{
		    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
			var title = "District";
			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);
			}
		}	
	}
}

function getrowlenth2()
{
	var table=document.getElementById("tab_securdet");
	var rowCount=table.rows.length; 
	return rowCount;
}

function showsecuritydet(rowIndex)
{  
	if(document.forms[0].cmdsave.disabled==false)
	{

		var temp1="";
		var rowcount=getrowlenth2();
		if(rowcount==1)
		{
			temp1=document.forms[0].txt_secur_id.value;
		}
		else if(rowcount>1)
		{
			for(var i=0;i<rowcount;i++)
			{
				if(i==0)
				temp1=document.forms[0].txt_secur_id[i].value;
				else
				temp1=temp1+"@"+document.forms[0].txt_secur_id[i].value;
				
			}
		}
		var varQryString1 = appURL+"action/searchSecurityDet.jsp?rowIndex="+rowIndex+"&rowcount="+rowcount+"&temp1="+temp1;
		var title1 = "Secrity_Value";
		var prop1 = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop1 = prop1 + ",left=200,top=200";
		window.open(varQryString1,title1,prop1);
	}
}

function getrowlenth1()
{
	var table=document.getElementById("tab_depacc_main");
	var rowCount1=table.rows.length; 
	return rowCount1;
}

function showdepositdet(rowIndex1)
{  
	if(document.forms[0].cmdsave.disabled==false)
	{
		var temp="";
		var rowcount2=getrowlenth1();
		
		if(rowcount2==1)
		{
			temp=document.forms[0].txt_dep_accno.value;
		}
		else if(rowcount2>1)
		{
			for(var i=0;i<rowcount2;i++)
			{
				if(i==0)
				temp=document.forms[0].txt_dep_accno[i].value;
				else
				temp=temp+"@"+document.forms[0].txt_dep_accno[i].value;
			}
		}
		var varQryString1 = appURL+"action/searchDepositDet.jsp?rowIndex="+rowIndex1+"&rowcount="+rowcount2+"&temp="+temp;
		var title1 = "Deposit_Value";
		var prop1 = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop1 = prop1 + ",left=200,top=200";
		window.open(varQryString1,title1,prop1);
	}
}

function showCitySearch1(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(var_applexisting=="No")
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varDemoflag="per_dev";
			var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&vardemo="+varDemoflag;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}	
}



function deleterow1(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;

		var tab1 = document.getElementById("tab_extFac1");
		var rowsLength1 = tab.rows.length;

		
		
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					if(tabid=="tab_managdet" && rowsLength=="1")
					{
					    	 document.forms[0].txt_managname.value="";  
					    	 document.forms[0].sel_designation.value="";
	  						 document.forms[0].comapp_divisionSubtype.value="";
	  						 document.forms[0].txt_mang_val.value="";
					    	 chkbox.checked=false; 
					    	 return;
					}
					else if(tabid=="tab_present_req" && rowsLength=="1")
					{
							 document.forms[0].txt_present_nature.value="";  
							 document.forms[0].sel_bankscheme.value="";
					    	 document.forms[0].txt_present_loanamt.value="";
					    	 document.forms[0].txt_present_interest.value="";  
					    	 document.forms[0].txt_present_period.value="";
					    	 document.forms[0].txt_present_purpose.value=""; 
					    	 chkbox.checked=false; 
					    	 return;

					}else if(tabid=="tab_securdet" && rowsLength=="1")
					{
						 document.forms[0].txt_secur_propno.value="";  
				    	 document.forms[0].txt_secur_facsno.value="";
						 document.forms[0].txt_secur_appname.value="";  
				    	 document.forms[0].txt_secur_id.value="";
				    	 document.forms[0].txt_secur_desp.value="";  
				    	 document.forms[0].txt_secur_val.value="";
				    	 document.forms[0].sel_secur_type.value="";
				    	 document.forms[0].txt_secur_marg.value=""; 
				    	 document.forms[0].txt_sec_val.value="";  
				    	 chkbox.checked=false;
				    	 return;
							
					}
					else
					{
						tab.deleteRow(i);
						rowsLength--;
						i--;
					}

					if(!varCheckedFlag)
					{
						varCheckedFlag=true;
					}
				}
			}
			if(!varCheckedFlag)
			{
				alert("please select the check box for deletion");
			}
		}
	}
}

function cons_val()
{
	
	if(document.forms[0].txt_constitution.value!="01")
	{
		document.all.i1.style.display="table-row";
	}
	else
	{
		document.all.i1.style.display="none";

		document.forms[0].txt_managname.value="";
	  	document.forms[0].sel_designation.value="";
	  	document.forms[0].comapp_divisionSubtype.value="";

	  	
	  	
   	 	for(var i=0;i<document.forms[0].txt_managname.length;i++)
 		{
 				document.forms[0].txt_managname[i].value="";
 		   	 	document.forms[0].sel_designation[i].value="";
 			  	document.forms[0].comapp_divisionSubtype[i].value="";
 		   	 	
 		}
 	
 	}
	 	  
}

function concernChange(obj1,obj2,val3,val4)
{
			var tab  = document.getElementById("tab_managdet");
			var rowsLength = tab.rows.length;
			var varType=obj1.value;
			var varposition;
			if(varType=="Division")
			{
				varType="193";
			}
			else if(varType=="Sister concern")
			{
				varType="194";
			}
			else if(varType=="Group concern")
			{
				varType="195";
			}
			else if(varType=="O")
			{
				varType="196";
			}
			else if(varType=="D")
			{
				varType="197";
			}
			else if(varType=="SP")
			{
				varType="198";
			}
			else if(varType=="PT")
			{
				varType="199";
			}
			else if(varType=="T")
			{
				varType="200";
			}
			else if(varType=="K")
			{
				varType="201";
			}
			else if(varType=="PA")
			{
				varType="202";
			}
			else if(varType=="OT")
			{
				varType="203";
			}
			else
			{
				varType="0";
			}
			if(rowsLength>1)
			{
				for(var i=0;i<document.all.txt_managname.length;i++)
				{
					if(obj1==document.all.sel_designation[i])
					{
						varposition=i;
					}
				}
				
			}
			if(val3=="Y")
			{
				rowsLength=rowsLength-1;
			}
			if(val4=="")
			{
				document.all.ifrm.src=appURL+"action/ifrmgrpconcernsubtype.jsp?hidBeanGetMethod=getGrpConcernType&hidBeanId=commappmaster&strconcerntype="+varType+"&strSubType="+obj2+"&strRowLen="+rowsLength+"&strPosition="+varposition;
			}
			else
			{
				var varpage=eval("document.all.ifrm"+val4)
				varpage.src=appURL+"action/ifrmgrpconcernsubtype.jsp?hidBeanGetMethod=getGrpConcernType&hidBeanId=commappmaster&strconcerntype="+varType+"&strSubType="+obj2+"&strRowLen="+rowsLength+"&strPosition="+varposition;
			}
		
}

function callvalid(){


	if(eval(document.forms[0].txt_TA_npa_acs.value) > eval(document.forms[0].txt_TA_brtot_acs.value))
	{
		alert("NPA A/c's Should not be greater than Branch total A/c's");
		document.forms[0].txt_TA_npa_acs.value="";
		document.forms[0].txt_TA_npaper_acs.value="";
		document.forms[0].txt_TA_npa_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_TA_npa_amt.value) > eval(document.forms[0].txt_TA_brtot_amt.value))
	{
		alert("NPA amt Should not be greater than Branch total Amt");
		document.forms[0].txt_TA_npa_amt.value="";
		document.forms[0].txt_TA_npaper_amt.value="";
		document.forms[0].txt_TA_npa_amt.focus();
		return ;
	}
	if(eval(document.forms[0].txt_sl_brtot_acs.value) > eval(document.forms[0].txt_TA_brtot_acs.value))
	{
		alert("Salaried class A/c's Should not be greater than Branch total A/c's");
		document.forms[0].txt_sl_brtot_acs.value="";
		document.forms[0].txt_sl_npa_acs.value="";
		document.forms[0].txt_sl_npaper_acs.value="";
		document.forms[0].txt_sl_brtot_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_sl_brtot_amt.value) > eval(document.forms[0].txt_TA_brtot_amt.value))
	{
		alert("Salaried class amt Should not be greater than Branch total amt");
		document.forms[0].txt_sl_brtot_amt.value="";
		document.forms[0].txt_sl_npa_amt.value="";
		document.forms[0].txt_sl_npaper_amt.value="";
		document.forms[0].txt_sl_brtot_amt.focus();
		return ;
	}
	if(eval(document.forms[0].txt_sl_npa_acs.value) > eval(document.forms[0].txt_sl_brtot_acs.value))
	{
		alert("Salaried class NPA A/c's Should not be greater than Branch total A/c's ");
		document.forms[0].txt_sl_npa_acs.value="";
		document.forms[0].txt_sl_npaper_acs.value="";
		document.forms[0].txt_sl_npa_acs.focus();
		return ;
	}

	if(eval(document.forms[0].txt_sl_npa_acs.value) > eval(document.forms[0].txt_TA_npa_acs.value))
	{
		alert("Salaried class NPA A/c's Should not be greater than Total Advances NPA A/c's ");
		document.forms[0].txt_sl_npa_acs.value="";
		document.forms[0].txt_sl_npaper_acs.value="";
		document.forms[0].txt_sl_npa_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_sl_npa_amt.value) > eval(document.forms[0].txt_sl_brtot_amt.value))
	{
		alert("Salaried NPA amt Should not be greater than Salaried branch total Amt");
		document.forms[0].txt_sl_npa_amt.value="";
		document.forms[0].txt_sl_npaper_amt.value="";
		document.forms[0].txt_sl_npa_amt.focus();
		return ;
	}

	if(eval(document.forms[0].txt_sl_npa_amt.value) > eval(document.forms[0].txt_TA_npa_amt.value))
	{
		alert("Salaried NPA amt Should not be greater than Total Advances NPA Amt");
		document.forms[0].txt_sl_npa_amt.value="";
		document.forms[0].txt_sl_npaper_amt.value="";
		document.forms[0].txt_sl_npa_amt.focus();
		return ;
	}
	
	if(eval(document.forms[0].txt_le_brtot_acs.value) > eval(document.forms[0].txt_TA_brtot_acs.value))
	{
		alert("Employee loans A/c's Should not be greater than Branch total A/c's");
		document.forms[0].txt_le_brtot_acs.value="";
		document.forms[0].txt_le_npa_acs.value="";
		document.forms[0].txt_le_npaper_acs.value="";
		document.forms[0].txt_le_brtot_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_le_brtot_acs.value) > eval(document.forms[0].txt_sl_brtot_acs.value))
	{
		alert("Employee loans A/c's Should not be greater than Loan under salaried class A/c's");
		document.forms[0].txt_le_brtot_acs.value="";
		document.forms[0].txt_le_npa_acs.value="";
		document.forms[0].txt_le_npaper_acs.value="";
		document.forms[0].txt_le_brtot_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_le_brtot_amt.value) > eval(document.forms[0].txt_TA_brtot_amt.value))
	{
		alert("Employee loan amt Should not be greater than Branch total amt");
		document.forms[0].txt_le_brtot_amt.value="";
		document.forms[0].txt_le_npa_amt.value="";
		document.forms[0].txt_le_npaper_amt.value="";
		document.forms[0].txt_le_brtot_amt.focus();
		return ;
	}
	if(eval(document.forms[0].txt_le_brtot_amt.value) > eval(document.forms[0].txt_sl_brtot_amt.value))
	{
		alert("Employee loan amt Should not be greater than Loan under salaried class amt");
		document.forms[0].txt_le_brtot_amt.value="";
		document.forms[0].txt_le_npa_amt.value="";
		document.forms[0].txt_le_npaper_amt.value="";
		document.forms[0].txt_le_brtot_amt.focus();
		return ;
	}
	if(eval(document.forms[0].txt_le_npa_acs.value) > eval(document.forms[0].txt_le_brtot_acs.value))
	{
		alert("Employee loan NPA A/cs Should not be greater than Employee loan Branch total A/Cs ");
		document.forms[0].txt_le_npa_acs.value="";
		document.forms[0].txt_le_npaper_acs.value="";
		document.forms[0].txt_le_npa_acs.focus();
		return ;
	}
	if(eval(document.forms[0].txt_le_npa_amt.value) > eval(document.forms[0].txt_le_brtot_amt.value))
	{
		alert("Employee loan amt Should not be greater than Employee loan branch total Amt");
		document.forms[0].txt_le_npa_amt.value="";
		document.forms[0].txt_le_npaper_amt.value="";
		document.forms[0].txt_le_npa_amt.focus();
		return ;
	}
	
	var ta_brtot_acs=document.forms[0].txt_TA_brtot_acs.value;
	var ta_brtot_amt=document.forms[0].txt_TA_brtot_amt.value;
	var ta_npa_acs=document.forms[0].txt_TA_npa_acs.value;
	var ta_npa_amt=document.forms[0].txt_TA_npa_amt.value;
	
	var sl_brtot_acs=document.forms[0].txt_sl_brtot_acs.value;
	var sl_brtot_amt=document.forms[0].txt_sl_brtot_amt.value;
	var sl_npa_acs=document.forms[0].txt_sl_npa_acs.value;
	var sl_npa_amt=document.forms[0].txt_sl_npa_amt.value;
	
	var le_brtot_acs=document.forms[0].txt_le_brtot_acs.value;
	var le_brtot_amt=document.forms[0].txt_le_brtot_amt.value;
	var le_npa_acs=document.forms[0].txt_le_npa_acs.value;
	var le_npa_amt=document.forms[0].txt_le_npa_amt.value;
	
	if(ta_brtot_acs=="")ta_brtot_acs=0;
	if(ta_brtot_amt=="")ta_brtot_amt=0;
	if(ta_npa_acs=="")ta_npa_acs=0;
	if(ta_npa_amt=="")ta_npa_amt=0;
	
	if(sl_brtot_acs=="")sl_brtot_acs=0;
	if(le_brtot_amt=="")le_brtot_amt=0;
	if(sl_npa_acs=="")sl_npa_acs=0;
	if(sl_npa_amt=="")sl_npa_amt=0;
	
	if(le_brtot_acs=="")le_brtot_acs=0;
	if(le_brtot_amt=="")le_brtot_amt=0;
	if(le_npa_acs=="")le_npa_acs=0;
	if(le_npa_amt=="")le_npa_amt=0;

	var TA_npaper_acs=0,TA_npaper_amt=0,sl_npaper_acs=0,sl_npaper_amt=0,le_npaper_acs=0,le_npaper_amt=0;

	if(eval(ta_brtot_acs)!=0)
	TA_npaper_acs=((ta_npa_acs)/(ta_brtot_acs))*100;
	if(eval(ta_brtot_amt)!=0)
	TA_npaper_amt=((ta_npa_amt)/(ta_brtot_amt))*100;

	if(eval(sl_brtot_acs)!=0)
	sl_npaper_acs=((sl_npa_acs)/(sl_brtot_acs))*100;
	if(eval(sl_brtot_amt)!=0)
	sl_npaper_amt=((sl_npa_amt)/(sl_brtot_amt))*100;

	if(eval(le_brtot_acs)!=0)
	le_npaper_acs=((le_npa_acs)/(le_brtot_acs))*100;
	if(eval(le_brtot_amt)!=0)
	le_npaper_amt=((le_npa_amt)/(le_brtot_amt))*100;

	document.forms[0].txt_TA_npaper_acs.value=eval(TA_npaper_acs);
	document.forms[0].txt_TA_npaper_amt.value=eval(TA_npaper_amt);

	document.forms[0].txt_sl_npaper_acs.value=eval(sl_npaper_acs);
	document.forms[0].txt_sl_npaper_amt.value=eval(sl_npaper_amt);

	document.forms[0].txt_le_npaper_acs.value=eval(le_npaper_acs);
	document.forms[0].txt_le_npaper_amt.value=eval(le_npaper_amt);

	document.forms[0].txt_TA_npaper_acs.value=roundVal(document.forms[0].txt_TA_npaper_acs.value);
	document.forms[0].txt_TA_npaper_amt.value=roundVal(document.forms[0].txt_TA_npaper_amt.value);
	document.forms[0].txt_sl_npaper_acs.value=roundVal(document.forms[0].txt_sl_npaper_acs.value);
	document.forms[0].txt_sl_npaper_amt.value=roundVal(document.forms[0].txt_sl_npaper_amt.value);
	document.forms[0].txt_le_npaper_acs.value=roundVal(document.forms[0].txt_le_npaper_acs.value);
	document.forms[0].txt_le_npaper_amt.value=roundVal(document.forms[0].txt_le_npaper_amt.value);

}

function callExistingFac()
{
	if(document.forms[0].cmdedit.disabled==false)
	{
		var hid_existingBowid=document.forms[0].hid_existingBowid.value;
		var varQryString1 = appURL+"action/searchExistingFacility.jsp?rowIndex=1&rowcount=1&temp1=1234&hid_existingBowid="+hid_existingBowid;
		var title1 = "Existing_Facility";
		var prop1 = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop1 = prop1 + ",left=200,top=200";
		window.open(varQryString1,title1,prop1);
	}
}

function callAddDeviation() 
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varAppId=document.forms[0].hidDemoId.value;
		var varQryString = appURL + "action/addjointsecurities.jsp?appid="+varAppId+"&linkFrom=Deviation";
		var title = "ADD";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString, title, prop);
	}

}

function DeviationDel()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varLapsID=document.forms[0].txt_security_ownership.value;
		var vardemoList=document.forms[0].hid_demoList.value;
		var del=vardemoList.split('@');
	
		var vardemoList1=document.forms[0].hid_SecOwnerList.value;
		var del1=vardemoList1.split('@');
		
		if(varLapsID=="")
		{
	
			alert("Please click the button to remove");
		}
		else
		{
			var table=document.all.id_jointsec;
			var rowCount=table.rows.length;
			for(var i=1;i<rowCount;i++)
			{
				if(rowCount>2)
				{
					if(document.forms[0].rad_chk[0].checked==true)
					{
						alert("You can't remove this family member Detail");
						return;
					}
					else if(document.forms[0].rad_chk[i-1].checked==true)
					{
					table.deleteRow(i);
					var temp=document.forms[0].hid_demoList.value;
					var temp2=temp.replace(del[i-2]+"@","");
					
					var temp3=document.forms[0].hid_SecOwnerList.value;
					var temp4=temp3.replace(del1[i-2]+"@","");
	
					document.forms[0].hid_SecOwnerList.value=temp4;
					
					document.forms[0].hid_demoList.value=temp2;
					--i;     
					--rowCount; 
					}
				}
				else
				{
					alert("You can't remove this family member Detail");
				}
			}
			document.forms[0].txt_security_ownership.value="";
		}
	}
}
function callLAPSID(id)
{
	document.forms[0].txt_security_ownership.value=id;	
}

function jointownerdisp(var_member_det)
{
	var var_arr= var_member_det.split("@");
	var length=var_arr.length;
	var tempOwnerList="";
	var tempcbsList="";
	var ownercount="0";
	for(var i=1;i<length;i=i+4)
	{
		var j=i;
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;
		ownercount++;
		
		var row=table.insertRow(rowCount);
		var varName=var_arr[j];
		var varLapsID=var_arr[++j];
		var varCBSID=var_arr[++j];
		var apptype=var_arr[++j];
		if(apptype!="A")
		{
			tempOwnerList=tempOwnerList+varLapsID+"@";
			tempcbsList=tempcbsList+varCBSID+"@";
		}
		
		
		var cell0=row.insertCell(0);
		cell0.className="datagrid";
		cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+varLapsID+');">';

		varName=varName.replace("~","@");		
			
		var cell1=row.insertCell(1);
		cell1.className="datagrid";
		cell1.innerHTML=varName;
		
		var cell2=row.insertCell(2);
		cell2.className="datagrid";
		cell2.innerHTML=varLapsID;

		var cell3=row.insertCell(3);
		cell3.className="datagrid";
		cell3.innerHTML=varCBSID;

		var cell4=row.insertCell(4);
		cell4.className="datagrid";
		var element4=document.createElement("input");
		element4.type="hidden";
		element4.name="hid_jointID["+rowCount+"]";
		element4.value=varLapsID;
		cell4.appendChild(element4);			
	}
	document.forms[0].hid_demoList.value=tempOwnerList;
	document.forms[0].hid_SecOwnerList.value=tempcbsList;
	if(length==1)
	{
		document.all.id_norec.style.display="table-cell";	
	}
	
	
}

function doFreeze()
{
	if(strOrgLevel!="C")
	{
		if(document.forms[0].txt_recommend_branch)
		{
			if(document.forms[0].txt_recommend_branch.value=="")
			{
				ShowAlert(121,"Recommendation by the Branch/CLPH");
				//document.forms[0].txt_recommend_branch.focus();
				return false;
			}
		}
	}
	else
	{
		if(document.forms[0].sel_bor_Rating.value=="0"||document.forms[0].sel_bor_Rating.value=="")
		{
			ShowAlert(111,"Borrower Rating");
			//document.forms[0].sel_bor_Rating.focus();
			return false;
		}
	}
	document.forms[0].cmdfreeze.disabled=true;
	document.forms[0].hidAction.value="Freeze"; 
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatepermissionGistData";
	document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	document.forms[0].hidSourceUrl.value="/action/permission_gist.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function doUndo()
{
	document.forms[0].cmdundo.disabled=true;
	document.forms[0].hidAction.value="Undo"; 
	document.forms[0].hidBeanId.value="perDeviation";
	document.forms[0].hidBeanMethod.value="updatepermissionGistData";
	document.forms[0].hidBeanGetMethod.value="getPermissionGistData";
	document.forms[0].hidSourceUrl.value="/action/permission_gist.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}

function dtype()
{
	if(var_freeze_flag=="Y")	
	{	
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].name=='rad_chk')
			{
				document.forms[0].elements[i].disabled=true;
			}
		}
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdundo.disabled=false;	
		document.forms[0].add1.disabled=true;	
		document.forms[0].remove.disabled=true;	
	}
	else if(var_freeze_flag=="N")	
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].name=='rad_chk')
			{
				document.forms[0].elements[i].disabled=false;
			}
		}
		
		document.forms[0].cmdfreeze.disabled=false;
		document.forms[0].cmdundo.disabled=true;
		document.forms[0].add1.disabled=false;	
		document.forms[0].remove.disabled=false;
	}
	else if(var_freeze_flag=="")	
	{
		for(var i=0;i<document.forms[0].length;i++)
		{
			if(document.forms[0].elements[i].name=='rad_chk')
			{
				document.forms[0].elements[i].disabled=false;
			}
		}
		
		document.forms[0].cmdfreeze.disabled=false;
		document.forms[0].cmdundo.disabled=true;
	}

	if(document.forms[0].btnenable.value=="N")
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}			
}
function validateperiod(obj)
{	
	if(obj.value!=""){
		if(eval(obj.value)>360 )
		{
			alert("Period(including holiday if any) should not be more than 360 months");
			obj.value="";
			obj.focus();
			return;
		}
	}
}
function validateTotal()
{
	var landcost =document.forms[0].txt_landcost.value;
	var constructionCost=document.forms[0].txt_constructionCost.value;
	
	if(landcost=="")landcost=0;
	if(constructionCost=="")constructionCost=0;

	total_cost=(eval(landcost)+eval(constructionCost));
	document.forms[0].txt_totprojectcost.value=eval(total_cost);
	document.forms[0].txt_totprojectcost.value=roundVal(document.forms[0].txt_totprojectcost.value);

}
function validateFinance(){

	var promotor_contrib=document.forms[0].txt_promotcontrib.value;
	var advance_amt=document.forms[0].txt_advanceamt.value;
	var loanfrom_KBL=document.forms[0].txt_loanfromKBL.value;

	if(promotor_contrib=="")promotor_contrib=0;
	if(advance_amt=="")advance_amt=0;
	if(loanfrom_KBL=="")loanfrom_KBL=0;

	total_finance=(eval(promotor_contrib)+eval(advance_amt)+eval(loanfrom_KBL));
	document.forms[0].txt_totmeansoffinance.value=eval(total_finance);
	document.forms[0].txt_totmeansoffinance.value=roundVal(document.forms[0].txt_totmeansoffinance.value);

	var promotor_con_per=0;
	var advance_amt_per=0;
	var loanfrom_KBL_per=0;
	var total_per=0;

	if(eval(total_finance)!=0)
	{
		promotor_con_per=((promotor_contrib)/(total_finance))*100;
		advance_amt_per=((advance_amt)/(total_finance))*100;
		loanfrom_KBL_per=((loanfrom_KBL)/(total_finance))*100;
		total_per=promotor_con_per+advance_amt_per+loanfrom_KBL_per;
	}

	document.forms[0].txt_percenttotal1.value=roundVal(promotor_con_per);
	document.forms[0].txt_percenttotal2.value=roundVal(advance_amt_per);
	document.forms[0].txt_percenttotal3.value=roundVal(loanfrom_KBL_per);
	document.forms[0].txt_percenttotal4.value=roundVal(total_per);
}

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onload();dtype()">
<form method="post" class="normal">

<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/devurllinker.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Permission -&gt; Permission Gist
		</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class='outertable linebor'>
	<tr class="applicationheader">
		<td width="12%">&nbsp;<b>Proposal No:</b></td>
		<td>&nbsp; <%=appno%></td>
		<td width="10%">&nbsp;<b>Applicant Name:</b></td>
		<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("PG_APPLIANTNAME"))%></td>
		<td width="7%">&nbsp;<b>Status:</b></td>
		<td>&nbsp; <%=appstatus%></td>
	</tr>
	<tr class="applicationheader">
		<td nowrap='nowrap'>&nbsp;<b>Application Holder:</b></td>
		<td>&nbsp; <%=Helper.correctNull((String) hshValues
									.get("hidAppholder"))%></td>
		<td nowrap='nowrap'>&nbsp;<b>App. Recd. from:</b></td>
		<td>&nbsp;<%=Helper.correctNull((String) hshValues
							.get("strCreatedOrg"))%></td>
		<td nowrap>Sanction / Rejected Reference No: &nbsp;</td>
		<td>&nbsp;<%=Helper.correctNull((String) hshValues
									.get("strSancRefno"))%></td>
	</tr>
	<tr class="applicationheader">
	<td nowrap='nowrap'>&nbsp;<b>Customer CBS ID:</b></td>
		<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("DEV_CBSID"))%></td>
	<td nowrap='nowrap'>&nbsp;<b>Region:</b></td>
		<td>&nbsp;<%=Helper.correctNull((String)hshValues.get("hshorg_Regionname"))%></td>
		<td nowrap='nowrap'>&nbsp;<b></b></td>
		<td>&nbsp;</td>
	</tr>
</table>


<table width="100%">

	<tr>
		<td>
		<table border="0" cellspacing="2" cellpadding="3" align="left"
			class="outertable">
			<tr>
				<td class="sub_tab_active" id="prin" nowrap width="150px;"
					align="center"><b>Permission Gist</b></td>
				<%if(!strDEV_SUBTYPE.equalsIgnoreCase("7"))
				{%>	
				<td class="sub_tab_inactive" id="more_det" align="center" width="250px;"><b><a href="#"
					onclick="javascript:callLink('permissiongist_addDetails.jsp','perDeviation','getPermissionGistMoreDet')">Permission Gist- More Information</a></b></td>	
				<%} %>
				<td class="sub_tab_inactive" id="prin" align="center" width="200px;"><b><a href="#"
					onclick="javascript:callLink('perm_appbackground_info.jsp','perDeviation','get_PermApplBackgroundData')">Background
				of the Applicant</a></b></td>
				<td class="sub_tab_inactive" id="idAssessment" width="200px"
					align="center" style="display: none;"><b><a href="#"
					onclick="javascript:callLink('perdeviationassessment.jsp','perDeviation','getAssessment')">Interest concession Assessment</a></b></td>
				<td class="sub_tab_inactive" id="prin" width="150px;" align="center"><b><a
					href="#"
					onclick="javascript:callLink('permission_parameters.jsp','perDeviation','getPermissionData')">Permission
				Parameters</a></b></td>
				<td class="sub_tab_inactive" id="idFinancial" width="200px;"
					align="center" style="display: none;"><b><a href="#"
					onclick="javascript:callLink('perm_financial.jsp','perDeviation','getdataFinancial')">Gist of Balance Sheet Analysis</a></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<table width="100%" border="1" cellspacing="0" cellpadding="0"
	class="outertable">
	<td valign="top">
	<table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td valign="top">
			<table width="98%" border="0" cellspacing="0" cellpadding="5" class="outertable">
				<%if(strappl_exist.equalsIgnoreCase("Yes"))
				{ %>
				<tr>
					<td> Customer CBS ID :&nbsp;&nbsp;</td>
					 <td><input type="text" name="txt_cbs_id" readOnly="readOnly" value="<%=Helper.correctNull((String)hshValues.get("DEV_CBSID"))%>" </td>	
				</tr>
				
				<%} %>
				<div id="id_cre_dev_gen_trust_div">
				<tr class="id_cre_dev_gen_trust">
					<td width="25%">Name<span class="mantatory">*</span></td>
					<td width="25%" valign="top"><select name="txt_applt_title">
						<option value="">---Select-----</option>
						<%
							String apptypecon = "1";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
					</select>&nbsp;&nbsp; <input type="text" name="txt_applName"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_APPLIANTNAME"))%>">
					</td>
					<td width="50%" colspan="4">&nbsp;</td>

				</tr>
				<tr class="id_cre_dev_gen_trust">
					<td width="25%">Address of the applicant <span
						class="mantatory">*</span></td>
					<td width="25%"><input type="text" size="40" name="txt_applAddress1"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_APPLADDRESS1"))%>">
					</td>
					<td width="50%" colspan="4">&nbsp;</td>
				</tr>
				<tr class="id_cre_dev_gen_trust">
					<td width="25%">&nbsp;</td>
					<td width="25%"><input type="text"  size="50"  maxlength="50" name="txt_applAddress2"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_APPLADDRESS2"))%>">
					</td>
					<td width="50%" colspan="4">&nbsp;</td>
				</tr>


				<tr class="id_cre_dev_gen_trust">
					<td width="25%">City <span class="mantatory">*</span></td>
					<td width="25%"><input type="text" name="txt_appl_city"
						maxlength="45" size="40" onkeypress="allowAlphabetsForName()"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HIDCITYNAME"))%>">
					<a href="#"
						onClick="showCitySearch1('txt_appl_city','txt_appl_state','hidcity','hidstate','txt_appl_pincode','');"
						style="cursor: hand" tabindex="22"><img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0" tabindex="21"></a> <input type="hidden"
						name="hidcity" size="5"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HIDCITY_CODE"))%>">
					</td>
					<td width="25%">District <span class="mantatory">*</span></td>
					<td width="25%"><input type="text" name="txt_appl_district"
						maxlength="45" size="35" onkeypress="allowAlphabetsForName()"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HID_DISTNAME"))%>">
					<a href="#" onClick="showDistSearch('per_dev');"
						style="cursor: hand" tabindex="22"> <img
						src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
						border="0" tabindex="21"></a> <input type="hidden"
						name="hid_dist" size="5"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HID_DIST_CODE"))%>">
					</td>
				</tr>



				<tr class="id_cre_dev_gen_trust">
					<td width="25%">State <span class="mantatory">*</span></td>
					<td width="25%"><input type="text" name="txt_appl_state"
						maxlength="45" size="40" onkeypress="allowAlphabetsForName()"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HIDSTATENAME"))%>">
					<input type="hidden" name="hidstate"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_HIDSTATE_CODE"))%>" />
					</td>
					<td width="25%">Pincode <span class="mantatory">*</span></td>
					<td width="25%"><input type="text" name="txt_appl_pincode"
						maxlength="6" size="10" onkeypress="allowInteger()"
						onBlur="zipvalidate(this,6)"
						value="<%=Helper.correctNull((String) hshValues.get("PG_PINCODE"))%>">
					</td>
				</tr>

				<tr class="id_cre_dev_gen_trust">
					<td width="25%">Phone Number <span class="mantatory">*</span></td>
					<td width="25%"><input type="text" name="txt_appl_phno"
						onkeypress="allowInteger()" maxlength="10"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_PHONE_NUMBER"))%>">
					</td>
					<td width="25%">E-mail ID </td>
					<td width="25%"><input type="text" name="txt_appl_mail"
						onBlur="isEmailAddr(document.forms[0].txt_appl_mail.value,document.forms[0].txt_appl_mail)"
						value="<%=Helper.correctNull((String) hshValues.get("PG_MAIL_ID"))%>">
					</td>
				</tr>
				</div>

				<div id="id_cre_dev_gen_div">
				<tr class="id_cre_dev_gen">
					<td>Constitution <span class="mantatory">*</span></td>
					<td><select name="txt_constitution" onchange="cons_val()">
						<option value="0">---Select-----</option>
						<lapschoice:CBSStaticDataNewTag apptype='2' />
					</select></td>

				</tr>
				</div>
				<div id="id_cre_dev_gen_div">
				<tr class="id_cre_dev_gen">
					<td>Nature of the Activity <span class="mantatory">*</span></td>
					<td><input type="text" name="txt_natureofactivity"  onKeyPress="textlimit(this,99);"
						value="<%=Helper.correctNull((String) hshValues
									.get("PG_ACTIVITY"))%>">
					</td>
					<td colspan="4">&nbsp;</td>
				</tr>
				<!-- for cibil details -->
				<tr id="hidcibil">		
		            <td width="">CIBIL Score &nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>						
		            <td colspan="" ><input type="text" name="txt_cibilscore" size="15" maxlength="5"
					 value="<%=Helper.correctNull((String) hshValues.get("PG_CIBIL_SCORE"))%>"
					  onKeyPress="allowNegtiveNumber(document.forms[0].txt_cibilscore)"  style="text-align:right"></td>
					
				    <td width="">CIBIL Reported Date&nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>
				    <td ><input type="text" name="txt_datecibil" size="10" maxlength="10" 
				     value="<%=Helper.correctNull((String) hshValues.get("PG_CIBIL_REPORTEDDATE"))%>"
				      onBlur="checkDate(this);checkmaxdate(this,curdate);">
				        <a alt="Select date from calender" href="#"
									onClick="callCalender('txt_datecibil')"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
									alt="Select date from calender" ></a></td>
				</tr>
				<tr id="hidcibil1">		
		            <td width="">CIBIL Details &nbsp; <b><span class="mantatory">*&nbsp;</span></b></td>						
		            <td colspan="" ><textarea name="txt_cibilComment" cols="50"  rows="3" 
		            	onKeyPress="textlimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String) hshValues.get("PG_CIBIL_DETAILS"))%></textarea>
		            </td>
				</tr>
				<!-- CRIF Score -->
				<tr id="crif_score">
						<td>CRIF Score&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td><input type="text" name="txt_crifscore"  value="<%=Helper.correctNull((String) hshValues.get("PG_CRIF_SCORE"))%>"
						 onKeyPress="allowNegtiveNumber(document.forms[0].crifscore)" style="text-align:right"></td>
						<td>CRIF Reported date&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td><input type="text" name="txt_crif_date" size="11"  value="<%=Helper.correctNull((String) hshValues.get("PG_CRIF_DATE"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="12">
							&nbsp;
							<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_crif_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" ></a></td>
				</tr>
				<tr id="crif_Details">
						<td>CRIF Details&nbsp;<b><span class="mantatory">*&nbsp;</span></b></td>
						<td><textarea name="txt_crifdetails" cols="50"  rows="3"
						onKeyPress="textlimit(this,499)"><%=Helper.correctNull((String) hshValues.get("PG_CRIF_DETAILS"))%></textarea></td>
				</tr>
				
				<tr class="id_cre_dev_gen" id="i1">
					<td valign="top">
					<table width="70%" border="0" cellspacing="1" cellpadding="3"
						class="outertable" ><tr>
						<td valign="top" id="">Management Details &nbsp;</td>
						<td id="add_mul" valign="top"><a onClick="addexstFac1();"><img src="<%=ApplicationParams.getAppUrl()%>img/add.png" width="10"
						height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp; <a
						onClick="deleterow1('tab_managdet','0');"><img
						src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" width="10"
						height="10" border="0" tabindex="38"></a></td></tr></table></td>
					
					<td>
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
							<td width="5%">&nbsp;</td>
							<td width="25%">Name</td>
							<td width="35%">Concern type</td>
							<td width="35%">Concern Sub type</td>

						</tr>
					</table>
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable" id="tab_managdet">

						<tr class="datagrid" align="center" id="1">
							<td width="5%"><input type="checkbox" name="chk6"
								style="border: none;"></td>
							<td width="25%"><input type="text" name="txt_managname"
								size="10" onKeyPress="allowAlphabetsForName()"
								value"<%=Helper.correctNull((String) hshValues
									.get("PG_MANAGNAME"))%>" maxlength="50">
							</td>
							<td width="35%"><select name="sel_designation"
								style="width: 80%" onchange="concernChange(this,'','N','')">
								<option Selected="selected" value="">--Select--</option>
								<option value="Division">Division</option>
								<option value="Sister concern">Sister Concern</option>
								<option value="Group concern">Group Concern</option>
								<option value="O">Share Holders</option>
								<option value="D">Directors</option>
								<option value="SP">Sole Proprietor</option>
								<option value="PT">Partner</option>
								<option value="T">Trustee</option>
								<option value="K">Karta</option>
								<option value="PA">Power of Attorney</option>
								<option value="OT">Others</option>
							</select></td>

							<td width="35%"><select name="comapp_divisionSubtype"
								style="width: 80%">
								<option Selected="selected" value="">--Select--</option>
							</select> <input type="hidden" name="txt_mang_val" value="N"></td>
						</tr>
					</table>
					</td>
					<td colspan="4">&nbsp;</td>
				</tr>


				</div>

				<div id="id_cre_div">
				<tr class="id_cre">
					<td>Date of Establishment</td>
					<td><input type="text" name="txt_estDate" size="11"
						value="<%=Helper.correctNull((String) hshValues
									.get("PG_ESTBDATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,curdate);"
						maxlength="10" tabindex="15"> <a
						alt="Select date from calender"
						onClick="callCalender('txt_estDate')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender" tabindex="29"></a></td>
					<td>Any Group concerns Business Potential</td>
					<td><textarea rows="3" cols="30" name="txt_grpcrn_busspot" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_GRPCRCN_POT"))%></textarea></td>
				</tr>
				</div>

				<div id="id_sal_div">
				<tr class="id_sal">
					<td>Name of the Employer <span class="mantatory">*</span></td>
					<td><input type="text" name="txt_employerName"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_EMPLOYERNAME"))%>">
					</td>
					<td>No.of employees drawing salary in the Branch</td>
					<td><input type="text" name="txt_noofemployer"
						onkeypress="allowNumber(this)"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_NOOFEMP_SALDRAW"))%>"
						maxlength="8"></td>
				</tr>
				</div>

				<div id="id_trust_div">
				<tr class="id_trust">
					<td>Names of the Present Trustee</td>
					<td><input type="text" name="txt_presentTrustee"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_NAMEOFTRUSTEE"))%>">
					</td>

				</tr>
				<tr class="id_trust">
					<td>Excess of Income over Expenditure</td>
					<td><textarea rows="4" cols="25"
						name="txt_excessincome_overexp" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_EXCESSINCOME"))%></textarea></td>
					<td>As on Date</td>
					<td><input type="text" name="txt_incexpen_date" size="11"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_INCEXPEN_DATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,curdate);"
						maxlength="10" tabindex="15"> <a
						alt="Select date from calender"
						onClick="callCalender('txt_incexpen_date')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender" tabindex="29"></a></td>
				</tr>
				</div>

				<div id="id_cre_dev_gen_sal_trust_div">
				<tr class="id_cre_dev_gen_sal_trust" id="p6">
				<%if(strDEV_SUBTYPE.equalsIgnoreCase("7")) {%>
					<td>Employees dealing with us since <span class="mantatory">*</span></td>
					<%}else{ %>
					<td>Dealings with us since <span class="mantatory">*</span></td>
					<%} %>
					<td><input type="text" name="txt_dealingSince" size="11"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_DEALINGSINCE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,curdate);"
						maxlength="10"> <a alt="Select date from calender"
						onClick="callCalender('txt_dealingSince')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;" id="iddeal"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender"></a></td>
				</tr>
				</div>
				<div id="id_trust_div">
				<tr id="id_trust">
					<td>Constituted on</td>
					<td><input type="text" name="txt_constitutedOn" size="11"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_CONSTITUTED_ON"))%>"
						onblur="checkDate(this);checkmaxdate(this,curdate);"
						maxlength="10" tabindex="15"> <a
						alt="Select date from calender"
						onClick="callCalender('txt_constitutedOn')"
						onMouseOver="window.status='Date Picker'; return true;"
						onmouseout="window.status='';return true;"> <img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" boarder="0"
						alt="Select date from calender" tabindex="29"></a></td>
				</tr>
				</div>
				

				<div id="id_dev_gen_div">
				<tr class="id_dev_gen">
					<td>Last two years Income as per IT Returns net off taxes paid
					</td>
					<td><textarea rows="4" cols="25" name="txt_itReturns_taxpaid" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_ITRETURNS_TAXPAID"))%></textarea></td>
				</tr>
				</div>
				<div id="id_cre_dev_gen_sal_trust_div" >
				<tr class="id_cre_dev_gen_sal_trust" >
					<td valign="top">Present Request &nbsp; <a
						onClick="addexstFac2();"><img
						src="<%=ApplicationParams.getAppUrl()%>img/add.png" width="10"
						height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp; <a
						onClick="deleterow1('tab_present_req','0');"><img
						src="<%=ApplicationParams.getAppUrl()%>img/cancel.png" width="10"
						height="10" border="0" tabindex="38"></a></td>
					<td colspan="3">
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
							<td width="5%">&nbsp;</td>
							<td width="18%">Nature of loan/facility</td>
							<td width="15%">Bank Scheme</td>
							<td width="15%">Loan Amount</td>
							<td width="14%">ROI/ Commission</td>
							<td width="13%">Period(including holiday if any)(months)</td>
							<td width="20%">Purpose of the loan</td>
						</tr>
					</table>
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable" id="tab_present_req">
						<%
							if (arrRow != null && arrRow.size() > 0) {
								for (int i = 0; i < arrRow.size(); i++) {
									arrCol = (ArrayList) arrRow.get(i);
						%>

						<tr class="datagrid" align="center">
							<td width="5%"><input type="checkbox" name="chk"
								style="border: none;"></td>
							<td width="18%"><select name="txt_present_nature"
								style="width: 80%">
								<option value="" selected>---Select-----</option>
								<lapschoice:StaticDataTag apptype="144" />
								</select></td>
							<td width="15%"><select name="sel_bankscheme" style="width:80%;" >
								<option value="" selected>&lt;----Select----&gt;</option>
						        <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
								</select></td>
							<td width="15%"><input type="text"
								name="txt_present_loanamt" onKeyPress="allowNumber(this)"
								onblur="roundtxt(this);" size="20" style="text-align: right"
								maxlength="10" value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(1))))%>"></td>
							<td width="14%"><input type="text"
								name="txt_present_interest" onKeyPress="allowNumber(this)"
								onblur="roundtxt(this);checkPercentage(this);" size="20"
								style="text-align: right" maxlength="5"
								value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)arrCol.get(2))))%>"></td>
							<td width="13%"><input type="text" name="txt_present_period"
								maxlength="3" size="20" style="text-align: right"
								onKeyPress="allowNumber(this)" onblur="validateperiod(this);" value="<%=arrCol.get(3)%>"></td>
							<td width="20%"><textarea rows="3" cols="30"
								name="txt_present_purpose" onkeypress="textlimit(this,199)" onKeyUp="textlimit(this,199)"><%=arrCol.get(4)%></textarea></td>
						</tr>
						<%
							}
							} else {
						%>
						<tr class="datagrid" align="center">
							<td width="5%"><input type="checkbox" name="chk"
								style="border: none;"></td>
							<td width="18%"><select name="txt_present_nature">
								<option value="" selected>---Select-----</option>
								<lapschoice:StaticDataTag apptype="144" />
							</select></td>
							<td width="15%"><select name="sel_bankscheme" style="width:80%;" >
								<option value="" selected>&lt;----Select----&gt;</option>
						        <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
								</select></td>
							<td width="15%"><input type="text"
								name="txt_present_loanamt" onKeyPress="allowNumber(this)"
								onblur="roundtxt(this);" maxlength="10" size="20"
								style="text-align: right" onKeyPress="allowInteger()"></td>
							<td width="14%"><input type="text"
								name="txt_present_interest" onKeyPress="allowNumber(this)"
								onblur="roundtxt(this);checkPercentage(this);" maxlength="5"
								size="20" style="text-align: right" onKeyPress="allowInteger()">
							</td>
							<td width="13%"><input type="text" name="txt_present_period"
								maxlength="3" size="20" style="text-align: right"
								onKeyPress="allowNumber(this)" onblur="validateperiod(this)"></td>
							<td width="20%"><textarea rows="3" cols="35"
								name="txt_present_purpose" onkeypress="textlimit(this,199)" onKeyUp="textlimit(this,199)"></textarea></td>
						</tr>
						<%
							}
						%>
					</table>
					</td>
				</tr>
				</div>

				<div id="id_cre_dev_gen_trust_div">
				<tr class="id_cre_dev_gen_trust">
					<td>Details of securities available for the proposed facility</td>
					<td colspan="3">
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr align="left">
							<td width="10%">Prime</td>
							<td width="15%" valign="middle">Rs.<input type="text" name="txt_prime_val"
								value="<%=Helper.correctNull((String) hshValues
									.get("PG_PRIME_SECVAL"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);" maxlength="15"
								style="text-align: right;"></td>
							<td width="25%" ><textarea rows="3" cols="30" name="txt_propfac_sec_prime" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_PROPFAC_SEC_PRIME"))%></textarea></td>
							<td width="10%">Collateral</td>
							<td width="15%" valign="middle">Rs.<input type="text" name="txt_collateral_val"
								value="<%=Helper.correctNull((String) hshValues
									.get("PG_COLLATERAL_SECVAL"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);" maxlength="15"
								style="text-align: right;"></td>
								<td width="25%" ><textarea rows="3" cols="30" name="txt_propfac_sec_Collateral" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_PROPFAC_SEC_COLLATERAL"))%></textarea></td>
						</tr>
					</table>
					</td>
				</tr>
				</div>

				<div id="id_cre_div">
				<tr class="id_cre">
					<td>Reasons for switch over to our Bank (in case of take over)
					</td>
					<td><textarea rows="3" cols="30" name="txt_rsn_switch" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_RSN_SWITCH"))%></textarea></td>
					<td>Account introduced by</td>
					<td width="2%"><input type="text" name="txt_acc_introdby"
						value="<%=Helper.correctNull((String) hshValues
							.get("PG_ACC_INTRODBY"))%>">
					</td>
				</tr>
				</div>

				<div id="id_cre_div">
				<tr class="id_cre">
					<td valign="top">In the case of Project Loan/Term Loan / DPN:</td>
					<td colspan="3">a)
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
							<td colspan="2" width="40%">Project Cost</td>
							<td colspan="2" width="40%">Means of Finance</td>
							<td width="20%">% to total</td>
						</tr>
						<!-- raja -->
						<tr class="datagrid">
							<td>Cost of land</td>
							<td><input type="text" name="txt_landcost"
								value="<%=Helper.correctNull((String) hshValues
									.get("PG_LANDCOST"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);validateTotal();"
								style="text-align: right;"></td>
							<td>Promoters Contribution & Internal Accruals</td>
							<td width="7%"><input type="text" name="txt_promotcontrib"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_PROMOTCONTRIB"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);validateFinance();"
								style="text-align: right;"></td>
							<td width="7%" align="center"><input type="text"
								name="txt_percenttotal1" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_PERCENTTOTAL1"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr class="datagrid">
							<td>Cost of construction</td>
							<td width="7%"><input type="text"
								name="txt_constructionCost"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_CONSTRUCTIONCOST"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);validateTotal();"
								style="text-align: right;"></td>
							<td>Advance amount from the prospective buyers</td>
							<td width="7%"><input type="text" name="txt_advanceamt"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_ADVANCEAMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);validateFinance();"
								style="text-align: right;"></td>
							<td width="7%" align="center"><input type="text"
								name="txt_percenttotal2" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_PERCENTTOTAL2"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr class="datagrid">
							<td>&nbsp;</td>
							<td width="7%">&nbsp;</td>
							<td>Proposed Term Loan from Karnataka Bank</td>
							<td width="7%"><input type="text" name="txt_loanfromKBL"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_LOANFROMKBL"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);validateFinance();"
								style="text-align: right;"></td>
							<td width="7%" align="center"><input type="text"
								name="txt_percenttotal3" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_PERCENTTOTAL3"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr class="datagrid">
							<td>Total Project Cost</td>
							<td width="7%"><input type="text" name="txt_totprojectcost" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_TOTPROJECTCOST"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
							<td>Total Means of Finance</td>
							<td width="7%"><input type="text"
								name="txt_totmeansoffinance" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_TOTMEANSOFFINANCE"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
							<td width="7%"  align="center"><input type="text" name="txt_percenttotal4" readonly="readonly"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_PERCENTTOTAL4"))%>" 
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>b) Sources for the margin money &nbsp; &nbsp;</td>
							<td><textarea rows="3" cols="30" name="txt_src_marginmoney" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_SRC_MARGINMONEY"))%></textarea></td>
						</tr>
						<tr>
							<td>c) Mode and Source of repayment &nbsp; &nbsp;</td>
							<td><textarea rows="3" cols="30" name="txt_src_repayment" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_SRC_REPAYMENT"))%></textarea></td>
						</tr>
						<tr>
							<td>d) Additional information:</td>
							<td colspan="2">i) Total area of the site property in sq
							feet</td>
							<td><input type="text" name="txt_totArea"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TOTAREA"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">ii) Total built up area of the building in
							sq feet</td>
							<td><input type="text" name="txt_totBuiltupArea"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_TOTBUILTUPAREA"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">iii) Details of floors that the proposed
							building consists of</td>
							<td><textarea rows="3" cols="30" name="txt_floordetails" onKeyPress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_FLOORDETAILS"))%></textarea></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">iv) Total cost of construction per sq.feet</td>
							<td><input type="text" name="txt_totconstCost"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_TOTCONSTCOST"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">v) Average selling price for sq feet (For
							Residential Flats)</td>
							<td><input type="text" name="txt_avgSellingPrice_rf"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_AVGSELLINGPRICE_RF"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">vi) Average selling price per sq feet (For
							commercialSpace)</td>
							<td><input type="text" name="txt_avgSellingPrice_cp"
								value="<%=Helper.correctNull((String) hshValues
							.get("PG_AVGSELLINGPRICE_CP"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;"></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">vii) Projected rent to be received from
							letting out of the building/shops with details</td>
							<td><textarea rows="3" cols="30" name="txt_projectedRent" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_PROJECTEDRENT"))%></textarea></td>
						</tr>
						<tr>
							<td>&nbsp;</td>
							<td colspan="2">viii) Confirmation regarding necessary
							permission from the respective authorities for construction of
							building</td>
							<td><textarea rows="3" cols="30"
								name="txt_conf_auth_constbuild" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_CONF_AUTH_CONSTBUILD"))%></textarea></td>
						</tr>
					</table>
					</td>
				</tr>
				</div>

				<div id="id_dev_gen_sal_trust_div">
				<tr class="id_dev_gen_sal_trust">
					<td>Scheme/Loan policy Guidelines</td>
					<td><textarea rows="3" cols="30" name="txt_scheme_guidelines" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_SCHEME_GUIDELINES"))%></textarea></td>
				</tr>
				</div>
				<div id="id_dev_gen_div">
				<tr class="id_dev_gen">
					<td>Deviations for which permission sought other than Interest
					concession</td>
					<td><textarea rows="3" cols="30"
						name="txt_devperm_soughtothers" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_DEVPERM_SOUGHTOTHERS"))%></textarea></td>
				</tr>
				</div>
				<div id="id_dev_div">
				<tr class="id_dev">
					<td>Earlier concessions if any, along with permission
					reference no.</td>
					<td><textarea rows="3" cols="30" name="txt_earlierConcession" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_EARLIERCONCESSION"))%></textarea></td>
					<td>Justification by the Branch for specific consideration of
					the credit facility with deviation</td>
					<td><textarea rows="3" cols="30" name="txt_justf_specconsid" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_JUSTF_SPECCONSID"))%></textarea></td>
				</tr>
				</div>
				<div id="id_cre_dev_div">
				<tr class="id_cre_dev">
					<td>Concession in Rate of Interest, processing charges,
					Commission on Bank Guarantee, etc. recommended</td>
					<td><textarea rows="3" cols="30"
						name="txt_concession_recommended" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_CONCESSION_RECOMMENDED"))%></textarea></td>
				</tr>
				</div>
				<div id="id_cre_gen_div">
				<tr class="id_cre_gen">
					<td>Justification for the concession sought by the Branch</td>
					<td><textarea rows="3" cols="30" name="txt_concession_justif" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_CONCESSION_JUSTIF"))%></textarea></td>
				</tr>
				</div>
				<div id="id_cre_div">
				<tr class="id_cre">
					<td>Details of Visits made by the Regional Head, if any.</td>
					<td><textarea rows="3" cols="30" name="txt_detofvisit" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_DETOFVISIT"))%></textarea></td>
					<td>Background of the party (including the details of earlier
					projects)</td>
					<td><textarea rows="3" cols="30"
						name="txt_partyBG_earprojects" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_PARTYBG_EARPROJECTS"))%></textarea></td>
				</tr>
				</div>

				<div id="id_sal_div">
				<tr class="id_sal">
					<td>Deviation observed</td>
					<td><textarea rows="3" cols="30" name="txt_devobserved" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_DEVOBSERVED"))%></textarea></td>
					<td>Whether permission has been extended earlier for these
					employees at HO. If yes, furnish details</td>
					<td><textarea rows="3" cols="30" name="txt_whtPerm_extended" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_WHTPERM_EXTENDED"))%></textarea></td>
				</tr>
				</div>

				<div id="id_sal_div">
				<tr class="id_sal">
					<td>Advances position of the branch</td>
					<td colspan="3">
					<table width="100%" border="0" cellspacing="1" cellpadding="3"
						class="outertable">
						<tr class="dataheader" align="center">
							<td rowspan="2">Particulars</td>
							<td colspan="2">Branch Total</td>
							<td colspan="2">NPA</td>
							<td colspan="2">% of NPA</td>
						</tr>
						<tr class="dataheader" align="center">
							<td>A/cs</td>
							<td>Amount</td>
							<td>A/cs</td>
							<td>Amount</td>
							<td>A/cs</td>
							<td>Amount</td>
						</tr>
						<tr class="datagrid" align="center">
							<td>Total Advances</td>
							<td><input type="text" name="txt_TA_brtot_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_BRTOT_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_TA_brtot_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_BRTOT_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_TA_npa_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_NPA_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_TA_npa_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_NPA_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								onchange="callvalid();" style="text-align: right;">
							</td>
							<td><input type="text" name="txt_TA_npaper_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_NPAPER_ACS"))%>"
								onkeypress="allowNumber(this);" readonly="readonly">
							</td>
							<td><input type="text" name="txt_TA_npaper_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_TA_NPAPER_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								readonly="readonly" style="text-align: right;">
							</td>
						</tr>
						<tr class="datagrid" align="center">
							<td>Loans under Salaried class</td>
							<td><input type="text" name="txt_sl_brtot_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_BRTOT_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_sl_brtot_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_BRTOT_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;" onchange="callvalid();"></td>
							<td><input type="text" name="txt_sl_npa_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_NPA_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_sl_npa_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_NPA_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_sl_npaper_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_NPAPER_ACS"))%>"
								onkeypress="allowNumber(this);" readonly="readonly">
							</td>
							<td><input type="text" name="txt_sl_npaper_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_SL_NPAPER_AMT"))%>"
								onkeypress="allowNumber(this);" readonly="readonly"
								onblur="roundtxt(this);" style="text-align: right;">
							</td>
						</tr>
						<tr class="datagrid" align="center">
							<td>Out of which, Loans to the employees of M/s</td>
							<td><input type="text" name="txt_le_brtot_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_BRTOT_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_le_brtot_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_BRTOT_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_le_npa_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_NPA_ACS"))%>"
								onkeypress="allowNumber(this);" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_le_npa_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_NPA_AMT"))%>"
								onkeypress="allowNumber(this);" onblur="roundtxt(this);"
								style="text-align: right;" onchange="callvalid();">
							</td>
							<td><input type="text" name="txt_le_npaper_acs"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_NPAPER_ACS"))%>"
								onkeypress="allowNumber(this);" readonly="readonly">
							</td>
							<td><input type="text" name="txt_le_npaper_amt"
								value="<%=Helper.correctNull((String) hshValues.get("PG_LE_NPAPER_AMT"))%>"
								onkeypress="allowNumber(this);" readonly="readonly"
								onblur="roundtxt(this);" style="text-align: right;">
							</td>
						</tr>
					</table>
					</td>
				</tr>
				</div>


				<div id="id_gen_div">
				<tr class="id_gen">
					<td>Any other information</td>
					<td><textarea rows="3" cols="30" name="txt_anyother_info" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_ANYOTHER_INFO"))%></textarea></td>
				</tr>
				</div>
				
				<%if(strpermissionfalg.equalsIgnoreCase("Y")){%>
				<tr >
					<td>Hunter Score</td>
			   <td>&nbsp;<%=Helper.correctNull((String) hshValues.get("intHuntScore1"))%></td>
				
				</tr>
				<%} %>
				
				<div id="id_cre_div">
				<tr class="id_cre">
					<td>CRE Exposure Norms</td>
					<td><textarea rows="3" cols="30" name="txt_cre_exposure" onkeypress="textlimit(this,399)" onKeyUp="textlimit(this,399)"><%=Helper.correctNull((String) hshValues
							.get("PG_CRE_EXPOSURE"))%></textarea></td>
				</tr>
				</div>

				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td colspan="4">&nbsp;</td>
				</tr>
				<tr>
					<td>Borrower Rating</td>
					<td>
					<select name="sel_bor_Rating" tabindex="17">
						<option value="0">---select---</option>
							<lapschoice:Previousyeardating selrating='149' />
					</select> &nbsp;&nbsp;&nbsp;
					</td>
					<td> Date </td>
					<td><input type="text" name="txt_ratingDate" size="11"
						value="<%=Helper.correctNull((String) hshValues
									.get("PG_RATINGDATE"))%>"
						onBlur="checkDate(this);checkmaxdate(this,curdate);"
						maxlength="10" tabindex="15"> <a
						alt="Select date from calender"
						onClick="callCalender('txt_ratingDate')"
						onMouseOver="window.status='Date Picker';return true;"
						onMouseOut="window.status='';return true;"><img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
						alt="Select date from calender" tabindex="29"></a>
					</td>
					
				</tr>
			<%if(!strDEV_SUBTYPE.equalsIgnoreCase("7"))
				{%>
				<tr>
					<td >Family Member Details</td>						
				    <td ><input type="text" name="txt_security_ownership" size="12" maxlength="10" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
				    	<input type="button" name="add1"	value="Add" class="buttonStyle" onClick="callAddDeviation()" tabindex="21" >&nbsp;&nbsp;
				    	<input type="button" name="remove" value="Remove" class="buttonStyle" onClick="DeviationDel()" tabindex="22" >
					</td>
					<td colpsan="2">&nbsp;</td>	
				</tr>
				
				<tr id="id_member_det" >
					<td colspan="2" width="20%" >
						<table id="id_jointsec" width="90%" border="0" cellspacing="1" cellpadding="3"  align="center" class="outertable"  style="border: 1px solid #bbb;">		
							<tr class="dataheader">
								<td width="6%">&nbsp;</td>
								<td width="33%" align="center">Name</td>
								<td width="33%" align="center">Laps ID</td>	
								<td width="33%" align="center">CBS ID</td>			
							</tr>
								<tr id="id_norec" class="datagrid" align="center" style="display: none;"> <td colspan="4" > No Records Found  </td></tr>
						</table>
					</td>
					<td colpsan="2">&nbsp;</td>	
				</tr>
				<%}else{ %>
				<input type="hidden" id="id_norec">
				<input type="hidden" name="cmdfreeze">
				<input type="hidden" name="cmdundo">
				<%} %>
				<tr>
					<td>Recommendation by the Branch/CLPH&nbsp;<span class="mantatory"><b>*</b></span></td>
					<td><textarea rows="3" cols="30" name="txt_recommend_branch" onkeyup="textlimitcorp1(this,400);" onkeydown="textlimitcorp1(this,400);"><%=Helper.correctNull((String) hshValues
							.get("PG_RECOMMEND_BRANCH"))%></textarea></td>
				</tr>
			</table>
			</td>
		</tr>
	</table>
	</td>
	</tr>
</table>
<br>

<!---<center><input type="button" name="btn_existFac"
	class="buttonStyle" value="Add Existing Facility"
	onClick="callExistingFac()"></center> -->
<br>

<%if(!strDEV_SUBTYPE.equalsIgnoreCase("7"))
				{%>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Freeze_Undo'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<%}else{ %>	
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<%} %>						
<br>
<input type="hidden" name="appno" value="<%=appno%>"> <input
	type="hidden" name="appholder"
	value="<%=Helper.correctNull((String) hshValues
									.get("hidAppholder"))%>">
<input type="hidden" name="applrecfrom"
	value="<%=Helper.correctNull((String) hshValues
							.get("strCreatedOrg"))%>">
<input type="hidden" name="btnenable"
	value="<%=Helper.correctNull((String) hshValues.get("btnenable"))%>">
<input type="hidden" name="appstatus"
	value="<%=Helper.correctNull((String) hshValues
							.get("DEV_APPSTATUS"))%>">
<input type="hidden" name="appname"
	value="<%=Helper.correctNull((String) hshValues
							.get("PG_APPLIANTNAME"))%>">
<input type="hidden" name="hidSubType"
	value="<%=Helper.correctNull((String) hshValues
									.get("DEV_SUBTYPE"))%>">
<input type="hidden" name="hiddeviationType"
	value="<%=Helper.correctNull((String) hshValues.get("DEV_TYPE"))%>">
<input type="hidden" name="hid_existingBowid" value="<%=Helper.correctNull((String)hshValues.get("PG_EXISINGFAC_BOWID"))%>">

<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>">

<input type="hidden" name="hid_SecOwnerList">

<input type="hidden" name="hid_demoList">

<input type="hidden" name="hid_addexsistingfac" value=""> <input
	type="hidden" name="hid_addexsistingsec" value=""> <lapschoice:hiddentag
	pageid='<%=PageId%>' /> <iframe height="0" width="0"
	id="ifrmpermissiontype" frameborder="0" style="border: 0"></iframe> <%
 	for (int i = 1; i <= intManagerLen; i++) {
 %> <iframe height="0" width="0" id="ifrm<%=i%>" frameborder="0"
	style="border: 0"></iframe> <%
 	}
 %> <iframe height="0" width="0" id="ifrm" frameborder="0"
	style="border: 0"></iframe></form>
</body>
</html>