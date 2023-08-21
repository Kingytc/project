function callonLoad()
{
	disableControls(true,true,true,true,false);
	callDisable(true);
	if(Category!="")
	{
		document.forms[0].sel_category.value=Category;
	}
	else
	{
		document.forms[0].sel_category.value="0";
	}
	if(varOccupation!="")
		{
		document.forms[0].selperemp_occupation.value=varOccupation;
		}
	else
		{
		document.forms[0].selperemp_occupation.value="0";
		}
	if(buspremises!="")
	{
		
		document.forms[0].sel_pre.value=buspremises;
		
	}
	else
	{
		document.forms[0].sel_pre.value="0";
	}
	
	showText();
	if(varemploy=="1")
	{
		document.all.add.style.visibility="visible";
		document.all.city.style.visibility="visible";
		document.all.state.style.visibility="visible";
		document.all.phone.style.visibility="visible";
		document.all.pin.style.visibility="visible";
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
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
		document.all.occ.style.visibility="visible";
		document.all.yeb.style.visibility="visible";
		document.all.est.style.visibility="visible";
		document.all.bp.style.visibility="visible";
		
		document.all.empname.style.visibility="hidden";
		document.all.rec.style.visibility="hidden";
		document.all.ret.style.visibility="hidden";
		document.all.empid.style.visibility="hidden";
		document.all.ln.style.visibility="hidden";
		document.all.ld.style.visibility="hidden";
	}
	
	
}
function callCalender(fieldname)
{
	if(document.forms[0].cmdEdit.disabled==false)
	{
		showCal(appURL,fieldname);
	}
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
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;
		}
	}
}

function callClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();
	}

}
function menuOptionDivMouseDown (url) {
		//if (! isMac) {
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			//window.location=url;
			document.forms[0].action=url;
			document.forms[0].submit();
			//}
		}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/loan_appretail_appempdetails.htm";
  var title = "EmploymentDetails";
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