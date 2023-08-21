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

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
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

function callonLoad()
{
	//document.getElementById("text_lease").style.visibility="hidden";
	//document.getElementById("name_lease").style.visibility="hidden";
	if(varemploy.toUpperCase()=="6")
	{
		document.all.t1.style.visibility="hidden";
		document.all.t2.style.visibility="hidden";
	}
	else
	{
		document.all.t1.style.visibility="visible";
		document.all.t2.style.visibility="visible";
	}
	callDisable(true);
	if(document.forms[0].hidappstatus.value=="true")
	{
		disableControls(true,true,true,false);
	}
	else
	{
		disableControls(false,true,true,false);
	}

	if(varemploy=="1")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.empname.style.visibility="visible";
		document.all.rec.style.visibility="visible";
		if(varStaff.toUpperCase()=="Y")
		{
			document.all.emp.style.visibility="hidden";
			document.all.empid.style.visibility="hidden";
			document.all.emp1.style.visibility="hidden";
		}
		else
		{
			document.all.empid.style.visibility="visible";
		}
		document.all.est.style.visibility="visible";
		document.all.ret.style.visibility="visible";
		document.all.id_conemp.style.visibility="visible";
		document.all.id_conemp.style.position="relative";
		document.all.id_list.style.visibility="visible";
		document.all.id_list.style.position="relative";
		document.all.id_source.style.visibility="visible";
		document.all.id_source.style.position="relative";
		
		var varlistcomp=document.all.sel_listcom.value;
		if(varlistcomp=="" || varlistcomp=="0" || varlistcomp=="1")
		{
			document.all.id_empdeal.style.visibility="hidden";
			document.all.id_empdeal.style.position="absolute";
			document.all.id_noofyrs.style.visibility="hidden";
			document.all.id_noofyrs.style.position="absolute";
		}
		else
		{
			document.all.id_empdeal.style.visibility="visible";
			document.all.id_empdeal.style.position="relative";
			document.all.id_noofyrs.style.visibility="visible";
			document.all.id_noofyrs.style.position="relative";
		}

	}
	if(varemploy=="2")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.est.style.visibility="visible";
		document.all.empname.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="3")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.est.style.visibility="visible";
		document.all.empname.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="4")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="5")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.est.style.visibility="visible";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="6" || varemploy=="7" || varemploy=="8")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.est.style.visibility="visible";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="9")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="visible";
		document.all.ret.style.visibility="visible";
		document.all.empid.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.id_conemp.style.visibility="visible";
		document.all.id_conemp.style.position="relative";
		document.all.id_list.style.visibility="visible";
		document.all.id_list.style.position="relative";
		document.all.id_source.style.visibility="visible";
		document.all.id_source.style.position="relative";
		var varlistcomp=document.all.sel_listcom.value;
		if(varlistcomp=="" || varlistcomp=="0" || varlistcomp=="1")
		{
			document.all.id_empdeal.style.visibility="hidden";
			document.all.id_empdeal.style.position="absolute";
			document.all.id_noofyrs.style.visibility="hidden";
			document.all.id_noofyrs.style.position="absolute";
		}
		else
		{
			document.all.id_empdeal.style.visibility="visible";
			document.all.id_empdeal.style.position="relative";
			document.all.id_noofyrs.style.visibility="visible";
			document.all.id_noofyrs.style.position="relative";
		}
	}
	if(varemploy=="10")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="11")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	if(varemploy=="12")
	{
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.est.style.visibility="visible";
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
		document.all.id_source.style.visibility="hidden";
		document.all.id_source.style.position="absolute";
	}
	
	if(varemploy=="1" || varemploy=="4")
	{
		document.getElementById('exp_col').innerHTML="Experience in Years";
	}
	else if(varemploy=="2" || varemploy=="3" || varemploy=="6" || varemploy=="7" || varemploy=="8" || varemploy=="11")
	{
		document.getElementById('exp_col').innerHTML="No. of Years in current activity";
	}
}

