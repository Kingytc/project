<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />

<html>
<head>
<title>Product - Category</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/prodmaster.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var mode ="load";
var path ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var strAction ="<%=(String)objValues.get("action")%>";
var strMsg ="<%=(String)objValues.get("Msg")%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage();showMsg()" >
<form name="myfrm" method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Category Master</td>
          </tr>
        </table>
  <br>
  <br>
  <table width="90%" border="0" cellspacing="0" cellpadding="10" align="center" class="outertable border1 tableBg">
    <tr> 
      <td>
        <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
                <tr> 
                  <td valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td colspan="10"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                        <tr> 
                                          <td  colspan="2" class="dataheader">Category Master</td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                              <tr> 
                                                <td colspan="2"> 
                                                  <table width="35%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                                    <tr> 
                                                      <td width="35%">&nbsp;</td>
                                                      <td width="8%">&nbsp;</td>
                                                      <td width="10%" align="right" >&nbsp;</td>
                                                      <td width="35%">&nbsp;</td>
                                                      <td width="12%">&nbsp;</td>
                                                    </tr>
                                                    <tr> 
                                                      <td width="35%">Category</td>
                                                      <td width="8%"> 
                                                        <input type="radio" name="rad" value="radiobutton1" onClick="showFields()" style="border-style:none" maxlength="75" >
                                                      </td>
                                                      <td width="10%" align="right" >&nbsp;</td>
                                                      <td width="35%">Sub Category</td>
                                                      <td width="12%"> 
                                                        <input type="radio" name="rad" value="radiobutton2" onClick="showFields()"  style="border-style:none" maxlength="75" >
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>                                              
                                              <tr id ="subcateg" style="visibility:hidden"> 
                                                <td width="28%" id="subcatlab">Category 
                                                 </td>
                                                <td width="72%"> 
                                                  <select name="selProd" style="width:350" onChange="getValue()">
                                                    <option selected value="0">--Select--</option>
                                                    <%
											  HashMap h = new HashMap();
											  h.put("value","parent");
											  h.put("parent","0");
											  h.put("hidMethod","getProd");
											  
											  HashMap hp1 = new HashMap();
											   hp1.put("BeanId","productcat");
											   hp1.put("MethodName","getData");
											   hp1.put("BeanParam",h);
											  %>
                                                    <lapschoice:selecttag value="<%= hp1%>" /> 
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr id="categ"> 
                                                <td width="28%" id="catlab">Category 
                                                 </td>
                                                <td width="72%"> 
                                                  <input type="text" name="txtcat_name" size="75" maxlength="75"  onKeyPress="notAllowSplChar1(this)">
                                                  <b><span onClick="showProduct()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span></b> 
                                                </td>
                                              </tr>
                                              <tr id="action">
												<td width="28%">Active</td>
						                        <td width="72%"><select name="sel_active">
						                            <option value="S" selected="selected">--Select--</option>
						                            <option value="E">Enable</option>
						                            <option value="D">Disable</option>
						                            </select>
						                        </td>
												</tr>
                                              <tr > 
                                                <td width="28%">&nbsp;</td>
                                                <td width="72%">&nbsp;</td>
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
        </table>
      </td>
    </tr>
  </table>
  <br>
  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <br>
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidcat_id" >
<input type="hidden" name="hidcat_parent" value="0">
<input type="hidden" name="audit_Category">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
<br>
</body>
</html>
