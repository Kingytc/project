<%@include file="../share/directives.jsp"%>
<%String strAppno = Helper.correctNull((String)request.getParameter("appno"));
 if(strAppno.equalsIgnoreCase(""))
 {
	 strAppno = Helper.correctNull((String)hshValues.get("appno"));
 }
 String strFacSno = Helper.correctNull((String)hshValues.get("strFacSno"));

String strSessionModuleType=Helper.correctNull((String)session.getAttribute("sessionModuleType")).trim();

if(strFacSno.equals(""))
	{
		strFacSno=	Helper.correctNull((String)hshValues.get("strfacilitysno"));
	}

ArrayList arrRow1=new ArrayList();
ArrayList arrRow=new ArrayList();
ArrayList arrCol=new ArrayList();
String stravail="";
arrRow1=(ArrayList)hshValues.get("arrRow");
int k=0;
if(arrRow1!=null && arrRow1.size()>0)
{
	for(int i=0;i<arrRow1.size();i++)
	{
		arrRow=(ArrayList)arrRow1.get(i);
		for(int j=0;j<arrRow.size();j++){k++;}
	}
}
%>
<html>
<head>
<title>Document Details</title>

<script>
var varFacSno = "<%=strFacSno%>";
var varModule="<%=strSessionModuleType%>";
var varODFlag="<%=Helper.correctNull((String)hshValues.get("strODFlag"))%>";
function doClose()
{
	if( ConfirmMsg(100) )
	{
		
		window.opener.document.forms[0].hidAppDoc.value="I";
		window.opener.document.forms[0].hidBeanGetMethod.value="getData";
		window.opener.document.forms[0].hidBeanId.value="commdocument";
		window.opener.document.forms[0].action=appURL+"action/appdocumentsinter.jsp";	
		window.opener.document.forms[0].submit();	

		window.close();
	}
}

function disableCommandButtons(val1,val2,val3,val4,val5)
{
	document.forms[0].cmdedit.disabled=val1;
  	document.forms[0].cmdsave.disabled=val3;
  	document.forms[0].cmdcancel.disabled=val4;
  	document.forms[0].cmdclose.disabled=val5;
}

function onLoading()
{
	disableFields(true);
	disableCommandButtons(false,true,true,true,false);

	if(varFacSno!="0")
		document.forms[0].sel_facilitysno.value = varFacSno;
	else
		document.forms[0].sel_facilitysno.value = "";
	
	document.forms[0].sel_facilitysno.disabled=false;

	<%int a=0;
	if(arrRow1!=null && arrRow1.size()>0)
	{
		for(int i=0;i<arrRow1.size();i++)
		{
			arrRow=(ArrayList)arrRow1.get(i);
			for(int j=0;j<arrRow.size();j++){
				arrCol=(ArrayList)arrRow.get(j);
				
				if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("Y")){
					stravail="Y";
				}else if(Helper.correctNull((String)arrCol.get(4)).equalsIgnoreCase("N")){
					stravail="N";
					}else{
					stravail="S";
					}
				if(!Helper.correctNull((String)arrCol.get(3)).equalsIgnoreCase("")){
				if(k>=2){%>
				document.forms[0].chk_box[<%=a%>].checked=true;
				document.forms[0].sel_type[<%=a%>].value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				document.forms[0].selaccoperby[<%=a%>].value="<%=stravail%>";
				<%}else if(k==1){%>
				document.forms[0].chk_box.checked=true;
				document.forms[0].sel_type.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				document.forms[0].selaccoperby.value="<%=stravail%>";
				<%}%>
				
			<% }else{
				if(k>=2){%>
				document.forms[0].chk_box[<%=a%>].checked=false;
				document.forms[0].sel_type[<%=a%>].value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				document.forms[0].selaccoperby[<%=a%>].value="<%=stravail%>";
				<%}else if(k==1){%>
				document.forms[0].chk_box.checked=false;
				document.forms[0].sel_type.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
				document.forms[0].selaccoperby.value="<%=stravail%>";
				<%}}%>
			<% a++; } %>
		<%}%>
		
	<%}%>
	if(varModule=="CORP" || varModule=="AGR")
	{
		document.forms[0].sel_facilitysno.value=varFacSno;
		if(document.forms[0].sel_facilitysno.value=="")
		{
			disableCommandButtons(true,true,true,true,false);
		}
	}

}

