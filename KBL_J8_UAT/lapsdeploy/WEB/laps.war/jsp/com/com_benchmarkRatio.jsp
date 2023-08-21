<%@include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strType = Helper.correctNull(request.getParameter("hidval"));
%>
<html>
<head>
<title>Benchmark Ratio</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL ="<%=ApplicationParams.getAppUrl()%>";
var path ="<%=ApplicationParams.getAppUrl()%>";
var button="";
var vartype = "";
var vardesc = "";
var varformula1="";
var varformula2="";
var varformulano1="";
var varformulano2="";
var varsno="";
var varstressrdo="";
var varstresspercent="";

function changemode(val)
{
	document.forms[0].sel_depends.disabled=val;
	document.forms[0].rowdesc.readOnly=val;
	document.forms[0].formula.readOnly=val;
	document.forms[0].cmaformat.readOnly=val;
	document.forms[0].cmaformat.readOnly=val;

}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddelete.disabled=bool6;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		button ="cancel";
		enableButtons(false,false,true,true,false,false);
			for(var i=0;i<document.forms[0].elements.length;i++)
			{
				if(document.forms[0].elements[i].type=="text")
				{
				 document.forms[0].elements[i].readOnly=true;
				}	
			}
			
			document.forms[0].rowdesc.value="";
			document.forms[0].txt_lending.value="";
			document.forms[0].sel_depends.value="S";
			document.forms[0].formula.value="";
			document.forms[0].formulano2.value="";

			changemode(true);
			if (vartype == "")
			{
				vartype="S";
			}
	}
}

function whileLoading()
{
	strtype="<%=strType%>";
	var buttonstatus="<%= Helper.correctNull((String)hshValues.get("hidval"))%>"
	
	/*if (buttonstatus == "" )
	{
		enableButtons(true,true,false,false,true,true);
		button = "insert";

	}
	else*/
	{
		enableButtons(false,false,true,true,false,false);
		//button="edit";
		
	}
	
	/*if(strtype != "update")
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
		if(document.forms[0].elements[i].type=="text")
			{
			 document.forms[0].elements[i].readOnly=false;
			}	
		}
	}
	else
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
		if(document.forms[0].elements[i].type=="text")
			{
			 document.forms[0].elements[i].readOnly=true;
			}	
		}
	}*/
	
		document.forms[0].cmaformat.readOnly=true;
		document.forms[0].formula.readOnly=true;
		document.forms[0].txt_lending.readOnly=true;
		document.forms[0].sel_depends.disabled=true;
		document.forms[0].rowdesc.readOnly=true;

}

function doDelete()
{
	if (document.forms[0].rowdesc.value == "")
	{
		alert("select Row Description");
		return ;
	}
	if(ConfirmMsg(101))
	{
		document.forms[0].cmaformat.disabled=false;
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="finmaster";
		document.forms[0].hidval.value="delete";
		document.forms[0].hidBeanMethod.value="updateBenchmarkRatio";
		document.forms[0].hidBeanGetMethod.value="getDataHelp";
		document.forms[0].hidSourceUrl.value="/action/com_benchmarkRatio.jsp";
		document.forms[0].submit();
	}
}

function doSave()
{
       if (document.forms[0].cmaformat.value == "")
	   {
		   	alert("Select a CMA Index");
			return ;
		}
       else if(document.forms[0].rowdesc.value == "")
	   {
	        document.forms[0].rowdesc.focus();
			alert("Enter a Row Description");
			return ;
	    }
	   else if(document.forms[0].txt_lending.value == "")
	   {
	        document.forms[0].txt_lending.focus();
			alert("Enter Benchmark Level");
			return ;
	    }
	   else if(document.forms[0].sel_depends.value == "S")
	   {
	        document.forms[0].sel_depends.focus();
			alert("Select Depends on");
			return ;
	   }
	   if(document.forms[0].formula.value == "" && (document.forms[0].sel_depends.value=="FI" ||document.forms[0].sel_depends.value=="DSCR"))
	   {
			alert("Select Formula");
			return ;
	   }else{
		   document.forms[0].cmdsave.disabled=true;
		   document.forms[0].sel_depends.disabled=false;
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidBeanId.value="finmaster";
			document.forms[0].hidval.value=button;
			document.forms[0].hidBeanMethod.value="updateBenchmarkRatio";
			document.forms[0].hidBeanGetMethod.value="getDataHelp";
      		document.forms[0].hidSourceUrl.value="/action/com_benchmarkRatio.jsp";
			document.forms[0].submit();
		}
	
	
}
function addedit()
{
	
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			 document.forms[0].elements[i].readOnly=false;
			}	
		}
	document.forms[0].sel_depends.disabled=false;
	document.forms[0].cmaformat.readOnly=true;
	document.forms[0].rowdesc.readOnly=false;
	document.forms[0].formula.readOnly=true;
}

function doNew()
{
	button="insert";
	enableButtons(true,true,false,false,true,true);
	document.forms[0].rowdesc.value="";
	document.forms[0].txt_lending.value="";
	document.forms[0].sel_depends.value="S";
	document.forms[0].formula.value="";
	addedit();
}

