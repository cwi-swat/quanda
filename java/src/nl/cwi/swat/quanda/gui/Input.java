package nl.cwi.swat.quanda.gui;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Notifiable;
import nl.cwi.swat.quanda.data.Variable;


public class Input extends Node implements Notifiable {

	private Variable var;
	private Expression cond;
	
	public Input(Variable var, Expression cond) {
		this.var = var;
		this.cond = cond;
		cond.addDependent(this);
	}

	@Override
	public void notify(int n) {
		Object c = cond.getValue(n);
		setEnabled(c != null && c.equals(true));
	}

	private void setEnabled(boolean b) {
		// TODO Auto-generated method stub
		
	}
	
	
	
	
}
