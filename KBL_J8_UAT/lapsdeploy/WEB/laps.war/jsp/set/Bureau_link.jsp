<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);
String inwardno = Helper.correctNull((String) hshValues.get("BUR_APPNO"));
String strBureauDate=Helper.correctNull((String)hshValues.get("CREATED_DATE"));
if(strBureauDate.equalsIgnoreCase(""))
	strBureauDate=Helper.getCurrentDateTime();
%>
<html>
<head>
<title>ACKNOWLEDGEMENT SLIP</title>

<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var vargender="<%=Helper.correctNull((String) hshValues.get("BUR_GENDER"))%>";
var varcustType="<%=Helper.correctNull((String) hshValues.get("BUR_CUSTYPE"))%>";
var varprdType="<%=Helper.correctNull((String) hshValues.get("BUR_PRDTYPE"))%>";
var varMartstatus="<%=Helper.correctNull((String) hshValues.get("BUR_MARSTAT"))%>";
var varcreatedusr="<%=Helper.correctNull((String) hshValues.get("app_createdusr"))%>";
var varUsrID="<%=Helper.correctNull((String) session.getAttribute("strUserId"))%>";
var varhunterreq="<%=Helper.correctNull((String) hshValues.get("BUR_HUNTER_REQ"))%>";
var hunterbuttonflag="<%=Helper.correctNull((String) hshValues.get("hunterbuttonflag"))%>";
var hunterScore="<%=Helper.correctNull((String) hshValues.get("strtotalScore"))%>";
var varalertFlag="<%=Helper.correctNull((String) hshValues.get("alertFlag"))%>";
var varReportFlag="<%=Helper.correctNull((String) hshValues.get("strReportFlag"))%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	  	
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
//	document.forms[0].cmddetail.disabled=bool6;
}

function onload()
{	
	if(hunterbuttonflag=="Y")
	{
	document.forms[0].cmdgethunter.disabled=false;
	}
	else
	{
		document.forms[0].cmdgethunter.disabled=true;
	}
	if(varcustType!="")
	{
		document.forms[0].selcusttype.value=varcustType;
	}
	else
	{
		document.forms[0].selcusttype.value="0"
	}
	if(vargender!="")
	{
		document.forms[0].selgender.value=vargender;
	}
	else
	{
		document.forms[0].selgender.value="0";
	}
	changeLoanType('P');
	if(varprdType!="")
	{
		document.forms[0].prd_type2.value=varprdType;
	}
	else
	{
		document.forms[0].prd_type2.value="0";
	}
	if(varMartstatus!="")
	{
		document.forms[0].sel_martial_status.value=varMartstatus;
	}
	var inwardno=document.forms[0].txt_inwardno.value;
	document.forms[0].hidAction.value="insert";
	if(inwardno==""){
		enableButtons(true,false,true,true,false,false);
		showcustid();
		disableFields(false);
	}else{
		showcustid();
		disableFields(true);
		enableButtons(false,true,true,true,false,false);
		
	}
	document.forms[0].txt_inwardno.readOnly=true;
	document.forms[0].txt_date1.readOnly=true;
	if(inwardno!="" && varcreatedusr!=varUsrID)
	{
		document.forms[0].cmdedit.disabled=true;
	}

	if(document.forms[0].selcusttype.value=="E")
	{
		document.forms[0].txt_comncustame.className="finaclefieldsbgcolor";
		document.forms[0].txt_comDOB.className="finaclefieldsbgcolor";
		document.forms[0].selgender.className="finaclefieldsbgcolor";
		document.forms[0].sel_martial_status.className="finaclefieldsbgcolor";
		document.forms[0].txtcust_Aadharid.className="finaclefieldsbgcolor";
		document.forms[0].txtcomcust_pan.className="finaclefieldsbgcolor";
		document.forms[0].txtcomcust_mobile.className="finaclefieldsbgcolor";
		document.forms[0].txt_comcustadd1.className="finaclefieldsbgcolor";
		document.forms[0].txt_comcustadd2.className="finaclefieldsbgcolor";
		document.forms[0].txt_comcustcity.className="finaclefieldsbgcolor";
		document.forms[0].txt_comndist.className="finaclefieldsbgcolor";
		document.forms[0].txtcomcust_state.className="finaclefieldsbgcolor";
		document.forms[0].txtcomcust_zip.className="finaclefieldsbgcolor";
		document.forms[0].txt_country.className="finaclefieldsbgcolor";
		document.forms[0].txt_custFname.className="finaclefieldsbgcolor";
		document.forms[0].txt_cbscustid.className="finaclefieldsbgcolor";
		document.forms[0].txtcomcust_email.className="finaclefieldsbgcolor";
	}

	if(varhunterreq!="")
		document.forms[0].hunter_required.value=varhunterreq;
	if(document.forms[0].hunter_required.value=="Y")
		document.all.cmdgethunter.style.visibility="visible";
	else	
		document.all.cmdgethunter.style.visibility="hidden";

	if(varhunterreq=="Y")
	{
		document.all.id_hunterScore.style.visibility="visible";
	}
	else
	{
		document.all.id_hunterScore.style.visibility="hidden";
	}
	

	if(hunterScore=="" && varalertFlag=="Y")
		alert("Please try again later");
	
}	

