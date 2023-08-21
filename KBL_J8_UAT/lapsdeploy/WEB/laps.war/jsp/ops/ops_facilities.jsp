<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%String strAppno = "", strFacCategory = "";
if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}

if (strCategoryType.equalsIgnoreCase("")) 
{
	strCategoryType = Helper.correctNull((String) hshValues.get("hidCategoryType"));
	if (strCategoryType.equalsIgnoreCase("CORPORATE")) {
		strCategoryType = "CORP";
	}
}
			String applicantid = "";
			String appstatus = "";
			String appname = "";
			String inwardno = "";
			String applevel = "";
			String strAppstatus="";
			String loanType="";
			String strValuesin="";
			String strApporgname="";
			String strAppholder = "";
			String btnenable="";
			if (hshValues.get("hshAppData") != null) {
				HashMap hshRecord = (HashMap) hshValues.get("hshAppData");
				strAppno = Helper.correctNull((String) hshRecord.get("appno"));
				applicantid = Helper.correctNull((String) hshRecord.get("applicantid"));
				appstatus = Helper.correctNull((String) hshRecord.get("app_status"));
				appname = Helper.correctNull((String) hshRecord.get("app_name"));
				inwardno = Helper.correctNull((String) hshRecord.get("inwardno"));
				applevel = Helper.correctNull((String) hshRecord.get("applevel"));
				strAppholder = Helper.correctNull((String) hshRecord.get("applnholder"));
				strValuesin=Helper.correctNull((String) hshRecord.get("valuesin"));
				strApporgname=Helper.correctNull((String) hshRecord.get("apporgname"));
				loanType=Helper.correctNull((String) hshRecord.get("apploantype"));
				strAppstatus= Helper.correctNull((String) hshRecord.get("app_status"));
				btnenable=(""+Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)).equals("r")?"N":(appstatus.equals("op") && strAppholder.equals(Helper.correctNull((String)session.getAttribute("strUserId"))))?"Y":"N";
			}
			if (strAppno.equalsIgnoreCase("")) {
				strAppno = Helper.correctNull((String) request.getParameter("appno"));
			}
			if (appstatus.equalsIgnoreCase("")) {
				appstatus = Helper.correctNull((String) request.getParameter("appstatus"));
			}
			if (appstatus.equalsIgnoreCase("op") || strAppno.equalsIgnoreCase("new")) {
				appstatus = "Open/Pending";
			} else if (strAppstatus.equalsIgnoreCase("pa")) {
				appstatus = "Processed/Approved";
			} else if (strAppstatus.equalsIgnoreCase("pr")) {
				appstatus = "Processed/Rejected";
			} else if (strAppstatus.equalsIgnoreCase("ca")) {
				appstatus = "Closed/Approved";
			} else if (strAppstatus.equalsIgnoreCase("cr")) {
				appstatus = "Closed/Rejected";
			}
			if (appname.equalsIgnoreCase("")) {
				appname = Helper.correctNull((String) request.getParameter("compname"));
			}
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			ArrayList vecHead = new ArrayList();
			ArrayList vecFac = new ArrayList();
			String strHeaddesc = "";
			String strHeadId = "";
			String strFacId = "";
			String strFacdesc = "";
			String strExist = "";
			String strProposed = "";
			String strDiff = "";
			String strIntadjust = "", strAction = "", strFacType = "facility";
			String strMargin = "";
			String strInterest = "";
			String strInt = "";
			String strbplr = "";
			String strCbsaccountno = "";
			String strOutstanding = "";
			int vecsize = 0;
			String strLC = Helper.correctNull((String) hshValues.get("lc"));
			String strTotExist = Helper.correctNull((String) hshValues.get("totexist"));
			String strTotDiff = Helper.correctNull((String) hshValues.get("totdiff"));
			strAppno = Helper.correctNull((String) hshValues.get("appno"));
			String strselsno = Helper.correctNull((String) hshValues.get("selsno"));
			String strsubselsno = Helper.correctNull((String) hshValues.get("selsubsno"));
			strAction = Helper.correctNull((String) hshValues.get("hidAction"));
			strFacType = Helper.correctNull((String) hshValues.get("factype"));
			strFacCategory = Helper.correctNull((String) hshValues.get("faccategory"));
			strInterest = Helper.correctNull((String) hshValues.get("facility_interest"));
			if (strFacCategory.trim().equals("")) {
				strFacCategory = "R";
			}
			if (strFacType.trim().equals("")) {
				strFacType = "facility";
			}
			if (hshValues != null) {
				vecData = (ArrayList) hshValues.get("vecData");
			}
			
			// end
			if (strBorrowerId.trim().equals("")) {
				strBorrowerId = Helper.correctNull((String) request.getParameter("comapp_id"));
			}
			String appval = Helper.correctNull((String) request.getParameter("val"));
			String appflag = Helper.correctNull((String) request.getParameter("valf"));
			String appMangflag = Helper.correctNull((String) request.getParameter("valm"));
			String appGroupflag = Helper.correctNull((String) request.getParameter("valg"));
			%>
<html>
<head>
<title>Facilities</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var editflag=1;
var varhidAction ="<%=strAction%>";
var editlockflag="<%=hshValues.get("editlock")%>";
var varhidpge="";
var varhidRen="";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var headid = "<%=Helper.correctNull((String)hshValues.get("headid"))%>";
var facid = "<%=Helper.correctNull((String)hshValues.get("facdid"))%>";
var subheadid = "<%=Helper.correctNull((String)hshValues.get("subheadid"))%>";
var subfacid = "<%=Helper.correctNull((String)hshValues.get("subfacdid"))%>";
var varinwardnorequired="<%=Helper.correctNull((String)hshValues.get("inwardnorequired"))%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/agrpage.jsp?hidCategoryType=OPS";
		document.forms[0].submit();
	}
}

function selectvalues1()
{
	arr1=document.forms[0].facility_head.value.split("~");
}

function showval()
{
	arr1=document.forms[0].facility_head.value.split("~");
}

function checkAdhocMonths(obj1)
{
	if(obj1.value!="")
	{
		if(document.forms[0].category[1].checked==true)	
		{
			if(eval(obj1.value)>3)
			{
				obj1.value="";
				alert("Adhoc period cannot be greater than three months");
			}
		}
	}
}

