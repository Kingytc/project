<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<%@ include file="../share/directives.jsp"%>


<% request.setAttribute("_cache_refresh", "true"); %>
<%
String val=Helper.correctNull(request.getParameter("val"));
String num=Helper.correctNull(request.getParameter("num"));

%>
<HTML>
<HEAD>
<TITLE> List Of <%//=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </TITLE>
<META NAME="Generator" CONTENT="EditPlus">

<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";






function doOk()
{
	var valu="";
	var id="";
	var flag = "<%=Helper.correctNull((String)request.getParameter("flag"))%>";
	var num="<%=num%>";
	var baserate = "<%=Helper.correctNull((String)request.getParameter("baserate"))%>";
	if (document.forms[0].cho_rate.value != "" && flag!="ops")
	{
		valu=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
		id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
		arr= id.split("^");

		if (baserate == "total")
		{
			window.opener.document.forms[0].total[num].value = arr[0];
		}
		else
		{
			if(flag=="corp")
			{
				window.opener.document.forms[0].baserate[num].value = arr[0];
			}
			else
			{
				if(num == "-")
				{
					if(baserate=="prd_intrate")
					{
						window.opener.document.forms[0].prd_inttype.value = valu;
						window.opener.document.forms[0].prd_intrate.value = arr[0];
						window.opener.document.forms[0].txt_interest.value = arr[0];
					}
					if(baserate=="prd_subintrate")
					{
						window.opener.document.forms[0].prd_subinttype.value = valu;
						window.opener.document.forms[0].prd_subintrate.value = arr[0];
						window.opener.document.forms[0].txt_subinterest.value = arr[0];
					}
					if(baserate=="txt_rateofint")
					{
						window.opener.document.forms[0].txt_rateofint.value =  arr[0];
					}
					
				}
				else
				{
					window.opener.document.forms[0].baserate[num].value = arr[0];
				}
			}
		}
		if(num != "-")
		{
			window.opener.document.forms[0].interestid[num].value = arr[1];
		}
		window.close();
	}
	else if(flag=="ops")
	{
		valu=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
		id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
		arr= id.split("^");

		if (baserate == "total")
		{
			window.opener.document.forms[0].total.value = arr[0];
		}
		else
		{
			if(num == "-")
			{
				if(baserate=="prd_intrate")
				{
					window.opener.document.forms[0].prd_inttype.value = valu;
					window.opener.document.forms[0].prd_intrate.value = arr[0];
					window.opener.document.forms[0].txt_interest.value = arr[0];
				}
				if(baserate=="prd_subintrate")
				{
					window.opener.document.forms[0].prd_subinttype.value = valu;
					window.opener.document.forms[0].prd_subintrate.value = arr[0];
					window.opener.document.forms[0].txt_subinterest.value = arr[0];
				}
				
			}
			else
			{
			
				window.opener.document.forms[0].baserate.value = arr[0];
			}
		}
		
		window.close();
	}
	
	else
	{
		alert("Select a value");
	}

}
function doClose()
{
	window.close();
}
</script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css"
	type="text/css">
</HEAD>

<body >
<form name="selection" method="post" class="normal">

    
  <table border="0" cellspacing="0" cellpadding="3" class="outertable border1" align="center">
    <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td colspan="2"><b>
               Select <%//=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </b></td>
            </tr>
			<tr> 
                                <td align=center>  
                                  
              <select name="cho_rate"   size=9 style="width:400;height:250" ondblclick="doOk()" >
                <lapschoice:fixedrateselect /> 
              </select>
                                </td>
                              </tr>
							  </table></td></tr></table>
							  <br>
							  

                                      <lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
	 <input type=hidden name=hiddesc value="">
  <input type=hidden name=hidtype value="">
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 		
</form>
</BODY>
</HTML>
