<%@include file="../share/directives.jsp"%>
<%
	String strType = Helper.correctNull((String) hshValues.get("com_compdttype"));
	String defflag = Helper.correctNull((String) hshValues.get("defflag"));
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strAppNo=Helper.correctNull((String)hshValues.get("appno"));
	if(strAppNo.equalsIgnoreCase(""))
	{
		strAppNo=Helper.correctNull((String)request.getParameter("hidappno"));
	}
	String strFreeze = Helper.correctNull((String)hshValues.get("strFreeze"));
	String strAppstatus=Helper.correctNull((String)request.getParameter("strappstatus"));
	String strGuarantor_corp=Helper.correctNull((String)hshValues.get("strGuarantor_corp"));
	String strCoappGuaCBS=Helper.correctNull((String)hshValues.get("StrCoappGuaCbs"));
	String strHunterScore = Helper.correctNull((String) hshValues
			.get("strAppHuntScore"));
	String strHunterScore1 = Helper.correctNull((String) hshValues
			.get("intcopHunterscore"));
	String strminhuntscore = Helper.correctNull((String) hshValues
					.get("dblHuntScore"));
	String strPropNo = Helper.correctNull((String) hshValues
			.get("APP_PERM_NO"));
	String strHunterCheck = Helper.correctNull((String) hshValues
			.get("DEV_DEVPARAM"));
	String strAppHuntStatus = Helper.correctNull((String) hshValues
			.get("strAppHuntStatus"));
	String strcophunterStatus = Helper.correctNull((String) hshValues
					.get("strcophunterStatus"));
	ArrayList arrAppid = new ArrayList();
	ArrayList arrAppid1 = new ArrayList();
	String StrTemp = "";
	StringBuffer strbuff = new StringBuffer();
	String temp1 = "";
	String temp = "";
	

	ArrayList arrCol = new ArrayList();
	ArrayList arrRow = new ArrayList();
	int intArrSize=0;
	int intArr1Size=0;
		

	if (hshValues != null)
		arrRow = (ArrayList) hshValues.get("HSCorelist");// applicant details
	
	if (arrRow != null && arrRow.size() > 0) {
		for (int i = 0; i < arrRow.size(); i++) {
			arrCol = (ArrayList) arrRow.get(i);
			if (i == 0) {
				temp = temp
						+ Helper.correctNull((String) arrCol.get(1)
								.toString())
						+ " ("
						+ Helper.correctNull((String) arrCol.get(0)
								.toString()) + ") ";
			} else {
				temp = temp
						+ " and "
						+ Helper.correctNull((String) arrCol.get(1)
								.toString())
						+ " ("
						+ Helper.correctNull((String) arrCol.get(0)
								.toString()) + ") ";

			}
		}
		
		intArrSize=arrRow.size();
	}
	
	
	ArrayList arrCol1 = new ArrayList();
	ArrayList arrRow1 = new ArrayList();
	
		if (hshValues != null)
			arrRow1 = (ArrayList) hshValues.get("HSCorelist1");// coapplicant details
		
		if (arrRow1 != null && arrRow1.size() > 0) {
			for (int i = 0; i < arrRow1.size(); i++) {
				arrCol1 = (ArrayList) arrRow1.get(i);
				if (i == 0) {
					temp1 = temp1
							+ Helper.correctNull((String) arrCol1.get(1)
									.toString())
							+ " ("
							+ Helper.correctNull((String) arrCol1.get(0)
									.toString()) + ") ";
				} else {
					temp1 = temp1
							+ " and "
							+ Helper.correctNull((String) arrCol1.get(1)
									.toString())
							+ " ("
							+ Helper.correctNull((String) arrCol1.get(0)
									.toString()) + ") ";

				}
			}
			
			intArr1Size=arrRow1.size();
		}
		String flag = "N";
		ArrayList arrCol14 = new ArrayList();
		ArrayList arrRow14 = new ArrayList();
		if (hshValues != null)
			arrRow14 = (ArrayList) hshValues.get("arrCol4");
		if (arrRow14 != null && arrRow14.size() > 0) {
			flag = "Y";
		}
		else
		{
			flag = "N";
		}
		
	String strAdhocFacDetails=Helper.correctNull((String)hshValues.get("strAdhocFacDetails"));
	String strcgtmseavail = Helper.correctNull((String)hshValues.get("strcgtmseavail"));
	//out.println("hshValues"+hshValues);
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var defflag = "<%=defflag%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var totalsharevalue="<%=Helper.correctNull((String) hshValues.get("totalsharevalue"))%>";
var comapp_totalshares="<%=Helper.correctNull((String) hshValues.get("comapp_totalshares"))%>";
var varappstatus="<%=strAppstatus%>";
var varSecFreeze="<%=Helper.correctNull((String)hshValues.get("strSecFreezeflag"))%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varFacility="<%=Helper.correctNull((String)hshValues.get("strFacilitySno"))%>";
var varPromotorId="<%=Helper.correctNull((String)hshValues.get("Prmotorsid"))%>";
var varApplicationno="<%=strAppNo%>";
var varPromotorsFreeze="<%=Helper.correctNull((String)hshValues.get("strFreeze"))%>";
var varInCompleteID="<%=Helper.correctNull((String)hshValues.get("strInCompleteID"))%>";
var varSessionModuleType="<%=strSessionModuleType%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
var varGuarantor_corp="<%=strGuarantor_corp%>";
var cgtmseavailmsg="<%=Helper.correctNull((String)hshValues.get("strcgtmseavailmsg"))%>";
var varStrAppid="<%=temp%>";
var arrRow = "<%=intArrSize%>";
var strHunterScore="<%=strHunterScore%>";
var strminhuntscore="<%=strminhuntscore%>";
var varNOtRequiredAppid="<%=Helper.correctNull((String)hshValues.get("strNOtRequiredAppid"))%>";
var varNOtRequiredFlag="<%=Helper.correctNull((String)hshValues.get("strNOtRequiredFlag"))%>";

