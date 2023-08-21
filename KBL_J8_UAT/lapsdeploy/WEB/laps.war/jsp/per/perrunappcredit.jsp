<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />

<%
//out.println("****************"+hshValues);
  ArrayList vecOrg = new ArrayList();
  vecOrg=(ArrayList)hshValues.get("vecValues");
    java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
	 nf.setGroupingUsed(true);
  nf.setMaximumFractionDigits(2);
  nf.setMinimumFractionDigits(2);
  String align="left";
  ArrayList vecVal=null;
  	
%>


<html>
<head>
<title>Report - Productwise Status Report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script>
var outlabel="<%= hshValues.get("labels")%>";
var textlabel="";
var datalen ="<%= vecOrg.size()%>";
</script>
<link rel="stylesheet"	href="<%=ApplicationParams.getAppUrl()%>css/report.css"	type="text/css">
</head>
<body bgcolor="#FFFFFF" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0">
<table width="100%" border="0" cellspacing="0" cellpadding="3">
        <tr>
          <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>          		
        </tr>
        <tr> 
          <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
        </tr>
         <tr> 
          <td align="center"><%=Helper.correctNull((String)hshValues.get("Org_Name"))%></td>
        </tr> 
        <tr> 
          <td align="center"><b>Report - Productwise Status Report for <%=Helper.correctNull((String)hshValues.get("cate"))%></b></td>
        </tr>
   </table>
   

