function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
	
function checkamt()
{
	var varloansub=document.forms[0].sub.value;
	var amtreqd=document.forms[0].txtloan_amtreqd.value;
	if(varloansub=="")
	{
		varloansub=0;
	}
	if(eval(amtreqd)<eval(varloansub))
	{
		alert("Subsidy Amount cannot be greater than Requested Loan Amount");
		document.forms[0].sub.value="";
		document.forms[0].sub.focus();
		return;
	}
}
	
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=bool;		  
		}		
	}
	document.forms[0].txtprd_desc.readOnly="true";
	document.forms[0].txtloan_intrate.readOnly="true";
	document.forms[0].txtloan_modintrate.readOnly="true";
	document.forms[0].txt_receivedRH.readOnly="true";
	document.forms[0].txtloan_filedon.readOnly="true";
	document.forms[0].txt_appinwardno.readOnly=true;
	document.forms[0].txt_repaycapacity.readOnly="true";
	document.forms[0].txtmarginoffered.readOnly="true";
	document.forms[0].txtmonPay.readOnly="true";
	document.forms[0].txtloan_docfee.readOnly="true";
	document.forms[0].txtloan_downpay.readOnly="true";
	document.forms[0].txtMarginpercent.readOnly="true";
	document.forms[0].txtloan_recmdamt.readOnly="true";
	document.forms[0].txtloan_sancamt.readOnly="true";
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		enableinterestcharge();
		disableDynamicFields();
	}
	else
	{
		document.forms[0].txtloan_costloanprd.readOnly=true;
	}
	document.forms[0].txt_schemecode.readOnly=true;
	
	if(document.forms[0].prd_type.value=="pL")
	{
		document.forms[0].txtloan_costloanprd.readOnly=true;
	}
	
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	var page=document.forms[0].page1.value;
	if(varconfirm)
	{
		if(page.toUpperCase()!="NR")
		{
			document.forms[0].radLoan.value="Y";
			document.forms[0].hidBeanGetMethod.value="getLoanProducts";
			document.forms[0].hidBeanId.value="perapplicant";
			if(document.forms[0].hidCategoryType.value=="LAD")
			{
				document.forms[0].action=appURL+"action/ladloandetails.jsp";	
			}
			else
			{
				document.forms[0].action=appURL+"action/perloandetails.jsp";	
			}
			document.forms[0].submit();
		}
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		var varconfirm=ConfirmMsg('101');
		if(varconfirm)
		{
			//document.forms[0].hidEditMode.value="D";
			document.forms[0].hidAction.value="delete";
			//document.forms[0].hidBeanMethod.value="updateLoanProducts";
			document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].action=appURL+"action/retailpge.jsp";	
			document.forms[0].submit();
		}
	}	
		else
		{
			ShowAlert(158);
		}
}

function doClose()
	{
	var con=ConfirmMsg('100');
	if(con)
		{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
		}
	}



function showRepayment()
{	
	if(document.forms[0].selectinttype.value < 5 )
	{
		if(document.forms[0].txtprd_desc.value == "")
		{
			ShowAlert('111',"Product");
			return;
		}
	/*	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
		if((checktrim(document.forms[0].txtloan_amtreqd.value)=="")||(varamtreqst=="0.00" && isNaN(varamtreqst)))
		{	
			ShowAlert('121',"Amount Requested");
			document.forms[0].txtloan_amtreqd.value="";
			document.forms[0].txtloan_amtreqd.focus();
			return false;
		}
		if(checktrim(document.forms[0].txtloan_reqterms.value)=="")
		{
			ShowAlert('121',"Term Requested");
			document.forms[0].txtloan_reqterms.focus();
			return false;
		}
		if(document.forms[0].selectinttype.value =="0")
		{
			ShowAlert('111',"Interest Type");
			return false;
		}*/
		//alert("Shahul  selrepaymenttype value====="+document.forms[0].selrepaymenttype.value);
		var repaymenttype = document.forms[0].selrepaymenttype.value;
		document.forms[0].hidrepayment.value = repaymenttype;
		var prdid   = document.forms[0].hidProductID.value;

		if(document.forms[0].selectinttype.value !="3")
		{
			if(document.forms[0].selrepaymenttype.value ==1 )
			{
			 	if(prdid!="")
				{
				 	if (document.forms[0].interestservised.value == "n")
				 	{
						document.forms[0].txtmonPay.value="";
						//document.all.calc1.style.visibility="hidden";
						//document.all.calc1.style.position="absolute";
						callCalculateInterest();
					}
					else
					{
						//document.all.calc1.style.visibility="visible";
						//document.all.calc1.style.position="relative";
						//document.all.calc2.style.visibility="visible";
						//document.all.calc2.style.position="relative";
						document.all.amort1.style.visibility="visible";
						document.all.amort1.style.position="relative";
						document.all.amort2.style.visibility="visible";
						document.all.amort2.style.position="relative";
					}
				}
			}
			else if(document.forms[0].selrepaymenttype.value == 2 )
			{
				if(prdid!="")
				{
					document.forms[0].txtmonPay.value="";
					//document.forms[0].txttotPayment.value="";	
					//document.all.calc1.style.visibility="hidden";
					//document.all.calc1.style.position="absolute";
					//document.all.calc2.style.visibility="hidden";
					//document.all.calc2.style.position="absolute";
					document.all.amort1.style.visibility="visible";
					document.all.amort1.style.position="relative";
					document.all.amort2.style.visibility="visible";
					document.all.amort2.style.position="relative";
				}
			}
			else if(document.forms[0].selrepaymenttype.value == 3)
			{
				if(prdid!="")
				{
					document.forms[0].txtmonPay.value="";
					//document.forms[0].txttotPayment.value="";
					//document.all.calc1.style.visibility="hidden";
					//document.all.calc1.style.position="absolute";
					
					//document.all.calc2.style.visibility="hidden";
					//document.all.calc2.style.position="absolute";
				}
			}
			else
			{
				document.forms[0].txtmonPay.value="";
				//document.forms[0].txttotPayment.value="";
				//document.all.calc1.style.visibility="hidden";
				//document.all.calc1.style.position="absolute";
				
				//document.all.calc2.style.visibility="hidden";
				//document.all.calc2.style.position="absolute";
			}
		}
	}
	/*else if(document.forms[0].selectinttype.value =="3")
	{
		//document.all.calc1.style.visibility="hidden";
		//document.all.calc2.style.visibility="hidden";
		document.all.amort2.style.visibility="hidden";
	} */
	var peridicity = trim(document.forms[0].sel_peridicity.value);
	var servised = trim(document.forms[0].interestservised.value);
	if (peridicity != "m" || servised != "y")
	{
		document.all.amort1.style.visibility="hidden";
		document.all.amort1.style.position="absolute";
		document.all.amort2.style.visibility="hidden";
		document.all.amort2.style.position="absolute";
	}
}

function showRepayment1()
{	
	if(document.forms[0].selectinttype.value < 5 )
	{
		var repaymenttype = document.forms[0].selrepaymenttype.value;
		document.forms[0].hidrepayment.value = repaymenttype;
		var prdid   = document.forms[0].hidProductID.value;

		if(document.forms[0].selectinttype.value !="3")
		{
			if(document.forms[0].selrepaymenttype.value ==1 )
			{
			 	if(prdid!="")
				{
				 	if (document.forms[0].interestservised.value == "n")
				 	{
						//document.forms[0].txtmonPay.value="";
						//document.all.calc1.style.visibility="hidden";
						//document.all.calc1.style.position="absolute";
						//callCalculateInterest();
					}
					else
					{
						//document.all.calc1.style.visibility="visible";
						//document.all.calc1.style.position="relative";
						
						//document.all.calc2.style.visibility="visible";
						//document.all.calc2.style.position="relative";
						
						document.all.amort1.style.visibility="visible";
						document.all.amort1.style.position="relative";
						
						document.all.amort2.style.visibility="visible";
						document.all.amort2.style.position="relative";
					}
				}
			}
			else if(document.forms[0].selrepaymenttype.value == 2 )
			{
				if(prdid!="")
				{
					//document.forms[0].txtmonPay.value="";
					//document.forms[0].txttotPayment.value="";	
					//document.all.calc1.style.visibility="hidden";
					//document.all.calc1.style.position="absolute";
					
					//document.all.calc2.style.visibility="hidden";
					//document.all.calc2.style.position="absolute";
					
					document.all.amort1.style.visibility="visible";
					document.all.amort1.style.position="relative";
					
					document.all.amort2.style.visibility="visible";
					document.all.amort2.style.position="relative";
				}
			}
			else if(document.forms[0].selrepaymenttype.value == 3)
			{
				if(prdid!="")
				{
					//document.forms[0].txtmonPay.value="";
					//document.forms[0].txttotPayment.value="";
					//document.all.calc1.style.visibility="hidden";
					//document.all.calc1.style.position="absolute";
					
					//document.all.calc2.style.visibility="hidden";
					//document.all.calc2.style.position="absolute";
				}
			}
			else
			{
				//document.forms[0].txtmonPay.value="";
				//document.forms[0].txttotPayment.value="";
				//document.all.calc1.style.visibility="hidden";
				//document.all.calc1.style.position="absolute";
				//document.all.calc2.style.visibility="hidden";
				//document.all.calc2.style.position="absolute";
			}
		}
	}
	else if(document.forms[0].selectinttype.value =="3")
	{
		//document.all.calc1.style.visibility="hidden";
		//document.all.calc1.style.position="absolute";
		//document.all.calc2.style.visibility="hidden";
		//document.all.calc2.style.position="absolute";
		document.all.amort2.style.visibility="hidden";
		document.all.amort2.style.position="absolute";
	}
	var peridicity = trim(document.forms[0].sel_peridicity.value);
	var servised = trim(document.forms[0].interestservised.value);
	if (peridicity != "m" || servised != "y")
	{
		document.all.amort1.style.visibility="hidden";
		document.all.amort1.style.position="absolute";
		document.all.amort2.style.visibility="hidden";
		document.all.amort2.style.position="absolute";
	}
}

