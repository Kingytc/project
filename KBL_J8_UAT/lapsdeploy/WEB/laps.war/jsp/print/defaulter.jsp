<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<%


String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));
String strCheck="";
	//strCheck=Helper.correctNull((String)request.getParameter("txt_check"));
	
	strCheck=Helper.correctNull((String)hshValues.get("strCheck"));
	//System.out.println("strCheck===="+strCheck);
	//out.println("hshValueshshValueshshValueshshValues"+hshValues);

	String strBIFR =  Helper.correctNull((String )hshValues.get("BIFR"));
	String strCDR =   Helper.correctNull((String )hshValues.get("CDR"));
	String strGCDR =   Helper.correctNull((String )hshValues.get("GCDR"));
	String strOTS =   Helper.correctNull((String )hshValues.get("OTS"));
	String strBANK =   Helper.correctNull((String )hshValues.get("BANK"));
	String strRBINSF =   Helper.correctNull((String )hshValues.get("RBINSF"));
	String strRBIWILL =   Helper.correctNull((String )hshValues.get("RBIWILL"));
	String strSuit =  Helper.correctNull((String)hshValues.get("sel_suit"));
%>

<html>

<head>
<title>BANK OF BARODA - CAD</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script>
var appUrl="<%=ApplicationParams.getAppUrl()%>";

function callLink(page,bean,method)
{	
	if(!document.forms[0].cmdedit.disabled)
	{
		 document.forms[0].hidSourceUrl.value=page;
		 document.forms[0].hidBeanGetMethod.value=method;
		 document.forms[0].hidBeanId.value=bean;
		 document.forms[0].action=appUrl+"action/"+page;
		 document.forms[0].submit();
	 }
	else
	{
		ShowAlert(103);
	}
}


function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].method="post";	document.forms[0].action=appUrl+"action/facilitynav.jsp";
		//alert(document.forms[0].action);
		document.forms[0].submit();
	}
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,true,true)
}
function doNew()
{
	disableFields(false);
	enableButtons(true,false,false,true,true);
	document.forms[0].txt_check.value="";
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
		{
			document.forms[0].elements[i].value="";		  
		}
		
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{

	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="cad"
		document.forms[0].hidBeanGetMethod.value="updateDefaulter";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/defaulter.jsp";
		document.forms[0].submit();
	 }
	
}
function doSave()
{
	if(document.forms[0].txt_bank.value=="")
	{
			alert("Fill Bank Name");
			document.forms[0].txt_bank.focus();
			return;
	}
	else if(document.forms[0].txt_party.value=="")
	{
		alert("Fill Party Name");
		document.forms[0].txt_party.focus();
		return;
	}
		
		document.forms[0].hidAction.value="update";
		//alert(document.forms[0].hidAction.value);
		document.forms[0].hidBeanId.value="cad";
		//document.forms[0].hidBeanMethod.value="updateDefaulter";
		document.forms[0].hidBeanGetMethod.value="updateDefaulter";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/defaulter.jsp";
		document.forms[0].submit();
		
}

function callDescHelp()
{	
	
		var varQryString = appUrl+"action/defaultlisthelp.jsp";
		var title = "DefaulterHelp";
		var prop = "scrollbars=no,width=700,height=375";	
		prop = prop + ",left=200,top=200";
		window.open(varQryString,title,prop);	
	
}

function whileLoading()
{
			
			disableFields(true);
			enableButtons(true,true,true,false,false);	
}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	
	if(document.forms[0].txt_bank.value=="")
		document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;	
	document.forms[0].cmdclose.disabled=bool4;	
	document.forms[0].cmdnew.disabled=bool5;
  //  document.forms[0].cmdaudit.disabled=true;
}

function disableFields(val)
{
	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if((document.forms[0].elements[i].type=="text")||(document.forms[0].elements[i].type=="textarea"))
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		
	}

}
function placevalues()
	{
		document.forms[0].sel_suit.value="<%=strSuit%>";
		if("<%=strBIFR%>"!="")
			document.forms[0].BIFR.checked=true;
		if("<%=strCDR%>"!="")
			document.forms[0].CDR.checked=true;
		if("<%=strGCDR%>"!="")
			document.forms[0].GCDR.checked=true;
		if("<%=strOTS%>"!="")
			document.forms[0].OTS.checked=true;
		if("<%=strBANK%>"!="")
			document.forms[0].BANK.checked=true;
		if("<%=strRBINSF%>"!="")
			document.forms[0].RBINSF.checked=true;
		if("<%=strRBIWILL%>"!="")
		document.forms[0].RBIWILL.checked=true;

		
	}


