<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<!--<lapschoice:handleerror />-->
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;			
			}			
			HashMap hshrec = (HashMap) hshValues.get("extfld");
			String mode = Helper.correctNull((String) hshValues.get("mode"));
			session.setAttribute("sessionapp_id", Helper.correctNull((String) hshValues.get("perapp_id")));
			String strProfilestatus = Helper.correctNull((String) hshValues.get("strProfilestatus"));
			String tempProfile = "";
			if (strProfilestatus.equalsIgnoreCase("Y")) {
				tempProfile = "Completed";
			} else {
				tempProfile = "Partial";
			}
				
			String strModuleType=Helper.correctNull((String)request.getParameter("hidPageType"));	
			String strUserId=Helper.correctNull((String)session.getAttribute("strUserId"));
			String PageName="";
			if(Helper.correctNull((String)session.getAttribute("moduletype")).equals("A"))
			{
				PageName="Agriculture";
			}
			else
			{
				PageName="Retail";
			}
%>
<%
String credate = "";
credate = Helper.correctNull((String)hshValues.get("Cust_createddate"));
if(credate.equals(""))
	credate = Helper.correctNull((String)hshValues.get("System_date"));
session.setAttribute("cust_createdate",credate);
String strdate = (String)ApplicationParams.getAppcreatedate();
long diff_intime = 0;
//diff_intime = Helper.dateDiff(credate,strdate);

session.setAttribute("dupecheckflag", Helper.correctNull((String) hshValues.get("dupecheckflag")));
String strCustCat = Helper.correctNull((String) hshValues.get("PERAPP_CUST_CATEGORY"));
String strpermar = Helper.correctNull((String) hshValues.get("perapp_permarstat"));
//out.print("mmmm"+strpermar);
String strpercat = Helper.correctNull((String) hshValues.get("perapp_percategory"));

%>
<%
String strCanaraSyndBank=ApplicationParams.getStrCbsInterfaceflag();
%>
<html>
<head>
<title>Personal - Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 400;
  overflow: auto;
}

select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/set/psb59perapplicant.js"></script>
	<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/browservalidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var mode = "<%=mode%>";
var id="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>";
var varSex="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>";
var varMstatus="<%=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>";
var varperMstatus="<%=Helper.correctNull((String)hshValues.get("perapp_permarstat"))%>";



var varEmployed="<%=Helper.correctNull((String)hshValues.get("perapp_employment"))%>";
var varperEmployed="<%=Helper.correctNull((String)hshValues.get("perapp_peremployment"))%>";

var vardelete="<%=Helper.correctNull((String)hshValues.get("nodelete"))%>";
var varedu = "<%=Helper.correctNull((String)hshValues.get("perapp_edu"))%>";
var varbank = "<%=Helper.correctNull((String)hshValues.get("perapp_bank"))%>";
//sathiya-GPA holder
var varGPAholder = "<%=Helper.correctNull((String)hshValues.get("PERAPP_WGPA"))%>";

var varbuss = "<%=Helper.correctNull((String)hshValues.get("perapp_buss"))%>";
var varcat = "<%=Helper.correctNull((String)hshValues.get("perapp_category"))%>";

var varpercat = "<%=Helper.correctNull((String)hshValues.get("perapp_percategory"))%>";

var yearsinadd = "<%=Helper.correctNull((String)hshValues.get("perapp_yrsinpresadd"))%>";
var typeofprof = "<%=Helper.correctNull((String)hshValues.get("perapp_typeofprof"))%>";
var varperapp_apptitle = "<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>"
var appstatus = "<%=Helper.correctNull((String)hshValues.get("appstatus"))%>";
var branchcode = "<%=Helper.correctNull((String)hshValues.get("perapp_branchcode"))%>";

var varindepend = "<%=Helper.correctNull((String)hshValues.get("perapp_spouseind"))%>";
var varcoborrow = "<%=Helper.correctNull((String)hshValues.get("perapp_spouserel"))%>";
var varselpensioner = "<%=Helper.correctNull((String)hshValues.get("selpensioner"))%>";
var perapp_education = "<%=Helper.correctNull((String)hshValues.get("perapp_education"))%>";
var varchairman = "<%=Helper.correctNull((String)hshValues.get("perapp_chairman"))%>";
var varperchairman = "<%=Helper.correctNull((String)hshValues.get("perapp_ischairman"))%>";

var varresstatus = "<%=Helper.correctNull((String)hshValues.get("perapp_resstaus"))%>";
var varperresstatus = "<%=Helper.correctNull((String)hshValues.get("perapp_perresidstatus"))%>";
var varperResidence="<%=Helper.correctNull((String)hshValues.get("perapp_residstatus"))%>";

var varrelation = "<%=Helper.correctNull((String)hshValues.get("PERAPP_RELATIONSHIP"))%>";





var varmobility = "<%=Helper.correctNull((String)hshValues.get("peremp_mobility"))%>";
var varbankrel = "<%=Helper.correctNull((String)hshValues.get("perapp_bankrel"))%>";
var varPERAPP_FARMER = "<%=Helper.correctNull((String)hshValues.get("PERAPP_FARMER"))%>";
//var varPERAPP_MEASUREMENT = "<%=Helper.correctNull((String)hshValues.get("PERAPP_MEASUREMENT"))%>";
var varPERAPP_SHG = "<%=Helper.correctNull((String)hshValues.get("PERAPP_SHG"))%>";
var varHid_Modtype = "<%=strModuleType%>";
var varJLG = "<%=Helper.correctNull((String)hshValues.get("PERAPP_JLG"))%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var varResidence="<%=Helper.correctNull((String)hshValues.get("perapp_residencetype"))%>";

var varCanaraSyndBank="<%=strCanaraSyndBank%>";
var varCustCat="<%=strCustCat%>";
var varSubConstitution="<%=Helper.correctNull((String)hshValues.get("perapp_subconsti"))%>";

function show_shgvalue()
{
	if(varResidence!="")
	{
		document.forms[0].txt_residence.value=varResidence;
	}
	else
	{
		document.forms[0].txt_residence.value="";
	}

if(varEmployed=="7")
{
	if(varJLG=="" || varJLG=="n" || varJLG=="s")
	{
		document.forms[0].sel_jlg.value="s";



		if(varPERAPP_SHG=="")
		{
			document.forms[0].sel_shg.value="s";
		}
		else
		{
			
			document.forms[0].sel_shg.value=varPERAPP_SHG;
			document.forms[0].sel_jlg.value=varJLG;
			showSHGJLG('SHG');


			if(document.forms[0].sel_shg.value=="y")
			{
				document.forms[0].txtshg_name.value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGNAME"))%>";
				document.forms[0].txtshg_village.value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGVILLAGE"))%>";
			}
				
			
		}

		
	}
	else
	{
		document.forms[0].sel_jlg.value=varJLG;
		document.forms[0].sel_shg.value=varPERAPP_SHG;
		showSHGJLG('JLG');

	
	if(document.forms[0].sel_jlg.value=="y")
	{
		document.forms[0].txtshg_name.value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGNAME"))%>";
		document.forms[0].txtshg_village.value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGVILLAGE"))%>";;
	}
			
		
		
	}


	
}


}


function checkFileDate(obj)
{
	var pagedate = obj.value;
	var pgdt = pagedate.substring(0,2);
	var pgmon = pagedate.substring(3,5);
	var pgyr = pagedate.substring(6,10);
	var objdate = pgmon+"/"+pgdt+"/"+pgyr;
	
	var currdate = currentDate;
	var crdt = currdate.substring(0,2);
	var crmon = currdate.substring(3,5);
	var cryr = currdate.substring(6,10);
	var curdate = crmon+"/"+crdt+"/"+cryr;
	
	if (Date.parse(objdate) > Date.parse(curdate))
	{
		alert("Date of Birth cannot be greater than Current Date");
		document.forms[0].txtperapp_dob.value="";
		document.forms[0].txtperapp_dob.focus();
		return;
	}
}

function showGPAholder()
{
	var strGPAtype="<%=Helper.correctNull((String)hshValues.get("PERAPP_WGPA"))%>";

	if(strGPAtype!="")
	{
				document.forms[0].selGPA.value=strGPAtype;
	}
	
}

function ShowStates(stateval)
{		   
	if(stateval =='111')
	{
		var purl = appURL+"action/stateslistnew.jsp?hidBeanGetMethod=getIndiaState&hidBeanId=perapplicant";
		prop = "scrollbars=yes,width=300,height=650,statusbar=yes,menubar=no";	
		xpos = 400;
		ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
		window.open(purl,title,prop);
	}
	else
	{
		var purl = appURL+"action/stateslist.jsp?stateval="+stateval;
		prop = "scrollbars=yes,width=300,height=650,statusbar=yes,menubar=no";	
		xpos = 400;
		ypos = 5;
		prop = prop + ",left="+xpos+",top="+ypos;
		var title = "Print";
		window.open(purl,title,prop);
	}
}
function ShowAccountDetails()
{
	//alert("varCanaraSyndBank"+varCanaraSyndBank);
	if(varCanaraSyndBank=="C")
	{
		var varQryString = appURL+"action/perappbank_Canara.jsp?hidBeanGetMethod=getAppBankInfo_Canara&hidBeanId=perfinancial&id="+id+"&cbs_id="+document.forms[0].txtperapp_cbsid.value;
		var title = "AccountDetails";
		var prop = "scrollbars=yes,width=850,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varQryString,title,prop);
	}
	else
	{
		var varQryString = appURL+"action/perappbank.jsp?hidBeanGetMethod=getAppBankInfo&hidBeanId=perfinancial&id="+id+"&cbs_id="+document.forms[0].txtperapp_cbsid.value;
		var title = "AccountDetails";
		var prop = "scrollbars=yes,width=850,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varQryString,title,prop);
	}
				

}
function ShowLegal(page)
{
	var demoid = document.forms[0].hidDemoId.value;
	var url = appURL+"action/"+page+"?hidBeanId=mastapplicant&hidBeanGetMethod=getLegalData&hidDemoId="+demoid;
	var title = "LegalHeirs";
	var prop = "scrollbars=no,width=775,height=500,menubar=no";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title,prop);
}
function callhelp()
{
		   var varQryString = appURL+"/jsp/perhlp/hlp_perapplicant.jsp"
		   var title = "ApplicantDemographics";
			var prop = "scrollbars=no,width=600,height=450";	
			prop = prop + ",left=200,top=150";
			window.open(varQryString,title,prop);
}
function callFirmDetails()
{

document.forms[0].method="post";
document.forms[0].hidBeanId.value="setfirmdetails";
document.forms[0].hidBeanGetMethod.value="getFirmData";
document.forms[0].action=appURL+"controllerservlet";
document.forms[0].action=appURL+"action/setfirmdetails.jsp?app_id="+document.forms[0].hidDemoId.value;

document.forms[0].submit();
}
function trandata()
{
	//alert(document.forms[0].percheck.disabled);
	if(document.forms[0].trapEdit.value=="TE")
	{
		//document.forms[0].percheck.disabled=false;
	  if (document.forms[0].percheck.checked == true)
	  {
	    document.forms[0].txtperapp_address1.value =  document.forms[0].txtperapp_permadd1.value;
	    document.forms[0].txtperapp_address2.value = document.forms[0].txtperapp_permadd2.value;
	    document.forms[0].txtperapp_city.value = document.forms[0].txtperapp_permcity.value;
	    document.forms[0].txtperapp_address3.value = document.forms[0].txtPERAPP_PERMADD3.value;
	    document.forms[0].txtperapp_zip.value =document.forms[0].txtperapp_permzip.value;
	  }
	  else
	  {
	   document.forms[0].txtperapp_address1.value =  "";
	    document.forms[0].txtperapp_address2.value = "";
	    document.forms[0].txtperapp_city.value = "";
	    document.forms[0].txtperapp_address3.value = "";
	    document.forms[0].txtperapp_zip.value ="";
	  }
	}
	else
	{
		//document.forms[0].percheck.disabled=true;
		alert("Kindly Click Modify and then Edit Button.");
	}
}

