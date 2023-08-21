<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<%
String strPageid="35";
String strPageName=Helper.correctNull((String)request.getParameter("flowtype"));
if(strPageName.equalsIgnoreCase(""))
	strPageName=Helper.correctNull((String)hshValues.get("flowtype1"));

if(strPageName.equalsIgnoreCase("KSAE"))
	strPageid="38";
else if(strPageName.equalsIgnoreCase("FIDPN"))
	strPageid="39";
else if(strPageName.equalsIgnoreCase("MMithra"))
	strPageid="40";
else if(strPageName.equalsIgnoreCase("GECL"))
	strPageid="41";
else if(strPageName.equalsIgnoreCase("CGSSD"))
	strPageid="42";

ArrayList listRow=new ArrayList();
ArrayList listDPN=new ArrayList();
ArrayList listCol=new ArrayList();

listRow=(ArrayList)hshValues.get("listRow");
listDPN=(ArrayList)hshValues.get("listDPN");
String[] strArr={"March","April","May","June*","July*","August*"};
java.text.NumberFormat jtn = java.text.NumberFormat.getInstance();
jtn.setMaximumFractionDigits(2);
jtn.setMinimumFractionDigits(2);
jtn.setGroupingUsed(false);
String strentitystatus=Helper.correctNull((String)hshValues.get("com_status"));
String strcgssdperc="";
String strmaxloan="";
String appstatus=Helper.correctNull((String) request.getParameter("appstatus"));
if(appstatus.equalsIgnoreCase("Open/Pending")){
 strcgssdperc=Helper.correctNull((String)hshValues.get("COM_CGSSDPERC"));
 strmaxloan=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("COM_RANGETO"))));
}else{
 strcgssdperc=Helper.correctNull((String)hshValues.get("COM_CGSSD_PERC"));
 strmaxloan=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_maxloan"))));
}
String strrangeto=Helper.correctNull((String)hshValues.get("COM_RANGETO"));
String COM_CGSSD_FACSNO=Helper.correctNull((String)hshValues.get("COM_CGSSD_FACSNO"));
double dbl_propfundostot=0;
dbl_propfundostot=Double.parseDouble(Helper.correctDouble((String)hshValues.get("dbl_propfundostot")));
String strcgssdpercflag=Helper.correctNull((String)hshValues.get("strcgssdpercflag"));
%>
<html>
<head>
<title>CGSSD Assessment</title>

