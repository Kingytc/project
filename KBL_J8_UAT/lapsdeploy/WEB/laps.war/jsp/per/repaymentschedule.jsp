<%@include file="../share/directives.jsp"%>
<%
ArrayList arryRow=(ArrayList)hshValues.get("arryRow");
ArrayList arryCol = null;
String strDbDataCount = Helper.correctNull((String)hshValues.get("isDataDb"));
String strmodintrate =Helper.correctNull((String)hshValues.get("txtloan_modintrate"));
String strterms =Helper.correctNull((String)hshValues.get("txtloan_reqterms"));
String strRepayMonths = Helper.correctNull((String)hshValues.get("txtloan_RepayMonths"));
String strrecmdamt =Helper.correctNull((String)hshValues.get("txtloan_sancamt"));
int intterms =Integer.parseInt(strRepayMonths);
String strStartTerm = (String)hshValues.get("hidstartterms");
int intstartterm = 1;
if (!strStartTerm.trim().equals("")) {
	intstartterm = Integer.parseInt(strStartTerm);
}
int intendtterm = 0;
if(intstartterm + 49 > intterms)
{
	intendtterm = intterms ;	
}
else
{
	intendtterm = intstartterm + 49;
}
String strServicingFlag = Helper.correctNull((String) request.getParameter("hidServicingFlag"));
if (strServicingFlag.trim().equals("")) {
	strServicingFlag = Helper.correctNull((String) request.getParameter("hidSerFlag"));
}%>
<html>
<head>
<title>Repayment Schedule</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script>
var strServicingFlag = "<%=strServicingFlag%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var vardbdata ="<%=strDbDataCount%>";
var varmodintrate = "<%=strmodintrate%>";
var varterm = "<%=strterms%>";
var varrecmdamt = "<%=strrecmdamt%>";
var varrate =eval(varmodintrate)/(12*100);
var varstartterm = "<%=intstartterm%>";
var varendterm = "<%=intendtterm%>";
var vardenominator=Math.pow(varrate+1,varterm)-1;
var varnumerator=varrate*Math.pow(varrate+1,varterm);
var varemi=roundVal((varnumerator/vardenominator)*varrecmdamt);
var vartotalemi=roundVal(varemi*varterm);
var originalinterestamt  = roundVal(varrecmdamt * varrate);
var originalprincipalamt =roundVal(varemi -( varrecmdamt * varrate));
var index1;

function doAccept(val) {
var index = val;
 var hlpvar = appURL+"action/repayment1.jsp?index="+index;
 var title = "Organisation";
 var monthfrom;
 var monthto;
 
var str=window.showModalDialog(hlpvar,window,"dialogWidth:250px;dialogHeight:250px;center:yes");
if (str == undefined)
 {
  return;
 }
var arr  =str.split(',');

for(var i=arr[0];i<=arr[1];i++)
{
index1 = i;
document.forms[0].hidtotalamt.value="1";
calculateAmountOS(index1,arr[2],arr[0]);
}
}

function applymon()
{	
	alert();
	document.forms[0].hidchange[0].value="1";
}

function onloading()
{	
	if(vardbdata=="true")
	{
		disableControls(true,true,false,true,false,true,false);
	}
	else
	{
		disableControls(true,true,false,true,true,true,false);
	}	
	if(eval(varstartterm) > 1)
	{		
		document.forms[0].cmdprevious.disabled = false;
	}
	if(eval(varendterm) < eval(varterm))
	{	
		if(vardbdata=="true")
		{
			document.forms[0].cmdnext.disabled = false;
		}
	}
	callDisable(true);
	for( i=eval(varstartterm);i<=eval(varendterm);i++)		
	{	
		document.forms[0].elements["txt_actualprincipalamt"+i].readOnly=true;
		document.forms[0].elements["txt_totamt"+i].readOnly=true;		
	}  
}

function doEdit()
{
	callDisable(true);
	disableControls(true,true,true,false,true,false,true);
}

