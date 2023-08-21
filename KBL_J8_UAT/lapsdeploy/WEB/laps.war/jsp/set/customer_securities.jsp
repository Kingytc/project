<%@include file="../share/directives.jsp"%>
<%
	HashMap hshRecord = (HashMap) hshValues.get("hshRecord");
	java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	nf.setGroupingUsed(false);
	String pageid = Helper.correctInt((String) request
			.getParameter("pageid"));
	String strEmployment = (String) session
			.getAttribute("strEmployment");
	String strModuleName = Helper.correctNull(request
			.getParameter("hidModuleName"));
	String strModName = "";
	if (strModuleName.equalsIgnoreCase("T")) {
		strModName = "Tertiary";
	} else if (strModuleName.equalsIgnoreCase("P")) {
		strModName = "Retail";
	} else {
		strModName = "Corporate & SME";
	}
	String strAppid = Helper.correctNull((String) hshValues
			.get("strAppid"));
	
	String grpRights = Helper.correctNull((String) session
			.getAttribute("strGroupRights"));
	
	ArrayList vecRow = new ArrayList();
	ArrayList vecCol = new ArrayList();
	vecRow = (ArrayList) hshValues.get("vecRow");
	int size=0;
	if (vecRow != null && vecRow.size() > 0) 
		 size = vecRow.size();
