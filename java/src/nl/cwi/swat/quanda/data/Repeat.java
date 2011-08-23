package nl.cwi.swat.quanda.data;


public class Repeat extends Notifiable {
	
	private final Expression count;
	
	public Repeat(Expression count) {
		this.count = count;
	}

	@Override
	protected void update(int n) {
		readjust((Integer)count.getValue(n));
	}

	private void readjust(int size) {
		// TODO Auto-generated method stub
		
	}
	
	
}
