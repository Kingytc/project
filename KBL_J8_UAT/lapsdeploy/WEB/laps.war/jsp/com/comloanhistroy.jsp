<%@include file="../share/directives.jsp"%>
<% 
if(strCategoryType.equalsIgnoreCase("CORPORATE"))
{
	strCategoryType ="CORP";
	
}
else if(strCategoryType.equalsIgnoreCase(""))
{
	strCategoryType=Helper.correctNull((String)hshValues.get("hidCategoryType"));
	if(strCategoryType.equalsIgnoreCase("CORPORATE"))
	{
		
		strCategoryType ="CORP";
		
	}else if(strCategoryType.equalsIgnoreCase("Corporate & SME")){
		strCategoryType ="CORP";
	}
}

String strCBSID=Helper.correctNull((String)hshValues.get("CBSid"));

if(strCBSID=="")
{
	strCBSID=Helper.correctNull((String)request.getParameter("CBSid"));
}
%>
<html>
<head>
<title>Commercial- Loan History Of Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/com/comloanhistory.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appid="<%=Helper.correctNull((String) request.getParameter("comapp_oldid"))%>";
var approvedApplDemoid="<%=Helper.correctNull((String) request.getParameter("approvedApplDemoid"))%>";

var newappno_val="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
var cbsid="<%=strCBSID%>";
//alert(appid);
var varstrSessionModuleType="<%=strCategoryType%>";

function callclose()
{
	var cattype="<%=strCategoryType%>";     //document.forms[0].cattype.value;
 	
	if(cattype=="CORP" ||cattype=="SME")
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/mainnav.jsp";
		 	document.forms[0].submit();
	 	}
	 }
	 if(cattype=="OPS")
     {
     	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appURL+"action/mainnav.jsp";
		 	document.forms[0].submit();
	 	}
	}
}
function callOld()
{
	//document.forms[0].radSearch.disabled = false;
	//document.all.search.style.visibility="visible";
	//document.all.search.style.position="relative";
	
}

function onLoad()
{
   document.all.search.style.visibility="hidden";
   document.all.search.style.position="absolute";
   document.forms[0].hidNewappno.value =newappno_val;
}
function callOnload(val1,val2)
{
	var hidrenewFac = "Y";
	var varAppno = val1;
	var comappid = val2;
	var comapp_newid=document.forms[0].comapp_newid.value;
	
	document.all.result.src=appURL+"action/comloanhistory_result.jsp?hidBeanId=facilities&hidBeanGetMethod=getRenewedFacility&appno="+varAppno+"&comappid="+comappid+"&hidrenewFac="+hidrenewFac+"&com_newid="+comapp_newid;
		var title = "ApplicationSearch";;
}
function callOnloadnew()
{
	if(approvedApplDemoid=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		document.all.result.src=appURL+"action/blank.jsp";
		document.all.search.style.visibility="hidden";
		document.all.search.style.position="absolute";
		document.all.idinward.style.visibility="hidden";
		document.all.idinward.style.position="absolute";
		return;
	}
	var hidrenewFac = "Y";
	var comapp_newid=document.forms[0].comapp_newid.value;
	document.all.result.src=appURL+"action/comloanhistory_result.jsp?hidBeanId=facilities&hidBeanGetMethod=getRenewedFacility&hidrenewFac="+hidrenewFac+"&hidapplicantoldid="+appid+"&com_newid="+comapp_newid;
	//document.forms[0].cmdOK.disabled = false;
	//document.forms[0].cmdCancel.disabled = false;
	document.all.search.style.visibility="visible";
	document.all.search.style.position="relative";
	document.all.idinward.style.visibility="visible";
	document.all.idinward.style.position="relative";
}
function callrestructure()
{
	if(approvedApplDemoid=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		document.all.result.src=appURL+"action/blank.jsp";
		document.all.search.style.visibility="hidden";
		document.all.search.style.position="absolute";
		document.all.idinward.style.visibility="hidden";
		document.all.idinward.style.position="absolute";
		return;
	}
	var hidrenewFac = "S";
	var comapp_newid=document.forms[0].comapp_newid.value;
	document.all.result.src=appURL+"action/comloanhistory_result.jsp?hidBeanId=facilities&hidBeanGetMethod=getRenewedFacility&hidrenewFac="+hidrenewFac+"&hidapplicantoldid="+appid+"&com_newid="+comapp_newid;
	document.all.search.style.visibility="visible";
	document.all.search.style.position="relative";
	document.all.idinward.style.visibility="visible";
	document.all.idinward.style.position="relative";
}
function callPostSanc()
{
	if(approvedApplDemoid=="Y")
	{
		alert("Kindly click on modify in customer profile and update latest details before proceeding");
		document.all.result.src=appURL+"action/blank.jsp";
		document.all.search.style.visibility="hidden";
		document.all.search.style.position="absolute";
		document.all.idinward.style.visibility="hidden";
		document.all.idinward.style.position="absolute";
		return;
	}
	var hidrenewFac = "P";
	var comapp_newid=document.forms[0].comapp_newid.value;
	document.all.result.src=appURL+"action/comloanhistory_result.jsp?hidBeanId=facilities&hidBeanGetMethod=getRenewedFacility&hidrenewFac="+hidrenewFac+"&hidapplicantoldid="+appid+"&com_newid="+comapp_newid;
	document.all.search.style.visibility="hidden";
	document.all.search.style.position="absolute";
	document.all.idinward.style.visibility="hidden";
	document.all.idinward.style.position="absolute";
}

