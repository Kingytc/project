
<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<HTML>
<HEAD>
<TITLE>POSTDISBBURSAL</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function gotoPostDisb()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/selectctrl.jsp";
	document.forms[0].submit();
}
function gotoNavigation()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/corppge.jsp";
	document.forms[0].submit();
}
function gotoNPA()
{
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/npamain.jsp";
	document.forms[0].submit();
}
function gotoQis()
{
 	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comborrowersearch.jsp?hidPageType=PDC";
	document.forms[0].submit();
}
function callFunction(pagename,pagetype)
{
	document.forms[0].workflow.value="N";	
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callFunctionNpa(pagename,pagetype,npatype)
{
	document.forms[0].workflow.value="N";	
	document.forms[0].hidPageType.value = pagetype;
	document.forms[0].hidNpaPageType.value = npatype;
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}
function callSearch()
{
	var varQryString = "<%=ApplicationParams.getAppUrl()%>action/searchCustomer.jsp";
	var title = "Customer";
	var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
}

function call_page(url,method)
{
	
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].method="post";

	if(url=="application_disposal_register.jsp")
	{
		document.forms[0].hidBeanId.value="Register";
	}
		
	else
	{
		document.forms[0].hidBeanId.value="Register";
	}
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type=1";
	document.forms[0].submit();
	
}
function callFunction2(pagename)
{
 	document.forms[0].hidBeanId.value="Register";
 	document.forms[0].hidBeanGetMethod.value="getInsuranceDetails";
	document.forms[0].action = appURL+"action/"+pagename;
	
	document.forms[0].submit();
}
 
</script>
<style type="text/css">
<!--
a:hover {  color: #FF3300}
-->
</style>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
</HEAD>
<BODY BGCOLOR=#EEEAE3 leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="">
<form name="myform" method="post" action="">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>Home 
              </i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
              <font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><i><font size="4"><b><font color="#000000" size="2"><i><font size="4"><b><i><font face="Times New Roman" size="3"><b><i>-&gt;</i></b></font></i></b></font></i></font></b></font></i></b></font></i></b></font></i></b></font></i></b></font> 
              <font face="Times New Roman" size="3"><b><i>SetUp(Register)</i></b></font></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td>
	  	
      </td>
    </tr>
 </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5">
    <tr> 
      <td valign="top">&nbsp;</td>
      <td align="center">
        <table width="100%" border="0" cellspacing="0" cellpadding="3">
          <tr> 
            <td align="center" valign="top">&nbsp;</td>
          </tr>
          <tr> 
         
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"><font size="3"></font></td>
          </tr>
           <tr > 
            <td valign="middle" align="center">&nbsp; </td>
          </tr>
          <tr> 
            <td align="center">
              <table width="30%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
                <tr> 
                  <td> 
                    <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="1" align="center">
                      <tr>
                        <td>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr> 
                              <td><font
					size="1" face="MS Sans Serif"><b><font color="#CC3300">Register</font></b> 
                                </font></td>
                            </tr>
                            <tr> 
                              <td> 
                                <table width="99%" border="0" cellspacing="1" cellpadding="3" align="center">
                                  <tr > 
                                    <td align="left"> 
                                      <p><b><a href="javascript:call_page('application_disposal_register.jsp','getDisposal')" class="blackfont"><font size="1" face="MS Sans Serif">DocumentRegister</font></a></b></p>
                                      <!-- <p><b><a href="javascript:gotoQis()" class="blackfont"><font size="1" face="MS Sans Serif">LimitRegister</font></a></b></p>
                                      <p><b><a href="javascript:call_page('application_disposal_register.jsp','getDisposal')" class="blackfont"><font size="1" face="MS Sans Serif"> 
                                        ApplicationDisposalRegisty</font></a></b>&nbsp;</p>
                                      <p> <b><a href="javascript:callFunction2('insurance_register.jsp')" class="blackfont"><font size="1" face="MS Sans Serif"> 
                                        InsuranceRegister</font></a></b> </p>
                                        <p> <b><a href="javascript:callSearch('docSearchCustomer.jsp','','')" class="blackfont"><font size="1" face="MS Sans Serif"> 
                                        Search</font></a></b> </p>-->
                                    </td>
                                    <!--  <td width="30%" align="center"><b> <a href="javascript:gotoPostDisb()" class="blackfont"><font size="1" face="MS Sans Serif">CONTROL</font></a> </b></td>-->
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
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp; </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><font size="3"><b></b></font></td>
          </tr>
          <!--<tr> 
            <td><font size="3"><b><a href="javascript:gotoNavigation()"><img src="<%=ApplicationParams.getAppUrl()%>img/back.jpg" border=0></a></b></font></td>
          </tr>-->
        </table>
      </td>
      <td valign="top" align="right">&nbsp;</td>
  </tr>
</table>
<input type="hidden" name="workflow">
<input type="hidden" name="hidPageType">
<input type="hidden" name="hidNpaPageType">
<input type="hidden" name="hidBeanGetMethod">

<input type="hidden" name="hidBeanId">

</form>
</BODY>
</HTML>