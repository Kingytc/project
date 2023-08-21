function calcincdeduc()
{
	var saltype=document.forms[0].incometype.value;
	
	if(saltype=="1")
	{		
		var rent=document.forms[0].txtperinc_rent.value;
		var agri=document.forms[0].txtperinc_agriculture.value;
		var othrinc=document.forms[0].txtperinc_others.value;
		var loan=document.forms[0].txtperinc_autoloanexp.value;
		var ins=document.forms[0].txtperinc_domexp.value;
		var othrdeduc1=document.forms[0].txtperinc_rentexp.value;
		var othrdeduc2=document.forms[0].txtperinc_otherexp.value;
		var grossmth=document.forms[0].txtperinc_monsalary.value;
		var deducmth=document.forms[0].txtperinc_deduction1.value;
		
		if(rent=="")rent=0;
		if(agri=="")agri=0;
		if(othrinc=="")othrinc=0;
		if(loan=="")loan=0;
		if(ins=="")ins=0;
		if(othrdeduc1=="")othrdeduc1=0;
		if(othrdeduc2=="")othrdeduc2=0;
		if(grossmth=="")grossmth=0;
		if(deducmth=="")deducmth=0;
		
		var takemth=eval(grossmth)-eval(deducmth);
		var otherdeduc=eval(loan)+eval(ins)+eval(othrdeduc1)+eval(othrdeduc2);
		var otherincome=eval(rent)+eval(agri)+eval(othrinc);
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
		var othrinc=document.forms[0].txtperinc_others.value;
		var loan=document.forms[0].txtperinc_autoloanexp.value;
		var ins=document.forms[0].txtperinc_domexp.value;
		var othrdeduc1=document.forms[0].txtperinc_rentexp.value;
		var othrdeduc2=document.forms[0].txtperinc_otherexp.value;
		var grossyr=document.forms[0].txtperinc_Yearlysalary.value;
		var deducyr=document.forms[0].txtperinc_yeardeduction.value;
			
		if(rent=="")rent=0;
		if(agri=="")agri=0;
		if(othrinc=="")othrinc=0;
		if(loan=="")loan=0;
		if(ins=="")ins=0;
		if(othrdeduc1=="")othrdeduc1=0;
		if(othrdeduc2=="")othrdeduc2=0;
		if(grossyr=="")grossyr=0;
		if(deducyr=="")deducyr=0;
			
		var takeyr=eval(grossyr)-eval(deducyr);
		
		var otherdeduc=eval(loan)+eval(ins)+eval(othrdeduc1)+eval(othrdeduc2);
		
		var otherincome=eval(rent)+eval(agri)+eval(othrinc);
		
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

function callDemographics()
{
	var applnt=document.forms[0].applntype.value;
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{
		
		document.forms[0].hidAppType.value="";
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}


function callEmployer()
{
	var applnt=document.forms[0].applntype.value;
	
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployerdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}


function callKYCNorms()
{
	if(document.forms[0].hideditflag.value=="N")
	{
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="getKYCNormsdetails";
			document.forms[0].action=appURL+"action/perkycnormsdisp.jsp";
			document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callonLoad()
{	

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

	if(varinctype!="")
	{
		document.forms[0].incometype.value=varinctype;
	}
	else
	{
		document.forms[0].incometype.value="0";
	}
		
	callDisable(true);	
} 



function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;
	document.forms[0].cmdDelete.disabled=bcmdDelete;
	document.forms[0].cmdCancel.disabled=bcmdCancel;
	document.forms[0].cmdClose.disabled=bcmdClose;
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

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdapply.disabled)
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
		document.forms[0].txtperinc_total.readOnly=true;
		document.forms[0].txtperinc_othertotal.readOnly=true;
		document.forms[0].txtperinc_deduc.readOnly=true;
		document.forms[0].txtperinc_totincome.readOnly=true;
		document.forms[0].txtperinc_otherincome.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;		
		document.forms[0].txtperinc_yearnetincome.readOnly=true;		
		document.forms[0].txtperinc_yearotherdedec.readOnly=true;		
		document.forms[0].txtperinc_yearotherincome.readOnly=true;		
		document.forms[0].txtperinc_yeartotalincome.readOnly=true;
}




function checktakehome()
{
	var val1=NanNumber(parseFloat(document.forms[0].txtperinc_monsalary.value));
	var val2=NanNumber(parseFloat(document.forms[0].txtperinc_deduction1.value));

	if(eval(val2)>eval(val1))
	{
		ShowAlert('105','takehome');
		document.forms[0].txtperinc_deduction1.focus();
		return false;
	}
}

function callIncomeEnable(){
	if(document.forms[0].incometype.value=="1"){
		document.forms[0].txtperinc_monsalary.readOnly=true;
		document.forms[0].txtperinc_deduction1.readOnly=true;
		document.forms[0].txt_otherdeduction.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;
		document.forms[0].txtperinc_yearotherdedec.readOnly=true;
		//document.forms[0].txtperinc_othertotal.value=document.forms[0].txtperinc_otherincome.value;
		
	}
	else if(document.forms[0].incometype.value=="2"){
		document.forms[0].txtperinc_monsalary.readOnly=true;
		document.forms[0].txtperinc_deduction1.readOnly=true;
		document.forms[0].txt_otherdeduction.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;
		document.forms[0].txtperinc_yearotherdedec.readOnly=true;
		//document.forms[0].txtperinc_othertotal.value=document.forms[0].txtperinc_yearotherincome.value;
		
	}else{
		document.forms[0].txtperinc_monsalary.readOnly=true;
		document.forms[0].txtperinc_deduction1.readOnly=true;
		document.forms[0].txt_otherdeduction.readOnly=true;
		document.forms[0].txtperinc_Yearlysalary.readOnly=true;
		document.forms[0].txtperinc_yeardeduction.readOnly=true;
		document.forms[0].txtperinc_yearotherdedec.readOnly=true;
		
	}
	
}

function showDedc(val)
{
	if(val=="y")
	{
		document.all.dover.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.dover.style.visibility="hidden";
	}	
}

function showTotDedc(val)
{
	if(val=="y")
	{
		document.all.dover2.style.visibility="visible";
	}
	else if(val =="n")
	{
		document.all.dover2.style.visibility="hidden";
	}
}