%>
<html>
<head>
<title>Securities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var curdate = "<%=Helper.getCurrentDateTime()%>";
var varAppid="<%=strAppid%>";
var secCount =  "<%=size%>";
var varProfileStatus="<%=Helper.correctNull((String)hshValues.get("perapp_profilestatus"))%>";
var cersailIDCorp=null;
	var varSecType = "";
	function onLoad() {
		disableFields(true);
		disableButtons(false,true,true,true,false);
		document.all.displayTab5.style.visibility = "hidden";
		document.all.displayTab5.style.position = "absolute";
		document.all.displayTab6.style.visibility = "hidden";
		document.all.displayTab6.style.position = "absolute";
		document.all.displayTab7.style.visibility = "hidden";
		document.all.displayTab7.style.position = "absolute";
		document.all.displayTab8.style.visibility = "hidden";
		document.all.displayTab8.style.position = "absolute";
		document.all.displayTab9.style.visibility = "hidden";
		document.all.displayTab9.style.position = "absolute";
		document.all.displayTab10.style.visibility = "hidden";
		document.all.displayTab10.style.position = "absolute";
		document.all.displayTab88.style.visibility = "hidden";
		document.all.displayTab88.style.position = "absolute";		
		document.all.displayTab18.style.visibility = "hidden";
		document.all.displayTab18.style.position = "absolute";
		document.all.displayTab19.style.visibility = "hidden";
		document.all.displayTab19.style.position = "absolute";
		document.all.displayTab20.style.visibility = "hidden";
		document.all.displayTab20.style.position = "absolute";
		document.all.displayTab21.style.visibility = "hidden";
		document.all.displayTab21.style.position = "absolute";
		document.all.displayTab22.style.visibility = "hidden";
		document.all.displayTab22.style.position = "absolute";
		document.all.displayTab23.style.visibility = "hidden";
		document.all.displayTab23.style.position = "absolute";

		document.all.displayTab25.style.visibility = "hidden";
		document.all.displayTab25.style.position = "absolute";

		document.all.displayTab24.style.visibility = "hidden";
		document.all.displayTab24.style.position = "absolute";
		document.all.id_jointsec.style.visibility = "hidden";
		document.all.id_jointsec.style.position = "absolute";
		document.all.id_ownerdet.style.visibility = "hidden";
		document.all.id_ownerdet.style.position = "absolute";
		document.all.com1.style.visibility = "hidden";
		document.all.com1.style.position = "absolute";
		document.all.com2.style.visibility = "hidden";
		document.all.com2.style.position = "absolute";
		disablefields();

		document.forms[0].txt_residual_amount.readOnly=false;
		document.forms[0].txt_net_security.readOnly=true;
		document.forms[0].txt_total_secval.readOnly=true;
		document.forms[0].txt_Valuers_name.readOnly=true;
		document.forms[0].cmdrelease.disabled=true;
		document.forms[0].cmdsecurityownershipchange.disabled=true;
		showSpecify('N');
		document.forms[0].sel_alreadycharged.disabled=true;
		document.all.ValuerDetails1.style.visibility="hidden";
	     document.all.ValuerDetails1.style.position="relative"; 
	 	document.all.ValuerDetails2.style.visibility="hidden";
	     document.all.ValuerDetails2.style.position="relative"; 

	        document.all.idtxtcersialcrop.style.visibility="hidden";
			document.all.idtxtcersialcrop.style.position="absolute";
			document.all.tabid_Cropvaluerlist.style.visibility="hidden";
			document.all.tabid_Cropvaluerlist.style.position="absolute";
			cropCerial();
			govtValuerCheck();
	}
	function showJointSecurity()
	{
		var rowCount=document.all.id_jointsec.rows.length;
		if(rowCount > 1)
		{
			document.forms[0].id_jointsec.visibility="visible";
			document.forms[0].id_jointsec.position="relative";
		}
		else
		{
			document.forms[0].id_jointsec.visibility="hidden";
			document.forms[0].id_jointsec.position="absolute";
		}
	}
	function disablefields()
	{
		document.all.specifytype1.style.visibility = "hidden";
		document.all.specifytype1.style.position = "absolute";
		document.all.specifytype2.style.visibility = "hidden";
		document.all.specifytype2.style.position = "absolute";

		document.all.instname.style.visibility = "hidden";
		document.all.instname.style.position = "absolute";
		document.all.instname1.style.visibility = "hidden";
		document.all.instname1.style.position = "absolute";

		document.all.amtcharged.style.visibility = "hidden";
		document.all.amtcharged.style.position = "absolute";
		document.all.amtcharged1.style.visibility = "hidden";
		document.all.amtcharged1.style.position = "absolute";
	}
	
	function doNew() {

		if(varProfileStatus=="N")
		{
			alert("Customer Profile is not filled completely");
			return;
		}
		disableFields(false);
		disableButtons(true, true, false, false, true, false, true);
		document.forms[0].hidAction.value = "new";
		clearfields();
		document.forms[0].add1.disabled=false;
		document.forms[0].remove.disabled=false;

		document.forms[0].txt_residual_amount.readOnly=false;
		document.forms[0].txt_net_security.readOnly=true;
		document.forms[0].txt_Valuers_name.readOnly=true;
		document.forms[0].txt_name_institution.readOnly=true;
		document.forms[0].txt_val_catCode.disabled=true;
		document.forms[0].sel_currentEmpList.disabled=true; 
		document.forms[0].hidSecurityId.disabled=true; 	

		document.forms[0].txt_City.readOnly=true;
		document.forms[0].txt_State.readOnly=true;
		document.forms[0].txt_District.readOnly=true;

	}
	function doEdit() {
		//document.forms[0].txt_security_ownership.disabled=true;
		disableFields(false);

		if(document.forms[0].hidCount.value=="0")
		{
			disableButtons(true, true, false, false, false, false, true);
		}
		else
		{		
			disableButtons(true, true, false, false, true, false, true);
		}
		if (document.forms[0].sel_securitytype.value == "6") 
		{
			document.forms[0].txt_com_cinno.readOnly=true;
			document.forms[0].txt_companyname.readOnly=true;
			document.forms[0].txt_shareval.readOnly=true;
			document.forms[0].sel_alreadycharged.disabled=true;
			if(document.forms[0].sel_securityclassifcation.value=="40")
			{
				document.forms[0].txt_total_secval.readOnly=true;
			}
		}
		document.forms[0].hidAction.value = "update";
		document.forms[0].add1.disabled=false;
		document.forms[0].remove.disabled=false;
		document.forms[0].txt_residual_amount.readOnly=false;
		document.forms[0].txt_net_security.readOnly=true;
		document.forms[0].txt_Valuers_name.readOnly=true;
		document.forms[0].sel_securitytype.disabled=true;
		document.forms[0].txt_name_institution.readOnly=true;
		document.forms[0].txt_val_catCode.disabled=true;
		document.forms[0].sel_currentEmpList.disabled=true; 

		var tab  = document.getElementById("tabid_valuerlist");
		var  rowsLength= tab.rows.length;
		if(rowsLength>1)
		{
			for(var j=0;j<rowsLength;j++)
			{
				if(document.forms[0].sel_approveFlag_mul[j].value=="N")
				{
					document.forms[0].sel_approveFlag_mul[j].disabled=true;
				}
				document.forms[0].txt_Valuers_name_mul[j].disabled=true;
				document.forms[0].txt_Valuers_code_mul[j].readOnly=true;
				document.forms[0].txt_validation_date_mul[j].disabled=true;
				document.forms[0].txt_dateofsubmissionbybank_mul[j].disabled=true;
				document.forms[0].txt_dateofreceiptbybank_mul[j].disabled=true;
				document.forms[0].txt_net_security_mul[j].disabled=true;
			}
			   document.forms[0].txt_dateofsubmissionbybank.readOnly=true;
			   document.forms[0].txt_dateofreceiptbybank.readOnly=true;
			   document.forms[0].txt_validation_date.readOnly=true;
			   document.forms[0].txt_total_secval.readOnly=true;
		}
		else
		{
			document.forms[0].sel_approveFlag_mul.disabled=false;
		}
	}

	function doSave() {
		if (document.forms[0].sel_securitytype.value == "0") {
			ShowAlert('111', "Security Type");
			document.forms[0].sel_securitytype.focus();
			return;
		}

		if(document.forms[0].sel_securitytype.value!="1" && document.forms[0].sel_natureCharge.selectedIndex<1)
		{
			 alert("Select Nature of Charge");
	         document.forms[0].sel_natureCharge.focus();
	         return;
		}
		/*if(document.forms[0].txt_secintID_roc.value=="")
		{
			ShowAlert('121', "Security interest ID with ROC ");
			document.forms[0].txt_secintID_roc.focus();
			return;
		}
		if(document.forms[0].txt_charid_roc.value=="")
		{
			ShowAlert('121', "Charge ID with ROC ");
			document.forms[0].txt_charid_roc.focus();
			return;
		}*/
		if (document.forms[0].sel_securitytype.value == "24") 
		{
			if(document.forms[0].txt_security_type_specify.value="")
			{
				ShowAlert('121', "Other Security Type ");
				document.forms[0].txt_security_type_specify.focus();
				return;
			}
		}
		var secTypevalue=document.forms[0].sel_securitytype.value;
		if(secTypevalue=="10" || secTypevalue=="11" || secTypevalue=="12" || secTypevalue=="13" || secTypevalue=="14" || secTypevalue=="15" || secTypevalue=="16" || secTypevalue=="17")
		{
			if(document.forms[0].txt_Valuers_code.value=="")
			{
				ShowAlert('111', "Valuer Name");
				document.forms[0].txt_Valuers_code.focus();
				return;
			}
			if(document.forms[0].txt_Valuers_name.value=="")
			{
				ShowAlert('111', "Valuer Name");
				document.forms[0].txt_Valuers_name.focus();
				return;
			}
			var valuerCode=document.forms[0].txt_Valuers_code.value;
			if(valuerCode=="2122"){
				if(document.forms[0].txt_gvtscheme_name.value=="")
				{
					alert('Specify Govt valuer name');
					document.forms[0].txt_gvtscheme_name.focus();
					return;
				}
			}
			if(document.forms[0].sel_property.value=="")
			{
			ShowAlert('121', "Property Leasehold");
			document.forms[0].sel_property.focus();
			return;
			}
			newcheck();
			if(document.forms[0].sel_property.value=="Y"&& document.forms[0].sel_lessor.value=="")
				{
				ShowAlert('121', "Lessor");
				document.forms[0].sel_lessor.focus();
				return;
				}
			
		}
		if (document.forms[0].sel_securityclassifcation.value =="0" || document.forms[0].sel_securityclassifcation.value =="") {
			ShowAlert('111', "Security Classification");
			document.forms[0].sel_securityclassifcation.focus();
			return;
		}

		/*if (document.forms[0].txt_security_type_specify.value == "") {
			ShowAlert('121', "Security Type Specify");
			document.forms[0].txt_security_type_specify.focus();
			return;
		}
		if (document.forms[0].txt_security_clasicification_specify.value == "") {
			ShowAlert('121', "Security Clasification Specify");
			document.forms[0].txt_security_clasicification_specify.focus();
			return;
		}*/

		if (document.forms[0].txt_collareral_start_date.value == "") {
			ShowAlert('121', "Collateral Start Date");
			document.forms[0].txt_collareral_start_date.focus();
			return;
		}

		if (document.forms[0].txt_collareral_end_date.value == "") {
			ShowAlert('121', "Collateral End Date");
			document.forms[0].txt_collareral_end_date.focus();
			return;
		}

		if (document.forms[0].txt_total_secval.value == "") {
			ShowAlert('121', "Market Value");
			document.forms[0].txt_total_secval.focus();
			return;
		}

		
		if (trim(document.forms[0].txt_security_desc.value) == "") {
			ShowAlert('121', "Security Description");
			document.forms[0].txt_security_desc.focus();
			return;
		}
		if(document.forms[0].sel_alreadycharged.value=="")
		{
			ShowAlert('111',"Already charged to other Banks/FIs");
			document.forms[0].sel_alreadycharged.focus();
			return;
		}
		
		if(document.forms[0].sel_alreadycharged.value=="Y")
		{
			if(document.forms[0].txt_name_institution.value==""){
			ShowAlert('121',"Name of the institution");
			document.forms[0].txt_name_institution.focus();
			return;
			}

			if(document.forms[0].txt_charged_to_institution.value==""){
				ShowAlert('121',"Amount Charged to other institution");
				document.forms[0].txt_charged_to_institution.focus();
				return;
				}
		}
				
/*		if (document.forms[0].txt_residual_amount.value == "") {
			ShowAlert('121', "Resudual Value ");
			document.forms[0].txt_residual_amount.focus();
			return;
		}
*/


if((eval(document.forms[0].sel_securitytype.value)>9 && eval(document.forms[0].sel_securitytype.value)<18)
		||(eval(document.forms[0].sel_securitytype.value) == 19))
{
	if (document.forms[0].txt_validation_date.value == "") {
		ShowAlert('121', "Valuation Date (as per Report)");
		document.forms[0].txt_validation_date.focus();
		return;
	}
	if(document.forms[0].txt_dateofsubmissionbybank.value=="")
	{
		ShowAlert('121',"Date of submission of request for valuation by bank");
		document.forms[0].txt_dateofsubmissionbybank.focus();
		return false;
	}
	if(document.forms[0].txt_dateofreceiptbybank.value=="")
	{
		ShowAlert('121',"Date of receipt of valuation report by bank");
		document.forms[0].txt_dateofreceiptbybank.focus();
		return false;
	}
}
	    var netSecuritVal=parseFloat(document.forms[0].txt_net_security.value);
	    //var residualVal=parseFloat(document.forms[0].txt_residual_amount.value);
	   // if(netSecuritVal<residualVal)
	   // {
		//    alert("Residual Value shoud be lesser than Net Security Value");
		//    document.forms[0].txt_residual_amount.value="";
		//    document.forms[0].txt_residual_amount.focus();
		//    return;
	   // }
	   
	   if (document.forms[0].sel_securitytype.value == "6") 
		{
		    if(document.forms[0].txt_com_cinno.value=="")
			{
				ShowAlert('111', "Company Name");
				document.forms[0].txt_com_cinno.focus();
				return;
			}
		    if(document.forms[0].sel_securityclassifcation.value=="40")
			{
				if(document.forms[0].txt_noofshares.value=="")
				{
					ShowAlert('121', "Number of shares of the Company");
					document.forms[0].txt_noofshares.focus();
					return;
				}
			}else
			{	
				if(document.forms[0].txt_noofshares.value=="")
				{
					ShowAlert('121', "Number of Units of the Company");
					document.forms[0].txt_noofshares.focus();
					return;
				}
			}
			 caltotalsecvalue('N');
		}

	   if(document.forms[0].hidAction.value != "new")
	   {
		   if((document.forms[0].txt_net_security.value!=document.forms[0].old_txt_net_security.value) ||
				   (document.forms[0].txt_Valuers_name.value!=document.forms[0].old_txt_Valuers_name.value) ||
				   (document.forms[0].txt_validation_date.value!=document.forms[0].old_txt_validation_date.value))
		  {
			 	if(trim(document.forms[0].txt_comments.value)=="")
				{
					ShowAlert('121', "Comments");
					document.forms[0].txt_comments.focus();
					return;
				}
			}
	   }
	   if((eval(document.forms[0].sel_securitytype.value)>9 && eval(document.forms[0].sel_securitytype.value)<18))
	   {
		  var netSecuritVal=parseFloat(document.forms[0].txt_net_security.value);
		 if(eval(netSecuritVal) > eval("100000000"))
		 {
			var tab  = document.getElementById("tabid_valuerlist");
			var rowsLength = tab.rows.length;
			var approveflag="N";
			if(document.forms[0].sel_alreadycharged.value=='N')
			{
				if(document.forms[0].txt_Valuers_code.value!="601")
				{
					if(rowsLength<2)
					{	
						alert("More than 2 valuation Required. Kindly Enter valuation Details");
						return false;
					}
					for(var j=0;j<rowsLength;j++)
					{
						if(document.forms[0].sel_approveFlag_mul[j].value=="Y")
						{
							approveflag="Y";
						}

						var propdistrict1=document.forms[0].hid_District.value;
						var varBflag1="false";
						if(document.forms[0].hidvaluationarea.value!="")
						{
							var varSplit=document.forms[0].hidvaluationarea.value.split("@");
							if(varSplit.length>=1)
							{
								for(var i=0;i<varSplit.length;i++)
								{
									var varSplit1=varSplit[i].split("~");
									if(varSplit1.length>1)
									{
										if(varSplit1[1]==propdistrict1 && varBflag1=="false")
										{
											varBflag1="true";
										}
									}
								}
							}
						}
						if(varBflag1=="false" &&  document.forms[0].hidPropFlag.value=="Y")
						{
							if(document.forms[0].hid_District.value=="")
							{
								alert("Select District in Property details ");
								
								funPropDet();
								return false;
							}
							else
							{
								if(document.forms[0].hidPropertycheck.value=="")
								{
									alert("Valuer selected is not empanelled to valuate property as per the district selected in Property details tab. If selected district is wrong then modify it or else obtain permission from CrMD");
									funPropDet();
									return false;
								}
								alert("The Valuer attached to this security not eligible to valuate this property. Please reattach the valuer/take permission from CrMD.");
								return false;
							}
						}
					}
				}
				else
				{
					if(rowsLength>=2)
					{	
						for(var j=0;j<rowsLength;j++)
						{
							if(document.forms[0].sel_approveFlag_mul[j].value=="Y")
							{
								approveflag="Y";
							}
						}
					}
					else
					{
						document.forms[0].sel_approveFlag_mul.value="Y";
						approveflag="Y";
						document.forms[0].txt_Valuers_name_mul.value= document.forms[0].txt_Valuers_name.value;
					     document.forms[0].txt_Valuers_code_mul.value= document.forms[0].txt_Valuers_code.value;
				    	 document.forms[0].txt_validation_date_mul.value =document.forms[0].txt_validation_date.value;
				  		 document.forms[0].txt_dateofsubmissionbybank_mul.value= document.forms[0].txt_dateofsubmissionbybank.value;
				 		 document.forms[0].txt_dateofreceiptbybank_mul.value= document.forms[0].txt_dateofreceiptbybank.value;
				 		 document.forms[0].txt_net_security_mul.value=document.forms[0].txt_net_security.value;
				 		 document.forms[0].txt_Valuers_catcode_mul.value=document.forms[0].txt_val_catCode.value;
				 		 document.forms[0].txt_Valuers_limit_mul.value=document.forms[0].txt_Valuers_limit.value;
				 		 document.forms[0].txt_Valuationloc_mul.value=document.forms[0].hidvaluationarea.value;
					}
				}
			}
			else
			{
				if(rowsLength>=2)
				{	
					for(var j=0;j<rowsLength;j++)
					{
						if(document.forms[0].sel_approveFlag_mul[j].value=="Y")
						{
							approveflag="Y";
						}
					}
				}
				else
				{
					document.forms[0].sel_approveFlag_mul.value="Y";
					approveflag="Y";
					document.forms[0].txt_Valuers_name_mul.value= document.forms[0].txt_Valuers_name.value;
				     document.forms[0].txt_Valuers_code_mul.value= document.forms[0].txt_Valuers_code.value;
			    	 document.forms[0].txt_validation_date_mul.value =document.forms[0].txt_validation_date.value;
			  		 document.forms[0].txt_dateofsubmissionbybank_mul.value= document.forms[0].txt_dateofsubmissionbybank.value;
			 		 document.forms[0].txt_dateofreceiptbybank_mul.value= document.forms[0].txt_dateofreceiptbybank.value;
			 		 document.forms[0].txt_net_security_mul.value=document.forms[0].txt_net_security.value;
			 		 document.forms[0].txt_Valuers_catcode_mul.value=document.forms[0].txt_val_catCode.value;
			 		 document.forms[0].txt_Valuers_limit_mul.value=document.forms[0].txt_Valuers_limit.value;
			 		 document.forms[0].txt_Valuationloc_mul.value=document.forms[0].hidvaluationarea.value;
			 		
					
				}
			}
			if(approveflag!="Y")
			{	
				alert("Kindly approve anyone of the Valuer Information");
				return false;
			}
		 }
		 else
		 {
			var tab  = document.getElementById("tabid_valuerlist");
			var rowsLength = tab.rows.length;
			if(rowsLength>1)
			{	
				var approveflag="N";
				for(var j=0;j<rowsLength;j++)
				{
					if(document.forms[0].sel_approveFlag_mul[j].value=="Y")
					{
						approveflag="Y";
					}
				}
				if(approveflag!="Y")
				{	
					alert("Kindly approve anyone of the Valuer Information");
					return false;
				}
			}
		 }



		var propdistrict=document.forms[0].hid_District.value;
		var varBflag="false";
		if(document.forms[0].hidvaluationarea.value!="")
		{
			var varSplit=document.forms[0].hidvaluationarea.value.split("@");
			if(varSplit.length>=1)
			{
				for(var i=0;i<varSplit.length;i++)
				{
					var varSplit1=varSplit[i].split("~");
					if(varSplit1.length>1)
					{
						if(varSplit1[1]==propdistrict && varBflag=="false")
						{
							varBflag="true";
						}
					}
				}
			}
		}
		if(varBflag=="false" && document.forms[0].txt_Valuers_code.value!="601" && document.forms[0].hidPropFlag.value=="Y")
		{
			if(document.forms[0].hid_District.value=="")
			{
				alert("Select District in Property details");
				
				funPropDet();
				
				return false;
			}
			else
			{
				if(document.forms[0].hidPropertycheck.value=="")
				{
					alert("Valuer selected is not empanelled to valuate property as per the district selected in Property details tab. If selected district is wrong then modify it or else obtain permission from CrMD");
					funPropDet();
					return false;
				}
				
				alert("The Valuer attached to this security not eligible to valuate this property. Please reattach the valuer/take permission from CrMD.");
				return false;
			}
		}
		
	   }

	   if(document.forms[0].sel_securitytype.value=="22")
	   {
		   var s="",s1="";
		    var cersai_id="";
		    var cer_date="";
			var tab  = document.getElementById("tabid_Cropvaluerlist");
			var rowsLength = tab.rows.length;	
			
			if(rowsLength==1)
			{	
				/*if(document.forms[0].txt_cersai_Crop_id.value=="")
				{
					alert("Enter CERSAI ID");
					document.forms[0].txt_cersai_Crop_id.focus();
					return;
				}*/
				if(document.forms[0].txt_cersai_Crop_id.value!="" && document.forms[0].txt_Cersai_Crop_Date.value=="")
				{
					alert("Enter CERSAI ASSET ID Creation Date");
					document.forms[0].txt_Cersai_Crop_Date.focus();
					return;
				}
				if(document.forms[0].txt_cersai_Crop_id.value!=undefined)
				{
					s = document.forms[0].txt_cersai_Crop_id.value; 
					s1=	document.forms[0].txt_Cersai_Crop_Date.value;
				}
				else
				{
					s = document.forms[0].txt_cersai_Crop_id[0].value; 
					s1=	document.forms[0].txt_Cersai_Crop_Date[0].value;
				}
		    }

			else if(rowsLength>1)
			{
				for(var i=0;i<rowsLength;i++)
				{
					if(document.forms[0].txt_cersai_Crop_id[i].value=="")
					{
						alert("Enter CERSAI ID");
						document.forms[0].txt_cersai_Crop_id[i].focus();
						return;
					}
					else if(document.forms[0].txt_Cersai_Crop_Date[i].value=="")
					{
						alert("Enter CERSAI ASSET ID Creation Date");
						document.forms[0].txt_Cersai_Crop_Date[i].focus();
						return;
					}
					if(s=="")
					{
						s = document.forms[0].txt_cersai_Crop_id[i].value; 
						s1=	document.forms[0].txt_Cersai_Crop_Date[i].value;
			        }
			        else
			        {
						s =s+"@"+ document.forms[0].txt_cersai_Crop_id[i].value; 
						s1=	s1+"@"+document.forms[0].txt_Cersai_Crop_Date[i].value;
			        }
	
				}
		    }
		    document.forms[0].txt_cersai_id.value = s;
			document.forms[0].txt_CersaiDate.value = s1;

			cersailIDCorp=s.split("@");
	   }
	   var tab  = document.getElementById("tabid_Cropvaluerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength>1)
		{
			for(var i=0;i<cersailIDCorp.length;i++)
			{
				for (var j=i+1;j<cersailIDCorp.length;j++)
				{
					if(cersailIDCorp[i]!="" && cersailIDCorp[i]==cersailIDCorp[j])
					{
							alert(cersailIDCorp[j]+" Cersail Id Already used,we can't modify!!!!");
							document.forms[0].txt_cersai_id[j].focus();
							return;
					}
				}
			}
		}
	  		 if((document.forms[0].hidAction.value == "new"))
			{
	  			var con = confirm("After Completion of the security, it will forwarded for Verification. Do you want to Proceed?");
	  			if(!con)
	  			{
	  				return;
	  			}

			}
	  		else
	  		{
		  		if((document.forms[0].txt_net_security.value!=document.forms[0].old_txt_net_security.value) ||
		 			   (document.forms[0].txt_Valuers_name.value!=document.forms[0].old_txt_Valuers_name.value) ||
					   (document.forms[0].txt_validation_date.value!=document.forms[0].old_txt_validation_date.value)) 
		  		{
		  			var con = confirm("Security Value / Valuation Details has been changed,needs to be send for Verification. Do you want to Proceed?");
		  			if(!con)
		  			{
		  				return;
		  			}
		  		}
	  		}
	  		 
	  		
	  disableValuerDetails();

	   modifyCheck();
	   
	    document.forms[0].txt_dateofsubmissionbybank.readOnly=false;
		 document.forms[0].txt_dateofreceiptbybank.readOnly=false;
		 document.forms[0].txt_validation_date.readOnly=false;
		 document.forms[0].txt_total_secval.readOnly=false;
	   document.forms[0].cmdsave.disabled = true;
	   document.forms[0].sel_securitytype.disabled=false;
	   document.forms[0].sel_alreadycharged.disabled=false;
		var rowCount=document.all.id_jointsec.rows.length;
		document.forms[0].hidOwners.value=rowCount;
		document.forms[0].hidDemoId.value = varAppid;
		document.forms[0].hidBeanId.value = "securitymaster";
		document.forms[0].hidBeanMethod.value = "updateSecurities";
		document.forms[0].hidBeanGetMethod.value = "getSecurities";
		document.forms[0].hidSourceUrl.value = "/action/customer_securities.jsp";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}

	function captureComments()
	{
	   if(document.forms[0].hidAction.value != "new")
	   {	
			if((document.forms[0].txt_net_security.value!=document.forms[0].old_txt_net_security.value) ||
			   (document.forms[0].txt_Valuers_name.value!=document.forms[0].old_txt_Valuers_name.value) ||
			   (document.forms[0].txt_validation_date.value!=document.forms[0].old_txt_validation_date.value))
			{
				alert("Security Value/Valuer detail changed. Please enter comments");
				document.all.com1.style.visibility = "visible";
				document.all.com1.style.position = "relative";
				document.all.com2.style.visibility = "visible";
				document.all.com2.style.position = "relative";		
				if(document.forms[0].txt_comments.value==document.forms[0].old_txt_comments.value)
				{
					document.forms[0].txt_comments.value="";
				}
				document.forms[0].txt_comments.focus();
			}
 		}
	}

	function modifyCheck()
	{
		var temp="";
		var tempname="";
		document.forms[0].sel_natureChargeText.value=document.forms[0].sel_natureCharge.options[document.forms[0].sel_natureCharge.selectedIndex].text;
		document.forms[0].sel_securityclassifcationText.value=document.forms[0].sel_securityclassifcation.options[document.forms[0].sel_securityclassifcation.selectedIndex].text;
		
		if(document.forms[0].sel_natureChargeText.value!=document.forms[0].old_sel_natureChargeText.value)
		{
			temp=temp+"old_sel_natureChargeText"+"@"; 
			tempname=tempname+"Nature of Charge"+"@";
		}
		if(document.forms[0].sel_securityclassifcationText.value!=document.forms[0].old_sel_securityclassifcationText.value)
		{
			temp=temp+"old_sel_securityclassifcationText"+"@"; 
			tempname=tempname+"Security Classification"+"@";
		}
		if(document.forms[0].txt_total_secval.value!=document.forms[0].old_txt_total_secval.value)
		{
			temp=temp+"old_txt_total_secval"+"@"; 
			tempname=tempname+"Market Value"+"@";
		}
		if(document.forms[0].sel_securitytype.value!=document.forms[0].old_sel_securitytype.value)
		{
			temp=temp+"old_sel_securitytype"+"@"; 
			tempname=tempname+"Security Type"+"@";
		}
		if(document.forms[0].sel_alreadycharged.value!=document.forms[0].old_sel_alreadycharged.value)
		{
			temp=temp+"old_sel_alreadycharged"+"@"; 
			tempname=tempname+"Already Charged"+"@";
		}
		if(document.forms[0].txt_security_clasicification_specify.value!=document.forms[0].old_txt_security_clasicification_specify.value)
		{
			temp=temp+"old_txt_security_clasicification_specify"+"@"; 
			tempname=tempname+"Specify (Other Security Classification)"+"@";
		}
		if(document.forms[0].txt_Valuers_name.value!=document.forms[0].old_txt_Valuers_name.value)
		{
			temp=temp+"old_txt_Valuers_name"+"@"; 
			tempname=tempname+"Valuer Name"+"@";
		}
		if(document.forms[0]. txt_validation_date.value!=document.forms[0].old_txt_validation_date.value)
		{
			temp=temp+"old_txt_validation_date"+"@"; 
			tempname=tempname+"Date of Valuation"+"@";
		}
		if(document.forms[0].txt_security_desc.value!=document.forms[0].old_txt_security_desc.value)
		{
			temp=temp+"old_txt_security_desc"+"@"; 
			tempname=tempname+"Security Description"+"@";
		}
		if(document.forms[0].txt_insurence_company.value!=document.forms[0].old_txt_insurence_company.value)
		{
			temp=temp+"old_txt_insurence_company"+"@"; 
			tempname=tempname+"Insurance Company"+"@";
		}
		if(document.forms[0]. txt_collareral_start_date.value!=document.forms[0].old_txt_collareral_start_date.value)
		{
			temp=temp+"old_txt_collareral_start_date"+"@"; 
			tempname=tempname+"Collateral Start Date"+"@";
		}
		if(document.forms[0]. txt_insured_amount.value!=document.forms[0].old_txt_insured_amount.value)
		{
			temp=temp+"old_txt_insured_amount"+"@"; 
			tempname=tempname+"Insured Amount"+"@";
		}
		if(document.forms[0]. txt_collareral_end_date.value!=document.forms[0].old_txt_collareral_end_date.value)
		{
			temp=temp+"old_txt_collareral_end_date"+"@"; 
			tempname=tempname+"Collateral End Date"+"@";
		}
		if(document.forms[0].txt_duedate.value!=document.forms[0].old_txt_duedate.value)
		{
			temp=temp+"old_txt_duedate"+"@"; 
			tempname=tempname+"Due Date"+"@";
		}
		if(document.forms[0]. sel_jointholder.value!=document.forms[0].old_sel_jointholder.value)
		{
			temp=temp+"old_sel_jointholder"+"@"; 
			tempname=tempname+"Joint Holder"+"@";
		}
		if(document.forms[0].txt_net_security.value!=document.forms[0].old_txt_net_security.value)
		{
			temp=temp+"old_txt_net_security"+"@"; 
			tempname=tempname+"Net Security Value"+"@";
		}
		if(document.forms[0].txt_security_type_specify.value!=document.forms[0].old_txt_security_type_specify.value)
		{
			temp=temp+"old_txt_security_type_specify"+"@"; 
			tempname=tempname+"Specify (Other Security Type)"+"@";
		}
		if(document.forms[0].sel_residual_risk.value!=document.forms[0].old_sel_residual_risk.value)
		{
			temp=temp+"old_sel_residual_risk"+"@"; 
			tempname=tempname+"Residual Risk Flag"+"@";
		}
		if(document.forms[0].txt_charged_to_institution.value!=document.forms[0].old_txt_charged_to_institution.value)
		{
			temp=temp+"old_txt_charged_to_institution"+"@"; 
			tempname=tempname+"Amount Charged to other institution"+"@";
		}
		if(document.forms[0].txt_name_institution.value!=document.forms[0].old_txt_name_institution.value)
		{
			temp=temp+"old_txt_name_institution"+"@"; 
			tempname=tempname+"Name of the institution"+"@";
		}
		if(document.forms[0].txt_residual_amount.value!=document.forms[0].old_txt_residual_amount.value)
		{
			temp=temp+"old_txt_residual_amount"+"@"; 
			tempname=tempname+"Residual amount"+"@";
		}
		if(document.forms[0]. txt_com_cinno.value!=document.forms[0].old_txt_com_cinno.value)
		{
			temp=temp+"old_txt_com_cinno"+"@"; 
			tempname=tempname+"Company CIN No"+"@";
		}
		if(document.forms[0].txt_companyname.value!=document.forms[0].old_txt_companyname.value)
		{
			temp=temp+"old_txt_companyname"+"@"; 
			tempname=tempname+"Company Name"+"@";
		}
		if(document.forms[0].txt_shareval.value!=document.forms[0].old_txt_shareval.value)
		{
			temp=temp+"old_txt_shareval"+"@"; 
			tempname=tempname+"Share Value"+"@";
		}
		if(document.forms[0].txt_noofshares.value!=document.forms[0].old_txt_noofshares.value)
		{
			temp=temp+"old_txt_noofshares"+"@"; 
			tempname=tempname+"No of shares"+"@";
		}
		if(document.forms[0].txt_dateofsubmissionbybank.value!=document.forms[0].old_txt_dateofsubmissionbybank.value)
		{
			temp=temp+"old_txt_dateofsubmissionbybank"+"@"; 
			tempname=tempname+"Date of submission of request"+"@";
		}
		if(document.forms[0].txt_dateofreceiptbybank.value!=document.forms[0].old_txt_dateofreceiptbybank.value)
		{
			temp=temp+"old_txt_dateofreceiptbybank"+"@"; 
			tempname=tempname+"Date of receipt of valuation report"+"@";
		}
		if(document.forms[0].txt_comments.value!=document.forms[0].old_txt_comments.value)
		{
			temp=temp+"old_txt_comments"+"@"; 
			tempname=tempname+"Comments"+"@";
		}
		
		if(document.forms[0].txt_secintID_roc.value!=document.forms[0].old_txt_secintID_roc.value)
		{
			temp=temp+"old_txt_secintID_roc"+"@"; 
			tempname=tempname+"Security interest ID with ROC "+"@";
		}
		if(document.forms[0].txt_charid_roc.value!=document.forms[0].old_txt_charid_roc.value)
		{
			temp=temp+"old_txt_charid_roc"+"@"; 
			tempname=tempname+"Charge ID with ROC"+"@";
		}
		if(document.forms[0].sel_type.value!=document.forms[0].old_sel_type.value)
		{
			temp=temp+"old_sel_type"+"@"; 
			tempname=tempname+"Share Type"+"@";
		}
		if(document.forms[0].txt_cersai_id.value!=document.forms[0].old_hid_cersai_id.value)
		{
			temp=temp+"old_hid_cersai_id"+"@"; 
			tempname=tempname+"CERSAI ID"+"@";
		}
		if(document.forms[0].txt_CersaiDate.value!=document.forms[0].old_hid_cersai_date.value)
		{
			temp=temp+"old_hid_cersai_date"+"@"; 
			tempname=tempname+"CERSAI ASSET ID Creation Date"+"@";
		}
		var newRowCount=document.all.id_jointsec.rows.length;
		var oldRowCount=document.forms[0].hid_oldSecOwnerLength.value;
		if(oldRowCount!=parseInt(newRowCount-1))
		{
			temp=temp+"old_hid_SecOwnerList"+"@"; 
			tempname=tempname+"Security Ownership"+"@";
		}
		
		   document.forms[0].hidmodifiedvalue.value = temp;
		   document.forms[0].hidmodifiedField.value = tempname;
			   
	}

	function doCancel() {
		ConfirmMsg(102);
		document.forms[0].hidAction.value = "";
		disableButtons(true, true, true, true, true, false, false);
		document.forms[0].hidBeanId.value = "securitymaster";
		document.forms[0].hidBeanMethod.value = "getSecurities";
		document.forms[0].hidBeanGetMethod.value = "getSecurities";
		document.forms[0].hidSourceUrl.value = "/action/customer_securities.jsp";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}

	function doRelease() {
	//var varFlag="Release";
		if(document.forms[0].hidReleaseFlag.value=="N")
		{
			//varFlag="Unrelease";
		}

		if (confirm('You cannot unrelease the security once it is released. Do you want to continue?')) {
			var rowCount=document.all.id_jointsec.rows.length;
			document.forms[0].hidOwners.value=rowCount;
			document.forms[0].hidDemoId.value = varAppid;
			document.forms[0].hidAction.value = "Release";
			document.forms[0].hidBeanId.value = "securitymaster";
			document.forms[0].hidBeanMethod.value = "updateSecurities";
			document.forms[0].hidBeanGetMethod.value = "getSecurities";
			document.forms[0].hidSourceUrl.value = "/action/customer_securities.jsp";
			document.forms[0].action = appURL + "controllerservlet";
			document.forms[0].submit();
		}

	}

	function doClose() {
		if (ConfirmMsg(100)) {
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();
		}
	}

	function clearfields() {
		document.forms[0].sel_securitytype.value = "0";
		document.forms[0].sel_securityclassifcation.value = "0";
		document.forms[0].txt_security_desc.value = "";
		document.forms[0].txt_net_security.value = "";
		document.forms[0].txt_security_type_specify.value = "";
		document.forms[0].txt_security_clasicification_specify.value = "";
		document.forms[0].txt_collareral_start_date.value = "";
		document.forms[0].txt_collareral_end_date.value = "";
		document.forms[0].sel_alreadycharged.value = "";
		document.forms[0].txt_charged_to_institution.value = "";
		document.forms[0].txt_name_institution.value = "";
		document.forms[0].sel_residual_risk.value = "";
		document.forms[0].txt_Valuers_name.value = "";
		document.forms[0].txt_validation_date.value = "";
		document.forms[0].txt_insurence_company.value = "";
		document.forms[0].txt_insured_amount.value = "";
		document.forms[0].txt_duedate.value = "";
		document.forms[0].sel_jointholder.value = "";
		document.forms[0].txt_residual_amount.value ="0";
	}

	function selectValues(val1, val2, val3, val4, val5, val6, val7, val8, val9,
			val10, val11, val12, val13, val14, val15, val16, val17, val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val32,val33,val35,val36,val37,val38,val39,val40,val41,val42,val43,val44,val45,val46,
			val47,val48,val49,val50,val51,val52,val53,val54,val55,val56,val57,val58,val59,val60,val61,val62,val63,val64,val65,val66,val67,val68,val69,val70) 
{
		var securityowners=val24;
		document.forms[0].hidSecurityId.value = val1;
		document.forms[0].sel_securitytype.value = val2;
		document.forms[0].old_sel_securitytype.value = val2;
		//document.forms[0].sel_securityclassifcation.value= val3;
		document.forms[0].txt_security_desc.value = val4;
		document.forms[0].old_txt_security_desc.value = val4;
		document.forms[0].txt_net_security.value = val5;
		document.forms[0].old_txt_net_security.value = val5;
		document.forms[0].txt_security_type_specify.value = val6;
		document.forms[0].old_txt_security_type_specify.value = val6;
		document.forms[0].txt_security_clasicification_specify.value = val7;
		document.forms[0].old_txt_security_clasicification_specify.value = val7;
		document.forms[0].txt_collareral_start_date.value = val8;
		document.forms[0].old_txt_collareral_start_date.value = val8;
		document.forms[0].txt_collareral_end_date.value = val9;
		document.forms[0].old_txt_collareral_end_date.value = val9;
		document.forms[0].sel_alreadycharged.value = val10;
		document.forms[0].old_sel_alreadycharged.value = val10;
		document.forms[0].txt_charged_to_institution.value = val11;
		document.forms[0].old_txt_charged_to_institution.value = val11;
		document.forms[0].txt_name_institution.value = val47;
		document.forms[0].old_txt_name_institution.value = val47;
		document.forms[0].sel_residual_risk.value = val13;
		document.forms[0].old_sel_residual_risk.value = val13;
		document.forms[0].txt_Valuers_name.value = val14;
		document.forms[0].old_txt_Valuers_name.value = val14;
		document.forms[0].txt_validation_date.value = val15;
		document.forms[0].old_txt_validation_date.value = val15;
		document.forms[0].txt_insurence_company.value = val16;
		document.forms[0].old_txt_insurence_company.value = val16;
		document.forms[0].txt_insured_amount.value = val17;
		document.forms[0].old_txt_insured_amount.value = val17;
		document.forms[0].txt_duedate.value = val18;
		document.forms[0].old_txt_duedate.value = val18;
		document.forms[0].sel_jointholder.value = val19;
		document.forms[0].old_sel_jointholder.value = val19;
		document.forms[0].txt_residual_amount.value = val25;
		document.forms[0].old_txt_residual_amount.value = val25;
		document.forms[0].sel_natureCharge.value = val26;
		document.forms[0].txt_Valuers_code.value = val51;
		document.forms[0].old_txt_Valuers_code.value=val51;
		if(val26!="")
			document.forms[0].old_sel_natureChargeText.value = document.forms[0].sel_natureCharge.options[document.forms[0].sel_natureCharge.selectedIndex].text; 

		//document.forms[0].sel_weathliquid.value=val29;
		//showMaturDate();
		//document.forms[0].txt_matudateliq.value=val28;
		
		//duplicate values to check for any modification
		
		
		var varAppId=document.forms[0].hidDemoId.value;
		var SecurityId=document.forms[0].hidSecurityId.value;
		var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
		document.all.ifrmsecurityclassification.src = appURL
				+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
				+ varSecurityType + "&sectype=" + val3 + "&appid=" + varAppId +"&secID=" + SecurityId;

		//document.forms[0].old_sel_securityclassifcationText.value=document.forms[0].sel_securityclassifcation.options[document.forms[0].sel_securityclassifcation.selectedIndex].text;
		selJointHolder();
		displayTab(val23);
		showSpecify('N');
		chargedDetails();
		//ownersdel();
		jointownerdelall();
		jointownerdisp(securityowners);
		//document.all.jointdetails.style.visibility = "visible";
		//document.all.jointdetails.style.position = "relative";
		cropCerial();
		govtValuerCheck();
		document.forms[0].txt_gvtscheme_name.value=val66;
		document.forms[0].hidCount.value = val27;
		if(val27=="0")
		{
			disableButtons(true, false, true, true, false, false, true);
		}
		else
		{	
			disableButtons(true, false, true, true, true, false, true);
		}
		document.forms[0].txt_total_secval.value = val30;
		document.forms[0].old_txt_total_secval.value = val30;
		document.forms[0].cmdsecurityownershipchange.disabled=false;
		if(val32=="N")
		{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdrelease.disabled=true;
		}
		if(val50!="")
		{
			var temp=val50;
			clearrows("tabid_valuerlist");
			document.all.ValuerDetails1.style.visibility="visible";
		    document.all.ValuerDetails1.style.position="relative";
		    document.all.ValuerDetails2.style.visibility="visible";
		    document.all.ValuerDetails2.style.position="relative"; 
			document.forms[0].cmdedit.disabled=true;
			 valuerlistDisp(temp);
			document.forms[0].cmdedit.disabled=false;		
			document.forms[0].hid_ValuerListDisp_temp.value="Y";	
		}
		else
		{
			clearrows("tabid_valuerlist");	 
		 	document.forms[0].txt_Valuers_name_mul.value="" ;
       	 	document.forms[0].txt_validation_date_mul.value = "";
     		document.forms[0].txt_dateofsubmissionbybank_mul.value= "";
    		document.forms[0].txt_dateofreceiptbybank_mul.value= "";
    		document.forms[0].txt_net_security_mul.value= "";
			document.all.ValuerDetails1.style.visibility="hidden";
		    document.all.ValuerDetails1.style.position="relative";
		    document.all.ValuerDetails2.style.visibility="hidden";
		    document.all.ValuerDetails2.style.position="relative"; 
		}
		document.forms[0].hid_VerificationFlag.value = val33;
	
		document.forms[0].txt_comments.value=val44;
		document.forms[0].old_txt_comments.value=val44;
		if(val44!="")
		{
			document.all.com1.style.visibility = "visible";
			document.all.com1.style.position = "relative";
			document.all.com2.style.visibility = "visible";
			document.all.com2.style.position = "relative";	
		}
		else
		{
			document.all.com1.style.visibility = "hidden";
			document.all.com1.style.position = "absolute";
			document.all.com2.style.visibility = "hidden";
			document.all.com2.style.position = "absolute";	
		}
		
		document.forms[0].hidOwnerChange.value=val35;
		document.forms[0].hidOwnerChangeAppno.value=val36;
		document.forms[0].txt_com_cinno.value=val37;
		document.forms[0].old_txt_com_cinno.value=val37;
		document.forms[0].txt_companyname.value=val38;
		document.forms[0].old_txt_companyname.value=val38;
		document.forms[0].hidcompanycode.value=val39;
		document.forms[0].txt_shareval.value=roundVal(val40);
		document.forms[0].old_txt_shareval.value=roundVal(val40);
		document.forms[0].txt_noofshares.value=val41;
		document.forms[0].txt_dateofsubmissionbybank.value=val42;
		document.forms[0].txt_dateofreceiptbybank.value=val43;
		document.forms[0].old_txt_dateofsubmissionbybank.value=val42;
		document.forms[0].old_txt_dateofreceiptbybank.value=val43;

		document.forms[0].txt_val_catCode.value=val48;
		document.forms[0].sel_currentEmpList.value=val49;
		
		document.forms[0].txt_secintID_roc.value=val45;
		document.forms[0].old_txt_secintID_roc.value=val45;
		document.forms[0].txt_charid_roc.value=val46;
		document.forms[0].old_txt_charid_roc.value=val46;
		document.forms[0].hid_LeadBankcode.value=val12;
		
		document.forms[0].old_txt_noofshares.value=val41;
		document.forms[0].sel_type.value=val52;
		document.forms[0].old_sel_type.value=val52;
		document.forms[0].txt_Valuers_limit.value=val53;
		document.forms[0].txt_cersai_id.value=val54;
		document.forms[0].old_hid_cersai_id.value=val54;
		document.forms[0].txt_CersaiDate.value=val55;
		clearrows("tabid_Cropvaluerlist");
		Totalvalue(val54,val55);

		if(val33=="Y" || val33=="W" || val33=="V"|| val33=="F"){

			if(val33=="V")
			{
				alert("Security Verification Pending");
			}
			if(val33=="Y" || val33=="V"|| val33=="F")
			{
				document.forms[0].cmdsecurityownershipchange.disabled=true;
			}
			document.forms[0].cmdrelease.disabled=true;
			document.forms[0].hidReleaseFlag.value="N";
			disableButtons(true, true, true, true, true, false, false);
			document.all.idheader.style.display="none";
		}
		else
		{
			document.forms[0].hidReleaseFlag.value="Y";
			document.all.idheader.style.display="table-cell";
			
		}

		
		document.forms[0].old_hid_cersai_date.value=val55;
		document.forms[0].hidDistrict.value=val56;
		document.forms[0].hidPropFlag.value=val57;
		document.forms[0].hidvaluationarea.value=val58;
		document.forms[0].hidsecuritystatus.value=val59;

		document.forms[0].hidcity.value=val60;
		document.forms[0].txt_City.value=val61;
		document.forms[0].hidstate.value=val62;
		document.forms[0].txt_State.value=val63;
		document.forms[0].hid_District.value=val64;
		document.forms[0].txt_District.value=val65;
		document.forms[0].sel_property.value=val67;
		
		if(document.forms[0].sel_property.value=="Y")
			{
			document.all.idlessor1.style.visibility="visible";
			document.all.idlessor1.style.position="relative";
			
			document.all.idlessor2.style.visibility="visible";
			document.all.idlessor2.style.position="relative";
			}
		else
			{
			document.all.idlessor1.style.visibility="hidden";
			document.all.idlessor1.style.position="absolute";
			
			document.all.idlessor2.style.visibility="hidden";
			document.all.idlessor2.style.position="absolute";
			}
		document.forms[0].sel_lessor.value=val68;
		
		document.forms[0].hid_value_as_per_valuation.value=val69;
		document.forms[0].hid_fsv_val.value=val70;
		
		
		
		
		
		//document.forms[0].old_txt_Valuation.value=val68;
		//document.forms[0].old_txt_ForcedSale.value=val69;
		//document.forms[0].txt_Valuation.value=val68;
		///document.forms[0].txt_ForcedSale.value=val69;
		

		
		document.forms[0].sel_alreadycharged.disabled=true;
		<%if(grpRights.charAt(18)=='r'){%>
		disableButtons(true, true, true, true, true, true, false);
		document.forms[0].cmdsecurityownershipchange.disabled=true;
		<%}%>
		disableFields(true);
		document.forms[0].sel_alreadycharged.disabled=true;
		document.forms[0].hidPropertycheck.value="";
		

	}

	function clearrows(tabid)
	{
		var table=document.getElementById(tabid);
		var rowCount=table.rows.length;
		if(rowCount > 0)
		{
			for(var i=rowCount-1;i>0;i--)
			{
				table.deleteRow(i);      
			}
		}
	}
	
	function jointownerdelall()
	{
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;
		if(rowCount > 1)
		{
			for(var i=rowCount-1;i>0;i--)
			{
				table.deleteRow(i);      
			}
		}
		else
		{
			//No Function
		}
	}
	function jointSecurityDel()
	{
		var varLapsID=document.forms[0].txt_security_ownership.value;
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
						alert("You can't remove owner of the security");
						return;
					}
					else if(document.forms[0].rad_chk[i-1].checked==true)
					{
					table.deleteRow(i);
					--i;     
					--rowCount; 
					}
				}
				else
				{
					alert("You can't remove owner of the security");
				}
			}
			document.forms[0].txt_security_ownership.value="";
		}
	}
	function callLAPSID(id)
	{
		document.forms[0].txt_security_ownership.value=id;	
	}
	function jointownerdisp(securityowners)
	{
		var var_arr= securityowners.split("@");
		var length=var_arr.length;
		var tempOwnerList="";
		var ownercount="0";
		for(var i=0;i<length-1;i=i+3)
		{
			var j=i;
			var table=document.all.id_jointsec;
			var rowCount=table.rows.length;
			ownercount++;
			
			var row=table.insertRow(rowCount);
			var varName=var_arr[j];
			var varLapsID=var_arr[++j];
			var varCBSID=var_arr[++j];
			tempOwnerList=tempOwnerList+varName+"("+varCBSID+"), ";
			
			var cell0=row.insertCell(0);
			cell0.className="datagrid";
			cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+varLapsID+')">';		
				
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
		document.forms[0].old_hid_SecOwnerList.value=tempOwnerList;
		document.forms[0].hid_SecOwnerList.value=tempOwnerList;
		document.forms[0].hid_oldSecOwnerLength.value=ownercount;	
	}

	function disableFields(val) {
		for ( var i = 0; i < document.forms[0].length; i++) {
			if (document.forms[0].elements[i].type == 'textarea') {
				document.forms[0].elements[i].readOnly = val;
			}
			if (document.forms[0].elements[i].type == 'text') {
				document.forms[0].elements[i].readOnly = val;
			}
			if (document.forms[0].elements[i].type == 'select-one') {
				document.forms[0].elements[i].disabled = val;
			}
		}
	}
	function disableButtons(bool1, bool2, bool3, bool4, bool5, bool6, bool7) {
		document.forms[0].cmdnew.disabled = bool1;
		document.forms[0].cmdedit.disabled = bool2;
		document.forms[0].cmdsave.disabled = bool3;
		document.forms[0].cmdcancel.disabled = bool4;
		document.forms[0].cmdrelease.disabled = bool5; // As per Delete Functionality - by DINESH on 07/02/2014
		document.forms[0].cmdclose.disabled = bool7;
	}
	function callLink(page, bean, method) {
		if (document.forms[0].cmdapply.disabled) {
			document.forms[0].hidSourceUrl.value = page;
			document.forms[0].hidBeanGetMethod.value = method;
			document.forms[0].hidBeanId.value = bean;
			document.forms[0].action = appUrl + "action/" + page;
			document.forms[0].submit();
		} else {
			ShowAlert(103);
		}
	}
	function callCalender(name) {

		if (document.forms[0].cmdsave.disabled == false) {

			if(name=="txt_dateofsubmissionbybank" || name=="txt_dateofreceiptbybank" || name=="txt_validation_date" )
			{
				var tab  = document.getElementById("tabid_valuerlist");
				var rowsLength = tab.rows.length;
				if(rowsLength>1)
				{
					return false;
				}
			}
			showCal(appURL, name);
		}
	}
	function callCalender_mul(name,rowindex) {

	 /*	if(rowindex=="0")
		{
				return false;
		}  */

		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;

		if(rowsLength>1)
		{
			if(document.forms[0].txt_Valuers_name_mul[rowindex].disabled == true)
			{
				return false;
			}
	
			name=name+"["+(rowindex)+"]";
		}
		if (document.forms[0].cmdsave.disabled == false) {

			showCal(appURL, name);
		}
	}

	function callSecurityType() {
		var varSecurityType = document.forms[0].sel_securitytype.options[document.forms[0].sel_securitytype.selectedIndex].value;
		document.all.ifrmsecurityclassification.src = appURL
				+ "action/ifrmsecurityclassification.jsp?hidBeanGetMethod=getSecurityClassification&hidBeanId=securitymaster&securityclassificationtype="
				+ varSecurityType;
	}
	function chargedDetails() {
		if (document.forms[0].sel_alreadycharged.value == "Y") {
			document.all.amtcharged.style.visibility = "visible";
			document.all.amtcharged.style.position = "relative";
			document.all.amtcharged1.style.visibility = "visible";
			document.all.amtcharged1.style.position = "relative";
			document.all.instname.style.visibility = "visible";
			document.all.instname.style.position = "relative";
			document.all.instname1.style.visibility = "visible";
			document.all.instname1.style.position = "relative";
			
		} else {
			document.forms[0].txt_charged_to_institution.value="0.00";
			document.all.amtcharged.style.visibility = "hidden";
			document.all.amtcharged.style.position = "absolute";
			document.all.amtcharged1.style.visibility = "hidden";
			document.all.amtcharged1.style.position = "absolute";
			document.all.instname.style.visibility = "hidden";
			document.all.instname.style.position = "absolute";
			document.all.instname1.style.visibility = "hidden";
			document.all.instname1.style.position = "absolute";

		}
	}
	function selJointHolder() {
		if (document.forms[0].sel_jointholder.value == "Y") {			
			document.all.ownership.style.visibility = "visible";
			document.all.ownership.style.position = "relative";
			document.all.ownership1.style.visibility = "visible";
			document.all.ownership1.style.position = "relative";
			document.all.id_jointsec.style.visibility="visible";
			document.all.id_jointsec.style.position="relative";
			document.all.id_ownerdet.style.visibility = "visible";
			document.all.id_ownerdet.style.position = "relative";
			
		} else{
			
			document.all.ownership.style.visibility = "hidden";
			document.all.ownership.style.position = "absolute";
			document.all.ownership1.style.visibility = "hidden";
			document.all.ownership1.style.position = "absolute";
			document.all.id_jointsec.style.visibility="hidden";
			document.all.id_jointsec.style.position="absolute";
			document.all.id_ownerdet.style.visibility = "hidden";
			document.all.id_ownerdet.style.position = "absolute";
		}

	}

	function displayTab(selected) {	
		var i=selected;	
		varSecType = document.forms[0].sel_securitytype.value;
		if(secCount>1){
			if (document.forms[0].radiobutton[i].checked == true && varSecType ==22) {
				
				document.all.displayTab22.style.visibility = "visible";
				document.all.displayTab22.style.position = "relative";
			} else {
				document.all.displayTab22.style.visibility = "hidden";
				document.all.displayTab22.style.position = "absolute";

			}
			
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==5) {
			
			document.all.displayTab5.style.visibility = "visible";
			document.all.displayTab5.style.position = "relative";
		} else {
			document.all.displayTab5.style.visibility = "hidden";
			document.all.displayTab5.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==6) {
			document.all.displayTab6.style.visibility = "visible";
			document.all.displayTab6.style.position = "relative";
		} else {
			document.all.displayTab6.style.visibility = "hidden";
			document.all.displayTab6.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==7) {
			document.all.displayTab7.style.visibility = "visible";
			document.all.displayTab7.style.position = "relative";
		} else {
			document.all.displayTab7.style.visibility = "hidden";
			document.all.displayTab7.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==8) {
			document.all.displayTab8.style.visibility = "visible";
			document.all.displayTab8.style.position = "relative";
		} else {
			document.all.displayTab8.style.visibility = "hidden";
			document.all.displayTab8.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==9) {
			document.all.displayTab9.style.visibility = "visible";
			document.all.displayTab9.style.position = "relative";
		} else {
			document.all.displayTab9.style.visibility = "hidden";
			document.all.displayTab9.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && (varSecType ==10 || varSecType ==11 || varSecType ==12 || varSecType ==13 || varSecType ==14 || varSecType ==15 || varSecType ==16 || varSecType ==17)) {
			document.all.displayTab10.style.visibility = "visible";
			document.all.displayTab10.style.position = "relative";
			document.all.displayTab88.style.visibility = "visible";
			document.all.displayTab88.style.position = "relative";
			
		} else {
			document.all.displayTab10.style.visibility = "hidden";
			document.all.displayTab10.style.position = "absolute";
			document.all.displayTab88.style.visibility = "hidden";
			document.all.displayTab88.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==18) {
			document.all.displayTab18.style.visibility = "visible";
			document.all.displayTab18.style.position = "relative";
		} else {
			document.all.displayTab18.style.visibility = "hidden";
			document.all.displayTab18.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==19) {
			document.all.displayTab19.style.visibility = "visible";
			document.all.displayTab19.style.position = "relative";
		} else {
			document.all.displayTab19.style.visibility = "hidden";
			document.all.displayTab19.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==20) {
			document.all.displayTab20.style.visibility = "visible";
			document.all.displayTab20.style.position = "relative";
		} else {
			document.all.displayTab20.style.visibility = "hidden";
			document.all.displayTab20.style.position = "absolute";

		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==21) {
			document.all.displayTab21.style.visibility = "visible";
			document.all.displayTab21.style.position = "relative";
			document.all.displayTab22.style.visibility = "visible";
			document.all.displayTab22.style.position = "relative";
		} else {
			document.all.displayTab21.style.visibility = "hidden";
			document.all.displayTab21.style.position = "absolute";
			document.all.displayTab22.style.visibility = "hidden";
			document.all.displayTab22.style.position = "absolute";
		}
		if (document.forms[0].radiobutton[i].checked == true && varSecType ==22) {
			document.all.displayTab24.style.visibility = "visible";
			document.all.displayTab24.style.position = "relative";
		} else {
			document.all.displayTab24.style.visibility = "hidden";
			document.all.displayTab24.style.position = "absolute";

		}

		if (document.forms[0].radiobutton[i].checked == true && varSecType == 3) {
			document.all.displayTab25.style.visibility = "visible";
			document.all.displayTab25.style.position = "relative";
			document.all.Cersai_det.style.visibility = "visible";
			document.all.Cersai_det.style.position = "relative";
		} else {
			document.all.displayTab25.style.visibility = "hidden";
			document.all.displayTab25.style.position = "absolute";
			document.all.Cersai_det.style.visibility = "hidden";
			document.all.Cersai_det.style.position = "absolute";

		}
		document.all.displayTab23.style.visibility = "hidden";
		document.all.displayTab23.style.position = "absolute";
		}
		if(secCount==1 )
		{

			if (varSecType ==5) {
				
				document.all.displayTab5.style.visibility = "visible";
				document.all.displayTab5.style.position = "relative";
			} else {
				document.all.displayTab5.style.visibility = "hidden";
				document.all.displayTab5.style.position = "absolute";

			}
			if (varSecType ==6) {
				document.all.displayTab6.style.visibility = "visible";
				document.all.displayTab6.style.position = "relative";
			} else {
				document.all.displayTab6.style.visibility = "hidden";
				document.all.displayTab6.style.position = "absolute";

			}
			if (varSecType ==7) {
				document.all.displayTab7.style.visibility = "visible";
				document.all.displayTab7.style.position = "relative";
			} else {
				document.all.displayTab7.style.visibility = "hidden";
				document.all.displayTab7.style.position = "absolute";

			}
			if (varSecType ==8) {
				document.all.displayTab8.style.visibility = "visible";
				document.all.displayTab8.style.position = "relative";
			} else {
				document.all.displayTab8.style.visibility = "hidden";
				document.all.displayTab8.style.position = "absolute";

			}
			if (varSecType ==9) {
				document.all.displayTab9.style.visibility = "visible";
				document.all.displayTab9.style.position = "relative";
			} else {
				document.all.displayTab9.style.visibility = "hidden";
				document.all.displayTab9.style.position = "absolute";

			}
			if (varSecType ==10 || varSecType ==11 || varSecType ==12 || varSecType ==13 || varSecType ==14 || varSecType ==15 || varSecType ==16 || varSecType ==17) {
				document.all.displayTab10.style.visibility = "visible";
				document.all.displayTab10.style.position = "relative";
				document.all.displayTab88.style.visibility = "visible";
				document.all.displayTab88.style.position = "relative";
			} else {
				document.all.displayTab10.style.visibility = "hidden";
				document.all.displayTab10.style.position = "absolute";
				document.all.displayTab88.style.visibility = "hidden";
				document.all.displayTab88.style.position = "absolute";
				

			}
			if (varSecType ==18) {
				document.all.displayTab18.style.visibility = "visible";
				document.all.displayTab18.style.position = "relative";
			} else {
				document.all.displayTab18.style.visibility = "hidden";
				document.all.displayTab18.style.position = "absolute";

			}
			if (varSecType ==19) {
				document.all.displayTab19.style.visibility = "visible";
				document.all.displayTab19.style.position = "relative";
			} else {
				document.all.displayTab19.style.visibility = "hidden";
				document.all.displayTab19.style.position = "absolute";

			}
			if (varSecType ==20) {
				document.all.displayTab20.style.visibility = "visible";
				document.all.displayTab20.style.position = "relative";
			} else {
				document.all.displayTab20.style.visibility = "hidden";
				document.all.displayTab20.style.position = "absolute";

			}
			if (varSecType ==21) {
				document.all.displayTab21.style.visibility = "visible";
				document.all.displayTab21.style.position = "relative";
				document.all.displayTab22.style.visibility = "visible";
				document.all.displayTab22.style.position = "relative";
			} else {
				document.all.displayTab21.style.visibility = "hidden";
				document.all.displayTab21.style.position = "absolute";
				document.all.displayTab22.style.visibility = "hidden";
				document.all.displayTab22.style.position = "absolute";
			}
			if (varSecType ==22) {
				document.all.displayTab24.style.visibility = "visible";
				document.all.displayTab24.style.position = "relative";
			} else {
				document.all.displayTab24.style.visibility = "hidden";
				document.all.displayTab24.style.position = "absolute";

			}
			if (varSecType ==3) {
				document.all.displayTab25.style.visibility = "visible";
				document.all.displayTab25.style.position = "relative";
			} else {
				document.all.displayTab25.style.visibility = "hidden";
				document.all.displayTab25.style.position = "absolute";
				document.all.Cersai_det.style.position = "absolute";

			}
			document.all.displayTab23.style.visibility = "visible";
			document.all.displayTab23.style.position = "relative";
		}

	}
	function callAddJointSecurity() {
		var varAppId=document.forms[0].hidDemoId.value;
		var varQryString = appURL + "action/addjointsecurities.jsp?appid="+varAppId+"&linkFrom=security";
		var title = "ADD";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString, title, prop);

	}

	function showSpecify(flag){
		document.all.idshare.style.display="none";
		if(document.forms[0].sel_securitytype.value ==24)
		{
				/* document.getElementById("specifytype1").style.display="block";
				document.getElementById("specifytype2").style.display="block"; */
			    document.all.specifytype1.style.visibility = "visible";
				document.all.specifytype1.style.position = "relative";
				document.all.specifytype2.style.visibility = "visible";
				document.all.specifytype2.style.position = "relative"; 
				
		} else {
				
			/* document.getElementById("specifytype1").style.display="none";
			document.getElementById("specifytype2").style.display="none"; */
				document.all.specifytype1.style.visibility = "hidden";
				document.all.specifytype1.style.position = "absolute";
				document.all.specifytype2.style.visibility = "hidden";
				document.all.specifytype2.style.position = "absolute";

			}
		
		if(document.forms[0].sel_securitytype.value ==3||document.forms[0].sel_securitytype.value ==4||document.forms[0].sel_securitytype.value ==18||
				document.forms[0].sel_securitytype.value ==19||document.forms[0].sel_securitytype.value ==20)
		{
			 document.all.Cersai_det.style.visibility = "visible";
				document.all.Cersai_det.style.position = "relative";
		}
		else{
			document.all.Cersai_det.style.visibility = "hidden";
			document.all.Cersai_det.style.position = "absolute";
		}
		if(document.forms[0].sel_securitytype.value =="6")
		{
			document.all.idcompanydetails.style.display="table-row";
			document.all.idcompanydetails1.style.display="table-row";
			document.forms[0].sel_alreadycharged.disabled=true;
			document.forms[0].txt_com_cinno.readOnly=true;
			document.forms[0].txt_companyname.readOnly=true;
			document.forms[0].txt_shareval.readOnly=true;
			document.forms[0].txt_total_secval.readOnly=true;
			if(flag=="Y")
			{
				document.forms[0].sel_alreadycharged.value="N";
				document.forms[0].txt_com_cinno.value="";
				document.forms[0].txt_companyname.value="";
				document.forms[0].txt_shareval.value="";
				document.forms[0].hidcompanycode.value="";
				if(document.forms[0].sel_securityclassifcation.value=="40")
				{
					caltotalsecvalue('Y');
				}
				else
				{
					document.forms[0].txt_total_secval.value="";
					document.forms[0].txt_net_security.value="";
					document.forms[0].txt_total_secval.readOnly=false;
				}
			}
			chargedDetails();
			if(document.forms[0].sel_securityclassifcation.value=="40")
			{
				document.all.idshare.style.display="table-cell";
				document.all.no_units.style.visibility = "hidden";
				document.all.no_units.style.position = "absolute";
				document.all.no_shares.style.visibility = "visible";
				document.all.no_shares.style.position = "relative";
			}
			else
			{
				document.all.no_shares.style.visibility = "hidden";
				document.all.no_shares.style.position = "absolute";
				document.all.no_units.style.visibility = "visible";
				document.all.no_units.style.position = "relative";
			}
		}
		else
		{
			document.all.idcompanydetails.style.display="none";
			document.all.idcompanydetails1.style.display="none";
			document.forms[0].sel_alreadycharged.disabled=false;
			document.forms[0].txt_total_secval.readOnly=false;
			document.forms[0].txt_com_cinno.value="";
			document.forms[0].txt_companyname.value="";
			document.forms[0].txt_shareval.value="0.00";
			document.forms[0].txt_noofshares.value="";
			if(flag=="Y")
			{
				document.forms[0].txt_total_secval.value="";
				document.forms[0].txt_net_security.value="";
			}
		}

		if(document.forms[0].cmdsave.disabled==true)
		{
			document.forms[0].sel_alreadycharged.disabled=true;
			
		}
		else
		{
			document.forms[0].txt_Valuers_name.value="";
			document.forms[0].txt_validation_date.value="";
			document.forms[0].txt_dateofsubmissionbybank.value="";
			document.forms[0].txt_dateofreceiptbybank.value="";
			
		}
	}
	function showValuersName()
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength>1)
		{
			return false;
		}
		
			var strAppVar="V";
			var strsecuritytype=document.forms[0].sel_securityclassifcation.value;
			if(strsecuritytype=="0")
			{
					alert("Please select Security Classification");
					document.forms[0].sel_securityclassifcation.focus();
					return false;
			}
			else if(document.forms[0].txt_total_secval.value=="")
			{
					alert("Please Enter Market Value");
					document.forms[0].txt_total_secval.focus();
					return false;
			}
			if(document.forms[0].cmdsave.disabled==false)
			{
				var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
				var url=appURL+"action/valuersname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&hidAction=search&strfrom=Securities&hidAppVal="+strAppVar+"&strsecuritytype="+strsecuritytype+"&strSecValue="+document.forms[0].txt_total_secval.value;
				window.open(url,"",prop);
			}
			
			document.forms[0].txt_Valuers_name.readOnly=true;
	}

	function showMaturDate()
	{
      if(document.forms[0].sel_weathliquid.value=="Y")
      {
        document.all.m1.style.visibility="visible";
        document.all.m1.style.position="relative";
        document.all.m2.style.visibility="visible";
        document.all.m2.style.position="relative";
      }
      else
      {        
    	  document.forms[0].txt_matudateliq.value="";
     	  document.all.m1.style.visibility="hidden";
          document.all.m1.style.position="absolute";
          document.all.m2.style.visibility="hidden";
          document.all.m2.style.position="absolute";
      }
    }
    function callnetsec()
    {
		if(document.forms[0].sel_alreadycharged.value=="Y")
		{
			if(document.forms[0].txt_total_secval.value=="")
			{
				alert("Enter Market Value");
				document.forms[0].txt_charged_to_institution.value="";
				document.forms[0].txt_total_secval.focus();
				return;
			}
			if(eval(document.forms[0].txt_total_secval.value)<eval(document.forms[0].txt_charged_to_institution.value))
			{
				alert("Amount Charged should not exceeds Market Value");
				document.forms[0].txt_charged_to_institution.value="";
				document.forms[0].txt_net_security.value=document.forms[0].txt_total_secval.value;
				document.forms[0].txt_charged_to_institution.focus();
				return;
			}
			
			document.forms[0].txt_net_security.value=NanNumber(parseFloat(document.forms[0].txt_total_secval.value))-NanNumber(parseFloat(document.forms[0].txt_charged_to_institution.value));
		}
		else
		{
			document.forms[0].txt_net_security.value=NanNumber(document.forms[0].txt_total_secval.value);
		}	
		document.forms[0].txt_net_security.value=roundVal(document.forms[0].txt_net_security.value);	
		
    } 
    function checkFromToDate()
    {        
    	if(document.forms[0].txt_collareral_start_date.value!=""&&document.forms[0].txt_collareral_end_date.value!="")
    	{
    		checkmaxdate(document.forms[0].txt_collareral_start_date,document.forms[0].txt_collareral_end_date.value);
    	}     	 
    } 

