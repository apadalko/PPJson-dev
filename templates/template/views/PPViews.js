
/* *********************************************************************************** */
/* ********************************** PPPostDetailsPostView ************************** */
/* *********************************************************************************** */

function PPPostDetailsPostView(pppost) {


    this.mainDiv = document.createElement("div");
    this.mainDiv.className = "post-details-post";
    this.mainDiv.style.width = "calc(100%-20px)"


    var contentViewDiv = document.createElement("div");
    contentViewDiv.className = "post-details-post-content";
    this.mainDiv.appendChild(contentViewDiv);
    contentViewDiv.appendChild(this.buildUserProfileDiv(pppost.fromUser));


    if (pppost.textContent.length > 0) {
        var contentTextDiv = document.createElement("div");
        contentTextDiv.id = "text-reply-section";
        contentTextDiv.innerHTML = pppost.textContent;
        contentTextDiv.style.textAlign = "left";
        contentTextDiv.style.float = "left";
        contentTextDiv.style.paddingTop = "14px";
        contentViewDiv.appendChild(contentTextDiv);
        contentTextDiv.style.fontSize = "18px";
    }


    {
        var breakDiv = document.createElement("div");

        breakDiv.style.width = "100%";
        breakDiv.style.height = "7px";
        breakDiv.style.float = "left";
        contentViewDiv.appendChild(breakDiv);
    }


    if (pppost.contentType > 0 && pppost.content != null) {

        var contentMediaHolderDiv = document.createElement("div");
        contentMediaHolderDiv.className="content-media-holder-div";
        contentViewDiv.appendChild(contentMediaHolderDiv);

        var type = "img";

        if(pppost.content.type==2){
            type="video";
        }

        var mediaDiv = document.createElement(type);
        mediaDiv.id = "post-details-media";
        mediaDiv.src = pppost.content.mediaUrl;
        contentMediaHolderDiv.appendChild(mediaDiv);


        if(pppost.content.type==2){

            mediaDiv.style.cursor = 'pointer';
            var playButton= document.createElement("div");
            playButton.className="play-button";
            contentMediaHolderDiv.appendChild(playButton);
            mediaDiv.loop=true;
            mediaDiv.onclick = function(){
                if (mediaDiv.paused)
                {
                    mediaDiv.play();
                    playButton.hidden="true";
                }else{
                    mediaDiv.pause();
                    playButton.hidden=false;
                }
            };
        }


    }


    {
        var breakDiv = document.createElement("div");

        breakDiv.style.width = "100%";
        breakDiv.style.height = 10 + "px";
        breakDiv.style.float = "left";

        contentViewDiv.appendChild(breakDiv);
    }
    var footer = this.buildFooter(pppost.timestamp, pppost.repliesCount, pppost.score);

    footer.style.paddingLeft = "-10px";
    contentViewDiv.appendChild(footer);

}


PPPostDetailsPostView.prototype.buildUserProfileDiv = function(user){

    var  ava = user.profilePicture?user.profilePicture:"/template/assets/images/gm_profile@2x.png";

    var  div = document.createElement("div");
    div.style.height="50px";
    div.style.width="250px";

    var  profPictureDiv = createImageElement("",50,50,0);

    if (user.userType!=1){
        profPictureDiv.style.borderRadius="25px";
        profPictureDiv.style.overflow="hidden";
    }


    profPictureDiv.src = ava;
    profPictureDiv.style.float="left";
    div.appendChild(profPictureDiv);

    var usernameKarmaContainerDiv = document.createElement("div");
    usernameKarmaContainerDiv.innerHTML='<span class="mueso500_16">@'+user.username+'</span> <span class="mueso500_14" style="color: #b2b2b2"><br>'+user.karma+'cred</span>';
    usernameKarmaContainerDiv.className="username-karma-container-div";
    div.appendChild(usernameKarmaContainerDiv);

    return div;

}

