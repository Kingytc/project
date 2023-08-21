<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%	String strType = Helper.correctNull(request.getParameter("hidval"));
	String strWrkflowtype = Helper.correctNull(request.getParameter("wrk_flowtype1"));
	if (strWrkflowtype.equals("")) {
		strWrkflowtype = "fixed";
	}
	ArrayList v = null;
	if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	if (strType.equalsIgnoreCase("show_terms") || strType.equalsIgnoreCase("update_terms")) 
	{
		v = (ArrayList) hshValues.get("vecVal");
	}
	int vecsize = 0;
	if (v != null) {
		vecsize = v.size();
	}
	String strInterestType=Helper.correctNull((String)hshValues.get("strInteresttype"));
	
	String strNoOfRatingDesc = Helper.correctNull((String) hshValues.get("prdNoOfRatingDescription"));
	int intNoOfRatingDesc = 0;
	if (!strNoOfRatingDesc.equalsIgnoreCase(""))
	{
		intNoOfRatingDesc = Integer.parseInt(strNoOfRatingDesc);
	}
	String strselinttype=Helper.correctNull((String)hshValues.get("sel_inttype"));
	String strmaxresttenure=Helper.correctNull((String) session.getAttribute("strmaxresttenure"));
	%>
<html>
<head>
<title>Setup(Products)</title>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script language="JavaScript"
	src="<%=ApplicationParams.getAppUrl()%>js/share/rightclick.js"></script>
<script>
var val = "<%=request.getParameter("hidval")%>";
var appUrl="<%=ApplicationParams.getAppUrl()%>";
var appURL="<%=ApplicationParams.getAppUrl()%>";
var button;
var workid   = new Array();
var termfrom = new Array();
var termto   = new Array();
var termint  = new Array();
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";
var varStaffPrd="<%=Helper.correctNull((String) hshValues.get("strStaffPrd"))%>";
var strtype= "<%=strType%>";
var varRuleIDNew="<%=Helper.correctNull((String) hshValues
	.get("ruleid"))%>";
if(varStaffPrd=="")
{
	varStaffPrd="<%=Helper.correctNull((String) request.getParameter("varStaffPrd"))%>";
}
var varNoOfRatingDescription ="<%=intNoOfRatingDesc%>";
function checkPeriod(objName)
	{
	//var fixedto=document.forms[0].prdTerm.value;
var fixedto="<%=strmaxresttenure%>";
	var userto=parseInt(objName.value);
	if(userto > fixedto)
		{
		alert("Repayment Period should not greater than Max. Repayment Period");
		objName.value = "";
		objName.focus();
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
	if(document.forms[0].wrk_flowtype1.value=="floating")
	{
		if((strtype == "show_terms" || strtype=="update_terms"))
		{
			enableButtons(true,false,true,true,false,true);
		}
		else
		{
			enableButtons(false,true,true,true,false,true);
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
	if(!document.forms[0].cmdsave.disabled)
	{
		ShowAlert(103);
	}
	else
	{
		if (type == "slabrate")
		{
			code=document.forms[0].prdCode.value;
			document.forms[0].wrk_flowtype1.value=type;
			document.forms[0].action=appUrl+"controllerservlet?code="+code;
			document.forms[0].hidBeanId.value="setuprate";
			document.forms[0].hidBeanMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/slabrate.jsp";
		}
		else if (type == "other")
		{
			document.forms[0].wrk_flowtype1.value=type;
			document.forms[0].action=appUrl+"action/setinterestrate.jsp?wrk_flowtype1=floating&hidSpreadFlag="+document.forms[0].hidSpreadFlag.value;
		}
		else
		{
			document.forms[0].wrk_flowtype1.value=type;
			document.forms[0].action=appUrl+"action/setintterms.jsp?wrk_flowtype1="+type+"&varStaffPrd="+varStaffPrd+"&hidBeanId=setproducts&hidBeanGetMethod=interestTerm";
		}
		document.forms[0].submit();
	}
}
function loadValues()
	{
	if(strtype == "update_terms" || strtype == "show_terms")
		{
		document.forms[0].amtfrom.value="<%=Helper.correctNull((String) hshValues.get("rangefrom"))%>";
		document.forms[0].amtto.value="<%=Helper.correctNull((String) hshValues.get("rangeto"))%>";
		document.forms[0].ruleid.value="<%=Helper.correctNull((String) hshValues
									.get("ruleid"))%>";
		document.forms[0].select_rule.value="<%=Helper.correctNull((String) hshValues
									.get("ruleid"))%>";
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			document.forms[0].sel_inttype1.value="<%=Helper.correctNull((String) hshValues
									.get("sel_inttype"))%>";
		}
		enableButtons(true,false,true,true,false,true);
		}
	else
		{
		enableButtons(false,true,true,true,false,true);
		}
	for(var i=0;i<document.forms[0].elements.length;i++)
		{
		if(document.forms[0].elements[i].type=="text")
			{
			document.forms[0].elements[i].readOnly=true;
			}	
		}
	if(varStaffPrd=="Y")
	{
		document.all.id_CBSTableCodeLbl.style.visibility="visible";
		document.all.id_CBSTableCodeLbl.style.position="relative";
		for(var i=0;i<document.all.id_CBSTableCodeTxt.length;i++)
		{
			document.all.id_CBSTableCodeTxt[i].style.visibility="visible";
			document.all.id_CBSTableCodeTxt[i].style.position="relative";
		}
	}
	else
	{
		document.all.id_CBSTableCodeLbl.style.visibility="hidden";
		document.all.id_CBSTableCodeLbl.style.position="absolute";
		for(var i=0;i<document.all.id_CBSTableCodeTxt.length;i++)
		{
			document.all.id_CBSTableCodeTxt[i].style.visibility="hidden";
			document.all.id_CBSTableCodeTxt[i].style.position="absolute";
		}
	}

		for(var i=0;i<document.all.baserate.length;i++)
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
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			getRangeValues();
		}
	}

