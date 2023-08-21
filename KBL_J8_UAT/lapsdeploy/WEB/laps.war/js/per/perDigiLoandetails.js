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
			document.forms[0].elements[i].readOnly=bool;		  
		}		
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
			document.forms[0].action=appURL+"action/perDigiLoandetails.jsp";	
			document.forms[0].submit();
		}
	}
}

function doDelete()
{
	if(document.forms[0].hidNSDLFlag.value=="Y")
	{
		alert("You are not allowed to delete Vidyalakshmi proposals");
		return;
	}
	if(varRecordFlag=="Y")
	{
		//var varconfirm=ConfirmMsg('101');
		if(confirm("Do you want to delete the proposal?"))
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

		if(document.forms[0].selectinttype.value !="3" && (document.forms[0].hidStaffProduct.value != "Y" && document.forms[0].selectinttype.value !="13" ))
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
					/*document.all.amort1.style.visibility="visible";
					document.all.amort1.style.position="relative";
					document.all.amort2.style.visibility="visible";
					document.all.amort2.style.position="relative";*/
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
	if(document.forms[0].hidStaffProduct.value == "Y")
	{
		document.all.amort1.style.visibility="hidden";
		document.all.amort1.style.position="absolute";
		document.all.amort2.style.visibility="hidden";
		document.all.amort2.style.position="absolute";
	}
	
	if(repaymenttype=="1" || repaymenttype=="13")
	{
		document.forms[0].sel_peridicity.value="m";
		document.forms[0].sel_peridicity.disabled=true;
	}else{
		document.forms[0].sel_peridicity.disabled=false;
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
	if(varAppType!="P")
	{
		
		if(document.forms[0].prd_type.value=="pG" && document.forms[0].sel_mclrtype.value!="")
	    {
			var varvalue=document.forms[0].sel_mclrtype.value;
			var vararr=varvalue.split("@");
			if(vararr!=null)
			{
				if(vararr[0]!="ST")
				{
			    	alert("Reference type should be Six Month Treasury Bill for Gold Loan");
			    	document.forms[0].sel_mclrtype.value="";
			    	return;
				}
			}
	    }
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
				if(document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value!="OD")
			    {
			    	ShowAlert('121',"Total Value of securities");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
			    }
				else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
			    {
					
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
			    else if(document.forms[0].prd_type.value=="pM")
			    {
			    	ShowAlert('121',"Market Value of property");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else if(document.forms[0].prd_type.value=="pS")
			    {
			    	ShowAlert('121',"Total value of Shares");
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
			if(checktrim(document.forms[0].txtloan_reqterms.value)=="")
			{
				ShowAlert('121',"Repayment Period");
				return false;
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
					
					if(document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value!="OD")
					{
						ShowAlert(183);
						return;
					}
					else if((document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value=="OD")|| (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC"|| document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
					{
						
					}
					else if(document.forms[0].prd_type.value=="pL")
					{
						ShowAlert(184);
						return;
					}
					else if(document.forms[0].prd_type.value=="pM")
					{
						ShowAlert(186);
						return;
					}
					else if(document.forms[0].prd_type.value=="pS")
					{
						alert("Total value of shares cannot be less than Amount Requested");
						return;
					}
					else
					{
						ShowAlert(133);
						return;
					}
					if(document.forms[0].prd_type.value!="pV")
					{
						document.forms[0].txtloan_costloanprd.value="";
						document.forms[0].txtloan_costloanprd.focus();
						//return;
					}
				}
		   }
			if(varcostofloan=="0.00" && isNaN(varcostofloan))
			{    
				if(document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value!="OD")
			    {
			    	ShowAlert('121',"Total Value of securities");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
			    }
				else if((document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value=="OD")|| (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
			    {
			    	
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
			    else if(document.forms[0].prd_type.value=="pM")
			    {
			    	ShowAlert('121',"Market Value of property");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else if(document.forms[0].prd_type.value=="pS")
			    {
			    	ShowAlert('121',"Total value of shares");
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
				if(document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value!="OD")
			    {
			    	ShowAlert('121',"Total Value of securities");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
			    }
				else if((document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
			    {
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
			    else if(document.forms[0].prd_type.value=="pM")
			    {
			    	ShowAlert('121',"Market Value of property");
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;	    	
			    }
			    else if(document.forms[0].prd_type.value=="pS")
			    {
			    	ShowAlert('121',"Total value of shares");
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
		
		if(document.forms[0].selectinttype.value=="2" && parseInt(document.forms[0].sel_interesttype.length)>2 && document.forms[0].sel_interesttype.value=="")
		{
			alert("select ROI Type");
			document.forms[0].sel_interesttype.focus();
			return;
		}
		else if(document.forms[0].selectinttype.value=="2" && parseInt(document.forms[0].sel_interesttype.length)==2 && document.forms[0].sel_interesttype.value=="")
		{
			document.forms[0].sel_interesttype.options[1].selected=true;
		}
		var varScore="";
		if(document.forms[0].selectinttype.value=="2" && document.forms[0].sel_interesttype.value=="CIBIL")
		{
			var var1=(document.forms[0].hidCIBILDet.value).split("~");
			if(var1[0]!="Y" && var1[0]!="N")
			{
				alert("Please update Applicant CIBIL details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="Y" && var1[1]=="0")
			{
				alert("Please update Applicant CIBIL Score in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="N")
			{
				alert("Please verify Applicant CIBIL Score and update Details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else
			{
				varScore=var1[1];
			}
		}
		else if(document.forms[0].selectinttype.value=="2" && document.forms[0].sel_interesttype.value=="CRIF")
		{
			var var1=(document.forms[0].hidCRIFDet.value).split("~");
			if(var1[0]!="Y" && var1[0]!="N")
			{
				alert("Please update Applicant CRIF details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="Y" && var1[1]=="0")
			{
				alert("Please update Applicant CRIF Score in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="N")
			{
				alert("Please verify Applicant CRIF Score and update Details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else
			{
				varScore=var1[1];
			}
		}
		
		
	
		if(document.forms[0].selectinttype.value < 3 || document.forms[0].selectinttype.value == 4)
		{
			if(prdid!="")
			{	
				var varsel_interesttype=document.forms[0].sel_interesttype.value;
				
				if(varsel_interesttype=="")
					varsel_interesttype="O";
									
				document.forms[0].prdid1.value=prdid;
				document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getInterestRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"&morterms="+mortperiod+"&hidCategoryType="+varCategoryType+"&varProductType="+varProductType+"&hidpurpose="+purposeid+"&strROI="+varsel_interesttype+"&strScore="+varScore+"&strMCLRType="+document.forms[0].sel_mclrtype.value;
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
			calculateLoanAmount();
		}
		
		
		if(document.forms[0].selectinttype.value =="2" || document.forms[0].selectinttype.value=="1")
		{
			document.forms[0].selrepaymenttype.disabled = false;
			//document.all.calc1.style.visibility="visible";
			//document.all.calc2.style.visibility="visible";
			document.all.amort1.style.visibility="visible";
			document.all.amort2.style.visibility="visible";
			calculateLoanAmount();
			
		}
		if(document.forms[0].hidStaffProduct.value == "Y")
		{
			document.all.amort1.style.visibility="hidden";
			document.all.amort1.style.position="absolute";
			document.all.amort2.style.visibility="hidden";
			document.all.amort2.style.position="absolute";
		}
	}
	else
	{
		varFlag="false";
		var varPSterms = document.forms[0].hidPSterms.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i]=="BRTOMCLR")
			{
				varFlag="true";
			}
		}
		
		if(varFlag=="false")
		{
			return;
		}
		var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
		var prdid   = document.forms[0].hidProductID.value;
		var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
		var terms =trim(document.forms[0].txtloan_reqterms.value);
		var mortperiod=document.forms[0].txt_installments.value;
		if(mortperiod=="")
		{
			mortperiod=0;
		}
		var recmat  = document.forms[0].txtloan_sancamt.value;
		if(parseFloat(recmat)>parseFloat(varto))
		{
			recmat=varto;
		}
		if(parseFloat(recmat)<parseFloat(varfrom))
		{
			recmat=0;
		}
		if(recmat==0) 
			recmat=varamtreqst;
		
		
		if(document.forms[0].selectinttype.value=="2" && parseInt(document.forms[0].sel_interesttype.length)>2 && document.forms[0].sel_interesttype.value=="")
		{
			alert("select ROI Type");
			document.forms[0].sel_interesttype.focus();
			return;
		}
		else if(document.forms[0].selectinttype.value=="2" && parseInt(document.forms[0].sel_interesttype.length)==2 && document.forms[0].sel_interesttype.value=="")
		{
			document.forms[0].sel_interesttype.options[1].selected=true;
		}
		var varScore="";
		if(document.forms[0].selectinttype.value=="2" && document.forms[0].sel_interesttype.value=="CIBIL")
		{
			var var1=(document.forms[0].hidCIBILDet.value).split("~");
			if(var1[0]!="Y" && var1[0]!="N")
			{
				alert("Please update Applicant CIBIL details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="Y" && var1[1]=="0")
			{
				alert("Please update Applicant CIBIL Score in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="N")
			{
				alert("Please verify Applicant CIBIL Score and update Details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else
			{
				varScore=var1[1];
			}
		}
		else if(document.forms[0].selectinttype.value=="2" && document.forms[0].sel_interesttype.value=="CRIF")
		{
			var var1=(document.forms[0].hidCRIFDet.value).split("~");
			if(var1[0]!="Y" && var1[0]!="N")
			{
				alert("Please update Applicant CRIF details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="Y" && var1[1]=="0")
			{
				alert("Please update Applicant CRIF Score in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else if(var1[0]=="N")
			{
				alert("Please verify Applicant CRIF Score and update Details in Customer profile -> Rating/Defaulter tab");
				return;
			}
			else
			{
				varScore=var1[1];
			}
		}
				
		if(document.forms[0].selectinttype.value < 3 || document.forms[0].selectinttype.value == 4)
		{
			if(prdid!="")
			{	

				var varsel_interesttype=document.forms[0].sel_interesttype.value;
				
				if(varsel_interesttype=="")
					varsel_interesttype="O";
				
				document.forms[0].prdid1.value=prdid;
				document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getInterestRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"&morterms="+mortperiod+"&hidCategoryType="+varCategoryType+"&varProductType="+varProductType+"&hidpurpose="+purposeid+"&strROI="+varsel_interesttype+"&strScore="+varScore+"&strMCLRType="+document.forms[0].sel_mclrtype.value;
			}
		}
		else if(document.forms[0].selectinttype.value == 3 )
		{
			document.all.ifrm1.src=appURL+"action/iframeperinteresttype.jsp?hidBeanGetMethod=getStepupRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+recmat+"&terms="+terms+"&costloanprd="+varcostofloan+"hidpurpose="+purposeid;
			document.all.amort1.style.visibility="visible";
			document.all.amort2.style.visibility="visible";
		}
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
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		document.forms[0].txtloan_sancamt.value="";
	}
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
						  if(document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value!="OD")
							{
							alert("Amount requested cannot be greater than Total Value of securities");
							document.forms[0].txtloan_amtreqd.value="";
							document.forms[0].txtloan_amtreqd.focus();
							return;								
					
							}
						  else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
							{
							  document.forms[0].txtloan_costloanprd.readOnly=true;
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
						else if(document.forms[0].prd_type.value=="pM")
						{
						alert("Amount requested cannot be greater than Market Value of property");
						document.forms[0].txtloan_amtreqd.value="";
						document.forms[0].txtloan_amtreqd.focus();
						return;
						}
						else if(document.forms[0].prd_type.value=="pS")
						{
							alert("Amount requested cannot be greater than Total value of shares");
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
		
		if((document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
		{
			if(document.forms[0].prd_type.value!="pV")
			{
				document.forms[0].txtloan_costloanprd.value=document.forms[0].txtloan_amtreqd.value;
			}
			document.all.costproject1.style.visibility = "hidden";
			document.all.costproject1.style.position = "absolute";

			document.all.costproject2.style.visibility = "hidden";
			document.all.costproject2.style.position = "absolute";

			document.all.costproject3.style.visibility = "hidden";
			document.all.costproject3.style.position = "absolute";

			document.all.costproject4.style.visibility = "hidden";
			document.all.costproject4.style.position = "absolute";

			document.all.costproject5.style.visibility = "visible";
			document.all.costproject5.style.position = "relative";

		}
		else
		{
			document.all.costproject1.style.visibility = "visible";
			document.all.costproject1.style.position = "relative";
		
		   	document.all.costproject2.style.visibility = "visible";
			document.all.costproject2.style.position = "relative";
		
			document.all.costproject3.style.visibility = "visible";
			document.all.costproject3.style.position = "relative";
		
			document.all.costproject4.style.visibility = "visible";
			document.all.costproject4.style.position = "relative";
		
			document.all.costproject5.style.visibility = "hidden";
			document.all.costproject5.style.position = "absolute";
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
	if((varcostofloan<varamtreqst)&& !((document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ")))
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
				if(servised == "n" && moritorium > 0 && interestcharged=="2")
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
					var var_terms=parseFloat(trim(document.forms[0].txtloan_reqterms.value))-parseFloat(moritorium);// - parseFloat(moritorium);
					varrate=parseFloat(document.forms[0].txtloan_modintrate.value)/(12*100);
					var denominator=Math.pow(varrate+1,var_terms)-1;
					var varnumerator=varrate*Math.pow(varrate+1,var_terms);
					var varemi=Math.ceil((varnumerator/denominator)*varAmtrecomd);
					var vartotal=varemi*var_terms;
					if(document.forms[0].hidStaffProduct.value == "Y")
					{
						if(document.forms[0].prd_type.value == "pH")
						{
						var_terms="270";
						var_terms=parseFloat(var_terms)-parseFloat(moritorium);
						}
						varemi=varAmtrecomd/var_terms;
					}
					varemi=Math.round(varemi);
					document.forms[0].txtmonPay.value=roundVal(varemi);
					roundtxt(document.forms[0].txtmonPay);
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
				if(document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value!="OD")
			    {
			    	ShowAlert('121',"Total Value of securities");
			    	document.forms[0].txtloan_costloanprd.value="";
				 	document.forms[0].txtloan_costloanprd.focus();
				 	return;
			    }
				else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
				{
					
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
			    else if(document.forms[0].prd_type.value=="pM")
			    {
			    	ShowAlert('121',"Market Value of property");
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
				if(document.forms[0].txtprd_desc.value=="----")
				{
					varconfirm=true;
				}
				else
				{
					varconfirm=ConfirmMsg('175');
				}
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

function doEditOld()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="update";
	document.forms[0].txt_receivedRH.readOnly=true;
	if(document.forms[0].hidCategoryType.value!="LAD" && varCGTMSE_APPLICABLE=="Y"){
		document.forms[0].CGTMSE_coverage.disabled=true;//for cgtmse button
	}
	//document.forms[0].CGTMSE_coverage.disabled=true;//for cgtmse button
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
	}
	
	else
	{
	document.forms[0].appno.readOnly=true;
	document.forms[0].appname.readOnly=true;
	document.forms[0].strappstatus.readOnly=true;
	}
	if((document.forms[0].prd_type.value=="pI" || document.forms[0].prd_type.value=="pM") && document.forms[0].hidODFlag.value=="OD")
	{
		if(document.forms[0].prd_type.value=="pI")
		{
			document.forms[0].txtloan_costloanprd.readOnly=true;
		}
		document.forms[0].sel_intcalcmode.disabled=true;
	}
	if(document.forms[0].prd_type.value=="pH" && document.forms[0].hidpurpose.value=="F")
	{
		document.forms[0].sel_intcalcmode.disabled=true;
	}
	if(document.forms[0].selrepaymenttype.value=="1" || document.forms[0].selrepaymenttype.value=="13")
	{
		document.forms[0].sel_peridicity.value="m";
		document.forms[0].sel_peridicity.disabled=true;
	}
	document.forms[0].selectgovt.disabled = true;
	document.forms[0].schemetype.disabled = true;
	document.forms[0].sel_subsidytype.disabled = true;
	document.forms[0].sub.disabled = true;
	document.forms[0].sel_sponser_agency.disabled = true;
	document.forms[0].txt_agency.readOnly = true;
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		document.forms[0].txt_cg_gst.readOnly = true;
		document.forms[0].txt_cg_int_rate.readOnly = true;
	}

	if(varAppType=="P")
	{
		CallPostSancRestriction();
	}
	
	if(val=="C")
	{
	document.forms[0].sel_ECSBankName.disabled = false;
	document.forms[0].sel_ECSBankName.readOnly = false;
	
	document.forms[0].sel_ECSaccnttype.disabled = false;
	document.forms[0].sel_ECSaccnttype.readOnly = false;
	
	document.forms[0].txt_ECSoperaccno.disabled = false;
	document.forms[0].txt_ECSoperaccno.readOnly = false;
	
	document.forms[0].sel_ECSauthmode.disabled = false;
	document.forms[0].sel_ECSauthmode.readOnly = false;
	
	document.forms[0].txt_ECSifsccode.disabled = false;
	document.forms[0].txt_ECSifsccode.readOnly = false;
	}
	document.forms[0].txt_ECSifsccode.readOnly = false;
	document.forms[0].txt_ECSoperaccno.readOnly = false;

	
	
}

function doEdit()
{
	document.forms[0].txt_ECSoperaccno.readOnly = false;
	document.forms[0].txt_ECSifsccode.readOnly = false;
	//govt scheme
	callDisableControls(true,false,true,false,false);
	document.forms[0].selectgovt.disabled = true;
	document.forms[0].schemetype.disabled = true;
	document.forms[0].sel_subsidytype.disabled = true;
	document.forms[0].sub.disabled = false;
	document.forms[0].sub.readOnly = false;
	document.forms[0].sel_sponser_agency.disabled = true;
	document.forms[0].txt_agency.disabled = true;
	document.forms[0].txt_agency.readOnly = true;
	
	
	document.forms[0].sel_Processed_Type.disabled = false;
	document.forms[0].txt_metloanpremium.disabled = false;
	document.forms[0].txt_metloanpremium.readOnly = false;
	document.forms[0].txt_premium_tenor.disabled = false;
	document.forms[0].txt_premium_tenor.readOnly = false;
	document.forms[0].txt_premium_loan_amt.disabled = false;
	document.forms[0].txt_premium_loan_amt.readOnly = false;
	document.forms[0].txt_premium_Account_no.disabled = false;
	document.forms[0].txt_premium_Account_no.readOnly = false;
	document.forms[0].sel_Funded_Comp_Name.disabled = false;

	
	document.forms[0].txtloan_amtreqd.disabled = false;
	document.forms[0].txtloan_amtreqd.readOnly = false;
	//document.forms[0].txtloan_reqterms.disabled = false;
	//document.forms[0].txtloan_reqterms.readOnly = false;
	
	document.forms[0].txt_fileNo.disabled = false;
	document.forms[0].txt_fileNo.readOnly = false;
	
	document.forms[0].txtloan_costloanprd.disabled = false;
	document.forms[0].txtloan_costloanprd.readOnly = false;
	if(varPrdType=='pB'){
	document.forms[0].txtloan_SecValue.disabled = false;
	document.forms[0].txtloan_SecValue.readOnly = false;
	}
	document.forms[0].selmodepayment.disabled = false;
	document.forms[0].txt_operativeaccno.readOnly = false;
	if(varPrdType=='pH' || varPrdType=='pA' || varPrdType=='pB' || varPrdType=='pM' )
	{
		if(document.forms[0].cmdedit.disabled==true)
		{
			document.forms[0].cmdroiupdate.disabled=false;
		}
	}
	
	if(val=="C")
	{
	document.forms[0].sel_ECSBankName.disabled = false;
	document.forms[0].sel_ECSBankName.readOnly = false;
	
	document.forms[0].sel_ECSaccnttype.disabled = false;
	document.forms[0].sel_ECSaccnttype.readOnly = false;
	
	document.forms[0].txt_ECSoperaccno.disabled = false;
	document.forms[0].txt_ECSoperaccno.readOnly = false;
	
	document.forms[0].sel_ECSauthmode.disabled = false;
	document.forms[0].sel_ECSauthmode.readOnly = false;
	
	document.forms[0].txt_ECSifsccode.disabled = false;
	document.forms[0].txt_ECSifsccode.readOnly = false;
	}
	
}


function CallPostSancRestriction()
{
	disablefields(true);
	document.forms[0].selrepaymenttype.disabled = true;
	document.all.idprdsel.style.display="none";
	var varPSterms = document.forms[0].hidPSterms.value.split("@");
	for(var i=0;i<varPSterms.length;i++)
	{
		if(varPSterms[i] == "DLP")
		{
			document.forms[0].txtloan_reqterms.readOnly = false;
		}
		if(varPSterms[i] == "MRI")
		{
			document.forms[0].txtloan_modintrate.readOnly = false;
		}
		if(varPSterms[i] == "SLILA")
		{
			document.forms[0].txtloan_amtreqd.readOnly = false;
		}
		if(varPSterms[i] == "BRTOMCLR")
		{
			document.forms[0].sel_mclrtype.disabled = false;
		}
		if(varPSterms[i] == "MODGSS")
		{
			document.forms[0].selectgovt.disabled = false;
			
			if(document.forms[0].selectgovt.value=="1")
			{
				document.forms[0].sub.disabled=false;
	    		document.forms[0].sub.readOnly=false;
	        	document.forms[0].schemetype.disabled=false;
	        	document.forms[0].sel_sponser_agency.disabled=false;
	        	document.forms[0].sel_subsidytype.disabled=false;
	        	document.forms[0].txt_agency.readOnly=false;
			}
		}
	}
}

function doSaveOld()
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
	var hidmortflag=document.forms[0].hidmortflag.value;
	
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
	document.forms[0].sel_interestcharge.disabled=false;
	if(document.forms[0].sel_interestcharge.value=="")
	{
		document.forms[0].sel_interestcharge.value = "1";
	}
	var intser= checktrim(document.forms[0].interestservised.value);
	if(varinwardnorequired=="" && document.forms[0].txt_appinwardno.value =="")
	{
		ShowAlert('111',"Application No");
		return false;
	}
	if(varprd_desc=="----"||varprd_desc=="")
	{
		ShowAlert('111',"Loan Product");
		return false;
	}
	var hidODFlag=document.forms[0].hidODFlag.value;
	if(varAppType=="R")
	{
		if(hidODFlag!="OD")
		{
			alert("Only Over Draft loans are allowed for Renew proposal. Kindly select OD product.");
			return;
		}
	}
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		if(document.forms[0].appno.value=="new" && document.forms[0].prd_type.value=="pE" && document.forms[0].hidNSDLRefNo.value=="")
		{
			alert("Off line Educational loan proposals are not allowed. All the proposals should processed via Vidyalakshmi only");
			return;
		}
	}
	if(varAppType!="P")
	{
		if(document.forms[0].hidprdbankscheme.value!=document.forms[0].hidLARbankscheme.value)
		{
			alert("Product Bank Scheme differs from Attached LAR Bank Scheme.");
			return;
		}
	}
	if(varamtreqst == "" || varamtreqst == "0.00"){
		ShowAlert('121'," Amount Requested");
	 	document.forms[0].txtloan_amtreqd.focus();
	 	return;
	}
	if(varAppType!="P")
	{
		if(parseFloat(varamtreqst)>parseFloat(document.forms[0].hidinwardAmt.value))
		{
			alert("Amount Requested should not be greater than Attached LAR Requested Limit");
			return;
		}
	}
	if(document.forms[0].hidCategoryType.value!="LAD" && varAppType!="P")
	{
		if(document.forms[0].sel_take_over.value=="0" || document.forms[0].sel_take_over.value=="")
		{
			ShowAlert('111',"Whether Take-Over");
		 	document.forms[0].sel_take_over.focus();
		 	return;
		}
	}
	
	if(document.forms[0].hidCategoryType.value!="LAD" && varAppType!="P")
	{
		//if(document.forms[0].hid_cgtmse_applicable.value=="Y")
		{
			if(document.forms[0].sel_wht_cgtmse.value=="")
			{
				ShowAlert('111',"Whether CGTMSE applicable");
			 	document.forms[0].sel_wht_cgtmse.focus();
			 	return;
			}
		}
	}
	/*if(renewflag=="R")	{ 
		if(document.forms[0].txt_duedate.value=="")
		{
			ShowAlert('111',"Due date");
		 	document.forms[0].txt_duedate.focus();
		 	return;
		}
		
	}*/
	if(document.forms[0].prd_type.value=="pL" && varAppType!="P")
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
		
		if(document.forms[0].txt_unexpiredlock.value=="")
		{
			ShowAlert('121',"Unexpired Lock Period");
			document.forms[0].txt_unexpiredlock.focus();
			return false;
		}	
		if(document.forms[0].sel_downwardrevision.value=="s")
		{
			ShowAlert('111',"Whether Downward revision in the rentals during the loan period");
			document.forms[0].sel_downwardrevision.focus();
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
	    if(document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value!="OD")
	    {
	    	ShowAlert('121',"Total Value of securities");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;
	    }
	    else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
	    {
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
	    else if(document.forms[0].prd_type.value=="pM")
	    {
	    	ShowAlert('121',"Market Value of property");
		 	document.forms[0].txtloan_costloanprd.focus();
		 	return;	    	
	    }
	    else if(document.forms[0].prd_type.value=="pS")
	    {
	    	ShowAlert('121',"Total value of shares");
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
	if(document.forms[0].txt_installments.value!="0" && document.forms[0].txt_installments.value!="")
	{		
		if(document.forms[0].interestservised.value=="s")
		{
			alert("Select Interest to be collected during Holiday");
			document.forms[0].interestservised.focus();
			return false;			
		}		
	}
	if(hidmortflag=='N')
	{
		if(varAppType!="P")
		{
			if(document.forms[0].sel_peridicity.value=="s")
			{
				alert("Select Periodicity of Installments ");
				document.forms[0].sel_peridicity.focus();
				return;
			}
		}
	}

if(varAppType!="P")
{
	if(varpurposeofloan == "")
	{
		alert("Enter Purpose of Loan");
		document.forms[0].txtloan_purposeofloan.focus();
		return false;
	}
	
	if(hidmortflag=='N')
	{
		if(document.forms[0].selrepaymenttype.value =="0")
		{
			ShowAlert('111',"Repayment Type");
			document.forms[0].selrepaymenttype.focus();
			return false;
		}
	}
	if(document.forms[0].selmodepayment.value=="0")
	{
		ShowAlert('111',"Mode of Payment");
		document.forms[0].selmodepayment.focus();
		return false;
	}
}


if(varAppType!="P" && document.forms[0].selectgovt.value=="1" && (document.forms[0].schemetype.value=="078" || document.forms[0].schemetype.value=="079"))
{
	if(document.forms[0].hidconstitution.value!="01" || document.forms[0].selrepaymenttype.value!="1")
	{
		alert("PMAY Loans Eligible only for Individual Constitution and EMI Loans only");
		return;
	}
}

if(document.forms[0].hidCategoryType.value!="LAD")
{
	if(document.forms[0].sel_wht_cgtmse.value=="Y")
	{
		
		if(document.forms[0].txt_cg_gua_fee.value=="" || document.forms[0].sel_cg_fee.value=="0.00")
		{
			alert("Enter Guarantee Fee");
			document.forms[0].txt_cg_gua_fee.focus();
			return false;
		}
		if(document.forms[0].sel_cg_fee.value=="" || document.forms[0].sel_cg_fee.value=="0")
		{
			ShowAlert('111',"CGTMSE Interest rate Split-up");
			document.forms[0].sel_cg_fee.focus();
			return false;
		}
		if(document.forms[0].txt_cg_gst.value=="0" || document.forms[0].txt_cg_gst.value=="0.00" )
		{
			alert("Enter GST on Guarantee Fee");
			document.forms[0].txt_cg_gua_fee.focus();
			return false;
		}
		cggstcal();
	}
}

/*if(document.forms[0].hidCategoryType.value=="RET" && varAppType!="P")
{
	if(document.forms[0].CFR_verified.value=="")
	{
		ShowAlert('111',"Whether verfied with Central Fraud Registry?");
		document.forms[0].CFR_verified.focus();
		return false;
	}
	if(document.forms[0].CFR_verified.value=="Y")
	{
		if(document.forms[0].Namein_CFR.value=="")
		{
			ShowAlert('111',"Whether Applicant/Co-applicant/Guarantor/Proprietor/Partner name appears in CFR ");
			document.forms[0].Namein_CFR.focus();
			return false;
		}
		else if(document.forms[0].Namein_CFR.value=="Y")
		{
			if(document.forms[0].txt_CFRdev_refno.value=="")
			{ 
				ShowAlert('121',"CFR Deviation Reference number");
				document.forms[0].txt_CFRdev_refno.focus();
				return false;
			}
		}
	}
}*/
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
	else
	{
		if(varAppType!="P")
		{
			if(document.forms[0].txt_metloanpremium.value=="")
			{
				ShowAlert('121',"One time Single Premium for Met Loan & Life Suraksha");
				document.forms[0].txt_metloanpremium.focus();
				return false;
			}
		}
	}
	if(varreceived == "")
	{
		alert("Enter the Application Received Date");
		document.forms[0].txt_receivedRH.focus();
		return false;
	}
	
	if(document.forms[0].hidCategoryType.value!="LAD" && varAppType!="P")
	{
		if(document.forms[0].txt_fileNo.value=="")
		{
			alert("Enter the Party File No");
			document.forms[0].txt_fileNo.focus();
			return false;
		}
	}
	
	if(strOrgLevel=="D")
	{	
		//if(document.forms[0].txt_receiptclpu.value=="")
		{
		  //alert("Enter Date of receipt of complete information @ CLPU");
		  //document.forms[0].txt_receiptclpu.focus();
		  //return false;			
		}		
	}
	if((strOrgLevel=="C" || strOrgLevel=="R") && strOrgcode!="001001000000000")
	{	
		if(document.forms[0].txt_receiptroho.value=="")
		{
			alert("Enter Date of Receipt at RO/HO");
			document.forms[0].txt_receiptroho.focus();
			return false;			
		}		
	}
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		if(strOrgLevel=="C" || strOrgLevel=="R")
		{	
			if(document.forms[0].txt_receiptcpc.value=="")
			{
			  alert("Enter Date of Receipt at CPC/RO/HO");
			  document.forms[0].txt_receiptcpc.focus();
			  return false;			
			}		
		}
	}
	if(varfiledon == "")
	{
		alert("Enter Application Processed On");
		document.forms[0].txtloan_filedon.focus();
		return false;
	}
	if(varAppType=="P" && document.forms[0].hidCategoryType.value!="LAD")
	{
		var varhidPSterms=document.forms[0].hidPSterms.value; 
		if(varhidPSterms.indexOf("BRTOMCLR")>=0)
		{
			if(document.forms[0].txt_migrationdate.value=="")
			{
			  alert("Enter Effective date of Migration");
			  document.forms[0].txt_migrationdate.focus();
			  return false;			
			}	
		}
	}
	else if(varAppType!="P" && document.forms[0].hidCategoryType.value!="LAD" && varPrdType=='pS')
	{
		if(document.forms[0].hidSharetype.value=="P")
		{
			if((eval(document.forms[0].hidPhysicalLimitAvailed.value)+eval(document.forms[0].txtloan_amtreqd.value))>eval(document.forms[0].hidPhysicalLimit.value))
			{
				alert("Physical form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidPhysicalLimit.value)-eval(document.forms[0].hidPhysicalLimitAvailed.value)));
				return;
			}
		}
		else if(document.forms[0].hidSharetype.value=="D")
		{
			if((eval(document.forms[0].hidDematLimitAvailed.value)+eval(document.forms[0].txtloan_amtreqd.value))>eval(document.forms[0].hidDematLimit.value))
			{
				alert("Demat form of loan against share limit exceeds for this borrower.\n You can avail only Rs."+roundVal(eval(document.forms[0].hidDematLimit.value)-eval(document.forms[0].hidDematLimitAvailed.value)));
				return;
			}
		}
	}
	
	if(document.forms[0].prd_type.value=='pH' && document.forms[0].hidpurpose.value=='H')
	{
		if(document.forms[0].txt_vehage.value=="")
		{
			alert("Enter Age of the Premises");
			document.forms[0].txt_vehage.focus();
			return;
		}
		
	}
	else if(document.forms[0].prd_type.value=='pA' && document.forms[0].hidpurpose.value=='U')
	{
		if(document.forms[0].txt_vehage.value=="")
		{
			alert("Enter Age of Vehicle");
			document.forms[0].txt_vehage.focus();
			return;
		}	
	}
	else if(document.forms[0].prd_type.value=='pU' && document.forms[0].hidvehicletype.value=='2')
	{
		if(document.forms[0].txt_vehage.value=="")
		{
			alert("Enter Age of Vehicle");
			document.forms[0].txt_vehage.focus();
			return;
		}	
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
	if(document.forms[0].selmodepayment.value=="C" )
	{
		if(document.forms[0].sel_ECSBankName.value=="0")
		{
		alert("Select the Bank Name");
		document.forms[0].sel_ECSBankName.focus();
		return;	
		}
		
		if(document.forms[0].sel_ECSaccnttype.value=="0")
		{
		alert("Select the Account Type");
		document.forms[0].sel_ECSaccnttype.focus();
		return;	
		}
		
		if(document.forms[0].txt_ECSoperaccno.value=="")
		{
		alert("Enter the Oper Account Number");
		document.forms[0].txt_ECSoperaccno.focus();
		return;	
		}
		
		if(document.forms[0].sel_ECSauthmode.value=="0")
		{
		alert("Select the Athunenticate Mode");
		document.forms[0].sel_ECSauthmode.focus();
		return;	
		}
		
		if(document.forms[0].txt_ECSifsccode.value=="")
		{
		alert("Enter the IFSC CODE");
		document.forms[0].txt_ECSifsccode.focus();
		return;	
		}}
	if (intser !="s" && (mor =="" || mor=="0"))
	{
		document.forms[0].interestservised.value="s";
	}
	if(varPrdType=="pR" && document.forms[0].hiddeposittype.value=="G")
	{
		//No check is required
	}
	else
	{
		if(document.forms[0].txtloan_modintrate.value =="0.00" || document.forms[0].txtloan_modintrate.value =="")
		{
			alert("No Interest rate Defined");
			return;
		}
	}
	
 if(varAppType!="P")
 {
	if(document.forms[0].selectgovt.value=="")
	{
		ShowAlert(111,'Govt Sponsor scheme');
		document.forms[0].selectgovt.focus();
		return;
	}
 
	if(document.forms[0].selectgovt.value=="1")
	{
		if(document.forms[0].schemetype.value=="0")
		{
			ShowAlert(111,'Scheme Type');
			document.forms[0].schemetype.focus();
			return;
		}
		if(document.forms[0].sel_sponser_agency.value=="0")
		{
			ShowAlert(111,'Sponsor agency');
			document.forms[0].sel_sponser_agency.focus();
			return;
		}
		if(document.forms[0].sel_subsidytype.value=="0")
		{
			ShowAlert(111,'Subsidy Type');
			document.forms[0].sel_subsidytype.focus();
			return;
		}
		document.forms[0].sub.disabled=false;
		document.forms[0].txt_agency.readOnly=false;
	}
	else
	{
		document.forms[0].schemetype.value="0";
		document.forms[0].sel_sponser_agency.value="0";
		document.forms[0].sel_subsidytype.value="0";
		document.forms[0].sub.value="";
		document.forms[0].txt_agency.value="";
	}
 }
	if(document.forms[0].hidPrdReselectFlag.value=="Y" && varAppType!="P")
	{
		alert("Product Expired / Not Available. Please Reselect the Product");
		return;
	}
	if(document.forms[0].sel_CERSAI_check.value=="S")
	{
		 ShowAlert(111,'Whether CERSAI data base checked?');
		  document.forms[0].sel_CERSAI_check.focus();
		  return;
	}
	if(varAppType=="S")
	{
		if(document.forms[0].sel_restr_scheme.value=="")
		{
			 ShowAlert(111,'Restructure Settlement Scheme');
			  document.forms[0].sel_restr_scheme.focus();
			  return;
		}
	}
	
	if(varappraisalFlag=="Y")
	{
		if(confirm("Appraisal -> Loan details will be delete, Do you want to Continue?"))
		{
			//do Nothing
		}
		else
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
			return;
		}
	}
	
	
	if(varterm!="")
	{
		if(varamtreqst!=0.0 && !isNaN(varamtreqst))
		{
			if((varcostofloan!=0.0 && !isNaN(varcostofloan))||(document.forms[0].hidCategoryType.value=="LAD") || (document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
			{
				if(page.toUpperCase()=="NR")
				{
					disablefields(false);
					if(varInterestType<3)
					{
						callCalculate();
						calculateLoanAmount();
					}
					if(document.forms[0].txtmonPay.value=="")
					{
						document.forms[0].txtmonPay.value="0.00";	
					}
					document.forms[0].txtmonPay.value=NanNumber(document.forms[0].txtmonPay.value);
					document.forms[0].hidDeleteDeviationFlag.value=varDeleteDeviationEntries;
					document.forms[0].txtmarginoffered.value=(NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value))-NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value)));
					document.forms[0].cmdsave.disabled=true;
					document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
					document.forms[0].hidBeanId.value="perapplicant";
					if(document.forms[0].hidCategoryType.value=="LAD")
					{
						document.forms[0].action=appURL+"action/ladloandetails.jsp";	
					}
					else
					{
						document.forms[0].action=appURL+"action/perloandetails.jsp";	
						if(varInterestType<3)
						{
							callCalculate();
						}
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
					document.forms[0].txtmonPay.value=NanNumber(document.forms[0].txtmonPay.value);
					document.forms[0].hidDeleteDeviationFlag.value=varDeleteDeviationEntries;
					document.forms[0].txtmarginoffered.value=roundVal(NanNumber(parseFloat(document.forms[0].txtloan_costloanprd.value))-NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value)));
					document.forms[0].cmdsave.disabled=true;
					document.forms[0].hidBeanGetMethod.value="updateLoanProducts";
					document.forms[0].hidBeanId.value="perapplicant";
					if(document.forms[0].hidCategoryType.value=="LAD")
					{
						document.forms[0].action=appURL+"action/ladloandetails.jsp";	
					}
					else
					{
						document.forms[0].action=appURL+"action/perloandetails.jsp";	
						if(varInterestType<3)
						{
							callCalculate();
						}
					}
					document.forms[0].submit();						
				}
			}
			else
			{
				if(document.forms[0].hidCategoryType.value!="LAD")
				{
					if(document.forms[0].prd_type.value=="pI"  && document.forms[0].hidODFlag.value!="OD")
				    {
				    	ShowAlert('121',"Total Value of securities");
					 	document.forms[0].txtloan_costloanprd.focus();
					 	return;
				    }
					else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
					{
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
				    else if(document.forms[0].prd_type.value=="pM" || (document.forms[0].prd_type.value=="pH" && document.forms[0].hidpurpose.value=="T"))
				    {
				    	ShowAlert('121',"Market Value of property");
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
	//getInterestValue();
	}
}

function doSave()
{
		var descvalue=(document.forms[0].txtprd_desc.value).split("-");
		var varfrom=descvalue[descvalue.length-3];			
		var varto=descvalue[descvalue.length-2];
		var amtvalue=document.forms[0].txtloan_amtreqd.value;
		
		if(parseFloat(amtvalue)>parseFloat(varto) || parseFloat(amtvalue)<parseFloat(varfrom))
			{
				ShowAlert('137');
				document.forms[0].txtloan_amtreqd.value="";
				document.forms[0].txtloan_amtreqd.focus();
				return;
			}
		
	if(document.forms[0].selmodepayment.value=="0")
	{
		ShowAlert('111',"Mode of Payment");
		document.forms[0].selmodepayment.focus();
		return false;
	}
	
	var varamtreqst=parseFloat(document.forms[0].txtloan_amtreqd.value);
	if((checktrim(document.forms[0].txtloan_amtreqd.value)=="")||(varamtreqst=="0.00" && isNaN(varamtreqst)))
	{	
		ShowAlert('121',"Amount Requested");
		document.forms[0].txtloan_amtreqd.value="";
		document.forms[0].txtloan_amtreqd.focus();
		return false;
	}
	
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
	}else{
		document.forms[0].txt_operativeaccno.disabled=true;
	}
	if(val=="C")
	{
	if(document.forms[0].sel_ECSBankName.value=="0")
	{
	alert("Select the Bank Name");
	document.forms[0].sel_ECSBankName.value="";
	return;	
	}
	
	if(document.forms[0].sel_ECSaccnttype.value=="0")
	{
	alert("Select the Account Type");
	document.forms[0].sel_ECSaccnttype.value="";
	return;	
	}
	
	if(document.forms[0].txt_ECSoperaccno.value=="")
	{
	alert("Enter the Oper Account Number");
	document.forms[0].txt_ECSoperaccno.value="";
	return;	
	}
	
	if(document.forms[0].sel_ECSauthmode.value=="0")
	{
	alert("Select the Athunenticate Mode");
	document.forms[0].sel_ECSauthmode.value="";
	return;	
	}
	
	if(document.forms[0].txt_ECSifsccode.value=="")
	{
	alert("Enter the IFSC CODE");
	document.forms[0].txt_ECSifsccode.value="";
	return;	
	}
	}
	if(varAppType!="P")
	{
		if(document.forms[0].sel_Processed_Type.value=="")
		{
			ShowAlert('111',"Insurance Covered Under");
			document.forms[0].sel_Processed_Type.focus();
			return false;
		}
		if(document.forms[0].sel_Processed_Type.value!="NC" && (document.forms[0].txt_metloanpremium.value==""||document.forms[0].txt_metloanpremium.value=="0" || document.forms[0].txt_metloanpremium.value=="0.00"))
		{
			ShowAlert('121',"Premium amount for "+document.forms[0].sel_Processed_Type.options[document.forms[0].sel_Processed_Type.selectedIndex].text+" should not be 0");
			document.forms[0].txt_metloanpremium.focus();
			return false;
		}
		
		if(document.forms[0].sel_Processed_Type.value!="NC")
		{
			if(document.forms[0].txt_premium_tenor.value==""  || document.forms[0].txt_premium_tenor.value=="0"  || document.forms[0].txt_premium_tenor.value=="0.00")
			{
				ShowAlert('121',"Premium Tenor");
				document.forms[0].txt_premium_tenor.focus();
				return false;
			}
			
			if(document.forms[0].txt_premium_loan_amt.value=="" || document.forms[0].txt_premium_loan_amt.value=="0" || document.forms[0].txt_premium_loan_amt.value=="0.00")
			{
				ShowAlert('121',"Loan amount covered under the scheme");
				document.forms[0].txt_premium_loan_amt.focus();
				return false;
			}
		}
		if(document.forms[0].sel_Processed_Type.value=="SF")
		{
			if(document.forms[0].txt_premium_Account_no.value=="")
			{
				ShowAlert('121',"Operative account number from which premium account will be debited ");
				document.forms[0].txt_premium_Account_no.focus();
				return false;
			}
			if(document.forms[0].sel_Funded_Comp_Name.value=="")
			{
				ShowAlert('111',"Insurance Funded Company Name");
				document.forms[0].sel_Funded_Comp_Name.focus();
				return false;
			}
		}
		
		if(document.forms[0].selectgovt.value=="")
		{
			ShowAlert(111,'Govt Sponsor scheme');
			document.forms[0].selectgovt.focus();
			return;
		}
	 
		if(document.forms[0].selectgovt.value=="1")
		{
			if(document.forms[0].schemetype.value=="0")
			{
				ShowAlert(111,'Scheme Type');
				document.forms[0].schemetype.focus();
				return;
			}
			if(document.forms[0].sel_sponser_agency.value=="0")
			{
				ShowAlert(111,'Sponsor agency');
				document.forms[0].sel_sponser_agency.focus();
				return;
			}
			if(document.forms[0].sel_subsidytype.value=="0")
			{
				ShowAlert(111,'Subsidy Type');
				document.forms[0].sel_subsidytype.focus();
				return;
			}
			document.forms[0].sub.disabled=false;
			document.forms[0].txt_agency.readOnly=false;
		}
		else
		{
			document.forms[0].schemetype.value="0";
			document.forms[0].sel_sponser_agency.value="0";
			document.forms[0].sel_subsidytype.value="0";
			document.forms[0].sub.value="";
			document.forms[0].txt_agency.value="";
		}
	 }
	
	if(varRepayType=="1" &&(document.forms[0].txtmonPay.value =="0.00" || document.forms[0].txtmonPay.value ==""))
	{
		alert("Please Fill EMI");
		return;
	}
	
	
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	if(varcostofloan=="" || varcostofloan=="0.00")
	{
		ShowAlert('121'," Cost of the project");
	 	document.forms[0].txtloan_costloanprd.focus();
	 	return;
	}
	
	document.forms[0].hidtxtduedate.value = document.forms[0].txt_duedate.value;
	if( renewflag=="R" && document.forms[0].hidtxtduedate.value == "")
	{
		ShowAlert('111',"Due date");
	 	document.forms[0].txt_duedate.focus();
	 	return;
	}
	
	if(confirm("Appraisal -> Loan details will be delete, Do you want to Continue?"))
	{
		document.forms[0].txtmonPay.disabled=false;
		document.forms[0].txtloan_reqterms.disabled = false;
		
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanMethod.value="updateDigiLoanProducts";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].hidSourceUrl.value="/action/perDigiLoandetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();	
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
	if(varProductType.charAt(0) == "P" && document.forms[0].hidStaffProduct.value == "Y" && 
		NanNumber(parseFloat(document.forms[0].hidPrincipalRepay.value))>0 && 
		NanNumber(parseFloat(document.forms[0].hidInterestRepay.value))>0)
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
		var  var_terms=trim(document.forms[0].txtloan_reqterms.value);
		var_terms=parseFloat(var_terms)-parseFloat(document.forms[0].txt_installments.value);
		varrate=parseFloat(document.forms[0].txtloan_modintrate.value)/(12*100);
		var denominator=Math.pow(varrate+1,var_terms)-1;
		var varnumerator=varrate*Math.pow(varrate+1,var_terms);
		if(servised == "y" && moritorium > 0 && interestcharged=="2")
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
		else if(servised == "n" && moritorium > 0 && interestcharged=="2")
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
		var vartotal=varemi*var_terms;
	 	varemi=Math.ceil(varemi)
	 	
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
			if(document.forms[0].prd_type.value!="pG" && document.forms[0].prd_type.value!="pR")
			{
				sancAmt  = 	roundVal(varamtreqst/var_terms);
				document.forms[0].txtmonPay.value=sancAmt;
			}
			//else
			//{
				//document.forms[0].txtmonPay.value="0.00";
			//}
		}	
		if(document.forms[0].hidStaffProduct.value == "Y")
		{
			if(document.forms[0].prd_type.value == "pH")
			{
				if(document.forms[0].hidstaff_under.value =="1")
				{
					var_terms="270";
				}else{
					var_terms="180";
				}
			var_terms=parseFloat(var_terms)-parseFloat(moritorium);
			}
			varemi=Math.ceil(varamtreqst/var_terms);
			document.forms[0].txtmonPay.value=roundVal(NanNumber(varemi));
		}
	}
}

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
	var calmonth=document.forms[0].hidprocessnote.value;
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
					var varQryString = appURL+"action/amortization.jsp?modIntRate="+intrate+"&terms="+terms+"&terms2="+0+"&terms3="+terms2+"&txtmonPay="+txtmonPayamor+"&recmdAmt="+sancAmt+"&hidBeanGetMethod=calculateAmortization&hidBeanId=perapplicant&hidrepaymenttype=amort&varappname="+varappname+"&inttype="+inttype+"&calmonth="+calmonth;
				}
				else if(servised == "n" && moritorium > 0)
				{
					var varQryString = appURL+"action/amortization.jsp?modIntRate="+intrate+"&terms="+terms1+"&terms2="+terms2+"&terms3=0&txtmonPay="+txtmonPayamor+"&recmdAmt="+sancAmt+"&hidBeanGetMethod=calculateAmortization&hidBeanId=perapplicant&hidrepaymenttype=amort&varappname="+varappname+"&inttype="+inttype+"&calmonth="+calmonth;
				}
				else
				{
					var varQryString = appURL+"action/amortization.jsp?modIntRate="+intrate+"&terms="+terms+"&terms2="+terms2+"&txtmonPay="+txtmonPayamor+"&recmdAmt="+recamt+"&hidBeanGetMethod=calculateAmortization&hidBeanId=perapplicant&hidrepaymenttype=amort&varappname="+varappname+"&inttype="+inttype+"&calmonth="+calmonth;
				}
				varQryString = varQryString + "&StaffFlag="+document.forms[0].hidStaffFlag.value;
				varQryString = varQryString + "&PrincipalRatio="+document.forms[0].hidPrincipalRatio.value;
				varQryString = varQryString + "&InterestRatio="+document.forms[0].hidInterestRatio.value;
				varQryString = varQryString + "&sel_interestcharge="+document.forms[0].sel_interestcharge.value;
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

function callIncomeExpenses()
{
	var page=document.forms[0].page1.value;
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpensesdisp.jsp?applnt=P";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callEmployer()
{
	var page=document.forms[0].page1.value;
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployerdisp.jsp?applnt=P";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callDemographics()
{
	var page=document.forms[0].page1.value;
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action=appURL+"action/perapplicantdisp.jsp?applnt=P";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callProposedAsset()
{
	var page=document.forms[0].page1.value;
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/perpropertydetails.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
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

function callCoAppGuarantor()
{

	var page=document.forms[0].page1.value;
	if(document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getCoAppGuarantor";
		document.forms[0].action=appURL+"action/percoappguarantor.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callEducationLoan()
{
	
	var page=document.forms[0].page1.value;
	if(page.toUpperCase()!="NR")
	{
		if(document.forms[0].hideditflag.value=="N")
		{
		document.forms[0].hidBeanId.value="edustudent";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/edustudent.jsp";
		document.forms[0].submit();
		}
		else
		{
			ShowAlert('103');
		}
	}
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
	var varSanctionAmount = NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value));
	var varEligibleAmount = varMarginEligibility;
	if(varRequestedAmount < varEligibleAmount)
	{
		varEligibleAmount = varRequestedAmount;
	}
	if(varSanctionAmount!="" && varSanctionAmount!="0" && varSanctionAmount!="0.00")
	{
		if(varSanctionAmount < varEligibleAmount)
		{
			varEligibleAmount = varSanctionAmount;
		}
	}
	document.forms[0].txtloan_sancamt.value = roundVal(varEligibleAmount);	
	document.forms[0].txtmarginoffered.value=roundVal(varProjectCost-varRequestedAmount);
	callSanc();
	
	if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
	{
	  document.forms[0].txtloan_costloanprd.readOnly=true;
	}
}

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
	var costPrd = document.forms[0].txtloan_costloanprd.value;
	var margin = document.forms[0].txtMarginpercent.value;
	if(isNaN(costPrd))
	{
		costPrd="0.00";
	}
	if(margin=="")
	{
		margin=0.0;
	}
	document.forms[0].txtloan_recmdamt.value=roundVal(parseFloat(costPrd)-(parseFloat(costPrd)*(parseFloat(margin)/100)));
	if(document.forms[0].txtloan_recmdamt.value=="N.aN")
	{
		document.forms[0].txtloan_recmdamt.value="0.00";
	}
	//This function calculates the Eligible loan amount based on Req amount, project cost, 
	// Eligiblity based on margin and eligibility based on salary.
	// This is called by the Iframe when changing the Cost of loan product or interest rate.
	var varLoanAmount = NanNumber(parseFloat(document.forms[0].txtloan_sancamt.value));
	var varInterest = NanNumber(parseFloat(document.forms[0].txtloan_modintrate.value));
	var varTerms = NanNumber(parseFloat(document.forms[0].txtloan_reqterms.value));
	var varPrinRatio = NanNumber(parseFloat(document.forms[0].hidPrincipalRepay.value));
	var varIntRatio = NanNumber(parseFloat(document.forms[0].hidInterestRepay.value));
	var varHoliday = NanNumber(parseFloat(document.forms[0].txt_installments.value));
	
	var varTotal = varPrinRatio + varIntRatio;
	var varTotalInterest = 0.0;
	var varPrinTerms = 0;
	var varIntTerms = 0;
	
	
//========= Calculate Monthly installment for staff --By Shahul 

	//var repayCapacity = varTerms / varTotal;
//	var principalPeriod = repayCapacity * varPrinRatio;
	
	var varPrinEMI = varLoanAmount / (varPrinRatio - varHoliday);
//	alert(varPrinEMI+","+roundtxt(varPrinEMI)+","+roundVal(varPrinEMI)+","+Math.round(varPrinEMI));
	document.forms[0].txtmonPay.value = roundVal(Math.round(varPrinEMI)); 
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
				if(strOrgLevel == "R" || strOrgLevel == "C")
				{
					showCal(appURL,name);
				}
				else
				{
					alert("For CPC/RO/HO use Only");
				}
			}
			else if(name=='txt_receiptclpu')
			{
				if(strOrgLevel == "D")
				{
					showCal(appURL,name);
				}
				else
				{
					alert("For CLPU use Only");
				}
			}
			else if(name=='txt_receiptroho')
			{
				if((strOrgLevel == "R" || strOrgLevel == "C") && strOrgcode!="001001000000000")
				{
					showCal(appURL,name);
				}
				else
				{
					alert("For RO/HO use Only");
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
	if(document.forms[0].selectinttype.value=="2")
	{
		document.all.idmclr1.style.visibility="visible";
		document.all.idmclr1.style.position="relative";
		document.all.idmclr2.style.visibility="visible";
		document.all.idmclr2.style.position="relative";
	}
	else
	{
		document.all.idmclr1.style.visibility="hidden";
		document.all.idmclr1.style.position="absolute";
		document.all.idmclr2.style.visibility="hidden";
		document.all.idmclr2.style.position="absolute";
	}
	
	if(varOtherDepFlag=="Y" && document.forms[0].sel_mclrtype.value!="")
	{
		var varMCLR=(document.forms[0].sel_mclrtype.value).split("@");
		if(varMCLR[0]!="Y")
		{
			alert("Third Party Deposits involved in this proposal, so Reference Type should be yearly");
			document.forms[0].sel_mclrtype.value="";
			return;
		}
	}
}
	
	
function callGoldLoan()
{
	var comappid = document.forms[0].checkappno.value; 
	var vartitle='Gold_Ornaments_Details';
	var purl = appURL+"action/agr_goldloan.jsp?hidBeanGetMethod=getgolddetails&hidBeanId=agrotherassets&appno="+str_appno1;
	var prop = 'scrollbars=no,width=850,height=500';	
	var xpos = (screen.width - 800) / 2;
	var ypos = (screen.height - 800) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,vartitle,prop);
}

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
function callIntcalcmode()
{
	/*if(document.forms[0].sel_interestcharge.value=="2" && document.forms[0].interestservised.value == "n" &&
			document.forms[0].txt_installments.value>0)
	{
		document.forms[0].sel_intcalcmode.value="C";
	}
	else
	{
		document.forms[0].sel_intcalcmode.value="S";
	}
	if(document.forms[0].prd_type.value=="pH" && document.forms[0].hidpurpose.value=="F")
	{
		document.forms[0].sel_intcalcmode.value="C";
	}
	if((document.forms[0].prd_type.value=="pI" || document.forms[0].prd_type.value=="pM") && document.forms[0].hidODFlag.value=="OD")
	{
		document.forms[0].sel_intcalcmode.value="C";
	}*/
	
	if(document.forms[0].hidStaffProduct.value == "Y" && document.forms[0].prd_type.value!="pC")
	{
		document.forms[0].sel_intcalcmode.value="S";
	}
	else
	{
		document.forms[0].sel_intcalcmode.value="C";
	}
	if(document.forms[0].hidCategoryType.value!="LAD")
	{
		document.all.idintcalcmode1.style.visibility="visible";
		document.all.idintcalcmode2.style.visibility="visible";
	}
	document.forms[0].sel_intcalcmode.disabled=true;
}
function disableDynamicFields()
{
	if(!(varPrepaymentCharge=="0.00"||varPrepaymentCharge=="0"))
	{
		document.forms[0].txtloan_prepaycharge.readOnly=true;
	}
	if(!(varUpfrontFee=="0.00"||varUpfrontFee=="0"))
	{
		document.forms[0].txtloan_upfrontfee.readOnly=true;
	}
	if(!(varLoanPurpose.toUpperCase()=="H"&&varProjectFinance.toUpperCase()=="Y"))
	{
		document.forms[0].txtloan_procfee.readOnly=true;
	}
}
function doCustomerBackground()
{
	
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo = document.forms[0].checkappno.value;
	var hidCommentPage = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage="+hidCommentPage+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
function checkHoliday()
{
	var varMaxHoliday=document.forms[0].hidHoliday.value;
	var varHoliday=document.forms[0].txt_installments.value;
	if(eval(varHoliday)>eval(varMaxHoliday))
	{
		alert("The Maximum Holiday Period is "+varMaxHoliday);
		document.forms[0].txt_installments.value=varMaxHoliday;
		document.forms[0].txt_installments.focus();
		return;
	}
}
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

function getMargincalc()
{
	var varProductType=document.forms[0].prd_type.value;
	var purposeid = document.forms[0].hidpurpose.value;
	var varage = document.forms[0].txt_vehage.value;
	var prdid   = document.forms[0].hidProductID.value;
	var varcostofloan=parseFloat(document.forms[0].txtloan_costloanprd.value);
	var terms =trim(document.forms[0].txtloan_reqterms.value);
	var inttype = document.forms[0].selectinttype.options[document.forms[0].selectinttype.selectedIndex].text;
	var mortperiod=document.forms[0].txt_installments.value;
	var varCategoryType=document.forms[0].hidCategoryType.value;
	
	if(document.forms[0].selectinttype.value < 3 || document.forms[0].selectinttype.value == 4)
	{
		if(prdid!="")
		{	
			document.forms[0].prdid1.value=prdid;
			document.all.ifrm1.src=appURL+"action/iframepermargincalc.jsp?hidBeanGetMethod=getInterestRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+varage+"&terms="+terms+"&costloanprd="+varcostofloan+"&morterms="+mortperiod+"&hidCategoryType="+varCategoryType+"&varProductType="+varProductType+"&hidpurpose="+purposeid;
			document.forms[0].selrepaymenttype.disabled = false;
		}
	}
	
	else if(document.forms[0].selectinttype.value == 3 )
	{
		document.all.ifrm1.src=appURL+"action/iframepermargincalc.jsp?hidBeanGetMethod=getStepupRate&hidBeanId=perapplicant&prdid1="+document.forms[0].prdid1.value+"&hidProductID="+document.forms[0].hidProductID.value+"&inttype="+inttype+"&recamt="+varage+"&terms="+terms+"&costloanprd="+varcostofloan+"hidpurpose="+purposeid;
		document.forms[0].selrepaymenttype.disabled = false;
		showRepayment();						
		document.all.amort1.style.visibility="visible";
		
		document.all.amort2.style.visibility="visible";
	}
	else
	{
	}
	
}

function checkvalue()
{
	var varProductType=document.forms[0].prd_type.value;
	if(varProductType=="pP")
	{
		document.forms[0].txtloan_costloanprd.value=document.forms[0].txtloan_amtreqd.value;
		getInterestValue();
		callOnAmtReqstd()
	}
callOnAmtReqstdDigi();
}

function chkloanleaseperiod()
{
	if(varAppType!="P")
	{
		var varloan = parseFloat(document.forms[0].txtloan_reqterms.value);
		var varlease = parseFloat(document.forms[0].txt_leaseperiod.value);
		/*
		if(parseFloat(varloan) >  parseFloat(varlease))
		{
			alert("Loan Period should not exceed Unexpired Lease Period");
			document.forms[0].txtloan_reqterms.value="";
			document.forms[0].txtloan_reqterms.focus();
			return;
		}
		*/
		if(parseFloat(varlease) <  parseFloat(varloan))
		{
			alert("Unexpired Lease Period should be greater than or equal to Loan Period");
			document.forms[0].txt_leaseperiod.value="";
			document.forms[0].txt_leaseperiod.focus();
			return;
		}
	}
}
function calcAgeofVehicle()
{
	var age = eval(document.forms[0].txt_vehage.value);
	var maxage= eval(document.forms[0].hidvehAge.value);
	if(document.forms[0].prd_type.value=="pA" || document.forms[0].prd_type.value=="pU")
	{
		if(parseInt(NanNumber(age)) > parseInt(NanNumber(maxage)))
		{
			alert("Vehicle age should not be greater than "+ maxage+" Years");
			document.forms[0].txt_vehage.value="";
			document.forms[0].txt_vehage.focus();
			return;
		}
	}
	else if(document.forms[0].prd_type.value=="pH")
	{
		if(parseInt(NanNumber(age)) > parseInt(NanNumber(maxage)))
		{
			alert("Age of House should not be greater than "+ maxage+" Years");
			document.forms[0].txt_vehage.value="";
			document.forms[0].txt_vehage.focus();
			return;
		}
	}
}
function calGrossrent()
{
	
	var varMonthgross=document.forms[0].txt_monthgrossrent.value;
	if(varMonthgross==""){
		varMonthgross="0.00";
	}
	var varleasePeriod=document.forms[0].txt_leaseperiod.value;
	if(varleasePeriod=="")
	{
		varleasePeriod="0";
	}
	var varRepayPeriod=document.forms[0].txtloan_reqterms.value;
	if(varRepayPeriod=="")
	{
		varRepayPeriod="0";
	}
	
	if(parseFloat(varRepayPeriod)<parseFloat(varleasePeriod))
	{
		varleasePeriod=varRepayPeriod;
	}
	document.forms[0].txtloan_costloanprd.value=parseFloat(varMonthgross)*parseFloat(varleasePeriod);
	roundtxt(document.forms[0].txtloan_costloanprd);	
}

function changlabelCop()
{

  if(document.forms[0].prd_type.value=="pI")
  {
	  document.all.cpl.innerText="Total Value of securities";
  }
  else if(document.forms[0].prd_type.value=="pL")
  {
	  document.all.cpl.innerText="Total Gross Rent";
  }
  else if(document.forms[0].prd_type.value=="pA")
  {
	  document.all.cpl.innerText="Cost of the Vehicle";
  }
  else if(document.forms[0].prd_type.value=="pE")
  {
	  document.all.cpl.innerText="Total Education Cost";
  }
  else if(document.forms[0].prd_type.value=="pM" || (document.forms[0].prd_type.value=="pH" && document.forms[0].hidpurpose.value=="T") || (document.forms[0].prd_type.value=="pH" && document.forms[0].hidpurpose.value=="HC"))
  {
	  document.all.cpl.innerText="Market Value of property";
  }
  else if(document.forms[0].prd_type.value=="pU" && document.forms[0].hidODFlag.value=="OD")
  {
	  document.all.cpl.innerText="Cost of machineries/equipment/ Stock/Book Debts";
  }
  else if(document.forms[0].prd_type.value=="pS")
  {
	  document.all.cpl.innerText="Total value of Shares";
  }
  else
  {
	  document.all.cpl.innerText="Cost of the Project";
  }	
}

function clpufocus()
{
	if(strOrgLevel == "D")
	{
		//Allow
	}
	else
	{
		alert("For CLPU use Only");
		document.forms[0].selmodepayment.focus();
	}
}

function rohofocus()
{
	if((strOrgLevel == "R" || strOrgLevel == "C") && strOrgcode!="001001000000000")
	{
		//Allow
	}
	else
	{
		alert("For RO/HO use Only");
		document.forms[0].selmodepayment.focus();
	}
}

function cpcfocus()
{
	if(strOrgLevel == "R" || strOrgLevel == "C")
	{
		//Allow
	}
	else
	{
		alert("For CPC/RO/HO use Only");
		document.forms[0].selmodepayment.focus();
	}
}
function ValidateOpearativeAcc()
{
	
		var varOperAcc=document.forms[0].txt_operativeaccno.value;
		if(varOperAcc.length!=16)
		{
			alert("Please Enter Valid Operative Account Number");
			return;
		}
	
}


	
function callInterestCharged()
{
	if(document.forms[0].interestservised.value=="n")
	{
		document.forms[0].sel_interestcharge.options[1].selected=true;
		callIntcalcmode();
		callCalculate();
		document.forms[0].sel_interestcharge.disabled=true;
	}
	else
	{
		document.forms[0].sel_interestcharge.options[0].selected=true;
		document.forms[0].sel_interestcharge.disabled=true;
	}
	if(document.forms[0].hidStaffProduct.value == "Y" && document.forms[0].prd_type.value!="pC")
	{
		document.forms[0].sel_interestcharge.options[2].selected=true;
		document.forms[0].sel_interestcharge.disabled=true;
	}
	else if(document.forms[0].hidStaffProduct.value == "Y" && document.forms[0].prd_type.value=="pC")
	{
		document.forms[0].sel_interestcharge.options[3].selected=true;
		document.forms[0].sel_interestcharge.disabled=true;
	}
}

function gototab(beanid,methodname,pagename)
{
	var varTakeOver =  document.forms[0].sel_take_over.value;
	var varTakeoverpageFilled =  document.forms[0].hidtakeoveravail.value;
	if(varTakeOver=="Y" && varTakeoverpageFilled=="N")
	{
		ShowAlert('192');
		return;
	}
	if((document.forms[0].schemetype.value=="079" || document.forms[0].schemetype.value=="078") && document.forms[0].hidPMAYDet.value=="N")
	{
		alert("Please Enter the PMAY Details");
		return;
	}
	if( document.forms[0].hidPrdFlag.value!="Y" && document.forms[0].hideditflag.value=="N")
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

function showAckSearch()
{	
	var varcategory="";
	
		if(document.forms[0].cmdsave.disabled==false)
		{
			if(document.forms[0].hidCategoryType.value=="RET")
			{
				varcategory="p";
			} 
			else if(document.forms[0].hidCategoryType.value=="AGR")
			{
				varcategory="a";
			}
			else if(document.forms[0].hidCategoryType.value=="LAD")
			{
				varcategory="LAD";
			}
			var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&CBSid="+varcbsid;   
			var title = "Acknowledgement";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
		
}

function callLoanDetails()
{
	if(document.forms[0].hideditflag.value.toUpperCase()=="N")
	{
		document.forms[0].hidBeanId.value="perpropertydetails";
		document.forms[0].hidBeanGetMethod.value="getLoanAgainstDep";
		document.forms[0].action=appURL+"action/loanagainstdep.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}

function callEqualInstallment(){
    
    var installments,loanamount,holiday,period;
    holiday=document.forms[0].txt_installments.value;
    installments=document.forms[0].txtloan_reqterms.value;
    loanamount=document.forms[0].txtloan_sancamt.value;
    period=document.forms[0].sel_peridicity.value;
    var varQryString = appURL+"action/equalinstallments.jsp?hidBeanGetMethod=getEqualInstallments&hidBeanId=perapplicant&installments="+installments+"&loanamount="+loanamount+"&hidAction=load&holiday="+holiday+"&period="+period;
	var title = "EqualInstallment";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 150) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);	
}
function validateAccno()
{
	if(document.forms[0].selmodepayment.value=="E" && document.forms[0].txt_operativeaccno.value=="")
	{
		alert("Enter the Operative Account Number");
		return;	
	}
}

function selOperative(obj)
{
	var val=obj.value;
	
	if(val=="E")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";
		
		document.forms[0].sel_ECSBankName.disabled=true;
		document.forms[0].sel_ECSaccnttype.disabled=true;
		document.forms[0].txt_ECSoperaccno.disabled=true;
		document.forms[0].sel_ECSauthmode.disabled=true;
		document.forms[0].txt_ECSifsccode.disabled=true;
		
		document.all.ECSopnolabel1.style.visibility="hidden";
		document.all.ECSopnolabel1.style.position="absolute";
		
		document.all.ECSopnovalue1.style.visibility="hidden";
		document.all.ECSopnovalue1.style.position="absolute";
		
		document.all.ECSopnolabel2.style.visibility="hidden";
		document.all.ECSopnolabel2.style.position="absolute";
		
		document.all.ECSopnovalue2.style.visibility="hidden";
		document.all.ECSopnovalue2.style.position="absolute";
		
		document.all.ECSopnolabel3.style.visibility="hidden";
		document.all.ECSopnolabel3.style.position="absolute";
		
		document.all.ECSopnovalue3.style.visibility="hidden";
		document.all.ECSopnovalue3.style.position="absolute";
		
		document.all.ECSopnolabel4.style.visibility="hidden";
		document.all.ECSopnolabel4.style.position="absolute";
		
		document.all.ECSopnovalue4.style.visibility="hidden";
		document.all.ECSopnovalue4.style.position="absolute";
		
		document.all.ECSopnolabel5.style.visibility="hidden";
		document.all.ECSopnolabel5.style.position="absolute";
		
		document.all.ECSopnovalue5.style.visibility="hidden";
		document.all.ECSopnovalue5.style.position="absolute";
		
	}else if(val=="C")
		{
			document.forms[0].sel_ECSBankName.disabled=false;
			document.forms[0].sel_ECSaccnttype.disabled=false;
			document.forms[0].txt_ECSoperaccno.disabled=false;
			document.forms[0].sel_ECSauthmode.disabled=false;
			document.forms[0].txt_ECSifsccode.disabled=false;
			
			document.all.ECSopnolabel1.style.visibility="visible";
			document.all.ECSopnolabel1.style.position="relative";
			
			document.all.ECSopnovalue1.style.visibility="visible";
			document.all.ECSopnovalue1.style.position="relative";
			
			document.all.ECSopnolabel2.style.visibility="visible";
			document.all.ECSopnolabel2.style.position="relative";
			
			document.all.ECSopnovalue2.style.visibility="visible";
			document.all.ECSopnovalue2.style.position="relative";
			
			document.all.ECSopnolabel3.style.visibility="visible";
			document.all.ECSopnolabel3.style.position="relative";
			
			document.all.ECSopnovalue3.style.visibility="visible";
			document.all.ECSopnovalue3.style.position="relative";
			
			document.all.ECSopnolabel4.style.visibility="visible";
			document.all.ECSopnolabel4.style.position="relative";
			
			document.all.ECSopnovalue4.style.visibility="visible";
			document.all.ECSopnovalue4.style.position="relative";
			
			document.all.ECSopnolabel5.style.visibility="visible";
			document.all.ECSopnolabel5.style.position="relative";
			
			document.all.ECSopnovalue5.style.visibility="visible";
			document.all.ECSopnovalue5.style.position="relative";
			
			document.forms[0].txt_operativeaccno.disabled=true;
			document.all.opnolabel.style.visibility="hidden";
			document.all.opnolabel.style.position="absolute";
			
			document.all.opnovalue.style.visibility="hidden";
			document.all.opnovalue.style.position="absolute";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
		//document.forms[0].txt_operativeaccno.value="";
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
		
		document.forms[0].sel_ECSBankName.disabled=true;
		document.forms[0].sel_ECSaccnttype.disabled=true;
		document.forms[0].txt_ECSoperaccno.disabled=true;
		document.forms[0].sel_ECSauthmode.disabled=true;
		document.forms[0].txt_ECSifsccode.disabled=true;
		
		document.all.ECSopnolabel1.style.visibility="hidden";
		document.all.ECSopnolabel1.style.position="absolute";
		
		document.all.ECSopnovalue1.style.visibility="hidden";
		document.all.ECSopnovalue1.style.position="absolute";
		
		document.all.ECSopnolabel2.style.visibility="hidden";
		document.all.ECSopnolabel2.style.position="absolute";
		
		document.all.ECSopnovalue2.style.visibility="hidden";
		document.all.ECSopnovalue2.style.position="absolute";
		
		document.all.ECSopnolabel3.style.visibility="hidden";
		document.all.ECSopnolabel3.style.position="absolute";
		
		document.all.ECSopnovalue3.style.visibility="hidden";
		document.all.ECSopnovalue3.style.position="absolute";
		
		document.all.ECSopnolabel4.style.visibility="hidden";
		document.all.ECSopnolabel4.style.position="absolute";
		
		document.all.ECSopnovalue4.style.visibility="hidden";
		document.all.ECSopnovalue4.style.position="absolute";
		
		document.all.ECSopnolabel5.style.visibility="hidden";
		document.all.ECSopnolabel5.style.position="absolute";
		
		document.all.ECSopnovalue5.style.visibility="hidden";
		document.all.ECSopnovalue5.style.position="absolute";
		
	}
}
function selsub(varFlag)
{
     if(document.forms[0].selectgovt.value == "1")
	 {
	    document.all.s5.style.visibility="visible";
	    document.all.s5.style.position="relative";	
	    	
	    document.all.s6.style.visibility="visible";
	    document.all.s6.style.position="relative";
	    
    	document.all.s1.style.visibility="visible";
    	document.all.s1.style.position="relative";
    		
    	document.all.s2.style.visibility="visible";
    	document.all.s2.style.position="relative";	
    	
    	document.all.s3.style.visibility="visible";
    	document.all.s3.style.position="relative";
    	
    	if(varsponseragency=="DRDA")
		{
	    	document.all.s4.style.visibility="hidden";
	    	document.all.s4.style.position="relative";	
	    	document.forms[0].txt_agency.readOnly=false;
		}
    	else
    	{
    		document.all.s4.style.visibility="visible";
        	document.all.s4.style.position="relative";
    	}
    	if(document.forms[0].sel_sponser_agency.value=="DRDA")
    	{
    		document.all.s4.style.visibility="hidden";
	    	document.all.s4.style.position="relative";
	    	document.forms[0].txt_agency.readOnly=false;
    	}
    	
    	if(varFlag=="Y")
    	{
    		document.forms[0].sub.disabled=false;
    		document.forms[0].sub.readOnly=false;
        	document.forms[0].schemetype.disabled=false;
        	document.forms[0].sel_sponser_agency.disabled=false;
        	document.forms[0].sel_subsidytype.disabled=false;
        	document.forms[0].txt_agency.readOnly=false;
    	}
    }
    else
  	{
    	document.all.s5.style.visibility="hidden";
    	document.all.s5.style.position="absolute";
    	
    	document.all.s6.style.visibility="hidden";
    	document.all.s6.style.position="absolute";
    		
    	document.all.s1.style.visibility="hidden";
    	document.all.s1.style.position="absolute";
    		
    	document.all.s2.style.visibility="hidden";
    	document.all.s2.style.position="absolute";
    		
    	document.all.s3.style.visibility="hidden";	
    	document.all.s3.style.position="absolute";
    	
    	document.all.s4.style.visibility="hidden";	
    	document.all.s4.style.position="absolute";
    	
    	document.forms[0].sub.value="";
    	document.forms[0].schemetype.value="0";
    	document.forms[0].sel_sponser_agency.value="0";
    	document.forms[0].sel_subsidytype.value="0";
    	document.forms[0].txt_agency.value="";
   	}
}


function chkRepayPeriod()
{
	if(varAppType!="P")
	{
	
		var chkrepayPerd=document.forms[0].repayperiod.value;
		maxterms1=document.forms[0].repayperiod.value;
		var chkmintenor = document.forms[0].minterm.value;
		if(eval(document.forms[0].txtloan_reqterms.value)>eval(chkrepayPerd) || eval(document.forms[0].txtloan_reqterms.value)==0)
		{ 
			alert("The Maximum Repayment Period is "+chkrepayPerd);
			document.forms[0].txtloan_reqterms.value="";
			document.forms[0].txtloan_reqterms.focus();
			return;
		}
		if(eval(document.forms[0].txtloan_reqterms.value)<eval(chkmintenor) || eval(document.forms[0].txtloan_reqterms.value)==0)
		{ 
			alert("The Minimum Repayment Period is "+chkmintenor);
			document.forms[0].txtloan_reqterms.value="";
			document.forms[0].txtloan_reqterms.focus();
			return;
		}
		if(eval(maxserviceleft)>0 && eval(maxserviceleft)>=eval(maxterms1) && eval(document.forms[0].txtloan_reqterms.value)>eval(maxterms1))
		{
			alert("The Maximum Repayment Period is "+maxterms1);
			document.forms[0].txtloan_reqterms.value="";
			document.forms[0].txtloan_reqterms.focus();
			return;
		}	
		else if(eval(maxserviceleft)>0 && eval(document.forms[0].txtloan_reqterms.value)>eval(maxserviceleft) && document.forms[0].hidStaffFlag.value == "Y")
		{
			alert("Service left for the applicant is "+maxserviceleft +" months. So the repayment period cannot exceed");
			document.forms[0].txtloan_reqterms.value="";
			document.forms[0].txtloan_reqterms.focus();
			return;
		}
		if(document.forms[0].selrepaymenttype.value=="1")
		{
		getInterestValue();
		}
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

function clearmonpay()
{
	document.forms[0].txtmonPay.value = "0.00";	
}

function enableinterestcharge()
{
	/*if(document.forms[0].hidEditMode.value=="E")
	{*/
		//if(document.forms[0].interestservised.value=="y")
		//{
			//document.forms[0].sel_interestcharge.disabled=false;
		//}
		//else
		//{
			//document.forms[0].sel_interestcharge.disabled=true;
		//}
	//}
}

function interestselect()
{
	document.forms[0].selrepaymenttype.value="0";
}

function getrepayment()
{
	if(document.forms[0].hidStaffProduct.value =="Y")
	{
		document.forms[0].selrepaymenttype.length=2;
		document.forms[0].selrepaymenttype.options[0].value="0";
		document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
		document.forms[0].selrepaymenttype.options[1].value="13";
		document.forms[0].selrepaymenttype.options[1].text="Equal Monthly Installments";
	}else{
	if(document.forms[0].sel_peridicity.value =="m")
	{	
		if(document.forms[0].selectinttype.value=="3")
		{
			document.forms[0].sel.length=2;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="11";
			document.forms[0].selrepaymenttype.options[1].text="Slab";
		}
		else
		{
			document.forms[0].selrepaymenttype.length=2;
			document.forms[0].selrepaymenttype.options[0].value="0";
			document.forms[0].selrepaymenttype.options[0].text="<-------- Select -------->";
			document.forms[0].selrepaymenttype.options[1].value="1";
			document.forms[0].selrepaymenttype.options[1].text="Equated Monthly Installment";
			/* document.forms[0].selrepaymenttype.options[2].value="2";
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
			document.forms[0].selrepaymenttype.options[9].text="Equal Installments"; */
		}
	}
	else if(document.forms[0].sel_peridicity.value =="q" || document.forms[0].sel_peridicity.value =="h" || document.forms[0].sel_peridicity.value =="y")
	{		
		document.forms[0].selrepaymenttype.length=9;
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
}

function showIntChargman()
{
	if(document.forms[0].txt_installments.value=='0')
	{
        document.all.mnt1.style.visibility="hidden";
	    document.all.mnt1.style.position="absolute";	
	}
	else
	{
		document.all.mnt1.style.visibility="visible";
		document.all.mnt1.style.position="relative";
	}	

}

function moratperiod()
{
	if(varAppType!="P")
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
				if(document.forms[0].prd_type.value=="pE")
				{
					document.forms[0].interestservised.value="n";
					document.forms[0].interestservised.disabled=true;
				}
			}
	
			
		}
		//The following function is called to recalculate the EMI
		callSanc();
	}
	
	if(varAppType=="P")
	{
		var varPSterms = document.forms[0].hidPSterms.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "DLP")
			{
				if(parseInt(document.forms[0].hidloan_reqterms.value) < parseInt(document.forms[0].txtloan_reqterms.value))
				{
					alert("Loan Period should not greater then "+document.forms[0].hidloan_reqterms.value+" months");
					document.forms[0].txtloan_reqterms.value=document.forms[0].hidloan_reqterms.value;
					return;
				}
			}
		}
	}
}

function entersecure()
{
	if (document.forms[0].sel_secured.value == "p")
	{
		document.all.secure.style.visibility="visible";
		document.all.secure.style.position="relative";
		document.all.secure2.style.visibility="visible";
		document.all.secure2.style.position="relative";
		document.all.secure1.style.visibility="visible";
		document.all.secure1.style.position="relative";
	}
	else
	{
		document.all.secure.style.visibility="hidden";
		document.all.secure.style.position="absolute";
		
		document.all.secure1.style.visibility="hidden";
		document.all.secure1.style.position="absolute";
		
		document.all.secure2.style.visibility="hidden";
		document.all.secure2.style.position="absolute";
		document.forms[0].txt_secured.value = "";
	}
}

function showRepayButton()
{
	var index = document.forms[0].selrepaymenttype.selectedIndex;
	var index1 = document.forms[0].selrepaymenttype.value;
	var varperiodicity=document.forms[0].sel_peridicity.value;

	if(index1 == "10")
	{
		document.all.amort1.style.visibility="visible";
		document.all.amort1.style.position="relative";
		
		document.all.amort2.style.visibility="visible";
		document.all.amort2.style.position="relative";
		
		document.all.amort1.innerText="Click here to view the Equal Installments Table";
		document.forms[0].amort.value = "Equal Installments";
		if(str_appno1=="" || str_appno1=="New" || str_appno1=="new")
		{
			//document.forms[0].amort.disabled=true;
		}
		else
		{
			//document.forms[0].amort.disabled=false;
		}
	}
	else if(index1 == "2"  || index1 == "3" || index1 == "4" || index1=="5" || index1=="6" || index1=="7"  || index1=="9")
	{
		if(varperiodicity=="m")
		{
			document.all.amort2.style.visibility="visible";
			document.all.amort2.style.position="relative";
			document.all.amort1.innerText="Click here to view the Restructed RePayment Schedule";
			document.forms[0].amort.value = "Repayment Schedule";
		}
		else if(varperiodicity=="h" || varperiodicity=="q" || varperiodicity=="y")
		{
			document.all.amort1.style.visibility="visible";
			document.all.amort1.style.position="relative";
			
			document.all.amort2.style.visibility="visible";
			document.all.amort2.style.position="relative";
			
			document.all.amort1.innerText="Click here to view the Equal Installments Table";
			document.forms[0].amort.value = "Equal Installments";
		}
		if(str_appno1=="" || str_appno1=="New" || str_appno1=="new"){
			//document.forms[0].amort.disabled=true;
		}else{
			//document.forms[0].amort.disabled=false;
		}
	}
	else if(index1 == "1" && index == "1")
	{
		if(varperiodicity=="m")
		{
			document.all.amort2.style.visibility="visible";
			document.all.amort2.style.position="relative";
			
			document.all.amort1.innerText="Click here to view the Restructed RePayment Schedule";
			document.forms[0].amort.value = "Repayment Schedule";
			document.all.amort1.innerText="Click here to view the Amortization Table";
			document.forms[0].amort.value = "Amortization";
			if(str_appno1=="" || str_appno1=="New" || str_appno1=="new")
			{
				//document.forms[0].amort.disabled=true;
			}
			else
			{
				//document.forms[0].amort.disabled=false;
			}
		}
	}
	else if(index1 == "11" && index == "1")
	{
		document.all.amort2.style.visibility="visible";
		document.all.amort2.style.position="relative";
		
		document.all.amort1.innerText="Click here to view the Slab Rate Schedule";
		document.forms[0].amort.value = "SlabRate";
		document.all.amort1.innerText="Click here to view the Slab Rate Table";
		document.forms[0].amort.value = "SlabRate";
		if(str_appno1=="" || str_appno1=="New" || str_appno1=="new"){
			//document.forms[0].amort.disabled=true;
		}else{
			//document.forms[0].amort.disabled=false;
		}
	}
	else
	{
		document.all.amort1.innerText="Click here to view the Amortization Table";
		document.forms[0].amort.value = "Amortization";
	}	
	if(varprdtype == "pA" && installment == "y" && varEmpStatus == "4")
	{
		document.all.amort2.style.visibility = "hidden";
		document.all.Amortlabel.style.visibility = "hidden";
		document.all.amort1.style.visibility = "hidden";
	}
	if(document.forms[0].hidStaffProduct.value =="Y")
	{
		document.all.amort2.style.visibility = "hidden";
		document.all.Amortlabel.style.visibility = "hidden";
		document.all.amort1.style.visibility = "hidden";
	}
}

function callCalculateInterest()
{
	var varIntType=document.forms[0].selectinttype.value ;	
	if(varIntType!="" && varIntType !=3 && varIntType !=0 )
	{	
		callCalculate();
	}
}
function enablefields()
{
	var producttype=document.forms[0].prd_type.value;
	var purposeid=document.forms[0].hidpurpose.value;
	var hidmortflag=document.forms[0].hidmortflag.value;
	//Added by Kishan
	if(hidmortflag=='Y') //if(producttype!="" && producttype=='pM' && prdLoanType == 'OD')
	{
		document.all.idrepay.style.visibility = "hidden";
		document.all.idrepay.style.position = "absolute";
		document.all.idrepay1.style.visibility = "hidden";
		document.all.idrepay1.style.position = "absolute";
		document.all.idrepay2.style.visibility = "hidden";
		document.all.idrepay2.style.position = "absolute";
		
		document.all.idemi1.style.visibility = "hidden";
		document.all.idemi1.style.position = "absolute";
		document.all.idemi2.style.visibility = "hidden";
		document.all.idemi2.style.position = "absolute";
	
		
		document.all.lbl_periodicity.style.visibility = "hidden";
		document.all.lbl_periodicity.style.position = "absolute";
		document.all.txt_periodicity.style.visibility = "hidden";
		document.all.txt_periodicity.style.position = "absolute";
		document.all.lbl_repaytype.style.visibility = "hidden";
		document.all.lbl_repaytype.style.position = "absolute";
		document.all.txt_repaytype.style.visibility = "hidden";
		document.all.txt_repaytype.style.position = "absolute";
	}else{
		document.all.idrepay.style.visibility = "visible";
		document.all.idrepay.style.position = "relative";
		document.all.idrepay1.style.visibility = "visible";
		document.all.idrepay1.style.position = "relative";
		document.all.idrepay2.style.visibility = "visible";
		document.all.idrepay2.style.position = "relative";
		
		/*document.all.idemi1.style.visibility = "visible";
		document.all.idemi1.style.position = "relative";
		document.all.idemi2.style.visibility = "visible";
		document.all.idemi2.style.position = "relative";
		document.all.idemi3.style.visibility = "visible";
		document.all.idemi3.style.position = "relative";*/
		checkPeriInstallments();
		
		document.all.lbl_periodicity.style.visibility = "visible";
		document.all.lbl_periodicity.style.position = "relative";
		document.all.txt_periodicity.style.visibility = "visible";
		document.all.txt_periodicity.style.position = "relative";
		document.all.lbl_repaytype.style.visibility = "visible";
		document.all.lbl_repaytype.style.position = "relative";
		document.all.txt_repaytype.style.visibility = "visible";
		document.all.txt_repaytype.style.position = "relative";
	}
	if((producttype=='pH' || producttype=='pS') && (purposeid=='H'))
	{
		document.all.idhous.style.visibility = "visible";
		document.all.idhous.style.position = "relative";
		
		document.all.idage.style.visibility = "visible";
		document.all.idage.style.position = "relative";
		
		document.all.idveh.style.visibility = "hidden";
		document.all.idveh.style.position = "absolute";
		
	}
	else if((producttype=='pA'  || producttype=='pS') && purposeid=='U')
	{
		document.all.idveh.style.visibility = "visible";
		document.all.idveh.style.position = "relative";
		
		document.all.idage.style.visibility = "visible";
		document.all.idage.style.position = "relative";
		
		document.all.idhous.style.visibility = "hidden";
		document.all.idhous.style.position = "absolute";
	}
	else if(producttype=='pU' && document.forms[0].hidvehicletype.value=='2')
	{
		document.all.idveh.style.visibility = "visible";
		document.all.idveh.style.position = "relative";
		
		document.all.idage.style.visibility = "visible";
		document.all.idage.style.position = "relative";
		
		document.all.idhous.style.visibility = "hidden";
		document.all.idhous.style.position = "absolute";
	}
	else
	{
		document.all.idhous.style.visibility = "hidden";
		document.all.idhous.style.position = "absolute";
		
		document.all.idveh.style.visibility = "hidden";
		document.all.idveh.style.position = "absolute";
		
		document.all.idage.style.visibility = "hidden";
		document.all.idage.style.position = "absolute";
	}
		
}
function callOnLoad() 
{

	
	if(vartakeover != "")
		 document.forms[0].sel_take_over.value=vartakeover;
		else
			document.forms[0].sel_take_over.value="0";
	
	if(subsidy!="")
	{
		document.forms[0].selectgovt.value=subsidy;
	}
	else
	{
		document.forms[0].selectgovt.value=2;
	}
	if (servised != "")
	{
		document.forms[0].interestservised.value = servised;
		
		if(servised=="s")
		{
			document.forms[0].sel_interestcharge.value = "1";
		}
		else if(servised=="n")
		{
			document.forms[0].sel_interestcharge.value = "2";
		}
	}
	else 
	{
		document.forms[0].interestservised.value = "s";
	}
	if(interestcharged!="")
	{
		document.forms[0].sel_interestcharge.value=interestcharged;
	}
	if(varIntCalcMode!="")
	{
		document.forms[0].sel_intcalcmode.value =varIntCalcMode;
	}
	else
	{
		document.forms[0].sel_intcalcmode.value = "C";
	}
	if(document.forms[0].btnenable.value=="Y")
	{
		callDisableControls(false,true,true,true,false);
		//document.forms[0].amort.disabled=false;		
		
		if(appholder==userid)
		{
			//document.forms[0].cmddelete.disabled=false;
		}
			
	}
	else
	{	
		callDisableControls(true,true,true,true,false);
		//document.forms[0].amort.disabled=false;
	}
	
	//document.forms[0].selectinttype.value=varIntType;
	document.forms[0].selrepaymenttype.value=varRepayType;
	document.forms[0].selmodepayment.value=val;
	document.forms[0].sel_mclrtype.value=varMCLRType;
	if(val=="E" || val=="")
	{
		document.forms[0].txt_operativeaccno.disabled=false;
		document.all.opnolabel.style.visibility="visible";
		document.all.opnolabel.style.position="relative";
		document.all.opnovalue.style.visibility="visible";
		document.all.opnovalue.style.position="relative";
		
		document.forms[0].sel_ECSBankName.disabled=true;
		document.forms[0].sel_ECSaccnttype.disabled=true;
		document.forms[0].txt_ECSoperaccno.disabled=true;
		document.forms[0].sel_ECSauthmode.disabled=true;
		document.forms[0].txt_ECSifsccode.disabled=true;
		
		document.all.ECSopnolabel1.style.visibility="hidden";
		document.all.ECSopnolabel1.style.position="absolute";
		
		document.all.ECSopnovalue1.style.visibility="hidden";
		document.all.ECSopnovalue1.style.position="absolute";
		
		document.all.ECSopnolabel2.style.visibility="hidden";
		document.all.ECSopnolabel2.style.position="absolute";
		
		document.all.ECSopnovalue2.style.visibility="hidden";
		document.all.ECSopnovalue2.style.position="absolute";
		
		document.all.ECSopnolabel3.style.visibility="hidden";
		document.all.ECSopnolabel3.style.position="absolute";
		
		document.all.ECSopnovalue3.style.visibility="hidden";
		document.all.ECSopnovalue3.style.position="absolute";
		
		document.all.ECSopnolabel4.style.visibility="hidden";
		document.all.ECSopnolabel4.style.position="absolute";
		
		document.all.ECSopnovalue4.style.visibility="hidden";
		document.all.ECSopnovalue4.style.position="absolute";
		
		document.all.ECSopnolabel5.style.visibility="hidden";
		document.all.ECSopnolabel5.style.position="absolute";
		
		document.all.ECSopnovalue5.style.visibility="hidden";
		document.all.ECSopnovalue5.style.position="absolute";
	}else if(val=="C")
	{
		document.forms[0].sel_ECSBankName.disabled=false;
		document.forms[0].sel_ECSaccnttype.disabled=false;
		document.forms[0].txt_ECSoperaccno.disabled=false;
		document.forms[0].sel_ECSauthmode.disabled=false;
		document.forms[0].txt_ECSifsccode.disabled=false;
		
		document.all.ECSopnolabel1.style.visibility="visible";
		document.all.ECSopnolabel1.style.position="relative";
		
		document.all.ECSopnovalue1.style.visibility="visible";
		document.all.ECSopnovalue1.style.position="relative";
		
		document.all.ECSopnolabel2.style.visibility="visible";
		document.all.ECSopnolabel2.style.position="relative";
		
		document.all.ECSopnovalue2.style.visibility="visible";
		document.all.ECSopnovalue2.style.position="relative";
		
		document.all.ECSopnolabel3.style.visibility="visible";
		document.all.ECSopnolabel3.style.position="relative";
		
		document.all.ECSopnovalue3.style.visibility="visible";
		document.all.ECSopnovalue3.style.position="relative";
		
		document.all.ECSopnolabel4.style.visibility="visible";
		document.all.ECSopnolabel4.style.position="relative";
		
		document.all.ECSopnovalue4.style.visibility="visible";
		document.all.ECSopnovalue4.style.position="relative";
		
		document.all.ECSopnolabel5.style.visibility="visible";
		document.all.ECSopnolabel5.style.position="relative";
		
		document.all.ECSopnovalue5.style.visibility="visible";
		document.all.ECSopnovalue5.style.position="relative";
		
		document.forms[0].txt_operativeaccno.disabled=true;
		document.all.opnolabel.style.visibility="hidden";
		document.all.opnolabel.style.position="absolute";
		
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
	}
	else
	{
		document.forms[0].txt_operativeaccno.disabled=true;
    	document.all.opnolabel.style.visibility="hidden";
    	document.all.opnolabel.style.position="absolute";
		document.all.opnovalue.style.visibility="hidden";
		document.all.opnovalue.style.position="absolute";
		
		document.forms[0].sel_ECSBankName.disabled=true;
		document.forms[0].sel_ECSaccnttype.disabled=true;
		document.forms[0].txt_ECSoperaccno.disabled=true;
		document.forms[0].sel_ECSauthmode.disabled=true;
		document.forms[0].txt_ECSifsccode.disabled=true;
		
		document.all.ECSopnolabel1.style.visibility="hidden";
		document.all.ECSopnolabel1.style.position="absolute";
		
		document.all.ECSopnovalue1.style.visibility="hidden";
		document.all.ECSopnovalue1.style.position="absolute";
		
		document.all.ECSopnolabel2.style.visibility="hidden";
		document.all.ECSopnolabel2.style.position="absolute";
		
		document.all.ECSopnovalue2.style.visibility="hidden";
		document.all.ECSopnovalue2.style.position="absolute";
		
		document.all.ECSopnolabel3.style.visibility="hidden";
		document.all.ECSopnolabel3.style.position="absolute";
		
		document.all.ECSopnovalue3.style.visibility="hidden";
		document.all.ECSopnovalue3.style.position="absolute";
		
		document.all.ECSopnolabel4.style.visibility="hidden";
		document.all.ECSopnolabel4.style.position="absolute";
		
		document.all.ECSopnovalue4.style.visibility="hidden";
		document.all.ECSopnovalue4.style.position="absolute";
		
		document.all.ECSopnolabel5.style.visibility="hidden";
		document.all.ECSopnolabel5.style.position="absolute";
		
		document.all.ECSopnovalue5.style.visibility="hidden";
		document.all.ECSopnovalue5.style.position="absolute";
	}
	disablefields(true);
	//document.forms[0].cmdedit.disabled=true;

	if (secured != "")
	{
		
		document.forms[0].sel_secured.value = secured;
	}
	else 
	{
		document.forms[0].sel_secured.value = "s";
	}
	/*
	* For hiding the amount secured based on whether secured
	*/
	 
	document.all.idhous.style.visibility = "hidden";
	document.all.idhous.style.position = "absolute";
	
	document.all.idage.style.visibility = "hidden";
	document.all.idage.style.position = "absolute";
	
	if((varPrdType=='pH'  || varPrdType=='pS') && (varPurposeID=='H'))
	{
		document.all.idhous.style.visibility = "visible";
		document.all.idhous.style.position = "relative";
		
		document.all.idage.style.visibility = "visible";
		document.all.idage.style.position = "relative";
		
	}
	document.forms[0].sel_Processed_Type.value=selProc_Type;
	document.forms[0].sel_Funded_Comp_Name.value=selFunded_Cmp_name;
	
	
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
			if(varsponseragency=="DRDA")
			{
				document.all.s4.style.visibility="hidden";	
		    	document.all.s4.style.position="relative";
			}
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
	
	processedType('N');
	
	if(varPrdType=="pC")
	{
		document.forms[0].cmdedit.disabled=true;
	}

	
	if(installment != ""){
		 document.forms[0].sel_peridicity.value=installment;
	}
	else{
	document.forms[0].sel_peridicity.value="s";
	}
	
	if(document.forms[0].selectinttype.value=="2")
	 {
		 if (varInterestType != "")
		 {
			document.forms[0].sel_interesttype.value = varInterestType;
		 }
		 else 
		 {
		 	document.forms[0].sel_interesttype.value = "";
		 }
	 }
	if(varPrdType=='pH' || varPrdType=='pA' || varPrdType=='pB' || varPrdType=='pM' )
	{
	document.forms[0].cmdroiupdate.disabled=true;
	}
	if(VARLOANUPDROIFLAG == "Y" && VARROIDATECHECK == "Y")
	{
		alert("ROI Updated !. Please Check. ");
	}
	if(varPrdType=='pB'){
	document.forms[0].txtloan_SecValue.readOnly=false;
	}
	
	if(ecsathunum!="")
	{
		document.forms[0].sel_ECSauthmode.value=ecsathunum;
	}
	else
	{
		document.forms[0].sel_ECSauthmode.value=0;
	}
	
	if(ecsaccntnum!="")
	{
		document.forms[0].sel_ECSaccnttype.value=ecsaccntnum;
	}
	else
	{
		document.forms[0].sel_ECSaccnttype.value=0;
	}
	if(ecsbankname!="")
	{
		document.forms[0].sel_ECSBankName.value=ecsbankname;
	}
	else
	{
		document.forms[0].sel_ECSBankName.value=0;
	}
	
	
	if(installment=="y" && varRepayType=="2")
	{
		document.all.idemi1.style.visibility = "hidden";
		document.all.idemi1.style.position = "absolute";
		document.all.idemi2.style.visibility = "hidden";
		document.all.idemi2.style.position = "absolute";
		
	}else{
		document.all.idemi1.style.visibility = "visible";
		document.all.idemi1.style.position = "relative";
		document.all.idemi2.style.visibility = "visible";
		document.all.idemi2.style.position = "relative";
		
	}
	
	if(renewflag=="R")
	{
		document.all.id_renewal_duedate1.style.visibility = "visible";
		document.all.id_renewal_duedate1.style.position = "relative";
		document.all.id_renewal_duedate2.style.visibility = "visible";
		document.all.id_renewal_duedate2.style.position = "relative";
	}
}
function processedType(flag){
	
	if(document.forms[0].sel_Processed_Type.value=="NC"||document.forms[0].sel_Processed_Type.value=="")
	{
		document.all.id_premium_tenor.style.display="none";
		document.all.id_premium_Account_no1.style.display="none";
		document.forms[0].txt_premium_tenor.value="";
		document.forms[0].txt_premium_loan_amt.value="";
		//document.forms[0].txt_premium_amt.value="";
		document.forms[0].txt_premium_Account_no.value="";
		document.forms[0].sel_Funded_Comp_Name.value="";
		document.forms[0].txt_metloanpremium.value="0";
		document.forms[0].txt_metloanpremium.readOnly=true;
	}
	else if(document.forms[0].sel_Processed_Type.value=="SF")
	{
		document.all.id_premium_Account_no1.style.display="table-row";
		document.all.id_premium_tenor.style.display="table-row";
		if(flag=="Y")
		{
			document.forms[0].txt_metloanpremium.readOnly=false;
		}
	}
	else
	{
		document.all.id_premium_tenor.style.display="table-row";
		document.all.id_premium_Account_no1.style.display="none";
		if(flag=="Y")
		{
			document.forms[0].txt_metloanpremium.readOnly=false;
			//document.forms[0].txt_premium_amt.value="";
			document.forms[0].txt_premium_Account_no.value="";
			document.forms[0].sel_Funded_Comp_Name.value="";
		}
	}
	
}

function interestselect()
{
	document.forms[0].selrepaymenttype.value="0";
}
function displaySpecify()
{
	if(document.forms[0].hidEmployment.value!="4")
	{
		if(document.forms[0].strappstatus.value=="" || document.forms[0].strappstatus.value=="Open/Pending")
		{
			if(document.forms[0].sel_docreceived.value=="1" ||document.forms[0].sel_docreceived.value=="2"||
					document.forms[0].sel_docreceived.value=="3")
			{
				alert("Agriculture Gold /Deposit Loans will be allowed only to the borrowers with employment status  as Agriculture and allied activities");
				if(document.forms[0].cmdsave.disabled==false)
				{
					document.forms[0].sel_docreceived.value="0";
					document.forms[0].sel_docreceived.focus();
				}
				return;
			}
		}
	}
	
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
function clearPrdDesc()
{
	document.forms[0].txtprd_desc.value="";
}
function checkLeaseRepay()
{
var chkrepayPerd=document.forms[0].repayperiod.value;
if(eval(document.forms[0].txt_leaseperiod.value)>eval(chkrepayPerd) || eval(document.forms[0].txt_leaseperiod.value)==0)
{ 
	alert("The Maximum Repayment Period is "+chkrepayPerd);
	document.forms[0].txt_leaseperiod.value="";
	document.forms[0].txt_leaseperiod.focus();
	return;
}
}
function checkPeriInstallments()
{
var varVisibility;
	if(document.forms[0].sel_peridicity.value=="m" && document.all.lbl_periodicity.style.visibility=="visible")
	{	
	 varVisibility="visible";
	 //calculateLoanAmount();
	}else
	{
	 varVisibility="hidden";
	}
	document.all.idemi1.style.visibility=varVisibility;
	document.all.idemi1.style.position="relative";
	
	document.all.idemi2.style.visibility=varVisibility;
	document.all.idemi2.style.position="relative";
	
	
}
function funrestrictzero()
{
	var varageofpremises=document.forms[0].txt_vehage.value;
	if(varageofpremises=="0" || varageofpremises=="00" || varageofpremises=="" )
	{
		if(document.forms[0].prd_type.value == "pH")
		{
			alert("Age of the Premises value should be greater than zero");
			document.forms[0].txt_vehage.value="";
			document.forms[0].txt_vehage.focus();
		}
		else
		{
			alert("Age of the Vehicle value should be greater than zero");
			document.forms[0].txt_vehage.value="";
			document.forms[0].txt_vehage.focus();
		}
	}
}
function loadRepaymentType()
{
	var varprdcode=document.forms[0].hidProductID.value;
	document.all.ifrmrepayment.src=appURL+"action/iframerepaymenttype.jsp?hidBeanGetMethod=getRepaymentTypeData&hidBeanId=setproducts&strPrdcode="+varprdcode+"&strRepayType="+varRepayType;
}
function selperiodicty()
{
	if((document.forms[0].hidODFlag.value=="TL")||(document.forms[0].hidODFlag.value=="DL"))
	{
		if(document.forms[0].sel_peridicity.value=="n")
		{
			alert("Periodicity of installment value should not be Not Applicable");
			document.forms[0].sel_peridicity.value="s";
			return;
		}
	}
}
function callAppStatusPopUp()
{
		var	varQryString = appURL+"action/nsdlShowAppDetails.jsp?hidBeanId=nsdl&hidBeanGetMethod=getNsdlShowApplicationDetails&strPageFrom=Loan&strRefId="+document.forms[0].hidNSDLRefNo.value;	
		var title = "ApplicantionStatus";
		var prop = "scrollbars=yes,width=850,height=550";	
		var xpos = (screen.width - 500) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
}
function callDocument()
{
	var	varQryString = appURL+"action/nsdlViewDocument.jsp?hidBeanId=nsdl&hidBeanGetMethod=getDocumentList&strRefId="+document.forms[0].hidNSDLRefNo.value;	
	var title = "ApplicantionStatus";
	var prop = "scrollbars=yes,width=850,height=550";	
	var xpos = (screen.width - 500) / 2;
	var ypos = (screen.height - 400) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
}
function LoadSharePage()
{
	var appno=document.forms[0].appno.value;
	if(document.forms[0].cmdsave.disabled == true)
	{
		var varQryString = appURL+"action/fac_shg_membershare.jsp?hidBeanId=facilities&hidBeanGetMethod=getSHGmembershare&sel_facilitysno=1&appno="+appno+"&btnenable="+document.forms[0].btnenable.value;
		var title = "SHG_Member_wise_Share";
		var prop = "scrollbars=yes,menubar=yes,status=yes,width=1200,height=500";
		prop = prop + ",left=50,top=150";
	    window.open(varQryString,title,prop);
	}
}

/*function CheckCFR_verified()
{
	if(document.forms[0].CFR_verified.value=="Y")
	{
		document.all.id_CFR1.style.display = "table-cell";
		document.all.id_CFR2.style.display = "table-cell";
	}
	else
	{
		document.forms[0].Namein_CFR.value="";
		document.forms[0].txt_CFRdev_refno.value="";
		document.all.id_CFR1.style.display = "none";
		document.all.id_CFR2.style.display = "none";
		document.all.id_CFR3.style.display = "none";
	}
}*/

/*function CheckCFR_name()
{
	if(document.forms[0].Namein_CFR.value=="Y")
	{
		document.all.id_CFR3.style.display = "table-row";
	}
	else
	{
		document.forms[0].txt_CFRdev_refno.value="";
		document.all.id_CFR3.style.display = "none";
	}
}*/
function showAgency()
{
	if(trim(document.forms[0].sel_sponser_agency.value)=="OTHERS")
	{
	document.all.s4.style.visibility="visible";
	document.all.s4.style.position="relative";
	}
	else
	{
		document.all.s4.style.visibility="hidden";
		document.all.s4.style.position="absolute";
	}
}

function openPMAY()
{	
	{
		var varQryString = appURL+"action/pmay_houseloan.jsp?hidBeanId=perpropertydetails&hidBeanGetMethod=getPMAYdata&hidBeanMethod=updatePMAYdata&appno="+ str_appno1+"&classificationtype="+ scheme;
		var title = "PMAY House Loan Details";
		var prop = "scrollbars=yes,width=1000,height=400, menubar=yes";	
		prop = prop + ",left=100,top=50";
		window.open(varQryString,"",prop);
	}
} 

function sel_whtCGTMSE()
{
	if(document.forms[0].sel_wht_cgtmse.value=="Y")
	{
		if(document.forms[0].hidAppCGStatus.value!="Y")
		{
			alert("Customer Constitution is not eligible to be covered under CGTMSE");
			document.forms[0].sel_wht_cgtmse.value="";
			return false;
		}
		document.all.cg1.style.visibility = "visible";
		document.all.cg1.style.position = "relative";
		document.all.cg2.style.visibility = "visible";
		document.all.cg2.style.position = "relative";
	}
	else
	{
		document.all.cg1.style.visibility = "hidden";
		document.all.cg1.style.position = "absolute";
		document.all.cg2.style.visibility = "hidden";
		document.all.cg2.style.position = "absolute";
		
		document.forms[0].txt_cg_gua_fee.value="";
		document.forms[0].txt_cg_gst.value="";
		document.forms[0].txt_cg_int_rate.value="";
		document.forms[0].sel_cg_fee.value="0";
	}
}

function callOnAmtReqstdDigi()
{
	var amtvalue=document.forms[0].txtloan_amtreqd.value;
	var costofproject=document.forms[0].txtloan_costloanprd.value;
	
	if(NanNumber(parseFloat(costofproject)) < NanNumber(parseFloat(amtvalue)))
	{
		if(document.forms[0].prd_type.value=="pM"  || (document.forms[0].prd_type.value=="pH" && (document.forms[0].hidpurpose.value=="T" || document.forms[0].hidpurpose.value=="HC")))
		{
			ShowAlert(186);
			document.forms[0].txtloan_costloanprd.value="";
			document.forms[0].txtloan_costloanprd.focus();
			return;
		}else{
		ShowAlert(133);
		document.forms[0].txtloan_costloanprd.value="";
		document.forms[0].txtloan_costloanprd.focus();
		return;
		}
	}
	
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
						  if(document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value!="OD")
							{
							alert("Amount requested cannot be greater than Total Value of securities");
							document.forms[0].txtloan_amtreqd.value="";
							document.forms[0].txtloan_amtreqd.focus();
							return;								
					
							}
						  else if((document.forms[0].prd_type.value=="pI" && document.forms[0].hidODFlag.value=="OD") || (document.forms[0].prd_type.value=="pN" || document.forms[0].prd_type.value=="pC" || document.forms[0].prd_type.value=="pV"|| document.forms[0].prd_type.value=="pJ"))
							{
							  document.forms[0].txtloan_costloanprd.readOnly=true;
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
						else if(document.forms[0].prd_type.value=="pM")
						{
						alert("Amount requested cannot be greater than Market Value of property");
						document.forms[0].txtloan_amtreqd.value="";
						document.forms[0].txtloan_amtreqd.focus();
						return;
						}
						else if(document.forms[0].prd_type.value=="pS")
						{
							alert("Amount requested cannot be greater than Total value of shares");
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

}

function calroitype()
{
	if(document.forms[0].selectinttype.value=="2")
	{
		if(parseInt(document.forms[0].sel_interesttype.length)>2)
		document.forms[0].sel_interesttype.value="";
	}
}
function loadInterestType()
{
	if(document.forms[0].selectinttype.value=="2")
	{
		var varprdcode=document.forms[0].hidProductID.value;
		document.all.ifrminterest.src=appURL+"action/iframeinteresttype.jsp?hidBeanGetMethod=getInterestType&hidBeanId=facilities&strPrdcode="+varprdcode+"&strIntType="+varInterestType;
	}
	else
	{
		document.all.idint3.style.visibility="hidden";
		document.all.idint3.style.position="absolute";
		document.all.idint4.style.visibility="hidden";
		document.all.idint4.style.position="absolute";
		
		/*document.forms[0].sel_interesttype.length =1;
		document.forms[0].sel_interesttype.options[0].text="<----select---->";
		document.forms[0].sel_interesttype.options[0].value="";*/
	}
}