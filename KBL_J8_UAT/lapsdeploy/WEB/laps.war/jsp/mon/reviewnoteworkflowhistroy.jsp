<%@include file="../share/directives.jsp"%>
<%
   	ArrayList arrFromUsr=(ArrayList)hshValues.get("arrFromUsr");
   	ArrayList arrToUsr=(ArrayList)hshValues.get("arrToUsr");
   	ArrayList arrDate=(ArrayList)hshValues.get("arrDate");
  	String strmoduletype=Helper.correctNull((String)request.getParameter("hidmoduletype"));
	String chkstatus = Helper.correctNull((String)hshValues.get("Stateflag"));
	
%>
<html>
<head>
<title>Review Term Loan - Work Flow</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var chkstatus="<%=chkstatus%>";
var reviewOf = "<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>"
function callOnload()
{
	if(chkstatus=="1")
 	{
		alert("Application is Approved");
		
	}
}

function callOtherTab(val)
{
	if(val=="action")
	{
		document.forms[0].hidBeanGetMethod.value="getTermLoanReview";
		document.forms[0].hidBeanId.value="commworkflow";
		document.forms[0].action=appURL+"action/reviewnoteworkflow.jsp";
		document.forms[0].submit();
	}
}

function callLink(page,bean,method)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value=bean;
	document.forms[0].action=appURL+"action/"+page;
	document.forms[0].submit();
}

function callClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/mon_borrowersearch.jsp?hidmontype=MONITREVIEW";
		document.forms[0].submit();
	}
}

function dohlp()     
{
  	var hlpvar = appURL+"phlp/loan_appretail_workflow_his.htm";
  	var title = "History";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}
 
function callRemarks()
{
	var cbsid = document.forms[0].cbsid.value;
	var mon_month = document.forms[0].mon_month.value;
	var mon_year = document.forms[0].mon_year.value;
	
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appURL+"action/mon_termloanreviewcomments.jsp?cbsid="+cbsid+"&mon_month="+mon_month+"&mon_year="+mon_year+"&hiduserid="+strUserId+"&hidtoUser="+document.forms[0].mail_tousrid.value+"&editoption="+document.forms[0].hideditoption.value+"&hidBeanId=mailboxcomments"+"&hidBeanGetMethod=getReviewTermLoanData";
	window.open(url,"remarks",prop);
}
function callOtherLink(page,bean,method)
{
	if(!document.forms[0].reviewYear.value=="")
	{
		document.forms[0].hidSourceUrl.value=page;
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		alert("Select Review Year");
	}
} 


function doPrint()
{
	if(document.forms[0].reviewYear.value=="")
	{
		alert("Select Review Year");
		return;
	}
	strcbsid=document.forms[0].cbsid.value;
	cbsname=document.forms[0].cbsname.value;
	tlrappno = document.forms[0].hidtlrno.value;
	var strfacility ="";
	var reviewYear = document.forms[0].reviewYear.value;
	var prop = "scrollbars=yes,width=775,height=550,menubar=yes";
	var title = "ReviewNote";
	var xpos = 100;
	var ypos = 55;
	prop = prop + ",left="+xpos+",top="+ypos;
	if(reviewOf=="0")
	{
	var url=appURL+"action/reviewNoteTermLoanPrint.jsp?hidBeanId=reviewtermloan&hidBeanGetMethod=getTLReviewRetailPrint&cbsid="+strcbsid+"&hidtlrno="+tlrappno+"&reviewYear="+reviewYear+"&cbsname="+cbsname+"&reviewOf="+reviewOf;

	}
	else if(reviewOf=="1")
	{
		var url=appURL+"action/reviewtermloansmeprint.jsp?hidBeanId=reviewtermloan&hidBeanGetMethod=getTLReviewSMEPrint&cbsid="+strcbsid+"&hidtlrno="+tlrappno+"&reviewYear="+reviewYear+"&cbsname="+cbsname+"&reviewOf="+reviewOf;
	}
	else if(reviewOf=="2")
	{
		var url=appURL+"action/reviewtermloancorporateprint.jsp?hidBeanId=reviewtermloan&hidBeanGetMethod=getTLReviewCorporatePrint&cbsid="+strcbsid+"&hidtlrno="+tlrappno+"&reviewYear="+reviewYear+"&cbsname="+cbsname+"&reviewOf="+reviewOf;
	}
	window.open(url,title,prop);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callOnload()">
<form name="frmworkflow" method="post" class="normal"> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<lapschoice:tlrtag pageid="13" reviewof='<%=Helper.correctNull((String)request.getParameter("reviewOf"))%>' valuesin='<%=Helper.correctNull((String)request.getParameter("valuesin"))%>'/>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
      <tr> 
         <td valign="top" colspan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt;Workflow -&gt;History</td>
      </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
			<table width="100%" border="0" cellspacing="0" cellpadding="0" align="left" class="outertable">
				<tr>
					<td>
						<lapschoice:MonitorReview />
					</td>
				</tr>
			</table>
		</td>
	</tr>
</table> 
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
        <tr> 
          <td height="20" width="50%" valign="bottom"> 
            <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left" class="outertable">
              <tr align="center"> 
                <td width="33%" class="sub_tab_active"><b>History</b></td>
                <td width="33%" id="action" class="sub_tab_inactive"><b><a href="javascript:callOtherTab('action')" >Action</a></b></td>
                <td width="33%" style="visibility:hidden"><b><a href="javascript:callOtherTab('remarks')">Remarks</a></b></td>
              </tr>
            </table>
          </td>
        </tr>
      </table>
      <br>
  <table width="95%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td><b>History</b></td>
    </tr>
    <tr>
      <td>
<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">
      <tr class="dataheader"> 
            <td width="19%" align="center">Sent By</td>
            <td width="16%" align="center">Sent On</td>
            <td width="21%" align="center">Sent To</td>
      </tr>
      <tr align="center"> 
            <td colspan="6"> 
              <div class="cellcontainer"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
                  <%
                                          
                                          if(arrFromUsr!=null && arrFromUsr.size()>0)
                                          {
                                          for(int i=0;i<arrFromUsr.size();i++){ %>
                  <tr> 
                    <td width="33%"> 
                      &nbsp;<%=Helper.correctNull((String)arrToUsr.get(i))%></td>
                    <td width="32%" align="center"><%=Helper.correctNull((String)arrDate.get(i))%> 
                      </td>
                    <td width="35%"> 
                      <%=Helper.correctNull((String)arrFromUsr.get(i))%> </td>
                  </tr>
                  <% } }%>
                </table>
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
        <tr>
      <td><br>
        <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
          <tr> 
            <td> 
              <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr valign="top"> 
               <td><input type="button" name="sanctionletter" value="Review Note" 
                       class="buttonPrint"  onClick="doPrint()">
               </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>			
    <tr>
      <td><br>
        <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
          <tr> 
            <td> 
              <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr valign="top"> 
                 
                  <td height="2"> 
                    <div align="center"> 
                      <input type="button" name="cmdclose" value="Close"  onClick = "callClose()" class="buttonClose">
                    </div>
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
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="borrowername" value="<%=Helper.correctNull((String)request.getParameter("borrowername"))%>">
  <input type="hidden" name="hidmoduletype" value="<%=strmoduletype%>">
  <input type="hidden" name="reviewOf" value="<%=request.getParameter("reviewOf")%>"> 
</form>
</body>
</html>
