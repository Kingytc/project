<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

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
          <td width="45%"><b>CREDIT REPORT</b></td>
          <td width="55%"><b>Karnataka Bank Ltd.</b><br>
            <%=Helper.correctNull((String)hshValues.get("branchName"))%> Branch 
          </td>
        </tr>
      </table>
      <table width="98%" border="1" cellspacing="0" cellpadding="5">
        <tr> 
          <td> 
            <div align="center">Name</div>
          </td>
          <td> 
            <div align="center">Head Office</div>
          </td>
          <td> 
            <div align="center">Tel.No</div>
          </td>
          <td> 
            <div align="center">Branch Office &amp;/or<br>
              Factory </div>
          </td>
          <td> 
            <div align="center">Tel.No</div>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
          <td>&nbsp;</td>
        </tr>
      </table>
      <table width="98%" border="1" cellspacing="0" cellpadding="5">
        <tr> 
          <td colspan="2"> 
            <p>&nbsp;</p>
            <p>Nature of Main Business</p>
          </td>
          <td colspan="2" width="64%"> 
            <p>&nbsp;</p>
            <p>Side Line if any</p>
          </td>
        </tr>
      </table>
      <table width="98%" border="1" cellspacing="0" cellpadding="5" height="132">
        <tr> 
          <td width="36%" height="146"> 
            <table width="100%" border="0" cellspacing="0" cellpadding="5" height="105">
              <tr> 
                <td height="103" width="44%"> 
                  <form name="form1" method="post" action="">
                    <p> 
                      <input type="checkbox" name="checkbox" value="checkbox">
                      Individual<br>
                      <input type="checkbox" name="checkbox2" value="checkbox">
                      Proprietory<br>
                      <input type="checkbox" name="checkbox3" value="checkbox">
                      H.U.F</p>
                  </form>
                </td>
                <td height="103" width="56%"> 
                  <form name="form2" method="post" action="">
                    <input type="checkbox" name="checkbox4" value="checkbox">
                    Partnership<br>
                    <input type="checkbox" name="checkbox5" value="checkbox">
                    Trust<br>
                    <input type="checkbox" name="checkbox6" value="checkbox">
                    Limited Com.p/Ltd<br>
                  </form>
                </td>
              </tr>
            </table>
          </td>
          <td width="27%" height="146"> 
            <form name="form3" method="post" action="">
              <input type="checkbox" name="checkbox7" value="checkbox">
              Agricultrist<br>
              <input type="checkbox" name="checkbox8" value="checkbox">
              Non Agricultrist 
            </form>
          </td>
          <td width="37%" height="146"><u>Established:(Year) :_ ______________<br>
            </u>
            <form name="form4" method="post" action="">
              <input type="checkbox" name="checkbox9" value="checkbox">
              Minority<br>
              <input type="checkbox" name="checkbox10" value="checkbox">
              SC/ST 
            </form>
            <u> </u></td>
        </tr>
      </table>
      <table width="98%" border="0" cellspacing="0" cellpadding="5">
        <tr> 
          <td> 
            <p>Full name of identical,connected or associated firms giving the 
              nature and places of business Name/Names of their bankers with address 
              and detail of credit facilities allowed by them<br>
            </p>
            <p>____________________________________________________________________________________________________________________<br>
              Full Names &amp; Address of the individual,proprietor,partners,karta 
              and Co-parceners,Directors,etc and their realtionship with each 
              other,if any(brief report on <br>
              the business means/assetsof partners,Directors to given on the reverse.)<br>
            </p>
            <table width="99%" border="0" class="outertable border1" cellspacing="0" cellpadding="5">
              <tr> 
                <td rowspan="2" width="12%">Name</td>
                <td colspan="7"> 
                  <div align="center">Address with telephone number</div>
                </td>
              </tr>
              <tr> 
                <td width="11%"> 
                  <div align="center">Father's Name</div>
                </td>
                <td width="10%"> 
                  <div align="center">Office</div>
                </td>
                <td width="10%"> 
                  <div align="center">Tel.No</div>
                </td>
                <td width="13%"> 
                  <div align="center">Residence</div>
                </td>
                <td width="12%"> 
                  <div align="center">Tel.No</div>
                </td>
                <td width="15%"> 
                  <div align="center">Permanent <br>
                    Address</div>
                </td>
                <td width="17%"> 
                  <div align="center">Tel.No</div>
                </td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="12%">&nbsp;</td>
                <td width="11%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="10%">&nbsp;</td>
                <td width="13%">&nbsp;</td>
                <td width="12%">&nbsp;</td>
                <td width="15%">&nbsp;</td>
                <td width="17%">&nbsp;</td>
              </tr>
            </table>
            <p>Total Means: Rs.</p>
            <table width="98%" border="1" cellspacing="0" cellpadding="5" height="759">
              <tr> 
                <td width="34%"> 
                  <p>Guarantee given in details</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
                <td width="66%"> 
                  <p>Particulars of Individual liabilities of partners</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
              </tr>
              <tr> 
                <td width="34%" height="305"> 
                  <table width="98%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td> 
                        <p>Business Ability</p>
                        <p> 
                          <input type="checkbox" name="checkbox11" value="checkbox">
                          Capable<br>
                          <input type="checkbox" name="checkbox11" value="checkbox">
                          Incapable<br>
                          <input type="checkbox" name="checkbox12" value="checkbox">
                          Experienced<br>
                          <input type="checkbox" name="checkbox13" value="checkbox">
                          Inexperienced </p>
                        <p>&nbsp; </p>
                      </td>
                      <td> 
                        <p>Business Conducted</p>
                        <p> 
                          <input type="checkbox" name="checkbox14" value="checkbox">
                          Speculative<br>
                          <input type="checkbox" name="checkbox15" value="checkbox">
                          Overtrade<br>
                          <input type="checkbox" name="checkbox16" value="checkbox">
                          Conservative<br>
                          <input type="checkbox" name="checkbox17" value="checkbox">
                          Prudent<br>
                          <input type="checkbox" name="checkbox18" value="checkbox">
                          Cautions<br>
                          <input type="checkbox" name="checkbox19" value="checkbox">
                          Steady</p>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p><br>
                  </p>
                  <p>&nbsp;</p>
                  <p>&nbsp; </p>
                  <p>&nbsp;</p>
                </td>
                <td width="66%" height="305"> 
                  <table width="51%" border="0" cellspacing="0" cellpadding="5">
                    <tr> 
                      <td> 
                        <p>Business Reputation<br>
                        </p>
                        <p> 
                          <input type="checkbox" name="checkbox20" value="checkbox">
                          Honest<br>
                          <input type="checkbox" name="checkbox21" value="checkbox">
                          DisHonest<br>
                          <input type="checkbox" name="checkbox22" value="checkbox">
                          Straight-Forward<br>
                          <input type="checkbox" name="checkbox23" value="checkbox">
                          Tricky<br>
                          <input type="checkbox" name="checkbox24" value="checkbox">
                          Sharp<br>
                          <input type="checkbox" name="checkbox25" value="checkbox">
                          Shrewd <br>
                          <br>
                          <br>
                          <br>
                        </p>
                      </td>
                      <td> 
                        <p>Condition of Business</p>
                        <p><br>
                          <input type="checkbox" name="checkbox30" value="checkbox">
                          Progressive<br>
                          <input type="checkbox" name="checkbox27" value="checkbox">
                          Declining<br>
                          <input type="checkbox" name="checkbox28" value="checkbox">
                          Staganant<br>
                          <input type="checkbox" name="checkbox29" value="checkbox">
                          Thriving<br>
                          <input type="checkbox" name="checkbox26" value="checkbox">
                          Healthy <br>
                          <input type="checkbox" name="checkbox31" value="checkbox">
                          Sound<br>
                          <input type="checkbox" name="checkbox32" value="checkbox">
                          Liquid <br>
                          <br>
                        </p>
                      </td>
                    </tr>
                  </table>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
              </tr>
              <tr> 
                <td width="34%" height="125"> 
                  <p>Nature:Extent of dealing with Banker's Branches:<br>
                    (State what limits enjoyed at other branches)</p>
                  <p>&nbsp;</p>
                  <p><br>
                  </p>
                </td>
                <td width="66%" height="125"> 
                  <p><br>
                    Names of Bankers/Financial Institutions and credit facilites<br>
                    at other Bankers/Financial Institutions and Securities<br>
                    charged to them.<br>
                  </p>
                  <p>&nbsp;</p>
                  <p><br>
                  </p>
                </td>
              </tr>
              <tr> 
                <td width="34%" height="81">&nbsp;</td>
                <td width="66%" height="81">&nbsp;</td>
              </tr>
            </table>
            <table width="98%" border="1" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="37%">Brief report on the means of individual propritor<br>
                  Partner of directors</td>
                <td width="63%">Details of fixed assets(Give nature and loction 
                  of each assets and in case of immovable property the name in 
                  which it is held)</td>
              </tr>
              <tr> 
                <td width="37%"> 
                  <p>&nbsp;</p>
                  <p>&nbsp;</p>
                </td>
                <td width="63%">&nbsp;</td>
              </tr>
            </table>
            <table width="98%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td width="35%"> 
                  <p>&nbsp;</p>
                  <p>Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b></p>
                </td>
                <td width="38%"> 
                  <p>&nbsp;</p>
                  <p>Credit Investigator</p>
                </td>
                <td width="27%"> 
                  <p>&nbsp;</p>
                  <p>Branch Manger</p>
                </td>
              </tr>
            </table>
            <p>Note:1.In case of Limited Companies,Public or private ,records 
              with the Register of Companies should be searched to verify</p>
          </td>
        </tr>
        <tr>
          <td>
            <p><br>
              a) Authorised Capital<br>
              b) Subscribed Capital<br>
              c) Paid-Up Capital<br>
              d) Name of Directors<br>
              e) Extent and nature of charges on assets of the company created 
              in favour of creditors<br>
              f) Name of Creditors<br>
              g) Any other relevent information<br>
              h) In case of Private Limited Companies,the names of the shareholders 
              should also be given.<br>
            </p>
            <p>2.Reports on Spinning and weaving Mills should contain the number 
              of looms,spindles,volume and value of production,labour force employed,volume 
              and value of raw materials consumed and in case of Mills,number 
              of expellers etc,should be stated.</p>
            <p>3)Situation of properties,in whose name(s) they stand and their 
              market value should be stated.</p>
            <p>4)Reports on the means of the Proprietors,Partners,Director etc 
              should be collected and included in this form as far as possible.</p>
            <p>5)Before signing reports,Branch Managers are expected to satisfy 
              themselves about their accuracy from independent sources</p>
          </td>
        </tr>
      </table>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
      <p>&nbsp;</p>
    </td>
  </tr>
</table> 
</body>
</html>
