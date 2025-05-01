import 'dart:developer';
import 'dart:io';

import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseImage {
  static Future<String?> uploadImage(File? imageFile) async {
    try {
      final supabase = Supabase.instance.client;
      //    final bytes = await imageFile!.readAsBytes();
      final fileName = 'uploads/${DateTime.now().millisecondsSinceEpoch}.jpg';

      await supabase.storage.from('usersimages').upload(fileName, imageFile!);

      // Get the public URL of the uploaded file
      final imageUrl = supabase.storage
          .from('usersimages')
          .getPublicUrl(fileName);
      return imageUrl;
    } catch (e) {
      log('Error uploading image: $e');
      return null;
    }
  }
}
