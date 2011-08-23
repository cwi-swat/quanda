package nl.cwi.swat.quanda.data;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;


public class Record extends Expression {
	private Set<Binding> bindings;
	
	public Record() {
		this.bindings = new HashSet<Binding>();
	}
	
	public void addBinding(Binding binding) {
		bindings.add(binding);
		binding.addDependent(this);
	}
	
	@Override
	protected Object compute(int n) {
		Map<String, Object> m = new HashMap<String, Object>();
		for (Binding binding: bindings) {
			m.put(binding.getName(), binding.getValue(n));
		}
		return m;
	}
	
	
	
	
	
}
