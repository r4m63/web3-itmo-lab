window.onload = function() {
    handleClick();
}

function handleClick() {
    document.getElementById('graph').removeEventListener('click', handleEvent);
    document.getElementById('graph').addEventListener('click', handleEvent);
}

function handleEvent(e){
    const svgX = e.offsetX;
    const svgY = e.offsetY;

    const x = (svgX - 250)/40;
    const y = (250 - svgY)/40;
    const r = PF('rMenu').getSelectedValue();

    console.log("x, y =" + x, y);
    console.log("r = " + r);

    document.getElementById('hiddenForm:hiddenX').value = x;
    document.getElementById('hiddenForm:hiddenY').value = y;
    document.getElementById('hiddenForm:hiddenR').value = r;
    document.getElementById('hiddenForm:hiddenSubmit').click();
}