function selectValues(sno,subsno)
{	
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		if(subsno!=0)
		{
			document.forms[0].cmdnew.disabled=true;
		}
		else
		{
			document.forms[0].cmdnew.disabled=false;
		}
	}
	var group=0;
	var strheadid=0,strfacid=0,strsubheadid=0,strsubfacid=0;
 	document.forms[0].hidAction.value = "update";
	document.forms[0].appno.value = "<%=Helper.correctNull((String)hshValues.get("appno"))%>";
	len = document.forms[0].facility_head.length;
	document.forms[0].selsno.value="";
	document.forms[0].selsubsno.value="0";
	if(sno)
	{		
		if(document.forms[0].elements["txtcategory"+sno].value=="R")
		{
			document.forms[0].category[0].checked=true;
		}
		else if(document.forms[0].elements["txtcategory"+sno].value=="A")
		{
			document.forms[0].category[1].checked=true;
		}
	}
 	if(document.forms[0].elements["txtsublimit"+sno].value=="Y")
	{
		group = document.forms[0].elements["txtgroup"+sno].value;
		if(group>0)
		{			
 			strheadid = document.facility.elements["txtheadid"+group].value;
			strfacid = document.facility.elements["txtfacid"+group].value;
			strsubheadid = document.facility.elements["txtsubheadid"+sno].value;
			strsubfacid = document.facility.elements["txtsubfacid"+sno].value;
			document.forms[0].selsno.value = document.forms[0].elements["txtsno"+sno].value;
			document.forms[0].selsubsno.value = subsno;
			document.forms[0].factype.value = "sublimit";
			document.forms[0].checkbox.checked=true
			document.forms[0].txt_exist_limit.value=document.forms[0].elements["txtexist"+subsno+"0"].value;	
			document.forms[0].txt_proposed_limit.value=document.forms[0].elements["txtproposed"+subsno+"0"].value;
			document.forms[0].hidproposed.value=document.forms[0].elements["txtproposed"+subsno+"0"].value;
			document.forms[0].txt_intadjust.value=document.forms[0].elements["txtintadjust"+subsno+"0"].value;
			document.forms[0].txt_interest.value=document.forms[0].elements["txt_interest"+subsno+"0"].value;			
			document.forms[0].txt_subexist_limit.value=document.forms[0].elements["txtsubexist"+sno+subsno].value;
			document.forms[0].txt_subproposed_limit.value=document.forms[0].elements["txtsubproposed"+sno+subsno].value;
			document.forms[0].txt_subintadjust.value=document.forms[0].elements["txtsubintadjust"+sno+subsno].value;
			document.forms[0].txt_subinterest.value=document.forms[0].elements["txt_subinterest"+sno+subsno].value;
			document.forms[0].prd_subintrate.value=document.forms[0].elements["txtsubbplr"+sno+subsno].value;
			document.forms[0].prd_intrate.value=document.forms[0].elements["txtbplr"+subsno+"0"].value;	
			document.forms[0].txt_outstanding.value=document.forms[0].elements["txtoutstanding"+subsno+"0"].value;	
			document.forms[0].txt_sub_outstanding.value=document.forms[0].elements["txtsuboutstanding"+sno+subsno].value;			
			document.forms[0].txt_cbsaccno.value=document.forms[0].elements["txtcbsaccno"+subsno+"0"].value;	
			document.forms[0].txt_subcbsaccno.value=document.forms[0].elements["txtsubcbsaccno"+sno+subsno].value;
			document.forms[0].txt_purpose.value=document.forms[0].elements["txtpurpose"+subsno+"0"].value;	
			document.forms[0].txt_subpurpose.value=document.forms[0].elements["txtsubpurpose"+sno+subsno].value;
			document.forms[0].txt_tenor.value=document.forms[0].elements["txtmonths"+subsno+"0"].value;
			document.forms[0].txt_subtenor.value=document.forms[0].elements["txtsubmonths"+sno+subsno].value;
		}
	}
	else
	{	
		strheadid = document.facility.elements["txtheadid"+sno].value;
		strfacid = document.facility.elements["txtfacid"+sno].value;
		document.forms[0].subfacility_head.selectedIndex=0;
		document.forms[0].subfacility.length=1;
		document.forms[0].subfacility.selectedIndex=1;
		document.forms[0].selsno.value = document.forms[0].elements["txtsno"+sno].value;
		document.forms[0].txt_exist_limit.value=document.forms[0].elements["txtexist"+sno+subsno].value; 
		document.forms[0].txt_proposed_limit.value=document.forms[0].elements["txtproposed"+sno+subsno].value;
		document.forms[0].hidproposed.value=document.forms[0].elements["txtproposed"+sno+subsno].value;
		document.forms[0].txt_intadjust.value=document.forms[0].elements["txtintadjust"+sno+subsno].value;
		document.forms[0].txt_interest.value=document.forms[0].elements["txt_interest"+sno+subsno].value;	
		document.forms[0].prd_intrate.value=document.forms[0].elements["txtbplr"+sno+subsno].value;			
		document.forms[0].txt_outstanding.value=document.forms[0].elements["txtoutstanding"+sno+subsno].value;
		document.forms[0].txt_cbsaccno.value=document.forms[0].elements["txtcbsaccno"+sno+subsno].value;
		document.forms[0].txt_purpose.value=document.forms[0].elements["txtpurpose"+sno+subsno].value;
		document.forms[0].txt_tenor.value=document.forms[0].elements["txtmonths"+sno+subsno].value;
		document.forms[0].txt_subexist_limit.value="";
		document.forms[0].txt_subproposed_limit.value="";
		document.forms[0].txt_subintadjust.value="";
		document.forms[0].txt_subinterest.value="";
		document.forms[0].prd_subintrate.value="";
		document.forms[0].txt_subtenor.value="";
		document.forms[0].txt_sub_outstanding.value="";
		document.forms[0].txt_subcbsaccno.value="";
		document.forms[0].txt_subpurpose.value="";
		document.forms[0].factype.value = "facility";
		document.forms[0].checkbox.checked=false;
	}
	for(k=0;k<len;k++)
	{
		arr = document.facility.facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strheadid)
			{
				document.facility.elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strheadid!="")
	{	
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strheadid+"&value=subsel&hidMethod=getFacility&factid="+strfacid+"&strtype=facility";
	}
 	for(k=0;k<len;k++)
	{
		arr = document.facility.subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==strsubheadid)
			{
				document.facility.elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(strsubheadid!="")
	{
		if(!isNaN(strsubheadid))
		{
			document.forms[0].checkbox.checked=true;
		}
		else
		{
			document.forms[0].checkbox.checked=false;
		}
		document.all.ifrm2.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+strsubheadid+"&value=subsel&hidMethod=getFacility&factid="+strsubfacid+"&strtype=sublimit";
	}
	else
	{
		document.forms[0].checkbox.checked=false;
	}
	disableCommandButtons("load");
	disableFields(true);
}

function totalInt()
{
	var baserate = parseFloat(document.forms[0].prd_intrate.value);
	var adjrate= parseFloat(document.forms[0].txt_intadjust.value);

	if(baserate == null || isNaN(baserate))
	{
		baserate = 0.00;
	}
	if(adjrate == null || isNaN(adjrate))
	{
		adjrate = 0.00;
	}
	document.forms[0].txt_interest.value = roundVal(baserate + adjrate);	
}

function sub_totalInt()
{
	var baserate1 = parseFloat(document.forms[0].prd_subintrate.value);
	var adjrate1= parseFloat(document.forms[0].txt_subintadjust.value);
	if(baserate1 == null || isNaN(baserate1))
	{
		baserate1 = 0.00;
	}
	if(adjrate1 == null || isNaN(adjrate1))
	{
		adjrate1 = 0.00;
	}
	document.forms[0].txt_subinterest.value = roundVal(baserate1 + adjrate1);	
}

function getFacility(strtype)
{	
	if(strtype=="facility")
	{
		arr1=document.forms[0].facility_head.value.split("~");		
		var facilityhead = document.forms[0].elements["facility_head"].value;		
		arr = facilityhead.split("-");		
		var parentparam =arr[0];
		if(parentparam)
		{	document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility";
		}
	}
	else if(strtype=="sublimit")
	{		
		var subfacilityhead = document.forms[0].elements["subfacility_head"].value;
		arr = subfacilityhead.split("-");
		var parentparam =arr[0];			
		if(parentparam)
		{
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=sublimit";
		}
		else
		{			
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=1;
		}
	} 
} 

