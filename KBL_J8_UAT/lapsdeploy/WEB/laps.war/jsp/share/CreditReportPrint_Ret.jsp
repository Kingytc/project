<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />
<%
ArrayList arrAppDetails=new ArrayList();
ArrayList arrRow=new ArrayList();

arrAppDetails=(ArrayList)hshValues.get("arrAppDetails");

%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Credit Report</title>
<style type="text/css">
<!--
body,td,th {
	font-family: verdana;
	font-size: 11px;
	color: #000000;
}
body {
	margin-left: 0px;
	margin-top: 0px;
	margin-right: 0px;
	margin-bottom: 0px;
}
-->
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/link.css" type="text/css"/>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr> 
    <td align="center" colspan="3"><b><font size="2" face="MS Sans Serif">Union 
      Bank of India</font></b></td>
  </tr>
  <tr> 
    <td align="center" colspan="3"><b><font size="2" face="MS Sans Serif"></font><%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  </tr>
  <tr> 
    <td align="center" colspan="3">&nbsp;</td>
  </tr>
  <tr bgcolor="#FFFFFF"> 
    <td align="center" colspan="3"><strong><font size="2" face="MS Sans Serif"> 
      Credit Report
      </font></strong></td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td valign="bottom" bgcolor="#FFFFFF" align="center" colspan="3"> <laps:application/></td>
  </tr>
  <tr> 
    <td width="37%"><strong>Name</strong></td>
    <td colspan="2" align="left">&nbsp;
      <%=Helper.correctNull((String) hshValues.get("perapp_fname"))%>
    </td>
  </tr>  
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td width="37%"><strong>ADDRESS WITH TELEPHONE NUMBER</strong></td>
    <td colspan="2">&nbsp;      
    </td>
  </tr>
  <tr> 
    <td colspan="3">
    &nbsp;<%=Helper.correctNull((String) hshValues.get("address"))%></br>
    &nbsp;<%=Helper.correctNull((String) hshValues.get("city_name"))%></br>
    &nbsp;<%=Helper.correctNull((String) hshValues.get("state_name"))%></br>
    &nbsp;Pincode:&nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_zip"))%></br>
    </br>
    &nbsp;Tel No :&nbsp;<%=Helper.correctNull((String) hshValues.get("perapp_phone"))%>
    </td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td width="37%"><strong>CONSTITUTION :</strong></td>
    <td colspan="2">&nbsp;<%=Helper.correctNull((String) hshValues.get("perinc_selfincometype"))%></td>
  </tr>
  <tr> 
    <td colspan="3">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"><strong>Full name of identical, connected or associated 
      firms giving the nature and place of business name(s) of their bankers with 
      address/es and details of credit facilities allowed by them. <br>
      Full names &amp; address of the individual, proprietor, partners, karta 
      and co-parceners, directors, etc. and their relationship with each other. 
      If any (brief report on the business means/assets of partners/directors 
      to be given on the reverse)</strong> <br>
    </td>
  </tr>
  <tr> 
    <td colspan="3"> 
      <table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="2">
          <tr > 
            <td rowspan="2" width="20%">
            <div align="center">Name &amp; Father s Name</div>
          </td>
            <td colspan="6">
            <div align="center">Address with Telephone Number</div>
          </td>
          </tr>
          <tr> 
            <td align="center" width="13%">Office</td>
            <td align="center" width="11%">Tel.No.</td>
            <td align="center" width="12%">Residence</td>
            <td align="center" width="13%">Tel.No.</td>
            <td align="center" width="17%">Permanent Address</td>
            <td align="center" width="14%">Tel. No.</td>
          </tr>
          <%
          	if(arrAppDetails.size()>0)
          	{
          		for(int i=0;i<arrAppDetails.size();i++)
          		{
          			arrRow=new ArrayList();
          			arrRow=(ArrayList)arrAppDetails.get(i);
          %>
          
          <tr> 
            <td width="20%"><%=arrRow.get(0)%><b>/</b></br><%=arrRow.get(1)%>		
            </td>
            <td width="13%">&nbsp;<%=arrRow.get(2)%>
            </td>
            <td width="11%">&nbsp;<%=arrRow.get(3)%>             
            </td>
            <td width="12%">&nbsp;<%=arrRow.get(4)%>               
            </td>
            <td width="13%">&nbsp;<%=arrRow.get(5)%>             
            </td>
            <td width="17%">&nbsp;<%=arrRow.get(6)%>               
            </td>
            <td width="14%">&nbsp;<%=arrRow.get(7)%>              
            </td>
          </tr>
          
         <%
          		}
         }
          	else
          	{
         %>
         	<tr> 
            <td width="20%">&nbsp;		
            </td>
            <td width="13%">&nbsp;
            </td>
            <td width="11%">&nbsp;           
            </td>
            <td width="12%">&nbsp;             
            </td>
            <td width="13%">&nbsp;             
            </td>
            <td width="17%">&nbsp;               
            </td>
            <td width="14%">&nbsp;             
            </td>
          </tr>
         <%
          	}
         %>
        </table>
      </td>
    </tr> 
</table>
</body>
</html> 
  