function doSave()
{	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidSerFlag.value="<%=strServicingFlag%>";
	document.forms[0].hidstartterms.value=varstartterm;
	document.forms[0].hidendterms.value=varendterm;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanGetMethod.value="updateAmortization";
	document.forms[0].hidBeanId.value="perapplicant";
	document.forms[0].action=appURL+"action/repaymentschedule.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidrepaymenttype.value="repay";
		document.forms[0].hidBeanGetMethod.value="calculateAmortization";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/repaymentschedule.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanGetMethod.value="updateAmortization";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].action=appURL+"action/repaymentschedule.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		if (strServicingFlag == "LS") {
			window.close();
		} else {
		document.forms[0].hidAppType.value="";
 		document.forms[0].radLoan.value="Y";
 		document.forms[0].page.value="ep";
 		document.forms[0].appno.value="<%=Helper.correctNull((String)hshValues.get("appno"))%>";
		document.forms[0].hidBeanId.value="perapplicant";
		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
		document.forms[0].hidSourceUrl.value="perloandetails.jsp";
		document.forms[0].action=appURL+"action/perloandetails.jsp";
		document.forms[0].method="post";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
		}
	}

}

function disableControls(bcmdPrevious,bcmdNext,bcmdEdit,bcmdSave,bcmdDelete,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdprevious.disabled=bcmdPrevious;
	document.forms[0].cmdnext.disabled=bcmdNext;
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdsave.disabled=bcmdSave;
	document.forms[0].cmddelete.disabled=bcmdDelete;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
	
}

function callDisable(one)
{
	for( i=eval(varstartterm);i<=eval(varendterm);i++)		
	{
			document.forms[0].elements["txt_actualinterestamt"+i].readOnly=one;	
			document.forms[0].elements["txt_actualprincipalamt"+i].readOnly=one;	
			document.forms[0].elements["txt_totamt"+i].readOnly=false;	
	}		
}

function checkInterestAmount(index)
{	if(document.forms[0].cmdedit.disabled)
	{
		if(checktrim(document.forms[0].elements["txt_actualinterestamt"+index].value)!="")
		{
			var indexactualinterestamt = roundVal(document.forms[0].elements["txt_actualinterestamt"+index].value);
			var indexoriginalinterestamt = roundVal(document.forms[0].elements["hidoriginalinterestamt"+index].value);
			if(eval(indexactualinterestamt) < eval(indexoriginalinterestamt))
			{
				document.forms[0].elements["txt_actualprincipalamt"+index].value = "0";
			}
		}
		else
		{
			document.forms[0].elements["txt_actualprincipalamt"+index].value = "";
		}
	}
}

function calculateAmountOS(index,val,monfrval)
{
	var orginalamountOS	;
	var actualinterestamt ;
	var originalinterestamt;
	var actualprincpalamt;
	var originalprincpalamt;
	var isactualinterestamt;
    var totalamt;
    var totamt1 = val;
    var checkflag = document.forms[0].hidtotalamt.value;
    var monthsfrom = monfrval;
	if(document.forms[0].cmdedit.disabled)
	{
		var appno = document.forms[0].appno.value;
		var stratterm = document.forms[0].hidstartterms.value;
		var index = index;
		orginalamountOS = roundVal(document.forms[0].elements["txt_originalOSamt"+index].value);
		actualinterestamt= roundVal(document.forms[0].elements["txt_actualinterestamt"+index].value);
		originalinterestamt= roundVal(document.forms[0].elements["hidoriginalinterestamt"+index].value);
		actualprincpalamt=roundVal(document.forms[0].elements["txt_actualprincipalamt"+index].value);
		originalprincpalamt= roundVal(document.forms[0].elements["hidoriginalprincipalamt"+index].value);
		if(document.forms[0].hidtotalamt.value == "1")
		{		
		totalamt = roundVal(totamt1);
		}
		else
		{
        totalamt = roundVal(document.forms[0].elements["txt_totamt"+index].value);
        }
		if(checktrim(document.forms[0].elements["txt_actualinterestamt"+index].value)!="")
		{
			isactualinterestamt ="notnull";
		}
		else
		{
			isactualinterestamt ="null";
		}
   		{		document.all.ifrm.src=appURL+"action/iframerepayment.jsp?hidBeanGetMethod=calcRepayment1&hidBeanId=perapplicant&appno="+appno+"&isactualinterestamt="+isactualinterestamt+"&hidstartterms="+stratterm+"&hidendterms="+varendterm+"&index="+index+"&totterms="+varterm+"&interestrate="+varmodintrate+"&orginalamountOS="+orginalamountOS+"&actualinterestamt="+actualinterestamt+"&originalinterestamt="+originalinterestamt+"&actualprincpalamt="+actualprincpalamt+"&originalprincpalamt="+originalprincpalamt+"&totalamt="+totalamt+"&checkflag="+checkflag+"&monthsfrom="+monthsfrom;
		}
	}
 } 

