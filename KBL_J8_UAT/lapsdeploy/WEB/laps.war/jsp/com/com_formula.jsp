<%@ include file="../share/directives.jsp"%>
<jsp:useBean id="objValues" class="java.lang.Object" scope="request" />
<%if (objValues instanceof java.util.HashMap) {
		hshValues = (java.util.HashMap) objValues;
	}
	String strCma = Helper.correctNull((String) hshValues.get("cmano"));
	String gg = Helper.correctNull((String) request.getParameter("varmode"));
	if (strCma.trim().equals("")) {
		strCma = Helper.correctNull((String) request.getParameter("selcma"));
	}%>
<html>
<head>
<title>Financial Formulas</title>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/AlertMessages.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/validation.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/set/navigate.js"></script>
<script src="<%=ApplicationParams.getAppUrl()%>js/share/CommonFunction.js"></script>
<script>
var path = "<%=ApplicationParams.getAppUrl()%>";
var varrowid ="";
var varforname="";
var varformuladesc="";
var vartxtformula="";
var varmode=1;
var varfortypevalue="";
var varforvalue="";
var appURL = "<%=ApplicationParams.getAppUrl()%>";
var varRecordFlag="<%=Helper.correctNull((String) hshValues.get("recordflag"))%>";

function replace(value, original, replace)
{
	var varValue = "";
	if(value!="")
	{
		for(var i=0; i<value.length; i++)
		{
			if(value.charAt(i)==original)
				varValue = varValue + replace;
			else
				varValue = varValue + value.charAt(i);
		}
	}
	return varValue;
}