function showhide()
{	
if(document.forms[0].selcusttype.value=="E")
{
	document.all.idtest.style.visibility="hidden";
	document.all.exist.style.visibility="hidden";
	document.all.iddistrict.style.display="none";
	document.all.Country.style.visibility="hidden";
}
else
{
	document.all.idtest.style.visibility="visible";
	document.all.exist.style.visibility="visible";
	document.all.iddistrict.style.display="inline";
	document.all.Country.style.visibility="visible";
}	
}

function validateno(obj)
{
	var re = new RegExp('^[a-zA-Z]{3}[0-9]{6}$');

	if(obj.value!="")
	{
		if(obj.value.match(re))
		{
			return true;
		}
		else
		{
			alert("Invalid Format.\n Lead Number should be 9 characters.\nFirst three digits should be Alpha and next 6 digits should be number ");
			obj.value="";
			obj.focus();
			return false;
		}
	}
}
function callReport()
{
	  document.forms[0].hidBeanId.value="perapplicant"
	  document.forms[0].hidBeanGetMethod.value="getCIBILReport";		
	  document.forms[0].action=appURL+"action/Bureau_link_report.jsp";
	  document.forms[0].submit();
}
function callDescCBS()
{	
	if(document.forms[0].selcusttype.value=="E" && document.forms[0].cmdsave.disabled==false){
	var varQryString = appURL+"action/CBSIDhelp.jsp?hidPagename=BUR";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
	}
}
function disableFields(val)
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
		}
		else if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=val;		
		}
	}
	document.forms[0].txtcomcust_state.readOnly=true;
	document.forms[0].txt_comndist.readOnly=true;
	document.forms[0].txt_country.readOnly=true;
	document.forms[0].txt_comcustcity.readOnly=true;
	document.forms[0].txt_comDOB.readOnly=true;
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(document.forms[0].elements[i].name!="" && document.forms[0].elements[i].name!="txt_date1")
			{
				document.forms[0].elements[i].value="";
			}
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].value="0";		  
		}
	}
	
}
function doPrint()
{
	var varinwardno = document.forms[0].txt_inwardno.value;
	var purl =appURL+"action/appinwardackprint.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getBureauData&inwardno="+varinwardno;
	var prop = 'scrollbars=yes,menubar=yes,width=775,height=520';	
	var xpos = (screen.width - 775) / 2;
	var ypos = (screen.height - 520) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,'title',prop);
}
function doClose()
{
	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
	 	document.forms[0].submit();
	}
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
} 
function doCancel()
{	
 	if(ConfirmMsg(102))
	 {
 			document.forms[0].hidBeanId.value="BureauLink"
 			document.forms[0].hidBeanGetMethod.value="getBureauData";
 			document.forms[0].hidSourceUrl.value="/action/Bureau_link.jsp";
 			document.forms[0].submit();
	 }
}
function doDelete()
{
	if(varReportFlag!="Y")
	{
		if(ConfirmMsg(101))
		{
			document.forms[0].hidAction.value="delete"
				document.forms[0].hidBeanId.value="BureauLink"
				document.forms[0].hidBeanMethod.value="updateBureauData";
				document.forms[0].hidBeanGetMethod.value="getData";
				document.forms[0].action=appURL+"controllerservlet";
				document.forms[0].hidSourceUrl.value="/action/Bureau_link_Search.jsp";
				document.forms[0].submit();
		}
	}
	else
	{
		alert("After generation of bureau report, you are not allowed to delete the proposal");
		return;
	}
}
function showCitySearch(val1)
{
	if(val1 == "INWARD")
	{
		if(document.forms[0].cmdsave.disabled==false)
		{
			var varQryString = appURL+"action/searchCity.jsp?inward="+val1;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
	}
}

function showcustid()
{
	var custvalue=document.forms[0].selcusttype.value;
	if(document.forms[0].selcusttype.value=="E" )
	{
		document.all.custid.style.visibility="visible";
		document.all.custid.style.position="relative";
		document.all.custid1.style.visibility="visible";
		document.all.custid1.style.position="relative";
		document.forms[0].txt_cbscustid.readOnly=true;
		disableFields(true);
		document.forms[0].selcusttype.disabled=false;
		document.forms[0].txtcust_Aadharid.readOnly=false;
		document.forms[0].selgender.disabled=false;
		document.forms[0].prd_type2.disabled=false;
		document.forms[0].txt_reqAmount.readOnly=false;
		document.forms[0].txt_tenor.readOnly=false;
	}
	else
	{
		disableFields(false);
		document.all.custid.style.visibility="hidden";
		document.all.custid.style.position="absolute";
		document.all.custid1.style.visibility="hidden";
		document.all.custid1.style.position="absolute";
	}
	document.forms[0].selcusttype.value=custvalue;
}

function doEdit()
{
	if(document.forms[0].selcusttype.value=="N"){
		disableFields(false);
		}else{
			disableFields(true);
			document.forms[0].selcusttype.disabled=false;
		}
	document.forms[0].hidAction.value="update";
	document.forms[0].prd_type2.disabled=false;
	document.forms[0].txt_reqAmount.readOnly=false;
	document.forms[0].txt_tenor.readOnly=false;
	document.forms[0].txt_inwardno.disabled=true;
	document.forms[0].txt_date1.readOnly=true;
	document.forms[0].hunter_required.disabled=false;
 	enableButtons(true,false,false,false,true,false);

}
function doSave(){	
	if(document.forms[0].selcusttype.value=="0")
	{
		ShowAlert(111,'Type of Borrower');
		document.forms[0].selcusttype.focus();
		return;
	}
	if(document.forms[0].selcusttype.value!="N" && document.forms[0].txt_cbscustid.value=="")
	{
		ShowAlert(121,'CBS Cust ID');
		document.forms[0].txt_cbscustid.focus();
		return;
	}
	if(document.forms[0].selcusttype.value!="E")
	{
		if(document.forms[0].txt_comncustame.value=="")
		{
			ShowAlert(121,'Name');
			document.forms[0].txt_comncustame.focus();
			return;
		}
		if(document.forms[0].txt_custFname.value=="")
		{
			ShowAlert(121,'Father Name');
			document.forms[0].txt_custFname.focus();
			return;
		}
		if(document.forms[0].prd_type2.value=="0")
		{
			ShowAlert(111,'Product Type');
			document.forms[0].prd_type2.focus();
			return;
		}
		if(document.forms[0].txt_reqAmount.value=="" || document.forms[0].txt_reqAmount.value=="0.00")
		{
			ShowAlert(121,'Amount Required');
			document.forms[0].txt_reqAmount.focus();
			return;
		}
		if(document.forms[0].txt_tenor.value=="" ||document.forms[0].txt_tenor.value=="0" )
		{
			ShowAlert(121,'Tenor');
			document.forms[0].txt_tenor.focus();
			return;
		}
		if(document.forms[0].txt_comDOB.value=="")
		{
			ShowAlert(121,'Date of Birth ');
			document.forms[0].txt_comDOB.focus();
			return;
		}
		if(document.forms[0].selgender.value=="0")
		{
			ShowAlert(111,'Gender');
			document.forms[0].selgender.focus();
			return;
		}
		if(document.forms[0].sel_martial_status.value=="0")
		{
			ShowAlert(111,'Marital status');
			document.forms[0].sel_martial_status.focus();
			return;
		}
		/*if(document.forms[0].txtcust_Aadharid.value=="")
		{
			ShowAlert(121,'Aadhaar No ');
			document.forms[0].txtcust_Aadharid.focus();
			return;
		}*/
		
		if(document.forms[0].txtcomcust_pan.value=="")
		{
			ShowAlert('121','PAN/TAN No.');
			document.forms[0].txtcomcust_pan.focus();
			return;
		}
		if(document.forms[0].txtcomcust_mobile.value=="")
		{
			ShowAlert('121','Mobile No.');
			document.forms[0].txtcomcust_mobile.focus();
			return;
		}
	}
	if(document.forms[0].txt_comcustadd1.value=="")
	{
		ShowAlert(121,'Address 1');
		document.forms[0].txt_comcustadd1.focus();
		return;
	}
	if(document.forms[0].txt_comcustadd2.value=="")
	{
		ShowAlert(121,'Address 2');
		document.forms[0].txt_comcustadd2.focus();
		return;
	}
	if(document.forms[0].txt_comcustcity.value=="")
	{
		ShowAlert(111,'City');
		return;
	}
	if(document.forms[0].txt_comndist.value=="")
	{
		if(document.forms[0].selcusttype.value!="E")
		{
			ShowAlert(111,'District');
			document.forms[0].txt_comndist.focus();
			return;
		}
		else
		{
			alert("District Field is Blank, Kindly update all the mandatory field in customer profile and then proceed");
			return;
		}
	}
	if(document.forms[0].txtcomcust_state.value=="")
	{
		ShowAlert(111,'State');
		return;
	}
	if(document.forms[0].txtcomcust_zip.value=="")
	{
		ShowAlert(121,'Pin code');
		document.forms[0].txtcomcust_zip.focus();
		return;
	}	
	if(document.forms[0].txt_country.value=="")
	{
		ShowAlert(111,'Country');
		document.forms[0].txt_country.focus();
		return;
	}
		document.forms[0].selgender.disabled=false;
		document.forms[0].prd_type2.disabled=false;
		document.forms[0].sel_martial_status.disabled=false;
		document.forms[0].selgender.value=document.forms[0].selgender.options[document.forms[0].selgender.selectedIndex].value;
		document.forms[0].hidBeanId.value="BureauLink";
		document.forms[0].hidBeanMethod.value="updateBureauData";
		document.forms[0].hidBeanGetMethod.value="getBureauData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/Bureau_link.jsp";
		document.forms[0].submit();
	
}
function callCntrySearch1(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value=="")
	{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
	}
	
}
function changeLoanType(val)
{	 
 	if(val=="A")
 	{
	 	document.forms[0].prd_type2.length=22;
	 	document.forms[0].prd_type2.options[1] = new Option('Poultry Boiler','A');
	 	document.forms[0].prd_type2.options[2] = new Option('Bullock Cart','B');
        document.forms[0].prd_type2.options[3] = new Option('Crop Loans','C');
        document.forms[0].prd_type2.options[4] = new Option('Diary Farming','D');
        document.forms[0].prd_type2.options[5] = new Option('Animal Rearing','E');
        document.forms[0].prd_type2.options[6] = new Option('Farm Machinery','F');
        document.forms[0].prd_type2.options[7] = new Option('Gobar Gas Plant','G');
        document.forms[0].prd_type2.options[8] = new Option('Gold Loan','H');
        document.forms[0].prd_type2.options[9] = new Option('Consumption Loan','I');
        document.forms[0].prd_type2.options[10] = new Option('Sericulture','J');
        document.forms[0].prd_type2.options[11] = new Option('Loan Against Warehouse Receipts','L');
        document.forms[0].prd_type2.options[12] = new Option('Vehicle Loan','M');
        document.forms[0].prd_type2.options[13] = new Option('Fisheries','N');
        document.forms[0].prd_type2.options[14] = new Option('Poultry Layering','P');
        document.forms[0].prd_type2.options[15] = new Option('Plantation Term Loan','Q');
        document.forms[0].prd_type2.options[16] = new Option('Loan Against deposit','R');
		document.forms[0].prd_type2.options[17] = new Option('Minor Irrigation','U');
		document.forms[0].prd_type2.options[18] = new Option('Common Product','K');
		document.forms[0].prd_type2.options[19] = new Option('Union General Crcmdedit Card','V');
		document.forms[0].prd_type2.options[20] = new Option('Purchase of fodder','T');
		document.forms[0].prd_type2.options[21] = new Option('Union Bhumiheen Card','W');
        document.forms[0].prd_type2.options[22] = new Option('Coffee Plantation','O'); 
		//document.forms[0].sel_staffloan.value="N";
		//showratios();

     }
  	if(val=="P")
	{
		document.forms[0].prd_type2.length=17;
		document.forms[0].prd_type2.options[1] = new Option('Housing Loan','H');
		document.forms[0].prd_type2.options[2] = new Option('Salaried Person','P');
		document.forms[0].prd_type2.options[3] = new Option('Vehicle Loan','A');
		//document.forms[0].prd_type2.options[4] = new Option('Consumer Durables Loan','D');
		document.forms[0].prd_type2.options[4] = new Option('Mortgage Loan','M');
        //document.forms[0].prd_type2.options[7] = new Option('Health Loan','I');
        document.forms[0].prd_type2.options[5] = new Option('Gold Loan','G');
       // document.forms[0].prd_type2.options[9] = new Option('Top Up','T');
        //document.forms[0].prd_type2.options[10] = new Option('Smiles Loan','O');
        document.forms[0].prd_type2.options[6] = new Option('Loan against Deposits','R');
        document.forms[0].prd_type2.options[7] = new Option('Mahila Udyog','U');
        document.forms[0].prd_type2.options[8] = new Option('Ravi Kiran','K');
        document.forms[0].prd_type2.options[9] = new Option('Education Loan','E');
        document.forms[0].prd_type2.options[10] = new Option('Leased Loan','L');
        document.forms[0].prd_type2.options[11] = new Option('Instacash Loan','I');
        document.forms[0].prd_type2.options[12] = new Option('Clean Loan','C');
        document.forms[0].prd_type2.options[13] = new Option('NSC Loan','N');
        document.forms[0].prd_type2.options[14] = new Option('Suvidha','V');
        document.forms[0].prd_type2.options[15] = new Option('General Loan','J');
        document.forms[0].prd_type2.options[16] = new Option('Loan Against Shares','S');
       // showratios();
 	}
}

