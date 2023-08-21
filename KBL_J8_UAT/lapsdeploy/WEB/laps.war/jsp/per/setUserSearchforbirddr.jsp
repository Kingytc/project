<%@include file="../share/directives.jsp"%>
<%
ArrayList arrValues=new ArrayList();
if (hshValues instanceof java.util.HashMap) 
{
	if(hshValues!=null)
	{
		arrValues=(ArrayList)hshValues.get("arrUserValues");
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
-->
</style>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/setuser.js"> </script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/set/CommonFunction.js"> </script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/PageLoadTime.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var comlink="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>";
var selval="<%=Helper.correctNull((String)request.getParameter("selval"))%>";
var parentfield="<%=Helper.correctNull((String)request.getParameter("hidField"))%>";
var parentfield1="<%=Helper.correctNull((String)request.getParameter("hidField1"))%>";
var varfrompage="<%=strFromPage%>";
var varCFRDeviationPWR="<%=Helper.correctInt((String)hshValues.get("strCFRdevPower"))%>";
var varCFRDevUsrDesc="<%=Helper.correctNull((String)hshValues.get("strCFRdevPwrDesc"))%>";

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
		alert("Please choose the user Id or Name ");
		return;
	}
	if(trimtxt(document.forms[0].txt_user_id_name.value)=="")
	{
		alert("Please enter user Id or Name ");
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
	document.forms[0].hidBeanGetMethod.value="getUserSearchDataforddrbir";
	document.forms[0].hidBeanId.value="setusers";
	document.forms[0].action=appURL+"action/setUserSearchforbirddr.jsp?txt_name="+document.forms[0].txt_user_id_name.value+"&selval="+selval;	
	document.forms[0].submit();
}

function callReset()
{

	
}
function callonLoad()
{		
	document.forms[0].txt_user_id_name.readOnly=true;		
}


function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		} 
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function callReset()
{
	document.forms[0].txt_user_id_name.value==""
}

//val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16
function displayUser(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,val16,obj)
{
	
	 window.opener.document.forms[0].txt_convertedid.value=val1;
	 window.opener.document.forms[0].txt_convertedname.value=val4+" "+val5+" "+val6;
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
        <table width="100%" border="1" cellspacing="0" cellpadding="5" class="outertable">
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
										  <td width="40%"><b>Designation 
                                            </b></td>
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
                                   			
                                            <td width="5%"> <input type="radio" name="rdoUser" style="border-style:none"  onClick="displayUser('<%= Helper.correctNull((String)arrData.get(0))%>',
                                            '<%= Helper.correctNull((String)arrData.get(1))%>','<%= Helper.correctNull((String)arrData.get(2))%>',
                                            '<%= Helper.correctNull((String)arrData.get(3))%>','<%= Helper.correctNull((String)arrData.get(4))%>',
                                            '<%= Helper.correctNull((String)arrData.get(5))%>','<%= Helper.correctNull((String)arrData.get(6))%>',
                                            '<%= Helper.correctNull((String)arrData.get(7))%>','<%= Helper.correctNull((String)arrData.get(8))%>',
                                            '<%= Helper.correctNull((String)arrData.get(9))%>','<%= Helper.correctNull((String)arrData.get(10))%>',
                                            '<%= Helper.correctNull((String)arrData.get(11))%>','<%= Helper.correctNull((String)arrData.get(12))%>',
                                            '<%= Helper.correctNull((String)arrData.get(13))%>','<%= Helper.correctNull((String)arrData.get(15))%>','<%= Helper.correctNull((String)arrData.get(16))%>',this);" >
                                            
                                            </td>
                                            <td width="10%"><%= Helper.correctNull((String)arrData.get(0))%> </td>
                                            <td width="45%"><%= Helper.correctNull((String)arrData.get(3))%> </td>
											<td width="40%"><%= Helper.correctNull((String)arrData.get(12))%> </td>
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
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
                                            <td>&nbsp; </td>
											<td>&nbsp; </td>
                                          </tr>
                                          <tr> 
                                            <td>&nbsp; </td>
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
  <input type="hidden" name="org_code" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="strOrgCode" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="usr_id">
  <input type="hidden" name="userStatus">
  <input type="hidden" name="pagefrom" value="<%=Helper.correctNull((String)request.getParameter("pagefrom"))%>"/>
  <input type="hidden" name="pageselrow" value="<%=Helper.correctNull((String)request.getParameter("selrownum"))%>"/>
  <input type="hidden" name="hidField" value="<%=Helper.correctNull((String)request.getParameter("hidField"))%>"/>
  <input type="hidden" name="hidField1" value="<%=Helper.correctNull((String)request.getParameter("hidField1"))%>"/>
  <input type="hidden" name="hidFrmPage" value="<%=strFromPage%>"/>
</form>
</body>
</html>

