<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if(objValues instanceof java.util.HashMap)
{
	hshValues=(java.util.HashMap)objValues;
}
ArrayList vecRow = null ;
ArrayList vecCol = null ;
int vecsize=0;
if(hshValues!=null)
{	vecRow = (ArrayList)hshValues.get("vecRow");
}%>
<html>
<head>
<title>Terms and Conditions</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var isadd ="false";
var strtermid = "";
var strtermdesc ="";
var strtermcont="";

function check()
{
	var key=window.event.keyCode;
	if(key == 13)
	{
		window.event.returnValue = false;
	}
}

function onloading()
{   
	for(i=0;i<document.forms[0].selectterm.length;i++)
	{	if(document.forms[0].hidId.value == document.forms[0].selectterm[i].value)
		{
			document.forms[0].selectterm.selectedIndex=i;
		}
	}	
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	if(selindex=='')
	{
		document.forms[0].cmdadd.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].sel_Action.disabled=true;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdadd.disabled=false;
		document.forms[0].sel_Action.disabled=true;
	}	 
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].cmdcancel.disabled=true;
	document.forms[0].cmddelete.disabled=true;
}

function getValue()
{		
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;	
	if(selindex=='')		
	{
		document.forms[0].hidAction.value = "";	
		document.forms[0].hidId.value = 
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setmodtermscond.jsp";
		document.forms[0].submit();
	}
	else if(selindex==0)
	{
		document.forms[0].txttrmdesc.value="";
		document.forms[0].txttrmcontent.value="";
		onNew();
	}
	else
	{
		document.forms[0].hidId.value = 
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value ;
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setmodtermscond.jsp";
		document.forms[0].submit();
	}
}

function selectValues(sno)
{
	document.forms[0].hidAction.value = "edit";	
	hiddesc = selindex;
	document.forms[0].selsno.value = sno;	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	var len = document.forms[0].sno.length;
	
	if(len!=null)
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				document.forms[0].txttrmcontent.value= document.forms[0].hidtermtext[i].value
				document.forms[0].sel_Action.value=document.forms[0].hidtermAction[i].value
				return false;
			}
		}
	}
	else
	{
		document.forms[0].txttrmcontent.value= document.forms[0].hidtermtext.value;
		document.forms[0].sel_Action.value=document.forms[0].hidtermAction.value
	}
}

function onNew()
{	
	isnew="true";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].sel_Action.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.all.text1.style.visibility="hidden";
}

function doAdd()
{
	isadd="true";
	document.forms[0].txttrmdesc.readOnly=true;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].sel_Action.disabled=false;
	document.forms[0].txttrmcontent.value="";
	document.forms[0].txttrmcontent.focus();
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=true;
}

function doEdit()
{
	strtermid = document.forms[0].selectterm.value;
	strtermdesc = document.forms[0].txttrmdesc.value;
	strtermcont = document.forms[0].txttrmcontent.value;
	document.forms[0].txttrmdesc.readOnly=true;
	document.forms[0].sel_Action.disabled=false;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmddelete.disabled=false;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
}

function doSave()
{
	if(checktrim(document.forms[0].txttrmdesc.value)=="")
	{		
		ShowAlert('121','Terms Description ');
		document.forms[0].txttrmdesc.focus();
		return false;
	}
	if(checktrim(document.forms[0].txttrmcontent.value)=="")
	{		
		ShowAlert('121','Terms and Conditions');
		document.forms[0].txttrmcontent.focus();
		return false;
	}
	if(isnew=="true")
	{
		document.forms[0].hidAction.value="insertnew";
	}
	else
	{
		if(isadd =="true")
		{
			document.forms[0].hidAction.value="insertadd";
		}
		else
		{
			document.forms[0].hidAction.value="update";
		}
	}
	if(document.forms[0].sel_Action.value=="")
	{
		alert("Select Action");
		return;
	}
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidId.value =
	document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	document.forms[0].action=path+"controllerservlet";
	
	document.forms[0].hidBeanId.value="setmodtermscond";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidSourceUrl.value="/action/setmodtermscond.jsp";
	document.forms[0].submit();
}

function doDelete()
{
	if(ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidId.value =
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].action=path+"controllerservlet";			
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanMethod.value="updateData";
		document.forms[0].hidSourceUrl.value="/action/setmodtermscond.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidAction.value = "";	
		document.forms[0].hidId.value = 
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"controllerservlet";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setmodtermscond.jsp";
		document.forms[0].submit();
	}
}

