<%@ page import="com.sai.laps.helper.*"%>
<%@ page import="java.util.*"%>
<%@ taglib prefix="lapschoice" uri="/WEB-INF/laps.tld"%>
<jsp:useBean id="hshValues" class="java.util.HashMap" scope="request" /> 
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />

<%if (objValues instanceof java.util.HashMap) {
				hshValues = (java.util.HashMap) objValues;
			}
			ArrayList vecData = new ArrayList();
			ArrayList vecRow = new ArrayList();
			int vecsize = 0;
			int vecsize1 = 0;
		
			String strapptype = "";
			String apptype = "";
			String app_status = Helper.correctNull((String) hshValues.get("app_status"));
			String PageType =Helper.correctNull((String)hshValues.get("PageType"));
%>
<%

String id="";
if (PageType.equalsIgnoreCase("C")) {
	id ="8";
} else{
	id="10";
}
ArrayList arryCol= new ArrayList();
ArrayList arryRow = new ArrayList();
arryRow=(ArrayList)hshValues.get("arryRow");

ArrayList arryCol1= new ArrayList();

if(arryRow == null)
{
	arryRow = new ArrayList();
}
String l1="",l2="",l3="",l4="",l5="",l6="",l7="",l8="",l9="",l10="",l11="",l12="",l_1="";
String f1 = "",f2="",f3="";
String f4 = "",f5="",f6="";
String f7= "",f8="",f9="";
String f10 = "",f11="",f12="",f_1="";
String q1 = "",q2="",q3="";
String q4 = "",q5="",q6="";
String q7= "",q8="",q9="";
String q10 = "",q11="",q12="",q_1="";
String m1 = "",m2="",m3="";
String m4 = "",m5="",m6="";
String m7= "",m8="",m9="";
String m10 = "",m11="",m12="",m_1="";
;
String p1 = "",p2="",p3="";
String p4 = "",p5="",p6="";
String p7= "",p8="",p9="";
String p10 = "",p11="",p12="",p_1="";
String r1 = "",r2="",r3="";
String r4 = "",r5="",r6="";
String r7= "",r8="",r9="";
String r10 = "",r11="",r12="",r_1="";
String d1 = "",d2="",d3="";
String d4 = "",d5="",d6="";
String d7= "",d8="",d9="";
String d10 = "",d11="",d12="",d_1="";
String c1 = "",c2="",c3="";
String c4 = "",c5="",c6="";
String c7= "",c8="",c9="";
String c10 = "",c11="",c12="",c_1="";
String e1 = "",e2="",e3="";
String e4 = "",e5="",e6="";
String e7= "",e8="",e9="";
String e10 = "",e11="",e12="",e_1="";
String g1 = "",g2="",g3="";
String g4 = "",g5="",g6="";
String g7= "",g8="",g9="";
String g10 = "",g11="",g12="",g_1="";
String h1 = "",h2="",h3="";
String h4 = "",h5="",h6="";
String h7= "",h8="",h9="";
String h10 = "",h11="",h12="",h_1="";
String j1 = "",j2="",j3="";
String j4 = "",j5="",j6="";
String j7= "",j8="",j9="";
String j10 = "",j11="",j12="",j_1="";
;
String k1 = "",k2="",k3="";
String k4 = "",k5="",k6="";
String k7= "",k8="",k9="";
String k10 = "",k11="",k12="",k_1="";
String o1 = "",o2="",o3="";
String o4 = "",o5="",o6="";
String o7= "",o8="",o9="",o11="",o12="",o_1="";
String o10 = "";String t1 = "",t2="",t3="";
String t4 = "",t5="",t6="";
String t7= "",t8="",t9="";
String t10 = "",t11="",t12="",t_1="";
java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance();
nf.setGroupingUsed(false);
nf.setMaximumFractionDigits(2);
nf.setMinimumFractionDigits(2);
%>
<html>
<head>
<title>LAPS -year loan Details</title>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script
	src="<%=ApplicationParams.getAppUrl()%>js/share/DateValidation.js"></script>
<script>
var appUrl = "<%=ApplicationParams.getAppUrl()%>";
var id ="";
var apptype="";
var varApptype=new Array();
var varAcctype=new Array();
var varAcctype1=new Array();
var currentDate = "<%=Helper.getCurrentDateTime()%>";
var  strid="<%=Helper.correctNull((String)hshValues.get("strid"))%>";
var  strAction="<%=Helper.correctNull((String)hshValues.get("strAction"))%>";

function enableButtons( bool2, bool3, bool4, bool5, bool6)
{
	
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmddel.disabled=bool5;
	document.forms[0].cmdclose.disabled = bool6;
}



