<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	ArrayList vecData = new ArrayList();
	ArrayList vecRow = new ArrayList();
	int vecsize = 0;
	if (hshValues != null) {
		vecData = (ArrayList) hshValues.get("vecData");
	}
	String strMode = Helper.correctNull((String) hshValues.get("mode"));
	String strModule = Helper.correctNull((String) hshValues
			.get("module"));
	if(strModule.equalsIgnoreCase(""))
		strModule = Helper.correctNull((String) request
				.getParameter("prdtype"));
		
%>
<html>
<head>
<title>Terms &amp; Conditions</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>/css/style.css" type="text/css">
<SCRIPT language="javascript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
	<script language="JavaScript1.2" src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script language="javascript">

var appUrl="<%=ApplicationParams.getAppUrl()%>";
var headid = "<%=Helper.correctNull((String) hshValues.get("head"))%>";
var facid = "<%=Helper.correctNull((String) hshValues.get("type"))%>";
var mode1= "<%=strMode%>";
var prepost= "<%=Helper.correctNull((String) hshValues.get("prepost"))%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var module="<%=strModule%>";
var facility_type="<%=Helper.correctNull((String) hshValues
									.get("FacilityCode"))%>";
function whileLoading()
{	
	document.forms[0].termscondition.readOnly=true;
	document.forms[0].sel_Action.disabled=true;
	<%if(strModule.equalsIgnoreCase("R")){%>
		if(module=="R"){
		document.forms[0].doc_module.checked=true;
		}
	<%}else{%>
		if(module=="C"){
			document.forms[0].doc_module[0].checked=true;
			}else if(module=="A"){
			document.forms[0].doc_module[1].checked=true;
			}
	<%}%>
	
if(module=="C"){
		if(mode1=="G")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_mode[0].checked=true;
			document.forms[0].doc_module[0].checked=true;
			
			if(prepost=="pre")
			{
				document.forms[0].disb_mode[0].checked=true;
			}
			else 
			{
				document.forms[0].disb_mode[1].checked=true;
			
			}
			disableFields(true);
		}
		else if(mode1=="S")
		{	
			document.forms[0].sel_Facility.disabled=false;
			document.forms[0].doc_mode[1].checked=true;
			document.forms[0].doc_module[0].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			if(facility_type!=""){
			document.forms[0].sel_Facility.value=facility_type;
			}		
			disableFields(true);
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="P")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module[0].checked=true;
			document.forms[0].doc_mode[2].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="O")
		{
			
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module[0].checked=true;
			document.forms[0].doc_mode[3].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="B")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module[0].checked=true;
			document.forms[0].doc_mode[4].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			disableFields(true);
			enableButtons(true,true,true,true,true,false);
			document.forms[0].prepost.value="";	
		}	
	}
	else if(module=="A"){
			if(mode1=="G")
			{
				document.forms[0].sel_Facility.disabled=true;
				document.forms[0].doc_mode[0].checked=true;
				document.forms[0].doc_module[1].checked=true;
				if(prepost=="pre")
				{
					document.forms[0].disb_mode[0].checked=true;
				}
				else
				{
					document.forms[0].disb_mode[1].checked=true;
				}
			}
			else if(mode1=="S")
			{	
				document.forms[0].sel_Facility.disabled=false;
				document.forms[0].doc_mode[1].checked=true;
				document.forms[0].doc_module[1].checked=true;
				document.forms[0].disb_mode[0].disabled=true;
				document.forms[0].disb_mode[1].disabled=true;
				if(facility_type!=""){
				document.forms[0].sel_Facility.value=facility_type;
				}	
				document.forms[0].prepost.value="";	
			}
			else  if(mode1=="P")
			{
				document.forms[0].sel_Facility.disabled=true;
				document.forms[0].disb_mode[0].disabled=true;
				document.forms[0].disb_mode[1].disabled=true;
				document.forms[0].doc_mode[2].checked=true;
				document.forms[0].doc_module[1].checked=true;	
				document.forms[0].prepost.value="";	
			}
			else  if(mode1=="O")
			{
				document.forms[0].sel_Facility.disabled=true;
				document.forms[0].disb_mode[0].disabled=true;
				document.forms[0].disb_mode[1].disabled=true;
				document.forms[0].doc_mode[3].checked=true;
				document.forms[0].doc_module[1].checked=true;
				document.forms[0].prepost.value="";		
			}
			else  if(mode1=="B")
			{
				document.forms[0].sel_Facility.disabled=true;
				document.forms[0].disb_mode[0].disabled=true;
				document.forms[0].disb_mode[1].disabled=true;
				document.forms[0].doc_mode[4].checked=true;
				document.forms[0].doc_module[1].checked=true;	
				document.forms[0].prepost.value="";	
			}
			else
			{
				document.forms[0].sel_Facility.disabled=true;
				document.forms[0].disb_mode[0].disabled=true;
				document.forms[0].disb_mode[1].disabled=true;
				document.forms[0].doc_mode[2].disabled=false;
				document.forms[0].doc_mode[3].disabled=false;
				document.forms[0].doc_mode[4].disabled=false;
				disableFields(true);
				enableButtons(true,true,true,true,true,false);
				document.forms[0].prepost.value="";	
			}	
	}
	else if(module=="R"){
		if(mode1=="G")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_mode[0].checked=true;
			document.forms[0].doc_module.checked=true;
			
			if(prepost=="pre")
			{
				document.forms[0].disb_mode[0].checked=true;
			}
			else 
			{
				document.forms[0].disb_mode[1].checked=true;
			
			}
			disableFields(true);
		}
		else if(mode1=="S")
		{	
			document.forms[0].sel_Facility.disabled=false;
			document.forms[0].doc_mode[1].checked=true;
			document.forms[0].doc_module.checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			if(facility_type!=""){
			document.forms[0].sel_Facility.value=facility_type;
			}		
			disableFields(true);
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="P")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module.checked=true;
			document.forms[0].doc_mode[2].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="O")
		{
			
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module.checked=true;
			document.forms[0].doc_mode[3].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else if(mode1=="B")
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].doc_module.checked=true;
			document.forms[0].doc_mode[4].checked=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			document.forms[0].prepost.value="";	
		}
		else
		{
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].disb_mode[0].disabled=true;
			document.forms[0].disb_mode[1].disabled=true;
			disableFields(true);
			enableButtons(true,true,true,true,true,false);
			document.forms[0].prepost.value="";	
		}
	}
	else
	{
		document.forms[0].sel_Action.disabled=true;
		document.forms[0].sel_Facility.disabled=true;
		document.forms[0].disb_mode[0].disabled=true;
		document.forms[0].disb_mode[1].disabled=true;
		document.forms[0].doc_mode[0].disabled=true;
		document.forms[0].doc_mode[1].disabled=true;
		document.forms[0].doc_mode[2].disabled=true;
		document.forms[0].doc_mode[3].disabled=true;
		document.forms[0].doc_mode[4].disabled=true;
		disableFields(true);
		enableButtons(true,true,true,true,true,false);
		document.forms[0].prepost.value="";	
	}
	
}


