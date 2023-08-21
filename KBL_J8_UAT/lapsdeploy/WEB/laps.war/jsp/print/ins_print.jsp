<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Technical / Inspection Report</title>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css"></link>
</head>
<body>
<table width="100%" border="0" cellspacing="0" cellpadding="3">
  <tr>
    <td align="center"><b><font size="2" face="MS Sans Serif">Karnataka Bank Ltd.</font></b></td>
  </tr>
  <tr> 
    <td align="center">&nbsp;</td>
  </tr>
   <tr bgcolor="#FFFFFF">
  <td align="center"><strong><font size="2" face="MS Sans Serif">
  <%String insflag=Helper.correctNull((String)hshValues.get("insflag"));
  if(insflag.equalsIgnoreCase("T")){ 
    out.println("TECHNICAL INSPECTION REPORT");
  }else if(insflag.equalsIgnoreCase("I")){
  out.println("INSPECTION REPORT");
	} %>
</font></strong></td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr>
		<td valign="bottom" bgcolor="#FFFFFF" align="center">
		<laps:application/></td>
    </tr>
  <tr> 
    <td><strong>(1) Purpose of Report</strong></td>
  </tr>
  <tr></tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top" >Existing<br />
            <br />
            ProjectNew Project <br />
            <br />
            (Appraisal)Sick Unit</td>
          <td width="63%" valign="top"> 
          <p><%=Helper.correctNull((String)hshValues.get("Purpose_of_Report"))%></p></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><strong>(2) Infrastructure Location Factors</strong></td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top">Raw Material Sources<br />
            <br />
            Water Arrangements<br />
            <br />
            Power<br />
            <br />
            Fuel<br />
            <br />
            Transportation and Communications<br />
            <br />
            Manpower<br />
            <br />
            Market For Products<br />
            <br />
            Workshop Facilities for Repairs<br />
            <br />
            Any Other Special Features such as special<br />
            facilities/concession available in the place/area<br />
            <br />
            Banking Facilities<br />
            <br />
            Effluent disposal and drainage;Pollution control and<br />
            environment safeguard measures; <br />
            permission of Pollution Control Authorities</td>
          <td width="63%" valign="top"> 
		   <p><%=Helper.correctNull((String)hshValues.get("Infra_Location_Factors"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td><strong>(3) Land and Building</strong></td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top">Land<br />
            <br />
            <br />
            Building</td>
          <td width="63%" valign="top"> 
		   <p><%=Helper.correctNull((String)hshValues.get("Land_Building"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td width="37%" valign="top"><strong>(4) Plant &amp; Machinery</strong></td>
          <td width="63%" valign="top"> 
		   <p><%=Helper.correctNull((String)hshValues.get("Plant_Machinery"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><strong>(5) Products</strong></td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("Products"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><strong>(6) Production</strong></td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("Production"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><strong>(7) Raw Materials</strong></td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("RawMaterials"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><strong>(8) Marketing</strong></td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top">Demand<br />
            <br />
            Arrangements</td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("Marketing"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><strong>(9) Profitability</strong></td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("Profitability"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td><strong>(10) Management</strong></td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="middle">Capabilities of following in Production, 
            marketing, Man management, financial management, general management 
            and quality control</td>
          <td width="63%" valign="top"> 
			<p><%=Helper.correctNull((String)hshValues.get("Management"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td> 
      <table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr> 
          <td width="37%" valign="top"><strong>(11) Conclusion</strong></td>
          <td width="63%" valign="top"> 
		   <p><%=Helper.correctNull((String)hshValues.get("Conclusion"))%></p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
  </tr>
</table>
</body>
</html>
