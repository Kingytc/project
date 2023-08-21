function showPeriod()
{
	var purl = path+"jsp/share/repdateselect.jsp";
	var title = "ListofPeriod";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	window.open(purl,title,prop);
}
function doRunReport()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var rpout=document.forms[0].hidCatFields.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var orglevel=document.forms[0].sellevel.value;
	
	var pt = document.forms[0].prodttype.options[document.forms[0].prodttype.selectedIndex].value;
	var pc = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	var pr=pt+pc;
	var orgname = document.forms[0].hidOrgName.value;
	var prd=document.forms[0].hidprd.value;
	var len = document.forms[0].prodcat.length;	
	for(i=0;i<len;i++)
	{
		 if(document.forms[0].prodcat.options[i].selected==true)
		 {
			 var hidprodcat_text = document.forms[0].prodcat.options[i].text; 
			break;
		 }
	}
	
	if (document.forms[0].txtDate.value == "")
		{
		ShowAlert('121',"Period");
		document.forms[0].txtDate.focus();
		return false;
		}
	
	if (param !="")
	{
		window.open(path+"action/perunappproduct.jsp?hidBeanId=repappcredit&hidBeanMethod=getData&hidMethod=getProductRepDetails&hidLoanType="+pt+"&hidPrdCode="+pr+"&hidCatFields="+rpout+"&txtDate="+dt+"&hidOrgCode="+code+"&txtSaveDate="+sdt+"&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgName="+orgname+"&hidprodcat_text="+hidprodcat_text+"&hidprd="+prd+"&orglevel="+orglevel,"cred","scrollbars=Yes,toolbars=No,menubar=yes ,width=750 , height=550,top=10,left=10");
	}
		
	
}

function save()
{
	var purl="";
	var title = "SaveReport";
	var prop = "scrollbars=no,width=350,height=320";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	
	var usrid =userid;
	var beanid ="repData";
	var action="Insert";
	var source="/action/perrepappcredit.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function browse()
{
	var user=userid;
	var purl="";
	var title = "BrowseReport";
	var prop = "scrollbars=no,width=400,height=300";	
	var xpos = (screen.width - 400) / 2;
	var ypos = (screen.height - 320) / 2;
	prop = prop + ",left="+xpos+",top="+ypos;
	var repname= document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname+"";
	window.open(purl,title,prop);
}

function doReset()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodcat.selectedIndex =0;
	
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";
	document.forms[0].prodttype.value="0";


}
function doClose()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/apprepnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodcat.selectedIndex =0;
	document.forms[0].prodcat.length =1;
	document.forms[0].prodttype.selectedIndex =0;
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
 document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;

	
}

function selectProd()
{
	if(document.forms[0].prodttype.value=='0')
	{
	alert("Select Loan Type");
	document.forms[0].prodttype.focus();
	return;
	}
	if(document.forms[0].prodcat.value=='0')
	{
	alert("Select Category");
	document.forms[0].prodcat.focus();
	return;
	}
	document.forms[0].rpprod.length=0;
	var count=0;
	var org="";
	var strBankVal="";
	//document.forms[0].rpselect1.selectedIndex =-1;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{

				var c = document.forms[0].rpselect1.options[x].value;
				strBankLevel =c.substring(0,1);
				org = c.substring(2,c.length);
				break;
						
			}
		}
	if (strBankLevel=="C")
	{
		strBankVal = "'"+org+"'";
	}
	else if (strBankLevel=="R")
	{
		strBankVal = "'"+org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="D")
	{
		strBankVal = "'"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="A")
	{
		strBankVal = "'"+org.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="B")
	{
		strBankVal = "'"+org.substring(0,15);
		strBankVal = strBankVal+"','"+org.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+org.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ org.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ org.substring(0,3)+"000000000000'";

	}

	if (document.forms[0].rpselect1.length != 0)
	{
	var pt = document.forms[0].prodttype.options[document.forms[0].prodttype.selectedIndex].value;
	var pc = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	var pr=pt+pc;
	document.all.ifrm.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getAllProductsDesc&hidBeanId=repappper&hidProducts=getAllProductsDesc&&hidLoanType=P&hidOrgCode="+strBankVal+"&prodtype="+pr;
	}
	else
	{
		alert("No Rights to view");
	}
		

}
function onsel()
{
	deSelect();

}
function deSelect()
{
	document.forms[0].rpprod.length=0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected == true)
			{
				document.forms[0].rpselect1.options.selectedIndex=-1;

			}
		}
}
function selLoanType()
{
	if(document.forms[0].prodttype.value=='0')
	{
	alert("Select Loan Type");
	document.forms[0].prodttype.focus();
	return true;
	}
}
