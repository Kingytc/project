<%@include file="../share/directives.jsp"%>
<%String checkStaff = Helper.correctNull((String) hshValues.get("checkStaff"));
String strauto_takeover=Helper.correctNull((String)hshValues.get("auto_take_over"));
String strFreeze=Helper.correctNull((String)request.getParameter("hidFreeze"));
String prd_type = Helper.correctNull((String)session.getAttribute("strProductType"));
String strProAvailableFor=Helper.correctNull((String) request.getParameter("hidApplicableFor"));
String strTake_over=Helper.correctNull((String)hshValues.get("loan_takeover"));
String strPrdPurpose=Helper.correctNull((String) session.getAttribute("strPrdPurpose"));
int linkid=5;
String strFreezeflag = Helper.correctNull((String)hshValues.get("strFreezeflag"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
session.setAttribute("VehicleEdit_Flag", Helper.correctNull((String)hshValues.get("VehicleEdit_Flag")));
%>
<html>
<head>
<title>Personal - Vehicle</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/perappvehicle.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript">

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var selectpurdurable="<%=Helper.correctNull((String)hshValues.get("auto_purpose"))%>";
var cmbauto_category = "<%=Helper.correctNull((String)hshValues.get("auto_category"))%>";
var vehicletype = "<%=Helper.correctNull((String)hshValues.get("vehtype"))%>";
var selauthdealer = "<%=Helper.correctNull((String)hshValues.get("auth_dealer"))%>";
var AUTO_SALTOSB = "<%=Helper.correctNull((String)hshValues.get("AUTO_SALTOSB"))%>";
var AUTO_UNDERTKNGLETTER = "<%=Helper.correctNull((String)hshValues.get("AUTO_UNDERTKNGLETTER"))%>";
var chkboxdealer="<%=Helper.correctNull((String)hshValues.get("remark_gen"))%>";
var auto_articlename="<%=Helper.correctNull((String)hshValues.get("auto_articlename"))%>";
var radio_applicantdrivenvehicle="<%=Helper.correctNull((String)hshValues.get("radio_applicantdrivenvehicle"))%>";
var fuelused="<%=Helper.correctNull((String)hshValues.get("txt_fuelused"))%>";
var auto_take_over="<%=Helper.correctNull((String)hshValues.get("auto_take_over"))%>";
var staffCond="<%=checkStaff%>";
var currentdate= "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varstrFreeze="<%=strFreeze%>";
var natureCharge =  "<%=Helper.correctNull((String)hshValues.get("auto_natureofcharge"))%>";
var vartakeover="<%=Helper.correctNull((String) hshValues.get("loan_takeover"))%>";
var varoldvehtype="<%=Helper.correctNull((String) hshValues.get("AUTO_OLDVEHICLETYPE"))%>";
var varprd_type="<%=prd_type%>";
var varProAvailableFor="<%=strProAvailableFor%>";
var var_vehAge="<%=Helper.correctNull((String)hshValues.get("loan_ageofveh"))%>";
var varcustrelease="<%=Helper.correctNull((String)hshValues.get("cus_release_flag"))%>";
var varsessionmodtype="<%=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim()%>";
function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].hidsecID.value=="" )
		{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}	
}

