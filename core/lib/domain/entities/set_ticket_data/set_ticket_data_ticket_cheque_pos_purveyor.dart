import 'package:core/domain/entities/domain_object.dart';

final class SetTicketDataTicketChequePosPurveyorData extends DomainObject {
  
final String name;
final String taxId;
final String phone;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        name,
        taxId,
        phone,
      ];

  const SetTicketDataTicketChequePosPurveyorData({
      required this.name,
      required this.taxId,
      required this.phone,
  });

  @override
  SetTicketDataTicketChequePosPurveyorData copyWith() {
    return SetTicketDataTicketChequePosPurveyorData(
      name: name,
      taxId: taxId,
      phone: phone,
    );
  }
}