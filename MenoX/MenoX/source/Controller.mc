using Toybox.WatchUi;
using Toybox.Timer;
using Toybox.ActivityMonitor;

class Controller extends WatchUi.View {
	hidden var session;
	hidden var timer = new Timer.Timer();
	hidden var infoWrapper = new InfoWrapper();
	hidden var viewHandler;
		
    function initialize() {
        View.initialize();
     	initSession();   
    }
    
    hidden function initSession() {
        var options = { :name => "test", :sport => ActivityRecording.SPORT_CYCLING, :subSport => ActivityRecording.SUB_SPORT_ROAD };
        session = ActivityRecording.createSession(options);
        session.setTimerEventListener(method(:activityListener));
    }

	function setViewHandler(viewHandler) {
		self.viewHandler = viewHandler;
	}

	function isStopped() {
		return !session.isRecording();
	}

	function activityListener(type, data) {
		switch (type) {
			case ActivityRecording.TIMER_EVENT_STOP:
				timer.stop();
				break;
			case ActivityRecording.TIMER_EVENT_START:
		        timer.start(method(:timerListener), 1000, true);
				break;
		}
		viewHandler.signalTimerStateChange(type);
	}
	
	function timerListener() {
		infoWrapper.updateInfo(Activity.getActivityInfo());
		viewHandler.signalInfoUpdate(infoWrapper);
	}

    function startStop() {
    	if (session.isRecording()) {
    		session.stop();
    	} else {
    		session.start();
    	}
    }
    
    function save() {
    	System.println("saving");
    	if (session.isRecording()) {
    		session.stop();
    	}
    	session.save();
    }
    
    function discard() {
    	System.println("discarding");
    	if (session.isRecording()) {
    		session.stop();
    	}
    	session.discard();
    }
    
}