function cleansecval()
{
	if(document.forms[0].sel_securitytype.value == 1 && document.forms[0].txt_total_secval.value > 0)
	{
		alert("No value can be given for Clean Security");
		document.forms[0].txt_total_secval.value = "0";
		document.forms[0].txt_total_secval.focus();
	}
	var secTypevalue=document.forms[0].sel_securitytype.value;
	if(secTypevalue=="10" || secTypevalue=="11" || secTypevalue=="12" || secTypevalue=="13" || secTypevalue=="14" || secTypevalue=="15" || secTypevalue=="16" || secTypevalue=="17")
	{
		if(document.forms[0].txt_Valuers_name.value!="")
		{
			if(eval(document.forms[0].txt_total_secval.value)>eval(document.forms[0].txt_Valuers_limit.value))
			{
				alert("Attached Valuer Maximum valuation Limit lesser then the security value, Attach another Valuer");
				document.forms[0].sel_currentEmpList.value="";
				document.forms[0].txt_val_catCode.value="";
				document.forms[0].txt_Valuers_name.value="";
				document.forms[0].txt_Valuers_code.value="";
				document.forms[0].txt_Valuers_limit.value="";
				return;
			}
		}
	}
}

function doSecurityOwnershipChange()
{
	if(document.forms[0].hidOwnerChange.value=="Y")
	{
		alert("This Security attached in Pending Proposals ("+document.forms[0].hidOwnerChangeAppno.value+"), You cannot make this change");
		return;
	}
	document.forms[0].hidBeanId.value = "securitymaster";
	document.forms[0].hidBeanGetMethod.value = "getSecurityOwnerChange";
	document.forms[0].action = appURL + "action/setsecurityownerchange.jsp";
	document.forms[0].submit();
}
function caltotalsecvalue(flag)
{
	if(document.forms[0].sel_securityclassifcation.value=="40")
	{
		document.forms[0].txt_total_secval.value=eval(NanNumber(parseFloat(document.forms[0].txt_shareval.value)))*eval(NanNumber(parseFloat(document.forms[0].txt_noofshares.value)));
		document.forms[0].txt_total_secval.value=roundVal(document.forms[0].txt_total_secval.value);
		document.forms[0].txt_net_security.value=document.forms[0].txt_total_secval.value;
		if(flag=="Y")
		captureComments();
	}
}
function showShareValue()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/setShareValueMasterSearch.jsp?pagefrom=securitymaster&SecType="+document.forms[0].sel_securityclassifcation.value;
		var title = "Users";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}

