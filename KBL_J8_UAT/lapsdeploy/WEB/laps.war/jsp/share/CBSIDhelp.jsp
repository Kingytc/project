<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	String strSno = Helper.correctNull((String)request.getParameter("varSno"));
	if(strSno.equalsIgnoreCase(""))
	{
		strSno = Helper.correctNull((String)hshValues.get("varSno"));
	}

	String pagename=Helper.correctNull((String)request.getParameter("pagename"));
	
	if(pagename.equalsIgnoreCase(""))
		pagename=Helper.correctNull((String)request.getParameter("hidPagename"));

	String strAppVar=Helper.correctNull((String)request.getParameter("strAppVar"));
	String strappstatus = Helper.correctNull((String)hshValues.get("appstatus"));
	String appno = Helper.correctNull((String)hshValues.get("appno"));
%>
<html>
<head>
<title>CBS ID SEARCH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varSno = "<%=strSno%>";
var pagename1="<%=pagename%>";
var varappstatus="<%=strappstatus%>";
var varappno="<%=appno%>";

var strAppVar1 = "<%=Helper.correctNull((String)hshValues.get("strAppVar"))%>";

function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25,val26,val27,val28,val29,val30,val31)
{
	if(pagename1=="LAR" || pagename1=="BUR"){
			if(val26=="Y"){
				alert("Kindly click on modify in customer profile and update latest details before proceeding");
				return;
			}
			if(val31=="MIGR")
			{
				alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile before creating LAR");
				return;
			}
		}
	if(pagename1=="appdocumentsinter"){
		window.opener.document.forms[0].txt_cbscustid.value=val0;
		window.close();
		return;
	}
	else if(pagename1=="rep"){
		window.opener.document.forms[0].idacno.value=val0;
		window.opener.document.forms[0].txt_cusname.value=val1;
		window.close();
		return;
	}
	else if(pagename1=="DeviationParameter"){

		var varAlerts="";
		if(val31=="MIGR")
		{
			alert("Please modify occupation code in Finacle - CRM and then visit LAPS customer profile before creating LAR");
			return;
		}
		
		if(val23=="")
		{
			varAlerts=varAlerts+'Fill Title in Customer Profile\n'; 
		}
		if(val1=="")
		{
			varAlerts=varAlerts+'Fill Name of the applicant in Customer Profile\n';
		}
		if(val3=="" || val8=="" || val14=="" || val13=="" || val5=="" || val12=="" || val20=="" || val6=="")
		{
			varAlerts=varAlerts+'Fill Address of the applicant in Customer Profile\n';
		}
		if(val1=="")
		{
			varAlerts=varAlerts+'Fill Name of the applicant in Customer Profile\n';
		}
		if(val15=="")
		{
			varAlerts=varAlerts+'Fill Phone Number in Customer Profile\n';
		}
		if(val24=="")
		{
			varAlerts=varAlerts+'Fill Constitution in Customer Profile\n';
		}
		if(val25=="")
		{
			varAlerts=varAlerts+'Fill Nature of the Activity(Proposal Description) in Customer Profile - KYC Norms tab\n';
		}
		if(varAlerts!="")
		{
			alert(varAlerts);
			return;
		}
	
		window.opener.document.forms[0].txt_cbscustid.value=val0;
		window.close();
		return;
	}
	else if(pagename1=="sec_furniture"||pagename1=="sec_plantmachinery"){
       
        window.opener.document.forms[0].txt_cbscustid.value=val0;
        window.opener.document.forms[0].sel_salutation.value=val23;
        window.opener.document.forms[0].sel_salutation.disabled=true;
        window.opener.document.forms[0].txt_belongsto.value=val1;
        window.opener.document.forms[0].txt_belongsto.readOnly=true;
 		window.opener.document.forms[0].txt_add1.value=val3;
 		window.opener.document.forms[0].txt_add1.readOnly=true;
 		window.opener.document.forms[0].txt_add2.value=val8;
 		window.opener.document.forms[0].txt_add2.readOnly=true;
 		window.opener.document.forms[0].txt_locationdistrict.value=val14;
 		window.opener.document.forms[0].hid_locationdistrict.value=val13;
 		window.opener.document.forms[0].txt_locationstate.value=val5;
 		window.opener.document.forms[0].hid_locationstate.value=val12;
        window.opener.document.forms[0].txt_locationcountry.value=val20;
 		window.opener.document.forms[0].hid_locationcountry.value=val19;
 		window.opener.document.forms[0].txt_locationcity.value=val4;
 		window.opener.document.forms[0].hid_locationcity.value=val11;
 		window.opener.document.forms[0].txt_pincode.value=val6;
 		window.close();
 		return;
 	}
	 else if(pagename1=="sec_vehicle"){
        
        window.opener.document.forms[0].txt_cbscustid.value=val0;
        window.opener.document.forms[0].sel_salutation.value=val23;
        window.opener.document.forms[0].sel_salutation.disabled=true;
        window.opener.document.forms[0].txt_belongsto.value=val1;
        window.opener.document.forms[0].txt_belongsto.readOnly=true;
 		window.opener.document.forms[0].txt_address1.value=val3;
 		window.opener.document.forms[0].txt_address1.readOnly=true;
 		window.opener.document.forms[0].txt_address2.value=val8;
 		window.opener.document.forms[0].txt_address2.readOnly=true;
 		window.opener.document.forms[0].txt_district.value=val14;
 		window.opener.document.forms[0].hid_district.value=val13;
 		window.opener.document.forms[0].txt_state.value=val5;
 		window.opener.document.forms[0].hid_state.value=val12;
        window.opener.document.forms[0].txt_country.value=val20;
 		window.opener.document.forms[0].hid_country.value=val19;
 		window.opener.document.forms[0].txt_city.value=val4;
 		window.opener.document.forms[0].hid_city.value=val11;
 		window.opener.document.forms[0].txt_pin.value=val6;
 		window.close();
 		return;
 	}
	 else if(pagename1=="sec_stock"){
        
        window.opener.document.forms[0].txt_cbscustid.value=val0;
        
        window.opener.document.forms[0].sel_salutation.value=val23;
        window.opener.document.forms[0].sel_salutation.disabled=true;
        window.opener.document.forms[0].txt_belongsto.value=val1;
        window.opener.document.forms[0].txt_belongsto.readOnly=true;
 		window.opener.document.forms[0].txt_address1.value=val3;
 		window.opener.document.forms[0].txt_address1.readOnly=true;
 		window.opener.document.forms[0].txt_address2.value=val8;
 		window.opener.document.forms[0].txt_address2.readOnly=true;
 		window.opener.document.forms[0].txt_district.value=val14;
 		window.opener.document.forms[0].hid_district.value=val13;
 		window.opener.document.forms[0].txt_state.value=val5;
 		window.opener.document.forms[0].hid_state.value=val12;
        window.opener.document.forms[0].txt_country.value=val20;
 		window.opener.document.forms[0].hid_country.value=val19;
 		window.opener.document.forms[0].txt_city.value=val4;
 		window.opener.document.forms[0].hid_city.value=val11;
 		window.opener.document.forms[0].txt_pin.value=val6;
 		window.close();
 		return;
 	}
	 else if(pagename1=="sec_livestock"){
        window.opener.document.forms[0].txt_cbscustid.value=val0;
        window.opener.document.forms[0].txt_applName.value=val1;
        window.opener.document.forms[0].txt_applName.readOnly=true;
        window.opener.document.forms[0].sel_applt_title.value=val23;
        window.opener.document.forms[0].sel_applt_title.disabled=true;
 		window.opener.document.forms[0].txt_applAddress1.value=val3;
 		window.opener.document.forms[0].txt_applAddress1.readOnly=true;
 		window.opener.document.forms[0].txt_applAddress2.value=val8;
 		window.opener.document.forms[0].txt_applAddress2.readOnly=true;
 		window.opener.document.forms[0].txt_addr_district.value=val14;
 		window.opener.document.forms[0].hid_dist.value=val13;
 		window.opener.document.forms[0].txt_addr_state.value=val5;
 		window.opener.document.forms[0].hidstate.value=val12;
        window.opener.document.forms[0].txt_applcountry.value=val20;
 		window.opener.document.forms[0].hid_applcountry.value=val19;
 		window.opener.document.forms[0].txt_addr_city.value=val4;
 		window.opener.document.forms[0].hidcity.value=val11;
 		window.opener.document.forms[0].txt_applpincode.value=val6;
 		window.close();
 		return;
 	}
	 else if(pagename1=="sec_crop"){
         
        window.opener.document.forms[0].txt_cbscustid.value=val0;
        window.opener.document.forms[0].txt_belonging.value=val1;
        window.opener.document.forms[0].txt_belonging.readOnly=true;
        window.opener.document.forms[0].sel_salutation.value=val23;
        window.opener.document.forms[0].sel_salutation.disabled=true;
 		window.opener.document.forms[0].txt_cropaddress1.value=val3;
 		window.opener.document.forms[0].txt_cropaddress1.readOnly=true;
 		window.opener.document.forms[0].txt_cropaddress2.value=val8;
 		window.opener.document.forms[0].txt_cropaddress2.readOnly=true;
 		window.opener.document.forms[0].txt_cropdistrict.value=val14;
 		window.opener.document.forms[0].hid_cropdistrict.value=val13;
 		window.opener.document.forms[0].txt_cropstate.value=val5;
 		window.opener.document.forms[0].hid_cropstate.value=val12;
        window.opener.document.forms[0].txt_cropcountry.value=val20;
 		window.opener.document.forms[0].hid_cropcountry.value=val19;
 		window.opener.document.forms[0].txt_cropcity.value=val4;
 		window.opener.document.forms[0].hid_cropcity.value=val11;
 		window.opener.document.forms[0].txt_croppin.value=val6;
 		window.close();
 		return;
 	}
	 else if(pagename1=="inward"){
		 window.opener.document.forms[0].txt_custid.value=val0;
		 window.opener.document.forms[0].txt_Name.value=val1
	 }
	 else if(pagename1=="BUR"){
		 if(val24!="01")
		 {
			 alert("At present Bureau Report is enabled only for Individuals");
			 return;
		 }

		 if(varappstatus=="Y")
			{
				//alert("Already Proposal "+varappno+"in  Open/Pending Status");
				alert("Digi Proposal in  Open/Pending Status");
				return;
			}
			 
			window.opener.document.forms[0].txt_cbscustid.value=val0;
			window.opener.document.forms[0].txt_comncustame.value=val1;
			window.opener.document.forms[0].txt_comDOB.value=val2;		
			window.opener.document.forms[0].txt_comcustadd1.value=val3;	
			window.opener.document.forms[0].txt_comcustcity.value=val4;	
			window.opener.document.forms[0].txtcomcust_state.value=val5;
			window.opener.document.forms[0].txtcomcust_zip.value=val6;	
			window.opener.document.forms[0].hidcity.value=val11;	
			window.opener.document.forms[0].hid_state.value=val12;
			window.opener.document.forms[0].hidstate.value=val12;
			window.opener.document.forms[0].txt_comcustadd2.value=val8;
			window.opener.document.forms[0].txtcomcust_email.value=val9;
			window.opener.document.forms[0].txtcomcust_pan.value=val10;
			window.opener.document.forms[0].hid_dist.value=val13;
			window.opener.document.forms[0].txt_comndist.value=val14;
			window.opener.document.forms[0].hid_perapp_id.value=val18;
			window.opener.document.forms[0].hid_country.value=val19;
			window.opener.document.forms[0].txt_country.value=val20;
			window.opener.document.forms[0].selgender.value=val27;
			window.opener.document.forms[0].hidgender.value=val27;
			window.opener.document.forms[0].txt_custFname.value=val28;
			window.opener.document.forms[0].txtcust_Aadharid.value=val29;
			window.opener.document.forms[0].sel_martial_status.value=val30;
			window.opener.document.forms[0].txt_comncustame.readOnly=true;
			window.opener.document.forms[0].txt_comDOB.readOnly=true;	
			window.opener.document.forms[0].txt_comcustadd1.readOnly=true;	
			window.opener.document.forms[0].txt_comcustcity.readOnly=true;
			window.opener.document.forms[0].txtcomcust_state.readOnly=true;
			window.opener.document.forms[0].txtcomcust_zip.readOnly=true;
			window.opener.document.forms[0].txt_comcustadd2.readOnly=true;
			window.opener.document.forms[0].txtcomcust_pan.readOnly=true;
			window.opener.document.forms[0].selgender.disabled=true;
			window.opener.document.forms[0].txt_custFname.readOnly=true;
			window.opener.document.forms[0].txtcust_Aadharid.readOnly=true;
			window.opener.document.forms[0].sel_martial_status.disabled=true;
			window.opener.document.forms[0].txtcomcust_mobile.value=val15;
			window.opener.document.forms[0].txtcomcust_mobile.readOnly=true;


			window.opener.document.forms[0].txt_comncustame.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_comDOB.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].selgender.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].sel_martial_status.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcust_Aadharid.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcomcust_pan.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcomcust_mobile.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_comcustadd1.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_comcustadd2.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_comcustcity.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_comndist.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcomcust_state.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcomcust_zip.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_country.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_custFname.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txt_cbscustid.className="finaclefieldsbgcolor";
			window.opener.document.forms[0].txtcomcust_email.className="finaclefieldsbgcolor";
	 }
	else if(varSno == "")
	{ 
       
        if(strAppVar1=="J"){
        	window.opener.document.forms[0].txt_cbscustid.value=val0;
        	window.opener.document.forms[0].txt_name.value=val1;
        	window.opener.document.forms[0].txt_address1.value=val3;	
        	window.opener.document.forms[0].txt_address2.value=val8;
          	window.opener.document.forms[0].txt_address3.value=val4;	
        	window.opener.document.forms[0].txt_city.value=val4;	
        	window.opener.document.forms[0].txt_state.value=val5;
        	window.opener.document.forms[0].txt_zip.value=val6;	
        	window.opener.document.forms[0].txt_resphone.value=val7;
			window.opener.document.forms[0].txt_resmobileno.value=val15;
			window.opener.document.forms[0].hidperapp_country.value=val19;
			window.opener.document.forms[0].txt_emailid.value=val9;
			window.opener.document.forms[0].hidcity.value=val11;
			window.opener.document.forms[0].hidstate.value=val12;
			window.opener.document.forms[0].txt_country.value=val20;
			window.opener.document.forms[0].txt_offphone.value=val21;
			window.opener.disableAppraiserDetails();

            	
        }
        else{
        	if(val11=="" || val12=="" || val20=="")
        	{
        		alert("Please fill Communication Details Tab in Customer Profile");
        		return;
        	}
			window.opener.document.forms[0].txt_cbscustid.value=val0;
			window.opener.document.forms[0].txt_comncustame.value=val1;
			window.opener.document.forms[0].txt_comDOB.value=val2;		
			window.opener.document.forms[0].txt_comcustadd1.value=val3;	
			window.opener.document.forms[0].txt_comcustcity.value=val4;	
			window.opener.document.forms[0].txtcomcust_state.value=val5;
			window.opener.document.forms[0].txtcomcust_zip.value=val6;	
			window.opener.document.forms[0].txtcomcust_phone.value=val7;
			window.opener.document.forms[0].hidcity.value=val11;	
			window.opener.document.forms[0].hid_state.value=val12;
			window.opener.document.forms[0].hidstate.value=val12;
			window.opener.document.forms[0].hidzip.value=val6;
			window.opener.document.forms[0].txt_comcustadd2.value=val8;
			window.opener.document.forms[0].txtcomcust_email.value=val9;
			window.opener.document.forms[0].txtcomcust_pan.value=val10;
			window.opener.document.forms[0].hid_dist.value=val13;
			window.opener.document.forms[0].txt_comndist.value=val14;
			window.opener.document.forms[0].txtcomcust_mobile.value=val15;
			window.opener.document.forms[0].txt_comncustame.readOnly=true;
			window.opener.document.forms[0].txt_comDOB.readOnly=true;	
			window.opener.document.forms[0].txt_comcustadd1.readOnly=true;	
			window.opener.document.forms[0].txt_comcustcity.readOnly=true;
			window.opener.document.forms[0].txtcomcust_state.readOnly=true;
			window.opener.document.forms[0].txtcomcust_zip.readOnly=true;
			window.opener.document.forms[0].txt_comcustadd2.readOnly=true;
			window.opener.document.forms[0].txtcomcust_pan.readOnly=true;
			window.opener.document.forms[0].txtcomcust_phone.readOnly=true;
			window.opener.document.forms[0].txtcomcust_mobile.readOnly=true;

			if(window.opener.document.forms[0].choose_type[1].checked==true)
		 	{
				window.opener.document.forms[0].selectgovtmain.value="2";
				window.opener.document.forms[0].schemetypemain.value="0";
				window.opener.document.forms[0].submainamnt.value="";
				window.opener.document.forms[0].sel_sponser_agencymain.value="0";
				window.opener.document.forms[0].sel_subsidytypemain.value="0";
				window.opener.document.forms[0].txt_agency.value="";
				window.opener.document.forms[0].selectgovtmain.disabled=true;
		 	}
        }
		
	}
	else
	{
		window.opener.document.forms[0].txt_cbsid[varSno].value=val0;
		window.opener.document.forms[0].txt_name[varSno].value=val1;
		window.opener.document.forms[0].txt_dob[varSno].value=val2;
		window.opener.document.forms[0].txt_panno[varSno].value=val16;
		window.opener.document.forms[0].txt_lapsid[varSno].value=val18;

		//window.opener.document.forms[0].txt_country.value=val20;
		//window.opener.document.forms[0].hid_country.value=val19;
		
	}	
	window.close();
}

