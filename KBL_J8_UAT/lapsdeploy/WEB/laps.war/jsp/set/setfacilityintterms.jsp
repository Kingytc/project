<%@include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%
	String strType = Helper.correctNull(request.getParameter("hidval"));
	String strWrkflowtype = Helper.correctNull(request.getParameter("wrk_flowtype1"));
	if (strWrkflowtype.equals(""))
	{
		strWrkflowtype = "fixed";
	}
	String section = "";
	ArrayList v = null;
	if (objValues instanceof java.util.HashMap)
	{
		hshValues = (java.util.HashMap) objValues;
	}
	if (strType.equalsIgnoreCase("show_terms")
			|| strType.equalsIgnoreCase("update_terms"))
	{
		v = (ArrayList) hshValues.get("vecVal");
	}
	int vecsize = 0;
	if (v != null)
	{
		vecsize = v.size();
	}
	String corpprd_industrytype = Helper.correctNull((String) hshValues.get("corpprd_industrytype"));
	String strNoOfRatingDesc = Helper.correctNull((String) hshValues.get("prdNoOfRatingDescription"));
	int intNoOfRatingDesc = 0;
	if (!strNoOfRatingDesc.equalsIgnoreCase(""))
	{
		intNoOfRatingDesc = Integer.parseInt(strNoOfRatingDesc);
	}
	ArrayList vecRatingRoiRow1 = null;
	ArrayList vecRatingRoiRow2 = null;
	ArrayList vecRatingRoiRow3 = null;
	ArrayList vecRatingRoiRow4 = null;
	ArrayList vecRatingRoiRow5 = null;
	if (strType.equalsIgnoreCase("show_terms")
			|| strType.equalsIgnoreCase("update_terms"))
	{
		vecRatingRoiRow1 = (ArrayList) hshValues.get("vecRatingRoi1");
		vecRatingRoiRow2 = (ArrayList) hshValues.get("vecRatingRoi2");
		vecRatingRoiRow3 = (ArrayList) hshValues.get("vecRatingRoi3");
		vecRatingRoiRow4 = (ArrayList) hshValues.get("vecRatingRoi4");
		vecRatingRoiRow5 = (ArrayList) hshValues.get("vecRatingRoi5");
	}
	int vecRatingRoi1Size = 0;
	if (vecRatingRoiRow1 != null)
	{
		vecRatingRoi1Size = vecRatingRoiRow1.size();
	}
	int vecRatingRoi2Size = 0;
	if (vecRatingRoiRow2 != null)
	{
		vecRatingRoi2Size = vecRatingRoiRow2.size();
	}
	int vecRatingRoi3Size = 0;
	if (vecRatingRoiRow3 != null)
	{
		vecRatingRoi3Size = vecRatingRoiRow3.size();
	}
	int vecRatingRoi4Size = 0;
	if (vecRatingRoiRow4 != null)
	{
		vecRatingRoi4Size = vecRatingRoiRow4.size();
	}
	int vecRatingRoi5Size = 0;
	if (vecRatingRoiRow5 != null)
	{
		vecRatingRoi5Size = vecRatingRoiRow5.size();
	}
	String strfacRating="";
	if(Helper.correctNull((String)hshValues.get("fac_interesttype")).contains("RATING"))
		strfacRating="Y";
	String strfacintdef=Helper.correctNull((String) hshValues.get("com_facintdef"));
	String strselinttype=Helper.correctNull((String) hshValues.get("sel_inttype"));
String strmaxresttenure=Helper.correctNull((String) session.getAttribute("strfacmaxperiodrest"));
	 
%>
<html>
<head>
<title>Setup(Corporate & Agriculture Products) - Int. & Tenors</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<%
	String strProductType = Helper.correctNull((String) session.getAttribute("strProductType"));
%>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script	src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script>
var fac_id ="<%=Helper.correctNull(request.getParameter("fac_id"))%>";
var val = "<%=request.getParameter("hidval")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var button;
var workid   = new Array();
var termfrom = new Array();
var termto   = new Array();
var termint  = new Array();
var varNoOfRatingDescription ="<%=intNoOfRatingDesc%>";
var var_flag="false";
var varRatingFlag = "<%=strfacRating%>";
var varRuleIDnew="<%=Helper.correctNull((String) hshValues
	.get("ruleid"))%>";
	