function callAppRenew()
{
	var varcomappid=document.forms[0].comapp_oldid.value;
	<%if(Helper.correctNull((String)hshValues.get("strhidType")).equalsIgnoreCase("P")){%>
		document.forms[0].hidBeanId.value="facilities";
		document.forms[0].action=appURL+"action/com_postsanc_parameters.jsp";
		document.forms[0].hidBeanGetMethod.value="getPostSanctiondata";
		document.forms[0].submit();
	<%}else{%>
	if(document.forms[0].hidNewappno.value!="")
	{	
		document.forms[0].method="post";
		document.forms[0].hidStatus.value="copy";
		document.forms[0].hidAction.value="insert";
		varcomappid=document.forms[0].comapp_id.value;
		if(varcomappid=="")
		{
			varcomappid=document.forms[0].comapp_oldid.value;
		}
		if(document.forms[0].hidCategoryType.value=="OPS")
		{
			
			document.forms[0].action=appURL+"action/ops_facilities.jsp?hidBeanGetMethod=getOPSFacilityData&hidBeanId=facilities";
		}
		else
		{
			document.forms[0].action=appURL+"action/facilities.jsp?hidBeanGetMethod=getFacilityData&hidBeanId=facilities&valuesin=L&varComId="+varcomappid;
		}
		document.forms[0].submit();
	}
	<%}%>
}
function callApplicationSearch()
{		
	var varproposaltype="";
		var varproposeal="",varcategory="";
		if(varstrSessionModuleType=="CORP")
		{
			
			varproposeal="C";
			varcategory="c";
		}
		else
		{
			
			varproposeal="A";
			varcategory="a";
		}
		var comapp_newid=document.forms[0].comapp_newid.value;
		var varQryString = appURL+"action/searchAppinwradno.jsp?hidBeanId=inwardRegister&hidBeanGetMethod=getInwardnoSearchList&Category="+varcategory+"&proposal="+varproposaltype+"&CBSid="+cbsid+"&reqpagefrom=CA";
		var title = "Acknowledgement";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);

	
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onload="onLoad();callAppRenew();">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
        <tr>
          <td class="page_flow">
            Home -&gt; <%if(strCategoryType.equalsIgnoreCase("OPS")){out.println("Tertiary (New)");}
            else if(strCategoryType.equalsIgnoreCase("CORP")){out.println("Corporate & SME (New)");}
            else{
            	out.println("Agriculture(New)");
            }
            	%></td>
        </tr>
      </table>		
      </td>
    </tr>
 </table>