//.....add...//
var varStrAppid1="<%=temp1%>";

var arrRow1 = "<%=intArr1Size%>";
var strHunterScore1="<%=strHunterScore1%>";
var strAppHuntStatus="<%=strAppHuntStatus%>";
var strcophunterStatus="<%=strcophunterStatus%>";
var varAdhocFacDetails="<%=strAdhocFacDetails%>";

var strPropNo="<%=strPropNo%>";
var strHunterCheck="<%=flag%>";
//vindhya begin
var ExposureChklimit= "<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>";
var Explimitchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>";
var varPancount="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>";
var varPanCheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>";
var ExposureChklimitagr= "<%=Helper.correctNull((String)hshValues.get("strdblExplimitagr"))%>";
var Explimitagrchk= "<%=Helper.correctNull((String)hshValues.get("strExplimitagrchk"))%>";
var Expmainactcheck="<%=Helper.correctNull((String)hshValues.get("strmainactcheck"))%>";
var Expcheck="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>";
//vindhya end
if(defflag == "Y")
{
	alert(defnam + " found in Defaulter List");
}

function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{		
	if(document.forms[0].cmdedit.disabled)
	{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}	
}

function callCalender(fname)
	{
	 	if(document.forms[0].cmdsave.disabled==false)
		{
		 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
		}
	}
function dateDOBCheck(objname)
	{
		var mycurrdate = new Date(currdate.substring(6,10),currdate.substring(3,5)-1,currdate.substring(0,2));	
  	  	var DOB =  objname.value
  	  	
      	var mydobdate = new Date(DOB.substring(6,10),DOB.substring(3,5)-1,DOB.substring(0,2));
	  	if (mydobdate >= mycurrdate)
	  	{
			alert("Date should not be greater or equal to current date");
			objname.focus();
			objname.value="";
			return;
	  	}	
	}
function placeValues()
{
	var selemp1="<%=Helper.correctNull((String) hshValues
									.get("COM_COMPDSEX"))%>";
	var stake1="<%=Helper.correctNull((String) hshValues
							.get("COM_COMPDSTKHOLDER"))%>";
	var str_type= "<%=strType%>";
	var val="<%=Helper.correctNull((String) hshValues
									.get("com_oldlapsid"))%>";
	var CBSRelation="<%=Helper.correctNull((String) hshValues.get("txt_relationship"))%>";
	var CBSBorrRelation="<%=Helper.correctNull((String) hshValues.get("cbs_borr_relation"))%>";
								
	
	if(val !="")
	{
		document.forms[0].cho_promoter.value = val;
		if(document.forms[0].btnenable.value=="Y")
		{
			enableButtons(false,false,true,false,false,false);
		}
		document.all.lapsid1.style.display="table-cell";
		document.all.lapsid2.style.display="table-cell";
		document.all.cbsid1.style.display="table-cell";
		document.all.cbsid2.style.display="table-cell";
	}
	else{
		document.all.lapsid1.style.display="none";
		document.all.lapsid2.style.display="none";
		document.all.cbsid1.style.display="none";
		document.all.cbsid2.style.display="none";
		if(document.forms[0].btnenable.value=="Y")
		{
			document.forms[0].cmdcancel.disabled=false;
		}
	}
	disablefields(true);

	if(selemp1!="")
	{
		document.forms[0].selemp.value=selemp1;
	}
	if(CBSRelation!="")
	{
		document.forms[0].sel_CBSrelation.value=CBSRelation;
	}
	if(CBSBorrRelation!="")
	{
		document.forms[0].sel_relation_type.value=CBSBorrRelation;
	}
	else
	{
		document.forms[0].selemp.value="S";
	}
	if(stake1!="")
	{
		document.forms[0].selstake.value=stake1;
	}
	else
	{
		document.forms[0].selstake.value="S";
	}
	if(str_type!="")
	{
		document.forms[0].Type.value=str_type;
	}
	else
	{
		document.forms[0].Type.value="S";
	}
	if(varFacility!="" || varFacility!="0")
	{
		document.forms[0].sel_facility.value=varFacility;
		getpromotors('N');
	}
	else
	{
		document.forms[0].sel_facility.value="0";
	}
	
	//var str_type_temp =str_type.split("@");	
	//for(var i=0;i<str_type_temp.length-1;i++)
	//{
		//var selValue=str_type_temp[i];
	
		//if("G"==selValue)	
		//{		
			//document.forms[0].Type.options[1].selected=true;
		///}			
		//else if("O"==selValue)
		//{			
			//document.forms[0].Type.options[2].selected=true;
		//}
		//else if("D"==selValue)
		//{			
			//document.forms[0].Type.options[3].selected=true;
		//}
		//else if("SP"==selValue)
		//{			
			//document.forms[0].Type.options[4].selected=true;
		//}			
		//else if("PT"==selValue)
		//{			
			//document.forms[0].Type.options[5].selected=true;
		//}
		//else if("OT"==selValue)
		//{			
			//document.forms[0].Type.options[6].selected=true;
		//}
		//else if("C"==selValue)
		//{			
			//document.forms[0].Type.options[7].selected=true;
		//}
		//else if("CO"==selValue)
		//{			
			//document.forms[0].Type.options[8].selected=true;
		//}
	//}

	//enableshares();
	
	if(varPostSanc=="P")
	{
		var boolflag=false;
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "GUAR")
			{
				boolflag=true;
			}
			
		}
		if(boolflag)
		{
			if(val !="")
			{
				document.forms[0].cmdnew.disabled=true;
				document.forms[0].cmdedit.disabled=false;
				document.forms[0].cmddelete.disabled=false;
			}
			else
			{
				document.forms[0].cmdnew.disabled=false;
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
			}
		}
		else
		{
			document.forms[0].cmdnew.disabled=true;
			if(val !="")
			{
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
			}
			else
			{
				document.forms[0].cmdedit.disabled=true;
				document.forms[0].cmddelete.disabled=true;
			}
		}
	}
	<%if(strFreeze.equalsIgnoreCase("Y")){%>
	enableButtons(true,true,true,true,true,false);
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=false;
	<%}else{%>
	
		document.forms[0].cmdfreeze.disabled=false;
		document.forms[0].cmdundo.disabled=true;
	<%}%>
	if(varSecFreeze=="Y")
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		enableButtons(true,true,true,true,true,true);
	}
	if(varappstatus=="pa"){
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
		enableButtons(true,true,true,true,true,true);
	}

	if(varGrpRights=='r')
	{
		document.forms[0].cmdfreeze.disabled=true;
		document.forms[0].cmdundo.disabled=true;
	}

	if(document.forms[0].hidFacgroup.value!="0")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=true;
	}

}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function doEdit()
{
	disablefields(false);
	document.forms[0].hidAction.value="update";
	document.forms[0].hideditflag.value="Y";
	enableButtons(true,true,false,false,false,true);
	document.forms[0].cho_promoter.disabled=true;
	document.forms[0].fname.readOnly=true;
	if(varPostSanc=="P")
	{
		document.forms[0].cmddelete.disabled=true;
		var boolflag=false;
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		for(var i=0;i<varPSterms.length;i++)
		{
			if(varPSterms[i] == "GUAR")
			{
				boolflag=true;
			}
			
		}
		if(boolflag)
		{
				document.forms[0].cmddelete.disabled=false;
		}
	}
	document.forms[0].sel_facility.disabled=true;
}

