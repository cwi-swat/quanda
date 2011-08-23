package nl.cwi.swat.quanda.data;


public class Repeat extends Flow {
	
	private final Expression count;
	
	public Repeat(Expression count) {
		this.count = count;
	}

	@Override
	protected void update(int n) {
		Object c = count.getValue(n);
		if (c != null) {
			readjust((Integer)c);
		}
	}

	private void readjust(int size) {
		// TODO Auto-generated method stub
		
	}
	
	
}
