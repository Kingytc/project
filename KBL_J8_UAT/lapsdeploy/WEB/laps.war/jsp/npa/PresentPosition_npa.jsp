<%@include file="../share/directives.jsp"%>
<%ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
ArrayList vecCol=new ArrayList();%>
<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
function disableCommandButtons(cmdedit,cmddelete,cmdsave,cmdcancel,cmdclose)
{
		document.forms[0].cmdedit.disabled=cmdedit;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdsave.disabled=cmdsave;
		document.forms[0].cmdcancel.disabled=cmdcancel;
		document.forms[0].cmdclose.disabled=cmdclose;	
}
function selectValues(val1,val2,val3,val4,val5,val6,val7)
{
	document.forms[0].hid_strsno.value=val1;
	document.forms[0].txt_nature_limit.value=val2;
	document.forms[0].txt_amount_limit.value=val3;
	document.forms[0].txt_running_outstand.value=val4;
	document.forms[0].txt_dummy_ledger.value=val5;
	document.forms[0].txt_total_dues.value=val6;
	 document.forms[0].txt_facility_hid.value=val7;
	 if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		 disableCommandButtons(false,false,true,true,false);
	}
}
function doNew()
{
	disableFields(false);
	document.forms[0].hidAction.value ="insert";
	disableCommandButtons(true,true,false,false,true);
}
function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,true,false,false,true);
	document.forms[0].txt_dummy_ledger.focus();
}
function doCancel()
{  
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidSourceUrl.value="/action/PresentPosition_npa.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].action=appURL +"controllerservlet";
		document.forms[0].submit(); 		
	}	
}

function doSave()
{
	if(trim(document.forms[0].txt_nature_limit.value)=="")
	{
		ShowAlert('121', 'Nature of limit');
		document.forms[0].txt_nature_limit.focus();
		return;
	}	
	if(document.forms[0].txt_dummy_ledger.value=="")
	{
		alert("Enter the Dummy Ledger Interest Amount");
		document.forms[0].txt_dummy_ledger.focus();
		return;
	}
	document.forms[0].hidSourceUrl.value="/action/PresentPosition_npa.jsp";
	document.forms[0].hidBeanId.value="npacommon";
	document.forms[0].hidBeanMethod.value="updatePresentPosition";
	document.forms[0].hidBeanGetMethod.value="getPresentPosition";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].hidSourceUrl.value="/action/PresentPosition_npa.jsp";
		document.forms[0].hidBeanId.value="npacommon";
		document.forms[0].hidBeanMethod.value="updatePresentPosition";
		document.forms[0].hidBeanGetMethod.value="getPresentPosition";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}
function disableFields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		if(document.forms[0].elements[i].type=='select-one')
	 	{
			document.forms[0].elements[i].disabled=val;
		}	
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].disabled=!val;
		}		 
	}
	document.forms[0].txt_total_dues.readOnly=true;
	document.forms[0].txt_nature_limit.readOnly=true;
	document.forms[0].txt_amount_limit.readOnly=true;
	document.forms[0].txt_running_outstand.readOnly=true;	
}
function onLoading()
{
	disableFields(true);	
	disableCommandButtons(false,true,true,true,false);
}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdsave.disabled)
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/npa_mainlinknav.jsp";
		document.forms[0].submit();		
	}
}	
function callCalender(name)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,name);		
	}
}
function calTotal()
{
 var running=document.forms[0].txt_running_outstand.value;
 var dummy=document.forms[0].txt_dummy_ledger.value;
	if(running=="")
	{
		running="0.00";
	}
	if(dummy=="")
	{
		dummy="0.00";
	}
	var total=eval(running)+eval(dummy);
    document.forms[0].txt_total_dues.value=total;
    roundtxt(document.forms[0].txt_total_dues);
}
</script>
</head>
<body onload="onLoading()">
<form name="safaeri2" method="post" class="normal">
<lapstab:sarfiurltag pageid="2"/>
     <span class="page_flow">Home -&gt; NPA-&gt; Sarfaesi Proposal -&gt;Present Position -&gt;Account
