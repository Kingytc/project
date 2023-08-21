<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<%

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	if (hshValues != null) 
	{
		arrRow = (ArrayList) hshValues.get("arrRow");
	}
	int intarrSize1=0;
	if(arrRow!=null)
	{
		intarrSize1=arrRow.size();
	}
%>
<title>Security Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script  LANGUAGE="JavaScript">
var path ="<%=ApplicationParams.getAppUrl()%>";
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var strAction ="<%=(String)objValues.get("action")%>";

function loadPage(){

	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = true;
	}
	
	document.forms[0].cmdnew.disabled = false;
	document.forms[0].cmdedit.disabled = false;
	document.forms[0].cmdclose.disabled = false;
	try{
		document.forms[0].cmdaudittrail.disabled = true; 
			}catch(e){
			}
	document.forms[0].rad[0].disabled = true;
	document.forms[0].rad[1].disabled = false;
	document.forms[0].rad[1].checked = true;
	document.forms[0].txtsec_type.value="";
	showFields();	

	/*if(document.forms[0].rad[0].selected=true){
		document.forms[0].hidinstype.value="type";
	}
	
	if(document.forms[0].rad[1].selected=true){
		document.forms[0].hidinstype.value="list";
	}*/
	
}

function showFields()
{
	if (document.forms[0].rad[0].checked == true)
	{
	  	document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="hidden";
		catLabel();

	}
	else
	{
		document.all.categ.style.visibility ="visible";   
		document.all.subcateg.style.visibility="visible";
		catLabel();
		document.forms[0].selSecType.selectedIndex =0;
	}
	document.forms[0].txtsec_type.value="";
}


function getValue()
{
	
}
function catLabel()
{
	if(document.forms[0].rad[1].checked==true)
	{
		document.all.catlab.innerHTML="Security Classification";
	}
	else if(document.forms[0].rad[0].checked==true)
	{
		document.all.catlab.innerHTML="Type";
	}
}

function checkVal(){
	
	if(document.forms[0].selSecType.selectedIndex == 0){
		alert("Select Security Type");
		document.forms[0].txtsec_type.value="";
		document.forms[0].selSecType.focus();
	}
}

function showSecurities(){
	 if(document.forms[0].cmdedit.disabled){

			for (i=0;i<document.forms[0].elements.length;i++)
			{
				document.forms[0].elements[i].disabled = false;
			}
			
	if(mode=="edit"){
		if (document.forms[0].selSecType.selectedIndex == 0)
	   	{
			ShowAlert("111","Security Type");
			document.forms[0].selSecType.focus();
	   	}
		else{
			var type=document.forms[0].selSecType.value;
			var purl = "<%=ApplicationParams.getAppUrl()%>action/securitylist.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getSecurityMaster&secType="+type;		
			var title = "ListofSecurities";
			var prop = "scrollbars=no,width=600,height=400";	
			var xpos = (screen.width - 600) / 2;
			var ypos = (screen.height - 400) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,title,prop);
			callDisableControls(true,true,false,false,false,true);
		}
	}	

	callDisableControls(true,true,false,false,false,true);
	document.forms[0].rad[0].disabled = true;
	document.forms[0].selSecType.disabled = false;
	 }
}
function callDisableControls(cmdNew,cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
	document.forms[0].cmdnew.disabled=cmdNew;
	document.forms[0].cmdedit.disabled=cmdEdit;
	document.forms[0].cmdsave.disabled=cmdSave;
	document.forms[0].cmddelete.disabled=cmdDelete;
	document.forms[0].cmdcancel.disabled=cmdCancel;
	document.forms[0].cmdclose.disabled=cmdClose;
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}	
}

function doCancel()
{
   	if (ConfirmMsg("102"))
   	   	
   	{
   		for (i=0;i<document.forms[0].elements.length;i++)
   		{
   			document.forms[0].elements[i].disabled = false;
   		}
   		
   		document.forms[0].hidBeanGetMethod.value="getSecurityMaster";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].action=appURL+"action/setsecuritymaster.jsp";	
		document.forms[0].submit();
   	}
}

function doNew()
{
	mode="new";
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,true,false,true);
	document.forms[0].selSecType.disabled = false;
	document.forms[0].txtsec_type.disabled = false;
	document.forms[0].sel_cbssecurity.disabled = false;
	document.forms[0].sel_collatflag.disabled = false;
	document.forms[0].sel_weathliquid.disabled = false;
	document.forms[0].sel_Action.disabled = false;
	
	
}

function doEdit()
{  
	mode="edit";
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="update";	
    callDisableControls(true,true,false,false,false,false);
	document.forms[0].selSecType.disabled = false;
	document.forms[0].sel_cbssecurity.disabled = false;
	document.forms[0].sel_collatflag.disabled = false;
	document.forms[0].sel_weathliquid.disabled = false;
	document.forms[0].sel_Action.disabled = false;
}