<%
if (vecOrg.size() > 0)
{
	
%>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="2">
   <tr> 
    <td width="12%"><font size="1" face="MS Sans Serif"><b>Organisation</b></font></td>
    <td width="38%"><font size="1" face="MS Sans Serif"><%=(String)hshValues.get("OrgName")%></font></td>
    <td width="16%"><b><font size="1" face="MS Sans Serif">Generated By</font></b></td>
    <td width="34%"><font size="1" face="MS Sans Serif"><%=(String)hshValues.get("genby")%></font></td>
  </tr>
  <tr> 
    <td width="12%"><font size="1" face="MS Sans Serif"><b>Period</b></font></td>
    <td width="38%"><font size="1" face="MS Sans Serif"><%=(String)hshValues.get("txtDate")%></font></td>
    <td width="16%"><b><font size="1" face="MS Sans Serif">Generated On</font></b></td>
    <td width="34%"><font size="1" face="MS Sans Serif"><%=(String)hshValues.get("txtSaveDate")%></font></td>
  </tr>
  <tr> 
    <td width="12%">&nbsp;</td>
    <td width="38%"><font size="1" face="MS Sans Serif"></font></td>
    <td width="16%">&nbsp;</td>
    <td width="34%">&nbsp;</td>
  </tr>
</table>
<br>
<tr> 
  <td> 
    <table width="100%" border="1" cellspacing="1" cellpadding="2"  bordercolor="#eeeeee">
     
  <tr> 
        <td width="16%"><font size="1" face="MS Sans Serif"><b>Category</b></font></td>
        <td colspan="3" width="84%"><font size="1" face="MS Sans Serif"><%=Helper.correctNull((String)hshValues.get("parcate"))%></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font></td>
      </tr>
      <tr> 
        <td width="16%" ><font size="1" face="MS Sans Serif"><b>Sub Category</b></font></td>
        <td colspan="3" width="84%" ><font size="1" face="MS Sans Serif">
	<%=Helper.correctNull((String)hshValues.get("cate"))%>
	<%//=(String)vecVal.get(3)  +" - " + (String)vecVal.get(1)+" - "+(String)vecVal.get(4)+"-"+(String)vecVal.get(5)%></font><font size="1" face="MS Sans Serif"></font><font size="1" face="MS Sans Serif"></font></td>
      </tr>
	

      <tr> 
        <td colspan="4"> 
          <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolor="#eeeeee">
           
            <tr > 
              <td width="15%"> 
                <div align="left"><font color="#000000"><b><font face="MS Sans Serif" size="1">Application 
                  No</font></b></font></div>
              </td>
              <td width="20%" align="left"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Applicant 
                Name</font></b></font></td>
              <td width="17%" align="center"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Date 
                Approved</font></b></font></td>
              <td width="18%"> 
                <div align="center"><font color="#000000"><b><font size="1" face="MS Sans Serif">Loan Amount Applied</font></b></font></div>
              </td>
              <td width="13%"> 
                <div align="center"><font color="#000000"><b><font size="1" face="MS Sans Serif">Loan 
                  Amount Sanctioned</font></b></font></div>
              </td>
           <!--   <td width="17%" align="center"> <font color="#000000"><b><font size="1" face="MS Sans Serif">Interest 
                Rate(%)</font></b></font></td>-->
            </tr>
		   <%

String subtot="0.00";
int prdcode=0;
HashMap hshsub= new HashMap();

 for (int i=0;i<vecOrg.size();i++)
  {  
	  
	  vecVal = new ArrayList();
	  //vecVal =(ArrayList)vecOrg.get(i);
	  if (vecOrg.get(i) instanceof HashMap)
	  {
		  hshsub =(HashMap)vecOrg.get(i);
		  subtot =(String)hshsub.get("subtot");
	
	  }
	  if(vecOrg.get(i) instanceof ArrayList)
	  {
		vecVal =(ArrayList)vecOrg.get(i);
		
	  }
	 
     // if (vecOrg.get(i) instanceof ArrayList) 
	 // {
		//  subtot="0.00";
		 // if(Integer.parseInt((String)vecVal.get(0)) != prdcode)
		//  {

	   
%>
            <tr >
              <td width="15%">&nbsp;</td>
              <td width="20%" align="left">&nbsp;</td>
              <td width="17%" align="center">&nbsp;</td>
              <td width="18%">&nbsp;</td>
              <td width="13%">&nbsp;</td>
            <!--  <td width="17%" align="center">&nbsp;</td>-->
            </tr>
          </table>
          <%
		 // }
	 // }
	  
	 if(vecOrg.get(i) instanceof ArrayList)
	 {
				  %>
          <table width="100%" cellpadding="0" cellspacing="0"  bordercolor="#eeeeee">
            <tr> 
              <td colspan="7"> 
                <table width="100%" border="1" cellspacing="0" cellpadding="1" bordercolor="#eeeeee">
                  <tr> 
                    <td width="14%"> <font size="1" face="MS Sans Serif"><%=(String)vecVal.get(1)%></font></td>
                    <td width="21%"> <font size="1" face="MS Sans Serif"><%=(String)vecVal.get(3)%></font></td>
                    <td width="17%" align="center"> <font size="1" face="MS Sans Serif"><%if(Helper.correctNull((String)vecVal.get(9)).equals("") ||Helper.correctNull((String)vecVal.get(9)).equals("01/01/1900")) 
					{
						out.println("");
					}
					else
					{
						out.println(Helper.correctNull((String)vecVal.get(9)));
					 }
						%></font></td>
                    <td width="18%" align="center"> <font size="1" face="MS Sans Serif"><%=nf.format(Double.parseDouble((String)vecVal.get(4)))%></font></td>
                    <td width="14%" align="center"> <font size="1" face="MS Sans Serif"><%=nf.format(Double.parseDouble((String)vecVal.get(7)))%></font></td>
                    <!--<td width="16%" align="center"> <font size="1" face="MS Sans Serif"><%=(String)vecVal.get(5)%></font></td>-->
                  </tr>
                </table>
              </td>
              <%
		
		//prdcode =Integer.parseInt((String)vecVal.get(0));
	 }    
		
	%>
              <!-- <%
				if (!subtot.equals("0.00"))
				{
				%>
            <tr> <table width="100%"><tr>
              <td width="14%">&nbsp;</td>
              <td width="21%">&nbsp;</td>
              <td width="17%">&nbsp;</td>
              <td width="18%" align="center"> <font size="1" face="MS Sans Serif"><b>Sub 
                Total :</b>&nbsp;</font></td>
              <td width="14%" align="center"> <font size="1" face="MS Sans Serif">&nbsp;<%//=nf.format(Double.parseDouble(subtot))%>&nbsp;</font> 
              </td>
              <td width="16%">&nbsp;</td>
			  </tr></table>
            </tr>
            <%
				}
				%> -->
          </table>
      </tr>
    </table>
  </td>
</tr>
<%
				}//for
	%>
<table width="100%" border="0" cellspacing="2" cellpadding="0">
  <tr> 
    <td width="33%">&nbsp;</td>
</table>
<table width="100%" >
  <tr> 
    <td width="14%" height="20">&nbsp;</td>
    <td width="21%" height="20">&nbsp;</td>
    <td width="20%" height="20">&nbsp;</td>
    <td width="18%" height="20"><font size="1" face="MS Sans Serif"><b>Grand Total 
      : </b></font></td>
   <td width="18%" height="20"><font size="1" face="MS Sans Serif">&nbsp;&nbsp;<%=nf.format(Double.parseDouble((String)hshValues.get("grandtot")))%></font></td>
	<td width="12%" height="20">&nbsp;</td>
  </tr>
</table>
<%
}
else
{
%>
<h2> 
  <center>
    No Data Found
</center>
</h2>
<%}
%>
<br>
</body>
</html>

