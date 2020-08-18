importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/4.8.1/firebase-messaging.js');
 
// Initialize Firebase
var config = {
    apiKey: "AIzaSyDDYOCHCJe-_sOTVkVo-Hi63oRTE1dVlgs",
    authDomain: "donataboard-mangchi-project.firebaseapp.com",
    databaseURL: "https://donataboard-mangchi-project.firebaseio.com",
    projectId: "donataboard-mangchi-project",
    storageBucket: "donataboard-mangchi-project.appspot.com",
    messagingSenderId: "178872893699",
    appId: "1:178872893699:web:94f9afe628778e2ad1a936",
    measurementId: "G-N8HPT4GQ8G"
};
firebase.initializeApp(config);
 
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function(payload){
 
    const title = "Hello World";
    const options = {
            body: payload.data.status
    };
 
    return self.registration.showNotification(title,options);
});
