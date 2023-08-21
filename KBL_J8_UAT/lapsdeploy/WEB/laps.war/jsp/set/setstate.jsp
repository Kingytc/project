<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%ArrayList v = new ArrayList();
			v = (ArrayList) hshValues.get("vecRow"); 
			String existing = request.getParameter("exist");%>
<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList g1 = new ArrayList();%>
<html>
<head>
<title>Setup-State</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var mode ="load";
var appUrl ="<%=ApplicationParams.getAppUrl()%>";
var flag="<%=Helper.correctNull((String)hshValues.get("flag"))%>";
var msg="<%=Helper.correctNull((String)hshValues.get("msg"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";

function onloading()
{	 
	if(flag=="Yes")
	{
	alert(msg);
	}
    var exist="<%=Helper.correctNull((String)request.getParameter("exist"))%>";	
    if(exist=="e")
    {
       	disableFields(true);
       	disableCommandButtons(true,true,true,true,true,false) ;
    }
    else
    {
      	disableFields(true);
      	disableCommandButtons(false,true,true,true,true,false);
    }
	document.forms[0].hidAction.value ="";
	document.forms[0].sel_active.disabled =true;
}
function selectValues(val1, val2, val3, val4, val5, val6,val7)
{	
   document.forms[0].hidstateID.value =val1;
	document.forms[0].txt_statecode.value =val2;
	document.forms[0].txt_statename.value =val3;
	document.forms[0].txt_cibilcode.value =val4;
	document.forms[0].txt_minpincode.value =val5;
	document.forms[0].txt_maxpincode.value =val6;
	document.forms[0].hidstatecode.value =val2;
	document.forms[0].sel_active.value = val7;
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmdnew.disabled =true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmddelete.disabled=false;
}
 function disableFields(val)
  {
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text')
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='radio')
		  {
			document.forms[0].elements[i].disabled=(!val);
		  }		
	 }
 }
 
function disableCommandButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled =bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmddelete.disabled=bool3;
	document.forms[0].cmdsave.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}  
 

function clearfields()
{
document.forms[0].txt_statename.value="";
	document.forms[0].txt_statecode.value="";

}
function doSave()
 {

 	if(trim(document.forms[0].txt_statename.value) == "")
 	{
 		ShowAlert(121,'State Name');
 		document.forms[0].txt_statename.focus();
 		return;
 	}
 	if(document.forms[0].txt_statecode.value=="")
 	{
 		ShowAlert(121,'State Code');
 		document.forms[0].txt_statecode.focus();
 		return;
 	}
 	if(document.forms[0].txt_cibilcode.value=="")
 	{
 		ShowAlert(121,'Cibil State Code');
 		document.forms[0].txt_cibilcode.focus();
 		return;
 	}
 	if(document.forms[0].txt_minpincode.value=="")
 	{
 		ShowAlert(121,'Pin code First two digit(MIN)');
 		document.forms[0].txt_minpincode.focus();
 		return;
 	}
 	if(document.forms[0].txt_maxpincode.value=="")
 	{
 		ShowAlert(121,'Pin code First two digit(MAX)');
 		document.forms[0].txt_maxpincode.focus();
 		return;
 	}
 		document.forms[0].cmdsave.disabled = true;
 		document.forms[0].hidRecordflag.value=varRecordFlag;
		document.forms[0].hidBeanGetMethod.value="updateStateDetails";	
		document.forms[0].hidBeanId.value="setstatecity";
		document.forms[0].action=appUrl+"action/setstate.jsp";
		document.forms[0].submit();
	
 }

  function doEdit()
  { 	
 
	disableFields(false);
	document.forms[0].hidAction.value ="Update";
	disableCommandButtons(true,true,true,false,false,true);
	if(document.forms[0].cmdedit.disabled==true)
	{
	document.forms[0].rdoUser.disabled=true;
	}
	document.forms[0].sel_active.disabled =false;
	
 }

  function doNew()
  {
	disableFields(false);
	disableCommandButtons(true,true,true,false,false,true);
	
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_active.disabled =false;
	
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='radio')
	 	{
			document.forms[0].elements[i].checked=false;
		}	  
	}
 
  clearfields();
   }

 function doCancel()
  {
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value ="";
		document.forms[0].hidBeanId.value="setstatecity";
		document.forms[0].action=appUrl+"action/setstate.jsp";
		//document.forms[0].hidBeanMethod.value="updateStateDetails";
		document.forms[0].hidMethod.value="getData";	
		document.forms[0].method="post";
		document.forms[0].submit();
		
		
		
	}
 }
 
