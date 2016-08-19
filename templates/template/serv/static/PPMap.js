/*
 * This demo illustrates the coordinate system used to display map tiles in the
 * API.
 *
 * Tiles in Google Maps are numbered from the same origin as that for
 * pixels. For Google's implementation of the Mercator projection, the origin
 * tile is always at the northwest corner of the map, with x values increasing
 * from west to east and y values increasing from north to south.
 *
 * Try panning and zooming the map to see how the coordinates change.
 */

/** @constructor */


PPMap.prototype.addPixelSelectionCallback = function (callback){
    this.selectionCallBack=callback;

}


var mapRef = null;
function PPMap(divName) {
    this.map = new google.maps.Map(document.getElementById(divName), {
        zoom: 3,
        center: {lat: 41.850, lng: -87.650},
        minZoom: 3,
        maxZoom: 16
    });
    this.selectedPixels = new Array();
    mapRef=this;
    this.selectionCallBack=null;
    this.lastSelectedPixelView=null;
    this.currentPixelsViews = new Array();

    this.setSelectedPixelView=function(pixelView){
        if(this.lastSelectedPixelView){
            this.lastSelectedPixelView.setSelected(false);
            this.lastSelectedPixelView=null;
        }
        this.lastSelectedPixelView=pixelView;
        this.lastSelectedPixelView.setSelected(true);

    }

    ///listeneres
    google.maps.event.addListener( this.map, 'click', function(event) {
        console.log("touch:"+event.latLng);
        console.log("ss2"+mapRef.n);
        mapRef.didTapOnMap(event.latLng);
    });
    google.maps.event.addListener( this.map, 'zoom_changed', function() {
        mapRef.currentPixelsViews = new Array();
        mapRef.lastSelectedPixelView=null;
        console.log("did change zoom");
    });
    //overlay
    overlay=new CoordMapType(new google.maps.Size(TILE_SIZE, TILE_SIZE),this);
    this.map.overlayMapTypes.insertAt(
        0, overlay);


    ///some functions
    this.didTapOnMap=function(latLng){


        console.log("touch:"+latLng.lat()+","+latLng.lng()+"zoom:"+ this.map+" ss:"+scale);

        var newSelectedPixels = new Array();
        var selectedPixelId;
        for(var dZoomLvl = 3;dZoomLvl<=16;dZoomLvl++){
            var scale = 1 << dZoomLvl;
            var worldCoordinate = project(latLng);
            var tileCoordinate = new google.maps.Point(
                Math.floor(worldCoordinate.x * scale / (TILE_SIZE/8.0)),
                Math.floor(worldCoordinate.y * scale / (TILE_SIZE/8.0)) );
            var  dpixelId = (tileCoordinate.x * 10000000) + tileCoordinate.y;
            if (dZoomLvl==this.map.zoom){
                selectedPixelId=dpixelId;
                if(this.lastSelectedPixelView&&this.selectedPixels.contains(""+dpixelId)){
                    console.log("THORW BACK")
                    return;
                }else{
                    console.log("Continue")
                }
            }
            newSelectedPixels.push(""+dpixelId);
        }
        this.selectedPixels=newSelectedPixels;

        console.log("cords:"+tileCoordinate +"pid:"+dpixelId);

        var  realZoom =realZoomFromGZoom(this.map.zoom)
        this.selectionCallBack(selectedPixelId,realZoom)

        var pixelView = this.currentPixelsViews[""+selectedPixelId];
        this.setSelectedPixelView(pixelView);

    }
}



/////////////////////////////////
//overlay realization
/////