function changlbl(par)
	{
	if(par =="a")
		{
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			if(document.forms[0].sel_inttype1.value=="")
			{
				alert("Select Interest Type");
				return;	
			}
		}
		document.all.labelchange.innerText="";
		document.all.labelhelp.style.visibility="hidden";
		for(i=0;i<=4;i++)
			{
			document.forms[0].from[i].value="";
			document.forms[0].to[i].value="";	
			document.forms[0].total[i].value="";
			document.forms[0].baserate[i].value="";
			document.forms[0].adjust[i].value="";
			document.forms[0].txtcreditrskpremium[i].value="";
			document.forms[0].txtbustratpremium[i].value="";
			}
		document.forms[0].amtfrom.value="";
		document.forms[0].amtto.value="";
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			document.forms[0].sel_inttype1.disabled=true;
		}		
		button="a";
		enableButtons(true,true,false,false,true,true);
		}
	else if(par=="e")
		{
		if(document.forms[0].select_rule.value == "0")
			{
			alert("Select Interest Range");
			return;
			}
			button="e";
			enableButtons(true,true,false,false,true,false);
		}	
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
		}
	for(var i=0;i<document.forms[0].total.length;i++)
	{
		document.forms[0].total[i].readOnly=true;
	}
	for(var i=0;i<document.forms[0].tablecode.length;i++)
	{
		document.forms[0].tablecode[i].readOnly=true;
	}
	document.forms[0].select_rule.disabled=false;
	document.forms[0].prdCode.readOnly=true;
	document.forms[0].prdType.readOnly=true;
	document.forms[0].prdStatus.readOnly=true;
	document.forms[0].prdCat.readOnly=true;
	document.forms[0].prdSubCat.readOnly=true;
	document.forms[0].prdRangeFrom.readOnly=true;
	document.forms[0].prdRangeTo.readOnly=true;
	document.forms[0].prdTerm.readOnly=true;
	}

