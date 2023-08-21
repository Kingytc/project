<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
ArrayList arrCol=new ArrayList();
ArrayList arrRow=new ArrayList();
int vecsize=0;
if (hshValues != null)
{		arrRow = (ArrayList) hshValues.get("arrRowtargetmaster");				
}
if(arrRow !=null)
{
	vecsize=arrRow.size();
}

%>
<%
String strSessionModuleType=Helper.correctNull((String)request.getParameter("hid_moduletype"));
String grpRights = String.valueOf(Helper.correctNull((String) session.getAttribute("strGroupRights")).charAt(18));
if(strSessionModuleType.equalsIgnoreCase("")){
	strSessionModuleType=Helper.correctNull((String) session.getAttribute("sessionModuleType"));
}


ArrayList glp = null;
glp=(ArrayList)hshValues.get("arr");
String level = (String)session.getAttribute("strOrgLevel");
%>


<html>
<head>
<title>Target Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<SCRIPT LANGUAGE="JavaScript">
var vargrprights="<%=grpRights%>";
var varstrSolid = "<%=session.getAttribute("strSolid")%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var varstrSessionModuleType="<%=strSessionModuleType%>";

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
		if (document.forms[0].elements[i].type == "select-one") {
			document.forms[0].elements[i].disabled = val;
		}
	
	}
}


function enableButtons(bool0,bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdnew.disabled=bool0;
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;	  	
	document.forms[0].cmdclose.disabled=bool5;
	
}

function onLoading()
{	 
	
	if(orglevel == "A" && vargrprights=="w")
	{
		document.forms[0].cmdedit.disabled=false;
		document.all.IDB.style.visibility="visible";
		document.all.IDB.style.position="relative";
		document.all.IDIB.style.visibility="hidden";
		document.all.IDIB.style.position="absolute";
		
		
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.all.IDB.style.visibility="hidden";
		document.all.IDB.style.position="absolute";
		document.all.IDIB.style.visibility="visible";
		document.all.IDIB.style.position="relative";
		document.forms[0].sel_schemename.disabled=true; 
	}
	disableFields(true);
	document.forms[0].txt_Branchname.disabled =true;
	enableButtons(false,true,true,true,false,false);
}

function doEdit()
{
	disableFields(false);
 	enableButtons(true,true,false,true,false,false);
    document.forms[0].txt_Branchname.disabled =true;
 	document.forms[0].sel_schemename.disabled =true;
 	
}

function doSave()
{ 	
	document.forms[0].sel_schemename.disabled =false;
	document.forms[0].hidBeanId.value="agrcommon";
	enableButtons(true,true,true,true,true,false);
	document.forms[0].hidBeanMethod.value="updateAgr_targetmastedate";
	document.forms[0].hidBeanGetMethod.value="getAgr_targetmastedate";
	document.forms[0].hidSourceUrl.value="/action/agr_targetmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();		
}


function doCancel()
{	
 	if(ConfirmMsg(102))
	 {

		document.forms[0].hidBeanId.value="agrcommon"
		document.forms[0].hidBeanGetMethod.value="getAgr_targetmastedate";
		document.forms[0].action=appURL+"action/agr_targetmaster.jsp";
		document.forms[0].submit();
	 }
}

function doClose()
{
	if(ConfirmMsg(100))
 	{
		document.forms[0].action=appURL+"action/corppge.jsp";
	 	document.forms[0].submit();
	}
}




