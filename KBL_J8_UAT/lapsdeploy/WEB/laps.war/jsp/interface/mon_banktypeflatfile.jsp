<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Bank Type - Flat File Generation</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function on_load()
{
	document.forms[0].txt_month.focus();
}
function callGenerate()
{
	if(document.forms[0].txt_month.value == "")
	{
		alert("Enter Month");
		document.forms[0].txt_month.focus();
		return false;
	}
	if(document.forms[0].txt_year.value == "")
	{
		alert("Enter Year");
		document.forms[0].txt_year.focus();
		return false;
	}

	month = document.forms[0].txt_month.value;
	year = document.forms[0].txt_year.value;
	var FileName='BANKINGDETAILS_'+'_'+month+'_'+year;
	var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	var url=appURL+"action/"+FileName+".txt?month="+month+"&year="+year+"&hidBeanGetMethod=monBankTypeFlatFile&hidBeanId=FinacleBean";
			 window.open(url,"MonBankType",prop);
			 self.close();

}

function checkmonth(obj)
{
	var month = obj.value;
	
	if((month ==0 || month>12) && month!="")
	{
	 	alert("Enter valid number for month");	
	 	document.forms[0].txt_month.value="";
	 	document.forms[0].txt_month.focus();	
	 	return false;
	}	

}

function checkyear(obj)
{
	var year = obj.value;
	
	if((year ==0 || year.length<4) && year!="")
	{
	 	alert("Enter valid number for year");	
	 	document.forms[0].txt_year.value="";
	 	document.forms[0].txt_year.focus();	
	 	return false;
	}	

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
<body onload="on_load()">

<form name="appform" method="post" class="normal">
<table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	
	<tr>

		
      <td><b>Bank Type - Flat File Generation</b></td>
	</tr>
	
</table>

<table class="outertable border1" width="100%" border="0" cellpadding="5" cellspacing="0" 	align="center">
	<tr>
		<td >
		

				<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
					<tr>


						<td align="right" width="20%"><b>Month</b></td>
						<td width="20%" align="center"><input type="text"
							name="txt_month"
							value="<%//=Helper.correctNull((String)hshValues.get("frmdate"))%>"
							size="13" maxlength="2"  tabindex="1"  onkeypress="allowInteger()" onblur="checkmonth(this)"> </td>
						
                  <td align="right" width="20%"><b>Year</b></td>
						<td width="20%" align="center"><input type="text"
							name="txt_year"
							value="<%//=Helper.correctNull((String)hshValues.get("todate"))%>"
							size="13" maxlength="4" tabindex="2" onkeypress="allowInteger()" onblur="checkyear(this)">
						</td>
						<td width="30%" align="right"><input type="button" name="cmdgen"
							value="Generate" class="buttonothers" onClick="callGenerate()"></td>
					</tr>
					
				</table>
				

		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>


<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanId" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidvalue" value="">
	</form>
</body>
</html>
