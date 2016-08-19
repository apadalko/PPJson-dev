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


////////////////////////////////////////////////
//////////////////////MAP////////////////////////
////////////////////////////////////////////////
///call backs!
PPMap.prototype.addPixelSelectionCallback = function (callback){
    this.selectionCallBack=callback;

}
PPMap.prototype.addWillApplyFilterListener = function (callback){
    this.willApplyFilter=callback;

    if(this.selectedFilter){
        this.willApplyFilter(this.selectedFilter);
    }



}
PPMap.prototype.clearFilter = function (){
    this.selectedFilter=null;
    if(this.willClearFilter){
        this.willClearFilter();
    }

    eraseCookie("filter");
    this.lastSelectedPixelView=null;
    this.map.overlayMapTypes.removeAt(0);
    this.map.overlayMapTypes.insertAt(
        0, this.overlay);

}
///public functions
PPMap.prototype.applyFilter = function (filter,selectNearest){
   this.selectedFilter=filter;
    if(this.willApplyFilter){
        this.willApplyFilter(filter);
    }

    var filterData = JSON.stringify(filter);

    if(filterData.searchName){
        delete filterData["searchName"];
    }
    createCookie("filter",filterData)
    console.log("did select new filter:"+filter.value);
    this.lastSelectedPixelView=null;
    this.map.overlayMapTypes.removeAt(0);
    this.map.overlayMapTypes.insertAt(
        0, this.overlay);


    if (selectNearest){

        var  request = "http://api.placepixel.com/api/";
        var  locPart = "&lat="+this.map.center.lat()+"&lon="+this.map.center.lng();
        var ending ="&limit=1&offset=0";
        if(filter.type==2){
            request+="v2/personas/posts?dist=1&hotnew=hot&id="+filter.value;
        }else if (filter.type==1){
            request+="search/commentquery?tagsonly=true&query="+filter.value;
        }else if (filter.type==0){
            request+="search/commentquery?tagsonly=false&query="+__textFilter(this.selectedFilter.value);
        }
        request+=locPart;
        request+=ending;


        var _filter = this.selectedFilter;
        console.log("request:"+request)
        var xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = (function() {


            if (xhttp.readyState == 4 && xhttp.status == 200) {
                var result = JSON.parse(xhttp.responseText);

                var selectedLoc;
                if(filter.type==2){

                    var  posts = result["response"];
                    if(posts.length>0){
                        var  p = posts[0];
                        var loc = pixelId_to_latlon(p.pixel,0);
                        var d1 = getDistance(loc,this.map.center)
                        selectedLoc={"loc":loc,"pixelId":pixelId,"d":d1}
                    }


                }else{
                    var textLoc;
                    var tagsLoc;
                    if (result["tags"]&&result["tags"].length>0){
                        var  pixelId = result["tags"][0]["pixel"];
                        var loc = pixelId_to_latlon(pixelId,0);
                        var d1 = getDistance(loc,this.map.center)
                        tagsLoc={"loc":loc,"pixelId":pixelId,"d":d1};
                        console.log("l:"+loc);
                    }
                    if (result["text"]&&result["text"].length>0){
                        var  pixelId = result["text"][0]["pixel"];
                        var loc = pixelId_to_latlon(pixelId,0);
                        var d1 = getDistance(loc,this.map.center);
                        textLoc={"loc":loc,"pixelId":pixelId,"d":d1};
                        console.log("l:"+loc);
                    }
                    if(tagsLoc&&textLoc){
                        if (tagsLoc["d"]>textLoc["d"]){
                            selectedLoc=textLoc;
                        }else{
                            selectedLoc=tagsLoc;
                        }
                    }else if(tagsLoc){
                        selectedLoc=tagsLoc;
                    }else{
                        selectedLoc=textLoc;
                    }
                }



                if (selectedLoc){

                    if(selectedLoc["loc"].lat()>84){
                        return;
                    }
                    var bounds = new google.maps.LatLngBounds();
                    bounds.extend(selectedLoc["loc"]);
                    //89.5919893003364, -58.560733795166016
                    bounds.extend(this.map.center);
                    console.log(bounds);
                    console.log("l("+selectedLoc["loc"].lat()+":"+selectedLoc["loc"].lng())
                    this.map.fitBounds(bounds);
                    this.map.center=selectedLoc["loc"];
                    this.selectLocation(selectedLoc["loc"]);

                }

            }

        }).bind(this);
        xhttp.open("GET", request, true);
        xhttp.send();


    }

}
PPMap.prototype.getFilterRequest=function(){
        if(this.selectedFilter){

            if(this.selectedFilter.type==0){

                return "text="+__textFilter(this.selectedFilter.value);
            }else if(this.selectedFilter.type==1){
                return "tagfilters[]="+this.selectedFilter.value;
            }else if(this.selectedFilter.type==2){
                return "poster="+this.selectedFilter.value;
            }else{
                return "";
            }
        }
        return "";
}

