function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text' && document.forms[0].elements[i].name!="appno" && document.forms[0].elements[i].name!="appname" && document.forms[0].elements[i].name!="appstatus" && document.forms[0].elements[i].name!="demo_industrycode" && document.forms[0].elements[i].name!="productdesc" && document.forms[0].elements[i].name!="demo_companyname" && document.forms[0].elements[i].name!="loan_terms")
		  {
			  document.forms[0].elements[i].readOnly=val;
		  }
	  }
	  
	  document.forms[0].demo_finstandard[0].disabled=val;
	  document.forms[0].demo_finstandard[1].disabled=val;
	  document.forms[0].demo_finstandard[2].disabled=val;
	  document.forms[0].demo_indrating[0].disabled=val;
	  document.forms[0].demo_indrating[1].disabled=val;
	  document.forms[0].demo_indrating[2].disabled=val;

	
  }

  function disableCommandButtons(val)
  {
	
	  if(val=="load")
	  {
		  if(editflag==1)
		  document.forms[0].cmdedit.disabled=false;
		  document.forms[0].cmddel.disabled=true;
		  document.forms[0].cmdapply.disabled=true;
		  document.forms[0].cmdcancel.disabled=true;
		  document.forms[0].cmdclose.disabled=false;
	  }
	 
	  if(val=="edit" || varhidpge =='newpge' ||  varhidRen == 'renewal')
	  {
		  document.forms[0].cmdedit.disabled=true;
		  document.forms[0].cmddel.disabled=false;
		  document.forms[0].cmdapply.disabled=false;
		  document.forms[0].cmdcancel.disabled=false;
		  if(document.forms[0].appno.value != "new")
		  {
		  document.forms[0].cmdclose.disabled=true;
		  }
		  else
		  {
			document.forms[0].cmdclose.disabled=false;
			document.forms[0].cmddel.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
		  }
		  disableFields(false);
	  }
 }


 function checkAppAmt()
  {
  var appamt = document.forms[0].approveamt.value;
  var costprd = document.forms[0].loan_costloanprd.value;
  var prddesc = document.forms[0].productdesc.value.split("-");
  var reqAmt = parseFloat(document.forms[0].loan_amtreqd.value);
  var varfrom=prddesc[prddesc.length-2];
  var varto=prddesc[prddesc.length-1];

  if(parseFloat(appamt)>parseFloat(varto))
	  {
	  alert("Approved Amount cannot be greater than product value");
		return false;
	  }

  
  if(document.forms[0].prd_type.value=="TL")
	  {
		if(parseFloat(appamt)>parseFloat(costprd))
		{
  		alert("Approved Amount cannot be greater than Cost of Loan Product");
		document.forms[0].approveamt.focus();
		return false;
	    }
	  }
   }

