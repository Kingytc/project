<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrCol=new ArrayList();
	ArrayList arrRow=new ArrayList();
	int intLength=0;
	if(hshValues!=null&&hshValues.size()>0)
	{
		arrRow=(ArrayList)hshValues.get("arrRow");
	}
	String strPgDist=Helper.correctNull(request.getParameter("hiPgDist"));	
	if(arrRow!=null)
		intLength=arrRow.size();
	String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
	String strProcessDate=Helper.correctNull((String)hshValues.get("strProcessdate"));
	if(strProcessDate.equalsIgnoreCase(""))
		strProcessDate=Helper.getCurrentDateTime();
	long lngDatediff=Helper.dateDiff(ApplicationParams.getStrRetailTCEffectDate(),strProcessDate);
%>
<html>
<head>
<title>Terms and Conditions</title>
<script>
var appURL="<%=ApplicationParams.getAppUrl()%>";
var varpageid="<%=Helper.correctNull((String) hshValues.get("PageId"))%>";
function callOnLoad()
{
	disableFields(true);
	document.forms[0].select_termstype.disabled=false;
	document.forms[0].select_termstype.value="<%=Helper.correctNull((String)hshValues.get("strTermType"))%>";
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableButton(false,false,true,true,true,false);
	}
	<%if(!Helper.correctNull((String)hshValues.get("strPrePost")).equalsIgnoreCase("")){%>
	document.forms[0].sel_prepost.value="<%=Helper.correctNull((String)hshValues.get("strPrePost"))%>";
	<%}%>
	if(document.forms[0].select_termstype.value=="G")
	{
		document.forms[0].sel_prepost.disabled=false;
	}
}
function setData()
{
	var len = document.forms[0].sno.length;
	if(len!=null)
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				if(document.forms[0].btnenable.value.toUpperCase()=="Y")
				{
					if(document.forms[0].hidtermtype[i].value=="P")
					{
						if(!confirm("Do you want to modify the Master or System terms and conditions?"))
						{
						document.forms[0].sno[i].checked=false;
						document.forms[0].txttrmdesc.value="";
						document.forms[0].sel_req.value="";
						document.forms[0].cmdadd.disabled=false;
						return;
						}
					}
				}
				
				document.forms[0].txttrmdesc.value = document.forms[0].hidText[i].value;
				document.forms[0].hidtermid.value = document.forms[0].sno[i].value;
				document.forms[0].hidterms.value = document.forms[0].hidtermtype[i].value;
				//document.forms[0].select_termstype.value =document.forms[0].hidtermtype_select[i].value;
				//While edit and this value has to be passed to bean.(In Edit mode select_termstype should be in disable mode)
				document.forms[0].hid_select_termstype.value=document.forms[0].hidtermtype_select[i].value;
				document.forms[0].hid_select_termsubtype.value=document.forms[0].hidtermtype_subtype[i].value;
				document.forms[0].sel_req.value=document.forms[0].hidSupportDoc[i].value;
			}
		}
	}
	else
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
			if(document.forms[0].hidtermtype.value=="P")
			{
				if(!confirm("Do you want to modify the Master or System terms and conditions?"))
				{
					document.forms[0].sno.checked=false;
					document.forms[0].txttrmdesc.value="";
					document.forms[0].sel_req.value="";
					document.forms[0].cmdadd.disabled=false;
					return;
				}
			}
		}
		
		document.forms[0].txttrmdesc.value = document.forms[0].hidText.value;
		document.forms[0].hidtermid.value = document.forms[0].sno.value;
		document.forms[0].hidterms.value = document.forms[0].hidtermtype.value;
		//document.forms[0].select_termstype.value =document.forms[0].hidtermtype_select.value;
		//While edit and this value has to be passed to bean.(In Edit mode select_termstype should be in disable mode)
		document.forms[0].hid_select_termstype.value=document.forms[0].hidtermtype_select.value;
		document.forms[0].hid_select_termsubtype.value=document.forms[0].hidtermtype_subtype.value;
		document.forms[0].sel_req.value=document.forms[0].hidSupportDoc.value;
	}
	document.forms[0].hidcomments.value="";
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
		disableButton(true,false,true,false,false,false);
		//disableButton(true,true,false,false,true,true);
	}
	document.forms[0].hidAction.value="update";
}
function disablebutton()
{
	if (document.forms[0].btnenable.value == "N")
	{
		disableButton(true,true,true,true,true,false);
		document.forms[0].cmdadd2.disabled=true;
	}
	else
	{
		disableButton(false,true,true,true,true,false);
	}
}