function CoordMapType(tileSize,ppmap) {
    this.tileSize = tileSize;
    this.ppmap = ppmap;
    this.pixelDiff = this.tileSize.width/128.0
}
CoordMapType.prototype.getTile = function(gcoord, gzoom, ownerDocument) {

    console.log("MAP LOAD tILES");
    var  mainDiv = ownerDocument.createElement('div_pp_maps_1');
    var  zoom = realZoomFromGZoom(gzoom);
    var  coord = googleCordsFix(gcoord,zoom);

    //////////////////////////////////////////////////////
    //////////////////debug only//////////////////////////
    //mainDiv.style.width = this.tileSize.width + 'px';
    //mainDiv.style.height = this.tileSize.height + 'px';
    //mainDiv.style.fontSize = '10';
    //mainDiv.style.fontWeight = 'bolder';
    //mainDiv.style.border='3px solid rgba(0,0,0,1)';
    //////////////////////////////////////////////////////


    var  idivSize = this.tileSize.width/this.pixelDiff;

    var anchorX = coord.x*this.pixelDiff;
    var anchorY = coord.y*this.pixelDiff;

    var  requestUrl = "http://104.196.109.226/pixels?zoomLevel="+Math.abs(zoom);


    var  loadingPixelViews = new Array();
    for (var i = 0;i<this.pixelDiff;i++ ){
        for (var j = 0;j<this.pixelDiff;j++ ) {
            requestUrl+="&";

            //pixel calculation
            var  dsx = anchorX+j;
            var  dsy = anchorY+i;

            var  pixelId = (dsx * 10000000) + dsy;
            requestUrl+="pixel_id="+pixelId;



            ///////view (div)
            var  pixelDiv = ownerDocument.createElement("pp_pixel");
            pixelDiv.id="pp_pixel";
            //frame calc
            var  x_pos = j*idivSize;
            var  y_pos = i*idivSize;
            pixelDiv.style.position = "absolute";
            pixelDiv.style.left = x_pos+0.5 + 'px';
            pixelDiv.style.top = y_pos+0.5 + 'px';
            pixelDiv.style.width = idivSize-1+ 'px';
            pixelDiv.style.height = idivSize-1 + 'px';

            /////////////////////////////
            ///debug only////////////////
            //pixelDiv.innerHTML = ""+pixelId;
            /////////////////////////////

            mainDiv.appendChild(pixelDiv);
            ////pixel view
            var pixelView;
            if (!this.ppmap.lastSelectedPixelView&& this.ppmap.selectedPixels.contains(""+pixelId)){
                 pixelView = new PPPixelView(pixelDiv,idivSize,true);
                this.ppmap.lastSelectedPixelView=pixelView;
                this.ppmap.selectionCallBack(pixelId,zoom)
            }else{
                pixelView = new PPPixelView(pixelDiv,idivSize,false);
            }



            loadingPixelViews[""+pixelId]=pixelView;
            this.ppmap.currentPixelsViews[""+pixelId]=pixelView;

        }
    }

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            var result = JSON.parse(xhttp.responseText);
            var  counterSize =
                result.forEach( function (arrayItem)
                {
                    var  loadedPixelId=arrayItem["objectId"];
                    var  pixelViewToUpdate = loadingPixelViews[loadedPixelId];
                    var  pixel = new PPPixel(loadedPixelId,zoom);
                    pixel.priority=arrayItem["priority"];
                    pixel.postsCount=arrayItem["postsCount"];

                    pixelViewToUpdate.setPixel(pixel);
                });

        }
    };
    xhttp.open("GET", requestUrl, true);
    xhttp.send();
    return mainDiv;
};


var lastSelectedPixelView;

