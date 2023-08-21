<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strStatId = Helper.correctNull((String) hshValues
			.get("strStatId"));
	String strStatsno = Helper.correctNull((String) hshValues
			.get("stat_data_sno"));
	if (strStatsno == "") {
		strStatsno = "0";
	}
	ArrayList arrRow = new ArrayList();
	ArrayList arrRow1 = new ArrayList();
	ArrayList arrRow2=new ArrayList();

	ArrayList arrCol = new ArrayList();
	if (hshValues != null) {
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrRow1= (ArrayList) hshValues.get("arrRow1");
		arrRow2=(ArrayList) hshValues.get("arrRow2");
		
	}
%>
<html>
<head>
<title>MIS - Data Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT
	src="<%=ApplicationParams.getAppUrl()%>js/set/mis_classification_master.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var statno=<%=strStatsno%>;
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varDataHeads="<%=Helper.correctNull((String) hshValues
							.get("strSelDataHeads"))%>";
 
var varsel_type="<%=Helper.correctNull((String) hshValues.get("strClassifType"))%>";

function callonLoad()
{
	disablefields(true);
	enableButtons(false, true, true, true, false,true);
	document.forms[0].sel_classtype.value=varsel_type;
	showClassifBased();	
	showActivityCode();
	document.forms[0].sel_classtype.disabled=false;
	if(document.all.id_ClassifBased.style.display=="block")
	{
		for(i=0;i<document.forms[0].rad_classificationbased.length;i++)
		{
			document.forms[0].rad_classificationbased[i].disabled = false;
		}
	}
	displayFields();
	StandUpIndia();
	
	//document.forms[0].seldataheadtype.value = varDataHeads;
	//document.forms[0].txt_ActivityCode.disabled = true;
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
	}
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=val;		
		}else if(document.forms[0].elements[i].type=="select-multiple")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
}

function doSave()
{	
	var str_constitution ="";
	var str_farmer_cate = "";
	var str_govt_spnr = "";
	var str_bankschematic_code = "";
	var str_utlz_credit = "";
	var str_branch_area = "";
	var str_caste = "";
	var str_dispscreen = "";
	var str_gender= "";
	var str_mgmnt_gender = "";
	var str_secval = "";
	var str_sector = "";
	var str_staffscheme = "";
	var str_standUp = "";
    if(document.forms[0].sel_classtype.value == "00")
	{
	ShowAlert(111,"MIS Classification Type");
	document.forms[0].sel_classtype.focus();
	return false;
	}
	if(document.forms[0].sel_classtype.value=="02")
	{
		if(trim(document.forms[0].txt_ActivityCode.value)=="")
		{
			ShowAlert(111,"Activity code");
			return false;
		}
	}
	else if(!document.forms[0].sel_classtype.value=="08")
	{
		if(document.forms[0].rad_classificationbased[1].checked)
		{
		    if(trim(document.forms[0].txt_ActivityCode.value)=="")
			{
				ShowAlert(111,"Activity code");
				return false;
			}
		}
		else if(document.forms[0].rad_classificationbased[0].checked)
		{
			document.forms[0].txt_ActivityCode.value="000000";
			document.forms[0].hidSlNo.value="00";
		}
		else
		{
			ShowAlert(111,"Classification Type based on");
			document.forms[0].rad_classificationbased[0].focus();
			return false;
		}
	}
	else if(!document.forms[0].sel_classtype.value=="08")
	{
		document.forms[0].txt_ActivityCode.value="000000";
		document.forms[0].hidSlNo.value="00";
	}
	//Policy Date
	//Sub sector
	if(document.forms[0].sel_classtype.value!="09"){
		if(document.forms[0].txt_new_psdate.value=="")
		{
			ShowAlert(121,"Policy Date");
			document.forms[0].txt_new_psdate.focus();
			return false;
		}
	if(document.forms[0].sel_subsector.value=="0")
	{
		ShowAlert(111,"Sub sector");
		document.forms[0].sel_subsector.focus();
		return false;
	}
	}
	//for stand up india
	if(document.forms[0].sel_classtype.value=="09"){
		if(document.forms[0].txt_dte_from.value=="")
		{
			ShowAlert(121," Exposure Range from");
			document.forms[0].txt_dte_from.focus();
			return false;
		}
		if(document.forms[0].txt_dte_to.value=="")
		{
			ShowAlert(121," Exposure Range To");
			document.forms[0].txt_dte_to.focus();
			return false;
		}
		if(document.forms[0].txt_dte_effect.value=="")
		{
			ShowAlert(111," Effect from");
			document.forms[0].txt_dte_effect.focus();
			return false;
		}
		if(document.forms[0].txt_loan_prd.value=="")
		{
			ShowAlert(121," Loan Period");
			document.forms[0].txt_loan_prd.focus();
			return false;
		}
		if(document.forms[0].txt_holiday_prd.value=="")
		{
			ShowAlert(121," Holiday Period");
			document.forms[0].txt_holiday_prd.focus();
			return false;
		}
		if(document.forms[0].sel_classfi.value=="00")
		{
			ShowAlert(111," Classification");
			document.forms[0].sel_classfi.focus();
			return false;
		}
		var count=0;
		for(var z=0;z<document.forms[0].sel_agr_srv_ctg.options.length;z++)
		{
			if(document.forms[0].sel_agr_srv_ctg.options[z].selected==true)
			{ count++;	}
		}
		if(count<=0)
		{
		ShowAlert(111," Agriculture Industry service category");
		document.forms[0].sel_agr_srv_ctg.focus();
		return false;
		}
			
	}
	//Mode of advance
	if(document.forms[0].sel_classtype.value == "01" && document.forms[0].sel_modeadv.value=="")
	{
		ShowAlert(111,"Mode of advance");
		document.forms[0].sel_modeadv.focus();
		return false;
	}
	if(document.forms[0].sel_classtype.value != "09")
	{
	
	/*if(((document.forms[0].sel_plantmech.value!="0.00"||document.forms[0].sel_plantmech.value!="")&&(document.forms[0].txt_plantmech_value.value!="0.00"
		||document.forms[0].txt_plantmech_value.value!=""))&& ((document.forms[0].sel_fxdval.value!="0.00"||document.forms[0].sel_fxdval.value!="")&&
				(document.forms[0].txt_fxdval.value!="0.00" ||document.forms[0].txt_fxdval.value!="")))
		{
			alert("Plant & Machiney and Equipment Value should not give it together");
			return;
		}
	}*/

	if(((eval(document.forms[0].sel_plantmech.value)>0)&&(eval(document.forms[0].txt_plantmech_value.value)>0))
		&& ((eval(document.forms[0].sel_fxdval.value)>0)&&(eval(document.forms[0].txt_fxdval.value)>0)))
		{
			alert("Plant & Machiney and Equipment Value should not give it together");
			return;
		}
	}
	//constitution
    for(var i=0;i<document.forms[0].sel_constitution1.options.length;i++)
	{
	  if(document.forms[0].sel_constitution1.options[i].selected)
		{
		  str_constitution=str_constitution+document.forms[0].sel_constitution1.options[i].value+"@";
		}
	}
	document.forms[0].hid_sel_constitution.value = str_constitution;
	//Former Category
	for(var j=0;j<document.forms[0].sel_farmer_cate1.options.length;j++)
	{
	  if(document.forms[0].sel_farmer_cate1.options[j].selected)
		{
		  str_farmer_cate=str_farmer_cate+document.forms[0].sel_farmer_cate1.options[j].value+"@";
		}
	}
	document.forms[0].hid_sel_farmer_cate.value = str_farmer_cate;

	//Govt Sponsers Scheme
	for(var k=0;k<document.forms[0].sel_govt_spnr1.options.length;k++)
	{
	  if(document.forms[0].sel_govt_spnr1.options[k].selected)
		{
		  str_govt_spnr=str_govt_spnr+document.forms[0].sel_govt_spnr1.options[k].value+"@";
		}
	}
	document.forms[0].hid_sel_govt_spnr.value = str_govt_spnr;

	//Bankschematic code
    for(var l=0;l<document.forms[0].sel_bankschematic_code1.options.length;l++)
	{
	  if(document.forms[0].sel_bankschematic_code1.options[l].selected)
		{
		  str_bankschematic_code=str_bankschematic_code+document.forms[0].sel_bankschematic_code1.options[l].value+"@";
		}
	}
	document.forms[0].hid_sel_bankschematic_code.value = str_bankschematic_code;
	//Utilization Credit
	for(var m=0;m<document.forms[0].sel_utlz_credit1.options.length;m++)
	{
	  if(document.forms[0].sel_utlz_credit1.options[m].selected)
		{
		  str_utlz_credit=str_utlz_credit+document.forms[0].sel_utlz_credit1.options[m].value+"@";
		}
	}
	document.forms[0].hid_sel_utlz_credit.value = str_utlz_credit;
	//Branch Area
	for(var z=0;z<document.forms[0].txt_brancharea_value.options.length;z++)
	{
	  if(document.forms[0].txt_brancharea_value.options[z].selected)
		{
		  str_branch_area=str_branch_area+document.forms[0].txt_brancharea_value.options[z].value+"@";
		}
	}
	document.forms[0].hid_sel_branch_area.value=str_branch_area;
	//Caste
	for(var n=0;n<document.forms[0].sel_caste1.options.length;n++)
	{
	  if(document.forms[0].sel_caste1.options[n].selected)
		{
		  str_caste=str_caste+document.forms[0].sel_caste1.options[n].value+"@";
		}
	}
	document.forms[0].hid_sel_caste.value = str_caste;
	//Display Screen
	for(var o=0;o<document.forms[0].sel_dispscreen1.options.length;o++)
	{
	  if(document.forms[0].sel_dispscreen1.options[o].selected)
		{
		  str_dispscreen=str_dispscreen+document.forms[0].sel_dispscreen1.options[o].value+"@";
		}
	}
	document.forms[0].hid_sel_dispscreen.value = str_dispscreen;

	//Gender
	for(var p=0;p<document.forms[0].sel_gender1.options.length;p++)
	{
	  if(document.forms[0].sel_gender1.options[p].selected)
		{
		  str_gender=str_gender+document.forms[0].sel_gender1.options[p].value+"@";
		}
	}
	document.forms[0].hid_sel_gender.value = str_gender;

	//Management Gender
	for(var q=0;q<document.forms[0].sel_mgmnt_gender1.options.length;q++)
	{
	  if(document.forms[0].sel_mgmnt_gender1.options[q].selected)
		{
		  str_mgmnt_gender=str_mgmnt_gender+document.forms[0].sel_mgmnt_gender1.options[q].value+"@";
		}
	}
	document.forms[0].hid_sel_mgmnt_gender.value = str_mgmnt_gender;

	//Security Value
	for(var r=0;r<document.forms[0].sel_secval1.options.length;r++)
	{
	  if(document.forms[0].sel_secval1.options[r].selected)
		{
		  str_secval=str_secval+document.forms[0].sel_secval1.options[r].value+"@";
		}
	}
	document.forms[0].hid_sel_secval.value = str_secval;


	//Sector
	for(var s=0;s<document.forms[0].sel_mulsector.options.length;s++)
	{
	  if(document.forms[0].sel_mulsector.options[s].selected)
		{
		  str_sector=str_sector+document.forms[0].sel_mulsector.options[s].value+"@";
		}
	}
	document.forms[0].hid_sector_value.value = str_sector;

	//StandUpIndia
	for(var z=0;z<document.forms[0].sel_agr_srv_ctg.options.length;z++)
	{
		if(document.forms[0].sel_agr_srv_ctg.options[z].selected)
		{
			str_standUp=str_standUp+document.forms[0].sel_agr_srv_ctg.options[z].value+"@";
		}
	}
	document.forms[0].hid_standUp.value=str_standUp;
	
	disablefields(false);
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanMethod.value="updateMisClassification";
	document.forms[0].hidBeanGetMethod.value="getMisClassification";
	document.forms[0].hidSourceUrl.value="/action/mis_classification_master.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();			
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
		document.forms[0].hidBeanGetMethod.value="getMisClassification";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].action=appURL+"action/mis_classification_master.jsp";	
		document.forms[0].submit();
	}
}

