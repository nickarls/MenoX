class NormalizedPower {
	hidden var sumOfPowersOfFour = 0;
	hidden var numberOfValues = 0;
	
	public function addValue(value) {
		if (value == null) {
			return;
		}
		sumOfPowersOfFour += Math.pow(value.toNumber(), 4);
		numberOfValues++;
	}
	
	public function getNP() {
		return Math.sqrt(Math.sqrt(sumOfPowersOfFour / numberOfValues.toDouble()));
	}
	
}