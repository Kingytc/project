<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>TakeOver Details</title>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/pertakeover.js"></script>
<script>
var regular_loan="<%=Helper.correctNull((String)hshValues.get("regular_loan"))%>";
var sel_transbank="<%=Helper.correctNull((String)hshValues.get("sel_transbank"))%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var varRecordFlag="<%=Helper.correctNull((String)hshValues.get("recordflag"))%>";
var varTakeOver="<%=Helper.correctNull((String)hshValues.get("strPagefrom"))%>";
</script>
</head>
<body leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onload="callonload()">
<form name="colForm" method="post" action="" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td id="mainlnk" colspan="2"><lapschoice:application /></td>
    </tr>
  </table>
  <br>
  <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td width="19%">Loan From Bank / Financial Institution  <span class="mantatory">*</span>
        <input
			type="hidden" name="loan_frombank" value="<%=Helper.correctNull((String)hshValues.get("loan_frombank"))%>">
        <input
			type="hidden" name="txt_bankid" value="<%=Helper.correctNull((String)hshValues.get("loan_bankid"))%>">
      </td>
      <td width="24%"> 
        <input
			type="text" name="loan_fininst" size="30" maxlength="30"
			value="<%=Helper.correctNull((String)hshValues.get("loan_fininst"))%>"> <a href="#" onClick="callBankmaster('147')" style="cursor: hand">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
				</a>
      </td>
      <td width="18%">Reason for to shifting to our Bank <span class="mantatory">*</span></td>
      <td width="20%"> 
        <input type="text" name="txt_shifting_reason" size="30" maxlength="50"
			onkeypress="allowAlphaNumericSpace()" value="<%=Helper.correctNull((String)hshValues.get("shifting_reason"))%>">
      </td>
    </tr>
    <tr> 
      <td width="19%">Loan Amount From Transferor Bank/FI</td>
      <td width="24%"> <lapschoice:CurrencyTag name="loanamt_transbank"
			onKeyPress="allowNumber(document.forms[0].loanamt_transbank)" maxlength="12"
			value='<%=Helper.correctNull((String)hshValues.get("loanamt_transbank"))%>' /> 
      </td>
      <td width="18%">Date of Availing Loan /First Disbursal <span class="mantatory">*</span></td>
      <td width="20%"> 
        <table width="30%" cellspacing="0" cellpadding="3">
          <tr> 
            <td> 
              <input
				type="text" name="avail_date" size="11"
				value="<%=Helper.correctNull((String)hshValues.get("avail_date"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td> <a href="#" onClick="callCalender('avail_date')"
				title="Click to view calender" border="0"><img
				src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
				height="22" border="0" tabindex="7"></a></td>
          </tr>
        </table>
    </tr>
    <tr> 
      <td width="19%" rowspan="2">Installment Stipulated by Transferor Bank/FI</td>
      <td width="24%" rowspan="2"> 
        <input type="text" name="installamt_transbank" style="text-align:right" maxlength="12"
			onKeyPress="allowNumber(document.forms[0].installamt_transbank)" value="<%=Helper.correctNull((String)hshValues.get("installamt_transbank"))%>" >
        <select name="sel_transbank" size="1">
          <option value="0" selected>--Select--</option>
          <option value="1">Monthly</option>
          <option value="2">Quarterly</option>
        </select>
      </td>
      <td width="18%">From Date / Installment Start Date</td>
      <td width="20%"> 
        <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input
			type="text" name="fromdate" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("fromdate"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td><a
			href="#" onClick="callCalender('fromdate')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="22" border="0" tabindex="7"></a></td>
          </tr>
        </table>
        </td>
    </tr>
    <tr>
    <td>Due Date / Last Installment Date<span class="mantatory">*</span></td>
    <td>
    <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input
			type="text" name="txt_due_date" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("due_date"))%>" onBlur="checkmindate(this,currdate)">
            </td>
            <td><a
			href="#" onClick="callCalender('txt_due_date')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
			height="22" border="0" tabindex="7"></a></td>
          </tr>
        </table>
    </td>
    </tr>
    <tr> 
      <td width="19%">Holiday Period</td>
      <td width="24%"> 
        <input type="text" name="txt_holiday_period"
			onKeyPress="allowInteger()" maxlength="5" size="10"
			value="<%=Helper.correctNull((String)hshValues.get("holiday_period"))%>" style="text-align:right">
        Months</td>
      <td width="18%">Total Repayment Period <span class="mantatory">*</span></td>
      <td width="20%"> 
        <input type="text" name="repay_period"
			onKeyPress="allowInteger()" maxlength="5" size="10"
			value="<%=Helper.correctNull((String)hshValues.get("repay_period"))%>" style="text-align:right">
        Months</td>
    </tr>
    <tr> 
      <td width="19%">Rate of Interest</td>
      <td width="24%"> 
        <input type="text" name="txt_rate_of_interest"
			onKeyPress="allowDecimals(this)" maxlength="5" size="10" onblur="roundtxt(this)"
			value="<%=Helper.correctNull((String)hshValues.get("rate_of_interest"))%>" style="text-align:right">
        &nbsp;%</td>
      <td width="18%">&nbsp;</td>
      <td width="20%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="19%">Total Liability</td>
      <td width="24%"> 
        <p> <lapschoice:CurrencyTag name="tot_liability"
			onKeyPress="allowNumber(document.forms[0].tot_liability)" maxlength="15"
			value='<%=Helper.correctNull((String)hshValues.get("tot_liability"))%>'/> 
          &nbsp;</p>
      </td>
      <td width="18%">As On Date</td>
      <td width="20%"> 
        <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input
			type="text" name="ason_date" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("ason_date"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td> <a href="#" onClick="callCalender('ason_date')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" 
			border="0" tabindex="7"></a> </td>
          </tr>
        </table>
    </tr>
    <tr> 
      <td width="19%">No of Installments Paid</td>
      <td width="24%"> 
        <input type="text" name="no_installpaid" maxlength="3" 
			value="<%=Helper.correctNull((String)hshValues.get("no_installpaid"))%>" onKeyPress="allowInteger()" style="text-align:right">
      </td>
      <td width="18%"> Upto Date </td>
      <td width="20%" valign="top"> 
        <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input type="text" name="uptodate"
			size="11"
			value="<%=Helper.correctNull((String)hshValues.get("uptodate"))%>">
            </td>
            <td> <a
			href="#" onClick="callCalender('uptodate')"
			title="Click to view calender" border=0><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" 
			 border="0" tabindex="7"></a> </td>
          </tr>
        </table>
    </tr>
    <tr> 
      <td width="19%">Whether Loan A/c is Regular</td>
      <td width="24%"> 
        <select name="regular_loan">
          <option value="0" selected>--Select--</option>
          <option value="1">Yes</option>
          <option value="2">No</option>
        </select>
      </td>
      <td width="18%">&nbsp;</td>
      <td width="20%">&nbsp;</td>
    </tr>
    <tr> 
      <td nowrap width="19%"><b>Overdue Amount</b></td>
      <td width="24%"><lapschoice:CurrencyTag name="tot_overdue"  maxlength="15" onKeyPress="allowNumber(document.forms[0].tot_overdue)" value='<%=Helper.correctNull((String)hshValues.get("tot_overdue"))%>' /> 
      </td>
      <td width="18%">As On Date</td>
      <td width="20%"> 
        <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input
			type="text" name="Overason_date" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("Overason_date"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td> <a href="#" onClick="callCalender('Overason_date')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" 
			border="0" tabindex="7"></a> </td>
          </tr>
        </table>
    </tr>
    <tr> 
      <td width="19%">Amount to be Paid Transferor Bank/FI For Takeover</td>
      <td width="24%"><lapschoice:CurrencyTag name="takeover_amtpaid" maxlength="10"
			onKeyPress="allowNumber(document.forms[0].takeover_amtpaid)"
			value='<%=Helper.correctNull((String)hshValues.get("takeover_amtpaid"))%>' /> 
      </td>
      <td width="18%">Details of opinion/report obtained from the previous Bank 
        and observations there on</td>
      <td width="20%"> 
        <textarea name="txtar_prev_bank_opinion" rows="5" cols="40" onkeydown="textlimit(this,400)" onkeyup="textlimit(this,400)"><%=Helper.correctNull((String)hshValues.get("prev_bank_opinion"))%></textarea>
      </td>
    </tr>
    <tr> 
      <td colspan="3">Statement of account from previous Banker is obtained and verified for 
        period covering from</td>
      <td> 
	   <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
        <table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td> 
              <input
			type="text" name="txt_stmt_dt_from" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("stmt_from_date"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td> <a href="#" onClick="callCalender('txt_stmt_dt_from')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" 
			border="0" tabindex="7"></a> </td>
			</tr>
			</table>
			</td>
			<td>to</td> 
            <td>
			<table width="30%" cellspacing="0" cellpadding="3" class="outertable">
          <tr> 
            <td>  
              <input
			type="text" name="txt_stmt_dt_to" size="11"
			value="<%=Helper.correctNull((String)hshValues.get("stmt_to_date"))%>" onBlur="checkmaxdate(this,currdate)">
            </td>
            <td> <a href="#" onClick="callCalender('txt_stmt_dt_to')"
			title="Click to view calender" border="0"><img
			src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif" 
			border="0" tabindex="7"></a> </td></tr></table></td>
          </tr>
        </table>
      </td>
	  </tr>
	  <tr>
      <td>Comments</td>
      <td colspan="3">
        <textarea name="txtar_comments_statement" rows="4" cols="100" onkeydown="textlimit(this,400)" onkeyup="textlimit(this,400)"><%=Helper.correctNull((String)hshValues.get("stmt_comments"))%></textarea>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
  <BR>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidsno" value="">
  <INPUT TYPE="hidden" name="radLoan" value="Y">
</form>
</body>
</html>