function showSHGJLG(val)
{
	if(varCanaraSyndBank=="C")
	{
		//showProfession1();
		if(val=='SHG')
		{
			var varshg=document.forms[0].sel_shg.value;		
			if(varshg!="")
			{
				 if(varshg=="y")
				{			
					 document.forms[0].selGPA.value="2";
					 enableGPAholder();
					document.all.farm8.style.visibility="hidden";
					document.all.farm8.style.position="absolute";
					
					document.all.farm9.style.visibility="hidden";
					document.all.farm9.style.position="absolute";
					
					document.all.farm10.style.visibility="hidden";
					document.all.farm10.style.position="absolute";
					
					document.all.farm11.style.visibility="hidden";
					document.all.farm11.style.position="absolute";
					
					document.all.farm12.style.visibility="hidden";
					document.all.farm12.style.position="absolute";
					
					document.all.farm13.style.visibility="hidden";
					document.all.farm13.style.position="absolute";
					
					document.all.farm14.style.visibility="hidden";
					document.all.farm14.style.position="absolute";
					
					document.all.farm15.style.visibility="hidden";
					document.all.farm15.style.position="absolute";
					
					document.all.farm16.style.visibility="hidden";
					document.all.farm16.style.position="absolute";
					
					document.all.farm17.style.visibility="hidden";
					document.all.farm17.style.position="absolute";
					
					document.all.farm18.style.visibility="hidden";
					document.all.farm18.style.position="absolute";
					
					document.all.farm19.style.visibility="hidden";
					document.all.farm19.style.position="absolute";
					
					document.all.farm20.style.visibility="hidden";
					document.all.farm20.style.position="absolute";
					
					document.all.farm21.style.visibility="hidden";
					document.all.farm21.style.position="absolute";
					
					document.all.farm22.style.visibility="hidden";
					document.all.farm22.style.position="absolute";
					
			//		document.all.farm23.style.visibility="hidden";
			//		document.all.farm23.style.position="absolute";
					
					document.all.farm24.style.visibility="visible";
					document.all.farm24.style.position="relative";

					document.all.legalheiers.style.display="none";				
					
					document.all.farm25.style.visibility="hidden";
					document.all.farm25.style.position="absolute";
					
					document.all.farm26.style.visibility="visible"
					document.all.farm26.style.position="relative";
					
					
				//	document.forms[0].seledu.value="";
					document.forms[0].txtperapp_age.value="";
					document.forms[0].choperapp_sex.value="";
					document.forms[0].txtperapp_fatname.value="";
					document.forms[0].selcat.value="";
					document.forms[0].txtperapp_childnum.value="";	
					document.forms[0].sel_jlg.value="n";

					document.all.agr_typefarmer.style.display="inline";// Type of Farmer
					document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

			    	//document.all.agr_measurementtype.style.display="inline";// Measurement Type-->
					//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

					document.all.agr_whetherjlg.style.display="none";// Whether JLG 
					document.all.agr_jlgtypes.style.display="none";   // sel Whether JLG

					document.all.agr_whethershg.style.display="inline";// Whether SHG 
					document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG

					document.all.shg_groupname.style.display="inline"; //SHG Group Name
					document.all.jlg_groupname.style.display="none"; //JLG Group Name

					document.all.txtshg_name.style.display="inline";   //  shg/jlg text box 

					document.all.agr_village.style.display="inline";// Village/block 
					document.all.agr_villageType.style.display="inline";   // Village/block txt
					document.all.txtshg_village.style.display="inline";   // Village/block txt box				
				
				}
				
				else
				{						
					document.all.farm8.style.visibility="visible";
					document.all.farm8.style.position="relative";
					
					document.all.farm9.style.visibility="visible";
					document.all.farm9.style.position="relative";
					
					document.all.farm10.style.visibility="visible";
					document.all.farm10.style.position="relative";
					
					document.all.farm11.style.visibility="visible";
					document.all.farm11.style.position="relative";
					
					document.all.farm12.style.visibility="visible";
					document.all.farm12.style.position="relative";
					
					document.all.farm13.style.visibility="visible";
					document.all.farm13.style.position="relative";
					
					document.all.farm14.style.visibility="visible";
					document.all.farm14.style.position="relative";
					
					document.all.farm15.style.visibility="visible";
					document.all.farm15.style.position="relative";
					
					document.all.farm16.style.visibility="visible";
					document.all.farm16.style.position="relative";
					
					document.all.farm17.style.visibility="visible";
					document.all.farm17.style.position="relative";
					
					document.all.farm18.style.visibility="visible";
					document.all.farm18.style.position="relative";
					
					document.all.farm19.style.visibility="visible";
					document.all.farm19.style.position="relative";
					
					document.all.farm20.style.visibility="visible";
					document.all.farm20.style.position="relative";
					
					document.all.farm21.style.visibility="visible";
					document.all.farm21.style.position="relative";
					
					document.all.farm22.style.visibility="visible";
					document.all.farm22.style.position="relative";
					
				//	document.all.farm23.style.visibility="visible";
				//	document.all.farm23.style.position="relative";
					
					document.all.farm24.style.visibility="hidden";
					document.all.farm24.style.position="absolute";

					document.all.legalheiers.style.display="inline";
					
					document.all.farm25.style.visibility="visible";
					document.all.farm25.style.position="relative";
					
					document.all.farm26.style.visibility="hidden";
					document.all.farm26.style.position="absolute";

					document.forms[0].txtshg_village.value=""; // village txt box
					document.forms[0].txtshg_name.value="";	// shg/jlg text box 

					document.all.shg_groupname.style.display="none"; //shg_groupname
					document.all.txtshg_name.style.display="none"; // shg/jlg text box 

					document.all.agr_village.style.display="none";  // Village/Block Name
					document.all.agr_villageType.style.display="none";  // Village/Block Name

					document.all.agr_whetherjlg.style.display="inline";// Whether SHG
					document.all.agr_jlgtypes.style.display="inline";   // sel Whether SHG
					document.all.txtshg_village.style.display="none"; // Village/Block Name text box
					
				}
			}
		}else if(val=='JLG')
		{
			
			var varjlg=document.forms[0].sel_jlg.value;
			if(varjlg!="")
				{
				 if(varjlg=="y")
					{		


								
						 document.forms[0].selGPA.value="2";
						 enableGPAholder();
						document.all.farm8.style.visibility="hidden";
						document.all.farm8.style.position="absolute";
						
						document.all.farm9.style.visibility="hidden";
						document.all.farm9.style.position="absolute";
						
						document.all.farm10.style.visibility="hidden";
						document.all.farm10.style.position="absolute";
						
						document.all.farm11.style.visibility="hidden";
						document.all.farm11.style.position="absolute";
						
						document.all.farm12.style.visibility="hidden";
						document.all.farm12.style.position="absolute";
						
						document.all.farm13.style.visibility="hidden";
						document.all.farm13.style.position="absolute";
						
						document.all.farm14.style.visibility="hidden";
						document.all.farm14.style.position="absolute";
						
						document.all.farm15.style.visibility="hidden";
						document.all.farm15.style.position="absolute";
						
						document.all.farm16.style.visibility="hidden";
						document.all.farm16.style.position="absolute";
						
						document.all.farm17.style.visibility="hidden";
						document.all.farm17.style.position="absolute";
						
						document.all.farm18.style.visibility="hidden";
						document.all.farm18.style.position="absolute";
						
						document.all.farm19.style.visibility="hidden";
						document.all.farm19.style.position="absolute";
						
						document.all.farm20.style.visibility="hidden";
						document.all.farm20.style.position="absolute";
						
						document.all.farm21.style.visibility="hidden";
						document.all.farm21.style.position="absolute";
						
						document.all.farm22.style.visibility="hidden";
						document.all.farm22.style.position="absolute";
						
					//	document.all.farm23.style.visibility="hidden";
					//	document.all.farm23.style.position="absolute";
						
						document.all.farm24.style.visibility="visible";
						document.all.farm24.style.position="relative";

						document.all.legalheiers.style.display="none"; //
						
						document.all.farm25.style.visibility="hidden";
						document.all.farm25.style.position="absolute";
						
						document.all.farm26.style.visibility="visible"
						document.all.farm26.style.position="relative";
						
					//	document.forms[0].seledu.value="";
						//document.forms[0].farm8.value="";
						document.forms[0].txtperapp_age.value="";
						document.forms[0].choperapp_sex.value="";
						document.forms[0].txtperapp_fatname.value="";
						document.forms[0].selcat.value="";
						document.forms[0].txtperapp_childnum.value="";	
						document.forms[0].sel_shg.value="n";	

						document.all.agr_typefarmer.style.display="inline";// Type of Farmer
						document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

						//document.all.agr_measurementtype.style.display="inline";// Measurement Type
						//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

						document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
						document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

						document.all.agr_whethershg.style.display="none";// Whether SHG 
						document.all.agr_shgtypes.style.display="none";   // sel Whether SHG

						document.all.jlg_groupname.style.display="inline"; // JLG Group Name
						document.all.shg_groupname.style.display="none"; //SHG Group Name

						document.all.agr_whethershg.style.display="none";// Whether SHG 
						document.all.agr_shgtypes.style.display="none";   // sel Whether SHG

						document.all.txtshg_name.style.display="inline";   //  shg/jlg text box 

						document.all.agr_village.style.display="inline";// Village/block 
						document.all.agr_villageType.style.display="inline";   // Village/block txt
						document.all.txtshg_village.style.display="inline";   // Village/block txt box
					}
					
					else
					{					
						document.all.farm8.style.visibility="visible";
						document.all.farm8.style.position="relative";
						
						document.all.farm9.style.visibility="visible";
						document.all.farm9.style.position="relative";
						
						document.all.farm10.style.visibility="visible";
						document.all.farm10.style.position="relative";
						
						document.all.farm11.style.visibility="visible";
						document.all.farm11.style.position="relative";
						
						document.all.farm12.style.visibility="visible";
						document.all.farm12.style.position="relative";
						
						document.all.farm13.style.visibility="visible";
						document.all.farm13.style.position="relative";
						
						document.all.farm14.style.visibility="visible";
						document.all.farm14.style.position="relative";
						
						document.all.farm15.style.visibility="visible";
						document.all.farm15.style.position="relative";
						
						document.all.farm16.style.visibility="visible";
						document.all.farm16.style.position="relative";
						
						document.all.farm17.style.visibility="visible";
						document.all.farm17.style.position="relative";
						
						document.all.farm18.style.visibility="visible";
						document.all.farm18.style.position="relative";
						
						document.all.farm19.style.visibility="visible";
						document.all.farm19.style.position="relative";
						
						document.all.farm20.style.visibility="visible";
						document.all.farm20.style.position="relative";
						
						document.all.farm21.style.visibility="visible";
						document.all.farm21.style.position="relative";
						
						document.all.farm22.style.visibility="visible";
						document.all.farm22.style.position="relative";
						
					//	document.all.farm23.style.visibility="visible";
					//	document.all.farm23.style.position="relative";
						
						document.all.farm24.style.visibility="hidden";
						document.all.farm24.style.position="absolute";

						document.all.legalheiers.style.display="inline"; //
						
						document.all.farm25.style.visibility="visible";
						document.all.farm25.style.position="relative";
						
						document.all.farm26.style.visibility="hidden";
						document.all.farm26.style.position="absolute";

					    document.forms[0].txtshg_village.value=""; // village txt box
					    document.forms[0].txtshg_name.value="";	// shg/jlg text box 	
						document.all.jlg_groupname.style.display="none";					

						document.all.agr_village.style.display="none";// Village/block 
						document.all.agr_villageType.style.display="none";   // Village/block txt

						document.all.agr_whethershg.style.display="inline";// Whether SHG
						document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG

						document.all.txtshg_name.style.display="none"; // 	
					}
				}
		}else {		
			var varProfession= document.forms[0].rdoperapp_employment[document.forms[0].rdoperapp_employment.options.selectedIndex].value;
				if(varEmployed=="7")
			{
			document.all.farm26.style.visibility="hidden";
			document.all.farm26.style.position="absolute";
					
			document.all.agr_typefarmer.style.display="inline";// Type of Farmer
			document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

			//document.all.agr_measurementtype.style.display="inline";// Measurement Type
			//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

			document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
			document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

			document.all.agr_whethershg.style.display="inline";// Whether SHG 
			document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG		

			document.all.shg_groupname.style.display="none"; //Whether SHG
			document.all.jlg_groupname.style.display="none"; // Whether JLG

			document.all.agr_village.style.display="none"; //Village/block 
			document.all.agr_villageType.style.display="none"; // Village/block txt
			document.all.txtshg_name.style.display="none"; 	

			document.all.farm24.style.visibility="hidden";
			document.all.farm24.style.position="absolute";
			
			document.all.legalheiers.style.display="inline"; 	//Legal Heirs
			
			}else {						
				document.all.farm26.style.visibility="hidden";
				document.all.farm26.style.position="absolute";

				document.all.farm24.style.visibility="hidden"; // Member Details
				document.all.farm24.style.position="absolute";  // Member Details		

				document.all.legalheiers.style.display="inline"; //
				
				document.all.agr_typefarmer.style.display="none"; //Type of Farmer
				document.all.agr_farmactivity.style.display="none"; // sel Type of Farmer

				//document.all.agr_measurementtype.style.display="none"; //Measurement Type
				//document.all.agr_measurementactivity.style.display="none"; // sel Measurement Type

				document.all.agr_whethershg.style.display="none"; //Whether SHG
				document.all.agr_shgtypes.style.display="none"; // sel Whether SHG

				document.all.agr_whetherjlg.style.display="none"; //Whether JLG
				document.all.agr_jlgtypes.style.display="none"; // sel Whether JLG

				document.all.shg_groupname.style.display="none"; //shg_groupname
				document.all.jlg_groupname.style.display="none"; // jlg_groupname

				document.all.agr_village.style.display="none"; //Village/block 
				document.all.agr_villageType.style.display="none"; // Village/block txt
				document.all.txtshg_name.style.display="none"; 
				}

				if(varProfession=="7"){ 								
					document.all.agr_typefarmer.style.display="inline";// Type of Farmer
					document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

					//document.all.agr_measurementtype.style.display="inline";// Measurement Type
					//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

					document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
					document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

					document.all.agr_whethershg.style.display="inline";// Whether SHG 
					document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG				

					document.all.shg_groupname.style.display="none"; //Whether SHG
					document.all.jlg_groupname.style.display="none"; // Whether JLG

					document.all.agr_village.style.display="none"; //Village/block 
					document.all.agr_villageType.style.display="none"; // Village/block txt
					document.all.txtshg_name.style.display="none"; 
				}
			}
		
	}
	else
	{

		//showProfession1();
		if(val=='SHG')
		{
			var varshg=document.forms[0].sel_shg.value;		
			if(varshg!="")
			{
				 if(varshg=="y")
				{			
					 document.forms[0].selGPA.value="2";
					 enableGPAholder();
					document.all.farm8.style.visibility="hidden";
					document.all.farm8.style.position="absolute";
					
					document.all.farm9.style.visibility="hidden";
					document.all.farm9.style.position="absolute";
					
					document.all.farm10.style.visibility="hidden";
					document.all.farm10.style.position="absolute";
					
					document.all.farm11.style.visibility="hidden";
					document.all.farm11.style.position="absolute";
					
					document.all.farm12.style.visibility="hidden";
					document.all.farm12.style.position="absolute";
					
					document.all.farm13.style.visibility="hidden";
					document.all.farm13.style.position="absolute";
					
					document.all.farm14.style.visibility="hidden";
					document.all.farm14.style.position="absolute";
					
					document.all.farm15.style.visibility="hidden";
					document.all.farm15.style.position="absolute";
					
					document.all.farm16.style.visibility="hidden";
					document.all.farm16.style.position="absolute";
					
					document.all.farm17.style.visibility="hidden";
					document.all.farm17.style.position="absolute";
					
					document.all.farm18.style.visibility="hidden";
					document.all.farm18.style.position="absolute";
					
					document.all.farm19.style.visibility="hidden";
					document.all.farm19.style.position="absolute";
					
					document.all.farm20.style.visibility="hidden";
					document.all.farm20.style.position="absolute";
					
					document.all.farm21.style.visibility="hidden";
					document.all.farm21.style.position="absolute";
					
					document.all.farm22.style.visibility="hidden";
					document.all.farm22.style.position="absolute";
					
			//		document.all.farm23.style.visibility="hidden";
			//		document.all.farm23.style.position="absolute";
					
					document.all.farm24.style.visibility="visible";
					document.all.farm24.style.position="relative";

					document.all.legalheiers.style.display="none";				
					
					document.all.farm25.style.visibility="hidden";
					document.all.farm25.style.position="absolute";
					
					document.all.farm26.style.visibility="visible"
					document.all.farm26.style.position="relative";
					
					
				//	document.forms[0].seledu.value="";
					document.forms[0].txtperapp_age.value="";
					document.forms[0].choperapp_sex.value="";
					document.forms[0].txtperapp_fatname.value="";
					document.forms[0].selcat.value="";
					document.forms[0].txtperapp_childnum.value="";	
					document.forms[0].sel_jlg.value="n";

					document.all.agr_typefarmer.style.display="inline";// Type of Farmer
					document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

			    	//document.all.agr_measurementtype.style.display="inline";// Measurement Type-->
					//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

					document.all.agr_whetherjlg.style.display="none";// Whether JLG 
					document.all.agr_jlgtypes.style.display="none";   // sel Whether JLG

					document.all.agr_whethershg.style.display="inline";// Whether SHG 
					document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG

					document.all.shg_groupname.style.display="inline"; //SHG Group Name
					document.all.jlg_groupname.style.display="none"; //JLG Group Name

					document.all.txtshg_name.style.display="inline";   //  shg/jlg text box 

					document.all.agr_village.style.display="inline";// Village/block 
					document.all.agr_villageType.style.display="inline";   // Village/block txt
					document.all.txtshg_village.style.display="inline";   // Village/block txt box				
				
				}
				
				else
				{						
					document.all.farm8.style.visibility="visible";
					document.all.farm8.style.position="relative";
					
					document.all.farm9.style.visibility="visible";
					document.all.farm9.style.position="relative";
					
					document.all.farm10.style.visibility="visible";
					document.all.farm10.style.position="relative";
					
					document.all.farm11.style.visibility="visible";
					document.all.farm11.style.position="relative";
					
					document.all.farm12.style.visibility="visible";
					document.all.farm12.style.position="relative";
					
					document.all.farm13.style.visibility="visible";
					document.all.farm13.style.position="relative";
					
					document.all.farm14.style.visibility="visible";
					document.all.farm14.style.position="relative";
					
					document.all.farm15.style.visibility="visible";
					document.all.farm15.style.position="relative";
					
					document.all.farm16.style.visibility="visible";
					document.all.farm16.style.position="relative";
					
					document.all.farm17.style.visibility="visible";
					document.all.farm17.style.position="relative";
					
					document.all.farm18.style.visibility="visible";
					document.all.farm18.style.position="relative";
					
					document.all.farm19.style.visibility="visible";
					document.all.farm19.style.position="relative";
					
					document.all.farm20.style.visibility="visible";
					document.all.farm20.style.position="relative";
					
					document.all.farm21.style.visibility="visible";
					document.all.farm21.style.position="relative";
					
					document.all.farm22.style.visibility="visible";
					document.all.farm22.style.position="relative";
					
				//	document.all.farm23.style.visibility="visible";
				//	document.all.farm23.style.position="relative";
					
					document.all.farm24.style.visibility="hidden";
					document.all.farm24.style.position="absolute";

					document.all.legalheiers.style.display="inline";
					
					document.all.farm25.style.visibility="visible";
					document.all.farm25.style.position="relative";
					
					document.all.farm26.style.visibility="hidden";
					document.all.farm26.style.position="absolute";

					document.forms[0].txtshg_village.value=""; // village txt box
					document.forms[0].txtshg_name.value="";	// shg/jlg text box 

					document.all.shg_groupname.style.display="none"; //shg_groupname
					document.all.txtshg_name.style.display="none"; // shg/jlg text box 

					document.all.agr_village.style.display="none";  // Village/Block Name
					document.all.agr_villageType.style.display="none";  // Village/Block Name

					document.all.agr_whetherjlg.style.display="inline";// Whether SHG
					document.all.agr_jlgtypes.style.display="inline";   // sel Whether SHG
					document.all.txtshg_village.style.display="none"; // Village/Block Name text box
					
				}
			}
		}else if(val=='JLG')
		{
			
			var varjlg=document.forms[0].sel_jlg.value;
			if(varjlg!="")
				{
				 if(varjlg=="y")
					{		


								
						 document.forms[0].selGPA.value="2";
						 enableGPAholder();
						document.all.farm8.style.visibility="hidden";
						document.all.farm8.style.position="absolute";
						
						document.all.farm9.style.visibility="hidden";
						document.all.farm9.style.position="absolute";
						
						document.all.farm10.style.visibility="hidden";
						document.all.farm10.style.position="absolute";
						
						document.all.farm11.style.visibility="hidden";
						document.all.farm11.style.position="absolute";
						
						document.all.farm12.style.visibility="hidden";
						document.all.farm12.style.position="absolute";
						
						document.all.farm13.style.visibility="hidden";
						document.all.farm13.style.position="absolute";
						
						document.all.farm14.style.visibility="hidden";
						document.all.farm14.style.position="absolute";
						
						document.all.farm15.style.visibility="hidden";
						document.all.farm15.style.position="absolute";
						
						document.all.farm16.style.visibility="hidden";
						document.all.farm16.style.position="absolute";
						
						document.all.farm17.style.visibility="hidden";
						document.all.farm17.style.position="absolute";
						
						document.all.farm18.style.visibility="hidden";
						document.all.farm18.style.position="absolute";
						
						document.all.farm19.style.visibility="hidden";
						document.all.farm19.style.position="absolute";
						
						document.all.farm20.style.visibility="hidden";
						document.all.farm20.style.position="absolute";
						
						document.all.farm21.style.visibility="hidden";
						document.all.farm21.style.position="absolute";
						
						document.all.farm22.style.visibility="hidden";
						document.all.farm22.style.position="absolute";
						
					//	document.all.farm23.style.visibility="hidden";
					//	document.all.farm23.style.position="absolute";
						
						document.all.farm24.style.visibility="visible";
						document.all.farm24.style.position="relative";

						document.all.legalheiers.style.display="none"; //
						
						document.all.farm25.style.visibility="hidden";
						document.all.farm25.style.position="absolute";
						
						document.all.farm26.style.visibility="visible"
						document.all.farm26.style.position="relative";
						
					//	document.forms[0].seledu.value="";
						//document.forms[0].farm8.value="";
						document.forms[0].txtperapp_age.value="";
						document.forms[0].choperapp_sex.value="";
						document.forms[0].txtperapp_fatname.value="";
						document.forms[0].selcat.value="";
						document.forms[0].txtperapp_childnum.value="";	
						document.forms[0].sel_shg.value="n";	

						document.all.agr_typefarmer.style.display="inline";// Type of Farmer
						document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

						//document.all.agr_measurementtype.style.display="inline";// Measurement Type
						//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

						document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
						document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

						document.all.agr_whethershg.style.display="none";// Whether SHG 
						document.all.agr_shgtypes.style.display="none";   // sel Whether SHG

						document.all.jlg_groupname.style.display="inline"; // JLG Group Name
						document.all.shg_groupname.style.display="none"; //SHG Group Name

						document.all.agr_whethershg.style.display="none";// Whether SHG 
						document.all.agr_shgtypes.style.display="none";   // sel Whether SHG

						document.all.txtshg_name.style.display="inline";   //  shg/jlg text box 

						document.all.agr_village.style.display="inline";// Village/block 
						document.all.agr_villageType.style.display="inline";   // Village/block txt
						document.all.txtshg_village.style.display="inline";   // Village/block txt box
					}
					
					else
					{					
						document.all.farm8.style.visibility="visible";
						document.all.farm8.style.position="relative";
						
						document.all.farm9.style.visibility="visible";
						document.all.farm9.style.position="relative";
						
						document.all.farm10.style.visibility="visible";
						document.all.farm10.style.position="relative";
						
						document.all.farm11.style.visibility="visible";
						document.all.farm11.style.position="relative";
						
						document.all.farm12.style.visibility="visible";
						document.all.farm12.style.position="relative";
						
						document.all.farm13.style.visibility="visible";
						document.all.farm13.style.position="relative";
						
						document.all.farm14.style.visibility="visible";
						document.all.farm14.style.position="relative";
						
						document.all.farm15.style.visibility="visible";
						document.all.farm15.style.position="relative";
						
						document.all.farm16.style.visibility="visible";
						document.all.farm16.style.position="relative";
						
						document.all.farm17.style.visibility="visible";
						document.all.farm17.style.position="relative";
						
						document.all.farm18.style.visibility="visible";
						document.all.farm18.style.position="relative";
						
						document.all.farm19.style.visibility="visible";
						document.all.farm19.style.position="relative";
						
						document.all.farm20.style.visibility="visible";
						document.all.farm20.style.position="relative";
						
						document.all.farm21.style.visibility="visible";
						document.all.farm21.style.position="relative";
						
						document.all.farm22.style.visibility="visible";
						document.all.farm22.style.position="relative";
						
					//	document.all.farm23.style.visibility="visible";
					//	document.all.farm23.style.position="relative";
						
						document.all.farm24.style.visibility="hidden";
						document.all.farm24.style.position="absolute";

						document.all.legalheiers.style.display="inline"; //
						
						document.all.farm25.style.visibility="visible";
						document.all.farm25.style.position="relative";
						
						document.all.farm26.style.visibility="hidden";
						document.all.farm26.style.position="absolute";

					    document.forms[0].txtshg_village.value=""; // village txt box
					    document.forms[0].txtshg_name.value="";	// shg/jlg text box 	
						document.all.jlg_groupname.style.display="none";					

						document.all.agr_village.style.display="none";// Village/block 
						document.all.agr_villageType.style.display="none";   // Village/block txt

						document.all.agr_whethershg.style.display="inline";// Whether SHG
						document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG

						document.all.txtshg_name.style.display="none"; // 	
					}
				}
		}else {		
			var varProfession= document.forms[0].rdoperapp_employment[document.forms[0].rdoperapp_employment.options.selectedIndex].value;
				if(varEmployed=="7")
			{
			document.all.farm26.style.visibility="hidden";
			document.all.farm26.style.position="absolute";
					
			document.all.agr_typefarmer.style.display="inline";// Type of Farmer
			document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

			//document.all.agr_measurementtype.style.display="inline";// Measurement Type
			//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

			document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
			document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

			document.all.agr_whethershg.style.display="inline";// Whether SHG 
			document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG		

			document.all.shg_groupname.style.display="none"; //Whether SHG
			document.all.jlg_groupname.style.display="none"; // Whether JLG

			document.all.agr_village.style.display="none"; //Village/block 
			document.all.agr_villageType.style.display="none"; // Village/block txt
			document.all.txtshg_name.style.display="none"; 	

			document.all.farm24.style.visibility="hidden";
			document.all.farm24.style.position="absolute";
			
			document.all.legalheiers.style.display="inline"; 	//Legal Heirs
			
			}else {						
				document.all.farm26.style.visibility="hidden";
				document.all.farm26.style.position="absolute";

				document.all.farm24.style.visibility="hidden"; // Member Details
				document.all.farm24.style.position="absolute";  // Member Details		

				document.all.legalheiers.style.display="inline"; //
				
				document.all.agr_typefarmer.style.display="none"; //Type of Farmer
				document.all.agr_farmactivity.style.display="none"; // sel Type of Farmer

				//document.all.agr_measurementtype.style.display="none"; //Measurement Type
				//document.all.agr_measurementactivity.style.display="none"; // sel Measurement Type

				document.all.agr_whethershg.style.display="none"; //Whether SHG
				document.all.agr_shgtypes.style.display="none"; // sel Whether SHG

				document.all.agr_whetherjlg.style.display="none"; //Whether JLG
				document.all.agr_jlgtypes.style.display="none"; // sel Whether JLG

				document.all.shg_groupname.style.display="none"; //shg_groupname
				document.all.jlg_groupname.style.display="none"; // jlg_groupname

				document.all.agr_village.style.display="none"; //Village/block 
				document.all.agr_villageType.style.display="none"; // Village/block txt
				document.all.txtshg_name.style.display="none"; 
				}

				if(varProfession=="7"){ 								
					document.all.agr_typefarmer.style.display="inline";// Type of Farmer
					document.all.agr_farmactivity.style.display="inline";   // sel Type of Farmer

					//document.all.agr_measurementtype.style.display="inline";// Measurement Type
					//document.all.agr_measurementactivity.style.display="inline";   // sel Measurement Type				

					document.all.agr_whetherjlg.style.display="inline";// Whether JLG 
					document.all.agr_jlgtypes.style.display="inline";   // sel Whether JLG

					document.all.agr_whethershg.style.display="inline";// Whether SHG 
					document.all.agr_shgtypes.style.display="inline";   // sel Whether SHG				

					document.all.shg_groupname.style.display="none"; //Whether SHG
					document.all.jlg_groupname.style.display="none"; // Whether JLG

					document.all.agr_village.style.display="none"; //Village/block 
					document.all.agr_villageType.style.display="none"; // Village/block txt
					document.all.txtshg_name.style.display="none"; 
				}
			}
		
	}
		
	
}