function disableControls(bcmdEdit,bcmdsave,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdsave;
	//document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function doSave()
{
	if(varemploy=="1")
	{
		if(trim(document.forms[0].txtperemp_name.value)=="")
		{
			ShowAlert('121','Employer Name');
			document.forms[0].txtperemp_name.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_address1.value)=="")
		{
			ShowAlert('121','Address');
			document.forms[0].txtperemp_address1.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_city.value)=="")
		{
			ShowAlert('121','City');
			return;
		}
		if(trim(document.forms[0].txtperemp_state.value)=="")
		{
			ShowAlert('121','State');
			return;
		}
		if(trim(document.forms[0].txtperemp_zip.value)=="")
		{
			ShowAlert('121','Pincode');
			document.forms[0].txtperemp_zip.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_phone.value)=="")
		{
			ShowAlert('121','Phone No.');
			document.forms[0].txtperemp_phone.focus();
			return;
		}
			if(trim(document.forms[0].txtperemp_empno.value)=="")
			{
				ShowAlert('121','Employee Id');
				document.forms[0].txtperemp_empno.focus();
				return;
			}
			if(document.forms[0].txt_expinyrs.value=="")
			{
				ShowAlert('121','Experience in years');
				document.forms[0].txt_expinyrs.focus();
				return;
			}
		if(trim(document.forms[0].txtperemp_receipt.value)=="")
		{
			
			ShowAlert('121','Employer Salary Receipt Date');
			document.forms[0].txtperemp_receipt.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_retdate.value)=="")
		{
			ShowAlert('121','Retirement Date');
			document.forms[0].txtperemp_retdate.focus();
			return;
		}
		if(document.forms[0].sel_confemp.value=="0")
		{
			ShowAlert('121','Whether a confirmed employee');
			document.forms[0].sel_confemp.focus();
			return;
		}
		if(document.forms[0].sel_empsource.value=="0")
		{
			ShowAlert('121','Whether an Regular Source from a gainful employment');
			document.forms[0].sel_empsource.focus();
			return;
		}
		if(document.forms[0].sel_listcom.value=="0")
		{
			ShowAlert('121','Whether an employee of a listed company');
			document.forms[0].sel_listcom.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_establish.value)=="")
		{
			ShowAlert('121',' Date of Joining in the Current Employment');
			document.forms[0].txtperemp_establish.focus(); 
			return;
		}
		if(document.forms[0].sel_listcom.value=="2")
		{
			if(document.forms[0].sel_empdeal.value=="0")
			{
				ShowAlert('121','Whether an employer is dealing with our company');
				document.forms[0].sel_empdeal.focus();
				return;
			}
			else if(document.forms[0].sel_empdeal.value=="1")
			{
				if(document.forms[0].txt_noofyears.value=="")
				{
					ShowAlert('121','No. of years');
					document.forms[0].txt_noofyears.focus();
					return;
				}
			}
			else
			{
				//Nofunction required.
			}
		}	
	}
	if(varemploy=="4")
	{
	
		if(document.forms[0].txt_expinyrs.value=="")
		{
			ShowAlert('121','Experience in years');
			document.forms[0].txt_expinyrs.focus();
			return;
		}
	}
	if(varemploy=="2" || varemploy=="3" || varemploy=="6" || varemploy=="7" || varemploy=="8" || varemploy=="11")
	{
		if(document.forms[0].txt_expinyrs.value=="")
		{
			ShowAlert('121','No. of Years in current activity');
			document.forms[0].txt_expinyrs.focus();
			return;
		}
		
		if(trim(document.forms[0].txtperemp_establish.value)=="")
		{
			ShowAlert('121',' Date of Commencement');
			document.forms[0].txtperemp_establish.focus(); 
			return;
		}
		if(varemploy=="3")
		{
			if(trim(document.forms[0].txtperemp_name.value)=="")
			{
				ShowAlert('121','Employee Name');
				document.forms[0].txtperemp_name.focus();
				return;
			}
		}
	}
	
	if(varemploy=="9")
	{
		if(trim(document.forms[0].txtperemp_name.value)=="")
		{
			ShowAlert('121','Company Name');
			document.forms[0].txtperemp_name.focus();
			return;
		} 
		if(trim(document.forms[0].txtperemp_receipt.value)=="")
		{
			ShowAlert('121','Pension Receipt Date');
			document.forms[0].txtperemp_receipt.focus();
			return;
		}
		if(trim(document.forms[0].txtperemp_retdate.value)=="")
		{
			ShowAlert('121','Retirement Date');
			document.forms[0].txtperemp_retdate.focus();
			return;
		} 	
		if(document.forms[0].sel_confemp.value=="0")
		{
			ShowAlert('121','Whether a confirmed employee');
			document.forms[0].sel_confemp.focus();
			return;
		}
		if(document.forms[0].sel_empsource.value=="0")
		{
			ShowAlert('121','Whether an Regular Source from a gainful employment');
			document.forms[0].sel_empsource.focus();
			return;
		}
		if(document.forms[0].sel_listcom.value=="0")
		{
			ShowAlert('121','Whether an employee of a listed company');
			document.forms[0].sel_listcom.focus();
			return;
		}
		if(document.forms[0].sel_listcom.value=="2")
		{
			if(document.forms[0].sel_empdeal.value=="0")
			{
				ShowAlert('121','Whether an employer is dealing with our company');
				document.forms[0].sel_empdeal.focus();
				return;
			}
			else if(document.forms[0].sel_empdeal.value=="1")
			{
				if(document.forms[0].txt_noofyears.value=="")
				{
					ShowAlert('121','No. of years');
					document.forms[0].txt_noofyears.focus();
					return;
				}
			}
			else
			{
				//Nofunction required.
			}
		}
	}
	if(document.forms[0].hidModuleName.value=="T")
	{
		alert(" Create separate Profile for each Partner/Co-Parcener/Truste/SHG Member/Director/guarantor if any? ");
	}
	else
	{
		//alert(" Create Profile for co-applicant /guarantor if any? ");
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value = varRecordFlag;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanMethod.value="updateEmployer";
	document.forms[0].hidBeanGetMethod.value="getEmployer";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/peremployer.jsp?applnt=P";
	document.forms[0].submit();
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
	document.forms[0].txt_servicemonths.readOnly=true;
	document.forms[0].txtserviceleft.readOnly=true;
	document.forms[0].txtperemp_state.readOnly=true;
	document.forms[0].txtperemp_city.readOnly=true;
}

function doEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);
	document.forms[0].txtperemp_name.focus();
	document.forms[0].hideditflag.value="Y";	
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

function callIncome()
{
	if(document.forms[0].hideditflag.value=="N")
	{
		if(isNaN(value1))
		{
			ShowAlert('103');
		}
		else
		{	
			document.forms[0].hidBeanGetMethod.value="getIncome";
			document.forms[0].action=appURL+"action/perincexpenses.jsp?applnt=P";
			document.forms[0].submit();
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
		document.forms[0].hidBeanGetMethod.value="getEmployer";
		document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="mastapplicant";
			document.forms[0].hidBeanGetMethod.value="updateEmployer";
			document.forms[0].hidBeanGetMethod.value="getEmployer";
			document.forms[0].action=appURL+"action/peremployer.jsp?applnt=P";
			document.forms[0].submit();
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
	var hlpvar = appURL+"phlp/loan_appretail_custpro_empdetails.htm";
  	var title = "GlobalOption";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
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
function callemp()
{
	var varlistcomp=document.all.sel_listcom.value;
	if(varlistcomp=="" || varlistcomp=="0" || varlistcomp=="1")
	{
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	else
	{
		document.all.id_empdeal.style.visibility="visible";
		document.all.id_empdeal.style.position="relative";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	document.forms[0].sel_empdeal.value="0";
	document.forms[0].txt_noofyears.value="";
}
function callnoofyrs()
{
	var varempdeal=document.all.sel_empdeal.value;
	if(varempdeal=="" || varempdeal=="0" || varempdeal=="2")
	{
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	else
	{
		document.all.id_noofyrs.style.visibility="visible";
		document.all.id_noofyrs.style.position="relative";
	}
	document.forms[0].txt_noofyears.value="";
}