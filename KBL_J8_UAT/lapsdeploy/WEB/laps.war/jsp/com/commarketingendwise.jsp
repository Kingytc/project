<%@ page import="java.util.*" %>
<%@ page import="com.sai.laps.helper.*" %>

<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
   if(objValues instanceof java.util.HashMap)
  {
	  hshValues=(java.util.HashMap)objValues;
  }
//out.println(hshValues);
 
 ArrayList vec1= null;
 int vecsize1=0;
 if (hshValues != null)
 {
   
  
   vec1 = (ArrayList)hshValues.get("vecVal1");
// out.println("vec"+vec);
//out.println("vec1"+vec1);
 }


if(vec1!=null)
{
	vecsize1 =vec1.size();
	
}
String strSSIType  =Helper.correctNull((String)request.getParameter("hidSSIType"));
String strCategoryType =Helper.correctNull((String)request.getParameter("hidCategoryType"));

%>
<html>
<head>
<title>Marketing &amp; Distribution</title>
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
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=val;		  
			}
			else if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=val;		  
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
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateSegmentEnd";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketingendwise.jsp";
		document.forms[0].submit();
	 }
		
}
function doSave()
{
		
		
		var termflag=termvalidate();
	
		if( termflag )
		{
		document.forms[0].cmdapply.disabled = true;
		document.forms[0].hidAction.value="update"
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanMethod.value="updateSegmentEnd";
		document.forms[0].hidBeanGetMethod.value="getSegmentEndData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketingendwise.jsp";
		document.forms[0].submit();
		}
		else
		{
			alert("Enter one value in Products Column");
		}

}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].hidBeanId.value="compro"
		document.forms[0].hidBeanGetMethod.value="getSegmentEndData";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/commarketingendwise.jsp";
		document.forms[0].submit();
	 }
		
	
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=appURL+"action/"+"comsearch.jsp";
		document.forms[0].submit();
	}
	
}
function  termvalidate()
{ 
	var termflag;
	for (m=0;m<8;m++)
	{
		

		if(document.forms[0].endproducts[m].value != "" ) 
				return true;
		else
				termflag=false;
	
	}

return termflag;

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
		ShowAlert(103);
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
		ShowAlert(103);
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
<link rel="stylesheet" href="<%//=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="placeValues()">
<jsp:include page="../share/help.jsp" flush="true"/>
<form method="post" name="fltintrate">
  <table width="100%" border="1" cellspacing="0" cellpadding="0"  bordercolorlight="#8F8369" bordercolordark="#FFFFFB">
    <tr>
      <td valign="top" colSpan=5> 
        <jsp:include page="../share/menus.jsp" flush="true"> </jsp:include>
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
        <i><b><font face="Times New Roman, Times, serif"> Marketing, Distribution, 
        Competition </font></b></i></td>
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
            <td width="13%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF"><a href="javascript:callLink('comrawmaterials.jsp','combanking','getRawData')" class="blackfont">Raw 
              Materials</a></font></b></font></td>
            <td width="13%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comprocess.jsp','combanking','getProcessData')" class="blackfont">Manf. 
              Process </a></b></font></td>
            <td width="9%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comgovtpolicies.jsp','combanking','getGovtData')" class="blackfont">Govt. 
              Policy</a></b></font></td>
            <td width="11%" bgcolor="#EEEAE3"><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('comtransport.jsp','combanking','getTransData')" class="blackfont">Transportation</a></b></font></td>
            <td width="13%" bgcolor="#71694F"><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">Marketing</font></b></font></td>
          </tr>
        </table>
      </td>
          </tr>
        </table>
  
  <table width="100%" border="1" cellspacing="0" cellpadding="5" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" height="400">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="1" cellspacing="3" cellpadding="1" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF" align="center" height="100%">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">
                <tr>
                  <td>
                    <table border="0" cellspacing="3" cellpadding="3" bordercolorlight="#EBEBF8" bordercolordark="#82829F" width="90%" >
                      <tr align="center" bgcolor="#EEEAE3"> 
                        <td width="13%" bgcolor="#EEEAE3" ><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('commarketing.jsp','combanking','getSegmentData')"  class="blackfont">Marketing 
                          </a> </b></font></td>
                        <td width="14%" bgcolor="#71694F" ><font face="MS Sans Serif" size="1"><b><font color="#FFFFFF">End-use 
                          wise </font></b></font></td>
                        <td width="13%" bgcolor="#EEEAE3" ><font face="MS Sans Serif" size="1"><b><a href="javascript:callLink('commarketingsegment.jsp','combanking','getMarketData')" class="blackfont">Distribution</a></b></font></td>
                        <td width="24%" bgcolor="#EEEAE3" ><font face="MS Sans Serif" size="1" color="#FFFFFF"><b><a href="javascript:callLink('comdistribute.jsp','combanking','getDistData')" class="blackfont">Major 
                          Customers Export</a></b></font></td>
                        <td width="22%" bgcolor="#EEEAE3" ><font face="MS Sans Serif" size="1" color="#FFFFFF"><b><a href="javascript:callLink('comdistributelocal.jsp','compro','getDistLocalData')" class="blackfont">Major 
                          Customers Local</a> </b></font></td>
                        <td width="14%" bgcolor="#EEEAE3"> 
                          <p><font face="MS Sans Serif" size="1"><a href="javascript:callLink('comcompetitor.jsp','combanking','getCompData')" class="blackfont"><b>Competition</b></a></font></p>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr>
                  <td> 
                    <table width="60%" border="1" cellspacing="0" cellpadding="5" align="center" bordercolorlight="#8F8369" bordercolordark="#FFFFFB" >
                      <tr> 
                        <td> 
                          <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center">
                            <tr> 
                              <td colspan="3"><font face="MS Sans Serif" size="1">Number 
                                of customers segment-wise (geographic / demographic 
                                / end use)</font></td>
                            </tr>
                            <tr bgcolor="#71694F">
                              <td width="50%" align="center"><font  color="#FFFFFF">S.No</font></td>
                              <td width="50%" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF">Products</font></td>
                              <td width="50%" align="center"><font face="MS Sans Serif" size="1" color="#FFFFFF">End 
                                wise</font></td>
                            </tr>
                            <%
					ArrayList g2=null;
				//if(vecsize1!=0)
				//{
					 for (int j=0;j<8;j++)
					 {
						
						int colSize1=0;

						 if(j<vecsize1)
						 {
							 g2 = (ArrayList)vec1.get(j);

							if(g2!=null)
							{
							   colSize1 = g2.size();
							}
						 }
						
					

						  if(colSize1>0)	
						  {
					
					
			 %>
                            <tr bgcolor="#EEEAE3">
                              <td width="50%" align="center"><font size="1" face="MS Sans Serif"><%=j+1%></font></td>
                              <td width="50%" align="center"> 
                                <input type="text" name="endproducts" maxlength="199" value="<%=Helper.correctNull((String)g2.get(2))%>" size="50" onKeyPress="notAllowSplChar1(this)">
                              </td>
                              <td width="50%" align="center"> 
                                <input type="text" name="endlocation" maxlength="199" value="<%=Helper.correctNull((String)g2.get(3))%>" size="35" onKeyPress="notAllowSplChar1(this)">
                                <input type="hidden" name="endtype" value="end">
                              </td>
                            </tr>
                            <%
						
						}
						else
						 {
					%>
                            <tr bgcolor="#EEEAE3">
                              <td width="50%" align="center"><font size="1" face="MS Sans Serif"><%=j+1%></font></td>
                              <td width="50%" align="center"> 
                                <input type="text" name="endproducts" size="50" maxlength="199" onKeyPress="notAllowSplChar1(this)">
                              </td>
                              <td width="50%" align="center"> 
                                <input type="text" name="endlocation" size="35" maxlength="199" onKeyPress="notAllowSplChar1(this)">
                                <input type="hidden" name="endtype" value="end">
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
<tr> 
      
    <td> 
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