function checkStandards()
  {
	  document.forms[0].demo_industrycode.value = "";
	  document.forms[0].demo_indrating[0].checked = false;
	  document.forms[0].demo_indrating[1].checked = false;
	  document.forms[0].demo_indrating[2].checked = false;
  }
  

  // for Calculating Recommended Loan Amount for Working Capital
  function getRecmdAmt()
  {
	  var prddesc = document.forms[0].productdesc.value.split("-");
	  var reqAmt = parseFloat(document.forms[0].loan_amtreqd.value);
	  	var varfrom=prddesc[prddesc.length-2];
		var varto=prddesc[prddesc.length-1];
		
	  if(reqAmt != "" && (reqAmt < varfrom || reqAmt > varto))
	  {
		  ShowAlert(134);
		  document.forms[0].loan_amtreqd.value="";	
		  return false;
	  }
	  
	  if(document.forms[0].prd_type.value =="Term Loan")
	  {
		  if(document.forms[0].loan_costloanprd == "")
		  {
			  ShowAlert(128,"Cost of Loan Product");
			  return false;
		  }
	  
	  }
	  else
	  {

		  document.forms[0].loan_recmdamt.value = roundVal(reqAmt);
		  	  
		  if(appamt=="")
		  {
		  document.forms[0].approveamt.value = roundVal(reqAmt);
		  }
		  else
		  {
			  document.forms[0].approveamt.value = roundVal(appamt);
		  }
		  document.forms[0].loan_downpay.value =roundVal(parseFloat(reqAmt) - parseFloat(document.forms[0].approveamt.value));
		  if(document.forms[0].loan_costloanprd.value=="")
		  {
			document.forms[0].loan_costloanprd.value="0.00";
		  }

	  }
  }


  // For Calculating Recommened Amount for Term Loan
  function getRecmdAmtTermLoan()
  {
		  var reqAmt = document.forms[0].loan_amtreqd.value;
		  var prdcost=document.forms[0].loan_costloanprd.value;
		  var lvr=document.forms[0].prd_lvr.value;
		  
		  if(prdcost == "")
			{
			  return;
			}
		  if(parseFloat(prdcost) < parseFloat(reqAmt))
		  {
			  ShowAlert(133);
			  document.forms[0].txtmps.value = "0.00";
			  return false;
		  }

		  var recmdamt;
		  var margin;

		  if(parseFloat(prdcost) == parseFloat(reqAmt))
		  {
			 recmdamt = parseFloat(prdcost)*lvr/100;
			 margin = parseFloat(prdcost) - parseFloat(recmdamt);
		  }
		  else if(parseFloat(prdcost) > parseFloat(reqAmt))
	      {
			recmdamt = parseFloat(prdcost)*parseFloat(lvr)/100;
			
			 if(parseFloat(recmdamt)>parseFloat(reqAmt))
			  {
				recmdamt = parseFloat(reqAmt);
			  }
			 margin = parseFloat(prdcost) - parseFloat(recmdamt);
		  }
		  
		  
		  document.forms[0].loan_recmdamt.value=roundVal(recmdamt);
		  if(appamt=="")
		  {
		  document.forms[0].approveamt.value = roundVal(recmdamt);
		  }
		  else
		  {
			 document.forms[0].approveamt.value = roundVal(appamt);
		  }
		  document.forms[0].loan_downpay.value = roundVal(margin);
		  callEMI();
	
  }

  function callRecmdAmount()
  {
	checkAmtReq();
	if(document.forms[0].prd_type.value =="TermLoan" || document.forms[0].prd_type.value =="Term Loan")
	  {
		
		getRecmdAmtTermLoan();
	  }
	 else if(document.forms[0].prd_type.value =="WorkingCapital" || document.forms[0].prd_type.value =="Working Capital")
	  {
		 getRecmdAmt();
	  }
	  if(trim(document.forms[0].loan_amtreqd.value)=="")
	  {
			document.forms[0].loan_recmdamt.value="";
			document.forms[0].loan_downpay.value="";
			document.forms[0].approveamt.value="";
	  }
  }

  function changeApproveAmt()
  {
	  
	  var costloanprd = document.forms[0].loan_costloanprd.value;
	  var approveamt  = document.forms[0].approveamt.value;

	  var actmargin = parseFloat(costloanprd) - parseFloat(approveamt);
		
		if(costloanprd != "0.00" && costloanprd != "")
		{
		document.forms[0].loan_downpay.value = roundVal(actmargin);
		}
	  
	  var actloanratio = (approveamt/costloanprd)*100;
	  if(costloanprd=="0.00")
	  {
		  actloanratio = document.forms[0].prd_lvr.value;
	  }
	  if(!isNaN(actloanratio))
	  {
	  document.forms[0].actlvr.value=roundVal(parseFloat(actloanratio));
	  }
  }


  // For Calcuting EMI
  function callEMI()
  {
			var varAmtrecomd = parseFloat(document.forms[0].approveamt.value);
			var varrate=parseFloat(document.forms[0].loan_modintrate.value)/(12*100);
			
			var varterm=parseFloat(document.forms[0].loan_terms.value);
			
			var denominator=Math.pow(varrate+1,varterm)-1;
			var varnumerator=varrate*Math.pow(varrate+1,varterm);

			var varemi=(varnumerator/denominator)*varAmtrecomd;
			if(document.forms[0].prd_type.value !="" && document.forms[0].prd_type.value == "Term Loan")
			{
			document.forms[0].txtmps.value = roundVal(varemi);
			}
			else
			{
				document.forms[0].txtmps.value="0.00";
			}

  }


  
  function getActualLvr()
  {
	  var acrlvr;
	  if(prdtype=="ct")
	  {
		  if(document.forms[0].loan_amtreqd.value == document.forms[0].loan_costloanprd.value)
		  {
			actlvr = document.forms[0].prd_lvr.value;
		  }
		  else
		  {
			  actlvr = document.forms[0].prd_lvr.value;
		  }
		  document.forms[0].actlvr.value=roundVal(actlvr);
		  
	  }
	  else
	  {
		  document.forms[0].actlvr.value="0.00";
	  }
  }

function loadDatas()
{
	if(document.forms[0].productdesc.value != "")
	{
	if(prdtype == "ct")
	{
		rval = getRecmdAmtTermLoan();
		
	}
	else
	{
		rval = getRecmdAmt();
		
	}
	getActualLvr();
	callEMI();
	}
	
}

function enableStds()
{
	if(document.forms[0].demo_finstandard[0].checked == true && document.forms[0].demo_finstandard[0].disabled == false)
	{
		for(i=0;i<document.forms[0].demo_indrating.length;i++)
		{
			document.forms[0].demo_indrating[i].disabled = false;
		}
	}
	else
	{
		for(i=0;i<document.forms[0].demo_indrating.length;i++)
		{
			document.forms[0].demo_indrating[i].disabled = true;
		}
	}
}

