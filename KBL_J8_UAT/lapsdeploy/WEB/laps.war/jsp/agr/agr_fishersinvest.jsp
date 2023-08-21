<%@include file="../share/directives.jsp"%>
<%
	ArrayList vecCol = new ArrayList();
	vecCol = (ArrayList) hshValues.get("vecData");
	int vsize = 0;
	if (vecCol != null) 
	{
		vsize = vecCol.size();
	}
	String schemetype = Helper.correctNull((String) request.getParameter("schemetype"));
%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<title>Fisheries Investment</title>


<script>
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var ownership_type= "<%=Helper.correctNull((String)hshValues.get("ownership_type"))%>"
var boat_type= "<%=Helper.correctNull((String)hshValues.get("boat_type"))%>"
var schemetype="<%=schemetype%>";
var appstatus="<%=Helper.correctNull((String)request.getParameter("appstatus"))%>";
function placevalues()
{
	if(ownership_type!="")
	{
		document.forms[0].sel_type.value=ownership_type;
	}
	if(boat_type!="")
	{
		document.forms[0].sel_boattype.value=boat_type;
	}
	<%
	ArrayList vecRow_val=new ArrayList();
	if(vecCol!=null && vecCol.size()!=0)
	{
		for(int i=0;i<3;i++)
		{
			vecRow_val=(ArrayList)vecCol.get(i);
	%>
		document.forms[0].txt_type<%=i+1%>.value=<%=vecRow_val.get(0)%>;
	<%
		}
	}
	%>
  	disableFields(true);
 	Tankparameter();
 	boatparameter();
 	tankOwned();
 	costTotal();
 	//loanTotal();
 	//marginTotal();
 	document.all.sel_scheme.disabled=false;
	document.all.sel_scheme.value=schemetype;
	if(appstatus=="Open/Pending")
	{
		if(document.forms[0].btnenable.value.toUpperCase()=="Y")
		{
	       callDisableControls(false,true,true,true, false);
		}
		else
		{
			callDisableControls(true,true,true,true, false);
		}
	}
	else
	{
		callDisableControls(true,true,true,true, false);
	}
}

function doSave()
{
	//if(document.forms[0].txt_type3.value!="3")
  //	{
    //	if(document.forms[0].txt_cost3.value == "" || document.forms[0].txt_cost3.value == "0.00")
	//	{
	//		ShowAlert('121','Estimated Cost for Net, Twins, Floats etc');
	//		document.forms[0].txt_cost3.focus();
	//		return;
	//	}
		//if(document.forms[0].txt_margin3.value == "" || document.forms[0].txt_margin3.value == "0.00")
		//{
		//	ShowAlert('121','Margin for Net, Twins, Floats etc');
		//	document.forms[0].txt_margin3.focus();
		//	return;
		//}
	//}
	/*if(document.forms[0].txt_type4.value == "" || document.forms[0].txt_type4.value == "0.00")
	{
		ShowAlert('121','Type for Fingerlings');
		document.forms[0].txt_type4.focus();
		return;
	}
	if(document.forms[0].txt_cost4.value == "" || document.forms[0].txt_cost4.value == "0.00")
	{
		ShowAlert('121','Estimated Cost for Fingerlings');
		document.forms[0].txt_cost4.focus();
		return;
	}
	if(document.forms[0].txt_margin4.value == "" || document.forms[0].txt_margin4.value == "0.00")
	{
		ShowAlert('121','Margin for Fingerlings');
		document.forms[0].txt_margin4.focus();
		return;
	}
	if(document.forms[0].txt_type5.value == "" || document.forms[0].txt_type5.value == "0.00")
	{
		ShowAlert('121','Type for Fish Feed');
		document.forms[0].txt_type5.focus();
		return;
	}
	if(document.forms[0].txt_cost5.value == "" || document.forms[0].txt_cost5.value == "0.00")
	{
		ShowAlert('121','Estimated Cost for Fish Feed');
		document.forms[0].txt_cost5.focus();
		return;
	}
	if(document.forms[0].txt_margin5.value == "" || document.forms[0].txt_margin5.value == "0.00")
	{
		ShowAlert('121','Margin for Fish Feed');
		document.forms[0].txt_margin5.focus();
		return;
	}*/

var len = document.forms[0].txt_type1.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type1.options[i].selected==true)
		 {
			 document.forms[0].txt_type1_text.value = document.forms[0].txt_type1.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].txt_type2.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type2.options[i].selected==true)
		 {
			 document.forms[0].txt_type2_text.value = document.forms[0].txt_type2.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].txt_type3.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type3.options[i].selected==true)
		 {
			 document.forms[0].txt_type3_text.value = document.forms[0].txt_type3.options[i].text; 
			break;
		 }
	}  
	var len = document.forms[0].sel_type.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_type.options[i].selected==true)
			 {
				 document.forms[0].sel_type_text.value = document.forms[0].sel_type.options[i].text; 
				break;
			 }
		}  
		
		var len = document.forms[0].sel_boattype.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_boattype.options[i].selected==true)
			 {
				 document.forms[0].sel_boattype_text.value = document.forms[0].sel_boattype.options[i].text; 
				break;
			 }
		}  
		document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="fishersinvest";
	document.forms[0].hidBeanMethod.value="updatefishersinvest";
	document.forms[0].hidBeanGetMethod.value="getfishersinvest";
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidSourceUrl.value="/action/agr_fishersinvest.jsp";
	document.forms[0].submit();
	}
 		
