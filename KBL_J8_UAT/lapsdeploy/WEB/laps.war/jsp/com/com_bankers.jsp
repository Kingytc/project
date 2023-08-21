<%@include file="../share/directives.jsp"%>

<%
//out.println("hshValues======"+hshValues);
	String strappno = Helper.correctNull((String) hshValues
			.get("BANKER_APPL_NO"));
	
	session.setAttribute("BANKER_APPL_NO", strappno);
	
	String strappstatus = Helper.correctNull((String) hshValues
			.get("BANKER_STATUS"));
	session.setAttribute("strappstatus", strappstatus);
	session.setAttribute("hidappstatus", strappstatus);
	session.setAttribute("hidapplholder",Helper.correctNull((String) hshValues
			.get("BANKER_APPLNHOLDER")));
	
	session.setAttribute("hidapplname",Helper.correctNull((String) hshValues
			.get("BANKER_APPLICANT_NAME")));
	session.setAttribute("hidOrgname",Helper.correctNull((String) request.getParameter("hidOrgname")));
	
	String appno = Helper.correctNull((String) hshValues
			.get("strappno"));
	String appid=Helper.correctNull((String) hshValues.get("BANKER_APPID"));
	//session.setAttribute("hidDemoId",appid);
	String strBtnenable = Helper.correctNull((String) session.getAttribute("btnenable"));
			
	session.setAttribute("strBtnenable", strBtnenable);
	String strCertificateNo=Helper.correctNull((String) hshValues.get("BANKER_CERTF_NO"));
	String[] strCertNo;
	if(!strCertificateNo.equalsIgnoreCase("")){
	 strCertNo=strCertificateNo.split("/");
	
	}
	else
	{
		strCertificateNo="/ / /";
		strCertNo=strCertificateNo.split("/");
	}
	String strSanBranch=Helper.correctNull((String) hshValues.get("BANKER_SANCTIONING_BRANCH"));
	String strSancfor=Helper.correctNull((String) hshValues.get("BANKER_SANCTION_FOR"));

	java.text.NumberFormat nf = java.text.NumberFormat
	.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	
	
%>
<html>
<head>
<title>Bankercertificate</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script type="text/javascript">
	var sanctionedby = "<%=Helper.correctNull((String) hshValues.get("BANKER_SANCTIONED_BY"))%>";
	var appno="<%=Helper.correctNull((String) hshValues.get("BANKER_APPL_NO"))%>";
    var id="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>";

    var varappholder='<%=Helper.correctNull((String) hshValues
							.get("BANKER_APPLNHOLDER"))%>'; 
    var varAction="<%=Helper.correctNull((String) hshValues.get("hidAction"))%>";
    var curDate="<%=Helper.getCurrentDateTime()%>";
    var varsanbranch="<%=strSanBranch%>";
	var appraisal_department = "<%=Helper.correctNull((String) hshValues.get("BANKER_SANCTIONING_DEPT"))%>";
	var varsancfor = "<%=Helper.correctNull((String) hshValues.get("BANKER_SANCTION_FOR"))%>";
    var varnetworthperc="<%=Helper.correctDouble((String) hshValues.get("networthperc"))%>";
    var txt_typeofbef = "<%=Helper.correctNull((String) hshValues.get("Type_of_Beneficiary"))%>";
   	var varstrUserClass = "<%=Helper.correctNull((String) hshValues.get("strUserClass"))%>";
