<%@include file="../share/directives.jsp"%>

<%
	ArrayList arryCol = new ArrayList();
	ArrayList arryRow = new ArrayList();

	arryRow = (ArrayList) hshValues.get("arryRow");
	if (arryRow == null) {
		arryRow = new ArrayList();
	}
	String l1 = "", d1 = "", u1 = "", w1 = "", m1 = "", tm1 = "", v1 = "", id = "";
	String l2 = "", d2 = "", u2 = "", w2 = "", m2 = "", tm2 = "", v2 = "", id2 = "";
	String l3 = "", d3 = "", u3 = "", w3 = "", m3 = "", tm3 = "", v3 = "", id3 = "";
	String lm1 = "", lm2 = "", lm3 = "";
	
	String schemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String strschemetype="",strfacsno="",stragrschemetype="";
	HashMap hshScheme = new HashMap();
	hshScheme = Helper.splitScheme(schemetype);
	if(hshScheme!=null)
	{
		strfacsno = Helper.correctNull((String)hshScheme.get("facility_sno"));
		if(strfacsno.equalsIgnoreCase(""))
			strfacsno = Helper.correctNull((String)hshValues.get("facsno"));
		stragrschemetype = Helper.correctNull((String)hshScheme.get("facility_schemetype"));
		if(stragrschemetype.equalsIgnoreCase(""))
			stragrschemetype = Helper.correctNull((String)hshValues.get("schemetype"));
	}
%>
<html>
<head>
<title>CAPL Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var sel_warehouse= "<%=Helper.correctNull((String)hshValues.get("sel_warehouse"))%>" 
var sel_insurance = "<%=Helper.correctNull((String)hshValues.get("sel_insurance"))%>" 
var sel_applicant= "<%=Helper.correctNull((String)hshValues.get("sel_applicant"))%>" 
var sel_license= "<%=Helper.correctNull((String)hshValues.get("sel_license"))%>" 
var varschemetype="<%=schemetype%>";
var varUnits="<%=Helper.correctNull((String)hshValues.get("agr_units"))%>";
var varMeasure1="<%=Helper.correctNull((String)hshValues.get("capl_weightmeasure1"))%>";
var varMeasure2="<%=Helper.correctNull((String)hshValues.get("capl_weightmeasure2"))%>";
var varMeasure3="<%=Helper.correctNull((String)hshValues.get("capl_weightmeasure3"))%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var sel_warehouse_other= "<%=Helper.correctNull((String)hshValues.get("sel_warehouse_owned"))%>" 
</script>

<script>
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appUrl,name);
	}
}

function onloading()
{	
	disableFields(true);
	if(sel_warehouse!="")
	{
		document.forms[0].sel_warehouse.value=sel_warehouse;
	}
	if(sel_applicant!="")
	{
		document.forms[0].sel_applicant.value=sel_applicant;
	}
	if(sel_license!="")
	{
		document.forms[0].sel_license.value=sel_license;
	}
	if(sel_insurance!="")
	{
		document.forms[0].sel_insurance.value=sel_insurance;
	}
	if(varMeasure1!="")
	{
		document.forms[0].sel_unitsy1.value=varMeasure1;
	}
	if(varMeasure2!="")
	{
		document.forms[0].sel_unitsy2.value=varMeasure2;
	}
	if(varMeasure3!="")
	{
		document.forms[0].sel_unitsy3.value=varMeasure3;
	}
	
	checklicense();
	callselownedother();
	document.forms[0].sel_scheme.disabled=false;
	document.forms[0].sel_scheme.value=varschemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	      enableButtons(false,true,true,true,false);
		}
		else
		{
			enableButtons(true,true,true,true,false);
		}
	}
	else
	{
		enableButtons(true,true,true,true,false);
	}
	document.forms[0].sel_ownedother.value=sel_warehouse_other;
}

