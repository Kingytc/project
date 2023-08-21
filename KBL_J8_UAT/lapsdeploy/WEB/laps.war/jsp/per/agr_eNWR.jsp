<%@include file="../share/directives.jsp"%>

<%String strCgAppNo=Helper.correctNull((String)hshValues.get("ApplicationExist"));//yes or n

String strCreatedBy=Helper.correctNull((String)hshValues.get("CreateBy"));
String strCreatedOn=Helper.correctNull((String)hshValues.get("CreateDate"));

java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<%
	String inwardno= Helper.correctNull((String) hshValues.get("inwardno"));
System.out.println("inwardno"+inwardno);
	String appno = Helper.correctNull((String) request.getParameter("appno"));
	if (appno.equals("")) 
	{
		appno = Helper.correctNull((String) hshValues.get("strAppno"));
	}
	if(appno.equals("")) 
	{
		appno = Helper.correctNull((String) request.getParameter("Applicationno"));
	}
	String fac = Helper.correctNull((String) hshValues.get("facility"));
	%>

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>eNWR</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" 	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<link rel="stylesheet" href="../htm/link.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>

</head>
<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varstrenwr_check= "<%=Helper.correctNull((String)hshValues.get("strenwr_check"))%>";
function selection()
{
	
	var Sno="<%=Helper.correctNull((String) hshValues
		.get("Sno"))%>";
	var eNWR_date= "<%=Helper.correctNull((String) hshValues.get("eNWR_date"))%>";
	
	var receiptnumber="<%=Helper.correctNull((String) hshValues.get("receiptnumber"))%>";
	//var eNWRvalidupto_date="<%=Helper.correctNull((String) hshValues.get("eNWRvalidupto_date"))%>";
	var croporcommodity="<%=Helper.correctNull((String) hshValues.get("croporcommodity"))%>";
	var godownno="<%=Helper.correctNull((String) hshValues.get("godownno"))%>";
	var noofpackages="<%=Helper.correctNull((String) hshValues.get("noofpackages"))%>";
	var netquantity="<%=Helper.correctNull((String) hshValues.get("netquantity"))%>";
	var estimatedvalue="<%=Helper.correctNull((String) hshValues.get("estimatedvalue"))%>";
	var totalvalue="<%=Helper.correctNull((String) hshValues
									.get("totalvalue"))%>";
	var godownname="<%=Helper.correctNull((String) hshValues
							.get("godownname"))%>";

	var godownreg_no="<%=Helper.correctNull((String) hshValues.get("godownreg_no"))%>";
	var godownregvalidupto_date="<%=Helper.correctNull((String) hshValues.get("godownregvalidupto_date"))%>";
	
	var totalcapacity="<%=Helper.correctNull((String) hshValues.get("totalcapacity"))%>";

	var capacityutilason_date="<%=Helper.correctNull((String) hshValues
									.get("capacityutilason_date"))%>";
	var city="<%=Helper.correctNull((String) hshValues.get("city"))%>";

	var District="<%=Helper.correctNull((String) hshValues
									.get("District"))%>";
	

	var State="<%=Helper.correctNull((String) hshValues
							.get("State"))%>";

	var Place="<%=Helper.correctNull((String) hshValues.get("Place"))%>";
	var Godowndistance="<%=Helper.correctNull((String) hshValues.get("Godowndistance"))%>";

	var InsuranceName="<%=Helper.correctNull((String) hshValues
							.get("InsuranceName"))%>";
	var PolicyNo="<%=Helper.correctNull((String) hshValues
							.get("PolicyNo"))%>";
	var PolicyDate="<%=Helper.correctNull((String) hshValues
							.get("PolicyDate"))%>";
	
	var Amount="<%=Helper.correctNull((String) hshValues.get("Amount"))%>";
	var DueDate="<%=Helper.correctNull((String) hshValues
							.get("DueDate"))%>";	
	var varCreatedDate="<%=Helper.correctNull((String) hshValues
							.get("CreatedDate"))%>";	
	var varCreateBy="<%=Helper.correctNull((String) hshValues
							.get("CreatedBy"))%>";
	
		if(Godowndistance!="")
		{
			document.forms[0].sel_godown_distance.value=Godowndistance;
		}
	}
	
