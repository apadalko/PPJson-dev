function PPTableView(){
    this.loadCell = null;
    this.div=document.createElement("pptableview");
    this.div.style.backgroundColor="#f2eee8"

    this.div.style.height="100%";
    this.div.style.width="100%";
    this.div.style.overflowY="auto";

    this.delegate=null;

    this.bottomInsets = 0;


    this.insetDiv = null;

    this.contentSize = 0;
    this.loadCellHeight= 0;
    this.didShowLoadCell = false;

    this.reloadData=function(){
        var numberOfItems = this.delegate.numberOfItems();
        this.insertItems(0,numberOfItems);
    }


    this.insertItems=function(fromIndex,size){

        this.didShowLoadCell = false;

        this.loadCellHeight=0;
        if(this.loadCell!=null){

            this.div.removeChild(this.loadCell);
            this.loadCell=null;
        }
        if(this.insetDiv!=null){

            this.div.removeChild(this.insetDiv);
            this.insetDiv=null;
        }


        for (var a = fromIndex ; a< (size+fromIndex);a++){
            var  cellDiv = this.delegate.divForIndex(a);
            this.div.appendChild(cellDiv);
        }

        this.contentSize=this.div.scrollHeight;



        this.loadCell = this.delegate.divForLoadingCell();

        if(  this.loadCell){

            this.div.appendChild(  this.loadCell);
             var loadCellHeight=this.div.scrollHeight-this.contentSize;


         var  bottomY =  this.div.scrollTop+this.div.clientHeight
            if(bottomY>=this.contentSize){
                this.didShowLoadCell = true;

                this.delegate.didShowLoadCell();

            }

        }else{
            if(fromIndex==0&&size==0){
                if(this.delegate.emptyStateCell){
                    this.loadCell=this.delegate.emptyStateCell();
                    this.div.appendChild(  this.loadCell);
                }


            }
        }


        if(this.bottomInsets>0){

            this.insetDiv = document.createElement("div");
            this.insetDiv.style.width="100px";
            //this.insetDiv.backgroundColor="red";
            this.insetDiv.style.height=this.bottomInsets+"px";
            this.div.appendChild(this.insetDiv);
        }

    }


    this.div.onscroll=function(){

        var botScroll = (this.div.scrollTop+this.div.clientHeight);

        if(this.loadCell&&!this.didShowLoadCell){
            if(botScroll>this.contentSize){

                console.log("should load");
                this.didShowLoadCell = true;

                this.delegate.didShowLoadCell();

            }
        }




    }.bind(this);




}