function checklicense()
{
	if(document.forms[0].sel_license.value=="1")
	{
		document.all.l1.style.visibility="visible";
	document.all.l2.style.visibility="visible";
	}
	else{
		document.all.l1.style.visibility="hidden";
		document.all.l2.style.visibility="hidden";
		document.forms[0].txt_licenseno.value="";
	}
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function doSave()
{   
	if(document.forms[0].sel_applicant.value=="0")
	{
		alert("Select Loan Applicant");
		document.forms[0].sel_applicant.focus();
		return;
	}
    if(document.forms[0].txt_warehouse.value=="")
	{
		alert("Enter Name of the warehouse");
		document.forms[0].txt_warehouse.focus();
		return;
	}  
	
	if(document.forms[0].sel_license.value=="1")
	{
		if(document.forms[0].txt_licenseno.value=="")
		{
			alert("Enter License No");
			document.forms[0].txt_licenseno.focus();
			return;
		}
	} 
	if(document.forms[0].sel_warehouse.value=="0")
	{
		alert("Select Type of WareHouse");
		document.forms[0].sel_warehouse.focus();
		return;
	}
	if(document.forms[0].sel_warehouse.value=="4" || document.forms[0].sel_warehouse.value=="5")
	{
		if(document.forms[0].sel_ownedother.value=="0")
		{
			alert("Select Type of WareHouse");
			document.forms[0].sel_ownedother.focus();
			return;
		}
	}
	
	
/*	
    for(i=0;i<3;i++)
	  {
	     if(document.forms[0].txt_namewarehouse1[i].value!="")
	       {
	      
		          if(document.forms[0].txt_warehousedoc1[i].value=="")
		   		  {
			   		alert("Enter warehouse Receipts No");
			   		document.forms[0].txt_warehousedoc1[i].focus();
			   		return;
		   		  }
		   		 if(document.forms[0].txt_marketrate1[i].value=="" || document.forms[0].txt_marketrate1[i].value=="0.00")
		   		  {
			   		alert("Enter Market rate per unit");
			   		document.forms[0].txt_marketrate1[i].focus();
			   		return;
		   		  }
		   		  if(document.forms[0].txt_invoiceval1[i].value=="")
		   		  {
			   		alert("Enter Value as per warehouse receipt");
			   		document.forms[0].txt_invoiceval1[i].focus();
			   		return;
		   		  }
		   		   if(document.forms[0].txt_invoicedate1[i].value=="")
		   		  {
			   		alert("Enter Date of Receipt");
			   		document.forms[0].txt_invoicedate1[i].focus();
			   		return;
		   		  }
	       }
	   
	   }
*/
var len = document.forms[0].sel_applicant.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_applicant.options[i].selected==true)
		 {
			 document.forms[0].sel_applicanttext.value = document.forms[0].sel_applicant.options[i].text; 
			break;
		 }
	}
	
	var len = document.forms[0].sel_license.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_license.options[i].selected==true)
		 {
			 document.forms[0].sel_licensetext.value = document.forms[0].sel_license.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].sel_warehouse.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_warehouse.options[i].selected==true)
		 {
			 document.forms[0].sel_warehousetext.value = document.forms[0].sel_warehouse.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].sel_insurance.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_insurance.options[i].selected==true)
		 {
			 document.forms[0].sel_insurancetext.value = document.forms[0].sel_insurance.options[i].text; 
			break;
		 }
	}


   // enableButtons(true, true, false, false, true);
   document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agriculture";		
	document.forms[0].hidSourceUrl.value="/action/agr_capldetails.jsp";
	document.forms[0].hidBeanMethod.value="updatecapldata";
	document.forms[0].hidBeanGetMethod.value="getcapldata";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
 	disableFields(false);
 	document.forms[0].hidAction.value ="insert";
 	enableButtons(true, false, false, false, true);
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidBeanGetMethod.value="getcapldata";
		document.forms[0].action=appUrl +"action/agr_capldetails.jsp";
		document.forms[0].submit(); 		
	}	
}



