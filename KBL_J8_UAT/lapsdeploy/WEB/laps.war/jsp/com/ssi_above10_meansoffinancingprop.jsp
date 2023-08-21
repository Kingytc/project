<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%
//System.out.println("--hshValues--"+hshValues);

ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";

int vecrowsize =0;

if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)

	for(int i=0;i<10;i++)
	{	vecCol =(ArrayList)vecRow.get(i);
		strgenid=strgenid+Helper.correctNull((String)vecCol.get(0))+",";
	}

	if(!strgenid.equals(""))
	{
	strgenid=strgenid.substring(0,(strgenid.length())-1);	
	}

}
else
{
	strgenid ="0";
}
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));

%>
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
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";

function callDisable(one)
{
	for( i=1;i<=9;i++)		
	{	

		document.forms[0].elements["txt_costofprojectraised1"+i].readOnly=one;
		document.forms[0].elements["txt_costofprojectraised2"+i].readOnly=one;	
	}		
		
}
function totalreadOnly()
{
	for( i=1;i<=10;i++)		
	{	
		document.forms[0].elements["txt_costofprojectraised3"+i].readOnly=true;
	}		
}

function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmdClose)
{

	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}


function onloading()
{	
	document.forms[0].hidGenID.value=genid;
	disableControls(false,true,true,false);
	callDisable(true);
	totalreadOnly();
}

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);

}

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);

}

function doSave()
{	
	disableControls(true,true,true,false);
	document.forms[0].hidBeanGetMethod.value="updateCostofProjectData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above10_meansoffinancing.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getCostofProject";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_meansoffinancing.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}


function onClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		document.forms[0].submit();
	}

}

</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" >

<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
     <tr> 
			<td valign="top" colSpan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/> 
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="5" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />
			
              </jsp:include>
            </td>
          </tr>
	</table>
        
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Small 
              Scale Industies </font></i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
    <span style="display:none"><laps:borrowertype /></span> <laps:application/> 

  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        <table width="70%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="20%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_above10_costofprojectincurredprop.jsp','getCostofProject','LAND^BULIDING^INDIGENOUSPLANTMC^IMPORTEDPLANTMC^TOOLSSPARES^TESTEQUIPMENTS^MISCFIXEDASSETS^INSTALLATIONCHRG^PRELIMEXPEMSES^PREOPTEXPENSES^BUILDINGCONTINGENCIES^PLANTMACHCONTINGENCIES^FIXEDASSETSCONTINGENCIES^MARGINWCREQ','CostOfProjectIncurred')"class="blackfont"> 
                Cost of Project </a></font></b></font></b></div>
            </td>
            <td width="30%" height="20" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF"> 
                Means of Financing </font></b></font></div>
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
                    <table width="100%" border="0" cellspacing="1" cellpadding="2">
                      <tr> 
                        <td colspan="6"><font size="1" face="MS Sans Serif">Cost 
                          of Project (Please furnish estimates of cost of project 
                          under the following heads. Indicate the basis for arriving 
                          at the cost of project).</font></td>
                      </tr>
                      <tr> 
                        <td colspan="6" align="center"><font size="1" face="MS Sans Serif"><b>(Rs. 
                          in 000's)</b></font></td>
                      </tr>
                      <tr bgcolor="#B5AD95"> 
                        <td align="center" height="26" width="6%"><font size="1" face="MS Sans Serif">S.No</font></td>
                        <td align="center" height="26" width="34%"><font size="1" face="MS Sans Serif">Particulars</font></td>
                        <td height="26" align="center" colspan="2"><font size="1" face="MS Sans Serif">Amount 
                          Already Raised</font></td>
                        <td width="25%" align="center" height="26"><font size="1" face="MS Sans Serif">Amount 
                          Proposed to be Raised</font></td>
                        <td width="16%" align="center" height="26"><font size="1" face="MS Sans Serif">Total</font></td>
                      </tr>
                      <%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">1.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Capital 
                          (Specify resources contribution capital)</font></td>
                        <td align="center" colspan="2"> 
                         <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(1);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">2.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Reserves</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(2);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">3.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Term 
                          Loans (give full particulars)</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                         <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(3);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">4.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Unsecured 
                          Loans and Deposits (indicate sources, rate of interest, 
                          repayment period etc.)</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(4);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">5.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Deferred 
                          Payment Arrangements including Supplier's Credit</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(5);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">6.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Subsidy 
                          Central Govt. State Govt.</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                         <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(6);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">7.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Seed 
                          Capital (indicate source)</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(7);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">8.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Internal 
                          Cash Accruals </font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(8);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">9.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Other 
                          Sources (Specify)</font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <% vecCol =(ArrayList)vecRow.get(9);%>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">10.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif"><b>Total</b> 
                          </font></td>
                        <td align="center" colspan="2"> 
                          <%=vecCol.get(2)%>
                        </td>
                        <td width="18%" align="center"> 
                          <%=vecCol.get(3)%>
                        </td>
                        <td width="17%" align="center"> 
                          <%=vecCol.get(4)%>
                        </td>
                      </tr>
                      <%
					  }
					  else
					  {
					 %>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">1.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Capital 
                          (Specify resources contributin capital)</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">2.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Reserves</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">3.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Term 
                          Loans (give full particulars)</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">4.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Unsecured 
                          Loans and Deposits (indicate sources, rate of interest, 
                          repayment period etc.)</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">5.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Deferred 
                          Payment Arrangements including Supplier's Credit</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">6.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Subsidy 
                          Central Govt. State Govt.</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">7.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Seed 
                          Capital (indicate source)</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">8.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Internal 
                          Cash Accruals </font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">9.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif">Other 
                          Sources (Specify)</font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <tr bgcolor="#EEEAE3"> 
                        <td align="center" width="6%"><font size="1" face="MS Sans Serif">10.</font></td>
                        <td width="34%"><font size="1" face="MS Sans Serif"><b>Total</b> 
                          </font></td>
                        <td align="center" colspan="2">&nbsp; </td>
                        <td width="18%" align="center">&nbsp; </td>
                        <td width="17%" align="center">&nbsp; </td>
                      </tr>
                      <%
					  }
					 %>
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



<input type="hidden" name="hidDesc1"  value="CAPITAL">
<input type="hidden" name="hidDesc2"  value="RESERVES">
<input type="hidden" name="hidDesc3"  value="TERMLOANS">
<input type="hidden" name="hidDesc4"  value="UNSECUREDLOANS">
<input type="hidden" name="hidDesc5"  value="DEFERREDPAYMENTS">
<input type="hidden" name="hidDesc6"  value="SUBSIDYGOVT">
<input type="hidden" name="hidDesc7"  value="SEEDCAPITAL">
<input type="hidden" name="hidDesc8"  value="INTERNALCASHACCRUALS">
<input type="hidden" name="hidDesc9"  value="OTHERSOURCES">


<input type="hidden" name="hidTotalDesc" value="9">
<input type="hidden" name="hidFieldPrefix" value="txt_costofprojectraised">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="CAPITAL^RESERVES^TERMLOANS^UNSECUREDLOANS^DEFERREDPAYMENTS^SUBSIDYGOVT^SEEDCAPITAL^INTERNALCASHACCRUALS^OTHERSOURCES">



<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hidOtherMethod" value="">

</form>
</body>
</html>