var BANK_CHARGES_REASON="<%=Helper.correctNull((String) hshValues.get("BANK_CHARGES_REASON"))%>";
var org_level="<%=Helper.correctNull((String) hshValues.get("org_level"))%>";

   	function disabledFields(one)
   	{
   		for(var i=0;i<document.forms[0].length;i++)
   		{
   			if(document.forms[0].elements[i].type=='text')
   			{
   				document.forms[0].elements[i].readOnly=one;
   			}	  
   			if(document.forms[0].elements[i].type=='select-one')
   			{
   				document.forms[0].elements[i].disabled=one;
   			}
   			if(document.forms[0].elements[i].type=="textarea")
   			{
   				document.forms[0].elements[i].readOnly=one;		  
   			}
   			if(document.forms[0].elements[i].type=="checkbox")
   			{
   				document.forms[0].elements[i].disabled=one;		  
   			}
   			if(document.forms[0].elements[i].type=="select-multiple" )
   			{
   				document.forms[0].elements[i].disabled=one;
   			}
   		}
   	}
   	
     function onloading() 
    {
		disabledFields(true);
		if (varsancfor != "")
		 {
			document.forms[0].sel_sanctionfor.value = varsancfor;
		 }
		
		 
		if (sanctionedby != "")
		 {
			document.forms[0].sel_SancAuth.value = sanctionedby;
		 }
		if (appraisal_department != "")
		 {		
			document.forms[0].sel_SancDept.value=appraisal_department;
		 }

		 if(txt_typeofbef!="")
		 {
			 document.forms[0].txt_typeofbef.value=txt_typeofbef;
		 }

		// if (sanctionedby != "")
		// {
		funsanctiondept(sanctionedby);
		 
		funsancrefno();
		//}
		if(varsanbranch!="")
		{
			document.forms[0].sel_SancBranch.value =varsanbranch;
		}
		 if(document.forms[0].btnenable.value=="Y")
		 {
	    	<%if (strappstatus.equalsIgnoreCase("PR")
					|| strappstatus.equalsIgnoreCase("PA") || strappstatus.equalsIgnoreCase("CA")) {%>
					//alert("1");
	    		enableButtons(true, true, true, false, false);
	     
	   		 <%} else {%>
	   		//alert("2");
	        enableButtons(false, true, true, true, false);
	    	<%}%>
		 }

		 if(document.forms[0].hidapplholder.value==document.forms[0].txt_usrid.value)
	   		 {
	   		 //alert("holder");
	   			 enableButtons(false, true, true, true, false);
	   		 }
	   		 else
	   		 {
		   		 //alert("else");
	   			enableButtons(true, true, true, true, false);
	   		 }

   		 
		 if(varAction=="new")
   		 {
			 //alert("3");
	   			enableButtons(false, true, true, true, false);
	   			document.forms[0].hidAction.value = "new";
	   			//document.forms[0].txt_issuedt.value = curDate;
	   			disabledFields(false);
	   	 }

		             
		 	   		
		 	   		 
		 <%if (strappstatus.equalsIgnoreCase("PR")
					|| strappstatus.equalsIgnoreCase("PA") ||  strappstatus.equalsIgnoreCase("CA")) {%>
					//alert("4");
	    		enableButtons(true, true, true, true, false);
	     
	   		 <%}%>


		 
		    document.forms[0].txt_cbsid.readOnly = true;
			document.forms[0].txt_nameofappl.readOnly = true;
			document.forms[0].txt_address.readOnly = true;
			document.forms[0].txt_addresstwo.readOnly = true;
			document.forms[0].txt_village.readOnly = true;
			document.forms[0].txt_city.readOnly = true;
			document.forms[0].txt_district.readOnly = true;
			document.forms[0].txt_state.readOnly = true;
			document.forms[0].txt_permzip.readOnly = true;
			document.forms[0].txtperapp_country.readOnly = true; 
			document.forms[0].txt_certfno.readOnly = true;
			document.forms[0].hid_appid.readOnly = true;
			document.forms[0].txt_applno.readOnly = true;
			document.forms[0].txt_networth.readOnly = true;
			document.forms[0].old_appid.readOnly = true;
			document.forms[0].txt_issuedt.readOnly = true;

			
			document.forms[0].txt_typeofbef.readOnly = true;
			document.forms[0].txt_nameofben.readOnly = true;
			document.forms[0].txt_benfaddress.readOnly = true;
			document.forms[0].txt_benfaddresstwo.readOnly = true;
			document.forms[0].txt_benfCity.readOnly = true;
			document.forms[0].txt_benfState.readOnly = true;
			document.forms[0].txt_benfDistrict.readOnly = true;
			document.forms[0].txt_existacc.readOnly = true;
			document.forms[0].txt_ten_not_date.readOnly = true;
			document.forms[0].txt_cutoffsubdate.readOnly = true;
			document.forms[0].txt_tenopendate.readOnly = true;
			document.forms[0].txt_indentno.readOnly = true;
			//document.forms[0].txt_valoftender.readOnly = true;

			document.forms[0].txt_commissionearn.readOnly = true;
			document.forms[0].txt_count.readOnly = true;
			document.forms[0].txt_sanlim.readOnly = true;
			document.forms[0].txt_expcount.readOnly = true;
			document.forms[0].txt_explim.readOnly = true;			
			document.forms[0].sel_sanctionfor.disabled = true;
			document.forms[0].sel_SancAuth.disabled = true;
			//document.forms[0].sel_reasonforcharges.disabled = true;
			document.forms[0].txt_typeofbef.disabled = true;
			document.forms[0].sel_SancDept.disabled = true;

			var appcharges=parseInt(document.forms[0].txt_appcommissionearn.value);
		       var comcharges=parseInt(document.forms[0].txt_commissionearn.value);
		       
				if((appcharges)<(comcharges))
				{
						document.all.reasoncharges1.style.visibility="Visible";
						document.all.reasoncharges1.style.position="relative";
						document.all.reasoncharges2.style.visibility="Visible";
						document.all.reasoncharges2.style.position="relative";

						if (BANK_CHARGES_REASON != "")
						 {
							document.forms[0].sel_reasonforcharges.value = BANK_CHARGES_REASON;
							document.forms[0].sel_reasonforcharges.disabled = true;
						 }
						
					}
					else
					{
						document.all.reasoncharges1.style.visibility="hidden";
						document.all.reasoncharges1.style.position="absolute";
						document.all.reasoncharges2.style.visibility="hidden";
						document.all.reasoncharges2.style.position="absolute";
					}

				document.forms[0].cmdreport.disabled = true;

				<%if ( strappstatus.equalsIgnoreCase("")  || strappstatus.equalsIgnoreCase("OP") || strappstatus.equalsIgnoreCase("PA") || strappstatus.equalsIgnoreCase("PR") )
				{%>				
				percentageval();
				<%}%>

				<%if (strappstatus.equalsIgnoreCase("PA")  && Helper.correctNull((String) hshValues.get("currentStatus")).equalsIgnoreCase("EXPIRED") )
				{%>
				alert("Please Extend the validity of the Certificate!!!");
					
				<%}%>
						
	 }
	 
	function callCalender(name) {
		if (document.forms[0].cmdsave.disabled == false) {
			showCal(appURL, name);
		}
	}
	
	function enableButtons(bool1, bool2, bool3, bool4, bool5) {
		//alert("bool2==="+bool2);
		document.forms[0].cmdedit.disabled = bool1;
		document.forms[0].cmdsave.disabled = bool2;
		document.forms[0].cmdcancel.disabled = bool3;
		document.forms[0].cmddelete.disabled = bool4;
		document.forms[0].cmdclose.disabled = bool5;
		//document.forms[0].cmdreport.disabled = bool6;
	}

	function doCancel() {
		if (ConfirmMsg(102)) {
			document.forms[0].method="post";
			document.forms[0].hidBeanId.value = "comsolvency";
			document.forms[0].hidBeanGetMethod.value = "getBankersData";
			document.forms[0].action = appURL + "action/com_bankers.jsp";
			document.forms[0].submit();
		}
	}

	 function doEdit() {
		 //alert("edit");
		disabledFields(false);
		document.forms[0].hidAction.value = "insert";
		enableButtons(true, false, false, false, false);
		document.forms[0].txt_cbsid.readOnly = true;
		document.forms[0].txt_nameofappl.readOnly = true;
		document.forms[0].txt_address.readOnly = true;
		document.forms[0].txt_addresstwo.readOnly = true;
		document.forms[0].txt_village.readOnly = true;
		document.forms[0].txt_city.readOnly = true;
		document.forms[0].txt_district.readOnly = true;
		document.forms[0].txt_state.readOnly = true;
		document.forms[0].txt_permzip.readOnly = true;
		document.forms[0].txtperapp_country.readOnly = true; 
		document.forms[0].txt_certfno.readOnly = true;
		document.forms[0].txt_solcertf1.readOnly = true;
		document.forms[0].txt_solcertf2.readOnly = true;
		document.forms[0].hid_appid.readOnly = true;
		document.forms[0].txt_applno.readOnly = true;
		document.forms[0].txt_networth.readOnly = true;
		document.forms[0].old_appid.readOnly = true;
		document.forms[0].txt_issuedt.readOnly = true;
		document.forms[0].txt_commissionearn.readOnly = true;
		document.forms[0].txt_benfCity.readOnly = true;
		document.forms[0].txt_benfState.readOnly = true;
		document.forms[0].txt_benfDistrict.readOnly = true;

		/*document.forms[0].txt_typeofbef.readOnly = true;
		document.forms[0].txt_nameofben.readOnly = true;
		document.forms[0].txt_benfaddress.readOnly = true;
		document.forms[0].txt_benfaddresstwo.readOnly = true;
		document.forms[0].txt_benfCity.readOnly = true;
		document.forms[0].txt_benfState.readOnly = true;
		document.forms[0].txt_existacc.readOnly = true;
		document.forms[0].txt_benfDistrict.readOnly = true;
		document.forms[0].txt_ten_not_date.readOnly = true;
		document.forms[0].txt_cutoffsubdate.readOnly = true;
		document.forms[0].txt_tenopendate.readOnly = true;
		document.forms[0].txt_indentno.readOnly = true;
		document.forms[0].txt_valoftender.readOnly = true;*/
		if(appno!="")
		 {
			 //alert("1");
			 document.forms[0].sel_sanctionfor.readOnly = true;
			 document.forms[0].sel_sanctionfor.value=varsancfor;
			 document.forms[0].sel_sanctionfor.disabled = true;
			 document.forms[0].sel_sanctionfor.value=varsancfor;
		 }

		document.forms[0].txt_count.readOnly = true;
		document.forms[0].txt_sanlim.readOnly = true;
		document.forms[0].txt_expcount.readOnly = true;
		document.forms[0].txt_explim.readOnly = true;

	    if( parseInt(varstrUserClass)>=130  && (org_level=="R" || org_level=="C" || org_level=="D"))
	    {
		document.forms[0].txt_valdays.readOnly = false;
	    }
	    else
	    {
	    document.forms[0].txt_valdays.readOnly = true;  
	    }

		var appcharges=parseInt(document.forms[0].txt_appcommissionearn.value);
	       var comcharges=parseInt(document.forms[0].txt_commissionearn.value);
	       
			if((appcharges)<(comcharges))
			{
					document.all.reasoncharges1.style.visibility="Visible";
					document.all.reasoncharges1.style.position="relative";
					document.all.reasoncharges2.style.visibility="Visible";
					document.all.reasoncharges2.style.position="relative";

					

					
				}
				else
				{
					document.all.reasoncharges1.style.visibility="hidden";
					document.all.reasoncharges1.style.position="absolute";
					document.all.reasoncharges2.style.visibility="hidden";
					document.all.reasoncharges2.style.position="absolute";
				}
	 
	}

	function doDelete() 
	{
		if (ConfirmMsg(101)) 
		{
			document.forms[0].hidAction.value = "delete";
			document.forms[0].action = appURL + "action/ControllerServlet";
			document.forms[0].hidBeanId.value = "comsolvency";
			//document.forms[0].hidBeanMethod.value = "updateBankersData";
			document.forms[0].hidBeanGetMethod.value = "updateBankersData";
			document.forms[0].hidSourceUrl.value = "action/com_searchbankers.jsp";
			document.forms[0].submit();
			alert("Application Deleted Sucessfully");
        }
	}

	function doClose() 
	{
		if (ConfirmMsg(100)) 
		{
			document.forms[0].action = appURL + "action/mainnav.jsp";
			document.forms[0].submit();
		}
	}
   function doReport()
   {
	  // alert("report");
	  var strappno="<%=strappno%>";
	  var appid="<%=appid%>";
	 // var varQryString = appURL + "action/BanksearchCity.jsp?banker=" + val1;
	 	var varQryString = appURL+"action/com_bankersreport.jsp?type=R&hidBeanGetMethod=getbankdata&hidBeanId=comsolvency&hidapplno="+strappno+"&cusid="+document.forms[0].txt_cbsid.value;
		var title = "Banker'sReport";
		var prop = "scrollbars=yes,menubar=yes,width=900,height=550";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
   } 
     
	function doSave() 
	{
		if (document.forms[0].txt_nameofappl.value == "") {
			ShowAlert('121', "Name of The Applicant");
			document.forms[0].txt_nameofappl.focus();
			return;
		}
		if (document.forms[0].txt_address.value == "") {
			ShowAlert('121', "Address");
			document.forms[0].txt_address.focus();
			return;
		}
		/*if (document.forms[0].txt_purpose.value == "") {
			ShowAlert('121', "Purpose");
			document.forms[0].txt_purpose.focus();
			return;
		}*/
		if (document.forms[0].txt_amtrs.value == "" || document.forms[0].txt_amtrs.value == "0" || document.forms[0].txt_amtrs.value == "0.0"|| document.forms[0].txt_amtrs.value == "0.00") {
			ShowAlert('121', "Amount BC/LOC (in Rs.)");
			document.forms[0].txt_amtrs.focus();
			return;
		}
		if (document.forms[0].txt_commissionearn.value == "") {
			ShowAlert('121', "Commission Earned[In Rs.]");
			document.forms[0].txt_commissionearn.focus();
			return;
		}
		/*if (document.forms[0].txt_networth.value == "") {
			ShowAlert('121', "Net Worth[In Rs.]");
			document.forms[0].txt_networth.focus();
			return;
		}*/

		if(document.forms[0].txt_networth.value=="" || document.forms[0].txt_networth.value=="0" ||
				 document.forms[0].txt_networth.value=="0.0" || document.forms[0].txt_networth.value=="0.00")
		{
			alert("Please Modify Networth in Customer Profile and proceed further");
			document.forms[0].txt_networth.value="";
			return;	
		}
		
		/*if (document.forms[0].txt_city.value == "") {
			ShowAlert('121', "City");
			document.forms[0].txt_city.focus();
			return;
		}*/
		if(document.forms[0].sel_SancDept.value=="s")
		{
			ShowAlert('111', "Sanctioning Department"); 	
			document.forms[0].sel_SancDept.focus();
			return;	
		}
		if((document.forms[0].sel_SancDept.value=="010" || document.forms[0].sel_SancDept.value=="008" || document.forms[0].sel_SancDept.value=="013" || document.forms[0].sel_SancDept.value=="014"|| document.forms[0].sel_SancDept.value=="015"|| document.forms[0].sel_SancDept.value=="016") && document.forms[0].sel_SancBranch.value=="")
	   	{
	   		alert("Select Sanctioning Branch");
	   		document.forms[0].sel_SancBranch.focus();
	   		return;
	   	}
		if (document.forms[0].sel_SancAuth.value == ""||document.forms[0].sel_SancAuth.value == "s") {
			ShowAlert('111', "Sanctioning Authority");
			document.forms[0].sel_SancAuth.focus();
			return;
		}
		if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
		{
			if(document.forms[0].txt_sancrefno.value=="")
			{
				ShowAlert('121', "Sanction Reference No"); 	
				document.forms[0].txt_sancrefno.focus();
				return;	
			}
			if(document.forms[0].sanctiondate.value=="")
			{
				ShowAlert('111', "Sanction Date"); 	
				document.forms[0].sanctiondate.focus();
				return;	
			}
		}
		
	/*	if (document.forms[0].txt_district.value == "") {
			ShowAlert('121', "District");
			document.forms[0].txt_district.focus();
			return;
		}*/
		if (document.forms[0].txt_permzip.value == "") {
			ShowAlert('121', "Pincode");
			document.forms[0].txt_permzip.focus();
			return;
		}
      /* if (document.forms[0].txtperapp_country.value == "") {
			ShowAlert('121', "Country");
			document.forms[0].txtperapp_country.focus();
			return;
		}*/
       if (document.forms[0].txt_addresstwo.value == "") {
			ShowAlert('121', "Address");
			document.forms[0].txt_addresstwo.focus();
			return;
		}
       if(document.forms[0].txt_nameofben.value=="")
		{
			ShowAlert('111', "Benificiary Name"); 	
			document.forms[0].txt_nameofben.focus();
			return;	
		}
       if(document.forms[0].txt_benfaddress.value=="")
		{
			ShowAlert('111', "Benificiary Address"); 	
			document.forms[0].txt_benfaddress.focus();
			return;	
		}
       if(document.forms[0].txt_benfaddresstwo.value=="")
		{
			ShowAlert('111', "Benficiary Address2"); 	
			document.forms[0].txt_benfaddresstwo.focus();
			return;	
		}
       if(document.forms[0].hid_City.value=="")
		{
			ShowAlert('121', "City"); 	
			document.forms[0].hid_City.focus();
			return;	
		}
       if(document.forms[0].hid_State.value=="")
		{
			ShowAlert('121', "State"); 	
			document.forms[0].hid_State.focus();
			return;	
		}
       if(document.forms[0].hid_District.value=="")
		{
			ShowAlert('121', "District"); 	
			document.forms[0].hid_District.focus();
			return;	
		}
       if(document.forms[0].sel_sanctionfor.value=="0")
		{
			ShowAlert('121', "Applied for"); 	
			document.forms[0].sel_sanctionfor.focus();
			return;	
		}
       if(document.forms[0].txt_breifworkdet.value=="")
		{
			ShowAlert('111', "Work Order/Contract Details"); 	
			document.forms[0].txt_breifworkdet.focus();
			return;	
		}
		
		

       if(document.forms[0].txt_ten_not_date.value=="")
		{
			ShowAlert('111', "Tender Notification date"); 	
			document.forms[0].txt_ten_not_date.focus();
			return;	
		}


       if(document.forms[0].txt_tenopendate.value=="")
		{
			ShowAlert('111', "Tender Opening date"); 	
			document.forms[0].txt_tenopendate.focus();
			return;	
		}


       if(document.forms[0].txt_typeofbef.value=="")
		{
			ShowAlert('111', "Type of Beneficiary"); 	
			document.forms[0].txt_typeofbef.focus();
			return;	
		}


       if(document.forms[0].txt_appcommissionearn.value=="" || document.forms[0].txt_appcommissionearn.value=="0" || document.forms[0].txt_appcommissionearn.value=="0.0" || document.forms[0].txt_appcommissionearn.value=="0.00")
		{
   		//alert("1");
   		if(document.forms[0].sel_reasonforcharges.value=="Waived")
   		{
   			//alert("2");
   		}
   		else 
   		{
   	   		if(document.forms[0].sel_reasonforcharges.value=="Concession")
   	   		{
   	   		//alert("3");
			ShowAlert('111', "charges collected(in Rs.) excluding GST"); 	
			document.forms[0].txt_appcommissionearn.focus();
			return;	
   	   		}
   		}
		}


       if(document.forms[0].txt_existacc.value=="")
		{
			ShowAlert('111', "Operative Account No"); 	
			document.forms[0].txt_existacc.focus();
			return;	
		}

       var appcharges=parseInt(document.forms[0].txt_appcommissionearn.value);
       var comcharges=parseInt(document.forms[0].txt_commissionearn.value);
      // alert("appcharges"+appcharges);
       //alert("comcharges"+comcharges);
		if((appcharges)<(comcharges))
		{
				document.all.reasoncharges1.style.visibility="Visible";
				document.all.reasoncharges1.style.position="relative";
				document.all.reasoncharges2.style.visibility="Visible";
				document.all.reasoncharges2.style.position="relative";

				if(document.forms[0].sel_reasonforcharges.value=="s")
				{
				ShowAlert('111', "Reason"); 	
				document.forms[0].sel_reasonforcharges.focus();
				return;
				}

				
			}
			else
			{
				document.forms[0].sel_reasonforcharges.value="";
				document.all.reasoncharges1.style.visibility="hidden";
				document.all.reasoncharges1.style.position="absolute";
				document.all.reasoncharges2.style.visibility="hidden";
				document.all.reasoncharges2.style.position="absolute";
			}
						
       	document.forms[0].cmdsave.disabled = true;
       	//alert("appno===="+appno);
       	if(appno=="")
       	{
       	document.forms[0].hidAction.value = "new";
       	}
       	else
       	{
       		document.forms[0].hidAction.value = "insert";
       	}
		document.forms[0].txt_certfno.value=document.forms[0].txt_certfno.value+"/"+document.forms[0].txt_solcertf1.value+"/"+document.forms[0].txt_solcertf2.value;
		//document.forms[0].action = appURL + "action/ControllerServlet";
		document.forms[0].hidBeanId.value = "comsolvency";
		//document.forms[0].hidBeanMethod.value = "updateBankersData";
		document.forms[0].hidBeanGetMethod.value = "updateBankersData";
		document.forms[0].action=appURL+"action/com_bankers.jsp";
		//document.forms[0].hidSourceUrl.value = "/action/com_bankers.jsp";
		document.forms[0].submit();
	}

	
	function showstate() {
		
		var val1 = document.forms[0].hidcity.value;
		var val2 = document.forms[0].hidstate.value;
		if (val1 != "") {
			document.forms[0].hidcity1.value = val1;
		}
		if (val2 != "") {
			document.forms[0].hidstate1.value = val2;
		}
	}
	
	function callBankerWorkflow()
	{
		if (sanctionedby!= "")
		{	
			 document.forms[0].action=appURL+"action/bankerworkflow.jsp?hidBeanId=comsolvency&hidBeanGetMethod=getBankerAction&hidDemoId="+id;
			 document.forms[0].submit(); 
	    }
		else {
			alert("Please Enter the Banker Certificate Details to proceed further ");
	    }
	}

	function funsanctiondept(varfname)
	{
		var varsancdept=document.forms[0].sel_SancDept.value;
		if((varsancdept=="008") || (varsancdept=="010")||(varsancdept=="013") || (varsancdept=="014")||(varsancdept=="015") || (varsancdept=="016"))
		{
			document.all.idsanbranch.style.display="table-cell";
			funsancbranchvalues();
		}
		else{
			document.all.idsanbranch.style.display="none";
			document.forms[0].sel_SancBranch.value="";
		}
		document.all.ifrmsancauthority.src=appURL+"action/iframesancauthority.jsp?hidBeanGetMethod=getSancAuthority&hidBeanId=comproposal&sancdept="+varsancdept+"&sancauth="+varfname;
	}
	function funsancbranchvalues()
	{
		var varsancdept=document.forms[0].sel_SancDept.value;
		document.all.ifrmsancbranch.src=appURL+"action/ifrmsancbranches.jsp?hidBeanGetMethod=getSancBranches&hidBeanId=comproposal&sancdept="+varsancdept+"&sancbranch="+varsanbranch;
	}
	function funsancrefno()
	{
		
		if((document.forms[0].sel_SancAuth.value=="15") || (document.forms[0].sel_SancAuth.value=="16")||(document.forms[0].sel_SancAuth.value=="14"))
		{
			document.all.sanrefno.style.display = "table-cell";
			document.all.sanrefval.style.display = "table-cell";
			document.all.sancdate1.style.display = "table-cell";
			document.all.sancdate2.style.display = "table-cell";	
		}
		else
		{
			document.all.sanrefno.style.display = "none";
			document.all.sanrefval.style.display = "none";
			document.all.sancdate1.style.display = "none";
			document.all.sancdate2.style.display = "none";	
			document.forms[0].txt_sancrefno.value="";
			document.forms[0].sanctiondate.value="";
		}		
	}
	
	function callCalender2()
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			showCal(appURL,'sanctiondate');
		}
	}
	function commissionern()
	{
    //alert("commission");
    var vartxt_commissionearn=0.00;
    var varamont=document.forms[0].txt_amtrs.value;
    if(varamont<=1000000){
      document.forms[0].txt_commissionearn.value="5000";
    }
    else if(varamont>1000000){
       document.forms[0].txt_commissionearn.value="10000";
    }
	}	
	function showCitySearch1(val1) {

		if (val1 == "BANKER") {
			if (document.forms[0].cmdsave.disabled == false  ) {
				var varQryString = appURL + "action/BanksearchCity.jsp?banker=" + val1;
				var title = "City";
				var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
				var xpos = (screen.width - 350) / 2;
				var ypos = (screen.height - 120) / 2;
				prop = prop + ",left=50,top=50";
				window.open(varQryString, title, prop);
			}
		}
	}

	function callDistrict() {
		var varstate = document.forms[0].hid_State.value;
		if (document.forms[0].cmdsave.disabled == false ) {
			if (document.forms[0].txt_benfCity.value == "") {
				ShowAlert(112, "City");
				document.forms[0].txt_benfCity.focus();
				return;
			}

			if (document.forms[0].hid_State.value == "") {
				alert("Please Reselect the City");
				document.forms[0].txt_benfCity.focus();
				return;

			} else {
				var varQryString = appURL

						+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="

						+ varstate + "&code=BANKER";

				var title = "District";
				var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';
				prop = prop + ",left=200,top=200";
				window.open(varQryString, title, prop);

			}

		}

	}
	function percentageval(){
		//alert("1");
		
		if(document.forms[0].txt_sanlim.value=="")
		{
			document.forms[0].txt_sanlim.value="0.00";
		}
		if(document.forms[0].txt_amtrs.value=="")
		{
			document.forms[0].txt_amtrs.value="0.00";
		}
		if(document.forms[0].txt_networth.value=="" || document.forms[0].txt_networth.value=="0" || document.forms[0].txt_networth.value=="0.0" || document.forms[0].txt_networth.value=="0.00")
		{
			alert("Please Modify Networth in Customer Profile and proceed further");
			document.forms[0].txt_networth.value="";
			return;	
		}
		var varsanlimit=parseInt(document.forms[0].txt_sanlim.value);
		//alert("varsanlimit"+varsanlimit);
		var varamount=parseInt(document.forms[0].txt_amtrs.value);
		
		var networth =parseInt(document.forms[0].txt_networth.value);
		var pernetworth =parseInt(varnetworthperc)
		//alert("pernetworth"+pernetworth);
		var percentval=(networth*pernetworth);///100;
		var totalamount=varsanlimit+varamount;
		//alert("totalamount"+totalamount);
		//alert("percentval"+percentval);
		if(eval(totalamount)>eval(percentval))
		{
			//alert("amount should not be greater than the "+varnetworthperc + " times of networth" );

			alert("Proposed Amount of BC/LOC + Active BC/LOC should not be greater than "+varnetworthperc + " times of networth");
			document.forms[0].txt_amtrs.value="";
			return false;
		}
		
	}

	
	   

	function chargescollected()
	{
		if(document.forms[0].txt_commissionearn.value=="")
		{
			document.forms[0].txt_commissionearn.value="0.00";
		}
		if(document.forms[0].txt_appcommissionearn.value=="")
		{
			document.forms[0].txt_appcommissionearn.value="0.00";
		}
		var varamount=parseInt(document.forms[0].txt_commissionearn.value);
		var networth =parseInt(document.forms[0].txt_appcommissionearn.value);
		document.forms[0].txt_commissionearn.value=eval(varamount+networth);
		
	}
	

	


	function ValidateOpearativeAcc()
	{
		var varOperAcc=document.forms[0].txt_existacc.value;

		if(varOperAcc!="")
			{
		if(varOperAcc.length!=16)
		{
			alert("Please Enter Valid Operative Account Number");
			document.forms[0].txt_existacc.focus();
			document.forms[0].txt_existacc.value="";
			return;
		}
		else if(varOperAcc!="")
		{
			if(document.forms[0].cmdsave.disabled==false)
			{
				document.forms[0].cmdsave.disabled=true;
				document.all.ifrmcheckduplicate.src = appURL+"action/ifrmcersaiIDcheckduplicate.jsp?hidBeanGetMethod=getcersaiIDCheckDuplicate&hidBeanId=securitymaster&strPage=Prop&strrowindexname=txt_existacc&strAccNo="+document.forms[0].txt_existacc.value;
			}
		}
		}
	}


	function getcomssioncharges()
	{

		if(document.forms[0].txt_amtrs.value=="")
		{
			ShowAlert('111', "Amount in Rs"); 	
			document.forms[0].txt_amtrs.focus();
			return;
		}
		 if(document.forms[0].sel_sanctionfor.value=="0")
			{
				ShowAlert('121', "Applied for"); 	
				document.forms[0].sel_sanctionfor.focus();
				return;	
			}
		
		document.all.ifrmcheckcharges.src = appURL+"action/iframeprocessingfee.jsp?hidBeanGetMethod=getSolvencyDocFee&hidBeanId=perlimitofloan&strPage=bankcert&sel_sanctionfor="+document.forms[0].sel_sanctionfor.value+"&recamt="+document.forms[0].txt_amtrs.value;
		
	}

	function notAllowSplChar1(obj)
	{
		var key=window.event.keyCode;
		//alert(window.event.keyCode);
		if(obj.value.length==0 && (key==32 || (key>47 && key<58)||(key==34 || key==39 || key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62 )))
		{
			window.event.returnValue = false;
		}
		else if(key==35 || key==94 || key==92 || key==126 || key==124 || key==96 || key==60 || key==62 || key==33 || key==64 || key==36 || key==37 || key==38 || key==42 ||  key==40 || key==41 ||  key==123 || key==125 ||  key==91 || key==93 ||  key==39 || key==59 
				||   key==58 || key==34 ||  key==63 || key==47 ||  key==44 || key==46 ||  key==95 || key==45 ||  key==61 || key==43 || key==13)
		{
			window.event.returnValue = false;
		}
	}

	function diffapplcommission()
	{
		 var appcharges=parseInt(document.forms[0].txt_appcommissionearn.value);
	       var comcharges=parseInt(document.forms[0].txt_commissionearn.value);
	      // alert("appcharges"+appcharges);
	       //alert("comcharges"+comcharges);
			if((appcharges)<(comcharges))
			{
					document.all.reasoncharges1.style.visibility="Visible";
					document.all.reasoncharges1.style.position="relative";
					document.all.reasoncharges2.style.visibility="Visible";
					document.all.reasoncharges2.style.position="relative";

					if(document.forms[0].sel_reasonforcharges.value=="s")
					{
					ShowAlert('111', "Reason"); 	
					document.forms[0].sel_reasonforcharges.focus();
					return;
					}

					
				}
				else
				{
					//alert("else");
					//alert("document.forms[0].sel_reasonforcharges.value"+document.forms[0].sel_reasonforcharges.value);
					document.forms[0].sel_reasonforcharges.value=="";
					document.all.reasoncharges1.style.visibility="hidden";
					document.all.reasoncharges1.style.position="absolute";
					document.all.reasoncharges2.style.visibility="hidden";
					document.all.reasoncharges2.style.position="absolute";
				}
							
	}
