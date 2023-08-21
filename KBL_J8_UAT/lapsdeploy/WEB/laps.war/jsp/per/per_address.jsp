<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
//out.println(hshValues);
String strEmployment="";
strEmployment=(String)session.getAttribute("strEmployment");

String strProfilestatus = Helper.correctNull((String) hshValues
		.get("strProfilestatus"));

session.setAttribute("strEmployment",strEmployment);
String strfacdata=Helper.correctNull(request.getParameter("strfacdata"));
String hidfacname=Helper.correctNull(request.getParameter("hidfacname"));
String strPageName=Helper.correctNull((String)hshValues.get("strIncompletepage"));

String pageid = request.getParameter("pageid");
String strapptype = Helper.correctNull((String)request.getParameter("corp"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

%>
<html>
<head>
<title>Communication Details</title>
<script LANGUAGE="JavaScript">
var sel_residence="<%=Helper.correctNull((String)hshValues.get("sel_residence"))%>";
var chk_offaddress="<%=Helper.correctNull((String)hshValues.get("chk_offaddress"))%>";
var chk_offaddress1="<%=Helper.correctNull((String)hshValues.get("chk_offaddress1"))%>";
var chk_commaddress="<%=Helper.correctNull((String)hshValues.get("chk_commaddress"))%>";
var app_constitution="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>";
var perapp_id="<%=Helper.correctNull((String)hshValues.get("hidDemoId"))%>";
var appstatus="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var cbs_id="<%= Helper.correctNull((String)hshValues.get("strCBSID"))%>";
var txtperapp_noyears="<%=Helper.correctNull((String)hshValues.get("txtperapp_noyears"))%>";
//alert(app_constitution);

function showres()
{	
	
	if(app_constitution=="01" || app_constitution=="02" || app_constitution=="") 
	{	

		document.all.add1.style.visibility="hidden";
		document.all.add1.style.position="absolute";
		document.all.add2.style.visibility="visible";
		document.all.add2.style.position="relative";
		
		document.all.chkAddress.style.visibility="hidden";
		document.all.chkAddress.style.position="absolute";		

		document.all.add_admin1.style.visibility="hidden";
		document.all.add_admin1.style.position="absolute";	
		
		document.all.add_admin2.style.visibility="hidden"; 
		document.all.add_admin2.style.position="absolute";	
		   
		document.all.add_admin12.style.visibility="hidden";
		document.all.add_admin12.style.position="absolute";	
		
		document.all.add_admin22.style.visibility="hidden"; 
		document.all.add_admin22.style.position="absolute";	
		 
		document.all.add_admin13.style.visibility="hidden";
		document.all.add_admin13.style.position="absolute";	
				
		document.all.add_admin23.style.visibility="hidden";
		document.all.add_admin23.style.position="absolute";	
		
		document.all.add_admin14.style.visibility="hidden"; 
		document.all.add_admin14.style.position="absolute";	
		   
		document.all.add_admin24.style.visibility="hidden";
		document.all.add_admin24.style.position="absolute";	
		
		document.all.add_admin15.style.visibility="hidden";  
		document.all.chkAddress.style.position="absolute";	
		
		document.all.add_admin25.style.visibility="hidden";		
		document.all.add_admin25.style.position="absolute";	
		
		document.all.add_admin16.style.visibility="hidden";
		document.all.add_admin16.style.position="absolute";	
		
		document.all.add_admin26.style.visibility="hidden";
		document.all.add_admin26.style.position="absolute";	
		    
		document.all.add_admin17.style.visibility="hidden";
		document.all.add_admin17.style.position="absolute";	
		
		document.all.add_admin27.style.visibility="hidden"; 
		document.all.add_admin27.style.position="absolute";	
		
		document.all.add_admin18.style.visibility="hidden";
		document.all.add_admin18.style.position="absolute";	
		
		document.all.add_admin28.style.visibility="hidden";
		document.all.add_admin28.style.position="absolute";	
		
		document.all.add_admin19.style.visibility="hidden";
		document.all.add_admin19.style.position="absolute";	
		
		document.all.add_admin29.style.visibility="hidden"; 
		document.all.add_admin29.style.position="absolute";	
		
		document.all.add_admin10.style.visibility="hidden";
		document.all.add_admin10.style.position="absolute";	
		
		document.all.add_admin20.style.visibility="hidden"; 
		document.all.add_admin20.style.position="absolute";	
		
		document.all.chkregaddress.style.visibility="hidden";
		document.all.chkregaddress.style.position="absolute";	
		 
		document.all.chkregaddress.style.position="absolute"; 
		
		document.all.chkcommaddress.style.visibility="visible";	
		document.all.chkcommaddress.style.position="relative";	

		document.all.id_ResTypeLbl.style.visibility="visible";
		document.all.id_ResTypeLbl.style.position="relative";
		document.all.id_ResTypeSel.style.visibility="visible";
		document.all.id_ResTypeSel.style.position="relative";
	}
	else
	{
		document.all.add1.style.visibility="visible";
		document.all.add1.style.position="relative";
		document.all.add2.style.visibility="hidden";
		document.all.add2.style.position="absolute";
		document.all.chkAddress.style.visibility="visible";
		
		document.all.add_admin1.style.visibility="visible";	
		document.all.add_admin2.style.visibility="visible";
		document.all.add_admin12.style.visibility="visible";
		document.all.add_admin22.style.visibility="visible";
		document.all.add_admin13.style.visibility="visible";		
		document.all.add_admin23.style.visibility="visible";	
		document.all.add_admin14.style.visibility="visible";
		document.all.add_admin24.style.visibility="visible";
		document.all.add_admin15.style.visibility="visible";
		document.all.add_admin25.style.visibility="visible";		
		document.all.add_admin16.style.visibility="visible";	
		document.all.add_admin26.style.visibility="visible";
		document.all.add_admin17.style.visibility="visible";
		document.all.add_admin27.style.visibility="visible";
		document.all.add_admin18.style.visibility="visible";
		document.all.add_admin28.style.visibility="visible";
		document.all.add_admin19.style.visibility="visible";
		document.all.add_admin29.style.visibility="visible";
		document.all.add_admin10.style.visibility="visible";
		document.all.add_admin20.style.visibility="visible";
		document.all.chkcommaddress.style.visibility="hidden";
		document.all.id_ResTypeLbl.style.visibility="hidden";
		document.all.id_ResTypeLbl.style.position="absolute";
		document.all.id_ResTypeSel.style.visibility="hidden";
		document.all.id_ResTypeSel.style.position="absolute";
	}

}

function callfunction()
{

	
	disableFields(true);
	multival(txtperapp_noyears);
	
	if(sel_residence=='0')
	{
		
		document.forms[0].sel_residence.options[0].selected=true;
		
	}
	else if(sel_residence=='1')
	{
			document.forms[0].sel_residence.options[1].selected=true;
	}
	else if(sel_residence=='2')
	{
			document.forms[0].sel_residence.options[2].selected=true;
	}
	else if(sel_residence=='3')
	{
			document.forms[0].sel_residence.options[3].selected=true;
	}
	else if(sel_residence=='4')
	{
			document.forms[0].sel_residence.options[4].selected=true;
	}
	else if(sel_residence=='5')
	{
			document.forms[0].sel_residence.options[5].selected=true;
	}


	if(chk_offaddress=='1')
	{
		
		document.forms[0].chk_offaddress.checked=true;
	}
	else if(chkcommaddress=='1')
		{
			document.forms[0].chkcommaddress.checked=true;
		}

	 if(chk_offaddress1=='2')
	{
		document.forms[0].chk_offaddress1.checked=true;
	}


		if(document.forms[0].chk_offaddress.checked)
		{
			disableFields(true);
			}
		
	
	// document.forms[0].txtperapp_city.readOnly=true;		
	 showres();
	//	showHeader();
	
	if(document.forms[0].readFlag.value=="r")
	{
		disableControls(true,true,true,false);
		
	}
	else
	{
	  if(appstatus=="true")
	  {
		disableControls(true,true,true,false);
	  }
	  else
	  {
		disableControls(false,true,true,false);
	  } 
	}

}
function showHeader()
{
	if((app_constitution=="01"))
	{
		document.all.add1.style.visibility="hidden";
		document.all.add1.style.position="absolute";
		document.all.add2.style.visibility="visible";
		document.all.add2.style.position="relative";
	}
	else
	{
		document.all.add1.style.visibility="visible";
		document.all.add1.style.position="relative";
		document.all.add2.style.visibility="hidden";
		document.all.add2.style.position="absolute";	
	}
}
function doEdit()
{
	
	 
    disableFields(false);
	
    if(document.forms[0].chk_offaddress.checked)
    {

	 document.forms[0].txtperapp_permadd1.readOnly=true;
	 document.forms[0].txtperapp_permadd2.readOnly=true;
	 document.forms[0].txtperapp_permadd3.readOnly=true;
	 document.forms[0].txtperapp_permcity.readOnly=true;
	 document.forms[0].txtperapp_permdistrict.readOnly=true;
	 document.forms[0].txtperapp_permstate.readOnly=true;
	 document.forms[0].txtperapp_permzip.readOnly=true;
	 document.forms[0].txtperapp_permcountry.readOnly=true;
	 document.forms[0].txtperapp_permphone.readOnly=true;
	 document.forms[0].txtperapp_permfax.readOnly=true;

    }
    if(document.forms[0].chk_offaddress1.checked){
    	 document.forms[0].txtperapp_adminadd1.readOnly=true;
    	 document.forms[0].txtperapp_adminadd2.readOnly=true;
    	 document.forms[0].txtperapp_adminadd3.readOnly=true;
    	 document.forms[0].txtperapp_admincity.readOnly=true;
    	 document.forms[0].txtperapp_admindistrict.readOnly=true;
    	 document.forms[0].txtperapp_adminstate.readOnly=true;
    	 document.forms[0].txtperapp_adminzip.readOnly=true;
    	 document.forms[0].txtperapp_admincountry.readOnly=true;
    	 document.forms[0].txtperapp_adminphone.readOnly=true;
    	 document.forms[0].txtperapp_adminfax.readOnly=true;
     }
	
	document.forms[0].txtperapp_city.readOnly=true;	
    document.forms[0].txtperapp_permcity.readOnly=true;	
    document.forms[0].txtperapp_admincity.readOnly=true;

    document.forms[0].txtperapp_state.readOnly=true;	
    document.forms[0].txtperapp_permstate.readOnly=true;	
    document.forms[0].txtperapp_adminstate.readOnly=true;

    document.forms[0].txtperapp_country.readOnly=true;	
    document.forms[0].txtperapp_permcountry.readOnly=true;	
    document.forms[0].txtperapp_admincountry.readOnly=true;

	disableControls(true,false,false,false);
	document.forms[0].hideditflag.value="Y";
	if(cbs_id=="")
	{
		disableCbsFields(false);	
	}
	else
	{
		disableCbsFields(true);
	}	
	document.forms[0].txtperapp_district.readOnly=true;
	document.forms[0].txtperapp_permdistrict.readOnly=true;
	document.forms[0].txtperapp_admindistrict.readOnly=true;
}
function disableCbsFields(boolval)
{
	document.forms[0].txtperapp_address1.readOnly=boolval;
	document.forms[0].txtperapp_address2.readOnly=boolval;
	document.forms[0].txtperapp_city.readOnly=boolval;
	document.forms[0].txtperapp_state.readOnly=boolval;
	document.forms[0].txtperapp_zip.readOnly=boolval;
	document.forms[0].txtperapp_country.readOnly=boolval;
	document.forms[0].txtperapp_phone.readOnly=boolval;
	document.forms[0].txtperapp_phoneoff.readOnly=boolval;
	document.forms[0].txtperapp_fax.readOnly=boolval;
	document.forms[0].txtperapp_email.readOnly=boolval;

	document.forms[0].txtperapp_permadd1.readOnly=boolval;
	document.forms[0].txtperapp_permadd2.readOnly=boolval;
	document.forms[0].txtperapp_permcity.readOnly=boolval;
	document.forms[0].txtperapp_permstate.readOnly=boolval;
	document.forms[0].txtperapp_permzip.readOnly=boolval;
	document.forms[0].txtperapp_permcountry.readOnly=boolval;
	document.forms[0].txtperapp_permphone.readOnly=boolval;
	document.forms[0].txtperapp_permfax.readOnly=boolval;
	document.forms[0].txtperapp_peremail.readOnly=boolval;
	document.forms[0].chk_offaddress.disabled=boolval;
	document.forms[0].txtperapp_mobile.readOnly=boolval;
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
		else if(document.forms[0].elements[i].type=="checkbox")
		{
		  document.forms[0].elements[i].disabled=val;		  
		}
	}
}
function doSave()
{
	if(document.forms[0].txtperapp_noyears.value=="")
	{
		document.forms[0].txtperapp_noyears.focus();
		ShowAlert("121","No. of years staying in the present address");
		return false;
	}
	if(document.forms[0].txtperapp_nomonth.value=="")
	{
		ShowAlert("121","No. of months staying in the present address");
		document.forms[0].txtperapp_nomonth.focus();
		return false;
	}
	if(app_constitution=="01" || app_constitution=="") 
	{
	if(document.forms[0].txtperapp_address1.value == "")
	{
		ShowAlert('121','Communication Address');
		document.forms[0].txtperapp_address1.focus();
		return;
	}
	}
	if(document.forms[0].txtperapp_address1.value == "")
	{
		ShowAlert('121','Register Office Address');
		document.forms[0].txtperapp_address1.focus();
		return;
	}
	if(app_constitution=="01" || app_constitution=="") 
	{
	if(document.forms[0].txtperapp_city.value == "")
	{
		ShowAlert('111','Communication Address City');
		document.forms[0].txtperapp_city.focus();
		return;
	}
	}
	if(document.forms[0].txtperapp_city.value == "")
	{
		ShowAlert('111','the City');
		document.forms[0].txtperapp_city.focus();
		return;
	}

	if(document.forms[0].hidperapp_country.value!="IN" && document.forms[0].hidperapp_country.value!="44")
	{
		if(document.forms[0].hidresidentstatus.value=="Y")
		{
			if(document.forms[0].txtperapp_permdistrict.value == "")
			{
				ShowAlert('111','the District');
				document.forms[0].txtperapp_permdistrict.focus();
				return;
			}
			if(document.forms[0].txtperapp_district.value == "")
			{
				document.forms[0].txtperapp_district.value=".";
			}
		}
		else
		{
			if(document.forms[0].txtperapp_district.value == "")
			{
				ShowAlert('111','the District');
				document.forms[0].txtperapp_district.focus();
				return;
			}
		}
	}
	else
	{
		if(document.forms[0].txtperapp_district.value == "")
		{
			ShowAlert('111','the District');
			document.forms[0].txtperapp_district.focus();
			return;
		}
	}
		
	
	if(app_constitution=="01" || app_constitution=="") 
	{
		if(document.forms[0].txtperapp_zip.value == "")
		{
			ShowAlert('121','Communication Address Pincode');
			document.forms[0].txtperapp_zip.focus();
			return false;
		}
	}
			if(document.forms[0].txtperapp_zip.value == "")
	{
		ShowAlert('121','Pincode');
		document.forms[0].txtperapp_zip.focus();
		return false;
	}
			if(app_constitution=="01" || app_constitution=="") 
			{
			if(document.forms[0].txtperapp_country.value == "")
		{
			ShowAlert('111','Communication Address Country');
			document.forms[0].txtperapp_country.focus();
			return false;
		}
			}
			if(document.forms[0].txtperapp_country.value == "")
		{
			ShowAlert('111','Country');
			document.forms[0].txtperapp_country.focus();
			return false;
		}
		if(app_constitution=="01" || app_constitution=="02" || app_constitution=="") 
		{
			if(document.forms[0].sel_residence.value == "0")
			{
				ShowAlert('111','Residence');
				document.forms[0].sel_residence.focus();
				return false;
			}
		}
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidAction.value="update";
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanMethod.value="updateAddressDetails";
		document.forms[0].hidBeanGetMethod.value="getAddressDetails";
		document.forms[0].hidSourceUrl.value="/action/per_address.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
}
function doCancel()
{var varconfirm=ConfirmMsg('102');
if(varconfirm)
{
	document.forms[0].hidBeanId.value="mastapplicant";
	document.forms[0].hidBeanGetMethod.value="getAddressDetails";
	document.forms[0].action=appURL+"action/per_address.jsp";
	document.forms[0].submit();
}
}
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/mastersearchper.jsp";
		document.forms[0].submit();
	}
}
function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdApply;
	//document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function getpmadd()
{
	
    if(document.forms[0].chk_offaddress.checked)
	{ 
 
     	document.forms[0].txtperapp_permadd1.value=document.forms[0].txtperapp_address1.value; 
	  	document.forms[0].txtperapp_permadd2.value=document.forms[0].txtperapp_address2.value;
      	document.forms[0].txtperapp_permadd3.value=document.forms[0].txtperapp_address3.value;
      	document.forms[0].txtperapp_permcity.value=document.forms[0].txtperapp_city.value;
      	document.forms[0].hidperapp_permcity.value=document.forms[0].hidperapp_city.value;
      	document.forms[0].hidperapp_permdist.value=document.forms[0].hidperapp_dist.value;
      	document.forms[0].hidperapp_permstate.value=document.forms[0].hidperapp_state.value;
      	document.forms[0].txtperapp_permdistrict.value=document.forms[0].txtperapp_district.value;
       	document.forms[0].txtperapp_permstate.value=document.forms[0].txtperapp_state.value;
      	document.forms[0].txtperapp_permzip.value=document.forms[0].txtperapp_zip.value;
      	document.forms[0].txtperapp_permcountry.value=document.forms[0].txtperapp_country.value;
      	document.forms[0].hidperapp_permcountry.value=document.forms[0].hidperapp_country.value;
      	//document.forms[0].txtperapp_permphone.value=document.forms[0].txtperapp_phone.value;
 	  	//document.forms[0].txtperapp_permfax.value=document.forms[0].txtperapp_fax.value;  
 	  	
   	}
    
     document.forms[0].txtperapp_city.readOnly=true;	
     document.forms[0].txtperapp_permcity.readOnly=true;	
     document.forms[0].txtperapp_admincity.readOnly=true;	

     if(document.forms[0].chk_offaddress.checked)
     {
    	 document.forms[0].txtperapp_permadd1.readOnly=true;
    	 document.forms[0].txtperapp_permadd2.readOnly=true;
    	 document.forms[0].txtperapp_permadd3.readOnly=true;
    	 document.forms[0].txtperapp_permcity.readOnly=true;
    	 document.forms[0].txtperapp_permdistrict.readOnly=true;
    	 document.forms[0].txtperapp_permstate.readOnly=true;
    	 document.forms[0].txtperapp_permzip.readOnly=true;
    	 document.forms[0].txtperapp_permcountry.readOnly=true;
    	 document.forms[0].txtperapp_permphone.readOnly=true;
    	 document.forms[0].txtperapp_permfax.readOnly=true;
     	
     }
     else
     {
     document.forms[0].txtperapp_permadd1.readOnly=false;
   	 document.forms[0].txtperapp_permadd2.readOnly=false;
   	 document.forms[0].txtperapp_permadd3.readOnly=false;
   	// document.forms[0].txtperapp_permcity.readOnly=false;
   	 //document.forms[0].txtperapp_permdistrict.readOnly=false;
   	// document.forms[0].txtperapp_permstate.readOnly=false;
   	 document.forms[0].txtperapp_permzip.readOnly=false;
   	// document.forms[0].txtperapp_permcountry.readOnly=false;
   	 document.forms[0].txtperapp_permphone.readOnly=false;
   	 document.forms[0].txtperapp_permfax.readOnly=false;
    	 document.forms[0].txtperapp_permadd1.value="";
    	 document.forms[0].txtperapp_permadd2.value="";
    	 document.forms[0].txtperapp_permadd3.value="";
    	 document.forms[0].txtperapp_permcity.value="";
    	 document.forms[0].txtperapp_permdistrict.value="";
    	 document.forms[0].txtperapp_permstate.value="";
    	 document.forms[0].txtperapp_permzip.value="";
    	 document.forms[0].txtperapp_permcountry.value="";
    	 document.forms[0].txtperapp_permphone.value="";
    	 document.forms[0].txtperapp_permfax.value="";
    	 document.forms[0].hidperapp_permcity.value="";
       	document.forms[0].hidperapp_permdist.value="";
       	document.forms[0].hidperapp_permstate.value="";
       	document.forms[0].hidperapp_permcountry.value="";
     	
     }
  
}
function getpmadd1()
{
 if(document.forms[0].chk_offaddress1.checked){
    	document.forms[0].txtperapp_adminadd1.value=document.forms[0].txtperapp_address1.value; 
	  	document.forms[0].txtperapp_adminadd2.value=document.forms[0].txtperapp_address2.value;
      	document.forms[0].txtperapp_adminadd3.value=document.forms[0].txtperapp_address3.value;
      	document.forms[0].txtperapp_admincity.value=document.forms[0].txtperapp_city.value;
      	document.forms[0].txtperapp_admindistrict.value=document.forms[0].txtperapp_district.value;
       	document.forms[0].txtperapp_adminstate.value=document.forms[0].txtperapp_state.value;
      	document.forms[0].txtperapp_adminzip.value=document.forms[0].txtperapp_zip.value;
      	document.forms[0].txtperapp_admincountry.value=document.forms[0].txtperapp_country.value;
      	document.forms[0].hidperapp_admincity.value=document.forms[0].hidperapp_city.value;
      	document.forms[0].hidperapp_admindist.value=document.forms[0].hidperapp_dist.value;
      	document.forms[0].hidperapp_adminstate.value=document.forms[0].hidperapp_state.value;
      	document.forms[0].hidperapp_admincountry.value=document.forms[0].hidperapp_country.value;
      	document.forms[0].txtperapp_adminphone.value=document.forms[0].txtperapp_phone.value;
 	  	document.forms[0].txtperapp_adminfax.value=document.forms[0].txtperapp_fax.value; 
    }
if(document.forms[0].chk_offaddress1.checked){
    	 document.forms[0].txtperapp_adminadd1.readOnly=true;
    	 document.forms[0].txtperapp_adminadd2.readOnly=true;
    	 document.forms[0].txtperapp_adminadd3.readOnly=true;
    	 document.forms[0].txtperapp_adminadd3.readOnly=true;
    	 document.forms[0].txtperapp_admincity.readOnly=true;
    	 document.forms[0].txtperapp_admindistrict.readOnly=true;
    	 document.forms[0].txtperapp_adminstate.readOnly=true;
    	 document.forms[0].txtperapp_adminzip.readOnly=true;
    	 document.forms[0].txtperapp_admincountry.readOnly=true;
    	 document.forms[0].txtperapp_adminphone.readOnly=true;
    	 document.forms[0].txtperapp_adminfax.readOnly=true;
     }
     else
     {
      	 document.forms[0].txtperapp_adminadd1.readOnly=false;
    	 document.forms[0].txtperapp_adminadd2.readOnly=false;
    	 document.forms[0].txtperapp_adminadd3.readOnly=false;
    	 //document.forms[0].txtperapp_admindistrict.readOnly=false;
    	 document.forms[0].txtperapp_adminzip.readOnly=false;
    	 document.forms[0].txtperapp_adminphone.readOnly=false;
    	 document.forms[0].txtperapp_adminfax.readOnly=false;
    	 document.forms[0].txtperapp_adminadd1.value="";
    	 document.forms[0].txtperapp_adminadd2.value="";
    	 document.forms[0].txtperapp_adminadd3.value="";
    	 document.forms[0].txtperapp_admincity.value="";
    	 document.forms[0].txtperapp_admindistrict.value="";
    	 document.forms[0].txtperapp_adminstate.value="";
    	 document.forms[0].txtperapp_adminzip.value="";
    	 document.forms[0].txtperapp_admincountry.value="";
    	 document.forms[0].txtperapp_adminphone.value="";
    	 document.forms[0].txtperapp_adminfax.value="";
    	 document.forms[0].hidperapp_admincity.value="";
       	document.forms[0].hidperapp_admindist.value="";
       	document.forms[0].hidperapp_adminstate.value="";
       	document.forms[0].hidperapp_admincountry.value="";
     }
}
function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	varDemoflag = "DEMO";
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(cbs_id=="")
		{
			var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&vardemo="+varDemoflag;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString,title,prop);
		}
		else
		{
			if(!(varTextControl=="txtperapp_city" || varTextControl=="txtperapp_permcity" ))
			{
				var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&vardemo="+varDemoflag;
				var title = "City";
				var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
				var xpos = (screen.width - 350) / 2;
				var ypos = (screen.height - 120) / 2;
				prop = prop + ",left=50,top=50";
				window.open(varQryString,title,prop);
			}
			else
			{
				//No Function
			}
		}
	}	
}
function showstate()
{
	var val1=document.forms[0].hidcity.value;
	var val2=document.forms[0].hidstate.value;
	if(val1!="")
	{
		document.forms[0].hidcity1.value=val1;
	}
	if(val2!="")
	{
		document.forms[0].hidstate1.value=val2;
	}
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		if(cbs_id=="")
		{
			var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
			var title = "Country";
			var prop = "scrollbars=no,width=750,height=500";	
			prop = prop + ",left=200,top=200";
			window.open(varQryString,title,prop);	
		}
		else
		{
			if(!(varTextControl=="txtperapp_country" || varTextControl=="txtperapp_permcountry" ))
			{
				var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
				var title = "Country";
				var prop = "scrollbars=no,width=750,height=500";	
				prop = prop + ",left=200,top=200";
				window.open(varQryString,title,prop);	
			}
			else
			{
				//No Function
			}
		}
	}
	
}
function min_nos(obj,no)
{
	var min_len=obj.value.length;
	if(min_len<eval(no))
	{
		alert("Enter all "+no+" digits");
		obj.value="";
	}
}


