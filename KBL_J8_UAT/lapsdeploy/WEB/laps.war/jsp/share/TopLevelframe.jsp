<%@ page import="com.sai.laps.helper.*,java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<%			
			String strTopPage = Helper.correctNull((String) hshValues.get("strTopPage"));
			String strChildPage = Helper.correctNull((String) hshValues.get("hidChildPage"));
			String strChildTab = Helper.correctNull((String) hshValues.get("hidChildTab"));
			String strTabId = Helper.correctNull((String) hshValues.get("strTabId"));
			String strParentId = Helper.correctNull((String) hshValues.get("hidParentId"));
			String strChildId = Helper.correctNull((String) hshValues.get("hidChildId"));
			ArrayList arrValues = new ArrayList();
			
			if (hshValues.get("arrValues") != null) 
			{
				arrValues = (ArrayList) hshValues.get("arrValues");
			}
%>
<lapschoice:handleerror />
<html>
<head>
<title>LAPS</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript" type="text/javascript">


function callPage(page_id, page, tab_id,pageText)
{

	if(parent.mainFrame.document.forms[0].cmdsave)
	{
	
		if(parent.mainFrame.document.forms[0].cmdsave.disabled==true)
		{
			document.all.hidParentId.value = page_id;	
			document.all.hidTopPage.value = page;	
			document.all.hidTabId.value = tab_id;	
			document.all.hidChildId.value = 0;	
			document.all.hidChildPage.value = "";	
			document.all.hidChildTab.value = 0;	
			var varappstatus=document.forms[0].appstatus.value;
			parent.menuFrame.document.all.agripath.innerHTML = pageText;
			
			
			for (i = 0; i < document.all["tab"].length; i++) 
			{
				if(i==tab_id)
				{
					
					document.all.enableId[i].style.display='none';
					document.all.disableId[i].style.display='block';
					
					document.all["tab"][i].style.color ="#FFFFFF";
					document.all["tab"][i].style.background ="#00579C";
					document.all["tab"][i].style.borderBottomColor = "#DA251C";
					document.all["tab"][i].style.borderBottomWidth = "2 px";
					document.all["tab"][i].style.borderRightColor  = "#DA251C";
					document.all["tab"][i].style.borderLeftColor   = "#00579C";
					document.all["tab"][i].style.borderRightWidth = "1 px";
					document.all["tab"][i].style.fontSize = "11 px";
				}
				else
				{
					
					document.all.enableId[i].style.display='block';
					document.all.disableId[i].style.display='none';
					document.all["link"][i].style.color ="#333333";
					document.all["tab"][i].style.background ="#99CCFE";
					document.all["tab"][i].style.borderBottomColor = "#FFFFFF";
					document.all["tab"][i].style.borderRightColor  = "#FFFFFF";
					document.all["tab"][i].style.borderLeftColor   = "#FFFFFF";
					document.all["tab"][i].style.borderBottomWidth = "0 px";
					document.all["tab"][i].style.borderRightWidth = "0 px";
					document.all["tab"][i].style.fontSize = "11 px";
					
				}
			}	
			
			parent.mainFrame.document.location.href = "<%=ApplicationParams.getAppUrl()%>action/"+page+"&screen_id="+page_id+"&appstatus="+varappstatus+"&btnenable="+document.forms[0].btnenable.value+"&appno="+document.forms[0].appno.value;
		}
		else
		{
			ShowAlert('103');
		}
	}
	else
	{
			document.all.hidParentId.value = page_id;	
			document.all.hidTopPage.value = page;	
			document.all.hidTabId.value = tab_id;	
			document.all.hidChildId.value = 0;	
			document.all.hidChildPage.value = "";	
			document.all.hidChildTab.value = 0;	
			
			var varappstatus=document.forms[0].appstatus.value;
			parent.menuFrame.document.all.agripath.innerHTML = pageText;
			
			for (i = 0; i < document.all["tab"].length; i++) 
			{
				if(i==tab_id)
				{
					document.all.enableId[i].style.display='none';
					document.all.disableId[i].style.display='block';
					
					document.all["tab"][i].style.color ="#FFFFFF";
					document.all["tab"][i].style.background ="#00579C";
					document.all["tab"][i].style.borderBottomColor = "#DA251C";
					document.all["tab"][i].style.borderBottomWidth = "2 px";
					document.all["tab"][i].style.borderRightColor  = "#DA251C";
					document.all["tab"][i].style.borderLeftColor   = "#00579C";
					document.all["tab"][i].style.borderRightWidth = "1 px";
					document.all["tab"][i].style.fontSize = "11 px";
					
				
				}
				else
				{
					
					document.all.enableId[i].style.display='block';
					document.all.disableId[i].style.display='none';
					document.all["link"][i].style.color ="#333333";
					document.all["tab"][i].style.background ="#99CCFE";
					document.all["tab"][i].style.borderBottomColor = "#FFFFFF";
					document.all["tab"][i].style.borderRightColor  = "#FFFFFF";
					document.all["tab"][i].style.borderLeftColor   = "#FFFFFF";
					document.all["tab"][i].style.borderBottomWidth = "0 px";
					document.all["tab"][i].style.borderRightWidth = "0 px";
					document.all["tab"][i].style.fontSize = "11 px";
				
				}
			}	
			parent.mainFrame.document.location.href = "<%=ApplicationParams.getAppUrl()%>action/"+page+"&screen_id="+page_id+"&appstatus="+varappstatus+"&appholder="+document.forms[0].appholder.value;
	}	
	
}
/*
// Tab is Child Tabs
function callChildPage(page_id, page, tab_id)
{
	parent.mainFrame.document.location.href = "<%//=ApplicationParams.getAppUrl()%>action/"+page+"&screen_id="+page_id;
}
*/
function clearSelection() 
{
	for (i = 0; i < document.all["tab"].length; i++) 
	{
		alert("clearselection");
		document.all["link"][i].style.color ="#589BD6";
		document.all["tab"][i].style.background ="#99CCFE";
	}	
}