function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appUrl+"action/"+"retailpge.jsp";
		document.forms[0].submit();
	}
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
			if(document.forms[0].elements[i].type=='text') 
			{
				document.forms[0].elements[i].readOnly=one;
				
				if(document.forms[0].elements[i].name=='txt_invoicedate1')
				{
					document.forms[0].elements[i].readOnly=true;
				}
				if(document.forms[0].elements[i].name=='txt_marketval1')
				{
					document.forms[0].elements[i].readOnly=true;
				}
			
			}
			if(document.forms[0].elements[i].type=='select-one')
	 		{
			document.forms[0].elements[i].disabled=one;
	 		}
		 	if(document.forms[0].elements[i].type=='checkbox')
		 	{
				document.forms[0].elements[i].disabled=one;
		 	}
		    if(document.forms[0].elements[i].type=='textarea')
		 	{
				document.forms[0].elements[i].readOnly=one;
			}
	}
	//document.forms[0].txt_date.readOnly=true;
	//document.forms[0].txt_duedate.readOnly=true;
	document.forms[0].txt_marketval1.readOnly=true;	
    document.forms[0].txt_totmarketval.readOnly=true;
    document.forms[0].txt_totloanamt.readOnly=true;
}


function doDelete()
{

var len = document.forms[0].sel_applicant.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_applicant.options[i].selected==true)
		 {
			 document.forms[0].sel_applicanttext.value = document.forms[0].sel_applicant.options[i].text; 
			break;
		 }
	}
	
	var len = document.forms[0].sel_license.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_license.options[i].selected==true)
		 {
			 document.forms[0].sel_licensetext.value = document.forms[0].sel_license.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].sel_warehouse.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_warehouse.options[i].selected==true)
		 {
			 document.forms[0].sel_warehousetext.value = document.forms[0].sel_warehouse.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].sel_insurance.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_insurance.options[i].selected==true)
		 {
			 document.forms[0].sel_insurancetext.value = document.forms[0].sel_insurance.options[i].text; 
			break;
		 }
	}
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatecapldata";
		document.forms[0].hidBeanGetMethod.value="getcapldata";
		document.forms[0].hidBeanId.value="agriculture";
		document.forms[0].hidSourceUrl.value="action/agr_capldetails.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}	
}
function calloantotal()
{
	var totalvalue1=0.00,totalvalue2=0.00,totalval3=0.00;	
	for(i=0;i<3;i++)
	{
		var value1 =  document.forms[0].txt_marketval1[i].value;
		var value2 =  document.forms[0].txt_loanamt[i].value;
		var value3 =  document.forms[0].txt_invoiceval1[i].value;
    	if( value1 =="")
		{
			 value1 =0.00;
		}
		if( value2 =="")
		{
			 value2 =0.00;
		}
		if(value3=="")
		{

			value3=0.00;
		}
		totalvalue1 = eval(value1)+eval(totalvalue1)
		totalvalue2 = eval(value2)+eval(totalvalue2)
		totalval3= eval(value3)+eval(totalval3)
	}
    document.forms[0].txt_totmarketval.value= eval(totalvalue1);
    roundtxt(document.forms[0].txt_totmarketval);
    document.forms[0].txt_totloanamt.value= eval(totalvalue2);
    roundtxt(document.forms[0].txt_totloanamt);
    document.forms[0].txt_totlreciptvalue.value= eval(totalval3);
    roundtxt(document.forms[0].txt_totlreciptvalue);
}
	
function doCal()
{
	var unit=0.00,cost=0.00;
   	for(i=0;i<3;i++)
	{
 		var unit=document.forms[0].txt_units1[i].value;
		var cost=document.forms[0].txt_marketrate1[i].value;
		var total=0;
   		if(unit==""){
    		unit="1";
	   	}
   		if(cost==""){
	      cost="0";
		}
   	total=eval(cost)*eval(unit);
   	document.forms[0].txt_marketval1[i].value=total;
	roundtxt(document.forms[0].txt_marketval1[i]); 
	}
}

function callselownedother()
{
	if(document.forms[0].sel_warehouse.value=="4" || document.forms[0].sel_warehouse.value=="5")
	{
		document.all.sel_ownedother.style.display="table-cell";
	}
	else
	{
		document.all.sel_ownedother.style.display="none";
	}
}