function doDelete()
{
	if(varPostSanc=="P" && document.forms[0].hidSecAvail.value=="Y")
	{
		alert("Kindly detach the securities of this guarantor for this facility and then proceed to delete");
		return;
	}
	if((document.forms[0].applevel.value=="S") && (document.forms[0].hidCreditIDCheck.value=="Y")) 
	{
			alert("Please detach the Co-applicant/Guarantor in credit report");
			return;
	}
	if(document.forms[0].cmdfreeze.disabled==true)
	{
		alert("Please Undo then delete the Co-applicant/Guarantor");
		return;
	}
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
	 	{
			document.forms[0].sel_facility.disabled=false;
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="compro";
			document.forms[0].hidBeanMethod.value="updatePromoter";
			document.forms[0].hidBeanGetMethod.value="getProData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
			document.forms[0].submit();
	    }
	}
	else
	{
		ShowAlert(158);
	}
}


function doSave()
{
	var str_type ="";
	if(document.forms[0].sel_facility.value=="0")
	{
		alert("Please Select Facility");
		document.forms[0].sel_facility.focus();
		return;
	}
	if(document.forms[0].Type.value=="S")
	{
		alert("Select the Type");
		document.forms[0].Type.focus();
		return false;
	}
	if(document.forms[0].fname.value=="")
	{
		alert("Enter Full Name");
		document.forms[0].fname.focus();
		return false;
	}
	if(document.forms[0].sel_relation_type.value=="0")
	{
		alert("Enter CBS Relation type");
		document.forms[0].sel_relation_type.focus();
		return false;
	}
	if(document.forms[0].sel_CBSrelation.value=="0")
	{
		alert("Enter Relationship to the borrower");
		document.forms[0].sel_CBSrelation.focus();
		return false;
	}
	if(document.forms[0].selemp.value=="S" || document.forms[0].selemp.value=="")
	{
		alert('Select Gender');
		return;
	}
	//if(document.forms[0].Type.options[2].selected==true)
	//{
		//if(document.forms[0].held.value=="")
		//{
			//alert('Enter Shares Held');
			//return;
		//}
	//}	
	document.forms[0].sel_facility.disabled=false;
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hid_str_type.value = str_type;
	document.forms[0].cho_promoter.disabled=false;
	document.forms[0].hidBeanId.value="compro"
	document.forms[0].hidBeanMethod.value="updatePromoter";
	document.forms[0].hidBeanGetMethod.value="getProData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
	document.forms[0].submit();	

}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidAction.value="get"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].hidBeanMethod.value="getValues";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
		document.forms[0].submit();

	 }
	
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appURL+"action/corppge.jsp";
		document.forms[0].submit();
	}
}


