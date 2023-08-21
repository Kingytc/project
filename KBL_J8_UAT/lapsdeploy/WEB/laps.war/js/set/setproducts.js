function placeValues()
{
	if(strprd_code=="")
	{
		document.forms[0].prd_code.value="New";
		document.forms[0].prd_intro_date.value=curDate;
		document.forms[0].prd_mod_date.value=curDate;
		
		document.forms[0].cmdedit.disabled=true;
	 	document.forms[0].cmddelete.disabled=true;
	 	document.forms[0].cmdrenew.disabled=true;
	 	document.forms[0].cmdcopy.disabled=true;	//Added By Zahoorunnisa.s to copy the product
		document.forms[0].cmdclose.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdsave.disabled=false;
		//document.forms[0].cmdstaffloanparameters.disabled=true;
		disableFields(false);
		//document.forms[0].prd_type1.focus();
		document.forms[0].hidAction.value="insert";
		changeLoanType();
		showGoldDepFields("","");
		return;
		
		
	}
	document.forms[0].prdCode.value=strprd_code;
	document.forms[0].prd_type.value=strprd_type;
	document.forms[0].prd_type1.value=strprd_type.charAt(0);
	document.forms[0].prd_stop.value=strprd_stop;
	/*if(strincomeflag == "1")
	{
		document.forms[0].prd_incomeflag.value=strincomeflag;
	}
	else if(strincomeflag == "2")
	{
		document.forms[0].prd_incomeflag.value=strincomeflag;
	}
	else
	{
		document.forms[0].prd_incomeflag.value="0";
	}*/
	document.forms[0].seltermid.value=terms_id;
	document.forms[0].selid.value=buss_id;
	document.forms[0].prd_loantype.value=strloantype;
	document.forms[0].sel_bankscheme.value=sel_bankscheme_name;
	/*if(strnsccheck=="1")
	{
		document.forms[0].nsc_check.checked=true;
	}
	else
	{
		document.forms[0].nsc_check.checked=false;
	}*/
	if(strStaffloancheck!="")
	{
		document.forms[0].sel_staffloan.value=strStaffloancheck;
	}
	if(strhomepluscheck!="")
	{
		document.forms[0].sel_homeplus.value=strhomepluscheck;
	}
	if(strprd_type == "pE")
	{
		if(strhomepluscheck!="")
		{
			document.forms[0].sel_splscheme.value=strhomepluscheck;
		}
	}
	/*if(varselinternet!="")
	{
		document.forms[0].sel_internet.value=varselinternet;
	}*/
	document.forms[0].schemecodeid1.value=strscheme_code;
	document.forms[0].sel_schemetype.value=strSchemeType;
	document.forms[0].sel_whetheragri.value=strWhetherAgri;
	document.forms[0].selintrate.value=sel_intrate;
	changeLoanType();	
	document.forms[0].prd_type2.value=strprd_type.charAt(1);
	disableFields(true);
	selectValues();
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdclose.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=false;
	document.forms[0].cmdrenew.disabled=true;
	document.forms[0].cmdcopy.disabled=false;//Added By Zahoorunnisa.s to copy the product
	document.forms[0].cmdcancel.disabled=true;
	
	if(document.forms[0].prd_principal.value!="" && document.forms[0].prd_interest.value!="")
	{
		//document.forms[0].cmdstaffloanparameters.disabled=false;
	}
	else
	{
		//document.forms[0].cmdstaffloanparameters.disabled=true;
	}
	document.forms[0].prdCode.value=document.forms[0].prd_code.value;
	document.forms[0].schCode.value=document.forms[0].hidSchemeCode.value;
	
	//document.forms[0].prdType.value=document.forms[0].prd_type2.options[document.forms[0].prd_type2.selectedIndex].text;
	
	if(document.forms[0].prd_type1.value=="p")
	{
		document.forms[0].prdType.value="Retail";
	}
	else if(document.forms[0].prd_type1.value=="a")
	{
		document.forms[0].prdType.value="Agriculture";
	}
	if(document.forms[0].prd_saveflag.value=='c')
	{
	 	document.forms[0].prdStatus.value="Complete";
	}
	else
	{
		document.forms[0].prdStatus.value="Partial";
	}
	document.forms[0].prdCat.value=document.forms[0].catname.value;
	document.forms[0].prdSubCat.value=document.forms[0].scatname.value;
	document.forms[0].prdRangeFrom.value=document.forms[0].prd_rng_from.value;
	document.forms[0].prdRangeTo.value=document.forms[0].prd_rng_to.value;
	document.forms[0].prdTerm.value=document.forms[0].prd_term.value;
	document.forms[0].prdminTerm.value=document.forms[0].prd_minterm.value;
	showGoldDepFields(document.forms[0].prd_type1.value,document.forms[0].prd_type2.value);
	if(staff_under !=""){
		document.forms[0].selstaffloan_under.value=staff_under;
	}else{
		document.forms[0].selstaffloan_under.value="S";
	}
	if(buss_ruleid !=""){
		document.forms[0].sel_busruleid.value=buss_ruleid;
	}else{
		document.forms[0].sel_busruleid.value="S";
	}
	if(vardeposittype !=""){
		document.forms[0].sel_deposittype.value=vardeposittype;
	}else{
		document.forms[0].sel_deposittype.value="s";
	}
	if(vardepositloanfor !=""){
		document.forms[0].sel_loanfor.value=vardepositloanfor;
	}else{
		document.forms[0].sel_loanfor.value="s";
	}
	selstaffstatus();
	
	var str_type=document.forms[0].hidRepaymentType.value;
	var str_type_temp =str_type.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		var selValue=str_type_temp[i];
	
		if("1"==selValue)	
		{		
			document.forms[0].sel_repaymenttype.options[0].selected=true;
		}			
		else if("2"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[1].selected=true;
		}
		else if("12"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[2].selected=true;
		}
		else if("8"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[3].selected=true;
		}			
		else if("13"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[4].selected=true;
		}
		else if("14"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[5].selected=true;
		}
		
	}
	str_type=document.forms[0].hidInterestType.value;
	str_type_temp =str_type.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		for(var j=0;j<document.forms[0].sel_interesttype.length;j++)
		{
			if(document.forms[0].sel_interesttype.options[j].value==str_type_temp[i])
			{
				document.forms[0].sel_interesttype.options[j].selected=true;
			}
		}
	}
	
	if(varPrdShareType!="")
	{
		document.all.loan_again_share.value = varPrdShareType;
	}else
	{
		document.all.loan_again_share.value="";

	}
	
	if(varPRDWHTDIGIPRD!="")
	{
		document.forms[0].sel_whtDigiProduct.value = varPRDWHTDIGIPRD;
	}
	else
	{
		document.forms[0].sel_whtDigiProduct.value="N";
	}
	if(varPRDCGTMSEFALG!="")
	{
		document.forms[0].sel_CGTMSE.value = varPRDCGTMSEFALG;
	}
	else
	{
		document.forms[0].sel_CGTMSE.value="S";
	}
	
	checkloanshare();	
}

