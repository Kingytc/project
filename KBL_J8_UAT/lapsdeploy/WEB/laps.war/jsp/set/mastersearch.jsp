<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;	
}
//out.println("hshValues"+hshValues);
ArrayList g1 =  new ArrayList();
String strStatId=Helper.correctNull((String)hshValues.get("strStatId"));
String strStatsno=Helper.correctNull((String)hshValues.get("stat_data_sno"));
if(strStatsno=="")
{
	strStatsno="0";
}%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var statno=<%=strStatsno%>;
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function callonLoad()
	{		
	disablefields(true);
	enableButtons(false, true, true, true, false);
	document.forms[0].seldataheadtype.value='<%=strStatId%>'; 
	
	if(document.forms[0].hidsno.value!="")
	
	if(statno>1)
	{
	
	document.forms[0].radiobutton[<%=strStatsno%>-1].checked=true;
	}
	if(statno=="1")
	{
	
	document.forms[0].radiobutton.checked=true;
	}

	if(document.forms[0].seldataheadtype.value=="205")
	{
		document.all.idval1.style.display="table-cell";
		document.all.idval2.style.display="table-cell";
	}
	else
	{
		document.all.idval1.style.display="none";
		document.all.idval2.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="218"|| document.forms[0].seldataheadtype.value=="252")
	{
		document.all.idval3.style.display="table-cell";
		document.all.idval4.style.display="table-cell";
		document.forms[0].selSMS.disabled=true;
	}
	else
	{
		document.all.idval3.style.display="none";
		document.all.idval4.style.display="none";
	}


	if(document.forms[0].seldataheadtype.value=="283")
	{
		document.all.idval5.style.display="table-cell";
		document.all.idIndSector.style.display="table-cell";
		document.forms[0].sel_Industry.disabled=true;
	}
	else
	{
		document.all.idval5.style.display="none";
		document.all.idIndSector.style.display="none";
	}
	
	if(document.forms[0].seldataheadtype.value=="211")
	{
		document.all.txt_act.style.display="table-cell";
		document.all.id_act.style.display="table-cell";
		document.forms[0].sel_act.disabled=true;
	}
	else
	{
		document.all.txt_act.style.display="none";
		document.all.id_act.style.display="none";
	}

	if(document.forms[0].seldataheadtype.value=="267")
	{
		document.all.idvalcersai.style.display="table-cell";
		document.all.idCersaiReq.style.display="table-cell";
		document.forms[0].sel_CersaiReq.disabled=true;
	}
	else
	{
		document.all.idvalcersai.style.display="none";
		document.all.idCersaiReq.style.display="none";
	}

	if(document.forms[0].seldataheadtype.value=="171")
	{
		document.all.idvalclpu1.style.display="table-cell";
	}
	if(document.forms[0].seldataheadtype.value=="268")
	{
		document.all.idvalclpu1.style.display="table-cell";
		document.all.idvalclpu2.style.display="table-cell";
		document.all.idvalclpu3.style.display="table-cell";
		document.all.idvalclpu4.style.display="table-cell";
		document.forms[0].sel_clpuReq.disabled=true;
		document.forms[0].sel_bankschemeforclpu.disabled=true;
	}
	else
	{
		document.all.idvalclpu1.style.display="none";
		document.all.idvalclpu2.style.display="none";
		document.all.idvalclpu3.style.display="none";
		document.all.idvalclpu4.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="224")
	{
		document.all.idMCLRNote.style.display="table-cell";
	}
	else
	{
		document.all.idMCLRNote.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="252" || document.forms[0].seldataheadtype.value=="171")
	{
		document.all.idbank1.style.display="table-cell";
	}
	else
	{
		document.all.idbank1.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230")
	{
		document.all.idval6.style.display="table-cell";
		document.all.idval7.style.display="table-cell";
		document.forms[0].sel_inputtype.disabled=true;
	}
	else
	{
		document.all.idval6.style.display="none";
		document.all.idval7.style.display="none";
		document.all.idval8.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="144")
	{
		document.all.idval9.style.display="table-cell";
		document.all.idval10.style.display="table-cell";
		document.forms[0].sel_type.disabled=true;
	}
	else
	{
		document.all.idval9.style.display="none";
		document.all.idval10.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="233"||document.forms[0].seldataheadtype.value=="234"||document.forms[0].seldataheadtype.value=="247")
	{
		document.all.idval02.style.display="table-cell";
		document.all.idval03.style.display="table-cell";
		document.forms[0].sel_gecltype.disabled=true;
	}
	else
	{
		document.all.idval02.style.display="none";
		document.all.idval03.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="257"||document.forms[0].seldataheadtype.value=="256" || document.forms[0].seldataheadtype.value=="278")
	{
		document.all.idvalsol.style.display="table-cell";
		document.all.idvalsol1.style.display="table-cell";
		document.all.idvalsol2.style.display="table-cell";
		document.all.idvalsol3.style.display="table-cell";
	}
	else
	{
		document.all.idvalsol.style.display="none";
		document.all.idvalsol1.style.display="none";
		document.all.idvalsol2.style.display="none";
		document.all.idvalsol3.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="234")
	{
		document.all.idval11.style.display="table-cell";
		document.all.idval12.style.display="table-cell";
		document.all.idval13.style.display="table-cell";
		document.all.idval14.style.display="table-cell";
		document.all.idval15.style.display="table-cell";
		document.forms[0].sel_eligibility.disabled=true;
		document.forms[0].sel_inputtype1.disabled=true;
		document.all.idval215.style.display="table-cell";
		document.all.idvalsec.style.display="table-cell";
		document.forms[0].sel_sector.disabled=true;
		
		
	}
	else
	{
		document.all.idval11.style.display="none";
		document.all.idval12.style.display="none";
		document.all.idval13.style.display="none";
		document.all.idval14.style.display="none";
		document.all.idval15.style.display="none";
		document.all.idval215.style.display="none";
		document.all.idvalsec.style.display="none";
		
	}

	if(document.forms[0].seldataheadtype.value=="240")
	{
		document.all.id_interstReason.style.display="table-row";
		document.forms[0].sel_module.disabled=true;
		document.forms[0].sel_reasonfor.disabled=true;
	}
	else
	{
		document.all.id_interstReason.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="245" || document.forms[0].seldataheadtype.value=="246")
	{
		document.all.id_Reasonmannualprocess.style.display="table-row";
		document.forms[0].sel_module.disabled=true;
	}
	else
	{
		document.all.id_Reasonmannualprocess.style.display="none";
	}
	 if (document.forms[0].seldataheadtype.value=="264"){
		document.all.id_restructure.style.display="table-row";
		document.forms[0].sel_type_borrower.disabled=true;
		document.forms[0].sel_borrow_module.disabled=true;	
	}
	else
	{
		document.all.id_restructure.style.display="none";
	}
	if (document.forms[0].seldataheadtype.value=="265"){
		document.all.id_restructure_loan.style.display="table-row";
		document.forms[0].sel_res_framework.disabled=true;
		document.forms[0].sel_framework_module.disabled=true;	
	}
	else
	{
		document.all.id_restructure_loan.style.display="none";
	}
	if(document.forms[0].seldataheadtype.value=="252")
	{
		document.forms[0].sel_bankscheme.disabled=true;
	}
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		} 
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
		if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=(!one);		  
		}
			
	}
	document.forms[0].selactive.disabled=one;
}

