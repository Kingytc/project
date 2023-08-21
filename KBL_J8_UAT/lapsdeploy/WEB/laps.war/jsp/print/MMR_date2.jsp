<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%

String MMRyear1="";
MMRyear1=Helper.correctNull((String)hshValues.get("MMRyear"));

ArrayList al=new ArrayList();
al=(ArrayList)hshValues.get("MonthlyStatus");


//out.println("hshValues"+al.size());
%>
<html>
<head>
<title>Monthly Statement of Advances</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
.fontstyle {  font-family: "MS Sans Serif"; font-size: 10px; font-weight: bold; color: #000000; text-decoration: none}
input {  font-family: "MS Sans Serif"; font-size: 9px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript">
function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/perexisting.jsp";
		document.forms[0].submit();
	}
}

</script>
</head>
<%
String strUser =(String)session.getAttribute("strUserId");

String strOrgName =(String)session.getAttribute("strOrgName");

String strmonthWords="";
String date=Helper.getCurrentDateTime();

String year=date.substring(6,10);

String month=Helper.correctNull((String)hshValues.get("MMRmonth"));

if(month.equalsIgnoreCase("01")){
	strmonthWords="January";
}
else if(month.equalsIgnoreCase("02")){
	strmonthWords="February";
}
else if(month.equalsIgnoreCase("03")){
	strmonthWords="March";
}
else if(month.equalsIgnoreCase("04")){
	strmonthWords="April";
}
else if(month.equalsIgnoreCase("05")){
	strmonthWords="May";
}
else if(month.equalsIgnoreCase("06")){
	strmonthWords="June";
}
else if(month.equalsIgnoreCase("07")){
	strmonthWords="July";
}
else if(month.equalsIgnoreCase("08")){
	strmonthWords="August";
}
else if(month.equalsIgnoreCase("09")){
	strmonthWords="September";
}
else if(month.equalsIgnoreCase("10")){
	strmonthWords="October";
}
else if(month.equalsIgnoreCase("11")){
	strmonthWords="November";
}
else if(month.equalsIgnoreCase("12")){
	strmonthWords="December";
}

ArrayList alValue=new ArrayList();
ArrayList collat=new ArrayList();
ArrayList collatVal=new ArrayList();
ArrayList arryCol=null;
ArrayList arryRow=(ArrayList)hshValues.get("arrVal");



