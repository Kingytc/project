<%@include file="../share/directives.jsp"%>

<html>
<head>
<title>Executive Summary</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callLink(page,bean,method)
{	
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidSourceUrl.value=page;
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].hidCategoryType.value="CORP"; 
 	 document.forms[0].action=appUrl+"action/"+page;
	 document.forms[0].submit();
}

function placevalues()
{
	disableFields(true);
	var fin_risk_assess="<%=Helper.correctNull((String)hshValues.get("fin_risk_assess"))%>";
}


function disableFields(val)

	{
		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;		  
			}
		}
	document.forms[0].exec_summ_finTL4.readOnly=true;	
	document.forms[0].exec_summ_finTOL4.readOnly=true;
	document.forms[0].exec_summ_fincurrentratio4.readOnly=true;
	document.forms[0].exec_summ_findscr4.readOnly=true;
	document.forms[0].exec_summ_fincovratio1.readOnly=true;
	document.forms[0].exec_summ_fincovratio2.readOnly=true;
	document.forms[0].exec_summ_fincovratio3.readOnly=true;
	document.forms[0].exec_summ_fincovratio4.readOnly=true;
		
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,false,true)
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="executive"
		document.forms[0].hidBeanGetMethod.value="getData4";
		document.forms[0].hidBeanMethod.value="updateData4";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/exec_page4.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{	
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}	
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidAction.value="update";
	document.forms[0].hidBeanId.value="executive";
	document.forms[0].hidBeanMethod.value="updateData4";
	document.forms[0].hidBeanGetMethod.value="getData4";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/exec_page4.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].hidAction.value="delete"
			document.forms[0].hidBeanId.value="executive"
			document.forms[0].hidBeanMethod.value="updateData4";
			document.forms[0].hidBeanGetMethod.value="getData4";
			document.forms[0].action=appUrl+"controllerservlet";
			document.forms[0].hidSourceUrl.value="/action/exec_page4.jsp";
			document.forms[0].submit();
		 }
    }
	else
	{
		ShowAlert(158);
	}
}
function calTotal1(fbl,nfbl,tot)
{	
	var total=0.00;
	var fund=fbl.value;
	var nonfund=nfbl.value; 
	var tot;
	if(fund=="")
	{
		fund=0.00;
	}
	if(nonfund=="")
	{
		nonfund=0.00;
	}
	total=eval(total)+eval(fund)+eval(nonfund);
	tot.value=NanNumber(total);
	roundtxt(document.forms[0].exec_summ_finTL4);
	roundtxt(document.forms[0].exec_summ_finTOL4);
	roundtxt(document.forms[0].exec_summ_fincurrentratio4);
	roundtxt(document.forms[0].exec_summ_findscr4);
	calTotal();
	
}

function calAccount()
{	var totalAccount=0;
	var stand=document.forms[0].exec_summ_finTL1.value;
	var substand=document.forms[0].exec_summ_finTOL1.value;	
	var doubt=document.forms[0].exec_summ_fincurrentratio1.value;	
	var loss=document.forms[0].exec_summ_findscr1.value;
	if(stand=="")
		{
		stand=0;
		}
	if(substand=="")
		{
		substand=0;
		}
	if(doubt=="")
		{
		doubt=0;
		}
	if(loss=="")
		{
		loss=0;
		}
	totalAccount=eval(stand)+eval(substand)+eval(doubt)+eval(loss);
	document.forms[0].exec_summ_fincovratio1.value=NanNumber(totalAccount);
}
function calTotalFund()
{
	var totalfund=0.00;
	var stand=document.forms[0].exec_summ_finTL2.value;
	var substand=document.forms[0].exec_summ_finTOL2.value;	
	var doubt=document.forms[0].exec_summ_fincurrentratio2.value;	
	var loss=document.forms[0].exec_summ_findscr2.value; 
	if(stand=="")
		{
		stand=0.00;
		}
	if(substand=="")
		{
		substand=0.00;
		}
	if(doubt=="")
		{
		doubt=0.00;
		}
	if(loss=="")
		{
		loss=0.00;
		}
		
	totalfund=eval(stand)+eval(substand)+eval(doubt)+eval(loss);
	document.forms[0].exec_summ_fincovratio2.value=NanNumber(totalfund);
	roundtxt(document.forms[0].exec_summ_fincovratio2);
	
	calTotal();
}
function calTotalNONFund()
{
	var totalnonfund=0.00;
	var stand=document.forms[0].exec_summ_finTL3.value;
	var substand=document.forms[0].exec_summ_finTOL3.value;	
	var doubt=document.forms[0].exec_summ_fincurrentratio3.value;	
	var loss=document.forms[0].exec_summ_findscr3.value; 
	if(stand=="")
		{
		stand=0.00;
		}
	if(substand=="")
		{
		substand=0.00;
		}
	if(doubt=="")
		{
		doubt=0.00;
		}
	if(loss=="")
		{
		loss=0.00;
		}
	totalnonfund=eval(stand)+eval(substand)+eval(doubt)+eval(loss);
	document.forms[0].exec_summ_fincovratio3.value=NanNumber(totalnonfund);
	roundtxt(document.forms[0].exec_summ_fincovratio3);
	calTotal();
}
function calTotal()
{
	var total=0.00;
	var stand=document.forms[0].exec_summ_finTL4.value;
	var substand=document.forms[0].exec_summ_finTOL4.value;	
	var doubt=document.forms[0].exec_summ_fincurrentratio4.value;	
	var loss=document.forms[0].exec_summ_findscr4.value; 
	if(stand=="")
		{
		stand=0.00;
		}
	if(substand=="")
		{
		substand=0.00;
		}
	if(doubt=="")
		{
		doubt=0.00;
		}
	if(loss=="")
		{
		loss=0.00;
		}
	total=eval(stand)+eval(substand)+eval(doubt)+eval(loss);
	document.forms[0].exec_summ_fincovratio4.value=NanNumber(total);
	roundtxt(document.forms[0].exec_summ_fincovratio4);
}
</script>
</head>
<body onload="placevalues()">
<form name="formsum" method = post class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top"><jsp:include page="../com/proposallinks.jsp"
			flush="true">
			<jsp:param name="pageid" value="10" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />

		</jsp:include></td>
	</tr>
	<tr>
		<td class="page_flow">
			Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Executive Summary -&gt; Page 3
		</td>
	</tr>
