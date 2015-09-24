part of dartTest;


abstract class _Entry {
  bool get _passed;
  HtmlElement get _node;
}

abstract class _Ledger<T extends _Entry> implements _Entry {
  String _name;
  final List<T> _entries;

  _Ledger(this._name, this._entries);

  // Will return true if all entries have passed, and false otherwise.
  bool get _passed =>	_entries.fold(true, (value, T entry) => value && entry._passed );


  UListElement get _node {
    var node = new UListElement()
      ..style.marginLeft = '2em'
      ..style.paddingLeft = '0em';
    var title = new SpanElement()
      ..text = _name
      ..style.color = _passed ? 'LimeGreen' : 'red';
    node.append(title);
    for (T entry in _entries) {
      node.append(entry._node);
    }
    return node;
  }
}
