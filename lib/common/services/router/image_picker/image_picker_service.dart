import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  late final ImagePicker picker;

  ImagePickerService() : picker = ImagePicker();

  Future pickImageFromGallery() async {
    return await picker.pickImage(source: ImageSource.gallery);
  }

  Future pickImageFromCamera() async {
    return await picker.pickImage(source: ImageSource.camera);
  }
}