</table>
<span style="display:none"><lapschoice:borrowertype /></span>
  <lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="5" align="center"  class="outertable">
  <tr> 
    <td valign="top"> 
      <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr > 
          <td valign="top" colspan="2"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="2"  class="outertable">
               <tr> 
                  <td colspan="5">Bank's 
                    Exposure to Industry 
                    
                  </td>
                </tr>
                <tr  class="dataheader"> 
                  <td width="20%" align="center">Classification of asset
                  </td>
                  <td width="19%" align="center">NO of A/Cs
                  </td>
                  <td width="19%" align="center">Fund based Limits
                  </td>
                  <td width="19%" align="center">Non Fund based Limits
                  </td>
                  <td width="23%" align="center">Total
                  </td>
                </tr>
                <tr> 
                  <td width="20%">Standard</td>
                  <td width="19%" align="center"> 
                      <input type="text" name="exec_summ_finTL1" 
                      size="12" onKeyPress="allowNumber(this)" 
                      value='<%=Helper.correctNull((String )hshValues.get("exec_summ_finTL1"))%>' 
                      maxlength="10" onChange="calAccount()">
                  </td>
                  <td width="19%" align="center">
                  	<lapschoice:CurrencyTag name="exec_summ_finTL2" size="15" maxlength="10"
						value='<%=Helper.correctNull((String )hshValues.get("exec_summ_finTL2"))%>' 
						onChange="calTotal1(document.forms[0].exec_summ_finTL2,document.forms[0].exec_summ_finTL3,document.forms[0].exec_summ_finTL4);calTotalFund();"/> 
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_finTL3" size="15" maxlength="10" 
                      value='<%=Helper.correctNull((String )hshValues.get("exec_summ_finTL3"))%>' 
					  onChange="calTotal1(document.forms[0].exec_summ_finTL2,document.forms[0].exec_summ_finTL3,document.forms[0].exec_summ_finTL4);calTotalNONFund()"/> 
                  </td>
                  <td width="23%" align="center"> 
                      <input type="text" name="exec_summ_finTL4" size="15" 
                      onKeyPress="allowNumber(this)" style="text-align:right"
                      value="<%=Helper.correctNull((String )hshValues.get("exec_summ_finTL4"))%>" maxlength="10" >
                  </td>
                </tr>
                <tr> 
                  <td width="20%">Sub-standard</td>
                  <td width="19%" align="center"> 
                      <input type="text" name="exec_summ_finTOL1" size="12" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_finTOL1"))%>" maxlength="10" onChange="calAccount()">
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_finTOL2" size="15"  
                      value='<%=Helper.correctNull((String )hshValues.get("exec_summ_finTOL2"))%>' maxlength="10" 
					  onChange="calTotal1(document.forms[0].exec_summ_finTOL2,document.forms[0].exec_summ_finTOL3,document.forms[0].exec_summ_finTOL4);calTotalFund()"/> 
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_finTOL3"
					   size="15"  value='<%=Helper.correctNull((String )hshValues.get("exec_summ_finTOL3"))%>' maxlength="10" 
					   onChange="calTotal1(document.forms[0].exec_summ_finTOL2,document.forms[0].exec_summ_finTOL3,document.forms[0].exec_summ_finTOL4);calTotalNONFund()"/> 
                  </td>
                  <td width="23%" align="center"> 
                      <input type="text" name="exec_summ_finTOL4" style="text-align:right" size="15" onKeyPress="allowNumber(this)"  value="<%=Helper.correctNull((String )hshValues.get("exec_summ_finTOL4"))%>" maxlength="10" >
                  </td>
                </tr>
                <tr> 
                  <td width="20%">Doubtful</td>
                  <td width="19%" align="center"> 
                      <input type="text" name="exec_summ_fincurrentratio1" size="12" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincurrentratio1"))%>" maxlength="10" onChange="calAccount()">
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_fincurrentratio2" size="15"  value='<%=Helper.correctNull((String )hshValues.get("exec_summ_fincurrentratio2"))%>' maxlength="10" 
					  onChange="calTotal1(document.forms[0].exec_summ_fincurrentratio2,document.forms[0].exec_summ_fincurrentratio3,document.forms[0].exec_summ_fincurrentratio4);calTotalFund()"/> 
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_fincurrentratio3" size="15"  value='<%=Helper.correctNull((String )hshValues.get("exec_summ_fincurrentratio3"))%>' maxlength="10" 
					  onChange="calTotal1(document.forms[0].exec_summ_fincurrentratio2,document.forms[0].exec_summ_fincurrentratio3,document.forms[0].exec_summ_fincurrentratio4);calTotalNONFund()"/> 
                  </td>
                  <td width="23%" align="center"> 
                      <input type="text" style="text-align:right" name="exec_summ_fincurrentratio4" size="15" onKeyPress="allowNumber(this)" onChange="calTotal()" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincurrentratio4"))%>" maxlength="10">
                  </td>
                </tr>
                <tr> 
                  <td width="20%">Loss</td>
                  <td width="19%" align="center"> 
                      <input type="text" name="exec_summ_findscr1" size="12" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_findscr1"))%>" maxlength="10" onChange="calAccount()">
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_findscr2" size="15"  value='<%=Helper.correctNull((String )hshValues.get("exec_summ_findscr2"))%>' maxlength="10" 
					onChange="calTotal1(document.forms[0].exec_summ_findscr2,document.forms[0].exec_summ_findscr3,document.forms[0].exec_summ_findscr4);calTotalFund()"/> 
                  </td>
                  <td width="19%" align="center"> 
                      <lapschoice:CurrencyTag name="exec_summ_findscr3" size="15"  value='<%=Helper.correctNull((String )hshValues.get("exec_summ_findscr3"))%>' maxlength="10" 
					onChange="calTotal1(document.forms[0].exec_summ_findscr2,document.forms[0].exec_summ_findscr3,document.forms[0].exec_summ_findscr4);calTotalNONFund()"/> 
                  </td>
                  <td width="23%" align="center"> 
                      <input type="text" style="text-align:right" name="exec_summ_findscr4" size="15" onKeyPress="allowNumber(this)" onChange="calTotal()" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_findscr4"))%>" maxlength="10">
                  </td>
                </tr>
                <tr> 
                  <td width="20%">Total</td>
                  <td width="19%" align="center"> 
                      <input type="text" name="exec_summ_fincovratio1" size="12" onKeyPress="allowNumber(this)" readOnly value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincovratio1"))%>" maxlength="10">
                  </td>
                  <td width="19%" align="center"> 
                      <input type="text" style="text-align:right" name="exec_summ_fincovratio2" size="15" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincovratio2"))%>" maxlength="10">
                  </td>
                  <td width="19%" align="center"> 
                      <input type="text" style="text-align:right" name="exec_summ_fincovratio3" size="15" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincovratio3"))%>" maxlength="10">
                  </td>
                  <td width="23%" align="center"> 
                      <input type="text" style="text-align:right" name="exec_summ_fincovratio4" size="15" onKeyPress="allowNumber(this)" value="<%=Helper.correctNull((String )hshValues.get("exec_summ_fincovratio4"))%>" maxlength="10">
                  </td>
                </tr>
              </table>
          </td>
        </tr>
        <tr> 
          <td valign="top" colspan="2">&nbsp;</td>
        </tr>

       
        <tr> 
          <td valign="top" colspan="2"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
          
            </table>
          </td>
        </tr>
       
      </table>
    </td>
  </tr>
</table>
     <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
<table width="100%" cellpadding="3" cellspacing="0"  class="outertable">
  <tr> 
    <td colspan="3"></td>
  </tr>
  <tr> 
    <td width="33%">&nbsp; 
        <div align="left"><a href="javascript:callLink('exec_page2.jsp','executive','getData2')" > 
          &lt;&lt; &nbsp;Previous </a> </div>
      </td>
    <td width="33%" align="center"> 
      <jsp:include page="../com/link1.jsp" flush="true"/> 
      </td>
    <td width="33%" align="right">Pg.3/8  &nbsp;<a href="javascript:callLink('exec_page5.jsp','executive','getData5')" > 
        Next &gt;&gt; </a>
    </td>
  </tr>
</table>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
</form>
</body>
</html>
