<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="#FFFFFF" text="#000000">
<table width="100%" border="0" cellspacing="0" cellpadding="1">
  <tr> 
    <td align="right" colspan="2"><u>FORMAT -9</u></td>
  </tr>
  <tr> 
    <td align="center" colspan="2"> 
      <p><u><b> LETTER OF UNDERTAKING (UNION RENT) (Annexure ? B to I.C. No. 6082 
        DATED 02-09-2000)</b></u></p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>From :<br>
        <br>
        (Borrowers name and address)</p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="left" colspan="2"> 
      <p>To, <br>
        Branch Manager,<br>
        <b>KARNATAKA BANK LTD.,</b><br>
        <b><%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch</p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td align="center" colspan="2"> 
      <p><b>LETTER OF UNDERTAKING</b></p>
      <p>&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td colspan="2"> 
      <p align="justify" >In consideration of your agreeing to sanction ________loan 
        of Rs. _____vide your sanction letter No.______dated ________ and General 
        Power of Attorney dated ______________ executed by me/us in your favour 
        to receive the monthly rent from the tenants/lessees/licensees of the 
        property which is owned by me/us, details of which are furnished in the 
        Schedule hereunder written, I/We hereby agree and irrevocably undertake 
        as under: <br>
      </p>
      <p align="justify" >&nbsp;</p>
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">i)</td>
    <td width="95%"> 
      <p align="justify">I/We hereby declare that I/We are the absolute owners 
        of the property as detailed in the schedule hereunder written and there 
        is no encumbrance created on the said property except Tenancy/Lease/License 
        which has been entered by me/us and the tenants/lessees/licensees and 
        I/we further agree and undertake that I/We shall not create any encumbrances 
        over the property prejudicial to your interest. <br>
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">ii)</td>
    <td width="95%"> 
      <p align="justify"> I/We shall instruct the tenants/lessees/licensees to 
        pay rents directly to you in terms of the said Power of Attorney and I/We 
        shall not receive any money/rent from the tenants/lessees/licensees without 
        your specific permission.<br>
      </p>
     
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">iii)</td>
    <td width="95%"> 
      <p align="justify"> I/We shall not revoke the said irrevocable General Power 
        of Attorney dated _____________ executed by me/us in your favour and in 
        case of any loss suffered by you by my/our act of commission /omission, 
        I/We shall indemnify and keep you indemnified against the loss caused 
        for the act of commission/omission which has been done by me/us. <br>
      </p>
      
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">iv)</td>
    <td width="95%"> 
      <p align="justify" > In case of premature termination of tenancy/lease/license, 
        if any, I/we agree and undertake that I/We shall inform you 2 months in 
        advance and also inform you the details of new tenancy/lease/license to 
        be entered with the tenants/lessees/licensees for the said premises to 
        enable you to collect the rent from the tenants/lessees/licensees in terms 
        of the General Power of Attorney dated_________________executed by me/us 
        in your favour<br>
      </p>
      
    </td>
  </tr>
  <tr> 
    <td width="5%" valign="top">v)</td>
    <td width="95%"> 
      <p align="justify" > I/We further agree and undertake that the breach of 
        the aforesaid conditions shall tantamount to the breach of the said sanction 
        letter issued by you in our favour and the said Power of Attorney dated 
        ___________executed by me/us in your favour and you shall be at liberty 
        to take such other action as you may deem fit against me/us. </p>
      
    </td>
  </tr>
</table>
</body>
</html>
