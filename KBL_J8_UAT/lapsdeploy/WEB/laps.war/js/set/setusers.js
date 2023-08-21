function getValue1()
{
	document.forms[0].usr_password.value=document.forms[0].usr_id.value;
	document.forms[0].usr_password1.value=document.forms[0].usr_id.value;
}
function fetchValues()
{
	
	 if(document.forms[0].userslist.selectedIndex==-1)
	 {
		 return;
	 }
	 document.forms[0].hidBeanMethod.value="getData";
	 var strText=document.forms[0].userslist.value.split("^");
	 document.forms[0].usr_id.value=strText[0];
	 document.forms[0].usr_id.disabled=false;
	 document.forms[0].action=strAppUrl+"action/setusers.jsp";
	  document.forms[0].submit();
}

function placeValues()
{
	 document.forms[0].sle_rmd.disabled=true;	 
	document.forms[0].usr_id.value=strId;
	document.all.d1.style.visibility="hidden";
	document.forms[0].usr_class.disabled=true;
	document.forms[0].prd_class_value.disabled=true;
	
	if(strAction=="update")document.forms[0].usr_id.value="";
	if(strAction=="delete")document.forms[0].usr_id.value="";
	if(strAction=="insert")document.forms[0].usr_id.value="";
	
	if(document.forms[0].usr_id.value!="")
 	{
 		document.forms[0].cmdpasswordreset.disabled=false;
 	}
 	else
 	{
 		document.forms[0].cmdpasswordreset.disabled=true;
 	}
	if(strId=="null" || strAction!="")
	{
		document.forms[0].cmdedit.disabled=true;
		document.forms[0].cmdsave.disabled=true;
		document.forms[0].cmdcancel.disabled=true;
		document.forms[0].userslist.disabled=false;
        document.forms[0].cmdcreate.disabled=false;
		document.forms[0].cmdclose.disabled=false;
		 displayGroupRights();
		return;
	}
	
	document.forms[0].usr_orgcode.value=strusrorgcode;
	document.forms[0].usr_fname.value=strusrfname;
	document.forms[0].usr_lname.value=strusrlname;
	document.forms[0].user_designation.value =user_designation;
	 document.forms[0].sle_rmd.value=strRmdFlag;
	 document.forms[0].sel_rlpftype.value=strRLPFType;
	 document.forms[0].hrms_des.value=strHrmsDes;
	 document.forms[0].hrms_jobCode.value=strHrmsjobCode;
	if(strusravail!="")
	{
		document.forms[0].usr_avail.value=strusravail;
	}
	else
	{
		document.forms[0].usr_avail.value="a";
	}
	if(strusrfunction!="")
	{
		document.forms[0].usr_function.value = strusrfunction;
	}
	else
	{
		document.forms[0].usr_function.value = "S";
	}
	document.forms[0].usr_emailid.value = strEmailID;
	document.forms[0].userslist.value=strId+"^"+strusrclass;
	getSupervisor(strusrclass); 	
	document.forms[0].usr_class.value=strusrclass;
	document.forms[0].usr_department.value=strdepartment;	
	for(var i=0;i<document.forms[0].grouplist.length;i++)
	{
		var strText=document.forms[0].grouplist.options[i].value.split("^");
		var strGrpId=strText[0];
		if(strGrpId==strusrgrpid)
		{
			document.forms[0].grouplist.selectedIndex=i;
		}
	}
	 document.forms[0].user_designation.disabled=true;
	 document.forms[0].usr_class.disabled=true;
	 document.forms[0].userslist.disabled=false;
	 document.forms[0].cmdedit.disabled=true;
	 document.forms[0].cmdcreate.disabled=false;
	 document.forms[0].cmdcancel.disabled=true;
	 document.forms[0].cmdsave.disabled=true;
	 document.forms[0].cmdclose.disabled=false;	
	/* document.forms[0].hrms_des.readOnly=true;
	 document.forms[0].hrms_jobCode.readOnly=true;
	 document.forms[0].hrms_des.disabled=true;
	 document.forms[0].hrms_jobCode.disabled=true;*/
	 displayGroupRights();	 
	 document.forms[0].txt_class_desc.readOnly=true;
	 showDescClass(strusrclass);
	 document.forms[0].prd_class_value.style.visibility="hidden";
	 if(document.forms[0].txt_flag.value=="y")
	 {
	 	document.forms[0].cmdedit.disabled=false;
	 }	
	 enableDepartment();
	 
	
 }
