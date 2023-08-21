<%@include file="../share/directives.jsp"%>
<%
	ArrayList arrRow= new ArrayList();
	ArrayList arrCol=new ArrayList();
	String Ianimal="0";
	String IIanimal="0";
	double Icost=0;
	double IIcost=0;
	double Itotcost=0;
	double IItotcost=0;
	
	if(hshValues!=null)
	{							
		arrRow=(ArrayList)hshValues.get("arrstockdetails");
		if(arrRow!=null && arrRow.size()>0)
		{
			if(arrRow.size()>0)
			{
				arrCol=(ArrayList) arrRow.get(0);
				Ianimal=Helper.correctNull((String)arrCol.get(2));
				Icost=Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
				Itotcost=Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
			}
			else
			{
				Ianimal="0";
				Icost=0;
				Itotcost=0;
			}
			if(arrRow.size()>1)
			{
				arrCol=(ArrayList) arrRow.get(1);
				IIanimal=Helper.correctNull((String)arrCol.get(2));
				IIcost=Double.parseDouble(Helper.correctDouble((String)arrCol.get(3)));
				IItotcost=Double.parseDouble(Helper.correctDouble((String)arrCol.get(4)));
			}
			else
			{
				IIanimal="0";
				IIcost=0;
				IItotcost=0;
			}
		}
		else
		{
			Ianimal="0";
			Icost=0;
			Itotcost=0;
			IIanimal="0";
			IIcost=0;
			IItotcost=0;
		}
	}						
%>
<html>
<head>
<title>Live Stock Details</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var selgobr= "<%=Helper.correctNull((String)hshValues.get("sel_gober"))%>";
var selcalv= "<%=Helper.correctNull((String)hshValues.get("sel_calves"))%>";
var selworkcap= "<%=Helper.correctNull((String)hshValues.get("sel_workcapital"))%>";
var selmaincost = "<%=Helper.correctNull((String)hshValues.get("maintcost"))%>";
var totnoofanimals = "<%=Helper.correctNull((String)hshValues.get("totnoofanimals"))%>";

var totnoofIBatanimals = "<%=Helper.correctNull((String)hshValues.get("totnoofIBatanimals"))%>";
function callonload()

{
	document.all.f1.style.visibility="hidden";
	document.all.f2.style.visibility="hidden";
	//document.all.f3.style.visibility="hidden";
	//document.all.f4.style.visibility="hidden";
	document.all.f5.style.visibility="hidden";
	document.all.f6.style.visibility="hidden";
	document.all.f7.style.visibility="hidden";
	document.all.f8.style.visibility="hidden";
	if(selgobr=="1")
	{
		document.all.f1.style.visibility="hidden";
		document.all.f2.style.visibility="hidden";
	}
	else if(selgobr=="2")
	{
		document.all.f1.style.visibility="visible";
		document.all.f2.style.visibility="visible";
	}
	
	if(selcalv=="1")
	{
		document.all.f3.style.visibility="visible";
		document.all.f4.style.visibility="visible";
	}
	else if(selcalv=="2")
	{
		document.all.f3.style.visibility="hidden";
		document.all.f4.style.visibility="hidden";
	}
	
	if(selworkcap=="2")
	{
		document.all.f5.style.visibility="hidden";
		document.all.f6.style.visibility="hidden";
		document.all.f7.style.visibility="hidden";
		document.all.f8.style.visibility="hidden";
	}
	else if(selworkcap=="1")
	{
		document.all.f5.style.visibility="visible";
		document.all.f6.style.visibility="visible";
		document.all.f7.style.visibility="visible";
		document.all.f8.style.visibility="visible";
	}
	
	if(selgobr!="")
	{
		document.forms[0].sel_gober.value=selgobr;
	}
	else
	{
		document.forms[0].sel_gober.value="1";
	}
	if(selcalv!="")
	{
		document.forms[0].sel_calves.value=selcalv;
	}
	else
	{
		document.forms[0].sel_calves.value="1";
	}
	if(selworkcap!="")
	{
		document.forms[0].sel_workcapital.value=selworkcap;
	}
	/*else
	{
		document.forms[0].sel_workcapital.value="1";
	} */
	if(selmaincost!="")
	{
		document.forms[0].txt_maintcost.value=selmaincost;
	}
	else
	{
		document.forms[0].txt_maintcost.value="0";
	} 
	disableFields(true);
	dispinccalves();
}