function doPrevious()
{
	document.forms[0].hidrepaymenttype.value="repay";
	var var1 = document.forms[0].hidstartterms.value;
	if(eval(varstartterm) > 1)
	{
		if(vardbdata=="false")
		{
			document.forms[0].hidstartterms.value = eval(var1)-50;
			calculateAmountOS(eval(var1)-50);
		}
		else
		{
			document.forms[0].hidstartterms.value = eval(var1)-50;
			document.forms[0].method="post";
			document.forms[0].hidBeanGetMethod.value="calculateAmortization";
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].action=appURL+"action/repaymentschedule.jsp";	
			document.forms[0].submit();
		}
	}	
}

function doNext()
{
	document.forms[0].hidrepaymenttype.value="repay";
	var var1 = document.forms[0].hidstartterms.value;
	if(eval(varendterm) < eval(varterm))
	{	
		if(vardbdata=="false")
		{
			document.forms[0].hidstartterms.value = eval(var1)+50;
			calculateAmountOS(eval(var1)+50);
		}
		else
		{
			document.forms[0].hidstartterms.value = eval(var1)+50;
			document.forms[0].method="post";
			document.forms[0].hidBeanGetMethod.value="calculateAmortization";
			document.forms[0].hidBeanId.value="perapplicant";
			document.forms[0].action=appURL+"action/repaymentschedule.jsp";	
			document.forms[0].submit();
		}
	}
}