function makeformula()
{
	var formula="",formval="",selvalue1="",selvalue2="",formvaldesc="",formuladesc="";
	var selformula1="",selformuladesc1="",selformula2="",selformuladesc2="",arr,arr1;
	var selCMAyr1="", selCMAyr2="", selFormulayr1="", selFormulayr2="",strFormulaType="";
	var dbnum1=0 , dbnum2=0 ;
	if(document.forms[0].choformula.options[document.forms[0].choformula.selectedIndex].value=="")
	{
		alert("Select 'Formula for' before adding formula");
		document.forms[0].choformula.focus();
		return;
	}
	var clr=confirm("Do you want to Add the Formula");
	if(clr==true)
	{
	selvalue1 =  document.forms[0].selcol1.options[document.forms[0].selcol1.selectedIndex].value;
	selvaluedesc1 =  document.forms[0].selcol1.options[document.forms[0].selcol1.selectedIndex].text;
	selvalue2 = document.forms[0].selcol2.options[document.forms[0].selcol2.selectedIndex].value;
	selvaluedesc2 = document.forms[0].selcol2.options[document.forms[0].selcol2.selectedIndex].text;
	selopt = document.forms[0].selopt.options[document.forms[0].selopt.selectedIndex].value;
	selCMAyr1 = document.forms[0].selCMAyr1.options[document.forms[0].selCMAyr1.selectedIndex].value;
	selCMAyr2 = document.forms[0].selCMAyr2.options[document.forms[0].selCMAyr2.selectedIndex].value;
	if(!isNaN(document.forms[0].txtnumber1.value))
	{
		dbnum1 = parseFloat(document.forms[0].txtnumber1.value);
	}
	if(!isNaN(document.forms[0].txtnumber2.value))
	{
		dbnum2 = parseFloat(document.forms[0].txtnumber2.value);
	}
	if(!dbnum1)
	{
		dbnum1=0;
	}
	if(!dbnum2)
	{
		dbnum2=0;
	}

	strFormulaType = document.forms[0].choformulatype.options[document.forms[0].choformulatype.selectedIndex].value;
	if(((document.forms[0].selcol1.selectedIndex>0)&&(document.forms[0].selformula1.value!=""))
		||((document.forms[0].selcol1.selectedIndex>0) &&(dbnum1!=0)) ||((document.forms[0].selformula1.value!="") &&(dbnum1!=0)))
	{
		alert("Select either Select CMA Column-1 or Select Formula-1 or Enter Numeral1")
		return;
	}
	else if(((document.forms[0].selcol2.selectedIndex>0) && (document.forms[0].selformula2.value!="")) || ((document.forms[0].selcol2.selectedIndex>0) && (dbnum2!=0)) || ((document.forms[0].selformula2.value!="") &&(dbnum2!=0)))
	{
		alert("Select either Select CMA Column-2 or Select Formula-2 or Enter Numerals2")
		return;
	}

	if( (selopt=="?" ) && ( (document.forms[0].selcol1.selectedIndex>0) || (document.forms[0].selcol2.selectedIndex>0)))
	{
		alert("Select only Formulas to compare");
		return;
	}
	else if( (selopt=="?" ) && ( (document.forms[0].selformula1.value=="") || (document.forms[0].selformula2.value=="")))
	{
		alert("Select Formulas to compare");
		return;
	}
	if(selopt=="%" && dbnum1>0)
	{
		dbnum1 = dbnum1/100;
	}
	if(selopt=="%" && dbnum2>0)
	{
		dbnum2 = dbnum2/100;
	}
	selformula1 =  document.forms[0].selformula1.value;
	if(selformula1)
	{
		arr = selformula1.split("::")
	
		if(arr)
		{
			if((strFormulaType=="GT") || (selopt=="?"))
			{
				selformula1 =arr[0];	
			}
			else
			{
				selformula1 =arr[1];	
			}
		}
	}
	selformuladesc1 =  document.forms[0].txtformula1.value;
	selformula2 = document.forms[0].selformula2.value;
	if(selformula2)
	{
		arr1 = selformula2.split("::")
		if(arr1)
		{
			if((strFormulaType=="GT") || (selopt=="?"))
			{
				selformula2 =arr1[0];	
			}
			else
			{
				selformula2 =arr1[1];	
			}
		}
	}
	selformuladesc2 = document.forms[0].txtformula2.value;
	formval =  checktrim(document.forms[0].txtformula.value);
	formvaldesc = document.forms[0].formuladesc.value;
	
	//Modifying the formula for the Previous Year
	if(selCMAyr1 == "~" && selformula1!="")
	{
		selformula1 = replace(selformula1,"$","~"); 
	}
	if(selCMAyr2 == "~" && selformula2!="")
	{
		selformula2 = replace(selformula2,"$","~"); 
	}
	if(selvalue1 !="" && selformula1=="" &&  selopt != "" && selvalue2 !="" && selformula2=="" && dbnum1==0 && dbnum2==0)
	{
		//VALUE & VALUE	
		formula = "(<"+selvalue1+selCMAyr1+ selopt+"&" + selvalue2+selCMAyr2+")>";
		formuladesc = "( "+selvaluedesc1 +" "+ selopt +" " + selvaluedesc2 +" )";
	}
	else if(selvalue1 =="" && selformula1!="" && selopt != "" && selvalue2 !="" && selformula2=="" && dbnum1==0 && dbnum2==0)
	{
		//FORMULA & VALUE
		formula = selformula1 + selopt+"&" + selvalue2+selCMAyr2;
		formuladesc = "( "+selformuladesc1 +" "+ selopt +" "+ selvaluedesc2 +" )";
		if(formval=="")
		{
			formula = "(<"+formula+")>";
		}
	}
	else if(selvalue1 !="" && selformula1=="" && selopt != "" && selvalue2 =="" && selformula2!="" && dbnum1==0 && dbnum2==0)
	{
		//VALUE & FORMULA
		formula = "(<"+selvalue1+selCMAyr1+ selopt+"&" + selformula2+")>";
		formuladesc = "( "+selvaluedesc1 + " "+ selopt + " "+ selformuladesc2 +" )";
	}
	else if(selvalue1 =="" && selformula1!="" && selopt != "" && selvalue2 =="" && selformula2!="" && dbnum1==0 && dbnum2==0)
	{
		//FORMULA & FORMULA
		if((strFormulaType=="GT") || (selopt=="?"))
		{
			selformula1 = selformula1+"$";
			selformula2 = selformula2+"$";
		}
		formula = "(<"+selformula1+selopt+"&" + selformula2+")>";
		if(selopt=="?")
		{
			formuladesc = "( "+selformuladesc1+"compare"+selformuladesc2+")";
		}
		else
		{
			formuladesc = "( "+selformuladesc1 +" "+ selopt +" "+ selformuladesc2 +" )";
		}
	}
	else if(selvalue1 =="" && selformula1=="" && selopt != "" && selvalue2 !="" && selformula2=="" && dbnum1==0 && dbnum2==0 )
	{
		//EMPTY & VALUE
		formula = selopt+"&" + selvalue2+selCMAyr2;
		formuladesc = "( "+ selopt+" " + selvaluedesc2 +" )";
	}
	else if(selvalue1 =="" && selformula1=="" && selopt != "" && selvalue2 =="" && selformula2 !="" && dbnum1==0 && dbnum2==0)
	{
		//EMPTY & FORMULA
		if(strFormulaType=="GT")
		{
			selformula2 = selformula2+"$";
		}
		formula = selopt+"&" + selformula2;
		formuladesc = "( "+ selopt +" "+ selformuladesc2 +" )";
	}
	else if(selvalue1 !="" && selformula1=="" && selopt == "" && selvalue2 =="" && selformula2 =="" && dbnum1==0 && dbnum2==0)
	{
		//VALUE & EMPTY
		formula = "(<"+selvalue1+selCMAyr1+")>";
		formuladesc = "( "+  selvaluedesc1 +" )";
	}	
	else if(selvalue1 =="" && selformula1 !="" && dbnum1==0 && selopt == "" && selvalue2 =="" && selformula2 =="" && dbnum2==0)
	{
		//FORMULA & EMPTY
		if(strFormulaType=="GT")
		{
		formula = "(<"+selformula1+"$)>";
		}
		else
		{
		formula = selformula1;
		}
		formuladesc = "( "+  selformuladesc1 +" )";
	}
	else if(selvalue1 =="" && selformula1=="" && selopt == "" && selvalue2 !="" && selformula2 ==""  && dbnum1==0 && dbnum2==0)
	{
		//EMPTY & VALUE (NO OPERATOR)
		formula ="(<"+selvalue2+"$)>";
		formuladesc = "( "+  selvaluedesc2 +" )";
	}	
	else if(selvalue1 =="" && selformula1 =="" && selopt == "" && selvalue2 =="" && selformula2 !="" && dbnum1==0 && dbnum2==0)
	{
		//EMPTY & FORMULA (NO OPERATOR)
		formula = "(<"+selformula2+"$)>";
		formuladesc = "( "+  selformuladesc2 +" )";
	}
	else if(selvalue1 =="" && selformula1 =="" && dbnum1 !=0 && selopt != "" && selvalue2 !="" && selformula2 =="" && dbnum2 ==0)
	{
		//CONST & VALUE
		if(selopt=="%")
		{
			formula = "(<"+dbnum1+"#*&"+selvalue2+selCMAyr2+")>";
			formuladesc = "( "+  document.forms[0].txtnumber1.value +" % "+selvaluedesc2+" )";
		}
		else 
		{
			formula = "(<"+dbnum1+"#"+selopt+"&"+selvalue2+selCMAyr2+")>";
			formuladesc = "( "+  document.forms[0].txtnumber1.value +" "+ selopt +" " +selvaluedesc2+" )";
		}
	}

	else if(selvalue1 =="" && selformula1 =="" && dbnum1 !=0 && selopt != "" && selvalue2 =="" && selformula2 !="" && dbnum2 ==0)
	{
		//CONST & FORMULA
		if(strFormulaType=="GT")
		{
			selformula2 = selformula2+"$";
		}
		if(selopt=="%")
		{
			formula = "(<"+dbnum1+"#*&"+selformula2+")>";
			formuladesc = "( "+  document.forms[0].txtnumber1.value +" % "+selformuladesc2+" )";
		}
		else 
		{
			formula = "(<"+dbnum1+"#"+selopt+"&"+selformula2+")>";
			formuladesc = "( "+  document.forms[0].txtnumber1.value +" " + selopt +" "+selformuladesc2+" )";
		}
	}
	else if(selvalue1 !="" && selformula1 =="" && dbnum1 ==0 && selopt != "" && selvalue2 =="" && selformula2 =="" && dbnum2 !=0)
	{
		//VALUE & CONST
		formula = "(<"+selvalue1+selCMAyr1+selopt+"&"+dbnum2+"#)>";
		formuladesc = "( "+ selvaluedesc1+ " "+ selopt +" "+ document.forms[0].txtnumber2.value +" )";
	}
	else if(selvalue1 =="" && selformula1 !="" && dbnum1 ==0 && selopt != "" && selvalue2 =="" && selformula2 =="" && dbnum2 !=0)
	{
		//FORMULA & CONST
		if(strFormulaType=="GT")
		{
			selformula1 = selformula1+"$";
		}
		formula = "(<"+selformula1+selopt+"&"+dbnum2+"#)>";
		formuladesc = "( "+ selformuladesc1+ " "+selopt+ " "+ document.forms[0].txtnumber2.value +" )";
	}
	else if(selvalue1 =="" && selformula1 =="" && dbnum1 ==0 && selopt != "" && selvalue2 =="" && selformula2 =="" && dbnum2 !=0)
	{
		//EMPTY & CONST
		if(strFormulaType=="GT")
		{
			selformula1 = selformula1+"$";
		}
		formula = selopt+"&"+dbnum2+"#";
		formuladesc = " "+ selopt+ " "+ document.forms[0].txtnumber2.value ;
	}
	alert("Formula Added");
	if(formval!="")
	{
		formval = 	"(<"+ formval + formula +")>";
		formvaldesc = 	"( "+ formvaldesc + " "+formuladesc +" )";
	}
	else
	{
		formval = 	 formula ;
		formvaldesc = formuladesc;
	}
	document.forms[0].txtformula.value =formval;
	document.forms[0].formuladesc.value =formvaldesc;
}
}
 function onApply()
{
	if(document.forms[0].cmdnew.disabled == true)
	{
		varmode=1;
	}
	else
	{
		varmode=0;
	}
	
	document.forms[0].hidBeanId.value="comformula";
	document.forms[0].action=path+"controllerservlet";
	document.forms[0].hidBeanMethod.value="getFinValue";
	document.forms[0].varmode.value=varmode;
	document.forms[0].hidSourceUrl.value="/action/com_formula.jsp";
	document.forms[0].submit();
}
function doClose()
{
		if( ConfirmMsg(100) )
		{
			document.forms[0].action=path+"action/setupnav.jsp";
			document.forms[0].submit();
		}
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(document.forms[0].cmano.value=="")
		{
			alert("Select CMA Type");
			return;
		}
		if(document.forms[0].rowid.value =="") 
		{
			alert("Select A Formula To Delete");
			return;
		}
		
		else
		{
			if(ConfirmMsg(101))
			 {
				document.forms[0].val.value = "cma";
				document.forms[0].hidAction.value="delete";			
				document.forms[0].hidBeanId.value="formula";
				document.forms[0].hidBeanGetMethod.value="updateData";
				document.forms[0].hidSourceUrl.value="/action/com_formula.jsp";
				document.forms[0].submit();
			 }
		}
	}
	else
	{
		ShowAlert(158);
	}
}
function doSave()
{
	if(document.forms[0].selcma.selectedIndex==0 )
	{
		alert("Select CMA Type");
		return ;
	}
	if( document.forms[0].forname.value=="")
	{
		alert("Enter Formula Name");
		return ;
	}
	if(document.forms[0].choformula.selectedIndex<=0)
	{
		alert("Select Formula For");
		return ;
	}
	if(document.forms[0].rowid.value=="")
	{
		document.forms[0].hidAction.value="insert";
		varmode=1;
	}
	if(document.forms[0].rowid.value!="")
	{
		document.forms[0].hidAction.value="update";
		varmode=0;

	}	
	// old code gives loop error crashing server modifed mck
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidBeanId.value="formula";
	document.forms[0].hidBeanGetMethod.value="updateData";
	document.forms[0].action=path+"action/com_formula.jsp?val=cma&varmode="+varmode;
	document.forms[0].submit();
}

