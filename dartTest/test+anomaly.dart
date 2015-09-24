
part of dartTest;

class Test extends _Ledger<_Result>{

	static Test _currentTest;

	static void _addEntry(_Result result) => _currentTest._entries.add(result);


	Test(String name, Function testBody) : super(name, []){
		_currentTest = this;
		testBody();
	}

	/// Generates an HTML node that can be appended to the node of a ledger.
	UListElement get _node{
		var node = new UListElement()
			..style.marginLeft = '1em'
			..style.paddingLeft = '0em'
			..style.color = _passed? 'LimeGreen' : 'Red';
    // Generates and appends either a green checkmark or a red x.
		var bullet = new SpanElement()
			..style.fontFamily = 'Webdings'
			..text = _passed? 'a' : 'r';
		node.append(bullet);
		node.appendText(' '+_name);

    _entries.forEach( (result) => node.append(result._node) );

		return node;
	}
}

class _Result implements _Entry{
	bool get _passed => false;
	String _message = '';
	_Result(this._message);
  /// Generates an HTML node that can be appended to the node of a test.
	LIElement get _node{
		if(_message.isEmpty) return null;
		var node = new LIElement()
			..style.textIndent = '0em'
			..style.marginLeft = '2em'
			..style.color = 'red'
			..text = this._message;
		return node;
	}
}