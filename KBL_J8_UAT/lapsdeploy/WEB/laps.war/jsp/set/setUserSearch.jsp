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
	document.forms[0].hidBeanGetMethod.value="getUserSearchData";
	document.forms[0].hidBeanId.value="setusers";
	document.forms[0].action=appURL+"action/setUserSearch.jsp?txt_name="+document.forms[0].txt_user_id_name.value;	
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
function displayUser(val1,val2,val3,val4,val5,val6,val7,val8,val9,val10,val11,val12,val13,val14,val15,obj)
{
	if(varfrompage == "page_access")
	{
		window.opener.document.forms[0].txt_user_id.value = val1;
		window.opener.UserEntry();
		window.close();
	}
	else
	{
		var pageselrow="<%=Helper.correctNull((String)request.getParameter("pageselrow"))%>";
		 if(comlink=='legalcomp')
		 { 
			 if(pageselrow=='1')
			 {
			window.opener.document.forms[0].text_id1.value=val1;
			window.opener.document.forms[0].text_name1.value=val4+" " +val5+" "+val6;
			window.opener.document.forms[0].text_desig1.value=val13;
			window.close();
			 }
			 else if(pageselrow=='2')
			 {  
			window.opener.document.forms[0].text_id2.value=val1;
			window.opener.document.forms[0].text_name2.value=val4+" " +val5+" "+val6;
			window.opener.document.forms[0].text_desig2.value=val13;
			window.close();
			 }
		 }
		 else if(comlink=='custprof')
		 {
			 if(parentfield=='relation')
			 {
				 window.opener.document.forms[0].txt_relat_staff_id.value=val1;
				 window.opener.document.forms[0].txt_staff_name.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
			 else if(parentfield=='intro')
			 {
				 window.opener.document.forms[0].txt_introstaff_id.value=val1;
				 window.opener.document.forms[0].txt_introducer_name.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
		 }
		 else if(comlink=='apptransferto')
		 {
			 if(val10=='u')
			 {
				 obj.checked=false;
				 alert("User is in Unavailable Status, You cannot forward.");
				 return;
			 }
				 window.opener.document.forms[0].txttousrid.value=val1;
				 window.opener.document.forms[0].hidtoorgcode.value=val3;
				 window.opener.document.forms[0].txttousrname.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='apptransferfrom')
		 {
				 window.opener.document.forms[0].txtFromUserId.value=val1;
				 window.opener.document.forms[0].hidfromorgcode.value=val3;
				 window.opener.document.forms[0].txtFromUsername.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='inward1')
		 {
				 window.opener.document.forms[0].txt_staffid.value=val1;
				 window.opener.document.forms[0].txt_staffname.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='DDR1')
		 {
				 window.opener.document.forms[0].txt_phyinsp_Userid.value=val1;
				 window.opener.document.forms[0].txt_phyinsp_username.value=val4+" "+val5+" "+val6;
				 window.opener.document.forms[0].txt_phyinsp_design.value=val13;
				 window.close();
		 }
		 else if(comlink=='DDR2')
		 {
			 window.opener.document.forms[0].txt_staffid.value=val1;
			 window.opener.document.forms[0].txt_staffname.value=val4+" "+val5+" "+val6;
			 window.close();
		 }
		 else if(comlink=='inward2')
		 {
				 window.opener.document.forms[0].txt_convertedid.value=val1;
				 window.opener.document.forms[0].txt_convertedname.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='rep')
		 {
				 window.opener.document.forms[0].usr_id.value=val1;
				 window.opener.document.forms[0].txt_usrname.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='ddr1')
		 {
			 var var1=eval("window.opener.document.forms[0]."+parentfield);
			 var1.value=val1;
			 var1=eval("window.opener.document.forms[0]."+parentfield1);
			 var1.value=val4+" "+val5+" "+val6;
			 window.close();
		 }
		 else if(comlink=='ddr2')
		 {
				 window.opener.document.forms[0].txt_convertedid.value=val1;
				 window.opener.document.forms[0].txt_convertedname.value=val4+" "+val5+" "+val6;
				 window.close();
		 }
		 else if(comlink=='CFRDet')
		 {
			 if(eval(varCFRDeviationPWR)<=eval(val7))
			 {
				 window.opener.document.forms[0].hid_userid1.value=val1;
				 window.opener.document.forms[0].txt_userid1.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
			 else if(window.opener.document.forms[0].status_verified.value=="R")
			 {
				 window.opener.document.forms[0].hid_userid1.value=val1;
				 window.opener.document.forms[0].txt_userid1.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
			 else if(window.opener.document.forms[0].status_verified.value=="A")
			 {
				 alert("Deviation Approval should get from "+varCFRDevUsrDesc+" and above");
			 }
		 }
		 else if(comlink=='CFRDet1')
		 {
			 if(eval(varCFRDeviationPWR)<=eval(val7))
			 {
				 window.opener.document.forms[0].hid_userid2.value=val1;
				 window.opener.document.forms[0].txt_userid2.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
			 else if(window.opener.document.forms[0].status_verified.value=="R")
			 {
				 window.opener.document.forms[0].hid_userid2.value=val1;
				 window.opener.document.forms[0].txt_userid2.value=val4+" "+val5+" "+val6;
				 window.close();
			 }
			 else if(window.opener.document.forms[0].status_verified.value=="A")
			 {
				 alert("Deviation Approval should get from "+varCFRDevUsrDesc+" and above");
			 }
		 }
		 else if(comlink=='inwardoutwardproposal')
		 {
			 window.opener.document.forms[0].txt_loanprocessofficername.value=val1 +" - "+ val4+" "+val5+" "+val6;;
			 window.close();
		 }
		 else
		 { 		
		 		window.opener.document.forms[0].userslist.value=val1+"^"+val7;
		 		window.opener.fetchValuesWindowOpener();
		 		window.close();
		 }
	}
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
                                            '<%= Helper.correctNull((String)arrData.get(13))%>','<%= Helper.correctNull((String)arrData.get(14))%>',this);" >
                                            
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