function displayGroupRights()
{
	document.all["rights"].style.visibility="visible";
	document.all["rights1"].style.visibility="visible";
	var strText1=document.forms[0].grouplist.value.split("^");
	
	if(strText1!="")
	{
		var strRights=strText1[1];
		if(strRights.charAt(0)=="1")
		{
			document.forms[0].apptext.value="Yes";
		}
		else
		{
			document.forms[0].apptext.value="No";
		}
		if(strRights.charAt(1)=="1")
		{
			document.forms[0].groupstext.value="Yes";
		}
		else
		{
			document.forms[0].groupstext.value="No";
		}		
		if(strRights.charAt(2)=="1")
		{
			document.forms[0].userstext.value="Yes";
		}
		else
		{
			document.forms[0].userstext.value="No";
		}
		if(strRights.charAt(3)=="1")
		{
			document.forms[0].otherstext.value="Yes";
		}
		else
		{
			document.forms[0].otherstext.value="No";
		}
		if(strRights.charAt(4)=="1")
		{
			document.forms[0].prodtext.value="Yes";
		}
		else
		{
			document.forms[0].prodtext.value="No";
		}
		if(strRights.charAt(5)=="1")
		{
			document.forms[0].servicestext.value="Yes";
		}
		else
		{
			document.forms[0].servicestext.value="No";
		}		
		if(strRights.charAt(6)=="1")
		{
			document.forms[0].coltext.value="Yes";
		}
		else 
		{
			document.forms[0].coltext.value="No";
		}
		/*if(strRights.charAt(7)=="1")
		{
			document.forms[0].coctext.value="Yes";
		}
		else
		{
			document.forms[0].coctext.value="No";
		}
		if(strRights.charAt(8)=="1")
		{
			document.forms[0].terapp.value="Yes";
		}
		else
		{
			document.forms[0].terapp.value="No";
		}
		if(strRights.charAt(9)=="1")
		{
			document.forms[0].audOpt.value="Yes";
		}
		else
		{
			document.forms[0].audOpt.value="No";
		}*/
		if(strRights.charAt(10)=="1")
		{
			document.forms[0].ootext.value="Yes";
		}
		else
		{
			document.forms[0].ootext.value="No";
		}
		if(strRights.charAt(11)=="1")
		{
			document.forms[0].pgotext.value="Yes";
		}
		else
		{
			document.forms[0].pgotext.value="No";
		}
		if(strRights.charAt(12)=="1")
		{
			document.forms[0].audText.value="Yes";
		}
		else
		{
			document.forms[0].audText.value="No";
		}
		if(strRights.charAt(13)=="1")
		{
			document.forms[0].others.value="Yes";
		}
		else
		{
			document.forms[0].others.value="No";
		}
		if(strRights.charAt(14)=="1")
		{
			document.forms[0].monitoring.value="Yes";
		}
		else
		{
			document.forms[0].monitoring.value="No";
		}
		if(strRights.charAt(15)=="1")
		{
			document.forms[0].reports.value="Yes";
		}
		else
		{
			document.forms[0].reports.value="No";
		}
		if(strRights.charAt(16)=="1")
		{
			document.forms[0].npa.value="Yes";
		}
		else
		{
			document.forms[0].npa.value="No";
		}
		if(strRights.charAt(17)=="1")
		{
			document.forms[0].workflowinbox.value="Yes";
		}
		else
		{
			document.forms[0].workflowinbox.value="No";
		}
		if(strRights.charAt(19)=="1")
		{
			document.forms[0].agricustext.value="Yes";
		}
		else
		{
			document.forms[0].agricustext.value="No";
		}
		if(strRights.charAt(20)=="1")
		{
			document.forms[0].agriapptext.value="Yes";
		}
		else
		{
			document.forms[0].agriapptext.value="No";
		}
		if(strRights.charAt(21)=="1")
		{
			document.forms[0].agriappsltext.value="Yes";
		}
		else
		{
			document.forms[0].agriappsltext.value="No";
		}
	}
}

