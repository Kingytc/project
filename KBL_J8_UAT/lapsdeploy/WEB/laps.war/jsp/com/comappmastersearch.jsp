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
	if(document.forms[0].hidPageType.value=="UPL")
  	{
  		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corpupload.jsp?custtype=New";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
  	}
  	else
  	{
		document.forms[0].action=appURL+"action/comappmaster.jsp?scode=y";
		document.forms[0].submit();
	}
}

function callOffline()
{
	document.forms[0].action=appURL+"action/offline.jsp?fileid=companydtls";
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

	if(document.forms[0].rad[0].checked)
	{
		cat=1;
	}
	else if(document.forms[0].rad[1].checked)
	{
		cat=2;
	}
	else
	{
		alert("Select a search criteria to search");   
		return;
	}
	for(var k=0;k<2;k++)
	{
		

		if(document.forms[0].rad[k].checked==true)
		{
			if(trim(document.forms[0].txtvalue.value) == "")
			{
			    
				ShowAlert(121,'Search Criteria');
				document.forms[0].txtvalue.focus();
				return false;
			}
		}	

	}

	
	
	if(document.forms[0].rad[0].checked && document.forms[0].txtvalue.value!="" )
	{
		appname=document.forms[0].txtvalue.value;
	}
	if(document.forms[0].rad[1].checked && document.forms[0].txtvalue.value!="")
	{
		appid=document.forms[0].txtvalue.value;
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
   
  document.all.result.src=appURL+"action/comappresult.jsp?hidBeanId=commappmaster&hidBeanGetMethod=getApplicantList&comapp_id="+appid+"&comapp_companyname="+appname+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidPageType="+varhidPagetype;

	
}

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/corppge.jsp";
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
function allowValuesinTextField()
{
	if(document.forms[0].rad[0].checked == true)
	{
		notAllowSplChar();
	}
	else
		
	{
		allowInteger();
	}
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body>
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems"><script language="JavaScript1.2">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script></div>
</div>

<form name="loanHistory" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
          <tr>
            <td class="page_flow"><b>Home -&gt; Commercial(Applicant Master)-&gt; Customer Master Details</b></td>
          </tr>
        </table>		
      </td>
    </tr>
 </table>
  <div align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
      <tr> 
        <td valign="top"> 
          <div align="left"></div>
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr> 
                    <td valign="top"> 
                      <div align="left"><b>Company Master Details</b><br>
                      </div>
                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable border1">
                              <tr> 
                                <td> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                                    <tr> 
                                      <td colspan="2"><b>Search 
                                        By</b></td>
                                      <td colspan="6">&nbsp; </td>
                                    </tr>
                                    <tr> 
                                      <td width="3%"> 
                                        <input type="radio" name="rad" value="0"  style="border-style:none" onClick="placeCursor()">
                                      </td>
                                      <td width="15%">Company Name</td>
                                      <td width="2%"> 
                                        <input type="radio" name="rad" value="1" style="border-style:none" onClick="placeCursor()">
                                       </td>
                                      <td width="13%">Industry BSR Code</td>
                                      <td width="24%"> 
                                      <input type="text" name="txtvalue" onKeyPress="allowValuesinTextField();">
                                      </td>
                                      <td width="12%" align="center"> 
                                        <input type="button" name="search" value="Search" style="width:75" onClick="doSearch()" class="buttonStyle">
                                      </td>

                                      <td width="12%" align="center">
                                        <input type="button" name="cmdOK22" value="New Applicant" style="width:100" onClick="callNew()" class="buttonStyle">
                                      </td>

                                     </tr>
                                 <tr>
                        <td colspan="8">
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                             <tr>
                              <td width="19%" nowrap="nowrap"><b>No. of rows to be displayed</b></td>
                             <td width="81%"> 
                          <input type="text" name="txt_noofrows" size="4" maxlength="2" value = "15" onBlur="setCount()" onKeyPress="allowInteger()">
                          <b>(Value should be below 100)</b></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                                    <tr> 
                                      <td colspan="8"> 
                                        <table width="70%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                                          <tr class="dataheader"> 
                                            <td width="50%"> 
                                              <div align="center"><b>Company Name</b></div>
                                            </td>
                                            <td width="50%"> 
                                              <div align="center"><b>Industry BSR Code</b></div>
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
                              
                <!-- next and prev -->
                     
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
                     <td align="left" width="50%" nowrap="nowrap"><a href="javascript:rowCount('1')"><b>&lt;&lt;Previous</b></a></td>

                     <td align="right" width="50%"><a href="javascript:rowCount('2')"><b>Next&gt;&gt;</b></a></td>
                 </tr>
             </table>   
    </table>
    
    <table width="0%" border="0" cellspacing="0" cellpadding="0"  align="center" class="outertable border1">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3" class="outertable" class="buttonStyle">
            <tr valign="top">
              <td height="2">
                <input type="button" name="cmdreset" value="Reset" style="width:80" onClick="resetme()" class="buttonStyle">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdHelp" value="Help" style="width:50" onClick="dohlp()" class="buttonStyle">
                </div>
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