function doSave()
{	
	if(document.forms[0].seldataheadtype.value=="245" || document.forms[0].seldataheadtype.value=="246")
	{
		var str_ModuleType ="";
		
		str_ModuleType=$('#module').val();
		
		document.forms[0].hidsel_module.value=$('#module').val();
	}
	if(document.forms[0].seldataheadtype.options.selectedIndex=="")
	{
		ShowAlert(111,"the Data Heads");
		document.forms[0].seldataheadtype.focus();
		return false;
	}
	else if((document.forms[0].txt_datavalues.value)=="")
	{
		ShowAlert(121,"the Data Values");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
	else if(document.forms[0].seldataheadtype.value=="205" && (document.forms[0].txt_value.value==""||document.forms[0].txt_value.value=="0.00"))
	{
		ShowAlert(121,"Valuation Max Limit");
		document.forms[0].txt_value.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="218" || document.forms[0].seldataheadtype.value=="252")&& (document.forms[0].selSMS.value==""))
	{
		ShowAlert(111,"SMS need to be Trigger?");
		document.forms[0].selSMS.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="283" && document.forms[0].sel_Industry.value=="")
	{
		ShowAlert(111,"Nature of Activity");
		document.forms[0].sel_Industry.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="267" && document.forms[0].sel_CersaiReq.value=="")
	{
		ShowAlert(111,"Cersai required");
		document.forms[0].sel_CersaiReq.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="268") && document.forms[0].sel_bankschemeforclpu.value=="")
	{
		ShowAlert(111,"Bank Scheme");
		document.forms[0].sel_bankschemeforclpu.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="268" && document.forms[0].sel_clpuReq.value=="")
	{
		ShowAlert(111,"Proposal to CLPU");
		document.forms[0].sel_clpuReq.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230") && (document.forms[0].sel_inputtype.value==""))
	{
		ShowAlert(111,"Input value will be");
		document.forms[0].sel_inputtype.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230") && (document.forms[0].sel_inputtype.value!="E" && document.forms[0].txt_inputvalue.value==""))
	{
		ShowAlert(121,"Input value");
		document.forms[0].txt_inputvalue.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="144" && document.forms[0].sel_type.value=="")
	{
		ShowAlert(111,"Loan type");
		document.forms[0].sel_type.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="234" && document.forms[0].sel_eligibility.value=="0"|| document.forms[0].sel_eligibility.value=="1")
	{
		ShowAlert(111,"Eligibility based on");
		document.forms[0].sel_eligibility.focus();
		return false;
	}
	else if(document.forms[0].seldataheadtype.value=="234" && document.forms[0].sel_inputtype1.value=="")
	{
		ShowAlert(111,"Input type");
		document.forms[0].sel_inputtype1.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="245" || document.forms[0].seldataheadtype.value=="246") && document.forms[0].hidsel_module.value=="")
	{
		document.forms[0].sel_module.disabled=false;
		alert("Select Modules");
		return;
	}
	else if(document.forms[0].seldataheadtype.value=="234" && (document.forms[0].sel_inputtype1.value=="EM"||document.forms[0].sel_inputtype1.value=="DA") && document.forms[0].txt_inputvalue1.value=="")
	{
		ShowAlert(111,"Input type");
		document.forms[0].txt_inputvalue1.focus();
		return false;
	}
	else if((document.forms[0].seldataheadtype.value=="233"||document.forms[0].seldataheadtype.value=="234"||document.forms[0].seldataheadtype.value=="247") && document.forms[0].sel_gecltype.value=="")
	{
		ShowAlert(111,"Gecl Type");
		document.forms[0].sel_gecltype.focus();
		return false;
	}

	/*else if((document.forms[0].seldataheadtype.value=="234") && (document.forms[0].sel_gecltype.value=="GECL2")&&(document.forms[0].sel_sector.value==""))
	{
		ShowAlert(111,"Name of Sector");
		document.forms[0].sel_sector.focus();
		return false;

	}*/
	else if((document.forms[0].seldataheadtype.value=="234") && (document.forms[0].sel_gecltype.value=="GECL2")&&(document.forms[0].sel_inputtype1.value=="IMM")&&(document.forms[0].txt_inputvalue2.value==""||document.forms[0].txt_inputvalue1.value==""))
	{
				ShowAlert(111,"Input type");
				document.forms[0].txt_inputvalue2.focus();
				return false;
	}
	
	else
	{

		if(document.forms[0].seldataheadtype.value=="240")
		{
			var str_ModuleType ="";
			for(var i=0;i<document.forms[0].sel_module.options.length;i++)
			{
				if(document.forms[0].sel_module.options[i].selected)
				{				
					str_ModuleType=str_ModuleType+document.forms[0].sel_module.options[i].value+"@";
				}		
			}

			var str_reasonfor ="";
			for(var i=0;i<document.forms[0].sel_reasonfor.options.length;i++)
			{
				if(document.forms[0].sel_reasonfor.options[i].selected)
				{				
					str_reasonfor=str_reasonfor+document.forms[0].sel_reasonfor.options[i].value+"@";
				}		
			}
			document.forms[0].hidsel_module.value=str_ModuleType;
			document.forms[0].hidsel_reasonfor.value=str_reasonfor;
			if(document.forms[0].hidsel_module.value=="")
			{
				alert("Select Modules");
				return;
			}

			if(document.forms[0].hidsel_reasonfor.value=="")
			{
				alert("Select Reason For");
				return;
			}
		}
		if(document.forms[0].seldataheadtype.value=="264"){
			var selreason = "";
			for(var i=0;i<document.forms[0].sel_type_borrower.options.length;i++)
			{
				if(document.forms[0].sel_type_borrower.options[i].selected)
				{			
					selreason=selreason+document.forms[0].sel_type_borrower.options[i].value+"@";

				}		
			}

				var selmoduletype = "";
			
			for(var i=0;i<document.forms[0].sel_borrow_module.options.length;i++)
			{
				if(document.forms[0].sel_borrow_module.options[i].selected)
				{			
					selmoduletype=selmoduletype+document.forms[0].sel_borrow_module.options[i].value+"@";

				}		
			}
			document.forms[0].hidsel_module.value=selmoduletype;
			document.forms[0].hidsel_reasonfor.value=selreason;
			if(document.forms[0].hidsel_module.value=="")
			{
				alert("Select Modules");
				return;
			}

			if(document.forms[0].hidsel_reasonfor.value=="")
			{
				alert("Select Reason For");
				return;
			}
		}
		if(document.forms[0].seldataheadtype.value=="265"){
			var selreason = "";
			for(var i=0;i<document.forms[0].sel_res_framework.options.length;i++)
			{
				if(document.forms[0].sel_res_framework.options[i].selected)
				{			
					selreason=selreason+document.forms[0].sel_res_framework.options[i].value+"@";

				}		
			}

				var selmoduletype = "";
			
			for(var i=0;i<document.forms[0].sel_framework_module.options.length;i++)
			{
				if(document.forms[0].sel_framework_module.options[i].selected)
				{			
					selmoduletype=selmoduletype+document.forms[0].sel_framework_module.options[i].value+"@";

				}		
			}
			document.forms[0].hidsel_module.value=selmoduletype;
			document.forms[0].hidsel_reasonfor.value=selreason;
			if(document.forms[0].hidsel_module.value=="")
			{
				alert("Select Modules");
				return;
			}

			if(document.forms[0].hidsel_reasonfor.value=="")
			{
				alert("Select Reason For");
				return;
			}
		}
		
			var len = document.forms[0].seldataheadtype.length;	
			for(i=0;i<len;i++)
			{
				 if(document.forms[0].seldataheadtype.options[i].selected==true)
				 {
					 document.forms[0].seldataheadtype1.value = document.forms[0].seldataheadtype.options[i].text; 
					  break;
				 }
			}
			
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].hidRecordflag.value=varRecordFlag;
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/mastersearch.jsp";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].submit();
		}	
	}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Cancel";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/mastersearch.jsp";	
		document.forms[0].submit();
	}
}