function getInterestValue()
{		
	//alert(document.forms[0].selectinttype.value);
	if(document.forms[0].txtprd_desc.value == "")
	{
		ShowAlert('111',"Product");
		return;
	}
	if(document.forms[0].hidCategoryType.value=="LAD")
	{
		/*if(varcostofloan=="" || varcostofloan=="0.00")
		{
			ShowAlert('121'," Security Value");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
		}*/
	}	
	else
	{
		if(document.forms[0].txtloan_costloanprd.value == "")
		{
			if(document.forms[0].prd_type.value=="pI")
		    {
		    	ShowAlert('121',"Total Value of securities");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;
		    }
		    else if(document.forms[0].prd_type.value=="pL")
		    {
		    	ShowAlert('121',"Total Gross Rent");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pA")
		    {
		    	ShowAlert('121',"Cost of the vehicle");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pE")
		    {
		    	ShowAlert('121',"Total education cost");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    
		    else
		    {
			ShowAlert('121'," Cost of the project");
			document.forms[0].txtloan_costloanprd.value="";
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
		    }
			
		}
	}
	
	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);

	if((checktrim(document.forms[0].txtloan_amtreqd.value)=="")||(varamtreqst=="0.00" && isNaN(varamtreqst)))
	{
		ShowAlert('121',"Amount Requested");
		document.forms[0].txtloan_amtreqd.value="";
		document.forms[0].txtloan_amtreqd.focus();
		return false;
	}
	if(checktrim(document.forms[0].txtloan_reqterms.value)=="")
	{
		ShowAlert('121',"Repayment Period");
		return false;
	}
	/*if(document.forms[0].selectinttype.value =="0")
	{
		document.forms[0].selrepaymenttype.selectedIndex="0";
		document.forms[0].hidrepayment.value="0";
		document.forms[0].selectinttype.focus();
		ShowAlert('111',"Interest Type");
		return;
	}*/		
	var prdid   = document.forms[0].hidProductID.value;
	var costofproject=document.forms[0].txtloan_costloanprd.value;
	var margin =  eval(100-eval(document.forms[0].txtMarginpercent.value))/100;
	//var margindown =  eval(document.forms[0].txtMarginpercent.value)/100;
	//var downamt=parseFloat(costofproject) * parseFloat(margindown );
	var recmat  = document.forms[0].txtloan_sancamt.value;
	//Checking for eligible loan amount is lessthan or greater than the product range
	var descvalue=(document.forms[0].txtprd_desc.value).split("-");
	var varCategoryType=document.forms[0].hidCategoryType.value;
	var varfrom=descvalue[descvalue.length-2];			
	var varto=descvalue[descvalue.length-1];
	if(parseFloat(recmat)>parseFloat(varto))
	{
		recmat=varto;
	}
	if(parseFloat(recmat)<parseFloat(varfrom))
	{
		recmat=0;
	}
	if(recmat==0) // modified by mck to get the alert for interest correct
		recmat=varamtreqst;// modified by mck to get the alert for interest correct
	var terms =trim(document.forms[0].txtloan_reqterms.value);
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	var mortperiod=document.forms[0].txt_installments.value;
	if(mortperiod=="")
	{
		mortperiod=0;
	}
	//alert("inttype==="+inttype);
	document.forms[0].hidinteresttype.value = inttype;
	document.forms[0].hidinterest.value = inttype;
	
	/*if(document.forms[0].txtloan_tradein.value=="" || document.forms[0].txtloan_tradein.value=="0.00")
	{
		if(parseFloat(document.forms[0].txtloan_loantrade.value)>0.00)
		{
			alert("Loan on tradein cannot be greater than 0");
			document.forms[0].txtloan_loantrade.value = "0.00";
			return;
		}
	}*/
	var varterm=trim(document.forms[0].txtloan_reqterms.value);
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	if(document.forms[0].hidCategoryType.value=="LAD")
	{  
		/*if(varcostofloan<varamtreqst)
		{
			alert("Security Value cannot be less than Amount Requested");
			document.forms[0].txtloan_costloanprd.value="";
			document.forms[0].txtloan_costloanprd.focus();
			return;
		}*/
	}
	else
	{
	    {
			if(varcostofloan<varamtreqst)
			{
				if(document.forms[0].prd_type.value=="pI")
				{
					ShowAlert(183);
				}
				else if(document.forms[0].prd_type.value=="pL")
				{
					ShowAlert(184);
				}
				else
				{
					ShowAlert(133);
				}
				document.forms[0].txtloan_costloanprd.value="";
				document.forms[0].txtloan_costloanprd.focus();
				return;
			}
	   }
		if(varcostofloan=="0.00" && isNaN(varcostofloan))
		{    
			if(document.forms[0].prd_type.value=="pI")
		    {
		    	ShowAlert('121',"Total Value of securities");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;
		    }
		    else if(document.forms[0].prd_type.value=="pL")
		    {
		    	ShowAlert('121',"Total Gross Rent");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pA")
		    {
		    	ShowAlert('121',"Cost of the vehicle");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pE")
		    {
		    	ShowAlert('121',"Total education cost");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    
		    else
		    {
			ShowAlert('121'," Cost of the project");
			document.forms[0].txtloan_costloanprd.value="";
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
		    }
		}
		if(varcostofloan=="0.00" && isNaN(varcostofloan))
		{ 
			if(document.forms[0].prd_type.value=="pI")
		    {
		    	ShowAlert('121',"Total Value of securities");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;
		    }
		    else if(document.forms[0].prd_type.value=="pL")
		    {
		    	ShowAlert('121',"Total Gross Rent");
		    	document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pA")
		    {
		    	ShowAlert('121',"Cost of the vehicle");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    else if(document.forms[0].prd_type.value=="pE")
		    {
		    	ShowAlert('121',"Total education cost");
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;	    	
		    }
		    
		    else
		    {
			ShowAlert('121'," Cost of the project");
			document.forms[0].txtloan_costloanprd.value="";
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
		    }
		}
	}
	if(!(varcostofloan=="0.00" && isNaN(varcostofloan)))
	{
		document.forms[0].txtmarginoffered.value=roundVal(document.forms[0].txtloan_costloanprd.value-document.forms[0].txtloan_amtreqd.value);
	}
	document.forms[0].selrepaymenttype.selectedIndex="0";
	document.forms[0].hidrepayment.value="0";
	
	var varProductType=document.forms[0].prd_type.value;
	var purposeid = document.forms[0].hidpurpose.value;
	//var varage = document.forms[0].txt_vehage.value;
	

	if(document.forms[0].selectinttype.value < 3 || document.forms[0].selectinttype.value == 4)
	{
		if(prdid!="")
		{	
			document.forms[0].prdid1.value=prdid;
			document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getInterestRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"&morterms="+mortperiod+"&hidCategoryType="+varCategoryType+"&varProductType="+varProductType+"&hidpurpose="+purposeid;
			document.forms[0].selrepaymenttype.disabled = false;
		}
	}
	else if(document.forms[0].selectinttype.value == 3 )
	{
		//document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getStepupRate&hidBeanId=perapplicant&prdcode="+prdid+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms;
		document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getStepupRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"hidpurpose="+purposeid;
		document.forms[0].selrepaymenttype.disabled = false;
		showRepayment();
		//document.all.calc1.style.visibility="visible";
		
		//document.all.calc2.style.visibility="visible";
		
		document.all.amort1.style.visibility="visible";
		
		document.all.amort2.style.visibility="visible";
	}
	
	
	if(document.forms[0].selectinttype.value =="2" || document.forms[0].selectinttype.value=="1")
	{
		document.forms[0].selrepaymenttype.disabled = false;
		//document.all.calc1.style.visibility="visible";
		//document.all.calc2.style.visibility="visible";
		document.all.amort1.style.visibility="visible";
		document.all.amort2.style.visibility="visible";
		
	}	
}

function callStepUpCalculate()
{	

}

function calculateDocCharge()
{
	/*var prdid = document.forms[0].hidProductID.value;
	var recmat = document.forms[0].txtloan_sancamt.value; 
	if(prdid!="")
	{
		//document.all.ifrm.src=appURL+"action/iframedocfee.jsp?hidBeanGetMethod=getDocFee&hidBeanId=perlimitofloan&prdcode="+prdid+"&recamt="+recmat;
		document.all.ifrm.src=appURL+"action/iframedocfee.jsp?hidBeanGetMethod=getDocFee&hidBeanId=perlimitofloan&prdcode1="+prdid+"&recamt="+recmat;
	}*/
}

function callOnAmtReqstd()
{
	if(trim(document.forms[0].txtprd_desc.value)!="")
	{
		var descvalue=(document.forms[0].txtprd_desc.value).split("-");
		var varfrom=descvalue[descvalue.length-3];			
		var varto=descvalue[descvalue.length-2];
		var amtvalue=document.forms[0].txtloan_amtreqd.value;
		document.forms[0].hidrangefrom.value=varfrom;	
		document.forms[0].hidrangeto.value=varto;
		
		if(amtvalue!="" && amtvalue !="0.00")
		{
			if(parseFloat(amtvalue)>parseFloat(varto) || parseFloat(amtvalue)<parseFloat(varfrom))
			{
				ShowAlert('137');
				document.forms[0].txtloan_amtreqd.value="";
				document.forms[0].txtloan_amtreqd.focus();
				return;
			}
			else
			{
				if(document.forms[0].hidCategoryType.value!="LAD")
				{
					var costofproject=document.forms[0].txtloan_costloanprd.value;
					if(NanNumber(parseFloat(costofproject))>0 && NanNumber(parseFloat(amtvalue))>NanNumber(parseFloat(costofproject)))
					{
						  if(document.forms[0].prd_type.value=="pI")
							{
							alert("Amount requested cannot be greater than Total Value of securities");
							document.forms[0].txtloan_amtreqd.value="";
							document.forms[0].txtloan_amtreqd.focus();
							return;								
					
							}
						else if(document.forms[0].prd_type.value=="pL")
						{
						alert("Amount requested cannot be greater than Total Gross Rent");
						document.forms[0].txtloan_amtreqd.value="";
						document.forms[0].txtloan_amtreqd.focus();
						return;
						}
						else if(document.forms[0].prd_type.value=="pA")
						{
						alert("Amount requested cannot be greater than Cost of the Vehicle");
						document.forms[0].txtloan_amtreqd.value="";
						document.forms[0].txtloan_amtreqd.focus();
						return;
						}
						else if(document.forms[0].prd_type.value=="pE")
						{
						alert("Amount requested cannot be greater than Total Education Cost");
						document.forms[0].txtloan_amtreqd.value="";
						document.forms[0].txtloan_amtreqd.focus();
						return;
						}
						else
						{
							alert("Amount requested cannot be greater than Cost of project");
							document.forms[0].txtloan_amtreqd.value="";
							document.forms[0].txtloan_amtreqd.focus();
							return;
							
						}
					}
				}
			}
		}
	}
	else
	{
		alert('Select Product');
		document.forms[0].txtloan_amtreqd.value="";
		return;
	}
}
	
function callnetTrade()
{
	/*var varltradein=document.forms[0].txtloan_tradein.value;
	var varlltradein=document.forms[0].txtloan_loantrade.value;
	if(varltradein == "")
	{
		varltradein = "0.00";
	}
	if(varlltradein == "")
	{
		varlltradein = "0.00";
	}
	vartradein=parseFloat(varltradein)-parseFloat(varlltradein);
	document.forms[0].txtnetTradeIn.value=roundVal(vartradein);*/
}

function callCalculate()
{	
	var moritorium = trim(document.forms[0].txt_installments.value);
	var interestcharged=document.forms[0].sel_interestcharge.value;
	if (moritorium=="")
	{
		moritorium="0";
	}	
	var peridicity = trim(document.forms[0].sel_peridicity.value);
	var servised = trim(document.forms[0].interestservised.value);
	var varterm = trim(document.forms[0].txtloan_reqterms.value);
	var first = "";
	var second = "";	
	if (servised == "y")
	{
		first = parseFloat(varterm) - parseFloat(moritorium);		
	}
	else if (servised == "n")
	{
		first = parseFloat(varterm)- parseFloat(moritorium);
	}
	if (peridicity == "m")
	{
		second = first;
	}
	else if (peridicity == "q")
	{
		second = parseFloat(first)/3;
	}
	else if (peridicity == "h")
	{
		second = parseFloat(first)/6;
	}
	else if (peridicity == "y")
	{
		second = parseFloat(first)/12;
	}
	varterm = second;
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	var varamtreqst=parseFloat(document.forms[0].txtloan_sancamt.value);
	if(varcostofloan<varamtreqst)
	{
		alert("Eligible loan amount cannot be greater than Amount requested");
		return;
	}
	if(varterm!="")
	{
		var varrecomlvr=parseFloat(document.forms[0].txtMarginpercent.value);
		var varAmtrecomd;
		var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
		
		if(varamtreqst!="0.00" && !isNaN(varamtreqst))
		{			
			if(varcostofloan!="0.00" && !isNaN(varcostofloan))
			{
				if(varcostofloan==varamtreqst)
				{
					varAmtrecomd=(100-varrecomlvr)*varamtreqst/100;
				}
				else if(varcostofloan > varamtreqst)
				{					
					var costLoan = (varcostofloan * (100-varrecomlvr)/100);
					if(costLoan < varamtreqst)
					{
						varAmtrecomd = costLoan;
					}
					else
					{
						varAmtrecomd = varamtreqst;
					}
				}
				document.forms[0].txtloan_recmdamt.value=roundVal(varAmtrecomd);
				var varIntCalcMode = document.forms[0].sel_intcalcmode.value;
				var recamt=varAmtrecomd;
				if(servised == "y" && moritorium > 0 && interestcharged=="3")
				{
					if(varIntCalcMode == "C")
					{
						var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
						varAmtrecomd  = 	roundVal(varamtreqst * (Math.pow(tmp,moritorium)));
					}
					else if(varIntCalcMode == "S")
					{
						varAmtrecomd = roundVal(varamtreqst + ((varamtreqst*moritorium*parseFloat(document.forms[0].txtloan_modintrate.value)))/1200);
					}
				}
				var varrate=parseFloat(document.forms[0].txtloan_modintrate.value);	
				var varinttype=	document.forms[0].selectinttype.value;	
				
				if(varinttype!="4" && (varrate!=""||varrate!="0.00"))
				{	
					varrate=parseFloat(document.forms[0].txtloan_modintrate.value)/(12*100);
					var denominator=Math.pow(varrate+1,varterm)-1;
					var varnumerator=varrate*Math.pow(varrate+1,varterm);
					var varemi=(varnumerator/denominator)*varAmtrecomd;
					var vartotal=varemi*varterm;
					varemi=Math.floor(varemi);
					document.forms[0].txtmonPay.value=roundVal(varemi);
				}
				else if(varinttype=="4")
				{
					document.all.ifrm1.src=appURL+"action/iframemonthinstallment.jsp?hidBeanGetMethod=getComboRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+document.forms[0].txtloan_reqterms.value+"&moritorium="+mortperiod+"&servised="+servised+"&interestcharged="+document.forms[0].sel_interestcharge.value;
				}
				else
				{
					document.forms[0].txtmonPay.value="0.00";
				}
			}
			else
			{
				if(document.forms[0].prd_type.value=="pI")
			    {
			    	ShowAlert('121',"Total Value of securities");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
			    }
			    else if(document.forms[0].prd_type.value=="pL")
			    {
			    	ShowAlert('121',"Total Gross Rent");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else if(document.forms[0].prd_type.value=="pA")
			    {
			    	ShowAlert('121',"Cost of the vehicle");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else if(document.forms[0].prd_type.value=="pE")
			    {
			    	ShowAlert('121',"Total education cost");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else
			    {
				ShowAlert('121'," Cost of the project");
				document.forms[0].txtloan_costloanprd.value="";
			 	document.forms[0].txtloan_costloanprd.focus();
			 	return;
			    }
				
			}
		}
		else
		{
			if(count!=0)
			{
				ShowAlert('121'," Amount Requested");
				document.forms[0].txtloan_amtreqd.value="";
				document.forms[0].txtloan_amtreqd.focus();
				return false;
			}
			count=count+1;
		}
	}	
	callSanc();	
}

function callDescHelp()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var bowid="";
		bowid=document.forms[0].hidapplicantid.value;
		var orgscode = document.forms[0].orgscode.value;
		var orgcode = document.forms[0].orgcode.value;
		var orglevel = document.forms[0].orglevel.value;
		var apptype = "p";
		var varCategoryType=document.forms[0].hidCategoryType.value;
		var varProductType=document.forms[0].prd_type.value;
		
		if(document.forms[0].appno.value=="new")
		{
			var varQryString = appURL+"action/productslisthelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getProductList&apptype="+apptype+"&comappid="+bowid+"&orgscode="+orgscode+"&orgcode="+orgcode+"&orglevel="+orglevel+"&hidStaffFlag="+document.forms[0].hidStaffFlag.value+"&hidServiceLeft="+document.forms[0].hidServiceLeft.value+"&perapp_age="+age+"&hidCategoryType="+varCategoryType+"&DocReceived="+varDocReceivedNew;
			var title = "ProductsSearch";
			var prop = "scrollbars=no,width=700,height=430,status=yes";	
			prop = prop + ",left=50,top=50";		
			window.open(varQryString,title,prop);
		}
		else
		{
			var varconfirm="";
			if(varCategoryType=="LAD")
			{
				if(varProductType=="pG")
				{
					varconfirm=ConfirmMsg('176');
				}
				else
				{
					varconfirm=ConfirmMsg('177');
				}
			}
			else
			{
				varconfirm=ConfirmMsg('175');
			}
			if(varconfirm)
			{
				var varQryString = appURL+"action/productslisthelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getProductList&apptype="+apptype+"&comappid="+bowid+"&orgscode="+orgscode+"&orgcode="+orgcode+"&orglevel="+orglevel+"&hidStaffFlag="+document.forms[0].hidStaffFlag.value+"&hidServiceLeft="+document.forms[0].hidServiceLeft.value+"&perapp_age="+age+"&hidCategoryType="+varCategoryType+"&DocReceived="+varDocReceivedNew;
				var title = "ProductsSearch";
				var prop = "scrollbars=no,width=700,height=430,status=yes";	
				prop = prop + ",left=50,top=50";		
				window.open(varQryString,title,prop);
			}
		}
	}
}

function doEdit()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	document.forms[0].txt_receivedRH.readOnly=true;
	callDisableControls(true,false,false,false,false);
	disablefields(false);
	document.forms[0].txtloan_reqterms.disabled=false;
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		if(document.forms[0].txt_installments.value=='0')
		{
			document.forms[0].interestservised.value="s"; 
		    document.forms[0].interestservised.disabled=true;	
		}
		callInterestCharged();
	
		if((document.forms[0].cmdedit.disabled==true) && (document.forms[0].cmdsave.disabled==false))
		{
		
			/*if(strOrgLevel=='A')
			{
				document.forms[0].txt_receiptclpu.readOnly=true;
				document.forms[0].txt_receiptcpc.readOnly=true;
			}
			else
			{
				document.forms[0].txt_receiptclpu.readOnly=true;
				document.forms[0].txt_receiptcpc.readOnly=true;*/
				if(strOrgLevel=='D')
				{
					document.forms[0].txt_receiptclpu.readOnly=false;
				}
				if(strOrgLevel=='R' && strOrgcode=='001001000000000')
				{
					document.forms[0].txt_receiptcpc.readOnly=false;
				}
			}
		}
	
	else
	{
	document.forms[0].appno.readOnly=true;
	document.forms[0].appname.readOnly=true;
	document.forms[0].strappstatus.readOnly=true;
	}
}

function doSave()
{
	var page=document.forms[0].page1.value;
	var varappname="";
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	var sancLoan=parseFloat(document.forms[0].txtloan_sancamt.value);
	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
	var varterm=trim(document.forms[0].txtloan_reqterms.value);
	var varInterestType = document.forms[0].selectinttype.selectedIndex;
	var varpurposeofloan = checktrim(document.forms[0].txtloan_purposeofloan.value);
	var varfiledon = checktrim(document.forms[0].txtloan_filedon.value);
	var varreceived =checktrim(document.forms[0].txt_receivedRH.value);
	var mor= checktrim(document.forms[0].txt_installments.value);
	var varprd_desc = document.forms[0].txtprd_desc.value;
	var varhidOldProductCode=document.forms[0].hidOldProductCode.value;
	var varnewProductCode=document.forms[0].hidProductID.value;
	var varDeleteDeviationEntries="false";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(document.forms[0].appno.value!="new")
	{
		if(varhidOldProductCode!=varnewProductCode)
		{
			varDeleteDeviationEntries="true";
		}
	}
	if(document.forms[0].comappid.value == "" ||document.forms[0].comappid.value == null)
	{
		document.forms[0].comappid.value = varApplicantId;
	}
	if (mor=="")
	{
		mor="0";
	}
	if(document.forms[0].sel_interestcharge.value=="")
	{
		document.forms[0].sel_interestcharge.value = "1";
	}
	var intser= checktrim(document.forms[0].interestservised.value);
	if(varinwardnorequired=="" && document.forms[0].txt_appinwardno.value =="")
	{
		ShowAlert('111',"Application Inward No");
		return false;
	}
	if(varprd_desc=="----"||varprd_desc=="")
	{
		ShowAlert('111',"Loan Product");
		return false;
	}
	
	if(varamtreqst == "" || varamtreqst == "0.00"){
		ShowAlert('121'," Amount Requested");
	 	document.forms[0].txtloan_amtreqd.focus();
	 	return;
	}
	if(document.forms[0].prd_type.value=="pL")
	{
				 
		if(document.forms[0].txt_monthgrossrent.value=="" || document.forms[0].txt_monthgrossrent.value=="0.00")
		{
		
		  ShowAlert('121',"Monthly Gross Rent");
		  document.forms[0].txt_monthgrossrent.focus();
		  return false;
		}	
		
		if(document.forms[0].txt_leaseperiod.value=="")
		{
		  ShowAlert('121',"Unexpired Lease Period");
		  document.forms[0].txt_leaseperiod.focus();
		  return false;
		}	
		
	}
	if(document.forms[0].hidCategoryType.value=="LAD")
	{
		if(varcostofloan=="" || varcostofloan=="0.00")
		{
		 	document.forms[0].txtloan_costloanprd.value="";
		}
	}	
		else { 
	if(varcostofloan=="" || varcostofloan=="0.00")
	{
	    if(document.forms[0].prd_type.value=="pI")
	    {
	    	ShowAlert('121',"Total Value of securities");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
	    }
	    else if(document.forms[0].prd_type.value=="pL")
	    {
	    	ShowAlert('121',"Total Gross Rent");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;	    	
	    }
	    else if(document.forms[0].prd_type.value=="pA")
	    {
	    	ShowAlert('121',"Cost of the vehicle");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;	    	
	    }
	    else if(document.forms[0].prd_type.value=="pE")
	    {
	    	ShowAlert('121',"Total education cost");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;	    	
	    }
	    else
	    {
		ShowAlert('121'," Cost of the project");
	 	document.forms[0].txtloan_costloanprd.focus();
	 	return;
	    }
	}
		}
	if(document.forms[0].selectinttype.value =="0")
	{  
		ShowAlert('111',"Interest Type");
		document.forms[0].selectinttype.focus();
		return false;
	}
	if(varterm == "")
	{   
		alert("Enter Loan Period (in months)");
		return false;
	}
	if(document.forms[0].sel_peridicity.value=="s")
	{
		alert("Select Periodicity of Installments ");
		document.forms[0].sel_peridicity.focus();
		return;
	}
	if(varpurposeofloan == "")
	{
		alert("Enter Purpose of Loan");
		document.forms[0].txtloan_purposeofloan.focus();
		return false;
	}
	
	if(document.forms[0].selrepaymenttype.value =="0")
	{
		ShowAlert('111',"Repayment Type");
		document.forms[0].selrepaymenttype.focus();
		return false;
	}
	if(document.forms[0].selmodepayment.value=="0")
	{
		ShowAlert('111',"Mode of Payment");
		document.forms[0].selmodepayment.focus();
		return false;
	}
	varPrdType=document.forms[0].prd_type.value;
	if(varPrdType=='pG'||varPrdType=='pR')
	{
		if(document.forms[0].sel_docreceived.value =="0")
		{
			ShowAlert('111',"Documents Received From Agriculturist");
			document.forms[0].sel_docreceived.focus();
			return false;
		}
	}
	if(varreceived == "")
	{
		alert("Enter the Application Received Date");
		document.forms[0].txt_receivedRH.focus();
		return false;
	}
	if(varfiledon == "")
	{
		alert("Enter Application Processed On");
		document.forms[0].txtloan_filedon.focus();
		return false;
	}
	
	if(document.forms[0].selmodepayment.value=="E" )
	{
		var varOperAcc=document.forms[0].txt_operativeaccno.value;
		
		if(document.forms[0].txt_operativeaccno.value=="")
		{
		alert("Enter the Operative Account Number");
		document.forms[0].txt_operativeaccno.value="";
		return;	
		}
		else if(varOperAcc.length!=16)
		{
			alert("Please Enter Valid Operative Account Number");
			document.forms[0].txt_operativeaccno.value="";
			return;
		}
	}
	if (intser !="s" && (mor =="" || mor=="0"))
	{
		document.forms[0].interestservised.value="s";
	}
	if(varPrdType!="pR")
	{
		if(document.forms[0].txtloan_modintrate.value =="0.00" || document.forms[0].txtloan_modintrate.value =="")
		{
			alert("No Interest rate Defined");
			return;
		}
	}
	if(document.forms[0].selectgovt.value=="1")
	{
		if(document.forms[0].schemetype.value=="0")
		{
			ShowAlert(111,'Scheme Type');
			document.forms[0].schemetype.focus();
			return;
		}
	}
	
	if(varterm!="")
	{
		if(varamtreqst!=0.0 && !isNaN(varamtreqst))
		{
			if((varcostofloan!=0.0 && !isNaN(varcostofloan))||document.forms[0].hidCategoryType.value=="LAD")
			{
				if(page.toUpperCase()=="NR")
				{
					disablefields(false);
					if(varInterestType<3)
					{
						callCalculate();
						calculateLoanAmount()
					}
					if(document.forms[0].txtmonPay.value=="")
					{
						document.forms[0].txtmonPay.value="0.00";	
					}
					document.forms[0].hidDeleteDeviationFlag.value=varDeleteDeviationEntries;
					document.forms[0].txtmarginoffered.value=roundVal(NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value))-NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value)));
					document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
					document.forms[0].hidBeanId.value="perapplicant";
					if(document.forms[0].hidCategoryType.value=="LAD")
					{
						document.forms[0].action=appURL+"action/ladloandetails.jsp";	
					}
					else
					{
						document.forms[0].action=appURL+"action/perloandetails.jsp";	
					}
					document.forms[0].submit();
				}
				else
				{
					disablefields(false);
					
					if(varInterestType<3)
					{
						callCalculate();
						calculateLoanAmount();
					}
					callSanc();				
					if(document.forms[0].txtmonPay.value=="")
					{
						document.forms[0].txtmonPay.value="0.00";	
					}	
					document.forms[0].hidDeleteDeviationFlag.value=varDeleteDeviationEntries;
					document.forms[0].txtmarginoffered.value=roundVal(NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value))-NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value)));
					document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
					document.forms[0].hidBeanId.value="perapplicant";
					if(document.forms[0].hidCategoryType.value=="LAD")
					{
						document.forms[0].action=appURL+"action/ladloandetails.jsp";	
					}
					else
					{
						document.forms[0].action=appURL+"action/perloandetails.jsp";	
					}
					document.forms[0].submit();						
				}
			}
			else
			{
				if(document.forms[0].hidCategoryType.value!="LAD")
				{
					if(document.forms[0].prd_type.value=="pI")
				    {
				    	ShowAlert('121',"Total Value of securities");
					 	document.forms[0].txtloan_costloanprd.focus();
					 	return;
				    }
				    else if(document.forms[0].prd_type.value=="pL")
				    {
				    	ShowAlert('121',"Total Gross Rent");
					 	document.forms[0].txtloan_costloanprd.focus();
					 	return;	    	
				    }
				    else if(document.forms[0].prd_type.value=="pA")
				    {
				    	ShowAlert('121',"Cost of the vehicle");
					 	document.forms[0].txtloan_costloanprd.focus();
					 	return;	    	
				    }
				    else if(document.forms[0].prd_type.value=="pE")
				    {
				    	ShowAlert('121',"Total education cost");
					 	document.forms[0].txtloan_costloanprd.focus();
					 	return;	    	
				    }
				    
				    else
				    {
					ShowAlert('121'," Cost of the project");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
				    }
				}
			}
		}
		else
		{
			ShowAlert('121'," Amount Requested");
			document.forms[0].txtloan_amtreqd.value="";
			document.forms[0].txtloan_amtreqd.focus();
			return;
		}
	}
	else
	{
		ShowAlert('111',"Product");
		return;
	}
	if(document.forms[0].selrepaymenttype.value=="1")
	{
	getInterestValue();
	}
}