////pixel objects
function PPPixelView(div,size,isSelected){

    this.pixel=null;
    this.size=size;
    this.div=div;
    this.isSelected=isSelected;



    /////


    //borders
    this.emptyBorder= function (){
        return emptyBorder;
    }
    this.priorityBorder = function(){
        if (this.pixel&& this.pixel.postsCount>0) {
            var alpha = Math.max(0.22, this.pixel.priority);
            return '3px solid rgba(16,214,210,' + alpha + ')';
        }else{
            return this.emptyBorder();
        }
    }
    this.selectedBorder=function(){
        return selectedBorder
    }
    ///counter
    this.selectedCounterColor=function(){
        return selectedColor;
    }
    this.priorityCounterColor=function(){
        if (this.pixel&& this.pixel.postsCount>0) {
            var alpha = Math.max(0.22, this.pixel.priority);
            var bgColor = new RGBA(16, 214, 210, alpha);
            return bgColor.getCSS();
        }else{
            return emptyBorder
        }
    }
    //bkgr
    this.priorityBkgrColor=function(){
        if (this.pixel&&this.pixel.postsCount>0){
            return clearColor
        }else{
            return grayEmptyColor
        }

    }
    this.selectedBkgrColor=function(){
        return clearColor;
    }
    this.emptyBkgrColor=function(){
        return grayEmptyColor;
    }




    this.setPixel=function(pixel){
        this.pixel=pixel;
        this.redrawDiv();
    }
    this.setSelected=function(slected){
        this.isSelected=slected;
        this.redrawDiv();
    }
    this.counterDiv = null;
    if(!this.isSelected){
        this.div.style.backgroundColor=this.emptyBkgrColor();
        this.div.style.border=this.emptyBorder();
    }else{

        this.div.style.backgroundColor=this.selectedBkgrColor();
        this.div.style.border=this.selectedBorder();
    }
    this.div.style.fontSize = '15';
    this.div.style.fontWeight = 'bolder';
    this.div.style.textAlign = 'center';
    this.div.style.lineHeight = size/8 + 'px';



    this.redrawDiv = function(){

        var  border;
        var  countercolor;
        var  bkgrColor ;

        if(this.isSelected){
              bkgrColor =  this.selectedBkgrColor();
              border = this.selectedBorder();
              countercolor = this.selectedCounterColor();
        }else{
              border=  this.priorityBorder();
              countercolor = this.priorityCounterColor();
              bkgrColor = this.priorityBkgrColor();
        }
        if(this.pixel&&this.pixel.postsCount>0){
            if(this.counterDiv==null){
                this.counterDiv=this.createCounter(countercolor)
                this.div.appendChild(this.counterDiv);
            }else {
                this.counterDiv.style.backgroundColor = countercolor;
            }

            this.counterDiv.innerHTML=this.pixel.postsCount;

        }else{
            if(this.counterDiv!=null){
                this.div.removeChild(this.counterDiv);
                this.counterDiv=null;
            }
        }
        this.div.style.border=border;
        this.div.style.backgroundColor=bkgrColor;
    }



    this.createCounter = function(color){
        var counter = document.createElement('small_div');
        counter.id="small_counter";
        counter.style.backgroundColor=color;
        counter.style.fontSize = '15';
        counter.style.fontWeight = 'bolder';
        counter.style.textAlign = 'center';
        counter.background='#ffffff';

        counter.style.color="#ffffff"

        counter.style.left = this.size-56-4-2.5 + 'px';
        counter.style.top = this.size-32-4-2.5 + 'px';
        counter.style.width = 56+ 'px';
        counter.style.height = 32 + 'px';
        counter.style.lineHeight = 32 + 'px';
        counter.style.position = "absolute";
        return counter;
    }








}
///static colors
var  emptyBorder = '0px solid rgba(244,164,1,0.0)';
var  selectedBorder = '3px solid rgba(244,164,1,0.8)';
var  clearColor =  new RGBA(244,164,1,0.0).getCSS();
var  grayEmptyColor =  new RGBA(128,128,128,0.08).getCSS();
var  selectedColor =    new RGBA(244,164,1,0.8).getCSS();
///


function PPPixel(pixelId,zoomLevel){
    this.pixelId=pixelId;
    this.zoomLevel=zoomLevel;
    this.priority=0;
    this.postsCount = 0;




    //this.setPostsCount=function(postsCount){
    //    this.postsCount=postsCount;
    //}
    //this.setPriority=function(priority){
    //    this.priority=priority;
    //}
    //
    //this.getPr
}



var TILE_SIZE = 1024;
var  gmap=null;
var overlay;

//p
function Point(x, y) {
    this.x = x;
    this.y = y;
}

////helpers
Array.prototype.contains = function(obj) {
    var i = this.length;
    while (i--) {
        if (this[i] == obj) {
            return true;
        }
    }
    return false;
}
///map

function googleCordsFix(gcords,zoom){
    var  pixel_step = 256.0 * Math.pow(2, Math.abs(zoom)+1);
    var  xmax= 268435456.0/pixel_step;
    var  x = gcords.x;
    if (x<0){
        x = Math.abs(xmax+x);
        console.log("NEG:"+x +" m"+xmax);
    }
    var  y =gcords.y;
    var  xdiff = Math.floor(x/xmax);
    if(xdiff>0){
        x = x-xdiff*xmax;
    }
    console.log("cord:"+gcords + " "+ x);
    return new Point(x,y);

}

function realZoomFromGZoom(gzoom){
    return (gzoom-21)
}

function project(latLng) {
    var siny = Math.sin(latLng.lat() * Math.PI / 180);

    // Truncating to 0.9999 effectively limits latitude to 89.189. This is
    // about a third of a tile past the edge of the world tile.
    siny = Math.min(Math.max(siny, -0.9999), 0.9999);

    return new google.maps.Point(
        256 * (0.5 + latLng.lng() / 360),
        256 * (0.5 - Math.log((1 + siny) / (1 - siny)) / (4 * Math.PI)));
}

//div
function RGBA(red,green,blue,alpha) {
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = alpha;
    this.getCSS = function() {
        return "rgba("+this.red+","+this.green+","+this.blue+","+this.alpha+")";
    }
}
