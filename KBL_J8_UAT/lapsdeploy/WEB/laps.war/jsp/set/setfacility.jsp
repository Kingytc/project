<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap)
	{
		hshValues = (java.util.HashMap) objValues;
	}
	String strProductType = Helper.correctNull((String) hshValues.get("prd_type"));
	if(strProductType.trim().equalsIgnoreCase(""))
	{
		strProductType = Helper.correctNull((String) hshValues.get("com_agrscheme"));
	}
	String strPurpose = "";
	if(strProductType.trim().equalsIgnoreCase(""))
	{
		strPurpose = "C";
	}
	else
	{
		strPurpose = strProductType.substring(0,1).toUpperCase();
	}
	session.setAttribute("strProductType", strProductType);
	session.setAttribute("schemeCode", Helper.correctNull((String) hshValues.get("scheme_code")));
	String fac_id = Helper.correctNull((String) hshValues.get("fac_id"));
	String fac_id1 = Helper.correctNull((String) hshValues.get("fac_id1"));
	String strType = Helper.correctNull((String) hshValues.get("txt_industry"));
	session.setAttribute("hidcorp_faccode", Helper.correctNull((String) hshValues.get("txt_code")));
	session.setAttribute("hidcorp_headname", Helper.correctNull((String) hshValues.get("txtcat_name")));
	session.setAttribute("hidcorp_subfac", Helper.correctNull((String) hshValues.get("txt_facility")));
	session.setAttribute("facility_type", Helper.correctNull((String) hshValues.get("seltype")));
	session.setAttribute("facility_nature", Helper.correctNull((String) hshValues.get("facility1")));
	session.setAttribute("facility_parent", Helper.correctNull((String) hshValues.get("fac_parent")));
	session.setAttribute("facility_sub", Helper.correctNull((String) hshValues.get("fac_sub")));
	String varNoOfRatingDescription=Helper.correctNull((String) hshValues.get("NoOfRatingDescription"));
	session.setAttribute("prdNoOfRatingDescription",varNoOfRatingDescription);
	session.setAttribute("hidcorp_module", Helper.correctNull((String)hshValues.get("com_module")));
	session.setAttribute("hidcom_facstatus", Helper.correctNull((String)hshValues.get("com_facstatus")));
	session.setAttribute("com_facintdef", Helper.correctNull((String)hshValues.get("com_facintdef")));
	String strCorpModule = Helper.correctNull((String)hshValues.get("com_module")).trim();
    session.setAttribute("strfacmaxperiodrest", Helper.correctNull((String)hshValues.get("COM_MAXREPAYPERIOD_REST")));
    session.removeAttribute("com_svanidhi1");
    session.removeAttribute("com_svanidhi");

    session.setAttribute("com_svanidhi1", Helper.correctNull((String)hshValues.get("COM_SVANIDHITYPE")));
  
%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Facility</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var sel_type="<%=Helper.correctNull((String) hshValues.get("seltype"))%>";
var sel_nature="<%=Helper.correctNull((String) hshValues.get("facility1"))%>";
var sel_stop="<%=Helper.correctNull((String) hshValues.get("com_facility_stop"))%>";
var sel_loantype="<%=Helper.correctNull((String) hshValues.get("com_facility_loantype"))%>";
var sel_emischcode="<%=Helper.correctNull((String) hshValues.get("com_facility_emischeme"))%>";
var sel_nonemischcode="<%=Helper.correctNull((String) hshValues.get("com_facility_nonemischeme"))%>";
var sel_eischcode="<%=Helper.correctNull((String) hshValues.get("com_facility_eischeme"))%>";
var sel_noneischcode="<%=Helper.correctNull((String) hshValues.get("com_facility_noneischeme"))%>";
var sel_lumpsum="<%=Helper.correctNull((String) hshValues.get("com_facility_lumpsum"))%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var fac_id="<%=fac_id%>";
var fac_id1="<%=fac_id1%>";
var varpurposeofloan = '<%=hshValues.get("com_purposeofloan")%>';
var var_module = "<%=Helper.correctNull((String)hshValues.get("com_module"))%>";
var var_agrscheme = "<%=Helper.correctNull((String)hshValues.get("com_agrscheme"))%>";
var sel_bankscheme_name = '<%=Helper.correctNull((String) hshValues.get("com_bankscheme"))%>'; 
var sel_agrscheme_name = '<%=Helper.correctNull((String) hshValues.get("com_agrschemetype"))%>';
var selintrate='<%=Helper.correctNull((String)hshValues.get("com_facility_intfreq"))%>';
var varselrating="<%=Helper.correctNull((String)hshValues.get("selrating"))%>";
var curDate="<%=Helper.getCurrentDateTime()%>";
var sel_schemeheadcode="<%=Helper.correctNull((String)hshValues.get("com_schemeheadcode"))%>";
var schemecode="";
var varcashmargin="<%=Helper.correctNull((String)hshValues.get("com_cashmargin"))%>";
var varloanagainstshare="<%=Helper.correctNull((String)hshValues.get("com_loanagainstshares"))%>";
var varfacintdef="<%=Helper.correctNull((String)hshValues.get("com_facintdef"))%>";
var varshartype="<%=Helper.correctNull((String)hshValues.get("COM_SHARETYPE"))%>";
var varwhetdigi="<%=Helper.correctNull((String)hshValues.get("com_whtdigiprd"))%>";
var varwhetdigiRat="<%=Helper.correctNull((String)hshValues.get("com_whtdigiprdRat"))%>";
var varforexfac="<%=Helper.correctNull((String)hshValues.get("com_forexfac"))%>";
var varpoolrating="<%=Helper.correctNull((String)hshValues.get("COM_POOL_BASED_RATING"))%>";
var varPRDCGTMSEFALG='<%=Helper.correctNull((String) hshValues.get("COM_CGTMSEFLAG"))%>';

