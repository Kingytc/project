    <%@include file="../share/directives.jsp"%>
    <%
    ArrayList arrRow=new ArrayList();
	ArrayList arrCol=new ArrayList();

    String appno=Helper.correctNull((String)request.getParameter("appno"));
   
    if(hshValues!=null)
    {	
    	arrRow = (ArrayList)hshValues.get("arrRow");
    }
    %>

   
<html>
<head>
<title>Check List Documents</title>
<script type="text/javascript">
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currentDate="<%=Helper.getCurrentDateTime()%>";
var fac= "<%=Helper.correctNull((String)hshValues.get("FACILITY_SNO"))%>";
var varCheckList= "<%=Helper.correctNull((String)hshValues.get("strCheckList_Check"))%>";

function onload()
{
	window.opener.document.forms[0].hidChecklist.value=varCheckList;
	if(fac!="")
	{
		document.forms[0].sel_facility.value=fac;
	}
	else
	{
		document.forms[0].cmdedit.disabled=true;
	}
	disableFields(true);
	document.forms[0].sel_facility.disabled=false;

	<% if( arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
		arrCol=(ArrayList)arrRow.get(i);
		if(arrRow.size()==1){%>
		document.forms[0].selAction.value="<%=Helper.correctNull((String)arrCol.get(3))%>";
		<%}else{%>
		document.forms[0].selAction[<%=i%>].value="<%=Helper.correctNull((String)arrCol.get(3))%>";
		
		<%}}
	}%>
	
}
function selvalues(obj)
{
	<% if( arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrRow.size()==1)
			{%>
			
				if(document.forms[0].selAction.value=="N")
				{
					document.forms[0].txt_reason.readOnly=false;
					document.all.idcal.style.display="inline";
				}
				else
				{
					document.forms[0].txt_reason.readOnly=true;
					document.all.idcal.style.display="none";
					document.forms[0].txt_reason.value="";
					document.forms[0].txt_expdate.value="";
				}
			<%}else{%>
			
				if(document.forms[0].selAction[<%=i%>]==obj)
				{
					if(document.forms[0].selAction[<%=i%>].value=="N")
					{
						document.forms[0].txt_reason[<%=i%>].readOnly=false;
						document.all.idcal[<%=i%>].style.display="inline";
					}
					else
					{
						document.forms[0].txt_reason[<%=i%>].readOnly=true;
						document.all.idcal[<%=i%>].style.display="none";
						document.forms[0].txt_reason[<%=i%>].value="";
						document.forms[0].txt_expdate[<%=i%>].value="";
					}
				}
			<%}
		}
	}%>
}

function doClose()
{
	
   if(ConfirmMsg(100))
	 {

		var subno=0;

		var factype = window.opener.document.forms[0].factype.value;
		var hidAction = window.opener.document.forms[0].hidAction.value;
		{
			window.opener.document.forms[0].hideditflag.value="no";
			if(!isNaN(window.opener.document.forms[0].selsubsno.value))
			{
				 subno = parseInt(window.opener.document.forms[0].selsubsno.value);
			}
			if(!subno)
			{
				subno=0;
			}
			if((subno==0) && (factype="sublimit") && (hidAction =="update"))
			{
				window.opener.document.forms[0].factype.value = "facility";
			}
			window.opener.document.forms[0].hidBeanId.value="facilities";
			window.opener.document.forms[0].hidBeanGetMethod.value="getFacilityData";
			window.opener.document.forms[0].action=appURL+"action/facilities.jsp";	
			window.opener.document.forms[0].method="post";
			window.opener.document.forms[0].submit();
		}
		window.close();
	 }
  
}
function doSave()
{

	<% if( arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrRow.size()==1)
			{%>
			
				if(document.forms[0].selAction.value=="")
				{
					alert("Select Action");
					document.forms[0].selAction.focus();
					return;
				}
				else if(document.forms[0].selAction.value=="N")
				{
					if(document.forms[0].txt_reason.value=="")
					{
						alert("Enter Reason");
						document.forms[0].txt_reason.focus();
						return;
					}
					else if(document.forms[0].txt_expdate.value=="")
					{
						alert("Select Expected Date");
						document.forms[0].txt_expdate.focus();
						return;
					}
				}
			<%}else{%>
			
			if(document.forms[0].selAction[<%=i%>].value=="")
			{
				alert("Select Action");
				document.forms[0].selAction[<%=i%>].focus();
				return;
			}
			else if(document.forms[0].selAction[<%=i%>].value=="N")
			{
				if(document.forms[0].txt_reason[<%=i%>].value=="")
				{
					alert("Enter Reason");
					document.forms[0].txt_reason[<%=i%>].focus();
					return;
				}
				else if(document.forms[0].txt_expdate[<%=i%>].value=="")
				{
					alert("Select Expected Date");
					document.forms[0].txt_expdate.focus();
					return;
				}
			}
			<%}
		}
	}%>
	
	document.forms[0].hidAction.value="update";
	document.forms[0].sel_facility.disabled=false;
	document.forms[0].hidBeanGetMethod.value="getCheckListValue";
	document.forms[0].hidBeanMethod.value="updateCheckListValue";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_CheckListDOC.jsp";
	document.forms[0].submit();
}
function doEdit()
{
	disableFields(false);
	document.forms[0].sel_facility.disabled=true;
	enableButtons(true,false,false,false,true);
	
	<% if( arrRow!=null && arrRow.size()>0)
	{
		for(int i=0;i<arrRow.size();i++)
		{
			arrCol=(ArrayList)arrRow.get(i);
			if(arrRow.size()==1)
			{%>
			
				if(document.forms[0].selAction.value!="N")
				{
					document.forms[0].txt_reason.readOnly=true;
					document.all.idcal.style.display="none";
				}
			<%}else{%>
				if(document.forms[0].selAction[<%=i%>].value!="N")
				{
					document.forms[0].txt_reason[<%=i%>].readOnly=true;
					document.all.idcal[<%=i%>].style.display="none";
				}
			<%}
		}
	}%>
	
}
function doDelete()
{
	document.forms[0].hidAction.value="delete";
	document.forms[0].sel_facility.disabled=false;
	document.forms[0].hidBeanGetMethod.value="getCheckListValue";
	document.forms[0].hidBeanMethod.value="updateCheckListValue";
	document.forms[0].hidBeanId.value="facilities";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/com_CheckListDOC.jsp";
	document.forms[0].submit();
}

