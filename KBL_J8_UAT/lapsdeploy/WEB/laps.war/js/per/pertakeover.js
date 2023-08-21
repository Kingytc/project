function doEdit()
{
	document.forms[0].hideditflag.value = "Y";
	//document.forms[0].hidAction.value="insert";
	//document.forms[0].hidBeanId.value="pertakeover";
	//document.forms[0].hidBeanMethod.value = "getData";
	//document.forms[0].action = appURL+"action/per_takeover.jsp";
	//document.forms[0].method="post";
	//document.forms[0].cmddel.disabled=false;
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	disableCommandButtons("edit");
	//document.forms[0].submit();
	document.forms[0].loan_fininst.readOnly=true;
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			window.opener.document.forms[0].hidtakeoveravail.value="N";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="pertakeover";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanMethod.value="updateData";
		    document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/per_takeover.jsp";
			document.forms[0].submit();
	    }	
	}
	else
	{
		ShowAlert(158);
	}
}
function disableFields(flag)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text" )
		{
			document.forms[0].elements[i].readOnly=flag;
		}
		if(document.forms[0].elements[i].type=="select-one" )
		{
			document.forms[0].elements[i].disabled=flag;
		}
		if(document.forms[0].elements[i].type=="textarea" )
		{
			 document.forms[0].elements[i].readOnly=flag;
		}
		if(document.forms[0].elements[i].type=="radio" )
		{
			 document.forms[0].elements[i].disabled=flag;
		}
		if(document.forms[0].elements[i].type=="checkbox" )
		{
			 document.forms[0].elements[i].disabled=flag;
		}
		
	}
	
	document.forms[0].avail_date.readOnly=true;
	document.forms[0].fromdate.readOnly=true;
	document.forms[0].ason_date.readOnly=true;
	document.forms[0].uptodate.readOnly=true;
	document.forms[0].Overason_date.readOnly=true;
	
}

function doSave()
{
	if(document.forms[0].txt_bankid.value=="")
	{
		ShowAlert('111',"Loan From Bank / Financial Institution");
		document.forms[0].loan_frombank.focus();
		return false;
	}
	if(document.forms[0].txt_shifting_reason.value=="")
	{
		ShowAlert('121',"Reason for to shifting to our Bank");
		document.forms[0].txt_shifting_reason.focus();
		return false;
	}
	if(document.forms[0].avail_date.value=="")
	{
		ShowAlert('121',"Date of Availing Loan / First Disbursal");
		document.forms[0].avail_date.focus();
		return false;
	}
	if(document.forms[0].txt_due_date.value=="")
	{
		ShowAlert('121',"Due Date / Last Installment Date");
		document.forms[0].txt_due_date.focus();
		return false;
	}
	if(document.forms[0].repay_period.value=="")
	{
		ShowAlert('121',"Total Repayment Period");
		document.forms[0].repay_period.focus();
		return false;
	}
	window.opener.document.forms[0].hidtakeoveravail.value="Y";
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="pertakeover";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/per_takeover.jsp";
	document.forms[0].submit();
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	      			
		document.forms[0].hidAction.value="";
		document.forms[0].action=appURL+"action/per_takeover.jsp";
		document.forms[0].hidBeanId.value="pertakeover";
	  	document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		if(varTakeOver=="vehicle"){
			window.opener.document.forms[0].cmdedit.disabled=false;
			window.opener.document.forms[0].hidBeanGetMethod.value="getBoatAuto";
			window.opener.document.forms[0].hidBeanId.value="percollateral";
			window.opener.document.forms[0].action=appURL+"action/perappvehicle.jsp";	
			window.opener.document.forms[0].submit();
			window.close();
		}
		else if(varTakeOver=="per_house"){
			window.opener.document.forms[0].hidBeanId.value = "perpropertydetails";
			window.opener.document.forms[0].hidBeanGetMethod.value = "getHousingLoanData";
			window.opener.document.forms[0].action = appURL+ "action/per_house_proposed_asset.jsp";
			window.opener.document.forms[0].submit();
			window.close();
		}else{
		window.opener.document.forms[0].hidBeanId.value="perapplicant";
		window.opener.document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		window.opener.document.forms[0].action=appURL+"action/perloandetails.jsp";
		window.opener.document.forms[0].submit();
		window.close();
		}
	}
}



function caculatetot()
{
	var overdue_install=document.forms[0].overdue_install.value;
	var overdue_interest=document.forms[0].overdue_interest.value;
     
	if (overdue_install=="")
	{
		overdue_install = "0";
	}
	if (overdue_interest=="")
	{
		overdue_interest = "0";
	}
	if(document.forms[0].tot_overdue.value=="")
	{
		document.forms[0].tot_overdue.value="0.00";
	}
	var tot_overdue= parseFloat(overdue_install) + parseFloat(overdue_interest);
	document.forms[0].tot_overdue.value=tot_overdue;
	roundtxt(document.forms[0].tot_overdue);
}

function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);
	}
}

function callonload()
{
	if(regular_loan!="")
	{
		document.forms[0].regular_loan.value=regular_loan;
	}
	if(sel_transbank!="")
	{
		document.forms[0].sel_transbank.value=sel_transbank;
	}
	disableFields(true);
	if(varTakeOver=="vehicle"||varTakeOver=="per_house")
		disableCommandButtons("Over");
	else
		disableCommandButtons("load");
//	if(varRecordFlag=="Y")
//	{
//		window.opener.document.forms[0].hidtakeoveravail.value="Y";
//	}
//	else
//	{
//		window.opener.document.forms[0].hidtakeoveravail.value="N";
//	}
}
	
function disableCommandButtons(val)
{
  	if(val=="load")
  	{
	  	/*document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdclose.disabled=false;*/
  	}
  	if(val=="edit")
  	{
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdclose.disabled=true;
  	}
  	if(val=="Over")
  	{
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=true;
		 document.forms[0].cmdcancel.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdclose.disabled=false;
  	}
}
function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=RetTakeOver&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}