function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	document.forms[0].hidBeanGetMethod.value="getloandetails";
	document.forms[0].hidBeanId.value="appraisal";
	document.forms[0].action=appURL+"action/loandetails.jsp";
	document.forms[0].submit();
	}
}
function doClose()
{
	var con = ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/retailpge";
	   	document.forms[0].submit();
	}
}
function checkEligibility()
{
	if(document.forms[0].txt_sanction_amount.value!="")
	{
		document.all.ifrm.src=appURL+"action/iframeeligibility.jsp?hidBeanGetMethod=checkEligibility&hidBeanId=perapplicant&appno="+document.forms[0].appno.value+"&txt_sanction_amount="+document.forms[0].txt_sanction_amount.value;
	}
}
function callUsersHelp()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var prop="scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL+"action/selectusers1.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}
function callOtherTab(val)
{
	if (document.forms[0].cmdsave.disabled)
	{
		if(val=="checklist")
		{
		document.forms[0].hidBeanId.value="appraisal";		
		document.forms[0].hidBeanGetMethod.value="getDataQuestParameters";
		document.forms[0].action=appURL+"action/appraisalconfirm.jsp";	
		document.forms[0].submit();
		 }
		 else
		 {
		 ShowAlert(103);
		 }
     }	
} 
function readretailscoring()
{
	if(confirm("Import Retail Scoring?"))
	{		
		document.forms[0].hidBeanId.value="appraisal";
		document.forms[0].hidAction.value="READ SCORING";		
		document.forms[0].hidBeanGetMethod.value="getloandetails";
		document.forms[0].hidSourceUrl.value="/action/loandetails.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableDetailandServices()
{
	if(prd_type=="pG"||prd_type=="pR")
	{
		document.all.id_EMI.style.display="none";
		document.all.id_RepayCapacity.style.display="none";
		document.all.id_AvailRepayPeriod.style.display="none";
		document.all.id_Networth.style.display="none";
		document.all.id_EMIVal.style.display="none";
		document.all.id_RepayCapacityVal.style.display="none";
		if(document.all.id_AvailRepayPeriodVal.length>1)
		{
			for(var i=0;i<document.all.id_AvailRepayPeriodVal.length;i++)
			{
				document.all.id_AvailRepayPeriodVal[i].style.display="none";
				document.all.id_NetworthVal[i].style.display="none";
			}
		}
		else
		{
			document.all.id_AvailRepayPeriodVal.style.display="none";
			document.all.id_NetworthVal.style.display="none";
		}
	}
	else
	{
		document.all.id_EMI.style.display="table-cell";
		document.all.id_RepayCapacity.style.display="table-cell";
		document.all.id_AvailRepayPeriod.style.display="table-cell";
		document.all.id_Networth.style.display="table-cell";
		document.all.id_EMIVal.style.display="table-cell";
		document.all.id_RepayCapacityVal.style.display="table-cell";
		if(document.all.id_AvailRepayPeriodVal.length>1)
		{
			for(var i=0;i<document.all.id_AvailRepayPeriodVal.length;i++)
			{
				document.all.id_AvailRepayPeriodVal[i].style.display="table-cell";
				document.all.id_NetworthVal[i].style.display="table-cell";
			}
		}
		else
		{
			document.all.id_AvailRepayPeriodVal.style.display="table-cell";
			document.all.id_NetworthVal.style.display="table-cell";
		}
	}
}
function createFlatFile(ARG)
{
	if(confirm("Send Loan Details to IRB ?"))
	{
	document.forms[0].hidAction.value="WRITE SCORING";	
	document.forms[0].hidBeanId.value="LapsToRam";
	if(ARG=="RET-EDU")
	{
		document.forms[0].hidPROD.value="EDU";
	}
	if(ARG=="RET-CUS")
	{
	document.forms[0].hidPROD.value="CUS";
	}
	document.forms[0].hidBeanGetMethod.value="getloandetails";
	document.forms[0].action=appURL+"action/loandetails.jsp";
	document.forms[0].submit();
	}
}
function ShowReport(page)
{
	var appno = document.forms[0].appno.value;
	var url = appURL+"action/"+page+"?appno="+appno;
	var title = "PrintFairReport";
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if (document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";	
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}
function callCalender1()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,'appraisaldate');
	}
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=true;
			if(document.forms[0].elements[i].name=="txt_inspremiumamt")
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
	}
	document.forms[0].appraisedby.readOnly=true;
	document.forms[0].txt_sanction_amount.readOnly=val;
	document.forms[0].txt_sanction_amount.disabled=val;
}
function enableButtons( bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function doEdit()
{
	if(status =="pa")
	{
	document.forms[0].appraisaldate.readOnly=true;
	document.forms[0].appraisedby.readOnly=true;
	document.forms[0].txt_schemefor.readOnly=true;
	document.forms[0].txt_sanction_amount.readOnly=true;
	}
	else
	{
	enableButtons(true, false, false, true,false);
	disablefields(false);
	document.forms[0].hidAction.value="edit";
	}
}
