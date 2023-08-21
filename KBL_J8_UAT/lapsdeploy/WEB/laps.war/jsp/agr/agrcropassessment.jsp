<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList arrData = new ArrayList();
	ArrayList arrRow = new ArrayList();
	int vecsize = 0;
	int vecsize1 = 0;
	if (hshValues != null) {
		arrData = (ArrayList) hshValues.get("arrData");
	}
	String strapptype = "";
	String apptype = "";
	String prd_type = Helper.correctNull((String) session
			.getAttribute("strProductType"));
	
	String schemetype="";
	String strschemetype="";
	schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
	String txt_scloffin = Helper.correctNull((String) hshValues.get("dblScaleoffin"));
	String strAssessment=Helper.correctNull((String) hshValues.get("strAssessmentFor"));

	%>
<html>
<head>
<title>Agriculture Land Holdings</title>
<STYLE>
DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
</STYLE>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var mode ="load";
var state = "<%=Helper.correctNull((String) hshValues.get("sel_state"))%>";
var district = "<%=Helper.correctNull((String) hshValues
									.get("txt_district"))%>";
var txt_crop = "<%=Helper.correctNull((String) hshValues.get("txt_crop"))%>";
var txt_finance= "<%=Helper.correctNull((String) hshValues
									.get("txt_finance"))%>";
var txt_fromdate="<%=Helper.correctNull((String) hshValues
									.get("txt_fromdate"))%>";
var txt_todate="<%=Helper.correctNull((String) hshValues.get("txt_todate"))%>";
var selsno="<%=Helper.correctNull((String) hshValues
									.get("selsno"))%>";
var varschemetype="<%=schemetype%>";
var txt_scloffin="<%=txt_scloffin%>";
var varAssessmentFor="<%=Helper.correctNull((String) hshValues.get("strAssessmentFor"))%>";
var appno="<%=request.getParameter("appno")%>";									
/*function calnoplants()
{
	var val1= parseFloat(document.forms[0].txt_amount.value);
	var val2= parseFloat(document.forms[0].txt_areaofcult.value);
	var val3= parseFloat(document.forms[0].txt_noofplnts.value);
	val3=val1/val2;
	document.forms[0].txt_noofplnts.value=NanNumber(val3);
	
}*/
function selectValues(sno,season,crop,sowmon,harvmon,areacul,amount,eligibility,limapplied,limitrecom,duedate,state,district,noofplants,meatype,scloffin,varplantval,varSDVal,varSDDesc,varActivity)
{

	if(document.forms[0].sel_assessment.value=="130")
	{
		document.forms[0].idno.value=sno;
		document.forms[0].txt_season.value=season;
		document.forms[0].txt_crop.value=crop;
		document.forms[0].txt_sowmonth.value=sowmon;
		document.forms[0].txt_harvmonth.value=harvmon;
		document.forms[0].txt_amount.value=amount;
		document.forms[0].txt_eligibility.value=eligibility;
		document.forms[0].txt_limitappl.value=limapplied;
		document.forms[0].txt_limitrecom.value=limitrecom;
		document.forms[0].txt_repay.value=duedate;
	//	document.forms[0].txt_costofcultivation.value=costofcultivation;
		document.forms[0].txt_state.value=state;
		document.forms[0].txt_district.value=district;
		document.forms[0].sel_meatype.value=meatype;
		document.forms[0].txt_scloffin.value=scloffin;
		if(meatype=="1")
		{
			document.all.meastype.innerText="Number of Plants";
			document.forms[0].txt_areaofcult.value=noofplants;
		}
		else if(meatype=="2")
		{
			document.all.meastype.innerText="Area of Cultivation in acres"; 
			document.forms[0].txt_areaofcult.value=areacul;
		}
		else
		{
			document.forms[0].txt_areaofcult.value="";
		}

		roundtxt1(document.forms[0].txt_amount);
		roundtxt(document.forms[0].txt_eligibility);
		roundtxt(document.forms[0].txt_limitappl);
		roundtxt(document.forms[0].txt_limitrecom);
	}
	else
	{
		document.forms[0].idno.value=sno;
		document.forms[0].txt_natureofactivity.value=crop;
		document.forms[0].txt_sof_value.value=amount;
		document.forms[0].txt_sof_eligibility.value=eligibility;
		document.forms[0].txt_limitappl1.value=limapplied;
		document.forms[0].txt_limitrecom1.value=limitrecom;
		document.forms[0].txt_sof_unitvalue.value=varplantval;
		document.forms[0].txt_sof_unit.value=noofplants;
		document.forms[0].hid_calcMode.value=varSDVal;
		document.forms[0].hid_calcValue.value=varSDDesc;
		document.forms[0].hid_scaleoffin.value=scloffin;
		document.forms[0].sel_assessment.value=varActivity;
	}
	
	//roundtxt(document.forms[0].txt_costofcultivation);
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y")
		{
			disableCommandButtons("radioselect");
		}
		else
		{
			disableCommandButtons("disableall");
		}
	}else
	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	disableCommandButtons("disableall");
	 	disableFields(true);
	 	
	}

	enablefields('N');
}
function callEnableCultivation()
{
	if('<%=prd_type%>'=="aF")
	{
		document.all.cultivation.style.visibility="hidden";
		document.all.cultivation.style.position="absolute";

		document.all.space.style.visibility="hidden";
		document.all.space.style.position="absolute";

		document.all.cultivationcost.style.visibility="hidden";
		document.all.cultivationcost.style.position="absolute";
	}
	else
	{
		document.all.cultivation.style.visibility="visible";
		document.all.cultivation.style.position="relative";

		document.all.space.style.visibility="visible";
		document.all.space.style.position="relative";

		document.all.cultivationcost.style.visibility="visible";
		document.all.cultivationcost.style.position="relative";
	}
}
function callLimitsPage()
{
	var strappno	=	"<%=Helper.correctNull((String) hshValues.get("appno"))%>";
	window.open(appURL+"action/agrcropassesmentpopup.jsp?hidBeanId=agrcrops&hidBeanGetMethod=getLimitsPageDetails&strappno="+strappno,"LifeStyle","scrollbars=yes,menubar=yes,width=600,height=300,top=50,left=50");
}


