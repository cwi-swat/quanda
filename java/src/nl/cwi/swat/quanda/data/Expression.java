package nl.cwi.swat.quanda.data;


public abstract class Expression extends Node {
	private Object value;
	
	public Object getValue(int n) {
		notify(n);
		return getValue();
	}
	
	protected Object getValue() {
		return value;
	}
	
	@Override
	public void notify(int n) {
		if (!outOfDate(n)) {
			return;
		}
		setUpToDate(n);

		Object x = getValue();
		Object y = compute(n);
		if (x == y || (x != null && x.equals(y))) {
			return; // no change
		}
		update(n, y);
		notifyDependents(n);
	}

	@Override
	protected void update(int n) {
		update(n, compute(n));
	}
	
	protected void update(int n, Object x) {
		this.value = x;
	}

	protected abstract Object compute(int n);
	
}