function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidBeanGetMethod.value="getfishersinvest";
		document.forms[0].action=appURL+"action/agr_fishersinvest.jsp";
		document.forms[0].submit();
	}
}
		 
function doDelete()
{

var len = document.forms[0].txt_type1.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type1.options[i].selected==true)
		 {
			 document.forms[0].txt_type1_text.value = document.forms[0].txt_type1.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].txt_type2.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type2.options[i].selected==true)
		 {
			 document.forms[0].txt_type2_text.value = document.forms[0].txt_type2.options[i].text; 
			break;
		 }
	}
	var len = document.forms[0].txt_type3.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].txt_type3.options[i].selected==true)
		 {
			 document.forms[0].txt_type3_text.value = document.forms[0].txt_type3.options[i].text; 
			break;
		 }
	}  
	var len = document.forms[0].sel_type.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_type.options[i].selected==true)
			 {
				 document.forms[0].sel_type_text.value = document.forms[0].sel_type.options[i].text; 
				break;
			 }
		}  
		
		var len = document.forms[0].sel_boattype.length;	
		for(i=0;i<len;i++)
		{
			 if(document.forms[0].sel_boattype.options[i].selected==true)
			 {
				 document.forms[0].sel_boattype_text.value = document.forms[0].sel_boattype.options[i].text; 
				break;
			 }
		} 
		
	if( ConfirmMsg(101))
	{
		document.forms[0].hidAction.value="delete";
		document.forms[0].hidBeanId.value="fishersinvest";
		document.forms[0].hidBeanMethod.value="updatefishersinvest";
		document.forms[0].hidBeanGetMethod.value="getfishersinvest";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidSourceUrl.value="/action/agr_fishersinvest.jsp";
		document.forms[0].submit();
	}
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
		 
function doEdit()
{
	document.forms[0].hidAction.value="update";
	disableFields(false);
	callDisableControls(true,false,false,false, true);
	if(document.forms[0].txt_type1.value=="3")
 	{
		document.forms[0].txt_cost1.readOnly=true;
	 	//document.forms[0].txt_margin1.readOnly=true;
	 	//document.forms[0].txt_loan1.readOnly=true;
	}
 	if(document.forms[0].txt_type2.value=="3")
	{
 		document.forms[0].txt_cost2.readOnly=true;
 		//document.forms[0].txt_margin2.readOnly=true;
 		//document.forms[0].txt_loan2.readOnly=true;
	}
	if(document.forms[0].txt_type3.value=="3")
	{
 		document.forms[0].txt_cost3.readOnly=true;
 		//document.forms[0].txt_margin3.readOnly=true;
 		//document.forms[0].txt_loan3.readOnly=true;
	}
}
		 
		 
		 
function callDisableControls(cmdEdit,cmdApply,cmdCancel,cmddelete,cmdClose)
{
		document.forms[0].cmdedit.disabled=cmdEdit;
		document.forms[0].cmdsave.disabled=cmdApply;
		document.forms[0].cmdcancel.disabled=cmdCancel;
		document.forms[0].cmddelete.disabled=cmddelete;
		document.forms[0].cmdclose.disabled=cmdClose;
}

