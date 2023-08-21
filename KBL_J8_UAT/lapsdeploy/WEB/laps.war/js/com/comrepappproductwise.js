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
	var prdcode =document.forms[0].hidProducts.value;
	var dt =document.forms[0].txtDate.value;
	var sdt =document.forms[0].txtSaveDate.value;
 
	if (document.forms[0].txtDate.value == "")
	{
		dt="All";
	}
	if (param !="")
	{
		window.open(path+"action/comrunappproductwise.jsp?hidBeanId=repappproductwise&hidBeanMethod=getData&hidMethod=getRepDetails&hidLoanType=C&hidProducts="+prdcode+"&txtDate="+dt+"&hidOrgCode="+code+"&hidOpFields="+outf+"&txtSaveDate="+sdt+"&hidSelFields="+dbf,"stat","scrollbars=Yes,toolbars=No,menubar=no,width=750,height=550,top=10,left=10");
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
	var source="/action/comrepappproductwise.jsp";
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
	var org="";
	var prdcode="";
	var prdval="";
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].prodopt.selectedIndex != 0 
			&&	document.forms[0].rpselect1.selectedIndex != -1 &&
		document.forms[0].selappno.selectedIndex != -1 ) 
	{
	
   var dt =document.forms[0].txtDate.value;
	if (document.forms[0].txtDate.value == "")
	{
		dt="All";
	}
  	 
		document.forms[0].txtDate.value =dt;
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
	for(x=0;x<document.forms[0].selappno.length;x++)
	{
		if (document.forms[0].selappno[x].selected)
		{
			count++;
			var c = document.forms[0].selappno.options[x].value;
			var c1= document.forms[0].selappno.options[x].text;
			prdcode =prdcode + c+",";
			prdval =prdval +c1+",";
					
		}
	}
	if (count > 0)
	{
		prdcode= prdcode.substring(0,prdcode.length-1);
		prdval= prdval.substring(0,prdval.length-1);
	}
				
		
   
    param =orgcode+";"+org+";"+prdcode+";"+dt+";";
	
	count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
						document.forms[0].rpselect2[x].selected=true;
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
	param +=dbfields+";C;"+prdval;

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidProducts.value =prdcode;
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	

	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].prodopt.selectedIndex == 0)
	{
		ShowAlert('111',"Loan Type");
		document.forms[0].prodopt.focus();
		return false;
	}
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111',"Organisation");
		document.forms[0].rpselect1.focus();
		return false;
	}
	else if(document.forms[0].selappno.selectedIndex == -1)
	{
		ShowAlert('111','Product');
		document.forms[0].selappno.focus();
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
	document.forms[0].selappno.length =0;
	document.forms[0].rpselect1.length =0;
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
	document.forms[0].rpselect1.selectedIndex =-1;
	document.forms[0].prodopt.selectedIndex =0;
	document.forms[0].selappno.length=0;

	//var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
    //bnkname = bnkname.substring(0,1); 
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
function selectProduct()
{
	if(document.forms[0].prodopt.selectedIndex == 0)
	{
		ShowAlert('111',"Loan Type");
		document.forms[0].prodopt.focus();
		return false;
	}
	else
	{
	var count =0;
	var org="";
	var strBankVal="";
	var strBankLevel="";
	var strBankCode="";
	document.forms[0].selappno.length=0;
	for(x=0;x<document.forms[0].rpselect1.length;x++)
	{
		if (document.forms[0].rpselect1[x].selected)
		{
			var c = document.forms[0].rpselect1.options[x].value;
			var c =document.forms[0].rpselect1.options[x].value;
			strBankLevel =c.substring(0,1);
			strBankCode = c.substring(2,c.length);
			break;
					
		}
	}
	
	if (strBankLevel=="C")
	{
		strBankVal = "'"+strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="R")
	{
		strBankVal = "'"+strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="D")
	{
		strBankVal = "'"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";
	}
	else if (strBankLevel=="A")
	{
		strBankVal = "'"+strBankCode.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";

	}
	else if (strBankLevel=="B")
	{
		strBankVal = "'"+strBankCode.substring(0,15);
		strBankVal = strBankVal+"','"+strBankCode.substring(0,12)+"000";
		strBankVal = strBankVal+"','"+strBankCode.substring(0,9)+"000000";
		strBankVal = strBankVal+"','"+ strBankCode.substring(0,6)+"000000000";
		strBankVal = strBankVal +"','"+ strBankCode.substring(0,3)+"000000000000'";

	}
 
	var prdtyp = document.forms[0].prodopt.options[document.forms[0].prodopt.selectedIndex].value;	
	document.all.ifrm.src=path+"action/iframeprimrep.jsp?hidBeanMethod=getData&hidMethod=getOrgProducts&hidBeanId=repappproductwise&hidPrdType="+prdtyp+"&hidOrgCode="+strBankVal;
	}
	
}
function setData()
{
	document.forms[0].selappno.length=0;		
	document.forms[0].rpselect1.selectedIndex =-1;
}