function checkMinMax(type)
{
	if(type == "F" && !document.forms[0].txt_fxdval.value=="")
	{
		if(eval(document.forms[0].sel_fxdval.value) >  eval(document.forms[0].txt_fxdval.value))
		{
			alert("Please enter a valid minimun and maximum value");
			document.forms[0].txt_fxdval.value="";
			document.forms[0].txt_fxdval.focus();
		}
	}
	if(type == "P" && !document.forms[0].txt_plantmech_value.value=="")
	{
		if(eval(document.forms[0].sel_plantmech.value) >  eval(document.forms[0].txt_plantmech_value.value))
		{
			alert("Please enter a valid minimun and maximum value");
			document.forms[0].txt_plantmech_value.value="";
			document.forms[0].txt_plantmech_value.focus();
		}
	}
	if(type == "S" && !document.forms[0].txt_borrower_totlimit_srvcat.value=="")
	{
		if(eval(document.forms[0].sel_borrower_totlimit_srvcat.value) >  eval(document.forms[0].txt_borrower_totlimit_srvcat.value))
		{
			alert("Please enter a valid minimun and maximum value");
			document.forms[0].txt_borrower_totlimit_srvcat.value="";		
			document.forms[0].txt_borrower_totlimit_srvcat.focus();		
		}
	}
	if(type == "sale" && !document.forms[0].txt_maxsalesturnover.value=="")
	{
		if(eval(document.forms[0].txt_maxsalesturnover.value) >  eval(document.forms[0].txt_maxsalesturnover.value))
		{
			alert("Please enter a valid minimun and maximum value");
			document.forms[0].txt_maxsalesturnover.value="";		
			document.forms[0].txt_maxsalesturnover.focus();		
		}
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].hidBeanMethod.value="updateMisClassification";
		document.forms[0].hidBeanGetMethod.value="getMisClassification";
		document.forms[0].hidSourceUrl.value="/action/mis_classification_master.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true,true);
   	disablefields(false);   	
}

function doEdit() 
{
    document.forms[0].hidAction.value="update";
    enableButtons(true, true, false, false, true,true);
	disablefields(false);
	document.forms[0].sel_classtype.disabled=true;
	for(i=0;i<document.forms[0].rad_classificationbased.length;i++)
	{
		document.forms[0].rad_classificationbased[i].disabled = true;
	}
	document.forms[0].sel_classtype.disabled=true;

	if(document.forms[0].rad_classificationbased[0].checked)
		document.forms[0].hid_rad_classificationbased.value="G";
	else
		document.forms[0].hid_rad_classificationbased.value="A";
	
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	//document.forms[0].cmddelete.disabled=bool6;
}

