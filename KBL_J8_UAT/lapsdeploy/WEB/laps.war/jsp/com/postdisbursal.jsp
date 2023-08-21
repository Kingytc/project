<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="strOrgLevel" class="java.lang.String" scope="session" />
<jsp:useBean id="strIsSaral" class="java.lang.String" scope="session" />
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

</script>
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
            <td valign="top" colspan=5><font size="4" color="#000000" face="Times New Roman" ><b><i>Home 
             -&gt; Credit / Inspection Report</i></b></font></td>
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
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td align="center"><font size="3"></font></td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td align="center">
              <table width="60%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" rowspan="2">                       
                        <b><A HREF="javascript:callFunction('comborrowersearch.jsp','INS')" CLASS="blackfont"><FONT SIZE="1" FACE="MS Sans Serif">Inspection 
                          Report </FONT></A> </b>
                          &nbsp; </td>                       
                      </tr>                      
                    </table>
					
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" rowspan="2">
                       <b><A HREF="javascript:callFunction('comborrowersearch.jsp','TINS')" CLASS="blackfont"><FONT SIZE="1" FACE="MS Sans Serif">Technical Inspection 
                          Report</FONT></A> </b>                         
                          &nbsp; </td>                        
                      </tr>
                    </table>
                    
					<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" rowspan="2">
                        <b><A HREF="javascript:callFunction('comborrowersearch.jsp','CIR')" CLASS="blackfont"><FONT SIZE="1" FACE="MS Sans Serif">Credit Report
                          </FONT></A> </b>
                          
                          &nbsp; </td>                       
                      </tr>                      
                    </table>    
                    <%if(strOrgLevel.equals("D") && strIsSaral.equals("Y")){ %>
                    
                    <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" rowspan="2">
                        <b><A HREF="javascript:callFunction('comborrowersearch.jsp','RFS')" CLASS="blackfont"><FONT SIZE="1" FACE="MS Sans Serif">Recommendations for sanction
                          </FONT></A> </b>&nbsp; </td>                       
                      </tr>                      
                    </table>  
					<%} %>               
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
          <tr> 
            <td><font size="3"><b><a href="javascript:gotoNavigation()"><img src="<%=ApplicationParams.getAppUrl()%>img/back.jpg" border=0></a></b></font></td>
          </tr>
        </table>
      </td>
      <td valign="top" align="right">&nbsp;</td>
  </tr>
</table>
<input type="hidden" name="workflow">
<input type="hidden" name="hidPageType">
</form>
</BODY>
</HTML>