function doClose()
{
 	window.close();
}

function callcbsid()
{
	if(document.forms[0].txt_cbsid.value=="")
	{
		alert("Enter minimum 3 characters");
		return;
	}
}

function callSearch()
{
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getCBSIDHelp";
	document.forms[0].hidBeanId.value="inwardRegister";
	document.forms[0].action=appURL+"action/CBSIDhelp.jsp";	
	document.forms[0].submit();	
	document.getElementById("form_blur").style.visibility="visible";
	document.getElementById("progress").style.visibility="visible";
}

function onRadioClick()
{
	if((document.forms[0].RD_CBS[0].checked==false)&& (document.forms[0].RD_CBS[1].checked==false))
	{
		document.forms[0].RD_CBS[0].checked=true;
	}
 	var varhidvalue=document.forms[0].hidvalue.value;
	document.forms[0].txt_cbsid.value="";
	document.forms[0].txt_cbsid.focus();
}

function resetme()
{
	document.forms[0].reset();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onRadioClick()">
<div id="progress" style="position:absolute; width:10px; visibility:hidden; height:10px; z-index:9999999; left: 200px; top: 200px">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
<div class="overlay" id="form_blur" style="position:absolute; visibility:hidden;"></div>
<form  method="post" class="normal">
<table width="90%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
<tr><td><b>Select CBS ID</b></td></tr>
</table>

<br>
<table width="90%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr class="dataheader">
		<td><b>CBS ID</b></td>
		<td><input type="radio" name="RD_CBS" STYLE="border-style: none" value="NO" ONCLICK="onRadioClick();"></td>
		<td><b>Name</b></td>
		<td><input type="radio" name="RD_CBS" STYLE="border-style: none" value="NAME" ONCLICK="onRadioClick();"></td>
		<td><input type="text" name="txt_cbsid" size="20" maxlength="25" value="" onKeyPress="notAllowSplChar();"></td>
		<td><input type="button" name="cmdsearch" value="Search" class="buttonStyle" onClick="callSearch();callcbsid();"></td>
		<td><input type="reset"name="search2" value="Reset" class="buttonStyle" onClick="resetme()"></td>
	</tr>
</table>
<br>
<table align="center" width="90%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
<tr class="dataheader">
<td align="center" width="15%"><b>CBS ID</b></td>
<td align="center" width="45%"><b>Name</b></td>
</tr>
<%
	arrCol=new ArrayList();
	if(hshValues!=null)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	if(arrRow!=null)
	{
			if(arrRow.size()>0)
			{
					for(int i=0;i<arrRow.size();i++)
					{
						 arrCol=(ArrayList)arrRow.get(i); 
%>
     	<tr class="datagrid">
		<td>	
		 <a href="javascript:selectValues(
		'<%=Helper.correctNull((String)arrCol.get(0))%>',
		'<%=Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(1))))%>',
	    '<%=Helper.correctNull((String)arrCol.get(2))%>',
		'<%=Helper.correctDoubleQuotesScript(Helper.replaceForJavaScriptString(Helper.correctNull((String)arrCol.get(3))))%>',
		'<%=Helper.correctNull((String)arrCol.get(4))%>',
		'<%=Helper.correctNull((String)arrCol.get(5))%>',
		'<%=Helper.correctNull((String)arrCol.get(6))%>',
		'<%=Helper.correctNull((String)arrCol.get(7))%>',
		'<%=Helper.correctNull((String)arrCol.get(8))%>',
		'<%=Helper.correctNull((String)arrCol.get(9))%>',
		'<%=Helper.correctNull((String)arrCol.get(10))%>',
		'<%=Helper.correctNull((String)arrCol.get(11))%>',
		'<%=Helper.correctNull((String)arrCol.get(12))%>',
		'<%=Helper.correctNull((String)arrCol.get(13))%>',
		'<%=Helper.correctNull((String)arrCol.get(14))%>',
		'<%=Helper.correctNull((String)arrCol.get(15))%>',
		'<%=Helper.correctNull((String)arrCol.get(16))%>',
		'<%=Helper.correctNull((String)arrCol.get(17))%>',
		'<%=Helper.correctNull((String)arrCol.get(18))%>',
		'<%=Helper.correctNull((String)arrCol.get(19))%>',
		'<%=Helper.correctNull((String)arrCol.get(20))%>',
		'<%=Helper.correctNull((String)arrCol.get(21))%>',
		'<%=Helper.correctNull((String)arrCol.get(23))%>',
		'<%=Helper.correctNull((String)arrCol.get(23))%>',
		'<%=Helper.correctNull((String)arrCol.get(24))%>',
		'<%=Helper.correctNull((String)arrCol.get(25))%>',
		'<%=Helper.correctNull((String)arrCol.get(26))%>',
		'<%=Helper.correctNull((String)arrCol.get(27))%>',
		'<%=Helper.correctNull((String)arrCol.get(28))%>',
		'<%=Helper.correctNull((String)arrCol.get(29))%>',
		'<%=Helper.correctNull((String)arrCol.get(30))%>',
		'<%=Helper.correctNull((String)arrCol.get(31))%>'
		)"><%=Helper.correctNull((String)arrCol.get(0))%></a>
		</td>
		<td><%=Helper.correctNull((String)arrCol.get(1))%></td>
		</tr>
		<%}%>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<tr class="datagrid"><td>&nbsp;</td><td>&nbsp;</td></tr>
		<% }
		else
		{%>
		<tr class="datagrid"><td COLSPAN="2" align="center">&nbsp;No Data Found</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<tr class="datagrid"><td COLSPAN="2">&nbsp;</td></tr>
		<%} 
		}%>
		</table>
<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>			
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden"  name="hidvalue" value="<%=Helper.correctNull((String)hshValues.get("hidStrCbs"))%>">
<input type="hidden"  name="varSno" value="<%=strSno%>">

<input type="hidden"  name="hidPagename" value="<%=pagename%>">

<input type="hidden"  name="hidstrAppVar" value="<%=strAppVar%>">

</form>
</body>
</html>
