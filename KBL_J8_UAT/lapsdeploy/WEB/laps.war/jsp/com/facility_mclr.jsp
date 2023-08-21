<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRowCRP = new ArrayList();
	ArrayList arrRowBSP = new ArrayList();
	ArrayList arrCol = new ArrayList();

	arrRowCRP = (ArrayList) hshValues.get("arrRowCRP");
	arrRowBSP = (ArrayList) hshValues.get("arrRowBSP");
	int arrCRPSize = 0, arrBSPSize = 0;
	if (arrRowCRP != null)
		arrCRPSize = arrRowCRP.size();
	if (arrRowBSP != null)
		arrBSPSize = arrRowBSP.size();
	String strHOFlag = Helper.correctNull((String) hshValues
			.get("strHOFlag"));
	
	
	String strLevel=Helper.correctNull((String)session.getAttribute("strOrgLevel"));
	String strFacIntDef=Helper.correctNull((String)hshValues.get("strFacIntDef"));
	String strappstatus=Helper.correctNull((String)request.getParameter("strappstatus"));
	
	if(strLevel.equalsIgnoreCase("C"))
	{
		strHOFlag="Y";
	}
	
	String strOption = "",strText="";
	String strMCLRtype = Helper.correctNull((String) hshValues.get("strMCLRType"));
	String strDescription=Helper.correctNull((String) hshValues.get("strMCLRtypeDesc"));
	String strRefType=Helper.correctNull((String) hshValues.get("strRefType"));
	String strFacMCLR=Helper.correctNull((String) hshValues.get("facility_intsubtype"));
	if(!strMCLRtype.equalsIgnoreCase(""))
	{
		/*strOption = strMCLRtype;
		strText = strMCLRtype.split("@")[0];
		if(strText.equalsIgnoreCase("O"))
			strDescription = "One day MCLR";
		else if(strText.equalsIgnoreCase("M"))
			strDescription = "Monthly MCLR";
		else if(strText.equalsIgnoreCase("Q"))
			strDescription = "Quartely MCLR";
		else if(strText.equalsIgnoreCase("H"))
			strDescription = "Half yearly MCLR";
		else if(strText.equalsIgnoreCase("Y"))
			strDescription = "Yearly MCLR";*/
			strOption = strMCLRtype;
			strDescription = strDescription+"-"+strMCLRtype.split("@")[1];
	}
	String APP_LOANSUBTYPE_DIGI = Helper.correctNull((String) hshValues.get("APP_LOANSUBTYPE_DIGI"));
	String strRoiEnableFlag = Helper.correctNull((String) hshValues.get("strRoiEnableFlag"));
	String strFacId = Helper.correctNull((String) hshValues.get("strfacsno"));
	session.setAttribute("strFacId",strFacId);	
	String STRROIDATECHECK= Helper.correctNull((String) hshValues.get("ROIDATECHECK"));

%>
<html>
<head>
<title>MCLR</title>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varfacsno="<%=strFacId%>";
var varmclrtype="<%=Helper.correctNull((String) hshValues
									.get("strMCLRType"))%>";
var varintrefno="<%=Helper.correctNull((String)hshValues.get("strIntRefNoFlag"))%>";
var varIntDefinition="<%=Helper.correctNull((String)hshValues.get("strIntDefinition"))%>";
var varBSPSize="<%=arrBSPSize%>";
var varCRPSize="<%=arrCRPSize%>";
var varPostSanc="<%=Helper.correctNull((String)session.getAttribute("strAppType"))%>";
var varMCLRFlag="<%=Helper.correctNull((String)hshValues.get("strMCLRFlag"))%>";
var varWCDPNfac="<%=Helper.correctNull((String)hshValues.get("strWCDPNFac"))%>";
var varWCDPNint="<%=Helper.correctDouble((String)hshValues.get("strWCDPNint"))%>";
var varWCDPNauth="<%=Helper.correctNull((String)hshValues.get("strWCDPNauthority"))%>";

