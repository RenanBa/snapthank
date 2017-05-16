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
var count = 0;

function startRecording(stream) {
  console.log('Start recording...');

  mediaRecorder = new MediaRecorder(stream);

  mediaRecorder.start(10);

  var video = document.querySelector('video');
  video.src = window.URL.createObjectURL(stream);
  // var url = window.URL || window.webkitURL;
  // videoElement.src = url ? url.createObjectURL(stream) : stream;
  // videoElement.play();

  mediaRecorder.ondataavailable = function(e) {
    //log('Data available...');
    // console.log(e.data);
    // console.log(e.data.type);
    // console.log(e);
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

    var blob = new Blob(chunks, {type: "video/webm"});
    chunks = [];

    var videoURL = window.URL.createObjectURL(blob);

    // downloadLink.href = videoURL;
    // videoElement.src = videoURL;
    video.src = videoURL

    // downloadLink.innerHTML = 'Download video file';

    var rand =  Math.floor((Math.random() * 10000000));
    var name  = "video_"+rand+".webm" ;

    // downloadLink.setAttribute( "download", name);
    // downloadLink.setAttribute( "name", name);
  };
}




function onBtnRecordClicked (){
   if (typeof MediaRecorder === 'undefined' || !navigator.getUserMedia) {
    alert('MediaRecorder not supported on your browser, use Firefox 30 or Chrome 49 instead.');
  }else {
    navigator.getUserMedia(constraints, startRecording, errorCallback);
    // recBtn.disabled = true;
    // pauseResBtn.disabled = false;
    // stopBtn.disabled = false;
  }
}

function onBtnStopClicked(){
  mediaRecorder.stop();
  video.controls = true;

  // recBtn.disabled = false;
  // pauseResBtn.disabled = true;
  // stopBtn.disabled = true;
}
