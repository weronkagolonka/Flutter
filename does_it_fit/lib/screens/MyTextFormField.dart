import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextFormField extends TextFormField {

  MyTextFormField({
    Key key, 
    TextEditingController controller, 
    String initialValue, 
    FocusNode focusNode, 
    InputDecoration decoration: const InputDecoration(), 
    TextInputType keyboardType, 
    TextCapitalization textCapitalization: TextCapitalization.none, 
    TextInputAction textInputAction, 
    TextStyle style, 
    StrutStyle strutStyle, 
    TextDirection textDirection, 
    TextAlign textAlign: 
    TextAlign.start, 
    TextAlignVertical textAlignVertical, 
    bool autofocus: false, 
    bool readOnly: false, 
    ToolbarOptions toolbarOptions, 
    bool showCursor, 
    bool obscureText: false, 
    bool autocorrect: true, 
    bool enableSuggestions: true, 
    bool autovalidate: false, 
    bool maxLengthEnforced: true, 
    int maxLines: 1, 
    int minLines, 
    bool expands: false, 
    int maxLength, 
    ValueChanged<String> onChanged, 
    GestureTapCallback onTap, 
    VoidCallback onEditingComplete, 
    ValueChanged<String> onFieldSubmitted, 
    FormFieldSetter<String> onSaved, 
    FormFieldValidator<String> validator, 
    List<TextInputFormatter> inputFormatters, 
    bool enabled: true, 
    double cursorWidth: 2.0, 
    Radius cursorRadius, 
    Color cursorColor, 
    Brightness keyboardAppearance, 
    EdgeInsets scrollPadding: const EdgeInsets.all(20.0), 
    bool enableInteractiveSelection: true, 
    InputCounterWidgetBuilder buildCounter,
    VoidCallback setErrorText}) : super();

}