PPMap.prototype.selectPixel=function(pixel){


    if(this.selectionCallBack)
        this.selectionCallBack(pixel)


    createCookie("last_selected_pixel",JSON.stringify(pixel));


}

PPMap.prototype.showPlace=function(placeName){


    var  requestUrl =  "http://api.placepixel.com/api/v2/search/location?query="+placeName;

    console.log("r:"+requestUrl);

    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = (function() {


        if (xhttp.readyState == 4 && xhttp.status == 200) {
            var result = JSON.parse(xhttp.responseText);
            this.currentPixelsViews = new Array();
            this.lastSelectedPixelView=null;
            this.selectedPixels=new Array();
            var  point =  new google.maps.LatLng(result["result"]["point"]["lat"],result["result"]["point"]["lon"]);
            if(result["result"]["bounds"]==true){

                var  bounds = result["result"]["bounding_box"];
                var sw = new google.maps.LatLng(bounds["sw"]["lat"], bounds["sw"]["lon"]);
                var ne = new google.maps.LatLng(bounds["ne"]["lat"], bounds["ne"]["lon"]);

                var  gbounds = new google.maps.LatLngBounds(sw,ne);
                this.map.fitBounds(gbounds);
            }

            setTimeout(function() {
                this.selectLocation(point);
            }.bind(this), 100)


        }

    }).bind(this);
    xhttp.open("GET", requestUrl, true);
    xhttp.send();



}


PPMap.prototype.selectLocation=function(latLng){
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

    this.selectPixel(new PPPixel( selectedPixelId,realZoom));
    var pixelView = this.currentPixelsViews[""+selectedPixelId];
    this.setSelectedPixelView(pixelView);

}


function PPMap(divName,initialPixel,filter) {





    //

    this.divName = divName;
    this.map=null;
    this.dispZoom = 10;
    this.dispCenter = new google.maps.LatLng ( 40.7649414124685, -73.88442993164062);
    var lastSelectedPixel;
    if (initialPixel){
        lastSelectedPixel=initialPixel;
    }else{
        var  cp = readCookie("last_selected_pixel");

        if(cp){
           try{
               lastSelectedPixel = JSON.parse(cp);
           } catch (e) {
               eraseCookie("last_selected_pixel");
           }
        }

    }
    var  initialFilter;
    if (filter)
        initialFilter =filter;
    //else if (!initialPixel)
    //    initialFilter = readCookie("filter");



    var  tryToLoadLocation = true;


    if(lastSelectedPixel){
        tryToLoadLocation=true;

        this.dispZoom=Number(lastSelectedPixel.zoomLevel);
        this.dispCenter=pixelId_to_latlon(lastSelectedPixel.pixelId,this.dispZoom)
        console.log("z:"+this.dispCenter);
        this.dispZoom=gZoomFromRealZoom(this.dispZoom);

    }
    this.willApplyFilter=null;
    this.willClearFilter=null;
    this.selectedFilter=null;
    this.overlay=null;
    this.selectedPixels = new Array();
    this.selectionCallBack=null;
    this.lastSelectedPixelView=null;
    this.currentPixelsViews = new Array();
    this.setSelectedPixelView=function(pixelView){
        if(this.lastSelectedPixelView){
            this.lastSelectedPixelView.setSelected(false);
            this.lastSelectedPixelView=null;
        }
        if(pixelView){
            this.lastSelectedPixelView=pixelView;
            this.lastSelectedPixelView.setSelected(true);
        }


    }



    if (tryToLoadLocation){
        this.generateMap(this.dispCenter,this.dispZoom,initialFilter);
    }else{
        this.generateMap(this.dispCenter,this.dispZoom,initialFilter);
    }




    // Set CSS for the control border.

}