function callSanc()
{	
	var varamtreqst =parseFloat(document.forms[0].txtloan_sancamt.value);
	var prdid   = document.forms[0].hidProductID.value;
	var recmat  = document.forms[0].txtloan_sancamt.value;
	var sancAmt = document.forms[0].txtloan_sancamt.value;
	var reqAmt = document.forms[0].txtloan_amtreqd.value;
	var costPrd = document.forms[0].txtloan_costloanprd.value;
	var sancAmt = document.forms[0].txtloan_sancamt.value;
	var recmat  = document.forms[0].txtloan_sancamt.value;
	if(recmat==0) // modified by mck to get the alert for interest correct
		recmat=varamtreqst;
	if(recmat==0) // modified by mck to get the alert for interest correct
		recmat=reqAmt;	
	
	var margin = document.forms[0].txtMarginpercent.value;
	var terms   = document.forms[0].txtloan_reqterms.value;
	var interestcharged=document.forms[0].sel_interestcharge.value;
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	if(isNaN(costPrd))
	{
		costPrd="0.00";
	}
	if(margin=="")
	{
		margin=0.0;
	}

	var varProductType=document.forms[0].prd_type.value.toUpperCase();

	//Calculate EMI for Staff Loan if the loan is for staff
	if(varProductType.charAt(0) == "P" && document.forms[0].hidStaffFlag.value == "Y" && 
		NanNumber(parseFloat(document.forms[0].hidPrincipalRatio.value))>0 && 
		NanNumber(parseFloat(document.forms[0].hidInterestRatio.value))>0)
	{
		calculateStaffEMI();
	}
	else
	{	
		var downpay = parseFloat(costPrd) - parseFloat(sancAmt);	
		var varrate=0;
		var varinttype=	document.forms[0].selectinttype.value;	
		
		var moritorium = trim(document.forms[0].txt_installments.value);
		if (moritorium=="")
		{
			moritorium="0";
		}
		var peridicity = trim(document.forms[0].sel_peridicity.value);
		var servised = trim(document.forms[0].interestservised.value);
		var varIntCalcMode = document.forms[0].sel_intcalcmode.value;
		var varterm = trim(document.forms[0].txtloan_reqterms.value);
		var first = "";
		var second = "";	
		if (servised == "y")
		{
			first = parseFloat(varterm) - parseFloat(moritorium);
		}
		else if (servised == "n")
		{
			first = parseFloat(varterm)- parseFloat(moritorium);
		}
		else if (servised=="s")
		{
			first=parseFloat(varterm);
		}	
		if (peridicity == "m")
		{
			second = first;
		}
		else if (peridicity == "q")
		{
			second = parseFloat(first)/3;
		}
		else if (peridicity == "h")
		{
			second = parseFloat(first)/6;
		}
		else if (peridicity == "y")
		{
			second = parseFloat(first)/12;
		}	
		varterm = second;	

		varrate=parseFloat(document.forms[0].txtloan_modintrate.value)/(12*100);
		var denominator=Math.pow(varrate+1,varterm)-1;
		var varnumerator=varrate*Math.pow(varrate+1,varterm);
		if(servised == "y" && moritorium > 0 && interestcharged=="3")
		{
			if(varIntCalcMode == "C")
			{
				var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
				sancAmt  = 	roundVal(varamtreqst *(Math.pow(tmp,moritorium)));
			}
			else if(varIntCalcMode == "S")
			{
				sancAmt = roundVal(varamtreqst + ((varamtreqst*moritorium*parseFloat(document.forms[0].txtloan_modintrate.value)))/1200);
			}
		}
		else
		{
			sancAmt  = 	roundVal(varamtreqst);
		}
		var varemi=0.00;
		if(denominator=="" || eval(denominator)==0)
		{
			varemi=0.0;
		}
		else
		{
			varemi=(varnumerator/denominator)*sancAmt;
		}
		
		var vartotal=varemi*varterm;
	 	varemi=Math.floor(varemi)
	 	
	 	document.forms[0].txtloan_recmdamt.value=roundVal(parseFloat(costPrd)-(parseFloat(costPrd)*(parseFloat(margin)/100)));
		if(document.forms[0].txtloan_recmdamt.value=="N.aN")
		{
			document.forms[0].txtloan_recmdamt.value="0.00";
		}
		if(isNaN(varemi))
		{
			varemi = 0.00;
		}
		if(isNaN(vartotal))
		{
			vartotal=0.00;
		}	
		if(document.forms[0].selrepaymenttype.value=="1" || document.forms[0].selrepaymenttype.value=="0")
		{
			if(varinttype=="4")
			{
				document.all.ifrm1.src=appURL+"action/iframemonthinstallment.jsp?hidBeanGetMethod=getComboRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+document.forms[0].txtloan_reqterms.value+"&moritorium="+moritorium+"&servised="+servised+"&interestcharged="+document.forms[0].sel_interestcharge.value;
			}
			else
			{
				if(isNaN(varemi))
				{
					varemi=0.00;
				}
				document.forms[0].txtmonPay.value=roundVal(varemi);
			}
		}
		else
		{
			document.forms[0].txtmonPay.value="0.00";
		}	
	}
}
/*
function callAmortization()
{	
	var txtmonPayamor=document.forms[0].txtmonPay.value;
	var reptype = document.forms[0].selrepaymenttype.value;
	var intrate=document.forms[0].txtloan_modintrate.value;
	var terms1=trim(document.forms[0].txtloan_reqterms.value);
	var terms2=trim(document.forms[0].txt_installments.value);
	var interestcharged=document.forms[0].sel_interestcharge.value;
	
	var terms = terms1 - terms2;
	
	var recamt=document.forms[0].txtloan_sancamt.value;
	var varappname = document.forms[0].appname.value;
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	var moritorium = trim(document.forms[0].txt_installments.value);
	var calmonth=document.forms[0].txtloan_filedon.value;
	var peridicity = trim(document.forms[0].sel_peridicity.value);	
	var servised = trim(document.forms[0].interestservised.value);
	//document.forms[0].txtloan_reqterms.readOnly=false;
	var varterm = trim(document.forms[0].txtloan_reqterms.value);
	document.forms[0].txtloan_reqterms.readOnly=true;
	var varIntCalcMode = document.forms[0].sel_intcalcmode.value;
	
	if (moritorium=="")
	{
		moritorium="0";
	}	
	var first = "";
	var second = "";	
	if (servised == "y")
	{
		first = parseFloat(varterm) - parseFloat(moritorium);
	}
	else if (servised == "n")
	{
		first = parseFloat(varterm)- parseFloat(moritorium);
	}	
	if (peridicity == "m")
	{
		second = first;
	}
	else if (peridicity == "q")
	{
		second = parseFloat(first)/3;
	}
	else if (peridicity == "h")
	{
		second = parseFloat(first)/6;
	}
	else if (peridicity == "y")
	{
		second = parseFloat(first)/12;
	}
	varterm = second;

	var denominator=Math.pow(intrate+1,varterm)-1;
	var varnumerator=intrate*Math.pow(intrate+1,varterm);
	if(servised == "y" && moritorium > 0 && interestcharged=="3")
	{
		if(varIntCalcMode == "C")
		{
			var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
			sancAmt  = 	roundVal(recamt * (Math.pow(tmp,moritorium)));
		}
		else if(varIntCalcMode == "S")
		{
			var varModIntRate = parseFloat(document.forms[0].txtloan_modintrate.value);
			var samplecalc= ((recamt*moritorium*varModIntRate)/1200);
			sancAmt =roundVal(parseFloat(recamt) + parseFloat(samplecalc));
		}
	}
	else
	{
			sancAmt=recamt;
	}		
	if(document.forms[0].amort.value == "Amortization")
	{
		if(eval(intrate) == 0)
		{
			alert("Interest is Zero . Hence cannot Calculate");
			return false;
		}
		if(intrate!="" && terms!=""  && recamt!="")
		{
			if(inttype=="Combo")
			{
				callComborate();
			}
			else
			{
				if(servised == "y" && moritorium > 0)
				{
					var varQryString = appURL+"action/amortization.jsp?modIntRate="+intrate+"&terms="+varterm+"&terms2="+terms2+"&txtmonPay="+txtmonPayamor+"&recmdAmt="+sancAmt+"&hidBeanGetMethod=calculateAmortization&hidBeanId=perapplicant&hidrepaymenttype=amort&varappname="+varappname+"&inttype="+inttype+"&calmonth="+calmonth;
				}
				else
				{
					var varQryString = appURL+"action/amortization.jsp?modIntRate="+intrate+"&terms="+terms+"&terms2="+terms2+"&txtmonPay="+txtmonPayamor+"&recmdAmt="+recamt+"&hidBeanGetMethod=calculateAmortization&hidBeanId=perapplicant&hidrepaymenttype=amort&varappname="+varappname+"&inttype="+inttype+"&calmonth="+calmonth;
				}
				varQryString = varQryString + "&StaffFlag="+document.forms[0].hidStaffFlag.value;
				varQryString = varQryString + "&PrincipalRatio="+document.forms[0].hidPrincipalRatio.value;
				varQryString = varQryString + "&InterestRatio="+document.forms[0].hidInterestRatio.value;
				
				var title = "Amortization";
				var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
				var xpos = (screen.width - 350) / 2;
				var ypos = (screen.height - 120) / 2;
				prop = prop + ",left=50,top=50";
				window.open(varQryString,title,prop);
			}
		}
		else
		{
			ShowAlert("121",'InterestRate ,','Terms,','Recommed Amount');
			return;
		}
	}
	else if(document.forms[0].amort.value == "Repayment Schedule")
	{
		callRepayment();
	}
	else if(document.forms[0].amort.value == "Equal Installments")
	{
		callEqualInstallment();
	}
	else if(document.forms[0].amort.value == "SlabRate")
	{
		callSlabRate();
	}	
}

function callSlabRate()
{
	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
	var prdid   = document.forms[0].hidProductID.value;
	var costofproject=document.forms[0].txtloan_costloanprd.value;
	var margin =  eval(100-eval(document.forms[0].txtMarginpercent.value))/100;
	var recamt = document.forms[0].txtloan_sancamt.value;
	if(recamt==0) 
		recamt=varamtreqst;
	//var terms =trim(document.forms[0].txtloan_reqterms.value);
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	document.forms[0].hidinteresttype.value = inttype;
	document.forms[0].hidinterest.value = inttype;
	var pdate = document.forms[0].txtloan_filedon.value;
	var prinRatio = document.forms[0].hidPrincipalRatio.value;
	var intrRatio = document.forms[0].hidInterestRatio.value;
	
	
		//added by asha
	
	var intrate=document.forms[0].txtloan_modintrate.value;
	var terms1=trim(document.forms[0].txtloan_reqterms.value);
	var terms2=trim(document.forms[0].txt_installments.value);
	var terms = terms1 - terms2;
	var varterm = trim(document.forms[0].txtloan_reqterms.value);
	var moritorium = trim(document.forms[0].txt_installments.value);
	var peridicity = trim(document.forms[0].sel_peridicity.value);	
	var servised = trim(document.forms[0].interestservised.value);
	var varIntCalcMode = document.forms[0].sel_intcalcmode.value;
	var interestcharged=document.forms[0].sel_interestcharge.value;
	
	
	if (moritorium=="")
	{
		moritorium="0";
	}	
	var first = "";
	var second = "";	
	if (servised == "y")
		{
		first = parseFloat(varterm) - parseFloat(moritorium);
		}
	else if (servised == "n")
		{
		first = parseFloat(varterm)- parseFloat(moritorium);
		}
	
	if (peridicity == "m")
		{
		second = first;
		}
	else if (peridicity == "q")
		{
		second = parseFloat(first)/3;
		}
	else if (peridicity == "h")
		{
		second = parseFloat(first)/6;
		}
	else if (peridicity == "y")
		{
		second = parseFloat(first)/12;
		}
	varterm = second;
	var sancAmt = "";
	var denominator=Math.pow(intrate+1,varterm)-1;
	var varnumerator=intrate*Math.pow(intrate+1,varterm);
	if(servised == "y" && moritorium > 0 && interestcharged=="3")
	{
		if(varIntCalcMode == "C")
		{
			var tmp =  (1+(parseFloat(document.forms[0].txtloan_modintrate.value) / 1200));		
			sancAmt  = 	roundVal(recamt * (Math.pow(tmp,moritorium)));
		}
		else if(varIntCalcMode == "S")
		{
			var varModIntRate = parseFloat(document.forms[0].txtloan_modintrate.value);
			var samplecalc= ((recamt*moritorium*varModIntRate)/1200);
			sancAmt =roundVal(parseFloat(recamt) + parseFloat(samplecalc));
		}
	}
	else
	{
			sancAmt=recamt;
	}
	
	//end
	
	
	
	/*if(document.forms[0].txtloan_tradein.value=="" || document.forms[0].txtloan_tradein.value=="0.00")
	{
		if(parseFloat(document.forms[0].txtloan_loantrade.value)>0.00)
		{
			alert("Loan on tradein cannot be greater than 0");
			document.forms[0].txtloan_loantrade.value = "0.00";
			return;
		}
	}*/