function callelig()
{
   var eligi=document.forms[0].sel_meatype.value;
   if(eligi==1)
   {
	   var elig=parseFloat(document.forms[0].txt_eligibility.value);
	   var np=parseFloat(document.forms[0].txt_areaofcult.value);
	   var tmnt=parseFloat(document.forms[0].txt_scloffin.value);
	   elig=(np*tmnt);	  
	   var nan=NanNumber(elig);
	   document.forms[0].txt_eligibility.value=nan;
   }
   if(eligi==2)
   {
	   var amnt=parseFloat(document.forms[0].txt_amount.value);
	   var area=parseFloat(document.forms[0].txt_areaofcult.value);
	   elig=(amnt*area);
	   var nan=NanNumber(elig);
	   document.forms[0].txt_eligibility.value=nan;
	   
   }
}

function callonLoad()
{	
	//calnoplants();
//	callEnableCultivation();
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value=="Y")
		{
			disableCommandButtons("load");
		}
		else
		{
			disableCommandButtons("disableall");
		}
		disableFields(true);
	}else
	
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
	{
	 	disableCommandButtons("disableall");
	 	disableFields(true);
	 	
	}	
	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=varschemetype;
	if(varAssessmentFor!="")
	{
		document.forms[0].sel_assessment.value=varAssessmentFor;
	}
	else
	{
		document.forms[0].sel_assessment.value="";
	}
	enablefields('N');
}

function roundtxt1(trate)
{
	var temp2="";
	if (trate.value==".") trate.value=0;
	var temp1= new Number(trate.value);
	var floc=0;

	temp=new String(Math.round(temp1*10000));
	temp2=String(temp/10000);
	if (temp==0)
	{
		temp2="0.0000";
	}
	if (temp2.substr(0,1)==".") temp2="0"+temp2;
	if (temp2.substr(temp2.length-2,1)==".") temp2=temp2+"0";
	if (parseInt(temp2.lastIndexOf("."))<0)
	{	
		temp2 = temp2+".0000";
	}
	trate.value = temp2;
	return trate.value;
}

function doSave()
{	
	if(document.forms[0].sel_assessment.value=="")
	{
		
	}
	else if(document.forms[0].sel_assessment.value=="130")
	{
		if(document.forms[0].txt_season.value=="")
		{
			ShowAlert(168);
			return;
		}
	
		if(document.forms[0].txt_crop.value=="" )
		{
			alert("Select Crop Name");
			return;
		}
		if(document.forms[0].sel_meatype.value=="0")
		{
			alert("Enter the Measurement type");
			return;
		}
		validateMaxAmount();
	}
	else
	{
		if(document.forms[0].txt_natureofactivity.value=="")
		{
			ShowAlert('111',"Nature of Activity");
			return;
		}
	
		if(document.forms[0].txt_sof_unitvalue.value=="" )
		{
			ShowAlert('121',document.all.idlabel1.innerHTML);
			return;
		}
	}
	document.forms[0].txt_state.readOnly=false; 
	document.forms[0].txt_district.readOnly=false;
	calcEligibility();
	disableCommandButtons("load");
	disableFields(false);
	document.forms[0].txt_season.readOnly=false; 
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidBeanMethod.value="updateCropAssessmentDetails";
	document.forms[0].hidBeanGetMethod.value="getCropAssessmentDetails";
	document.forms[0].hidSourceUrl.value="/action/agrcropassessment.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{

			document.forms[0].txt_state.readOnly=false; 
			document.forms[0].txt_district.readOnly=false;
			document.forms[0].hidAction.value="Cancel";
		    document.forms[0].hidBeanId.value="agrcrops"
			document.forms[0].hidBeanGetMethod.value="getCropAssessmentDetails";
		    document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrcropassessment.jsp";
			document.forms[0].hidSourceUrl.value="/action/agrcropassessment.jsp";
			document.forms[0].method="post";	
			document.forms[0].submit();
	}
}

