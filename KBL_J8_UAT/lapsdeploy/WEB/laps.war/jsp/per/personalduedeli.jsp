<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
ArrayList vec = new ArrayList();

int vecsize = 0;

if (hshValues != null) 
{
	vec = (ArrayList) hshValues.get("vecRow2");
	
	
}
if (vec != null) 
{
	vecsize = vec.size();
}


ArrayList g1 = new ArrayList();

%>
<% String str=Helper.correctNull((String)hshValues.get("auth_dealer"));%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">
<title>ANNEXURE - 4.3</title>
</head>

<body>

         <table width="100%" border="0" cellspacing="0" cellpadding="4">
        <tr>
          
          <td align="center" ><img src="<%=ApplicationParams.getAppUrl()%>img/lapstitle/ubilogo.gif"><br>
      Pre-Sanction inspection/due Diligence report in respect of the <br> 
       applicant and the vechile dealer</td>
          
    <td align="right">Annexure-4.3<br />
            </td>
        </tr>
      </table>
    
    
<br>
<table width="100%" border="1" cellspacing="0" cellpadding="3">
  <tr> 
    <td width="3%">1</td>
    <td width="47%">Name of the Applicant:<%=Helper.correctNull((String)hshValues.get("perapp_title"))%> 
      <%=Helper.correctNull((String)hshValues.get("appname"))%></td>
    <td width="50%">Age:<%=Helper.correctNull((String)hshValues.get("age"))%> 
      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
      <%String value=Helper.correctNull((String)hshValues.get("perapp_hname"));
     
       String sex=Helper.correctNull((String)hshValues.get("perapp_sex"));
   if(sex.equalsIgnoreCase("M"))
   {
    if(value.equalsIgnoreCase("2"))
    {
    	%>
      H/o.<%=Helper.correctNull((String)hshValues.get("perapp_husname")) %>&nbsp;and 
      S/o.<%=Helper.correctNull((String)hshValues.get("perapp_fatname")) %> 
      <% }else if(value.equalsIgnoreCase("1")){
    %>
      S/o.<%=Helper.correctNull((String)hshValues.get("perapp_fatname")) %> 
      <%
    }
   }else
   {
	   if(value.equalsIgnoreCase("2"))
	    {
	    	%>
      w/o.<%=Helper.correctNull((String)hshValues.get("perapp_husname")) %> 
      <% }else if(value.equalsIgnoreCase("1")){
	    %>
      D/o.<%=Helper.correctNull((String)hshValues.get("perapp_fatname")) %> 
      <%
	    }  
   }