function showsecAttached(val1)
{
	var prop = "scrollbars=yes,width=950,height=500,top=100,left=250";
	var url = appURL+"action/sec_attachedtoproposal.jsp?hidBeanGetMethod=getSecAttachedData&hidBeanId=securitymaster&SecId="+val1;
	window.open(url,"",prop);
	
}
function showsecModified(val1)
{
	var prop = "scrollbars=yes,width=950,height=500,top=100,left=250";
	var url = appURL+"action/sec_modification_his.jsp?hidBeanGetMethod=getSecModifiedHisData&hidBeanId=securitymaster&SecId="+val1;
	window.open(url,"",prop);
	
}
function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=sec&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}

function Addvaluer()
{
	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
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
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="textarea")
				{
					new_RowCell.childNodes[j].value="";		  
					new_RowCell.childNodes[j].disabled=false;
				}
				if(new_RowCell.childNodes[j].type=="select-one")
				{
					new_RowCell.childNodes[j].value="N";
					if(document.forms[0].sel_approveFlag_mul[rowsLength-1].value=="Y")
					{
						new_RowCell.childNodes[j].disabled=true;		
					}
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

function valuerlistDisp(valuerVal)
{
	 var temp=valuerVal.split("@");
	 var valuerlen=temp.length
	 document.all.ValuerDetails1.style.visibility="visible";
     document.all.ValuerDetails1.style.position="relative"; 
     document.all.ValuerDetails2.style.visibility="visible";
     document.all.ValuerDetails2.style.position="relative"; 
     
     for(var i=0;i<(valuerlen)-1;i++)
     {
    	 Addvaluer();
    	 if(valuerlen==2)
    	 {
    		 var valtemp=temp[i].split(",");
    		 document.forms[0].txt_Valuers_name_mul[i].value=valtemp[2] ;
        	 document.forms[0].txt_validation_date_mul[i].value = valtemp[5];
      		 document.forms[0].txt_dateofsubmissionbybank_mul[i].value= valtemp[3];
     		 document.forms[0].txt_dateofreceiptbybank_mul[i].value=valtemp[4];
     		 document.forms[0].txt_net_security_mul[i].value=valtemp[6] ;	
     		 document.forms[0].sel_approveFlag_mul[i].value=valtemp[7];	
     		 document.forms[0].txt_Valuers_code_mul[i].value=valtemp[8];
     		 document.forms[0].txt_Valuers_catcode_mul[i].value=valtemp[9];
     		 document.forms[0].txt_Valuers_limit_mul[i].value=valtemp[10];
     		 document.forms[0].txt_Valuationloc_mul[i].value=valtemp[11].replace("$","@");	
    	 }
    	 else
    	 {
    		 var valtemp=temp[i].split(",");
    		 document.forms[0].txt_Valuers_name_mul[i].value=valtemp[2] ;
        	 document.forms[0].txt_validation_date_mul[i].value = valtemp[3];
      		 document.forms[0].txt_dateofsubmissionbybank_mul[i].value= valtemp[4];
     		 document.forms[0].txt_dateofreceiptbybank_mul[i].value=valtemp[5];
     		 document.forms[0].txt_net_security_mul[i].value=valtemp[6] ;	
     		 document.forms[0].sel_approveFlag_mul[i].value=valtemp[7];	
     		 document.forms[0].txt_Valuers_code_mul[i].value=valtemp[8];
     		 document.forms[0].txt_Valuers_catcode_mul[i].value=valtemp[9];
     		 document.forms[0].txt_Valuers_limit_mul[i].value=valtemp[10];
     		 document.forms[0].txt_Valuationloc_mul[i].value=valtemp[11].replace("$","@");
     		 
    	 }
     }
	
     deleteRow("tabid_valuerlist");
}


function deleteRow(tableid)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var table=document.getElementById(tableid);
		var rowCount=table.rows.length; 
		
		if(rowCount==1){
	       alert("Atleast one data is needed");
	       return;
		}
		else{
			 table.deleteRow(rowCount-1);
		}
	}
}