function doNew() 
{

	
	disableFields(false);
	
	disableCommandButtons("edit");
	document.forms[0].hidAction.value="insert";
   	mode = "new";
	document.forms[0].txt_amount.readOnly=true;
	document.forms[0].txt_eligibility.readOnly=true;
	document.forms[0].txt_limitrecom.readOnly=true;
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].checked=false;
		}	  
	}
	document.forms[0].txt_season.readOnly = true;
	document.forms[0].txt_crop.readOnly =true;
	document.forms[0].txt_state.readOnly=true; 
	document.forms[0].txt_district.readOnly=true;
	document.forms[0].txt_sof_value.readOnly=false;
	document.forms[0].txt_natureofactivity.readOnly=false;

	//if(varAssessmentFor!="")
	{
		document.forms[0].sel_assessment.disabled=false;
	}
}

function enableButton(bool1, bool2, bool3, bool4, bool5, bool6)
{
	
		document.forms[0].cmdnew.disabled=bool1;
		document.forms[0].cmdedit.disabled=bool2;
		document.forms[0].cmdsave.disabled=bool3;
		document.forms[0].cmdcancel.disabled=bool4;
		document.forms[0].cmddelete.disabled=bool5;
	//	document.forms[0].cmdhelp.disabled=bool6;
	    document.forms[0].cmdclose.disabled=bool6;
	    document.forms[0].cmdcomments.disabled=false;
		
	
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		
		if(appstatus=="Open/Pending")
		{
			enableButton(false,true,true,true, true,false);
		}
		else
		{	   
		 	enableButton(true,true,true,true, true,false);
		}
	}
	if(val=="edit")
	{	 
		 enableButton(true,true, false, false, true,true);	 
		
		 disableFields(false);
	}
	if(val=="radioselect")
	{	 
		if(appstatus=="Open/Pending")
		{
			enableButton(true,false, true, false, false,false);
		}
		else
		{	   
			 enableButton(true,true,true,true, true,false);
		}
		
		
	}	
	if(val=="disableall")
	{
		 enableButton(true,true,true,true, true,false);
		 disableFields(true);
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	   
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
	
	}
	
	
}
function doEdit() 
{
	if(document.forms[0].sel_assessment.value=="130" && trim(document.forms[0].txt_season.value)=="")
	{
		ShowAlert(167);
		return;
	}
	disableFields(false);
	disableCommandButtons("edit");
   	document.forms[0].hidAction.value="update"
	mode ="edit";
	document.forms[0].txt_season.readOnly=true; 
	document.forms[0].txt_amount.readOnly=true;
	document.forms[0].txt_eligibility.readOnly=true; 
	document.forms[0].txt_limitrecom.readOnly=true;
	document.forms[0].txt_state.readOnly=true; 
	document.forms[0].txt_district.readOnly=true;
	document.forms[0].txt_crop.readOnly=true;
	document.forms[0].txt_sof_value.readOnly=false;
	document.forms[0].txt_natureofactivity.readOnly=false;
	if(varAssessmentFor!="")
	{
		document.forms[0].sel_assessment.disabled=true;
	}
	
	
}
 function doDelete() 
   {
	 if(document.forms[0].sel_assessment.value=="130" && trim(document.forms[0].txt_season.value)=="")
		{
			alert('Select a Record to Delete');
			return;
		}
	 if( ConfirmMsg(101))
	{
		document.forms[0].txt_state.readOnly=false; 
		document.forms[0].txt_district.readOnly=false;
		document.forms[0].txt_season.readOnly=false;
		document.forms[0].sel_assessment.disabled=false;  
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateCropAssessmentDetails";
		document.forms[0].hidBeanGetMethod.value="getCropAssessmentDetails";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidSourceUrl.value="action/agrcropassessment.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
	}
}  
function callCalender(fname)
{
	var action  =document.forms[0].hidAction.value;
	if(action =="insert" || action =="update")
	{
		showCal(appURL,fname);
	}
}
function callAgrLandHolding()
{
	document.forms[0].hidBeanId.value="agrlandholdings";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrlandholdings.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

function showfinance()
{
	   
	   if(!document.forms[0].cmdsave.disabled)
		{ 
		   if(document.forms[0].sel_assessment.value=="")
			{
				alert("Select Assessment Type");
				document.forms[0].sel_assessment.focus();
				return;
			}
		   if(document.forms[0].sel_assessment.value=="130")
			{
				var strappno="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
				var action=document.forms[0].hidAction.value;
				var prop = "scrollbars=Yes,width=650,height=400,top=100,left=250";
				var url=appUrl+"action/scalefinancemasterlist.jsp?&strfrom=DistrictMaster&strappno="+strappno;
				window.open(url,"",prop);
			}
		   else
		   {
			   var strappno="<%=Helper.correctNull((String)request.getParameter("appno"))%>";
				var action=document.forms[0].hidAction.value;
				var prop = "scrollbars=Yes,width=650,height=400,top=100,left=250";
				var url=appUrl+"action/scalefinancemasterlistnew.jsp?hidBeanId=agrcrops&hidBeanGetMethod=getFinancemasterData&strAssessment="+document.forms[0].sel_assessment.value;
				window.open(url,"",prop);
		   }
	
		}
}

function calcEligibility()
{
	if(document.forms[0].sel_assessment.value=="130")
	{
		if(document.forms[0].sel_meatype.value=="1")
		{
			document.forms[0].txt_eligibility.value =
				 parseFloat(document.forms[0].txt_areaofcult.value) * parseFloat(document.forms[0].txt_scloffin.value);
			
		}
		else if(document.forms[0].sel_meatype.value=="2")
		document.forms[0].txt_eligibility.value = parseFloat(document.forms[0].txt_areaofcult.value) * parseFloat(document.forms[0].txt_amount.value);
		document.forms[0].txt_eligibility.value=NanNumber(document.forms[0].txt_eligibility.value);
		roundtxt(document.forms[0].txt_eligibility);
	}
	else
	{
		document.forms[0].txt_sof_eligibility.value =
			 parseFloat(document.forms[0].txt_sof_unit.value) * parseFloat(document.forms[0].txt_sof_value.value);
		document.forms[0].txt_sof_eligibility.value=NanNumber(document.forms[0].txt_sof_eligibility.value);
		roundtxt(document.forms[0].txt_sof_eligibility);
	}
	calRecommend();
}

function calRecommend()
{
	if(document.forms[0].sel_assessment.value=="130")
	{
		if(parseFloat(document.forms[0].txt_limitappl.value ) < parseFloat(document.forms[0].txt_eligibility.value))
		{
			document.forms[0].txt_limitrecom.value = document.forms[0].txt_limitappl.value;
		}
		if(parseFloat(document.forms[0].txt_limitappl.value ) >= parseFloat(document.forms[0].txt_eligibility.value))
		{
			document.forms[0].txt_limitrecom.value = document.forms[0].txt_eligibility.value;
		}
		roundtxt(document.forms[0].txt_limitrecom);
	}
	else
	{
		if(parseFloat(document.forms[0].txt_limitappl1.value ) < parseFloat(document.forms[0].txt_sof_eligibility.value))
		{
			document.forms[0].txt_limitrecom1.value = document.forms[0].txt_limitappl1.value;
		}
		if(parseFloat(document.forms[0].txt_limitappl1.value ) >= parseFloat(document.forms[0].txt_sof_eligibility.value))
		{
			document.forms[0].txt_limitrecom1.value = document.forms[0].txt_sof_eligibility.value;
		}
		roundtxt(document.forms[0].txt_limitrecom1);
	}
}

function validateMaxAmount()
{
	if(document.forms[0].txt_amount.readOnly==false)
	{
		validateMaximumValue(document.forms[0].txt_amount,document.forms[0].toRange.value );
		validateMinimumValue(document.forms[0].txt_amount,document.forms[0].fromRange.value );
	}
	
}

function callLink(page,bean,method)
{	
	if (document.forms[0].cmdsave.disabled)
	{
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
function showMeasurementtype()
{
	if(document.forms[0].sel_meatype.value=="1" || document.forms[0].sel_meatype.value=="0")
	{
		document.all.meastype.innerText="Number of Plants";
	}
	else if(document.forms[0].sel_meatype.value=="2")
	{
		document.all.meastype.innerText="Area of Cultivation in acres"; 
	}
}
function doComments()
{
	var btnenable=document.forms[0].btnenable.value;
	var strAppno =appno;
	var pagetype = document.forms[0].hidCommentPage.value;
	var prop = "scrollbars=yes,width=750,height=550,top=25,left=180";
	var url=appURL+"action/com_bankArgmnt_comments.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComments&pagetype="+pagetype+"&strAppno="+strAppno+"&btnenable="+btnenable+"&appstatus="+appstatus;
	window.open(url,"Comments",prop);
}
function enablefields(varFlag)
{
	if(varFlag=="Y")
	{
		if(varAssessmentFor=="130" && document.forms[0].sel_assessment.value!="130" && document.forms[0].sel_assessment.value!="")
		{
			alert("You cannot add Other Activity with Crop Loan");
			document.forms[0].sel_assessment.value="";
			document.forms[0].sel_assessment.focus();
		}
		else if(varAssessmentFor!="" && varAssessmentFor!="130" && document.forms[0].sel_assessment.value=="130")
		{
			alert("You cannot add Crop with Other Activity");
			document.forms[0].sel_assessment.value="";
			document.forms[0].sel_assessment.focus();
		}
	}
	if(document.forms[0].sel_assessment.value=="130")
	{
		document.all.idassess1.style.display="table-row";
		document.all.idassess2.style.display="table-row";
		document.all.idassess3.style.display="none";
	}
	else
	{
		document.all.idassess1.style.display="none";
		document.all.idassess2.style.display="none";
		document.all.idassess3.style.display="table-row";

		if(document.forms[0].sel_assessment.value=="225"||document.forms[0].sel_assessment.value=="226"||document.forms[0].sel_assessment.value=="230")
		{
			document.all.idlabel1.innerHTML="No. of Animals";
		}
		else if(document.forms[0].sel_assessment.value=="227")
		{
			document.all.idlabel1.innerHTML="No. of Birds";
		}
		else if(document.forms[0].sel_assessment.value=="228")
		{
			document.all.idlabel1.innerHTML="No. of Acres";
		}
		else if(document.forms[0].sel_assessment.value=="229")
		{
			document.all.idlabel1.innerHTML="No. of Days/Animals";
		}
	}
}
function checkInput()
{
	var varValue;
	if(document.forms[0].hid_calcMode.value=="M")
	{
		varValue=eval(document.forms[0].txt_sof_unitvalue.value)%eval(document.forms[0].hid_calcValue.value);
		if(varValue!=0)
		{
			alert("Invalid Input");
			document.forms[0].txt_sof_unitvalue.value="";
			document.forms[0].txt_sof_unit.value="";
			document.forms[0].txt_sof_eligibility.value="";
			document.forms[0].txt_limitrecom1.value="";
			return;
		}
		else
		{
			document.forms[0].txt_sof_unit.value=eval(document.forms[0].txt_sof_unitvalue.value)/eval(document.forms[0].hid_calcValue.value);
		}
	}
	else if(document.forms[0].hid_calcMode.value=="E")
	{
			document.forms[0].txt_sof_unit.value=document.forms[0].txt_sof_unitvalue.value;
	}
	else if(document.forms[0].hid_calcMode.value=="EM")
	{
		varValue=eval(eval(document.forms[0].txt_sof_unitvalue.value)*100)%eval(eval(document.forms[0].hid_calcValue.value)*100);
		if(varValue!=0)
		{
			alert("Invalid Input");
			document.forms[0].txt_sof_unitvalue.value="";
			document.forms[0].txt_sof_unit.value="";
			document.forms[0].txt_sof_eligibility.value="";
			document.forms[0].txt_limitrecom1.value="";
			return;
		}
		else
		{
			document.forms[0].txt_sof_unit.value=eval(document.forms[0].txt_sof_unitvalue.value);
		}
	}
	else if(document.forms[0].hid_calcMode.value=="D")
	{
		varValue=eval(document.forms[0].txt_sof_unitvalue.value)%eval(document.forms[0].hid_calcValue.value);
		if(varValue!=0)
		{
			alert("Invalid Input");
			document.forms[0].txt_sof_unitvalue.value="";
			document.forms[0].txt_sof_unit.value="";
			document.forms[0].txt_sof_eligibility.value="";
			document.forms[0].txt_limitrecom1.value="";
			return;
		}
		else
		{
			document.forms[0].txt_sof_unit.value=eval(document.forms[0].txt_sof_unitvalue.value)/eval(document.forms[0].hid_calcValue.value);
		}
	}
	else if(document.forms[0].hid_calcMode.value=="EM")
	{
		varValue=eval(eval(document.forms[0].txt_sof_unitvalue.value)*100)%eval(eval(document.forms[0].hid_calcValue.value)*100);
		if(varValue!=0)
		{
			alert("Invalid Input");
			document.forms[0].txt_sof_unitvalue.value="";
			document.forms[0].txt_sof_unit.value="";
			document.forms[0].txt_sof_eligibility.value="";
			document.forms[0].txt_limitrecom1.value="";
			return;
		}
		else
		{
			document.forms[0].txt_sof_unit.value=eval(document.forms[0].txt_sof_unitvalue.value);
		}
	}
	else if(document.forms[0].hid_calcMode.value=="EMM")
	{
		if(eval(document.forms[0].txt_sof_unitvalue.value)>eval(document.forms[0].hid_calcValue.value))
		{
			alert("Input value should not be more than "+eval(document.forms[0].hid_calcValue.value));
			document.forms[0].txt_sof_unitvalue.value="";
			document.forms[0].txt_sof_unit.value="";
			document.forms[0].txt_sof_eligibility.value="";
			document.forms[0].txt_limitrecom1.value="";
			return;
		}
		else
		{
			document.forms[0].txt_sof_unit.value=eval(document.forms[0].txt_sof_unitvalue.value);
		}
	}
}
function checkInputValue(val)
{
	if(document.forms[0].hid_calcMode.value=="EMM")
	{
		allowInteger();
	}
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
	<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body  onload="callonLoad();showMeasurementtype()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="frmpri" method="post" class="normal">
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
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">	
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Assessment of Limit</td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="52" />
			<jsp:param name="schemetype" value="<%=schemetype%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="98%" border="0" cellspacing="0" cellpadding="5" class="" align="center" class="outertable border1">
	<tr CLASS="dataheader">
			<td colspan="6">Assessment for&nbsp;&nbsp;
			<select name="sel_assessment" onchange="enablefields('Y');">
			<option value=""><--select--></option>
			<lapschoice:StaticDataQuestionMastTag apptype="231" />
			</select>
			</td>
			</tr>
	<tr id="idassess1">
		<td>
		<TABLE WIDTH="100%" BORDER="0" CELLSPACING="1" CELLPADDING="5">
		
			<TR CLASS="dataheader">
				<TD ALIGN="center" WIDTH="17%">Scale of Finance</TD>
				<TD WIDTH="15%" ALIGN="center">Season<span class="mantatory">*</span></TD>

				<TD WIDTH="13%" ALIGN="center">Crop <span class="mantatory">*</span></TD>

				<TD ALIGN="center" COLSPAN="2" WIDTH="15%">Month Of</TD>
				<TD ALIGN="center" COLSPAN="1" WIDTH="15%">Measurement Type <span class="mantatory">*</span></TD>
				 <TD ALIGN="center" COLSPAN="1" WIDTH="25%" id="meastype">Number of Plants</TD>

			</TR>
			<TR ALIGN="center" CLASS="dataheader">

				<TD WIDTH="17%">&nbsp;</TD>

				<TD VALIGN="middle" ALIGN="center" WIDTH="15%">&nbsp;</TD>
				<TD WIDTH="13%">&nbsp;</TD>
				<TD WIDTH="7%">Sowing</TD>

				<TD WIDTH="8%">Harvesting</TD>

				<TD COLSPAN="1" WIDTH="15%">&nbsp;</TD>

				<TD COLSPAN="1"  id="aoc_nop1" WIDTH="25%">&nbsp;</TD>
				
			</TR>
			<TR ALIGN="center" CLASS="datagrid">
				<TD WIDTH="17%"><lapschoice:CurrencyTag name="txt_amount"
					maxlength="15" tabindex="1" size="15"
					onKeyPress="roundtxt1(this);allowDecimals(this)" style="text-align:right"
					onBlur="validateMaxAmount();calcEligibility();callelig()"
					other="readOnly" /> <B><SPAN ONCLICK="showfinance()"
					STYLE="cursor: hand"><IMG
					SRC="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" BORDER="0"></SPAN></B></TD>
				
				<TD WIDTH="15%"><INPUT TYPE="text" NAME="txt_season" SIZE="20"
					maxlength="50"></TD>

				<TD VALIGN="middle" ALIGN="center" WIDTH="13%"><INPUT
					TYPE="text" NAME="txt_crop" SIZE="15" maxlength="50"></TD>

				<TD ID="amountid" WIDTH="12%"><INPUT TYPE="text"
					NAME="txt_sowmonth" VALUE="" TABINDEX="2" maxlength="50" SIZE="15" ONKEYPRESS="allowNumber(this)"
					STYLE="text-align: right"></TD>
				<TD ID="amountid" WIDTH="14%"><INPUT tabindex="3" TYPE="text"
					NAME="txt_harvmonth" VALUE="" maxlength="50" SIZE="15" ONKEYPRESS="allowNumber(this)"
					STYLE="text-align: right"></TD>
				<td> <select name="sel_meatype" onChange="callelig();showMeasurementtype();"> <option value="0">--Select--</option>
<!--				<option value="1">Number of Plants</option>-->
				<option value="2">Area in acres</option></select></td>
				<TD COLSPAN="1" width="14%">
				<INPUT TYPE="text" SIZE="15" maxlength="15" NAME="txt_areaofcult"
					VALUE="" tabindex="4" ONKEYPRESS="allowNumber(this)"
					onBlur="calcEligibility();roundtxt(this)" STYLE="text-align: right" id="aoc_nop2">
					
				</TD>	
				
			</TR>
		</table>
		</td>
	</tr>
	<tr id="idassess2">
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5">
			<tr ALIGN="center" class="dataheader">

				
            <TD nowrap width="15%">State</TD>

				
            <TD WIDTH="15%">District</TD>
            
          

				
            <TD nowrap width="14%">Eligibility</TD>

				<TD nowrap width="14%">Limit applied for</TD>

				<TD nowrap width="15%">Limit Recommended</TD>

				<TD nowrap width="17%">Due date of Repayment</TD>
			</tr>
			<tr ALIGN="center" CLASS="datagrid">

				
            <TD width="15%"> 
              <INPUT TYPE="text" NAME="txt_state" VALUE=""
					MAXLENGTH="50" SIZE="25"></TD>

				
            <TD WIDTH="15%"> 
              <INPUT TYPE="text" NAME="txt_district" VALUE=""
					MAXLENGTH="50" SIZE="25"></TD>
            
          				
            <TD WIDTH="14%"><lapschoice:CurrencyTag name="txt_eligibility"
					maxlength="15" size="15" onKeyPress="allowDecimals(this)"
					style="text-align:right" onBlur="roundtxt(this);" other="readOnly" /></TD>
				<TD WIDTH="14%"><lapschoice:CurrencyTag name="txt_limitappl"
					maxlength="15" size="15" tabindex="6"
					onKeyPress="allowDecimals(this)" style="text-align:right"
					onBlur="roundtxt(this);calcEligibility();calRecommend();"
					other="readOnly" /></TD>

				<TD WIDTH="15%"><lapschoice:CurrencyTag name="txt_limitrecom"
					maxlength="15" size="15" onKeyPress="allowDecimals(this)"
					style="text-align:right" onBlur="roundtxt(this);" other="readOnly" /></TD>

				<TD width="17%">
				<TABLE WIDTH="40%" BORDER="0" CELLSPACING="0" CELLPADDING="3">
					<TR>
						<TD><INPUT TYPE="text" SIZE="11" NAME="txt_repay"
							tabindex="7" onBlur="checkDate(this);"></TD>
						<TD><A HREF="#" ONCLICK="callCalender('txt_repay')"
							TITLE="Click to view calender"><IMG
							src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
							HEIGHT="22" BORDER="0" tabindex="8"></A></TD>
					</TR>
				</TABLE>
				</TD>
			</tr>
		</TABLE>
		</td>
	</tr>
	<tr id="idassess3">
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="5">
			<tr ALIGN="center" class="dataheader">
            <TD nowrap width="15%">Nature of Activity</TD>
            <TD WIDTH="15%"><span id="idlabel1"></span>&nbsp;</TD>
          	<TD nowrap width="15%">No. of units</TD>
            <TD nowrap width="14%">Scale of finance</TD>
            <TD nowrap width="14%">Eligibility</TD>
			<TD nowrap width="14%">Limit applied for</TD>
			<TD nowrap width="15%">Limit Recommended</TD>
			</tr>
			<tr ALIGN="center" CLASS="datagrid">
            <TD width="15%"><INPUT TYPE="text" NAME="txt_natureofactivity" VALUE="" MAXLENGTH="50" SIZE="25">&nbsp;&nbsp;
            <INPUT TYPE="hidden" NAME="hid_scaleoffin" VALUE="" MAXLENGTH="50" SIZE="25">
            <B><SPAN ONCLICK="showfinance()"
					STYLE="cursor: hand"><IMG
					SRC="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" BORDER="0"></SPAN></B></TD>
            <TD WIDTH="15%"><INPUT TYPE="text" NAME="txt_sof_unitvalue" VALUE="" MAXLENGTH="50" SIZE="25" onkeypress="checkInputValue(this);" onblur="checkInput();calcEligibility();"  style="text-align: right;"></TD>
            <TD WIDTH="14%"><INPUT TYPE="text" NAME="txt_sof_unit" VALUE="" MAXLENGTH="50" SIZE="25" onblur="calcEligibility();"  style="text-align: right;"></TD>
			<TD WIDTH="14%"><INPUT TYPE="text" NAME="txt_sof_value" VALUE=""
				MAXLENGTH="50" SIZE="25"  onblur="roundtxt(this);calcEligibility();calRecommend();" style="text-align: right;"></TD>
				<TD WIDTH="14%"><INPUT TYPE="text" NAME="txt_sof_eligibility" VALUE=""
				MAXLENGTH="50" SIZE="25" style="text-align: right;"></TD>
			<TD WIDTH="14%"><lapschoice:CurrencyTag name="txt_limitappl1"
				maxlength="15" size="15" tabindex="6"
				onKeyPress="allowDecimals(this)" style="text-align:right"
				onBlur="roundtxt(this);calcEligibility();calRecommend();" other="readOnly" /></TD>

			<TD WIDTH="15%"><lapschoice:CurrencyTag name="txt_limitrecom1"
				maxlength="15" size="15" onKeyPress="allowDecimals(this)"
				style="text-align:right" onBlur="roundtxt(this);" other="readOnly" /></TD>

			</tr>
		</TABLE>
		</td>
	</tr>
</table>
<input type="hidden" size="10" name="txt_scloffin" onBlur="roundtxt(this);calcEligibility()"></td></tr>

<br>

<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Comments" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>

		<TABLE WIDTH="98.3%" BORDER="0" CELLSPACING="1" CELLPADDING="3">
			<TR CLASS="dataheader">
				<td width="4%" class="dataheader">&nbsp;</td>
				<%if(strAssessment.equalsIgnoreCase("130")){ %>
				<td width="17%" align="center" class="dataheader">Season</td>
				<td width="17%" align="center" class="dataheader">Crop</td>
				<td width="16%" align="center" class="dataheader">Area of
				Cultivation</td>
				<td width="15%" align="center" class="dataheader">Amount</td>
				<td width="15%" align="center" class="dataheader">Eligibility</td>
				<%}else{ %>
				<td width="17%" align="center" class="dataheader">Nature of Activity</td>
				<td width="16%" align="center" class="dataheader">No. of units</td>
				<td width="15%" align="center" class="dataheader">Scale of Finance</td>
				<td width="15%" align="center" class="dataheader">Limit as per <br> scale of finance</td>
				<td width="15%" align="center" class="dataheader">Limit Recommended</td>
				<%} %>
				
				
				
			</tr>
			<%
				if (arrData != null) {
			%>
			<%
				vecsize = arrData.size();
				}
				String strSno = "";
				for (int i = 0; i < vecsize; i++) {
					arrRow = (ArrayList) arrData.get(i);
					if (arrRow != null) {
						strSno = Helper.correctNull((String) arrRow.get(5));
			%>
			<tr align="center" class="datagrid">
				<td width="5%"><input type="radio" name="sno"
					style="border-style: none"
					onClick="selectValues('<%=Helper.correctNull((String) arrRow.get(0))%>', 
											'<%=Helper.correctNull((String) arrRow.get(1))%>',
											'<%=Helper.correctNull((String) arrRow.get(2))%>',
											'<%=Helper.correctNull((String) arrRow.get(3))%>',
											'<%=Helper.correctNull((String) arrRow.get(4))%>',
											'<%=Helper.correctNull((String) arrRow.get(5))%>',
											'<%=Helper.correctDouble((String) arrRow.get(6))%>',
											'<%=Helper.correctNull((String) arrRow.get(7))%>',
											'<%=Helper.correctNull((String) arrRow.get(8))%>',
											'<%=Helper.correctNull((String) arrRow.get(9))%>',
											'<%=Helper.correctNull((String) arrRow.get(10))%>',
											'<%=Helper.correctNull((String) arrRow.get(12))%>',
											'<%=Helper.correctNull((String) arrRow.get(13))%>',
											'<%=Helper.correctNull((String) arrRow.get(15))%>',
											'<%=Helper.correctNull((String) arrRow.get(16))%>',
											'<%=Helper.correctNull((String) arrRow.get(17))%>',
											'<%=Helper.correctNull((String) arrRow.get(14))%>',
											'<%=Helper.correctNull((String) arrRow.get(18))%>',
											'<%=Helper.correctNull((String) arrRow.get(19))%>',
											'<%=Helper.correctNull((String) arrRow.get(20))%>');">
				<input type="hidden" name="hid" value="<%=strSno%>"></td>
				<%if(strAssessment.equalsIgnoreCase("130")){ %>
              <td width="17%" align="left"><%=Helper.correctNull((String) arrRow.get(1))%> 
              </td>
              <td width="17%" align="left"><%=Helper.correctNull((String) arrRow.get(2))%></td>
				
              <td width="16%" align="right">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) arrRow.get(5))%></td>
              <td width="15%" align="right">&nbsp;<%=Helper.correctNull(Helper
									.checkDecimal((String) arrRow.get(6)))%>&nbsp;</td>
				
              <td width="15%" align="right" nowrap>&nbsp;<%=Helper.correctNull(Helper
									.checkDecimal((String) arrRow.get(7)))%></td>
              <%}else{ %>
              <td width="19%" align="left"><%=Helper.correctNull((String) arrRow.get(2))%></td>
				
              <td width="16%" align="right">&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;<%=Helper.correctNull((String) arrRow.get(15))%></td>
              <td width="15%" align="right">&nbsp;<%=Helper.correctNull(Helper
									.checkDecimal((String) arrRow.get(6)))%>&nbsp;</td>
				
              <td width="15%" align="right" nowrap>&nbsp;<%=Helper.correctNull(Helper
									.checkDecimal((String) arrRow.get(7)))%></td>
				<td width="15%" align="right" nowrap>&nbsp;<%=Helper.correctNull(Helper
				.checkDecimal((String) arrRow.get(9)))%></td>
              <%} %>
				
              
				
              
			</tr>
			<%
				}
				}
			%>
			<%
				for (int i = 0; i <= 5; i++) {
			%>
			<tr class="datagrid">
				
              <td width="5%">&nbsp;</td>
              <td width="20%" align="center" valign="middle">&nbsp;</td>
              <td width="20%">&nbsp;</td>
				
              <td width="19%" align="right">&nbsp;</td>
				
              <td width="18%" align="right">&nbsp;</td>
				
              <td width="18%" align="right">&nbsp;</td>
			</tr>
			<%
				}
			%>
</table>

<br>
<p>&nbsp;</p>
<input type="hidden" name="hidorg_code"
	value="<%=Helper.correctNull((String) hshValues.get("ORG_CODE"))%>">
<input type="hidden" name="hidsno" value=""> <input
	type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden"
	name="hidBeanId"> <input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidBeanGetMethod"> <input
	type="hidden" name="hidcat_parent" value="0"> <input
	type="hidden" name="strStatId1" value=""> <input type="hidden"
	name="selsno" value=""> <INPUT TYPE="hidden" NAME="idno"
	VALUE=""> 
	<input type="hidden" name="strAppno"
	value="<%=Helper.correctNull((String) hshValues.get("appno"))%>">
<input type="hidden" name="fromRange"> <input type="hidden"
	name="toRange"><input type="hidden" name="hidAppType">
<input type="hidden" name="hidschemetype" value="<%=schemetype%>">
<input type="hidden" name="txt_noofplnts" value="">
<input type="hidden" name="hid_subvention" value="<%=Helper.correctNull((String)request.getParameter("hid_subvention"))%>">
		<input type="hidden" name="hidAppNo" value="<%=Helper.correctNull((String)request.getParameter("appno"))%>">
	<input type="hidden" name="hidCommentPage" value="cropass">
	<input type="hidden" name="hid_calcMode" value="">
	<input type="hidden" name="hid_calcValue" value="">
		
</form>

</body>
</html>