</script>
<style type="text/css">
<!--
textarea {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
a:hover {  color: #FF3300}
-->
</style>
<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}
a:hover {  color: #FF6600}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
<link rel="stylesheet" href="blackfont.css" type="text/css">
</head>
<body text="#000000"  leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" bgcolor="#EEEAE3" onLoad="whileLoading();placevalues()">
<form name="loanHistory" method="post">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" >
          <tr> 
            <td valign="top" colSpan=5> 
              <jsp:include page="../share/help.jsp" flush="true"/>
              <jsp:include page="../share/menus.jsp" flush="true"/>
            </td>
          </tr>
          <tr> 
            <td valign="top" colSpan=5><b><font face="Times New Roman, Times, serif" size="3">Home -&gt; Setup -&gt; Corporate Products-&gt;Defaulters 
              List Add</font></b></td>
          </tr>
        </table>
      </td>
    </tr>
  </table>


  <table width="100%" border="1" cellspacing="0" cellpadding="3" height="400" bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
      <tr> 
        <td valign="top"> 
          <div align="left"></div>
          <table width="100%" border="0" cellspacing="0" cellpadding="0">
            <tr> 
              
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0">
                      <tr> 
                        <td valign="top"> 
                          <table width="100%" border="1" cellspacing="0" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="3">
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font face="MS Sans Serif" size="2">Bank 
                                      Name </font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_bank" size="40" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("txt_bank"))%>" maxlength="255">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2">Branch 
                                        Name </font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
					<input type="text" name="txt_branch" size="40" 
				onKeyPress="notAllowSplChar()"	value="<%=Helper.correctNull((String)hshValues.get("txt_branch"))%>" maxlength="255">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">State</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_state" size="40" 
									onKeyPress="notAllowSplChar()"	value="<%=Helper.correctNull((String)hshValues.get("txt_state"))%>" maxlength="255">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Party 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_party" size="40" 
									onKeyPress="notAllowSplChar()"	value="<%=Helper.correctNull((String)hshValues.get("txt_party"))%>" maxlength="255">
                                        </font>
								<font size="2"><b><a href="#" onClick="JavaScript:callDescHelp()" class="blackfont">?</a></b></font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Registered 
                                      Address</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_addr" size="40" 
										value="<%=Helper.correctNull((String)hshValues.get("txt_addr"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Outstanding 
                                        Amount</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_osamount" size="20" 
									onKeyPress="allowInteger()"	value="<%=Helper.correctNull((String)hshValues.get("txt_osamount"))%>" maxlength="12">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Suit 
                                      Filed</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <select name="sel_suit">
                                          <option value="" selected>&lt;------------Select---------------&gt;</option>
                                          <option value="SUIT">Yes</option>
                                       
                                        </select>
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"> <font size="2" face="MS Sans Serif"> 
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td colspan="4" bgcolor="#EEEAE3" nowrap><font face="MS Sans Serif" size="1">&nbsp; 
                                      <input type="checkbox" name="BIFR" value="BIFR" style="border-style:none">
                                      BIFR A/C&nbsp; 
                                      <input type="checkbox" name="CDR" value="CDR" style="border-style:none">
                                      A/c in CDR 
                                      <input type="checkbox" name="GCDR" value="GCDR" style="border-style:none">
                                      A/c of Group in CDR 
                                      <input type="checkbox" name="OTS" value="OTS" style="border-style:none">
                                      Compromise/OTS&nbsp; 
                                      <input type="checkbox" name="BANK" value="BANK" style="border-style:none">
                                      Bank's Caution 
                                      <input type="checkbox" name="RBINSF" value="RBINSF" style="border-style:none">
                                      RBI Defaulter(Non Suit File) 
                                      <input type="checkbox" name="RBIWILL" value="RBIWILL" style="border-style:none">
                                      RBI Defaulter(Willful)</font></td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir1" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir1"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir2" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir2"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir3" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir3"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir4" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir4"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir5" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir5"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir6" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir6"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir7" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir7"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir8" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir8"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font face="MS Sans Serif" size="2">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir9" size="41" maxlength="255" value="<%=Helper.correctNull((String)hshValues.get("txt_dir9"))%>"onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir10" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir10"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir11" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir11"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir12" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir12"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%" bgcolor="#EEEAE3" nowrap><font size="2" face="MS Sans Serif">Director 
                                      Name</font></td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir13" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir13"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                    <td width="20%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font size="2" face="MS Sans Serif">Director 
                                        Name</font></div>
                                    </td>
                                    <td width="30%" bgcolor="#EEEAE3" nowrap align="center"> 
                                      <div align="left"><font face="MS Sans Serif" size="2"> 
                                        <input type="text" name="txt_dir14" size="40" value="<%=Helper.correctNull((String)hshValues.get("txt_dir14"))%>" maxlength="255" onKeyPress="notAllowSplChar()">
                                        </font></div>
                                    </td>
                                  </tr>
                                </table>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                      <tr> 
                        <td height="60">&nbsp;</td>
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
    <TABLE ALIGN="CENTER" cellpadding="0" cellspacing="0">
    <TR><td width='16%'><input type='button' name='cmdnew' value='New' onClick="doNew()" style='font-weight:bold;background-color:#8F8369;color:white;font-size=10;font-family:mssansserif;width:50'  ></td><TD>    <%
		String strappno = request.getParameter("appno");
	//	out.println(strappno);
		%>
     <laps:combuttons  apporgcode='<%=strappno%>' strSource=""/> </TD></TR></TABLE>

<input type="hidden" name="comapp_id">
  <input type="hidden" name="comapp_companyname">
  <input type="hidden" name="hidSSIType" value="<%=Helper.correctNull((String)request.getParameter("ssitype"))%>">
  <input type="hidden" name="hidCategoryType" value="<%=Helper.correctNull((String)request.getParameter("cattype"))%>">
   <input type="hidden" name="hidNpaPageType" value="<%=Helper.correctNull((String)Helper.correctNull((String)request.getParameter("hidNpaPageType")))%>"> 
    <input type="hidden" name="hidAction" >
	  <input type="hidden" name="txt_check" value="<%=strCheck%>">
  <input type="hidden" name="hidBeanId" value="cad">
  <input type="hidden" name="hidBeanMethod" value="updateDefaulter">
  <input type="hidden" name="hidBeanGetMethod" value="getDefData" >
  <input type="hidden" name="hidSourceUrl" value="">
  
</form>
</body>
</html>

