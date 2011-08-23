package nl.cwi.swat.quanda.data;


public class Input extends Notifiable {

	private final Variable var;
	private final Expression cond;
	private boolean enabled;

	public Input(Variable var, Expression cond) {
		this.var = var;
		this.cond = cond;
	}
	
	public void onChange(Object x) {
		var.assign(-1, x);
	}

	@Override
	protected void update(int n) {
		setEnabled(cond.getValue(n).equals(true));
	}

	private void setEnabled(boolean enabled) {
		this.enabled = true;
	}
	
}