function doEdit()
{
	if(varModule=="CORP" || varModule=="AGR")
	{
		if(document.forms[0].sel_facilitysno.value=="")
		{
			alert("Select a facility");
			document.forms[0].sel_facilitysno.focus();
			return;
		}
	}
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
	document.forms[0].sel_facilitysno.disabled=true;
	document.forms[0].txt_releasedate.readOnly=true;
	<%int a1=0;
	if(arrRow1!=null && arrRow1.size()>0)
	{
		for(int i=0;i<arrRow1.size();i++)
		{
			arrRow=(ArrayList)arrRow1.get(i);
			for(int j=0;j<arrRow.size();j++){
				arrCol=(ArrayList)arrRow.get(j);
				
				if(arrRow!=null && arrRow.size()>0){%>
				
					<%if(k==1){%>
					document.forms[0].chk_box.checked=true;
					document.forms[0].hid_apptype1.value="<%=Helper.correctNull((String)arrCol.get(0))%>";
					<%}else{%>
					document.forms[0].chk_box[<%=a1%>].checked=true;
					document.forms[0].hid_apptype1[<%=a1%>].value="<%=Helper.correctNull((String)arrCol.get(0))%>";
					<%}%>
				
			<%}%>
			<%if(Helper.correctNull((String)arrCol.get(0)).equalsIgnoreCase("a")){%>
			<%if(k==1){%>
			document.forms[0].chk_box.checked=true;
			document.forms[0].chk_box.disabled=true;
			<%}else{%>
			document.forms[0].chk_box[<%=a1%>].checked=true;
			document.forms[0].chk_box[<%=a1%>].disabled=true;
			<%}%>
			<%}a1++;}%>

		<%}%>
	<%}%>
}

function disableFields(val)
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
		if(document.forms[0].elements[i].type=='checkbox')
		{
			document.forms[0].elements[i].disabled=val;
		}	
	}
}
function doSave()
{
	if(document.forms[0].txt_releasedate.value=="")
	{
		alert("Select Release Date of MCLR");
		document.forms[0].txt_releasedate.focus();
		return;
	}

	if(document.forms[0].hid_branchcode.value=="")
	{
		alert("Select Loan Disbursing Branch");
		document.forms[0].txt_branchcode.focus();
		return;
	}

	
	if(varODFlag=="OD")
	{
		if(document.forms[0].chk_box.length!=undefined && document.forms[0].chk_box.length>1)
		{
			for(var i=0;i<document.forms[0].selaccoperby.length;i++)
			{
				if(document.forms[0].selaccoperby[i].value=="S")
				{
					alert("Please Select Account to be operated by");
					document.forms[0].selaccoperby[i].focus();
					return;
				}
			}
		}
		else
		{
			if(document.forms[0].selaccoperby.value=="S")
			{
				alert("Please Select Account to be operated by");
				document.forms[0].selaccoperby.focus();
				return;
			}
		}
	}

	
	disableFields(false);
	document.forms[0].sel_facilitysno.disabled=false;
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].hidBeanMethod.value="updateDocPrintDetails";
	document.forms[0].hidBeanGetMethod.value="printDocumentDetails";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_documentprintdetails.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if(ConfirmMsg('102'))
	{
		document.forms[0].hidBeanGetMethod.value="printDocumentDetails";
		document.forms[0].hidBeanId.value="commdocument";
		document.forms[0].action=appURL+"action/com_documentprintdetails.jsp";	
		document.forms[0].submit();
	}
}

