<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
  if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }
	ArrayList vecData = new ArrayList();
	ArrayList vecRow  = new ArrayList();
	int vecsize=0;
	if(hshValues.get("vecData") != null)
	{
		vecData = (ArrayList)hshValues.get("vecData");
		
		vecsize = vecData.size();
	}%>
<html>
<head>
<title>SSI - Past Performance</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/com/ssi_pastperf.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl		= "<%=ApplicationParams.getAppUrl()%>";
var appURL		= "<%=ApplicationParams.getAppUrl()%>";
var varappno		= "<%=request.getParameter("appno")%>";
var cntT	= "<%=Helper.correctNull((String)hshValues.get("cntT"))%>";
var cntN	= "<%=Helper.correctNull((String)hshValues.get("cntN"))%>";
var cntR	= "<%=Helper.correctNull((String)hshValues.get("cntR"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<BODY onload="onloading()" >
<form method="post" name="bordeposit" class="normal">
 <table width="100%" cellpadding="0" cellspacing="0" border="0" class="outertable">
 	<tr>
      <td align="right"><span class="mantatory">(All Values are Rupees)</span></td>
    </tr>
</table>
<iframe  height="0" width="0" id="ifrm" frameborder="0" style="border:0"></iframe> 
<span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
      <tr> 
        <td valign="top"> 
          <table width="100%" border="1" cellspacing="0" cellpadding="3" class="outertable">
          	<tr> 
          	 <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr>              
		            <td width="50%"><b>Past Performance(in the case of existing units):- </b>
		            </td>
		            <td>&nbsp;</td>            
                </tr>
                <tr>              
		            <td width="50%">If not banking with us, how were the unit's needs met in the past.
		            </td>
		            <td><textarea name="txt_UnitNeedsMet" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_UnitNeedsMet,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txt_UnitNeedsMet"))%></textarea> </td>           
                </tr>
                <tr>              
		            <td width="50%">Details of unit's borrowings from source other than the Bank (State Financial Corporation, NSIC borrowings from private financiers etc.) including overdues if any.
		            </td>
		            <td><textarea name="txt_DetailsOfBorrowing" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_DetailsOfBorrowing,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txt_DetailsOfBorrowing"))%></textarea> </td>            
                </tr>
                <tr>              
		            <td width="50%">Arrears in statutory payments, if any.
		            </td>
		            <td><textarea name="txt_ArrearsInPayments" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_ArrearsInPayments,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txt_ArrearsInPayments"))%></textarea> </td>            
                </tr>
                <tr>              
		            <td width="50%">Monthly turnover during the last year and recent months. 
		            </td>
		            <td><textarea name="txt_MonthlyTurnover" cols="50" wrap="VIRTUAL" rows="5" onKeyPress="textlimit(document.forms[0].txt_MonthlyTurnover,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("txt_MonthlyTurnover"))%></textarea> </td>            
                </tr>
              </table>
              </td> 
             </tr>           
            <tr>               
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr class="dataheader"> 
                  <td width="20%"  align="center"><b>Particulars<span class="mantatory">&nbsp;*</span></b></td>
                  <td align="center" width="20%" ><b>Last Year</b></td>
                  <td align="center" width="20%" ><b>Last but one Year</b></td>
                  <td width="30%" align="center" ><b>Last but II Year</b></td>
                </tr>
                <tr class="datagrid"> 
                  <td align="center"> 
                    <SELECT NAME="txt_part">
                      <option selected="selected" value="S">--Select--</option>
					  <option value="T">Turnover</option>
                      <option value="N">Net Profit</option>
                      <option value="R">Retained Profit</option>
                    </SELECT>
                  </td>
                  <td align="center"> 
                  	<input type="text" name="txt_year1"  maxlength="12" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right"/> 
                  </td>
                  <td align="center"> 
                  	<input type="text" name="txt_year2"  maxlength="12" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right"/> 
                  </td>
                  <td width="30%" align="center"> 
                  	<input type="text" name="txt_year3"  maxlength="12" size="15" onKeyPress="allowNegtiveNumber(this)" style="text-align:right"/> 
                  </td>
                </tr>
              </table>
              <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                <tr class="dataheader"> 
                  <td  align="center"><b>Particulars&nbsp; </b></td>
                  <td align="center"  ><b>&nbsp;&nbsp;&nbsp;Last Year</b></td>
                  <td align="center" ><b>Last but one Year</b></td>
                  <td align="center" ><b>Last but II Year</b></td>
                </tr>             
                  <%if(vecsize!=0)
						{
						for(int i=0;i<vecsize;i++)
						{
						ArrayList vecRec = new ArrayList();
						vecRec = (ArrayList)vecData.get(i);%>
                  <tr class="datagrid"> 
                    <td width="20%" align="center" > <a href= "javascript:placevalue('<%=Helper.correctNull((String)vecRec.get(0))%>','<%=Helper.correctNull((String)vecRec.get(1))%>','<%=Helper.correctNull((String)vecRec.get(2))%>','<%=Helper.correctNull((String)vecRec.get(3))%>','<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(4)))%>','<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(5)))%>','<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(6)))%>')" class="blackfont"> 
                      &nbsp;<%=Helper.correctNull((String)vecRec.get(2))%></a></td>
                    <td width="20%" align="right" >  
                      <%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(4)))%>&nbsp;</td>
                    <td width="20%" align="right" > &nbsp;<%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(5)))%>&nbsp;</td>
                    <td width="25%" align="right" > &nbsp; 
                      <%=Helper.formatDoubleValue(Double.parseDouble((String)vecRec.get(6)))%>&nbsp;</td>
                  </tr>
                  <%}}%>
                </table>            
			</td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
    <br>
  <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <br>
  <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidappno" value = "<%=request.getParameter("appno")%>">
<input type="hidden" name="seqno" >
</form>
</body>
</html>