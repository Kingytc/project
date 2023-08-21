<%@ page import="com.sai.laps.helper.*" %>
<%@ page import="java.util.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }
 //out.println(hshValues);
 ArrayList vec = null;
 int vecsize=0;
 if (hshValues != null)
 {
   
   vec = (ArrayList)hshValues.get("vecVal");
  
 }

if(vec!=null)
{
	vecsize =vec.size();
	
}
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));


%>

<html>
<head>
<title>Process of Manufacture</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function placeValues()
{
	disableFields(true);
}
function disableFields(val)
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="select-one")
			{
			  document.forms[0].elements[i].disabled=val;
		  
			}
		}
	}
function doEdit()
{
	disableFields(false);
	enableButtons(true,false,false,false,true);

}
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdapply.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}
function doDelete()
{
	if(ConfirmMsg(101))
	 {
		document.forms[0].hidAction.value="delete"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateProcess";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocess.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
		var flag=validate();
	if(flag)
	{
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanMethod.value="updateProcess";
		document.forms[0].hidBeanGetMethod.value="getProcessData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocess.jsp";
		document.forms[0].submit();
	}
	else
		{
			alert("Enter values in Name/Company Field");
		}
	
}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="combanking"
		document.forms[0].hidBeanGetMethod.value="getProcessData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/comprocess.jsp";
		document.forms[0].submit();
	 }
		
	
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/comsearch.jsp";
		document.forms[0].submit();
	}
	
}

