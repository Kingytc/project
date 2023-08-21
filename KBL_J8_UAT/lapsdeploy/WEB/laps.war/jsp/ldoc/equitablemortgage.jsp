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
      <td width="71%"><br>
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="43%"> 
              <div align="center"></div>
            </td>
            <td width="8%"><b> </b></td>
            <td width="49%"><b>KARNATAKA BANK LTD.</b></td>
          </tr>
          <tr> 
            <td width="43%">&nbsp;</td>
            
          <td colspan="2"><b>CENTRAL ADVANCES DEPARTMENT</b></td>
          </tr>
          <tr> 
            <td width="43%">&nbsp;</td>
            <td width="8%">&nbsp;</td>
            <td width="49%">&nbsp;</td>
          </tr>
        </table>
        <br>
      </td>
      <td width="29%">&nbsp;</td>
    </tr>
    <tr>
      <td width="71%">&nbsp;</td>
      <td width="29%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="71%">INSTRUCTION CIRCULAR NO:5572</td>
      <td width="29%"><br>
        Date: <b><%=Helper.correctNull((String) hshValues.get("Curdate"))%></b> <br>
      </td>
    </tr>
    <tr> 
      <td width="71%">&nbsp;</td>
      
    <td width="29%">Place: <b><%=Helper.correctNull((String) hshValues.get("cityName"))%></b><br>
      </td>
    </tr>
    <tr> 
      <td colspan="2"><br>
        To: All Branches / Office </td>
    </tr>
    <tr> 
      <td colspan="2"> 
        <div align="center"><b><u>sub:Equitable Mortgage<br>
          <br>
          </u></b> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              <td width="6%"><br>
                <br>
              </td>
              <td width="94%">Reference is invited to the Instruction Circular 
                No.3072 dt. 13.06.85 on the above subject.</td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%"><br>
                 <font face="Times New Roman" size="3"> 
              <p align="justify">  
                The subject of creation of Equitable Mortgage was dealt with exhaustively 
                in the above referred Circular. Still, certain infirmities have 
                come to light that have the effect of negating the Mortgage and 
                the same has necessitated the issuance of this Circular.</p> </font>
              </td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%"><br>
                 <font face="Times New Roman" size="3"> 
              <p align="justify">  
                At the cost of repetition it is reiterated that the Branches should 
                create Equitable Mortgage by taking deposit of only the Original 
                Title Deeds. Equitable Mortgage by Deposit of certified copies 
                / True Copies / Xerox copies of the Title Deeds on the pretext 
                that the Originals are not available cannot be encouraged, since 
                such a mortgage is void ab initio and in the eyes of Law, it is 
                not a mortgage at all.</p> </font> 
              </td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
                Though Law permits creation of Equitable Mortgage with the certified 
                copies of the title deeds issued by the concerned Registrar of 
                Assurances, the same is fraught with great risk and hence, the 
                same is also not encouraged. The Registrar of Assurances will 
                issue any number of certified copies of a title deed on a mere 
                application with a meagre fee. If creation of Equitable Mortgage 
                with certified copies of title deeds is encouraged, an unscrupulous 
                borrower may create any number of Equitable Mortgages with the 
                help of such certified copies apart from creating an Equitable 
                Mortgage with the original deeds elsewhere. Since creation of 
                Equitable Mortgage does not require compulsory registration under 
                the Indian Registration Act, it is impossible to find out the 
                details of earlier mortgages created against the same property. 
                Hence, as a matter of rule, Equitable Mortgage should be created 
                only with the Original Title Deeds and creation of Equitable Mortgage 
                with anything other than Original Title Deeds will be viewed very 
                seriously.</p> </font> 
              </td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%"><br> <font face="Times New Roman" size="3"> 
              <p align="justify">  
                It has also come to light that certain branches, instead of creating 
                the Equitable Mortgage, obtain an undertaking / agreement to create 
                Equitable Mortgage for various reasons. The field functionaries 
                should note that such an undertaking / agreement does not create 
                any charge over the property stipulated and it creates only a 
                right to seek specific performance of such agreement that defeats 
                the very interest of the Bank stipulating a security. Hence, obtaining 
                of an undertaking / agreement in lieu of Equitable Mortgage will 
                be considered as a serious lapse jeopardising the interests of 
                the Bank. </p> </font> 
              </td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%"> <br>
                All are advised to take a careful note of the above.<br>
              </td>
            </tr>
            <tr> 
              <td width="6%">&nbsp;</td>
              <td width="94%">&nbsp;</td>
            </tr>
          </table>
          <div align="right"><b><u>GENERAL MANAGER </u></b></div>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td colspan="2">&nbsp;</td>
    </tr>
  </table>
</body>
</html>
