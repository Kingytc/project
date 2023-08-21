<%@ include file="../share/directives.jsp"%>
<% java.util.ArrayList arrWorkid=(java.util.ArrayList)hshValues.get("prd_workid");
   java.util.ArrayList arrMaxclass=(java.util.ArrayList)hshValues.get("prd_maxclass");
   java.util.ArrayList arrDuration=(java.util.ArrayList)hshValues.get("prd_duration");
   java.util.ArrayList arrWorkflowname=(java.util.ArrayList)hshValues.get("wrk_flowname");
   String strWrkflowtype=request.getParameter("wrk_flowtype");
   int intCount=0;
   if(strWrkflowtype==null || strWrkflowtype.trim().equals(""))
   {
	   strWrkflowtype="p";
   }
   if(strWrkflowtype.equals("p"))
   {
	   intCount=1;
   }
   else if(strWrkflowtype.equals("a"))
   {
	   intCount=9;
   }
   else
   {
	   intCount=17;
   }%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/setproducts.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/setprdworkflow.js" ></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
<!--
 var val = "<%=request.getParameter("val")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
 var workid=new Array();
 var maxclass=new Array();
 var duration=new Array();
 var workname=new Array();
var strWrkflowtype ="<%=strWrkflowtype%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

 var recsize=<%=arrWorkid.size()%>;
 <%for(int j=0;j<arrWorkid.size();j++){%>
	 workid[<%=j%>]="<%=arrWorkid.get(j)%>";
     maxclass[<%=j%>]="<%=arrMaxclass.get(j)%>";
	 duration[<%=j%>]="<%=arrDuration.get(j)%>";
	 workname[<%=j%>]="<%=arrWorkflowname.get(j)%>";
<%}%>
//-->
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp()">
<form name="documentsfrm" method="post" class="normal"> 
 <lapstab:setproductstab tabid="5" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Flowpoints -&gt; 
      <%if(strWrkflowtype.equals("p")){%>In Process<%}else if(strWrkflowtype.equals("a")){%>Post Approval
      <%} else if(strWrkflowtype.equals("r")){ %> Post Rejection <%} %></td>
    </tr>
  </table>
  <div style="padding-bottom:10px;">
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                <tr> 
                  <td colspan="4" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td valign="top"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                                        <tr> 
                                          <td colspan="6"><fieldset> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" >
                                              <tr> 
                                                <td><lapschoice:products /></td>
                                              </tr>
                                            </table>
                                            </fieldset> </td>
                                        </tr>
                                        <tr> 
                                          <td colspan="6"> 
                                            <table width="37%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                              <tr > 
                                                <td align="center" <%if(strWrkflowtype.equals("p")){%>
                                                  class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b> 
                                                  <%if (!strWrkflowtype.equals("p")){%>
                                                  <a href="javascript:callFlowtype('p')"> 
                                                  <%}%>
                                                  In Process</a></b></td>
                                                <td align="center" <%if(strWrkflowtype.equals("a")){%>
                                                 class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b> 
                                                  <%if (!strWrkflowtype.equals("a")){%>
                                                  <a href="javascript:callFlowtype('a')" > 
                                                  <%}%>
                                                  Post Approval </a></b></td>
                                                <td align="center" <%if(strWrkflowtype.equals("r")){%>
                                                 class="sub_tab_active"<%} else {%>class="sub_tab_inactive"<%} %> ><b>  
                                                  <%if (!strWrkflowtype.equals("r")){%>
                                                  <a href="javascript:callFlowtype('r')" > 
                                                  <%}%>
                                                  Post Rejection </a></b></td>
                                              </tr>
                                            </table>
                                          </td>
                                        </tr>
                                      </table>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td valign="top"> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                                        <tr> 
                                          <td colspan="5" height="18"><span class="mantatory">Double 
                                            click on the cell to get the list 
                                            of Actions, then enter Minimum Class 
                                            and Duration after selecting the Action.</span></td>
                                        </tr>
                                        <tr class="dataheader"> 
                                          <td width="7%" ><div align="center">Flow point </div></td>
                                          <td width="38%"><div align="center">Action</div></td>
                                          <td width="35%"><div align="center">Minimum Class </div></td>                                         
                                          <td width="10%"><div align="center">Duration (in Days)</div></td>
                                        </tr>
                                        <tr class="datagrid"> 
                                          <td colspan="5"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">
                                              <%for(int i=intCount,j=0;i<intCount+8;i++,j++){%>
                                              <tr> 
                                                <td width="5%"  align="center"><%=i%>
                                                </td>
                                                <td width="40%"  align="center"> 
                                                    <input type="text" name="wrk_flowname" size="5" style="width:200" maxlength="200" onDblClick="callWorkflowlist(<%=j%>)" onKeyDown="doDelete(<%=j%>)">
                                                </td>
                                                <td width="35%"  align="center">
                                      <input type="hidden" name="prd_maxintclass1" size="12"  maxlength="4" disabled onKeyPress="allowInteger()" style="text-align:right">
                                      <select name="prd_maxclass">
                                        <option value="">----Select----</option>
                                	       <%String apptype="7"; %>
                				    	    <lapschoice:StaticDataNewTag apptype='<%=apptype%>'/> 
					                     </select>
					                      <input type="hidden" name="hid_prd_maxclass">                                     
                                                </td>
                                                <td width="10%" > 
                                                  <div align="center"> 
                                                    <input type="text" name="prd_duration" size="5" style="width:50;text-align:center"  maxlength="4" onKeyPress="allowInteger()" onFocus="checkFlowname(<%=j%>)">
                                                    <input type="hidden" name="prd_workid" >
                                                  </div>
                                                </td>
                                              </tr>
                                              <%}%>
                                            </table>
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
  </div>
  
  
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="wrk_flowtype">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="prdtype" value="P">
<!--  <input type ="hidden" name ="hidkeyid" value="set">-->
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
 </html>
  