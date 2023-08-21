<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%
  if(objValues instanceof java.util.HashMap)
   {
	  hshValues=(java.util.HashMap)objValues;
   }
	//out.println("hshValues----------------------------------------"+hshValues);
	
	
	ArrayList vecOthers= null;
	vecOthers=(ArrayList)hshValues.get("vecOthers");
	
	ArrayList vecIncurred=new ArrayList();
	ArrayList vecTobeIncurred=new ArrayList();
	ArrayList vecTotal=new ArrayList();
	
	java.text.NumberFormat jtn=java.text.NumberFormat.getInstance();
	jtn.setMaximumFractionDigits(2);
	jtn.setMinimumFractionDigits(2);
	jtn.setGroupingUsed(false);
	

	String strRepay="";
	String dblTotalCapital1="";
	String dblTotalCapital2="";
	String dblTotalCapital3="";
	String dblTotalCost1="";
	String dblTotalCost2="";
	String dblTotalCost3="";
	String dblTotal1="";
	String dblTotal2="";
	String dblTotal3="";
		
	int vecsize=0;
	if(hshValues!=null)
	{
		vecIncurred = (ArrayList)hshValues.get("vecIncurred");
		//out.println(vecIncurred);
		vecTobeIncurred = (ArrayList)hshValues.get("vecTobeIncurred");
		//out.println(vecTobeIncurred);
		vecTotal = (ArrayList)hshValues.get("vecTotal");
		strRepay=Helper.correctNull((String)hshValues.get("strRepay"));
		
		if(hshValues.size()>0)
		{
			dblTotalCapital1=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCapital1"))));
			dblTotalCapital2=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCapital2"))));
			dblTotalCapital3=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCapital3"))));
			dblTotalCost1	=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCost1"))));
			dblTotalCost2	=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCost2"))));
			dblTotalCost3	=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotalCost3"))));
			dblTotal1		=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotal1"))));
			dblTotal2		=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotal2"))));
			dblTotal3		=jtn.format(Double.parseDouble(Helper.correctDouble((String)hshValues.get("dblTotal3"))));
		}
	}
	else
	{
		hshValues=new HashMap();
	}
	if(vecIncurred!=null)
	{
		vecsize=vecIncurred.size();
	}
	
	String strIncurred[]=new String[28];
	String strTobeIncurred[]=new String[28];
	String strTotal[]=new String[28];
	String strOthers[]=new String[28];
	

	if(vecsize==0)
	{
		for(int i=0;i<28;i++)
		{
			strIncurred[i]="";
			strTobeIncurred[i]="";
			strTotal[i]="";	
			strOthers[i]="";
		}
	}
	else
	{
		for(int i=0;i<28;i++)
		{
			strIncurred[i]=(jtn.format(Double.parseDouble((String)vecIncurred.get(i))));
			strTobeIncurred[i]=(jtn.format(Double.parseDouble((String)vecTobeIncurred.get(i))));
			strTotal[i]=(jtn.format(Double.parseDouble((String)vecTotal.get(i))));
			strOthers[i]=Helper.correctNull((String)vecOthers.get(i));	
		}
	}

	
	//out.println(strIncurred[0]);
	String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
	String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

%>


<html>

