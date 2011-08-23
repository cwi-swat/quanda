package nl.cwi.swat.quanda.ctl;

import nl.cwi.swat.quanda.data.Expression;
import nl.cwi.swat.quanda.data.Node;
import nl.cwi.swat.quanda.data.Variable;


public class Source extends Node {

	private final Variable var;
	private final Expression cond;
	private boolean enabled;

	public Source(Variable var, Expression cond) {
		this.var = var;
		this.cond = cond;
	}
	
	public void onChange(Object x) {
		var.assign(-1, x);
	}

	@Override
	protected void update(int n) {
		Object c = cond.getValue(n);
		setEnabled(c != null && c.equals(true));
	}

	private void setEnabled(boolean enabled) {
		this.enabled = true;
	}
	
	
	public Source copy() {
		Variable v2 = var.copy();
		Source s = new Source(v2, cond);
		cond.addDependent(s);
		return s;
	}

	public Variable getVariable() {
		return var;
	}
	
}
