/**
 * Created by sventevit on 7/8/16.
 */

/* *********************************************************************************** */
/* ***************************************** PopUp *********************************** */
/* *********************************************************************************** */

 function PopUp (holder,title) {

     this.holder = holder;

     this.div = document.createElement("div");
     this.div.className = "popup-overlay";

     this.holder.appendChild(this.div);


     this.contentDiv = document.createElement("div")
     this.contentDiv.className = "popup-div";
     this.div.appendChild(this.contentDiv);

     var navigationDiv = this.buildNavigationBar(title);
     navigationDiv.className = "popup-navigation-bar";
     this.contentDiv.appendChild(navigationDiv);
 }

PopUp.prototype.onCloseButton = function(){

    this.holder.removeChild(this.div);
    if(this.closeListener!=null)
        this.closeListener();

}
PopUp.prototype.addCloseListener = function(closeListener){
    this.closeListener=closeListener;
}

PopUp.prototype.buildNavigationBar=function(title) {
   var  navBarDiv = document.createElement("div");
   navBarDiv.className="popup-navigation-bar ";

   var  closeButton =    createImageElement("template/assets/images/gm_x@2x.png",27,27);
   closeButton.className = "popup-close-button";
   navBarDiv.appendChild(closeButton);

    var textDiv = document.createElement("div");
    textDiv.className="popup-navigation-bar-title";
    textDiv.style.width="calc(100% - 100px)"
    textDiv.innerHTML=title;
    navBarDiv.appendChild(textDiv);

    closeButton.onclick=function(){
        this.onCloseButton();
    }.bind(this);

   return navBarDiv;
}
function createImageElement(imagename,width,height){

   var element = document.createElement("img");
   element.style.width=width+"px";
   element.style.height=height+"px";
   element.src=imagename;

   return element;
}





/* *********************************************************************************** */
/* ***************************************** PPSharePopUp **************************** */
/* *********************************************************************************** */

function PPSharePopUp (div,title,linkToShare) {
    PopUp.call(this,div,title);
    var personaFace = document.createElement("img");
    personaFace.className="persona-share-face";
    personaFace.src="template/assets/images/lb_tiny_superhappy@2x.png";
    this.contentDiv.appendChild(personaFace);

    var textInputHolder = document.createElement("div");
    textInputHolder.className = "popup-share-text-input-holder";

    var  textInput = document.createElement("input");
    textInputHolder.appendChild(textInput);
    textInput.style.textAlign="center";
    textInput.value=linkToShare;
    this.contentDiv.appendChild(textInputHolder);

    textInput.setSelectionRange(0, textInput.value.length)
    textInput.disabled=true;

    this.contentDiv.onclick=function(){

        textInput.setSelectionRange(0, textInput.value.length)
    }.bind(this);

    var bodyFooterTitle = document.createElement("div");

    bodyFooterTitle.className = "popup-body-text";
    bodyFooterTitle.innerHTML="Just copy + paste the link to share this map with your friends!";

    this.contentDiv.appendChild(bodyFooterTitle);

    var spacer = document.createElement("div");
    spacer.style.paddingTop="30px"
    spacer.style.width="100%";
    spacer.style.height="1px";
    this.contentDiv.appendChild(spacer);
}
PPSharePopUp.prototype = Object.create(PopUp.prototype);



/* *********************************************************************************** */
/* ************************************** PPDownloadPopUp **************************** */
/* *********************************************************************************** */

