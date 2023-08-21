<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<% request.setAttribute("_cache_refresh", "true"); %>
<% 
String strCatName="";
if(strCategoryType.equals("CORPORATE")||strCategoryType.equals("CORP") || strCategoryType.equals("SME"))
{
	strCategoryType ="CORP";
	strCatName="Corporate";
	
}
else if(strCategoryType.equals("OPS"))
{
	strCatName="Tertiary";
}

String bid=Helper.correctNull((String)hshValues.get("borrowerid"));
String strAppID="";
if (bid.trim().equals(""))
{
 strAppID=request.getParameter("comapp_id");
}
else
{
 strAppID=Helper.correctNull((String)hshValues.get("borrowerid"));
}
String strAppno=request.getParameter("appno");
String strBorrowerType =Helper.correctNull((String)request.getParameter("hidBorrowerType"));
String strIstakeover=Helper.correctNull((String)hshValues.get("istakeover"));
String strreason=Helper.correctNull((String)hshValues.get("reason"));
String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();
ArrayList vecRow=new ArrayList();
ArrayList vecCol=new ArrayList();
if(hshValues!=null)
{
	vecRow=(ArrayList)hshValues.get("vecData");
}
%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">


<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var isTakeover="<%=Helper.correctNull((String)hshValues.get("istakeover"))%>";  
var varNatureofLoan="<%=Helper.correctNull((String)hshValues.get("comtak_NatureLoan"))%>";  
var varReasonTakingOver="<%=Helper.correctNull((String)hshValues.get("reason"))%>"; 
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
var varGrpRights="<%=(Helper.correctNull((String)session.getAttribute("strGroupRights"))).charAt(18)%>";
function disablecontrols(val1,edit,save,cancel,cdelete,close)
{
	document.forms[0].cmdnew.disabled = val1;
	document.forms[0].cmdedit.disabled = edit;
	document.forms[0].cmdsave.disabled = save;
	document.forms[0].cmdcancel.disabled = cancel;
	document.forms[0].cmddelete.disabled = cdelete;
	document.forms[0].cmdclose.disabled = close;
}
function calldisable(val)
{
	for(i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type == "text" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "textarea" )
		{
			document.forms[0].elements[i].disabled = val;
		}
		if(document.forms[0].elements[i].type == "select-one" )
		{
			document.forms[0].elements[i].disabled = val;
		}
    }
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanGetMethod.value="gettakeover";
		document.forms[0].action=appUrl+"action/com_istakeover.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	calldisable(false);
	disablecontrols(true,true,false,false,false,true);
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="edit";
	document.forms[0].sel_Reasontakover.disabled=false;
}
function doNew()
{
	calldisable(false);
	disablecontrols(true,true,false,false,true,true);
	document.forms[0].hidAction.value ="insert";
	document.forms[0].sel_Reasontakover.disabled=false;
}
function doSave()
{
	var str_type ="";
	for(var i=0;i<document.forms[0].sel_Reasontakover.options.length;i++)
	{
		if(document.forms[0].sel_Reasontakover.options[i].selected)
		{				
			str_type=str_type+document.forms[0].sel_Reasontakover.options[i].value+"@";
		}		
	}
	if(document.forms[0].istakeover.value=="0")
	{
		alert("Select whether Takeover");
		document.forms[0].istakeover.focus();
		return;
	}
	if(document.forms[0].istakeover.value=="1")
	{
		if(str_type=="")
		{
			alert("Please Select the Reason for Taking Over");
			document.forms[0].sel_Reasontakover.focus();
		 	return;
		}
		if(document.forms[0].txt_bankname.value=="")
		{
			alert("Enter the Bank's Name");
			document.forms[0].txt_bankname.focus();
		 	return;
		}
		if(document.forms[0].sel_Natureloan.value=="")
		{
			alert("Select the Nature of Loan");
			document.forms[0].sel_Natureloan.focus();
		 	return;
		}
		if(document.forms[0].txt_mainlimit.value=="" || document.forms[0].txt_mainlimit.value=="0.00")
		{
			alert("Please Enter the Main Limit");
			document.forms[0].txt_mainlimit.focus();
		 	return;
		}
		if(document.forms[0].txt_Outstanding.value=="" || document.forms[0].txt_Outstanding.value=="0.00")
		{
			alert("Please  Enter the Outstanding Balance");
			document.forms[0].txt_Outstanding.focus();
		 	return;
		}
	}
	else
	{
		document.forms[0].txt_bankname.value="";
		document.forms[0].sel_Natureloan.value="";
		document.forms[0].txt_mainlimit.value="";
		document.forms[0].txt_Outstanding.value="";
		document.forms[0].sel_Reasontakover.value="";
		document.forms[0].hidReasontakover.value="";
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidReasontakover.value=str_type;
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updatetakeover";
	document.forms[0].hidBeanGetMethod.value="gettakeover";
	document.forms[0].hidSourceUrl.value="/action/com_istakeover.jsp";
	document.forms[0].submit();
}
function doDelete()
{
	if (ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].hidBeanId.value="comproposal";
		document.forms[0].hidBeanMethod.value="updatetakeover";
		document.forms[0].hidBeanGetMethod.value="gettakeover";
		document.forms[0].hidSourceUrl.value="/action/com_istakeover.jsp";
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(158);
	}	
}		