PPMap.prototype.generateMap =function (selectLocation,zoom,filter){
    //var myStyles =[
    //    {
    //        featureType: "poi",
    //        elementType: "labels",
    //        stylers: [
    //            { visibility: "off" }
    //        ]
    //    }
    //];
    this.map = new google.maps.Map(document.getElementById(this.divName), {
        zoom: zoom,
        center:  selectLocation,
        minZoom: 4,
        maxZoom: 16,
        //styles: myStyles,
        zoomControl: true,
        mapTypeControl: false,
        scaleControl: false,
        streetViewControl: false,
        rotateControl: false,
        fullscreenControl: false

    });





    ///listeneres
    var fnSet = google.maps.InfoWindow.prototype.set;
    google.maps.InfoWindow.prototype.set = function (one,two) {

        console.log(""+one+" s:"+two);

        if(two&&two.lat){
            this.selectLocation(two)
        }

        //if(this.get('isCustomInfoWindow'))
        //    fnSet.apply(this, arguments);
    }.bind(this);
    google.maps.event.addListener( this.map, 'click', function(event) {
        console.log("touch:"+event.latLng);
        this.selectLocation(event.latLng);
    }.bind(this));
    google.maps.event.addListener( this.map, 'zoom_changed', function() {
        this.currentPixelsViews = new Array();
        this.lastSelectedPixelView=null;
        console.log("did change zoom");
    }.bind(this));


    this.overlay=new CoordMapType(new google.maps.Size(TILE_SIZE, TILE_SIZE),this);
    this.map.overlayMapTypes.insertAt(
        0, this.overlay);

    this.selectLocation(selectLocation);





    if (filter) {
        this.applyFilter(filter);

    }

    var geoloccontrol = new klokantech.GeolocationControl( this.map, 16);

    geoloccontrol.element.onclick=function(ss){


        geoloccontrol.oa.fillOpacity=0;
        geoloccontrol.oa.strokeOpacity=0;
        //setTimeout(function(){
        //    if(Ha.visible)
        //    this.selectLocation(geoloccontrol.Ha.position);
        //}.bind(this),5000);
    }.bind(this);
}


///////////////////////////////////////////////
////////////////map overlay////////////////////
///////////////////////////////////////////////


