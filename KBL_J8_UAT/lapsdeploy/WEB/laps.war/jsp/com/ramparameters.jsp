<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<html>
<head>
<title>IRB Parameters</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var varCompSectorCode="<%=Helper.correctNull((String)hshValues.get("companysectorcode"))%>";
var varCountryCode="<%=Helper.correctNull((String)hshValues.get("companycountrycode"))%>";
var varMarketSegment="<%=Helper.correctNull((String)hshValues.get("marketsegment"))%>";
var varRBIIndustrycode="<%=Helper.correctNull((String)hshValues.get("rbiindustrycode"))%>";
var varAssetclassification="<%=Helper.correctNull((String)hshValues.get("standardhost"))%>";
var varIsMarketParticipant="<%=Helper.correctNull((String)hshValues.get("ismarketparticipant"))%>";
var varIsCommercialBank="<%=Helper.correctNull((String)hshValues.get("iscommercialbank"))%>";
var varIsPSENotified="<%=Helper.correctNull((String)hshValues.get("ispsenotified"))%>";
var varIsCentralSovereign="<%=Helper.correctNull((String)hshValues.get("iscentralsoverign"))%>";
var varSendFlag="<%=Helper.correctNull((String)hshValues.get("flag"))%>";
var varRamFlag="<%=Helper.correctNull((String)hshValues.get("Sendflag"))%>";
var varException_flag="<%=Helper.correctNull((String)hshValues.get("Exception_flag"))%>";

function Onloading()
{
	if(varCompSectorCode!="")		
	{
		document.frmramparam.sel_sector.value=varCompSectorCode;
	}
	else
	{
		document.frmramparam.sel_sector.value="0";
	}
	if(varCountryCode!="")
	{
		document.frmramparam.sel_country.value=varCountryCode;
	}
	else
	{
		document.frmramparam.sel_country.value="0";
	}
	if(varMarketSegment!="")
	{
		document.frmramparam.sel_segment.value=varMarketSegment;
	}
	else
	{
		document.frmramparam.sel_segment.value="0";
	}
	if(varRBIIndustrycode!="")
	{
		document.frmramparam.sel_rbiindustrycode.value=varRBIIndustrycode;
	}
	else
	{
		document.frmramparam.sel_rbiindustrycode.value="0";
	}
	if(varAssetclassification!="")
	{
		document.frmramparam.sel_asset.value=varAssetclassification;
	}
	else
	{
		document.frmramparam.sel_asset.value="0";
	}
	if(varIsMarketParticipant!="")
	{
		document.frmramparam.sel_core.value=varIsMarketParticipant;
	}
	else
	{
		document.frmramparam.sel_core.value=0;
	}
	if(varIsCommercialBank!="")
	{
		document.frmramparam.sel_comm.value=varIsCommercialBank;
	}
	else
	{
		document.frmramparam.sel_comm.value=0;
	}
	if(varIsPSENotified!="")
	{
		document.frmramparam.sel_pse.value=varIsPSENotified;
	}
	else
	{
		document.frmramparam.sel_pse.value=0;
	}
	if(varIsCentralSovereign!="")
	{
		document.frmramparam.sel_claim.value=varIsCentralSovereign;
	}
	else
	{
		document.frmramparam.sel_claim.value=0;
	}
	CheckCondition();
	document.frmramparam.hidsendflag.value=varSendFlag;
	if(varSendFlag=='Y' && varRamFlag=='sendtoram' && varException_flag=="false")
	{
		alert('Data Sent to IRB Sucessfully');
	}
	if(varException_flag=="true")	
	{
		alert("Network Connectivity Error Occured While Sending Rating Parameters to IRB !!");
	}
	disablefields(true);
	enablebuttons(false,true,false);
	}
function doClose()
{
	window.close();
}
function disablefields(bool)
	{
	for(var i=0;i<document.frmramparam.length;i++)
		{
		if(document.frmramparam.elements[i].type=='select-one')
			{
			document.frmramparam.elements[i].disabled=bool;
			}	
		}
	}

function enablebuttons(bedit,bsend,bclose)
	{
	document.frmramparam.cmdedit.disabled=bedit;
	document.frmramparam.cmdexport.disabled=bsend;
	document.frmramparam.cmdclose.disabled=bclose;
	}
