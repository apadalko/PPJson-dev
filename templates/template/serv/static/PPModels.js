/**
 * Created by alexpadalko on 6/30/16.
 */


function PPCommentPost(commentPostData){

    this.fromUser = new PPUser(commentPostData["fromUser"]);
    this.textContent = commentPostData["textContent"];
    this.lastReplyDate = commentPostData["updateTime"];

    this.contentType = commentPostData["contentType"];
    this.content=null;
    if(this.contentType>0){
        this.content=new PPCommentContent("content");
    }


}

function PPUser(userData){
    this.username= userData["username"];
    this.objectId= userData["objectId"];
}



function PPCommentContent(commentContentData){

    this.mediaUrl = commentContentData["mediaUrl"];
    this.type=commentContentData["type"];

}