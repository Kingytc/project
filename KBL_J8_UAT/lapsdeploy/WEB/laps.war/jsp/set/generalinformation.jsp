<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) 
{
	hshValues = (java.util.HashMap) objValues;
}
ArrayList vec = new ArrayList();
int vecsize=0;
if (hshValues != null)
{
	vec = (ArrayList)hshValues.get("vecRow"); 
	
}
vecsize=vec.size();	
String prdtype=Helper.correctNull((String)hshValues.get("prdtype"));%>
<html>
<head>
<title>General Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var strPrdcode1 ="<%=Helper.correctNull((String)hshValues.get("strPrdcode1"))%>";
var sel_productID = "<%=Helper.correctNull((String)hshValues.get("sel_productID"))%>";
var mode="";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callonLoad()
{	
	if(document.forms[0].prd_type.value == "p")
	{		
		document.forms[0].prd_choose.checked  = true;
		//document.forms[0].prd_choose[1].checked = false;
	}
   else if(document.forms[0].prd_type.value == "a")
	{
		document.forms[0].prd_choose.checked  = false;
		//document.forms[0].prd_choose[1].checked  = true;
	}	
	disablefields(true);		
	document.forms[0].sel_productID.disabled=false;
	if(sel_productID!="")
	{
		document.forms[0].sel_productID.value=sel_productID;
		enableButtons(false, true, true, true,true, false);	
	}
	else
	{
		document.forms[0].sel_productID.value="0";
		enableButtons(false, true, true, true,true,false);	
	}	 
}
function disablefields(val)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
	 	{
			document.forms[0].elements[i].readOnly=val;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=val;
		}
		if(document.forms[0].elements[i].type=='radio')
		{
			document.forms[0].elements[i].disabled=(!val);
		}	 
		if(document.forms[0].elements[i].type=='textarea')
		{
			document.forms[0].elements[i].disabled=val;
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
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function doSave()
{	
	if(document.forms[0].sel_productID.value == "0")
	{
		ShowAlert('121','Product Name');
		return;
	}
	if(trimtxt(document.forms[0].txt_question.value) == "")
	{
		ShowAlert('121','Question');
		document.forms[0].txt_question.focus();
		return;
	}
	if(trimtxt(document.forms[0].txt_comments.value) == "")
	{
		ShowAlert('121','Description');
		document.forms[0].txt_comments.focus();
		return;
	}
	if(document.forms[0].sel_active.value=="")
	{
		ShowAlert('111','Active');
		document.forms[0].sel_active.focus();
		return;
	}
	var varproducthelp=document.forms[0].sel_productID.selectedIndex;
	var varValue=document.forms[0].sel_productID.value;
	var varArr= varValue.split("$");	
	var productID = varArr[0];	
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hid_ProductID.value=productID;
	document.forms[0].prd_choose.disabled=false;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updategeneralinfoData";
	document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
	document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";
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
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
		document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";		
		document.forms[0].submit();
	}
}

function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{	
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanMethod.value="updategeneralinfoData";
			document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
			document.forms[0].action=appURL +"controllerservlet";
			document.forms[0].submit(); 
		}
		ClearFields();
	}
	else
	{
		ShowAlert(158);
	}
}
function doNew() 
	{
	ClearFields();
	document.forms[0].prd_type.value="<%=prdtype%>";
	if(document.forms[0].sel_productID.value=="0")
		{
		alert("Select the Product");
		document.forms[0].sel_productID.focus();
		return;
		}
	document.forms[0].hidAction.value="New";
   	enableButtons(true, true, false, false,true,true);
   	disablefields(false);  	
	}

function doEdit() 
	{
   	document.forms[0].hidAction.value="Edit"
	enableButtons(true, true, false, false, false, true);
	disablefields(false);  	
	}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5,bool6)
	{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=true;	
	document.forms[0].cmdclose.disabled=bool6;
	}

function selectValues(val1, val2, val3, val4, val5)
	{
	document.forms[0].hid_ProductID.value=val1;
	document.forms[0].hidsno.value=val2;
	document.forms[0].txt_question.value=val3;
	document.forms[0].txt_comments.value=val4;
	document.forms[0].sel_active.value=val5;
	enableButtons(true, false, true, false, false);	
	}

function getQuestion()
	{	
	
	var varproducthelp=document.forms[0].sel_productID.selectedIndex;
	var varValue=document.forms[0].sel_productID.value;
	var varArr= varValue.split("$");	
	var productID = varArr[0];	
	document.forms[0].hid_ProductID.value=productID;
	document.forms[0].hidAction.value="Select";
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
	document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";		
	document.forms[0].submit();
	}
function selproduct()
    {
	  if(mode=="yes")
	  {
	   if(document.forms[0].prd_choose.checked == true)
		{
			
			document.forms[0].sel_productID.value="0";
			document.forms[0].prd_type.value=document.forms[0].prd_choose.value;	
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
			document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";		
			document.forms[0].submit();
		}
	   /* else if(document.forms[0].prd_choose[1].checked == true) 
	    {
	  	    document.forms[0].sel_productID.value="0";
			document.forms[0].prd_type.value=document.forms[0].prd_choose[1].value;   
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidBeanGetMethod.value="getgeneralinfoData";
			document.forms[0].hidSourceUrl.value="/action/generalinformation.jsp";		
			document.forms[0].submit();
	    }*/
	  }
	  
	   
    }	
