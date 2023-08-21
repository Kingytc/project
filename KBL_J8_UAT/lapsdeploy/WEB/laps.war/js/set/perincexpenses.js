function calcincdeduc()
{
	var saltype=document.forms[0].incometype.value;
	
	if(saltype=="1")
	{		
		var rent=document.forms[0].txtperinc_rent.value;
		var agri=document.forms[0].txtperinc_agriculture.value;
		var capgain=document.forms[0].txtperinc_capitalgain.value;
		var othrinc=document.forms[0].txtperinc_others.value;
		var loan=document.forms[0].txtperinc_autoloanexp.value;
		var ins=document.forms[0].txtperinc_domexp.value;
		var othrdeduc1=document.forms[0].txtperinc_rentexp.value;
		var othrdeduc2=document.forms[0].txtperinc_otherexp.value;
		var grossmth=document.forms[0].txtperinc_monsalary.value;
		var deducmth=document.forms[0].txtperinc_deduction1.value;
		
		if(rent=="")rent=0;
		if(agri=="")agri=0;
		if(capgain=="")capgain=0;
		if(othrinc=="")othrinc=0;
		if(loan=="")loan=0;
		if(ins=="")ins=0;
		if(othrdeduc1=="")othrdeduc1=0;
		if(othrdeduc2=="")othrdeduc2=0;
		if(grossmth=="")grossmth=0;
		if(deducmth=="")deducmth=0;
		
		var takemth=eval(grossmth)-eval(deducmth);
		var otherdeduc=eval(loan)+eval(ins)+eval(othrdeduc1)+eval(othrdeduc2);
		var otherincome=eval(rent)+eval(agri)+eval(capgain)+eval(othrinc);
		var netincome=eval(takemth)-eval(otherdeduc)+eval(otherincome);
		
		document.forms[0].txtperinc_Yearlysalary.value=eval(grossmth)*12;
		document.forms[0].txtperinc_yeardeduction.value=eval(deducmth)*12;
		document.forms[0].txt_otherdeduction.value=otherdeduc;
		document.forms[0].txtperinc_yearotherdedec.value=eval(otherdeduc)*12;
		document.forms[0].txtperinc_otherincome.value=otherincome;
		document.forms[0].txtperinc_yearotherincome.value=eval(otherincome)*12;
		document.forms[0].txtperinc_totincome.value=netincome;
		document.forms[0].txtperinc_yeartotalincome.value=eval(netincome)*12;
		document.forms[0].txtperinc_total.value=eval(otherdeduc);
		document.forms[0].txtperinc_othertotal.value=eval(otherincome);
		document.forms[0].txtperinc_deduc.value=takemth;
		document.forms[0].txtperinc_yearnetincome.value=(takemth)*12;
	}
	if(saltype=="2")
	{
		var rent=document.forms[0].txtperinc_rent.value;
		var agri=document.forms[0].txtperinc_agriculture.value;
		var capgain=document.forms[0].txtperinc_capitalgain.value;
		var othrinc=document.forms[0].txtperinc_others.value;
		var loan=document.forms[0].txtperinc_autoloanexp.value;
		var ins=document.forms[0].txtperinc_domexp.value;
		var othrdeduc1=document.forms[0].txtperinc_rentexp.value;
		var othrdeduc2=document.forms[0].txtperinc_otherexp.value;
		var grossyr=document.forms[0].txtperinc_Yearlysalary.value;
		var deducyr=document.forms[0].txtperinc_yeardeduction.value;
			
		if(rent=="")rent=0;
		if(agri=="")agri=0;
		if(capgain=="")capgain=0;
		if(othrinc=="")othrinc=0;
		if(loan=="")loan=0;
		if(ins=="")ins=0;
		if(othrdeduc1=="")othrdeduc1=0;
		if(othrdeduc2=="")othrdeduc2=0;
		if(grossyr=="")grossyr=0;
		if(deducyr=="")deducyr=0;
			
		var takeyr=eval(grossyr)-eval(deducyr);
		
		var otherdeduc=eval(loan)+eval(ins)+eval(othrdeduc1)+eval(othrdeduc2);
		
		var otherincome=eval(rent)+eval(agri)+eval(capgain)+eval(othrinc);
		
		var netincome=eval(takeyr)-eval(otherdeduc)+eval(otherincome);
		
		document.forms[0].txtperinc_monsalary.value=eval(grossyr)/12;
		document.forms[0].txtperinc_deduction1.value=eval(deducyr)/12;
				
		document.forms[0].txtperinc_deduc.value=eval(takeyr)/12;
		document.forms[0].txtperinc_yearnetincome.value=eval(takeyr);
		
		document.forms[0].txt_otherdeduction.value=eval(otherdeduc)/12;
		document.forms[0].txtperinc_yearotherdedec.value=eval(otherdeduc);
		
		document.forms[0].txtperinc_otherincome.value=eval(otherincome)/12;
		document.forms[0].txtperinc_yearotherincome.value=eval(otherincome);
		
		document.forms[0].txtperinc_totincome.value=eval(netincome)/12;
		document.forms[0].txtperinc_yeartotalincome.value=eval(netincome);
		
		document.forms[0].txtperinc_total.value=eval(otherdeduc);
		document.forms[0].txtperinc_othertotal.value=eval(otherincome);
	}
	if(saltype=="0")
	{
		return;
	}
	if(document.forms[0].txtperinc_monsalary.value=="NaN")
	{
		document.forms[0].txtperinc_monsalary.value="0.00";
	}
	else
	{
		roundtxt(document.forms[0].txtperinc_monsalary);
	}
	if(document.forms[0].txtperinc_Yearlysalary.value=="NaN")
	{
		document.forms[0].txtperinc_Yearlysalary.value="0.00";
	}
	else
	{
		roundtxt(document.forms[0].txtperinc_Yearlysalary);
	}
	if(document.forms[0].txtperinc_yeardeduction.value=="NaN")
	{
		document.forms[0].txtperinc_yeardeduction.value="0.00";
	}
	else
	{
		roundtxt(document.forms[0].txtperinc_yeardeduction);
	}
	
	if(document.forms[0].txtperinc_monsalary.value=="NaN")
	{
		document.forms[0].txtperinc_monsalary.value="0.00";
	}
	else
	{
		roundtxt(document.forms[0].txtperinc_monsalary.value);
	}
	roundtxt(document.forms[0].txtperinc_deduction1);
	roundtxt(document.forms[0].txtperinc_othertotal);
	roundtxt(document.forms[0].txtperinc_total);
	roundtxt(document.forms[0].txtperinc_totincome);
	roundtxt(document.forms[0].txtperinc_yeartotalincome);
	roundtxt(document.forms[0].txtperinc_otherincome);
	roundtxt(document.forms[0].txtperinc_yearotherincome);
	roundtxt(document.forms[0].txt_otherdeduction);
	roundtxt(document.forms[0].txtperinc_yearotherdedec);
	roundtxt(document.forms[0].txtperinc_deduc);
	roundtxt(document.forms[0].txtperinc_yearnetincome);
}