function doClose()
{
	if( ConfirmMsg(100))
	{



		document.forms[0].action=appUrl+"action/"+"perresult.jsp";
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

function doSave()
{
     
		
	enableButtons( true, true, true, true, false);	
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="/action/agr_yearcostdetails.jsp";
	document.forms[0].hidBeanMethod.value="updateYearCostData";
	document.forms[0].hidBeanGetMethod.value="getYearCostData";
	document.forms[0].action=appUrl+"controllerservlet";
	document.forms[0].submit();
}

function doEdit()
{
 	disableFields(false);
	for(var i=0;i<14;i++)
	{
	document.forms[0].txt_totalcost1[i].readOnly=true;
 	document.forms[0].txt_totalloan1[i].readOnly=true;
	}
 	document.forms[0].txt_cost1[13].readOnly=true;
 	document.forms[0].txt_cost2[13].readOnly=true;
 	document.forms[0].txt_cost3[13].readOnly=true;
 	document.forms[0].txt_loan1[13].readOnly=true;
 	document.forms[0].txt_loan2[13].readOnly=true;
 	document.forms[0].txt_loan3[13].readOnly=true;
	document.forms[0].txt_cost4[13].readOnly=true;
 	document.forms[0].txt_loan4[13].readOnly=true;
 	document.forms[0].txt_cost5[13].readOnly=true;
 	document.forms[0].txt_loan5[13].readOnly=true;
 	document.forms[0].txt_cost6[13].readOnly=true;
 	document.forms[0].txt_loan6[13].readOnly=true;
	document.forms[0].txt_cost7[13].readOnly=true;
 	document.forms[0].txt_loan7[13].readOnly=true;
 
 	document.forms[0].hidflag.value ="edit";
	document.forms[0].hidAction.value ="insert";
	enableButtons(true, false, false, true, true);	
}

function callhelp()
{
	var varQryString = appUrl+"/jsp/perhlp/hlp_edueducational.jsp"
	var title = "ApplicantDemographics";
	var prop = "scrollbars=no,width=600,height=450";	
	prop = prop + ",left=200,top=150";
	window.open(varQryString,title,prop);
}
 


function doCancel()
{   
	if(ConfirmMsg(102))
	{
		document.forms[0].hidSourceUrl.value="/action/agr_yearcostdetails.jsp";
		document.forms[0].hidBeanId.value="agrcrops";
		document.forms[0].hidBeanGetMethod.value="getYearCostData";
		document.forms[0].action=appUrl+"controllerservlet";
		document.forms[0].submit(); 		
	}
	//disableCommandButtons("load");
}

function doDelete()
{
if(ConfirmMsg(101))
	{
	document.forms[0].hidAction.value ="delete";
	document.forms[0].action=appUrl+"action/ControllerServlet";		
	document.forms[0].hidBeanMethod.value="updateYearCostData";
	document.forms[0].hidBeanGetMethod.value="getYearCostData";
	document.forms[0].hidBeanId.value="agrcrops";
	document.forms[0].hidSourceUrl.value="action/agr_yearcostdetails.jsp";	
	document.forms[0].method="post";			
	document.forms[0].submit();		
	}
}
	
function onloading()
{	  
	
	enableButtons(false, true, true, false, false);	
	disableFields(true);
}



function calculateTotal()
{	
    var totalvalue=0.00;
	var totalvalue1=0.00;var totalvalue2=0.00;
	var totalvalue3=0.00;var totalvalue4=0.00;
	var totalvalue5=0.00;var totalvalue6=0.00;
	var totalvalue7=0.00;var totalvalue8=0.00;var totalvalue10=0.00;
	var totalvalue9=0.00;var totalvalue11=0.00;var totalvalue12=0.00;var totalvalue13=0.00;
	for(var i=1;i<=12;i++)
	{		
        var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue = eval(value1)+eval(totalvalue)
		totalvalue1 = eval(value2)+eval(totalvalue1)
		totalvalue2 = eval(value3)+eval(totalvalue2)
		totalvalue3 = eval(value4)+eval(totalvalue3)
		totalvalue4 = eval(value5)+eval(totalvalue4)
		totalvalue5 = eval(value6)+eval(totalvalue5)
		totalvalue6 = eval(value7)+eval(totalvalue6)
		totalvalue7 = eval(value8)+eval(totalvalue7)
		totalvalue8 = eval(value9)+eval(totalvalue8)
		totalvalue9 = eval(value10)+eval(totalvalue9)
        totalvalue10 = eval(value11)+eval(totalvalue10)
		totalvalue11 = eval(value12)+eval(totalvalue11)
		totalvalue12 = eval(value13)+eval(totalvalue12)
		totalvalue13 = eval(value14)+eval(totalvalue13)
	}
	document.forms[0].txt_cost1[13].value= totalvalue;
	roundtxt(document.forms[0].txt_cost1[13]);
	document.forms[0].txt_loan1[13].value= totalvalue1;
	roundtxt(document.forms[0].txt_loan1[13]);
	document.forms[0].txt_cost2[13].value=totalvalue2;
	roundtxt(document.forms[0].txt_cost2[13]);
	
	document.forms[0].txt_loan2[13].value=totalvalue3;
	roundtxt(document.forms[0].txt_loan2[13]);
	
	document.forms[0].txt_cost3[13].value=totalvalue4; 
	roundtxt(document.forms[0].txt_cost3[13]);
	
	document.forms[0].txt_loan3[13].value=totalvalue5;
	roundtxt(document.forms[0].txt_loan3[13]);
	
	document.forms[0].txt_cost4[13].value=totalvalue6;
	roundtxt(document.forms[0].txt_cost4[13]);
	
	document.forms[0].txt_loan4[13].value=totalvalue7;
	roundtxt(document.forms[0].txt_loan4[13]);
	
	document.forms[0].txt_cost5[13].value=totalvalue8;
	roundtxt(document.forms[0].txt_cost5[13]);
	
	document.forms[0].txt_loan5[13].value=totalvalue9;
	roundtxt(document.forms[0].txt_loan5[13]);
	
    document.forms[0].txt_cost6[13].value=totalvalue10;
    roundtxt(document.forms[0].txt_cost6[13]);
	
	document.forms[0].txt_loan6[13].value=totalvalue11;
	roundtxt(document.forms[0].txt_loan6[13]);
	
	document.forms[0].txt_cost7[13].value=totalvalue12;
	roundtxt(document.forms[0].txt_cost7[13]);
	
	document.forms[0].txt_loan7[13].value=totalvalue13;
	roundtxt(document.forms[0].txt_loan7[13]);
	
}

function calTotal()
{	
    var totalvalue=0.00;
	var totalvalue1=0.00;var totalvalue2=0.00;
	var totalvalue3=0.00;var totalvalue4=0.00;
	var totalvalue5=0.00;var totalvalue6=0.00;
	var totalvalue7=0.00;var totalvalue8=0.00;var totalvalue10=0.00;var totalvalue22=0.00;var totalvalue23=0.00;
	var totalvalue9=0.00;var totalvalue11=0.00;var totalvalue12=0.00;var totalvalue13=0.00;
	var totalvalue14=0.00;var totalvalue15=0.00;var totalvalue16=0.00;var totalvalue17=0.00;
	var totalvalue18=0.00;var totalvalue19=0.00;var totalvalue20=0.00;var totalvalue21=0.00;
	for(var i=1;i<2;i++)
	{		
        var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue);
		totalvalue1 = eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue1);
		
	}
	document.forms[0].txt_totalcost1[1].value= totalvalue;
	roundtxt(document.forms[0].txt_totalcost1[1]);
	
	 document.forms[0].txt_totalloan1[1].value= totalvalue1;
	 roundtxt(document.forms[0].txt_totalloan1[1]);
	for(var i=2;i<3;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue2 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue2);
		totalvalue3 = eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue3);
		
	}
	document.forms[0].txt_totalcost1[2].value= totalvalue2;
	 document.forms[0].txt_totalloan1[2].value= totalvalue3;
	 roundtxt(document.forms[0].txt_totalcost1[2]);
	roundtxt(document.forms[0].txt_totalloan1[2]);
	for(var i=3;i<4;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue4 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue4);
		totalvalue5 = eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue5);
		
	
}
document.forms[0].txt_totalcost1[3].value= totalvalue4;
document.forms[0].txt_totalloan1[3].value= totalvalue5;
roundtxt(document.forms[0].txt_totalcost1[3]);
roundtxt(document.forms[0].txt_totalloan1[3]);
for(var i=4;i<5;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue6 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue6);
		totalvalue7 = eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue7);
	
}
document.forms[0].txt_totalcost1[4].value= totalvalue6;
document.forms[0].txt_totalloan1[4].value= totalvalue7;
roundtxt(document.forms[0].txt_totalcost1[4]);
roundtxt(document.forms[0].txt_totalloan1[4]);
for(var i=5;i<6;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue8 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue8);
		totalvalue9 = eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue9);
	
}
document.forms[0].txt_totalcost1[5].value= totalvalue8;
document.forms[0].txt_totalloan1[5].value= totalvalue9;
roundtxt(document.forms[0].txt_totalcost1[5]);
roundtxt(document.forms[0].txt_totalloan1[5]);
for(var i=6;i<7;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue10 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue10);
		totalvalue11= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue11);
	
}
document.forms[0].txt_totalcost1[6].value= totalvalue10;
document.forms[0].txt_totalloan1[6].value= totalvalue11;
roundtxt(document.forms[0].txt_totalcost1[6]);
roundtxt(document.forms[0].txt_totalloan1[6]);
for(var i=7;i<8;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue12 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue12);
		totalvalue13= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue13);
		}
		document.forms[0].txt_totalcost1[7].value= totalvalue12;
        document.forms[0].txt_totalloan1[7].value= totalvalue13;
        roundtxt(document.forms[0].txt_totalcost1[7]);
        roundtxt(document.forms[0].txt_totalloan1[7]);
