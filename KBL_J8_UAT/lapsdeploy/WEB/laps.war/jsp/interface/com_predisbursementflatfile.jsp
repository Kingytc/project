<%@include file="../share/directives.jsp"%>
<%String flag = "false";
			if (hshValues.get("flag") != null) {
				flag = "true";
			}
%>
<html>
<head>
<title>Pre-disbursement - Flat File Generation</title>
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
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentdate = "<%=Helper.getCurrentDateTime()%>";

function on_load()
{
	document.forms[0].txt_fromdate.focus();
}

function setValues()
{
	if(document.forms[0].rdo_type[0].checked==true)
	{
		document.forms[0].hid_option.value="R";
	}
	else if(document.forms[0].rdo_type[1].checked==true)
	{
		document.forms[0].hid_option.value="A";
	}
	else if(document.forms[0].rdo_type[2].checked==true)
	{
		document.forms[0].hid_option.value="T";
	}
	else if(document.forms[0].rdo_type[3].checked==true)
	{
		document.forms[0].hid_option.value="C";
	}
	else
	{
		document.forms[0].hid_option.value="";
	}
}

function callGenerate()
{
	if(document.forms[0].rdo_type[0].checked==false && document.forms[0].rdo_type[1].checked==false && document.forms[0].rdo_type[2].checked==false && document.forms[0].rdo_type[3].checked==false)
	{
		alert("Select any one option");
		document.forms[0].rdo_type[0].focus();
		return;
	}
	if(document.forms[0].txt_fromdate.value != "" && document.forms[0].txt_todate.value == "")
	{
		alert("Enter the to Date");
		document.forms[0].txt_todate.focus();
		return false;
	}
	if(document.forms[0].txt_fromdate.value == "" && document.forms[0].txt_todate.value == "")
	{
		alert("Enter the Date");
		document.forms[0].txt_fromdate.focus();
		return false;
	}
	if(document.forms[0].txt_fromdate.value == "" && document.forms[0].txt_todate.value != "")
	{
		var pagedate=document.forms[0].txt_todate.value;
		var pgdt=changeDateformat(pagedate);
		var maxdt=changeDateformat(currentdate);
		if(Date.parse(pgdt) > Date.parse(maxdt))
		{
			alert("Date cannot be greater than " +currentdate );
			document.forms[0].txt_todate.value="";
			document.forms[0].txt_todate.focus();
			return false;
		}
	}
	 var FileName='Predisbursementdetails';
	 var prop = "scrollbars=no,width=650,height=500,top=25,left=180";
	 var url=appURL+"action/"+FileName+".txt?hidBeanGetMethod=getPreDisbursementflatfileData&hidBeanId=FinacleBean&startdate="+document.forms[0].txt_fromdate.value+"&enddate="+document.forms[0].txt_todate.value+"&hid_option="+document.forms[0].hid_option.value;
	 window.open(url,"remarks",prop);
}
function doClose()
{
window.close();
}

function callCalender(fname)
{ 	
	showCal("<%=ApplicationParams.getAppUrl()%>",fname);
}
    
</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</head>
<body 
	onload="on_load()">
<form name="appform" method="post" class="normal">
<table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="2"
	align="center">
	
	<tr>
		<td><b>Pre-disbursement - Flat File Generation</b></td>
	</tr>
	
</table>

		<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="1">
			<tr>
				
            <td><table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr>
                 
                  <td width="26%" align="center"> 
                    <input type="radio" name="rdo_type" value="" style="border:none" onClick="setValues()">
                    Retail </td>
                  <td width="20%"> 
                    <input type="radio" name="rdo_type" value="" style="border:none" onClick="setValues()">
                    Agriculture</td>
                  <td width="21%"> 
                    <input type="radio" name="rdo_type" value="" style="border:none" onClick="setValues()">
                    Tertiary </td>
                  <td width="33%"> 
                    <input type="radio" name="rdo_type" value="" style="border:none" onClick="setValues()">
                    Corporate</td>
                </tr>
                <tr> 
                  
                  <td width="26%" align="right"> 
                    <table class="outertable" width="20%" border="0" cellspacing="0" cellpadding="3">
                      <tr>
                        <td><b>From</b></td>
                        <td> 
                          <input type="text"
							name="txt_fromdate"
							value="<%//=Helper.correctNull((String)hshValues.get("frmdate"))%>"
							size="11" maxlength="10"
							onBlur="checkDate(this);checkmaxdate(this,currentdate)"
							tabindex="1">
                        </td>
                        <td><a alt="Select date from calender"
							href="javascript:callCalender('txt_fromdate')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
                      </tr>
                    </table>
                  </td>
                  <td width="20%"> 
                    <table class="outertable" width="20%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td><b>To</b></td>
                        <td> 
                          <input type="text"
							name="txt_todate"
							value="<%//=Helper.correctNull((String)hshValues.get("todate"))%>"
							size="11" maxlength="10" tabindex="2"
							onBlur="checkDate(this);checkmindate(this,document.forms[0].txt_fromdate.value)">
                        </td>
                        <td><a alt="Select date from calender"
							href="javascript:callCalender('txt_todate')"><img
							src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
                      </tr>
                    </table>
                  </td>
                  <td align="center" colspan="2"> 
                    <input type="button" name="cmdgen"
							value="Generate"
							class="buttonothers"
							onClick="callGenerate()">
                  </td>
                  
                </tr>
                
                <%if (Helper.correctNull((String) hshValues.get("status")).equals(
					"success")) {

			%>
                <tr> 
                  <td nowrap colspan="5" align="center"><b>Application Status:</b>Flat 
                    file is generated</td>
                </tr>
                <%} else if (Helper.correctNull((String) hshValues.get("status"))
					.equals("fail")) {%>
                <tr> 
                  <td nowrap colspan="5" align="center"><b>Application Status:</b>Flat 
                    file is not generated</td>
                </tr>
                <%}%>
               
              </table> </td>
			</tr>
			
		</table>
		<br>
 <lapschoice:combuttonnew  btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>


<lapschoice:hiddentag pageid='<%=PageId%>'/> 

<input type="hidden" name="hid_option" value="">
</form>
</body>
</html>