function PPDownloadPopUp (div) {
    PopUp.call(this,div,"Download Gabbermap to join the conversation");

    var bodyTitle = document.createElement("div");
    bodyTitle.className = "popup-body-text";
    bodyTitle.innerHTML="Send a download link";
    this.contentDiv.appendChild(bodyTitle);

    var inputHolderDiv = document.createElement("div");
    inputHolderDiv.className="popup-download-input-holder";

    this.inputDiv = document.createElement("input");
    this.inputDiv.id="phone";
    this.inputDiv.style.height="45px";
    this.inputDiv.style.width="303px";
    this.inputDiv.placeholder="Enter phone number";

    inputHolderDiv.appendChild(   this.inputDiv);

    this.sendButton = document.createElement("div");

    this.sendButton.className="popup-download-send-button";
    this.sendButton.innerHTML="SEND";
    inputHolderDiv.appendChild(this.sendButton);

    this.contentDiv.appendChild(inputHolderDiv);


    this.invalidPhoneNumber= document.createElement("div");
    this.invalidPhoneNumber.className = "popup-body-text";
    this.invalidPhoneNumber.style.paddingTop="5px"
    this.invalidPhoneNumber.style.color="#f13759";
    this.invalidPhoneNumber.innerHTML="Invalid phone number";
    this.invalidPhoneNumber.style.fontFamily="MuseoSansRounded-300";
    this.invalidPhoneNumber.hidden=true;
    this.contentDiv.appendChild(this.invalidPhoneNumber);

    var bodyFooterTitle = document.createElement("div");

    bodyFooterTitle.className = "popup-body-text";
    bodyFooterTitle.innerHTML="Or visit the App Store";

    this.contentDiv.appendChild(bodyFooterTitle);


    var  downloadFromAppstore = document.createElement("img");
    downloadFromAppstore.className="download-from-appstore-image";
    downloadFromAppstore.src = 'template/assets/images/gm_appstore@2x.png';
    this.contentDiv.appendChild(downloadFromAppstore);

    downloadFromAppstore.onclick=function(){

        var win = window.open("https://bnc.lt/Jt4k/vuNjXPBHXu", '_blank');
        win.focus();
        this.onCloseButton();

    }.bind(this);

    this.sendButton.onclick=function(){

        this.onSendButton();

    }.bind(this);


    setTimeout(function(){
        this.inputDiv.focus();
    }.bind(this),200)
}
(function(b,r,a,n,c,h,_,s,d,k){if(!b[n]||!b[n]._q){for(;s<_.length;)c(h,_[s++]);d=r.createElement(a);d.async=1;d.src="https://cdn.branch.io/branch-latest.min.js";k=r.getElementsByTagName(a)[0];k.parentNode.insertBefore(d,k);b[n]=h}})(window,document,"script","branch",function(b,r){b[r]=function(){b._q.push([r,arguments])}},{_q:[],_v:1},"addListener applyCode banner closeBanner creditHistory credits data deepview deepviewCta first getCode init link logout redeem referrals removeListener sendSMS setIdentity track validateCode".split(" "), 0);
branch.init('key_live_adeXdQg9vnbM5avErsIP3beoCxoP55o5');


PPDownloadPopUp.prototype = Object.create(PopUp.prototype);
PPDownloadPopUp.prototype.onSendButton=function(){



    var phone = this.inputDiv.value;
    var linkData = {
        tags: [],
        channel: 'Website',
        feature: 'download',
        $ios_url: 'gabbermap://',
        data: {
            $gm_source:"website",
            $gm_source_type:"download_gabbermap"
        },
        $gm_source:"website",
        $gm_source_type:"download_gabbermap"
    };
    var options = {};
    var callback = function(err, result) {
        if (err) {
            this.invalidPhoneNumber.hidden=false;
            if(err.message==("Error in API: 400")){
                this.invalidPhoneNumber.innerHTML="Invalid phone number";
            }else{
                this.invalidPhoneNumber.innerHTML="Something went wrong :( Please try again later!";
            }

        }
        else {
            this.invalidPhoneNumber.hidden=true;
            console.log("SUC");
            this.sendButton.disabled=true;
            this.sendButton.innerHTML="SENT!";
            this.sendButton.style.backgroundColor="#2ecc71";

        }
    }.bind(this);
    branch.sendSMS(phone, linkData, options, callback);

}


/* *********************************************************************************** */
/* ************************************** PPFeedBackPopUp **************************** */
/* *********************************************************************************** */

function PPFeedBackPopUp (div) {
    PopUp.call(this,div,"Send feedback");

    var personaAndTextHolder = document.createElement("div");
    personaAndTextHolder.className = "feedback-popup";
    this.contentDiv.appendChild(personaAndTextHolder);

    var personaFace = document.createElement("div");
    personaFace.className="persona-feedback-face";
    personaFace.src="face.png";
    personaAndTextHolder.appendChild(personaFace);

    var textDescription = document.createElement("div");
    textDescription.className = "popup-share-text-description";
    textDescription.innerHTML = "Have any content / feature suggestions? Found a bug?" +
        " Or just want to say hello? We’d love to hear from you!";
    personaAndTextHolder.appendChild(textDescription);

    var textArea = document.createElement("textarea");
    textArea.className = "feedback-textarea";
    textArea.rows="10";
    textArea.cols="80";
    textArea.placeholder="Type away my friend!";
    textArea.resize="none";
    textArea.maxLength="500";
    this.contentDiv.appendChild(textArea);


    var footerHolder = document.createElement("div");
    footerHolder.className = "feedback-footer";
    this.contentDiv.appendChild(footerHolder);

    var footerText = document.createElement("div");
    footerText.className = "popup-share-text-description";
    footerText.style.lineHeight="40px";
    footerText.style.textAlign="center";
    footerText.style.verticalAlign="middle";
    footerText.innerHTML = "We'll get back to you as soon as we can";
    footerHolder.appendChild(footerText);


    var sendButton = document.createElement("div");
    sendButton.className = "feedback-send-button";
    sendButton.innerHTML='SEND';

    sendButton.onclick=function(){
        if(this.shareListener){
            this.shareListener(this.post);
        }
    }.bind(this);

    footerHolder.appendChild(sendButton);
}

PPFeedBackPopUp.prototype = Object.create(PopUp.prototype);