%>
<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td>
      <table width="74%" border="0" cellspacing="0" cellpadding="3" align="center" height="48">
        <tr>
          <td>
            <p>Monthly Statement of Advances granted during the Month of <b><%=strmonthWords %> <%=MMRyear1%></b></p>
            </td>
        </tr>
      </table>
      <table width="75%" border="0" cellspacing="0" cellpadding="3" align="center">
        <tr> 
          <td>Branch:<b> <%=strOrgName %></b></td>
          
        </tr>
      </table>
      <p>&nbsp;</p>
     
      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolor='#eeeeee'>
        <tr> 
          <td rowspan="2"> 
            <div align="left">S No</div>
           
          </td>
          <td rowspan="2"> 
            <div align="left">Name of the Account</div>
          </td>
          <td rowspan="2"> 
            <p align="left">Sanction Number &amp;</p>
            <p align="left">Date</p>
          </td>
          <td rowspan="2"> 
            <p align="left">Nature of </p>
            <p align="left">Activity</p>
          </td>
          <td colspan="2"> 
            <div align="left">Health Indicators</div>
          </td>
          <td rowspan="2"> 
            <div align="left">Purpose of Advance</div>
          </td>
          <td rowspan="2"> 
            <div align="left">Rate of Interest</div>
          </td>
          <td colspan="3"> 
            <div align="center">Credit Facilities Sanctioned</div>
          </td>
          <td colspan="2"> 
            <div align="center">Securities</div>
          </td>
          <td rowspan="2"> 
            <div align="left">Remarks</div>
          </td>
        </tr>
        <tr> 
          <td width="1%"> 
            <div align="left">Asset Classification</div>
          </td>
          <td width="5%"> 
            <div align="left">Credit Rating &amp; Score/Grade</div>
          </td>
          <td width="5%"> 
            <div align="left">Nature of Facility</div>
          </td>
          <td width="3%"> 
            <div align="left">Existing Limit(Rs)</div>
          </td>
          <td width="5%"> 
            <div align="left">Reviewed/Increases/Fresh Limits (Rs) </div>
          </td>
          <td width="0%"> 
            <div align="left">Prime(Nature &amp; Value)</div>
          </td>
          <td width="0%"> 
            <div align="left">Collateral(Nature &amp; Value)</div>
          </td>
        </tr>
    <% 
      for(int i=0;i<al.size();i++)
      {
    	  alValue=(ArrayList)al.get(i);
    	  String desg=(String)alValue.get(17);
    	  if(desg.equalsIgnoreCase("1"))
    			  {
    		  desg="Executive";
    			  }
    	  else if(desg.equalsIgnoreCase("2"))
    			  {
    		  desg="Self Employed";
    			  }
    	  else if(desg.equalsIgnoreCase("3"))
    			  {
    		  desg="Junior Clerk";
    			  }
    	  else if(desg.equalsIgnoreCase("4"))
    			  {
    		  desg="Others";
    			  }
    	  %>
        <tr> 
     
          <td width="1%">&nbsp;    <%=
            (String)alValue.get(3)%></td>
          <td width="11%">&nbsp;  <%=
            (String)alValue.get(4)%></td>
          <td width="10%">&nbsp;<%=
            (String)alValue.get(5)%></td>
          <td width="4%">&nbsp;
         
          </td>
          <td width="1%">&nbsp;
          
          
          </td>
          <td width="5%">&nbsp;   <%=
         (String)alValue.get(13)%>
          
          </td>
          <td width="10%">&nbsp;  <%=
            (String)alValue.get(2)%></td>
          <td width="7%">&nbsp;  <%=
            (String)alValue.get(0)%></td>
          <td width="5%">&nbsp;
           <%=
            (String)alValue.get(18)%>
          </td>
          <td width="3%">&nbsp;   <%=
            (String)alValue.get(1)%></td>
          <td width="5%">&nbsp;
            <%=
            (String)alValue.get(19)%>
          </td>
          <td width="0%">&nbsp;
          <% if((String)alValue.get(6)!="" && (String)alValue.get(6)!= null)
          {
          out.println("Equitable  mortgage of House/Flat at");
                  }%><%=
            (String)alValue.get(6)%>
            <%=
            (String)alValue.get(7)%>
            <%=
            (String)alValue.get(8)%>
            <%=
            (String)alValue.get(9)%>
            <%=
            (String)alValue.get(10)%>
            <%=
            (String)alValue.get(11)%>
            
           <% if((String)alValue.get(15)!="" && (String)alValue.get(15)!= null)
          {
        	   out.println("Hypothecation of vehicle   Make & Model ");
          }
           %><%=
            (String)alValue.get(15)%>
            <%=
            (String)alValue.get(16)%>
            
            
            </td>
          
          
          <td width="5%">&nbsp;
          <%
          collat=(ArrayList)alValue.get(12);
          for(int j=0;j<collat.size();j++)
          {
        	  collatVal=(ArrayList)collat.get(j);
          
          %>Hypothecation charge over 
          <%=
            (String)collatVal.get(1)%>,<%=
            (String)collatVal.get(2)%>,<%=
            (String)collatVal.get(3)%>,<%=
            (String)collatVal.get(4)%> Belonging to
            <%=
            (String)collatVal.get(6)%><br><br>
             <%
          }
          %>
            
            </td>
          
         
          <td width="7%">&nbsp;</td>
        </tr>
        <%
      
      }
      %>
          
      </table>
      
      <p>&nbsp;</p>
      <p>&nbsp;</p></td>
     
  </tr>
  <tr> <td> <div align="right">Signature</div></td></tr>
</table>

</body>
</html>