function openRatingBasedRoi(id)
{
	if (document.forms[0].cmdsave.disabled == true)
	{
		if(parseInt(varNoOfRatingDescription)>0) {
		var wrkflowtype="<%=strWrkflowtype%>";
		var from_date = document.forms[0].from[id].value;
		var to_date = document.forms[0].to[id].value;
		var ref_rate = document.forms[0].baserate[id].value;
		var interest_id="";
		var varRuleId = document.forms[0].ruleid.value;
		var chkapp = document.forms[0].checkApp.value;
		if(wrkflowtype=="fixed")
		{
			if(ref_rate=="")
			{
				 alert("Enter Reference Rate");
				 return;
			}
		}
		if(from_date!="" && to_date!="")
		{
			var varQryString = appUrl+"action/setratingbasedroicorporate.jsp?hidBeanGetMethod=getPerratingBasedROI&hidBeanId=setproducts&work="+wrkflowtype+"&slno="+id+"&from_date="+from_date+"&to_date="+to_date+"&varRuleId="+varRuleId+"&chkapp="+chkapp+"&ref_rate="+ref_rate+"&interest_id="+interest_id;
			var title = "Rating Based InterestRate";
			var prop = "scrollbars=yes,width=620,height=430";	
			prop = prop + ",left=100,top=150";	
			window.open(varQryString,"",prop);
		}
		else
		{
			if(from_date=="")
			{
			     alert("Enter Loan Period From");
			     document.forms[0].from[id].focus();
			}
			else if(to_date=="")
			{
				 alert("Enter Loan Period To");
			     document.forms[0].to[id].focus();
			}
		}
	}else
	{
		alert('There are no rating codes defined');
	}
}
	
	
}
function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdnew.disabled=true;
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].cmddelete.disabled=true;
		document.forms[0].cmdclose.disabled=false;
		if(val=="existing")
		{
		ShowAlert(144);
		}
	}
}
function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;
	document.forms[0].cmddelete.disabled=bool6;
}
function check_mandatory(val)
{
	if(val!="")
 	{
 		var_flag = "true";
 	}
}
function doRoi()
{	
	var code=document.forms[0].prdCode.value;
    var varQryString = appURL+"action/rating_roi.jsp?hidBeanId=setproducts&hidBeanGetMethod=getRatingData&code="+code;
	var title = "Rating Based ROI";
	var prop = "scrollbars=yes,menubar=yes,width=800,height=550";	
	prop = prop + ",left=100,top=50";
	window.open(varQryString,"",prop);
}
function totalInt(val)
{
	var baserate = parseFloat(document.forms[0].baserate[val].value);
	var adjrate  = parseFloat(document.forms[0].adjust[val].value);
	if(baserate == null || isNaN(baserate))
	{
		baserate = 0.00;
	}
	if(adjrate == null || isNaN(adjrate))
	{
		adjrate = 0.00;
	}
	document.forms[0].total[val].value = roundVal(baserate + adjrate);
}
function callFlowtype(type)
{
	if(type == "setuprate")
	{
		code=document.forms[0].prdCode.value;
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appURL+"controllerservlet?code="+code;
		document.forms[0].hidBeanId.value="setuprate";
		document.forms[0].hidBeanMethod.value="getData";
		document.forms[0].hidSourceUrl.value="/action/setuprate.jsp";
	}
	else if (type == "other")
	{
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appUrl+"action/setcorpinterestrate.jsp?wrk_flowtype1=floating&hidBeanId=setproducts&hidBeanGetMethod=getCorpOtherinterestTerm";
	}
	else
	{
		document.forms[0].wrk_flowtype1.value=type;
		document.forms[0].action=appUrl+"action/setfacilityintterms.jsp?wrk_flowtype1="+type+"&hidBeanId=setproducts&hidBeanGetMethod=corpinterestTerm";
	}
	document.forms[0].submit();
}
function loadValues()
{
	strtype= "<%=strType%>";
	if(strtype == "update_terms" || strtype == "show_terms")
	{
		document.forms[0].amtfrom.value="<%=Helper.correctNull((String) hshValues.get("rangefrom"))%>";
		document.forms[0].amtto.value="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
		document.forms[0].ruleid.value="<%=Helper.correctNull((String) hshValues.get("ruleid"))%>";
		document.forms[0].select_rule.value="<%=Helper.correctNull((String) hshValues.get("ruleid"))%>";
		//document.forms[0].sel_indtype.value="<%=Helper.correctNull((String) hshValues.get("selindtype"))%>";		
		//document.forms[0].sel_indtype.value="<%=Helper.correctNull((String) hshValues.get("corpprd_industrytype"))%>";
		//document.forms[0].sel_inttype.value="<%=Helper.correctNull((String) hshValues.get("corpprd_interesttype"))%>";
		document.forms[0].sel_inttype.value="<%=Helper.correctNull((String) hshValues
								.get("sel_inttype"))%>";
	}
	else if((strtype=="show_indterms")||(strtype=="insert_terms"))
	{
		//document.forms[0].sel_indtype.value="<%=Helper.correctNull((String) hshValues.get("selindtype"))%>";		
		//document.forms[0].sel_inttype.value="<%=Helper.correctNull((String) hshValues.get("selinttype"))%>";	
		document.forms[0].amtfrom.value="<%=Helper.correctNull((String) hshValues.get("rangefrom"))%>";
		document.forms[0].amtto.value="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
	}
	enableButtons(false,false,true,true,false,true);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		 document.forms[0].elements[i].readOnly=true;
		}	
	}
	if(document.forms[0].prd_saveflag.value=='Yes' && false)
	{
		document.forms[0].select_rule.value='0';
		document.forms[0].amtfrom.value='';
		document.forms[0].amtto.value='';
		for(i=0;i<=4;i++)
		{
			document.forms[0].from[i].value="";
			document.forms[0].to[i].value="";	
			document.forms[0].total[i].value="";
			document.forms[0].baserate[i].value="";
			if(document.forms[0].adjust[i]!=null){
			document.forms[0].adjust[i].value="";}
			document.forms[0].txtcreditrskpremium[i].value="";
			document.forms[0].txtbustratpremium[i].value="";
		}
		enableButtons(false,false,true,true,false,true);
	}
	if(document.forms[0].select_rule.value != '0')
		document.forms[0].cmdnew.disabled=true;
	document.forms[0].prd_saveflag.value="";
	showLabel();


	for(var i=0;i<document.forms[0].baserate.length;i++)
	{
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			document.all.idcrpvalue[i].style.display="inline";
			document.all.idbspvalue[i].style.display="inline";
			document.all.idcrplabel.style.display="inline";
			document.all.idbsplabel.style.display="inline";
			
			document.all.Idrefratelabel.style.display="none";
			document.all.Idadjustmentlabel.style.display="none";
			document.all.Idintratelabel.style.display="none";
			
			document.all.Idrefratevalue[i].style.display="none";
			document.all.Idadjustmentvalue[i].style.display="none";
			document.all.Idintratevalue[i].style.display="none";
		}
		else
		{
	
			document.all.Idrefratelabel.style.display="inline";
			document.all.Idadjustmentlabel.style.display="inline";
			document.all.Idintratelabel.style.display="inline";
			
			document.all.Idrefratevalue[i].style.display="inline";
			document.all.Idadjustmentvalue[i].style.display="inline";
			document.all.Idintratevalue[i].style.display="inline";
			
			document.all.idcrpvalue[i].style.display="none";
			document.all.idbspvalue[i].style.display="none";
			document.all.idcrplabel.style.display="none";
			document.all.idbsplabel.style.display="none";
		}
	}
	getRangeValues();
}
function doNew()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	
	if(document.forms[0].wrk_flowtype1.value=="floating")
	{
		if(document.forms[0].sel_inttype.value=="")
		{
			alert("Select Interest Type");
			return;	
		}
	}
	document.forms[0].hidValue.value="new";
	document.all.labelhelp.style.visibility="hidden";
	document.all.labelhelp1.style.visibility="hidden";
	work="<%=strWrkflowtype%>";
	for(i=0;i<=4;i++)
	{
		document.forms[0].from[i].value="";
		document.forms[0].to[i].value="";	
		document.forms[0].total[i].value="";
		document.forms[0].baserate[i].value="";
		if(document.forms[0].adjust[i]!=null){
		document.forms[0].adjust[i].value="";}
	}
	document.forms[0].amtfrom.value="";
	document.forms[0].amtto.value="";
	document.forms[0].sel_inttype.disabled=true;	
	button="a";
	clearHiddenVariables(varNoOfRatingDescription);
	enableButtons(true,true,false,false,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=false;
		}
	}
	for(var i=0;i<document.forms[0].baserate.length;i++)
	{
		document.forms[0].baserate[i].readOnly=true;
		document.forms[0].total[i].readOnly=true;
		//document.forms[0].tablecode_gen[i].readOnly=true;
	}
	document.forms[0].select_rule.disabled=false;
	showLabel();
}
function doEdit()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	if(document.forms[0].select_rule.value == "0")
	{
		alert("Select Interest Range");
		return;
	}
	button="e";
	enableButtons(true,true,false,false,true,false);
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			document.forms[0].elements[i].readOnly=false;
		}
	}
	for(var i=0;i<document.forms[0].baserate.length;i++)
	{
		document.forms[0].baserate[i].readOnly=true;
		document.forms[0].total[i].readOnly=true;
		//document.forms[0].tablecode_gen[i].readOnly=true;
	}
	document.forms[0].select_rule.disabled=false;
}
function clearHiddenVariables(varNoOfRatingDescription)
{
	for(var i=0;i<varNoOfRatingDescription;i++)
	{
		document.forms[0].hidroi_from1[i].value="";
		document.forms[0].hidroi_to1[i].value="";
		document.forms[0].hidroi_baserate1[i].value="";
		document.forms[0].hidroi_interestid1[i].value="";

		/*document.forms[0].hidroi_adjust1[i].value="";
		document.forms[0].hidroi_total1[i].value="";
		document.forms[0].hidroi_tablecode1[i].value="";
		document.forms[0].hidroi_ratingsno1[i].value="";
		document.forms[0].hidroi_ratingdesc1[i].value="";
		document.forms[0].hidroi_ratingadj1[i].value="";
		document.forms[0].hidroi_ratingtot1[i].value="";*/
	}
	for(var i=0;i<varNoOfRatingDescription;i++)
	{
		document.forms[0].hidroi_from2[i].value="";
		document.forms[0].hidroi_to2[i].value="";
		document.forms[0].hidroi_baserate2[i].value="";
		document.forms[0].hidroi_interestid2[i].value="";
		
		/*document.forms[0].hidroi_adjust2[i].value="";
		document.forms[0].hidroi_total2[i].value="";
		document.forms[0].hidroi_tablecode2[i].value="";
		document.forms[0].hidroi_ratingsno2[i].value="";
		document.forms[0].hidroi_ratingdesc2[i].value="";
		document.forms[0].hidroi_ratingadj2[i].value="";
		document.forms[0].hidroi_ratingtot2[i].value="";
		*/
	}
	for(var i=0;i<varNoOfRatingDescription;i++)
	{
		document.forms[0].hidroi_from3[i].value="";
		document.forms[0].hidroi_to3[i].value="";
		document.forms[0].hidroi_baserate3[i].value="";
		document.forms[0].hidroi_interestid3[i].value="";
		
		/*document.forms[0].hidroi_adjust3[i].value="";
		document.forms[0].hidroi_total3[i].value="";
		document.forms[0].hidroi_tablecode3[i].value="";
		document.forms[0].hidroi_ratingsno3[i].value="";
		document.forms[0].hidroi_ratingdesc3[i].value="";
		document.forms[0].hidroi_ratingadj3[i].value="";
		document.forms[0].hidroi_ratingtot3[i].value="";
		*/
	}
	for(var i=0;i<varNoOfRatingDescription;i++)
	{
		document.forms[0].hidroi_from4[i].value="";
		document.forms[0].hidroi_to4[i].value="";
		document.forms[0].hidroi_baserate4[i].value="";
		document.forms[0].hidroi_interestid4[i].value="";
		/*
		document.forms[0].hidroi_adjust4[i].value="";
		document.forms[0].hidroi_total4[i].value="";
		document.forms[0].hidroi_tablecode4[i].value="";
		document.forms[0].hidroi_ratingsno4[i].value="";
		document.forms[0].hidroi_ratingdesc4[i].value="";
		document.forms[0].hidroi_ratingadj4[i].value="";
		document.forms[0].hidroi_ratingtot4[i].value="";
		*/
	}
	for(var i=0;i<varNoOfRatingDescription;i++)
	{
		document.forms[0].hidroi_from5[i].value="";
		document.forms[0].hidroi_to5[i].value="";
		document.forms[0].hidroi_baserate5[i].value="";
		document.forms[0].hidroi_interestid5[i].value="";
		
		/*document.forms[0].hidroi_adjust5[i].value="";
		document.forms[0].hidroi_total5[i].value="";
		document.forms[0].hidroi_tablecode5[i].value="";
		document.forms[0].hidroi_ratingsno5[i].value="";
		document.forms[0].hidroi_ratingdesc5[i].value="";
		document.forms[0].hidroi_ratingadj5[i].value="";
		document.forms[0].hidroi_ratingtot5[i].value="";
		*/
	}
}
function doSave()
{
	var flag = true;
	if (document.forms[0].wrk_flowtype1.value == "" )
	{
		document.forms[0].wrk_flowtype1.value = "fixed"
	}
	flag = true;
	if(parseFloat(document.forms[0].amtto.value) <  parseFloat(document.forms[0].amtfrom.value))
	{
		alert("The From Range Should Be Less Than To Range");
		return;
	}
	if ((parseFloat(document.forms[0].amtto.value)== 0)||(parseFloat(document.forms[0].amtto.value)== 0.00))
	{
		alert("To Range shouldnot be Zero");
		return;
	}
	for(var k=0;k<document.forms[0].from.length;k++)
	{
		if(document.forms[0].from[k].value=="" && document.forms[0].baserate[k].value!="")
		{
			alert("Enter the Loan period from");
			return;
		}
	}
	for(var k=0;k<document.forms[0].to.length;k++)
	{
		if(document.forms[0].to[k].value=="" && document.forms[0].baserate[k].value!="")
		{
			alert("Enter the Loan period to");
			return;
		}
	}
	if (flag != false)
	{
		if (document.all.labelhelp.style.visibility == "hidden")
		{
			if (document.forms[0].amtfrom.value != "" && document.forms[0].amtto.value != "")
			{
				work="<%=strWrkflowtype%>";
				if (work == "")
				{
					work="fixed";
				}
				var count=0;
				for(var i=0; i<document.forms[0].from.length;i++)
				{
					if(document.forms[0].from[i].value=="")
					{
						count = eval(count)+1;
					}
				}
				if(eval(count)==5)
				{
					alert("Enter Data");
					return;
				}
				for(var i=0;i<document.forms[0].baserate.length;i++)
				{
					if(document.forms[0].wrk_flowtype1.value=="fixed" && document.forms[0].from[i].value != "" && document.forms[0].baserate[i].value == "")
					{
						alert("Enter Reference Rate");
						return;
					}
					if(document.forms[0].from[i].value != "")
					{
						if(parseFloat(document.forms[0].from[i].value) > parseFloat(document.forms[0].to[i].value))
							{
								alert("From Range should Be Lesser Than To Range");
								return ;
							}
					}
					if(document.forms[0].baserate[i].value !="")
					{
						totalInt(i);
					}

					if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtcreditrskpremium[i].value == "")
					{
						alert("Enter Credit Business  Premium Rate");
						return;
					}
					
					if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtbustratpremium[i].value == "")
					{
						alert("Enter Business Strategic Premium  Rate");
						return;
					}
				}
				/*if(document.forms[0].from[0].value!="")
				{
					for(var j=0;j<document.forms[0].hidroi_baserate1.length;j++)
					{
						check_mandatory(document.forms[0].hidroi_baserate1[j].value);
					}
					if(var_flag=="false")
					{
						alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[0].value+"-"+document.forms[0].to[0].value);
						return;
					}
				}
				var_flag = "false";
				if(document.forms[0].from[1].value!="")
				{
					for(var j=0;j<document.forms[0].hidroi_baserate2.length;j++)
					{
						check_mandatory(document.forms[0].hidroi_baserate2[j].value);
					}
					if(var_flag=="false")
					{
						alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[1].value+"-"+document.forms[0].to[1].value);
						return;
					}
				}
				var_flag = "false";
				if(document.forms[0].from[2].value!="")
				{
					for(var j=0;j<document.forms[0].hidroi_from3.length;j++)
					{
						check_mandatory(document.forms[0].hidroi_from3[j].value);
					}
					if(var_flag=="false")
					{
						alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[2].value+"-"+document.forms[0].to[2].value);
						return;
					}
				}
				var_flag = "false";
				if(document.forms[0].from[3].value!="")
				{
					for(var j=0;j<document.forms[0].hidroi_from4.length;j++)
					{
						check_mandatory(document.forms[0].hidroi_from4[j].value);
					}
					if(var_flag=="false")
					{
						alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[3].value+"-"+document.forms[0].to[3].value);
						return;
					}
				}
				var_flag = "false";
				if(document.forms[0].from[4].value!="")
				{
					for(var j=0;j<document.forms[0].hidroi_from5.length;j++)
					{
						check_mandatory(document.forms[0].hidroi_from5[j].value);
					}
					if(var_flag=="false")
					{
						alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[4].value+"-"+document.forms[0].to[4].value);
						return;
					}
				}*/
			document.forms[0].cmdsave.disabled = true;
			document.forms[0].sel_inttype.disabled=false;				
			document.forms[0].prd_saveflag.value="Yes";
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].hidval.value="insert_terms";
			document.forms[0].hidAction.value="insert";
			document.forms[0].hidBeanGetMethod.value="corpinterestTerm";		
			document.forms[0].action=appURL+"action/setfacilityintterms.jsp?work="+work;		
			document.forms[0].submit();
			}
			else
			{
				alert("Enter the range");
			}
		}
		if(document.all.labelhelp.style.visibility != "hidden")
		{
			if(document.forms[0].select_rule.value != "0")
			{
				if(document.forms[0].amtfrom.value != "" && document.forms[0].amtto.value != "" )
				{	
					for(var i=0;i<document.forms[0].baserate.length;i++)
					{
						if(document.forms[0].wrk_flowtype1.value=="fixed" && document.forms[0].from[i].value != "" && document.forms[0].baserate[i].value=="")
						{
							alert("Enter Reference Rate");
							return;
						}
						if(parseFloat(document.forms[0].from[i].value) != "")
						{
							if(parseFloat(document.forms[0].from[i].value) > parseFloat(document.forms[0].to[i].value))
							{
								alert("From Range should Be Lesser Than To Range");
								return ;
							}
						}
						if(parseFloat(document.forms[0].baserate[i].value) !="")
						{
								totalInt(i);
						}

						if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtcreditrskpremium[i].value == "")
						{
							alert("Enter Credit Business  Premium Rate");
							document.forms[0].txtcreditrskpremium[i].focus();
							return;
						}
						
						if(document.forms[0].wrk_flowtype1.value=="floating" && document.forms[0].from[i].value != "" && document.forms[0].txtbustratpremium[i].value == "")
						{
							alert("Enter Business Strategic Premium  Rate");
							document.forms[0].txtbustratpremium[i].focus();
							return;
						}
					}
					/*if(document.forms[0].from[0].value!="")
					{
						for(var j=0;j<document.forms[0].hidroi_baserate1.length;j++)
						{
							check_mandatory(document.forms[0].hidroi_baserate1[j].value);
						}
						if(var_flag=="false")
						{
							alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[0].value+"-"+document.forms[0].to[0].value);
							return;
						}
					}
					var_flag = "false";
					if(document.forms[0].from[1].value!="")
					{
						for(var j=0;j<document.forms[0].hidroi_baserate2.length;j++)
						{
							check_mandatory(document.forms[0].hidroi_baserate2[j].value);
						}
						if(var_flag=="false")
						{
							alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[1].value+"-"+document.forms[0].to[1].value);
							return;
						}
					}
					var_flag = "false";
					if(document.forms[0].from[2].value!="")
					{
						for(var j=0;j<document.forms[0].hidroi_from3.length;j++)
						{
							check_mandatory(document.forms[0].hidroi_from3[j].value);
						}
						if(var_flag=="false")
						{
							alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[2].value+"-"+document.forms[0].to[2].value);
							return;
						}
					}
					var_flag = "false";
					if(document.forms[0].from[3].value!="")
					{
						for(var j=0;j<document.forms[0].hidroi_from4.length;j++)
						{
							check_mandatory(document.forms[0].hidroi_from4[j].value);
						}
						if(var_flag=="false")
						{
							alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[3].value+"-"+document.forms[0].to[3].value);
							return;
						}
					}
					var_flag = "false";
					if(document.forms[0].from[4].value!="")
					{
						for(var j=0;j<document.forms[0].hidroi_from5.length;j++)
						{
							check_mandatory(document.forms[0].hidroi_from5[j].value);
						}
						if(var_flag=="false")
						{
							alert("Enter Rating Based ROI for the Loan Period"+document.forms[0].from[4].value+"-"+document.forms[0].to[4].value);
							return;
						}
					}*/
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].ruleid.value = document.forms[0].select_rule.value;
					work="<%=strWrkflowtype%>";
					document.forms[0].prd_saveflag.value="Yes";
					document.forms[0].action=appURL+"action/setfacilityintterms.jsp?work="+work;
					document.forms[0].hidBeanId.value="setproducts";
					document.forms[0].hidval.value="update_terms";
					document.forms[0].hidAction.value="update";
					document.forms[0].hidBeanGetMethod.value="corpinterestTerm";
					document.forms[0].submit();
				}
				else
				{
					alert("Enter The Range");
				}
			}
		}
	}
	else
	{
		alert("Enter the Value of the Fields Properly");
	}
}
function checktoamtval()
{
	var comrangefrom="<%=Helper.correctNull((String) hshValues.get("com_rangefrom"))%>";
	var comrangeto="<%=Helper.correctNull((String) hshValues.get("com_rangeto"))%>";
	var comminrepayperiod="<%=Helper.correctNull((String) hshValues.get("com_minrepayperiod"))%>";
	var commaxrepayperiod="<%=strmaxresttenure%>";
	var amtfromvalue=document.forms[0].amtfrom.value;
	var amttovalue=document.forms[0].amtto.value;
	for(i=0;i<5;i++)
	{
		var repayfrom=document.forms[0].from[i].value;
		var repayto=document.forms[0].to[i].value;
		if(eval(comminrepayperiod)< eval(repayfrom) && (eval(repayfrom) >= eval(commaxrepayperiod)))
		{
			alert("Loan period From should be less than Loan period To");
			return;
		}
		if(eval(commaxrepayperiod) < eval(repayto) ) 
		{
			alert("Loan period To  should not be Greater than Max Loan period of Product");
			return;
		}
	}
	if(eval(comrangefrom)> eval(amtfromvalue))
	{
		alert("From Range should be Equal to product Range From amount");
		document.forms[0].amtfrom.value="";
		return false;
	}
	if(eval(comrangeto)< eval(amttovalue)) 
	{
		alert("To Range should be less or Equal to product Range To amount");
		document.forms[0].amtto.focus();
		document.forms[0].amtto.value="";
		return;
	}
}
function doDelete()
{
	if(document.forms[0].select_rule.value==0)
	{
	  alert("Select the Interest Range");
	  return;
	}
	if(confirm("Do you really want to delete the Interest Range ?"))
	{
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanMethod.value="deletecorpTerms";
		document.forms[0].hidBeanGetMethod.value="corpinterestTerm";
		document.forms[0].hidSourceUrl.value="/action/setfacilityintterms.jsp";
		document.forms[0].submit();
	}
}
function opendis(num)
{
	var purl = appUrl+"jsp/set/floatselect?identity=floating&num="+num;
	var prop = "scrollbars=no,width=350,height=320";	
	var title = "InterestRate";
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function checkvalues()
{
	var x=document.forms[0].from[0].value;
	var x1 =parseInt(document.forms[0].from[1].value);
	var x2=parseInt(document.forms[0].from[2].value);
	var x3=parseInt(document.forms[0].from[3].value);
	var x4=parseInt(document.forms[0].from[4].value);
	var y=parseInt(document.forms[0].to[0].value);
	var y1=parseInt(document.forms[0].to[1].value);
	var y2=parseInt(document.forms[0].to[2].value);
	var y3=parseInt(document.forms[0].to[3].value);
	var y4=parseInt(document.forms[0].to[4].value);
	if(x1<=y)
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].from[1].focus();
	 	return;
	}
	else if(x2<=y1)
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].from[2].focus();
	 	return;
	}
	else if(x3<=y2)
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].from[3].focus();
	 	return;
	}
	else if(x4<=y3)
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].from[4].focus();
	 	return;
	}
	if((y1<=x)||(y>=y1))
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].to[1].focus();
	 	return;
	}
	else if((y2<=x1)||(y1>=y2))
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].to[2].focus();
	 	return;
	}
	else if((y3<=x2)||(y2>=y3))
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].to[3].focus();
	 	return;
	}
	else if((y4<=x3)||(y3>=y4))
	{
		alert("Checking the Existing Loan Period");
		document.forms[0].to[4].focus();
	 	return;
	}
}
function opendisfixed(num,field)
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		return false;
	}
	var inttype="";//document.forms[0].sel_inttype.value;
	if(document.forms[0].from[num].value=="")
	{
		alert("Enter Loan Period From ");
		document.forms[0].from[num].focus();
		return;
	}
	if(document.forms[0].to[num].value=="")
	{
		alert("Enter Loan Period To");
		document.forms[0].to[num].focus();
		return;
	}
	if (document.forms[0].cmdedit.disabled == true)
	{
		var flag="corp";
		var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating&interesttype="+inttype+"&flag="+flag;
		var prop = "scrollbars=no,width=450,height=360";	
		var title = "InterestRate";
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,title,prop);
	}
	else
	{
		alert("Click Edit/New To change");
	}
}
function getvalues()
{
	if( document.forms[0].select_rule.value != "0")
	{
		document.forms[0].ruleid.value = document.forms[0].select_rule.value;
		var	id=document.forms[0].select_rule.options[document.forms[0].select_rule.selectedIndex].text;
		arr=id.split("---");
		document.forms[0].amtfrom.value=arr[0];
		document.forms[0].amtto.value=arr[1];
		from=arr[0];
		to=arr[1]
		work=document.forms[0].wrk_flowtype1.value;
		document.forms[0].action=appURL+"action/setfacilityintterms.jsp?amfrom="+from+"&amto="+to+"&work="+work;
		document.forms[0].hidBeanId.value="setproducts";
		document.forms[0].hidBeanGetMethod.value="corpinterestTerm";
		document.forms[0].hidval.value="show_terms";
		document.forms[0].submit();
	}
}
function getindvalues()
{
	//document.forms[0].selindtype1.value = document.forms[0].sel_indtype.value;
	//document.forms[0].selinttype1.value = document.forms[0].sel_inttype.value;
	//var	id2=document.forms[0].sel_indtype.options[document.forms[0].sel_indtype.selectedIndex].text;
	/*if((document.forms[0].sel_inttype.value=="0")||(document.forms[0].sel_inttype.value==""))
	{
		document.forms[0].select_rule.disabled=true;
		document.forms[0].sel_inttype.value=="0"
		alert("Select the Interest Type");
		return ;
	}*/
	work=document.forms[0].wrk_flowtype1.value;
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanMethod.value="corpinterestTerm";
	document.forms[0].hidBeanGetMethod.value="corpinterestTerm";
	document.forms[0].hidval.value="show_indterms";
	document.forms[0].hidSourceUrl.value="/action/setfacilityintterms.jsp";
	document.forms[0].submit();
}
function doCancel()
{
	if (ConfirmMsg(102))
	{
		work="<%=strWrkflowtype%>";
		if (work == "floating")
		{
			for(i=0;i<5;i++)
			{
				document.forms[0].from[i].value="";
				document.forms[0].to[i].value="";	
				document.forms[0].total[i].value="";
				document.forms[0].baserate[i].value="";
				if(document.forms[0].adjust[i]!=null)
				document.forms[0].adjust[i].value="";
			}
		}
		else
		{
			for(i=0;i<=4;i++)
			{
				document.forms[0].from[i].value="";
				document.forms[0].to[i].value="";	
				document.forms[0].total[i].value="";
				document.forms[0].baserate[i].value="";
				if(document.forms[0].adjust[i]!=null)
				document.forms[0].adjust[i].value="";
			}
		}
		document.forms[0].amtfrom.value="";
		document.forms[0].amtto.value="";
	    for(var i=0;i<document.forms[0].elements.length;i++)
		{
			if(document.forms[0].elements[i].type=="text")
			{
			  document.forms[0].elements[i].readOnly=true;
			}
		}
		document.all.labelhelp.style.visibility="visible";
		document.all.labelhelp1.style.visibility="visible";
		document.forms[0].select_rule.value="0";
		document.forms[0].sel_inttype.value="";
		document.forms[0].sel_inttype.disabled=false;
		enableButtons(false,false,true,true,false,true);
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appUrl+"action/comfacilityhome.jsp";
		document.forms[0].submit();
	}
}
function dohlp()
{
	var hlpvar = appUrl+"phlp/setup_retailprod_interestandterms.htm";
	var title = "InterestTerms";
	var prop = "scrollbars=yes,width=600,height=450";	
	prop = prop + ",left=50,top=150";
	window.open(hlpvar,title,prop);
}
function callTableCode()
{
	if(document.forms[0].cmdsave.disabled==true)
	{
		return false;
	}
	var inttype="";//document.forms[0].sel_inttype.value;
 	if(document.forms[0].from[num].value=="")
  	{
		alert("Enter Loan Period From ");
		document.forms[0].from[num].focus();
		return;
	}
	if(document.forms[0].to[num].value=="")
	{
		alert("Enter Loan Period To");
		document.forms[0].to[num].focus();
		return;
	}
	if(document.forms[0].cmdedit.disabled == true)
	{
		var varArrRatingDescSize = "5";
		var prop="scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appUrl+"action/setcbstablecodelist.jsp?Array_size="+varArrRatingDescSize+"&strfrom=intrate&pagefrom=corp";
		window.open(url,"hai",prop);
	}
	else
	{
		alert("Click Edit/New To change");
	}
}
function callTableCode(intt)
{	
	if(document.forms[0].cmdsave.disabled==true)
	{
		return false;
	}
	var inttype="";//document.forms[0].sel_inttype.value;
	if(document.forms[0].from[intt].value=="")
	{
		alert("Enter Loan Period From ");
		document.forms[0].from[intt].focus();
		return;
	}
	if(document.forms[0].to[intt].value=="")
	{
		alert("Enter Loan Period To");
		document.forms[0].to[intt].focus();
		return;
	}
	if (document.forms[0].cmdedit.disabled == true)
	{
		var intnumber=intt;
		var varArrRatingDescSize = "5";
		var prop="scrollbars=no,width=300,height=300,top=100,left=250";
		var url=appUrl+"action/setcbstablecodelist.jsp?Array_size="+varArrRatingDescSize+"&intNum="+intnumber+"&strfrom=intrate&pagefrom=corp";
		window.open(url,"hai",prop);
	}
	else
	{
	  alert("Click Edit/New To change");
	}
}
function showLabel()
{
	var varOption = document.forms[0].select_rule.value;
	if((varRatingFlag == "Y" && !(varOption== "0" || varOption == "")) || (varRatingFlag == "Y" && document.forms[0].hidValue.value == "new"))
	{
		document.all.label.style.visibility="visible";
	}
	else
	{
		document.all.label.style.visibility="hidden";
	}
}
function getRangeValues()
{
	document.all.ifrminterest.src=appUrl+"action/iframeinttypes.jsp?hidBeanGetMethod=getOtherinterestTypes&hidBeanId=setproducts&prdCode="+document.forms[0].prdCode.value+"&inttype="+document.forms[0].wrk_flowtype1.value+"&interestfor="+document.forms[0].sel_inttype.value+"&strRule="+varRuleIDnew+"&strModule=C&strROIType=O";
}	
function clearfields()
{
	for(i=0;i<=4;i++)
	{
	  document.forms[0].from[i].value="";
	  document.forms[0].to[i].value="";	
	  document.forms[0].txtbustratpremium[i].value="";	
	  document.forms[0].txtcreditrskpremium[i].value="";	
	}
	document.forms[0].amtfrom.value="";
	document.forms[0].amtto.value="";
    for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
	}
	document.all.labelhelp1.innerText="Select Interest Range";
	document.all.labelhelp.style.visibility="visible";
	varRuleIDnew="";
	document.forms[0].select_rule.value="";
	enableButtons(false,true,true,true,false,true);
}
</script>
<style>
.navlist {
	padding: 3px 0;
	margin-left: 0;
	border-bottom: 1px solid #778;
	font: bold 12px Verdana, sans-serif;
}
.navlist li {
	list-style: none;
	margin: 0;
	display: inline;
}
.navlist li a,.navlist li a.normal {
	padding: 2px 0.5em 3px 0.5em;
	margin-left: 3px;
	border: 1px solid #778;
	border-bottom: none;
	background: #DDE;
	text-decoration: none;
}
.navlist li a:link {
	color: #448;
}
.navlist li a:visited {
	color: #667;
}
.navlist li a:hover {
	color: #000;
	background: #AAE;
	border-color: #227;
}
.navlist li a.current {
	background: white;
	border-bottom: 1px solid white;
}
</style>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/headmenu.js"></script>
<script language="JavaScript" src="<%=ApplicationParams.getAppUrl()%>js/share/keytrap.js"></script>
</head>
<body onLoad="loadValues();loadUsedApp()">
<form name="documentsfrm" method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
<tr>
	<td>
		<jsp:include page="../share/help.jsp" flush="true"/>
		<jsp:include page="../share/menus.jsp" flush="true"/>
	</td>
