package nl.cwi.swat.quanda.data;


public abstract class Expression extends Flow {
	private Object value;
	
	public Object getValue(int n) {
		notify(n);
		return getValue();
	}
	
	protected Object getValue() {
		return value;
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
