<%@ page import="com.sai.laps.helper.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
String strAmt=Helper.correctNull((String)hshValues.get("category"));
if(strAmt.equals("c"))
	strAmt=" Lacs";
else
	strAmt="";

String strDetails=Helper.correctNull((String)hshValues.get("additional_details"));
String[] strArrDet=strDetails.split("\n");
strDetails="";
for(int j=0;j<strArrDet.length;j++)
{
	if(!strArrDet[j].equalsIgnoreCase(""))
	strDetails=strDetails+(j+1)+"."+strArrDet[j]+"<br>";
}

if(strDetails.equalsIgnoreCase(""))
	strDetails="Nil";

String strRLPF=Helper.correctNull((String)hshValues.get("usr_rlpftype"));
if(strRLPF.equalsIgnoreCase("012"))
	strRLPF="CLPH";
else if(strRLPF.equalsIgnoreCase("999"))
	strRLPF="CLPU";
else
	strRLPF="";

%>
<html>
<head>
<title>ACKNOWLEDGEMENT SLIP</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
</head>
<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" class="bgcolor">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form method="post" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
<td valign="top">
  <p style="page-break-after: always">
  <table width="80%" border="0" cellspacing="0" cellpadding="5" align="center" valign="top">
    <tr> 
      <td align="right" colspan="2"><b>(Customer Copy)</b></td>
    </tr>
    <tr> 
      <td align="center" colspan="2"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
    </tr>
    <tr> 
      <td class="tabactive" align="center" colspan="2"><b>Branch - 
        <%=Helper.correctNull((String)hshValues.get("orgname"))%> <%if(!strRLPF.equalsIgnoreCase("")){ %> [<%=strRLPF %>]<%} %><br>
        <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp;
        <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp;
        <%=Helper.correctNull((String)hshValues.get("orgcity"))%>.&nbsp;
         <%=Helper.correctNull((String)hshValues.get("orgstate"))%>&nbsp;
          <%=Helper.correctNull((String)hshValues.get("orgzip"))%>.
         <br> Tel No :  <%=Helper.correctNull((String)hshValues.get("orgphone"))%></b> 
        <hr>
      </td>
    </tr>
    <tr> 
      <td width="50%" valign="top" align="left">Application Inward No:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("inwardno"))%></b></td>
      <td width="50%" valign="top" align="right">Date:-<b><%=Helper.correctNull((String)hshValues.get("createdon"))%></b>&nbsp;</td>
    </tr>
    <tr> 
      <td valign="top"  class="tabactive" align="center" colspan="2"><b>ACKNOWLEDGEMENT 
        SLIP</b></td>
    </tr>
    <tr> 
      <td valign="top" colspan="2">To,</td>
    </tr>
    <tr> 
      <td valign="top" colspan="2"><b><%=Helper.correctNull((String)hshValues.get("customername"))%><br>
        <% if(!(Helper.correctNull((String)hshValues.get("customeradd1")).equals(""))){%>
        <%=Helper.correctNull((String)hshValues.get("customeradd1"))%> <br>
        <% }%>
        <% if(!(Helper.correctNull((String)hshValues.get("customeradd2")).equals(""))){%>
        <%=Helper.correctNull((String)hshValues.get("customeradd2"))%> <br>
        <% }%>
        <% if(!(Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
        <%=Helper.correctNull((String)hshValues.get("customercity"))+" - "%><%=Helper.correctNull((String)hshValues.get("customerpin"))%> 
        <br>
        <%}else{ %>
        <%=Helper.correctNull((String)hshValues.get("customercity"))%> <br>
        <% }}%>
        <% if((Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
        <%=Helper.correctNull((String)hshValues.get("customerpin"))%> <br>
        <%} }%>
        <% if(!(Helper.correctNull((String)hshValues.get("customerstate")).equals(""))){%>
        <%=Helper.correctNull((String)hshValues.get("customerstate"))%> <br>
        <% }%>
        </b></td>
    </tr>
    <tr> 
      <td valign="top" colspan="2"> 
        <p align="justify">We acknowledge the receipt of your loan application 
          on <b><%=Helper.correctNull((String)hshValues.get("appliedon"))%></b> 
          for <b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%> 
          </b> under <b><%=Helper.correctNull((String)hshValues.get("category")).equals("t")?"Tertiary":Helper.correctNull((String)hshValues.get("category")).equals("p")?"Retail":Helper.correctNull((String)hshValues.get("category")).equals("a")?"Agriculture":"Corporate/SME"%></b> 
          sector for the purpose of <b><%=Helper.correctNull((String)hshValues.get("loanpurpose"))%></b>.</p>
      </td>
    </tr>
    <%if(Helper.correctNull((String)hshValues.get("category")).equals("t")||(Helper.correctNull((String)hshValues.get("category")).equals("c")))  {%>
    <tr> 
      <td valign="top" colspan="2">Details of credit limits applied for: &nbsp;</td>
    </tr>
    <tr> 
      <td valign="top" colspan="2">
      	<table width="51%">
      		<tr>
      			<td colspan="3">1.&nbsp;Fund Based</td>
      		</tr>
      		<tr>
      			<td width="50%">a.&nbsp;Working Capital</td>
      			<td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
      			<td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital"))))%></b></td>
      		</tr>
      		<tr>
      			<td>b.&nbsp;Term loan</td>
      			<td><b><%=ApplicationParams.getCurrency()%></b></td>
      			  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan"))))%></b></td>
      		</tr>
      		<tr>
      			<td>2.&nbsp;Non Fund Based</td>
      			<td><b><%=ApplicationParams.getCurrency()%></b></td>
      			  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%></b></td>
      		</tr>
      	</table>
      </td>
    </tr>
    <%}%>
    <tr> 
      <td valign="top" colspan="2"> 
        <p>On receipt of the following documents, the application will be treated 
          as complete and will be considered for further processing:</p>
        <!--         Additional details / requirements to be submitted if 
          any other than those mentioned in checklist: -->
      </td>
    </tr>
    <tr> 
            <td valign="top" colspan="2"><b><%=strDetails%></b>&nbsp;</td>
    </tr>
    <tr> 
      <td valign="top" align="right" colspan="2">For Karnataka Bank Ltd.</td>
    </tr>
    <tr> 
      <td valign="top" colspan="2">&nbsp;</td>
    </tr>
    <tr> 
      <td valign="top" align="right" colspan="2">Branch Manager</td>
    </tr>
  </table>