function doDelete()
{
if (ConfirmMsg("101"))
		{
	document.forms[0].hidAction.value ="Delete";
	document.forms[0].hidBeanGetMethod.value="updateStateDetails";
	document.forms[0].hidBeanId.value="setstatecity";
	document.forms[0].hidSourceUrl.value="action/setstate.jsp";	
	document.forms[0].submit();	
	}
	
}
 
 function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].method="post";
		document.forms[0].action=appUrl+"action/setstatecity.jsp";
		document.forms[0].submit();
	}
}
 
 
 
</script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>


<body onLoad="onloading()" >
<form name="workfrm" method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td valign="top" class="page_flow">Home -&gt; Setup -&gt; State</td>
          </tr>
        </table>		
      <table width="47%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1 tableBg">
    <tr> 
      <td valign="top"> 
        
              <table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
                <tr> 
                  <td height="7"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                      <tr> 
                        <td colspan="4"> 
                          <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
                            <tr> 
                              <td colspan="10"> 
                                <table width="100%" border="0" cellspacing="0" cellpadding="0"  class="outertable">
                                  <tr> 
                                    <td> 
                                      <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                        <tr align="center" class="dataheader"> 
                                          <td colspan="2">State</td>
                                        </tr>
                                        <tr> 
                                          <td colspan="2"> 
                                            <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                                              <tr> 
                                                <td>State Name </td>
                                                <td>
                                                  <input type="text" name="txt_statename" value=""  onKeyPress="notAllowSplChar();allowAlphabetsForName();" maxlength="25" size="35" >
                                                </td>
                                              </tr>
                                              <tr> 
                                                <td>State Code </td>
                                               <td>
                                                  <input type="text" name="txt_statecode" value="" maxlength="5"  onKeyPress="notAllowSplChar();allowAlphaNumeric();" size="35" >
                                                   </td>
                                              </tr>
                                               <tr> 
                                                <td>CIBIL State Code </td>
                                                <td><input type="text" name="txt_cibilcode" value="" maxlength="2"  onKeyPress="notAllowSplChar();allowInteger();" size="35" ></td>
                                              </tr>
                                              <tr> 
                                                <td>Pin code First two digit(MIN)</td>
                                                <td><input type="text" name="txt_minpincode" value="" maxlength="2"  onKeyPress="notAllowSplChar();allowInteger();" size="35" ></td>
                                              </tr>
                                              <tr>
                                                <td>Pin code First two digit(MAX)</td>
                                                <td><input type="text" name="txt_maxpincode" value="" maxlength="2"  onKeyPress="notAllowSplChar();allowInteger();" size="35" ></td>
                                              </tr>
                                              <tr>
												<td>Active</td>
					                        <td><select name="sel_active">
					                            <option value="E" selected="selected">Enable</option>
					                            <option value="D">Disable</option>
					                            </select> </td>
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
  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
  <br>
  <table width="60%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
    <tr >
										<td>
        <table width="97%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
          <tr class="dataheader">                                     
            <td align="center">&nbsp;</td>                                    
            <td align="center"><b>State Name </b></td>                                    
            <td align="center"><b>State Code</b></td>
          </tr>								                                  
          <%v = (ArrayList) hshValues.get("vecRow");
			String inside = "N";
			if (v != null) {
				int vecsize = v.size();
				for (int l = 0; l < vecsize; l++) {
					g1 = (ArrayList) v.get(l);%>
            <tr class="datagrid">                                      
              <td align="center" > 
  <input type="radio" name="rdoUser" style="border-style:none" onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
                                            '<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>'
                                            ,'<%=Helper.correctNull((String)g1.get(3))%>','<%=Helper.correctNull((String)g1.get(4))%>'
                                            ,'<%=Helper.correctNull((String)g1.get(5))%>','<%=Helper.correctNull((String)g1.get(6))%>')">
                 </td>
                                      
              <td ><%=Helper.correctNull((String)g1.get(2))%></td>
                                      
              <td ><%=Helper.correctNull((String)g1.get(1))%></td>
                                      
                                    </tr>
                                    <%}
			}%>
                                   
                                    <!--  <tr class="datagrid"> 
                                      
              <td align="center">&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
                                    </tr>
                                    <tr class="datagrid"> 
                                      
              <td align="center">&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
                                    </tr>
                                    <tr class="datagrid"> 
                                      
              <td align="center">&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
                                    </tr>
                                    <tr class="datagrid"> 
                                      
              <td align="center">&nbsp;</td>
                                      
              <td  width="35%">&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
                                    </tr>
                                    <tr class="datagrid"> 
                                      
              <td align="center">&nbsp;</td>

                                      
              <td >&nbsp;</td>
                                      
              <td >&nbsp;</td>
                                      
                                    </tr>-->
                                  </table>
								<br>
								<br>
  
  

<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidstateID" value="<%=Helper.correctNull((String)hshValues.get("state_id"))%>">
<input type="hidden" name="hidstatecode" >
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>
