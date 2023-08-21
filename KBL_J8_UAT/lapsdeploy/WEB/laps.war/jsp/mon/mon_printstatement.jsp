<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

  <%
 
  ArrayList vecrow = new ArrayList();
	ArrayList veccol = new ArrayList();
	int j=0;
	double totalvalue=Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalvalue")));
	
	double dbltotalstock=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_totalstock")));
	double margincal=Double.parseDouble(Helper.correctDouble((String)hshValues.get("marginpercent")));
	double stockelg=totalvalue-dbltotalstock;
	
	double margin=stockelg*margincal/100;
	 double vecvalue=0.00;
	 double tempvalue=0.00;
	 
	 String strbankname=Helper.correctNull((String)hshValues.get("mmr_bankname"));

	 String banknamepercent=Helper.correctNull((String)hshValues.get("mmr_sharepercent"));

	 double  strsharepercent=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_sharepercent")));
	 double ownbank=0.00;
	 if(strbankname.equalsIgnoreCase("1")) {
	 	ownbank=stockelg*strsharepercent/100;
	 	
	 }else {
	 	ownbank=0.00;
	 	strbankname="NIL";
	 	
	 }

	%>
	<%
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>

<head>
<title>STOCK STATEMENT</title>
<!-- <meta http-equiv="Content-Type" content="text/html; charset=windows-1252">-->
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
</head>

<body bgcolor="white" align="center">
<form name="frmstock" method=post>

<p>&nbsp;</p>
  <table width="87%" border="0" cellspacing="0" cellpadding="4" >
    <tr>
        
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" ></td>          		
       
        </tr>
 </table>


<table cellSpacing="0" cellPadding="0" width="87%" border="0">
<TBODY>
  <tr>

    <td width="33%" colSpan="4"><big><big><strong><p align="center">KARNATAKA BANK LTD.</strong></big></big></td>
   
  </tr>
    <tr>

      <td colSpan="3"align="Right"><strong>BRANCH</strong> </td>
	  <td width="44%">&nbsp;</td>
   
  </tr>
  
  <tr>
    <td width="100%" colSpan="4"><p align="center"><strong>CALCULATION OF DRAWING POWER
    against STOCKS<br>
    (Excluding Stocks meant for PACKING CREDIT)</strong></td>
  </tr>
 
  
  <tr>
    <td width="100%" colSpan="4"></td>
  </tr>
</TBODY>
</table>
<br>
<br>
<table  cellSpacing="0" cellPadding="2" width="87%" border="0">
	<tr>		
      <td width="55%"></td>
	  <td width="45%">Annexure to Stock Statement as on</td>
	</tr>
	<tr>		
      <td width="55%"><b>A/C No :</b></td>
	  <td width="45%"><b> Name of the Account:</b></td>
	</tr>
	<tr>		
      <td width="55%">
        <p><b>Address of Contact Office :</b></p>
        <p>&nbsp;</p>
        
      </td>
	</tr>
	<tr>
		
      <td width="55%"><b>Tel No:</b></td>
		
      <td width="45%"><b>Contact Person :</b></td>
	</tr>
</table>

<br>
<table  cellSpacing="0" cellPadding="5" width="87%" border="0">	
	<tr>		
      <td width="45%">
        <p><b>Stock Statement for the month of :</b></p>
        
      </td>
	</tr>
	<tr>
		<td width="25%"></td>
		
      <td width="75%"><b>Based on STOCK STATEMENTS as on </b></td>
	</tr>		
</table>

<table  cellSpacing="0" cellPadding="0" width="87%" border="0" class="outertable border1">
<TBODY>

  <tr>
      <td align="center" height="13" width="14%"><strong>S.No</strong></td>
      <td align="center"height="13" width="30%" ><strong>Type</strong></td>
      <td align="center" height="13" width="40%"><strong>Description of Materials</strong></td>
      <td align="center"height="13" width="16%"><strong>Value</strong></td>
  </tr>
  <%if (hshValues != null) 
                 	 {
             vecrow = (ArrayList) hshValues.get("vecRow");
                             	 
                  	  if(vecrow!=null && vecrow.size()>0)
                 						{
                             		 			
                   							for(int i=0;i<vecrow.size();i++)
                   							{
                   									j++;
                   								veccol = (ArrayList) vecrow.get(i);
%>
  
  
  
  
  <tr>
  
      <td width="14%" height="29"><%=j%> </td>
      <td width="30%" height="29"><%=Helper.correctNull((String)veccol.get(2))%> 
      </td>
      <td width="40%"height="29" ><%=Helper.correctNull((String)veccol.get(3))%></td>
      <td width="16%"height="29" ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(8))))%></td>
    <% 
   vecvalue=Double.parseDouble((Helper.correctDouble((String)veccol.get(8))));
       	
  	tempvalue=tempvalue+vecvalue;
    
    	
    %>
  </tr>
  <%}}} %>
  <tr>
    
      <td height="2"colspan="3"> 
        <p align="right"><strong>Grand Total</strong></td>
      <td width="16%" height="2"><%=nf.format(tempvalue)%></td>
  </tr>