<p style="page-break-after: always">
        <table width="80%" border="0" cellspacing="0" cellpadding="5" align="center" valign="top">
          <tr> 
            <td align="right" colspan="2"><b>(Branch Copy)</b></td>
          </tr>
          <tr> 
            <td align="center" colspan="2"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
          </tr>
          <tr> 
            <td class="tabactive" align="center" colspan="2"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%> <%if(!strRLPF.equalsIgnoreCase("")){ %> [<%=strRLPF %>]<%} %><br>
              <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgcity"))%>.&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgstate"))%>&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgzip"))%></b> 
              <hr>
            </td>
          </tr>
          <tr> 
            <td width="50%" valign="top" align="left">Application Inward No:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("inwardno"))%></b></td>
            <td width="50%" valign="top" align="right">Date:-<b><%=Helper.correctNull((String)hshValues.get("createdon"))%></b>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top"  class="tabactive" align="center" colspan="2"><b>ACKNOWLEDGEMENT 
              SLIP</b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">To,</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"><b><%=Helper.correctNull((String)hshValues.get("customername"))%><br>
              <% if(!(Helper.correctNull((String)hshValues.get("customeradd1")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customeradd1"))%> <br>
              <% }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customeradd2")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customeradd2"))%> <br>
              <% }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
              <%=Helper.correctNull((String)hshValues.get("customercity"))+" - "%><%=Helper.correctNull((String)hshValues.get("customerpin"))%> 
              <br>
              <%}else{ %>
              <%=Helper.correctNull((String)hshValues.get("customercity"))%> <br>
              <% }}%>
              <% if((Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
              <%=Helper.correctNull((String)hshValues.get("customerpin"))%> <br>
              <%} }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customerstate")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customerstate"))%> 
              <br>
              <% }%>
              </b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <p align="justify">We acknowledge the receipt of your loan application 
                on <b><%=Helper.correctNull((String)hshValues.get("appliedon"))%></b> 
                for <b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%> 
                </b> under <b><%=Helper.correctNull((String)hshValues.get("category")).equals("t")?"Tertiary":Helper.correctNull((String)hshValues.get("category")).equals("p")?"Retail":Helper.correctNull((String)hshValues.get("category")).equals("a")?"Agriculture":"Corporate/SME"%></b> 
                sector for the purpose of <b><%=Helper.correctNull((String)hshValues.get("loanpurpose"))%></b>.</p>
            </td>
          </tr>
           <%if(Helper.correctNull((String)hshValues.get("category")).equals("t")||(Helper.correctNull((String)hshValues.get("category")).equals("c")))  {%>
          <tr> 
            <td valign="top" colspan="2">Details of credit limits applied for: 
              &nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="48%">
                <tr> 
                  <td colspan="3">1.&nbsp;Fund Based</td>
                </tr>
                <tr> 
                  <td width="50%">a.&nbsp;Working Capital</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital"))))%></b></td>
                </tr>
                <tr> 
                  <td>b.&nbsp;Term loan</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan"))))%></b></td>
                </tr>
                <tr> 
                  <td>2.&nbsp;Non Fund Based</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%></b></td>
                </tr>
              </table>
            </td>
          </tr>
         <%} %>
          <tr> 
            <td valign="top" colspan="2"> 
              <p>On receipt of the following documents, the application will be 
                treated as complete and will be considered for further processing:</p>
              <!--         Additional details / requirements to be submitted if 
          any other than those mentioned in checklist: -->
            </td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"><b><%=strDetails%></b>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" colspan="2">For Karnataka Bank Ltd.</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" colspan="2">Branch Manager</td>
          </tr>
          <%if(Helper.correctNull((String)hshValues.get("category")).equals("t")||(Helper.correctNull((String)hshValues.get("category")).equals("c")))  {%>
          <%}%>
        </table>