function callNew()
{
	if(prd_choose == "New")
	{
		 //cmdeditValues();
		// document.forms[0].prd_type1.focus();
		 document.forms[0].cmdclose.disabled=false;
	}
} 
 
function doEdit()
{
 	document.forms[0].cmdedit.disabled=true;
 	if(document.forms[0].prd_code.value!="New")
 	{
	 	document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdrenew.disabled=true;
		document.forms[0].cmdcopy.disabled=true;//Added By Zahoorunnisa.s to copy the product
    }		
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdsave.disabled=false;
	//document.forms[0].cmdstaffloanparameters.disabled=true;
	disableFields(false);
	//document.forms[0].prd_type1.focus();
	document.forms[0].hidAction.value="update";
	document.forms[0].catname.readOnly=true;
	document.forms[0].scatname.readOnly=true;
	funforsuvidha('N');
	
	if(document.forms[0].checkApp.value=="Yes")
	{
		disableFields(true);
		document.forms[0].sel_interesttype.disabled=false;
	}
	document.forms[0].prd_mintermrest.readOnly=false;
	 document.forms[0].prd_termrest.readOnly=false;
	 document.forms[0].txtprd_holidayrest.readOnly=false;
}

function callCategoryHelp(catid)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		return;
	}
	if((!document.forms[0].cmdedit.disabled) && document.forms[0].prd_code.value!="New")
	{
		 return;
	}
	if(trim(catid)=="")
	{
		ShowAlert(111,"category");
		return;
	}
    var prop = "scrollbars=no,width=450,height=370, top=100, left=200";
	var url=appURL+"action/categorylist.jsp?cat_id="+catid;
	window.open(url,"",prop);
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
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
	
	 //document.forms[0].prd_eff_date.readOnly=true;
	 document.forms[0].prd_mod_date.readOnly=true;
	 document.forms[0].prd_intro_date.readOnly=true;
	 document.forms[0].prd_code.readOnly=true;
	 
	 document.forms[0].catname.readOnly = true;
	 document.forms[0].scatname.readOnly = true;
	 if(document.forms[0].prd_saveflag.value=='c')
	 {
		 document.forms[0].prd_type1.disabled=true;
		 document.forms[0].prd_type2.disabled=true;
		 document.forms[0].sel_bankscheme.disabled=true;
		 document.forms[0].sel_purpose_of_loan.disabled=true;
	 }
}

