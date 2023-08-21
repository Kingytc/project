<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
if(objValues instanceof java.util.HashMap)
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
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var selindex;
var isnew="false";
var isadd ="false";
var strtermid = "";
var strtermdesc ="";
var strtermcont="";
var scheme_exi= "<%=Helper.correctNull((String) hshValues.get("scheme"))%>";
var sectortype= "<%=Helper.correctNull((String)hshValues.get("sector"))%>";
var desc= "<%=Helper.correctNull((String)hshValues.get("desc"))%>";
var varBankScheme= "<%=Helper.correctNull((String)hshValues.get("strBankScheme"))%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var schmeActive="<%=Helper.correctNull((String) hshValues.get("SCHEME_Active"))%>";;

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
	
	/*if(sectortype == "" || sectortype =="s")
	{
		document.forms[0].selectterm.disabled=true;
	}
	else
	{
		if(scheme_exi != "")
		{
			document.forms[0].selsector.value =sectortype;
			document.forms[0].txttrmdesc.value =desc;
			document.all.ifrm1.src=path+"action/iframescheme.jsp?hidBeanGetMethod=getSchemeData&hidBeanId=setmodtermscond&sector="+sectortype+"&scheme_exi="+scheme_exi;	
		}		
	}		
		selindex= scheme_exi;
		if(selindex=='')
		{
			document.forms[0].cmdadd.disabled=true;
			document.forms[0].cmdedit.disabled=true;			
		}
		else
		{
			document.forms[0].cmdedit.disabled=true;
			document.forms[0].cmdadd.disabled=false;
		}	 
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;*/

	if(scheme_exi != "")
	{
		document.forms[0].selectterm.value =scheme_exi;
	}
	document.forms[0].sel_active.disabled=true;
	
}

function getValue()
{		
	selindex=document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;	
	
	if(selindex=='')		
	{
		document.forms[0].hidAction.value = "";	
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"action/setschemedocument.jsp";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getSchemeDocData";
		document.forms[0].submit();
	}
	else
	{
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"action/setschemedocument.jsp";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getSchemeDocData";
		document.forms[0].submit();
	}		
}

function selectValues(sno,active)
{
	document.forms[0].hidAction.value = "edit";	
	hiddesc = selindex;
	document.forms[0].selsno.value = sno;	
	document.forms[0].cmdedit.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].sel_active.value = active;	
	var len = document.forms[0].sno.length;
	
	if(len!=null)
	{
		for(i=0;i<len;i++)
		{
			if(document.forms[0].sno[i].checked == true)
			{
				document.forms[0].txttrmcontent.value= document.forms[0].hidtermtext[i].value
				return false;
			}
		}
	}
	else
	{
		document.forms[0].txttrmcontent.value= document.forms[0].hidtermtext.value;
	}
}

function onNew()
{	
	isnew="true";
	document.forms[0].txttrmdesc.readOnly=false;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	//document.all.text1.style.visibility="hidden";
}

function doAdd()
{
	if(document.forms[0].selectterm.value=="")
	{
		alert("Select Bank Scheme");
		document.forms[0].selectterm.focus();
		return;
	}
	isadd="true";
	//document.forms[0].txttrmdesc.readOnly=true;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].txttrmcontent.value="";
	document.forms[0].txttrmcontent.focus();
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].sel_active.disabled=false;
	document.forms[0].sel_active.value="";
}

function doEdit()
{
	strtermid = document.forms[0].selectterm.value;
	//strtermdesc = document.forms[0].txttrmdesc.value;
	strtermcont = document.forms[0].txttrmcontent.value;
	//document.forms[0].txttrmdesc.readOnly=true;
	document.forms[0].txttrmcontent.readOnly=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdadd.disabled=true;
	document.forms[0].cmddelete.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].sel_active.disabled=false;
}

function doSave()
{
	/*if(checktrim(document.forms[0].txttrmdesc.value)=="")
	{		
		ShowAlert('121','Scheme Description');
		document.forms[0].txttrmdesc.focus();
		return false;
	}*/
	if(checktrim(document.forms[0].txttrmcontent.value)=="")
	{		
		ShowAlert('121','Documents');
		document.forms[0].txttrmcontent.focus();
		return false;
	}
	if(document.forms[0].sel_active.value=="")
	{
		ShowAlert('111','Active Status');
		document.forms[0].sel_active.focus();
		return false;
	}
	//if(isnew=="true")
	//{
		//document.forms[0].hidAction.value="insertnew";
	//}
	//else
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
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidId.value =
	document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	document.forms[0].hiddesc.value = document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
	document.forms[0].action=path+"controllerservlet";
	
	document.forms[0].hidBeanId.value="setmodtermscond";
	document.forms[0].hidBeanMethod.value="updateshemedocData";
	document.forms[0].hidBeanGetMethod.value="getSchemeDocData";
	document.forms[0].hidSourceUrl.value="/action/setschemedocument.jsp";
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
		document.forms[0].hidBeanMethod.value="updateshemedocData";
		document.forms[0].hidBeanGetMethod.value="getSchemeDocData";
		document.forms[0].hidSourceUrl.value="/action/setschemedocument.jsp";
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
		document.forms[0].action=path+"action/setschemedocument.jsp";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getSchemeDocData";
		document.forms[0].submit();
	}
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
	/*if(document.forms[0].selectterm.selectedIndex!=0 && document.forms[0].selectterm.selectedIndex!=1)
	{
		var txtheadvalue = document.forms[0].txtheadvalue0.value;
		if(txtheadvalue != null)
		document.forms[0].txttrmdesc.value = txtheadvalue;
	else
		document.forms[0].txttrmdesc.value = "";
	}	*/
}
/*function get_Value()
{
	if( document.forms[0].selsector.value  !="s")
	{
		document.forms[0].selectterm.disabled=false;	
		var selindex=document.forms[0].selsector[document.forms[0].selsector.selectedIndex].value;		
		if(selindex !='') 
		{
			var varsector=document.forms[0].selsector.value;
			document.all.ifrm1.src=path+"action/iframescheme.jsp?hidBeanGetMethod=getSchemeData&hidBeanId=setmodtermscond&sector="+varsector;			
		}		
	}
	else
	{
		document.forms[0].selectterm.value="";
		document.forms[0].selectterm.disabled=true;
		document.forms[0].hidAction.value = "";	
		document.forms[0].hidId.value = 
		document.forms[0].selectterm[document.forms[0].selectterm.selectedIndex].value;
		document.forms[0].hiddesc.value=selindex;
		document.forms[0].action=path+"action/setschemedocument.jsp";
		document.forms[0].hidBeanId.value="setmodtermscond";
		document.forms[0].hidBeanGetMethod.value="getSchemeDocData";		
		document.forms[0].submit();
	}		
} */
</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body  onload="onloading();loadData()">
<iframe height="0" width="0" id="ifrm1" frameborder=0 style="border:0"></iframe>
<form name="f1" method="post" class="normal"> 
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
    <tr> 
      <td class="page_flow">Home -&gt; Setup -&gt; Schemes and Documents</td>
    </tr>
  </table>
  <br>
  <table width="100%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
    <tr> 
      <td valign="top" align="center"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" height="100%" class="outertable border1 tableBg">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table width="50%" border="0" cellspacing="0" cellpadding="2" class="outertable">
