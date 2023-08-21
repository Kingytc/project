<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<%
   String strType=request.getParameter("doc_type");
   if(strType.equalsIgnoreCase("i"))
   {
	   strType="Internal";
   }
   else
   {
	   strType="Applicant";
   }
   String ModuleType=request.getParameter("ModuleType");
 %>
<html>
<head>
<title>Setup - Product</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" >
</script>
<script>
 var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var doctype="<%=request.getParameter("doc_type")%>";
 function doOk()
 {
	 var startpos=0;
	 if(document.forms[0].doclist.selectedIndex==-1)
	 {
		 ShowAlert(110);
		 return;
	 }
	 for(var i=0;i<40;i++)
	 {
		 if(window.opener.document.forms[0].elements[doctype+"doc_desc"][i].value=="")
		 {
			 startpos=i;
			 break;
		 }
	 }
	 for(var j=0;j<document.forms[0].doclist.length;j++)
	 {
		 if(document.forms[0].doclist.options[j].selected && (!isExists(document.forms[0].doclist.options[j].text)))
		 {
			var codeDate=document.forms[0].doclist.options[j].value.split("#");
		    window.opener.document.forms[0].elements[doctype+"doc_desc"][startpos].value=document.forms[0].doclist.options[j].text;
			window.opener.document.forms[0].elements[doctype+"doc_code"][startpos].value=codeDate[0];
			window.opener.document.forms[0].elements[doctype+"doc_date"][startpos].value=codeDate[1];
		
			startpos++;
			if(startpos>39)
			{
				startpos=0;
			}
		}
	}
	window.close();
}

function isExists(val)
{
	for(var k=0;k<window.opener.document.forms[0].elements[doctype+"doc_desc"].length;k++)
	{
		if(val==window.opener.document.forms[0].elements[doctype+"doc_desc"][k].value)
		{
			return true;
		}
	}
	return false;
}
function doClose()
{
	window.close();
}
</script>

<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body>

<form name="myfrm" class="normal">
  <table width="90%" border="0" cellspacing="0" cellpadding="3"  align="center" class="outertable">
    <tr> 
      <td valign="top" height="259"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr> 
            <td height="20" class="dataheader"> 
              <div align="left">Documents 
                - <%=strType%></div>
            </td>
          </tr>
          <tr> 
            <td height="7"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td colspan="4" height="2"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4" class="outertable">
                                  <tr> 
                                    <td height="196" colspan="2"> 
                                      <div align="center"> 
                                        <select name="doclist" size="20" style="width:625" multiple onclick="document.forms[0].cmdok.disabled=false" onDblClick="doOk()">
                                          <laps:documents /> 
                                        </select>
                                      </div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="50%"> 
                                    <lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
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
        </table>
      </td>
    </tr>
  </table>
  <p>&nbsp;</p>
</form>
<p>&nbsp;</p></body>
</html>
