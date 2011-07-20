package nl.cwi.swat.quanda.model;

import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.util.Set;

import javax.swing.JComponent;
import javax.swing.JLabel;
import javax.swing.JPanel;
import javax.swing.JTextField;
import javax.swing.event.DocumentListener;
import javax.swing.event.UndoableEditListener;
import javax.swing.text.AbstractDocument;
import javax.swing.text.AttributeSet;
import javax.swing.text.BadLocationException;
import javax.swing.text.Document;
import javax.swing.text.Element;
import javax.swing.text.Position;
import javax.swing.text.Segment;
import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;

import org.mozilla.javascript.Context;
import org.mozilla.javascript.EcmaError;
import org.mozilla.javascript.Scriptable;

import nl.cwi.swat.quanda.eval.Env;

public class Question {
	private String id;
	private String label;
	private String condition;
	private String variable;
	private Set<Question> next;

	@XmlAttribute @XmlID
	public String getId() {
		return this.id;
	}
	
	public void setId(String id) {
		this.id = id;
	}
	
	@XmlAttribute
	public String getVariable() {
		return variable;
	}
	
	public void setVariable(String variable) {
		this.variable = variable;
	}
	
	@XmlElement
	public String getLabel() {
		return label;
	}

	public void setLabel(String label) {
		this.label = label;
	}
	
	@XmlElement 
	public String getCondition() {
		return condition;
	}
	
	public void setCondition(String condition) {
		this.condition = condition;
	}
	
	@XmlElement
	@XmlList
	@XmlIDREF
	public Set<Question> getNext() {
		return this.next;
	}
	
	public void setNext(Set<Question> next) {
		this.next = next;
	}
	
	
	@Override
	public String toString() {
		return getCondition() + " => " + getVariable() + ": " + getLabel(); 
	}
	
	/// NON JAXB METHODS
	
	public boolean isEnabled(Env env) {
		Context ctx = Context.enter();
		try {
			Scriptable scope = ctx.initStandardObjects();
			env.define(scope);
			try {
				Object result = ctx.evaluateString(scope, getCondition(), getId(), 1, null);
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
	
	
}
