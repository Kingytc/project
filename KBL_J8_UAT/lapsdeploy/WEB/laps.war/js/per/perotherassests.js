function doEdit()
{	
	document.forms[0].hideditflag.value = "Y";
	disableFields(false);
	disableCommandButtons(true,false,false,false,true);
	//document.forms[0].hidBeanId.value="perpropertydetails";
	//document.forms[0].hidBeanMethod.value = "getOtherAssetData";
	//document.forms[0].action = appURL+"action/otherassets.jsp?hidBeanGetMethod=getOtherAssetData";
	//document.forms[0].method="post";
	//document.forms[0].submit();
}

function doSave()
{	
	document.forms[0].hidRecordflag.value=varRecordFlag;	
	var i=0;
	if(trimtxt(document.forms[0].txtAssetDetail[i].value)=="")
	{
		ShowAlert('121','Details of Asset/Equipment');
		document.forms[0].txtAssetDetail[i].focus();
		return;
				
	}
		
		for(;i<10;++i)
		{
			if(trimtxt(document.forms[0].txtAssetDetail[i].value)!="")
			{
				if(trimtxt(document.forms[0].txtNeed[i].value)=="")
					{
					ShowAlert('121','Equipment needed for');
					document.forms[0].txtNeed[i].focus();
					return;
					}
				if(trimtxt(document.forms[0].txtSupplier[i].value)=="")
					{
					ShowAlert('121',' Supplier Value');
					document.forms[0].txtSupplier[i].focus();
					return;
					}	
				if(trimtxt(document.forms[0].txtPurchasePrice[i].value)=="")
					{
					ShowAlert('121',' Purchase Price');
					document.forms[0].txtPurchasePrice[i].focus();
					return;
					}
				if(trimtxt(document.forms[0].txt_invoiceDate[i].value)=="")
					{
					ShowAlert('121',' Date of Invoice / Quotation');
					document.forms[0].txt_invoiceDate[i].focus();
					return;
					}
			}
			else
			{
				if(trimtxt(document.forms[0].txtNeed[i].value)!="")
					{
					ShowAlert('121',' Details of Asset/Equipment');
					document.forms[0].txtAssetDetail[i].focus();
					return;
					}
				if(trimtxt(document.forms[0].txtSupplier[i].value)!="")
					{
					ShowAlert('121','Details of Asset/Equipment');
					document.forms[0].txtSupplier[i].focus();
					return;
					}		
				if(trimtxt(document.forms[0].txtPurchasePrice[i].value)!="")
					{
					ShowAlert('121','Details of Asset/Equipment');
					document.forms[0].txtAssetDetail[i].focus();
					return;
					}
				if(trimtxt(document.forms[0].txt_invoiceDate[i].value)!="")
					{
					ShowAlert('121','Date of Invoice / Quotation');
					document.forms[0].txtAssetDetail[i].focus();
					return;
					}
				
			}
		}
		
	document.forms[0].action=appURL+"controllerservlet";
	document.forms[0].hidAction.value="insert";
	document.forms[0].hidBeanId.value="perpropertydetails";
	document.forms[0].hidBeanMethod.value="updateOtherAssetData";
	document.forms[0].hidBeanGetMethod.value="getOtherAssetData";	
	document.forms[0].hidSourceUrl.value="/action/otherassets.jsp";
	document.forms[0].submit();
	
}

function doCancel()
{
	if(ConfirmMsg('102'))
	{	      			
		 document.forms[0].action=appURL+"action/otherassets.jsp"
		 document.forms[0].hidBeanId.value="perpropertydetails";
	  	 document.forms[0].hidBeanGetMethod.value="getOtherAssetData";
		// document.forms[0].hidSourceUrl.value="/;
		 document.forms[0].submit();
	}
}

function doClose()
{	
	var con=ConfirmMsg('100');
	if(con)
	{		
		document.forms[0].action=appURL+"action/persearch.jsp";
		document.forms[0].submit();		
	}
}

function doDelete()
	{
	if(varRecordFlag=="Y")
		{
		if(ConfirmMsg(101))
			{
			document.forms[0].action=appURL+"controllerservlet";
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="perpropertydetails";
			document.forms[0].hidBeanMethod.value="updateOtherAssetData";
			document.forms[0].hidBeanGetMethod.value="getOtherAssetData";	
			document.forms[0].hidSourceUrl.value="/action/otherassets.jsp";
			document.forms[0].submit();
			}
		}
	else
		{
		ShowAlert(158);
		}
	}