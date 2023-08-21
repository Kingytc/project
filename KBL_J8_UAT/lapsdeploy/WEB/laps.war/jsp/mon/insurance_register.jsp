<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%ArrayList vecRow= new ArrayList();
ArrayList vecCol= new ArrayList();
vecRow =(ArrayList)hshValues.get("vecRow");
String straccno = Helper.correctNull((String)hshValues.get("Accno"));
String strcbsid = Helper.correctNull((String)hshValues.get("strcbsid"));
int intVecRowSize = vecRow.size();
%>
<html>
<head>
<title>Insurance Register</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varOrgLev = "<%=strOrgLevel%>";
function placevalues()
{
	disableCommandButtons(false,false,true,true,true,false,true);
}
function showCitySearch(varTextControl,varTextControl1,varHidControl,varHidControl1,varTextControl2,varHidControl2)
{
	if(document.forms[0].cmdsave.disabled==false)
		{
		var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCity.jsp?hidcitycontrol="+varTextControl+"&hidstatecontrol="+varTextControl1+"&hidcitycodecontrol="+varHidControl+"&hidstatecodecontrol="+varHidControl1+"&hidzipcontrol="+varTextControl2+"&hidzipvaildatorcontrol="+varHidControl2;
		var title = "City";
		var prop = "scrollbars=yes,width=650,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
		}	
}
function showSecurity()
{
	if(document.forms[0].cmdsave.disabled=true)
	{		
		var cbsaccno="<%=request.getParameter("cbsaccno")%>";
		var	varQryString = appUrl+"action/mon_securitysearch.jsp?cbsaccno="+cbsaccno;
		var title = "ApplicantIDHelp";
		var prop = "scrollbars=no,width=500,height=400";	
		var xpos = (screen.width - 450) / 2;
		var ypos = (screen.height - 400) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(varQryString,title,prop);
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/mainnav.jsp";
		document.forms[0].submit();
	}			
}
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function selectValues(id,cbsid,security,company,policyno,clause,cvramt,premium,paidby,benefit,duedate,risk,details,covernote,policydate,expirydate,riskfactor,risk1,addr3,city,state,pincode,cbsaccno,val)
{
	document.forms[0].hidSeqid.value=document.getElementById("hid_Seqid"+val).value;
	document.forms[0].cbsid.value=cbsid;
	document.forms[0].insreg_compname.value=company;
	document.forms[0].insreg_beneficial.value=benefit;
	document.forms[0].insreg_coverno.value=covernote;
	document.forms[0].insreg_policyno.value=document.getElementById("hidpolicyno"+val).value;
	document.forms[0].insreg_policydate.value=policydate;
	document.forms[0].bnk_cond.value=clause;
	document.forms[0].sel_prempdby.value=paidby;
	document.forms[0].insreg_premamt.value=premium;
	document.forms[0].insreg_duedate.value=duedate;
	document.forms[0].insreg_security.value=security;
	document.forms[0].sel_risk.value=risk;
	document.forms[0].insreg_details.value=details;
	document.forms[0].insreg_credamt.value=cvramt;
	document.forms[0].txt_expirydate.value=expirydate;
	document.forms[0].txt_rskfactor.value=riskfactor;
	
	document.forms[0].txt_insaddres1.value=document.getElementById("hidaddr1"+val).value;
	document.forms[0].txt_insaddres2.value=document.getElementById("hidaddr2"+val).value;
	document.forms[0].txt_insaddres3.value=addr3;
	document.forms[0].txt_inscity.value=city;
	document.forms[0].txt_insstate.value=state;
	document.forms[0].txt_inspincode.value=pincode;
	document.forms[0].cbsaccountno.value=cbsaccno;
	
	showDetails();
	if(document.forms[0].statusflag.value=="O" && document.forms[0].readFlag.value.toUpperCase()=="W")
	{
		disableCommandButtons(false,true,false,true,true,false);
	}
}
function clearfields()
{
	document.forms[0].insreg_compname.value="";
	document.forms[0].insreg_beneficial.value="";
	document.forms[0].insreg_coverno.value="";
	document.forms[0].insreg_policyno.value="";
	document.forms[0].insreg_policydate.value="";
	document.forms[0].bnk_cond.value="";
	document.forms[0].sel_prempdby.value="";
	document.forms[0].insreg_premamt.value="";
	document.forms[0].insreg_duedate.value="";
	document.forms[0].insreg_security.value="";
	document.forms[0].sel_risk.value="";
	document.forms[0].insreg_details.value="";
	document.forms[0].insreg_credamt.value="";
}
function doSave()
{
	document.forms[0].hidBeanId.value="Register";		
	document.forms[0].hidSourceUrl.value="/action/insurance_register.jsp";
	document.forms[0].hidBeanMethod.value="updateInsuranceDetails";
	document.forms[0].hidBeanGetMethod.value="getInsuranceDetails";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function disableCommandButtons(cmdedit,cmdsave,cmddel,cmdcancel,cmdclose,cmdmask)
{  
	 document.forms[0].cmdedit.disabled=cmdedit;	  
	 document.forms[0].cmdsave.disabled=cmdsave;
	 document.forms[0].cmddelete.disabled=cmddel;
	 document.forms[0].cmdcancel.disabled=cmdcancel;
	 document.forms[0].cmdclose.disabled=cmdclose;
	 document.forms[0].cmdmask.disabled=cmdmask;
}  

function doEdit()
{ 	
	disableFields(true);
	document.forms[0].hidAction.value ="Update";
	document.forms[0].insreg_premamt.readOnly=false;
	document.forms[0].insreg_beneficial.readOnly=false;
	document.forms[0].insreg_coverno.readOnly=false;
	document.forms[0].bnk_cond.disabled=false;
	document.forms[0].sel_prempdby.disabled=false;
	document.forms[0].sel_risk.disabled=false;
	document.forms[0].txt_rskfactor.disabled=false;
	
	document.forms[0].txt_insaddres1.readOnly=false;
	document.forms[0].txt_insaddres2.readOnly=false;
	document.forms[0].txt_insaddres3.readOnly=false;
	document.forms[0].txt_inscity.readOnly=false;
	document.forms[0].txt_insstate.readOnly=false;
	document.forms[0].txt_inspincode.readOnly=false;
	document.forms[0].insreg_details.readOnly=false;
	disableCommandButtons(true,false,false,false,true);
}

function doNew()
{
  disableFields(false);
  document.forms[0].hidAction.value ="Insert";
  disableCommandButtons(true,false,true,false,true,true);
  clearfields();
   for(var i=0;i<document.forms[0].length;i++)
	  {
		if(document.forms[0].elements[i].type=='radio'  )
		  {
			document.forms[0].elements[i].disabled=true;
		  }	 
	  }
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidBeanGetMethod.value="getInsuranceDetails";
		document.forms[0].action=appUrl+"action/insurance_register.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function showDetails()
{
	if(document.forms[0].sel_risk.value=="n")
	{
		document.all.d1.style.visibility="hidden";
		document.all.d2.style.visibility="hidden";
		document.forms[0].insreg_details.value="";
	}
	else
	{
		document.all.d1.style.visibility="visible";
		document.all.d2.style.visibility="visible";
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
		  if(document.forms[0].elements[i].type=='select-one')
		  {
			document.forms[0].elements[i].disabled=val;
		  }	 
	  }	  
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="Delete";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateInsuranceDetails";
		document.forms[0].hidBeanGetMethod.value="getInsuranceDetails";	
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="action/insurance_register.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();
	}
}

function onloading()
{	 
	showDetails(); 
	document.forms[0].hidAction.value ="";
	document.all.d1.style.visibility="hidden";
	document.all.d2.style.visibility="hidden";
	disableFields(true);

	if(varOrgLev != 'A')
	{
	   disableControls(true,true,true,true,true,false);
	}
	else
	{
		disableControls(true,false,true,true,true,false);
		if(<%=intVecRowSize%>==0)
		{
			document.forms[0].cmdedit.disabled = true;
		}
	}
}
function disableControls(bcmdMask,bcmdEdit,bcmdApply,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdmask.disabled=bcmdMask;
	document.forms[0].cmdsave.disabled=bcmdApply;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}
function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appUrl+"action/"+page;
	document.forms[0].submit();
}

