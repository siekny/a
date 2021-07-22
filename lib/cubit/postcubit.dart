import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:htb_mobile/data/models/post.dart';
import 'package:htb_mobile/services/postservice.dart';

class PostCubit extends Cubit<List<Post>> {
  final _service = PostService();

  PostCubit() : super([]);

  void getPosts() async => emit(await _service.getPosts());
}