function showRating(val)
{
 	tabtitle="";
	cmano="";
	var purl = appURL+"jsp/com/finmasterselect.jsp?val="+val+"&tabtitle="+tabtitle+"cmano="+cmano;
	var title = "Help";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}

function openFormula()
{
	if((document.forms[0].cmdedit.disabled == false) && (document.forms[0].cmdnew.disabled == true))
	{
		return;
	}
	var cmano=document.forms[0].cmano.value;
	if (cmano=="")
	{
		alert("Select cma type");
		
	}
	else
	{
		var purl ="";
		purl =  path+"action/formulaselect.jsp?hidBeanGetMethod=getFormulaData&hidBeanId=formula&cmano="+cmano+"&HiddenControl=&TextControl=";
		var prop = 'scrollbars=yes,width=450,height=320';	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
	}
}

function showFormula(val)
{
	
	if(!(document.forms[0].cmdsave.disabled == false))
	{
		return;
	}
	var cmano=document.forms[0].cmano.value;
	if (cmano=="")
	{
		alert("Select cma type");
		
	}
	else
	{
		var purl ="";
		if(val=="formula1")
			purl =  path+"action/formulaselect.jsp?hidBeanGetMethod=getFormulaData&hidBeanId=formula&cmano="+cmano+"&HiddenControl=selformula1&TextControl=txtformula1";
		else if(val=="formula2")
			purl =  path+"action/formulaselect.jsp?hidBeanGetMethod=getFormulaData&hidBeanId=formula&cmano="+cmano+"&HiddenControl=selformula2&TextControl=txtformula2";
		else
			purl =  path+"action/formulaselect.jsp?hidBeanGetMethod=getFormulaData&hidBeanId=formula&cmano="+cmano+"&HiddenControl=&TextControl=";
		
		var prop = 'scrollbars=yes,width=450,height=320';	
		var xpos = (screen.width - 350) / 2;
		var ypos = (screen.height - 320) / 2;
		prop = prop + ",left="+xpos+",top="+ypos;
		window.open(purl,'title',prop);
	}
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		enableButtons(false,false,true,false,true,false);
		changemode('true');
		document.forms[0].selcol1.value="";
		document.forms[0].selformula1.value="";
		document.forms[0].txtformula1.value="";
		document.forms[0].selopt.value="";
		document.forms[0].selcol2.value="";
		document.forms[0].selformula2.value="";
		document.forms[0].txtformula2.value="";
		document.forms[0].choformula.value="";
		document.forms[0].choformulatype.value="S";
		document.forms[0].txtnumber1.value="";
		document.forms[0].txtnumber2.value="";
		document.forms[0].rowid.value=varrowid;
		document.forms[0].forname.value=varforname;
		document.forms[0].choformula.value=varforvalue;
		if(varfortypevalue=="")
		{
			varfortypevalue="S";
		}
		document.forms[0].choformulatype.value=varfortypevalue;
		document.forms[0].formuladesc.value=varformuladesc;
		document.forms[0].txtformula.value=vartxtformula;
	}
}

