/**
 * 
 */
$("#sendBtn").click(function () {
    sendMessage();
    $('#message').val('');
    $('#message').focus();
});

let sock = new SockJS("http://localhost:8080/mc-chat/echo/");
sock.onmessage
console.log(sock);
sock.onmessage = onMessage;
sock.onclose = onClose;
// 메시지 전송
function sendMessage() {
    sock.send('${loginInfo.nick}&12&유저1')
    //sock.send('${loginInfo.nick},' + $("#message").val());
}
// 서버로부터 메시지를 받았을 때
function onMessage(msg) {
    var data = msg.data;
    console.log(data);
    //$("#messageArea").append(data + "<br/>");
}
// 서버와 연결을 끊었을 때
function onClose(evt) {
    //$("#messageArea").append("연결 끊김");

}