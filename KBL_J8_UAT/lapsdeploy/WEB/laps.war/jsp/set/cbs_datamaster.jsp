<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;	
}
String strStatId=Helper.correctNull((String)hshValues.get("strStatId"));
String strStatsno=Helper.correctNull((String)hshValues.get("stat_data_sno"));
if(strStatsno=="")
{
	strStatsno="0";
}
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
if(hshValues!=null)
{
arrRow = (ArrayList)hshValues.get("arrRow");
}

String dataHead=Helper.correctNull((String) hshValues.get("strSelDataHeads"));
//out.println(hshValues);
%>
<html>
<head>
<title>CBS - Data Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var statno=<%=strStatsno%>;
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varDataHeads="<%=Helper.correctNull((String) hshValues.get("strSelDataHeads"))%>";
var varCGTMSE='<%=Helper.correctNull((String) hshValues.get("cbs_static_cgtmse"))%>';
function callonLoad()
{		
	disablefields(true);
	enableButtons(false, true, true, true, false,true);	
	document.forms[0].seldataheadtype.value = varDataHeads;
	if(document.forms[0].seldataheadtype.value=="27" || document.forms[0].seldataheadtype.value=="32" || document.forms[0].seldataheadtype.value=="15")
	{
		document.all.id_Codepass1.style.visibility="visible";
		document.all.id_Codepass1.style.position="relative";
		document.all.id_Codepass2.style.visibility="visible";
		document.all.id_Codepass2.style.position="relative";
	}
	else
	{
		document.all.id_Codepass1.style.visibility="hidden";
		document.all.id_Codepass1.style.position="absolute";
		document.all.id_Codepass2.style.visibility="hidden";
		document.all.id_Codepass2.style.position="absolute";
	}

	if(document.forms[0].seldataheadtype.value=="20")
	{
		document.all.head1.style.visibility="visible";
		document.all.head1.style.position="relative";
		document.all.head2.style.visibility="visible";
		document.all.head2.style.position="relative";
	}
	else
	{
		document.all.head1.style.visibility="hidden";
		document.all.head1.style.position="absolute";
		document.all.head2.style.visibility="hidden";
		document.all.head2.style.position="absolute";
	}
	if(document.forms[0].seldataheadtype.value=="34")
	{
		document.all.id_interesttype1.style.visibility="visible";
		document.all.id_interesttype1.style.position="relative";
		document.all.id_interesttype2.style.visibility="visible";
		document.all.id_interesttype2.style.position="relative";

		document.all.id_interesttype3.style.visibility="visible";
		document.all.id_interesttype3.style.position="relative";
		document.all.id_interesttype4.style.visibility="visible";
		document.all.id_interesttype4.style.position="relative";
		document.all.id_interesttype5.style.visibility="visible";
		document.all.id_interesttype5.style.position="relative";
		document.all.id_interesttype6.style.visibility="visible";
		document.all.id_interesttype6.style.position="relative";
		
	}
	else
	{
		document.all.id_interesttype1.style.visibility="hidden";
		document.all.id_interesttype1.style.position="absolute";
		document.all.id_interesttype2.style.visibility="hidden";
		document.all.id_interesttype2.style.position="absolute";

		document.all.id_interesttype3.style.visibility="hidden";
		document.all.id_interesttype3.style.position="absolute";
		document.all.id_interesttype4.style.visibility="hidden";
		document.all.id_interesttype4.style.position="absolute";
		document.all.id_interesttype5.style.visibility="hidden";
		document.all.id_interesttype5.style.position="absolute";
		document.all.id_interesttype6.style.visibility="hidden";
		document.all.id_interesttype6.style.position="absolute";
	}

	if(document.forms[0].seldataheadtype.value=="6")
	{
		document.all.intro1.style.visibility="visible";
		document.all.intro1.style.position="relative";
		document.all.intro2.style.visibility="visible";
		document.all.intro2.style.position="relative";
	}
	else
	{
		document.all.intro1.style.visibility="hidden";
		document.all.intro1.style.position="absolute";
		document.all.intro2.style.visibility="hidden";
		document.all.intro2.style.position="absolute";
	}
	if(document.forms[0].seldataheadtype.value=="2")
	{
		document.all.const1.style.visibility="visible";
		document.all.const1.style.position="relative";
		document.all.const2.style.visibility="visible";
		document.all.const2.style.position="relative";
	}
	else
	{
		document.all.const1.style.visibility="hidden";
		document.all.const1.style.position="absolute";
		document.all.const2.style.visibility="hidden";
		document.all.const2.style.position="absolute";
	}
	document.forms[0].sel_visibility.disabled = true;
	document.forms[0].sel_introducer_type.disabled = true;

	if(document.forms[0].seldataheadtype.value=="2")
    {
		if(varCGTMSE !=""){
			document.forms[0].sel_cg.value=varCGTMSE;
		}else{
			document.forms[0].sel_cg.value="S";
		}
    }
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
	}
}

