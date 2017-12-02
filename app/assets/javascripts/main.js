console.log("main.js");

$(document).ready(function() {
  function hasGetUserMedia() {
    return !!(navigator.getUserMedia || navigator.webkitGetUserMedia ||
            navigator.mozGetUserMedia || navigator.msGetUserMedia);
  }
  if (hasGetUserMedia()) {
    console.log("Good to go!");
    $(".lunch-local-camera").remove();
  } else {
    // alert('getUserMedia() is not supported in your browser');
    console.log("Not supported");
    $(".chromeBrowser").remove();
    $(".mobile").removeClass("display-none");
  }


  $(".lunch-local-camera").click(function(){
    $("#file-input").trigger('click');
  });

  $("#submit").click(function(){
    $(this).hide();
  });
});


// HD constraints
var constraints = {
  audio: true,
  video: {
    mandatory: {
      minWidth: 1280,
      minHeight: 720
    }
  }
};

var errorCallback = function(e) {
  console.log('Reeeejected!', e);
};

var mediaRecorder;
var chunks = [];

function startRecording(stream) {
  console.log('Start recording...');

  mediaRecorder = new MediaRecorder(stream);
  mediaRecorder.start(1000);
  var video = document.querySelector('video');
  video.src = window.URL.createObjectURL(stream);


  mediaRecorder.ondataavailable = function(e) {
    console.log('Data available...', e.data.type, e.data.size, e.data);
    chunks.push(e.data);
    video.muted = true;
  };

  mediaRecorder.onerror = function(e){
    console.log('Error: ' + e);
    console.log('Error: ', e);
  };

  mediaRecorder.onstart = function(){
    console.log('Started & state = ' + mediaRecorder.state);
  };

  mediaRecorder.onstop = function(){
    console.log('Stopped  & state = ' + mediaRecorder.state);
    video.muted = false;
    blob = new Blob(chunks, {type: "video/webm"});
    chunks = [];
    var videoURL = window.URL.createObjectURL(blob);
    video.src = videoURL;
  };
}


function onBtnRecordClicked (){
   if (typeof MediaRecorder === 'undefined' || !navigator.getUserMedia) {
    alert('MediaRecorder not supported on your browser, use Firefox 30 or Chrome 49 instead.');
  }else {
    navigator.getUserMedia(constraints, startRecording, errorCallback);
    $("#stop").removeClass( "disable-buttons" ).addClass( "buttons" );
    $("#rec").removeClass( "buttons" ).addClass( "disable-buttons" );
    $("#send").removeClass( "buttons" ).addClass( "disable-buttons" );
  }
}

function onBtnStopClicked(){
  mediaRecorder.stop();
  video.controls = true;
  $("#stop").removeClass( "buttons" ).addClass( "disable-buttons" );
  $("#rec").removeClass( "disable-buttons" ).addClass( "buttons" );
  $("#send").removeClass( "disable-buttons" ).addClass( "buttons" );
}

function onBtnSendClicked(id){
  $(".campaigns").addClass("display-none");
  $(".sending").addClass("display-block");
  $("#center-buttons").addClass("display-none");
  $(".video-container").addClass("display-none");
  $("#uploading").removeClass("display-none").addClass("display-block");

  var rand =  Math.floor((Math.random() * 10000000));
  var fd = new FormData();

  fd.append('webmasterfile', blob);
  fd.append("title", "video_"+rand+".webm");
  fd.append("description", "SnapThank");
  fd.append("donor_id", id);
  video.src = "";
  $.ajax({
    type: 'POST',
    // url: 'https://snapthank.herokuapp.com/videos',
    url: 'http://localhost:3000/videos',
    data: fd,
    processData: false,
    contentType: false,
    success: function(data){
      video.src = "";
      console.log("SUCCESS");
    },
    error: function(data){
      video.src = "";
      console.log(data);
      uploadError();
    }
  });

  var uploadError = function(){
    console.log("Error");
    $(".sending").removeClass("display-block").addClass("display-none");
    $("#uploading").removeClass("display-block").addClass("display-none");
    $(".error-message").append("<div class='message'><h1>Something wrong happened</h1><a href='/logout'><button class='send'><h2>Try Again</h2></button></a><h2>Make sure that you have a YouTube channel.</div>");
  };
}







