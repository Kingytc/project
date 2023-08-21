<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<%
//out.println("hshValues========"+hshValues);
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
	String strStatId=Helper.correctNull((String)hshValues.get("strStatId"));
	String strStatsno=Helper.correctNull((String)hshValues.get("stat_data_sno"));
	if(strStatsno=="")
	{
		strStatsno="0";
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
var statno=<%=strStatsno%>;
function loadPage(){

	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = true;
	}
	
	document.forms[0].cmdnew.disabled = false;
	//document.forms[0].cmdedit.disabled = false;
	disableFieldsradio(true);
	document.forms[0].cmdclose.disabled = false;
	try{
		document.forms[0].cmdaudittrail.disabled = true; 
			}catch(e){
			}
			
	//showFields();	
//	alert("statno===="+statno);
// 	if(statno>1)
// 	{
	
<%-- 	document.forms[0].radiobutton[<%=strStatsno%>-1].checked=true;  --%>
// 	}
// 	if(statno=="1")
// 	{
	
// 	document.forms[0].radiobutton.checked=true;
// 	}
// 	if(statno=="0")
// 	{
	
// 	document.forms[0].radiobutton.checked=true;
// 	}
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



function catLabel()
{
// 	if(document.forms[0].rad[1].checked==true)
// 	{
// 		document.all.catlab.innerHTML="Security Classification";
// 	}
// 	else if(document.forms[0].rad[0].checked==true)
// 	{
// 		document.all.catlab.innerHTML="Type";
// 	}
}

function checkVal(){
	
// 	if(document.forms[0].selSecType.selectedIndex == 0){
// 		alert("Select Security Type");
// 		document.forms[0].txtsec_type.value="";
// 		document.forms[0].selSecType.focus();
// 	}
}

function showSecurities(){
// 	 if(document.forms[0].cmdedit.disabled){

// 			for (i=0;i<document.forms[0].elements.length;i++)
// 			{
// 				document.forms[0].elements[i].disabled = false;
// 			}
			
// 	if(mode=="edit"){
// 		if (document.forms[0].selSecType.selectedIndex == 0)
// 	   	{
// 			ShowAlert("111","Security Type");
// 			document.forms[0].selSecType.focus();
// 	   	}
// 		else{
			var type=document.forms[0].selSecType.value;
			var purl = "<%=ApplicationParams.getAppUrl()%>action/securitylist.jsp?hidBeanId=securitymaster&hidBeanGetMethod=getSecurityMaster&secType="+type;		
			var title = "ListofSecurities";
			var prop = "scrollbars=no,width=600,height=400";	
			var xpos = (screen.width - 600) / 2;
			var ypos = (screen.height - 400) / 2;
			prop = prop + ",left="+xpos+",top="+ypos;
			window.open(purl,title,prop);
			callDisableControls(true,true,false,false,false,true);
		//}
	//}	

	callDisableControls(true,true,false,false,false,true);
	//document.forms[0].rad[0].disabled = true;
	//document.forms[0].selSecType.disabled = false;
	// }
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
   		
   		document.forms[0].hidBeanGetMethod.value="getAgriunitcostMaster";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].action=appURL+"action/Agricultureunitcostsetup.jsp";	
		document.forms[0].submit();
   	}
}

function doNew()
{
	mode="new";
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,true,false,true);   //selScheme sel_state  sel_actname  sel_actname  sel_Action
	document.forms[0].selScheme.disabled = false;
	document.forms[0].sel_state.disabled = false;
	document.forms[0].sel_actname.disabled = false;
	document.forms[0].sel_specifica.disabled = false;
	document.forms[0].sel_Action.disabled = false;
	
	
	
}



function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		} 
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
 		if(document.forms[0].elements[i].type=="radio")
 		{
 			document.forms[0].elements[i].disabled=(one);		  
 		}
			
	}
}


//


function disableFieldsradio(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		} 
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}	
 		if(document.forms[0].elements[i].type=="radio")
 		{
 			one=false;
 			
 			document.forms[0].elements[i].disabled=(one);		  
 		}
			
	}
}
function doEdit()
{  
	mode="edit";
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="update";	
    callDisableControls(true,true,false,false,false,false);
    document.forms[0].selScheme.disabled = false;
	document.forms[0].sel_state.disabled = false;
	document.forms[0].sel_actname.disabled = false;
	document.forms[0].sel_specifica.disabled = false;
	document.forms[0].sel_Action.disabled = false;
	disablefields(false);
}

function doSave()
{
	document.forms[0].selScheme.disabled = false;
	document.forms[0].sel_state.disabled = false;
	document.forms[0].sel_actname.disabled = false;
	document.forms[0].sel_specifica.disabled = false;
	document.forms[0].sel_Action.disabled = false;
	if(document.forms[0].selScheme.value=="0")
	{
		alert("Select Scheme");
		return;
	}
	if(document.forms[0].sel_state.value=="")
	{
		alert("Select State");
		return;
	}
	if(document.forms[0].sel_actname.value=="")
	{
		alert("Select Activity Name");
		return;
	}
	if(document.forms[0].sel_specifica.value=="")
	{
		alert("Select Specifications");
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
	document.forms[0].hidBeanMethod.value="updateAgriunitcostMaster";
    document.forms[0].hidBeanGetMethod.value="getAgriunitcostMaster";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/Agricultureunitcostsetup.jsp";
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
		document.forms[0].hidBeanMethod.value="updateAgriunitcostMaster";
	    document.forms[0].hidBeanGetMethod.value="getAgriunitcostMaster";
		document.forms[0].hidSourceUrl.value="/action/Agricultureunitcostsetup.jsp";
		document.forms[0].submit();
	}

}