function doSave()
	{
	var flag = true;
	if (document.forms[0].wrk_flowtype1.value == "" )
		{
		document.forms[0].wrk_flowtype1.value = "fixed"
		}
	flag = true;
	if(parseFloat(document.forms[0].amtfrom.value) > parseFloat(document.forms[0].prdRangeTo.value) || parseFloat(document.forms[0].amtfrom.value) < parseFloat(document.forms[0].prdRangeFrom.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
		}
	if(parseFloat(document.forms[0].amtto.value) > parseFloat(document.forms[0].prdRangeTo.value) )
		{
		alert("Amount Range Should Be Between Product Amount Range");
		return;
		}
	if(parseFloat(document.forms[0].amtto.value) <  parseFloat(document.forms[0].amtfrom.value))
		{
		alert("The From Range Should Be Less Than To Range For a Interest Range");
		return;
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
				for(var i=0;i<document.forms[0].baserate.length;i++)
					{
					if(document.forms[0].wrk_flowtype1.value=="fixed"  && document.forms[0].from[i].value != "" && document.forms[0].baserate[i].value == "")
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
						if(document.forms[0].sel_inttype1.value=="O")
							alert("Enter Business Strategic Premium  Rate");
						else
							alert("Enter Fixed Spread  Rate");
						return;
					}
					
					}
				if(varStaffPrd=="Y")
				{
					for(var j=0;j<document.forms[0].tablecode.length;j++)
					{
						if(document.forms[0].from[j].value != "" && document.forms[0].tablecode[j].value == "")
						{
							alert("Enter CBS Int. Table Code");
							return;
						}
					}
				}
				document.forms[0].cmdsave.disabled = true;
				if(document.forms[0].wrk_flowtype1.value=="floating")
				{
					document.forms[0].sel_inttype1.disabled=false;
				}
				document.forms[0].hidRecordflag.value=varRecordFlag;
				document.forms[0].hidBeanId.value="setproducts";
				document.forms[0].hidval.value="insert_terms";
				document.forms[0].hidBeanMethod.value="interestTerm";
				document.forms[0].hidSourceUrl.value="/action/setintterms.jsp";
				document.forms[0].action=appUrl+"controllerservlet?work="+work;
				document.forms[0].submit();
				}
			else
				{
				alert("Enter the range");
				}
		}
		if(document.all.labelhelp.style.visibility != "hidden")
		{
			if (document.forms[0].select_rule.value != "0")
			{
				if (document.forms[0].amtfrom.value != "" && document.forms[0].amtto.value != "" )
				{	
					
					for(var i=0;i<document.forms[0].baserate.length;i++)
						{
							if(document.forms[0].wrk_flowtype1.value=="fixed"  && document.forms[0].from[i].value != "" && document.forms[0].baserate[i].value=="")
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
							if(document.forms[0].sel_inttype1.value=="O")
								alert("Enter Business Strategic Premium  Rate");
							else
								alert("Enter Fixed Spread  Rate");
							document.forms[0].txtbustratpremium[i].focus();
							return;
						}
						
						}
					if(varStaffPrd=="Y")
					{
						for(var j=0;j<document.forms[0].tablecode.length;j++)
						{
							if(document.forms[0].from[j].value != "" && document.forms[0].tablecode[j].value == "")
							{
								alert("Enter CBS Int. Table Code");
								return;
							}
						}
					}
					document.forms[0].cmdsave.disabled = true;
					document.forms[0].hidRecordflag.value=varRecordFlag;
					document.forms[0].ruleid.value = document.forms[0].select_rule.value;
					work="<%=strWrkflowtype%>";
					document.forms[0].action=appUrl+"controllerservlet?work="+work;
					document.forms[0].hidBeanId.value="setproducts";
					document.forms[0].hidval.value="update_terms";
					document.forms[0].hidBeanMethod.value="interestTerm";
					document.forms[0].hidSourceUrl.value="/action/setintterms.jsp";
					document.forms[0].submit();
				}
				else
				{
					alert("Enter The Range");					
				}
			}
			else
			{
				alert("Select a Rule To Update");
			}
		}
	}
	else
		{
		alert("Enter the Value of the Fields Properly");
		}
	}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(document.forms[0].select_rule.value==0)
		{
		  alert("Select the Interest Range");
		  return;
		}
		if(confirm("Do you really want to delete the Interest Range ?"))
		{
			document.forms[0].hidBeanId.value="setproducts";
			document.forms[0].method="post";
			document.forms[0].hidBeanMethod.value="deleteTerms";	
			document.forms[0].action=appUrl+"controllerservlet";		
			document.forms[0].hidSourceUrl.value="/action/setintterms.jsp";
			document.forms[0].submit();
		}
	}
	else
	{
		ShowAlert(158);
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

function opendisfixed(num,field)
{
	if (document.forms[0].cmdsave.disabled == false)
	{
	  var purl = appUrl+"action/fixedselect.jsp?val=fixedselect&num="+num+"&baserate="+field+"&identity=floating";
	  var prop = "scrollbars=no,width=450,height=360";	
	  var title = "InterestRate";
	  var xpos = (screen.width - 350) / 2;
	  var ypos = (screen.height - 320) / 2;
	  prop = prop + ",left="+xpos+",top="+ypos;
      window.open(purl,title,prop);
	}
	else if(document.forms[0].checkApp.value!="Yes")
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
	document.forms[0].action=appUrl+"action/setintterms.jsp?amfrom="+from+"&amto="+to+"&work="+work;
	document.forms[0].hidBeanId.value="setproducts";
	document.forms[0].hidBeanGetMethod.value="interestTerm";
	document.forms[0].hidval.value="show_terms";
	document.forms[0].submit();
	}	
}

