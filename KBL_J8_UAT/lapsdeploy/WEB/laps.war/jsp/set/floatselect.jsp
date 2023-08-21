<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ page import="com.sai.laps.helper.*,java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />


<% request.setAttribute("_cache_refresh", "true"); %>
<laps:handleerror />
<%
String identity=Helper.correctNull(request.getParameter("identity"));
String num=Helper.correctNull(request.getParameter("num"));
String strvalue="";
ArrayList vecData = (ArrayList) hshValues.get("vecRec1");
	if(vecData!=null)
	{
	//size=vecData.size();


	}


//out.print(hshValues);

//strvalue=request.getParameter("val");
%>
<HTML>
<HEAD>
<TITLE> List Of <%//=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<style type="text/css">
<!--
select {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
input {  font-family: "MS Sans Serif"; font-size: 10px; color: #003399; border-style: groove}
-->
</style>

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";


/*function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdadd.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdapply.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;

}

*/

/*function call_page()
{
	window.close();
	
}*/

function getValue()
	{
		var dis="<%//=vecData%>";
		//alert(dis);
		if (dis == "null")
		{
			
		//alert(dis);
			//document.forms[0].hidval.value="get";
			document.forms[0].action = appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="floatbaserate";
			document.forms[0].hidBeanMethod.value="getDisplay";
			document.forms[0].hidSourceUrl.value="/action/floatselect.jsp";
			document.forms[0].submit();
		}
   }

function show_submit()
{
var val="";
var id="";
var identity = "<%=identity%>"; 
var num="<%=num%>";
if (document.forms[0].cho_rate.value != "")
	{
val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
arr= id.split("^");
if (identity == "floating")
		{
window.opener.document.forms[0].baserate[num].value = arr[1];	
window.opener.document.forms[0].interestid[num].value = id;	
		}


/*for(int i=0;i<=arr.length;i++)
		{
			//a=arr[i];
			//alert (a);
		}
//window.opener.document.forms[0].txtinttype1.value = val;	

//window.opener.document.forms[0].txtinttype.value = id;	


/*var opt="<%=strvalue%>";
if (document.forms[0].cho_rate.value != "")
	{
val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
if (opt == "rating")
	{
window.opener.document.forms[0].ratetype.disabled = true;	
window.opener.document.forms[0].ratetype.value = val;	
window.opener.document.forms[0].hidsno.value = id;	
	}
*/

	
					
window.close();
}
else
	{
	alert("Select a value");
	}

}

</script>
</HEAD>

<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" 
onload="getValue();">
<form name="selection" method="post" action="">
  <div align="center"> 
    <p>&nbsp; </p>
    <table border="0" cellspacing="0" cellpadding="3" class="outertable border1" width="300">
      <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5">
            <tr bgcolor="#71694F"> 
              <td colspan="2"><font color="#FFFFFF"><b><font size="2" face="MS Sans Serif">
               Select <%//=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </font></b></font></td>
            </tr>
			<tr> 
                                <td align=center> <font size="1" face="MS Sans Serif"> 
                                  <select name="cho_rate"   size=9 style="width:200" ondblclick="show_submit()" >
                                  <lapschoice:floatbasedisp />
                                  </select>
                                  </font></td>
                              </tr>
							  <br>
							  
  <table width="12%" border="0" cellspacing="0" cellpadding="0" class="outertable border1"  align="center">
    <tr> 
	<td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top">
            <td width="0">
				<input type="button" name="cmdok" value="OK" class="buttonStyle" onClick="show_submit()">
            </td>
			<td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close"  class="buttonClose"  onClick="javascript:window.close()">
              </div>
            </td>
			</tr>
        </table>
      </td>
    </tr>
  </table>
	 <input type=hidden name=hiddesc value="">
  <input type=hidden name=hidtype value="">
  <input type="hidden" name="hidBeanId" value="floatbaserate" >
  <input type="hidden" name="hidBeanMethod">
  <input type="hidden" name="hidBeanGetMethod">
  <input type="hidden" name="hidSourceUrl">		
</form>
</BODY>
</HTML>
