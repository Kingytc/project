<%@include file="../share/directives.jsp"%>

<%
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
String strPagefrom = Helper.correctNull((String) request.getParameter("pagefrom"));	
String pageid = Helper.correctNull((String) request.getParameter("pageid"));

String strSEC_TITLE = Helper.correctNull((String) hshValues.get("SEC_APP_TITLE"));
String strtot_number = Helper.correctNull((String) hshValues.get("auto_count"));

%>
<html>
<head>
<title>Live - Stock Security Details</title>
<SCRIPT LANGUAGE="JavaScript">

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var tot_number="<%=strtot_number%>";
var sec_title="<%=strSEC_TITLE%>";
var varVerificationFlag="<%=Helper.correctNull((String)hshValues.get("hid_VerificationFlag"))%>";


function showCitySearch1(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value=="")
		{
		var varDemoflag="livestock";
		var varQryString = appURL+"action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2+"&vardemo="+varDemoflag;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}
}

function showDistSearch(val)
{  

	var varstate = document.forms[0].hidstate.value;
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value=="")
	{
	if(document.forms[0].hidstate.value=="")
	{
		alert("Please Reselect the City");
		document.forms[0].txt_addr_city.focus();
		return;
	}
	if(document.forms[0].txt_addr_city.value=="")
	{
		ShowAlert(112,"City");
		document.forms[0].txt_addr_city.focus();
		return;
	}	
	else		
	{
    var varQryString = appURL+"action/searchDistrict.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getDistrictSearch&statecode="+varstate+"&code="+val;
	var title = "District";
	var prop = 'scrollbars=yes,menubar=yes,status=yes,width=750,height=520';	
	prop = prop + ",left=200,top=200";
	window.open(varQryString,title,prop);
	}
	}	
	
}


function doEdit()
{
	callDisableControls(true,false,false,false,false);
	disablefields(false);
	document.forms[0].txt_addr_city.readOnly=true;
	document.forms[0].txt_addr_district.readOnly=true;
	document.forms[0].txt_addr_state.readOnly=true;
	document.forms[0].txt_applcountry.readOnly=true;
	document.forms[0].txt_cbscustid.readOnly=true;
	if(document.forms[0].txt_cbscustid.value!=""){
		document.forms[0].sel_applt_title.disabled=true;
		document.forms[0].txt_applName.readOnly=true;
		document.forms[0].txt_applAddress1.readOnly=true;
		document.forms[0].txt_applAddress2.readOnly=true;
		}
}

function callDisableControls(cmdEdit,cmdSave,cmdCancel,cmdDelete,cmdClose)
{
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdclose.disabled=cmdClose;
}

function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].disabled=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].disabled=bool;		  
		}		
		
	}
	document.all.idsearch.disabled=bool;
}

function doSave()
{
	document.forms[0].hidsalutation.value=document.forms[0].sel_applt_title.value;
	var confirm_flag;
	if (document.forms[0].txt_totnumber.value == "0" || document.forms[0].txt_totnumber.value=="") 
	{
		ShowAlert('121', "Total Number");
		document.forms[0].txt_totnumber.focus();
		return;
	}
	
	if (document.forms[0].sel_applt_title.value == "")
	{
		ShowAlert('111', "Name of Title");
		document.forms[0].sel_applt_title.focus();
		return;
	}
	if (document.forms[0].txt_applName.value == "")
	{
		ShowAlert('121', "Name");
		document.forms[0].txt_applName.focus();
		return;
	}
	if (document.forms[0].txt_applsurveyno.value == "")
	{
		ShowAlert('121', "Survey No.");
		document.forms[0].txt_applsurveyno.focus();
		return;
	}
	if (document.forms[0].txt_applAddress1.value == "")
	{
		ShowAlert('121', "Address of the applicant");
		document.forms[0].txt_applAddress1.focus();
		return;
	}
	if (document.forms[0].txt_applAddress2.value == "")
	{
		ShowAlert('121', "Address of the applicant");
		document.forms[0].txt_applAddress2.focus();
		return;
	}
	if (document.forms[0].txt_addr_city.value == "")
	{
		ShowAlert('111', "City ");
		document.forms[0].txt_addr_city.focus();
		return;
	}
	if (document.forms[0].txt_addr_district.value == "")
	{
		ShowAlert('111', "District ");
		document.forms[0].txt_addr_district.focus();
		return;
	}
	if (document.forms[0].txt_addr_state.value == "")
	{
		ShowAlert('111', "State ");
		document.forms[0].txt_addr_state.focus();
		return;
	}
	if (document.forms[0].txt_applpincode.value == "")
	{
		ShowAlert('121', "Pin Code ");
		document.forms[0].txt_applpincode.focus();
		return;
	}
	if (document.forms[0].txt_applcountry.value == "")
	{
		ShowAlert('111', "Country ");
		document.forms[0].txt_applcountry.focus();
		return;
	}
	
	var s1=document.forms[0].old_txt_totnumber.value;
	if(s1!=document.forms[0].txt_totnumber.value && tot_number!="0")
	{
		var a=confirm("Details of "+tot_number+" Particulars were already added. If Total No. changes Particulars record will be deleted");
		
		if(a==true)
		{
			confirm_flag=true;
		}
		else
		{
			confirm_flag=false;
		}	
	}
	else
	{
		confirm_flag=true;
	}
		if(confirm_flag==true)
		{
			modifyCheck();
			document.forms[0].hidAction.value="insert";
			document.forms[0].hidBeanId.value="securitymaster";
			document.forms[0].hidBeanMethod.value="updateLiveStock";
			document.forms[0].hidBeanGetMethod.value="getLiveStock";
			document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock.jsp";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].submit();	
		}
}


