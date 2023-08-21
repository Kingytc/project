<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
double dblMargin=0.0;
 ArrayList arrRow=(ArrayList)hshValues.get("mailcomments");
%>
<html >
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>UBI</title>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">

</head>

<body >

<table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
  <tr> 
    <td> 
        <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr>
    <td>&nbsp;</td>
    </tr>
    <tr align="center">
    <td ><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"
							width="350" height="70">
    </td>
    </tr>
      <tr align="center" > .
      
                <td align="center"> <b>KARNATAKA BANK LTD.</b><br>
                  <b><%=Helper.correctNull((String) hshValues.get("orgname"))%> 
                  </b> Branch<br>
                </td>
              </tr>
              <tr> 
                <td align="center" ><b> <%=Helper.correctNull((String) hshValues.get("orgadd1"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgadd2"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgcity"))%>,&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgstate"))%>-&nbsp; 
                  <%=Helper.correctNull((String) hshValues.get("orgzip"))%>&nbsp; 
                  .<br>
                  Tel No : <%=Helper.correctNull((String) hshValues.get("orgphone"))%></b> 
                  <hr />
                </td>
              </tr>
    </table>
    <br>
      <table width="100%" border="1" cellspacing="0" cellpadding="5">
        <tr> 
         
          <td align="center"><b>Loan Against Deposit Process Note</b>
          </td></tr>
        <tr> 
          <td> 
            <table width="100%" border="0" cellspacing="0" cellpadding="5">
              <tr> 
                <td align="left" colspan="2"><b>Application Inward No.<%=Helper.correctNull((String)hshValues.get("appno")) %></b></td>
                <td>&nbsp;</td>
                <td  align="right">Date of Acknowledgement:&nbsp;&nbsp;<strong><%=Helper.correctNull((String)hshValues.get("loan_receivedate")) %></strong></td>
              </tr>
              <tr> 
                <td valign="top" ><b>1(a). </b></td>
                <td valign="top" width="20%"><b>Name of the Applicant/s </b></td>
                <td valign="top" width="1%"><b>:</b></td>
                <td align="left" colspan="3"><%=Helper.correctNull((String)hshValues.get("Title"))%> 
                  <%=Helper.correctNull((String)hshValues.get("appname")) %> </td>
              </tr>
              <tr> 
                <td width="3%"><b>1(b). </b></td>
                <td width="2%"><b>Branch Name</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3"><%=Helper.correctNull((String)hshValues.get("cus_org_name")) %> 
                </td>
              </tr>
              <tr> 
                <td width="3%"><b>2. </b></td>
                <td width="2%"><b>Purpose of Loan </b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3"><%=Helper.correctNull((String)hshValues.get("loan_purposeofloan")) %> 
                </td>
              </tr>
              <tr> 
                <td><b>3.</b></td>
                <td><b> Details of Deposit:</b></td>
                <td valign="top"><b></b></td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td colspan="5"> 
                  <div id="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr class="tblhead" valign="top"> 
                        <td width="4%" align="center">S.No</td>
                        <td width="11%" align="center">Receipt No</td>
                        <td width="30%" align="center">Name of The Depositer</td>
                        <td width="11%" align="center">Date of receipt </td>
                        <td width="11%" align="center">Face Value<b> (Rs)</b></td>
                        <td width="11%" align="center">Maturity Date</td>
                        <td width="11%" align="center">Present Value <b>(Rs)</b></td>
                        <td width="11%" align="center">Interest to be charged 
                          on Loan/Overdraft <b>(%)</b> </td>
                      </tr>
                      <%
                    ArrayList arraylist=(ArrayList)hshValues.get("arrRow");
                    ArrayList arrayRow=null;
                    double totValueofSecurity=00.00;
                    double dblfacevalue=0.0;
                    double totValueofEligible=00.00;
                    if(arraylist!=null)
                    {
                    	
                    for(int i=0;i<arraylist.size();i++)
                    {
                    	
                    	arrayRow=(ArrayList)arraylist.get(i);
                    	dblMargin=Double.parseDouble(Helper.correctDouble((String)arrayRow.get(13)));
                    %>
                      <tr> 
                        <td width="4%"><%=i+1%></td>
                        <td width="11%"><%=Helper.correctNull((String)arrayRow.get(1))%></td>
                        <td width="30%"><%=Helper.correctNull((String)arrayRow.get(3))%></td>
                        <td width="11%"><%=Helper.correctNull((String)arrayRow.get(5))%></td>
                        <td width="11%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrayRow.get(6))))
                     
                    	  %></td>
                        <td width="11%"><%=Helper.correctNull((String)arrayRow.get(11))%></td>
                        <td width="11%" align="right"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrayRow.get(8))))%></td>
                        <td width="11%" align="center"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)arrayRow.get(12))))%></td>
                      </tr>
                      <%
                      dblfacevalue=dblfacevalue+Double.parseDouble(Helper.correctDouble((String)arrayRow.get(6)));
                    totValueofSecurity=totValueofSecurity+Double.parseDouble(Helper.correctDouble((String)arrayRow.get(8)));
                    totValueofEligible=totValueofEligible+Double.parseDouble(Helper.correctDouble((String)arrayRow.get(8)))
                    -
                	(
                	(Double.parseDouble(Helper.correctDouble((String)arrayRow.get(8)))*dblMargin)/100);
                    }
                    }
                    %>
                    </table>
                  </div>
                </td>
              </tr>
              <tr> 
                <td valign="top" ><b>4. </b></td>
                <td width="20%" valign="top"><b>LIMIT DETAILS </b></td>
                <td width="1%" valign="top"><b></b></td>
                <td width="60%" colspan="3" valign="top">&nbsp;</td>
              </tr>
              <tr> 
                <td align="left" valign="top" ><b>4.1 </b></td>
                <td align="left" width="20%" valign="top"><b>LIMIT APPLIED </b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("amtreqd"))))%></td>
              </tr>
              <tr> 
                <td align="left" valign="top" ><b>4.2 </b></td>
                <td align="left" width="20%" valign="top"><b>TOTAL FACE VALUE</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(dblfacevalue)%></td>
              </tr>
              <tr> 
                <td align="left" valign="top" ><b>4.3 </b></td>
                <td align="left" width="20%" valign="top"><b>TOTAL PRESENT VALUE</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(totValueofSecurity)%></td>
              </tr>
              <tr> 
                <td align="left"   valign="top"><b>4.4 </b></td>
                <td align="left" width="20%"  valign="top"><b>MARGIN(%)</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(dblMargin)%></td>
              </tr>
              <tr> 
                <td align="left"   valign="top"><b>4.5 <br>
                  </b></td>
                <td align="left" width="20%"  valign="top"><b>ELIGIBLE AMOUNT</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(totValueofEligible)%></td>
              </tr>
              <tr> 
                <td align="left"   valign="top"><b>4.6 <br>
                  </b></td>
                <td align="left" width="20%"  valign="top"><b>LIMIT RECOMMENDED</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("sancamount"))))%></td>
              </tr>
              <tr> 
                <td align="left"  valign="top"><b>5. </b></td>
                <td align="left" width="20%" valign="top"><b> DOCUMENTS </b></td>
                <td valign="top"><b>: </b></td>
                <td> 
                  <%
                  ArrayList arrDocuments=(ArrayList)hshValues.get("arrDocsId");
                if(arrDocuments!=null)
                {
                	for(int i=0;i<arrDocuments.size();i++)
                	{
                		ArrayList arrDocdesc=(ArrayList)arrDocuments.get(i);
                		out.print((i+1)+" ) "+arrDocdesc.get(1)+" <br>");
                	}
                }
                %>
                </td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
                <td>&nbsp;</td>
              </tr>
              <tr> 
                <td align="left" valign="top"><b>6.</b></td>
                <td align="left" valign="top"><b>WHETHER DOCUMENTS VALID AND IN 
                  FORCE</b></td>
                <td align="left" valign="top"><b>:</b></td>
                <td align="left" colspan="3"><%=Helper.correctNull((String)hshValues.get("txtarea_documents"))%></td>
              </tr>
              <tr> 
                <td align="left" valign="top"><b>7. </b></td>
                <td align="left" valign="top"><b>TERM AND CONDITIONS </b></td>
                <td align="left" valign="top"><b>: </b></td>
                <td align="left"> 
                  <%
                
                 arraylist=(ArrayList)hshValues.get("arrTermsId");
                if(arraylist!=null){
                for(int i=0;i<arraylist.size();i++)
                {
                  arrayRow=(ArrayList)arraylist.get(i);
                  
                  out.println((i+1)+" ) "+arrayRow.get(1)+"<br>");
                  
                	
                }
                
                }
                %>
                </td>
                <td align="left">&nbsp;</td>
                <td align="left">&nbsp;</td>
              </tr>
              <tr> 
                <td align="left" valign="top"><b> 8. <br>
                  </b></td>
                <td align="left" width="20%" valign="top"><b>WHETHER FDR/DRCs/CUMULATIVEDEPOSIT 
                  etc. ARE RENEWED AND DULY DISCHARGED ALONG WITH LETTER OF LIEN</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.correctNull((String)hshValues.get("txtarea_fdr"))%></td>
              </tr>
              <tr> 
                <td align="left" valign="top"><b>9.</b></td>
                <td align="left" width="20%" valign="top"><b>COMPLIANCE TO TERM 
                  OF SANCTION</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.correctNull((String)hshValues.get("txtarea_compliance"))%></td>
              </tr>
              <tr> 
                <td align="left" valign="top"><b>10.<br>
                  </b></td>
                <td align="left" width="20%" valign="top"><b>AUDIT OBSERVATIONS 
                  &amp; COMPLIANCE</b></td>
                <td width="1%" valign="top"><b>:</b></td>
                <td colspan="3" valign="top"><%=Helper.correctNull((String)hshValues.get("txtarea_audit"))%></td>
              </tr>
            </table>
          </td>
        </tr>
      
              <tr>
        <td><table width="65%" border="0" align="center" cellpadding="5" cellspacing="0">

          <tr>
            <td colspan="3" align="center" class="td_bg"><strong>Recommended for Sanction</strong></td>
            </tr>
             <%if(arrRow!=null && arrRow.size()>0)
          				{
          				for(int i=0; i<arrRow.size();i++)
          					{
          					ArrayList arrCol=new ArrayList();
          					arrCol=(ArrayList)arrRow.get(i);
       					%>
            <tr> 
                <td align="left" width="39%" valign="top"><b><%=arrCol.get(0)%></b></td>
                <td width="1%"  valign="top">:</td>
                <td> 
                  <P><%=arrCol.get(1)%></P>
                </td>
              </tr>
                <% 
            			}
			            }
          				%>
          <tr>
          
            <td width="40%">Signature</td>
            <td width="1%">:</td>
            <td width="59%">&nbsp;</td>
            </tr>
          <tr>
            <td>Name of the officer</td>
            <td>:</td>
            <td>&nbsp;</td>
            </tr>
          <tr>
            <td>Designation</td>
            <td>:</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td colspan="3" align="center" class="td_bg"><strong>Sanctioned / Declined</strong></td>
            </tr>
            <tr>
			 	<td valign="top"><%=Helper.correctNull((String)hshValues.get("sancauth"))%>&nbsp;</td>
				<td valign="top">:&nbsp;</td>
			  	<td valign="top"><p><%=Helper.correctNull((String)hshValues.get("sancofficercomments"))%>&nbsp;</p></td>
       		</tr>	
          <tr>
            <td>Signature</td>
            <td>:</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Name of the officer</td>
            <td>:</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Designation</td>
            <td>:</td>
            <td>&nbsp;</td>
          </tr>
          <tr>
            <td>Name of the Br. with Seal</td>
            <td>:</td>
            <td>&nbsp;</td>
          </tr>
        </table>
          <br /></td>
      </tr>
            </table>
          </td>
        </tr>
      </table>
    
 

</body>
</html>
