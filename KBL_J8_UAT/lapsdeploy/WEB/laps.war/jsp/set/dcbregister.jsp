<%@include file="../share/directives.jsp"%>
<%@ page import="java.text.*"%>
<%
NumberFormat nf = NumberFormat.getInstance();
nf.setMinimumFractionDigits(2);
nf.setMaximumFractionDigits(2);
nf.setGroupingUsed(false);
ArrayList vecRow= new ArrayList();
ArrayList vecCol= new ArrayList();
ArrayList vecElement= new ArrayList();
ArrayList vecregionname= new ArrayList();
vecElement=(ArrayList)hshValues.get("totalregion");
vecregionname=(ArrayList)hshValues.get("regionname");
String strlevel=Helper.correctNull((String)hshValues.get("levelcode"));
%>

<html>
<head>
<title>DCB Register</title>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";

function onloading()
{	  
    disableFields(true);
   	disableCommandButtons(false,true,true,false);
   	document.forms[0].hidAction.value ="";
    <%if(vecRow == null || vecRow.size()==0){%>
    	document.forms[0].cmdedit.disabled=true;
	<%}%>
}
 function doEdit()
 { 	
	disableFields(false);
	document.forms[0].hidAction.value ="update";
	disableCommandButtons(true,false,false,true);
	
 }
 function doSave()
 {
 		document.forms[0].hidBeanId.value="npa";		
		document.forms[0].hidSourceUrl.value="/action/dcbregister.jsp";
		document.forms[0].hidBeanMethod.value="updateDCBRegisterData";
		document.forms[0].hidBeanGetMethod.value="getDCBRegisterData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit();
 }
   
 function disableCommandButtons(cmdedit,cmdapply,cmdcancel,cmdclose)
 {  
	 
	  document.forms[0].cmdedit.disabled=cmdedit;	  
	  document.forms[0].cmdapply.disabled=cmdapply;
	  document.forms[0].cmdcancel.disabled=cmdcancel;
	  document.forms[0].cmdclose.disabled=cmdclose;
 }
 
