<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />

<%	
	
	ArrayList arrValues=new ArrayList();
	
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrValues1");
	}
	
	ArrayList vecRow=(ArrayList)hshValues.get("vecRow");
	ArrayList vecCol=new ArrayList();		
	
	//out.println(vecRow);
%>
<html>
<head>
<title>Security Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">
DIV.cellContainer 
{	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var state = "<%=Helper.correctNull((String)hshValues.get("strStatId"))%>";

function callSearch()
	{
		
			
		var txtval=document.forms[0].txt_insurance.value;
		if(txtval=="")
			{
					 alert("Enter Value to Search");
				     document.forms[0].txt_insurance.focus();
				     return;
			}
		document.forms[0].method="post";
		document.forms[0].hidBeanGetMethod.value="getInsuranceno";
		document.forms[0].hidBeanId.value="Register";
		document.forms[0].action=appURL+"action/serchinsuranceregister.jsp";	
		document.forms[0].submit();
		
	   	
	}

function ClearFields()
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
				  document.forms[0].elements[i].value="";		  
			}		
			
		}
	}

function setValues(value1)
	{
		
		window.opener.document.forms[0].txt_insuranceno.value = value1;
		window.close();
	}

function callReset()
	{
		document.forms[0].txt_insurance.value=="";
	}


function callonLoad()
	{
	
	}
    
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css" type="text/css">
</head>
<body bgcolor="#EEEAE3" text="#000000" vlink="#330000" alink="#330000"
	leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onload="callonLoad()">
<jsp:include page="../share/help.jsp" flush="true"/>

<form name="appform" method="post">
  <table width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
    <tr> 
      <td>&nbsp; </td>
    </tr>
    <tr> 
      <td><b>Search by</b></td>
    </tr>
    <tr>
      <td>&nbsp;</td>
    </tr>
  </table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	class="outertable border1"
	align="center">
	 <tr> 
      <td valign="top">
	  <table width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td> 
                                
              <table width="100%" border="0" cellspacing="0" cellpadding="1">
                <tr> 
                  <td nowrap width="18%">&nbsp;</td>
                  <td nowrap width="18%"><font face="MS Sans Serif" size="1">Insurance No</font></td>
                  <td width="30%"> 
                    <input type="text" name="txt_insurance" size="20" maxlength="25" value="" onKeyPress="notAllowSplChar()">
                  </td>
                  <td width="16%"> 
                    <div align="center"> 
                      <input type="button" name="cmdsearch" value="Search" 
														class="buttonStyle"
														onClick="callSearch()">
                    </div>
                  </td>
                  <td width="18%"> 
                    <div align="center"> 
                      <input type="button" name="cmdreset" value="Reset" 
														class="buttonStyle"
														onClick="callReset()">
                    </div>
                  </td>
                </tr>
                <tr> 
                  <td colspan="6" nowrap>&nbsp;</td>
                </tr>
              </table>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" bordercolorlight="#EBEBF8" bordercolordark="#82829F">
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="100%" border="0" cellspacing="1" cellpadding="3" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                                        <tr bgcolor="#71694F"> 
                                          
                        <td width="24%" ><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>Sno</b></font></td>
                                          
                        <td width="76%"><font face="MS Sans Serif" size="1" color="#FFFFFF"><b>Insurance No
                          </b></font></td>
                                            
                                          
                      
                                          
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    
                  <td valign="top" align="center" height="230"> 
                    <DIV class="cellcontainer"> 
                                        
                      <table width="100%" border="0" cellspacing="1" cellpadding="2" bordercolorlight="#FFFFFB" bordercolordark="#DEDACF">
                        <%
                                      if(vecRow!=null)
                                      {
                                    	  int vecRowsize=vecRow.size();
                                    	 
                                          for(int i=0;i<vecRowsize;i++)
                                    	  {
                                        	  
                                        	  vecCol=(ArrayList)vecRow.get(i);
                                       %>
                        <tr> 
                          <td width="24%"><%=i+1%> </td>
                          <td width="76%"><a href="javascript:setValues('<%= Helper.correctNull((String)vecCol.get(0))%>')"><%= Helper.correctNull((String)vecCol.get(0))%></a></td>
                        </tr>
                        <% 		  
                                    	  }
                                    	  
                                      }
                                      
                                   %>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                        <tr> 
                          <td width="24%">&nbsp; </td>
                          <td width="76%">&nbsp; </td>
                        </tr>
                      </table>
                                      </div>
									  <table width="10%" border="0" cellspacing="0" cellpadding="3" align="center">
   <tr valign="top"> 
	 <td width="20%"> 
       <input type=button class="buttonClose" value="Close" name="closebtn" tabindex="25"  onClick=window.close()>
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

  
  
  <input type="hidden" name="hidBranchCode" value="<%=Helper.correctNull((String)request.getParameter("hidBranchCode")) %>">
  <input type="hidden" name="hidBeanMethod" value="getBranchSearchList">
  <input type="hidden" name="hidBeanId" value="mastapplicant">
  <input type="hidden" name="hidBeanGetMethod" value="getBranchSearchList">
  <input type="hidden" name="cbsaccno" value="<%=Helper.correctNull((String)request.getParameter("cbsaccno")) %>">
   
  
<br> 
</form>
</body>
</html>
