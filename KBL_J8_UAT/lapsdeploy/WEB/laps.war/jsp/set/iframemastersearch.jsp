<%@ page import="com.sai.laps.helper.*" %>
<%@ taglib prefix ="laps"  uri="/WEB-INF/laps.tld" %>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" />
<laps:handleerror />
<html>
<head>
<title>Untitled Document</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">

<script>
function loadValues()
{
	parent.frames.document.forms[0].hidsno.value = "<%=Helper.correctNull((String)hshValues.get("sno"))%>";	
	parent.frames.document.forms[0].txt_datavalues.value = "<%=Helper.correctNull((String)hshValues.get("datavalue"))%>";
	parent.frames.document.forms[0].txt_datavalues1.value = "<%=Helper.correctNull((String)hshValues.get("datadesc"))%>";
	parent.frames.document.forms[0].selactive.value = "<%=Helper.correctNull((String)hshValues.get("dataactive"))%>";
	parent.frames.document.forms[0].txt_value.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("218")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("252")){%>
	parent.frames.document.forms[0].selSMS.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("283")){%>
	parent.frames.document.forms[0].sel_Industry.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("211")){%>
	parent.frames.document.forms[0].sel_act.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("144")){%>
	parent.frames.document.forms[0].sel_type.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("225")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("226")
			||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("227")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("228")||
			Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("229")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("230")){%>
	parent.frames.document.forms[0].sel_inputtype.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	parent.frames.document.forms[0].txt_inputvalue.value = "<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("234")){%>
	parent.frames.document.forms[0].sel_inputtype1.value = "<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	parent.frames.document.forms[0].txt_inputvalue1.value = "<%=Helper.correctNull((String)hshValues.get("stat_data_descvalue1"))%>";
	<%}else if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("240")){%>

	var strdatavalue1="<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";

	var strstrdatavalue1_temp =strdatavalue1.split("@");	
	parent.frames.document.forms[0].sel_reasonfor.options[0].selected=false;
	parent.frames.document.forms[0].sel_reasonfor.options[1].selected=false;
	parent.frames.document.forms[0].sel_reasonfor.options[2].selected=false;
	for(var i=0;i<strstrdatavalue1_temp.length-1;i++)
	{
		var selValue=strstrdatavalue1_temp[i];
		if(selValue=="D")	
			parent.frames.document.forms[0].sel_reasonfor.options[0].selected=true;
		 
		if(selValue=="C")
			parent.frames.document.forms[0].sel_reasonfor.options[1].selected=true;
		 
		if(selValue=="A")
			parent.frames.document.forms[0].sel_reasonfor.options[2].selected=true;
	}
	
	var strModuleType="<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	var strModuleType_temp =strModuleType.split("@");	
	parent.frames.document.forms[0].sel_module.options[0].selected=false;
	parent.frames.document.forms[0].sel_module.options[1].selected=false;
	parent.frames.document.forms[0].sel_module.options[2].selected=false;
	for(var i=0;i<strModuleType_temp.length-1;i++)
	{
		var selValue=strModuleType_temp[i];
		if(selValue=="ret")	
			parent.frames.document.forms[0].sel_module.options[0].selected=true;
		 
		if(selValue=="corp")
			parent.frames.document.forms[0].sel_module.options[1].selected=true;
		 
		if(selValue=="agr")
			parent.frames.document.forms[0].sel_module.options[2].selected=true;
	}
	
	
	<%}else{%>
	parent.frames.document.forms[0].txt_value.value = "<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	<%}%>
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("233")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("234")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("247")){%>
	parent.frames.document.forms[0].sel_gecltype.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_GECLDESC"))%>";
	
	<%}%>
	
	
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("234")){%>
	parent.frames.document.forms[0].sel_gecltype.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_GECLDESC"))%>";
	//parent.frames.document.forms[0].sel_eligibility.value="<%//=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	parent.frames.callperType('<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>');
	parent.frames.document.forms[0].sel_sector.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_SECTOR"))%>";
	parent.frames.document.forms[0].txt_inputvalue2.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_MAXVAL"))%>";
	
	<%}%>
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("252")){%>
	parent.frames.document.forms[0].sel_bankscheme.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_BANK_SCHEME"))%>";
	
	<%}%>

	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("267")){%>
	parent.frames.document.forms[0].sel_CersaiReq.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_CERSAIREQ"))%>";
	<%}%>
	
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("268")){%>
	parent.frames.document.forms[0].sel_bankschemeforclpu.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_BANK_SCHEMECLPH"))%>";
	parent.frames.document.forms[0].sel_clpuReq.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_SENDTOCLPH"))%>";
	<%}%>
	
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("256")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("257")||Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("278")){%>
	parent.frames.document.forms[0].txt_inputsolvalue1.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_RANGE_FROM"))%>";
	parent.frames.document.forms[0].txt_inputsolvalue2.value = "<%=Helper.correctNull((String)hshValues.get("STATIC_DATA_RANGE_TO"))%>";
	
	<%}%>
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("264")){ %>
	var strdatavalue1="<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	var selreason = strdatavalue1.split("@");
	for(var k=0;k<selreason.length;k++)
	{
		for(var m=0;m<parent.frames.document.forms[0].sel_type_borrower.options.length;m++)
		{
			if(parent.frames.document.forms[0].sel_type_borrower.options[m].value==selreason[k])
			{			
				parent.frames.document.forms[0].sel_type_borrower.options[m].selected=true;

				break;
			}		
		}
	}


	var strModuleType="<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	var strModuleType_temp =strModuleType.split("@");	
	for(var n=0;n<strModuleType_temp.length;n++)
	{
		for(var q=0;q<parent.frames.document.forms[0].sel_borrow_module.options.length;q++)
		{
			if(parent.frames.document.forms[0].sel_borrow_module.options[q].value==strModuleType_temp[n])
			{			
				parent.frames.document.forms[0].sel_borrow_module.options[q].selected=true;

				break;
			}		
		}
	}
	<%}%>
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("245")){ %>
	var strdatavalue1="<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	var selreason = strdatavalue1.split(",");
	var select=parent.frames.document.getElementById("module");
	//alert("selreason===="+selreason);
	
	for(var i=0; i<selreason.length; i++)
	{
		//alert("selreason1111"+selreason);
		for(var j=0;j<select.options.length;j++)
		{
			//alert("selreason[i]"+selreason[i]);
			if(select.options[j].value== selreason[i])
			{
				select.options[j].selected ="selected";
				//select.options[j].selected =true;

				
			}

			if((select.options[j].value!= selreason[i]) && j>=i)
			{
				select.options[j].selected ="";
			}
			
		}
		
	}

	

	<%}%>


	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("246")){ %>
	var strdatavalue1="<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	var selreason = strdatavalue1.split(",");
	var select=parent.frames.document.getElementById("module");
	//alert("selreason===="+selreason);
	
	for(var i=0; i<selreason.length; i++)
	{
		for(var j=0;j<select.options.length;j++)
		{
			if(select.options[j].value== selreason[i])
			{
				//select.options[j].selected ="selected";
				select.options[j].selected =true;

				break;
			}
		}
	}
	<%}%>
	<%if(Helper.correctNull((String)hshValues.get("dataId")).equalsIgnoreCase("265")){%>
	var strdatavalue1="<%=Helper.correctNull((String)hshValues.get("datavalue1"))%>";
	var selreason = strdatavalue1.split("@");
	for(var j=0;j<selreason.length;j++)
	{
		for(var i=0;i<parent.frames.document.forms[0].sel_res_framework.options.length;i++)
		{
			if(parent.frames.document.forms[0].sel_res_framework.options[i].value==selreason[j])
			{			
				parent.frames.document.forms[0].sel_res_framework.options[i].selected=true;

				break;
			}		
		}
	}
	var strModuleType="<%=Helper.correctNull((String)hshValues.get("stat_data_valuedesc"))%>";
	var strModuleType_temp =strModuleType.split("@");	
	for(var j=0;j<strModuleType_temp.length;j++)
	{
		for(var i=0;i<parent.frames.document.forms[0].sel_framework_module.options.length;i++)
		{
			if(parent.frames.document.forms[0].sel_framework_module.options[i].value==strModuleType_temp[j])
			{			
				parent.frames.document.forms[0].sel_framework_module.options[i].selected=true;

				break;
			}		
		}
	}
	<%}%>
	parent.frames.enablefields();
	
}
</script>
</head>

<body  text="#000000" leftmargin="0" topmargin="0" marginwidth="0" marginheight="0" onLoad="loadValues()">
<form name="frm" method="post">
</form>
</body>
</html>
