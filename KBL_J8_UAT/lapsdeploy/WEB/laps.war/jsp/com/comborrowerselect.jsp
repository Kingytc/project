<%@include file="../share/directives.jsp"%>
<% request.setAttribute("_cache_refresh", "true"); %>
<%
String strvalue="",strglpsize ="";
strvalue =request.getParameter("val");
strglpsize=request.getParameter("glpsize");
String strPageName =request.getParameter("pageName");

	int strrowindex =Integer.valueOf(Helper.correctInt((String)request.getParameter("rowindex")));
	int strrowcount =Integer.valueOf(Helper.correctInt((String)request.getParameter("rowcount")));

%>
<HTML>
<HEAD>
<TITLE> Help </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdadd.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdapply.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;
}
function doOk()
{
	var val="";
	var id="";
	var opt="<%=strvalue%>";
	var par ="<%//=par%>";
	var glpsize="<%=strglpsize%>";
	var varPagename="<%=strPageName%>";
	var varrowindex="<%=strrowindex%>";
	var varrowcount="<%=strrowcount%>";

	if(document.forms[0].cho_rate.selectedIndex<0)
	{
		alert("Select the Item");
	}
	else
	{
		val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
		id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
		if (opt == "2")
		{
			window.opener.document.forms[0].area2.value = val;	
			window.opener.document.forms[0].hidarea2.value=id;
			if(glpsize=="3")
			{
				window.opener.document.forms[0].area3.value="";
				window.opener.document.forms[0].hidarea3.value="";
			}
			else if(glpsize=="4")
			{
				window.opener.document.forms[0].area3.value="";
				window.opener.document.forms[0].hidarea3.value="";
				window.opener.document.forms[0].area4.value="";
				window.opener.document.forms[0].hidarea4.value="";
			}
			else if(glpsize=="5")
			{
				window.opener.document.forms[0].area3.value="";
				window.opener.document.forms[0].hidarea3.value="";
				window.opener.document.forms[0].area4.value="";
				window.opener.document.forms[0].hidarea4.value="";
				window.opener.document.forms[0].area5.value="";
				window.opener.document.forms[0].hidarea5.value="";
			}
		}
		if (opt == "3")
		{
			window.opener.document.forms[0].area3.value = val;	
			window.opener.document.forms[0].hidarea3.value=id;
			if(glpsize=="4")
			{
				window.opener.document.forms[0].area4.value="";
				window.opener.document.forms[0].hidarea4.value="";
			}
			else if(glpsize=="5")
			{
				window.opener.document.forms[0].area4.value="";
				window.opener.document.forms[0].hidarea4.value="";
				window.opener.document.forms[0].area5.value="";
				window.opener.document.forms[0].hidarea5.value="";
			}
		}
		if (opt == "4")
		{
			window.opener.document.forms[0].area4.value = val;	
			window.opener.document.forms[0].hidarea4.value=id;
			if(glpsize=="5")
			{
				window.opener.document.forms[0].area5.value="";
				window.opener.document.forms[0].hidarea5.value="";
			}
		}
		if (opt == "5")
		{
			window.opener.document.forms[0].area5.value = val;	
			window.opener.document.forms[0].hidarea5.value=id;
			
		}	

		if (glpsize == "66")
		{
			if(varrowcount==1)
			{
				window.opener.document.forms[0].org_code.value = val;	
				window.opener.document.forms[0].hidarea.value=id;
			}
			else
			{
				for(var i=0;i<varrowcount;i++)
				{
					if(window.opener.document.forms[0].hidarea[i].value==id)
					{
						alert("Organisation already exist");
						return;
					}
				}
				window.opener.document.forms[0].org_code[<%=strrowindex%>].value = val;	
				window.opener.document.forms[0].hidarea[<%=strrowindex%>].value=id;
			}
			
		}
		
      if(varPagename == "ATM")
       { 		 
		    window.opener.document.forms[0].hidBranches.value=id;
		    window.opener.document.forms[0].txt_Branchname.value=val;
		    document.forms[0].hidBranches.value=id;
		 
		   window.opener.funIfream();
      }

		
		window.close();
	}
}
function call_page()
{
	window.close();	
}

function doClose()
{
	window.close();
}

</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</HEAD>

<body>
<form name="selection" method="post" class="normal">    
  <table border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td colspan="2"><b>Help</b></td>
            </tr>
			<tr> 
              <td align=center>                                  
              <select name="cho_rate" size=15 style="width:400" onDblclick="doOk()">
                <lapschoice:borrowersearch /></select>				 
 			   </td>
               </tr></table></td></tr></table>
<lapschoice:combuttonnew btnnames='Ok' btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/> 			
<INPUT TYPE="hidden" name="val" value="category">

<input type="hidden" name="hidBeanId" value="">
<input type="hidden" name="hidBeanMethod" value=""> 
<input type="hidden" name="hidBeanGetMethod" value=""> 
<input type="hidden" name="hidBranches" value=""> 
</form>
</BODY>
</HTML>
