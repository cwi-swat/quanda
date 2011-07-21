package nl.cwi.swat.quanda.ast;

import java.util.Set;

import javax.xml.bind.annotation.XmlAttribute;
import javax.xml.bind.annotation.XmlIDREF;
import javax.xml.bind.annotation.XmlList;
import javax.xml.bind.annotation.XmlType;

@XmlType
public class Output extends Stat implements User {
	private Widget widget;
	private String expression;
	
	private Set<Definer> dependencies;
	
	public Widget getWidget() {
		return widget;
	}
	public void setWidget(Widget widget) {
		this.widget = widget;
	}
	
	@XmlAttribute
	public String getExpression() {
		return expression;
	}
	public void setExpression(String expression) {
		this.expression = expression;
	}
	
	@XmlAttribute
	@XmlIDREF
	@XmlList
	@Override
	public Set<Definer> getDependencies() {
		return dependencies;
	}

	
}
