<html>
<head>
<title>Small Scale Industries</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
<!--
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}

-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
.tabfont {  font-family: "MS Sans Serif"; font-size: 10px; color: #000000; text-decoration: none}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
</head><body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" >
<form name="fininc" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
       
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i>Small Scale Industies -&gt; Application 
              Form for Credit Facilities above Rs.10 Lakh</i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        <table width="80%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="20%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                1</a></font></b></font></b></div>
            </td>
            <td width="23%" height="20" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Tab 
                2 </font></b></font></div>
            </td>
            <td width="22%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                3 </a></font></b></font></div>
            </td>
            <td width="18%" height="20" bgcolor="#EEEAE3" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
              4 </a></font></b></font></td>
            <td width="17%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                5 </a></font></b></font></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="350">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr> 
                              <td width="35%"><font size="1" face="MS Sans Serif"><b>ECONOMIC 
                                FEASIBILITY </b></font></td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
						 <%
						 if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
						{
							vecCol =(ArrayList)vecRow.get(0);
						  %>
                                <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="74%"><font size="1" face="MS Sans Serif">Marketing 
                                      (mention saperately for each product)</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="74%"> 
                                      <textarea name="textfield2222" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="29%"><font size="1" face="MS Sans Serif">Whether 
                                      the product is reserved exclusively for 
                                      the SSI sector ? If so, please furnish Item 
                                      Code No.</font></td>
                                    <td width="23%"> 
                                      <input type="text" name="textfield222" size="25">
                                    </td>
                                    <td width="23%"><font size="1" face="MS Sans Serif">Name 
                                      of the Major customers</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="textfield2225" size="25">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="29%"><font size="1" face="MS Sans Serif">Region 
                                      / Area where the product is / will be sold</font></td>
                                    <td width="23%"> 
                                      <input type="text" name="textfield2223" size="25">
                                    </td>
                                    <td width="23%"><font size="1" face="MS Sans Serif">Extent 
                                      of competition &amp; No. of Units engaged 
                                      in similar line in the area</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="textfield2224" size="25">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td width="35%">
                                <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">How 
                                      does the unit meet / propose to meet the 
                                      competition ?</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%"> 
                                      <textarea name="textarea" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">In price and quality, how does the unit's product comapre with those of its competitors? </font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%">
                                      <textarea name="textarea2" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
								   <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">Is 
                                      the Unit selling direct to its cutomers? 
                                      If so, please furnish details like sales 
                                      force, showrooms depots etc.</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%">
                                      <textarea name="textarea3" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
							 </table>
							 <%
							 }
							 else
							 {
							 %>
								     <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="74%"><font size="1" face="MS Sans Serif">Marketing 
                                      (mention saperately for each product)</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="74%"> 
                                      <textarea name="textfield2222" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="29%"><font size="1" face="MS Sans Serif">Whether 
                                      the product is reserved exclusively for 
                                      the SSI sector ? If so, please furnish Item 
                                      Code No.</font></td>
                                    <td width="23%"> 
                                      <input type="text" name="textfield222" size="25">
                                    </td>
                                    <td width="23%"><font size="1" face="MS Sans Serif">Name 
                                      of the Major customers</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="textfield2225" size="25">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="29%"><font size="1" face="MS Sans Serif">Region 
                                      / Area where the product is / will be sold</font></td>
                                    <td width="23%"> 
                                      <input type="text" name="textfield2223" size="25">
                                    </td>
                                    <td width="23%"><font size="1" face="MS Sans Serif">Extent 
                                      of competition &amp; No. of Units engaged 
                                      in similar line in the area</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="textfield2224" size="25">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr>
                              <td width="35%">
                                <table width="100%" border="0" cellspacing="1" cellpadding="5">
                                  <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">How 
                                      does the unit meet / propose to meet the 
                                      competition ?</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%"> 
                                      <textarea name="textarea" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">In price and quality, how does the unit's product comapre with those of its competitors? </font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%">
                                      <textarea name="textarea2" cols="120" rows="4" wrap="VIRTUAL"></textarea>
                                    </td>
                                  </tr>
								   <tr> 
                                    <td width="21%"><font size="1" face="MS Sans Serif">Is 
                                      the Unit selling direct to its cutomers? 
                                      If so, please furnish details like sales 
                                      force, showrooms depots etc.</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="21%">
                                      <textarea name="textarea3" cols="120" rows="4" wrap="VIRTUAL"></textarea>
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
					 }
					%>
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

<br>
  <table border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr bordercolordark="#FFFFFB" bordercolorlight="#8F8369"> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" >
          <tr valign="top"> 
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" onClick="onEdit()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" onClick="doSave()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="14%"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel" onClick="onCancel()" style="background-color:#8F8369;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="15%"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="onClose()" style="background-color:#CC3300;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>

<input type="hidden" name="hidTabName" value="EconomicFeasibility">

<input type="hidden" name="hidDesc1" value="Occupation">
<input type="hidden" name="hidDesc2" value="DetailsOfMovableImmovableProperty">
<input type="hidden" name="hidDesc3" value="DetailsOfSimilarGuatantee">
<input type="hidden" name="hidDesc4" value="GovernmentEnquirtyOrProceedings">
<input type="hidden" name="hidDesc5" value="DetailsOfPendingLitigation">
<input type="hidden" name="hidDesc6" value="PromotersOrDirectorsInsolvent">


<input type="hidden" name="hidTotalDesc" value="6">
<input type="hidden" name="hidFieldPrefix" value="txt_occupationguarantor">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="Occupation^DetailsOfMovableImmovableProperty^DetailsOfSimilarGuatantee^GovernmentEnquirtyOrProceedings^DetailsOfPendingLitigation^PromotersOrDirectorsInsolvent">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">

</form>
</body>
</html>
