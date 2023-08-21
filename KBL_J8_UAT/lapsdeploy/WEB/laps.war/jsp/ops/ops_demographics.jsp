<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
String var1=Helper.correctNull((String)hshValues.get("prinfullname"));
String proname = var1;
String promoterid=Helper.correctNull((String)hshValues.get("prinfullname"));
%>
<html>
<head>
<title>Details of Proprietor / Partners / Managing Partner / Promoters / Director 
/ Managing Director</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/ops/ops_demographics.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<script language="javascript" >
var prom_id="<%=promoterid%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var strvalue ="/jsp/comhlp/hlp_demograph.jsp";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var apptype="<%=Helper.correctNull((String)hshValues.get("strdemoapptype"))%>";
var hidval="<%=Helper.correctNull((String)hshValues.get("hidVal"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function doClose()
{
    if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
}

function pageonload()
{
	if(prom_id!="")
 	{
    	document.forms[0].prinfullname.value=prom_id;
     	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	    	document.forms[0].cmddelete.disabled=false;
		    document.forms[0].cmdcancel.disabled=false;
		}
 	}
 	else
 	{
 		document.forms[0].prinfullname.value="0";
 		document.forms[0].txt_din.value="";
	 	document.forms[0].cmddelete.disabled=true;
 		document.forms[0].cmdcancel.disabled=true;
	 }
	var str_type_temp =apptype.split("@");	
	for(var i=0;i<str_type_temp.length-1;i++)
	{
		var selValue=str_type_temp[i];
		if("P"==selValue)			
			document.forms[0].printype.options[0].selected=true;			
		else if("D"==selValue)			
			document.forms[0].printype.options[1].selected=true;
		else if("G"==selValue)			
			document.forms[0].printype.options[2].selected=true;			
		else if("O"==selValue)			
			document.forms[0].printype.options[3].selected=true;
		else if("C"==selValue)			
			document.forms[0].printype.options[4].selected=true;
		else if("MD"==selValue)			
			document.forms[0].printype.options[5].selected=true;
		else if("SP"==selValue)			
			document.forms[0].printype.options[6].selected=true;
		else if("SH"==selValue)			
			document.forms[0].printype.options[7].selected=true;	
		else if("CA"==selValue)			
			document.forms[0].printype.options[8].selected=true;
		else if("PT"==selValue)			
			document.forms[0].printype.options[9].selected=true;		
	}	
	if(hidval=="cancel")
	{
	 	document.forms[0].prinfullname.value="0";
	 	document.forms[0].txtloan_cname.value="";
	 	document.forms[0].printype.value="";
	 	document.forms[0].txt_din.value="";
	 	document.forms[0].cmddelete.disabled=true;
 		document.forms[0].cmdcancel.disabled=true;
	}
	if(hidval=="delete")
	{
	 	document.forms[0].prinfullname.value="0";
	 	document.forms[0].txtloan_cname.value="";
	 	document.forms[0].printype.value="";
	 	document.forms[0].txt_din.value="";
 		document.forms[0].cmddelete.disabled=true;
 		document.forms[0].cmdcancel.disabled=true;
	} 
	if(hidval=="add"){
		document.forms[0].prinfullname.value="0";
	 	document.forms[0].txtloan_cname.value="";
	 	document.forms[0].printype.value="";
	 	document.forms[0].txt_din.value="";
	 	document.forms[0].cmddelete.disabled=true;
 		
	}
	if(document.forms[0].prinfullname.value == '0'){
		
		document.forms[0].cmdsave.disabled=true;
	}else{
		document.forms[0].cmdsave.disabled=false;
	}
}
</script>
<body onload="pageonload()">
<form name="fininc" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="1" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td class="page_flow">Home -&gt; Tertiary -&gt;  Application -&gt; Details of Promoter/Guarantor</td>
 </tr>
        </table>
      </td>
    </tr>
  </table>
    <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
			<tr>
				<td>
				<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
					<tr align="center">
						<td class="sub_tab_inactive"><b> <a
							href="javascript:gotoTab(appURL,'facilities','getOPSFacilityData','ops_facilities.jsp')">Facilities</a>
						</b></td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'comssiaboveten','getDataSubsidy','ops_subsidy.jsp')">Subsidy</a></b>
						</td>
						<td class="sub_tab_inactive"><b><a
							href="javascript:gotoTab(appURL,'comssiaboveten','getAccountDetails','ops_accountdetails.jsp')">Account
						Details</a></b></td>
						<td class="sub_tab_inactive">
							<b><a href="javascript:gotoTab(appURL,'compro','getCapitalStructure','com_capitalstructure.jsp')">Capital Structure</a></b>
						</td>
						<td class="sub_tab_active"><b>Details of Promoter/Guarantor</b>
						</td>						
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
   <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <table width="65%" border="1" align="center" cellspacing="0" cellpadding="3" class="outertable">
                <tr align="center"> 
                  <td colspan="2"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
						<tr> 
                        <td width="41%">Name of Proprietor / Partner / Director</td>
                        <td width="59%"> 
                            <select name="prinfullname" onChange="javascript:displayData()">
                                  <option selected="selected" value ='0'>----Select----</option>
                                  <option value ='new'>New</option>
                                  <lapschoice:tertiarypromoter apptype="N"/> 
                                </select>
                        </td>
                      </tr>					
                      <tr> 
                        <td width="41%"> 
                          <div>Select 
                            Proprietor / Partner / Director Type</div>
                        </td>
                        <td width="59%"> 
                             <select name="printype" Multiple size="9">
                                <option value="P">Promoters / Founders</option>
								<option value="D">Directors</option>
								<option value="G">Guarantor</option>
								<option value="O">Share Holders</option>
								<option value="C">Chairman</option>
								<option value="MD">Managing Director</option>
								<option value="SP">Sole Proprietor</option>
								<option value="SH">SHG Member</option>
								<option value="CA">Co-Applicant</option>
								<option value="PT">PARTNERS</option>
                                </select>
                               <input type="hidden" name="hidprintype" value="">
                         </td>
                       </tr>                      
                      <tr> 
                        <td width="41%"> 
                          <div>Name of the Person</div>
                        </td>
                        <td width="59%"> 
                          <div> 
                            <table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                              <tr> 
                                <td > 
                                  <input type="text" name="txtloan_cname" value="<%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>" size="50" readonly>
                                </td>
                                <td><span onClick="javascript:callCoAppIDHelp()" style="cursor:hand" ><b><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0" tabindex="2"></b></span></td>
                                </tr>
                                 
                            </table>
                          </div>
                        </td>
                      </tr>
                      <tr> 
                        <td width="41%"> 
                          <div align="left"> Director Identification Number(DIN)</div>
                        </td>
                        <td><input name="txt_din" type="text"
									size="11" maxlength="10" tabindex="17"
									value="<%=Helper.correctNull((String)hshValues.get("perapp_din"))%>"></td>
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
           <lapschoice:combuttonnew btnnames='Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
           <br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidCoDemoId" value = <%=Helper.correctNull((String)hshValues.get("prinfullname")) %> >
<input type="hidden" name="hidVal">
<input type="hidden" name="hidTotalDesc" value="4">
<input type="hidden" name="otherGetMethod" value="">
<input type="hidden" name="frompage" value="P">
<input type="hidden" name="pname" value="P">
<input type="hidden" name="proname" value ="<%=proname%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<INPUT TYPE="hidden" name="hidCreditIDCheck" value="<%=Helper.correctNull((String)hshValues.get("creditAppidCheck"))%>">

</form>
</body>
</html>