function  validate_enable()
{ 
	var flag;	
	for (m=0;m<5;m++)
		{
			if(document.forms[0].from[m].value != "" || document.forms[0].to[m].value != "" || document.forms[0].total[m].value != "" || document.forms[0].baserate[m].value != "" ||
				document.forms[0].adjust[m].value != "")
			{
				if(document.forms[0].from[m].value != "" && document.forms[0].to[m].value != "" && document.forms[0].total[m].value != "" && document.forms[0].from[m].value <= document.forms[0].to[m].value && document.forms[0].baserate[m].value != "" && document.forms[0].adjust[m].value != "" )
				{
					flag = true; 
				}
				else
				{
					return false;
				}
			}
		}
return flag;	
}

function doCancel()
{
	if (ConfirmMsg(102))
	{
		for(i=0;i<=4;i++)
		{
		  document.forms[0].from[i].value="";
		  document.forms[0].to[i].value="";	
		  document.forms[0].total[i].value="";
		  document.forms[0].baserate[i].value="";
		  document.forms[0].adjust[i].value="";
		  document.forms[0].tablecode[i].value="";
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
	    for(var i=0;i<document.forms[0].total.length;i++)
		{
			document.forms[0].total[i].readOnly=true;
		}
		document.all.labelchange.innerText="Select Interest Range";
		document.all.labelhelp.style.visibility="visible";
		document.forms[0].select_rule.value="0";
		if(document.forms[0].wrk_flowtype1.value=="floating")
		{
			document.forms[0].sel_inttype1.value="";
			document.forms[0].sel_inttype1.disabled=false;
		}
		enableButtons(false,false,true,true,false,true);
	}
}

function doClose()
 {
	 if(ConfirmMsg(100))
	 {
		 document.forms[0].action=appUrl+"action/setsearchproducts.jsp";
		 document.forms[0].submit();
	 }
 }	
 function callOtherTab(url)
	{
		
		if(!document.forms[0].cmdsave.disabled)
		{
			ShowAlert(103);
		}
		else
		{
			 if(url=="setproducts.jsp" ||  url=="prodinterest.jsp" || url=="prodsanclimit.jsp")
			 {
				document.forms[0].hidBeanGetMethod.value="getData";
			 }
			 if(url=="setprdauth.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getAuthorityData";
			 }
			 
			 if(url=="setprddoc.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getDocData";
			 }

			 if(url=="setprdworkflow.jsp")
			 {
				 document.forms[0].hidBeanGetMethod.value="getWorkflowData";
			 }
		 document.forms[0].prd_code.value=document.forms[0].prdCode.value;
		 document.forms[0].action=appUrl+"action/"+url;
		 document.forms[0].submit();
		}
	}
function doNew()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	varRecordFlag="N";
	changlbl('a');
}
function doEdit()
{
	if(document.forms[0].hidSpreadFlag.value=="Y")
	{
		alert("Spread Updation is pending");
		return;
	}
	changlbl('e');
}
function callTableCode(intt)
{
	if(document.forms[0].cmdsave.disabled==false)
	{
		var intnumber=intt;
		var varArrRatingDescSize =5;
		var prop="scrollbars=no,width=350,height=350";
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 350) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		var url=appUrl+"action/setcbstablecodelist.jsp?Array_size="+varArrRatingDescSize+"&intNum="+intnumber;
		window.open(url,"hai",prop);
	}
	else if(document.forms[0].checkApp.value!="Yes")
	{
	  alert("Click Edit/New To change");
	}
}
function openRatingBasedRoi(id,sno)
{
	if (document.forms[0].cmdedit.disabled == false)
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
			var varQryString = appUrl+"action/setratingbasedroicorporate.jsp?hidBeanGetMethod=getCorporateRatings&hidBeanId=setproducts&work="+wrkflowtype+"&slno="+id+"&from_date="+from_date+"&to_date="+to_date+"&varRuleId="+varRuleId+"&chkapp="+chkapp+"&ref_rate="+ref_rate+"&interest_id="+interest_id+"&hidModule=RET";
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
function getRangeValues()
{
	if(document.forms[0].sel_inttype1.value=="O")
	{
		document.all.idbsp.innerHTML="Business Strategic Premium";
	}
	else
	{
		document.all.idbsp.innerHTML="Fixed Spread";
	}
	document.all.ifrminterest.src=appUrl+"action/iframeinttypes.jsp?hidBeanGetMethod=getOtherinterestTypes&hidBeanId=setproducts&prdCode="+document.forms[0].prd_code.value+"&inttype="+document.forms[0].wrk_flowtype1.value+"&strROIType=O&strRule="+varRuleIDNew+"&interestfor="+document.forms[0].sel_inttype1.value;
}	
function clearfields()
{
	for(i=0;i<5;i++)
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
	document.all.labelchange.innerText="Select Interest Range";
	document.all.labelhelp.style.visibility="visible";
	varRuleIDNew="";
	document.forms[0].select_rule.value="";
	enableButtons(false,true,true,true,false,true);
}
</script>
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onLoad="loadValues();loadUsedApp()">
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
<form name="documentsfrm" method="post" class="normal">
<lapstab:setproductstab tabid="8" prdtype='<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>'/>
<table width="100%" border="0" cellspacing="0" cellpadding="0" align="center" class="outertable">
	<tr>
		<td class="page_flow">Home -&gt; Setup -&gt; Retail &amp;
		Agriculture Products -&gt; Products -&gt; Interest and Terms -&gt; <%
 	if (strWrkflowtype.equals("floating")) {
 %>Floating Rate<%} else if (strWrkflowtype.equals("fixed")) {%>Fixed Rate<%}%>
		</td>
	</tr>
</table>
<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable" align="center">
	<tr>
		<td valign="top">
		<table width="100%" border="0" cellspacing="0" cellpadding="3" align="center" class="outertable">
			<tr>
				<td valign="top">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td colspan="4">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td colspan="6">
								<fieldset>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" 	class="outertable">
									<tr>
										<td><lapschoice:products /></td>
									</tr>
								</table>
								</fieldset>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td colspan="4">
						<table width="40%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr>
								<td align="center"
									<%if (strWrkflowtype.equals("fixed") || strWrkflowtype.equals("")) {%>
									 class="sub_tab_active">Fixed Rate <%} else {%> class="sub_tab_inactive"> 
									 <a href="javascript:callFlowtype('fixed')">Fixed Rate</a><%}%>
							</td>
								<td align="center"
									<%if (strWrkflowtype.equals("floating")) {%> class="sub_tab_active"	>
								Floating Rate <%} else { %> class="sub_tab_inactive">
								<a href="javascript:callFlowtype('floating')">Floating Rate</a><%}%></td>
								<td align="center" class="sub_tab_inactive"> <a href="javascript:callFlowtype('other')">Other Rates</a></td>
								
								</tr>
						</table>
						<br>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable border1">
							<tr><td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
						<%if (strWrkflowtype.equals("floating")) {%>
							<tr>
								<td width="15%">Reference type</td>
								<td width="85%"><select name=sel_inttype1 tabindex="1" onchange="clearfields();getRangeValues();">
									<option value="">--------------Select--------------</option>
									<lapschoice:interesttype appmodule="R"  appvalue='<%=request.getParameter("prdCode")%>'/>
								</select></td>
							</tr>
							<tr>
								<td width="15%"><span
									id="labelchange">Select Interest Range </span></td>
								<td width="85%"><select name="select_rule" id="labelhelp"
									onchange="getvalues()" tabindex="1">
									<option value="0">--------------Select--------------</option>
								</select></td>
							</tr>
						<%}else{%>						
						<tr>
								<td width="15%"><span
									id="labelchange">Select Interest Range </span></td>
								<td width="85%"><select name="select_rule" id="labelhelp"
									onchange="getvalues()" tabindex="1">
									<option value="0">--------------Select--------------</option>
									<lapschoice:fixedfloat apptype="O"/>
								</select></td>
						</tr>					
						<%} %>
							
						</table>						
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td width="14%">Amount Range From</td>
								<td width="20%"><lapschoice:CurrencyTag name="amtfrom"
									maxlength="18" tabindex="2" size="18" /></td>
								<td width="17%">Amount Range To</td>
								<td width="25%"><lapschoice:CurrencyTag name="amtto"
									maxlength="18" tabindex="3" size="18" /></td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
				</tr>
				</table>
				<br>
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr class="dataheader">
						<td width="5%">
						<div align="center">S.No</div>
						</td>
						<td width="12%">
						<div align="center">Repayment Period From</div>
						</td>
						<td width="12%">
						<div align="center">Repayment Period To</div>
						</td>
						<td width="15%"  id="Idrefratelabel">
						<div align="center">Reference Rate </div>
						</td>
						<td width="10%" id="Idadjustmentlabel">
						<div align="center">Adjustments
						(+/-) </div>
						</td>						
						<td width="10%" id="Idintratelabel">
						<div align="center">Interest Rate (%)</div>
						</td>
						<td width="15%" id="id_CBSTableCodeLbl">
						<div align="center">CBS Int. Table Code</div>
						</td>
						<td width="15%" align="center" nowrap="nowrap" id="idcrplabel">Credit Risk Premium</td>
						<td width="15%" align="center" nowrap="nowrap" id="idbsplabel"><span id="idbsp">Business Strategic Premium</span> </td>
						<%if(strInterestType.contains("RATING")){ %>
						<td width="15%" align="center" nowrap="nowrap">Rating based ROI</td>
						<%} %>
					</tr>
					<%ArrayList g1 = null;
						for (int l = 0; l < 5; l++) {
							int colSize = 0;
							if (l < vecsize) {
								g1 = (ArrayList) v.get(l);
								if (g1 != null) {
									colSize = g1.size();
								}
							}
							if (colSize > 0) {%>
					<tr class="datgrid" >
						<td width="5%" align="center"> <input type=hidden name="line"
							value="<%=l + 1%>"><%=l + 1%></td>
						<td width="15%">
						<div align="center"><input type="text" name="from"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 4%>"
							onKeyPress="allowInteger()" size="12"
							value="<%=Helper.correctNull((String) g1.get(0))%>">
						</div>
						</td>
						<td width="15%">
						<div align="center"><input type="text" name="to"
							maxlength="11" style="text-align: right" tabindex="<%=(4 * l) + 5%>"
							onKeyPress="allowInteger()" size="12" onBlur="checkPeriod(this)"
							value="<%=Helper.correctNull((String) g1.get(1))%>">
						</div>
						</td>
						<td width="15%" align="center"  id="Idrefratevalue"><input type="text"
							name="baserate" maxlength="8" readonly
							onKeyPress="allowInteger()" size="12"
							value="<%=Helper.correctNull((String) g1.get(2))%>">
						<span onClick="opendisfixed('<%=l%>','baserate')"
							style="cursor: hand" tabindex="<%=(4 * l) + 6%>"><b> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></td>
						<td width="10%" align="center"  id="Idadjustmentvalue"><input type="text"
							name="adjust" maxlength="6" size="12" tabindex="<%=(4 * l) + 7%>"
							onKeyPress="allowAdjustment(this);"
							onBlur="checkPercentage(this);totalInt('<%=l%>');"
							value="<%=Helper.correctNull((String) g1.get(3))%>">

						</td>
						<td width="10%"  id="Idintratevalue">
						<div align="center"><input type="text" name="total"
							maxlength="8" onKeyPress="allowNumber(this)" size="12"
							onBlur="checkPercentage(this),roundtxt(this)"
							value="<%=Helper.correctNull((String) g1.get(4))%>">
						</div>
						</td>
						<input type="hidden" name="interestid" maxlength="8" readonly
							value="<%=Helper.correctNull((String) g1.get(5))%>">
						<td width="15%" align="center" id="id_CBSTableCodeTxt"><input type="text"
							name="tablecode" maxlength="8" readonly
							onKeyPress="allowInteger()" size="12"
							value="<%=Helper.correctNull((String) g1.get(6))%>">
						<span onClick="callTableCode('<%=l%>')"
							style="cursor: hand" tabindex="<%=(4 * l) + 8%>"><b> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></td>
							
						<td align="center" id="idcrpvalue"><input type="text" name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);" style="text-align: right;" size="12"  onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(7))%>'/></td>
						<td align="center" id="idbspvalue"><input type="text" name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);"  style="text-align: right;" size="12"  onkeypress="allowNumber(this)" value='<%=Helper.correctNull((String) g1.get(8))%>'/></td>
						<%if(strInterestType.contains("RATING")){ %>
						<td width="11%" align="center" >
						<span onClick="openRatingBasedRoi('<%=l %>')" style="cursor: hand">
						<img src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif" border="0">
						</span></td>
						<%} %>
					</tr>
					<%} else {%>
					<tr class="datagrid">
						<td width="5%">
						<div align="center">
						<input type=hidden name="line" value="<%=l + 1%>"><%=l + 1%></div>
						</td>
						<td width="18%">
						<div align="center"><input type="text" name="from"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 4%>"
							onKeyPress="allowInteger()" size="12"></div>
						</td>
						<td width="20%">
						<div align="center"><input type="text" name="to"
							maxlength="8" style="text-align: right" tabindex="<%=(4 * l) + 5%>"
							onKeyPress="allowInteger()" onBlur="checkPeriod(this)" size="12">
						</div>
						</td>						
						<td width="15%" id="Idrefratevalue">
						<div align="center"><input type="text" name="baserate"
							maxlength="8" readonly onKeyPress="allowInteger()" size="12">
						<span onClick="opendisfixed('<%=l%>','baserate')"
							style="cursor: hand" tabindex="<%=(4 * l) + 5%>"><b><img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></div>
						</td>
						<td width="10%"  id="Idadjustmentvalue">
						<div align="center"><input type="text" name="adjust"
							maxlength="8" tabindex="<%=(4 * l) + 6%>" size="12"
							onBlur="totalInt('<%=l%>')"></div>
						</td>
						<td width="15%" id="Idintratevalue">
						<div align="center"><input type="text" name="total"
							maxlength="8" onKeyPress="allowNumber(this)" size="12"
							onBlur="checkPercentage(this),roundtxt(this)"></div>
						</td>
						<td style="visibility:hidden;position:absolute;" width="0%">
						<div align="center"><input type="hidden" name="interestid"
							maxlength="8" readonly></div>
						</td>
						<td width="15%" align="center" id="id_CBSTableCodeTxt"><input type="text"
							name="tablecode" maxlength="8" readonly
							onKeyPress="allowInteger()" size="12">
						<span onClick="callTableCode('<%=l%>')"
							style="cursor: hand" tabindex="<%=(4 * l) + 8%>"><b> <img
							src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
							border="0"></b></span></td>
							
						<td align="center" id="idcrpvalue"><input type="text" name="txtcreditrskpremium" onBlur="roundtxt(this);checkPercentage(this);"  onkeypress="allowNumber(this)" size="12" style="text-align: right;"/></td>
						<td align="center" id="idbspvalue"><input type="text" name="txtbustratpremium" onBlur="roundtxt(this);checkPercentage(this);"   onkeypress="allowNumber(this)" size="12" style="text-align: right;"/></td>
						<%if(strInterestType.contains("RATING")) { %>
					<td width="11%" align="center">
				&nbsp;
					</td>
					<%} %>
						
					</tr>
					<%}}%>
				</table>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String)request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>'/> 							
<input type="hidden" name="prd_code" value="<%=request.getParameter("prdCode")%>">
<input type="hidden" name="wrk_flowtype1" value="<%=strWrkflowtype%>">
<input type="hidden" name="checkApp" value="<%=request.getParameter("checkApp")%>"> 
<input type="hidden" name="hidval"> 
<input type="hidden" name="ruleid">
<input type="hidden" name="hidSpreadFlag" value="<%=Helper.correctNull((String)hshValues.get("strSpreadFlag")) %>">
<input type="hidden" name="prd_choose" value="<%=request.getParameter("prd_choose")%>">
<input type="hidden" name="hidProductType" value="<%=Helper.correctNull((String)request.getParameter("hidProductType"))%>">
<input type="hidden" name="hidInteresetType" value="O">
<iframe name="ifrminterest" width="0" height="0" border="0"></iframe>
</form>
</body>
</html>