function focus1()
{
	document.forms[0].txtperinc_deduction1.focus();
}
	
function focus2()
{
	document.forms[0].txtperinc_yeardeduction.focus();
}

function callEmployerMedic()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployerMedic";
			document.forms[0].action=appURL+"action/incexpmedic.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}


function callFinancial()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(document.forms[0].txtperapp_appid.value))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/per_fin_stat.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}
	
function callonLoad()
{	
	if(vardoc!="")
	{
		document.forms[0].sel_documents.value=vardoc;
	}
	else
	{
		document.forms[0].sel_documents.value="";
	}
	if(perinc_itreturn=='Y')
	{
		document.forms[0].cboitreturn.value="Y";
	}
	else
	{
		document.forms[0].cboitreturn.value="N";
	}

	if(perinc_assetandliab=='Y')
	{
		document.forms[0].cboassetliability.value="Y";
	}
	else
	{
		document.forms[0].cboassetliability.value="N";  
	} 

	if(incpatternval!="")
	{
		document.forms[0].incpattern.value=incpatternval;
	}
	else
	{
		document.forms[0].incpattern.value="0";
	}
	if(incproofval!="")
	{
		document.forms[0].incproof.value=incproofval;
	}
	else
	{
		document.forms[0].incproof.value="0";
	}
	/*if(incloyalty!="")
	{
		document.forms[0].cbo_loyalty.value=incloyalty;
	}
	else
	{
		document.forms[0].cbo_loyalty.value="0";
	}
	if(inchistory!="")
	{
		document.forms[0].cbo_history.value=inchistory;
	}
	else
	{
		document.forms[0].cbo_history.value="0";
	}*/
	if(varinctype!="")
	{
		document.forms[0].incometype.value=varinctype;
	}
	else
	{
		document.forms[0].incometype.value="0";
	}
		
	callDisable(true);
	if(varemploystatus == '1'||varemploystatus == '9')
	{
		document.all.id_span.style.visibility="hidden";
		document.all.id_span.style.position="absolute";
		document.all.id_primaryinc.style.visibility="visible";
		document.all.id_primaryinc.style.position="relative";
	}
	else
	{
		document.all.id_span.style.visibility="visible";
		document.all.id_span.style.position="relative";
		document.all.id_primaryinc.style.visibility="hidden";
		document.all.id_primaryinc.style.position="absolute";
	}
	
	if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,false);
	}
	else
	{
		if(appstatus=="true")
		{
			disableControls(true,true,true,false);
		}
		else
		{
			disableControls(false,true,true,false);
		}
	}
} 
 
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function doSave()
{   
	/*if(document.forms[0].cbo_loyalty.value=="0")
	{
		alert("Choose Length of Relationship with the bank ");
		document.forms[0].cbo_loyalty.focus();
		return;
	}	
	if(document.forms[0].cbo_history.value=="0")
	{
		alert("Choose Record of Repayment");
		document.forms[0].cbo_history.focus();
		return;
	}	
	if(document.forms[0].incproof.value=="0")
	{
		alert("Choose Income Tax Details");
		document.forms[0].incproof.focus();
		return;
	}*/
		if(document.forms[0].sel_documents.value=="")
		{	alert("Select Income Support Documents");
		document.forms[0].sel_documents.focus();
		return;
		}
	if(varemploystatus == '1'){
		if(document.forms[0].incometype.value=="0")
		{
			alert("Select Primary Income Type ");
			document.forms[0].incometype.focus();
			return;
		}
		if(document.forms[0].incometype.value == "1"){
			if(document.forms[0].txtperinc_monsalary.value=="" || document.forms[0].txtperinc_monsalary.value=="0.00"){
				alert("Employee's gross income shouldn't be Zero");
				return;
			}
		}else if(document.forms[0].incometype.value == "2"){
			if(document.forms[0].txtperinc_Yearlysalary.value=="" || document.forms[0].txtperinc_Yearlysalary.value=="0.00"){
				alert("Employee's gross income shouldn't be Zero");
				return;
			}
		}
		if(document.forms[0].incproof.value=="0")
		{
			alert("Choose Income Tax Details");
			document.forms[0].incproof.focus();
			return;
		}
	}else if(varemploystatus == '9'){
		if(document.forms[0].incometype.value=="0")
		{
			alert("Select Primary Income Type ");
			document.forms[0].incometype.focus();
			return;
		}
		if(document.forms[0].incometype.value == "1"){
			if(document.forms[0].txtperinc_monsalary.value=="" || document.forms[0].txtperinc_monsalary.value=="0.00"){
				alert("Pensioner's gross income shouldn't be Zero");
				return;
			}
		}else if(document.forms[0].incometype.value == "2"){
			if(document.forms[0].txtperinc_Yearlysalary.value=="" || document.forms[0].txtperinc_Yearlysalary.value=="0.00"){
				alert("Pensioner's gross income shouldn't be Zero");
				return;
			}
		}
		if(document.forms[0].incproof.value=="0")
		{
			alert("Choose Income Tax Details");
			document.forms[0].incproof.focus();
			return;
		}
	}
	else
	{
		if(document.forms[0].incproof.value=="0")
		{
			alert("Choose Income Tax Details");
			document.forms[0].incproof.focus();
			return;
		}
		if((document.forms[0].txt_yearincome1.value==""
			||document.forms[0].txt_yearincome1.value=="0.00"
				||document.forms[0].txt_yearincome1.value=="0")
		 &&(document.forms[0].txt_yearincome2.value==""
			||document.forms[0].txt_yearincome2.value=="0.00"
				||document.forms[0].txt_yearincome2.value=="0"))
		{
			alert("Income as per ITR/FS/Declaration shouldn't be Zero");
			document.forms[0].txt_yearincome1.focus();
			return;
		}
		document.forms[0].incometype.value="1";
	}
	
	if(varemploystatus=="1" || varemploystatus=="9"){
		document.forms[0].hidPerappIncome.value=document.forms[0].txtperinc_yeartotalincome.value;
	}
	else{
		document.forms[0].hidPerappIncome.value=document.forms[0].txt_yearincome1.value;
	}
	document.forms[0].txtperinc_monsalary.readOnly=false;
	document.forms[0].txtperinc_deduction1.readOnly=false;		
	document.forms[0].txtperinc_deduc.readOnly=false;		
	document.forms[0].txt_otherdeduction.readOnly=false;		
	document.forms[0].txtperinc_otherincome.readOnly=false;		
	document.forms[0].txtperinc_totincome.readOnly=false;

	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidAction.value="insert";

	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateIncome";
	document.forms[0].hidBeanGetMethod.value="getIncome";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/perincexpenses.jsp?applnt=P";
	document.forms[0].submit();
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdApply.disabled)
	{
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

function doEdit() 
{
	callDisable(false);
	disableControls(true,false,false,true);
	callIncomeEnable();
	document.forms[0].hideditflag.value="Y";
	document.forms[0].incometype.focus();
	
}

function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
		  document.forms[0].elements[i].readOnly=one;
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
	document.forms[0].txtperinc_deduc.readOnly=true;
	document.forms[0].txtperinc_yearnetincome.readOnly=true;		
	document.forms[0].txt_otherdeduction.readOnly=true;
	document.forms[0].txtperinc_yearotherdedec.readOnly=true;
	document.forms[0].txtperinc_otherincome.readOnly=true;
	document.forms[0].txtperinc_yearotherincome.readOnly=true;		
	document.forms[0].txtperinc_totincome.readOnly=true;	
	document.forms[0].txtperinc_yeartotalincome.readOnly=true;
	document.forms[0].txtperinc_othertotal.readOnly=true;
	document.forms[0].txtperinc_total.readOnly=true;
}