function changeLoanType()
{	 
 	if(document.forms[0].prd_type1.value.toUpperCase()=="A")
 	{
	 	document.forms[0].prd_type2.length=22;
	 	document.forms[0].prd_type2.options[1] = new Option('Poultry Boiler','A');
	 	document.forms[0].prd_type2.options[2] = new Option('Bullock Cart','B');
        document.forms[0].prd_type2.options[3] = new Option('Crop Loans','C');
        document.forms[0].prd_type2.options[4] = new Option('Diary Farming','D');
        document.forms[0].prd_type2.options[5] = new Option('Animal Rearing','E');
        document.forms[0].prd_type2.options[6] = new Option('Farm Machinery','F');
        document.forms[0].prd_type2.options[7] = new Option('Gobar Gas Plant','G');
        document.forms[0].prd_type2.options[8] = new Option('Gold Loan','H');
        document.forms[0].prd_type2.options[9] = new Option('Consumption Loan','I');
        document.forms[0].prd_type2.options[10] = new Option('Sericulture','J');
        document.forms[0].prd_type2.options[11] = new Option('Loan Against Warehouse Receipts','L');
        document.forms[0].prd_type2.options[12] = new Option('Vehicle Loan','M');
        document.forms[0].prd_type2.options[13] = new Option('Fisheries','N');
        document.forms[0].prd_type2.options[14] = new Option('Poultry Layering','P');
        document.forms[0].prd_type2.options[15] = new Option('Plantation Term Loan','Q');
        document.forms[0].prd_type2.options[16] = new Option('Loan Against deposit','R');
		document.forms[0].prd_type2.options[17] = new Option('Minor Irrigation','U');
		document.forms[0].prd_type2.options[18] = new Option('Common Product','K');
		document.forms[0].prd_type2.options[19] = new Option('Union General Crcmdedit Card','V');
		document.forms[0].prd_type2.options[20] = new Option('Purchase of fodder','T');
		document.forms[0].prd_type2.options[21] = new Option('Union Bhumiheen Card','W');
        document.forms[0].prd_type2.options[22] = new Option('Coffee Plantation','O'); 
		document.forms[0].sel_staffloan.value="N";
		showratios();

     }
  	if(document.forms[0].prd_type1.value.toUpperCase()=="P")
	{
		document.forms[0].prd_type2.length=18;
		document.forms[0].prd_type2.options[1] = new Option('Housing Loan','H');
		document.forms[0].prd_type2.options[2] = new Option('Salaried Person','P');
		document.forms[0].prd_type2.options[3] = new Option('Vehicle Loan','A');
		//document.forms[0].prd_type2.options[4] = new Option('Consumer Durables Loan','D');
		document.forms[0].prd_type2.options[4] = new Option('Mortgage Loan','M');
        //document.forms[0].prd_type2.options[7] = new Option('Health Loan','I');
        document.forms[0].prd_type2.options[5] = new Option('Gold Loan','G');
       // document.forms[0].prd_type2.options[9] = new Option('Top Up','T');
        //document.forms[0].prd_type2.options[10] = new Option('Smiles Loan','O');
        document.forms[0].prd_type2.options[6] = new Option('Loan against Deposits','R');
        document.forms[0].prd_type2.options[7] = new Option('Mahila Udyog','U');
        document.forms[0].prd_type2.options[8] = new Option('Ravi Kiran','K');
        document.forms[0].prd_type2.options[9] = new Option('Education Loan','E');
        document.forms[0].prd_type2.options[10] = new Option('Leased Loan','L');
        document.forms[0].prd_type2.options[11] = new Option('Instacash Loan','I');
        document.forms[0].prd_type2.options[12] = new Option('Clean Loan','C');
        document.forms[0].prd_type2.options[13] = new Option('NSC Loan','N');
        document.forms[0].prd_type2.options[14] = new Option('Suvidha','V');
        document.forms[0].prd_type2.options[15] = new Option('General Loan','J');
        document.forms[0].prd_type2.options[16] = new Option('Loan Against Shares','S');
        document.forms[0].prd_type2.options[17] = new Option('Business Quick Loan','B');
       // showratios();
 	}
}