function Tankparameter()
	{	
		
		if(document.forms[0].txt_type1.value=="1")
		{
			document.all.t1.style.visibility="visible";
			document.all.t1.style.position="relative";
			document.all.t2.style.visibility="visible";
			document.all.t2.style.position="relative";
			document.all.t3.style.visibility="visible";
			document.all.t3.style.position="relative";
			document.all.t4.style.visibility="visible";
			document.all.t4.style.position="relative";
			/*document.all.tw.style.visibility="visible";
			document.all.tw.style.position="relative";
			document.all.tw1.style.visibility="visible";
			document.all.tw1.style.position="relative";*/
			document.all.t5.style.visibility="visible";
			document.all.t5.style.position="relative";
			
			document.forms[0].txt_cost1.readOnly=false;
			//document.forms[0].txt_margin1.readOnly=false;
			//document.forms[0].txt_loan1.readOnly=false;
			
		}
		else if(document.forms[0].txt_type1.value=="2")
		{
			document.all.t1.style.visibility="visible";
			document.all.t1.style.position="relative";
			document.all.t2.style.visibility="visible";
			document.all.t2.style.position="relative";
			document.all.t3.style.visibility="visible";
			document.all.t3.style.position="relative";
			document.all.t4.style.visibility="visible";
			document.all.t4.style.position="relative";
			/*document.all.tw.style.visibility="visible";
			document.all.tw.style.position="relative";
			document.all.tw1.style.visibility="visible";
			document.all.tw1.style.position="relative";*/
			document.all.t5.style.visibility="visible";
			document.all.t5.style.position="relative";
			
			
			document.forms[0].txt_cost1.readOnly=false;
			//document.forms[0].txt_margin1.readOnly=false;
			//document.forms[0].txt_loan1.readOnly=false;
			
			
			
		}
		else if(document.forms[0].txt_type1.value=="3")
		{
			document.all.t1.style.visibility="hidden";
			document.all.t1.style.position="absolute";
			document.all.t2.style.visibility="hidden";
			document.all.t2.style.position="absolute";
			document.all.t3.style.visibility="hidden";
			document.all.t3.style.position="absolute";
			document.all.t4.style.visibility="hidden";
			document.all.t4.style.position="absolute";
			document.all.tw.style.visibility="hidden";
			document.all.tw.style.position="absolute";
			document.all.tw1.style.visibility="hidden";
			document.all.tw1.style.position="absolute";
			document.all.tr.style.visibility="hidden";
			document.all.tr.style.position="absolute";
			document.all.tr1.style.visibility="hidden";
			document.all.tr1.style.position="absolute";
			document.all.t5.style.visibility="hidden";
			document.all.t5.style.position="absolute";
			document.forms[0].sel_type.value="1";
			document.forms[0].txt_lease.value="";
			document.forms[0].txt_lengthtank.value="";
			document.forms[0].txt_breathtank.value="";
			document.forms[0].txt_normaltank.value="";
			document.forms[0].txt_depthtank.value="";
			document.forms[0].txt_summertank.value="";
			document.forms[0].txt_cost1.value="";
			//document.forms[0].txt_margin1.value="";
			//document.forms[0].txt_loan1.value="";
			document.forms[0].txt_rent.value="";
			document.forms[0].txt_cost1.readOnly=true;
			//document.forms[0].txt_margin1.readOnly=true;
			//document.forms[0].txt_loan1.readOnly=true;
			
		}
		
	}

function boatparameter()	 
{
	if(document.forms[0].txt_type2.value=="1")
	{
		document.all.b1.style.visibility="visible";
		//document.all.b1.style.position="relative";
		document.all.b2.style.visibility="visible";
		//document.all.b2.style.position="relative";
		document.all.b3.style.visibility="visible";
		//document.all.b3.style.position="relative";
		document.all.b4.style.visibility="visible";
		//document.all.b4.style.position="relative";
		document.all.b5.style.visibility="visible";
		//document.all.b5.style.position="relative";
		
		document.forms[0].txt_cost2.readOnly=false;
		//document.forms[0].txt_margin2.readOnly=false;
		//document.forms[0].txt_loan2.readOnly=false;
	}
	else if(document.forms[0].txt_type2.value=="2")
	{
		document.all.b1.style.visibility="visible";
		//document.all.b1.style.position="relative";
		document.all.b2.style.visibility="visible";
		//document.all.b2.style.position="relative";
		document.all.b3.style.visibility="visible";
		//document.all.b3.style.position="relative";
		document.all.b4.style.visibility="visible";
		//document.all.b4.style.position="relative";
		document.all.b5.style.visibility="visible";
		//document.all.b5.style.position="relative";
				
		document.forms[0].txt_cost2.readOnly=false;
		//document.forms[0].txt_margin2.readOnly=false;
		//document.forms[0].txt_loan2.readOnly=false;
	}
	else if(document.forms[0].txt_type2.value=="3")
	{
		document.all.b1.style.visibility="hidden";
		//document.all.b1.style.position="absolute";
		document.all.b2.style.visibility="hidden";
		//document.all.b2.style.position="absolute";
		document.all.b3.style.visibility="hidden";
		//document.all.b3.style.position="absolute";
		document.all.b4.style.visibility="hidden";
		//document.all.b4.style.position="absolute";
		document.all.b5.style.visibility="hidden";
		//document.all.b5.style.position="absolute";
		document.forms[0].txt_lengthboat.value="";
		document.forms[0].txt_breathboat.value="";
		document.forms[0].txt_capacityboat.value="";
		document.forms[0].txt_cost2.value="";
		//document.forms[0].txt_margin2.value="";
		//document.forms[0].txt_loan2.value="";
					
		document.forms[0].txt_cost2.readOnly=true;
		//document.forms[0].txt_margin2.readOnly=true;
		//document.forms[0].txt_loan2.readOnly=true;
		
	}
}

function  tankOwned()
{
	if(document.forms[0].sel_type.value=="2" || document.forms[0].sel_type.value=="3")
	{
		document.all.tw.style.visibility="visible";
		document.all.tw.style.position="relative";
		document.all.tw1.style.visibility="visible";
		document.all.tw1.style.position="relative";
		document.all.tr.style.visibility="visible";
		document.all.tr.style.position="relative";
		document.all.tr1.style.visibility="visible";
		document.all.tr1.style.position="relative";
	}
	if(document.forms[0].sel_type.value=="1")
	{
		document.all.tw.style.visibility="hidden";
		document.all.tw.style.position="absolute";
		document.all.tw1.style.visibility="hidden";
		document.all.tw1.style.position="absolute";
		document.all.tr.style.visibility="hidden";
		document.all.tr.style.position="absolute";
		document.all.tr1.style.visibility="hidden";
		document.all.tr1.style.position="absolute";
	}
}

