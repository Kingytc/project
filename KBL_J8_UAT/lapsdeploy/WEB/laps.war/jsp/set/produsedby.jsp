<%@ include file="../share/directives.jsp"%>
<html>
<head>
<title>Setup(Products)</title>
<script language="JavaScript">
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var val = "<%=request.getParameter("val")%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
<%
	HashMap hshSelNames = (HashMap)hshValues.get("OrgSelNames");
	int len = hshSelNames.size(); 
	out.println("var arrSelNames = new Array("+len+");");
	out.println("var arrSelKeys = new Array("+len+");");

	Iterator iterator =(hshSelNames.keySet()).iterator();
	int i=0;
	while(iterator.hasNext())
	{
		String strTmp = (String) iterator.next();
		out.println("arrSelNames["+i+"] = '"+hshSelNames.get(strTmp)+"';");
		out.println("arrSelKeys["+i+"] = '"+strTmp+"';");
		i++;
	}

	HashMap hshNames = (HashMap)hshValues.get("OrgNames");
	out.println("var arrNames = new Array();");
	out.println("var arrKeys = new Array();");
	iterator = (hshNames.keySet()).iterator();
	i=0;
	while(iterator.hasNext())
	{
		String strTmp = (String) iterator.next();
		out.println("arrNames["+i+"] = '"+Helper.replaceForJavaScriptString((String)hshNames.get(strTmp))+"';");
		out.println("arrKeys["+i+"] = '"+strTmp+"';");
		i++;
	}%>
 
	function setData()
	{
		setButtons();
		code = '<%= hshValues.get("prd_code") %>';
		level = '<%= hshValues.get("prd_org_level") %>';
		scode = '<%= hshValues.get("prd_org_scode") %>';
		prdint = '<%= hshValues.get("prd_internet") %>';

		setOptions(level);
		for(i=0;i<arrSelNames.length;i++)
		{
			document.prdusedfrm.seldInsti.options[i] = new Option(arrSelNames[i],arrSelKeys[i]);
		}		
	}
</script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/produsedby.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head> 
<body onLoad="setData();loadUsedApp()">
<form name="prdusedfrm" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">  
<lapstab:setproductstab tabid="2" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
    <tr>
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Used By</td>
    </tr>    
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" class="outertable" align="center">
          <tr> 
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="2" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                      <tr> 
                        <td valign="top"> <fieldset> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                            <tr> 
                              <td> <lapschoice:products /></td>
                            </tr>
                          </table>
                          </fieldset> </td>
                      </tr>
                    </table>
                    <br>
                    <table width="98%" border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
      <td>
                    <table width="100%" border="0" cellspacing="0" cellpadding="6" class="outertable">
                      <tr> 
                        <td colspan="3"><b>Select Organisation Level</b></td>
                        <td width="9%">&nbsp;</td>
                        <td width="9%">&nbsp;</td>
                        <td width="9%">&nbsp;</td>
                        <td width="10%">&nbsp;</td>
                        <td width="9%">&nbsp;</td>
                        <td width="9%">&nbsp;</td>
                        <td width="18%">&nbsp;</td>
                      </tr>
                      <tr> 
                        <% if( !( ((String)hshValues.get("orgname1")).trim()).equals("") ){%>
                        <td width="8%"> 
                          
						  	<input type="hidden" name="hidOrgName1" value="<%= hshValues.get("orgname1")%>">	
                            <input type="radio" name="radioOrg" value="C" disabled="true" style=" border-style: none" onClick="setOptions('C')">
   	                   </td>
                        <td width="10%"> <%= hshValues.get("orgname1")%> 
                           </td>
                        <%}if( !(((String)hshValues.get("orgname2")).trim()).equals("") ){%>
                        <td width="9%"> 
                           
						  <input type="hidden" name="hidOrgName2" value="<%= hshValues.get("orgname2")%>">
                            <input type="radio" name="radioOrg" value="R"  disabled="true" style=" border-style: none" onClick="setOptions('R')">
                            
                        </td>
                        <td width="9%"> 
                          <div ><%= hshValues.get("orgname2") %></div>
                        </td>
                        <%}if( !(((String)hshValues.get("orgname3")).trim()).equals("") ){%>
                        <td width="9%">                            
						  <input type="hidden" name="hidOrgName3" value="<%= hshValues.get("orgname3")%>">
                            <input type="radio" name="radioOrg" value="D"  disabled="disabled" style=" border-style: none" onClick="setOptions('D')">                            
                        </td>
                        <td width="9%"> <%= hshValues.get("orgname3") %> 
                           </td>
                        <%}if( !(((String)hshValues.get("orgname4")).trim()).equals("") ){%>
                        <td width="10%"> 
						 <input type="hidden" name="hidOrgName4" value="<%= hshValues.get("orgname4")%>">
                          
                            <input type="radio" name="radioOrg" value="A"
								 disabled="disabled" style=" border-style: none" onClick="setOptions('A')">                            
                        </td>
                        <td width="9%"><%= hshValues.get("orgname4") %></td>
                        <%}if( !( ((String)hshValues.get("orgname5")).trim()).equals("") ){%>
                        <td width="9%">                           
						  <input type="hidden" name="hidOrgName5" value="<%= hshValues.get("orgname5")%>">
                            <input type="radio" name="radioOrg" value="B"
								disabled="disabled" style=" border-style: none" onClick="setOptions('B')">                            
                        </td>
                        <td width="18%"> <%= hshValues.get("orgname5") %> 
                           </td>
                        <%}%>
                      </tr>
                      <tr valign="top"> 
                        <td colspan="10"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" height="100%" class="outertable" >
                            <tr> 
                              <td> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                                  <tr> 
                                    <td width="18%">&nbsp;</td>
                                    <td colspan="3"> 
                                      <table width="46%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                        <tr> 
                                          <td><font color="#CC0000">Double click to select Institution</font></td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="18%" valign="top">&nbsp;</td>
                                    <td width="20%" valign="top">Select the&nbsp;Institution&nbsp;</td>
                                    <td width="15%" valign="top">&nbsp;</td>
                                    <td width="47%">Selected&nbsp;Institution</td>
                                  </tr>
                                  <tr> 
                                    <td width="18%" valign="top"> 
                                      &nbsp;
                                    </td>
                                    <td width="20%" valign="top">  
                                      <select name="selInsti" size="8" style="width:250" onDblClick="javascript:selectedProduct()">
                                      </select>
                                       </td>
                                    <td width="15%" valign="top"> 
                                      <div align="right">&nbsp;</div>
                                    </td>
                                    <td width="47%">  
                                      <select name="seldInsti" size=8 style="width:250;"  onDblClick="checkRemove()" multiple>
                                      </select>
                                      <br>
                                       
                                      <div align="center"></div>
                                    </td>
                                  </tr>
                                  <tr>
                                    <td colspan="3" valign="top" align="center">&nbsp;</td>
                                    <td width="47%" valign="top">&nbsp;</td>
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
  </td>
  </tr>
  </table><br>
 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="hidSeldInsti" value="" > 
<input type=hidden name="sch_code" value="">
<input type=hidden name="seldInsti1">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
  