function doSave()
{ 		
	var prop =0,sno=0,subsno=0;
	var sublimit=0;
	assignData();
	var factype=document.forms[0].factype.value;
	if(!isNaN(document.forms[0].selsno.value))
	{
		sno = parseInt(document.forms[0].selsno.value);
	}
	if(!isNaN(document.forms[0].selsubsno.value))
	{
		subsno = parseFloat(document.forms[0].selsubsno.value);
	}
	if(!sno)
	{
		sno=0;
	}
	if(!subsno)
	{
		subsno=0;
	}
	if(!isNaN(document.forms[0].txt_proposed_limit.value))
	{
		prop = parseFloat(document.forms[0].txt_proposed_limit.value);
	}
	if(!prop)
	{
		prop=0.00;
	}
	if(!isNaN(document.forms[0].txt_subproposed_limit.value))
	{
		sublimit = parseFloat(document.forms[0].txt_subproposed_limit.value);
	}	 
	if(!sublimit)
	{
		sublimit=0.00;
	}	
	if(sublimit>prop)
	{
		alert("The Sublimit 'proposed limit' exceeds the Parent facility 'proposed limit'");
		return;
	}
	if(varinwardnorequired=="" && document.forms[0].txt_appinwardno.value=="")
	{
		ShowAlert(121,'Application Inward No');
		document.forms[0].txt_appinwardno.focus();
		return;
	}
 	if(document.forms[0].comapp_id.value=="")
	{
		ShowAlert(111,'Borrower');
	}
	else if( (factype=="facility") && (document.forms[0].facility_head.value=="-"))
	{
		ShowAlert(111,'facility head');
	}
	else if( (factype=="facility") && (document.forms[0].facility.value=="-"))
	{
		ShowAlert(111,'facility type');	
	}
	else if( (factype=="sublimit") && (document.forms[0].subfacility_head.value=="-"))
	{
		ShowAlert(111,'Sub facility head');
	}
	else if( (factype=="sublimit") && (document.forms[0].subfacility.value=="-"))
	{
		ShowAlert(111,'Sub facility type');	
	}
	else if((factype=="facility") && ((document.forms[0].txt_exist_limit.value=="" && document.forms[0].txt_proposed_limit.value=="")||(document.forms[0].txt_exist_limit.value=="0.00" && document.forms[0].txt_proposed_limit.value=="0.00")))
	{		
		alert("Please Define the Values for Existing/Proposed Limit");
	}
	else if((factype=="sublimit") && ((document.forms[0].txt_subexist_limit.value=="" && document.forms[0].txt_subproposed_limit.value=="") || (document.forms[0].txt_subexist_limit.value=="0.00" && document.forms[0].txt_subproposed_limit.value=="0.00")))
	{
		alert("Please Define the Values for Existing/Proposed Limit");		
	}	
	else
	{	
		var lc=0,prop=0,hidprop=0;			
		if(document.forms[0].hidproposed.value!="")
		{
			hidprop = parseFloat(document.forms[0].hidproposed.value);
		}
		if(!hidprop)
		{
			hidprop =0;
		}
		if(document.forms[0].txt_proposed_limit.value!="")
		{
			prop = parseFloat(document.forms[0].txt_proposed_limit.value);
		}
		if(!prop)
		{
			prop =0;
		}
		if(document.forms[0].hid_line_credit.value!="")
		{
			lc = parseFloat(document.forms[0].hid_line_credit.value);
		}
		if(!lc)
		{
			lc =0;
		}		
		if(document.forms[0].category[0].checked==true)
		{
			document.forms[0].faccategory.value="R";
		}
		else if(document.forms[0].category[1].checked==true)
		{
			document.forms[0].faccategory.value="A";
		}
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].factype.value="sublimit";
		}
		else
		{
			document.forms[0].factype.value="facility"
		}				
		document.forms[0].txt_line_credit.value = lc-hidprop+prop;
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ops_facilities.jsp";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="updateOPSData";
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
		document.forms[0].submit();
	}
}

function findtype()
{
	var hidAction = document.forms[0].hidAction.value;
	var subno=0;
	var factype =document.forms[0].factype.value;
	if(!isNaN(document.forms[0].selsubsno.value))
	{
	 subno = parseInt(document.forms[0].selsubsno.value);
	}
	if(!subno)
	{
		subno=0;
	}
	if(document.forms[0].facility_head.value=="-")
	{
		alert("Select any Main Limit then select sublimit");
		document.forms[0].checkbox.checked=false;
		return true;
	}
	if(document.forms[0].cmdnew.disabled==true && document.forms[0].cmdnew.disabled==true)
	{
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].checkbox.checked=false;
			alert("Can't check in edit mode or add mode");			
			return;
		}
	}
	if((document.forms[0].cmdedit.disabled==true) && (hidAction=="update") && (factype=="sublimit"))
	{
		alert("Can't uncheck");
		document.forms[0].checkbox.checked=true;
		return;
	}
	 else if((subno>0) && (document.forms[0].factype.value=="sublimit") && (hidAction=="update"))
	 {
		alert("Can't uncheck,because sub-limit exists");
		document.forms[0].checkbox.checked=true;
		return;
	 }
	if(document.forms[0].checkbox.checked==true)
	{
	}
	else
	{
		 if((subno>0) && (document.forms[0].factype.value=="sublimit") && ("<%=strAction%>"=="update"))
		 {	
			alert("Can't uncheck");
		 	document.forms[0].checkbox.checked=true
			 return;
		 }
		else
		{
		document.forms[0].factype.value="facility"
		}
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
		if(document.forms[0].elements[i].type=='select-one' )
		{
 				document.forms[0].elements[i].disabled=val;
		}
	}
	document.forms[0].txt_interest.readOnly=true;
	document.forms[0].txt_subinterest.readOnly=true;	
	document.forms[0].prd_intrate.readOnly=true;
	document.forms[0].prd_subintrate.readOnly=true;
	document.forms[0].txt_appinwardno.readOnly=true;	
}