function NTF()
{
	if(document.forms[0].txt_type3.value=="3")
	{
		document.forms[0].txt_cost3.value="";
		//document.forms[0].txt_margin3.value="";
		//document.forms[0].txt_loan3.value="";
		document.forms[0].txt_cost3.readOnly=true;
		//document.forms[0].txt_margin3.readOnly=true;
		//document.forms[0].txt_loan3.readOnly=true;
	}
	else
	{
		document.forms[0].txt_cost3.readOnly=false;
	//	document.forms[0].txt_margin3.readOnly=false;
		//document.forms[0].txt_loan3.readOnly=false;
	}
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
	}
	//document.forms[0].txt_loan1.readOnly=true;
	//document.forms[0].txt_loan2.readOnly=true;
	//document.forms[0].txt_loan3.readOnly=true;
	//document.forms[0].txt_loan4.readOnly=true;
	//document.forms[0].txt_loan5.readOnly=true;
	//document.forms[0].txt_loan6.readOnly=true;
	//document.forms[0].txt_loanamt.readOnly=true;
}
function costTotal()
{
	var total=0.00;
	var cost1=document.forms[0].txt_cost1.value;
	var cost2=document.forms[0].txt_cost2.value;
	var cost3=document.forms[0].txt_cost3.value;
	var cost4=document.forms[0].txt_cost4.value;
	var cost5=document.forms[0].txt_cost5.value;
	var cost6=document.forms[0].txt_cost6.value;
	if(cost1=="")
	{
		cost1=0.00;
	}
	if(cost2=="")
	{
		cost2=0.00;
	}
	if(cost3=="")
	{
		cost3=0.00;
	}
	if(cost4=="")
	{
		cost4=0.00;
	}
	if(cost5=="")
	{
		cost5=0.00;
	}
	if(cost6=="")
	{
		cost6=0.00;
	}
	total=eval(total)+eval(cost1)+eval(cost2)+eval(cost3)+eval(cost4)+eval(cost5)+eval(cost6);
	
	document.forms[0].txt_estimatecost.value=NanNumber(total);
	roundtxt(document.forms[0].txt_estimatecost);
	roundtxt(document.forms[0].txt_cost1);
	roundtxt(document.forms[0].txt_cost2);
	roundtxt(document.forms[0].txt_cost3);
	roundtxt(document.forms[0].txt_cost4);
	roundtxt(document.forms[0].txt_cost5);
	roundtxt(document.forms[0].txt_cost6);
	
	
	
	
	
}
function loanTotal()
{
//	var total=0.00;
//	var loan1=document.forms[0].txt_loan1.value;
//	var loan2=document.forms[0].txt_loan2.value;
//	var loan3=document.forms[0].txt_loan3.value;
//	var loan4=document.forms[0].txt_loan4.value;
//	var loan5=document.forms[0].txt_loan5.value;
//	var loan6=document.forms[0].txt_loan6.value;
//	if(loan1=="")
//	{
//		loan1=0.00;
//	}
//	if(loan2=="")
//	{
//		loan2=0.00;
//	}
//	if(loan3=="")
//	{
//		loan3=0.00;
//	}
//	if(loan4=="")
//	{
//		loan4=0.00;
///	}
//	if(loan5=="")
//	{
//		loan5=0.00;
//	}
//	if(loan6=="")
//	{
//		loan6=0.00;
//	}
	total=eval(total)+eval(loan1)+eval(loan2)+eval(loan3)+eval(loan4)+eval(loan5)+eval(loan6);
	
	document.forms[0].txt_loanamt.value=NanNumber(total);
	roundtxt(document.forms[0].txt_loanamt);
	//roundtxt(document.forms[0].txt_loan1);
	//roundtxt(document.forms[0].txt_loan2);
	//roundtxt(document.forms[0].txt_loan3);
	//roundtxt(document.forms[0].txt_loan4);
	//roundtxt(document.forms[0].txt_loan5);
	//roundtxt(document.forms[0].txt_loan6);
	
}
function marginTotal()
{
	var total=0.00;
	var margin1=document.forms[0].txt_margin1.value;
	var margin2=document.forms[0].txt_margin2.value;
	var margin3=document.forms[0].txt_margin3.value;
	var margin4=document.forms[0].txt_margin4.value;
	var margin5=document.forms[0].txt_margin5.value;
	var margin6=document.forms[0].txt_margin6.value;
	if(margin1=="")
	{
		margin1=0.00;
	}
	if(margin2=="")
	{
		margin2=0.00;
	}
	if(margin3=="")
	{
		margin3=0.00;
	}
	if(margin4=="")
	{
		margin4=0.00;
	}
	if(margin5=="")
	{
		margin5=0.00;
	}
	if(margin6=="")
	{
		margin6=0.00;
	}
	total=eval(total)+eval(margin1)+eval(margin2)+eval(margin3)+eval(margin4)+eval(margin5)+eval(margin6);
	
	document.forms[0].txt_totalmargin.value=NanNumber(total);
	roundtxt(document.forms[0].txt_totalmargin);
	//roundtxt(document.forms[0].txt_loan1);
	//roundtxt(document.forms[0].txt_loan2);
	//roundtxt(document.forms[0].txt_loan3);
	//roundtxt(document.forms[0].txt_loan4);
	//roundtxt(document.forms[0].txt_loan5);
	//roundtxt(document.forms[0].txt_loan6);
//	roundtxt(document.forms[0].txt_margin1);
//	roundtxt(document.forms[0].txt_margin2);
//	roundtxt(document.forms[0].txt_margin3);
//	roundtxt(document.forms[0].txt_margin4);
//	roundtxt(document.forms[0].txt_margin5);
//	roundtxt(document.forms[0].txt_margin6);
	
	
	
	
}
function totalamount()
{
	var total=0.00;
	var cost1=document.forms[0].txt_cost1.value;
	var cost2=document.forms[0].txt_cost2.value;
	var cost3=document.forms[0].txt_cost3.value;
	var cost4=document.forms[0].txt_cost4.value;
	var cost5=document.forms[0].txt_cost5.value;
	var cost6=document.forms[0].txt_cost6.value;
	var totalcost=document.forms[0].txt_estimatecost.value;
	
	var loan1=0.00;
	var loan2=0.00;
	var loan3=0.00;
	var loan4=0.00;
	var loan5=0.00;
	var loan6=0.00;
	var totalloan=0.00;
	
	if(cost1=="")
	{
		cost1=0.00;
	}
	if(cost2=="")
	{
		cost2=0.00;
	}
	if(cost3=="")
	{
		cost3=0.00;
	}
	if(cost4=="")
	{
		cost4=0.00;
	}
	if(cost5=="")
	{
		cost5=0.00;
	}
	if(cost6=="")
	{
		cost6=0.00;
	}
	if(totalcost=="")
	{
		totalcost=0.00;
	}
	
	/*if(loan1=="")
	{
		loan1=0.00;
	}
	if(loan2=="")
	{
		loan2=0.00;
	}
	if(loan3=="")
	{
		loan3=0.00;
	}
	if(loan4=="")
	{
		loan4=0.00;
	}
	if(loan5=="")
	{
		loan5=0.00;
	}
	if(loan6=="")
	{
		loan6=0.00;
	}*/
	//var margin1= document.forms[0].txt_margin1.value;
	//var margin2= document.forms[0].txt_margin2.value;
	//var margin3= document.forms[0].txt_margin3.value;
	//var margin4= document.forms[0].txt_margin4.value;
	//var margin5= document.forms[0].txt_margin5.value;
	//var margin6= document.forms[0].txt_margin6.value;
	//var totalmargin= document.forms[0].txt_totalmargin.value;
	//if(margin1=="")
	//{
	//	margin1=0.00;
	//}
	//if(margin2=="")
	//{
	//	margin2=0.00;
	//}
	//if(margin3=="")
	//{
	//	margin3=0.00;
	//}
	//if(margin4=="")
	//{
	//	margin4=0.00;
	//}
	//if(margin5=="")
	//{
	//	margin5=0.00;
	//}
	//if(margin6=="")
	//{
	//	margin6=0.00;
	//}
	//if(totalmargin=="")
	//{
	//	totalmargin=0.00;
	//}
	//loan1=eval(cost1)-eval(margin1);
	//loan2=eval(cost2)-eval(margin2);
	//loan3=eval(cost3)-eval(margin3);
	//loan4=eval(cost4)-eval(margin4);
	//loan5=eval(cost5)-eval(margin5);
	//loan6=eval(cost6)-eval(margin6);
	//totalloan=eval(totalcost)-eval(totalmargin);
	// document.forms[0].txt_loan1.value=loan1;
	//document.forms[0].txt_loan2.value=loan2;
	//document.forms[0].txt_loan3.value=loan3;
	//document.forms[0].txt_loan4.value=loan4;
	//document.forms[0].txt_loan5.value=loan5;
	//document.forms[0].txt_loan6.value=loan6;
	//document.forms[0].txt_loanamt.value=totalloan
	//roundtxt(document.forms[0].txt_margin1);
	////roundtxt(document.forms[0].txt_margin2);
	//roundtxt(document.forms[0].txt_margin3);
	///roundtxt(document.forms[0].txt_margin4);
	//roundtxt(document.forms[0].txt_margin5);
	//roundtxt(document.forms[0].txt_margin6);
	//roundtxt(document.forms[0].txt_loanamt);
}