function doSave()
{
	 
	 if(document.forms[0].prd_type2.value=="S" && document.forms[0].loan_again_share.value == "")
	 {
		 alert("Select the Type of Share");
		 document.forms[0].loan_again_share.focus();
		 return;
	 }
	 if(document.forms[0].prd_type2.value!="S")
	 {
		document.forms[0].loan_again_share.value = "";
	 }
	
	var boolVal1=document.forms[0].prd_type1.value;
	var boolVal2=document.forms[0].prd_type2.value
	 if(document.forms[0].prd_type2.selectedIndex==0)
	 {
		ShowAlert(111,"Product For");
		document.forms[0].prd_type2.focus();
		return;
	 }
	 if(document.forms[0].prd_loantype.selectedIndex==0)
	 {
		 ShowAlert(111,"Type of Loan");
		 document.forms[0].prd_loantype.focus();
		 return;
	 }
	 if(document.forms[0].sel_bankscheme.selectedIndex==0)
	 {
		 ShowAlert(111,"Bank's Scheme");
		 document.forms[0].sel_bankscheme.focus();
		 return;
	 }
	 if(strprd_type!=null)
	 {
		 if(strprd_type=="pH" || document.forms[0].prd_type2.value=="H") 
		 {
			 if(document.forms[0].sel_purpose_of_loan.value=="0")
			 {
			 ShowAlert(111,"Purpose of Loan");
			 document.forms[0].sel_purpose_of_loan.focus();
			 return;
			 }
		 }
		
		 if(strprd_type=="pA" || document.forms[0].prd_type2.value=="A") 
		 {
			 if(document.forms[0].sel_vehicletype.value=="0")
			 {
			 ShowAlert(111,"Type of Vehicle");
			 document.forms[0].sel_vehicletype.focus();
			 return;
			 }
		 }
		 if(strprd_type=="pE" || document.forms[0].prd_type2.value=="E") 
		 {
			
			 if(document.forms[0].sel_edu_loan.value=="S")
			 {
			 ShowAlert(111,"Purpose of Loan");
			 document.forms[0].sel_edu_loan.focus();
			 return;
			 }
		 }
		 
	 }
	
	 if(document.forms[0].prd_term.value=="" || eval(document.forms[0].prd_term.value)<=0) 
	 {
		 ShowAlert(154,"Maximum Repayment Period");
		 var temp = document.forms[0].prd_term.value;
		 document.forms[0].prd_term.value="";
		 document.forms[0].prd_term.focus();
		 return;
	 }	 
	 if(document.forms[0].prd_minterm.value=="" || eval(document.forms[0].prd_minterm.value)<=0)
	 {
	  	 ShowAlert(154,"Minimum Repayment Period");
		 document.forms[0].prd_minterm.value="";
		 document.forms[0].prd_minterm.focus();
		 return;
	 }
	 if(eval(document.forms[0].prd_term.value)<= eval(document.forms[0].prd_minterm.value))
	  {
	  	 ShowAlert(153,"Minimum Repayment Period","Maximum Repayment Period");
	  	 document.forms[0].prd_minterm.value="";
		 document.forms[0].prd_minterm.focus();
		 return;
	 }
	 if(document.forms[0].prd_type1.value=="c" && document.forms[0].prd_type2.selectedIndex==0)
	 {
		 ShowAlert(111,"Type of Loan");
		 document.forms[0].prd_type2.focus();
		 return;
	 }
	 if(document.forms[0].catname.value=="")
	 {
		 ShowAlert(111,"Category");
		 return;
	 }
	 if(document.forms[0].scatname.value=="")
	 {
		 ShowAlert(111,"Subcategory");
		 return;
	 }	
	 if(trim(document.forms[0].prd_rng_from.value)=="" || eval(document.forms[0].prd_rng_from.value)<=0)
	 {
		 ShowAlert(112,"Range from value");
		 document.forms[0].prd_rng_from.focus();
		 return;
	 }
	 if(trim(document.forms[0].prd_rng_to.value)=="")
	 {
		 ShowAlert(112,"Range to value");
		 document.forms[0].prd_rng_to.focus();
		 return;
	 }
	 document.forms[0].prd_rng_to.value=trim(document.forms[0].prd_rng_to.value);
	 if(document.forms[0].prd_rng_to.value!="" && eval(document.forms[0].prd_rng_from.value)>=eval(document.forms[0].prd_rng_to.value))
	 {
		 ShowAlert(115,"Range to value","range from value");
		 document.forms[0].prd_rng_to.select();
		 document.forms[0].prd_rng_to.focus();
		 return;
	 }
	 if(eval(document.forms[0].maxnonmetro.value)>eval(document.forms[0].prd_rng_to.value))
	 {
		 alert("Max Non-Metro value Should be given with in Product Range");
		 document.forms[0].maxnonmetro.select();
		 document.forms[0].maxnonmetro.focus();
		 return;
	 }
	 if(eval(document.forms[0].maxmetro.value)>eval(document.forms[0].prd_rng_to.value))
	 {
		alert("Max Metro value Should be given with in Product Range");
		 document.forms[0].maxmetro.select();
		 document.forms[0].maxmetro.focus();
		 return;
	 }
     document.forms[0].prd_desc.value=trim(document.forms[0].prd_desc.value);
	 if(document.forms[0].prd_desc.value=="")
	 {
		 ShowAlert(112,"product description");
		 document.forms[0].prd_desc.focus();
		 return;
	 }
	 if(document.forms[0].selid.value=="" || document.forms[0].selid.value=="0")
	 {
		 ShowAlert(111,"Whether Rating");
		 document.forms[0].selid.focus();
		 return;
	 }
	 if(document.forms[0].seltermid.value=="" || document.forms[0].seltermid.value=="-")
	 {
		 ShowAlert(111,"Terms and Conditions");
		 document.forms[0].seltermid.focus();
		 return;
	 }
	 document.forms[0].prd_eff_date.value=trim(document.forms[0].prd_eff_date.value);
	 if(document.forms[0].prd_eff_date.value=="")
	 {
		 ShowAlert(112,"Product effective date");
		 document.forms[0].prd_eff_date.focus();
		 return;
	 }
	 checkValidmindate();
	/* if(document.forms[0].sel_staffloan.value=="Y")
	 {
		if(document.forms[0].prd_principal.value=="" && document.forms[0].prd_interest.value=="")
		{
			 ShowAlert(112,"Repayment Ratio(Principal:Interest) ");
			  return;
		}
	}*/
	//added by Karthikeyan.S for making Scheme Code Mandatory
	 if(document.forms[0].prd_loantype.value!="")
	 {
		 if(trim(document.forms[0].schemecodeid1.value)=="S"||trim(document.forms[0].schemecodeid1.value)=="")
		 {
			 ShowAlert(111,"Scheme Code");
			 document.forms[0].schemecodeid1.focus();
			 return;
		 }
	 }
	if(boolCheckDep(boolVal1,boolVal2)==true)
	{
		if(document.forms[0].prd_addintrate.value=="0.00"||document.forms[0].prd_addintrate.value==""||document.forms[0].prd_addintrate.value==null)
		{
			ShowAlert(121,"Additional Interest Rate to be accumulated");
			document.forms[0].prd_addintrate.focus();
			return;
		}
	}
	if((boolCheckGold(boolVal1,boolVal2)==true)||(boolCheckDep(boolVal1,boolVal2)==true))
	{
		if(document.forms[0].sel_whetheragri.value=="")
		{
			ShowAlert(111,"Whether this product comes under Agriculture scheme");
			document.forms[0].sel_whetheragri.focus();
			return;
		}
	}
	//added by Kamal for making Valid upto date Mandateory
	 if(document.forms[0].prd_validupto_date.value=="")
	 {
		 ShowAlert(112,"Valid upto");
		 document.forms[0].prd_validupto_date.focus();
		 return;
	 }
	 if((strprd_type=="pA" || document.forms[0].prd_type2.value=="A" ||strprd_type=="pH" || document.forms[0].prd_type2.value=="H")&& document.forms[0].sel_staffloan.value=="Y")
	 {
		 if(document.forms[0].txt_repaytprincipal_staff.value=="" || eval(document.forms[0].txt_repaytprincipal_staff.value)<=0)
		 {
		 ShowAlert(121,"Maximum period for Repay the Principal");
		 document.forms[0].txt_repaytprincipal_staff.focus();
		 return;
		 }
		 if(document.forms[0].txt_repaytinterest_staff.value=="" || eval(document.forms[0].txt_repaytinterest_staff.value)<=0)
		 {
		 ShowAlert(121,"Maximum period for Repay the Interest");
		 document.forms[0].txt_repaytinterest_staff.focus();
		 return;
		 }
		 var varTotal=parseInt(document.forms[0].txt_repaytprincipal_staff.value)+parseInt(document.forms[0].txt_repaytinterest_staff.value);
		 var varTenor=eval(document.forms[0].prd_term.value);
		 if(eval(varTotal)>eval(varTenor))
		 {
			 alert("Sum of Maximum Repayment period of Principal and Interest should not exceed the Total Tenor Period");
			 return;
		 }
	 }
	 
	 if(!checkDate(document.forms[0].prd_eff_date))
		 return;
	 
	 var str_type ="";
		for(var i=0;i<document.forms[0].sel_repaymenttype.options.length;i++)
		{
			if(document.forms[0].sel_repaymenttype.options[i].selected)
			{				
				str_type=str_type+document.forms[0].sel_repaymenttype.options[i].value+"@";
			}		
		}
		
		if(str_type=="")
		{
			alert("Select the Repayment Type");
			return false;
		}
		
		if(strprd_type=="pR" || document.forms[0].prd_type2.value=="R") 
		{
			if(document.forms[0].sel_deposittype.value=="s")
			{
				 ShowAlert(111,"Deposit Type");
				 document.forms[0].sel_deposittype.focus();
				 return;
			}
			if(document.forms[0].sel_deposittype.value=="F" && document.forms[0].sel_loanfor.value=="s")
			{
				 ShowAlert(111,"Loan for");
				 document.forms[0].sel_loanfor.focus();
				 return;
			}
		}
		
		 if(strprd_type=="pU" || document.forms[0].prd_type2.value=="U") 
		 {
			 if(document.forms[0].sel_ProAppFor.value=="S")
			 {
				 ShowAlert(111,"Product Applicable For ");
				 document.forms[0].sel_ProAppFor.focus();
				 return;
			 }
			 
			 if(document.forms[0].sel_ProAppFor.value=="V")
			 {
				 if(document.forms[0].sel_VehiType.value=="0")
				 {
					 ShowAlert(111,"Whether Old or New Vehicle is required ");
					 document.forms[0].sel_VehiType.focus();
					 return;
				 }
			 }
			 
		 }
		 
	document.forms[0].hidRepaymentType.value=str_type;
	
	str_type ="";
	for(var i=0;i<document.forms[0].sel_interesttype.options.length;i++)
	{
		if(document.forms[0].sel_interesttype.options[i].selected)
		{				
			str_type=str_type+document.forms[0].sel_interesttype.options[i].value+"@";
		}		
	}
	
	if(str_type=="")
	{
		alert("Select Interest Type");
		return false;
	}
	if(document.forms[0].selid.value=="NR" && str_type.indexOf("RATING@")!=-1)
	{
		alert("Rating Interest type is not applicable");
		return;
	}
	if(document.forms[0].prd_termrest.value=="" || eval(document.forms[0].prd_termrest.value)<=0) 
	 {
		 ShowAlert(154,"Maximum Repayment Period");
		 var temp = document.forms[0].prd_term.value;
		 document.forms[0].prd_termrest.value="";
		 document.forms[0].prd_termrest.focus();
		 return;
	 }	 
	 if(document.forms[0].prd_mintermrest.value=="" || eval(document.forms[0].prd_mintermrest.value)<=0)
	 {
	  	 ShowAlert(154,"Minimum Repayment Period");
		 document.forms[0].prd_mintermrest.value="";
		 document.forms[0].prd_mintermrest.focus();
		 return;
	 }
	 if(eval(document.forms[0].prd_termrest.value)<= eval(document.forms[0].prd_mintermrest.value))
	  {
	  	 ShowAlert(153,"Minimum Repayment Period","Maximum Repayment Period");
	  	 document.forms[0].prd_mintermrest.value="";
		 document.forms[0].prd_mintermrest.focus();
		 return;
	 }
	 if(document.forms[0].sel_CGTMSE.value=="S")
	 {
		 ShowAlert(112,"Mandatory CGTMSE");
		 document.forms[0].sel_CGTMSE.focus();
		 return;
	 }
	document.forms[0].hidInterestType.value=str_type;
	
	 document.forms[0].prd_mod_date.value=curDate;
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmddelete.disabled=true;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].cmdclose.disabled=true;
	 document.forms[0].prd_loantype.disabled=false;
	 
	 document.forms[0].prd_type.value=document.forms[0].prd_type1.value;
 	 document.forms[0].prd_type.value+=document.forms[0].prd_type2.value;
	 var selid = document.forms[0].selid.value;
	 document.forms[0].hidselid.value = document.forms[0].selid.value;
	 document.forms[0].hidtermid.value = document.forms[0].seltermid.value;
	 /*var prd_incomeflag1 = document.forms[0].prd_incomeflag.value;
	 if(prd_incomeflag1 == "1")
	 {
			alert("Eligibility based on Income for this Product will be calculated based on Net Income");	 	 
	 }
	 else if(prd_incomeflag1 == "0")
	 {
			alert("Eligibility based on Income for this Product will be calculated based on Gross Income");
	 }
	 else
	 {
	 		alert("Eligibility based on  Income for this Product will be calculated based on Both (Gross Income & Net Income)");
	 }
	 if(document.forms[0].nsc_check.checked==true)
	 {
	 	document.forms[0].nsc_check.value="1";
	 }
	 if(document.forms[0].nsc_check.checked==false)
	 {
	 	document.forms[0].nsc_check.value="0";
	 }*/
	
	var len = document.forms[0].selid.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].selid.options[i].selected==true)
		 {
			 document.forms[0].selid1.value = document.forms[0].selid.options[i].text; 
			break;
		 }
	}
	
	var len1 = document.forms[0].prd_type2.length;	
	for(i=0;i<len1;i++)
	{
		 if(document.forms[0].prd_type2.options[i].selected==true)
		 {
			 document.forms[0].prd_type3.value = document.forms[0].prd_type2.options[i].text; 
			break;
		 }
	}
	disableFields(false);
	document.forms[0].prd_type1.disabled=false;
	document.forms[0].prd_type2.disabled=false;
	document.forms[0].sel_bankscheme.disabled=false;
	document.forms[0].sel_purpose_of_loan.disabled=false;
	
	
	if(document.forms[0].prd_code.value=="New")
	{
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidBeanGetMethod.value="updateData";
		document.forms[0].action=appURL+"action/setproducts.jsp";
		//document.forms[0].hidSourceUrl.value="/action/setproducts.jsp";
	 }
	 else
	 {
	 	document.forms[0].hidBeanMethod.value="updateData";
	 	document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setproducts.jsp";
		document.forms[0].action=appURL+"controllerservlet";
	 }
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].submit();
}

