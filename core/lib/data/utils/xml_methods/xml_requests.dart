// ignore_for_file: lines_longer_than_80_chars

abstract final class XmlRequests {
  /// getBusStops( ) - Get all available bus stops, doesn't require any parameters
  static String getBusStops() {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:GetBusStops/>
        </soap:Body>
    </soap:Envelope>
  ''';
  }

  /// getDestinations - Get destinations for a selected stop.
  ///
  /// [departure] - can be taken from getBusStops.
  static String getDestinations({
    required String departure,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:GetDestinations>
            <sal:Substring></sal:Substring>
            <sal:Departure>$departure</sal:Departure>
          </sal:GetDestinations>
        </soap:Body>
    </soap:Envelope>
  ''';
  }

  /// getTrips( ) - Get all trips by the specified [departure], [destination], and [tripsDate].
  ///
  /// [departure] - Name or ID of the departure bus station, which can be obtained from getBusStops( ).
  /// [destination] - Name or ID of the destination bus station, which can be obtained from getBusStops( ).
  /// [tripsDate] - The date parameter must be in the {YYYY-MM-DD} format.
  static String getTrips({
    required String departure,
    required String destination,
    required String tripsDate,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:GetTrips>
            <sal:Departure>$departure</sal:Departure>
            <sal:Destination>$destination</sal:Destination>
            <sal:TripsDate>$tripsDate</sal:TripsDate>
          </sal:GetTrips>
        </soap:Body>
    </soap:Envelope>
  ''';
  }

  /// getTrip( ) - Get a specific trip by providing the [tripId] and [busStop].
  ///
  /// [tripId] - The ID of the specific trip, which can be obtained from getTrips( ).
  ///
  /// [busStop] - The name or ID of the departure bus station, which can be obtained from getTrips( ).
  static String getTrip({
    required String tripId,
    required String busStop,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:GetTrip>
            <sal:TripId>$tripId</sal:TripId>
            <sal:BusStop>$busStop</sal:BusStop>
          </sal:GetTrip>
        </soap:Body>
    </soap:Envelope>''';
  }

  /// getOccupiedSeats( ) - Get list of all occupied seats and their status.
  ///
  /// [tripId] - The ID of the specific trip, which can be obtained from [getTrips( ) , getTrip( )].
  ///
  /// [departure] - Name or ID of the departure bus station, which can be obtained from [getTrips( ) , getTrip( ) , getBusStops( )].
  ///
  /// [destination] - Name or ID of the destination bus station, which can be obtained from [getTrips( ) , getTrip( ) , getBusStops( )].
  static String getOccupiedSeats({
    required String tripId,
    required String departure,
    required String destination,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:GetOccupiedSeats>
            <sal:TripId>$tripId</sal:TripId>
            <sal:Departure>$departure</sal:Departure>
            <sal:Destination>$destination</sal:Destination>
            <sal:OrderId></sal:OrderId>
          </sal:GetOccupiedSeats>
        </soap:Body>
      </soap:Envelope>
  ''';
  }

  static String startSaleSession({
    required String tripId,
    required String departure,
    required String destination,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport">
      <soap:Header/>
        <soap:Body>
          <sal:StartSaleSession>
            <sal:TripId>$tripId</sal:TripId>
            <sal:Departure>$departure</sal:Departure>
            <sal:Destination>$destination</sal:Destination>
            <sal:OrderId></sal:OrderId>
          </sal:StartSaleSession>
        </soap:Body>
      </soap:Envelope>
  ''';
  }

  static String addTicket({
    required String orderId,
    required String fareName,
    required String seatNum,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport" xmlns:xdto="http://www.unistation.ru/xdto">
      <soap:Header/>
        <soap:Body>
          <sal:AddTickets>
            <sal:OrderId>$orderId</sal:OrderId>
              <sal:TicketSeats>
                <xdto:Elements>
                  <xdto:FareName>$fareName</xdto:FareName>
                  <xdto:SeatNum>$seatNum</xdto:SeatNum>
  
                  <xdto:Destination></xdto:Destination>
  
                  <xdto:TicketNumber></xdto:TicketNumber>
  
                  <xdto:ParentTicketSeatNum></xdto:ParentTicketSeatNum>
                </xdto:Elements>
              </sal:TicketSeats>
            </sal:AddTickets>
          </soap:Body>
        </soap:Envelope>
    ''';
  }

  static String payment({
    required String orderId,
    required String paymentType,
    required String amount,
    String? terminalId,
    String? terminalSessionId,
  }) {
    return '''
    <soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:sal="http://www.unistation.ru/saleport" xmlns:xdto="http://www.unistation.ru/xdto">
      <soap:Header/>
        <soap:Body>
          <sal:Payment>
            <sal:OrderId>$orderId</sal:OrderId>
            <sal:TerminalId>$terminalId</sal:TerminalId>
            <sal:TerminalSessionId>$terminalSessionId</sal:TerminalSessionId>
            <sal:PaymentItems>
              <xdto:Elements>
                <xdto:PaymentType>$paymentType</xdto:PaymentType>
                <xdto:Amount>$amount</xdto:Amount>
              </xdto:Elements>
            </sal:PaymentItems>
            <sal:ChequeSettings>
              <xdto:ChequeWidth>48</xdto:ChequeWidth>
            </sal:ChequeSettings>
          </sal:Payment>
        </soap:Body>
    </soap:Envelope>
  ''';
  }
}
