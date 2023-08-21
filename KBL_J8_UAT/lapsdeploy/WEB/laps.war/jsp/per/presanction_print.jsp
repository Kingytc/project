<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<laps:handleerror />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }

out.print(hshValues.get("pre_accdetailsverifyfrom"));	
//out.println("HSHVALUES===>"+hshValues);	
String per_residence=Helper.correctNull((String)hshValues.get("pre_residence"));
String residence="";
if((per_residence!="null")||(per_residence!=""))
{
if(per_residence.equalsIgnoreCase("1"))
{
	  residence="Owned";
}
if(per_residence.equalsIgnoreCase("2"))
{
	  residence="Rented";
}
if(per_residence.equalsIgnoreCase("3"))
{
	  residence="Leased";
}
if(per_residence.equalsIgnoreCase("4"))
{
	  residence="Others";
}
if(per_residence.equalsIgnoreCase("5"))
{
	  residence="Provided by Employer";
}
}
String accdet=Helper.correctNull((String)hshValues.get("pre_accdetailsverifyfrom"));
if((accdet!="null")||(accdet!=""))
{
	if(accdet.equalsIgnoreCase("1"))
	{
		accdet="Bank Statement";
	}
	if(accdet.equalsIgnoreCase("2"))
	{
		accdet="Pass Book";
	}
}
else
{
	accdet="";
}
	
	
	
String strapplnamedisplayed=Helper.correctNull((String)hshValues.get("pre_applnamedisplayed"));	
String stremployment= Helper.correctNull((String) session.getAttribute("perapp_employment"));  
String per_accdetails=Helper.correctNull((String)hshValues.get("per_accdetails"));
String per_engineer=Helper.correctNull((String)hshValues.get("per_engineer"));
String per_request=Helper.correctNull((String)hshValues.get("per_request"));

String per_chkreturn=Helper.correctNull((String)hshValues.get("per_chkreturn"));

