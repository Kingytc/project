<%@include file="../share/directives.jsp"%>
<%ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arryRow");
			//int noofrows = Integer.parseInt(request.getParameter("noofrows"));

			%>

<html>
<head>
<title>searchresults</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strLinkFrom=Helper.correctNull((String)request.getParameter("pageType"));
    
%>
<SCRIPT LANGUAGE="JavaScript">
var appid="<%=Helper.correctNull((String)hshValues.get("appidnew"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function callLink(cmano,finance_id)
{
	document.forms[0].hidfinanceid.value=finance_id;
	document.forms[0].hidcmasno.value=cmano;
	
	document.forms[0].hidappid.value=appid;
	

		document.forms[0].action=appURL+"action/com_FinancialTemp.jsp";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanId.value="financial";
		document.forms[0].target="mainFrame";
		document.forms[0].submit();
}
	
function callfindata()
{

var pagetype="FINANCIAL";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].hidBeanGetMethod.value="getFinancialtype";
	//document.forms[0].hidBeanMethod.value="getData";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/com_FinancialTemp.jsp?appid="+appid+"&pagetype="+pagetype;


	document.forms[0].target="mainFrame";
	document.forms[0].submit();
}

</SCRIPT>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="" method="post" class="normal" style="width: 102%">
<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
          <%  		
          String g1 =  "",g2="",g3="",cma="",g4="";   	
                 
                  ArrayList arrcmavalcma = (ArrayList) hshValues.get("arrcmavalcma");
                  ArrayList arrcmavalRowdesc = (ArrayList) hshValues.get("arrcmavalRowdesc");
                  ArrayList arrcmavalRowdate = (ArrayList) hshValues.get("arrcmavalRowdate");
                  ArrayList arrcmavalfinanceid = (ArrayList) hshValues.get("arrcmavalfinanceid");
                  int arrsize =arrcmavalcma.size();
							if(arrcmavalcma!=null && arrsize>0)
							{	
							
							
								for(int l=0;l<arrsize;l++)
								{	
									g1 = (String)arrcmavalRowdate.get(l);
									g2 = (String)arrcmavalcma.get(l);
									g3 = (String)arrcmavalRowdesc.get(l);
									g4 = (String)arrcmavalfinanceid.get(l);
									%>
	<tr class="datagrid">

		<td width="45%" align="center">&nbsp; <a
			href="JavaScript:callLink('<%=arrcmavalcma.get(l)%>', '<%=arrcmavalfinanceid.get(l)%>')" class="blackfont">
		<b><%=g3%></b></a></td>
		<td width="20%" align="center"><%=g1%></td><%}%>
		</tr>
          <%
                    				}
								

							else {
							  
							%>
				<tr><td colspan="5">&nbsp;</td></tr>
				<tr><td colspan="5">&nbsp;</td></tr>
				<tr><td colspan="5" align="center">&nbsp;<a href="javascript:callfindata()">Click here for New Financial</a></td></tr>
				<tr><td colspan="5">&nbsp;</td></tr>
				<tr><td colspan="5">&nbsp;</td></tr>
				<%}
							
								 %>
        </table>
    
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<INPUT TYPE="hidden" name="hidAppType">
<input type="hidden" name="hidDemoId"> 
<input type="hidden" name="hidcmasno"> 

<input type="hidden" name="hidfinanceid"> 

<input type="hidden" name="hidappid"> 

<input type="hidden" name="hidModuleName" value="P">
<input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("hidCategoryType"))%>"> 
</form>
</body>
</html>
