import 'package:core/data/mappers/base_mapper.dart';
import 'package:core/domain/entities/set_ticket_data/set_ticket_data_ticket_cheque_pos_purveyor.dart';

abstract final class _Fields {
  static const String name = 'Name';
  static const String taxId = 'TaxId';
  static const String phone = 'Phone';
}

final class SetTicketDataTicketChequePosPurveyorDataMapper
    implements BaseMapper<SetTicketDataTicketChequePosPurveyorData> {
  @override
  Map<String, dynamic> toJson(SetTicketDataTicketChequePosPurveyorData data) {
    return {
      _Fields.name: data.name,
      _Fields.taxId: data.taxId,
      _Fields.phone: data.phone,
    };
  }

  @override
  SetTicketDataTicketChequePosPurveyorData fromJson(Map<String, dynamic> json) {
    return SetTicketDataTicketChequePosPurveyorData(
      name: json[_Fields.name],
      taxId: json[_Fields.taxId],
      phone: json[_Fields.phone],
    );
  }
}