</script>
</HEAD>
<body onload="onloading();">
<form method="post" class="normal">
<table>
	<tr>
		<td width="50%" align="center" class="sub_tab_active">Banker's
		Certificate</td>

		<td width="50%" align="center" class="sub_tab_inactive"><a
			href="javascript:callBankerWorkflow();"
			onMouseOut="window.status='';return true;"
			onMouseOver="window.status='Applicant';return true;"> <b>
		Banker's Certificate WorkFlow </b></a></td>

	</tr>
	
	<tr>
				<td class="page_flow" colspan="5">Home -> Banker's Certificate
				-> Banker's Certificate Details</td>
			</tr>
</table>
<lapschoice:ApplBankerHeaderTag/>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
			class="outertable" align="center">
			
			
			
			<tr class="dataheader" align="center">
				<td width="20%">CBS Customer ID</td>
				<td width="10%">Applicant ID</td>
				<td width="15%">Proposal No.</td>
				<td width="15%">Banker's Certificate No.</td>
				<td width="25%">Status : <%
					if (strappstatus.equalsIgnoreCase("")) {
				%> New<%
					} else if (strappstatus.equalsIgnoreCase("OP")) {
				%> Open/Pending<%
					} else if (strappstatus.equalsIgnoreCase("PA")) {
				%> Processed/Approved <%
					} else if (strappstatus.equalsIgnoreCase("PR")) {
				%> Processed/Rejected <%
					}  else if(strappstatus.equalsIgnoreCase("CA")) {
				%> Closed/Approved <%
				    } else if (strappstatus.equalsIgnoreCase("CR")) {
				%> Closed/Rejected <%} %>
				</td>
				<td width="15%">Current Status.</td>
			</tr>
			<tr align="center">
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_cbsid" size="10" maxlength="10"
					style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("BANKER_CBS_ID"))%>"></td>

				<td><input type="text" class="finaclefieldsbgcolor"
					name="old_appid" size="7" maxlength="10" style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("BANKER_OLDID"))%>">
				</td>
				<input type="hidden" class="finaclefieldsbgcolor"
					name="hid_appid" size="6" maxlength="10" style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues.get("BANKER_APPID"))%>"/>
			
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_applno" size="16" maxlength="15"
					style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("BANKER_APPL_NO"))%>"></td>

				<td><input type="text" name="txt_solno" size="16"
					maxlength="16" style="text-align: center"
					onkeypress="allowAlphaNumeric()"
					value="<%=Helper.correctNull((String) hshValues.get("BANKER_CERTF_NO"))%>">
				</td>
				<td></td>
				<td><input type="text" class="finaclefieldsbgcolor"
					name="txt_applcurrentstatus" size="16" maxlength="15"
					style="text-align: center"
					value="<%=Helper.correctNull((String) hshValues.get("currentStatus"))%>"></td>
			</tr>
		</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			class="outertable border1" align="center">
			<tr>
				<td>
				<table width="98%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center">
					<tr>
						<td nowrap="nowrap">Name of The Applicant<span
							class="mantatory">*</span></td>
						<td><input type="text" name="txt_nameofappl" size="35"
							maxlength="25" class="finaclefieldsbgcolor" tabindex="1"
							onKeyPress="allowAlphabetsForName();notAllowSplChar1(this)"
							value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_APPLICANT_NAME"))%>"
							maxlength="25"></td>
							
							<td>Applied For<span
							class="mantatory">*</span></td>
						<td><select name="sel_sanctionfor" style="width: 200px" onchange="getcomssioncharges();">
							<option value="0">&lt;--Select--&gt;</option>
							<lapschoice:StaticDataNewTag apptype="244" />
						</select></td>
						
							