</TBODY>
</table>
<br>
<table height="181" cellSpacing="0" cellPadding="0" width="87%" border="0" class="outertable border1">
<TBODY>
  <tr>
      <td width="3%" height="19">&nbsp;</td>
      <td width="78%" height="19">&nbsp;</td>
      <td width="19%" height="19">&nbsp;</td>
  </tr>
  <tr>
      <td width="3%" height="19">A</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Value of stock 
        procured under LC/ LG but not paid. Stocks against devolved LC&#146;s 
        and invoked guarantees</font></td>
      <td width="19%" height="19"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_stocklc")))) %></td>
  </tr>
  <tr>
      <td width="3%" height="19">B</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Value of unpaid 
        stock (under creditors / supplier credit / co acceptance) &#150; user 
        defined.</font></td>
      <td width="19%" height="19"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_stockcreditor"))) )%></td>
  </tr>
  <tr>
      <td width="3%" height="19"></td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Total of Unpaid 
        Stocks (A+B)</font></td>
      <td width="19%" height="19"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_totalunpaidstock"))) )%>
     </td>
  </tr>
  <tr>
      <td width="3%" height="19">C</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Value of Stock 
        not consider for Drawing Power (Stocks older then&nbsp; __ days)</font> 
      </td>
      <td width="19%" height="19">
      <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_stocknotdp"))) )%>
      
     </td>
  </tr>
  <tr>
      <td width="3%" height="19">D</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Value of other 
        assets (not reckoned for Drawing Power) ie. Slow moving /obsolete item 
        / user defined.</font></td>
      <td width="19%" height="19">
       <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_otherasset"))) )%>
    </td>
  </tr>
  <tr>
      <td width="3%" height="19">E</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Value of Stock 
        meant for pre-shipment finance (Packing Credit)</font></td>
      <td width="19%" height="19">
      <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_packingcredit"))) )%>
   </td>
  </tr>
  <tr>
      <td width="3%" height="19">F</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif"> Value of 
        stock earmarked for other banks/financing agencies</font></td>
      <td width="19%" height="19">
         <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_stockearmarked"))) )%>
    </td>
  </tr>
  <tr>
      <td width="3%" height="20">II</td>
      <td width="78%" height="20"><font size="1" face="MS Sans Serif">Total Stock 
        to be excluded for calculation of Drawing Power for Cash Credit/Demand 
        Loan (A+B+C+D+E+F)</font></td>
      <td width="19%" height="20">
        <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_totalstock"))) )%>
    </td>
  </tr>
  <tr>
      <td width="3%" height="19">III</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Stock eliglible 
        for calculation of Drawing Power for CASH CREDIT/DEMAND LOAN ACCOUNTS 
        (I-II)</font></td>
      <td width="19%" height="19"><%=nf.format(stockelg) %> 
        <!-- <=Helper.correctNull((String)hshValues.get("totalvalue")) %>-->
      </td>
  </tr>
  <tr>
      <td width="3%" height="19">IV</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">Less Margin</font></td>
      <td width="19%" height="19">
         <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("marginpercent"))) )%>
    
        %</td>
  </tr>
  <tr>
      <td width="3%" height="19">V</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif">TOTAL AVAILABLE 
        DP AGAINST STOCKS(III-IV) </font> </td>
      <td width="19%" height="19"> <%=nf.format(stockelg-margin) %></td>
  </tr>
  <tr>
      <td width="3%" height="19">&nbsp;</td>
      <td width="78%" height="19">&nbsp;</td>
      <td width="19%" height="19">&nbsp;</td>
  </tr>
  <tr>
      <td width="3%" height="19">&nbsp;</td>
      <td width="78%" height="19"><font size="1" face="MS Sans Serif"> Our Share 
        in DP <%=banknamepercent %>%(% age Share in Consortium)</font></td>
      <td width="19%" height="19"><%=banknamepercent %>%<br>
		  <%=nf.format(ownbank) %></td>
  </tr>
</TBODY>
</table>

<p>&nbsp;</p>

<table border="0" width="87%">
  <tr>
    <td width="50%">.</td>
    <td width="25%"><p align="left">Name of Authorised Signatory</td>
  </tr>
  <tr>
    <td width="50%">.</td>
    <td width="25%"><p align="left">Designation</td>
  </tr>
  <tr>
    <td width="50%">&nbsp;</td>
    <td width="25%">PF No</td>
  </tr>
  <tr>
    <td width="50%">&nbsp;</td>
      <td width="50%"><i>*Seal and Signature of the Bank's Official in Print Out</i></td>
  </tr>
</table>


</form>
</body>
</html>
