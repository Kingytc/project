<%@ include file="../share/directives.jsp"%>
<%String grpRights = (String) session.getAttribute("strGroupRights");
%>
<html>
<head>
<TITLE>Laps Navigation</TITLE>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=iso-8859-1">
<script language="JavaScript">
var grpRights = "<%=session.getAttribute("strGroupRights")%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function callFunction(pagename)
{
	document.forms[0].method="post";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
}

function callWorkflow(pagename)
{
    document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getWorkflowData";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].submit();
	
}

function callPage(pagename)
{	
	document.forms[0].method="post";	
	document.forms[0].action = appURL+"action/"+pagename;
	document.forms[0].hidBeanId.value="formula";
	document.forms[0].hidBeanGetMethod.value="getCMA";
	document.forms[0].submit();
}
function callPage1(pname)
{
    document.forms[0].method="post";
	document.forms[0].action=appURL+"action/"+pname;
	document.forms[0].submit();
}

function doClose()
{
	callFunction('setupnav.jsp','','');	
}
</script>
<script language="JavaScript1.2"
	src="<%=ApplicationParams.getAppUrl()%>js/share/imageload.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
</head>

<body onLoad="">

<form name="frmltrnav" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
		
			<tr>
				<td valign="top" colspan=5 class="page_flow">Home
				-&gt; Setup -&gt; Corporate Products</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<BR>
<BR>
<table width="50%" border="0" cellspacing="0" cellpadding="5" class="outertable"
	align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0"
			align="center" class="outertable">
			<tr>
				
            <td width="100%" valign="top" align="center"> 
            	<fieldset style="width:400;height:50;">
            		<legend>
            			<b>Exposure</b></legend>
						<table width="100%" cellpadding="1" cellspacing="1" border="0" class="outertable">
							<tr>
								<td valign="top" width="100%">
									<fieldset style="width:400;">
						
                    <table width="100%" border="0" cellspacing="2" cellpadding="5"
							align="center" class="outertable">
                      <tr> 
                        <td ><b><b><a
									href="javascript:callPage1('comcustsearch.jsp')"
									>Exposure</a></b></b></td>
                      </tr>
                      <tr> 
                        <td><b><a
									href="javascript:callPage1('set_constitutionexposure.jsp?hidBeanGetMethod=getConsExp&hidBeanId=exposure')"
									>Constitution Exposure</a></b></td>
                      </tr>
                    </table>

						</fieldset>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<div align="center"><BR>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" NAME="hidPage"> <INPUT TYPE="hidden"
	NAME="hidusr_id">  <input type="hidden" name="newmode"
	value="Y"> <input type="hidden" name="prdtype" value="C"></div>
</form>
</body>
</html>