function getValue()
{
	
// 	alert("444");
// 	document.forms[0].hidBeanGetMethod.value="getAgriunitcostMaster";
// 	document.forms[0].hidBeanId.value="securitymaster";
// 	document.forms[0].action=appURL+"action/Agricultureunitcostsetup.jsp";	
// 	document.forms[0].submit();
}

function selectValues1(val0,val1,val2,val3,val4,val5)
{
	
//	alert("1");
	document.all.ifrm.src=appURL+"action/iframeagrimastersearch.jsp?hidBeanGetMethod=getAgriunitcostMaster&hidBeanId=securitymaster&selScheme="+val1+"&hidsno="+val0+"&sel_state="+val2+"&sel_actname="+val3+"&sel_specifica="+val4+"&sel_view=view";
//    	enableButtons(true, false, true, false, true);
   	
// 	document.forms[0].hidsno.value = val0;
// 	document.forms[0].selScheme.value = val1;
// 	document.forms[0].sel_state.value = val2;
// 	document.forms[0].sel_actname.value = val3;
// 	document.forms[0].sel_specifica.value = val4;
// 	document.forms[0].sel_Action.value = val5;
	enableButtons(true, false, true, false, true);
}

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage();" >
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Other Setup &amp;  Agriculture Unit Cost Master</td>
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
                                          <td  colspan="2" class="setuphead">Agriculture Unit Cost</td>
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
                                    
                                                  </table>
                                                </td>
                                              </tr>                                              
                                              <tr> 
                                                <td width="28%" >Scheme<span class="mantatory">*</span> 
                                                 </td>
                                                <td width="72%"> 
                                                  <select name="selScheme" style="width:350" onChange="getValue()">
                                                    <option selected value="0">--Select--</option>
                                                   
														 <%String apptypecon = "285";%>
                                                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
                                                  </select>
                                                </td>
                                              </tr>
                                              <tr>
												<td>Select State<span class="mantatory">*</span></td>
															<td width="25%" nowrap><b><select name="sel_state" onClick="">
															<option value="0">--Select--</option>
															<lapschoice:stateflexmaster />
															</select> </b></td>
												</tr>
                                             <tr>
													<td width="28%%">Activity Name<span class="mantatory">*</span></td>
													<td  width="72%">
														<select name="sel_actname" style="width:350">
														<option value="0">--Select--</option>
														 <% apptypecon = "286";%>
                                                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
														</select>
													</td>
											   </tr > 
											    <tr>
													<td width="28%%">Specifications<span class="mantatory">*</span></td>
													<td  width="72%">
														<select name="sel_specifica" style="width:350">
														<option value="0">--Select--</option>
														 <% apptypecon = "287";%>
                                                   <lapschoice:StaticDataNewTag apptype='<%=apptypecon%>' />
														</select>
													</td>
											   </tr > 
											  
											 
		 
		  <tr>
                     <td>Action<span class="mantatory">*</span></td>
                     <td><select name="sel_Action">
                     <option value="0">--Select--</option>
                     <option value="Y">Yes</option>
                     <option value="N">No</option></select></td>
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
	<br>
	  <table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr class="dataheader"> 
                                          <td width="3%" >&nbsp;</td>
                                          <td width="5%" align="center" ><b>S No.</b></td>
                                          <td width="7%"  align="center"><b>Data Id</b></td>
                                          <td width="20%"  align="center"><b>Scheme</b></td>
										  <td width="20%"  align="center"><b>State</b></td>
										  <td width="20%"  align="center"><b>Activity Name</b></td>
										  <td width="20%"  align="center"><b>Specifications</b></td>
										  <td width="8%"  align="center"><b>Action</b></td>
										  
										  
										
										  </tr>
                                        
                                      	<%
											if (arrRow != null && arrRow.size() > 0) 
											{
											for (int i = 0; i < arrRow.size(); i++) 
											{
												
											arrCol = (ArrayList) arrRow.get(i);
											
											String strVisibility = Helper.correctNull((String)arrCol.get(7));
											String strVisibility1= "";
											if(strVisibility.equalsIgnoreCase("Y"))
											{
												strVisibility1 = "Enable";
											}
											if(strVisibility.equalsIgnoreCase("N"))
											{
												strVisibility1 = "Disable";
											}
											
											
											
										%>
                                          <tr class="datagrid"> 
                                            <td width="3%"> 

                                              <input type="radio" name="radiobutton" value="radiobutton"    onClick="selectValues1('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>'
                                            ,'<%=Helper.correctNull((String)arrCol.get(5))%>')">

                                            <td width="5%" align="center"><%=i+1%></td>
                                            <td width="7%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
                                            <td width="20%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(8))%></td>
											 <td width="20%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(9))%></td>
											  <td width="20%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(5))%></td>
											   <td width="20%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(6))%></td>
											<td width="8%" align="center"><%=strVisibility1%></td>
											
											
                                          </tr>
                                          <%}} %>
                                           <tr class="datagrid"> 
                                            <td width="3%">&nbsp; </td>
                                            <td width="5%">&nbsp; </td>
                                            <td width="7%">&nbsp; </td>
                                            <td width="20%">&nbsp; </td>
											<td width="20%">&nbsp; </td>
											 <td width="20%">&nbsp; </td>
											<td width="20%">&nbsp; </td>
											<td width="8%">&nbsp; </td>
											
                                          </tr>
                                        </table>
                                        </td>
                                        </tr>
                                        </table>
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidagrisno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">

<input type="hidden" name="hidinstype" value="">
   <iframe height="0" width="0" id="ifrm" frameborder=0 style="border:0"></iframe> 
</form>
</body>
</html>