<%@ include file="../share/directives.jsp"%>
<%
//out.println(hshValues);
ArrayList arrAppDocCode = new ArrayList();
ArrayList arrAppDocDesc = new ArrayList();
ArrayList arrAppDocDate = new ArrayList();
ArrayList arrAppDocMand = new ArrayList();
ArrayList arrIntDocCode = new ArrayList();
ArrayList arrIntDocDesc = new ArrayList();
ArrayList arrIntDocDate = new ArrayList();
ArrayList arrIntDocMand = new ArrayList();

  if ( (hshValues.get("appdoccode")) != null)
{
    arrAppDocCode=(ArrayList)hshValues.get("appdoccode");
}
if ( (hshValues.get("appdocdesc")) != null)
{
   arrAppDocDesc=(ArrayList)hshValues.get("appdocdesc");
}
if ( (hshValues.get("appdocdate")) != null)
{
    arrAppDocDate=(ArrayList)hshValues.get("appdocdate");
}
if ( (hshValues.get("appdocmand")) != null)
{
	arrAppDocMand=(ArrayList)hshValues.get("appdocmand");
}


if ( (hshValues.get("intdoccode")) != null)
{
    arrIntDocCode=(java.util.ArrayList)hshValues.get("intdoccode");
}
 if ( (hshValues.get("intdocdesc")) != null)
{
   arrIntDocDesc=(ArrayList)hshValues.get("intdocdesc");
}
if ( (hshValues.get("intdocdate")) != null)
{
   arrIntDocDate=(ArrayList)hshValues.get("intdocdate");
}  
if ( (hshValues.get("intdocmand")) != null)
{
	arrIntDocMand=(ArrayList)hshValues.get("intdocmand");
}
String strModuleType=Helper.correctNull((String)hshValues.get("prdType"));
strModuleType=strModuleType.substring(0,3);


%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js" >
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js" >
</script>
 
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/setprddoc.js" >
</script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>

 var val = "<%=request.getParameter("val")%>";
 var appUrl="<%=ApplicationParams.getAppUrl()%>";
 var appdoccode=new Array();
 var appdocdesc=new Array();
 var appdocdate=new Array();
  var appdocmand=new Array();
 var intdoccode=new Array();
 var intdocdesc=new Array();
 var intdocdate=new Array();
  var intdocmand=new Array();
var ModuleType="<%=strModuleType%>";

 var applen=<%=arrAppDocCode.size()%>;
 var intlen=<%=arrIntDocCode.size()%>;
 
 <%
   for(int k1=0;k1<arrAppDocCode.size();k1++){
 %>
	 appdoccode[<%=k1%>]="<%=arrAppDocCode.get(k1)%>";
     appdocdesc[<%=k1%>]="<%=arrAppDocDesc.get(k1)%>";
	 appdocdate[<%=k1%>]="<%=arrAppDocDate.get(k1)%>";
	 appdocmand[<%=k1%>]="<%=arrAppDocMand.get(k1)%>";
<%
 }
%>
<%
   for(int k2=0;k2<arrIntDocCode.size();k2++){
 %>
	 intdoccode[<%=k2%>]="<%=arrIntDocCode.get(k2)%>";
     intdocdesc[<%=k2%>]="<%=arrIntDocDesc.get(k2)%>";
	 intdocdate[<%=k2%>]="<%=arrIntDocDate.get(k2)%>";
	 intdocmand[<%=k2%>]="<%=arrIntDocMand.get(k2)%>";
<%
 }
%>

//alert(appdocmand);

	





