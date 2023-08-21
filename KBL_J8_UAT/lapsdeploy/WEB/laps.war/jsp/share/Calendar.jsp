<%@include file="../share/directives.jsp"%>
<% response.setHeader("Cache-Control","no-store"); %>
<%
	String strDOW = "";
	String strMonth = "";
	String strYear="";	
	String strMonthnm = "";
	String strMonnum = "";	
	String strFldName="";	
	String strTemp = "window.opener";
	String strSysDay = "";
			
	int intYear = 0;
	int curYear = 0;
	int intMonth = 0;	
	int intStartYear;	
	int intStopYear;				
	int noDays=0;					
	int intDOW= 0;					
	int intLCount = 0;				
	String[] strMonthName = {"January","February","March","April","May","June","July","August","September", 		       		 "October","November","December"};
	
%>

<%	
	String strAppPath		=  ApplicationParams.getAppUrl();
	
	strFldName = request.getParameter("fname");

    if (!(request.getParameter("month") == null) || !(request.getParameter("year") == null))
	{
		strMonth=request.getParameter("month");
		strYear=request.getParameter("year");
	}
	else
	{
		strMonth = null;
		strYear = null;
	}

	Calendar calen = Calendar.getInstance();
	//first time when the Calendar.jsp invoked
	if(strMonth==null || strYear==null)						
	{
		strMonth = String.valueOf(calen.get(Calendar.MONTH));// calculate the month number
		strYear = String.valueOf(calen.get(Calendar.YEAR));  // calculate the year
		curYear = calen.get(Calendar.YEAR);					 // calculate the current year
		calen.set(Calendar.DAY_OF_MONTH, 1);				 // set Day of Month value to 1	
		intDOW = calen.get(Calendar.DAY_OF_WEEK);			 // calculate the Day of week	
		intMonth = Integer.parseInt(strMonth);				 // to find the Month name
		strMonthnm = strMonthName[intMonth];
	}
	// when the user select particular year or month from the calendar window
	else			
	{
		strMonth = strMonth;
		intMonth = Integer.parseInt(strMonth);				// conver the string parameter to integer  	
		intYear = Integer.parseInt(strYear);				// conver the string parameter to integer	
		curYear = calen.get(Calendar.YEAR);					// calculate the current year

		calen.set(Calendar.MONTH, intMonth );				// set the Calendar month to user interest
		calen.set(Calendar.YEAR, intYear);					// set the Calendar year to user interest
		calen.set(Calendar.DAY_OF_MONTH, 1);				//	set the Day of Month to 1

		strMonth = String.valueOf(calen.get(Calendar.MONTH));
		strYear = String.valueOf(calen.get(Calendar.YEAR));
		intYear = calen.get(Calendar.YEAR);
		
		intDOW = calen.get(Calendar.DAY_OF_WEEK);			//	calculate the Day of Week
		intMonth = Integer.parseInt(strMonth);
		strMonthnm = strMonthName[intMonth];				//  to find the Month Name
	}
	intStartYear = curYear-90;
	intStopYear = curYear+75;

	Calendar cal = Calendar.getInstance();
	strSysDay = String.valueOf(cal.get(Calendar.DATE));
	
	// to calculate Number of Days in a month
	if((strMonthnm.equalsIgnoreCase("January"))||(strMonthnm.equalsIgnoreCase("March"))||(strMonthnm.equalsIgnoreCase("May"))||(strMonthnm.equalsIgnoreCase("July"))||strMonthnm.equalsIgnoreCase("August")||strMonthnm.equalsIgnoreCase("October")||strMonthnm.equalsIgnoreCase("December"))
	{
		noDays = 31;
	}
	else if(strMonthnm.equalsIgnoreCase("February"))
	{
		if((Integer.parseInt(strYear)%4==0)||(Integer.parseInt(strYear)%100==0))
			noDays = 29;
		else
			noDays = 28;
	}
	else
	{
		noDays = 30;
	}
	strDOW = String.valueOf(intDOW);
	strMonnum = strMonth;
	strMonth  = strMonthnm ;
%>

<html>
<head>
<title>Calendar Monthly View</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript">
var fld = "<%=strFldName%>";
var tem="<%=strTemp%>";

function calc(month,year)
{
	var selyr = document.MonthlyView.choYear.selectedIndex;
	var yr = document.MonthlyView.choYear.options[selyr].value;
	document.MonthlyView.action="<%= strAppPath%>action/Calendar.jsp?month="+month+"&year="+yr+"&fname="+fld;
	document.MonthlyView.submit();
}
function closewin()
{
	<%=strTemp%>.document.forms[0].<%=strFldName%>.focus();
	window.close();
}