function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;	
	document.forms[0].cmddelete.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;		
}

function disableFields(val)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=val;		  
		}
	}
	document.forms[0].sel_Action.disabled=val;
}

function doCancel()
{
	if(ConfirmMsg(102))
	{				
		document.forms[0].action=appURL+"action/setcomtermscondition.jsp";				
		document.forms[0].submit();		
	}
}

function makeNull()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="textarea")
		{							
			document.forms[0].elements[i].value="";		  
		}
	}
}

function placeValues(termsno,termscond,factype,currParentId,termAction)
{
	document.forms[0].hidParent.value=currParentId;
	document.forms[0].hidSno.value=termsno;
	document.forms[0].hidChild.value="Yes";
	document.forms[0].hidParentSno.value=termsno;
	document.forms[0].sel_Action.value=termAction;
	if(termsno!="")
	{				
		if(document.forms[0].doc_mode[0].checked)
			mode="G";
		else
			mode="S";
		if(mode=="G")
		{
			document.forms[0].sno.value=termsno;
			document.forms[0].termscondition.value=termscond;
			//if(document.forms[0].disb_mode[0].checked)
			//document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&module="+module+"&mode=G&prepost=pre";
			//else
			//document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&module="+module+"&mode=G&prepost=post";
		}
		else
		{
			document.forms[0].sno.value=termsno;
			document.forms[0].termscondition.value=termscond;
			document.forms[0].sel_Facility.value=factype;
			//if(document.forms[0].disb_mode[0].checked)
			//document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&module="+module+"&mode=S&prepost=pre";
			//else
			//document.all.termfrm.src=appUrl+"action/iframetermscondition.jsp?hidBeanId=comtermscondition&termsno="+termsno+"&hidBeanGetMethod=getComTermsConData&toget=place&module="+module+"&mode=S&prepost=post";
		}
	}
	//document.forms[0].sel_Facility.disabled=true;
	enableButtons(true,false,true,false,true,false);	
}