function callopeviability()
{
	var appno = document.forms[0].appno.value;
	var prop = "scrollbars=yes,width=575,height=550,menubar=yes";
	var title = "";
	var xpos = 4;
	var ypos = 4;
	prop = prop + ",left="+xpos+",top="+ypos;
	var url=appURL+"action/operationalviability.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getOpeViability&appno="+appno; //+"&comappid="+comappid;
	window.open(url,title,prop);
}
function callUsersHelp()
{
	if(document.forms[0].cmdedit.disabled==true)
	{
		var prop="scrollbars=no,width=500,height=400,top=100,left=250";
		var url=appURL +"action/selectusers.jsp?hidBeanId=appraisal&hidBeanGetMethod=getuserslist";
		window.open(url,"",prop);
	}
}
function caculatetot()
{
	var costprice=document.forms[0].txtauto_valuation.value;
	var accessoriesprice=document.forms[0].txtauto_accessories.value;
    var txtauto_tax=document.forms[0].txtauto_tax.value;
	var txtauto_insurance=document.forms[0].txtauto_insurance.value;
	var txtauto_charges=document.forms[0].txtauto_charges.value;	
	var discount=document.forms[0].txt_discount.value;
	if (costprice=="")
		{
		costprice = "0";
		}
	if (accessoriesprice=="")
		{
		accessoriesprice = "0";
		}
	if (txtauto_tax=="")
		{
		txtauto_tax = "0";
		}
	if (txtauto_insurance=="")
		{
		txtauto_insurance = "0";
		}
	if (txtauto_charges=="")
		{
		txtauto_charges = "0";
		}		
	if (discount=="")
		{
		discount = "0";
		}		
	var str_dtotal1= (parseFloat(costprice) + parseFloat(accessoriesprice)+parseFloat(txtauto_tax)+parseFloat(txtauto_insurance) + parseFloat(txtauto_charges)) - parseFloat(discount);
	str_dtotal=Math.ceil(str_dtotal1);
	document.forms[0].txtauto_totcost.value=str_dtotal;
	roundtxt(document.forms[0].txtauto_totcost)	        
}
function totalcost1()
{
var totcost=document.forms[0].txtauto_totcost.value;
var discount=document.forms[0].txt_discount.value;
var totcost1=totcost-discount;
document.forms[0].txtauto_totcost.value=totcost1;
roundtxt(document.forms[0].txtauto_totcost);
}
function callleastvalue()
{
	var originalcost =document.forms[0].txt_originalcost.value;
	var actualconsideration = document.forms[0].txt_actualconsideration.value;
	var valuation = document.forms[0].txtauto_valuation1.value;	
	var leastval;	
	if(originalcost=="")
	{
		originalcost = "0.00";
	}
	if(actualconsideration=="")
	{
		actualconsideration = "0.00";
	}
	if(valuation=="")
	{
		valuation = "0.00";
	}
	if(eval(parseFloat(originalcost)) <= eval(parseFloat(actualconsideration)))
	{		
		leastval = originalcost;		
	}
	else
	{	
		leastval = actualconsideration;
	}	
	if(eval(parseFloat(leastval)) <= eval(parseFloat(valuation)))
	{	
		leastval = leastval;
	}
	else
	{	
		leastval = valuation;
	}	
	document.forms[0].txt_leastvalue.value = (parseFloat(leastval));
	document.forms[0].txt_leastvalue.readOnly = true;
}
function calculateAgeofVehicle()
{
	var age = document.forms[0].txtauto_age.value;
	var maxage = '<%=Helper.correctNull((String) hshValues.get("prd_vehloanperiod"))%>';
	if(age == "")
	{
		age = "0";
	}
	if(staffCond=="staff")
	{
		var maxage2wheeler = "5";
		var maxage4wheeler = "10";
		if(document.getElementById("sel_vehicletype").value=="1" && (eval(age)>eval(maxage2wheeler)))
		{
			alert("Secondhand Two Wheeler Cannot Exceeds More than 5 Years");
			document.forms[0].txtauto_age.value="";
			document.forms[0].txtauto_age.focus();
			return;
		}
		else if(document.getElementById("sel_vehicletype").value=="3" && (eval(age)>eval(maxage4wheeler)))
		{
			alert("Secondhand Four Wheeler Cannot Exceeds More than 10 Years");
			document.forms[0].txtauto_age.value="";
			document.forms[0].txtauto_age.focus();
			return;
		}		
	}
	else if(eval(age) > eval(maxage))
	{
		alert("Vehicle age should not be greater than "+maxage+"  years");
		document.forms[0].txtauto_age.value="";
		document.forms[0].txtauto_age.focus();
		return;
	}
}
function callCalender(name)
{
if(document.forms[0].cmdedit.disabled==true)
	{
	showCal(appURL,name);
	}
}
function enablevalues()
{	
	if(document.forms[0].cmbauto_category.value=="1")
	{
	    document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
	    
	    document.all.b2.style.visibility="visible";
		document.all.b2.style.position="relative";
	    
	    document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		
		document.all.a3.style.visibility="visible";
		document.all.a3.style.position="relative";
		
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		
		document.all.a5.style.visibility="visible";
		document.all.a5.style.position="relative";
		
		document.all.a6.style.visibility="visible";
		document.all.a6.style.position="relative";
		
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		
		document.all.a8.style.visibility="visible";
		document.all.a8.style.position="relative";

		document.all.registration.style.visibility="hidden";
	    document.all.registration.style.position="absolute";
		document.all.registration1.style.visibility="hidden";
		document.all.registration1.style.position="absolute";
		document.all.registration2.style.visibility="hidden";
		document.all.registration2.style.position="absolute";	
	
		//callMakeNull();
		document.forms[0].txtauto_age.readOnly=true;
		document.forms[0].txt_originalcost.readOnly=true;
		document.forms[0].txtauto_valuation1.readOnly=true;
		document.forms[0].txt_actualconsideration.readOnly=true;
		document.forms[0].txt_leastvalue.readOnly=true;		
		document.forms[0].txtauto_engine.value.readOnly=true;
		document.forms[0].txtauto_ownername.readOnly=true;
		
		document.forms[0].txtauto_valuation.readOnly=false;
		document.forms[0].txtauto_accessories.readOnly=false;
		document.forms[0].txtauto_tax.readOnly=false;
		document.forms[0].txtauto_insurance.readOnly=false;
		document.forms[0].txtauto_charges.readOnly=false;
		document.forms[0].txtauto_totcost.readOnly=true;
		document.forms[0].txtauto_chasis.readOnly=false;
		document.forms[0].txtauto_valuation.focus();
	}
	else if(document.forms[0].cmbauto_category.value=="2")
	{
	    document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
		 document.all.b1.style.visibility="visible";
		document.all.b1.style.position="relative";
	
	    document.all.a1.style.visibility="visible";
		document.all.a1.style.position="relative";
		
		document.all.a2.style.visibility="visible";
		document.all.a2.style.position="relative";
		
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		
		document.all.a4.style.visibility="visible";
		document.all.a4.style.position="relative";
		
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		
		document.all.a7.style.visibility="visible";
		document.all.a7.style.position="relative";
		
		document.all.a8.style.visibility="hidden";
		document.all.a8.style.position="absolute";	

		document.all.registration.style.visibility="visible";
		document.all.registration.style.position="relative";
		document.all.registration1.style.visibility="visible";
		document.all.registration1.style.position="relative";
		document.all.registration2.style.visibility="visible";
		document.all.registration2.style.position="relative";
		
		//callMakeNull();
		//document.forms[0].txtauto_age.readOnly=false;
		document.forms[0].txt_originalcost.readOnly=false;
		document.forms[0].txtauto_valuation1.readOnly=false;
		document.forms[0].txt_actualconsideration.readOnly=false;
		document.forms[0].txt_leastvalue.readOnly=false;
		document.forms[0].txtauto_valuation.readOnly=true;
		document.forms[0].txtauto_accessories.readOnly=true;
		document.forms[0].txtauto_tax.readOnly=true;
		document.forms[0].txtauto_insurance.readOnly=true;
		document.forms[0].txtauto_charges.readOnly=true;
		document.forms[0].txtauto_totcost.readOnly=true;
		document.forms[0].txtauto_chasis.readOnly=false;
		document.forms[0].txtauto_engine.value.readOnly=false;
		document.forms[0].txtauto_ownername.readOnly=false;
		document.forms[0].txtauto_vehicles.readOnly=false;
		//document.forms[0].txtauto_age.focus();		
	}
	else 
	{
	    document.all.b2.style.visibility="hidden";
		document.all.b2.style.position="absolute";
		
		document.all.b1.style.visibility="hidden";
		document.all.b1.style.position="absolute";
	
	    document.all.a1.style.visibility="hidden";
		document.all.a1.style.position="absolute";
		
		document.all.a2.style.visibility="hidden";
		document.all.a2.style.position="absolute";
		
		document.all.a3.style.visibility="hidden";
		document.all.a3.style.position="absolute";
		
		document.all.a4.style.visibility="hidden";
		document.all.a4.style.position="absolute";
		
		document.all.a5.style.visibility="hidden";
		document.all.a5.style.position="absolute";
		
		document.all.a6.style.visibility="hidden";
		document.all.a6.style.position="absolute";
		
		document.all.a7.style.visibility="hidden";
		document.all.a7.style.position="absolute";
		
		document.all.a8.style.visibility="hidden";
		document.all.a8.style.position="absolute";
	    //callMakeNull();	

	    document.all.registration.style.visibility="hidden";
	    document.all.registration.style.position="absolute";
		document.all.registration1.style.visibility="hidden";
		document.all.registration1.style.position="absolute";
		document.all.registration2.style.visibility="hidden";
		document.all.registration2.style.position="absolute";
	}	
	easyride();
}