<!--						<td width="" nowrap="nowrap">Name of the Beneficiary<span-->
<!--							class="mantatory">*</span></td>-->
<!--						<td><input type="text" name="txt_nameofben" size="35"-->
<!--							maxlength="25" style="text-align: left" tabindex="1"-->
<!--							onKeyPress="allowAlphabetsForName();notAllowSplChar1(this)"-->
<!--							 //maxlength="25"></td>-->
<td></td>
<td></td>

					</tr>

					<tr>
						<td nowrap="nowrap">Address<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_address" size="35"
							class="finaclefieldsbgcolor" maxlength="50" tabindex="2" 
							value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_ADDRESS_ONE"))%>"></td>
							
							<td>Type of Beneficiary<span class="mantatory">*</span></td>
							<td><select name="txt_typeofbef" style="width: 200px">
							<option value="">--Select--</option>
							<lapschoice:StaticDataTag apptype="276" />
						</select></td>
						
						
						<td nowrap="nowrap">Amount BC/LOC (in Rs.)<span class="mantatory">*</span></td>
						<td><lapschoice:CurrencyTag name="txt_amtrs" size="20"
							 tabindex="11" onKeyPress="allowDecimals(this)"
							style="text-align:right" onBlur="roundtxt(this);percentageval();getcomssioncharges();"
							value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("BANKER_AMOUNT"))))%>' /></td>
					</tr>

					<tr>
						<td></td>
						<td><input type="text" name="txt_addresstwo" size="35"
							class="finaclefieldsbgcolor" maxlength="50" tabindex="3" value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_ADDRESS_TWO"))%>"></td>
						
						
						
						<td width="" nowrap="nowrap">Name of the Beneficiary<span
							class="mantatory">*</span></td>
						<td><input type="text" name="txt_nameofben" size="35"
							maxlength="25" style="text-align: left" tabindex="1"
							onKeyPress="allowAlphabetsForName();notAllowSplChar1(this)"
							value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_BENF_NAME"))%>" maxlength="25"></td>
							
							
						
							
							
						
						<td nowrap="nowrap">Applicable charges  (in Rs.)<span
							class="mantatory">*</span> excluding GST</td>
						<td ><lapschoice:CurrencyTag name="txt_commissionearn"
							size="20"  tabindex="12"  
							 style="background: #efddec;text-align:right"
							onBlur="roundtxt(this);"
							value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("procfee"))))%>' /></td>
							<td nowrap="nowrap">charges collected(in Rs.)<span
							class="mantatory">*</span> excluding GST</td>
						<td ><lapschoice:CurrencyTag name="txt_appcommissionearn"
							size="20"  tabindex="12"  
							 style="text-align:right"
							onBlur="roundtxt(this);allowDecimals(this);diffapplcommission()"
							value='<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("BANK_CHARGE_APPLICABLE"))))%>' /></td>
					</tr>

					<tr>
						<td>Village/Taluk/Town</td>
						<td><input type="text" name="txt_village" size="35"
							class="finaclefieldsbgcolor" maxlength="50" tabindex="4"
							value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_VILLAGE_TALUK_TOWN"))%>"
							onKeyPress="allowAlphabetsForName();"></td>
							
							<td>Address of the Beneficiary<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_benfaddress" size="35"
							maxlength="50" tabindex="2"
							 onKeyPress="notAllowSplChar1(this)"
								 value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_BENF_ADDRESSONE"))%>"></td>
							
							
							
							
							
						
						<td nowrap="nowrap">Net Worth [In Rs.]<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_networth" size="20"
							class="finaclefieldsbgcolor" onkeypress="notAllowAlphabets();"
							onblur="roundtxt(this);" tabindex="13"
							value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("BANKER_NETWORTH"))))%>"
							maxlength="7" style="text-align: right" /></td>
							
							<td nowrap="nowrap" id="reasoncharges1">Reason<span class="mantatory">*</span></td>
						<td id="reasoncharges2"><select name="sel_reasonforcharges" style="width: 200px">
							<option value="s">&lt;--Select--&gt;</option>
							<lapschoice:StaticDataNewTag apptype="280" />
						</select></td>
							
					</tr>

					<tr>
						<td>City<span class="mantatory">*</span></td>
						<td><input  type="text" name="txt_city" size="25"
							maxlength="50" tabindex="5" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_city"))%>"
							onKeyPress=""> <input type="hidden" name="hidperapp_city"
							size="5" value=""></td>
							
							<td></td>
							<td><input type="text" name="txt_benfaddresstwo" size="35"
							maxlength="50" tabindex="3"
							 onKeyPress="notAllowSplChar1(this)"
							 value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_BENF_ADRESSTWO"))%>"></td>
							
							
							
							
						
						<td>Operative Account No<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_existacc" size="16" id="opaccno" onKeyPress="allowInteger()"  onBlur="ValidateOpearativeAcc()"
							onkeypress="allowAlphaNumeric()" tabindex="14" value="<%=Helper.correctNull((String) hshValues
									.get("BANKER_EXISTING_ACCNO"))%>"
							maxlength="16" style="text-align: right" /></td>

					</tr>

					<tr>
						<td>District<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_district" size="21"
							maxlength="50" tabindex="6" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_district"))%>"
							onKeyPress="notallowInteger()">
							
							<input type="hidden"
							name="hidperapp_dist" size="5"
							value="<%=Helper.correctNull((String) hshValues
									.get("txtperapp_district"))%>"></td>
									
									
									<td nowrap="nowrap">
						<div align="left">City <b><span class="mantatory">*&nbsp;</span></b></div>
						</td>
						<td><input  name="txt_benfCity"
							value="<%=Helper.correctNull((String)hshValues.get("txtbanker_city"))%>">
						<a href="#" onClick="showCitySearch1('BANKER');"
							style="cursor: hand" tabindex="13"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"> </a></td>
							
									
							
							
						
						<td>Certification No</td>
						<td><input type="text" name="txt_certfno" size="6"
							tabindex="17" onkeypress="allowAlphaNumeric()"
							value="<%=strCertNo[0] %>" maxlength="15"
							style="text-align: right">&nbsp;/&nbsp; <input
							type="text" name="txt_solcertf1" size="15" tabindex="17"
							onkeypress="allowNumber(this)" value="<%=strCertNo[1] %>"
							maxlength="15" style="text-align: right">&nbsp;/&nbsp; <input
							type="text" name="txt_solcertf2" size="10" tabindex="19"
							onkeypress="allowAlphaNumeric()" value="<%=strCertNo[2] %>"
							maxlength="15" style="text-align: right">&nbsp;<br>
						Sol Id/SIno/Year,Ex:513/BC-0001/2020-2021 or 513/LC-0001/2020-2021)</td>

					</tr>

					<tr>
						<td>State</td>
						<td><input type="text" name="txt_state" size="21"
							maxlength="25" tabindex="7" class="finaclefieldsbgcolor"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_permstate"))%>"
							 onKeyPress="allowAlphabets();" onBlur=""> 
							 <input type="hidden" name="hidperapp_state" size="5"
							value="<%=Helper.correctNull((String) hshValues.get("BANKER_STATE"))%>">
						</td>
						
						<td>State<b><span class="mantatory">&nbsp;*</span></b></td>
						<td><input type="text" name="txt_benfState" value="<%=Helper.correctNull((String) hshValues
							.get("txtbanker_permstate"))%>"></td>
							
							
						
							
							
						
						
						<td>Cut-off date for bid submission</td>
						<td><input type="text" name="txt_cutoffsubdate" size="12"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("CUT_OFF_DATED_SUBMISSION"))%>"
							onblur="checkDate(this);checkmindate(this,currentDate)"/>
							<a alt="Select date from calender"
													href="#" onClick="callCalender('txt_cutoffsubdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>

					</tr>

					<tr>
						<td nowrap="nowrap">Pincode<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_permzip" size="12"
							class="finaclefieldsbgcolor" maxlength="6"
							value="<%=Helper.correctNull((String) hshValues
									.get("BANKER_PINCODE"))%>"
							tabindex="8" style="text-align: left" onKeyPress="allowInteger()"
							onBlur=""></td>
							
							<td>District<b><span class="mantatory">&nbsp;*</span></b></td>
						<td><input type="text" name="txt_benfDistrict" value="<%=Helper.correctNull((String) hshValues
							.get("txtbanker_district"))%>">
						<a href="#" onClick="callDistrict();" style="cursor: hand"
							tabindex="14"> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"> </a></td>
							
							
										
							
							
							
							
							
							<td>	Valid for (No of Days)<b><span
							class="mantatory">*</span></b></td>
								<td><input type="text" name="txt_valdays"
									size="13" maxlength="13" style="background: #efddec;text-align: right"
									value="<%=Helper.correctNull((String) hshValues.get("BANK_VALID_DAYS"))%>"></td>	
							
							
							<td>Indent Number</td>
						<td><input type="text" name="txt_indentno" size="12"
							tabindex="16" onKeyPress="allowNumber(this)"
							value="<%=Helper.correctNull((String) hshValues.get("Indent_Number"))%>"
							/>&nbsp;</td>
							

					</tr>


					<tr>
						<td>Country<span class="mantatory">*</span></td>
						<td><input type="text" name="txtperapp_country"
							class="finaclefieldsbgcolor" size="25" maxlength="15"
							value="<%=Helper.correctNull((String) hshValues
							.get("txtperapp_country"))%>"
							tabindex="9" style="text-align: left"
							onKeyPress="allowAlphabets();"> <input type="hidden"
							name="hidperapp_country"
							value="<%=Helper.correctNull((String) hshValues
									.get("BANKER_COUNTRY"))%>">

						</td>
						<!--  <td>Validity of Tender</td>
						<td><input type="text" name="txt_valoftender" size="12"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("Validity_of_Tender"))%>"
							onblur="checkDate(this);checkminequaldate(this,currentDate)""/>
							<a alt="Select date from calender"
													href="#" onClick="callCalender('txt_valoftender')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>-->
													
									
									<td>Tender Notification date<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_ten_not_date" size="12"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("Tender_Notification_date"))%>"
							onblur="checkDate(this);checkmaxdate(this,currentDate)" />
							<a alt="Select date from calender"
													href="#" onClick="callCalender('txt_ten_not_date')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
										
										
									<td>Tender Opening date<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_tenopendate" size="12"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("Tender_Opening_date"))%>"
							onblur="checkDate(this);checkmindate(this,currentDate)"  />
							<a alt="Select date from calender"
													href="#" onClick="callCalender('txt_tenopendate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>				
							
											
					</tr>
					<tr>
					<td>Total Active Sanction Limit</td>
						<td><input type="text" name="txt_count" size="12"
							tabindex="3"
							value="<%=Helper.correctNull((String) hshValues.get("ACTCOUNT"))%>"
							 readonly style="background: #efddec;text-align: right">&nbsp;&nbsp;
							 <input type="text" name="txt_sanlim" size="20"
							tabindex="3"
							value="<%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("ACTNETWORTH"))))%>"
							 readonly style="background: #efddec;text-align: right"/></td>
							 