function  validate()
{ 
	var flag;
	for (m=0;m<8;m++)
	{
		if(document.forms[0].production[m].value != "")
		{
			
				return true ;
			
		}
		else
				flag = false; 
	}
	
return flag;

}
function callLink(page,bean,method)
{
	if (document.forms[0].cmdapply.disabled)
	{
	 document.forms[0].hidBeanGetMethod.value=method;
	 document.forms[0].hidBeanId.value=bean;
	 document.forms[0].action=appURL+"action/"+page;
	 document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
}
function callApplicantTab(page)
{ 
   	
	if (document.forms[0].cmdapply.disabled)
	{
	  if(page=="company")
	  { 
		  document.forms[0].hidBeanGetMethod.value="getData";
		  document.forms[0].action=appURL+"action/comcompany.jsp";
	  }
	  if(page=="proposal")
	  {
		  document.forms[0].hidBeanGetMethod.value="getProposal";
		  document.forms[0].action=appURL+"action/comproposal.jsp";
	  }
	   	  if(page=="facilities")
	  {
		  document.forms[0].hidBeanMethod.value="getFacilityData";
		  document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/facilities.jsp";
	  }
	 
	 
	 
		  document.forms[0].submit();
	 }
	else
	{
		ConfirmMsg(103);
	}
	
	
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
  width: 100%; height: 380;
  overflow: auto;
}
</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="placeValues()">
<form method="post" name="fltintrate">
<jsp:include page="../share/help.jsp" flush="true"/> 

   
  <table width="100%" border="0" cellspacing="0" cellpadding="0"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr> 
      <td valign="top" colSpan=5> 
        <jsp:include page="../share/menus.jsp" flush="true"/> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="4" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
  </table><table width="100%" border="0" cellspacing="0" cellpadding="0" >
    <tr> 
      <td valign="top" colspan=5> 
        <jsp:include page="../share/menus.jsp" flush="true"/>
        <i><b><font face="Times New Roman, Times, serif"> Process of Manufacture</font></b></i></td>
    </tr>
  </table>
  <span style="display:none"><laps:borrowertype /></span> <laps:application/>
    <table width="100%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            
      <td> 
        <table width="100%" border="0" cellspacing="3" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
          <tr align="center">
            <td width="10%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comactivities.jsp','compro','getActivity')" class="blackfont">Activities</a></b></font></td>
            <td width="10%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comproduction.jsp','combanking','getProductData')" class="blackfont">About 
              Prod.</a></b></font></td>
            <td width="13%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')" class="blackfont">Raw 
              Materials</a></b></font></td>
            <td width="13%" bgcolor="#71694F"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Manf. 
              Process</font> </b></font></td>
            <td width="9%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')" class="blackfont">Govt. 
              Policy</a></b></font></td>
            <td width="11%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comtransport.jsp','combanking','getTransData')" class="blackfont">Transportation</a></b></font></td>
            <td width="13%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('commarketing.jsp','combanking','getSegmentData')" class="blackfont">Marketing</a></b></font></td>
          </tr>
        </table>
      </td>
          </tr>
        </table>
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="380">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr> 
                  <td colspan="2"> 
                    <table width="50%" border="0" cellspacing="3" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F" >
                      <tr align="center" bgcolor="#EEEAE3"> 
                        <td width="36%" bgcolor="#71694F"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Installed 
                          Capacity </font></b></font></td>
                        <td width="38%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comprocessdesc.jsp','combanking','getDescData')" class="blackfont">Production 
                          Process </a></b></font></td>
                        <td width="26%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comstandard.jsp','combanking','getStdData')" class="blackfont">Other 
                          Details </a></b></font></td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2"> 
                    <table width="100%" border="1" cellspacing="0" cellpadding="3" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1"
								 cellpadding="4" align="center">
                            <tr>
                              <td width="6%" align="center" bgcolor="#71694F"><b><font  color="#FFFFFF">S.No</font></b></td>
                              <td width="19%" align="center" bgcolor="#71694F"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Installation 
                                / Production Plant</font></b></font></td>
                              <td align="center" width="12%" bgcolor="#71694F">&nbsp;</td>
                              <td align="center" colspan="3" bgcolor="#71694F"><font  color="#FFFFFF"><b>Installed 
                                capacity (over last 3 years)</b></font></td>
                              <td colspan="3" align="center" bgcolor="#71694F"><font  color="#FFFFFF"><b>Utilised 
                                capacity (over last 3 years)</b></font></td>
                            </tr>
                            <tr>
                              <td width="6%" bgcolor="#F9F7F2">&nbsp;</td>
                              <td width="19%" bgcolor="#F9F7F2"><font size="1" face="MS Sans Serif"></font></td>
                              <td align="center" width="12%" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b>Units</b></font></td>
                              <td align="center" width="11%" bgcolor="#F9F7F2"><font size="1" face="MS Sans Serif"><b>Year 
                                1</b></font></td>
                              <td align="center" width="11%" bgcolor="#F9F7F2"><font size="1" face="MS Sans Serif"><b>Year 
                                2</b></font></td>
                              <td align="center" width="11%" bgcolor="#F9F7F2"> 
                                <font size="1" face="MS Sans Serif"> </font> <font size="1" face="MS Sans Serif"><b>Year 
                                3</b></font></td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b>Year 
                                1</b></font></td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b>Year 
                                2</b></font></td>
                              <td width="14%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b>Year 
                                3</b></font></td>
                            </tr>
                            <%
					ArrayList g1=null;
					
					 for (int l=0;l<8;l++)
					 {
						
							
							int colSize=0;
						 
						 if(l<vecsize)
						 {
							 g1 = (ArrayList)vec.get(l);

							if(g1!=null)
							{
							   colSize = g1.size();

							   
       						}
						 }
						
							
						 if(colSize>0)	
						  {
						
					  %>
                            <tr>
                              <td width="6%" align="center" bgcolor="#F9F7F2"><font size="1" face="MS Sans Serif"><%=l+1%></font></td>
                              <td width="19%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="production" size="20" maxlength="200" value="<%=Helper.correctNull((String)g1.get(2))%>" onKeyPress="notAllowSplChar1(this)">
                              </td>
                              <td width="12%" align="center" bgcolor="#EEEAE3"> 
                                <select name="unit">
                                  <option value="">Select</option>
                                  <option value="Ton"
								<%
									if((Helper.correctNull((String)g1.get(3))).equals("Ton"))
									out.println("selected");
								%>
								
								>Ton</option>
                                  <option value="Litres"
							<%	if((Helper.correctNull((String)g1.get(3))).equals("Litres"))
									out.println("selected");
							%>
							>Litres</option>
                                  <option value="Numbers" 
							<%	
								if((Helper.correctNull((String)g1.get(3))).equals("Numbers"))
									out.println("selected");
							%>
								>Numbers</option>
                                </select>
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear1" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(4))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear2" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(5))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear3" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(6))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear1" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(7))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear2" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(8))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="14%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear3" size="10" maxlength="12" value="<%=Helper.correctNull((String)g1.get(9))%>" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                            </tr>
                            <%
						
						}
						else
						 {
					%>
                            <tr>
                              <td width="6%" align="center" bgcolor="#F9F7F2"><font size="1" face="MS Sans Serif"><%=l+1%></font></td>
                              <td width="19%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="production" size="20" maxlength="200" onKeyPress="notAllowSplChar1(this)">
                              </td>
                              <td width="12%" align="center" bgcolor="#EEEAE3"> 
                                <select name="unit">
                                  <option>Select</option>
                                  <option>Ton</option>
                                  <option>Litres</option>
                                  <option>Numbers</option>
                                </select>
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear1" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear2" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#F9F7F2"> 
                                <input type="text" name="insyear3" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear1" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="11%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear2" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
                              </td>
                              <td width="14%" align="center" bgcolor="#EEEAE3"> 
                                <input type="text" name="utiyear3" size="10" maxlength="12" onKeyPress="allowNumber(this)" style="text-align:right">
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
    <tr> 
      <td> 
        <%
		String strappno = request.getParameter("appno");
		//out.println(strappno);
		%>
        <laps:combuttons  apporgcode='<%=strappno%>' strSource=''/> </td>
    </tr>
  </table>
  <input type="hidden" name="hidAction" >
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod" value="">
<input type="hidden" name="hidSourceUrl">
</form>
</body>
</html>