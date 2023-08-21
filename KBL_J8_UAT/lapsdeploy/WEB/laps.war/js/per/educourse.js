function callLink(page,bean,method)
{	
	if (document.forms[0].hideditflag.value=="N")
	{
		document.forms[0].hidAction.value="";
		document.forms[0].hidBeanGetMethod.value=method;
		document.forms[0].hidBeanId.value=bean;
		document.forms[0].action=appURL+"action/"+page;
		document.forms[0].submit();
	}
	else
	{
		ShowAlert(103);
	}
}

function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=appURL+"action/perborrowersearch.jsp?hidPageType=EXI";
		document.forms[0].submit();
	}
	
}


function doSave()
{
	document.forms[0].hidRecordflag.value=varRecordFlag;
	if(parseFloat(document.forms[0].txt_TotalExpensesValue.value) == '0.00')
		{
		alert("Enter values in page or press Cancel to proceed");
		return;
		}
	if(parseFloat(document.forms[0].total_1year.value)!=parseFloat(document.forms[0].total_exp1year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for first year");
		return;
		}
	if(parseFloat(document.forms[0].total_2year.value)!=parseFloat(document.forms[0].total_exp2year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for second year");
		return;
		}
	if(parseFloat(document.forms[0].total_3year.value)!=parseFloat(document.forms[0].total_exp3year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for third year");
		return;
		}
	if(parseFloat(document.forms[0].total_4year.value)!=parseFloat(document.forms[0].total_exp4year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for fourth year");
		return;
		}
	if(parseFloat(document.forms[0].total_5year.value)!=parseFloat(document.forms[0].total_exp5year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for fifth year");
		return;
		}
	if(parseFloat(document.forms[0].total_6year.value)!=parseFloat(document.forms[0].total_exp6year.value))
		{
		alert("Cost of Estimates & Means of finance is not same for sixth year");
		return;
		}
	
		document.forms[0].cmdsave.disabled=true;
 		document.forms[0].hidBeanId.value="eduscholar";		
		document.forms[0].hidSourceUrl.value="/action/educourse.jsp";
		document.forms[0].hidBeanMethod.value="updateDataExp";
		document.forms[0].hidBeanGetMethod.value="getDataExp";
		document.forms[0].action=appURL+"controllerservlet";
		document.forms[0].submit();
	
}

function disableCmdButtons(val)
{	 
	
	if(val=="edit")
	{		  
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmddelete.disabled=false;
		document.forms[0].cmdsave.disabled=false;
		document.forms[0].cmdcancel.disabled=false;		 
		document.forms[0].cmdclose.disabled=true;	 
		disableFields(false);
	}
	
}  

function doEdit()
{ 	
	disableFields(false);
	document.forms[0].hideditflag.value ="Y";
	document.forms[0].hidAction.value ="update";
	disableCmdButtons("edit");
}

function doCancel()
{
	if(ConfirmMsg(102))
	{
		document.forms[0].hidBeanId.value="eduscholar";
		document.forms[0].hidBeanGetMethod.value="getDataExp";
		document.forms[0].action=appURL+"action/educourse.jsp";
		document.forms[0].method="post";
		document.forms[0].submit();
	}
}

function getTotalValue(year1, year2, year3, year4, year5, year6, totalexpenses, totalexpensesvalue)
{
	var year1 = year1.value;
	var year2 = year2.value;
	var year3 = year3.value;
	var year4 = year4.value;
	var year5 = year5.value;
	var year6 = year6.value;
	var totalexpensesvalue = totalexpensesvalue.value;

	if(year1=="")
	{
		year1 =0.00;
	}

	if(year2=="")
	{
		year2 =0.00;
	}

	if(year3=="")
	{
		year3 =0.00;
	}

	if(year4=="")
	{
		year4 =0.00;
	}

	if(year5=="")
	{
		year5 =0.00;
	}

	if(year6=="")
	{
		year6 =0.00;
	}
	
	if(totalexpensesvalue=="")
	{
		totalexpensesvalue =0.00;
	}
	
	TotalExpenses = eval(year1) + eval(year2) + eval(year3) + eval(year4) + eval(year5) + eval(year6);
	totalexpenses.value = TotalExpenses;
	totalexpensesvalue = eval(totalexpensesvalue) + eval(TotalExpenses);
	totalexpensesvalue.value = totalexpensesvalue;
	roundtxt(totalexpenses);
	return totalexpenses.value;
}

function getTotalValue1(year1,year2,year3,year4,year5,year6,txt_newexpenses,txt_totalnewexpenses)
{
	var year1 = year1.value;
	var year2 = year2.value;
	var year3 = year3.value;
	var year4 = year4.value;
	var year5 = year5.value;
	var year6 = year6.value;
	if(year1=="")
	{
		year1 =0.00;
	}

	if(year2=="")
	{
		year2 =0.00;
	}

	if(year3=="")
	{
		year3 =0.00;
	}

	if(year4=="")
	{
		year4 =0.00;
	}

	if(year5=="")
	{
		year5 =0.00;
	}

	if(year6=="")
	{
		year6 =0.00;
	}
	var txt_totalnewexpenses =txt_totalnewexpenses.value;
  
	if(totalexpensesvalue=="")
	{
		totalexpensesvalue =0.00;
	}
	
	txt_newexpensesval = eval(year1) + eval(year2) + eval(year3) + eval(year4) + eval(year5) + eval(year6);
	txt_newexpenses.value = txt_newexpensesval;
	txt_totalnewexpensesval = eval(txt_totalnewexpenses) + eval(txt_newexpenses);
	txt_totalnewexpenses.value = txt_totalnewexpensesval;
	roundtxt(txt_newexpenses);
	return txt_newexpenses.value;
}
function totalexpensesvalue()
{
	var totalvalue1=0.00;
	for(var i=0;i<15;i++)
		{
		var txt_totalexpenses=document.forms[0].txt_totalexpenses[i].value;
		if(document.forms[0].txt_totalexpenses[i].value=="")
			{
			txt_totalexpenses[i]="0.00";
			}
		totalvalue1 = eval( txt_totalexpenses)+eval(totalvalue1)
		}
	document.forms[0].txt_TotalExpensesValue.value= eval(totalvalue1);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function totalexpensesvalue1()
{
	var totalvalue1=0.00;
	for(var i=0;i<12;i++)
		{
		var txt_newexpenses=document.forms[0].txt_newexpenses[i].value;
		if(document.forms[0].txt_newexpenses[i].value=="")
			{
			txt_newexpenses[i]="0.00";
			}
		totalvalue1 = eval( txt_newexpenses)+eval(totalvalue1)
		}
	document.forms[0].txt_totalnewexpenses.value= eval(totalvalue1);
	
	roundtxt(document.forms[0].txt_totalnewexpenses);
}
function totexpval()
	{
	for(var i=0;i<15;i++)
		{
		var txt_Iyear=document.forms[0].txt_Iyear[i].value;
		var txt_2year=document.forms[0].txt_2year[i].value;
		var txt_3year=document.forms[0].txt_3year[i].value;
		var txt_4year=document.forms[0].txt_4year[i].value;
		var txt_5year=document.forms[0].txt_5year[i].value;
		var txt_6year=document.forms[0].txt_6year[i].value;
		if(document.forms[0].txt_Iyear[i].value=="")
			{
			txt_Iyear="0.00";
			}
		if(document.forms[0].txt_2year[i].value=="")
			{
			txt_2year="0.00";
			}
		if(document.forms[0].txt_3year[i].value=="")
			{
			txt_3year="0.00";
			}
		if(document.forms[0].txt_4year[i].value=="")
			{
			txt_4year="0.00";
			}
		if(document.forms[0].txt_5year[i].value=="")
			{
			txt_5year="0.00";
			}
		if(document.forms[0].txt_6year[i].value=="")
			{
			txt_6year="0.00";
			}
		document.forms[0].txt_totalexpenses[i].value=eval(txt_Iyear)+eval(txt_2year)+eval(txt_3year)+eval(txt_4year)+eval(txt_5year)+eval(txt_6year);
		if(document.forms[0].txt_totalexpenses[i].value=="NaN")
			{
			document.forms[0].txt_totalexpenses[i].value="";
			}
			roundtxt(document.forms[0].txt_totalexpenses[i]);
		}
	}
function totsourceval()
	{
	for(var i=0;i<12;i++)
		{
		var exp_1year=document.forms[0].exp_1year[i].value;
		var exp_2year=document.forms[0].exp_2year[i].value;
		var exp_3year=document.forms[0].exp_3year[i].value;
		var exp_4year=document.forms[0].exp_4year[i].value;
		var exp_5year=document.forms[0].exp_5year[i].value;
		var exp_6year=document.forms[0].exp_6year[i].value;
		if(document.forms[0].exp_1year[i].value=="")
			{
			exp_1year="0.00";
			}
		if(document.forms[0].exp_2year[i].value=="")
			{
			exp_2year="0.00";
			}
		if(document.forms[0].exp_3year[i].value=="")
			{
			exp_3year="0.00";
			}
		if(document.forms[0].exp_4year[i].value=="")
			{
			exp_4year="0.00";
			}
		if(document.forms[0].exp_5year[i].value=="")
			{
			exp_5year="0.00";
			}
		if(document.forms[0].exp_6year[i].value=="")
			{
			exp_6year="0.00";
			}
		document.forms[0].txt_newexpenses[i].value=eval(exp_1year)+eval(exp_2year)+eval(exp_3year)+eval(exp_4year)+eval(exp_5year)+eval(exp_6year);
		if(document.forms[0].txt_newexpenses[i].value=="NaN")
			{
			document.forms[0].txt_newexpenses[i].value="";
			}
			roundtxt(document.forms[0].txt_newexpenses[i]);
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
	}
	for(var i=0;i<15;i++)
	{
		document.forms[0].txt_totalexpenses[i].readOnly=true;
			
	}
	for(var i=0;i<12;i++)
	{
		document.forms[0].txt_newexpenses[i].readOnly=true;
			
	}
	
	
	document.forms[0].total_1year.readOnly=true;
	document.forms[0].total_2year.readOnly=true;
	document.forms[0].total_3year.readOnly=true;
	document.forms[0].total_4year.readOnly=true;
	document.forms[0].total_5year.readOnly=true;
	document.forms[0].total_6year.readOnly=true;
	document.forms[0].total_exp1year.readOnly=true;
	document.forms[0].total_exp2year.readOnly=true;
	document.forms[0].total_exp3year.readOnly=true;
	document.forms[0].total_exp4year.readOnly=true;
	document.forms[0].total_exp5year.readOnly=true;
	document.forms[0].total_exp6year.readOnly=true;
	document.forms[0].txt_TotalExpensesValue.readOnly=true;
	document.forms[0].txt_totalnewexpenses.readOnly=true;
}

function total1year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		var value1 =  document.forms[0].txt_Iyear[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue);
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	document.forms[0].total_1year.value= totalvalue;
	roundtxt(document.forms[0].total_1year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function total2year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		var value1 =  document.forms[0].txt_2year[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue);
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].total_2year.value= totalvalue;
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	roundtxt(document.forms[0].total_2year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}

function total3year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		
		var value1 =  document.forms[0].txt_3year[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].total_3year.value= totalvalue;
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	roundtxt(document.forms[0].total_3year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function total4year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		
		var value1 =  document.forms[0].txt_4year[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].total_4year.value= totalvalue;
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	roundtxt(document.forms[0].total_4year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function total5year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		
		var value1 =  document.forms[0].txt_5year[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].total_5year.value= totalvalue;
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	roundtxt(document.forms[0].total_5year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function total6year()
{
	var totalvalue=0.00;
	var TotalExpenses =0.00;
	for(var i=0;i<15;i++)
	{
		
		var value1 =  document.forms[0].txt_6year[i].value;
		var value2 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		if(value2=="")
		{
			value2=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
		TotalExpenses = eval(TotalExpenses)+eval(value2);
	}
	document.forms[0].total_6year.value= totalvalue;
	document.forms[0].txt_TotalExpensesValue.value=TotalExpenses;
	roundtxt(document.forms[0].total_6year);
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
/*function totalexpensevalues()
{
	var totalvalue=0.00;
	
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].txt_totalexpenses[i].value;
		
		if(value1=="")
		{
			value1=0.00;
		}
		
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].txt_TotalExpensesValue.value= totalvalue;
}*/
function totalexp1year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_1year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].total_exp1year.value= totalvalue;
	roundtxt(document.forms[0].total_exp1year);
}
function totalexp2year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_2year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].total_exp2year.value= totalvalue;
	roundtxt(document.forms[0].total_exp2year);
}
function totalexp3year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_3year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].total_exp3year.value= totalvalue;
	roundtxt(document.forms[0].total_exp3year);
}
function totalexp4year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_4year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].total_exp4year.value= totalvalue;
	roundtxt(document.forms[0].total_exp4year);
}
function totalexp5year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_5year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	    Math.round.totalvalue;
	}
	document.forms[0].total_exp5year.value= totalvalue;
	roundtxt(document.forms[0].total_exp5year);
}
function totalexp6year()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].exp_6year[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].total_exp6year.value= totalvalue;
	roundtxt(document.forms[0].total_exp6year);
}
function totalexpval()
{
	var totalvalue=0.00;
	for(var i=0;i<12;i++)
	{
		var value1 =  document.forms[0].txt_totalexpenses[i].value;
		if(value1=="")
		{
			value1=0.00;
		}
		totalvalue = eval(value1)+eval(totalvalue)
	}
	document.forms[0].txt_TotalExpensesValue.value= totalvalue;
	roundtxt(document.forms[0].txt_TotalExpensesValue);
}
function doDelete()
	{
	if(varRecordFlag=="Y")
		{
		if(ConfirmMsg(101))
			{
			document.forms[0].hidAction.value ="delete";
			document.forms[0].action=appURL+"action/ControllerServlet";	
			document.forms[0].hidBeanMethod.value="updateDataExp";
			document.forms[0].hidBeanGetMethod.value="getDataExp";
			document.forms[0].hidBeanId.value="eduscholar";
			document.forms[0].hidSourceUrl.value="/action/educourse.jsp";	
			document.forms[0].method="post";			
			document.forms[0].submit();	
			}
		}
	else
		{
		ShowAlert(158);
		}
	}
	
function onloading()
{	
	disableFields(true);
}