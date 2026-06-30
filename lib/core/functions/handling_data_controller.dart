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
handlingData2(response) {
  if (response is StatusRequest) {
    return response;
  } else if (response is Map) { // أضفنا هذا الفحص
    if (response['status'] == true) {
      return StatusRequest.success;
    } else {
      // هنا المشكلة: أنت كنت تعيد success دائماً، غيرناها لـ failure
      return StatusRequest.failure;
    }
  } else {
    return StatusRequest.serverfailure;
  }
}