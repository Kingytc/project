<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.util.HashMap" scope="request" />
<html>
<head>
<%

	ArrayList arrRow = new ArrayList();
	ArrayList arrCol = new ArrayList();
	
	ArrayList arrRow2 = new ArrayList();
	ArrayList arrCol2 = new ArrayList();
	
	if (hshValues != null) 
	{
		arrRow = (ArrayList) hshValues.get("arrRow");
		arrRow2 = (ArrayList) hshValues.get("arrRow2");
	}
	int intarrSize1=0;
	int intarrSize2=0;
	if(arrRow!=null)
	{
		intarrSize1=arrRow.size();
	}
	if(arrRow2!=null)
	{
		intarrSize2=arrRow2.size();
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
var varRule ="<%=Helper.correctNull((String)hshValues.get("strRskRule"))%>";
var varRisRatFor="<%=Helper.correctNull((String)hshValues.get("strRiskRatFor"))%>";
var varRiskBankSchemCode="<%=Helper.correctNull((String)hshValues.get("strRiskbankSchemeCode"))%>";

function loadPage(){

	disablefields(true);
	
	document.all.desc1.style.visibility="hidden";
	//document.all.desc1.style.position="absolute";

	document.all.desc2.style.visibility="hidden";
	//document.all.desc2.style.position="absolute";
	document.all.desc3.style.visibility="hidden";
	document.all.desc4.style.visibility="hidden";

	document.forms[0].sel_scorerule.value=varRule;
	if(varRule!="")
	{
		document.all.desc1.style.visibility="visible";
		document.all.desc2.style.visibility="visible";	
		document.all.desc3.style.visibility="visible";
		document.all.desc4.style.visibility="visible";	
	}

	var varsize = <%=intarrSize1%>;

	if(varsize>0)
	{
		for(var i=0;i<varsize;i++)
		{
			if(document.forms[0].chkbox[i].checked)
			{
				document.forms[0].hidchk[i].value="1";
			}
			else
			{
				document.forms[0].hidchk[i].value="0";
			}
		}
	}

	<%
	for(int k=0;k<intarrSize1;k++){
		arrCol = (ArrayList) arrRow.get(k);
		if(arrCol!=null)
		{%>
		var varCheck = "<%=Helper.correctNull((String)arrCol.get(1))%>";
		if(varCheck == 0)
		{
			document.forms[0].chkbox[<%=k%>].checked=false;
		}
		else
		{
			document.forms[0].chkbox[<%=k%>].checked=true;
		}
		<%}
	}%>

	 if(varRisRatFor!="")
	 {

	   if(varRisRatFor=="R")
	   {	    
       document.forms[0].txt_ratingfor[0].checked=true;
	   }
	   else if(varRisRatFor=="C")
	   {
		   document.forms[0].txt_ratingfor[1].checked=true;
	   }	   

	 }

	 //alert(varRiskBankSchemCode);
	 var a1=varRiskBankSchemCode.split("@");
	
	  for(var c=0;c<a1.length;c++)
	  {
		  for(var b=0;b<document.forms[0].sel_bankscheme.options.length;b++)
			 {
 		if(document.forms[0].sel_bankscheme.options[b].value==a1[c])
		{
                 
          document.forms[0].sel_bankscheme.options[b].selected=true;
     
		}
		
	  }
	 }

	  if(varRiskBankSchemCode!="")
	  {
	  document.forms[0].sel_bankscheme.disabled=true;
	  }
	  else
	  {
		  document.forms[0].sel_bankscheme.disabled=false;
	  }
	  
	  

}

function disablefields(bool)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=bool;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=='select-muliple')
		{
			document.forms[0].elements[i].disabled=bool;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=bool;		  
		}		
		else if(document.forms[0].elements[i].type=="checkbox")
		{
			document.forms[0].elements[i].disabled=bool;	
		}
		else if(document.forms[0].elements[i].type=="radio")
		{
			document.forms[0].elements[i].disabled=bool;	
		}
	}
	document.forms[0].sel_scorerule.disabled=false;
}

function callDisableControls(cmdEdit,cmdSave,cmdDelete,cmdCancel,cmdClose)
{
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
   		
   		document.forms[0].hidBeanGetMethod.value="getScoringParameters";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].action=appURL+"action/setriskparameters.jsp";	
		document.forms[0].submit();
   	}
}

