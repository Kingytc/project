<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%ArrayList v = new ArrayList();
			String strcomid = Helper.correctNull((String) request
					.getParameter("id1"));
			String strcomid1 = Helper.correctNull((String) request
					.getParameter("hid_comappid2"));
			if (strcomid.equalsIgnoreCase("")) {
				strcomid = Helper.correctNull((String) hshValues
						.get("perapp_id"));
			}
			String part_gurantee = Helper.correctNull((String) hshValues
					.get("part_gurantee"));
			String part_dependent = Helper.correctNull((String) hshValues
					.get("part_dependent"));%>
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList g1 = new ArrayList();
			java.text.NumberFormat nf = java.text.NumberFormat
			.getNumberInstance();
	nf.setGroupingUsed(false);
	nf.setMaximumFractionDigits(2);
	nf.setMinimumFractionDigits(2);
	String strAppname=Helper.correctNull((String)request.getParameter("hidapp_name"));
	if(strAppname.equals(""))
	{
		strAppname=Helper.correctNull((String)hshValues.get("strAppname"));
	}
	%>
<html>
<head>
<title>Partners/Co-Partners/Trustees/SHG/Directors</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var CurrentDate="<%=Helper.getCurrentDateTime()%>";
var part_gurantee="<%=Helper.correctNull((String)hshValues.get("part_gurantee"))%>";
var part_dependent="<%=Helper.correctNull((String)hshValues.get("part_dependent"))%>";
var varpageid="<%=Helper.correctNull((String)hshValues.get("PageId"))%>";

function getAge(obj)
{
  	var result = true;
  	var birthDate = new Date(obj.value);
  	var today = new Date();
 	var currdate=CurrentDate.substring(6,10);
 	
  	var birthDate1=document.forms[0].dob.value;
  		var birthMM=birthDate1.substring(3,5);
  	var CurrbirthMM=CurrentDate.substring(3,5);
  	
    birthDate1=birthDate1.substring(6,10);
   
    var CurrYear=parseInt(currdate)-parseInt(birthDate1);
   var mon1=CurrbirthMM.substring(1,2);
   var mon2=birthMM.substring(1,2);
	var CurrMon=parseInt(mon1)-parseInt(mon2);
	 
	if(CurrMon==0)
	{
		CurrMon=0;
	}  
	if(CurrbirthMM > birthMM)
	{
		
	}
	  
	if(CurrbirthMM < birthMM)
	{
		CurrMon = 0;
		CurrMon = parseFloat(birthMM)-parseFloat(CurrbirthMM);
		CurrYear=NanNumber(CurrYear)-1;
		CurrMon=  12 - CurrMon;
	}
	  
  
  
  	if(CurrYear<20)
  {
   document.forms[0].txt_age.value=NanNumber(CurrYear);
   alert("Age should be Greater Than 20")
   document.forms[0].dob.focus();
   
   document.forms[0].dob.value="";
   document.forms[0].txt_age.value="0";
  }
   else
   {
   document.forms[0].txt_age.value=NanNumber((CurrYear));
   if(document.forms[0].txt_age.value=="0.00")
   {
   		 document.forms[0].txt_age.value="0";
   }
   }
    }
 function clearfields()
{
	
	document.forms[0].txt_name.value= "";
	document.forms[0].txt_age.value= "";
	document.forms[0].txt_qualification.value= "";
	document.forms[0].txt_designation.value= "";
	document.forms[0].txt_networth.value= "";
	document.forms[0].txt_Phoneno.value= "";
	document.forms[0].dob.value="";
	document.forms[0].share.value="";
	document.forms[0].select.value="";
	document.forms[0].txt_father.value="";
	document.forms[0].txt_per.value="";
	document.forms[0].txt_office.value="";
	document.forms[0].txt_res.value="";
	document.forms[0].txt_annual.value= "";
	document.forms[0].txt_incometax.value= "";
	document.forms[0].txt_incometaxass.value= "";
	document.forms[0].txt_wealth.value= "";
	document.forms[0].txt_credit.value= "";
	document.forms[0].txt_creditother.value= "";
	document.forms[0].txt_fixedasset.value= "";
	document.forms[0].txt_relationship.value= "";
	document.forms[0].sel_dependent.value= "";
}   

