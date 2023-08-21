 <%@include file="../share/directives.jsp"%>
<%ArrayList vec = new ArrayList();
int vecsize=0;
if (hshValues != null)
{
	vec = (ArrayList)hshValues.get("vecRow"); 
}%>
<html>
<head>
<title>General Information</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>htm/link.css" type="text/css">
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<SCRIPT LANGUAGE="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"> </script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<SCRIPT LANGUAGE="JavaScript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var sel_SchId = "<%=Helper.correctNull((String)hshValues.get("strschcode"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
function callonLoad()
{	
	document.forms[0].sel_govtScheme.disabled=false;
	document.forms[0].txt_question.disabled=true;
	if(sel_SchId!="")
	{
		document.forms[0].sel_govtScheme.value=sel_SchId;
	}
	enableButtons(false, true, true, true, false);	
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
	if(document.forms[0].sel_govtScheme.value == "0")
	{
		ShowAlert('121','Product Name');
		return;
	}
	if(document.forms[0].txt_question.value == "")
	{
		ShowAlert('121','Question');
		return;
	}
	
	var govtScheme = document.forms[0].sel_govtScheme.length;	
	for(i=0;i<govtScheme;i++)
	{
		 if(document.forms[0].sel_govtScheme.options[i].selected==true)
		 {
			 document.forms[0].hid_sel_govtScheme.value = document.forms[0].sel_govtScheme.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled = true;
	var varproducthelp=document.forms[0].sel_govtScheme.selectedIndex;
	var varValue=document.forms[0].sel_govtScheme.value;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanMethod.value="updategovtsponsData";
	document.forms[0].hidBeanGetMethod.value="getgovtsponsData";
	document.forms[0].hidSourceUrl.value="/action/govtsponsorinfo.jsp";
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
		document.forms[0].hidBeanId.value="govtsponschklist";
		document.forms[0].hidBeanGetMethod.value="getgovtsponsData";
		document.forms[0].hidSourceUrl.value="/action/govtsponsorinfo.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	if(document.forms[0].sel_govtScheme.value=="0")
	{
		alert("Select the Product");
		document.forms[0].sel_govtScheme.focus();
		return;
	}
	document.forms[0].hidAction.value="New";
   	enableButtons(true, true, false, false, true);
   	document.forms[0].sel_govtScheme.disabled=false;
	document.forms[0].txt_question.disabled=false;
		
}

function doEdit() 
{
   	document.forms[0].hidAction.value="Edit"
	enableButtons(true, true, false, false, true);
	document.forms[0].sel_govtScheme.disabled=false;
	document.forms[0].txt_question.disabled=false;
}
   
function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
}

function textlimit(field,maxlen)
{
	if(field.value.length>maxlen)
    {
		field.value=field.value.substring(0,maxlen);
    }
}

function selectValues(val1, val2, val3)
{
	document.forms[0].hidsno.value=val1;
	document.forms[0].sel_govtScheme.value=val2;
	document.forms[0].txt_question.value=val3;
	enableButtons(true,false,true,false,false);
}

function getQuestion()
{	
	document.forms[0].hidBeanId.value="govtsponschklist";
	document.forms[0].hidBeanGetMethod.value="getgovtsponsData";
	//document.forms[0].hidSourceUrl.value="/action/govtsponsorinfo.jsp";
	document.forms[0].action=appURL+"action/govtsponsorinfo.jsp";		
	document.forms[0].submit();
}

</SCRIPT>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	

<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">


<form name="appform" method="post" action="" class="normal">
<table class="outertable" width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt; Government Sponsor Questionnaire</td>
	</tr>
</table><br>
                    <table class="outertable border1 tableBg" width="100%" border="0" cellspacing="0" cellpadding="1">
                      <tr> 
                        <td width="69%" valign="top"> 
                          <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                            <tr> 
                              <td> 
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="1">
                                 
                                  <tr> 
                                    <td width="20%">Sponsor Scheme<b><span class="mantatory">*</span></b></td>
                                    <td colspan="2">
									<select name="sel_govtScheme" tabindex="11" onchange="getQuestion()">
									<option value="0"><b>--Select--</b></option>
									<%String apptype = "11";%>
									<lapschoice:StaticDataTag apptype='<%=apptype%>' />
								</select>                                      
                                  </tr>
                                  <tr> 
                                    <td width="20%"><font size="1" face="MS Sans Serif">Question</td>
                                    <td colspan="2"> 
                                      <input type="text" name="txt_question" size="150" maxlength="1000" value="<%=Helper.correctNull((String)hshValues.get(""))%>">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td width="20%">&nbsp;</td>
                                    <td colspan="2">&nbsp;</td>
                                  </tr>
                                  </table></td>
                                  </tr>
                                  </table>
                                  </td>
                                  </tr>
                                  </table>
                                  <br>
                                  <lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>                                 
<br>                                      
                                <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2"
									 class="" align="center">
									<tr>
										<td valign="top">
										<table class="outertable linebor" width="100%" cellspacing="0" cellpadding="3">
										<tr align="center" class="dataheader">

                                          <td width="5%" >&nbsp;</td>
                                          <td width="95%" ><b>Questions</b></td>
									    </tr>                                      
                                          <%                                          
                                          if(vec!=null)
                                          {
                                        	vecsize=vec.size();
											ArrayList g1=new ArrayList();
                                           
											 for (int l=0;l<vecsize;l++)
											 {	
												if(l<vecsize)
												{
													g1 = (ArrayList)vec.get(l);
												}
											%>
                                          <tr class="datagrid"> 
                                            <td width="5%"> 
                                              <input type="radio" name="radiobutton" value="radiobutton" style="border-style:none"  onClick="
                                              selectValues('<%=Helper.correctNull((String)g1.get(0))%>',
                                              '<%=Helper.correctNull((String)g1.get(1))%>',
                                              '<%=Helper.correctNull((String)g1.get(2))%>'
                                            )">
                                            </td>
                                            <td width="95%"><%=Helper.correctNull((String)g1.get(2))%></td>
                                          </tr>
                                          <%
					                       }
                                          }
									%>
                                        </table>
                                        </td>
                                        </tr>
                                        </table>
 <lapschoice:hiddentag pageid='<%=PageId%>'/>  
  <input type="hidden" name="hidsno" value="" >
  <input type="hidden" name="hidstate" value="2">
  <input type="hidden" name="hidstatenew" value="">
  <input type="hidden" name="hid_sel_govtScheme"> 
  <input type ="hidden" name ="hidkeyid" value="set">
<br> 
</form>
</body>
</html>

