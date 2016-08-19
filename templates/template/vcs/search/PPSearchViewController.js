/**
 * Created by alexpadalko on 7/8/16.
 */

function PPSearchViewController(){

    this.shareListener=null;

    this.div = document.createElement("div");
    this.div.className="search-overlay";

    var fakeHolder = document.createElement("div")
    fakeHolder.className="search-fake-suggestion-holder";
    this.div.appendChild(fakeHolder);


    this.suggestionHolderDiv = document.createElement("div")
    this.suggestionHolderDiv.className="search-suggestion-holder";
    //this.suggestionHolderDiv.style.height="200px";
    fakeHolder.appendChild(this.suggestionHolderDiv);






    this.searchBar=this.buildSearchBar();
    this.suggestionHolderDiv.appendChild(this.searchBar.div);



   this.shareButton = document.createElement("div");
    this.shareButton.className="search-share-button";
    this.shareButton.innerHTML='<div style="color: #b2b2b2">SHARE</div>';
    this.shareButton.style.backgroundColor="#ffffff";
    this.shareButton.style.color="b2b2b2";

    this.shareButton.onclick=function(){
        if(this.shareListener){

            this.shareListener();
        }
    }.bind(this);

   fakeHolder.appendChild(  this.shareButton);


    this.locationListener;
    this.filterListener;
    this.filterCancelListener;
    this.loadedText=null;

    this.botsSuggestions= new Array();


    this.selectedFilter = null;
    this.subDivs = new Array();

    this.savedSuggestions = readCookie("_s_suggestions");
    if (!this.savedSuggestions||!this.savedSuggestions.length>0){
        this.savedSuggestions=new Array();
    }

    console.log("suggsetions count:"+this.savedSuggestions.length);


    this.loadBots();
    //

}
PPSearchViewController.prototype.loadBots=function(){

    var  requestUrl =  "http://api.placepixel.com/api/v2/personas";

    console.log("BOTS:"+requestUrl);
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = (function() {

        if (xhttp.readyState == 4 && xhttp.status == 200) {
            var result = JSON.parse(xhttp.responseText);



            var response= result["response"];
            //response=shuffle(response);

            for(var a=0;a<response.length;a++){
                if(response[a]["id"]==3273||
                    response[a]["id"]==3272||
                    response[a]["id"]==3238||
                    response[a]["id"]==5522||
                    response[a]["id"]==5313||
                    response[a]["id"]==5925){
                    var  personaData = response[a];
                    this.botsSuggestions.push(new PPSuggestion(new PPPersona(personaData),2));
                }


            }
            this.botsSuggestions=shuffle( this.botsSuggestions);


        }

    }.bind(this))
    xhttp.open("GET", requestUrl, true);
    xhttp.send();
}

PPSearchViewController.prototype.generateEmptySuggestions=function(){


    var suggestions = new Array;

    suggestions= suggestions.concat(this.savedSuggestions);


    if(this.botsSuggestions.length>0){
        var  gabberbotsheader = document.createElement("div");
        gabberbotsheader.className="search-gabberbots-title-section";
        gabberbotsheader.innerHTML=
            '<span style="color: #f13759; ">G</span>' +
            '<span style="color: #f4a401; ">a</span>' +
            '<span style="color: #7e45dc; ">b</span>' +
            '<span style="color: #10d6d2; ">b</span>' +
            '<span style="color: #29abe2; ">e</span>' +
            '<span style="color: #f13759; ">r</span>' +
            '<span style="color: #f4a401; ">b</span>' +
            '<span style="color: #7e45dc; ">o</span>' +
            '<span style="color: #10d6d2; ">t</span>' +
            '<span style="color: #29abe2; ">s</span>' ;
        suggestions.push(gabberbotsheader);

        suggestions=suggestions.concat(this.botsSuggestions);
    }


    this.displayItems(suggestions,true);

}

PPSearchViewController.prototype.saveSuggestion=function(suggestion){

    if(suggestion.type==2||suggestion.type==3){
        return;
    }
    for (a=0;a<this.savedSuggestions.length;a++){

        if(this.savedSuggestions[a].value==suggestion.value){
            this.savedSuggestions.splice(a,1);
            break;
        }

    }


   this.savedSuggestions.splice(0, 0, suggestion);



    if (this.savedSuggestions.length>=4){
        this.savedSuggestions.pop();
    }
    createCookie("_s_suggestions",JSON.stringify(this.savedSuggestions));

}

PPSearchViewController.prototype.addShareListener= function(sharelistener) {
    this.shareListener = sharelistener;
}
PPSearchViewController.prototype.addLocationListener= function(listener) {
    this.locationListener = listener;
}
PPSearchViewController.prototype.addFilterListener = function(listener) {
    this.filterListener = listener;
}
PPSearchViewController.prototype.addFilterCancelListener = function(listener){
    this.filterCancelListener=listener;
}