function selectValues(val1, val2, val3, val4, val5, val6, val7, val8,val9,val10,val11,val12,
val13,val14,val15,val16,val17,val18,val19,val20,val21,val22,val23,val24,val25)
{
   	document.forms[0].hid_sno.value =val2;
   	document.forms[0].hid_comappid2.value = val1;	
	document.forms[0].txt_name.value= val3;
	document.forms[0].txt_age.value= val4;
	document.forms[0].txt_qualification.value= val5;
	document.forms[0].txt_designation.value= val6;
	document.forms[0].txt_networth.value= val7;
	document.forms[0].txt_Phoneno.value= val8;
	document.forms[0].dob.value= val10;
	document.forms[0].share.value=val9;
	document.forms[0].select.value=val11;
	document.forms[0].txt_father.value=val12;
	document.forms[0].txt_per.value=val13;
	document.forms[0].txt_office.value=val14;
	document.forms[0].txt_res.value=val15;
	document.forms[0].txt_annual.value= val16;
	document.forms[0].txt_incometax.value= val17;
	document.forms[0].txt_incometaxass.value= val18;
	document.forms[0].txt_wealth.value= val19;
	document.forms[0].txt_credit.value= val20;
	document.forms[0].txt_creditother.value= val21;
	document.forms[0].txt_fixedasset.value= val22;
	document.forms[0].txt_relationship.value= val23;
	document.forms[0].sel_dependent.value= val24;
	document.forms[0].txt_din.value= val25;
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
	disableCommandButtons("radioselect");
	}
}

function doSave()
{
    if(document.forms[0].txt_name.value=="" && document.forms[0].hidAction.value=="insert")
	{
		 alert("Enter the Partner Name");
		 document.forms[0].txt_name.focus();
		 return;
	}	
	
	if(trim(document.forms[0].txt_name.value)=="")
	{
		ShowAlert(121,'Partner Name');
		document.forms[0].txt_name.focus();
		return;
	}	
	
	if(trim(document.forms[0].dob.value)=="")
		{
		ShowAlert(121,'Date of Birth');
		document.forms[0].dob.focus();
		return;
		}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="refdetails";
	document.forms[0].hidBeanMethod.value="UpdatePartnerDetailsData";
	document.forms[0].hidBeanGetMethod.value="getPartnerDetailsData";
	document.forms[0].hidSourceUrl.value="/action/perdirectors.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	
}

function callDisableControls(cmdNew,cmdEdit,cmdApply,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdApply;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		clearfields();
		document.forms[0].cmdnew.disabled =false;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;		 
	}
	if(val=="edit")
	{	 
		 document.forms[0].cmdnew.disabled =true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		document.forms[0].cmdnew.disabled =true;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=false;
		document.forms[0].cmdclose.disabled=false;
	}	  
}  

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value="update";
	disableCommandButtons("edit");
}

function callhelp()
{
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}

function doNew()
{
	disableFields(false);
	disableCommandButtons("edit");		
	document.forms[0].txt_name.value="";	 
	document.forms[0].txt_designation.value="";
	document.forms[0].txt_age.value="";
	document.forms[0].txt_qualification.value="";
	document.forms[0].txt_networth.value="";
	document.forms[0].dob.value="";
	document.forms[0].txt_Phoneno.value="";
	document.forms[0].share.value="";
	document.forms[0].txt_father.value="";
	document.forms[0].txt_per.value="";
	document.forms[0].txt_office.value="";
	document.forms[0].txt_res.value="";
	document.forms[0].txt_annual.value= "";
	document.forms[0].txt_incometax.value= "";
	document.forms[0].txt_incometaxass.value=""; 
	document.forms[0].txt_wealth.value= "";
	document.forms[0].txt_credit.value= "";
	document.forms[0].txt_creditother.value= "";
	document.forms[0].txt_fixedasset.value= "";
	document.forms[0].txt_relationship.value= "";
	document.forms[0].sel_dependent.value= "";
	document.forms[0].hidAction.value ="insert";

}
function onloading()
{	 
	callDisableControls(true,true,false,true,false,false)
   
}