function disableCommandButtons(val)
{
	if(val=="load")
	{
		if(document.forms[0].btnenable.value =="N")
		{
			document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;
			document.forms[0].cmddeleteapplication.disabled=true;
	 	}
	 	else
	 	{
	 		document.forms[0].cmdedit.disabled=false;
			document.forms[0].cmddelete.disabled=false;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;
	 	}
	}
	if(val=="edit" || varhidpge =='newpge' ||varhidRen == 'renewal')
	{
		if(document.forms[0].btnenable.value=="N")
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
			document.forms[0].cmddelete.disabled=true;
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


function doAfterEdit()
{
	if(document.forms[0].btnenable.value =="N")
	{
		disableFields(true);
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddeleteapplication.disabled=true;
		return;
	}
	if(varhidAction=="insert")
	{
		if(document.forms[0].factype.value=="facility")
		{
			document.forms[0].facility_head.selectedIndex=0;
			document.forms[0].facility.length=1;
			document.forms[0].facility.selectedIndex=0;
			document.forms[0].selsno.value ="";
			document.forms[0].selsubsno.value ="";
			document.forms[0].txt_exist_limit.value="";
			document.forms[0].txt_proposed_limit.value="";
			document.forms[0].txt_intadjust.value="";
			document.forms[0].txt_interest.value="";			
			document.forms[0].txt_cbsaccno.value="";
			document.forms[0].prd_intrate.value="";	
			document.forms[0].txt_interest.readOnly=true;	
			document.forms[0].hidproposed.value="";

			document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_subproposed_limit.value="";
			document.forms[0].txt_subintadjust.value="";
			document.forms[0].txt_subinterest.value="";	
			document.forms[0].txt_subcbsaccno.value="";	
			document.forms[0].prd_subintrate.value="";			 
			document.forms[0].txt_subinterest.readOnly=true;
		}
		else if(document.forms[0].factype.value=="sublimit")
		{
			document.forms[0].selsubsno.value ="";
			document.forms[0].subfacility_head.selectedIndex=-1;
			document.forms[0].subfacility.length=0;
			document.forms[0].subfacility.selectedIndex=-1;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_subproposed_limit.value="";
			document.forms[0].txt_subintadjust.value="";
			document.forms[0].txt_subinterest.value="";
			document.forms[0].txt_subcbsaccno.value="";	
			document.forms[0].prd_subintrate.value="";
		}
		 disableCommandButtons("edit");
	}
	else if(varhidAction=="delete")
	{
		 if(document.forms[0].factype.value=="facility")
		 {
			document.forms[0].facility_head.selectedIndex=0;
			document.forms[0].facility.length=1;
			document.forms[0].facility.selectedIndex=1;
			document.forms[0].selsno.value ="";
			document.forms[0].selsubsno.value ="";
			document.forms[0].txt_exist_limit.value="";
			document.forms[0].txt_proposed_limit.value="";
			document.forms[0].txt_intadjust.value="";
			document.forms[0].txt_interest.value="";			
			document.forms[0].hidproposed.value="";
			document.forms[0].txt_cbsaccno.value="";
			document.forms[0].prd_intrate.value="";	

			document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_subproposed_limit.value="";
			document.forms[0].txt_subintadjust.value="";
			document.forms[0].txt_subinterest.value="";	
			document.forms[0].txt_subcbsaccno.value="";	
			document.forms[0].prd_subintrate.value="";		
		}
		else if(document.forms[0].factype.value=="sublimit")
		{
			document.forms[0].selsubsno.value ="";
			document.forms[0].subfacility_head.selectedIndex=0;
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=0;
			document.forms[0].txt_subexist_limit.value="";
			document.forms[0].txt_subproposed_limit.value="";
			document.forms[0].txt_subintadjust.value="";
			document.forms[0].txt_subinterest.value="";	
			document.forms[0].txt_subcbsaccno.value="";	
			document.forms[0].prd_subintrate.value="";	
		 }
		clearRadioButton();
		disableCommandButtons("edit");
	}
	if("<%=request.getParameter("appno")%>" != "new")
	{
		var editcheck="<%=request.getParameter("hideditflag")%>";
		if(editcheck=="yes")
		{
			if(editlockflag=="y")
			{
				disableCommandButtons("edit");
			}
			else
			{
				disableFields(true);
				ShowAlert(128);
				disableCommandButtons("load");
			}
		}
		else
		{
			disableFields(true);
			disableCommandButtons("load");
		}
	}
	else
	{
			disableCommandButtons("edit");
	}
 }

function doEdit()
{
	var subno=0;
	var hidAction = document.forms[0].hidAction.value;
	if(!isNaN(document.forms[0].selsubsno.value))
	{
	 subno = parseInt(document.forms[0].selsubsno.value);
	}
	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].factype.value="sublimit"
	}
	else
	{
		document.forms[0].factype.value="facility";
	}
	 if((!subno) && (document.forms[0].factype.value=="sublimit") && (hidAction=="update"))
	 {
		alert("Sub-limit was not selected to modify");
		return;
	 }
	if(document.forms[0].appno.value!="")
	{
		if(document.forms[0].selsno.value!="")
		{
			document.forms[0].hidAction.value ="update";
			disableFields(false);
			document.forms[0].cmdnew.disabled=true;
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=false;
			document.forms[0].cmdcancel.disabled=false;
			document.forms[0].cmdclose.disabled=true;
		 }
		 else
		{
				ShowAlert(111,'facility');
		}
	 }
	 else
	 {
		ShowAlert(111,'Application');
	 }
 }
function clearRadioButton()
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if((document.forms[0].elements[i].name.indexOf("category"))!=0 && (document.forms[0].elements[i].type=="radio"))
		{
			document.forms[0].elements[i].checked=false;
		}
	}
}
function doNew()
{	
	document.forms[0].txt_subinterest.value="";
	if(document.forms[0].checkbox.checked==true)
	{
		document.forms[0].factype.value="sublimit"
	}
	else
	{
		document.forms[0].factype.value="facility";
	}
	 clearRadioButton();
	disableFields(false);
	if(document.forms[0].factype.value=="facility")
	{
		document.forms[0].facility_head.selectedIndex=0;
		document.forms[0].facility.length=1;
		document.forms[0].facility.selectedIndex=0;
		document.forms[0].selsno.value ="";
		document.forms[0].selsubsno.value ="";
		document.forms[0].txt_exist_limit.value="";
		document.forms[0].txt_proposed_limit.value="";
		document.forms[0].txt_intadjust.value="";
		document.forms[0].txt_interest.value="";			//raman
		document.forms[0].hidproposed.value="";

		document.forms[0].subfacility_head.selectedIndex=0;
		document.forms[0].subfacility.length=1;
		document.forms[0].subfacility.selectedIndex=0;
		document.forms[0].txt_subexist_limit.value="";
		document.forms[0].txt_subproposed_limit.value="";
		document.forms[0].txt_subintadjust.value="";
		document.forms[0].txt_subinterest.value="";			//raman
	}
	else if(document.forms[0].factype.value=="sublimit")
	{
 		document.forms[0].selsubsno.value ="";
		document.forms[0].subfacility_head.selectedIndex=0;
		document.forms[0].subfacility.length=1;
		document.forms[0].subfacility.selectedIndex=0;
		document.forms[0].txt_subexist_limit.value="";
		document.forms[0].txt_subproposed_limit.value="";
		document.forms[0].txt_subintadjust.value="";
		document.forms[0].txt_subinterest.value="";			//raman

	}
	document.forms[0].hidAction.value ="insert";
	document.forms[0].cmdnew.disabled=true;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
 }