function doNew()
{

	var flag=false;
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		 if((document.forms[0].elements[i].checked)&&(document.forms[0].elements[i].name=="termsel1"))
		{
			flag=true;
			break;
		}
 }
	 if(flag)
	 {
		 alert('You cannot create new terms and condition for this selected terms and condition');
		 
	 }
	 else
	 {
		 if(document.forms[0].doc_mode[0].checked)
			{
				mode="G";
			}
			else if (document.forms[0].doc_mode[1].checked)
			{
				mode="S";
			}
			else if(document.forms[0].doc_mode[2].checked)
			{
				mode="P";
			}
			else if(document.forms[0].doc_mode[3].checked)
			{
				mode="O";
			}
			else if(document.forms[0].doc_mode[4].checked)
			{
				mode="B";
			}

			
			
			
			if(mode=="G")
			{
				makeNull();
				disableFields(false);
				enableButtons(true,true,false,false,true,true);	
				document.forms[0].hidVal.value="insert";
				document.forms[0].mode.value="G";
				<%if(strModule.equalsIgnoreCase("R")){%>
				if(document.forms[0].doc_module.checked)
					document.forms[0].module.value="R";
			<%}else{%>
				if(document.forms[0].doc_module[0].checked)
					document.forms[0].module.value="C";
				else
					document.forms[0].module.value="A";
			<%}%>
				if(document.forms[0].disb_mode[0].checked)
				{
					document.forms[0].prepost.value="pre";
				}
				
				else if(document.forms[0].disb_mode[1].checked)
				{
					document.forms[0].prepost.value="post";
				}
				else
				{
					document.forms[0].prepost.value="";
				}

				
					
				 document.forms[0].termscondition.focus();
			}
			
			else if(mode=="S")
			{		
				if(document.forms[0].sel_Facility.value=="selected" ||document.forms[0].sel_Facility.value=="")
				{
					alert("select Facility");
					document.forms[0].sel_Facility.focus();
					return;
				}
				makeNull();
				disableFields(false);
				enableButtons(true,true,false,false,true,true);	
				document.forms[0].hidVal.value="insert";
				document.forms[0].mode.value="S";
				<%if(strModule.equalsIgnoreCase("R")){%>
				if(document.forms[0].doc_module.checked)
					document.forms[0].module.value="R";
			<%}else{%>
				if(document.forms[0].doc_module[0].checked)
					document.forms[0].module.value="C";
				else
					document.forms[0].module.value="A";
			<%}%>
				if(document.forms[0].disb_mode[0].checked)
					document.forms[0].prepost.value="pre";
				else if(document.forms[0].disb_mode[1].checked)
					document.forms[0].prepost.value="post";
				else
					document.forms[0].prepost.value="";
				document.forms[0].termscondition.focus();
			}


			else if(mode=="P")
			{
				
				makeNull();
				disableFields(false);
				enableButtons(true,true,false,false,true,true);	
				document.forms[0].hidVal.value="insert";
				document.forms[0].mode.value="P";
				if(document.forms[0].doc_module.checked)
				{
					document.forms[0].module.value="C";
					document.forms[0].hid_othertc.value="P";
				}
				document.forms[0].termscondition.focus();
				
			}

			else if(mode=="O")
			{
				
				makeNull();
				disableFields(false);
				enableButtons(true,true,false,false,true,true);	
				document.forms[0].hidVal.value="insert";
				document.forms[0].mode.value="O";
				if(document.forms[0].doc_module.checked)
				{
					document.forms[0].module.value="C";
					document.forms[0].hid_othertc.value="O";
				}
				document.forms[0].termscondition.focus();
				
			}

			else if(mode=="B")
			{
				
				makeNull();
				disableFields(false);
				enableButtons(true,true,false,false,true,true);	
				document.forms[0].hidVal.value="insert";
				document.forms[0].mode.value="B";
				if(document.forms[0].disb_mode[0].checked)
				{
					document.forms[0].module.value="C";
					document.forms[0].hid_othertc.value="B";
				}
				document.forms[0].termscondition.focus();
			
			}

	 }

	 document.forms[0].cmdnew.disabled=true;
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}

function doEdit()
{
	//document.forms[0].sel_Facility.disabled=true;
	var flag=false;
	if(document.forms[0].doc_mode[0].checked)
	{
		mode="G";
	}
	else if(document.forms[0].doc_mode[1].checked)
	{
		mode="S";
	}
	else if(document.forms[0].doc_mode[2].checked)
	{
		mode="P";
	}
	else if(document.forms[0].doc_mode[3].checked)
	{
		mode="O";
	}
	else if(document.forms[0].doc_mode[4].checked)
	{
		mode="B";
	}

	

	
	if(mode=="S")
	{
		if((document.forms[0].sel_Facility.value=="")||(document.forms[0].sel_Facility.value=="selected"))
		{
			
			document.forms[0].sel_Facility.focus();
			return;
		}
	}
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if((document.forms[0].elements[i].checked)&&(document.forms[0].elements[i].name=="termsel"))
		{
			flag=true;
			break;
		}
		else if((document.forms[0].elements[i].checked)&&(document.forms[0].elements[i].name=="termsel1"))
		{
			flag=true;
			break;
		}
	}
	if(flag)
	{
		disableFields(false);
		enableButtons(true,true,false,false,true,true);	
		document.forms[0].hidVal.value ="edit";	
		document.forms[0].termscondition.focus();
	}
	else
	{
		  alert("select terms and condition to edit");
		  //document.forms[0].cmdnew.disabled=false;
	}
	document.forms[0].cmdnew.disabled=false;
}

