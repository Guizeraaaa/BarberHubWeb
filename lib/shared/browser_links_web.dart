import 'dart:js_interop';

@JS('window.open')
external JSAny? _open(JSString url, JSString target, JSString features);

bool openBrowserLink(Uri uri) {
  _open(uri.toString().toJS, '_blank'.toJS, 'noopener,noreferrer'.toJS);
  return true;
}
