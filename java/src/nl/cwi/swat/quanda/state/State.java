package nl.cwi.swat.quanda.state;

import nl.cwi.swat.quanda.eval.Env;
import nl.cwi.swat.quanda.model.Question;

public abstract class State {

	private Question question;
	private boolean enabled;
	
	public boolean isEnabled() {
		return enabled;
	}
	
	public void setEnabled(boolean enabled) {
		this.enabled = enabled;
	}
	
	public abstract boolean propagate(Env env);
	
	
	
}
