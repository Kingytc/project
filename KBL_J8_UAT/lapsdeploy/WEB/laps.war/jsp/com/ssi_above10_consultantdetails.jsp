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
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));

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
	for( i=1;i<=6;i++)		
	{	

		document.forms[0].elements["txt_consultantdetails"+i].readOnly=one;	
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
if(appstatus=="Processed/Rejected" || appstatus=="Processed/Approved" || appstatus=="Closed/Approved" || appstatus=="Closed/Rejected")	 
		{
			disableControls(true,true,true,false);
		}else {
			document.forms[0].hidGenID.value=genid;
			disableControls(false,true,true,false);
			callDisable(true);
		}
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
	document.forms[0].action=appUrl+"action/ssi_above10_consultantdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above10_consultantdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}


function onClose()
{
	var cattype=document.forms[0].cattype.value;
	var id=document.forms[0].id.value;
 if((cattype=="ASSI")||(cattype=="ASBI"))
        {
       if(ConfirmMsg(100))
	 { 
		document.forms[0].action=appURL+"action/agrsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}
		if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
        {
        if(ConfirmMsg(100))
	 {
		document.forms[0].action=appURL+"action/comsearch.jsp?&id="+document.forms[0].id.value;
		document.forms[0].submit();
	 }
		}

}
</script>
</head>

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()">
<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
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
           <td valign="top" colspan=5><b><i><font face="Times New Roman, Times, serif" size="3">Home 
				-&gt;  Application-&gt; Tech. Feasibility    -&gt;Consultants  
 
 </font></i></b></td>
          </tr>
        </table>
		
      </td>
    </tr>
  </table>
   <span style="display:none"><laps:borrowertype /></span> <laps:application/> 
      <laps:Techfeasibilitytab tabid="8" typessi='<%=strSSIType%>'/>
   <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="350">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td valign="top"> 
                    <%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr>
                              <td width="35%" valign="top"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                  <tr> 
                                    <td width="31%"><font size="1" face="MS Sans Serif">Name 
                                      of the consultant</font></td>
                                    <td width="25%"> 
                                      <INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                                      <input type="text" name="txt_consultantdetails1"   VALUE="<%=vecCol.get(1)%>"size="25">
                                    </td>
                                    <% vecCol =(ArrayList)vecRow.get(1);%>
                                    <td width="22%"><font size="1" face="MS Sans Serif">Address 
                                      of the consultants</font></td>
                                    <td width="22%" align="right"> 
                                      <INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                                      <input type="text" name="txt_consultantdetails2"   VALUE="<%=vecCol.get(1)%>"size="25">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <% vecCol =(ArrayList)vecRow.get(2);%>
                                    <td width="31%"><font size="1" face="MS Sans Serif">Fees 
                                      payable and the manner in which payable</font></td>
                                    <td width="25%"> 
                                      <INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
                                      <input type="text" name="txt_consultantdetails3"  VALUE="<%=vecCol.get(1)%>"size="25">
                                    </td>
                                    <% vecCol =(ArrayList)vecRow.get(3);%>
                                    <td width="22%"><font size="1" face="MS Sans Serif">Scope 
                                      of work assigned to them</font></td>
                                    <td width="22%" align="right"> 
                                      <INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
                                      <input type="text" name="txt_consultantdetails4"  VALUE="<%=vecCol.get(1)%>" size="25">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
								<% vecCol =(ArrayList)vecRow.get(4);%>
                              <td width="35%"><font size="1" face="MS Sans Serif">Brief 
                                particulars of consultants including organisation 
                                set-up, bio-data or senior personnel, name of 
                                directors / partners, particulars of work done 
                                in the past and work on hand.</font></td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <INPUT TYPE="hidden" NAME="hidtxt5" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_consultantdetails5" cols="130" wrap="VIRTUAL" rows="5"> <%=vecCol.get(1)%></textarea>
                              </td>
                            </tr>
                            <tr> 
									<% vecCol =(ArrayList)vecRow.get(5);%>
                              <td width="35%"><font size="1" face="MS Sans Serif">Whether 
                                any of partners of partners / promoters / directors 
                                have any interest in consultant / collaborator 
                                firm. If so, details to be furnished</font></td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <INPUT TYPE="hidden" NAME="hidtxt6" VALUE="<%=vecCol.get(0)%>">
                                <textarea name="txt_consultantdetails6" cols="130" wrap="VIRTUAL" rows="5"> <%=vecCol.get(1)%> </textarea>
                              </td>
                            </tr>
                          </table>

						  <%
						  }
						  else
						  {
						  %>
                          <table width="100%" border="0" cellspacing="1" cellpadding="3">
                            <tr>
                              <td width="35%">
                                <table width="100%" border="0" cellspacing="1" cellpadding="3">
                                  <tr> 
                                    <td width="31%"><font size="1" face="MS Sans Serif">Name 
                                      of the consultant</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="txt_consultantdetails1" size="25">
                                    </td>
                                    <td width="22%"><font size="1" face="MS Sans Serif">Address 
                                      of the consultants</font></td>
                                    <td width="22%" align="right"> 
                                      <input type="text" name="txt_consultantdetails2" size="25">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="31%"><font size="1" face="MS Sans Serif">Fees 
                                      payable and the manner in which payable</font></td>
                                    <td width="25%"> 
                                      <input type="text" name="txt_consultantdetails3" size="25">
                                    </td>
                                    <td width="22%"><font size="1" face="MS Sans Serif">Scope 
                                      of work assigned to them</font></td>
                                    <td width="22%" align="right"> 
                                      <input type="text" name="txt_consultantdetails4" size="25">
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"><font size="1" face="MS Sans Serif">Brief 
                                particulars of consultants including organisation 
                                set-up, bio-data or senior personnel, name of 
                                directors / partners, particulars of work done 
                                in the past and work on hand.</font></td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="txt_consultantdetails5" cols="130" wrap="VIRTUAL" rows="5"></textarea>
                              </td>
                            </tr>
                            <tr> 
                              <td width="35%"><font size="1" face="MS Sans Serif">Whether 
                                any of partners of partners / promoters / directors 
                                have any interest in consultant / collaborator 
                                firm. If so, details to be furnished</font></td>
                            </tr>
                            <tr> 
                              <td width="35%" align="right"> 
                                <textarea name="txt_consultantdetails6" cols="130" wrap="VIRTUAL" rows="5"></textarea>
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
  <input type="hidden" name="hidTabName" value="ConsultantDetails">

<input type="hidden" name="hidDesc1" value="ConsultantName">
<input type="hidden" name="hidDesc2" value="ConsultantAddress">
<input type="hidden" name="hidDesc3" value="FeesPayable">
<input type="hidden" name="hidDesc4" value="ScopeOfWork">
<input type="hidden" name="hidDesc5" value="ConsultantOrganisationSetUp">
<input type="hidden" name="hidDesc6" value="PartnersInterestinConsultant">


<input type="hidden" name="hidTotalDesc" value="6">
<input type="hidden" name="hidFieldPrefix" value="txt_consultantdetails">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="ConsultantName^ConsultantAddress^FeesPayable^ScopeOfWork^ConsultantOrganisationSetUp^PartnersInterestinConsultant">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">

<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="hidOtherMethod" value="">

 <input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">	

</form>
</body>
</html>
