<%@ page import="java.util.*" %>
<%@ page import="com.sai.laps.helper.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }

String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

%>
<html>
<head>
<title>SSI Other Details</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function Help()
{
	  var varString = appURL+"jsp/sethlp/hlp_ssiotherdetails.jsp"
	   var title = "Documents";
		var prop = "scrollbars=no,width=600,height=450";	
		prop = prop + ",left=50,top=150";
		window.open(varString,title,prop);
}
function onLoading()
{
	disableFields(true);
	enableButtons(false,true,true,false,false);

}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true,true);
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateotherdetailsData";
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ssi_otherdetails.jsp";
		document.forms[0].submit();
	 }
}
function doSave()
{		
		enableButtons(true,true,true,false,false);
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].hidBeanMethod.value="updateotherdetailsData";
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ssi_otherdetails.jsp";
		document.forms[0].submit();
		
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="comsiaboveten";
		document.forms[0].hidBeanGetMethod.value="getotherdetailsData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/ssi_otherdetails.jsp";
		document.forms[0].submit();
	 }
	
}
function doClose()
{
	if( ConfirmMsg(100) )
	{
		self.close();
	}
	
}

 
</script>

<STYLE>
DIV.cellContainer {	
  width: 100%; height: 380;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onLoading()" bgcolor="#EEEAE3">
<form method="post" name="fltintrate">
<jsp:include page="../share/help.jsp" flush="true"/> 

 <span style="display:none"><laps:borrowertype /></span> <laps:application/>

  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="380">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td valign="top"> 
			 <div class="cellcontainer"> 
			  <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr > 
                        <td width="50%" height="20" class="tabactive"><b>If the unit is an ancilary unit, the undertaking to which it is catering and its address</b></td>
                          <td width="50%" height="20" class="tabactive"><b>Details 
                            of arrangement made for quality control. &nbsp;If 
                            BIS/FPO/ISO specifications are followed, No. of BIS/FPO/ISO 
                            standards and the particulars thereof should be provided.</b></td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <textarea name="Description1" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc1"))%></textarea>
                          </font></td>
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <textarea name="Description2" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc2"))%></textarea>
                          </font></td>
                      </tr>
                      <tr align="center"> 
                        <td width="50%" height="18">&nbsp;</td>
                        <td width="50%" height="18">&nbsp;</td>
                      </tr>
                      <tr > 
                        <td width="50%" height="20" class="tabactive"><b>Particulars of R &amp; D activity proposed</b></td>
                        <td width="50%" height="20" class="tabactive"><b>Repayment Programme</b></td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%">
                          <textarea name="Description3" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc3"))%></textarea>
                          </td>
                        <td align="center" width="50%">
                          <textarea name="Description4" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc4"))%></textarea>
                          </td>
                      </tr>
					   <tr align="center"> 
                        <td width="50%" height="18">&nbsp;</td>
                        <td width="50%" height="18">&nbsp;</td>
                      </tr>
                      <tr> 

                        <td width="50%" height="20" class="tabactive"><b>Whether any Government enquiry, proceedings or prosecution has been instituted against the units or its proprietor / partners / directors for any offence? If so, please give details.</b></td>
                        <td width="50%" height="20" class="tabactive"><b>Details of pending Litigation, if any, against and by the unit.</b></td>

                         

                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <textarea name="Description5" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc5"))%></textarea>
                          </font></td>
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <textarea name="Description6" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc6"))%></textarea>
                          </font></td>
                      </tr>
					   <tr align="center"> 
                        <td width="50%" height="18">&nbsp;</td>
                        <td width="50%" height="18">&nbsp;</td>
                      </tr>
                      <tr > 
                        <td width="50%" height="20" class="tabactive"><b>Please Indicate whether the proprietor / any of the partners / promoters / directors have at any time declared themselves as insolvent. if so, details therof.</b></td>
                      </tr>
                      <tr> 
                        <td align="center" width="50%"><font size="1" face="MS Sans Serif"> 
                          <textarea name="Description7" cols="70" wrap="VIRTUAL" rows="9"><%=Helper.correctNull((String)hshValues.get("desc7"))%></textarea>
                          </font></td>
                      </tr>
                    </table>
                    </td>
                </tr>
              </table>
			  </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
 <br>
   <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="2">
        <tr valign="top"> 
        
		   
          <td  align="center"> 
              <input type="button" name="cmdedit" value="Edit"  class="buttonStyle"  onClick="doEdit()">
          </td>
          <td align="center"> 
                <input type="button" name="cmdapply" value="Save" class="buttonStyle" onClick="doSave()">
          </td>
          <td align="center"> 
              <input type="button" name="cmdcancel" value="Cancel" class="buttonStyle" onClick="doCancel()">
          </td>
          <td> 
            <input type="button" name="cmddel" value="Delete"  class="buttonStyle" onClick="doDelete()">
          </td>
          <td> 
            <input type="button" name="cmdhelp" value="Help" class="buttonHelp" onClick="Help()">
          </td>
          <td> 
            <input type="button" name="cmdclose" value="Close"  class="buttonClose" onClick="doClose()">
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table> 
<input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">
</form>
</body>
</html>