function easyride()
{
	if(document.forms[0].sel_vehicletype.value=="1")
	{
		document.getElementById("two1").style.display="table";
	}
	else if(document.forms[0].sel_vehicletype.value=="3")
	{
		document.getElementById("two1").style.display="none";
	}
	else
	{
		document.getElementById("two1").style.display="none";
	}
}

function enableGeneralInfo()
{
	if(document.forms[0].sel_vehicletype.value=="1")
	{
		document.all.general1.style.visibility="visible";
		//document.all.general2.style.visibility="visible";
		document.all.general1.style.position="relative";
		//document.all.general2.style.position="relative";
	}
	else
	{
		document.all.general1.style.visibility="hidden";
		document.all.general1.style.position="absolute";
		//document.all.general2.style.visibility="hidden";
		//document.all.general2.style.position="absolute";
	}
	    
}
function selJointHolder()
{
	if (document.forms[0].sel_jointholder.value == "Y") {			
		document.all.ownership.style.visibility = "visible";
		document.all.ownership.style.position = "relative";
		document.all.ownership1.style.visibility = "visible";
		document.all.ownership1.style.position = "relative";
		document.all.id_jointsec.style.visibility="visible";
		document.all.id_jointsec.style.position="relative";
		document.all.id_ownerdet.style.visibility = "visible";
		document.all.id_ownerdet.style.position = "relative";
		
	} else{
		
		document.all.ownership.style.visibility = "hidden";
		document.all.ownership.style.position = "absolute";
		document.all.ownership1.style.visibility = "hidden";
		document.all.ownership1.style.position = "absolute";
		document.all.id_jointsec.style.visibility="hidden";
		document.all.id_jointsec.style.position="absolute";
		document.all.id_ownerdet.style.visibility = "hidden";
		document.all.id_ownerdet.style.position = "absolute";
	}

}

function callAddJointSecurity() 
{
	var varQryString = appURL + "action/addjointsecurities.jsp";
	var title = "ADD";
	var prop = "scrollbars=yes,width=650,height=400,menubar=yes";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString, title, prop);
}

function jointSecurityDel()
{
	var varLapsID=document.forms[0].txt_security_ownership.value;
	if(varLapsID=="")
	{

		alert("Please click the button to remove");
	}
	else
	{
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;
		for(var i=1;i<rowCount;i++)
		{
			if(document.forms[0].rad_chk[i-1].checked==true)
			{
				table.deleteRow(i);
				--i;     
				--rowCount; 
			}
		}
		document.forms[0].txt_security_ownership.value="";
	}
}

