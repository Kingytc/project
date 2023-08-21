<%@include file="../share/directives.jsp"%>
<%
	String strApptype = ""; //= Helper.correctNull(request.getParameter("apptype"));
	if (strApptype.equalsIgnoreCase("")) {
		strApptype = Helper.correctNull((String) hshValues.get("apptype"));
	}
	ArrayList v = (ArrayList) hshValues.get("arryRow");
 	ArrayList arryCol = new ArrayList();
	String strStaffFlag = Helper.correctNull((String) request.getParameter("hidStaffFlag"));
	String appage = Helper.correctNull((String) request.getParameter("perapp_age"));
	String strApplId = Helper.correctNull((String) request.getParameter("comappid"));
	String strprdtype = Helper.correctNull((String) hshValues.get("appprdtype"));
	String strFromLink = Helper.correctNull((String) request.getParameter("strFrom"));
	String strAppno = Helper.correctNull((String) request.getParameter("appno"));
	String strAppid=Helper.correctNull((String) request.getParameter("varStrAppid"));
	if(strFromLink.equalsIgnoreCase(""))
	{
		strFromLink=Helper.correctNull((String) hshValues.get("strFromLink"));
	}
	//out.println(hshValues);
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();	
	String strModule="";
	ArrayList vecRow=new ArrayList();
	ArrayList vecCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();
	if(hshValues!=null)
	{
		vecRow=(ArrayList)hshValues.get("vecRow");
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	if(strFromLink.equalsIgnoreCase("GCF"))
	{		
		strSessionModuleType=Helper.correctNull((String) request.getParameter("strModuleType"));
		if(strSessionModuleType.equalsIgnoreCase(""))
		{
				
			strSessionModuleType=Helper.correctNull((String) hshValues.get("strHidModuleType"));
		}
		if(strSessionModuleType.equalsIgnoreCase("a"))
		{
			strSessionModuleType="AGR";
		}
		else if(strSessionModuleType.equalsIgnoreCase("c"))
		{
			strSessionModuleType="CORP";
		}
		else
		{
			strSessionModuleType="r";
		}
	}
	
	String strConstituiton="",strLending="";
	
	if(hshValues!=null)
	{
		strConstituiton=Helper.correctNull((String) hshValues.get("PERAPP_CONSTITUTIONNEW"));
		strLending=Helper.correctNull((String) hshValues.get("PERAPP_LENDING"));
	}
	if(strConstituiton.equals(""))
	{
		strConstituiton=Helper.correctNull((String) hshValues.get("strconstitution"));
	}
	     
	//out.println(hshValues);
%>

<html>
<head>
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 325;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL="<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var apptype="<%=strApptype%>";
var appprdtype="<%=strprdtype%>";
var varStrFormLink="<%=strFromLink%>";
var varFacSubCode="<%=Helper.correctNull((String)hshValues.get("strFacSubCOde1"))%>";
var varFacHead="<%=Helper.correctNull((String)hshValues.get("strFacParent1"))%>";
var varStrprdType="<%=Helper.correctNull((String)hshValues.get("strprdType"))%>";
var varStrSesModule="<%=strSessionModuleType%>";
var vargeclborrowerchk="<%=Helper.correctNull((String)hshValues.get("strgeclborrowchk"))%>";
var strConstituiton="<%=strConstituiton%>";

function getFacility(strtype)
{	
	var a1=varFacSubCode.split("-");
	var varFacID=a1[0];
   
	if(strtype=="facility")
	{
       	arr1=document.forms[0].facility_head.value.split("~");		
		var facilityhead = document.forms[0].elements["facility_head"].value;		
		arr = facilityhead.split("-");
		var parentparam =arr[0];
		if(parentparam)
		{	document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=facility&factid="+varFacID+"&varFromLink="+varStrFormLink+"&varModuleNew="+varStrSesModule;
		}
	}
	else if(strtype=="sublimit")
	{		
		    document.forms[0].subfacility.value="-";
	         document.forms[0].facilitydescsub.value="";
	         document.forms[0].txt_subproposed_limit.value="";
		var subfacilityhead = document.forms[0].elements["subfacility_head"].value;
		arr = subfacilityhead.split("-");
		var parentparam =arr[0];			
		if(parentparam)
		{
		document.all.ifrm1.src=appURL+"action/iframefacility.jsp?hidBeanId=facilitymaster&parent="+parentparam+"&value=subsel&hidMethod=getFacility&strtype=sublimit";
		}
		else
		{			
			document.forms[0].subfacility.length=1;
			document.forms[0].subfacility.selectedIndex=1;
		}
	} 
 }
function getFacilityDesc()
{
	var varvaluesIn;
	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
		strModule="a";
	else if(strSessionModuleType.equalsIgnoreCase("CORP"))
		strModule="c";%>
	var varModtype="<%=strModule%>";
	var varFacParent=document.forms[0].facility_head.value;
	var varFacSub=document.forms[0].facility.value;
	if(varStrFormLink!="GCF")
	{
		varvaluesIn=window.opener.document.forms[0].sel_proposalvaluesin.value;
	}
	else
	{
		varvaluesIn="";
	}
	var appid=document.forms[0].appid.value;
	document.forms[0].action=appURL+"action/facilitieslisthelp.jsp?hidBeanId=facilities&hidBeanGetMethod=getSetupFacility&strFacParent="+varFacParent+"&strFacSub="+varFacSub+"&subFacFlag=N&strValuesIn="+varvaluesIn+"&moduletype="+varModtype+"&strappid="+appid;
	document.forms[0].submit(); 
	
}
function callOnLoad()
{

	<%if(strSessionModuleType.equalsIgnoreCase("AGR") || strSessionModuleType.equalsIgnoreCase("CORP")){ %>
	if("<%=Helper.correctNull((String)hshValues.get("strFacParent1"))%>" !="")
	{
		document.forms[0].facility_head.value="<%=Helper.correctNull((String)hshValues.get("strFacParent1"))%>";

	}
	else
	{
		document.forms[0].facility_head.value="-";
	}

	if("<%=Helper.correctNull((String)hshValues.get("strFacSubCOde1"))%>" !="")
	{
		getFacility("facility");
	}
	else
	{
		document.forms[0].facility.value="-"; 
	}
	<%}%>

	if('<%=strSessionModuleType%>'=="r")
	{
		loadprdcategory();
		if(varStrprdType!="")
		{
			document.forms[0].prd_type.value=varStrprdType;
		}
		else
		{
			document.forms[0].prd_type.value="0";
		}
				
	}
	
	
	
}

function setValues(varFacId,varFacDesc,varMinAmnt,varmaxAmnt,varSchemeCode,varMintenor,varmaxTenor,varfacnature,varagrscheme,varfacilitytype,varcashmargin,varrepayment,varFacLoanType,varLoanagainstshare,varsharetype,varAccountOpenFlag,varbankscheme,varGECLType,varSvanidhiType,varSvandihiFlag,varCgtmseFlag)
{
	var aa=varFacHead.split("-");		 
	var ab=varFacSubCode.split("-");
	window.opener.document.forms[0].hidgecltype.value=varGECLType;	
	window.opener.document.forms[0].hidenwrbankschemecode.value=varbankscheme; 
	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
	{%>		
	if(varbankscheme=="074")
	{
		if(window.opener.document.forms[0].txt_appinwardno.value=="")
		{
			 alert("Please enter the Application No.");		   		
				return;	
		}	
		var inwarddate ="";
		if(window.opener.document.forms[0].hidinwarcreateddate.value=="")
			inwarddate=window.opener.document.forms[0].hidinwardcreatedate.value;
		else
			inwarddate=window.opener.document.forms[0].hidinwarcreateddate.value;
			
		var afterthreemonthdate="";
		if(window.opener.document.forms[0].hidafterthreemonthdate.value=="")
			{
			 inwarddt=changeDateformat(inwarddate);			
				var dt = new Date(inwarddt);				
				var no_of_months = 3;
				dt.setMonth(dt.getMonth() + no_of_months);
				var year=dt.getFullYear();
				var month=(dt.getMonth()+1).toString().padStart(2,'0');
				var day=dt.getDate().toString().padStart(2,'0');
				afterthreemonthdate=day+"/"+month+"/"+year;				
			}
		else
			{
				afterthreemonthdate=window.opener.document.forms[0].hidafterthreemonthdate.value;
			}
		
			var currdate=changeDateformat(window.opener.document.forms[0].hidsysdate.value);
			var inwarddt=changeDateformat(inwarddate);
			var enddate=changeDateformat(afterthreemonthdate);
			
			 if((Date.parse(enddate) >= Date.parse(currdate) && Date.parse(currdate)>= Date.parse(inwarddt))==false) 
		    {
				 alert("Proposal creation date should be between Inward Date "+inwarddate+" and 3 months from Inward Date "+afterthreemonthdate);		   		
					return;	 
		   	}   
		
		window.opener.document.all.eNWR_button.style.visibility="visible";
		window.opener.document.all.eNWR_button.style.position="relative";
	}
	else
	{
		window.opener.document.all.eNWR_button.style.visibility="hidden";
		window.opener.document.all.eNWR_button.style.position="absolute";	
	}
	<%}%>
	//alert(window.opener.document.forms[0].hidgecltype.value);
	if(aa[0]=="3" && ab[0]=="84" && window.opener.document.forms[0].txt_KCCFlag.value=="Y")
	{
		 alert("You cannot add KCC Crop Facility because KCC Other than Crop facility already exist");
		 return;
	}
	if(aa[0]=="3" && ab[0]=="94" && window.opener.document.forms[0].txt_KCCFlag.value=="N")
	{
		 alert("You cannot add KCC Other than Crop Facility because KCC Crop facility already exist");
		 return;
	}
	if((varbankscheme=="069" || varbankscheme=="69") && strConstituiton=="01")
	{
		alert("This Facility Eligible only for Non Individuals");
		return;
	}
	if(varLoanagainstshare=="Y" && window.opener.document.forms[0].hidconst.value!="01")
	{
		alert("Loan against Share facility Eligible only for individuals");
		return;
	}
	if((varbankscheme=="064") && window.opener.document.forms[0].hidconst.value!="01")
	{
		alert("Facility Eligible only for Individuals");
		return;
	}
	if(varsharetype=="P" && (window.opener.document.forms[0].hidAction.value=="insert"||window.opener.document.forms[0].hidAction.value=="") && window.opener.document.forms[0].hidPhysicalFlag.value=="Y")
	{
		alert("Physical form of loan against share limit exceeds for this borrower");
		return;
	}
	if(varsharetype=="D" && (window.opener.document.forms[0].hidAction.value=="insert"||window.opener.document.forms[0].hidAction.value=="")
			 && window.opener.document.forms[0].hidDematFlag.value=="Y")
	{
		alert("Demat form of loan against share limit exceeds for this borrower");
		return;
	}

	if(varbankscheme=="061" && window.opener.document.forms[0].hidMobileNo.value=="")
	{
		alert("Please update customer Mobile no in Customer Profile -> Communication Details tab");
		return;	
	}

	//Only one facility should be availed either GECL 1/3 or ParyaTan

	if((varbankscheme=="071")
			  && 
			(eval(window.opener.document.forms[0].intfaccountgeclgp2.value)>=1 
					|| eval(window.opener.document.forms[0].intcountgeclgp1.value)>=1 ||
					 eval(window.opener.document.forms[0].intcountgeclgp3.value)>=1 ||
					 eval(window.opener.document.forms[0].intcountgeclgp1ext.value)>=1 ||
					 eval(window.opener.document.forms[0].intcountgeclgp3ext.value)>=1 ||
					 eval(window.opener.document.forms[0].intfaccountgeclgp3.value)>=1 ||
					 eval(window.opener.document.forms[0].intfaccountgeclgpext1.value)>=1 ||
					eval(window.opener.document.forms[0].intfaccountgeclgpext3.value)>=1 
					
					   ))	
		{
		alert("Only one facility should be availed either GECL 1/3 or ParyaTan");
		return;
	}
	
	
	//alert("varGECLType===="+varGECLType);
	if(  (varGECLType=="GECL -3 extension" ||  varGECLType=="GECL -3" || varGECLType=="GECL -1 extension" ||  varGECLType=="GECL -1" )
			  && 
			( eval(window.opener.document.forms[0].intcountparayatan.value)>=1 ||
					 eval(window.opener.document.forms[0].intfaccountparayatan.value)>=1 
					 
					
					   ))	
		{
		alert("Only one facility should be availed either GECL 1/3 or ParyaTan");
		return;
	    }
//alert("varGECLType"+varGECLType);
	//alert("window.opener.document.forms[0].perapp_facility_othbankP.value"+window.opener.document.forms[0].perapp_facility_othbankP.value);
	//alert("window.opener.document.forms[0].perapp_facility_othbankG.value"+window.opener.document.forms[0].perapp_facility_othbankG.value);
	if(window.opener.document.forms[0].perapp_facility_othbankP.value =="P" && (varGECLType=="GECL -3 extension" ||  varGECLType=="GECL -3" || varGECLType=="GECL -1 extension" ||  varGECLType=="GECL -1" ))
	{
		alert("Only one facility should be availed either GECL 1/3 or ParyaTan");
		return;
	}


	if(window.opener.document.forms[0].perapp_facility_othbankG.value =="G" && (varbankscheme=="071"))
	{
		alert("Only one facility should be availed either GECL 1/3 or ParyaTan");
		return;
	}
	
	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL3")
	{
		alert("If one facility is under KBL GECL-3 then all other facilities of the proposal should also be in KBL GECL-3 scheme only ");
		return;	
	}

	else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL3" )
	{
		alert("If one facility is under KBL GECL-3 then all other facilities of the proposal should also be in KBL GECL-3 scheme only ");
		return;	
	}
 	if((varGECLType=="GECL1"||varGECLType=="GECL2" || varGECLType=="GECL -1 extension") &&  varbankscheme=="061"  &&  eval(window.opener.document.forms[0].hidfacgecl3count.value)>=1){
		alert("If one facility is under KBL GECL-3 then all other facilities of the proposal should also be in KBL GECL-3 scheme only ");
		return;
	}
	if( window.opener.document.forms[0].hidGECLType.value=="GECL3"&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidfacgecl3count.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 facility");
		return;	
	}
	if( window.opener.document.forms[0].hidGECLType.value=="GECL3" && varbankscheme=="061" &&eval(window.opener.document.forms[0].hidgecl3count.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 facility");
		return;	
	}
 	if( (varGECLType=="GECL3")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidgecl3count.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 facility");
		return;	
	}
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL1")
	{
		alert("If one facility is under KBL GECL-1 then all other facilities of the proposal should also be in KBL GECL-1 scheme only ");

			return;	
	}
	// varGECLType=="GECL -1 extension"
	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension")
	{
		alert("If one facility is under KBL GECL-1 Extension then all other facilities of the proposal should also be in KBL GECL-1 Extension scheme only ");
		return;	
	}
	/*else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL1" )
	{
		alert("If one facility is under KBL GECL-1 then all other facilities of the proposal should also be in KBL GECL-1 scheme only ");
		return;	
	}*/
//alert("varbankscheme"+varbankscheme);
	if( (varGECLType=="GECL2")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidgecl1count.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2");
		return;	
	}

	
	if( (varGECLType=="GECL2")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1 Extension and GECL -2");
		return;	
	}


	if( (varGECLType=="GECL2")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1extension and GECL -2");
		return;	
	}
	
	if( (varGECLType=="GECL -1 extension") && varbankscheme=="061" && eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}
	
	
	if( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" &&  varbankscheme=="061" &&(eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1 && (eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0||eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1extension facility");
		return;	
	}

	
	
	if( (varGECLType=="GECL1") && varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl1count.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}
	//alert("window.opener.document.forms[0].intfaccountgeclext1.value"+window.opener.document.forms[0].intfaccountgeclext1.value);

	if( (varGECLType=="GECL -1 extension") && varbankscheme=="061" && eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}

	
 	if( window.opener.document.forms[0].hidGECLType.value=="GECL1" &&  varbankscheme=="061" &&(eval(window.opener.document.forms[0].hidgecl1count.value)>=1 && (eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0||eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}

 	if( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" &&varbankscheme=="061" &&(eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && (eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0||eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}
	
 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL1"  &&  varGECLType=="GECL2")&&varbankscheme=="061")
	{
 		//alert("1");
		alert("One borrower cannot have facilities both in GECL -1 and GECL -2");
		return;	
	}

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension "&&varGECLType=="GECL2")&&varbankscheme=="061")
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2");
		return;	
	}
	
 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL2" && varGECLType=="GECL1")&& varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL2" && varGECLType=="GECL -1 extension") && varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}

	
	if(varGECLType=="GECL1" &&varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl2count.value)>=1 ){
		//alert("2");
		alert("One borrower cannot have facilities both in GECL -1 and GECL -2");
		return;
	}


	if(varGECLType=="GECL -1 extension"&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl2count.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2");
		return;
	}

	
	if( varGECLType=="GECL1"&&varbankscheme=="061" &&(eval(window.opener.document.forms[0].hidfacgecl2count.value)>=1 && eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0)&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}


	if( varGECLType=="GECL -1 extension"  &&varbankscheme=="061" &&(eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0)&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}

	
	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL2")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}
	else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL2" )
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL4")
	{
		alert("If one facility is under KBL GECL-4 then all other facilities of the proposal should also be in KBL GECL-4 scheme only ");
		return;	
	}
	else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL4" )
	{
		alert("If one facility is under KBL GECL-4 then all other facilities of the proposal should also be in KBL GECL-4 scheme only ");
		return;	
	}
	if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidDPNFac.value!="Y" && aa[0]=="5" && ab[0]=="98")||(window.opener.document.forms[0].hidDPNFac.value=="Y" && !(aa[0]=="5" && ab[0]=="98"))))
	{
		alert("If one facility is under Interest Deferment DPN 2020 then all other facilities of the proposal should also be in Interest Deferment DPN 2020 only ");
		return;	
	}
	else if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidDPNFac.value!="Y" && aa[0]=="5" && ab[0]=="98")||(window.opener.document.forms[0].hidDPNFac.value=="Y" && !(aa[0]=="5" && ab[0]=="98"))))
	{
		alert("If one facility is under Interest Deferment DPN 2020 then all other facilities of the proposal should also be in Interest Deferment DPN 2020 only ");
		return;	
	}
	if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidCGSSD.value!="Y" && varbankscheme=="065")||(window.opener.document.forms[0].hidCGSSD.value=="Y" && !(varbankscheme=="065"))))
	{
		alert("If one facility is under KBL CGSSD then all other facilities of the proposal should also be in KBL CGSSD only ");
		return;	
	}
	else if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidCGSSD.value!="Y" && varbankscheme=="065")||(window.opener.document.forms[0].hidCGSSD.value=="Y" && !(varbankscheme=="065"))))
	{
		alert("If one facility is under KBL CGSSD then all other facilities of the proposal should also be in KBL CGSSD only ");
		return;	
	}
	/*if(window.opener.document.forms[0].hidAction.value =="update" && (vargeclborrowerchk=="Y")) 
	{
		alert("The borrower already availed under GECL scheme. Multiple Gecl facilities are not allowed.");
		return;	
	}*/

	if( (varGECLType=="GECL1")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidfacgecl2count.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S" )
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}

	if( (varGECLType=="GECL -1 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S" )
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}
	

	/*if( (varGECLType=="GECL1")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidfacgecl2count.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S" )
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}*/








	///////gecl 2 ,3 ext
	
	
	
	

	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||
					(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& 
					window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension")
	{
		//alert("1");
		alert("If one facility is under KBL GECL -3 extension then all other facilities of the proposal should also be in KBL GECL -3 extension scheme only ");
		return;	
	}


	
	else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" 
				&& !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension" )
	{
		//alert("2");
		alert("If one facility is under KBL GECL -3 extension then all other facilities of the proposal should also be in KBL GECL -3 extension scheme only ");
		return;	
	}
 	if((varGECLType=="GECL1"||varGECLType=="GECL2" || varGECLType=="GECL -1 extension" || varGECLType=="GECL -2 extension") &&  varbankscheme=="061"  && 
 		 	 eval(window.opener.document.forms[0].hidfacgecl3countext.value)>=1)

	 	 {
 		//alert("3");
		alert("If one facility is under KBL GECL -3 extension then all other facilities of the proposal should also be in KBL GECL -3 extension scheme only ");
		return;
	}
	if( window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension"&&varbankscheme=="061" 
		&&eval(window.opener.document.forms[0].hidfacgecl3countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 extension facility");
		return;	
	}
	if( window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension" && varbankscheme=="061" 
		&&eval(window.opener.document.forms[0].hidgecl3countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 extension facility");
		return;	
	}
 	if( (varGECLType=="GECL -3 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidgecl3countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 extension facility");
		return;	
	}
	
	if( (varGECLType=="GECL -3 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].hidfacgecl3countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -3 extension facility");
		return;	
	}
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||
					(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& 
					(window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" || varGECLType=="GECL -1 extension"))
	{
		//alert("4");
		alert("If one facility is under KBL GECL -3 extension then all other facilities of the proposal should also be in KBL GECL -3 extension scheme only ");

			return;	
	}
	
	if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||
					(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& 
					(window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" || varGECLType=="GECL -1 extension"))
	{
		//alert("5");
		alert("If one facility is under KBL GECL -3 extension then all other facilities of the proposal should also be in KBL GECL -3 extension scheme only ");

			return;	
	}
	
	if( (varGECLType=="GECL -2 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2 extension");
		return;	
	}

	
	if( ( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension"  || varGECLType=="GECL -2 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1 Extension and GECL -2 extension");
		return;	
	}


	if( ( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension"  || varGECLType=="GECL -2 extension")&&varbankscheme=="061" &&eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1)
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2 extension");
		return;	
	}
	
	if( (varGECLType=="GECL -1 extension") && varbankscheme=="061" && eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}
	
	
	if( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" &&  varbankscheme=="061" 
		&&(eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1 && 
				(eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0||
						eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1extension facility");
		return;	
	}

	
	
	if( (varGECLType=="GECL1") && varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl1count.value)>=1 && window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}
	//alert("window.opener.document.forms[0].intfaccountgeclext1.value"+window.opener.document.forms[0].intfaccountgeclext1.value);

	if( (varGECLType=="GECL -1 extension") && varbankscheme=="061" && eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 
			&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}

	
 	if( window.opener.document.forms[0].hidGECLType.value=="GECL1" &&  varbankscheme=="061" 
 	 	&&(eval(window.opener.document.forms[0].hidgecl1count.value)>=1 && 
 	 	 	 	(eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0
 	 	 	 	 	 	||eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}

 	if( window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" &&varbankscheme=="061" 
 	 	&&(eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && 
 	 	 	 	(eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0||
 	 	 	 	 	 	eval(window.opener.document.forms[0].hidfacgecl3count.value)!=1))&& 
 	 	 	 	 	 	window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}
	
 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL1"  &&  varGECLType=="GECL2")&&varbankscheme=="061")
	{
 		//alert("3");
		alert("One borrower cannot have facilities both in GECL -1 and GECL -2");
		return;	
	}

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension "&&varGECLType=="GECL2")&&varbankscheme=="061")
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2");
		return;	
	}
 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension "&&varGECLType=="GECL -2 extension")&&varbankscheme=="061")
	{
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2 extension");
		return;	
	}
	

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL1"&&varGECLType=="GECL -2 extension")&&varbankscheme=="061")
	{
		alert("One borrower cannot have facilities both in GECL -1  and GECL -2 extension");
		return;	
	}
	
 	
 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL2" && varGECLType=="GECL1")&& varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" && varGECLType=="GECL1")&& varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" && varGECLType=="GECL -1 extension")&& varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}
	
	

 	if( (window.opener.document.forms[0].hidGECLType.value=="GECL2" && varGECLType=="GECL -1 extension") && varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL-2 then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}

	
	if((window.opener.document.forms[0].hidGECLType.value=="GECL1" || varGECLType=="GECL1")&&varbankscheme=="061"
		 && eval(window.opener.document.forms[0].hidgecl2count.value)>=1 ){
		// alert("4");
		alert("One borrower cannot have facilities both in GECL -1 and GECL -2");
		return;
	}

	if(( window.opener.document.forms[0].hidGECLType.value=="GECL1" || varGECLType=="GECL1")&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl2countext.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -1 and GECL -2 extensions");
		return;
	}

	if((window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" || varGECLType=="GECL -1 extension")&&varbankscheme=="061" &&
			 eval(window.opener.document.forms[0].hidgecl2countext.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -1  extensions and GECL -2 extensions");
		return;
	}

	if((window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" || varGECLType=="GECL -2 extension")&&varbankscheme=="061"
		 && eval(window.opener.document.forms[0].intcountgecl1ext.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -1  extensions and GECL -2 extensions");
		return;
	}
	
	

	if((window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" || varGECLType=="GECL -1 extension")&&varbankscheme=="061" 
		&& eval(window.opener.document.forms[0].hidgecl2count.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -1 extension and GECL -2");
		return;
	}

	if((window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" || varGECLType=="GECL -2 extension")&&varbankscheme=="061" && 
			eval(window.opener.document.forms[0].hidgecl1count.value)>=1 ){
		alert("One borrower cannot have facilities both in GECL -2 extension and GECL -1");
		return;
	}
	
	
	if( (window.opener.document.forms[0].hidGECLType.value=="GECL1" || varGECLType=="GECL1")&&varbankscheme=="061"
		 &&(eval(window.opener.document.forms[0].hidfacgecl2count.value)>=1 && eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0)&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 facility");
		return;	
	}


	if( (window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" ||varGECLType=="GECL -1 extension")  &&varbankscheme=="061" 
		&&(eval(window.opener.document.forms[0].intfaccountgeclext1.value)>=1 && 
				eval(window.opener.document.forms[0].hidfacgecl3count.value)!=0)&& window.opener.document.forms[0].hidstrAppType.value!="S")
	{
		alert("One Borrower cannot have more than one GECL -1 extension facility");
		return;	
	}

	
	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||
					(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& 
					(window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" ||varGECLType=="GECL -2 extension"))
	{
		alert("If one facility is under KBL GECL -2 extension then all other facilities of the proposal should also be in KBL GECL-2 scheme only ");
		return;	
	}
	else if( eval(window.opener.document.forms[0].hidfaccount.value)>1 && 
			((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" 
				&& !(varbankscheme=="061")))&& (window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension"  || varGECLType=="GECL -2 extension"))
	{
		alert("If one facility is under KBL GECL -2 extension then all other facilities of the proposal should also be in KBL GECL -2 extension scheme only ");
		return;	
	}

	if( (varGECLType=="GECL -3 extension") &&varbankscheme=="061" 
		&& eval(window.opener.document.forms[0].hidfacgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have facilities both in GECL -2 extension and  GECL -3 extension");
		return;	
	}

	
	if( window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension"&&varbankscheme=="061" 
		&& eval(window.opener.document.forms[0].hidfacgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -2 extension facility");
		return;	
	} 

	if( window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension" && varbankscheme=="061" 
		&& eval(window.opener.document.forms[0].hidgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -2 extension facility");
		return;	
	}
 	if( (varGECLType=="GECL -2 extension")&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -2 extension facility");
		return;	
	}
	
	if( (varGECLType=="GECL -2 extension")&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidfacgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -2 extension facility");
		return;	
	}

	if( (varGECLType=="GECL -2 extension")&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidfacgecl2countext.value)>=1)
	{
		alert("One Borrower cannot have more than one GECL -2 extension facility");
		return;	
	}


	if( (varGECLType=="GECL -3 extension")&&varbankscheme=="061" && eval(window.opener.document.forms[0].hidfacgecl2countext.value)>=1)
	{
		alert("If one facility is under KBL GECL -2 extension then all other facilities of the proposal should also be in KBL GECL -2 extension scheme only ");
		return;	
	}


	//Only one facility should be availed either GECL 1/3 or ParyaTan

	

	
	if(window.opener.document.forms[0].hidAction.value =="update" && (window.opener.document.forms[0].hidfaccount.value)>=1 && (window.opener.document.forms[0].hidGECLAvail.value!="Y") &&
			(varGECLType=="GECL -1 extension" || varGECLType=="GECL -2 extension" || varGECLType=="GECL -3 extension" ||
					window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" ||
					window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension"  ||
						window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension"))
	{ 

		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only");
		return;		
	}


	/*if(window.opener.document.forms[0].hidAction.value =="update" && (window.opener.document.forms[0].hidnongeclfacchk.value=="Y")
		 && varbankscheme=="061")
	{
		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only ");
		return;	
	}*/


	

	if(window.opener.document.forms[0].hidAction.value =="update" && (window.opener.document.forms[0].hidnongeclfacchk.value=="Y") 
		 && varbankscheme=="061" && (window.opener.document.forms[0].hidfaccount.value)>=1 &&
			(varGECLType=="GECL -1 extension" || varGECLType=="GECL -2 extension" || varGECLType=="GECL -3 extension" ||
					window.opener.document.forms[0].hidGECLType.value=="GECL -1 extension" ||
					window.opener.document.forms[0].hidGECLType.value=="GECL -2 extension"  ||
						window.opener.document.forms[0].hidGECLType.value=="GECL -3 extension"))
	{
		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only ");
		return;	
	}
	
	if(window.opener.document.forms[0].hidAction.value =="insert" && eval(window.opener.document.forms[0].hidfaccount.value)>=1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL4")
	{

			alert("If one facility is under KBL GECL-4 then all other facilities of the proposal should also be in KBL GECL-4 scheme only ");
		return;	
	}
	else if(window.opener.document.forms[0].hidAction.value =="update" && eval(window.opener.document.forms[0].hidfaccount.value)>1 && ((window.opener.document.forms[0].hidGECLAvail.value!="Y" && varbankscheme=="061")||(window.opener.document.forms[0].hidGECLAvail.value=="Y" && !(varbankscheme=="061")))&& window.opener.document.forms[0].hidGECLType.value=="GECL4" )
	{
		alert("If one facility is under KBL GECL-4 then all other facilities of the proposal should also be in KBL GECL-4 scheme only ");
		return;	
	}


	

	

	///end
	if(window.opener.document.forms[0].hidAction.value =="insert" && (window.opener.document.forms[0].hidnongeclfacchk.value=="Y"
		 && varbankscheme=="061"))
	{
		alert("If one facility is under KBL GECL type then all other facilities of the proposal should also be in KBL GECL type scheme only ");
		return;	
	}
	if(varSvanidhiType =="" && varbankscheme=="064" ){
		alert("Please add Svanidhi version in Product -Other details tab ");
		return;
	}	
	if((varSvanidhiType =="1") && (varSvandihiFlag=="N")){
		alert("One borrower should not  have more than one PM Svanidhi 1.0 ");
		return;
	}
	if((varSvanidhiType =="2") && (varSvandihiFlag=="N")){
		alert("Once Borrower sanctioned and close the loan under PM Svanidhi 1.0 , can only add PM Svanidhi 2.0 and cannot have more than one PM Svanidhi 2.0 ");
		return;
	}
	if((varSvanidhiType =="3") && (varSvandihiFlag=="N")){
		alert("Once Borrower sanctioned and close the loan under PM Svanidhi 1.0 & PM Svanidhi 2.0, can only add PM Svanidhi 3.0 and cannot have more than one PM Svanidhi 3.0");
		return;
	}
	
	if(varStrFormLink!="GCF")
	{
		var varhidcashmargin=window.opener.document.forms[0].hidCashMarginPrd.value;
		var varAppno=window.opener.document.forms[0].appno.value;
		var varCusConst=document.forms[0].hidconstituiton.value;
		var varlending=document.forms[0].hidlending.value;
		var varfaccount=window.opener.document.forms[0].hidfaccount.value;
		var varfacCode=window.opener.document.forms[0].facility_OldCode.value;
		if(parseFloat(varfaccount)>1 && varAppno!="new" && varhidcashmargin!=varcashmargin)
		{
			alert("Facilities with 100 % cash margin and other facilities cannot be processed together");
			varStrFormLink="";
		 }else if(parseFloat(varfaccount)==1 && varfacCode=="" && varhidcashmargin!=varcashmargin)
		 {
			 alert("Facilities with 100 % cash margin and other facilities cannot be processed together");
			 varStrFormLink="";
		 }
	 }
	 if(varStrFormLink=="CFM")
	 {
	
		  <%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
		 if(varagrscheme=="aS" && (varCusConst>=183 || varCusConst<=191) && varlending!="IL")
		 {	
               alert("Customer is not belongs to SHG");
               window.close();					 
			
		 }
		 else
		 {
			 if(varCgtmseFlag=="Y")
				{
					window.opener.document.forms[0].cgtmse_app.value="Y";
					window.opener.document.forms[0].cgtmse_app.disabled=true;
				}
			 window.opener.document.forms[0].txt_proposed_limit.value="";
			 window.opener.document.forms[0].sel_inttype.value="0";
			 window.opener.document.forms[0].txt_facmonths.value="";
			 window.opener.document.forms[0].txt_installments.value="";
			 window.opener.document.forms[0].prd_intrate.value="";
			 //window.opener.document.forms[0].facilitydescnew.value=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
			 window.opener.document.forms[0].facilitydescnew.value=varFacDesc;
			 var a1=varFacHead.split("-");		 
			 var a2=varFacSubCode.split("-");	 
			 window.opener.document.forms[0].facility_head_id_code.value=a1[0];

			 if(a1[0]=="5" && a2[0]=="97")
			 {
				 window.opener.document.all.idmargin.style.display="table-row";
				 window.opener.document.all.idmargin1.style.display="table-row";
			 }
			 else
			 {
				 window.opener.document.all.idmargin.style.display="none";
				 window.opener.document.all.idmargin1.style.display="none"; 
				 window.opener.document.forms[0].sel_margin.value="";
				 window.opener.document.forms[0].sel_relaxedmargin.value="";
				 window.opener.document.forms[0].sel_definedmargin.value="";
			 }
			 
			 window.opener.document.forms[0].facility_id_code.value=a2[0];
			 window.opener.document.forms[0].facilitydesc.value=varFacId+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varMintenor+"-"+varmaxTenor;
			 //window.opener.document.forms[0].facilitydescnew.title=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
			 window.opener.document.forms[0].facilitydescnew.title=varFacDesc;
			 window.opener.document.forms[0].sel_schemetype.value=varagrscheme;
			 window.opener.document.forms[0].facility_nature.value=varfacilitytype;
			 window.opener.document.forms[0].hidComFactype.value=varFacLoanType;
			 window.opener.document.forms[0].txtsharetype.value=varsharetype;
			 window.opener.document.forms[0].hidfacilityCode.value=varFacId;
			 if(window.opener.document.forms[0].sel_fac_desc.value=="2")
			 {
				 window.opener.document.forms[0].sel_fac_desc.value="2";
			 }else{
			 	window.opener.document.forms[0].sel_fac_desc.value="1";
			 }
			 /*if(varfacilitytype=="2")
			 {
				 window.opener.document.all.Existing_limit.style.visibility="hidden";
				 window.opener.document.all.Existing_limit1.style.visibility="hidden";
				// window.opener.document.all.Existing_limit.style.position="relative";
			 }else
			 {
				 window.opener.document.all.Existing_limit.style.visibility="visible";
				 window.opener.document.all.Existing_limit1.style.visibility="visible";
			 }*/
			 window.opener.hideCBSaccountno();
			 window.opener.callduedate(varFacLoanType);
			 window.opener.document.forms[0].seladhocof.value="";
			 window.opener.document.forms[0].sel_intsutype.value="0";
			 window.opener.document.forms[0].sel_propbanktype.value="";
			 window.opener.document.forms[0].sel_repaytype.value="0";
			 window.opener.document.forms[0].txt_LeadBank.value="";
			 window.opener.document.forms[0].sel_peridicityfac.value="s";
			 window.opener.document.forms[0].sel_displaydesc.value="0";
			 window.opener.document.forms[0].txt_margin.value="";
			 window.opener.document.forms[0].txt_purpose.value="";
			 window.opener.document.forms[0].txt_desc.value="";
			 window.opener.document.forms[0].txt_duedate.value="";
			 window.opener.getFacDescription('',varFacId);

		 }
		
		 <%} else{%>
		 window.opener.document.forms[0].txt_proposed_limit.value="";
		 window.opener.document.forms[0].sel_inttype.value="0";
		 window.opener.document.forms[0].txt_facmonths.value="";
		 window.opener.document.forms[0].txt_installments.value="";
		 window.opener.document.forms[0].prd_intrate.value="";
		 //window.opener.document.forms[0].facilitydescnew.value=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
		 window.opener.document.forms[0].facilitydescnew.value=varFacDesc;
		 var a1=varFacHead.split("-");		 
		 window.opener.document.forms[0].facility_head_id_code.value=a1[0];
		 var a2=varFacSubCode.split("-");
		 window.opener.document.forms[0].facility_id_code.value=a2[0];
		 if(a1[0]=="5" && a2[0]=="97")
		 {
			 window.opener.document.all.idmargin.style.display="table-row";
			 window.opener.document.all.idmargin1.style.display="table-row";
		 }
		 else
		 {
			 window.opener.document.all.idmargin.style.display="none";
			 window.opener.document.all.idmargin1.style.display="none";
			 window.opener.document.forms[0].sel_margin.value="";
			 window.opener.document.forms[0].sel_relaxedmargin.value="";
			 window.opener.document.forms[0].sel_definedmargin.value=""; 
		 }
		 
		 window.opener.document.forms[0].facilitydesc.value=varFacId+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varMintenor+"-"+varmaxTenor;
		//window.opener.document.forms[0].facilitydescnew.title=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
		 window.opener.document.forms[0].facilitydescnew.title=varFacDesc;
		 window.opener.document.forms[0].sel_schemetype.value=varagrscheme;
		 window.opener.document.forms[0].facility_nature.value=varfacilitytype;
		 window.opener.document.forms[0].hidComFactype.value=varFacLoanType;
		 window.opener.document.forms[0].txtsharetype.value=varsharetype;
		 window.opener.document.forms[0].hidfacilityCode.value=varFacId;
		 if(window.opener.document.forms[0].sel_fac_desc.value=="2")
		 {
			 window.opener.document.forms[0].sel_fac_desc.value="2";
		 }else{
		 	window.opener.document.forms[0].sel_fac_desc.value="1";
		 }
		/* if(varfacilitytype=="2")
		 {
			 window.opener.document.all.Existing_limit.style.visibility="hidden";
			 window.opener.document.all.Existing_limit1.style.visibility="hidden";
		}else
		 {
			 window.opener.document.all.Existing_limit.style.visibility="visible";
			 window.opener.document.all.Existing_limit1.style.visibility="visible";
		 }*/
		 window.opener.funenablefitl();
		 window.opener.hideCBSaccountno();
		 window.opener.callduedate(varFacLoanType);
		 window.opener.document.forms[0].seladhocof.value="";
		 window.opener.document.forms[0].sel_intsutype.value="0";
		 window.opener.document.forms[0].sel_propbanktype.value="";
		 window.opener.document.forms[0].sel_repaytype.value="0";
		 window.opener.document.forms[0].txt_LeadBank.value="";
		 window.opener.document.forms[0].sel_peridicityfac.value="s";
		 window.opener.document.forms[0].sel_displaydesc.value="0";
		 window.opener.document.forms[0].txt_margin.value="";
		 window.opener.document.forms[0].txt_purpose.value="";
		 window.opener.document.forms[0].txt_desc.value="";
		 window.opener.document.forms[0].txt_duedate.value="";
		 window.opener.getFacDescription('',varFacId);
		 <%} %>
		 var varArr1= varrepayment.split("@");
			for(var i=0;i<varArr1.length-1;i++)
			{
				window.opener.document.forms[0].sel_repaytype.length=varArr1.length;

				if(i==0)
				{
					window.opener.document.forms[0].sel_repaytype.options[0].text="<--select-->";	
					window.opener.document.forms[0].sel_repaytype.options[0].value="0";
				}
				
				var selValue=varArr1[i];
			
				if("E"==selValue)	
				{	
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="EMI";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}			
				else if("NE"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="Non-EMI";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("OD"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="On Demand";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("LC"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="As Per LC Terms";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}			
				else if("CO"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="As Per Contract Terms";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("BG"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="As Per BG Rules";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("DD"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="On Due Date";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("PC"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="From the proceeds of PSC \ by realization of bill";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("PS"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="By Realization of Export Bills";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("PR"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="By Realization of Respective Bills";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				else if("TG"==selValue)
				{			
					window.opener.document.forms[0].sel_repaytype.options[i+1].text="As per TCBG Rules";	
					window.opener.document.forms[0].sel_repaytype.options[i+1].value=selValue;
				}
				
			}
			window.opener.document.forms[0].seladhocof.length=1;
			window.opener.document.forms[0].seladhocof.options[0].text="<--select-->";
			window.opener.document.forms[0].seladhocof.options[0].vale="";
			window.opener.document.all.idadhoc.style.display="none";
			window.opener.document.all.idadhoc1.style.display="none";
			window.opener.document.forms[0].seladhocof.selectIndex="0";
			window.opener.document.forms[0].txt_accountopenflag.value=varAccountOpenFlag;
			
			if(varAccountOpenFlag=="Y" || window.opener.document.forms[0].hidCashMarginPrd.value=="Y")
			{
				window.opener.document.forms[0].seladhoclimit.value="O";
				window.opener.document.forms[0].seladhoclimit.disabled=true;
			}
			else
			{
				window.opener.document.forms[0].seladhoclimit.value="";
				window.opener.document.forms[0].seladhoclimit.disabled=false;
			}

			window.opener.document.forms[0].hidfacreattach.value="N";
	 }
	 else if(varStrFormLink=="CFS")
	 {
		 <%if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		 if(varagrscheme=="aS" && varCusConst!="14" && varlending!="IL")
		 {			
            
               alert("Customer is not belongs to SHG");
               window.close();
           			 
			
		 }
		 else
		 {
			 if(varCgtmseFlag=="Y")
				{
					window.opener.document.forms[0].cgtmse_appsub.value="Y";
					window.opener.document.forms[0].cgtmse_appsub.disabled=true;
				}
			 //window.opener.document.forms[0].facilitydescsubnew.value=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
			 window.opener.document.forms[0].txt_subproposed_limit.value="";
			 window.opener.document.forms[0].sel_sub_inttype.value="0";
			 window.opener.document.forms[0].txt_subfacmonths.value="";
			 window.opener.document.forms[0].txt_installments_sub.value="";
			 window.opener.document.forms[0].prd_subintrate.value="";
			 window.opener.document.forms[0].facilitydescsubnew.value=varFacDesc;
			 var a1=varFacHead.split("-");		 
			 window.opener.document.forms[0].facilitysub_head_id_code.value=a1[0];
			 var a2=varFacSubCode.split("-");
			 window.opener.document.forms[0].facilitysub_id_code.value=a2[0];

			 if(a1[0]=="5" && a2[0]=="97")
			 {
				 window.opener.document.all.idsubmargin.style.display="table-row";
				 window.opener.document.all.idsubmargin1.style.display="table-row";
			 }
			 else
			 {
				 window.opener.document.all.idsubmargin.style.display="none";
				 window.opener.document.all.idsubmargin1.style.display="none"; 
				 window.opener.document.forms[0].sel_marginsub.value="";
				 window.opener.document.forms[0].sel_relaxedmarginsub.value="";
				 window.opener.document.forms[0].sel_definedmarginsub.value="";
			 }
			 
			 window.opener.document.forms[0].facilitydescsub.value=varFacId+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varMintenor+"-"+varmaxTenor;
			 window.opener.document.forms[0].sel_subschemetype.value=varagrscheme;
			 window.opener.document.forms[0].facilitysub_nature.value=varfacilitytype;
			 if(window.opener.document.forms[0].sel_subfac_desc.value=="2")
			 {
				 window.opener.document.forms[0].sel_subfac_desc.value="2";
			 }else{
				 window.opener.document.forms[0].sel_subfac_desc.value="1";
			 }
			 if(varfacilitytype=="2")
			 {
				 window.opener.document.all.sublimitexisting.style.visibility="hidden";
				 window.opener.document.all.sublimitexisting1.style.visibility="hidden";
			}else
			 {
				 window.opener.document.all.sublimitexisting.style.visibility="visible";
				 window.opener.document.all.sublimitexisting1.style.visibility="visible";
			 }
			window.opener.document.forms[0].hidSubComFactype.value=varFacLoanType;
			window.opener.document.forms[0].txtsharetypesub.value=varsharetype;
			window.opener.document.forms[0].hidsubfacilityCode.value=varFacId;
			window.opener.callsubduedate(varFacLoanType);
			window.opener.document.forms[0].selsubadhocof.value="";
			window.opener.document.forms[0].sel_intsufacsubtype.value="0";
			window.opener.document.forms[0].sel_sub_propbanktype.value="";
			window.opener.document.forms[0].sel_sub_repaytype.value="0";
			window.opener.document.forms[0].txt_sub_LeadBank.value="";
			window.opener.document.forms[0].sel_peridicityfacsub.value="s";
			window.opener.document.forms[0].sel_subdisplaydesc.value="0";
			window.opener.document.forms[0].txt_margin_sub.value="";
			window.opener.document.forms[0].txt_subpurpose.value="";
			window.opener.document.forms[0].txt_subdesc.value="";
			window.opener.document.forms[0].txt_subduedate.value="";
			window.opener.getSubFacDescription('',varFacId);

		 }		
		 <%}else{%>
		 //window.opener.document.forms[0].facilitydescsubnew.value=varFacDesc+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varSchemeCode+"-"+varMintenor+"-"+varmaxTenor;
		 window.opener.document.forms[0].txt_subproposed_limit.value="";
		 window.opener.document.forms[0].sel_sub_inttype.value="0";
		 window.opener.document.forms[0].txt_subfacmonths.value="";
		 window.opener.document.forms[0].txt_installments_sub.value="";
		 window.opener.document.forms[0].prd_subintrate.value="";
		 window.opener.document.forms[0].facilitydescsubnew.value=varFacDesc;
		 var a1=varFacHead.split("-");		 
		 window.opener.document.forms[0].facilitysub_head_id_code.value=a1[0];
		 var a2=varFacSubCode.split("-");
		 if(a1[0]=="5" && a2[0]=="97")
		 {
			 window.opener.document.all.idsubmargin.style.display="table-row";
			 window.opener.document.all.idsubmargin1.style.display="table-row";
		 }
		 else
		 {
			 window.opener.document.all.idsubmargin.style.display="none";
			 window.opener.document.all.idsubmargin1.style.display="none";
			 window.opener.document.forms[0].sel_marginsub.value="";
			 window.opener.document.forms[0].sel_relaxedmarginsub.value="";
			 window.opener.document.forms[0].sel_definedmarginsub.value=""; 
		 }
		 window.opener.document.forms[0].facilitysub_id_code.value=a2[0];
		 window.opener.document.forms[0].facilitydescsub.value=varFacId+"-"+varMinAmnt+"-"+varmaxAmnt+"-"+varMintenor+"-"+varmaxTenor;
		 window.opener.document.forms[0].sel_subschemetype.value=varagrscheme;
		 window.opener.document.forms[0].facilitysub_nature.value=varfacilitytype;
		 if(window.opener.document.forms[0].sel_subfac_desc.value=="2")
		 {
			 window.opener.document.forms[0].sel_subfac_desc.value="2";
		 }else{
			 window.opener.document.forms[0].sel_subfac_desc.value="1";
		 }
		 if(window.opener.document.forms[0].sel_subfac_desc.value=="1")
		 {
			 window.opener.document.all.sublimitexisting.style.visibility="hidden";
			 window.opener.document.all.sublimitexisting1.style.visibility="hidden";
			// window.opener.document.all.Existing_limit.style.position="relative";
		 }else
		 {
			 window.opener.document.all.sublimitexisting.style.visibility="visible";
			 window.opener.document.all.sublimitexisting1.style.visibility="visible";
		 }
		window.opener.document.forms[0].hidSubComFactype.value=varFacLoanType;
		window.opener.document.forms[0].txtsharetypesub.value=varsharetype;
		window.opener.document.forms[0].hidsubfacilityCode.value=varFacId;
		window.opener.callsubduedate(varFacLoanType);
		window.opener.funenablesubfitl();
		window.opener.document.forms[0].selsubadhocof.value="";
		window.opener.document.forms[0].sel_intsufacsubtype.value="0";
		window.opener.document.forms[0].sel_sub_propbanktype.value="";
		window.opener.document.forms[0].sel_sub_repaytype.value="0";
		window.opener.document.forms[0].txt_sub_LeadBank.value="";
		window.opener.document.forms[0].sel_peridicityfacsub.value="s";
		window.opener.document.forms[0].sel_subdisplaydesc.value="0";
		window.opener.document.forms[0].txt_margin_sub.value="";
		window.opener.document.forms[0].txt_subpurpose.value="";
		window.opener.document.forms[0].txt_subdesc.value="";
		window.opener.document.forms[0].txt_subduedate.value="";
		window.opener.getSubFacDescription('',varFacId);
		 <%}%>
		 var varArr2= varrepayment.split("@");
			for(var i=0;i<varArr2.length-1;i++)
			{
				window.opener.document.forms[0].sel_sub_repaytype.length=varArr2.length;

				if(i==0)
				{
					window.opener.document.forms[0].sel_sub_repaytype.options[0].text="<--select-->";	
					window.opener.document.forms[0].sel_sub_repaytype.options[0].value="0";
				}
				
				var selValue=varArr2[i];
			
				if("E"==selValue)	
				{	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="EMI";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}			
				else if("NE"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="Non-EMI";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("OD"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="On Demand";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("LC"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="As Per LC Terms";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}			
				else if("CO"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="As Per Contract Terms";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("BG"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="As Per BG Rules";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("DD"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="On Due Date";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("PC"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="From the proceeds of PSC \ by realization of bill";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("PS"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="By Realization of Export Bills";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("PR"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="By Realization of Respective Bills";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				else if("TG"==selValue)
				{			
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].text="As per TCBG Rules";	
					window.opener.document.forms[0].sel_sub_repaytype.options[i+1].value=selValue;
				}
				
			}

			window.opener.document.forms[0].selsubadhocof.length=1;
			window.opener.document.forms[0].selsubadhocof.options[0].text="<--select-->";
			window.opener.document.forms[0].selsubadhocof.options[0].vale="";
			window.opener.document.forms[0].selsubadhocof.selectIndex="0";
			window.opener.document.all.idsubadhoc.style.display="none";
			window.opener.document.all.idsubadhoc1.style.display="none";
			window.opener.document.forms[0].txt_accountopenflagsub.value=varAccountOpenFlag;
				
			if(varAccountOpenFlag=="Y")
			{
				window.opener.document.forms[0].selsubadhoclimit.value="O";
				window.opener.document.forms[0].selsubadhoclimit.disabled=true;
			}
			else
			{
				window.opener.document.forms[0].selsubadhoclimit.value="";
				window.opener.document.forms[0].selsubadhoclimit.disabled=false;
			}

			window.opener.document.forms[0].hidfacreattachsub.value="N";

	 }
	 else if(varStrFormLink=="GCF")
	 {
		 window.opener.document.forms[0].sel_FacilityNew.value=varFacDesc;
		 window.opener.document.forms[0].sel_FacilityNew.title=varFacDesc;
		 window.opener.document.forms[0].sel_Facility.value=varFacId+"~"+varfacnature;
		 window.opener.setIdNature(varFacId+"~"+varfacnature);

	 }
	 
	 window.close();
}

function setValuesRetail(va0,va1,va2)
{
	 window.opener.document.forms[0].sel_FacilityNew.value=va1;
	 window.opener.document.forms[0].sel_FacilityNew.title=va1;
	 window.opener.document.forms[0].sel_Facility.value=va0+"~"+va2;
	 window.opener.setIdNature(va0+"~"+va2);
	 window.close();

	
}

function loadprdcategory(){
	
		document.forms[0].prd_type.length=7;
		document.forms[0].prd_type.options[1] = new Option('Housing Loan','H');
		document.forms[0].prd_type.options[2] = new Option('Vehicle Loan','A');
		document.forms[0].prd_type.options[3] = new Option('Mortgage Loan','M');
		document.forms[0].prd_type.options[4] = new Option('Salaried Person','P');
        document.forms[0].prd_type.options[5] = new Option('Mahila Udyog','U');
        document.forms[0].prd_type.options[6] = new Option('Ravi Kiran','K');
        document.forms[0].prd_type.options[7] = new Option('Education Loan','E');
 	
}

function doSearch()
{

	var varvaluesIn;
	<%if(strSessionModuleType.equalsIgnoreCase("AGR"))
		strModule="a";
	else if(strSessionModuleType.equalsIgnoreCase("CORP"))
		strModule="c";
		else
			strModule="r";%>
	var varModtype="<%=strModule%>";
	if(varStrFormLink!="GCF")
	{
		varvaluesIn=window.opener.document.forms[0].sel_proposalvaluesin.value;
	}
	else
	{
		varvaluesIn="";
	}
	varFacParent="";
	varFacSub="";
	var appno=document.forms[0].appno.value;
	var appid=document.forms[0].appid.value;
	document.forms[0].action=appURL+"action/facilitieslisthelp.jsp?hidBeanId=facilities&hidBeanGetMethod=getSetupFacility&strFacParent="+varFacParent+"&strFacSub="+varFacSub+"&subFacFlag=N&strValuesIn="+varvaluesIn+"&moduletype="+varModtype+"&appno="+appno+"&strappid="+appid;
	document.forms[0].submit();	
	
}

function doClose()
{
	window.close();
}
</SCRIPT>
<body onload="callOnLoad()">
<form name="facility" method="post" class="normal">
<table width="98%" border="0" cellspacing="2" cellpadding="2" class="outertable" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
	<tr>
		<td>
		<%if(strSessionModuleType.equalsIgnoreCase("AGR") || strSessionModuleType.equalsIgnoreCase("CORP")){ %>
		<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<tr align="center" class="dataheader">
				<td width="20%">Facility Head<span
											class="mantatory">*</span></td>
										<td width="20%">
										<%
											HashMap hp1 = new HashMap();
										%> <select name="facility_head"
											onChange="javascript:getFacility('facility')" style="width:150px">
											<option selected="selected" value="-">----Select----</option>
											<%
												HashMap h = new HashMap();
												h.put("value", "parent");
												h.put("parent", "0");
												h.put("hidMethod", "getFacility");

												hp1 = new HashMap();
												hp1.put("BeanId", "facilitymaster");
												hp1.put("MethodName", "getData");
												hp1.put("BeanParam", h);
											%>
											<lapschoice:selecttag value="<%=hp1%>" />
										</select> </td>
										<td width="20%">Facility<span
											class="mantatory">*</span></td>
										<td width="20%"><select name="facility" onchange="getFacilityDesc()"  style="width:150px">
											<option selected="selected" value="-">----Select----</option>
										</select></td>
			</tr>
		</table>
		<%}else{%>
		
		<table width="100%" border="0" cellpadding="3" cellspacing="0">
			<tr align="center" class="dataheader">
				<td colspan="2" align="right"><b>Products</b>&nbsp;</td>
				<td align="left">&nbsp;<select name="prd_type" onchange="doSearch()" >
				<option value="0">--Select---</option>
				</select></td>
			</tr>
		</table>		
		
		<%} %>
		
		</td>
	</tr>
</table>
<div class="cellcontainer">
<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
<%
if(strSessionModuleType.equalsIgnoreCase("AGR") || strSessionModuleType.equalsIgnoreCase("CORP")){ 
 if(vecRow!=null && vecRow.size()>0)
 {
	 for(int i=0;i<vecRow.size();i++)
	 {
		// out.println("vecRow===="+vecRow);
		 vecCol=(ArrayList)vecRow.get(i);
%>
     <tr  valign="top" class="datagrid">
     
     <td width="3%"><a href="javascript:setValues('<%=Helper.correctNull((String)vecCol.get(0))%>','<%=Helper.correctNull((String)vecCol.get(1))%>','<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(3))%>','<%=Helper.correctNull((String)vecCol.get(4))%>',
     '<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.correctNull((String)vecCol.get(6))%>','<%=Helper.correctNull((String)vecCol.get(7))%>','<%=Helper.correctNull((String)vecCol.get(8))%>','<%=Helper.correctNull((String)vecCol.get(9))%>','<%=Helper.correctNull((String)vecCol.get(10))%>','<%=Helper.correctNull((String)vecCol.get(11))%>','<%=Helper.correctNull((String)vecCol.get(12))%>','<%=Helper.correctNull((String)vecCol.get(13))%>','<%=Helper.correctNull((String)vecCol.get(14))%>','<%=Helper.correctNull((String)vecCol.get(15))%>','<%=Helper.correctNull((String)vecCol.get(16))%>','<%=Helper.correctNull((String)vecCol.get(17))%>','<%=Helper.correctNull((String)vecCol.get(18))%>','<%=Helper.correctNull((String)vecCol.get(19))%>','<%=Helper.correctNull((String)vecCol.get(20))%>')"><b>
     <%=Helper.correctNull((String)vecCol.get(1))+"-"+Helper.correctNull((String)vecCol.get(2))+"-"+Helper.correctNull((String)vecCol.get(3))+"-"+Helper.correctNull((String)vecCol.get(4))+"-"+Helper.correctNull((String)vecCol.get(5))+"-"+Helper.correctNull((String)vecCol.get(6))%></b></a></td>
          
     </tr>
<%		 
		 
		 
		 
		 
		 
	 }
	 
	 
	 
	 
 }
}
else
{
	if(arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			%>
			
			<tr  valign="top" class="datagrid">
			
			 <td><a href="javascript:setValuesRetail('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>')" class="blackfont" align="center"><%=Helper.correctNull((String)arrCol.get(1))%></a></td>		
			
			</tr>
			
			
			
			
		<%	
		}
		
	}
	
	
	
}

%>
<tr valign="top" class="datagrid">
<td></td>
</tr>
</table>
</div>
</td>
</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable="Y" />
<input type="hidden" name="comappid" value="<%=Helper.correctNull((String) request.getParameter("comappid"))%>">
<input type="hidden" name="apptype" value="<%=Helper.correctNull((String)request.getParameter("apptype"))%>">
<input type="hidden" name="hidBeanId" value="appeditlock"> 
<input type="hidden" name="hidBeanGetMethod" value="getProductList"> 
<input type="hidden" name="orgscode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>">
<input type="hidden" name="orgcode1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgCode"))%>">
<input type="hidden" name="orglevel1" value="<%=Helper.correctNull((String)session.getAttribute("strOrgLevel"))%>">
<input type="hidden" name="hidStaffFlag" value="<%=Helper.correctNull((String)request.getParameter("hidStaffFlag"))%>">
<input type="hidden" name="hidServiceLeft" value="<%=Helper.correctNull((String)request.getParameter("hidServiceLeft"))%>">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
<input type="hidden" name="DocReceived" value="<%=Helper.correctNull((String)request.getParameter("DocReceived"))%>"> 
<INPUT TYPE="hidden" name="bowid" value="<%//=bowid%>"> 
<input type="hidden" name="hidappage" value="<%=appage%>"> 
<input type="hidden" name="hidfromlink" value="<%=strFromLink%>">
<input type="hidden" name="hidModuleType" value="<%=strSessionModuleType%>">
<input type="hidden" name="hidconstituiton" value="<%=strConstituiton%>">
<input type="hidden" name="hidlending" value="<%=strLending%>">
<input type="hidden" name="appno" value="<%=strAppno%>">
<input type="hidden" name="appid" value="<%=strAppid%>">

<iframe height="0" width="0" id="ifrms" frameborder="0" style="border:0"></iframe>
<iframe
	height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder="0"
	style="border: 0"></iframe>
</form>
</body>
</html>