function doCancel()
{   
	if(ConfirmMsg(102))
	{
		
		document.forms[0].hidAction.value="cancel";
		document.forms[0].hidSourceUrl.value="/action/perdirectors.jsp";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidBeanMethod.value="getPartnerDetailsData";
		document.forms[0].hidBeanGetMethod.value="getPartnerDetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit(); 
	}
	 disableCommandButtons("load"); 
	
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if((document.forms[0].elements[i].type=='text')||(document.forms[0].elements[i].type=='textarea'))
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		
	}
	document.forms[0].txt_age.readOnly=true;
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";	
		document.forms[0].hidBeanMethod.value="UpdatePartnerDetailsData";
		document.forms[0].hidBeanGetMethod.value="getPartnerDetailsData";
		document.forms[0].hidBeanId.value="refdetails";
		document.forms[0].hidSourceUrl.value="/action/perdirectors.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();		
	 }	
}

function onloading()
{	 
	disableCommandButtons("load");
	document.forms[0].select.value="2";
	if(part_dependent!="")
	{
		document.forms[0].sel_dependent.value=part_dependent;
	}
	else
	{
		document.forms[0].sel_dependent.value="0";
	}
}

function call_page(url)
{
	document.forms[0].action=appURL+"action/"+url;
	document.forms[0].submit();
}