function doNew()
{
	document.forms[0].hideditflag.value="Y";
	document.forms[0].hidAction.value="insert";
	callDisableControls(true,true,false,true,false,true);
	document.forms[0].sel_bankscheme.disabled=false;	
}

function doEdit()
{  
	disablefields(false);
	document.forms[0].hideditflag.value="Y";
    document.forms[0].hidAction.value="insert";	
    callDisableControls(true,false,false,false,false);	
    document.forms[0].sel_bankscheme.disabled=false;
}

function doSave()
{


	if(document.forms[0].sel_scorerule.value!="")
	{

     if(document.forms[0].txtruledesc.value=="")
     {
       alert("Enter Rule Description");
       document.forms[0].txtruledesc.focus();
       return false;
     }

     if(document.forms[0].txt_ratingfor[0].checked==false && document.forms[0].txt_ratingfor[1].checked==false)
     {
       alert("Select Rating For");
       document.forms[0].txt_ratingfor[0].focus();
       return false;
     }

     if(document.forms[0].txt_rskparamcode.value=="")
     {
       alert("Enter Code passed for rating");
       document.forms[0].txt_rskparamcode.focus();
       return false;
     }

     if(document.forms[0].sel_bankscheme.value=="")
     {
       alert("Select Bank Scheme");
       document.forms[0].sel_bankscheme.focus();
       return false;
     }
	}		
	for (i=0;i<document.forms[0].elements.length;i++)
	{
		document.forms[0].elements[i].disabled = false;
	}
	
	var varsize = <%=intarrSize1%>;

	if(varsize>0)
	{
		for(var i=0;i<varsize;i++)
		{
			if(document.forms[0].chkbox[i].checked)
			{
				document.forms[0].hidchk[i].value="1";
			}
			else
			{
				document.forms[0].hidchk[i].value="0";
			}
		}
	}

	
	var strSchem="@";
	var strTotalScem="";
	for(var i=0;i<document.forms[0].sel_bankscheme.options.length;i++)
	{
		if(document.forms[0].sel_bankscheme.options[i].selected)
		{

         if(document.forms[0].sel_bankscheme.options[i].value!="")
         {
             
        	 strTotalScem=strTotalScem+document.forms[0].sel_bankscheme.options[i].value+strSchem

         }

		}
	}
	document.forms[0].cmdsave.disabled=true;
	 document.forms[0].hidSchemTotal.value=strTotalScem;		
	 document.forms[0].hidBeanId.value="securitymaster";
	 document.forms[0].hidBeanGetMethod.value="updateScoringParameters";
    // document.forms[0].hidBeanMethod.value="updateScoringParameters";
   //  document.forms[0].hidBeanGetMethod.value="getScoringParameters";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/setriskparameters.jsp";
	document.forms[0].method="post";
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
		document.forms[0].hidBeanMethod.value="updateScoringParameters";
	    document.forms[0].hidBeanGetMethod.value="getScoringParameters";
		document.forms[0].hidSourceUrl.value="/action/setriskparameters.jsp";
		document.forms[0].submit();
	}
	
}