function ShowAgrivalue()
{
	varHid_Modtype="Retail";
	
	if(varHid_Modtype=="Retail")
	{		
		if(varEmployed!="7")
		{						
		document.all.farm26.style.visibility="hidden";
		document.all.farm26.style.position="absolute";

		document.all.agr_typefarmer.style.display="none"; //Type of Farmer
		document.all.agr_farmactivity.style.display="none"; // sel Type of Farmer

		//document.all.agr_measurementtype.style.display="none"; //Measurement Type
		//document.all.agr_measurementactivity.style.display="none"; // sel Measurement Type

		document.all.agr_whethershg.style.display="none"; //Whether SHG
		document.all.agr_shgtypes.style.display="none"; // sel Whether SHG

		document.all.agr_whetherjlg.style.display="none"; //Whether JLG
		document.all.agr_jlgtypes.style.display="none"; // sel Whether JLG		
		
		}else {			
			document.all.agr_typefarmer.style.display="none"; //Type of Farmer
			document.all.agr_farmactivity.style.display="none"; // sel Type of Farmer

			//document.all.agr_measurementtype.style.display="none"; //Measurement Type
			//document.all.agr_measurementactivity.style.display="none"; // sel Measurement Type

			document.all.agr_whethershg.style.display="none"; //Whether SHG
			document.all.agr_shgtypes.style.display="none"; // sel Whether SHG

			document.all.agr_whetherjlg.style.display="none"; //Whether JLG
			document.all.agr_jlgtypes.style.display="none"; // sel Whether JLG				
		}		
	}			
}

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
	var CurrMon=parseInt(CurrbirthMM)-parseInt(birthMM);
	
	if(document.forms[0].dob.value=="")
	{
  		          
	}
	else
	{
		if(CurrMon==0)
		{
			CurrMon=0;
		}  
		if(CurrbirthMM > birthMM)
		{
			CurrMon = 0;
		  	CurrMon=parseInt(CurrbirthMM)-parseInt(birthMM);
		  	
		}
		if(CurrbirthMM < birthMM)
		{
			CurrMon = 0;
			CurrMon = parseFloat(birthMM)-parseFloat(CurrbirthMM);
			CurrYear=Math.round(CurrYear)-1;
			CurrMon=  12 - CurrMon;
			
		}	
		document.forms[0].age.value =CurrYear;  
  		//if(CurrYear<=18)
  		//{
 			
  		//}
 	} 
}
function calcAge()
{
	 var dateString=document.forms[0].txtperapp_dob.value;
	 var currdate='<%=Helper.getCurrentDateTime()%>';     
	 
		 if(dateString!=="")
		 {
		    var today = new Date(currdate.substring(6,10),
		    		currdate.substring(3,5)-1,
		    		currdate.substring(0,2));

		   // var yearNow = today.getYear();
		    var yearNow  = currdate.substring(6,10);
		    var monthNow = today.getMonth();
		    var dateNow = today.getDate();

		    var dob = new Date(dateString.substring(6,10),
		                            dateString.substring(3,5)-1,
		                            dateString.substring(0,2));

		    var yearDob = dateString.substring(6,10);
		    var monthDob = dob.getMonth();
		    var dateDob = dob.getDate();
            
		    yearAge = yearNow - eval(yearDob);

		    if (monthNow >= monthDob)
		        var monthAge = monthNow - monthDob;
		    else {
		        yearAge = yearAge-1;
		        var monthAge = 12 + monthNow -monthDob;
		    }

		    if (dateNow >= dateDob)
		        var dateAge = dateNow - dateDob;
		    else {
		        monthAge--;
		        var dateAge = 31 + dateNow - dateDob;

		        if (monthAge < 0) {
		            monthAge = 11;
		            yearAge=yearAge-1;
		        }
		    }

		   // document.forms[0].txtperapp_age.value = yearAge;


		   //// alert("======="+document.forms[0].age.value);
		    
		   // document.forms[0].txt_months.value = monthAge;
		   // document.forms[0].txt_days.value = dateAge; 
		 }
	 
	 // var curdate=new Date(currdate); 
	 //var dob= new Date(dateobj);	
}
//end 

function showProfession()
{	
	varProfession= document.forms[0].rdoperapp_employment[document.forms[0].rdoperapp_employment.options.selectedIndex].value;

	if(varProfession!="")
		{
			if(varProfession.toUpperCase()!="4")
			{	document.all.prof1.style.visibility="hidden";
				document.all.prof2.style.visibility="hidden";
			}
			else
			{
				document.all.prof1.style.visibility="visible";
				document.all.prof2.style.visibility="visible";
			}
			
			if(varProfession.toUpperCase()!="5"  && varProfession.toUpperCase()!="14")
			{	document.all.pension1.style.visibility="hidden";
				//document.all.pension2.style.visibility="hidden";
			}
			else
			{
				document.all.pension1.style.visibility="visible";
				//document.all.pension2.style.visibility="visible";
				document.forms[0].pensionerage.focus();
				return false;
			}
			
		}

		if(document.forms[0].rdoperapp_employment.selectedIndex==3)
		{
		document.forms[0].selbuss.length=1;
	//	document.forms[0].selbuss.options[0].text= "No";
	//	document.forms[0].selbuss.options[0].value= "0";
		document.forms[0].selbuss.options[0].text= "Yes";
		document.forms[0].selbuss.options[0].value= "1";
		}
		else
		{
		document.forms[0].selbuss.length=1;
		document.forms[0].selbuss.options[0].text= "No";
		document.forms[0].selbuss.options[0].value= "0";
		}
		
		if(varProfession!="5")
		{
			document.forms[0].pensionerage.value="";
		}
		
}
function callEXPERIANPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getExperianPageDetails";
	document.forms[0].action=appURL+"action/ExperianReport.jsp?applnt=P";
	document.forms[0].submit();	
		
}
function callCRIFPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getCRIFHighMark";
	document.forms[0].action=appURL+"action/criffReports.jsp";
	document.forms[0].submit();
}
function callEquifaxPage()
{
	document.forms[0].hidBeanId.value="cibilInterface";
	document.forms[0].hidBeanGetMethod.value="getEquifaxPageDetails";
	document.forms[0].action=appURL+"action/equifaxReports.jsp";
	document.forms[0].submit();
}
function showSHGJLGforcust()
{
	var varcustcat=document.forms[0].txt_subconsti.value;
	if(varcustcat!="")
		{
			if(varcustcat=="SHG")
			{
				document.forms[0].sel_shg.value=varPERAPP_SHG;	
				document.all.agr_whethershg.style.display = "table-row";   // Whether SHG
				document.all.agr_shgtypes.style.display = "table-row"; // sel Whether SHG
				document.all.shg_groupname.style.display="table-row"; //SHG Group Name
				document.all.txtshg_name.style.display="table-row";   //  shg/jlg text box 
				document.all.agr_village.style.display="table-row";// Village/block 
				document.all.agr_villageType.style.display="table-row";   // Village/block txt
				document.all.txtshg_village.style.display="table-row";   // Village/block txt box
				
				document.all.agr_whetherjlg.style.display="none";// Whether JLG 
				document.all.agr_jlgtypes.style.display="none";   // sel Whether JLG				
				document.all.jlg_groupname.style.display="none"; //JLG Group Name

			
				
			}else if(varcustcat=="JLG")
			{	
				document.forms[0].sel_jlg.value=varJLG;										
				document.all.agr_whetherjlg.style.display = "table-row";   // Whether JLG
				document.all.agr_jlgtypes.style.display = "table-row"; // sel Whether JLG
				document.all.jlg_groupname.style.display="table-row"; //JLG Group Name				
			}
			else
			{
				document.all.agr_whethershg.style.display = "none";   // Whether SHG
				document.all.agr_shgtypes.style.display = "none"; // sel Whether SHG

				document.all.agr_whetherjlg.style.display = "none";   // Whether JLG
				document.all.agr_jlgtypes.style.display = "none"; // sel Whether JLG 

				document.all.shg_groupname.style.display = "none";   // SHG Group Name
				document.all.jlg_groupname.style.display = "none";   // JLG Group Name
				document.all.txtshg_name.style.display = "none"; // shg/jlg text box 

				document.all.agr_village.style.display = "none";   // Village/Block Name
				document.all.agr_villageType.style.display = "none";   // Village/Block Name
				document.all.txtshg_village.style.display = "none"; // shg/jlg text box 
				
				document.forms[0].sel_shg.value = "s";  // making SHG as select
				document.forms[0].sel_jlg.value = "s";  // making JLG as select
			}
		}
}
function showProfession1()
{	
	if(varCustCat != "C")
	{
	var varProfession= document.forms[0].rdoperapp_employment[document.forms[0].rdoperapp_employment.options.selectedIndex].value;
	var varEmpl = "";		
	if(varProfession!="")
		{
			 if(varProfession=="7")
			{	
			 
				//agriculture details 
				document.all.agr_typefarmer.style.display = "inline";   // Type of Farmer
				document.all.agr_farmactivity.style.display = "inline"; // sel Type of Farmer

				//document.all.agr_measurementtype.style.display = "inline";   // Measurement Type
				//document.all.agr_measurementactivity.style.display = "inline"; // sel Measurement Type

				document.all.agr_whethershg.style.display = "inline";   // Whether SHG
				document.all.agr_shgtypes.style.display = "inline"; // sel Whether SHG

				document.all.agr_whetherjlg.style.display = "inline";   // Whether JLG
				document.all.agr_jlgtypes.style.display = "inline"; // sel Whether JLG
				
				var varSHGJLG ="";
				if(varPERAPP_SHG=='y')
					varSHGJLG ="SHG";
				else if (varJLG=='y')
					varSHGJLG ="JLG";				
				showSHGJLG(varSHGJLG);
			}else
			{											
				//agriculture details 
				 document.all.agr_typefarmer.style.display = "none";  // Type of Farmer
				document.all.agr_farmactivity.style.display = "none"; // sel Type of Farmer

				//document.all.agr_measurementtype.style.display = "none";   // Measurement Type
				//document.all.agr_measurementactivity.style.display = "none"; // sel Measurement Type

				document.all.agr_whethershg.style.display = "none";   // Whether SHG
				document.all.agr_shgtypes.style.display = "none"; // sel Whether SHG

				document.all.agr_whetherjlg.style.display = "none";   // Whether JLG
				document.all.agr_jlgtypes.style.display = "none"; // sel Whether JLG 

				document.all.shg_groupname.style.display = "none";   // SHG Group Name
				document.all.jlg_groupname.style.display = "none";   // JLG Group Name
				document.all.txtshg_name.style.display = "none"; // shg/jlg text box 

				document.all.agr_village.style.display = "none";   // Village/Block Name
				document.all.agr_villageType.style.display = "none";   // Village/Block Name
				document.all.txtshg_village.style.display = "none"; // shg/jlg text box 

				document.forms[0].sel_shg.value = "s";  // making SHG as select
				document.forms[0].sel_jlg.value = "s";  // making JLG as select	
			
				document.all.farm15.style.visibility="visible";  // Father's Name
				document.all.farm15.style.position="relative";  // Father's Name 
				
				document.all.farm16.style.visibility="visible";  // Father's Name txt box
				document.all.farm16.style.position="relative"; 	// Father's Name txt box						
				
				document.all.farm17.style.visibility="visible";  // Edu. Qualification
				document.all.farm17.style.position="relative";  // Edu. Qualification
				
				document.all.farm18.style.visibility="visible"; // Edu. Qualification  drop down
				document.all.farm18.style.position="relative";// Edu. Qualification  drop down

				document.all.farm21.style.visibility="visible";  //No. of Dependents
				document.all.farm21.style.position="relative"; //No. of Dependents

				document.all.farm22.style.visibility="visible"; // No. of Dependents txt box
				document.all.farm22.style.position="relative"; //No. of Dependents txt box

				document.all.farm19.style.visibility="visible";  //Category
				document.all.farm19.style.position="relative"; //Category

				document.all.farm20.style.visibility="visible";  //Category sel
				document.all.farm20.style.position="relative"; //Category sel

				document.all.farm8.style.visibility="visible";  //Spouse Details 
				document.all.farm8.style.position="relative";  // Spouse Details

				document.all.farm24.style.visibility="hidden";  //Member Details
				document.all.farm24.style.position="absolute";  // Member Details

				document.all.legalheiers.style.display = "inline"; // Legal Heirs  		


				/*if(perapp_education=="" || perapp_education=="S")
				
				{
					document.forms[0].seleducat.value="0";			//Edu. Qualification
				}
				else
				{
					//document.forms[0].seleducat.value=perapp_education;
					
				}*/	
				 	
			}
		}else {			
	}
	}
}
function doDedupecheck()
{
	  var varQryString =appURL+"action/hevpdedupecheckview.jsp?hidBeanGetMethod=getKycdedupe&hidBeanId=mastapplicant&panno="+document.forms[0].txtperapp_panno.value+"&passportno="+document.forms[0].txtperapp_passport.value+"&license="+document.forms[0].txtperapp_driving.value+"&aadhar="+document.forms[0].txtperapp_aadhar.value+"&voterid="+document.forms[0].txtperapp_spemail.value+"&appleid="+id+"&rationid="+document.forms[0].txtperapp_ration.value+"&hidRetail="+"Y";
	  var prop = "scrollbars=yes,width=1500,height=550,menubar=yes,rightclick=no";	
	  var xpos = (screen.width - 1200) / 2;
	  var ypos = (screen.height - 550) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
	  window.open(varQryString,'title',prop);
}
function allowAlphabetsOne(evt)
{
	evt=(evt) ? evt : window.event;
	var charCode =(evt.which) ? evt.which : evt.keyCode;
	if(!((charCode>64 && charCode<91) || (charCode>96 && charCode<123)))
	{
		return false;
	}
	return true;
}