function doAdd()
{
	if(document.forms[0].select_termstype.value =="")
	{
		alert("Please Select Terms Type");
		document.forms[0].select_termstype.focus();
		return false;
	}
	else if(document.forms[0].select_termstype.value=="G")
	{
		if(document.forms[0].sel_prepost.value=="s")
		{
			alert("Select Type");
			document.forms[0].sel_prepost.focus();
			return;
		}
		
	}
	
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidtermid.value="";
	document.forms[0].txttrmdesc.value="";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].sel_req.disabled=false;
	disableButton(true,true,false,false,true,true);
	document.forms[0].select_termstype.disabled=true;
	document.forms[0].sel_prepost.disabled=true;
}

function doEdit()
{
	if(document.forms[0].hidAction.value!="update")
	document.forms[0].hidAction.value="Print";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].select_termstype.disabled=true;
	document.forms[0].sel_prepost.disabled=true;
	document.forms[0].sel_req.disabled=false;
	var len = document.forms[0].sno.length;

	if(len != null)
	{
		for(i=0;i<len;i++)
		{
			document.forms[0].sno[i].disabled = true;
		}
	}
	else
	{
		document.forms[0].sno.disabled = true;
	}
	disableButton(true,true,false,false,true,true);
	if(document.forms[0].hidAction.value=="update")
	{
		disableFields(true);
		document.forms[0].txttrmdesc.readOnly=false;
		document.forms[0].sel_req.disabled=false;
	}
	else
	{
		disableFields(false);
		document.forms[0].txttrmdesc.readOnly=true;
		document.forms[0].sel_req.disabled=true;
	}
	document.forms[0].select_termstype.disabled=true;
	document.forms[0].sel_prepost.disabled=true;
}
function doSave()
{
	if(document.forms[0].hidAction.value!="Print")
	{
		if(trimtxt(document.forms[0].txttrmdesc.value)=="")
		{
			alert("Enter Terms Description");
			document.forms[0].txttrmdesc.focus();
			return false;
		}
		else if(document.forms[0].select_termstype.value =="")
		{
			alert("Please Select Terms Type");
			document.forms[0].select_termstype.focus();
			return false;
		}
		else if(document.forms[0].select_termstype.value=="G" && document.forms[0].sel_prepost.value=="s")
		{
			alert("Select Type");
			document.forms[0].sel_prepost.focus();
			return;
		}
		else if(document.forms[0].sel_req.value=="")
		{
			alert("Select Whether supporting document Required");
			document.forms[0].sel_req.focus();
			return;
		}
	}
	else
	{
		if(document.forms[0].chk_print && document.forms[0].chk_print.length==undefined)
		{
			if(document.forms[0].chk_print.checked==true)
			{
				if(document.forms[0].sel_DocUpload.value==''){
					alert("Select Supporting Document Upload required");
					document.forms[0].sel_DocUpload.focus();
					return;
				}
			}
			else
			{
				document.forms[0].sel_DocUpload.value='';
			}
		}
		else
		{
			for(var i=0;i<document.forms[0].chk_print.length;i++)
			{
				if(document.forms[0].chk_print[i].checked==true)
				{
					if(document.forms[0].sel_DocUpload[i].value==''){
						alert("Select Supporting Document Upload required");
						document.forms[0].sel_DocUpload[i].focus();
						return;
					}
				}
				else
				{
					document.forms[0].sel_DocUpload[i].value='';
				}
			}
		}
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].select_termstype.disabled = false;
	document.forms[0].sel_prepost.disabled = false;
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanMethod.value="updateTerms";
	document.forms[0].hidBeanGetMethod.value="getTerms";		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/apptermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}	