function placeValues()
{
	var selcma="<%=strCma%>";
	var sel=document.forms[0].selcma.options[document.forms[0].selcma.selectedIndex].value;
	document.forms[0].selcma.value=selcma;
	document.forms[0].cmano.value=document.forms[0].selcma.options[document.forms[0].selcma.selectedIndex].value
	document.forms[0].formuladesc.readOnly=true;
	varmode="<%=Helper.correctNull((String) request
							.getParameter("varmode"))%>";
	if (varmode == "0")
	{
		enableButtons(false,false,true,false,true,false);
		changemode('true');
	}
	else
	{
		enableButtons(true,false,false,true,false,true);
		document.forms[0].forname.focus();
	}
	deletion="<%=Helper.correctNull((String) hshValues.get("deletion"))%>";
	
	permentdisable();
	
	selectcombo();
	
	if (deletion  == "terminated")
	{
		alert("The Record Has Not Been Deleted");
		return;
	} 
}

function doEdit()
{
	varrowid =document.forms[0].rowid.value;
	varforname=document.forms[0].forname.value;
	varformuladesc=document.forms[0].formuladesc.value;
	vartxtformula=document.forms[0].txtformula.value;
	varforvalue=document.forms[0].choformula.value
	varfortypevalue=document.forms[0].choformulatype.value

	if(document.forms[0].selcma.selectedIndex==0 )
	{
		alert("Select CMA Type");
		return false;
	}
	else if( document.forms[0].forname.value=="")
	{
		alert("Enter Formula Name");
		return false;
	}
	
	else
	{
	enableButtons(true,true,false,false,false,true);
	changemode(false);
	}
}