for(var i=8;i<9;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue14 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue14);
		totalvalue15= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue15);
		
}
document.forms[0].txt_totalcost1[8].value= totalvalue14;
document.forms[0].txt_totalloan1[8].value= totalvalue15;
 roundtxt(document.forms[0].txt_totalcost1[8]);
 roundtxt(document.forms[0].txt_totalloan1[8]);
      
for(var i=9;i<10;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue16 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue16);
		totalvalue17= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue17);
		
}
document.forms[0].txt_totalcost1[9].value= totalvalue16;
document.forms[0].txt_totalloan1[9].value= totalvalue17;
 roundtxt(document.forms[0].txt_totalcost1[9]);
  roundtxt(document.forms[0].txt_totalloan1[9]);
for(var i=10;i<11;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue18 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue18);
		totalvalue19= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue19);
		
}
document.forms[0].txt_totalcost1[10].value= totalvalue18;
document.forms[0].txt_totalloan1[10].value= totalvalue19;
 roundtxt(document.forms[0].txt_totalcost1[10]);
  roundtxt(document.forms[0].txt_totalloan1[10]);
for(var i=11;i<12;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue20= eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue20);
		totalvalue21= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue21);
		
}
document.forms[0].txt_totalcost1[11].value= totalvalue20;
document.forms[0].txt_totalloan1[11].value= totalvalue21;
roundtxt(document.forms[0].txt_totalcost1[11]);
roundtxt(document.forms[0].txt_totalloan1[11]);
for(var i=12;i<13;i++)
	{
	    var value1 =  document.forms[0].txt_cost1[i].value;
		var value2=document.forms[0].txt_loan1[i].value;
		var value3 =  document.forms[0].txt_cost2[i].value;
		var value4=document.forms[0].txt_loan2[i].value;
		var value5 =  document.forms[0].txt_cost3[i].value;
		var value6=document.forms[0].txt_loan3[i].value;
		var value7 =  document.forms[0].txt_cost4[i].value;
		var value8=document.forms[0].txt_loan4[i].value;
		var value9=document.forms[0].txt_cost5[i].value;
		var value10 =  document.forms[0].txt_loan5[i].value;
		var value11 =  document.forms[0].txt_cost6[i].value;
		var value12=document.forms[0].txt_loan6[i].value;
		var value13=document.forms[0].txt_cost7[i].value;
		var value14 =  document.forms[0].txt_loan7[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		if(value3=="")
		{
			value3=0.00;
		}
		if(value4=="")
		{
			value4=0.00;
		}
		if(value5=="")
		{
			value5=0.00;
		}
		if(value6=="")
		{
			value6=0.00;
		}
		if(value7=="")
		{
			value7=0.00;
		}
		if(value8=="")
		{
			value8=0.00;
		}
		if(value9=="")
		{
			value9=0.00;
		}
		if(value10=="")
		{
			value10=0.00;
		}
               if(value11=="")
		{
			value11=0.00;
		}
              if(value12=="")
		{
			value12=0.00;
		}
             if(value13=="")
		{
			value13=0.00;
		}
              if(value14=="")
		{
			value14=0.00;
		}
		
		totalvalue22 = eval(value1)+eval(value3)+eval(value5)+eval(value7)+eval(value9)+eval(value11)+eval(value13)+eval(totalvalue22);
		totalvalue23= eval(value2)+eval(value4)+eval(value6)+eval(value8)+eval(value10)+eval(value12)+eval(value14)+eval(totalvalue23);
		
}
document.forms[0].txt_totalcost1[12].value= totalvalue22;
document.forms[0].txt_totalloan1[12].value= totalvalue23;	
roundtxt(document.forms[0].txt_totalcost1[12]);
roundtxt(document.forms[0].txt_totalloan1[12]);
}


