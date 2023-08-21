<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />

<laps:handleerror />

<% HashMap hshmp1=null;
	HashMap hshmp3=null;
	HashMap hshmp2=null;
	HashMap hshmp4=null;
	
	hshmp1=(HashMap)hshValues.get("hshValues1");
	hshmp2=(HashMap)hshValues.get("hshValues2");
	hshmp3=(HashMap)hshValues.get("hshValues3");
	hshmp4=(HashMap)hshValues.get("hshValues4");
	
	String[] bank_name = new String[4];
	String[] Limit = new String[4];
	String[] out_standing = new String[4];
	String[] DL_INTEREST = new String[4];
	String[] tot_dues = new String[4];
	String[] date1=new String[4];

	String[] ACC_NAME = new String[8];
	String[] BRANCH_NAME = new String[8];
	String[] CREDIT_LIMIT = new String[8];
	String[] OUT_STAND= new String[8];
	String[] ACC_CLASS = new String[8];
	String[] SECURITIES=new String[8];
	String[] date2=new String[8];
	String [] sec1=new String[8];

	bank_name=(String[]) hshmp2.get("BANK_NAME");

	Limit=(String[]) hshmp2.get("LIMIT");
	out_standing=(String[]) hshmp2.get("OUTSTANDING_VALUE1");
	DL_INTEREST=(String[]) hshmp2.get("DL_INTEREST");
	tot_dues=(String[]) hshmp2.get("TOTAL_DUE");

	ACC_NAME=(String[]) hshmp2.get("ACCOUNT_NAME");
	BRANCH_NAME=(String[]) hshmp2.get("BRANCH_NAME");
	CREDIT_LIMIT=(String[]) hshmp2.get("CREDIT_LIMIT");
	OUT_STAND=(String[]) hshmp2.get("OUTSTANDING_VALUE2");
	ACC_CLASS=(String[]) hshmp2.get("ACC_CLASSIFICATION");
	SECURITIES=(String[]) hshmp2.get("SECURITIES");


	date1=(String[]) hshmp2.get("OUTSTANDING_DATE1");
	

	
	%>

<html>
<head>
<title>ubi</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>
<style>
.td,tr{font-family: "MS Sans Serif";
	font-size: 11px;
	}