<lapschoice:npaapplication />
<INPUT type="hidden" name="npa_appno" value="<%=(String)request.getParameter("npa_appno")%>" />
<lapstab:npapresentpostion module='<%=Helper.correctNull((String)request.getParameter("hidmoduletype"))%>' pageid="1" />
<br>
  <table width="60%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor" align="center">
    <tr class="dataheader"> 
      <td colspan="3" ><b>C) STATUS OF THE ACCOUNT (Rs.) </b></td>
    </tr>
    <tr class="datagrid"> 
      <td width="41%">NATURE OF LIMIT</td>
      <td width="3%">&nbsp;</td>
      <td width="56%"><input type="text" name="txt_nature_limit" size="20" maxlength="30">
	<input type="hidden" name="txt_facility_hid">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="41%">AMOUNT OF LIMIT</td>
      <td width="3%">Rs.</td>
      <td width="56%"> 
        <input type="text" name="txt_amount_limit" size="20" style="text-align:right" maxlength="15" onKeyPress="allowInteger()">
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="41%">RUNNING LEDGER OUTSTANDING</td>
      <td width="3%">Rs.</td>
      <td width="56%"> 
        <input type="text" name="txt_running_outstand" size="20" style="text-align:right"
				maxlength="15"   onKeyPress="allowInteger()" onBlur="calTotal()" >
      </td>
    </tr>
    <tr class="datagrid"> 
      <td width="41%" >DUMMY LEDGER INTEREST AMOUNT <span class="mantatory">*&nbsp;</span></td>
      <td width="3%" >Rs.</td>
      <td width="56%" > 
        <lapschoice:CurrencyTag name="txt_dummy_ledger" maxlength="15" tabindex="1" onBlur="calTotal()" />
      </td>
    </tr>
    <tr  class="dataheader"> 
      <td width="41%">TOTAL DUES</td>
      <td width="3%">Rs.</td>
      <td width="56%"> 
        <lapschoice:CurrencyTag name="txt_total_dues" maxlength="15" tabindex="5" onBlur="calTotal()" />
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
 <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td align="right"> <strong>Rs. in Lacs</strong></td>
      <td align="right">&nbsp;</td>
    </tr>
  
  <tr align="center"> 
                  <td colspan="2">
                      <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                        <tr> 
                          <td valign="top">                              
                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable linebor">
                  <tr class="dataheader"> 
                    <td width="3%"  rowspan="2">&nbsp;</td>
                    <td colspan="2"  align="center"><b>LIMIT</b></td>
                    <td width="20%"  align="center" rowspan="2"><b>RUNNING LEDGER OUTSTANDING</b></td>
                    <td width="16%"  align="center" rowspan="2"><b>DUMMY LEDGER INTEREST AMOUNT</b></td>
                    <td width="17%"  align="center" rowspan="2"><b>TOTAL DUES</b></td>
                  </tr>
                  <tr class="dataheader"> 
                    <td width="29%"  align="center"><b>NATURE </b></td>
                    <td width="15%"  align="center"><b>AMOUNT </b></td>
                  </tr>
                  <%vecRow=(ArrayList)hshValues.get("vecRow");
					if(vecRow.size()>0 && vecRow!=null)
					{
						for(int i=0;i<vecRow.size();i++)
						{
						vecCol = (ArrayList)vecRow.get(i);%>
                  <tr class="datagrid"> 
                    <td width="3%" align=center> 
                      <input type="radio" 
													style="border:none" name="radiobutton" value="radiobutton"
													onClick="selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
													'<%=Helper.correctNull((String)vecCol.get(1))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%>',
													'<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%>',
													'<%=Helper.correctNull((String)vecCol.get(20))%>')">
                      </td>
                    <td width="29%" >&nbsp;<%=Helper.correctNull((String)vecCol.get(1))%></td>
                    <td width="15%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(2))))%></td>
                    <td width="20%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(3))))%></td>
                    <td width="16%" align="right">&nbsp;&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(11))))%></td>
                    <td width="17%" align="right">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)vecCol.get(13))))%></td>
                  </tr>
                  <%}}else{%>
                  <tr class="datagrid"> 
                    <td align="center" colspan="8">No Data Found</td>
                  </tr>
                  <%}%>
                </table>
                          </td>
                        </tr>
                      </table>
                  </td>
                </tr>
               </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hid_strsno" value="<%=Helper.correctNull((String)hshValues.get("PRE_SNO"))%>"/>
</form>
</body>
</html>