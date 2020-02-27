using Toybox.WatchUi;

class ViewHandler extends WatchUi.View {

	hidden var inputDelegate;
	hidden var views = [];
	hidden var index = 0;

	hidden var controller;

	function initialize(controller) {
		View.initialize();
		self.controller = controller;
	}
	
	function setInputDelegate(inputDelegate) {
		self.inputDelegate = inputDelegate;
	}

	function register(view) {
		views.add(view);
	}
	
	function showCurrentView() {
		switchToView(views[index], inputDelegate, WatchUi.SLIDE_IMMEDIATE);
	}
	
	function signalTimerStateChange(type) {
		var view;
		for (var i = 0; i < views.size(); i++) {
			view = views[i];
			if (view instanceof BaseView) {
				view.onTimerState(type);
			}
		}
	}

	class MenuDelegate extends WatchUi.Menu2InputDelegate {
	
		hidden var controller;
	
		function initialize(controller) {
			Menu2InputDelegate.initialize();
			self.controller = controller;
		}
	
		function onSelect(item) {
			switch (item.getId()) {
				case "save" :
					controller.save(); 
					break;
				case "discard" :
					controller.discard(); 
					break;
			}
		}
		
    	function onBack() {
        	WatchUi.popView(WatchUi.SLIDE_DOWN);
    	}

    	function onDone() {
	        WatchUi.popView(WatchUi.SLIDE_DOWN);
	    }		
	}

	function showMenu() {
        var delegate = new MenuDelegate(controller);

        var menu = new WatchUi.Menu2({:title => "Session"});
        menu.addItem(new MenuItem("Save", null, "save", null));
        menu.addItem(new MenuItem("Discard", null, "discard", null));

        WatchUi.pushView(menu, delegate, WatchUi.SLIDE_IMMEDIATE);
        return true;	
	}

	function signalInfoUpdate(infoWrapper) {
		var view;
		for (var i = 0; i < views.size(); i++) {
			view = views[i];
			if (view instanceof BaseView) {
				view.onInfo(infoWrapper);
			}
		}
	}
	
	function nextPage() {
		if (index == views.size() - 1) {
			index = 0;
		} else {
			index++;
		}
		showCurrentView();
	}
	
	function previousPage() {
		if (index == 0) {
			index = views.size() - 1;
		} else {
			index--;
		}
		showCurrentView();
	}
}