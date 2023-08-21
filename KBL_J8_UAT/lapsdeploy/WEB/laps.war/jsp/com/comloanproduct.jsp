<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<jsp:useBean id="strGroupRights" class="java.lang.String" scope="session" />

<%
   if(objValues instanceof java.util.HashMap)
   {
	   hshValues=(java.util.HashMap)objValues;
   }
   String strUsrClass=Helper.correctNull((String)session.getAttribute("strUserClass"));
%>

<laps:handleerror />

<html>
<head>
<title>Commercial-Applicant</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/com/comloanproduct.js">
</script>

<script>
  var varhidpge ="<%=request.getParameter("hidpge")%>"; // add
  var varhidRen ="<%=request.getParameter("hidRen")%>"; // add
  var appUrl="<%=ApplicationParams.getAppUrl()%>";
  var varhidAction ="<%=request.getParameter("hidAction")%>";
  var appno="<%=Helper.correctNull((String)hshValues.get("app_no"))%>";
  var prdcode="<%=Helper.correctNull((String)hshValues.get("app_prdcode"))%>";
  var modintrate="<%=Helper.correctNull((String)hshValues.get("loan_modintrate"))%>";
  var terms="<%=Helper.correctNull((String)hshValues.get("loan_terms"))%>";
  var amtreqd="<%=Helper.correctNull((String)hshValues.get("loan_amtreqd"))%>";
  var prdcost="<%=Helper.correctNull((String)hshValues.get("loan_costloanprd"))%>";
  var amtrecmd="<%=Helper.correctNull((String)hshValues.get("loan_recmdamt"))%>";
  var downpay="<%=Helper.correctNull((String)hshValues.get("loan_downpay"))%>";
  var appamt = "<%=Helper.correctNull((String)hshValues.get("approveamt"))%>";
  var prddesc="<%=Helper.correctNull((String)hshValues.get("productdesc"))%>";
  var prdlvr="<%=Helper.correctNull((String)hshValues.get("prd_lvr"))%>";
  var prdtotint="<%=Helper.correctNull((String)hshValues.get("prd_totalint"))%>";
  var prdterm="<%=Helper.correctNull((String)hshValues.get("prd_term"))%>";
  var finstd="<%=Helper.correctNull((String)hshValues.get("demo_finstandard"))%>";
  var indcode="<%=Helper.correctNull((String)hshValues.get("demo_industrycode"))%>";
  var rating="<%=Helper.correctNull((String)hshValues.get("demo_indrating"))%>";
  var prdtype="<%=Helper.correctNull((String)hshValues.get("prd_type"))%>";
  var compid="<%=Helper.correctNull((String)hshValues.get("demo_comappid"))%>";
  var maxclass = "<%=Helper.correctNull((String)hshValues.get("prd_class"))%>";

  var editflag=1;
  var editlockflag="<%=hshValues.get("editlock")%>";
 
  function placeValues()
  {
	  if(varhidAction == 'insert')
	  {
		document.forms[0].appno.value =appno;
		document.forms[0].appname.value="<%=request.getParameter("demo_companyname")%>";
		document.forms[0].appstatus.value="Open/Pending";
		document.forms[0].prd_type.value="<%=request.getParameter("prd_type")%>";
		document.forms[0].app_prdcode.value="<%=request.getParameter("app_prdcode")%>";
		compid="<%=request.getParameter("comapp_id")%>";
	  }

	  if(varhidpge == 'newpge' || varhidRen == 'renewal') //// add
	  {
		document.forms[0].hidpges.value="newpge";
		document.forms[0].hidprinDtls.value = "<%=Helper.correctNull(request.getParameter("hidprinDtls"))%>";
		document.forms[0].hidcollDtls.value = "<%=Helper.correctNull(request.getParameter("hidcollDtls"))%>";
		document.forms[0].hidfinDtls.value = "<%=Helper.correctNull(request.getParameter("hidfinDtls"))%>";
        document.forms[0].hidapps.value=document.forms[0].appno.value;
		document.forms[0].appno.value ="new";
		document.forms[0].appstatus.value="Open/Pending";
	  }
	  document.forms[0].app_prdcode.value=prdcode;
	  document.forms[0].loan_modintrate.value=modintrate;
	  document.forms[0].loan_terms.value=terms;
	  document.forms[0].loan_amtreqd.value=amtreqd;
	  document.forms[0].loan_costloanprd.value=prdcost;
	  document.forms[0].loan_recmdamt.value=amtrecmd;
	  document.forms[0].loan_downpay.value=roundVal(downpay);
	  document.forms[0].approveamt.value=appamt;
	  document.forms[0].productdesc.value=prddesc;
	  document.forms[0].prd_lvr.value=prdlvr;
	  document.forms[0].prd_totalint.value=prdtotint;
	  document.forms[0].demo_companyname.value=document.forms[0].appname.value;
	  document.forms[0].comapp_id.value=compid;
	  if(finstd.toUpperCase()=="N")
	  {
		  document.forms[0].demo_finstandard[0].checked=true;
		  if(rating.toUpperCase()=="E")
		  {
			  document.forms[0].demo_indrating[0].checked=true;
		  }
		  else if(rating.toUpperCase()=="A")
		  {
			  document.forms[0].demo_indrating[1].checked=true;
		  }
		  else
		  {
			  document.forms[0].demo_indrating[2].checked=true;
		  }
		  document.forms[0].demo_industrycode.value=indcode;
	  }
	  else if(finstd.toUpperCase()=="P")
	  {
		  document.forms[0].demo_finstandard[1].checked=true;
	  }
	  else
	  {
		  document.forms[0].demo_finstandard.checked=true;
	  }
	  
	  if(prdtype.toUpperCase()=="CW")
		  document.forms[0].prd_type.value="Working Captial";
	  else if(prdtype.toUpperCase()=="CT")
		  document.forms[0].prd_type.value="Term Loan";
	  
	  if(document.forms[0].cmdedit.disabled)
		  editflag=0;
	 doAfterEdit();
	  
  }

  function doAfterEdit()
  {
	  if(varhidAction=="insert")
	  {
		   disableFields(true);
		   disableCommandButtons("load");
		   return;
	  }

	
	 if("<%=request.getParameter("appno")%>" != "new")
	 {
	      var editcheck="<%=request.getParameter("hideditflag")%>";
		  if(editcheck=="yes")
		  {
			  if(editlockflag=="y")
			  {
				  disableCommandButtons("edit");
			  }
			  else
			  {
				  disableFields(true);
				  ShowAlert(128);
				  disableCommandButtons("load");
			  }
		  }
		  else
		  {
			  disableFields(true);
			  disableCommandButtons("load");
		  }
	  }
	  else
	  {
			disableCommandButtons("edit");
	  }
	   document.forms[0].prd_totalint.readOnly = true;
  
 
  if(parseFloat("<%=strUsrClass%>")<=maxclass)
  {
  document.forms[0].loan_modintrate.readOnly = false;
  }
  else
  {
	  document.forms[0].loan_modintrate.readOnly = true;
  }
  document.forms[0].prd_type.readOnly = true;
  document.forms[0].prd_lvr.readOnly = true;
  document.forms[0].actlvr.readOnly = true;
  document.forms[0].loan_recmdamt.readOnly = true;
  document.forms[0].loan_downpay.readOnly = true;
  document.forms[0].txtmps.readOnly = true;
 
 enableStds();
 if(document.forms[0].cmdapply.disabled == false)
	{
		document.forms[0].cmdaudit.disabled = true;
	}
 }




  

  