function callfilldefault()
{
	if(document.forms[0].check_default.checked == true)
	{
		
		document.forms[0].txt_totcostlact.value = 70;
		document.forms[0].txt_totcostdry.value = 50;
		document.forms[0].txt_greenfodder.value = 6;
		document.forms[0].txt_costgreen.value = 1.50;
		document.forms[0].txt_expgreen.value = 9;
		document.forms[0].txt_dryfodder.value = 19;
		document.forms[0].txt_costdry.value = 1;
		document.forms[0].txt_expdry.value = 19;
		document.forms[0].txt_concenfeed.value = 7;
		document.forms[0].txt_costconcen.value = 6;
		document.forms[0].txt_expconcen.value = 42;
		
		
		document.forms[0].txt_dgreenfodder.value = 6;
		document.forms[0].txt_dcostgreen.value = 1.50;
		document.forms[0].txt_dexpgreen.value = 9;
		document.forms[0].txt_ddryfodder.value = 17;
		document.forms[0].txt_dcostdry.value = 1;
		document.forms[0].txt_dexpdry.value = 17;
		document.forms[0].txt_dconcenfeed.value = 4;
		document.forms[0].txt_dcostconcen.value = 6;
		document.forms[0].txt_dexpconcen.value = 24;
		document.forms[0].txt_greenfodder.readOnly = true;
		document.forms[0].txt_dryfodder.readOnly = true;
		document.forms[0].txt_concenfeed.readOnly = true;
		document.forms[0].txt_costgreen.readOnly = true;
		document.forms[0].txt_costdry.readOnly = true;
		document.forms[0].txt_costconcen.readOnly = true;
		document.forms[0].txt_dgreenfodder.readOnly = true;
		document.forms[0].txt_dcostgreen.readOnly = true;
		document.forms[0].txt_ddryfodder.readOnly = true;
		document.forms[0].txt_dcostdry.readOnly = true;
		document.forms[0].txt_dconcenfeed.readOnly = true;
		document.forms[0].txt_dcostconcen.readOnly = true;
	}
	else if(document.forms[0].check_default.checked == false)
	{
		document.forms[0].txt_greenfodder.readOnly = false;
		document.forms[0].txt_dryfodder.readOnly = false;
		document.forms[0].txt_concenfeed.readOnly = false;
		document.forms[0].txt_costgreen.readOnly = false;
		document.forms[0].txt_costdry.readOnly = false;
		document.forms[0].txt_costconcen.readOnly = false;
		document.forms[0].txt_dgreenfodder.readOnly = false;
		document.forms[0].txt_dcostgreen.readOnly = false;
		document.forms[0].txt_ddryfodder.readOnly = false;
		document.forms[0].txt_dcostdry.readOnly = false;
		document.forms[0].txt_dconcenfeed.readOnly = false;
		document.forms[0].txt_dcostconcen.readOnly = false;
	}
}	
function dispworkcapital()
{
	if(document.forms[0].sel_workcapital.value=="1")
	{	
		document.all.f5.style.visibility="visible";
		document.all.f6.style.visibility="visible";
		document.all.f7.style.visibility="visible";
		document.all.f8.style.visibility="visible";
		//document.all.f9.style.visibility="visible";
		//document.all.f10.style.visibility="visible";
	}
	else
	{
		document.all.f5.style.visibility="hidden";
		document.all.f6.style.visibility="hidden";
		document.all.f7.style.visibility="hidden";
		document.all.f8.style.visibility="hidden";
		//document.all.f9.style.visibility="hidden";
	//	document.all.f10.style.visibility="hidden";		
	}	
}

function calcuateotherexp()
{
 
 var EBexpenses = document.forms[0].txt_elecexp.value;
 var otherexpenses = document.forms[0].txt_otherexp.value;

 var total;
 if(EBexpenses == "")
 {
 	EBexpenses = 0;
 }
 if(otherexpenses =="")
 {
 	otherexpenses = 0;
 }
 total = (eval(EBexpenses)* eval(12)) + (eval(otherexpenses) * eval(totnoofanimals));

 //document.forms[0].txt_tototherexp.value = total;
}

function dispincgober()
{
	if(document.forms[0].sel_gober.value=="2")
	{
		document.all.f1.style.visibility="visible";
		document.all.f2.style.visibility="visible";
	}
	else
	{
		document.all.f1.style.visibility="hidden";
		document.all.f2.style.visibility="hidden";
	}		
}

function dispinccalves()
{
	if(document.forms[0].sel_calves.value=="1")
	{
		document.all.f3.style.visibility="visible";
		document.all.f4.style.visibility="visible";
	}
	else
	{
		document.all.f3.style.visibility="hidden";
		document.all.f4.style.visibility="hidden";
		document.forms[0].txt_inccalves.value="";
	}		
}