/*
	if(servised == "y" && moritorium > 0)
	{
		var varQryString = appURL+"action/slabrateChart.jsp?hidBeanGetMethod=getSlabRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recamt+"&terms="+varterm+"&terms2="+terms2+"&costloanprd="+varcostofloan+"&pdate="+pdate+"&prinRatio="+prinRatio+"&intrRatio="+intrRatio;
	}
	else
	{
		var varQryString = appURL+"action/slabrateChart.jsp?hidBeanGetMethod=getSlabRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recamt+"&terms="+terms+"&terms2="+terms2+"&costloanprd="+varcostofloan+"&pdate="+pdate+"&prinRatio="+prinRatio+"&intrRatio="+intrRatio;
	}
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	var appno = document.forms[0].appno.value;
	//var varQryString = appURL+"action/slabrateChart.jsp?hidBeanGetMethod=getSlabRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recamt+"&terms="+terms1+"&costloanprd="+varcostofloan+"&pdate="+pdate+"&prinRatio="+prinRatio+"&intrRatio="+intrRatio;
	var title = "SlabRate";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);	
}

function callComborate()
{
	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
	var varappname = document.forms[0].appname.value;
	var intrate=document.forms[0].txtloan_modintrate.value;
	var prdid   = document.forms[0].hidProductID.value;
	var costofproject=document.forms[0].txtloan_costloanprd.value;
	var margin =  eval(100-eval(document.forms[0].txtMarginpercent.value))/100;
	var recmat  = document.forms[0].txtloan_sancamt.value;
	if(recmat==0) 
		recmat=varamtreqst;
	var terms =trim(document.forms[0].txtloan_reqterms.value);
	var moritorium = trim(document.forms[0].txt_installments.value);
	if(moritorium=="")
		moritorium=0;
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	document.forms[0].hidinteresttype.value = inttype;
	document.forms[0].hidinterest.value = inttype;
	var pdate = document.forms[0].txtloan_filedon.value;
		
	var varterm=trim(document.forms[0].txtloan_reqterms.value);
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	var interestcharged=document.forms[0].sel_interestcharge.value;
 	var servised = trim(document.forms[0].interestservised.value);
 	
	var appno = document.forms[0].appno.value;
	var varQryString = appURL+"action/amortization.jsp?hidBeanGetMethod=getComboRateChart&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&varappname="+varappname+"&inttype="+inttype+"&modIntRate="+intrate+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"&pdate="+pdate+"&moritorium="+moritorium+"&interestcharged="+interestcharged+"&servised="+servised;
	var title = "ComboRate";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);	
}
*/
function callRepayment()
{
	document.forms[0].hidrepaymenttype.value="repay";
	
	var appno = document.forms[0].appno.value;
	var intrate=document.forms[0].txtloan_modintrate.value;
	document.forms[0].txtloan_reqterms.disabled=false;	
	var terms=trim(document.forms[0].txtloan_reqterms.value);
	var recamt=document.forms[0].txtloan_sancamt.value;
	
	if(eval(intrate)==0)
	{
		alert("Interest is Zero . Hence cannot Calculate");
		return false;
	}
	if(intrate!="" && terms!=""  && recamt!="")
	{
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="calculateAmortization";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/repaymentschedule.jsp";	
		document.forms[0].submit();
	}
	else
	{
		ShowAlert("121",'InterestRate ,','Terms,','Recommed Amount');
		return;
	}
}