function doSave()
{
	var strText1=document.forms[0].grouplist.value.split("^");
	document.forms[0].usr_grpid.value=strText1[0];
	document.forms[0].usr_fname.value=trim(document.forms[0].usr_fname.value);
	document.forms[0].usr_lname.value=trim(document.forms[0].usr_lname.value);
	document.forms[0].usr_password.value=trim(document.forms[0].usr_password.value);
	document.forms[0].usr_password1.value=trim(document.forms[0].usr_password1.value);
	document.forms[0].usr_id.value=trim(document.forms[0].usr_id.value);
	document.forms[0].usr_class.value=trim(document.forms[0].usr_class.value);
	document.forms[0].usr_emailid.value=trim(document.forms[0].usr_emailid.value);
	
	if(document.forms[0].hidAction.value=="update" && document.forms[0].usr_orgcode.value != strusrorgcode)
	{
	   if(varMailBoxStatus == "Y")
	   {
	     alert("User has some pending application, so you can not change the organisation");
	     return
	   }		
	}	
	if(document.forms[0].usr_id.value=="" && document.forms[0].hidAction.value=="insert")
	{
	 	ShowAlert(112,"Login name");
		document.forms[0].usr_id.focus();
		return;
	}	
	if(document.forms[0].usr_fname.value=="")
	{
	 	ShowAlert(112,"First name");
		document.forms[0].usr_fname.focus();
		return;
	}
	if(document.forms[0].user_designation.value=="")
	{
	 	ShowAlert(112,"Designation");
		document.forms[0].user_designation.focus();
		return;
	}
	
	if(document.forms[0].usr_orgcode.selectedIndex==0)
	{
	 	ShowAlert(111,"Location");
		document.forms[0].usr_orgcode.focus();
		return;
	}
	if(document.forms[0].grouplist.selectedIndex==0)
	{
	 	ShowAlert(111,"Group");
		document.forms[0].grouplist.focus();
		return;
	}
	if((document.forms[0].usr_function.selectedIndex=='S')||(document.forms[0].usr_function.selectedIndex=='0'))
	{
	 	ShowAlert(111,"Function");
		document.forms[0].usr_function.focus();
		return;
	}
	if(document.forms[0].usr_class.value=="" || eval(document.forms[0].usr_class.value)==0)
	{
		ShowAlert(106,"Class");
		document.forms[0].usr_class.focus();
		document.forms[0].usr_class.value="";
		return;
	}
	if(document.forms[0].usr_password.value=="" && document.forms[0].hidAction.value=="insert")
	{
	 	ShowAlert(112,"Password");
		document.forms[0].usr_password.focus();
		return;
	}
	if(document.forms[0].usr_password1.value=="" && document.forms[0].hidAction.value=="insert")
	{
	 	ShowAlert(112,"Confirm Password");
		document.forms[0].usr_password1.focus();
		return;
	}
	if(document.forms[0].sle_rmd.value=="")
	{
		alert("Select Whether RMD");
		document.forms[0].sle_rmd.focus();
		return false;		
		
	}
	if(document.forms[0].hidAction.value=="insert" && document.forms[0].usr_password.value!=document.forms[0].usr_password1.value)
	{
	 	ShowAlert(114);
		document.forms[0].usr_password.value="";
		document.forms[0].usr_password1.value="";
		document.forms[0].usr_password.focus();
		return;
	}
	if(document.forms[0].hidAction.value=="insert")
	{
		for(var k=0;k<document.forms[0].userslist.length;k++)
		{
		 	var strTxt1=document.forms[0].userslist.options[k].value.split("^");
            if(strTxt1[0].toUpperCase()==document.forms[0].usr_id.value.toUpperCase())
			{
				ShowAlert(113,"login");
				document.forms[0].usr_id.value="";
				document.forms[0].usr_id.focus();
				return;
			}
		}
	}
	
	if(document.forms[0].usr_orgcode.value.length==15 && (((document.forms[0].usr_orgcode.value).substr((document.forms[0].usr_orgcode.value).length-6))=="000000") && (((document.forms[0].usr_orgcode.value).substr((document.forms[0].usr_orgcode.value).length-9))!="000000000") && document.forms[0].sel_rlpftype.value=="")
	{
		ShowAlert(111,"Whether CLPU/CLPH User?");
		document.forms[0].sel_rlpftype.value="";
		document.forms[0].sel_rlpftype.focus();
		return;
	}
	var lencode = document.forms[0].usr_orgcode.length;	
	for(i=0;i<lencode;i++)
	{
		 if(document.forms[0].usr_orgcode.options[i].selected==true)
		 {
			 document.forms[0].hid_location.value = document.forms[0].usr_orgcode.options[i].text; 
			break;
		 }
	}	
	var lengrp = document.forms[0].grouplist.length;	
	for(i=0;i<lengrp;i++)
	{
		 if(document.forms[0].grouplist.options[i].selected==true)
		 {
			 document.forms[0].hid_grouplist.value = document.forms[0].grouplist.options[i].text; 
			break;
		 }
	}	
	document.forms[0].usr_id.disabled=false;
	document.forms[0].cmdsave.disabled=true;
	document.forms[0].hidRecordflag.value=varRecordFlag;
	document.forms[0].hidBeanId.value="setusers";
	document.forms[0].hidBeanMethod.value="updateData";
	document.forms[0].hidBeanGetMethod.value="getData";
	document.forms[0].hidSourceUrl.value="/action/setusers.jsp";
	document.forms[0].action=strAppUrl+"controllerservlet";
	document.forms[0].submit();
}
function doCancel()
{	
	if(ConfirmMsg(102))
	{		
		document.forms[0].action=appURL+"action/setusers.jsp";	
		document.forms[0].submit();	
	}
	
}
function doDelete()
{
	if(varRecordFlag=="Y")
	{
		if(ConfirmMsg(101))
		{
		 	document.forms[0].usr_id.disabled=false;
			document.forms[0].cmdsave.disabled=true;
			document.forms[0].cmddelete.disabled=true;
			document.forms[0].hidAction.value="delete";
			document.forms[0].hidBeanId.value="setusers";
			document.forms[0].hidBeanMethod.value="updateData";
			document.forms[0].hidBeanGetMethod.value="getData";
			document.forms[0].hidSourceUrl.value="/action/setusers.jsp";
			document.forms[0].action=strAppUrl+"controllerservlet";
			document.forms[0].submit();
		}
	}
	else
	{		
		ShowAlert(158);
	}
}
function doCreate()
{
	document.forms[0].reset();
	document.forms[0].cmdpasswordreset.disabled=true;
	document.forms[0].userslist.disabled=true;
	document.forms[0].usr_id.disabled=false;
	document.forms[0].usr_fname.disabled=false;
	document.forms[0].usr_lname.disabled=false;
	document.forms[0].usr_orgcode.disabled=false;
	document.forms[0].grouplist.disabled=false;
	document.forms[0].usr_class.disabled=false;
	document.forms[0].usr_avail.disabled=false;
	document.forms[0].usr_function.disabled=false;
	document.forms[0].user_designation.disabled=false;
	document.forms[0].usr_emailid.disabled=false;
	document.forms[0].cmdcreate.disabled=true;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdclose.disabled=true;
	document.all["rights"].style.visibility="hidden";
	document.all["rights1"].style.visibility="hidden";
	document.all["passwd"].style.visibility="visible";
	document.forms[0].usr_id.focus();
	document.forms[0].hidAction.value="insert";
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].usr_department.disabled=false;
	document.forms[0].sel_rlpftype.disabled=false;
	document.forms[0].sle_rmd.disabled=false;
	document.forms[0].hrms_jobCode.disabled=false;
	document.forms[0].hrms_des.disabled=false;
}
function doEdit()
{
 	document.forms[0].usr_fname.disabled=false;
	document.forms[0].usr_lname.disabled=false;
	document.forms[0].usr_orgcode.disabled=false;
	document.forms[0].grouplist.disabled=false;
	document.forms[0].usr_class.disabled=false;
	document.forms[0].usr_avail.disabled=false;
	document.forms[0].usr_function.disabled=false;
	document.forms[0].user_designation.disabled=false;
	document.forms[0].usr_emailid.disabled=false;
	document.forms[0].cmdedit.disabled=true;
	document.forms[0].cmdsave.disabled=false;
	document.forms[0].cmdcancel.disabled=false;
	document.forms[0].cmdclose.disabled=true;
	document.forms[0].cmdcreate.disabled=true;
	document.forms[0].userslist.disabled=true;
	document.forms[0].usr_department.disabled=false;
	document.forms[0].sel_rlpftype.disabled=false;
	document.forms[0].hidAction.value="update";
	document.forms[0].sle_rmd.disabled=false;
	document.forms[0].hrms_jobCode.disabled=false;
	document.forms[0].hrms_des.disabled=false;
}
function populateSupervisor()
{
	var strclassid=document.forms[0].usr_class.value;
	if(isNaN(strclassid))
		return;
	getSupervisor(strclassid);
}
function getSupervisor(classid)
{	
	for(var i=0;i<document.forms[0].userslist.length;i++)
	{
	 	var strText1=document.forms[0].userslist.options[i].value.split("^");
		var strText3=document.forms[0].userslist.options[i].text;
		var strText2=strText1[0];
		var strclassid1=strText1[1];		
	}
}
function doClose()
{
	if(ConfirmMsg(100))
	{
		document.forms[0].action=strAppUrl+"action/setupnav.jsp";
		document.forms[0].submit();
	}
}
function callSearch()
{
	if(document.forms[0].cmdcreate.disabled == false){
	var varQryString = strAppUrl+"action/setUserSearch.jsp";
	var title = "Users";
	var prop = "scrollbars=yes,width=650,height=400,menubar=no";	
	var xpos = (screen.width - 350) / 2;
	var ypos = (screen.height - 120) / 2;
	prop = prop + ",left=50,top=50";
	window.open(varQryString,title,prop);
	}
}
function enableDepartment(){
	if(document.forms[0].usr_orgcode.value=="001000000000000"){
		
		document.all.deprt1.style.visibility="visible";
		document.all.deprt1.style.position="relative";
		document.all.deprt2.style.visibility="visible";
		document.all.deprt2.style.position="relative";
	}else{
		document.all.deprt1.style.visibility="hidden";
		document.all.deprt1.style.position="absolute";
		document.all.deprt2.style.visibility="hidden";
		document.all.deprt2.style.position="absolute";
		document.forms[0].usr_department.value="";
	}
	
	if(document.forms[0].usr_orgcode.value.length==15 && (((document.forms[0].usr_orgcode.value).substr((document.forms[0].usr_orgcode.value).length-6))=="000000") && (((document.forms[0].usr_orgcode.value).substr((document.forms[0].usr_orgcode.value).length-9))!="000000000"))
	{
		document.all.clpu1.style.visibility="visible";
		document.all.clpu1.style.position="relative";
		document.all.clpu2.style.visibility="visible";
		document.all.clpu2.style.position="relative";
	}
	else
	{
		document.all.clpu1.style.visibility="hidden";
		document.all.clpu1.style.position="absolute";
		document.all.clpu2.style.visibility="hidden";
		document.all.clpu2.style.position="absolute";
		document.forms[0].sel_rlpftype.value="";
	}
}