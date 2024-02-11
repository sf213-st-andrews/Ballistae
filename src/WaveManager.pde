// WaveManager.pde

private static int WAVE_DURATION = 600;

class WaveManager {
	public int wave;
	public int scoreMultiplier;
	public int lifetime;
	
	WaveManager() {
		this.wave = 1;
		setMultiplier();
		this.lifetime = WAVE_DURATION;
	}

	public void setMultiplier() {
		switch (wave) {
			case 1:
			case 2:
				scoreMultiplier = 1;
			break;
			
			case 3:
			case 4:
				scoreMultiplier = 2;
			break;
			
			case 5:
			case 6:
				scoreMultiplier = 3;
			break;
			
			case 7:
			case 8:
				scoreMultiplier = 4;
			break;
			
			case 9:
			case 10:
				scoreMultiplier = 5;
			break;
			
			default:
				scoreMultiplier = 6;
			break;
		}
	}

	public boolean updateWave() {
		// Returns true when a wave is done
		lifetime -= 1;
		return(lifetime <= 0);
	}

	public void nextWave() {
		wave++;
		lifetime = WAVE_DURATION;
		setMultiplier();
	}

	public boolean isPastWaveOne() {
		return (wave > 1);
	}
}