function callLink(page,bean,method)
{
	//pan check
	if(document.forms[0].freezeflag.value=="Y")
	{
		if(document.forms[0].varPanCheck.value=="Y")
		{ 
			if(document.forms[0].sessionmodule.value!="AGR")
			{
				
					if(document.forms[0].sessionmodule.value=="CORP")
					{					
							if(document.forms[0].Explimitchk.value=="F")
							 {
								 if (document.forms[0].varPancount.value=="N")
								{
								 alert(" Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
									return;
								}	 
							}				
					
					}
					else
					{			
					 if(document.forms[0].Explimitchk.value=="F")
						 {
							 if (document.forms[0].varPancount.value=="N")
							{
							 alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
								return;
							}	 
						}
					}	
			
				 
			}
			if(document.forms[0].sessionmodule.value=="AGR")
			{
				if(document.forms[0].Expmainactcheck.value>0)
				{	
				 if(document.forms[0].Explimitagrchk.value=="F")
					 {
						if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of "+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}
				else
				{
					if(document.forms[0].Explimitagrchk.value=="F")
					 {
						 if (document.forms[0].varPancount.value=="N")
						{
						 	alert("Please obtain PAN number of the Applicants (including co-applicant/Joint borrower/Co-applicant) Co-Obligant/guarantor and capture in CBS for exposure (includes existing and proposed limit) of Rs."+document.forms[0].Expcheck.value+"/- and above ");
							return;
						}	 
					}
				}	
			
			}
			
		}
	}
	//pan check
  	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=val;
		}	  
		else if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=val;
		}
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}		
	}
	document.forms[0].share.readOnly=true;
	document.forms[0].sel_facility.disabled=false;
}

function doNew()
{
	if(document.forms[0].sel_facility.value=="0")
	{
		alert("Please Select Facility");
		document.forms[0].sel_facility.focus();
		return;
	}
	var prd_cgtmse = document.forms[0].txt_prd_cgtmse.value; 
	var varAppId=document.forms[0].hidapplicantid.value;
	var	varQryString = appURL+"action/perapplicantidhelp.jsp?apptype=promoter&appid="+varAppId+"&appno="+document.forms[0].hidappno.value+"&strFacno="+document.forms[0].sel_facility.value+"&prd_cgtmse="+prd_cgtmse;;
	var title = "ApplicantIDHelp";
	var prop = "scrollbars=no,width=500,height=500";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 300) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(varQryString,title,prop);
	document.forms[0].hidAction.value="insert";
	disablefields(false);
	enableButtons(true,true,false,false,true,true);
	clearFields();
	//document.forms[0].cho_promoter.disabled=true;
    document.forms[0].hideditflag.value="Y";
    document.forms[0].fname.readOnly=true;
    document.forms[0].sel_facility.disabled=true;
}

function clearFields()
{
	document.forms[0].fname.value="";
	document.forms[0].addr1.value="";
	document.forms[0].addr2.value="";
	document.forms[0].phone.value="";
	document.forms[0].pin.value="";
	document.forms[0].city.value="";
	//document.forms[0].txt_desig.value="";
	document.forms[0].fax.value="";
	document.forms[0].cho_promoter.selectedIndex=0;
	document.forms[0].state.value="";
	document.forms[0].email.value="";
	document.forms[0].pin.value="";
	document.forms[0].city.value="";
	document.forms[0].addr2.value="";
	document.forms[0].phone.value="";
	document.forms[0].pin.value="";
	document.forms[0].city.value="";
	
	if("<%=strCategoryType%>"=="STL" || "<%=strCategoryType%>"=="ADC" || "<%=strCategoryType%>"=="SRE")
	{
	 document.forms[0].txt_means.value="";
	}
	document.forms[0].mname.value="";
	document.forms[0].lname.value="";
	document.forms[0].dob.value="";
	//document.forms[0].txt_academic.value="";
	document.forms[0].txt_exp.value="";
	document.forms[0].txt_background.value="";
	document.forms[0].share.value="";
	document.forms[0].held.value="";
	document.forms[0].facevalue.value="";
	document.forms[0].txt_capital.value="";
	document.forms[0].valdate.value="";
	document.forms[0].Type.selectedIndex=0;
	document.forms[0].selemp.value="S";
	document.forms[0].selstake.value="S";
	document.forms[0].txt_din.value="";
	document.forms[0].txt_prolapsid.value="";
	document.forms[0].txt_procbsid.value="";
	document.forms[0].txt_relshipthemselves.value="";
	document.forms[0].sel_CBSrelation.value="0";
	document.forms[0].sel_relation_type.value="0";
}
function getValues()
{
	if(document.forms[0].cho_promoter.selectedIndex>0)
	{
		document.forms[0].sel_facility.disabled=false;
		document.forms[0].hidAction.value="get"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getValues";
		document.forms[0].action=appURL+"action/compromoters.jsp";
		document.forms[0].submit();
	}
	else
	{
		document.all.lapsid1.style.display="none";
		document.all.lapsid2.style.display="none";
		document.all.cbsid1.style.display="none";
		document.all.cbsid2.style.display="none";
		clearFields();
		enableButtons(false,true,true,true,true,false);
		disablefields(true);
		if(varSecFreeze=="Y")
		{
			enableButtons(true,true,true,true,true,true);
		}
	}
}

