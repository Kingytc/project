function callonLoad()
{
	
	if(vardesig.toUpperCase()=="1")
	{
		//document.forms[0].txtperemp_empdesig.options.selectedIndex=1;
	}
	else if(vardesig.toUpperCase()=="2")
	{
		//document.forms[0].txtperemp_empdesig.options.selectedIndex=2;
	}
	else if(vardesig.toUpperCase()=="3")
	{
		//document.forms[0].txtperemp_empdesig.options.selectedIndex=3;
	}
	else if(vardesig.toUpperCase()=="4")
	{
		//document.forms[0].txtperemp_empdesig.options.selectedIndex=4;
	}
	else
	{
		//document.forms[0].txtperemp_empdesig.options.selectedIndex=0;
	}

	if(varemploy.toUpperCase()=="6")
	{
		//document.all.r1.style.visibility="hidden";
		//document.all.r2.style.visibility="hidden";
	}
	else
	{
		//document.all.r1.style.visibility="visible";
		//document.all.r2.style.visibility="visible";
	}
	//disableControls(true,true,true,true,false);
	callDisable(true);
	/*if(Category!="")
	{	
		document.forms[0].sel_category.value=Category;
		
	}
	else
	{
		document.forms[0].sel_category.value="0"; 
	}
	if(buspremises!="")
	{
		
		document.forms[0].sel_pre.value=buspremises;
	}
	else
	{
		document.forms[0].sel_pre.value="0";
	}
	if(buspremises=="2")
	{	
		//showText();
			
	}
	if(varemploy=="1")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
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
		document.all.est.style.visibility="hidden";
		document.all.bp.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
	}
	if(varemploy=="2")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		document.all.ln.style.visibility="visible";
		document.all.ld.style.visibility="visible";
		
		document.all.empname.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
	}
	if(varemploy=="3")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		document.all.empname.style.visibility="visible";
		
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
	}
	if(varemploy=="4")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.empname.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
	}
	if(varemploy=="5")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
	}
	if(varemploy=="6" || varemploy=="7" || varemploy=="8")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		document.all.ln.style.visibility="visible";
		document.all.ld.style.visibility="visible";
		
		document.all.empid.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
	}
	if(varemploy=="9")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.empname.style.visibility="visible";
		document.all.rec.style.visibility="visible";
		document.all.ret.style.visibility="visible";
		
		document.all.empid.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.bp.style.visibility="hidden";
	}
	if(varemploy=="10")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.bp.style.visibility="hidden";
		
	}
	if(varemploy=="11")
	{
		document.all.yeb.style.visibility="visible";
		
		document.all.add.style.visibility="hidden";
		document.all.city.style.visibility="hidden";
		document.all.state.style.visibility="hidden";
		document.all.phone.style.visibility="hidden";
		document.all.pin.style.visibility="hidden";
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
		document.all.est.style.visibility="hidden";
		document.all.bp.style.visibility="hidden";
	}
	if(varemploy=="12")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
	}*/
	//showText();
	if(varemploy=="1")
	{
		document.all.id_conemp.style.visibility="visible";
		document.all.id_conemp.style.position="relative";
		document.all.id_list.style.visibility="visible";
		document.all.id_list.style.position="relative";
		
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
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="3")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="4")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="5")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="6" || varemploy=="7" || varemploy=="8")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="9")
	{
		document.all.id_conemp.style.visibility="visible";
		document.all.id_conemp.style.position="relative";
		document.all.id_list.style.visibility="visible";
		document.all.id_list.style.position="relative";
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
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="11")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
	if(varemploy=="12")
	{
		document.all.id_conemp.style.visibility="hidden";
		document.all.id_conemp.style.position="absolute";
		document.all.id_list.style.visibility="hidden";
		document.all.id_list.style.position="absolute";
		document.all.id_empdeal.style.visibility="hidden";
		document.all.id_empdeal.style.position="absolute";
		document.all.id_noofyrs.style.visibility="hidden";
		document.all.id_noofyrs.style.position="absolute";
	}
}

function disableControls(bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}


function callpersonal()
{
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].hidBeanGetMethod.value="getPersonalLoandetails";
	document.forms[0].action=appURL+"action/perpersonal.jsp";
	document.forms[0].submit();
}

function callCalender(fieldname)
{
	if(document.forms[0].cmdEdit.disabled==false)
	{
		showCal(appURL,fieldname);
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
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}
	}
}

function callEdit()
{
	callDisable(false);
}

function callDemographics()
{
var applnt=document.forms[0].applntype.value;
	//alert(document.forms[0].applntype.value);
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action=appURL+"action/perapplicantdispco.jsp?applnt="+applnt;
		document.forms[0].submit();
	}
}


function callIncome()
{
	if(isNaN(value1))
	{
		//alert("no permission");
	}else
	{	
	var applnt=document.forms[0].applntype.value;
	//alert(document.forms[0].applntype.value);
		document.forms[0].hidBeanGetMethod.value="getIncome";
		document.forms[0].action=appURL+"action/perincexpensesdispco.jsp?applnt="+applnt;
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
function loanDetails()
{
	document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	document.forms[0].action=appURL+"action/perloandetails.jsp";
	document.forms[0].submit();
}

function callLink(page,bean,method)
{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	
}