package nl.cwi.swat.quanda.gui;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Notifiable;
import nl.cwi.swat.quanda.data.Variable;

public class Input extends Notifiable {

	private Variable var;
	private Expression cond;

	public Input(Variable var) {
		this.var = var;
	}
	
	public void onChange(Object x) {
		var.assign(-1, x);
	}

	@Override
	protected void update(int n) {
		setEnabled(cond.getValue(n).equals(true));
	}

	private void setEnabled(boolean enabled) {
		
	}
	
}