function sharePercentage()
{
	<% if (strCategoryType.equalsIgnoreCase("STL")) {%>
	comapp_totalshares="20";
<%	}%>
	if(document.forms[0].hidAction.value=="insert")
	{
		var sharehold=eval(totalsharevalue)+eval(document.forms[0].held.value);
	}
	else
	{
		var sharehold=eval(totalsharevalue)+eval(document.forms[0].held.value)-eval(document.forms[0].hidsharevalue.value);
	}

	var shareheldind=NanNumber(document.forms[0].held.value);
	var sharepercent="";
	if(eval(shareheldind)>eval(comapp_totalshares))
	{
		alert("Enter proper share held");
	    document.forms[0].held.value="";
		return;
	}
	else if(eval(sharehold)>eval(comapp_totalshares))
 	{
		alert("Enter proper share held");
	  	document.forms[0].held.value="";
	 	return;
 	}
	else
	{
		sharepercent=NanNumber((eval(shareheldind)/eval(comapp_totalshares))*100);
		if(sharepercent!="NaN")
		{
			document.forms[0].share.value=round(sharepercent);
		}
		else
		{
			document.forms[0].share.value="";
		}
	}
}
function enableshares()
{
	if(document.forms[0].Type.options[2].selected)
	{
		document.all.idshares.style.visibility="visible";
		document.all.idshares.style.position="relative";
		document.all.t1.style.visibility="visible";
	}
	else
	{
		document.all.idshares.style.visibility="hidden";
		document.all.t1.style.visibility="hidden";
		document.all.idshares.style.position="absolute";
		document.forms[0].share.value="";
		document.forms[0].facevalue.value="";
		document.forms[0].held.value="";
	}
}
function doFreeze()
{
	//alert(varNOtRequiredFlag);
	
	<%if(!strAdhocFacDetails.equalsIgnoreCase("")){%>
	alert("Tenor/Due date of Adhoc/additional limits should not be greater than Regular limit tenor/due date - Check facility serial number "+varAdhocFacDetails);
	return;
	<%}%>
	<%if(strcgtmseavail.equalsIgnoreCase("Y")){%>
	if(varNOtRequiredFlag=="Y")
	{
		alert("Co applicant/Guarantor/Coobligant is not attached in Customer Profile -Groups / Management People details tab\n"+varNOtRequiredAppid);
		return;
	}
		alert("Co-applicant/Guarantor/Coobligant cannot be attached if borrower has CGTMSE coverage except Proprietors,Partners,Directors, Trustees/Karta who are attached in Customer Profile - Group Management People Details tab \n"+cgtmseavailmsg);
		return;
    <%}%>
	if(arrRow>0&&false)
	{
		if(strAppHuntStatus=="Y"){
		alert("Hunter Score is less than "+strminhuntscore+" for the "+varStrAppid+" further processing shall not be allowed.");
		return;
	   }

		if(strPropNo=="")
		{
			alert("Kindly attach the Permission Proposal since Hunter Score is less than the minimum score");
			return;
		}
		else if(strPropNo!="" && strHunterCheck=="N")
		{
			alert("Kindly attach the valid Permission Proposal with Deviation in Hunter score");
			return;
		}
	}
	if(arrRow1>0&&false)
	{
		alert("Hunter Score is less than "+strminhuntscore+" for the "+varStrAppid1+" further processing shall not be allowed.");
		return;
	}
	
	
	
	<%if(!strCoappGuaCBS.equals("")){%>

		var temp="<%=strCoappGuaCBS%>";
		alert("The following Applicant Details are not added in Customer profile("+temp+").Kindly remove and proceed");
		return;
	<%}%>
	if(varInCompleteID!="")
	{
		alert("You cannot do this action.The following Applicant Details are partial in Customer profile("+varInCompleteID+")");
		return;
	}
	if(varGuarantor_corp=="N")
	{
		alert("You cannot Freeze .The Guarantor/Co-Applicant details are not completed fully.");
		return;
	}
	
	showProgress('imgloading');
	window.scrollTo(0, 0);
	document.forms[0].cmdfreeze.disabled=true;
	document.forms[0].hidAction.value="freeze"
	document.forms[0].hidBeanId.value="bankappfi"
	document.forms[0].hidBeanGetMethod.value="getFreezeData";
	document.forms[0].action=appURL+"action/compromoters.jsp";
	document.forms[0].submit();
}
function doUndo()
{

	if(varSessionModuleType=="AGR")
	{
		if(confirm("DSS entries will be Deleted, Do you want to proceed?"))
		{
			document.forms[0].hidAction.value="Undo";
			document.forms[0].hidBeanId.value="compro";
			document.forms[0].hidBeanMethod.value="updatePromoter";
			document.forms[0].hidBeanGetMethod.value="getProData";
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		document.forms[0].hidAction.value="Undo";
		document.forms[0].hidBeanId.value="compro";
		document.forms[0].hidBeanMethod.value="updatePromoter";
		document.forms[0].hidBeanGetMethod.value="getProData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/compromoters.jsp";
		document.forms[0].submit();
	}
}
function getpromotors(flag)
{
	var varProId=document.forms[0].cho_promoter.value;
	var varappno=document.forms[0].hidappno.value;
	if(flag=="Y")
	{
		if(document.forms[0].sel_facility.value=="0")
		{
			alert("Please Select Facility");
			document.forms[0].sel_facility.focus();
			return;
		}
		clearFields();
	}
	if(varProId=="")
	{
		varProId=varPromotorId;
	}
	if(varappno=="")
	{
		varappno=varApplicationno;
	}
	if(varappno=="")
	{
		varappno=document.forms[0].appno.value;
	}
	if(document.forms[0].sel_facility.value!="0")
	{
		document.all.ifrm.src = appURL+ "action/iframepromotors.jsp?hidBeanGetMethod=getPromotorsList&hidBeanId=compro&strFacility="+document.forms[0].sel_facility.value+"&appno="+varappno+"&strProId="+varProId+"&strChange="+flag;
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="placeValues();sharePercentage()">
<div id='imgloading' style="display:none;">
<img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"></div>
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
<form name="frmpri" method="post" class="normal">
<%if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="subpageid" value="102" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../share/applurllinkscom.jsp"
			flush="true">
			<jsp:param name="pageid" value="2" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<%if (strCategoryType.equalsIgnoreCase("SRE")) {%> 
		<td class="page_flow">
		Home -&gt; Corporate &amp; SME -&gt; Short Review/Extension -&gt; Co-Applicant / Guarantor -&gt; Co - Applicant / Guarantor </td>
		<%} else if (strCategoryType.equalsIgnoreCase("ADC")) {%>
		<td class="page_flow"> Home
		-&gt; Corporate &amp; SME -&gt; Adhoc -&gt; Co-Applicant / Guarantor </td>
		<%} else if (strCategoryType.equalsIgnoreCase("STL")) {%>
		<td class="page_flow">
		Home -&gt; Corporate &amp; SME -&gt; Short Term Loan -&gt; Co-Applicant / Guarantor
		-&gt; Co-Applicant / Guarantor </td>
		<%} else if(strSessionModuleType.equalsIgnoreCase("AGR")){%>
		<td class="page_flow"> Home -&gt; Agriculture -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Co-Applicant / Guarantors </td>
		<%}else{%>
		<td class="page_flow"> Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Co-Applicant / Guarantor -&gt;
		Co-Applicant / Guarantors </td>
		<%} %>
	</tr>
</table>
<span style="display: none"> <lapschoice:borrowertype /></span><lapschoice:application />
<%if (!strCategoryType.equalsIgnoreCase("ADC")) {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td valign="bottom">
		<table border="0" cellspacing="1" cellpadding="3" class="outertable">
			<tr align="center">
				<td class="sub_tab_active" id="prin"><b> Co-Applicant / Guarantor</b></td>
				<%
					if (strCategoryType.equalsIgnoreCase("CORP")
								|| strCategoryType.equalsIgnoreCase("SME")) {
				%>
				<!-- <td class="sub_tab_inactive" id="prin"><b><b><a
					href="#" onclick="javascript:callLink('com_companybackground.jsp','compro','getCompanyBackground')">Promoter
				Company / Group Companies Background</a></b></b></td> -->
				<%
					}
				%>
				<td class="sub_tab_inactive" id="prin" nowrap><b><b><a
					href="#" onclick="javascript:callLink('comgroupcompanies.jsp','executive','getData7')">Group
				Concerns</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_shareholdpattern.jsp','executive','getDataShareHoldPattern')">Share Holding Pattern</a></b></b></td>
				<td class="sub_tab_inactive" nowrap="nowrap"><b><b><a href="javascript:callLink('com_promocomments.jsp','compro','getgroupcomments')">Comments</a></b></b></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%
	}}
%>
<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td valign="top">
						<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
													<td width="40%">
													<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
													<tr>
													<td width="20%">Facility</td>
													<td width="18%"><select name="sel_facility" onchange="getpromotors('Y');">
													<option value="0"><--Select--></option>
													<lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>'  page='pro'/>
													<td colspan="2">&nbsp;</td>
													</tr>
													<tr>
														<td width="20%" nowrap="nowrap">
														<DIV ALIGN="LEFT">Select Principal <span
															class="mantatory"><b>*</b></span></DIV>
														</td>
														<td width="18%"><select name="cho_promoter"
															tabindex="1" size="1" style="width: 150"
															onChange="javascript:getValues()">
															<option selected value='S'>-- Select --</option>
														</select></td>
														</tr>
														<tr><td colspan="2">&nbsp;</td></tr>
														<tr>
														<td id="lapsid1" nowrap="nowrap" width="18%">
														<DIV ALIGN="LEFT">LAPS ID </DIV>
														</td>
														<td id="lapsid2"><input type="text" name="txt_prolapsid" value="<%=Helper.correctNull((String)hshValues.get("Prmotorsid")) %>" size="10" class="finaclefieldsbgcolor" readonly="readonly"></td>
														</tr>
														<tr>
														<td id="cbsid1" nowrap="nowrap" width="18%">
														<DIV ALIGN="LEFT">CBS Customer ID </DIV>
														</td>
														<td id="cbsid2"><input type="text" name="txt_procbsid" value="<%=Helper.correctNull((String)hshValues.get("PromotorsCBSID")) %>" size="15" class="finaclefieldsbgcolor" readonly="readonly"></td>
														</tr>
														</table>
														</td>
														<td width="15%" valign="top">Type <span class="mantatory"><b>*</b></span>
														</td>
														<td width="35%" valign="top"><select name="Type" TABINDEX="2" 
															>
															<option value="S">-- Select --</option>
															<option value="G">Guarantor</option>
															<option value="C">Co-Applicant</option>
															<option value="CO">Co-Obligant</option>
															<option value="SP">Sole Proprietor</option>
														</select></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr>
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="3"
											class="outertable border1">
											<tr>
												<td>

												<table width="100%" border="0" cellspacing="0"
													cellpadding="5" class="outertable">
													<tr>
														<td width="18%">Full Name<span class="mantatory"><b>*</b></span></td>
														<td width="31%"><input type="text" TABINDEX="3"
															name="fname" size="50" maxlength="80"
															onKeyPress="notAllowSplChar();allowAlphabetsForName()"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtfname"))%>" readonly;>
														</td>
														
														<td>CBS Relation type<span class="mantatory"><b>*</b></td>
									                        <td ><select name="sel_relation_type" onChange="">
									                            <option value="0" selected>-- Select --</option>
									                            <lapschoice:CBSStaticDataNewTag apptype="33" />
									                          </select></td>
														
														<input type="hidden" TABINDEX="4"
															name="mname" size="50" maxlength="80"
															onKeyPress="notAllowSplChar()"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtmname"))%>">
														
													</tr>
													<tr>
													<td>
														Relationship among themselves</span>
														</td>
														<td>
														<input type="text" name="txt_relshipthemselves" value="<%=Helper.correctNull((String)hshValues.get("com_relthemselves")) %>" size="25" maxlength="55">
														</td>
														
													<td>
														Relationship to borrower<span class="mantatory"><b>*</b></span>
														</td>
														<td ><select name="sel_CBSrelation" onChange="">
								                            <option value="0" selected>-- Select --</option>
								                            <lapschoice:CBSStaticDataNewTag apptype="32" />
								                          </select>
								                         </td>
<!--														<td>-->
<!--														<input type="text" name="txt_relationship" value="<%=Helper.correctNull((String)hshValues.get("txt_relationship")) %>" size="25" maxlength="55">-->
<!--														</td>-->
													</tr>
													<tr>
														<td width="18%">Short Name</td>
														<td width="31%"><input type="text" name="lname"
															TABINDEX="5" size="50" maxlength="80"
															onKeyPress="notAllowSplChar()"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtlname"))%>">
														</td>
														<td width="15%">Date of Birth</td>
														<td width="36%"><input type="text" name="dob"
															size="12" TABINDEX="6" maxlength="10"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtdob"))%>"
															onBlur="checkDate(this);dateDOBCheck(this);" readOnly="readonly">
														<a alt="Select date from calender"
															href="javascript:callCalender('dob')"><img
															src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
															width="21" height="18" border="0"></a></td>
													</tr>
													<tr>
														<TD WIDTH="18%">Gender of Promoter/Directors/Partners<span
															class="mantatory"><b>*</b></span></TD>
														<TD WIDTH="31%"><SELECT NAME="selemp" TABINDEX="7">
															<OPTION VALUE="S" selected>----Select----</OPTION>
															<OPTION VALUE="M">Male</OPTION>
															<OPTION VALUE="F">Female</OPTION>
															<OPTION VALUE="O">Others</OPTION>
														</SELECT></TD>
														<td width="15%">Director Identification Number(DIN)</td>
                                          <td width="36%"> 
                                          <input type="text" name="txt_din" tabindex="10" size="11" value="<%=Helper.correctNull((String)hshValues.get("COM_COMPDTDIN"))%>"
											maxlength="10" onKeyPress="notAllowSplChar()">
                                          </td>
														<!--<td width="15%">Academic Qualification</td>
														<td width="36%"><input type="text"
															name="txt_academic"
															value="<%=Helper.correctNull((String) hshValues.get("COM_COMPDACA"))%>"
															size="30" maxlength="25" style="text-align: left;"
															TABINDEX="8"></td>-->
													</tr>
													<!--<tr>
														<TD WIDTH="18%">Designation</TD>
														<TD WIDTH="31%"><input type="text" name="txt_desig"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtdesignation"))%>"
															size="30" maxlength="100" style="text-align: left;"
															TABINDEX="9"></TD>
													 <td width="15%">Director Identification Number(DIN)</td>
                                          <td width="36%"> 
                                          <input type="text" name="txt_din" tabindex="10" size="11" value="<%=Helper.correctNull((String)hshValues.get("COM_COMPDTDIN"))%>"
											maxlength="10" onKeyPress="notAllowSplChar()">
                                          </td>
													</tr>-->
													<tr>
														<td width="18%">Experience of Promoters/Directors</td>
														<td width="31%"><input type="text" name="txt_exp"
															size="30" maxlength="50"
															value="<%=Helper.correctNull((String) hshValues.get("COM_COMPDEXP"))%>"
															style="text-align: left;" TABINDEX="11"></td>
														<td width="15%">Whether the promoter is major stake
														holder</td>
														<td width="36%"><select name="selstake" TABINDEX="12">
															<option value="S" selected>----Select----</option>
															<option value="Yes">Yes</option>
															<option value="No">No</option>
														</select></td>
													</tr>

													<tr>
														<td width="18%">Address</td>
														<td width="31%"><input type="text" name="addr1"
															tabindex="13" size="30" maxlength="99" onKeyPress=""
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtaddress1"))%>">
														</td>
														<td width="18%">City</td>
														<td width="31%"><input type="text" name="city"
															TABINDEX="14" size="30" maxlength="49"
															onKeyPress="allowAlphabets()"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtcity"))%>">
														</td>
													</tr>
													<tr>
														<td width="15%">&nbsp;</td>
														<td width="36%"><input type="text" name="addr2"
															size="30" TABINDEX="15" maxlength="99" onKeyPress=""
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtaddress2"))%>">
														</td>
														<td width="15%">State</td>
														<td width="36%"><input type="text" name="state"
															TABINDEX="16" size="30" onKeyPress="allowAlphabets()"
															maxlength="49"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtstate"))%>"
															readOnly="readonly"></td>
													</tr>
													<tr>
														<td width="18%"><%=ApplicationParams.getZipName()%></td>
														<td width="31%"><INPUT TYPE="text" NAME="pin"
															SIZE="12" TABINDEX="17" onKeyPress="allowNumber(this)"
															MAXLENGTH="<%=ApplicationParams.getZipValue()%>"
															VALUE="<%=Helper.correctNull((String) hshValues.get("com_compdtpin"))%>"
															ONBLUR="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
														</td>
														<td width="15%">Phone</td>
														<td width="36%"><input type="text" name="phone"
															size="30" TABINDEX="18" maxlength="15"
															onKeyPress="allowNumber(this)"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtphone"))%>">
														</td>
													</tr>
													<tr>
														<td width="18%">Fax</td>
														<td width="31%"><input type="text" name="fax"
															size="30" TABINDEX="19" maxlength="15"
															onKeyPress="allowNumber(this)"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtfax"))%>">
														</td>
														<td width="15%">Email</td>
														<td width="36%"><input type="text" name="email"
															size="30" TABINDEX="20" maxlength="99"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtemail"))%>"
															onblur="isEmailAddr(document.forms[0].email.value,document.forms[0].email)">
														</td>
													</tr>
													<tr>
														<td width="18%" valign="top">Brief Background</td>
														<td><textarea name="txt_background" cols="60"
															style="text-align: left;" tabindex="21" rows="8" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues.get("com_background"))%></textarea></td>
														<%
															if (strCategoryType.equalsIgnoreCase("ADC")
																	|| strCategoryType.equalsIgnoreCase("STL")
																	|| strCategoryType.equalsIgnoreCase("SRE")) {
														%>
														<td>Means</td>
														<td><lapschoice:CurrencyTag name="txt_means"
															size="15" tabindex="22"
															value='<%=Helper.correctNull((String) hshValues.get("means"))%>'
															maxlength="12" /></td>
														<%
															}
														%>
													</tr>
													<tr>
														<td>Capital Contribution</td>
														<td><lapschoice:CurrencyTag name="txt_capital" size="30"
															tabindex="23" maxlength="10"
															value='<%=Helper.correctNull((String) hshValues.get("capcontribution"))%>'/></td>
														<td width="15%">As on Date</td>
														<td width="36%"><input type="text" name="valdate"
															size="12" tabindex="24" maxlength="10"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdate"))%>"
															onBlur="checkDate(this);dateDOBCheck(this);" readOnly>
														<a alt="Select date from calender"
															href="javascript:callCalender('valdate')"><img
															src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
															width="21" height="18" border="0"></a></td>
													</tr>
												</table>
												</td>
											</tr>
										</table>
										</td>
									</tr>
									<tr id="idshares">
										<td>
										<table width="100%" border="0" cellspacing="0" cellpadding="5"
											class="outertable border1">
											<tr>
												<td>
												<table width="100%" border="0" cellspacing="0"
													cellpadding="5" class="outertable">
													<tr>
														<td width="18%">Share (%)</td>
														<td width="31%"><input type="text" name="share"
															size="8" maxlength="49" tabindex="24"
															value="<%//=jtn.format(dbl_comdtpershare)%>"
															onBlur="roundtxt(share);checkPercentage(this)"
															onKeyPress="allowNumber(this)" readOnly></td>
														<td width="15%">Shares Held<span
															class="mantatory" maxlength="49" id="t1"><b>*</b></span></td>
														<td width="36%"><input type="text" name="held"
															size="30" maxlength="49" tabindex="25"
															onBlur="sharePercentage()"
															value="<%=Helper.correctNull((String) hshValues.get("com_compdtshareheld"))%>"
															onKeyPress="allowInteger(this)"></td>

													</tr>
													<tr>
														<td width="18%">Total Value of Shares (Rs.)</td>
														<td width="31%"><lapschoice:CurrencyTag name="facevalue"
															size="30" tabindex="26" maxlength="10"
															value='<%=Helper.correctNull((String) hshValues.get("com_facevalue"))%>' /></td>
														<td>&nbsp;</td>
														<td>&nbsp;</td>
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
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew
	btnnames="New_Edit_Save_Delete_Cancel_Audit Trail_Freeze_Undo"
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hid_str_type"
	value="<%=Helper.correctNull((String) hshValues
							.get("com_compdttype"))%>">
