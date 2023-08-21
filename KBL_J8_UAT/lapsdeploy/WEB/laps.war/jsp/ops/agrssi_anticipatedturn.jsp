<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Anticipated Turnover</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varrecordflag = "<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var genid = "";
function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		if(document.forms[0].appstatus.value !='Open/Pending')
	  	{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;		 
		}
		else
		{
			document.forms[0].cmdedit.disabled=false;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmdcancel.disabled=true;
			document.forms[0].cmdclose.disabled=false;	
		}
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddelete.disabled=false;
		 document.forms[0].cmdsave.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose.disabled=true;	 
		 disableFields(false);
	}
}
function onloading()
{	
	disableFields(true);
	//disableCommandButtons("load");
	document.forms[0].hidTabName.value="ExportDetails";	
}
function doEdit()
{	
	disableFields(false);
	document.forms[0].hidAction.value ="U";
	disableCommandButtons("edit");
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{	
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
	document.forms[0].txt_total.readOnly=true;
	document.forms[0].txt_stockperiodLimit.readOnly=true;
	document.forms[0].txt_outstandLimit.readOnly=true;
	document.forms[0].txt_tot.readOnly=true;	
}
function callAdd()
{
	var val1=document.forms[0].txt_stkvalue.value;
	var val2=document.forms[0].txt_outstndvalue.value;
	
	if(val1=="")
	{
		val1=0.0;	
	}
	if(val2=="")
	{
		val2=0.0;
	}
	var val3=eval(val1)+eval(val2);
	document.forms[0].txt_tot.value=eval(val3);
	roundtxt(document.forms[0].txt_tot);
}
function callAddtwo()
{
	var val1=document.forms[0].txt_stockperiodLimit.value;
	var val2=document.forms[0].txt_outstandLimit.value;
	if(val1=="")
	{
		val1=0.0;
	}
	if(val2=="")
	{
		val2=0.0;	
	}
	var val3=eval(val1)+eval(val2);
	document.forms[0].txt_total.value=eval(val3);
}
function callPercentage()
{
	var val1=document.forms[0].txt_stkvalue.value;
	var val2=document.forms[0].txt_stockperiodmargin.value;
	if(val1=="")
		val1=0.0;
	if(val2=="")
		val2=0.0;
		
	var val3=0.0;
	if(val2!=0.0)
	{
		val3=eval(val1) - eval(val1)*(eval(val2)/100);
	}
	document.forms[0].txt_stockperiodLimit.value=eval(val3);
	roundtxt(document.forms[0].txt_stockperiodLimit);
	callAddtwo();
}
function callPercentagetwo()
{
	var val1=document.forms[0].txt_outstndvalue.value;
	var val2=document.forms[0].txt_outstandmargin.value;
	if(val1=="")
		val1=0.0;
	if(val2=="")
		val2=0.0;
	var val3=0.0;
	if(val2!=0.0)
	{
		val3=eval(val1)-eval(val1)*(eval(val2)/100);
	}
	document.forms[0].txt_outstandLimit.value=eval(val3);
	roundtxt(document.forms[0].txt_outstandLimit);
	callAddtwo();
}
function doSave()
{	
	document.forms[0].hidRecordflag.value = varrecordflag;
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidSourceUrl.value="/action/agrssi_anticipatedturn.jsp";
	document.forms[0].hidBeanMethod.value="updateAnticipatedTurnover";
	document.forms[0].hidBeanGetMethod.value="getAnticipatedTurnover";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doDelete()
{
	document.forms[0].hidAction.value="D";
	if(varrecordflag == "Y"){
	if(ConfirmMsg("101"))
	{
	document.forms[0].hidBeanId.value="arrears";
	document.forms[0].hidBeanMethod.value="updateAnticipatedTurnover";
	document.forms[0].hidBeanGetMethod.value="getAnticipatedTurnover";
	document.forms[0].hidSourceUrl.value="/action/agrssi_anticipatedturn.jsp";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
	}
}
}
function doCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanId.value="arrears";
		document.forms[0].hidBeanGetMethod.value="getAnticipatedTurnover";		
		document.forms[0].action=appUrl+"action/agrssi_anticipatedturn.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
	disableCommandButtons("load");
}
function doClose()
{	
	 if(ConfirmMsg(100))
	 {
		window.close();
	 }
}
function total(stock,outstand,total)
{	
	var total=0.00;
	var stock=stock.value;
	var outstand=outstand.value;
	if(stock=="")
	{
		stock=0.00;
	}
	if(outstand=="")
	{
		outstand=0.00;
	}
	total=eval(total)+eval(stock)+eval(outstand);
	document.forms[0].txt_total.value=total;
	roundtxt(document.forms[0].txt_total);
}
</script>
</head>
<body onload="onloading()">
<form name="fininc" method="post" class="normal"> 
 <lapschoice:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="5" class="outertable">
                      <tr class="dataheader"> 
                        <td colspan="4">Working Capital Requirement for Anticipted Turnover </td>
                      </tr>
                      <tr class="dataheader"> 
                        <td align="center" width="31%">&nbsp;</td>
                        <td width="20%" align="center">value</td>
                        <td width="20%" align="center">Margin(%)</td>
                        <td width="29%" align="center">Permissible Limit</td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center"width="31%">Average 
                          level,of stocking period required at any one time</td>
                        <td width="20%" align="center" class="tabactivenew">Rs. <lapschoice:CurrencyTag name="txt_stkvalue" onBlur="callAdd()" size="15" value = '<%=Helper.correctNull((String)hshValues.get("AT_Stockvalue"))%>' maxlength="10"/></td>
                        <td width="20%" align="center" class="tabactivenew"> 
                          <input type="text" name="txt_stockperiodmargin" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);callPercentage()" size="5" value="<%=Helper.correctNull((String)hshValues.get("AT_Stockmargin"))%>" maxlength="3"  >
                        </td>
                        <td width="29%" align="center" class="tabactivenew"> <lapschoice:CurrencyTag  name="txt_stockperiodLimit" size="15"  value='<%=Helper.correctNull((String)hshValues.get("AT_Stocklimit"))%>' maxlength="10" onChange="total(document.forms[0].txt_stockperiodLimit,document.forms[0].txt_outstandLimit,document.forms[0].txt_total)"/> 
                        </td>
                      </tr>
                      <tr class="datagrid"> 
                        <td align="center" height="36" width="31%">Average 
                          level of outstanding debtors at any one time </td>
                        <td width="20%" align="center" height="36">Rs. 
                          <lapschoice:CurrencyTag name="txt_outstndvalue" onBlur="callAdd()"  size="15" value = '<%=Helper.correctNull((String)hshValues.get("AT_outstandingvalue"))%>' maxlength="10"/></td>
                        <td width="20%" align="center" height="36"> 
                          <input type="text" name="txt_outstandmargin" onKeyPress="allowNumber(this)" onBlur="checkPercentage(this);callPercentagetwo()" size="5" value="<%=Helper.correctNull((String)hshValues.get("AT_Outstandmargin"))%>" maxlength="3">
                        </td>
                        <td width="29%" align="center" height="36"> 
                          <lapschoice:CurrencyTag name="txt_outstandLimit"  onBlur="callAddtwo()" size="15" value='<%=Helper.correctNull((String)hshValues.get("AT_Outstandlimit"))%>' maxlength="10" onChange="total(document.forms[0].txt_stockperiodLimit,document.forms[0].txt_outstandLimit,document.forms[0].txt_total)"/> 
                        </td>
                      </tr>
                      <tr class="dataheader"> 
                        <td align="center" height="36" width="31%">Total</td>
                        <td width="20%" align="center" height="36">Rs. 
                          <lapschoice:CurrencyTag name="txt_tot"  size="15" value = '<%=Helper.correctNull((String)hshValues.get("AT_Total"))%>' maxlength="10"/></td>
                        <td width="20%" align="center" height="36">&nbsp; 
                        </td>
                        <td width="29%" align="center" height="36"> 
                          <lapschoice:CurrencyTag name="txt_total"  size="15"  value = '<%=Helper.correctNull((String)hshValues.get("AT_Total"))%>' maxlength="10"/> 
                        </td>
                      </tr>
                      <tr> 
                        <td align="center" height="36" width="31%">Credit 
                          available from suppliers</td>
                        <td width="20%" align="center" height="36">Rs.</td>
                        <td colspan="2" align="center" height="36"> 
                          <lapschoice:CurrencyTag name="txt_creditsupplier" size="15"  maxlength="10" value ='<%=Helper.correctNull((String)hshValues.get("AT_Creditsupplier"))%>'/> 
                        </td>
                      </tr>
                      <tr> 
                        <td align="center" height="36" width="31%">Working 
                          capital required </td>
                        <td width="20%" align="center" height="36">Rs.</td>
                        <td colspan="2" align="center" height="36"><lapschoice:CurrencyTag name="txt_workingcapital"  size="15" value ='<%=Helper.correctNull((String)hshValues.get("AT_Workingcapital"))%>' maxlength="10"/> 
                        </td>

                      </tr>
                      <tr> 
                        <td align="center" width="31%">Weaknesses 
                          in the form which may require counselling from the bank</td>
                        <td width="20%" align="center" class="tabactivenew">&nbsp;</td>
                        <td colspan="2" align="center" class="tabactivenew">&nbsp; 
                          <textarea name="txt_counsellingbank" cols="50" rows="3" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL"><%=Helper.correctNull((String)hshValues.get("AT_Counsellingbank"))%></textarea>
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
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <br> 
  <br> 
  <br> 
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidTotalDesc" value="10">
<input type="hidden" name="hidFieldPrefix" value="txt_exportproducts">
<INPUT TYPE="hidden" NAME="hidGenID" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<INPUT TYPE="hidden" NAME="hidappno" value="<%=request.getParameter("appno")%>"> 
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
</form>
</body>
</html>