function CoordMapType(tileSize,ppmap) {
    this.tileSize = tileSize;
    this.ppmap = ppmap;
    this.pixelDiff = this.tileSize.width/128.0
}
CoordMapType.prototype.getTile = function(gcoord, gzoom, ownerDocument) {

    var  mainDiv = ownerDocument.createElement('div_pp_maps_1');
    var  zoom = realZoomFromGZoom(gzoom);
    var  coord = googleCordsFix(gcoord,zoom);

    // ////////////////////////////////////////////////////
    // ////////////////debug only//////////////////////////
    // mainDiv.style.width = this.tileSize.width + 'px';
    // mainDiv.style.height = this.tileSize.height + 'px';
    // mainDiv.style.fontSize = '10';
    // mainDiv.style.fontWeight = 'bolder';
    // mainDiv.style.border='3px solid rgba(0,0,0,1)';
    // ////////////////////////////////////////////////////


    var  idivSize = this.tileSize.width/this.pixelDiff;

    var anchorX = coord.x*this.pixelDiff;
    var anchorY = coord.y*this.pixelDiff;

    var  requestUrl = " http://api2.placepixel.com/api/v2/pixels/batch?zoom=-"+Math.abs(zoom);


    var  loadingPixelViews = new Array();
    for (var i = 0;i<this.pixelDiff;i++ ){
        for (var j = 0;j<this.pixelDiff;j++ ) {
            requestUrl+="&";

            //pixel calculation
            var  dsx = anchorX+j;
            var  dsy = anchorY+i;

            var  pixelId = (dsx * 10000000) + dsy;
            requestUrl+="pixels[]="+pixelId;



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
            if (this.ppmap.selectedPixels.contains(""+pixelId)){
                 pixelView = new PPPixelView(pixelDiv,idivSize,true);
                if(!this.ppmap.lastSelectedPixelView||(this.ppmap.lastSelectedPixelView.pixelId!=pixelId)){
                    this.ppmap.selectPixel(new PPPixel(pixelId,zoom));

                }


                this.ppmap.lastSelectedPixelView=pixelView;

            }else{
                pixelView = new PPPixelView(pixelDiv,idivSize,false);
            }


            pixelView.pixelId = pixelId;

            loadingPixelViews[""+pixelId]=pixelView;
            this.ppmap.currentPixelsViews[""+pixelId]=pixelView;

        }
    }

    var  filter = this.ppmap.getFilterRequest();
    if(filter.length>0){
        requestUrl+=("&"+filter);
    }
    console.log("url:"+requestUrl);
    var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
        if (xhttp.readyState == 4 && xhttp.status == 200) {
            var result = JSON.parse(xhttp.responseText);

                //result.forEach( function (arrayItem)
                //{
                //    var  loadedPixelId=arrayItem["objectId"];
                //    var  pixelViewToUpdate = loadingPixelViews[loadedPixelId];
                //    var  pixel = new PPPixel(loadedPixelId,zoom);
                //    pixel.priority=arrayItem["priority"];
                //    pixel.postsCount=arrayItem["postsCount"];
                //
                //    pixelViewToUpdate.setPixel(pixel);
                //});

          var  pixelsData = result["response"]["pixels"]["pixels"];

            var  parentPixelsData = result["response"]["parent_pixels"];

            var  percentiles= new Array();

            parentPixelsData.forEach( function (arrayItem)
            {
                var  min =arrayItem["posts_min"];
                var  max =arrayItem["posts_max"];
                var avg = arrayItem["posts_total"]/arrayItem["total_pixels"];
                var d = [0,0,min,(min+avg)/2,avg,(max+avg)/2,max]
                if(arrayItem["pixels"]&&arrayItem["pixels"].length>0){
                    var  parentPixelId = arrayItem["pixels"][0]["id"];
                    percentiles[""+parentPixelId]=d;
                }

            });

            pixelsData.forEach( function (arrayItem)
            {
                var  loadedPixelId=arrayItem["id"];
                var  pixelViewToUpdate = loadingPixelViews[loadedPixelId];
                var  pixel = new PPPixel(loadedPixelId,zoom);
                pixel.postsCount=arrayItem["posts"];

                var perc = percentiles[""+arrayItem["parent"]];




                pixel.priority = 0;

            var alpha=1.0;

                var step =1.0/ (perc.length-1);

            for (var a =(perc.length-1); a>0; a--) {

                var val = perc[a];
                if ( pixel.postsCount>val) {
                    var valBefore =perc[a+1];
                    var offset = pixel.postsCount==valBefore?step:((pixel.postsCount-val)/(valBefore-val)/10.0);
                    pixel.priority= offset+alpha;
                    break;
                }
                alpha-=step;

            }

                pixel.priority=pixel.priority*0.75;
                pixelViewToUpdate.setPixel(pixel);


            });


        }
    }.bind(this);
    xhttp.open("GET", requestUrl, true);
    xhttp.send();
    return mainDiv;
};

var lastSelectedPixelView;

