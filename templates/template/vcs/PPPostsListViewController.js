
function include(filename)
{
    var head = document.getElementsByTagName('head')[0];

    var script = document.createElement('script');
    script.src = filename;
    script.type = 'text/javascript';

    head.appendChild(script)
}

include("PPModels.js")
include("PPTableView.js")

function PPPostsList(divName){
    this.div=document.getElementById(divName);
    this.tableView = new PPTableView();
    this.tableView.bottomInsets=64;
    this.tableView.delegate=this;
    this.div.appendChild(this.tableView.div);
    this.selectionListener = null;

    this.items = new Array ();
    this.shouldShowLoadcell = false;

    this.filterRequestPart = null;

    this.pixel=null;


    this.currentPage=0;

    this.selection=function(pixel){
        this.currentPage=0;
        this.pixel=pixel;

        this.shouldShowLoadcell = true;
        this.items = new Array ();
        this.div.removeChild(this.tableView.div);


        this.tableView = new PPTableView();
        this.tableView.bottomInsets=64;
        this.tableView.delegate=this;
        this.tableView.div.style.float="left";
        this.div.appendChild(this.tableView.div);
        this.tableView.reloadData();


    }.bind(this);




    this.onElementsLoad= function(_result){

////

        var result = _result["pixel"]["hot"];

        var newItems = new Array();
        ///

        if (result.length>0){
            result.forEach( (function (arrayItem)
            {
                console.log("---------");

                var  pppost = new PPCommentPost(arrayItem);

                newItems.push(pppost);

            }).bind(this));
        }else{



        }





        if (newItems.length>=20){
            this.shouldShowLoadcell = true;
        }else{
            this.shouldShowLoadcell = false;
        }

        newItems.sort(function(a, b) {
            return  b.rating- a.rating;
        });

        //
        var from = this.items.length;
        this.items= this.items.concat(newItems);
        this.tableView.insertItems(from,newItems.length);
    }.bind(this);







}
PPPostsList.prototype.setFilterRequestPart=function(requestPart){
this.filterRequestPart=requestPart;

}

PPPostsList.prototype.loadNextPage=function(){


    var  requestUrl =  "http://api.placepixel.com/api/pixelandaggregate?limit=20&offset="+(this.currentPage*20)+"&pixel="+this.pixel.pixelId+"&zoom="+this.pixel.zoomLevel;

    if(this.filterRequestPart){

        requestUrl+=("&"+this.filterRequestPart);
    }
    console.log("r:"+requestUrl);

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = (function() {

        if (xhttp.readyState == 4){
            if ( xhttp.status == 200) {
                var result = JSON.parse(xhttp.responseText);
                this.onElementsLoad(result);
                this.currentPage++;
            }
        }


    }).bind(this);
    xhttp.open("GET", requestUrl, true);
    xhttp.send();




}

PPPostsList.prototype.addSelectionListener=function(selectionListener){

    this.selectionListener=selectionListener;
}

PPPostsList.prototype.numberOfItems=function(){

    console.log("numberOfItems:"+this.items.length);
    return this.items.length;
}

PPPostsList.prototype.didShowLoadCell=function(){

    this.loadNextPage();
}
PPPostsList.prototype.emptyStateCell=function(){
    var  loadDiv= document.createElement("div");
    loadDiv.className="loading-cell";




    var image = document.createElement("img");
    image.src='template/assets/images/lb_shocked@2x.png';
    image.style.width="64px";
    image.style.height="64px";
    loadDiv.appendChild(image);
if(this.items.length==0){
    image.style.marginTop="180px";
}



    var textDiv= document.createElement("div");
    textDiv.innerHTML="This Block is empty.<br>Tap on another to<br>see what’s inside!";
textDiv.style.marginTop="8px";
    textDiv.style.fontFamily="MuseoSansRounded-700";
    textDiv.style.fontSize="17px";
    textDiv.style.color="#4d4d4d";

    loadDiv.appendChild(textDiv);




    return loadDiv;

}

PPPostsList.prototype.divForLoadingCell=function(){

    if(this.shouldShowLoadcell){



        var  loadDiv= document.createElement("div");
        loadDiv.className="loading-cell";



        var image = document.createElement("img");

        image.src='template/assets/images/loadingbuddy.gif';
        loadDiv.appendChild(image);

        if(this.items.length==0){
            image.style.marginTop="180px";
        }
        var textDiv= document.createElement("div");
        textDiv.innerHTML="loading...";

        textDiv.style.fontFamily="MuseoSansRounded-700";
        textDiv.style.fontSize="17px";
        textDiv.style.color="#4d4d4d";

        loadDiv.appendChild(textDiv);




        return loadDiv;

    }else{
        return null;
    }

}


PPPostsList.prototype.divForIndex=function(index){



    var  postView = new PPPostsListPostView(this.items[index]);


    postView.mainDiv.style.cursor = 'pointer';

    postView.mainDiv.onclick =( function() {
        this.onDivClick(index)
    }).bind(this);

    return postView.mainDiv;
}


PPPostsList.prototype.onDivClick = function(index){

    console.log("div cl:"+index);
    
    if (index < this.items.length) {
        this.selectionListener(this.items[index]);
    }else {
        
        //means that user have cliced on load more cell!!!
        
    }

}






//////

function createFakePosts (){

    var  result = new Array();

    for (var  a =  0 ; a < 20 ; a++){

        var fakePost = new Array();

        fakePost["repliesCount"]=Math.floor((Math.random() * 10) + 1);
        fakePost["updateTime"]="1467328000.39519";
        if (a%3==0){
            fakePost["contentType"]=1;
            fakePost["content"]={"mediaUrl":"http://images4.fanpop.com/image/photos/22500000/Cool-Photos-happy-square-sponge-22529919-500-500.jpg","type":1};

        }else{
            fakePost["contentType"]=0;
        }
        fakePost["textContent"]="text asdad asd as das da number:"+a;

        fakePost["likesCount"]=21;
        fakePost["disLikesCount"]=2;
        fakePost["fromUser"]={"username":"bob123456","objectId":"123"}

result.push(fakePost);
    }

return result;
}