function doEdit()
{
	button="update";
	if(document.forms[0].cmaformat.value == "")
	{
			alert("Select a CMA Index")
			return;
	}
	if (document.forms[0].rowdesc.value == "")
	{
			alert("Select a Row Description");
			return ;
	}
	else
	{
	enableButtons(true,true,false,false,true,true);
	varformula1=document.forms[0].formula.value;
	varformulano1=document.forms[0].formulano.value;
	varformulano2=document.forms[0].formulano2.value;
	vardesc=document.forms[0].rowdesc.value;
	document.forms[0].sel_depends.disabled=false;
	}
	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
	if(document.forms[0].elements[i].type=="text")
		{
		 document.forms[0].elements[i].readOnly=false;
		}	
	}

}

function showRating(val)
{
	
	var prop = "scrollbars=no,width=450,height=350";	
	var xpos = (screen.width - 450) / 2;
	var ypos = (screen.height - 350) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	if ((button == "add"  || button == "")&& (val == "rowdesc"))
	{
		return;
	}
	if(document.forms[0].cmdedit.disabled != true && val == "formula")
	{
		return;
	}

	if(document.forms[0].cmdsave.disabled != true || document.forms[0].cmdedit.disabled != true)
	{
		if(val=='formula')
		{
			if(document.forms[0].sel_depends.value=='S')
			{
			alert("Select Depends on");
			return;
			}
			if(document.forms[0].sel_depends.value=='OT')
			{
				var purl = appURL+"jsp/com/finbeanchselect.jsp";
			}
			else
			{
				cmano=document.forms[0].cmano.value;
					var purl = appURL+"jsp/com/finmasterselect.jsp?val="+val+"&cmano="+cmano;
			}
		}
		else
			{
				cmano=document.forms[0].cmano.value;
					var purl = appURL+"jsp/com/finmasterselect.jsp?val="+val+"&cmano="+cmano+"&pagetitle="+document.forms[0].hid_pagetitle.value;
			}
		var title = "Help";
		window.open(purl,title,prop);
	}
	
}

function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function kalyptocode()
{
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="whileLoading()">
<form class="normal" >
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Corporate Products -&gt; Benchmark Ratio </td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable border1 tableBg">
    <tr>
      <td>
        <table width="96%" border="0" cellspacing="0" cellpadding="5"
							align="center" >
          <tr class="dataHeadColor"> 
            <td width="26%">CMA Index</td>
            <td colspan="2" width="74%"> 
              <input type="text" name="cmaformat"
									size="30"
									value="<%= Helper.correctNull((String)hshValues.get("cmaformat"))%>">
              <b><span
									onClick="showRating('cma1')" style="cursor:hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="22"></span></b> 
          </tr>
          <tr> 
            <td width="26%">Row Description</td>
            <td colspan="2" width="74%"> 
              <input type="text" name="rowdesc"
									size="50"
									value="<%= Helper.correctNull((String)hshValues.get("rowdesc"))%>">
              <b><span
									onClick="showRating('benchrowdesc')" style="cursor:hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="22"></span></b></td>
          </tr>
          <tr> 
            <td width="26%">Benchmark Level</td>
            <td colspan="2" width="74%"> 
              <input type="text"
									name="txt_lending" size="30"
									value="<%= Helper.correctNull((String)hshValues.get(""))%>">
            </td>
          </tr>
          <tr> 
            <td width="26%">Depends on </td>
            <td colspan="2" width="74%"> 
              <select name="sel_depends">
                <option value="S" selected>&lt;--Select--&gt;</option>
                <option value="FI">Financial</option>
                <option value="DSCR">DSCR</option>
                <option value="PCOV">Security Coverage (Prime)</option>
                <option value="CRR">Credit Risk Rating</option>
                <option value="PTL">Period of the Term loan</option>
                <option value="M">Manual Entry</option>
              </select>
            </td>
          </tr>
          <tr> 
            <td width="26%"><span
									id="formulaid">Formula</span></td>
            <td colspan="2" width="74%"> 
              <input type="text" name="formula"
									size="30"
									value="<%= Helper.correctNull((String)hshValues.get("formula"))%>">
              <b><span
									onClick="showRating('formula')" style="cursor:hand"><img
									src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
									border="0" tabindex="22"></span></b></td>
          </tr>
        </table>
      </td>
    </tr>
 </table>
  <br>

<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' />
	
	<input type="hidden" name="sno"> 
	<input type="hidden" name="hidval"> 
	<input type="hidden" name="formulano"> 
	<input type="hidden" name="formulano2" value="<%= Helper.correctNull((String)hshValues.get("formulano2"))%>">
	<input type="hidden" name="cmano" value=""> 
	<input type="hidden" name="hid_pagetitle" value="cma1">
	<input type="hidden" name="tabtitle" value=""> 
	<input type="hidden" name="select_type">
	<input type="hidden" name="txtorder">
	<input type="hidden" name="formula2">
	
	
</form>
</body>
</html>