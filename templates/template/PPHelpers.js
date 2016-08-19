

function humanTimestamp(timestamp){

    var  d = new Date();

   var  s = ( d.getTime()/1000-timestamp)

    if(s<60){

        return Math.floor(s)+"s ago";
    }else if (s < 3600){

        return Math.floor((s/60))+"m ago";
    }else if (s < 86400){

        return Math.floor((s/3600))+"hs ago";

    }else if (s < 1209600){

        return Math.floor((s/86400))+"d ago"


    } else{

        return Math.floor((s/604800))+" w ago"


    }



}
