<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<%
	ArrayList v = new ArrayList();
	ArrayList g1 = new ArrayList();
%>

<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/per/persecurities.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
var strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var str_txtsecname   ="<%=Helper.correctNull((String)hshValues.get("str_txtsecname "))%>";
var str_txtdempar ="<%=Helper.correctNull((String)hshValues.get("str_txtdempar"))%>";
var str_txtstandname="<%=Helper.correctNull((String)hshValues.get("str_txtstandname"))%>";
var str_txtregfoliono="<%=Helper.correctNull((String)hshValues.get("str_txtregfoliono"))%>";
var str_txtfacvalue="<%=Helper.correctNull((String)hshValues.get("str_txtfacvalue"))%>";
var str_txtqty  ="<%=Helper.correctNull((String)hshValues.get("str_txtqty "))%>";
var str_txtmetvalue="<%=Helper.correctNull((String)hshValues.get("str_txtmetvalue"))%>";
var str_dtotal="<%=Helper.correctNull((String)hshValues.get("str_dtotal"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<style>
Div.cellcontainer
{
	height:200;overflow:auto
}



</style>
</head>
<body onload="onloading()">
<form method="post" name="frmpersecurities">
<table width="100%" border="1" cellpadding="0" cellspacing="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
  <tr> 
    <td>
      <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
      <jsp:param name="pageid" value="1" />
      </jsp:include>
    </td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
  <tr> 
    <td valign="top" colspan=5><font
			face="Times New Roman" size="3"><b><i>Home -&gt; Retail -&gt; <%=(String) session.getAttribute("pgeLabel")%> 
      -&gt;Applicant-&gt; Proposed Asset -&gt; Details of Securities</i></b></font></td>
  </tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
  <tr> 
    <td><lapschoice:application /></td>
  </tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr> 
    	<td valign="bottom"> 
     		<table width="93%" border="0" cellspacing="0" cellpadding="0" align="left">
				<tr align="center"> 
        			<td>
             			<jsp:include page="../per/applicanttab.jsp" flush="true"> 
             			<jsp:param name="linkid" value="5" />
                        </jsp:include>
            		</td>
        		</tr>
      		</table>
    	</td>
  	</tr>
