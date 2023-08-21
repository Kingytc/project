<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%

ArrayList vecRow = new ArrayList();
ArrayList vecCol = new ArrayList();
String strgenid="";

int vecrowsize =0;

if(hshValues.size()>0 && hshValues != null)
{
	vecRow = (ArrayList)hshValues.get("vecRow");
	vecrowsize = vecRow.size();
	if(vecrowsize>0)

	for(int i=0;i<2;i++)
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
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callDisable(one)
{
	for( i=1;i<=3;i++)		
	{	

		document.forms[0].elements["txt_govtenquiry"+i].readOnly=one;	
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
	if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
			{
				disableControls(true,true,true,false);
			}
			else
			 {
				disableControls(false,true,true,false);
			 }
	callDisable(true);
}

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);

}


function doSave()
{	
	if(<%=vecrowsize%> >0)
	{
		document.forms[0].hidAction.value="update";
	}
	else
	{
		document.forms[0].hidAction.value="insert";
	}
	disableControls(true,true,true,false);
	document.forms[0].hidBeanGetMethod.value="updateGeneralData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above50lakhs_govtenquiry.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above50lakhs_govtenquiry.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}


function onClose()
{
	var cattype=document.forms[0].cattype.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/agrpage.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/corppge.jsp";
		 document.forms[0].submit();
	 }
		}

}

</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()" >
<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="11" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
	</table>
    
  <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
				-&gt;  Application-&gt; Govt. Enq.   
 
 </font></i></b></td>
          </tr>
        </table>
		
		<span style="display:none"><lapschoice:borrowertype /></span> 
<laps:application  />
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
          <!--<td width="20%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_above10_securityandguarantordetails.jsp','getGeneralDetails','WorkingCapitalAndTermLoan^CollateralFullDetails','SecurityGuarantorDetails')"class="blackfont"> Securities </a></font></b></font></b></div>
            </td>
            
		 <td width="21%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="javascript:callFunction('ssi_above10_occupationguaranteedetails.jsp','getGuarantorDetails','','GuarantorDetails')"class="blackfont"> Guarantor(s)</a></font></b></font></b></div>
            </td>
			
			<%
			if((strSSIType.equals("AB50L")) || (strSSIType.equals("AB05C")))
			{

			%>
				 <td width="17%" height="20" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Govenment Enquiry</font></b></font></div>
            </td>      
			<%
			}
			%>-->

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
              <table width="100%" border="0" cellspacing="2" cellpadding="8">
                <%
			   if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
			{
				vecCol =(ArrayList)vecRow.get(0);
			  %>
                <tr> 
                  <td colspan="2"><font size="1" face="MS Sans Serif">Whether 
                    any Government enquiry, proceedings or prosecution has been 
                    instituted against the unit or its proprietor / partners / 
                    promoters / directors for any offences ? if so, please give 
                    details</font></td>
                  <td width="18%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <input type="hidden" name="hidtxt1" value="<%=vecCol.get(0)%>">
                    <textarea name="txt_govtenquiry1" cols="60" rows="3" wrap="VIRTUAL"> <%=vecCol.get(1)%>  </textarea>
                  </td>
                  <td width="18%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"><font size="1" face="MS Sans Serif">Details 
                    of pending litigation, if any against and by the concern</font></td>
                  <td colspan="2" width="18%"><font size="1" face="MS Sans Serif">Please 
                    indicate whether any of the promoters or directors have at 
                    any time declared themselves as insolvent</font></td>
                </tr>
                <tr> 
                  <td colspan="2" height="122"> 
                    <% vecCol =(ArrayList)vecRow.get(1);%>
                    <input type="hidden" name="hidtxt2" value="<%=vecCol.get(0)%>">
                    <textarea name="txt_govtenquiry2" cols="60" rows="3" wrap="VIRTUAL"> <%=vecCol.get(1)%>  </textarea>
                  </td>
                  <td colspan="2" width="18%" height="122"> 
                    <% vecCol =(ArrayList)vecRow.get(2);%>
                    <input type="hidden" name="hidtxt3" value="<%=vecCol.get(0)%>">
                    <textarea name="txt_govtenquiry3" cols="60" rows="3" wrap="VIRTUAL"> <%=vecCol.get(1)%>  </textarea>
                  </td>
                </tr>
                <%
				}
				else
				{
				%>
                <tr> 
                  <td colspan="2"><font size="1" face="MS Sans Serif">Whether 
                    any Government enquirty, proceedings or prosecution has been 
                    instituted against the unit or its proprietor / partners / 
                    promoters / directors for any offences ? if so, please give 
                    details</font></td>
                  <td width="18%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <textarea name="txt_govtenquiry1" cols="60" rows="3" wrap="VIRTUAL"> </textarea>
                  </td>
                  <td width="18%">&nbsp;</td>
                </tr>
                <tr> 
                  <td colspan="2"><font size="1" face="MS Sans Serif">Details 
                    of pending litigation, if any against and by the concern</font></td>
                  <td colspan="2" width="18%"><font size="1" face="MS Sans Serif">Please 
                    indicate whether any of the promoters or directors have at 
                    any time declared themselves as insolvent</font></td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <textarea name="txt_govtenquiry2" cols="60" rows="3" wrap="VIRTUAL"> </textarea>
                  </td>
                  <td colspan="2" width="18%"> 
                    <textarea name="txt_govtenquiry3" cols="60" rows="3" wrap="VIRTUAL"> </textarea>
                  </td>
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

<input type="hidden" name="hidTabName" value="GovtEnquiry">


<input type="hidden" name="hidDesc1" value="GovernmentEnquirtyOrProceedings">
<input type="hidden" name="hidDesc2" value="DetailsOfPendingLitigation">
<input type="hidden" name="hidDesc3" value="PromotersOrDirectorsInsolvent">


<input type="hidden" name="hidTotalDesc" value="3">
<input type="hidden" name="hidFieldPrefix" value="txt_govtenquiry">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="GovernmentEnquirtyOrProceedings^DetailsOfPendingLitigation^PromotersOrDirectorsInsolvent">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="otherGenTable" value="">
<input type="hidden" name="hidOtherMethod" value="">
 <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="hidCategoryType" value="<%=strCategoryType%>">
<input type="hidden" name="hidSSIType" value="<%=strSSIType%>">




</form>
</body>
</html>