function doSave()
{
	if(document.forms[0].txt_milkprice.value=="")
	{
		alert("Enter the Mlilk price Value");
		document.forms[0].txt_milkprice.focus();
		return false; 
	}
	if(document.forms[0].sel_gober.value=="2")
	{
		if(document.forms[0].txt_incomgober.value=="")
		{
			alert("Enter the Income from gober Value");
			document.forms[0].txt_incomgober.focus();
			return false; 
		}
	}
	if(document.forms[0].txt_vetaid.value=="")
	{
		alert("Enter the veterianary aid Value");
		document.forms[0].txt_vetaid.focus();
		return false; 
	}	
	if(document.forms[0].txt_elecexp.value=="")
	{
		alert("Enter the electricity expenses Value");
		document.forms[0].txt_elecexp.focus();
		return false; 
	}
	if(document.forms[0].sel_calves.value=="1")
	{
		if(document.forms[0].txt_inccalves.value=="")
		{
			alert("Enter the expenses for female calves Value");
			document.forms[0].txt_inccalves.focus();
			return false; 
		}
	}
	if(document.forms[0].check_default.value == false)
	{
	 if(document.forms[0].txt_greenfodder.value=="")
	{
		alert("Enter the Green fodder Value");
		document.forms[0].txt_greenfodder.focus();
		return false; 
	}
	if(document.forms[0].txt_costgreen.value=="")
	{
		alert("Enter the Cost of Green fodder Value");
		document.forms[0].txt_costgreen.focus();
		return false; 
	}
	if(document.forms[0].txt_dryfodder.value=="")
	{
		alert("Enter the Dry fodder Value");
		document.forms[0].txt_dryfodder.focus();
		return false; 
	}
	if(document.forms[0].txt_costdry.value=="")
	{
		alert("Enter the Cost of Dry fodder Value");
		document.forms[0].txt_costdry.focus();
		return false; 
	}
	if(document.forms[0].txt_concenfeed.value=="")
	{
		alert("Enter the Concentrate feed Value");
		document.forms[0].txt_concenfeed.focus();
		return false; 
	}
	if(document.forms[0].txt_costconcen.value=="")
	{
		alert("Enter the cost of Concentrate feed Value");
		document.forms[0].txt_costconcen.focus();
		return false; 
	}
	if(document.forms[0].txt_dgreenfodder.value=="")
	{
		alert("Enter the Green fodder Value");
		document.forms[0].txt_dgreenfodder.focus();
		return false; 
	}
	if(document.forms[0].txt_dcostgreen.value=="")
	{
		alert("Enter the cost of Green fodder Value");
		document.forms[0].txt_dcostgreen.focus();
		return false; 
	}
	if(document.forms[0].txt_ddryfodder.value=="")
	{
		alert("Enter the Dry fodder Value");
		document.forms[0].txt_ddryfodder.focus();
		return false; 
	}
	if(document.forms[0].txt_dcostdry.value=="")
	{
		alert("Enter the  cost of Dry fodder Value");
		document.forms[0].txt_dcostdry.focus();
		return false; 
	}
	if(document.forms[0].txt_dconcenfeed.value=="")
	{
		alert("Enter the Concentrate feed Value");
		document.forms[0].txt_dconcenfeed.focus();
		return false; 
	}
	if(document.forms[0].txt_dcostconcen.value=="")
	{
		alert("Enter the cost of Concentrate feed Value");
		document.forms[0].txt_dcostconcen.focus();
		return false;
	}
	}
	if(document.forms[0].txt_value.value=="")
	{
		alert("Enter the value of one animal at the end of project");
		document.forms[0].txt_value.focus();
		return false; 
	}
	
	if(document.forms[0].sel_workcapital.value=="1")
	{
		if(document.forms[0].txt_feed.value=="")
		{
			alert("Enter the Feeding cost Value");
			document.forms[0].txt_feed.focus();
			return false; 
		}
	}
	
	var len = document.forms[0].sel_gober.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_gober.options[i].selected==true)
		 {
			 document.forms[0].sel_gober_text.value = document.forms[0].sel_gober.options[i].text; 
			break;
		 }
	}
	
	len = document.forms[0].sel_calves.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_calves.options[i].selected==true)
		 {
			 document.forms[0].sel_calves_text.value = document.forms[0].sel_calves.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_workcapital.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_workcapital.options[i].selected==true)
		 {
			 document.forms[0].sel_workcapital_text.value = document.forms[0].sel_workcapital.options[i].text; 
			break;
		 }
	}
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="agreconomic";		
	document.forms[0].hidSourceUrl.value="/action/agr_diaryfindata.jsp";
	document.forms[0].hidBeanMethod.value="updatediaryfinData";
	document.forms[0].hidBeanGetMethod.value="getdiaryfinData";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].submit();	
}

