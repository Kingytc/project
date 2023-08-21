<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var varGovtsponsorschme="<%=Helper.correctNull((String)hshValues.get("govtsponsorschme"))%>";
var vareducation="<%=Helper.correctNull((String)hshValues.get("minedu"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function call_page(url)
{
	document.location=appUrl+"action/"+url;
}
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	
		 disableFields(false);
	}
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="/action/set_govtspons_parameters.jsp";
		document.forms[0].hidBeanId.value="govtsponschklist";
		document.forms[0].hidBeanGetMethod.value="getgovtsponsparameters";
		document.forms[0].action=appUrl +"action/set_govtspons_parameters.jsp";
		document.forms[0].submit(); 
	}	
}
function doEdit()
{ 	
	if(document.forms[0].sel_Govtsponsorschme.value != '0'){
    disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
	 document.forms[0].sel_Govtsponsorschme.disabled=true;	
	}else{
		alert("Select Government Sponsor Scheme");
		return;
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
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}	 	  
	}
	document.forms[0].sel_Govtsponsorschme.disabled=false;	
}
function doDelete()
{
	if (ConfirmMsg("101"))
	{
		document.forms[0].hidAction.value="Delete";
		
		document.forms[0].hidSourceUrl.value="/action/set_govtspons_parameters.jsp";
		document.forms[0].hidBeanId.value="govtsponschklist";
		document.forms[0].hidBeanMethod.value="updategovtsponsparameters";
		document.forms[0].hidBeanGetMethod.value="getgovtsponsparameters";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
	}
}

function placevalues()
{
	if(varGovtsponsorschme!="")
	{
		document.forms[0].sel_Govtsponsorschme.value=varGovtsponsorschme;
	}
	if(vareducation!="")
	{
		document.forms[0].txt_minedu.value=vareducation;
	}
	disableCommandButtons("load");
}