function callCalender()
{
	if(document.forms[0].cmdedit.disabled)
		showCal(appURL,'prd_eff_date');
}
function callCalender1(fname)
 {
 	if(document.forms[0].cmdedit.disabled)
		showCal(appURL,fname);
 }
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(145))
		{
		 	var selid = document.forms[0].selid.value;
		 	document.forms[0].hidselid.value = selid.substring(0,selid.indexOf('^'));
		 	
			var len = document.forms[0].selid.length;	
				for(i=0;i<len;i++)
				{
					 if(document.forms[0].selid.options[i].selected==true)
					 {
						 document.forms[0].selid1.value = document.forms[0].selid.options[i].text; 
						break;
					 }
				}
			var len1 = document.forms[0].prd_type2.length;	
			for(i=0;i<len1;i++)
			{
				 if(document.forms[0].prd_type2.options[i].selected==true)
				 {
					 document.forms[0].prd_type3.value = document.forms[0].prd_type2.options[i].text; 
					break;
				 }
			}	
		 	document.forms[0].cmddelete.disabled=true;
		 	document.forms[0].cmdsave.disabled=true;
		 	document.forms[0].hidAction.value="delete";
		 	document.forms[0].hidBeanMethod.value="updateData";
		 	document.forms[0].hidBeanId.value="setproducts";
		 	document.forms[0].hidSourceUrl.value="/action/setsearchproducts.jsp";
		 	document.forms[0].action=appURL+"controllerservlet";
		 	document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		if(document.forms[0].prd_code.value=="New")
		{
			document.forms[0].reset();
			document.forms[0].prd_code.value="New";
			document.forms[0].prd_intro_date.value=curDate;
			document.forms[0].prd_mod_date.value=curDate;
			document.forms[0].cmdedit.disabled=false;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;
			
			changeLoanType();
			disableFields(true);
		}
		else
		{
			placeValues();
		}
	}
}

