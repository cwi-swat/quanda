package nl.cwi.swat.quanda.data;

public class Add extends Expression {

	public final Expression lhs, rhs;
	
	public Add(Expression lhs, Expression rhs) {
		this.lhs = lhs;
		this.rhs = rhs;
	}
	
	@Override
	protected Object compute(int n) {
		return ((Integer)lhs.getValue(n)) + ((Integer)rhs.getValue(n));
	}
	
	
	

}