</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<style type="text/css">

DIV.cellContainer {	
  width: 100%; height: 250;
  overflow: auto;
}
</style>
<link rel="stylesheet"
	href="<%=ApplicationParams.getAppUrl()%>css/blackfont.css"
	type="text/css">
</head>
<body onLoad="onloading();calculateTotal();calTotal()">
<form name="frmpri" method=post>

<table width="100%" border="0" cellpadding="0" cellspacing="0">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
			<tr>
				
            <td> 
              <table width="100%" border="0" cellspacing="0" cellpadding="0">					
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							bordercolorlight="#8F8369" bordercolordark="#FFFFFB">							
							<tr>
								
                        <td> <table width="100%" border="0" cellspacing="1" cellpadding="3">
<tr> 
                              <td colspan="17" bgcolor="#71694F" ><b><font size="1"
											face="MS Sans Serif" color="#FFFFFF">Year 
                                Details </font></b></td>
                            </tr>
                            <tr> 
							<%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(0);
	                   
						if(arryCol.size()!=0)
						{

						 l_1=Helper.correctNull((String)arryCol.get(4)); 
						f_1=Helper.correctNull((String)arryCol.get(5));
					    p_1=Helper.correctNull((String)arryCol.get(6));
					    r_1=Helper.correctNull((String)arryCol.get(7));
					    d_1=Helper.correctNull((String)arryCol.get(8));
					   q_1=Helper.correctNull((String)arryCol.get(9));
					   m_1=Helper.correctNull((String)arryCol.get(10));
					   c_1=Helper.correctNull((String)arryCol.get(11));
					    e_1=Helper.correctNull((String)arryCol.get(12));
					    g_1=Helper.correctNull((String)arryCol.get(13));
					    h_1=Helper.correctNull((String)arryCol.get(14));
					   j_1=Helper.correctNull((String)arryCol.get(15));
					   k_1=Helper.correctNull((String)arryCol.get(16));
					   o_1=Helper.correctNull((String)arryCol.get(17));
					   t_1=Helper.correctNull((String)arryCol.get(18));
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	f_1="20";
                    	p_1="";
                    	r_1="20";
                    	d_1="";
                        q_1="20";
                    	m_1="";
						c_1="20";
						e_1="";
						g_1="20";
						h_1="";
						j_1="20";
						k_1="";
						o_1="20";
						t_1="";
                    	
                    }
                    
                    %>
                              
                              <td  width="11%" bgcolor="#71694F" align=""><b><font size="1"
											face="MS Sans Serif" color="#FFFFFF"> 
                                <input type="hidden"
											name="txt_item" size="20" maxlength="20" value=""
											onKeyPress="">
                                </font></b></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost1" size="5" maxlength="4"
											value="<%=f_1%>" onKeyPress="" readonly
											>
                                <input type="hidden" name="txt_loan1"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost2" size="5" maxlength="4"
											value="<%=r_1%>" onKeyPress="" readonly
											>
                                <input type="hidden" name="txt_loan2"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost3" size="5" maxlength="4"
											value="<%=q_1%>" onKeyPress="" readonly
											>
                                <input type="hidden" name="txt_loan3"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost4" size="5" maxlength="4"
											value="<%=c_1%>" onKeyPress="" readonly
											>
                                <input type="hidden" name="txt_loan4"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost5" size="5" maxlength="4"
											value="<%=g_1%>" onKeyPress="" readonly
										>
                                <input type="hidden" name="txt_loan5"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost6" size="5" maxlength="4"
											value="<%=j_1%>" onKeyPress="" readonly
											> 