</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();calloantotal()">
<form name="frmpri" class="normal" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
      <td class="page_flow">Home -> Agriculture -> Details of produce pledged</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="67" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<table class="outertable border1" align="center" width="100%" border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td>
	<table class="outertable" align="center" width="98%" border="0" cellpadding="3" cellspacing="0">
	<tr>
		<td width="20%">Loan Applicant <b><span class="mantatory">*</span></b></td>
		<td width="80%" colspan="5">
			<select name="sel_applicant" onChange="">
				<option value="0" selected>------select-----</option>
				<option value="1">Farmer with crop loan from our Bank</option>
				<option value="2">Farmer with crop loan from other Banks</option>
		<!-- 	<option value="3">Trader with valid license for above 1 year</option>  -->	<!--  Commented by DINESH on 18/03/2014 as per change request -->
				<option value="4">Others</option>
			</select>
		</td>
	</tr>
	<tr class="dataheader">
		<td height="30" colspan="6"> 
			Particulars of warehouse where goods are stored</td>
	</tr>
	<tr>
		<td width="15%"></td>
		<td width="20%"></td>
		<td width="15%"></td>
		<td width="20%"></td>
		
	</tr>
	<tr>
		<td>Name of the warehouse <b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="txt_warehouse"
			value="<%=Helper.correctNull((String)hshValues.get("txt_warehouse"))%>"
			size="35" onKeyPress="allowAlphaNumericSpace()" maxlength="50">
		</td>
		<td>Godown No.</td>
		<td nowrap> <input type="text" name="txtgodownno"
			value="<%=Helper.correctNull((String)hshValues.get("txtgodownno"))%>"
			size="20%" maxlength="20">
		</td>
	</tr>
	<tr>
		<td>License</td>
		<td><select name="sel_license" onChange="checklicense()">
			<option value="0" selected>--select--</option>
			<option value="1">license to deal in proposed commodity</option>
			<option value="2">No License</option>
		</select></td>
		<td id="l1">License No <b><span class="mantatory">*</span></b></td>
		<td id="l2"><input type="text" name="txt_licenseno"
			value="<%=Helper.correctNull((String)hshValues.get("txt_licenseno"))%>"
			size="20%" maxlength="25"></td>
	</tr>
	<tr>
		<td>Address</td>
		<td><textarea name="txr_address" cols="25" rows="2"
			onKeyPress="notAllowSingleQuote();textlimit(txr_address,200)" onKeyUp="textlimit(this,200)"><%=Helper.correctNull((String)hshValues.get("txr_address" ))%></textarea>
		</td>
		<td>Type of WareHouse<b><span class="mantatory">*</span></b></td>
		<td>
		<table width="100%">
		<tr><td nowrap width="50%"><select name="sel_warehouse" onChange="callselownedother();">
			<option value="0" selected>--select--</option>
			<option value="1">Central WareHousing Corporation</option>
			<option value="2">State WareHousing Corporation</option>
			<option value="3">Bank empanelled ware house</option>
			<option value="4">Owned by others</option>
			<option value="5">Managed by Collateral Manager</option>
		</select>
		</td>
		<td align="left" width="25%">
		<select name="sel_ownedother">
					<option value="0" selected="selected">--select--</option>
					<option value="1">NBHC</option>
					<option value="2">Staragri</option>
					<option value="3">MCMSL</option>
					<option value="4">EDELWEISS</option>
		</select>
		</td>
		<td>&nbsp;</td>
		</tr>
		</table>
		</td></tr>
	<tr>
		<td>Distance from Branch</td>
		<td> <input
			type="text" name="txt_distance"
			value="<%=Helper.correctNull((String)hshValues.get("txt_distance"))%>"
			size="5%" onKeyPress="allowDecimals(this)" maxlength="3"> (Km) </td>
		<td>Accessibility</td>
		<td><b> <input type="text" name="txt_accesibilty"
			value="<%=Helper.correctNull((String)hshValues.get("txt_accesibilty"))%>"
			size="20%" onKeyPress="notAllowSplChar()" maxlength="15"> </b></td>
	</tr>
	
	<!-- <tr><td>Select Unit<b><span class="mantatory">*</span></b></td>
	 <td><select name="sel_units">
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="121"/></select></td></tr> -->
</table>
<table class="outertable" align="center" width="98%" border="0" cellspacing="1" cellpadding="3" style="visibility: hidden;position: absolute;">
	<tr class="dataheader">
		<td width="14%" align="center"> 
			Name &amp; Description of the goods to be pledged</td>
		<td width="14%" align="center"> 
			Document of title to goods &amp; or warehouse Receipts<b>
			<span class="mantatory">*</span></b></td>
		<td width="10%" align="center"> 
			No. of units to be Pledged</td>
		<td width="15%" align="center"> 
			Weight/Measurement units in Quintals</td>
		<td width="10%" align="center"> 
			Market rate per unit<b><span class="mantatory">*</span></b></td>
		<td width="9%" align="center"> 
			Total Market Value</td>
		<td width="9%" align="center" style="visibility:hidden;position:absolute"> 
			Loan Amount requested</td>
		
      <td width="9%" align="center"> 
			 Value as per warehouse receipt<b><span class="mantatory">*</span></b></td>
		<td width="18%" align="center"> 
			Date of Receipt<b><span class="mantatory">*</span></b></td>
	</tr>
	<tr class="datagrid">
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(0);

				if (arryCol.size() != 0) {

					l1 = Helper.correctNull((String) arryCol.get(4));
					d1 = Helper.correctNull((String) arryCol.get(5));
					u1 = Helper.correctNull((String) arryCol.get(6));
					w1 = Helper.correctNull((String) arryCol.get(7));
					m1 = Helper.correctNull((String) arryCol.get(8));
					tm1 = Helper.correctNull((String) arryCol.get(9));
					v1 = Helper.correctNull((String) arryCol.get(10));
					id = Helper.correctNull((String) arryCol.get(11));
					lm1 = Helper.correctNull((String) arryCol.get(12));
				}

			} else if (arryRow.size() == 0) {
				l1 = "";
				d1 = "";
				u1 = "";
				w1 = "";
				m1 = "";
				tm1 = "";
				v1 = "";
				lm1 = "";
			}

			%>
		<td align="center"><input type="text" name="txt_namewarehouse1"
			value="<%=l1%>" size="13%" onKeyPress="notAllowSplChar()"
			maxlength=50"></td>
		<td align="center"><input type="text" name="txt_warehousedoc1"
			value="<%=d1%>" size="25" onKeyPress="notAllowSplChar()"
			maxlength="50" onBlur="calloantotal();doCal()"></td>
		<td align="center"><input type="text" name="txt_units1"
			value="<%=u1%>" size="10" onKeyPress="allowNumber(this)"
			maxlength="8"></td>
		<td align="center"><input type="text" name="txt_weight1"
			value="<%=w1%>" size="10%" onKeyPress="allowNumber(this)"
			maxlength="8">&nbsp;<select name="sel_unitsy1" >
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="136"/></select></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketrate1"
			value='<%=m1%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketval1"
			value='<%=tm1%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"  style="visibility:hidden;position:absolute"><lapschoice:CurrencyTag name="txt_loanamt"
			value='<%=lm1%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_invoiceval1"
			value="<%=v1%>" size="13%" onKeyPress="allowNumber(this)"
			maxlength="8" onBlur="calloantotal();doCal()" /></td>
		<td align="center"><input type="text" name="txt_invoicedate1"
			value="<%=id%>" size="10%" onKeyPress="" maxlength="10"
			onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#"
			onClick="callCalender('txt_invoicedate1[0]')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="23" border="0"></a></td>
	</tr>
	<tr class="datagrid">
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(1);

				if (arryCol.size() != 0) {

					l2 = Helper.correctNull((String) arryCol.get(4));
					d2 = Helper.correctNull((String) arryCol.get(5));
					u2 = Helper.correctNull((String) arryCol.get(6));
					w2 = Helper.correctNull((String) arryCol.get(7));
					m2 = Helper.correctNull((String) arryCol.get(8));
					tm2 = Helper.correctNull((String) arryCol.get(9));
					v2 = Helper.correctNull((String) arryCol.get(10));
					id2 = Helper.correctNull((String) arryCol.get(11));
					lm2 = Helper.correctNull((String) arryCol.get(12));
				}

			} else if (arryRow.size() == 0) {
				l2 = "";
				d2 = "";
				u2 = "";
				w2 = "";

				m2 = "";
				tm2 = "";
				v2 = "";
				lm2 = "";
			}

			%>
		<td align="center"><input type="text" name="txt_namewarehouse1"
			value="<%=l2%>" size="13%" onKeyPress="notAllowSplChar()"
			maxlength="50"></td>
		<td align="center"><input type="text" name="txt_warehousedoc1"
			value="<%=d2%>" size="25" onKeyPress="notAllowSplChar()"
			maxlength="50" onBlur="calloantotal();doCal()"></td>
		<td align="center"><input type="text" name="txt_units1"
			value="<%=u2%>" size="10" onKeyPress="allowNumber(this)"
			maxlength="8"></td>
		<td align="center"><input type="text" name="txt_weight1"
			value="<%=w2%>" size="10%" onKeyPress="allowNumber(this)"
			maxlength="8">&nbsp;<select name="sel_unitsy2" >
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="136"/></select></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketrate1"
			value='<%=m2%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketval1"
			value='<%=tm2%>' size="13%" maxlength="8" style="text-align:right"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"  style="visibility:hidden;position:absolute"><lapschoice:CurrencyTag name="txt_loanamt"
			value='<%=lm2%>' size="13%" maxlength="8" style="text-align:right"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_invoiceval1"
			value='<%=v2%>' size="13%" onKeyPress="allowNumber(this)"
			maxlength="8" onBlur="calloantotal();doCal()"/></td>
		<td align="center"><input type="text" name="txt_invoicedate1"
			value="<%=id2%>" size="10%" maxlength="8"
			onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#"
			onClick="callCalender('txt_invoicedate1[1]')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="23" border="0"></a></td>
	</tr>
	<tr class="datagrid">
		<%if (arryRow.size() != 0) {
				arryCol = (ArrayList) arryRow.get(2);

				if (arryCol.size() != 0) {

					l3 = Helper.correctNull((String) arryCol.get(4));
					d3 = Helper.correctNull((String) arryCol.get(5));
					u3 = Helper.correctNull((String) arryCol.get(6));
					w3 = Helper.correctNull((String) arryCol.get(7));
					m3 = Helper.correctNull((String) arryCol.get(8));
					tm3 = Helper.correctNull((String) arryCol.get(9));
					v3 = Helper.correctNull((String) arryCol.get(10));
					id3 = Helper.correctNull((String) arryCol.get(11));
					lm3 = Helper.correctNull((String) arryCol.get(12));
				}

			} else if (arryRow.size() == 0) {
				l3 = "";
				d3 = "";
				u3 = "";
				w3 = "";
				m3 = "";
				tm3 = "";
				v3 = "";
				lm3 = "";
			}

			%>
		<td align="center"><input type="text" name="txt_namewarehouse1"
			value="<%=l3%>" size="13%" onKeyPress="notAllowSplChar()"
			maxlength="50"></td>
		<td align="center"><input type="text" name="txt_warehousedoc1"
			value="<%=d3%>" size="25" onKeyPress="notAllowSplChar()"
			maxlength="50" onBlur="calloantotal();doCal()"></td>
		<td align="center"><input type="text" name="txt_units1"
			value="<%=u3%>" size="10" onKeyPress="allowNumber(this)"
			maxlength="8"></td>
		<td align="center"><input type="text" name="txt_weight1"
			value="<%=w3%>" size="10%" onKeyPress="allowNumber(this)"
			maxlength="8">&nbsp;<select name="sel_unitsy3" >
                    			 <option value="">--Select--</option>
                    			 <lapschoice:StaticDataNewTag apptype="136"/></select></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketrate1"
			value='<%=m3%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_marketval1"
			value='<%=tm3%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"  style="visibility:hidden;position:absolute"><lapschoice:CurrencyTag name="txt_loanamt"
			value='<%=lm3%>' size="13%" maxlength="8"
			onBlur="calloantotal();doCal()" /></td>
		<td align="center"><lapschoice:CurrencyTag name="txt_invoiceval1"
			value='<%=v3%>' size="13%" onKeyPress="allowNumber(this)"
			maxlength="8" onBlur="calloantotal();doCal()"/></td>
		<td align="center"><input type="text" name="txt_invoicedate1"
			value="<%=id3%>" size="10%" maxlength="8"
			onBlur="checkDate(this);checkmaxdate(this,currdate)"> <a href="#"
			onClick="callCalender('txt_invoicedate1[2]')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="23" border="0"></a></td>
	</tr>
	<tr class="datagrid">
		<td > 
			Total(<%=ApplicationParams.getCurrency()%>)</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	
		<td><lapschoice:CurrencyTag name="txt_totmarketval" value=''
			size="15%" maxlength="8" /></td>
		<td  style="visibility:hidden;position:absolute"><lapschoice:CurrencyTag name="txt_totloanamt" value='' size="15%"
			maxlength="8" /></td>
			<td align="center"><lapschoice:CurrencyTag name="txt_totlreciptvalue" value=''
			size="15%" maxlength="8" /></td>
		<td>&nbsp;</td>
		<td>&nbsp;</td>
	</tr>
