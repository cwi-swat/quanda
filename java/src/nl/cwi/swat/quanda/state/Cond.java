package nl.cwi.swat.quanda.state;

import nl.cwi.swat.quanda.eval.Env;

public class Cond extends State {

	public Cond(String exp, State state) {
		super(null);
	}

	@Override
	public boolean propagate(Env env) {
		if (eval(exp, env)) {
			propagate(env);
		}
		return false;
	}

	
}