function checkval(objName)
{
    var processdate = objName;
    var currentdt=currentDate;
    
    if(document.forms[0].txt_receivedRH.value=="")
    	{
    	alert("Enter Received Date");
    	document.forms[0].txt_receivedRH.focus();
    	return;
    	}
	var Receiveddate = document.forms[0].txt_receivedRH.value;
	
	var pgdt=processdate.substring(0,2);
	var pgmon=processdate.substring(3,5);
	var pgyear=processdate.substring(6,10);
	var pgdt=pgmon+"/"+pgdt+"/"+pgyear;
	
	var curdt=currentdt.substring(0,2);
	var curmon=currentdt.substring(3,5);
	var curyear=currentdt.substring(6,10);
	var curdt=curmon+"/"+curdt+"/"+curyear;
	
	var recdt=Receiveddate.substring(0,2);
	var recmon=Receiveddate.substring(3,5);
	var recyear=Receiveddate.substring(6,10);
	var recdt=recmon+"/"+recdt+"/"+recyear;
		
		if(document.forms[0].txtloan_filedon.value!="")
		{
			if(Date.parse(pgdt) > Date.parse(curdt))
			{
				alert("Processed Date Should Not greater than Current Date");
				document.forms[0].txtloan_filedon.value="";
				document.forms[0].txtloan_filedon.focus();
				return;
			}
			if(Date.parse(pgdt) < Date.parse(recdt))
			{
				alert("Processed Date Should Not Less Than Received Date");
				document.forms[0].txtloan_filedon.value="";
				document.forms[0].txtloan_filedon.focus();
				return;
			}
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
  	var hlpvar = appURL+"phlp/loan_appretail_apploanproduct.htm";
  	var title = "LoanProduct";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function calculateLoanAmount()
{	
	//Calculating the Eligibility Loan amount
	
	var varProductType = document.forms[0].prd_type.value.toUpperCase();	
	var varMarginEligibility = NanNumber(parseFloat(document.forms[0].txtloan_recmdamt.value));	
	//var varSalaryEligibility = NanNumber(parseFloat(document.forms[0].txt_salarymargin.value));
	var varRequestedAmount = NanNumber(parseFloat(document.forms[0].txtloan_amtreqd.value));
	var varProjectCost = NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value));	
	var varEligibleAmount = varMarginEligibility;
		
	if(varRequestedAmount < varEligibleAmount)
	{
		varEligibleAmount = varRequestedAmount;
	}
	
	document.forms[0].txtloan_sancamt.value = roundVal(varEligibleAmount);	
	document.forms[0].txtmarginoffered.value=roundVal(varProjectCost-varRequestedAmount);
	callSanc();
}
//The following function is called from an iframe
function Eligibility_check()
{
	var varRequestedAmount = NanNumber(parseFloat(document.forms[0].txtloan_amtreqd.value));
	var varProjectCost = NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value));	
	var loan_sancamt=document.forms[0].txtloan_sancamt.value;
	var loan_downpay=document.forms[0].txtloan_downpay.value;
	var prd_rangefrom=document.forms[0].hidrangefrom.value;
	var prd_rangeto=document.forms[0].hidrangeto.value;	
	var intrate=document.forms[0].txtloan_intrate.value;
	var offeredmargin=document.forms[0].txtmarginoffered.value;	
	var principalratio;
	principalratio=document.forms[0].hidPrincipalRatio.value;
	var interestratio;
	interestratio=document.forms[0].hidInterestRatio.value;
	var MAX_ELIGIBLE_AMOUNT=document.forms[0].hidserviceamount.value;
	
	if(varProjectCost!="" && varProjectCost!="0.00" && intrate!="" && intrate!="0.00")
	{
		if(eval(loan_sancamt) < eval(prd_rangefrom))
		{
			alert("The Eligible Loan Amount is not within the Minimum Product Range");	
			document.forms[0].txtloan_sancamt.value="0";			
		}
		if(eval(loan_sancamt) > eval(prd_rangeto))
		{
			alert("The Eligible Loan Amount is Greater than Maximum Product Range");	
			document.forms[0].txtloan_sancamt.value=prd_rangeto;			
		}
		if(eval(offeredmargin) < eval(loan_downpay))
		{
			alert("Margin Offered by the Borrower is less than the stipulated Margin");					
		}
		var flag;
		if (eval(principalratio)>0 || eval(interestratio)>0) 
		{
			flag="false";	
		}
		if(eval(principalratio)==0 && eval(interestratio)==0)
		{
			flag="true";	
		}
		if(flag=="false")
		{
			if(eval(loan_sancamt)>eval(MAX_ELIGIBLE_AMOUNT))
			{
				alert("The Eligible Loan Amount  Based on Service "+MAX_ELIGIBLE_AMOUNT);
			}
		}
	}
}


