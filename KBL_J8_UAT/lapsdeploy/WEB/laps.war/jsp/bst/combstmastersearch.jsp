<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
function callNew()
{
		document.forms[0].action=appURL+"action/combst_custinfo.jsp";
		document.forms[0].submit();
}

function placeCursor()
	{
		document.loanHistory.txtvalue.focus();
	}

function resetme()
	{
	    
		document.forms[0].reset();
		document.all.result.src=appURL+'action/blank.jsp';
	}

function doSearch()
{
	var appid="%";
	var appname="%";

	if(document.forms[0].srchtype.checked)
	{
		cat=1;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	if(document.forms[0].srchtype.checked==true)
	{
		if(trim(document.forms[0].txtvalue.value) == "")
		{
			ShowAlert(121,'Search Criteria');
			document.forms[0].txtvalue.focus();
			return false;
		}
	}	

	if(document.forms[0].srchtype.checked && document.forms[0].txtvalue.value!="" )
	{
		appname=document.forms[0].txtvalue.value;
	}
	
	var txtval=document.forms[0].txtvalue.value;
    var txtlen=txtval.length;
	if(txtlen<=2)
 	{
		 alert("Enter atleast 3 characters");
     	document.forms[0].txtvalue.focus();
     	return;
 	}
	var hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
   	noofrows = document.forms[0].txt_noofrows.value;
    var varhidPagetype = document.forms[0].hidPageType.value;
    document.all.result.src=appURL+"action/combstmasterresult.jsp?hidBeanId=broadsancterms&hidBeanGetMethod=getBSTCustomerList&comapp_companyname="+appname+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidPageType="+varhidPagetype;
}

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/combstpge.jsp";
		 document.forms[0].submit();
	 }
}
 
function rowCount(nav)
{
 	if(document.forms[0].hid_rowcount.value == "")
 	{
 		document.forms[0].hid_rowcount.value = 0;
 	}
 	else
 	{
 		if(nav == 1)
 		{
 			if(parseInt(document.forms[0].hid_rowcount.value) < parseInt(document.forms[0].txt_noofrows.value) + 1)
 			{
	 		  document.forms[0].hid_rowcount.value = 0;
	 		}
	 		else
	 		{
			  document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) - parseInt(document.forms[0].txt_noofrows.value);
			}
		}
		else if(nav == 2)
		{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) + parseInt(document.forms[0].txt_noofrows.value);
		}
	    	doSearch();
 	}
}
 
function setpageid()
{
   
	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
}


function setCount()
{
    if(document.forms[0].txt_noofrows.value == "")
	{
		alert(" Enter Value");
		document.forms[0].txt_noofrows.focus();
		return;
	}
	if(parseInt(document.forms[0].txt_noofrows.value) > 100)
	{
		alert("Value should be below 100");
		document.forms[0].txt_noofrows.focus();
		return;
	}
}


function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_custmast_search.htm";
  var title = "CorporateSearch";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
          <tr>
            <td class="page_flow"><b>Home&nbsp;-&gt;&nbsp;Commercial(Broad Sanction Terms Customer Information) 
              -&gt; Customer Information Details</b></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <div align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
      <tr> 
        <td valign="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr> 
                    <td valign="top"> 
                      <div align="left"><b>Customer Information Details</b><br>
                      </div>
                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                    <tr> 
                                      <td colspan="2"><b>Search 
                                        By</b> </td>
                                      <td colspan="6">&nbsp; </td>
                                    </tr>
                                    <tr> 
                                      <td width="3%"> 
                                        <input type="radio" name="srchtype" value="radiobutton"  style="border-style:none" onClick="placeCursor()">
                                      </td>
                                      <td width="10%">Company 
                                        Name</td>
                                      <td width="15%"> 
                                        <input type="text" name="txtvalue" onKeyPress="notAllowSplChar1(this)" >
                                      </td>
                                      <td width="12%"> 
                                        <input type="button" name="search" value="Search" style="width:75" onClick="doSearch()" class="buttonStyle">
                                      </td>

                                      <td width="60%">
                                        <input type="button" name="cmdOK22" value="New Applicant" style="width:100" onClick="callNew()" class="buttonStyle">
                                      </td>
                                    </tr>
                              <tr>
                        <td colspan="8">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                             <tr>
                              <td width="19%" nowrap> <b>No. of rows to be displayed 
                             </b> </td>
                             <td width="81%"> 
                          <input type="text" name="txt_noofrows" size="4" maxlength="2" value = "15" onBlur="setCount()" onKeyPress="allowInteger()">
                           <b>(Value should be below 100)</b> </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                                    <tr> 
                                      <td colspan="8"> 
                                        <table width="70%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
                                          <tr class="dataheader"> 
                                            <td width="50%"> 
                                              <div align="center"><b>Company 
                                                Name</b></div>
                                            </td>
                                            <td width="50%"> 
                                              <div align="center"><b>Organisation Name</b></div>
                                            </td>
                                          </tr>
                                          </table>
                                      </td>
                                    </tr>
                                    <tr align="center"> 
                                      <td colspan="8"> <iframe id="result" src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp" width=70% height=240> 
                                        </iframe> </td>
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
              </td>
            </tr>
          </table>
          
        </td>
      </tr>
        <table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr>
                     <td align="left" width="50%" nowrap="nowrap"><a href="#" onclick="javascript:rowCount('1')"><b>&lt;&lt;Previous</b></a></td>

                     <td align="right" width="50%"><a href="#" onclick="javascript:rowCount('2')"><b>Next&gt;&gt;</b></a></td>
                 </tr>
             </table>   
    </table>
     <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable border1">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3" class="outertable">
            <tr valign="top">
              <td height="2">
                <input type="button" name="cmdreset" value="Reset" style="width:80" onClick="resetme()" class="buttonStyle">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdClose" value="Close" style="width:50" onClick="doClose()" class="buttonClose">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
  	<input type=hidden name="comapp_id">
  	<input type=hidden name="comapp_companyname">
	<input type=hidden name="hid_rowcount" value="">
  	<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">
</form>
</body>
</html>
