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
<title>Outward</title>

</head>
<script>	
var currentDate="<%=Helper.getCurrentDateTime()%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";

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
			document.forms[0].action=appURL+"action/inward_reg.jsp";
			document.forms[0].hidBeanId.value = "agr_eNWR";
			document.forms[0].hidBeanGetMethod.value = "getagr_eNWR";
			document.forms[0].submit();
		}
		
	}
	function callonLoad()
	{
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
		document.forms[0].hidSourceUrl.value = "/action/inward_reg.jsp";
		document.forms[0].hidBeanMethod.value = "updateagreNWR";	
		document.forms[0].hidBeanGetMethod.value = "getagr_eNWR";
		document.forms[0].action = appURL + "controllerservlet";
		document.forms[0].submit();
	}
	
	
}

function doSave()  
{
	
	if(document.forms[0].txt_inwardrefno.value=="")
	{
		ShowAlert(121,"Inward Ref No ");
		document.forms[0].txt_inwardrefno.focus();
		return;
	}
	
	if(document.forms[0].txt_inwarddate.value=="")
	{
		ShowAlert(121,"Inward Date");
		document.forms[0].txt_inwarddate.focus();
		return;
	}
	if(document.forms[0].sel_type.value=="")
	{
		ShowAlert(111,"Type of Borrower");
		document.forms[0].sel_type.focus();
		return;
	}
	if(document.forms[0].txt_solid.value=="")
	{
		ShowAlert(121,"Sol ID");
		document.forms[0].txt_solid.focus();
		return;
	}
	if(document.forms[0].txt_BranchName.value=="")
	{
		ShowAlert(121,"Branch Name");
		document.forms[0].txt_BranchName.focus();
		return;
	}
	
	if(document.forms[0].txt_RegionName.value=="")
	{
		ShowAlert(121,"Region Name ");
		document.forms[0].txt_RegionName.focus();
		return;
	}
	/*if(document.forms[0].txt_custid.value=="")
	{
		ShowAlert(121,"Cust ID");
		document.forms[0].txt_custid.focus();
		return;
	}*/
	if(document.forms[0].txt_Name.value=="")
	{
		ShowAlert(121,"Name");
		document.forms[0].txt_Name.focus();
		return;
	}
	
	if(document.forms[0].sel_typeofinward.value=="")
	{
		ShowAlert(111,"Type of Inward");
		document.forms[0].sel_typeofinward.focus();
		return;
	}
	
	if(document.forms[0].txt_inwarddetailsreceived.value=="")
	{
		ShowAlert(121,"Details of Inward Received ");
		document.forms[0].txt_inwarddetailsreceived.focus();
		return;
	}
	
	if(document.forms[0].txt_remarks.value=="")
	{
		ShowAlert(121,"Remarks");
		document.forms[0].txt_remarks.focus();
		return;
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

function allow()
{
	var key = window.event.keyCode;
	if(!(key>47 && key<58))
	{
		window.event.returnValue = false;
	}
}

</script>
<body onload="callonLoad();selection();">
<form class="normal" method="post">


<table width="95%" border="1" cellspacing="0" cellpadding="3"
	class="outertable" align="center" style="margin-left: 20px; margin-right: 20px; margin-top: 5px;">
<tr>
<td>
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">

	<tr class="dataheader" style="text-align: center">
		<td style="text-align: center;width:100%;">Credit Enquiry</td><td></td>	
	</tr>
</table>	
<table class="outertable" width="100%"  border="0" cellspacing="0" cellpadding="3" align="center">	
	<tr>
		<td width="10%">Inward Ref No <b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_inwardrefno"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_outwardrefno"))%>" onkeypress="allowNumber();"></td>
		<td width="10%">Inward Date<b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_inwarddate" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("txt_inwarddate"))%>"
							onBlur="checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_inwarddate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
							

		<td width="10%">LAR Ref No.</td>
		 <td width="15%"><input type="text" name="txt_LAR"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_outwardrefno"))%>" onkeypress="allowNumber();"></td>						        
		</tr>
	<tr>
		<td>Sol ID <b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_solid"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_solid"))%>" onkeypress="allowNumber();"></td>
		<td>Branch Name<b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_BranchName"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_BranchName"))%>" onkeypress="allowNumber();"></td>
							
		<td>Region Name <b><span class="mantatory">*</span></b></td>
		<td> <input type="text" name="txt_RegionName"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_RegionName"))%>" onkeypress="allowNumber();"></td>
					
	</tr>
	<tr>
		<td>Cust ID</td>
		 <td><input type="text" name="txt_custid"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_custid"))%>" onkeypress="allowNumber();"></td>
		<td>Borrower Name<b><span class="mantatory">*</span></b></td>
		 <td><input type="text" name="txt_Name"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("txt_Name"))%>" onkeypress="allowNumber();"></td>
							
		<td>Proposed FB Limit<b><span class="mantatory">*</span></b></td>
		<td><input type="text" name="fblimit"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("fblimit"))%>" onkeypress="allowNumber();"></td>
	<tr>
		<td>Proposed NFB Limit<b><span class="mantatory">*</span></b> </td>
		 <td> <input type="text" name="nfblimit"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("nfblimit"))%>" onkeypress="allowNumber();"></td>
		<td>Total Exposure  <b><span class="mantatory">*</span></b> </td>
		 <td> <input type="text" name="total_exp"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("total_exp"))%>" onkeypress="allowNumber();"></td>
				<td width="15%">Exposure Brecket<b><span class="mantatory">*</span></b></td>
		 <td width="10%"> <select name="sel_type">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="1">Below 5Cr</option>
								          <option value="2">5 - 15Cr</option>
								           <option value="3">Above 15Cr</option>
								        </select></td>
		</tr>
		<tr>
		<td width="15%">Proposal Handlet at<b><span class="mantatory">*</span></b></td>
		 <td width="10%"> <select name="sel_type">
								          <option value="0" selected="selected">&lt;---Select---&gt;</option>
								          <option value="M">Mangalury</option>
								          <option value="B">Bengaluru (Manual)</option>
								      
								        </select></td>
        <td width="10%">CMC Date<b><span class="mantatory">*</span></b></td>
		 <td width="15%"><input type="text" name="txt_CMC_Date" size="12"
							maxlength="10" 
							value="<%=Helper.correctNull((String)hshValues.get("txt_CMC_Date"))%>"
							onBlur="checkDate(this);">
							 <a href="#"
							onClick="callCalender1('txt_inwarddate')"
								onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"
							title="Click to view calender" border=0><img
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							border="0"></a></td>
		</tr>
		<tr>
		<td>CMC decision<b><span class="mantatory">*</span></b> </td>
		 <td> <input type="text" name="cmcdecision"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("cmcdecision"))%>" onkeypress="allowNumber();"></td>
		<td>Remarks<b><span class="mantatory">*</span></b> </td>
		 <td> <input type="text" name="remarks"  maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("remarks"))%>" onkeypress="allowNumber();"></td>
		</tr>	
		
</table>

</td>
</tr>

<!-- Button Portion in table -->
<tr>
<td>
		<table width="12%" border="0" cellspacing="0" cellpadding="0"	align="center" class="outertable">
			<tr>
				<lapschoice:combuttonnew btnnames='Edit_Save' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />	
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