<%if(Helper.correctNull((String)hshValues.get("processedat")).equals("2")){ %>
<p style="page-break-after: always">
        <table width="80%" border="0" cellspacing="0" cellpadding="5" align="center" valign="top">
          <tr> 
            <td align="right" colspan="2"><b>(SARAL Copy)</b></td>
          </tr>
          <tr> 
            <td align="center" colspan="2"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg"></td>
          </tr>
          <tr> 
            <td class="tabactive" align="center" colspan="2"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%>  <%if(!strRLPF.equalsIgnoreCase("")){ %> [<%=strRLPF %>]<%} %><br>
              <%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgcity"))%>.&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgstate"))%>&nbsp; 
              <%=Helper.correctNull((String)hshValues.get("orgzip"))%></b> 
              <hr>
            </td>
          </tr>
          <tr> 
            <td width="50%" valign="top" align="left">Application Inward No:&nbsp;<b><%=Helper.correctNull((String)hshValues.get("inwardno"))%></b></td>
            <td width="50%" valign="top" align="right">Date:-<b><%=Helper.correctNull((String)hshValues.get("createdon"))%></b>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top"  class="tabactive" align="center" colspan="2"><b>ACKNOWLEDGEMENT 
              SLIP</b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">To,</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"><b><%=Helper.correctNull((String)hshValues.get("customername"))%><br>
              <% if(!(Helper.correctNull((String)hshValues.get("customeradd1")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customeradd1"))%> <br>
              <% }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customeradd2")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customeradd2"))%> <br>
              <% }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
              <%=Helper.correctNull((String)hshValues.get("customercity"))+" - "%><%=Helper.correctNull((String)hshValues.get("customerpin"))%> 
              <br>
              <%}else{ %>
              <%=Helper.correctNull((String)hshValues.get("customercity"))%> <br>
              <% }}%>
              <% if((Helper.correctNull((String)hshValues.get("customercity")).equals(""))){
    	  if(!(Helper.correctNull((String)hshValues.get("customerpin")).equals(""))){
      %>
              <%=Helper.correctNull((String)hshValues.get("customerpin"))%> <br>
              <%} }%>
              <% if(!(Helper.correctNull((String)hshValues.get("customerstate")).equals(""))){%>
              <%=Helper.correctNull((String)hshValues.get("customerstate"))%> 
              <br>
              <% }%>
              </b></td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <p align="justify">We acknowledge the receipt of your loan application 
                on <b><%=Helper.correctNull((String)hshValues.get("appliedon"))%></b> 
                for <b>Rs. <%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital")))+
        		  Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%> 
                </b> under <b><%=Helper.correctNull((String)hshValues.get("category")).equals("t")?"Tertiary":Helper.correctNull((String)hshValues.get("category")).equals("p")?"Retail":Helper.correctNull((String)hshValues.get("category")).equals("a")?"Agriculture":"Corporate/SME"%></b> 
                sector for the purpose of <b><%=Helper.correctNull((String)hshValues.get("loanpurpose"))%></b>.</p>
            </td>
          </tr>
           <%if(Helper.correctNull((String)hshValues.get("category")).equals("t")||(Helper.correctNull((String)hshValues.get("category")).equals("c")))  {%>
          <tr> 
            <td valign="top" colspan="2">Details of credit limits applied for: 
              &nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"> 
              <table width="45%">
                <tr> 
                  <td colspan="3">1.&nbsp;Fund Based</td>
                </tr>
                <tr> 
                  <td width="50%">a.&nbsp;Working Capital</td>
                  <td width="3%"><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundworkingcapital"))))%></b></td>
                </tr>
                <tr> 
                  <td>b.&nbsp;Term loan</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("fundtermloan"))))%></b></td>
                </tr>
                <tr> 
                  <td>2.&nbsp;Non Fund Based</td>
                  <td><b><%=ApplicationParams.getCurrency()%></b></td>
                  <td align="right"><b><%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)hshValues.get("nonfund"))))%></b></td>
                </tr>
              </table>
            </td>
          </tr>
          <%} %>
          <tr> 
            <td valign="top" colspan="2"> 
              <p>On receipt of the following documents, the application will be 
                treated as complete and will be considered for further processing:</p>
              <!--         Additional details / requirements to be submitted if 
          any other than those mentioned in checklist: -->
            </td>
          </tr>
          <tr> 
            <td valign="top" colspan="2"><b><%=strDetails%></b>&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" colspan="2">For Karnataka Bank Ltd.</td>
          </tr>
          <tr> 
            <td valign="top" colspan="2">&nbsp;</td>
          </tr>
          <tr> 
            <td valign="top" align="right" colspan="2">Branch Manager</td>
          </tr>
          <%if(Helper.correctNull((String)hshValues.get("category")).equals("t")||(Helper.correctNull((String)hshValues.get("category")).equals("c")))  {%>
          <%}%>
        </table>
<%} %>
</td>
</tr>
</table>

</form>
</body>
</html>