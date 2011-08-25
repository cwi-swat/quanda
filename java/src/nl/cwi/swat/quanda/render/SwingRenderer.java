package nl.cwi.swat.quanda.render;

import nl.cwi.swat.quanda.ast.Definer;
import nl.cwi.swat.quanda.ast.Group;
import nl.cwi.swat.quanda.ast.Repeat;
import nl.cwi.swat.quanda.state.Iter;
import nl.cwi.swat.quanda.state.Nest;
import nl.cwi.swat.quanda.state.State;
import nl.cwi.swat.quanda.state.Value;

public class SwingRenderer {

	
	// implements Visitor on State graph
	// renders controls based on question referenced in a state Node.
	
	public void render() {
		
	}
	
	// it should visit both the state tree and the layout tree in parallel.
	// if it encounters a list state, and a repeat, it recurses
	
	public void visitIter(Iter iter, Repeat repeat) {
		for (State s: iter.getChildren()) {
			s.accept(this, repeat.getArg());
		}
	}
	
	public void visitValue(Value value, Definer definer) {
	}
	
	public void visitNest(Nest nest, Group group) {
		int n = nest.getChildren().size();
		assert group.getRules().size() == n;
		
		for (int i = 0; i < n; i++) {
			nest.getChildren().get(i).accept(this, group.getRules().get(i));
		}
	}
	
}