PPPostDetailsPostView.prototype.buildFooter = function(timeStamp,repliesCount,score){

    var  div = document.createElement("div");
    div.style.display="block";
    div.style.height="15px";
    div.style.display="flex";
    div.style. position="relative";
    div.style.width="100%";

    var timestampDiv = createTimestamp();
    // timestampDiv.className = "timestamp";
    timestampDiv.style.marginLeft="-5px";
    timestampDiv.innerHTML=humanTimestamp(timeStamp);
    div.appendChild(timestampDiv);


    {

        var footerRightDiv = document.createElement("div");
        footerRightDiv.id="footer-element";
        footerRightDiv.style.right=0;
        footerRightDiv.style.backgroundColor="#asdas2";
        div.appendChild(footerRightDiv);



        if (repliesCount > 0 ) {
            var repliesCounterDiv = createFooterTextElement(""+repliesCount);
            repliesCounterDiv.className="replies-counter-div";
            footerRightDiv.appendChild(repliesCounterDiv);

            var  r = createFooterImageElement("/template/assets/images/web_reply@2x.png",15,11);
            r.style.paddingTop=3+"px";
            r.style.paddingLeft=3+"px";
            footerRightDiv.appendChild( r);
        }



        footerRightDiv.onclick=function () {
            var  dp= new PPDownloadPopUp(document.getElementById("bbb"));
        }
        footerRightDiv.style.cursor="pointer";

        ////vote controll
        //
        var leftVoteControllArrow = createFooterImageElement("/template/assets/images/web_vote_up@2x.png",16,8);
        leftVoteControllArrow.style.paddingLeft=36+"px";
        leftVoteControllArrow.style.paddingRight=7+"px";
        leftVoteControllArrow.style.paddingTop=5+"px";
        footerRightDiv.appendChild(leftVoteControllArrow)

        var voteControlCounter = createFooterTextElement(""+(score));
        voteControlCounter.style.paddingRight=7+"px";
        if (score < 0) {
            voteControlCounter.style.color="#f2385a";
        } else if (score > 0) {
            voteControlCounter.style.color="#10d6d2";
        } else {
            voteControlCounter.style.color="#b2b2b2";
        }
        voteControlCounter.style.paddingTop=3+"px";


        footerRightDiv.appendChild(voteControlCounter);

        var  rightVoteArrow =createFooterImageElement("/template/assets/images/web_vote_down@2x.png",16,8);
        rightVoteArrow.style.paddingTop=5+"px";
        footerRightDiv.appendChild(rightVoteArrow);

    }

    return div;


}
/* *********************************************************************************** */
/* ********************************** END PPPostDetailsPostView ********************** */
/* *********************************************************************************** */





/* *********************************************************************************** */
/* ********************************** PPPostDetailsReplyView ************************* */
/* *********************************************************************************** */
function PPPostDetailsReplyView(reply){

    this.mainDiv = document.createElement("div");
    this.mainDiv.className="post-details-reply-holder-wrapper";

    var holder = document.createElement("div");
    holder.className="post-details-reply-holder";

    this.mainDiv.appendChild(holder);

    var  profpic = this.buildUserProfileDiv(reply.fromUser);
    profpic.style.paddingTop="5px";
    holder.appendChild(profpic);

    var  replyBubble =document.createElement("div");
    replyBubble.className="post-details-reply-content";
    this.mainDiv.appendChild(replyBubble);
    replyBubble.style.marginLeft="10px";
    replyBubble.style.paddingBottom="2px";

    var  replyContent = document.createElement("div");
    replyContent.className="post-details-reply-content-content";
    replyBubble.appendChild(replyContent)


    if(reply.contentType > 0 && reply.content!=null){
        var contentMediaHolderDiv = document.createElement("div");
        contentMediaHolderDiv.className="content-media-holder-div";
        replyContent.appendChild(contentMediaHolderDiv);

        var type = "img";

        if(reply.content.type==2){
            type="video";
        }
        var mediaDiv = document.createElement(type);
        mediaDiv.id = "post-details-media";
        mediaDiv.style.borderRadius=    "0px 6px 0px 0px";
        mediaDiv.src = reply.content.mediaUrl;

        contentMediaHolderDiv.appendChild(mediaDiv)

        if(reply.content.type==2){
            mediaDiv.style.cursor = 'pointer';
            var playButton= document.createElement("div");
            playButton.className="play-button";
            contentMediaHolderDiv.appendChild(playButton);
            mediaDiv.loop=true;
            mediaDiv.onclick = function(){
                if (mediaDiv.paused)
                {
                    mediaDiv.play();
                    playButton.hidden="true";
                    ///
                }else{
                    mediaDiv.pause();
                    playButton.hidden=false;

                    ///
                }
            };
        }




    }else{

        var contentTextDiv = document.createElement("div");
        contentTextDiv.id="text-reply-section";
        contentTextDiv.innerHTML=reply.textContent;
        contentTextDiv.style.textAlign="left";
        contentTextDiv.style.float="left";
        contentTextDiv.style.paddingTop="10px";
        contentTextDiv.style.paddingLeft="10px";
        contentTextDiv.style.paddingRight="10px";
        contentTextDiv.style.fontSize="15px";

        replyContent.appendChild(contentTextDiv);
    }


    var  footer = this.buildFooter(reply.fromUser.username,reply.timestamp,reply.score);

    footer.style.paddingTop="10px";
    replyBubble.appendChild(footer);

}

