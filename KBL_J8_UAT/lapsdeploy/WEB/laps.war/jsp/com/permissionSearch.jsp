<%@include file="../share/directives.jsp"%>
<%ArrayList glp = null;
glp=(ArrayList)hshValues.get("arr");%>
<html>
<head>
<title>Borrower Master Search</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";
var varstrSessionModuleType="PERM";

function callNew()
{
	document.forms[0].action=appURL+"action/comappmaster.jsp";
	document.forms[0].submit();
}


function resetme()
{
	document.forms[0].bow_name.focus();
	document.all.result.src=appURL+"action/blank.jsp";
}

function setpageid()
{
	if(trim(document.forms[0].txt_noofrows.value) == "")
	{
		document.forms[0].txt_noofrows.value = "15"
	}
}	

function setCount()
{
   if(document.forms[0].txt_noofrows.value == "")
	{
		alert(" Enter Value");
		document.forms[0].txt_noofrows.focus();
		return;
	}
	if(parseInt(document.forms[0].txt_noofrows.value) > 100)
	{
		alert("Value should be below 100");
		document.forms[0].txt_noofrows.focus();
		return;
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/com_permission.jsp";
		 document.forms[0].submit();
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

function doSelect()
{
	document.forms[0].bow_name.value="";
	document.forms[0].bow_name.focus();
}

function rowCount(nav)
{
 	if(document.forms[0].hid_rowcount.value == "")
 	{
 		document.forms[0].hid_rowcount.value = 0;
		document.all.result.src=appURL+"action/blank.jsp";
 	}
 	else
 	{
 		if(nav == 1)
 		{
 			if(parseInt(document.forms[0].hid_rowcount.value) < parseInt(document.forms[0].txt_noofrows.value) + 1)
 			{
	 			document.forms[0].hid_rowcount.value = 0;
	 		}
	 		else
	 		{
				document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) - parseInt(document.forms[0].txt_noofrows.value);
			}
		}
		else if(nav == 2)
		{
			document.forms[0].hid_rowcount.value = parseInt(document.forms[0].hid_rowcount.value) + parseInt(document.forms[0].txt_noofrows.value);
		}
		doSearch();
 	}
}
function callOnKeyPress()
{
	if(document.forms[0].cat[0].checked)
	{
		allowAlphaNumeric();
	}
	else if (document.forms[0].cat[1].checked)
	{
		allowAlphaNumeric(); 
	}
	else if (document.forms[0].cat[2].checked)
	{
		allowAlphabetsForName();
	}
}

function doSearch()
{
	var area1="";
	var area2="";
	var area3="";
	var area4="";
	var area5="";
	if (document.forms[0].cat[2].checked){
	if(orglevel == "C")
	{	
		area2 = document.forms[0].hidarea2.value;
		if(area2=="")
		{
			alert("Select a Region");
			return;
		}
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "R")
	{
		area3=document.forms[0].hidarea3.value;
		if(area3=="")
		{
			alert("Select a CLPU");
			return;
		}
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "D")
	{
		area4=document.forms[0].hidarea4.value;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	else if(orglevel == "A")
	{
		area4=level;
		if(area4=="")
		{
			alert("Select a Branch");
			return;
		}
	}
	}
	scode="";
	if(document.forms[0].cat[0].checked)
	{
		cat=1;
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat=2;
	}
	else if (document.forms[0].cat[2].checked)
	{
		cat=3;
	}
	else
	{
		alert("Select a search criteria to search");
		return;
	}
	
	hid_rowcount=document.forms[0].hid_rowcount.value;
	
	if(hid_rowcount=="")
	{
		hid_rowcount=0;
	}
	
	var txtval=document.forms[0].bow_name.value;
	var txtlen=txtval.length;

	if (cat==3)
	{
		if(txtval == "")
		{
			ShowAlert('121','Borrower Name');
			document.forms[0].bow_name.value="";
			document.forms[0].bow_name.focus();
			return false;
		}
		 if(txtlen<=2)
		 {
			 alert("Enter atleast 3 characters");
		     document.forms[0].bow_name.focus();
		     return;
	 	 }
	}
	else if(cat==2 && txtval=="")
	{
		ShowAlert('121','CBS Customer ID');
	     document.forms[0].bow_name.focus();
	     return;
	}
	else if(cat==1 && txtval=="")
	{
		ShowAlert('121','Proposal No');
	     document.forms[0].bow_name.focus();
	     return;
	}
	
    noofrows = document.forms[0].txt_noofrows.value;
    bow_name =  document.forms[0].bow_name.value;
    hidPageType = document.forms[0].hidPageType.value;
    hidPage=document.forms[0].hidPage.value;
	select_cat="";
	document.all.result.src=appURL+"action/permissionResult.jsp?hidBeanGetMethod=getpermBorrowerDetails&area1="+area1+"&scode="+scode+"&cat="+cat+"&select_cat="+select_cat+"&bow_name="+bow_name+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidPageType="+hidPageType+"&hid_rowcount="+hid_rowcount+"&noofrows="+noofrows+"&hidPage="+hidPage+"&varstrSessionModuleType="+varstrSessionModuleType;	
}




</script>

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
</head>
<body onLoad="rowCount('0')">
<form name="loanHistory" method="post" class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
        <tr>
			<td class="page_flow">Home -&gt; Permission -&gt; Existing Permission </td>
		</tr>
        </table>
      </td>
    </tr>
  </table>
  <div align="center">
    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1 tableBg">
      <tr> 
        <td valign="top" height="397"> 
          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
            <tr> 
              <td valign="top"> 
                <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr> 
                    <td valign="top" class="setuphead"> 
                      <b>Borrower Search</b><br>
                      
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
					  						<td width="2%">                                               
                                                <input type="radio" name="cat" value="1" onClick="doSelect()" style="border-style:none">                                                
                                            </td>                                            
                                           
					                        <td width="10%"><b>Proposal No</b>                                              
                                            </td>
					                    	<td width="2%"> 
                                              <input type="radio" name="cat" value="2" onClick="doSelect()" style="border-style:none" checked="checked">
                                            </td>                                             
                                            
                                            <td width="10%"><b>CBS Customer ID</b>
                                            </td>
                                            <td width="2%"> 
                                              <input type="radio" name="cat" value="3" onClick="doSelect()" style="border-style:none">
                                            </td>
                                            <td width="10%"> 
                                              <b>Borrower Name</b> 
                                            </td>
                                            
                                            <td width="16%" align="center"> 
                                              <input type="text" name="bow_name"  size="20" onKeyPress="callOnKeyPress();">
                                            </td>
                                                                                      
                                            <td width="50%" align="left">                                               
                                                <input type="button" name="search" value="Search" class="buttonStyle" onClick="doSearch()">
                                                <input type="reset" name="search2" value="Reset" class="buttonStyle" onClick="resetme()">                                             
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
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr>
                                <td width="19%" nowrap> <b>No. of rows to be displayed 
                                  </b> </td>
                              <td width="81%"> 
                                <input type="text" name="txt_noofrows" size="4" maxlength="2" value = "15" onBlur="setCount()"onKeyPress="allowInteger()">
                                  <b>(Value should be below 100)</b> </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
                              <tr> 
                                <td colspan="8"> 
                                  <table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable">
                                    <tr class="dataheader"> 
                                      <td width="35%" align="center">Applicant Name</td>
										<td width="12%" align="center">CBS Customer ID</td>
										<td width="33%" align="center">Organisation</td>
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
             <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                  <tr>
                     <td width="9%" nowrap="nowrap"><a href="#" onclick="javascript:rowCount('1')"><b>&lt;&lt;Previous</b></a></td>
                     <td width="84%">&nbsp;</td>
                     <td align="right" width="7%"><a href="#" onclick="javascript:rowCount('2')"><b>Next&gt;&gt;</b></a></td>
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
<input type="hidden" name="comapp_id">
<input type="hidden" name="comapp_companyname">
<input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">
<input type="hidden" name="hidPage" value="<%=request.getParameter("hidPage")%>">
<input type="hidden" name ="hid_rowcount" value ="">

</form>
</body>
</html>