function callOnload()
{

	if(isTakeover =="1")
	{
		document.forms[0].istakeover.value="1";
		document.forms[0].sel_Reasontakover.disabled=true;
		document.forms[0].istakeover.disabled = false;
	}
	else if(isTakeover =="2")
	{
		document.forms[0].istakeover.value="2";
		document.forms[0].istakeover.disabled = true;	
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		disablecontrols(true,false,true,true,true,true);
		}
	}
	else
	{
		document.forms[0].istakeover.value="0";
		document.forms[0].istakeover.disabled = true;	
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		disablecontrols(true,false,true,true,true,true);	
		}
	}  
		//disableCommandButtons(true,true,true,true,true,false);

	if(varGrpRights=='r')
	{
		document.forms[0].istakeover.disabled = true;
	}
	}

	

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/corppge.jsp";
		document.forms[0].submit();
	}
} 

function showTakeover(val)
{
	var btnenable=document.forms[0].btnenable.value;
		
	if(document.forms[0].istakeover.value=="1")
	{	

		var strList=[];
		for(var j=0;j<document.forms[0].sel_Reasontakover.options.length;j++)
		{
			strList[j]= document.forms[0].sel_Reasontakover.options[j].value;
		}
		var str_type_temp =varReasonTakingOver.split("@");
		for(var i=0;i<str_type_temp.length-1;i++)
		{
			var selValue=str_type_temp[i];
			for(var j=0;j<strList.length;j++)
			{
				if(strList[j]==selValue)	
				{		
					document.forms[0].sel_Reasontakover.options[j].selected=true;
				}
			}			
		}
		document.getElementById("ID1").style.display = "table-cell";
		document.getElementById("ID2").style.display = "table";
		document.getElementById("ID3").style.display = "table";
		calldisable(true);
		document.forms[0].istakeover.disabled=false;
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
		disablecontrols(false,true,true,true,true,false);
		}
	}	
	else if(document.forms[0].istakeover.value=="2")
	{
		document.getElementById("ID1").style.display = "none";		
		document.getElementById("ID2").style.display = "none";
		document.getElementById("ID3").style.display = "none";
		if(val == "page")
		{
			document.forms[0].hidAction.value="insert";
			
			disablecontrols(true,true,false,false,false,true);
			
		}
	} 
	else if(document.forms[0].istakeover.value=="0")
	{
		document.getElementById("ID1").style.display = "none";		
		document.getElementById("ID2").style.display = "none";
		document.getElementById("ID3").style.display = "none";
		if(val == "page")
		{
			document.forms[0].hidAction.value="insert";
			
			disablecontrols(false,true,true,true,true,false);
			
		}
	}
	if(varGrpRights=='r')
	{
		document.forms[0].istakeover.disabled = true;
	}
}