function doDelete()
{
	if(document.forms[0].hidtermid.value=="")
	{
		alert("Select Terms to delete");
		return false;
	}
	if(trimtxt(document.forms[0].hidcomments.value)=="")
	{
		var url = "<%=ApplicationParams.getAppUrl()%>action/deletedtermremarks.jsp";
		var title1 = "";
		var prop = "scrollbars=no,width=600,height=450,menubar=no";
		var xpos = 20;
		var ypos = 20;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(url,title1,prop);
	}
	else
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanMethod.value="updateTerms";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/apptermsandcond.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}
function disableButton(b1,b2,b3,b4,b5,b6)
{
	document.forms[0].cmdadd.disabled = b1;
	document.forms[0].cmdedit.disabled = b2;
	document.forms[0].cmdsave.disabled = b3;
	document.forms[0].cmdcancel.disabled = b4;
	document.forms[0].cmddelete.disabled = b5;
	document.forms[0].cmdclose.disabled = b6;
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidBeanId.value="apptermscond";
		document.forms[0].hidBeanGetMethod.value="getTerms";
		document.forms[0].action=appURL+"action/apptermsandcond.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function doClose()
{
	if("<%=strPgDist%>"=="P")
	{
		document.forms[0].action=appURL+"action/retailpge.jsp";
	}else
	{
		document.forms[0].action=appURL+"action/corppge.jsp";
	}
		document.forms[0].method="post";
		document.forms[0].submit();
}
function deleteTerms()
{
	var appno = document.forms[0].appno.value;
	var url = "<%=ApplicationParams.getAppUrl()%>action/apptermsandcondexcep_retail.jsp?appno="+appno+"&hidBeanId=apptermscond&hidBeanGetMethod=getDeletedTerms&hidAction=Retail";
	var title1 = "";
	var prop = "scrollbars=yes,width=775,height=500,menubar=yes";
	var xpos = 5;
	var ypos = 5;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(url,title1,prop);
}
function callTerms()
{

	if(document.forms[0].select_termstype.value=="s")
	{
		alert("Select Terms Type");
		document.forms[0].select_termstype.focus();
		return;
	}
	if((document.forms[0].select_termstype.value=="G"))
	{
		if(document.forms[0].sel_prepost.value=="s")
		{
			alert("Select Type");
			document.forms[0].sel_prepost.disabled=false;
			document.forms[0].sel_prepost.focus();
			return;
		}
		
	}else
	{
		document.forms[0].sel_prepost.value='s';
		document.forms[0].sel_prepost.disabled=true;	
	}
	document.forms[0].hidBeanId.value="apptermscond";
	document.forms[0].hidBeanGetMethod.value="getTerms";
	document.forms[0].action=appURL+"action/apptermsandcond.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
function chkdetails(i)
{
	var len = "<%=intLength%>";
	if(len>1)
	{
		if(document.forms[0].chk_print[i].checked == true)
		{
			document.forms[0].txt_print[i].value="Y";
		}
		else
		{
			document.forms[0].txt_print[i].value="N";
		}
	}
	else 
	{
		if(document.forms[0].chk_print.checked == true)
		{
			document.forms[0].txt_print.value="Y";
		}
		else
		{
			document.forms[0].txt_print.value="N";
		}
	}
}
function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
		{	
			document.forms[0].elements[i].disabled=one;		  
		}
		if(document.forms[0].elements[i].type=="select-one")
		{
			document.forms[0].elements[i].disabled=one;		  
		} 
	}
}
</script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="callOnLoad();">
<form name="frm1" method="post" class="normal">
<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>

<%if(strSessionModuleType.equalsIgnoreCase("DIGI")) { %>
        <jsp:include page="../share/applurllinkerdigi.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">  
    <tr> 
      <td class="page_flow">Home -&gt; Digi Retail -&gt; Appraisal -&gt; Terms and Conditions</td>
    </tr>
  	</table>
 <% } else { %> 
   <jsp:include page="../share/Applurllinkper.jsp" flush="true"> 
        <jsp:param name="pageid" value="10" />
        </jsp:include>
    <table width="100%" border="0" cellpadding="0" cellspacing="0" class="outertable">  
    <tr> 
      <td class="page_flow">Home -&gt; Retail(including schematic) -&gt; Appraisal -&gt; Terms and Conditions</td>
    </tr>
  </table>
 
 <% } %>
  
<lapschoice:application />
 <jsp:include page="../share/apprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="5" />
		</jsp:include>