function doClose()
{
	 if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/setsearchproducts.jsp";
		 document.forms[0].submit();
	 }
 }

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		
		if(val=="existing")
		{
		ShowAlert(144);
		}
		document.forms[0].cmdedit.disabled=false;
	}
}

/* Added By Karthikeyan.S to Show / Hide Fields based on the Loan Product */

function showGoldDepFields(varPrdFor,varUnder)
{
	showSchemeType(varPrdFor,varUnder);
	showAdIntRate(varPrdFor,varUnder);
	showWhetherAgri(varPrdFor,varUnder);
}

/* Added By Karthikeyan.S to Show Scheme Type for Gold Loan */

function showSchemeType(product,scheme)
{
	if(boolCheckGold(product,scheme)==true)
	{
		document.all.id_schemetypelbl.style.visibility="visible";
		document.all.id_schemetypelbl.style.position="relative";
		document.all.id_schemetypetxt.style.visibility="visible";
		document.all.id_schemetypetxt.style.position="relative";
	}
	else
	{
		document.forms[0].sel_schemetype.value="";
		document.all.id_schemetypelbl.style.visibility="hidden";
		document.all.id_schemetypelbl.style.position="absolute";
		document.all.id_schemetypetxt.style.visibility="hidden";
		document.all.id_schemetypetxt.style.position="absolute";
	}
}

