// Give the service worker access to Firebase Messaging.
// Note that you can only use Firebase Messaging here, other Firebase libraries
// are not available in the service worker.
importScripts('https://www.gstatic.com/firebasejs/6.6.0/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/5.10.1/firebase-messaging.js');
 
// Initialize Firebase
firebase.initializeApp({
    apiKey: "AIzaSyDDYOCHCJe-_sOTVkVo-Hi63oRTE1dVlgs",
    authDomain: "donataboard-mangchi-project.firebaseapp.com",
    databaseURL: "https://donataboard-mangchi-project.firebaseio.com",
    projectId: "donataboard-mangchi-project",
    storageBucket: "donataboard-mangchi-project.appspot.com",
    messagingSenderId: "178872893699",
    appId: "1:178872893699:web:94f9afe628778e2ad1a936",
    measurementId: "G-N8HPT4GQ8G"
});
 
const messaging = firebase.messaging();


//수신자 앱이 백그라운드 상태일 때 메시지 수신
messaging.setBackgroundMessageHandler(function(payload){
 
    const title = payload.notification.title;
    const options = {
            body: payload.data.status
    };
 
    return self.registration.showNotification(title,options);
});