</style>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" font-family="arial" font-size="11px">

  <tr> 
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
        <tr> 
          <td align="center"><b>Proposal for Approval for counter offer</b></td>
        </tr>
        <tr> 
          <td align="right">Date: 
            -----------------  
          </td>
        </tr>
        <tr> 
          <td> 
            <table width="50%" border="1" cellspacing="0" cellpadding="2" align="right">
              <tr> 
                <td width="34%">ACCOUNT</td>
				<td width="32%"><%=Helper.correctNull((String)hshmp1.get("comapp_companyname"))%> </td>
                                             
              <!--<td width="32%">&nbsp;</td>-->
              </tr>
              <tr> 
                <td width="34%">BRANCH</td>
				<td width="32%"><%=Helper.correctNull((String)hshmp1.get("strOrgName"))%> </td>
               <!-- <td width="32%">&nbsp;</td>-->
              </tr>
              <tr> 
                <td width="34%">ZONE</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("ZONE"))%> </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="40%" border="1" cellspacing="0" cellpadding="2" align="right">
              <tr> 
                <td width="50%">CLASSIFICATION</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("CLASSIFICATION"))%> </td>
              </tr>
              <tr> 
                <td width="50%">PROVISION</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("PROVISION"))%> </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>We received OTS offer of above borrower, signed by Mr./ Mrs. 
            ---<%=Helper.correctNull((String)hshmp1.get("BORROWER"))%> 
            who is an authorized signatory, for Rs. 
            ---<%=Helper.correctNull((String)hshmp1.get("RUPEES_PAID"))%> 
            to be paid as under: </td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="5" align="center">
              <tr align="center"> 
                <td width="50%">Date of Payment</td>
                <td width="50%">Amount</td>
              </tr>
              <tr> 
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("DATE_OF_PAYMENT1"))%> </td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("AMOUNT1"))%> </td>
              </tr>
              <tr> 
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("DATE_OF_PAYMENT2"))%> </td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("AMOUNT2"))%> </td>
              </tr>
              <tr> 
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("DATE_OF_PAYMENT3"))%> </td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("AMOUNT3"))%> </td>
              </tr>
              <tr> 
               <td width="32%"><%=Helper.correctNull((String)hshmp1.get("DATE_OF_PAYMENT4"))%> </td>
               <td width="32%"><%=Helper.correctNull((String)hshmp1.get("AMOUNT4"))%> </td>
              </tr>
              <tr> 
                <td width="50%" align="center">Total</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("TOT_AMT"))%> </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>Proposed Interest Rate .for payment of instalments: 
            ----<%=Helper.correctNull((String)hshmp1.get("PROPOSED_INTEREST"))%> 
            % p.a </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td>The details of the NPA are as follows:</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="5" align="center">
              <tr> 
                <td width="50%">ADVANCESINC</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("ADVANCE_SINCE"))%> </td>
              </tr>
              <tr> 
                <td width="50%">NPA SINCE</td>
               <td width="32%"><%=Helper.correctNull((String)hshmp1.get("NPA_SINCE"))%> </td>
              </tr>
              <tr> 
                <td width="50%">DATE &amp; AMOUNT OF SUIT<br>
                  PRESENT POSITION</td>
               <td width="32%"><%=Helper.correctNull((String)hshmp1.get("DATE_SUIT"))%> </td>
              </tr>
              <tr> 
                <td width="50%">&nbsp;</td>
                <td width="50%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="50%">&nbsp;</td>
                <td width="50%">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b><U>PRESENT POSITION:</U></b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="4" align="center">
              <tr> 
                <td width="50%">Outstanding in Running Ledger</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("AMT_SUIT"))%> </td>
              </tr>
              <tr> 
                <td width="50%">Interest held in Dummy Ledger From 
                  ---<%=Helper.correctNull((String)hshmp1.get("PRESENT_POSITION"))%> 
                  To 
                  ---<%=Helper.correctNull((String)hshmp1.get("ELIGIBLE_ACTION"))%>
                </td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("CHANGES_RECOVERY"))%> </td>
              </tr>
              <tr> 
                <td width="50%">Legal Expenses</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("OUTSTANDING_LEDGER"))%> </td>
              </tr>
              <tr> 
                <td width="50%">TOTAL DUES</td>
                <td width="32%"><%=Helper.correctNull((String)hshmp1.get("INTEREST_LEDGER_FROM"))%> </td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
      
      
    
    <!-- page2 start -->
    
    
    
    <table width="100%" border="1" cellspacing="0" cellpadding="2">
  <tr> 
    <td>
      <table width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
        <tr> 
          <td ><u><b>DUES TO OTHER BANKS/FIS:</b></u></td>
        </tr>
        <tr> 
          <td align="right">&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="4">
              <tr> 
                <td height="22" width="20%">Name of the Bank / FI</td>
                <td height="22" width="20%">Limit</td>
                <td height="22" width="20%">O/s as of 
                  ------
                </td>
                <td height="22" width="20%">D/L Interest</td>
                <td height="22" width="20%">Total Dues</td>
              </tr>
              <%	for (int i = 0; i < 4; i++) {
            	  if(bank_name[i]==null && Limit[i]==null && out_standing[i]== null && DL_INTEREST[i]==null && tot_dues[i]==null) {
            		  bank_name[i]=null;
            		   Limit[i]=null;
            		   out_standing[i]=null;
            		  DL_INTEREST[i]=null;
            		  tot_dues[i]=null;
				}%>
              <tr> 
                <td width="20%"><%=Helper.correctNull((String)bank_name[i])%></td>
                <td width="20%"><%=Helper.correctNull((String)Limit[i])%></td>
                <td width="20%"><%=Helper.correctNull((String)out_standing[i])%></td>
                <td width="20%"><%=Helper.correctNull((String)DL_INTEREST[i])%></td>
                <td width="20%"><%=Helper.correctNull((String)tot_dues[i])%></td>
              </tr>
              <%
            }
             
			%>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
                <td width="20%">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td><b><u>DETAILS OF GROUP/ ASSOCIATE CONCERNS, IF ANY:</u> </b></td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="4">
              <tr> 
                <td width="18%">Name of the A/c.</td>
                <td width="18%">Branch</td>
                <td width="18%">Details of credit Limit</td>
                <td width="18%">O/s as on 
                  ----------
                </td>
                <td width="14%">Classification of the A/c.</td>
                <td width="14%">Securities (primary / Collateral)</td>
              </tr>
              <%	for (int i = 0; i < 8; i++) {
            	   			
				%>
              <tr> 
                <td width="18%"><%=Helper.correctNull(ACC_NAME[i])%></td>
                <td width="18%"><%=Helper.correctNull(BRANCH_NAME[i])%></td>
                <td width="18%"><%=Helper.correctNull(CREDIT_LIMIT[i])%></td>
                <td width="18%"><%=Helper.correctNull(OUT_STAND[i])%></td>
                <td width="14%"><%=Helper.correctNull(ACC_CLASS[i])%></td>
                
              </tr>
               <%
              }

			%>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
              <tr> 
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="18%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
                <td width="14%">&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp; </td>
        </tr>
        <tr> 
          <td><b><u>SECURITIES:</u></b></td>
        </tr>
        <tr> 
          <td align="right"><b>(Rs in lacs)</b></td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="4">
              <tr> 
                <td width="30%">&nbsp;</td>
                <td colspan="2" align="left">AS PER VALUATION DATED: 
                  ----<%=Helper.correctNull((String)hshmp2.get("VALUATION_DATE"))%>
                </td>
              </tr>
              <tr> 
                <td width="30%">&nbsp;</td>
                <td width="35%">Nature</td>
                <td width="35%">Value</td>
              </tr>
              <tr> 
                <td width="30%" height="22">Primary</td>
                <td width="35%" height="22"><%=Helper.correctNull((String) hshmp2.get("PRIMARY_NATURE"))%></td>
                <td width="35%" height="22"><%=Helper.correctNull((String) hshmp2.get("PRIMARY_VALUE"))%></td>
              </tr>
              <tr> 
                <td width="30%">Collateral</td>
                <td width="35%"><%=Helper.correctNull((String) hshmp2.get("COLLATERAL_NATURE"))%></td>
                <td width="35%"><%=Helper.correctNull((String) hshmp2.get("COLLATERAL_VALUE"))%></td>
              </tr>
              <tr> 
                <td width="30%">Means of Borrower #</td>
                <td colspan="2"><%=Helper.correctNull((String)hshmp2.get("BorrowerMeans"))%></td>
              </tr>
              <tr> 
                <td width="30%">Means of Guarantor #</td>
                <td colspan="2">ENTERABLE</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr>
          <td align="center"># SHOULD INCLUDE REALISABLE VALUE OF THE OTHER ASSETS 
            OWNED BYTHE PARTIES BUT NOT SECURED TO THE BANK</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
    
    
 <!-- end page 2 -->
    
    
    
      
     