function doCancel()
{
	var subno=0;
	var factype = document.forms[0].factype.value;
	var hidAction = document.forms[0].hidAction.value;
	if(ConfirmMsg(102))
	{
		document.forms[0].hideditflag.value="no";
		 if(!isNaN(document.forms[0].selsubsno.value))
		{
			 subno = parseInt(document.forms[0].selsubsno.value);
		}
		if(!subno)
		{
			subno=0;
		}
		if((subno==0) && (factype="sublimit") && (hidAction =="update"))
		{
			document.forms[0].factype.value = "facility";
		}
		if(document.forms[0].checkbox.checked==true)
		{
		}
		else
		{
		}
		document.forms[0].hidBeanMethod.value="";
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
		document.forms[0].hidSourceUrl.value="action/ops_facilities.jsp";	
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/controllerservlet";	
		document.forms[0].submit();
	}
}
function doDelete()
	{
		var factype="";
		if(ConfirmMsg(101))
		{
		if(document.forms[0].checkbox.checked==true)
		{
			document.forms[0].factype.value ="sublimit";
			factype="sublimit"
		}
		else
		{
			document.forms[0].factype.value ="facility";
			factype="facility"
		}
		if(document.forms[0].appno.value!="")
		{
			if((factype=="facility") && (document.forms[0].selsno.value==""))
			{
				ShowAlert(111,'facility');	
				return;
			}
			else if((factype=="sublimit") && (document.forms[0].selsubsno.value==""))
			{
				ShowAlert(111,'Sub-limit');	
				return;
			}
			else
			{
 		assignData();
				document.forms[0].hidAction.value ="delete";
				document.forms[0].hidBeanId.value="facilities";
				document.forms[0].hidBeanMethod.value="updateOPSData";
				document.forms[0].hidBeanGetMethod.value="getOPSFacilityData";
				document.forms[0].hidSourceUrl.value="action/ops_facilities.jsp";	
				document.forms[0].method="post";
				document.forms[0].action=appUrl+"action/controllerservlet";	
				document.forms[0].submit();
			 }
		}
		else
		{
			ShowAlert(111,'Application');
		}
		}
	}
function callApplicanthelp()
{
	if(document.forms[0].cmdedit.disabled && editflag==1)
	{
		var prop = "scrollbars=no,width=450,height=300,,top=100,left=250";
		var url=appUrl+"action/comapplicantlist.jsp";
		window.open(url,"",prop);
	}
}

function opendisfixed(field)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
	var num="-";
	
	var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	var prop = "scrollbars=no,width=450,height=360";	
	var title = "InterestRate";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
window.open(purl,title,prop);
	}
}
function callApplicantTab(page)
{ 
 var cattype=document.forms[0].cattype.value;

 	if(document.forms[0].cmdsave.disabled)
	{
 
	if(page=="company")
	{ 
	 if((cattype!="ASSI")||(cattype!="ASBI"))
{
		document.forms[0].hidBeanGetMethod.value="getcompanyData";
		document.forms[0].action=appUrl+"action/comcompany.jsp";
		}
		if((cattype=="ASSI")||(cattype=="ASBI"))
{
		document.forms[0].hidBeanGetMethod.value="getcompanyData";
		document.forms[0].action=appUrl+"action/agrcompany.jsp";
		}
	}
	if(page=="proposal")
	{
		document.forms[0].hidBeanGetMethod.value="getProposal";
		document.forms[0].action=appUrl+"action/comproposal.jsp";
	}
	document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function onloading()
{
	var Check="<%=Helper.correctNull((String)hshValues.get("strCountcheck"))%>";

	if(Check == "Yes")
	{	
		alert("InValid Application Number Please Enter Valid Application Number");
		document.forms[0].hidBeanId.value="borrowersearch";
		document.forms[0].hidBeanGetMethod.value="getData";
		var cattype=document.forms[0].cattype.value;

		if((cattype=="ASSI")||(cattype=="ASBI"))
		{
			if(ConfirmMsg(100))
			{
			 	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/agrpage.jsp";
			 	document.forms[0].target="mainFrame";
			 	document.forms[0].submit();
		 	}
		}
		if((cattype=="SSI")||(cattype=="CORP") ||(cattype=="SME"))
		{
			if(ConfirmMsg(100))
		 	{
				document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
			 	document.forms[0].target="mainFrame";
				document.forms[0].submit();
		 	}
		}
	}
	document.forms[0].appno.value = "<%=Helper.correctNull((String)hshValues.get("appno"))%>";
	len = document.forms[0].facility_head.length;
	for(k=0;k<len;k++)
	{
		arr = document.facility.facility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==headid)
			{
				document.facility.elements["facility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(headid!="" && varhidAction!="insert")
	{
		document.all.ifrm1.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+headid+"&value=subsel&hidMethod=getFacility&factid="+facid+"&strtype=facility";
	}
	for(k=0;k<len;k++)
	{
		arr = document.facility.subfacility_head.options[k].value.split("-");
		if(arr!=null)
		{
			if(arr[0]==subheadid)
			{
				document.facility.elements["subfacility_head"].options[k].selected=true;
				break;
			}
		}
	}
	if(subheadid!="" && varhidAction!="insert")
	{
		if(!isNaN(subheadid))
		{
			document.forms[0].checkbox.checked=true;
		}
		else
		{
			document.forms[0].checkbox.checked=false;
		}
		document.all.ifrm2.src=appUrl+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+subheadid+"&value=subsel&hidMethod=getFacility&factid="+subfacid+"&strtype=sublimit";
	}
	else
	{
		document.forms[0].checkbox.checked=false;
	}

	<%if(strAppno.equals("new")) 
	{	%>
		document.forms[0].cmdnew.disabled=true;
		<%}%>
		
	if(document.forms[0].cmdedit.disabled)
		editflag=0;
	if("<%=strFacCategory.trim()%>"=="R")
	{
		document.forms[0].category[0].checked=true;
	}
	else if("<%=strFacCategory.trim()%>"=="A")
	{
		document.forms[0].category[1].checked=true;
	}
	
	doAfterEdit();
	if(document.forms[0].readFlag.value.toUpperCase()=="R")
	{
		document.forms[0].cmddeleteapplication.disabled=true;
	}
	clearRadioButton();
	
}
function selectSublimit()
{
	if(document.forms[0].checkbox.checked==false)
	{
		alert("Check sublimit option");
		document.forms[0].subfacility_head.selectedIndex=0;
 		return;
	}
}

function doDeleteApplication()
{
 if(document.forms[0].appno.value != "")
 {
	 if(ConfirmMsg(136))
		{
		document.forms[0].hidAction.value ="deleteapplication";
		document.forms[0].hidBeanMethod.value ="";
		document.forms[0].hidBeanGetMethod.value ="updateCompanyData";
		document.forms[0].hidBeanId.value ="facilities";
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/agrpage.jsp";	
		document.forms[0].submit();
		}
	}
}

function showAckSearch()
{		
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varCategory = "t";
		var varQryString = appUrl+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varCategory;
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}
function callDemographics()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		document.forms[0].hidBeanId.value="mastapplicant";
		document.forms[0].hidBeanGetMethod.value="getDemographics";
		document.forms[0].action=appURL+"action/ops_applicantdisp1.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callSubsidy()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getDataSubsidy";
		document.forms[0].action=appURL+"action/ops_subsidy.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function callAccountDetails()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanGetMethod.value="getAccountDetails";
		document.forms[0].action=appURL+"action/ops_accountdetails.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert('103');
	}
}
function assignData()
{
try
{
	document.forms[0].hid_facility_head.value=document.forms[0].facility_head.options[document.forms[0].facility_head.selectedIndex].text;
	document.forms[0].hid_facility.value=document.forms[0].facility.options[document.forms[0].facility.selectedIndex].text;
	document.forms[0].hid_subfacility_head.value=document.forms[0].subfacility_head.options[document.forms[0].subfacility_head.selectedIndex].text;
	document.forms[0].hid_subfacility.value=document.forms[0].subfacility.options[document.forms[0].subfacility.selectedIndex].text;
}
catch(errr)
{
}
}
function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appUrl,val);
	}
}
</script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading(); showval()">
<form method="post" name="facility" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> 
			 <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>"></td>
	</tr>
	<tr>
		<td class="page_flow">Home -&gt; Tertiary-&gt;
		Application-&gt; Facilities</td>
	</tr>
	<tr>
		<td><span ><lapschoice:borrowertype /></span>		
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
	<tr class="applicationheader">
		<td>
			<b>Application No :</b>
		</td>
		<td>
			<%=strAppno%>&nbsp;
		</td>
		<td>
			<b>Applicant Name:</b>
		</td>
		<td>
			<%=appname%>&nbsp;
		</td>
		<td>
			<b>Status:</b>
		</td>
		<td>
			<%=appstatus%>&nbsp;
		</td>
	</tr>
	<tr class="applicationheader">
		<td>
			<b>Application Holder:</b>
		</td>
		<td>
			<%=strAppholder%>&nbsp;
		</td>
		<td>
			<b>App. Recd. from:</b>
		</td>
		<td>
			<%=strApporgname%>&nbsp;
		</td>
		<td>
			<b>Inward No :</b>
		</td>
		<td>
			<%=inwardno%>&nbsp;
			<input type="hidden" name="appname" value="<%=appname%>">
			<input type="hidden" name="appno" value="<%=strAppno%>">
			<input type="hidden" size="3" name="hidapplicantid" value="<%=applicantid%>">
			<input type="hidden" name="inwardno" value="<%=inwardno%>">
			<input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
			<input type="hidden" size="3" name="appholder" value="<%=strAppholder%>">
			<input type="hidden" name="applevel" value="<%=applevel%>">
			<input type="hidden" name="apploantype" value="<%=loanType%>">
			<input type="hidden" name="valuesin" value="<%=strValuesin%>">
			<input type="hidden" name="strappstatus" value="<%=strAppstatus%>">
			<input type="hidden" name="apporgname" value="<%=strApporgname%>">
			<input type="hidden" name="btnenable" value="<%=btnenable%>">
			</td>
	</tr>