<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String) request.getParameter("appstatus"))%>";
var varEligBasedon="<%=Helper.correctNull((String) hshValues.get("strEligBasedon"))%>";
var varFacilitysno="<%=Helper.correctNull((String) hshValues.get("strFacilitysno"))%>";
var varFacProposed="<%=Helper.correctNull((String) hshValues.get("strFacProposed"))%>";
var appno="<%=request.getParameter("appno")%>";
var strentitystatus="<%=strentitystatus%>";
var COM_CGSSD_FACSNO="<%=COM_CGSSD_FACSNO%>";
var strcgssdperc="<%=strcgssdperc%>";
var strrangeto="<%=strrangeto%>";
var dbl_propfundostot="<%=dbl_propfundostot%>";
var strcgssdpercflag="<%=strcgssdpercflag%>";
var varentityrestructure="<%=Helper.correctNull((String)hshValues.get("COM_ENTITY_RESTRUCTURE"))%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
        document.forms[0].hidBeanId.value="";
	    document.forms[0].action=appURL+"action/"+"corppge.jsp";	
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{	
	    document.forms[0].sel_facilitysno.disabled=false;
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanMethod.value="updateCgssdAssessment";
		document.forms[0].hidBeanGetMethod.value="getCgssdAssessment";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidSourceUrl.value="/action/com_cgssdAssessment.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}
function doSave()
{ 	
	proposedcal();
	calculate();
	if(document.forms[0].sel_facilitysno.value=="")
	{
		  ShowAlert(111,'Facility');
		  document.forms[0].sel_facilitysno.focus();
		  return;
	}
	if(document.forms[0].txt_cap_entity.value=="0.00"||document.forms[0].txt_cap_entity.value=="")
	{
		  ShowAlert(121,'Capital of the entity');
		    
		  document.forms[0].txt_cap_entity.focus();
		  return;
	}

	if(document.forms[0].txt_prom_stake.value=="0.00"||document.forms[0].txt_prom_stake.value=="")
	{
		  ShowAlert(121,'Promoters Stake');
		  document.forms[0].txt_prom_stake.focus();
		  return;
	}
	if(document.forms[0].txt_eligamount.value=="0.00"||document.forms[0].txt_eligamount.value=="")
	{
		  ShowAlert(121,'Eligible Amount');
		  document.forms[0].txt_eligamount.focus();
		  return;
	}
	if(document.forms[0].txt_amount.value=="0.00"||document.forms[0].txt_amount.value=="")
	{
		  ShowAlert(121,'Amount Applied');
		  document.forms[0].txt_amount.focus();
		  return;
	}
	if(document.forms[0].txt_liability.value=="0.00"||document.forms[0].txt_liability.value=="")
	{
		  ShowAlert(121,'liability');
		  document.forms[0].txt_liability.focus();
		  return;
	}
	if(document.forms[0].txt_maxloan.value=="0.00"||document.forms[0].txt_maxloan.value=="")
	{
		  ShowAlert(121,'maximum loan');
		  document.forms[0].txt_maxloan.focus();
		  return;
	}

	if(document.forms[0].txt_entity.value=="")
	{
		  ShowAlert(121,'Entity Name');
		  document.forms[0].txt_entity.focus();
		  return;
	}

	if(document.forms[0].txt_operaccountnum.value=="")
	{
		  ShowAlert(121,'Parent entity  loan account number/operative account number');
		  document.forms[0].txt_operaccountnum.focus();
		  return;
	}

	if(document.forms[0].sel_entitystatus.value=="")
	{
		  ShowAlert(111,'Entity Status');
		  document.forms[0].sel_entitystatus.focus();
		  return;
	}
	if(document.forms[0].sel_entitystatus.value=="N")
	{   
		if(document.forms[0].txt_datenpa.value=="")
		{
			
		  ShowAlert(111,'NPA Date');
		  document.forms[0].txt_datenpa.focus();
		  return;
		}
	}
	if(document.forms[0].txt_cusid_msme.value=="")
	{
		  ShowAlert(121,'CBS Customer ID of parent MSME entity');
		  document.forms[0].txt_cusid_msme.focus();
		  return;
	}

	if(document.forms[0].txt_dpd_msme.value=="")
	{
		  ShowAlert(121,'Number of DPD of parent MSME entity');
		  document.forms[0].txt_dpd_msme.focus();
		  return;
	}

	if(document.forms[0].sel_entity_restructure.value=="")
	{
		  ShowAlert(111,'Whether  Parent entity is eligible  for restructure');
		  document.forms[0].sel_entity_restructure.focus();
		  return;
	}
	document.forms[0].cmdsave.disabled=true;
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateCgssdAssessment";
	document.forms[0].hidBeanGetMethod.value="getCgssdAssessment";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_cgssdAssessment.jsp";
	document.forms[0].submit();
}
function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	  	{
			if(document.forms[0].btnenable.value =='N')
		  	{
				document.forms[0].cmdnew.disabled=true;
			  	document.forms[0].cmdedit.disabled=true;
			  	document.forms[0].cmddelete.disabled=true;
			  	document.forms[0].cmdsave.disabled=true;
			  	document.forms[0].cmdcancel.disabled=true;
			  	document.forms[0].cmdclose.disabled=false;
		 	}
	  	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
	 	  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit")
	{
		if(document.forms[0].btnenable.value =='N')
	  	{
			document.forms[0].cmdnew.disabled=true;
		  	document.forms[0].cmdedit.disabled=true;
		  	document.forms[0].cmddelete.disabled=true;
		  	document.forms[0].cmdsave.disabled=true;
		  	document.forms[0].cmdcancel.disabled=true;
		  	document.forms[0].cmdclose.disabled=false;
	 	}
	 	else
	 	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			if(document.forms[0].appno.value != "new")
			{
				document.forms[0].cmdclose.disabled=true;
			}
			else
			{
				document.forms[0].cmdclose.disabled=false;
				document.forms[0].cmddelete.disabled=true;
				document.forms[0].cmdcancel.disabled=true;
			}
		}
		disableFields(false);
	}
}
function onLoading()
{
	 disableFields(true);
	 if(strentitystatus!=""){
		 document.forms[0].sel_entitystatus.value=strentitystatus;
	 }
	 if(COM_CGSSD_FACSNO!=""){
		 document.forms[0].sel_facilitysno.value=COM_CGSSD_FACSNO;
	 }
	 if(varentityrestructure!=""){
		 document.forms[0].sel_entity_restructure.value=varentityrestructure;
	 }
	 document.forms[0].sel_facilitysno.disabled=false;
	 
	 checkstatus();
	 calculate();
	 if(appstatus== "Open/Pending"){
	
	 checkeligval();
	 }
	 if(COM_CGSSD_FACSNO!=""){
		 if(appstatus== "Open/Pending"){
			 if(strcgssdpercflag=="Y"){
				 alert("please renter the details"); 
						return;
			 }
		 }
	 }
}
function doEdit()
{
	if(document.forms[0].sel_facilitysno.value=="")

	{

		ShowAlert(111,"Facility");

		document.forms[0].sel_facilitysno.focus();

		return;

	}

	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	document.forms[0].txt_maxloan.readOnly=true;
	document.forms[0].txt_eligamount.readOnly=true;
}
function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='textarea')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
	  }
}
function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updateCgssedAssessment";
		document.forms[0].hidBeanGetMethod.value="getCgssdAssessment";
		document.forms[0].action=appURL+"action/com_cgssdAssessment.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function getValues()
{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getCgssdAssessment";
	document.forms[0].action=appURL+"action/com_cgssdAssessment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}


function getFacilityDetails()
{
	
	document.forms[0].hidBeanId.value = "comproposal";
	document.forms[0].hidBeanGetMethod.value = "getBGassessment";
	document.forms[0].action = appURL + "action/com_bgassessment.jsp";
	document.forms[0].submit();

}
function checkstatus(){
	if(document.forms[0].sel_entitystatus.value=="N"){
		document.all.npadate.style.visibility="visible";
		document.all.npadate.style.position="relative";
		document.all.hid_desc1.innerHTML="5.CBS Customer ID of parent MSME entity";
		document.all.hid_desc2.innerHTML="6.Number of DPD of parent MSME entity";
		document.all.hid_desc3.innerHTML="7.Whether  Parent entity is eligible  for restructure";
	}else{
		document.all.npadate.style.visibility="hidden";
		document.all.npadate.style.position="absolute";
		document.all.hid_desc1.innerHTML="4.CBS Customer ID of parent MSME entity";
		document.all.hid_desc2.innerHTML="5.Number of DPD of parent MSME entity";
		document.all.hid_desc3.innerHTML="6.Whether  Parent entity is eligible  for restructure";
	}
}

function checkeligval(){
	if(strcgssdperc=="NaN")
	{
		strcgssdperc="0.00";
	}
	if(document.forms[0].txt_prom_stake.value=="")document.forms[0].txt_prom_stake.value=0;
	if(strcgssdperc=="")strcgssdperc=0;
	document.forms[0].txt_eligamount.value=	(eval(document.forms[0].txt_prom_stake.value)*eval(strcgssdperc))/100;
	document.forms[0].txt_eligamount.value=roundVal(document.forms[0].txt_eligamount.value);
	
}


function calculate(){
	var vareligamt=document.forms[0].txt_eligamount.value;
	var varamtapplied=document.forms[0].txt_amount.value;
	var avarliablility=document.forms[0].txt_liability.value;
	var varmaxamt=document.forms[0].txt_maxloan.value;
	var varleastval1=0.00;
	var varleastval2=0.00;
	var varleastval3=0.00;
	
	if(vareligamt=="NaN" ||vareligamt=="")
	{
		vareligamt="0.00";
	}if(varamtapplied=="NaN" ||varamtapplied=="")
	{
		varamtapplied="0.00";
	}if(avarliablility=="NaN" ||avarliablility=="")
	{
		avarliablility="0.00";
	}if(varmaxamt=="NaN" ||varmaxamt=="")
	{
		varmaxamt="0.00";
	}
if(eval(vareligamt)<eval(varamtapplied)){
	varleastval1=vareligamt;
}else{
	varleastval1=varamtapplied;
}
if(eval(avarliablility)<eval(varleastval1)){
	varleastval2=avarliablility;
}else{
	varleastval2=varleastval1;
}
if(eval(varmaxamt)<eval(varleastval2)){
	varleastval3=varmaxamt;
}else{
	varleastval3=varleastval2;
}
document.forms[0].txt_recomended.value=eval(varleastval3);
document.forms[0].txt_recomended.value=roundVal(varleastval3);
}

function proposedcal(){
	var varamtapplied=document.forms[0].txt_amount.value;
	if(varamtapplied=="NAN"||varamtapplied==""){
		varamtapplied="0.00";
	}
	if(eval(dbl_propfundostot)<eval(varamtapplied)){
		alert("amount applied should not be greater than the Proposed limit");
		document.forms[0].txt_amount.value="";
		return;
	}

}

function ValidateOpearativeAcc(obj,objname)
{
	var varOperAcc=obj.value;
	if(varOperAcc.length!=16)
	{
		alert("Please Enter Valid Operative Account Number");
		obj.value="";
		return;
	}
	
}
function Validatecbsid(obj,objname)
{
	var varCBSID=obj.value;
	if(varCBSID.length!=9)
	{
		alert("Please Enter Valid CBS ID");
		obj.value="";
		return;
	}
	
}


function chknpaDate()
{
	var date1 = document.forms[0].txt_datenpa.value;
	var date2= "30/04/2020";
	var pcgdt=date1.substring(0,2);
	var pcgmon=date1.substring(3,5);
	var pcgyear=date1.substring(6,10);
	var npadate=pcgmon+"/"+pcgdt+"/"+pcgyear;
	
	var ppgdt=date2.substring(0,2);
	var ppgmon=date2.substring(3,5);
	var ppgyear=date2.substring(6,10);
	var harddate=ppgmon+"/"+ppgdt+"/"+ppgyear;
	 if(Date.parse(npadate) >Date.parse(harddate) )
	  {
		alert("NPA Date should not be greater than the " +date2)
		document.forms[0].txt_datenpa.value="";
		document.forms[0].txt_datenpa.focus();
		return;
	  }
	
	
}

function callIFrame()
{
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanGetMethod.value="getCgssdAssessment";
	document.forms[0].action=appURL+"action/com_cgssdAssessment.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}


</script>
</head>
<body onload="onLoading()">
<form method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top" colSpan=5>
			<jsp:include page="../com/proposallinks.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
         
<tr>
  	<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Assessment -&gt; Assessment Comments</td>
</tr>         
</table>
<span style="display:none;"><lapschoice:borrowertype /></span><lapschoice:application />

<jsp:include page="../com/com_commentstab.jsp" flush="true">
<jsp:param name="tabid" value="<%=strPageid %>" />
</jsp:include>	


<table width="50%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
<tr>
				<td>
				Facility &nbsp; &nbsp;
				<select name="sel_facilitysno" tabindex="1" onchange="callIFrame()">
				<option value="" selected="selected">--Select--</option>
                <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='cgssd'/>
				</select>
				</td>
				</tr>
</table>

<table width="50%" align="center" border="0" cellspacing="0" cellpadding="3" class="outertable">
					
					<tr class="dataheader">
						<td colspan="2" align="center">Assessment for CGSSD</td>
			  	    </tr>		
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="1.Capital of the entity">1.Capital of the entity</td>
						<td><input type="text" name="txt_cap_entity" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_capita")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="2.Promoters Stake">2.Promoters Stake</td>
						<td><input type="text" name="txt_prom_stake" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_promoter")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);checkeligval();"></td>
					</tr>
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="3.Eligible Amount of Promoters Stake)">3.Eligible Amount (<%=strcgssdperc%>% of Promoters Stake)</td>
						<td><input type="text" name="txt_eligamount" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_eligamount")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="4.Amount Applied">4.Amount Applied</td>
						<td><input type="text" name="txt_amount" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_amountappl")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);proposedcal();"></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="5.Liability of the entity">5.Liability of the entity</td>
						<td><input type="text" name="txt_liability" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_liability")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);"></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="6.Maximum loan under the scheme">6.Maximum loan under the scheme</td>
						<td><input type="text" name="txt_maxloan" value="<%=strmaxloan%>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="roundtxt(this);" readonly="readonly"></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="7.Recommended (lower of 3,4,5,6)">7.Recommended (lower of 3,4,5,6)</td>
						<td><input type="text" name="txt_recomended" value="<%=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("com_recamount")))) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="calculate();roundtxt(this);"></td>
					</tr>
					
					<tr class="dataheader">
						<td colspan="2" align="center">Additional Details for KBL CGSSD</td>
			  	    </tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="1.Entity Name">1.Entity Name</td>
						<td><input type="text" name="txt_entity" value="<%=Helper.correctNull((String)hshValues.get("com_entiry_name")) %>" style="text-align: right;" onkeypress="allowAlphabetsForName()" ></td>
					</tr>
					
					<tr class="datagrid">
						<td nowrap="nowrap"><input type="hidden" name="hid_desc" value="2.Parent entity  loan account number/operative account number (in case of OD)" >2.Parent entity  loan account number/operative account number (in case of OD)</td>
						<td><input type="text" name="txt_operaccountnum" value="<%=Helper.correctNull((String)hshValues.get("com_operaccountnum")) %>" style="text-align: right;" onKeyPress="allowNumber(this)" onBlur="ValidateOpearativeAcc(this,'txt_operaccountnum')" ></td>
					</tr>
					
					<tr class="datagrid">
						<td><input type="hidden" name="hid_desc" value="3.Status of the entity">3.Status of the entity</td>
						<td><select name="sel_entitystatus" onchange="checkstatus();">
							<option value="" selected="selected">--select--</option>
							<option value="S">Standard</option>
							<option value="N" >NPA</option>
							</select>
					   </td>
					</tr>
					
					<tr class="datagrid" id="npadate">
						<td><input type="hidden" name="hid_desc" value="">4.Date of NPA</td>
						<td><input type="text" name="txt_datenpa"
													size="16"
													onBlur="checkDate(this);chknpaDate();"
													value="<%=Helper.correctNull((String)hshValues.get("com_npadate"))%>">
												<a alt="Select date from calender" id="txt_datenpa"
													href="#" onClick="callCalender('txt_datenpa')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
						
					</tr>
				
					<tr class="datagrid">
						<td id="hid_desc1"><input type="hidden" name="hid_desc" value="CBS Customer ID of parent MSME entity "><span id="iddealer">CBS Customer ID of parent MSME entity</span></td>
						<td><input type="text" name="txt_cusid_msme" maxlength="9" value="<%=Helper.correctNull((String)hshValues.get("COM_MSME_CBSID")) %>" style="text-align: right;" onkeypress="allowAlphaNumeric();" onBlur="Validatecbsid(this,'txt_cusid_msme')"></td>
					</tr>
					<tr class="datagrid">
						<td id="hid_desc2"><input type="hidden" name="hid_desc" value="CBS Customer ID of parent MSME entity " >Number of DPD of parent MSME entity</td>
						<td><input type="text" name="txt_dpd_msme" maxlength="9" value="<%=Helper.correctNull((String)hshValues.get("COM_MSME_DPDNO")) %>" style="text-align: right;" onkeypress="allowInteger();" ></td>
					</tr>
					<tr class="datagrid">
						<td id="hid_desc3"><input type="hidden" name="hid_desc" value="Whether  Parent entity is eligible  for restructure ">Whether  Parent entity is eligible  for restructure </td>
						<td><select name="sel_entity_restructure" onchange="">
							<option value="" selected="selected">--select--</option>
							<option value="S">Yes</option>
							<option value="N" >No</option>
							</select>
						</td>
					</tr>
					
					
</table>
</td>
</tr>
<br> 
	
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' btnnames='Edit_Save_Cancel_Delete'/>

<input type="hidden" name="hidPage" value="35">
<input type="hidden" name="hidBeanId" value="">
 <input type="hidden" name="hidBeanMethod" value=""> 
 <input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidCommentPage" value="">
<input type="hidden" name="flowtype1" value="<%=strPageName %>">
<INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
<br>
</form>
</body>
</html>