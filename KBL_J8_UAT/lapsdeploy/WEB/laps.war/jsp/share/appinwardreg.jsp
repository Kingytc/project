<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strProposal = Helper.correctNull((String) hshValues
			.get("inward_proptype"));
	if (strProposal.equals("")) {
		strProposal = Helper.correctNull((String) request
				.getParameter("hidproposal"));
	}
	String strgender = Helper.correctNull((String) hshValues
			.get("inward_gender"));
	if (strgender.equals("")) {
		strgender = Helper.correctNull((String) request
				.getParameter("hidgender"));
	}
	String strpurpose = Helper.correctNull((String) hshValues
			.get("INWARD_ENQUIRYPURPOSE"));
	if (strgender.equals("")) {
		strgender = Helper.correctNull((String) request
				.getParameter("hidpurpose"));
	}
	String strSector = Helper.correctNull((String) request
			.getParameter("hidsector"));
	if (strSector.equals(""))
		strSector = Helper.correctNull((String) hshValues
				.get("sectordesc"));
	String strSaral = Helper.correctNull((String) request
			.getParameter("hidsaral"));
	if (strSaral.equals(""))
		strSaral = "saral";
	String strappliedfor = Helper.correctNull((String) hshValues
			.get("borrowertype"));
	if (strappliedfor.equals(""))
		strappliedfor = Helper.correctNull((String) request
				.getParameter("appliedfor"));
	String strNew = Helper.correctNull((String) request
			.getParameter("new"));
	String strstatus = Helper.correctNull((String) request
			.getParameter("hidstatus"));
	if (strstatus.equals(""))
		strstatus = Helper
				.correctNull((String) hshValues.get("status"));
	String strappassign = Helper.correctNull((String) request
			.getParameter("hidappassign"));
	if (strappassign.equals(""))
		strappassign = Helper.correctNull((String) hshValues
				.get("assignusrid"));
	//String strAppAtached = Helper.correctNull(request
			//.getParameter("hidappatached"));
	//if (strAppAtached.equals(""))
		String	strAppAtached = Helper.correctNull((String) hshValues
				.get("appatached"));
	String customername = Helper.correctNull((String) hshValues
			.get("customername"));
	String inwardno = Helper.correctNull((String) hshValues
			.get("inwardno"));
	String valuesin = Helper.correctNull((String) hshValues
			.get("valuesin"));
	String IsSaralhead = Helper.correctNull((String) hshValues
			.get("IsSaralhead"));
	String ISorghead = Helper.correctNull((String) hshValues
			.get("ISorghead"));
	String strAppOrgName = Helper.correctNull((String) hshValues
			.get("orgname"));
	String strIpAddress = Helper.correctNull((String) hshValues
			.get("ipaddress"));
	
	String strPageFrom = Helper.correctNull((String) request
			.getParameter("strPageFromnsdl"));
	
	String strNSDLRefNo=Helper.correctNull((String) request
			.getParameter("strRefNo"));
	if(strNSDLRefNo.equalsIgnoreCase(""))
			strNSDLRefNo=Helper.correctNull((String)hshValues.get("inward_nsdlrefno"));	
	
	String strAppname=Helper.correctNull((String) request.getParameter("strAppname"));
	if(strAppname.equalsIgnoreCase(""))
		strAppname=Helper.correctNull((String)hshValues.get("strAppname"));	
	String strAppDOB=Helper.correctNull((String) request.getParameter("strAppDOB"));
	if(strAppDOB.equalsIgnoreCase(""))
		strAppDOB=Helper.correctNull((String)hshValues.get("strAppDOB"));	

	String strPropCreateDate=Helper.correctNull((String)hshValues.get("createdon"));
	if(strPropCreateDate.equalsIgnoreCase(""))
		strPropCreateDate=Helper.getCurrentDateTime();
	
	String strinwexappflag=Helper.correctNull((String)hshValues.get("INWARD_EXTERNALAPP_FLAG"));
	//out.println("strPanCheck"+Helper.correctNull((String)hshValues.get("strPanCheck")));
%>
<html>
<head>
<title>ACKNOWLEDGEMENT SLIP</title>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/appinwardreg.js"></script>
	<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var category = "<%=Helper.correctNull((String) hshValues.get("category"))%>";
var vardocreceived = "<%=Helper.correctNull((String) hshValues
									.get("docreceived"))%>";
var varapplnprocess = "<%=Helper.correctNull((String) hshValues
									.get("processedat"))%>";
var varborrowertype="<%=Helper.correctNull((String) hshValues
									.get("borrowertype"))%>";
var vardataexists="<%=Helper.correctNull((String) hshValues.get("dataexists"))%>";
var varappliedfor="<%=Helper.correctNull((String) hshValues
							.get("inward_appliedfor"))%>";
var varproptype="<%=Helper.correctNull((String) hshValues
							.get("inward_proptype"))%>";
var varipaddress="<%=strIpAddress%>";
var varselgender="<%=Helper.correctNull((String) hshValues
							.get("INWARD_GENDER"))%>";
var varselcibilreport="<%=Helper.correctNull((String) hshValues
							.get("INWARD_CIBILREPORT"))%>";
var varselenquiry="<%=Helper.correctNull((String) hshValues
							.get("INWARD_ENQUIRYPURPOSE"))%>";
var varappstatus="<%=Helper.correctNull((String) hshValues
								.get("inward_appstatus"))%>";
var varbankscheme="<%=Helper.correctNull((String) hshValues
									.get("inward_bankscheme"))%>";
var varschemedesc="<%=Helper.correctNull((String) hshValues
										.get("inward_schemedesc"))%>";
var varssitype="<%=Helper.correctNull((String) hshValues.get("INWARD_SSI"))%>";
var varTiny="<%=Helper.correctNull((String) hshValues.get("INWARD_TINY"))%>";
var varstrnew="<%=strNew%>";
var varstatus="<%=strstatus%>";
var varstrOrgLevel="<%=strOrgLevel%>";
var varstrAppAtached="<%=strAppAtached%>";
var varstrIsSaral="<%=strIsSaral%>";
var varstrSaral="<%=strSaral%>";
var varGovtSubSidy="<%=Helper.correctNull((String)hshValues.get("inward_govtspons"))%>";
var varSchemGovtType="<%=Helper.correctNull((String)hshValues.get("inward_schmetype"))%>";
var varSponserAgency="<%=Helper.correctNull((String)hshValues.get("inward_sponagency"))%>"
var varSubsidyType="<%=Helper.correctNull((String)hshValues.get("inward_subsdtype"))%>";
var varCurrentDate="<%=Helper.getCurrentDateTime()%>";
var varAttachFlag="<%=Helper.correctNull((String)hshValues.get("appattachFlag"))%>";
var varcanvassedbystaff="<%=Helper.correctNull((String)hshValues.get("inward_canvassedbystaff"))%>";
var varINWARD_LEADGENBY="<%=Helper.correctNull((String)hshValues.get("INWARD_LEADGENBY"))%>";
var varborrowerstatus="<%=Helper.correctNull((String)hshValues.get("inward_borrowerstatus"))%>";
var varPageFrom="<%=strPageFrom%>";
var varPropCreateDate="<%=strPropCreateDate%>";
var varorgscode="<%=Helper.correctNull((String)hshValues.get("orgscode"))%>";
var varScode="<%=Helper.correctNull((String)session.getAttribute("strOrgShortCode"))%>";
var varRLPFUser="<%=Helper.correctNull((String)session.getAttribute("strRLPFUser"))%>";
//var usr_rlpftype="<%//=Helper.correctNull((String)hshValues.get("usr_rlpftype"))%>";
var varEduDate="<%=Helper.correctNull((String)session.getAttribute("strEduDate"))%>";