</table>
		</td>
	</tr>
</table>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_active"><b>Facilities</b></td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'comssiaboveten','getDataSubsidy','ops_subsidy.jsp')">Subsidy</a></b>
						</td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'comssiaboveten','getAccountDetails','ops_accountdetails.jsp')">Account Details</a></b>
						</td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'compro','getCapitalStructure','com_capitalstructure.jsp')">Capital Structure</a></b>
						</td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'ssidemographics','getOpsdemograph','ops_demographics.jsp')">Details of Promoter/Guarantor</a></b>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>		
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td valign="top">						
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
<tr> 
<td width="3%"> 
<input type="radio" name="category" style="border-style:none" checked="checked" onClick="doNew()">
</td>
<td width="7%">Main Limit</td>
<td width="80%">&nbsp;</td>
<td width="3%"> 
<input type="radio" name="category" style="border-style:none" checked="checked">
</td>
<td>Adhoc</td>
</tr>
</table>
						</td>
					</tr>
					<tr>
						<td valign="top">
						<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
										<td colspan="4">
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
											<tr>
												<td width="15%">Acknowledgement No.<span class="mantatory">*&nbsp;</span></td>
												<td width="45%"><input type="text"
													name="txt_appinwardno" size="20" maxlength="15" tabindex=""
													onkeypress="allowInteger(this)" value="<%=inwardno%>"
													readOnly="readonly"> <b><span onClick="showAckSearch()"
													style="cursor:hand"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="36"></span></b></td>
												
<td align="right" width="20%"><b>Details As on</b></td>
												<td width="20%"><table width="100%" border="0" class="outertable">
<tr> 
<td width="21%"> 
<input type="text" name="txt_osdate" size="16" onBlur="checkDate(this);checkmaxdate(this,currentDate)"
											value="<%=Helper.correctNull((String)hshValues.get("asondate"))%>">
</td>
<td width="79%"><a
													alt="Select date from calender" href="#"
													onClick="callCalender('txt_osdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
