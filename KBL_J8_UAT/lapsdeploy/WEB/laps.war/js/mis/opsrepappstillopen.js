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
	var code =document.forms[0].hidOrgCode.value;
	var outf =document.forms[0].hidOpFields.value;
	var dbf =document.forms[0].hidSelFields.value;	 
	var stat =document.forms[0].hidStatus.value;
	var dt = document.forms[0].txtDate.value;
	var sdt = document.forms[0].txtSaveDate.value;
	var  orglevel= document.forms[0].sellevel.value;
	var  loantype="";
	var  fromamt = document.forms[0].txtfromamt.value;
	var  toamt = document.forms[0].txttoamt.value;
	var orgname = document.forms[0].hidOrgName.value;
	
	if (document.forms[0].txtDate.value == "")
		{
			ShowAlert('121','Period');
			document.forms[0].txtDate.focus();
			return false;
		}
	
	
	if (param !="")
	{

		window.open(path+"action/opsrunappstillopen.jsp?hidBeanId=opsreport&hidBeanMethod=getData&hidMethod=getOpsTurnaroundRepDetails&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgCode="+code+"&hidLoanType="+loantype+"&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt+"&orglevel="+orglevel+"&fromamt="+fromamt+"&toamt="+toamt+"&hidOrgName="+orgname,"still","scrollbars=Yes,toolbars=No,menubar=YES ,width=750 , height=550,top=10,left=10");
		//window.open(path+"action/perrunappstillopen.jsp?hidBeanId=repappstillopen&hidBeanMethod=getData&hidMethod=getRepDetails&hidOpFields="+outf+"&hidSelFields="+dbf+"&hidOrgCode="+code+"&hidLoanType=C&hidStatus="+stat+"&txtDate="+dt+"&txtSaveDate="+sdt,"still","scrollbars=Yes,toolbars=No,menubar=no ,width=750 , height=550,top=10,left=10");
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
	var source="/action/perrepappstillopen.jsp";
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
	var org_name="";
	param="";
	
	if(document.forms[0].sellevel.selectedIndex != 0 
		&& document.forms[0].cmbstatus.selectedIndex != 0
		&&	document.forms[0].rpselect1.selectedIndex != -1 ) 
	{
  		var dt =document.forms[0].txtDate.value;	
		//if (document.forms[0].txtDate.value == "")
	//	{
		//	document.forms[0].txtDate.value="All";
	//	}
 
		var stat =document.forms[0].cmbstatus.options[document.forms[0].cmbstatus.selectedIndex].value;
		
		for (i=0;i<document.forms[0].rpselect2.length;i++)
       	{
			if (document.forms[0].rpselect2.options[i].selected == true)
			{
				count++;
			}
        }
		if(count == 0)
		{
			for(i=0;i<10;i++)
			{
				document.forms[0].rpselect2.options[i].selected = true;
			}
		}
		orgcode =document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].text;
   
  		count =0;
		for(x=0;x<document.forms[0].rpselect1.length;x++)
		{
			if (document.forms[0].rpselect1[x].selected)
			{
				count++;
				var c = document.forms[0].rpselect1.options[x].value;
				c = c.substring(2,c.length);
				org =org + "'"+c+"'"+",";
				c = document.forms[0].rpselect1.options[x].text;
				org_name =org_name + "," + c ;		
			}
		}
		if (count > 0)
		{
			org= org.substring(0,org.length-1);
			org_name= org_name.substring(1,org_name.length);
		}
				
		
   
    param =orgcode+";"+org+";"+stat+";"+dt+";";
	
		 count =0;
		for(x=0;x<document.forms[0].rpselect2.length;x++)
		{
			if (document.forms[0].rpselect2[x].selected)
			{
				count++;
				if(document.forms[0].rpselect2.options[x].text=='Date')
				{
					if(document.forms[0].cmbstatus.value=='A')
					{
					dbfields =dbfields + "Approved Date,";
					}
					else if(document.forms[0].cmbstatus.value=='R')
					{
					dbfields =dbfields + "Rejected Date,";
					}
					else if(document.forms[0].cmbstatus.value=='P')
					{
					dbfields =dbfields;
					}
				}
				else if(document.forms[0].rpselect2.options[x].text=='Actual Time taken(Days)')
				{
					if(document.forms[0].cmbstatus.value=='P')
					{
					dbfields =dbfields + "No of Days Pending,";
					}
					else
					{
					dbfields =dbfields + "Actual Time taken(Days),";
					}
				}
				else if(document.forms[0].rpselect2.options[x].text=='Branch')
				{
				    if(document.forms[0].sellevel.value!='A')
					{
					dbfields =dbfields + "Branch,";
					}
					else if(document.forms[0].sellevel.value=='A')
					{
					dbfields =dbfields;
					}
				}
				else if(document.forms[0].rpselect2.options[x].text=='Application with')
				{
					if(document.forms[0].cmbstatus.value=='A')
					{
					dbfields =dbfields + "Application Approved By,";
					}
					else if(document.forms[0].cmbstatus.value=='R')
					{
					dbfields =dbfields + "Application Rejected By,";
					}
					else if(document.forms[0].cmbstatus.value=='P')
					{
					dbfields =dbfields + "Application Pending with,";
					}
				}
				else
				{
				dbfields =dbfields +document.forms[0].rpselect2.options[x].text+",";
				}
				opfields =opfields +document.forms[0].rpselect2.options[x].value+",";
				
							
			}
		}
		if (count > 0)
		{
			dbfields= dbfields.substring(0,dbfields.length-1);
			opfields= opfields.substring(0,opfields.length-1);
		}
	
	param +=opfields+";";
	param +=dbfields+";P";

	document.forms[0].hidParam.value=param;
	document.forms[0].hidOrgCode.value =org;	
	document.forms[0].hidOpFields.value =opfields;	
	document.forms[0].hidSelFields.value =dbfields;	
	document.forms[0].hidStatus.value =stat;
	document.forms[0].hidOrgName.value =org_name;		
	}
	else if(document.forms[0].sellevel.selectedIndex == 0)
	{
		ShowAlert('111',"Organisation Level");
		document.forms[0].sellevel.focus();
		return false;
	}
	else if(document.forms[0].cmbstatus.selectedIndex == 0)
	{
		ShowAlert('111',"Process Status");
		document.forms[0].cmbstatus.focus();
		return false;
	}
	
	else if(document.forms[0].rpselect1.selectedIndex == -1)
	{
		ShowAlert('111','Organisation');
		document.forms[0].rpselect1.focus();
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
	var repname=document.forms[0].repname.value;
	purl =path+"action/browsereport.jsp?BeanId= repData&userid="+user+"&method=getProfileNames&repname="+repname;
	window.open(purl,title,prop);
}

function resetValues()
{
	document.forms[0].sellevel.options[0].selected =true;
	document.forms[0].rpselect1.length =0;
}
function closeWindow()
{
	if (ConfirmMsg("100"))
	{
		document.forms[0].reset();
	document.forms[0].hidBeanId.disabled=true;
	document.forms[0].action=path+"action/tertiary_report.jsp";
	document.forms[0].submit();
	}
}


function selectValues()
{
	document.forms[0].rpselect1.selectedIndex =-1;
	var bnkname = document.forms[0].sellevel.options[document.forms[0].sellevel.selectedIndex].value;
	document.all.ifrm.src=path+"action/iframeapprep.jsp?hidBeanMethod=getData&hidMethod=getOrgnames&hidBeanId=repappper&bnklevel="+bnkname;
}

