<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<title>Product- Workflow</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/set/workflowmas.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var mode ="load";
var path ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var strAction ="<%=(String)objValues.get("action")%>";
var strMsg ="<%=(String)objValues.get("Msg")%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="loadPage();showMsg()" >
<form name="workfrm" method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">       
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Workflow Master </td>
          </tr>
        </table>
  <br>
  <table width="90%" border="0" cellspacing="0" cellpadding="15" align="center" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable border1 tableBg">
          <tr> 
            <td>
              <table width="100%" border="0" cellspacing="0" cellpadding="0" height="8" align="center" class="outertable">
                <tr> 
                  <td height="7"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="4" height="2"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td colspan="10"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" height="67" class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                        <tr align="center" class="dataheader"> 
                                          <td  colspan="2"><b>Workflow Master </b></td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="10" class="outertable">
                                              <tr> 
                                                <td>Workflow Type</td>
                                                <td> 
                                                  <select name="selwork" style="width:115" onChange="getValue()">
                                                    <option selected>----Select----</option>
                                                    <option value="p">In Process</option>
                                                    <option value="a">Post Approval</option>
                                                    <option value="r">Post Rejection</option>
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>Workflow Action</td>
                                                <td> 
                                                  <input type="text" maxlength =75 size = 70 name="txtwrk_flowname"onBlur="JavaScript:this.value =trim(this.value)" onkeypress="notAllowSingleQuote();notAllowSplChar1(this)">
                                                 <span onClick="showProduct()" style="cursor:hand" id="help"> <b><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></b> </span>
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
      </td>
    </tr>
  </table>
  <br>
   <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidwrk_flowid" >
<input type="hidden" name="hidwrk_flowtype" >
<input type ="hidden" name ="hidkeyid" value="set">
</form>
<br>
</body>
</html>