function showDistSearch(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		vreg = "REG";
		vcorp = "CORP";
		vadm = "ADM";
		varreg = document.forms[0].hidperapp_state.value;
		varcorp = document.forms[0].hidperapp_permstate.value;
		varadm = document.forms[0].hidperapp_adminstate.value;	
		if(val == "REG")
		{
	    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varreg+"&code="+vreg;
		var title = "District";
		var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);
		}
		if(val == "CORP")
		{
	    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varcorp+"&code="+vcorp;
		var title = "District";
		var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);
		}
		if(val == "ADM")
		{
		if(document.forms[0].txtperapp_admincity.value=="")
		{
			ShowAlert(112,"City");
			document.forms[0].txtperapp_admincity.focus();
			return;
		}
		else		
		{
	    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varadm+"&code="+vadm;
		var title = "District";
		var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);
		}
		}
	}
}

function multival(val)
{

	if(val!="")
	{
		
		var temp=val.split("~");
		
		document.forms[0].txtperapp_noyears.value=temp[0] ;
		document.forms[0].txtperapp_nomonth.value=temp[1] ;
			
	}
}
function chkMonths()
{
	if(document.forms[0].txtperapp_nomonth.value!="")
	{
		if(eval(document.forms[0].txtperapp_nomonth.value)>11)
		{
			alert("value should not be more than 11 Months");
			document.forms[0].txtperapp_nomonth.value="";
			document.forms[0].txtperapp_nomonth.focus();
			return;
		}
	}
}
</script>
</head>
<body onload="callfunction();">
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
<form class="normal" method="post">

	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer
		Profile -&gt; Communication Details</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			<tr>
		<td><jsp:include page="../share/Cusurllink.jsp" flush="true">
			<jsp:param name="pageid" value="2"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="strProfilestatus" value="<%=strProfilestatus%>" />
			<jsp:param name="hidincompletedpagename" value="<%=strPageName%>" />
			</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<% }  else { %>

<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ 
if(!strSessionModuleType.equalsIgnoreCase("RET")){%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="subpageid" value="115" />
			<jsp:param name="subsubpageid" value="22" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<% }else{%>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subsubpageid" value="22"/>
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value=""/>
			<jsp:param name="subsubpageid" value="22"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include>
<%}else{ %>
<%if(strapptype.equalsIgnoreCase("C")){ %>
 <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="CORP" />
			<jsp:param name="ssitype" value="" />
			<jsp:param name="applevel" value="A" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
  
   <%
    if(strSessionModuleType.equalsIgnoreCase("AGR")){
   %>
   <tr>
		<td class="page_flow">Home -&gt;Agriculture -&gt;Application -&gt; Applicant -&gt; customer profile -&gt; Communication details</td>
	</tr>
   
    <%}else
     {
     %>
	<tr>
		<td class="page_flow">Home -&gt;Corporate &amp; SME -&gt; Application -&gt; Applicant-&gt; customer profile -&gt; Communication details</td>
	</tr>
  </table>
   <%}}else if(strSessionModuleType.equalsIgnoreCase("LAD") || strSessionModuleType.equalsIgnoreCase("RET")){ %>
        <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; 
       Retail(including schematic) -&gt; Application -&gt; Applicant/Guarantor -&gt; Communication details</td>
    </tr>
  </table>
  <%} else { %>
    <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="<%=pageid%>" />
        </jsp:include>
         <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center"  class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Digi Retail -&gt; Application -&gt; Applicant/Guarantor -&gt; Communication details</td>
    </tr>
  </table>
  <% } %>
<lapschoice:application />
   
   <table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="98%" border="0" cellspacing="1" cellpadding="3"
			align="left" class="outertable">
			
			<%if(strapptype.equalsIgnoreCase("C")){ %>
		<tr>
		<lapstab:ComfacilityTab tabid="2" />
		</tr>
		<tr>
		<%} if(strapptype.equalsIgnoreCase("C") || strapptype.equalsIgnoreCase("R")){ %>
		<td><jsp:include page="../share/Cusurllinkdisp.jsp" flush="true">
			<jsp:param name="pageid" value="22"/>
			<jsp:param name="employmenttype" value="<%=strEmployment%>" />
			<jsp:param name="demoid" value="<%=strapptype%>" />
		</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	</table>
		<%} }%>

 <% } %>