function doEdit()
{
	disableFields(false);
	document.forms[0].txt_expgreen.readOnly=true;
 	document.forms[0].txt_expdry.readOnly=true;
	document.forms[0].txt_expconcen.readOnly=true;
 	document.forms[0].txt_totcostlact.readOnly=true;
	document.forms[0].txt_dexpgreen.readOnly=true;
 	document.forms[0].txt_dexpdry.readOnly=true;
	document.forms[0].txt_dexpconcen.readOnly=true;
 	document.forms[0].txt_totcostdry.readOnly=true;
	document.forms[0].txt_totexplab.readOnly=true;
 	document.forms[0].txt_totcostconst.readOnly=true;
	document.forms[0].txt_equip1totcost.readOnly=true;
 	document.forms[0].txt_equip2totcost.readOnly=true;
	document.forms[0].txt_equip3totcost.readOnly=true;
	document.forms[0].txt_equip4totcost.readOnly=true;
	document.forms[0].txt_totequipcost.readOnly=true;
	document.forms[0].txt_feed.readOnly=true;
	document.forms[0].txt_icost.readOnly=true;
	document.forms[0].txt_iicost.readOnly=true;
	document.forms[0].txt_ino.readOnly=true;
	document.forms[0].txt_iino.readOnly=true;
	document.forms[0].txt_itotcost.readOnly=true;
	document.forms[0].txt_iitotcost.readOnly=true;
	document.forms[0].txt_totcost.readOnly=true;
	
	//document.forms[0].txt_tototherexp.readOnly=true;
	document.forms[0].hidAction.value ="update"; 
	enableButtons(true, false, false, false, true);	
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidBeanGetMethod.value="getdiaryfinData";
		document.forms[0].action=appURL +"action/agr_diaryfindata.jsp";
		document.forms[0].submit(); 	
	}
}

function doDelete()
{
var len = document.forms[0].sel_gober.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_gober.options[i].selected==true)
		 {
			 document.forms[0].sel_gober_text.value = document.forms[0].sel_gober.options[i].text; 
			break;
		 }
	}
	
	len = document.forms[0].sel_calves.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_calves.options[i].selected==true)
		 {
			 document.forms[0].sel_calves_text.value = document.forms[0].sel_calves.options[i].text; 
			break;
		 }
	}
	len = document.forms[0].sel_workcapital.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].sel_workcapital.options[i].selected==true)
		 {
			 document.forms[0].sel_workcapital_text.value = document.forms[0].sel_workcapital.options[i].text; 
			break;
		 }
	}
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value ="delete";
		document.forms[0].action=appURL+"action/ControllerServlet";	
		document.forms[0].hidBeanMethod.value="updatediaryfinData";
		document.forms[0].hidBeanGetMethod.value="getdiaryfinData";
		document.forms[0].hidBeanId.value="agreconomic";
		document.forms[0].hidSourceUrl.value="/action/agr_diaryfindata.jsp";	
		document.forms[0].method="post";			
		document.forms[0].submit();	
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

function enableButtons(bool1, bool2, bool3, bool4, bool5)
{
	
	document.forms[0].cmdedit.disabled=bool1;
	document.forms[0].cmdsave.disabled=bool2;
	document.forms[0].cmdcancel.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdclose.disabled = bool5;
}

function feedingcalc(obj1, obj2, obj3)
{	
	var res=eval((obj2))*eval((obj1.value));
	obj3.value=res;
}

function totfeedlact()
{
	var expgreen=document.forms[0].txt_expgreen.value;
	if(expgreen=="")
	{
		expgreen=0;
	} 
	var expdry=document.forms[0].txt_expdry.value;
	if(expdry=="")
	{
		expdry=0;
	} 
	var expconcen=document.forms[0].txt_expconcen.value;
	if(expconcen=="")
	{
		expconcen=0;
	}
	var totlact=eval(expgreen) + eval(expdry) + eval(expconcen);
	document.forms[0].txt_totcostlact.value=totlact;
}

function totfeeddry()
{
	var dexpgreen=document.forms[0].txt_dexpgreen.value;
	if(dexpgreen=="")
	{
		dexpgreen=0;
	}
	var dexpdry=document.forms[0].txt_dexpdry.value;
	if(dexpdry=="")
	{
		dexpdry=0;
	}
	var dexpconcen=document.forms[0].txt_dexpconcen.value;
	if(dexpconcen=="")
	{
		dexpconcen=0;
	}
	var totdry=eval(dexpgreen) + eval(dexpdry) + eval(dexpconcen);
	document.forms[0].txt_totcostdry.value=totdry;
}

function totequip(obj1, obj2, obj3)
{
	var obj11=obj1.value;
	if(obj11=="")
	{
		obj11=0;
	}
	if(obj2=="")
	{
		obj2=0;
	}
	var res=eval((obj2))*eval((obj11));
	obj3.value=res;
}

function costequip()
{
	var e1=document.forms[0].txt_equip1totcost.value;
	if(e1=="")
	{
		e1=0;
	}
	var e2=document.forms[0].txt_equip2totcost.value;
	if(e2=="")
	{
		e2=0;
	}
	var e3=document.forms[0].txt_equip3totcost.value;
	if(e3=="")
	{
		e3=0;
	}
	var e4=document.forms[0].txt_equip4totcost.value;
	if(e4=="")
	{
		e4=0;
	}
	var totequ=eval(e1) + eval(e2) + eval(e3) + eval(e4);
	document.forms[0].txt_totequipcost.value=totequ;
}

