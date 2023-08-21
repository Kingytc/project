function enableButtons(bool1,bool2,bool3,bool4,bool5)
{
	document.forms[0].cmdadd.disabled=bool1;
	document.forms[0].cmdedit.disabled=bool2;
	document.forms[0].cmdapply.disabled=bool3;
	document.forms[0].cmdcancel.disabled=bool4;
	document.forms[0].cmdclose.disabled=bool5;

}