function doSelection(obj) 
{

	clearSelection();
	obj.style.background ="#00579C";
	
	
}

function MM_reloadPage(init)
{
  	if (init==true) with (navigator) 
  	{
  		if ((appName=="Netscape")&&(parseInt(appVersion)==4)) 
  		{
     		document.MM_pgW=innerWidth; 
     		document.MM_pgH=innerHeight; 
     		onresize=MM_reloadPage; 
     	}
    }
  	else if (innerWidth!=document.MM_pgW || innerHeight!=document.MM_pgH) location.reload();
}

MM_reloadPage(true);
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doLogout() 
{
	if(confirm('Do you want to logout?'))
	{
	    document.forms[0].hidBeanId.value = "";
	    document.forms[0].hidBeanGetMethod.value = "";
	    document.forms[0].hidBeanMethod.value = "";
	    document.forms[0].hidPage.value = "Navigation";
		document.forms[0].hidusr_id.value = "<%=session.getAttribute("strUserId")%>";
		document.forms[0].action=appURL+"action/hidlogin.jsp?val=exit";
		document.forms[0].submit();
	}
}

function doGoHome() 
{
	document.all.hidChildId.value = 0;	
	document.all.hidChildPage.value = "";	
	document.all.hidChildTab.value = 0;	
	clearSelection();
    document.forms[0].hidBeanId.value="";
	document.forms[0].hidBeanGetMethod.value="";
	document.forms[0].hidBeanMethod.value="";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/mainnav.jsp";
	document.forms[0].target="mainFrame";
	document.forms[0].submit();  
}

function callsupnam()
{
	var prop = "scrollbars=no,width=500,height=400,top=100,left=250";
	var url=strAppUrl+"action/orgnamelist.jsp?strfrom=topframe";
	window.open(url,"",prop);
}

