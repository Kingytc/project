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
            <div align="right">ANNEXURE-III</div>
          </td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td> 
            <div align="center"><b>KARNATAKA BANK LTD.</b><br>
             <b> <%=Helper.correctNull((String) hshValues.get("branchName"))%></b> Branch <br>
            </div>
          </td>
        </tr>
        <tr>
          <td>
            <div align="center">
              <table width="98%" border="0" cellspacing="0" cellpadding="5" height="114">
                <tr>
                  <td height="107" width="50%"> 
                    <p><b>DIVISIONAL OFFICE</b>:</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                    <p>&nbsp;</p>
                  </td>
                  <td height="107" width="50%"><b>FOR OFFICE USE ONLY</b><br>
                    <table width="57%" border="0" cellspacing="0" cellpadding="5">
                      <tr>
                        <td width="68%">Ref.No </td>
                        <td width="32%">Date: <b> <%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></td>
                      </tr>
                    </table>
                  Collection No.<br>
                    <br>
                    Policy No.<br>
                    <br>
                    <p>&nbsp;</p></td>
                </tr>
              </table>
              <br>
              <table width="98%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td> 
                    <div align="center">
                      <p><u><b>PROPOSAL FOR SPECIAL CONTINGENCY POLICY</b></u></p>
                      <p>&nbsp;</p>
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td> 
                    <table width="98%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td width="42%"> 
                          <div align="center"><b>NAME OF PROPOSER</b></div>
                        </td>
                        <td width="58%"> 
                          <div align="center"><b>KARNATAKA BANK LTD.</b></div>
                        </td>
                      </tr>
                      <tr> 
                        <td width="42%" height="13"><b>ADDRESS</b></td>
                        <td width="58%" height="13">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Name of Insured Person(Borrower)</b></td>
                        <td width="58%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Date of Birth/Age</b></td>
                        <td width="58%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Business(Please describe fully)</b></td>
                        <td width="58%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Has the insured person suffered or 
                          suffer from any physical defect or disability</b></td>
                        <td width="58%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Address of the property to be insured</b></td>
                        <td width="58%">&nbsp;</td>
                      </tr>
                    </table>
                    <table width="98%" border="1" cellspacing="0" cellpadding="5">
                      <tr> 
                        <td width="42%"><b>Type of construction</b></td>
                        <td width="58%"><b>PUCCA</b></td>
                      </tr>
                      <tr> 
                        <td width="42%"><b>Sum Insured-For Fire Cover*<br>
                          &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; 
                          &nbsp; &nbsp; &nbsp; For Personal Accident&nbsp;</b></td>
                        <td width="58%"><b>Rs.<br>
                          Rs. </b></td>
                      </tr>
                    </table>
                    <div align="center">
                      <p><br>
                        <b><font size="+1">. </font></b>* Sum Insured for Fire 
                        coved should represent atleast total Loan amount<br>
                        <b><font size="+1">.</font></b> ** Sum Insured or Personal 
                        Accident cover should be the Loan amount</p>
                      <table width="98%" border="0" cellspacing="0" cellpadding="5">
                        <tr>
                          <td>
                            <p><b><u>Perils to be covered:</u></b></p>
                            <p>1.As per the perils coverd in Special Contingency 
                              Policy<br>
                              2.As per Table 1 of P.A.POLICY(Death Only)</p>
                            <table width="98%" border="0" cellspacing="0" cellpadding="5">
                              <tr> 
                                <td width="49%">Period of Insurance :From </td>
                                <td width="21%">to</td>
                                <td width="25%">(No of Years</td>
                                <td width="5%">)</td>
                              </tr>
                            </table>
                            <table width="98%" border="0" cellspacing="0" cellpadding="5">
                              <tr>
                                <td>I/We declare that the forgoing statement are 
                                  true to the best of my/our knowledge and better</td>
                              </tr>
                            </table>
                            <p>&nbsp;</p>
                            <table width="98%" border="0" cellspacing="0" cellpadding="5">
                              <tr> 
                                <td width="33%"> 
                                  <p>Date: <%=Helper.correctNull((String)hshValues.get("Curdate"))%><br>
                                  </p>
                                  <p>Place: <%=Helper.correctNull((String)hshValues.get("branchName"))%></p>
                                </td>
                                <td width="37%"> 
                                  <p><br>
                                  </p>
                                  <p align="center"><b>SIGNATURE OF INSURED PERSON</b></p>
                                </td>
                                <td width="30%"> 
                                  <p>&nbsp;</p>
                                  <p align="center"><b>SIGNATURE OF PROPOSER<br>
                                    (BANK)</b></p>
                                </td>
                              </tr>
                            </table>
                            <table width="98%" border="0" cellspacing="0" cellpadding="5">
                              <tr> 
                                <td> 
                                  <p>&nbsp;</p>
                                  <p align="center"><u><b>ASSIGNMENT</b></u></p>
                                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                                    <tr> 
                                      <td width="31%">I</td>
                                      <td width="69%">do hereby assign the moneys 
                                        payable by the United India Insurance 
                                        Co.Ltd.In the event of my </td>
                                    </tr>
                                  </table>
                                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                                    <tr> 
                                      <td colspan="2">death to M/S.UNION BANK 
                                        OF INDIA and I further declare that their 
                                        receipt shall be sufficient discharge 
                                        to the company.</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr> 
                                      <td colspan="2">&nbsp;</td>
                                    </tr>
                                    <tr> 
                                      <td width="57%"> 
                                        <p>Date: <%=Helper.correctNull((String)hshValues.get("Curdate"))%></p>
                                        <p>Place: <%=Helper.correctNull((String)hshValues.get("branchName"))%></p>
                                      </td>
                                      <td width="43%"><b>SIGNATURE OF THE INSURED 
                                        PERSON </b></td>
                                    </tr>
                                    <tr>
                                      <td width="57%"> 
                                        <p><br>
                                        </p>
                                        <p><b>Witness:</b><br>
                                        </p>
                                        <p>Signature:<br>
                                          Name:<br>
                                          Address: </p>
                                      </td>
                                      <td width="43%"> 
                                        <div align="center"><br>
                                          <br>
                                          <br>
                                          <br>
                                          <br>
                                          <b>SIGNATURE OF THE POLICY HOLDER<br>
                                          (BANK)</b></div>
                                      </td>
                                    </tr>
                                  </table>
                                  <p align="center">&nbsp;</p>
                                </td>
                              </tr>
                              <tr>
                                <td>&nbsp;</td>
                              </tr>
                            </table>
                            <p><br>
                            </p>
                            <p>&nbsp;</p>
                          </td>
                        </tr>
                      </table>
                      <p><br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                        <br>
                      </p>
                    </div>
                  </td>
                </tr>
              </table>
            </div>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>
</body>
</html>
