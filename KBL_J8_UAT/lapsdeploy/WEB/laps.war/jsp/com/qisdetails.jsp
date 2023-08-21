<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld" %>
<lapschoice:handleerror />
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

 <%   
 // out.println("-----"+hshValues);
	ArrayList vecData = (ArrayList)hshValues.get("vecData");
	int size=0,intQuarter=0,intYear=0;
	if(vecData!=null)
	{
		size = vecData.size();
	}
String	strQisType = Helper.correctNull((String)hshValues.get("qistype"));

String	strYear = Helper.correctNull((String)hshValues.get("year"));
String	strQuarter = Helper.correctNull((String)hshValues.get("quarter"));
if(!strYear.trim().equals(""))
{
	intYear = Integer.parseInt(strYear);
}
if(!strQuarter.trim().equals(""))
{
	intQuarter = Integer.parseInt(strQuarter);
}
String strCompId =   Helper.correctNull((String)hshValues.get("comapp_id"));
String strCompDesc = Helper.correctNull((String)hshValues.get("comapp_name"));
if(strCompId.trim().equals(""))
{
	strCompId = Helper.correctNull((String)request.getParameter("comapp_id"));
}
if(strCompDesc.trim().equals(""))
{
	strCompDesc = Helper.correctNull((String)request.getParameter("comapp_compname"));
}
//out.println("strCompDesc"+strCompDesc);
%>

<html>
<head>
<title>Rating</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script language="javascript">

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var qistype="<%=strQisType%>";


function callChange()
{
	
	if( (document.forms[0].qistype.value=="H1") || (document.forms[0].qistype.value=="H2") )
	{
		document.forms[0].quarter.length=3;
		document.forms[0].quarter.options[0].value="S";
		document.forms[0].quarter.options[0].text="<-- Select -->";
		document.forms[0].quarter.options[1].value="1";
		document.forms[0].quarter.options[1].text="I";
		document.forms[0].quarter.options[2].value="2";
		document.forms[0].quarter.options[2].text="II";
	}
	else
	{
		document.forms[0].quarter.length=5;
		document.forms[0].quarter.options[0].value="S";
		document.forms[0].quarter.options[0].text="<-- Select -->";
		document.forms[0].quarter.options[1].value="1";
		document.forms[0].quarter.options[1].text="I";
		document.forms[0].quarter.options[2].value="2";
		document.forms[0].quarter.options[2].text="II";
		document.forms[0].quarter.options[3].value="3";
		document.forms[0].quarter.options[3].text="III";
		document.forms[0].quarter.options[4].value="4";
		document.forms[0].quarter.options[4].text="IV";
	}
}
  
function qislist()
{	
	callDisable(false);
	if((document.forms[0].qistype.value=="")||(document.forms[0].qistype.value=="S"))
	{
		ShowAlert('111',"Qis Type");
		document.forms[0].qistype.focus();
		return;
		
	}
	else if((document.forms[0].year.value=="")||(document.forms[0].year.value=="S"))
	{	
		ShowAlert('111',"Year");
		document.forms[0].year.focus();
		return;
		
	}
	else if((document.forms[0].quarter.value=="")||(document.forms[0].quarter.value=="S"))
	{	
		ShowAlert('111',"Period");
		document.forms[0].quarter.focus();
		return;
		
	}

	document.forms[0].hidBeanId.value="qis";
	document.forms[0].hidBeanGetMethod.value = "";
	document.forms[0].action=appUrl+"action/qisdetails.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function changelabel()
{
	if( (document.forms[0].qistype.value="H1") || (document.forms[0].qistype.value="H2") )
	{
		document.forms[0].quarter.length=2;
		document.forms[0].quarter.options[0].value="H1";
		document.forms[0].quarter.options[0].text="I";
		document.forms[0].quarter.options[1].value="H1";
		document.forms[0].quarter.options[1].text="II";
	}
	else
	{
//		document.forms[0].quarter.length=4;

	}
	

}
 
function doSave()
{

var qisnow=document.forms[0].qistype.value;
var quarternow=document.forms[0].quarter.value;
var yearnow=document.forms[0].year.value;
var year="<%=strYear %>";
var quarter="<%=strQuarter%>";

		if(qistype=="")
	{
		alert("No Data to Save");
		return;
	}

	 else if((qistype!=qisnow)||(quarter!=quarternow)||(year!=yearnow))
	{
		alert("Click on GO and then Save");
		return;
	}
 		callDisable(false);
 		document.forms[0].cmdapply.disabled = true;
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/qisdetails.jsp";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].submit();
 	 
}
function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=appUrl+"action/"+"corppge.jsp";
		document.forms[0].submit();
	}
}
function onloading()
{	 
	if(qistype=="")		
	document.forms[0].qistype.value ="S";
	else
	document.forms[0].qistype.value = qistype;
 	disableControls(false,true,true,false);
	callDisable(true);
	callChange();
	
}