function showCitySearch1(val1) {

	if (val1 == "MIS") {
		//if (document.forms[0].cmdsave.disabled == false) 
		{
			var varQryString = appURL + "action/searchCity.jsp?mis=" + val1;
			var title = "City";
			var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
			var xpos = (screen.width - 350) / 2;
			var ypos = (screen.height - 120) / 2;
			prop = prop + ",left=50,top=50";
			window.open(varQryString, title, prop);
		}

	}
}

function callDistrict() {

	var varstate = document.forms[0].hid_State.value;
	if (document.forms[0].cmdsave.disabled == false) 
	{
		if (document.forms[0].txt_City.value == "") {

			ShowAlert(112, "City");

			document.forms[0].txt_City.focus();

			return;

		}

		if (document.forms[0].hid_State.value == "") {

			alert("Please Reselect the City");

			document.forms[0].txt_City.focus();

			return;

		} else {

			var varQryString = appURL

					+ "action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="

					+ varstate + "&code=MIS";

			var title = "District";

			var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';

			prop = prop + ",left=200,top=200";

			window.open(varQryString, title, prop);

		}

	}

}
function callCalender1(name)
{	
		showCal(appURL,name);
}

	function doEdit() 
	{
		callDisable(false);
		disableControls(true,false,false,false,false);	
		document.forms[0].sel_facilitysno.disabled=true;
		document.forms[0].txt_totalvalue.readOnly=true;
		document.forms[0].txt_City.readOnly=true;		
		document.forms[0].txt_District.readOnly=true;	
		document.forms[0].txt_State.readOnly=true;	
	}

	function doCancel()
	{
		
		if(ConfirmMsg('102'))
		{
			document.forms[0].action=appURL+"action/agr_eNWR.jsp";
			document.forms[0].hidBeanId.value = "agr_eNWR";
			document.forms[0].hidBeanGetMethod.value = "getagr_eNWR";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
		
		if(varstrenwr_check!="")
		{
			window.opener.document.forms[0].hidcheckenwr.value=varstrenwr_check;
		}
		var facility= "<%=fac%>";
		if(facility!="0")
		{			
			document.forms[0].sel_facilitysno.value=facility;
			callDisable(true);
			disableControls(false,true,true,true,false);
			document.forms[0].sel_facilitysno.disabled=false;			
		}
		else
		{
			document.forms[0].sel_facilitysno.value="0";
			callDisable(true);
			disableControls(true,true,true,true,false);
			document.forms[0].sel_facilitysno.disabled=false;		
		}
		
	}
	function callIFrame()
	{	
		
		document.forms[0].hidBeanId.value = "facilities";
		document.forms[0].hidBeanGetMethod.value = "getagr_eNWR";
		document.forms[0].action = appURL + "action/agr_eNWR.jsp";
		document.forms[0].submit();
		if(document.forms[0].sel_facilitysno.value=="")
		{
			disableControls(true,true,true,true,true);
		}
		else
		{
			disableControls(false,true,true,true,false);
		}	

	}
	function disableControls(cmdEdit,cmdApply,cmdCancel,cmdDelete,cmdClose)
	{
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdApply;
		document.forms[0].cmddelete.disabled=cmdDelete;
		document.forms[0].cmdcancel.disabled=cmdCancel;
		document.forms[0].cmdclose.disabled=cmdClose;
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
		
		
	}

function doClose()
{	
	   if(ConfirmMsg(100))
		 {
		   window.opener.document.forms[0].hidBeanId.value="facilities";
			window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
			window.opener.document.forms[0].action=appUrl+"action/facilities.jsp";	
			window.opener.document.forms[0].method="post";
			window.opener.document.forms[0].submit();		
			window.close();
		 }
}
function selfacility()
{	
	
	document.forms[0].action=appURL+"action/agr_eNWR.jsp?hidBeanId=facilities&hidBeanGetMethod=getagr_eNWR";
	document.forms[0].submit();
	
}

function doDelete()
{

	if(ConfirmMsg('101'))
	{
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidfacility.value=document.forms[0].sel_facilitysno.value;
		document.forms[0].hidBeanId.value = "facilities";
		document.forms[0].hidAction.value = "delete";
		document.forms[0].hidSourceUrl.value = "/action/agr_eNWR.jsp";
		document.forms[0].hidBeanMethod.value = "updateagreNWR";	
		document.forms[0].hidBeanGetMethod.value = "getagr_eNWR";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
	
	
}

function doSave()  
{
	
	if(document.forms[0].txt_issueofeNWR_date.value=="")
	{
		ShowAlert(121,"Date of Issue of eNWR");
		document.forms[0].txt_issueofeNWR_date.focus();
		return;
	}
	if(document.forms[0].txt_issueofeNWR_date.value!="")
	{
		if(validate_eNWRdate()==false)
		{
			var inwarddate= "<%=Helper.correctNull((String) hshValues.get("inwarddate"))%>";
			alert("Date of Issue should be beyond 3 months of Inward Date "+inwarddate);			
			document.forms[0].txt_issueofeNWR_date.focus();
			return;
		}	
			
	}
	if(document.forms[0].txt_receiptnumber.value=="")
	{
		ShowAlert(121,"Receipt Number");
		document.forms[0].txt_receiptnumber.focus();
		return;
	}
	if(document.forms[0].txt_eNWRvalidupto_date.value=="")
	{
		ShowAlert(121,"eNWR Valid Upto");
		document.forms[0].txt_eNWRvalidupto_date.focus();
		return;
	}
	if(document.forms[0].txt_eNWRvalidupto_date.value!="")
	{
	var validupto=document.forms[0].txt_eNWRvalidupto_date.value;
	var v_issueofeNWRdate=document.forms[0].txt_issueofeNWR_date.value;
	var v_validuptodt=changeDateformat(validupto);
	var v_issueofeNWRdt=changeDateformat(v_issueofeNWRdate);
	var currentdt=changeDateformat(currentDate);
		if(Date.parse(v_issueofeNWRdt) > Date.parse(v_validuptodt))
		{
			alert("eNWR valid upto Date should be greater than or equal to Date of Issue of eNWR " +v_issueofeNWRdate);
			document.forms[0].txt_eNWRvalidupto_date.value="";
			document.forms[0].txt_eNWRvalidupto_date.focus();
			return;
		}
		if(Date.parse(v_validuptodt) < Date.parse(currentdt))	
		{
			alert("eNWR valid upto Date should be greater than or equal to to " +currentDate);
			document.forms[0].txt_eNWRvalidupto_date.value="";
			document.forms[0].txt_eNWRvalidupto_date.focus();
			return;
		}
	}	
	if(document.forms[0].txt_croporcommodity.value=="")
	{
		ShowAlert(121,"Name of the Crop/Commodity");
		document.forms[0].txt_croporcommodity.focus();
		return;
	}
	if(document.forms[0].txt_godownno.value=="")
	{
		ShowAlert(121,"Godown/stack/Lot No (if any)");
		document.forms[0].txt_godownno.focus();
		return;
	}
	
	if(document.forms[0].txt_nopackages.value=="")
	{
		ShowAlert(121,"Number of Packages/Bags");
		document.forms[0].txt_nopackages.focus();
		return;
	}
	if(document.forms[0].txt_netquantity.value=="")
	{
		ShowAlert(121,"Net Quantity in Quintal (A)");
		document.forms[0].txt_netquantity.focus();
		return;
	}
	if(document.forms[0].txt_estimatedvalue.value=="")
	{
		ShowAlert(121,"Estimated Value per Quintal (B)");
		document.forms[0].txt_estimatedvalue.focus();
		return;
	}
	
	if(document.forms[0].txt_totalvalue.value=="")
	{
		ShowAlert(121,"Total Value (A X B)");
		document.forms[0].txt_totalvalue.focus();
		return;
	}
	
	if(document.forms[0].txt_warehouse.value=="")
	{
		ShowAlert(121,"Name of the Godown/Warehouse");
		document.forms[0].txt_warehouse.focus();
		return;
	}
	
	if(document.forms[0].txt_godownreg_no.value=="")
	{
		ShowAlert(121,"Godown/Warehouse Registration No");
		document.forms[0].txt_godownreg_no.focus();
		return;
	}
	
	if(document.forms[0].txt_godownregvalidupto_date.value=="")
	{
		ShowAlert(121,"Godown/Warehouse Registration valid upto");
		document.forms[0].txt_godownregvalidupto_date.focus();
		return;
	}
	if(document.forms[0].txt_godownregvalidupto_date.value!="")
	{
		var pagedate=document.forms[0].txt_godownregvalidupto_date.value;
		var pgdt=changeDateformat(pagedate);
		var currentdt=changeDateformat(currentDate);		
			if(Date.parse(pgdt) < Date.parse(currentdt))
			{
				alert("Godown/Warehouse Registration valid upto date should be greater than or equal to " +currentDate);
				document.forms[0].txt_godownregvalidupto_date.value="";
				document.forms[0].txt_godownregvalidupto_date.focus();
				return;
			}		
	
	}	
	/*if(document.forms[0].txt_totalcapacity.value=="")
	{
		ShowAlert(121,"Total capacity of the Godown");
		document.forms[0].txt_totalcapacity.focus();
		return;
	}
	
	if(document.forms[0].txt_capacityutilason_date.value=="")
	{
		ShowAlert(121,"Capacity utilized as on date");
		document.forms[0].txt_capacityutilason_date.focus();
		return;
	}
	*/
	if(document.forms[0].txt_City.value=="")
	{
		ShowAlert(121,"City");
		document.forms[0].txt_City.focus();
		return;
	}
	if(document.forms[0].txt_District.value=="")
	{
		ShowAlert(121,"District");
		document.forms[0].txt_District.focus();
		return;
	}
	if(document.forms[0].txt_State.value=="")
	{
		ShowAlert(121,"State");
		document.forms[0].txt_State.focus();
		return;
	}
	if(document.forms[0].txt_place.value=="")
	{
		ShowAlert(121,"Place");
		document.forms[0].txt_place.focus();
		return;
	}
	if(document.forms[0].sel_godown_distance.value=="")
	{
		ShowAlert(111,"Distance from the Godown");
		document.forms[0].sel_godown_distance.focus();
		return;
	}
	if(document.forms[0].txt_insurance.value=="" || document.forms[0].txt_insurance.value==0)
	{
		ShowAlert(121,"Name of the Insurance Company");
		document.forms[0].txt_insurance.focus();
		return;
	}	
	if(document.forms[0].txt_policyno.value=="" || document.forms[0].txt_policyno.value==0)
	{
		ShowAlert(121,"Policy No./Cover note no.");
		document.forms[0].txt_policyno.focus();
		return;
	}
	if(document.forms[0].txt_date.value=="" || document.forms[0].txt_date.value==0)
	{
		ShowAlert(121,"Date");
		document.forms[0].txt_date.focus();
		return;
	}
	if(document.forms[0].txt_date.value!="" || document.forms[0].txt_date.value!=0)
	{
		var pagedate=document.forms[0].txt_date.value;
		var pgdt=changeDateformat(pagedate);
		var currentdt=changeDateformat(currentDate);
		
			if(Date.parse(pgdt) > Date.parse(currentdt))
			{
				alert("Date always be less than or equal to " +currentDate);
				document.forms[0].txt_date.value="";
				document.forms[0].txt_date.focus();
				return;
			}
	}
	if(document.forms[0].txt_amount.value==""  || document.forms[0].txt_amount.value==0)
	{
		ShowAlert(121,"Amount");
		document.forms[0].txt_amount.focus();
		return;
	}
	if(document.forms[0].txt_duedate.value=="" || document.forms[0].txt_amount.value==0)
	{
		ShowAlert(121,"Due Date");
		document.forms[0].txt_duedate.focus();
		return;
	}
	if(document.forms[0].txt_duedate.value!="" || document.forms[0].txt_amount.value!=0)
	{
		var v_duedate=document.forms[0].txt_duedate.value;
		var currentdt=changeDateformat(currentDate);
		var facilitydate="<%=Helper.correctNull((String) hshValues.get("facdate"))%>";		
		var v_duedt=changeDateformat(v_duedate);
		var facilitydt=changeDateformat(facilitydate);
		if(Date.parse(v_duedt) < Date.parse(facilitydt))
		{
			alert("Due Date should be greater than or equal to Proposal Creation date " +facilitydate);
			document.forms[0].txt_duedate.value="";
			document.forms[0].txt_duedate.focus();
			return;
		}		
		if(Date.parse(v_duedt) < Date.parse(currentdt))
		{
			alert("Due Date always be greater than or equal to " +currentDate);
			document.forms[0].txt_duedate.value="";
			document.forms[0].txt_duedate.focus();
			return;
		}
	}
	document.forms[0].cmdsave.disabled = true;	
	document.forms[0].hidfacility.value=document.forms[0].sel_facilitysno.value;	
	document.forms[0].hidAction.value = "insert";
	document.forms[0].hidBeanId.value="facilities";	
	document.forms[0].hidBeanMethod.value="updateagreNWR";
	document.forms[0].hidBeanGetMethod.value="getagr_eNWR";
	document.forms[0].hidSourceUrl.value="/action/agr_eNWR.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();

}

function validate_eNWRdate()
{
	var inwarddate= "<%=Helper.correctNull((String) hshValues.get("inwarddate"))%>";
	var enddate= "<%=Helper.correctNull((String) hshValues.get("enddate"))%>";	
	var DOIdate=document.forms[0].txt_issueofeNWR_date.value;
	//alert(inwarddate);//15/07/21
	//alert(enddate);//15/10/21
	//alert(DOIdate);//08/09/21	
	var v_inwardt=changeDateformat(inwarddate);
    var v_doidt=changeDateformat(DOIdate);
    var v_enddt=changeDateformat(enddate);
    //alert(Date.parse(v_doidt)>= Date.parse(v_inwardt))
    //alert(Date.parse(v_enddt) >= Date.parse(v_doidt))   
   // if(Date.parse(v_enddt) >= Date.parse(v_doidt) && Date.parse(v_doidt)>= Date.parse(v_inwardt)) //for LAR Date +3 months
	  if(Date.parse(v_doidt)<= Date.parse(v_inwardt) && Date.parse(v_enddt)<= Date.parse(v_doidt))  
    {
    		return true;
   	}
   	else
   	{
   		return false;
   	}	
}
function get_totalvalue()
{
	var val1=document.forms[0].txt_netquantity.value;
	if(val1=="NaN" ||val1=="")
	{
		val1="0.00";
		document.forms[0].txt_netquantity.value=val1;
	}
	var val2=document.forms[0].txt_estimatedvalue.value;	
	
	if(val2=="NaN" || val2=="")
	{
		val2="0.00";
		document.forms[0].txt_estimatedvalue.value=val2;
	}
	document.forms[0].txt_totalvalue.value=(val1*val2);
	
}
function allowalwysOldDate(obj,currentdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var currentdt=changeDateformat(currentdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(currentdt))
		{
			alert("Date always be less than or equal to " +currentdate);
			obj.value="";
			obj.focus();
			return false;
		}
		
	}
	return true;
}

function allowalwysFutureDate(obj,currentdate)
{
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var currentdt=changeDateformat(currentdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) < Date.parse(currentdt))
		{
			alert("Date always be greater than or equal to " +currentdate);
			obj.value="";
			obj.focus();
			return false;
		}
		
	}
	return true;
}
function checkduedate()
{
	var v_duedate=document.forms[0].txt_duedate.value;
	var currentdt=changeDateformat(currentDate);
	var facilitydate="<%=Helper.correctNull((String) hshValues.get("facdate"))%>";
	
	var v_duedt=changeDateformat(v_duedate);
	var facilitydt=changeDateformat(facilitydate);
	if(Date.parse(v_duedt) < Date.parse(facilitydt))
	{
		alert("Due Date should be greater than or equal to Proposal Creation date " +facilitydate);
		document.forms[0].txt_duedate.value="";
		document.forms[0].txt_duedate.focus();
		return false;
	}
	if(Date.parse(v_duedt) < Date.parse(currentdt))
	{
		alert("Due Date always be greater than or equal to " +currentDate);
		document.forms[0].txt_duedate.value="";
		document.forms[0].txt_duedate.focus();
		return false;
	}
	
}

