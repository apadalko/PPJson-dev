function MasterDetailController (masterDiv,detailDiv){
    this.masterDiv = masterDiv;
    this.detailDiv=detailDiv;
    this.divsFunction = null;
}
MasterDetailController.prototype.startWorking = function(){
    this.reload();
}
MasterDetailController.prototype.reload = function (){
    if(this.divsFunction){
        items = this.divsFunction();
        items.forEach(function(item){
            this.masterDiv.appendChild(item.div);
            item.div.onclick=function(){
                xhr = new XMLHttpRequest();

                xhr.onreadystatechange = function (e) {
                    if (xhr.readyState == 4 && xhr.status == 200) {

                        insertAndExecute(this.detailDiv,xhr.responseText);
                        this.detailDiv.innerHTML = xhr.responseText;
                        //var arr =   this.detailDiv.innerHTML.getElementsByTagName('script')
                        //for (var n = 0; n < arr.length; n++)
                        //    eval(arr[n].innerHTML)
                    }
                }.bind(this);

                xhr.open("GET", "/static/"+item.htmlFile, true);
                xhr.setRequestHeader('Content-type', 'text/html');
                xhr.send();
            }.bind(this);

        }.bind(this));
    }
}
function MDButton(div,htmlFile){
    this.div=div;
    this.htmlFile = htmlFile;
}
function insertAndExecute(domelement, text)
{

    domelement.innerHTML = text;
    var scripts = [];

    ret = domelement.childNodes;
    for ( var i = 0; ret[i]; i++ ) {
        if ( scripts && nodeName( ret[i], "script" ) && (!ret[i].type || ret[i].type.toLowerCase() === "text/javascript") ) {
            scripts.push( ret[i].parentNode ? ret[i].parentNode.removeChild( ret[i] ) : ret[i] );
        }
    }

    for(script in scripts)
    {
        evalScript(scripts[script]);
    }
}
function nodeName( elem, name ) {
    return elem.nodeName && elem.nodeName.toUpperCase() === name.toUpperCase();
}
function evalScript( elem ) {
    data = ( elem.text || elem.textContent || elem.innerHTML || "" );

    var head = document.getElementsByTagName("head")[0] || document.documentElement,
        script = document.createElement("script");
    script.type = "text/javascript";
    script.appendChild( document.createTextNode( data ) );
    head.insertBefore( script, head.firstChild );
    head.removeChild( script );

    if ( elem.parentNode ) {
        elem.parentNode.removeChild( elem );
    }
}
function loadScript(url, callback)
{
    // Adding the script tag to the head as suggested before
    var head = document.getElementsByTagName('head')[0];
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = url;

    // Then bind the event to the callback function.
    // There are several events for cross browser compatibility.

    // Fire the loading
    head.appendChild(script);
}