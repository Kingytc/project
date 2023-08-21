<%@include file="../share/directives.jsp"%>
  <%
  String strsaral=Helper.correctNull((String)request.getParameter("hidsaral"));	
  String strappname=Helper.correctNull((String)request.getParameter("appname"));
 	ArrayList arryCol = null;
			ArrayList arryRow = (ArrayList) hshValues.get("arrRow");
			
java.text.NumberFormat nf=java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<html>
<head>
<title>INSPECTION REPORT</title>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252">
<meta content="Microsoft FrontPage 3.0" name="GENERATOR">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css"/>
</head>

<body bgcolor="white">
<form name="frmstock" method=post>

<table width="100%" border="0" cellspacing="0" cellpadding="4" >
        <tr>
       
          <td align="center" colspan="3"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
      
        </tr>
 </table>

<table cellSpacing="0" cellPadding="0" width="100%" border="0">
<TBODY>
  <tr>
 <td align="center" colspan="3"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
  </tr>
<tr>
    <td align="center" colspan="3"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp;<hr/></td>
  </tr>
  <tr>
      <td width="100%" colSpan="4" align="center"> 
     <b>  Inspection Report</b>
      </td>
  </tr>
   <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><div id="top"><lapschoice:inward/></div></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><div id="top"> <lapschoice:application/></div></td>
  </tr>
  <%}%>
  <tr>
    <td width="100%" colSpan="4">&nbsp;</td>
  </tr>
</TBODY>
</table>
<table width="100%" border="0" cellspacing="1" cellpadding="3">
      <tr><td><div id="top"> 