function dohlp()     
{
  	var hlpvar = path+"phlp/setup_retailprod_termsandconditions.htm";
  	var title = "TermsandConditions";
  	var prop = "scrollbars=yes,width=600,height=450";	
  	prop = prop + ",left=50,top=150";
  	window.open(hlpvar,title,prop);
}

function doClose()
{
	if(ConfirmMsg('100'))
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function menuOptionDivMouseDown (url) 
{		
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
		return;
	}
	document.currentMenu.style.display='none';
	document.currentMBarOpt.style.border='1px solid lightgrey';
	document.menuIsActive = false;
	document.forms[0].action=url;
	document.forms[0].submit();
}

function loadData()
{
	if(document.forms[0].selectterm.selectedIndex!=0 && document.forms[0].selectterm.selectedIndex!=1)
	{
		var txtheadvalue = document.forms[0].txtheadvalue0.value;
		if(txtheadvalue != null)
		document.forms[0].txttrmdesc.value = txtheadvalue;
	else
		document.forms[0].txttrmdesc.value = "";
	}	
}
 
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="onloading();loadData()">
<form name="f1" method="post" class="normal"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Retail &amp; Agriculture Products -&gt;Terms and Conditions</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5"  align="center" class="outertable">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable" align="center" >
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
                      <tr> 
                        <td width="22%">Select 
                          Existing Terms </td>
                        <td width="18%"> 
                          <select name="selectterm" onChange="getValue()" >
                            <lapschoice:settermcond/> 
                          </select>
                        </td>
                        <td align="center">Terms 
                          Description</td>
                        <td width="36%"> 
                          <input type="text" name="txttrmdesc" size="50" maxlength="50" readOnly onKeyPress="notAllowSingleQuote()" value="">
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table border="0" cellspacing="0" cellpadding="5" class="outertable" align="center">
                      <tr> 
                        <td > 
                          <textarea name="txttrmcontent" wrap="VIRTUAL" cols="85" rows="5"  onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" readOnly></textarea>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                 <tr>
                     <td  width="" align="center">Action<span class="mantatory">*</span></td>
                     <td  width="" ><select name="sel_Action">
                     <option value="">--Select--</option>
                     <option value="E">Enabled</option>
                     <option value="D">Disabled</option></select></td>
                     </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>
                          
                            <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                              <tr>
                                <td class="dataheader" align="center">TERMS AND CONDITIONS</td>
                              </tr>
                            </table>
                            <table width="100%" id="text1" border="0" cellspacing="1" cellpadding="2" align="center" class="outertable">
                              <%if(vecRow!=null)
			{
				if(vecRow.size()>0)
				{
				vecsize = vecRow.size();
				}
			}
			String strSno="";
			for(int i=0;i<vecsize;i++)
			{				
				vecCol = (ArrayList)vecRow.get(i);
				if(vecCol!=null)
				{
					strSno = Helper.correctNull((String)vecCol.get(1));%>
                              <tr class="datagrid"> 
                                <td width="3%"> 
                                  <input type="radio" name="sno" style="border-style:none" onClick="selectValues(<%=strSno%>)">
                                  <input type="hidden" name="txtheadid<%=i%>" value="<%=Helper.correctNull((String)vecCol.get(1))%>" style="border:0;background-color:#DEDACF;text-align:right">
                                  <input type="hidden" name="txtheadvalue<%=i%>" value="<%=Helper.correctNull((String)vecCol.get(2))%>" style="border:0;background-color:#DEDACF;text-align:right">
                                <td align="left" width="85%">
                                  <input type="hidden" name="hidtermtext" value="<%=Helper.correctNull((String)vecCol.get(3))%>">
                                  <%=Helper.correctNull((String)vecCol.get(3))%>
                                </td>
                               <td width="10%">
							
							<%String strEnable=Helper.correctNull((String) vecCol.get(4));
							if(strEnable.equalsIgnoreCase("E"))
							{
								strEnable="Enable";
							}
							else if(strEnable.equalsIgnoreCase("D"))
							{
								strEnable="Disable";
							}
							else
							{
								strEnable="";
							}%>
							<%=strEnable %>&nbsp;<input type="hidden" name="hidtermAction" value="<%=Helper.correctNull((String)vecCol.get(4))%>">
                               </td>
                              </tr>
                              <%}}%>
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
<lapschoice:combuttonnew btnnames="Add_Edit_Save_Cancel_Delete" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
  <input type="hidden" name="hiddesc">
  <input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
  <input type="hidden" name="hidRuleNo" value="">
  <input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>">
  <input type="hidden" name="selsno" value="">
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
</form>
</body>
</html>