function showdesc()
{
	if(document.forms[0].sel_scorerule.value == "")
	{
		document.all.desc1.style.visibility="hidden";
		document.all.desc2.style.visibility="hidden";
		document.all.desc3.style.visibility="hidden";
		document.all.desc4.style.visibility="hidden";
	}
	else if (document.forms[0].sel_scorerule.value == "N")
	{
		document.all.desc1.style.visibility="visible";
		document.all.desc2.style.visibility="visible";
		document.all.desc3.style.visibility="visible";
		document.all.desc4.style.visibility="visible";
		disablefields(false);
		document.forms[0].hideditflag.value="Y";
	    document.forms[0].hidAction.value="insert";	
	    callDisableControls(true,false,false,false,false);	
		document.forms[0].chkbox.checked=false;	
		document.forms[0].txtruledesc.value="";
		document.forms[0].txt_ratingfor[0].checked=false;
		document.forms[0].txt_ratingfor[1].checked=false;
		document.forms[0].txt_rskparamcode.value="";
		document.forms[0].sel_bankscheme.value="";
		document.forms[0].sel_bankscheme.disabled=false;

		var varsize = <%=intarrSize1%>;

		if(varsize>0)
		{
			for(var i=0;i<varsize;i++)
			{
				document.forms[0].chkbox[i].checked=false;
			}
		}
    
	}
	else
	{
		document.all.desc1.style.visibility="visible";
		document.all.desc2.style.visibility="visible";
		document.all.desc3.style.visibility="visible";
		document.all.desc4.style.visibility="visible";
		document.forms[0].hidBeanGetMethod.value="getScoringParameters";
		document.forms[0].hidBeanId.value="securitymaster";
		document.forms[0].action=appURL+"action/setriskparameters.jsp";	
		document.forms[0].submit();
		
	}
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad ="loadPage()" >
<form method="post" class="normal">
	    <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr>
            <td class="page_flow">Home -&gt; Setup -&gt; Other Setup &amp;  Risk Parameters</td>
          </tr>
        </table>
  <br>
  <br>
  
  <table width="98%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
	<tr>
		<td align="center">
		<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable">			
					<tr>
						<td colspan="2">
						<table width="100%" border="0" cellspacing="2" cellpadding="2" align="center" class="outertable">												
							<tr>
								<td width="22%">Business Rule</td>
								<td width="18%"><select name="sel_scorerule" onChange="showdesc()">
									<option value="" selected="selected">-- Select --</option>
									<option value="N">-- New --</option>
									<%for(int i=0;i<intarrSize2;i++){
										arrCol2 = (ArrayList) arrRow2.get(i);
										if(arrCol2!=null)
										{%>
									<option value="<%=Helper.correctNull((String)arrCol2.get(0))%>"><%=Helper.correctNull((String)arrCol2.get(1))%></option>
									<%}
										} %>
								</select></td>
								
								<td align="center" id="desc1">Rule Description&nbsp;<span class="mantatory">*</span></td>
								<td width="36%" id="desc2"><input type="text" name="txtruledesc" size="50"
									maxlength="50" value="<%=Helper.correctNull((String)hshValues.get("strRskDesc"))%>"></td>								
							</tr>	
							  <TR id="desc3">
							
							 	
								<td nowrap="nowrap">Rating For&nbsp;<span class="mantatory">*</span></td>
								<td nowrap="nowrap">Retail&nbsp;<input type="radio" name="txt_ratingfor" value="R" style=" border: 0">&nbsp;
								Corporate&nbsp;<input type="radio" name="txt_ratingfor" value="C"  style=" border: 0">
								 </td>								 	
								<td align="center">Code Passed For Rating&nbsp;<span class="mantatory">*</span></td>
								<td nowrap="nowrap"><input type="text" name="txt_rskparamcode" size="30" maxlength="30" value="<%=Helper.correctNull((String)hshValues.get("strrskratCode"))%>"></td>	
								</TR>								 
								 <TR id="desc4">							 	
								<td nowrap="nowrap">Select Bank Scheme&nbsp;<span class="mantatory">*</span></td>
								<td colspan="3"><select name="sel_bankscheme" style="width:465px;" multiple="multiple">
							<option value="">&lt;----Select----&gt;</option>
                            <lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
						</select></td>
								</tr>	
							
							
											
						</table>
						</td>
					</tr>
										
					<tr>
						<td colspan="2">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr>
								<td>

								<table width="100%" border="0" cellspacing="0" cellpadding="3">
									<tr class="dataheader">
										<td align="center">Parameters</td>
									</tr>
								</table>
								<div class="cellContainer">
								<table width="100%" border="0" cellspacing="1" cellpadding="2" align="center">
									
									<%for(int i=0;i<intarrSize1;i++){
										arrCol = (ArrayList) arrRow.get(i);
										if(arrCol!=null)
										{%>
										
										<tr class="datagrid">
											<td width="10%" align="center"><input type="checkbox" name="chkbox" style="border-style:none"
													value="<%=Helper.correctNull((String)arrCol.get(0))%>"></td>
											<td width="90%"><%=Helper.correctNull((String)arrCol.get(2))%></td>			
											<input type="hidden" name="hidchk" value="">								
										</tr>										
											
									<%	}									
									}%>
									<%for (int j = 0; j < 2; j++) { %>
										<tr class="datagrid">
											<td width="10%">&nbsp;</td>
											<td width="90%">&nbsp;</td>											
										</tr>
									<% }
									%>
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

  <lapschoice:combuttonnew btnnames='Edit_Save_Cancel_Delete_Audit Trail'
	btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	  <lapschoice:hiddentag pageid="<%=PageId%>"/> 
	
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidinstype" value="">
<input type="hidden" name="hidSchemTotal">
</form>
</body>
</html>