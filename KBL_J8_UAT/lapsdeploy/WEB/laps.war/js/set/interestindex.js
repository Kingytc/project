	function setButtons()
	{
		loadValues();
		disableAll();
		document.frm1.cmdedit.disabled = false;
		document.frm1.cmdapply.disabled = true;
		document.frm1.cmdcancel.disabled = true;
		document.frm1.cmdclose.disabled = false;
	}
	

	function setFocus()
	{
		document.frm1.mdrlabel1.focus();
	}

	function onEditMode()
	{
		disableFields();
		document.frm1.moddate.disabled=true
		setFocus();
		document.frm1.cmdedit.disabled = true;
		document.frm1.cmdapply.disabled = false;
		document.frm1.cmdcancel.disabled = false;
		document.frm1.cmdclose.disabled = true;
		getValues();
	}

	function getValues()
	{
		mdrlabel1 = document.frm1.mdrlabel1.value;
		mdrlabel2 = document.frm1.mdrlabel2.value;
		mdrlabel3 = document.frm1.mdrlabel3.value;
		mdrrate1 = document.frm1.mdrrate1.value;
		mdrrate2 = document.frm1.mdrrate2.value;
		mdrrate3 = document.frm1.mdrrate3.value;
		type1label = document.frm1.type1label.value;
		type2label = document.frm1.type2label.value;
		type3label = document.frm1.type3label.value;
		typerate1 = document.frm1.typerate1.value;
		typerate2 = document.frm1.typerate2.value;
		typerate3 = document.frm1.typerate3.value;
		wclabel1 = document.frm1.wclabel1.value;
		wclabel2 = document.frm1.wclabel2.value;
		wclabel3 = document.frm1.wclabel3.value;
		wcrate1 = document.frm1.wcrate1.value;
		wcrate2 = document.frm1.wcrate2.value;
		wcrate3 = document.frm1.wcrate3.value;
		wclabel4 = document.frm1.wclabel4.value;
		wclabel5 = document.frm1.wclabel5.value;
		wclabel6 = document.frm1.wclabel6.value;
		wcrate4 = document.frm1.wcrate4.value;
		wcrate5 = document.frm1.wcrate5.value;
		wcrate6 = document.frm1.wcrate6.value;
	}

	function disableFields()
	{
		for(i=0;i<document.frm1.elements.length;i++)
		{
			if(document.frm1.elements[i].type == "text")
				document.frm1.elements[i].readOnly=false;
		}
	}

	function disableAll()
	{
		for(i=0;i<document.frm1.elements.length;i++)
		{
			if(document.frm1.elements[i].type == "text")
				document.frm1.elements[i].readOnly=true;
		}
	}

	function onCancel()
	{
		if(ConfirmMsg(102))
		{
			placeValues();
			setButtons();
		}
	}


	function validatePer(obj)
	{

		var str = obj.value;
		
		if( isNaN(str) )
		{
			alert("Enter valid Number");
			obj.value="";
			obj.focus();
			return false;
		}
		else if( parseFloat(str,10) > 100 )
		{
			ShowAlert(104);
			obj.focus();
			return false;
		}
		else
		{
			return true;
		}
	}

	function chkValue(strLbl, strRte, obj)
	{
		if( strLbl=="" && eval(strRte) != 0.00 )
		{
			if( strLbl=="" && strRte != "" )
			{
				ShowAlert(105,'Label');
				obj.focus();
				return false;
			}
			else
			{
				return true;
			}
		}
		else
		{
			return true;
		}
	}

	function submitme()
	{ 
		flag = chkValue(trim(document.frm1.mdrlabel1.value), trim(document.frm1.mdrrate1.value),document.frm1.mdrlabel1);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.mdrlabel2.value), trim(document.frm1.mdrrate2.value),document.frm1.mdrlabel2);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.mdrlabel3.value), trim(document.frm1.mdrrate3.value),document.frm1.mdrlabel3);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.type1label.value), trim(document.frm1.typerate1.value),document.frm1.type1label);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.type2label.value), trim(document.frm1.typerate2.value),document.frm1.type2label);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.type3label.value), trim(document.frm1.typerate3.value),document.frm1.type3label);
		if(	!flag )
			return false;

		flag = chkValue(trim(document.frm1.wclabel1.value), trim(document.frm1.wcrate1.value),document.frm1.wclabel1);
		if( !flag )
			return false;

		flag = chkValue(trim(document.frm1.wclabel2.value), trim(document.frm1.wcrate2.value),document.frm1.wclabel2);
		if(!flag)
			return false;

		flag = chkValue(trim(document.frm1.wclabel3.value), trim(document.frm1.wcrate3.value),document.frm1.wclabel3);
		if(!flag)
			return false;

		flag = chkValue(trim(document.frm1.wclabel4.value), trim(document.frm1.wcrate4.value),document.frm1.wclabel4);
		if(!flag)
			return false;

		flag = chkValue(trim(document.frm1.wclabel5.value), trim(document.frm1.wcrate5.value),document.frm1.wclabel5);
		if(!flag)
			return false;

		flag = chkValue(trim(document.frm1.wclabel6.value), trim(document.frm1.wcrate6.value),document.frm1.wclabel6);
		if(!flag)
			return false;

		document.frm1.submit();
	}

	function windowclosing()
	{
		if( ConfirmMsg(100))
		{						
			document.forms[0].action = appURL+"action/setupnav.jsp";
			document.forms[0].submit();
		}
	}

function menuOptionDivMouseDown (url)
		{
		
			if(!document.forms[0].cmdapply.disabled)
			{
				ShowAlert(103);
				return;
			}
			document.currentMenu.style.display='none';
			document.currentMBarOpt.style.border='1px solid lightgrey';
			document.menuIsActive = false;
			document.forms[0].action=url;
			document.forms[0].submit();
					
		}