function callCalender()
{
	showCal(appURL,'dob');
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
} 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer {
	width: 100%;
	height: 150;
	overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="onloading()">
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
<form name="frmpri" method=post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Customer Profile -&gt; Demographics -&gt; Partners/Co-Partners/Trustees/SHG/Directors
	</tr>	
</table>
<table width="100%" border="1" cellpadding="2" 
	class="outertable" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			class="outertable">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="2"
					class="outertable">
					<tr>
						<td colspan="4">
						<table width="100%" border="0" cellspacing="0" cellpadding="1"
							class="outertable">
							<tr>
								<td width="11%">Name<b><span class="mantatory">*&nbsp;</span></b></td>
								<td width="20%"><input type="text" name="txt_name"
									tabindex="1" size="25" maxlength="30"
									onKeyPress="notAllowSplChar()"
									value="<%=Helper.correctNull((String)hshValues.get("part_name"))%>">
								</td>
								<td width="14%">DOB<b><span class="mantatory">*&nbsp;</span></b>
								(dd/mm/yyyy)</td>
								<td width="21%">
								<table width="71%" border="0" cellspacing="0" cellpadding="3"
									class="outertable">
									<tr>
										<td><input type="text" size="12" name="dob"
											value="<%=Helper.correctNull((String)hshValues.get("part_dob"))%>"
											onBlur="dateDOBCheck(document.forms[0].dob);getAge(document.forms[0].dob)"
											readOnly></td>
										<td width="55%"><a href="#" onClick="callCalender()"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0" tabindex="7"></a></td>
									</tr>
								</table>
								</td>
								<td width="13%">Age</td>
								<td width="21%"><b> <input type="text" tabindex="3"
									name="txt_age" size="3" maxlength="2"
									onKeyPress="allowInteger()"
									value="<%=Helper.correctNull((String)hshValues.get("part_age"))%>"
									readonly> years </b></td>

							</tr>
							<tr>
								<td width="11%">Father / Husband Name</td>
								<td width="20%"><input type="text" name="txt_father"
									tabindex="1" size="25" maxlength="35"
									onKeyPress="notAllowSplChar()"
									value="<%=Helper.correctNull((String)hshValues.get("fathers_name"))%>">
								</td>
								<td width="14%">Office / Bussiness Address</td>
								<td width="21%"><textarea name="txt_office" tabindex="1"
									size="30"
									onKeyPress="textlimit(this,160);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,160)"><%=Helper.correctNull((String)hshValues.get("office_add"))%></textarea>
								</td>
								<td width="13%">Residence Address</td>
								<td width="21%"><textarea name="txt_res" tabindex="1"
									size="35" maxlength="300"
									onKeyPress="textlimit(this,160);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,160)"><%=Helper.correctNull((String)hshValues.get("residence_add"))%></textarea>
								</td>
							</tr>
							<tr>
								<td width="11%">Permanent Address</td>
								<td width="20%"><textarea name="txt_per" tabindex="1"
									size="25"
									onKeyPress="textlimit(this,160);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,160)"><%=Helper.correctNull((String)hshValues.get("permeninant_add"))%></textarea>
								</td>
								<td width="14%">Phone No.</td>
								<td width="21%"><input type="text" name="txt_Phoneno"
									tabindex="2" size="15" maxlength="15" onKeyPress="allowPhone()"
									value="<%=Helper.correctNull((String)hshValues.get("part_phoneno"))%>">
								</td>
								<td width="13%">Qualification (Technical / Educational)</td>
								<td width="21%"><input type="text" name="txt_qualification"
									tabindex="4" size="25" maxlength="25"
									onKeyPress="notAllowSplChar()" style=""
									value="<%=Helper.correctNull((String)hshValues.get("part_qualification"))%>">
								</td>
							</tr>
							<tr>
								<td width="11%">Designation</td>
								<td width="20%"><input type="text" name="txt_designation"
									size="25" maxlength="25" onKeyPress="notAllowSplChar()"
									tabindex="5" style=""
									value="<%=Helper.correctNull((String)hshValues.get("part_designation"))%>">
								</td>
								<td "width="14%">Networth</td>
								<td width="21%"><b> <lapschoice:CurrencyTag
									name="txt_networth" size="12" maxlength="12"
									value='<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("part_networth"))))%>' />
								</b></td>
								<td width="13%">% Share</td>
								<td width="21%"><b> <input type="text" size="10"
									maxlength="8" name="share" onKeyPress="allowNumber(this)"
									onBlur="checkPercentage(this)"
									value="<%=Helper.correctNull((String)hshValues.get("part_share"))%>">
								</b></td>
							</tr>
							<tr>
								<td width="11%">Personal Guarantee</td>
								<td width="20%"><select name="select" tabindex="40">
									<option value="1">Yes</option>
									<option value="2" selected>No</option>
								</select></td>
								<td width="14%">Annual Income for the last Financial Year</td>
								<td width="21%"><lapschoice:CurrencyTag name="txt_annual"
									size="12" maxlength="12"
									value='<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("part_annual"))))%>' />
								</td>
								<td width="13%">Income Tax Repayment (Assessment for the
								last Year)</td>
								<td width="21%"><lapschoice:CurrencyTag
									name="txt_incometax" size="12" maxlength="12"
									value='<%=nf.format(Double.parseDouble(Helper
						.correctDouble((String) hshValues.get("part_repayment"))))%>' />
								</td>
							</tr>
							<tr>
								<td width="11%">Income Tax Assessment (Completed till)</td>
								<td width="20%"><input type="text" name="txt_incometaxass"
									size="25" maxlength="50" onKeyPress="notAllowSplChar1(this)"
									tabindex="5" style=""
									value="<%=Helper.correctNull((String)hshValues.get("part_itassesment"))%>">
								</td>
								<td width="14%">Wealth Tax Payments(Assessment)</td>
								<td width="21%"><b> <input type="text"
									name="txt_wealth" tabindex="5" size="15" maxlength="9"
									onKeyPress="notAllowSplChar1(this)" style=""
									value="<%=Helper.correctNull((String)hshValues.get("part_wealthtax"))%>">
								</b></td>
								<td align="left" width="13%">Credit Facilities Enjoyed
								with our Bank</td>
								<td align="left" valign="middle" width="21%"><textarea
									name="txt_credit" cols="15" rows="2" tabindex="23"
									onKeyPress="textlimit(this,3000);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,3000)"><%=Helper.correctNull((String)hshValues.get("part_credit"))%></textarea>
								</td>
							</tr>
							<tr>
								<td align="left" width="11%">Credit Facilities Enjoyed
								with Other Bank</td>
								<td align="left" valign="middle" width="20%"><textarea
									name="txt_creditother" cols="15" rows="2" tabindex="23"
									onKeyPress="textlimit(this,3000);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,3000)"><%=Helper.correctNull((String)hshValues.get("part_creditother"))%></textarea>
								</td>
								 <td align="left" width="14%" >Details 
                          of fixed/Moveable assets </td>
                        <td align="left" valign="middle"> 
                          <textarea name="txt_fixedasset" cols="15" rows="2"  tabindex="23" onKeyPress="textlimit(this,3000);notAllowSingleQuote();notAllowedDouble()" onKeyUp="textlimit(this,3000)"><%=Helper.correctNull((String)hshValues.get("part_fixedasset"))%></textarea>
                        </td>
                        <td width="11%"><font face="MS Sans Serif" size="1">Director Identification Number(DIN)</font></td>
                        <td width="20%"> 
                          <input type="text" name="txt_din" tabindex="" size="11"
											maxlength="10" onKeyPress="notAllowSplChar()">
                        </td>
							</tr>
							<tr>
								<td width="11%">Relationship</td>
								<td width="20%"><input type="text" name="txt_relationship"
									tabindex="" size="25" maxlength="35"
									onKeyPress="notAllowSplChar()"
									value="<%=Helper.correctNull((String)hshValues.get("part_relationship"))%>">
								</td>
								<td width="14%">Whether Dependent</td>
								<td width="21%"><select name="sel_dependent" tabindex="40">
									<option value="0">--select--</option>
									<option value="1">Yes</option>
									<option value="2" selected>No</option>
								</select></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br>
						<table width="12%" border="0" align="center" cellpadding="3"
							cellspacing="0" class="outertable">
							<tr>
								<lapschoice:combuttonnew
									btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
									btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="4"><br>
						<table width="100%" border="0" cellspacing="0" cellpadding="0"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3"
									class="outertable linebor">
									<tr class="dataheader">
										<td width="25%" align="center"><b>Name</b></td>
										<td width="12%" align="center"><b>Phone No. </b></td>
										<td width="7%" align="center"><b>Age</b></td>
										<td width="23%" align="center"><b>Qualification</b></td>
										<td width="18%" align="center"><b>Designation</b></td>
										<td width="15%" align="center"><b>Networth </b></td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td>
								<%v = (ArrayList) hshValues.get("vecData");if (v != null) {if(v.size()>6){ %>
								<div class="cellContainer">
								<%} }%>
								<table width="100%" border="0" cellspacing="1" cellpadding="3">
									<%
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);

					%>
									<tr class="datagrid">
										<td width="25%" align="left"><b><a
											href="javascript:selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>','<%=nf.format(Double.parseDouble(Helper
                						.correctDouble((String) g1.get(6))))%>','<%=Helper.correctNull((String)g1.get(7))%>','<%=Helper.correctNull((String)g1.get(8))%>','<%=Helper.correctNull((String)g1.get(9))%>','<%=Helper.correctNull((String)g1.get(10))%>','<%=Helper.correctNull((String)g1.get(11))%>','<%=Helper.correctNull((String)g1.get(12))%>','<%=Helper.correctNull((String)g1.get(13))%>','<%=Helper.correctNull((String)g1.get(14))%>','<%=nf.format(Double.parseDouble(Helper
                						.correctDouble((String) g1.get(15))))%>','<%=nf.format(Double.parseDouble(Helper
                						.correctDouble((String) g1.get(16))))%>','<%=Helper.correctNull((String)g1.get(17))%>','<%=Helper.correctNull((String)g1.get(18))%>','<%=Helper.correctNull((String)g1.get(19))%>','<%=Helper.correctNull((String)g1.get(20))%>','<%=Helper.correctNull((String)g1.get(21))%>','<%=Helper.correctNull((String)g1.get(22))%>','<%=Helper.correctNull((String)g1.get(23))%>','<%=Helper.correctNull((String)g1.get(24))%>')">
										<%=Helper.correctNull((String) g1
											.get(2))%></a></b></td>
										<td width="12%" align="left"><%=Helper.correctNull((String) g1
											.get(7))%>&nbsp;</td>
										<td width="7%" align="center">&nbsp;<%=Helper.correctNull((String) g1
											.get(3))%></td>
										<td width="23%" align="left">&nbsp;<%=Helper.correctNull((String) g1
											.get(4))%></td>
										<td width="18%" align="left"><%=Helper.correctNull((String) g1
											.get(5))%>&nbsp;</td>
										<td width="15%" align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper
                						.correctDouble((String) g1.get(6))))%></td>
									</tr>
									<%}
			}%>

								</table>
								<%if (v != null) {if(v.size()>6){ %>
								</div>
								<%}} %>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		<lapschoice:hiddentag pageid='<%=PageId%>' />
		<input type="hidden" name="hid_comappid2" value="<%=strcomid1%>">
		<input type="hidden" name="hid_comappid" value="<%=strcomid1%>">
		<input type="hidden" name="hid_sno"
			value="<%=Helper.correctNull((String)hshValues.get("part_slno"))%>">
		<input type="hidden" name="readFlag"
			value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
			<input type="hidden" name="hidapp_name" value="<%=strAppname%>">
</form>
</body>
</html>