function CallvaluerCheck()
{
	var netSecuritVal=parseFloat(document.forms[0].txt_net_security.value);
	var secTypevalue=document.forms[0].sel_securitytype.value;
	if(secTypevalue=="10" || secTypevalue=="11" || secTypevalue=="12" || secTypevalue=="13" || secTypevalue=="14" || secTypevalue=="15" || secTypevalue=="16" || secTypevalue=="17")
	{
		 if(eval(netSecuritVal) > eval("100000000"))
		 {
				if(document.forms[0].txt_Valuers_name.value=="")
				{
					ShowAlert('111', "Valuer Name");
					//document.forms[0].txt_Valuers_name.focus();
					//document.forms[0].txt_total_secval.value="";
					//document.forms[0].txt_net_security.value="";
					return;
				}
				if(document.forms[0].txt_Valuers_name.value!="")
				{
					if (document.forms[0].txt_validation_date.value == "") 
					{
						ShowAlert('121', "Valuation Date (as per Report)");
						document.forms[0].txt_validation_date.focus();
						document.forms[0].txt_net_security.value="";
						document.forms[0].txt_total_secval.value="";
						return;
					}
					if(document.forms[0].txt_dateofsubmissionbybank.value=="")
					{
						ShowAlert('121',"Date of submission of request for valuation by bank");
						document.forms[0].txt_dateofsubmissionbybank.focus();
						document.forms[0].txt_net_security.value="";
						document.forms[0].txt_total_secval.value="";
						return false;
					}
					if(document.forms[0].txt_dateofreceiptbybank.value=="")
					{
						ShowAlert('121',"Date of receipt of valuation report by bank");
						document.forms[0].txt_dateofreceiptbybank.focus();
						document.forms[0].txt_net_security.value="";
						document.forms[0].txt_total_secval.value="";
						return false;
					}
				}
	
			 document.all.ValuerDetails1.style.visibility="visible";
		     document.all.ValuerDetails1.style.position="relative"; 
		     document.all.ValuerDetails2.style.visibility="visible";
		     document.all.ValuerDetails2.style.position="relative"; 
		     
		     document.forms[0].txt_Valuers_name_mul.value= document.forms[0].txt_Valuers_name.value;
		     document.forms[0].txt_Valuers_code_mul.value= document.forms[0].txt_Valuers_code.value;
	    	 document.forms[0].txt_validation_date_mul.value =document.forms[0].txt_validation_date.value;
	  		 document.forms[0].txt_dateofsubmissionbybank_mul.value= document.forms[0].txt_dateofsubmissionbybank.value;
	 		 document.forms[0].txt_dateofreceiptbybank_mul.value= document.forms[0].txt_dateofreceiptbybank.value;
	 		 document.forms[0].txt_net_security_mul.value=document.forms[0].txt_net_security.value;
	 		 document.forms[0].txt_Valuers_catcode_mul.value=document.forms[0].txt_val_catCode.value;
	 		 document.forms[0].txt_Valuers_limit_mul.value=document.forms[0].txt_Valuers_limit.value;
	 		document.forms[0].txt_Valuationloc_mul.value=document.forms[0].hidvaluationarea.value;
	
	  		 document.forms[0].txt_Valuers_name_mul.disabled=true;
	   	 	 document.forms[0].txt_validation_date_mul.disabled=true;
	 		 document.forms[0].txt_dateofsubmissionbybank_mul.disabled=true;
			 document.forms[0].txt_dateofreceiptbybank_mul.disabled=true;
			 document.forms[0].txt_net_security_mul.disabled=true;
			 document.forms[0].sel_approveFlag_mul.disabled=false;
			 
			  document.forms[0].txt_dateofsubmissionbybank.readOnly=true;
			 document.forms[0].txt_dateofreceiptbybank.readOnly=true;
			 document.forms[0].txt_validation_date.readOnly=true;
			 document.forms[0].txt_total_secval.readOnly=true;
					 
		 }
		 else
		 {
			 if(document.forms[0].hid_ValuerListDisp_temp.value=="N")
			 {
			 	clearrows("tabid_valuerlist");	 
			 	document.forms[0].txt_Valuers_name_mul.value="" ;
	    	 	document.forms[0].txt_validation_date_mul.value = "";
	  			document.forms[0].txt_dateofsubmissionbybank_mul.value= "";
	 			document.forms[0].txt_dateofreceiptbybank_mul.value= "";
	 			document.forms[0].txt_net_security_mul.value= "";
				document.all.ValuerDetails1.style.visibility="hidden";
			    document.all.ValuerDetails1.style.position="relative";
			    document.all.ValuerDetails2.style.visibility="hidden";
			    document.all.ValuerDetails2.style.position="relative"; 
			 }
		 }
	}	 
}

function showValuersName_mul(rowindex)
{
	if(rowindex=="0")
	{
		return false;
	}
	if(document.forms[0].txt_Valuers_name_mul[rowindex].disabled == true)
	{
		return false;
	}
	
	
		var strAppVar="V";
		var strsecuritytype=document.forms[0].sel_securityclassifcation.value;
		if(strsecuritytype=="0")
		{
				alert("Please select Security Classification");
				document.forms[0].sel_securityclassifcation.focus();
				return false;
		}
		else if(document.forms[0].txt_net_security_mul[rowindex].value=="")
		{
				alert("Please Enter Market Value");
				document.forms[0].txt_net_security_mul[rowindex].focus();
				return false;
		}

		var tab  = document.getElementById("tabid_valuerlist");
		var rowsLength = tab.rows.length;
		var valuernametemp="";
		if(rowsLength>0)
		{
			for(var i=0;i<rowsLength;i++)
			{
					valuernametemp=valuernametemp+document.forms[0].txt_Valuers_name_mul[i].value+"@";
			}	
		}
		else
		{
			valuernametemp=document.forms[0].txt_Valuers_name_mul.value;
		}
		if(document.forms[0].cmdsave.disabled==false)
		{
			var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
			var url=appURL+"action/valuersname.jsp?hidBeanId=staticdata&hidBeanGetMethod=getValuerMasterList&hidAction=search&strfrom=Securities&hidAppVal="+strAppVar+"&strsecuritytype="+strsecuritytype+"&rowcount="+(rowsLength)+"&rowindex="+(rowindex)+"&fieldtype=valuerlist&strSecValue="+document.forms[0].txt_net_security_mul[rowindex].value+"&valuernametemp="+valuernametemp;
			window.open(url,"",prop);
		}
		document.forms[0].txt_Valuers_name.readOnly=true;
}