function doDelete()
{
	var flag=true;
	if(document.forms[0].hidParent.value=="0")
	{
		for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(flag==false)
			{
				break;
			}
			
			if(document.forms[0].elements[i].name=="hidIsContainChild")
			{
				var length=document.forms[0].hidIsContainChild.length;
				
				if(length>0)
				{
					for(var j=0;j<document.forms[0].hidIsContainChild.length;j++)
					{
						if(document.forms[0].hidIsContainChild[j].value==document.forms[0].hidParentSno.value)
						{
							flag=false;
							break;

							
						}
						
					}
					 
				}
				else
				{
					if(document.forms[0].hidIsContainChild.value==document.forms[0].hidParentSno.value)
					{
						flag=false;
						break;
						
					}
				}
				
			}
		}
		
		
	}
 
	if(flag)
	{

		if(document.forms[0].doc_mode[0].checked)
		{
			mode="G";
		}
		else if(document.forms[0].doc_mode[1].checked)
		{
			mode="S";
		}
		else if(document.forms[0].doc_mode[2].checked)
		{
			mode="P";
		}
		else if(document.forms[0].doc_mode[3].checked)
		{
			mode="O";
		}
		else if(document.forms[0].doc_mode[4].checked)
		{
			mode="B";
		}
		

		if(mode=="S")
		{
			document.forms[0].mode.value="S";
		}
		else if(mode=="G")
		{
			document.forms[0].mode.value="G";
		}

		else if(mode=="P")
		{
			document.forms[0].mode.value="P";
		}
		else if(mode=="O")
		{
				document.forms[0].mode.value="O";
		}
		else if(mode=="B")
		{
			document.forms[0].mode.value="B";
		}

		
        
		
		if(document.forms[0].doc_module[0].checked)
		{
			document.forms[0].module.value="C";
		}
		else
		{
			document.forms[0].module.value="A";
		}

		if(document.forms[0].disb_mode[0].checked)
		{
			document.forms[0].prepost.value="pre";
		}
		else if(document.forms[0].disb_mode[1].checked)
		{
			document.forms[0].prepost.value="post";
		}
		else
		{
			document.forms[0].prepost.value="";
		}


		if(ConfirmMsg(101))
		{		
			document.forms[0].hidVal.value ="delete";	
			document.forms[0].hidBeanGetMethod.value="UpdateComTermsConData";
			document.forms[0].hidBeanId.value="comtermscondition";
			document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
			document.forms[0].submit();	
		}
	
	}
	else
	{
		alert("You cannot delete the terms and conditions");
		return;
		
	}

}

function doSave()
{
	if(document.forms[0].sel_Action.value=="")
	{
		alert("Select Action");
		return;
	}
	if(checktrim(document.forms[0].termscondition.value)=="")
	{
		  ShowAlert(111,'conditions');
		  document.forms[0].termscondition.focus();
	}
	else
	{
	
		if(document.forms[0].doc_mode[0].checked)
		{
			mode="G";
			document.forms[0].mode.value="G";
		}
		else if(document.forms[0].doc_mode[1].checked)
		{
			mode="S";
			document.forms[0].mode.value="S";
		}
		else if(document.forms[0].doc_mode[2].checked)
		{
			mode="P"; 
			document.forms[0].mode.value="P";
		}
		else if(document.forms[0].doc_mode[3].checked)
		{
			mode="O";
			document.forms[0].mode.value="O";
		}
		else if(document.forms[0].doc_mode[4].checked)
		{
			mode="B";
			 document.forms[0].mode.value="B"; 
		}

	if((document.forms[0].disb_mode[0].checked)||(document.forms[0].disb_mode[1].checked))
	{
			if(document.forms[0].disb_mode[0].checked)
				document.forms[0].prepost.value="pre";
			else if(document.forms[0].disb_mode[1].checked)
				document.forms[0].prepost.value="post";
			
	}
	else
	 document.forms[0].prepost.value="";
	 
		<%if(strModule.equalsIgnoreCase("R")){%>
		if(document.forms[0].doc_module.checked)
			document.forms[0].module.value="R";
	<%}else{%>
		if(document.forms[0].doc_module[0].checked)
			document.forms[0].module.value="C";
		else
			document.forms[0].module.value="A";
	<%}%>
		document.forms[0].cmdsave.disabled = true;
		document.forms[0].hidBeanGetMethod.value="UpdateComTermsConData";
		document.forms[0].hidBeanId.value="comtermscondition";
		document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
		document.forms[0].submit();
		
	}
}