<input type="hidden" name="txt_loan6"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="2" bgcolor="#71694F" align="center"><input
											type="text" name="txt_cost7" size="5" maxlength="4"
											value="<%=o_1%>" onKeyPress="" readonly
											>
                                <input type="hidden" name="txt_loan7"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" 
											style="text-align:right;"></td>
                              <td  colspan="4" align="center" bgcolor="#71694F">
							  <input type="hidden" name="txt_totalcost1"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;">
                                <input type="hidden" name="txt_totalloan1"
											size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur=""
											style="text-align:right;"></td>
                            </tr>
                            <tr> 
                              <td  width="11%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Items 
                                of Development</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="6%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost 
                                </font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Cost</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align=""><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Loan</font></b></td>
                              <td  width="5%" bgcolor="#71694F" align="" nowrap><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Total 
                                cost</font></b></td>
                              <td  width="13%" bgcolor="#71694F" align="" ><b><font
											size="1" face="MS Sans Serif" color="#FFFFFF">Total 
                                Loan </font></b></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(1);
	                   
						if(arryCol.size()!=0)
						{

						 l1=Helper.correctNull((String)arryCol.get(4)); 
						f1=Helper.correctNull((String)arryCol.get(5));
					    p1=Helper.correctNull((String)arryCol.get(6));
					    r1=Helper.correctNull((String)arryCol.get(7));
					    d1=Helper.correctNull((String)arryCol.get(8));
					   q1=Helper.correctNull((String)arryCol.get(9));
					   m1=Helper.correctNull((String)arryCol.get(10));
					   c1=Helper.correctNull((String)arryCol.get(11));
					    e1=Helper.correctNull((String)arryCol.get(12));
					    g1=Helper.correctNull((String)arryCol.get(13));
					    h1=Helper.correctNull((String)arryCol.get(14));
					   j1=Helper.correctNull((String)arryCol.get(15));
					   k1=Helper.correctNull((String)arryCol.get(16));
					   o1=Helper.correctNull((String)arryCol.get(17));
					   t1=Helper.correctNull((String)arryCol.get(18));
					}
					}
                   
                  
                    else if(arryRow.size()==0){
                    	//l1="0";
                    	f1="";
                    	p1="";
                    	r1="";
                    	d1="";
                        q1="";
                    	m1="";
						c1="";
						e1="";
						g1="";
						h1="";
						j1="";
						k1="";
						o1="";
						t1="";
                    	
                    }
                    
                    %>
                              <td  width="11%"> 
                                <div align=""> 
                                  <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l1%>" onKeyPress="">
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f1%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div>
                              </td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p1%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r1%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d1%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o1%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%" >
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t1%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td bgcolor="#71694F">
							  <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9"
											/></td>
                              <td bgcolor="#71694F" >
							  <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(2);
	                   
						if(arryCol.size()!=0)
						{

							l2=Helper.correctNull((String)arryCol.get(4)); 
							f2=Helper.correctNull((String)arryCol.get(5));
						    p2=Helper.correctNull((String)arryCol.get(6));
						    r2=Helper.correctNull((String)arryCol.get(7));
						    d2=Helper.correctNull((String)arryCol.get(8));
						    q2=Helper.correctNull((String)arryCol.get(9));
						    m2=Helper.correctNull((String)arryCol.get(10));
						c2=Helper.correctNull((String)arryCol.get(11));
					    e2=Helper.correctNull((String)arryCol.get(12));
					    g2=Helper.correctNull((String)arryCol.get(13));
					    h2=Helper.correctNull((String)arryCol.get(14));
					   j2=Helper.correctNull((String)arryCol.get(15));
					   k2=Helper.correctNull((String)arryCol.get(16));
					   o2=Helper.correctNull((String)arryCol.get(17));
					   t2=Helper.correctNull((String)arryCol.get(18));
						  
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    	//l2="0";
                    	f2="";
                    	p2="";
                    	r2="";
                    	d2="";
                    	q2="";
                    	m2="";
                    	c2="";
                    	e2="";
                    	g2="";
                    	h2="";
                    	j2="";k2="";o2="";t2="";
                    	
                    }
                    
                    %>
                              <td  width="11%"> 
                                <div align=""> 
                                  <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l2%>" onKeyPress="">
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f2%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p2%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r2%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d2%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o2%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t2%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" value=''
											/></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9"/></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(3);
	                	if(arryCol.size()!=0)
						{

							l3=Helper.correctNull((String)arryCol.get(4)); 
							f3=Helper.correctNull((String)arryCol.get(5));
						    p3=Helper.correctNull((String)arryCol.get(6));
						    r3=Helper.correctNull((String)arryCol.get(7));
						    d3=Helper.correctNull((String)arryCol.get(8));
						    q3=Helper.correctNull((String)arryCol.get(9));
						   m3=Helper.correctNull((String)arryCol.get(10));
						   c3=Helper.correctNull((String)arryCol.get(11));
					    e3=Helper.correctNull((String)arryCol.get(12));
					    g3=Helper.correctNull((String)arryCol.get(13));
					    h3=Helper.correctNull((String)arryCol.get(14));
					   j3=Helper.correctNull((String)arryCol.get(15));
					   k3=Helper.correctNull((String)arryCol.get(16));
					   o3=Helper.correctNull((String)arryCol.get(17));
					   t3=Helper.correctNull((String)arryCol.get(18));
						   
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    	//l4="0";
                    	f3="";
                    	p3="";
                    	r3="";
                    	d3="";
                    	q3="";
                    	m3="";c3="";e3="";g3="";h3="";j3="";k3="";o3="";t3="";
                    	
                    }
                    
                    %>
                              <td  width="11%" align="">
                                <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l3%>" onKeyPress=""> 
                              </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f3%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p3%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r3%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d3%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t3%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(4);
	                   
						if(arryCol.size()!=0)
						{

							l4=Helper.correctNull((String)arryCol.get(4)); 
							f4=Helper.correctNull((String)arryCol.get(5));
						    p4=Helper.correctNull((String)arryCol.get(6));
						    r4=Helper.correctNull((String)arryCol.get(7));
						    d4=Helper.correctNull((String)arryCol.get(8));
						    q4=Helper.correctNull((String)arryCol.get(9));
						   m4=Helper.correctNull((String)arryCol.get(10));
						   c4=Helper.correctNull((String)arryCol.get(11));
					    e4=Helper.correctNull((String)arryCol.get(12));
					    g4=Helper.correctNull((String)arryCol.get(13));
					    h4=Helper.correctNull((String)arryCol.get(14));
					   j4=Helper.correctNull((String)arryCol.get(15));
					   k4=Helper.correctNull((String)arryCol.get(16));
					   o4=Helper.correctNull((String)arryCol.get(17));
					   t4=Helper.correctNull((String)arryCol.get(18));
						   
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    	//l4="0";
                    	f4="";
                    	p4="";
                    	r4="";
                    	d4="";
                    	q4="";
                    	m4="";c4="";e4="";g4="";h4="";j4="";k4="";o4="";t4="";
                    	
                    }
                    
                    %>
                              <td  id="r6" width="11%" height=""> 
                                <div align=""> 
                                  <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l4%>" onKeyPress="">
                                </div></td>
                              <td  id="r6" width="5%" height=""> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f4%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  id="r6" width="5%" height=""> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p4%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  id="r6" width="5%" height=""> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r4%>'
											onBlur="calculateTotal();calTotal()"
											/>