<table width="100%" border="0" cellspacing="1" cellpadding="3">
     <tr> 
      <td width="22%">Date of visit</td>
      <td colspan="2">
      <%=Helper.correctNull((String)hshValues.get("ins_dateofvisit"))%>
       </td>
    </tr>
	<tr> 
      <td width="22%">Name of the Applicant / Borrower:</td>
      <td colspan="2">
       <%if(strsaral.equalsIgnoreCase("saral")){ %>
       <%=strappname%>
       <%}else{ %>
      <%=Helper.correctNull((String)hshValues.get("app_name"))%>
      <%}%>
       </td>
    </tr>
	<tr>
      <td width="22%">Distance from branch</td>
      <td colspan="2"><%=Helper.correctNull((String)hshValues.get("ins_distance"))%> </td>
    </tr>
	<tr>
      <td width="22%">Purpose of Loan </td>
      <td colspan="2"><%=Helper.correctNull((String)hshValues.get("ins_purpose"))%>  </td>
    </tr>
	<tr>
      <td width="22%"> Loan amount requested</td>
      <td colspan="2" > <%=ApplicationParams.getCurrency()%> <%=Helper.correctNull((String)hshValues.get("ins_amtreqd"))%></td>
    </tr>
	
	   <tr> 
      <td colspan="3">  Facility / ies Proposed to be availed from Bank</td>
    </tr>
	
    <tr> 
      <td width="22%">Purpose</td>
      <td width="34%">Type of Facility</td>
      <td width="44%">Loan amount requested (<%=ApplicationParams.getCurrency()%>)</td>
    </tr>
   
	<%for (int i = 1; i < 5; i++) {
				if (arryRow != null && arryRow.size() >= i) {
					arryCol = (ArrayList) arryRow.get(i - 1);
					if (arryCol != null) {%>
						 <tr> 
      <td width="22%"> 
     <%=Helper.correctNull((String)arryCol.get(2))%>
      </td>
      <td width="34%"> 
        <%=Helper.correctNull((String)arryCol.get(3))%>
      </td>
      <td width="44%"> <%=Helper.correctNull((String)arryCol.get(4))%> </td>
    </tr>
		<%}
				}%>    
	<%}//end of for statement

			%>
   
	 
	  <tr> 
            
      <td width="" colspan="2">Business premises is </td>
          <% String permises=Helper.correctNull((String)hshValues.get("ins_businessper"));
          if(permises.equalsIgnoreCase("1"))
          {
        	  permises="Owned";
          }
          else if(permises.equalsIgnoreCase("2"))
          {
        	  permises="Leased";
          }
          else if(permises.equalsIgnoreCase("3"))
          {
        	  permises="Rented";
          }
          else if(permises.equalsIgnoreCase("4"))
          {
        	  permises="Others";
          }
          else
          {
        	  permises="";
          }
          
          %>  
      <td width=""  colspan="2"> 
     <%=permises%>
            </td>
          </tr>
		    <tr> 
            
      <td width="22%"  colspan="2">Nature of ownership</td>
             <% String owership=Helper.correctNull((String)hshValues.get("ins_natureofbusiness"));
          if(owership.equalsIgnoreCase("1"))
          {
        	  owership="Free hold";
          }
          else if(owership.equalsIgnoreCase("2"))
          {
        	  owership="Lease hold";
          }
          else if(owership.equalsIgnoreCase("3"))
          {
        	  owership="Licence";
          }
          else if(owership.equalsIgnoreCase("4"))
          {
        	  owership="Undivided share";
          }
          else if(owership.equalsIgnoreCase("5"))
          {
        	  owership="Trust property";
          }
          else if(owership.equalsIgnoreCase("6"))
          {
        	  owership="Title only by possession";
          }
          else
          {
        	  owership="";
          }
          
          %>  
      <td width="34%"  colspan="2"> 
       <%=owership%>
      </td>
          </tr>
		   
      <td width="22%"  colspan="2">Business Address:</td>
            
      <td width="34%"  colspan="2"> 
       <%=Helper.correctNull((String) hshValues
									.get("ins_businessaddr"))%>
      </td>
          </tr>
    <tr> 
      <td colspan="3"> Nearby Landmarks for Identification:</td>
    </tr>
    <tr> 
      <td colspan="3"><div id="top">
        <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td width="15%">North</td>
            <td width="32%"> 
            <%=Helper.correctNull((String) hshValues
									.get("ins_landmarknorth"))%>
            </td>
            <td width="18%">East</td>
            <td width="35%"> 
             <%=Helper.correctNull((String) hshValues
									.get("ins_landmarkeast"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%">West</td>
            <td width="32%"> 
    <%=Helper.correctNull((String) hshValues
									.get("ins_landmarkwest"))%>
            </td>
            <td width="18%">South</td>
            <td width="35%"> 
         <%=Helper.correctNull((String) hshValues
									.get("ins_landmarksouth"))%>
          </tr>
        </table>
        </div>
      </td>
    </tr>
    <tr> 
      <td colspan="3"> <div id="top">
        <table width="100%" border="0" cellspacing="1" cellpadding="3">
		
		 <tr> 
      <td colspan="4">  Security offered</td>
    </tr>
       
          <tr> 
            <td width="15%">Primary Security:</td>
            <td width="32%"> 
 <%=Helper.correctNull((String) hshValues
							.get("ins_prisecurity"))%>
            <td width="19%">Collateral Security:</td>
            <td width="34%"> 
          <%=Helper.correctNull((String) hshValues
							.get("ins_collsecurity"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%">Present Banker, if any</td>
            <td width="32%"> 
            <%=Helper.correctNull((String) hshValues
							.get("ins_presentbanker"))%>
            <td width="19%">&nbsp;</td>
            <td width="34%">&nbsp; </td>
          </tr>
          <tr> 
            <td width="15%"> Loan Outstanding</td>
            <td width="32%">With Other Bank 1</td>
            <td width="19%">&nbsp;</td>
            <td width="34%">With Other Bank 2</td>
          </tr>
          <tr> 
            <td width="15%">Name of the Bank/Branch:</td>
            <td width="32%"> 
       <%=Helper.correctNull((String)hshValues.get("ins_ourbranchname"))%>
            </td>
            <td width="15%"> Name of the Bank/Branch:</td>
            <td width="32%"> 
            <%=Helper.correctNull((String)hshValues.get("ins_othrbankname"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%">Type of Loan:</td>
            <td width="32%"> 
<%=Helper.correctNull((String)hshValues.get("ins_ourloantype"))%>
            </td>
            <td width="15%">Type of Loan:</td>
            <td width="32%"> 
           <%=Helper.correctNull((String)hshValues.get("ins_othrloantype"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Amount Sanctioned: </td>
            <td width="32%"> <%=ApplicationParams.getCurrency()%>
<%=Helper.correctNull((String)hshValues.get("ins_ouramtsanc"))%>
            </td>
            <td width="15%"> Amount Sanctioned</td>
            <td width="32%"><%=ApplicationParams.getCurrency()%> 
<%=Helper.correctNull((String)hshValues.get("ins_othramtsanc"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%">Date of Loan:</td>
            <td width="32%"> 
<%=Helper.correctNull((String)hshValues.get("ins_ourloandate"))%>
              </td>
            <td width="15%"> Date of Loan:</td>
            <td width="32%"> 
<%=Helper.correctNull((String)hshValues.get("ins_othrloandate"))%>
             </td>
          </tr>
          <tr> 
            <td width="15%">Balance outstanding:</td>
            <td width="32%"> <%=ApplicationParams.getCurrency()%>
<%=Helper.correctNull((String)hshValues.get("ins_ourbalos"))%>
            </td>
            <td width="15%">Balance outstanding:</td>
            <td width="32%"> <%=ApplicationParams.getCurrency()%>
       <%=Helper.correctNull((String)hshValues.get("ins_othrbalos"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Overdue if any :</td>
            <td width="32%"> <%=ApplicationParams.getCurrency()%>
<%=Helper.correctNull((String)hshValues.get("ins_ouroverdue"))%>
            </td>
            <td width="15%"> Overdue if any </td>
            <td width="32%"> <%=ApplicationParams.getCurrency()%>
<%=Helper.correctNull((String)hshValues.get("ins_othroverdue"))%>
            </td>
          </tr>
    <tr> 
      <td colspan="4"> <b>Due Diligence</b></td>
    </tr>
		      <tr> 
      <td colspan="4"> <b>A) For KYC Norms</b></td>
    </tr>
       
          <tr> 
            <td width="15%">Name and Address of person contacted</td>
            <td width="32%"> 
 <%=Helper.correctNull((String) hshValues
							.get("ins_kycpernameaddr"))%>
            </td>
            <td width="19%"> Whether related to applicant?</td>
			<%
			String relation=Helper.correctNull((String)hshValues.get("ins_kycperrelated"));
			if(relation.equalsIgnoreCase("1"))
			{
				relation="Yes";
			}
			else if(relation.equalsIgnoreCase("2"))
			{
				relation="No";
			}
			else
			{
				relation="";
			}
			
			%>
            <td width="34%"> 
             <%=relation%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Since when he/she knows the applicant</td>
            <td width="32%"> 
<%=Helper.correctNull((String)hshValues.get("ins_kycpersincewhen"))%>
            </td>
            <td width="15%"> Since when the applicant is staying at given address</td>
            <td width="32%"> 
         <%=Helper.correctNull((String)hshValues.get("ins_appstayinaddr"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Opinion / Views gathered</td>
            <td width="32%"> 
            <%=Helper.correctNull((String) hshValues
							.get("ins_opiniongathered"))%>
            </td>
            <td width="15%">&nbsp; </td>
            <td width="32%">&nbsp; </td>
          </tr>
		      <tr> 
      <td colspan="4"> <b>Property Details</b></td>
    </tr>
          
          <tr> 
            <td width="15%"> Name and Address of person contacted</td>
            <td width="32%"> 
           <%=Helper.correctNull((String) hshValues
							.get("ins_proppernameaddr"))%>
            </td>
            <td width="15%"> Name of the neighbour</td>
            <td width="32%"> 
<%=Helper.correctNull((String)hshValues.get("ins_propneighbour"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Whether the properties owned by applicant / guarantor 
              and in their possession?</td>
            <td width="32%"> 
        <%=Helper.correctNull((String) hshValues
							.get("ins_propinpossession"))%>
            </td>
            <td width="15%"> Location of the property is as declared by applicant 
              and prevailing market rate</td>
            <td width="32%"> 
<%=Helper.correctNull((String) hshValues
							.get("ins_proplocation"))%>
            </td>
          </tr>
          <tr> 
            <td width="15%"> Observations / Comments of Inspecting officer:</td>
            <td width="32%"> 
  <%=Helper.correctNull((String) hshValues
							.get("ins_officercomments"))%>
            </td>
            <td width="15%">&nbsp; </td>
            <td width="32%">&nbsp; </td
          ></tr>
        </table>
        </div>
      </td>
    </tr>
  </table>
  </div>
  </td>
  </tr>
  </table>
  <p>&nbsp;</p>

  <table border="0" width="100%">
    <tr> 
      <td width="42%" align="center">&nbsp;</td>
      <td width="12%" align="center">&nbsp;</td>
      <td width="46%" align="center">Signature:</td>
    </tr>
    <tr> 
      <td width="42%"> Place: </td>
      <td width="12%">&nbsp;</td>
      <td width="46%"> 
        <p align="left">Name of inspecting officer:
      </td>
    </tr>
    <tr> 
      <td width="42%">Date:</td>
      <td width="12%">&nbsp;</td>
      <td width="46%"> 
        <p align="left">Designation 
      </td>
    </tr>
    <tr> 
      <td width="42%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="46%">P. A. No. </td>
    </tr>
    <tr> 
      <td width="42%">&nbsp;</td>
      <td width="12%">&nbsp;</td>
      <td width="46%">&nbsp;</td>
    </tr>
  </table>

<input type="hidden" name="cbsname1" value="<%=Helper.correctNull((String)request.getParameter("cbsname"))%>">


</form>
</body>
</html>
