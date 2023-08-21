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
var mon_status_account =  "<%=Helper.correctNull((String)hshValues.get("mon_status_account"))%>";

var mon_banking =  "<%=Helper.correctNull((String)hshValues.get("mon_banking"))%>";

var reviewOf = "<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>";


function disableCommandButtons(val)
{
	if(val=="load")
	{  
		disableFields(true);
		document.forms[0].cmdedit.disabled=false;
		document.forms[0].cmddel.disabled=true;
		document.forms[0].cmdapply.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmdclose2.disabled=false;	
	}
	
	if(val=="edit")
	{	 
		 document.forms[0].cmdedit.disabled=true;
		 document.forms[0].cmddel.disabled=false;
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
	 <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")){%>
	if(mon_status_account!="")
	{
		document.forms[0].status_account.value=mon_status_account;
	}
	else
	{
		document.forms[0].status_account.value="0";
	}
	if(mon_banking!="")
	{
		document.forms[0].txt_banking.value=mon_banking;
	}
	else
	{
		document.forms[0].txt_banking.value="0";
	}
	changeArrangement();
	document.forms[0].reviewYear.disabled = false;
	<%}%>
}

function changeArrangement()
{
	if(document.forms[0].txt_banking.value=="2")
	{
		document.all["leadbank"].style.display="table-row";
		document.all["ourshare"].style.display="table-row";
	}
	else
	{
		document.forms[0].txt_branch.value="";
		document.forms[0].txt_sharepercent.value="";		
		document.all["leadbank"].style.display="none";
		document.all["ourshare"].style.display="none";
	}	
}
function doDelete()
{
	if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";		
			document.forms[0].hidBeanMethod.value="updateReviewCorpCompany";
			document.forms[0].hidBeanGetMethod.value="getReviewCorpCompany";
			document.forms[0].hidBeanId.value="reviewtermloan";
			document.forms[0].hidSourceUrl.value="action/reviwnotecompanycorporate.jsp";	
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

/*function doNew()
{ 	
	disableFields(false);
    document.forms[0].hidAction.value ="insert";
	disableCommandButtons("new");	
	document.forms[0].reviewYear.disabled = true;
	clearAll();
}*/

function doCancel()
{  
	if(ConfirmMsg(102))
	{
		//document.forms[0].hidSourceUrl.value="reviwnotecompanycorporate.jsp";
		document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanGetMethod.value="getReviewCorpCompany";
		document.forms[0].action=appUrl +"action/reviwnotecompanycorporate.jsp";
	    document.forms[0].submit();	
	}	
}

	function doSave()
	{
	   document.forms[0].hidBeanId.value="reviewtermloan";
		document.forms[0].hidBeanMethod.value="updateReviewCorpCompany";
		document.forms[0].hidBeanGetMethod.value="getReviewCorpCompany";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/reviwnotecompanycorporate.jsp";
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
			document.forms[0].elements[i].disabled=val;
		}
		 
	}
	
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		//document.forms[0].hidmontype.value = "MONITREVIEW";
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


</script>

</head>