PPSearchViewController.prototype.didSelectSuggetion = function(suggsetion){


        if(suggsetion.type==0||suggsetion.type==1){
            var filter = new PPMapFilter(suggsetion.value,suggsetion.type);

            this.filterListener(filter);

            this.saveSuggestion(suggsetion);
        }else if (suggsetion.type==4){
            this.locationListener(suggsetion.value);
            this.searchBar.clean();
            this.saveSuggestion(suggsetion);
            filter.searchName=suggsetion.value;
        }else if (suggsetion.type == 2){
            var filter = new PPMapFilter(suggsetion.value.objectId,suggsetion.type,suggsetion.value.name);

            this.filterListener(filter);
        }



    this.cleanAll();

}
PPSearchViewController.prototype.applyFilter=function(filter){
    this.searchBar.applyFilter(filter);
    if(filter){

        this.invertColors(true);

    }else{
        this.invertColors(false);
    }

    this.selectedFilter=filter;
}



PPSearchViewController.prototype.displayItems = function(items,asSaved){
    this.subDivs = new Array();

    var  idx = 0;
    items.forEach( (function (arrayItem)
    {

        var adiv;
        if (arrayItem.value){
            var suggsetionView = new PPSearchSuggestionView(arrayItem,asSaved);

            suggsetionView.onSelection=function(suggsetion){
                console.log("!!!");

                this.didSelectSuggetion(suggsetion);
            }.bind(this);

            adiv= suggsetionView.div;

        }else{
            adiv=arrayItem;
        }
        adiv.style.marginTop=idx>0?"5px":"15px";

        this.suggestionHolderDiv.appendChild(adiv);
        this.subDivs.push(adiv);
        idx++;

    }.bind(this)));







}


PPSearchViewController.prototype.invertColors = function(filtered){

    if(filtered){
        this.shareButton.innerHTML='<div style="color: #ffffff">SHARE</div>';
        this.shareButton.style.backgroundColor="#10d6d2";
        this.shareButton.style.color="#ffffff";
    }else{
        this.shareButton.innerHTML='<div style="color: #b2b2b2">SHARE</div>';
        this.shareButton.style.backgroundColor="#ffffff";
        this.shareButton.style.color="b2b2b2";
    }

}

PPSearchViewController.prototype.onElementsLoad = function(result,searchedText){
    var  tags = result["tags"];
    var originalText=searchedText.toLowerCase();
    var  locations = result["locations"];
    var  suggsetions = new Array();
    var textType = searchedText.startsWith("#")?1:0;

    var tagsCount =4;
    if (textType==0){
        suggsetions.push(new PPSuggestion(searchedText,textType));
        //tagsCount++;
    }


    for (var  a=0;a<Math.min(tagsCount,tags.length);a++){
        var  val = tags[a];

        if(textType!=0||val!=originalText){
            suggsetions.push(new PPSuggestion(val,textType));
        }

    }


    for (var  a=0;a<Math.min(4,locations.length);a++){
        suggsetions.push(new PPSuggestion(locations[a],4));
    }

    this.displayItems(suggsetions,false);




}



PPSearchViewController.prototype.load = function(text){
    var  searchString=text.toLowerCase();

    if(searchString.startsWith("#")){
      searchString=  searchString.replace("#","");
    }
    searchString= searchString.split(' ').join('+');





    if(this.loadedText==searchString){
        return;
    }



    this.cleanAll();
    this.loadedText=searchString;
    if(searchString.length>0){


        console.log(searchString);
        var  requestUrl =  "http://api.placepixel.com/api/search/autocompletequery?query="+encodeURIComponent(searchString.toLowerCase())+"&tagsonly=1";

        console.log(requestUrl);
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = (function() {

            if(this.loadedText!=searchString)
            return;

            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var result = JSON.parse(xhttp.responseText);
                this.onElementsLoad(result,text);
            }

        }).bind(this);
        xhttp.open("GET", requestUrl, true);
        xhttp.send();
    }else{
        this.generateEmptySuggestions();
    }



}

PPSearchViewController.prototype.cleanAll = function(){
    this.loadedText=null;
    this.subDivs.forEach( (function (arrayItem)
    {
       this.suggestionHolderDiv.removeChild(arrayItem);

    }).bind(this));

    this.subDivs = new Array();

}
PPSearchViewController.prototype.buildSearchBar = function(){
    var searchBar =new PPSearchBar();
    searchBar.didChangeText=function(text){
        console.log(text);
        this.load(text);

    }.bind(this);
    searchBar.didFinishEditing=function(){

        this.cleanAll();

    }.bind(this);
    searchBar.willBeginEditing=function(){

        this.load(this.searchBar.getText());
    }.bind(this);
    searchBar.shouldCancelFilter=function(){

        if(this.filterCancelListener){
            this.filterCancelListener();
        }

        this.invertColors(false);

    }.bind(this);
    searchBar.didPressEnter=function(){



    }.bind(this);

    return searchBar;
}

function shuffle(array) {
    var currentIndex = array.length, temporaryValue, randomIndex;

    // While there remain elements to shuffle...
    while (0 !== currentIndex) {

        // Pick a remaining element...
        randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex -= 1;

        // And swap it with the current element.
        temporaryValue = array[currentIndex];
        array[currentIndex] = array[randomIndex];
        array[randomIndex] = temporaryValue;
    }

    return array;
}