function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,
		val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,
		val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,
		val30,val31,val32,val33,val34,val35,val36,val37,val38,val39,
		val40,val41,val42,val43,val44,val45,val46,val47,val48,val49,
		val50,val51,val52,val53,val54,val55,val56,val57,val58,val59,
		val60,val61,val62,val63,val64,val65,val66,val67,val68,val69,
		val70,val71,val72,val73,val74,val75,val76,val77,val78,val79,val80,val81,
		val82,val83,val84,val85,val86,val87,val88,val89,val90,val91,val92,val93,val94,val95,val96,val97,val98,val99,val100,val101,val102,val103,val104,val105)
{
	
	if(document.forms[0].cmdsave.disabled == false)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].sel_classtype.value=val0;
	displayFields();
	showClassifBased();
	StandUpIndia();
	if(!(val0=="09")){
	if(!(val0=="02"))
	{
		if(val60=="A")
		{
			document.forms[0].txt_ActivityCode.value=val58;
		}
	}
	else
	{
		document.forms[0].txt_ActivityCode.value=val58;
	}
	}
	else{document.forms[0].txt_ActivityCode.style.display="none";}
	if(!(val0=="02"))
	{
		if(val60=="G")
		{
			document.forms[0].rad_classificationbased[0].checked=true;
		}
		else if(val60=="A")
		{
			document.forms[0].rad_classificationbased[1].checked=true;
		}
	}
	showActivityCode();
	document.forms[0].hid_actual_sno.value=val1;
	document.forms[0].hid_run_sno.value=val2;
	document.forms[0].sel_loanamt.value=val3;
	document.forms[0].txt_loanamt_value.value=val4;
	document.forms[0].sel_loantenor.value=val5;
	document.forms[0].txt_loantenor_value.value=val6;
	document.forms[0].sel_plantmech.value=val7;
	document.forms[0].txt_plantmech_value.value=val8;
	document.forms[0].sel_constitution.value=val9;
	//constitution Multiple Select box.
	var varconstitution=val10;
	var strconstitution=varconstitution.split("@");
	for(var s=0;s<strconstitution.length-1;s++)
	{
		var constitution=strconstitution[s];
		for(var i=0;i<document.forms[0].sel_constitution1.options.length;i++)
		{
			if(document.forms[0].sel_constitution1.options[i].value==constitution)
		  	{	
				 document.forms[0].sel_constitution1.options[i].selected=true;
			}
		}
	}
	document.forms[0].sel_fxdval.value=val11;
	document.forms[0].txt_fxdval.value=val12;
	document.forms[0].sel_hlval.value=val13;
	document.forms[0].txt_hlval.value=val14;
	document.forms[0].sel_brancharea.value=val15;
	//document.forms[0].txt_brancharea_value.value=val16;
	document.forms[0].sel_farmer_cate.value=val17;
	//Farmer Category Multiple Select box.
	var varfarmer_cate=val18;
	var strfarmer_cate=varfarmer_cate.split("@");
	for(var s=0;s<strfarmer_cate.length-1;s++)
	{
		var formercate=strfarmer_cate[s];
		for(var j=0;j<document.forms[0].sel_farmer_cate1.options.length;j++)
		{
			if(document.forms[0].sel_farmer_cate1.options[j].value==formercate)
		  	{	
				 document.forms[0].sel_farmer_cate1.options[j].selected=true;
			}
		}
	}
	document.forms[0].sel_sanction_val.value=val19;
	document.forms[0].txt_sanctiondate.value=val20;
	document.forms[0].sel_govt_spnr.value=val21;
	//Govt.Sponser Scheme Multiple Select box.
	var sel_govt_spnr=val22;
	var varsel_govt_spnr=sel_govt_spnr.split("@");
	for(var s=0;s<varsel_govt_spnr.length-1;s++)
	{
		var govt_spnr=varsel_govt_spnr[s];
		for(var k=0;k<document.forms[0].sel_govt_spnr1.options.length;k++)
		{
			if(document.forms[0].sel_govt_spnr1.options[k].value==govt_spnr)
		  	{	
				 document.forms[0].sel_govt_spnr1.options[k].selected=true;
			}
		}
	}
	document.forms[0].sel_shg_val.value=val23;
	document.forms[0].txt_shg_val.value=val24;
	document.forms[0].sel_bankschematic_code.value=val25;
	// Bank Schematic Code Multiple Select box.
	var bankschematic_code=val26;
	var bankschematic=bankschematic_code.split("@");
	for(var s=0;s<bankschematic.length-1;s++)
	{
		var sel_bankschematic=bankschematic[s];
		for(var l=0;l<document.forms[0].sel_bankschematic_code1.options.length;l++)
		{
			if(document.forms[0].sel_bankschematic_code1.options[l].value==sel_bankschematic)
		  	{	
				 document.forms[0].sel_bankschematic_code1.options[l].selected=true;
			}
		}
	}
	document.forms[0].sel_utlz_credit.value=val27;
	// Utilization Credit Multiple Select box.
	var utlz_credit=val28;
	var utlzcredit=utlz_credit.split("@");
	for(var s=0;s<utlzcredit.length-1;s++)
	{
		var sel_utlzcredit=utlzcredit[s];
		for(var m=0;m<document.forms[0].sel_utlz_credit1.options.length;m++)
		{
			if(document.forms[0].sel_utlz_credit1.options[m].value==sel_utlzcredit)
		  	{	
				 document.forms[0].sel_utlz_credit1.options[m].selected=true;
			}
		}
	}
	var branch_area=val16;
	var brancharea=branch_area.split("@");
	for(var s=0;s<brancharea.length-1;s++)
	{
		var sel_brancharea=brancharea[s];
		for(var m=0;m<document.forms[0].txt_brancharea_value.options.length;m++)
		{
			if(document.forms[0].txt_brancharea_value.options[m].value==sel_brancharea)
		  	{	
				 document.forms[0].txt_brancharea_value.options[m].selected=true;
			}
		}
	}
	document.forms[0].sel_familyincome.value=val29;
	document.forms[0].txt_familyincome.value=val30;
	document.forms[0].sel_borrower_totlimit.value=val31;
	document.forms[0].txt_borrower_totlimit.value=val32;
	document.forms[0].sel_borrower_totlimit_srvcat.value=val33;
	document.forms[0].txt_borrower_totlimit_srvcat.value=val34;
	document.forms[0].sel_borrower_agrtotlimit.value=val35;
	document.forms[0].txt_borrower_agrtotlimit.value=val36;
	//document.forms[0].sel_psdateval.value=val37;
	document.forms[0].txt_new_psdate.value=val38;
	document.forms[0].sel_caste.value=val39;
	// Caste Multiple Select box.
	var caste=val40;
	var strcaste=caste.split("@");
	for(var s=0;s<strcaste.length-1;s++)
	{
		var sel_caste=strcaste[s];
		for(var n=0;n<document.forms[0].sel_caste1.options.length;n++)
		{
			if(document.forms[0].sel_caste1.options[n].value==sel_caste)
		  	{	
				 document.forms[0].sel_caste1.options[n].selected=true;
			}
		}
	}
	document.forms[0].sel_irrigate.value=val41;
	document.forms[0].txt_irrigate_val.value=val42;
	document.forms[0].sel_dispscreen.value=val43;
	// Display Screen Multiple Select box.
	var dispscreen=val44;
	var strdispscreen=dispscreen.split("@");
	for(var s=0;s<strdispscreen.length-1;s++)
	{
		var sel_strdispscreen=strdispscreen[s];
		for(var o=0;o<document.forms[0].sel_dispscreen1.options.length;o++)
		{
			if(document.forms[0].sel_dispscreen1.options[o].value==sel_strdispscreen)
		  	{	
				 document.forms[0].sel_dispscreen1.options[o].selected=true;
			}
		}
	}
	document.forms[0].sel_gender.value=val45;
	// Gender Multiple Select box.
	var gender=val46;
	var strgender=gender.split("@");
	for(var s=0;s<strgender.length-1;s++)
	{
		var sel_strgender=strgender[s];
		for(var p=0;p<document.forms[0].sel_gender1.options.length;p++)
		{
			if(document.forms[0].sel_gender1.options[p].value==sel_strgender)
		  	{	
				 document.forms[0].sel_gender1.options[p].selected=true;
			}
		}
	}
	document.forms[0].sel_mgmnt_gender.value=val47;
	// Management Gender Multiple Select box.
	var mgmntgender=val48;
	var str_mgmntgender=mgmntgender.split("@");
	for(var s=0;s<str_mgmntgender.length-1;s++)
	{
		var sel_mgmntgender=str_mgmntgender[s];
		for(var q=0;q<document.forms[0].sel_mgmnt_gender1.options.length;q++)
		{
			if(document.forms[0].sel_mgmnt_gender1.options[q].value==sel_mgmntgender)
		  	{	
				 document.forms[0].sel_mgmnt_gender1.options[q].selected=true;
			}
		}
	}
	document.forms[0].sel_sectype.value=val49;
	document.forms[0].sel_sectype1.value=val50;
	document.forms[0].sel_secval.value=val51;
	// Security Value Multiple Select box.
	var secval=val52;
	var strsecval=secval.split("@");
	for(var s=0;s<strsecval.length-1;s++)
	{
		var sel_strsecval=strsecval[s];
		for(var r=0;r<document.forms[0].sel_secval1.options.length;r++)
		{
			if(document.forms[0].sel_secval1.options[r].value==sel_strsecval)
		  	{	
				 document.forms[0].sel_secval1.options[r].selected=true;
			}
		}
	}
	document.forms[0].sel_sharebrk.value=val53;
	document.forms[0].txt_sharebrkval.value=val54;
	document.forms[0].hid_activity_sno.value=val56;
	//document.forms[0].sel_priority.value=val57;
	document.forms[0].sel_subsector.value=val55;
	showSubSectorValuesSel(val55);
	document.forms[0].sel_Visibility.value=val59;
	
	document.forms[0].sel_modeadv.value=val61;
    enableButtons(true, false, true, false, true,false);
    document.forms[0].sel_classtype.disabled=true;
	for(i=0;i<document.forms[0].rad_classificationbased.length;i++)
	{
		document.forms[0].rad_classificationbased[i].disabled = true;
	}
	document.forms[0].sel_classtype.disabled=true;
	document.forms[0].sel_sector.value = val62;
	var varsector=val63;
	var strsector=varsector.split("@");
	for(var t=0;t<strsector.length-1;t++)
	{
		var sector1=strsector[t];
		for(var k=0;k<document.forms[0].sel_mulsector.options.length;k++)
		{
			if(document.forms[0].sel_mulsector.options[k].value==sector1)
		  	{	
				 document.forms[0].sel_mulsector.options[k].selected=true;
			}
		}
	}
	

	document.forms[0].sel_staffscheme.value = val64;
	document.forms[0].sel_staffschemevalue.value = val65;
	document.forms[0].sel_cretype.value = val66;
	document.forms[0].txt_cre_value.value = val67;
	document.forms[0].sel_social_Infra.value = val68;
	document.forms[0].txt_social_Infra.value = val69;
	document.forms[0].sel_agri_anci.value = val70;
	document.forms[0].txt_agri_anci.value = val71;
	document.forms[0].sel_renew_energy.value = val72;
	document.forms[0].txt_renew_energy.value = val73;
	document.forms[0].sel_renew_energy_indv.value = val74;
	document.forms[0].txt_renew_energy_indv.value = val75;
	document.forms[0].sel_physically_challenged.value = val76;
	document.forms[0].sel_physically_challenged_val.value = val77;
	document.forms[0].sel_agri_infra.value = val78;
	document.forms[0].txt_agri_infra.value = val79;
	document.forms[0].sel_cons_cost.value = val80;
	document.forms[0].txt_cons_cost.value = val81;


	document.forms[0].txt_dte_from.value = val82;
	document.forms[0].txt_dte_to.value = val83;
	document.forms[0].txt_dte_effect.value = val84;
	document.forms[0].txt_loan_prd.value = val85;
	document.forms[0].txt_holiday_prd.value = val86;


	var standup=val87;	
	var str_StandUpIndia=standup.split("@");
	for(var s=0;s<str_StandUpIndia.length-1;s++)
	{
		var str_StandUp_India=str_StandUpIndia[s];
		for(var z=0;z<document.forms[0].sel_agr_srv_ctg.options.length;z++)
		{
			if(document.forms[0].sel_agr_srv_ctg.options[z].value==str_StandUp_India)
		  	{	
				 document.forms[0].sel_agr_srv_ctg.options[z].selected=true;
					}
		}
	}
	document.forms[0].sel_classfi.value = val88;
	document.forms[0].txt_fromsalesturnover.value = val89;
	document.forms[0].txt_tosalesturnover.value = val90;
	document.forms[0].sel_minority.value = val91;
	document.forms[0].sel_minority_val.value = val92;
	document.forms[0].sel_nonindminority.value = val93;
	document.forms[0].sel_nonindminority_val.value = val94;

	document.forms[0].sel_start_up_minority_val.value = val95;
	document.forms[0].txt_carpet.value = val96;
	document.forms[0].txt_carpet_value.value = val97;
	document.forms[0].txt_floorarea.value = val98;
	document.forms[0].txt_floorarea_value.value = val99;
	document.forms[0].txt_maxarea_indhouse.value = val100;
	document.forms[0].txt_max_shg_proploan.value = val101;
	document.forms[0].txt_max_shg_proploan_value.value = val102;
	document.forms[0].sel_alliedactivity.value = val103;
	document.forms[0].txt_dwelling_code.value = val104;
	document.forms[0].txt_dwelling_value.value = val105;
	
}