function typeFieldsClearing()
{
if(document.forms[0].txt_lease)
document.forms[0].txt_lease.value="";
if(document.forms[0].txt_rent)
 document.forms[0].txt_rent.value="";
}

</script>
</head>
<body class="bgcolor" onload="placevalues()">
<form name="appform" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0" class="outertable">
	<tr>
		<td valign="top">
		<jsp:include page="../share/applurllinkscom.jsp" flush="true">
			<jsp:param name="pageid" value="999" />
			<jsp:param name="cattype" value="<%=strCategoryType%>" />
			<jsp:param name="ssitype" value="<%=strSSIType%>" />
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr>
      <td class="page_flow"> Home -> Agriculture ->  Fisheries Investment </td>
      
	</tr>
</table>
<lapschoice:borrowertype /> 
<lapschoice:application />

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td><jsp:include page="../agr/Applurllinkagr.jsp" flush="true">
			<jsp:param name="pageid" value="202" />
			<jsp:param name="pageid" value="<%=schemetype%>"/>
		</jsp:include></td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
	<tr> 
    	<td valign="top"> 
        	<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
                <tr> 
                	<td valign="top"> 
						<table width="100%" border="0" cellpadding="3" cellspacing="1" align="center" class="outertable">
	<tr class="dataheader">
		<td><strong>Particulars </strong></td>
		<td><strong>Type</strong></td>
		
