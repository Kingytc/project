<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCust");
			}
			
String strYearType = Helper.correctNull((String)request.getParameter("yeartype"));
String strhidYearType = Helper.correctNull((String)hshValues.get("hidyeartype"));

if(strhidYearType.equals(""))
{
	strhidYearType = strYearType;
}
int arrSize=0;

String strhidType = Helper.correctNull((String)request.getParameter("type"));
String strAgency =Helper.correctNull((String)request.getParameter("agency"));
if(strhidType.equals(""))
{
	strhidType = Helper.correctNull((String)hshValues.get("hidtype"));
}
if(strAgency.equals(""))
{
	strAgency = Helper.correctNull((String)hshValues.get("hidagency"));
}

			%>
		
			
						<%
String field=Helper.correctNull(request.getParameter("field"));
String num=Helper.correctNull(request.getParameter("num"));
int intLen=Integer.parseInt(Helper.correctInt((String)request.getParameter("len")));

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
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var yeartype = "<%=strhidYearType%>";
var type = "<%=strhidType%>";


var pagetype="<%=field%>";
var varnum="<%=num%>";
var varLen="<%=Integer.toString(intLen)%>";

	function callSearch()
	{
		var value = document.forms[0].txt_value.value;
		if(value == "")
		{
			alert("Enter atleast 3 characters");
			document.forms[0].txt_value.focus();
			return false;
		}
		if(callack())
		{
			document.forms[0].hidvalue.value="symbol";
			document.forms[0].method="post";
			document.forms[0].hidBeanGetMethod.value="getAgencyandSymbolList";
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].action=appURL+"action/searchsymbollist.jsp";	
			document.forms[0].submit();
		}
	}
	
	function callack()
	{
		var txtval=document.forms[0].txt_value.value;
		var txtlen=txtval.length;
	 		
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
			 document.forms[0].txt_value.focus();
			 return false;
	
		 }
		
		
		return true;
	}
	
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
	
	if(pagetype=="CEXR")
	{
		if(eval(varLen)>1)
		{
	
		if(yeartype == "P" && type=="S")
		{
			window.opener.document.forms[0].txt_pre_shortsymbol[varnum].value =val1+" - "+val2;
		}
		else if(yeartype == "P" && type=="L")
		{
			window.opener.document.forms[0].txt_pre_longsymbol[varnum].value =val1+" - "+val2;
		}
		else if(yeartype == "C" && type=="S")
		{
			window.opener.document.forms[0].txt_cur_shortsymbol[varnum].value =val1+" - "+val2;
		}
		else if(yeartype == "C" && type=="L")
		{
			window.opener.document.forms[0].txt_cur_longsymbol[varnum].value =val1+" - "+val2;
		}
		else
		{
			window.opener.document.forms[0].txt_symbol.value = val1;
			window.opener.document.forms[0].txt_meaning.value = val2;
			window.opener.document.forms[0].hidsno.value = val3;
			window.opener.document.forms[0].sel_active.value = val4;
			window.opener.document.forms[0].txtArea_definition.value = val5;
		}
		window.close();
	}

		else if(eval(varLen)==1)
		{
			
			if(yeartype == "P" && type=="S")
			{
				window.opener.document.forms[0].txt_pre_shortsymbol.value =val1+" - "+val2;
			}
			else if(yeartype == "P" && type=="L")
			{
				window.opener.document.forms[0].txt_pre_longsymbol.value =val1+" - "+val2;
			}
			else if(yeartype == "C" && type=="S")
			{
				window.opener.document.forms[0].txt_cur_shortsymbol.value =val1+" - "+val2;
			}
			else if(yeartype == "C" && type=="L")
			{
				window.opener.document.forms[0].txt_cur_longsymbol.value =val1+" - "+val2;
			}
			else
			{
				window.opener.document.forms[0].txt_symbol.value = val1;
				window.opener.document.forms[0].txt_meaning.value = val2;
				window.opener.document.forms[0].hidsno.value = val3;
				window.opener.document.forms[0].sel_active.value = val4;
				window.opener.document.forms[0].txtArea_definition.value = val5;
			}
			window.close();
		}

		

		
	}


	else 
	{
		
		if(yeartype == "P" && type=="S")
		{
			window.opener.document.forms[0].txt_pre_longsymbol.value =val1+" - "+val2;
		}
		else if(yeartype == "P" && type=="L")
		{
			window.opener.document.forms[0].txt_pre_longsymbol.value =val1+" - "+val2;
		}
		else if(yeartype == "C" && type=="S")
		{
			window.opener.document.forms[0].txt_cur_shortsymbol.value =val1+" - "+val2;
		}
		else if(yeartype == "C" && type=="L")
		{
			window.opener.document.forms[0].txt_cur_longsymbol.value =val1+" - "+val2;
		}
		else
		{
			window.opener.document.forms[0].txt_symbol.value = val1;
			window.opener.document.forms[0].txt_meaning.value = val2;
			window.opener.document.forms[0].hidsno.value = val3;
			window.opener.document.forms[0].sel_active.value = val4;
			window.opener.document.forms[0].txtArea_definition.value = val5;
		}
		window.close();
	}
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
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body >