function doEdit()
	{
	if(document.forms[0].readFlag.value.toUpperCase()=="W")
		{
			disablefields(false);
			enablebuttons(true,false,true);
		}
	}
function doExport()
 	{  
 	var varconfirm=true;	    
 	if(document.frmramparam.sel_sector.value=="0")
 		{
	 	ShowAlert('111',"Company Sector Code");
 		document.frmramparam.sel_sector.focus();
 		return;
	 	}
 	if(document.frmramparam.sel_country.value=="0")
 		{
	 	ShowAlert('111',"Country Code");
 		document.frmramparam.sel_country.focus();
 		return;
	 	}
 	if(document.frmramparam.sel_segment.value=="0")
 		{
	 	ShowAlert('111',"Market Segment");
 		document.frmramparam.sel_segment.focus();
 		return;
	 	}
 	if(document.frmramparam.sel_rbiindustrycode.value=="0")
 		{
	 	ShowAlert('111',"RBI Industry Code");
 		document.frmramparam.sel_rbiindustrycode.focus();
 		return;
	 	}
	if(document.frmramparam.sel_asset.value=="0")
 		{
	 	ShowAlert('111',"Asset Classification");
 		document.frmramparam.sel_asset.focus();
 		return;
	 	}	
		varconfirm=ConfirmMsg('157');		
	if(varconfirm)
		{
		if("<%=request.getParameter("type")%>"=="R")
			{
			document.frmramparam.hidBeanId.value="LapsToRam";		
			document.frmramparam.hidBeanMethod.value="retailCompanyMaster";
			document.frmramparam.hidBeanGetMethod.value="";
			document.frmramparam.hidSourceUrl.value="action/ramparameters.jsp";
			document.frmramparam.action=appUrl+"controllerservlet";
			document.frmramparam.submit();
			}
		else
			{
	  	    document.frmramparam.hidBeanId.value="LapsToRam";	
	  	    document.frmramparam.hidAction.value="sendtoram";		
			document.frmramparam.hidBeanGetMethod.value="companyMaster";			
			document.frmramparam.action=appUrl+"action/ramparameters.jsp?";
			document.frmramparam.submit();
			}
		}
 	} 
 function CheckCondition()
 {
 	var asset=document.frmramparam.sel_asset.value;
	if(asset==4)
 	{
		document.all.bank.style.visibility="visible";
		document.all.bank.style.position="relative";
		document.all.pse.style.visibility="hidden";
		document.all.pse.style.position="absolute";
		document.all.sover.style.visibility="hidden";
		document.all.sover.style.position="absolute";
 	}
 	else if(asset==2)
 	{
		document.all.bank.style.visibility="hidden";
		document.all.bank.style.position="absolute";
		document.all.pse.style.visibility="visible";
		document.all.pse.style.position="relative";
		document.all.sover.style.visibility="hidden";
		document.all.sover.style.position="absolute";
 	}
 	else if(asset==5)
 	{
		document.all.bank.style.visibility="hidden";
		document.all.bank.style.position="absolute";
		document.all.pse.style.visibility="hidden";
		document.all.pse.style.position="absolute";
		document.all.sover.style.visibility="visible";
		document.all.sover.style.position="relative";
 	}
	else
		{
		document.all.bank.style.visibility="hidden";
		document.all.bank.style.position="absolute";
		document.all.pse.style.visibility="hidden";
		document.all.pse.style.position="absolute";
		document.all.sover.style.visibility="hidden";
		document.all.sover.style.position="absolute";
		}
 } 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="Onloading();">
