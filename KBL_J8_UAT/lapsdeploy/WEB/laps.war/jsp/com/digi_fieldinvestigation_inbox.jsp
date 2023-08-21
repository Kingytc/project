<%@include file="../share/directives.jsp"%>
<%ArrayList glp = null;
glp=(ArrayList)hshValues.get("arr");

String strhidcategory = Helper.correctNull((String)hshValues.get("hidCategoryType"));

%>
<html>
<head>
<title>Borrower Master Search</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var varhidcategory = "<%=strhidcategory%>";

function resetme()
{
	document.forms[0].sel_queryType.value="S";
	document.all.result.src=appURL+"action/blank.jsp";
}

function doClose()
{
	if(ConfirmMsg(100))
	 {
		 if(varhidcategory=="PERM")
		 {
			 document.forms[0].action=appURL+"action/com_permission.jsp?hidCategoryType="+varhidcategory;
			 document.forms[0].submit();
		 }
		 else if(varhidcategory=="RET")
		 {
			 document.forms[0].action=appURL+"action/retailpge.jsp?hidCategoryType="+varhidcategory;
			 document.forms[0].submit();
		 }
		 else if(varhidcategory=="CORP" || varhidcategory=="AGR")
		 {
			 document.forms[0].action=appURL+"action/corppge.jsp?hidCategoryType="+varhidcategory;
			 document.forms[0].submit();
		 }
	 }
}

function showSystem(val)
{
	prop = "scrollbars=yes,width=500,height=355,statusbar=yes";	
	xpos = (screen.width - 700) / 2;
	ypos = (screen.height - 550) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	if(orglevel == "C")
	{
		if(val == "2")
		{			
			valsys=level.substring(0,3)+"%%%000000000";
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
		}
		if(val == "3")
		{
			if(document.forms[0].hidarea2.value != "")
			{
				level = document.forms[0].hidarea2.value;
				valsys=level.substring(0,6)+"%%%000000"
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
			}
			else
			{
				alert("select a Zone");
				return;
			}
		}
	    if(val == "4")
		{
			if(document.forms[0].hidarea2.value != "" && document.forms[0].hidarea3.value != "")
			{
				level = document.forms[0].hidarea3.value;
				valsys=level.substring(0,9)+"%%%000"	;
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
				var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
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
			var purl = appURL+"jsp/com/comborrowerselect.jsp?val="+val+"&valsys="+level;
		}		
	}
	
	title="help";	
	window.open(purl,title,prop);	
}

function changeQueryType()
{
	if(document.forms[0].sel_queryType.value=="S")
	{
		document.forms[0].sel_queryType.value="S";
		document.all.result.src=appURL+"action/blank.jsp";
		return;
	}
		var area1="";
		var area2="";
		var area3="";
		var area4="";
		var area5="";
		if(document.forms[0].sel_queryType.value!="S")
		{
			if(orglevel == "C")
			{	
				area2 = document.forms[0].hidarea2.value;
				if(area2=="")
				{
					//alert("Select a Region");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
				area3=document.forms[0].hidarea3.value;
				if(area3=="")
				{
					//alert("Select a CLPU");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
				area4=document.forms[0].hidarea4.value;
				if(area4=="")
				{
					//alert("Select a Branch");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
			}
			else if(orglevel == "R")
			{
				area3=document.forms[0].hidarea3.value;
				if(area3=="")
				{
					//alert("Select a CLPU");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
				area4=document.forms[0].hidarea4.value;
				if(area4=="")
				{
					//alert("Select a Branch");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
			}
			else if(orglevel == "D")
			{
				area4=document.forms[0].hidarea4.value;
				if(area4=="")
				{
					//alert("Select a Branch");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
			}
			else if(orglevel == "A")
			{
				area4=level;
				if(area4=="")
				{
					//alert("Select a Branch");
					//document.forms[0].sel_queryType.value="S";
					//return;
				}
			}
		}
		//alert(area4+"---"+area3+"---"+area2);
	    var varqueryType=document.forms[0].sel_queryType.value;
		document.all.result.src=appURL+"action/appdigi_pending_result.jsp?hidBeanGetMethod=getdigi_FIKYCpending&area1="+area1+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidqueryType="+varqueryType+"&hidCategoryType="+varhidcategory;	
		
}


</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="">
<form name="loanHistory" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
       <%if(strhidcategory.equals("PERM")){ %>
        <tr>
			<td class="page_flow">Home -&gt; Permission -&gt; Query Reply </td>
		</tr>
		<% } else if(strhidcategory.equals("RET")) { %>
		 <tr>
			<td class="page_flow">Home -&gt; Retail -&gt; Digi-Retail FI/KYC Pending </td>
		</tr>
		<% } else if(strhidcategory.equals("CORP")) { %>
		 <tr>
			<td class="page_flow">Home -&gt; Corporate -&gt; Query Reply </td>
		</tr>
		<% } else if(strhidcategory.equals("AGR")) { %>
		 <tr>
			<td class="page_flow">Home -&gt; Agriculture -&gt; Query Reply </td>
		</tr>
		<% } %>
        </table>
      </td>
    </tr>
  </table>
  <div align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
      <tr> 
        <td valign="top" height="397"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td valign="top"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr> 
                    <td valign="top"> 
                      <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                        <tr> 
                          <td valign="top"> 
                            <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                              <tr>
                                <td valign="top"> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                                    <tr> 
                                      <td width="76%" valign="top"> 
                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
                                         <tr>
										  <%
										  int initial = 0;
										  String level = (String)session.getAttribute("strOrgLevel");
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
												onClick="showSystem('<%=y%>')" style="cursor:hand"><img
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
                                <tr> 
                                <td valign="top"> 
                                  <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
                                    <tr> 
                                      <td valign="top"> 
                                        <table width="100%" border="0" cellspacing="1" cellpadding="0" class="outertable">
                                          <tr>
                                             <td> Query  Type&nbsp;
                                             	<select name="sel_queryType" onchange="changeQueryType()">
                                             	 	<option value="S"> -- Select -- </option>
                                         	 	    <option value="ALL"> All</option>
                                             	 	<option value="KYC"> KYC Checklist Pending</option>
                                             	 	<option value="FI"> Field Investigation Pending</option>
                                             	</select>
                                             </td>
                                          </tr>
                                        </table>
                                      </td>
                                    </tr>
                                  </table>
                                  <br>
                                </td>
                              </tr>
                               <tr>
                        <td colspan="8">
                        </td>
                      </tr>
                              <tr> 
                                <td colspan="8"> 
                                  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
                                    <tr class="dataheader"> 
                                        <td width="20%" align="center">Proposal No</td>
										<td width="20%" align="center">Applicant Name</td>
										<td width="20%" align="center">Created by</td>
										<td width="20%" align="center">Created on</td>
										<td width="20%" align="center">Module</td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr align="center"> 
                            <td colspan="8"> <iframe id="result" src="" width="100%" height="240"> 
                                  </iframe> </td>
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
    <table width="0%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
      <tr> 
        <td> 
          <table width="0%" border="0" cellspacing="0" cellpadding="3" class="outertable">
            <tr valign="top"> 
              <td height="2"> 
                <input type="button" name="cmdreset" value="Reset" class="buttonStyle" onClick="resetme()">
              </td>
              <td height="2"> 
                <div align="center"> 
                  <input type="button" name="cmdClose" value="Close" class="buttonClose" onClick="doClose()">
                </div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
    </table>
  </div>
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">
<input type="hidden" name="hidPage" value="<%=request.getParameter("hidPage")%>">

</form>
</body>
</html>