<form name="appform" method="post" class="normal">
<table class="outertable"  width="98%" border="0" cellspacing="0" cellpadding="0"
	align="center">
	<tr>
		<td>&nbsp;</td>
	</tr>
	<tr>
		
      <td><b>Symbol Search</b></td>
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
				<td>

				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1">
					<tr>
						
						
                  <td align="right" width="22%"><b>Symbol</b></td>
						<td width="25%" align="center"><input type="text" name="txt_value"
							size="25" maxlength="70" onBlur="JavaScript:this.value =trim(this.value)"></td>

						<td width="35%"><input type="button" name="cmdsearch"
							value="Search"
							class="buttonstyle"
							onClick="callSearch()"></td>
					</tr>
					<tr>

						<td nowrap colspan="3">&nbsp;</td>

					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td valign="top">
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
					<tr>
						<td valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="3" >
							<tr class="dataheader">
								
                        <td width="10%">Sno</td>

								
                        <td width="45%" align="center">Symbol</td>

<td width="45%" align="center">Meaning</td>
								

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

								
                          <td width="10%"><%=i + 1%></td>
								
                          <td width="45%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(2))%>','<%= Helper.correctNull((String)arrCol.get(3))%>','<%= Helper.correctNull((String)arrCol.get(4))%>','<%= Helper.correctNull((String)arrCol.get(5))%>','<%= Helper.correctNull((String)arrCol.get(6))%>')"><%=Helper.correctNull((String) arrCol.get(2))%></a> 
                          </td>
							 <td width="45%"><%=Helper.correctNull((String) arrCol.get(3))%></td>	
							</tr>
							<%}
				}

			}

			%>
							<tr class="datagrid">
								
                          <td width="10%">&nbsp;</td>
								
                          <td width="45%">&nbsp;</td>
						  <td width="45%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="10%">&nbsp;</td>
								
                          <td width="45%">&nbsp;</td>
						  <td width="45%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="10%">&nbsp;</td>
								
                          <td width="45%">&nbsp;</td>
						  <td width="45%">&nbsp;</td>
								
							</tr>
							<%if (arrSize == 0) { %>	
							
							<tr class="datagrid">
													
                          <td colspan="3" align="center"><b>NO DATA FOUND</b>&nbsp;</td>
								
							</tr>
							<%} %>
							
							<tr class="datagrid">
								
                          <td width="10%">&nbsp;</td>
								
                          <td width="45%">&nbsp;</td>
						  <td width="45%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="10%">&nbsp;</td>
								
                          <td width="45%">&nbsp;</td>
						  <td width="45%">&nbsp;</td>
								
							</tr>
							
						</table>
						</div>
				<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
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
<input type="hidden" name="hidtype" value="<%=strhidType%>">
<input type="hidden" name="hidagency" value="<%=strAgency%>">
<input type="hidden" name="hidyeartype" value="<%=strhidYearType%>">
<input type="hidden" name="pageID" value="<%=Helper.correctNull((String)request.getParameter("pageID"))%>">
</form>
</body>
</html>
