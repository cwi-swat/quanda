package nl.cwi.swat.quanda.ast;

import java.util.List;

import javax.xml.bind.annotation.XmlType;

@XmlType
public class OneOf extends Widget {

	private List<Option> options;
	
	public List<Option> getOptions() {
		return options;
	}
	
	public void setOptions(List<Option> options) {
		this.options = options;
	}
}