</div></td>
                              <td  id="r6" width="5%" height=""> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d4%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_cost3" size="5" maxlength="9" value='<%=q4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="6%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_loan3" size="5" maxlength="9" value='<%=m4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_cost4" size="5" maxlength="9" value='<%=c4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_loan4" size="5" maxlength="9" value='<%=e4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_cost5" size="5" maxlength="9" value='<%=g4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_loan5" size="5" maxlength="9" value='<%=h4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_cost6" size="5" maxlength="9" value='<%=j4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_loan6" size="5" maxlength="9" value='<%=k4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_cost7" size="5" maxlength="9" value='<%=o4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  id="r6" width="5%" height="">
                                <lapschoice:CurrencyTag 
											name="txt_loan7" size="5" maxlength="9" value='<%=t4%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	 
											<lapschoice:CurrencyTag  name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(5);
	                   
						if(arryCol.size()!=0)
						{

							l5=Helper.correctNull((String)arryCol.get(4)); 
							f5=Helper.correctNull((String)arryCol.get(5));
						    p5=Helper.correctNull((String)arryCol.get(6));
						    r5=Helper.correctNull((String)arryCol.get(7));
						    d5=Helper.correctNull((String)arryCol.get(8));
						    q5=Helper.correctNull((String)arryCol.get(9));
						    m5=Helper.correctNull((String)arryCol.get(10));
							 c5=Helper.correctNull((String)arryCol.get(11));
					    e5=Helper.correctNull((String)arryCol.get(12));
					    g5=Helper.correctNull((String)arryCol.get(13));
					    h5=Helper.correctNull((String)arryCol.get(14));
					   j5=Helper.correctNull((String)arryCol.get(15));
					   k5=Helper.correctNull((String)arryCol.get(16));
					   o5=Helper.correctNull((String)arryCol.get(17));
					   t5=Helper.correctNull((String)arryCol.get(18));
						   
						  
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    	//l5="0";
                    	f5="";
                    	p5="";
                    	r5="";
                    	d5="";
                    	q5="";
                    	m5="";c5="";e5="";g5="";h5="";j5="";k5="";o5="";t5="";
                    	
                    }
                    
                    %>
                              <td  width="11%" align="">
                                <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l5%>" onKeyPress=""> 
                              </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag  name="txt_cost1"
											size="5" maxlength="9" value='<%=f5%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag  name="txt_loan1"
											size="5" maxlength="9" value='<%=p5%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r5%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d5%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t5%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" value=''
											/></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <%

                    if(arryRow.size()!=0){
	                    arryCol = (ArrayList)arryRow.get(6);
	                   
						if(arryCol.size()!=0)
						{

							l6=Helper.correctNull((String)arryCol.get(4)); 
							f6=Helper.correctNull((String)arryCol.get(5));
						    p6=Helper.correctNull((String)arryCol.get(6));
						    r6=Helper.correctNull((String)arryCol.get(7));
						    d6=Helper.correctNull((String)arryCol.get(8));
						  q6=Helper.correctNull((String)arryCol.get(9));
						  m6=Helper.correctNull((String)arryCol.get(10));
						   c6=Helper.correctNull((String)arryCol.get(11));
					    e6=Helper.correctNull((String)arryCol.get(12));
					    g6=Helper.correctNull((String)arryCol.get(13));
					    h6=Helper.correctNull((String)arryCol.get(14));
					   j6=Helper.correctNull((String)arryCol.get(15));
					   k6=Helper.correctNull((String)arryCol.get(16));
					   o6=Helper.correctNull((String)arryCol.get(17));
					   t6=Helper.correctNull((String)arryCol.get(18));
						   
						   
					}
                   
                   } 
                    else if(arryRow.size()==0){
                    	//l6="0";
                    	f6="";
                    	p6="";
                    	r6="";
                    	d6="";
                        q6="";
                    	m6="";c6="";e6="";g6="";h6="";j6="";k6="";o6="";t6="";
                    	
                    }
                    
                    %>
                              <td  width="11%"> 
                                <div align=""> 
                                  <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l6%>" onKeyPress="">
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f6%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p6%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r6%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d6%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t6%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <%if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(7);
							                   
											if(arryCol.size()!=0)
											{

												l7=Helper.correctNull((String)arryCol.get(4)); 
												f7=Helper.correctNull((String)arryCol.get(5));
											    p7=Helper.correctNull((String)arryCol.get(6));
											    r7=Helper.correctNull((String)arryCol.get(7));
											    d7=Helper.correctNull((String)arryCol.get(8));
											    q7=Helper.correctNull((String)arryCol.get(9));
											   m7=Helper.correctNull((String)arryCol.get(10));
											   c7=Helper.correctNull((String)arryCol.get(11));
										    e7=Helper.correctNull((String)arryCol.get(12));
										    g7=Helper.correctNull((String)arryCol.get(13));
										    h7=Helper.correctNull((String)arryCol.get(14));
										   j7=Helper.correctNull((String)arryCol.get(15));
										   k7=Helper.correctNull((String)arryCol.get(16));
										   o7=Helper.correctNull((String)arryCol.get(17));
										   t7=Helper.correctNull((String)arryCol.get(18));
											   
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l7="0";
					                    	f7="";
					                    	p7="";
					                    	r7="";
					                    	d7="";
					                        q7="";
					                        m7="";c7="";e7="";g7="";h7="";j7="";k7="";o7="";t7="";
					                    	
					                    }
					                    
			%>
                              <td  width="11%" align="">
                                <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l7%>" onKeyPress=""> 
                              </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f7%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p7%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r7%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d7%>'
											onBlur="calculateTotal();calTotal()"
											/> </td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o7%>'
											onBlur="calculateTotal();calTotal()"
											/> 
                              <td  width="5%">
								<lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t7%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <% if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(8);
							                  
											if(arryCol.size()!=0)
											{

												l8=Helper.correctNull((String)arryCol.get(4)); 
												f8=Helper.correctNull((String)arryCol.get(5));
											    p8=Helper.correctNull((String)arryCol.get(6));
											    r8=Helper.correctNull((String)arryCol.get(7));
											    d8=Helper.correctNull((String)arryCol.get(8));
											  q8=Helper.correctNull((String)arryCol.get(9));
											   m8=Helper.correctNull((String)arryCol.get(10));
											    c8=Helper.correctNull((String)arryCol.get(11));
										    e8=Helper.correctNull((String)arryCol.get(12));
										    g8=Helper.correctNull((String)arryCol.get(13));
										    h8=Helper.correctNull((String)arryCol.get(14));
										   j8=Helper.correctNull((String)arryCol.get(15));
										   k8=Helper.correctNull((String)arryCol.get(16));
										   o8=Helper.correctNull((String)arryCol.get(17));
										   t8=Helper.correctNull((String)arryCol.get(18));
											   
											    
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l8="0";
					                    	f8="";
					                    	p8="";
					                    	r8="";
					                    	d8="";
					                    	q8="";
					                        m8="";e8="";g8="";h8="";j8="";k8="";o8="";t8="";
					                    		
					                    }

			%>
                              <td  width="11%" align="">
                                <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l8%>" onKeyPress=""> 
                              </td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f8%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p8%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r8%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d8%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t8%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <% if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(9);
							                  
											if(arryCol.size()!=0)
											{

												l9=Helper.correctNull((String)arryCol.get(4)); 
												f9=Helper.correctNull((String)arryCol.get(5));
											    p9=Helper.correctNull((String)arryCol.get(6));
											    r9=Helper.correctNull((String)arryCol.get(7));
											    d9=Helper.correctNull((String)arryCol.get(8));
											  q9=Helper.correctNull((String)arryCol.get(9));
											   m9=Helper.correctNull((String)arryCol.get(10));
											     c9=Helper.correctNull((String)arryCol.get(11));
										    e9=Helper.correctNull((String)arryCol.get(12));
										    g9=Helper.correctNull((String)arryCol.get(13));
										    h9=Helper.correctNull((String)arryCol.get(14));
										   j9=Helper.correctNull((String)arryCol.get(15));
										   k9=Helper.correctNull((String)arryCol.get(16));
										   o9=Helper.correctNull((String)arryCol.get(17));
										   t9=Helper.correctNull((String)arryCol.get(18));
											   
											   
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l9="0";
					                    	f9="";
					                    	p9="";
					                    	r9="";
					                    	d9="";
					                    	q9="";
					                        m9="";c9="";e9="";g9="";h9="";j9="";k9="";o9="";t9="";
					                    		
					                    }
			%>
                              <td  width="11%"> 
                                <div align=""> 
                                  <input type="text" name="txt_item"
											size="20" maxlength="20" value="<%=l9%>" onKeyPress="">
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost1"
											size="5" maxlength="9" value='<%=f9%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan1"
											size="5" maxlength="9" value='<%=p9%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_cost2"
											size="5" maxlength="9" value='<%=r9%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%"> 
                                <div align=""> 
                                  <lapschoice:CurrencyTag name="txt_loan2"
											size="5" maxlength="9" value='<%=d9%>'
											onBlur="calculateTotal();calTotal()"
											/>
                                </div></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t9%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <% if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(10);
							                  
											if(arryCol.size()!=0)
											{

												l10=Helper.correctNull((String)arryCol.get(4)); 
												f10=Helper.correctNull((String)arryCol.get(5));
											    p10=Helper.correctNull((String)arryCol.get(6));
											    r10=Helper.correctNull((String)arryCol.get(7));
											    d10=Helper.correctNull((String)arryCol.get(8));
											  q10=Helper.correctNull((String)arryCol.get(9));
											   m10=Helper.correctNull((String)arryCol.get(10));
											     c10=Helper.correctNull((String)arryCol.get(11));
										    e10=Helper.correctNull((String)arryCol.get(12));
										    g10=Helper.correctNull((String)arryCol.get(13));
										    h10=Helper.correctNull((String)arryCol.get(14));
										   j10=Helper.correctNull((String)arryCol.get(15));
										   k10=Helper.correctNull((String)arryCol.get(16));
										   o10=Helper.correctNull((String)arryCol.get(17));
										   t10=Helper.correctNull((String)arryCol.get(18));
										   
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l10="0";
					                    	f10="";
					                    	p10="";
					                    	r10="";
					                    	d10="";
					                    	q10="";
					                        m10="";c10="";j10="";k10="";o10="";g10="";t10="";h10="";e10="";
					                    		
					                    }
					                    

			%>
                              <td  width="11%" align="">
                                <input type="text"
											name="txt_item" size="20" maxlength="20" value="<%=l10%>"
											onKeyPress=""></td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag
											name="txt_cost1" size="5" maxlength="9" value='<%=f10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag
											name="txt_loan1" size="5" maxlength="9" value='<%=p10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag
											name="txt_cost2" size="5" maxlength="9" value='<%=r10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" align="">
                                <lapschoice:CurrencyTag
											name="txt_loan2" size="5" maxlength="9" value='<%=d10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t10%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <% if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(11);
							                  
											if(arryCol.size()!=0)
											{

												l11=Helper.correctNull((String)arryCol.get(4)); 
												f11=Helper.correctNull((String)arryCol.get(5));
											    p11=Helper.correctNull((String)arryCol.get(6));
											    r11=Helper.correctNull((String)arryCol.get(7));
											    d11=Helper.correctNull((String)arryCol.get(8));
											  q11=Helper.correctNull((String)arryCol.get(9));
											   m11=Helper.correctNull((String)arryCol.get(10));
											     c11=Helper.correctNull((String)arryCol.get(11));
										    e11=Helper.correctNull((String)arryCol.get(12));
										    g11=Helper.correctNull((String)arryCol.get(13));
										    h11=Helper.correctNull((String)arryCol.get(14));
										   j11=Helper.correctNull((String)arryCol.get(15));
										   k11=Helper.correctNull((String)arryCol.get(16));
										   o11=Helper.correctNull((String)arryCol.get(17));
										   t11=Helper.correctNull((String)arryCol.get(18));
										   
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l10="0";
					                    	f11="";
					                    	p11="";
					                    	r11="";
					                    	d11="";
					                    	q10="";
					                        m11="";c11="";j11="";k11="";o11="";g11="";t11="";h11="";e11="";
					                    		
					                    }
					          %>
                              <td ><input type="text"
											name="txt_item" size="20" maxlength="20" value="<%=l11%>"
											onKeyPress=""></td>
                              <td ><lapschoice:CurrencyTag
											name="txt_cost1" size="5" maxlength="9" value='<%=f11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag
											name="txt_loan1" size="5" maxlength="9" value='<%=p11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag
											name="txt_cost2" size="5" maxlength="9" value='<%=r11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag
											name="txt_loan2" size="5" maxlength="9" value='<%=d11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td ><lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t11%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>	 <td  width="" bgcolor="#71694F">	
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr> 
                              <% if(arryRow.size()!=0){
						                    arryCol = (ArrayList)arryRow.get(12);
							            	if(arryCol.size()!=0)
											{

												l12=Helper.correctNull((String)arryCol.get(4)); 
												f12=Helper.correctNull((String)arryCol.get(5));
											    p12=Helper.correctNull((String)arryCol.get(6));
											    r12=Helper.correctNull((String)arryCol.get(7));
											    d12=Helper.correctNull((String)arryCol.get(8));
											  q12=Helper.correctNull((String)arryCol.get(9));
											   m12=Helper.correctNull((String)arryCol.get(10));
											     c12=Helper.correctNull((String)arryCol.get(11));
										    e12=Helper.correctNull((String)arryCol.get(12));
										    g12=Helper.correctNull((String)arryCol.get(13));
										    h12=Helper.correctNull((String)arryCol.get(14));
										   j12=Helper.correctNull((String)arryCol.get(15));
										   k12=Helper.correctNull((String)arryCol.get(16));
										   o12=Helper.correctNull((String)arryCol.get(17));
										   t12=Helper.correctNull((String)arryCol.get(18));
										   
										}
					                   
					                   } 
					                    else if(arryRow.size()==0){
					                    	//l10="0";
					                    	f12="";
					                    	p12="";
					                    	r12="";
					                    	d12="";
					                    	q12="";
					                        m12="";c12="";j12="";k12="";o12="";g12="";t12="";h12="";e12="";
					                    		
					                    }
					          %>
                              <td  width="11%">
                                <input type="text"
											name="txt_item" size="20" maxlength="20" value="<%=l12%>"
											onKeyPress=""></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag
											name="txt_cost1" size="5" maxlength="9" value='<%=f12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag
											name="txt_loan1" size="5" maxlength="9" value='<%=p12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag
											name="txt_cost2" size="5" maxlength="9" value='<%=r12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag
											name="txt_loan2" size="5" maxlength="9" value='<%=d12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost3"
											size="5" maxlength="9" value='<%=q12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="6%">
                                <lapschoice:CurrencyTag name="txt_loan3"
											size="5" maxlength="9" value='<%=m12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost4"
											size="5" maxlength="9" value='<%=c12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan4"
											size="5" maxlength="9" value='<%=e12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost5"
											size="5" maxlength="9" value='<%=g12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan5"
											size="5" maxlength="9" value='<%=h12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost6"
											size="5" maxlength="9" value='<%=j12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan6"
											size="5" maxlength="9" value='<%=k12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_cost7"
											size="5" maxlength="9" value='<%=o12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%">
                                <lapschoice:CurrencyTag name="txt_loan7"
											size="5" maxlength="9" value='<%=t12%>'
											onBlur="calculateTotal();calTotal()"
											/></td>
                              <td  width="5%" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalcost1"
											size="5" maxlength="9" /></td>
                              <td  width="" bgcolor="#71694F">
                                <lapschoice:CurrencyTag name="txt_totalloan1"
											size="5" maxlength="9" /></td>
                            </tr>
                            <tr bgcolor="#71694F"> 
                              <td  width="11%" ><b><font size="1"
											face="MS Sans Serif" color="#FFFFFF">Total 
