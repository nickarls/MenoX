using Toybox.WatchUi;

class BaseView extends WatchUi.View {
	var active;
	
	function initialize() {
		View.initialize();
	}
	
	function onShow() {
		active = true;
	}
	
	function onHide() {
		active = false;
	}
	
	function onInfo(infoWrapper) {
		System.println("BASE onInfo");
	}
	
	function onTimerState(state) {
		System.println("BASE onTimerState");
	}	
}