function calculateStaffEMI()
{
	//This function calculates the Eligible loan amount based on Req amount, project cost, 
	// Eligiblity based on margin and eligibility based on salary.
	// This is called by the Iframe when changing the Cost of loan product or interest rate.
	
	var varLoanAmount = NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value));
	var varInterest = NanNumber(parseFloat(document.forms[0].txtloan_modintrate.value));
	var varTerms = NanNumber(parseFloat(document.forms[0].txtloan_reqterms.value));
	var varPrinRatio = NanNumber(parseFloat(document.forms[0].hidPrincipalRatio.value));
	var varIntRatio = NanNumber(parseFloat(document.forms[0].hidInterestRatio.value));
	
	var varTotal = varPrinRatio + varIntRatio;
	var varTotalInterest = 0.0;
	var varPrinTerms = 0;
	var varIntTerms = 0;
	
	
//========= Calculate Monthly installment for staff --By Shahul 

	var repayCapacity = varTerms / varTotal;
	var principalPeriod = repayCapacity * varPrinRatio;
	var varPrinEMI = varLoanAmount / principalPeriod;
	document.forms[0].txtmonPay.value = roundVal(varPrinEMI); 
	var varOriginalLoan = varLoanAmount;
	
	//Calculating the total interest
	if(varIntTerms!="" && varIntTerms>0)
	{
		for(var i=0; i<varPrinTerms; i++)
		{
			varTotalInterest = varTotalInterest + (varLoanAmount * varInterest/1200);
			varLoanAmount = varLoanAmount - varPrinEMI;
		}
		document.forms[0].txtInterestEMI.value = roundVal(varTotalInterest/varIntTerms);
	}
	else
	{
		document.forms[0].txtInterestEMI.value = "0.00";
	}
}