</table>

       
            <table width="100%" border="1" cellspacing="0" cellpadding="0">
              <tr> 
                <td> 
                  <table width="91%" border="0" cellspacing="0" cellpadding="0" align="left">
                    <tr> 
                      <td> 
                        <jsp:include page="../per/ProposedAssetTabs.jsp" flush="true"> 
                        <jsp:param name="tabid" value="7" />
                        </jsp:include>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              <tr> 
                <td> 
                  <table border="1" cellspacing="0" cellpadding="3" width="100%"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                    <tr> 
                      <td> 
                        <table width="100%" border="1" cellspacing="0" cellpadding="3"
									bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                          <tr> 
                            <td> 
                              <table width="100%" border="0" cellspacing="0" cellpadding="3"
											align="center">
                                <tr> 
                                  <td width="100%" align="center"> 
                                    <table width="100%" border="0" cellspacing="0"
													cellpadding="3" bordercolorlight="#FFFFFB"
													bordercolordark="#DEDACF">
                                      <tr> 
                                        <td> 
                                          <table width="100%" border=0 " cellspacing="0"
															cellpadding="2">
                                            <tr class="blackfont"> 
                                              <td width="15%">Name 
                                                of the Security </td>
                                              <td width="19%">
                                                <input type="text" name="txtsecname" size="20" style="text-align:left" maxlength="50"
												value="">
                                              </td>
                                              <td width="16%">Demand 
                                                Particulars DP Id &amp; Client Id</td>
                                              <td width="11%">
                                                <input type="text" name="txtdempar" size="20" maxlength="30" value="">
                                              </td>
                                              <td width="23%">Standing 
                                                in the name of </td>
                                              <td width="23%">
                                                <input type="text" name="txtstandname" size="20" style="text-align:left" maxlength="15"
																	value="">
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td bgcolor="" width="15%">&nbsp;Reg. 
                                                Folio No</td>
                                              <td bgcolor="" width="19%">
                                                <input type="text"
																	name="txtregfoliono" size="20"	 style="text-align:left" maxlength="15"
																	value="">
                                              </td>
                                              <td bgcolor="" width="16%">Face 
                                                Value</td>
                                              <td bgcolor="" nowrap width="11%">
                                                <lapschoice:CurrencyTag
																	name="txtfacvalue" size="20"
																	
																	 maxlength="12"
																	value=''/>
                                              </td>
                                              <td bgcolor="" width="23%">Quantity</td>
                                              <td bgcolor="" width="23%">
                                                <input type="text"
																	name="txtqty" size="20"
																	onKeyPress="allowNumber(document.forms[0].txtqty)"
																	style="text-align:right" maxlength="7"
																	value="">
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td bgcolor="" width="15%">Mkt. 
                                                / Maturity Value/ NAV</td>
                                              <td bgcolor="" width="19%"><b> 
                                                <lapschoice:CurrencyTag
																	name="txtmetvalue" size="20"
																	maxlength="7"
																	value=''/>
                                                </b></td>
                                              <td bgcolor="" width="16%">&nbsp;</td>
                                              <td bgcolor="" nowrap width="11%">&nbsp;</td>
                                              <td bgcolor="" width="23%">&nbsp;</td>
                                              <td bgcolor="" width="23%">&nbsp;</td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                       <lapschoice:combutton btntype="NO" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>                                   
                                    
                                      <tr> 
                                        <td> 
                                          <table width="100%" border="0" cellspacing="0"
															cellpadding="0" bordercolorlight="#82829F"
															bordercolordark="#EBEBF8">
                                            <tr> 
                                              <td> 
                                                
                                      <table width="98%" border="0" cellspacing="1"
																	cellpadding="2" bordercolorlight="#FFFFFF"
																	bordercolordark="#DEDACF">
                                        <tr bgcolor="#71694F"> 
                                                    <!-- <td width="4%" align="center"></td> -->
                                                    <td width="5%" align="center"><font color="#FFFFFF"><b></b></font></td>
                                                    <td width="15%" align="center"><font
																			color="#FFFFFF"><b>Name 
                                                      of the Security</b> </font> 
                                                    <td width="10%" align="center"><b><font
																			color="#FFFFFF">Demand 
                                                      Particu lars DP Id &amp; Client 
                                                      Id</font></b></td>
                                                    <td width="15%" align="center"><b><font
																			color="#FFFFFF">Standing 
                                                      in the name of</font></b></td>
                                                    <td width="15%" align="center"><b><font
																			color="#FFFFFF">Reg. 
                                                      Folio No</font></b></td>
                                                    <td width="10%" align="center"><b><font
																			color="#FFFFFF">Face 
                                                      Value</font></b></td>
                                                    <td width="10%" align="center"><b><font
																			color="#FFFFFF">Quantity</font></b></td>
                                                    <td width="10%" align="center"><b><font
																			color="#FFFFFF">Mkt. 
                                                      / Maturity Value/ NAV</font></b></td>
                                                    <td width="10%" align="center"><b><font
																			color="#FFFFFF">Total 
                                                      Value</font></b></td>
                                                  </tr>
                                                </table>
                                              </td>
                                            </tr>
                                            <tr> 
                                              <td> 
                                                <div class="cellcontainer"> 
                                                  
                                        <table width="98%" border="0" cellspacing="1"
																	cellpadding="2" bordercolorlight="#DEDACF"
																	bordercolordark="#FFFFFB">
                                          <%v = (ArrayList) hshValues.get("vecData");
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					inside="Y";
					g1 = (ArrayList) v.get(l);

					%>
                                          
                              <%//if (Helper.correctNull((String) hshValues.get("strid")).equalsIgnoreCase(Helper.correctNull((String) g1.get(1))))%>
										<tr valign="top" bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center"> 
                                              <input type="radio" style="border:none" name="radiobutton"
                                              value=""
                                               onclick="javascript:selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(5))))%>','<%=Helper.correctNull((String)g1.get(6))%>','<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String)g1.get(7))))%>','<%=Helper.correctNull((String)g1.get(8))%>')">
                                               </td> 
                                             <td width="15%" align="left"><%=Helper.correctNull((String) g1
											.get(1))%></td>
                                            <td width="10%" align="left">&nbsp;<%=Helper.correctNull((String) g1
											.get(3))%></td>
                                            <td width="15%" align="right">&nbsp; 
                                              <%=Helper.correctNull((String) g1
											.get(2))%></td>
                                            <td width="15%" align="left">&nbsp; 
                                              <%=Helper.correctNull((String) g1
											.get(4))%></td>
                                            <td width="10%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1
											.get(5))))%></td>
                                            <td width="10%" align="left">&nbsp; 
                                              <%=Helper.correctNull((String) g1
											.get(6))%></td>
                                            <td width="10%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1
											.get(7))))%></td>
                                            <td width="10%" align="left">&nbsp;<%=Helper.formatDoubleValue(Double.parseDouble(Helper.correctDouble((String) g1
											.get(8))))%></td>
                                          </tr>
                                          <%}
			} %>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
										 <% if(inside.equalsIgnoreCase("N")){%>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                          <tr bgcolor="#EEEAE3"> 
                                            <td width="5%" align="center">&nbsp;</td>
                                            <td width="15%" align="center">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="15%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                            <td width="10%" align="left">&nbsp;</td>
                                          </tr>
                                         <%}%> 
                                        </table>
                                                </div>
                                              </td>
                                            </tr>
                                          </table>
                                        </td>
                                      </tr>
                                    </table>
                                  </td>
                                </tr>
                              </table>
                        </table>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
<lapschoice:hiddentag/>
<input type="hidden" name="hid_sno" value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
<input type="hidden" name="txtTOTAL" value="<%=Helper.correctNull((String)hshValues.get("str_dtotal"))%>">
<input type="hidden" name="radLoan" value="Y">
<%-- 
<INPUT TYPE="hidden" name="hidDemoId" value="<%=(String)Helper.correctNull(request.getParameter("hidDemoId"))%>">
--%>
</form>
</body>
</html>
