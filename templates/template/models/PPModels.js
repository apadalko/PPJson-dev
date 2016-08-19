/**
 * Created by alexpadalko on 6/30/16.
 */

var PPComment = function(commentData){

    this.objectId = commentData["id"];
    this.fromUser = new PPUser(commentData["userid"],commentData["username"],commentData["userscore"],commentData["usersmallicon"],commentData["usertype"]);
    this.textContent = commentData["usercomment"];
//this.repliesCount=commentData["childcount"];

    this.likes=commentData["likes"];
    this.dislikes=commentData["dislikes"];
    this.score = this.likes + this.dislikes;
    this.rating = commentData["rating"];
    this.timestamp = commentData["commenttime"];



    this.content=null;
    if(commentData["userimage"]){
        this.content=new PPCommentContent(commentData["userimage"],1);
        this.contentType=1;
    }else if (commentData["uservideo"]){
        this.content=new PPCommentContent(commentData["uservideo"],2);
        this.contentType=2;
    }

}


var PPCommentPost = function(commentPostData){
    PPComment.call(this, commentPostData)

    this.lastReplyDate = commentPostData["updateTime"];
    this.repliesCount=commentPostData["childcount"];

}
//

PPCommentPost.prototype = Object.create(PPComment.prototype);




function PPCommentReply(commentReplyData){
   PPComment.call(this,commentReplyData)

}
///

PPCommentReply.prototype = Object.create(PPComment.prototype);










function PPUser(objectId,username,karma,profilepicture,userType){
    this.username= username;
    this.objectId= objectId;
    this.profilePicture= profilepicture;
    this.karma= karma;
    this.userType = userType;
}



function PPCommentContent(mediaUrl,type){

    this.mediaUrl = mediaUrl;
    this.type=type;

}



function PPSuggestion(value,type){
    this.value=value;
    this.type=type;

}

function PPPersona(personaData){
    this.name="@"+personaData["name"].toLocaleLowerCase();
    this.displayText=personaData["displaytext"];
    this.objectId = personaData["id"];
    this.icon = personaData["gif_url"];
    this.color=personaData["color"];
if(!this.icon){
    this.icon = personaData["userimage"];
}


    if(personaData["color"]){
        this.color=personaData["color"];
    }else{

        if(this.objectId==5925){
            this.color="#29abe2"
        }else
        if(this.objectId==5313){
            this.color="#2ec3bf"
        }else
        if(this.objectId==3272){
            this.color="#7e45dc"
        }else
        if(this.objectId==3273){
            this.color="#f13759"
        }else if (this.objectId==3280){
            this.color="#f4a401"
        }else if (this.objectId==3238){
            this.color="#2ec3bf"
        }else if (this.objectId==5522){
            this.color="#f5a502"
        }else{
            this.color="#29abe2"
        }
    }


}


