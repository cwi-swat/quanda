package nl.cwi.swat.quanda.state;

import nl.cwi.swat.quanda.eval.Env;
import nl.cwi.swat.quanda.model.Question;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.EcmaError;
import org.mozilla.javascript.Scriptable;

public class Value extends State {

	private Object value;
	private Widget widget;
	

	public Question getQuestion() {
		return question;
	}

	public Value(Question question) {
		super(question);
	}
	
	public Object getValue() {
		return value;
	}
	
	public boolean isEnabled(Env env) {
		Context ctx = Context.enter();
		try {
			Scriptable scope = ctx.initStandardObjects();
			env.define(scope);
			try {
				Object result = ctx.evaluateString(scope, getQuestion().getCondition(), getQuestion().toString(), 1, null);
				return result == null ? false : result.equals(true);
			}
			catch (EcmaError e) {
				return false;
			}
		}
		finally {
			Context.exit();
		}
	}

	@Override
	public boolean propagate(String variable, Object value) {
		if (eval(question.getCond))
		// TODO Auto-generated method stub
		return false;
	}
	
	
}
