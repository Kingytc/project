<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<% 
HashMap hshMoragageDetails= null;
ArrayList arrRow=new ArrayList();
ArrayList arrCol=null;
arrRow=(ArrayList)hshValues.get("arrRow");
hshMoragageDetails=(HashMap)hshValues.get("hshMoragageDetails");

%>
<html>
<head>
<title>Credit Process Audit</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/report.css" type="text/css">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
</script>

</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#FFFFFF" >
<form name="frmpri" method = post>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td valign="bottom" > 
        </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" height="380"  align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"> </div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5" height="100%" >
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0"  >
						  <tr>
						  <td>
						  <table width="100%" border="0" align="center">
						  <tr>
						            <td align="center">
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td align="center" colspan="3"><img
					src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"
					width="50" height="35"></td>
                                        </tr>
                                        <tr> 
                                          <td align="center" colspan="3"><b>UNION 
                                            BANK OF INDIA </b></td>
                                        </tr>
                                        <tr> 
                                          <td align="center" colspan="3"><B><%=Helper.correctNull((String) hshValues.get("OrgName"))%></B></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td>From : </td>
                                          <td>To :</td>
                                        </tr>
                                        <tr> 
                                          <td><%=Helper.correctNull((String) hshValues.get("UserName"))%></td>
                                          <td>The BM/CM/AGM/DGM</td>
                                        </tr>
                                        <tr> 
                                          <td><%=Helper.correctNull((String) hshValues.get("OrgName"))%></td>
                                          <td><%=Helper.correctNull((String)hshValues.get("APPROVED_ORGNAME"))%></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td>Ref :&nbsp;<%=Helper.correctNull((String)hshValues.get("credit_appno"))%></td>
                                          <td>Date :&nbsp;<%=Helper.getCurrentDateTime()%> 
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2">&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td>Account :&nbsp;<%=Helper.correctNull((String)hshValues.get("appname"))%></td>
                                          <td>Branch :&nbsp;<%=Helper.correctNull((String)hshValues.get("APPROVED_ORGNAME"))%></td>
                                        </tr>
                                        <tr> 
                                          <td>Sanction Advice No.&nbsp;: &nbsp;</td>
                                          <td>Date :&nbsp;<%=Helper.correctNull((String)hshValues.get("APP_PROCESSDATE"))%></td>
                                        </tr>
                                        <tr> 
                                          <td>Sanctioning Authority : &nbsp;<%=Helper.correctNull((String)hshValues.get("APPROVED_FNAME"))%>&nbsp;<%=Helper.correctNull((String)hshValues.get("APPROVED_LNAME"))%></td>
                                          <td>&nbsp;</td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2">&nbsp;</td>
                                        </tr>
                                      </table>
                                    </td>
						  </tr>
						  <tr>
                                    <td > 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td colspan="2" valign="top"> <p>I.&nbsp;
                                            As instructed by Regional Office/FGMO, 
                                              Vide&nbsp;<b><%=Helper.correctNull((String)hshValues.get("processcondvide"))%></b>,&nbsp;I &nbsp;have verified 
                                              compliance of the pre-disbursement 
                                              terms and conditions by the branch 
                                              officials as per the above sanction 
                                              advice and confirm that the branch 
                                              has complied with all the pre-disbursement 
                                              conditions, except the following 
                                              (if any):</p>
                                          </td>
                                        </tr>
                                        
                                      </table>
                                    </td>
									  </tr>
									  
								  <tr >
                                    <td>
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td> 
                                          <p>
                                            <%String process_condition=Helper.correctNull((String)hshValues.get("processcondition"));%>
                                            <%if (process_condition.trim().equals("")){%>
                                            Nil 
                                            <%}else{
				  StringTokenizer strIdV16c= new StringTokenizer(process_condition,"\n");
						  while (strIdV16c.hasMoreTokens())			
							{
							 String strTempV=(String)strIdV16c.nextToken();
							
							 out.println(strTempV+"<br>");
							
							}}%></p>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
							  </tr>
							  <tr>
							    <td>&nbsp;</td>
							  </tr>
							 <tr>
												<td><table width="100%" border="0" cellspacing="0" cellpadding="0"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
  <tr>
    <td align="center">II.</td>
    <td>I further confirm that the branch has recovered the applicable processing charges.</td>
  </tr>
