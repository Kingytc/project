<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCust");
			}
int arrSize =0;
			%>
<html>
<head>
<title></title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
	<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

	function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			else if(document.forms[0].elements[i].type=="textarea")
			{
				document.forms[0].elements[i].value="";		  
			}
		}
	}

	function setValues(val1,val2,val3,val4,val5)
	{
		alert(val1+"\n"+val2+"\n"+val3+"\n"+val4+"\n"+val5);
		window.opener.document.forms[0].hidRefNo.value = val1;
		window.opener.document.forms[0].hidParentLevel.value = val4;
		window.opener.document.forms[0].cmdEdit.disabled=false;
		window.opener.document.forms[0].cmdCancel.disabled=false;
		window.opener.document.forms[0].cmdDelete.disabled=false;
		if(val4 == 0)
		{
			window.opener.document.forms[0].txt_freecode6.value = val2;
			window.opener.document.forms[0].txt_freecode6desc.value = val3;
			window.opener.document.forms[0].txt_freecode7.value = "";
			window.opener.document.forms[0].txt_freecode7desc.value = "";
			window.opener.document.forms[0].txt_freecode8.value = "";
			window.opener.document.forms[0].txt_freecode8desc.value = "";
			window.opener.document.forms[0].hidParentRef.value = val1;
			window.opener.doChange();
		}
		else if(val4 == 1)
		{
			window.opener.document.forms[0].txt_freecode7.value = val2;
			window.opener.document.forms[0].txt_freecode7desc.value = val3;
			window.opener.document.forms[0].txt_freecode8.value = "";
			window.opener.document.forms[0].txt_freecode8desc.value = "";
			window.opener.document.forms[0].hidParentRef1.value = val5;
			window.opener.doChange();
		}		
		else if(val4 == 2)
		{
			window.opener.document.forms[0].txt_freecode8.value = val2;
			window.opener.document.forms[0].txt_freecode8desc.value = val3;
			window.opener.document.forms[0].hidParentLevel2.value = val5;
			alert(val5 + " val5 ");
			window.opener.doChange();
		}	
		window.close();
	}

	function callReset()
	{
		document.forms[0].txt_value.value==""
	}

function doClose()
{
	window.close();
}

    
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body>


<form name="appform" method="post" class="normal">
<table class="outertable"  width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		
      <td><b>Free Code Name</b></td>
	</tr>
	<tr>
		<td>&nbsp;</td>
	</tr>
</table>

<table class="outertable border1"  width="98%" border="0" cellpadding="5" cellspacing="0"
	align="center">
	<tr>
		<td valign="top">
		<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1">
			
			<tr>
				<td valign="top">
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr class="dataheader">
								
                        <td width="45%" align="center"><b>Code</b></td>
                        
                        <td width="48%" align="center"><b>Code Description</b></td>

							</tr>
						</table>
						</td>
					</tr>
					<tr>

						<td valign="top" align="center" height="230">
						<DIV class="cellcontainer">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="2">
							<%if (arrValues != null) {
				 arrSize = arrValues.size();
				ArrayList arrCol = null;
				for (int i = 0; i < arrSize; i++) {
					arrCol = new ArrayList();
					if (arrCol != null) {
						arrCol = (ArrayList) arrValues.get(i);

						%>
							<tr class="datagrid">
								
                          <td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>')"><%=Helper.correctNull((String) arrCol.get(1))%></a> 
                          </td>
                          
                          <td width="48%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>','<%= Helper.correctNull((String)arrCol.get(1))%>','<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a> 
                          </td>
								
							</tr>
							<%}
				}
			}
			%>
							<tr class="datagrid">
								
                          
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
							
							<%if (arrSize == 0) { %>	
							</tr>
							<tr class="datagrid">
								
                          
								
                          <td colspan="2" align="center"><b>NO DATA FOUND</b>&nbsp;</td>
								
							</tr>
							<%} %>
							<tr class="datagrid">
								
                          
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                         
								
                          <td width="45%">&nbsp;</td>
                          
                          <td width="48%">&nbsp;</td>
								
							</tr>
						</table>
						</div>
						<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>

		</td>
	</tr>
</table>

   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidvalue">
</form>
</body>
</html>