function showDistSearch(val)
{  

	var varstate = document.forms[0].hid_state.value;
	if(document.forms[0].cmdsave.disabled==false)
	{
	if(document.forms[0].hid_state.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_comcustcity.focus();
		return;
	}
	if(document.forms[0].txt_comcustcity.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_comcustcity.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(document.forms[0].elements[i].name!="txt_inwardno" && document.forms[0].elements[i].name!="txt_date1")
			{
				document.forms[0].elements[i].value="";
			}
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
		document.forms[0].selgender.value="0";
		
	}
}
function callAadcheck(){

	if(document.forms[0].txtcust_Aadharid.value!="")
	{
	var varlen=document.forms[0].txtcust_Aadharid.value.length;
	if(varlen<12){
		alert("Please Enter valid Aadhaar No");
		document.forms[0].txtcust_Aadharid.focus();
		document.forms[0].txtcust_Aadharid.value="";
		return;
	}
	}
}
function callHunter(){

	document.forms[0].hidBeanId.value="DigitalAppInterface";
	//document.forms[0].hidBeanMethod.value="updateBureauData";
	document.forms[0].hidBeanGetMethod.value="hunterService";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/Bureau_link.jsp";
	document.forms[0].submit();
	
}

</script>
</head>
<body onLoad="onload();">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}

