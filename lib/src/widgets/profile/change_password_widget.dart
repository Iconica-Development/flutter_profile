import 'package:flutter/material.dart';
import 'package:flutter_profile/flutter_profile.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({
    required this.config,
    required this.service,
    this.wrapViewOptions,
    this.wrapItemsBuilder,
    this.itemBuilder,
    this.itemBuilderOptions,
    this.style = const ProfileStyle(),
    super.key,
  });

  final ChangePasswordConfig config;
  final WrapViewOptions? wrapViewOptions;
  final ItemBuilder? itemBuilder;
  final ItemBuilderOptions? itemBuilderOptions;
  final Widget Function(BuildContext context, Widget child)? wrapItemsBuilder;
  final ProfileStyle style;
  final ProfileService service;

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  late var config = widget.config;

  late final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late final Widget? changePasswordChild;

  String? password1;
  String? password2;

  late var builder = widget.itemBuilder ??
      ItemBuilder(
        options: widget.itemBuilderOptions ?? ItemBuilderOptions(),
      );

  @override
  void initState() {
    super.initState();

    var changePasswordItems = Wrap(
      alignment: widget.wrapViewOptions?.wrapAlignment ?? WrapAlignment.start,
      direction: widget.wrapViewOptions?.direction ?? Axis.vertical,
      spacing: widget.wrapViewOptions?.spacing ?? 0,
      runSpacing: widget.wrapViewOptions?.runSpacing ?? 0,
      clipBehavior: widget.wrapViewOptions?.clipBehavior ?? Clip.none,
      children: [
        builder.buildPassword(
          'password_1',
          (value) => password1 = value,
          (value) {
            if (password1?.isEmpty ?? true) {
              return config.fieldRequiredErrorText;
            }

            return null;
          },
        ),
        builder.buildPassword(
          'password_2',
          (value) => password2 = value,
          (value) {
            if (password2?.isEmpty ?? true) {
              return config.fieldRequiredErrorText;
            }

            if (password2 != password1) {
              return config.notEqualErrorText;
            }

            return null;
          },
        ),
      ],
    );

    changePasswordChild =
        widget.wrapItemsBuilder?.call(context, changePasswordItems) ??
            changePasswordItems;
  }

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    void onTapSave() {
      if ((_formKey.currentState?.validate() ?? false) && password2 != null) {
        widget.service.changePassword(password2!);
      }
    }

    return Form(
      key: _formKey,
      child: Column(
        children: [
          SizedBox(
            height: widget.style.betweenDefaultItemPadding * 2.5,
          ),
          Text(
            config.title,
            style: config.titleStyle ?? theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          Text(
            config.underTitle,
            style: config.underTitleStyle ?? theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: widget.style.betweenDefaultItemPadding,
          ),
          changePasswordChild!,
          SizedBox(
            height: widget.style.betweenDefaultItemPadding * 2,
          ),
          config.saveButtonBuilder?.call(
                context,
                () => onTapSave(),
              ) ??
              FilledButton(
                onPressed: () => onTapSave(),
                child: const Text('Save password'),
              ),
          const Spacer(),
        ],
      ),
    );
  }
}