%>
<html>
<head>
<title>Retail Lending - Pre-sanction visit report</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
a:hover {  color: #FF3300}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>jsp/htm/link.css" type="text/css">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF" >
<jsp:include page="../share/help.jsp" flush="true"/> 
<form name="frmpri" method = post>
  <table width="96%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom"><img src="<%=ApplicationParams.getAppUrl()%>img/ubilogo.gif"></td>
    </tr>
    <tr> 
      <td valign="middle" align="center"><font face="MS Sans Serif" size="2"><font color="#000000" size="3" face="Times New Roman, Times, serif"><b><font face="MS Sans Serif" size="2">PRE-SANCTION 
        VISIT REPORT FOR RETAIL LOANS</font></b></font></font></td>
    </tr>
    
  </table>
  <table width="96%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#FFFFFF" bordercolordark="#EEEEEE"  align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="1">
          <tr> 
            <td valign="top" width="97%"><font face="MS Sans Serif" size="1"></font></td>
          </tr>
          <tr> 
            <td valign="top" width="97%"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="25%"><font face="MS Sans Serif" size="1"> <b>NAME 
                    OF THE APPLICANT</b></font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%"><font face="MS Sans Serif" size="1">Mr./Ms/Smt.<%=Helper.correctNull((String)hshValues.get("pre_name"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="25%" valign="top"><font face="MS Sans Serif" size="1"> 
                    <b>FATHER'S /HUSBAND'S NAME</b></font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="middle"><font face="MS Sans Serif" size="1">Mr.<%=Helper.correctNull((String)hshValues.get("perapp_fatname"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="25%"><font face="MS Sans Serif" size="1"> <b>RESIDENTIAL 
                    ADDRESS</b><br>
                    <br>
                    <br>
                    </font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" height="47"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_address"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="25%" valign="top"><font face="MS Sans Serif" size="1"> 
                    PURPOSE OF LOAN</font></td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("pre_loanpurpose"))%></font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="25%"> 
                    <p><font face="MS Sans Serif" size="1">NAME OF THE PRODUCT 
                      / ARTICLE TO BE PURCHASED</font></p>
                  </td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_product"))%> 
                    </font></td>
                </tr>
                <tr> 
                  <td width="25%" valign="top"><font face="MS Sans Serif" size="1">NAME 
                    OF THE SUPPLIER</font></td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_supplier"))%></font></td>
                </tr>
                <tr> 
                  <td width="25%" valign="top"><font face="MS Sans Serif" size="1">PURCHASE 
                    PRICE</font></td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif" size="1">Rs: 
                    &nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_purchaseprice"))%>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(inclusive 
                    of taxes)</font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td width="25%" valign="top"> 
                    <p><font face="MS Sans Serif" size="1"> <b>GENUINESS OF QUOTATION 
                      VERIFIED</b></font> </p>
                  </td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif" size="1">a) 
                    OVER PHONE NO.&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_genuinessphone"))%><br>
                    b) NAME OF THE PERSON CONTACTED &nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_genphcontperson"))%></font></td>
                </tr>
                <tr> 
                  <td width="25%" valign="top">&nbsp;</td>
                  <td width="1%" valign="top"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif" size="1">a) 
                    BY PERSONAL VISIT &nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_genuinesspersonal"))%><br>
                    b) NAME OF THE PERSON CONTACTED&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_genpercontperson"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="25%"><font face="MS Sans Serif" size="1">DATE OF 
                    VISIT </font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="74%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_visitdate"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr valign="top"> 
                  <td width="85%"><font face="MS Sans Serif" size="1"> PROOF FOR 
                    VERIFICATION OF RESIDENTIAL ADDRESS --- Ration Card No., Voters 
              ID Card No., Passport No./PAN Card No.,Rent Agreement, Electricity/Telephone 
              6 months and -1-latest bill). Whether residing with parents/relatives </font></td>
                  
                </tr>
                <tr valign="top"> 
                  <td width="42%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_proof"))%></font></td>
                  <td width="58%">&nbsp;</td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="1">
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr valign="top"> 
                        <td><font face="MS Sans Serif" size="1">Residence is :&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=residence%></font></td>
                        <td colspan="5">&nbsp;</td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="4"><font face="MS Sans Serif" size="1">Place visited 
                    with Identification Landmark :<%=Helper.correctNull((String)hshValues.get("per_placevisit"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td colspan="3" height="18">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="3" height="18"><font face="MS Sans Serif" size="1"> 
                    <b>OCCUPATION OF APPLICANT (GIVE DETAILS): </b></font></td>
                </tr>
                
                  <%
          if(stremployment.equalsIgnoreCase("1")){
          %>
          <tr> 
            <td colspan="2"  bordercolor="0"><font
					face="MS Sans Serif" size="1"><b>SERVICE </b></font></td>
            <td colspan="2" bordercolor="0"><font face="MS Sans Serif" size="1"><b>EMPLOYMENT 
              DETAILS </b></font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">NAME OF EMPLOYER</font></td>
            <td><%=Helper.correctNull((String)hshValues.get("pre_employername"))%>
            
            </td>
            <td bordercolor="0"><font face="MS Sans Serif" size="1">DETAILS VERIFIED 
              BY/THROUGH <br>
              PERSONAL VISIT TO OFFICE ON </td>
            <td bordercolor="0"> <%=Helper.correctNull((String)hshValues.get("pre_employerverify"))%>
              
            </td>
          </tr>
          <tr> 
            <td ><font face="MS Sans Serif" size="1">Address</font></td>
            <td > <%=Helper.correctNull((String) hshValues.get("pre_employeraddress"))%>
             </td>
            <td ><font face="MS Sans Serif" size="1">NAME OF PERSON 
              CONTACTED </font></td>
            <td > <%=Helper.correctNull((String)hshValues.get("pre_emppersoncontact"))%>
              </td>
          </tr>
          <tr> 
            <td ><font size="1" face="MS Sans Serif">DESIGNATION	</font></td>
            <td > <%=Helper.correctNull((String)hshValues.get("pre_employeedesig"))%>
             
            </td>
            <td><font face="MS Sans Serif" size="1">GROSS ANNUAL/MONTHLY 
              INCOME -<br>
              IF ANY DEVIATION FOUND </font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_employeeincome"))%>
              
            </td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">WORKING SINCE</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_employeeworksince"))%>
             
            </td>
            <td><font size="1" face="MS Sans Serif">EMPLOYEE NO.</font></td>
            <td><%=Helper.correctNull((String)hshValues.get("pre_employeeno"))%> 
             
            </td>
          </tr>
          <tr> 
            <td ><font face="MS Sans Serif" size="1">WHETHER CONFIRMED/PROBATION/OR 
              ON CONTRACT BASIS</font></td>
            <td > <%=Helper.correctNull((String)hshValues.get("pre_employerconfirm"))%>
              
            </td>
            <td>&nbsp; </td>
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">Phone No.</font></td>
            <td><font face="MS Sans Serif" size="1"> OFFICE</font></td>
            <td><font face="MS Sans Serif" size="1">RESIDENCE</font></td>
            <td><font face="MS Sans Serif" size="1">MOBILE</font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">&nbsp;</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_employerofficephone"))%>
             </td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_employerresiphone"))%>
               </td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_employermobile"))%>
             
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <%} if(stremployment.equalsIgnoreCase("2")){ %>
          <tr> 
            <td colspan="4" bordercolor="0" ><font
					face="MS Sans Serif" size="1"><b>BUSINESS</b></font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">NAME OF THE 
              FIRM</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_businessfirmname"))%>
                     </td>
            <td><font face="MS Sans Serif" size="1">ADDRESS</font></td>
            <td> <%=Helper.correctNull((String) hshValues.get("pre_businessfirmaddr"))%>
              
            </td>
          </tr>
          <tr> 
            <td ><font face="MS Sans Serif" size="1">REGISTRATION 
              NO.</font></td>
            <td > <%=Helper.correctNull((String)hshValues.get("pre_businessfirmregno"))%>
              
            </td>
            <td><font face="MS Sans Serif" size="1">LICENCE NO.</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmlicenceno"))%>
              
            </td>
          </tr>
          <tr> 
            <td colspan="4"><font face="MS Sans Serif" size="1"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">EAST</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmeastlandmark"))%>
              
            </td>
            <td><font face="MS Sans Serif" size="1">WEST</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmwestlandmark"))%>
              
            </td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">NORTH</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmnorthlandmark"))%>
                   </td>
            <td><font face="MS Sans Serif" size="1">SOUTH</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmsouthlandmark"))%>
              
            </td>
          </tr>
          <tr> 
            <td  colspan="4">&nbsp;</td>
          </tr>
          <tr> 
            <td ><font size="1" face="MS Sans Serif">APPLICANTS 
              POSITION IN THE FIRM</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmposition"))%>
                   </td>
            <td><font face="MS Sans Serif" size="1">YEAR OF ESTABLISHMENT</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmestabyr"))%>
              
            </td>
          </tr>
          <tr> 
            <td><font size="1" face="MS Sans Serif">NATURE OF 
              BUSINESS</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_busifirmnature"))%>
              
            </td>
        <!--     <td bordercolor="0"><font size="1" face="MS Sans Serif">APPLICANTS 
              NAME BOARD DISPLAYED</font></td>
            <td bordercolor="0"> 
              <select name="sel_applnamedisplayed">
                <%if(strapplnamedisplayed.trim().equalsIgnoreCase("S")){ %>
                <option value="S" selected>&lt;---Select---&gt;</option>
				<%}else {%>
				<option value="S">&lt;---Select---&gt;</option>
				 <%}if(strapplnamedisplayed.trim().equalsIgnoreCase("Y")){ %>
				 <option value="Y"  selected>Yes</option>
				 <%}else {%>
                <option value="Y">Yes</option>
				 <%}if(strapplnamedisplayed.trim().equalsIgnoreCase("N")){ %>
				  <option value="N"  selected>No</option>
				 <%}else {%>
                <option value="N">No</option>
				<%}%>
              </select>
            </td> -->
          </tr>
          <%} if(stremployment.equalsIgnoreCase("3")){ %>
          <tr> 
            <td colspan="4"><font
					face="MS Sans Serif" size="1"><b>SELF-EMPLOYED &amp; PROFESSIONAL 
              </b></font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">OCCUPATION</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfoccupation"))%>
             
            </td>
            <td><font face="MS Sans Serif" size="1">BUSINESS ADDRESS</font></td>
            <td> <%=Helper.correctNull((String) hshValues.get("pre_selfempaddress"))%>
              
          </tr>
          <tr> 
            <td ><font face="MS Sans Serif" size="1">REGISTRATION 
              NO.</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfempregno"))%>
                </td>
            <td ><font face="MS Sans Serif" size="1">LICENCE NO.</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfemplicenceno"))%>
              
            </td>
          </tr>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4"><font face="MS Sans Serif" size="1"><b>NEARBY LANDMARK 
              FOR IDENTIFICATION : </b></font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">EAST</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfempeastlandmark"))%>
              
            </td>
            <td><font face="MS Sans Serif" size="1">WEST</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfempwestlandmark"))%>
              
            </td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">NORTH</font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfempnorthlandmark"))%>
              
            </td>
            <td><font face="MS Sans Serif" size="1">SOUTH</font></td>
            <td><%=Helper.correctNull((String)hshValues.get("pre_selfempsouthlandmark"))%> 
             
            </td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">Phone No.</font></td>
            <td><font face="MS Sans Serif" size="1">OFFICE</font></td>
            <td><font face="MS Sans Serif" size="1">RESIDENCE</font></td>
            <td><font face="MS Sans Serif" size="1">MOBILE</font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">&nbsp;</font></td>
            <td><%=Helper.correctNull((String)hshValues.get("pre_selfempofficephone"))%></td>
                
            <td ><%=Helper.correctNull((String)hshValues.get("pre_selfempresiphone"))%> </td>
      
            <td> <%=Helper.correctNull((String)hshValues.get("pre_selfempmobile"))%></td>
          
            
          </tr>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
          <%}if(stremployment.equalsIgnoreCase("3") || stremployment.equalsIgnoreCase("2") || stremployment.equalsIgnoreCase("1") ){ %>
          <tr bgcolor="#CCCCCC"> 
            <td colspan="4" bordercolor="0"><font face="MS Sans Serif" size="1"><b>DETAILS 
              VERIFIED FROM: </b> </font></td>
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">a. FORM NO.16 
              (FOR THE FINANCIAL YEAR ENDED MARCH 200...) </font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_form16"))%>
              
            </td>
            <td><font face="MS Sans Serif" size="1">b. LAST SALARY 
              SLIP (FOR THE MONTH OF </font></td>
            <td> <%=Helper.correctNull((String)hshValues.get("pre_salslip"))%></td>
                        
          </tr>
          <tr> 
            <td><font face="MS Sans Serif" size="1">c. INCOME 
              TAX RETURN FOR A.Y. (ALONG WITH ORIGINAL COPY OF TAX CHALLAN PERIOD</font></td>
            <td><%=Helper.correctNull((String)hshValues.get("pre_taxreturn"))%> 
              
            </td>
            <td bordercolor="0">&nbsp;</td>
            <td bordercolor="0">&nbsp;</td>
          </tr>
          <%} %>
          <tr> 
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
            <td>&nbsp;</td>
          </tr>
                
                
                <tr> 
                  <td colspan="3" height="18"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3">
                      <tr> 
                        <td><font face="MS Sans Serif" size="1">A) SERVICE </font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">B) 
                          BUSINESS</font></td>
                      </tr>
                      <tr> 
                        <td><font face="MS Sans Serif" size="1"> Name of employer 
                          &nbsp;<%=Helper.correctNull((String)hshValues.get("pre_employername"))%></font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">Name 
                          of the firm&nbsp;<%=Helper.correctNull((String)hshValues.get("per_firmname"))%></font></td>
                      </tr>
                      <tr valign="top"> 
                        <td><font face="MS Sans Serif" size="1">Address&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_employeraddress"))%><br>
                          <br>
                          <br>
                          <br>
                          </font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">Address&nbsp;<%=Helper.correctNull((String)hshValues.get("per_add2"))%></font></td>
                      </tr>
                      <tr> 
                        <td><font face="MS Sans Serif" size="1"> Designation &nbsp;<%=Helper.correctNull((String)hshValues.get("pre_employeedesig"))%> 
                          </font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">Applicants 
                          position in the firm&nbsp;<%=Helper.correctNull((String)hshValues.get("per_position"))%></font></td>
                      </tr>
                      <tr> 
                        <td><font face="MS Sans Serif" size="1"> Working Since 
                          &nbsp;<%=Helper.correctNull((String)hshValues.get("pre_employeeworksince"))%></font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">Established 
                          since&nbsp;<%=Helper.correctNull((String)hshValues.get("per_establish"))%></font></td>
                      </tr>
                      <tr> 
                        <td><font face="MS Sans Serif" size="1"> Employee No. 
                          <%=Helper.correctNull((String)hshValues.get("pre_employeeno"))%></font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">Nature 
                          of Business&nbsp;<%=Helper.correctNull((String)hshValues.get("per_nature"))%></font></td>
                      </tr>
                      <tr valign="top"> 
                        <td><font face="MS Sans Serif" size="1">Whether confirmed 
                          / probation / or on contract basis</font></td>
                        <td width="8%">&nbsp;</td>
                        <td colspan="2" width="41%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_confirm"))%></font></td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td width="14%"><font face="MS Sans Serif" size="1">Phone 
                                No. </font></td>
                              <td width="6%"><font face="MS Sans Serif" size="1">Office 
                                </font></td>
                              <td width="22%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_office"))%></font></td>
                              <td width="9%"><font face="MS Sans Serif" size="1">Residence 
                                </font></td>
                              <td width="20%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_resi"))%></font></td>
                              <td width="7%"><font face="MS Sans Serif" size="1">Mobile</font></td>
                              <td width="22%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_mobile"))%></font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4">&nbsp;</td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4"><font face="MS Sans Serif" size="1"><b>SELF-EMPLOYED 
                          &amp; PROFESSIONAL </b></font></td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4"><font face="MS Sans Serif" size="1">Occupation&nbsp;<%=Helper.correctNull((String)hshValues.get("per_occupation"))%></font></td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4"><font face="MS Sans Serif" size="1">Address&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_add3"))%><br>
                          <br>
                          </font></td>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td width="14%"><font face="MS Sans Serif" size="1">Phone 
                                No. </font></td>
                              <td width="6%"><font face="MS Sans Serif" size="1">Office 
                                </font></td>
                              <td width="22%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_office2"))%></font></td>
                              <td width="9%"><font face="MS Sans Serif" size="1">Residence 
                                </font></td>
                              <td width="20%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_resi2"))%></font></td>
                              <td width="7%"><font face="MS Sans Serif" size="1">Mobile</font></td>
                              <td width="22%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_mobile2"))%></font></td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <!-- <tr> 
                  <td width="25%"><font face="MS Sans Serif, Verdana" size="1">Location/address 
                    of the Property</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="25%"><font face="MS Sans Serif, Verdana" size="1">Present 
                    Status / Stage of Construction</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%">&nbsp; </td>
                </tr>
                <tr> 
                  <td width="25%"><font face="MS Sans Serif, Verdana" size="1">Status 
                    of Occupation ( X )</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td><font face="MS Sans Serif, Verdana" size="1">Self 
                          Occupied</font></td>
                        <td><font face="MS Sans Serif, Verdana" size="1">Rented 
                          out</font></td>
                        <td><font face="MS Sans Serif, Verdana" size="1">Vacant</font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td width="25%"><font face="MS Sans Serif, Verdana" size="1">Value 
                    as per valuation report/approx. expensesincurred on repairs/renovation</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%" valign="top">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="25%"><font face="MS Sans Serif, Verdana" size="1">Date 
                    of last valuation</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%" valign="top">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="25%" valign="top"><font face="MS Sans Serif, Verdana" size="1">Whether 
                    Insurance taken under Uni-Home Care Policy</font></td>
                  <td width="1%"><font face="MS Sans Serif, Verdana" size="1">:</font></td>
                  <td width="74%" valign="top"><font face="MS Sans Serif, Verdana" size="1">Yes/No 
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;If Yes, 
                    date</font></td>
                </tr>-->
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <br>
			  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="29%"><font face="MS Sans Serif" size="1"><b>EMPLOYMENT 
                    DETAILS</b></font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1"><b>:</b></font></td>
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="29%"><font face="MS Sans Serif" size="1">Details 
                    verified by / through Personal visit to Office on </font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_verify"))%></font></td>
                  <td><font face="MS Sans Serif" size="1">Name of person contacted 
                    : <%=Helper.correctNull((String)hshValues.get("per_person2"))%></font></td>
                </tr>
                <tr> 
                  <td width="29%"><font face="MS Sans Serif" size="1">Over Tel. 
                    No.</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="20%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_overtel2"))%></font></td>
                  <td width="50%"><font face="MS Sans Serif" size="1">Name of 
                    person contacted : <%=Helper.correctNull((String)hshValues.get("per_persontel2"))%></font></td>
                </tr>
                <tr> 
                  <td width="29%"><font face="MS Sans Serif" size="1">Gross Annual 
                    / Monthly Income</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td colspan="2"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_income"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr valign="top">
                  <td width="29%">&nbsp;</td>
                  <td width="1%">&nbsp;</td>
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td width="29%"><font face="MS Sans Serif" size="1"> <b>DETAILS 
                    VERIFIED FROM</b></font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td colspan="2">&nbsp;</td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4"><font face="MS Sans Serif" size="1"> Form No.16 
                    (for the financial year ended&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_form16"))%></font></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4"><font face="MS Sans Serif" size="1"> Last Salary 
                    Slip (for the month of&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_salslip"))%></font></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4"><font face="MS Sans Serif" size="1"> Income 
                    tax Return for A.Y (along with original copy of Tax Challan 
                    Period ) &nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_taxreturn"))%><br>
                    </font></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4"><font face="MS Sans Serif" size="1"> Number 
                    of dependants&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("perapp_depend"))%></font></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="4"><font face="MS Sans Serif" size="1"> Total annual/monthly 
                    deductions Rs:&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_deductions"))%></font></td>
                </tr>
                <tr valign="top"> 
                  <td colspan="3"><font face="MS Sans Serif" size="1"> Net annual/monthly 
                    income</font></td>
                  <td width="55%"><font face="MS Sans Serif" size="1">Rs&nbsp;<%=Helper.correctNull((String)hshValues.get("per_netincome"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="23%">&nbsp;</td>
                  <td width="49%">&nbsp;</td>
                  <td width="8%">&nbsp;</td>
                  <td width="20%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%"><font face="MS Sans Serif" size="1"> <b>PRESENT 
                    BANKERS</b></font></td>
                  <td width="49%">&nbsp;</td>
                  <td width="8%">&nbsp;</td>
                  <td width="20%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%"><font face="MS Sans Serif" size="1">Name of 
                    the Bank : </font></td>
                  <td width="49%"><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String)hshValues.get("pre_presentbank"))%></b></font></td>
                  <td width="8%"><font face="MS Sans Serif" size="1">Branch : </font></td>
                  <td width="20%"><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String)hshValues.get("pre_presentbankbranch"))%></b></font></td>
                </tr>
                <tr> 
                  <td width="23%"><font face="MS Sans Serif" size="1">Type of 
                    A/c. :</font></td>
                  <td width="49%"><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String)hshValues.get("pre_presentbankactype"))%></b></font></td>
                  <td width="8%"><font face="MS Sans Serif" size="1">A/c. No. :</font></td>
                  <td width="20%"><font face="MS Sans Serif" size="1"><b><%=Helper.correctNull((String)hshValues.get("pre_presentbankaccno"))%></b></font></td>
                </tr>
                <tr> 
                  <td width="23%"><font face="MS Sans Serif" size="1">Details 
                    of A/c verified from : </font></td>
                  <td colspan="3"><font face="MS Sans Serif" size="1">&nbsp;<b><%=accdet%></b></font></td>
                </tr>
                <!--  <tr> 
                  <td colspan="4"><font face="MS Sans Serif" size="1">Cheque returned- 
                    number of times : &nbsp;<%=per_chkreturn%></font></td>
                </tr>-->
              </table>
            </td>
          </tr>
        <!--    <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="23%">&nbsp;</td>
                  <td width="49%">&nbsp;</td>
                  <td width="8%">&nbsp;</td>
                  <td width="20%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%"><font face="MS Sans Serif" size="1"> <b>Old 
                    Vechile Details</b></font></td>
                  <td width="49%">&nbsp;</td>
                  <td width="8%">&nbsp;</td>
                  <td width="20%">&nbsp;</td>
                </tr>
                <tr> 
                  <td width="23%">Type of vehicle</td>
                  <td width="49%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_bank"))%></font></td>
                  <td width="8%">valued by </td>
                  <td width="20%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_branch"))%></font></td>
                </tr>
                <tr> 
                  <td width="23%">age of the vehicle</td>
                  <td width="49%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_type"))%></font></td>
                  <td width="8%">registration no</td>
                  <td width="20%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_accno"))%></font></td>
                </tr>
                <tr> 
                  <td width="23%">value of the vehicle</td>
                  <td colspan="3"><font face="MS Sans Serif" size="1">&nbsp;<%=per_accdetails%></font></td>
                </tr>
                <tr> 
                  <td colspan="4"><font face="MS Sans Serif" size="1">chassis 
                    No : &nbsp;<%=per_chkreturn%></font></td>
                </tr>
              
			   <tr> 
                  <td width="23%">engine No </td>
                  <td colspan="3"><font face="MS Sans Serif" size="1">&nbsp;<%=per_accdetails%></font></td>
                </tr>
                
              
			  
			  
			  
			  
			  
			  
			  </table>
			  
			  
			  
			  
			  
			  
			  
			  
			  
            </td>
          </tr>
		  
		  
		  -->
		  <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1"> <b>LOAN OUTSTANDING 
                    </b></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1"><b>WITH OUR BANK </b></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1"><b>WITH OTHER BANK </b></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Name of the Branch</font></td>
                  <td><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_ourbankname"))%></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_otherbankname"))%></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Type of Loan</font></td>
                  <td><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_ourbankloantype"))%></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_otherbankloantype"))%></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Amount sanctioned<%=per_request%></font></td>
                  <td><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_ourbanksancamt"))%></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_otherbanksancamt"))%></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Balance outstanding</font></td>
                  <td><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_ourbankosamt"))%></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_otherbankosamt"))%></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Amount of Overdues, 
                    if any</font></td>
                  <td><font face="MS Sans Serif" size="1">:</font></td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_ourbankoverdueamt"))%></font></td>
                  <td>&nbsp;</td>
                  <td><font face="MS Sans Serif" size="1">Rs.&nbsp;<%=Helper.correctNull((String)hshValues.get("pre_otherbankoverdueamt"))%></font></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"><font face="MS Sans Serif" size="1"></font></td>
          </tr>
          <tr> 
            <td width="97%" valign="top"><font face="MS Sans Serif" size="1"> 
              <b>DETAILS OF THE PROPERTY TO BE PURCHASED (to be filled only in 
              case of Housing Loans)</b></font></td>
          </tr>
          <tr> 
            <td width="97%" valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3">
                <tr> 
                  <td colspan="6"><font face="MS Sans Serif" size="1">Loan requested 
                    for (X)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</font></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td width="35%"><font face="MS Sans Serif" size="1">Sale Amount</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="64%"><font face="MS Sans Serif" size="1">Rs.&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_saleamt"))%></font></td>
                </tr>
                <tr> 
                  <td width="35%"><font face="MS Sans Serif" size="1">Value as 
                    per Valuation Report, value indicated in the sale deed may 
                    also be taken into account. In case of wide variation, comments 
                    required.</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="64%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_valreport"))%></font></td>
                </tr>
                <tr> 
                  <td width="35%"><font face="MS Sans Serif" size="1">Name of 
                    the person representing seller contacted &amp; details verified</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="64%"><font face="MS Sans Serif" size="1">&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_represent"))%></font></td>
                </tr>
                <tr> 
                  <td width="35%"><font face="MS Sans Serif" size="1">Area in 
                    sq.ft. as per sale agreement</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="64%"><font face="MS Sans Serif" size="1">&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_area"))%></font></td>
                </tr>
                <tr> 
                  <td width="35%"><font face="MS Sans Serif" size="1">Whether 
                    owner occupied or rented or leased out</font></td>
                  <td width="1%"><font face="MS Sans Serif" size="1">:</font></td>
                  <td width="64%"><font face="MS Sans Serif" size="1">&nbsp;<%=Helper.correctNull((String)hshValues.get("per_whether"))%></font></td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="0" cellpadding="2">
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Present state of construction&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_constructions"))%></font></td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1">Report / Valuation from 
                    Architect / Engineer Obtained &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<%=per_engineer%></font></td>
                </tr>
                <tr> 
                  <td>&nbsp;</td>
                </tr>
                <tr> 
                  <td><font face="MS Sans Serif" size="1"><b>NEARBY LANDMARK FOR 
                    IDENTIFICATION : </b></font></td>
                </tr>
                <tr> 
                  <td> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2">
                      <tr> 
                        <td width="10%"><font face="MS Sans Serif" size="1">EAST 
                          </font></td>
                        <td width="47%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_east"))%></font></td>
                        <td width="7%"><font face="MS Sans Serif" size="1">WEST</font></td>
                        <td width="36%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_west"))%></font></td>
                      </tr>
                      <tr> 
                        <td width="10%"><font face="MS Sans Serif" size="1">NORTH 
                          </font></td>
                        <td width="47%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_north"))%></font></td>
                        <td width="7%"><font face="MS Sans Serif" size="1">SOUTH</font></td>
                        <td width="36%"><font face="MS Sans Serif" size="1"><%=Helper.correctNull((String)hshValues.get("per_south"))%></font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td width="97%" valign="top"><font face="MS Sans Serif" size="1">COMMENTS 
              OF VISITING OFFICER</font></td>
          </tr>
          <tr> 
            <td width="97%" valign="top"><font face="MS Sans Serif" size="1"><br>
              <br>
              <%=Helper.correctNull((String)hshValues.get("per_comments"))%><br>
              <br>
              <br>
              </font></td>
          </tr>
        </table>
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr> 
            <td width="50%"><font face="MS Sans Serif" size="1">Place:. <%=Helper.correctNull((String)hshValues.get("per_signplace"))%><br>
              Date:.&nbsp;<%=Helper.correctNull((String)hshValues.get("per_signdate"))%></font></td>
            <td width="50%"> 
              <div align="right"><font face="MS Sans Serif" size="1">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(Signature 
                of Bank's Official)</font></div>
            </td>
          </tr>
          <tr> 
            <td width="50%"><font face="MS Sans Serif" size="1"></font></td>
            <td width="50%"> 
              <p>&nbsp;</p>
              <p><font face="MS Sans Serif" size="1">NAME :&nbsp;<%=Helper.correctNull((String)hshValues.get("per_signname"))%>&nbsp;&nbsp;DESIGNATION&nbsp;&nbsp;&nbsp;<%=Helper.correctNull((String)hshValues.get("per_signdesig"))%></font></p>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <tr> 
    <td valign="bottom"><br>
      <br>
  </form>
</body>
</html>