</script>
</div></div>
<form method="post" name="facility" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Applicant Details</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="70%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr> 
            <td width="10%" align="center" class="sub_tab_active"><b>Applicant Details</b></td>
            <td align="center" width="10%" class="sub_tab_inactive"><b><a href="javascript:callReport()">Bureau Report</a></b> </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="2"
			class="outertable" align="center">
			<tr style="color: #942188;">
				<td valign="top">Proposal No&nbsp;</td>
				<td><input type="text" name="txt_inwardno" size="15"
					maxlength="20" tabindex="0" style="border: none"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_APPNO"))%>"
					onKeyPress="allowInteger()"></td>
					<td width="15%">&nbsp;</td>					
				<td>Date:</td>
				<td><input type="text" name="txt_date1"
					value="<%=strBureauDate%>"
					size="13" maxlength="10" tabindex="1" onBlur="checkDate(this)"></td>
			</tr>
			<tr>
				<td valign="top" colspan="5"> <B><span style="font-size: 14px;"> Customer Information&nbsp;</b></td>
			</tr>
			<tr>
				<td>Type of Borrower<span class="mantatory">*</span></td>
				<td width="34%"><select name="selcusttype"
					onchange="showcustid();showhide()">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<option value="N">New Connection</option> 
					<option value="E">Existing Customer</option>
				</select></td>
					<td>&nbsp;</td>	
				<td width="13%" id="custid">CBS Cust ID<span class="mantatory">*</span></td>
				<td width="34%" id="custid1"><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String) hshValues.get("BUR_CBSID"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
			</tr>
			<tr>
				<td valign="top" width="25%">Name<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_comncustame" size="50"
					maxlength="50" tabindex="1"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_FNAME"))%>"
					onKeyPress="notAllowSplChar1(this)"></td>
					<td>&nbsp;</td>	
					<td>Product Type<span class="mantatory">*</span></td>
						<td>
						<select name="prd_type2" onclick="" style="width: 150"
							onChange="" tabindex="2">
							<option value="0" selected="selected">----- Select ------</option>
					</select></td>
				
				</tr>
				<tr>
				<td valign="top" width="25%">Father Name <span class="mantatory">*</span></td>
				<td><input type="text" name="txt_custFname" size="50"
					maxlength="50" tabindex="1"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_FATHERNAME"))%>"
					onKeyPress="notAllowSplChar1(this)"></td>
					<td>&nbsp;</td>	
					<td>Marital Status&nbsp;</td>	
					<td><select name="sel_martial_status">
                    <option value="0">---Select-----</option>
                    <lapschoice:CBSStaticDataNewTag apptype='3' />
                  </select>
                </td>
				</tr>
				<tr>
				<td valign="top" width="25%">Amount Required<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_reqAmount" size="25"
					maxlength="15" tabindex="" onblur="roundtxt(this)"
					value="<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) hshValues.get("BUR_REQAMNT"))))%>"
					onKeyPress="allowNumber(this);" style="text-align: right;"></td>
				<td>&nbsp;</td>	
				<td valign="top" width="25%">Tenor(In Months)<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_tenor" size="25"
					maxlength="3" tabindex=""
					value="<%=Helper.correctNull((String) hshValues.get("BUR_TENOR"))%>"
					onKeyPress="allowInteger();"></td>
				</tr>
			<tr id="id_gender">
				<td>Gender<span class="mantatory">*</span></td>
				<td width="34%"><select name="selgender">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<option value="M">Male</option>
					<option value="F">Female</option>
					<option value="O">Others</option>
				</select></td>
				<td>&nbsp;</td>	
				<td valign="top">Aadhaar No</td>
				<td valign="top"><input type="text"
					name="txtcust_Aadharid" size="25" onblur="callAadcheck()"
					onKeyPress="allowNumber(this);notAllowSpace()" maxlength="12" 
					tabindex="5"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_AADHAR"))%>"
					onKeyPress="notAllowedDouble()"></td>
			</tr>
			<tr>
				<td valign="top" width="25%">Date of Birth  <span class="mantatory">*</span></td>
				<td valign="top" width="28%">
				<table>
				<tr>
				<td><input type="text"
					name="txt_comDOB"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_DOB"))%>"
					size="13" maxlength="10" tabindex="2"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
				</td>
				<td id="exist"><a alt="Select date from calender"
					href="javascript:callCalender('txt_comDOB')"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" tabindex="3"></a></td>
				</tr>
				</table>
				</td>
						<td>&nbsp;</td>	
				<td valign="middle" width="13%" id="id_pan_lbl">
				PAN/TAN No.<span class="mantatory" id="id_pan">*</span></td>
				<td width="34%" id="id_pan_txt"><input type="text"
					name="txtcomcust_pan" size="15" maxlength="10"
					tabindex="4" value="<%=Helper.correctNull((String) hshValues.get("BUR_PANNO"))%>"
					onblur="validatePANNO(document.forms[0].txtcomcust_pan)"></td>
			</tr>
			<tr id="id_passport">
				
					<td valign="top" width="13%">E - mail&nbsp;</td>
				<td width="34%"><input type="text" name="txtcomcust_email"
					size="30" maxlength="30"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_EMAIL"))%>"
					tabindex="11"></td>
					<td>&nbsp;</td>	
				<td valign="top" width="13%">City<span class="mantatory">*</span></td>
				<td width="34%" >
				<table><tr>
				<td>
				<input type="text" name="txt_comcustcity"
					tabindex="7"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_CITY"))%>" 
					onKeyPress="notAllowSplChar()" size="25" maxlength="20"> <input
					type="hidden" name="hidcity"
					value="<%=Helper.correctNull((String) hshValues
							.get("BUR_CITYCODE"))%>" />
				</td>
				<td id="idtest" ><a href="#"
					onClick="showCitySearch('INWARD')"
					style="cursor: hand" tabindex="8"> <img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></a></td>
				</tr></table>
					</td>
			</tr>
			<tr>
				<td valign="top" width="25%">Address<span class="mantatory">*</span></td>
				<td valign="top" width="28%"><input type="text"
					name="txt_comcustadd1" size="50" maxlength="50" tabindex="5"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_ADDRESS1"))%>">
				</td>
				<td>&nbsp;</td>	
				<td>District<span class="mantatory">*</span></td>
										<td><input type="text" name="txt_comndist" size="25" value="<%=Helper.correctNull((String) hshValues.get("BUR_DIST"))%>" 
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()" >
										&nbsp;<a href="#" id="iddistrict"
													onClick="showDistSearch('INWARD');"
													style="cursor:hand" tabindex="22" id="iddistrict"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></a>
											<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get("BUR_DISTCODE")) %>"></td>
				</tr>
			<tr>
				<td valign="top" width="25%">&nbsp;</td>
				<td valign="top" width="28%"><input type="text"
					name="txt_comcustadd2" size="50" maxlength="50" tabindex="6"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_ADDRESS2"))%>"
					onKeyPress="notAllowedDouble()"></td>
					<td>&nbsp;</td>	
				<td valign="top" width="13%">State<span class="mantatory">*</span></td>
				<td width="34%"><input type="text" name="txtcomcust_state"
					size="25" maxlength="25" tabindex="9"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_STATE"))%>"
					onKeyPress="notAllowSplChar()"
					onBlur="changecase(document.forms[0].txtcomcust_state)"> <input
					type="hidden" name="hidstate"
					value="<%=Helper.correctNull((String) hshValues
							.get("BUR_STATECODE"))%>" />
				<input type="hidden" size="5" name="hid_state" value="<%=Helper.correctNull((String) hshValues
							.get("BUR_STATECODE"))%>">
			</tr>
			<tr>
				<td valign="top" width="25%">Pin code<span class="mantatory">*</span></td>
				<td valign="top" width="28%"><input type="text"
					name="txtcomcust_zip" size="12"
					maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="10"
					style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_ZIP"))%>"
					onKeyPress="allowInteger()">
				</td>
				<td>&nbsp;</td>	
				<td>Country<span class="mantatory">*</span></td>
						<td><input type="text" name="txt_country" tabindex="17"
									size="25" value="<%=Helper.correctNull((String) hshValues.get("BUR_COUNTRY"))%>">
									<input type="hidden" name="hid_country" value="<%=Helper.correctNull((String) hshValues.get("BUR_COUNTRYCODE"))%>">
									 <a href="#" id="Country"
													onClick="callCntrySearch1('txt_country','hid_country')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> </td>
			</tr>
			<tr>
			<td valign="top" width="25%">Mobile No.<span class="mantatory">*</span></td>
				<td valign="top" width="28%"><input type="text"
					name="txtcomcust_mobile" size="12"
					maxlength="10" tabindex="10"
					value="<%=Helper.correctNull((String) hshValues.get("BUR_MOBILE"))%>"
					onKeyPress="allowInteger()">
				</td>
				<td>&nbsp;</td>	
			</tr>
				
			</tr>
			
		</table>
		
		</td>
	</tr>
	