function checkeNWRvalidupto()
{
var validupto=document.forms[0].txt_eNWRvalidupto_date.value;
var v_issueofeNWRdate=document.forms[0].txt_issueofeNWR_date.value;
var v_validuptodt=changeDateformat(validupto);
var v_issueofeNWRdt=changeDateformat(v_issueofeNWRdate);
var currentdt=changeDateformat(currentDate);
	if(Date.parse(v_issueofeNWRdt) > Date.parse(v_validuptodt))
	{
		alert("eNWR valid upto Date should be greater than or equal to Date of Issue of eNWR " +v_issueofeNWRdate);
		document.forms[0].txt_eNWRvalidupto_date.value="";
		document.forms[0].txt_eNWRvalidupto_date.focus();
		return false;
	}
	if(Date.parse(v_validuptodt) < Date.parse(currentdt))	
	{
		alert("eNWR valid upto Date should be greater than or equal to to " +currentDate);
		document.forms[0].txt_eNWRvalidupto_date.value="";
		document.forms[0].txt_eNWRvalidupto_date.focus();
		return false;
	}

}
function specialcharalert(event) {
    //alert("alert2");
      var x = event.which || event.keyCode;
      
      if((x>=65 && x<=90)||(x>=97 && x<=122)||(x>=48 && x<=57)|| x==32)
      {
          return true;
      }
      else
      {
          alert("Only allow for Alphabet and Numbers")
          return false;
            
      }
        /*   if(x==34||x==39)
          {
           alert("Double or single quotes not allowed");
           return false;
          }
           else
               {
               return true;
               }*/
      
    }
