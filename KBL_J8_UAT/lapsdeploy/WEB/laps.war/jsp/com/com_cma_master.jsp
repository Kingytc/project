<%@ include file="../share/directives.jsp"%>
<%@ taglib prefix="laps" uri="/WEB-INF/laps.tld"%>
<%ArrayList arrIndusttryVal = new ArrayList();
			ArrayList arrIndustryCheckedVal = new ArrayList();
			int arrIndusttrysize = 0;
			int arrIndustryCheckedsize = 0;
			String strCMAName = "";
			String strCMANo = "";
			if (hshValues != null) {
				arrIndusttryVal = (ArrayList) hshValues.get("arrIndusttryVal");
				arrIndustryCheckedVal = (ArrayList) hshValues
						.get("arrIndustryCheckedVal");
				strCMAName = Helper.correctNull((String) hshValues
						.get("strCMAName"));
				strCMANo = Helper.correctNull((String) hshValues
						.get("strCMANo"));
			}

			if (arrIndusttryVal != null) {
				arrIndusttrysize = arrIndusttryVal.size();
				arrIndustryCheckedsize = arrIndustryCheckedVal.size();
			}
%>

<html>
<head>
<title>CMA Format Master</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js">
</script>
<script>
var path      ="<%=ApplicationParams.getAppUrl()%>";
var isnew="false";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		document.forms[0].action=path+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function doDelete()
{
	if(document.forms[0].cmaformat.value=="")
	{
		alert("Select CMA Type ");
	}
	else
	{
		if(ConfirmMsg(101))
		 {
			document.forms[0].cmano.value="<%=strCMANo%>";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="formula";
			document.forms[0].action=path+"controllerservlet";
			document.forms[0].hidBeanMethod.value="updateCMAData";
			document.forms[0].hidBeanGetMethod.value="getCMA";
			document.forms[0].hidSourceUrl.value="/action/com_cma_master.jsp";
			document.forms[0].submit();
		 }
	}
}

function doSave()
{

	
			if(document.forms[0].cmaformat.value=="" )
			{
				if(document.forms[0].hidMode.value=="new")
				{
					alert("Enter CMA Type");
				}
				else{
					alert("Select CMA Type");
				}
				return false;
			}
		var flag =false;		
			for(var i=0;i<document.forms[0].elements.length;i++)
				{
					if(document.forms[0].elements[i].type=="checkbox")
						{				
								if(document.forms[0].elements[i].checked==true){
								    flag = true;
								    break;
								}
						}				
				 }

			if(!flag){
				alert("Select Industry");
				return;
			}
			
			//document.forms[0].method="post";
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].action=path+"controllerservlet";	
			document.forms[0].hidBeanId.value="formula";			
			document.forms[0].hidBeanMethod.value="updateCMAData";			
			document.forms[0].hidBeanGetMethod.value="getCMA";
			document.forms[0].hidSourceUrl.value="/action/com_cma_master.jsp";
			document.forms[0].submit();
}
function showRating(val)
{
		tabtitle="";
		cmano="";
		
		var purl = appURL+"jsp/com/finmasterselect.jsp?val="+val+"&tabtitle="+tabtitle+"cmano="+cmano;
		var title = "Help";
		var prop = "scrollbars=no,width=450,height=320";	
		var xpos = (screen.width - 450) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos+",menubar=no, scrollbars=no";
		window.open(purl,title,prop);
}

