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

	for(int i=0;i<7;i++)
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
	for( i=1;i<=7;i++)		
	{	

		document.forms[0].elements["txt_utilities"+i].readOnly=one;	
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
	document.forms[0].action=appUrl+"action/ssi_above50lakhs_utilities.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}



function onCancel()
{	
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidMethod.value="getGeneralDetails";
		document.forms[0].hidBeanId.value="comssiaboveten";
		document.forms[0].action=appUrl+"action/ssi_above50lakhs_utilities.jsp";
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
<body  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onload="onloading()">
<form name="fininc" method="post">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colspan=5> 
              <jsp:include page="../share/menus.jsp" flush="true"/>
            </td>
          </tr>
        </table>
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
              Form for Credit Facilities above Rs.10 Lakh</i></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td valign="top"> 
        <table width="80%" border="0" cellspacing="3" cellpadding="2">
          <tr> 
            <td width="20%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><b><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                1</a></font></b></font></b></div>
            </td>
            <td width="23%" height="20" bgcolor="#71694F"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1" color="#FFFFFF">Tab 
                2 </font></b></font></div>
            </td>
            <td width="22%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                3 </a></font></b></font></div>
            </td>
            <td width="18%" height="20" bgcolor="#EEEAE3" align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
              4 </a></font></b></font></td>
            <td width="17%" height="20" bgcolor="#EEEAE3"> 
              <div align="center"><font face="Arial, Helvetica, sans-serif" size="2"><b><font face="MS Sans Serif" size="1"><a href="#"class="blackfont">Tab 
                5 </a></font></b></font></div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" onMouseOver=" " height="403">
    <tr> 
      <td valign="top" height="463"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" height="100%" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="5">
                <tr> 
                  <td height="448"> 
                    <table width="100%" border="0" cellspacing="1" cellpadding="3">
					<%
					if(hshValues.size()>0 && hshValues != null && vecrowsize >0)
					{
							vecCol =(ArrayList)vecRow.get(0);
					%>
                      <tr> 
                        <td width="50%"><b><font face="MS Sans Serif" size="2">UTILITIES 
                          </font></b><font face="MS Sans Serif" size="1">(Give 
                          comments on requirement /availability/adequacy,qualitative 
                          aspects,etc) </font></td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="50%" height="35"><font size="1" face="MS Sans Serif">a) 
                          Power</font></td>
                        <td width="50%" height="35"> 
                         </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Contracted 
                          Load </font></td>
                        <td width="50%"> 
						<INPUT TYPE="hidden" NAME="hidtxt1" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities1" value="<%=vecCol.get(1)%>">
                        </td>
                      </tr>
					<% vecCol =(ArrayList)vecRow.get(1);%>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Connected 
                          Load </font> </td>
                        <td width="50%"> 
							<INPUT TYPE="hidden" NAME="hidtxt2" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities2" value="<%=vecCol.get(1)%>" >
                        </td>
                      </tr>
					<% vecCol =(ArrayList)vecRow.get(2);%>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Future 
                          Poer Consumption (in No of units per month)</font></td>
                        <td width="50%"> 
						<INPUT TYPE="hidden" NAME="hidtxt3" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities3" value="<%=vecCol.get(1)%>" >
                        </td>
                      </tr>
					<% vecCol =(ArrayList)vecRow.get(3);%>
					<tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">StandBy Arrangements </font></td>
                        <td width="50%"> 
						<INPUT TYPE="hidden" NAME="hidtxt4" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities4" value="<%=vecCol.get(1)%>" >
                        </td>
                      </tr>


                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">(Enclose 
                          certified xerox copy of the power connection)</font></td>
                        <td width="50%">&nbsp;</td>
                      </tr>
						<% vecCol =(ArrayList)vecRow.get(4);%>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">b) 
                          Water </font></td>
                        <td width="50%"> 
						<INPUT TYPE="hidden" NAME="hidtxt5" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities5" value="<%=vecCol.get(1)%>" >
                        </td>
                      </tr>
					<% vecCol =(ArrayList)vecRow.get(5);%>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">c) 
                          Fuel </font></td>
                        <td width="50%">
						<INPUT TYPE="hidden" NAME="hidtxt6" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities6" value="<%=vecCol.get(1)%>" >
                        </td>
                      </tr>
					<% vecCol =(ArrayList)vecRow.get(6);%>
                      <tr> 
                        <td width="50%"><font size="1" face="MS Sans Serif">d) 
                          Other's Specify</font></td>
                        <td width="50%"><font size="1" face="MS Sans Serif">
						<INPUT TYPE="hidden" NAME="hidtxt7" VALUE="<%=vecCol.get(0)%>">
                          <input type="text" name="txt_utilities7" value="<%=vecCol.get(1)%>" >
                          </font></td>
                      </tr>
					<%
					  }
					  else
					  {
					%>
						                      <tr> 
                        <td width="50%"><b><font face="MS Sans Serif" size="2">UTILITIES 
                          </font></b><font face="MS Sans Serif" size="1">(Give 
                          comments on requirement /availability/adequacy,qualitative 
                          aspects,etc) </font></td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="50%" height="35"><font size="1" face="MS Sans Serif">a) 
                          Power</font></td>
                        <td width="50%" height="35"> 
                        
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Contracted 
                          Load </font></td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities1">
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Connected 
                          Load </font> </td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities2">
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">Future 
                          Poer Consumption (in No of units per month)</font></td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities3">
                        </td>
                      </tr>
						<tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">StandBy Arrangements </font></td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities4">
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">(Enclose 
                          certified xerox copy of the power connection)</font></td>
                        <td width="50%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">b) 
                          Water </font></td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities5">
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font face="MS Sans Serif" size="1">c) 
                          Fuel </font></td>
                        <td width="50%"> 
                          <input type="text" name="txt_utilities6">
                        </td>
                      </tr>
                      <tr> 
                        <td width="50%"><font size="1" face="MS Sans Serif">d) 
                          Other's Specify</font></td>
                        <td width="50%"><font size="1" face="MS Sans Serif"> 
                          <input type="text" name="txt_utilities7">
                          </font></td>
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
                <input type="button" name="cmdhelp" value="Help"  onClick="doHelp('products.htm')" style="background-color:#009966;cursor:help;;font-weight:bold;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
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


<input type="hidden" name="hidTabName" value="Utilities">

<input type="hidden" name="hidDesc1" value="PowerContractedLoad ">
<input type="hidden" name="hidDesc2" value="PowerConnectedLoad">
<input type="hidden" name="hidDesc3" value="PowerFutureConsumption">
<input type="hidden" name="hidDesc4" value="StandByArrangements">
<input type="hidden" name="hidDesc5" value="Water"> 
<input type="hidden" name="hidDesc6" value="Fuel"> 
<input type="hidden" name="hidDesc7" value="Others"> 

<input type="hidden" name="hidTotalDesc" value="7">
<input type="hidden" name="hidFieldPrefix" value="txt_utilities">
<INPUT TYPE="hidden" NAME="hidparam" VALUE="PowerContractedLoad^PowerConnectedLoad^PowerFutureConsumption^StandByArrangements^Water^Fuel^Others">
<INPUT TYPE="hidden" NAME="hidMethod" VALUE="getGeneralDetails">

<INPUT TYPE="hidden" NAME="hidGenID" VALUE="">
<INPUT TYPE="hidden" NAME="hidAction" VALUE="">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl" value="">

</form>
</body>
</html>
