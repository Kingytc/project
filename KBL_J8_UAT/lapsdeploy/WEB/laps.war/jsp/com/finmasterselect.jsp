<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<% request.setAttribute("_cache_refresh", "true"); %>


<%
String strvalue="";
strvalue =request.getParameter("val");
String strCategory = Helper.correctNull((String)request.getParameter("lst_formula"));
String par =Helper.correctNull((String)request.getParameter("par"));

%>
<HTML>
<HEAD>
<TITLE> List Of <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </TITLE>
<META NAME="Generator" CONTENT="EditPlus">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";


function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	window.opener.document.forms[0].cmdsave.disabled=bool1;
	window.opener.document.forms[0].cmdedit.disabled=bool2;
	window.opener.document.forms[0].cmdsave.disabled=bool3;
	window.opener.document.forms[0].cmdcancel.disabled=bool4;
	window.opener.document.forms[0].cmdclose.disabled=bool5;

}



function doOk()
{
var val="";
var id="";
var opt="<%=strvalue%>";
var par ="<%=par%>";




if (document.forms[0].cho_rate.value != "")
	{

	val=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].text;
	id=document.forms[0].cho_rate.options[document.forms[0].cho_rate.selectedIndex].value;
//	window.opener.document.forms[0].val.value =opt ;	

	if (id == "0")
		{
			
		if (opt == "rowdesc")
			{ 
			window.opener.document.forms[0].rowdesc.value = "";	
			window.opener.document.forms[0].formula.value = "";	
			window.opener.document.forms[0].formulano.value = "";
			window.opener.document.forms[0].select_type.value = "S";	
			window.opener.document.forms[0].sno.value = "";	
			window.opener.document.forms[0].txt_kalypto_code.value = "";
			window.opener.document.forms[0].txt_experian_code.value = "";	
			enableButtons(false,false,true,true,false,false);
			}

			if (opt == "formula")
			{
			window.opener.document.forms[0].formula.value = "";	
			window.opener.document.forms[0].formulano.value="";
			}
			/*if (opt == "formula2")
			{
			window.opener.document.forms[0].formula2.value = "";	
			window.opener.document.forms[0].formulano2.value="";
			} */

			if (opt == "cma")
			{
				
			window.opener.document.forms[0].cmaformat.value = "";	
			window.opener.document.forms[0].cmano.value="";
			window.opener.document.forms[0].tabtitle.value="";
			window.opener.document.forms[0].rowdesc.value="";
			window.opener.document.forms[0].select_type.value="S";
			window.opener.document.forms[0].formula.value="";
			window.opener.document.forms[0].formulano.value="";
			window.opener.document.forms[0].txtorder.value="";
			//window.opener.document.forms[0].formulano2.value="";
			//window.opener.document.forms[0].formula2.value="";
			}
			if (opt == "tabtitle")
			{
			window.opener.document.forms[0].tabtitle.value = "";	
			window.opener.document.forms[0].select_type.value="S";
			window.opener.document.forms[0].formula.value="";
			window.opener.document.forms[0].formulano.value="";
			window.opener.document.forms[0].rowdesc.value="";
			window.opener.document.forms[0].txtorder.value="";
			//window.opener.document.forms[0].formulano2.value="";
			//window.opener.document.forms[0].formula2.value="";
			}
			if (opt == "ratingcma")
			{
				
			window.opener.document.forms[0].cmadesc.value = "";	
			window.opener.document.forms[0].cmano.value="";
			}
			


		}
	else
		{

						
		if (opt == "rowdesc")
		{
			window.opener.document.forms[0].rowdesc.value = val;	
			arr=id.split("^");
			if (arr[0] == "0")
			{
				arr[0]=""
			}
			if (arr[4] == "null")
			{
				arr[4]=""
			}
			window.opener.document.forms[0].formula.value = arr[0];	
			window.opener.document.forms[0].formulano.value = arr[1];
			window.opener.document.forms[0].select_type.value = arr[2];	
			window.opener.document.forms[0].sno.value = arr[3];	
			window.opener.document.forms[0].txtorder.value = arr[4];
			window.opener.document.forms[0].txt_kalypto_code.value = arr[11];
			window.opener.document.forms[0].txt_experian_code.value = arr[12];
			//window.opener.document.forms[0].formulano2.value = arr[7];
			//window.opener.document.forms[0].formula2.value = arr[8];
			//window.opener.document.forms[0].stressrdo.value = arr[9];
			val = arr[9];
			
			if(val == "Y")
			{
			//window.opener.document.all.stressId1.style.visibility="visible";
			//window.opener.document.all.stressId2.style.visibility="visible";
			window.opener.document.forms[0].stressrdo[0].checked = true;

			}
			else if(val == "N")
			{
			//window.opener.document.all.stressId1.style.visibility="hidden";
			//window.opener.document.all.stressId2.style.visibility="hidden";
			window.opener.document.forms[0].stressrdo[1].checked =true;

			}

			//window.opener.document.forms[0].stresspercent.value = arr[10];
			enableButtons(false,false,true,true,false,false);

			
				
				
			if (arr[6] != "FI" || arr[6] != "RA")
			{
				window.opener.document.forms[0].tabtitle.disabled=true;
			}	
			
	}

		if (opt == "formula")
			{
			if(id !="")
			{
			var idVal=id.indexOf("::");
			idVal=id.substr(0,idVal);
				window.opener.document.forms[0].formula.value = val;	
				window.opener.document.forms[0].formulano.value=idVal;
				}
			}
		/*if (opt == "formula2")
			{
			if(id !="")
			{
			var idVal2=id.indexOf("::");
			idVal2=id.substr(0,idVal2);
				window.opener.document.forms[0].formula2.value = val;	
				window.opener.document.forms[0].formulano2.value=idVal2;
				}
			}*/
		if (opt == "cma1")
			{	
				
				window.opener.document.forms[0].cmaformat.value = val;	
				window.opener.document.forms[0].cmano.value=id;
				window.opener.document.forms[0].tabtitle.value="";
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].select_type.value="S";
				window.opener.document.forms[0].formula.value="";
				window.opener.document.forms[0].formulano.value="";
				window.opener.document.forms[0].txtorder.value="";
				//window.opener.document.forms[0].formulano2.value="";
				//window.opener.document.forms[0].formula2.value="";
			}
			if (opt == "ratingcma")
			{
				window.opener.document.forms[0].cmadesc.value = val;	
				window.opener.document.forms[0].cmano.value=id;

				
			}
		if (opt == "cma")
		{		
				window.opener.document.forms[0].cmaformat.value = val;	
				window.opener.document.forms[0].cmano.value=id;
				window.opener.document.forms[0].hidMode.value="edit";
				window.opener.document.forms[0].method="post";
				window.opener.document.forms[0].hidBeanId.value="formula";
				window.opener.document.forms[0].hidBeanGetMethod.value="getCMA";
				window.opener.document.forms[0].action=appURL+"action/com_cma_master.jsp";
				//window.opener.document.forms[0].hidSourceUrl.value="/action/com_cma_master.jsp";
				window.opener.document.forms[0].submit();
		}
		if (opt == "tabtitle")
			{
				window.opener.document.forms[0].tabtitle.value = val;	
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].select_type.value="S";
				window.opener.document.forms[0].formula.value="";
				window.opener.document.forms[0].formulano.value="";
				window.opener.document.forms[0].rowdesc.value="";
				window.opener.document.forms[0].txtorder.value="";
				//window.opener.document.forms[0].formulano2.value="";
				//window.opener.document.forms[0].formula2.value="";
			}

		if (opt == "benchrowdesc")
		{
			window.opener.document.forms[0].rowdesc.value = val;	
			arr=id.split("^");
			if (arr[0] == "0")
			{
				arr[0]=""
			}
			if (arr[4] == "null")
			{
				arr[4]=""
			} 
			window.opener.document.forms[0].txt_lending.value = arr[0];	
			window.opener.document.forms[0].sel_depends.value = arr[1];
			window.opener.document.forms[0].formula.value = arr[2];	
			window.opener.document.forms[0].sno.value = arr[3];
			window.opener.document.forms[0].formulano.value = arr[4];
			enableButtons(true,false,true,false,true,false);
		}
	}
		window.opener.kalyptocode();							
		window.close();
}

 else 
	{
		alert("Select a value");
		return;
	}

}