/* Added By Karthikeyan.S to Show Additional Interest Rate for Deposit Loan */

function showAdIntRate(product,scheme)
{
	if(boolCheckDep(product,scheme)==true)
	{
		document.all.id_adintratelbl.style.visibility="visible";
		document.all.id_adintratelbl.style.position="relative";
		document.all.id_adintratetxt.style.visibility="visible";
		document.all.id_adintratetxt.style.position="relative";
	}
	else
	{
		document.all.id_adintratelbl.style.visibility="hidden";
		document.all.id_adintratelbl.style.position="absolute";
		document.all.id_adintratetxt.style.visibility="hidden";
		document.all.id_adintratetxt.style.position="absolute";
	}
}

/* Added By Karthikeyan.S to Show Whether the product comes under Agriculture scheme for Gold & Deposit Loan */

function showWhetherAgri(product,scheme)
{
	if((boolCheckDep(product,scheme)==true)||(boolCheckGold(product,scheme)==true))
	{
		document.all.id_whetheragrilbl.style.visibility="visible";
		document.all.id_whetheragrilbl.style.position="relative";
		document.all.id_whetheragritxt.style.visibility="visible";
		document.all.id_whetheragritxt.style.position="relative";
	}
	else
	{
		document.all.id_whetheragrilbl.style.visibility="hidden";
		document.all.id_whetheragrilbl.style.position="absolute";
		document.all.id_whetheragritxt.style.visibility="hidden";
		document.all.id_whetheragritxt.style.position="absolute";
	}
}