function callLAPSID(id)
{
	document.forms[0].txt_security_ownership.value=id;	
}
function jointownerdisp(securityowners)
{
	var var_arr= securityowners.split("@");
	var length=var_arr.length;
	for(var i=0;i<length-1;i=i+3)
	{
		var j=i;
		var table=document.all.id_jointsec;
		var rowCount=table.rows.length;
		
		var row=table.insertRow(rowCount);
		var varName=var_arr[j];
		var varLapsID=var_arr[++j];
		var varCBSID=var_arr[++j];
		
		var cell0=row.insertCell(0);
		cell0.className="datagrid";
		cell0.innerHTML='<input type="radio" style="border-style:none" name="rad_chk" onclick="callLAPSID('+varLapsID+')">';		
		
		var cell1=row.insertCell(1);
		cell1.className="datagrid";
		cell1.innerHTML=varName;
		
		var cell2=row.insertCell(2);
		cell2.className="datagrid";
		cell2.innerHTML=varLapsID;

		var cell3=row.insertCell(3);
		cell3.className="datagrid";
		cell3.innerHTML=varCBSID;

		var cell4=row.insertCell(4);
		cell4.className="datagrid";
		var element4=document.createElement("input");
		element4.type="hidden";
		element4.name="hid_jointID["+rowCount+"]";
		element4.value=varLapsID;
		cell4.appendChild(element4);			
	}

}
function jointownerdelall()
{
	var table=document.all.id_jointsec;
	var rowCount=table.rows.length;
	if(rowCount > 1)
	{
		for(var i=rowCount-1;i>0;i--)
		{
			table.deleteRow(i);      
		}
	}
	else
	{
		//No Function
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
function callMDTD()
{
	document.forms[0].action=appURL+"action/app_sec_MDTDdetails.jsp";
	document.forms[0].submit();	
}
function callLinkComments(page,bean,method,title)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidAction.value="";
	 	document.forms[0].hidBeanGetMethod.value=method;
	 	document.forms[0].hidBeanId.value=bean;
	 	document.forms[0].hpage.value=title;	 
	 	document.forms[0].action=appURL+"action/"+page;
	 	document.forms[0].submit();
	}
	else 
	{
		ShowAlert(103);
	}
}
function callalert()
{
	alert("Click Freeze in Attached Securities page to view Security Coverage");
	return;
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnload();caculatetot();">
<form name="colForm" method="post" class="normal">
 
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>

<% if(strSessionModuleType.equalsIgnoreCase("DIGI")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<% } else { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="22" />
        </jsp:include>
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
	 <%if(strSessionModuleType.equals("AGR")){%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; vehicle </td>
	<%} else if(strSessionModuleType.equals("DIGI")){ %>
		<td class="page_flow">Home -&gt; Dig Retail -&gt; Application  -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; Vehicle</td>
	<%}else{%>
		<td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Application  -&gt; Security Master -&gt; Proposed/Offered Asset -&gt; Vehicle</td>
		<%} %>			
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td>
        <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
          <tr align="center"> 
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLink('securitymaster_retail.jsp','bankappfi','getSecurityRetailDetails')">Borrower Securities</a></b></b>
            </td>
            <td align="center" width="15%" class="sub_tab_inactive"><b><b><a
					href="#" onclick="javascript:callLink('attachedsecurities_retail.jsp','bankappfi','getAttachedRetailSecurityDetails')">Attached Securities</a></b></b></td>
        
           <%if(strSessionModuleType.equals("RET") || strSessionModuleType.equals("DIGI") ){ %>
           
          	<%
				  if (prd_type.substring(0, 1).equalsIgnoreCase("p")
								&& !prd_type.equalsIgnoreCase("pE")
								&& !prd_type.equalsIgnoreCase("pG")
								&& !prd_type.equalsIgnoreCase("pM")
								&& !prd_type.equalsIgnoreCase("pL")
								&& !prd_type.equalsIgnoreCase("pI")) {
							if (linkid == 5) {
				%>
				<td class="sub_tab_active" WIDTH="15%" nowrap="nowrap"><b>Proposed/Offered
				Asset</b></td>
				<%
					} else if ((prd_type.equalsIgnoreCase("pH")&& !(strPrdPurpose.equalsIgnoreCase("F")||strPrdPurpose.equalsIgnoreCase("T")||strPrdPurpose.equalsIgnoreCase("HC")))
									|| prd_type.equalsIgnoreCase("pM")
									|| prd_type.equalsIgnoreCase("pI")
									|| prd_type.equalsIgnoreCase("pT")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getHousingLoanData','per_house_proposed_asset.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pA")||(prd_type.equalsIgnoreCase("pU") && strProAvailableFor.equalsIgnoreCase("V"))) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('percollateral','getBoatAuto','perappvehicle.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pD")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('perpropertydetails','getOtherAssetData','otherassets.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					} else if (prd_type.equalsIgnoreCase("pK")) {
				%>
				<td class="sub_tab_inactive" WIDTH="15%" nowrap="nowrap"><a
					href="JavaScript:gototab('agreconomic','getSolarlightData','per_solarlight.jsp')"><b>Proposed/Offered
				Asset</b></a></td>
				<%
					}
						}	
         		 %>
          <% } %>
          
          <%
			if(strFreezeflag.equalsIgnoreCase("Y")){%>
		 	<td align="center" width="15%" class="sub_tab_inactive_new"><b>
		 	 	<a href="JavaScript:callLink('com_attchsecuritydisplay_reatail.jsp','securitymaster','getCollateralSecurityDisplayretail')">
			 	Security Coverage</a></b></td>				
			<% }else{%>
			<td align="center" width="15%" class="sub_tab_inactive_new" align="center"><b><a href="JavaScript:callalert()">Security Coverage</a></b></td>
			
				<%} %>
				
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callLinkComments('per_commentsonseccovergae.jsp','facilities','getComments','secoverageretail')">Comments on Security Coverage</a></b></b></td>	
			<td align="center" width="15%" class="sub_tab_inactive"><b><b><a href="#" onclick="javascript:callMDTD()">MDTD</a></b></b></td>	
          
          </tr>
        </table>
      </td>
    </tr>
  </table>
<%} %> 
 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
			<tr>
				<td><jsp:include page="../per/ProposedAssetTabs.jsp" flush="true">
					<jsp:param name="tabid" value="2" />
				</jsp:include></td>
			</tr>
		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>

										<td>

										<table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
											<tr>
												<td nowrap align="left" width="20%">Brand Name</td>
												<td valign="top" width="30%"><input type="text"
													name="txtauto_article" size="35" maxlength="40"
													value="<%=Helper.correctNull((String)hshValues.get("auto_articlename"))%>" onKeyPress="notAllowSingleAndDoubleQuote();">
												</td>
												<td nowrap align="left" width="20%">Purchase of Vehicle<b><span class="mantatory">*&nbsp;</span></b></td>
												<td valign="top" width="30%"><select name="selectpurdurable" onChange="Showopervia()">
													<option value="0" selected>------Select-----</option>
													<option value="1">Private</option>
													<option value="2">Public</option>
													<option value="3">Commercial</option>
													<option value="4">Others</option>
												</select></td>
											</tr>
											<tr>
												<td nowrap>
												Category<b><span class="mantatory">*&nbsp;</span></b>
												</td>
												<td valign="top"><select name="cmbauto_category"
													onchange="enablevalues()">
													<option selected value="0">------Select------</option>
													<option value="1">New Vehicle</option>
													<option value="2">Second Hand Vehicle</option>
												</select></td>
												<td>Type <span class="mantatory">*&nbsp;</span></td>
												<td><select
													name="sel_vehicletype" onChange="easyride();funoldVehType();">
													<option value="0" selected>------Select-----</option>
													<option value="1">Two Wheeler</option>
													<option value="2">Three Wheeler</option>
													<option value="3">Four Wheeler</option>
												</select></td>
											</tr>
											<tr>
											<%if(checkStaff.equalsIgnoreCase("staff")){ %>
												<td id="old1">Type of Vehicle<span class="mantatory">*&nbsp;</span></td>
												<td id="old2"><select
													name="sel_oldcar_type">
													<option value="0" selected>------Select-----</option>
													<option value="1">Used Car</option>
													<option value="2">Certified Pre owned car</option>
												</select></td>
												<%}else{ %>
												<td colspan="2">&nbsp;</td>
												<%} %>
												<td nowrap align="left">Model &amp; Make <b><span class="mantatory">*&nbsp;</span></b></td>
												<td><input type="text" name="txtauto_model"
													size="5" maxlength="4"
													value="<%=Helper.correctNull((String)hshValues.get("auto_model"))%>"
													onKeyPress="allowInteger()"
													onBlur="min_nos(document.forms[0].txtauto_model,4)">
												&nbsp;&nbsp;&nbsp;<input type="text"
													name="txtauto_make" size="20" maxlength="40"
													value="<%=Helper.correctNull((String)hshValues.get("auto_make"))%>"
													onKeyPress="notAllowSplChar1(this)"></td>
											</tr>
											<tr>
											<td>Nature of Charge&nbsp;<span class="mantatory">*</span></td>
											<td> 
								              <select name="sel_natureCharge" tabindex="" >
												<option value="0" selected>---Select---</option>
								                <lapschoice:StaticDataNewTag apptype="134"  /> 
											 </select>
											</td>
											<td>Whether Take-Over<b><span class="mantatory">*&nbsp;</span></b></td>
											<td><select name="sel_take_over">
											<option value="0" selected>--Select--</option>
											<option value="Y">Yes</option>
											<option value="N">No</option>
											</select></td>
											</tr>
											<tr class="dataheader">
												<td colspan="4" nowrap id="b1"><b>If Second Hand Vehicle</b></td>
												<td colspan="4" nowrap id="b2"><b>If New Vehicle</b></td>
											</tr>
											<tr id="a1">
												<td nowrap align="left">Date of Manufacture</td>
												<td><input type="text" name="txt_dateofmanufac"
													size="12" maxlength="10"
													onBlur="checkDate(this);checkmaxdate(this,currentDate);checkStaffCondition()"
													value="<%=Helper.correctNull((String)hshValues.get("auto_datemanu"))%>">
												&nbsp;<a href="#"
													onClick="callCalender('txt_dateofmanufac')"
													title="Click to view calender" border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													width="0" border="0" tabindex="7"></a></td>
												<td colspan="2">&nbsp;</td>
											</tr>
											<tr id="a2">
												<td nowrap align="left">Age of Vehicle</td>
												<td><input type="text" name="txtauto_age"
													size="5" maxlength="2" onblur="calculateAgeofVehicle()"
													value="<%=Helper.correctNull((String)hshValues.get("loan_ageofveh"))%>"
													onKeyPress="allowInteger()"></td>

								<td nowrap>Original Cost of the Vehicle</td>
								<td><lapschoice:CurrencyTag name="txt_originalcost"
									maxlength="12" size="18"
									value='<%=Helper.correctNull((String) hshValues
							.get("auto_originalcost"))%>'
									onBlur="callleastvalue()" /></td>



							</tr>
							<tr id="a3">
								<td nowrap>Cost Price of the Vehicle<b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td><lapschoice:CurrencyTag name="txtauto_valuation"
									size="18" maxlength="9"
									value='<%=Helper.correctNull((String) hshValues
							.get("auto_valuation"))%>'
									onBlur="caculatetot()" /></td>
								<td nowrap>Price For Accessories/Body Building</td>
								<td><lapschoice:CurrencyTag name="txtauto_accessories"
									size="18" maxlength="12" onBlur="caculatetot()"
									value='<%=Helper.correctNull((String) hshValues
							.get("auto_accessories"))%>' />
								</td>
							</tr>
							<tr id="a4">
								<td nowrap>Valuation of the Vehicle<b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td><lapschoice:CurrencyTag name="txtauto_valuation1"
									maxlength="12" size="18"
									value='<%=Helper.correctNull((String) hshValues
							.get("txtauto_valuation1"))%>'
									onBlur="callleastvalue()" /></td>
								<td nowrap>Actual Consideration paid by purchaser</td>
								<td><lapschoice:CurrencyTag name="txt_actualconsideration"
									size="18" maxlength="12"
									value='<%=Helper.correctNull((String) hshValues
							.get("auto_actualconsideration"))%>'
									onBlur="callleastvalue()" /></td>

							</tr>
							<tr id="a5">
								<td nowrap>Tax<b><span class="mantatory">*&nbsp;</span></b></td>
								<td><lapschoice:CurrencyTag name="txtauto_tax" size="18"
									maxlength="12" onBlur="caculatetot()"
									value='<%=Helper.correctNull((String) hshValues
									.get("txtauto_tax"))%>' />
								</td>

								<td nowrap>Insurance</td>
								<td><lapschoice:CurrencyTag name="txtauto_insurance"
									size="18" maxlength="12" onBlur="caculatetot()"
									value='<%=Helper.correctNull((String) hshValues
							.get("txtauto_insurance"))%>' />
								</td>
							</tr>
							<tr id="a6">
								<td nowrap>Other Charges</td>
								<td><lapschoice:CurrencyTag name="txtauto_charges"
									size="18" maxlength="12" onBlur="caculatetot()"
									value='<%=Helper.correctNull((String) hshValues
							.get("txtauto_charges"))%>' />
								</td>

								<td nowrap>Discount</td>
								<td><lapschoice:CurrencyTag name="txt_discount" size="18"
									maxlength="12"
									value='<%=Helper.correctNull((String) hshValues
									.get("txt_discount"))%>'
									onBlur="caculatetot()" /></td>
							</tr>
							<tr id="a7">
								<td nowrap>Least Value of the above</td>
								<td><lapschoice:CurrencyTag name="txt_leastvalue" size="12"
									value='<%=Helper.correctNull((String) hshValues
							.get("auto_leastvalue"))%>' />
								</td>
								<td nowrap>Name of the Owner</td>
								<td><input type="text" name="txtauto_ownername" size="35"
									maxlength="25"
									value="<%=Helper.correctNull((String) hshValues
							.get("txtauto_ownername"))%>">
								</td>
							</tr>

							<tr id="a8">
								<td nowrap>Total Cost</td>
								<td><lapschoice:CurrencyTag name="txtauto_totcost"
									size="18" maxlength="12"
									value='<%=Helper.correctNull((String) hshValues.get("str_dtotal"))%>' />
								</td>

								<td nowrap>&nbsp;</td>
								<td>&nbsp;</td>
							</tr>
							<tr>
								<td nowrap>Registration No.</td>
								<td><input type="text" name="txtauto_registration"
									size="35" maxlength="15"
									value="<%=Helper.correctNull((String) hshValues
							.get("txtauto_registration"))%>">
								</td>

								<td id="registration">Date of registration<b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td>
								<table border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td id="registration1"><input type="text"
											name="txt_registration" size="11"
											value="<%=Helper.correctNull((String) hshValues
							.get("registration_date"))%>"
											onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											maxlength="12"></td>
										<td id="registration2"><a alt="Select date from calender"
											href="#" onClick="callCalender('txt_registration')"
											onMouseOver="window.status='Date Picker';return true;"
											onMouseOut="window.status='';return true;"><img
											src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
											border="0" alt="Select date from calender" tabindex="29"></a></td>
									</tr>
								</table>
								</td>

							</tr>
							<tr>
								<td nowrap>Chasis No.</td>
								<td><input type="text" name="txtauto_chasis" size="35"
									maxlength="17"
									value="<%=Helper.correctNull((String) hshValues
							.get("txtauto_chasis"))%>">
								</td>
							</tr>
							<tr>
								<td nowrap>Engine No.</td>
								<td><input type="text" name="txtauto_engine" size="35"
									maxlength="15"
									value="<%=Helper.correctNull((String) hshValues
							.get("txtauto_engine"))%>">
								</td>
								<td nowrap></td>
								<td></td>
							</tr>
							<tr>
								<td nowrap>Fuel Used</td>
								<td><select value="" name="txt_fuelused">
									<option value="0" selected>------Select-----</option>
									<option value="1">Diesel</option>
									<option value="2">Petrol</option>
									<option value="3">CNG</option>
									<option value="4">Battery</option>
								</select></td>
								<td nowrap>Vehicle to be Driven By Applicant</td>
								<td>Yes <input type="radio"
									name="radio_applicantdrivenvehicle" value="Y"
									style="border-style: none" selected> No <input
									type="radio" name="radio_applicantdrivenvehicle" value="N"
									style="border-style: none"></td>
							</tr>
							<tr>
								<td nowrap>If Transport Operator No. of Vehicles Owned</td>
								<td><input type="text" name="txtauto_vehicles" size="5"
									maxlength="7"
									value="<%=Helper.correctNull((String) hshValues
							.get("txtauto_vehicles"))%>"
									onKeyPress="allowInteger()"></td>

							</tr>

							<tr>
								<td nowrap>Security Details Remarks</td>
								<td colspan="3"><textarea name="txa_remarks" cols="70"
									rows="3" onkeyPress="textlimit(txa_remarks,1499)" onKeyUp="textlimit(this,1499)"><%=Helper.correctNull((String) hshValues
									.get("txa_remarks"))%></textarea></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="6">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr class="dataheader">
								<td><b>Name and Address of Supplier</b></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="4"
							class="outertable">
							<tr>
								<td width="25%" nowrap align="left">Name of the Supplier <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td colspan="3" valign="top"><input type="text"
									name="txtauto_dealer"
									value="<%=Helper.correctNull((String) hshValues
									.get("auto_dealer"))%>"
									size="45" maxlength="50"></td>
							</tr>
							<tr>
								<td nowrap align="left">Address <b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td colspan="3" valign="top"><input type="text"
									name="txtsup_address1"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_deleraddress1"))%>"
									size="45" maxlength="50"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td colspan="3" valign="top"><input type="text"
									name="txtsup_address2" size="45" maxlength="50"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_deleraddress2"))%>">
								</td>
							</tr>
							<tr>
								<td align="left">City <b><span class="mantatory">*&nbsp;</span></b></td>
								<td width="29%"><input type="text" name="txtsup_city"
									size="20" maxlength="20" onKeyPress="notAllowSplChar()"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_delercity"))%>">
								<b><span id="City_pop"
									onClick="showCitySearch('txtsup_city','txtsup_state','hidcity','hidstate','txtsup_zip','hidzip')"
									style="cursor: hand"> <img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0"></span></b></td>

								<td width="21%">State <b><span class="mantatory">*&nbsp;</span></b></td>
								<td width="25%"><input type="text" name="txtsup_state"
									size="20" maxlength="20"
									onBlur="changecase(document.forms[0].txtsup_state)"
									onKeyPress="notAllowSplChar()"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_delerstate"))%>">
								</td>
							</tr>
							<tr>
								<td align="left"><%=ApplicationParams.getZipName()%><b><span
									class="mantatory">*&nbsp;</span></b></td>
								<td><input type="text" name="txtsup_zip" size="12"
									maxlength="<%=ApplicationParams.getZipValue()%>"
									onKeyPress="allowInteger()"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_delerpin"))%>"
									onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">

								</td>
								<td nowrap>Phone No.</td>
								<td><input type="text" name="txtsup_phone" size="20"
									maxlength="15" onKeyPress="allowPhone()"
									value="<%=Helper.correctNull((String) hshValues
							.get("auto_delerphone"))%>">
								</td>
							</tr>
							<tr>
								<td>Authorised Dealer</td>
								<td><select name="selauthdealer">
									<option selected value="0">&lt;-Select-&gt;</option>
									<option value="1">Yes</option>
									<option value="2">No</option>
								</select></td>
								<td nowrap>Dealer Since</td>
								<td><input type="text" name="txtdealersince" size="6"
									maxlength="4" onKeyPress="allowInteger()"
									onBlur="checkcurrentyear(this)"
									value="<%=Helper.correctNull((String) hshValues
									.get("dealer_since"))%>">
								</td>
							</tr>
							<TR>
								<td><input type="button" name="operationalviability"
									value="Operational Viability" onClick="callopeviability()"
									class="buttonStyle" style="width: 150;" id="opervia"></td>
							</TR>
							<!-- security creation removed while saving proposed offered asset tab -->
							<!-- <tr class="dataHeader"> 
								          	<td colspan="4"><b>Joint Holder</b></td>
								          </tr>
								          <tr>
								        	<td>Joint Holder</td>						
								            <td colspan="3"> 
								              <select name="sel_jointholder" onChange="selJointHolder()" tabindex="20">
												<option value="" selected>--Select--</option>
												<option value="Y">Yes</option>
												<option value="N">No</option>
											  </select>
											</td>
										</tr>
										<tr id="id_ownerdet">
											<td id="ownership">Security Ownership <span class="mantatory">*&nbsp;</span></td>						
								            <td id="ownership1">
								            	<input type="text" name="txt_security_ownership" size="12" maxlength="10" readonly="readonly">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
								            	<input type="button" name="add1" value="Add" class="buttonStyle" onClick="callAddJointSecurity()" tabindex="21" disabled="disabled">&nbsp;&nbsp;
								            	<input type="button" name="remove" value="Remove" class="buttonStyle" onClick="jointSecurityDel()" tabindex="22" disabled="disabled">
								            </td>
										</tr>
										<tr>
											<td colspan="4">
												<table id="id_jointsec" width="45%" border="0" cellspacing="1" cellpadding="3" class="outertable"  style="border: 1px solid #bbb;">		
												<tr class="dataheader">
													<td width="5%">&nbsp;</td>
													<td width="35%" align="center">Name</td>
													<td width="30%" align="center">Laps Id</td>			
								            		<td width="30%" align="center" colspan="2">CBS Id</td>
												</tr>
												</table>
											</td>
										</tr> -->
						</table>
					<tr>
						<table id="two1" width="100%" border="0" cellspacing="0"
							cellpadding="2" class="outertable">
							<tr class="dataheader">
								<td colspan="2">General Information</td>
							</tr>
							<tr>
								<td width="70%">Where the salary of the applicant is
								directly credited to his SB account maintained at the branch
								under an irrevocable arrangement with the salary disbursing
								authority and he has produced irrevocable letter of authority to
								debit his account towards the monthly installments payable.</td>
								<td width="30%"><select name="sel_salrytoSB">
									<option value="0" selected>--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
							</tr>
							<tr>
								<td>Where the applicant has produced necessary irrevocable
								undertaking letter from his salary-drawing officer for deduction
								of monthly installments and interest from his salary and for
								remittance of the same to the bank.</td>
								<td><select name="sel_undrtkngletter">
									<option value="0" selected>--Select--</option>
									<option value="Y">Yes</option>
									<option value="N">No</option>
								</select></td>
							</tr>
						</table>
					</tr>
				</table>
				</td>
			</tr>
			</td>
			</tr>

		</table>
		</td>
	</tr>
