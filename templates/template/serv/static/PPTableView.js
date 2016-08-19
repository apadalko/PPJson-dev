function PPTableView(){

    this.div=document.createElement("pptableview");
    this.div.style.backgroundColor="#1235d4"
    this.div.style.float="left";
    this.div.style.height="100%";
    this.div.style.width="100%";
    this.div.style.overflowY="auto";
    this.delegate=null;



    this.reloadData=function(){

        var numberOfItems = this.delegate.numberOfItems();

        var  dY = 0
        for (var a = 0 ; a< numberOfItems;a++){

            var  cellDiv = this.delegate.divForIndex(a);


            ////cellDiv.style.left = dY + 'px';
            ////cellDiv.style.top = 0 + 'px';
            //
            //dY+=cellDiv.style.height;
            //console.log("div:"+cellDiv);
            //console.log("dy:"+dY+"  h:"+cellDiv.style.height);

            this.div.appendChild(cellDiv);


        }
    }





}