function CallEligible360Degree(){
	var varcbsid = document.forms[0].txtperapp_cbsid.value;
	var id = "<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>";
	var uname = document.forms[0].txtperapp_fname.value;
	var varQryString = appURL+"action/agri_Exposure.jsp?hidBeanGetMethod=getAgri360DegreeViewAPI&hidBeanId=mastapplicant&txt_cbsid="+varcbsid+"&strLapsId="+id+"&uname="+document.forms[0].txtperapp_fname.value;
	var title = "AccountDetails";
	var prop = "scrollbars=yes,width=850,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(varQryString,title,prop);
}

function CTypeCustomer(){
	if(varCustCat == "C"){
		document.all.farm13.style.display="none";
		document.all.farm14.style.display="none";
		document.all.emp1.style.display="none";
		document.all.emp2.style.display="none";
		document.all.id_Residence1.style.display="none";
		document.all.id_Residence2.style.display="none";
		document.all.farm15.style.display="none";
		document.all.farm16.style.display="none";
		document.all.child1.style.display="none";
		document.all.child2.style.display="none";
		document.all.farm19.style.display="none";
		document.all.farm20.style.display="none";
		document.all.farm21.style.display="none";
		document.all.farm22.style.display="none";
		document.all.id_kyc1.style.display="table-row";
		document.all.id_kyc2.style.display="table-row";
		document.all.id_kyc3.style.display="table-row";
		document.all.id_kyc4.style.display="table-row";
		document.all.id_kyc5.style.display="table-row";
		document.all.id_kyc6.style.display="table-row";
		document.all.id_kyc7.style.display="table-row";
		document.all.id_kyc8.style.display="table-row";
		document.all.id_kyc9.style.display="table-row";
		document.all.id_kyc10.style.display="table-row";
		document.all.id_Driving.style.display="none";
		document.all.id_Driving1.style.display="none";
		document.all.id_Voter.style.display="none";
		document.all.id_Voter1.style.display="none";
		document.all.id_Aadhar.style.display="none";
		document.all.id_Aadhar1.style.display="none";
		document.all.id_Ration.style.display="none";
		document.all.id_Ration1.style.display="none";
		document.all.farm11.style.display="none";
		document.all.farm12.style.display="none";
		document.all.farm17.style.display="none";
		document.all.farm18.style.display="none";
		document.all.id_Mobility.style.display="none";
		document.all.id_Mobility1.style.display="none";
		document.all.id_Canara.style.display="none";
		document.all.id_Canara1.style.display="none";
		document.all.id_Passport.style.display="none";
		document.all.id_Passport1.style.display="none";
		document.all.id_Passport2.style.display="none";
		document.all.id_Passport3.style.display="none";
		document.all.id_Close.style.display="none";
		document.all.id_Close1.style.display="none";
	}
	if(varCustCat != "C"){
	document.all.id_kyc1.style.display="none";
	document.all.id_kyc2.style.display="none";
	document.all.id_kyc3.style.display="none";
	document.all.id_kyc4.style.display="none";
	document.all.id_kyc5.style.display="none";
	document.all.id_kyc6.style.display="none";
	document.all.id_kyc7.style.display="none";
	document.all.id_kyc8.style.display="none";
	document.all.id_kyc9.style.display="none";
	document.all.id_kyc10.style.display="none";
	}
}

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body text="#000000" vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad();showGPAholder();calcAge();showProfession();showProfession1();show_shgvalue();CTypeCustomer();marrystatus();custcategory();ischairman();custedustatus();custemplystatus();perresstatus();empmobility();relatstatus();custrelation();"	class="bgcolor">
<jsp:include page="../share/help.jsp" flush="true">
</jsp:include>
<form name="appform" method="post" action="">