function selvalues()
{	
	document.forms[0].hidBeanId.value="mis";
	document.forms[0].hidBeanGetMethod.value="getMISstaticdata";
	document.forms[0].action=appURL+"action/mis_datamaster.jsp?DataHeads="+document.forms[0].seldataheadtype.value;
	document.forms[0].submit();
}
function callMISActvityHelp()
{
	var varAction=document.forms[0].hidAction.value;
	if(varAction!="update")
	{
		if(document.forms[0].sel_classtype.value=="01"||document.forms[0].sel_classtype.value=="02")
		{
			callMISActHelp(varAction);
		}
		else
		{
			if(document.forms[0].rad_classificationbased[1].checked)
			{
				if(document.forms[0].sel_classtype.value=="00")
				{
					ShowAlert(111,"MIS Classification Type first");
					document.forms[0].sel_classtype.focus();
					return;
				}
				else
				{
					callMISActHelp(varAction);
				}
			}
		}
	}
}
function callMISActHelp(varAction)
{
	var varQryString = appURL+"action/mis_classification_activity.jsp?hidActionType="+varAction;
	var title = "MIS_ActivityCode";
	var prop = "scrollbars=no,width=650,height=400";
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
}
function callCalender1()
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,'txt_sanctiondate');
	}
}
function callCalender2()
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,'txt_new_psdate');
	}
}
function showCal(path,fname)
{
	var url = path+"action/Calendar.jsp?fname="+fname;
	var title = "Calendar";
	var prop = "scrollbars=no,width=260,height=240";	
	var xpos = (screen.width - 260) / 2;
	var ypos = (screen.height - 250) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop,"pop");
}
function showSubSectorValuesSel(subsecval)
{
	var varClassType=document.forms[0].sel_classtype.value;
	var varSubSectorVal=subsecval;
	document.all.ifrm.src=appURL+"action/iframe_mis_subsector.jsp?hidBeanGetMethod=getSubsector&hidBeanId=mis&strClassType="+varClassType+"&strSubSectorVal="+varSubSectorVal;
}
function showSubSectorValues()
{
	var varClassType=document.forms[0].sel_classtype.value;
	document.all.ifrm.src=appURL+"action/iframe_mis_subsector.jsp?hidBeanGetMethod=getSubsector&hidBeanId=mis&strClassType="+varClassType;
}
function showActivityCode()
{
	if(!(document.forms[0].sel_classtype.value=="02"))
	{
		if(document.forms[0].rad_classificationbased[1].checked)
		{
			document.all.id_ActOrGen.style.display="table-row";
		}
		else
		{
			document.all.id_ActOrGen.style.display="none";
			
		}
	}
	else
	{
		document.all.id_ActOrGen.style.display="table-row";
	}
	if(document.forms[0].sel_classtype.value=="08")
	{
		document.all.id_ActOrGen.style.display="none";
	}
	if(document.forms[0].sel_classtype.value=="01"||document.forms[0].sel_classtype.value=="02")

	{
		document.all.id_modeadv.style.display="table-row";
	}
	else
	{
		document.all.id_modeadv.style.display="none";
	}
	

}
function showClassifBased()
{
	if(!(document.forms[0].sel_classtype.value=="02"||document.forms[0].sel_classtype.value=="00" || document.forms[0].sel_classtype.value=="08"|| document.forms[0].sel_classtype.value=="09"||document.forms[0].sel_classtype.value=="" ))
	{
		document.all.id_ClassifBased.style.display="table-row";
	}
	else
	{
		document.all.id_ClassifBased.style.display="none";
	}
}
function callMISActivity()
{
	document.forms[0].hidSlNo.value="0";
	document.forms[0].txt_ActivityCode.value="000000";
	if(document.forms[0].hidAction.value!="insert")
	{
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="getMisClassification";
		document.forms[0].hidBeanId.value="mis";
		document.forms[0].action=appURL+"action/mis_classification_master.jsp";	
		document.forms[0].submit();
	}
}
function callMISActivity_GSS()
{
	if(document.forms[0].sel_classtype.value=="08" || document.forms[0].sel_classtype.value=="09")
	{
		if(document.forms[0].hidAction.value!="insert")
		{
			document.forms[0].method="post";
			document.forms[0].sel_classtype[document.forms[0].sel_classtype.selectedIndex].value
			document.forms[0].hidBeanGetMethod.value="getMisClassification";
			document.forms[0].hidBeanId.value="mis";
			document.forms[0].action=appURL+"action/mis_classification_master.jsp";	
			document.forms[0].submit();
		}
	}
}

function StandUpIndia()
{
	if(document.forms[0].sel_classtype.value=="09")
	{	
		document.all.stand_up.style.display="none";
		document.all.stand_up1.style.display="none";
		document.all.id_stnd.style.display="table-row";
		document.all.id_stnd1.style.display="table-row";
		document.all.id_stnd2.style.display="table-row";
		document.all.id_stnd3.style.display="table-row";
	
	}
	else
	{
		
		document.all.id_stnd.style.display="none";
		document.all.id_stnd1.style.display="none";
		document.all.id_stnd2.style.display="none";
		document.all.id_stnd3.style.display="none";	
	}
}

function callCalender3()
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,'txt_dte_from');
	}
}
function callCalender4()
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,'txt_dte_to');
	}
}
function callCalender5()
{
if(document.forms[0].cmdsave.disabled==false)
	{
	showCal(appURL,'txt_dte_effect');
	}
}

function comparedate(date1,date2)
{	
	var pgdt=changeDateformat(date1);
	var maxdt=changeDateformat(date2);
	if(pgdt.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Exposure Range TO date cannot be less then Exposure FROM date ");
			document.forms[0].txt_dte_to.value="";
			document.forms[0].txt_dte_to.focus();								
		}			
	}
}
function saleschk(){
	if(document.forms[0].sel_plantmech.value!="0.00"||document.forms[0].sel_plantmech.value!=""&&document.forms[0].txt_plantmech_value.value!="0.00"||document.forms[0].txt_plantmech_value.value!=""){
		//document.forms[0].sel_fxdval.readOnly=true;
		//document.forms[0].txt_fxdval.readOnly=true;
		}
	if(document.forms[0].sel_fxdval.value!="0.00"||document.forms[0].sel_fxdval.value!=""&&document.forms[0].txt_fxdval.value!="0.00"||document.forms[0].txt_fxdval.value!=""){
		//document.forms[0].sel_plantmech.readOnly=true;
		//document.forms[0].txt_plantmech_value.readOnly=true;
		}
}
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form class="normal" name="appform" method="post" action="">
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; MIS Classification
		Master</td>
	</tr>