function callCalender(name)
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			if(name=='txt_receiptcpc')
			{
				if(document.forms[0].txt_receiptcpc.readOnly)
				{
					alert("For CPC use Only");
				}
				else
				{
					showCal(appURL,name);
				}
			}
			else if(name=='txt_receiptclpu')
			{
				if(document.forms[0].txt_receiptclpu.readOnly)
				{
					alert("For CLPU use Only");
				}
				else
				{
					showCal(appURL,name);
				}
			}
			else
			{
				showCal(appURL,name);
			}
		}
	}
	
function disabledvalues()
{
	if(document.forms[0].selectinttype.value=="1" || document.forms[0].selectinttype.value=="2")
	{
		//document.all.sel1.style.visibility="visible";
	}
	else
	{
		document.all.sel1.style.visibility="hidden";
	}
}
	
	

/*
function checkStaffyearcal()
{
	var prd_code=document.forms[0].hidProductID.value;
	var EXserviceyear;
	
	EXserviceyear=document.forms[0].hidexserviceyear.value;
	if(EXserviceyear=="")
	{
		EXserviceyear="0";
	}
	var empserviceyear;
	empserviceyear=document.forms[0].hidyearsinbuss.value;
	
	if(empserviceyear=="")
	{
		empserviceyear="0";
	}
	var totalyear=eval(EXserviceyear)+eval(empserviceyear);
	document.forms[0].hidtotalyear.value=totalyear;
	document.all.ifrm.src=appURL+"action/iframestaffservice.jsp?hidBeanGetMethod=getStaffservice&hidBeanId=perapplicant&prd_code="+prd_code+"&totalyear="+totalyear;
}

function checkcalstaff()
{	 
	var loan_sancamt=document.forms[0].txtloan_sancamt.value;
	var minservice=document.forms[0].hidminservice.value;
	var maxservice=document.forms[0].hidmaxservice.value;
	var MAX_ELIGIBLE_AMOUNT=document.forms[0].hidserviceamount.value;
	if(minservice=="")
	{
		minservice="0";
	}
	if(maxservice=="")
	{
		minservice="0";
	}
	if(MAX_ELIGIBLE_AMOUNT=="")
	{
		MAX_ELIGIBLE_AMOUNT="0";
	}
	if(loan_sancamt=="")
	{
		loan_sancamt="0";
	}
	var principalratio;
	principalratio=document.forms[0].hidPrincipalRatio.value;
	var interestratio;
	interestratio=document.forms[0].hidInterestRatio.value;
	var EXselservice;
	EXselservice=document.forms[0].hidselexservice.value;
	var EXserviceyear;
	
	EXserviceyear=document.forms[0].hidexserviceyear.value;
	if(EXserviceyear=="")
	{
		EXserviceyear="0";
	}
	var empserviceyear;
	empserviceyear=document.forms[0].hidyearsinbuss.value;
	
	if(empserviceyear=="")
	{
		empserviceyear="0";
	}
	var totalyear=eval(EXserviceyear)+eval(empserviceyear);
	var flag;
	if (eval(principalratio)>0 || eval(interestratio)>0) 
	{
			 flag="false";	
			 	
	}
	if(eval(principalratio)==0 && eval(interestratio)==0)
	{
			 flag="true";	
			
	}
	
	if(flag=="false")
	{
		if(eval(totalyear)< eval(minservice))
		{
			alert("Years in Service is not within Product Range");
		}
		if(eval(totalyear)>eval(maxservice))
		{
			alert("Years in Service is not within Product Range");
		}
		
		
	}
}
*/
function checkDocRec()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(document.forms[0].appno.value=="new")
		{
			/*if(varEmpStatus=="4")
			{*/
				if(document.forms[0].sel_docreceived.value=="0")
				{
					alert("Select Document Received from Agriculturist");
					document.forms[0].sel_docreceived.focus();
					return;
				}
				else
				{
					varDocReceivedNew=document.forms[0].sel_docreceived.value;
					callDescHelp();
				}
			/*}
			else
			{
				callDescHelp();
			}*/
		}
		else
		{
			varPrdType=document.forms[0].prd_type.value;
			if(varPrdType=='pG'||varPrdType=='pR')
			{
				if(document.forms[0].sel_docreceived.value=="0")
				{
					alert("Please Select Document Received from Agriculturist before choosing the Product");
					document.forms[0].sel_docreceived.focus();
					return;
				}
				else
				{
					varDocReceivedNew=document.forms[0].sel_docreceived.value;
					callDescHelp();
				}
			}
			else
			{
				callDescHelp();
			}
		}
	}
}
	function disgold()
	{
		var producttype=document.forms[0].prd_type.value;
		if(producttype=="aH" || producttype=="pG")
		{
			document.all.g1.style.visibility="visible";
		}
		else
		{
			document.all.g1.style.visibility="hidden";
		}
	}

	function callOnLoad()
	{	
		
		if(document.forms[0].appno.value=="new")
		{	
			callDisableControls(true,false,true,true,false);
			document.forms[0].hideditflag.value="Y";
			placeValues();
			document.forms[0].hidAction.value="insert";
			if(document.forms[0].txtprd_desc.value=="---")
			{
				document.forms[0].txtprd_desc.value="";
			}
			disablefields(false);
			document.forms[0].appno.readOnly=true;
			document.forms[0].appname.readOnly=true;
			document.forms[0].appstatus.readOnly=true;
			
		}
		else if(document.forms[0].btnenable.value =="Y")
		{
			callDisableControls(false,true,true,true,false);
			placeValues();
			disablefields(true);
		}
		else
		{
			callDisableControls(true,true,true,true,false);
			placeValues();
			disablefields(true);
		}
		calculateLoanAmount();

	    if(subsidy!="")
		{
			document.forms[0].selectgovt.value=subsidy;
			/*
			* To store the value in the "Scheme Type " field
			*/
			if(scheme!="")
			{
				document.forms[0].schemetype.value=scheme;
			}
			else
			{
				document.forms[0].schemetype.value=0;
			}
			/*
			* To store the value in the "Sponsor Agency" field
			*/
			if(varsponseragency!="")
			{
				document.forms[0].sel_sponser_agency.value=varsponseragency;
			}
			else
			{
				document.forms[0].sel_sponser_agency.value="0";
			}
			/*
			* To store the value in the "Govt. Sponsor Scheme" field
			*/
			if(varsubsidytype!="")
			{
			document.forms[0].sel_subsidytype.value=varsubsidytype;
			}
			else
			{
				document.forms[0].sel_subsidytype.value="0";
			}
		}
		else
		{
			document.forms[0].selectgovt.value=2;
		}
	}

	function placeValues()
	{
		if(document.forms[0].prd_type.value=="pR")
		{
			document.forms[0].selectinttype.value="1";
			document.forms[0].sel_peridicity.value="n";
			document.forms[0].txtloan_reqterms.value="12";
			getrepayment();
			document.forms[0].txt_installments.value="0";
			document.forms[0].selrepaymenttype.value="12";
			document.all.idinttype1.style.visibility="hidden";
			document.all.idinttype2.style.visibility="hidden";
			document.all.idint1.style.visibility="hidden";
			document.all.idint2.style.visibility="hidden";
			document.all.idperiod.style.visibility="hidden";
			document.all.idperiod1.style.visibility="hidden";
			document.all.idperiod2.style.visibility="hidden";
			document.all.idmargin.style.visibility="hidden";
			document.all.id_secdisp.innerText="(Securities to be entered in Deposit Details page)";
		}
		if(document.forms[0].prd_type.value=="pG")
		{
			document.forms[0].sel_peridicity.value="n";
			document.all.idperiod1.style.visibility="hidden";
			document.all.idperiod1.style.position="absolute";
			document.all.idperiod2.style.visibility="hidden";
			document.all.idperiod2.style.position="absolute";
			document.all.idmargin.style.visibility="hidden";
			document.all.id_secdisp.innerText="(Securities to be entered in Gold Ornaments page)";
			
		}
		if(document.forms[0].prd_type.value=="aR")
		{
			document.forms[0].selectinttype.value="1";
			document.forms[0].sel_peridicity.value="n";
			document.forms[0].txtloan_reqterms.value="12";
			getrepayment();
			document.forms[0].txt_installments.value="0";
			//document.forms[0].selrepaymenttype.value="12";
		}
		document.all.idperiod.style.visibility="hidden";
		document.all.idperiod.style.position="absolute";
		/*if(document.forms[0].appno.value=="new")
		{
			if(varEmpStatus=="4")
			{
				document.all.id_docreceived.style.display="block";
			}
			else
			{
				document.all.id_docreceived.style.display="none";
			}
		}
		else
		{
			if((varPrdType=='pG'||varPrdType=='pR')&&varEmpStatus=="4")
			{
				document.all.id_docreceived.style.display="block";*/
				if(varDocRecvd!="")
				{
					document.forms[0].sel_docreceived.value=varDocRecvd;
				}
				else
				{
					document.forms[0].sel_docreceived.value="0";
				}
				if(varSpecialCust!="")
				{
					document.forms[0].sel_SpecialCust.value=varSpecialCust;
				}
				else
				{
					document.forms[0].sel_SpecialCust.value="N";
				}
			/*}
			else
			{
				document.all.id_docreceived.style.display="none";
			}
		}*/
		/*
		* To store the value in the "Periodicity of Installments" field
		*/
		if (installment != "")
		{
			document.forms[0].sel_peridicity.value = installment;
		}
		else 
		{
			document.forms[0].sel_peridicity.value = "m";
		}
		/*
		* For storing the option values based on the value of periodicity of installments
		*/
		getrepayment();
		/*
		* To store the value in the "Repayment Type" field
		*/

		if(varRepayType!="")
		{
			document.forms[0].selrepaymenttype.value=varRepayType;
		}
		else
		{
			document.forms[0].selrepaymenttype.value="0";
		}
		/*
		* To store the value in the "Facility Type" field
		*/
		if(varloan_facility=="")
		{
			document.forms[0].sel_facilitytype.value='0';
		}
		else
		{
			document.forms[0].sel_facilitytype.value=varloan_facility;
		}
		displaySpecify();
	}


	function callCalculateInterest()
	{
		var varIntType=document.forms[0].selectinttype.value ;	
		if(varIntType!="" && varIntType !=3 && varIntType !=0 )
		{	
			callCalculate();
		}
	}


	function doHelp()     
	{
		var hlpvar = appURL+"phlp/loan_appretail_apploanproduct.htm";
	  	var title = "ApplicantLoanProduct";
	  	var prop = "scrollbars=yes,width=600,height=450";	
	  	prop = prop + ",left=50,top=150";
	  	window.open(hlpvar,title,prop);
	}

	function showAckSearch()
	{		
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/searchAppinwradno.jsp?Category=LAD&CBSid="+varcbsid;
			var title = "Acknowledgement";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}	
	}

	function gototab(beanid,methodname,pagename)
	{
		if(document.forms[0].hideditflag.value=="N")
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

	function getrepayment()
	{
		if(document.forms[0].sel_peridicity.value =="m")
		{	
			if(document.forms[0].selectinttype.value=="3")
			{
				document.forms[0].selrepaymenttype.length=2;
				document.forms[0].selrepaymenttype.options[0].value="0";
				document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
				document.forms[0].selrepaymenttype.options[1].value="11";
				document.forms[0].selrepaymenttype.options[1].text="Slab";
			}
			else
			{
				document.forms[0].selrepaymenttype.length=10;
				document.forms[0].selrepaymenttype.options[0].value="0";
				document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
				document.forms[0].selrepaymenttype.options[1].value="1";
				document.forms[0].selrepaymenttype.options[1].text="Equated Monthly Installment";
				document.forms[0].selrepaymenttype.options[2].value="2";
				document.forms[0].selrepaymenttype.options[2].text="Structured Repayment Schedule";
				document.forms[0].selrepaymenttype.options[3].value="3";
				document.forms[0].selrepaymenttype.options[3].text="Graduated installments";
				document.forms[0].selrepaymenttype.options[4].value="4";
				document.forms[0].selrepaymenttype.options[4].text="Step Up";
				document.forms[0].selrepaymenttype.options[5].value="5";
				document.forms[0].selrepaymenttype.options[5].text="Step Down";
				document.forms[0].selrepaymenttype.options[6].value="6";
				document.forms[0].selrepaymenttype.options[6].text="Taper Down";
				document.forms[0].selrepaymenttype.options[7].value="7";
				document.forms[0].selrepaymenttype.options[7].text="Balloon";
				document.forms[0].selrepaymenttype.options[8].value="9";
				document.forms[0].selrepaymenttype.options[8].text="Flip Method";
				document.forms[0].selrepaymenttype.options[9].value="10";
				document.forms[0].selrepaymenttype.options[9].text="Equal Installments";
			}
		}
		else if(document.forms[0].sel_peridicity.value =="q" || document.forms[0].sel_peridicity.value =="h" || document.forms[0].sel_peridicity.value =="y")
		{		
			document.forms[0].selrepaymenttype.length=10;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="2";
			document.forms[0].selrepaymenttype.options[1].text="Structured Repayment Schedule";
			document.forms[0].selrepaymenttype.options[2].value="3";
			document.forms[0].selrepaymenttype.options[2].text="Graduated installments";
			document.forms[0].selrepaymenttype.options[3].value="4";
			document.forms[0].selrepaymenttype.options[3].text="Step Up";
			document.forms[0].selrepaymenttype.options[4].value="5";
			document.forms[0].selrepaymenttype.options[4].text="Step Down";
			document.forms[0].selrepaymenttype.options[5].value="6";
			document.forms[0].selrepaymenttype.options[5].text="Taper Down";
			document.forms[0].selrepaymenttype.options[6].value="7";
			document.forms[0].selrepaymenttype.options[6].text="Balloon";
			document.forms[0].selrepaymenttype.options[7].value="9";
			document.forms[0].selrepaymenttype.options[7].text="Flip Method";
			document.forms[0].selrepaymenttype.options[8].value="10";
			document.forms[0].selrepaymenttype.options[8].text="Equal Installments";
		}
		else if(document.forms[0].sel_peridicity.value =="n")
		{
			document.forms[0].selrepaymenttype.length=3;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="12";
			document.forms[0].selrepaymenttype.options[1].text="OverDraft";
			document.forms[0].selrepaymenttype.options[2].value="8";
			document.forms[0].selrepaymenttype.options[2].text="Bullet";
		}
	}

	function moratperiod()
	{
		if(document.forms[0].txt_installments.value=='0')
		{
			document.forms[0].interestservised.value="s"; 
		    document.forms[0].interestservised.disabled=true;	
		}
		else
		{
			var varrepayperiod="";
			var varmoratorium="";
			varrepayperiod=document.forms[0].txtloan_reqterms.value;
			varmoratorium=document.forms[0].txt_installments.value;
			if(eval(varrepayperiod)<=eval(varmoratorium))
			{
				alert("Initial Holiday/Gestation/ Moratorium Period cannot be greater than Repayment Period");
				document.forms[0].txt_installments.value="";
				document.forms[0].txt_installments.focus();
				return false;
			}
			else
			{
				document.forms[0].interestservised.disabled=false;	
			}
		}
		//The following function is called to recalculate the EMI
		callSanc();
	}

	function interestselect()
	{
		document.forms[0].selrepaymenttype.value="0";
	}
	function displaySpecify()
	{
		if(document.forms[0].sel_docreceived.value=="3"||
				document.forms[0].sel_docreceived.value=="4")
		{
			document.all.id_lbldocspecify.style.display="table-cell";
			document.all.id_txtdocspecify.style.display="table-cell";
		}
		else
		{
			document.all.id_lbldocspecify.style.display="none";
			document.all.id_txtdocspecify.style.display="none";
		}
	}
	function selsub()
	{
	    if(document.forms[0].selectgovt.value == "1")
		 {
	    	document.all.s1.style.visibility="visible";
	    	document.all.s1.style.position="relative";    		
	    	document.all.s2.style.visibility="visible";
	    	document.all.s2.style.position="relative";
	    }
	    else
	  	{
	    	document.all.s1.style.visibility="hidden";
	    	document.all.s1.style.position="absolute";
	    	document.all.s2.style.visibility="hidden";
	    	document.all.s2.style.position="absolute";

	   	}
	}
	function clearPrdDesc()
	{
		document.forms[0].txtprd_desc.value="";
	}
 

 

