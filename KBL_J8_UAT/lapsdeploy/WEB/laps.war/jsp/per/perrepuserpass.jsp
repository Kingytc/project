<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>DOVE</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js">
</script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/per/perrepuserpass.js">
</script>
<script>
var path="<%=ApplicationParams.getAppUrl()%>";
var bnkname="";
var param="";
var userid ="<%=(String)session.getAttribute("strUserId")%>";
var rights ="<%=(String)session.getAttribute("strGroupRights")%>";

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>

<body>
<form name="orgfrm" method="post" class="normal">
<iframe  height="0" width="0" id="ifrm" frameborder=0 style="border:0" ></iframe> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td>Home-&gt; Retail -&gt; Reports -&gt; User Details
     </td>
    </tr>
    <tr> 
      <td align="right">&nbsp; </td>
    </tr>
  </table>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="middle">     
          <table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1 tableBg">
            <tr> 
              <td> 
                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
                  <tr> 
                    <td width="71%">
                      
                      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                        <tr align="center" class="dataheader"> 
                          <td align="center" colspan="2">Organisation 
                            Level</td>
                        </tr>
                        <tr align="center"> 
                          <td align="center" colspan="2"> 
                            <select name="sellevel" style="width:100"  onChange="selectValues()" >
                              <option selected value="select">---Select---</option>
                              <lapschoice:reptag beanid="setupreport" methodname="getLevels" param="" /> 
                            </select>
                           </td>
                        </tr>
                        <tr align="center" class="dataheader"> 
                          <td align="center">Select 
                            Organisation</td>
                          <td align="center">Select 
                            Output Fields</td>
                        </tr>
                        <tr align="center"> 
                          <td> 
                            <select name="rpselect1" size="11" style="width:150" multiple>
                            </select>
                           </td>
                          <td> 
                            <select name="rpselect2" size="11" style="width:150" multiple>
                              <option value="usr_fname as usr_name" >User Name 
                             </option>
                              <option value="usr_id">Employee ID</option>
                              <option value="org_name">Organisation Name
                             </option>
                              <option value="grp_name">Group Name
                             </option>
                              <option value="usr_class">Class
                             </option>
                              <option value="usr_avail">Availablity
                             </option>
                            </select>
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
 <lapschoice:combuttonnew btnnames='Run Report_Reset' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
    <lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidOrgCode"  >
<input type="hidden" name="txtDate"  >
<input type="hidden" name="hidOpFields"  >
<input type="hidden" name="hidSelFields">
<input type="hidden" name="repname" value ="Personal User Details Report">
<input type="hidden" name="txtprofile_name" >
<input type="hidden" name="hidPage" value="perrepuserclass.jsp">
<input type="hidden" name="txtSaveDate" value='<%=Helper.getCurrentDateTime()%>'>
</form>
</body>
</html>
