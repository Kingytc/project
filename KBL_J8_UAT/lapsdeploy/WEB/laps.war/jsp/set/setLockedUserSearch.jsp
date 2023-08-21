<%@include file="../share/directives.jsp"%>
<%
ArrayList arrValues=new ArrayList();
if (hshValues instanceof java.util.HashMap) 
{
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrValues");
	}
	
}

String strFromPage = Helper.correctNull((String)request.getParameter("frompage"));
if(strFromPage.equalsIgnoreCase(""))
{
	strFromPage = Helper.correctNull((String)hshValues.get("frompage"));
}
%>

<html>
<head>
<title>USER SEARCH</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">

</style>
<style type="text/css">
<!--
.cellContainers 
{
	width: 100%;
	height: 250px;
	overflow: auto;
}
</style>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/setuser.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/CommonFunction.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";

function doClose()
{
if(ConfirmMsg(100))
	{
		window.close();
	}
}

function selectValues()
{
	document.forms[0].txt_user_id_name.readOnly=false;
	document.forms[0].txt_user_id_name.value="";
	document.forms[0].txt_user_id_name.focus();
}

function callSearch1()
{

	
	if((document.forms[0].userType[0].checked==false)&&(document.forms[0].userType[1].checked==false))
	{
		alert("Please choose the user ID or Name ");
		return;
	}
	if(trimtxt(document.forms[0].txt_user_id_name.value)=="")
	{
		alert("Please enter user ID or Name ");
		return;
	}
	if(document.forms[0].userType[0].checked==true)
	{
		document.forms[0].userStatus.value="id";
	}
	if(document.forms[0].userType[1].checked==true)
	{
		document.forms[0].userStatus.value="name";
	}
	
	document.forms[0].method="post";
	document.forms[0].hidBeanGetMethod.value="getLockedUserSearchData";
	document.forms[0].hidBeanId.value="setusers";
	document.forms[0].action=appURL+"action/setLockedUserSearch.jsp";	
	document.forms[0].submit();
}

function callonLoad()
{		
	document.forms[0].txt_user_id_name.readOnly=true;		
}




function callReset()
{
	document.forms[0].txt_user_id_name.value==""
}

function displayUser(val1,val2)
{
	window.opener.document.forms[0].txt_user_id.value = val1;
	window.opener.document.forms[0].txt_username.value = val2;
	window.opener.document.forms[0].cmdunlock.disabled=false;
	window.close();
}
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">  
<form name="appform" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		
      <td class="page_flow">Home -&gt; User-&gt; Search 
        By User Id or User Name </td>
	</tr>
</table>

<table width="98%" border="0" cellpadding="5" cellspacing="0"
	 class="outertable"
	align="center">
	 <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1">
          <tr> 
            <td valign="top"> 
              <table border="0" cellspacing="0" cellpadding="0" width="100%" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                                  <tr > 
                                    <td width="2%" nowrap="nowrap"> 
                                      <input type="radio" name="userType" value="radiobutton" style="border-style:none"  onClick="selectValues()">
                                    </td>
                                    <td width="10%">User ID </td>
                                    <td width="0%" nowrap="nowrap"> 
                                      <input type="radio" name="userType" value="radiobutton" style="border-style:none"  onClick="selectValues()">
                                    </td>
                                    <td width="7%" nowrap="nowrap">User Name</td>
                                    <td width="33%"> 
                                      <input type="text" name="txt_user_id_name" size="20" maxlength="25" value="" readOnly="readonly">
                                    </td>
                                    <td width="50%"> 
                                      <input type="button" name="cmdsearch" value="Search" 
														class="buttonStyle"
														onClick="callSearch1()">
                                    </td>
                                    
                                  </tr>
                                </table>
                              </td>
                            </tr>
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="98.3%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                        <tr class="dataheader"> 
                                          <td width="5%" >&nbsp;</td>
                                          <td width="10%"><b>User 
                                            Id </b></td>
                                          <td width="45%"><b>User 
                                            Name</b></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <DIV class="cellContainers"> 
                                        <table width="100%" border="0" cellspacing="1" cellpadding="2" >
                                  
                                   <%
                                   
                                      if(arrValues!=null)
                                      {
                                    	  int arrSize=arrValues.size();
                                          ArrayList arrData=null;
                                    	  for(int i=0;i<arrSize;i++)
                                    	  {
                                    		  arrData=new ArrayList();
                                    		  arrData=(ArrayList)arrValues.get(i);

                                   %>
                                   			<tr class="datagrid">
                                   			
                                            <td width="5%"> <input type="radio" name="rdoUser" style="border-style:none"  onClick="displayUser('<%= Helper.correctNull((String)arrData.get(0))%>','<%= Helper.correctNull((String)arrData.get(1))%>');" ></td>
                                            <td width="10%"><%= Helper.correctNull((String)arrData.get(0))%> </td>
                                            <td width="45%"><%= Helper.correctNull((String)arrData.get(1))%> </td>
                                          </tr>
                                   <% 		  
                                    	  }
                                    	  
                                      }
                                      else{
                                   %>
                                         
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <%} %>
                                        </table>
                                      </div>
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
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
<lapschoice:combuttonnew btnnames="" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="userStatus">
</form>
</body>
</html>