function disableCommandButtons( bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;		
	document.forms[0].cmdclose.disabled=bool5;
}
function placevalues()
{

		
	document.forms[0].sel_bankscheme.value=sel_bankscheme_name;
	if(varpoolrating !=""){
	document.forms[0].sel_rating_pool.value=varpoolrating;
	}
	
	if(var_module !="")
	{
		document.forms[0].sel_facility.value = var_module;
	}
	else
	{
		document.forms[0].sel_facility.value = "s";
	}
	callProducts();


	if(sel_agrscheme_name!="")
	{
     document.forms[0].sel_schemetype.value=sel_agrscheme_name;
	}
	else
	{
		document.forms[0].sel_schemetype.value="0";
	}
	if(selintrate!="")
	{
		document.forms[0].selintrate.value=selintrate;
	}
	else
	{
		document.forms[0].selintrate.value="M";
	}
	if(var_agrscheme != "")
	{
		document.forms[0].prd_type2.value = var_agrscheme.charAt(1);
	}
	if(sel_type!="")
	{
		document.forms[0].seltype.value=sel_type;
	}
	else
	{
		document.forms[0].seltype.value="";
	}
	if(sel_nature!="")
	{
		document.forms[0].facility1.value=sel_nature;
	}
	else
	{
		document.forms[0].facility1.value="0";
	}
	if(sel_stop!="")
	{
		document.forms[0].sel_stop.value=sel_stop;
	}
	else
	{
		document.forms[0].sel_stop.value="0";
	}
	if(sel_loantype!="")
	{
		document.forms[0].fac_loantype.value=sel_loantype;
	}
	else
	{
		document.forms[0].fac_loantype.value="0";
	}
	if(varselrating!="")
	{
		document.forms[0].selrating.value=varselrating;
	}
	else
	{
		document.forms[0].selrating.value="s";
	}
	if(varPRDCGTMSEFALG!="")
	{
		document.forms[0].sel_CGTMSE.value = varPRDCGTMSEFALG;
	}
	else
	{
		document.forms[0].sel_CGTMSE.value="S";
	}
	selectValues();
	funglsubcode();
	if(fac_id=="new")
	{
		document.forms[0].fac_intro_date.value=curDate;
		document.forms[0].fac_id.value=fac_id;
		document.forms[0].sel_facility.focus();
		document.forms[0].hidAction.value ="update";
		disableCommandButtons(true,false,true,true,false);
	}
	else if(fac_id1!="")
	{
		document.forms[0].fac_id.value=fac_id1;
	}
	else if(fac_id!="new")
	{
		disableFields(true);
		disableCommandButtons(false,true,true,true,false);
	}
	if(varcashmargin=="Y")
	{
		document.forms[0].chkcashmargin.checked=true;
	}
	else
	{
		document.forms[0].chkcashmargin.checked=false;
	}
	if(varloanagainstshare=="Y")
	{
		document.forms[0].chkloanagainstshare.checked=true;

		if(varshartype!="")
		{
			document.all.loan_again_share.value = varshartype;
		}
	}
	else
	{
		document.forms[0].chkloanagainstshare.checked=false;
		document.all.loan1.style.display = "none";
		document.all.loan2.style.display = "none";
	}
	if(varfacintdef!="")
	{
		document.forms[0].sel_intdefinition.value=varfacintdef;
	}
	else
	{
		document.forms[0].sel_intdefinition.value="";
	}
	document.forms[0].sel_forexfac.value=varforexfac;
	var str_type=document.forms[0].hidRepaymentType.value;
	var str_type_temp =str_type.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		var selValue=str_type_temp[i];
	
		if("E"==selValue)	
		{		
			document.forms[0].sel_repaymenttype.options[0].selected=true;
		}			
		else if("NE"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[1].selected=true;
		}
		else if("OD"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[2].selected=true;
		}
		else if("LC"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[3].selected=true;
		}			
		else if("CO"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[4].selected=true;
		}
		else if("BG"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[5].selected=true;
		}
		else if("DD"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[6].selected=true;
		}
		else if("PC"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[7].selected=true;
		}
		else if("PS"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[8].selected=true;
		}
		else if("PR"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[9].selected=true;
		}
		else if("TG"==selValue)
		{			
			document.forms[0].sel_repaymenttype.options[10].selected=true;
		}
		
	}


	str_type=document.forms[0].hidInterestType.value;
	str_type_temp =str_type.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		for(var j=0;j<document.forms[0].sel_interesttype.length;j++)
		{
			if(document.forms[0].sel_interesttype.options[j].value==str_type_temp[i])
			{
				document.forms[0].sel_interesttype.options[j].selected=true;
			}
		}
	}

	str_type=document.forms[0].hidFacDisplayDesc.value;
	str_type_temp =str_type.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		for(var j=0;j<document.forms[0].sel_facdispdesc.length;j++)
		{
			if(document.forms[0].sel_facdispdesc.options[j].value==str_type_temp[i])
			{
				document.forms[0].sel_facdispdesc.options[j].selected=true;
			}
		}
	}
	document.forms[0].sel_digi.value=varwhetdigi;
	document.forms[0].sel_digiRating.value=varwhetdigiRat;
	document.forms[0].hidcashmargin.value=varcashmargin;
	document.forms[0].seltype.disabled=true;
	document.forms[0].facility1.disabled=true;
	document.forms[0].sel_stop.disabled=true;
	checkloanshare();
}
function callRange(range)
{
	var rangeamount=document.forms[0].prd_rng_from.value;
	<%ArrayList vec = (ArrayList) hshValues.get("vecMarginRow");
	if (vec != null)
	{
		for (int i = 0; i < vec.size(); i++)
		{
			ArrayList v = (ArrayList) vec.get(i);%>
			if(eval(rangeamount) > eval('<%=v.get(2)%>'))
			{
				alert("The Entered amount is less than margin amount range from");
				document.forms[0].prd_rng_from.focus();
				return 0;
			}
		<%}
	}%>
}
function callRangeTo(range)
{
	var rangeamount1=document.forms[0].prd_rng_to.value;
	<%ArrayList vec1 = (ArrayList) hshValues.get("vecMarginRow");
	if (vec != null)
	{
		for (int i = 0; i < vec.size(); i++)
		{
			ArrayList v1 = (ArrayList) vec1.get(i);%>
			if(eval(rangeamount1) < eval('<%=v1.get(3)%>'))
			{
				alert("The Entered amount is greater than margin amount range to");
				document.forms[0].prd_rng_to.focus();
				return 0;
			}
		<%}
	}%>	
}
function showProduct(val)
{
	if(val=="FH")
	{
		show('parent',"0");
	}
	else
	{
		if(document.forms[0].hidcat_id.value=="")
		{
			alert("Select Facility Head");
			return false;
		}
 	 	show('subsel',document.forms[0].hidcat_id.value);
	}
}
function show(val,val2)
{
	if(trimtxt(document.forms[0].sel_facility.value)=="s")
	{
		alert("Select - Facility For");
		document.forms[0].sel_facility.focus();
		return;
	}
	var purl = appUrl+"action/prodlist.jsp?hidMethod=getFacility&page=corpfacility&cat="+val+"&select="+val2+"&beanid=facilitymaster&method=getData&modType="+trimtxt(document.forms[0].sel_facility.value);
	var title = "Head_of_the_Facility";
	var prop = "scrollbars=no,width=450,height=350";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function callPage(pagename)
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+pagename;
	document.forms[0].submit();
}
function selpen()
{
	if(strsec_unsecfl=="y")
	{
		document.forms[0].sec_unsecfl.value="y";
	}
	if(strsec_unsecfl=="n")
	{
		document.forms[0].sec_unsecfl.value="n";
	}
	if(strsec_unsecfl=="")
	{
		document.forms[0].sec_unsecfl.value="0";
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
	    document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comfacilityhome.jsp";
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=!val;
		}
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].disabled=val;
		}
	}
	document.forms[0].fac_intro_date.readOnly=true;
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,true,false,false);
	document.forms[0].seltype.disabled=true;
	document.forms[0].facility1.disabled=true;
	document.forms[0].hidAction.value ="update";
	document.forms[0].txt_facility.readOnly=true;
	document.forms[0].txtcat_name.readOnly=true;
}
function doSave()
{
	
	if(trimtxt(document.forms[0].sel_facility.value)=="s")
	{
		alert("Select - Facility For");
		document.forms[0].sel_facility.focus();
		return;
	}
	if(trimtxt(document.forms[0].fac_loantype.value)=="0")
	{
		alert("Select Loan Type");
		document.forms[0].fac_loantype.focus();
		return;
	}
	if(trimtxt(document.forms[0].scheme_code.value)=="S")
	{
		alert("Select Scheme Code");
		document.forms[0].scheme_code.focus();
		return;
	}
	 if(document.forms[0].sel_bankscheme.selectedIndex==0)
	 {
		 ShowAlert(111,"Bank's Scheme");
		 document.forms[0].sel_bankscheme.focus();
		 return;
	 }
	if(trimtxt(document.forms[0].txtcat_name.value)=="")
	{
		alert("Select - Head of Facility");
		document.forms[0].txtcat_name.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_facility.value)=="")
	{
		alert("Select - Facility");
		document.forms[0].txt_facility.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_descrip.value)=="")
	{
		alert("Enter the Description");
		document.forms[0].txt_descrip.focus();
		return;
	}
	if(trimtxt(document.forms[0].sel_facility.value)=="a")
	{
		if(document.forms[0].sel_schemetype.value=="0")
		{
		alert("Select Scheme Type");
		document.forms[0].sel_schemetype.focus();
		return;
		}
	}
	if(trimtxt(document.forms[0].prd_rng_from.value)=="")
	{
		alert("Enter the Range From");
		document.forms[0].prd_rng_from.focus();
		return;
	}	
	if(trimtxt(document.forms[0].prd_rng_to.value)=="")
	{
		alert("Enter the Range To");
		document.forms[0].prd_rng_to.focus();
		return;
	}
	document.forms[0].prd_rng_to.value=trim(document.forms[0].prd_rng_to.value);
	 if(document.forms[0].prd_rng_to.value!="" && eval(document.forms[0].prd_rng_from.value)>=eval(document.forms[0].prd_rng_to.value))
	 {
		 ShowAlert(115,"Range to value","range from value");
		 document.forms[0].prd_rng_to.select();
		 document.forms[0].prd_rng_to.focus();
		 return;
	 }
	if(trimtxt(document.forms[0].prd_minterm.value)=="")
	{
		alert("Enter the Min Loan Period");
		document.forms[0].prd_minterm.focus();
		return;
	}	
	if(trimtxt(document.forms[0].prd_maxterm.value)=="")
	{
		alert("Enter the Max Loan Period");
		document.forms[0].prd_maxterm.focus();
		return;
	}
	if(eval(document.forms[0].prd_maxterm.value)<= eval(document.forms[0].prd_minterm.value))
	{
		ShowAlert(153,"Minimum Repayment Period","Maximum Repayment Period");
		document.forms[0].prd_minterm.value="";
		document.forms[0].prd_minterm.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_holiday.value)=="")
	{
		alert("Enter the Holiday Period");
		document.forms[0].txt_holiday.focus();
		return;
	}
	if(eval(document.forms[0].prd_maxterm.value)<= eval(document.forms[0].txt_holiday.value))
	{
		ShowAlert(153,"Holiday Period","Maximum Repayment Period");
		document.forms[0].txt_holiday.value="";
		document.forms[0].txt_holiday.focus();
		return;
	}
	if(document.forms[0].selrating.value=="s")
	{
		alert("Select Whether Rating");
		document.forms[0].selrating.focus();
		return;
	}
	if(schemecode=="BPGEN" || schemecode=="FBA")
	{
		if(document.forms[0].selschemehead.value=="S")
		{
			alert("Select GL Sub Head Code");
			document.forms[0].selschemehead.focus();
			return;
		}
	}
	var str_type ="";
	for(var i=0;i<document.forms[0].sel_repaymenttype.options.length;i++)
	{
		if(document.forms[0].sel_repaymenttype.options[i].selected)
		{				
			str_type=str_type+document.forms[0].sel_repaymenttype.options[i].value+"@";
		}		
	}
	
	if(str_type=="")
	{
		alert("Select the Repayment Type");
		return false;
	}
	document.forms[0].hidRepaymentType.value=str_type;

	if(document.forms[0].sel_intdefinition.value=="")
	{
		alert("Select Interest Definition");
		document.forms[0].sel_intdefinition.focus();
		return;
	}

	str_type ="";
	for(var i=0;i<document.forms[0].sel_interesttype.options.length;i++)
	{
		if(document.forms[0].sel_interesttype.options[i].selected)
		{				
			str_type=str_type+document.forms[0].sel_interesttype.options[i].value+"@";
		}		
	}

	if(document.forms[0].sel_intdefinition.value=="S")
	{
		if(str_type=="")
		{
			alert("Select Interest Type");
			return false;
		}
	}

	if(document.forms[0].selrating.value=="N" && str_type.indexOf("RATING@")!=-1)
	{
		alert("Rating Interest type is not applicable");
		return;
	}
	document.forms[0].hidInterestType.value=str_type;
	if(document.forms[0].chkcashmargin.checked==true)
	{
		document.forms[0].hidcashmargin.value="Y";
	}
	if(document.forms[0].chkcashmargin.checked==false)
	{
		document.forms[0].hidcashmargin.value="N";
	}
	if(document.forms[0].chkloanagainstshare.checked==true)
	{
		document.forms[0].hidloanagainstshare.value="Y";

		if(document.forms[0].chkloanagainstshare.checked==true && document.forms[0].loan_again_share.value == "" )
		{
			alert("Select the Type of Share");
			document.forms[0].loan_again_share.focus();
			return;
		}
		
	}
	else
	{
		document.forms[0].hidloanagainstshare.value="N";
		document.forms[0].loan_again_share.value = "";
	}

	if(document.forms[0].txt_expirydate.value=="")
	{
		  ShowAlert(111,'Expiry Date');
		  document.forms[0].txt_expirydate.focus();
		  return;
	}
	if(document.forms[0].sel_forexfac.value=="")
	{
		  ShowAlert(111,'Forex Facility');
		  document.forms[0].sel_forexfac.focus();
		  return;
	}
	if(document.forms[0].sel_digi.value=="")
	{
		  ShowAlert(111,'DIGI Product');
		  document.forms[0].sel_digi.focus();
		  return;
	}
	if(document.forms[0].sel_digiRating.value=="")
	{
		  ShowAlert(111,'DIGI rating ');
		  document.forms[0].sel_digiRating.focus();
		  return;
	}

	
		if(document.forms[0].sel_rating_pool.value==""||document.forms[0].sel_rating_pool.value=="S"){
		  ShowAlert(111,'Pool Based Rating ');
		  document.forms[0].sel_rating_pool.focus();
		  return;
		}
		if(trimtxt(document.forms[0].prd_mintermrest.value)=="")
		{
			alert("Enter the Min Loan Period");
			document.forms[0].prd_mintermrest.focus();
			return;
		}	
		if(trimtxt(document.forms[0].prd_maxtermrest.value)=="")
		{
			alert("Enter the Max Loan Period");
			document.forms[0].prd_maxtermrest.focus();
			return;
		}
		if(eval(document.forms[0].prd_maxtermrest.value)<= eval(document.forms[0].prd_mintermrest.value))
		{
			ShowAlert(153,"Minimum Repayment Period","Maximum Repayment Period");
			document.forms[0].prd_mintermrest.value="";
			document.forms[0].prd_mintermrest.focus();
			return;
		}
		if(trimtxt(document.forms[0].txt_holidayrest.value)=="")
		{
			alert("Enter the Holiday Period");
			document.forms[0].txt_holidayrest.focus();
			return;
		}
		if(eval(document.forms[0].prd_maxtermrest.value)<= eval(document.forms[0].txt_holidayrest.value))
		{
			ShowAlert(153,"Holiday Period","Maximum Repayment Period");
			document.forms[0].txt_holidayrest.value="";
			document.forms[0].txt_holidayrest.focus();
			return;
		}
	//document.forms[0].sel_digi.value=document.forms[0].hidDigiProd.value
	
	var varFacDesc="";
	
	for(var i=0;i<document.forms[0].sel_facdispdesc.options.length;i++)
	{
		if(document.forms[0].sel_facdispdesc.options[i].selected)
		{				
			varFacDesc=varFacDesc+document.forms[0].sel_facdispdesc.options[i].value+"@";
		}		
	} 
	if(document.forms[0].sel_CGTMSE.value=="S")
	 {
		 ShowAlert(112,"Mandatory CGTMSE");
		 document.forms[0].sel_CGTMSE.focus();
		 return;
	 }
	if(varFacDesc=="")
	{
		alert("Select Facility Display Description");
		return;
	}
	document.forms[0].hidFacDisplayDesc.value=varFacDesc;
	document.forms[0].cmdsave.disabled = true;
	var str_type="",indtype="";
	document.forms[0].seltype.disabled=false;
    document.forms[0].facility1.disabled=false;
	subIndex=0;
	document.forms[0].indtype.value = indtype;
	document.forms[0].hidBeanId.value="corporatefacility"
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setfacility.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="corporatefacility"
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setfacility.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/"+"comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function selectValues()
{
	var varloantype = document.forms[0].fac_loantype.options[document.forms[0].fac_loantype.selectedIndex].value;
	document.all.ifrmscheme.src=appUrl+"action/iframeschemecodecorp.jsp?hidBeanGetMethod=getSchemeCodeData&hidBeanId=setproducts&loantype="+varloantype;
}
function callProducts()
{
	if(document.forms[0].sel_facility.value.toUpperCase() == "A")
	{
		document.all.agr1.style.visibility = "hidden";
		document.all.agr1.style.position = "absolute";
		document.all.agr2.style.visibility = "hidden";
		document.all.agr2.style.position = "absolute";
		document.all.ast.style.visibility="visible";
		document.all.ast.style.position="relative";
		document.all.ast1.style.visibility="visible";
		document.all.ast1.style.position="relative";
	}
	else
	{
		document.all.agr1.style.visibility = "hidden";
		document.all.agr1.style.position = "absolute";
		document.all.agr2.style.visibility = "hidden";
		document.all.agr2.style.position = "absolute";
		document.all.ast.style.visibility="hidden";
		document.all.ast.style.position="absolute";
		document.all.ast1.style.visibility="hidden";
		document.all.ast1.style.position="absolute";
	}
}
function selsubheadcode()
{
	document.all.ifrmsubheadcode.src=appUrl+"action/iframesubheadcode.jsp?hidBeanGetMethod=getSchemesubheadCodeData&hidBeanId=setproducts&schemecode="+schemecode+"&subheadcode="+sel_schemeheadcode;
	
}
function funglsubcode()
{
	schemecode = document.forms[0].scheme_code.options[document.forms[0].scheme_code.selectedIndex].value;
	if(schemecode=="S")
	{
		schemecode=sel_emischcode;
	}
	if(schemecode=="BPGEN" || schemecode=="FBA")
	{
		document.all.glsubcode1.style.display = "block";
		document.all.glsubcode2.style.display = "block";
		selsubheadcode();
	}else{
		document.all.glsubcode1.style.display = "none";
		document.all.glsubcode2.style.display = "none";
	}
}