function doMask()
{	
		document.forms[0].hidAction.value ="Mask";
		document.forms[0].action=appUrl+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updateInsuranceDetails";
		document.forms[0].hidBeanGetMethod.value="getInsuranceDetails";	
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].hidSourceUrl.value="action/insurance_register.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();
}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading()" >
<form name="frmpri" method = "post" class="normal">
<lapschoice:monitortag pageid="2"/>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
      <tr> 
        
      <td class="page_flow">Home -&gt;Monitoring-&gt;Monitoring Register -&gt;Insurance Register</td>
      </tr>
    </table>
    <lapschoice:Monitor strSource="MREG"/>    
   <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td valign="top">		
		<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                            <tr>                               
            <td colspan="2"  >
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td colspan="2"> </td>
                </tr>
                <tr> 
                  <td width="11%">Insurance Company name</td>
                  <td  width="20%"> 
                    <input type="text" name="insreg_compname" size="20" maxlength="100"  style= "text-align:left;border-style=groove" 
                    onKeyPress="formattext()" >
                  </td>
                  <td width="14%" nowrap="nowrap">Cover Note No </td>
                  <td width="18%"> 
                    <input type="text" name="insreg_coverno" size="20" maxlength="6"  style= "text-align:left;border-style=groove" 
                    onKeyPress="allowInteger()">
                  </td>
                  <td width="14%" >Beneficiary Name </td>
                  <td  width="23%" > 
                    <input type="text" name="insreg_beneficial" size="20" maxlength="100"  style= "text-align:left;border-style=groove" 
                    onKeyPress="formattext()">
                  </td>
                </tr>
                <tr> 
                  <td width="11%">Policy No</td>
                  <td  width="20%"> 
                    <input type="text" name="insreg_policyno" size="20" maxlength="20"  style= "text-align:left;border-style=groove"
                     onKeyPress="formattext()" >
                  </td>
                  <td width="14%" nowrap="nowrap">Policy Date</td>
                  <td width="18%"> 
                    <input type="text" name="insreg_policydate" size="20" maxlength="10"  style= "text-align:left;border-style=groove" 
                    onKeyPress="allowInteger()" >
                  </td>
                  <td width="14%" >Whether Bank Clause Covered</td>                    
					<td  width="23%" ><select name="bnk_cond">
                                    <option value="s">--Select--</option>
                                    <option value="y">Yes</option>
                                    <option value="n">No</option>
                                  </select>
                  </td>
                </tr>
                <tr> 
                  <td width="11%">Premium paid by</td>                 
					 <td  width="20%">                    
					 <select name="sel_prempdby">
                                    <option value="s">--Select--</option>
                                    <option value="b">Bank</option>
                                    <option value="a">Applicant</option>
                                  </select>
                  </td>                  
                  <td width="14%" nowrap="nowrap">Premium Amount</td>
                  <td width="18%"> 
                    <input type="text" name="insreg_premamt" size="20" maxlength="15"  style= "text-align:left;border-style=groove" 
                    onKeyPress="allowInteger()">
                  </td>
                  <td width="14%" >Due date for Renewal</td>
                  <td  width="23%" > 
                    <input type="text" name="insreg_duedate"
                  			  onBlur="checkDate(this)" size="20" maxlength="10" >
                  </td>
                </tr>
                <tr>                  
                  <td width="14%" nowrap="nowrap">Whether Exemptions of risk</td>
                  	<td>
                    <select name="sel_risk" size="1" onChange="showDetails()">
                      <option value="s">--Select--</option>
                      <option value="y">Yes</option>
                      <option value="n">No</option>
                    </select>
                    </td>                   
                  <td> Risk Factor</td>
                  <td>
                    <select name="txt_rskfactor">
				<option value="0">---Select-----</option>
				<%String apptype="38"; %>
				<lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
			  </select>
					</td>
				  <td>Expiry Date</td>
                  <td><input type="text" name="txt_expirydate" onBlur="checkDate(this)" size="20" maxlength="10" >
                    </td>
                </tr>
                <tr> 
                  <td  width="11%">Insurance Covered amount</td>
                  <td> 
                    <input type="text" name="insreg_credamt" size="20" maxlength="6"  style= "text-align:left;border-style=groove" 
                    onKeyPress="allowInteger()" >
                  </td>                  
					<td width="14%" id="d1">&nbsp; Details of Exemptions</td>
                  <td  width="23%" id="d2"> 
                    <textarea name="insreg_details" cols="25" rows="2"  tabindex="1" style= text-align:left;border-style=groove onKeyPress="formattext();textlimit(this,999)" onKeyUp="textlimit(this,999)" 
                    wrap="VIRTUAL"></textarea>
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="6"><b>Insured Property Address</b></td>
                </tr>
                <tr> 
                  <td width="11%">Address1</td>
                  <td width="20%"><input type="text" name="txt_insaddres1" tabindex="2" size="20" maxlength="50"  style= "text-align:left;border-style=groove" 
                    onKeyPress=""> </td>
                  <td width="14%">Address2</td>
                  <td width="18%"> <input type="text" name="txt_insaddres2" tabindex="3" size="20" maxlength="50"  style= "text-align:left;border-style=groove" 
                    onKeyPress=""></td>
                  <td width="14%">Address3</td>
                  <td width="23%"><input type="text" name="txt_insaddres3" tabindex="4" size="20" maxlength="50"  style= "text-align:left;border-style=groove" 
                    onKeyPress=""> </td>
                </tr>
                <tr>
                  <td width="11%">City</td>
                  <td width="20%"><input type="text" name="txt_inscity"  size="20" maxlength="50"  style= "text-align:left;border-style=groove" 
                    onKeyPress="notAllowSplChar()"> 
					<b><span 
					onClick="showCitySearch('txt_inscity','txt_insstate','hidcity','hidstate','txt_inspincode','hidzip')" style="cursor:hand"><img
																				src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
																				border="0" tabindex="5"></span></b>
					</td>
                  <td width="14%">State</td>
                  <td width="18%">
                    <input type="text" name="txt_insstate" tabindex="6" size="20" maxlength="50"  style= "text-align:left;border-style=groove" 
                    onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="9%"><%=ApplicationParams.getZipName()%></td>
                  <td width="28%"> 
                  <input type="text" name="txt_inspincode" tabindex="7" size="12"
					maxlength="<%=ApplicationParams.getZipValue()%>"  style="text-align:left"
					onKeyPress="allowInteger()" onBlur="zipvalidate(this,'<%=ApplicationParams.getZipValue()%>')">
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
            <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail_Mask' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>                      
            <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
  <tr>
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr align="center" class="dataheader"> 
            <td width="3%">&nbsp;</td>
            <td width="13%">Insurance Company Name</td>
            <td width="8%">Policy Date</td>
            <td width="10%">Policy No </td>
            <td width="9%">Ins. Covered Amt</td>
            <td width="11%">Premium Amount </td>
            <td width="12%">Beneficiary Name</td>            
            <td width="12%">Risk Factor</td>
            <td width="13%">Expiry Date</td>
          </tr>
          <%if(vecRow!=null && vecRow.size()>0)
                            {
                            	for(int i=0;i<vecRow.size();i++)
                            	{
                            		vecCol =(ArrayList)vecRow.get(i);%>
          <tr class="datagrid"> 
            <td width="3%" align="center"> 
              <input type="radio" style="border:none" name="opt_radio"  value=""
								 onClick="selectValues('<%=Helper.correctNull((String) vecCol.get(0))%>','<%=Helper.correctNull((String) vecCol.get(1))%>', 
																			'<%=Helper.correctNull((String) vecCol.get(2))%>','<%=Helper.correctNull((String) vecCol.get(3))%>',
																			'<%=Helper.correctNull((String) vecCol.get(4))%>','<%=Helper.correctNull((String) vecCol.get(5))%>',
																			'<%=Helper.correctNull((String) vecCol.get(6))%>','<%=Helper.correctNull((String) vecCol.get(7))%>',
																			'<%=Helper.correctNull((String) vecCol.get(8))%>','<%=Helper.correctNull((String) vecCol.get(9))%>',
																			'<%=Helper.correctNull((String) vecCol.get(10))%>','<%=Helper.correctNull((String) vecCol.get(11))%>',
																			'<%=Helper.correctNull((String) vecCol.get(12))%>','<%=Helper.correctNull((String) vecCol.get(13))%>',
																			'<%=Helper.correctNull((String) vecCol.get(14))%>','<%=Helper.correctNull((String) vecCol.get(15))%>',
																			'<%=Helper.correctNull((String) vecCol.get(16))%>','<%=Helper.correctNull((String) vecCol.get(17))%>',
																			'<%=Helper.correctNull((String) vecCol.get(20))%>','<%=Helper.correctNull((String) vecCol.get(21))%>',
																			'<%=Helper.correctNull((String) vecCol.get(22))%>','<%=Helper.correctNull((String) vecCol.get(23))%>',
																			'<%=Helper.correctNull((String) vecCol.get(24))%>','<%=i%>')">
<input type="HIDDEN" name="hid_Seqid<%=i%>" value="<%=Helper.correctNull((String) vecCol.get(0))%>">
<input type="HIDDEN" name="hidpolicyno<%=i%>" value="<%=Helper.correctNull((String) vecCol.get(4))%>">
<input type="HIDDEN" name="hidaddr1<%=i%>" value="<%=Helper.correctNull((String) vecCol.get(18))%>">
<input type="HIDDEN" name="hidaddr2<%=i%>" value="<%=Helper.correctNull((String) vecCol.get(19))%>">

              </td>
            <td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(3))%></td>
            <td width="8%">&nbsp;<%=Helper.correctNull((String) vecCol.get(14))%></td>
            <td width="10%">&nbsp;<%=Helper.correctNull((String) vecCol.get(4))%></td>
            <td width="9%"><%=Helper.correctNull((String) vecCol.get(6))%></td>
            <td width="11%">&nbsp;<%=Helper.correctNull((String) vecCol.get(7))%></td>
            <td width="12%">&nbsp;<%=Helper.correctNull((String) vecCol.get(9))%></td>
            <td width="12%">&nbsp;<%=Helper.correctNull((String) vecCol.get(17))%></td>
            <td width="13%">&nbsp;<%=Helper.correctNull((String) vecCol.get(15))%></td>
          </tr>
          <%}}else{%>
          <tr class="datagrid"> 
            <td align="center"  colspan="7">No Data Found</td>
          </tr>
          <%}%>
        </table>                        
	  </td>
  </tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidSeqid" value="">
<input type="hidden" name="hidcity" value="<%=Helper.correctNull((String)hshValues.get("hidcity"))%>">
<input type="hidden" name="hidstate" value="<%=Helper.correctNull((String)hshValues.get("hidstate"))%>">
<input type="hidden" name="insreg_security" value=""> 
<input type="hidden" name="cbsaccountno">
  <input type="hidden" name="hidzip">
  <input type="hidden" name="hidkeyid" value="<%=Helper.correctNull((String)hshValues.get("Accno")) %>">
</form>
</body>
</html>