PPPostDetailsReplyView.prototype.buildUserProfileDiv = function(user) {

    var  ava = user.profilePicture?user.profilePicture:"/template/assets/images/gm_profile@2x.png";
    var div = document.createElement("div");
    div.style.height = "50px";
    div.style.minWidth = "50px";


    var profPictureDiv = createImageElement(ava, 50, 50, 0);

    if(user.userType!=1){
        profPictureDiv.style.borderRadius = "25px";
        profPictureDiv.style.overflow = "hidden";
    }

    profPictureDiv.src = ava;
    profPictureDiv.style.float = "left";

    div.appendChild(profPictureDiv);

    return div;
}



PPPostDetailsReplyView.prototype.buildFooter = function(username,timeStamp, score){

    var  div = document.createElement("div");
    div.style.display="block";
    div.style.height="15px";
    div.style.display="flex";
    div.style. position="relative";
    div.style.width="100%";

    var timestampDiv = createTimestamp();
    // var timestampDiv = document.createElement("div");
    // timestampDiv.className = "timestamp";
    timestampDiv.innerHTML="@"+username+" &#8226 "+humanTimestamp(timeStamp);
    timestampDiv.style.top="0px";
    timestampDiv.style.left="10px";

    div.appendChild(timestampDiv);


    {

        var footerRightDiv = document.createElement("div");
        footerRightDiv.className="comment-footer-element";
        footerRightDiv.style.right="5px";
        footerRightDiv.style.backgroundColor="#asdas2";
        div.appendChild(footerRightDiv);


        //vote controll
        var leftVoteControllArrow = createFooterImageElement("/template/assets/images/web_vote_up@2x.png",16,8);
        leftVoteControllArrow.style.paddingLeft=36+"px";
        leftVoteControllArrow.style.paddingRight=7+"px";
        leftVoteControllArrow.style.paddingTop=2+"px";
        footerRightDiv.appendChild(leftVoteControllArrow)



        footerRightDiv.onclick=function () {
            var  dp= new PPDownloadPopUp(document.getElementById("bbb"));
        }
        footerRightDiv.style.cursor="pointer";

        var voteControlCounter = createFooterTextElement(""+(score));
        voteControlCounter.style.paddingRight=7+"px";
        if (score < 0) {
            voteControlCounter.style.color="#f2385a";
        } else if (score > 0) {
            voteControlCounter.style.color="#10d6d2";
        } else {
            voteControlCounter.style.color="#b2b2b2";
        }

        footerRightDiv.appendChild(voteControlCounter);

        var  rightVoteArrow =createFooterImageElement("/template/assets/images/web_vote_down@2x.png",16,8);

        rightVoteArrow.style.paddingTop=2+"px";
        rightVoteArrow.style.marginRight=5+"px";

        footerRightDiv.appendChild(rightVoteArrow);
    }

    return div;


}
/* *********************************************************************************** */
/* ****************************** END PPPostDetailsReplyView ************************* */
/* *********************************************************************************** */