var varEXTERNALAPP_FLAG="<%=Helper.correctNull((String)hshValues.get("INWARD_EXTERNALAPP_FLAG"))%>";
var varADDRESSCHANGE_FLAG="<%=Helper.correctNull((String)hshValues.get("INWARD_ADDRESSCHANGE_FLAG"))%>";
var varCIBILSCORE="<%=Helper.correctNull((String)hshValues.get("INWARD_CIBILSCORE"))%>";
var varCIBILDETAILS="<%=Helper.correctNull((String)hshValues.get("INWARD_CIBILDETAILS"))%>";
var varLeadRegion="<%=Helper.correctNull((String)hshValues.get("INWARD_LEADREGION"))%>";
var varinwexappflag="<%=strinwexappflag%>";
var varOnlineURL="<%=Helper.correctNull((String)hshValues.get("DMSUPLOAD"))%>";
var varLMSAvail="<%=Helper.correctNull((String)hshValues.get("strLMSAvail"))%>";
var varsourcedby="<%=Helper.correctNull((String)hshValues.get("SOURCE_BY"))%>";
var varsourcedbyreason="<%=Helper.correctNull((String)hshValues.get("REASON_JS"))%>";

var varpanchecklimit="<%=Helper.correctNull((String)hshValues.get("strChecklimit"))%>"; //vindhya 
var varpancheck="<%=Helper.correctNull((String)hshValues.get("strPanCheck"))%>"; //vindhya 

function showhide()
{	
if(document.forms[0].selcusttype.value=="E")
{
	document.all.idtest.style.visibility="hidden";
	document.all.exist.style.visibility="hidden";
	document.all.iddistrict.style.display="none";
}
else
{
	document.all.idtest.style.visibility="visible";
	document.all.exist.style.visibility="visible";
	document.all.iddistrict.style.display="inline";
}	
}
function chkLoanAmount(obj)
{
	if(varAttachFlag=="Y")
	{
		if(document.forms[0].choose_type[0].checked==true)
		{
			if((eval(document.forms[0].txtret_ftf.value)>0.0) && (eval(document.forms[0].txtret_ftf.value)<eval(document.forms[0].hidLoanAmount.value)))
			{
				alert("Amount should not be lesser than Proposed Requested Amount Rs. "+roundVal(document.forms[0].hidLoanAmount.value));
				obj.value="";
				obj.focus();
			}
		}
		else if((document.forms[0].choose_type[1].checked==true)||(document.forms[0].choose_type[2].checked==true))
		{
			var vartotal=eval(document.forms[0].txtcomcust_fwc.value)+eval(document.forms[0].txtcomcust_ftf.value)+eval(document.forms[0].txtcomcust_nf.value);
			if((eval(vartotal)>0.0)&&(eval(vartotal)<eval(document.forms[0].hidLoanAmount.value)))
			{
				alert("Amount should not be lesser than Sum of Proposed Requested Amount Rs. "+roundVal(document.forms[0].hidLoanAmount.value));
				obj.value="";
				obj.focus();
			}
		}
	}
}
function chkbankscheme()
{
	if((document.forms[0].choose_type[0].checked==true)&&(varAttachFlag=="Y")&&(document.forms[0].sel_bankscheme.value!="")&&(document.forms[0].sel_bankscheme.value!=varbankscheme))
	{
		//alert("Attached in Proposal,So you cannot made any changes in bank scheme");
		//document.forms[0].sel_bankscheme.value=varbankscheme;
		//document.forms[0].sel_bankscheme.focus();
		
	}
	var table=document.getElementById("table");
	var rowCount=table.rows.length; 
	if(rowCount>0)
	{
		for(var i=0;i<=rowCount;i++)
		{
			var rowCount=table.rows.length; 
			var row=table.deleteRow(rowCount-1);
		}
	}
	document.forms[0].area_details.value=""; 

	if(document.forms[0].seldocrecd.value=="N")
	{
		if(document.forms[0].area_details.value=="")
		{
			alert("Select Additional Documents to be Submitted");
			doDetail();
			return;
		}
	}
	
}
function chkagri(vartype)
{
	if(vartype=="A")
	{
		document.forms[0].selectgovtmain.value="2";
		document.forms[0].schemetypemain.value="0";
		document.forms[0].submainamnt.value="";
		document.forms[0].sel_sponser_agencymain.value="0";
		document.forms[0].sel_subsidytypemain.value="0";
		document.forms[0].txt_agency.value="";
		document.forms[0].selectgovtmain.disabled=true;
	}
	else
	{
		document.forms[0].selectgovtmain.disabled=false;
	}
}
function chkappattach()
{
	if(varAttachFlag=="Y" && document.forms[0].seldocrecd.value=="N")
	{
		alert("Application Attached with Proposal, You cannot change");
		document.forms[0].seldocrecd.value="Y";
		return;
	}

	if(document.forms[0].seldocrecd.value=="N")
	{
		document.all.iddocrep.style.display="none";

		fnchklist();
		if(document.forms[0].seldocrecd.value=="N" && document.forms[0].area_details.value=="" && document.forms[0].choose_type[0].checked)
		{
			if(document.forms[0].sel_bankscheme.value=="")
			{
				alert("Select Bank's Scheme");
				return;
			}
			else
			{
				alert("Select Additional Documents to be Submitted");
				doDetail();
				return;
			}
		}
	}
	else if(document.forms[0].seldocrecd.value=="Y")
	{
		document.all.iddocrep.style.display="table-row";
	}
	else
	{
		document.all.iddocrep.style.display="none";
	}

	if(document.forms[0].seldocrecd.value=="Y" && document.forms[0].txt_receidate.value=="")
	{
		ShowAlert('111','Date of receipt of additional documents');
		document.forms[0].txt_receidate.focus();
		return;
	}
}
function checklistdoc()
{
	<% 
		String checklist=Helper.correctNull((String) hshValues.get("additional_details"));
		if(!checklist.equals(""))
		{
		String[] list=checklist.split("\n");
		for(int i=0;i<list.length;i++)
		{
			String docname=list[i].trim();
			%>
			var table= document.getElementById("table");
			var rowCount=table.rows.length; 

			var row=table.insertRow(rowCount++);
			var cell1=row.insertCell(0);
			var cell2=row.insertCell(1);
			
			cell1.innerHTML="<td ><input type='checkbox' disabled='disabled' checked='checked' name='doccheckbx' style='border=none;'></td>";
			cell2.innerHTML="<td ><input type='text' size='60' name='docname' readonly='readonly'  value='<%= docname %>'></td>";
			document.all.iddoc.style.display="none";		
	<%	} }else{
	%> 
	document.all.iddoc.style.display="inline";
	<%}%>
}

