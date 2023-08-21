<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css"/>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var strReviewYear = "<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strUserId='<%=(String)session.getAttribute("strUserId")%>';
var strprocessby="<%=Helper.correctNull((String)hshValues.get("MON_TERMLOANREVIEW_TOUSRID"))%>";
var strstatus="<%=Helper.correctNull((String)hshValues.get("review_status"))%>";


var selInstallment="<%=Helper.correctNull((String)hshValues.get("installment"))%>";
var selInterest="<%=Helper.correctNull((String)hshValues.get("interest"))%>";
var selDocuments="<%=Helper.correctNull((String)hshValues.get("documents"))%>";
var strReviewYear="<%=Helper.correctNull((String)hshValues.get("strReviewYear"))%>";
var strreview_status="<%=Helper.correctNull((String)hshValues.get("review_status"))%>";


var strClassification = "<%=Helper.correctNull((String)hshValues.get("assetclasification"))%>";

function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		//document.forms[0].cmdNew.disabled=false;
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose2.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 //document.forms[0].cmdNew.disabled=true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose2.disabled=true;	 
		 disableFields(false);
	}
	if(val=="new")
	{	 
		 //document.forms[0].cmdNew.disabled=true;
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=true;
		 document.forms[0].cmdapply.disabled=false;
		 document.forms[0].cmdcancel.disabled=false;		 
		 document.forms[0].cmdclose2.disabled=true;	 
		 disableFields(false);
	}
	

}
function callCalender(fname)
 {
	 if(document.forms[0].cmdapply.disabled==false)
	 { 
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
	 }
 }


function onLoading()
{
	
	disableCommandButtons("load");
	
	document.forms[0].reviewYear.disabled = false;
	
	if(selInstallment!="")
	document.forms[0].selInstallment.value = selInstallment;
	
	if(selInterest!="")
	document.forms[0].selInterest.value = selInterest;
	
	if(selDocuments!="")
	document.forms[0].selDocuments.value = selDocuments;
	
	if(strReviewYear!="")
	document.forms[0].reviewYear.value = strReviewYear;
	
	if(strClassification!="")
	document.forms[0].txt_assetclasification.value = strClassification;
	changeinstallment();
	changeinterest();
	
}

function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateReviewNoteTermLoan";
			document.forms[0].hidBeanGetMethod.value="getReviewNoteTermLoan";
			document.forms[0].hidBeanId.value="reviewtermloan";
			document.forms[0].hidSourceUrl.value="action/reviewnotecorporatepersonal.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
		}
}
function doEdit()
{ 	
	if(document.forms[0].reviewYear.value=="")
	{
		alert("Select Review Year");
		return;
	}	
	disableFields(false);
    document.forms[0].hidAction.value ="update";
	disableCommandButtons("edit");
}

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="reviewnotecorporatepersonal.jsp";
		document.forms[0].hidBeanId.value="reviewtermloan";
		//document.forms[0].hidBeanMethod.value="updateReviewNoteTermLoan";
		document.forms[0].hidBeanGetMethod.value="getReviewNoteTermLoan";
		document.forms[0].action=appUrl +"action/reviewnotecorporatepersonal.jsp";
	    document.forms[0].submit();	
	}	
}

	function doSave()
	{
	   document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanMethod.value="updateReviewNoteTermLoan";
		document.forms[0].hidBeanGetMethod.value="getReviewNoteTermLoan";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/reviewnotecorporatepersonal.jsp";
		document.forms[0].submit();
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
		if(document.forms[0].elements[i].type=='textarea')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}
		 
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
		
	}
}
function callLink(page,bean,method)
{
	
	 if (document.forms[0].cmdapply.disabled)
		{
			document.forms[0].hidSourceUrl.value=page;
			document.forms[0].hidBeanGetMethod.value=method;
			document.forms[0].hidBeanId.value=bean;
			document.forms[0].action=appUrl+"action/"+page;
			document.forms[0].submit();
		}
	else
		{
			ShowAlert(103);
		}
}
function callLink1(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appUrl+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
}

function changeinstallment()
{
	if(document.forms[0].selInstallment.value=="1")
	{
	  document.all["installment"].style.display="none";
	  document.forms[0].txt_installremarks.value="";
	}
	else
	{
	    document.all["installment"].style.display="table-row";	
	}	
}


