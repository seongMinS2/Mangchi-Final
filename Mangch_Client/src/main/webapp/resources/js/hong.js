function boardList(){

	$.ajax({
		url : 'http://localhost:8080/donate/donateBoard',
		type : 'get',
		success : function(data){
			var html= '';
			for(var i=0;i<data.length; i++) {
				html+='<div class="card" style="width: 250px; height: 350px;">';
				html+='		<p>'+data[i].doLoc+'</p>';
				html+='		<img src="'+data[i].doImg+'" style="width: 100%">';
				html+='		<p>'+data[i].doTitle+'</p>';
				html+='		<p>'+data[i].doDate+'</p>';
				html+='		<p>'+data[i].doViewCnt+'</p>';
				html+='</div>';
			}
			$('#listBox').html(html);
		
		}
	});
}


$(document).ready(function(){
	boardList();
});
