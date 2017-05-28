console.log("main.js");
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
  mediaRecorder.start(10);
  var video = document.querySelector('video');
  video.src = window.URL.createObjectURL(stream);

  mediaRecorder.ondataavailable = function(e) {
    //console.log('Data available...');
    chunks.push(e.data);
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

    blob = new Blob(chunks, {type: "video/webm"});
    chunks = [];
    var videoURL = window.URL.createObjectURL(blob);
    video.src = videoURL
  };
}


function onBtnRecordClicked (){
   if (typeof MediaRecorder === 'undefined' || !navigator.getUserMedia) {
    alert('MediaRecorder not supported on your browser, use Firefox 30 or Chrome 49 instead.');
  }else {
    navigator.getUserMedia(constraints, startRecording, errorCallback);
  }
}

function onBtnStopClicked(){
  mediaRecorder.stop();
  video.controls = true;
}

function onBtnSendClicked(id){
  console.log("AJAX!");

  var rand =  Math.floor((Math.random() * 10000000));
  var fd = new FormData();

  fd.append('webmasterfile', blob);
  fd.append("title", "video_"+rand+".webm");
  fd.append("description", "SnapThank");
  fd.append("donor_id", id);

  $.ajax({
      type: 'POST',
      url: 'https://snapthank.herokuapp.com/videos',
      // url: 'http://localhost:3000/videos',
      data: fd,
      processData: false,
      contentType: false
  }).done(function(data) {
         console.log(data);
  });
}

