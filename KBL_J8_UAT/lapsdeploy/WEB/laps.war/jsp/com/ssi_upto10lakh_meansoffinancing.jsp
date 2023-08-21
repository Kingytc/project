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

	for(int i=0;i<4;i++)
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function callDisable(one)
{
	for( i=1;i<=4;i++)		
	{	

		document.forms[0].elements["txt_meansoffinance"+i].readOnly=one;	
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
		else {
		
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
	document.forms[0].action=appUrl+"action/ssi_upto10lakh_meansoffinancing.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_upto10lakh_meansoffinancing.jsp";
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
		 document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 document.forms[0].submit();
	 }
		}

}
</script>


</head>
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3"  onload="onloading()" >
<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#EEEAE3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
		<laps:borrowertype />
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="20" />
		<jsp:param name="cattype" value="<%=strCategoryType%>" />
	    <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table>
 <laps:application  />    
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5><b><i>Small Scale Industies -&gt; Application 
              Form for Credit Facilities upto Rs.10 Lakh</i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
<!--  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        <table width="80%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="19%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><a href="#" class="blackfont"><font size="1" face="MS Sans Serif">Tab1 </font></a></b></div>
            </td>
            <td width="22%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#" class="blackfont">Tab 2</a></font></b></font></div>
            </td>
            <td width="21%" height="20" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Means of Financing </font></b></font></div>
            </td>
            <td width="15%" height="20" bgcolor="#EEEAE3" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 3</a></font></b></font></td>
            <td width="23%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 4</a></font></b></font></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>-->
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="350">
    <tr> 
      <td valign="top"> 
        <div align="left">
          <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
            <tr> 
              <td>
                <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%">
                  <tr> 
                    <td valign="top">
                      <table width="100%" border="0" cellspacing="1" cellpadding="5">
					   <%
						   if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
						{
							vecCol =(ArrayList)vecRow.get(0);
						  %>
                       <tr> 
                          <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b> Means of Financing InCase of those applying for credit limits above Rs. 50,000/-  </b></font><font size="1" face="MS Sans Serif"></font></td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Promoters's Contribution </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> Rs.
						  <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                            <input  TYPE="text" name="txt_meansoffinance1"  onKeyPress="allowNumber(this)" value="<%=vecCol.get(1)%>">
                          </td>
                        </tr>
					   <% vecCol =(ArrayList)vecRow.get(1);%>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Subsidy , if any avaliable/eligible for</font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
							  <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                             <input  TYPE="text" name="txt_meansoffinance2"  onKeyPress="allowNumber(this)" value="<%=vecCol.get(1)%>">
                          </td>
                        </tr>
					 <% vecCol =(ArrayList)vecRow.get(2);%>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Seed Capital </font></td>
                      <td width="45%" bgcolor="#EEEAE3">Rs.
						<INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_meansoffinance3" value="<%=vecCol.get(1)%>" onKeyPress="allowNumber(this)">
                          </td>
                     </tr>
					 <% vecCol =(ArrayList)vecRow.get(3);%>	
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Loan(Working Capital / Term Loan) </font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
						<INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_meansoffinance4"  value="<%=vecCol.get(1)%>" onKeyPress="notAllowSplChar1(this)">
                          </td>
                     </tr>
			  	    <%
						}
					else
						{
					%>
						 <tr> 
                          <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b> Means of Financing InCase of those applying for credit limits above Rs. 50,000/-  </b></font><font size="1" face="MS Sans Serif"></font></td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Promoters's Contribution </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
                            Rs. <input  TYPE="text" name="txt_meansoffinance1"  onKeyPress="allowNumber(this)" >
                          </td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Subsidy , if any avaliable/eligible for </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
                              <input  TYPE="text" name="txt_meansoffinance2"  >
                          </td>
                        </tr>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Seed Capital </font></td>
                      <td width="45%" bgcolor="#EEEAE3"> Rs.
                         <input  TYPE="text" name="txt_meansoffinance3" onKeyPress="allowNumber(this)">
                          </td>
                     </tr>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Loan(Working Capital / Term Loan) </font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
                         <input  TYPE="text" name="txt_meansoffinance4" onKeyPress="allowNumber(this)">
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
        </div>
        
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

<input type="hidden" name="hidTabName" value="Upto10LakhMeansOfFinancing">

<input type="hidden" name="hidDesc1" value="PromotersContribution">
<input type="hidden" name="hidDesc2" value="SubsidyIfAvailable">
<input type="hidden" name="hidDesc3" value="SeedCapital">
<input type="hidden" name="hidDesc4" value="LoanWCTL">

   <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 

<input type="hidden" name="hidTotalDesc" value="4">
<input type="hidden" name="hidFieldPrefix" value="txt_meansoffinance">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="PromotersContribution^SubsidyIfAvailable^SeedCapital^LoanWCTL">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">

</form>
</body>
</html>