function cancelradio()
{
		document.forms[0].disb_mode[0].checked=false;
		document.forms[0].disb_mode[1].checked=false;
}

 function callMode()
 {	 	 
		var mode;
		if(document.forms[0].doc_mode[0].checked)
		{
		mode="G";
		}
		else if(document.forms[0].doc_mode[1].checked)
		{
		mode="S";	
		}
	    if(mode=="G")
	 	{		
		 	
			document.forms[0].sel_Facility.disabled=true;
			document.forms[0].disb_mode[0].disabled=false;
			document.forms[0].disb_mode[1].disabled=false;			
			if(document.forms[0].disb_mode[0].checked || document.forms[0].disb_mode[1].checked)
			{
				disableFields(true);
				enableButtons(false,false,true,true,true,false);
				document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";	
				document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
				document.forms[0].mode.value="G";
				<%if(strModule.equalsIgnoreCase("R")){%>
					if(document.forms[0].doc_module.checked)
						document.forms[0].module.value="R";
				<%}else{%>
					if(document.forms[0].doc_module[0].checked)
						document.forms[0].module.value="C";
					else
						document.forms[0].module.value="A";
				<%}%>
				if(document.forms[0].disb_mode[0].checked)
					document.forms[0].prepost.value="pre";
				else if(document.forms[0].disb_mode[1].checked)
					document.forms[0].prepost.value="post";
				else
					document.forms[0].prepost.value="";
				document.forms[0].submit();
		}else{
				enableButtons(true,true,true,true,true,false);
			}
		 }
		 
		 else if(mode=="S")
		 {
			
			 document.forms[0].disb_mode[0].disabled=true;
			 document.forms[0].disb_mode[1].disabled=true;
			 document.forms[0].sel_Facility.disabled=false;
			 enableButtons(false,false,true,true,true,false);
			 document.forms[0].mode.value="S";
			 <%if(strModule.equalsIgnoreCase("R")){%>
				if(document.forms[0].doc_module.checked)
					document.forms[0].module.value="R";
			<%}else{%>
				if(document.forms[0].doc_module[0].checked)
					document.forms[0].module.value="C";
				else
					document.forms[0].module.value="A";
			<%}%>
		 }
 }
 function callModule()
 {	 
		var module;
		var mode;

		<%if(strModule.equalsIgnoreCase("R")){%>
			if(document.forms[0].doc_module.checked)
			{
				module="R";
				document.forms[0].module.value="R";
			}
		<%}else{%>
			if(document.forms[0].doc_module[0].checked)
			{
				module="C";
				document.forms[0].module.value="C";
			}
			else if (document.forms[0].doc_module[1].checked)
			{			 
				module="A";	
				document.forms[0].module.value="A";
			}
		<%}%>

		if(document.forms[0].doc_mode[0].checked)
		{
			mode="G";
		}
		else if(document.forms[0].doc_mode[1].checked)
		{
			mode="S";
		}
		 if(document.forms[0].doc_mode[2].checked)
		{
				mode="G";
		}
		else if(document.forms[0].doc_mode[3].checked)
		{
			mode="S";
		}
		if(document.forms[0].doc_mode[4].checked)
		{
			mode="G";
		}

		document.forms[0].doc_mode[0].disabled=false;
		document.forms[0].doc_mode[1].disabled=false;
     	document.forms[0].sel_Facility.disabled=false;
		disableFields(true);
		enableButtons(true,true,true,true,true,false);
		document.forms[0].hidBeanGetMethod.value="getComTermsConData";
		document.forms[0].hidBeanId.value="comtermscondition";	
		document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	

		if(document.forms[0].doc_mode[0].checked)
		{
			if(document.forms[0].disb_mode[0].checked)
			{
				document.forms[0].prepost.value="pre";
			}
			else if(document.forms[0].disb_mode[1].checked)
			{
				document.forms[0].prepost.value="post";
			}
		}else
		{
			document.forms[0].prepost.value="";
		}
		document.forms[0].submit();
				
}

//Help function
function dohlp()     
{
  var hlpvar = appUrl+"phlp/setup_corpprod_termsandconditions.html";
  var title = "TermsAndConditions";
  var prop = "scrollbars=yes,width=600,height=450";	
  prop = prop + ",left=50,top=150";
  window.open(hlpvar,title,prop);
}

function changeFacilityTermsAndConditions()
{
	
	if(document.forms[0].doc_mode[0].checked)
		mode="G";
	else
		mode="S";
	<%if(strModule.equalsIgnoreCase("R")){%>
	if(document.forms[0].doc_module.checked)
		module="R";
	<%}else{%>
	if(document.forms[0].doc_module[0].checked)
		module="C";
	else
		module="A";
	<%}%>
	/*if(document.forms[0].doc_module[0].checked)
		module="C";
		else if(document.forms[0].doc_module[1].checked)
		module="A";*/
	if(mode=="S")
	{
		if(document.forms[0].sel_Facility.value=="selected")
		{
			alert("select Facility");
			document.forms[0].sel_Facility.focus();
			return;
		}
	}
	var facility=document.forms[0].sel_Facility.value;
	//if(document.forms[0].disb_mode[0].checked)
	//	document.all.selectfacilityfrm.src=appUrl+"action/iframetermscondition_facilitybased.jsp?hidBeanId=comtermscondition&hidBeanGetMethod=getComTermsConData&module="+module+"&mode=S&prepost=pre&sel_Facility="+facility;
	//else
	//	document.all.selectfacilityfrm.src=appUrl+"action/iframetermscondition_facilitybased.jsp?hidBeanId=comtermscondition&hidBeanGetMethod=getComTermsConData&module="+module+"&mode=S&prepost=post&sel_Facility="+facility;
	document.forms[0].hidBeanGetMethod.value="getComTermsConData";
	document.forms[0].hidBeanId.value="comtermscondition";	
	document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
	document.forms[0].mode.value="S";
	 <%if(strModule.equalsIgnoreCase("R")){%>
		if(document.forms[0].doc_module.checked)
			document.forms[0].module.value="R";
	<%}else{%>
		if(document.forms[0].doc_module[0].checked)
			document.forms[0].module.value="C";
		else
			document.forms[0].module.value="A";
	<%}%>
	/*if(document.forms[0].disb_mode[0].checked)
		document.forms[0].prepost.value="pre";
	else
		document.forms[0].prepost.value="post";*/
	disableFields(true);
	document.forms[0].submit();
		
}