function doDelete()
{		
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	document.forms[0].hidAction.value="delete"; 
	document.forms[0].hidBeanId.value="securitymaster";
	document.forms[0].hidBeanMethod.value="updateLiveStock";
	document.forms[0].hidBeanGetMethod.value="getLiveStock";
	document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
	}
} 

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanGetMethod.value="getLiveStock";
		document.forms[0].hidBeanId.value="getLiveStock";
		document.forms[0].hidSourceUrl.value="/action/securitiesLiveStock.jsp";
		document.forms[0].submit();
	}
}

function doClose()
{
	var varconfirm=ConfirmMsg('100');
	if(varconfirm)
	{
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
		document.forms[0].submit();
	}
}

function onload()
{
	if(varVerificationFlag=="V")
	{
		document.forms[0].cmdedit.disabled=true;
	}
	
	if(sec_title!="")
	{
		document.forms[0].sel_applt_title.value= sec_title;
		document.forms[0].old_sel_applt_titleTxt.value=document.forms[0].sel_applt_title.options[document.forms[0].sel_applt_title.selectedIndex].text;
		
	}else
	{
		document.forms[0].sel_applt_title.value= "";
		document.forms[0].old_sel_applt_titleTxt.value="";
	}
	
	disablefields(true);
}

function disableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdedit.disabled = bool1;
	document.forms[0].cmdsave.disabled = bool2;
	document.forms[0].cmdcancel.disabled = bool3;
	document.forms[0].cmddelete.disabled = bool4;
	document.forms[0].cmdclose.disabled = bool5;
}
function callCntrySearch(varTextControl,varHidControl)
{	
	if(document.forms[0].cmdsave.disabled==false && document.forms[0].txt_cbscustid.value=="")
	{
		var varQryString = appURL+"action/searchCountry.jsp?hidBeanId=mastapplicant&hidBeanGetMethod=getAddressDetail"+"&hidcntrycontrol="+varTextControl+"&hidcntrycodecontrol="+varHidControl;
		var title = "Country";
		var prop = "scrollbars=no,width=750,height=500";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	}
}	