</table>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5"
	cellspacing="0" align="center">
	<tr>
		<td valign="top">
		<table class="outertable" border="0" cellspacing="0" cellpadding="0"
			width="100%" align="center">
			<tr>
				<td valign="top">
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="1">
					<tr>
						<td width="69%" valign="top">
						<table class="outertable" width="100%" border="0" cellspacing="0"
							cellpadding="3">
							<tr>
								<td>
								<table class="outertable" width="100%" border="0"
									cellspacing="0" cellpadding="5">
									<tr>
										<td width="16%" nowrap>MIS Classification Type</td>
										<td colspan="5"><select name="sel_classtype" tabindex="2"
											onchange="showSubSectorValues();showClassifBased();showActivityCode();displayFields();callMISActivity_GSS();StandUpIndia();">
											<option value="00" selected>&lt;----Select----&gt;</option>
											<option value="01">Priority Sector</option>
											<option value="02">Non Priority Sector</option>
											<option value="03">Agriculture / Industry / Service	Category Type</option>
											<option value="04">Sensitive Sector</option>
											<option value="05">Weaker Section</option>
											<option value="06">Twenty Point Programmee</option>
											<option value="07">Infrastructure Credit Type</option>
											<option value="08">Government announced scheme</option>
											<option value="09">Stand up india</option>
										</select></td>
									</tr>
									<tr id="id_ClassifBased">
										<td nowrap="nowrap">Classification Type based on<b><span
											class="mantatory">&nbsp;*</span></b></td>
										<td><input type="radio" name="rad_classificationbased"
											value="G" onClick="showActivityCode();callMISActivity();"
											style="border-style: none">&nbsp;General</td>
										<td><input type="radio" name="rad_classificationbased"
											value="A" onClick="showActivityCode();"
											style="border-style: none">&nbsp;Activity</td>
										<td colspan="3">&nbsp;</td>
									</tr>
									<tr id="id_ActOrGen">
										<td width="16%">Activity code</td>
										<td colspan="5"><input type="text"
											name="txt_ActivityCode" size="55" maxlength="50"
											onKeyPress="allowInteger()" readOnly="readonly"
											style="width: 30%"> &nbsp; <b> <span
											onClick="callMISActvityHelp();" style="cursor: hand">
										<img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"> </span> </b></td>
									</tr>
									<tr>
										<td width="16%" nowrap id="lnamt1"><span id="microunit">Loan Amount</span></td>

										<td width="9%" id="lnamt2"><select name="sel_loanamt"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="lnamt3"><input
											type="text" name="txt_loanamt_value" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>

										<td width="13%" align="left" nowrap id="lntnr1">Loan
										Tenor</td>

										<td width="9%" id="lntnr2"><select name="sel_loantenor"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td width="30%" id="lntnr3"><input type="text"
											name="txt_loantenor_value" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											value=""></td>
									</tr>
									<tr>
										<td width="16%" nowrap id="plant1">Plant and Machinery</td>

<!--										<td width="9%" id="plant2"><select name="sel_plantmech"-->
<!--											tabindex="2">-->
<!--											<option value="0" selected>&lt;--Select--&gt;</option>-->
<!--											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />-->
<!--										</select></td>-->

										<td align="left" width="9%" id="plant2"><input
											type="text" name="sel_plantmech" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this);checkMinMax('P');saleschk();"
											value=""></td>
											
										<td align="left" width="23%" id="plant3"><input
											type="text" name="txt_plantmech_value" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this);checkMinMax('P');saleschk();"
											value=""></td>
										<td width="16%" nowrap id="fi1">Family Income</td>

										<td width="9%" id="fi2"><select name="sel_familyincome"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="fi3"><input type="text"
											name="txt_familyincome" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>

									</tr>

									<tr>
										<td width="16%" nowrap id="fdval1">Fixed Value</td>

<!--										<td width="9%" id="fdval2"><select name="sel_fxdval"-->
<!--											tabindex="2">-->
<!--											<option value="0" selected>&lt;--Select--&gt;</option>-->
<!--											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />-->
<!--										</select></td>-->

										<td align="left" width="9%" id="fdval2"><input
											type="text" name="sel_fxdval" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this);checkMinMax('F');saleschk();" value=""></td>
											
										<td align="left" width="23%" id="fdval3"><input
											type="text" name="txt_fxdval" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this);checkMinMax('F');saleschk();" value=""></td>

										<td width="13%" align="left" nowrap id="hlval1">HL Value</td>

										<td width="9%" id="hlval2"><select name="sel_hlval"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td width="30%" id="hlval3"><input type="text"
											name="txt_hlval" size="25" maxlength="25"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
											
									</tr>

									<tr>
										<td width="16%" nowrap id="shgval1">SHG Value</td>

										<td width="9%" id="shgval2"><select name="sel_shg_val"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="shgval3"><input
											type="text" name="txt_shg_val" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
										<td width="16%" nowrap id="iv1">Irrigated Value</td>

										<td width="9%" id="iv2"><select name="sel_irrigate"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="iv3"><input type="text"
											name="txt_irrigate_val" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											value=""></td>
											<td width="16%" nowrap id="sales1">Sales TurnOver</td>
										<td align="left" width="9%" id="sales2"><input
											type="text" name="txt_fromsalesturnover" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this);checkMinMax('sale')"
											value=""></td>
											
										<td align="left" width="23%" id="sales3"><input
											type="text" name="txt_tosalesturnover" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this);checkMinMax('sale')"
											value=""></td>
									</tr>
									<tr>
										<td width="16%" nowrap id="tl1">Total Limit (per
										borrower)</td>

										<td width="9%" id="tl2"><select
											name="sel_borrower_totlimit" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="tl3"><input type="text"
											name="txt_borrower_totlimit" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
										<td width="16%" nowrap id="sbv1">Share Broker Value</td>

										<td width="9%" id="sbv2"><select name="sel_sharebrk"
											tabindex="2">
											<option value="0"  selected="selected">&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td align="left" width="23%" id="sbv3">
										<select name="txt_sharebrkval">
										<option value="0">-- Select --</option>
										<option value="1">Yes</option>
										<option value="2">No</option>
										</select></td>
									</tr>


									<tr>
										<td width="16%" id="tlac1">Total Limit Agri Category (per
										borrower)</td>

										<td width="9%" id="tlac2"><select
											name="sel_borrower_agrtotlimit" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="tlac3"><input
											type="text" name="txt_borrower_agrtotlimit" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
										<td width="13%" align="left" id="tlsc1">Total Limit
										Service Category (per borrower)</td>