function feedcostmeth()
{
	var mncost = document.forms[0].txt_maintcost.value;
	var totcostlac = document.forms[0].txt_totcostlact.value;
	var totfeedcost = 1;
	if(totcostlac=="")
	{
		totcostlac=0;
	}

	if(mncost=="")
	{
		mncost=1;
	}
	
	if(mncost=="1")
	{
		mncost=30;
	}
	else if(mncost=="2")
	{
		mncost=60;
	}
	else if(mncost=="3")
	{
		mncost=90;
	}
	totfeedcost = eval(totcostlac) * eval(mncost) * eval(totnoofIBatanimals);
	document.forms[0].txt_feed.value = eval(totfeedcost);
}
function doClose()
{
	if( ConfirmMsg(100))
	{
		document.forms[0].target="_parent";
		document.forms[0].action=appURL+"action/retailpge.jsp";				
		document.forms[0].submit();
	}
}

function checkMonth(obj1)
{

	if(eval(obj1.value)>12)
	{
		alert("Interval between Batches(Months) cannot be greater than 12");
		obj1.value="";
		obj1.focus();
	}
	
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="callonload()">
<form name="frmpri" method="post" class="normal">
<table width="100%" border="0" cellpadding="3" cellspacing="0" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable border1">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
								  <tr>
									<td>
									 <table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Income Details </b></td>
                                  </tr>
                                  <tr> 
                                    <td width="19%">Sale Price of Milk/litre (Rs)<b class="mantatory">*</b></td>
                                    <td width="9%"> 
                                      <lapschoice:CurrencyTag  name="txt_milkprice"
													value='<%=Helper.correctNull((String)hshValues.get("milkprice"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                    <td width="12%">Gober</td>
                                    <td width="6%"> 
                                      <select name="sel_gober" onChange="dispincgober()">
                                        <option value="1">Own Use</option>
                                        <option value="2" selected="selected">For Sale</option>
                                      </select>
                                      </td>
                                    <td width="17%" id="f1">Income from Gober/ Animal / Year (Rs) </td>
                                    <td width="10%" id="f2">&nbsp;&nbsp; 
                                      <lapschoice:CurrencyTag 
													name="txt_incomgober"
													value='<%=Helper.correctNull((String)hshValues.get("incomgober"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													/>
                                    </td>
                                    <td width="11%">&nbsp;</td>
                                    <td width="16%">&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Other Income per year (Rs.)</td>
                                    <td> 
                                       <lapschoice:CurrencyTag name="txt_otherincome"
													value='<%=Helper.correctNull((String)hshValues.get("otherincome"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Expenses Details </b></td>
                                  </tr>
                                  <tr> 
                                    <td>Expenses on Veterianary Aid / Animal / Year (Rs)<b class="mantatory">*</b></td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_vetaid"
													value='<%=Helper.correctNull((String)hshValues.get("vetaid"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
                                    </td>
                                    <td>Electricity expenses Per Month (Rs)<b class="mantatory">*</b></td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_elecexp"
													value='<%=Helper.correctNull((String)hshValues.get("elecexp"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>Female Calves</td>
                                    <td> 
                                      <select name="sel_calves" onChange="dispinccalves()">
                                        <option value="1">Retained</option>
                                        <option value="2" selected="selected">For Sale</option>
                                      </select>
                                      </td>
                                    <td id="f3">Expense for rearing Female Calves/ Animal / Year 
                                      (Rs)<b class="mantatory">*</b></td>
                                    <td id="f4">&nbsp;&nbsp; 
                                      <lapschoice:CurrencyTag name="txt_inccalves"
													value='<%=Helper.correctNull((String)hshValues.get("inccalves"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td>Insurance Premium / Per Animal / Year (Rs)</td>
                                    <td> 
                                     <lapschoice:CurrencyTag name="txt_inspremium"
													value='<%=Helper.correctNull((String)hshValues.get("inspremium"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
                                    </td>
                                    <td>Cost of Transportation per animal (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_transcost"
													value='<%=Helper.correctNull((String)hshValues.get("transcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Other Expenses / Animal / Year</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_otherexp"
													value='<%=Helper.correctNull((String)hshValues.get("otherexp"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                      <b> </b></td>
                                    <td> 
                                      <!--Total 
                                      Other Expenses -->
                                    </td>
                                    <td colspan="2">&nbsp;&nbsp; 
                                      <input type="hidden" name="txt_tototherexp"
													value="<%=Helper.correctNull((String)hshValues.get("tototherexp"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													style="text-align:right" readOnly="readonly">
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>No of Labourers</td>
                                    <td> 
                                      <input type="text" name="txt_nooflabour"
													value="<%=Helper.correctNull((String)hshValues.get("nooflabour"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_salmonth.value, document.forms[0].txt_totexplab)"
														style="text-align:left">
                                    </td>
                                    <td>Salary Per Month (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_salmonth"
													value='<%=Helper.correctNull((String)hshValues.get("salmonth"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_nooflabour.value, document.forms[0].txt_totexplab)"/>
													
                                    </td>
                                    <td>Total Expenses on Labour / Month</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_totexplab"
													value='<%=Helper.correctNull((String)hshValues.get("totexplab"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Feeding during Lactation days&nbsp;&nbsp;&nbsp;&nbsp; 
                                      <input type="hidden" name="check_default" value="checkbox" style="border:none"  onChange="callfilldefault();feedcostmeth()" >
                                      <!--Fill With Default Values-->
                                      </b></td>
                                  </tr>
                                  <tr> 
                                    <td>Green fodder / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_greenfodder"
													value="<%=Helper.correctNull((String)hshValues.get("greenfodder"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_costgreen.value, document.forms[0].txt_expgreen);totfeedlact();callfilldefault();feedcostmeth()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG (Rs)</td>
                                    <td> 
                                   <lapschoice:CurrencyTag name="txt_costgreen"
													value='<%=Helper.correctNull((String)hshValues.get("costgreen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_greenfodder.value, document.forms[0].txt_expgreen);totfeedlact();callfilldefault();feedcostmeth()" />
													
                                    </td>
                                    <td>Total Expenses on Green Fodder</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_expgreen"
													value='<%=Helper.correctNull((String)hshValues.get("expgreen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td height="32">Dry  fodder / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_dryfodder"
													value="<%=Helper.correctNull((String)hshValues.get("dryfodder"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_costdry.value, document.forms[0].txt_expdry);totfeedlact();callfilldefault();feedcostmeth()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG (Rs)</td>
                                    <td> 
                                       <lapschoice:CurrencyTag name="txt_costdry"
													value='<%=Helper.correctNull((String)hshValues.get("costdry"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dryfodder.value, document.forms[0].txt_expdry);totfeedlact();callfilldefault();feedcostmeth()" />
													
                                    </td>
                                    <td>Total Expenses on Dry Fodder</td>
                                    <td> 
                                     <lapschoice:CurrencyTag name="txt_expdry"
													value='<%=Helper.correctNull((String)hshValues.get("expdry"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Concentrate feed / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_concenfeed"
													value="<%=Helper.correctNull((String)hshValues.get("concenfeed"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_costconcen.value, document.forms[0].txt_expconcen);totfeedlact();callfilldefault();feedcostmeth()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG (Rs)</td>
                                    <td> 
                                       <lapschoice:CurrencyTag name="txt_costconcen"
													value='<%=Helper.correctNull((String)hshValues.get("costconcen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_concenfeed.value, document.forms[0].txt_expconcen);totfeedlact();callfilldefault();feedcostmeth()" />
													
                                    </td>
                                    <td>Total Expenses on Conc Feed</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_expconcen"
													value='<%=Helper.correctNull((String)hshValues.get("expconcen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="3">&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td><b>Total Cost Per Day</b></td>
                                    <td> 
                                    <lapschoice:CurrencyTag name="txt_totcostlact"
													value='<%=Helper.correctNull((String)hshValues.get("totcostlact"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
												
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="3"><b>Feeding during Dry days</b></td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Green fodder / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_dgreenfodder"
													value="<%=Helper.correctNull((String)hshValues.get("dgreenfodder"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dcostgreen.value, document.forms[0].txt_dexpgreen);totfeeddry();callfilldefault()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_dcostgreen"
													value='<%=Helper.correctNull((String)hshValues.get("dcostgreen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dgreenfodder.value, document.forms[0].txt_dexpgreen);totfeeddry();callfilldefault()" />
													
                                    </td>
                                    <td>Total Expenses on Green Fodder</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_dexpgreen"
													value='<%=Helper.correctNull((String)hshValues.get("dexpgreen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Dry fodder / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_ddryfodder"
													value="<%=Helper.correctNull((String)hshValues.get("ddryfodder"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dcostdry.value, document.forms[0].txt_dexpdry);totfeeddry();callfilldefault()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_dcostdry"
													value='<%=Helper.correctNull((String)hshValues.get("dcostdry"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_ddryfodder.value, document.forms[0].txt_dexpdry);totfeeddry();callfilldefault()" />
													
                                    </td>
                                    <td>Total Expenses on Dry Fodder</td>
                                    <td> 
                                     <lapschoice:CurrencyTag name="txt_dexpdry"
													value='<%=Helper.correctNull((String)hshValues.get("dexpdry"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>Concentrate feed / Animal / Day - KG</td>
                                    <td> 
                                      <input type="text" name="txt_dconcenfeed"
													value="<%=Helper.correctNull((String)hshValues.get("dconcenfeed"))%>"
													size="10" maxlength="6" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dcostconcen.value, document.forms[0].txt_dexpconcen);totfeeddry();callfilldefault()"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per KG</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_dcostconcen"
													value='<%=Helper.correctNull((String)hshValues.get("dcostconcen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_dconcenfeed.value, document.forms[0].txt_dexpconcen);totfeeddry();callfilldefault()"/>
													
                                    </td>
                                    <td>Total Expenses on Conc Feed</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_dexpconcen"
													value='<%=Helper.correctNull((String)hshValues.get("dexpconcen"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
												
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td><b>Total Cost Per Day</b></td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_totcostdry"
													value='<%=Helper.correctNull((String)hshValues.get("totcostdry"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr> 
                                    <td colspan="2">Value of one animal at the end of project (Average 
                                      of culled &amp; young) <b class="mantatory">*</b> 
                                    </td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_value"
													value='<%=Helper.correctNull((String)hshValues.get("txt_value"))%>'
													size="12" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Loan Particulars</b></td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Shed Details</b></td>
                                  </tr>
                                  <tr> 
                                    <td>Construction of Shed (Total Area - Sq ft)</td>
                                    <td> 
                                      <input type="text" name="txt_constshed"
													value="<%=Helper.correctNull((String)hshValues.get("constshed"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_constsqrcost.value, document.forms[0].txt_totcostconst)"
													style="text-align:right">
                                    </td>
                                    <td>Cost Per Sq ft (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_constsqrcost"
													value='<%=Helper.correctNull((String)hshValues.get("constsqrcost"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_constshed.value, document.forms[0].txt_totcostconst)" />
													
                                    </td>
                                    <td>Total Cost of Construction</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_totcostconst"
													value='<%=Helper.correctNull((String)hshValues.get("totcostconst"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Equipment Details</b></td>
                                  </tr>
                                  <tr> 
                                    <td> Equipment Specify (1)</td>
                                    <td> 
                                      <input type="text" name="txt_equip1"
													value="<%=Helper.correctNull((String)hshValues.get("equip1"))%>"
													size="15" maxlength="20" onKeyPress=""
													style="text-align:left">
                                    </td>
                                    <td>No of Units </td>
                                    <td> 
                                      <input type="text" name="txt_equip1unit"
													value="<%=Helper.correctNull((String)hshValues.get("equip1unit"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip1cost.value, document.forms[0].txt_equip1totcost);costequip()"
														style="text-align:left">
                                    </td>
                                    <td>Cost Per Unit (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_equip1cost"
													value='<%=Helper.correctNull((String)hshValues.get("equip1cost"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip1unit.value, document.forms[0].txt_equip1totcost);costequip()"/>
													
                                    </td>
                                    <td>Total Cost</td>
                                    <td>&nbsp;&nbsp; 
                                     <lapschoice:CurrencyTag name="txt_equip1totcost"
													value='<%=Helper.correctNull((String)hshValues.get("equip1totcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
												
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td>Equipment Specify (2)</td>
                                    <td> 
                                      <input type="text" name="txt_equip2"
													value="<%=Helper.correctNull((String)hshValues.get("equip2"))%>"
													size="15" maxlength="25" onKeyPress=""
													style="text-align:left">
                                    </td>
                                    <td>No of Units</td>
                                    <td> 
                                      <input type="text" name="txt_equip2unit"
													value="<%=Helper.correctNull((String)hshValues.get("equip2unit"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip2cost.value, document.forms[0].txt_equip2totcost);costequip()"
														style="text-align:left">
                                    </td>
                                    <td>Cost Per Unit (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_equip2cost"
													value='<%=Helper.correctNull((String)hshValues.get("equip2cost"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip2unit.value, document.forms[0].txt_equip2totcost);costequip()"/>
													
                                    </td>
                                    <td>Total Cost</td>
                                    <td>&nbsp;&nbsp; 
                                      <lapschoice:CurrencyTag name="txt_equip2totcost"
													value='<%=Helper.correctNull((String)hshValues.get("equip2totcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td height="24">Equipment Specify (3)</td>
                                    <td> 
                                      <input type="text" name="txt_equip3"
													value="<%=Helper.correctNull((String)hshValues.get("equip3"))%>"
													size="15" maxlength="25" onKeyPress=""
													style="text-align:left">
                                    </td>
                                    <td>No of Units</td>
                                    <td> 
                                      <input type="text" name="txt_equip3unit"
													value="<%=Helper.correctNull((String)hshValues.get("equip3unit"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip3cost.value, document.forms[0].txt_equip3totcost);costequip()"
														style="text-align:left">
                                    </td>
                                    <td>Cost Per Unit (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_equip3cost"
													value='<%=Helper.correctNull((String)hshValues.get("equip3cost"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip3unit.value, document.forms[0].txt_equip3totcost);costequip()"/>
													
                                    </td>
                                    <td>Total Cost</td>
                                    <td>&nbsp;&nbsp; 
                                     <lapschoice:CurrencyTag name="txt_equip3totcost"
													value='<%=Helper.correctNull((String)hshValues.get("equip3totcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td>Equipment Specify (4)</td>
                                    <td> 
                                      <input type="text" name="txt_equip4"
													value="<%=Helper.correctNull((String)hshValues.get("equip4"))%>"
													size="15" maxlength="25" onKeyPress=""
													style="text-align:left">
                                    </td>
                                    <td>No of Units</td>
                                    <td> 
                                      <input type="text" name="txt_equip4unit"
													value="<%=Helper.correctNull((String)hshValues.get("equip4unit"))%>"
													size="10" maxlength="9" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip4cost.value, document.forms[0].txt_equip4totcost);costequip()"
														style="text-align:left">
                                    </td>
                                    <td>Cost Per Unit (Rs)</td>
                                    <td> 
                                      <lapschoice:CurrencyTag name="txt_equip4cost"
													value='<%=Helper.correctNull((String)hshValues.get("equip4cost"))%>'
													size="10" maxlength="8" onKeyPress="allowNumber(this)"
													onBlur="totequip(this, document.forms[0].txt_equip4unit.value, document.forms[0].txt_equip4totcost);costequip()"/>
													
                                    </td>
                                    <td>Total Cost</td>
                                    <td>&nbsp;&nbsp; 
                                      <lapschoice:CurrencyTag name="txt_equip4totcost"
													value='<%=Helper.correctNull((String)hshValues.get("equip4totcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td> <b>Cost of Equipments</b></td>
                                    <td>&nbsp;&nbsp; 
                                      <lapschoice:CurrencyTag name="txt_totequipcost"
													value='<%=Helper.correctNull((String)hshValues.get("totequipcost"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)"/>
													
                                    </td>
                                  </tr>
                                  <tr class="dataheader"> 
                                    <td colspan="8"><b>Animal Details</b></td>
                                  </tr>
								
                                  <tr> 
								  
                                    <td>Animal Cost (I Batch)</td>
                                    <td>
                                      <input type="text" value="<%=Helper.formatDoubleValue(Icost)%>" style="text-align:right" size="10" maxlength="9" readOnly="readonly" name="txt_icost">
                                    </td>
                                    <td >No of Animals</td>
                                    <td >
                                      <input type="text" value="<%=Ianimal%>" readOnly="readonly" size="10" maxlength="9" name="txt_ino">
                                    </td>
                                    <td >&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>Total Cost</td>
                                    <td>
                                      <input type="text" value="<%=Helper.formatDoubleValue(Itotcost)%>" style="text-align:right" 
									size="10" maxlength="9" readOnly="readonly" name="txt_itotcost">
                                    </td>
                                  </tr>
                                  <tr> 
                                    <td>Animal Cost (II Batch)</td>
                                    <td>
                                      <input type="text" value="<%=Helper.formatDoubleValue(IIcost)%>"  style="text-align:right" readOnly="readonly" size="10" maxlength="9" name="txt_iicost">
                                      &nbsp;</td>
                                    <td>No of Animals</td>
                                    <td>
                                      <input type="text" value="<%=IIanimal%>" readOnly="readonly" size="10" maxlength="9" name="txt_iino">
                                    </td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>Total Cost</td>
                                    <td><input type="text" value="<%=Helper.formatDoubleValue(IItotcost)%>" 
										style="text-align:right" size="10" maxlength="9" readOnly="readonly" name="txt_iitotcost"></td>
                                  </tr>
                                  <tr> 
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                    <td><b>Cost of Animals</b></td>
                                    <td><input type="text" value="<%=Helper.formatDoubleValue(Itotcost+IItotcost)%>" 
										style="text-align:right" size="10" maxlength="9" readOnly="readonly" name="txt_totcost"></td>
                                  </tr>
                                  <tr> 
                                    <td> Working Capital Requirement&nbsp;(if required)</td>
                                    <td> 
                                      <select name="sel_workcapital" onChange="dispworkcapital()">
                                        <option value="1">Required</option>
                                        <option value="2" selected="selected">Not Required</option>
                                      </select>
                                      </td>
                                    <td id="f5">Cost of Maintenance(No of Months)</td>
                                    <td id="f6"> 
                                      <select name="txt_maintcost" onChange="feedcostmeth()">
                                        <option value="0" selected="selected"> --Select-- 
                                        </option>
                                        <option value="1">1</option>
                                        <option value="2">2</option>
                                        <option value="3">3</option>
                                      </select>
                                      </td>
                                    <td id="f7">Feeding Cost</td>
                                    <td colspan="3" id="f8"> 
                                      <lapschoice:CurrencyTag name="txt_feed"
													value='<%=Helper.correctNull((String)hshValues.get("feed"))%>'
													size="10" maxlength="9" onKeyPress="allowNumber(this)" />
													
                                      &nbsp; 
                                      &nbsp;&nbsp;<b>(Cost 
                                      of Maintenance in Days) x (First  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
									  Batch No of Animals) x (To Cost of  &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Feeding Laction Days)</b></td>
                                  </tr>
                                </table>
										</td>
									</tr>
								</table>
								</td>
							</tr>							
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		
      </td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>

<br>
<lapschoice:agrihiddentag pageid="<%=PageId%>"/>
<input type="hidden" name="sel_calves_text">
<input type="hidden" name="sel_gober_text">
<input type="hidden" name="sel_workcapital_text">
<input type="hidden" name="hidAuditFlag" value="<%=Helper.correctNull((String)hshValues.get("auditFlag"))%>"> 
</form>
</body>
</html>