</table>
</td>
												
											</tr>
  
							</table>
						  </td>
						  </tr>
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="4" align="center">
                                  <tr> 
                                    <td align="center"bgcolor="#FFFFFF" colspan="4"><b></b></td>
                                    <td align="center"bgcolor="#FFFFFF" width="38%"><b><font size="1" face="MS Sans Serif" color="#000000">Aspects</font></b></td>
                                    <td align="center" bgcolor="#FFFFFF" width="18%"><b><font size="1" face="MS Sans Serif" color="#000000">CPAO's 
                                      Observations</font></b></td>
                                    <td align="center" bgcolor="#FFFFFF" width="40%"><b><font size="1" face="MS Sans Serif" color="#000000">Comments</font></b></td>
                                  </tr>
                                  <%
								  arrRow=(ArrayList)hshValues.get("arrRow");
								  if(arrRow!=null && arrRow.size()>0)
								  {
								  	for(int i=0;i<arrRow.size();i++)	
									{
								  		arrCol=(ArrayList)arrRow.get(i);
										if(arrCol!=null && arrCol.size()>0)
										{
								  %>
                                  <tr> 
                                    <td colspan="4" valign="top" align="left"><%=Helper.correctNull((String)arrCol.get(3))%></td>
                                    <td  valign="top" align="left" width="38%"><%=Helper.correctNull((String)arrCol.get(0))%> 
                                      <input type="hidden" name="hidnorms" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
                                    </td>
                                    <td width="18%" align="center" valign="top"> 
                                      <%String strselreason=Helper.correctNull((String)arrCol.get(1));
										if(strselreason.equalsIgnoreCase("S"))
										{
											out.println("");
										}
										else if(strselreason.equalsIgnoreCase("Y"))
										{
											out.println("Yes");
										}
										else if(strselreason.equalsIgnoreCase("N"))
										{
											out.println("No");
										}
										else if(strselreason.equalsIgnoreCase("NA"))
										{
											out.println("NA");
										}
	                                      %>
                                    </td>
                                    <td width="40%"  align="center" valign="top">
                                    <p>
                                     <%//=Helper.correctNull((String)arrCol.get(2))%> 
                                     
                                     <%String comments=Helper.correctNull((String)arrCol.get(2));%>
                                            <%if (comments.trim().equals("")){%>
                                            &nbsp;
                                            <%}else{
				  StringTokenizer str_comments= new StringTokenizer(comments,"\n");
						  while (str_comments.hasMoreTokens())			
							{
							 String strTempcomments=(String)str_comments.nextToken();
							
							 out.println(strTempcomments+"<br>");
							
							}}%>
							
                                     </p>
                                    </td>
                                  </tr>
                                  <%}
								  }
								  }%>
                                </table>
                              </td>
                            </tr>
							<tr>
							<td>
							    <table width="100%" border="0">
                                  <tr> 
                                    <td colspan="2" >&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2"> 
                                      <table width="100%" border="0">
                                        <tr> 
                                          <td width="22%"  valign="top"  >Remarks 
                                            of Nominated officer</td>
                                          <td width="1%"  valign="top"  >:</td>
                                          <td width="82%">
                                          <p>
                                          <%String process_remarks=Helper.correctNull((String) hshValues.get("processremarks"));%>
                                            <%if (process_remarks.trim().equals("")){%>
                                            Nil 
                                            <%}else{
				  StringTokenizer str_remarks= new StringTokenizer(process_remarks,"\n");
						  while (str_remarks.hasMoreTokens())			
							{
							 String strTempRemarks=(String)str_remarks.nextToken();
							
							 out.println(strTempRemarks+"<br>");
							
							}}%>
							          </p>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" >&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2">* The branch has complied 
                                      with all the terms and conditions of sanction.</td>
                                  </tr>
                                  <tr> 
                                    <td align="center" colspan="2"><b>OR</b></td>
                                  </tr>
                                  <tr> 
                                    <td  colspan="2" >
                                      <p>* As some of the terms and conditions 
                                        are not complied with, as stated above, 
                                        branch has to take up the matter with 
                                        the sanctioning authority for either waiver/modification 
                                        of the conditions or extension of  time 
                                        for compliance before disbursment of the 
                                        facilities in the case of new account/enhancement 
                                        in case of existing accounts.</p>
                                    </td>
                                  </tr>
                                 
                                 
                                  <tr> 
                                    <td colspan="2" >
                                      <p>I have personally visited the site of 
                                        the mortgaged property situated as mentioned 
                                        below and have satisfied myself that the 
                                        property inspected by me is the same as 
                                        detailed in title deeds and title verification 
                                        report submitted by the branch and branch 
                                        advocate. Further I have satisfied myself 
                                        that the value of the property is approximately 
                                        the same as given by the branch.</p>
                                    </td>
                                  </tr>
                                  
                                  <tr align="left"> 
                                    <td colspan="2"> 
                                      <table width="95%" border="0" cellspacing="1" cellpadding="2" >
                                        <tr > 
                                          <td width="3%" align="center">&nbsp;</td>
                                          <td width="82%" ><b><font size="1" face="MS Sans Serif" color="#000000">Address of the Property</font></b></td>
                                          <td width="10%" ><b><font size="1" face="MS Sans Serif" color="#000000">Date of visit</font></b></td>
                                        </tr>
                                        <%
										arrCol=new ArrayList();
										arrRow=(ArrayList)hshMoragageDetails.get("arrRow");
										
										if(arrRow!=null && arrRow.size()>0)
										{
 							    			for(int i=0;i<arrRow.size();i++)
											{
 							    				arrCol=(ArrayList)arrRow.get(i);
									%>
                                        <tr > 
                                          <td width="3%" valign="top"><%=i+1%>.</td>
                                          <td width="82%" ><%=Helper.correctNull((String)arrCol.get(2))%></td>
                                          <td width="10%" valign="top"><%=Helper.correctNull((String)arrCol.get(3))%></td>
                                        </tr>
                                        <%
									}
									}
									%>
                                        <tr > 
                                          <td width="3%" align="center">&nbsp;</td>
                                          <td width="82%" align="left">&nbsp;</td>
                                          <td width="10%" align="left">&nbsp;</td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
								  <tr> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
								  <tr> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td width="60%">Date : </td>
                                    <td width="40%" ALIGN="CENTER">( <%=Helper.correctNull((String) hshValues.get("UserName"))%> )</td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                    <td ALIGN="CENTER">CREDIT PROCESS AUDIT OFFICER</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2">(Copy of the report to be 
                                      submitted to RO/FGMO and sanctioning authority).</td>
                                  </tr>
                                  <tr>
                                    <td colspan="2">*  Strike off whichever is not applicable.</td>
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
  </form>
</body>

</html>
