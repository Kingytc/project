<%@ include file="../share/directives.jsp"%>
<%
String prdcode=Helper.correctNull((String) hshValues.get("strmodule"));
//out.println("prdcode=="+prdcode);
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
ArrayList termsidrow=new ArrayList();
ArrayList termsidCol=new ArrayList();
if(hshValues!=null&&hshValues.size()>0)
{
	arrRow=(ArrayList)hshValues.get("arrRow");
	termsidrow=(ArrayList)hshValues.get("termsidrow");
	//out.println("arrRow=="+arrRow);
	//out.println("termsidrow=="+termsidrow);
}

%>
<html>
<head>
<title>Setup(Terms and Conditions)</title>
<script language="JavaScript">

function callOnLoad()
{	

	var strMode="<%=Helper.correctNull((String) hshValues.get("strMode"))%>";
	var strprepost="<%=Helper.correctNull((String) hshValues.get("strprepost"))%>";	
	if (strMode!="")
	{
		document.forms[0].select_termstype.value=strMode;
	}	
	if (strprepost!="")
	{
		document.forms[0].sel_prepost.value=strprepost;
	}
	
	<%		
	
	 if(termsidrow!=null&&termsidrow.size()>0)
	                      {
		 						
							  for(int i=0;i<termsidrow.size();i++)
							  {
								  termsidCol=(ArrayList)termsidrow.get(i);
								 
								  %>
								  var size="";
								  var arrsize="";
								  var size=<%=termsidrow.size()%>;	
								  var arrsize=<%=arrRow.size()%>;	
								  var v_constitution="<%=Helper.correctNull((String) termsidCol.get(1))%>";	
								  var v_insurancecovered="<%=Helper.correctNull((String) termsidCol.get(2))%>";	
								  var v_interestsubtype="<%=Helper.correctNull((String) termsidCol.get(4))%>";									  
								  var v_holidayperiod="<%=Helper.correctNull((String) termsidCol.get(3))%>";	
								  var v_selectcheck="<%=Helper.correctNull((String) termsidCol.get(5))%>";
								 
								  if(v_constitution!="")
									{
										var arrconstitution =v_constitution.split("@");											
										for(var j=0;j<arrconstitution.length-1;j++)
										{
											var varoption=arrconstitution[j];
											if(size>=2 ||(size==1 && arrsize>=2))
											{
												for(var m=0;m<document.forms[0].sel_constitution[<%=i%>].options.length;m++)
												{
													if(document.forms[0].sel_constitution[<%=i%>].options[m].value==varoption)
												  	{	
														 document.forms[0].sel_constitution[<%=i%>].options[m].selected=true;
														 break;
													}
												}
											}
												
											else
											{
												for(var m=0;m<document.forms[0].sel_constitution.options.length;m++)
												{
													if(document.forms[0].sel_constitution.options[m].value==varoption)
												  	{	
														 document.forms[0].sel_constitution.options[m].selected=true;
														 break;
													}
												}
											}
										}
									}
								  if(v_insurancecovered!="")
									{
										var arrinsurancecovered =v_insurancecovered.split("@");										
										for(var j=0;j<arrinsurancecovered.length-1;j++)
										{
											var varoption=arrinsurancecovered[j];
											if(size>=2 ||(size==1 && arrsize>=2))
											{
												for(var m=0;m<document.forms[0].sel_insurancecovered[<%=i%>].options.length;m++)
												{
													if(document.forms[0].sel_insurancecovered[<%=i%>].options[m].value==varoption)
												  	{	
														 document.forms[0].sel_insurancecovered[<%=i%>].options[m].selected=true;
														 break;
													}
												}
											}												
											else
												{
													for(var m=0;m<document.forms[0].sel_insurancecovered.options.length;m++)
													{
														if(document.forms[0].sel_insurancecovered.options[m].value==varoption)
													  	{	
															 document.forms[0].sel_insurancecovered.options[m].selected=true;
															 break;
														}
													}
												}
										}
									}
								  if(v_interestsubtype!="")
									{
										var arrinterestsubtype =v_interestsubtype.split("#");
										
										for(var j=0;j<arrinterestsubtype.length-1;j++)
										{
											var varoption=arrinterestsubtype[j];	
											if(size>=2 ||(size==1 && arrsize>=2))
											{
												for(var m=0;m<document.forms[0].sel_interestsubtype[<%=i%>].options.length;m++)
												{
													if(document.forms[0].sel_interestsubtype[<%=i%>].options[m].value==varoption)
												  	{	
														 document.forms[0].sel_interestsubtype[<%=i%>].options[m].selected=true;
														 break;
													}
												}
											}
											else
											{
												for(var m=0;m<document.forms[0].sel_interestsubtype.options.length;m++)
												{
													if(document.forms[0].sel_interestsubtype.options[m].value==varoption)
												  	{	
														 document.forms[0].sel_interestsubtype.options[m].selected=true;
														 break;
													}
												}
											}
										}
									}
								  if(size>=2 ||(size==1 && arrsize>=2))
									{
								  		document.forms[0].sel_Holidayperiod[<%=i%>].value=v_holidayperiod;
									}
								  else
									  document.forms[0].sel_Holidayperiod.value=v_holidayperiod; 
								  if(size>=2 ||(size==1 && arrsize>=2))
								{
									  if(v_selectcheck=="Y")
									{	  
									  document.forms[0].chk_status[<%=i%>].checked=true;
									}
									  else
										  document.forms[0].chk_status[<%=i%>].checked=false;
								}
							  else
								  {
									  if(v_selectcheck=="Y")
										{	  
										  document.forms[0].chk_status.checked=true;
										}
										  else
											  document.forms[0].chk_status.checked=false;
								  }
								  <% }} %>
	//vindhya end
	disableFields(true);
	disableCommandButtons(false,true,true,false);
}
function doEdit()
{
	disableFields(false);
	disableCommandButtons(true,false,false,false);
	if(document.forms[0].select_termstype.value!="G")
	{
		document.forms[0].sel_prepost.disabled="true";
	}	
}
function doSave()
{
	if(document.forms[0].select_termstype.value =="")
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
	if(document.forms[0].chk_status.length>=2)
	{
		for(var i=0;i<document.forms[0].chk_status.length;i++)
		{
			if(document.forms[0].chk_status[i].checked==true)
			{
				/*if(document.forms[0].sel_constitution[i].value==""){
					alert("Select Constitution");
					document.forms[0].sel_constitution[i].focus();
					return;
				}
			
				if(document.forms[0].sel_insurancecovered[i].value==""){
					alert("Select Insurance Covered");
					document.forms[0].sel_insurancecovered[i].focus();
					return;
				}	
				if(document.forms[0].sel_Holidayperiod[i].value=="S"){
					alert("Select Holiday Period");
					document.forms[0].sel_Holidayperiod[i].focus();
					return;
				}
				if(document.forms[0].sel_interestsubtype[i].value==""){
					alert("Select Interest Subtype");
					document.forms[0].sel_interestsubtype[i].focus();
					return;
				}*/
				if(document.forms[0].sel_constitution[i].value=="" && document.forms[0].sel_insurancecovered[i].value=="" && 
						document.forms[0].sel_Holidayperiod[i].value=="S" && document.forms[0].sel_interestsubtype[i].value=="")
				{
					alert("Select Any one of the Constraint");
					document.forms[0].sel_constitution[i].focus();
					return;
				}	
					
					
			}
			else if(document.forms[0].chk_status[i].checked==false)
			{
				/*if(document.forms[0].sel_constitution[i].value!=""){
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}
				if(document.forms[0].sel_insurancecovered[i].value!=""){
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}	
				if(document.forms[0].sel_Holidayperiod[i].value!="S"){
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}
				if(document.forms[0].sel_interestsubtype[i].value!=""){
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}*/
				if(document.forms[0].sel_constitution[i].value!="" || document.forms[0].sel_insurancecovered[i].value!="" 
						||document.forms[0].sel_Holidayperiod[i].value!="S" || document.forms[0].sel_interestsubtype[i].value!=""){
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}
			}
		}
	}	
	else
	{
		if(document.forms[0].chk_status.checked==true)
		{
			/*if(document.forms[0].sel_constitution.value==""){
				alert("Select Constitution");
				document.forms[0].sel_constitution.focus();
				return;
			}
		
			if(document.forms[0].sel_insurancecovered.value==""){
				alert("Select Insurance Covered");
				document.forms[0].sel_insurancecovered.focus();
				return;
			}	
			if(document.forms[0].sel_Holidayperiod.value=="S"){
				alert("Select Holiday Period");
				document.forms[0].sel_Holidayperiod.focus();
				return;
			}
			if(document.forms[0].sel_interestsubtype.value==""){
				alert("Select Interest Subtype");
				document.forms[0].sel_interestsubtype.focus();
				return;
			}*/
			if(document.forms[0].sel_constitution.value=="" && document.forms[0].sel_insurancecovered.value=="" && 
					document.forms[0].sel_Holidayperiod.value=="S" && document.forms[0].sel_interestsubtype.value=="")
			{
				alert("Select Any one of the Constraint");
				document.forms[0].sel_constitution.focus();
				return;
			}
		}
		else if(document.forms[0].chk_status.checked==false)
			{
				/*if(document.forms[0].sel_constitution.value!=""){
					alert("Select Check box");
					document.forms[0].chk_status.focus();
					return;
				}
				if(document.forms[0].sel_insurancecovered.value!=""){
					alert("Select Check box");
					document.forms[0].chk_status.focus();
					return;
				}	
				if(document.forms[0].sel_Holidayperiod.value!="S"){
					alert("Select Check box");
					document.forms[0].chk_status.focus();
					return;
				}
				if(document.forms[0].sel_interestsubtype.value!=""){
					alert("Select Check box");
					document.forms[0].chk_status.focus();
					return;
				}*/
			if(document.forms[0].sel_constitution.value!="" || document.forms[0].sel_insurancecovered.value!="" 
				||document.forms[0].sel_Holidayperiod.value!="S" || document.forms[0].sel_interestsubtype.value!="")
				{
					alert("Select Check box");
					document.forms[0].chk_status[i].focus();
					return;
				}	
			}
	}	
	if(document.forms[0].hidtermCode.length>=2)
	{
		for(var i=0;i<document.forms[0].hidtermCode.length;i++)
		{
			if(document.forms[0].chk_status[i].checked==true)
			{
			document.forms[0].hid_chk_status[i].value="Y";
			}
			else
			{
			document.forms[0].hid_chk_status[i].value="N";
			}	
			document.forms[0].hid_Holidayperiod[i].value=document.forms[0].sel_Holidayperiod[i].value;
			var varcode="";		
			for(var j=0;j<document.forms[0].sel_constitution[i].options.length;j++)
			{
				if(document.forms[0].sel_constitution[i].options[j].selected)
				{				
					varcode=varcode+document.forms[0].sel_constitution[i].options[j].value+"@";
				}		
			}
			document.forms[0].hid_constitution[i].value=varcode;
			var varinsurcode ="";
			for(var j=0;j<document.forms[0].sel_insurancecovered[i].options.length;j++)
			{
				if(document.forms[0].sel_insurancecovered[i].options[j].selected)
				{				
					varinsurcode=varinsurcode+document.forms[0].sel_insurancecovered[i].options[j].value+"@";
				}		
			}
			document.forms[0].hid_insurancecovered[i].value=varinsurcode;
			var varinterestsubtype ="";
			for(var j=0;j<document.forms[0].sel_interestsubtype[i].options.length;j++)
			{
				if(document.forms[0].sel_interestsubtype[i].options[j].selected)
				{				
					varinterestsubtype=varinterestsubtype+document.forms[0].sel_interestsubtype[i].options[j].value+"#";
				}		
			}
			document.forms[0].hid_interestsubtype[i].value=varinterestsubtype;
			
		}
	}
	else
	{
		if(document.forms[0].chk_status.checked==true)
		{
		document.forms[0].hid_chk_status.value="Y";
		}
		else
		{
		document.forms[0].hid_chk_status.value="N";
		}	
		document.forms[0].hid_Holidayperiod.value=document.forms[0].sel_Holidayperiod.value;
		var varcode="";		
		for(var j=0;j<document.forms[0].sel_constitution.options.length;j++)
		{
			if(document.forms[0].sel_constitution.options[j].selected)
			{				
				varcode=varcode+document.forms[0].sel_constitution.options[j].value+"@";
			}		
		}
		document.forms[0].hid_constitution.value=varcode;
		var varinsurcode ="";
		for(var j=0;j<document.forms[0].sel_insurancecovered.options.length;j++)
		{
			if(document.forms[0].sel_insurancecovered.options[j].selected)
			{				
				varinsurcode=varinsurcode+document.forms[0].sel_insurancecovered.options[j].value+"@";
			}		
		}
		document.forms[0].hid_insurancecovered.value=varinsurcode;
		var varinterestsubtype ="";
		for(var j=0;j<document.forms[0].sel_interestsubtype.options.length;j++)
		{
			if(document.forms[0].sel_interestsubtype.options[j].selected)
			{				
				varinterestsubtype=varinterestsubtype+document.forms[0].sel_interestsubtype.options[j].value+"#";
			}		
		}
		document.forms[0].hid_interestsubtype.value=varinterestsubtype;
		
	}	
	
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidsel_prepost.value=document.forms[0].sel_prepost.value;
	document.forms[0].hidBeanMethod.value="updateSetTermsandConditions";
	document.forms[0].hidBeanGetMethod.value="getSetTermsandConditions";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidSourceUrl.value="/action/prodtermsandcondition.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanGetMethod.value="getSetTermsandConditions";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].action=appURL+"action/prodtermsandcondition.jsp";
		document.forms[0].submit();
	}
}
function doClose()
{	
	var prdcode=document.forms[0].hidmoduletype.value;
	if(ConfirmMsg(100))
	{
		if (prdcode=="c"||prdcode=="a"||prdcode=="C"||prdcode=="A")
		{
			document.forms[0].action=appURL+"action/comfacilityhome.jsp";
			document.forms[0].submit();
		}
		else
		{
			document.forms[0].action=appURL+"action/setsearchproducts.jsp";
			document.forms[0].submit();
		}
	}
}
function disableFields(binaryVal)
{  
	document.forms[0].select_termstype.disabled=binaryVal;	
	document.forms[0].sel_prepost.disabled=binaryVal;	
	if(document.forms[0].hidtermCode.length>=2)
	{
		for(var i=0;i<document.forms[0].hidtermCode.length;i++)
		{
			document.forms[0].sel_constitution[i].disabled=binaryVal;	
			document.forms[0].sel_insurancecovered[i].disabled=binaryVal;	
			document.forms[0].sel_Holidayperiod[i].disabled=binaryVal;	
			document.forms[0].sel_interestsubtype[i].disabled=binaryVal;	
			document.forms[0].chk_status[i].disabled=binaryVal;
		}
	}
	else
	{
		document.forms[0].sel_constitution.disabled=binaryVal;	
		document.forms[0].sel_insurancecovered.disabled=binaryVal;	
		document.forms[0].sel_Holidayperiod.disabled=binaryVal;	
		document.forms[0].sel_interestsubtype.disabled=binaryVal;	
		document.forms[0].chk_status.disabled=binaryVal;
	}
	
}
function disableCommandButtons(binary1,binary2,binary3,binary4)
{
	document.forms[0].cmdedit.disabled = binary1;
	document.forms[0].cmdsave.disabled = binary2;
	document.forms[0].cmdcancel.disabled = binary3;
	document.forms[0].cmdclose.disabled = binary4;
	
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
	document.forms[0].hidsel_prepost.value=document.forms[0].sel_prepost.value;
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanGetMethod.value="getSetTermsandConditions";	
	document.forms[0].action=appURL+"action/prodtermsandcondition.jsp";
	document.forms[0].method="post";
	document.forms[0].submit();
}
</script>

