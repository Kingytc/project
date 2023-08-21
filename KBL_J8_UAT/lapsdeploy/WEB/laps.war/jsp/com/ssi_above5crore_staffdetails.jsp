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

	for(int i=0;i<vecrowsize;i++)
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
//System.out.println("--hshValues-34636-"+hshValues);
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
	for( i=1;i<=10;i++)		
	{	
		document.forms[0].elements["txt_staffdetails1"+i].readOnly=one;
		document.forms[0].elements["txt_staffdetails2"+i].readOnly=one;
		document.forms[0].elements["txt_staffdetails3"+i].readOnly=one;
		document.forms[0].elements["txt_staffdetails4"+i].readOnly=one;		document.forms[0].elements["txt_staffdetails5"+i].readOnly=one;		document.forms[0].elements["txt_staffdetails6"+i].readOnly=one;
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

function onEdit()
{
	callDisable(false);
	disableControls(true,false,false,true);

}

function doSave()
{	
	disableControls(true,true,true,false);
	document.forms[0].hidBeanGetMethod.value="updateStaffData";
	document.forms[0].hidBeanId.value="comssiaboveten";
	document.forms[0].action=appUrl+"action/ssi_above5crore_staffdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getStaffDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above5crore_staffdetails.jsp";
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

<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()" >
<form name="fininc" method="post">
<jsp:include page="../share/help.jsp" flush="true"/> 

  <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  >
    <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true">
        <jsp:param name="pageid" value="4" />
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
            <td valign="top" colspan=5><b><i>Home 
				-&gt;  Application-&gt; Ind. Activity   -&gt;Staff Details</i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  
<span style="display:none"><laps:borrowertype /></span> <laps:application/> 
<laps:Activitytab tabid="10" ssitype='<%=strSSIType%>' />
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
                          <table width="100%" border="0" cellspacing="1" cellpadding="0">
                            <tr> 
                              <td colspan="6"><font size="1" face="MS Sans Serif"><b>Particulars 
                                of existing key technical and executive staff 
                                (Please furnish data for existing as well as proposed 
                                staff) </b></font></td>
                            </tr>
                            <tr bgcolor="#71694F"> 
                              <td width="20%" align="center" height="25"><font  color="#FFFFFF">Name</font></td>
                              <td width="17%" align="center" height="25"><font  color="#FFFFFF">Designation</font></td>
                              <td width="15%" align="center" height="25"><font  color="#FFFFFF">Qualification</font></td>
                              <td width="9%" align="center" height="25"><font  color="#FFFFFF">Experiance</font> 
                              </td>
                              <td width="19%" align="center" height="25"><font  color="#FFFFFF">Any 
                                Special Achievement</font></td>
                              <td width="20%" align="center" height="25"><font  color="#FFFFFF">Functional 
                                Duties at the Unit</font></td>
                            </tr>
                            <%
				   if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
						vecCol =(ArrayList)vecRow.get(0);
				  		for(int i=0;i<vecrowsize;i++)
						  {
							vecCol =(ArrayList)vecRow.get(i);
				  %>
                            <tr bgcolor="#EEEAE3"> 
                              <td width="20%" bgcolor="#EEEAE3" align="center"> 
                                <input type="text" name="txt_staffdetails1<%=i+1%>" size="25" VALUE="<%=vecCol.get(1)%>" maxlength="50" >
                              </td>
                              <td width="17%" align="center"> 
                                <input type="text" name="txt_staffdetails2<%=i+1%>" size="20" VALUE="<%=vecCol.get(2)%>" maxlength="50" >
                              </td>
                              <td width="15%" align="center"> 
                                <input type="text" name="txt_staffdetails3<%=i+1%>" size="20" VALUE="<%=vecCol.get(3)%>" maxlength="50" >
                              </td>
                              <td width="9%" align="center"> 
                                <input type="text" name="txt_staffdetails4<%=i+1%>" size="5" VALUE="<%=vecCol.get(4)%>" maxlength="5" >
                              </td>
                              <td width="19%" align="center"> 
                                <textarea name="txt_staffdetails5<%=i+1%>" cols="20" wrap="VIRTUAL"><%=vecCol.get(5)%></textarea>
                              </td>
                              <td width="20%" align="center"> 
                                <textarea name="txt_staffdetails6<%=i+1%>" cols="20" wrap="VIRTUAL"> <%=vecCol.get(6)%> </textarea>
                              </td>
                            </tr>
                            <%
					  }
					for(int i=vecrowsize;i<10;i++)
					  {
				  %>
                            <tr bgcolor="#EEEAE3"> 
                              <td width="20%" bgcolor="#EEEAE3" align="center"> 
                                <input type="text" name="txt_staffdetails1<%=i+1%>" size="25" maxlength="50">
                              </td>
                              <td width="17%" align="center"> 
                                <input type="text" name="txt_staffdetails2<%=i+1%>" size="20" maxlength="50">
                              </td>
                              <td width="15%" align="center"> 
                                <input type="text" name="txt_staffdetails3<%=i+1%>" size="20" maxlength="50">
                              </td>
                              <td width="9%" align="center"> 
                                <input type="text" name="txt_staffdetails4<%=i+1%>" size="5" maxlength="5">
                              </td>
                              <td width="19%" align="center"> 
                                <textarea name="txt_staffdetails5<%=i+1%>" cols="20" wrap="VIRTUAL"></textarea>
                              </td>
                              <td width="20%" align="center"> 
                                <textarea name="txt_staffdetails6<%=i+1%>" cols="20" wrap="VIRTUAL"></textarea>
                              </td>
                            </tr>
                            <%
					  }
					
					}
				  else
				  {
					for(int i=0;i<10;i++)
					 {
				  %>
                            <tr bgcolor="#EEEAE3"> 
                              <td width="20%" bgcolor="#EEEAE3" align="center"> 
                                <input type="text" name="txt_staffdetails1<%=i+1%>" size="25" maxlength="50">
                              </td>
                              <td width="17%" align="center"> 
                                <input type="text" name="txt_staffdetails2<%=i+1%>" size="20" maxlength="50">
                              </td>
                              <td width="15%" align="center"> 
                                <input type="text" name="txt_staffdetails3<%=i+1%>" size="20" maxlength="50">
                              </td>
                              <td width="9%" align="center"> 
                                <input type="text" name="txt_staffdetails4<%=i+1%>" size="5" maxlength="5">
                              </td>
                              <td width="19%" align="center"> 
                                <textarea name="txt_staffdetails5<%=i+1%>" cols="20" wrap="VIRTUAL"></textarea>
                              </td>
                              <td width="20%" align="center"> 
                                <textarea name="txt_staffdetails6<%=i+1%>" cols="20" wrap="VIRTUAL"></textarea>
                              </td>
                            </tr>
                            <%
					  }
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

<input type="hidden" name="hidTabName" value="StaffDetails">

<input type="hidden" name="hidTotalDesc" value="10">
<input type="hidden" name="hidFieldPrefix" value="txt_staffdetails">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getStaffDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">
<input type="hidden" name="comapp_id" value="<%=request.getParameter("comapp_id")%>">
<input type="hidden" name="hidOtherMethod" value="">
<input type="hidden" name="otherGetMethod" value="">
 <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
 <input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
 <input type="hidden" name="id" value="<%=strBorrowerType%>">	
</form>
</body>
</html>
