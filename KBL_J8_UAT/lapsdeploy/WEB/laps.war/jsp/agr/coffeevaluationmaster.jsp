<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
	hshValues = (java.util.HashMap) objValues;
}
ArrayList vecData = new ArrayList();
ArrayList vecRow = new ArrayList();
int vecsize = 0;
if (hshValues != null) {
	vecData = (ArrayList) hshValues.get("vecData");
}
String str="",str1="";
java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
nf.setGroupingUsed(false);%>
<html>
<head>
<title>Finance Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<SCRIPT language="javascript" src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var currdate = "<%=Helper.getCurrentDateTime()%>";
var mode ="load";
var sel_coffeeplant = "<%=Helper.correctNull((String)hshValues.get("sel_coffeeplant"))%>";
var sel_type= "<%=Helper.correctNull((String)hshValues.get("sel_type"))%>";
var txt_value= "<%=Helper.correctNull((String)hshValues.get("txt_value"))%>";
var txt_valdate="<%=Helper.correctNull((String)hshValues.get("txt_valdate"))%>";
var selsno="<%=Helper.correctNull((String)hshValues.get("selsno"))%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function selectValues(val1, val2, val3, val4,val5)
{
	varRecordFlag="Y";
	document.forms[0].hidsno.value = val1;	
    document.forms[0].sel_coffeeplant.value = val2;
	if(val2!="")
	{
		document.forms[0].sel_coffeeplant.value=val2;		
	}
	document.forms[0].sel_type.value = val3;
	if(val3!="")
	{
		document.forms[0].sel_type.value=val3;
	}	
	document.forms[0].txt_value.value = val4;
	document.forms[0].txt_valdate.value = val5;	
	enableButtons(true, false, true, false, false, true);
}

function ClearFields()
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			  document.forms[0].elements[i].value="";		  
		}		
		else if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].value="";		  
		}
	}
}

function disableFields(one)
{
	for(var i=0;i<document.forms[0].length;i++)
	{
		if(document.forms[0].elements[i].type=='text')
		{
			document.forms[0].elements[i].readOnly=one;
		}	  
		if(document.forms[0].elements[i].type=='select-one')
		{
			document.forms[0].elements[i].disabled=one;
		}
		if(document.forms[0].elements[i].type=="textarea")
		{
			document.forms[0].elements[i].readOnly=one;		  
		}		
	}
}

function doSave()
{	 	
	
	document.forms[0].sel_coffeeplant.disabled=false;
	document.forms[0].sel_type.disabled=false;	
	if(document.forms[0].sel_coffeeplant.value=="s")
	{
		alert("Please select Type of Coffee Crop");
		document.forms[0].sel_coffeeplant.focus();
		return;
	}
	if(document.forms[0].sel_type.value=="s")
	{
		alert("Please select Type");
		document.forms[0].sel_type.focus();
		return;
	}	
	if(document.forms[0].txt_value.value=="" || eval(document.forms[0].txt_value.value)==0)
	{
		alert("Value / Tonne cannot be empty or zero");
		document.forms[0].txt_value.focus();
		return;
	}
	if(document.forms[0].txt_valdate.value=="")
	{
		alert("Valid Upto cannot be empty");
		document.forms[0].txt_valdate.focus();
		return;
	}	
	if(document.forms[0].hidAction.value=="insert")
	{
		if(document.forms[0].type_Coffee)
		{
			var len = document.forms[0].type_Coffee.length;
			if(len==null)
			{
					if(document.forms[0].type_Coffee.value==document.forms[0].sel_coffeeplant.value && document.forms[0].type_Text.value==document.forms[0].sel_type.value)
					{
						alert("Data already exist");
						return;
					}
			}
			else
			{
				for(i=0;i<len;i++)
				{	
					if(document.forms[0].type_Coffee[i].value==document.forms[0].sel_coffeeplant.value && document.forms[0].type_Text[i].value==document.forms[0].sel_type.value)
					{
						alert("Data already exist");
						return;
					}
				}	
			}
		}	
	}
	enableButtons(true, true, true, true, true, false);	
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="staticdata";
	document.forms[0].hidBeanMethod.value="updateCoffeeData";
	document.forms[0].hidBeanGetMethod.value="getCoffeeData";
	document.forms[0].hidSourceUrl.value="/action/coffeevaluationmaster.jsp";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();
}