function doCancel()
{
	if(ConfirmMsg(102))
	 {
		if(document.forms[0].hidMode.value=="new")
		 {
			document.forms[0].hidMode.value="edit"
		 }
		 else if(document.forms[0].hidMode.value=="edit")
		 {
			document.forms[0].hidMode.value="";
		 }

		
			document.forms[0].method="post";
			document.forms[0].hidBeanId.value="formula";
			document.forms[0].hidBeanGetMethod.value="getCMA";
			document.forms[0].hidBeanMethod.value="getCMA";
			document.forms[0].action=path+"controllerservlet";			
			document.forms[0].hidSourceUrl.value="/action/com_cma_master.jsp";
			document.forms[0].submit();

	 
	 }
}
function placeValues()
{

	if(document.forms[0].hidMode.value == "new")
	{		
		enableButtons(true,false,false,true,false,false);
	
		document.forms[0].cmaformat.value="";		
		document.forms[0].cmaformat.focus();
		document.forms[0].cmano.value="";
		document.forms[0].cmaformat.readOnly=false;
		document.all.help.style.visibility="hidden";
		changemode(false);
	}
	else if(document.forms[0].hidMode.value == "edit")
	{
		enableButtons(false,false,true,false,true,false);	 
		document.forms[0].cmaformat.readOnly=true;
		document.all.help.style.visibility="visible"
		changemode(true);
	}
	else if(document.forms[0].hidMode.value == "")
	{
	
		enableButtons(false,false,true,false,true,false);	 
		document.forms[0].cmaformat.readOnly=true;
		document.all.help.style.visibility="visible"
		changemode(true);
	}




	 var arrIndustryChecked =new Array();
	if("<%=arrIndustryCheckedsize%>" >0){

	<%
			ArrayList arrindustryname = null;
					 for(int j=0;j<arrIndustryCheckedsize;j++){
						arrindustryname = (ArrayList)arrIndustryCheckedVal.get(j);
	%>
						arrIndustryChecked[<%=j%>]="<%=(String)arrindustryname.get(0)%>";

	 <% } %>								for(var i=0;i<document.forms[0].elements.length;i++)
										{
												if(document.forms[0].elements[i].type=="checkbox")
																{
																document.forms[0].elements[i].checked=false;
																}
										}


											document.forms[0].cmaformat.value ="<%= strCMAName %>";
											
										
													for(var i=0;i<document.forms[0].elements.length;i++)
														{
															if(document.forms[0].elements[i].type=="checkbox")
																{
															for(var j=0;j<arrIndustryChecked.length;j++){
																if(document.forms[0].elements[i].value==arrIndustryChecked[j]){	
																	document.forms[0].elements[i].checked=true;
																}
															}
														 }
											 }

			
		}
														

}
function doEdit()
{
	if (document.forms[0].cmaformat.value=="")
	{
		alert("Select CMA format");
		return false;
	}
	document.forms[0].hidMode.value="edit";
	document.forms[0].hidAction.value="update";
	document.forms[0].cmano.value="<%=strCMANo%>";
	document.all.help.style.visibility="visible";
	/*if (document.forms[0].cmaformat.value=="")
	{
	document.forms[0].cmaformat.readOnly=true;
	}
	if (document.forms[0].cmaformat.value!="")
	{
		document.forms[0].cmaformat.readOnly=false;
		document.forms[0].cmaformat.focus();
	}*/
	enableButtons(true,true,false,true,false,true);
	changemode(false);

}
function doNew()
{
	document.forms[0].hidMode.value="new";
	document.forms[0].hidAction.value="insert";
	document.forms[0].cmano.value="";
	document.forms[0].cmaformat.value="";
	document.forms[0].cmaformat.readOnly=false;
	document.all.help.style.visibility="hidden";
	enableButtons(true,true,false,true,false,true);
	changemode(false);
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
	

}


function changemode(val)
{
	
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="checkbox")
			{
				if(document.forms[0].hidMode.value!="edit"){
				document.forms[0].elements[i].checked=false;
				}
				document.forms[0].elements[i].disabled=val;
			}
				
	}	
		
	
}
function kalyptocode()
{
}
</script>

<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="placeValues()">
<form name="frmcma" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td class="page_flow" >Home -&gt; Setup -&gt; Corporate Products -&gt; CMA Index
</td>
	</tr>
</table>
<br>
<table width="98%" border="0" cellspacing="0" cellpadding="5" align="center" class="outertable">
	<tr>
	  <td><table width="80%" border="0" cellspacing="0" cellpadding="2" class="outertable"	align="center" >
        <tr>
          <td><table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
              <tr>
                <td width="13%">CMA Index</td>
                <td><table width="22%" border="0" cellspacing="0" cellpadding="3" class="outertable">
                    <tr>
                      <td><input type="text" name="cmaformat" size="25" value="" readOnly></td>
                      <td id="help">
                      		<b><span
							onClick="showRating('cma')" style="cursor:hand"><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></span></b>
					 </td>                      
                    </tr>
                </table></td>
              </tr>
              <tr align="center">
              <td colspan="2">
					<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete"
							btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
							</td>
							</tr>
              <tr>
                <td colspan="2"><b>Applicable
                  Industry Names</b></td>
              </tr>
              <tr>
                <td colspan="2"><table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable linebor">
                    <%ArrayList arrIndusttryname = null;
			if (arrIndusttrysize > 0) {

				for (int i = 0; i < arrIndusttrysize; i++) {
					arrIndusttryname = (ArrayList) arrIndusttryVal.get(i);
					String indno = Helper.correctNull((String) arrIndusttryname
							.get(0));
					String indname = Helper
							.correctNull((String) arrIndusttryname.get(1));

					%>
                    <tr>
                      <td width="6%"><input checked type="checkbox" name="indno"
													value="<%= indno %>" style="border-style:none"></td>
                      <td width="94%"><%=indname%></td>
                    </tr>
                    <%}
			}

			%>
                </table></td>
              </tr>
          </table></td>
        </tr>
      </table></td>
	</tr>
</table>

   <lapschoice:hiddentag pageid='<%=PageId%>'/> 
<INPUT TYPE="hidden" name="hidAudit" value="<%=Helper.correctNull((String)hshValues.get("oldVal"))%>"> 

<input type="hidden" name="hidMode" value="">

 <!--  <input type="text" name="hidNew" value="<%//=Helper.correctNull((String)hshValues.get("cmano"))%>"> -->
 
<input type="hidden" name="cmano" value=""> 
<input type="hidden" name="hidtotal" value=""> 
<input type=hidden name="hidPageName" value="com_cma_master.jsp">

</form>
</body>
</html>