var varCIBILDet="<%=Helper.correctNull((String)hshValues.get("strCIBILDetails"))%>";
var varCRIFDet="<%=Helper.correctNull((String)hshValues.get("strCRIFDetails"))%>";
var varCIBILFlag="<%=Helper.correctNull((String)hshValues.get("strCIBILFlag"))%>";
var varCRIFFlag="<%=Helper.correctNull((String)hshValues.get("strCRIFFlag"))%>";
var varDigiLoanType="<%=APP_LOANSUBTYPE_DIGI%>";
var varRoiEnableFlag="<%=strRoiEnableFlag%>";
var varSecValue = "<%=Helper.correctNull((String)hshValues.get("strFACILITYSECAMOUNT"))%>";
var varroiflag = "<%=Helper.correctNull((String)hshValues.get("FACILITYUPDROIFLAG"))%>";
var VARROIDATECHECK ="<%=STRROIDATECHECK%>";
var varmisdetails = "<%=Helper.correctNull((String)hshValues.get("misdetails"))%>";
var varGuarantee = "<%=Helper.correctNull((String)hshValues.get("APP_GUARANTEE"))%>";
var varstrFacMCLR="<%=strFacMCLR%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var varfbilreffdate= "<%=Helper.correctNull((String)hshValues.get("fbilreffdate"))%>";
var varfbilrefffrq= "<%=Helper.correctNull((String)hshValues.get("FBILL_FRQ"))%>";
var varBaseRate="<%=(Helper.correctNull((String)hshValues.get("FACILITY_BASERATE")+"%(EBLR)+"))+"  "+
Helper.correctNull((String)hshValues.get("MCLR_CRP_TOTAL")+"%(Credit Risk Premium)+")+"  "+
Helper.correctNull((String)hshValues.get("MCLR_BSP_TOTAL")+"%(Fixed Spread) =")+"  "+
Helper.correctNull((String)hshValues.get("TotalBaseRate")+"%")%>";
var varConcession="<%=Helper.correctNull((String)hshValues.get("FACILITY_CONCESSION"))%>";
var varPenalty="<%=Helper.correctNull((String)hshValues.get("FACILITY_CONDESC"))%>";

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mainnav.jsp";
		document.forms[0].submit();
	}
}
function doSave()
{
	if(document.forms[0].sel_mclrtype.value=="")
	{
		alert("select Reference Type");
		document.forms[0].sel_mclrtype.focus();
		return;
	}
	if(varstrFacMCLR=="FTBR")
		{
	if(document.forms[0].sel_fbill_fre.value=="")
		{
		alert("please select Interest Reset Frequence")
		document.forms[0].sel_fbill_fre.focus();
		return;
		}
		}
	try
	{
		if(document.forms[0].hidcaptionval.length==undefined)
		{
			throw err;
		}
		 for(var i=0;i<document.forms[0].hidcaptionval.length;i++)
		 {
			 if(document.forms[0].sel_crpspreadoption[i].value=="-" && !document.forms[0].sel_crpspreadoption[i].disabled)
			 {
				 if('<%=strRefType%>'=="O")
				 {
					alert("select Credit Risk Premium value");
				 }
				 else
				 {
					alert("select Fixed spread value");
				 }
				document.forms[0].sel_crpspreadoption[i].focus();
				return;
			 }
		 }
	 }
	 catch(err)
	 {
		 if(document.forms[0].sel_crpspreadoption.value=="-" && !document.forms[0].sel_crpspreadoption.disabled)
		 {
			 if('<%=strRefType%>'=="O")
			 {
			 	alert("select Credit Risk Premium value");
			 }
			 else{
			 	alert("select Fixed spread value");
			 }
				document.forms[0].sel_crpspreadoption.focus();
				return;
		 }
	 }

	try
	{
		if(document.forms[0].hidbspcaptionval.length==undefined)
		{
			throw err;
		}
		 for(var i=0;i<document.forms[0].hidbspcaptionval.length;i++)
		 {
			 if(document.forms[0].sel_bspspreadoption[i].value=="-" && (!document.forms[0].sel_bspspreadoption[i].disabled &&  document.forms[0].hidbspcaption[i].value!="Market Competition Rebate (Threat of losing the Account) (HO)" && document.forms[0].hidbspcaption[i].value!="Fixed Spread" && document.forms[0].hidbspcaption[i].value!="Business strategic Premium" && document.forms[0].hidbspcaption[i].value!="Market Competition Rebate (Threat of losing the Account) (HO)" && document.forms[0].hidbspcaption[i].value!="Additional Premium for Adhoc Facilities(WCDPN)"))
			 {

				 if('<%=strRefType%>'=="O")
				 { 
				 alert("select Business Strategic Premium value");
				 }
				 else
				 {
				 alert("select Fixed spread value");
				 }
				 document.forms[0].sel_bspspreadoption[i].focus();
				 return;
			 }
		 }
	 }
	 catch(err)
	 {
		 if(document.forms[0].sel_bspspreadoption.value=="-" && (!document.forms[0].sel_bspspreadoption.disabled &&  document.forms[0].hidbspcaption.value!="Market Competition Rebate (Threat of losing the Account) (HO)" && document.forms[0].hidbspcaption.value!="Business strategic Premium" && document.forms[0].hidbspcaption.value!="Fixed Spread" && document.forms[0].hidbspcaption.value!="Market Competition Rebate (Threat of losing the Account) (HO)" && document.forms[0].hidbspcaption[i].value!="Additional Premium for Adhoc Facilities(WCDPN)"))
		 {
			 if('<%=strRefType%>'=="O")
			 {
			 	alert("select Business Strategic Premium value");
			 }
			 else{
				 alert("select Fixed spread value");
					 
			 }
				 
				document.forms[0].sel_bspspreadoption.focus();
				return;
		 }
	 }

	 var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
	 for(var i=0;i<varPSterms.length;i++)
	 {
		if((varPSterms[i] == "BRTOMCLR") && (document.forms[0].txt_migrationdate.value==""))
		{
			 ShowAlert(111,'Effective Date of Migration');
			  document.forms[0].txt_migrationdate.focus();
			  return;
		}
	 }	

	var varBSPTotal=0,varBSPHO=0,varCRPTotal=0;
	<%if(arrRowBSP!=null && arrRowBSP.size()>1)
	{
		for(int a=0;a<arrRowBSP.size();a++)
		{%>
			if(document.forms[0].hidbspcaption[<%=a%>].value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{
				varBSPHO=parseFloat(NanNumber(document.forms[0].txt_bspspreadval[<%=a%>].value));
			}
			else
			{
				varBSPTotal=parseFloat(varBSPTotal)+parseFloat(NanNumber(document.forms[0].txt_bspspreadval[<%=a%>].value));
			}
		<%}
	}
	if(arrRowCRP!=null && arrRowCRP.size()>1)
	{
		for(int a=0;a<arrRowCRP.size();a++)
		{%>
			varCRPTotal=parseFloat(varCRPTotal)+parseFloat(NanNumber(document.forms[0].txt_crpspreadval[<%=a%>].value));
		<%}
	}
	else if(arrRowCRP!=null && arrRowCRP.size()==1)
	{%>
		varCRPTotal=parseFloat(NanNumber(document.forms[0].txt_crpspreadval.value));
	<%}
	%>

	var vararr=(document.forms[0].sel_mclrtype.value).split("@");
	if(vararr!=null)
	{
		if(vararr[0]!="ST" && vararr[0]!="TB")
		{
			if(eval(varBSPHO)!=0 && eval(eval(varBSPTotal)+eval(varBSPHO))<0)
			{
				alert("Market Competition Rebate (Threat of losing the Account) (HO) should not be greater than Business Statregic Premium");
				return;
			}
		}
		else
		{
			if(eval(varBSPHO)!=0 && eval(eval(varCRPTotal)+eval(varBSPHO))<0)
			{
				alert("Market Competition Rebate (Threat of losing the Account) (HO) should not be greater than Credit Risk Premium");
				return;
			}
		}
	}
	var varCRPTot = 0;
	if(varDigiLoanType == "PC"){
	if(parseInt(varCRPSize)>1)
	{
		for(var i=0;i<(document.forms[0].txt_crpspreadval.length);i++)
		{
			varCRPTot=varCRPTot+parseFloat(NanNumber(document.forms[0].txt_crpspreadval[i].value));
			document.forms[0].hidcrptotal.value=varCRPTot;
		}
		
	}
	else if(parseInt(varCRPSize)==1)
	{
		varCRPTot=varCRPTot+parseFloat(NanNumber(document.forms[0].txt_crpspreadval.value));
		document.forms[0].hidcrptotal.value=varCRPTot;
	}}
	
	document.forms[0].hidAction.value="update";
	document.forms[0].cmdsave.disabled=true;
	disablefields(false);
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="UpdateFacilityMCLRDetails";
	document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
	document.forms[0].hidSourceUrl.value="/action/facility_mclr.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doEdit()
{
	var boolflag=false;
	if(varPostSanc=="P")
	{
		disablefields(true);
		
		var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
		if(varPSterms == "")
		{
			boolflag=true;
		}
		else
		{
			for(var i=0;i<varPSterms.length;i++)
			{
				if(varPSterms[i] == "MRI")
				{
					//document.forms[0].sel_mclrtype.disabled = false;
					//document.forms[0].sel_facilitysno.disabled=true;
					//callDisableControls(true,false,false,false,false);
					//return;
					boolflag=true;
				}
				else if(varPSterms[i] == "BRTOMCLR")
				{
					boolflag=true;
				}
			}
		}
	}
	else
	{
		boolflag=true;
	}
	
	if(boolflag)
	{
		disablefields(false);

		<%if (arrRowCRP != null && arrRowCRP.size() > 0) 
		{
			for (int i = 0; i < arrRowCRP.size(); i++) 
			{
				arrCol = (ArrayList) arrRowCRP.get(i);
				if (arrRowCRP.size() == 1) 
				{
					if (Helper.correctNull((String) arrCol.get(2)).contains("(HO)")) 
					{
						if(strHOFlag.equalsIgnoreCase("Y")){%>
							document.forms[0].sel_crpspreadoption.disabled=false;
						<%} else {%>
							document.forms[0].sel_crpspreadoption.disabled=true;
						<%}
					}
				} 
				else 
				{
					if (Helper.correctNull((String) arrCol.get(2)).contains("(HO)")) 
					{
						if(strHOFlag.equalsIgnoreCase("Y")){%>
							document.forms[0].sel_crpspreadoption[<%=i%>].disabled=false;
						<%} else {%>
							document.forms[0].sel_crpspreadoption[<%=i%>].disabled=true;
						<%}
					}
				}
			}
		}
		
		if (arrRowBSP != null && arrRowBSP.size() > 0) 
		{
			for (int i = 0; i < arrRowBSP.size(); i++) 
			{
				arrCol = (ArrayList) arrRowBSP.get(i);
				if (arrRowBSP.size() == 1) 
				{
					if (Helper.correctNull((String) arrCol.get(2)).contains("(HO)")) 
					{
						if(strHOFlag.equalsIgnoreCase("Y")){%>
							document.forms[0].sel_bspspreadoption.disabled=false;
							<%if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Market Competition Rebate (Threat of losing the Account) (HO)")){%>
								document.forms[0].txt_bspspreadval.readOnly=false;
							<%}
						} else {%>
							document.forms[0].sel_bspspreadoption.disabled=true;
						<%}
					}								
					
					if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Market Competition Rebate (Threat of losing the Account) (HO)")){
						if(strHOFlag.equalsIgnoreCase("Y")){%>
						document.forms[0].txt_bspspreadval.readOnly=false;
						<%}
					}
					if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Additional Premium for Adhoc Facilities(WCDPN)")){%>
						if(varWCDPNauth == "Y")
						{
							document.forms[0].txt_bspspreadval.readOnly=false;
						}
						else
						{
							document.forms[0].txt_bspspreadval.readOnly=true;
						}
					<%}
				} 
				else 
				{
					if (Helper.correctNull((String) arrCol.get(2)).contains("(HO)")) 
					{
						if(strHOFlag.equalsIgnoreCase("Y")){%>
							document.forms[0].sel_bspspreadoption[<%=i%>].disabled=false;
							<%if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Market Competition Rebate (Threat of losing the Account) (HO)")){%>
								document.forms[0].txt_bspspreadval[<%=i%>].readOnly=false;
							<%}%>
						<%} else {%>
							document.forms[0].sel_bspspreadoption[<%=i%>].disabled=true;
						<%}
					}
								
					if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Market Competition Rebate (Threat of losing the Account) (HO)"))
					{
						if(strHOFlag.equalsIgnoreCase("Y")){%>
							document.forms[0].txt_bspspreadval[<%=i%>].readOnly=false;
						<%}
					}
					if(Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Additional Premium for Adhoc Facilities(WCDPN)")){%>
						if(varWCDPNauth == "Y")
						{
							document.forms[0].txt_bspspreadval[<%=i%>].readOnly=false;
						}
						else
						{
							document.forms[0].txt_bspspreadval[<%=i%>].readOnly=true;
						}
					<%}
				}
			}
		}%>
			
		document.forms[0].sel_facilitysno.disabled=true;
		callDisableControls(true,false,false,false,false);
	}
	if(varPostSanc=="P")
	{
		document.forms[0].cmddelete.disabled=true;
	}

	<%if (arrRowCRP != null && arrRowCRP.size() > 0) 
	{
		for (int i = 0; i < arrRowCRP.size(); i++) 
		{
			arrCol = (ArrayList) arrRowCRP.get(i);
			if (arrRowCRP.size() == 1) 
			{%>
				if(varDigiLoanType == "PC")
					{
						document.forms[0].txt_crpspreadval.readOnly=true;
					}
				<%} else{%>
				if(varDigiLoanType == "PC")
				{
					document.forms[0].txt_crpspreadval[<%=i%>].readOnly=true;
				}
			
				<%}
			}
		}%>

		if(varDigiLoanType == "PC" && varRoiEnableFlag == "Y")
		{
			document.forms[0].cmdroiupdate.disabled=false;
		}

		if(varDigiLoanType == "PC"){
			document.forms[0].txtloan_SecValue.readOnly=false;
		}
		if(varstrFacMCLR=="FTBR")
			{
			document.forms[0].sel_mclrtype.disabled=true;
			}
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].cmdsave.disabled=true;
		disablefields(false);
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanMethod.value="UpdateFacilityMCLRDetails";
		document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
		document.forms[0].hidSourceUrl.value="/action/facility_mclr.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function doCancel()
{
	disablefields(false);
	/*if(varstrFacMCLR == "FTBR")
		{
		document.forms[0].txt_subduedate.value="";
		}*/
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
	document.forms[0].action=appURL+"action/facility_mclr.jsp";
	document.forms[0].submit();
}
function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function callOnLoad()
{

		disablefields(true);
	document.forms[0].sel_facilitysno.disabled=false;

	if(varDigiLoanType == "PC"){
	if(varGuarantee!="S" && varmclrtype!="")
	{
	document.forms[0].sel_GuarCovered.value = varGuarantee;
	}}

	if(varfacsno!="")
	{
		document.forms[0].sel_facilitysno.value=varfacsno;
	}
	else
	{
		document.forms[0].sel_facilitysno.selectedIndex=0;
	}
	if(varstrFacMCLR == "FTBR"){
		if(varfbilreffdate!="" && varfbilreffdate!="0")
		{
			document.forms[0].txt_subduedate.value = varfbilreffdate;
			
		}
		else
			{
			document.forms[0].txt_subduedate.value = "";
			}
		if(varfbilrefffrq!="")
			{
			document.forms[0].sel_fbill_fre.value = varfbilrefffrq;
			}
		else
			{
			document.forms[0].sel_fbill_fre.value = "";
			}
		document.all.fbillrefferencedate.style.visibility="visible";
		document.all.fbillrefferencedate.style.position="relative";
		}
	else
		{
		document.forms[0].txt_subduedate.value="";
		document.forms[0].sel_fbill_fre.value = "";
		document.all.fbillrefferencedate.style.visibility="hidden";
		document.all.fbillrefferencedate.style.position="absolute";
		}
	if(varmclrtype!="")
	{
		document.forms[0].sel_mclrtype.value=varmclrtype;
	}
	else
	{
		document.forms[0].sel_mclrtype.selectedIndex=0;
	}
	/*if(varstrFacMCLR != "FTBR")
		{
	if(varmclrtype!="")
	{
		document.forms[0].sel_mclrtype.value=varmclrtype;
	}
	else
	{
		document.forms[0].sel_mclrtype.selectedIndex=0;
	}
		}
	else
		{
		if(varfbilreffdate!="" && varfbilreffdate!="0")
			{
			//alert(varfbilreffdate);
		document.forms[0].txt_subduedate.value = varfbilreffdate;
		//ftbilldatechk(document.forms[0].txt_subduedate);
		if(varmclrtype!="")
		{
			//alert(varmclrtype);
			document.forms[0].sel_mclrtype.selectedIndex=1;
			document.forms[0].sel_mclrtype.value=varmclrtype;
			//alert(document.forms[0].sel_mclrtype.value);
		}
		else
		{
			document.forms[0].sel_mclrtype.selectedIndex=0;
		}
			}
		}*/

	if(document.forms[0].btnenable.value=="Y" && document.forms[0].sel_facilitysno.value!="")
	{
		callDisableControls(false,true,true,true,false);
	}
	else
	{
		callDisableControls(true,true,true,true,false);
	}

	<%if (arrRowCRP != null && arrRowCRP.size() > 0) {
				for (int i = 0; i < arrRowCRP.size(); i++) {
					arrCol = (ArrayList) arrRowCRP.get(i);%>
		<%if (arrRowCRP.size() == 1) {%>
		document.forms[0].sel_crpspreadoption.value='<%=Helper.correctNull((String) arrCol.get(3))%>';
		<%} else {%>
		document.forms[0].sel_crpspreadoption[<%=i%>].value='<%=Helper.correctNull((String) arrCol.get(3))%>';
		<%}
				}%>

		<%if(!strFacIntDef.equalsIgnoreCase("M")){%>
				document.all.idcrpsubtotal.style.display="table-cell";
		<%}%>
			<%}%>
	<%if (arrRowBSP != null && arrRowBSP.size() > 0) {
				for (int i = 0; i < arrRowBSP.size(); i++) {
					arrCol = (ArrayList) arrRowBSP.get(i);%>
		<%if (arrRowBSP.size() == 1) {%>
		document.forms[0].sel_bspspreadoption.value='<%=Helper.correctNull((String) arrCol.get(3))%>';
		<%} else {%>
		document.forms[0].sel_bspspreadoption[<%=i%>].value='<%=Helper.correctNull((String) arrCol.get(3))%>';
		<%}
				}
		if(!strFacIntDef.equalsIgnoreCase("M")){%>
				document.all.idbspsubtotal.style.display="table-cell";
		<%}
			}%>


			<%if(strFacIntDef.equalsIgnoreCase("F")){%>
			document.all.idfloating.style.display="none";
			document.all.idfixed.style.display="inline";
			<%}else{%>
			document.all.idfloating.style.display="inline";
			document.all.idfixed.style.display="none";
			<%}%>

			<%if(Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P")){%>
			if(varPostSanc=="P")
			{
				var varPSterms = document.forms[0].hidPostSancParams.value.split("@");
				for(var i=0;i<varPSterms.length;i++)
				{
					if((varPSterms[i] == "MRI" && varMCLRFlag=="Y") || varPSterms[i] == "BRTOMCLR")
					{
						document.forms[0].cmdedit.disabled=false;
						return;
					}
					else
						document.forms[0].cmdedit.disabled=true;
				}
			}
			<%}else{%>

			if(varCIBILFlag=="Y")
			{
				var var1=varCIBILDet.split("~");
				if(var1[0]!="Y" && var1[0]!="N")
				{
					alert("Please update Applicant CIBIL details in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
				else if(var1[0]=="Y" && var1[1]=="0")
				{
					alert("Please update Applicant CIBIL Score in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
				else if(var1[0]=="N")
				{
					alert("Please verify Applicant CIBIL Score and update Details in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
			}
			else if(varCRIFFlag=="Y")
			{
				var var1=varCRIFDet.split("~");
				if(var1[0]!="Y" && var1[0]!="N")
				{
					alert("Please update Applicant CRIF details in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
				else if(var1[0]=="Y" && var1[1]=="0")
				{
					alert("Please update Applicant CRIF Score in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
				else if(var1[0]=="N")
				{
					alert("Please verify Applicant CRIF Score and update Details in Customer profile -> Rating/Defaulter tab");
					document.forms[0].cmdedit.disabled=true;
				}
			}
			<%}%>

			if(document.forms[0].hidEditFlag.value=="Y")
			{
				doEdit();
				setvalues('N');
				document.forms[0].hidEditFlag.value="";
			}

			if(varDigiLoanType == "PC" && varRoiEnableFlag == "Y")
			{
				document.forms[0].cmdroiupdate.disabled=true;
			}
			document.getElementById("progress").style.visibility="hidden";

			if(varroiflag == "Y" && VARROIDATECHECK == "Y")
			{
				alert("ROI Updated !. Please Check. ");
			}

			if(varroiflag == "O")
			{
				alert("Total rate of interest or CRP is 0 from Digi. please check");
			}

			<%if (arrRowCRP != null && arrRowCRP.size() > 0) {
				for (int i = 0; i < arrRowCRP.size(); i++) {		
					if(APP_LOANSUBTYPE_DIGI.equals("PC")){ %>
					document.forms[0].sel_GuarCovered.disabled=true;
			<%} }
			}else if(arrRowBSP != null && arrRowBSP.size() > 0)
			{
				for (int i = 0; i < arrRowBSP.size(); i++) {
					if(APP_LOANSUBTYPE_DIGI.equals("PC")){ %>
								document.forms[0].sel_GuarCovered.disabled=true;					
			<%}}}%>
			
}
function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=true;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
	}
}

function callfacilitydetails()
{
	document.forms[0].hidBeanId.value = "facilities";
	document.forms[0].hidBeanGetMethod.value = "getFacilityMCLRDetails";
	document.forms[0].action = appURL + "action/facility_mclr.jsp";
	document.forms[0].submit();
}
function getvalue(id,type,val,size)
{
	var value=val.value;
	if(value=="-")
	{
		alert("select option value");

		if(type=="BSP")
		{
			<%if(arrRowBSP!=null && arrRowBSP.size()>0){
				if (arrRowBSP.size()==1) {%>
				document.forms[0].txt_bspspreadval.value="0.00";
			<%}else{%>
				document.forms[0].txt_bspspreadval[id].value="0.00";
			<%}}%>
		}
		else if(type=="CRP")
		{
			<%if(arrRowCRP!=null && arrRowCRP.size()>0){
				if (arrRowCRP.size()==1) {%>
				document.forms[0].txt_crpspreadval.value="0.00";
			<%}else{%>
				document.forms[0].txt_crpspreadval[id].value="0.00";
			<%}}%>
		}
		setvalues('N');
		return;
	}
	
	document.all.ifrm1.src = appURL

	+ "action/iframemclr.jsp?hidBeanGetMethod=getMCLRSpreadValue&hidBeanId=facilities&strtype="

	+ type+"&strID="+id+"&strValue="+value+"&strSize="+size;
}
function setvalues(varFlag)
{
	var varvalue=document.forms[0].sel_mclrtype.value;
	var vararr=varvalue.split("@");

	if(varFlag=="Y" && document.forms[0].sel_mclrtype.value!="")
	{
		var vararr=(document.forms[0].sel_mclrtype.value).split("@");
		if(vararr!=null)
		{
			if((("<%=strFacMCLR%>"=="SMTB" || "<%=strFacMCLR%>"=="EBLEC") && vararr[0]!="ST")||("<%=strFacMCLR%>"=="TYGS" && vararr[0]!="TG")||(("<%=strFacMCLR%>"=="MCLR"||"<%=strFacMCLR%>"=="MCLEC") && (vararr[0]=="TG"||vararr[0]=="ST")))
			{
		    	alert("Reference type should match with Interest Sub type");
		    	document.forms[0].sel_mclrtype.value="";
		    	return;
			}
		}
	}

	var vararr=(document.forms[0].sel_mclrtype.value).split("@");
	var varMCLRType="";
	if(vararr!=null)
	{
		varMCLRType=vararr[0];
	}
	
	if(varFlag=="Y" && document.forms[0].sel_mclrtype.value!=varmclrtype)
	{
		{
			if((varMCLRType=="ST" && ("<%=strFacMCLR%>"!="SMTB" && "<%=strFacMCLR%>"!="EBLEC" )) ||(varMCLRType=="TB" && "<%=strFacMCLR%>"!="TYGS"))
			{
		    	alert("Reference type should match with Interest Sub type");
		    	document.forms[0].sel_mclrtype.value="";
		    	return;
			}
		}
		
		document.forms[0].hidEditFlag.value="Y";
		document.forms[0].sel_facilitysno.disabled=false;
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
		document.forms[0].action=appURL+"action/facility_mclr.jsp";
		document.forms[0].submit();
		return;
	}
	
	if(varvalue!="")
	{
		if(vararr!=null)
		{
			if(document.forms[0].hidLoanType.value=="OD")
				document.forms[0].hidMCLRTableCode.value=vararr[3];
			else
				document.forms[0].hidMCLRTableCode.value=vararr[2];
			document.forms[0].hidMCLRSpread.value=vararr[1];
		}
	}
	else
	{
		document.forms[0].hidMCLRSpread.value="0.00";
	}
	var varCRPTot=0.0,varBSP=0.0;

	if(parseInt(varCRPSize)>1)
	{
		for(var i=0;i<(document.forms[0].txt_crpspreadval.length);i++)
		{
			varCRPTot=varCRPTot+parseFloat(NanNumber(document.forms[0].txt_crpspreadval[i].value));
		}
		
	}
	else if(parseInt(varCRPSize)==1)
	{
		varCRPTot=varCRPTot+parseFloat(NanNumber(document.forms[0].txt_crpspreadval.value));
	}
	if(parseInt(varBSPSize)>1)
	{
		for(var i=0;i<(document.forms[0].txt_bspspreadval.length);i++)
		{
			if(document.forms[0].hidbspcaption[i].value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{
				if(varMCLRType!='ST' && varMCLRType!="TG")
				{
					varBSP=varBSP+parseFloat(NanNumber(document.forms[0].txt_bspspreadval[i].value));
				}
				else
				{
					varCRPTot=varCRPTot+parseFloat(NanNumber(document.forms[0].txt_bspspreadval[i].value));
				}
			}
			else
			{
				varBSP=varBSP+parseFloat(NanNumber(document.forms[0].txt_bspspreadval[i].value));
			}

			
		}
	}
	else if(parseInt(varBSPSize)==1)
	{
		varBSP=varBSP+parseFloat(NanNumber(document.forms[0].txt_bspspreadval.value));
	}

	if(parseFloat(varCRPTot)<0)
	{
		varCRPTot=0.0;
	}
	if(parseFloat(varBSP)<0)
	{
		varBSP=0.0;
	}
	if(varDigiLoanType != "PC")
	{
	document.forms[0].hidcrptotal.value=varCRPTot;
	}
	document.forms[0].hidcrptotal.value=roundtxt(document.forms[0].hidcrptotal);
	
	document.forms[0].hidbsptotal.value=varBSP;
	document.forms[0].hidbsptotal.value=roundtxt(document.forms[0].hidbsptotal);
	
	document.forms[0].hidtotalIntRate.value=parseFloat(NanNumber(document.forms[0].hidMCLRSpread.value))+
	parseFloat(NanNumber(document.forms[0].hidcrptotal.value))+parseFloat(NanNumber(document.forms[0].hidbsptotal.value))+
	+parseFloat(NanNumber(document.forms[0].hidMSMEpercnt.value));
	
	document.forms[0].hidtotalIntRate.value=roundtxt(document.forms[0].hidtotalIntRate);

	if(varGuarantee!="S" && varDigiLoanType == "PC")
	{
	document.forms[0].sel_GuarCovered.value = varGuarantee;
	}
}
function funSpreadVal(varflag)
{
	var varbsrvalue=0;
	setvalues('N');
	var varIntDevVal=parseFloat(document.forms[0].hidIntDevLimit.value);
	varIntDevVal=parseFloat("-"+varIntDevVal);
	<%if(arrRowBSP!=null && arrRowBSP.size()>0){%>
	
		<%if (arrRowBSP.size()==1) {%>
			varbsrvalue=parseFloat(NanNumber(document.forms[0].txt_bspspreadval.value));
			if(document.forms[0].hidbspcaption.value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{

				if((parseFloat(varbsrvalue)<parseFloat(varIntDevVal))||(parseFloat(varbsrvalue)>0))
				{
					alert("The spread value should be greater than "+parseFloat(varIntDevVal)+" and less than or equal to zero");
					document.forms[0].txt_bspspreadval.value="0.00";
					setvalues('N');
					return;
				}
			}
			if(document.forms[0].hidbspcaption.value=="Additional Premium for Adhoc Facilities(WCDPN)")
			{
				if(parseFloat(varbsrvalue)>parseFloat(varWCDPNint) || parseFloat(varbsrvalue)<0)
				{
					alert("The Adhoc Premium cannot be greater than "+parseFloat(varWCDPNint)+" and less than zero");
					document.forms[0].txt_bspspreadval.value=varWCDPNint;
					setvalues('N');
					return;
				}
			}
		<%}else{%>
			varbsrvalue=parseFloat(NanNumber(document.forms[0].txt_bspspreadval[varflag].value));
			if(document.forms[0].hidbspcaption[varflag].value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{
				if((parseFloat(varbsrvalue)<parseFloat(varIntDevVal))||(parseFloat(varbsrvalue)>0))
				{
					alert("The spread value should be greater than "+parseFloat(varIntDevVal)+" and less than or equal to zero");
					document.forms[0].txt_bspspreadval[varflag].value="0.00";
					setvalues('N');
					return;
				}
			}
			if(varIntDefinition=="S" && document.forms[0].hidbspcaption[varflag].value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{

				if(varintrefno!="Y" && document.forms[0].txt_bspspreadval[varflag].value!="" && document.forms[0].txt_bspspreadval[varflag].value!="0.00")
				{
					<%if(strHOFlag.equalsIgnoreCase("Y")){%>
						alert("Please Enter Deviation reference number for this proposal in Basic Information tab");
						document.forms[0].txt_bspspreadval[varflag].value="0.00";
						setvalues('N');
						return;	
					<%}%>
				}
				
				var vardifference=parseFloat(NanNumber(document.forms[0].txt_bspspreadval[varflag-1].value));
				//if(parseFloat(vardifference)>2.5)
				//{
					//vardifference=2.5;
				//}
				if((parseFloat(varbsrvalue)<parseFloat(varIntDevVal))||(parseFloat(varbsrvalue)>0))
				{
					alert("The spread value should be greater than "+parseFloat(varIntDevVal)+" and less than or equal to zero");
					document.forms[0].txt_bspspreadval[varflag].value="0.00";
					setvalues('N');
					return;
				}
				//if(parseFloat(varbsrvalue)>parseFloat(vardifference))
				//{
				//	alert("The spread value should be greater than "+parseFloat(vardifference));
				//	document.forms[0].txt_bspspreadval[varflag].value="0.00";
				//	setvalues();
				//	return;
				//}
			}
			if(document.forms[0].hidbspcaption[varflag].value=="Additional Premium for Adhoc Facilities(WCDPN)")
			{
				if(parseFloat(varbsrvalue)>parseFloat(varWCDPNint) || parseFloat(varbsrvalue)<0)
				{
					alert("The Adhoc Premium cannot be greater than "+parseFloat(varWCDPNint)+" and less than zero");
					document.forms[0].txt_bspspreadval[varflag].value=varWCDPNint;
					setvalues('N');
					return;
				}
			}
		<%}%>
	<%}%>
	var varBSPTotal=0,varBSPHO=0,varCRPTotal=0;
	<%if(arrRowBSP!=null && arrRowBSP.size()>1)
	{
		for(int a=0;a<arrRowBSP.size();a++)
		{%>
			if(document.forms[0].hidbspcaption[<%=a%>].value=="Market Competition Rebate (Threat of losing the Account) (HO)")
			{
				varBSPHO=parseFloat(NanNumber(document.forms[0].txt_bspspreadval[<%=a%>].value));
			}
			else
			{
				varBSPTotal=parseFloat(varBSPTotal)+parseFloat(NanNumber(document.forms[0].txt_bspspreadval[<%=a%>].value));
			}
		<%}
	}
	if(arrRowCRP!=null && arrRowCRP.size()>1)
	{
		for(int a=0;a<arrRowCRP.size();a++)
		{%>
			varCRPTotal=parseFloat(varCRPTotal)+parseFloat(NanNumber(document.forms[0].txt_crpspreadval[<%=a%>].value));
		<%}
	}
	else if(arrRowCRP!=null && arrRowCRP.size()==1)
	{%>
		varCRPTotal=parseFloat(NanNumber(document.forms[0].txt_crpspreadval.value));
	<%}
	%>

	var vararr=(document.forms[0].sel_mclrtype.value).split("@");
	if(vararr!=null)
	{
		if(vararr[0]!="ST" && vararr[0]!="TB")
		{
			if(eval(varBSPHO)!=0 && eval(eval(varBSPTotal)+eval(varBSPHO))<0)
			{
				alert("Market Competition Rebate (Threat of losing the Account) (HO) should not be greater than Business Statregic Premium");
				return;
			}
		}
		else
		{
			if(eval(varBSPHO)!=0 && eval(eval(varCRPTotal)+eval(varBSPHO))<0)
			{
				alert("Market Competition Rebate (Threat of losing the Account) (HO) should not be greater than Credit Risk Premium");
				return;
			}
		}
	}
}

function callCalender(val)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		 showCal(appURL,val);
	}
}


function callRoiUpdate()
{
	if(varSecValue == "" || varSecValue == "0.00")
	{
		alert("Please Fill Security Value ");
		document.forms[0].txtloan_SecValue.focus();
		return false;
	}
	
	 if(varmisdetails != "Y")
	{
		alert("Please Fill MIS/CBS Details ");
		return false;
	} 
	//shiva
/*	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="msmeRoiUpdateServices";
	document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
	document.forms[0].action=appURL+"action/facility_mclr.jsp";
	document.forms[0].submit();
	document.getElementById("progress").style.visibility="visible";
	disablefields(false);*/

	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanMethod.value="msmeRoiUpdateServices";
	document.forms[0].hidBeanGetMethod.value="getFacilityMCLRDetails";
	document.forms[0].hidSourceUrl.value="/action/facility_mclr.jsp"; 
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
	document.getElementById("progress").style.visibility="visible";
	disablefields(false);
}
function allowalwysOldDate(obj,mindate,chkdate)
{
	if(chkdate=="")
		{
		chkdate=document.forms[0].hidinwarcreateddate.value
		if(chkdate=="")
			{
		alert("Please select the Application Number");
		obj.value="";
		return false;
			}
		}
	var pagedate=obj.value;
	var pgdt=changeDateformat(pagedate);
	var mindt=changeDateformat(mindate);
	var chk=changeDateformat(chkdate);
	if(obj.value!="")
	{
		if(Date.parse(pgdt) > Date.parse(mindt))
		{
			
			
			alert("Referred Date can not be greater than Today date " + mindate );
			obj.value="";
			obj.focus();
			return false;
		}
		else if(Date.parse(pgdt) < Date.parse(chk))
		{
			alert("Referred Date should not be earlier than the LAR Creation Date  " +chkdate );
			obj.value="";
			obj.focus();
			return false;
		}
	}
	return true;
}

//roi details
function callRoiDetails()
{
	alert("Rate Of Interest: "+varBaseRate+"\n\n"+"Concession Interest: "+varConcession+"\n\n"+"Concession Description: "+varPenalty);
		return;
	
}

function ftbilldatechk(fbilldata)
{
	
	var tenordateval=fbilldata.value;
	//alert(tenordateval);
	if(tenordateval !="")
		{
	document.all.ifrm3.src=appURL+"action/iframeftbilldatechk.jsp?hidBeanGetMethod=chkMCLRTable&hidBeanId=facilities&fbilldatavalue="+tenordateval;
		}
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callOnLoad();">
<div id="progress" style="position:absolute; width:106px; visibility:hidden; height:19px; z-index:1; left:700px; top: 100px"> 
    <img src="<%=ApplicationParams.getAppUrl()%>img/processing2.gif"> </div></td>
<form method="post" class="normal">
<%if((Helper.correctNull((String)hshValues.get("app_renew_flag")).equalsIgnoreCase("P"))||(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P"))){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
			<jsp:param name="pageid" value="34" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
			<jsp:param name="applevel" value="" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%}else{ %>
<jsp:include page="../com/proposallinks.jsp" flush="true"> 
            <jsp:param name="pageid" value="29" />
	  <jsp:param name="cattype" value="<%=strCategoryType%>" />
	  <jsp:param name="ssitype" value="<%=strSSIType%>" />		
	</jsp:include>

<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<%
			String strSessionModuleType = Helper.correctNull(
					(String) session.getAttribute("sessionModuleType")).trim();
			if (strSessionModuleType.equalsIgnoreCase("AGR")) {
		%>
		<td class="page_flow">Home -&gt; Agriculture -&gt;Application
		-&gt; Applicant -&gt; MCLR</td>
		<%
			} else {
		%>
		<td class="page_flow">Home -&gt; Corporate &amp; SME
		-&gt;Application -&gt; Applicant -&gt; MCLR</td>
		<%
			}
		%>
	</tr>
</table>
<span style="display: none;"><lapschoice:borrowertype /></span><lapschoice:application />
<%} %>
<table width="95%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
		<td>
		<table width="60%" border="0" cellspacing="0" cellpadding="3"
			class="outertable" align="center">
			<tr align="center">
				<td>Facility &nbsp; &nbsp; <select name="sel_facilitysno"
					tabindex="1" onchange="callfacilitydetails();">
					<option value="" selected="selected">--Select--</option>
					<lapschoice:ComMisDetailsTag
						apptype='<%=Helper.correctNull((String) request
									.getParameter("appno"))%>'
						page='mclr' />
				</select></td>
			</tr>

		</table>
		</td>
	</tr>
	<tr>
		<td>
		<table width="90%" border="0" cellspacing="0" cellpadding="3"
			class="outertable border1" align="center">
			<tr>
				<td align="center"><br/>
				<span id="idfixed" ><font color="red"><b>Floating Rate is not available for this facility </b></font></span>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
					class="outertable" align="center" id="idfloating">
					<tr id="fbillrefferencedate"  style="visibility: hidden; position: absolute;">
					<td width="30%"> FBIL-T-Bill referred date <span
											class="mantatory">*</span> </td>
											<td width="30%" id="idsubduedatetxt"><input type="text" name="txt_subduedate"
													size="16"
													onBlur="allowalwysOldDate(this,currentDate,'<%=Helper.correctNull((String)hshValues.get("miboinward_created"))%>');ftbilldatechk(this)"
													value="">
												<a alt="Select date from calender" id="subduedate"
													href="#" onClick="callCalender('txt_subduedate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a></td>
												 <td width="10%">Interest Reset Frequence</td>
													 <td><select name="sel_fbill_fre">
													<option value=" " selected="selected">--Select--</option>
													<option value="M" >Monthly</option>
													<option value="Q">Quarterly</option>
													<option value="H">Half-Yearly</option>
													<option value="Y">Yearly</option>
												</select></td>	 
													
					</tr>
					<tr>
						<td  width="30%">Reference Type</td>
						<td  width="30%">
						<select name="sel_mclrtype" onchange="setvalues('Y');">
							<option value=""><--select--></option>
							<%if(strappstatus.equalsIgnoreCase("op") && strFacMCLR.equalsIgnoreCase("FTBR") && !Helper.correctNull((String)hshValues.get("fbilreffdate")).equalsIgnoreCase("0")){ %>
							 <lapschoice:MCLRTagForfbill fibilldate='<%=Helper.correctNull((String)hshValues.get("fbilreffdate"))%>'/>
							<%}else if(strappstatus.equalsIgnoreCase("op")){ %>
						       <lapschoice:MCLRTag/>
							<%}else{ %>
								<option value="<%=strOption%>"><%=strDescription%></option>
							<%} %>
						</select></td>
						<td><lapschoice:CurrencyTag name="hidMCLRSpread" value='<%=Helper.correctDouble((String) hshValues
							.get("mclr_spread"))%>'/></td>
					</tr>
					<%
						if (arrRowCRP != null && arrRowCRP.size() > 0) {
					%>
					<%if(strFacIntDef.equalsIgnoreCase("M")){ %>
					<tr class="dataheader">
						<td colspan="3">Credit Risk Premium</td>
					</tr>
					<%} %>
					<%
						for (int i = 0; i < arrRowCRP.size(); i++) {
								arrCol = (ArrayList) arrRowCRP.get(i);
					%>
					<tr>
					<td nowrap="nowrap"><b><%=Helper.correctNull((String) arrCol.get(2))%><input type="hidden" name="hidcrpcaption" value="<%=Helper.correctNull((String) arrCol.get(2))%>"></b></td>
					<%if(!strFacIntDef.equalsIgnoreCase("M")){ %>
					<td><input type="hidden" name="sel_crpspreadoption">
					<input type="hidden" name="hidcaptionval" value="<%=Helper.correctNull((String) arrCol.get(1))%>"></td>
					<%}else{ %>
					<td>
					<select name="sel_crpspreadoption" onchange="getvalue('<%=i%>','CRP',this,'<%=arrCRPSize%>');">
					<option value="-"> <-- select --></option>
					<%
						String strVal = Helper.correctNull((String) arrCol.get(1));
					%>
					<lapschoice:MCLRMaster value='<%=strVal%>' />
					</select>
					<input type="hidden" name="hidcaptionval" value="<%=strVal%>">
					</td>
					<%} %>
					<td>
					<lapschoice:CurrencyTag name="txt_crpspreadval"  value='<%=Helper.correctDouble((String) arrCol
											.get(4))%>'/>
					</td>
					</tr>
					<%
						}
					%>
					<tr class="datagrid"  id="idcrpsubtotal">
					<td colspan="2" align="right"><b>Sub Total/Modified Value</b></td>
					<td><lapschoice:CurrencyTag name ="hidcrptotal" value='<%=Helper.correctDouble((String) hshValues
								.get("mclr_crp_total"))%>'/></td>
					</tr>
					<%
						}
					%>
					<%
						if (arrRowBSP != null && arrRowBSP.size() > 0) {
					%>
					<%if(strFacIntDef.equalsIgnoreCase("M")){ %>
					<tr class="dataheader">
						<td colspan="3">Business strategic Premium</td>
					</tr>
					<%} %>
					<%
						for (int i = 0; i < arrRowBSP.size(); i++) {
								arrCol = (ArrayList) arrRowBSP.get(i);
					%>
					<tr>
					<td nowrap="nowrap"><b><%=Helper.correctNull((String) arrCol.get(2))%> <input type="hidden" name="hidbspcaption" value="<%=Helper.correctNull((String) arrCol.get(2))%>"></b></td>
					<%if((!strFacIntDef.equalsIgnoreCase("M")) || (Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Market Competition Rebate (Threat of losing the Account) (HO)")) || (Helper.correctNull((String) arrCol.get(2)).equalsIgnoreCase("Additional Premium for Adhoc Facilities(WCDPN)"))){ %>
					<td style="visibility: hidden;position: relative;"><select name="sel_bspspreadoption">
					<option value="-"><-- select --></option>
					</select>
					<input type="hidden" name="hidbspcaptionval" value="<%=Helper.correctNull((String) arrCol.get(1))%>"></td>
					<%}else{ %>
					<td>
					<select name="sel_bspspreadoption" onchange="getvalue('<%=i%>','BSP',this,'<%=arrBSPSize%>');">
					<option value="-"> <-- select --></option>
					<%
						String strVal = Helper.correctNull((String) arrCol.get(1));
					%>
					<lapschoice:MCLRMaster value='<%=strVal%>' />
					</select>
					<input type="hidden" name="hidbspcaptionval" value="<%=strVal%>">
					</td>
					<%} %>
					<td>
					<input type="text" name="txt_bspspreadval"  value='<%=Helper.correctDouble((String) arrCol
											.get(4))%>' onkeypress="allowNegtiveNumber(this);" onBlur="roundtxt(this);funSpreadVal('<%=i %>')" style="text-align: right;" />
					</td>
					</tr>
					<%
						}
					%>
					<tr class="datagrid" id="idbspsubtotal">
					<td colspan="2"  align="right"><b>Sub Total/Modified Value</b></td>
					<td><lapschoice:CurrencyTag name ="hidbsptotal" value='<%=Helper.correctDouble((String) hshValues
								.get("mclr_bsp_total"))%>'/></td>
					</tr>
					<%
						}
					%>
					
					<tr class="dataheader">
					<td colspan="2" align="right"><b>Final Interest Rate</b></td>
					<td><lapschoice:CurrencyTag name ="hidtotalIntRate" value='<%=Helper.correctDouble((String) hshValues
							.get("dblTotalIntRate"))%>'/>
					<%if(Helper.correctDouble((String)hshValues.get("strMSMEborrower")).equalsIgnoreCase("Y")){ %>**<%} %>		
					</td>
					</tr>
					<%if(Helper.correctDouble((String)hshValues.get("strMSMEborrower")).equalsIgnoreCase("Y")){ %>
					<tr class="datagrid">
					<td colspan="3"><b>** Since the borrower is categorized under the MSME category based on the exposure, <%=Helper.correctDouble((String)hshValues.get("strMSMEpercent"))%>% is added up with the final Interest rate.</b></td>
					</tr>
					<%} %>
					<%if(Helper.correctDouble((String)hshValues.get("strPostSancParam")).contains("BRTOMCLR")){ %>
					<tr>
					<td colspan="2"><b>Effective date of Migration</b></td>
					<td><input type="text" name="txt_migrationdate" value="<%=Helper.correctNull((String)hshValues.get("strMigrationDate")) %>" size="10" onBlur="checkDate(this);checkmindate(this,'01/04/2016');">&nbsp;
					<a alt="Select date from calender" href="#" onClick="callCalender('txt_migrationdate')"
													onMouseOver="window.status='Date Picker';return true;"
													onMouseOut="window.status='';return true;"><img
													src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
													border="0" alt="Select date from calender"></a>
					</td>
					</tr>
					<%} %>
										<%
						if (arrRowCRP != null && arrRowCRP.size() > 0) {
					
						for (int i = 0; i < arrRowCRP.size(); i++) {
								
					%>
					
					<% if(APP_LOANSUBTYPE_DIGI.equals("PC")){ %>
					<tr>
						<td nowrap="nowrap">Security Value &nbsp;&nbsp;<%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag
													name="txtloan_SecValue"  maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("strFACILITYSECAMOUNT"))%>'
													tabindex="6" />
													</td>
						<td nowrap="nowrap">Guarantee Covered by </td><td>
								<select name="sel_GuarCovered" onChange="callGuarCovered('Y');" style="width: 80%" tabindex="18">
									<option value="S" >--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="17" />
								</select>
						</td>
						
					</tr>
					<tr>
						<td nowrap="nowrap">KB Rating &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" name="kbrating" value='<%=Helper.correctNull((String)hshValues.get("KB_RATING"))%>'>
						</td>
													
						<td nowrap="nowrap">Band Rating </td><td nowrap="nowrap"><input type="text" name="bandrating"  size="50" 
						value='<%=Helper.correctNull((String)hshValues.get("BAND_RATING"))%>' tabindex="6">
						</td>
						
					</tr>
					<%} %>
					
					<%}
					}else if(arrRowBSP != null && arrRowBSP.size() > 0)
					{
						for (int i = 0; i < arrRowBSP.size(); i++) {
					%>
					<% if(APP_LOANSUBTYPE_DIGI.equals("PC")){ %>
					<tr>
						<td nowrap="nowrap">Security Value &nbsp;&nbsp;<%=ApplicationParams.getCurrency()%><lapschoice:CurrencyTag
													name="txtloan_SecValue"  maxlength="12"
													value='<%=Helper.correctNull((String)hshValues.get("strFACILITYSECAMOUNT"))%>'
													tabindex="6" />
													</td>
						<td nowrap="nowrap">Guarantee Covered by </td><td>
								<select name="sel_GuarCovered" onChange="callGuarCovered('Y');" style="width: 80%" tabindex="18">
									<option value="S" >--Select--</option>
									<lapschoice:BanksSchemeStaticDataNewTag apptype="17" />
								</select>
						</td>
						
					</tr>
					<tr>
						<td nowrap="nowrap">KB Rating &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<input type="text" name="kbrating"  value='<%=Helper.correctNull((String)hshValues.get("BAND_RATING"))%>' >
													</td>
													
						<td nowrap="nowrap">Band Rating </td><td nowrap="nowrap"><input type="text" name="bandrating"  size="50" 
						value='<%=Helper.correctNull((String)hshValues.get("BAND_RATING"))%>' tabindex="6">
													</td>
						
					</tr>
					<%} }}%>
				</table>
				<br/>
				</td>
			</tr>
		</table>
		</td>
	</tr>
	<tr><td>&nbsp;</td></tr>
</table>
<% if(APP_LOANSUBTYPE_DIGI.equals("PC") && strRoiEnableFlag.equals("Y")){ %>
<table width="20%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td align="center">
	<%  if(strappstatus.equals("op")){ %>
		<input type="button" value="ROI Update" class="buttonStyle" style="width: 150" name="cmdroiupdate" onClick="callRoiUpdate()" >
	<% } else {%>
		<input type="hidden" value="ROI Update" class="buttonStyle" style="width: 150" name="cmdroiupdate" onClick="callRoiUpdate()" >
	<% } %>
	</td>
	<td>
	<input type="button" value="ROI Details" class="buttonStyle" style="width: 150" name="cmdroiupdate" onClick="callRoiDetails()" >
	</td>
	</tr>
		<tr><td>&nbsp;</td></tr>
</table>
<%} %>
<table width="60%" border="0" cellspacing="0" cellpadding="3"
	class="outertable" align="center">
	<tr>
	<td>
	<lapschoice:combuttonnew btnnames='Edit_Save_Delete_Cancel'
		btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
	</td>
	</tr>
							
		<tr><td>&nbsp;</td></tr>
</table>
<iframe height="0" width="0" id="ifrm1" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm2" frameborder="0" style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm3" frameborder="0"	style="border: 0"></iframe>
<br>
<input type="hidden" name="hidMCLRTableCode" value="<%=Helper.correctNull((String) hshValues.get("mclr_tablecode"))%>">
<input type="hidden" name="hidPostSancParams" value="<%=Helper.correctNull((String)hshValues.get("strPostSancParam"))%>">
<input type="hidden" name="hidIntDevLimit" value="<%=Helper.correctDouble((String)hshValues.get("strIntDevLimit"))%>" />
<input type="hidden" name="hidMSMEpercnt" value="<%=Helper.correctDouble((String)hshValues.get("strMSMEpercent"))%>" />
<input type="hidden" name="hidScore" value="<%=Helper.correctDouble((String)hshValues.get("strScore"))%>" />
<input type="hidden" name="hidEditFlag" value="<%=Helper.correctDouble((String)hshValues.get("strEditFlag"))%>" />
<input type="hidden" name="hidDataFlag" value="<%=Helper.correctDouble((String)hshValues.get("strDataFlag"))%>" />
<input type="hidden" name="hidLoanType" value="<%=Helper.correctNull((String)hshValues.get("COM_FACILITY_LOANTYPE"))%>" />
<lapschoice:hiddentag pageid='<%=PageId%>' /></form>
</body>
</html>