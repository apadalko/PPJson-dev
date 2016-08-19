

function PPSearchBar(){
    //this.input =

    this.div = document.createElement("div");
    this.div.className="search-bar search-section";

    this.searchImage = document.createElement("img");
    this.searchImage.className="left-image";
    this.searchImage.src="/template/assets/images/gm_search_grey_full@2x.png";
    this.div.appendChild(this.searchImage);


    this.savedValue = null;


    this.inputDiv = document.createElement("input")
    this.inputDiv.placeholder="Search Gabbermap"
    this.div.appendChild(this.inputDiv);

    this.cancelImage=document.createElement("img");
    this.cancelImage.className="right-image";
    this.cancelImage.id="search-bar-right-image"
    this.cancelImage.src="/template/assets/images/gm_x_small@2x.png";
    this.div.appendChild(this.cancelImage);
    this.cancelImage.hidden=true;

    this.filtered=false;




    this.didPressEnter = null;
    this.willBeginEditing = null;
    this.didFinishEditing = null;
    this.didChangeText = null;
    this.shouldCancelFilter = null;


    this.shouldSkipFinishEditingCall=false;
    this.shouldSkipBeginEditingCall=false;
    this.text = "";




    this.cancelImage.onclick=( function() {
        console.log("cl");

        if(this.filtered){
            this.cancelImage.hidden=true;
            this.invertColor(false);
            this.inputDiv.value="";
            this.text="";
            this.filtered=false;
            if(this.shouldCancelFilter){
                this.shouldCancelFilter();
            }
            this.savedValue=null;
        }else{
            this.shouldSkipFinishEditingCall=true;
            this.shouldSkipBeginEditingCall=true;
            this.inputDiv.value="";
            this.setText("");
            this.inputDiv.focus();
        }

        //
    }.bind(this));

    this.inputDiv.addEventListener('input', function() {

        this.setText(this.inputDiv.value);

    }.bind(this));

    this.inputDiv.addEventListener('focus', function() {
        console.log("willBeginEditing");

        if(this.filtered){
            this.invertColor(false);
            this.filtered=false;
            if(this.shouldCancelFilter){
                this.shouldCancelFilter();
            }
            this.inputDiv.value=this.savedValue;
            this.text=this.savedValue;
            this.savedValue=null;
        }

        if(this.inputDiv.value.length>0){
            this.cancelImage.hidden=false;
        }else{
            this.cancelImage.hidden=true;
        }

        if(this.shouldSkipBeginEditingCall==true){
            this.shouldSkipBeginEditingCall=false;
            console.log("willBeginEditing - skipped");
            return;
        }

        if(this.willBeginEditing){
            this.willBeginEditing();
        }
    }.bind(this));
    this.inputDiv.addEventListener('blur', function() {
        console.log("didFinishEditing");
        this.editing=false;


        if(this.didFinishEditing){


            setTimeout(function() {

                if(this.shouldSkipFinishEditingCall==true){
                    this.shouldSkipFinishEditingCall=false;
                    console.log("didFinishEditing - skipped");
                    return;
                }

                this.didFinishEditing();
            }.bind(this), 200)


        }
    }.bind(this));
    this.inputDiv.addEventListener('keyup', function (e) {
        if (e.keyCode == 13) {
            if(this.didPressEnter){
                this.didPressEnter();
            }
        }else if (e.keyCode == 27) {
           this.inputDiv.blur();
        }
    }.bind(this));
    //console.log(this.inputDiv.innerHTML);
}
PPSearchBar.prototype.setText=function(text){

    console.log("didChangeText");
    this.text=text;

    if(this.text.length>0){
        this.cancelImage.hidden=false;
    }else{
        this.cancelImage.hidden=true;
    }

    if(this.didChangeText){
        this.didChangeText(this.getText());
    }
}
PPSearchBar.prototype.getText=function(){
    return this.text;
}
PPSearchBar.prototype.clean=function(){

    this.inputDiv.value="";
    this.text="";
    this.savedValue=null;
}

PPSearchBar.prototype.applyFilter=function(filter){
    this.cancelImage.hidden=false;
    this.inputDiv.value=filter.displayName;
    this.savedValue=filter.searchName;
    this.invertColor(true);
    this.filtered=true;


}
PPSearchBar.prototype.invertColor=function(blue){

    if(blue){
        this.div.style.backgroundColor="#10d6d2";
        this.inputDiv.style.textAlign="center";
        this.inputDiv.style.color="#ffffff";
        this.searchImage.id="search-bar-left-image-onfilter"


        this.searchImage.src="/template/assets/images/gm_search_white_full@2x.png";
        this.cancelImage.src="/template/assets/images/gm_x_small_white@2x.png";
    }else{
        this.div.style.backgroundColor="#ffffff";
        this.inputDiv.style.color="#000000";
        this.inputDiv.style.textAlign="left";
        this.searchImage.id="search-bar-left-image";


        this.searchImage.src="/template/assets/images/gm_search_grey_full@2x.png";
        this.cancelImage.src="/template/assets/images/gm_x_small@2x.png";
    }


}


function PPSearchSuggestionView(suggestion,asSaved){

    this.suggestion=suggestion;
    this.div = document.createElement("div");
    this.div.className="search-section";

    this.leftImage=document.createElement("img");
    this.leftImage.className="left-image";
    this.leftImage.id="search-bar-left-image"
    this.div.appendChild(this.leftImage);

    var textDiv  = document.createElement("div");
    textDiv.className="suggestion-text";
    this.div.appendChild(textDiv);
    this.onSelection=null;
    if(suggestion.type==4){

        this.leftImage.src="/template/assets/images/gm_location_full@2x.png";

        if(asSaved==true)
            this.div.style.backgroundColor="#b2b2b2"
        else
            this.div.style.backgroundColor="#29abe2"

        var fullLoc = suggestion.value.split(",");
        if(fullLoc.length>1){

            var  mainStirng = fullLoc[0];
            fullLoc.shift();
            var detailsString=fullLoc.join(",");

            textDiv.innerHTML='<span class="mueso500Medium">'+mainStirng+'</span> <span class="mueso500Small"><br>'+detailsString+'</span>';


        }else{
            textDiv.innerHTML='<span class="mueso500Medium">'+suggestion.value+'</span>';
        }


    }else if(suggestion.type==2){
        this.leftImage.id="search-section-persona-image";
        this.div.style.backgroundColor=suggestion.value.color;

        this.leftImage.src=suggestion.value.icon;

        var  text = '<span class="mueso500Medium">'+suggestion.value.name+'</span>';

        if(suggestion.value.displayText&&suggestion.value.displayText.length>0){
            text+='<br><span class="mueso500Small">'+suggestion.value.displayText+'</span>';
        }

            textDiv.innerHTML=text;


    } else{


        this.leftImage.src="/template/assets/images/gm_search_white_full@2x.png";

        if(asSaved==true)
            this.div.style.backgroundColor="#cccccc"
        else
            this.div.style.backgroundColor="#10d6d2"


        if(suggestion.type==1){
            textDiv.innerHTML='<span class="mueso500Medium">#'+suggestion.value+'</span>';
        }else{
            textDiv.innerHTML='<span class="mueso500Medium">'+suggestion.value+'</span>';
        }

    }


    this.div.style.cursor = 'pointer';

    this.div.onclick =( function() {
        if(this.onSelection){
            this.onSelection(this.suggestion);
        }

    }).bind(this);



}