function doClose()
{
	var con=ConfirmMsg('100');
	if(con)
	{
		document.forms[0].action=appURL+"action/setagriparam.jsp";
		document.forms[0].submit();
	}
}

function doCancel()
{
	var varconfirm=ConfirmMsg('102');
	if(varconfirm)
	{
		document.forms[0].hidAction.value="Cancel";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="staticdata";
		document.forms[0].hidBeanGetMethod.value="getCoffeeData";
		document.forms[0].hidSourceUrl.value="/action/coffeevaluationmaster.jsp";		
		document.forms[0].submit();
	}
}

function doNew() 
{
	ClearFields();
	document.forms[0].hidAction.value="insert";
	varRecordFlag="N";
   	enableButtons(true, true, false, true, false, true);
   	disableFields(false);   
   	mode = "new";
}
function doEdit() 
{
   	document.forms[0].hidAction.value="update"
  
	enableButtons(true, true, false, true, false, true);
	disableFields(false);
	document.forms[0].sel_coffeeplant.disabled=true;
	document.forms[0].sel_type.disabled=true;
	mode ="edit";	
}
function doDelete() 
{
	if(varRecordFlag=="Y")
	{
		if( ConfirmMsg(101))
		{
			
			document.forms[0].sel_coffeeplant.disabled=false;
			document.forms[0].sel_type.disabled=false;
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appUrl+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateCoffeeData";
			document.forms[0].hidBeanGetMethod.value="getCoffeeData";
			document.forms[0].hidBeanId.value="staticdata";
			document.forms[0].hidSourceUrl.value="action/coffeevaluationmaster.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
			
		}
	}
	else
	{
		ShowAlert(158);
	}
}  
function enableButtons(bool1, bool2, bool3, bool4, bool5, bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}
function callCalender(fname)
{	
	if(document.forms[0].cmdsave.disabled==false)
	{
		showCal(appURL,fname);
	}
}