</tr>
</table>
<lapstab:setproductstabcorp tabid="4" />
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
<tr>
	<td class="page_flow">Home -&gt; Setup -&gt; Corporate &amp; Agri Products -&gt; Facility Creation -&gt; Interest and Terms</td>
</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center">
<tr> 
	<td> 
		<table width="100%" border="0" cellspacing="0" cellpadding="5">
		<tr>
			<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="5">
				<tr>
					<td valign="top">
						<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="0">
						<tr>
							<td valign="top">
								<table width="100%" border="0" cellspacing="0" cellpadding="1" class="outertable">
								<tr>
									<td><lapschoice:facility /></td>
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
<table width="98%" border="0" cellspacing="0" cellpadding="3" align="center">
<tr>
	<td>
		<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
		<tr>
		<%if(strfacintdef.equalsIgnoreCase("F")){ %>
			<td width="50%" align="center"
				<%if(strWrkflowtype.equals("fixed") || strWrkflowtype.equals(""))
				{%> class="sub_tab_active" <%} else {%> class="sub_tab_inactive" <%}%>>
				<%if(strWrkflowtype.equals("fixed") || strWrkflowtype.equals("")){%>
				Fixed Rate
				<%}else{%>
				<a href="javascript:callFlowtype('fixed')">Fixed Rate</a>
				<%}%>
			</td>
			<%} %>
			<%if(!(strfacintdef.equalsIgnoreCase("M")||strfacintdef.equalsIgnoreCase("F"))){ %>
			<td width="50%" align="center"
				<%if(strWrkflowtype.equals("floating"))
				{%> class="sub_tab_active" <%} else {%> class="sub_tab_inactive" <%}%>>
				<%if(strWrkflowtype.equals("floating") || strWrkflowtype.equals("")) {%>
				Floating
				<%}else{%>
				<a href="javascript:callFlowtype('floating')">Floating</a>
				<%}%>
			</td>
			<td align="center" class="sub_tab_inactive"> <a href="javascript:callFlowtype('other')">Other Rates</a></td>
			<%} %>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" border="0" class="outertable border1" cellspacing="0" cellpadding="1">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="3" cellspacing="1" class="outertable">
				<%if(strWrkflowtype.equals("floating"))
				{%>
					<tr>
								<td>Reference type</td>
								<td><select name=sel_inttype tabindex="1" onchange="clearfields();getRangeValues();">
									<option value="">--------------Select--------------</option>
									<lapschoice:interesttype appmodule="R"  appvalue='<%=request.getParameter("fac_id")%>'/>
								</select></td>
					</tr>
					<tr>					
					<td id="labelhelp1">Select Interest Range</td>
					<td>
						<select name="select_rule" id="labelhelp" onchange="getvalues();" style="width: 250px">
							<option value="0">--------------Select--------------</option>
						</select>
					</td>
				</tr>
				<%}else{%>
				<tr>
					<td width="25%" style="display: none;">Interest Type</td>
					<td width="25%" style="display: none;">
						<select name="sel_inttype">
							<option value="O" selected="selected">NONE</option>
						</select>
					</td>
					<td width="25%" id="labelhelp1">Select Interest Range</td>
					<td width="75%" colspan="3">
						<select name="select_rule" id="labelhelp" onchange="getvalues();showLabel()" style="width: 250px">
							<option value="0">--------------Select--------------</option>
							<lapschoice:corpfixedfloat apptype="O" />
						</select>
					</td>
				</tr>
				<%}%>
				<tr>
					<td>Amount Range From</td>
					<td>
						<lapschoice:CurrencyTag name="amtfrom" maxlength="18"
							size="18" onBlur="checktoamtval()" />
					</td>
					<td>Amount Range To</td>
					<td>
						<lapschoice:CurrencyTag name="amtto" maxlength="18"
							size="18" onBlur="checktoamtval()" />
					</td>
				</tr>
				</table>
			</td>
		</tr>
		</table>
	</td>