function callAgentName()
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var action=document.forms[0].hidAction.value;
		var strAppVar=document.forms[0].sel_leadgenby.value;
		var scode=document.forms[0].sel_leadregion.value;
		if(strAppVar=="0")
		{
			ShowAlert('111','Lead generated by');
			document.forms[0].sel_leadgenby.focus();
			return;
		}
		else if(scode=="")
		{
			ShowAlert('111','Lead generated by Agent Region');
			document.forms[0].sel_leadregion.focus();
			return;
		}
		else
		{
			var prop = "scrollbars=yes,width=500,height=400,top=100,left=250";
			var url=appURL+"action/BSADSAlist.jsp?hidBeanId=staticdata&hidBeanGetMethod=getBSADSAList&hidAction=search&strfrom=LAR&hidAppVal="+strAppVar+"&strScode="+scode;
			//var url=appURL+"action/valuerslist.jsp?strfrom=ValuersMaster&hidAppVal="+strAppVar;
			window.open(url,"",prop);
		}
	}
}
function leadgenChange()
{
	document.forms[0].txt_name.value="";
	document.forms[0].hidAgentID.value="";
}

function fnchklist()
{
	var table=document.getElementById("table");
	var rowCount=table.rows.length; 
	if(rowCount>1)
	{
		for(var i=0;i<rowCount;i++)
		{
			var docname=document.forms[0].docname[i].value; 
			if(document.forms[0].doccheckbx[i].checked==true)
			{
				document.forms[0].area_details.value=document.forms[0].area_details.value+"\n"+docname;
			}
		}
	}
	else
	{
		if(document.forms[0].doccheckbx!=undefined)
		{
			if(document.forms[0].doccheckbx.checked==true)
			{
				document.forms[0].area_details.value=document.forms[0].docname.value; 
			}
		}
	}
}
function validateno(obj)
{
	var re = new RegExp('^[a-zA-Z]{3}[0-9]{6}$');

	if(obj.value!="")
	{
		if(obj.value.match(re))
		{
			return true;
		}
		else
		{
			alert("Invalid Format.\n Lead Number should be 9 characters.\nFirst three digits should be Alpha and next 6 digits should be number ");
			obj.value="";
			obj.focus();
			return false;
		}
	}
}
function leadnumCheck(leadnum,flag)
{
	if(varstrAppAtached!="Y")
	{
		var leadnum1=leadnum.value;
		if(document.forms[0].choose_type[0].checked && document.forms[0].sel_bankscheme.value=="")
		{
			alert("Select Bank scheme");
			leadnum.value="";
			document.forms[0].sel_bankscheme.focus();
			return;
		}
		else if(leadnum1=="NA" && document.forms[0].selcanvassedbystaff.value!="NR" && document.forms[0].choose_type[0].checked && (document.forms[0].sel_bankscheme.value=="030"||
				document.forms[0].sel_bankscheme.value=="003"||document.forms[0].sel_bankscheme.value=="102"
					||document.forms[0].sel_bankscheme.value=="036"||document.forms[0].sel_bankscheme.value=="001"
						||document.forms[0].sel_bankscheme.value=="053"||document.forms[0].sel_bankscheme.value=="038"
							||document.forms[0].sel_bankscheme.value=="035") && varLMSAvail=="Y")
		{
			alert("Lead Number Required for this scheme.\n Please Enter valid Lead Number");
		    leadnum.value="";
			leadnum.focus();
			return;
		}
		if(leadnum1!="" && leadnum1!="NA")
		document.all.ifrm1.src=appURL+"action/iframeLeadnumCheck.jsp?hidBeanGetMethod=getInwardLeadnoCheck&hidBeanId=inwardRegister&leadnum="+leadnum1+"&strLeadno="+document.forms[0].inwardno.value+"&strFlag="+flag;
	
		if(leadnum1=="NA")
		{
			document.forms[0].hidleadflag.value="n";
		}
	}
}
function setleadchk()
{
	if(document.forms[0].txt_leadno.value!="")
		document.forms[0].hidleadflag.value="y";
	else
		document.forms[0].hidleadflag.value="n";
}
function callAppStatusPopUp()
{
		var	varQryString = appURL+"action/nsdlShowAppDetails.jsp?hidBeanId=nsdl&hidBeanGetMethod=getNsdlShowApplicationDetails&strPageFrom=Inward&strRefId="+document.forms[0].txtnsdlrefno.value;	
		var title = "ApplicantionStatus";
		var prop = "scrollbars=yes,width=850,height=550";	
		var xpos = (screen.width - 500) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
}
function caldmsupload()
{
	if(varinwexappflag=="N" || varinwexappflag=="")
	{
		document.forms[0].cmddmsupload.disabled=false;
	}
	else
	{
		document.forms[0].cmddmsupload.disabled=true;
	}
}
function doDmsUpload()
{
	   var sOptions ='status=yes,menubar=yes,scrollbars=yes,resizable=yes,toolbar=yes,maximize=1'
		sOptions = sOptions + ',width=' + (screen.availWidth).toString();
		sOptions = sOptions + ',height=' + (screen.availHeight).toString();
		sOptions = sOptions + ',screenX=0,screenY=0,left=0,top=0';

		//var request = "http://172.20.115.10:75/kblloan/";
		var request = varOnlineURL;
	if(request!="")
	{
		var win=window.open(request,"",sOptions);
	}
	else
	{
		alert("Specify URL  in Static data Master");
	}
}
function appDedupe()
{
	if(document.forms[0].sel_bankscheme.value=="001" && (document.forms[0].selcanvassedbystaff.value=="Y" || document.forms[0].selcanvassedbystaff.value=="N"))
	{
		
		var hidPan=document.forms[0].txtcomcust_pan.value;
		var hidAppId=document.forms[0].txt_cbscustid.value;

		if(hidPan=="")
		{
			alert("Kindly enter PAN");
			return false;
		}
		
		document.all.ifrm2.src=appURL+"action/iframeApplicationDedupe.jsp?hidBeanGetMethod=applicationDedupe&hidBeanId=DigitalAppInterface&panNo="+hidPan+"&appId="+hidAppId;
	}
}

function allowAlphaNumericNew(e) {
	  var code = ('charCode' in e) ? e.charCode : e.keyCode;
	  if (!(code > 47 && code < 58) &&  !(code > 64 && code < 91)&&!(code > 96 && code < 123)) 
	     { 
	    e.preventDefault();
	  }
	}
