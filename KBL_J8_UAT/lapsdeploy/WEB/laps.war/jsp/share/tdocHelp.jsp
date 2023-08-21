<%@include file="../share/directives.jsp"%>
<%
String strUsedFor=Helper.correctNull(request.getParameter("usedfor"));
String strHidsheet=Helper.correctNull(request.getParameter("hidSheet"));
%>

<HTML>
<HEAD>
<title>

<%
if(strUsedFor.equals("A"))
{
%>
Documents - Applicant
<%
}
else if ( strUsedFor.equals("I"))
{
%>
Documents - Internal
<%
}
else
{
%>
Industrial Code
<%
}
%>
</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
	
<SCRIPT LANGUAGE="JavaScript">
var varUsedFor="<%=strUsedFor%>";
var varHidsheet="<%=strHidsheet%>";

/*
*	This javaScript function is used to get
*	the value selected by the user
*/

function doOk(){
	getSelectedlistValue();
}
function getSelectedlistValue()
{
	var length=document.forms[0].elements.length;
	//for(var i=0;i<length;i++)
		//alert(document.forms[0].elements[i].type + '-->'+document.forms[0].elements[i].name);
	
	if(length=="4")
	{
		if(varUsedFor!="")
		{
			
			window.opener.document.forms[0].hidUsedFor.disabled=false;
			var selIndex=document.forms[0].seltdoc_docs.value;
			if(selIndex!="")
			{
			   window.opener.document.forms[0].hidUsedFor.value=selIndex;
				window.opener.document.forms[0].hidSourceUrl.value="/action/documents.jsp";
				window.opener.document.forms[0].hidBeanGetMethod.value="getData";
				window.opener.document.forms[0].hidBeanId.value="tdocdocuments";
				//window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
				window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/documents.jsp";
				window.opener.document.forms[0].submit();
				window.close();
			}
			else
			{
				alert("Select a particular description");
			}
		}else if(varHidsheet!="")
		{
				var selIndex=document.forms[0].seltdoc_docs.value;
				if(varHidsheet.toUpperCase()=="IC")
				{
					window.opener.document.forms[0].hidSourceUrl.value="/action/setriskInc.jsp";
					window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setriskInc.jsp";
				}
				else
				{
					window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/setriskBal.jsp";
					window.opener.document.forms[0].hidSourceUrl.value="/action/setriskBal.jsp";
				}
				window.opener.document.forms[0].hidriskcode.value=selIndex;
				window.opener.document.forms[0].hidSheet.value="<%=strHidsheet%>";
				window.opener.document.forms[0].hidrisk_code_nature.value="I";
				window.opener.document.forms[0].hidBeanGetMethod.value="getData";
				window.opener.document.forms[0].hidBeanId.value="setriskbd";
				//window.opener.document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";

				
				window.opener.document.forms[0].submit();
				
				window.close();
				
		
		}
	}else
	{
		alert("No help avaliable");
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		window.close();
	}
}
</SCRIPT>
<style type="text/css">

</style>
</HEAD>
<BODY >
<form name="tocHelp" method="post" action="" class="normal">
  <p>&nbsp;</p><table width="90%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1">
    <tr class="dataheader">
      <td><b>
        Select Description</b></td>
    </tr>
    <tr> 
      <td width="1000"> 
        <%
	if(strHidsheet.equalsIgnoreCase("BS") || strHidsheet.equalsIgnoreCase("IC"))
	{
%>
        <lapschoice:dochelp value='<%=strHidsheet%>' /> 
        <%
	}
	else
	{
%>
        <lapschoice:dochelp value='<%=strUsedFor%>' /> 
        <%
	}		
%>
      </td>
    </tr>
  </table>
  <br>
 <lapschoice:combuttonnew btnnames='OK' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' /> 
							
</form>
</BODY>
</HTML>