</script>
<body onload="callonLoad();selection();">
<form class="normal" method="post">
<lapschoice:application />

<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
						<td colspan="2">Facility &nbsp; &nbsp;<select
							name="sel_facilitysno" id="sel_fac"  onchange="selfacility()">
							<option value="0">--Select--</option>
							<%
					String parent=appno;
				%>
							<lapschoice:ComMisDetailsTag
								apptype='<%= parent%>'  />
						</select></td>
						<td></td>
					</tr>
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td style="text-align: center" colspan="2">eNWR Details</td>
		<td></td>
	</tr>
	
	<tr>
		<td width="40%">Date of Issue of eNWR  <b><span class="mantatory">*</span></b></td>
		 <td width="60%"><input type="text" name="txt_issueofeNWR_date" size="12"
							maxlength="10" 
							 value="<%=Helper.correctNull((String)hshValues.get("eNWR_date"))%>"
							onBlur="checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_issueofeNWR_date')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		</tr>
	<tr>
		<td>Receipt Number  <b><span class="mantatory">*</span></b> </td>
		<td><input type="text" name="txt_receiptnumber"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("receiptnumber"))%>" onkeypress="return specialcharalert(event);"></td>
	</tr>
	
	<tr>
		<td>eNWR Valid Upto  <b><span class="mantatory">*</span></b> </td>
		 <td><input type="text" name="txt_eNWRvalidupto_date" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("eNWRvalidupto_date"))%>"
							onBlur="checkeNWRvalidupto();checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_eNWRvalidupto_date')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		</tr>	