////pixel objects
function PPPixelView(div,size,isSelected){

    this.pixelId = null;
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
}
function PPMapFilter(value,type,displayName){
    this.value=value;
    this.type=type;
    this.displayName=displayName;
    this.searchName="";
    if(!this.displayName)
        this.displayName=value;



}


var TILE_SIZE = 1024;
var  gmap=null;
var overlay;

//p
function Point(x, y) {
    this.x = x;
    this.y = y;
}
function PPCordPoint(lat, lng) {
    this.lat = x;
    this.lng = y;

    this.lng=function(){
        return this.lng;
    }
    this.lat=function(){
        return this.lat;
    }
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

///filter helper
function __textFilter(value){
    var  _string=value.toLowerCase();
    var arr = _string.split(" ")
    var result = "\"\"";
    arr.forEach (function (str)
    {
        var  subStr ="(text:"+str+" OR text:"+str+"*)";
        result=result+" AND "+subStr;
    });
    return result;
}
///map helpers

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
function gZoomFromRealZoom(realZoom){
    return (realZoom+21)
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

//div helpers
function RGBA(red,green,blue,alpha) {
    this.red = red;
    this.green = green;
    this.blue = blue;
    this.alpha = alpha;
    this.getCSS = function() {
        return "rgba("+this.red+","+this.green+","+this.blue+","+this.alpha+")";
    }
}


function convertResponseToPixels(response){





}



function createCookie(name,value){

    document.cookie = name+"="+value+"; path=/";

    //var d = new Date();
    //d.setTime(d.getTime() + (90*24*60*60*1000));
    //var expires = "expires="+d.toUTCString();
    //document.cookie = name+"="+value+expires+"; path=/";
}
function pixelIdToCoords(pixelId) {
    var x = Math.round(pixelId / 10000000);
    var y = pixelId % 10000000;
    var xy = [x, y];
    return xy;
}
function pixelId_to_latlon(pixelId, zoom) {

    var xy = pixelIdToCoords(pixelId);

    return xyzoom_to_latlon(xy[0],xy[1],Math.abs(zoom));

}

function xyzoom_to_latlon(x, y, zoom) {
    var zoom_diff = -2 + zoom;
    var zoom_exponent =zoom_diff< 0? 0: zoom_diff;
    var  pixel_step = 256.0 * Math.pow(2, zoom_exponent);
    return xy_to_latlon_step(x, y, pixel_step);
}
function xy_to_latlon_step(x_init,y_init,step) {
    var mercator_offset = 268435456;
    var x = (x_init + 0.5) * step;
    var  y = (y_init + 0.5) * step;
    x /= mercator_offset;
    y /= mercator_offset;
    x = x -Math.round(x);
    y = y -Math.round(y);
    var  n = ((2.0 * Math.PI) * y) - Math.PI;
    var l = Math.atan((Math.exp(n) - Math.exp(-n)) / 2.0);
    var lat = -(180.0 / Math.PI) * l;
    var lon = (360.0 * x) - 180.0;
    var  r = new google.maps.LatLng(lat, lon);
    return r;
}

function readCookie(name) {

    try{
        var nameEQ = name + "=";
        var ca = document.cookie.split(';');
        for(var i=0;i < ca.length;i++) {
            var c = ca[i];
            while (c.charAt(0)==' ') c = c.substring(1,c.length);
            if (c.indexOf(nameEQ) == 0)
                return JSON.parse(c.substring(nameEQ.length,c.length));
        }
        return null;
    }catch(e) {
        return null;
    }

}

function eraseCookie(name) {
    createCookie(name,"",-1);
}
var rad = function(x) {
    return x * Math.PI / 180;
};

var getDistance = function(p1, p2) {
    var R = 6378137; // Earth’s mean radius in meter
    var dLat = rad(p2.lat() - p1.lat());
    var dLong = rad(p2.lng() - p1.lng());
    var a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
        Math.cos(rad(p1.lat())) * Math.cos(rad(p2.lat())) *
        Math.sin(dLong / 2) * Math.sin(dLong / 2);
    var c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    var d = R * c;
    return d; // returns the distance in meter
};
//loc
