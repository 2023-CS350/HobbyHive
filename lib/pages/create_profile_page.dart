import 'package:hobby_hive/components/drop_down.dart';
import 'package:hobby_hive/components/icon_button.dart';
import 'package:hobby_hive/components/form_field_controller.dart';
import 'package:hobby_hive/theme.dart';
import 'package:hobby_hive/widgets.dart';
import 'package:hobby_hive/model.dart';
import 'package:flutter/material.dart';

class CreateProfilePageModel extends HobbyHiveModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for yourName widget.
  TextEditingController? yourNameController;
  String? Function(BuildContext, String?)? yourNameControllerValidator;
  // State field(s) for city widget.
  TextEditingController? cityController;
  String? Function(BuildContext, String?)? cityControllerValidator;
  // State field(s) for DropDown widget.
  String? dropDownValue;
  FormFieldController<String>? dropDownValueController;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {}

  void dispose() {
    yourNameController?.dispose();
    cityController?.dispose();
  }

  /// Additional helper methods are added here.
}

class CreateProfilePageWidget extends StatefulWidget {
  const CreateProfilePageWidget({Key? key}) : super(key: key);

  @override
  _CreateProfilePageWidgetState createState() =>
      _CreateProfilePageWidgetState();
}

class _CreateProfilePageWidgetState extends State<CreateProfilePageWidget> {
  late CreateProfilePageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => CreateProfilePageModel());

    _model.yourNameController ??= TextEditingController();
    _model.cityController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: HobbyHiveTheme.of(context).primary,
        automaticallyImplyLeading: false,
        leading: HobbyHiveIconButton(
          borderColor: Colors.transparent,
          borderRadius: 30.0,
          borderWidth: 1.0,
          buttonSize: 60.0,
          icon: Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
            size: 30.0,
          ),
          onPressed: () async {},
        ),
        title: Text(
          'Create your profile',
          style: HobbyHiveTheme.of(context).headlineMedium.override(
                fontFamily: 'Noto Sans',
                color: Colors.white,
                fontSize: 22.0,
              ),
        ),
        actions: [],
        centerTitle: true,
        elevation: 2.0,
      ),
      body: SafeArea(
        top: true,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(0.0, 40.0, 0.0, 16.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                      color: Color(0xFFDBE2E7),
                      shape: BoxShape.circle,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
              child: TextFormField(
                controller: _model.yourNameController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your Name',
                  labelStyle: HobbyHiveTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  hintStyle: HobbyHiveTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: HobbyHiveTheme.of(context).bodyMedium.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF101213),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                maxLines: null,
                validator:
                    _model.yourNameControllerValidator.asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
              child: TextFormField(
                controller: _model.cityController,
                obscureText: false,
                decoration: InputDecoration(
                  labelText: 'Your City',
                  labelStyle: HobbyHiveTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  hintStyle: HobbyHiveTheme.of(context).bodySmall.override(
                        fontFamily: 'Outfit',
                        color: Color(0xFF57636C),
                        fontSize: 14.0,
                        fontWeight: FontWeight.normal,
                      ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xFFF1F4F8),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0x00000000),
                      width: 2.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                      EdgeInsetsDirectional.fromSTEB(20.0, 24.0, 0.0, 24.0),
                ),
                style: HobbyHiveTheme.of(context).bodyMedium.override(
                      fontFamily: 'Outfit',
                      color: Color(0xFF101213),
                      fontSize: 14.0,
                      fontWeight: FontWeight.normal,
                    ),
                maxLines: null,
                validator: _model.cityControllerValidator.asValidator(context),
              ),
            ),
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 0.0, 20.0, 16.0),
              child: HobbyHiveDropDown<String>(
                controller: _model.dropDownValueController ??=
                    FormFieldController<String>(null),
                options: ['Option 1'],
                onChanged: (val) => setState(() => _model.dropDownValue = val),
                width: double.infinity,
                height: 50.0,
                searchHintTextStyle: HobbyHiveTheme.of(context).labelMedium,
                textStyle: HobbyHiveTheme.of(context).bodyMedium.override(
                      fontFamily: 'Outfit',
                      color: HobbyHiveTheme.of(context).secondaryText,
                    ),
                hintText: 'Your Interests',
                searchHintText: 'Search for an item...',
                icon: Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: HobbyHiveTheme.of(context).secondaryText,
                  size: 24.0,
                ),
                fillColor: HobbyHiveTheme.of(context).secondaryBackground,
                elevation: 2.0,
                borderColor: HobbyHiveTheme.of(context).primaryBackground,
                borderWidth: 2.0,
                borderRadius: 8.0,
                margin: EdgeInsetsDirectional.fromSTEB(16.0, 4.0, 16.0, 4.0),
                hidesUnderline: true,
                isSearchable: false,
              ),
            ),
            Align(
              alignment: AlignmentDirectional(0.0, 0.05),
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(0.0, 24.0, 0.0, 0.0),
                child: HobbyHiveButtonWidget(
                  onPressed: () {
                    print('Button pressed ...');
                  },
                  text: 'Save Changes',
                  options: HobbyHiveButtonOptions(
                    width: 270.0,
                    height: 50.0,
                    padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    iconPadding:
                        EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                    color: HobbyHiveTheme.of(context).primary,
                    textStyle: HobbyHiveTheme.of(context).titleMedium.override(
                          fontFamily: 'Outfit',
                          color: Colors.white,
                          fontSize: 18.0,
                          fontWeight: FontWeight.normal,
                        ),
                    elevation: 2.0,
                    borderSide: BorderSide(
                      color: Colors.transparent,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