function modifyCheck()
{
	var temp="";
	var tempname="";

	document.forms[0].sel_applt_titleTxt.value=document.forms[0].sel_applt_title.options[document.forms[0].sel_applt_title.selectedIndex].text;
	
	if(document.forms[0].txt_totnumber.value!=document.forms[0].old_txt_totnumber.value)
	{
		temp=temp+"old_txt_totnumber"+"@"; 		tempname=tempname+"Total Number "+"@";
	}
	if(document.forms[0].sel_applt_titleTxt.value!=document.forms[0].old_sel_applt_titleTxt.value)
	{
		temp=temp+"old_sel_applt_titleTxt"+"@"; 		tempname=tempname+"Title "+"@";
	}
	if(document.forms[0].txt_applName.value!=document.forms[0].old_txt_applName.value)
	{
		temp=temp+"old_txt_applName"+"@"; 		tempname=tempname+"Name "+"@";
	}
	if(document.forms[0].txt_applsurveyno.value!=document.forms[0].old_txt_applsurveyno.value)
	{
		temp=temp+"old_txt_applsurveyno"+"@"; 		tempname=tempname+"Survey no "+"@";
	}
	if(document.forms[0].txt_applAddress1.value!=document.forms[0].old_txt_applAddress1.value)
	{
		temp=temp+"old_txt_applAddress1"+"@"; 		tempname=tempname+"Address line 1 "+"@";
	}
	if(document.forms[0].txt_applAddress2.value!=document.forms[0].old_txt_applAddress2.value)
	{
		temp=temp+"old_txt_applAddress2"+"@"; 		tempname=tempname+"Address line 2 "+"@";
	}
	if(document.forms[0].txt_addr_city.value!=document.forms[0].old_txt_addr_city.value)
	{
		temp=temp+"old_txt_addr_city"+"@"; 		tempname=tempname+"City "+"@";
	}
	if(document.forms[0].txt_addr_district.value!=document.forms[0].old_txt_addr_district.value)
	{
		temp=temp+"old_txt_addr_district"+"@"; 		tempname=tempname+"District "+"@";
	}
	if(document.forms[0].txt_addr_state.value!=document.forms[0].old_txt_addr_state.value)
	{
		temp=temp+"old_txt_addr_state"+"@"; 		tempname=tempname+"State "+"@";
	}

	if(document.forms[0].txt_applcountry.value!=document.forms[0].old_txt_applcountry.value)
	{
		temp=temp+"old_txt_applcountry"+"@"; 		tempname=tempname+"Country "+"@";
	}
	if(document.forms[0].txt_applpincode.value!=document.forms[0].old_txt_applpincode.value)
	{
		temp=temp+"old_txt_applpincode"+"@"; 		tempname=tempname+"PinCode "+"@";
	}
	
	document.forms[0].hidmodifiedvalue.value = temp;
	document.forms[0].hidmodifiedField.value = tempname;
	
}
function callDescCBS()
{	
	var varQryString = appURL+"action/CBSIDhelp.jsp?&pagename=sec_livestock";
	var title = "SelectCBSID";
	var prop = "scrollbars=yes,menubar=yes,status=yes,width=500,height=400";
	prop = prop + ",left=50,top=150";
    window.open(varQryString,title,prop);	
}
</SCRIPT>
</head>
<body onload="onload()">
<form method="post" class="normal">
<%if(strPagefrom.equalsIgnoreCase("appl")){ 
if(!(strSessionModuleType.equalsIgnoreCase("RET"))){
if(Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){ %>
	 <table width="100%" border="0" cellspacing="0" cellpadding="0"
		class="outertable">
		<tr>
			<td><jsp:include page="../com/postsanctionlinks.jsp" flush="true">
				<jsp:param name="pageid" value="33" />
				<jsp:param name="subpageid" value="209" />
				<jsp:param name="cattype" value="<%=strCategoryType%>" />
				<jsp:param name="ssitype" value="<%=strSSIType%>" />
			</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
			</td>
		</tr>
	</table>
	<%}else{%>
 <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="33" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Corporate &amp; SME -&gt; Application -&gt; Security Master -&gt; Live - Stock Details</td>
	</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../set/appurlsectabs.jsp" flush="true">
			<jsp:param name="pageid" value="19" />
		</jsp:include>
		</td>
	</tr>
</table>
<%}else if(strSessionModuleType.equalsIgnoreCase("RET")){
if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
<jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
<jsp:param name="pageid" value="<%=pageid%>" />
</jsp:include>
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
<tr>
<td class="page_flow" colspan="2">Home -&gt; Retail -&gt; Application -&gt; Security Master -&gt; Live - Stock Details</td>
</tr>
</table>
<span style="display: none"><lapschoice:borrowertype /></span> <lapschoice:application />
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="4" />
			<jsp:param name="subpageid" value="209" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
<td valign="top">
<jsp:include page="../set/appurlsectabs.jsp" flush="true">
	<jsp:param name="pageid" value="19" />
</jsp:include>
</td>
</tr>
</table>
<%
}}else if(strPagefrom.equals("secmailbox")) { %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr>
	<td valign="top">
	<jsp:include page="../set/appurlsectabs.jsp" flush="true">
		<jsp:param name="pageid" value="19" />
	</jsp:include>
	</td>
</tr>
</table>		
<%}else{%>
<table width="98%" border="0" cellspacing="1" cellpadding="3"	class="outertable" align="center">
	<tr class="dataheader">
		<td align="left" width="10%"><b>Customer Name</b></td>
		<td align="left" width="30%"><b><%=Helper.correctNull((String)hshValues.get("perapp_fname"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer CBSID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_cbsid"))%>&nbsp;</b></td>
		<td align="left" width="10%"><b>Customer LAPS ID</b></td>
		<td align="left" width="20%"><b><%=Helper.correctNull((String)hshValues.get("perapp_oldid"))%>&nbsp;</b></td>
	</tr>
</table> 
<table width="98%" border="0" cellspacing="1" cellpadding="3" class="outertable" align="center">
	<tr>
		<td class="page_flow">Home -&gt; Securities -&gt; Live - Stock Details</td>
	</tr>
</table>
<table width="60%" border="0" cellspacing="1" cellpadding="0" class="outertable">
	<tr>
		<td class="sub_tab_inactive_new" align="center">
			<b><a href="JavaScript:gototab('securitymaster','getSecurities','customer_securities.jsp')">Security Details</a></b>
		</td>
		<td class="sub_tab_active_new" align="center" ><b>Live Stock Details</b></td>
		<td class="sub_tab_inactive_new" align="center" >
			<b><a href="JavaScript:gototab('securitymaster','getLiveStockDet','securitiesLiveStock_det.jsp')">Details of Particulars</a></b>
		</td>
		
	</tr>
</table>
<%} %>
<table width="98%" align="center" cellspacing="0" cellpadding="0" border="1" class="outertable">
    <tr> 
      <td> 
        <table width="100%" cellspacing="0" cellpadding="5" align="center" class="outertable">
          <tr>
				<td colspan="2"> Security ID :  <span style="color:#750b6a"> <%=Helper.correctNull((String)hshValues.get("SEC_SECURITYID"))%> </span>  </td>	
		</tr>
          <tr> 
	           	<td width="30%">Total Number <span class="mantatory">*</span></td>
	            <td width="70%"><input type="text" name="txt_totnumber" maxlength="3" size="20" onkeypress="allowInteger()" 
	            	value="<%=Helper.correctNull((String) hshValues.get("SEC_TOTNUMBER"))%>">
	            </td>
	            
        	</tr>
        	
        	<tr>
        		<td colspan="2" class="dataheader" >Location Details </td>
        	</tr>
        		<tr>
					<td width="13%" >CBS Cust ID</td>
				<td id="idsearch" width="34%"><input type="text"
					name="txt_cbscustid" size="12" maxlength="10" onBlur="readOnly" 
					value="<%=Helper.correctNull((String)hshValues.get("SEC_APP_CBSID"))%>">
				<b><span onClick="javascript:callDescCBS()" style="cursor: hand" ><img
					src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
					border="0"></span></b></td>
					</tr>
        	<tr>
        		<td width="30%">Name<span class="mantatory">*</span></td>
				<td valign="top" width="70%">
						<select name="sel_applt_title" style="width:15%">
						<option value="">---Select-----</option>
						<%
							String apptypecon = "1";
						%>
						<lapschoice:CBSStaticDataNewTag apptype='<%=apptypecon%>' />
						</select>&nbsp;&nbsp; 
						<input type="text" name="txt_applName" SIZE="25" maxlength="20" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_NAME"))%>">
				</td>
        	</tr>
        	
        	<tr>
        		<td width="30%">Survey No.<span class="mantatory">*</span></td>
				<td width="70%"><input type="text" name="txt_applsurveyno" SIZE="25"  maxlength="15"
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_SURVEYNO"))%>">
				</td>
        	</tr>
        	<tr>
        		<td width="30%">Address of the applicant <span class="mantatory">*</span></td>
				<td width="70%"><input type="text" name="txt_applAddress1" SIZE="25"  maxlength="50"
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_ADDR1"))%>">
				</td>
			</tr>
			<tr>
					<td width="30%">&nbsp;</td>
					<td width="70%"><input type="text" name="txt_applAddress2" SIZE="25" maxlength="50"
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_ADDR2"))%>">
					</td>
			</tr>
			<tr>
				<td width="30%">City <span class="mantatory">*</span></td>
            	<td width="70%"><input type="text" name="txt_addr_city" maxlength="20" size="45" 
					value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_CITYNAME"))%>">
					<a onClick="showCitySearch1('txt_addr_city','txt_addr_state','hidcity','hidstate','','');"
					style="cursor:hand" tabindex="22"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a>
			 		<input type="hidden" name="hidcity" size="5" value="<%=Helper.correctNull((String)hshValues.get("SEC_APP_CITYCODE"))%>">				
				</td>
			</tr>
			
			<tr> 
	            <td width="30%">District <span class="mantatory">*</span></td>
	            <td width="70%">
	              <input type="text" name="txt_addr_district" maxlength="20" size="45" 
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_DISTRICTNAME"))%>">
						<a onClick="showDistSearch('livestock');" style="cursor:hand" tabindex="22">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" tabindex="21"></a> 
				<input type="hidden" name="hid_dist" size="5" value="<%=Helper.correctNull((String)hshValues.get("SEC_APP_DISTRICTCODE"))%>">				
	            </td>
            </tr>
            <tr>
	            <td width="30%">State <span class="mantatory">*</span></td>
	            <td width="70%">
	              <input type="text" name="txt_addr_state" maxlength="20" size="20" 
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_STATENAME"))%>">
				<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_STATECODE"))%>" />
	            </td>
          </tr>
          
         
        	
        	<tr>
        		<td width="30%">Country<span class="mantatory">*</span></td>
				<td width="70%"><input type="text" name="txt_applcountry" size="25" maxlength="15" tabindex="24" style="text-align:left"
													value="<%=Helper.correctNull((String)hshValues.get("SEC_APP_COUNTRY"))%>">
													<input type="hidden" name="hid_applcountry" value="<%=Helper.correctNull((String)hshValues.get("SEC_APP_COUNTRYCODE"))%>">
													<a onClick="callCntrySearch('txt_applcountry','hid_applcountry')" style="cursor:hand" tabindex="8">
													<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
													border="0" tabindex="21"></a> 
				</td>
        	</tr>
        	
        	 <tr>
        		<td width="30%">Pin Code<span class="mantatory">*</span></td>
				<td width="70%"><input type="text" name="txt_applpincode" MAXLENGTH="6" SIZE="15" onkeypress="allowInteger()"
						value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_PINCODE"))%>">
				</td>
        	</tr>
          
        </table>
       </td>
      </tr>
   </table>   
     <br/>   	

<lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />

<br>
<lapschoice:hiddentag pageid='<%=pageid%>' />

<input type="hidden" name="txtperapp_appid"
			value="<%=Helper.correctNull((String) hshValues.get("applicantId"))%>">
		<input type="hidden" name="hidDemoId"
			value="<%=Helper.correctNull((String) request.getParameter("hidDemoId"))%>">
		<input type="hidden" name="hidSecurityId"
			value="<%=Helper.correctNull((String)request.getParameter("hidSecurityId"))%>">
			
<input type="hidden" name="hid_VerificationFlag" value="<%=Helper.correctNull((String) hshValues.get("hid_VerificationFlag"))%>" />
			
<input type="hidden" name="hidmodifiedvalue">  
<input type="hidden" name="hidmodifiedField">

<input type="hidden" name="old_txt_totnumber" value="<%=Helper.correctNull((String) hshValues.get("SEC_TOTNUMBER"))%>">
<input type="hidden" name="old_sel_applt_titleTxt" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_TITLE"))%>">
<input type="hidden" name="old_txt_applName" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_NAME"))%>">

<input type="hidden" name="old_txt_applsurveyno" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_SURVEYNO"))%>">
<input type="hidden" name="old_txt_applAddress1" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_ADDR1"))%>">
<input type="hidden" name="old_txt_applAddress2" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_ADDR2"))%>">

<input type="hidden" name="old_txt_addr_city" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_CITYNAME"))%>">
<input type="hidden" name="old_txt_addr_district" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_DISTRICTNAME"))%>">
<input type="hidden" name="old_txt_addr_state" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_STATENAME"))%>">

<input type="hidden" name="old_txt_applcountry" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_COUNTRY"))%>">
<input type="hidden" name="old_txt_applpincode" value="<%=Helper.correctNull((String) hshValues.get("SEC_APP_PINCODE"))%>">
<input type="hidden" name="hidsalutation">
<input type="hidden" name="sel_applt_titleTxt">

</form>
</body>
</html>