function disablefields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		} 	
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		} 
		if(document.forms[0].elements[i].type=='select-multiple')
		{
			document.forms[0].elements[i].disabled=one;
		} 	
	}
	document.forms[0].seldataheadtype.disabled = false;
}

function doSave()
{	
    if((document.forms[0].seldataheadtype.value == "" ) || (document.forms[0].seldataheadtype.value == "0" ))
	{
	ShowAlert(111,"the Data Heads");
	document.forms[0].seldataheadtype.focus();
	return false;
	}
    if(trim(document.forms[0].txt_datavalues.value)=="")
	{
	ShowAlert(121,"the Data Values");
	document.forms[0].txt_datavalues.focus();
	return ;
	}
    if(trim(document.forms[0].txt_datacode.value)=="")
	{
	ShowAlert(121,"the CBS Data Code");
	document.forms[0].txt_datacode.focus();
	return ;
	}
    if((document.forms[0].seldataheadtype.value=="27" || document.forms[0].seldataheadtype.value=="32") &&trim(document.forms[0].txt_datacodepass.value)=="")
	{
		ShowAlert(121,"the CBS Data Code to be Passed");
		document.forms[0].txt_datacodepass.focus();
		return ;
	}
    if(document.forms[0].seldataheadtype.value=="34")
	{
    	if(document.forms[0].txt_interestcode.value=="")
    	{
			ShowAlert(121,"the Interest Type Code to be Passed");
			document.forms[0].txt_interestcode.focus();
			return ;
    	}
    	if(document.forms[0].sel_spread1.value=="")
    	{
			ShowAlert(111,"Spread1 Type");
			document.forms[0].sel_spread1.focus();
			return ;
    	}
    	if(document.forms[0].sel_spread2.value=="")
    	{
			ShowAlert(111,"Spread2 Type");
			document.forms[0].sel_spread2.focus();
			return ;
    	}
	}
    if(trim(document.forms[0].sel_visibility.value)=="")
	{
	ShowAlert(111,"Visibility");
	document.forms[0].sel_visibility.focus();
	return ;
	}	
    if(document.forms[0].seldataheadtype.value=="20")
	{
    if(document.forms[0].userlist.value == "0" ) 
	{
	ShowAlert(111,"Head of the Department");
	document.forms[0].userlist.focus();
	return false;
	}
	}
    else
    {
    }
    if(document.forms[0].seldataheadtype.value=="6")
	{
	    if(document.forms[0].sel_introducer_type.value == "0" ) 
		{
		ShowAlert(111,"Introducer status");
		document.forms[0].sel_introducer_type.focus();
		return false;
		}
	}
    if(document.forms[0].seldataheadtype.value=="2")
	{
	    if(document.forms[0].sel_const_type.value == "0" || document.forms[0].sel_const_type.value == "") 
		{
			ShowAlert(111,"Constitution Type");
			document.forms[0].sel_const_type.focus();
			return false;
		}
		
		if(document.forms[0].sel_cg.value=="" || document.forms[0].sel_cg.value=="S")
		{
			 ShowAlert(111,"Whether CGTMSE applicable");
			 document.forms[0].sel_cg.focus();
			 return;
		}
		if(document.forms[0].sel_CGTMSE_CONS.value=="" || document.forms[0].sel_CGTMSE_CONS.value=="S")
		{
			 ShowAlert(111,"CGTMSE Constitution");
			 document.forms[0].sel_CGTMSE_CONS.focus();
			 return;
		}
		var str_ConcernType ="";
		for(var i=0;i<document.forms[0].comapp_divisiontype.options.length;i++)
		{
			if(document.forms[0].comapp_divisiontype.options[i].selected)
			{				
				str_ConcernType=str_ConcernType+document.forms[0].comapp_divisiontype.options[i].value+"@";
			}		
		}
		document.forms[0].hidsel_ConcernType.value=str_ConcernType;
		
		
    }
    if(document.forms[0].seldataheadtype.value=="26")
	{
		if(document.forms[0].sel_orglevel.value=="")
		{
			 ShowAlert(111,"Organisation Level");
			 document.forms[0].sel_orglevel.focus();
			 return;
		}
		else if(document.forms[0].sel_orglevel.value=="C" && document.forms[0].sel_department.value=="")
		{
			 ShowAlert(111,"Department");
			 document.forms[0].sel_department.focus();
			 return;
		}

		var str_type ="";
		for(var i=0;i<document.forms[0].sel_subdepartment.options.length;i++)
		{
			if(document.forms[0].sel_subdepartment.options[i].selected)
			{				
				str_type=str_type+document.forms[0].sel_subdepartment.options[i].value+"@";
			}		
		}
		document.forms[0].hidsubdept.value=str_type;
		if(document.forms[0].sel_orglevel.value=="C" && str_type=="")
		{
			 ShowAlert(111,"Sub Department");
			 return;
		}
    }
    if(document.forms[0].seldataheadtype.value=="131"&& document.forms[0].txt_sancrefno.value=="")
	{
			 ShowAlert(121,"Sanction Reference No");
			 document.forms[0].txt_sancrefno.focus();
			 return;
	}
	if(document.forms[0].seldataheadtype.value=="2")
	{
		if(document.forms[0].beneficial_owner_cap.value=="s")
		{
		alert("Please Select Whether Beneficial Owner is YES OR NO ");
		document.forms[0].beneficial_owner_cap.focus();
		return;
		}
	}
	if(document.forms[0].seldataheadtype.value=="27")
	{
		if(document.forms[0].legalopinion.value=="s")
		{
		alert("Please Select Whether legal opinion verifier is YES OR NO ");
		document.forms[0].legalopinion.focus();
		return;
		}
	}
	if(document.forms[0].seldataheadtype.value=="27")
	{
		if(document.forms[0].ddrbir.value=="s")
		{
		alert("Please Select Whether DDR/BIR verifier is YES OR NO ");
		document.forms[0].ddrbir.focus();
		return;
		}
	}
    document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateCBSstaticdata";
	document.forms[0].hidBeanGetMethod.value="getCBSstaticdata";
	document.forms[0].hidSourceUrl.value="/action/cbs_datamaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();			
	}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Cancel";
		document.forms[0].hidBeanGetMethod.value="getCBSstaticdata";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].action=appURL+"action/cbs_datamaster.jsp";	
		document.forms[0].submit();
	}
}