<!-- ************************************* FOR CANARA ************************************************ -->
<%if(strCanaraSyndBank.equals("C")){ %>

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="outertablecolor"><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b><i>Home -&gt; <%=PageName %> </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile Search </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font>
		</i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile </i></b></font><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>NP_Demographics</i></b></font></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td colspan="2" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>

				<td width="20%" class="tabactive" align="center"><b><font size="1"
					face="MS Sans Serif" color="#FFFFFF">NP_Demographics</font></b></td>
					          
					<%
				//	if((!Helper.correctNull((String)hshValues.get("perapp_employment")).equals("10")) && (!Helper.correctNull((String)hshValues.get("perapp_employment")).equals("7"))){
					if((!Helper.correctNull((String)hshValues.get("perapp_employment")).equals("10"))){%>
					
				<td width="20%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callIncomeExpenses()"
					class="blackfont">NP_Income &amp; Deduction</a></font></b></td>
				<% if(!strCustCat.equalsIgnoreCase("C")){%>
				<td width="20%" id="employertdbtn1" align="center"
					class="tabinactive"><b><font size="1" face="ms sans serif"><a
					href="JavaScript:callEmployer()" class="blackfont">NP_Employment
				Details </a></font></b></td>
				<%} %>
				<% }%>
				<!--
				<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCBIL()"
					class="blackfont">TransUnion CIBIL</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEXPERIANPage()"
					class="blackfont">Experian</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCRIFPage()"
					class="blackfont">CRIFF Highmark</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEquifaxPage()"
					class="blackfont">Equifax</a></font></b></td>-->
					
				<td class="tabactive" align="center"> 
					<b><font size="1" face="ms sans serif">Profile Status &nbsp; : &nbsp;<%=tempProfile%></font></b>
					</td>
				  <!--<td width="25%" id="firmdetails" align="center" class="tabinactive"><b><font
					size="2" face="ms sans serif"><a
					href="JavaScript:callFirmDetails()" class="blackfont"><font
					size="1"> Firm/Company Details </font></a></font></b></td>-->
				
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
	<td>				
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
                     
				<table width="100%" border="1" cellspacing="0" cellpadding="1"
					bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr align="center">
						<td width="18%"><font size="1" face="MS Sans Serif">Applicant ID</font></td>
						<td width="15%"><font size="1" face="MS Sans Serif">Title</font></td>
						<td width="22%"><font size="1" face="MS Sans Serif">First Name </font></td>
						<td width="23%"><font size="1" face="MS Sans Serif">Middle Name </font></td>
						<td width="22%"><font size="1" face="MS Sans Serif">Last Name </font></td>
					</tr>
					<tr align="center">
						<td width="18%"><font size="1" face="MS Sans Serif"><input
							type="text" name="txtperapp_cbsid" size="12" maxlength="9"
							tabindex="1"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>"
							class="cbsstyle" onKeyPress="allowInteger()" readOnly></font></td>
						<td width="15%"><font size="1" face="MS Sans Serif"> <input
							type="text" name="txtperapp_apptitle" size="4" maxlength="4"
							tabindex="2" readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>"
							class="cbsstyle"> </font></td>
						<td width="22%">
						<p><font size="1" face="MS Sans Serif"> <input type="text"
							name="txtperapp_fname" size="25" maxlength="20" tabindex="3"
							readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>"
							class="cbsstyle"> </font></p>
						</td>
						<td width="23%">
						<p><font size="1" face="MS Sans Serif"> <input type="text"
							name="txtperapp_mname" size="20" maxlength="20" tabindex="4"
							readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_mname"))%> "
							class="cbsstyle"> </font></p>
						</td>
						<td width="22%"><font size="1" face="MS Sans Serif"> <input
							type="text" name="txtperapp_lname" size="20" maxlength="20"
							tabindex="5" readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_lname"))%>"
							class="cbsstyle"> </font></td>
					</tr>
					<tr>

						<td valign="top" colspan="5">
						<!-- new div -->
						
						<table width="100%" border="1" cellspacing="0" cellpadding="0">
							<tr>
								<td width="30%" valign="top">
								  
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										
                                <td width="30%" height="277" valign="top"> 
                                  <!-- 	<div class="cellContainer"> 
									-->
<table width="100%" border="0" cellspacing="0" cellpadding="5">
											<!-- <tr>
												<td width="50%"><font size="1" face="MS Sans Serif">LAPS ID</font></td>
												<td><input
							type="text" name="txtperapp_appid" size="12" maxlength="9"
							tabindex="1"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"
							class="cbsstyle" onKeyPress="allowInteger()" readOnly><input type="text"
							name="txt_perappid" size="5" readOnly
							value="<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
							onKeyPress="allowNumber(this)" style="visibility: hidden"></td>
											</tr>  -->
								
<tr>
<td>&nbsp;</td>
</tr>
<tr>
									<td align="right"><font size="2" face="MS Sans Serif">E-mail :&nbsp;</font></td>
												<td><font size="2" face="MS Sans Serif"> <input type="text"
													name="txtperapp_email" size="25" maxlength="50"
													tabindex="16"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_email"))%> "
													onblur="isEmailAddr(document.forms[0].txtperapp_email.value,document.forms[0].txtperapp_email)">
												</font></td>
</tr>
		
	
								<tr>
									<td align="right" id='farm25' width="50%" nowrap='nowrap'>
										<font size="2" face="MS Sans Serif">Date of Birth/Formation(DD/MM/YYYY)</font>
										<b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
										<font size="2" face="MS Sans Serif"> :&nbsp;</font>
									</td>
									
													
												<td valign="top"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_dob" size="12" maxlength="10"
													tabindex="7"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>"
													onBlur="checkDate(this);checkFileDate(this);calcAge();"> <!-- dateCheck(this) --><font
													size="2"></font> </font> <a href="#"
													onClick="callCalender()" title="Click to view calender"
													border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></td>
									<td align="right" id='farm9' valign="top" width="10%" align="left">
													<font size="2" face="MS Sans Serif">Age :&nbsp;</font><b>
													<font size="2" face="MS Sans Serif" color="#FF0000"></font></b></td>
													<td id='farm10' valign="top" align="left"><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_age" size="5" maxlength="3"
													value="" readonly="readonly"> </font><font size="2"
													face="MS Sans Serif">&nbsp; </font></td>
													<td id='farm26' nowrap='nowrap' width="50%" style="visibility: hidden;position: absolute;"><font size="1" face="MS Sans Serif">Date of
												Formation(DD/MM/YYYY)</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b>
												
												</td>
											</tr>
											<tr>
												<td align="right" width="50%" id='farm11'><font size="2" face="MS Sans Serif">Sex :&nbsp;</font></td>

												<td id='farm12' colspan="3"><font size="2" face="MS Sans Serif"> <input
													type="text" name="choperapp_sex" size="8" maxlength="10"
													tabindex="7"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>"
													class="cbsstyle" readOnly> <!-- <select name="choperapp_sex" tabindex="7" OnChange="checkProfession()">
                                          <option value=""><font size="2" face="MS Sans Serif">--Select--</font></option>
                                          <option value="M"><font size="2" face="MS Sans Serif">Male</font></option>
                                          <option value="F"><font size="2" face="MS Sans Serif">Female</font></option>
                                        </select> --> </font></td>
											</tr>
											<tr>
												<td width="50%" id='farm13' align="right"><font size="2" face="MS Sans Serif">Marital
												Status :&nbsp;</font></td>
												<td  id='farm14' colspan="3"><font size="2" face="MS Sans Serif"> 
												<!-- <input type="text" name="choperapp_marstat" size="8" maxlength="10" tabindex="7" value = "<%//=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>" class="cbsstyle"  readOnly> -->
												<select name="choperapp_marstat" tabindex="8"
													OnChange="showNumberChildren()">
													<!--  <option value="0">----Select----</option>
													<option value="1">Single</option>
													<option value="2">Married</option>
													<option value="3">Divorced</option>
													<option value="4">Widowed</option>
													<option value="5">Separated</option>-->
																<!-- sathiya -->
										 <option value="0" selected> <----Select----> 
                                          </option>
												 	
                                               <lapschoice:StaticDataTag  apptype="8"/>													</select> </font>
													<font size="2" face="MS Sans Serif">&nbsp;</font></td>
											</tr>
											<tr>
												<td width="50%" align="right" id="emp1"><font size="2" face="MS Sans Serif">Employment
												Status</font> <b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
												<font size="2" face="MS Sans Serif"> :&nbsp;</font>
												</td>
												<td id="emp2" colspan="3"><font size="2" face="MS Sans Serif"> <select
													name="rdoperapp_employment" tabindex="9"
													onchange="showProfession();showProfession1();">
													<!--  
													<option value="0">---- Select ----</option>
													<option value="1">Salaried in approved Company</option>
													<option value="2">Salaried in Private Sector</option>
												<option value="3">Syndicate Staff</option> 
													<option value="4">Professional</option>
													<option value="5">Pensioner</option>
													<option value="6">Self Employed</option>
													<option value="7">Agriculturist</option>
													<option value="8">Business</option>
													<!-- sathiya -->
											<!--  	<option value="9">Housewife</option>
													<option value="10">Student</option> -->
													<!-- sathiya -->
										 <option value="0" Selected>----Select---- </option>
												 	
                                               <lapschoice:StaticDataTag  apptype="7"/>									
                                               				</select> </font>
													<font size="2" face="MS Sans Serif">&nbsp;</font></td>
												
											</tr>
											<% if(strCustCat.equalsIgnoreCase("C")){%>
											<tr align="left" id="non_constit">
												<td width="15%" align="right" ><font size="2"
													face="MS Sans Serif">Non Individual Sub Constitution<font size="1"
													face="MS Sans Serif" color="#FF0000">*</font> </font></td>
												<td width="15%" align="left" ><font size="1"
													face="MS Sans Serif"> <select name="txt_subconsti" onchange="showSHGJLGforcust()"
													tabindex="18">
													<option value="">---Select---</option>
													<lapschoice:StaticDataTag apptype="178" />
												</select> </font></td>
												<td width="10%">&nbsp;</td> 
												<td width="15%" align="left" ><font size="1"
													face="MS Sans Serif">&nbsp; </font></td>
												<td width="15%" align="left" >&nbsp;</td>
											</tr>
											<%} %>
											 	<tr >
									<td width="35%" id="agr_typefarmer" align="right" >Type of Farmer :&nbsp;</td>
											<td colspan="3" id="agr_farmactivity" ><select
												name="sel_farmactivity" tabindex="13">
												<option value="0" Selected>---- Select ----</option>
												<option value="1">Agriculture Labor</option>
												<option value="2">Marginal Farmer</option>
												<option value="3">Other Farmer</option>
												<option value="4">Others</option>
												<option value="5">Share Cropper</option>
												<option value="6">Small Farmer</option>
												<option value="7">Tenant Farmer</option>
												<option value="8">Orallesse</option>
											</select></td>
										</tr>
<!--										<tr >-->
<!--										<td width="35%" id="agr_measurementtype" >Measurement Type</td>-->
<!--										<td colspan="3" id="agr_measurementactivity" ><select-->
<!--												name="sel_measurementtype" tabindex="13">-->
<!--												<option value="0" Selected>---- Select ----</option>-->
<!--												<option value="1">Cents</option>-->
<!--												<option value="2">Guntas</option>-->
<!--											</select></td>-->
<!--										</tr>-->
										<tr >
										<td width="35%" id="agr_whethershg" align="right">Whether SHG :&nbsp;</td>
										<td colspan="3" id="agr_shgtypes" ><select
												name="sel_shg" tabindex="13" OnChange="showSHGJLG('SHG');">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></td>
										</tr>
										<tr >
										<td width="35%" id="agr_whetherjlg" align="right">Whether JLG :&nbsp;</td>
										<td colspan="3" id="agr_jlgtypes" ><select
												name="sel_jlg" tabindex="13" OnChange="showSHGJLG('JLG');">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></td>
										</tr>
										
											<tr >
										<td width="35%" id="shg_groupname"  align="right">SHG Group Name :&nbsp;</td>
										<td width="35%" id="jlg_groupname" align="right">JLG Group Name :&nbsp;</td>
										
										<td colspan="3" valign="top"><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtshg_name" onKeyPress="return allowAlphabetsSpaceOne(event)" size="38" maxlength="100"
													tabindex="14"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGNAME"))%>"
													> </font></td>
										
										</tr>
										<tr >
										<td width="35%" id="agr_village" align="right">Village/Block Name :&nbsp;</td>
										<td colspan="3" valign="top" id="agr_villageType" ><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtshg_village" onKeyPress="return allowAlphabetsSpaceOne(event)" size="38" maxlength="100"
													tabindex="15"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGVILLAGE"))%>"
													> </font></td>
										</tr>
										
											
											<tr>
												<td width="50%" id="prof1" align="right"><font size="2"
													face="MS Sans Serif">Type of Profession :&nbsp;</font></td>
												<td colspan="3" id="prof2"><font size="2"
													face="MS Sans Serif"> <select name="rdoperapp_professional"
													tabindex="12">
													<option value="0" selected>---- Select ----</option>
													<option value="1">Doctor</option>
													<option value="2">Architect</option>
													<option value="3">CA</option>
													<option value="4">MBA</option>
													<option value="5">Engineer</option>
													<option value="6">Lawyer</option>
													<option value="7">Others</option>
												</select> </font> <font size="2" face="MS Sans Serif">&nbsp;
												</font></td>
											</tr>
											<tr id="pension1">
												<td width="50%" align="right"><font size="2" face="MS Sans Serif">Pensioner Age</font><b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
												<font size="2" face="MS Sans Serif"> :&nbsp;</font></td>
												<td colspan="3">
													
												<input type="text" name="pensionerage" onkeypress="allowInteger()" maxlength="2" tabindex="13" value="<%=Helper.correctNull((String)hshValues.get("pensionerage")) %>">	
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>

								<td width="62%" valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										
                                <td height="277" valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="5">
											<tr>
												<td><font size="2" face="MS Sans Serif"><b>KYC </b></font></td>
											</tr>
											<tr>
												<td align="right" width="20%">
												<font size="2" face="MS Sans Serif">PAN /GIR No. :&nbsp;</font>
												</td>
												<td>
												<font size="2" face="MS Sans Serif">
												<input type="text" name="txtperapp_panno" size="12" maxlength="10"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_panno"))%>" 
													class="cbsstyle" readOnly onKeyPress="allowAlpaNumeric()"> </font>
												</td>
												<td align="right" width="20%" id="id_kyc1">
												<font size="2" face="MS Sans Serif">CIN Number :&nbsp;</font>
												</td>
												<td id="id_kyc2"><font size="1" face="MS Sans Serif"> <input type="text"
								                     name="txt_cinid" maxlength="21" onkeypress="return allowAlphaNumericOne(event);" onBlur="validateCIN(this);"
									                 value="<%=Helper.correctNull((String) hshValues.get("MORT_CIN_ID"))%>" ></font>
												</td>
											</tr><tr>
												<td align="right" width="20%" id="id_Driving">
												<font size="2" face="MS Sans Serif">Driving licence Number :&nbsp;</font>
												</td><td id="id_Driving1">
													<input type="text" name="txtperapp_driving"
													size="15" maxlength="10" tabindex="21" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DL"))%>" class="cbsstyle" readOnly>
												</td>
												<td align="right" width="20%" id="id_kyc3">
												<font size="2" face="MS Sans Serif">GST Number :&nbsp;</font>
												</td>
												<td id="id_kyc4">
												<font size="2" face="MS Sans Serif">
												<font size="1" face="MS Sans Serif"> <input type="text"
								                 name="txt_gstnumber" maxlength="15"  onkeypress="return allowAlphaNumericOne(event);" 
								                 onBlur="validateGST(this);" value="<%=Helper.correctNull((String) hshValues.get("MORT_GST"))%>">
							                            </font>
												</td>
											</tr>
											<tr>
												
												<td align="right" width="20%" id="id_Voter"><font size="2" face="MS Sans Serif"> Voter Id :&nbsp;</font>
												</td><td id="id_Voter1">
												<input type="text" name="txtperapp_spemail"
													size="15" maxlength="10" tabindex="18" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseemail"))%>" class="cbsstyle" readOnly><!--onblur="isEmailAddr(document.forms[0].txtperapp_spemail.value,document.forms[0].txtperapp_spemail)" -->
												</td>
												<td align="right" width="20%" id="id_kyc5">
												<font size="2" face="MS Sans Serif">CRN Number :&nbsp;</font>
												</td>
												<td id="id_kyc6">
												<font size="2" face="MS Sans Serif">
												<input type="text" name="txt_crnid" maxlength="30" onkeypress="return allowAlphaNumericOne(event);" 
												onBlur="validateCRN(this);" value="<%=Helper.correctNull((String) hshValues.get("perapp_crn"))%>" > </font>
												</td>
											</tr><tr>	
												<td align="right" width="20%" id="id_Aadhar"><font size="2" face="MS Sans Serif"> Aadhar No. :&nbsp;</font>
												</td><td  id="id_Aadhar1">
												<input type="text" name="txtperapp_aadhar"
													size="15" maxlength="10" tabindex="19" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_AADHARNO"))%>" class="cbsstyle" readOnly>
												</td>
												<td align="right" width="20%" id="id_kyc7">
												<font size="2" face="MS Sans Serif">TIN Number :&nbsp;</font>
												</td>
												<td id="id_kyc8"><font size="1" face="MS Sans Serif"> <input type="text"
								                    name="txt_tinnumber" maxlength="12"  onkeypress="return allowAlphaNumericOne(event);" onBlur="validateTIN(this);"
								                    value="<%=Helper.correctNull((String) hshValues.get("perapp_tin"))%>">
							</font>
												</td>	
											</tr>
											<tr>
												<td align="right" width="20%" id="id_Ration"><font size="2" face="MS Sans Serif">RationCard Number :&nbsp;</font>
												
												</td><td id="id_Ration1">
													<input type="text" name="txtperapp_ration"
													size="15" maxlength="10" tabindex="20" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_rationcard"))%>" >
													</td>
												<td align="right" width="20%" id="id_kyc9">
												<font size="2" face="MS Sans Serif">Udhyog Aadhar Number :&nbsp;</font>
												</td>
												<td  id="id_kyc10">
												<font size="1" face="MS Sans Serif"> <input type="text"
								                   name="txt_udhyogid" maxlength="12" onkeypress="return allowAlphaNumericOne(event);" 
									               value="<%=Helper.correctNull((String) hshValues.get("perapp_udhyog"))%>" >
							                    </font>
												</td>	
											</tr>
											
											
											
											<tr style="visibility: hidden;position: absolute;">
													<TD ROWSPAN="4" WIDTH="30%" ><IFRAME
													SRC="<%=ApplicationParams.getAppUrl()%>action/ifrmapplicantphoto.jsp?hidBeanGetMethod=getdemographicsphoto&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
													ID="IDIFRMPH" WIDTH="160" HEIGHT="185" SCROLLING="no"
													FRAMEBORDER="0" align="top"></IFRAME>
													
													&nbsp;
												<DIV ALIGN="LEFT"><INPUT TYPE="button"
													NAME="cmdPhoto" VALUE="Get Photo" class="btn"
													ONCLICK="getPhoto()" TABINDEX="24"></DIV>
												</TD>
												<!--  <td valign="top" rowspan="4" width="20%"> 
                                        			<div align="center"><font size="2" face="MS Sans Serif"><iframe src="<%=ApplicationParams.getAppUrl()%>action/setphoto.jsp?hidDemoId=<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>" id="idfrm1" width="110" height="130" scrolling="no" frameborder=no></iframe> 
                                          				</font></div>
                                      			</td> -->
											</tr>
											
											<tr style="visibility: hidden;position: absolute;">
												<td valign="top" rowspan="3" width="27%" align="center"><iframe
												src="<%=ApplicationParams.getAppUrl()%>action/ifrmapplicantsign.jsp?hidBeanGetMethod=getdemographicssign&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
												id="idfrm1" width="200" height="80" scrolling="no"
												frameborder='no'></iframe>
												</td>									
											</tr>
											<tr style="visibility: hidden;position: absolute;">
												<td WIDTH="27%">
												<DIV ALIGN="CENTER"><INPUT TYPE="button" NAME="cmdPhoto2"
												VALUE="Get Sign" class="btn" ONCLICK="getPhoto2()"
												TABINDEX="22"></DIV>
												</td>
											</tr>
											<tr>
												
												
													
												<td></td>
												<!-- <td width="20%" align="center"> 
                                        <div align="left"><font size="2" face="MS Sans Serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                          </font> 
                                        <input type="button" name="cmdPhoto" value="Get Photo" style="width:80" class="buttoncolor" onClick = "" >
                                        </div>
                                      </td> -->
											</tr>
											
											
												
										
											</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td width="30%">
										
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1">
                                    <tr> 
                                      <td colspan="2"><font size="2" face="MS Sans Serif"><b>PERMANENT ADDRESS </b></font></td>
                                      <td colspan="4"><font size="2" face="MS Sans Serif"><b>PRESENT ADDRESS </b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="checkbox" name="percheck" onClick ="trandata()" tabindex="11" style="border: 0">
												<!--<font size="2" face="MS Sans Serif">Check to have Permanent</font>-->
												<font size="2" face="MS Sans Serif">Copy from Permanent Address</font>
									  </td>

                                      <td colspan="2" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"><b>Previous 
                                        Address</b></font></td>
                                    
                                    </tr>
                                    <tr> 
                                    	<td width="16%" align="right"><font size="2" face="MS Sans Serif">Address :&nbsp;</font></td>
                                      	<td width="34%"><font size="2" face="MS Sans Serif"> 
                                        	<input type="text" name="txtperapp_permadd1" size="30" maxlength="50" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>"
													class="cbsstyle" readOnly> </font>
                                    	</td>
                                        
                                        <td width="18%"  align="right">
												<font size="2" face="MS Sans Serif">Address [Start with S/o,D/o,W/o]</font><b>
												<font size="2" face="MS Sans Serif" color="#FF0000">*</font></b> 
												<font size="2" face="MS Sans Serif"> :&nbsp;</font>
										</td>
										<td colspan="3" valign="top"><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address1" size="38" maxlength="150"
													tabindex="11"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>"
													onKeyPress="notAllowedDouble()"> </font><font size="2"
													face="MS Sans Serif">&nbsp; </font>
										</td>
                                    
                                      <td width="12%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif">Address</font></td>
                                      <td width="30%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevadd1" size="30"
													maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>"
													onKeyPress="notAllowedDouble()">
                                        </font></td>
                                      
                                    </tr>
                                    <tr> 
                                    <td width="16%">&nbsp;</td>
                                     <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permadd2" size="30"
													maxlength="50"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd2"))%>"
													class="cbsstyle" readOnly>
                                        </font></td>
 <td width="16%"><font size="2" face="MS Sans Serif">&nbsp;</font></td>
										 <td colspan="3" valign="top"><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address2" size="38" maxlength="150"
													tabindex="12"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address2"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>

                                      <td width="12%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="30%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevadd2" size="30"
													maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevadd2"))%>"
													onKeyPress="notAllowedDouble()">
                                        </font></td>
                                     
                                     
                                    </tr>  
                                     <tr> 
                                     
                                      <td width="16%"><font size="2" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtPERAPP_PERMADD3" size="30"
													maxlength="50"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd3"))%>"
													class="cbsstyle" readOnly>
                                        </font></td>
                                       <td width="18%" align="left">												 
													<font size="2" face="MS Sans Serif">&nbsp;</font>												 
												</td>
												<td colspan="3" valign="top"><font size="2"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address3" size="38" maxlength="150"
													tabindex="12"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
                                    </tr>                                       
                                    <tr> 
                                      
                                      <td width="18%" align="right"><font size="2" face="MS Sans Serif">City :&nbsp;</font></td>
                                      <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permcity" size="18"
													maxlength="20" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>"
													class="cbsstyle" readOnly
													onKeyPress="allowAlphabets()">
                                        </font></td>

									<td width="24%" align="right"><font size="2" face="MS Sans Serif">City</font>
									<b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
									<font size="2" face="MS Sans Serif"> :&nbsp;</font>			
												</td>
												<td width="15%"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_city" size="12" maxlength="20"
													tabindex="13"
													value="<%=Helper.correctNull(
										(String)hshValues.get("perapp_city"))%>"
													onKeyPress="allowAlphabets()"> </font></td>



                                        <td width="12%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="30%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevcity" size="18"
													maxlength="20" tabindex="20"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_city"))%>"
													onKeyPress="allowAlphabets()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      
                                      <td width="16%" align="right"><font size="2" face="MS Sans Serif">State :&nbsp;</font></td>
                                      <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permstate" size="18"
													maxlength="20" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>"
													class="cbsstyle" readOnly onKeyPress="allowAlphabets()">
                                        </font></td>
                                        
                                        <td width="19%" align="right"><font size="2" face="MS Sans Serif">State</font>
                                        							<b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
                                        							<font size="2" face="MS Sans Serif"> :&nbsp;</font></td>
												<td width="22%"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_state" size="15" maxlength="20"
													tabindex="14"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>"
													onKeyPress="allowAlphabetsAndSpace()"
													onBlur="changecase(document.forms[0].txtperapp_state)">
													 <a	href="javascript:ShowStates('111')" class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px"></a> </font></td>
									
									<td width="12%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif">State</font></td>
                                      <td width="30%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevstate" size="18"
													maxlength="20" tabindex="21"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>"
													onKeyPress="allowAlphabets()"
													onBlur="changecase(document.forms[0].txtperapp_prevstate)">
                                        </font><a href="javascript:ShowStates('2')"
													class="blackfont">?</a></td>
								
								
								
                                    </tr>
                                    <tr> 
                                      
                                      <td width="16%"  align="right"><font size="2" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font>
                                      <font size="2" face="MS Sans Serif">:&nbsp;</font></td>
                                      <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permzip"))%>"
													class="cbsstyle" onKeyPress="allowInteger()" readOnly>
                                        </font></td>
                                        
                                        <td width="24%" align="right">
												<!-- <div align="left">
												-->
												<font size="2" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font>
												<font size="2" face="MS Sans Serif">:&nbsp;</font>
												<!-- </div>
												-->
												</td>
												<td width="15%"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_zip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="15"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>"
													onKeyPress="allowInteger()"> </font>
												</td>
													
                                        <td width="12%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
                                      <td width="30%" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="22"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevzip"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      
                                      <td width="16%" align="right"><font size="2" face="MS Sans Serif"> 
                                         Mobile No. :&nbsp;</font></td>
                                      <td width="34%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permphone" size="15"
													maxlength="10" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>"
													class="cbsstyle" readOnly onKeyPress="allowInteger()">
                                        </font></td>
                                        
                                        <td width="19%" align="right" nowrap="nowrap"><font size="2" face="MS Sans Serif">Mobile
												No. :&nbsp;</font></td>
												<td width="22%" nowrap="nowrap"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_mobile" size="15"
													maxlength="10" tabindex="17" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>" class="cbsstyle" readOnly
													onKeyPress="allowInteger();allowPhone()"> </font></td>
                                    </tr>
                                    <tr> 
                                                                       
                                      <td width="16%" align="right" id="id_Mobility"><font size="2" face="MS Sans Serif">Mobility 
                                        of Individual</font> <b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
                                        <font size="2" face="MS Sans Serif"> :&nbsp;</font></td>
                                      <td width="34%" height="36" id="id_Mobility1"><font size="2"
													face="MS Sans Serif"> 
                                        <select name="sel_mobility"
													tabindex="12">
                                          <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag apptype="1"/> 
                                        </select>
                                        </font>
                                        </td>
                                        <td width="22%" align="right"><font size="2" face="MS Sans Serif">Residence Extension &
												Phone No. : </font></td>
										<td width="22%"><font size="2" face="MS Sans Serif"></font>
													    <font size="2" face="MS Sans Serif"><input type="text"
													name="txtperapp_phoneext" size="4" maxlength="10"
													tabindex="16" onKeyPress="allowInteger();isNumber(evt)"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_exphone"))%>"
													onKeyPress=""> 
													<input type="text"
													name="txtperapp_phone" size="15" maxlength="10"
													tabindex="16" onKeyPress="allowInteger();isNumber(evt)"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>"
													onKeyPress="isNumber(evt)"> </font>
										</td>
                                    </tr>
                                    <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
												<td width="18%" align="right" id="id_Residence1">												 
													<font size="2" face="MS Sans Serif">Residence Type<font size="2" face="MS Sans Serif" color="#FF0000">*</font></font>
													<font size="2" face="MS Sans Serif"> :&nbsp;</font>												 
												</td>
												<td colspan="3" valign="top" id="id_Residence2"><font size="2"
													face="MS Sans Serif"> <select name="txt_residence"
														tabindex="12">
														<option value="">---Select---</option>
														<option value="1">Owned</option>
														<option value="2">Rented</option>
													</select></font></td>
									</tr>
									<tr>
										<td>&nbsp;</td>
                                    	<td>&nbsp;</td>
										<td width="20%" align="right">
											<font size="2" face="MS Sans Serif">Years in Current Address :&nbsp;</font>
										</td>
										<td width="10%"><font size="2" face="MS Sans Serif"> <select
													name="txtperapp_yrsinpresadd" tabindex="18">
													<option value="0">---- Select ----</option>
													<option value="1">&gt; 3 Years</option>
													<option value="2">&lt; 2 years</option>
													<option value="3">&lt;1 year</option>
												</select> </font>
										</td>
									</tr>
                                  </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td>
										
                                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                    <tr> 
                                      <td  id='farm15' width="16%" align="right"><font size="2" face="MS Sans Serif">Father/Husband 
                                        Name :&nbsp;</font><font size="2" face="MS Sans Serif" color="#FF0000">*</font></td>
                                      <td  id='farm16' width="16%"> 
                                        <input type="text" name="txtperapp_fatname"
													size="20" maxlength="50" tabindex="29"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_fatname"))%>"
													onKeyPress="notAllowedDouble();allowAlphabetsAndSpace(); return allowAlphabetsOne(evt)">
                                      </td>
                                      <td id='farm17' width="16%" align="right"><font size="2" face="MS Sans Serif">Edu. 
                                        Qualification :&nbsp;</font></td>
                                      <td  id='farm18' width="16%"><font size="2" face="MS Sans Serif"> 
                                        <!-- <input type="text" name="seleducat" size="20" maxlength="50" tabindex="29" value="<%//=Helper.correctNull((String)hshValues.get("perapp_education"))%>"  class="cbsstyle" readOnly> -->
                                        <select name="seleducat" tabindex="30">
                                       <!--     <option value="0" selected>----Select----</option>
                                          <option value="1">Doctorate</option>
                                          <option value="2">Post Graduate</option>
                                          <option value="3">Graduate</option>
                                          <option value="4">Higher Secondary</option>
                                          <option value="5">Others</option>
												 		<td width="16%"><font size="2"
											face="MS Sans Serif"> -->
										 <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag  apptype="12"/>
                                        </select>
                                        </font></td>
                                      <td width="16%" align="right"><font size="2" face="MS Sans Serif">Banking 
                                        with us :&nbsp;</font></td>
                                      <td width="16%"><font size="2" face="MS Sans Serif"> 
                                        <select
													name="selbank" onChange="enableSince()" tabindex="31">
                                          <option value="1" selected><font size="2"
														face="MS Sans Serif">Yes</font></option>
                                          <option value="2"><font size="2" face="MS Sans Serif">No</font></option>
                                        </select>
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%" id="s1" align="right"><font size="2" face="MS Sans Serif">Since :&nbsp;</font></td>
                                      <td width="16%" id="s2"><font size="2" face="MS Sans Serif"
													width="16%"> 
                                        <input type="text" name="txtperapp_since"
													size="5" maxlength="4" tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperapp_since)">
                                        </font><font size="2" face="MS Sans Serif">&nbsp; 
                                        </font></td>
                                      <td width="16%" id="actype1" align="right"><font size="2"
													face="MS Sans Serif">Account 
                                        Type :&nbsp;</font></td>
                                      <td width="16%" id="actype2"><font size="2"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_acctype" size="10" maxlength="10"
													tabindex="33" readOnly
													value="<%=Helper.correctNull((String)hshValues.get("perapp_bankacctype"))%>"
													onKeyPress="notAllowSingleQuote()">
                                        </font><a
													href="javascript:ShowAccountDetails()" class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px"></a><font
													size="1" face="MS Sans Serif" width="16%">&nbsp; 
                                        </font></td>
                                      <td width="16%" id="acno1" align="right"><font size="2"
													face="MS Sans Serif">A/c No :&nbsp;</font></td>
                                      <td width="16%" id="acno2"><font size="2"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_accno" size="20" maxlength="20"
													tabindex="34" readOnly
													value="<%=Helper.correctNull((String)hshValues.get("perapp_bankaccno"))%>"
													onKeyPress="notAllowSingleQuote()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td align="right" id="id_Canara"><font size="2" face="MS Sans Serif">Are you a Canara Staff :&nbsp;</font></td>
                                      <td id="id_Canara1"><font size="2" face="MS Sans Serif"> 
                                        <select name="selbuss" tabindex="35">
                                          <option value="0"><font size="2" face="MS Sans Serif">No</font></option>
                                          <option value="1"><font size="2" face="MS Sans Serif">Yes</font></option>
                                        </select>
                                        </font></td>
                                      <td  id="farm19" width="16%" align="right"><font size="2" face="MS Sans Serif">Category :&nbsp;</font><font size="2" face="MS Sans Serif" color="#FF0000">*</font></td>
                                      <td  id="farm20" width="16%"> 
                                        <select name="selcat" tabindex="36">
                                          <option value="0" selected>----Select----</option>
                                          <option value="1">SC & Minority</option>
                                          <option value="2">SC</option>
                                          <option value="3">ST</option>
                                          <option value="4">OBC</option>
                                          <option value="5">Others</option>
                                          <option value="6">Minority</option>
                                        </select>
                                      </td>
                                      <td  id="farm21" width="16%" align="right"><font size="2" face="MS Sans Serif">No. 
                                        of Dependents</font><b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
                                        <font size="2" face="MS Sans Serif"> :&nbsp;</font></td>
                                      <td  id="farm22" width="16%"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_depend" size="5" maxlength="4"
													tabindex="37"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_depend"))%>"
													onKeyPress="return allowIntegerOne(event)">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%" id="child1" align="right"><font size="2"
													face="MS Sans Serif">Children :&nbsp;</font></td>
                                      <td width="16%" id="child2"><font size="2"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_childnum" size="4" maxlength="2"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_childnum"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                      <td width="16%" rowspan="2" align="right" id="id_Passport"><font size="2" face="MS Sans Serif">Passport 
                                        Number :&nbsp;</font></td>
                                      <td width="16%" rowspan="2" id="id_Passport1"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_passport" size="15"
													tabindex="39"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_passport"))%>" class="cbsstyle" readOnly
													maxlength="50">
                                        </font></td>
                                      <td width="16%" rowspan="2" align="right" id="id_Passport2">Passport Expiry 
                                        Date :&nbsp;</td>
                                      <td width="16%" rowspan="2" id="id_Passport3"><font size="2" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_passport_expiry" size="15"
													tabindex="39" onBlur="checkDate(this)"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_PASSPORT_EXPIRY"))%>"
													maxlength="50">
                                        </font></td>
                                    </tr>
                                    <tr>
                                      <td width="16%" id="child3" align="right"><font size="2"
													face="MS Sans Serif">Relationship with the Bank</font>
													<b><font size="2" face="MS Sans Serif" color="#FF0000">*</font></b>
													<font size="2" face="MS Sans Serif"> :&nbsp;</font></td>
                                      <td width="16%" id="child4"><font size="2"
													face="MS Sans Serif"> 
                                        <select name="sel_bankrel"
													tabindex="12">
                                          <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag apptype="2"/>
                                        
                                        </select>
                                        </font></td>
                                    </tr>
                                    
                                     <tr> 
                                      <td width="16%" id="mother1" align="right"><font size="2"
													face="MS Sans Serif">Mothers Name:&nbsp;</font></td>
                                      <td width="16%" id="mother2"><font size="2"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_mothername" size="20" maxlength="50"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_motname"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                                 <td width="16%" id="mark1" align="right"><font size="2"
													face="MS Sans Serif">Marks:&nbsp;</font></td>
                                      <td width="16%" id="mark2"><font size="2"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_marks" size="10" maxlength="5"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_marks"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                                       <td width="16%" id="chairman1" align="right"><font size="2"
													face="MS Sans Serif">Is Chairman:&nbsp;</font></td>
                                     <td id="chairman2"><font size="2" face="MS Sans Serif"> 
                                        <select name="selchairman" tabindex="35">
                                         <option value="0" selected>----Select----</option>
                                          <option value="1"><font size="2" face="MS Sans Serif">No</font></option>
                                          <option value="2"><font size="2" face="MS Sans Serif">Yes</font></option>
                                        </select>
                                        </font></td>
                                        </tr> 
                                   <tr> 
                                    <td  id="rel1" width="16%" align="right"><font size="2" face="MS Sans Serif">Relationship :&nbsp;</font><font size="2" face="MS Sans Serif" color="#FF0000">*</font></td>
                                      <td  id="rel2" width="16%"> 
                                        <select name="selrelation" tabindex="36">
                                          <option value="0" selected>----Select----</option>
                                          <option value="1">Father</option>
                                          <option value="2">Mother</option>
                                          <option value="3">Brother</option>
                                          <option value="4">Sister</option>
                                          <option value="5">Spouse</option>
                                          <option value="6">Brother- in- Law</option>
                                          <option value="7">Son</option>
                                          <option value="8">Daughter</option>
                                          <option value="9">Brother</option>
                                          <option value="10">Sister</option>
                                          <option value="11">Spouse</option>
                                          <option value="12">Brother- in- Law</option>
                                           <option value="13">Daughter- in - Law </option>
                                          <option value="14">Father - In - Law</option>
                                          <option value="15">Grand daughter</option>
                                          <option value="16">Grand Father</option>
                                          <option value="17">Grand Mother</option>
                                          <option value="18">Grand son</option>
                                           <option value="19">Mother- in- Law</option>
                                          <option value="20">Sister - in - Law</option>
                                          <option value="21">Son- in- Law</option>
                                          <option value="22"> Others</option>
                                          <option value="23">Grand son</option>
                                        </select>
                                      </td>
                                      
                                       <td width="16%" id="busss1" align="right"><font size="2"
													face="MS Sans Serif">Business Establishment Year:&nbsp;</font></td>
                                      <td width="16%" id="busss2"><font size="2" face="MS Sans Serif"> 
                                        <input type="text" name="txtperapp_bussyr" size="20" maxlength="6"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_busyear"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                        
                                             <td width="16%" id="busssmnth1" align="right"><font size="2"
													face="MS Sans Serif">Business Establishment Month:&nbsp;</font></td>
                                      <td width="16%" id="busssmnth2"><font size="2" face="MS Sans Serif"> 
                                        <input type="text" name="txtperapp_bussmnth" size="20" maxlength="5"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_busmonth"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                      
                                        </tr>
                                        
                                       <tr>
                                       
                                       <td width="16%" id="resstatus1" align="right"><font size="2"
													face="MS Sans Serif">Residental Status:&nbsp;</font></td>
                                           <td id="resstatus2"><font size="2" face="MS Sans Serif"> 
                                        <select name="selresstatus" tabindex="35">
                                         <option value="0" selected>----Select----</option>
                                          <option value="1"><font size="2" face="MS Sans Serif">Resident in India</font></option>
                                          <option value="2"><font size="2" face="MS Sans Serif">Non Resident</font></option>
                                        </select>
                                        </font></td>
                                        </tr>             
                                   
                             
                                    
                                  </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr id="farm8">
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="2"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>

										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr style="visibility: hidden;position: absolute;">
												<td colspan="2"><font size="2" face="MS Sans Serif"><b>SPOUSE DETAILS </b> </font></td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
											</tr>
											<tr style="visibility: hidden;position: absolute;">
												<td width="16%" align="right"><font size="2" face="MS Sans Serif" > Name :&nbsp;</font></td>
												<td width="16%"><input type="text" name="txtperapp_husname"
													size="20" maxlength="50" tabindex="40"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_husname"))%>"
													onKeyPress="notAllowedDouble();allowAlphabetsAndSpace()"></td>
												<td width="16%" align="right"><font size="2" face="MS Sans Serif" >
												Occupation : </font></td>
												<td width="16%"><input type="text"
													name="txtperapp_occupation" size="20" tabindex="41"
													maxlength="41"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseoccu"))%>">
												</td>
												
												 <td width="16%"><font size="2" face="MS Sans Serif">&nbsp; </font>&nbsp;</td>
												<td width="16%">&nbsp;</td> 
											    </tr>
											<tr style="visibility: hidden;position: absolute;">
												<td width="16%" align="right"><font size="2" face="MS Sans Serif"> PAN 
												/ GIR No. :&nbsp;</font></td>
												<td width="16%"><input type="text" name="txtperapp_sppan"
													size="15" maxlength="10" tabindex="43"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spousepan"))%>">
												</td>

												<td width="16%" align="right"><font size="2" face="MS Sans Serif"> Whether
												the spouse is employed? :&nbsp;</font></td>
												<td width="16%">
												<select name="selSpouseIncome" tabindex="44">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>


												<!--  <td width="16%"><font size="2" face="MS Sans Serif"> 
                                        Net Monthly Income</font></td>
                                      <td width="16%"> 
                                        <input type="text" name="txtperapp_spincome" size="15" maxlength="12"  tabindex="44" onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onblur="roundtxt(txtperapp_spincome)" value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseincome"))%>">
                                      </td> -->
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
											</tr>

											<tr style="visibility:hidden">
												<td width="16%" align="right"><font size="2" face="MS Sans Serif"> If
												Employed ,Net Income From</font></td>
												<td width="16%">&nbsp;</td>
												<td width="16%" align="right"><font size="2" face="MS Sans Serif"> (1)
												Salary (Monthly)</font></td>
												<td width="16%"><input type="text" name="txtperapp_spincome"
													size="15" maxlength="12" tabindex="45"
													onkeypress="allowDecimals(this.value)"
													style="text-align:right"
													onblur="roundtxt(txtperapp_spincome)"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseincome"))%>">
												</td>
												<td width="16%" align="right"><font size="2" face="MS Sans Serif"> (2)
												Other Sources (Monthly)</font></td>
												<td width="16%"><input type="text"
													name="txtperapp_spotherincome" size="15" maxlength="10"
													tabindex="46"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseother"))%>">
												</td>
											</tr>

											<tr>
												<td width="16%" align="right" id="id_Close"><font size="2" face="MS Sans Serif"> Whether
												any other close relative intending to join the loan transaction as Guarantor ?&nbsp;</font></td>
												<td width="16%" id="id_Close1"><select name="selIfCoBorrow" tabindex="47">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											
												<td width="16%" align="right" style="visibility: hidden;position: absolute;"><font size="2" face="MS Sans Serif"> Whether applicant is NRI ?&nbsp;</font></td>
												<td width="16%" style="visibility: hidden;position: absolute;"><select name="selpensioner" tabindex="47">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
												</tr>
												<tr>
													<td width="16%" align="right" nowrap="nowrap">
													<font size="2" face="MS Sans Serif">Whether GPA holder Appointed ?&nbsp;</font></td>
												<td width="16%"><font size="2" face="MS Sans Serif"> <select
													name="selGPA" onChange="enableGPAholder()" tabindex="48">
													<option value="1" ><font size="2" face="MS Sans Serif">Yes</font></option>
													<option value="2" selected><font size="2" face="MS Sans Serif">No</font></option>
												</select> </font></td>
										
												<td id="legalheiers"><input type="button" name="legal" value="Legal Heirs"
													onClick="ShowLegal('legalheirs.jsp')" style="width:100"
													class="buttoncolor"></td>
											</tr>
											<tr>
												<td width="26%" id="h1"><font size="2" face="MS Sans Serif"><b>General Power of Attorney Details</b>
												</font></td>
												</tr>
											<tr>
												<td width="16%" id="p1" align="right"><font size="2" face="MS Sans Serif">Name of the GPA holder :&nbsp;</font></td>
												<td width="16%" id="p2"><font size="2" face="MS Sans Serif"
													width="16%"> <input type="text" name="txtperapp_GPAholder"
													size="30" maxlength="25" tabindex="48"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAHOLDERNAME"))%>"
													onKeyPress="">
												</font><font size="2" face="MS Sans Serif">&nbsp; </font></td>
												</tr>
												<tr>
												<td width="16%" id="a1" align="right"><font size="2" face="MS Sans Serif">Age :&nbsp;</font></td>
												<td width="16%" id="a2"><font size="2" face="MS Sans Serif">
												 <input type="text"	name="txtperapp_GPAage" size="10" maxlength="2"
													tabindex="49"  	value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAHOLDERAGE"))%>"
													onKeyPress="allowNumber(this)" > </font></td>
													</tr>
												<tr>
												<td width="12%" id="add1" align="right"><font size="2" face="MS Sans Serif">Address :&nbsp;</font></td>
												<td width="30%" id="add2"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAadd1" size="30"
													maxlength="50" tabindex="50"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAADDRESS1"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
												</tr>
												<tr>
												    <td width="12%" id="add3"><font size="2" face="MS Sans Serif"></font></td>
													<td width="30%" id="add4"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAadd2" size="30"
													maxlength="50" tabindex="50"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAADDRESS2"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
												</tr>
	
											<tr>
												<td width="12%" id="GPAcity1" align="right"><font size="2" face="MS Sans Serif">City :&nbsp;</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
												<td width="30%"  id="GPAcity2"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAcity" size="18"
													maxlength="20" tabindex="51"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPACITY"))%>"
													onKeyPress="allowAlphabetsAndSpace()"> </font></td>
												
											</tr>
											<tr>
												<td width="12%" id="GPAState1" align="right"><font size="2" face="MS Sans Serif">State : </font></td>
												<td width="22%" id="GPAState2"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAstate" size="15" maxlength="20"
													tabindex="52"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPASTATE"))%>"
													onKeyPress="allowAlphabetsAndSpace()"
													onBlur="changecase(document.forms[0].txtperapp_GPAstate)">
													 <a	href="javascript:ShowStates('3')" class="blackfont">?</a> </font></td>
												
											</tr>
											<tr>
												<td width="12%" id="GPApin1" align="right">
												<font size="2" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font>
												<font size="2" face="MS Sans Serif"> : </font></td>
												<td width="30%" id="GPApin2"><font size="2" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="53"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAZIP"))%>"
													onKeyPress="allowInteger()"> </font></td>
												
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
				</td>
			</tr>
		</table>		
		</td>
	</tr>
