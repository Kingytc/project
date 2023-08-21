<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.ArrayList"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
<title>Pre Sanction Report</title>


<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>

<%
			String address1 = (String) hshValues.get("perapp_address1");
			String address4 = (String) hshValues.get("address4");
			String City = (String) hshValues.get("City");
			String State = (String) hshValues.get("State");
			String Pincode = (String) hshValues.get("Pincode");
			String age = (String) hshValues.get("agecal");
			String edu = (String) hshValues.get("perapp_education");
			
			String strval = request.getParameter("val");

			String sel_construction = Helper.correctNull((String) hshValues
					.get("sel_construction"));
			String sel_borrower = Helper.correctNull((String) hshValues
					.get("sel_borrower"));
			String sel_map = Helper.correctNull((String) hshValues
					.get("sel_map"));
			ArrayList arrRow = (ArrayList) hshValues.get("arrRow");

			String strappname= Helper.correctNull((String) request.getParameter("appname"));
			String strsaral= Helper.correctNull((String) request.getParameter("hidsaral"));
			%>

<script>

var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";


function doClose()
    {
	var con=ConfirmMsg('100');
	if(con)
	{
		window.close();
	}
}
 
</script>


<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/report.css"
	type="text/css" />
</head>

<body  text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="">
<form name="appform" method="post">
<table width=98% " border="0" cellspacing="0" cellpadding="3"
	align="center">
	<tr>
		<td colspan="2">
		<table width="100%" cellpadding="5" cellspacing="0" border="0">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="1">
                <tr> 
                  <td> 
                    <table width="100%" cellpadding="3" cellspacing="0" border="0">
                      <tr> 
                          <td align="center" colspan="3"><img src="<%=ApplicationParams.getAppUrl()%>img/ubibilinguallogo.jpg" /></td>
                      </tr>
                      
                      <tr > 
                       <td align="center" colspan="3"><b>Branch - <%=Helper.correctNull((String)hshValues.get("orgname"))%></b></td>
                      </tr>
					  <tr>
    <td align="center" colspan="3"><%=Helper.correctNull((String)hshValues.get("orgadd1"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgadd2"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgcity"))%>,&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgstate"))%>-&nbsp;
   								<%=Helper.correctNull((String)hshValues.get("orgzip"))%>&nbsp;<hr/></td>
  </tr>
                      <tr > 
                        <td align="center" colspan="4"><strong><font size="2"
									face="MS Sans Serif"> PRE SANCTION INSPECTION 
                          REPORT </font></strong></td>
                      </tr>
                        <%if(strsaral.equalsIgnoreCase("saral"))
		{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"><lapschoice:inward/></td>
  </tr>
  <%}else
	{%>
  <tr> 
    <td valign="bottom" align="center" colspan="3"> <lapschoice:application/></td>
  </tr>
  <%}%>
                      <tr > 
                        <td align="center" colspan="4">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="4"> <b>DATE OF INSPECTION:<%=Helper.correctNull((String) hshValues
							.get("inspection_date"))%></b></td>
                      </tr>
                      <tr> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                            <tr> 
                              <td>FULL NAME AND ADDRESS</td>
                              <%if(strsaral.equalsIgnoreCase("saral")){%>
                              <td width="75%">&nbsp;<b><%=strappname%></b></td>
                              <%}else{ %>
                              <td width="75%">&nbsp;<b><%=Helper.correctNull((String) hshValues
          							.get("perapp_fname"))%></b></td>
                              <%}%>
                            </tr>
                            <%if(!(strsaral.equalsIgnoreCase("saral"))){%>
                            <tr> 
                              <td>&nbsp;</td>
                              <td width="75%">&nbsp;<b><%=address1%> </b></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td width="75%">&nbsp;<b><%=address4%> </b></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td width="75%">&nbsp;<b><%=City%> </b></td>
                            </tr>
                            <tr> 
                              <td>&nbsp;</td>
                              <td width="75%">&nbsp;<b><%=State%>-<%=Pincode%> 
                                </b></td>
                            </tr>
                            <tr> 
                              <td>AGE AND EDUCATION</td>
                              <td width="75%">&nbsp;<%=age  + "," + edu%></td>
                            </tr>
                            <%} %>
                            <tr> 
                              <td valign="top">BRIEF DESCRIPTION OF OTHER FAMILY 
                                MEMBERS</td>
                              <td width="75%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("other_family_members"))%></td>
                            </tr>
                            <tr> 
                              <td>PRESENT INCOME AND SOURCES OF INCOME</td>
                              <td width="75%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("present_income_source"))%></td>
                            </tr>
                            <tr> 
                              <td>OTHER INFORMATION</td>
                              <td width="75%">&nbsp;<%=Helper.correctNull((String) hshValues
							.get("other_information"))%></td>
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
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td> 
                    <table width="100%" cellpadding="3" cellspacing="0" border="0">
                      <tr > 
                        <td width="25%">WHETHER BORROWER IS FROM SERVICE AREA 
                          OF BRANCH</td>
                        <td width="34%">&nbsp; 
                          <%if (sel_borrower.equalsIgnoreCase("Y")) {
				out.println("Yes");
			} else if (sel_borrower.equalsIgnoreCase("N")) {
				out.println("No");
			}

			%>
                        </td>
                      </tr>
                      <tr > 
                        <td width="16%" valign="top">REVENUE MAP OBTAINED</td>
                        <td width="25%">&nbsp; 
                          <%if (sel_map.equalsIgnoreCase("Y")) {
				out.println("Yes");
			} else if (sel_map.equalsIgnoreCase("N")) {
				out.println("No");
			}

			%>
                        </td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>NEARBY LANDMARK FOR IDENTIFICATION 
                          : </b></td>
                      </tr>
                      <tr> 
                        <td width="25%">EAST</td>
                        <td width="34%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txr_east"))%> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" valign="top">WEST</td>
                        <td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txr_west"))%> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="16%" valign="top">SOUTH</td>
                        <td width="25%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txr_south"))%> 
                        </td>
                      </tr>
                      <tr> 
                        <td width="25%">NORTH</td>
                        <td width="34%">&nbsp;<%=Helper.correctNull((String) hshValues.get("txr_north"))%> 
                        </td>
                      </tr>
                    </table>
                    <br>
                    <table width="100%" cellpadding="3" cellspacing="0" border="0">
                      <tr > 
                        <td colspan="3"><b>PARTICULARS OF LAND-LOCATION,FERTILITY, 
                          OWNED LAND,LEASED LAND UNDER CULTIVATION,UNCULTIVABLE 
                          LAND, SOURCES OF IRRIGATION PARTICULARS OF SOURCE :</b></td>
                      </tr>
                      <tr > 
                        <td><%=Helper.correctNull((String) hshValues
							.get("land_particulars"))%>&nbsp;</td>
                        <td valign="top" width="41%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td valign="top" colspan="2"><b>THE AVAILABILITY OF WATER 
                          FROM SOURCE OF IRRIGATION-GIVE DETAILS:</b></td>
                      </tr>
                      <tr> 
                        <td valign="top"><%=Helper.correctNull((String) hshValues
							.get("water_avail_details"))%>&nbsp;</td>
                        <td width="41%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>LOAN AMOUNT APPLIED AND PURPOSE AND 
                          THE AREA TO BE BENEFITED FROM THE PROPOSED DEVELOPMENTS:</b></td>
                      </tr>
                      <tr> 
                        <td><%=Helper.correctNull((String) hshValues
									.get("benefit_area"))%>&nbsp;</td>
                        <td width="41%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>THE DETAILS OF CROPS BEING RAISED AT 
                          PRESENT AND THE DETAILS OF THE CROPS TO BE RAISED AS 
                          PER THE PROPOSED DEVELOPMENT.</b></td>
                      </tr>
                      <tr> 
                        <td><%=Helper.correctNull((String) hshValues
							.get("crops_details"))%>&nbsp;</td>
                        <td width="41%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>THE NAMES OF THE GUARANTOR/S,DETAILS 
                          OF ASSETS, LAND ,HOUSE ,AGRICULTURAL IMPLEMENTS ETC. 
                          AND VALUE OF EACH.</b></td>
                      </tr>
                      <tr> 
                        <td><%=Helper.correctNull((String) hshValues
							.get("asset_details"))%>&nbsp;</td>
                        <td width="41%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>TYPE OF CONSTRUCTION </b></td>
                      </tr>
                      <tr> 
                        <td colspan="2"> 
                          <%if (sel_construction.equalsIgnoreCase("0")) {
				out.println("");
			} else if (sel_construction.equalsIgnoreCase("1")) {
				out.println("RCC Construction");
			} else if (sel_construction.equalsIgnoreCase("2")) {
				out.println("Mud & Brick");
			} else if (sel_construction.equalsIgnoreCase("3")) {
				out.println("Sheed");
			} else if (sel_construction.equalsIgnoreCase("4")) {
				out.println("Kacha");
			} else if (sel_construction.equalsIgnoreCase("5")) {
				out.println("Tile roof houses");
			}

			%>
                          &nbsp;</td>
                      </tr>
                      <tr> 
                        <td colspan="2"><b>APPLICANT/S LIABILITIES AND DETAILS 
                          OF CHARGES ON THE LAND&nbsp;</b></td>
                      </tr>
                      <tr> 
                        <td colspan="2"><%=Helper.correctNull((String) hshValues
							.get("liability_details"))%></td>
                      </tr>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="1">
                <tr> 
                  <td> 
                    <table width="100%" cellpadding="3" cellspacing="0" border="0">
                      <%if (strval.equalsIgnoreCase("y")) {
				if (arrRow.size() > 0) {

				%>
                      <tr> 
                        <td><b>THE DETAILS OF EXISTING LIMITS </b></td>
                      </tr>
                      <%}

				%>
                      <%ArrayList arrCol = new ArrayList();
				for (int i = 0; i < arrRow.size(); i++) {
					arrCol = (ArrayList) arrRow.get(i);

					%>
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td width="16%"><b>SANCTION REFERENCE NO.</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(0))%></td>
                              <td width="18%"><b>DATE</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
                              <td width="22%"><b>AMOUNT OF LOAN SANCTIONED</b></td>
                              <td width="18%"><%=Helper.correctNull((String) arrCol.get(2))%> 
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%"><b>PURPOSE</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(3))%></td>
                              <td width="18%"><b>SANCTIONING AUTHORITY</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
                              <td width="22%"><b>LOAN AMOUNT DISBURSED</b></td>
                              <td width="18%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%> 
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%"><b>DATE OF DISBURSEMENT</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(6))%></td>
                              <td width="18%"><b>AMOUNT OUTSTANDING</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(7))%></td>
                              <td width="22%"><b>AMOUNT OVERDUE</b></td>
                              <td width="18%">&nbsp;<%=Helper.correctNull((String) arrCol.get(8))%> 
                              </td>
                            </tr>
                            <tr> 
                              <td width="16%"><b>WHETHER ACCOUNT IS REGULAR ?</b></td>
                              <td>&nbsp; 
                                <%if (Helper.correctNull((String) arrCol.get(9))
							.equalsIgnoreCase("y")) {
						out.println("Yes");
					} else {
						out.println("No");
					}

					%>
                              </td>
                              <td width="18%"><b>IF NOT, GIVE DETAILS OF IRREGULARITIES</b></td>
                              <td>&nbsp;<%=Helper.correctNull((String) arrCol.get(10))%></td>
                              <td width="22%"><b>WHETHER ALL THE TERMS &amp; CONDITIONS 
                                STIPULATED IN THE SANCTION ADVICE HAVE BEEN COMPLIED 
                                WITH ?</b></td>
                              <td width="18%">&nbsp; 
                                <%if (Helper.correctNull((String) arrCol.get(11))
							.equalsIgnoreCase("y")) {
						out.println("Yes");
					} else {
						out.println("No");
					}

				%>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <%}
			}

			%>
                    </table>
                  </td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" cellpadding="3" cellspacing="0" border="0">
                <tr> 
                  <td><b>WHAT ARRANGEMENTS HAVE BEEN MADE BY THE APPLICANT FOR 
                    EXPENSES/ CROP LOAN FOR RAISING THE CROPS, IN CASE OF MEDIUM 
                    TERM LOAN BEING APPLIED.</b></td>
                </tr>
                <tr> 
                  <td colspan="2"><%=Helper.correctNull((String) hshValues
							.get("applicant_arrangements"))%>&nbsp;</td>
                </tr>
                <tr> 
                  <td><b>COMMENTS IN DETAIL AND RECOMMENDATION REGARDING TECHNICAL 
                    FEASIBILITY AND ECONOMICAL VIABILITY OF THE PROPOSAL AND OTHER 
                    INFORMATIONS</b></td>
                </tr>
                <tr> 
                  <td><%=Helper.correctNull((String) hshValues
							.get("recommendation"))%>&nbsp;</td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
          <tr> 
            <td> 
              <table width="100%" cellpadding="3" cellspacing="0" border="0">
                <tr> 
                  <td WIDTH="20%" align="left">&nbsp;</td>
                  <td WIDTH="30%" align="left">&nbsp;</td>
                  <td align="left" COLSPAN="2" >SIGNATURE OF INSPECTING OFFICER</td>
                </tr>
                <tr> 
                  <td colspan="5" align="center"></td>
                </tr>
                <tr> 
                  <td align="center" WIDTH="20%">&nbsp;</td>
                  <td align="center" WIDTH="30%">&nbsp;</td>
                  <td align="left" WIDTH="27%"><B>NAME :</B></td>
                  <td align="left" WIDTH="23%"><%=Helper.correctNull((String) hshValues.get("nameofinsp"))%></td>
                </tr>
                <tr> 
                  <td align="center" WIDTH="20%">&nbsp;</td>
                  <td align="center" WIDTH="30%">&nbsp;</td>
                  <td align="left" width="27%">P.F NUMBER:</td>
                  <td align="left" width="23%"><%=Helper.correctNull((String) hshValues.get("panum"))%></td>
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
            <td>&nbsp;</td>
          </tr>
        </table>
       </td>
      </tr>
     </table>
     
</form>
</body>
</html>
