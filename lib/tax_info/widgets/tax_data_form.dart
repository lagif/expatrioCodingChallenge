import 'package:coding_challenge/api/client/exceptions.dart';
import 'package:coding_challenge/api/model/tax_info.dart';
import 'package:coding_challenge/shared/countries_constants.dart';
import 'package:coding_challenge/shared/item_dropdown.dart';
import 'package:coding_challenge/shared/widgets/icon_title.dart';
import 'package:coding_challenge/shared/widgets/result_notification.dart';
import 'package:coding_challenge/tax_info/cubits/tax_info_cubit.dart';
import 'package:coding_challenge/tax_info/cubits/tax_info_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class TaxInfoForm extends StatefulWidget {
  const TaxInfoForm({super.key});

  @override
  State<TaxInfoForm> createState() => _TaxInfoFormState();
}

/// as well as the authorization form
/// this form also depends on the global tax data state
/// so I have put it to the stateful widget
///
class _TaxInfoFormState extends State<TaxInfoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TaxInfoCubit, TaxInfoState>(
        listener: (context, state) {},
        bloc: context.read<TaxInfoCubit>()..load(),
        builder: (context, state) => switch (state) {
              TaxInfoLoading() || TaxInfoInitial() => _loadingIndicator(),
              TaxInfoSuccess() => _TaxInfoSheet(info: state.taxInfo),
              TaxInfoError() => ResultNotification(
                  isSuccess: false,
                  title: "The error occurred",
                  message: (state.error is HttpErrorException)
                      ? state.error.errorMessage
                      : 'Try again!',
                  action: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('GOT IT'),
                  ),
                ),
            });
  }

  Widget _loadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(
        color: Color.fromRGBO(65, 171, 158, 1),
      ),
    );
  }
}

class _TaxInfoSheet extends StatefulWidget {
  final TaxInfo info;

  const _TaxInfoSheet({required this.info});

  @override
  State<_TaxInfoSheet> createState() => _TaxInfoSheetState();
}

class _TaxInfoSheetState extends State<_TaxInfoSheet> {
  final _formKey = GlobalKey<FormBuilderState>();
  List<TaxResidence> residences = [];

  @override
  void initState() {
    residences = [
      widget.info.primaryTaxResidence ?? TaxResidence(country: '', id: '')
    ];
    residences.addAll(widget.info.secondaryTaxResidence);
    super.initState();
  }

  ///
  /// some elements here, for example validators,
  /// can be extracted from this long piece of code
  ///
  @override
  Widget build(BuildContext context) {
    /// I know dropdown search looks much cooler,
    /// but I had a very limited time,
    /// so I used the standard dropdown for this FormBuilder
    ///
    List<ItemDropDown> countries = CountriesConstants.nationality
        .map((e) => ItemDropDown(e["code"], e["label"], e["label"]))
        .toList()
      ..sort((a, b) => a.value.compareTo(b.value));
    countries.add(const ItemDropDown('', '', ''));
    return Center(
      child: FormBuilder(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                "Declaration of financial information",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8.0),
              for (final (i, residency) in residences.indexed) ...{
                IconTitle(
                    icon: Icons.location_on_outlined,
                    iconSize: 20,
                    fontSize: 12,
                    title: i == 0
                        ? "WHICH COUNTRY SERVES AS YOUR PRIMARY TAX RESIDENCE?*"
                        : "DO YOU HAVE OTHER TAX RESIDENCE?*"),
                FormBuilderDropdown<ItemDropDown>(
                  name: 'country_$i',

                  ///items of the countries list, mapped to dropdown items,
                  ///whith disabling the countries that are already used
                  items: countries
                      .map(
                        (e) => DropdownMenuItem<ItemDropDown>(
                          value: e,
                          enabled: !residences
                              .map((residence) => residence.country)
                              .contains(e.key),
                          child: Text(e.value),
                        ),
                      )
                      .toList(),
                  initialValue: countries.firstWhere(
                      (element) => element.key == residency.country,
                      orElse: () => const ItemDropDown('', '', '')),
                  dropdownColor: Colors.white,
                  onChanged: (selectedItem) {
                    if (selectedItem != null) {
                      setState(() {
                        residences[i].country = selectedItem.key;
                      });
                    }
                  },
                  validator: FormBuilderValidators.compose([
                    FormBuilderValidators.required(),
                    (country) {
                      return (country?.value.isNotEmpty ?? false)
                          ? null
                          : "Please set the country";
                    },
                  ]),
                ),
                const SizedBox(height: 8.0),
                const IconTitle(
                  title: "TAX IDENTIFICATION NUMBER*",
                  fontSize: 12,
                ),
                FormBuilderTextField(
                    name: 'number_$i',
                    initialValue: residency.id,
                    validator: FormBuilderValidators.compose([
                      FormBuilderValidators.required(),
                    ]),
                    onChanged: (newValue) {
                      setState(() {
                        residences[i].id = newValue ?? '';
                      });
                    }),
                if (i != 0)
                  Row(
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            residences.removeAt(i);
                          });
                        },
                        child: const Text(
                          "- REMOVE",
                          style: TextStyle(
                            color: Colors.redAccent,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 16.0),
              },
              Row(
                children: [
                  TextButton(
                    onPressed: () {
                      setState(() {
                        residences.add(TaxResidence(country: '', id: ''));
                      });
                    },
                    child: const Text(
                      "+ ADD ANOTHER",
                      style: TextStyle(
                        color: Color.fromRGBO(65, 171, 158, 1),
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              FormBuilderCheckbox(
                name: "consent",
                title: const Text(
                  "I confirm above tax residency and US self-declaration is true and accurate",
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  maxLines: 2,
                ),
                validator: FormBuilderValidators.required(),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  _formKey.currentState?.save();
                  if (_formKey.currentState?.validate() ?? false) {
                    context.read<TaxInfoCubit>().setTaxInfo(_editedTaxInfo());
                    Navigator.pop(context);
                  }
                },
                child: const Text('SAVE'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TaxInfo _editedTaxInfo() {
    TaxInfo editedTaxInfo = TaxInfo(
        usPerson: widget.info.usPerson,
        usTaxId: widget.info.usTaxId,
        primaryTaxResidence: residences[0],
        secondaryTaxResidence: residences..removeAt(0));
    return editedTaxInfo;
  }
}