<body text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px" onload="onLoading()">
<form name="safaeri3" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr>
					
            <td> 
              <table width="75%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr> 
                  <td width="20%%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotetypeofreview.jsp','reviewtermloan','getTypeReviewTermLoan')" class="blackfont">Account Type</a></b> </font></td>
                  <td width="20%" align="center" bgcolor="#71694F"> <font size="1" face="MS Sans Serif"><b> 
                   <font color="#FFFFFF"> Company</font></b></font></td>
                  <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("0")){%>
                  <td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewNoteTermLoan.jsp','reviewtermloan','getReviewNoteTermLoan')" class="blackfont">Review 
                    Note</a></b> </font> </td>
                  <%}else{%>
                  <td width="20%%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotecorporatepersonal.jsp','reviewtermloan','getReviewNoteTermLoan')" class="blackfont">Review 
                    Note</a></b> </font> </td>
                  <%}%>
                  <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")){%>
                  <td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotecorporatefinancial.jsp','reviewtermloan','getReviewFinancial')" class="blackfont">Finacial</a></b> 
                    </font> </td>
                  <%}%>
                  <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("1")){%>
                  <td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
                    <a href="JavaScript:callLink1('reviewnotesmefinancial.jsp','reviewtermloan','getReviewFinancial')" class="blackfont">Finacial</a></b> 
                    </font> </td>
                  <%}%>
                  <td width="20%" align="center" bgcolor="#EEEAE3"> <font size="1" face="MS Sans Serif"><b> 
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
        -&gt; Monitoring -&gt; Term Loan - Review</font><font face="Times New Roman, Times, serif" size="3">-&gt; 
        Company </font></i></b></td>
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
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" bordercolordark="#DEDACF" bordercolorlight="#FFFFFB">
          <%if(Helper.correctNull((String)request.getParameter("reviewOf")).equals("2")){%>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Group</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="text" name="txt_group" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_group"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Banking</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <select name="txt_banking" onChange="changeArrangement()">
                <option value="s">--Select--</option>
                <option value="1">Sole</option>
                <option value="2">Consortium</option>
                <option value="3">Multiple</option>
              </select>
            </td>
          </tr>
          <tr id="leadbank"> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Lead Bank</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="text" name="txt_branch" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_leadbank"))%>'>
            </td>
          </tr>
          <tr  id="ourshare"> 
            <td width="5%" height="30">&nbsp;</td>
            <td width="35%" height="30">Our Share (%)</td>
            <td width="60%" height="30">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="text" name="txt_sharepercent" size="7" value="<%=Helper.correctNull((String)hshValues.get("mon_sharepercent"))%>" onBlur="roundtxt(txt_sharepercent);checkPercentage(this)" onKeyPress="allowNumber(this)">
            </td>
          </tr>
        
         <%--  <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Month Of Review</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="text" name="txt_monthreview" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_review"))%>'  tabindex="8">
            </td>
          </tr>
              <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Asset Classification</td>
            <td width="60%"> &nbsp; 
              <input type="text" name="txt_accountclassification" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_accountclassification"))%>'  tabindex="8">
            </td>
          </tr>--%>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Internal Credit Rating</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <input type="text" name="txt_creditrating" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_creditrating"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Status of Account</td>
            <td width="60%">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
              <select name="status_account">
                <option value="0" selected>Regular </option>
                <option value="1">Eas-I</option>
                <option value="2">Eas-II</option>
                <option value="3">SMA</option>
              </select>
            </td>
          </tr>
          <%}%>
            <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">Date For Proposal</td>
            <td width="60%"> 
              <table width="35%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td width="42%"> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                    <input type="text" name="txt_dateprposal" size="13" onBlur="checkDate(this)" value="<%=Helper.correctNull((String)hshValues.get("dateproposal"))%>">
                  </td>
                  <td width="58%"><a alt="Select date from calender" href="#" 
																	onClick="callCalender('txt_dateprposal')"
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
            <td width="5%">&nbsp;</td>
            <td width="35%">Names of the Directors / Partners</td>
            <td width="60%"> 1.&nbsp;&nbsp; 
              <input type="text" name="partner" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner1"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%">2.&nbsp;&nbsp; 
              <input type="text" name="partner1" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner2"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 3.&nbsp;&nbsp; 
              <input type="text" name="partner2" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner3"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 4.&nbsp;&nbsp; 
              <input type="text" name="partner3" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner4"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 5.&nbsp;&nbsp; 
              <input type="text" name="partner4" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner5"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%" height="33">&nbsp;</td>
            <td width="35%" height="33">&nbsp;</td>
            <td width="60%" height="33"> 6.&nbsp;&nbsp; 
              <input type="text" name="partner5" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner6"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 7.&nbsp;&nbsp; 
              <input type="text" name="partner6" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner7"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 8.&nbsp;&nbsp; 
              <input type="text" name="partner7" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner8"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%"> 9.&nbsp;&nbsp; 
              <input type="text" name="partner8" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner9"))%>'  tabindex="8">
            </td>
          </tr>
          <tr> 
            <td width="5%">&nbsp;</td>
            <td width="35%">&nbsp;</td>
            <td width="60%">10. 
              <input type="text" name="partner9" size="30" maxlength="50" value='<%=Helper.correctNull((String)hshValues.get("mon_partner10"))%>'  tabindex="8">
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
				<!--<td align="center"><input type="button" name="cmdNew" value="New"
					class="buttonStyle"
					onclick="doNew()"></td>-->
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
				<!--<td align="center"><input type="button" name="cmdprint"
					value="Print"
					class="buttonHelp"
					onclick="doPrint()"></td>-->
						
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

