package nl.cwi.swat.quanda.data;

public class Add extends Expression {

	public final Expression lhs, rhs;
	
	public Add(Expression lhs, Expression rhs) {
		this.lhs = lhs;
		this.rhs = rhs;
	}
	
	@Override
	protected Object compute(int n) {
		Integer a = (Integer)lhs.getValue(n);
		Integer b = (Integer)rhs.getValue(n);
		if (a == null || b == null) {
			return null;
		}
		return a + b;
	}
	
	

}