<!--										<td width="9%" id="tlsc2"><select-->
<!--											name="sel_borrower_totlimit_srvcat" tabindex="2">-->
<!--											<option value="0" selected>&lt;--Select--&gt;</option>-->
<!--											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />-->
<!--										</select></td>-->

										<td width="9%" id="tlsc2"><input type="text"
											name="sel_borrower_totlimit_srvcat" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this);checkMinMax('S')" value=""></td>
											
										<td width="30%" id="tlsc3"><input type="text"
											name="txt_borrower_totlimit_srvcat" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this);checkMinMax('S')" value=""></td>
									</tr>
									
									<!-- Added by Guhan on 06/08/2015 for New Priority sector conditions -->
									
									<tr>
										<td id="socInfra1">Social Infrastructure value</td>

										<td id="socInfra2"><select
											name="sel_social_Infra" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" id="socInfra3"><input
											type="text" name="txt_social_Infra" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
										<td align="left" id="agrianci1">Agriculture/ Ancillary activities value</td>

										<td id="agrianci2"><select
											name="sel_agri_anci" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td id="agrianci3"><input type="text"
											name="txt_agri_anci" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
									</tr>
									
									<tr>
										<td id="renew1">Renewable energy value</td>

										<td id="renew2"><select
											name="sel_renew_energy" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" id="renew3"><input
											type="text" name="txt_renew_energy" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
										<td align="left" id="renewIndv1">Renewal energy Individual value</td>

										<td id="renewIndv2"><select
											name="sel_renew_energy_indv" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td id="renewIndv3"><input type="text"
											name="txt_renew_energy_indv" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
									</tr>

									<tr>
										<td id="agriinfra1">Agriculture Infrastructure value</td>

										<td id="agriinfra2"><select
											name="sel_agri_infra" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" id="agriinfra3"><input
											type="text" name="txt_agri_infra" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
										<td id="conscost1">Cost of Construction</td>

										<td id="conscost2"><select
											name="sel_cons_cost" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" id="conscost3"><input
											type="text" name="txt_cons_cost" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
									</tr>
									<!-- End -->
												
									<!-- Added by Arsath on 22/08/2013 for New Fields like below -->									
									<tr>
									<td id="staff1">Staff Scheme</td>
									<td id="staff2">
									<select name="sel_staffscheme">
									<option value="0" selected>&lt;--Select--&gt;</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
									</select>
									</td>
									<td id="staff3">
									<select name="sel_staffschemevalue" style="width: 40%">
								    <option value="0" selected>&lt;----Select----&gt;</option>
									<option value="02">Yes</option>
									<option value="01">No</option>
									</select></td>
									
							<!--Added by Guhan on 10/08/2015-->
									<td id="physical1">Physically Challenged</td>
									<td id="physical2">
									<select name="sel_physically_challenged">
									<option value="0" selected>&lt;--Select--&gt;</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
									</select>
									</td>
									<td id="physical3">
									<select name="sel_physically_challenged_val" style="width: 40%">
								    <option value="0" selected>&lt;----Select----&gt;</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select></td>
							<!-- End by Guhan -->	
								
									</tr>
									<!-- End of Arsath -->
									<tr>
										<td width="16%" nowrap id="ba1">Branch Area</td>

										<td width="9%" id="ba2"><select name="sel_brancharea"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td align="left" width="23%" id="ba3"><select
											name="txt_brancharea_value" tabindex="2" multiple="multiple"
											style="width: 100%">
											<lapschoice:StaticDataNewTag apptype="128" />
										</select></td>

										<td width="13%" align="left" nowrap id="st1">Security
										Type</td>

										<td width="9%" id="st2"><select name="sel_sectype"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>
										<td id="st3"><select name="sel_sectype1" tabindex="2"
											style="width: 140px;">
											<option value="S" selected>&lt;----Select----&gt;</option>
											<option value="P">Primary</option>
											<option value="C">Collateral</option>
										</select></td>
									</tr>

									<tr>
										<td width="13%" align="left" nowrap id="uc1">Utilization
										Credit</td>

										<td width="9%" id="uc2"><select name="sel_utlz_credit"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="uc3"><select name="sel_utlz_credit1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<lapschoice:StaticDataNewTag apptype="128" />
										</select></td>
										<td width="13%" align="left" nowrap id="cons1">Constitution</td>

										<td width="9%" id="cons2"><select name="sel_constitution"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="cons3"><select
											name="sel_constitution1" tabindex="2" multiple="multiple"
											style="width: 100%">
											<lapschoice:CBSStaticDataNewTag apptype="2" />
										</select></td>
										
										<td width="16%" nowrap id="cre1">Percentage of CRERH</td>

										<td width="9%" id="cre2"><select name="sel_cretype"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" width="23%" id="cre3"><input
											type="text" name="txt_cre_value" size="25" maxlength="5"
											onKeyPress="allowWholeNumber(this)" onBlur="checkPercentage(this)" value=""></td>
										
										
									</tr>

									<tr>
										<td width="13%" align="left" nowrap id="ct1">Caste</td>

										<td width="9%" id="ct2"><select name="sel_caste"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="ct3"><select name="sel_caste1"
											tabindex="2" multiple="multiple" style="width: 75%">
											<lapschoice:CBSStaticDataNewTag apptype="7" />
										</select></td>

										<td width="13%" align="left" nowrap id="fc1">Farmer
										Category</td>

										<td width="9%" id="fc2"><select name="sel_farmer_cate"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="fc3"><select name="sel_farmer_cate1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<lapschoice:BanksSchemeStaticDataNewTag apptype="13" />
										</select></td>
									</tr>

									<tr>
										<td width="13%" align="left" nowrap id="ds1">Display
										Screen</td>

										<td width="9%" id="ds2"><select name="sel_dispscreen"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="ds3"><select name="sel_dispscreen1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<lapschoice:BanksSchemeStaticDataNewTag apptype="4" />
										</select></td>

										<td width="13%" align="left" nowrap id="gen1">Gender</td>

										<td width="9%" id="gen2"><select name="sel_gender"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="gen3"><select name="sel_gender1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<option value="M">Male</option>
											<option value="F">Female</option>
											<option value="O">Others</option>
										</select></td>
									</tr>

									<tr>
										<td width="13%" align="left" nowrap id="mg1">Management
										Gender</td>

										<td width="9%" id="mg2"><select name="sel_mgmnt_gender"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="mg3"><select name="sel_mgmnt_gender1"
											tabindex="2" multiple="multiple" style="width: 75%">
											<lapschoice:CBSStaticDataNewTag apptype="1" />
										</select></td>

										<td width="13%" align="left" nowrap id="gss1">Govt.Sponser
										Scheme</td>

										<td width="9%" id="gss2"><select name="sel_govt_spnr"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="gss3"><select name="sel_govt_spnr1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<lapschoice:StaticDataTag apptype="11"  tagType=""/>
										</select></td>
									</tr>
									<tr>
										<td width="13%" align="left" nowrap id="sv1">Security
										Value</td>

										<td width="9%" id="sv2"><select name="sel_secval"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="sv3"><select name="sel_secval1"
											tabindex="2" multiple="multiple" style="width: 100%">
											<%
												if (arrRow1 != null && arrRow1.size() > 0) {
													int intarrSize1 = arrRow1.size();
													for (int i = 0; i < intarrSize1; i++) {
														arrCol = (ArrayList) arrRow1.get(i);
											%>
											<option
												value="<%=Helper.correctNull((String) arrCol.get(0))%>"><%=Helper.correctNull((String) arrCol.get(1))%></option>
											<%
												}
												}
											%>
										</select></td>

										<td width="13%" align="left" nowrap id="bsc1">Bank
										Schematic Code</td>

										<td width="9%" id="bsc2"><select
											name="sel_bankschematic_code" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
										</select></td>

										<td width="30%" id="bsc3"><select
											name="sel_bankschematic_code1" tabindex="2"
											multiple="multiple" style="width: 100%">
											<lapschoice:BanksSchemeStaticDataNewTag apptype="1" />
										</select></td>

									</tr>
									
									<!-- Added by Arsath on 22/08/2013 for New Field Sector -->
									<tr id="sector">
									<td>Sector</td>
									<td>
									<select name="sel_sector">
									<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
									</select>
									</td>
									<td>
									<select name="sel_mulsector" tabindex="2" multiple="multiple" style="width: 100%">
									<lapschoice:BanksSchemeStaticDataNewTag apptype="7" />
									<lapschoice:BanksSchemeStaticDataNewTag apptype="8" />
									</select></td>
									</tr>
									<!-- End -->
									
									<tr id="stand_up">
										<td width="16%" nowrap id="sd1">Sanction Date</td>
										<td align="left" id="sd2"><select name="sel_sanction_val"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>
										<td valign="top" id="sd3">
										<table border="0" cellspacing="0" cellpadding="0"
											class="outertable">
											<tr>
												<td><input type="text" name="txt_sanctiondate"
													size="12" maxlength="10" value=""
													onBlur="checkDate(this);checkmaxdate(this,currentDate);">&nbsp;
												</td>
												<td><a href="#" onClick="callCalender1()"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0"></a></td>
											</tr>
										</table>
										</td>
								
										<td width="13%" align="left" nowrap>Policy Date<b><span
											class="mantatory">&nbsp;*</span></b></td>
										<!--<td id="npd3">
										<select name="sel_psdateval"
											tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select>
										</td>-->
										<td valign="top" colspan="2">
										<table border="0" cellspacing="0" cellpadding="0" width="40%"
											class="outertable">
											<tr>
												<td><input type="text" name="txt_new_psdate" size="12"
													maxlength="10" value=""
													onBlur="checkDate(this);">
												</td>
												<td><a href="#" onClick="callCalender2()"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></td>
											</tr>
										</table>
										</td>
									</tr>	
									<tr id="stand_up1">
										<td width="13%" align="left" nowrap>Sub Sector<b><span class="mantatory">&nbsp;*</span></b></td>
										<td colspan="2"><select name="sel_subsector"
											style="width: 300px;">
											<option value="0" selected>&lt;----Select----&gt;</option>
										</select></td>
										<td>Visibility</td>
										<td colspan="2"><select name="sel_Visibility"
											style="width: 110px;">
											<option value="E" selected="selected">Enable</option>
											<option value="D">Disable</option>
										</select></td>
									</tr>
									
									<tr id="id_modeadv">	
										<td width="13%" align="left" nowrap>Mode of Advance<b><span
											class="mantatory">&nbsp;*</span></b></td>
										<td colspan="2"><select name="sel_modeadv"
											style="width: 300px;">
											<option value="" selected>&lt;----Select----&gt;</option>
											<lapschoice:CBSStaticDataNewTag apptype="23"/>
										</select></td>
									</tr>
									<!--<tr>
										<td width="13%" align="left" nowrap id="pno1">Priority No</td>
										<td colspan="5" id="pno2"><select name="sel_priority"
											tabindex="2">
											<option value="0" selected>&lt;----Select----&gt;</option>
											<option value="1">Primary</option>
											<option value="2">Collateral</option>
										</select></td>
									</tr>-->
									
									<tr id="id_stnd"> 
									<td  width="5%"  nowrap>Exposure Range from <b><span class="mantatory">&nbsp;*</span></b></td>
									<td width="16%">
										<table width="40%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td><input type="text" name="txt_dte_from" size="12" style="text-align: right;"
													maxlength="11" value=""	>
												</td></tr></table></td>
									<td width="5%" nowrap>To<b><span class="mantatory">&nbsp;*</span></b></td>
									<td width="16%">
										<table width="40%" border="0" cellspacing="0" cellpadding="3">
											<tr>
											<td><input type="text" name="txt_dte_to" size="12" style="text-align: right;"
													maxlength="11" value="">
												</td></tr></table></td>
									</tr>
									<tr id="id_stnd1">
									<td width="5%">Effect from<b><span class="mantatory">&nbsp;*</span></b></td>
									<td width="16%">
										<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
													<td ><input type="text" name="txt_dte_effect" size="12" maxlength="10" value="" onBlur="checkDate(this);checkmaxdate(this,currentDate)"></td>
													<td ><a href="#" onClick="callCalender5()"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0"></a></td>
													</tr></table></td>
													<td >Loan Period<b><span class="mantatory">&nbsp;*</span></b></td>
													<td ><input type="text" name="txt_loan_prd" size="12" maxlength="3" onKeyPress="allowWholeNumber(this)" value="">(months)</td>
													<td></td>
													
									</tr>
									<tr id="id_stnd2">
									<td width="5%">Holiday Period<b><span class="mantatory">&nbsp;*</span></b></td>
									<td width="16%">
										<table width="40%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
											<td ><input type="text" name="txt_holiday_prd" size="12" maxlength="3" onKeyPress="allowWholeNumber(this)" value="">(months)</td>
											<td></td>
											</tr></table></td>
											<td width="13%">Classification<b><span class="mantatory">&nbsp;*</span></b></td>
										<td ><select name="sel_classfi">
											<option value="00" selected="selected">--select--</option>
											<option value="01">Priority Sector</option>
											<option value="02">Non Priority Sector</option>
											</select></td>
											
									</tr>
									<tr id="id_stnd3">
									<td width="13%">Agriculture Industry service category<b><span class="mantatory">&nbsp;*</span></b></td>
									<td width="20%"><select name="sel_agr_srv_ctg"
											tabindex="2" multiple="multiple" style="width: 100%">
											<%
												if (arrRow2 != null && arrRow2.size() > 0) {
													int intarrSize1 = arrRow2.size();
													for (int i = 0; i < intarrSize1; i++) {
														arrCol = (ArrayList) arrRow2.get(i);
											%>
											<option	value="<%=Helper.correctNull((String) arrCol.get(0))%>"><%=Helper.correctNull((String) arrCol.get(1))%></option>
											<%
												}
												}
											%>
										</select></td>
										<td></td>
									
				
									</tr>
										<!--Added by Guhan on 10/08/2015-->
										<tr id="minority">
									<td>Minority</td>
									<td>
									<select name="sel_minority">
									<option value="0" selected>&lt;--Select--&gt;</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
									</select>
									</td>
									<td>
									<select name="sel_minority_val" style="width: 40%">
								    <option value="0" selected>&lt;----Select----&gt;</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select></td>
									</tr>
									<tr id="minority1">
									<td nowrap="nowrap">Whether majority of members/owners belong to minority community</td>
									<td>
									<select name="sel_nonindminority">
									<option value="0" selected>&lt;--Select--&gt;</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="20" />
									</select>
									</td>
									<td>
									<select name="sel_nonindminority_val" style="width: 40%">
								    <option value="0" selected>&lt;----Select----&gt;</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
									</select></td>
									</tr>
								<tr id="priority_id1">
										<td nowrap="nowrap">Whether Start up as per definition of
										Ministry of Commerce and Industry</td>
										
										<td colspan="2"><select name="sel_start_up_minority_val">
											<option value="0" selected>&lt;----Select----&gt;</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select></td>
										<td><span>Carpet Area (in Sq mt)</span></td>

										<td><select name="txt_carpet" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left"><input type="text"
											name="txt_carpet_value" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
									</tr>

									<tr id="priority_id2">

										<td  nowrap="nowrap"><span>Floor Area Ratio/Floor Space Index (in %)</span></td>

										<td><select name="txt_floorarea" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left"><input type="text"
											name="txt_floorarea_value" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>

										<td  nowrap="nowrap"><span>Maximum Area of Individual House</span></td>

										<td colspan="2"><select name="txt_maxarea_indhouse" tabindex="2">
											<option value="0">&lt;--Select--&gt;</option>
                                         <%String strapptype1 = "253";%>
                                       <lapschoice:StaticDataNewTag apptype='<%=strapptype1%>' />
                                         </select></td>
									</tr>

									<tr id="priority_id3">
										<td  nowrap="nowrap"><span>Maximum Share in the proposed loan by each SHG member</span></td>

										<td><select name="txt_max_shg_proploan" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left"><input type="text"
											name="txt_max_shg_proploan_value" size="25" maxlength="20"
											style="text-align: right" onKeyPress="allowWholeNumber(this)"
											onBlur="roundtxt(this)" value=""></td>
									</tr>
									<tr id="priority_id4">
									<td  nowrap="nowrap"><span>Allied Activity</span></td>
									<td colspan="2"><select name="sel_alliedactivity">
											<option value="0" selected>&lt;----Select----&gt;</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
										</select></td>
									
									</tr>
									<tr id="id_drilling">
										<td>overall cost of the dwelling unit</td>

										<td><select
											name="txt_dwelling_code" tabindex="2">
											<option value="0" selected>&lt;--Select--&gt;</option>
											<lapschoice:BanksSchemeStaticDataNewTag apptype="19" />
										</select></td>

										<td align="left" ><input
											type="text" name="txt_dwelling_value" size="25"
											maxlength="20" style="text-align: right"
											onKeyPress="allowWholeNumber(this)" onBlur="roundtxt(this)"
											value=""></td>
									</tr>
									<!-- End by Guhan -->	
									
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
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<br>
<table class="outertable" width="98%" border="0" cellspacing="0"
	cellpadding="0" align="center">
	<tr>
		<td valign="top" align="center">
		<table class="outertable linebor" width="100%" border="0"
			cellspacing="0" cellpadding="3">
			<tr class="dataheader">
				<td width="3%">&nbsp;</td>
				<td width="7%" align="center"><b>S No.</b></td>
				<td width="90%" align="center"><b>Activity Code</b></td>
			</tr>
			<%
				if (arrRow != null && arrRow.size() > 0) {
					for (int i = 0; i < arrRow.size(); i++) {
						arrCol = (ArrayList) arrRow.get(i);

			%>
			<tr class="datagrid">
				<td width="3%"><input type="radio" name="radiobutton"
					value="radiobutton" style="border-style: none"
					onClick="selectValues('<%=Helper.correctNull((String) arrCol.get(0))%>',
					'<%=Helper.correctNull((String) arrCol.get(1))%>',
					'<%=Helper.correctNull((String) arrCol.get(2))%>',
					'<%=Helper.correctNull((String) arrCol.get(3))%>',
					'<%=Helper.correctNull((String) arrCol.get(4))%>',
					'<%=Helper.correctNull((String) arrCol.get(5))%>',
					'<%=Helper.correctNull((String) arrCol.get(6))%>',
					'<%=Helper.correctNull((String) arrCol.get(7))%>',
					'<%=Helper.correctNull((String) arrCol.get(8))%>',
					'<%=Helper.correctNull((String) arrCol.get(9))%>',
					'<%=Helper.correctNull((String) arrCol.get(10))%>',
					'<%=Helper.correctNull((String) arrCol.get(11))%>',
					'<%=Helper.correctNull((String) arrCol.get(12))%>',
					'<%=Helper.correctNull((String) arrCol.get(13))%>',
					'<%=Helper.correctNull((String) arrCol.get(14))%>',
					'<%=Helper.correctNull((String) arrCol.get(15))%>',
					'<%=Helper.correctNull((String) arrCol.get(16))%>',
					'<%=Helper.correctNull((String) arrCol.get(17))%>',
					'<%=Helper.correctNull((String) arrCol.get(18))%>',
					'<%=Helper.correctNull((String) arrCol.get(19))%>',
					'<%=Helper.correctNull((String) arrCol.get(20))%>',
					'<%=Helper.correctNull((String) arrCol.get(21))%>',
					'<%=Helper.correctNull((String) arrCol.get(22))%>',
					'<%=Helper.correctNull((String) arrCol.get(23))%>',
					'<%=Helper.correctNull((String) arrCol.get(24))%>',
					'<%=Helper.correctNull((String) arrCol.get(25))%>',
					'<%=Helper.correctNull((String) arrCol.get(26))%>',
					'<%=Helper.correctNull((String) arrCol.get(27))%>',
					'<%=Helper.correctNull((String) arrCol.get(28))%>',
					'<%=Helper.correctNull((String) arrCol.get(29))%>',
					'<%=Helper.correctNull((String) arrCol.get(30))%>',
					'<%=Helper.correctNull((String) arrCol.get(31))%>',
					'<%=Helper.correctNull((String) arrCol.get(32))%>',
					'<%=Helper.correctNull((String) arrCol.get(33))%>',
					'<%=Helper.correctNull((String) arrCol.get(34))%>',
					'<%=Helper.correctNull((String) arrCol.get(35))%>',
					'<%=Helper.correctNull((String) arrCol.get(36))%>',
					'<%=Helper.correctNull((String) arrCol.get(37))%>',
					'<%=Helper.correctNull((String) arrCol.get(38))%>',
					'<%=Helper.correctNull((String) arrCol.get(39))%>',
					'<%=Helper.correctNull((String) arrCol.get(40))%>',
					'<%=Helper.correctNull((String) arrCol.get(41))%>',
					'<%=Helper.correctNull((String) arrCol.get(42))%>',
					'<%=Helper.correctNull((String) arrCol.get(43))%>',
					'<%=Helper.correctNull((String) arrCol.get(44))%>',
					'<%=Helper.correctNull((String) arrCol.get(45))%>',
					'<%=Helper.correctNull((String) arrCol.get(46))%>',
					'<%=Helper.correctNull((String) arrCol.get(47))%>',
					'<%=Helper.correctNull((String) arrCol.get(48))%>',
					'<%=Helper.correctNull((String) arrCol.get(49))%>',
					'<%=Helper.correctNull((String) arrCol.get(50))%>',
					'<%=Helper.correctNull((String) arrCol.get(51))%>',
					'<%=Helper.correctNull((String) arrCol.get(52))%>',
					'<%=Helper.correctNull((String) arrCol.get(53))%>',
					'<%=Helper.correctNull((String) arrCol.get(54))%>',
					'<%=Helper.correctNull((String) arrCol.get(55))%>',
					'<%=Helper.correctNull((String) arrCol.get(56))%>',
					'<%=Helper.correctNull((String) arrCol.get(57))%>',
					'<%=Helper.correctNull((String) arrCol.get(58))%>',
					'<%=Helper.correctNull((String) arrCol.get(59))%>',
					'<%=Helper.correctNull((String) arrCol.get(60))%>',
					'<%=Helper.correctNull((String) arrCol.get(61))%>',					
					'<%=Helper.correctNull((String) arrCol.get(62))%>',
					'<%=Helper.correctNull((String) arrCol.get(63))%>',
					'<%=Helper.correctNull((String) arrCol.get(64))%>',
					'<%=Helper.correctNull((String) arrCol.get(65))%>',
					'<%=Helper.correctNull((String) arrCol.get(66))%>',
					'<%=Helper.correctNull((String) arrCol.get(67))%>',							
					'<%=Helper.correctNull((String) arrCol.get(68))%>',							
					'<%=Helper.correctNull((String) arrCol.get(69))%>',							
					'<%=Helper.correctNull((String) arrCol.get(70))%>',							
					'<%=Helper.correctNull((String) arrCol.get(71))%>',							
					'<%=Helper.correctNull((String) arrCol.get(72))%>',							
					'<%=Helper.correctNull((String) arrCol.get(73))%>',							
					'<%=Helper.correctNull((String) arrCol.get(74))%>',							
					'<%=Helper.correctNull((String) arrCol.get(75))%>',					
					'<%=Helper.correctNull((String) arrCol.get(76))%>',					
					'<%=Helper.correctNull((String) arrCol.get(77))%>',					
					'<%=Helper.correctNull((String) arrCol.get(78))%>',					
					'<%=Helper.correctNull((String) arrCol.get(79))%>',
					'<%=Helper.correctNull((String) arrCol.get(80))%>',
					'<%=Helper.correctNull((String) arrCol.get(81))%>',
					
					'<%=Helper.correctNull((String) arrCol.get(82))%>',
					'<%=Helper.correctNull((String) arrCol.get(83))%>',
					'<%=Helper.correctNull((String) arrCol.get(84))%>',
					'<%=Helper.correctNull((String) arrCol.get(85))%>',
					'<%=Helper.correctNull((String) arrCol.get(86))%>',
					'<%=Helper.correctNull((String) arrCol.get(87))%>',
					'<%=Helper.correctNull((String) arrCol.get(88))%>',
					'<%=Helper.correctNull((String) arrCol.get(89))%>',
					'<%=Helper.correctNull((String) arrCol.get(90))%>',
					'<%=Helper.correctNull((String) arrCol.get(91))%>',
					'<%=Helper.correctNull((String) arrCol.get(92))%>',
					'<%=Helper.correctNull((String) arrCol.get(93))%>',
					'<%=Helper.correctNull((String) arrCol.get(94))%>',
					'<%=Helper.correctNull((String) arrCol.get(95))%>',
					'<%=Helper.correctNull((String) arrCol.get(96))%>',
					'<%=Helper.correctNull((String) arrCol.get(97))%>',
					'<%=Helper.correctNull((String) arrCol.get(98))%>',
					'<%=Helper.correctNull((String) arrCol.get(99))%>',
					'<%=Helper.correctNull((String) arrCol.get(100))%>',
					'<%=Helper.correctNull((String) arrCol.get(101))%>',
					'<%=Helper.correctNull((String) arrCol.get(102))%>',
					'<%=Helper.correctNull((String) arrCol.get(103))%>',
					'<%=Helper.correctNull((String) arrCol.get(104))%>',
					'<%=Helper.correctNull((String) arrCol.get(105))%>'
					)">
				</td>
				<td width="7%" align="center"><%=Helper.correctNull((String) arrCol.get(2))%></td>
				<td width="90%" align="left">&nbsp;<%=Helper.correctNull((String) arrCol.get(58))%></td>
			</tr>
			<%
				}
				} else {
			%>
			<tr class="datagrid">
				<td width="3%">&nbsp;</td>
				<td width="7%">&nbsp;</td>
				<td width="90%">&nbsp;</td>
			</tr>
			<%
				}
			%>
			<tr class="datagrid">
				<td width="3%">&nbsp;</td>
				<td width="7%">&nbsp;</td>
				<td width="90%">&nbsp;</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidkeyid" value="set"> <input type="hidden"
	name="seldataheadtype1"> <input type="hidden" name="org_code"
	value="<%=session.getAttribute("strOrgCode")%>"> <input
	type="hidden" name="strOrgCode"
	value="<%=session.getAttribute("strOrgCode")%>"> <input
	type="hidden" name="hidstate" value="2"> <input type="hidden"
	name="hidstatenew" value=""> <input type="hidden"
	name="txt_hidsno" value=""> <input type="hidden"
	name="hid_sel_constitution" value=""> <input type="hidden"
	name="hid_sel_farmer_cate" value=""> <input type="hidden"
	name="hid_sel_govt_spnr" value=""> <input type="hidden"
	name="hid_sel_bankschematic_code" value=""> <input
	type="hidden" name="hid_sel_utlz_credit" value=""> <input
	type="hidden" name="hid_sel_branch_area" value=""> <input
	type="hidden" name="hid_sel_caste" value=""> <input
	type="hidden" name="hid_sel_dispscreen" value=""> <input
	type="hidden" name="hid_sel_gender" value=""> <input
	type="hidden" name="hid_sel_mgmnt_gender" value=""> <input
	type="hidden" name="hid_sel_secval" value=""> <input
	type="hidden" name="hid_run_sno" value=""> <input type="hidden"
	name="hid_actual_sno" value=""> <input type="hidden"
	name="hid_activity_sno" value=""> <input type="hidden"
	name="hidSlNo">
	<input type="hidden" name="hid_sector_value">
	<input type="hidden" name="hid_rad_classificationbased">
	<input type="hidden" name="hid_standUp" value="">
	
	<br>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>