function changeinterest()
{
	if(document.forms[0].selInterest.value=="1")
	{
	  document.all["interest"].style.display="none";
	  document.forms[0].txt_interestremarks.value="";
	}
	else
	{
	    document.all["interest"].style.display="table-row";	
	}	
}
</script>

</head>

<body onload="onLoading()">

<form name="frmTLReviewcorp" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					
            <td> 
              <table width="77%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr> 
                  <td width="25%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotetypeofreview.jsp','reviewtermloan','getTypeReviewTermLoan')" class="blackfont">Account 
                    Type</a></b> </font></td>
                  <td width="13%" align="center" bgcolor="#E EEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviwnotecompanycorporate.jsp','reviewtermloan','getReviewCorpCompany')" class="blackfont">Company</a></b> 
                    </font> </td>
                  <td width="13%" align="center" bgcolor="#71694F"><font size="1" face="MS Sans Serif" color="#000000"><b><font color="#FFFFFF">Review 
                    Note</font></b></font> </td>
                  <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")){%>
                  <td width="13%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotecorporatefinancial.jsp','reviewtermloan','getReviewFinancial')" class="blackfont">Finacial</a></b> 
                    </font> </td>
                  <%}%>
                  <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("1")){%>
                  <td width="14%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotesmefinancial.jsp','reviewtermloan','getReviewFinancial')" class="blackfont">Finacial</a></b> 
                    </font> </td>
                  <%}%>
                  <td width="22%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnoteworkflowhistroy.jsp','commworkflow','getTermLoanReviewHistory')" class="blackfont">Workflow</a></b> 
                    </font> </td>
                </tr>
              </table>
            </td>
				</tr>
			</table>
		</td>
	</tr>