</table>

</td>
</tr>

<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">	
	<tr class="dataheader"  style="text-align:center;">
		<td colspan="2">Commodity/Crop details</td>
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td width="40%">Name of the Crop/Commodity <b><span class="mantatory">*</span></b></td>
		<td width="60%"><input type="text" name="txt_croporcommodity"
			value="<%=Helper.correctNull((String)hshValues.get("croporcommodity"))%>"
			size="35"  maxlength="50">
		</td>
		</tr>
		<tr>
		<td>Godown/stack/Lot No (if any)  <b><span class="mantatory">*</span></b> </td>
		<td> <input type="text" name="txt_godownno"
			value="<%=Helper.correctNull((String)hshValues.get("godownno"))%>"
			size="20%" maxlength="20">
		</td>
	</tr>
	<tr>
		<td>Number of Packages/Bags <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_nopackages"
			value="<%=Helper.correctNull((String)hshValues.get("noofpackages"))%>"
			size="20%"  maxlength="10">
		</td>
	</tr>
	<tr>		
		<td>Net Quantity in Quintal (A)  <b><span class="mantatory">*</span></b> </td>
		<td nowrap> <input type="text" name="txt_netquantity" onBlur="get_totalvalue()"
			value="<%=Helper.correctNull((String)hshValues.get("netquantity"))%>"
			onKeyPress="allowNumber(this)" maxlength="13" style="text-align: right">
		</td>
	</tr>	
	<tr>
		<td>Estimated Value per Quintal (B) <b><span class="mantatory">*</span></b></td>
		<td nowrap> <input type="text" name="txt_estimatedvalue" onBlur="get_totalvalue()"
			value="<%=Helper.correctNull((String)hshValues.get("estimatedvalue"))%>"
			onKeyPress="allowNumber(this)" maxlength="13" style="text-align: right">
		</td>
	</tr>
	<tr>	
		<td>Total Value (A X B) </td>
		<td nowrap> <input type="text" name="txt_totalvalue"
			value="<%=Helper.correctNull((String)hshValues.get("totalvalue"))%>"
			size="20%" maxlength="20"  style="text-align: right" readonly="true">
		</td>
	</tr>	