function changeApprove(rowindex)
{
	var tab  = document.getElementById("tabid_valuerlist");
	var  rowsLength= tab.rows.length;
	if(document.forms[0].sel_alreadycharged.value=='N')
	{
		if(rowsLength<2)
		{
			if(document.forms[0].txt_Valuers_code.value!="601")
			{
				alert("Please add one more Valuer");
				document.forms[0].sel_approveFlag_mul.value="Y";
				return false;
			}
		}
	}
	if(document.forms[0].sel_alreadycharged.value=='Y' && rowsLength=="1")
	{
		return false;
	}
	if(document.forms[0].sel_approveFlag_mul[rowindex].value=="Y")
	{
		var temp="N";
		if(document.forms[0].txt_Valuers_name_mul[rowindex].value=="")
		{
			alert("Select Valuer");
			document.forms[0].sel_approveFlag_mul[rowindex].value="N";
			return false;
		}
		if(document.forms[0].txt_dateofsubmissionbybank_mul[rowindex].value=="")
		{
			alert("Enter Valuation Submission Date");
			document.forms[0].sel_approveFlag_mul[rowindex].value="N";
			return false;
		}
		if(document.forms[0].txt_validation_date_mul[rowindex].value=="")
		{
			alert("Enter Valuation Date ");
			document.forms[0].sel_approveFlag_mul[rowindex].value="N";
			return false;
		}
		if(document.forms[0].txt_dateofreceiptbybank_mul[rowindex].value=="")
		{
			alert("Enter Receipt Date");
			document.forms[0].sel_approveFlag_mul[rowindex].value="N";
			return false;
		}
		if(document.forms[0].txt_net_security_mul[rowindex].value=="")
		{
			alert("Enter Security Value");
			document.forms[0].sel_approveFlag_mul[rowindex].value="N";
			return false;
		}

		for(var j=0;j<rowsLength;j++)
		{
			if((rowindex)!=j)
				document.forms[0].sel_approveFlag_mul[j].disabled=true;

			document.forms[0].txt_Valuers_name_mul[j].disabled=true;
			document.forms[0].txt_Valuers_code_mul[j].readOnly=true;
			document.forms[0].txt_validation_date_mul[j].disabled=true;
			document.forms[0].txt_dateofsubmissionbybank_mul[j].disabled=true;
			document.forms[0].txt_dateofreceiptbybank_mul[j].disabled=true;
			document.forms[0].txt_net_security_mul[j].disabled=true;
		}
		
		document.forms[0].txt_Valuers_name.value = document.forms[0].txt_Valuers_name_mul[rowindex].value; 
		document.forms[0].txt_Valuers_code.value = document.forms[0].txt_Valuers_code_mul[rowindex].value; 
		document.forms[0].txt_validation_date.value = document.forms[0].txt_validation_date_mul[rowindex].value;
		document.forms[0].txt_dateofsubmissionbybank.value = document.forms[0].txt_dateofsubmissionbybank_mul[rowindex].value; 
		document.forms[0].txt_dateofreceiptbybank.value = document.forms[0].txt_dateofreceiptbybank_mul[rowindex].value;
		document.forms[0].txt_total_secval.value = document.forms[0].txt_net_security_mul[rowindex].value;
		document.forms[0].txt_Valuers_limit.value = document.forms[0].txt_Valuers_limit_mul[rowindex].value;
		document.forms[0].hidvaluationarea.value = document.forms[0].txt_Valuationloc_mul[rowindex].value;
		document.forms[0].txt_val_catCode.value = document.forms[0].txt_Valuers_catcode_mul[rowindex].value;
		document.forms[0].txt_net_security.value=NanNumber(parseFloat(document.forms[0].txt_total_secval.value))-NanNumber(parseFloat(document.forms[0].txt_charged_to_institution.value));
		document.forms[0].txt_total_secval.focus();
		document.forms[0].hid_ValuerListDisp_temp.value="Y";
	}
	else
	{
		var tab  = document.getElementById("tabid_valuerlist");
		var  rowsLength= tab.rows.length;
		for(var j=0;j<rowsLength;j++)
		{
			if((rowindex)!=j)
			{
				document.forms[0].sel_approveFlag_mul[j].disabled=false;
			}
			
			document.forms[0].txt_Valuers_name_mul[j].disabled=false;
			document.forms[0].txt_Valuers_code_mul[j].readOnly=false;
			document.forms[0].txt_validation_date_mul[j].disabled=false;
			document.forms[0].txt_dateofsubmissionbybank_mul[j].disabled=false;
			document.forms[0].txt_dateofreceiptbybank_mul[j].disabled=false;
			document.forms[0].txt_net_security_mul[j].disabled=false;
			
		}
	}
}
function disableValuerDetails()
{
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	if(rowsLength>1)
	{
		for(var i=0;i<rowsLength;i++)
		{	
			document.forms[0].txt_Valuers_name_mul[i].disabled=false;
			document.forms[0].txt_validation_date_mul[i].disabled=false;
			document.forms[0].txt_dateofsubmissionbybank_mul[i].disabled=false; 
			document.forms[0].txt_dateofreceiptbybank_mul[i].disabled=false;
			document.forms[0].txt_net_security_mul[i].disabled=false;
			document.forms[0].sel_approveFlag_mul[i].disabled=false;
		}
	}
	else
	{
		document.forms[0].txt_Valuers_name_mul.disabled=false;
		document.forms[0].txt_validation_date_mul.disabled=false;
		document.forms[0].txt_dateofsubmissionbybank_mul.disabled=false; 
		document.forms[0].txt_dateofreceiptbybank_mul.disabled=false;
		document.forms[0].txt_net_security_mul.disabled=false;
		document.forms[0].sel_approveFlag_mul.disabled=false;
	}
}
function checkmaxdate_mul(objdate,name,rowindex)
{
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	var temp="";
	if(rowsLength>1)
	{
		if(name=="txt_validation_date_mul")
		{
			temp=document.forms[0].txt_validation_date_mul[rowindex].value;
		}
	}
	else
	{
		temp=document.forms[0].txt_validation_date_mul.value;
	}
	
	checkmaxdate(objdate,temp);
}

function checkmindate_mul(objdate,name,rowindex)
{
	var tab  = document.getElementById("tabid_valuerlist");
	var rowsLength = tab.rows.length;
	var temp="";
	if(rowsLength>1)
	{
		if(name=="txt_dateofsubmissionbybank_mul")
		{
			temp=document.forms[0].txt_dateofsubmissionbybank_mul[rowindex].value;
		}
	}
	else
	{
		temp=document.forms[0].txt_dateofsubmissionbybank_mul.value;
	}
	
	checkmindate(objdate,temp);
}