<head>
<title>Cost of Project</title>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
if( ConfirmMsg(100) )
		{
			
			window.close();
			
		}

}
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
td{font-family: "MS Sans Serif"; font-size: 10px;}
-->
DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"   >
<form name="frmpri" method = "post">
  
  <b><i>Banking Arrangements</i></b> 
  <br>
  <span style="display:none"><laps:borrowertype /></span> <laps:application/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
       <!--  <table width="90%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr> 
          <td width="21%" align="center" bgcolor="#EEEAE3"><a href="javascript:callLink('comtotal.jsp','combanking','getTotalLoan')" class="blackfont"><b>Total 
              Loan Amounts</b></a></td>
            <td width="21%" align="center" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF"><a href="javascript:callLink('combanking.jsp','bankapp','getData')" class="blackfont">Working 
              Capital</a></font></b></font></td>
            <td width="18%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:callLink('combankingfi.jsp','bankappfi','getData')" class="blackfont">Term 
              Finance </a></font></b></td>
            <td width="24%"  align="center" bgcolor="#EEEAE3" id="prin"><b><font size="1" face="MS Sans Serif"><a href="javascript:callLink('comrepayment.jsp','combanking','getRepayData')" class="blackfont">Repayment 
              of Loans</a></font></b></td>
            <td width="17%"  align="center"  id="prin" bgcolor="#71694F"><b><font color="#FFFFFF">Cost 
              of Project</font></b></td>
            <td width="37%"  align="center"  id="prin"> 

            </td>
          </tr>
        </table> -->
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td valign="top" colspan="3"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="5">
                            <tr> 
                              <td width="33%"><b>Cost of Project and Source of 
                                Finance</b></td>
                              <td width="28%">&nbsp;</td>
                              <td width="23%">&nbsp;</td>
                              <td width="16%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"><font color="#000000">a) 
                                Cost of Project</font></td>
                              <td width="28%" > 
                                <div align="center"><font color="#000000"><b>Already 
                                  incurred in Lacs</b></font></div>
                              </td>
                              <td width="23%" > 
                                <div align="center"><font color="#000000"><b>To be 
                                  incurred</b> </font></div>
                              </td>
                              <td width="16%"> 
                                <div align="center"><font color="#000000"><b>Total</b></font></div>
                              </td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid1" value="1">
                                Land </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[0]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[0]%>
                              </td>
                              <td width="16%" align="center"> <%=strTotal[0]%>&nbsp;</td>
                            </tr>
                            <tr > 
                              <td width="33%"> 
                                <input type="hidden" name="rowid2" value="2">
                                Site Development </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[1]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[1]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[1]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid3" value="3">
                                Buildings </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[2]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[2]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[2]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%">Plant and Machinery (incl. Stores 
                                and Spares)</td>
                              <td width="28%">&nbsp;</td>
                              <td width="23%">&nbsp;</td>
                              <td width="16%" align="center">&nbsp; </td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <blockquote> 
                                  <input type="hidden" name="rowid4" value="4">
                                  Imported CIF </blockquote>
                              </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[3]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[3]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[3]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <blockquote> 
                                  <input type="hidden" name="rowid5" value="5">
                                  Import Duty </blockquote>
                              </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[4]%>                              </td>
                              <td width="23%"  align="center"> 
                                <%=strTobeIncurred[4]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[4]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <blockquote> 
                                  <input type="hidden" name="rowid6" value="6">
                                  Indigenous </blockquote>
                              </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[5]%>
                              </td>
                              <td width="23%"  align="center"> 
                                <%=strTobeIncurred[5]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[5]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid7" value="7">
                                Transportation Charges </td>
                              <td width="28%" align="center"> 
                              
                                 <%=strIncurred[6]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[6]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[6]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid8" value="8">
                                Other Fixed Assests </td>
                              <td width="28%" align="center"> 
                             
                                  <%=strIncurred[7]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[7]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[7]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid9" value="9">
                                Tech Knowhow, Engg. Fee and Expenses </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[8]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[8]%>
                              </td>
                              <td width="16%" align="center"> 
                                <div align="center"><%=strTotal[8]%>&nbsp;</div>
                              </td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid10" value="10">
                                Preliminary and pre-operative Expenses </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[9]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[9]%>
                              </td>
                              <td width="16%" align="center"> 
                                <div align="center"><%=strTotal[9]%>&nbsp;</div>
                              </td>
                            </tr>
                            	<%  if(!strOthers[10].equalsIgnoreCase("")) {%>	  
			   				 <tr > 
                              <td width="33%"> 
                                <input type="hidden" name="rowid11" value="11">
				<%=strOthers[10]%>
                               </td>
                              <td width="28%"> 
                                <div align="center"> 
                                 <%=strIncurred[10]%>
                                </div>
                              </td>
                              <td width="23%"> 
                                <div align="center"> 
								<%=strTobeIncurred[10]%>
                                </div>
                              </td>
                              <td width="16%" align="center"><%=strTotal[10]%>&nbsp;</td>
                            </tr>
			    				<%} 
			    				if(!strOthers[11].equalsIgnoreCase("")){%>
			    				<tr > 
                              <td width="33%"> 
                                <input type="hidden" name="rowid12" value="12">
								<%=strOthers[11]%>
                                </td>
                              <td width="28%"> 
                                <div align="center"> 
								<%=strIncurred[11]%>
                                </div>
                              </td>
                              <td width="23%"> 
                                <div align="center"> 
                                <%=strTobeIncurred[11]%>
                                </div>
                              </td>
                              <td width="16%" align="center"><%=strTotal[11]%>&nbsp;</td>
                            </tr>
                            <%}
                            if(!strOthers[12].equalsIgnoreCase("")){
                            %>
                            <tr > 
                              <td width="33%"> 
                                <input type="hidden" name="rowid13" value="13">
								<%=strOthers[12]%>
                                </td>
                              <td width="28%"> 
                                <div align="center"> 
									<%=strIncurred[12]%>
                                </div>
                              </td>
                              <td width="23%"> 
                                <div align="center"> 
									<%=strTobeIncurred[12]%>
                                </div>
                              </td>
                              <td width="16%" align="center"><%=strTotal[12]%>&nbsp;</td>
                            </tr>
                            <%}
                            if(!strOthers[13].equalsIgnoreCase("")){%>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid14" value="14">
								<%=strOthers[13]%>
                                </td>
                              <td width="28%"> 
                                <div align="center"> 
								<%=strIncurred[13]%>
                                </div>
                              </td>
                              <td width="23%"> 
                                <div align="center"> 
									<%=strTobeIncurred[13]%>
                                </div>
                              </td>
                              <td width="16%" align="center"><%=strTotal[13]%>&nbsp;</td>
                            </tr>
			    <%} %>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid15" value="15">
                                Provision for Contingencies Incl. Prices escalation 
                                etc. </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[14]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[14]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[14]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"><b>Total Capital Cost of the Scheme</b></td>
                              <td width="28%" align="center"><b>
                                <input type="text" name="txt_total1" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCapital1%>">
                                </b>
                              </td>
                              <td width="23%" align="center"><b> 
                                <input type="text" name="txt_total2" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCapital2%>">
                                </b></td>
                              <td width="16%" align="center"><b>
                                <input type="text" name="txt_total3" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCapital3%>">
                                </b></td>
                            </tr>
                            <tr> 
                              <td width="33%"><b> 
                                <input type="hidden" name="rowid16" value="16">
                                Margin for Working capital </b></td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[15]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[15]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[15]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"><b>Total Cost of the Scheme</b></td>
                              <td width="28%" align="center"><b> 
                                <input type="text" name="txt_total12" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCost1%>">
                                </b></td>
                              <td width="23%" align="center"><b> 
                                <input type="text" name="txt_total13" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCost2%>">
                                </b></td>
                              <td width="16%" align="center"><b>
                                <input type="text" name="txt_total14" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotalCost3%>">
                                </b></td>
                            </tr>
                            <tr> 
                              <td width="33%">&nbsp;</td>
                              <td width="28%">&nbsp;</td>
                              <td width="23%">&nbsp;</td>
                              <td width="16%">&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%" ><font color="#000000">b) 
                                Source of Finance</font></td>
                              <td width="28%" > 
                                <div align="center"><font  color="#000000"><b>Already 
                                  Tied Up</b></font></div>
                              </td>
                              <td width="23%" > 
                                <div align="center"><font  color="#000000"><b>To be 
                                  Tied Up</b></font></div>
                              </td>
                              <td width="16%"> 
                                <div align="center"><font  color="#000000"><b>Total</b></font></div>
                              </td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid17" value="17">
                                Equity </td>
                              <td width="28%" align="center">
                               <%=strIncurred[16]%>
                              </td>
                              <td width="23%"  align="center"> 
                               <%=strTobeIncurred[16]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[16]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid18" value="18">
                                Promoters contribution </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[17]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[17]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[17]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid19" value="19">
                                Loans </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[18]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[18]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[18]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid20" value="20">
                                Borrowings from Promoters/ Directors. Friends 
                                and relatives </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[19]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[19]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[19]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid21" value="21">
                                Internal Generation </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[20]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[20]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[20]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid22" value="22">
                                Bonds / Debentures and others debt instruments 
                              </td>
                              <td width="28%" align="center"> 
                               <%=strIncurred[21]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[21]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[21]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid23" value="23">
                                Deferred Credit from Suppliers/Bankers </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[22]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[22]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[22]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid24" value="24">
                                Venture Capital </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[23]%>
                              </td>
                              <td width="23%" align="center"> 
                                <%=strTobeIncurred[23]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[23]%>&nbsp;</td>
                            </tr>
                            <tr> 
                              <td width="33%"> 
                                <input type="hidden" name="rowid25" value="25">
                                Other Sources (Pl. specify) </td>
                              <td width="28%" align="center"> 
                                <%=strIncurred[24]%>
                              </td>
                              <td width="23%" align="center"> 
                               <%=strTobeIncurred[24]%>
                              </td>
                              <td width="16%" align="center"><%=strTotal[24]%>&nbsp;</td>
                            </tr>
                            <%if(!strOthers[25].equalsIgnoreCase("")) {%>
			                 <tr >
                              <td width="33%">
                                <input type="hidden" name="rowid26" value="26">
								<%=strOthers[25]%>
                                </td>
                              <td width="28%">
							  <div align="center"> 
                              <%=strIncurred[25]%>
                                </div>
							  </td>
                              <td width="23%">
							  <div align="center"> 
                                  <%=strTobeIncurred[25]%>
                                </div>
							  </td>
                              <td width="16%" align="center"><%=strTotal[25]%></td>
                            </tr>
                            <%}
                            if(!strOthers[26].equalsIgnoreCase("")){
                            %>
                            <tr >
                              <td width="33%"><input type="hidden" name="rowid27" value="27">
							<%=strOthers[26]%>
                                </td>
                              <td width="28%">
							  <div align="center"> 
								<%=strIncurred[26]%>
                                </div>
							  </td>
                              <td width="23%">
							    <div align="center"> 
								<%=strTobeIncurred[26]%>
                                </div>
							  </td>
                              <td width="16%" align="center"><%=strTotal[26]%></td>
                            </tr>
                            <%}
                            if(!strOthers[27].equalsIgnoreCase("")){%>
                            <tr >
                              <td width="33%">
                                <input type="hidden" name="rowid28" value="28">
								<%=strOthers[27]%>
                                </td>
                              <td width="28%">
							  <div align="center"> 
								<%=strIncurred[27]%>
                                </div>
							  </td>
                              <td width="23%">
							  <div align="center"> 
							<%=strTobeIncurred[27]%>
                                </div> 
							  </td>
                              <td width="16%" align="center"><%=strTotal[27]%></td>
                            </tr>
                            <%}%>
                            <tr> 
                              <td width="33%"><b>Total</b></td>
                              <td width="28%" align="center">
                                <input type="text" name="txt_total122" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotal1%>">
                              </td>
                              <td width="23%" align="center"><b> 
                                <input type="text" name="txt_total123" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotal2%>">
                                </b></td>
                              <td width="16%" align="center"><b>
                                <input type="text" name="txt_total124" size="12" style="text-align:center;border=none" onKeyPress="allowNumber(this)" value="<%=dblTotal3%>">
                                </b></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr valign="top"> 
                        <td width="33%" valign="middle">
                          <p>Repayment Schedule </p>
                          <p>&nbsp;</p>
                        </td>
                        <td width="28%"> 
                          <%=strRepay%>
                        </td>
                        <td width="39%" align="left">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="3"> <br>
                          <br>
                          <br>
                          <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"   align="center">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2">
                                  <tr valign="top"> 
                                    <td width="0"> 
                                      <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doClose()">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <%
		String strappno = request.getParameter("appno");
		//out.println(strappno);
		%>
  <input type="hidden" name="hidAction" >
  <input type="hidden" name="hidBeanId">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="" >
  <input type="hidden" name="hidSourceUrl" value="">
  <input type="hidden" name="hidflag" value="">
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="selsno" value="">
  <input type="hidden" name="hidval" >
  <input type="hidden" name="hiddesc" >
  <input type="hidden" name="comapp_compname" value="<%=request.getParameter("comapp_compname")%>">
  <input type="hidden" name="comapp_compid" value="<%=request.getParameter("comapp_compid")%>">
  <INPUT TYPE="hidden" NAME="hidPageSource" VALUE="COP">

</form>
</body>
</html>
