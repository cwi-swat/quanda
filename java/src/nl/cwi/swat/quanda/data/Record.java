package nl.cwi.swat.quanda.data;

import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;


public class Record extends Expression {
	private Set<Variable> bindings;
	
	public Record() {
		this.bindings = new HashSet<Variable>();
	}
	
	public void addBinding(Variable v) {
		bindings.add(v);
		v.addDependent(this);
	}
	
	@Override
	protected Object compute(int n) {
		Map<String, Object> m = new HashMap<String, Object>();
		for (Variable var: bindings) {
			m.put(var.getName(), var.getValue(n));
		}
		return m;
	}
	
	
	
	
	
}
