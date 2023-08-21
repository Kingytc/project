<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<lapschoice:handleerror/>
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}
ArrayList g1 =  new ArrayList();
%>
<html>
<head>
<title>Designation Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<STYLE>
DIV.cellcontainer 
{	
  width: 100%; height:290;
  overflow: auto;
}
</STYLE>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>

<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/designationmaster.js"> </script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";

</SCRIPT>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0"
	onload="callonLoad()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()" onMouseout="lowlightie5()" onClick="jumptoie5()"> 
	<div class="menuitems" url="">
    	<script language="JavaScript1.2">
			if (document.all && window.print)
				{
				ie5menu.className = menuskin;
				document.oncontextmenu = showmenuie5;
				document.body.onclick = hidemenuie5;
				}
		</script>
	</div>
</div>
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post" action="">
<div align="center">
<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369"
	bordercolordark="#FFFFFB">
	<tr>
		<td><font
			face="Times New Roman" size="3"><b><i>Home -&gt; Master -&gt; Designation Master</i></b></font></td>
	</tr>
</table>
<table width="100%" border="0" cellpadding="0" cellspacing="0"
		class="outertable border1">
		<tr>
			<td>
				<jsp:include page="../set/mastertab.jsp" flush="true">
				<jsp:param name="tabid" value="6" />
				</jsp:include>
			</td>
		</tr>
	</table>
<table width="100%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable border1" align="center" >
	 <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
          <tr> 
            <td valign="top"> 
              <table border="0" cellspacing="0" cellpadding="0" width="100%" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                            <tr> 
                              <td> 
                                <table width="45%" border="0" cellspacing="0" cellpadding="1" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
                                  <tr> 
                                    <td width="25%" nowrap> <font face="MS Sans Serif"
											size="2" > Designation</font></td>
                                    <td width="75%"> 
                                      <input type="text" name="txt_datavalues" onKeyPress="notAllowSplChar1(this)" size="50" maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("DESIGN_NAME"))%>">
                                     </td>
                                     <td id="t1"> <b><span onClick="callsupnam()" style="cursor:hand"><font size="2" face="MS Sans Serif">?</font></span></b>
                                     
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2" nowrap> <br>
                                      <table width="12%" border="0" cellspacing="0" cellpadding="0" align="center"
										>
                                        <tr> 
                                          <td> 
                                            <table width="43%" border="0" cellspacing="0" cellpadding="2">
                                              <tr valign="top"> 
                                                <td height="0"> 
                                                  <input type="button" name="cmdNew" value="New"
														class="buttonStyle"
														onClick="callNew()">
                                                </td>
                                                <td height="0"> 
                                                  <input type="button" name="cmdEdit" value="Edit"
														class="buttonStyle"
														onClick="callEdit()">
                                                </td>
                                                <td height="0"> 
                                                  <input type="button" name="cmdApply" value="Save"
														class="buttonStyle"
														onClick="doSave()">
                                                </td>
                                                <td height="0"> 
                                                  <input type="button" name="cmdCancel" value="Cancel"
														class="buttonStyle"
														onClick="callCancel()">
                                                </td>
                                                <td height="0"> 
                                                  <input type="button" name="cmdHelp" value="Help"
														class="buttonHelp"
														onClick="doHelp('designationmaster.htm')">
                                                </td>
                                                <td height="0"> 
                                                  <div align="center"> 
                                                    <input type="button" name="cmdClose"
														value="Close" onClick="callClose()"
														class="buttonClose">
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
                            <tr> 
                              <td>&nbsp;</td>
                            </tr>
                            <tr> 
                            	<td valign="top"> 
                                	<table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                  		<tr> 
                                    		<td valign="top"> 
                                      			<table width="98.3%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                        			<tr bgcolor="#71694F"> 
                                          				<td width="5%" >&nbsp;</td>
                                          				<td width="10%"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>S No.</b></font></td>
                                          				<td width="85%"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>Designation</b></font></td>
                                        			</tr>
                                     	 		</table>
	                                  		</td>
                                  		</tr>
                                  		<tr> 
                                    		<td valign="top" align="center"> 
                                     	 	<DIV class="cellcontainer"> 
                                        		<table width="100%" border="0" cellspacing="1" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                      <% 
						 				ArrayList	v = (ArrayList) hshValues.get("vecRow");
										String inside="N";
										if(v!=null)
										{					
											int vecsize =v.size();
											for(int l=0;l<vecsize;l++)
											{	
												inside="Y";
												g1 = (ArrayList)v.get(l);
												%>
                                          <tr> 
                                            <td width="5%"> 
                                              <input type="radio" <%if(Helper.correctNull((String)hshValues.get("DESIGN_CODE")).equalsIgnoreCase(Helper.correctNull((String)g1.get(0)))){out.println("Checked");}%> name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>')">
                                            </td>
                                            <td width="10%"><%=Helper.correctNull((String)g1.get(0))%></td>
                                            <td width="85%"><%=Helper.correctNull((String)g1.get(1))%></td>
                                          </tr>
                                          <%
					                       }
										}
										 %>
                                          <tr>
                                            <td width="5%">&nbsp; </td>
                                            <td width="10%">&nbsp; </td>
                                            <td width="85%">&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <%
                                          if(inside.equalsIgnoreCase("N")){
                                          %>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                            <td>&nbsp;</td>
                                          </tr>
                                          <%
                                          }
                                          %>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<input type="hidden" name="hidBeanMethod">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidSourceUrl">
<input type="hidden" name="hidAction">
<input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("DESIGN_CODE"))%>">
<input type="hidden" name="hidstate" value="2">
<input type="hidden" name="hidstatenew" value="">
<input type="hidden" name="hidBeanGetMethod" value="getData">
<br> 
</form>
</body>
</html>