function enableuniqueid()
{
	if(document.forms[0].sourceby.value=="JS")
	{
	document.all.idjs1.style.display="inline";
	document.all.idjs2.style.display="inline";
	if(document.forms[0].selapplstatus.value=="2")
	{
		document.all.rejreasonforjansamarth.style.display="table-row";
		document.all.rejreason.style.display="none";
		document.forms[0].txt_rejreason.value="";
		
	}
	else
	{
		document.all.rejreasonforjansamarth.style.display="none";
		document.forms[0].sourcebyreason.value="0";
		document.all.rejreason.style.display="none";
		document.forms[0].txt_rejreason.value="";
	}
	}
	else
	{
		document.all.idjs1.style.display="none";
		document.all.idjs2.style.display="none";
		document.forms[0].unirefid.value="";
		if(document.forms[0].selapplstatus.value=="2")
		{
			document.all.rejreasonforjansamarth.style.display="none";
			document.all.rejreason.style.display="table-row";
			document.forms[0].sourcebyreason.value="0";
			
		}
		else
		{
			document.all.rejreasonforjansamarth.style.display="none";
			document.forms[0].sourcebyreason.value="0";
			document.all.rejreason.style.display="none";
			document.forms[0].txt_rejreason.value="";
		}
	}
}
function checkchar()
{
	var udyamchar = document.forms[0].unirefid.value;
	
	var capudyamchar=udyamchar.toUpperCase();
	if(capudyamchar.length==19)
	{
		 if(capudyamchar.charAt(0))
		  {
			  var code = capudyamchar.charCodeAt(0);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(1))
		  {
			  var code = capudyamchar.charCodeAt(1);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(2))
		  {
			  var code = capudyamchar.charCodeAt(2);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(3)!='-')
		  {
			 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		 if(capudyamchar.charAt(4))
		  {
			  var code = capudyamchar.charCodeAt(4);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(5))
		  {
			  var code = capudyamchar.charCodeAt(5);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(6))
		  {
			  var code = capudyamchar.charCodeAt(6);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(7))
		  {
			  var code = capudyamchar.charCodeAt(7);
			  if(!(code>=65 && code<=90))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(8)!='-')
		  {
			 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		 if(capudyamchar.charAt(9))
		  {
			 var code = capudyamchar.charCodeAt(9);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(10))
		  {
			 var code = capudyamchar.charCodeAt(10);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(11))
		  {
			 var code = capudyamchar.charCodeAt(11);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(12))
		  {
			 var code = capudyamchar.charCodeAt(12);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(13))
		  {
			 var code = capudyamchar.charCodeAt(13);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(14)!='-')
		  {
			 alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
			  return false;
			 
		  }
		 if(capudyamchar.charAt(15))
		  {
			 var code = capudyamchar.charCodeAt(15);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(16))
		  {
			 var code = capudyamchar.charCodeAt(16);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(17))
		  {
			 var code = capudyamchar.charCodeAt(17);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
		 if(capudyamchar.charAt(18))
		  {
			 var code = capudyamchar.charCodeAt(18);
			  if(!(code>=48 && code<=57))
			  {
				  alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
				  return false;
			  }
		  }
	}
	else
	{
		alert("Kindly enter valid Unique Reference ID  - 'XXX-XXXX-00000-0000' X represents Alphabets and 0 represents Numeric Character.");
		return;
	}
}

</script>
</head>
<body onLoad="onload();selsubmain();showAgency();showhide();enablestafffields();checklistdoc();caldmsupload();enableuniqueid();">
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
<form method="post" name="facility" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Loan Application Register</td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable linebor">
	<tr class="applicationheader">
		<td width="12%">Application Number <input type="hidden"
			name="inwardno" size="20" value="<%=inwardno%>"> <input
			type="hidden" name="hidsaral" value="saral"> <input
			type="hidden" name="issaralhead" value="<%=IsSaralhead%>"> <input
			type="hidden" name="hidstatus" value="<%=strstatus%>"> <input
			type="hidden" name="hidappassign" value="<%=strappassign%>">
		<input type="hidden" name="hidappatached" value="<%=strAppAtached%>">
		<input type="hidden" name="valuesin" value="<%=valuesin%>"> <input
			type="hidden" name="isorghead" value="<%=ISorghead%>"> <input
			type="hidden" name="hidproposal" value="<%=strProposal%>"> <input
			type="hidden" name="hidgender" value="<%=strgender%>"> <input
			type="hidden" name="hidpurpose" value="<%=strpurpose%>"> <input
			type="hidden" name="appliedfor" value="<%=strappliedfor%>"> <input
			type="hidden" name="readFlag"
			value="<%=Helper.correctNull(
							(String) session.getAttribute("strGroupRights"))
							.charAt(18)%>">
		<input type="hidden" name="apporgname" value="<%=strAppOrgName%>"></td>
		<td width="10%"><%=inwardno%></td>
		<td width="10%">Applicant Name</td>
		<td width="25%"><%=Helper.decodeAmpersand(customername)%> <input
			type="hidden" name="appname" value="<%=customername%>"></td>
		<td width="5%">Sector</td>
		<td width="10%"><%=strSector%> <input type="hidden"
			name="hidsector" size="20" value="<%=strSector%>"></td>
		<td width="10%">App. Recd. from</td>
		<td width="23%"><%=strAppOrgName%>
		<%if(Helper.correctNull((String)hshValues.get("strRlpcFlag")).equalsIgnoreCase("Y")){ %>[CLPH]
		<%}else if(Helper.correctNull((String)hshValues.get("processedat")).equalsIgnoreCase("3")){ %>[CLPU]
		<%} %></td>
		<td width="5%" style="visibility: hidden; position: absolute">gender</td>
		<td width="7%" style="visibility: hidden; position: absolute"><%=strgender%>
		<input type="hidden" name="hidgender" size="20" value="<%=strgender%>"></td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2"
	class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2"
			class="outertable" align="center">
			<tr>
				<td valign="top" colspan="5">
				<table width="90%" class="outertable">
					<tr>
						<td width="6%"><b>Sectors</b><span class="mantatory">*</span></td>
						<td width="8%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Retail');applied();check();chkagri('O');" checked>
						&nbsp;<b>Retail</b></td>
						<td width="10%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Agri');applied();check();chkagri('A');">
						&nbsp;<b>Agriculture</b></td>
						 <td width="8%" nowrap style="display: none;"><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Tertiary');applied();check();chkagri('O');">
						&nbsp;<b>Tertiary</b></td>
						<td width="68%" nowrap><input type="radio"
							name="choose_type" style="border-style: none"
							onClick="settype('Corp');applied();check();chkagri('O');">
						&nbsp;<b>Corporate &amp; SME</b> </td>
						<td width="86">&nbsp;</td>
					</tr>
				</table>
				</td>
			</tr>
			<%
			if(!strNSDLRefNo.equalsIgnoreCase(""))
			{%>
			<tr style="color: #942188;">
			<td><b>NSDL Reference Number :</b></td>
			<td colspan="2"><input type="text" name="txtnsdlrefno" value="<%=strNSDLRefNo %>">
			&nbsp;<a href="#" onClick="JavaScript:callAppStatusPopUp()"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></a>
			</td>
			<%if(!strAppname.equalsIgnoreCase(""))
				{%>
				<td><b>Student Name :</b></td>
				<td><%=strAppname %></td>
				<%} %>
			</tr>
				
			<%}
			else{
			%>
			<tr>
			<td>
			<input type="hidden" name="txtnsdlrefno" value="<%=strNSDLRefNo %>">
			</td>
			</tr>
			<%} %>
			<tr>
				<td valign="top">Application No&nbsp;</td>
				<td><input type="text" name="txt_inwardno" size="15"
					maxlength="20" tabindex="0"
					value="<%=Helper.correctNull((String) hshValues.get("inwardno"))%>"
					onKeyPress="allowInteger()"></td>
					<td width="15%">&nbsp;</td>					
				<td>Date:</td>
				<td><input type="text" name="txt_date1"
					value="<%=strPropCreateDate%>"
					size="13" maxlength="10" tabindex="1" onBlur="checkDate(this)"></td>
			</tr>
			<tr>
			<td>Lead Number&nbsp;<span class="mantatory">*</span></td>
			<td><input type="text" name="txt_leadno" size="20"
					maxlength="14" tabindex="0"
					value="<%=Helper.correctNull((String) hshValues.get("inw_leadno"))%>"
					onKeyPress="allowAlphaNumeric();" 
					onblur="changecase(document.forms[0].txt_leadno);leadnumCheck(document.forms[0].txt_leadno,'N')"
					onkeyup="setleadchk()">
					<input type="hidden" name="hidleadflag">
					</td>
			</tr>
			<tr id="prop">
				<td valign="top">Proposal Type</td>
				<td><select name="prop_type">
					<option value="0">&lt;------select------&gt;</option>
					<option value="C">Regular Proposal</option>
					<option value="H">Adhoc Proposal</option>
					<option value="V">Short term loan</option>
					<option value="E">Short Review/Extension</option>
				</select></td>
				<td>&nbsp;</td>	
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" colspan="5"><b>Customer Information&nbsp;</b></td>
			</tr>
			<tr>
				<td>Type of Borrower<span class="mantatory">*</span></td>
				<td width="34%"><select name="selcusttype"
					onchange="showcustid();applied();selcust();showhide()">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<option value="N">New Connection</option> 
					<option value="E">Existing Customer</option>
				</select></td>
					<td>&nbsp;</td>	
				<td width="13%" id="custid">CBS Cust ID<span class="mantatory">*</span></td>
				<td width="34%" id="custid1"><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String)hshValues.get("cbscustid"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" id="idsearch"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
			</tr>
			<tr>
				<td valign="top" width="25%">Name<span class="mantatory">*</span></td>
				<td><input type="text" name="txt_comncustame" size="35"
					maxlength="60" tabindex="1"
					value="<%=Helper.correctDoubleQuotesHtml((String) hshValues
							.get("customername"))%>"
					onKeyPress="notAllowSplChar1(this)"></td>
					<td>&nbsp;</td>	
					<td>&nbsp;</td>	
					<td>&nbsp;</td>	
				
				</tr>
			<tr id="id_gender">
				<td>Gender<span class="mantatory">*</span></td>
				<td width="34%"><select name="selgender">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<option value="M">Male</option>
					<option value="F">Female</option>
					<option value="O">Others</option>
				</select></td>
				<td>&nbsp;</td>	
				<td valign="top">Voter ID<span class="mantatory"
					id="id_voterid1">*</span></td>
				<td valign="top"><input type="text"
					name="txtcomcust_voterid" size="35"
					onKeyPress="allowAlpaNumeric();notAllowSpace()" maxlength="15"
					tabindex="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("customervoterid"))%>"
					onKeyPress="notAllowedDouble()"></td>
			</tr>
			
			<tr id="applied">
				<td valign="top" width="25%">&nbsp;</td>
				<td valign="top" width="28%">&nbsp;</td>
					<td>&nbsp;</td>	
				<td valign="top" width="13%">Whether Applied for<span
					class="mantatory">*</span></td>
					
				<td width="34%"><select name="selapplied"
					onchange="showcustid();check()">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<option value="N">New Limits</option>
					<option value="R">Renewal/Enhancement/Modification/Adhoc/Additional</option>
				</select></td>
			</tr>
			<tr>
				<td valign="top" width="25%">Date of Birth /Date of
				Commencement of Business /Date of Incorporation <span
					class="mantatory">*</span></td>
				<td valign="top" width="28%">
				<table>
				<tr>
				<td><input type="text"
					name="txt_comDOB"
					value="<%=Helper.correctNull((String) hshValues
									.get("customerDOB"))%>"
					size="13" maxlength="10" tabindex="2"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>')">
				</td>
				<td id="exist"><a alt="Select date from calender"
					href="javascript:callCalender('txt_comDOB')"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" tabindex="3"></a></td>
				</tr>
				</table>
				</td>
						<td>&nbsp;</td>	
				<td valign="middle" width="13%" id="id_pan_lbl">
				PAN/TAN No.<span class="mantatory" id="id_pan">*</span></td>
				<td width="34%" id="id_pan_txt"><input type="text"
					name="txtcomcust_pan" size="15" maxlength="10"
					value="<%=Helper.correctNull((String) hshValues
									.get("customerpan"))%>"
					tabindex="4"
					onblur="validatePANNO(document.forms[0].txtcomcust_pan)"></td>
			</tr>
			<tr id="id_passport">
				<td valign="top" width="25%" style="visibility: hidden">Passport Number<span
					class="mantatory" id="id_pp">*</span></td>
				<td valign="top" width="28%"  style="visibility: hidden"><input type="text"
					name="txtcomcust_passno" size="35"
					onKeyPress="allowAlpaNumeric();notAllowSpace()" maxlength="20"
					tabindex="5"
					value="<%=Helper.correctNull((String) hshValues
							.get("customerpassport"))%>"
					onKeyPress="notAllowedDouble()"></td>
				<td>&nbsp;</td>	
				<td valign="top" width="13%">City<span class="mantatory">*</span></td>
				<td width="34%" >
				<table><tr>
				<td>
				<input type="text" name="txt_comcustcity"
					tabindex="7"
					value="<%=Helper.correctNull((String) hshValues
									.get("customercity"))%>"
					onKeyPress="notAllowSplChar()" size="25" maxlength="20"> <input
					type="hidden" name="hidcity"
					value="<%=Helper.correctNull((String) hshValues
							.get("customercitycode"))%>" />
				</td>
				<td id="idtest" ><a href="#"
					onClick="showCitySearch('INWARD')"
					style="cursor: hand" tabindex="8"> <img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></a></td>
				</tr></table>
					</td>
			</tr>
			<tr>
				<td valign="top" width="25%">Address<span class="mantatory">*</span></td>
				<td valign="top" width="28%"><input type="text"
					name="txt_comcustadd1" size="50" maxlength="50" tabindex="5"
					value="<%=Helper.correctNull((String) hshValues
									.get("customeradd1"))%>">
				</td>
				<td>&nbsp;</td>	
				<td>District<span class="mantatory">*</span></td>
										<td><input type="text" name="txt_comndist" size="25" value="<%=Helper.correctNull((String)hshValues.get("INWARD_DIST")) %>"
											maxlength="30" style="text-align: left;"
											onKeyPress="notAllowSplChar();allowAlphabets()" >
										&nbsp;<a href="#" id="iddistrict"
													onClick="showDistSearch('INWARD');"
													style="cursor:hand" tabindex="22" id="iddistrict"><img
													src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" ></a>
											<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get("INWARD_DISTCODE")) %>"></td>
				</tr>
			<tr>
				<td valign="top" width="25%">&nbsp;</td>
				<td valign="top" width="28%"><input type="text"
					name="txt_comcustadd2" size="50" maxlength="50" tabindex="6"
					value="<%=Helper.correctNull((String) hshValues
									.get("customeradd2"))%>"
					onKeyPress="notAllowedDouble()"></td>
					<td>&nbsp;</td>	
				<td valign="top" width="13%">State<span class="mantatory">*</span></td>
				<td width="34%"><input type="text" name="txtcomcust_state"
					size="25" maxlength="25" tabindex="9"
					value="<%=Helper.correctNull((String) hshValues
							.get("customerstate"))%>"
					onKeyPress="notAllowSplChar()"
					onBlur="changecase(document.forms[0].txtcomcust_state)"> <input
					type="hidden" name="hidstate"
					value="<%=Helper.correctNull((String) hshValues
							.get("customerstatecode"))%>" />
				<input type="hidden" size="5" name="hid_state" value="<%=Helper.correctNull((String) hshValues
							.get("customerstatecode"))%>">
				</td>
			</tr>
			<tr>
				<td valign="top" width="25%">Pin code<span class="mantatory">*</span></td>
				<td valign="top" width="28%"><input type="text"
					name="txtcomcust_zip" size="12"
					maxlength="<%=ApplicationParams.getZipValue()%>" tabindex="10"
					style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues
									.get("customerpin"))%>"
					onKeyPress="allowInteger()"
					onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>');zipcodeVaildate(document.forms[0].txtcomcust_zip,document.forms[0].hidzip,document.forms[0].hidstate)">
				</td>
				<td>&nbsp;</td>	
				<td valign="top" width="13%">E - mail&nbsp;</td>
				<td width="34%"><input type="text" name="txtcomcust_email"
					size="40" maxlength="50"
					value="<%=Helper.correctNull((String) hshValues
							.get("customeremail"))%>"
					onBlur="isEmailAddr(document.forms[0].txtcomcust_email.value,document.forms[0].txtcomcust_email)"
					tabindex="11"></td>
			</tr>
			<tr>
				<td valign="top" width="25%">Phone No.&nbsp;</td>
				<td width="28%"><input type="text" name="txtcomcust_phone"
					size="20" maxlength="15" tabindex="12" style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues
							.get("customerphone"))%>"
					onblur="allowPhone();validatephone(document.forms[0].txtcomcust_phone.value);phonechk(document.forms[0].txtcomcust_phone.value,document.forms[0].txtcomcust_phone)">
				</td>
				<td>&nbsp;</td>	
				<td width="13%">Mobile No. <span class="mantatory">*</span><span
					class="mantatory" id="idmobmandatory" style="visibility: hidden;position: absolute;">&nbsp;</span></td>
				<td width="34%"><input type="text" name="txtcomcust_mobile"
					size="20" maxlength="10" tabindex="13" style="text-align: left"
					value="<%=Helper.correctNull((String) hshValues
							.get("customermobile"))%>"
					onblur="allowPhone();" onkeypress="allowInteger()">
				</td>
			</tr>
			<tr>
				<td valign="top" width="25%">Date of receipt of physical application form and initial Documents<span
					class="mantatory">*</span></td>
				<td width="28%" valign="top"><input type="text"
					name="txt_appdate"
					value="<%=Helper.correctNull((String) hshValues.get("appliedon"))%>"
					size="13" maxlength="10" tabindex="14"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');comparedate(document.forms[0].txt_date1.value,document.forms[0].txt_appdate.value)">
				<a alt="Select date from calender"
					href="javascript:callCalender('txt_appdate')" id="idapprecvdate"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" tabindex="15"></a></td>
				<td>&nbsp;</td>	
				<td width="13%" valign="top" rowspan="2" nowrap>Purpose of Loan<span
					class="mantatory">*</span></td>
				<td width="34%" rowspan="2"><textarea name="txt_comloanpur" cols="75"
					onKeyPress="textlimit(this,750)" onkeyup="textlimit(this,750)"
					tabindex="16" rows="3"><%=Helper.correctNull((String) hshValues
									.get("loanpurpose"))%></textarea></td>
			</tr>
			<tr>
				<td valign="top">Whether Application is received
				with all required documents? <span class="mantatory">*</span></td>
				<td valign="top"><select name="seldocrecd" onchange="chkappattach();"
					tabindex="23">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
				</select> &nbsp;&nbsp;</td>
			</tr>
			<tr id="iddocrep">
				<td valign="top" width="25%">Date of receipt of additional
				documents<span class="mantatory">*</span></td>
				<td valign="top"><input type="text"
					name="txt_receidate"
					value="<%=Helper.correctNull((String) hshValues
							.get("docreceiveddate"))%>"
					size="13" maxlength="10" tabindex="24"
					onBlur="checkDate(this);checkmaxdate(this,'<%=Helper.getCurrentDateTime()%>');checkmindate(this,document.forms[0].txt_appdate.value)">
				<a alt="Select date from calender"
					href="javascript:callCalender('txt_receidate')" id="iddocreceived"> <img
					src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
			</tr>
			
			
		
			<tr id="id_enquirypurpose">
				<td>Enquiry Purpose<span class="mantatory">*</span></td>
				<td width="34%"><select name="selpurpose"
					onchange="showcustid();applied()">
					<option value="0" selected>&lt;---Select---&gt;</option>
					<lapschoice:StaticDataNewTag apptype="74" />
				</select></td>
				<td>&nbsp;</td>	
				<td>&nbsp;</td>	
				<td>&nbsp;</td>	
			</tr>
			<tr>
				<td valign="top" colspan="5"><br/><b>Details of loan applied</b> &nbsp;</td>
			</tr>
			<tr>
				<td valign="top" colspan="5">1.&nbsp;Fund Based</td>
			</tr>
			<tr id="schemedesc">
            <td>Scheme Type<b><span class="mantatory">*</span></b></td>
            <b><span>&nbsp;</span></b>
													<td colspan="4"><select name="sel_scheme" tabindex="19">
													<option value="0">&lt;----Select----&gt;</option>
													<option value="t">Term Loan</option>
													<option value="d">DPN</option>
													<option value="o">Overdraft</option>
													</select></td>
			</tr>
		<tr id="bankscheme">										
		<td valign="top">Bank's Scheme&nbsp;<b><span class="mantatory">*</span></b></td>
		<td colspan="4"><select name="sel_bankscheme" style="width:200px;" onchange="chkbankscheme();leadnumCheck(document.forms[0].txt_leadno,'N');" > 
		<option value="" selected>&lt;---------------Select---------------&gt;</option>
        <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
		</select></td>
													</tr>
			<tr id="retail1">
				
            <td>Scheme Description</td>
				<td><input type="text" name="txt_retschemedesc1" size="35"
					maxlength="60" tabindex="17"
					value="<%=Helper.correctNull((String) hshValues.get("schemedesc"))%>">
				</td>
				<td>&nbsp;</td>	
				<td>Amount<span class="mantatory">*</span></td>
				<td>Rs. <lapschoice:CurrencyTag name="txtret_ftf" size="15"
					maxlength="14"
					value='<%=Helper.correctNull((String) hshValues
									.get("fundtermloan"))%>'
					tabindex="18" onBlur="chkLoanAmount(this);"/></td>
			</tr>
			<tr id="tercorp1">
				<td>a.&nbsp;Working Capital</td>
				<td>Rs. <lapschoice:CurrencyTag name="txtcomcust_fwc" size="15"
					maxlength="12" tabindex="19"
					value='<%=Helper.correctNull((String) hshValues
							.get("fundworkingcapital"))%>'  onBlur="chkLoanAmount(this);"/>
				<span id="corp1">&nbsp;</span></td>
				<td>&nbsp;</td>	
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr id="tercorp2">
				<td valign="top">b.&nbsp;Term loan</td>
				<td>Rs. <lapschoice:CurrencyTag name="txtcomcust_ftf" size="15"
					maxlength="12" tabindex="20"
					value='<%=Helper.correctNull((String) hshValues
									.get("fundtermloan"))%>'   onBlur="chkLoanAmount(this);"/>
				<span id="corp2">&nbsp;</span></td>
				<td>&nbsp;</td>	
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr id="tercorp3">
				<td valign="top">2.&nbsp;Non Fund Based</td>
				<td>Rs. <lapschoice:CurrencyTag name="txtcomcust_nf" size="15"
					maxlength="12" tabindex="21"
					value='<%=Helper.correctNull((String) hshValues.get("nonfund"))%>'  onBlur="chkLoanAmount(this);"/>
				<span id="corp3">&nbsp;</span></td>
				<td>&nbsp;</td>	
				<td>&nbsp;</td>
				<td>&nbsp;</td>
			</tr>
			<tr>
				<td valign="top" width="25%">Additional details / requirements
				to be submitted</td>
				<td valign="top" colspan="3">
				<table width="100%" cellspacing="0" cellpadding="2" id="table" border="0">
				</table>
				<span id="iddoc" class="mantatory">- Nil -</span>
				<input type="hidden" name="area_details" value="<%=Helper.correctNull((String) hshValues
							.get("additional_details"))%>">
				</td>
				<td valign="center"><input type="button" name="cmddetail"
					value="Checklist for Documents to be collected" class="buttonStyle"
					onClick="doDetail()"></td>
			</tr>
			
			
			<tr id="SSItype"><td>Whether SSI</td>
			<td><select name="sel_SSI">
			<option value="1">Yes</option>
			<option value="2" selected="selected">No</option>
			</select></td>
			</tr>
			<tr id="Tiny"><td>Whether Tiny industry</td>
			<td><select name="sel_tiny">
			<option value="1">Yes</option>
			<option value="2" selected="selected">No</option>
			</select></td>
			</tr>
			<tr>
									     <td nowrap="nowrap">Govt. Sponsor Scheme</td>
									    <td><select name="selectgovtmain"
													onChange="selsubmain();">
													<option value=""><-- select --></option>
													<option value="1">Yes</option>
													<option value="2" selected="selected">No</option>
												</select></td>
												</tr>
											<tr>														
												
												<td id="s5m">Scheme Type</td>
												<td id="s6m"><select name="schemetypemain"  style="width:150px">
													<option value="0">---select---</option>
													<lapschoice:StaticDataTag apptype="11" tagType=""/>
												</select> &nbsp;</td>
												<td>&nbsp;</td>		
												         	<td id="s1m">Subsidy Amount&nbsp;</td>
												<td id="s2m"><lapschoice:CurrencyTag name="submainamnt"
													size="20" maxlength="10"
													value='<%=Helper.correctNull((String)hshValues.get("inward_subsamount"))%>'
													tabindex="18"  style="width:150px"/> &nbsp;</td>										
											</tr>
																					
											<tr id="s3m">
												<td nowrap="nowrap">Sponsor Agency</td>
												<td><select name="sel_sponser_agencymain"
													tabindex="19"  style="width:150px" onchange="showAgency()">
													<option value="0">Select</option>
													<%
														String apptype = "3";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>		
												<td>&nbsp;</td>								
												<td>Subsidy type</td>
												<td><select name="sel_subsidytypemain" tabindex="20">
													<option value="0"  style="width:150px">Select</option>
													<%
														apptype = "5";
													%>
													<lapschoice:StaticDataTag apptype="<%=apptype%>" />
												</select></td>
											</tr>									
										<tr id="s4m">
											<td nowrap="nowrap">Name of the Agency</td>
											<td><input type="text" name="txt_agency" maxlength='50' size='50' value='<%=Helper.correctNull((String)hshValues.get("inward_otheragency"))%>'/></td>
											<td colspan="3"></td>
										</tr>	
			<tr id="id_extAppl_cibil">
				<td>CIBIL Score </td>
				<td> <input type="text" name="txt_cibilSCore" value="<%=Helper.correctNull((String) hshValues.get("INWARD_CIBILSCORE"))%>"> </td>
				<td>&nbsp;</td>	
				<td>CIBIL Details</td>
				<td>
					<textarea name="txt_cibilDetails" cols="45" rows="4" onKeyPress="textlimit(this,599)" onKeyUp="textlimit(this,599)" tabindex="22"><%=Helper.correctNull((String) hshValues.get("INWARD_CIBILDETAILS"))%></textarea>
				</td>
			</tr>
				
			<tr>
				<td valign="top" width="25%" colspan="2">Canvassed By (Staff Number) (Other than canvassed enter BM staff ID) <span class="mantatory">*</span></td>
				<td valign="top"><select name="selcanvassedbystaff"
					tabindex="23" onblur="appDedupe();" onchange="enablestafffields();leadnumCheck(document.forms[0].txt_leadno,'N')">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="Y">Yes</option>
					<option value="N">No</option>
					<option value="NP">Not Applicable (Renewal Application)</option>
					<option value="NR">Restructure Proposal</option>
				</select></td>
				<td id="idstaff1" style="display: none;">Staff ID</td>
				<td id="idstaff2" style="display: none;"><input type="text" name="txt_staffid" size="10" readonly="readonly"
																	value="<%=Helper.correctNull((String)hshValues.get("inward_staffid")) %>">&nbsp;
																	<input type="text" name="txt_staffname" size="35" value="<%=Helper.correctNull((String)hshValues.get("inward_staffname")) %>"> <a
																	href="#" onClick="javascript:callUsersHelp('1')"><img
																	src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																	border="0"> </a></td>
			</tr>
			
				<tr>
			<td valign="top" width="25%" colspan="2">Source by:</td>
			<td valign="top"><select name="sourceby" onchange="enableuniqueid();"
					tabindex="23">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="NA">Not Applicable</option>
					<option value="JS">Jan Samarth</option>
				</select></td>
			<td id="idjs1" style="display: none;">Unique Reference ID </td>
				<td id="idjs2" style="display: none;"><input type="text" name="unirefid" size="20" maxlength="19" onBlur="checkchar();" 
																	value="<%=Helper.correctNull((String)hshValues.get("UNIQUEID")) %>">&nbsp;</td>
			</tr>
			
			
			<tr id="idLeadgen">
				<td valign="top" width="25%" colspan="2"> Lead generated by </td>
				<td valign="top">
					<select name="sel_leadgenby" onchange="leadgenChange()">
						<option value="0" selected>&lt;--Select--&gt;</option>
						<option value="BSA">Business Sourcing Agents</option>
						<option value="DSA">Direct Sales Agents</option>
						<lapschoice:StaticDataTag apptype="218" />
					</select>
					</td>
					<td valign="top">
					<select name="sel_leadregion" onchange="leadgenChange();">
						<option value="" selected>&lt;--select--&gt;</option>
						<option value="All" selected>All Regions</option>
						<lapschoice:LeadGeneratedRegion/>
					</select>
				</td>
				<td  valign="top">
					<input type="text"
					name="txt_name" size="30" maxlength="50" tabindex="1" readonly="readonly"
					value="<%=Helper.correctNull((String) hshValues
							.get("INWARD_AGENTname"))%>" 
					onKeyPress="notAllowSplChar()"> &nbsp;&nbsp;<b><span
					onClick="callAgentName()" style="cursor: hand" id="idsearch1"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b>
				</td>
			</tr>
			
			<tr id="idLeadconv">
				<td valign="top" width="25%" colspan="2"> Lead Converted By <span class="mantatory">*</span></td>
				<td colspan="2">
					<input type="text" name="txt_convertedid" size="10" readonly="readonly"
						value="<%=Helper.correctNull((String)hshValues.get("INWARD_CONVERTEDBY"))%>">&nbsp;
					<input type="text" name="txt_convertedname"  size="20" readonly="readonly" value="<%=Helper.correctNull((String)hshValues.get("INWARD_CONVERTEDBYname")) %>">
					 <a	href="#" onClick="javascript:callUsersHelp('2')"><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"> </a></td>
			</tr>
			
			
			<tr>
				<td valign="top" width="25%" colspan="2">Status of the Borrower<span class="mantatory">*</span></td>
				<td valign="top" colspan="3"><select name="selborrowerstatus"
					tabindex="23">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="N">New Borrower</option>
					<option value="E">Existing Borrower</option>
				</select></td>
			</tr>		
			
					
			
			<tr>
				<td valign="top" width="25%" colspan="2">Status of Application<span class="mantatory">*</span></td>
				<td valign="top" colspan="3"><select name="selapplstatus"
					tabindex="25" onChange="checkStatus()">
					<option value="0" >&lt;--Select--&gt;</option>
					<option value="1">Approve</option>
					<option value="2">Reject</option>
				</select></td>
			</tr>
			<tr id="propcreation">
				<td valign="top" width="25%" colspan="2">The Proposal creation will take place in<span class="mantatory">*</span></td>
				<td valign="top" colspan="3"><select name="selappcreation"
					tabindex="25" onChange="check()">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="1">Branch</option>
					<!-- <option value="2">SARAL</option> -->