function LoadValues()
{
	document.forms[0].hidBeanGetMethod.value="printDocumentDetails";
	document.forms[0].hidBeanId.value="commdocument";
	document.forms[0].action=appURL+"action/com_documentprintdetails.jsp";	
	document.forms[0].submit();
}
function callCalender(cmdname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,cmdname);
	}
} 
function chktype(obj,val,type)
{
	var len=document.forms[0].chk_box.length;
	var obj1;
	if(len!=undefined)
	{
		for(var i=0;i<len;i++)
		{
			if(type=="S")
			{
				if(obj==document.forms[0].sel_type[i])
				{
					obj1=i;
				}
			}
			else
			{
				if(obj==document.forms[0].chk_box[i])
				{
					obj1=i;
				}
			}
		}
		if(document.forms[0].chk_box[obj1].checked==true)
		{
			document.forms[0].hid_apptype1[obj1].value=document.forms[0].sel_type[obj1].value;
		}
		else
		{
			document.forms[0].hid_apptype1[obj1].value="";
		}

	}
	else
	{
		if(document.forms[0].chk_box.checked==true)
		{
			document.forms[0].hid_apptype1.value=document.forms[0].sel_type.value;
		}
		else
		{
			document.forms[0].hid_apptype1.value="";
		}
	}
	
}

function showOrganizationSearch(path, forgscode, forgname)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var varQryString = path+"action/searchOrg.jsp?forgscode="+forgscode+"&forgname="+forgname;
		var title = "Organization";
		var prop = "scrollbars=yes,width=500,height=400,menubar=yes";	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 120) / 2;
		prop = prop + ",left=50,top=50";
		window.open(varQryString,title,prop);
	}
}
</script>
</head>
<body onLoad="onLoading()">
<form name="frm" method="post" class="normal">
<br>
<table width="95%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
<tr>
	<td colspan="2">
		<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable" align="center">
		<%if(strSessionModuleType.equalsIgnoreCase("RET") || strSessionModuleType.equalsIgnoreCase("LAD") || strSessionModuleType.equalsIgnoreCase("DIGI")  ){ %>
		<tr style="display: none;">
				<td>
				<input type="hidden" name="sel_facilitysno" value="1">
				</td>
			</tr>
		<%}else if(strSessionModuleType.equalsIgnoreCase("CORP") || strSessionModuleType.equalsIgnoreCase("AGR")){ %>
			<tr class="datagrid">
				<td>
				Facility &nbsp; &nbsp;
				<select name="sel_facilitysno" tabindex="1" onchange="LoadValues()">
				<option value="" selected="selected">--Select--</option>
		        <lapschoice:ComMisDetailsTag apptype='<%=Helper.correctNull((String)request.getParameter("appno")) %>' page='mis'/>
				</select>
				</td>
			</tr>
		<%} %>
		</table>
	</td>
</tr>
<tr class="datagrid">
	<td width="20%">Date of Release <span class="mantatory">*</span></td>
	<td><input type="text" name="txt_releasedate" onBlur="checkDate(this);checkmindate(this,'<%=Helper.correctNull((String)hshValues.get("strSanctionDate")) %>');checkmaxdate(this,'<%=Helper.getCurrentDateTime() %>');" size="10" value="<%=Helper.correctNull((String)hshValues.get("strReleaseDateofMCLR")) %>"> &nbsp; <a alt="Select date from calender"
						href="javascript:callCalender('txt_releasedate')"> <img
						src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border="0"></a></td>
</tr>

<tr class="datagrid">
	<td width="20%">Loan Disbursing Branch <span class="mantatory">*</span></td>
	<td>
		<input type="text" name="txt_branchcode" size="38" value="<%=Helper.correctNull((String)hshValues.get("strBrachName"))%>">
		<input type="hidden" name="hid_branchcode" value="<%=Helper.correctNull((String)hshValues.get("strBrachCode"))%>">
		<b><a href="#" onClick="showOrganizationSearch('<%=ApplicationParams.getAppUrl()%>','hid_branchcode','txt_branchcode')" style="cursor: hand">
		<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0" ></a></b>
    </td>