function showSystem(val)
{
	prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var pageName="ATM";
	if(orglevel == "C")
	{
		if(val == "2")
		{			
			valsys=level.substring(0,3)+"%%%000000000";
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
			}
			else
			{
				alert("select a Zone");
				return;
			}
		}
	    if(val == "4")
		{
			if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "" )
			{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
				
			}
			else
			{
				alert("select a Region");
				return;
			}
		}
		if(val == "5")
		{
			if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "" &&  document.forms[0].hidarea4.value != "")
			{
				level = document.forms[0].hidarea4.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
			}
			else
			{
				alert("Select a Branch");
				return;
			}
		}
	}
	else if(orglevel == "R")
	{
		if(val == "3")
		{
			valsys=level.substring(0,9)+"%%%000"	;
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
		}
		if(val == "4")
		{
			if(document.forms[0].hidarea3.value != "" )
			{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,12)+"%%%"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
			}
			else
			{
				alert("Select a Branch");
				return;
			}
		}
	}
	else if(orglevel == "D")
	{
		if(val == "4")
		{
			valsys=level.substring(0,9)+"%%%000";
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level+"&pageName="+pageName;
		}		
	}
	document.forms[0].hidBranches.value=level;
	title="help";	
	window.open(purl,title,prop);	

	
}
function funIfream()
{
	var varhidBranches= document.forms[0].hidBranches.value;
	document.all.isearch.src="<%=ApplicationParams.getAppUrl()%>action/iframeagrtargetmaster.jsp?hidBeanGetMethod=getAgr_targetmastedate&hidBeanId=agrcommon&hidBranches="+varhidBranches;      
}
function Selectval(val1,val2,val3,val4,val5,val6,val7){
	document.forms[0].hidAction.value="update"
	document.forms[0].sel_schemename.value=val1;
	document.forms[0].txt_amount.value=val2;
	document.forms[0].txt_noapplications.value=val3;
	document.forms[0].txt_subsidyamt.value=val4;
	document.forms[0].txt_Financialfrom.value=val5;
	document.forms[0].txt_Financialto.value=val6;
	document.forms[0].txt_bankloan.value=val7;
	
	enableButtons(true,false,true,false,false,false);
}
function doDelete()
{
	if(ConfirmMsg(101))
	{
	document.forms[0].sel_schemename.disabled=false;
	document.forms[0].hidAction.value="delete";
	document.forms[0].hidBeanId.value="agrcommon";
	document.forms[0].hidBeanMethod.value="updateAgr_targetmastedate";
	document.forms[0].hidBeanGetMethod.value="getAgr_targetmastedate";
	document.forms[0].hidSourceUrl.value="/action/agr_targetmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	 	
	}
}
function doNew()
{
	document.forms[0].hidAction.value="insert";
	disableFields(false);
	enableButtons(true,true,false,true,false,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=true;
		}
	}
}
function callSchemeType()
{
	var varScheme		=	document.forms[0].hidAgrTarget.value;
	if(varScheme!="")
	{
	var arr = varScheme.split("@");
	var arrLength=arr.length;
	if(arr!=null)
	{
		for(var i=0;i<arrLength;i++)
		{
			if(arr[i]==document.forms[0].sel_schemename.value)
			{
				alert("Scheme Name already attached ");
				document.forms[0].sel_schemename.value="0";
				document.forms[0].sel_schemename.focus();
				break;
			}
		}
		
	}
	
	}
	 
}
</script>
</head>
<body onload="onLoading()">

<form method="post" name="Master" class="normal">

<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Agriculture -&gt; Target Master </td>
	</tr>
</table>

<br>
<table width="80%" border="0" cellspacing="0" cellpadding="2" class="outertable border1" align="center">
<tr>
<td>
<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
                                    <tr> 
                                      <td width="76%" valign="top"> 
                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
                                         <tr>
										  <%
										  int initial = 0;
										  
										  if(level.equalsIgnoreCase("C"))
										  {
											  initial = 2;
										  }
										  else if(level.equalsIgnoreCase("R"))
										  {
											initial = 3;
										  }
										  else if(level.equalsIgnoreCase("D"))
										  {
											initial = 4;
										  }
											else if(level.equalsIgnoreCase("A"))
										  {
											initial = 5;
										  }
											else if(level.equalsIgnoreCase("B"))
										  {
											initial = 6;
										  }
										for(int y=initial;y<=glp.size()-1;y++)
										{
											if(!glp.get(y).equals(""))
											{
											%>
												<td  width="8%" > 
												<%=glp.get(y)%> 
												</td>
											<td width="25%">  
                                                   <input type="text" name="area<%=y%>" size=25>
												  <input type="hidden" name="hidarea<%=y%>" >
												
												<b><span
												onClick="showSystem('<%=y%>');" style="cursor:hand"><img
												src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												border="0" ></span></b>												
                                             	&nbsp;&nbsp;&nbsp;&nbsp; 
                                              </td>
											  <%
											}
										}
										  %>
										  <tr>
										  
                                        </table>
                                      </td>
                                      
                                    </tr>
                                 
                                  </table>
                                  
                                  
          


<table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable " align="center">

		<tr>
		    <td>Branch Name </td>
		    <% 
		    if(level.equalsIgnoreCase("A"))
		    {
		    %>
		   <td colspan="2"><input type="text" name="txt_Branchname" size="65" maxlength="70" value="<%=session.getAttribute("strOrgName")%>">		   
		  <%}else
			  {%>
			   <td colspan="2"><input type="text" name="txt_Branchname" size="65" maxlength="70"></td>
			  <%} %>
		</tr>
		
		<tr>
		    <td>Scheme Name </td>
		    <td colspan="2"> <select name="sel_schemename"  style="width:340px" onChange="callSchemeType()">
				 <option value="0">---select---</option>
				 <lapschoice:StaticDataTag apptype="11"  tagType=""/>
			     </select>
		     </td>
		   
		 </tr>
		 
		 
		 <tr>
		    <td>Amount</td>
		   <td> <lapschoice:CurrencyTag name="txt_amount" size="20" maxlength="12"	tabindex="2"  style="width:150px" /></td>
		 </tr>
		
		 <tr>
		    <td>No. of Applications</td>
		   <td> <input type="text" name="txt_noapplications" size="20" maxlength="10"	tabindex="2"  style="width:150px;text-align: right" onkeypress="allowInteger()"></td>
		 </tr>
		 
		  <tr>
		    <td>Subsidy Amount</td>
		   <td> <lapschoice:CurrencyTag name="txt_subsidyamt" size="20" maxlength="15"	tabindex="2"  style="width:150px"/></td>
		 </tr>
		 
		 <tr>
		 <td>Bank Loan</td>
		 <td><lapschoice:CurrencyTag name="txt_bankloan" size="20" maxlength="15"	tabindex="2"  style="width:150px"/></td>
		 </tr>
		 
		
		<tr>
			<td>Financial Yearwise From </td>
			
			<td><input type="text" name="txt_Financialfrom" size="6" maxlength="4" onkeypress="allowInteger()">&nbsp; To: &nbsp;<input type="text" name="txt_Financialto" size="6" maxlength="4" onkeypress="allowInteger()"> </td>
			
		</tr>
		
		</table>
		</td>
		</tr>
		</table>