</table>
  
<!-- ************************************* END FOR CANARA ************************************************ -->
 <%}else{ %>
<!-- ************************************* FOR SYNDICATE ************************************************ -->

<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="outertablecolor"><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b><i>Home -&gt; <%=PageName %> </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile Search </i></b></font><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font
			size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font>
		</i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Customer Profile </i></b></font><font size="4"><b><i><font size="4"><b><i><font
			size="4"><b><i><font size="4"><b><i><font size="4"><b><font
			color="#000000" size="2"><i><font size="4"><b><i><font
			face="Times New Roman" size="3"><b>-&gt; </b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font><font
			face="Times New Roman" size="3"><b><i>Demographics</i></b></font></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertablecolor">
	<tr>
		<td colspan="2" valign="bottom">
		<table width="100%" border="0" cellspacing="3" cellpadding="3"
			align="left">
			<tr>

				<td width="20%" class="tabactive" align="center"><b><font size="1"
					face="MS Sans Serif" color="#FFFFFF">NP_Demographics</font></b></td>
					          
					<%
					if((!Helper.correctNull((String)hshValues.get("perapp_employment")).equals("10")) && (!Helper.correctNull((String)hshValues.get("perapp_employment")).equals("7"))){%>
					
				<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callIncomeExpenses()"
					class="blackfont">NP_Income &amp; Deduction</a></font></b></td>
					<% if(!strCustCat.equalsIgnoreCase("C")){%>
				<td width="10%" id="employertdbtn1" align="center"
					class="tabinactive"><b><font size="1" face="ms sans serif"><a
					href="JavaScript:callEmployer()" class="blackfont">NP_Employment
				Details </a></font></b></td>
				<%} %>
				<% }%>
				
				<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCBIL()"
					class="blackfont">TransUnion CIBIL</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEXPERIANPage()"
					class="blackfont">Experian</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callCRIFPage()"
					class="blackfont">CRIFF Highmark</a></font></b></td>
					
					<td width="10%" align="center" class="tabinactive"><b><font size="1"
					face="ms sans serif"><a href="JavaScript:callEquifaxPage()"
					class="blackfont">Equifax</a></font></b></td>
					
				<td class="tabactive" align="center"> 
					<b><font size="1" face="ms sans serif">NP_Profile Status &nbsp; : &nbsp;<%=tempProfile%></font></b>
					</td>
				<!--  <td width="25%" id="firmdetails" align="center" class="tabinactive"><b><font
					size="2" face="ms sans serif"><a
					href="JavaScript:callFirmDetails()" class="blackfont"><font
					size="1"> Firm/Company Details </font></a></font></b></td>-->
				
			</tr>
		</table>
		</td>
	</tr>
</table>
<table width="90%" border="0" cellspacing="0" cellpadding="3"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor">
	<tr>
	<td>				
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				<td>
                     
				<table width="100%" border="1" cellspacing="0" cellpadding="1"
					bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
					<tr align="center">
						<td width="18%"><font size="1" face="MS Sans Serif">Applicant ID</font></td>
						<td width="15%"><font size="1" face="MS Sans Serif">Title</font></td>
						<td width="22%"><font size="1" face="MS Sans Serif">First Name </font></td>
						<td width="23%"><font size="1" face="MS Sans Serif">Middle Name </font></td>
						<td width="22%"><font size="1" face="MS Sans Serif">Last Name </font></td>
					</tr>
					<tr align="center">
						<td width="18%"><font size="1" face="MS Sans Serif"><input
							type="text" name="txtperapp_cbsid" size="12" maxlength="9"
							tabindex="1"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>"
							class="cbsstyle" onKeyPress="allowInteger()" readOnly></font></td>
						<td width="15%"><font size="1" face="MS Sans Serif"> <input
							type="text" name="txtperapp_apptitle" size="4" maxlength="4"
							tabindex="2" readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_title"))%>"
							class="cbsstyle"> </font></td>
						<td width="22%">
						<p><font size="1" face="MS Sans Serif"> <input type="text"
							name="txtperapp_fname" size="25" maxlength="20" tabindex="3"
							readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>"
							class="cbsstyle"> </font></p>
						</td>
						<td width="23%">
						<p><font size="1" face="MS Sans Serif"> <input type="text"
							name="txtperapp_mname" size="20" maxlength="20" tabindex="4"
							readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_mname"))%> "
							class="cbsstyle"> </font></p>
						</td>
						<td width="22%"><font size="1" face="MS Sans Serif"> <input
							type="text" name="txtperapp_lname" size="20" maxlength="20"
							tabindex="5" readOnly
							value="<%=Helper.correctNull((String)hshValues.get("perapp_lname"))%>"
							class="cbsstyle"> </font></td>
					</tr>
					<tr>

						<td valign="top" colspan="5">
						<!-- new div -->
						
						<table width="100%" border="1" cellspacing="0" cellpadding="0">
							<tr>
								<td width="30%" valign="top">
								  
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										
                                <td width="30%" height="277" valign="top"> 
                                  <!-- 	<div class="cellContainer"> 
									-->
<table width="100%" border="0" cellspacing="0" cellpadding="5">
											<!-- <tr>
												<td width="50%"><font size="1" face="MS Sans Serif">LAPS ID</font></td>
												<td><input
							type="text" name="txtperapp_appid" size="12" maxlength="9"
							tabindex="1"
							value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"
							class="cbsstyle" onKeyPress="allowInteger()" readOnly><input type="text"
							name="txt_perappid" size="5" readOnly
							value="<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
							onKeyPress="allowNumber(this)" style="visibility: hidden"></td>
											</tr>  -->
											<tr>
												<td width="50%"><font size="1" face="MS Sans Serif">PAN /
												GIR No. </font><b><font size="1" face="MS Sans Serif"
													color="#FF0000"></font></b></td>
												<td colspan="3"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_panno" size="12" maxlength="10"
													tabindex="6"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_panno"))%>" class="cbsstyle" readOnly
													onKeyPress="allowAlpaNumeric()"> </font></td>
											</tr>
											<tr>
												<td id='farm25' width="50%"><font size="1" face="MS Sans Serif">Date of
												Birth(DD/MM/YYYY)</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												
												<td id='farm26' nowrap='nowrap' width="50%"><font size="1" face="MS Sans Serif">Date of
												Formation(DD/MM/YYYY)</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b>
												
												</td>
												
												<td valign="top"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_dob" size="12" maxlength="10"
													tabindex="7"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_dob"))%>"
													onBlur="checkDate(this);checkFileDate(this);calcAge();"> <!-- dateCheck(this) --><font
													size="2"></font> </font> <a href="#"
													onClick="callCalender()" title="Click to view calender"
													border=0><img
													src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
													border="0"></a></td>
													<td id='farm9' valign="top" width="10%" align="left">
													<font size="1" face="MS Sans Serif">Age </font><b>
													<font size="1" face="MS Sans Serif" color="#FF0000"></font></b></td>
													<td id='farm10' valign="top" align="left"><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_age" size="5" maxlength="3"
													value="" readonly="readonly"> </font><font size="1"
													face="MS Sans Serif">&nbsp; </font></td>
											</tr>
											<tr>
												<td width="50%" id='farm11'><font size="1" face="MS Sans Serif">Sex </font></td>

												<td id='farm12' colspan="3"><font size="1" face="MS Sans Serif"> <input
													type="text" name="choperapp_sex" size="8" maxlength="10"
													tabindex="7"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_sex"))%>"
													class="cbsstyle" readOnly> <!-- <select name="choperapp_sex" tabindex="7" OnChange="checkProfession()">
                                          <option value=""><font size="1" face="MS Sans Serif">--Select--</font></option>
                                          <option value="M"><font size="1" face="MS Sans Serif">Male</font></option>
                                          <option value="F"><font size="1" face="MS Sans Serif">Female</font></option>
                                        </select> --> </font></td>
											</tr>
											<tr>
												<td width="50%" id='farm13'><font size="1" face="MS Sans Serif">Marital
												Status </font></td>
												<td  id='farm14' colspan="3"><font size="1" face="MS Sans Serif"> <!-- <input type="text" name="choperapp_marstat" size="8" maxlength="10" tabindex="7" value = "<%//=Helper.correctNull((String)hshValues.get("perapp_marstat"))%>" class="cbsstyle"  readOnly> -->
												<select name="choperapp_marstat" tabindex="8"
													OnChange="showNumberChildren()">
													<!--  <option value="0">----Select----</option>
													<option value="1">Single</option>
													<option value="2">Married</option>
													<option value="3">Divorced</option>
													<option value="4">Widowed</option>
													<option value="5">Separated</option>-->
																<!-- sathiya -->
										 <option value="0" selected> <----Select----> 
                                          </option>
												 	
                                               <lapschoice:StaticDataTag  apptype="8"/>													</select> </font>
													<font size="1" face="MS Sans Serif">&nbsp;</font></td>
											</tr>
											<tr>
												<td width="50%"><font size="1" face="MS Sans Serif">Employment
												Status</font> <b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td colspan="3"><font size="1" face="MS Sans Serif"> <select
													name="rdoperapp_employment" tabindex="9"
													onchange="showProfession();showProfession1();">
													<!--  
													<option value="0">---- Select ----</option>
													<option value="1">Salaried in approved Company</option>
													<option value="2">Salaried in Private Sector</option>
												<option value="3">Syndicate Staff</option> 
													<option value="4">Professional</option>
													<option value="5">Pensioner</option>
													<option value="6">Self Employed</option>
													<option value="7">Agriculturist</option>
													<option value="8">Business</option>
													<!-- sathiya -->
											<!--  	<option value="9">Housewife</option>
													<option value="10">Student</option> -->
													<!-- sathiya -->
										 <option value="0" Selected>----Select---- </option>
												 	
                                               <lapschoice:StaticDataTag  apptype="7"/>									
                                               				</select> </font>
													<font size="1" face="MS Sans Serif">&nbsp;</font></td>
												
											</tr>
											 	<tr >
									<td width="35%" id="agr_typefarmer"  >Type of Farmer</td>
											<td colspan="3" id="agr_farmactivity" ><select
												name="sel_farmactivity" tabindex="13">
												<option value="0" Selected>---- Select ----</option>
												<option value="1">Agriculture Labor</option>
												<option value="2">Marginal Farmer</option>
												<option value="3">Other Farmer</option>
												<option value="4">Others</option>
												<option value="5">Share Cropper</option>
												<option value="6">Small Farmer</option>
												<option value="7">Tenant Farmer</option>
												<option value="8">Orallesse</option>
											</select></td>
										</tr>
<!--										<tr >-->
<!--										<td width="35%" id="agr_measurementtype" >Measurement Type</td>-->
<!--										<td colspan="3" id="agr_measurementactivity" ><select-->
<!--												name="sel_measurementtype" tabindex="13">-->
<!--												<option value="0" Selected>---- Select ----</option>-->
<!--												<option value="1">Cents</option>-->
<!--												<option value="2">Guntas</option>-->
<!--											</select></td>-->
<!--										</tr>-->
										<tr >
										<td width="35%" id="agr_whethershg" >Whether SHG</td>
										<td colspan="3" id="agr_shgtypes" ><select
												name="sel_shg" tabindex="13" OnChange="showSHGJLG('SHG');">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></td>
										</tr>
										<tr >
										<td width="35%" id="agr_whetherjlg" >Whether JLG</td>
										<td colspan="3" id="agr_jlgtypes" ><select
												name="sel_jlg" tabindex="13" OnChange="showSHGJLG('JLG');">
												<option value="s" Selected>---- Select ----</option>
												<option value="y">Yes</option>
												<option value="n">No</option>
											</select></td>
										</tr>
										
											<tr >
										<td width="35%" id="shg_groupname">SHG Group Name</td>
										<td width="35%" id="jlg_groupname">JLG Group Name</td>
										<td colspan="3" valign="top"><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtshg_name" size="38" maxlength="100"
													tabindex="14"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGNAME"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
										</tr>
										<tr >
										<td width="35%" id="agr_village" >Village/Block Name</td>
										<td colspan="3" valign="top" id="agr_villageType" ><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtshg_village" size="38" maxlength="100"
													tabindex="15"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_SHGVILLAGE"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
										</tr>
										
											
											<tr>
												<td width="50%" id="prof1"><font size="1"
													face="MS Sans Serif">Type of Profession </font></td>
												<td colspan="3" id="prof2"><font size="1"
													face="MS Sans Serif"> <select name="rdoperapp_professional"
													tabindex="12">
													<option value="0" selected>---- Select ----</option>
													<option value="1">Doctor</option>
													<option value="2">Architect</option>
													<option value="3">CA</option>
													<option value="4">MBA</option>
													<option value="5">Engineer</option>
													<option value="6">Lawyer</option>
													<option value="7">Others</option>
												</select> </font> <font size="1" face="MS Sans Serif">&nbsp;
												</font></td>
											</tr>
											<tr id="pension1">
												<td width="50%"><font size="1" face="MS Sans Serif">Pensioner Age</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td colspan="3">
													
												<input type="text" name="pensionerage" onkeypress="allowInteger()" maxlength="2" tabindex="13" value="<%=Helper.correctNull((String)hshValues.get("pensionerage")) %>">	
												</td>
											</tr>
										</table>
										</td>
									</tr>
								</table>
								</td>

								<td width="62%" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="4"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										
                                <td height="277" valign="top"> 
<table width="100%" border="0" cellspacing="0" cellpadding="5">
											<tr>
												<td colspan="3"><font size="1" face="MS Sans Serif"><b>Present
												Address</b></font>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
												<input type="checkbox"
													name="percheck" onClick ="trandata()" tabindex="11" style="border: 0"><font size="1" face="MS Sans Serif">Check to have Permanent as Present
												Address</font></td>
											</tr>
											<tr>
												<td width="18%" align="left">
												<!-- <div align="left">
												-->
												
												<font size="1" face="MS Sans Serif">Address [Start with S/o,D/o,W/o]
												</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b> <!-- </div> -->
												</td>
												<td colspan="3" valign="top"><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address1" size="38" maxlength="150"
													tabindex="11"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>"
													onKeyPress="notAllowedDouble()"> </font><font size="1"
													face="MS Sans Serif">&nbsp; </font></td>
													
													
														<TD ROWSPAN="4" WIDTH="30%" ><IFRAME
													SRC="<%=ApplicationParams.getAppUrl()%>action/ifrmapplicantphoto.jsp?hidBeanGetMethod=getdemographicsphoto&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
													ID="IDIFRMPH" WIDTH="160" HEIGHT="185" SCROLLING="no"
													FRAMEBORDER="0" align="top"></IFRAME></TD>
													
													
												<!--  <td valign="top" rowspan="4" width="20%"> 
                                        <div align="center"><font size="1" face="MS Sans Serif"><iframe src="<%=ApplicationParams.getAppUrl()%>action/setphoto.jsp?hidDemoId=<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>" id="idfrm1" width="110" height="130" scrolling="no" frameborder=no></iframe> 
                                          </font></div>
                                      </td> -->
											</tr>
											<tr>
												<td width="18%" align="left">
												<!--  <div align="left">
												-->
												<font size="1" face="MS Sans Serif">&nbsp;</font>
												<!-- 
												
>
												-->
												</td>
												<td colspan="3" valign="top"><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address2" size="38" maxlength="150"
													tabindex="12"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address2"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
											</tr>
											<tr>
												<td width="18%" align="left">												 
													<font size="1" face="MS Sans Serif">&nbsp;</font>												 
												</td>
												<td colspan="3" valign="top"><font size="1"
													face="MS Sans Serif"> <input type="text"
													name="txtperapp_address3" size="38" maxlength="150"
													tabindex="12"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
											</tr>
											<tr>
												<td width="18%" align="left">												 
													<font size="1" face="MS Sans Serif">Residence Type <font size="1" face="MS Sans Serif" color="#FF0000">*</font></font>												 
												</td>
												<td colspan="3" valign="top"><font size="1"
													face="MS Sans Serif"> <select name="txt_residence"
														tabindex="12">
														<option value="">---Select---</option>
														<option value="1">Owned</option>
														<option value="2">Rented</option>
													</select></font></td>
											</tr>
											<tr>
												<td width="24%" align="left">
												<!-- <div align="left">
												-->
												<font size="1" face="MS Sans Serif">City </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b>
												<!-- </div> -->
												</td>
												<td width="15%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_city" size="12" maxlength="20"
													tabindex="13"
													value="<%=Helper.correctNull(
										(String)hshValues.get("perapp_city"))%>"
													onKeyPress="allowAlphabets()"> </font></td>
												<td width="19%"><font size="1" face="MS Sans Serif">State </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
												<td width="22%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_state" size="15" maxlength="20"
													tabindex="14"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_state"))%>"
													onKeyPress="allowAlphabetsAndSpace()"
													onBlur="changecase(document.forms[0].txtperapp_state)">
													 <a	href="javascript:ShowStates('111')" class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px"></a> </font></td>
											</tr>
											<tr>
												<td width="24%" align="left">
												<!-- <div align="left">
												-->
												<font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font>
												<!-- </div>
												-->
												</td>
												<td width="15%"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_zip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="15"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_zip"))%>"
													onKeyPress="allowInteger()"> </font></td>
												<td width="22%"><font size="1" face="MS Sans Serif">Residence Extension &
												Phone No.   </font></td>
												<td width="22%"><font size="1" face="MS Sans Serif"></font><font
													size="1" face="MS Sans Serif"></font><font size="1"
													face="MS Sans Serif"><input type="text"
													name="txtperapp_phoneext" size="4" maxlength="10"
													tabindex="16" onKeyPress="allowInteger();"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_exphone"))%>"
													onKeyPress=""> <input type="text"
													name="txtperapp_phone" size="15" maxlength="10"
													tabindex="16" onKeyPress="allowInteger();"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>"
													onKeyPress=""> </font></td>
											</tr>
											<tr>
												<td><font size="1" face="MS Sans Serif">E-mail</font></td>
												<td><font size="1" face="MS Sans Serif"> <input type="text"
													name="txtperapp_email" size="25" maxlength="50"
													tabindex="16"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_email"))%> "
													onblur="isEmailAddr(document.forms[0].txtperapp_email.value,document.forms[0].txtperapp_email)">
												</font></td>
												<td width="19%" nowrap="nowrap"><font size="1" face="MS Sans Serif">Mobile
												No. </font></td>
												<td width="22%" nowrap="nowrap"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_mobile" size="15"
													maxlength="10" tabindex="17" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_mobile"))%>" class="cbsstyle" readOnly
													onKeyPress="allowInteger();allowPhone()"> </font></td>
													<TD  ALIGN="center" WIDTH="30%">
												<DIV ALIGN="CENTER"><INPUT TYPE="button"
													NAME="cmdPhoto" VALUE="Get Photo" class="btn"
													ONCLICK="getPhoto()" TABINDEX="24"></DIV>
												</TD>
												<td></td>
												<!-- <td width="20%" align="center"> 
                                        <div align="left"><font size="1" face="MS Sans Serif">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                          </font> 
                                        <input type="button" name="cmdPhoto" value="Get Photo" style="width:80" class="buttoncolor" onClick = "" >
                                        </div>
                                      </td> -->
											</tr>
											<tr>
												<td width="20%"><font size="1" face="MS Sans Serif">Years in
												Current Address</font></td>
												<td width="10%"><font size="1" face="MS Sans Serif"> <select
													name="txtperapp_yrsinpresadd" tabindex="18">
													<option value="0">---- Select ----</option>
													<option value="1">&gt; 3 Years</option>
													<option value="2">&lt; 2 years</option>
													<option value="3">&lt;1 year</option>
												</select> </font></td>
												<td width="16%"><font size="1" face="MS Sans Serif"> Voter Id </font></td>
												<td width="16%"><input type="text" name="txtperapp_spemail"
													size="15" maxlength="10" tabindex="18" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseemail"))%>" class="cbsstyle" readOnly><!--onblur="isEmailAddr(document.forms[0].txtperapp_spemail.value,document.forms[0].txtperapp_spemail)" -->
												</td>	
												<td width="16%"><font size="1" face="MS Sans Serif"> Aadhar No. </font>&nbsp;
												<input type="text" name="txtperapp_aadhar"
													size="15" maxlength="10" tabindex="19" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_AADHARNO"))%>" class="cbsstyle" readOnly>
												</td>	
												</tr>
												<tr>
												
													<td width="20%"><font size="1" face="MS Sans Serif">RationCard Number </font></td>
													<td width="10%">
													<input type="text" name="txtperapp_ration"
													size="15" maxlength="10" tabindex="20" onKeyPress="allowAlpaNumeric();blockSpecialChar(event)"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_rationcard"))%>" >
													</td>
													<td width="20%"><font size="1" face="MS Sans Serif">Driving licence Number </font></td>
													<td width="10%">
													<input type="text" name="txtperapp_driving"
													size="15" maxlength="10" tabindex="21" onKeyPress="allowAlpaNumeric()"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_DL"))%>" class="cbsstyle" readOnly>
													</td>
												
												</tr>
										
											</table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td width="30%">
										
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1">
                                    <tr> 
                                      <td colspan="2"><font size="1" face="MS Sans Serif"><b>Previous 
                                        Address</b></font></td>
                                      <td colspan="2"><font size="1" face="MS Sans Serif"><b>Permanent 
                                        Address</b></font></td>
                                    </tr>
                                    <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif">Address</font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevadd1" size="30"
													maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevadd1"))%>"
													onKeyPress="notAllowedDouble()">
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">Address</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permadd1" size="30"
													maxlength="50" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd1"))%>"
													class="cbsstyle" readOnly>
                                        </font></td>
                                        <td valign="top" rowspan="3" width="27%" align="center"><iframe
									src="<%=ApplicationParams.getAppUrl()%>action/ifrmapplicantsign.jsp?hidBeanGetMethod=getdemographicssign&hidBeanId=mastapplicant&hidDemoId=<%=Helper.correctNull((String) hshValues.get("perapp_id"))%>"
									id="idfrm1" width="200" height="80" scrolling="no"
									frameborder='no'></iframe></td>
                                    </tr>
                                    <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevadd2" size="30"
													maxlength="50" tabindex="19"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevadd2"))%>"
													onKeyPress="notAllowedDouble()">
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permadd2" size="30"
													maxlength="50"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd2"))%>"
													class="cbsstyle" readOnly>
                                        </font></td>
                                    </tr>  
                                     <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                       </td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtPERAPP_PERMADD3" size="30"
													maxlength="50"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permadd3"))%>"
													class="cbsstyle" readOnly>
                                        </font></td>
                                    </tr>                                       
                                    <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevcity" size="18"
													maxlength="20" tabindex="20"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevcity"))%>"
													onKeyPress="allowAlphabets()">
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permcity" size="18"
													maxlength="20" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permcity"))%>"
													class="cbsstyle" readOnly
													onKeyPress="allowAlphabets()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif">State</font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevstate" size="18"
													maxlength="20" tabindex="21"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevstate"))%>"
													onKeyPress="allowAlphabets()"
													onBlur="changecase(document.forms[0].txtperapp_prevstate)">
                                        </font><a href="javascript:ShowStates('2')"
													class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px"></a></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">State</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permstate" size="18"
													maxlength="20" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permstate"))%>"
													class="cbsstyle" readOnly onKeyPress="allowAlphabets()">
                                        </font></td>
                                        
                                        <td WIDTH="27%">
								<DIV ALIGN="CENTER"><INPUT TYPE="button" NAME="cmdPhoto2"
									VALUE="Get Sign" class="btn" ONCLICK="getPhoto2()"
									TABINDEX="22"></DIV>
								</td>
								
								
                                    </tr>
                                    <tr> 
                                      <td width="12%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
                                      <td width="30%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_prevzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="22"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_prevzip"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													
													value="<%=Helper.correctNull((String)hshValues.get("perapp_permzip"))%>"
													class="cbsstyle" onKeyPress="allowInteger()" readOnly>
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="12%" rowspan="2">&nbsp;</td>
                                      <td width="30%" rowspan="2"><font size="1" face="MS Sans Serif">&nbsp; 
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif"> 
                                         Mobile No.</font></td>
                                      <td width="34%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_permphone" size="15"
													maxlength="10" 
													value="<%=Helper.correctNull((String)hshValues.get("perapp_phone"))%>"
													class="cbsstyle" readOnly onKeyPress="allowInteger()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%"><font size="1" face="MS Sans Serif">Mobility 
                                        of Individual</font> <b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                      <td width="34%" height="36"><font size="1"
													face="MS Sans Serif"> 
                                        <select name="sel_mobility"
													tabindex="12">
                                          <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag apptype="1"/> 
                                        </select>
                                        </font></td>
                                    </tr>
                                  </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr>
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="5"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>
										<td>
										
                                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                    <tr> 
                                      <td  id='farm15' width="16%"><font size="1" face="MS Sans Serif">Father's 
                                        Name</font></td>
                                      <td  id='farm16' width="16%"> 
                                        <input type="text" name="txtperapp_fatname"
													size="20" maxlength="50" tabindex="29"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_fatname"))%>"
													onKeyPress="notAllowedDouble();allowAlphabetsAndSpace();return allowIntegerOne(event)">
                                      </td>
                                      <td id='farm17' width="16%"><font size="1" face="MS Sans Serif">Edu. 
                                        Qualification </font></td>
                                      <td  id='farm18' width="16%"><font size="1" face="MS Sans Serif"> 
                                        <!-- <input type="text" name="seledu" size="20" maxlength="50" tabindex="29" value="<%//=Helper.correctNull((String)hshValues.get("perapp_education"))%>"  class="cbsstyle" readOnly> -->
                                        <select name="seledu" tabindex="30">
                                       <!--     <option value="0" selected>----Select----</option>
                                          <option value="1">Doctorate</option>
                                          <option value="2">Post Graduate</option>
                                          <option value="3">Graduate</option>
                                          <option value="4">Higher Secondary</option>
                                          <option value="5">Others</option>
												 		<td width="16%"><font size="1"
											face="MS Sans Serif"> -->
										 <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag  apptype="12"/>
                                        </select>
                                        </font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif">Banking 
                                        with us</font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif"> 
                                        <select
													name="selbank" onChange="enableSince()" tabindex="31">
                                          <option value="1" selected><font size="1"
														face="MS Sans Serif">Yes</font></option>
                                          <option value="2"><font size="1" face="MS Sans Serif">No</font></option>
                                        </select>
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%" id="s1"><font size="1" face="MS Sans Serif">Since 
                                        </font></td>
                                      <td width="16%" id="s2"><font size="1" face="MS Sans Serif"
													width="16%"> 
                                        <input type="text" name="txtperapp_since"
													size="5" maxlength="4" tabindex="32"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_banksince"))%>"
													onKeyPress="allowNumber(document.forms[0].txtperapp_since)">
                                        </font><font size="1" face="MS Sans Serif">&nbsp; 
                                        </font></td>
                                      <td width="16%" id="actype1"><font size="1"
													face="MS Sans Serif">Account 
                                        Type</font></td>
                                      <td width="16%" id="actype2"><font size="1"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_acctype" size="10" maxlength="10"
													tabindex="33" readOnly
													value="<%=Helper.correctNull((String)hshValues.get("perapp_bankacctype"))%>"
													onKeyPress="notAllowSingleQuote()">
                                        </font><a
													href="javascript:ShowAccountDetails()" class="blackfont">?</a><font
													size="1" face="MS Sans Serif" width="16%">&nbsp; 
                                        </font></td>
                                      <td width="16%" id="acno1"><font size="1"
													face="MS Sans Serif">A/c No</font></td>
                                      <td width="16%" id="acno2"><font size="1"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_accno" size="20" maxlength="20"
													tabindex="34" readOnly
													value="<%=Helper.correctNull((String)hshValues.get("perapp_bankaccno"))%>"
													onKeyPress="notAllowSingleQuote()">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%"><font size="1" face="MS Sans Serif">Are 
                                        you a Canara Staff</font></td>
                                      <td width="16%"><font size="1" face="MS Sans Serif"> 
                                        <select
													name="selbuss" tabindex="35">
                                          <option value="0"><font size="1" face="MS Sans Serif">No</font></option>
                                          <option value="1"><font size="1" face="MS Sans Serif">Yes</font></option>
                                        </select>
                                        </font></td>
                                      <td  id="farm19" width="16%"><font size="1" face="MS Sans Serif">Category 
                                        </font></td>
                                      <td  id="farm20" width="16%"> 
                                        <select name="selcat" tabindex="36">
                                          <option value="0" selected>----Select----</option>
                                          <option value="1">SC & Minority</option>
                                          <option value="2">SC</option>
                                          <option value="3">ST</option>
                                          <option value="4">OBC</option>
                                          <option value="5">Others</option>
                                          <option value="6">Minority</option>
                                        </select>
                                      </td>
                                      <td  id="farm21" width="16%"><font size="1" face="MS Sans Serif">No. 
                                        of Dependents </font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                      <td  id="farm22" width="16%"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_depend" size="5" maxlength="4"
													tabindex="37"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_depend"))%>"
													onKeyPress="return allowIntegerOne(event)">
                                        </font></td>
                                    </tr>
                                    <tr> 
                                      <td width="16%" id="child1"><font size="1"
													face="MS Sans Serif">Children</font></td>
                                      <td width="16%" id="child2"><font size="1"
													face="MS Sans Serif"> 
                                        <input type="text"
													name="txtperapp_childnum" size="4" maxlength="2"
													tabindex="38"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_childnum"))%>"
													onKeyPress="allowInteger()">
                                        </font></td>
                                      <td width="16%" rowspan="2"><font size="1" face="MS Sans Serif">Passport 
                                        Number </font></td>
                                      <td width="16%" rowspan="2"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_passport" size="15"
													tabindex="39"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_passport"))%>" class="cbsstyle" readOnly
													maxlength="50">
                                        </font></td>
                                      <td width="16%" rowspan="2">Passport Expiry 
                                        Date</td>
                                      <td width="16%" rowspan="2"><font size="1" face="MS Sans Serif"> 
                                        <input
													type="text" name="txtperapp_passport_expiry" size="15"
													tabindex="39" onBlur="checkDate(this)"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_PASSPORT_EXPIRY"))%>"
													maxlength="50">
                                        </font></td>
                                    </tr>
                                    <tr>
                                      <td width="16%" id="child1"><font size="1"
													face="MS Sans Serif">Relationship with the Bank</font><b><font size="1" face="MS Sans Serif" color="#FF0000">*</font></b></td>
                                      <td width="16%" id="child2"><font size="1"
													face="MS Sans Serif"> 
                                        <select name="sel_bankrel"
													tabindex="12">
                                          <option value="0" selected> <----Select----> 
                                          </option>
                                          <lapschoice:StaticDataTag apptype="2"/>
                                        
                                        </select>
                                        </font></td>
                                    </tr>
                                  </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>
							<tr id="farm8">
								<td colspan="2" valign="top">
								<table width="100%" border="1" cellspacing="0" cellpadding="2"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
									<tr>

										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3">
											<tr>
												<td colspan="2"><font size="1" face="MS Sans Serif"><b>Spouse
												Details</b> </font></td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
											</tr>
											<tr>
												<td width="16%"><font size="1" face="MS Sans Serif"> Name </font></td>
												<td width="16%"><input type="text" name="txtperapp_husname"
													size="20" maxlength="50" tabindex="40"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_husname"))%>"
													onKeyPress="notAllowedDouble();allowAlphabetsAndSpace()"></td>
												<td width="16%"><font size="1" face="MS Sans Serif">
												Occupation</font></td>
												<td width="16%"><input type="text"
													name="txtperapp_occupation" size="20" tabindex="41"
													maxlength="41"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseoccu"))%>">
												</td>
												
												 <td width="16%"><font size="1" face="MS Sans Serif">&nbsp; </font>&nbsp;</td>
												<td width="16%">&nbsp;</td> 
											    </tr>
											<tr>
												<td width="16%"><font size="1" face="MS Sans Serif"> PAN 
												/ GIR No.</font></td>
												<td width="16%"><input type="text" name="txtperapp_sppan"
													size="15" maxlength="10" tabindex="43"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spousepan"))%>">
												</td>

												<td width="16%"><font size="1" face="MS Sans Serif"> Whether
												the spouse is employed?</font></td>
												<td width="16%">
												<select name="selSpouseIncome" tabindex="44">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>


												<!--  <td width="16%"><font size="1" face="MS Sans Serif"> 
                                        Net Monthly Income</font></td>
                                      <td width="16%"> 
                                        <input type="text" name="txtperapp_spincome" size="15" maxlength="12"  tabindex="44" onkeypress=
										"allowDecimals(this.value)"  style="text-align:right" onblur="roundtxt(txtperapp_spincome)" value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseincome"))%>">
                                      </td> -->
												<td width="16%">&nbsp;</td>
												<td width="16%">&nbsp;</td>
											</tr>

											<tr style="visibility:hidden">
												<td width="16%"><font size="1" face="MS Sans Serif"> If
												Employed ,Net Income From</font></td>
												<td width="16%">&nbsp;</td>
												<td width="16%"><font size="1" face="MS Sans Serif"> (1)
												Salary (Monthly)</font></td>
												<td width="16%"><input type="text" name="txtperapp_spincome"
													size="15" maxlength="12" tabindex="45"
													onkeypress="allowDecimals(this.value)"
													style="text-align:right"
													onblur="roundtxt(txtperapp_spincome)"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseincome"))%>">
												</td>
												<td width="16%"><font size="1" face="MS Sans Serif"> (2)
												Other Sources (Monthly)</font></td>
												<td width="16%"><input type="text"
													name="txtperapp_spotherincome" size="15" maxlength="10"
													tabindex="46"
													value="<%=Helper.correctNull((String)hshValues.get("perapp_spouseother"))%>">
												</td>
											</tr>

											<tr>
												<td width="16%"><font size="1" face="MS Sans Serif"> Whether
												any other close <br>
												relative intending to <br>
												join the loan transaction <br>
												as Guarantor</font></td>
												<td width="16%"><select name="selIfCoBorrow" tabindex="47">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
											
												<td width="16%"><font size="1" face="MS Sans Serif"> Whether
												applicant is NRI?</font></td>
												<td width="16%"><select name="selpensioner" tabindex="47">
													<option value="0" selected>----Select----</option>
													<option value="1">Yes</option>
													<option value="2">No</option>
												</select></td>
													<td width="16%"><font size="1" face="MS Sans Serif">Whether GPA holder Appointed?</font></td>
												<td width="16%"><font size="1" face="MS Sans Serif"> <select
													name="selGPA" onChange="enableGPAholder()" tabindex="48">
													<option value="1" ><font size="1" face="MS Sans Serif">Yes</font></option>
													<option value="2" selected><font size="1" face="MS Sans Serif">No</font></option>
												</select> </font></td>
										
												<td id="legalheiers"><input type="button" name="legal" value="Legal Heirs"
													onClick="ShowLegal('legalheirs.jsp')" style="width:100"
													class="buttoncolor"></td>
											</tr>
											<tr>
												<td width="26%" id="h1"><font size="1" face="MS Sans Serif"><b>General Power of Attorney Details</b>
												</font></td>
												</tr>
											<tr>
												<td width="16%" id="p1"><font size="1" face="MS Sans Serif">Name of the GPA holder
												</font></td>
												<td width="16%" id="p2"><font size="1" face="MS Sans Serif"
													width="16%"> <input type="text" name="txtperapp_GPAholder"
													size="30" maxlength="25" tabindex="48"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAHOLDERNAME"))%>"
													onKeyPress="">
												</font><font size="1" face="MS Sans Serif">&nbsp; </font></td>
												
												<td width="16%" id="a1"><font size="1" face="MS Sans Serif">Age</font></td>
												<td width="16%" id="a2"><font size="1" face="MS Sans Serif">
												 <input type="text"	name="txtperapp_GPAage" size="10" maxlength="2"
													tabindex="49"  	value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAHOLDERAGE"))%>"
													onKeyPress="allowNumber(this)" > </font></td>
													</tr>
												<tr>
												<td width="12%" id="add1"><font size="1" face="MS Sans Serif">Address</font></td>
												<td width="30%" id="add2"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAadd1" size="30"
													maxlength="50" tabindex="50"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAADDRESS1"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
												</tr>
												<tr>
												    <td width="12%" id="add3"><font size="1" face="MS Sans Serif"></font></td>
													<td width="30%" id="add4"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAadd2" size="30"
													maxlength="50" tabindex="50"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAADDRESS2"))%>"
													onKeyPress="notAllowedDouble()"> </font></td>
												</tr>
	
											<tr>
												<td width="12%" id="GPAcity1"><font size="1" face="MS Sans Serif">City</font><font
													size="1" face="MS Sans Serif">&nbsp;</font></td>
												<td width="30%"  id="GPAcity2"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAcity" size="18"
													maxlength="20" tabindex="51"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPACITY"))%>"
													onKeyPress="allowAlphabetsAndSpace()"> </font></td>
												
											</tr>
											<tr>
												<td width="12%" id="GPAState1"><font size="1" face="MS Sans Serif">State</font></td>
												<td width="22%" id="GPAState2"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAstate" size="15" maxlength="20"
													tabindex="52"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPASTATE"))%>"
													onKeyPress="allowAlphabetsAndSpace()"
													onBlur="changecase(document.forms[0].txtperapp_GPAstate)">
													 <a	href="javascript:ShowStates('3')" class="blackfont"><img src="<%=ApplicationParams.getAppUrl()%>img/Search.png" style="border: none" align="middle" height="25px"></a> </font></td>
												
											</tr>
											<tr>
												<td width="12%" id="GPApin1"><font size="1" face="MS Sans Serif"><%=ApplicationParams.getZipName()%></font></td>
												<td width="30%" id="GPApin2"><font size="1" face="MS Sans Serif"> <input
													type="text" name="txtperapp_GPAzip" size="12"
													maxlength="<%=ApplicationParams.getZipValue()%>"
													tabindex="53"
													value="<%=Helper.correctNull((String)hshValues.get("PERAPP_GPAZIP"))%>"
													onKeyPress="allowInteger()"> </font></td>
												
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
				</td>
			</tr>
		</table>		
		</td>
	</tr>