function AddvaluerCrop(){

	if(document.forms[0].cmdedit.disabled==true)
	{	
	var tab  = document.getElementById("tabid_Cropvaluerlist");
	var rowsLength = tab.rows.length;
	if(rowsLength<=200)
	{
		var new_Row    = tab.insertRow(rowsLength);
		
		var rwlength=rowsLength;
		new_Row.id=""+rowsLength;
		var previous_RowCells=tab.rows[rowsLength-1].cells; 
		for(i=0;i<previous_RowCells.length;i++)
		{
			var new_RowCell=new_Row.insertCell(i);
			new_RowCell.innerHTML=previous_RowCells[i].innerHTML;
			new_RowCell.align="center";
			new_RowCell.className="datagrid";
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
}

function deleteRowCrop(tabid,tdcount)
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var tab = document.getElementById(tabid);
		var rowsLength = tab.rows.length;
		var varCheckedFlag=false;
		if(rowsLength>=1)
		{
			for(var i=0;i<rowsLength;i++)
			{
				var current_row = tab.rows[i];
				var chkbox = current_row.cells[tdcount].childNodes[0];
				if(chkbox != null && chkbox.checked == true)
				{
					 if(tabid=="tabid_Cropvaluerlist" && rowsLength=="1")
					{
						document.forms[0].txt_cersai_Crop_id.value="";  
						document.forms[0].txt_Cersai_Crop_Date.value="";  
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
				alert("Please select the check box for deletion");
			}
		}
	}
}

function Totalvalue(id,dat)
{
	var a="";
	var b="";
	var varCersaiCropID=id;
	var varCersaiCropDate=dat;
	document.forms[0].cmdedit.disabled=true;
	if(varCersaiCropID!="")
	{
		var temp_ID=varCersaiCropID.split("@");
		var temp_Date=varCersaiCropDate.split("@");
		var valuerlen=temp_ID.length;
		for(var i=0;i<valuerlen;i++)
		{
			AddvaluerCrop();
			 if(temp_ID[i]==undefined){temp_ID[i]="";}
			 if(temp_Date[i]==undefined){temp_Date[i]="";}
			 if(valuerlen==1)
			 {
				 document.forms[0].txt_cersai_Crop_id[i].value =temp_ID[i];
				 document.forms[0].txt_Cersai_Crop_Date[i].value = temp_Date[i];
		    	 
			 }else
			 {
				 document.forms[0].txt_cersai_Crop_id[i].value =temp_ID[i];
				 document.forms[0].txt_Cersai_Crop_Date[i].value = temp_Date[i];
		    }
		 }
	}
	
	else
	{
		AddvaluerCrop();
	}
deleteRow("tabid_Cropvaluerlist");
document.forms[0].cmdedit.disabled=false;
}

function cropCerial(){
	 var position=document.forms[0].sel_securitytype.value;
	 if(position=="22"){
		document.all.idtxtcersialcrop.style.visibility="visible";
		document.all.idtxtcersialcrop.style.position="relative";
		document.all.tabid_Cropvaluerlist.style.visibility="visible";
		document.all.tabid_Cropvaluerlist.style.position="relative";
	 }
	 else{
		document.all.idtxtcersialcrop.style.visibility="hidden";
		document.all.idtxtcersialcrop.style.position="absolute";
		document.all.tabid_Cropvaluerlist.style.visibility="hidden";
		document.all.tabid_Cropvaluerlist.style.position="absolute";
	 }
}

function callCalender_mul_Ec(name,rowindex) 
{
	if(rowindex=="0")
	{
		var tab  = document.getElementById("tabid_Cropvaluerlist");
		var rowsLength = tab.rows.length;
		if(rowsLength==1)
		{
			if (document.forms[0].cmdsave.disabled == false) 
			{
				showCal(appURL, name);
			}
		}
		else
		{
			name=name+"["+(rowindex)+"]";
			if (document.forms[0].cmdsave.disabled == false) 
			{

				showCal(appURL, name);
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}

function cerDuplicateCheck(val,rowindex,name){
	var varIndex=0;
	var cersailIDCorp1=val.value;
	var SecurityId=document.forms[0].hidSecurityId.value;
	
	if(rowindex=="0")
	{
		if(name=="txt_cersai_id")
		{
			//doNothing
		}
		else
		{
			var tab  = document.getElementById("tabid_Cropvaluerlist");
			var rowsLength = tab.rows.length;
			if(rowsLength==1)
			{
				name=name;
			}
			else
			{
				name=name+"["+(rowindex)+"]";
			}
		}
	}
	else
	{
		name=name+"["+(rowindex)+"]";
	}
	 var varcersaiid=document.forms[0].txt_cersai_id.value;
		if(varcersaiid.length==12)
		{
	document.all.ifrmcersaiIDcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strcersailIDCorp="+cersailIDCorp1
	+ "&strrowindexname="+name+"&strSecurityId="+SecurityId;
		}
}
function funPropDet()
{
	var varQryString = appURL + "action/cus_sec_propDet.jsp?strDistCode="+document.forms[0].hid_District.value+"&strDistDesc="+document.forms[0].txt_District.value+"&strCityCode="+document.forms[0].hidcity.value+"&strCityDesc="+document.forms[0].txt_City.value+"&strStateCode="+document.forms[0].hidstate.value+"&strStateDesc="+document.forms[0].txt_State.value;
	var title = "ADD";
	var prop = "scrollbars=yes,width=650,height=200,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
}
function govtValuerCheck(){
	
	var valuerCode=document.forms[0].txt_Valuers_code.value;
	if(valuerCode=="2122"){
		document.all.govt_name.style.visibility="visible";
		document.all.govt_name.style.position="relative";
	}else{
		document.all.govt_name.style.visibility="hidden";
		document.all.govt_name.style.position="absolute";
	}
}
function callMinVAl()
{
	var varcersaiid=document.forms[0].txt_cersai_id.value;
	 if(varcersaiid.length!=12 && varcersaiid.length>0){

		alert("Please Enter 12 - Digit Valid CERSAI ASSET Id");
		document.forms[0].txt_cersai_id.value="";
		return;
	}
}
function fsvamtchk()
{
	var fsv = document.forms[0].txt_ForcedSale.value;
	var value_as_per  = document.forms[0].txt_Valuation.value;
	if(parseFloat(fsv)>0 && parseFloat(value_as_per)>0)
		{
	if(parseFloat(fsv)>=parseFloat(value_as_per))
		{
		alert("Amount entered in Forced sale value should always be less than Value as per valuation ");
	     document.forms[0].txt_ForcedSale.value="";
	     return;
	     
		}
		}
}
function chkleasehold()
{
	if(document.forms[0].sel_property.value=="Y")
		{
		document.all.idlessor1.style.visibility="visible";
		document.all.idlessor1.style.position="relative";
		
		document.all.idlessor2.style.visibility="visible";
		document.all.idlessor2.style.position="relative";
		}
	else
		{
		document.forms[0].sel_lessor.value="";
		document.all.idlessor1.style.visibility="hidden";
		document.all.idlessor1.style.position="absolute";
		
		document.all.idlessor2.style.visibility="hidden";
		document.all.idlessor2.style.position="absolute";
		}
}
function newcheck()
{
	if(document.forms[0].sel_property.value=="Y")
		{
		if(document.forms[0].sel_securitytype.value=="15"&& document.forms[0].hid_value_as_per_valuation.value!="")
			{
			if(parseFloat(document.forms[0].txt_total_secval.value)!=parseFloat(document.forms[0].hid_value_as_per_valuation.value))
				{
				 alert("Amount entered does not tally the  amount entered in Property Details  'Value as per valuation - "+document.forms[0].hid_value_as_per_valuation.value);
				 document.forms[0].txt_total_secval.value="";
				 return;
				}
			}
		else if((document.forms[0].sel_securitytype.value=="10"||document.forms[0].sel_securitytype.value=="11"||document.forms[0].sel_securitytype.value=="12"
			||document.forms[0].sel_securitytype.value=="13"||document.forms[0].sel_securitytype.value=="14"||document.forms[0].sel_securitytype.value=="16"
				||document.forms[0].sel_securitytype.value=="17")&&document.forms[0].hid_value_as_per_valuation.value!="")
			{
			if(parseFloat(document.forms[0].txt_total_secval.value)!=parseFloat(document.forms[0].hid_value_as_per_valuation.value))
			{
			 alert("Amount entered does not tally the  amount entered in Property Details  'Value as per valuation- "+document.forms[0].hid_value_as_per_valuation.value);
			 document.forms[0].txt_total_secval.value="";
			 return;
			}
			}
		}
	else if(document.forms[0].sel_property.value=="N")
		{
		
		if((document.forms[0].sel_securitytype.value=="10"||document.forms[0].sel_securitytype.value=="11"||document.forms[0].sel_securitytype.value=="12"
			||document.forms[0].sel_securitytype.value=="13"||document.forms[0].sel_securitytype.value=="14"||document.forms[0].sel_securitytype.value=="16"
				||document.forms[0].sel_securitytype.value=="17")&&document.forms[0].hid_value_as_per_valuation.value!="")
			{
			if(parseFloat(document.forms[0].txt_total_secval.value)!=parseFloat(document.forms[0].hid_value_as_per_valuation.value))
			{
			 alert("Amount entered does not tally the  amount entered in Property Details  'Value as per valuation- "+document.forms[0].hid_value_as_per_valuation.value);
			 document.forms[0].txt_total_secval.value="";
			 return;
			}
			}
		else if(document.forms[0].sel_securitytype.value=="15"&& document.forms[0].hid_fsv_val.value!="")
			{
			if(parseFloat(document.forms[0].txt_total_secval.value)!=parseFloat(document.forms[0].hid_fsv_val.value))
				{
				 alert("Amount entered does not tally the  amount entered in Property Details  'Forced sale value - "+document.forms[0].hid_fsv_val.value);
				 document.forms[0].txt_total_secval.value="";
				 return;
				}
			}
		}
	}
</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onLoad()" style="overflow-y: scroll; overflow-x: hidden">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>
<form name="colForm" method="post" class="normal"><jsp:include
	page="../share/help.jsp" flush="true"/>

<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table> 
<table width="98%" border="0" cellspacing="1" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td class="page_flow" align="left">Home -&gt; Securities -&gt; Security Details</td>
	</tr>
	</table> 
<table width="40%" border="0" cellspacing="1" cellpadding="0"
	class="outertable" >
	<tr>
	<td nowrap="nowrap" class="sub_tab_active" align="center"><b>Security Details</b></td>
	<td id="displayTab5"  nowrap="nowrap" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getFinDocNonTradeable','setFinDocNonTradeable.jsp')">Financial Documents-Non Tradeable or Non Transferable</a></b></td>
	<td id="displayTab6"  nowrap="nowrap" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getFinDocTradeable','setFinDocTradeable.jsp')">Financial Documents- Tradeable or Transferable</a></b></td>
					
					<td id="displayTab7" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getSecurityBankDeposit','securitiesBankDeposits.jsp')">Bank Deposits</a></b></td>
					
					<td  id="displayTab8" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getJewelDetail','securitiesJewelDetail.jsp')">Jewel Details</a></b></td>
					
					<td  id="displayTab9" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getTitleGoods','securitiesTitleGoods.jsp')">Title to Goods</a></b></td>
					
					<td  id="displayTab10" width="8%" nowrap="nowrap" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getPropertyDetData','sec_propertydet.jsp')">Property Details</a></b></td>
					
					<td id="displayTab88" class="sub_tab_inactive_new">
	<b ><a href="JavaScript:gototab('securitymaster','getLegalOpinion','sec_property_legalopinion.jsp')">Legal Opinion</a></b></td>
					
					<td  id="displayTab18" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getSecurityVehicle','securitiesVehicle.jsp')">Vehicle</a></b></td>
					
					<td  id="displayTab19" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getPlantMachinery','securitiesPlantMachinery.jsp')">Plant & Machinery</a></b></td>
					<td  id="displayTab20" class="sub_tab_inactive_new"><b><a
					href="JavaScript:gototab('securitymaster','getFurnitures','securitiesFurnitureFixture.jsp')">Furniture & Fixtures</a></b></td>
					<td  id="displayTab21" class="sub_tab_inactive_new"><b><a 
					href="JavaScript:gototab('securitymaster','getLiveStock','securitiesLiveStock.jsp')">Live Stock Details</a></b></td>
					<td  id="displayTab22" class="sub_tab_inactive_new"><b><a 
					href="JavaScript:gototab('securitymaster','getLiveStockDet','securitiesLiveStock_det.jsp')">Details of Particulars</a></b></td>
					<td id="displayTab24" class="sub_tab_inactive_new"><b ><a 
					href="JavaScript:gototab('securitymaster','getSecurityCrop','securitiesCrop.jsp')">CROP</a></b></td>
					<td  id="displayTab25" class="sub_tab_inactive_new"><b ><a
					href="JavaScript:gototab('securitymaster','getSecurityStock','securitiesStock.jsp')">Stock</a></b></td>	
					<td  id="displayTab23">&nbsp;</td>				
	</tr>
	<!--<jsp:include page="../per/applicanttab.jsp" flush="true"> 
             			<jsp:param name="linkid" value="222" />
                        </jsp:include>-->
     
</table>
<table width="98%" border="0" cellpadding="3" cellspacing="1" class="outertable" align="center" style="border: 1px solid #bbb;">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="3" cellpadding="3"	align="center" class="outertable">
		<tr>
		    <td width="20%">Security Type <span class="mantatory">*&nbsp;</span></td>
						
            <td width="30%"> 
              <select name="sel_securitytype"size="1"
							onChange="callSecurityType();showSpecify('Y');cropCerial();" tabindex="1">
							<option value="0">&lt;--Select--&gt;</option>
                    <%
                    	String parenttype = "0";
                    %>
                    <lapschoice:staticdatasecuritiestag parenttype='<%=parenttype%>' />
						</select></td>
			
		    <td width="20%">Already charged to other Banks/FIs <span class="mantatory">*&nbsp;</span></td>						
            <td width="30%"> 
              <select name="sel_alreadycharged" onChange="chargedDetails();callnetsec();" tabindex="10">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
							
		</tr>
		<tr>
		
		 <td id="specifytype1">Specify (Other Security Type)<span class="mantatory">*&nbsp;</span></td>						
            <td id="specifytype2"> 
              <input type="text" name="txt_security_type_specify" size="30" maxlength="29"
						value='' tabindex="2"></td>
						
		</tr>
		<tr>	       
             <td id="instname">Name of the institution</td>						
            <td id="instname1"> 
              <input type="text" name="txt_name_institution" size="30" maxlength="29"
		value='' tabindex="12">
		<input type="hidden" name="hid_LeadBankcode" value="">
				<a href="#" onClick="callBankmaster('147')" style="cursor: hand">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
				</a>
		</td>
			 <td id="amtcharged">Amount Charged to other institution <b>(<%=ApplicationParams.getCurrency()%>)</b></td>						
            <td id="amtcharged1">
              <input type="text" name="txt_charged_to_institution" size="12" maxlength="15"
		value='' onKeyPress="allowNumber(document.forms[0].txt_charged_to_institution)" onBlur="roundtxt(document.forms[0].txt_charged_to_institution);callnetsec();captureComments()" tabindex="13" style="text-align:right"></td>
		   
			
		</tr>
		
		
		<tr>
		    <td>Security Classification <span class="mantatory">*&nbsp;</span></td>
						
            <td> 
            <table width="100%" border="0" cellspacing="3" cellpadding="3"	align="center" class="outertable">
            <tr><td>
               <select name="sel_securityclassifcation" size="1" tabindex="3" onchange="showSpecify('Y');">
                      <option selected value="0">--Select--</option>
                    </select>
                    </td>
                    <td id="idshare"><select name="sel_type">
                    <option value=""><--Select--></option>
                    <option value="P">Physical Form</option>
                    <option value="D">Demat Form</option>
                    </select></td>
                    </tr>
                    </table>
             </td>
             
						
		</tr>	
		<tr>
			 <td>Property Leasehold <span class="mantatory">*&nbsp;</span></td>						
            <td> 
              <select name="sel_property" tabindex="21" onchange="chkleasehold();">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
		<td id="idlessor1" style="visibility:hidden;position:absolute">Lessor <span class="mantatory">*&nbsp;</span></td>
						
				 <td id="idlessor2" style="visibility:hidden;position:absolute"><select name="sel_lessor">
                    <option value=""><--Select--></option>
                    <option value="1">State Government</option>
                    <option value="2">Central Government</option>
                    <option value="3">Authority constituted under special Act</option>
                    </select></td>		
		</tr>
		<tr id="idcompanydetails">
		
		 <td>CIN No&nbsp;<span class="mantatory">*&nbsp;</span></td>						
            <td> 
              <input type="text" name="txt_com_cinno" size="30" maxlength="29"
						value=''>&nbsp;<b><span onClick="showShareValue();" style="cursor: hand"><font
													size="1" face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span></b></td>
						
			       
             <td>Name of the Company</td>						
            <td> 
              <input type="text" name="txt_companyname" size="30"
		value='' tabindex="12"><input type="hidden" name="hidcompanycode"></td>
		   
			
		</tr>
		<tr id="idcompanydetails1">
		
		<td>Share Value</td>
		<td> 
              <input type="text" name="txt_shareval" size="10" maxlength="5"  
						value='' onblur="caltotalsecvalue('Y');" style="text-align: right;"></td>
						
		 <td id="no_shares">Number of Shares&nbsp;<span class="mantatory">*&nbsp;</span></td>
		 <td id="no_units">Number of Units&nbsp;<span class="mantatory">*&nbsp;</span></td>						
            <td> 
              <input type="text" name="txt_noofshares" size="10" maxlength="10" onkeypress="allowNumber(this);" 
						value=''  onblur="caltotalsecvalue('Y');"></td>
		</tr>	
		<tr>
		<td>Specify (Other Security Classification) </td>						
            <td> 
              <input type="text" name="txt_security_clasicification_specify" size="30" maxlength="29"
		value='' tabindex="4"></td>
		
		<td>Valuer Name</td>
						<td><input type="text" name="txt_Valuers_name" size="30" maxlength="29"
													value="" onKeyPress="notAllowSplChar()" onblur="captureComments();CallvaluerCheck();govtValuerCheck();" tabindex="14">
													<input type="hidden" name="txt_Valuers_code">
												<b><span onClick="showValuersName();" style="cursor: hand"><font
													size="1" face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span></b>&nbsp;</td>
		</tr>
		<tr id="govt_name">
		<td>Specify the Name(GOVT VALUER) </td>						
            <td> 
              <input type="text" name="txt_gvtscheme_name" size="30" maxlength="29"
		value='' onKeyPress="notAllowSplChar()" ></td>
		</tr>
		<tr>
			<td>Valuer's Category Code </td>
			<td> <input name="txt_val_catCode"  readonly="readonly"> </td>
			<td> Whether valuer currently in Empanelment list </td>
			<td> 
				<select name="sel_currentEmpList" disabled="disabled">
					<option value="0" selected>---Select---</option>
					<option value="1">Yes</option>
					<option value="2">No</option>
				 </select>
			 </td>
		</tr>
		
		<tr>
			<td>Nature of Charge<span class="mantatory">*&nbsp;</span></td>
			<td> 
              <select name="sel_natureCharge" tabindex="" >
				<option value="0" selected>---Select---</option>
                <lapschoice:StaticDataNewTag apptype="134"  /> 
			 </select>
			</td>
			<td colspan="2">&nbsp;</td>
		</tr>
		
		<tr>
			<td>Security interest ID with ROC </td>
			<td><input type="text" name="txt_secintID_roc" size="30" maxlength="29" ></td>
			<td> Charge ID with ROC  </td>
			<td><input type="text" name="txt_charid_roc" size="30" maxlength="29" ></td>
		</tr>
		<tr>
                   <td>Date of submission of request for valuation by bank <span class="mantatory">*&nbsp;</span></td>
                   <td><input type="text" name="txt_dateofsubmissionbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legsubmitteddate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmaxdate(this,document.forms[0].txt_validation_date.value);checkmaxdate(this,document.forms[0].txt_dateofreceiptbybank.value);CallvaluerCheck();" maxlength="10" tabindex="15">
		    <a alt="Select date from calender"
							onClick="callCalender('txt_dateofsubmissionbybank')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
                   <td>Date of receipt of valuation report by bank <span class="mantatory">*&nbsp;</span></td>
                   <td><input type="text" name="txt_dateofreceiptbybank" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legrecvdate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].txt_dateofsubmissionbybank.value);CallvaluerCheck();" maxlength="10" tabindex="15">
		    <a alt="Select date from calender"
							onClick="callCalender('txt_dateofreceiptbybank')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
                  </tr>
		
		<tr>
		    <td>Security Description<span class="mantatory">*&nbsp;</span></td>						
            <td> 
<!--              <input type="text" name="txt_security_desc" size="30" maxlength="29"-->
<!--		value='' tabindex="5"> -->
   <textarea name='txt_security_desc' rows='3' cols='50' onkeypress='textlimitcorp1(this,300);notAllowSingleAndDoubleQuote();'  onblur="textlimitcorp1(this,300);" onkeyup="textlimitcorp1(this,300);" onkeydown="textlimitcorp1(this,300);"></textarea>
   </td>
			<td>Date of Valuation (as per report)<span class="mantatory">*&nbsp;</span></td>										
		    <td > 
              <input type="text" name="txt_validation_date" size="11"
							value=""
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate(this,document.forms[0].txt_dateofsubmissionbybank.value);captureComments();CallvaluerCheck();" maxlength="12" tabindex="15">
		    <a alt="Select date from calender" 
							onClick="callCalender('txt_validation_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
		</tr>
		
		<tr>
		    <td>Collateral Start Date <span class="mantatory">*&nbsp;</span></td>										
		    <td> 
              <input type="text" name="txt_collareral_start_date" size="11"
							value=""
							onBlur="checkDate(this);checkFromToDate();checkmaxdate(this,currentDate);" maxlength="12" tabindex="6">
		<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_collareral_start_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
			<td>Insurance Company</td>
						<td><input type="text" name="txt_insurence_company" size="30" maxlength="29"
													value="" tabindex="16"></td>
						
		</tr>
		<tr>
		<td>Collateral End Date <span class="mantatory">*&nbsp;</span></td>										
		    <td> 
              <input type="text" name="txt_collareral_end_date" size="11"
							value=""
							onBlur="checkDate(this);checkmindate(this,curdate),checkFromToDate()" maxlength="12" tabindex="7">
		    <a alt="Select date from calender" href="#"
							onClick="callCalender('txt_collareral_end_date')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
							
			<td>Insured Amount <b><%=ApplicationParams.getCurrency()%></b></td>						
            <td> 
              <input type="text" name="txt_insured_amount" size="12" maxlength="10"
		value='' onKeyPress="allowNumber(document.forms[0].txt_insured_amount)" onBlur="roundtxt(document.forms[0].txt_insured_amount)" tabindex="18" style="text-align:right"></td>
			
						
		</tr>
		
		<tr style="visibility:hidden;position:absolute">
		<td>Residual Amount <b><%=ApplicationParams.getCurrency()%></b></td>						
              <td> 
              <input type="text" name="txt_residual_amount" size="12" maxlength="10" readOnly
		value='' onKeyPress="allowNumber(document.forms[0].txt_residual_amount)" onBlur="roundtxt(document.forms[0].txt_residual_amount)" tabindex="18" style="text-align:right"></td>
		</tr>
		<tr>
		<td>Total Market Value <span class="mantatory">*&nbsp;</span> <b><%=ApplicationParams.getCurrency()%></b></td>						
              <td> 
              <input type="text" name="txt_total_secval" size="12" maxlength="15" readOnly
		value='' onKeyPress="allowNumber(document.forms[0].txt_total_secval)" onBlur="cleansecval();roundtxt(document.forms[0].txt_total_secval);callnetsec();captureComments();CallvaluerCheck();newcheck();" tabindex="18" style="text-align:right"></td>
			
		   
		
		    <td>Due Date </td>										
		    <td> 
              <input type="text" name="txt_duedate" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGFRMDAT"))%>"
							onBlur="checkDate(this);" maxlength="12" tabindex="19">
		<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_duedate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
		</tr>
		
			<!-- <tr>
					<td >Value as per valuation <span class="mantatory">*&nbsp;</span></td>
					<b >Rs.</b>
					<td >
						<input type="text" style="text-align:right"  name="txt_Valuation" size="30" value="" maxlength="15" tabindex="9" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);fsvamtchk();">
					</td>
				
				
					<td>Forced sale value <span class="mantatory" >*&nbsp;</span></td>
					<b >Rs.</b>
					<td >
						<input type="text" style="text-align:right"  name="txt_ForcedSale" size="30" value="" maxlength="15" tabindex="10" onKeyPress="allowNumber(this);" onBlur="roundtxt(this);fsvamtchk();">
					</td>
				</tr> -->
		
		
		
		<tr>
			 <td>Net Security Value <span class="mantatory">*&nbsp;</span> <b><%=ApplicationParams.getCurrency()%></b></td>						
            <td>
              <input type="text" name="txt_net_security" size="12" maxlength="15"
		value='' onKeyPress="allowNumber(document.forms[0].txt_net_security)" onBlur="roundtxt(document.forms[0].txt_net_security)"  onchange="captureComments();" tabindex="8" style="text-align:right"></td>
										
			 <td>Joint Holder</td>						
            <td> 
              <select name="sel_jointholder" onChange="selJointHolder()" tabindex="20">
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
						
					
		</tr>	
		
		<tr>
		<td>Residual Risk Flag</td>						
            <td> 
              <select name="sel_residual_risk" tabindex="9" >
							<option value="" selected>--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
						</select></td>
												
			 <td id="com1">Comments<span class="mantatory">*&nbsp;</span></td>						
             <td id="com2"> 
  			 	<textarea name='txt_comments' rows='3' cols='50' onkeypress='notAllowSingleAndDoubleQuote();' maxlength='3990'"></textarea>
  			</td>
		</tr>
		
		<tr id="Cersai_det">
		<td>CERSAI ASSET ID&nbsp;</td>						
            <td><input type="text" name="txt_cersai_id" size="30" maxlength="12" value="" tabindex="" onblur="cerDuplicateCheck(this,'0','txt_cersai_id')" onkeypress="allowInteger();" onChange="callMinVAl()"></td>
            											
			 <td>CERSAI ASSET ID Creation Date&nbsp;</td>						
             <td> 
						<input type="text" name="txt_CersaiDate" size="20" 
							value="" onBlur="checkDate(this);checkmaxdate(this,curdate);" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender('txt_CersaiDate')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a>  			</td>
		</tr>
		
		<tr style="visibility:hidden;position:absolute">
		
		 <td>Weather Liquid Security&nbsp;<span class="mantatory">*</span></td>
		 <td><select name="sel_weathliquid" onchange="showMaturDate()">
		 <option value="">--Select--</option>
		 <option value="Y">Yes</option>
		 <option value="N">No</option>
		 </select></td>
		 <td id="m1">Maturity Date<span class="mantatory">*</span></td>
		 <td id="m2"> 
              <input type="text" name="txt_matudateliq" size="11"
							value="<%=Helper.correctNull((String) hshValues
							.get("DEF_ECGFRMDAT"))%>"
							onBlur="checkDate(this);checkmindate(this,curdate)" maxlength="12" tabindex="19">
		<a alt="Select date from calender" href="#"
							onClick="callCalender('txt_matudateliq')"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
						
		
		</tr>
		
		<tr>
				 <td class="dataheader" colspan="2" align="center" id="ValuerDetails1"> <span style="width: 80%;"> Valuer Details  </span> 
				 <span style="width: 20%;">  <a onClick="Addvaluer();"><img
								src="<%=ApplicationParams.getAppUrl()%>img/add.png"
								width="10" height="10" border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;
					 <a onClick="deleteRow('tabid_valuerlist');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							width="10" height="10" border="0" tabindex="38"></a> </span>
				 </td>
				<td colspan="2" id="id_ownerdet">
					<table width="100%" border="0"  align="center" class="outertable">
						<tr>
						<td id="ownership">Security Ownership <span class="mantatory">*&nbsp;</span></td>						
		                <td id="ownership1"> 
		                <input type="text" name="txt_security_ownership" size="12" maxlength="10" readonly="readonly">
		                 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<input type="button" name="add1"
																	value="Add" class="buttonStyle"
																	onClick="callAddJointSecurity()" tabindex="21" disabled="disabled">
					    &nbsp;&nbsp;<input type="button" name="remove"
																	value="Remove" class="buttonStyle"
																	onClick="jointSecurityDel()" tabindex="22" disabled="disabled">
		                </td>
						</tr>
					</table>
				</td>
		</tr>
		
		<tr>
				<td colspan="6" valign="top" width="45%">
				<table id="idtxtcersialcrop" width="50%" border="0"  align="center" class="outertable"  style="border: 1px solid #bbb;">
				<tr class="dataheader" align="center" >
						<td width="5%"><span style=""  id="idheader"><a onClick="AddvaluerCrop();"><img
							src="<%=ApplicationParams.getAppUrl()%>img/add.png"
							border="0" tabindex="38"></a>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
					 		<a onClick="deleteRowCrop('tabid_Cropvaluerlist','0');"><img
							src="<%=ApplicationParams.getAppUrl()%>img/cancel.png"
							border="0" tabindex="38"></a> </span>&nbsp; </td>
						<td width="25%"> CERSAI ASSET ID</td>
						<td width="25%"> CERSAI ASSET ID Creation Date</td>
				</tr>
			<tr class="datagrid">
				<td colspan="6"  width="48%"> 
				<table width="98%" border="0"  align="center" class="outertable border1"  style="border: 1px solid #bbb;" id="tabid_Cropvaluerlist">
				<tr align="center" id="0">	
					<td width="5%"><input type="checkbox" name="chk1" style="border: none;"></td>	
					<td width="25%"><input type="text" name="txt_cersai_Crop_id" size="23" readonly="readonly" value="" maxlength="25" onkeypress="allowAlphaNumeric()" tabindex="13" onblur="cerDuplicateCheck(this,this.parentNode.parentNode.id,'txt_cersai_Crop_id');"></td>
					<td width="25%">
					<input type="text" name="txt_Cersai_Crop_Date" readonly="readonly"
					        size="20"
			                onBlur="checkDate(this);"  
			                value="" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul_Ec('txt_Cersai_Crop_Date',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
				</tr>
				</table>
				</td> 
				</tr>
			</table>
		</td>
		</tr>
		
		<tr>
		<td colspan="2" valign="top" width="70%" id="ValuerDetails2">
			<table width="98%" border="0"  align="center" class="outertable"  style="border: 1px solid #bbb;">
				<tr class="dataheader" align="center">
						<td width="20%"> Valuer Name </td>
						<td width="20%"> Valuation Submission Date</td>
						<td width="20%"> Receipt Date </td>
						<td width="20%"> Valuation Date </td>
						<td width="10%"> Security Value</td>
						<td width="10%"> Approve </td>
				</tr>
				<tr >
				<td colspan="6"> 
				<table width="100%" border="0"  align="center" class="outertable"  style="border: 1px solid #bbb;" id="tabid_valuerlist">
				<tr align="center" id="0">	
					<td  width="20%"><input type="text" name="txt_Valuers_name_mul" readonly="readonly">
						<input type="hidden" name="txt_Valuers_code_mul">
						<input type="hidden" name="txt_Valuers_limit_mul">
						<input type="hidden" name="txt_Valuationloc_mul">
						<input type="hidden" name="txt_Valuers_catcode_mul">
					<span  onClick="showValuersName_mul(this.parentNode.parentNode.id);" style="cursor: hand"><font
													size="1" face="MS Sans Serif"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0"></font></span> </td>
					<td  width="20%"><input type="text" name="txt_dateofsubmissionbybank_mul" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legsubmitteddate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmaxdate_mul(this,'txt_validation_date_mul',this.parentNode.parentNode.id)" maxlength="10" tabindex="15">
		   					 <a alt="Select date from calender" 
							onClick="callCalender_mul('txt_dateofsubmissionbybank_mul',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>	
				
					 <td  width="20%"><input type="text" name="txt_dateofreceiptbybank_mul" size="11"
							value="<%=Helper.correctNull((String)hshValues.get("sec_pl_legrecvdate"))%>"
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate_mul(this,'txt_dateofsubmissionbybank_mul',this.parentNode.parentNode.id)" maxlength="10" tabindex="15">
		    				<a alt="Select date from calender"
							onClick="callCalender_mul('txt_dateofreceiptbybank_mul',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a> </td>
							
					<td width="20%"> <input type="text" name="txt_validation_date_mul" size="11"
							value=""
							onBlur="checkDate(this);checkmaxdate(this,curdate);checkmindate_mul(this,'txt_dateofsubmissionbybank_mul',this.parentNode.parentNode.id)" maxlength="12" tabindex="15">
		    				<a alt="Select date from calender"
							onClick="callCalender_mul('txt_validation_date_mul',this.parentNode.parentNode.id)"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" tabindex="29"></a></td>
					<td width="10%"> <input type="text" name="txt_net_security_mul" onKeyPress="allowNumber(document.forms[0].txt_net_security)" size="10"> </td>				
                 	<td width="10%"> <select name="sel_approveFlag_mul" onchange="changeApprove(this.parentNode.parentNode.id)" >
                 		<option value="N" > No </option> 
                 		<option value="Y"> Yes </option>
                 	</select> </td>
				</tr>
				</table>
				</td> 
				</tr>
			</table>
		</td>
		
		<td colspan="2" width="20%" >
		<table id="id_jointsec" width="90%" border="0" cellspacing="1" cellpadding="3"  align="center" class="outertable"  style="border: 1px solid #bbb;">		
				<tr class="dataheader">
					<td width="5%">&nbsp;</td>
					<td width="30%" align="center">Name</td>
					<td width="30%" align="center">Laps Id</td>			
            		<td width="30%" align="center">CBS Id</td>
            		<td width="5%" align="center">&nbsp;</td>						
				</tr>
				</table>
		</td>
		</tr>
<!--<tr id="jointdetails" height="auto">
			<td colspan="4"><iframe id="ifrmonclick" frameborder="0" style="border: 0" align="right"></iframe></td>	
		
		</tr>   -->		
		</table>
	
		</td>
	</tr>
</table>

<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Release_Security Ownership Change_Audit Trail' btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>'/> 
<br>

<table align="right" width="95%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
			<table width="95%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
				<tr class="dataheader">
					<td width="5%">&nbsp;</td>
					<td width="10%" align="center"><b>Security Id</b></td>
					<td width="22%" align="center" ><b>Security Type</b></td>
					<td width="18%" align="center"><b>Security Classification</b></b></td> 
					<!-- <td width="17%" align="center"><b>Security Description</b></b></td> -->
					<td width="15%" align="center"><b>Net Security Value</b></b></td>		
					<td width="10%" align="center"><b>Status</b></b></td>						
					<td width="10%" align="center"><b>Availability</b></b></td>		
				 	<td width="5%" align="center">&nbsp; </td>						
					<td width="5%" align="center">&nbsp; </td>						
									
				</tr>
				<%
					if (vecRow != null && vecRow.size() > 0) {
						for (int i = 0; i < vecRow.size(); i++) {
							vecCol = (ArrayList) vecRow.get(i);
							String strSecStatus=Helper.correctNull((String) vecCol.get(31));
							if(strSecStatus.equalsIgnoreCase("Y")){
								strSecStatus="Completed";
							}else{
								strSecStatus="Not Completed";
							}
				%>
					 	<tr class="datagrid">
							<td width="5%"><input type="radio" name="radiobutton"
								value="radiobutton" style="border-style:none"
								onClick="selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>',
										'<%=Helper.correctNull((String) vecCol.get(1))%>',
										'<%=Helper.correctNull((String) vecCol.get(2))%>',
										'<%=Helper.replaceForJavaScriptString((String) vecCol.get(3))%>',
										'<%=Helper.checkDecimal(Helper.correctNull((String) vecCol.get(4)))%>',										
										'<%=Helper.correctNull((String) vecCol.get(5))%>',
										'<%=Helper.correctNull((String) vecCol.get(6))%>',
										'<%=Helper.correctNull((String) vecCol.get(7))%>',
										'<%=Helper.correctNull((String) vecCol.get(8))%>',										
										'<%=Helper.correctNull((String) vecCol.get(9))%>',
										'<%=Helper.checkDecimal((String) vecCol
											.get(10))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(11))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(12))%>',										
										'<%=Helper.correctNull((String) vecCol
											.get(13))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(14))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(15))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(16))%>',										
										'<%=Helper.correctNull((String) vecCol
											.get(17))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(18))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(19))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(20))%>',
										'<%=Helper.correctNull((String) vecCol
											.get(21))%>','<%=i%>','<%=Helper.correctNull((String) vecCol
											.get(24))%>','<%=Helper.checkDecimal(Helper.correctNull((String) vecCol
											.get(25)))%>','<%=Helper.correctNull((String) vecCol
											.get(26))%>','<%=Helper.correctNull((String) vecCol
											.get(27))%>','<%=Helper.correctNull((String) vecCol
											.get(28))%>','<%=Helper.correctNull((String) vecCol
											.get(29))%>','<%=Helper.checkDecimal((String) vecCol
											.get(30))%>','<%=Helper.correctNull((String) vecCol
											.get(32))%>','<%=Helper.correctNull((String) vecCol
											.get(33))%>','<%=Helper.correctNull((String) vecCol
											.get(35))%>','<%=Helper.correctNull((String) vecCol
											.get(36))%>','<%=Helper.correctNull((String) vecCol
											.get(37))%>','<%=Helper.correctNull((String) vecCol
											.get(38))%>','<%=Helper.correctNull((String) vecCol
											.get(39))%>','<%=Helper.correctNull((String) vecCol
											.get(40))%>','<%=Helper.correctNull((String) vecCol
											.get(41))%>','<%=Helper.correctNull((String) vecCol
											.get(42))%>','<%=Helper.correctNull((String) vecCol
											.get(43))%>','<%=Helper.replaceForJavaScriptString((String) vecCol
											.get(44))%>','<%=Helper.correctNull((String) vecCol
											.get(45))%>','<%=Helper.correctNull((String) vecCol
											.get(46))%>','<%=Helper.correctNull((String) vecCol
											.get(47))%>','<%=Helper.correctNull((String) vecCol
											.get(48))%>','<%=Helper.correctNull((String) vecCol
											.get(49))%>','<%= vecCol.get(50)%>',
											'<%=Helper.correctNull((String) vecCol.get(51))%>',
											'<%=Helper.correctNull((String) vecCol.get(52))%>',
											'<%=Helper.correctNull((String) vecCol.get(53))%>',
											'<%=Helper.correctNull((String) vecCol.get(54))%>',
											'<%=Helper.correctNull((String) vecCol.get(55))%>',
											'<%=Helper.correctNull((String) vecCol.get(56))%>',
											'<%=Helper.correctNull((String) vecCol.get(57))%>',
											'<%=Helper.correctNull((String) vecCol.get(58))%>',
											'<%=Helper.correctNull((String) vecCol.get(31))%>',
											'<%=Helper.correctNull((String) vecCol.get(59))%>',
											'<%=Helper.correctNull((String) vecCol.get(60))%>',
											'<%=Helper.correctNull((String) vecCol.get(61))%>',
											'<%=Helper.correctNull((String) vecCol.get(62))%>',
											'<%=Helper.correctNull((String) vecCol.get(63))%>',
											'<%=Helper.correctNull((String) vecCol.get(64))%>','<%=Helper.correctNull((String) vecCol.get(65))%>',
											'<%=Helper.correctNull((String) vecCol.get(66))%>','<%=Helper.correctNull((String) vecCol.get(67))%>',
											'<%=Helper.correctNull((String) vecCol.get(68))%>','<%=Helper.correctNull((String) vecCol.get(69))%>'
											)">										

							</td>
							<td width="10%" nowrap="nowrap"><%=Helper.correctNull((String) vecCol.get(0))%></td>
							<td width="22%"><%=Helper.correctNull((String) vecCol
											.get(22))%></td>
							<td width="18%"><%=Helper.correctNull((String) vecCol
											.get(23))%></td>
							<!-- <td width="17%"><%=Helper.correctNull((String) vecCol.get(3))%></td> -->
							<td width="15%" align="right"><%=nf
									.format(Double.parseDouble(Helper
											.correctDouble((String) vecCol
													.get(4))))%></td>	
							<td width="10%" align="left"><%=strSecStatus%></td>							
							<td width="10%"><%=Helper.correctNull((String) vecCol.get(34))%></td>							
							<td width="5%"><input type="button" size="5" name="btnAttProposal" value="Sec. Attach to Proposal" class="buttonOthers" onclick="showsecAttached('<%=Helper.correctNull((String) vecCol.get(0))%>')" >  </td>
							<td width="5%"><input type="button" size="5" name="btnsecModHis" value="Modification History" class="buttonOthers" onclick="showsecModified('<%=Helper.correctNull((String) vecCol.get(0))%>')" >   </td>
						</tr>
					<%
						}
						} else {
							%>
							<tr class="datagrid">
								<td width="5%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
								<td width="10%">&nbsp;</td>
								<td width="107%">&nbsp;</td>	
								<td width="10%">&nbsp;</td>	
								<td width="10%">&nbsp;</td>	
								<td width="10%">&nbsp;</td>	
								<td width="10%">&nbsp;</td>								
								<td width="10%">&nbsp;</td>								
							</tr>
						<%
							}
						%>
				</table>		</td>
	</tr>