</script>
<link rel="stylesheet" href="<%=strAppPath%>css/style.css" type="text/css">
</head>

<body>
<form name="MonthlyView" method="post" class="normal">
  <table border="0" cellspacing="0" cellpadding="0" class="calendarWrap outertable border1" width="98%" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="1" >
          <tr >
            <td width="94%"><b style="color:#fff;font-size:12px;">Calender</b></td>
            <td width="6%"><b><select name="choYear" onChange="calc(<%=strMonnum%>,this.value)" style="FONT-FAMILY: Arial; FONT-SIZE: 8pt;COLOR: #CC3300">
                <%for(int i=intStartYear;i<=intStopYear;i++){%>
	<option value="<%=i%>" 
<%if(i==Integer.parseInt(strYear)) 
	out.println("selected");
	%>><%=i%></option>
<%}%>
              </select>
              </b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" class="linebor" width="98%" align="center">
    <tr class="calendarHeader" align="center"> 
      <td><a href="javascript:calc(00,<%=strYear%>)" border="0" class="whitefont">Jan</a></td>
      <td><a href="javascript:calc(01,<%=strYear%>)" border="0" class="whitefont">Feb</a></td>
      <td><a href="javascript:calc(02,<%=strYear%>)" border="0" class="whitefont">Mar</a></td>
      <td><a href="javascript:calc(03,<%=strYear%>)"  border="0" class="whitefont">Apr</a></td>
      <td><a href="javascript:calc(04,<%=strYear%>)"  border="0" class="whitefont">May</a></td>
      <td><a href="javascript:calc(05,<%=strYear%>)"  border="0" class="whitefont">Jun</a></td>
    </tr>
    <tr class="calendarHeader" align="center"> 
      <td><a href="javascript:calc(06,<%=strYear%>)" border="0" class="whitefont">Jul</a></td>
      <td><a href="javascript:calc(07,<%=strYear%>)" border="0" class="whitefont">Aug</a></td>
      <td><a href="javascript:calc(08,<%=strYear%>)" border="0" class="whitefont">Sep</a></td>
      <td><a href="javascript:calc(09,<%=strYear%>)" border="0" class="whitefont">Oct</a></td>
      <td><a href="javascript:calc(10,<%=strYear%>)" border="0" class="whitefont">Nov</a></td>
      <td><a href="javascript:calc(11,<%=strYear%>)" border="0" class="whitefont">Dec</a></td>
    </tr>
  </table>
  <table border="0" cellspacing="0" cellpadding="0" class="outertable linebor calena"  width="98%" align="center">
    <tr align="center" class="dataheader-month"> 
      <td colspan="7"><b><%= strMonth %>&nbsp;<%= strYear %> 
        </b></td>
    </tr>
    <tr align="center" class="calendarHeader"> 
      <td><b>Sun</b></td>
      <td><b>Mon</b></td>
      <td><b>Tue</b></td>
      <td><b>Wed</b></td>
      <td><b>Thu</b></td>
      <td><b>Fri</b></td>
      <td><b>Sat</b></td>
    </tr>
    <tr class="calendarGrid"> 
      <%
	intLCount=0;
	int j = 1;		
	for(j=1;j<=Integer.parseInt(strDOW)-1;j++)
	{
		intLCount++;
%>
      <td valign="top">&nbsp;</td>
      <%
	}
	
	for(int i=1;i<=noDays;i++)
	{
		if(i==Integer.parseInt(strSysDay))
		{
	%>
      <td align="center" class="dataheader">
	<%
		}
		else
		{
	%>
	<td align="center"  class="calendarGrid">
	<%}
		if(((intLCount+1)%7==0)||((intLCount)%7==0))			
		{	
			out.println( " <a  href='#' onClick=" +strTemp+".document.forms[0]."+strFldName+".value='"+i+"/"+(Integer.parseInt(strMonnum)+1)+"/"+strYear+"';javascript:closewin();>&nbsp;"+i+"&nbsp;</a>");			
		}
		else
		{
			out.println( " <a  href='#' onClick=" +strTemp+".document.forms[0]."+strFldName+".value='"+i+"/"+(Integer.parseInt(strMonnum)+1)+"/"+strYear+"';javascript:closewin();>&nbsp;"+i+"&nbsp;</a>");
		}
		intLCount++;
		if(intLCount%7 == 0)
		{
			intLCount=0;
			out.println("</td><tr class='datagrid'>");
		}
	}
%>
      </td>
    </tr>
  </table>
  <br>
</form> 
</body>
</html>