function doNew()
{
	document.forms[0].rowid.value="";
	document.forms[0].forname.value="";
	document.forms[0].formuladesc.value="";
	document.forms[0].forcode.value="";
	document.forms[0].txtformula.value="";	
	varrowid =document.forms[0].rowid.value;
	varforname=document.forms[0].forname.value;
	varformuladesc=document.forms[0].formuladesc.value;
	vartxtformula=document.forms[0].txtformula.value;
	document.forms[0].choformula.value = "";
	document.forms[0].choformulatype.value = "S";
	enableButtons(true,false,false,true,false,false);
	changemode(false);
}

function enableButtons(bool1,bool2,bool3,bool4,bool5,bool6)
{
	document.forms[0].cmdnew.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdsave.disabled=bool3;
	document.forms[0].cmddelete.disabled=bool4;
	document.forms[0].cmdcancel.disabled=bool5;
	document.forms[0].cmdclose.disabled=bool6;
}

function getValue()
{
var val="";
var id="";

	if (document.forms[0].selcma.value != "")
	{
		val=document.forms[0].selcma.options[document.forms[0].selcma.selectedIndex].text;
		id=document.forms[0].selcma.options[document.forms[0].selcma.selectedIndex].value;		
		document.forms[0].cmano.value=id;	
	}
	if(document.forms[0].cmdnew.disabled == true)
	{
		varmode=1;
	}
	else
	{
		varmode=0;
	}
	document.forms[0].action=path+"action/com_formula.jsp?val=cma&varmode="+varmode;
	document.forms[0].submit();
}
function getformulatype()
{
	if(document.forms[0].choformula.value=="CA" || document.forms[0].choformula.value=="MPBF1" || document.forms[0].choformula.value=="MPBF2" || document.forms[0].choformula.value=="PBF1" || document.forms[0].choformula.value=="PBF2" || document.forms[0].choformula.value=="PBF3" || document.forms[0].choformula.value=="PBF4" || document.forms[0].choformula.value=="TO")
	{
		document.forms[0].choformulatype.length=6;
		document.forms[0].choformulatype.options[0].value="S";
		document.forms[0].choformulatype.options[0].text="<-- Select -->";
		document.forms[0].choformulatype.options[1].value="I";
		document.forms[0].choformulatype.options[1].text="Increase";
		document.forms[0].choformulatype.options[2].value="D";
		document.forms[0].choformulatype.options[2].text="Decrease";
		document.forms[0].choformulatype.options[3].value="GT";
		document.forms[0].choformulatype.options[3].text="Group-Total";
		document.forms[0].choformulatype.options[4].value="H";
		document.forms[0].choformulatype.options[4].text="Higher";
		document.forms[0].choformulatype.options[5].value="L";
		document.forms[0].choformulatype.options[5].text="Lower";	 
	}
	
	 if(document.forms[0].choformula.value=="FU")
	{
		document.forms[0].choformulatype.length=9;
		document.forms[0].choformulatype.options[0].value="S";
		document.forms[0].choformulatype.options[0].text="<-- Select -->";
		document.forms[0].choformulatype.options[1].value="I";
		document.forms[0].choformulatype.options[1].text="Increase";
		document.forms[0].choformulatype.options[2].value="D";
		document.forms[0].choformulatype.options[2].text="Decrease";
		document.forms[0].choformulatype.options[3].value="GT";
		document.forms[0].choformulatype.options[3].text="Group-Total";
		document.forms[0].choformulatype.options[4].value="NFL";
		document.forms[0].choformulatype.options[4].text="Net Funds Lost";
		document.forms[0].choformulatype.options[5].value="LTS";
		document.forms[0].choformulatype.options[5].text="Long Term Sources";
		document.forms[0].choformulatype.options[6].value="H";
		document.forms[0].choformulatype.options[6].text="Higher";
		document.forms[0].choformulatype.options[7].value="L";
		document.forms[0].choformulatype.options[7].text="Lower";
		document.forms[0].choformulatype.options[8].value="ID";
		document.forms[0].choformulatype.options[8].text="Increase/Decrease";
		 
	}
	if(document.forms[0].choformula.value=="FI" || document.forms[0].choformula.value=="RA")
	{
		document.forms[0].choformulatype.length=3;
		document.forms[0].choformulatype.options[0].value="S";
		document.forms[0].choformulatype.options[0].text="<-- Select -->";
		document.forms[0].choformulatype.options[1].value="H";
		document.forms[0].choformulatype.options[1].text="Higher";
		document.forms[0].choformulatype.options[2].value="L";
		document.forms[0].choformulatype.options[2].text="Lower";
	}
	//val=document.forms[0].selcma.options[document.forms[0].selcma.selectedIndex].text;
	document.forms[0].hidformfor.value = document.forms[0].choformula.options[document.forms[0].choformula.selectedIndex].text;
}

