function callCalender(fname)
 {
	 showCal(path,fname);
 }

function loadData()
{
	
	document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]=new Option('Comm/Term Loan',"CT");
		document.forms[0].prodopt.options[document.forms[0].prodopt.options.length]= new Option('Comm/Working Capital',"CW");
	
}
function selectPrdType()
{
	document.forms[0].prodcat.options[0].selected = true;
	document.forms[0].prodcat.length = 0;
    if (document.forms[0].prodopt.selectedIndex == 0)
    {
		document.forms[0].prodcat.length =1;
		document.forms[0].prodcat.selectedIndex =0;
    }
	else
	{
	var prodid = document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
    prodid =trim(prodid);
	document.all.ifrm.src=path+"action/iframeprodrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=prodavail&hidProducts=prod&prodtype="+prodid;
	}
}
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

function runrep()
{
	var param = setParam();
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var code =document.forms[0].hidOrgCode.value;
	var rpout=document.forms[0].hidCatFields.value;
	var dt=document.forms[0].txtDate.value;
	var sdt=document.forms[0].txtSaveDate.value;
	var pt=document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;

	if (param !="")
	{
		window.open(path+"action/comrunappcredit.jsp?hidBeanId=repappcredit&hidBeanMethod=getData&hidMethod=getRepDetails&hidLoanType=C&hidPrdCode="+pt+"&hidCatFields="+rpout+"&txtDate="+dt+"&hidOrgCode="+code+"&txtSaveDate="+sdt+"&hidOpFields="+outf+"&hidSelFields="+dbf,"cred","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	var source="/action/comrepappcredit.jsp";
	var repname=document.forms[0].repname.value;
	
	var param = setParam();
	if (param !="")
	{
		purl =path+"action/savereport.jsp?BeanId="+beanid+"&Action="+action;
		purl +="&Source="+source+"&repname="+repname+"&param="+param;
		window.open(purl,title,prop);
	}
}

function setParam()
{
	var opfields="";
	var dbfields="";
	var orgcode="";
	var orgname="";
	var count=0;
	var prd="";
	var org="";
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].prodopt.selectedIndex != 0  
		&& document.forms[0].prodcat.selectedIndex != 0  
		&& document.forms[0].product.selectedIndex != 0
		&&	document.forms[0].rpselect1.selectedIndex != -1 
		&&	document.forms[0].rpprod.selectedIndex != -1 ) 
	{
	if (document.forms[0].txtDate.value == "")
	{
		document.forms[0].txtDate.value="All";
	}
   var dt =document.forms[0].txtDate.value;
	var cat =document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
	var pt =document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
		
	orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
    count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + c+",";
						
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
		}
		
		count =0;
		var subcat="";
		for(x=0;x<document.forms[0].rpprod.length;x++)
		{
			if (document.forms[0].rpprod[x].selected)
			{
				count++;
				prd =prd +document.forms[0].rpprod.options[x].text+",";
				subcat =subcat +document.forms[0].rpprod.options[x].value+",";
			}										
			
		}
		if (count > 0)
		{
			prd= prd.substring(0,prd.length-1);
			subcat= subcat.substring(0,subcat.length-1);
		}				
		
   
    param =orgcode+";"+org+";"+subcat+";"+dt+";C;"+pt+";";

		count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			
				count++;
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
							
			
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidCatFields.value =subcat;	
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].prodopt.selectedIndex == 0)
	{
		ShowAlert('111',"Product type");
		document.forms[0].prodopt.focus();
		return false;
	}
	else if(document.forms[0].prodcat.selectedIndex == 0)
	{
		ShowAlert('111',"Category");
		document.forms[0].prodcat.focus();
		return false;
	}
	else if(document.forms[0].product.selectedIndex == 0)
	{
		ShowAlert('111',"Sub Category");
		document.forms[0].product.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].rpprod.selectedIndex == -1)
	{
		ShowAlert('111','Product');
		document.forms[0].rpprod.focus();
		return false;
	}
	
	return param;
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

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodcat.selectedIndex =0;
	document.forms[0].prodopt.selectedIndex =0;
	document.forms[0].product.selectedIndex =0;
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";


}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/comrepappnav.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.length =0;
	document.forms[0].prodopt.selectedIndex =0;
	document.forms[0].prodcat.selectedIndex =0;
	document.forms[0].product.selectedIndex =0;
	document.forms[0].rpprod.length =0;
	document.forms[0].txtDate.value="";
	bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   // bnkname = bnkname.substring(0,1);
		bnkname =document.forms[0].sellevel.selectedIndex
	if(bnkname=="1")
	{
		bnkname="C";
	}
	else if(bnkname=="2")
	{
		bnkname="R";
	}
	else if(bnkname=="3")
	{	
		bnkname="D";
	}
	else if(bnkname=="4")
	{
		bnkname="A";
	}
	else if(bnkname=="5")
	{
		bnkname="B";
	}
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
	
}


function selectSubCat()
{	
	
	deSelect();
		document.forms[0].product.options[0].selected = true;
		if (document.forms[0].rpselect1.length != 0)
		{
			var pr = document.forms[0].prodcat.options[document.forms[0].prodcat.selectedIndex].value;
//	alert(pr);
			document.all.ifrmp.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=subprod&prodtype="+pr;
			
		}
		else
		{
			document.forms[0].prodcat.selectedIndex =0;
			alert("No Rights to view");
		}
	

}
function selectProd()
{
	document.forms[0].rpprod.length=0;
	var strBankLevel = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	var strBankVal="";
	var count=0;
	var org="";
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
//	alert("o1rg="+org);

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
// alert("strBankVal----"+strBankVal);
	if (document.forms[0].rpselect1.length != 0)
	{
	var pr = document.forms[0].product.options[document.forms[0].product.selectedIndex].value;
	var pt = document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;
//alert(path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=allprod&prodtype="+pt+"&hidLoanType=C&hidOrgCode="+strBankVal+"&prodid="+pr);
//	document.all.ifrm.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getProducts&hidBeanId=repappper&hidProducts=allprod&prodtype="+pt+"&hidLoanType=C&hidOrgCode="+strBankVal+"&prodid="+pr;
	document.all.ifrm.src=path+"action/iframecreditrep.jsp?hidBeanMethod=getData&hidMethod=getAllUsableProducts&hidBeanId=repappper&hidProducts=allprod&prodtype="+pt+"&hidLoanType=C&hidOrgCode="+strBankVal+"&prodid="+pr;
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