function doSave()
{
	
	if(document.forms[0].selSecType.value=="0")
	{
		alert("Select Security Type");
		return;
	}
	if(document.forms[0].txtsec_type.value=="")
	{
		alert("Enter Security Classification");
		return;
	}
	if(document.forms[0].sel_cbssecurity.value=="")
	{
		alert("Select CBS Security Codes");
		return;
	}
	if(document.forms[0].sel_Action.value=="")
	{
		alert(" Select Action");
		return;
	}
	
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="securitymaster";
	//document.forms[0].hidBeanMethod.value="updateSecurityMaster";
    document.forms[0].hidBeanGetMethod.value="updateSecurityMaster";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setsecuritymaster.jsp";
	document.forms[0].method="post";
	
	//document.forms[0].action=appURL+"action/setsecuritymaster.jsp";	
	document.forms[0].submit();
}

function doDelete()
{

	if(ConfirmMsg(101))
	{

		for (i=0;i<document.forms[0].elements.length;i++)
		{
			document.forms[0].elements[i].disabled = false;
		}
		
     	document.forms[0].hidAction.value="delete";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].hidBeanMethod.value="updateSecurityMaster";
	    document.forms[0].hidBeanGetMethod.value="getSecurityMaster";
		document.forms[0].hidSourceUrl.value="/action/setsecuritymaster.jsp";
		document.forms[0].submit();
	}

}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage();" >
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Other Setup &amp;  Security Master</td>
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
                                          <td  colspan="2" class="setuphead">Security Master</td>
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
                                                      <td width="35%">Security Type</td>
                                                      <td width="8%"> 
                                                        <input type="radio" name="rad" value="radiobutton1" onClick="showFields()" style="border-style:none" maxlength="75" >
                                                      </td>
                                                      <td width="10%" align="right" >&nbsp;</td>
                                                      <td width="35%">Security Classification</td>
                                                      <td width="12%"> 
                                                        <input type="radio" name="rad" value="radiobutton2" onClick="showFields()"  style="border-style:none" maxlength="75" >
                                                      </td>
                                                    </tr>
                                                  </table>
                                                </td>
                                              </tr>                                              
                                              <tr id ="subcateg" style="visibility:hidden"> 
                                                <td width="28%" id="subcatlab">Security Types 
                                                 </td>
                                                <td width="72%"> 
                                                  <select name="selSecType" style="width:350" onChange="getValue()">
                                                    <option selected value="0">--Select--</option>
                                                    <%  intarrSize1= 0;
														if(arrRow!=null&&arrRow.size()>0){
															intarrSize1=arrRow.size();
					  										for(int i=0;i<intarrSize1;i++){			   	
														    arrCol=(ArrayList)arrRow.get(i);
												   %>
												   <option value="<%=Helper.correctNull((String)arrCol.get(0))%>"><%=Helper.correctNull((String)arrCol.get(1))%></option>
												   <%}} %>
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr id="categ"> 
                                                <td width="28%" id="catlab">Security Types 
                                                 </td>
                                                <td width="72%"> 
                                                  <input type="text" name="txtsec_type" size="75" style="width:350" maxlength="75"  onKeyPress="notAllowSplChar1(this);" onBlur="checkVal()">
                                                  <b><span onClick="showSecurities()" style="cursor:hand"><img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
												 border="0"></span></b> 
                                                </td>
                                              </tr>
                                             <tr>
													<td width="28%%">CBS Security Codes</td>
													<td  width="72%">
														<select name="sel_cbssecurity" style="width:350">
														<option value="">--Select--</option>
														<lapschoice:CBSStaticDataNewTag apptype="25"/>
														</select>
													</td>
											   </tr > 
											   <tr>
													<td width="28%%">Whether given as Collateral</td>
													<td  width="72%">
														<select name="sel_collatflag">
														<option value="S">--Select--</option>
														<option value="Y">Yes</option>
														<option value="N">No</option>														
														</select>
													</td>
											   </tr > 
											   <tr>
		
		 <td>Whether Liquid Security</td>
		 <td><select name="sel_weathliquid">
		 <option value="">--Select--</option>
		 <option value="Y">Yes</option>
		 <option value="N">No</option>
		 </select></td></tr>
		 
		  <tr>
                     <td>Action<span class="mantatory">*</span></td>
                     <td><select name="sel_Action">
                     <option value="">--Select--</option>
                     <option value="E">Enabled</option>
                     <option value="D">Disabled</option></select></td>
                     </tr>
                                                <td width="28%">&nbsp;</td>
                                                <td width="72%">&nbsp;</td>
                                         
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
  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
  <lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidinstype" value="">
</form>
</body>
</html>