function changemode(val)
{
	document.forms[0].selcol1.disabled=val;
	document.forms[0].selCMAyr1.disabled=val;
	document.forms[0].selopt.disabled=val;
	document.forms[0].selcol2.disabled=val;
	document.forms[0].selCMAyr2.disabled=val;
	document.forms[0].forname.readOnly=val;
	document.forms[0].choformula.disabled=val;
	document.forms[0].choformulatype.disabled=val;
	document.forms[0].txtnumber1.readOnly=val;
	document.forms[0].txtnumber2.readOnly=val;
	document.forms[0].apply2.disabled=val;	
}
function permentdisable()
{
	document.forms[0].formuladesc.readOnly=true;
	document.forms[0].txtformula.readOnly=true;
}
function clearVal()
{
	var clr=confirm("Do you want to clear the Formula");
	if(clr==true)
	{
	document.forms[0].formuladesc.value="";
	document.forms[0].txtformula.value="";
	}	
}
function selectcombo()
{
	combovalue="<%=Helper.correctNull((String) hshValues.get("choformula"))%>";
	if (combovalue != "")
	{
		document.forms[0].choformula.value = combovalue;
	}
	else
	{
		document.forms[0].choformula.value = "";
	}
	getformulatype();
	combovalue="<%=Helper.correctNull((String) hshValues.get("choformulatype"))%>";
	if (combovalue != "")
	{
		document.forms[0].choformulatype.value = combovalue;
	}
	else
	{
		document.forms[0].choformulatype.value = "S";
	}
}