function checkloanshare()
{
if(document.all.chkloanagainstshare.checked==true)
{
	document.all.glsubcode2.style.display = "block";
	document.all.loan2.style.display = "table-cell";
	
}else if(document.all.chkloanagainstshare.checked==false)
{
	document.all.loan1.style.display = "none";
	document.all.loan2.style.display = "none";
	document.all.loan_again_share.value = "";
	
}
}
function chkintdef()
{
	if(document.forms[0].sel_intdefinition.value=="")
	{
		alert("select Interest Definition");
		return;
	}
}
function chkinttype()
{
	if(document.forms[0].sel_intdefinition.value=="M"||document.forms[0].sel_intdefinition.value=="F")
	{
		document.all.idint1.style.display="none";
		document.all.idint2.style.display="none";
		document.all.idint3.style.display="none";

		for(var i=0;i<document.forms[0].sel_interesttype.options.length;i++)
		{
			document.forms[0].sel_interesttype.options[i].selected=false;
		}
	}
	else
	{
		document.all.idint1.style.display="table-cell";
		document.all.idint2.style.display="table-cell";
		document.all.idint3.style.display="table-cell";
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
/*function chkrating(){
	if(document.forms[0].sel_bankscheme.value=="065"){
	document.all.id_rating.style.visibility = "visible";
	document.all.id_rating.style.position = "relative";
	document.all.id_rating1.style.visibility = "visible";
	document.all.id_rating1.style.position = "relative";
	}else{
		document.all.id_rating.style.visibility = "hidden";
		document.all.id_rating.style.position = "absolute";
		document.all.id_rating1.style.visibility = "hidden";
		document.all.id_rating1.style.position = "absolute";
	}
}*/
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placevalues();chkinttype();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">
if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div></div>
<form method="post" class="normal">
<iframe height="0" width="0" id="ifrmscheme" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" name="ifrmsubheadcode" frameborder="0" style="border:0"></iframe>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td valign="top" colspan="5">
		<jsp:include page="../share/help.jsp" flush="true"/>
		<jsp:include page="../share/menus.jsp" flush="true"/>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="1" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Facility</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">

</table>
<table width="98%" class="outertable" border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
	<td>
		<table border="0" cellspacing="0" cellpadding="5" width="100%" class="outertable">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
				<tr>
					<td>
						<table width="100%" border="0" cellspacing="5" cellpadding="3" class="outertable">
						<tr> 
							<td align="left">Facility Code</td>
							<td colspan="2"> 
								<input type="text" name="txt_code" size="25" readonly="readonly"
									value="<%=Helper.correctNull((String) hshValues.get("txt_code"))%>">
							</td>
							<td>&nbsp;Facility ID</td>
							<td colspan="2">
								<input type="text" name="fac_id" readonly="readonly" size="25"
									value="<%=Helper.correctNull((String) hshValues.get("fac_id"))%>">
							</td>
							<td align="left">Facility For <span class="mantatory">*</span> </td>
							<td align="left">
								<select name="sel_facility" onchange="callProducts()" style="width: 80%" tabindex="1">
									<option value="s" selected="selected">--Select--</option>
									<option value="c">Corporate</option>
									<option value="a">Agriculture</option>
								</select>
							</td>
						</tr>
						<tr>
							<td>Type of Loan&nbsp;<span class="mantatory">*</span></td>
							<td colspan="2"> 
								<select name="fac_loantype" tabindex="2" onChange="selectValues()" style="width: 140">
									<option value="0" selected="selected">---Select---</option>
									<option value="TL">Term Loan</option>
									<option value="DL">Demand Loan</option>
									<option value="OD">Over Draft</option>
<!--									<option value="CC">Cash Credit</option>-->
								</select>
							</td>
							<td>Scheme Code<span class="mantatory">*</span></td>
							<td colspan="2"> 
								<select name="scheme_code" style="width: 140" tabindex="3" onchange="funglsubcode();">
									<option value="S" selected="selected">-----select------</option>
								</select>
							</td>
							<td id="bus2">Nature of Facility</td>
							<td id="bus1"> 
								<select name="facility1" style="width: 80%" tabindex="4">
									<option value="0" selected="selected">--Select--</option>
									<option value="1">Working Capital</option>
									<option value="2">Term Loan</option>
								</select>
							</td>
						</tr>
						
						<tr>
						<td>Bank's Scheme&nbsp;<b><span class="mantatory">*</span>
						</b></td>
						<td colspan="5"><select name="sel_bankscheme">
							<option value="" selected="selected">&lt;----Select----&gt;</option>
                            <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
						</select></td>
						<td id="id_rating">pool based rating &nbsp;<b><span class="mantatory">*</span></b></td>
						<td id="id_rating1"><select name="sel_rating_pool">
							<option value="S" selected="selected">--Select--</option>
							<option value="Y">Yes</option>
							<option value="N">No</option>
                            
						</select></td>
						</tr>
						
						<tr> 
							<td align="left">Head of the Facility&nbsp;<span class="mantatory">*</span></td>
							<td colspan="5"> 
								<table width="80%" border="0" cellspacing="0" cellpadding="0">
								<tr>
									<td width="92%"> 
										<input type="text" name="txtcat_name" size="85" maxlength="99" readonly="readonly"
											value="<%=Helper.correctNull((String) hshValues.get("fac_parent"))%>">
									</td>
									<td width="1%">&nbsp;</td>
									<td width="6%">
										<span onClick="showProduct('FH')" STYLE="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="5">
										</span>
									</td>
								</tr>
								</table>
							</td>
							<td id="bus1">Type</td>
							<td>
								<select name="seltype" style="width: 140" tabindex="6">
									<option value='' selected="selected">----Select----</option>
									<option value="F">Funded</option>
									<option value="NF">Non Funded</option>
								</select>
							</td>
						</tr>
						<tr> 
							<td align="left">Facility&nbsp;<span class="mantatory">*</span></td>
							<td colspan="5"> 
								<table width="80%" border="0" cellspacing="0" cellpadding="0">
								<tr> 
									<td width="92%"> 
										<input type="text" name="txt_facility" size="85" maxlength="50" readonly="readonly"
											value="<%=Helper.correctNull((String) hshValues.get("fac_sub"))%>">
									</td>
									<td width="2%">&nbsp;</td>
									<td width="6%">
										<span onClick="showProduct('FS')" style="cursor: hand">
										<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" tabindex="7">
										</span>
									</td>
								</tr>
								</table>
								</td>
								<td><div id="glsubcode1">GL Sub Head code</div></td>
							<td >
								<div id="glsubcode2"><select name="selschemehead" style="width: 140" tabindex="6">
									<option value="S" selected="selected">----Select----</option>
								</select>
								</div>
							</td>
							<td align="left" id="agr1" style="visibility: hidden;position: absolute;">Agri Scheme&nbsp;<span class="mantatory">*</span> </td>
							<td align="left" id="agr2" style="visibility: hidden;position: absolute;">
								<select name="prd_type2" style="width: 80%" tabindex="8">
									<option selected="selected">----- Select ------</option>
								</select>
							</td>
						</tr>
						<tr> 
							<td align="left">Description <span class="mantatory">*</span></td>
							<td colspan="5"> 
								<input type="text" name="txt_descrip" size="75"
									maxlength="50" onKeyUp="changecase(this);" tabindex="9"
									value="<%=Helper.correctNull((String) hshValues.get("fac_descrip"))%>">
							</td>
							<td ><input type="checkbox" name="chkcashmargin" style="border-style:none" >&nbsp;100 % Cash Margin&nbsp;</td>
							<td ><input type="checkbox" name="chkloanagainstshare" style="border-style:none" onclick="checkloanshare()">&nbsp;Loan against Share facility&nbsp; </td>
						</tr>
						<tr > 
							<td align="left" id="ast">Scheme Type<span class="mantatory">*</span></td>
							<td colspan="2" id="ast1"> 
							<select name="sel_schemetype">
							<option value="0">--Select--</option>
										<option title="Kisan Credit Card Scheme" value="aQ">Kisan Credit Card Scheme</option>
										<option title="Farm Development" value="aV">Farm Development</option>
										<option title="Minor Irrigation" value="aO">Minor Irrigation</option>
										<option title="Farm Mechanisation" value="aM">Farm Mechanisation</option>
										<option title="Financing of Bullock Cart" value="aT">Financing of Bullock / Cart</option>
										<option title="Sericulture" value="aI">Sericulture</option>
										<option title="Tobacco Financing" value="aB">Tobacco Financing</option>
										<option title="Plantation & Horticulture" value="aH">Plantation & Horticulture</option>
										<option title="Farm Forestry" value="aY">Farm Forestry</option>
										<option title="Diary Farming" value="aD">Diary Farming</option>
										<option title="Poultry Development" value="aE">Poultry Development</option>
										<option title="Allied Activity" value="aR">Allied Activity</option>
										<option title="Gobar Gas plant" value="aN">Gobar Gas plant</option>
										<option title="Financing Fisheries" value="aJ">Financing Fisheries</option>
										<option title="Self Help Group" value="aS">Self Help Group</option>
										<option title="Advance Against Warehouse Receipt" value="aK">Advance Against Warehouse Receipt</option>				
										<option title="KCC (Restructure)" value="aC">KCC (Restructure)</option>				
							
							</select>								
							</td>
							<td>Select Repayment Type<b><span
							class="mantatory">*</span></b></td>
						<td colspan="3">
						<select multiple="multiple" name="sel_repaymenttype" size="10">
						<option value="E">EMI</option>
						<option value="NE">Non-EMI</option>	
						<option value="OD">On Demand</option>
			     		<option value="LC">As Per LC Terms</option>
			     		<option value="CO">As Per Contract Terms</option>
			     		<option value="BG">As Per BG Rules</option>										
			          	<option value="DD">On Due Date</option>
			          	<option value="PC">From the proceeds of PSC \ by realization of bill</option>
			          	<option value="PS">By Realization of Export Bills</option>
			          	<option value="PR">By Realization of Respective Bills</option>
			          	<option value="TG">As per TCBG Rules</option>
						</select>
						</td>
						<!--<td nowrap="nowrap">Whether CGTMSE applicable&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="sel_cg">
							<option value="S" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
						-->
						</tr>
						<tr>
							<td>Range From&nbsp;<span class="mantatory">*</span></td>
							<td colspan="2"> 
								<input type="text" name="prd_rng_from" maxlength="12" tabindex="10" size="25"
									style="text-align: right" onBlur="callRange(this)" onKeyPress="allowNumber(this)"
									value="<%=Helper.correctNull((String) hshValues.get("prd_rng_from"))%>">
							</td>
							<td>Range To&nbsp;<span class="mantatory">*</span></td>
							<td colspan="4"> 
								<input type="text" name="prd_rng_to" maxlength="12" tabindex="11" size="25"
									style="text-align: right" onblur="callRangeTo(this)" onkeypress="allowNumber(this)"
									value="<%=Helper.correctNull((String) hshValues.get("prd_rng_to"))%>">
							</td>
						</tr>
						<tr> 
							<td width="14%">Min. Loan Period <span class="mantatory">*</span></td>
							<td width="8%"> 
								<input type="text" align="top" name="prd_minterm" size="12" maxlength="4"
									onkeypress="allowInteger()" tabindex="12"
									value="<%=Helper.correctNull((String) hshValues.get("prd_minterm"))%>">
							</td>
							<td width="8%" align="left">(Months)</td>
							<td width="14%">Max. Loan Period&nbsp;<span class="mantatory">*</span></td>
							<td width="8%">
								<input type="text" align="top" name="prd_maxterm" size="12" maxlength="10"
									onkeypress="allowInteger()" tabindex="13"
									value="<%=Helper.correctNull((String) hshValues.get("prd_maxterm"))%>">
							</td>
							<td width="8%" align="left">(Months)</td>
							<td width="20%">&nbsp;</td>
							<td width="20%">&nbsp;</td>
						</tr>
						<tr>
							<td id="bus1">Holiday Period&nbsp;<span class="mantatory">*</span></td>
							<td id="bus2"> 
								<input type="text" name="txt_holiday" size="12" maxlength="4" tabindex="14"
									value="<%=Helper.correctNull((String) hshValues.get("txt_holiday"))%>">
							</td>
							<td>(Months)</td>
							<td id="bus2">Stop Product to User</td>
							<td>
								<select name="sel_stop" tabindex="15">
									<option value="0" selected="selected">No</option>
									<option value="1">Yes</option>
								</select>
							</td>
						</tr>
						<tr>
						<td>Select Interest rate frequency&nbsp;</td>
						<td><select name="selintrate" tabindex="18">
							<option value="M" selected="selected">Monthly</option>
								<option value="Q">Quartely</option>
								<option value="H">Half-yearly</option>
								<option value="Y">Yearly</option>
						</select></td>	
						<td>&nbsp;</td>
						<td>Whether Rating <span class="mantatory">*</span></td>
						<td>   <select name="selrating" tabindex="18">
						<option value="s" selected>--Select--</option>
								<option value="Y">Yes</option>
								<option value="N" >No</option>
								</select></td>
						</tr>
						<tr>
						<td nowrap;>Facility Creation Date&nbsp;</td>
						<td><input type="text" name="fac_intro_date" size="12"
							readonly="readonly"
							value="<%=Helper.correctNull((String) hshValues.get("com_faccreated_date"))%>">
						</td>
						<td>&nbsp;</td>
						<td nowrap;>Interest Definition&nbsp;<span class="mantatory">*</span></td>
						<td><select name="sel_intdefinition" onchange="chkinttype();">
						<option value=""><--select--></option>
						<option value="F">Fixed</option>
						<option value="S">Setup (Floating)</option>
						<option value="M">Reference Rate (Floating)</option>
						</select>
						</td>
						</tr>
						
								<tr>			
										<td id="" width="20%">Expiry Date<span class="mantatory">*</span></td>
										 <td width="21%" id="idexpirydatetxt"><input type="text" name="txt_expirydate"
													size="16" readonly="readonly"
													onBlur="checkmindate(this,document.forms[0].fac_intro_date.value)"
													value="<%=Helper.correctNull((String) hshValues.get("COM_FACILITY_EXPIRYDATE"))%>">
												<a alt="Select date from calender" id="expirydate"
													href="#" onClick="callCalender('txt_expirydate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
									</tr>
						
						<tr>
						<td id="idint1">Interest type</td>
						<td id="idint2"><select name="sel_interesttype" multiple="multiple" onclick="chkintdef();">
							<lapschoice:StaticDataTag apptype="219" />		
								</select>
						</td>
						<td id="idint3">&nbsp;</td>
						<td id="loan1" width="12%">Type of Share &nbsp;<span class="mantatory">*</span></td>
						 <td id="loan2"><select name="loan_again_share" tabindex="18">
							<option value="" selected>--Select--</option>
							<option value="P">Physical Form</option>
							<option value="D">Demat Form</option>
							</select>
						</td>
						
						<td id="digiid">Whether DIGI Product &nbsp;<span class="mantatory">*</span></td>
						<td><select name="sel_digi" >
						<option value=""><--Select--></option>
						<option value="N">No</option>
						<option value="Y">Yes</option>
						</select>
						<td id="digiid">Whether DIGI rating &nbsp;<span class="mantatory">*</span></td>
						<td><select name="sel_digiRating" >
						<option value=""><--Select--></option>
						<option value="N">No</option>
						<option value="Y">Yes</option>
						</select>
						</tr>
						<tr>
						<td>Facility Display Description</td>
						<td><select name="sel_facdispdesc" multiple="multiple" size="10">
							<lapschoice:StaticDataTag apptype="180" />		
								</select>
						</td>
						<td>Whether Forex Facility</td>
						<td><select name="sel_forexfac">
						<option value=""><--Select--></option>
						<option value="N">No</option>
						<option value="Y">Yes</option>
						</select></td>
						</tr>
						<tr>
						<tr>
					<td nowrap="nowrap">Min. Restructure Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_mintermrest"
							size="12" maxlength="4" style="text-align: right"
							onKeyPress="allowInteger();" tabindex="19"
							value="<%=Helper.correctNull((String) hshValues
									.get("COM_MINREPAYPERIOD_REST"))%>">
						</td>
						
						<td nowrap="nowrap">Max. Restructure Repayment Period (In Months) &nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" align="top" name="prd_maxtermrest" size="12"
							maxlength="4" style="text-align: right"
							onKeyPress="allowInteger();" tabindex="20"
							value="<%=Helper.correctNull((String) hshValues.get("COM_MAXREPAYPERIOD_REST"))%>">
						</td>
						</tr>
						<tr>
						<td nowrap="nowrap">Maximum restructure Holiday Period</td>
						<td><input type="text" name="txt_holidayrest" size="6" maxlength="3" onKeyPress="allowInteger();"
							value="<%=Helper.correctDoubleQuote((String) hshValues.get("COM_HOLIDAYPERIOD_REST"))%>" tabindex="21"></td>
						<td>Mandatory CGTMSE</td>
						<td><select name="sel_CGTMSE" onchange="">
							<option value="S" selected="selected"><--Select--></option>
							<option value="Y">Yes</option>
							<option value="N" >No</option>
						</select></td>	
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
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="prd_catid"> <input type="hidden" name="cat_id">
<input type="hidden" name="hidsno"> 
<iframe id="bussframe" width="0" height="0"></iframe> 
<input type="hidden" name="hidcat_facilitycorpid"> 
<input type="hidden" name="hidcat_id"> 
<input type="hidden" name="hidcat_parent"> 
<input type="hidden" name="indtype">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull((String) hshValues.get("fac_id"))%>">
<input type="hidden" name="fac_module" value="<%=strCorpModule%>">
<input type="hidden" name="prd_type">
<input type="hidden" name="hidAgrScheme" value="<%=strProductType%>">
<input type="hidden" name="hidcorp_faccode" value="<%=Helper.correctNull(request.getParameter("hidcorp_faccode"))%>">
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidcashmargin">
<input type="hidden" name="hidRepaymentType" value="<%=Helper.correctNull((String) hshValues.get("com_repaytype"))%>">
<input type="hidden" name="hidloanagainstshare" value="<%=Helper.correctNull((String) hshValues.get("com_loanagainstshares"))%>">
<input type="hidden" name="hidInterestType" value="<%=Helper.correctNull((String)hshValues.get("fac_interesttype")) %>">
<input type="hidden" name="hidDigiProd" value="<%=Helper.correctNull((String)hshValues.get("com_whtdigiprd")) %>">
<input type="hidden" name="hidFacDisplayDesc" value="<%=Helper.correctNull((String)hshValues.get("com_facdispdesc")) %>">
</form>
</body>
</html>