<!--					<option value="3">CLPU</option>-->
					<!-- <option value="4">RO</option>-->
					<option value="5">HO</option>
					<option value="6">CLPH</option>
				</select></td>
			</tr>
			<tr id="rejreason">
				<td valign="top" width="25%">Reason for Rejection<span class="mantatory">*</span></td>
				<td valign="top" colspan="4"><textarea name="txt_rejreason"
					cols="65" rows="5" tabindex="22"
					<%if(!strNSDLRefNo.equalsIgnoreCase(""))
					{ %>onKeyPress="textlimit(this,250)" onkeyup="checkTextArealimit(this,250);"
					<%}else{ %>
					onKeyPress="textlimit(this,3999)" onkeyup="checkTextArealimit(this,3999);"
					<%} %>><%=Helper.correctNull((String) hshValues
							.get("inward_rejreason"))%></textarea>
				</td>
			</tr>
			
			
			<tr id="rejreasonforjansamarth" >
			<td valign="top" width="25%">Reason for Rejection<span class="mantatory">*</span></td>
			<td valign="top"><select name="sourcebyreason" 
					tabindex="23">
					<option value="0" selected>&lt;--Select--&gt;</option>
					<option value="1">Customer is not reachable </option>
					<option value="2">Customer provided wrong infomration or data on the Jansamarth Portal</option>
					<option value="3">Delinquencies observed in customer Credit Bureau Report</option>
					<option value="4">Customer is located outside the branch jurisdiction or service area</option>
					<option value="5">Customer is not eligible under the scheme</option>
					<option value="6">Loan purpose is  not covered under the scheme</option>
					<option value="7">Customer not able to provide required documents</option>
					<option value="8">Customer is not interessted in availing loan</option>
				</select></td>
				</tr>
			
			<tr id="id_clpldisp" style="display: none;">
			<td valign="top" width="50%" colspan="2">Date of receipt of physical
				loan papers at CLPU<span class="mantatory">*</span></td>
				<td valign="top" colspan="3"><input type="text"
					name="txt_clpreceivedate" value="<%=Helper.correctNull((String) hshValues.get("inward_clpudate"))%>"
					size="13" maxlength="10"></td></tr>
			
		</table>
		
		</td>
	</tr>
	