function doNew() 
{
	if(document.forms[0].seldataheadtype.value=="0")
	{
		ShowAlert(111,"Data Heads");
		document.forms[0].seldataheadtype.focus();
		return ;
	}
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true);
   	disablefields(false);  
   	if(document.forms[0].seldataheadtype.value=="218"||document.forms[0].seldataheadtype.value=="252")
	{
		document.forms[0].selSMS.disabled=false;
	}
   	if(document.forms[0].seldataheadtype.value=="283")
	{
		document.forms[0].sel_Industry.disabled=false;
	}
 	if(document.forms[0].seldataheadtype.value=="211")
	{
		document.forms[0].sel_act.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="267")
	{
		document.forms[0].sel_CersaiReq.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="268")
	{
		document.forms[0].sel_bankschemeforclpu.disabled=false;
		document.forms[0].sel_clpuReq.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230")
	{
		document.forms[0].sel_inputtype.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="234")
	{
		document.forms[0].sel_eligibility.disabled=false;
		document.forms[0].sel_inputtype1.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="240"||document.forms[0].seldataheadtype.value=="264"||document.forms[0].seldataheadtype.value=="265")
	{
		document.forms[0].sel_module.disabled=false;
		document.forms[0].sel_reasonfor.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="245" || document.forms[0].seldataheadtype.value=="246")
	{
		document.forms[0].sel_module.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="233"||document.forms[0].seldataheadtype.value=="234"||document.forms[0].seldataheadtype.value=="247")
	{
		document.forms[0].sel_gecltype.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="234")
	{
		document.forms[0].sel_sector.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="252" || document.forms[0].seldataheadtype.value=="171")
	{
		document.forms[0].sel_bankscheme.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="264")
	{
		document.forms[0].sel_type_borrower.disabled=false;
		document.forms[0].sel_borrow_module.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="265")
	{
		document.forms[0].sel_res_framework.disabled=false;
		document.forms[0].sel_framework_module.disabled=false;
	}
}