function selectValues(val1,val2,val3,val4,val5,val6)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].txt_bankname.value=val2;
	document.forms[0].sel_Natureloan.value=val3;
	document.forms[0].txt_mainlimit.value=val4;
	document.forms[0].txt_Outstanding.value=val5;
	document.forms[0].hid_LeadBankcode.value=val6;
	if(document.forms[0].btnenable.value.toUpperCase()=="Y")
	{
	disablecontrols(true,false,true,true,true,false);
	}
	calldisable(true);	
}

function callBankmaster(id)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
			var varQryString = appURL+"action/ops_sanctionhelp.jsp?hidBeanGetMethod=getSearch&hidBeanId=additionalParameter&pagename=Takeover&id="+id;
			var title = "Bank_Master";
			var prop = "scrollbars=no,width=650,height=400";
			var xpos = "50";
			var ypos = "50";
			prop = prop+","+xpos+","+ypos+",left=200,top=200";
			window.open(varQryString,title,prop);
	}
}

</script>
</head>
<body onload="callOnload();showTakeover()">
<form name="frmpri" method="post" class="normal">
<%if(strCategoryType.equalsIgnoreCase("OPS")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr> 
      <td> 
        <jsp:include page="../share/applurllinkscom.jsp" flush="true"> 
        <jsp:param name="pageid" value="17" />
        <jsp:param name="cattype" value="<%=strCategoryType%>" />
        <jsp:param name="ssitype" value="<%=strSSIType%>" />
        </jsp:include>
      </td>
    </tr>
 </table>
<%}else{ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
		<td><jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="41" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include> <input type="hidden" name="comapp_id" value="<%=strBorrowerId%>">
		</td>
	</tr>
</table>
<%} %>

<%if(strSessionModuleType.equalsIgnoreCase("AGR")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
<tr> 
 <td class="page_flow">
 Home -&gt; Agriculture -&gt; Application -&gt; Take Over Norms -&gt; Take Over
 </td>
</tr>
</table><%}else if(strCategoryType.equalsIgnoreCase("OPS")){ %>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
 <tr> 
  <td class="page_flow">
  Home -&gt; Tertiary -&gt; Application -&gt; Take Over Norms -&gt; Take Over
  </td>
 </tr>
</table>
<%}else {%>
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr>
        
		<td class="page_flow">Home&nbsp;-&gt;Corporate &amp; SME -&gt; Application -&gt; Take Over Norms -&gt; Take Over</td>
    </tr>
</table>
<%} %>
    <span style="display:none"><lapschoice:borrowertype /></span> <lapschoice:application/>
    <lapstab:TakeoverTab tabid="1" istakeover='<%=strIstakeover%>'/>
  <table width="98%" border="0" cellspacing="0" cellpadding="5" class="shadow" align="center" class="outertable">
    <tr> 
      <td valign="top">  
        <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1">
          <tr> 
            <td valign="top"><table width="100%" border="0" cellspacing="1" cellpadding="4" class="outertable">
              <Tr>
                <td> Is Take Over :
                  <select name="istakeover" onchange="showTakeover('page')">
                      <option value=0 selected>--Select-- </option>
                      <option value=1 >Yes </option>
                      <option value=2 >No </option>
                    </select>
                </td>
             <td id="ID1">  Reason for Taking Over<span class="mantatory">*</span> 
	          <select name="sel_Reasontakover" multiple="multiple">
	          <option value="0">&lt;----Select----&gt;</option>
	          <lapschoice:StaticDataNewTag apptype="145" />
	          </select>
	     </td></tr>
            </table></td>
          </tr>
        </table></td></tr>
        <tr>
        <td>
         <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable border1" id="ID2">
         <tr>
         <td>
          <table width="100%" border="0" cellspacing="1" cellpadding="1" class="outertable">
	         <tr align="center" class="dataheader" >
	              <td width="40%">Bank's Name <span class="mantatory">*</span></td>
	              <td width="15%">Nature of Loan <span class="mantatory">*</span></td>
	              <td width="15%">Main Limit <span class="mantatory">*</span></td>
	              <td width="15%">Outstanding Balance <span class="mantatory">*</span></td>
	         </tr>
	         <tr align="center">
	         <td align="center">
					<input type="text" name="txt_bankname" value="" size="30" readOnly="readonly"  
						maxlength="50"  onKeyPress="notAllowSingleAndDoubleQuote();notAllowSplChar()"
						 tabindex="2">
						 <input type="hidden" name="hid_LeadBankcode" value="">
				<a href="#" onClick="callBankmaster('147')" style="cursor: hand">
				<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
				</a>
			</td>
	         
	         <td>
	          <select name="sel_Natureloan">
                 <option value="" selected>&lt;----Select----&gt;</option>                      
               <lapschoice:StaticDataNewTag apptype="144" /> 
              </select>
                                    </td>
	        
	        <td>
				   <lapschoice:CurrencyTag name="txt_mainlimit"	maxlength="15" size="12"
				   onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this)"  value='<%= Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("comtak_mainlimit")))%>'/>
		   </td>
	         
	       <td>
				  <lapschoice:CurrencyTag name="txt_Outstanding"	maxlength="15" size="12" 
				  onKeyPress="allowDecimals(this)" style="text-align:right" onBlur="roundtxt(this)"  value='<%=Helper.checkDecimal(Helper.correctDouble((String)hshValues.get("comtak_Outstanding")))%>'/>
		  </td>
	      </tr>
    </table></td></tr></table>
    </td>
    </tr>
    <tr><td>&nbsp;&nbsp;</td></tr>
	</table>
	