</tr>
</table></td>
											</tr>
										</table>
										</td>
									</tr>
							<tr>
								<td>


								<table width="100%" border="0" cellspacing="1" cellpadding="2" class="outertable">
									
									<tr>
										<td width="15%" >Facility Head</td>
										<td  width="58%"><%HashMap hp1 = new HashMap();%>
										<select name="facility_head"
											onChange="javascript:getFacility('facility')">
											<option selected="selected" value="-">----Select----</option>
											<%HashMap h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");

			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);

			%>
											<lapschoice:selecttag value='<%= hp1%>' />
										</select> <input type="hidden" name="hid_facility_head"></td>
										<td  width="6%">Facility</td>
										<td  width="21%"><select
											name="facility">
											<option selected="selected">----Select----</option>
										</select> <input type="hidden" name="hid_facility"></td>
									</tr>
									<tr>
										<td width="15%" >Existing Limit
										</td>
										<td  width="58%"><input
											type="text" name="txt_exist_limit" size="16"
											onBlur="javascript:roundtxt(this)"
											value="<%=Helper.correctNull((String)hshValues.get("facexist"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"></td>
										<td width="6%" >Proposed Limit</td>
										<td width="21%" ><input
											type="text" name="txt_proposed_limit" size="16"
											onBlur="javascript:roundtxt(this)"
											value="<%=Helper.correctNull((String)hshValues.get("facproposed"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"> <input type="hidden"
											name="hidproposed"
											value="<%=Helper.correctNull((String)hshValues.get("facproposed"))%>">
										</td>
									</tr>
									<tr>
										<td width="15%" >Interest/
										Discount/ Commission (%)</td>
										<td  width="58%"><%strInt = Helper.correctNull((String) hshValues.get("facinterest"));

			%> <input type="text" name="prd_intrate" size="10"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right" readonly="readonly"> <span
											onClick="opendisfixed('prd_intrate')" style="cursor:hand"><b>
										<img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></b></span> <input type="text"
											name="txt_intadjust" size="5"
											
											maxlength="5" onBlur="totalInt()" onKeyPress="allowNumber(this)"> <input
											type="text" name="txt_interest" size="10" value="<%=strInt%>">
										</td>
										<td width="6%"  nowrap="nowrap">Outstanding</td>
										<td width="21%" ><input
											type="text" name="txt_outstanding" size="16"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"></td>
									</tr>
									<tr>
										<td >Purpose</td>
										<td><input type="text" name="txt_purpose"
											size="40" maxlength="200"></td>
										<td>Tenor (in Months)</td>
										<td><input type="text" name="txt_tenor" size="5" maxlength="3"
											onkeypress="allowInteger(this)"
											onBlur="checkAdhocMonths(this)"></td>
									</tr>
									<tr>
										<td >CBS Account Number</td>
										<td><input type="text" name="txt_cbsaccno"
											size="18" maxlength="15"></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
										</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>

					<tr>
						<td valign="top">
						<table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
									<tr valign="middle">
										<td colspan="4">Sub - Limits&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <input
											type="checkbox" name="checkbox" value="checkbox"
											style="border-style:none" onClick="javascript:findtype()"></td>
									</tr>
									<tr>
										<td width="15%" >Sub-Limit Head</td>
										<td  width="35%"><select
											name="subfacility_head"
											onChange="javascript:getFacility('sublimit');selectSublimit()">
											<option selected="selected" value="-">----Select----</option>
											<%h = new HashMap();
			h.put("value", "parent");
			h.put("parent", "0");
			h.put("hidMethod", "getFacility");
			hp1 = new HashMap();
			hp1.put("BeanId", "facilitymaster");
			hp1.put("MethodName", "getData");
			hp1.put("BeanParam", h);%>
											<lapschoice:selecttag value='<%= hp1%>' />
										</select> <input type="Hidden" name="hid_subfacility_head"></td>
										<td width="12%" >Sub-Limit</td>
										<td width="30%" ><select
											name="subfacility">
											<option selected="selected">----Select----</option>
										</select> <input type="hidden" name="hid_subfacility"></td>
									</tr>
									<tr>
										<td width="15%" >Existing Limit
										</td>
										<td  width="35%"><input
											type="text" name="txt_subexist_limit" size="16"
											onBlur="javascript:roundtxt(this)"
											value="<%=Helper.correctNull((String)hshValues.get("subexist"))%>"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"></td>
										<td width="12%" >Proposed Limit
										</td>
										<td width="30%" ><input
											type="text" name="txt_subproposed_limit" size="16"
											onBlur="javascript:roundtxt(this)"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"
											value="<%=Helper.correctNull((String)hshValues.get("subproposed"))%>">
										</td>
									</tr>
									<tr>
										<td width="15%" >Interest/ Discount/ Commission (%)</td>
										<td  width="58%"><%strInt = Helper.correctNull((String) hshValues
					.get("subfacinterest"));

			%> <input type="text" name="prd_subintrate" size="10"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right" readonly="readonly"> <span
											onClick="opendisfixed('prd_subintrate')" style="cursor:hand"><b><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></b></span> <input type="text"
											name="txt_subintadjust" size="5" maxlength="5"
											onBlur="sub_totalInt()"> <input type="text"
											name="txt_subinterest" size="10" value="<%=strInt%>"></td>
										<td width="6%"  nowrap="nowrap">Outstanding</td>
										<td width="21%" ><input
											type="text" name="txt_sub_outstanding" size="16"
											onKeyPress="allowNumber(this)" maxlength="13"
											style="text-align:right"></td>
									</tr>
									<tr>
										<td >Purpose</td>
										<td><input type="text" name="txt_subpurpose"
											size="40" maxlength="200"></td>
										<td>Tenor (in Months)</td>
										<td><input type="text" name="txt_subtenor" size="5"
											maxlength="3" onKeyPress="allowInteger(this)"
											onBlur="checkAdhocMonths(this)"></td>
									</tr>
									<tr>
										<td >CBS Account Number</td>
										<td><input type="text"
											name="txt_subcbsaccno" size="18" maxlength="15"></td>
										<td>&nbsp;</td>
										<td>&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						<br>
						<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Delete Application_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
						<br>
						</td>
					</tr>

					<tr>
						<td>

						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr class="dataheader">
								<td width="6%">&nbsp;</td>
								<td width="15%" align="center">Facility Head</td>
								<td align="center"width="15%" >Facility</td>
								<td width="7%" align="center">Existing<br></td>
								<td width="8%" align="center">Proposed</td>
								<td width="7%" align="center">Difference<br></td>
								<td align="center" width="12%">Interest (%)</td>
								<td align="center" width="15%">CBS Account Number</td>
							</tr>
							<%//									
			if (vecData != null) {
				vecsize = vecData.size();
			}
			String strSno = "", strSubLimit = "";
			int j = 0, intsno = 0, intGroup = 0;
			int subGrpSize = 0;
			String strPreCategory = "", strCategory = "", strMonths = "";
			for (int i = 1; i <= vecsize; i++) {
				strHeaddesc = "";
				strCategory = "";
				strMonths = "";
				strFacdesc = "";
				strExist = "";
				strProposed = "";
				strDiff = "";
				strIntadjust="";
				strInterest = "";
				strMargin = "";
				strbplr = "";
				strOutstanding = "";
				String strPurpose = "";
				String strGroup = "", strCurCat = "";
				vecRow = (ArrayList) vecData.get(i - 1);
				if (vecRow != null) {

					strHeadId = Helper.correctNull((String) vecRow.get(0));
					vecHead.add(strHeadId);
					strFacId = Helper.correctNull((String) vecRow.get(2));
					vecFac.add(strHeadId);
					strHeaddesc = Helper.correctNull((String) vecRow.get(1));
					strFacdesc = Helper.correctNull((String) vecRow.get(3));
					strDate=Helper.correctNull((String) vecRow.get(5));
					strExist = Helper.correctNull((String) vecRow.get(6));
					strProposed = Helper.correctNull((String) vecRow.get(7));
					strDiff = Helper.correctNull((String) vecRow.get(8));
					strIntadjust = Helper.correctNull((String) vecRow.get(9));
					strSno = Helper.correctNull((String) vecRow.get(10));
					strGroup = Helper.correctNull((String) vecRow.get(11));
					strCategory = Helper.correctNull((String) vecRow.get(12));
					strMonths = Helper.correctNull((String) vecRow.get(13));
					strInterest = Helper.correctNull((String) vecRow.get(14));
					strMargin = Helper.correctNull((String) vecRow.get(15));
					strbplr = Helper.correctNull((String) vecRow.get(16));
					strOutstanding = Helper.correctNull((String) vecRow.get(17));
					strCbsaccountno = Helper.correctNull((String) vecRow.get(18));
					strPurpose = Helper.correctNull((String) vecRow.get(19));
					
					strCurCat = strCategory;
					intsno = Integer.parseInt(strSno);
					if (!strGroup.trim().equals("")) {
						intGroup = Integer.parseInt(strGroup);
					}
				}
				if ((!strPreCategory.trim().equals(strCurCat.trim()))
						&& (strCategory.trim().equals("R"))) {
					strPreCategory = strCurCat;%>
							<tr class="dataheader">
								<td colspan="8"><b>Main Limit Facilities :</b></td>
							</tr>
							<%} else if ((!strPreCategory.trim().equals(strCurCat.trim()))
						&& (strCategory.trim().equals("A"))) {
					strPreCategory = strCurCat;%>
							<tr class="dataheader">
								<td colspan="8"><b>Adhoc facilities :</b></td>
							</tr>
							<%}%>
							<%if (strGroup.trim().equals("0")) {
					j = 0;%>
							<tr class="datagrid">
								<td width="6%"><%if (strSno.trim().equals(strselsno.trim())) {
						%> <input type="radio" name="sno" style="border-style:none"
									onClick="selectValues(<%=intsno%>,<%=intGroup%>);selectvalues1()"
									checked="checked"> <%} else {%> <input type="radio" name="sno"
									style="border-style:none"
									onClick="selectValues(<%=intsno%>,<%=intGroup%>);selectvalues1()">
								<%}%></td>
								<td width="15%" align="center">
									<input type="hidden" name="txtheadid<%=intsno%>" value="<%=strHeadId%>"> <%=strHeaddesc%></td>
								<td align="center" width="15%">
									<input type="hidden" name="txtfacid<%=intsno%>" value="<%=strFacId%>"><%=strFacdesc%></td>
								<td width="7%" align="right">
								<div style="width:100"><%=strExist%></div>
								<input type="hidden" name="txtexist<%=intsno%><%=intGroup%>" value="<%=strExist%>"></td>
								<td width="8%" align="right">
								<div align="right" style="width:100"><%=strProposed%></div>
								<input type="hidden" name="txtproposed<%=intsno%><%=intGroup%>" value="<%=strProposed%>"></td>
								<td width="7%" align="right">
								<div style="width:100"><%=strDiff%></div>
								</td>
								<td width="12%">
								<div style="width:60"><%=strInterest%></div>
								<div align="center">
								<input type="hidden" name="txtintadjust<%=intsno%><%=intGroup%>" value="<%=strIntadjust%>">
								<input type="hidden" name="txtsno<%=intsno%>" value="<%=strSno%>"> 
								<input type="hidden" name="txtgroup<%=intsno%>" value="<%=strGroup%>"> 
								<input type="hidden" name="txtsublimit<%=intsno%>">
								<input type="hidden" name="txtcategory<%=intsno%>" value="<%=strCategory%>"> 
								<input type="hidden" name="txtmonths<%=intsno%><%=intGroup%>" value="<%=strMonths%>"> 
								<input type="hidden" name="txt_interest<%=intsno%><%=intGroup%>" value="<%=strInterest%>"> 
								<input type="hidden" name="txtmargin<%=intsno%><%=intGroup%>" value="<%=strMargin%>"> 
								<input type="hidden" name="txtbplr<%=intsno%><%=intGroup%>" value="<%=strbplr%>"> 
								<input type="hidden" name="txtoutstanding<%=intsno%><%=intGroup%>" value="<%=strOutstanding%>"> 
								<input type="hidden" name="txtcbsaccno<%=intsno%><%=intGroup%>" value="<%=strCbsaccountno%>"> 
								<input type="hidden" name="txtpurpose<%=intsno%><%=intGroup%>" value="<%=strPurpose%>" />
								</div></td>
								<td width="15%">&nbsp;<%=strCbsaccountno%></td>
							</tr>
							<%} else {

					if ((!strGroup.equals(strSubLimit))
							&& (!strGroup.trim().equals("0"))) {
						strSubLimit = strGroup;
						j++;

					%>
							<tr class="dataheader">
								<td width="6%">&nbsp;</td>
								<td colspan="7"><b>&gt;&gt;</b> <b>Sub-Limit</b></td>
							</tr>
							<%}%>
							<tr class="datagrid">
								<td width="6%"><%if (strSno.trim().equals(strselsno.trim())) {
						strsubselsno = strGroup;

						%> <input type="radio" name="sno" style="border-style:none"
									onClick="selectValues(<%=intsno%>,<%=intGroup%>);selectvalues1()"
									checked="checked"> <%} else {

						%> <input type="radio" name="sno" style="border-style:none"
									onClick="selectValues(<%=intsno%>,<%=intGroup%>)">
								<%}%></td>
								<td width="15%" align="center"><input
									type="hidden" name="txtsubheadid<%=intsno%>"
									value="<%=strHeadId%>"> <%=strHeaddesc%></td>
								<td align="center" width="15%"><input
									type="hidden" name="txtsubfacid<%=intsno%>"
									value="<%=strFacId%>"> <%=strFacdesc%></td>
								<td width="7%" align="right">
								<div style="width:100">(<%=strExist%>)</div>
								<input type="hidden" name="txtsubexist<%=intsno%><%=intGroup%>"
									value="<%=strExist%>"></td>
								<td width="8%" align="right">
								<div style="width:100"><input type="hidden"
									name="txtsubproposed<%=intsno%><%=intGroup%>"
									value="<%=strProposed%>"> (<%=strProposed%>)</div>
								</td>
								<td width="7%" align="right">
								<div style="width:100"><%=strDiff%></div>
								</td>
								<td width="12%">
								<div style="width:60"><%=strInterest%></div>
								<div align="center">
									<input type="hidden" name="txtsubintadjust<%=intsno%><%=intGroup%>" value="<%=strIntadjust%>"> 
									<input type="hidden" name="txtsno<%=intsno%>" value="<%=strSno%>"> 
									<input type="hidden" name="txtgroup<%=intsno%>" value="<%=strGroup%>">
									<input type="hidden" name="txtsublimit<%=intsno%>" value="Y">
									<input type="hidden" name="txtcategory<%=intsno%>" value="<%=strCategory%>"> 
									<input type="hidden" name="txtsubmonths<%=intsno%><%=intGroup%>" value="<%=strMonths%>"> 
									<input type="hidden" name="txt_subinterest<%=intsno%><%=intGroup%>" value="<%=strInterest%>"> 
									<input type="hidden" name="txtsubmargin<%=intsno%><%=intGroup%>" value="<%=strMargin%>"> 
									<input type="hidden" name="txtsubbplr<%=intsno%><%=intGroup%>" value="<%=strbplr%>">
									<input type="hidden" name="txtsuboutstanding<%=intsno%><%=intGroup%>" value="<%=strOutstanding%>"> 
									<input type="hidden" name="txtsubcbsaccno<%=intsno%><%=intGroup%>" value="<%=strCbsaccountno%>"> 
									<input type="hidden" name="txtsubpurpose<%=intsno%><%=intGroup%>" value="<%=strPurpose%>" />
									</div></td>

								<td width="15%">&nbsp;<%=strCbsaccountno%></td>
							</tr>
							<%}
			}%>
							<tr class="dataheader">
								<td colspan="3" align="center"><b>Total</b></td>
								<td width="7%" align="right">
								<div style="width:100"><%=strTotExist%></div>
								</td>
								<td width="8%" align="right">
								<div style="width:100"><%=strLC%></div>
								</td>
								<td width="7%" align="right">
								<div style="width:100"><%=strTotDiff%></div>
								</td>
								<td width="12%"></td>
								<td width="15%">&nbsp;</td>
								<input type="hidden" name="txt_line_credit" value="<%=strLC%>">
								<input type="hidden" name="hid_line_credit" value="<%=strLC%>">
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidDemoId" value="<%=strBorrowerId%>"> 
<input type="hidden" name="appval" value="<%=appval%>">
<input type="hidden" name="appflag" value="<%=appflag%>"> 
<input type="hidden" name="appMangflag" value="<%=appMangflag%>"> 
<input type="hidden" name="appGroupflag" value="<%=appGroupflag%>"> 
<input type="hidden" name="addflag">
<input type="hidden" name="selsno" value="<%=strselsno%>">
<input type="hidden" name="selsubsno" value="<%=strsubselsno%>">
<input type="hidden" name="factype" value="<%=strFacType%>"> 
<input type="hidden" name="faccategory" value="<%=strFacCategory%>"> 
<input type="hidden" name="prd_inttype">
<input type="hidden" name="prd_subinttype" value="">
<input type="hidden" name="otherGenTable"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
<input type="hidden" name="cattype" value="<%=strCategoryType%>">

	 <iframe height="0" width="0"
	id="ifrm1" frameborder="0" style="border:0"></iframe> <iframe height="0"
	width="0" id="ifrm2" frameborder="0" style="border:0"></iframe> <script>
	var msg ="<%=Helper.correctNull((String)hshValues.get("msg"))%>";
	if(msg!="")
	{
		alert(msg);
	}
</script></form>
</body>
</html>