function onEdit()
{
	
	callDisable(false);
	disableControls(true,false,false,true);
	
	
}
function callDisable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=one;		  
		}
		else if(document.forms[0].elements[i].type=="select-one")
		{
		  document.forms[0].elements[i].disabled=one;		  
		}

	}
}

function disableControls(bcmdEdit,bcmdApply,bcmdCancel,bcmdClose)
{
	document.forms[0].cmdedit.disabled=bcmdEdit;
	document.forms[0].cmdapply.disabled=bcmdApply;	
	document.forms[0].cmdcancel.disabled=bcmdCancel;
	document.forms[0].cmdclose.disabled=bcmdClose;
}

function onCancel()
{ 

	if (ConfirmMsg("102"))	
	{

			if((document.forms[0].qistype.value=="")||(document.forms[0].qistype.value=="S")||(document.forms[0].year.value=="S")||(document.forms[0].quarter.value=="S")||(qistype==""))
	{
		disableControls(false,true,true,false);
		callDisable(true);
		callChange();
		return;
	}

//		document.forms[0].hidBeanId.value="comratingana";
		document.forms[0].action=appUrl+"action/qisdetails.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function qisanalysis()
{
	if(!document.forms[0].cmdapply.disabled==true)
{
		ShowAlert('103');			
		return;
 }


	document.forms[0].hidBeanId.value="qis";
	document.forms[0].hidBeanGetMethod.value = "getQisAna";
	document.forms[0].action=appUrl+"action/qisanalysis.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();

}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appUrl+"phlp/corp_postdis_qisdet.htm";
  var title = "QIS";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
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
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="onloading()">
<form method="post" >
  <jsp:include page="../share/menus.jsp" flush="true"/> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td height="18"><font face="Times New Roman" size="3"><b><i>Home 
        </i><font face="MS Sans Serif">-&gt;</font><i> Corporate </i> <i> 
        Corporate -&gt; QIS</i></b></font></td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
    
        </table>
      </td>
    </tr>
  </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%">
          <tr> 
            <td> 
              <%
int strWidth=0;
int tabWidth=0;
int tableWidth;
 if(strWidth == 1)
{
	tableWidth = 15;
}
else if(strWidth == 2)
{
tableWidth = 30;
}
else
{
tableWidth=60;
}
%>
            </td>
          </tr>
        </table>
        <font face="MS Sans Serif" size="1"><b>Borrower Name :</b></font> <font face="MS Sans Serif" size="1"><%=strCompDesc %> </font>
        <table width="100%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
		<tr> 
            <td valign="bottom"> 
              <table width="70%" border="0" cellspacing="3" cellpadding="3" align="left">
                <tr> <td width="27%" align="center" height="2" bgcolor="#71694F"><b><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>QIS </b></font></b></td>
                  <td width="36%" align="center" bgcolor="#EEEAE3" height="2"><font face="MS Sans Serif" size="1"><a href="Javascript:qisanalysis()" class="blackfont"><b>QIS Analysis</b></a></font></td>
                  
                </tr>
              </table>
            </td>
          </tr>
          <tr> 
<td>
		   <table width="100%" border=0 cellspacing=0 cellpadding=0>
                <tr> 
                  <td width="7%" align="center"><font size="1" face="MS Sans Serif">QIS 
                                Type </font> </td>
                  <td width="20%" > <select name="qistype"  onChange="callChange()">
                                  <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                                  Select --&gt;</font></option>
                                  <option value="Q1" ><font size="1" face="MS Sans Serif">QIS (Form-I) </font></option>
                                  <option value="Q2"><font size="1" face="MS Sans Serif">QIS (Form-II)</font></option>
                                  <option value="H1"><font size="1" face="MS Sans Serif">Half - Yearly (Form-III A)</font></option>
                                  <option value="H2"><font size="1" face="MS Sans Serif"> Half - Yearly (Form-III B)</font></option>
                                 
                                </select>
                    
                   

				  <td width="20%"> <font face="MS Sans Serif" size="1">Year </font> 
                    <select name="year"  >
                      <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                      Select --&gt;</font></option>
                      <%for(int i=2000;i<=2025;i++)
								  {
									  if(intYear==i)
									  {
								  %>
                      <option value="<%=i%>" selected><font size="1" face="MS Sans Serif"><%=i%>-<%=i+1%> 
                      </font></option>
                      <%}else
									  {%>
                      <option value="<%=i%>" ><font size="1" face="MS Sans Serif"><%=i%>-<%=i+1%> 
                      </font></option>
                      <%}}%>
                    </select>
                                       <b><font size="1" face="MS Sans Serif"> </font></b> 
                     
  </td>
                  <td width="17%" align="right" > <font face="MS Sans Serif" size="1">Period 
                    </font><font size="1" face="MS Sans Serif"> </font><b><font size="1" face="MS Sans Serif">
                    <select name="quarter"  >
                      <option value="S" selected><font size="1" face="MS Sans Serif">&lt;-- 
                      Select --&gt;</font></option>
                      <%if(intQuarter==1)
									  {%>
                      <option value="1" selected><font size="1" face="MS Sans Serif">I 
                      </font></option>
                      <%}else
									  {%>
                      <option value="1" ><font size="1" face="MS Sans Serif">I 
                      </font></option>
                      <%}%>
                      <%if(intQuarter==2)
									  {%>
                      <option value="2" selected><font size="1" face="MS Sans Serif">II 
                      </font></option>
                      <%}else
									  {%>
                      <option value="2" ><font size="1" face="MS Sans Serif">II 
                      </font></option>
                      <%}%>
                      <%if(intQuarter==3)
									  {%>
                      <option value="3" selected><font size="1" face="MS Sans Serif">III 
                      </font></option>
                      <%}else
									  {%>
                      <option value="3" ><font size="1" face="MS Sans Serif">III 
                      </font></option>
                      <%}%>
                      <%if(intQuarter==4)
									  {%>
                      <option value="4" selected><font size="1" face="MS Sans Serif">IV 
                      </font></option>
                      <%}else
									  {%>
                      <option value="4" ><font size="1" face="MS Sans Serif">IV 
                      </font></option>
                      <%}%>
                    </select>
                    </font></b> 
                    <input type="button" name="go" value="GO" onClick="qislist()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif">
                  </td>
                </tr>
              </table>
			  </td>
			  </tr>
			  <tr>
            <td align="center"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" >
 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0"  height="100%">
                      <tr> 
                        <td valign="top" align="center"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
                            <tr> 
                              <td align="center"> 
                                <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                                  <tr> 
                                    <td width="5%" bgcolor="#71694F"> 
                                      <div align="left"><font  color="#FFFFFF">S.no</font></div>
                                    </td>
                                    <td width="34%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF">Particulars</font></td>
                                    <%
									   if((strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Current Year (Budget) </font></td>
                                    <%	}

									if(strQisType.trim().equals("H1"))		
								   {
								%>
								<td colspan="2">
									  <table width="100%" cellpadding="0" cellspacing="0" border="0" height="100">
                                        <tr align="center"> 
                                          <td colspan="2" bgcolor="#71694F"><font  color="#FFFFFF"> 
                                            Half Year Ended </font></td>
                                        </tr>
										<tr>
                                          <td bgcolor="#71694F" align="center"><font  color="#FFFFFF">Estimate 
                                            </font></td>
                                          <td bgcolor="#71694F" align="center"><font  color="#FFFFFF">Actuals</font></td>
                                        </tr>
									</table>
									
								</td>
                                <!-- <td align="center" bgcolor="#71694F"> <font  color="#FFFFFF"> 
                                      Half Year Ended </font><font  color="#FFFFFF">Estimate 
                                      </font></td>
                                    <td align="center" bgcolor="#71694F"> <font  color="#FFFFFF"> 
                                      Half Year Ended </font><font  color="#FFFFFF">Actuals</font></td>-->
                                    <%	}
									else if(strQisType.trim().equals("H2"))		
								   {
								%>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Previous Year Half Ended Estimate </font></td>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Previous Year Half Year Ended Actuals </font></td>
                                    <%	}

									if((strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Current Half Year Ending Estimate </font></td>
                                    <%	}

	                               if((strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Estimates </font></td>
                                    <%	}
									if(strQisType.trim().equals("Q2"))
									{
								%>
                                    <td width="31%" align="center" bgcolor="#71694F"> 
                                      <font  color="#FFFFFF"> 
                                      Actuals </font></td>
                                    <%	}
								%>
                                  </tr>
                                  <%
 	 for(int i=0;i<size;i++)
	 {
		ArrayList vecVal = (ArrayList)vecData.get(i);
		 if(vecVal!=null)
		 {
			 String strQisId = Helper.correctNull((String)vecVal.get(0));
			 String strRowType = Helper.correctNull((String)vecVal.get(1));
			
			String value3=Helper.correctNull((String)vecVal.get(3));
			if(value3.equals("0.00"))
			value3="";
			 String estimateval=Helper.correctNull((String)vecVal.get(4));
			if(estimateval.equals("0.00"))
			estimateval="";
			String actualval=Helper.correctNull((String)vecVal.get(5));
			if(actualval.equals("0.00"))
			actualval="";
			 
			


			 if(strRowType.trim().equals("H"))
			 {
			 %>
                                  <tr> 
                                    <td width="34%"  bgcolor="#F5F3EF"> 
                                      <font size="1" face="MS Sans Serif" ><%=(i+1)%> 
                                      </font></td>
                                    <td width="5%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"> 
                                     <%//=Helper.correctNull((String)vecVal.get(3)) %><%=value3 %>	
                                      </font></td>
                                    <%
									   if((strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}

									if(strQisType.trim().equals("H1"))		
								   {
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}
									else if(strQisType.trim().equals("H2"))		
								   {
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}

									if((strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}

	                               if((strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")))
									  {
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}
									if(strQisType.trim().equals("Q2"))
									{
								%>
                                    <td width="31%" align="center" bgcolor="#F5F3EF"> 
                                      <font  color="#FFFFFF"> 
                                      </font></td>
                                    <%	}
								%>
                                  </tr>
                                  <%}
			 else if(strRowType.trim().equals("C"))
			 {
 	%>
                                  <tr>
                                    <td width="5%" bgcolor="#F5F3EF" height="26"><font size="1" face="MS Sans Serif"><%=i+1%>.</font></td>
                                    <td width="54%" align="left" bgcolor="#F5F3EF" height="26"> 
                                      <input type="hidden" name="qisid<%=(i+1)%>" value="<%=strQisId%>">
                                      <font size="1" face="MS Sans Serif"> <%//=Helper.correctNull((String)vecVal.get(3)) %><%=value3 %></font></td>
                                    <%		if( (strQisType.trim().equals("Q1")) || (strQisType.trim().equals("Q2")) )
			{
	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=estimateval %> 
                                      </font> </td>
                                    <%		}

	 		if(strQisType.trim().equals("Q2")) 
			{
	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=actualval %> 
                                      </font> </td>
                                    <%		}

			if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
			{
	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=estimateval %> 
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=actualval %> 
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=Helper.correctNull((String)vecVal.get(6)) %> 
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right" height="26"> 
                                      <font size="1" face="MS Sans Serif"> <%=Helper.correctNull((String)vecVal.get(7)) %> 
                                      </font> </td>
                                    <%		}
	%>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <%
			 }
			 else
			 {
 	%>
                                  <tr> 
                                    <td width="5%" bgcolor="#F5F3EF"><font size="1" face="MS Sans Serif"><%=i+1%>.</font></td>
                                    <td width="54%" align="left" bgcolor="#F5F3EF"> 
                                      <input type="hidden" name="qisid<%=(i+1)%>" value="<%=strQisId%>">
                                      <font size="1" face="MS Sans Serif"> <%//=Helper.correctNull((String)vecVal.get(3)) %><%=value3 %></font></td>
                                    <%		if(strQisType.trim().equals("Q1"))
			{

									

	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_estimate<%=i+1%>" type="text" value="<%=estimateval %>" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <input name="txt_actual<%=i+1%>" type="hidden" 		value="<%=actualval %>">
                                    <%		}

	 		if(strQisType.trim().equals("Q2")) 
			{
	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_estimate<%=i+1%>" type="text" value="<%=estimateval %>" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_actual<%=i+1%>" type="text" 		value="<%= actualval %>" style="text-align:right">
                                      </font> </td>
                                    <%		}

			if( (strQisType.trim().equals("H1")) || (strQisType.trim().equals("H2")) )
			{
	%>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_cur_budget<%=i+1%>" type="text" 		value="<%=estimateval %>" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_half_estimate<%=i+1%>" type="text" 		value="<%= actualval %>kkk" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_half_actual<%=i+1%>" type="text" value="<%=Helper.correctNull((String)vecVal.get(6)) %>" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <td width="20%" bgcolor="#F5F3EF" align="right"> 
                                      <font size="1" face="MS Sans Serif"> 
                                      <input name="txt_cur_half_estimate<%=i+1%>" type="text" value="<%=Helper.correctNull((String)vecVal.get(7)) %>" OnKeyPress="allowDecimals(this)" style="text-align:right">
                                      </font> </td>
                                    <%		}
	%>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <%
			 }
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
                    <br>
                    <input type="hidden" name="count" value="<%=size%>">
                    <input type="hidden" name="hidBeanMethod" >
                    <input type="hidden" name="hidBeanGetMethod" value="getData">
                    <input type="hidden" name="hidBeanId" value="qis">
                    <input type="hidden" name="hidSourceUrl" value="/action/qisdetails.jsp" >
              </table>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <table width="12%" border="1" cellspacing="0" cellpadding="0" bordercolorlight="#8F8369" bordercolordark="#FFFFFB"  align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2">
          <tr valign="top"> 
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdedit" value="Edit" onClick="onEdit()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" >
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdapply" value="Save" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="doSave()">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdcancel" value="Cancel"  onClick="onCancel()" style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdhelp" value="Help"  style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50" onClick="dohlp()">
              </div>
            </td>
            <td width="0"> 
              <div align="center"> 
                <input type="button" name="cmdclose" value="Close" onClick="doClose()"  style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50">
              </div>
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
   <input type="hidden" name="comapp_id" value="<%=strCompId%>">
<input type="hidden" name="comapp_name" value="<%=strCompDesc%>">
   <input type="hidden" name="hidNpaPageType" >


 </form>
</body>
</html>