function doDelete()
{
	var varconfirm=ConfirmMsg('101');
	if(varconfirm)
	{
	    document.forms[0].hidAction.value="Delete";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanMethod.value="updateCBSstaticdata";
		document.forms[0].hidBeanGetMethod.value="getCBSstaticdata";
		document.forms[0].hidSourceUrl.value="/action/cbs_datamaster.jsp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	}
}

function doNew() 
{
	if(document.forms[0].seldataheadtype.value=="0")
	{
		ShowAlert(111,"Data Heads");
		document.forms[0].seldataheadtype.focus();
		return ;
	}
	ClearFields();
	document.forms[0].hidAction.value="insert";
   	enableButtons(true, true, false, false, true,true);
   	disablefields(false);   	
   	document.forms[0].sel_visibility.disabled = false;
   	document.forms[0].sel_introducer_type.disabled = false;
}

function doEdit() 
{
	if(document.forms[0].txt_datavalues.value=="")
	{
		ShowAlert(111,"Data Values Sno from the list");
		document.forms[0].txt_datavalues.focus();
		return ;
	}
    document.forms[0].hidAction.value="update";
    enableButtons(true, true, false, false, true,true);
	disablefields(false);
	document.forms[0].sel_visibility.disabled = false;
	document.forms[0].sel_introducer_type.disabled = false;
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	//document.forms[0].cmddelete.disabled=bool6;
}

function selectValues(val0,val1,val2,val3,val4,val5,val6,val7,val9,val11,val12,val13,val14)
{
	document.forms[0].txt_datacode.value = val0;
	document.forms[0].txt_datavalues.value = val1;
	document.forms[0].sel_visibility.value = val2;
	document.forms[0].txt_hidsno.value = val3;
	document.forms[0].seldataheadtype.value = val4;
	
	
	if(val4=="20")
	document.forms[0].userlist.value = val5;
	else if(val4=="6")
	document.forms[0].sel_introducer_type.value = val5;	
	else if(val4=="26")
	document.forms[0].sel_department.value = val5;	
	else if(val4=="34")
	document.forms[0].txt_interestcode.value = val5;	
	else if(val4=="27" || val4=="32"|| val4=="15")
		document.forms[0].txt_datacodepass.value = val5;
	     if(val4=="27")
	     {
	    	 document.forms[0].legalopinion.value = val12; 
	    	 document.forms[0].ddrbir.value = val13;  
	     }
	else
		document.forms[0].txt_datacodepass.value=val5;
	if(val4=="2")
	{
		document.forms[0].sel_const_type.value = val7;
		document.forms[0].sel_CGTMSE_CONS.value = val14;
		document.forms[0].beneficial_owner_cap.value = val11;
		var strModuleType=val9;
		var strModuleType_temp =strModuleType.split("@");	
		for(var j=0;j<10;j++)
		{
				document.forms[0].comapp_divisiontype.options[j].selected=false;
		}
		
		for(var i=0;i<strModuleType_temp.length-1;i++)
		{
			var selValue=strModuleType_temp[i];
			for(var j=0;j<10;j++)
			{
				if(selValue==document.forms[0].comapp_divisiontype.options[j].value)	
					document.forms[0].comapp_divisiontype.options[j].selected=true;
			}
		}

	}
	else if(val4=="26")
	{
		document.forms[0].hidsubdept.value = val7;
		if(val7!="")
		{
			var str_type_temp =val7.split("@");	
			for(var j=0;j<str_type_temp.length-1;j++)
			{
				var selValue=str_type_temp[j];
			
				for(var i=0;i<document.forms[0].sel_subdepartment.options.length;i++)
				{
					if(document.forms[0].sel_subdepartment.options[i].value==selValue)
					{				
						document.forms[0].sel_subdepartment.options[i].selected=true;
					}
					else
					{				
						document.forms[0].sel_subdepartment.options[i].selected=false;
					}		
				}		
				
			}
		}
		else
		{
			for(var i=0;i<document.forms[0].sel_subdepartment.options.length;i++)
			{
					document.forms[0].sel_subdepartment.options[i].selected=false;
			}
		}
	}
	else if(val4=="131"||val4=="130")
		document.forms[0].txt_sancrefno.value = val7;
	else if(val4=="34")
		document.forms[0].sel_spread1.value = val7;
	else
		document.forms[0].txt_refno.value = val7;

	if(document.forms[0].seldataheadtype.value=="2")
    {
		if(val6=="")
		{
		document.forms[0].sel_cg.value = "S";
		}
		else
		{
		document.forms[0].sel_cg.value = val6;
		}	
    }
	else if(document.forms[0].seldataheadtype.value=="26")
    {
		document.forms[0].sel_orglevel.value = val6;
    }
	else if(val4=="34")
		document.forms[0].sel_spread2.value = val6;
    enableButtons(true, false, true, false, true,false);
}

function selvalues()
{		
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getCBSstaticdata";
	document.forms[0].action=appURL+"action/cbs_datamaster.jsp?DataHeads="+document.forms[0].seldataheadtype.value;
	document.forms[0].submit();
} 
</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form class="normal" name="appform" method="post" action="">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup  -&gt; CBS Data Master</td></tr>
</table>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellpadding="5" cellspacing="0" align="center">
	 <tr> 
      <td valign="top">       
              <table class="outertable" border="0" cellspacing="0" cellpadding="0" width="100%" align="center">
                <tr> 
                  <td valign="top"> 
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="3">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="5">
                                  <tr> 
                                    <td width="8%" nowrap="nowrap">Data Heads</td>
                                    <td width="13%"> 
                                      <select name="seldataheadtype" tabindex="2" onchange="selvalues()">
                                        <option value="" selected="selected">&lt;----Select----&gt;</option>
                                        <lapschoice:CBSStaticDataTag/> 
                                      </select>
                                    </td>
                                    <td width="9%" nowrap="nowrap">Data Values</td>
                                    <td width="70%" colspan="3"> 
                                      <input type="text" name="txt_datavalues" size="80" maxlength="40" onKeyPress="notAllowSplChar()" value="<%=Helper.correctNull((String)hshValues.get("stat_data_desc"))%>">
                                    </td>
                                  </tr>
								  <tr> 
                                    <td width="8%" nowrap="nowrap">CBS Data Code</td>
                                    <td width="13%"> <input type="text" name="txt_datacode" size="6" onKeyPress="notAllowSplChar()" value=""> </td>
                                    
                                    <td id="id_Codepass1" nowrap="nowrap">CBS Data Code to be Passed</td>
                                    <td id="id_Codepass2"><input type="text" name="txt_datacodepass" size="8" maxlength="4" onKeyPress="notAllowSplChar()" value=""> </td>
                                    
                                     <td id="id_interesttype1" nowrap="nowrap">Interest Type Code to be Passed</td>
                                    <td id="id_interesttype2"><input type="text" name="txt_interestcode" size="8" maxlength="4" onKeyPress="notAllowSplChar()" value=""> </td>
                                  <%if(dataHead.equals("27"))  {%>  
                                    <td nowrap="nowrap">Whether legal opinion verifier <span class="mantatory">*</span> </td>
						   
						   
						   <td><select name="legalopinion">
							<option value="s" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
                                     <%} %>
                                      <%if(dataHead.equals("27"))  {%>  
                                    <td nowrap="nowrap">Whether DDR/BIR verifier <span class="mantatory">*</span> </td>
						   
						   
						   <td><select name="ddrbir">
							<option value="s" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
                                     <%} %>
                                    
                                    <td nowrap="nowrap">Visibility</td>
                                    <td><select name="sel_visibility">
                                      	<option value="E" selected="selected">Enable</option>
                                      	<option value="D">Disable</option>
                                      </select></td>
									  <td nowrap="nowrap" id="head1">Head of the Department<span class="mantatory">*&nbsp;</span> </td>
                                    <td id="head2"><select name="userlist">
									<option value="0" selected="selected">&lt;----Select----&gt;</option>
									<lapschoice:HeadUserListTag />
								</select></td>
									<td id="intro1">Introducer Type<span class="mantatory">*</span></td>
					                <td id="intro2"><select name="sel_introducer_type">
					                <option value="0" selected>--Select--</option>
					                <option value="1">Staff</option>
					                <option value="2">Existing Customer</option>
					                <option value="3">Others</option>
					                </select>
					                </td>
									<td id="const1">Constitution Type<span class="mantatory">*</span></td>
					                <td id="const2"><select name="sel_const_type">
					                <option value="0" selected>--Select--</option>
					                <option value="P">Partnership</option>
					                <option value="C">Company/Corporate</option>
					                <option value="T">Trust</option>
					                <option value="H">HUF</option>
					                <option value="O">Others</option>
					                </select>
					                </td>
                                  </tr>
                                  <tr>
                                  <td id="id_interesttype3" nowrap="nowrap">Spread rate 1</td>
                                    <td id="id_interesttype4"><select name="sel_spread1">
                                    <option value=""><--select--></option>
					                 <lapschoice:StaticDataTag apptype="224"  tagType=""/>
					                </select></td>
                                     
                                     <td id="id_interesttype5" nowrap="nowrap">Spread rate 2</td>
                                    <td id="id_interesttype6"><select name="sel_spread2">
                                     <option value=""><--select--></option>
					                 <lapschoice:StaticDataTag apptype="224" tagType=""/>
					                </select> </td>
                                  </tr>
                                  <%if(dataHead.equals("26"))  {%>
                                  <tr>
                                  <td>Department</td>
					                <td><select name="sel_department">
					                <option value="" selected>--Select--</option>
					                 <lapschoice:CBSStaticDataNewTag apptype='20' />
					                </select>
					                </td>
                                  <td>Sub Department</td>
					                <td><select name="sel_subdepartment"  multiple="multiple">
					                 <lapschoice:CBSStaticDataNewTag apptype='131' />
					                </select>
					                </td>
									<td>Organisation Level<span class="mantatory">*</span></td>
					                <td><select name="sel_orglevel">
					                <option value="" selected>--Select--</option>
					                <option value="C">Head Office</option>
					                <option value="R">Regional Office</option>
					                <option value="D">CLPU</option>
					                <option value="A">Branch</option>
					                </select>
					                </td>
                                  </tr>
                                  <%}else if(dataHead.equals("131")||dataHead.equals("130"))  { %>
                          <tr>
						<td nowrap="nowrap">Sanction Reference No&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><input type="text" name="txt_sancrefno" size="8" maxlength="6" onKeyPress="notAllowSplChar()" value=""> </td>
						</tr>    
						
					 <%}else if(dataHead.equals("2"))  {%>	
					   <tr valign="top">
						<td nowrap="nowrap">Whether CGTMSE applicable&nbsp;<b><span
							class="mantatory">*</span></b></td>
						<td><select name="sel_cg">
							<option value="S" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
						
						<td nowrap="nowrap">CGTMSE Concern Type Exceptions &nbsp;</td>
						<td>
						<select name="comapp_divisiontype" size="11" multiple="multiple" tabindex="1">
							<option value="Division">Division</option>
							<option value="Sister concern">Sister Concern</option>
							<option value="Group concern">Group Concern</option>
							<option value="O">Share Holders</option>
							<option value="D">Directors</option>
							<option value="SP">Sole Proprietor</option>
							<option value="PT">Partner</option>
							<option value="T">Trustee</option>
							<option value="K">Karta</option>
						    <option value="PA">Power of Attorney</option>
							<option value="OT">Others</option>
						</select>
						</td>
						<td nowrap="nowrap">Whether Beneficial Owner Capturing <span class="mantatory">*</span> </td>
						<td><select name="beneficial_owner_cap">
							<option value="s" selected="selected">---- Select	----</option>
							<option value="Y">Yes</option>							
							<option value="N">No</option>							
						</select></td>
						</tr>
						<tr>
						<td nowrap="nowrap">CGTMSE Constitution <span class="mantatory">*</span> </td>
						<td><select name="sel_CGTMSE_CONS">
						<option value="S"><--select--></option>
					                 <lapschoice:StaticDataTag apptype="282" tagType=""/>
					               							
						</select>
							</td>
						</tr>
						
						
				  	<% } %>
						
                                
                                <tr><td width="8%" nowrap="nowrap">&nbsp;</td><td width="13%">&nbsp;</td><td width="9%" nowrap="nowrap">&nbsp;</td><td width="70%" colspan="3">&nbsp;</td></tr>
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
                                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                                  <br>                                
                                <table class="outertable" width="98%" border="0" cellspacing="0" cellpadding="0" align="center">
                                  <tr> 
                                    <td valign="top" align="center"> 
                                      <table class="outertable linebor" width="100%" border="0" cellspacing="0" cellpadding="3">
                                        <tr class="dataheader"> 
                                          <td width="3%" >&nbsp;</td>
                                          <td width="7%" align="center" ><b>S No.</b></td>
                                          <td width="40%"  align="center"><b>Data Values</b></td>
										  <td width="40%"  align="center"><b>Data Code</b></td>
										  <td width="10%"  align="center"><b>Visibility</b></td>
										  <%if(dataHead.equals("2"))
										  {%>
										  <td width="10%"  align="center"><b>CGTMSE</b></td>
										  <td>Constitution Type</td>
										  
										  <%} %>
										
										  </tr>
                                        
                                      	<%
											if (arrRow != null && arrRow.size() > 0) 
											{
											for (int i = 0; i < arrRow.size(); i++) 
											{
											arrCol = (ArrayList) arrRow.get(i);
											
											String strVisibility = Helper.correctNull((String)arrCol.get(2));
											String strVisibility1= "";
											if(strVisibility.equalsIgnoreCase("E"))
											{
												strVisibility1 = "Enable";
											}
											if(strVisibility.equalsIgnoreCase("D"))
											{
												strVisibility1 = "Disable";
											}
											
											String strCGTMSE = Helper.correctNull((String)arrCol.get(6));
											if(strCGTMSE.equalsIgnoreCase("S"))
											{
												strCGTMSE = "";
											}
											else if(strCGTMSE.equalsIgnoreCase("Y"))
											{
												strCGTMSE = "Yes";
											}
											else if(strCGTMSE.equalsIgnoreCase("N"))
											{
												strCGTMSE = "No";
											}
											
											String strConstType=Helper.correctNull((String)arrCol.get(7));
											if(strConstType.equals("P"))
												strConstType="Partnership";
											else if(strConstType.equals("C"))
												strConstType="Company/Corporate";
											else if(strConstType.equals("T"))
												strConstType="Trust";
											else if(strConstType.equals("H"))
												strConstType="HUF";
											else if(strConstType.equals("O"))
												strConstType="Others";
											
										%>
                                          <tr class="datagrid"> 
                                            <td width="3%"> 

                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)arrCol.get(0))%>','<%=Helper.correctNull((String)arrCol.get(1))%>','<%=Helper.correctNull((String)arrCol.get(2))%>','<%=Helper.correctNull((String)arrCol.get(3))%>','<%=Helper.correctNull((String)arrCol.get(4))%>','<%=Helper.correctNull((String)arrCol.get(5))%>','<%=Helper.correctNull((String)arrCol.get(6))%>','<%=Helper.correctNull((String)arrCol.get(7))%>','<%=Helper.correctNull((String)arrCol.get(9))%>','<%=Helper.correctNull((String)arrCol.get(10))%>','<%=Helper.correctNull((String)arrCol.get(11))%>','<%=Helper.correctNull((String)arrCol.get(12))%>','<%=Helper.correctNull((String)arrCol.get(13))%>')">

                                            <td width="7%" align="center"><%=i+1%></td>
                                            <td width="40%" align="left">&nbsp;<%=Helper.correctNull((String)arrCol.get(1))%></td>
											<td width="40%" align="center"><%=Helper.correctNull((String)arrCol.get(0))%></td>
											<td width="10%" align="center"><%=strVisibility1%></td>
											
											<%if(dataHead.equals("2")) {%>
											    <td width="10%" align="center"><%=strCGTMSE%></td>
												<td width="40%" align="center"><%=strConstType%></td>
											<%}%>
                                          </tr>
                                          <%}} %>
                                           <tr class="datagrid"> 
                                            <td width="3%">&nbsp; </td>
                                            <td width="7%">&nbsp; </td>
                                            <td width="40%">&nbsp; </td>
											<td width="40%">&nbsp; </td>
											<td width="10%">&nbsp; </td>
											<%if(dataHead.equals("2")) {%>
											<td width="10%">&nbsp; </td>
											<td>&nbsp; </td>
											<%}%>
                                          </tr>
                                        </table>
                                        </td>
                                        </tr>
                                        </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type ="hidden" name ="hidkeyid" value="set">
   <input type="hidden" name="seldataheadtype1">
  <input type="hidden" name="org_code" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="strOrgCode" value ="<%=session.getAttribute("strOrgCode")%>" >
  <input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("stat_data_sno"))%>">
  <input type="hidden" name="hidstate" value="2">
  <input type="hidden" name="hidstatenew" value="">
  <input type="hidden" name="txt_hidsno" value="">  
  <input type="hidden" name="txt_refno" value="">  
  <input type="hidden" name="hidsubdept" value="">  
  <input type="hidden" name="hidsel_ConcernType" value="">  
  
  
<br> 
</form>
</body>
</html>
