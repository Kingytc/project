<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Commercial-Existing Application form</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var currentDate = "<%=Helper.getCurrentDateTime().substring(6,10)%>";
var varClassfication = "<%=Helper.correctNull((String)request.getParameter("classid"))%>";

function showBlank()
{
	document.all.result.src=appUrl+'action/blank.jsp';
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		 	document.forms[0].action=appUrl+"action/mon_borrowersearch.jsp";
			document.forms[0].submit();
	}
}
function doNew()
{
	var txtyear = document.forms[0].txt_year.value;
	var maxyear=document.forms[0].hidMaxYear.value;
			
	if(document.forms[0].txt_year.value=="")
	{
		alert("Year cannot be Empty");
		return;
	}

	if(parseInt(txtyear) <= parseInt(maxyear))
	{
	    alert("Review note already prepared");
	    document.forms[0].txt_year.value="";
		document.forms[0].txt_year.focus();
		return;
	}
    if(parseInt(txtyear) > parseInt(currentDate))
    {
        alert("Review Year cannot be greater than current year");
		document.forms[0].txt_year.value="";
		document.forms[0].txt_year.focus();
		return;
	}

    document.forms[0].hidtlrno.value="New";
	document.forms[0].reviewYear.value=document.forms[0].txt_year.value;
	document.forms[0].action=appUrl+"action/reviewnotetypeofreview.jsp";		
    document.forms[0].hidBeanGetMethod.value="getTypeReviewTermLoan";
	document.forms[0].hidBeanId.value="reviewtermloantwo";
	document.forms[0].method="post";			
	document.forms[0].submit();		
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<style type="text/css">
</style>
</head>
<body onLoad="">
<form name="exist" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td valign="top" colSpan="5" class="page_flow">Home -&gt; Term Loan - Review -&gt;Accountwise Search </td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                <tr> 
                  <td valign="top"> 
                    <table width="20%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
											
											<tr id="yearchk" style="visibility:hidden">
												<td width="8%" align="right"><b>Year</b><span class="mantatory">*</span></td>
												<td width="8%"><input type="text" name="txt_year" size="5"
													maxlength="4" onKeyPress="allowInteger()"></td>
												<td width="8%"><input type="button" name="cmd_new"
													value="New" class="buttonStyle" onClick="doNew()"></td>
											
											</tr>
											
					</table>						
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                      <tr valign="top"> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
                            <tr  align="center"> 
                             
                              <td width="9%" height="22">Application No.</td>
                              <td width="18%" height="22">Borrower Name</td>								
                              <td width="20%" height="22">Process Status</td> 						 		
                              
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td valign="top">
                        <iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/tlr_reviewresult.jsp?hidBeanGetMethod=getTermLoanReviewData&hidprinttype=<%=Helper.correctNull((String)request.getParameter("hidprinttype"))%>&hidmontype=<%=Helper.correctNull((String)request.getParameter("hidmontype"))%>&id=<%=Helper.correctNull((String)request.getParameter("id"))%>&cbsname=<%=Helper.correctNull((String)request.getParameter("cbsname"))%>&custorgscode=<%=Helper.correctNull((String)request.getParameter("custorgscode"))%>&custclassification=<%=Helper.correctNull((String)request.getParameter("classid"))%>" width="100%" height="220" > </iframe> </td>
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
  <table border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
    <tr> 
      <td> 
        <table width="0%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="middle"> 
            <td> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" class="buttonClose" onClick="doClose()">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="cbsname" value="<%=request.getParameter("cbsname")%>"> 
<input type="hidden" name="cbsid" value="<%=Helper.correctNull((String)request.getParameter("id"))%>">
<input type="hidden" name="hidmontype" value="<%=request.getParameter("hidmontype")%>">
<input type="hidden" name="hidprinttype" value="<%=request.getParameter("hidprinttype")%>">
<input type="hidden" name="hidMaxYear">
<input type="hidden" name="reviewYear" value="">
<input type="hidden" name="hidtlrno" value="">
</form>
</body>
</html>
