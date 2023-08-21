function callModFac(val)
{
	if(val=="s")
	{
		val="";
	}
	if(document.forms[0].sel_Bank.value!="")
	{
		 document.all.ifrFacilityDesc.src =appURL+"action/IframeGroupConcernFac.jsp?hidBeanId=combanking&hidBeanGetMethod=getWCFacilitiesData&appno="+document.forms[0].hidappno.value+"&strModType="+document.forms[0].sel_Module.value+"&val1="+val; 
	}
}
function calSelectBank()
{
	if(checktrim(document.forms[0].sel_Bank.value)=="")
	{
		alert("Select whether our bank or other bank");
		document.forms[0].txt_Bank.value="";
	}
}
function calBankFun()
{
	if(document.forms[0].sel_Bank.value=="Our")
	{
		document.forms[0].txt_Bank.value="Karnataka Bank";
	}
	funTypeFacility();
}
function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31,val32,val33,val34)
{
	document.forms[0].sel_Module.value=val20;
	document.forms[0].hidAction.value = "edit";	
	document.forms[0].selsno1.value = val0;
	appno=document.forms[0].appno.value;
	document.forms[0].sel_Bank.value=val11;
	if(document.forms[0].sel_Bank.value=="Our")
	{
		document.forms[0].sel_Facility.value=val1;
		setIdNature(val1);
	}
	else
	{
		//document.forms[0].txt_Facility.value=val1;
		  document.forms[0].hidFacSNo.value="";
	}
	document.forms[0].idno.value=val0;
	document.forms[0].txt_OSAsOnDate.value=val2;
	document.forms[0].sel_BnkType.value=val3;
	document.forms[0].sel_IntType.value=val4;
	document.forms[0].sel_CreditType.value=val5;
	document.forms[0].txt_SancRefNo.value=val6;
	document.forms[0].txt_SancDate.value=val7;
	document.forms[0].txt_DueDate.value=val8;
	document.forms[0].txtArea_Arrears.value=val9;
	document.forms[0].sel_CompName.value=val10;
	document.forms[0].txt_Limit.value=val14;
	document.forms[0].txt_OS.value=val15;
	document.forms[0].txt_SpreadVal.value=val16;
	document.forms[0].txtarea_Remarks.value=val17;
	document.forms[0].hidFacSNo.value=val19;
	document.forms[0].txt_monthlyins.value=val21;
	document.forms[0].txt_cbsappno.value=val23;
	document.forms[0].sel_FacilityNew.value=val18;
	document.forms[0].txt_Exposure.value=val33;
	if(val20=="p"||val20=="r")
	{
		document.forms[0].com_banksel_repaytype.length=6;
		document.forms[0].com_banksel_repaytype.options[1] = new Option('EMI','1');
		document.forms[0].com_banksel_repaytype.options[2] = new Option('Non-EMI','2');
		document.forms[0].com_banksel_repaytype.options[3] = new Option('On Demand','12');
		document.forms[0].com_banksel_repaytype.options[4] = new Option('On Due Date','8');
		document.forms[0].com_banksel_repaytype.options[5] = new Option('Equal Monthly Installment','13');
		document.forms[0].com_banksel_repaytype.options[6] = new Option('2 Yearly Equal Installment','14');
	}
	else
	{
		document.forms[0].com_banksel_repaytype.length=11;
		document.forms[0].com_banksel_repaytype.options[1] = new Option('EMI','E');
		document.forms[0].com_banksel_repaytype.options[2] = new Option('Non-EMI','NE');
		document.forms[0].com_banksel_repaytype.options[3] = new Option('On Demand','OD');
		document.forms[0].com_banksel_repaytype.options[4] = new Option('As Per LC Terms','LC');
		document.forms[0].com_banksel_repaytype.options[5] = new Option('As Per Contract Terms','CO');
		document.forms[0].com_banksel_repaytype.options[6] = new Option('As Per BG Rules','BG');
		document.forms[0].com_banksel_repaytype.options[7] = new Option('On Due Date','DD');
		document.forms[0].com_banksel_repaytype.options[8] = new Option('From the proceeds of PSC \ by realization of bill','PC');
		document.forms[0].com_banksel_repaytype.options[9] = new Option('By Realization of Export Bills','PS');
		document.forms[0].com_banksel_repaytype.options[10] = new Option('By Realization of Respective Bills','PR');
		document.forms[0].com_banksel_repaytype.options[11] = new Option('As per TCBG Rules','TG');
	}
	document.forms[0].com_banksel_repaytype.value=val26;
	document.forms[0].txt_bank_drwpower.value=val27;
	document.forms[0].txtArea_purpose.value=val28;
	document.forms[0].txtArea_repayment.value=val34;
	document.forms[0].txt_prestatus.value=val29;
	document.forms[0].sel_factype.value=val30;
	document.forms[0].txt_bank_intrate.value=val25;
	
	if(val30!="0"&&val30!="M")
	{
		document.all.id_MainLimit1.style.visibility	= "visible";
		document.all.id_MainLimit1.style.position	= "relative";
		document.all.id_MainLimit2.style.visibility	= "visible";
		document.all.id_MainLimit2.style.position	= "relative";
		document.forms[0].txt_facof.value			= val31;
		document.forms[0].txt_facof_desc.value		= val32;
	}
	else
	{
		document.all.id_MainLimit1.style.visibility	= "hidden";
		document.all.id_MainLimit1.style.position	= "absolute";
		document.all.id_MainLimit2.style.visibility	= "hidden";
		document.all.id_MainLimit2.style.position	= "absolute";
		document.forms[0].txt_facof.value			= "0";
		document.forms[0].txt_facof_desc.value		= "";
	}
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableCommandButtons(false,true,true,true,false);
		if((val5=="P") && (document.forms[0].txt_cbsappno.value==""))
		{
			document.forms[0].cmdedit.disabled=true;
		}
	}
}
function doSave()
{
	if(document.forms[0].sel_Bank.value=="")
	{
		ShowAlert(111,"Bank");
		document.forms[0].sel_Bank.focus();
		return;
	}
	else if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_Module.value=="")
		{
			ShowAlert(111,"Module");
			document.forms[0].sel_Module.focus();
			return;
		}
		if(document.forms[0].sel_FacilityNew.value=="")
		{
			ShowAlert(111,"Facility");
			document.forms[0].sel_FacilityNew.focus();
			return;
		}
	}
	else if(document.forms[0].sel_Bank.value=="Other")
	{
		if(document.forms[0].txt_Bank.value=="")
		{
			ShowAlert(121,"Name of the Bank");
			document.forms[0].txt_Bank.focus();
			return;
		}
		//if(document.forms[0].txt_Facility.value=="")
		//{
		//	ShowAlert(121,"Facility");
		//	document.forms[0].txt_Facility.focus();
		//	return;
		//}
	}
	if(document.forms[0].txt_Limit.value=="")
	{
		ShowAlert(121,"Limit");
		document.forms[0].txt_Limit.focus();
		return;
	}
	if(document.forms[0].txt_OS.value=="")
	{
		ShowAlert(121,"Outstanding");
		document.forms[0].txt_OS.focus();
		return;
	}
	if(document.forms[0].txt_OSAsOnDate.value=="")
	{
		ShowAlert(121,"Outstanding as on Date");
		document.forms[0].txt_OSAsOnDate.focus();
		return;
	}
	if(document.forms[0].sel_BnkType.value=="")
	{
		ShowAlert(111,"Banking Type");
		document.forms[0].sel_BnkType.focus();
		return;
	}
	if(document.forms[0].sel_IntType.value=="")
	{
		ShowAlert(111,"Interest Type");
		document.forms[0].sel_IntType.focus();
		return;
	}
	if(document.forms[0].txt_SpreadVal.value=="")
	{
		ShowAlert(121,"Spread Value");
		document.forms[0].txt_SpreadVal.focus();
		return;
	}
	if(document.forms[0].sel_CreditType.value=="")
	{
		ShowAlert(111,"Type of Credit");
		document.forms[0].sel_CreditType.focus();
		return;
	}
	document.forms[0].sel_Bank.disabled=false;
	if(document.forms[0].sel_Bank.value=="Our")
	{
		 document.forms[0].sel_Module.disabled=false;
	}
	if(document.forms[0].txt_bank_intrate.value=="" || document.forms[0].txt_bank_intrate.value=="0.00")
	{
		ShowAlert(121,"Interest Rate");
		document.forms[0].txt_bank_intrate.focus();
		return;
	}
	if(document.forms[0].com_banksel_repaytype.value=="0")
	{
		ShowAlert(111,"Repayment Type");
		document.forms[0].com_banksel_repaytype.focus();
		return;
	}
	if(document.forms[0].txt_DueDate.value=="")
	{
		ShowAlert(121,"Due Date");
		document.forms[0].txt_DueDate.focus();
		return;
	}
	/*if(document.forms[0].sel_CreditType.value=="E")
	{
		if(document.forms[0].txt_cbsappno.value=="")
		{
		alert("Please Enter the CBS Account No");
		document.forms[0].txt_cbsappno.focus();
		return;
		}
	}*/
	document.forms[0].sel_CompName.disabled=false;
	document.forms[0].sel_Facility.disabled=false;
	document.forms[0].sel_BnkType.disabled=false;
	document.forms[0].sel_IntType.disabled=false;
	document.forms[0].sel_CreditType.disabled=false;
	document.forms[0].sel_Bank.disabled=false;
	document.forms[0].sel_factype.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="bankappfi";
	document.forms[0].hidSourceUrl.value="/action/combankingfi.jsp";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function disableCommandButtons(valedit,valapply,valcancel,valdel,valclose)
{
	document.forms[0].cmdedit.disabled=valedit;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=valapply;
	document.forms[0].cmdcancel.disabled=valcancel;
	document.forms[0].cmdclose.disabled=valclose;
}
function doEdit()
{
	disableFields(false);
	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="update";
	if(document.forms[0].sel_Bank.value=="Our")
	{
		if(document.forms[0].sel_CreditType.value=="P")
		{
			document.forms[0].sel_Bank.disabled=true;
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].txt_Limit.readOnly=true;
			document.forms[0].txt_Exposure.readOnly=true;
			document.forms[0].txt_OS.focus();
			document.forms[0].sel_Module.disabled=true;
			disableCommandButtons(true,false,false,true,true);
		}
		else
		{
			disableCommandButtons(true,false,false,false,true);
			document.forms[0].sel_Bank.focus();
		}
	}
	else
	{
		disableCommandButtons(true,false,false,false,true);
		document.forms[0].sel_Bank.focus();
	}
	document.forms[0].sel_CompName.disabled=true;
	document.forms[0].sel_CreditType.disabled=true;
	document.forms[0].sel_Bank.disabled=true;
	document.forms[0].sel_factype.disabled=true;
	document.forms[0].txt_Limit.readOnly=true;
	document.forms[0].txt_OS.readOnly=true;
	document.forms[0].txt_OSAsOnDate.readOnly=true;
	document.forms[0].txt_bank_drwpower.readOnly=true;
	document.forms[0].txt_Exposure.readOnly=true;
	document.forms[0].sel_Module.disabled=true;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="bankappfi";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appURL+"action/combankingfi.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].readOnly=val;
		}	 
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!val);		  
		} 
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		  
		} 
	}
	document.forms[0].sel_FacilityNew.readOnly=true;
	document.forms[0].txt_cbsappno.readOnly=true;
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].sel_Bank.disabled=false;
		   	document.forms[0].hidAction.value ="delete";		
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanId.value="bankappfi";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidSourceUrl.value="/action/combankingfi.jsp";			
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}	
	}
	else
	{
		ShowAlert(158);
	}
}
function onloading()
{
	disableFields(true);
	disableCommandButtons(true,true,true,true,false);
	if(appstatus.toUpperCase()=="OPEN/PENDING")
	{
		document.forms[0].cmdupdateliabilities.disabled=false;
	}else{
		document.forms[0].cmdupdateliabilities.disabled=true;
	}
	if(varGrpRights=='r')
		document.forms[0].cmdupdateliabilities.disabled=true;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}
