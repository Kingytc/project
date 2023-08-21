<%@ include file="../share/directives.jsp"%>

<%ArrayList arrValues = new ArrayList();

			if (hshValues != null) {
				arrValues = (ArrayList) hshValues.get("arrCust");
			}
			
String strYearType = Helper.correctNull((String)request.getParameter("yeartype"));
String strhidYearType = Helper.correctNull((String)hshValues.get("hidyeartype"));
String strPagefrom = Helper.correctNull((String)hshValues.get("pagefrom"));
if(strPagefrom.equalsIgnoreCase(""))
{
	strPagefrom = Helper.correctNull((String)hshValues.get("hidpagefrm"));	
}
if(strhidYearType.equals(""))
{
	strhidYearType = strYearType;
}
int arrSize =0;


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
	<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var yeartype = "<%=strhidYearType%>";
var pagetype="<%=field%>";
var varnum="<%=num%>";
var varLen="<%=Integer.toString(intLen)%>";
var varPagefrom="<%=strPagefrom%>";

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
		
			document.forms[0].hidvalue.value="agency";
			document.forms[0].method="post";
			document.forms[0].hidBeanGetMethod.value="getAgencyandSymbolList";
			document.forms[0].hidBeanId.value="limitmaster";
			document.forms[0].action=appURL+"action/searchagencylist.jsp";	
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

function setValues(val1)
{

	if(pagetype=="CEXR")
	{
		if(eval(varLen)>1)
		{
			if(yeartype == "P")
			{
				window.opener.document.forms[0].txt_pre_agency[varnum].value = val1;	

				window.opener.document.forms[0].txt_pre_longsymbol[varnum].value="";
			}
			else if(yeartype == "C")
			{
				window.opener.document.forms[0].txt_cur_agency[varnum].value = val1;
			}
			else
			{
				window.opener.document.forms[0].txt_pre_agency[varnum].value = val1;
				window.opener.document.forms[0].txt_pre_longsymbol[varnum].value="";
			}
			window.close();
		}
		else if(eval(varLen)==1)
		{
			if(yeartype == "P")
			{
				window.opener.document.forms[0].txt_pre_agency.value = val1;	
				window.opener.document.forms[0].txt_pre_longsymbol.value="";
			}
			else if(yeartype == "C")
			{
				window.opener.document.forms[0].txt_cur_agency.value = val1;
				
			}
			else
			{
				window.opener.document.forms[0].txt_pre_agency.value = val1;
				window.opener.document.forms[0].txt_pre_longsymbol.value="";
			}
			window.close();
		}
	}
	else if(varPagefrom == "setuprating")
	{
		window.opener.document.forms[0].txt_agency.value = val1;
		window.close();
	}
	else
	{
		
		if(yeartype == "P")
		{
			window.opener.document.forms[0].txt_pre_agency.value = val1;	
		}
		else if(yeartype == "C")
		{
			window.opener.document.forms[0].txt_cur_agency.value = val1;
		}
		else
		{
			window.opener.document.forms[0].txt_pre_agency.value = val1;
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
		
      <td><b>Agency Name Search</b></td>
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
						
						
                  <td align="right" width="22%"><b>Agency Name</b></td>
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
				<table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>
						<td valign="top">
						<table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="3">
							<tr class="dataheader">
								
                        <td width="7%"><b>Sno</b></td>

								
                        <td width="93%" align="center"><b>Agency Name</b></td>


								

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

								
                          <td width="7%"><%=i + 1%></td>
								
                          <td width="93%"><a
									href="javascript:setValues('<%= Helper.correctNull((String)arrCol.get(0))%>')"><%=Helper.correctNull((String) arrCol.get(0))%></a> 
                          </td>
								
							</tr>
							<%}
				}

			}
							

			%>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>
							<%if (arrSize == 0) { %>	
							</tr>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td colspan="2" align="center"><b>NO DATA FOUND</b>&nbsp;</td>
								
							</tr>
							<%} %>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>

								
							</tr>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>
								
							</tr>
							<tr class="datagrid">
								
                          <td width="7%">&nbsp;</td>
								
                          <td width="93%">&nbsp;</td>
								
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
<input type="hidden" name="hidyeartype" value="<%=strhidYearType%>">
<input type="hidden" name="hidpagefrm" value="<%=strPagefrom%>">
</form>
</body>
</html>