</table>
<table align="center" class="outertable" width="98%" border="0" cellspacing="0" cellpadding="3">
	<tr class="dataheader">
		<td colspan="4"> Insurance	of Goods</td>
	</tr>
	<tr>
		<td width="27%">Insurance of the
		goods Effected</td>
		<td colspan="3"><select name="sel_insurance" onChange="">
			<option value="0" selected>select</option>
			<option value="1">By the warehouse</option>
			<option value="2">By the Applicant</option>
		</select></td>
	</tr>
	<tr>
		<td>Name of the Insurance Company</td>
		<td colspan="3"><input type="text" name="txt_insurance"
			value="<%=Helper.correctNull((String)hshValues.get("txt_insurance"))%>"
			size="50%" onKeyPress="" maxlength="100"></td>
	</tr>
	<tr>
		<td>Policy No./Cover note no.</td>
		<td width="17%"><input type="text" name="txt_policyno"
			value="<%=Helper.correctNull((String)hshValues.get("txt_policyno"))%>"
			size="20%" onKeyPress="" maxlength="20"></td>
		<td width="14%">Date</td>
		<td width="42%"><input type="text" name="txt_date"
			value="<%=Helper.correctNull((String)hshValues.get("txt_date"))%>"
			size="20%" onKeyPress="" maxlength="10"
			onBlur="checkDate(this);checkmaxdate(this,currdate);"> <a href="#"
			onClick="callCalender('txt_date')" title="Click to view calender"
			border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			width="0" height="23" border="0"></a></td>
	</tr>
	<tr>
		<td>Amount(in <%=ApplicationParams.getCurrency()%>)</td>
		<td><lapschoice:CurrencyTag name="txt_amount" size="18"
			value='<%=Helper.correctNull((String)hshValues.get("txt_amount"))%>'
			maxlength="15" onBlur="roundtxt(this)" /></td>
		<td>Due Date</td>
		<td><input type="text" name="txt_duedate"
			value="<%=Helper.correctNull((String)hshValues.get("txt_duedate"))%>"
			size="20%" onKeyPress="" maxlength="19" onBlur ="checkDate(this);checkmindate(this,document.forms[0].txt_date.value);"> <a href="#"
			onClick="callCalender('txt_duedate')" title="Click to view calender"
			border=0><img src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			width="0" height="23" border="0"></a></td>
	</tr>
</table></td></tr></table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="hidAction"> 
<input type="hidden" name="hidBeanId"> 
<INPUT TYPE="hidden" NAME="hidscheme" VALUE="<%=stragrschemetype%>">
<INPUT TYPE="hidden" NAME="hidSno" VALUE="<%=strfacsno%>">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidSourceUrl"> 
<INPUT TYPE="hidden" NAME="hidPageSource" VALUE=""> 
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="">
<input type="hidden" name="hidappno" value="<%=request.getParameter("appno")%>">
<INPUT TYPE="hidden" NAME="hidOtherMethod" VALUE=""> 
<input type="hidden" name="hidAppType">
<input type="hidden" name="sel_applicanttext" value=""/>
<input type="hidden" name="sel_licensetext" value=""/>
<input type="hidden" name="sel_warehousetext" value=""/>
<input type="hidden" name="sel_insurancetext" value=""/>
</form>
</body>
</html>