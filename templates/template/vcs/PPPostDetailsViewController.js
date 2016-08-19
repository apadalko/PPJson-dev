/**
 * Created by alexpadalko on 7/6/16.
 */


function PPPostDetailsView (pppost,mainDiv,postId){

    this.post = pppost;
    this.preloadedPostId=postId;
    this.items= new Array();

    if(pppost){
        this.items.push(this.post);
    }

    this.pageSize=25;
    this.currentPage =0 ;

    this.shareListener=null;
    this.downloadListener=null;
    this.closeListener = null;


    this.shouldShowLoadcell=false;

    if(pppost==null || this.post.repliesCount>0){
        this.shouldShowLoadcell=true;
    }
    this.superDiv = mainDiv;
    this.div = document.createElement("div");
    this.div.className ="map-overlay details-overlay"
    this.div.id="post-details-overlay";
    this.postDetailsHolderDiv = document.createElement("div");
    this.postDetailsHolderDiv.className="post-details-holder";
    this.div.appendChild(this.postDetailsHolderDiv);






    this.tableView  = new PPTableView();
    this.tableView.div.style.marginTop="50px";
    this.tableView.div.style.height="calc(100% - 100px)";
    this.tableView.div.style.width="100%";
    this.tableView.div.style.float="left";
    this.tableView.delegate=this;
    this.postDetailsHolderDiv.appendChild(this.tableView.div);
    this.tableView.reloadData();

    var  bar = this.buildNavigationBar();
    this.postDetailsHolderDiv.appendChild(bar);

    var  toolbar = this.buildToolBar();
    this.postDetailsHolderDiv.appendChild(toolbar);


    this.onElementsLoad= function(_result){

////

        var result = _result["comments"];

        var newItems = new Array();
        ///

        if (result.length>0){
            result.forEach( (function (arrayItem)
            {
                console.log("---------");

                var  pppost = new PPCommentReply(arrayItem);

                newItems.push(pppost);

            }).bind(this));
        }





        if (newItems.length>=this.pageSize){
            this.shouldShowLoadcell = true;
        }else{
            this.shouldShowLoadcell = false;
        }

        newItems.sort(function(a, b) {
            return  a.timestamp- b.timestamp;
        });

        //
        var from = this.items.length;
        this.items= this.items.concat(newItems);
        this.tableView.insertItems(from,newItems.length);
    }.bind(this);



    this.superDiv.appendChild(this.div);

}
PPPostDetailsView.prototype.addCloseListener = function(closeListener){

    this.closeListener=closeListener;

}

PPPostDetailsView.prototype.loadNextPage=function(){


    if(this.post){
        var  requestUrl =  "http://api.placepixel.com/api/comments/children/"+this.post.objectId+"?limit="+this.pageSize+"&offset="+(this.pageSize*this.currentPage)+"&sorting=ASC";

        console.log("r:"+requestUrl);

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = (function() {


            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var result = JSON.parse(xhttp.responseText);
                this.onElementsLoad(result);
                this.currentPage++;
            }

        }).bind(this);
        xhttp.open("GET", requestUrl, true);
        xhttp.send();
    }else if (this.preloadedPostId){

        http://api.placepixel.com/api/comments/8972360
            var  requestUrl =  "http://api.placepixel.com/api/comments/"+this.preloadedPostId;

        console.log("r:"+requestUrl);

        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = (function() {


            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var result = JSON.parse(xhttp.responseText);


                this.post=new PPCommentPost(result);
                this.items.push(this.post);
                if(this.post.repliesCount>0){
                    this.shouldShowLoadcell=true;
                }else{
                    this.shouldShowLoadcell=false;
                }

                this.tableView.reloadData();

            }

        }.bind(this));
        xhttp.open("GET", requestUrl, true);
        xhttp.send();
    }




}



///actions

PPPostDetailsView.prototype.addShareListener= function(sharelistener) {
    this.shareListener = sharelistener;
}
PPPostDetailsView.prototype.addDownloadListener= function(sharelistener) {
    this.downloadListener = sharelistener;
}
PPPostDetailsView.prototype.onCloseButton = function(){


this.superDiv.removeChild(this.div);
    if(this.closeListener!=null)
    this.closeListener();

}




//// table data source

PPPostDetailsView.prototype.didShowLoadCell=function(){


    this.loadNextPage();

}
PPPostDetailsView.prototype.divForLoadingCell=function(){


    if(this.shouldShowLoadcell){


        var  loadDiv= document.createElement("div");
        loadDiv.className="loading-cell";



        var image = document.createElement("img");
        image.src='template/assets/images/loadingbuddy.gif';
        loadDiv.appendChild(image);


        var textDiv= document.createElement("div");
        textDiv.innerHTML="loading...";

        textDiv.style.fontFamily="MuseoSansRounded-500";
        textDiv.style.fontSize="17px";
        textDiv.style.color="#4d4d4d";

        loadDiv.appendChild(textDiv);





        return loadDiv;

    }else{
        return null;
    }
}


PPPostDetailsView.prototype.numberOfItems=function(){

    return this.items.length;
}

PPPostDetailsView.prototype.divForIndex=function(index){


    if(index==0){
        var postView = new PPPostDetailsPostView(this.items[index]);
        return postView.mainDiv;
    }else{
        var reply = new PPPostDetailsReplyView(this.items[index]);
        return reply.mainDiv;
    }


}

//// ui logic


PPPostDetailsView.prototype.buildNavigationBar = function(){

    var  navBarDiv = document.createElement("div");
    navBarDiv.className="post-details-nav-bar";
    navBarDiv.style.position="relative";

    navBarDiv.style.borderRadius="6px 6px 0px 0px";
    this.postDetailsHolderDiv.appendChild(navBarDiv);


    //



    var  closeButton =    createImageElement("/template/assets/images/gm_x@2x.png",27,27);
    closeButton.style.position="absolute";
    closeButton.style.top="12px";
    closeButton.style.left="8px";
    navBarDiv.appendChild(closeButton);

    closeButton.onclick =( function() {
        this.onCloseButton()
    }).bind(this);


    var sharePostButton = document.createElement("div");
    sharePostButton.className = "gm-share-post-button";
    sharePostButton.style.position="absolute";
    //sharePostButton.style.top="12px";
    sharePostButton.style.right="8px";
    sharePostButton.innerHTML='SHARE';

    sharePostButton.onclick=function(){
        if(this.shareListener){

            this.shareListener(this.post);
        }
    }.bind(this);


    navBarDiv.appendChild(sharePostButton);


    return navBarDiv;

}
PPPostDetailsView.prototype.buildToolBar=function(){

    var  toolBarDiv = document.createElement("div");
    toolBarDiv.className="post-details-tool-bar";
    toolBarDiv.innerHTML='<span class="mueso900Medium">'+"Download Gabbermap "+'</span> <span class="mueso700Medium">'+"to join the conversation"+'</span>';


    toolBarDiv.onclick=(function(){
        if(this.downloadListener){
            this.downloadListener();
        }

    }.bind(this))
    return toolBarDiv;
}

///
function createFakeReplies (limit){

    var  result = new Array();

    for (var  a =  0 ; a < limit ; a++){

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