<!--		<td><strong>Margin in Rs. </strong></td>-->
<!--		<td><strong>Loan Amount</strong></td>-->
	</tr>
	<%if (vsize > 0) {
				ArrayList vecRow1 = new ArrayList();
				ArrayList vecRow2 = new ArrayList();
				ArrayList vecRow3 = new ArrayList();
				ArrayList vecRow4 = new ArrayList();
				ArrayList vecRow5 = new ArrayList();
				ArrayList vecRow6 = new ArrayList();

				for (int i = 0; i < vsize; i++) {

					vecRow1 = (ArrayList) vecCol.get(0);

					vecRow2 = (ArrayList) vecCol.get(1);
					vecRow3 = (ArrayList) vecCol.get(2);
					vecRow4 = (ArrayList) vecCol.get(3);
					vecRow5 = (ArrayList) vecCol.get(4);
					vecRow6 = (ArrayList) vecCol.get(5);
				}

				%>
	<tr>
		<td>Tank</td>
		<td><select name="txt_type1" size="1" onChange="Tankparameter()" tabindex="1">
			<option value="1">Construction</option>
			<option value="2">Renovation</option>
			<option value="3" selected>Not Applicable</option>
		</select></td>
		
      <td>
        <input type="hidden" name="txt_cost1" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow1.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="2">
      </td>
<!--		<td><input type="text" name="txt_margin1" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow1.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="3"></td>-->
<!--		<td><input type="text" name="txt_loan1" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow1.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>Boats</td>
		<td><select name="txt_type2" size="1" onChange="boatparameter()"
			onBlur="costTotal()" tabindex="4">
			<option value="1">Mechanised</option>
			<option value="2">Non Mechanised</option>
			<option value="3" selected>Not Applicable</option>
		</select></td>
		<td><input type="hidden" name="txt_cost2" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow2.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="5"></td>
<!--		<td><input type="text" name="txt_margin2" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow2.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="6"></td>-->
<!--		<td><input type="text" name="txt_loan2" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow2.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>Net, Twins, Floats etc</td>
		<td><select name="txt_type3" size="1" onChange="NTF()" tabindex="7">
			<option value="1">Cotton</option>
			<option value="2">Nylon</option>
			<option value="3" selected="selected">Not Applicable</option>
		</select></td>
		<td><input type="hidden" name="txt_cost3" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow3.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="8"></td>
<!--		<td><input type="text" name="txt_margin3" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow3.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="9"></td>-->
<!--		<td><input type="text" name="txt_loan3" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow3.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>Fingerlings<b> <!-- <font size="1" face="MS Sans Serif" color="#FF0000">*</font> --></b></td>
		<td><input type="text" name="txt_type4" size="20"
			value="<%=vecRow4.get(0) %>" maxlength="100" tabindex="10"></td>
		<td><input type="hidden" name="txt_cost4" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow4.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="11"></td>
<!--		<td><input type="text" name="txt_margin4" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow4.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="12"></td>-->
<!--		<td><input type="text" name="txt_loan4" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow4.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>Fish Feed<b> <!--<font size="1" face="MS Sans Serif" color="#FF0000">*</font>--></b></td>
		<td><input type="text" name="txt_type5" size="20"
			value="<%=vecRow5.get(0) %>" maxlength="100" tabindex="13"></td>
		<td><input type="hidden" name="txt_cost5" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow5.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="14"></td>
<!--		<td><input type="text" name="txt_margin5" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow5.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="15"></td>-->
<!--		<td><input type="text" name="txt_loan5" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow5.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>Maintanence &amp; Other Charges</td>
		<td><input type="text" name="txt_type6" size="20"
			value="<%=vecRow6.get(0) %>" maxlength="100" tabindex="16"></td>
		<td><input type="hidden" name="txt_cost6" size="20" maxlength="8"
			style="text-align:right" value="<%=vecRow6.get(1) %>"
			onKeyPress="allowNumber(this)" onBlur="costTotal();totalamount()" tabindex="17"></td>
<!--		<td><input type="text" name="txt_margin6" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow6.get(2) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="marginTotal();totalamount()" tabindex="18"></td>-->
<!--		<td><input type="text" name="txt_loan6" size="20" maxlength="8"-->
<!--			style="text-align:right" value="<%=vecRow6.get(3) %>"-->
<!--			onKeyPress="allowNumber(this)" onBlur="loanTotal()"></td>-->
	</tr>
	<tr>
		<td>&nbsp;</td>
		<td><b>Total</b></td>
		<td><input type="hidden" name="txt_estimatecost" size="20" maxlength="8"
			style="text-align:right" onBlur="costTotal()"></td>
<!--		<td><input type="text" name="txt_totalmargin" size="20" maxlength="8"-->
<!--			style="text-align:right" onBlur="costTotal()"></td>-->
<!--		<td><input type="text" name="txt_loanamt" size="20" maxlength="8"-->
<!--			style="text-align:right" onBlur="loanTotal()"></td>-->
	</tr>
	<%} else {

			%>

	<tr>
		<td>Tank</td>
		<td><select name="txt_type1" size="1" onChange="Tankparameter()" tabindex="1">
			<option value="1">Construction</option>
			<option value="2">Renovation</option>
			<option value="3" selected>Not Applicable</option>
		</select></td>
		<td><input type="hidden" name="txt_cost1" size="20" maxlength="8"
			style="text-align:right" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="2"></td>

<!--		<td><input type="text" name="txt_margin1" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="3"></td>-->
<!--		<td><input type="text" name="txt_loan1" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"></td>-->
	</tr>
	<tr>
		<td>Boats</td>
		<td><select name="txt_type2" size="1" onChange="boatparameter()" tabindex="4">
          <option value="1">Mechanised</option>
          <option value="2">Non Mechanised</option>
          <option value="3" selected>Not Applicable</option>
        </select></td>
		<td><input type="hidden" name="txt_cost2" size="20" maxlength="8"
			style="text-align:right" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="5"></td>
<!--		<td><input type="text" name="txt_margin2" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="6"></td>-->
<!--		<td><input type="text" name="txt_loan2" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"></td>-->
	</tr>
	<tr>
		<td>Net, Twins, Floats etc<b><font size="1" face="MS Sans Serif"
			color="#FF0000">*</font></b></td>
		<td><select name="txt_type3" size="1" onChange="NTF()" tabindex="7">
          <option value="1">Cotton</option>
          <option value="2">Nylon</option>
          <option value="3" selected>Not Applicable</option>
        </select></td>
		<td><input type="hidden" name="txt_cost3" size="20" maxlength="8"
			style="text-align:right" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="8"></td>
<!--		<td><input type="text" name="txt_margin3" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="9"></td>-->
<!--		<td><input type="text" name="txt_loan3" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"></td>-->
	</tr>
	<tr>
		<td>Fingerlings<b> <!-- <font size="1" face="MS Sans Serif" color="#FF0000">*</font> --></b></td>
		<td><input type="text" name="txt_type4" size="20" maxlength="100" tabindex="10"></td>
		<td><input type="hidden" name="txt_cost4" size="20"
			style="text-align:right" maxlength="8" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="11"></td>
<!--		<td><input type="text" name="txt_margin4" size="20"-->
<!--			style="text-align:right" maxlength="8" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="12"></td>-->
<!--		<td><input type="text" name="txt_loan4" size="20"-->
<!--			style="text-align:right" maxlength="8" onKeyPress="allowNumber(this)"></td>-->
	</tr>
	<tr>
		<td>Fish Feed<b> <!--<font size="1" face="MS Sans Serif" color="#FF0000">*</font>--></b></td>
		<td><input type="text" name="txt_type5" size="20" maxlength="100" tabindex="13"></td>
		<td><input type="hidden" name="txt_cost5" size="20" maxlength="8"
			style="text-align:right" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="14"></td>
<!--		<td><input type="text" name="txt_margin5" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="15"></td>-->
<!--		<td><input type="text" name="txt_loan5" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)" ></td>-->
	</tr>
	<tr>
		<td>Maintanence &amp; Other Charges</td>
		<td><input type="text" name="txt_type6" size="20" maxlength="100" tabindex="16"></td>
		<td><input type="hidden" name="txt_cost6" size="20" maxlength="8"
			style="text-align:right" onKeyPress="allowNumber(this)"
			onBlur="costTotal();totalamount()" tabindex="17"></td>
