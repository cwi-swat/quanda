package nl.cwi.swat.quanda.model;

import java.util.Set;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlID;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;

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
	
	
	
}