<!--					<td>Applied For<span
							class="mantatory">*</span></td>
						<td><select name="sel_sanctionfor" style="width: 200px" onchange="getcomssioncharges();">
							<option value="0">&lt;--Select--&gt;</option>
							<lapschoice:StaticDataNewTag apptype="244" />
						</select></td>-->

<td></td>
<td></td>					
						
						
							
						<td>Issue Date</td>
						<td><input type="text" name="txt_issuedt" size="12"
							tabindex="16"
							value="<%=Helper.correctNull((String) hshValues.get("BANKER_DATE"))%>"
							onblur="checkDate(this);"  />&nbsp;</td>
							</tr>
							
							<tr>
							<td>Total Expired Sanction Limit</td>
						<td><input type="text" name="txt_expcount" size="12"
							tabindex="3"
							value="<%=Helper.correctNull((String) hshValues.get("EXPCOUNT"))%>"
							 readonly style="background: #efddec;text-align: right">&nbsp;&nbsp;
							 <input type="text" name="txt_explim" size="20"
							tabindex="3"
							value=" <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("EXPNETWORTH"))))%>"
							 readonly style="background: #efddec;text-align: right"/>&nbsp;</td>
							<td nowrap="nowrap">Work Order/Contract Details
<span
							class="mantatory">*</span></td>
						<td nowrap="nowrap"><textarea rows="3" cols="45" tabindex="8"
							style="text-align: left" name="txt_breifworkdet" onKeyUp="textlimit(this,127)" onkeyPress="notAllowSplChar1(this);textlimit(this,127)"
							><%=Helper.correctNull((String) hshValues.get("BANKER_BRIEF_WORKORDER"))%></textarea></td>
						<td nowrap="nowrap">Sanctioning Department<span
							class="mantatory"><b>*</b></span></td>
						<td>
						<table width="40%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td><select name="sel_SancDept"
									onchange="funsanctiondept('s');">
									<option value="s">--Select--</option>
									<lapschoice:CBSStaticDataNewTag apptype="26" />
								</select></td>
								<td id="idsanbranch"><select name="sel_SancBranch">
									<option value="">--Select--</option>
								</select></td>
							</tr>
						</table>
						</td>
						
						</tr>
						
						<tr>
						<td></td>
						<td></td>
							<td>Sanctioning Authority<span class="mantatory"><b>*</b></span></td>
						<td><select name="sel_SancAuth" style="width: 200px;"
							onChange="funsancrefno()">
							<option value="">--Select--</option>
							<lapschoice:CBSStaticDataNewTag apptype="15" />
						</select></td>
						<td id="sanrefno">Sanction Reference No.<b><span
							class="mantatory">*</span></b></td>
						<td id="sanrefval"><input type="text" name="txt_sancrefno"
							size="37" maxlength="25"
							value="<%=Helper.correctNull((String) hshValues.get("BANKER_SANC_REF_NO"))%>"></td>
							</tr>
							<tr>
							<td></td>
							<td></td>
							
						<td id="sancdate1">Sanction date <b><span
							class="mantatory">*</span></b></td>
						<td id="sancdate2"><input type="text" name="sanctiondate"
							maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentDate);"
							size="12" onKeyPress="notAllowSplChar()"
							value="<%=Helper.correctNull((String) hshValues.get("BANKER_SANCTION_DATE"))%>">
						  &nbsp;<a alt="Select date from calender" href="#"
							onClick="callCalender2()"
							onMouseOver="window.status='Date Picker';return true;"
							onMouseOut="window.status='';return true;"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"
							alt="Select date from calender" align="middle"></a></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Report"
	btnenable='<%=Helper.correctNull((String) session
							.getAttribute("strBtnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<iframe height="0"
	width="0" name="ifrmsancauthority" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" name="ifrmsancbranch" frameborder="0"
	style="border: 0"></iframe> <input type="hidden" name="hididvalue"/>
<input type="hidden" name="strUserClass" value="<%=Helper.correctNull((String) hshValues.get("strUserClass"))%>"> 
<input type="hidden"
	name="hidSo"> <input type="hidden" name="cattype"
	value="<%=strCategoryType%>"> <input type="hidden"
	name="hidcity"
	value="<%=Helper.correctNull((String) hshValues
							.get("perapp_city_code"))%>">