</table>
</td>
</tr>
<!-- godown details -->
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader"  >		
		<td colspan="2" style="text-align:center;">Godown details</td>		
		<td></td><td></td>
	</tr>
	
	<tr>
	<td width="40%">Name of the Godown/Warehouse <b><span class="mantatory">*</span></b></td>
		<td width="60%"><input type="text" name="txt_warehouse"
			value="<%=Helper.correctNull((String)hshValues.get("godownname"))%>"
			size="35" onKeyPress="allowAlphaNumericSpace()" maxlength="50">
		</td>
	</tr>
	
	<tr>
	<td>Godown/Warehouse Registration No  <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_godownreg_no"
			value="<%=Helper.correctNull((String)hshValues.get("godownreg_no"))%>"
			size="35" maxlength="50">
		</td>	
		</tr>
		<tr>
		<td>Godown/Warehouse Registration valid upto  <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_godownregvalidupto_date" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("godownregvalidupto_date"))%>"
							onBlur="allowalwysFutureDate(this,currentDate);checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_godownregvalidupto_date')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>		
	</tr>
	<tr>
		<td> Total capacity of the Godown </td>
		<td><input type="text" name="txt_totalcapacity"
			value="<%=Helper.correctNull((String)hshValues.get("totalcapacity"))%>"
			size="20"  maxlength="10" onkeypress="allowNumber(this);">
		</td>
	</tr>
	<tr>
		<td> Capacity utilized as on date </td>
		<td><input type="text" name="txt_capacityutilason_date" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("capacityutilason_date"))%>"
							onBlur="allowalwysOldDate(this,currentDate);checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_capacityutilason_date')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>		
	</tr>
	<tr>
		<td>City  <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_City"
			value="<%=Helper.correctNull((String)hshValues.get("city"))%>"
			>			
		<a href="#" onClick="showCitySearch1('MIS');" style="cursor: hand" tabindex="13">
			<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
		</a>
		</td>
	</tr>	
	<tr>
		<td>District  <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_District"
			value="<%=Helper.correctNull((String)hshValues.get("District"))%>"
			>
			<a href="#" onClick="callDistrict();" style="cursor: hand" tabindex="14">
									<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</a>
		</td>
	</tr>
	<tr>
		<td>State  <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_State"
			value="<%=Helper.correctNull((String)hshValues.get("State"))%>"
			>
		</td>
	</tr>
	<tr>
		<td>Place  <b><span class="mantatory">*</span></b> </td>
		<td><input type="text" name="txt_place"
			value="<%=Helper.correctNull((String)hshValues.get("Place"))%>"
			size="35"  maxlength="50">
		</td>
	</tr>
	<tr>
		<td>Distance from the Godown  <b><span class="mantatory">*</span></b></td>
		<td><select name="sel_godown_distance"  class="finaclefieldsbgcolor" >
			<option value="0">---select--</option>
			<option value="1">1-10 Km</option>
			<option value="11">11-20 Km</option>
			<option value="21">21-30 Km</option>
			<option value="31">More Than 30 Km</option>
		</select>
		</td>
	</tr>	
