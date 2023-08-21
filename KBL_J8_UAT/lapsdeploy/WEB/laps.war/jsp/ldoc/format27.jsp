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
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td colspan="3"> 
        <div align="right"><b><u>FORMAT 27<br>
          </u></b></div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"><u><b>Draft of Letter to be obtained when documents are 
        executed out of the branch premises by the Borrower/Guarantor<br>
        </b></u></td>
    </tr>
    <tr> 
      <td colspan="2" height="68"><br>
        <b>From </b>:<br>
        <br>
       
        
      </td>
      <td width="24%" height="68">Place :  <b> <%=Helper.correctNull((String) hshValues.get("cityName"))%></b></td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp; </td>
      <td width="24%"> Date:  <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        <br>
      </td>
      <td width="24%">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2"><b>To:<br>
        <br>
        </b> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="7%">&nbsp;</td>
            
          <td width="93%">The<br>
            Branch Manager,</td>
          </tr>
          <tr> 
            <td width="7%">&nbsp;</td>
            
          <td width="93%"><b>Karnataka Bank Ltd.,</b></td>
          </tr>
          <tr> 
            <td width="7%">&nbsp;</td>
            <td width="93%">
               <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch </td>
          </tr>
        </table>
        <b> <br>
        </b></td>
      <td width="24%"><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center">Sub: Execution of security Documents of the Bank.<br>
          -Confirmation Letter</div>
      </td>
      <td width="24%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="4%">Sir,</td>
      <td width="72%">&nbsp;</td>
      <td width="24%">&nbsp;</td>
    </tr>
    <tr>
      <td width="4%">&nbsp;</td>
      <td width="72%">This is to confirm the following:<br>
      </td>
      <td width="24%">&nbsp;</td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0"> </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td width="4%" height="27">(i) <br>
      </td>
      <td width="96%" rowspan="2"> <font face="Times New Roman" size="3"> 
              <p align="justify">   As I/we was/were unable to attend the Bank 
        for execution of the security documents required by you in connection 
        with the loan/advances granted to me/us/to M/s&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;&#133;I/we 
        had requested you to send the document/s to me/us for affixing my/our 
        signature in the said document/s</p> </font> </td>
    </tr>
    <tr> 
      <td width="4%">&nbsp;</td>
    </tr>
    <tr> 
      <td> <br>
        (ii)</td>
      <td> <br>
        I/we hereby confirm having executed the following documents received me/us 
        through your official/representative:</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td>a. <br>
        <br>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>b. </td>
      <td rowspan="2"><br>
      </td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td> c. <br>
        <br>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>d.<br>
        <br>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td>e.<br>
        <br>
      </td>
      <td>&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td><br>
        (iii)<br>
      </td>
      <td><br>
        I/We return herewith the said documents duly executed through your official/representative 
        for your safe custody/use.</td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        Yours truly,<br>
      </td>
    </tr>
  </table>
</body>
</html>