<br>
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trail' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							
 <br>
								
							
								<table width="90%" border="0" cellspacing="1" cellpadding="2" class="outertable" align="center" id="ID3">
											
																	
								<tr  align="center" class="dataheader">				
								 <td width="30%" align="center">Bank's Name</td>
								 <td width="20%" align="center">Nature of Loan</td>
								 <td width="20%" align="center">Main Limit</td>
								 <td width="20%" align="center">Outstanding Balance</td>
								</tr>
									<%if(vecRow!=null && vecRow.size()>0){
									  for(int i=0;i<vecRow.size();i++){
										  
										  vecCol=(ArrayList)vecRow.get(i);
									  
									  %>						
									<tr class="datagrid">
									 <td><input type="radio" style="border:none" name="selradio" onclick="javascript:selectValues('<%=Helper.correctNull((String)vecCol.get(0))%>',
									 '<%=Helper.correctNull((String)vecCol.get(2))%>','<%=Helper.correctNull((String)vecCol.get(6))%>','<%=Helper.correctNull((String)vecCol.get(4))%>','<%=Helper.correctNull((String)vecCol.get(5))%>','<%=Helper.correctNull((String)vecCol.get(7))%>')">&nbsp;&nbsp;<%=Helper.correctNull((String)vecCol.get(2))%></td>
									 <td><%=Helper.correctNull((String)vecCol.get(3))%></td>
									 <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)vecCol.get(4)))%></td>
									 <td align="right"><%=Helper.checkDecimal(Helper.correctNull((String)vecCol.get(5)))%></td>
									
									</tr>	
									
									<%}}else{ %>
									
									 <tr class="datagrid">
									 <td colspan="7" align="center">---No Data Found--</td>
									 </tr>
									
									<%} %>						
									
								</table>
								</td>
							</tr>	
	

<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type=hidden name="comapp_id" value="<%=strAppID%>">
<input type=hidden name="ano" value="<%=strAppno%>">
<input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
<input type="hidden" name="ssitype" value="<%=strSSIType%>"> 
<input type="hidden" name="id" value="<%=strBorrowerType%>">
<input type="hidden" name="hidReasontakover" value="">
<input type="hidden" name="hidsno">
</form>
</body>
</html>
