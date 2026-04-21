import '../class/statusrequest.dart';

// handlingData(response){
//   if(response is StatusRequest){
//       return response;
//   }
//   else{
//     return StatusRequest.success ;
//   }
// }
handlingData(response) {
  if (response is StatusRequest) {
    return response;
  } else if (response['statusCode'] == 422) {
    return StatusRequest.failure;
  } else {
    return StatusRequest.success;
  }
}