%>
    </td>
  </tr>
  <tr> 
    <td>2</td>
    <td>Present occupation:<%=Helper.correctNull((String)hshValues.get("occup_name"))%></td>
    <td>Experience:<%=Helper.correctNull((String)hshValues.get("peremp_yresemp"))%>(Years)</td>
  </tr>
  <tr> 
    <td>3</td>
    <td>Address:Residence<br> 
      <%String address1=Helper.correctNull((String)hshValues.get("perapp_address1"));
      if(address1.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address1"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address1"))%>,&nbsp; 
      <br /> 
      <%
      }
         %>
      <%
      String address2=Helper.correctNull((String)hshValues.get("perapp_address2"));
      if(address2.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address2"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address2"))%>,&nbsp; 
      <br /> 
      <%
      }
         %>
      <%
      String address3=Helper.correctNull((String)hshValues.get("perapp_address3"));
      if(address3.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address3"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("perapp_address3"))%>,&nbsp; 
      <br /> 
      <%
      }

         %>
      <%=Helper.correctNull((String)hshValues.get("perapp_city"))%> - <%= Helper.correctNull((String)hshValues.get("perapp_zip"))%>.&nbsp; 
      <br /> <%=Helper.correctNull((String)hshValues.get("perapp_state"))%> &nbsp;<br />
      Phone: <%=Helper.correctNull((String)hshValues.get("perapp_phone"))%><br> 
    </td>
    <td>Address:Office/Business<br> <%=Helper.correctNull((String)hshValues.get("peremp_name"))%> 
      <%String addresse1=Helper.correctNull((String)hshValues.get("peremp_address1"));
      if(addresse1.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address1"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address1"))%>,&nbsp; 
      <br /> 
      <%
      }
         %>
      <%
      String addresse2=Helper.correctNull((String)hshValues.get("peremp_address2"));
      if(addresse2.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address2"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address2"))%>,&nbsp; 
      <br /> 
      <%
      }
         %>
      <%
      String addresse3=Helper.correctNull((String)hshValues.get("peremp_address3"));
      if(addresse3.equalsIgnoreCase(""))
      {
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address3"))%> 
      <%
      } else{
      %>
      <%=Helper.correctNull((String)hshValues.get("peremp_address3"))%>,&nbsp; 
      <br /> 
      <%
      }
         %>
      <%=Helper.correctNull((String)hshValues.get("peremp_city"))%> - <%= Helper.correctNull((String)hshValues.get("peremp_zip"))%>.&nbsp; 
      <br /> <%=Helper.correctNull((String)hshValues.get("peremp_state"))%> &nbsp;<br />
      Phone: <%=Helper.correctNull((String)hshValues.get("peremp_phone"))%> </tr>
  <tr> 
    <td>4</td>
    <td>Source of verification/identification of the applicant</td>
    <td > 
      <%String str6=Helper.correctNull((String)hshValues.get("src_verification"));
      if(str6.equalsIgnoreCase("1"))
      {
      %>
      <%out.println("Employer's Idetification Card");%>
      <%
      } else  if(str6.equalsIgnoreCase("2")){
      %>
      <%out.println("Votere's ID card");%>
      <%
      }
      else  if(str6.equalsIgnoreCase("3")){
          %>
      <%out.println("PAN Card");%>
      <%
          }
      else  if(str6.equalsIgnoreCase("4")){
          %>
      <%out.println("Others ( e.g. Telephoe Bill etc.,specify)");%>
      <%
          }
     
      else{
    	  %>
      <%out.println("Employers Certificate");%>
      <%
      }
         %>
    </td>
  </tr>
  <tr> 
    <td>5</td>
    <td colspan="2">Particulars of references made:(At least 2 references shall 
      be obtained to confirm the identity of the applicant.)</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>Reference No.1</td>
    <td>Reference No.2</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <%
                                        String name,design,pno,id;
                                        
                                        if(vecsize!=0)
                                        {
                                        	
                                        	 if(vecsize!=3)
                                        	 {
                                        	for(int i=0;i<vecsize;i++)
                                        	{
                                        		g1=(ArrayList)vec.get(i);
                                        		if(g1!=null)
                                        		{
                                        			name=Helper.correctNull((String)g1.get(0));
                                        			design=Helper.correctNull((String)g1.get(1));
                                        			pno=Helper.correctNull((String)g1.get(2));
                                        			id=Helper.correctNull((String)g1.get(3));
                                        			%>
    <td>Name:&nbsp;<%=name %><br>
      Address:&nbsp;<%=id %><br>
      Phone No. &nbsp;<%=pno %><br>
      Designation: &nbsp;<%=design %> </td>
    <%
                                        		}
                                        	}
                                        }
                                        }else
                                		{
                                			%>
    <td>Name:&nbsp;<br>
      Address:&nbsp;<br>
      Phone No:&nbsp;<br>
      Designation:&nbsp;</td>
    <%}
                                        %>
  </tr>
  <tr> 
    <td>6.</td>
    <td>Whether latest I.T.Return verified</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>7.</td>
    <td>Whether statement of Assets &amp; Liabilities verified ?</td>
    <td>&nbsp;</td>
  </tr>
  <tr> 
    <td>8.</td>
    <td colspan="2">I Confirm having verified the various details furnished above 
      and the details furnished above are true to the best of my knowledge and 
      belief.</td>
  </tr>
  <tr> 
    <td>&nbsp;</td>
    <td>Details of the Official who conducted the verification<br>
      Name : <%=Helper.correctNull((String)hshValues.get("verf_doneby"))%> E.No: 
      <%=Helper.correctNull((String)hshValues.get("auto_userid"))%> </td>
    <td>Signature:<br>
      Date: <%=Helper.correctNull((String)hshValues.get("perapp_date"))%></td>
  </tr>
</table>
</body>
</html>