function selfacility()
{		
	document.forms[0].action=appURL+"action/com_CheckListDOC.jsp?hidBeanId=facilities&hidBeanGetMethod=getCheckListValue";
	document.forms[0].submit();
}

function disableFields(val)
{
	  for(var i=0;i<document.forms[0].length;i++)
	  {
		  if(document.forms[0].elements[i].type=='text'  )
		  {
			document.forms[0].elements[i].readOnly=true;
		  }
		  if(document.forms[0].elements[i].type=='textarea'  )
		  {
			document.forms[0].elements[i].readOnly=val;
		  }
		  if(document.forms[0].elements[i].type=='select-one' )
		  {
				document.forms[0].elements[i].disabled=val;
		  }
	  }
}
function enableButtons(bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;

}
function doCancel()
{
	if(ConfirmMsg(102))
	 {
		document.forms[0].sel_facility.disabled=false;
		document.forms[0].hidBeanId.value="facilities"
		document.forms[0].hidBeanGetMethod.value="getCheckListValue";
		document.forms[0].action=appURL+"action/com_CheckListDOC.jsp";
		document.forms[0].submit();
	 }
}
function callCalender_mul(name,obj) 
{
	var tab  = document.getElementById("idtab");
	var rowsLength = tab.rows.length;
	if(rowsLength==2)
	{
		if (document.forms[0].cmdsave.disabled == false) {

			showCal(appURL, name);
		}
	}
	else
	{
		for(var i=0;i<document.all.idcal.length;i++)
		{
			if(obj==document.all.idcal[i])
			{
				name="txt_expdate["+(i)+"]";
			}
		}
		if (document.forms[0].cmdsave.disabled == false) 
		{
			showCal(appURL, name);
		}
	}
}
</script>
</head>
<body onload="onload();">
<form method="post"  class="normal">
<lapschoice:application/>
<table width="100%" border="0" cellspacing="0" cellpadding="10" class="outertable border1" align="center">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="5"
			align="center" class="outertable">
				<tr class="dataheader"> 
                      <td width="100%" align="center"><b>Check List Document</b></td>
                      </tr>
				<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
                      
                <tr>
				<td>
				Facility &nbsp;<select name="sel_facility"  onchange="selfacility()">
				<option value="" selected>--Select--</option>
				<%
					String parent=appno;
				%>
				<lapschoice:ComMisDetailsTag apptype='<%= parent%>' />
				</select>
				</td>
				</tr>
				</table>
				<table width="100%" border="0" cellspacing="0" cellpadding="3"
			align="center" class="outertable" id="idtab">
			<tr class="dataheader">
			<td align="center">Documents</td>
			<td align="center">Documents Collected</td>
			<td align="center">Reason</td>
			<td align="center">Expected Date</td>
			</tr>
			<% if( arrRow!=null && arrRow.size()>0)
			{
			for(int i=0;i<arrRow.size();i++)
			{			
			arrCol = (ArrayList)arrRow.get(i);
			
				if(arrCol!=null)
				{ %>
				<tr class="datagrid" align="center">
				<td width="30%" align="left">&nbsp;&nbsp;<%=Helper.correctNull((String)arrCol.get(2))%>
				<input type="hidden" name="hid_ruleno" value="<%=Helper.correctNull((String)arrCol.get(1))%>">
				<input type="hidden" name="hid_schemeid" value="<%=Helper.correctNull((String)arrCol.get(0))%>">
				</td>
				<td width="15%"><select  name="selAction" onChange="selvalues(this);">
				<option value="">--Select--</option>
				<option value="Y">Yes</option>
				<option value="N">No</option>
				<option value="NA">Not Applicable</option>
				</select>
				</td>
				
				<td  width="15%">
				<textarea rows="2" cols="20" name="txt_reason" onkeypress="checkTextArealimit(this,499)" onKeyUp="textlimit(this,499)"><%=Helper.correctNull((String)arrCol.get(4))%></textarea>
				</td>
				
				
				<td width="10%"><input type="text" name="txt_expdate"
					value="<%=Helper.correctNull((String)arrCol.get(5))%>" onBlur="checkDate(this);checkmindate(this,currentDate)" size="10">
                             <b>&nbsp;</b>

						<a alt="Select date from calender" href="#" id="idcal"
									onClick="callCalender_mul('txt_expdate',this);"
									onMouseOver="window.status='Date Picker';return true;"
									onMouseOut="window.status='';return true;"><img
									src="<%=ApplicationParams.getAppUrl()%>img/calen.gif" border=0
									alt="Select date from calender" ></a></td>
					</tr>
				
				<%}}}%>
			</table>
				</td>
				</tr>
				</table>
				
			</td>
		</tr>
	</table>
	<lapschoice:combuttonnew
	btnnames='Edit_Save_Delete_Cancel'
	btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
	
	
		
<lapschoice:hiddentag pageid='<%=PageId%>' />


</form>
 </body>
</html>