function doClose()
{
	
 	if(ConfirmMsg(100))
 	{
		window.close();
	}
}
function printpreview()
{
			var code="<%=Helper.correctNull((String)hshValues.get("branchcode"))%>";
			var orgname="<%=Helper.correctNull((String)hshValues.get("orgname"))%>";
			var level="<%=strlevel%>";
			var purl = appUrl+"action/dcbregisterprint.jsp?hidBeanGetMethod=getDCBRegisterPrintData&hidBeanId=npa&hidcode="+code+"&hidorgname="+orgname+"&hidlevel="+level;
			prop = "scrollbars=yes,width=1000,height=550,statusbar=yes,menubar=yes";	
			xpos = (screen.width - 1000) / 2;
			ypos = (screen.height - 650) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			var title = "DCBPRINTREGISTER";
			window.open(purl,title,prop); 
}		
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css"> 
</head>
<body>
<form class="normal">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
    <tr> 
      <td align="center"><img src="<%=ApplicationParams.getAppUrl()%>img/bank_rep_logo.jpg"></td>
    </tr>
    <tr> 
      <td align="center"><strong>Karnataka Bank Ltd.</strong></td>
    </tr>
    <tr> 
      <td align="center"><%=Helper.correctNull((String)hshValues.get("branchname"))%></td>
    </tr>
    <tr> 
      <td align="center"><b>DCB Register Report</b></td>
    </tr>
    <tr> 
      <td align="center">&nbsp;</td>
    </tr>
  </table>
  <div id="top">
  <table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td> 
        <table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3"
					>
          <tr bgcolor="#71694F"> 
            <td align="center" width="2%"rowspan="2"><b>&nbsp;</b> </td>
            <td align="center" width="10%"rowspan="2"><b>Account No. / Ledger Folio No.</b> 
            </td>
            <td align="center" width="10%"rowspan="2"><b>Sector</b> </td>
            <td align="center" width="6%"rowspan="2"><b>Scheme</b> </td>
            <td align="center" colspan="3"><b>DEMAND</b> </td>
            <td align="center" colspan="2"><b>COLLECTION (RECOVERY)</b> 
            </td>
            <td align="center" colspan="4"><b>OVERDUE (BALANCE)</b> </td>
          </tr>
          <tr bgcolor="#71694F"> 
            
            <td align="center" width="8%"><b>Arrears</b> </td>
			<td align="center" width="8%"><b>Current</b> </td>
            <td align="center" width="8%"><b>Total</b> </td>
            <td align="center" width="8%"><b>Recovery</b> </td>
            <td align="center" width="8%"><b>Advance Collection</b> </td>
            <td align="center" width="8%"><b> < 1 year </b> </td>
            <td align="center" width="8%"><b>1 to 3 Years </b> </td>
            <td align="center" width="8%"><b>&gt; 3 Years </b> </td>
            <td align="center" width="8%"><b>Total</b> </td>
          </tr>
          <input type="hidden" name="hid_size" value="<%=vecRow.size()%>">
          <%
					  if(vecElement.size()>0 && vecElement!=null)
					   vecRow =(ArrayList)vecElement.get(0);
					  
					  if(vecRow!=null && strlevel.equalsIgnoreCase("A")){
			if (vecRow.size() > 0) {%>
          <% 	for (int i = 0; i < vecRow.size(); i++) {
			vecCol = (ArrayList) vecRow.get(i);
			
	
			%>
          <tr bgcolor="#EEEAE3" > 
            <td width="2%" valign="top">&nbsp; <%=i+1%> </td>
            <td width="8%" valign="top"><%=Helper.correctNull((String)vecCol.get(0))%>
            </td>
            <td width="12%" valign="top"><%=Helper.correctNull((String)vecCol.get(1))%>&nbsp;</td>
            <td width="6%" valign="top"><%=Helper.correctNull((String)vecCol.get(2))%>&nbsp;</td>
            
            <td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(4))%> 
            </td>
          	<td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(3))%> 
            </td>
            <td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(5))%></td>
            <td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(6))%> 
            </td>
            <td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(7))%> 
            </td>
            <td align="right" width="8%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(8))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(9))%> 
            </td>
            <td  align="right" width="6%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(10))%> 
            </td>
          
            <td  align="right" width="8%" valign="top">&nbsp; <%=Helper.correctNull((String)vecCol.get(11))%> </td>
          </tr>
          <%}
		  }
					  }else if(vecRow!=null && strlevel.equalsIgnoreCase("D")){
	 for(int j=0;j<vecElement.size();j++) {
		vecRow=(ArrayList)vecElement.get(j);
		%>
          <tr> 
            <td align="left" colspan="13"> <b>Branch Name: <%=vecregionname.get(j).toString()%> 
              </b> </td>
          </tr>
          <%
 	for (int i = 0; i < vecRow.size(); i++) {
	vecCol = (ArrayList) vecRow.get(i);
	

	%>
          <tr bgcolor="#EEEAE3" > 
            <td width="2%" valign="top">&nbsp; <%=i+1%> </td>
            <td width="10%" valign="top"><%=Helper.correctNull((String)vecCol.get(0))%>
            <td width="10%" valign="top"><%=Helper.correctNull((String)vecCol.get(1))%>&nbsp; 
            </td>
            <td width="6%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(3))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(4))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(5))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(6))%></td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(7))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(8))%> 
            </td>
            <td align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(9))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(10))%> 
            </td>
            <td  align="right" width="8%" valign="top">&nbsp;<%=Helper.correctNull((String)vecCol.get(11))%> 
            </td>
          </tr>
          <%}
	}
			}
			if(vecElement==null || vecElement.size()==0){

			    %>
          <tr>
            <td align="center" colspan="13">No 
              Data Found</td>
          </tr>
          <%} %>
        </table>
       </td>
       </tr>
      </table>
      </div>
  <br>
  <table class="outertable border1" width="8%" border="0" cellspacing="0" cellpadding="0"
			
			align="center">
    <tr> 
      <td> 
        <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
          <tr valign="top"> 
           
            <td width="45%"> 
                <input type="button" name="Button232253" value="Close" 
                class="buttonothers" onClick="window.close()">
            </td>
            <td width="55%"> 
                <input type="button" name="Button2322532" value="Print Preview" 
               class="buttonclose"
                onclick="printpreview()">
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <input type="hidden" name="hidAction">
  <input type="hidden" name="hidBeanId" value="">
  <input type="hidden" name="hidBeanMethod" value="">
  <input type="hidden" name="hidBeanGetMethod" value="">
  <input type="hidden" name="hidSourceUrl" value="">
  <input type="hidden" name="hidcode1">
  <input type="hidden" name="hidorg" value="<%=Helper.correctNull((String)hshValues.get("str_name"))%>">
</form>
</body>
</html>