function callModeotehr()
{
	
	var module;
	var mode;
	<%if(strModule.equalsIgnoreCase("R")){%>
	if(document.forms[0].doc_module.checked)
		module="R";
	<%}else{%>
	if(document.forms[0].doc_module[0].checked)
		module="C";
	else if(document.forms[0].doc_module[1].checked)
		module="A";
	<%}%>
	if(document.forms[0].doc_mode[2].checked)
	{
		mode="P";
	}
	else if(document.forms[0].doc_mode[3].checked)
	{
		mode="O";
	}
	else if(document.forms[0].doc_mode[4].checked)
	{
		mode="B";
	}
	if(mode=="O")
	{		
		 	document.forms[0].sel_Facility.disabled=true;
				disableFields(true);
				enableButtons(false,false,true,true,true,false);
				document.forms[0].hidBeanGetMethod.value="getComTermsConData";
				document.forms[0].hidBeanId.value="comtermscondition";	
				document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
				
				document.forms[0].mode.value="O";
				 <%if(strModule.equalsIgnoreCase("R")){%>
					if(document.forms[0].doc_module.checked)
						document.forms[0].module.value="R";
				<%}else{%>
					if(document.forms[0].doc_module[0].checked)
						document.forms[0].module.value="C";
					else
						document.forms[0].module.value="A";
				<%}%>
			
				if(document.forms[0].doc_mode[2].checked)
				{
					document.forms[0].hid_spec.value="P";
				}
				
				else if(document.forms[0].doc_mode[3].checked)
				{
					document.forms[0].hid_othertc.value="O";
				}
				else if(document.forms[0].doc_mode[4].checked)
				{
					document.forms[0].hid_iBranch.value="B";
				}
				document.forms[0].submit();
	}
	 else if(mode=="B")
	 { 	 	
				document.forms[0].sel_Facility.disabled=true;
				
					disableFields(true);
					enableButtons(false,false,true,true,true,false);
					document.forms[0].hidBeanGetMethod.value="getComTermsConData";
					document.forms[0].hidBeanId.value="comtermscondition";	
					document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
					
					document.forms[0].mode.value="B";
					 <%if(strModule.equalsIgnoreCase("R")){%>
						if(document.forms[0].doc_module.checked)
							document.forms[0].module.value="R";
					<%}else{%>
						if(document.forms[0].doc_module[0].checked)
							document.forms[0].module.value="C";
						else
							document.forms[0].module.value="A";
					<%}%>

					 if(document.forms[0].doc_mode[2].checked)
					{
						document.forms[0].hid_spec.value="P";
					}

					 else if (document.forms[0].doc_mode[3].checked)
						{
							document.forms[0].hid_othertc.value="O";
						}
					else if(document.forms[0].doc_mode[4].checked)
					{
						document.forms[0].hid_iBranch.value="B";
					}
					
					document.forms[0].submit();
		}
		 else if(mode=="P")
		 { 	 	
				document.forms[0].sel_Facility.disabled=true;
					disableFields(true);
					enableButtons(false,false,true,true,true,false);
					document.forms[0].hidBeanGetMethod.value="getComTermsConData";
					document.forms[0].hidBeanId.value="comtermscondition";	
					document.forms[0].action=appURL+"action/setcomtermscondition.jsp";	
					
					document.forms[0].mode.value="P";
					 <%if(strModule.equalsIgnoreCase("R")){%>
						if(document.forms[0].doc_module.checked)
							document.forms[0].module.value="R";
					<%}else{%>
						if(document.forms[0].doc_module[0].checked)
							document.forms[0].module.value="C";
						else
							document.forms[0].module.value="A";
					<%}%>
				
					if(document.forms[0].doc_mode[2].checked)
					{
						document.forms[0].hid_spec.value="P";
					}
					else if(document.forms[0].doc_mode[3].checked)
					{
						document.forms[0].hid_othertc.value="O";
											
					}
					else if(document.forms[0].doc_mode[4].checked)
					{
						document.forms[0].hid_iBranch.value="B";
						
					}
					document.forms[0].submit();
		}
		 
}

