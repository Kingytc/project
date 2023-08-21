									
<%@ page import="com.sai.laps.helper.*" %>
<%
int pageid = Integer.parseInt(request.getParameter("pageid"));
%>

<HTML>
<HEAD>
<TITLE> Application Form Navigation </TITLE>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript">

function gotoPage(pagename)
{

	if(document.forms[0].appno.value == "new" || document.forms[0].appno.value == "")
	{
		ShowAlert(103);
		return;
	}
	
	if(document.forms[0].cmdapply.disabled == false)
	{
		ShowAlert(103);
		return;
	}
	if(pagename=="comapplicant.jsp")
	{
//		document.forms[0].hidBeanGetMethod.value="getLoanProducts";
	//document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/comloanproduct.jsp?hidBeanGetMethod=getLoanProducts";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet?hidBeanMethod=getFacilityData&hidBeanId=facilities&hidSourceUrl=/action/facilities.jsp";

	}
	else if(pagename=="borrowerinfo.jsp")
	{
		//document.forms[0].hidBeanGetMethod.value="getAddressData";
	var appno=document.forms[0].appno.value;
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/borrowerinfo.jsp?appno="+appno;
	}
	else if(pagename=="comdocuments.jsp")
	{
		//document.forms[0].hidBeanGetMethod.value="getDocument";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appdocuments.jsp?hidBeanGetMethod=getDocument";
	}
	else if(pagename=="appworkflowhistory.jsp")
	{
		//document.forms[0].hidBeanGetMethod.value="getHistory";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appworkflowhistory.jsp?hidBeanGetMethod=getHistory";
	}
	else if(pagename=="finavigate.jsp")
	{
	//	document.forms[0].hidBeanGetMethod.value="";
		document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/finavigate.jsp";
	}
	else if(pagename=="riskanalysisbal.jsp")
	{
		//document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/riskanalysisbal.jsp?hidBeanGetMethod=getData";
	}
	else if(pagename=="commcollateral.jsp")
	{
		//document.forms[0].hidBeanGetMethod.value="getCollateral";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/commcollateral.jsp?hidBeanGetMethod=getCollateral";
		
				
	}
	else if(pagename=="appnotes.jsp")
	{
	//document.forms[0].hidBeanGetMethod.value="getNotes";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/appnotes.jsp";
	}
	document.forms[0].submit();
	
}

		function menuOptionDivMouseDown (url) 
		{
			if(document.forms[0].cmdapply.disabled == true)
			{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}

		
		}
		function menuOptionDivClick (url) 
		{
			if(document.forms[0].cmdapply.disabled == true)
			{
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
			}
			else
			{
				ShowAlert(103);
			}
		}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		appname=document.forms[0].appname.value;
		document.forms[0].action=appURL+"action/"+"persearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=<%=session.getAttribute("link")%>&comapp_compname="+appname;
		//alert(document.forms[0].action);
		document.forms[0].submit();
	}


}
function onclose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";
		appname=document.forms[0].appname.value;
		document.forms[0].action=appURL+"action/"+"persearch.jsp?id=<%=session.getAttribute("comappid")%>&hidPageType=<%=session.getAttribute("link")%>&comapp_compname="+appname;
		//alert(document.forms[0].action);
		document.forms[0].submit();
	}


}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</HEAD>

<BODY leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">

<table width=100% border=0 cellpadding=0 cellspacing=0 height="20">
<tr> 
	<td width="12%">
		
      <div align="center"> 
        <%if(pageid==1)
		  {%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Applicant</font></b> 
        </font> 
        <%}
		  else
		  {%>
        <a href="javascript:gotoPage('comapplicant.jsp')" class="blackfont"> <b>Applicant</b> 
        </a> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 2)
		   {%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Principal 
        [s]</font></b> </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('borrowerinfo.jsp')" class="blackfont">Principal 
        [s] </a></b> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 3)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Financial</font></b> 
        </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('finavigate.jsp')" class="blackfont">Financial</a></b> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 4)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Security</font></b> 
        </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('commcollateral.jsp')" class="blackfont"> 
        Security</a></b> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 5)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Documents</font></b> 
        </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('comdocuments.jsp')" class="blackfont"> 
        Documents</a></b> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 6)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Risk Analysis</font></b> 
        </font> 
        <%}
			else
			{%>
        <a href="javascript:gotoPage('riskanalysisbal.jsp')" class="blackfont"> 
        <b>Risk Analysis</b></a> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 7)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Workflow</font></b> 
        </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('appworkflowhistory.jsp')" class="blackfont">Workflow</a></b> 
        <%}%>
      </div>
    </td>

			<td width="12%"> 
			
      <div align="center"> 
        <%if(pageid == 8)
			{%>
        <font color="#999999"> <b><font size="1" face="MS Sans Serif">Notes</font></b> 
        </font> 
        <%}
			else
			{%>
        <b><a href="javascript:gotoPage('appnotes.jsp')" class="blackfont">Notes</a></b> 
        <%}%>
      </div>
    </td>
			</tr>
			</table>
</BODY>

</HTML>