<%} else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0"
	class="outertable">
	<tr>
		<td><jsp:include page="../set/postsanctionlinksper.jsp" flush="true">
			<jsp:param name="pageid" value="7" />
			<jsp:param name="subpageid" value="114" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<jsp:include page="../share/postsanctionapprlinktab.jsp" flush="true">
			<jsp:param name="tabid" value="5" />
		</jsp:include>
<%} %>
 
              <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                <tr> 
                  <td colspan="2" valign="top"> 
					  <br>
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                      <tr> 
                        <td> 
                          <table width="70%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                          <tr> 
                           <td width="29%">Select Terms Type <b><span class="mantatory">*&nbsp;</span></b></td>
                              <td width="71%"><select name="select_termstype" onchange="callTerms();">
								<option value="" selected="selected"><---Select---></option>
								<%if(lngDatediff>=0){ %>
									<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
								<option value="G">General</option>
								<%} %>
								<option value="P">Specific</option>
								<option value="B">Branch Specific</option>
								<option value="O">Others</option>
								<lapschoice:comtermscond /> 
								<%}else{ %>
								<%if(!Helper.correctNull((String)session.getAttribute("strAppType")).equalsIgnoreCase("P")){%>
								<option value="S">General</option>
								<%} %>
								<option value="P">Specific</option>
								<option value="B">Branch Specific</option>
								<%} %>
							</select></td>
                            </tr>
                            <tr class="dataGridColor">
                              <td width="29%">Select Type</td>
                              <td width="71%">
                                <select name="sel_prepost" onChange="callTerms()">
                                  <option value='s' selected><-- Select --></option>
                                  <option value='pre'>Pre-disbursement</option>
								  <option value='post'>Post-disbursement</option>
                                </select>
                              </td>
                            </tr>
                            <tr> 
                              <td width="29%">Add Terms and Conditions</td>
                              <td width="71%"> 
                                <input type="hidden" name="hidtermid">
                                <input type="hidden" name="hidterms">
                                <textarea name="txttrmdesc" cols="100" readonly="readOnly"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" wrap="VIRTUAL" rows="5"></textarea>
                              </td>
                            </tr>
                             <tr id="iddoc"> 
                              <td width="29%">Whether Supporting Document Upload required?</td>
                              <td width="71%"> 
                                <select name="sel_req">
                                 <option value='' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                              </td>
                            </tr>
                          </table>
                        </td>
                      </tr>
					</table>
					<br>
                  </td>
                </tr>
               <tr> 
                <td colspan="2">
                 <lapschoice:combuttonnew 	btnnames='Add_Edit_Save_Cancel_Delete_Audit Trial' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/><br>
				  <table border="0" cellspacing="0" cellpadding="3" align="center" class="outertable border1">
				    <tr> 
				      <td><input type="button" name="cmdadd2" value="Deleted Terms" class="buttonOthers" onClick="deleteTerms()"></td>
				          </tr>
				   </table>
                <td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable linebor">
                      <tr class="dataheader" align="center"> 
                        <td width="3%">&nbsp;</td>
                        <td align="center" width="78%" class="tabactivenew">Terms and Conditions</td>
                        <td width="7%">Print</td>
                        <td width="12%" nowrap="nowrap">Supporting Document Upload required ?</td>
                      </tr>
                      <%boolean bflag=true;
                      if(arrRow!=null&&arrRow.size()>0)
                      {
						  for(int i=0;i<arrRow.size();i++)
						  {
							  arrCol=(ArrayList)arrRow.get(i);
							  if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("P"))
							  {
								  bflag=false;
								 %>
                      <tr  class="datagrid"> 
                        <td width="3%"> 
                          <input type="radio" name="sno" style="border-style:none" value="<%=arrCol.get(0)%>" onClick="setData()">
                       
                        <input type="hidden" name="hidsno" style="border-style:none" value="<%=arrCol.get(0)%>">
                        <input type="hidden" name="hidText" style="border-style:none" value="<%=arrCol.get(1)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrCol.get(2)%>">
                        <input type="hidden" name="hidtermtype_select" style="border-style:none" value="<%=arrCol.get(3)%>">
                        <input type="hidden" name="hidtermtype_subtype" style="border-style:none" value="<%=arrCol.get(6)%>">
                        <input type="hidden" name="hidprdcode" style="border-style:none" value="<%=arrCol.get(7)%>">
                        <input type="hidden" name="hidSupportDoc" style="border-style:none" value="<%=arrCol.get(5)%>">
                         </td>
                        <td> 
                            <%=Helper.breakText((String)arrCol.get(1),30)%>
                        </td>
                        <td align="center"><input type="checkbox" name="chk_print" style="border: none;" onclick="chkdetails(<%=i%>)"
                        <%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Y")){ %>checked<%} %>>
                        <input type="hidden" name="txt_print" value="<%=Helper.correctNull((String)arrCol.get(4))%>"></td>
                        <td>
                        <select name="sel_DocUpload" onChange="">
                                  <option value='' selected><- Select -></option>
                                  <option value='Y'<%if(Helper.correctNull((String)arrCol.get(5)).equalsIgnoreCase("Y")){ %>selected<%} %>>Yes</option>
								  <option value='N'<%if(Helper.correctNull((String)arrCol.get(5)).equalsIgnoreCase("N")){ %>selected<%} %>>No</option>
                                </select>
                        </td>
                      </tr>
                      <%	}}
                      	}
                      if(bflag){%>
                      <tr  class="datagrid">
                      <td colspan="4" align="center">&nbsp; - Nil -</td>
                      </tr>
                    	  
                      <%}
                      
                      bflag=true;
                      if(arrRow!=null&&arrRow.size()>0)
                      {
						  for(int i=0;i<arrRow.size();i++)
						  {
							  arrCol=(ArrayList)arrRow.get(i);
							  if(Helper.correctNull((String)arrCol.get(2)).equalsIgnoreCase("A"))
							  {
								  if(bflag){
									  bflag=false;
					  %>
					  <tr class="dataheader" align="center">
					  <td colspan="4">Terms and Conditions For this Specific Borrower</td>
					  </tr>
					  <%} %>
                      <tr  class="datagrid"> 
                        <td width="3%"> 
                          <input type="radio" name="sno" style="border-style:none" value="<%=arrCol.get(0)%>" onClick="setData()">
                       
                        <input type="hidden" name="hidsno" style="border-style:none" value="<%=arrCol.get(0)%>">
                        <input type="hidden" name="hidText" style="border-style:none" value="<%=arrCol.get(1)%>">
                        <input type="hidden" name="hidtermtype" style="border-style:none" value="<%=arrCol.get(2)%>">
                        <input type="hidden" name="hidtermtype_select" style="border-style:none" value="<%=arrCol.get(3)%>">
                        <input type="hidden" name="hidtermtype_subtype" style="border-style:none" value="<%=arrCol.get(6)%>">
                        <input type="hidden" name="hidprdcode" style="border-style:none" value="<%=arrCol.get(7)%>">
                        <input type="hidden" name="hidSupportDoc" style="border-style:none" value="<%=arrCol.get(5)%>">
                         </td>
                        <td> 
                            <%=Helper.breakText((String)arrCol.get(1),30)%>
                        </td>
                        <td align="center"><input type="checkbox" name="chk_print" style="border: none;" onclick="chkdetails(<%=i%>)"
                        <%if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Y")){ %>checked<%} %>>
                        <input type="hidden" name="txt_print" value="<%=Helper.correctNull((String)arrCol.get(4))%>"></td>
                        <td>
                        <select name="sel_DocUpload" onChange="">
                                  <option value='' selected><- Select -></option>
                                  <option value='Y'<%if(Helper.correctNull((String)arrCol.get(5)).equalsIgnoreCase("Y")){ %>selected<%} %>>Yes</option>
								  <option value='N'<%if(Helper.correctNull((String)arrCol.get(5)).equalsIgnoreCase("N")){ %>selected<%} %>>No</option>
                                </select>
                        </td>
                      </tr>
                      <%	}}
                      	}%>
                    </table>
                  </td>
                </tr>
              </table>
  <br>
 
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
      <input TYPE="hidden" name="hidcomments">
      <input type="hidden" name="hidLoanType" value="P">
      	<input type="hidden" name="rdtermid">
      	<input TYPE="hidden" name="hid_select_termstype">
      	<input TYPE="hidden" name="hid_select_termsubtype">
</form>
</body>
</html>
