class ReceiptModel {
 final String Time;
 final int clientId;
 final String cost;
 final String distance;
 final String endRide;
 final String endTime;
 final String fee;
 final String Total;
 final int id;
 final String startRide;
 final String startTime;
 final dynamic late;

  ReceiptModel( {
   required this.Time, 
   required this.clientId,
   required this.distance,
   required this.endRide,
   required this.endTime,
   required this.id,
   required this.startTime, 
   required this.cost,
   required this.fee,
   required this.Total,
   required this.startRide,
   required this.late
   });

  
}