<form method="post" name="frmramparam" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow"><%if(Helper.correctNull((String)request.getParameter("type")).equalsIgnoreCase("OPS")) {%>
			Home -&gt; Tertiary -&gt; Customer Profile -&gt; Demographics -&gt; IRB Details
			<%} else {%>
			Home -&gt; Commercial(Applicant Master) -&gt; Customer Master Details -&gt; Company Details -&gt; IRB Details
			<%} %>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                            <tr class="dataheader"> 
                              <td colspan="4">
                                <b>IRB Parameters</b></td>
                            </tr>
                            <tr> 
                              <td   width="13%">
                                </td>
                              <td width="41%"  >Company 
                                Sector Code </td>
                              <td  width="27%"> 
                                <select name="sel_sector" tabindex="40">
                                  <option value="0" selected>----Select----</option>
                                  <lapschoice:RAMparameters type="sector"/> 
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td   width="13%">&nbsp;</td>
                              <td width="41%" >Country 
                                Code </td>
                              <td  width="27%"> 
                                <select name="sel_country" tabindex="40">
                                  <option value="0" selected>----Select----</option>
                                  <lapschoice:RAMparameters type="country"/> 
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td   width="13%">&nbsp; </td>
                              <td width="41%" >Market 
                                Segment  </td>
                              <td  width="27%"> 
                                <select name="sel_segment" tabindex="40">
                                  <option value="0" selected>----Select----</option>
                                  <lapschoice:RAMparameters type="segment"/> 
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td  width="13%">&nbsp;</td>
                              <td width="41%">RBI 
                                Industry Code</td>
                              <td  width="27%"> 
                                <select name="sel_rbiindustrycode" tabindex="40">
                                  <option value="0" selected>----Select----</option>
                                  <lapschoice:RAMparameters type="industry"/> 
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td  width="13%">&nbsp;</td>
                              <td width="41%" >Asset 
                                Classification  </td>
                              <td width="27%"> 
                                <select name="sel_asset" tabindex="40" onChange="CheckCondition()">
                                  <option value="0" selected>----Select----</option>
                                  <lapschoice:RAMparameters type="assetclass"/> 
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td  width="13%">&nbsp;</td>
                              <td width="41%">Is 
                                this entity a core market participant ? </td>
                              <td width="27%"> 
                                <select name="sel_core" tabindex="40">                                  
                                  <option value="1">Yes</option>
                                  <option value="0" selected>No</option>
                                </select>
                              </td>
                            </tr>
                            <tr id="bank">
                              <td  width="13%">&nbsp;</td>
                              <td width="41%">Is 
                                this a Commercial Bank ?</td>
                              <td width="27%"> 
                                <select name="sel_comm" tabindex="40">                                  
                                  <option value="1">Yes</option>
                                  <option value="0" selected>No</option>
                                </select>
                              </td>
                            </tr>
                            <tr id="pse"> 
                              <td  width="13%">&nbsp;</td>
                              <td width="41%">Is 
                                this PSE notified ?</td>
                              <td width="27%"> 
                                <select name="sel_pse" tabindex="40">                                  
                                  <option value="1">Yes</option>
                                  <option value="0" selected>No</option>
                                </select>
                              </td>
                            </tr>
                            <tr id="sover"> 
                              <td  width="13%">&nbsp;</td>
                              <td width="41%">Is 
                                the claim to central sovereign?</td>
                              <td width="27%"> 
                                <select name="sel_claim" tabindex="40">                                  
                                  <option value="1">Yes</option>
                                  <option value="0" selected>No</option>
                                </select>
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
 <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
  <tr> 
    <td> 
      <table width="0%" border="0" cellspacing="0" cellpadding="3">
        <tr valign="top"> 
			<td > 
            	<input type="button" name="cmdedit" value="Edit" class="buttonStyle" onClick="doEdit()">
			</td>
          <td > 
            <input type="button" name="cmdexport" value="Send Details To IRB" class="buttonOthers" style="width:130" onClick="doExport()">
          </td>
          <td > 
            <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
        </tr>
      </table>
    </td>
  </tr>
</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="comapp_id"  value="<%=Helper.correctNull((String)hshValues.get("comapp_id"))%>">
  <input type="hidden" name="comapp_companyid"  value="<%=Helper.correctNull((String)hshValues.get("comapp_companyid"))%>">
  <input type="hidden" name="hidsendflag">
  <input type="hidden" name="type" value="<%=Helper.correctNull((String)request.getParameter("type"))%>">
  <input type="hidden" name="comapp_appno"  value="<%=Helper.correctNull((String)hshValues.get("comapp_appno"))%>">
  <input type="hidden" name="readFlag" value="<%=Helper.correctNull((String)session.getAttribute("strGroupRights")).charAt(18)%>">
  
</form>
</body>
</html>