</table>
</td>
</tr>
</table>
<%if (strTake_over.equals("Y")) {%>
<br>
  <table border="0" cellspacing="0" cellpadding="3" align="center"
	class="outertable linebor buttonbgcolor">
    <tr> 
      <td align="center">
        <input type="button" name="pretakeover"
			class="buttonStyle" style="width: 150" value="Take Over details"
			onClick="calltakeover()">
      </td>
    </tr>
</table>
<%}%>
<br>
<lapschoice:combuttonnew
	btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="0"
					class="outertable">
					<tr class="dataheader">
						<td width="5%">&nbsp;</td>
						<td width="5%" align="center" nowrap="nowrap"><b>Sno</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Vehicle Name</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Vehicle Type</b></td>
						<td width="20%" align="center" nowrap="nowrap"><b>Name of the Supplier </b></td>
						<td width="15%" align="center" nowrap="nowrap"><b>Purchase price of the Vehicle</b></td>
						<td width="15%" align="center" nowrap="nowrap"><b>Security ID</b></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>

	<tr>
		<td>

				<table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable" >
					<%ArrayList g1 = new ArrayList();
					ArrayList v = (ArrayList) hshValues.get("vecRow");
					if (v != null) {
					int vecsize = v.size();
					for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
					<tr valign="top" class="datagrid">
						<td width="5%"><input type="radio"
							onclick="javascript:getSelectedValue('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>',
																		 '<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>',
																		 '<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(5))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(6))))%>','<%=Helper.correctNull((String)g1.get(7))%>',
																		 '<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>',
																		 '<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>',
																		 '<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>',
																		 '<%=Helper.correctNull((String)g1.get(14))%>','<%=Helper.correctNull((String)g1.get(15))%>',
																		 '<%=Helper.correctNull((String)g1.get(16))%>','<%=Helper.correctNull((String)g1.get(17))%>',
																		  '<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>',
																		  '<%=Helper.correctNull((String)g1.get(20))%>','<%=Helper.correctNull((String)g1.get(21))%>',
																		 '<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>',
																		 '<%=Helper.correctNull((String)g1.get(24))%>','<%=Helper.correctNull((String)g1.get(25))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(26))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(27))))%>',
																		 '<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(28))))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(29))))%>',
																		 '<%=Helper.correctNull((String)g1.get(30))%>','<%=Helper.correctNull((String)g1.get(31))%>',
																		  '<%=Helper.correctNull((String)g1.get(32))%>','<%=Helper.correctNull((String)g1.get(33))%>',
																		 '<%=Helper.correctNull((String)g1.get(34))%>','<%=Helper.correctNull((String)g1.get(35))%>',
																		 '<%=Helper.correctNull((String)g1.get(36))%>','<%=Helper.correctNull((String)g1.get(37))%>',
																		 '<%=Helper.correctNull((String)g1.get(38))%>','<%=Helper.correctNull((String)g1.get(39))%>',
																		 '<%=Helper.correctNull((String)g1.get(40))%>','<%=Helper.correctNull((String)g1.get(41))%>',
																		 '<%=Helper.correctNull((String)g1.get(42))%>','<%=Helper.correctNull((String)g1.get(43))%>',
																		 '<%=Helper.correctNull((String)g1.get(44))%>','<%=Helper.correctNull((String)g1.get(45))%>',
																		 '<%=Helper.correctNull((String)g1.get(46))%>','<%=Helper.correctNull((String)g1.get(47))%>',
																		 '<%=Helper.correctNull((String)g1.get(48))%>','<%=Helper.correctNull((String)g1.get(49))%>','<%=Helper.correctNull((String)g1.get(50))%>',
																		 <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(51))))%>)"
																		 
							name="radiobutton"
							value="<%=Helper.correctNull((String) g1.get(1))%>"
							style="border: none"> &nbsp;</td>
							<td width="5%" align="center"><%=Helper.correctNull((String) g1.get(48))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1
											.get(4))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1.get(50))%></td>
						<td width="20%" align="center"><%=Helper.correctNull((String) g1.get(8))%></td>
						<td width="15%"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(51))))%>&nbsp;</td>
						<td width="15%"><%=Helper.correctNull((String) g1.get(49))%></td>
					</tr>
					<%
														}
													}
												%>


					<tr class="datagrid">
						<td align="center" width="5%" colspan="7">&nbsp;</td>
					</tr>
				</table>
		</td>
	</tr>
	</table>
	
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name=hidcity value="<%=Helper.correctNull((String)hshValues.get("hidcity"))%>"> 
<input type="hidden" name=hidstate value="<%=Helper.correctNull((String)hshValues.get("hidstate"))%>"> 
<INPUT TYPE="hidden" name="radLoan1" value="Y">
<input type="hidden" name="appid" value='<%=request.getParameter("hidapplicantid")%>'>
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>">
<input type="hidden" name="hidSecurityId" value="<%=Helper.correctNull((String) hshValues.get("strSecId"))%>">
<input type="hidden" name="hidOwners">
<input type="hidden" name="hidSecValue" value="<%=Helper.correctNull((String) hshValues.get("cus_sec_joint_holder"))%>"> 	
<input type="hidden" name="hidJointOwnValue" value="<%=Helper.correctNull((String) hshValues.get("strJointOwnDetails"))%>"> 	
<input type="hidden" name="hpage">
<input type="hidden" name="hidsnmbr">
<input type="hidden" name="hidsecID">
<input type="hidden" name="hidTotCost_veh">
<input type="hidden" name="hidValuationFlag" value="<%=Helper.correctNull((String)hshValues.get("valuationFlag"))%>">
<input type="hidden" name="hidHouseEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("HouseEdit_Flag"))%>">
<input type="hidden" name="hidVehicleEdit_Flag" value="<%=Helper.correctNull((String)hshValues.get("VehicleEdit_Flag"))%>">
</form>
</body>
</html>