function doEdit() 
{
	if(document.forms[0].txt_datavalues.value=="")
	{
		ShowAlert(111,"Data Values Sno from the list");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
    document.forms[0].hidAction.value="update";
    enableButtons(true, true, false, false, true);
	disablefields(false);
	if(document.forms[0].seldataheadtype.value=="218"||document.forms[0].seldataheadtype.value=="252")
	{
		document.forms[0].selSMS.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="283")
	{
		document.forms[0].sel_Industry.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="211")
	{
		document.forms[0].sel_act.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="267")
	{
		document.forms[0].sel_CersaiReq.disabled=false;
	}
	
	if(document.forms[0].seldataheadtype.value=="268" || document.forms[0].seldataheadtype.value=="171")
	{
		document.forms[0].sel_bankschemeforclpu.disabled=false;
		document.forms[0].sel_clpuReq.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="144")
	{
		document.forms[0].sel_type.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230"||document.forms[0].seldataheadtype.value=="255"||document.forms[0].seldataheadtype.value=="256")
	{
		document.forms[0].sel_inputtype.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="234")
	{
		document.forms[0].sel_eligibility.disabled=false;
		document.forms[0].sel_inputtype1.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="240")
	{
		document.forms[0].sel_module.disabled=false;
		document.forms[0].sel_reasonfor.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="245" || document.forms[0].seldataheadtype.value=="246")
	{
		document.forms[0].sel_module.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="264")
	{
		document.forms[0].sel_type_borrower.disabled=false;
		document.forms[0].sel_borrow_module.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="265")
	{
		document.forms[0].sel_res_framework.disabled=false;
		document.forms[0].sel_framework_module.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="233"||document.forms[0].seldataheadtype.value=="234"||document.forms[0].seldataheadtype.value=="247")
	{
		document.forms[0].sel_gecltype.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="234")
	{
		document.forms[0].sel_sector.disabled=false;
	}
	if(document.forms[0].seldataheadtype.value=="252" || document.forms[0].seldataheadtype.value=="171")
	{
		document.forms[0].sel_bankscheme.disabled=false;
	}
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function selectValues(val0,val1,val2)
{
	document.all.ifrm.src=appURL+"action/iframemastersearch.jsp?hidBeanGetMethod=getDataonselect&hidBeanId=staticdata&statdatahead="+val1+"&statsno="+val0+"&statdesc="+val2;
   	enableButtons(true, false, true, false, true);
}

function selvalues()
{		
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action=appURL+"action/mastersearch.jsp";
	document.forms[0].submit();
}
function enablefields()
{
	if((document.forms[0].seldataheadtype.value=="225"||document.forms[0].seldataheadtype.value=="226"||document.forms[0].seldataheadtype.value=="227"||document.forms[0].seldataheadtype.value=="228"||document.forms[0].seldataheadtype.value=="229"||document.forms[0].seldataheadtype.value=="230")&&(document.forms[0].sel_inputtype.value=="M"||document.forms[0].sel_inputtype.value=="D"||document.forms[0].sel_inputtype.value=="EM"||document.forms[0].sel_inputtype.value=="EMM"))
	{
		document.all.idval8.style.display="inline";
	}
	else
	{
		document.all.idval8.style.display="none";
		document.forms[0].txt_inputvalue.value="";
	}
	if((document.forms[0].seldataheadtype.value=="234")&&(document.forms[0].sel_inputtype1.value=="EM" || document.forms[0].sel_inputtype1.value=="DA"||document.forms[0].sel_inputtype1.value=="IMM"||document.forms[0].sel_inputtype1.value=="OCC"))
	{
		document.all.idval15.style.display="inline";
	}
	else
	{
		document.all.idval15.style.display="none";
		document.forms[0].txt_inputvalue1.value="";
	}

	
	if((document.forms[0].seldataheadtype.value=="234"))
	{
		if((document.forms[0].sel_gecltype.value=="GECL2"||document.forms[0].sel_gecltype.value=="GECL3"||document.forms[0].sel_gecltype.value=="GECL4")&&(document.forms[0].sel_inputtype1.value=="IMM")){
		   document.all.idval215.style.display="inline";
			 
		}
		else
		{
			document.all.idval215.style.display="none";
		}
		if(((document.forms[0].sel_gecltype.value=="GECL2"||document.forms[0].sel_gecltype.value=="GECL3"||document.forms[0].sel_gecltype.value=="GECL4")&&(document.forms[0].sel_inputtype1.value=="NS"))||(document.forms[0].sel_inputtype1.value=="NS")){
		document.all.idvalsec.style.display="inline";
		}else{
			document.all.idvalsec.style.display="none";
		}
	}
	
	if((document.forms[0].seldataheadtype.value=="257"||document.forms[0].seldataheadtype.value=="256" ||  document.forms[0].seldataheadtype.value=="278"))
	{
		 document.all.idvalsol.style.display="inline";
		 document.all.idvalsol1.style.display="inline";
	}else{
		 document.all.idvalsol.style.display="none";
		 document.all.idvalsol1.style.display="none";
	}
}
function callperType(varValue) {
	var varType = document.forms[0].sel_gecltype.options[document.forms[0].sel_gecltype.selectedIndex].value;
	document.all.iframegecl.src = appURL
			+ "action/iframegecl.jsp?hidBeanGetMethod=getgeclidentification&hidBeanId=staticdata&statheadcode=233&GeclType="+ varType+"&strValue="+varValue;
}

function callnameofsectorType(varValue) {
	var varType = document.forms[0].sel_gecltype.options[document.forms[0].sel_gecltype.selectedIndex].value;
	document.all.iframegec3.src = appURL
			+ "action/iframenameofsector.jsp?hidBeanGetMethod=getNameofsectorgeclident&hidBeanId=staticdata&statheadcode=247&GeclType="+ varType+"&strValue="+varValue;
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();enablefields();">
<form class="normal" name="appform" method="post" action="">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; Static Data Master</td></tr>
</table>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
	 <tr> 
      <td valign="top">       
              <table class="outertable" border="0" cellspacing="0" cellpadding="0" width="100%">
                <tr> 
                  <td valign="top"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                                  <tr> 
                                    <td width="8%" nowrap>Data Heads</td>
                                    <td width="13%"> 
                                      <select name="seldataheadtype" tabindex="2" onchange="selvalues()">
                                        <option value="0" selected>---------Select--------</option>
                                        <lapschoice:StaticDataHeadsTag/> 
                                      </select>
                                    </td>
                                    <td width="9%" nowrap>Data Value</td>
                                    <td width="70%"> 
                                      <input type="text" name="txt_datavalues" size="80" maxlength="400" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("stat_data_desc"))%>">
                                    </td>
                                  </tr>
								  <tr> 
                                    <td width="8%" nowrap>&nbsp;</td>
                                    <td width="13%">&nbsp; </td>
                                    <td width="9%" nowrap>Data Description</td>
                                    <td width="70%"> 
                                      <input type="text" name="txt_datavalues1" onKeyPress="notAllowSplChar()" size="80" maxlength="400" value="<%=Helper.correctNull((String)hshValues.get("stat_data_desc1"))%>">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="8%" nowrap id="idval1" style="display: none;">Valuation Limit Upto</td>
                                    <td width="13%" id="idval2" style="display: none;"><input type="text" name="txt_value" maxlength="15" onkeypress="allowNumber(this);" onblur="roundtxt(this);" style="text-align: right"> </td>
                                    <td width="9%" nowrap>Active</td>
                                    <td width="70%"> 
                                      <select name="selactive">
                                      	<option value="Y" selected>Yes</option>
                                      	<option value="N">No</option>
                                      </select>
                                    </td>
                                      <td width="8%" nowrap id="idval3" style="display: none;">SMS need to be Trigger?</td>
                                    <td width="13%" id="idval4" style="display: none;">
                                    <select name="selSMS">
                                      	<option value="" selected>&lt;--Select--&gt;</option>
                                      	<option value="Y">Yes</option>
                                      	<option value="N">No</option>
                                      </select> </td>
                                     
                                       
                                      <td width="9%" nowrap id="idval5" style="display: none;">Nature of industry</td>
                                       <td  id="idIndSector">
                                    <select name="sel_Industry">
                                      <option value="">--Select--</option>
                                       <lapschoice:StaticDataTag apptype="210"/>
                                      </select> </td> 
                                      
                                       <td width="9%" nowrap id="txt_act" style="display: none;" >Type of Activity</td>
                                       <td  id="id_act">
                                    <select name="sel_act">
                                      <option value="">--Select--</option>
                                       <lapschoice:StaticDataTag apptype="283"/>
                                      </select> </td> 
                                      
                                       <td width="9%" nowrap id="idval6" style="display: none;">input value will be </td>
                                       <td  id="idval7">
                                    <select name="sel_inputtype" onchange="enablefields();">
                                      <option value=""><--Select--></option>
                                      <option value="M">Multiple of & divided by</option>
                                      <option value="E">Equal to input value</option>
                                       <option value="EM">Equal to input value & Multiple of</option>
                                       <option value="EMM">Equal to input value & Multiple of 1 and Maximum of</option>
                                      <option value="D">Divided by & Minimum and Maximum of</option>
                                      </select> &nbsp;<span id="idval8"><input type="text" name="txt_inputvalue"></span> </td>
                                      
                                      <td width="9%" nowrap id="idval9" style="display: none;">Loan type</td>
                                       <td  id="idval10">
                                    <select name="sel_type">
                                       <option value='' selected="selected">----Select----</option>
									<option value="F">Funded</option>
									<option value="NF">Non Funded</option>
                                      </select> </td> 
                                       <td width="9%" nowrap id="idval11" style="display: none;">GECL Eligbility Based on</td>
                                       <td  id="idval12">
                                       
                                    <select name="sel_eligibility">
                                       <option value='0'>----Select----</option>
                                      </select> </td> 
                      
                                  </tr>
                                  <tr id="idbank1">
                                   <td nowrap="nowrap">Bank Scheme </td>
                                  <td>
								<select name="sel_bankscheme">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="1"/>
								</select>
							</td>
							</tr>
                                  <tr>
                                   <td width="9%" nowrap id="idval13" style="display: none;">input value will be </td>
                                       <td  id="idval14">
                                    <select name="sel_inputtype1" onchange="enablefields();">
                                      <option value=""><--Select--></option>
                                       <option value="T">Text Area</option>
                                       <option value="EM">input value & Maximum of</option>
                                        <option value="DA">Days & Maximum of</option>
                                      <option value="D">Drop down with Yes/No Value</option>
                                       <option value="IMM">input value of minimum and maximum value</option>
                                       <option value="NS">Name of the Sector</option>
                                       <option value="LC">LEI Code and due date of the same</option>
                                       <option value="GRN">GST Registration number</option>
                                       <option value="OCC">Overdue in credit card/savings account</option>
                                       <option value="AO">Amount of overdue in savings/current account/credit card account</option>
                                      </select> &nbsp;<span id="idval15"><input type="text" name="txt_inputvalue1"></span>&nbsp;&nbsp;<span id="idval215"><input type="text" name="txt_inputvalue2"></span> <span id="idvalsec"><select name="sel_sector">
                                       <option value='' selected="selected">----Select----</option>
									 <lapschoice:StaticDataHeadsTag/>
                                      </select></span> </td> 
                                  </tr>
                                  <tr id="idMCLRNote">
                                  <td colspan="8"><span class="mantatory">Note: Before Creating new Spread Type Please check Max MCLR ID in MCLR Spread Master Table.</span></td>
                                  </tr>
                                  
                                  <tr id="id_interstReason">
                                  	<td> Reason is for</td>
                                  	<td>
                                  		<select multiple="multiple" size="3" name="sel_reasonfor">  
                                  			<option value="D">Deviation/Penalty </option>
                                  			<option value="C">Concession </option>
                                  			<option value="A">As per Circular </option>
                                  		</select>
                                  	 </td>
                                  	 <td> Module</td>
                                		<td>
                                  			 <select multiple="multiple" size="3"  name="sel_module">
										     <option value="ret">Retail</option>
										     <option value="corp">Corporate</option>
										     <option value="agr">Agriculture</option>
										     </select>
									</td>
                                  </tr>
                                  <tr id="id_Reasonmannualprocess">
                                   <td> Module</td>
                                		<td>
                                  			 <select multiple="multiple" size="3" id="module" name="sel_module">
										     <option value="ret">Retail</option>
										     <option value="corp">Corporate</option>
										     <option value="agr">Agriculture</option>
										     </select>
									</td>
                                  	<td>&nbsp;</td>
                                  	<td>&nbsp;</td>
                                  </tr>
                                  <tr id="id_restructure">
                                  	<td nowrap="nowrap"> Type of Borrower</td>
                                  	<td>
                                  		<select multiple="multiple" name="sel_type_borrower">  
        								<lapschoice:StaticDataTag apptype="260"/>
        									</select></td>
                                  	 <td> Module</td>
                                		<td>
                                  			 <select multiple="multiple"   name="sel_borrow_module">
										     <option value="ret">Retail</option>
										     <option value="corp">Corporate</option>
										     <option value="agr">Agriculture</option>
										     </select>
									</td>
                                  </tr>
                                  <tr id="id_restructure_loan">
                                  	<td nowrap="nowrap">  Permitted activities under Resolution Frame work</td>
                                  	<td>
                                  		<select multiple="multiple"  name="sel_res_framework">
        								<lapschoice:StaticDataTag apptype="263"/>
        									</select></td>
                                  	 <td> Module</td>
                                		<td>
                                  			 <select multiple="multiple"  name="sel_framework_module">
										     <option value="ret">Retail</option>
										     <option value="corp">Corporate</option>
										     <option value="agr">Agriculture</option>
										     </select>
									</td>
                                  </tr>
                                  <tr>
                                   <td width="9%" nowrap id="idval02" style="display: none;">Select Gecl type</td>
                                       <td  id="idval03">
                                    <select name="sel_gecltype" onchange="callperType('');">
                                       <option value='' selected="selected" >----Select----</option>
									<option value="GECL1">GECL1</option>
									<option value="GECL2">GECL2</option>
									<option value="GECL3">GECL3</option>
									<option value="GECL4">GECL4</option>
									<option value="GECL1-Restructure">GECL1-Restructure</option>
									<option value="GECL -1 extension">GECL -1 extension</option>
									<option value="GECL -2 extension">GECL -2 extension</option>
									<option value="GECL -3 extension">GECL -3 extension</option>
									
                                      </select> </td> 
                                      
                                      </tr>
                                      
                                      <tr> 
                                    <td width="8%" nowrap id="idvalsol3">Range From </td>
                                    <td width="13%" nowrap="nowrap" id="idvalsol1"> 
                                         <input type="text" name="txt_inputsolvalue1" size="20" maxlength="16" value="<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_RANGE_FROM"))%>">

                                    </td>
                                    <td width="9%" nowrap id="idvalsol2">Range To</td>
                                    <td width="70%" id="idvalsol"> 
                                      <input type="text" name="txt_inputsolvalue2" size="20" maxlength="16" value="<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_RANGE_TO"))%>">
                                    </td>
                                  </tr>
                                      
                                      <!-- <tr id="idvalsec">
                                        <td width="9%" nowrap  >Name of the Sector</td>
                                       <td >
                                    <select name="sel_sector">
                                       <option value='' selected="selected">----Select----</option>
									<lapschoice:StaticDataTag apptype="247" />
                                      </select> </td> 
                                      </tr> -->
                                <tr><td width="8%" nowrap>&nbsp;</td><td width="13%">&nbsp;</td><td width="9%" nowrap>&nbsp;</td><td width="70%">&nbsp;</td></tr>
                                <tr>
                               	 <td width="9%" nowrap id="idvalcersai" style="display: none;">Cersai required</td>
                                       <td  id="idCersaiReq">
                                    <select name="sel_CersaiReq">
                                      <option value="">--Select--</option>
                                      	<option value="Y">Yes</option>
                                      	<option value="N">No</option>
                                      </select> </td> 
                                </tr>
                                
                                
                                      <tr> 
                                    <td width="8%" nowrap id="idvalclpu1">Bank Scheme </td>
                                    <td width="13%" nowrap="nowrap" id="idvalclpu2"> 
									<select name="sel_bankschemeforclpu">
									<option value="" selected="selected">--Select--</option>
									<lapschoice:MISDataTag apptype="1"/>
								</select>
                                    </td>
                                    <td width="9%" nowrap id="idvalclpu3">Proposal to CLPH</td>
                                    <td width="70%" id="idvalclpu4"> 
									<select name="sel_clpuReq">
                                      <option value="">--Select--</option>
                                      	<option value="Y">Yes</option>
                                      	<option value="N">No</option>
                                      </select> </td>
                                  </tr>
                                  
                                  
                                </table>
                              </td>
                            </tr>
                            </table>
                            </td>
                            </tr>
                            </table>
                            </td>
                            </tr>
                            </table>
                            </td>
                            </tr>
                            </table>
                            <br>
                                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                                  <br>                                
                                <table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr class="dataheader"> 
                                          <td width="3%" >&nbsp;</td>
                                          <td width="7%" ><b>S No.</b></td>
                                          <td width="10%" ><b>Data Value</b></td>
										  <td width="10%" ><b>Data Description</b></td>
										  <td width="10%" ><b>Active</b></td>
										  <%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >SMS Trigger</td><%} %>
										  <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >Eligibility Based on</td><%} %>
                                       	<%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >Nature of industry</td><%} %>
                                       	<%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >Type of Activity</td><%} %>
                                       	<%if(strStatId.equalsIgnoreCase("240") || strStatId.equalsIgnoreCase("245") || strStatId.equalsIgnoreCase("246")){ %> <td width="10%" >Reason For</td><%} %>
                                         <%if(strStatId.equalsIgnoreCase("264")){ %> <td width="10%" >Type of Borrower</td><%} %>
                                       	<%if(strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >Purpose of Loan</td><%} %>

                                       	<%if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >Module</td><%} %>
                                       	<%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >Gecl Type</td><%} %>
                                        <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >Input Type</td><%} %>
                                        <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >Bank Scheme</td><%} %>
                                       	 <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="10%" >Cersai required</td><%} %>
                                        
                                      <% 
						 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
										String inside="N";
										if(v!=null)
										{					
											int vecsize =v.size();
											for(int l=0;l<vecsize;l++)
											{	
												inside="Y";
												g1 = (ArrayList)v.get(l);
												
												%>
                                          <tr class="datagrid"> 
                                            <td width="3%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(2))%>', '<%=Helper.correctNull((String)g1.get(6))%>')">
                                            </td>
                                            <td width="7%" ><%=Helper.correctNull((String)g1.get(0))%></td>
                                            <td width="10%" ><%=Helper.correctNull((String)g1.get(1))%></td>
											<td width="10%" ><%=Helper.correctNull((String)g1.get(3))%></td>
											<td width="10%" > <%if(Helper.correctNull((String)g1.get(4)).equalsIgnoreCase("Y")){%>
											 Yes
											 <%}else{ %>
											 No
											 <%} %></td>
											 <%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >
											 <%if(Helper.correctNull((String)g1.get(5)).equalsIgnoreCase("Y")){%>
											 Yes
											 <%}else{ %>
											 No
											 <%} %>
											 &nbsp;
											 </td><%} %>
											  <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >
											 <%=Helper.correctNull((String)g1.get(5))%>
											 &nbsp;
											 </td><%} %>
											  <%if(strStatId.equalsIgnoreCase("283") || strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >
											 <%=Helper.correctNull((String)g1.get(5))%>
											 &nbsp;
											 </td><%}
											  
											  if(strStatId.equalsIgnoreCase("240")){
												  String strTemp1="";
												  if(!Helper.correctNull((String)g1.get(5)).equalsIgnoreCase(""))
												  {
													  String strTemp=Helper.correctNull((String)g1.get(5));
													  String strArr[]=strTemp.split("@");
													  for(int k=0;k<strArr.length;k++)
													  {
														  String StrDummy="";
														  if(strArr[k].equalsIgnoreCase("D"))
															  StrDummy="Deviation";
														  else if(strArr[k].equalsIgnoreCase("C"))
															  StrDummy="Concession";
														  else if(strArr[k].equalsIgnoreCase("A"))
															  StrDummy="As per Circular";
														  if(strTemp1.equalsIgnoreCase(""))
														  strTemp1=StrDummy;
														  else
															  strTemp1=strTemp1+","+StrDummy;
													  }
												  }%> <td width="10%" ><%=strTemp1 %>
											 &nbsp;
											 </td><%}
											  if(strStatId.equalsIgnoreCase("265")){
												  String strTemp1="";
												  if(!Helper.correctNull((String)g1.get(5)).equalsIgnoreCase(""))
												  {
													  String strTemp=Helper.correctNull((String)g1.get(5));
													  String strArr[]=strTemp.split("@");
													  for(int k=0;k<strArr.length;k++)
													  {
														  String StrDummy="";
														  if(strArr[k].equalsIgnoreCase("1"))
															  StrDummy="Education";
														  else if(strArr[k].equalsIgnoreCase("2"))
															  StrDummy="Auto Loans(perso nal Use)";
														  else if(strArr[k].equalsIgnoreCase("3"))
															  StrDummy="Salary Loans";
														  else if(strArr[k].equalsIgnoreCase("4"))
															  StrDummy="Business-c purPose";
														  else if(strArr[k].equalsIgnoreCase("5"))
															  StrDummy="Agri Allied";
														  else if(strArr[k].equalsIgnoreCase("6"))
															  StrDummy="Others";
														  else if(strArr[k].equalsIgnoreCase("7"))
															  StrDummy="Housing Loans";
														  if(strTemp1.equalsIgnoreCase(""))
														  strTemp1=StrDummy;
														  else
															  strTemp1=strTemp1+","+StrDummy;
													  }
												  }%> <td width="10%" ><%=strTemp1 %>
											 &nbsp;
											 </td><%}
											  if(strStatId.equalsIgnoreCase("264")){
												  String strTemp1="";
												  if(!Helper.correctNull((String)g1.get(5)).equalsIgnoreCase(""))
												  {
													  String strTemp=Helper.correctNull((String)g1.get(5));
													  String strArr[]=strTemp.split("@");
													  for(int k=0;k<strArr.length;k++)
													  {
														  String StrDummy="";
														  if(strArr[k].equalsIgnoreCase("1"))
															  StrDummy="Individuals";
														  else if(strArr[k].equalsIgnoreCase("2"))
															  StrDummy="Small Businesses Enterprises (Retail/Wholesale Trade other than MSMEs)";
														  else if(strArr[k].equalsIgnoreCase("3"))
															  StrDummy="MSME Enterprises";
														  if(strTemp1.equalsIgnoreCase(""))
														  strTemp1=StrDummy;
														  else
															  strTemp1=strTemp1+","+StrDummy;
													  }
												  }%> <td width="10%" ><%=strTemp1 %>
											 &nbsp;
											 </td><%}
											  if(strStatId.equalsIgnoreCase("245")||strStatId.equalsIgnoreCase("246")){
												  String strTemp1="";
												  if(!Helper.correctNull((String)g1.get(6)).equalsIgnoreCase(""))
												  {
													  String strTemp=Helper.correctNull((String)g1.get(6));
													  //out.println("strTemp==="+strTemp);
													  String strArr[]=strTemp.split(",");
													  for(int k=0;k<strArr.length;k++)
													  {
														  String StrDummy="";
														  if(strArr[k].equalsIgnoreCase("ret"))
															  StrDummy="Retail";
														  else if(strArr[k].equalsIgnoreCase("corp"))
															  StrDummy="Corporate";
														  else if(strArr[k].equalsIgnoreCase("agr"))
															  StrDummy="Agriculture";
														  if(strTemp1.equalsIgnoreCase(""))
														  strTemp1=StrDummy;
														  else
															  strTemp1=strTemp1+","+StrDummy;
													  }
												  }%>
												  <td width="10%" ><%=strTemp1 %>
													 &nbsp;
													 </td><%}
											  if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){
												  String strTemp1="";
												  if(!Helper.correctNull((String)g1.get(6)).equalsIgnoreCase(""))
												  {
													  String strTemp=Helper.correctNull((String)g1.get(6));
													  String strArr[]=strTemp.split("@");
													  for(int k=0;k<strArr.length;k++)
													  {
														  String StrDummy="";
														  if(strArr[k].equalsIgnoreCase("ret"))
															  StrDummy="Retail";
														  else if(strArr[k].equalsIgnoreCase("corp"))
															  StrDummy="Corporate";
														  else if(strArr[k].equalsIgnoreCase("agr"))
															  StrDummy="Agriculture";
														  if(strTemp1.equalsIgnoreCase(""))
														  strTemp1=StrDummy;
														  else
															  strTemp1=strTemp1+","+StrDummy;
													  }
												  }%> <td width="10%" ><%=strTemp1 %>
											 &nbsp;
											 </td><%}%>
											 <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> 
							           <td width="10%" ><%=Helper.correctNull((String)g1.get(8))%></td>
											 <%} %>
											  <%if(strStatId.equalsIgnoreCase("234")){ %> 
                                            <td  width="20%"><%if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("D")){%>Drop Down
											 <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("EM")){ %>input value & Maximum of <%=Helper.correctNull((String)g1.get(7)) %>
											 <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("T")){ %>Text Area
											 <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("DA")){ %>Days & Maximum of <%=Helper.correctNull((String)g1.get(7)) %>
											  <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("IMM")){ %>input value of minimum and maximum value <%=Helper.correctNull((String)g1.get(7))+"-"+Helper.correctNull((String)g1.get(9)) %>
											  <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("NS")){ %>Name of the Sector<%=Helper.correctNull((String)g1.get(7)) %>
											  <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("LC")){ %>LEI Code and due date of the same
											 <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("GRN")){ %>GST Registration number 
									         <%}else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("OCC")){ %>Overdue in credit card/savings account<%=Helper.correctNull((String)g1.get(7)) %>
											 <% }else if(Helper.correctNull((String)g1.get(6)).equalsIgnoreCase("AO")){ %>Amount of overdue in savings/current account/credit card account 
												 <%}else{ %>&nbsp; <%} %>
											 </td>											 <%} %>
											 <%if(strStatId.equalsIgnoreCase("267")){ %> 
											 <td width="10%" > <%if(Helper.correctNull((String)g1.get(14)).equalsIgnoreCase("Y")){%>
											 Yes
											 <%}else if(Helper.correctNull((String)g1.get(14)).equalsIgnoreCase("N")){ %>
											 No
											 <%}} %></td>
                                          </tr>
                                          <%}}%>
                                           <tr class="datagrid"> 
                                            <td width="3%">&nbsp; </td>
                                            <td width="7%">&nbsp; </td>
                                            <td width="10%">&nbsp; </td>
											<td width="10%">&nbsp; </td>
											<td width="10%">&nbsp; </td>
											 <%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
											 <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
											 <%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
											  <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
											   <%if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >&nbsp;</td><%} %>
											    <%if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >&nbsp;</td><%} %>
										      <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
											   <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
								                
								                  <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
								                  <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
											    
                                          </tr>
                                           <tr class="datagrid">  
                                          <td width="3%">&nbsp; </td>
                                            <td width="7%">&nbsp; </td>
                                            <td width="10%">&nbsp; </td>
											<td width="30%">&nbsp; </td>
											<td width="10%">&nbsp; </td>
											<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
											 <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
											 <%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
											  <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
											  <%if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >&nbsp;</td><%} %>
											    <%if(strStatId.equalsIgnoreCase("240")||strStatId.equalsIgnoreCase("264")||strStatId.equalsIgnoreCase("265")){ %> <td width="10%" >&nbsp;</td><%} %>
										     <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
											   <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>

											      <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
											      <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
											    
                                          </tr>
                                          <%                                      
                                          if(inside=="N")
                                          {%>
													 <tr class="datagrid"> 
														<td width="3%">&nbsp;</td>
														<td width="7%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
													 <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
													   <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
													</tr>
													 <tr class="datagrid"> 
														<td width="3%">&nbsp;</td>
														<td width="7%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
													     <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
											              <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
											                 <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
											                  <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
												</tr>
													 <tr class="datagrid"> 
														<td width="3%">&nbsp;</td>
														<td width="7%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
												       <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
												       <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
													     <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
													</tr>
													 <tr class="datagrid"> 
														<td width="3%">&nbsp;</td>
														<td width="7%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
														<%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
													   <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
													 <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
												     <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
													     <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
													</tr>
													 <tr class="datagrid"> 
														<td width="3%">&nbsp;</td>
														<td width="7%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<td width="10%">&nbsp;</td>
														<%if(strStatId.equalsIgnoreCase("218")||strStatId.equalsIgnoreCase("252")){ %> <td width="10%" >&nbsp;</td><%} %>
														 <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="10%" >&nbsp;</td><%} %>
														 <%if(strStatId.equalsIgnoreCase("283")){ %> <td width="10%" >&nbsp;</td><%} %>
												     <%if(strStatId.equalsIgnoreCase("211")){ %> <td width="10%" >&nbsp;</td><%} %>
													 <%if(strStatId.equalsIgnoreCase("233")||strStatId.equalsIgnoreCase("234")||strStatId.equalsIgnoreCase("247")){ %> <td width="10%" >&nbsp;</td><%} %>
													  <%if(strStatId.equalsIgnoreCase("234")){ %> <td width="20%" >&nbsp;</td><%} %>
													    <%if(strStatId.equalsIgnoreCase("252")){ %> <td width="20%" >&nbsp;</td><%} %>
													     <%if(strStatId.equalsIgnoreCase("267")){ %> <td width="20%" >&nbsp;</td><%} %>
													</tr><%}%>
                                        </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type ="hidden" name ="hidkeyid" value="set">
   <input type="hidden" name="seldataheadtype1">
  <input type="hidden" name="org_code" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="strOrgCode" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
  <input type="hidden" name="hidstate" value="2">
  <input type="hidden" name="hidstatenew" value="">
   <iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> 
   <input type="hidden" name="hidsel_module">
   <input type="hidden" name="hidsel_reasonfor">
   <iframe height="0" width="0" id="iframegecl"
	frameborder=0 style="border: 0"></iframe>
	<iframe height="0" width="0" id="iframegec3"
	frameborder=0 style="border: 0"></iframe>
<br> 
</form>
</body>
</html>