/* *********************************************************************************** */
/* ********************************** PPPostsListPostView **************************** */
/* *********************************************************************************** */
function PPPostsListPostView (pppost){

    this.mainDiv = document.createElement("div");
    this.mainDiv.id="post";
    this.mainDiv.style.boxShadow=" 0px 2px 4px rgba(0, 0, 0, 0.2)";


    var leftDiv = document.createElement("div");
    leftDiv.id = "post-left";

    var  ava = pppost.fromUser.profilePicture?pppost.fromUser.profilePicture:"/template/assets/images/gm_profile@2x.png";

    if (pppost.fromUser.userType==1){
        leftDiv.innerHTML='<image src ='+ava + ' height="50px" width="50px">';
    }else{
        leftDiv.innerHTML='<image src ='+ava + ' height="50px" width="50px" style=" border-radius:25px; overflow: hidden;">';
    }

    this.mainDiv.appendChild(leftDiv);


    var rightDiv = document.createElement("div");
    rightDiv.id = "post-right";
    this.mainDiv.appendChild(rightDiv);

    var rightContentDiv = document.createElement("div");
    rightContentDiv.id="post-content";
    rightDiv.appendChild(rightContentDiv);

    var rightContentTextDiv;
    if(pppost.textContent.length>0){
        rightContentTextDiv = document.createElement("div");
        rightContentTextDiv.id="text-reply-section";
        rightContentTextDiv.innerHTML=pppost.textContent;
        rightContentDiv.appendChild(rightContentTextDiv);
        rightContentDiv.style.marginTop="6px";
    }
    if(pppost.contentType>0&&pppost.content!=null){

        var contentMediaHolderDiv = document.createElement("div");
        contentMediaHolderDiv.className = "content-media-holder-div";
        contentMediaHolderDiv.style.marginTop="7px";
        rightContentDiv.appendChild(contentMediaHolderDiv);

        var type = "img";

        if(pppost.content.type==2){
            type="video";
        }
        var mediaDiv = document.createElement(type);
        mediaDiv.id = "post-details-media";
        mediaDiv.style.borderRadius=    "6px 6px 6px 6px";
        mediaDiv.src = pppost.content.mediaUrl;
        contentMediaHolderDiv.appendChild(mediaDiv)

        if(pppost.content.type==2) {

            var playButton = document.createElement("div");
            playButton.className = "play-button";
            contentMediaHolderDiv.appendChild(playButton);
        }
    }


    var footerDiv = document.createElement("div");
    footerDiv.id="footer-section";
    rightDiv.appendChild(footerDiv);

    //username
    var  usernameDiv = document.createElement("div");
    usernameDiv.id ="footer-element";
    usernameDiv.className="username";
    // usernameDiv.style.float="left";
    usernameDiv.innerHTML="@"+pppost.fromUser.username;
    footerDiv.appendChild(usernameDiv);



    // var footer right
    var footerRightDiv = document.createElement("div");
    footerRightDiv.id="footer-element";
    footerRightDiv.style.right=0;
    footerRightDiv.style.backgroundColor="#asdas2";
    footerDiv.appendChild(footerRightDiv);



    if (pppost.repliesCount > 0 ) {
        var repliesCounterDiv = createFooterTextElement(""+pppost.repliesCount);
        repliesCounterDiv.className="replies-counter-div";
        footerRightDiv.appendChild(repliesCounterDiv);

        var  r = createFooterImageElement("/template/assets/images/web_reply@2x.png",15,11);
        r.style.paddingTop=3+"px";
        r.style.paddingLeft=3+"px";
        footerRightDiv.appendChild( r);
    }


    //vote controll
    var leftVoteControllArrow = createVoteControllImage("/template/assets/images/web_vote_up@2x.png",16,8);
    leftVoteControllArrow.style.paddingLeft=36+"px";
    leftVoteControllArrow.style.paddingRight=7+"px";
    footerRightDiv.appendChild(leftVoteControllArrow)


    footerRightDiv.onclick=function (e) {
        var  dp= new PPDownloadPopUp(document.getElementById("bbb"));
        e.stopPropagation();
    }
    footerRightDiv.style.cursor="pointer";


    var voteControlCounter = createFooterTextElement(""+(pppost.likes+pppost.dislikes));
    voteControlCounter.style.paddingRight=7+"px";
    if (pppost.score < 0) {
        voteControlCounter.style.color="#f2385a";
    } else if (pppost.score > 0) {
        voteControlCounter.style.color="#10d6d2";
    } else {
        voteControlCounter.style.color="#b2b2b2";
    }
    voteControlCounter.style.paddingTop=3+"px";

    footerRightDiv.appendChild(voteControlCounter);
    footerRightDiv.appendChild(createVoteControllImage("/template/assets/images/web_vote_down@2x.png",16,8));
}

function createFooterTextElement(text){

    var element = document.createElement("div");
    element.style.float="left";
    element.style.lineHeight="100%";
    element.innerHTML=text;
    element.style.fontFamily="MuseoSansRounded-500";
    element.style.fontSize="12px";
    return element;
}
function createFooterImageElement(imagename,width,height){

    var element = document.createElement("img");
    element.style.position="relative";
    element.style.float="left";
    element.style.width=width+"px";
    element.style.height=height+"px";
    element.src=imagename
    return element;
}

function createVoteControllImage(imagename,width,height){

    var  element = createFooterImageElement(imagename,width,height);
    element.style.transform="translateY(50%)";
    element.style.lineHeight="100%";

    return element;
}

function createTimestamp () {
    this.timestampDiv = document.createElement("div");
    this.timestampDiv.className = "timestamp";
    return this.timestampDiv;
}

/* *********************************************************************************** */
/* ********************************** END PPPostsListPostView ************************ */
/* *********************************************************************************** */