</table>

<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2"	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="2"	class="outertable" align="center">
			<tr>
				<td colspan="2">  <B><span style="font-size: 14px;"> Hunter Details </b> </td>
			</tr>		
			<tr>
				<td width="20%">Hunter Score Required<span class="mantatory" id="cibil_req">*</span></td>
				<td><select name="hunter_required">
					<option value="N">No</option>
					<option value="Y">Yes</option>
				</td>
				<td align="center"><input type="button" class="buttonOthers" name="cmdgethunter" value="Fetch Hunter Score" onclick="callHunter()"> &nbsp;</td>
				<td rowspan="2" id="id_hunterScore">
					<table width="%" border="0" cellspacing="0" cellpadding="2"	class="outertable" align="center">
						<tr>
							<td > Hunter Score </td>
							<td> : <span style="color: #7a4d98"><%=Helper.correctNull((String) hshValues.get("BUR_HUNTER_SCORE"))%>  </span>  </td>
						</tr>
						<tr>
							<td> Hunter Fetch date </td>
							<td> : <span style="color: #7a4d98"><%=Helper.correctNull((String) hshValues.get("BUR_HUNTER_FETCH_DATE"))%>  </span>  </td>
						</tr>
						
					</table>
				</td>
			</tr>
		
		</table>
		</td>
	</tr>
</table>	

		
			
			
<table width="20%" border="0" cellspacing="0" align="center" cellpadding="3" class="outertable">
<tr align="center">
<br><td>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />

</td>
<br>
<lapschoice:hiddentag pageid='BureauReport' />
</tr> 
</table>
<input type="hidden" name="hidBRappno" value="<%=inwardno%>">
<input type="hidden" name="hidgender">
<input type="hidden" name="hid_perapp_id" value="<%=Helper.correctNull((String) hshValues.get("BUR_PERAPPID"))%>">
<iframe height="0" width="0" id="ifrstate" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder="0"	style="border: 0"></iframe>

</form>
</html>