</script>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
<link rel="stylesheet" href="<%=ApplicationParams.getAppUrl()%>css/style.css" type="text/css">
</head>
<body onload="placeValues()">
<form method="post" class="normal">
<table width="100%" border="0" cellspacing="0" cellpadding="0">
	<tr class="page_flow">
		<td valign="bottom">Home -&gt;Setup -&gt; Corporate Products-&gt; Formula Definition</td>
	</tr>
</table>
<br>
<table width="100%" border="0" cellspacing="0" cellpadding="5" class="outertable">
	<tr>
		<td>
		<table width="100%" border="0" cellspacing="0" cellpadding="2" align="center" class="outertable border1 tableBg">
			<tr>
				<td>
				<table width="100%" border="0" cellspacing="0" cellpadding="4" align="center" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
									<tr>
										<td width="12%" height="43">CMA Type</td>
										<td width="20%" height="43"><select name="selcma"
											onchange="getValue()">
											<option value=""><--Select--></option>
											<lapschoice:finmaster />
										</select></td>
										<td width="12%" height="43">Formula Name</td>
										<td colspan="2" height="43"><input type="text"
											name="forname" size="60"
											value="<%=Helper.correctNull((String) hshValues.get("forname"))%>"
											maxlength="100"> <b><span onClick="openFormula()"
											style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
									</tr>
									<tr>
										<td width="12%">Formula for</td>
										<td width="20%"><input type="hidden" name="forcode"
											size="25" value="forcode"> <select name="choformula"
											onChange="getformulatype()">
											<option value="" selected><--Select--></option>
											<option value="FI">Financials</option>
											<option value="RA">Ratios</option>
											<option value="DSCR">DSCR</option>
											<option value="CA">Cash Flow</option>
											<option value="FU">Fund Flow</option>
											<option value="INV">Assessment - Inventory Norms</option>
											<option value="MU">Assessment - MPBF UPTO 25 CRORES</option>
											<option value="MA">Assessment - MPBF ABOVE 25 CRORES</option>
											<option value="FL">Assessment - Forex Limits</option>
											<!--  <option value="MPBF1">Assessment - MPBF1</option>
											<option value="MPBF2">Assessment - Holding Level</option>
											<option value="PBF1">Assessment - NBFC1</option>
											<option value="PBF2">Assessment - NBFC2</option>
											<option value="TO">Assessment - Turn Over</option>-->											
										</select></td>
										<td width="12%">Formula Type</td>
										<td width="15%"><select name="choformulatype">
											<option value="S" selected><--Select--></option>
											<option value="I">Increase</option>
											<option value="D">Decrease</option>
											<option value="GT">Group-Total</option>
											<option value="NFL">Net Funds Lost</option>
											<option value="LTS">Long Term Sources</option>
											<option value="ID">Increase/Decrease</option>
										</select></td>
										<td width="31%">&nbsp;</td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="54%">
						<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr >
										<td width="24%">CMA- 1</td>
										<td width="36%"><select name="selcol1">
											<option value=""><--Select--></option>
											<lapschoice:finmasthelp />
										</select></td>
										<td  width="24%">Year</td>
										<td width="16%"><select name="selCMAyr1">
											<option value="$" selected>Current Year</option>
											<option value="~">Previous Year</option>
										</select></td>
									</tr>
									<tr >
										<td width="24%">Formula-1</td>
										<td width="36%"><input type="hidden" name="selformula1">
										<input type="text" name="txtformula1" readOnly> <b><span
											onClick="showFormula('formula1')" style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
										<td  width="24%">Numerals -1</td>
										<td width="16%"><input type="text" name="txtnumber1"
											size="5"></td>										
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="64%">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td>
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr >
										<td width="14%">Select Operator</td>
										<td ><select name="selopt">
											<option value="" selected><--Select--></option>
											<option value="+">(+)</option>
											<option value="-">(-)</option>
											<option value="*">(X)</option>
											<option value="/">(/)</option>
											<option value="%">(%)</option>
											<option value="?">Compare</option>
										</select></td>
									</tr>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
					<tr>
						<td width="64%">
						<table width="100%" border="0" cellspacing="0" cellpadding="3"
							class="outertable">
							<tr>
								<td colspan="2">
								<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
									<tr>
										<td width="25%" >CMA -2</td>
										<td width="37%" ><select name="selcol2">
											<option value=""><--Select--></option>
											<lapschoice:finmasthelp />
										</select></td>
										<td  width="25%">Year</td>
										<td width="15%" ><select
											name="selCMAyr2">
											<option value="$" selected>Current Year</option>
											<option value="~">Previous Year</option>
										</select></td>
									</tr>
									<tr>
										<td width="25%" >Formula-2</td>
										<td width="37%" ><input type="hidden"
											name="selformula2"> <input type="text"
											name="txtformula2" readOnly> <b><span
											onClick="showFormula('formula2')" style="cursor: hand"><img
											src="<%=ApplicationParams.getAppUrl()%>/img/search_corp.gif"
											border="0"></span></b></td>
										<td  width="25%">Numerals -2</td>
										<td width="15%" ><input type="text"
											name="txtnumber2" size="5"></td>
									<tr  align="center">
										<td colspan="2"><input type="button" name="apply2"
											value="Add Formula" onClick="makeformula()" class="buttonstyle"></td>
										<td colspan="2"><input type="button" name="Clear"
											value="Clear Formula" onClick="clearVal()" class="buttonstyle"></td>
								</table>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td width="64%">
				<table width="100%" border="0" cellspacing="0" cellpadding="3" class="outertable">
					<tr>
						<td>
						<table width="100%" border="0" cellspacing="1" cellpadding="3" class="outertable">
							<tr >
								<td  width="8%">Formula</td>
								<td  width="92%"><textarea
									name="formuladesc" rows="5" cols="130" wrap="VIRTUAL" onKeyPress="textlimit(this,3999)" onKeyUp="textlimit(this,3999)"><%=Helper.correctNull((String) hshValues
									.get("formuladesc"))%></textarea>
								</td>
							</tr>
						</table>
						</td>
					</tr>
				</table>
				<input type="hidden" name="txtformula" size="124"
					value="<%=Helper.correctNull((String) hshValues.get("txtformula"))%>">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
<br>
<lapschoice:combuttonnew btnnames="New_Edit_Save_Cancel_Delete_Audit Trail" btnenable='<%=Helper.correctNull((String) request.getParameter("btnenable"))%>' />
<lapschoice:hiddentag pageid='<%=PageId%>' /> 
<input type="hidden" name="rowid" value="<%=Helper.correctNull((String) hshValues.get("rowid"))%>">
<input type="hidden" name="cmano" value="<%=Helper.correctNull((String) hshValues.get("cmano"))%>">
<input type="hidden" name="val"> 
<input type="hidden" name="varmode" value="">
<input type ="hidden" name ="hidkeyid" value="set">
<input type = "hidden" name = "hidformfor">
</form>
</body>
</html>