<input type="hidden" name="hidstate"
	value="<%=Helper.correctNull((String) hshValues
							.get("perapp_state_code"))%>">
<input type="hidden" name="hidid"
	VALUE="<%=Helper.correctNull((String) request
									.getParameter("hidid"))%>">
 <input
	type="hidden" name="txt_loantype"
	value="<%=Helper.correctNull((String) hshValues
									.get("BANKER_LOANTYPE"))%>">

			<input type="hidden" name="hidapplno"
	value="<%=Helper.correctNull((String) hshValues
									.get("BANKER_APPL_NO"))%>">																															
<input type="hidden" name="hidapplname"
	value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_APPLICANT_NAME"))%>">
<input type="hidden" name="hidapplholder"
	value="<%=Helper.correctNull((String) hshValues
							.get("BANKER_APPLNHOLDER"))%>">
<input type="hidden" name="hidapplrecfrom"
	value="<%=Helper.correctNull((String) hshValues.get("BANKER_USRID"))%>">
<input type="hidden" name="hidappstatus"
	value="<%=Helper.correctNull((String) hshValues.get("BANKER_STATUS"))%>">
<input type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String) hshValues.get("strAppid"))%>">
<input type="hidden" name="hidOrgname"
	value="<%=Helper.correctNull((String) hshValues.get("BANKERORG_NAME"))%>">
<input type="hidden" name="hidAvailFlg"
	value="<%=Helper.correctNull((String) hshValues
							.get("strDataAvlFlag"))%>">
<input type="hidden" name="btnenable" value="<%=strBtnenable%>">
<input type="hidden" name="hid_City" value="<%=Helper.correctNull((String)hshValues.get("BANKER_BENF_CITY"))%>">
<input type="hidden" name="hid_State" value="<%=Helper.correctNull((String)hshValues.get("BANKER_BENF_STATE"))%>">
<input type="hidden" name="hid_District" value="<%=Helper.correctNull((String)hshValues.get("BANKER_BENF_DISTRICT"))%>">
<input type="hidden" name="hidstrappstatus" value="<%=Helper.correctNull((String)hshValues.get("BANKER_STATUS"))%>"/>
<input type="hidden" name="txt_usrid" value="<%=Helper.correctNull((String)hshValues.get("strUserId"))%>"> 


<iframe height="0" width="0" id="ifrmcheckduplicate" frameborder="0"	style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrmcheckcharges" frameborder="0"	style="border: 0"></iframe>
</form>
</body>
</HTML>