<!--		<td><input type="text" name="txt_margin6" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"-->
<!--			onBlur="marginTotal();totalamount()" tabindex="18"></td>-->
<!--		<td><input type="text" name="txt_loan6" size="20" maxlength="8"-->
<!--			style="text-align:right" onKeyPress="allowNumber(this)"></td>-->
	</tr>
	<tr>
		<td>&nbsp;</td>
		
		<td><input type="hidden" name="txt_estimatecost" size="20"
			style="text-align:right" maxlength="8"></td>
<!--		<td><input type="text" name="txt_totalmargin" size="20" maxlength="8"-->
<!--			style="text-align:right" onBlur="costTotal()"></td>-->
<!--		<td><input type="text" name="txt_loanamt" size="20"-->
<!--			style="text-align:right" maxlength="8"></td>-->
	</tr>
	<%}

			%>
</table>
<table class="outertable">
	<tr>
		<td id="t1"><strong>Tank Parameters</strong></td>
	</tr>
	<tr id="t5">
		<td>Type of ownership</td>
		<td><select name="sel_type" size="1"
			onChange="tankOwned();typeFieldsClearing()" tabindex="19">
			<option value="1">Owned</option>
			<option value="2">Leased</option>
			<option value="3">Rented</option>
		</select></td>
		<td id="tw">Agreement Period</td>
		<td id="tw1"><input type="text" name="txt_lease" size="20"
			maxlength="8" onKeyPress="allowNumber(this)" tabindex="20"
			value="<%=Helper.correctNull((String)hshValues.get("lease_period"))%>">
		</td>

		<td id="tr">(yrs),</td>
		<td id="tr1">&nbsp;&nbsp;Rent/Year<lapschoice:CurrencyTag name="txt_rent"
			size="20" maxlength="8" tabindex="21"
			value='<%=Helper.correctNull((String)hshValues.get("tank_rent_year"))%>' />
		</td>
	</tr>
	<tr id="t2">
		<td>Length</td>
		<td><input type="text" name="txt_lengthtank" size="20" maxlength="25"
			onKeyPress="allowAlphaNumeric(this)" tabindex="22"
			value="<%=Helper.correctNull((String)hshValues.get("tank_length"))%>">
		</td>
		<td>Level of Water</td>
	</tr>
	<tr id="t3">
		<td>Breath</td>
		<td><input type="text" name="txt_breathtank" size="20" maxlength="25"
			onKeyPress="allowAlphaNumeric(this)" tabindex="23"
			value="<%=Helper.correctNull((String)hshValues.get("tank_breath"))%>">
		</td>
		<td>Normal Days</td>
		<td><input type="text" name="txt_normaltank" size="20" maxlength="25"
			onKeyPress="allowAlphaNumeric(this)" tabindex="24"
			value="<%=Helper.correctNull((String)hshValues.get("normal_water_level"))%>">
		</td>
	</tr>
	<tr id="t4">
		<td>Depth</td>
		<td><input type="text" name="txt_depthtank" size="20" maxlength="25"
			onKeyPress="allowAlphaNumeric(this)" tabindex="25"
			value="<%=Helper.correctNull((String)hshValues.get("tank_debth"))%>">
		</td>
		<td>Summer Days</td>
		<td><input type="text" name="txt_summertank" size="20" maxlength="25"
			onKeyPress="allowAlphaNumeric(this)" tabindex="26"
			value="<%=Helper.correctNull((String)hshValues.get("summar_water_level"))%>">
		</td>
	</tr>