</script>
</head>
<body leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form name="amtfrm" class="normal">
  <iframe  height="0" width="0" id="ifrm" frameborder="0" style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
    <tr> 
      <td align="center"><b>Repayment Schedule</b></td>
    </tr>
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr align="center" class="dataheader"> 
            <td width="7%" > <b>Month</b></td>
            <td width="16%" > <b>Original Loan Amount OS</b></td>
            <td width="16%" > <b>Actual Interest Amt</b></td>
            <td width="19%" > <b>Actual Principal Amt</b></td>
            <td width="17%" > <b>Total Amount</b></td>
            <td width="25%" > <b>Actual Loan Amount OS</b></td>
          </tr>
          </table>
          <table  width="100%" cellspacing="0" cellpadding="3" class="outertable linebor">
          <%
		  for(int i = intstartterm; i<=intendtterm;i++)
		  {
		  if(arryRow!=null && arryRow.size()>0)
		  {
	        arryCol=(ArrayList)arryRow.get(i-1);
			if(arryCol!=null)
			{
			%>
          <tr class="datagrid"> 
            <td width="7%" align="center"> 
              <input name="txt_terms<%=i%>" type="text" value="<%=i%>" size="2" readOnly="readonly">
            </td>
            <td width="16%" align="center"> 
              <input name="txt_originalOSamt<%=i%>" type="text" value="<%=arryCol.get(1)%>" size="15" readOnly="readonly" style="text-align:right" maxlength="12">
            </td>
            <td width="16%" align="center"> 
              <input name="txt_actualinterestamt<%=i%>" type="text" value="<%=arryCol.get(2)%>" size="15" onBlur="" onKeyPress="allowDecimals(this)" readOnly="readonly" style="text-align:right" maxlength="12">
			  			  <input name="hidoriginalinterestamt<%=i%>" type="hidden" value="<%=arryCol.get(3)%>" size="8" readOnly="readonly" >
            <input name="hiddiffinterestamt<%=i%>" type="hidden" value="hidden" size="8" readOnly="readonly" >	  

				  </td>
            <td width="19%" align="center"> 
              <input name="txt_actualprincipalamt<%=i%>" type="text" value="<%=arryCol.get(4)%>" size="15" onBlur="" onKeyPress="allowDecimals(this)" readOnly="readonly" style="text-align:right" maxlength="12">
			               <input name="hidoriginalprincipalamt<%=i%>" type="hidden" value="<%=arryCol.get(5)%>" size="8" readOnly="readonly"  >
            <input name="hiddiffprincipalamt<%=i%>" type="hidden" value="" size="8"  readOnly="readonly"> 
           		 </td>
            <td width="17%" align="center"> 
              <input name="txt_totamt<%=i%>" type="text" value="<%=arryCol.get(6)%>" size="15" onBlur="checkInterestAmount('<%=i%>');calculateAmountOS('<%=i%>',this.value,'<%=i%>')" onKeyPress="allowDecimals(this)" style="text-align:right" maxlength="12">
            </td>
            <td width="25%" align="center"> 
              <input name="txt_actualOSamt<%=i%>" type="text" value="<%=arryCol.get(7)%>" size="15"  readOnly="readonly" style="text-align:right" maxlength="12">
            
		
            </td>
          </tr>
          <%		 }
			   }
			}
		%>
        </table>
      </td>
    </tr>
  </table>
  		          <%
		  for(int i=intendtterm+1; i<= (intendtterm+1);i++)
		  {
		  if(arryRow!=null && arryRow.size()>0)
		  {
			arryCol=(ArrayList)arryRow.get(i-2);
			if(arryCol!=null)
			{
			%>          
              <input type="hidden" name="txt_terms<%=i%>" value="<%=i%>" size="2" readOnly="readonly">     
              <input  type="hidden" name="txt_originalOSamt<%=i%>" value="<%=strrecmdamt%>"
				size="8" readOnly="readonly" >
              <input type="hidden" name="txt_actualinterestamt<%=i%>" size="8" onBlur="checkInterestAmount('<%=i%>');calculateAmountOS('<%=i%>')" onKeyPress="allowDecimals(this)" >
              <input type="hidden" name="hidoriginalinterestamt<%=i%>"  value="" size="8" readOnly="readonly" >
              <input type="hidden" name="hiddiffinterestamt<%=i%>"  size="8" readOnly="readonly" >
              <input  type="hidden" name="txt_actualprincipalamt<%=i%>"  size="8" 
			 onBlur="checkInterestAmount('<%=i%>');calculateAmountOS('<%=i%>')" onKeyPress="allowDecimals(this)" >
            <input type="hidden" name="txt_actualOSamt<%=i%>2" size="8"  readOnly="readonly" >
            <input name="txt_totamt<%=i%>2" type="hidden" size="8"  readOnly="readonly">
            <input type="hidden" name="hiddiffprincipalamt<%=i%>2"  size="8"  readOnly="readonly">
            <input type="hidden" name="hidoriginalprincipalamt<%=i%>2"  value="" size="8" readOnly="readonly"  >
  <%		 }	
			   }
			}
		%>
  <%String strappno = request.getParameter("appno");

		if(strappno.equalsIgnoreCase("new")){strappno ="";}
  %>
  <br>
    
  <table width="12%" border="0" align="center" cellpadding="0" cellspacing="0" class="outertable">
											<tr>
												<td><lapschoice:combuttonnew btnnames='Previous_Next_Edit_Save_Cancel_Delete_Audit Trail'
													btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
												</td>
											</tr>
										</table>
   
<INPUT TYPE="hidden" name="appno" value="<%=Helper.correctNull((String)hshValues.get("appno"))%>">
<INPUT TYPE="hidden" name="txtloan_modintrate" value="<%=Helper.correctNull((String)hshValues.get("txtloan_modintrate"))%>">
<INPUT TYPE="hidden" name="txtloan_reqterms" value="<%=Helper.correctNull((String)hshValues.get("txtloan_reqterms"))%>">
<INPUT TYPE="hidden" name="txtloan_sancamt" value="<%=Helper.correctNull((String)hshValues.get("txtloan_sancamt"))%>">
<INPUT TYPE="hidden" name="txt_installments" value="<%=Helper.correctNull((String)hshValues.get("txt_installments"))%>">
<INPUT TYPE="hidden" name="hidBeanGetMethod" value="">
<INPUT TYPE="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidSourceUrl" value="repaymentschedule.jsp">
<input type="hidden" name="hidAppType" value="">
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidrepaymenttype" value="">
<input type="hidden" name="hidmonthsfrom" value="">
<input type="hidden" name="hidmonthsto" value="">
<input type="hidden" name="hidtotalamt" value="">
<input type="hidden" name="hidstartterms" value="<%=hshValues.get("hidstartterms")%>">
<input type="hidden" name="hidendterms" value="">
<input type="hidden" name="radLoan" value="">
<input type="hidden" name="page" value="">
<input type="hidden" name="hidSerFlag" value="<%=strServicingFlag%>">

</form>
</body>
</html>