function doClose()
{
	if (ConfirmMsg(100))
	{
		call_page('setupnav.jsp');
	}	
}
function doSave()
{
   if(document.forms[0].txt_sustenance.value!="")
      {
          var intValue=parseFloat(document.forms[0].txt_sustenance.value);
          if(intValue>100.00)
          {
              alert("Minimum sustenance Required \n should not be greater than 100%");
              return false;
           }      
      }

    var term = parseFloat(document.forms[0].txt_tl.value);
	var wc = parseFloat(document.forms[0].txt_wc.value);
    var business = parseFloat(document.forms[0].txt_businesssector.value);
    var total = parseFloat(term + wc);
	if(business < total){
		alert("Sum of Term loan and Working Capital shouldn't exceed the limit defined in Business sector (Overall Limit)");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
   	document.forms[0].sel_Govtsponsorschme.disabled=false;	
   	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidSourceUrl.value="/action/set_govtspons_parameters.jsp";
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanMethod.value="updategovtsponsparameters";
	document.forms[0].hidBeanGetMethod.value="getgovtsponsparameters";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();	
}
function getpoints()
{
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanGetMethod.value="getgovtsponsparameters";
	document.forms[0].action=appUrl +"action/set_govtspons_parameters.jsp";
	document.forms[0].submit(); 

}
function checkAge(obj)
{	
	if(parseFloat(obj.value,10) > 100)
	{
		ShowAlert(104,"Age");
		obj.focus();
		obj.value = "";
		return false;
	}
}
function chkMinMax(){
	var minterm = parseInt(document.forms[0].txt_minage.value);
	
	if(minterm > parseInt(document.forms[0].txt_maxage.value)){
		alert("Minimum Age cannot be greater than Maximum Age General (Yrs)");
		return;
	} 
	if (minterm > parseInt(document.forms[0].txt_maxagescst.value)){
		alert("Minimum Age cannot be greater than Maximum Age (SC/ST) (Yrs)");
		return;
	} 
	if (minterm > parseInt(document.forms[0].txt_maxageex.value)){
		alert("Minimum Age cannot be greater than Maximum age (Ex-serviceman) (Yrs)");
		return;
	}
	if (minterm > parseInt(document.forms[0].txt_maxagephy.value)){
		alert("Minimum Age cannot be greater than Maximum age (Phy.Challenged) (Yrs)");
		return;
	}
	if (minterm > parseInt(document.forms[0].txt_maxagewomen.value)){
		alert("Minimum Age cannot be greater than Maximum age (Women) (Yrs)");
		return;
	}
	if (minterm > parseInt(document.forms[0].txt_northeast.value)){
		alert("Minimum Age cannot be greater than North east general maximum age");
		return;
	}
	
}

function chkMinMaxRepay(){
	var minrepay = parseInt(document.forms[0].txt_minrepay.value);
	var maxrepay = parseInt(document.forms[0].txt_maxrepay.value); 

	if(minrepay > maxrepay){
		alert("Min Repayment period (Months) shouldn't be greater than Maximum repayment period (Months)");
		return;
	}
}

function chkMinMaxSHG(){
	var minrepay = parseInt(document.forms[0].txt_minno.value);
	var maxrepay = parseInt(document.forms[0].txt_maxno.value); 

	if(minrepay > maxrepay){
		alert("For SHG Min No. of members shouldn't be greater than Max. no. of members");
		return;
	}
}
</script>
</head>
<body onload="placevalues()">
<form name="realisible_means" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Tertiary Products -&gt; Government Sponsor Scheme Parameters</td>
    </tr>
  </table>
  <table width="71%" border="0" cellspacing="3" cellpadding="5" class="outertable border1" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center" onload="placevalues()">
          <tr class="dataheader">
            <td colspan="4" align="center"><b>Government Sponsor Scheme Parameters</b></td>
          </tr>
          <tr> 
            <td>Government Sponsor Scheme</td>
            <td colspan="3"> 
              <select name="sel_Govtsponsorschme" tabindex="1" onchange="getpoints()">
                <option value="0">---select---</option>
                <lapschoice:StaticDataTag apptype="11" tagType=""/> 
              </select>
            </td>
          </tr>
          <tr> 
            <td>Minimum Age</td>
            <td> 
              <input type="text" name="txt_minage" onblur="checkAge(this);"
					value="<%=Helper.correctNull((String)hshValues.get("minage"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Maximum Age General (Yrs)</td>
            <td> 
              <input type="text" name="txt_maxage" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("maxage"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td>Maximum Age (SC/ST) (Yrs)</td>
            <td> 
              <input type="text" name="txt_maxagescst" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("maxagescst"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Maximum age (Ex-serviceman) (Yrs)</td>
            <td> 
              <input type="text" name="txt_maxageex" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("maxageexser"))%>"
					size="5" maxlength="3"  onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td>Maximum age (Phy.Challenged) (Yrs)</td>
            <td> 
              <input type="text" name="txt_maxagephy" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("maxagephy"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Maximum age (Women) (Yrs)</td>
            <td> 
              <input type="text" name="txt_maxagewomen" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("maxagewomen"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td>North east general maximum age (Yrs)</td>
            <td> 
              <input type="text" name="txt_northeast" onblur="checkAge(this);chkMinMax();"
					value="<%=Helper.correctNull((String)hshValues.get("northeast"))%>"
					size="5" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Minimum educational qualification</td>
            <td> 
              <select name="txt_minedu">
                <option value="9">PUC / Plus 2</option>
                <option value="10">SSLC</option>
                <option value="11">VIII Pass</option>
                <option value="12">Illiterate</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>Annual income of family (Rural) (<%=ApplicationParams.getCurrency()%>)</td>
            <td> <lapschoice:CurrencyTag name="txt_annualincomerural"
					value='<%=Helper.correctNull((String)hshValues.get("annualincomerural"))%>'
					size="20" maxlength="9" /> </td>
            <td>Mobility in years</td>
            <td colspan="2"> 
              <input type="text" name="txt_mobility" size="5" maxlength="2" value="<%=Helper.correctNull((String)hshValues.get("mobility"))%>">
            </td>
          </tr>
          <tr> 
            <td>Annual income of family (others) (<%=ApplicationParams.getCurrency()%>)</td>
            <td> <lapschoice:CurrencyTag name="txt_annualincomeothers"
					value='<%=Helper.correctNull((String)hshValues.get("annualincomeothers"))%>'
					size="20" maxlength="9" /> </td>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp; </td>
          </tr>
          <tr> 
            <td><b>Business sector (Overall Limit) (<%=ApplicationParams.getCurrency()%>)</b></td>
            <td> <lapschoice:CurrencyTag name='txt_businesssector'
					value='<%=Helper.correctNull((String)hshValues.get("sector"))%>'
					size="20" maxlength="15" /> </td>
            <td>&nbsp;</td>
            <td colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td>Term loan <b>(<%=ApplicationParams.getCurrency()%>)</b>
            </td>
            <td> <lapschoice:CurrencyTag name="txt_tl" 
					value='<%=Helper.correctNull((String)hshValues.get("termloan"))%>'
					size="20" maxlength="15" /> </td>
            <td>Working Capital <b>(<%=ApplicationParams.getCurrency()%>)</b></td>
            <td colspan="2"> <lapschoice:CurrencyTag name="txt_wc" 
					value='<%=Helper.correctNull((String)hshValues.get("workingcapital"))%>'
					size="20" maxlength="15" /> </td>
          </tr>
          <tr> 
            <td><b>Other than business (Overall Limit) (<%=ApplicationParams.getCurrency()%>)</b></td>
            <td> <lapschoice:CurrencyTag name="txt_otherbus"
					value='<%=Helper.correctNull((String)hshValues.get("otherbuss"))%>'
					size="20" maxlength="15" /> </td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>Term loan <b>(<%=ApplicationParams.getCurrency()%>)</b>
            </td>
            <td> <lapschoice:CurrencyTag name="txt_othertl"
					value='<%=Helper.correctNull((String)hshValues.get("othertl"))%>'
					size="20" maxlength="15" /> </td>
            <td>Working Capital <b>(<%=ApplicationParams.getCurrency()%>)</b></td>
            <td colspan="2"> <lapschoice:CurrencyTag name="txt_otherwc"
					value='<%=Helper.correctNull((String)hshValues.get("otherwc"))%>'
					size="20" maxlength="15" /> </td>
          </tr>
          <tr> 
            <td> Margin Required <b>(%) </b></td>
            <td> 
              <input type="text" name="txt_margin"
					value="<%=Helper.correctNull((String)hshValues.get("margin"))%>"
					size="15" maxlength="5" onKeypress="allowNumber(this)"  onblur="checkPercentage(this);"
					style="border-style=groove">
            </td>
            <td>&nbsp; Subsidy <b>%</b></td>
            <td colspan="2"> 
              <input type="text" name="txt_loansubsidy"
					value="<%=Helper.correctNull((String)hshValues.get("subsidy"))%>" onblur="checkPercentage(this);"
					size="15" maxlength="5" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td>Maximum Subsidy Amount <b>(<%=ApplicationParams.getCurrency()%>)</b>
            </td>
            <td> <lapschoice:CurrencyTag name="txt_maxsubsidy"
					value='<%=Helper.correctNull((String)hshValues.get("maxsubamt"))%>'
					size="20" maxlength="15" /> </td>
            <td>Min Repayment period (Months)</td>

            <td colspan="2"> 
              <input type="text" name="txt_minrepay" onblur = 'chkMinMaxRepay();'
					value="<%=Helper.correctNull((String)hshValues.get("minreayment"))%>"
					size="15" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td>Maximum repayment period (Months)
            </td>
            <td> 
              <input type="text" name="txt_maxrepay" onblur = 'chkMinMaxRepay();'
					value="<%=Helper.correctNull((String)hshValues.get("maxrepay"))%>"
					size="15" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Minimum sustenance Required (%)</td>
            <td colspan="2"> 
              <input type="text" name="txt_sustenance" onblur="checkPercentage(this);"
					value="<%=Helper.correctNull((String)hshValues.get("sustenance"))%>"
					size="15" maxlength="5" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
          </tr>
          <tr> 
            <td colspan="5"><b>For SHG</b>
            </td>
          </tr>
          <tr> 
            <td>Min No. of members</td>
            <td  colspan="3"> 
              <input type="text" name="txt_minno" onblur="chkMinMaxSHG();"
					value="<%=Helper.correctNull((String)hshValues.get("shgminmem"))%>"
					size="15" maxlength="3" onKeypress="allowNumber(this)">
            </td>
          </tr>
          <tr> 
            <td >Max. no. of members</td>
            <td> 
              <input type="text" name="txt_maxno" onblur="chkMinMaxSHG();"
					value="<%=Helper.correctNull((String)hshValues.get("shgmaxmem"))%>"
					size="15" maxlength="3" onKeypress="allowNumber(this)" style="text-align:left;border-style=groove">
            </td>
            <td>Max. limit of loan for single borrower <b>(<%=ApplicationParams.getCurrency()%>)</b></td>
            <td colspan="2"> 
              <lapschoice:CurrencyTag name="txt_maxloan"
					value='<%=Helper.correctNull((String)hshValues.get("shgmaxloan"))%>'
					size="20" maxlength="15" style = "text-align:right"/>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hidRealisible_ID" value="" />
  <input type ="hidden" name ="hidkeyid" value="<%=Helper.correctNull((String)hshValues.get("govtsponsorschme"))%>">
</form>
</body>
</html>