/* Added By Karthikeyan.S to Check Whether Gold Loan */

function boolCheckGold(product,scheme)
{
	if(((product.toUpperCase()=="P")&&(scheme.toUpperCase()=="G")) || ((product.toUpperCase()=="A")&&(scheme.toUpperCase()=="H")))
 	{
		return true;
	}
	else
	{
		return false;
	}
}

/* Added By Karthikeyan.S to Check Whether Deposit Loan */

function boolCheckDep(product,scheme)
{
	if((product.toUpperCase()=="P")&&(scheme.toUpperCase()=="R"))
 	{
		return true;
	}
	else
	{
		return false;
	}
}

//Added by Arsath on 19/12/2013 for Purpose of Loan/Type of Vehicle included in product page(Given by Prakash.N)
function showhidevehhomefields()
{
	document.all.homepurid1.style.visibility="hidden";
    document.all.homepurid1.style.position="absolute";
    document.all.homepurid2.style.visibility="hidden";
    document.all.homepurid2.style.position="absolute";
    document.all.vehtypeid1.style.visibility="hidden";
    document.all.vehtypeid1.style.position="absolute";
    document.all.vehtypeid2.style.visibility="hidden";
    document.all.vehtypeid2.style.position="absolute";
    document.all.edupurid1.style.visibility="hidden";
    document.all.edupurid1.style.position="absolute";
    document.all.edupurid2.style.visibility="hidden";
    document.all.edupurid2.style.position="absolute";
   
    if(strprd_type=="pH")
    {
	document.all.homepurid1.style.visibility = "visible";
	document.all.homepurid1.style.position	 = "relative";
	document.all.homepurid2.style.visibility = "visible";
	document.all.homepurid2.style.position	 = "relative";
    document.forms[0].sel_purpose_of_loan.value = varpurpose;
    }
    if(strprd_type=="pA")
    {
	document.all.vehtypeid1.style.visibility = "visible";
	document.all.vehtypeid1.style.position	 = "relative";
	document.all.vehtypeid2.style.visibility = "visible";
	document.all.vehtypeid2.style.position	 = "relative";
	document.forms[0].sel_vehicletype.value = varpurpose;
    }
    if(strprd_type=="pE")
    {
	document.all.edupurid1.style.visibility = "visible";
	document.all.edupurid1.style.position	 = "relative";
	document.all.edupurid2.style.visibility = "visible";
	document.all.edupurid2.style.position	 = "relative";
	document.forms[0].sel_edu_loan.value = varpurpose;
    }
    
    //End of Arsath
}

function enabledepositdetails()
{
	if(document.forms[0].sel_deposittype.value=="F")
	{
		document.all.iddeposittype3.style.display="table-row";
		document.all.iddeposittype4.style.display="table-row";
	}
	else
	{
		document.all.iddeposittype3.style.display="none";
		document.all.iddeposittype4.style.display="none";
	}
}