<input type="hidden" name="cho"
	value="<%=Helper.correctNull((String) hshValues
									.get("com_oldlapsid"))%>">
<input type="hidden" name="defflag" value="N"> <input
	type="hidden" name="hidsharevalue"
	value="<%=Helper.correctNull((String) hshValues
							.get("com_compdtshareheld"))%>">
<input type="hidden" name="networth" value="0.00"> <INPUT
	TYPE="hidden" name="hidCreditIDCheck"
	value="<%=Helper.correctNull((String) hshValues
							.get("creditAppidCheck"))%>">
<input type="hidden" name="hidDemoId" value="<%=Helper.correctNull((String)hshValues.get("com_compdtappid"))%>">
<input type="hidden" name="hidOldId" value="<%=Helper.correctNull((String)hshValues.get("com_oldlapsid"))%>">
<input type="hidden" name="hidSecAvail" value="<%=Helper.correctNull((String)hshValues.get("Sec_available"))%>">
<input type="hidden" name="hidappno" value="<%=strAppNo%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidFacgroup" value="<%=Helper.correctNull((String)hshValues.get("facility_group"))%>">
<input type="hidden" name="txt_prd_cgtmse" value="">
<input type="hidden" name="freezeflag" value="<%=Helper.correctNull((String)hshValues.get("strFreeze"))%>"> <!--pan check -->
<input type="hidden" name="ExposureChklimit" value="<%=Helper.correctNull((String)hshValues.get("strdblExplimit"))%>"> <!--pan check -->
<input type="hidden" name="Explimitchk" value="<%=Helper.correctNull((String)hshValues.get("strExplimitchk"))%>"> <!--pan check -->
<input type="hidden" name="varPancount" value="<%=Helper.correctNull((String)hshValues.get("Pancount"))%>"> <!--pan check -->
<input type="hidden" name="varPanCheck" value="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>"> <!--pan check -->
<input type="hidden" name="ExposureChklimitagr" value="<%=Helper.correctNull((String)hshValues.get("strdblExplimitagr"))%>"> <!--pan check -->
<input type="hidden" name="Explimitagrchk" value="<%=Helper.correctNull((String)hshValues.get("strExplimitagrchk"))%>"> <!--pan check -->
<input type="hidden" name="Expmainactcheck" value="<%=Helper.correctNull((String)hshValues.get("strmainactcheck"))%>"> <!--pan check -->
<input type="hidden" name="Expcheck" value="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>"> <!--pan check -->
<input type="hidden" name="sessionmodule" value="<%=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim()%>"> 
<iframe height="0" width="0" id="ifrm" frameborder="0" style="border: 0"></iframe>
</form>
</body>
</html>
