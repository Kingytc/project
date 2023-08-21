var imgSetUp = new Image();
function imgLoad(url,imgname)
{
	imgSetUp.src = url + "img/" + imgname;
	parent.topFrame.document.titleimg.src = imgSetUp.src;
}

function onNavLoad(url,imgname)
{
	imgSetUp.src = url + "img/" + imgname;
	parent.topFrame.document.titleimg.src = imgSetUp.src;
}

function txtLoad(txtname)
{
	parent.topFrame.document.all.titleimg.innerHTML=txtname;
}