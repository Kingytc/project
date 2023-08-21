<%@ include file="../share/directives.jsp"%>
<%ArrayList glp = null;
glp=(ArrayList)hshValues.get("arr");%>
<html>
<head>
<title>Borrower Master Search</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/menudropdown.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var level = "<%=session.getAttribute("strOrgCode")%>";
var orglevel = "<%=session.getAttribute("strOrgLevel")%>";

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function callCalender(fname)
 {
	 showCal("<%=ApplicationParams.getAppUrl()%>",fname);
 }

function callNew()
{
	document.forms[0].action=appURL+"action/comappmaster.jsp";
	document.forms[0].submit();
}

function callOffline()
{
	document.forms[0].action=appURL+"action/offline.jsp?fileid=companydtls";
	document.forms[0].submit();
}


function doReset()
	{
		document.forms[0].reset();
		document.all.result.src=appURL+"action/blank.jsp";
	}

function doSearch()
{
if(document.forms[0].select_cat.value=="S")
	{
		alert("Select Module");
		document.forms[0].select_cat.focus();
		return;
	}
var area1="";
var area2="";
var area3="";
var area4="";
var area5="";
	if(orglevel == "C")
	{
	area2 = document.forms[0].hidarea2.value;
	area3=document.forms[0].hidarea3.value;
	area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "R")
	{
	area3=document.forms[0].hidarea3.value;
	area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "D")
	{
	area4=document.forms[0].hidarea4.value;
	}
	else if(orglevel == "A")
	{
	area4=level;
	}
	scode="";
	if(document.forms[0].cat[0].checked)
	{
		cat="user";
	}
	else if (document.forms[0].cat[1].checked)
	{
		cat="borrower";
	}
	else 
	{
		cat="";
	}
	select_cat = document.forms[0].select_cat.value;	
	hidPageType = document.forms[0].hidPageType.value;
	From_date=document.forms[0].From_date.value;
	To_date=document.forms[0].To_date.value;
document.all.result.src=appURL+"action/audit_trial_result.jsp?hidBeanGetMethod=getBorrowerDetails&area1="+area1+"&cat="+cat+"&select_cat="+select_cat+"&area2="+area2+"&area3="+area3+"&area4="+area4+"&area5="+area5+"&hidPageType="+hidPageType+"&hidBeanId=audittrialsearch&From_date="+From_date+"&To_date="+To_date;
}
function doClose()
{
	if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appURL+"action/setupnav.jsp";
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
function show()
{
		if(document.forms[0].select_cat.value=="Setup")
	{
		document.all.b1.style.visibility="hidden";
		document.all.b2.style.visibility="hidden";
		document.forms[0].cat[0].checked=true;

	}
	else
	{
		document.all.b1.style.visibility="visible";
		document.all.b2.style.visibility="visible";

	}

}

//Help function added by vino
function dohlp()     
{
  var hlpvar = appURL+"phlp/setup_corpprod_audittrailreport.htm";
  var title = "AuditorsReport";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>

<STYLE>

DIV.cellContainer {	
  width: 100%; height: 100%;
  overflow: auto;
}

</STYLE>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="">
<form name="loanHistory" method="post" class="normal">
  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0">
    <tr> 
      <td> 
        <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0"  >
          
          <tr> 
            <td valign="top"  class="page_flow">Audit Trail Search</td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <br>
  <div align="center">
    <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="3" >
      <tr> 
        <td valign="top" height="397"> 
          <div align="left"></div>
          <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
            <tr> 
              <td valign="top"> 
                <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="5" >
                  <tr> 
                    <td valign="top"> 
                      <div align="left"><b>Borrower 
                        Search</b><br>
                      </div>
                      <table class="outertable"  width="100%" border="0" cellspacing="2" cellpadding="5" >
                        <tr> 
                          <td valign="top"> 
                            <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="0" >
                              <tr>
                                <td valign="top"> 
                                  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1" >
                                    <tr> 
                                      <td width="76%" valign="top"> 
                                        <table class="outertable border1"  width="100%" border="0" cellspacing="1" cellpadding="0" >
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
                                                   <input type="text" name="area<%=y%>" size="25">
												  <input type="hidden" name="hidarea<%=y%>" >
												<b><span onClick="showSystem('<%=y%>')" style="cursor:hand">?</span></b> 
                                             &nbsp;&nbsp;&nbsp;&nbsp; 
                                              </td>
											  <%
											}
										}
										  %>
										  </tr>
										  
                                        </table>
                                      </td>
                                      
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr> 
                                <td valign="top"> <br>
                                  <table class="outertable"  width="100%" border="0" cellspacing="0" cellpadding="1" >
                                    <tr> 
                                      <td valign="top"> 
                                        <table class="outertable"  width="100%" border="0" cellspacing="1" cellpadding="0">
                                          <tr> 
                                            <!--<td> 
                                              <div align="center"> 
                                                <input type="radio" name="cat" value="1"  style="border-style:none" >
                                              </div>
                                            </td>
                                            <td> Corporate 
                                              </td>
                                            <td> 
                                              <div align="center"> 
                                                <input type="radio" name="cat" value="2" style="border-style:none">
                                                </div>
                                            </td>
                                            <td>SSI</td>-->
											<td>Module</td>

                                            <td> 
                                              <div align="right"> 
                                                <select name="select_cat" onChange="show()">
                                                  <option value="S" selected>&lt;--Select--&gt;</option>
                                                  <option value="Setup">Setup </option>
												   <option value="Retail">Retail / Agriculture </option>
                                                  <option value="CommercialApplication">CommercialApplication</option>
												  <option value="CommercialProposal">CommercialProposal</option>
												  <option value="TertiaryApplication">TertiaryApplication</option> 
												  <%-- <option value="TertiaryProposal">TertiaryProposal</option>--%>                                        
                                                </select>
                                              </div>
                                            </td>
                                            <td align="right"> Report From </td>
                                            <td> 
                                              <div align="center">
                                                <input type="text" name="From_date"  onblur="checkDate(this)" size="15" readOnly>
                                                <a alt="Select date from calender"  href="javascript:callCalender('From_date')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0" ></a> 
                                              </div>
                                            </td>
											<td align="right"> To </td>
											 <td> 
                                              <div align="center">
                                                <input type="text" name="To_date"  onblur="checkDate(this)" size="15" readOnly>
                                                <a alt="Select date from calender"  href="javascript:callCalender('To_date')"><img src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a> 
                                              </div>
                                            </td>
                                            <td>
                                              <input type="button" name="search" value="Search" class="buttonstyle" onClick="doSearch()">
                                            </td>
                                            <td> 
                                              <div align="right"> </div>
                                            </td>
                                          </tr>										 
                                        </table>
										
                                      </td>
                                    </tr>
									
										<tr> 
                                      <td valign="top"> 
                                        <table class="outertable"  width="100%" border="0" cellspacing="2" cellpadding="0">
                                          <tr> 
									 
										 <td> 
                                              <div align="center"> 
                                                <input type="radio" name="cat" value="user"  style="border-style:none" checked>
                                              </div>
                                            </td>
                                            <td> User Wise 
                                              </td>
                                            <td> 
                                              <div align="center" id="b1"> 
                                                <input type="radio" name="cat" value="borrower" style="border-style:none" >
                                                </div>
                                            </td>
                                            <td><div id="b2">Borrower Wise</div></td>
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
                                  <table class="outertable linebor"  width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
                                    <tr class="dataheader"> 
                                      <td width="50%" align="center">Name</td>                                     
                                      <td width="50%"  align="center">Location</td>
                                    </tr>
                                  </table>
                                </td>
                              </tr>
                              <tr align="center" class="datagrid"> 
                            <td colspan="8"> <iframe id="result" src="" width="100%" height="240" border="no"></iframe> </td>
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
    <br>
<lapschoice:combuttonnew btnnames="Reset"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  </div>
  <input type="hidden" name="comapp_id">
  <input type="hidden" name="comapp_companyname">
  <input type="hidden" name="hidPageType" value="<%=request.getParameter("hidPageType")%>">
  <input type="hidden" name="hidSSIType" value="<%=request.getParameter("ssitype")%>">
  <input type="hidden" name="hidCategoryType" value="<%=request.getParameter("cattype")%>">
  <input type="hidden" name="hidarea4" value="">
</form>
</body>
</html>