function callonLoad()
{		
	if(sel_coffeeplant!="")
	{
		document.forms[0].sel_coffeeplant.value=sel_coffeeplant;
	}	
	if(sel_type!="")
	{
		document.forms[0].sel_type.value=sel_type;
	}
	if(txt_value!="")
	{
		document.forms[0].txt_value.value=txt_value;
	}	
	
	if(txt_valdate!="")
	{
		document.forms[0].txt_valdate.value=txt_valdate;
	}
	enableButtons(false,true,true,true,true,false);	
	disableFields(true);
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonLoad()">
<form name="frmpri" method="post" class="normal">
  <table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>		
      <td class="page_flow">Home -&gt; Setup -&gt; Retail & Agriculture Products -&gt; Agri Parameters -&gt; Coffee Parameters</td>
	</tr>
</table>
<br>
						<table class="outertable border1" width="100%" border="0" cellspacing="0" cellpadding="3">
							<tr>
								<td>
								<table class="outertable" width="100%" border="0" cellspacing="0" cellpadding="2">
                            <tr align="center"> 
                              <td width="12%" >&nbsp;</td>
                              <td width="27%" >&nbsp;</td>
                              <td width="5%" >&nbsp;</td>
                              <td width="24%" >&nbsp;</td>
                              <td width="9%" >&nbsp;</td>
                              <td width="23%" >&nbsp;</td>
                            </tr>
                            <tr > 
                              <td width="16%" >  
                                <b>Type of Coffee Crop</b></td>
                              <td width="27%" ><b> 
                                <select name="sel_coffeeplant" style="width:200" onChange="">
                                  <option value="s">--Select--</option>
                                  <option value ="1">Arabica</option>
                                  <option value = "2">Robusta</option>
                                </select>
                                </b></td>
                              <td width="8%" > <b>Type</b></td>
                              <td width="24%" > <b> 
                                <select name="sel_type" style="width:200" onChange="">
                                  <option value="s" selected>--Select--</option>
                                  <option value="1">Parachment</option>
                                  <option value="2">Cherry</option>
                                </select>
                                </b></td>
                              <td width="12%" > <b>Value / Tonne</b> <strong>(Rs.)</strong></td>
                              <td width="23%" >&nbsp;   
                                <input type="text" maxlength="16" style="text-align: right;"
											name="txt_value" value="" onblur="roundtxt(this);" onKeyPress="allowInteger()">
                                <b> </b></td>
                            </tr>
                            <tr > 
                              <td width="12%" > &nbsp;<b>Valid 
                                Upto </b></td>
                              <td width="27%" > 
                                <table class="outertable" width="40%" border="0" cellspacing="0" cellpadding="3">
                                  <tr> 
                                    <td><input type="text" size="11"
											name="txt_valdate" onBlur="checkDate(this);checkmindate(this,'<%=Helper.getCurrentDateTime()%>')" ></td>
                                    <td><a href="#"
											onClick="callCalender('txt_valdate')"
											title="Click to view calender" border=0><img
											src="<%=ApplicationParams.getAppUrl()%>/img/calen.gif"
											border="0"></a></td>
                                  </tr>
                                </table>                               
                              <td nowrap width="5%" > &nbsp;</td>
                              <td width="24%" >&nbsp;</td>
                              <td width="9%" > &nbsp;</td>
                              <td width="23%" >&nbsp; </td>                           
                          </table>	
                          </td>
                          </tr>
                          </table>							
							<br>							
							<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
							<br>							
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable linebor">
									<tr class="dataheader">
										<td width="4%" > &nbsp;</td>										
                              <td width="17%" align="center" >Type of Coffee</td>										
                              <td width="17%" align="center" >Type</td>										
                              <td width="16%" align="center" >Value/Tonne (Rs.)</td>										
                              <td width="15%" align="center" >Valid upto </td>                           	
									</tr>
									<%if (vecData != null) 
									{
										vecsize = vecData.size();			
									}
			String strSno = "";
			for (int i = 0; i < vecsize; i++) {
				vecRow = (ArrayList) vecData.get(i);
				if (vecRow != null) {
					strSno = Helper.correctNull((String) vecRow.get(0));%>
									<tr align="center" class="datagrid">
										<td width="4%" ><input type="radio"
											name="sno" style="border-style:none"
											onClick="selectValues('<%=Helper.correctNull((String) vecRow.get(0))%>', '<%=Helper.correctNull((String) vecRow.get(1)) %>','<%=Helper.correctNull((String) vecRow.get(2))%>','<%=Helper.correctNull((String) vecRow.get(3))%>', '<%=Helper.correctNull((String) vecRow.get(4))%>');">
										<input type="hidden" name="hid" value="<%=strSno%>"></td>
										<td width="17%" valign="middle" >&nbsp;
										<input type="hidden" name = "type_Coffee" value="<%=Helper.correctNull((String) vecRow.get(1))%>">
										<%str=Helper.correctNull((String) vecRow.get(1));									 	
									   if(str.equalsIgnoreCase("1"))
	                                        {
		                                       str="Arabica";
	                                         }
	                                    if(str.equalsIgnoreCase("2"))
	                                     {
	                                 		 	str="Robusta";
                                         	}%>
                <%=str%>&nbsp; &nbsp; &nbsp; &nbsp;</td>
										<td width="17%" >&nbsp;
										<input type="hidden" name = "type_Text" value="<%=Helper.correctNull((String) vecRow.get(2))%>">
										<% str1=Helper.correctNull((String) vecRow.get(2));
										 if(str1.equalsIgnoreCase("1"))
	                                        {
		                                       str1="Parachment";
	                                         }
	                                    if(str1.equalsIgnoreCase("2"))
	                                     {
	                                  	str1="Cherry";
                                         	}%>
										<%=str1%>&nbsp; &nbsp; &nbsp; &nbsp;</td>										
                              <td width="16%"  align="right">&nbsp;<%=nf.format(Double.parseDouble(Helper.correctDouble((String) vecRow.get(3))))%>&nbsp; 
                                &nbsp; &nbsp; &nbsp;</td>										
                              <td width="15%"  style="text-align:right" align="center"><%=Helper.correctNull((String) vecRow.get(4))%> 
                              </td>								
									</tr>
									<%}}%>
								</table>
<lapschoice:hiddentag pageid='<%=PageId%>'/> 
<input type="hidden" name="hidorg_code" value="<%=Helper.correctNull((String)hshValues.get("ORG_CODE"))%>"> 
<input type="hidden" name="hidsno" value="">
<input type="hidden" name="hidcat_parent" value="0">  
<input type="hidden" name="selsno" value="">
<input type ="hidden" name ="hidkeyid" value="set">
</form>
</body>
</html>

