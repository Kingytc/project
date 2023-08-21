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
<table width="100%" border="0" cellspacing="0" cellpadding="5">
  <tr>
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td>
            <div align="center"><b><u>LETTER OF CONTINUITY (AD-09)</u></b></div>
          </td>
        </tr>
        <tr>
          <td>
            <p><b>KARNATAKA BANK LTD.</b><br>
              <%=Helper.correctNull((String)hshValues.get("branchName"))%> Branch</p>
            <p>Dear Sirs,</p>
            <p align="justify">I/We beg to enclose a Demand Promissory Note for <b>Rs &nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              (Rupees&nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%></b> 
              ) signed by me/us which is given to you as security for the repayment 
              of any overdraft/Cash credit which is at present outstanding in 
              my/our name or in the name of either of us and also for the repayment 
              of any over draft/Cash credit to the extent of <b>Rs&nbsp;<%=Helper.correctNull((String) hshValues.get("sancamount"))%></b> 
              (Rupees &nbsp;<b><%=Helper.figtoWords((String) hshValues.get("sancamount"))%>)</b> 
              which I/We or either of us may avail of hereafter and the said Promissory 
              Note is to be security to you for the repayment of the ultimate 
              balance or sum remaining unpaid on the overdraft/Cash credit and 
              I ami We are to remain liable on the said Promissory Note notwithstanding 
              the fact that by payments made into the account of the said overdraft/Cash 
              credit from time to time the said overdraft/ cash credit may from 
              time to time be reduced or extinguished or even that the balance 
              of the said account may be at credit although the said overdraft/cash 
              credit account is in the name of ___________________________________________________________________________ 
              and will be operated only by the said_______________________________________<br>
            </p>
            <p align="right">&nbsp;</p>
            <p align="right">Yours Faithfully <br>
           &nbsp; &nbsp;<%=Helper.correctNull((String) hshValues.get("appname"))%><br> </p>
            <p align="right">&nbsp;</p>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr>
                <td width="41%">&nbsp;</td>
                <td width="20%"> 
                  <p>Full Names</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>___________________________________</p>
                  <p>___________________________________</p>
                </td>
                <td width="39%"> 
                  <p>Signature</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>__________________________________</p>
                  <p>___________________________________</p>
                  <p>___________________________________</p>
                </td>
              </tr>
            </table>
            <p>&nbsp; </p>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