</tr>
<%

if(arrRow1!=null && arrRow1.size()>0)
{
	for(int i=0;i<arrRow1.size();i++)
	{
		arrRow=(ArrayList)arrRow1.get(i);
		for(int j=0;j<arrRow.size();j++){
			arrCol=(ArrayList)arrRow.get(j);
		
			if(j==0)
			{
			%>
				<tr>
					<td class="dataheader" colspan="1">
						<%if(Helper.correctNull((String)arrCol.get(0)).equals("a")){ %>
							Applicant Details
						<%} else if(Helper.correctNull((String)arrCol.get(0)).equals("c")){ %>
							Joint Applicant Details
						<%} else if(Helper.correctNull((String)arrCol.get(0)).equals("g")){ %>
							Guarantor Details
						<%} else if(Helper.correctNull((String)arrCol.get(0)).equals("p")){ %>
							Sole properitier Details
						<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("o")){ %>
							Co-Obligant Details
						<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("G")){ %>
							Guarantor Details
						<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("C")){ %>
							Co-Applicant Details
						<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("CO")){ %>
							Co-Obligant Details
						<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("SP")){ %>
							Sole Proprietor Details
						<%}%>
					</td>
					<td width="10%" class="dataheader" ><%if(Helper.correctNull((String)hshValues.get("strODFlag")).equalsIgnoreCase("OD")){ %> Account to be operated by<span class="mantatory">*&nbsp;</span><%} %></td>
				</tr>
				
			<%}%>
		<tr class="datagrid">
		<td colspan="1">
		<input type="checkbox" name="chk_box" value="<%=Helper.correctNull((String)arrCol.get(0))%>" style="border: none;" onclick="chktype(this,'<%=Helper.correctNull((String)arrCol.get(0))%>','C');">
		&nbsp;&nbsp; <%=Helper.correctNull((String)arrCol.get(2)) %> <select  name="sel_type" style="visibility: hidden;">
		<%if(Helper.correctNull((String)arrCol.get(0)).equals("a")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Applicant</option>
		<%} else if(Helper.correctNull((String)arrCol.get(0)).equals("c")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Co-Applicant</option>
		<%} else if(Helper.correctNull((String)arrCol.get(0)).equals("p")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Sole properitier</option>
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("o")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Co-Obligant</option>
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("g")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Guarantor</option>
		
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("SP")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Sole Proprietor</option>
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("CO")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Co-Obligant</option>
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("C")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Co-Applicant</option>
		<%}else if(Helper.correctNull((String)arrCol.get(0)).equals("G")){%>
		<option value="<%=Helper.correctNull((String)arrCol.get(0)) %>" selected="selected">Guarantor</option>
		<%} %>
		</select> 
		<input type="hidden" name="hid_apptype" value="<%=Helper.correctNull((String)arrCol.get(0)) %>">
		<input type="hidden" name="hid_apptype1" value="<%=Helper.correctNull((String)arrCol.get(3)) %>">
		 <input type="hidden" name="hid_demoid" value="<%=Helper.correctNull((String)arrCol.get(1)) %>"></td>

		<td width="19%">
		<%if(Helper.correctNull((String)hshValues.get("strODFlag")).equalsIgnoreCase("OD")){ %>
					<select name="selaccoperby" size="1">
						<option value="S">--Select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select>
					<%}else{ %>
					<select name="selaccoperby" size="1"  style="visibility: hidden;">
						<option value="S">--Select--</option>
						<option value="Y">Yes</option>
						<option value="N">No</option>
					</select>
					<%} %>
		</td>
		</tr>
		
			
		<%}
	}
}
%>

</table>
<br>  
<lapschoice:combuttonnew btnnames='Edit_Save_Cancel' btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/>
<input type="hidden" name="appno" value="<%=strAppno %>">
 <span class="mantatory">Note : Please Check the borrower Details to display in the Documents.</span>
</form>
</body>
</html>