function doLoad()
{
	var page = document.all.hidTopPage.value;
	var tab_id = document.all.hidTabId.value;
	var page_id = document.all.hidParentId.value;		
	var child_page_id = document.all.hidChildId.value;
	

	if(tab_id!="")
	{
		if (flag=="orgChange") 
		{	
			doSelection(document.all["tab"][tab_id]);
			document.all["link"][tab_id].style.color ="#589BD6";
			document.all["timg"][tab_id].background ="#99CCFE";	
			parent.mainFrame.document.location.href = "<%=ApplicationParams.getAppUrl()%>action/"+page+"&screen_id="+page_id;
    	}
    }
    else
    {
	   		var len = document.all.link.length;
	   		
	   		if(len==null)	
		   	{
	   			document.all.enableId.style.display='none';
				document.all.disableId.style.display='block';
			   	
		   		document.all.tab.style.color ="#FFFFFF";
		   		document.all.tab.style.background ="#00579C";
		   		document.all.tab.style.borderBottomColor = "#DA251C";
				document.all.tab.style.borderBottomWidth = "2 px";
				document.all.tab.style.borderRightColor  = "#DA251C";
				document.all.tab.style.borderLeftColor   = "#00579C";
				document.all.tab.style.borderRightWidth = "1 px";
				document.all.tab.style.fontSize = "11 px";
		   		
		   		parent.menuFrame.document.all.agripath.innerHTML = document.all.tabData.value;
		   	}
		   	else
		   	{
			   	document.all.enableId[0].style.display='none';
				document.all.disableId[0].style.display='block';
				
			   	document.all["tab"][0].style.color ="#FFFFFF";
				document.all["tab"][0].style.background ="#00579C";
				document.all["tab"][0].style.borderBottomColor = "#DA251C";
				document.all["tab"][0].style.borderBottomWidth = "2 px";
				document.all["tab"][0].style.borderRightColor  = "#DA251C";
				document.all["tab"][0].style.borderLeftColor   = "#00579C";
				document.all["tab"][0].style.borderRightWidth = "1 px";
				document.all.tab["tab"][0].style.fontSize = "11 px";
				
				parent.menuFrame.document.all.agripath.innerHTML = document.all.tabData.value;
				
				
				
	 		}
	 }
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body onload="doLoad()">
<form name="colForm" method="post" class="normal">
<table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="8" />
		</jsp:include></td>
	</tr>
</table>

<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
	<tr align="center" bgcolor="#99CCFE">
		<%

		if (arrValues.size() > 0) 
		{
				for (int iCtr = 0, size = arrValues.size(); iCtr < size; iCtr++) 
				{
					ArrayList arrRow = (ArrayList) arrValues.get(iCtr);
					
					%>
			

		<%if(iCtr==0){%>
		<input type="hidden"  name="tabData" value="<%=(String) arrRow.get(1)%>">
		<%}%>
				<td id='tab' class="main_tab_inactive" nowrap width="12%"><b><span id="enableId"><a id="link" style="text-decoration:none;"
			href="javascript:callPage('<%= arrRow.get(0)%>', '<%= arrRow.get(2)%>', '<%= iCtr %>','<%=arrRow.get(1)%>')"><%=(String) arrRow.get(1)%></a></span><span id="disableId" style="display:none"><%=(String) arrRow.get(1)%></span></b></td>

		<%}
			}

			%>
	</tr>
</table>


<input type="hidden" name="hidPage"> 
<input type="hidden" name="hidPageType"> 
<input type="hidden" name="hidBeanId"> 
<input type="hidden" name="hidBeanMethod"> 
<input type="hidden" name="hidBeanGetMethod"> 
<input type="hidden" name="user_id" value='<%=session.getAttribute("strUserId")%>'> 
<input type="hidden" name="appid" value='<%=request.getParameter("appno")%>'> 
<input type="hidden" name="radLoan1" value="Y"> 
<input type="hidden" name="hidSourceUrl"> 
<input type="hidden" name="hidTopPage" value="<%=strTopPage%>">
<input type="hidden" name="hidTabId" value="<%=strTabId%>">  
<input type="hidden" name="hidParentId" value="<%=strParentId%>"> 
<input type="hidden" name="hidChildId" value="<%=strChildId%>"> 
<input type="hidden" name="hidChildPage" value="<%=strChildPage%>"> 
<input type="hidden" name="cmdsave" value="" disabled>
<input type="hidden" name="hidChildTab" value="<%=strChildTab%>"> 

</form>
</body>
</html>