function doClose()
{
	window.close();
	
}

function getFormula()
{
	
	document.forms[0].submit();
}

</script>
</HEAD>

<body>
<form name="selection" method="post" class="normal">


    
  <table border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
    <tr> 
        <td valign="top">
          <table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
            <tr class="dataheader"> 
              <td width="28%"><b>
               Select <%=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length())%> </b>
               <%String strVal=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length());
             
              if((strVal.equalsIgnoreCase("Formula"))||(strVal.equalsIgnoreCase("Formula2") ))
               {%>
                 
						<select name="lst_formula" onChange="getFormula()">
                                  <option value="" <%=strCategory.trim().equals("")?"selected":""%>><--Select--></option>
                                  <option value="FI" <%=strCategory.trim().equals("FI")?"selected":""%>>Financial</option>
                                  <option value="CA" <%=strCategory.trim().equals("CA")?"selected":""%>>CashFlow</option>
                                  <option value="FU" <%=strCategory.trim().equals("FU")?"selected":""%>>FundFlow</option>
                                  <option value="RA" <%=strCategory.trim().equals("RA")?"selected":""%>>Ratios</option>
                                   <option value="DSCR" <%=strCategory.trim().equals("DSCR")?"selected":""%>>DSCR</option>
                                  <option value="INV" <%=strCategory.trim().equals("INV")?"selected":""%>>Assessment - Inventory Norms</option>
                                  <option value="MU" <%=strCategory.trim().equals("MU")?"selected":""%>>Assessment - MPBF UPTO 25 CRORES</option>
                                  <option value="MA" <%=strCategory.trim().equals("MA")?"selected":""%>>Assessment - MPBF ABOVE 25 CRORES</option>
                                  <option value="FL" <%=strCategory.trim().equals("FL")?"selected":""%>>Assessment - Forex Limits</option> 
                                  <%-- <option value="PBF4" <%=strCategory.trim().equals("PBF4")?"selected":""%>>Assessment - PBF4</option>
                                  <option value="PBF1" <%=strCategory.trim().equals("PBF1")?"selected":""%>>Assessment - PBF1</option>
                                 
								  <option value="RHP" <%=strCategory.trim().equals("RHP")?"selected":""%>>Ratios - Holding Period</option>--%>								
						</select>
                  </td>
                  <%} %>
            </tr>
			<tr class="datagrid"> 
                                <td align=center> 
                                
                                <%String strVal1=strvalue.substring(0,1).toUpperCase()+strvalue.substring(1,strvalue.length());
             
                                if((strVal.equalsIgnoreCase("Formula"))||(strVal.equalsIgnoreCase("Formula2") ))
               {%><select name="cho_rate" size=15 style="width:400" onDblClick="javascript:doOk()">
                <option value = "0">----Deselect-----</option>
                <laps:comFormula /> 
              </select>
              <%} else{%>
                                  
              <select name="cho_rate" size=15 style="width:400" >
                <option value = "0">----Deselect-----</option>
                                    <laps:finmaster /> 
									
								</select>
								<%} %>
                                
                                  
                                  </td>
                              </tr></table></td></tr></table>
							  <br>
							  

<lapschoice:combuttonnew btnnames="Ok"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />			
</form>
   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="val" value="<%=strvalue%>">
<input type=hidden name="hidPageName" value="finmasterselect.jsp" >
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>" >

</BODY>
</HTML>
