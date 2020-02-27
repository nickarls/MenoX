using Toybox.WatchUi;

class InputDelegate extends WatchUi.BehaviorDelegate {

	hidden var viewHandler;
	hidden var controller;
	
	function initialize(viewHandler, controller) {
		BehaviorDelegate.initialize();
		self.viewHandler = viewHandler;
		self.controller = controller;
	}
	
	function onNextPage() {
		viewHandler.nextPage();
	}
	
	function onPreviousPage() {
		viewHandler.previousPage();
	}	

   	function onKey(evt) {
   		if (evt.getKey() == 18) {
   			controller.startStop();
   		}
	}
	
	function onMenu() {
		if (controller.isStopped()) {
			viewHandler.showMenu();
		}
	}

}