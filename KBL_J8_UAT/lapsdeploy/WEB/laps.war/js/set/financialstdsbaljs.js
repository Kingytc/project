/*
*	JavaScript array for inital label values
*/
var varratios=new Array();
varratios[0]="Current Ratio";
varratios[1]="Debt Equity Ratio";
varratios[2]="Total Outside Liab/Total NW";
varratios[3]="Bank Borrowings/Total OL";
varratios[4]="NWC";
varratios[5]="Inventory Holding Level";
varratios[6]="Receivable Holding Level";
varratios[7]="Payable Holding Level";

/*
*	Function called on load of the form
*/
function callOnload()
{
	for(var i=0;i<document.forms[0].txtfin_label.length;i++)
	{
		document.forms[0].txtfin_label[i].value=varratios[i];
	}
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
		  document.forms[0].elements[i].readOnly=true;
		}
	}

disableControls(false,true,false,false);
}

/*
*	Function called when edit button is pressed
*/
function callEdit()
{
	document.forms[0].hidCheckEdit.value="E";
	callEnable(false);
	disableControls(true,false,false,true);
	document.forms[0].txtfin_rangefrom[0].focus();
}

/*
*	Function called to disable buttons as needed
*/

function disableControls(cmdEdit,cmdApply,cmdHelp,cmdClose)
{
	document.forms[0].cmdEdit.disabled=cmdEdit;
	document.forms[0].cmdApply.disabled=cmdApply;
	document.forms[0].cmdHelp.disabled=cmdHelp;
	document.forms[0].cmdClose.disabled=cmdClose;
}

/*
*	Function called to enable or disable textfield based on parameter true or false
*/
function callEnable(one)
{
	for(var i=0;i<document.forms[0].elements.length;i++)
	{
		if(document.forms[0].elements[i].type=="text")
		{
			if(document.forms[0].elements[i].name.indexOf("txtfin_label")==-1)
			{
			  document.forms[0].elements[i].readOnly=one;
			}
		}
	}
}

/*
*	function called when apply button is pressed
*/
function doSave()
{
	document.forms[0].hidCheckEdit.value="";
	for(var i=0;i<document.forms[0].txtfin_label.length;i++)
	{
	document.forms[0].txtfin_rangefrom[i].value=roundtxt(document.forms[0].txtfin_rangefrom[i]);
	document.forms[0].fin_rangeTo[i].value=roundtxt(document.forms[0].fin_rangeTo[i]);
		if(parseFloat(document.forms[0].txtfin_rangefrom[i].value) > parseFloat(document.forms[0].fin_rangeTo[i].value))
		{
			ShowAlert('115','To value','From value');
			document.forms[0].txtfin_rangefrom[i].focus();
			return false;
		}
	}
	document.forms[0].hidproductId.value=varproductid;
	
	document.forms[0].hidcategory.value=varcategory;
	document.forms[0].hidsubcategory.value=varsubcategory;
	document.forms[0].hidrangefrom.value=rangefrom;
	document.forms[0].hidrangeto.value=rangeto;

	document.forms[0].cmdApply.disabled=true;
	document.forms[0].hidBeanId.value="setfinstd";
	document.forms[0].hidSheet.value="BS";	
	document.forms[0].hidBeanGetMethod.value="updateData";
	
	document.forms[0].action=appurl+"action/financialstdsbal.jsp";
	document.forms[0].submit();	
}

/*
*	Function called when insertstatement tab is pressed
*/
function callInsertStatement()
{
	if(document.forms[0].hidCheckEdit.value!="E")
	{
		document.forms[0].hidproductId.value=varproductid;
		
		document.forms[0].hidcategory.value=varcategory;
		document.forms[0].hidsubcategory.value=varsubcategory;
		document.forms[0].hidrangefrom.value=rangefrom;
		document.forms[0].hidrangeto.value=rangeto;


		document.forms[0].hidSheet.value="IC";
		document.forms[0].action=appurl+"action/financialstdsinc.jsp";
		document.forms[0].submit();	
	}else
	{
		ShowAlert('103');
	}

}

/*
*	Function called when close button is clicked
*/

function callClose()
{
var con=ConfirmMsg('100');
if(con)
	{
	
		//document.forms[0].prdCode.value=varproductid;
		document.forms[0].prd_code.value = document.forms[0].prdCode.value;
		document.forms[0].hidBeanId.value="setinterest";
		document.forms[0].hidBeanGetMethod.value="getData";
		document.forms[0].action=appurl+"action/prodinterest.jsp";
		document.forms[0].submit();
			
	}

}

function loadUsedApp()
{
	if(document.forms[0].checkApp.value=="Yes")
	{
		document.forms[0].cmdEdit.disabled=true;
		document.forms[0].cmdApply.disabled=true;
		document.forms[0].cmdClose.disabled=false;
	}
}