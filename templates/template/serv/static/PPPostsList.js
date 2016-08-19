
function include(filename)
{
    var head = document.getElementsByTagName('head')[0];

    var script = document.createElement('script');
    script.src = filename;
    script.type = 'text/javascript';

    head.appendChild(script)
}

include("/static/PPModels.js")
include("/static/PPTableView.js")

function PPPostsList(divName){
    this.div=document.getElementById(divName);
    this.tableView = new PPTableView();
    this.tableView.delegate=this;
    this.div.appendChild(this.tableView.div);

    this.items = new Array ();

    this.selection=function(pixelId,zoomLevel){

        console.log("p:"+pixelId+" zl:"+zoomLevel);

        var  requestUrl = "http://localhost:8080/comments?pixelId="+pixelId+"&zoomLevel="+zoomLevel;

        //var xhttp = new XMLHttpRequest();
        //xhttp.onreadystatechange = (function() {
        //
        //
        //    if (xhttp.readyState == 4 && xhttp.status == 200) {
        //        var result = JSON.parse(xhttp.responseText);
        //        this.onElementsLoad(result);
        //
        //    }
        //}).bind(this);
        //xhttp.open("GET", requestUrl, true);
        //xhttp.send();

        this.onElementsLoad(null);
    }

    this.onElementsLoad= function(result){

        console.log("OOO:"+this.tableView);

        //result.forEach( (function (arrayItem)
        //{
        //    console.log("---------");
        //
        //    var  a = new PPCommentPost(arrayItem);
        //    console.log("o:"+ a.textContent);
        //    for (i in arrayItem){
        //        console.log(i+":"+arrayItem[i]);
        //
        //    }
        //
        //    console.log("OOO2:"+this.tableView);
        //
        //}));

        this.tableView.reloadData();
    }


}

PPPostsList.prototype.numberOfItems=function(){

    console.log("numberOfItems")
    return 10;
}

PPPostsList.prototype.divForIndex=function(index){


    var post = this.items[index];

    var  div =document.createElement("post"); // create core div
    div.id="post";


    var postLeft = document.createElement("post-left");
    postLeft.id="post-left";
    div.appendChild(postLeft);

    var postRight = document.createElement("post-right");
    postRight.id="post-right";
    div.appendChild(postRight);

    var postContent= document.createElement("post-content");
    postContent.id="post-content";
    postRight.appendChild(postContent);


    var textReplySection= document.createElement("text-reply-section");
    textReplySection.id="text-reply-section";
    textReplySection.innerHTML="asdasdd asd asd saasdsad  dsd s";
    postContent.appendChild(textReplySection);




    var footer= document.createElement("footer-section");
    footer.id="footer-section";
    postRight.appendChild(footer);


    console.log("a:"+postRight);

    console.log("c:"+postContent);




    return div;
}