</head>
<body onload="callOnLoad();">
<form name="prodtermsandcondition" method="post" action="<%=ApplicationParams.getAppUrl()%>controllerservlet" class="normal">
<% if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a")){%>
<lapstab:setproductstabcorp tabid="12"/>
<% } else {%>
<lapstab:setproductstab tabid="12" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<%} %>
<% if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a")){%>  
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate & Agri Products  &amp; Facility Creation -&gt; Terms and Conditions</td>
</tr>
</table>
<%}else {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Products -&gt; Terms and Conditions</td>
</tr>
</table>
<%}%>
<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center">
<tr>
	<td>
		<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable" align="center">
		<tr>
			<td>
				<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable">
				<tr> 
					<td valign="top"> 
					<fieldset> 
						<table width="100%" border="0" cellspacing="3" cellpadding="0" class="outertable">
						<tr> 
						<%if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a"))	{%>
							<td><lapschoice:facility /></td>
						<%} else {%>
							<td> <lapschoice:products /></td>
						<%}	%>
						</tr>
						</table>
					</fieldset> 
					</td>
				</tr>
				<tr><td>&nbsp;</td></tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table class="outertable border1" width="100%" cellspacing="0" cellpadding="1" border="0" align="center"> 
				<tr class="dataGridColor"> 
                           <td width="29%">Select Terms Type <b><span class="mantatory">*&nbsp;</span></b></td>
                              <td width="71%">
                              <select name="select_termstype" onchange="callTerms();">
                 				<option value="" selected="selected"><---Select---></option>
								<option value="G">General</option>								
								<option value="P">Specific</option>
								<option value="B">Instruction to the Branch</option>
								<option value="O">Others</option>
								<%if (prdcode.equalsIgnoreCase("c")||prdcode.equalsIgnoreCase("a"))	{%>
								 <lapschoice:ProductdescriptionTag prod_code='<%=Helper.correctNull((String)request.getParameter("fac_id")) %>' prodtype='<%=prdcode%>'/>
								<%} else {%>
								 <lapschoice:ProductdescriptionTag prod_code='<%=Helper.correctNull((String)request.getParameter("prdCode")) %>' prodtype='<%=prdcode%>'/>	
								 <%} %>						
							</select>
							</td>
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
				
				</table>
				</td>
                </tr>  
				<br><br>
					<tr>
				<td>
				<table width="100%" border="0" cellspacing="1" cellpadding="3" align="center" class="outertable border1">			
				<tr class="dataheader">
						<td width="5%" align="center"></td>				
						<td width="15%">Terms &amp;
						Conditions</td>
						<td width="15%" align="center">Constitution of the Borrower</td>
						<td width="10%" align="center">Insurance Covered Under</td>
						<td width="5%" align="center">Holiday Period</td>
						<td width="15%" align="center">Interest Sub Type</td>
				</tr> 
				<%
                      if(arrRow!=null&&arrRow.size()>0)
                      {
						  for(int i=0;i<arrRow.size();i++)
						  {
							  arrCol=(ArrayList)arrRow.get(i);
							 if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("E"))
							  {
								  
								 %>                      
				 <tr class="datagrid">										
						<input type="hidden" name="hidtermCode" 
						  value="<%=Helper.correctNull((String) arrCol.get(0))%>"> 	
						<td width="5%" align="center">
						<input type="hidden" name="hid_chk_status">  
						  <input type="checkbox" name="chk_status" style="border-style:none" value=""></td>					
						<td width="15%"> 						
						 <%=Helper.correctNull((String) arrCol.get(1))%>
						 </td>
						<td width="15%">
						<input type="hidden" name="hid_constitution">  
						<select name="sel_constitution" multiple>						
						<lapschoice:CBSStaticDataNewTag apptype="2" />
						</select>
						</td>
						<td width="10%">
						<input type="hidden" name="hid_insurancecovered">  
						<select name="sel_insurancecovered" multiple>
						<lapschoice:StaticDataTag apptype="223" tagType="a" />										
						</select>
						</td>
						<td width="5%" align="center">
						 <input type="hidden" name="hid_Holidayperiod">  
                        <select name="sel_Holidayperiod" onChange="">
                                  <option value='S' selected><- Select -></option>
                                  <option value='Y'>Yes</option>
								  <option value='N'>No</option>
                                </select>
                         </td>
						<td width="15%">
						<input type="hidden" name="hid_interestsubtype">  
						<select name="sel_interestsubtype" multiple>
						<lapschoice:MCLRTag/>
						</select>
						</td>
					</tr>
					<%	}}
                      	}%>
				
		</table>
	</td>
</tr>
<tr><td>&nbsp;</td></tr>
</table>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hidmoduletype" value="<%=Helper.correctNull((String) hshValues.get("strmodule"))%>">
<input type="hidden" name="hidsel_prepost">
</form>
</body>
</html>