<input type="hidden"
											name="txt_item" size="20" maxlength="20" value=""
											onKeyPress="">
                                </font></b></td>
                              <td  width="5%"  align="">
                                <input
											type="text" name="txt_cost1" size="5" maxlength="9"
											value="" onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()" readonly
											style="text-align:right;"></td>
                              <td  width="5%" align="">
                                <input type="text"
											name="txt_loan1" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" align="">
                                <input type="text"
											name="txt_cost2" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" align="">
                                <input type="text"
											name="txt_loan2" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_cost3" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="6%" >
                                <input type="text"
											name="txt_loan3" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_cost4" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_loan4" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_cost5" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_loan5" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_cost6" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_loan6" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_cost7" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
                              <td  width="5%" >
                                <input type="text"
											name="txt_loan7" size="5" maxlength="9" value=""
											onKeyPress="allowNumber(this)" onBlur="calculateTotal();calTotal()"
											readonly style="text-align:right;"></td>
								   
                              <td  width="5%" >
                                <input type="hidden"
											name="txt_totalcost1" size="5" maxlength="9" value="0"
											onKeyPress="allowNumber(this)" 
											readonly style="text-align:right;"></td>
											   
                              <td  width="13%" >
                                <input type="hidden"
											name="txt_totalloan1" size="5" maxlength="9" value="0"
											onKeyPress="allowNumber(this)" 
											readonly style="text-align:right;"></td>			
											
                            </tr>
                          </table></td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td>						<table width="12%" border="1" align="center" cellpadding="0"
							cellspacing="0" bordercolorlight="#8F8369"
							bordercolordark="#FFFFFB" class="outertablecolor">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center">
									<tr valign="top">
										<td ><input type="button" name="cmdedit"
											value="Edit"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doEdit()"></td>
										<td align=""><input type="button" name="cmdapply"
											value="Save"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doSave()"></td>
										<td align=""><input type="button" name="cmdcancel"
											value="Cancel"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doCancel()"></td>
										<td width="0"><input type="button" name="cmddel"
											value="Delete"
											style="background-color:#8F8369;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											class="buttoncolor" onClick="doDelete()"></td>
										<td width="0"><input type="button" name="cmdhelp2"
											value="Help"
											style="background-color:#009966;cursor:help;;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="callhelp()"></td>
										<td width="0"><input type="button" name="cmdclose"
											value="Close"
											style="background-color:#CC3300;font-weight:bold;color:white;font-size=10;font-family:mssansserif;width:50"
											onClick="doClose()"></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td></td>
					</tr>
					<tr>
						<td></td>
					</tr>
				</table>
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<%String strappno = request.getParameter("appno");%>
<input type="hidden" name="hidAction"> <input type="hidden"
	name="hidBeanId" value=""> <input type="hidden" name="hidBeanMethod"
	value=""> <input type="hidden" name="hidBeanGetMethod" value=""> <input
	type="hidden" name="hidSourceUrl" value=""> <input type="hidden"
	name="hidApp_type" value="A"> <input type="hidden" name="hidflag"
	value=""> <input type="hidden" name="hideditflag"> <input type="hidden"
	name="selsno" value=""> <input type="hidden" name="hidval">  <input
	type="hidden" name="page">  <input type="hidden"
	name="radLoan" value="Y">   <input type="hidden"
	name="app_status" value="<%=app_status%>"> <input type="hidden" name="hid_sno"
	value="<%=Helper.correctNull((String)hshValues.get("strid"))%>">
	<input
	type="hidden" name="appstatus" value="">
	</form>
</body>
</html>