<!--                    <tr>-->
<!--						<td>Sector</td>-->
<!--                    	<td colspan="3">-->
<!--                    		<select name="selsector" onChange="get_Value()">-->
<!--							   	<option value="s" selected>--Select--</option>-->
<!--							   	<option value="p">Retail</option>-->
<!--								<option value="a">Agriculture</option>-->
<!--								<option value="t">Tertiary</option>-->
<!--								<option value="c">Corporate & SME</option>-->
<!--							 </select>-->
<!--                    	</td>-->
<!--                    </tr>-->
<!--                      <tr> -->
<!--                        <td width="22%">Select Existing Scheme </td>-->
<!--                        <td width="18%"> -->
<!--                          <select name="selectterm" onChange="getValue()" >-->
<!--                           	<option value="" selected>----Select----</option>-->
<!--                            <option value="0">----New----</option>-->
<!--                          </select>-->
<!--                        </td>-->
<!--                        <td align="center">Scheme Description</td>-->
<!--                        <td width="36%"> -->
<!--                          <input type="text" name="txttrmdesc" size="50" maxlength="50" readOnly onKeyPress="notAllowSingleQuote()" value="">-->
<!--                        </td>-->
<!--                      </tr>-->
						<tr> 
                        <td width="10%">Select Bank's Scheme </td>
                        <td width="18%"> 
                          <select name="selectterm" onChange="getValue()" >
                           	<option value="" selected>----Select----</option>
                           	<lapschoice:BanksSchemeStaticDataNewTag apptype="1" /> 
                          </select>
                        </td>
<!--                        <td align="center">Scheme Description</td>-->
<!--                        <td width="36%"> -->
<!--                          <input type="text" name="txttrmdesc" size="50" maxlength="50" readOnly onKeyPress="notAllowSingleQuote()" value="">-->
<!--                        </td>-->

 						
                      </tr>
                      <tr>
                      <td>Active Status </td>
                        <td> 
                          <select name="sel_active"  >
                           	<option value="">--Select--</option>
                           	<option value="E">Enabled</option>
                           	<option value="D">Disabled</option>
                           
                          </select>
                        </td>
                      </tr>
                    </table>
                  </td>
                </tr>
                <tr> 
                  <td colspan="2" valign="middle"> 
                    <table border="0" cellspacing="0" cellpadding="5"   align="center" class="outertable">
                      <tr> 
                        <td > 
                          <textarea name="txttrmcontent" wrap="VIRTUAL" cols="85" rows="5" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)" readOnly></textarea>
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
                    <table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                      <tr> 
                        <td>                          
                            <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
                              <tr class="dataheader">
                                <td align="center" colspan="2"><b>Documents</b></td>
                              </tr>                            
                              <%if(vecRow!=null){
				if(vecRow.size()>0){
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
                                  <input type="radio" name="sno" style="border-style:none" onClick="selectValues('<%=strSno%>','<%=Helper.correctNull((String)vecCol.get(5))%>')">
                                  <input type="hidden" name="txtheadid<%=i%>" value="<%=Helper.correctNull((String)vecCol.get(1))%>" style="border:0;background-color:#DEDACF;text-align:right">
                                  <input type="hidden" name="txtheadvalue<%=i%>" value="<%=Helper.correctNull((String)vecCol.get(2))%>" style="border:0;background-color:#DEDACF;text-align:right">
                                <td align="left" width="95%">
                                  <input type="hidden" name="hidtermtext" value="<%=Helper.correctNull((String)vecCol.get(3))%>">
                                  <%=Helper.correctNull((String)vecCol.get(3))%>
                                </td>
                              </tr>
                              <%}}%>
                            </table>
  <br>
 <lapschoice:combuttonnew btnnames='Add_Edit_Save_Cancel_Delete' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
 <lapschoice:hiddentag pageid='<%=PageId%>'/>
  <input type="hidden" name="hiddesc">
  <input type="hidden" name="hidId" value="<%=request.getParameter("hidId") %>">
  <input type="hidden" name="hidRuleNo" value="">
  <input type="hidden" name="hidmaxterm" value="<%=request.getParameter("hidmaxterm") %>">
  <input type="hidden" name="selsno" value="">
  <input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>

