<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String strvalue="";
strvalue =request.getParameter("val");
String par =Helper.correctNull((String)request.getParameter("par"));
%>
<HTML>
<HEAD>
<TITLE> List Of <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> 
</TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var concateval="";
var concateid="";



function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdadd.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdapply.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;

}


function show_submit()
{
var val="";
var id="";
var opt="<%=strvalue%>";
var par ="<%=par%>";
if (document.forms[0].valid.value != "")
	{
	window.opener.document.forms[0].formula.value = document.forms[0].formuladesc.value ;
	window.opener.document.forms[0].formulano.value=document.forms[0].txtformula.value;
	window.close();
	}

 else 
	{
		alert("Select a value");
		return;
	}

}

function call_page()
{
	window.close();
	
}

function makeformula()
{

	var formula="",formval="",selvalue1="",selvalue2="",formvaldesc="",formuladesc="";
	var selformula1="",selformuladesc1="",selformula2="",selformuladesc2="",arr,arr1;
	var selCMAyr1="$", selCMAyr2="$", selFormulayr1="", selFormulayr2="";

	selvalue1 =  document.forms[0].selcol1.options[document.forms[0].selcol1.selectedIndex].value;
	selvaluedesc1 =  document.forms[0].selcol1.options[document.forms[0].selcol1.selectedIndex].text;
	selvalue2 = document.forms[0].selcol2.options[document.forms[0].selcol2.selectedIndex].value;
	selvaluedesc2 = document.forms[0].selcol2.options[document.forms[0].selcol2.selectedIndex].text;
	selopt = document.forms[0].selopt.options[document.forms[0].selopt.selectedIndex].value;
	


	


	
	formval =  checktrim(document.forms[0].txtformula.value);
	formvaldesc = document.forms[0].formuladesc.value;

	if(selvalue1 !="" && selopt != "" && selvalue2 !="" )
	{	
		formula = "(<"+selvalue1+selCMAyr1+ selopt+"&" + selvalue2+selCMAyr2+")>";
		formuladesc = "("+selvaluedesc1 + selopt + selvaluedesc2 +")";
	}
	
	else if(selvalue1 =="" && selopt != "" && selvalue2 !=""  )
	{
		formula = selopt+"&" + selvalue2+selCMAyr2;
		formuladesc = selopt+"("+  selvaluedesc2 +")";
		
	}
	
//	alert("formula="+formula);
	if(formval!="")
	{
		formval = 	"(<"+ formval + formula +")>";
		formvaldesc = 	"("+ formvaldesc + formuladesc +")";
	}
	else
	{
		formval = 	 formula ;
		formvaldesc = formuladesc;
	}
	document.forms[0].txtformula.value =formval;
	document.forms[0].formuladesc.value =formvaldesc;

}




</script>
</HEAD>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" ><form name="selection" method="post" action=""> 
<div align="center"> 
  <p>&nbsp; </p>
  <table border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" width="300">
    <tr> 
        <td valign="top"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr bgcolor="#71694F"> 
              <td colspan="2"><font color="#FFFFFF"><b><font size="2" face="MS Sans Serif"> 
                Select <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> 
                </font></b></font></td>
            </tr>
            <tr> 
              <td width="30%"><font size="1" face="MS Sans Serif">Select CMA Column-1 
                </font></td>
              <td width="61%"> 
                <select name="selcol1">
                  <option value=""><--Select--></option>
                  <laps:finmaster/> 
                </select>
              </td>
            </tr>
            <tr bgcolor="#F2F1EC"> 
              <td><font size="1" face="MS Sans Serif">Select Operator </font></td>
              <td> 
                <select name="selopt">
                  <option value="" selected><--Select--></option>
                  <option value="+">(+)</option>
                  <option value="-">(-)</option>
                  <option value="*">(X)</option>
                  <option value="/">(/)</option>
                </select>
              </td>
              <td bgcolor="#F2F1EC" align="center" width="2%">&nbsp; </td>
            </tr>
            <tr> 
              <td><font size="1" face="MS Sans Serif">Select CMA Column-2 </font></td>
              <td> 
                <select name="selcol2">
                  <option value=""><--Select--></option>
                  <laps:notefinmaster/> 
                </select>
              </td>
            </tr>
            <tr> 
              <td colspan="2"> 
                <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                  <tr> 
                    <td> 
                      <table width="100%" border="0" cellspacing="1" cellpadding="5">
                        <tr bgcolor="#F2F1EC"> 
                          <td bgcolor="#F2F1EC" align="center"> 
                            <input type="button" name="apply2" value="Add Formula" onClick="makeformula()" style="color:white;background-color:#8F8369">
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
              </td>
            </tr>
            <tr> 
              <td colspan="2"> 
                <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                  <tr> 
                    <td> 
                      <table width="100%" border="0" cellspacing="1" cellpadding="5">
                        <tr> 
                          <td bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif">Formula</font></td>
                        </tr>
                        <tr> 
                          <td bgcolor="#F2F1EC"> 
                            <textarea name ="formuladesc" rows="10" cols="120" wrap="VIRTUAL"></textarea>
                          </td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <input type="text" name="txtformula" size="124" value="">
              </td>
            </tr>
            <br>
            <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
              <tr> 
                <td> 
                  <table width="100%" border="0" cellspacing="0" cellpadding="2">
                    <tr valign="top"> 
                      <td width="0"> 
                        <input type="button" name="cmdok" value="OK" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="show_submit()">
                      </td>
                      <td width="0"> 
                        <div align="center"> 
                          <input type="button" name="cmdclose" value="Close"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"  onClick="javascript:window.close()">
                        </div>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
            <input type="hidden" name="valid" >
            <tr> 
              <td colspan="2"> 
          </table>
        
      </table>
</div>
</form>
</BODY>
</HTML>
