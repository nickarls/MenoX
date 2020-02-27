using Toybox.Application;
using Toybox.WatchUi;

class MenoXApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
    	var controller = new Controller();
    	var viewHandler = new ViewHandler(controller);
    	controller.setViewHandler(viewHandler);
    	var inputDelegate = new InputDelegate(viewHandler, controller);
    	viewHandler.setInputDelegate(inputDelegate);
    	
    	var powerView = new PowerView();
    	viewHandler.register(powerView);
    	
    	var overviewView = new OverviewView(controller);
    	viewHandler.register(overviewView);
    	
        return [ overviewView, inputDelegate ];
    }

}