<form name="loanHistory" method="post" class="normal">
 <div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
      <tr> 
        <td valign="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr> 
                    <td valign="top"> 
                      <table width="80%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                        <tr> 
                          <td width="20%">&nbsp;</td>
                          <td width="3%">&nbsp;</td>
                          <td width="15%">&nbsp;</td>
                          <td width="3%">&nbsp;</td>
                          <td width="12%">&nbsp;</td>
                          <td width="3%">&nbsp;</td>
                          <td width="21%">&nbsp;</td>
                          <td width="3%">&nbsp;</td>
                          <td width="20%">&nbsp;</td>
                        </tr>
                        <tr> 
                          <td style="text-align: center;"><b>Whether proposal applied for ?</b> </td>
                          <td align="center"> <input type="radio" name="radLoan" value="N" style="border-style:none" onClick="callNew()"> </td>
                          <td>Fresh</td>
                          <td align="center"> <input type="radio" name="radLoan" value="Y" style="border-style:none" onClick="callOnloadnew()"> </td>
                          <td>Renew</td>
                          <!--<td width="3%" align="center"> <input type="radio" name="radLoan" value="N" style="border-style:none" onClick="callNew()"> </td>
                          <td width="17%" nowrap>100% Cash Margin &nbsp;&nbsp;</td> -->
                          
                          <td align="center"> <input type="radio" name="radLoan" value="N" style="border-style:none" onClick="callrestructure()"> </td>
                          <td nowrap>Re-Structuring / Rephasement</td>
                          <td align="center"> <input type="radio" name="radLoan" value="N" style="border-style:none" onClick="callPostSanc()"> </td>
                          <td nowrap>Post Sanction Modification</td>
                        </tr>
                      </table>
                      <div align="center"><br>
                        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                          <tr> 
                            <td width="50%" valign="top"> 
                              <table width="90%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
                                <tr> 
                                  <td valign="top"> 
                                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                      <tr> 
                                        <td width="45%" valign="top"> 
                                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                            <tr  class="dataheader"> 
                                              <td colspan="3">&nbsp;<b>Search By</b> </td>
                                            </tr>
                                            <tr id="idinward" style="visibility: hidden;position: absolute;"> 
                                              <td width="8%" style="visibility: hidden;"> 
                                                <input type="radio" name="radSearch" value="A" style="border-style:none" disabled="disabled" onClick="enableText()">
                                                </td>
                                              <td width="41%">Inward  
                                                No.</td>
												<td> 
												<input type="hidden" name="txt_receivedRH">
                                                <input type="text" name="txt_appinwardno" size="35" readOnly="readonly" onKeyPress="notAllowSplChar()">
                                                <a href="#"
											onClick="callApplicationSearch()"
											style="cursor: hand" tabindex="8"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0" id="search"></a>
                                                <input type="hidden" name="radSearch1" value="P" style="border-style:none" disabled="disabled" onClick="enableText()">
                                              </td>
                                              
                                            </tr>
                                           <tr align="center"> 
                                              <td colspan="3"> 
                                                <input type="hidden" name="txtSearch1" size="35" disabled="disabled" onKeyPress="notAllowSplChar()">
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                      <tr style="visibility: hidden;position: absolute;"> 
                                        <td width="50%" align="right"> 
                                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                            <tr> 
                                              <td colspan="4"><b>Check 
                                                the details you want to retain</b></td>
                                            </tr>
                                            <tr> 
                                              <td width="5%"> 
                                                <input type="checkbox" name="chkApp" value="Y" disabled="disabled" style="border-style:none" checked="checked">
                                              </td>
                                              <td width="45%"> 
                                                Facility Details</td>
                                              <td width="5%">  
                                                <input type="checkbox" name="chkColl" onClick="callMang()" disabled="disabled" style="border-style:none">
                                                </td>
                                              <td width="45%">Security  
                                                Details </td>
                                            </tr>
                                            <tr> 
                                              <td width="5%"> 
                                                <input type="checkbox" name="chkCoApp"  onClick="callGroup()" disabled="disabled" style="border-style:none">
                                              </td>
                                              <td width="45%">Promotor/ Guarantor 
                                                details</td>
                                              <td width="5%">  
                                                <input type="checkbox" name="chkFin"  onClick="callFin()" disabled="disabled" style="border-style:none">
                                                </td>
                                              <td width="45%">Financial 
                                                Details </td>
                                            </tr>
                                            <tr> 
                                              <td width="5%">&nbsp; </td>
                                              <td width="45%">&nbsp;</td>
                                              <td colspan="2"></td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                      <tr> 
		                                <td > 
		                                  <iframe id="result" src="" width="100%" height="240"></iframe> 
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
                      </div>
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
    <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3" class="outertable">
            <tr valign="top"> 
              
              <td align="center"> 
                  <input type="button" name="cmdClose" value="Close" class="buttonClose" onClick="callclose()">
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>

 <input type ="hidden" name ="appnval">
<input type ="hidden" name ="hidsearch">
<input type ="hidden" name ="hidSourceUrl">

<input type ="hidden" name ="strAppval">
<input type ="hidden" name ="strAppFlag">
<input type ="hidden" name ="strAppSecurity">
<input type ="hidden" name ="strAppGroupflag">
<input type ="hidden" name ="strchkApp">

<input type ="hidden" name ="hidprinDtls">
<input type ="hidden" name ="hidcollDtls">
<input type ="hidden" name ="hidfinDtls">

<input type="hidden"  name="hidBeanMethod">
<input type="hidden" name="hidBeanId" value="facilities">
<input type="hidden"  name="hidBeanGetMethod">

<input type ="hidden" name ="appno" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
<input type ="hidden" name ="hidAction">
<input type ="hidden" name ="hidStatus">

<input type="hidden" name="comapp_id"  value="<%=Helper.correctNull((String)request.getParameter("comapp_id"))%>">
<input type="hidden" name="comapp_oldid"  value="<%=Helper.correctNull((String)request.getParameter("comapp_oldid"))%>">
<input type="hidden" name="comapp_compname" value="<%=Helper.correctNull((String)request.getParameter("comapp_compname"))%>">
<input type="hidden" name="comapp_compid" value="<%=Helper.correctNull((String)request.getParameter("comapp_compid"))%>" >
<input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>"> 
<input type="hidden" name="hidPropType" value="C"> 
<input type="hidden" name="hidComappid">
<input type="hidden" name="hidFacsno">
<input type="hidden" name="hidType">
<input type="hidden" name="hidNewappno" value="">
<input type="hidden" name="hidApplicationno" value="">
<input type="hidden" name="comapp_newid" value="<%=Helper.correctNull((String)request.getParameter("comapp_newid"))%>">
</form>
</body>
</html>