function callDemographics()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getDemographics";
			if(document.forms[0].hidModuleName.value=="T")
				document.forms[0].action=appURL+"action/ops_applicant.jsp?applnt=T";
			else
				document.forms[0].action=appURL+"action/perapplicant.jsp?applnt=P";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{
			if(document.forms[0].hidModuleName.value == 'T'){
				
				document.forms[0].hidBeanGetMethod.value="getEmployer";
				document.forms[0].action=appURL+"action/peremployer.jsp?applnt=T";
				document.forms[0].submit();
				
			}else{
				
				document.forms[0].hidBeanGetMethod.value="getEmployer";
				document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
				document.forms[0].submit();
			}
		}
	}
	else
	{
		ShowAlert('103');
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		if(document.forms[0].hidModuleName.value=='T')
		{
			document.forms[0].action=appURL+"action/agrappmastersearch.jsp";	
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/mastersearchper.jsp";
			document.forms[0].submit();
		}
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url) 
{	
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;	
	document.forms[0].action=url;
	document.forms[0].submit();	
}

function dohlp()     
{
  	var hlpvar = appURL+"phlp/loan_appretail_custpro_incomandexp.htm";
  	var title = "IncomeAndExpenses";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function callIncomeEnable()
{
	if(document.forms[0].incometype.value=="1")
	{	 
		document.forms[0].txtperinc_monsalary.readOnly=false;
		document.forms[0].txtperinc_deduction1.readOnly=false;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;
	}
	else if(document.forms[0].incometype.value=="2")
	{
		document.forms[0].txtperinc_monsalary.readOnly=true;
		document.forms[0].txtperinc_deduction1.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=false;
		document.forms[0].txtperinc_yeardeduction.readOnly=false;
	}
	else
	{
		document.forms[0].txtperinc_monsalary.readOnly=true;
		document.forms[0].txtperinc_deduction1.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;
	}
}

function checkPanno()
{
	 if(varpanno=="")
	 {
		if(document.forms[0].incproof.value=="1")
		{	
			alert("Pan No. Not Filled in the Demographics  Page Please Filled the no");
			return;
		}
	}	
}

function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"action/set_KYCNorms.jsp";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callCalender(controlname)
{
	if(document.forms[0].cmdedit.disabled)
	{
		showCal(appURL,controlname);
	}
}