</table>
</td>
</tr>
<!--Insurance Details -->
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr class="dataheader">
		<td colspan="4" style="text-align:center;">Insurance Details of the Warehouse</td>		
		<td></td>
		<td></td>
	</tr>
	<tr>
		<td width="45%">Name of the Insurance Company  <b><span class="mantatory">*</span></b> </td>
		<td colspan="3"><input type="text" name="txt_insurance"
			value="<%=Helper.correctNull((String)hshValues.get("InsuranceName"))%>"
			size="50%" onKeyPress="" onBlur="allowAlphaNumeric()" maxlength="150"></td>
	</tr>
	<tr>
		<td>Policy No./Cover note no.  <b><span class="mantatory">*</span></b> </td>
		<td><input type="text" name="txt_policyno"
			value="<%=Helper.correctNull((String)hshValues.get("PolicyNo"))%>"
			size="20%" onKeyPress="" maxlength="20"></td>
		<td width="20%">Date  <b><span class="mantatory">*</span></b> </td>
		<td width="30%"><input type="text" name="txt_date" onBlur="allowalwysOldDate(this,currentDate);checkDate(this);"
			value="<%=Helper.correctNull((String)hshValues.get("PolicyDate"))%>"
			size="12" onKeyPress="" maxlength="10">
			<a href="#"
							onClick="callCalender1('txt_date')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
	</tr>
	<tr>
		<td>Amount(in <%=ApplicationParams.getCurrency()%>)  <b><span class="mantatory">*</span></b> </td>
		<td><lapschoice:CurrencyTag name="txt_amount" size="18"
			value='<%=Helper.correctNull((String)hshValues.get("Amount"))%>'
			maxlength="15" onBlur="roundtxt(this)" /></td>
		<td>Due Date  <b><span class="mantatory">*</span></b> </td>
		<td><input type="text" name="txt_duedate"
			value="<%=Helper.correctNull((String)hshValues.get("DueDate"))%>"
			size="12" onKeyPress="" maxlength="19" onBlur="checkduedate();checkDate(this);">
			<a href="#"
							onClick="callCalender1('txt_duedate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
	</tr>
	
	
</table>
</td>
</tr>
<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
			</tr>
		</table>
		
</td>
</tr>

</table>
</td>
</tr>
</table>
					
<lapschoice:hiddentag pageid="<%=PageId %>" /> 
<input type="hidden" name="hidUsername" value="<%=Helper.correctNull((String)session.getAttribute("strUserName"))%>"> 
<input type="hidden" name="hidOrgcode" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
 <input type="hidden" name="hidCreatedOn" value="<%=strCreatedOn%>" >
<input type="hidden" name="hidCreatedBy" value="<%=strCreatedBy%>" >
<input type="hidden" name="hidCondtion" value="<%=strCgAppNo%>" >
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>"> 
<input type="hidden" name="hidinwardno" value="<%=inwardno%>">
<input type="hidden" name="strappno" value="<%=appno%>">
<input type ="hidden" name="hidfacility" value="">
<input type="hidden" name="hid_District" value="<%=Helper.correctNull((String)hshValues.get("app_district"))%>">
<input type="hidden" name="hid_City" value="<%=Helper.correctNull((String)hshValues.get("app_city"))%>">
<input type="hidden" name="hid_State" value="<%=Helper.correctNull((String)hshValues.get("app_state"))%>">
</form>
</body>
</html>