</script>

</head>
<body onload="javascript:whileLoading()">
<style type="text/css">
DIV.cellContainer {	
  width: 100%; height: 130;
  overflow: auto;
}
DIV.cellContainer2 {	
  width: 100%; height: 200;
  overflow: auto;
}
</style>
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

<form name="facility" method="post" class="normal"><iframe
	height="0" width="0" id="termfrm" frameborder=0 style="border: 0"></iframe>
<iframe height="0" width="0" id="ifrm1" frameborder=0 style="border: 0"></iframe>
<table class="outertable" width="100%" border="0" cellspacing="0"
	cellpadding="0">
	<tr>
		<td>
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="0">
			<tr>
			<%if (strModule.equalsIgnoreCase("R")) {%>
				<td class="page_flow">Home -&gt; Setup -&gt; Retail Products
				-&gt; Terms & Conditions</td>
				<%}else{ %>
				<td class="page_flow">Home -&gt; Setup -&gt; Corporate  & Agriculture Products
				-&gt; Terms & Conditions</td>
				<%} %>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<table class="outertable border1 tableBg" width="98%" border="0" cellspacing="0"
	align="center" cellpadding="5">
	<tr>
		<td valign="top">
		<table class="outertable" width="100%" border="0" cellspacing="0"
			cellpadding="5" align="center">
			<tr>
				<td>
				<table class="outertable" width="90%" border="0" cellspacing="0"
					cellpadding="3" align="center">

					<%if (strModule.equalsIgnoreCase("R")) {%>
					<tr>
						<td colspan="2"><input type="radio" name="doc_module"
							style="border-style: none" value="R"
							onClick="cancelradio();callModule();" disabled="disabled" checked="checked"> Retail</td>
						<td colspan="2">&nbsp;</td>
					</tr>
					<%}else{ %>
					<tr>
						<td colspan="2"><input type="radio" name="doc_module"
							style="border-style: none" value="C"
							onClick="cancelradio();callModule();"> Corporate</td>
						<td colspan="2"><input type="radio" name="doc_module"
							style="border-style: none" value="A"
							onClick="cancelradio();callModule();"> Agriculture</td>
					</tr>
					<%} %>
					<tr>
						<td nowrap="nowrap"><input type="radio" name="doc_mode"
							style="border-style: none" value="G"
							onClick="cancelradio();callMode();"> General Terms &amp;
						Conditions</td>
						
						<%if (strModule.equalsIgnoreCase("R")) {%>
						<td nowrap="nowrap" style="display: none;"><input type="radio" name="doc_mode"  onClick="cancelradio();callModeotehr();"style="border-style: none"  value="S"> &nbsp;</td>
						<td nowrap="nowrap"><input type="radio" name="doc_mode"  onClick="cancelradio();callModeotehr();"style="border-style: none"  value="P"> Specific &amp; Conditions</td>
						<%}else{ %>
						<td nowrap="nowrap"><input type="radio" name="doc_mode"
							style="border-style: none" value="S"
							onClick="cancelradio();callMode();"> Facility Based Terms &amp; Conditions</td>
							<td nowrap="nowrap"><input type="radio" name="doc_mode"  onClick="cancelradio();callModeotehr();"style="border-style: none"  value="P"> Specific &amp; Conditions</td>
						<%} %>
						
						
						<td nowrap="nowrap"><input type="radio" name="doc_mode"
							style="border-style: none" onClick="cancelradio();callModeotehr();" value="O"> Other Terms &amp; Conditions</td>
						<td nowrap="nowrap"><input type="radio" name="doc_mode"
							style="border-style: none" onClick="cancelradio();callModeotehr();" value="B"> Instructions to the Branch</td>
						
						
						
					</tr>
					<tr>
						<td align="center" ><input type="radio"
							name="disb_mode" style="border-style: none" value="pre"
							onClick="callMode()"> PreDisbursement</td>

						<td align="center" ><input type="radio"
							name="disb_mode" style="border-style: none" value="post"
							onClick="callMode()"> PostDisbursement</td>
							

					</tr>
					
				
					<%if (!strModule.equalsIgnoreCase("R")) {%>
					<tr>
						<td width="20%" align="">Select Facility</td>
						<td align="" colspan="2" id="id_FacilitySel"><select
							name="sel_Facility"
							onchange="javascript:changeFacilityTermsAndConditions()"
							tabindex="7">
							<option value="" selected="selected">---Select---</option>
							<%
								if (strModule.equalsIgnoreCase("C")) {
							%>
							<lapschoice:FacilitiesTag moduletype="c" />
							<%
								} else if (strModule.equalsIgnoreCase("A")) {
							%>
							<lapschoice:FacilitiesTag moduletype="a" />
							<%
								} else {
							%>
							<lapschoice:FacilitiesTag moduletype="" />
							<%
								}
							%>

						</select></td>
					</tr>
					<%}else{ %>
					<input type="hidden" name="sel_Facility">
					<%} %>
					
					 <tr>
                     <td>Action<span class="mantatory">*</span></td>
                     <td><select name="sel_Action">
                     <option value="">--Select--</option>
                     <option value="E">Enabled</option>
                     <option value="D">Disabled</option></select></td>
                     </tr>
                     
					<tr>
						<td colspan="4">&nbsp;</td>
					</tr>
					<tr>
						<td colspan="4" align="center"><textarea
							name="termscondition" cols="140" wrap="VIRTUAL" rows="5" onKeyPress="notAllowSingleQuote();NoallowEnterandDoubleQuote(); textlimit(this,3999)" onKeyUp="textlimit(this,3999)"></textarea>
						</td>
					</tr>
				</table>
				<br>
				<table class="outertable" width="100%" border="0" cellspacing="0"
					cellpadding="0" height="100%">
					<tr>
						<td valign="top"><lapschoice:combuttonnew
							btnnames="New_Edit_Save_Cancel_Delete"
							btnenable='<%=Helper.correctNull((String) request
							.getParameter("btnenable"))%>' />
						</td>
					</tr>
					<tr>
						<td valign="top">&nbsp;</td>
					</tr>

					<tr class="dataheader">
						<%
							if ((vecData != null) && (vecData.size() != 0)) {
						%>
						<td colspan=2 align="center" height="20">TERMS &amp;
						CONDITIONS</td>
						<td align="center">Action</td>
					</TR>
					<%
						String prevSno="";
						String currParentId="";
						vecsize = vecData.size();

							String termsno = "";
							boolean booflag=true;
							boolean childflag=true;

							for (int i = 0; i < vecsize; i++) {
								vecRow = (ArrayList) vecData.get(i);

								if (vecRow != null) {

									termsno = Helper.correctNull((String) vecRow.get(0));
									currParentId=Helper.correctNull((String) vecRow.get(3));
									if(currParentId.equalsIgnoreCase("0") && childflag==true )
									{
										booflag=true;
									}
									if(booflag)
									{
										prevSno=Helper.correctNull((String) vecRow.get(0));
										booflag=false;
									}
									
					%>
					<table class="outertable" width="100%" border="0" cellspacing="1"
						cellpadding="2">
						
						<%
						
						
						if(currParentId.equalsIgnoreCase("0"))
						{
							childflag=true;
						%>
						<tr class="datagrid">
							<td width="5%"><input type="radio" name="termsel"
								value="radiobutton" style="border-style: none"
								onClick="placeValues('<%=termsno%>','<%=Helper.correctNull((String) vecRow
										.get(1))%>','<%=Helper.correctNull((String) vecRow
										.get(2))%>','<%=currParentId%>','<%=Helper.correctNull((String) vecRow
										.get(4))%>')"></td>
										
										
							<td width="85%"><%=Helper.correctNull((String) vecRow
										.get(1))%></td>
							<td width="10%">
							
							<%String strEnable=Helper.correctNull((String) vecRow.get(4));
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
							<%=strEnable %>&nbsp;</td>
							

						</tr>
						
						<%} %>
						
						<% 
						if(prevSno.equalsIgnoreCase(currParentId) && (!currParentId.equalsIgnoreCase("0")))
						{
							
						%>
							
							<tr class="datagrid">
							<td width="5%">&nbsp;</td>
							<td width="85%"><input type="radio" name="termsel1" value="radiobutton" style="border-style: none"
								onClick="placeValues('<%=termsno%>','<%=Helper.correctNull((String) vecRow
										.get(1))%>','<%=Helper.correctNull((String) vecRow
										.get(2))%>','<%=currParentId %>','<%=Helper.correctNull((String) vecRow
										.get(4))%>')"> 
							<%=Helper.correctNull((String) vecRow
										.get(1))%></td>
							<td width="10%">
							
							<%String strEnable=Helper.correctNull((String) vecRow.get(4));
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
							<%=strEnable %>&nbsp;</td>
					<input type="hidden" name="hidIsContainChild" value="<%=Helper.correctInt((String)vecRow.get(3))%>" >										
						</tr>
							
						<%} %>
						
					</table>
					<%
						}
							}
						}
					%>

				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:hiddentag pageid='<%=PageId%>' /> <input type="hidden"
	name="hidVal"> <input type="hidden" name="sno"> <input
	type="hidden" name="mode"> <input type="hidden" name="prdtype"
	value="<%=strModule%>"> <input type="hidden" name="prepost">
<input type="hidden" name="module">
<input type="hidden" name="hidSno" value="">
<input type="hidden" name="hidChild" value="">
<input type="hidden" name="hidParent" value="">
<input type="hidden" name="hidParentSno" value="">
<input type="hidden" name="hid_othertc">
<input type="hidden" name="hid_iBranch">
<input type="hidden" name="hid_spec">
</form>
 
</body>
</html>
