function calcincdeduc()
	{
	var saltype=document.forms[0].incometype.value;
	
	if(saltype=="1")
		{		
		if(document.forms[0].txtperinc_deduction1.value=="NaN")
			{
			document.forms[0].txtperinc_deduction1.value="0.00";
			}
		if(document.forms[0].txtperinc_monsalary.value=="NaN")
			{
			document.forms[0].txtperinc_monsalary.value="0.00";
			}
		if(document.forms[0].txtperinc_rent.value=="")
			{
			document.forms[0].txtperinc_rent.value="0.00";
			} 
		if(document.forms[0].txtperinc_agriculture.value=="")
				{
				document.forms[0].txtperinc_agriculture.value="0.00";
				}
		if(document.forms[0].txtperinc_others.value=="")
				{
				document.forms[0].txtperinc_others.value="0.00";
				}
		if(document.forms[0].txtperinc_autoloanexp.value=="")
				{
				document.forms[0].txtperinc_autoloanexp.value="0.00";
				}
		if(document.forms[0].txtperinc_domexp.value=="")
				{
				document.forms[0].txtperinc_domexp.value="0.00";
				}
		if(document.forms[0].txtperinc_rentexp.value=="")
				{
				document.forms[0].txtperinc_rentexp.value="0.00";
				}
		if(document.forms[0].txtperinc_otherexp.value=="")
				{
				document.forms[0].txtperinc_otherexp.value="0.00";
				}
		var rent=parseFloat(document.forms[0].txtperinc_rent.value);
		var agri=parseFloat(document.forms[0].txtperinc_agriculture.value);
		var othrinc=parseFloat(document.forms[0].txtperinc_others.value);
		var loan=parseFloat(document.forms[0].txtperinc_autoloanexp.value);
		var ins=parseFloat(document.forms[0].txtperinc_domexp.value);
		var othrdeduc1=parseFloat(document.forms[0].txtperinc_rentexp.value);
		var othrdeduc2=parseFloat(document.forms[0].txtperinc_otherexp.value);
		var grossmth=parseFloat(document.forms[0].txtperinc_monsalary.value);
		var deducmth=parseFloat(document.forms[0].txtperinc_deduction1.value);
		
		var takemth=grossmth-deducmth;
		var otherdeduc=loan+ins+othrdeduc1+othrdeduc2;
		var otherincome=rent+agri+othrinc;
		var netincome=takemth-otherdeduc+otherincome;
		
		document.forms[0].txtperinc_Yearlysalary.value=(grossmth)*12;
		document.forms[0].txtperinc_yeardeduction.value=(deducmth)*12;
		document.forms[0].txt_otherdeduction.value=otherdeduc;
		document.forms[0].txtperinc_yearotherdedec.value=(otherdeduc)*12;
		document.forms[0].txtperinc_otherincome.value=otherincome;
		document.forms[0].txtperinc_yearotherincome.value=(otherincome)*12;
		document.forms[0].txtperinc_totincome.value=netincome;
		document.forms[0].txtperinc_yeartotalincome.value=(netincome)*12;
		document.forms[0].txtperinc_total.value=(otherdeduc);
		document.forms[0].txtperinc_othertotal.value=(otherincome);
		document.forms[0].txtperinc_deduc.value=takemth;
		document.forms[0].txtperinc_yearnetincome.value=(takemth)*12;
		}
	if(saltype=="2")
		{
		if(document.forms[0].txtperinc_Yearlysalary.value=="NaN")
			{
			document.forms[0].txtperinc_Yearlysalary.value="0.00";
			}
		if(document.forms[0].txtperinc_yeardeduction.value=="NaN")
			{
			document.forms[0].txtperinc_yeardeduction.value="0.00";
			}
		if(document.forms[0].txtperinc_rent.value=="")
			{
			document.forms[0].txtperinc_rent.value="0.00";
			}
		if(document.forms[0].txtperinc_agriculture.value=="")
				{
				document.forms[0].txtperinc_agriculture.value="0.00";
				}
		if(document.forms[0].txtperinc_others.value=="")
				{
				document.forms[0].txtperinc_others.value="0.00";
				}
		if(document.forms[0].txtperinc_autoloanexp.value=="")
				{
				document.forms[0].txtperinc_autoloanexp.value="0.00";
				}
		if(document.forms[0].txtperinc_domexp.value=="")
				{
				document.forms[0].txtperinc_domexp.value="0.00";
				}
		if(document.forms[0].txtperinc_rentexp.value=="")
				{
				document.forms[0].txtperinc_rentexp.value="0.00";
				}
		if(document.forms[0].txtperinc_otherexp.value=="")
				{
				document.forms[0].txtperinc_otherexp.value="0.00";
				}
		var rent=parseFloat(document.forms[0].txtperinc_rent.value);
		var agri=parseFloat(document.forms[0].txtperinc_agriculture.value);
		var othrinc=parseFloat(document.forms[0].txtperinc_others.value);
		var loan=parseFloat(document.forms[0].txtperinc_autoloanexp.value);
		var ins=parseFloat(document.forms[0].txtperinc_domexp.value);
		var othrdeduc1=parseFloat(document.forms[0].txtperinc_rentexp.value);
		var othrdeduc2=parseFloat(document.forms[0].txtperinc_otherexp.value);
		var grossyr=parseFloat(document.forms[0].txtperinc_Yearlysalary.value);
		var deducyr=parseFloat(document.forms[0].txtperinc_yeardeduction.value);
				
		var takeyr=grossyr-deducyr;
		
		var otherdeduc=loan+ins+othrdeduc1+othrdeduc2;
		
		var otherincome=rent+agri+othrinc;
		
		var netincome=takeyr-otherdeduc+otherincome;
		
		document.forms[0].txtperinc_monsalary.value=(grossyr)/12;
		document.forms[0].txtperinc_deduction1.value=(deducyr)/12;
				
		document.forms[0].txtperinc_deduc.value=(takeyr)/12;
		document.forms[0].txtperinc_yearnetincome.value=eval(takeyr);
		
		
		document.forms[0].txt_otherdeduction.value=(otherdeduc)/12;
		document.forms[0].txtperinc_yearotherdedec.value=(otherdeduc);
		
		
		document.forms[0].txtperinc_otherincome.value=eval(otherincome)/12;
		document.forms[0].txtperinc_yearotherincome.value=eval(otherincome);
		
		
		document.forms[0].txtperinc_totincome.value=(netincome)/12;
		document.forms[0].txtperinc_yeartotalincome.value=(netincome);
		
		
		document.forms[0].txtperinc_total.value=(otherdeduc);
		
		
		document.forms[0].txtperinc_othertotal.value=(otherincome);
				
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
		if(document.forms[0].txtperinc_deduction1.value=="NaN")
			{
			document.forms[0].txtperinc_deduction1.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_deduction1);
			}
		if(document.forms[0].txtperinc_monsalary.value=="NaN")
			{
			document.forms[0].txtperinc_monsalary.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_monsalary.value);
			}
		if(document.forms[0].txtperinc_deduction1.value=="NaN")
			{
			document.forms[0].txtperinc_deduction1.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_deduction1);
			}
		if(document.forms[0].txtperinc_othertotal.value=="NaN")
			{
			document.forms[0].txtperinc_othertotal.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_othertotal);
			}
		if(document.forms[0].txtperinc_total.value=="NaN")
			{
			document.forms[0].txtperinc_total.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_total);
			}
		if(document.forms[0].txtperinc_totincome.value=="NaN")
			{
			document.forms[0].txtperinc_totincome.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_totincome);
			}
		if(document.forms[0].txtperinc_yeartotalincome.value=="NaN")
			{
			document.forms[0].txtperinc_yeartotalincome.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_yeartotalincome);
			}
		if(document.forms[0].txtperinc_otherincome.value=="NaN")
			{
			document.forms[0].txtperinc_otherincome.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_otherincome);
			}
		if(document.forms[0].txtperinc_yearotherincome.value=="NaN")
			{
			document.forms[0].txtperinc_yearotherincome.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_yearotherincome);
			}
		if(document.forms[0].txt_otherdeduction.value=="NaN")
			{
			document.forms[0].txt_otherdeduction.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txt_otherdeduction);
			}
		if(document.forms[0].txtperinc_yearotherdedec.value=="NaN")
			{
			document.forms[0].txtperinc_yearotherdedec.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_yearotherdedec);
			}
		if(document.forms[0].txtperinc_deduc.value=="NaN")
			{
			document.forms[0].txtperinc_deduc.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_deduc);
			}
		if(document.forms[0].txtperinc_yearnetincome.value=="NaN")
			{
			document.forms[0].txtperinc_yearnetincome.value="0.00";
			}
		else
			{
			roundtxt(document.forms[0].txtperinc_yearnetincome);
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
	/*if(perinc_selfincometype1!="")
	{
		document.forms[0].choperinc_selfincometype.value=perinc_selfincometype1;
	}
	else
	{
		document.forms[0].choperinc_selfincometype.value="0";;
	}*/
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
		document.forms[0].incpattern.value="0";;
	}
	if(incproofval!="")
	{
		document.forms[0].incproof.value=incproofval;
	}
	else
	{
		document.forms[0].incproof.value="0";;
	}
	if(incloyalty!="")
	{
		document.forms[0].cbo_loyalty.value=incloyalty;
	}
	else
	{
		document.forms[0].cbo_loyalty.value="0";;
	}
	if(inchistory!="")
	{
		document.forms[0].cbo_history.value=inchistory;
	}
	else
	{
		document.forms[0].cbo_history.value="0";;
	}
	if(varinctype!=""){
	document.forms[0].incometype.value=varinctype;
	}
	else{
	document.forms[0].incometype.value="0";
	}
		
	disableControls(true,true,true,true,false);	
		
	
	
	callDisable(true);
} 



function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdEdit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;
	document.forms[0].cmdDelete.disabled=bcmdDelete;
	document.forms[0].cmdCancel.disabled=bcmdCancel;
	document.forms[0].cmdClose.disabled=bcmdClose;
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
		
	}
		
}

function dohlp()     
{
  var hlpvar = appURL+"phlp/loan_appretail_appincomandexp.htm";
  var title = "IncomeAndExpenses";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function gototab(beanid,methodname,pagename)
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
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