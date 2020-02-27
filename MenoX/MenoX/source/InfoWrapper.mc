class InfoWrapper {
	hidden var info;
	hidden var normalizedPower;
	
	function setNormalizedPower(normalizedPower) {
		self.normalizedPower = normalizedPower;
	}
	
	function updateInfo(info) {
		self.info = info;
	}
	
	function isReady() {
		return info != null;
	}
	
	function getNormalizedPower() {
		return normalizedPower == null ? null : normalizedPower.format("%.0f");
	}
	
	function getCurrentHeartRate() {
		return info.currentHeartRate == null ? null : info.currentHeartRate.format("%.0f");
	}
	
	function getAverageHeartRate() {
		return info.averageHeartRate == null ? null : info.averageHeartRate.format("%.0f");
	}

	function getCurrentSpeed() {
		return info.currentSpeed == null ? null : info.currentSpeed.format("%.1f");
	}
	
	function getAverageSpeed() {
		return info.averageSpeed == null ? null : info.averageSpeed.format("%.1f");
	}
	
	function getCurrentPower() {
		return info.currentPower == null ? null : info.currentPower.format("%.0f");
	}
	
	function getAveragePower() {
		return info.averagePower == null ? null : info.averagePower.format("%.0f");
	}

	function getCurrentCadence() {
		return info.currentCadence == null ? null : info.currentCadence.format("%.0f");
	}
	
	function getAverageCadence() {
		return info.averageCadence == null ? null : info.averageCadence.format("%.0f");
	}
	
	function getWallClockTime() {
		var time  = System.getClockTime();
		return time.hour.format("%02d") + ":" + time.min.format("%02d");
	}
	
	function getSessionTime() {
		if (info == null || info.timerTime == null) {
			return null;
		}
		
		if (info.timerState < 3) {
			switch (info.timerState) {
				case Activity.TIMER_STATE_OFF: return "---";
				case Activity.TIMER_STATE_PAUSED: return "paused";
				case Activity.TIMER_STATE_STOPPED: return "stopped";
			}
		}
		
		var time = info.timerTime;
		var seconds = (time / 1000) % 60 ;
		var minutes = (time / (1000 * 60)) % 60;
		var hours = ((time / (1000 * 60 * 60)) % 24);
		
		return hours.format("%02d") + ":" + minutes.format("%02d") + ":" + seconds.format("%02d");
	}
	
}