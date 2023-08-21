<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>

<%@ page import="java.util.*"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<laps:handleerror />

  <%
 String month=Helper.correctNull((String)request.getParameter("month"));
  String monthvalue="";
  if(month.equalsIgnoreCase("1")){
	  monthvalue="Jan";
  }else if(month.equalsIgnoreCase("2")){
	  monthvalue="Feb";
  }else if(month.equalsIgnoreCase("3")){
	  monthvalue="Mar";
  }else if(month.equalsIgnoreCase("4")){
	  monthvalue="Apr";
  }else if(month.equalsIgnoreCase("5")){
	  monthvalue="May";
  }else if(month.equalsIgnoreCase("6")){
	  monthvalue="Jun";
  }else if(month.equalsIgnoreCase("7")){
	  monthvalue="July";
  }else if(month.equalsIgnoreCase("8")){
	  monthvalue="Aug";
  }else if(month.equalsIgnoreCase("9")){
	  monthvalue="Sep";
  }else if(month.equalsIgnoreCase("10")){
	  monthvalue="Oct";
  }else if(month.equalsIgnoreCase("11")){
	  monthvalue="Nov";
  }else if(month.equalsIgnoreCase("12")){
	  monthvalue="Dec";
  }

 double bktotal=Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbtotaleligibleamount"))); 

  ArrayList vecrow = new ArrayList();
	ArrayList veccol = new ArrayList();
	int j=0;
	double totalvalue=Double.parseDouble(Helper.correctDouble((String)hshValues.get("totalvalue")));
	double margin=totalvalue*25/100;
	 double vecvalue=0.00;
	 double tempvalue=0.00;
	 double subvalue=0.00;
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
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta content="Microsoft FrontPage 3.0" name="GENERATOR">
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css">

</head>

<body bgcolor="white">
<form name="frmstock" method=post>

<table width="100%" border="0" cellspacing="0" cellpadding="4" >
        <tr>
       
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg" ></td>          		
      
        </tr>
 </table>

<table cellSpacing="0" cellPadding="0" width="100%" border="0">
<TBODY>
  <tr>

    <td width="33%" colSpan="4"><div align="center"><b>KARNATAKA BANK LTD.</b></div></td>
  
  </tr>
 <tr>

      <td colSpan="3" ><div align="Right"><b>BRANCH</b></div></td>
	  <td width="44%">&nbsp;</td>
   
  </tr>
  <tr>
      <td width="100%" colSpan="4"> 
        <div align="center"><b>STATEMENT OF BOOK-DEBTS POSITION</b></div>
      </td>
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
      <td width="55%"><b>A/C No :<%=Helper.correctNull((String)hshValues.get("mmr_cbsaccountno"))%></b></td>
	  <td width="45%"><b> Name of the Account:<%=Helper.correctNull((String)request.getParameter("cbsname"))%></b></td>
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
        <p><b>Book Debts for the month of : <%=monthvalue %></b> </p>
       
      </td>
		</tr>
		<tr>		
      <td width="45%"> 
        <b>We give below the particulars of Book Debts charged to you as on 
          :</b>
        </td>
		</tr>
		</table>
<table cellSpacing="0" cellPadding="0" width="100%" border="0">
	<tr>
		
      <td align="center"><b>DIVISION WISE</b> </td>
		
      <td align="center"><b>AGE WISE BREAK- UP</b></td>
	</tr>

</table>
<br>
  <table cellSpacing="0" cellPadding="0" width="100%" border="0" class="outertable border1">
    <TBODY> 
    <tr> 
      <td  align="center" rowspan="2"><strong>S.No</strong></td>
      <td align="center" rowspan="2"><strong>Name of the Party</strong></td>
      <td align="center" rowspan="2"><strong>Date of Invoice</strong></td>
      <td align="center" colspan="3" ><strong>Days</strong></td>
      <td align="center" rowspan="2"><strong>Amount</strong></td>
    </tr>
    <tr>
      <td align="center" ><strong>Up to 90 days</strong></td>
      <td align="center"><strong>91 to 180 days</strong></td>
      <td align="center" ><strong>Above 180 days</strong></td>
    </tr>
    <%if (hshValues != null) 
                 	 {
             vecrow = (ArrayList)hshValues.get("arrRow");
                             	 
                  	  if(vecrow!=null && vecrow.size()>0)
                 						{
                             		 			
                   							for(int i=0;i<vecrow.size();i++)
                   							{
                   									j++;
                   								veccol = (ArrayList) vecrow.get(i);
%>
    <tr> 
      <td><%=j%> </td>
      <td><%=Helper.correctNull((String)veccol.get(0))%> </td>
      <td><%=Helper.correctNull((String)veccol.get(1))%></td>
      <td><%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(2))))%></td>
      <td><%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(3))))%></td>
      <td><%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(4))))%></td>
      <td><%=nf.format(Double.parseDouble(Helper.correctDouble((String)veccol.get(5))))%></td>
      <% 
    vecvalue=Double.parseDouble((Helper.correctDouble((String)veccol.get(5))));
       	
  	tempvalue=tempvalue+vecvalue;
    
    	
    %>
    </tr>
    <%}}} %>
    <tr> 
       
		<td><strong></strong></td>
		<td><strong></strong></td>
		
      <td><strong></strong></td>
		
      <td><strong></strong></td>
		<td><strong></strong></td>
		<td><strong>Grand Total</strong></td>
