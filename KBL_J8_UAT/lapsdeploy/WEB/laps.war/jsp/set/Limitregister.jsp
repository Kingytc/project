 <%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
 
<html>
<head>
<title>Proposed Asset</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/per/perpropertydetails.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var path      ="<%=ApplicationParams.getAppUrl()%>";
var strAppUrl="<%=ApplicationParams.getAppUrl()%>";
var strAction="<%=request.getParameter("hidAction")%>";
 
  function onloading()
  {
  
  }
 
  
 
 function doNew()
 {
 
 }
 function doEdit() 
 {
 
 }
 
 function doSave()
 {
 
 }
 
 function doCancel()
 {
 
 }
 
 function doDelete()
 {
 
 }
 
 function callClose()
 {
 
 }
 
 function dohlp()
 {
 
 }
 
 
 

  
 

</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
<style>
Div.cellcontainer
{
	height:100px;
	overflow:auto;
}
</style>
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0"
	marginwidth="0" marginheight="0" onload="onloading()">
 
<form method="post">
<table width="100%" border="0" cellpadding="0" cellspacing="0"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td><jsp:include page="../share/Applurllinkper.jsp" flush="true">
			<jsp:param name="pageid" value="1" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td valign="top" colspan=5><font
			face="Times New Roman" size="3"><b><i> </i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr> 
      <td height="17"><lapschoice:application /></td>
	</tr>
</table>
 