var strvalue="comapp.htm";
</script>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 150;
  overflow: auto;
}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #333399; border-style: groove}
a:hover {  color: #FF3300}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000"  link="#000000" vlink="#330000" alink="#330000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="placeValues();loadDatas();changeApproveAmt();">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post">
  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" align="center" bordercolorlight="#EBEBF8" bordercolordark="#82829F" id="unlinktable">
          <tr> 
            <jsp:include page="../share/ApplURLLinks.jsp" flush="true"> 
            <jsp:param name="pageid" value="1" />
            </jsp:include>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="bottom">&nbsp;</td>
    </tr>
    <tr> 
      <td valign="bottom"> <laps:application  /> </td>
    </tr>
    <tr> 
      <td width="29%" valign="bottom"> 
        <table width="40%" border="0" cellspacing="3" cellpadding="3" align="left">
          <tr align="center"> 
            <td width="36%" bgcolor="#71694F"><b>Loan 
              Product</b></td>
            <td width="34%" bgcolor="#EEEAE3"><a href="javascript:callApplicantTab('company')" class="blackfont"><b>Company</b></a></td>
            <td width="30%" bgcolor="#EEEAE3"><a href="javascript:callApplicantTab('proposal')" class="blackfont"><b>Proposal</b></a></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" height="380" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" align="center">
    <tr> 
      <td valign="top"> 
        <div align="left"></div>
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <table width="100%" border="1" cellspacing="0" cellpadding="5" height="100%" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                <tr> 
                  <td valign="top"> 
                    <div align="center"> 
                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                        <tr> 
                          <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="2">
                              <tr> 
                                <td width="18%">Name 
                                  of Business 
                                </td>
                                <td width="6%">&nbsp;</td>
                                <td colspan="2"> 
                                  <input type="text" name="demo_companyname" size="30" maxlength="50"  style= text-align:left;border-style=groove readonly>
                                  <a href="#" onClick="javascript:callApplicanthelp()" class="blackfont"><b>?</b></a> 
                                </td>
                                <td width="15%">Loan 
                                  Type</td>
                                <td width="29%"> 
                                  <input type="text" name="prd_type" size="25" maxlength="50"  style= text-align:left;border-style=groove>
                                </td>
                              </tr>
                              <tr> 
                                <td colspan="6"><b>Define 
                                  Loan Product</b></td>
                              </tr>
                              <tr> 
                                <td width="25%">Product</td>
                                <td width="6%">&nbsp;</td>
                                <td colspan="4"> 
                                  <input type="text" name="productdesc" size="60" readonly>
                                  <a href="#" onClick="javascript:callPrdhelp()" class="blackfont"><b>?</b></a> 
                                  </td>
                              </tr>
                              <tr> 
                                <td width="25%">Term 
                                  Requested (Months) </td>
                                <td width="6%"> 
                                  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
                                  </td>
                                <td> 
                                  <input type="text" name="loan_terms" size="5" class="cellContainer" readOnly  style= text-align:left;border-style=groove>
                                  </td>
                                <td width="25%">&nbsp;</td>
                                <td width="5%">&nbsp;</td>
                                <td> </td>
                              </tr>
                              <tr> 
                                <td width="25%">Interest 
                                  Rate Defined %</td>
                                <td width="6%">&nbsp;</td>
                                <td width="18%"> 
                                  <input type="text" name="prd_totalint" size="6"style= text-align:right;border-style=groove>
                                  </td>
                                <td width="25%">Amount 
                                  Requested</td>
                                <td width="5%"> 
                                  <div align="right"><%=ApplicationParams.getCurrency()%> 
                                     </div>
                                </td>
                                <td width="29%"> 
                                  <input type="text" name="loan_amtreqd" size="15" style= text-align:right;border-style=groove  maxlength="12" onBlur="roundtxt(this);callRecmdAmount()" onKeyPress="allowNumber(this)">
                                   </td>
                              </tr>
                              <tr> 
                                <td width="25%">Interest 
                                  Rate Modified %</td>
                                <td width="6%">&nbsp;</td>
                                <td width="18%"> 
                                  <input type="text" name="loan_modintrate" size="6"style= text-align:right;border-style=groove   maxlength="5" onBlur="roundtxt(this);checkPercentage(this)" onKeyPress="allowNumber(this)">
                                  <a href="#" onClick="javascript:callInthelp()" class="blackfont"><b>?</b></a> 
                                  </td>
                                <td width="25%">Cost 
                                  of Loan Product</td>
                                <td width="5%"> 
                                  <div align="right"><%=ApplicationParams.getCurrency()%></div>
                                </td>
                                <td width="29%"> 
                                  <input type="text" name="loan_costloanprd" size="15" maxlength="12" style="text-align:right" onBlur="callRecmdAmount();roundtxt(this)" onKeyPress="allowNumber(this)">
                                  </td>
                              </tr>
                              <tr> 
                                <td width="25%">Loan 
                                  to Value Ratio&nbsp;%</td>
                                <td width="6%"></td>
                                <td width="18%"> 
                                  <input type="text" name="prd_lvr" size="6" class="cellContainer" maxlength="2"  style= text-align:right;border-style=groove>
                                  </td>
                                <td width="25%">Actual 
                                  Loan to Value Ratio %</td>
                                <td width="5%"></td>
                                <td width="29%"> 
                                  <input type="text" name="actlvr" size="6" class="cellContainer" maxlength="2"  style= text-align:right;border-style=groove>
                                  </td>
                              </tr>
                              <tr> 
                                <td width="25%">Recommended 
                                  Loan Amount &nbsp;</td>
                                <td width="6%"><%=ApplicationParams.getCurrency()%></td>
                                <td width="18%"> 
                                  <input type="text" name="loan_recmdamt" size="15" style= text-align:right;border-style=groove maxlength="12">
                                  </td>
                                <td width="25%">Actual 
                                  Margin Amount </td>
                                <td width="5%"> 
                                  <div align="right"><%=ApplicationParams.getCurrency()%></div>
                                </td>
                                <td width="29%"> 
                                  <input type="text" name="loan_downpay" size="15" maxlength="12"  style= text-align:right;border-style=groove >
                                  </td>
                              </tr>
                              <tr> 
                                <td width="18%">Approved 
                                  Amount </td>
                                <td width="6%"><%=ApplicationParams.getCurrency()%></td>
                                <td width="18%"> 
                                  <input type="text" name="approveamt" size="15" style= text-align:right;border-style=groove  maxlength="12" onBlur="checkAppAmt();changeApproveAmt()" onkeypress="allowDecimals(this.value)">
                                  </td>
                                <td width="25%">Monthly 
                                  Payment</td>
                                <td width="5%"> 
                                  <div align="right"><%=ApplicationParams.getCurrency()%></div>
                                </td>
                                <td width="29%"> 
                                  <input type="text" name="txtmps" size="15" style= text-align:right;border-style=groove value="0.00" readOnly>
                                  </td>
                              </tr>
                            </table>
                          </td>
                        </tr>
                      </table>
                      <br>
                      <br>
                      <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                        <tr> 
                          <td> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="3">
                              <tr> 
                                <td width="16%"><b>Financial 
                                  Standards </b></td>
                                <td width="45%"> 
                                  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="100%" >
                                    <tr> 
                                      <td valign="top"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                          <tr> 
                                            <td colspan="3"> 
                                              <input type="radio" name="demo_finstandard" value="N"  style="border-style:none" onClick="enableStds()">
                                              Industry 
                                              Defined </td>
                                            <td colspan="2">Industrial 
                                              Code</td>
                                            <td width="32%"> 
                                              <input type="text" name="demo_industrycode" maxlength="10" size="10" readonly>
                                              <a href="#" onclick="javascript:callIndcodehelp()"><b class="blackfont">?</b></a> 
                                            </td>
                                          </tr>
                                          <tr> 
                                            <td width="9%">  
                                              <input type="radio" name="demo_indrating" value="E"  style="font-weight:bold;border-style:none" disabled>
                                              </td>
                                            <td width="20%">Excellent</td>
                                            <td width="10%">  
                                              <input type="radio" name="demo_indrating" value="A"  style="font-weight:bold;border-style:none" disabled>
                                              </td>
                                            <td width="18%">Average</td>
                                            <td width="11%">  
                                              <input type="radio" name="demo_indrating" value="P" style="font-weight:bold;border-style:none" disabled>
                                              </td>
                                            <td width="32%">Poor</td>
                                          </tr>
                                        </table>
                                      </td>
                                    </tr>
                                  </table>
                                </td>
                                <td width="39%" valign="top"> 
                                  <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="100%" >
                                    <tr> 
                                      <td valign="top" height="61"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                          <tr> 
                                            <td colspan="4">&nbsp;</td>
                                          </tr>
                                          <tr> 
                                            <td width="9%">  
                                              <input type="radio" name="demo_finstandard" value="P" style="font-weight:bold;border-style:none" onClick="checkStandards();enableStds()">
                                              </td>
                                            <td>Product 
                                              Defined</td>
                                            <td width="9%">  
                                              <input type="radio" name="demo_finstandard" value="B" style="font-weight:bold;border-style:none"  checked  onClick="checkStandards();enableStds()">
                                              </td>
                                            <td width="43%">Bank 
                                              Defined</td>
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
                      Please 
                      fill all the fields and press &quot;Save&quot; button</div>
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
  <table width="0%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <% String strappno = request.getParameter("appno");
		
          if(strappno.equalsIgnoreCase("new"))
		  {
				strappno = "";
		  }
  		
		  %>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=''/> </td>
    </tr>
  </table>
  <input type="hidden" name="app_prdcode">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="prd_maxintclass">
  <input type="hidden" name="comapp_id">
  <input type="hidden" name="hidBeanId" value="commapplicant">
  <input type=hidden name="hidBeanMethod" value="updateData">
  <input type="hidden" name="hidSourceUrl" value="/action/comloanproduct.jsp" >
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="tabflag" value="loan">
  <input type="hidden" name="app_no">
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidClass" value="">
  <input type="hidden" name="hidapps">
  <input type ="hidden" name ="hidprinDtls">
  <input type ="hidden" name ="hidcollDtls">
  <input type ="hidden" name ="hidfinDtls">
  <input type="hidden" name="hidpges">
  <input type="hidden" name="hidEditMode">
</form>
</body>
</html>