function checkselect()
{
	mode="yes";
	selproduct();
}
	

</SCRIPT>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad();selproduct()">
<form name="appform" method="post" action="" class="normal">
<table class="outertable" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Appraisal Questionnaire</td>
	</tr>
</table>
<br>
                    <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1" align="center">
						  <tr> 
                        <td> 
                          <table class="outertable" width="40%" border="0" cellspacing="0" cellpadding="3" align="left">
                            <tr> 
                              <td width="6%" align="center">   
                                <input type="radio" name="prd_choose" value="p" style="border-style:none" onclick = "checkselect()" >
                                 </td>
                              <td width="34%"><b>Retail Products</b> </td>
<!--                             <td width="6%"> 
                                <input type="radio" name="prd_choose" value="a" style="border-style:none" onclick = "checkselect()" >
                                </td>
                              <td width="20%"><b>Agriculture Products</b></td>  -->                          
                            </tr>
                          </table>
                        </td>
                      </tr> 
                      <tr> 
                        <td><table class="outertable border1 tableBg" width="100%" border="0" cellspacing="0" cellpadding="5" align="center">
						    <tr> 
                              <td> 
                                <table class="outertable" width="98%" border="0" cellspacing="0" align="center" cellpadding="1">
                                  <tr> 
                                  <tr> 
                                    <td width="20%">Product<b>&nbsp;<span class="mantatory">*</span></b></td>
                                    <td colspan="2">
                                    <select name="sel_productID" onchange="getQuestion();selproduct()">
                                    <option value="0">--Select--</option>
                                    	<lapschoice:prdlisthelp1 apptype='<%=prdtype%>'/>
                                    </select>
                                  </tr>
                                  <tr>
                                    <td width="20%">Question</td>
                                    <td colspan="2">
                                      <input type="text" name="txt_question" size="80" maxlength="5000" onkeyup="checkTextArealimit(this,400);"/>
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%"> 
                                      Description
                                    </td>
                                    <td colspan="2">
                                   <textarea name="txt_comments" cols="40" rows="3" wrap="VIRTUAL" onkeyPress="notAllowSingleQuote();textlimit(this,299)" onkeyup="checkTextArealimit(this,299);"/ ><%//=Helper.correctNull((String)hshValues.get("gene_info_desc"))%></textarea></td>
                                  </tr>    
                                  <tr>
                                   <td>Active</td>
				                   <td><select name="sel_active" style="width: 120px">
				                   <option value="">--Select--</option>
				                   <option value="E">Enable</option>
				                   <option value="D">Disable</option>
				                 </select>
				                  </td> 
                                  </tr>
                                                                
                                </table></td>
                                </tr>
                                </table>                          
                             <br>
                            <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
                           <br> <tr> 
                              <td valign="top"> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr>
										<td valign="top">
										<table class="outertable linebor" width="100%" cellspacing="0" cellpadding="3">
										<tr align="center" class="dataheader">
                                          <td width="5%" >&nbsp;</td>
                                          <td width="95%" ><b>Questions</b></td>
									    </tr>
                                          <%
                                          vecsize=vec.size();
                                          if(vecsize!=0)
                                          {
											ArrayList g1=new ArrayList();
                                           
											 for (int l=0;l<vecsize;l++)
											 {	
												if(l<vecsize)
												{
													g1 = (ArrayList)vec.get(l);
												}%>
                                          <tr class="datagrid"> 
                                            <td width="5%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="selectValues('<%=Helper.correctNull((String)g1.get(0))%>','<%=Helper.correctNull((String)g1.get(1))%>','<%=Helper.correctNull((String)g1.get(2))%>','<%=Helper.replaceForJavaScriptString(Helper.correctNull((String)g1.get(3)))%>','<%=Helper.correctNull((String)g1.get(4))%>','<%=Helper.correctNull((String)g1.get(5))%>')">
                                            </td>
                                            <td width="95%"><%=Helper.correctNull((String)g1.get(2))%></td>
                                          </tr>
                                          <%}}%>
                                          <!--  <tr> 
                                            <td width="5%">&nbsp; </td>
                                            <td width="95%">&nbsp; </td>
                                          </tr>-->
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
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
  <input type="hidden" name="hidsno" value="<%=Helper.correctNull((String)hshValues.get("gene_slno"))%>" >
  <input type="hidden" name="hidstate" value="2">
  <input type="hidden" name="hidstatenew" value="">
  <input type="hidden" name="hid_ProductID" value="<%=Helper.correctNull((String)hshValues.get("strPrdcode"))%>">
  <input type="hidden" name="prd_type" value="<%=prdtype%>">
  <input type ="hidden" name ="hidkeyid" value="set">
<br> 
</form>
</body>
</html>
