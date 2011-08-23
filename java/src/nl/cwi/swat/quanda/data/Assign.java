package nl.cwi.swat.quanda.data;

public class Assign extends Binding {
	private Expression exp;

	public Assign(String name, Expression exp) {
		super(name);
		this.exp = exp;
		exp.addDependent(this);
	}
	
	@Override
	protected Object compute(int n) {
		return exp.getValue(n);
	}

}