<table width="98%" border="0" cellspacing="0" cellpadding="3"  class="outertable border1" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"  class="outertable" align="center" >

<tr class="dataheader" id="add1">
    <td > Registered Office Address</td>
   
   	<td> Corporate Address</td>

	<td nowrap="nowrap" align="center">Administrative Office Address</td>
  </tr>
  <tr class="dataheader" id="add2">
   <td >Communication Address</td>
   <td > Permanent Address</td>
  </tr>
 </table> 
  <table cellpadding="3" cellspacing="1" width="90%" border="0" class="outertable" >
  <tr id="chk1">
												
                  <td colspan="2" id="busicommaddr" height="30">&nbsp;</td>
                  <td colspan="4" height="41"> 
                    <table width="90%" border="0" cellspacing="0"	cellpadding="0" class="outertable">
					<tr>
					     <td width="6%" nowrap >
					<input type="checkbox" name="chk_offaddress" onClick="getpmadd()" style="border-style:none" value="1"></td>
														
                        <td id="chkregaddress">Copy Registered Office Address</td>
														
                        <td  id="chkcommaddress">Copy Communication 
                          Address</td>
													</tr>
												</table>
												</td>
												
                  <td colspan="4" height="41"> 
                    <table width="90%" border="0" cellspacing="0"
													cellpadding="0" class="outertable">
													<tr id="chkAddress">
														<td width="38%" nowrap><input type="checkbox" name="chk_offaddress1" style="border-style:none" onClick="getpmadd1()" value="2">Copy Registered Office Address</td>
													
													</tr>
												</table>
												</td>
							</tr>
					<tr>
					<td>Address<b><span class="mantatory">*&nbsp;</span></b></td>
					<td> 
                    <input type="text" name="txtperapp_address1"
													size="35" maxlength="50" tabindex="18"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address1"))%>"
													onKeyPress="" class="finaclefieldsbgcolor"></td>
												
                    <td  valign="top" >Address</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd1" size="35" maxlength="50"
													tabindex="28" onKeyPress="" class="finaclefieldsbgcolor"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd1"))%>">
												</td>
												
                    <td valign="top"  id="add_admin1">Address</td>
												<td valign="top" style=" " colspan="2" id="add_admin2"><input type="text"
													name="txtperapp_adminadd1" size="35" maxlength="50"
													tabindex="28" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd1"))%>">
												</td>
											</tr>
											<tr>
												
                    <td align="center" width="12%">&nbsp;</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_address2"
													size="35" maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address2"))%>"
													onKeyPress="" class="finaclefieldsbgcolor"></td>
												
                    <td valign="top" width="11%">&nbsp;</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd2" size="35" maxlength="50"
													tabindex="29" onKeyPress="" class="finaclefieldsbgcolor"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd2"))%>">
												</td>
												
                    <td valign="top" width="12%" id="add_admin12">&nbsp;</td>
												<td valign="top" colspan="2" id="add_admin22"><input type="text"
													name="txtperapp_adminadd2" size="35" maxlength="50"
													tabindex="29" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd2"))%>">
												</td>
											</tr>
											<tr>
												
                    <td  width="12%">Village/Taluk/Town</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_address3"
													size="35" maxlength="50" tabindex="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_address3"))%>"
													onKeyPress=""></td>
												
                    <td valign="top" width="11%">Village/Taluk/Town</td>
												<td valign="top" colspan="2"><input type="text"
													name="txtperapp_permadd3" size="35" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permadd3"))%>">
												</td>
												
                    <td valign="top" width="12%" id="add_admin13">Village/Taluk/Town</td>
												<td valign="top" colspan="2" id="add_admin23"><input type="text"
													name="txtperapp_adminadd3" size="35" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminadd3"))%>">
												</td>
											</tr>
											<tr>
												
                    <td width="12%"> 
                      <div align="left">City <b><span class="mantatory">*&nbsp;</span></b></div>
												</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_city" class="finaclefieldsbgcolor"
													size="25" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_city"))%>"
													onKeyPress="" ><a href="#"
													onClick="showCitySearch('txtperapp_city','txtperapp_state','hidperapp_city','hidperapp_state','hidzip1','hidres1');showstate()"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a>
					<input type="hidden" name="hidperapp_city" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>">				
													
													</td>
													
												
                    <td width="11%">City</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permcity" class="finaclefieldsbgcolor"
													size="25" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcity"))%>"
													onKeyPress="" ><a href="#"
													onClick="showCitySearch('txtperapp_permcity','txtperapp_permstate','hidperapp_permcity','hidperapp_permstate','hidzip1','hidres1');showstate()"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a>
					<input type="hidden" name="hidperapp_permcity" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity"))%>">
												</td>
												
                    <td valign="top" width="12%" id="add_admin14">City</td>
												<td valign="top" colspan="2" id="add_admin24"><input type="text"
													name="txtperapp_admincity" size="25" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admincity"))%>" >
												<a href="#"
													onClick="showCitySearch('txtperapp_admincity','txtperapp_adminstate','hidperapp_admincity','hidperapp_adminstate','hidzip1','hidres1');showstate()"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a>
					  <input type="hidden" name="hidperapp_admincity" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_admincity"))%>">
												</td>
												
											</tr>
											<tr>
												
                    <td width="12%"> 
                      <div align="left">District <b><span class="mantatory">*&nbsp;</span></b></div>
												</td>
												
                    <td width="18%">
                            <input type="text" name="txtperapp_district"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_district"))%>"
													onKeyPress="notallowInteger()">&nbsp;<a href="#"
													onClick="showDistSearch('REG');"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a>
							<input type="hidden" name="hidperapp_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get("txtperapp_district_code"))%>">		
													
													 </td>
												
                    <td width="11%">District</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permdistrict"
													size="21" maxlength="20"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permdistrict"))%>"
													onKeyPress="notallowInteger()"> 
													&nbsp;<a href="#"
													onClick="showDistSearch('CORP');"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
					<input type="hidden" name="hidperapp_permdist" size="5" value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permdistrict_code"))%>">						
													</td>
											
												
                    <td valign="top" width="12%" id="add_admin15">District</td>
												<td valign="top" colspan="2" id="add_admin25"><input type="text"
													name="txtperapp_admindistrict" size="20" maxlength="50"
													tabindex="30" onKeyPress=""
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admindistrict"))%>">
												&nbsp;<a href="#"
													onClick="showDistSearch('ADM');"
													style="cursor:hand" tabindex="22"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
					<input type="hidden" name="hidperapp_admindist" size="5" value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admindistrict_code"))%>">							
													</td>
												
											</tr>
											<tr>
												
                    <td width="12%">State </td>
												
                    <td width="18%"> 
                        <input type="text" name="txtperapp_state" class="finaclefieldsbgcolor"
													size="21" maxlength="25" tabindex="22"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_state"))%>"
													onKeyPress=""
													onBlur="">
						<input type="hidden" name="hidperapp_state" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>">
													
													</td>
												
                    <td width="11%">State</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permstate" size="21" maxlength="20" class="finaclefieldsbgcolor"
													tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permstate"))%>"
													onKeyPress=""
													onBlur="">
					  <input type="hidden" name="hidperapp_permstate" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate"))%>">
												</td>
												
                    <td width="12%" id="add_admin16">State</td>
												
                    <td colspan="2" id="add_admin26"> 
                      <input type="text"	name="txtperapp_adminstate" size="21" maxlength="20"
													tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminstate"))%>"
													onKeyPress=""
													onBlur="">
													  <input type="hidden" name="hidperapp_adminstate" size="5" value="<%=Helper.correctNull((String)hshValues.get("perapp_adminstate"))%>">
												</td>
												
					
											<tr>
												
                    <td width="12%"> 
                      <div align="left">Pin Code<span class="mantatory">*&nbsp;</span></div>
												</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_zip" class="finaclefieldsbgcolor"
													size="12" maxlength="6"
													tabindex="23" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_zip"))%>"
													onKeyPress="allowInteger()"
													onBlur="">
												</td>
												
                    <td width="11%" >Pin Code</td>
												
                    <td colspan="2"> 
                      <input type="text" name="txtperapp_permzip"	size="12" maxlength="6" tabindex="33" style="text-align:left"	  value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permzip"))%>"
													onKeyPress="allowInteger()" onBlur="" class="finaclefieldsbgcolor">
												</td>
												
                    <td width="12%" id="add_admin17">Pin Code</td>
												
                    <td colspan="2" id="add_admin27"> 
                      <input type="text" name="txtperapp_adminzip"
													size="12" maxlength="6"
													tabindex="33" style="text-align:left"
													 value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminzip"))%>"
													onKeyPress="allowInteger()"
													onBlur="">
												</td>
											</tr>
											<tr>
												
                    <td nowrap width="12%" >Country<span class="mantatory">*&nbsp;</span></td>
												
                    <td width="18%" > 
                      <input type="text" name="txtperapp_country" class="finaclefieldsbgcolor"
													size="25" maxlength="15" tabindex="24"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_country"))%>"
													onKeyPress=""><input type="hidden"
													name="hidperapp_country"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_countrycode"))%>"><a href="#"
													onClick="callCntrySearch('txtperapp_country','hidperapp_country')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
												</td>
												
                    <td width="11%">Country</td>
												
                    <td colspan="2"> 
                      <input type="text"	name="txtperapp_permcountry" size="25" maxlength="15" class="finaclefieldsbgcolor"
													tabindex="34" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcountry"))%>"
													onKeyPress="">
													<input type="hidden"
													name="hidperapp_permcountry"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permcountrycode"))%>">
													<a href="#"
													onClick="callCntrySearch('txtperapp_permcountry','hidperapp_permcountry')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a>  
												</td>
													
                    <td width="12%" id="add_admin18">Country</td>
												
                    <td colspan="2" id="add_admin28"> 
                      <input type="text" name="txtperapp_admincountry" size="25" maxlength="15"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admincountry"))%>"
													onKeyPress="">
													<input type="hidden"
													name="hidperapp_admincountry"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_admincode"))%>">
													<a href="#"
													onClick="callCntrySearch('txtperapp_admincountry','hidperapp_admincountry')"
													style="cursor:hand" tabindex="8"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
												</td>
											</tr>
											<tr>
												
                    <td nowrap width="12%">Phone No.(Res)</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_phone" class="finaclefieldsbgcolor"
													size="20" maxlength="15" tabindex=""
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_phone"))%>"
													onKeyPress="allowPhone()"></td>
												
                    <td width="11%">Phone No.</td>
												
                    <td colspan="2"> 
                      <input type="text"	name="txtperapp_permphone" size="20" maxlength="15" class="finaclefieldsbgcolor"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permphone"))%>"
													onKeyPress="allowPhone()"></td>
													
                    <td width="12%" id="add_admin19">Phone No.</td>
												
                    <td colspan="2" id="add_admin29"> 
                      <input type="text"	name="txtperapp_adminphone" size="20" maxlength="15"
													tabindex="" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminphone"))%>"
													onKeyPress="allowPhone()"></td>
												<!-- <td></td>-->
											</tr>
											<tr>
					<td nowrap width="12%">Phone No.(Off)</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_phoneoff" class="finaclefieldsbgcolor"
													size="20" maxlength="15" tabindex=""
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_phoneoff"))%>"
													onKeyPress="allowPhone()"></td>
					<td colspan="6">&nbsp;</td>
					</tr>
					<tr>
                    <td nowrap width="12%">Fax No.</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_fax" class="finaclefieldsbgcolor"
													size="20" maxlength="15" tabindex="25"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_fax"))%>"
													onKeyPress="allowPhone();"></td>
												
                    <td width="11%">Fax No.</td>
												
                    <td colspan="2"> 
                      <input type="text" class="finaclefieldsbgcolor"
													name="txtperapp_permfax" size="20" maxlength="15"
													tabindex="35" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_permfax"))%>"
													onKeyPress="allowPhone();"></td>
													
                    <td width="12%" id="add_admin10">Fax No.</td>
												
                    <td colspan="2" id="add_admin20"> 
                      <input type="text"
													name="txtperapp_adminfax" size="20" maxlength="15"
													tabindex="35" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_adminfax"))%>"
													onKeyPress="allowPhone();"></td>
												<!-- <td></td>-->
											</tr>
											<tr>
												
                    <td nowrap width="12%">Mobile No.</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_mobile" class="finaclefieldsbgcolor"
													size="20" maxlength="10" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_mobile"))%>"
													onKeyPress="allowPhone();"
													onChange="min_nos(document.forms[0].txtperapp_mobile,10)">
												</td>
					<td nowrap width="12%">Website</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_website"
													size="35" maxlength="100" tabindex="26"
													style="text-align:left" readonly="readonly"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_website"))%>"
													onKeyPress=""
													onChange="" >
												</td>							
                   
											</tr>
											<tr>
												
                    <td nowrap width="16%">E-mail</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_email" class="finaclefieldsbgcolor"
													size="30" maxlength="50" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_email"))%>"
													onKeyPress=""
													onChange=""
													onBlur="isEmailAddr(document.forms[0].txtperapp_email.value,document.forms[0].txtperapp_email)">
												</td>
                    <td nowrap width="16%">E-mail</td>
												
                    <td width="18%"> 
                      <input type="text" name="txtperapp_peremail" class="finaclefieldsbgcolor"
													size="30" maxlength="50" tabindex="26"
													style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("txtperapp_peremail"))%>"
													onKeyPress=""
													onChange=""
													onBlur="isEmailAddr(document.forms[0].txtperapp_peremail.value,document.forms[0].txtperapp_peremail)">
												</td>
                   
											</tr>
											<tr>
												
                    <td nowrap width="12%" id="id_ResTypeLbl">Resident type<span class="mantatory">*&nbsp;</span></td>
												
                    <td width="18%" id="id_ResTypeSel"><select name="sel_residence" tabindex=""
					onChange="showres()">
					<option value="0" selected>--Select--</option>
					<option value="1">Rented</option>
					<option value="2">Owned</option>
					<option value="3">Leased</option>
					<option value="4">Family</option>
					<option value="5">Employer</option>
				</select></td>
			
											
											</tr>
											<tr>
												<td nowrap width="12%">No.of years staying in<br> the present address <b><span class="mantatory">*</span></b></td>
												
												<td width="18%"> 
												  <input type="text" name="txtperapp_noyears"
																				size="5" maxlength="4" tabindex=""
																				style="text-align:left"
																				value="<%=Helper.correctNull((String)hshValues.get("txtperapp_noyears"))%>"
																				onChange="" readOnly onKeyPress="allowInteger()"> Years
																			&nbsp;&nbsp;&nbsp; <input type="text" name="txtperapp_nomonth" size="5" value=""
																				onKeyPress="allowInteger();" onblur="chkMonths();"> Months
																			</td>
											</tr>
											
										</table>
										
						</table>
						</td>
						</tr>
					</table>