</table>
<!-- ************************************* END FOR SYNDICATE ************************************************ -->
<%} %>


<br>

<table width="12%" border="1" cellspacing="0" cellpadding="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
	class="outertablecolor" align="center">
	<tr>
		<td>
		<table width="43%" border="0" cellspacing="0" cellpadding="2">
			<tr valign="top">
				<td><input type="button" name="cmdEdit" value="Edit"
					style="width:50" class="buttoncolor" onClick="callEdit()"></td>
				<td><input type="button" name="cmdApply" value="Apply"
					style="width:50" class="buttoncolor" onClick="callApply()"></td>
				<td><input type="button" name="cmdCancel" value="Cancel"
					style="width:50" class="buttoncolor" onClick="callCancel()"></td>
				<td style="visibility: hidden;position: absolute;"><input type="button" name="cmdDelete" value="Delete"
					style="width:50" class="buttoncolor" onClick="callDelete()"></td>
				            <td height="0"> 
                <input type="button" name="cmdModify" value="Modify" style="width:50" class="buttoncolor"  onClick="callModify()" disabled>
              </td>
  
				<td><input type="button" name="cmdHelp" value="Help"
					style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
					onClick="callhelp()"></td>
				<td height="0">
				<input type="button" name="cmdClose"
					value="Close" onClick="callClose()"
					style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">				
				</td>
				<td  id="farm24" align="center" width="15%" id="id_processnote"><font size="1" face="MS Sans Serif"> 