<table>

<tr> 
          <td> 
            <table width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
              <tr> 
                <td ><u><b>EVALUATION MODULE</b></u></td>
              </tr>
              <tr> 
                <td align="right">&nbsp;</td>
              </tr>
              <tr> 
                <td> 
                  <table width="100%" border="1" cellspacing="0" cellpadding="4">
                    <tr> 
                      <td width="10%" height="19">Sr.No.</td>
                      <td width="30%" height="19">Parameter</td>
                      <td width="30%" height="19">Particulars*</td>
                      <td width="30%" height="19">Points</td>
                    </tr>
                    <tr> 
                      <td width="10%">1</td>
                      <td width="30%">Realisable value of Securites</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("REALISIBLE_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("REALISIBLE_POINTS"))%></td>
                    </tr>
                    <tr> 
                      <td width="10%">2</td>
                      <td width="30%">Aggregate means of the borrower / guarantors</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("AGGREGATE_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("AGGREGATE_POINTS"))%></td>
                    </tr>
                    <tr> 
                      <td width="10%">3</td>
                      <td width="30%">Marakatability of Security</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("MARKETABILITY_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("MARKETABILITY_PONITS"))%></td>
                    </tr>
                    <tr> 
                      <td width="10%">4</td>
                      <td width="30%">Age of NPA</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("AGE_NPA_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("AGE_NPA_POINTS"))%></td>
                    </tr>
                    <tr> 
                      <td width="10%">5</td>
                      <td width="30%">Legal Position of th bank</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("LEGAL_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("LEGAL_POINTS"))%></td>
                    </tr>
                    <tr> 
                      <td width="10%">&nbsp;</td>
                      <td width="30%">&nbsp;</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("NET_SCORE_PARTICULARS"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("NET_SCORE_POINTS"))%></td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td>* to be filled in as applicable</td>
              </tr>
              <tr> 
                
          <td>A) AMOUNT PAYABLE AS PER THE MODULE: Rs.:  ----<%=Helper.correctNull((String)hshmp3.get("AMT_PAYABLE"))%></td>
              </tr>
              <tr> 
                <td>B)AMOUNT EXPECTED TO BE RECOVERABLE FROM THE SECURITES/ MEANS 
                  OF THE PARTIES: Rs:---<%=Helper.correctNull((String)hshmp3.get("AMT_EXPECTED"))%></td>
              </tr>
              <tr> 
                <td>&nbsp; </td>
              </tr>
              <tr> 
                <td><b><u>CALCULATION OF RELIEF:</u></b></td>
              </tr>
              <tr> 
                <td><b></b></td>
              </tr>
              <tr> 
                <td align="right"> 
                  <table width="100%" border="1" cellspacing="0" cellpadding="4">
                    <tr> 
                      <td width="30%">&nbsp;</td>
                      <td colspan="2">Rs.</td>
                    </tr>
                    <tr> 
                      <td width="30%">Running ledger Balance</td>
                      <td colspan="2"><%=Helper.correctNull((String)hshmp3.get("RUNNING_LEDGER"))%></td>
                    </tr>
                    <tr> 
                      <td width="30%" height="37">Interest held in dummy ledger 
                        From 
                        ----<%=Helper.correctNull((String)hshmp3.get("INTEREST_FROM"))%>
                        To 
                        -----<%=Helper.correctNull((String)hshmp3.get("INTEREST_TO"))%>
                      </td>
                      <td colspan="2" height="37"><%=Helper.correctNull((String)hshmp3.get("INTEREST_HELD"))%></td>
                    </tr>
                    <tr> 
                      <td width="30%">Legal Expenses</td>
                      <td colspan="2"><%=Helper.correctNull((String)hshmp3.get("LEGAL_EXPENSES"))%></td>
                    </tr>
                    <tr> 
                      <td width="30%">Total Dues</td>
                      <td width="30%">As per OTS Proposal</td>
                      <td width="30%">As per Counter offer proposed</td>
                    </tr>
                    <tr> 
                      <td width="30%">Less: settlement Amount</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("SETTLEMENT_PROPOSAL"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("SETTLEMENT_OFFER"))%></td>
                    </tr>
                    <tr> 
                      <td width="30%">Balance Sacrifice</td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("BALANCE_PROPOSAL"))%></td>
                      <td width="30%"><%=Helper.correctNull((String)hshmp3.get("BALANCE_OFFER"))%></td>
                    </tr>
                    <tr> 
                      <td width="30%"><u>of which:<br>
                        </u><br>
						</tr>
						<tr>
                        <td>-write off </td>
						<td><%=Helper.correctNull((String)hshmp3.get("WRITEOFF_PROPOSAL"))%></td>
						<td><%=Helper.correctNull((String)hshmp3.get("WRITEOFF_OFFER"))%></td>
						</tr>
						<tr>
						<td>
                        -wavier of Dummy ledger Interest</td>
						<td><%=Helper.correctNull((String)hshmp3.get("WAIVER_PROPOSAL"))%></td>
						<td><%=Helper.correctNull((String)hshmp3.get("WAIVER_OFFER"))%></td>
						</tr>
						<tr>
						<td>
                        -Absorption of Legal Expenses</td>
						<td><%=Helper.correctNull((String)hshmp3.get("ABSORPTION_PROPOSAL"))%></td>
						<td><%=Helper.correctNull((String)hshmp3.get("ABSORPTION_OFFER"))%></td>
						</tr>
                     
                    <tr> 
                      <td width="30%">&nbsp;</td>
                      <td width="30%">&nbsp;</td>
                      <td width="30%">&nbsp;</td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td align="center">&nbsp;</td>
              </tr>
              <tr> 
                <td><b><u>BRIEF BACKGROUND OF NPA AMOUNT </u></b></td>
              </tr>
              <tr> 
                <td> 
                  -----<%=Helper.correctNull((String)hshmp3.get("BRIEF_BACKGROUND"))%>
                </td>
              </tr>
              <tr> 
                <td>&nbsp;</td>
              </tr>
            </table>
          </td>
        </tr>
</table>

      <!-- page 3 end -->
      
      
      <!-- page 4 start -->
      
      <table width="100%" border="1" cellspacing="0" cellpadding="2">
  <tr> 
    <td valign="top">
      <table width="98%" border="0" cellspacing="0" cellpadding="2" align="center">
        <tr> 
          <td ><u>COMMENTS ON STEPS INITIATED FOR RECOVERY, EXPECTED AMOUNT OF 
            RECOVERY AND PERIOD WHICH THE SAME IS EXPECTED:</u></td>
        </tr>
        <tr> 
          <td align="right">&nbsp;</td>
        </tr>
        <tr> 
          <td> <%=Helper.correctNull((String)hshmp4.get("COMMENTS"))%></td>
        </tr>
        <tr> 
          <td><b></b></td>
        </tr>
        <tr> 
          <td><b><u>AMOUNT RECOMMENDED FOR MAKING THE COUNTER OFFER:</U></b></td>
        </tr>
        <tr> 
          <td >We recommend that we may make the following counter offer: </td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="1" cellspacing="0" cellpadding="4">
              <tr> 
                <td>Date of Payment </td>
                <td>Amount</td>
              </tr>
              <tr> 
			 
                <td><%=Helper.correctNull((String)hshmp4.get("PAYMENT_DATE1"))%></td>
                <td> <%=Helper.correctNull((String)hshmp4.get("AMOUNT1"))%></td>
              </tr>
              <tr> 
                <td><%=Helper.correctNull((String)hshmp4.get("PAYMENT_DATE2"))%></td>
                <td><%=Helper.correctNull((String)hshmp4.get("AMOUNT2"))%></td>
              </tr>
              <tr> 
                <td><%=Helper.correctNull((String)hshmp4.get("PAYMENT_DATE3"))%></td>
                <td><%=Helper.correctNull((String)hshmp4.get("AMOUNT3"))%></td>
              </tr>
              <tr> 
                <td><%=Helper.correctNull((String)hshmp4.get("PAYMENT_DATE4"))%></td>
                <td><%=Helper.correctNull((String)hshmp4.get("AMOUNT4"))%></td>
              </tr>
              <tr> 
                <td>Total</td>
                <td><%=Helper.correctNull((String)hshmp4.get("TOTAL_AMOUNT"))%></td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>Recommended rate of interest on instalments proposed: 
            ----<%=Helper.correctNull((String)hshmp4.get("RATE_INTEREST"))%>
            % P.a </td>
        </tr>
        <tr>
          <td>We request / recommend permission to make the ciunter offer:</td>
        </tr>
        <tr> 
          <td>ENTERABLE</td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="4">
              <tr> 
                <td>Name</td>
                <td>Name</td>
                <td>Name</td>
              </tr>
              <tr> 
                <td>BRANCH MANGER</td>
                <td>REGIONAL HEAD</td>
                <td>ZONAL HEAD /PGM</td>
              </tr>
              <tr> 
                <td>Date:</td>
                <td>Date:</td>
                <td>Date:</td>
              </tr>
            </table>
          </td>
        </tr>
        <tr> 
          <td>&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>APPROVED / NOTAPPROVED</b></td>
        </tr>
        <tr> 
          <td align="center">&nbsp;</td>
        </tr>
        <tr> 
          <td align="center"><b>COMPETENT AUTHORITY</b></td>
        </tr>
        <tr> 
          <td align="center">Date:</td>
        </tr>
        <tr> 
          <td align="center">&nbsp;</td>
        </tr>
      </table>
    </td>
  </tr>
</table>
      
      <!-- page 4 end -->
      
      
      
   
      <br>
      <br>
	  </body>
	  </html>
	  