</table>
<table class="outertable">
	<tr id="b1">
		<td><strong>Boat Parameters</strong></td>
	</tr>
	<tr id="b2">
		<td>Purpose of Boat Loan</td>
		<td><select name="sel_boattype" size="1" tabindex="27">
			<option value="1">New</option>
			<option value="2">Existing</option>
			<option value="3">Repair</option>
		</select></td>
	</tr>
	<tr id="b3">
		<td>Length</td>
		<td><input type="text" name="txt_lengthboat" size="20" maxlength="25"
			onKeyPress="" tabindex="28"
			value="<%=Helper.correctNull((String)hshValues.get("boat_length"))%>"></td>
	</tr>
	<tr id="b4">
		<td>Breath</td>
		<td><input type="text" name="txt_breathboat" size="20" maxlength="25"
			onKeyPress="" tabindex="29"
			value="<%=Helper.correctNull((String)hshValues.get("boat_breath"))%>"></td>
	</tr>
	<tr id="b5">
		<td>Capacity of catches</td>
		<td><input type="text" name="txt_capacityboat" size="20"
			maxlength="25" onKeyPress="" tabindex="30"
			value="<%=Helper.correctNull((String)hshValues.get("boat_catch_capacity"))%>"></td>
	</tr>
</table>
</td>
</tr>
</table>
</td>
</tr>
</table>
<br/>
<lapschoice:combuttonnew btnnames="Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>'/>
<input type="hidden" name="txt_type1_text" value="">
<input type="hidden" name="txt_type2_text" value="">
<input type="hidden" name="txt_type3_text" value="">
<input type="hidden" name="sel_type_text" value="">
<input type="hidden" name="sel_boattype_text" value="">
<lapschoice:hiddentag pageid="<%=PageId%>"/>
</form>
</body>
</html>