<input type="button" name="processnote" value="Member Details" class="buttoncolor" onClick="callmemberdetails()">
</font></td>
		
			<td width="20%" align="left" id="dedupeNew"><font size="1"
				face="MS Sans Serif"> <input type="button"
				name="txt_dedupe" value="De-Dupe Check"
				style="width:50" class="buttoncolor"
				onclick="doDedupecheck()"></font></td>
				<td width="20%" align="left" id="CurrentExpo"><font size="1" face="MS Sans Serif"> <input type="button"
				name="CurrentExpo" value="Current Exposure" style="width:100" class="buttoncolor"onclick="CallEligible360Degree()"></font></td>
												</tr>	
			
		</table>
		</td>
	</tr>
</table>
<input type="hidden" name="hidApp_type" value='A'> <input type="hidden"
	name="hidBeanMethod" value=""> <input type="hidden" name="hidBeanId">
<input type="hidden" name="hidSourceUrl"> <input type="hidden"
	name="hidBeanGetMethod"> <input type="hidden" name="hidDemoId"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> <input
	type="hidden" name="hidAppType"> <input type="hidden" name="trapEdit"
	value=""> <input type="hidden" name="hidappstatus"
	value="<%=Helper.correctNull((String)hshValues.get("appstatus"))%>"> <input
	type="hidden" name="hidOldAppId"
	value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>"> <input
	type="hidden" name="scode" value="yyy"> <input type="hidden"
	name="mode" value="<%=mode%>">
	<input type="hidden" name="hid_comappid1" value="<%=Helper.correctNull((String)hshValues.get("perapp_id"))%>">
	<input type="hidden" name="currentdate"  value="<%=Helper.getCurrentDateTime()%>">
	<input type="hidden" name="txtperapp_appid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id")) %>">
	<input type="hidden" name="txt_perappid" value="<%=Helper.correctNull((String)hshValues.get("perapp_id")) %>">
	<input type="hidden" name="closeFlag" value="">
	
	</form>
</body>
</html>