</table>
<br>
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Print_Audit Trail_DMS Upload' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="hidtype"> 
<input type="hidden" name="hidzip" value="<%=Helper.correctNull((String) hshValues.get("state_validatepin"))%>" />
<input type="hidden" name="hidoldtype" value="<%=Helper.correctNull((String) hshValues.get("category"))%>">
<input type="hidden" name="hidoldapplied" value="<%=Helper.correctNull((String) hshValues.get("inward_appliedfor"))%>">
<input type="hidden" name="hidoldappcreation" value="<%=Helper.correctNull((String) hshValues.get("processedat"))%>">
<input type="hidden" name="Application" value="<%=inwardno%>">
<input type="hidden" name="hidSNo"> 
<input type="hidden" name="hidLoanAmount" value="<%=Helper.correctNull((String)hshValues.get("strLoanAmount")) %>"> 
<input type="hidden" name="hidappname" value="<%=strAppname%>"> 
<input type="hidden" name="hidappDOB" value="<%=strAppDOB%>"> 
<iframe height="0" width="0" id="ifrstate" frameborder="0" style="border: 0"></iframe>
<input type="hidden" name="hidAgentID"  value="<%=Helper.correctNull((String) hshValues.get("INWARD_AGENTID"))%>"> 
<input type="hidden" name="hidnsdlremarks"  value="<%=Helper.correctNull((String)hshValues.get("strRemarks")) %>"> 
<iframe height="0" width="0" id="ifrm1" frameborder="0"	style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder="0"	style="border: 0"></iframe>
<input type="hidden" name="hidApp_dedupestatus"> 
<input type="hidden" name="hidApp_deduperefno"> 

</form>
</html>