</table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
           
      <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
        -&gt; Monitoring -&gt; Term Loan - Review-&gt;Review Note</font></i></b></td>
          </tr>
        </table>
 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					<td>
						<laps:MonitorReview />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table>   


        
  <table width="100%" border="1" cellspacing="0" cellpadding="4" align="center" bordercolordark="#DEDACF" bordercolorlight="#FFFFFB">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="5" cellpadding="3" align="center" bordercolordark="#DEDACF" bordercolorlight="#FFFFFB">
         
         
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Name of the Account</td>
            <td width="60%">&nbsp;<%=Helper.decodeAmpersand(Helper.correctNull((String)hshValues.get("strappname")))%> 
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Activity</td>
            <td width="60%">
			  <textarea name="txtActivity" onKeyUp="textlimit(this,99)" onKeyPress="textlimit(this,99)" cols="60" rows="2"><%=Helper.correctNull((String)hshValues.get("activity"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="5%" height="40">&nbsp;</td>
            <td width="35%" height="40">Dealing with Bank since</td>
            <td width="60%" height="40">&nbsp;<%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%> 
              <input type="hidden" name="hidBankSince" value="<%=Helper.correctNull((String)hshValues.get("personal_bankingsince"))%>">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Asset Classification</td>
            <td width="60%">&nbsp;<select name="txt_assetclasification" >
                          <option value="0">--select--</option>
                          <laps:StaticDataNewTag apptype="31" /> 
                        </select></td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Renewal Due</td>
            <td width="60%">&nbsp;<%=Helper.correctNull((String)hshValues.get("LIMIT_REVIEWDATE"))%>
<input type="hidden" name="hidReviewDate" value="<%=Helper.correctNull((String)hshValues.get("LIMIT_REVIEWDATE"))%>">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Credit facilities since</td>
             <td width="60%">&nbsp;
             <input type="text" name="txt_datecredit" size="20" maxlength="20"  value="<%=Helper.correctNull((String)hshValues.get("datecredit"))%>">
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="3">
                <tr> 
                  <td align="center">Name of Facility</td>
                  <td align="center">Limit</td>
                  <td align="center">O/S Amount</td>
                  <td align="center">Nature &amp; values of Security</td>
                  <td align="center">Overdue,if any</td>
                </tr>
                <tr> 
                  <td width="20%">&nbsp;<%=Helper.correctNull((String)hshValues.get("strfacility"))%> 
				  <input type="hidden" name="hidFacilityname" value="<%=Helper.correctNull((String)hshValues.get("strfacility"))%>">
                  </td>
                  <td width="20%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("LIMIT_SANCTAMT"))%> 
				  <input type="hidden" name="hidFacilitylimit" value="<%=Helper.correctNull((String)hshValues.get("LIMIT_SANCTAMT"))%>">
                  </td>
                  <td width="20%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%>
                    <input type="hidden" name="hidOSAmt" value="<%=Helper.correctNull((String)hshValues.get("FUND_OSAMT"))%>">
                    
                  </td>
                  <td width="20%"><b> 
                    <textarea name="txtNatureValSecurity"  onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="30" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("natureValSecurity"))%></textarea>
                    </b></td>
                  <td width="20%" align="right">&nbsp;<%=Helper.correctNull((String)hshValues.get("FUND_OVERDUEAMT"))%>
                    <input type="hidden" name="hidOverDue" value="<%=Helper.correctNull((String)hshValues.get("FUND_OVERDUEAMT"))%>">
                    
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Purpose of loan</td>
            <td width="60%">
			<textarea name="txt_purposeofloan" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("purposeofloan"))%></textarea>
			</td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Present status of the Project</td>
            <td width="60%"> 
              <textarea name="txtPresentStatusPrj" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual"><%=Helper.correctNull((String)hshValues.get("presentStatusPrj"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Operation in CD Account</td>
            <td width="60%"> 
              <textarea name="txtOperationCDAcc" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("operationCDAcc"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td colspan="3"> 
              <table width="100%" border="1" cellspacing="0" cellpadding="3">
                <tr> 
                  <td align="center">Maximum Debit(Rs.)</td>
                  <td> 
                    <input type="text" name="txtMaxDebit" onKeyPress="allowNumber(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("maxDebit"))%>">
                  </td>
                  <td align="center">Maximum Credit(Rs.)</td>
                  <td > 
                    <input type="text" name="txtMaxCredit" onKeyPress="allowNumber(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("maxCredit"))%>">
                  </td>
                </tr>
                <tr> 
                  <td width="20%" align="center">Minimum Debit(Rs.)</td>
                  <td width="20%"> 
                    <input type="text" name="txtMinDebit" onKeyPress="allowNumber(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("minDebit"))%>">
                  </td>
                  <td width="20%" align="center">Minimum Credit(Rs.)</td>
                  <td><b> 
                    <input type="text" name="txtMinCredit" onKeyPress="allowNumber(this)" maxlength="10" value="<%=Helper.correctNull((String)hshValues.get("minCredit"))%>">
                    </b></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%">&nbsp;</td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">No. of Days in Debit</td>
            <td width="60%"> 
              <input type="text" name="txtDaysDebit" onKeyPress="allowNumber(this)" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("daysDebit"))%>"> 
            </td>
          </tr>
		  <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">No. of Days in Credit</td>
            <td width="60%"> 
              <input type="text" name="txtDayscredit" onKeyPress="allowNumber(this)" maxlength="3" value="<%=Helper.correctNull((String)hshValues.get("daysCredit"))%>">
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Operations in Term Loan A/C</td>
            <td>
              <textarea name="txtOperTermLoanACC" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("operTermLoanACC"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td >&nbsp;</td>
            <td >Date of First disbursement</td>
            <td >
              <table width="35%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="32%"> 
                    <input type="text" name="txtfirstdisbursement" size="13" onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("disbursementdate"))%>">
                  </td>
                  <td width="68%"><a alt="Select date from calender" href="#" 
																	onClick="callCalender('txtfirstdisbursement')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Repaymemt Schedule</td>
            <td> 
              <textarea name="txtRepaySchedule" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("repaySchedule"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Whether installment are paid regularly?</td>
            <td>&nbsp; 
              <select name="selInstallment" onChange="changeinstallment()">
                <option value="1" selected>Yes</option>
                <option value="2">No</option>
				<option value="3">NA</option>
              </select>
			  
            </td>
          </tr>
		  <tr id="installment"> 
            <td>&nbsp;</td>
            <td>Remarks</td>
            <td>&nbsp; 
              <textarea name="txt_installremarks" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual"><%=Helper.correctNull((String)hshValues.get("installremarks"))%></textarea>
			  
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Whether interest serviced regularly?</td>
            <td>&nbsp; 
              <select name="selInterest" onChange="changeinterest()">
                <option value="1" selected>Yes</option>
                <option value="2">No</option>
				<option value="3">NA</option>
              </select>
            </td>
            </tr>
          <tr id="interest">
		     <td>&nbsp;</td>
            <td>Remarks</td>
            <td>&nbsp; 
              <textarea name="txt_interestremarks" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("interestremarks"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Compliance to terms of sanction</td>
            <td> 
              <textarea name="txtCompliance" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("compliance"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Completion of Mortgage formalities</td>
            <td> 
              <textarea name="txtCompletionMort" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("completionMort"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Registration of Charges with ROC /Date of last search report held 
              on records</td>
            <td> 
              <textarea name="txtRegistCharge" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("registCharge"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Whether documents are valid and in force</td>
            <td> 
              <select name="selDocuments">
                <option value="1" selected>Yes</option>
                <option value="2">No</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Date of last DBC obtained</td>
            <td>&nbsp;<%=Helper.correctNull((String)hshValues.get("dbc_date"))%> 
              <input type="hidden" name="hidDBCDate" value="<%=Helper.correctNull((String)hshValues.get("dbc_date"))%>">
              
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Details of Collateral Security and value Date of last valuation 
            </td>
            <td> 
              <textarea name="txtCollSecurityDet" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("collSecurityDet"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Date of last inspection of securities</td>
            <td> 
              <table width="35%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="34%"> 
                    <input type="text" name="txtInspectionDate" size="13" onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("inspectionDate"))%>">
                  </td>
                  <td width="66%"><a alt="Select date from calender" href="#" 
																	onClick="callCalender('txtInspectionDate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Whether securities are adequately insured and valid policy held 
              on record</td>
            <td> 
              <textarea name="txtSecAdequtely" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("secAdequtely"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Observation of the Inspecting official/Irregularities if any and 
              compliance thereof</td>
            <td> 
              <textarea name="txtInspectingOfficial" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual"><%=Helper.correctNull((String)hshValues.get("inspectingOfficial"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Audit Observation &amp; Compliance thereof </td>
            <td> 
              <textarea name="txtAuditObserv" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("auditObserv"))%></textarea>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>Recommendations</td>
            <td> 
              <textarea name="txtRecommendation" onKeyUp="textlimit(this,3999)" onKeyPress="textlimit(this,3999)" rows="3" cols="70" wrap="virtual" ><%=Helper.correctNull((String)hshValues.get("recommendation"))%></textarea>
            </td>
          </tr>
         <tr> 
            <td width="3%">&nbsp;</td>
            <td width="37%">Next Review Date</td>
            <td width="60%">
<table width="35%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="36%"> 
                    <input type="text" name="txtnextreviedate" size="13" onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("nextreveiwdate"))%>">
                  </td>
                  <td width="64%"><a alt="Select date from calender" href="#" 
																	onClick="callCalender('txtnextreviedate')"
																	onMouseOver="window.status='Date Picker';return true;"
																	onMouseOut="window.status='';return true;"><img
																	src="<%=ApplicationParams.getAppUrl()%>img/calen.gif"
																	border=0 alt="Select date from calender"></a> 
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
          </tr>
          
        </table>
    

<table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
	<tr> 
    	<td> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="2">
        	<tr>
				<td align="center"><input type="button" name="cmdedit" value="Edit"
					class="buttonStyle"
					onclick="doEdit()"></td>
				<td align="center"><input type="button" name="cmdapply"
					value="Save"
					class="buttonStyle"
					onclick="doSave()"></td>
				<td align="center"><input type="button" name="cmdcancel"
					value="Cancel"
					class="buttonStyle"
					onclick="doCancel()"></td>
				<td align="center"><input type="button" name="cmddel"
					value="Delete"
					class="buttonStyle"
					onclick="doDelete()"></td>
					<td align="center">	
						<input type="button" name="cmdclose2"
			value="Close"
			class="buttonClose"
			onclick="doClose()">
			</td>
					</tr>
					
			</table>
		</td>
	</tr>
</table>

<input type="hidden" name="hidAction" />
<input type="hidden" name="hidBeanId" />
<input type="hidden" name="hidBeanMethod" value="" />
<input type="hidden" name="hidBeanGetMethod" value="" />
<input type="hidden" name="hidSourceUrl" />
<input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>"> 
</form>
</body>
</html>