function callCalender(fname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,fname);
	}
}
function setIdNature(varFac)
{
	if(varFac!="")
	{
		var varFacArr=new Array();
		varFacArr=varFac.split("~");
		if(varFacArr.length>1)
		{
			document.forms[0].hidFacID.value=varFacArr[0];
			document.forms[0].sel_FacilityType.value=varFacArr[1];
			if(document.forms[0].sel_FacilityType.value=="2")
			{	document.all.id_monthlyins.style.display="table-cell";
				document.all.id_monthlyinsval.style.display="table-cell";
			}
			else
			{   document.all.id_monthlyins.style.display="none";
				document.all.id_monthlyinsval.style.display="none";
			}
		}
	}
}
function callLink(page,bean,method)
{ 
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
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
function funTypeFacility()
{
	 if(document.forms[0].sel_FacilityType.value=="2")
	{
		document.all.id_monthlyins.style.display="table-cell";
		document.all.id_monthlyinsval.style.display="table-cell";
	}
	else
	{
		document.all.id_monthlyins.style.display="none";
		document.all.id_monthlyinsval.style.display="none";
	}
}
function callexisec()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=existcreditfac&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);
}
function callRepayMentComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var hidAppNo=document.forms[0].hidappno.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/comments.jsp?hidBeanId=perfinancial&hidBeanGetMethod=getComments&hidAppNo="+hidAppNo+"&hidCommentPage=existcreditfacRepay&appstatus="+appstatus+"&btnenable="+btnenable;
	window.open(url,"Comments",prop);	
}
function callDescHelp(varsubfacFlag)
{
	var varstrSessionModuleType=document.forms[0].sel_Module.value;
	var apptype="GCF";
	if(varstrSessionModuleType!="")
	{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = appURL+"action/facilitieslisthelp.jsp?hidBeanId=appeditlock&hidBeanGetMethod=getProductList&strFrom="+apptype+"&strModuleType="+varstrSessionModuleType;
		var title = "ProductsSearch";
		var prop = "scrollbars=yes,width=700,height=430,status=yes";	
		prop = prop + ",left=50,top=50";		
		window.open(varQryString,title,prop);
	}
	}
	else
	{
      alert("Select Module Type");
      document.forms[0].sel_Module.focus();
      return;
	}
}
function doUpdateLiabilities()
{
	document.forms[0].hidBeanId.value="bankappfi";
	document.forms[0].hidSourceUrl.value="/action/combankingfi.jsp";
	document.forms[0].hidBeanMethod.value="updateFreezeData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}