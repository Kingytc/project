<%@include file="../../share/directives.jsp"%>
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>

function showDateRange()
{
	
	if(document.forms[0].cmbperiod[document.forms[0].cmbperiod.selectedIndex].text == "Date Range")
	{
		document.all.a1.style.visibility="visible";
		document.forms[0].txtdfrom.focus();
					
	}
	else
	{
		document.all.a1.style.visibility="hidden";
	}
	
}
function doOk()
{
	var strFrom = document.forms[0].txtdfrom.value;
	var strTo = document.forms[0].txtdto.value;
	var bool = false;
	var per="";
	if (document.forms[0].cmbperiod.selectedIndex != -1 ) 
	{
		if(document.forms[0].cmbperiod[document.forms[0].cmbperiod.selectedIndex].text == "Date Range")
		{
			if (strFrom=="")
			{
				ShowAlert("112","From Date");
				return false;
			}
			if (strTo == "")
			{
				ShowAlert("112","To Date");
				return false;
			}
			bool = dateDiff();
		}
		else
		{
			bool = true;
		}
		
		if(bool == true)
		{
		per=document.forms[0].cmbperiod.options[document.forms[0].cmbperiod.selectedIndex].value;
		window.opener.document.forms[0].txt_period.value = getFromToDate(per);

		window.close();
		}
	}
	else
	{
		ShowAlert('111',"Period");
		document.forms[0].cmbperiod.focus();
		return false;
	}
}
function getFromToDate(period)
{
	var strToday="<%=(String)Helper.getCurrentDateTime()%>";
	var strFrom="";
	var strTo ="";
	var dd="";
	var mm="";
	var yy="";
	
	dd=strToday.substring(0,2);
	mm=strToday.substring(3,5);
	yy=strToday.substring(6,10);

	if (period=="Q1")
	{
		strFrom="01/04/"+yy;
		strTo="30/06/"+yy;
	}
	else if (period=="Q2")
	{
		strFrom="01/07/"+yy;
		strTo="30/09/"+yy;
	}
	else if (period=="Q3")
	{
		strFrom="01/10/"+yy;
		strTo="31/12/"+yy;
	}
	else if (period=="Q4")
	{
		strFrom="01/01/"+yy;
		strTo="30/04/"+yy;
	}
	else if (period=="H1")
	{
		strFrom="01/04/"+yy;
		strTo="30/09/"+yy;
	}
	else if (period=="H2")
	{
		strFrom="01/10/"+yy;
		strTo="31/03/"+yy;
	}
	else if (period=="Y")
	{
		strFrom="01/04/"+yy;
		strTo="31/03/"+(++yy);
	}
	else if (period=="D")
	{
		strFrom=document.forms[0].txtdfrom.value;
		strTo=document.forms[0].txtdto.value;
	}
	var strf= strFrom+"-"+strTo;
	if (period =="A")
	{
		strf ="All";
	}
	return strf;
}
function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function dayscalc(fromdt,todt)
{
	var fmonth = eval(fromdt.substring(0, 2));

	var fday = eval(fromdt.substring(3, 5));

	var fyear = eval(fromdt.substring(6, 10));

	var tmonth = eval(todt.substring(0, 2));

	var tday = eval(todt.substring(3, 5));

	var tyear = eval(todt.substring(6, 10));

var totdays = (((eval(tmonth) + (eval(tday) * 30)) + (eval(tyear) * 365)) - ((eval(fmonth) + (eval(fday) * 30)) + (eval(fyear) * 365)));

	return totdays;
}


 function dateDiff()
 {
	var ddiff=0;
	ddiff=dayscalc(document.forms[0].txtdfrom.value,document.forms[0].txtdto.value)
    
    if (ddiff<0)
    {
	alert("From Date cannot be greater than To Date");
	document.forms[0].txtdfrom.value = "";
	return false;
    }
      else
	{
	  return true;
	}
	
}

</script>

</head>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<body >
<form class="normal" name="form1" method="post" action="">
  <div align="center"> 
    
    <table class="outertable border1" border="0" cellspacing="0" cellpadding="3" width="300">
      <tr> 
        <td valign="top">
          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr class="dataHeader"> 
              <td colspan="2"><b>Select 
                Period</b></td>
            </tr>
            <tr> 
              <td colspan="2" align="center"> 
                <select name="cmbperiod" size=9 style="width:200" onChange="showDateRange() " onDblClick="doOk()">
                  <option value="A">All</option>
                  <option value="Q1">First Quarter</option>
                  <option value="Q2">Second Quarter</option>
                  <option value="Q3">Third Quarter</option>
                  <option value="Q4">Fourth Quarter</option>
                  <option value="H1">First Half</option>
                  <option value="H2">Second Half</option>
                  <option value="Y">Yearly</option>
                  <option value="D">Date Range</option>
                </select>
              </td>
            </tr>
            <tr> 
              <td colspan="2"> 
                <table class="outertable" width="100%" border="0">
                  <tr id ="a1" style="visibility:hidden"> 
                    <td  width="30%"> <font size="1" face="MS Sans Serif">From 
                      Date 
                      <input type="text" name="txtdfrom" size="12" maxlength="10" onBlur="checkDate(txtdfrom)">
                      </td>
                    <td width="20%" align="left" valign="bottom"><a alt="Select date from calender"  href="javascript:callCalender('txtdfrom')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
                    <td width="30%"> <font size="1" face="MS Sans Serif">To Date 
                      <input type="text" name="txtdto" size="12" maxlength="10"
			onBlur="checkDate(txtdto)">
                      </td>
                    <td width="20%" align="left" valign="bottom"><a alt="Select date from calender"  href="javascript:callCalender('txtdto')"><img src ="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr > 
               <lapschoice:combuttonnew btnnames="Ok" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
            </tr>
          </table>
        </td>
      </tr>
    </table>
   
    </div>
</form>
</body>
</html>