</table>
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">
<input type="hidden" name="hidsno"> 
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>">
<input type="hidden" name="hidOnclickFlag"> 
<input type="hidden" name="hidOwners"> 
<input type="hidden" name="hidsecid"> 
<input type="hidden" name="hidCount"> 
<input type="hidden" name="hidCBSID" value="<%=Helper.correctInt((String) hshValues.get("strCBSCustID"))%>"> 
<input type="hidden" name="hidReleaseFlag"> 
<input type="hidden" name="hidOwnerChange"> 
<input type="hidden" name="hidOwnerChangeAppno"> 

<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">  

<input type="hidden" name="old_sel_securitytype"> <input type="hidden" name="old_sel_alreadycharged"> 
<input type="hidden" name="old_txt_security_clasicification_specify"><input type="hidden" name="old_txt_Valuers_name"> <input type="hidden" name="old_txt_Valuers_code">
<input type="hidden" name="old_sel_natureChargeText"> <input type="hidden" name="old_txt_validation_date"> 
<input type="hidden" name="old_txt_security_desc"> <input type="hidden" name="old_txt_insurence_company"> 
<input type="hidden" name="old_txt_collareral_start_date"> <input type="hidden" name="old_txt_insured_amount"> 
<input type="hidden" name="old_txt_collareral_end_date"> <input type="hidden" name="old_txt_duedate"> 
<input type="hidden" name="old_txt_total_secval"> <input type="hidden" name="old_sel_jointholder"> 
<input type="hidden" name="old_txt_net_security"> <input type="hidden" name="old_txt_security_type_specify"> 
<input type="hidden" name="old_sel_residual_risk">  <input type="hidden" name="old_txt_charged_to_institution">  
<input type="hidden" name="old_txt_name_institution">  <input type="hidden" name="old_txt_residual_amount">  
<input type="hidden" name="old_txt_com_cinno">  <input type="hidden" name="old_txt_companyname">  
<input type="hidden" name="old_txt_shareval" >  <input type="hidden" name="old_txt_noofshares">  
<input type="hidden" name="old_sel_securityclassifcationText">
<input type="hidden" name="old_sel_type">
<input type="hidden" name="old_txt_dateofsubmissionbybank">   <input type="hidden" name="old_txt_dateofreceiptbybank">  
<input type="hidden" name="hid_secChangeComments">

<input type="hidden" name="old_txt_secintID_roc">
<input type="hidden" name="old_txt_charid_roc">


<input type="hidden" name="sel_natureChargeText">
<input type="hidden" name="sel_securityclassifcationText">
<input type="hidden" name="old_txt_comments">

<input type="hidden" name="hid_VerificationFlag">
<input type="hidden" name="hid_ValuerListDisp_temp" value="N">
<input type="hidden" name="txt_Valuers_limit">
<input type="hidden" name="hid_oldSecOwnerLength">
<input type="hidden" name="old_hid_SecOwnerList">
<input type="hidden" name="hid_SecOwnerList">


<!--<input type="hidden" name="old_txt_Valuation" value="" />
<input type="hidden" name="old_txt_ForcedSale" value="" />  -->



<input type="hidden" name="old_hid_cersai_id">
<input type="hidden" name="old_hid_cersai_date">

<input type="hidden" name="hidAppid" value="">
<input type="hidden" name="hidcersaiId">
<input type="hidden" name="hidname">
<input type="hidden" name="hidDistrict">
<input type="hidden" name="hidPropFlag">
<input type="hidden" name="hidvaluationarea">
<input type="hidden" name="hidsecuritystatus">
<input type="hidden" name="hidPropertycheck">
<input type="hidden" name="hidcity">
<input type="hidden" name="txt_City">
<input type="hidden" name="hidstate">
<input type="hidden" name="txt_State">
<input type="hidden" name="hid_District">
<input type="hidden" name="txt_District">

<input type="hidden" name="hid_value_as_per_valuation">
<input type="hidden" name="hid_fsv_val">
<%
 	String strappno = request.getParameter("appno");
 %> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<iframe	height="0" width="0" id="ifrmsecurityclassification" frameborder=0 style="border: 0">
<iframe height="0" width="0" id="ifrmcersaiIDcheckduplicate" frameborder="0"	style="border: 0"></iframe>
</iframe>
</form>
</body>
</html>