</tr>
<tr>
	<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="0">
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="outertable">
				<tr class="dataheader">
					<td width="6%" align="center">S.No</td>
					<td width="13%" align="center">Loan Period From</td>
					<td width="13%" align="center">Loan Period To</td>
					<td width="16%" align="center" id="Idrefratelabel">Reference Rate</td>
					<td width="13%" align="center" id="Idadjustmentlabel">Adjustments (+/-)</td>
					<td width="14%" align="center" id="Idintratelabel">Interest Rate (%)</td>
					<td width="13%" align="center" id="idcrplabel">Credit Risk Premium</td>
					<td width="14%" align="center" id="idbsplabel">Business Strategic Premium</td>
					<%if(strfacRating.equalsIgnoreCase("y")){ %>
					<td width="11%" align="center">Rating based ROI</td>
					<%} %>
				</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td>
				<table width="100%" border="0" cellpadding="1" cellspacing="1" class="outertable">
					<%
						ArrayList g1 = null;
						for (int l = 0; l < 5; l++)
						{
							int colSize = 0;
							if (l < vecsize)
							{
								g1 = (ArrayList) v.get(l);
								if (g1 != null)
								{
									colSize = g1.size();
								}
							}
							if (colSize > 0)
							{
					%>
				<tr class="datagrid">
					<td width="6%" align="center">
						<input type="hidden" name="line" value="<%=l + 1%>"> <%=l + 1%>
					</td>
					<td width="13%" align="center">
						<input type="text" name="from" maxlength="8" style="text-align: right"
							onKeyPress="allowNumber(this)" onBlur="checkvalues();checktoamtval()" size="12"
							value="<%=Helper.correctNull((String) g1.get(0))%>">
					</td>
					<td width="13%" align="center">
						<input type="text" name="to" maxlength="11" style="text-align: right"
							onKeyPress="allowNumber(this)" size="12" onBlur="checkvalues();checktoamtval()"
							value="<%=Helper.correctNull((String) g1.get(1))%>">
					</td>
					<td width="16%" align="center" id="Idrefratevalue">
						<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
						<tr>
							<td width="75%">
								<input type="text" name="baserate" maxlength="8"
									readonly="readonly" onKeyPress="allowInteger()" size="15"
									value="<%=Helper.correctNull((String) g1.get(2))%>">
							</td>
							<td width="25%">
								<span onClick="opendisfixed('<%=l%>','baserate')" style="cursor: hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</span>
							</td>
						</tr>
						</table>
					</td>
					<td width="13%" align="center" id="Idadjustmentvalue">
						<INPUT TYPE="text" NAME="adjust" MAXLENGTH="8" SIZE="12"
							ONKEYPRESS="allowAdjustment(this)" ONBLUR="totalInt('<%=l%>')"
							VALUE="<%=Helper.correctNull((String) g1.get(3))%>">
					</td>
					<td width="14%" align="center" id="Idintratevalue">
						<input type="text" name="total" maxlength="8" onKeyPress="allowNumber(this);"
							size="12" onBlur="checkPercentage(this),roundtxt(this)"
							value="<%=Helper.correctNull((String) g1.get(4))%>">
					</td>
					<td width="13%" align="center" id="idcrpvalue">
						<input type="text" name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);"  style="text-align: right;" size="12" onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(10))%>'/>
					</td>
					<td width="14%" align="center" id="idbspvalue">
						<input type="text" name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);"  style="text-align: right;" size="12" onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(11))%>'/>
					</td>
						<input type="hidden" name="interestid" maxlength="8" readonly="readonly"
							value="<%=Helper.correctNull((String) g1.get(5))%>">
					<%if(strfacRating.equalsIgnoreCase("y")) {
						if(!Helper.correctNull((String) g1.get(0)).equals("") && !Helper.correctNull((String) g1.get(1)).equals("")) {
						%>
					<td width="11%" align="center" >
						<span onClick="openRatingBasedRoi('<%=l%>')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
						</span>
					</td>
					<%} else {%>
					<td width="11%" align="center" >&nbsp;
					</td>
					<%} } %>
				</tr>
					<%
							}
							else
							{
					%>
				<tr class="datagrid">
					<td width="6%" align="center">
						<input type="hidden" name="line" value="<%=l + 1%>"> <%=l + 1%>
					</td>
					<td width="13%" align="center">
						<input type="text" name="from" maxlength="8" style="text-align: right"
							onKeyPress="allowNumber(this)" onBlur="checkvalues();checktoamtval()" size="12">
					</td>
					<td width="13%" align="center">
						<input type="text" name="to" maxlength="8" style="text-align: right"
							onKeyPress="allowNumber(this)" onBlur="checkvalues();checktoamtval()" size="12">
					</td>
					<td width="16%" align="center" id="Idrefratevalue">
						<table width="60%" border="0" cellspacing="1" cellpadding="3" class="outertable">
						<tr>
							<td width="75%">
								<input type="text" name="baserate" maxlength="8"
									readonly="readonly" onKeyPress="allowInteger()" size="15">
							</td>
							<td width="25%">
								<span onClick="opendisfixed('<%=l%>','baserate')" style="cursor: hand">
								<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
								</span>
							</td>
						</tr>
						</table>
					</td>
					<td width="13%" align="center" id="Idadjustmentvalue">
						<INPUT TYPE="text" NAME="adjust" MAXLENGTH="8" SIZE="12"
							ONKEYPRESS="allowAdjustment(this)" ONBLUR="totalInt('<%=l%>')">
					</td>
					<td width="14%" align="center" id="Idintratevalue">
						<input type="text" name="total" maxlength="8" onKeyPress="allowNumber(this)"
							size="12" onBlur="checkPercentage(this),roundtxt(this)">
					</td>
					<td width="13%" align="center" id="idcrpvalue">
						<input type="text"  name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/>
					</td>
					<td width="14%" align="center" id="idbspvalue">
						<input type="text"  name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" onkeypress="allowNumber(this)" size="12"/>
					</td>
					<input type="hidden" name="interestid" maxlength="8" readonly="readonly">
					<%if(strfacRating.equalsIgnoreCase("y")) { %>
					<td width="11%" align="center">
				&nbsp;
					</td>
					<%} %>
				</tr>
					<%
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
<table width="100%" id="label">
<tr>
<td align="center"><font color="red">Note : After save the changes please fill the pages under Rating Based ROI heading.</font></td>
</tr>
</table> 
<lapschoice:combuttonnew btnnames='New_Edit_Save_Cancel_Delete_Audit Trial'
					btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<br>
<%
	if(intNoOfRatingDesc == 1)
	{
		intNoOfRatingDesc = intNoOfRatingDesc + 1;
	}
 	for(int i = 0; i < intNoOfRatingDesc; i++)
 	{
 		int colSize = 0;
 		
 			g1 = (ArrayList) vecRatingRoiRow1.get(0);
 			if(g1 != null)
 			{
 				colSize = g1.size();
 			}
 		
 		if(colSize > 0)
 		{
%>
<input type="hidden" name="hidroi_from1" size="12" value="<%=g1.get(0)%>">
<input type="hidden" name="hidroi_to1" size="12" value="<%=g1.get(1)%>">
<input type="hidden" name="hidroi_baserate1" size="12" value="<%=g1.get(2)%>">
<input type="hidden" name="hidroi_interestid1" value="<%=g1.get(3)%>">
<input type="hidden" name="hidroi_interestsno1" value="1">
<%
		}
 		else
 		{
%>
<input type="hidden" name="hidroi_from1" size="12" value="">
<input type="hidden" name="hidroi_to1" size="12" value="">
<input type="hidden" name="hidroi_baserate1" size="12" value="">
<input type="hidden" name="hidroi_interestid1" value="">
<input type="hidden" name="hidroi_interestsno1" value="1">
<%
		}
	}
 	for(int i = 0; i < intNoOfRatingDesc; i++)
 	{
 		int colSize = 0;
 		
 			g1 = (ArrayList) vecRatingRoiRow2.get(0);
 			if(g1 != null)
 			{
 				colSize = g1.size();
 			}
 		
 		if(colSize > 0)
 		{
%>
<input type="hidden" name="hidroi_from2" size="12" value="<%=g1.get(0)%>">
<input type="hidden" name="hidroi_to2" size="12" value="<%=g1.get(1)%>">
<input type="hidden" name="hidroi_baserate2" size="12" value="<%=g1.get(2)%>">
<input type="hidden" name="hidroi_interestid2" value="<%=g1.get(3)%>">
<input type="hidden" name="hidroi_interestsno2" value="2">
<%
		}
 		else
 		{
%> 
<input type="hidden" name="hidroi_from2" size="12" value="">
<input type="hidden" name="hidroi_to2" size="12" value="">
<input type="hidden" name="hidroi_baserate2" size="12" value="">
<input type="hidden" name="hidroi_interestid2" value="">
<input type="hidden" name="hidroi_interestsno2" value="2">
<%
		}
	}
 	for(int i = 0; i < intNoOfRatingDesc; i++)
 	{
 		int colSize = 0;
 		
 			g1 = (ArrayList) vecRatingRoiRow3.get(0);
 			if(g1 != null)
 			{
 				colSize = g1.size();
 			}
 		
 		if(colSize > 0)
 		{
%>
<input type="hidden" name="hidroi_from3" size="12" value="<%=g1.get(0)%>">
<input type="hidden" name="hidroi_to3" size="12" value="<%=g1.get(1)%>">
<input type="hidden" name="hidroi_baserate3" size="12" value="<%=g1.get(2)%>">
<input type="hidden" name="hidroi_interestid3" value="<%=g1.get(3)%>">
<input type="hidden" name="hidroi_interestsno3" value="3">
<%
		}
 		else
 		{
%>
<input type="hidden" name="hidroi_from3" size="12" value="">
<input type="hidden" name="hidroi_to3" size="12" value="">
<input type="hidden" name="hidroi_baserate3" size="12" value="">
<input type="hidden" name="hidroi_interestid3" value="">
<input type="hidden" name="hidroi_interestsno3" value="3">
<%
		}
 	}
 	for(int i = 0; i < intNoOfRatingDesc; i++)
 	{
 		int colSize = 0;
 		
 			g1 = (ArrayList) vecRatingRoiRow4.get(0);
 			if(g1 != null)
 			{
 				colSize = g1.size();
 			}
 		
 		if(colSize > 0)
 		{
%>
<input type="hidden" name="hidroi_from4" size="12" value="<%=g1.get(0)%>">
<input type="hidden" name="hidroi_to4" size="12" value="<%=g1.get(1)%>">
<input type="hidden" name="hidroi_baserate4" size="12" value="<%=g1.get(2)%>">
<input type="hidden" name="hidroi_interestid4" value="<%=g1.get(3)%>">
<input type="hidden" name="hidroi_interestsno4" value="4">
<%
		}
 		else
 		{
%>
<input type="hidden" name="hidroi_from4" size="12" value="">
<input type="hidden" name="hidroi_to4" size="12" value="">
<input type="hidden" name="hidroi_baserate4" size="12" value="">
<input type="hidden" name="hidroi_interestid4" value="">
<input type="hidden" name="hidroi_interestsno4" value="4">
<%
		}
	}
	for(int i = 0; i < intNoOfRatingDesc; i++)
	{
 		int colSize = 0;
 		
 			g1 = (ArrayList) vecRatingRoiRow5.get(0);
 			if(g1 != null)
 			{
 				colSize = g1.size();
 			}
 		
 		if(colSize > 0)
 		{
%>
<input type="hidden" name="hidroi_from5" size="12" value="<%=g1.get(0)%>">
<input type="hidden" name="hidroi_to5" size="12" value="<%=g1.get(1)%>">
<input type="hidden" name="hidroi_baserate5" size="12" value="<%=g1.get(2)%>">
<input type="hidden" name="hidroi_interestid5" value="<%=g1.get(3)%>">
<input type="hidden" name="hidroi_interestsno5" value="5">
<%
		}
 		else
 		{
%>
<input type="hidden" name="hidroi_from5" size="12" value="">
<input type="hidden" name="hidroi_to5" size="12" value="">
<input type="hidden" name="hidroi_baserate5" size="12" value="">
<input type="hidden" name="hidroi_interestid5" value="">
<input type="hidden" name="hidroi_interestsno5" value="5">
<%
		}
	}
%>
<input type="hidden" name="line">
<input type="hidden" name="hidval">
<input type="hidden" name="ruleid">
<input type="hidden" name="selindtype1">
<input type="hidden" name="selinttype1">
<input type="hidden" name="prd_catid">
<input type="hidden" name="cat_id">
<input type="hidden" name="prd_type">
<input type="hidden" name="prd_saveflag" value="<%=Helper.correctNull((String) hshValues.get("prd_saveflag"))%>">
<input type="hidden" name="hidBeanId">
<input type="hidden" name="hidBeanMethod" value="">
<input type="hidden" name="hidBeanGetMethod">
<input type="hidden" name="hidSourceUrl" value="/action/setfacilityintterms.jsp">
<input type="hidden" name="hidAction">
<input type="hidden" name="prdCode" value="<%=request.getParameter("fac_id")%>">
<input type="hidden" name="schemeCode">
<input type="hidden" name="prdType">
<input type="hidden" name="prdStatus">
<input type="hidden" name="prdCat">
<input type="hidden" name="prdSubCat">
<input type="hidden" name="prdRangeFrom">
<input type="hidden" name="prdRangeTo">
<input type="hidden" name="prdTerm">
<input type="hidden" name="prdminTerm">
<input type="hidden" name="secured">
<input type="hidden" name="inttenor">
<input type="hidden" name="intamt">
<input type="hidden" name="repayment">
<input type="hidden" name="hidselid">
<input type="hidden" name="hidtermid">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String) hshValues.get("prd_type"))%>">
<input type="hidden" name="prd_code" value="<%=request.getParameter("fac_id")%>">
<input type="hidden" name="wrk_flowtype1" value="<%=strWrkflowtype%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>">
<input type="hidden" name="hiddesc" value="">
<input type="hidden" name="hidindtype" value="">
<input type="hidden" name="fac_id1" value="<%=Helper.correctNull(request.getParameter("fac_id"))%>">
<input type="hidden" name="hidindustrytype" value="<%=Helper.correctNull((String) hshValues.get("selindtype"))%>">
<input type="hidden" name="hidinteresttype" value="<%=Helper.correctNull((String) hshValues.get("selinttype"))%>">
<input type="hidden" name="condition_code" value="S">
<input type="hidden" name="hidAgrScheme" value="<%=Helper.correctNull((String)request.getParameter("hidAgrScheme"))%>">
<input type="hidden" name="hidPageId" value="<%=PageId%>">
<input type="hidden" name="hidValue" value="">
<input type="hidden" name="hidSpreadFlag" value="<%=Helper.correctNull((String)hshValues.get("strSpreadFlag")) %>">
<iframe name="ifrminterest" width="0" height="0" border="0"></iframe>
</form>
</body>
</html>