<br>
<table width="60%" border="0" cellspacing="0" cellpadding="2" class="outertable " align="center">
<tr>
	<td>

<lapschoice:combuttonnew btnnames='New_Edit_Save_Delete_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
</td>
</tr>
</table>

<br>



<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable " align="center">
<tr class="dataheader" align="center">
	<td width="5%">&nbsp;</td>
	<td  width="20%">Scheme Name</td>
	<td width="10%">Amount</td>
	<td width="15%">User Id</td>
	<td width="10%">No. of Applications</td>
	<td width="15%">Subsidy Amount </td>
	<td width="10%">Bank Loan</td>
	<td width="10%">Financial Yearwise </td>
	
	
	
	
	</tr>
	</table>

<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable" id="IDB" align="center">
   </tr>
	
	<%
	String strSchemeType="";
	for(int i=0;i<vecsize;i++)
	{
		arrCol = (ArrayList) arrRow.get(i);
		
		 strSchemeType=strSchemeType+"@"+Helper.correctNull((String) arrCol.get(9));
	%>
	
	<tr class="datagrid">
	<td width="5%"><input type="radio" name="sel_rad" onClick="Selectval('<%=Helper.correctNull((String) arrCol.get(9))%>','<%=Helper.checkDecimal((String) arrCol.get(2))%>','<%=Helper.correctInt((String) arrCol.get(5))%>','<%=Helper.checkDecimal((String) arrCol.get(6))%>','<%=Helper.correctNull((String) arrCol.get(7))%>','<%=Helper.correctNull((String) arrCol.get(8))%>','<%=Helper.checkDecimal((String) arrCol.get(10))%>')" style="border-style:none"></td>
		<td  width="20%">&nbsp;<%=Helper.correctNull((String) arrCol.get(1))%></td>
		<td align="right" width="10%"><%=Helper.checkDecimal((String) arrCol.get(2))%></td>
		
		<td width="15%">&nbsp;<%=Helper.correctNull((String) arrCol.get(4))%></td>
		<td width="10%">&nbsp;<%=Helper.correctNull((String) arrCol.get(5))%></td>
		<td width="15%" align="right">&nbsp;<%=Helper.checkDecimal((String) arrCol.get(6))%></td>
		<td width="10%"; align="right">&nbsp;<%=Helper.checkDecimal((String) arrCol.get(10))%></td>
		<td width="10%">&nbsp;
		<%=Helper.correctNull((String) arrCol.get(7))%><%if((Helper.correctNull((String) arrCol.get(7))!="")&& (Helper.correctNull((String) arrCol.get(8))!="")) {%>-<%} %><%=Helper.correctNull((String) arrCol.get(8))%></td>
		
		
		
	</tr>
	<%} if(vecsize<=0)
	{ %>
	<tr class="datagrid">
	<td colspan="6">&nbsp;</td>
	</tr>
	<tr class="datagrid">
	<td colspan="6" align="center">No Data Found</td>
	</tr>
	<tr class="datagrid">
	<td colspan="6">&nbsp;</td>
	</tr>
	<%} %>
</table>

	
<table width="98%" border="0" cellspacing="1" cellpadding="0" class="outertable " align="center" id="IDIB">
<tr>
<td>
 <div class="cellContainer"> 
 <iframe src="<%=ApplicationParams.getAppUrl()%>action/blank.jsp"  id="isearch" width="100%" height="50%"  align="middle"></iframe> 
                            </div>
                            </td>
                            </tr>
                          
                            
                            </table>

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidAction" value="">
<input type="hidden" name="hidSourceUrl" value=""> 
<input type="hidden" name="hidBranches" value=""> 
<input type="hidden" name="hidAgrTarget" value="<%=strSchemeType %>">


</form>
</body>
</html>