function checkAmtReq()
{
	var amtreq = parseFloat(document.forms[0].loan_amtreqd.value);
	var desc = document.forms[0].productdesc.value.split('-');
	if(amtreq != "" && (amtreq<parseFloat(desc[2]) || parseFloat(amtreq>desc[3])))
	{
		ShowAlert(137);
		document.forms[0].loan_amtreqd.value="";
		return;

	}
}

  function doEdit()
  {
	document.forms[0].hideditflag.value="yes";
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appUrl+"action/comloanproduct.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
  }

  function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].action=appUrl+"action/comloanproduct.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
  }

  function doDelete()
	{
	document.forms[0].hidEditMode.value="D";	
	document.forms[0].hidBeanMethod.value="updateLoanProducts";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidSourceUrl.value=appUrl+"action/comsearch.jsp";	
	document.forms[0].method="post";
	document.forms[0].action=appUrl+"action/ControllerServlet";	
	document.forms[0].submit();
	}

  function doSave()
  {
	if(document.forms[0].demo_companyname.value == "")
	  {
		ShowAlert(121,'Name of the Business');
		return false;
	  }

	  if(document.forms[0].productdesc.value == "")
	  {
		  ShowAlert(111,'Product');
		return false;
	  }

	  if(document.forms[0].loan_amtreqd.value == "" || document.forms[0].loan_amtreqd.value == "0.00")
	  {
		 
		  ShowAlert(121,'Amount Requested');
		  document.forms[0].loan_amtreqd.focus();
		  return false;
	  }
		
	  if(document.forms[0].prd_type.value == "Term Loan")
	  {
			if(document.forms[0].loan_costloanprd.value == "" || document.forms[0].loan_costloanprd.value == "0.00")
			{
				ShowAlert(121,'Cost of Loan product');
				document.forms[0].loan_costloanprd.focus();
				return false;
			}
			
	  }

		if(document.forms[0].prd_type.value == "Term Loan")
		{
			if(parseFloat(document.forms[0].loan_costloanprd.value) < parseFloat(document.forms[0].loan_amtreqd.value))
			{
			ShowAlert(133);
			return false;
			}
		}

	  if(document.forms[0].demo_finstandard[0].checked == true)
	  {
		if(document.forms[0].demo_industrycode.value == "")
		  {
			ShowAlert(111,'Industrial Code');			
			return false;
		  }
		  if(document.forms[0].demo_indrating[0].checked != true && document.forms[0].demo_indrating[1].checked != true && document.forms[0].demo_indrating[2].checked != true )
		  {
			ShowAlert(111,'Industrial Standard');		
			return false;
		  }
	  
	  }
	
	
	if(document.forms[0].appno.value!="new")
	  {
		document.forms[0].hidAction.value="update";
	  }
	else
	  {
		document.forms[0].hidAction.value="insert";
		document.forms[0].hidSourceUrl.value="/jsp/com/comloanproduct.jsp";
	  }
	
	
	document.forms[0].app_no.value=document.forms[0].appno.value;
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].cmdapply.disabled=true;
	document.forms[0].appname.disabled=false;
	document.forms[0].appstatus.disabled=false;
	document.forms[0].submit();
  }


 function doClose()
 {
	if(varhidpge == "newpge")
	{
		document.forms[0].action=appUrl+"action/comloanhistroy.jsp";
	}
	else if(varhidRen == "renewal")
	{
	document.forms[0].action=appUrl+"action/renewal.jsp";
	}
	else
	{
	document.forms[0].action=appUrl+"action/comsearch.jsp";
	}
	document.forms[0].submit();
	
	
 }

  function callApplicantTab(page)
  {
  	if(document.forms[0].cmdapply.disabled)
	{
	  if(page=="company")
	  {
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appUrl+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appUrl+"action/comproposal.jsp";
	  }
	  document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
  }
  function callPrdhelp()
  {
//	if(document.forms[0].cmdedit.disabled && editflag==1)
	//{
		var prop = "scrollbars=no,width=400,height=300,,top=100,left=250";
		var url=appUrl+"action/productslisthelp.jsp?apptype=c";
		window.open(url,"",prop);
	//}
  }

function callInthelp()
  {
		var prop = "scrollbars=no,width=400,height=300,,top=100,left=250";
		var url=appUrl+"action/interesthelp.jsp";
		window.open(url,"",prop);
  }

  function callApplicanthelp()
  {
	  if(document.forms[0].cmdedit.disabled && editflag==1)
	  {
		var prop = "scrollbars=no,width=400,height=300,,top=100,left=250";
		var url=appUrl+"action/comapplicantlist.jsp";
		window.open(url,"",prop);
	  }
  }

   function callIndcodehelp()
   {
	  //if(document.forms[0].cmdedit.disabled && editflag==1)
	  //{
		//if(document.forms[0].demo_finstandard[0].checked == true)
		 // {
		var prop = "scrollbars=no,width=400,height=300,,top=100,left=250";
		var url=appUrl+"action/comindcodelist.jsp";
		window.open(url,"",prop);
		 // }
	 // }
   }
