<%@ include file="../share/directives.jsp"%>
<% int size=0;
ArrayList vecData=new ArrayList();
ArrayList vecDatag=new ArrayList();
if(hshValues!=null)
{
	vecData = (ArrayList) hshValues.get("vecData");
	if(vecData!=null)  
	{
		size=vecData.size();
	}
	vecDatag = (ArrayList) hshValues.get("vecDatagroup");
}
%>
<html>
<head>
<title>Setup(Products - Sanction Limit)</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/prodsanclimit.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script language="JavaScript">
 var val = "<%=request.getParameter("val")%>";
var path="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="setData();loadUsedApp()">
<form name="prdsanclimit" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">  
<lapstab:setproductstab tabid="7" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Delegated Powers</td>
    </tr>
  </table><br>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="4"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="10"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td> <fieldset> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td> <lapschoice:products /> </td>
                                  </tr>
                                </table>
                                </fieldset></td>
                            </tr>
                            <tr> 
                              <td align="center"><br>
                                <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable" >
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellpadding="3" cellspacing="0" align="center" class="outertable">
                                        <tr class="dataheader" align="center"> 
                                          <td width="13%">S.No</td>
                                          <td width="40%">User Designation</td>
                                          <td width="47%">Powers(Rs.)</td>
                                        </tr>
                                        <%if(size>0){
							if(vecData!=null)
							{
								for(int i=0;i<size;i++)
								{
									ArrayList vecVal = (ArrayList)vecData.get(i);
									String strSancClass=Helper.correctNull((String)vecVal.get(0));
									String strSancLimit=Helper.correctNull((String)vecVal.get(1));
									String strSancDesig=Helper.correctNull((String)vecVal.get(2));%>
                                        <tr class="datagrid"> 
                                          <td width="13%"  align="center"> 
                                            <%=i+1%>
                                          </td>
                                          <td width="40%" align="center">
                                              <input type="hidden" name="txtsanc_class" size="15" readonly value="<%=strSancClass%>">
										      <input type="text" name="txtsanc_desig" size="50"  value="<%=strSancDesig%>" readOnly>
                                          </td>
                                          <td width="47%" align="center"> 
                                           	<lapschoice:CurrencyTag name="txtsanc_limit" 	maxlength="13" size="15" value='<%=strSancLimit%>' onBlur="roundtxt(this);"/>
                                          </td>
                                       </tr>
                                 <%}}}else{	 						
							if(vecDatag!=null)
							{
								for(int i=0;i<vecDatag.size();i++)
								{
									ArrayList vecVal = (ArrayList)vecDatag.get(i);
									String strSancClass=Helper.correctNull((String)vecVal.get(0));
									String strSancDesig=Helper.correctNull((String)vecVal.get(1));%>
                                        <tr class="datagrid"> 
                                          <td width="13%" align="center"> 
                                            <%=i+1%> 
                                          </td>
                                          <td width="40%" align="center">
                                              <input type="hidden" name="txtsanc_class" size="15" readonly value="<%=strSancClass%>">
										      <input type="text" name="txtsanc_desig" size="50"  value="<%=strSancDesig%>" readOnly>
                                          </td>
                                          <td width="47%" align="center"> 
										   <lapschoice:CurrencyTag name="txtsanc_limit" maxlength="13"
											size="15" onBlur="roundtxt(this);"/>
										  </td>
                                        </tr>
                                        <%}}}%>							
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
 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type=hidden name="hidSeldInsti" value="">
  <input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
  <input type="hidden" name="hideditflag">
  <input type="hidden" name="prd_code" value="<%=Helper.correctNull((String)request.getParameter("prdCode")) %>"/>
  <input type="hidden" name="prd_choose" value="<%=request.getParameter("prd_choose")%>">
  <input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
  <input type="hidden" name="hidPage" value="prdDelegate">
</form>
</body>
</html>