<td >
        <p ><strong></strong>
      <%=nf.format(tempvalue)%></td>
    </tr>
    </TBODY> 
  </table>
<br>
  <table  cellSpacing="0" cellPadding="0" width="100%" border="1">
    <tr> 
      <td >&nbsp;</td>
      <td >&nbsp;</td>
      <td >&nbsp;</td>
    </tr>
    <tr> 
      <td width="3%" ><strong>A</strong></td>
      <td  width="67%"><font face="Times New Roman">Book debts older than user 
        defined period. (older then 90 days)</font></td>
      <td width="23%"><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbtolderamount")))) %></td>
    </tr>
    <tr> 
      <td ><strong>B</strong></td>
      <td > Bills Negotiated / discounted with bank/Financial institution</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbdiscountamount")))) %> 
      </td>
    </tr>
    <tr> 
      <td ><strong>C</strong></td>
      <td > Books Debts assigned to factors.</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbfactoramount")))) %> 
      </td>
    </tr>
    <tr> 
      <td ><strong>D</strong></td>
      <td >Debts considered doubtful of recovery. </td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbdoubtfulamount")))) %> 
      </td>
    </tr>
    <tr> 
      <td ><strong>E</strong></td>
      <td > Book Debts arising out of Bills Drawn on Associate concerns.</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbassociateamount")))) %> 
      </td>
    </tr>
    <tr> 
      <td ><strong>F</strong></td>
      <td > Book Debts arising out of Activity other than for which bank finance 
        is extended.</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbfinanceamount")))) %> 
      </td>
    </tr>
    <% subvalue=Math.abs(tempvalue-bktotal); %>
    <tr> 
      <td ><strong>G</strong></td>
      <td > Eligible Book Debts for calculation of DP Amount= Grand Total-(A+B+C+D+E+F))</td>
      <td><%=nf.format(subvalue)%> 
        <%//=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mmr_bkdbtotaleligibleamount")))) %>
      </td>
    </tr>
    <tr>
      <td >&nbsp;</td>
      <td >Less : Margin(@ <%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_marginbookdebt")))) %> %)</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_marginbookdebtpercent")))) %> </td>
    </tr>
    <tr> 
      <td >&nbsp;</td>
      <td >Total Drawing Power against Book - Debts</td>
      <td ><%=nf.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("mon_totaldrawing")))) %> </td>
    </tr>
  </table>

<p>&nbsp;</p>

  <table border="0" width="100%">
    <tr> 
      <td width="42%" align="center"><b>Signature Verified</b></td>
      <td width="12%" align="center">&nbsp;</td>
      <td width="46%" align="center"><b>Authorised Signatory</b></td>
    </tr>
    <tr> 
      <td width="42%"> Name</td>
      <td width="12%">&nbsp;</td>
      <td width="46%"> 
        <p align="left">Name of 
      </td>
    </tr>
    <tr> 
      <td width="42%">PF No</td>
      <td width="12%">&nbsp;</td>
      <td width="46%"> 
        <p align="left">Designation 
      </td>
    </tr>
    <tr> 
      <td width="42%">Designation</td>
      <td width="12%">&nbsp;</td>
      <td width="46%">&nbsp;</td>
    </tr>
    <tr> 
      <td width="42%"><i>* Seal and Signature of the Bank's Official in Print 
        Out</i></td>
      <td width="12%">&nbsp;</td>
      <td width="46%"><i>* Seal and Signature of the Customer in Print Out</i></td>
    </tr>
  </table>

<input type="hidden" name="cbsname1" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">


</form>
</body>
</html>