<table width="100%" border="0" cellspacing="0" cellpadding="5"
	bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3"
			bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
			 
					<tr>
						<td>
						<table border="0" cellspacing="0" cellpadding="3" width="100%"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3"
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
														
                                      <table width="100%" border="0" cellspacing="0"
															cellpadding="2">
                                        <tr class="blackfont"> 
                                          <td width="9%" height="60" nowrap><font size="1" face="MS Sans Serif">Applicant 
                                            Type</font> </td>
                                          <td width="37%" height="60" nowrap> 
                                            <select name="selApplicant">
											<option value="R">Retail</option>
											<option value="A">Agriculture</option>
                                            </select>
                                          </td>
                                          <td width="9%" height="60" nowrap><font size="1" face="MS Sans Serif">Applicant 
                                            Name </font></td>
                                          <td width="44%" height="60" nowrap> 
                                            <input type="text" name="txt_appname">
                                          </td>
                                          <td width="1%" rowspan="4"><font size="1" face="MS Sans Serif"> 
                                            </font> <font size="1" face="MS Sans Serif"> 
                                            </font> </td>
                                        </tr>
										 <tr> 
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Date 
                                            </font></td>
                                          <td bgcolor="" width="37%" nowrap> 
                                            <input type="text" name="txt_nature">
                                          </td>
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Sanctioned 
                                            By </font></td>
                                          <td bgcolor="" nowrap width="44%"> 
                                            <input type="text" name="txt_amount">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Nature 
                                            of Limit</font></td>
                                          <td bgcolor="" width="37%" nowrap> 
                                            <input type="text" name="txt_nature">
                                          </td>
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Amount 
                                            of Limit</font></td>
                                          <td bgcolor="" nowrap width="44%"> 
                                            <input type="text" name="txt_amount">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Margin 
                                            </font></td>
                                          <td bgcolor="" width="37%" nowrap><b> 
                                            <input type="text" name="txt_margin">
                                            </b></td>
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Rate 
                                            of Interest</font></td>
                                          <td bgcolor="" nowrap width="44%"> 
                                            <input type="text" name="txt_rate">
                                          </td>
                                        </tr>
                                        <tr> 
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Security</font></td>
                                          <td bgcolor="" width="37%" nowrap><b> 
                                            <input type="text" name="txt_security">
                                            </b></td>
                                          <td bgcolor="" width="9%" nowrap><font size="1" face="MS Sans Serif">Remarks</font></td>
                                          <td bgcolor="" nowrap width="44%"> 
                                            <input type="text" name="txt_remarks">
                                          </td>
                                        </tr>
                                      </table>
														</td>
													</tr>
													<tr>
														<td><br>
														<table width="12%" border="0" align="center"
															cellpadding="0" cellspacing="0"
															bordercolorlight="#FFFFFB" bordercolordark="#DEDACF"
															class="blackfont">
															<tr>
																<td>

																<table width="43%" border="0" cellspacing="0"
																	cellpadding="2">
																	<tr valign="top">
																		<td><input type="button" name="cmdnew"
																			value="New"
																			class="buttonStyle"
																			onClick="doNew()"></td>
																		<td><input type="button" name="cmdedit"
																			value="Edit"
																			class="buttonStyle"
																			onClick="doEdit()"></td>
																		<td><input type="button" name="cmdapply"
																			value="Save"
																			class="buttonStyle"
																			onClick="doSave()" disabled></td>
																		<td><input type="button" name="cmdcancel"
																			value="Cancel"
																			class="buttonStyle"
																			onClick="doCancel()" disabled></td>
																		<td><input type="button" name="cmddel"
																			value="Delete"
																			class="buttonStyle"
																			onClick="doDelete()" disabled></td>
																		<td><input type="button" name="cmdhelp2"
																			value="Help"
																			class="buttonHelp"
																			onClick="dohlp()"></td>
																		<td>
																		<div align="center"><input type="button"
																			name="cmdclose" value="Close" onClick="callClose()"
																			class="buttonClose">
																		</div>
																		</td>
																	</tr>
																</table>
																</td>
															</tr>
														</table>
														<br>
														</td>
													</tr>
													<tr>
														
                                    <td valign="top"> 
                                      <table width="100%" border="0" cellspacing="0"
															cellpadding="0" bordercolorlight="#EBEBF8"
															bordercolordark="#82829F">
															<tr>
																<td>

																
                                                  
                                            <table width="98.3%" border="0" cellspacing="1"
																	cellpadding="2" bordercolorlight="#FFFFFF"
																	bordercolordark="#DEDACF">
                                              <tr bgcolor="#71694F"> 
                                                <!-- <td width="4%" align="center"></td> -->
                                                <td width="3%" align="center"><font color="#FFFFFF" face="MS Sans Serif" size="1"></font></td>
                                                <td width="11%" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b> 
                                                  Date </b> </font> 
                                                <td width="12%" align="center"><b><font face="MS Sans Serif" size="1" color="#FFFFFF"> 
                                                  Sanctioned By </font></b></td>
                                                <td width="11%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Nature 
                                                  of Limit</font></b></td>
                                                <td width="11%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Amount 
                                                  of Limit</font></b></td>
                                                <td width="11%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Margin 
                                                  </font></b></td>
                                                <td width="11%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Rate 
                                                  of Interest</font></b></td>
                                                <td width="15%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Security</font></b></td>
                                                <td width="15%" align="center"><b><font color="#FFFFFF" face="MS Sans Serif" size="1">Remarks</font></b></td>
                                              </tr>
                                            </table>
																</td>
															</tr>
															<tr>
																
                                          <td valign="top"> 
                                            <div class="cellcontainer">
																
                                              <table width="100%" border="0" cellspacing="1"
																	cellpadding="2" bordercolorlight="#FFFFFB"
																	bordercolordark="#DEDACF">
                                                <tr> 
                                                  <td width="3%" align="center"> 
                                                    <input type="radio" style="border:none"
																			name="radiobutton" value="radiobutton">
                                                  </td>
                                                  <td width="11%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="12%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="11%" align="right">&nbsp; 
                                                  </td>
                                                  <td width="11%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="11%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="11%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="15%" align="left">&nbsp; 
                                                  </td>
                                                  <td width="15%" align="left">&nbsp; 
                                                  </td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr> 
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
                                                <tr>
                                                  <td align="center">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="right">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                  <td align="left">&nbsp;</td>
                                                </tr>
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
										</td>
									</tr>
								</table>
						</table>
						</td>
					</tr>
					<tr>
						<td>
						<table border="0" cellspacing="0" cellpadding="0"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB"
							align="center">
							<tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369">
								<td></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
	 
	 
 
<BR>
</form>

</body>
</html>
