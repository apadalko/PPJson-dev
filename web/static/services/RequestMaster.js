/**
 * Created by alexpadalko on 8/18/16.
 */

function GET_REQUEST(url,callBack){
    xhr = new XMLHttpRequest();
    xhr.onreadystatechange = function (e) {
        if (xhr.readyState == 4 && xhr.status == 200) {
            callBack(xhr.responseText);
        }
    }
    xhr.open("GET", url, true);
    xhr.setRequestHeader('Content-type', 'text/html');
    xhr.send();

}
