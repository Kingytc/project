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

	for(int i=0;i<6;i++)
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

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}

</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/blackfont.css" type="text/css">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var genid = "<%=strgenid%>";

function callDisable(one)
{
	for( i=1;i<=6;i++)		
	{	

		document.forms[0].elements["txt_staffemployed"+i].readOnly=one;	
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
	document.forms[0].action=appUrl+"action/ssi_upto10lakh_staffemployed.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_upto10lakh_staffemployed.jsp";
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
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3"  onload="onloading()" >
<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bgcolor="#EEEAE3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
		<laps:borrowertype />
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="3" />
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
 <laps:Activitytab tabid="7" ssitype='<%=strSSIType%>' />
 
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
                          <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b>No. of Staff Employed</b></font><font size="1" face="MS Sans Serif"></font></td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Number of persons presently employed (to be filled up in case of existing units only) </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
						  <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                            <input  TYPE="text" name="txt_staffemployed1"  onKeyPress="allowNumber(this)" value="<%=vecCol.get(1)%>">
                          </td>
                        </tr>
					   <% vecCol =(ArrayList)vecRow.get(1);%>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Number of persons proposed to be employed </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
							  <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                             <input  TYPE="text" name="txt_staffemployed2"  onKeyPress="allowNumber(this)" value="<%=vecCol.get(1)%>">
                          </td>
                        </tr>
					 <% vecCol =(ArrayList)vecRow.get(2);%>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Raw Materials required (quantity) and source of supply</font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
						<INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_staffemployed3" value="<%=vecCol.get(1)%>" >
                          </td>
                     </tr>
					 <% vecCol =(ArrayList)vecRow.get(3);%>	
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Location of the market for the products(s)</font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
						<INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_staffemployed4"  value="<%=vecCol.get(1)%>" >
                          </td>
                     </tr>
			 <% vecCol =(ArrayList)vecRow.get(4);%>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Purpose of the new Loan.</font></td>
                      <td width="45%" bgcolor="#EEEAE3">
						<INPUT TYPE="hidden" NAME="hidtxt5" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_staffemployed5"  value="<%=vecCol.get(1)%>" >
                          </td>
                     </tr>
			 <% vecCol =(ArrayList)vecRow.get(5);%>
				<tr> 
				<td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Amount of the loan required </font></td>
                      <td width="45%" bgcolor="#EEEAE3">
						<INPUT TYPE="hidden" NAME="hidtxt6" VALUE="<%=vecCol.get(0)%>">
                         <input  TYPE="text" name="txt_staffemployed6" value="<%=vecCol.get(1)%>" onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" >
                          </td>
                     </tr>

					<%
						}
					else
						{
					%>
						 <tr> 
                          <td colspan="2" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b> No. of Staff Employed </b></font><font size="1" face="MS Sans Serif"></font></td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Number of persons presently employed (to be filled up in case of existing units only) </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
                             <input  TYPE="text" name="txt_staffemployed1"  onKeyPress="allowNumber(this)" >
                          </td>
                        </tr>
                        <tr> 
                          <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Number of persons proposed to be employed </font></td>
                          <td width="45%" bgcolor="#EEEAE3"> 
                              <input  TYPE="text" name="txt_staffemployed2"  onKeyPress="allowNumber(this)" >
                          </td>
                        </tr>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Raw Materials required (quantity) and source of supply</font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
                         <input  TYPE="text" name="txt_staffemployed3" >
                          </td>
                     </tr>
					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Location of the market for the products(s)</font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
                         <input  TYPE="text" name="txt_staffemployed4" >
                          </td>
                     </tr>

					<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Purpose of the new Loan.</font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
                         <input  TYPE="text" name="txt_staffemployed5"  >
                          </td>
                     </tr>
				<tr> 
                      <td width="55%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"> Amount of the loan required </font></td>
                      <td width="45%" bgcolor="#EEEAE3"> 
                         <input  TYPE="text" name="txt_staffemployed6"  onKeyPress="allowDecimals(this)" onBlur="roundtxt(this)" >
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

<input type="hidden" name="hidTabName" value="Upto10LakhStaffRMLoanDetails">

<input type="hidden" name="hidDesc1" value="NoOfStaffPresentlyEmployed">
<input type="hidden" name="hidDesc2" value="NoOfStaffProposedEmployed">
<input type="hidden" name="hidDesc3" value="SourcesOfSupply">
<input type="hidden" name="hidDesc4" value="LocationOfMarket">
<input type="hidden" name="hidDesc5" value="PurposeOfLoan">
<input type="hidden" name="hidDesc6" value="AmountOfLoan">


<input type="hidden" name="hidTotalDesc" value="6">
<input type="hidden" name="hidFieldPrefix" value="txt_staffemployed">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="NoOfStaffPresentlyEmployed^NoOfStaffProposedEmployed^SourcesOfSupply^LocationOfMarket^PurposeOfLoan^AmountOfLoan">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="hidOtherMethod" value="">
<input type="hidden" name="otherGetMethod" value="">
</form>
</body>
</html>