<br>
	<%if(Helper.correctNull((String)session.getAttribute("sessionModuleType")).equals("")) { %>	
		<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
	<% }  else { %>
		<div style="display: none; ">
			<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
		</div>		
		<lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
	<% } %>
	

<lapschoice:hiddentag pageid='<%=PageId%>'/>


<input type="hidden" name="comapp_id"	value="<%=Helper.correctNull((String)hshValues.get("cust_id"))%>">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("perapp_city_code"))%>">
<input type="hidden" name="hidPermCity" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidcity1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity_code"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("perapp_state_code"))%>">
<input type="hidden" name="hidstate1" value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate_code"))%>"> 
<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>">
<input type="hidden" name="hidzipcontrol"	value="">
<input type="hidden" name="hidzipvaildatorcontrol"	value="">
 <input type="hidden" name="hidcitycontrol"	value="">
<input type="hidden" name="hidstatecontrol"	value="">
<input type="hidden" name="hidcitycodecontrol"	value="">
<input type="hidden" name="hidstatecodecontrol"	value="">
 <input type="hidden"name="hidzip">
<input type="hidden" name="hidCategory" />
<input type="hidden" name="hid_inwardno"/>
<input type="hidden" name="hidzip1" value="">
<input type="hidden" name="hidzip2" value="">
<input type="hidden" name="hidres1" value="">
<input type="hidden" name="hidres2" value="">
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
<input type="hidden" name="app_constitution" value="<%=Helper.correctNull((String)hshValues.get("app_constitution"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)request.getParameter("hidDemoId"))%>"> 
<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
<input type="hidden" name="hidappstatus" value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>">  
<input type="hidden" name="hidresidentstatus" value="<%=Helper.correctNull((String)hshValues.get("strResidentstatus"))%>">  
<input type="hidden" name="hidfacname"	value="<%=hidfacname%>">
</form>
</body>
</html>