</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues();loadUsedApp()">
<form name="documentsfrm" method="post" class="normal">
<lapstab:setproductstab tabid="4" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
  <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable linebor">
    <tr> 
      <td class="page_flow">Home -&gt;
        Setup -&gt; Retail &amp; Agriculture Products -&gt;  
        Products -&gt; Documents</td>
    </tr>
  </table>
  
 <%-- 
  <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="2" cellpadding="3" align="left">
          <tr> 
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font color="#FFFFFF" size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setproducts.jsp')" class="blackfont">Products</a></b></font></td>
            <td height="2" width="9%" align="center" bgcolor="#EEEAE3"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF"><a href="javascript:callOtherTab('produsedby.jsp')" class="blackfont">Used 
              By</a></font></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdauth.jsp')" class="blackfont">Authority</a></b></font></td>
            <td height="2" width="10%" bgcolor="#71694F" align="center"><font size="1" face="MS Sans Serif"><b><font color="#FFFFFF">Documents</font></b></font></td>
            <td height="2" width="11%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setprdworkflow.jsp')" class="blackfont">Flowpoints</a></b></font></td>
            <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodprocesscharges.jsp')" class="blackfont">Charges 
              </a></b></font></td>
            <td nowrap height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodsanclimit.jsp')" class="blackfont">Delegated Powers</a></b></font></td>
            <td height="2" width="13%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('setintterms.jsp')" class="blackfont">Int. 
              &amp; Terms</a></b></font></td>
         
           <!-- <td height="2" width="10%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('proddisbursement.jsp')" class="blackfont">Disbursement 
              </a></b></font></td>-->
			<td height="2" width="19%" bgcolor="#EEEAE3" align="center"><font size="1" face="MS Sans Serif"><b><a href="javascript:callOtherTab('prodinterest.jsp')" class="blackfont">Repayment 
              Capacity</a></b></font></td>
		  
		  </tr>
        </table>
      </td>
    </tr>
  </table>
  --%>
  <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center" >
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
          <tr> 
            <td height="7"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="4" height="239" valign="top"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td colspan="10" valign="top"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr valign="top"> 
                              <td colspan="4"> <fieldset>
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                  <tr> 
                                    <td><lapschoice:products /></td>
                                  </tr>
                                </table></fieldset><br>
                              </td>
                            <tr> 
                              <td width="35%" ><span class="mantatory">Click 
                                on 'Existing' button to select documents </span></td>
                              <td colspan="3" ></td>
                            </tr>
                            <tr> 
                              <td width="35%" height="29" > &nbsp;Document 
                                  Category - Applicant
                             
                              <!-- <td width="15%" height="29" align="left">  -->
                                
                                  <input type=button name=appdoclist onClick="callDocList('a')" value="Existing" disabled class="buttonstyle">
                                
								   </td>
                             <!--  </td> -->
                              <td width="32%" height="29"> Document 
                                  Category - &nbsp;Bank
                           
                               
                                  <input type=button name=intdoclist  onClick="callDocList('i')" value="Existing" disabled class="buttonstyle">
                                
                              </td>
                            </tr>
                            <tr> 
                              <td colspan="4" height="20">  
                                <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                  <tr> 
                                    <td colspan="2" height="2" valign="top"> 
                                      <div class="cellContainer"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                          <tr> 
                                            <td height="10" valign="top"> 
                                              <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                                <tr> 
                                                  <td width="25%" align="center">&nbsp;</td>
                                                  <td width="73%" valign="top" align="center">&nbsp;</td>
                                                  <td width="73%" valign="top" align="center" nowrap>Mandatory 
                                                    Document ?</td>
                                                </tr>
                                                <% for(int i=1;i<=40;i++){ %>
                                                <tr> 
                                                  <td width="25%" align="center"><%=i%> 
                                                  </td>
                                                  <td width="75%" valign="top" align="center"> 
                                                    <input type="hidden"  name="adoc_mand1" >
                                                    <input type="text" name="adoc_desc" tabindex="0"  style="width:300" onKeyDown="allowDelete(this)" disabled>
                                                    <input type="hidden"  name="adoc_code" >
                                                    <input type="hidden"  name="adoc_date" >
                                                  </td>
                                                  <td width="75%" valign="top" align="center"> 
                                                    <input type="checkbox" name="adoc_mand" value="N" disabled style="border:none">
                                                  </td>
                                                </tr>
                                                <%}%>
                                              </table>
                                            </td>
                                          </tr>
                                        </table>
                                      </div>
                                    </td>
                                    <td colspan="2" height="2" valign="top" width="51%"> 
                                      <div class="cellContainer"> 
                                        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                                          <tr> 
                                            <td height="87" valign="top"> 
                                              <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                                                <tr> 
                                                  <td width="25%" align="center">&nbsp;</td>
                                                  <td width="75%" valign="top" align="center">&nbsp;</td>
                                                  <td width="75%" valign="top" align="center"nowrap>Mandatory 
                                                    Document ? </td>
                                                </tr>
                                                <% for(int j=1;j<=40;j++) {%>
                                                <tr> 
                                                  <td width="25%" align="center"><%=j%> 
                                                  </td>
                                                  <td width="75%" valign="top" align="center"> 
                                                    <input type="hidden"  name="idoc_mand1" >
                                                    <input type="text" name="idoc_desc" style="width:300" onKeyDown="allowDelete(this)" disabled>
                                                    <input type="hidden"  name="idoc_code" >
                                                    <input type="hidden"  name="idoc_date" >
                                                  </td>
                                                  <td width="75%" valign="top" align="center">
                                                    <input type="checkbox" name="idoc_mand" value="N" disabled style="border:none">
                                                  </td>
                                                </tr>
                                                <%}%>
                                              </table>
                                            </td>
                                          </tr>
                                        </table>
                                      </div>
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
 <lapschoice:combuttonnew btnnames="Edit_Save_Cancel"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
</form>
</body>
</html>
  

