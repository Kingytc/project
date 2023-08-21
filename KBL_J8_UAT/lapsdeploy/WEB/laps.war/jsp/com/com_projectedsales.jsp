<%@include file="../share/CKEditor.jsp"%>
<%@include file="../share/directives.jsp"%>
<html>
<head>
<title>Proposal</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">

<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/editor.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script  src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<SCRIPT src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>	
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>ckeditor/ckeditor.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function htmlView()
{
  var hlpvar = appURL+"action/com/htmlView.jsp?hidBeanId=comproposal&hidBeanGetMethod=getDataComment&type=1&appno="+"<%=Helper.correctNull((String)hshValues.get("appno"))%>";
  var title = "HTMLVIEW";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function enableButtons(bool1,bool2,bool3,bool4)
{
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmdclose.disabled=bool4;
}

function call_page(url,method,type)
{
	document.forms[0].hidBeanGetMethod.value=method;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action="<%=ApplicationParams.getAppUrl()%>action/"+url+"?type="+type;
	document.forms[0].submit();
}

function placevalues()
{
	EditorEnableDisable("id_div","block","id_editor","none");
	if(document.forms[0].btnenable.value=="N")	 
	{	 	
	 	enableButtons(true,true,true,false);
	}
	else
	{
		enableButtons(false,true,true,false);
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
				 document.forms[0].elements[i].readOnly=true;
			}
		}
	 }
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].action=appURL+"action/controllerservlet?type=2";
	document.forms[0].submit();
	}
}
function doClose()
{
	var cattype=document.forms[0].cattype.value;
	if((cattype=="ASSI")||(cattype=="ASBI"))
    {
    	if(ConfirmMsg(100))
	 	{
			document.forms[0].action=appUrl+"action/agrborrowersearch.jsp";
		 	document.forms[0].submit();
	 	}
	}
	if((cattype=="SSI")||(cattype=="CORP")||(cattype=="SME"))
    {
    	if(ConfirmMsg(100))
	 	{
	 		document.forms[0].action=appUrl+"action/comborrowersearch.jsp";
		 	document.forms[0].submit();
		}
	}
}

function doEdit()
{		
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="textarea")
			{
			  document.forms[0].elements[i].readOnly=false;
			  
			}			
		}
	enableButtons(true,false,false,true);
	document.forms[0].hidAction.value ="insert";
	EditorEnableDisable("id_div","none","id_editor","block");
	editor_generate('txt_projectedsales');
}
function doSave()
{
	document.forms[0].cmdsave.disabled = true;
	document.forms[0].hidBeanId.value="comproposal";
	document.forms[0].hidBeanMethod.value="updateGeneralComment";
	document.forms[0].hidBeanGetMethod.value="getDataComment";
	document.forms[0].hidSourceUrl.value="/action/com_projectedsales.jsp"
	document.forms[0].action=appURL+"controllerservlet?type=2";
	document.forms[0].submit();
}
function gototab(beanid,methodname,pagename,flowtype)
{
	if(flowtype=="COP")
	{
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename+"?hidPageSource="+flowtype;
		document.forms[0].submit();
	}
	else
	{	
		document.forms[0].hidBeanId.value=beanid;
		document.forms[0].hidBeanGetMethod.value=methodname;
		document.forms[0].action=appURL+"action/"+pagename;
		document.forms[0].flowtype.value=flowtype;
		document.forms[0].submit();
	}	
} 
function dohlp()     
{
  var hlpvar = appURL+"phlp/corp_propocoment.htm";
  var title = "Comment1";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}
</script>
</head>
<body onload="placevalues()">
<div id="ie5menu" class="skin0" onMouseover="highlightie5()"
	onMouseout="lowlightie5()" onClick="jumptoie5()">
<div class="menuitems" url="">
<script language="JavaScript">

if (document.all && window.print)
{
	ie5menu.className = menuskin;
	document.oncontextmenu = showmenuie5;
	document.body.onclick = hidemenuie5;
}
</script>
</div></div>
<form name="frmprojectedsales" method = post class="normal">
  <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
			<td valign="top" colSpan=5>
              <jsp:include page="../com/proposallinks.jsp" flush="true"> 
              <jsp:param name="pageid" value="41" />
			   <jsp:param name="cattype" value="<%=strCategoryType%>" />
			  <jsp:param name="ssitype" value="<%=strSSIType%>" />			
              </jsp:include>
            </td>
          </tr>
          <tr>
          	<td class="page_flow">
          		Home -&gt; Corporate &amp; SME -&gt; Proposal -&gt; Financial Analysis -&gt; Assessment -&gt; Projected Level of Sales
      			<span style="display:none"><lapschoice:borrowertype /></span> 
      			<lapschoice:application/>
          	</td>
          </tr>
        </table>	
		 <jsp:include page="../com/com_commentstab.jsp" flush="true">
						<jsp:param name="tabid" value="2" />
					</jsp:include>	
  <table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable" align="center">
    <tr> 
      <td valign="top"> 
        <table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
          <tr> 
            <td valign="top"> 
              <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
                <tr> 
                  <td valign="top"> 
                    <table width="90%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                       <tr>
					  <td>
					  <div id="id_div">
					  <div class="EditorClassNew"><%=Helper.correctNull((String)hshValues.get("com_projectedsales_comments")) %></div></div>
					  <div id="id_editor">
					  <textarea name="txt_projectedsales" width="550" cols="110" wrap="VIRTUAL" rows="25" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String)hshValues.get("com_projectedsales_comments"))%></textarea>
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
      </td>
    </tr>
  </table>
  <br>
	<table width="12%" border="0" cellspacing="0" cellpadding="0" class="outertable" align="center">
    <tr> 
      <td> 
        <table width="100%" border="0" cellspacing="0" cellpadding="2" class="outertable">
          <tr valign="top"> 
            <td align="center"> 
			<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 
            </td>
          </tr>
        </table>
      </td>
    </tr>
  </table>
  <lapschoice:hiddentag pageid='<%=PageId%>'/>
   <input type="hidden" name="flowtype"/>
   <input type="hidden" name="cattype" value="<%=strCategoryType%>"> 
   <input type="hidden" name="yearfrom" value="1">
   <input type="hidden" name="pagefrom">
   <INPUT TYPE="hidden" name="strAssessment" value = "<%=request.getParameter("strAssessment")%>">
</form>
</body>
<!--<script language="javascript1.2">editor_generate('txt_projectedsales');</script> -->
</html>